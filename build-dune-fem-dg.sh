#!/bin/bash

if command -v module &> /dev/null
then
    echo "module command found - attempting to load modules"
    scripts_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
    source $scripts_path/lunarc-load-modules.sh
fi

# to venv or not to venv, that is the question?
USEVENV=1
#USEVENV=0

# gitlab repo with dune modules
URL=https://gitlab.maths.lu.se/dune/

WORKDIR="${PWD}"

if [ "$DUNE_CONTROL_PATH" != "" ]; then
  if [ "$WORKDIR" != "$DUNE_CONTROL_PATH" ]; then
    echo "DUNE_CONTROL_PATH is already set to $DUNE_CONTROL_PATH"
    exit 1
  fi
fi

# check for system installation
if test -f /usr/share/dune/cmake/modules/DuneMacros.cmake || test -f /usr/bin/dunecontrol ; then
  echo "DUNE system installation seems to exists, remove it first by running:"
  echo ""
  echo "sudo apt remove libdune*"
  echo "sudo apt autoremove"
  echo ""
  exit 1
fi


# create necessary python virtual environment
# this script assumes the name venv.
# Otherwise copy the instructions from the script
# to build you own

CMAKE_NOT_FOUND=`command -v cmake`

if [ "$CMAKE_NOT_FOUND" == "" ]; then
  CMAKEPIP=cmake
  echo "Installing cmake since no cmake was found!"
else
  CMAKE_VERSION=`cmake --version | head -1 | cut -d " " -f 3 | cut -d " " -f 1`
  REQUIRED_VERSION="3.13.3"
  # check if cmake version is ok
  if awk 'BEGIN {exit !('$CMAKE_VERSION' < '$REQUIRED_VERSION')}'; then
    CMAKEPIP=cmake
    echo "Installing cmake since current version is not new enough!"
  fi
fi

if [ "$USEVENV" == "1" ]; then
  # create necessary python virtual environment
  VENVDIR=$WORKDIR/venv
  if ! test -d $VENVDIR ; then
    python3 -m venv $VENVDIR
    source $VENVDIR/bin/activate
    pip install --upgrade pip
    pip install $CMAKEPIP fenics-ufl==2022.2.0 numpy matplotlib mpi4py
  else
    source $VENVDIR/bin/activate
  fi
fi

#change appropriately, i.e. 2.8 or leave empty which refers to master
DUNEVERSION=

FLAGS="-O3 -DNDEBUG"

DUNECOREMODULES="dune-common dune-istl dune-geometry dune-grid dune-localfunctions"
DUNEEXTMODULES="dune-alugrid dune-spgrid"
DUNEFEMMODULES="dune-fem dune-fem-dg"

# build flags for all DUNE modules
# change according to your needs
if test -f config.opts ; then
  read -p "Found config.opts. Overwrite with default? (y,n) " YN
  if [ "$YN" == "y" ] ;then
    echo "Overwriting config.opts!"
    rm -f config.opts
  fi
fi

if ! test -f config.opts ; then
echo "\
DUNEPATH=`pwd`
BUILDDIR=build-cmake
USE_CMAKE=yes
MAKE_FLAGS=-j4
CMAKE_FLAGS=\"-DCMAKE_CXX_FLAGS=\\\"$FLAGS\\\"  \\
 -DDISABLE_DOCUMENTATION=TRUE \\
 -DCMAKE_DISABLE_FIND_PACKAGE_Vc=TRUE \\
 -DCMAKE_DISABLE_FIND_PACKAGE_LATEX=TRUE\" " > config.opts
fi

ACTIVATE=activate.sh
if [ "$USEVENV" == "1" ]; then
  ACTIVATE="$VENVDIR/bin/activate"
else
  DEACTIVATEFUNCTION="deactivate() {
  echo \"\"
}
  "
fi

FOUND_MODULES_ACTIVATE=`grep "LUNARC_MODULES_ACTIVATION" $ACTIVATE`

if [ "$FOUND_MODULES_ACTIVATE" == "" ];
then
    if command -v module &> /dev/null
    then
        tmp_activate=$( mktemp $VENVDIR/bin/activate.XXXX )
        scripts_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
        echo "
