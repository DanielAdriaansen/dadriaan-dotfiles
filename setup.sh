#!/bin/bash

printf "Setting up ${HOME} environment\n"

# find location of this running script
SCRIPT_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0))  # https://stackoverflow.com/a/34208365/

# include utility functions
. ${SCRIPT_DIR}/script-support.sh

# Set current time
CURRENT_TIMESTAMP=$(date +%F_%T)

# List of desired files
my_files=("bashrc " "bash_profile" "bash_functions" "bash_aliases" "vimrc" "condarc" "vim")

# Install desired files using symlinks to the git repo
# git repo location is stored as ${SCRIPT_DIR}
for f in ${my_files[@]}; do
  install_dotfile ${f} ${CURRENT_TIMESTAMP} ${SCRIPT_DIR}
done

printf "\nSetup of ${HOME} completed succesfully\n"

printf "\nTo use your new environment, run:\n"
printf ". ~/.bashrc\n"
