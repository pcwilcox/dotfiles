
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

if [ -f ~/.bashrc ]; then source ~/.bashrc; fi  # source bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