## LUNARC_MODULES_ACTIVATION
source $scripts_path/lunarc-load-modules.sh
"       > $tmp_activate
        cat $ACTIVATE >> $tmp_activate
        mv $tmp_activate $ACTIVATE
    fi
fi

FOUND_DUNE_ACTIVATE=`grep "DUNE_VENV_SPECIFIC_SETUP" $ACTIVATE`

if [ "$FOUND_DUNE_ACTIVATE" == "" ]; then
echo "
## DUNE_VENV_SPECIFIC_SETUP

# setVariable( varname newvalue )
setVariable() {
  if [ -n \"\${!1}\" ]; then
    export _OLD_VIRTUAL_\${1}=\"\${!1}\"
  fi
  export \${1}=\"\${2}\"
}

# set current main working directory
setVariable DUNE_CONTROL_PATH \"$WORKDIR\"
setVariable DUNE_LOG_LEVEL \"info\"
setVariable DUNE_PY_DIR \${DUNE_CONTROL_PATH}/cache/

DUNEPYTHONPATH=
MODULES=\`\$DUNE_CONTROL_PATH/dune-common/bin/dunecontrol --print 2> /dev/null\`
for MOD in \$MODULES; do
  MODPATH=\"\$DUNE_CONTROL_PATH/\${MOD}/build-cmake/python\"
  MODFOUND=\`echo \$DUNEPYTHONPATH | grep \$MODPATH\`
  if [ \"\$MODFOUND\" == \"\" ]; then
    DUNEPYTHONPATH=\$DUNEPYTHONPATH:\$MODPATH
  fi
done

setVariable PYTHONPATH \$DUNEPYTHONPATH

echo \"DUNE_LOG_LEVEL=\$DUNE_LOG_LEVEL\"
echo \"Change with 'export DUNE_LOG_LEVEL={none,critical,info,debug}' if necessary!\"

# python \$DUNE_CONTROL_PATH/dune-common/bin/setup-dunepy.py
save_function() {
    local ORIG_FUNC=\$(declare -f \$1)
    local NEWNAME_FUNC=\"\$2\${ORIG_FUNC#\$1}\"
    eval \"\$NEWNAME_FUNC\"
}

restoreVariable() {
  VARNAME=_OLD_VIRTUAL_\$1
  if [ -n \"\${!VARNAME}\" ]; then
    export \${1}=\${!VARNAME}
    unset \${VARNAME}
  else
    unset \${1}
  fi
}

$DEACTIVATEFUNCTION

save_function deactivate venv_deactivate
deactivate() {
  restoreVariable DUNE_CONTROL_PATH
  restoreVariable DUNE_PY_DIR
  restoreVariable DUNE_LOG_LEVEL
  restoreVariable PYTHONPATH

  # call original deactivate
  venv_deactivate
  # self destroy
  unset venv_deactivate
  unset deactivate
}
" >> $ACTIVATE
fi

FOUND_PRECONDITIONER_SETUP=`grep "PRECONDITIONER_SPECIFIC_SETUP" $ACTIVATE`
if [ "$FOUND_PRECONDITIONER_SETUP" == "" ]; then
echo "
## PRECONDITIONER_SPECIFIC_SETUP
if [ -d \"$WORKDIR/dgsem-preconditioner\" ]; then
    export PYTHONPATH=\$PYTHONPATH:$WORKDIR/dgsem-preconditioner
fi
" >> $ACTIVATE
fi

DUNEBRANCH=

if [ "$DUNEVERSION" != "" ] ; then
  DUNEBRANCH="-b releases/$DUNEVERSION"
fi

# get all dune modules necessary
for MOD in $DUNECOREMODULES ; do
  git clone $DUNEBRANCH $URL/$MOD.git
done

# get all dune extension modules necessary
for MOD in $DUNEEXTMODULES ; do
  git clone $DUNEBRANCH $URL/$MOD.git
done

# get all dune extension modules necessary
for MOD in $DUNEFEMMODULES ; do
  git clone $DUNEBRANCH $URL/$MOD.git
done

# load environment variables
source $VENVDIR/bin/activate

# build all DUNE modules using dune-control
./dune-common/bin/dunecontrol --opts=config.opts all

echo "####################################################

Build finished (hopefully successful). Use

source $ACTIVATE

to activate the virtual environment!"
