# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"



#Path to PETSc
export PETSC_DIR=/home/user1/tester/petsc3.19.5

export PYTHONPATH=/usr/bin/python3.12

#export PYTHONPATH="${PYTHONPATH}:/home/user1/Downloads/petsc_new/lib"
#export PETSC_DIR=/home/user1/Downloads/petsc_new
export PYTHONPATH="${PYTHONPATH}:$PETSC_DIR/lib"
export PYTHONPATH="${PYTHONPATH}:/home/user1/Documents/Thesis/droplet-collision/examples"

export PATH="$PATH:$HOME/.openmpi/bin"

#PATH ="$PATH:home/user1/paraview_build"
export LD_LIBRARY_PATH=:
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/user1/.openmpi/lib/"

export PATH=$PATH:/usr/local/MATLAB/R2023b/bin



#export DUNE_SAVE_BUILD=console 
#export DUNE_LOG_LEVEL=info

#Theme for omz
ZSH_THEME="agnoster"
#configs
#sensativity

ENABLE_CORRECTION="true"
HIST_STAMPS="mm/dd/yyyy"

#update
zstyle ':omz:update' mode disabled  # disable automatic updates

source $ZSH/oh-my-zsh.sh

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
alias ml="matlab"
alias za="zathura"
alias q="exit"
alias cl="clear"
alias lsh="ls -a"
alias daa="source $HOME/Documents/Thesis/droplet-collision/venv/bin/activate"
alias thc="cd /home/user1/Documents/Thesis/droplet-collision"
alias thd="cd /home/user1/Documents/Thesis"
alias rmtu="rm *.vtu"
alias mdir="cd /home/user1/Documents/MATLAB"
alias sc="source" 
alias i3c="vim $HOME/.config/i3/config"
alias v="vim"
alias ssn="sudo shutdown now"
#plugin paths

source $HOME/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
