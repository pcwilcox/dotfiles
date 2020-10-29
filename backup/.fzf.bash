# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/petewilcox/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/petewilcox/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/petewilcox/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/petewilcox/.fzf/shell/key-bindings.bash"
