#!/bin/bash

#######################################################
# PRELIMINARY STUFF LIKE COLORS AND FUNCTIONS
#######################################################

DOTFILES="$(pwd)"
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
#COL_BLUE=$ESC_SEQ"34;01m"
#COL_MAGENTA=$ESC_SEQ"35;01m"
#COL_CYAN=$ESC_SEQ"36;01m"

ok()
{
    echo -e "${COL_GREEN[ok]}${COL_RESET}"
}

bot()
{
    echo -e "\n${COL_GREEN}\[._.]/${COL_RESET} - ${1}"
}

running()
{
    echo -en "${COL_YELLOW} ⇒ ${COL_RESET}${1} : "
}

action()
{
    echo -e "\n${COL_YELLOW}[action]:${COL_RESET}\n ⇒ ${1}..."
}

warn()
{
    echo -e "${COL_YELLOW}[warning]${COL_RESET} ${1}"
}

error()
{
    echo -e "${COL_RED}[error]${COL_RESET} ${1}"
    exit 1
}

confirm()
{
    read -r -p "${1:-${COL_RED}Are you sure? [y/N]${COL_RESET}} " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

#######################################################
# SETUP SHELL
#######################################################
setup_shell()
{
    true
}

#######################################################
# SETUP OPERATING SYSTEM
#######################################################
setup_os()
{
    SYSTEM="$(uname -a)"
    case "${SYSTEM}" in
        #"Darwin")   setup_macos;;
        #"Linux")    setup_linux;;
        *)          error "Not configured for this system.";;
    esac
}
#######################################################
# SETUP MACOS (IF WE'RE ON A MAC)
#######################################################

setup_macos()
{
        # install homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 

        # install things from the brewfile
        brew bundle

        # now install from the mackup
        ln -s "$DOTFILES/backup/.mackup.cfg" "$HOME/.mackup.cfg"
        mackup restore

    	running "Installing fzf"
    	"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
}

#######################################################
# SETUP LINUX (IF WE'RE NOT)
#######################################################
setup_linux()
{
    error "Not configured for linux yet :("
}

#######################################################
# ACTUAL EXECUTION BEGINS HERE
#######################################################
bot "Beginning installation of dotfiles!"
setup_shell
setup_os

exit 0
