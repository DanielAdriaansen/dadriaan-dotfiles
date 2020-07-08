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
my_files=("bashrc " "bash_profile" "bash_functions" "bash_aliases" "vimrc" "condarc" "tmux.conf" "conda")

# Install desired files using symlinks to the git repo
# git repo location is stored as ${SCRIPT_DIR}
for f in ${my_files[@]}; do
  install_dotfile ${f} ${CURRENT_TIMESTAMP} ${SCRIPT_DIR}
done

# Install vim directory
printf "LINKING DIR: ~/.vim\n"
# If there's no vim directory (or link), link in the one we want
# -d returns true if .vim is a directory or if the link exists
if [ ! -d ~/.vim ]; then
  printf "NO DIRECTORY OR LINK PRESENT. CREATING LINK.\n"
  ln -s ${SCRIPT_DIR}vim ~/.vim
  check_return_code "Error linking ${SCRIPT_DIR}vim into ~/.vim"
# Otherwise if there is a directory and it's not a link,
# then save the directory off and link in the one we want
elif [ -d ~/.vim ] && [ ! -L ~/.vim ]; then
  printf "DIRECTORY PRESENT BUT NO LINK. SAVING AND CREATING LINK.\n"
  mv ~/.vim ~/.vim.${CURRENT_TIMESTAMP}
  check_return_code "Error saving ~/.vim to ~/.vim.${CURRENT_TIMESTAMP}"
  ln -s ${SCRIPT_DIR}vim ~/.vim
  check_return_code "Error linking ${SCRIPT_DIR}vim into ~/.vim"
# If the link is present, just let the user know
elif [ -d ~/.vim ] && [ -L ~/.vim ]; then
  printf "LINK for ~/.vim PRESENT.\n"
else  
  printf "EDGE CASE.\n"
  exit_with_message "UNSURE WHAT TO DO WITH vim"
fi

printf "LINKING FILE: ~/.ssh/authorized_keys\n"
# Install authorized keys file
# If there's no keys file (or link), link the one we want
# -f returns true if the keys file exists or if the link exists
if [ ! -f ~/.ssh/authorized_keys ]; then
  printf "NO AUTHORIZED KEYS PRESENT. CREATING LINK.\n"
  ln -s ${SCRIPT_DIR}authorized_keys ~/.ssh/authorized_keys
  check_return_code "Error linking ${SCRIPT_DIR}authorized_keys into ~/.ssh/authorized_keys"
# Otherwise if there is a file and it's not a link,
# then save the file off and link in the one we want
elif [ -f ~/.ssh/authorized_keys ] && [ ! -L ~/.ssh/authorized_keys ]; then
  printf "KEYS FILE PRESENT BUT NO LINK. SAVING AND CREATING LINK.\n"
  mv ~/.ssh/authorized_keys ~/.ssh/authorized_keys.${CURRENT_TIMESTAMP}
  check_return_code "Error saving ~/.ssh/authorized_keys to ~/.ssh/authorized_keys.${CURRENT_TIMESTAMP}"
  ln -s ${SCRIPT_DIR}authorized_keys ~/.ssh/authorized_keys
  check_return_code "Error linking ${SCRIPT_DIR}authorized_keys into ~/.ssh/authorized_keys"
# If the link is present, just let the user know
elif [ -f ~/.ssh/authorized_keys ] && [ -L ~/.ssh/authorized_keys ]; then
  printf "LINK for ~/.ssh/authorized_keys PRESENT.\n"
else
  printf "EDGE CASE.\n"
  exit_with_message "UNSURE WHAT TO DO WITH authorized_keys"
fi

printf "\nSetup of ${HOME} completed successfully\n"

printf "\nTo use your new environment, run:\n"
printf ". ~/.bashrc\n"
