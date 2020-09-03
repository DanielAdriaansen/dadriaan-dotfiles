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
