# dan_cvs()
function dan_cvs () { command cvs -d :pserver:dadriaan@cvs.rap.ucar.edu:/cvs "$@";  }

# dcvs()
function dcvs () { command cvs -d :pserver:dadriaan@cvs.rap.ucar.edu:/cvs "$@";  }

# cvs_autocomplete()
function cvs_autocomplete { complete -o default -F _cvs cvs "$@"; }

# function for setting git branch
function setbranch () { export GIT_BRANCH=`git rev-parse --abbrev-ref HEAD` "$@"; }

# function for setting git repository name
function setrepo () { export REPONAME=`basename \`git rev-parse --show-toplevel\`` "$@"; }

# function for cloning a repo
function clone () { git clone git@github.com:"$@"; }

# Usage: helper functions to smartly add to path
# Example: PATH=$(path_append $PATH /my/bin)

path_append() {
    if [ -d "$2" ] && [[ ":$1:" != *":$2:"* ]]; then
        echo "${1:+"$1:"}$2"
    else
        echo "$1"
    fi
}

path_prepend() {
    if [ -d "$2" ] && [[ ":$1:" != *":$2:"* ]]; then
        echo "$2${1:+":$1"}"
    else
        echo "$1"
    fi
}
