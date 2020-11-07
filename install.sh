#!/bin/bash

DOTFILES="$(pwd)"

. notices


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
    if [[ "${SYSTEM}" =~ "Darwin" ]]; then
	    setup_macos
	elif [[ "${SYSTEM}" =~ "Linux" ]]; then
	    setup_linux
    else
        *          error "Not configured for this system."
    fi
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
	# install things from apt
	apt_install.sh

	# install things which aren't in apt
	not_apt_install.sh

	# symlink things
	for f in $(pwd)/symlinks/*; do
		ln -s $f ~/"$(basename $f)"
	done
}

#######################################################
# SETUP SYMLINKS
#######################################################
setup_symlinks()
{
    for f in bin/*; do
        ln -s "$f" "$HOME/.bin/$(basename $f)"
    done
}
#######################################################
# ACTUAL EXECUTION BEGINS HERE
#######################################################
bot "Beginning installation of dotfiles!"
setup_shell
setup_os
setup_symlinks

exit 0
