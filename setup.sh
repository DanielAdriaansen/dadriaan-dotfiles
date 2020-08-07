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
my_files=("bashrc " "bash_profile" "bash_functions" "bash_aliases" "vimrc" "condarc" "tmux.conf" "condainit")

# Install desired files using symlinks to the git repo
# git repo location is stored as ${SCRIPT_DIR}
for f in ${my_files[@]}; do
  install_dotfile ${f} ${CURRENT_TIMESTAMP} ${SCRIPT_DIR}
done

# Make a git config directory if there isn't one
if [ ! -d ~/.config/git ]; then
  printf "MAKING GIT CONFIG DIRECTORY.\n"
  mkdir -p ~/.config/git
fi
# Install git config file
printf "INSTALLING ~/.config/git/config\n"
# If there's no git/config file (or link), link in the one we want
# -f returns true if the config file exists or if the link exists
if [ ! -f ~/.config/git/config ]; then
  printf "NO GIT CONFIG FILE PRESENT. CREATING LINK.\n"
  ln -s ${SCRIPT_DIR}gitconfig ~/.config/git/config
  check_return_code "Error linking ${SCRIPT_DIR}gitconfig into ~/.config/git/config"
# Otherwise if there is a file and it's not a link,
# then save the file off and link the one we want
elif [ -f ~/.config/git/config ]; then
  printf "GIT CONFIG FILE PRESENT BUT NO LINK. SAVING AND CREATING LINK.\n"
  mv ~/.config/git/config ~/.config/git/config.${CURRENT_TIMESTAMP}
  check_return_code "Error saving ~/.config/git/config to ~/.config/git/config.${CURRENT_TIMESTAMP}"
  ln -s ${SCRIPT_DIR}gitconfig ~/.config/git/config
  check_return_code "Error linking ${SCRIPT_DIR}gitconfig to ~/.config/git/config"
# If the link is present, just let the user know
elif [ -f ~/.config/git/config ]; then
  printf "LINK for ~/.config/git/config PRESENT.\n"
else
  printf "EDGE CASE.\n"
  exit_with_message "UNSURE WHAT TO DO WITH gitconfig"
fi

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
# Otherwise if there is a file present and it's not a link,
# then save the file off and link in what we want
elif [ -f ~/.vim ] && [ ! -L ~/.vim ]; then
  printf "$1 PRESENT (FILE) BUT NO LINK. SAVING AND CREATING LINK.\n"
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

printf "INSTALLING FILE: ~/.ssh/authorized_keys\n"
# Install authorized keys file
# If there's no keys file (or link), install the one we want
# -f returns true if the keys file exists or if the link exists
if [ ! -f ~/.ssh/authorized_keys ]; then
  printf "NO AUTHORIZED KEYS PRESENT. COPYING FILE.\n"
  #ln -s ${SCRIPT_DIR}authorized_keys ~/.ssh/authorized_keys
  cp ${SCRIPT_DIR}authorized_keys ~/.ssh/authorized_keys
  check_return_code "Error installing ${SCRIPT_DIR}authorized_keys into ~/.ssh/authorized_keys"
# Otherwise if there is a file and it's not a link,
# then save the file off and copy in the one we want
elif [ -f ~/.ssh/authorized_keys ] && [ ! -L ~/.ssh/authorized_keys ]; then
  printf "KEYS FILE PRESENT BUT NO LINK. SAVING AND COPYING FILE.\n"
  mv ~/.ssh/authorized_keys ~/.ssh/authorized_keys.${CURRENT_TIMESTAMP}
  check_return_code "Error saving ~/.ssh/authorized_keys to ~/.ssh/authorized_keys.${CURRENT_TIMESTAMP}"
  #ln -s ${SCRIPT_DIR}authorized_keys ~/.ssh/authorized_keys
  cp ${SCRIPT_DIR}authorized_keys ~/.ssh/authorized_keys
  check_return_code "Error installing ${SCRIPT_DIR}authorized_keys into ~/.ssh/authorized_keys"
else
  printf "EDGE CASE.\n"
  exit_with_message "UNSURE WHAT TO DO WITH authorized_keys"
fi

printf "\nSetup of ${HOME} completed successfully\n"

printf "\nTo use your new environment, run:\n"
printf ". ~/.bashrc\n"
