# ~/.bashrc: executed by bash(1) for non-login shells.
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
git_branch () { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'; }
HOST='\033[02;36m\]\h'; HOST=' '$HOST
TIME='\033[01;31m\]\t \033[01;32m\]'
LOCATION=' \033[01;34m\]`pwd | sed "s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1_\2#g"`'
BRANCH=' \033[00;33m\]$(git_branch)\[\033[00m\]\n\$ '
PS1=$TIME$USER$HOST$LOCATION$BRANCH
PS2='\[\033[01;36m\]>'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

#export PYTHONPATH=""
#export PYTHONPATH="$PYTHONPATH:$HOME/Documents/Thesis/droplet-collision/examples/"
#export PYTHONPATH="$PYTHONPATH:/home/user1/.DUNE/dune-common/build-cmake/python:/home/user1/.DUNE/dune-istl/build-cmake/python:/home/user1/.DUNE/dune-geometry/build-cmake/python:/home/user1/.DUNE/dune-grid/build-cmake/python:/home/user1/.DUNE/dune-localfunctions/build-cmake/python:/home/user1/.DUNE/dune-alugrid/build-cmake/python:/home/user1/.DUNE/dune-spgrid/build-cmake/python:/home/user1/.DUNE/dune-fem/build-cmake/python:/home/user1/.DUNE/dune-fem-dg/build-cmake/python"
#export PETSC_DIR=$HOME/tester/petsc3.19.5
#export PETSC_DIR="$HOME/programs/petsc_git/petsc/1"
#export PYTHONPATH="${PYTHONPATH}:$PETSC_DIR/lib"
export PATH="$PATH:$HOME/.openmpi/bin"
export PATH="$PATH:$HOME/paraview_build/bin"
export PATH="$PATH:/usr/local/MATLAB/R2024a/bin"

alias thc="cd $HOME/Documents/Thesis/droplet-collision"
alias daa="source $HOME/.venvs/dune_venv/bin/activate"
alias daa2="source $HOME/.DUNE/venv/bin/activate"
alias comp="python3 $HOME/.config/Other/compile_bib.py"
alias za="devour zathura"
alias vlc="devour vlc" 
alias gv="devour gwenview"
alias para="devour paraview"
alias ssn="sudo shutdown now" 
alias ins="yay -S"
alias mixer="alsamixer"
alias q="exit"
alias tor="$HOME/programs/tor-browser/start-tor-browser.desktop"

ls --color=al > /dev/null 2>&1 && alias ls='ls -F --color=al' || alias ls='ls -G'
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

