# shellcheck shell=bash
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

###
# some colorized echo helpers
# @author Adam Eivy
###

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
# COL_BLUE=$ESC_SEQ"34;01m"
# COL_MAGENTA=$ESC_SEQ"35;01m"
# COL_CYAN=$ESC_SEQ"36;01m"

function ok() {
    echo -e "${COL_GREEN[ok]}${COL_RESET} ${1}"
}

function bot() {
    echo -e "\n${COL_GREEN}\[._.]/${COL_RESET} - ${1}"
}

function running() {
    echo -en "${COL_YELLOW} ⇒ ${COL_RESET}${1} : "
}

function action() {
    echo -e "\n${COL_YELLOW}[action]:${COL_RESET}\n ⇒ ${1}..."
}

function warn() {
    echo -e "${COL_YELLOW}[warning]${COL_RESET} ${1}"
}

function error() {
    echo -e "${COL_RED}[error]${COL_RESET} ${1}"
}

# source things
__SOURCES=(
    "$HOME/.path"
    "$HOME/.env"
    "$HOME/.alias"
    "$HOME/.functions"
    "/usr/local/etc/profile.d/z.sh"
)
for f in "${__SOURCES[@]}"; do
    if [ -f "$f" ]; then
        # shellcheck disable=1090
        source "$f";
    else
        error "File $f not found! Rerun dotfiles install."
    fi
done

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# matlab
alias matlab='/Applications/MATLAB_R2019a.app/bin/matlab -nodesktop -nosplash'

# silence Catalina shell warning
export BASH_SILENCE_DEPRECATION_WARNING=1

export EDITOR="nvim"


# don't repeat duplicate lines or lines starting with spaces in the history
HISTCONTROL=ignoreboth

# append to the history file instead of overwriting
shopt -s histappend

# make the history file longer
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size and update as necessary
shopt -s checkwinsize

# make less friendlier
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

unset color_prompt force_color_prompt

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced


# navi cheatsheet generator thingy
eval "$(navi widget bash)"

# shellcheck disable=SC1091
# shellcheck source=/Users/petewilcox/.echos
eval 
            function fuck () {
                TF_PYTHONIOENCODING=$PYTHONIOENCODING;
                export TF_SHELL=bash;
                export TF_ALIAS=fuck;
                TF_SHELL_ALIASES=$(alias);
                export TF_SHELL_ALIASES;
                TF_HISTORY=$(fc -ln -10);
                export TF_HISTORY;
                export PYTHONIOENCODING=utf-8;
                TF_CMD=$(
                    thefuck THEFUCK_ARGUMENT_PLACEHOLDER "$@"
                ) && eval "$TF_CMD";
                unset TF_HISTORY;
                export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
                history -s "$TF_CMD";
            }

# shellcheck disable=SC1090
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
eval "$(starship init bash)"
eval "$(zoxide init bash)"
