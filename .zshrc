# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"



#Path to PETSc
#export PETSC_DIR=/home/user1/tester/petsc3.19.5
export PETSC_DIR=$HOME/petsc_git/petsc_install

export PYTHONPATH=/usr/bin/python3.12

#export PYTHONPATH="${PYTHONPATH}:/home/user1/Downloads/petsc_new/lib"
#export PETSC_DIR=/home/user1/Downloads/petsc_new
export PYTHONPATH="${PYTHONPATH}:$PETSC_DIR/lib"
export PYTHONPATH="${PYTHONPATH}:/home/user1/Documents/Thesis/droplet-collision/examples"

export PATH="$PATH:$HOME/.openmpi/bin"
export PATH="$PATH:$HOME/paraview_build/bin"
export LD_LIBRARY_PATH=:
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/user1/.openmpi/lib/"

export PATH="$PATH:/usr/local/MATLAB/R2024a/bin"


DISABLE_UNTRACK_FILES_DIRTY="true"

#export DUNE_SAVE_BUILD=console 
#export DUNE_LOG_LEVEL=info

#Theme for omz
#ZSH_THEME="agnoster"
ZSH_THEME="steeef"
#configs
#sensativity

ENABLE_CORRECTION="true"
HIST_STAMPS="mm/dd/yyyy"

#update
zstyle ':omz:update' mode disabled  # disable automatic updates

source $ZSH/oh-my-zsh.sh

HISTSIZE=1000
SAVEHIST=1000
# User configuration

export MANPATH="/usr/local/man:$MANPATH"

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi

plugins=(
	z 
	zsh-syntax-highlighting 
	sudo
	zsh-autosuggestions
)

#Some aliases 
alias py3="python3"
alias paraw= "$HOME/paraview_build/bin/paraview"
alias cab="source anaconda3/bin/activate"
alias ins="sudo apt-get install "
alias matlab="devour matlab"
alias za="devour zathura"
alias vlc="devour vlc"
alias paraview="devour paraview"
alias q="exit"
alias cl="clear"
alias lsh="ls -a"
alias daa="source $HOME/Documents/Thesis/droplet-collision/venv/bin/activate"
alias thc="cd $HOME/Documents/Thesis/droplet-collision"
alias thd="cd $HOME/Documents/Thesis"
alias rmtu="rm *.vtu"
alias mdir="cd /home/user1/Documents/MATLAB"
alias sc="source" 
alias i3c="vim $HOME/.config/i3/config"
alias v="vim"
alias ssn="sudo shutdown now"
alias tt="taskwarrior-tui"
alias comp="python3 $HOME/.config/Other/compile_bib.py"
#plugin paths

source $HOME/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
