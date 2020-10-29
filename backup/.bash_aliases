

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Kill all running containers.
alias dockerkillall='printf "\n>>> Stopping all containers\n\n" && docker kill $(docker ps -q) > /dev/null 2>&1'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q) > /dev/null 2>&1'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true) > /dev/null 2>&1'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'

# matlab
alias matlab='/Applications/MATLAB_R2019a.app/bin/matlab -nodesktop -nosplash'
