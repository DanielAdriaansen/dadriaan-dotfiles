#!/bin/bash

printf "Setting up ${HOME} environment\n"

# find location of this running script
# this is where the GitHub repository was cloned to
SCRIPT_DIR=$([[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}") # https://stackoverflow.com/a/3572105/11573886

# include utility functions
. ${SCRIPT_DIR}/script-support.sh

# Set current time
CURRENT_TIMESTAMP=$(date +%F_%T)

# List of desired files
my_files=("bashrc " "bash_profile" "bash_functions" "bash_aliases" "vimrc" "condarc" "tmux.conf")

# Install desired files using symlinks to the git repo
# git repo location is stored as ${SCRIPT_DIR}
for f in ${my_files[@]}; do
  install_dotfile ${f} ${CURRENT_TIMESTAMP} ${SCRIPT_DIR}
done

# Install vim directory
[ ! -d ~/.vim ] || mv ~/.vim ~/.vim.${CURRENT_TIMESTAMP}
check_return_code "Error saving ~/.vim to ~/.vim.${CURRENT_TIMESTAMP}"
ln -s ${SCRIPT_DIR}vim ~/.vim

# Install authorized keys file
[ ! -f ~/.ssh/authorized_keys ] || mv ~/.ssh/authorized_keys ~/.ssh/authorized_keys.${CURRENT_TIMESTAMP}
check_return_code "Error saving ~/.ssh/authorized_keys to ~/.ssh/authorized_keys.${CURRENT_TIMESTAMP}"
ln -s ${SCRIPT_DIR}authorized_keys ~/.ssh/authorized_keys

printf "\nSetup of ${HOME} completed successfully\n"

printf "\nTo use your new environment, run:\n"
printf ". ~/.bashrc\n"
