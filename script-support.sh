#!/bin/bash

# Usage:  call this after a shell command if you want to make sure it succeeded, and exit with a message if it failed

# grep $user2install /etc/passwd >/dev/null
# check_return_code "Missing user: $user2install"
check_return_code() {
    if [ $? -ne 0 ]; then
	exit_with_message "$1"
    fi
}

# Usage: Call this when you want to print a message and exit:

#if [ ! -d $installDir ]; then
#    exit_with_message "$installDir does not appear to be mounted on this system"
#fi

exit_with_message() {
    printf "EXITING  Error message is:   %s\n" "$1"
    exit 1
}

# Usage: install_file(filename,timestamp,script_dir)

install_dotfile() {
  # $1 -> file string
  # $2 -> CURRENT_TIMESTAMP
  # $3 -> SCRIPT_DIR (git repo)
  
  # Debug
  printf "LINKING FILE: $1 at ~/.$1\n"

  # Install requested file
  # If there's no file (or link), link the one we want
  # -f returns true if the file exists or if the link exists
  if [ ! -f ~/.$1 ]; then
    printf "NO $1 FILE PRESENT. CREATING LINK.\n"
    ln -s $3$1 ~/.$1
    check_return_code "Error linking $1 into ~/.$1"
  # Otherwise if there is a file and it's not a link,
  # then save the file off and link in the one we want
  elif [ -f ~/.$1 ] && [ ! -L ~/.$1 ]; then
    printf "$1 PRESENT BUT NO LINK. SAVING AND CREATING LINK.\n"
    mv ~/.$1 ~/.$1.$2
    check_return_code "Error saving ~/.$1 to ~/.$1.$2"
    ln -s $3$1 ~/.$1
    check_return_code "Error linking $1 into ~/.$1"
  # If the link is present, just let the user know
  elif [ -f ~/.$1 ] && [ -L ~/.$1 ]; then
    printf "LINK for ~/.$1 PRESENT.\n"
  else
    printf "EDGE CASE.\n"
    exit_with_message "UNSURE WHAT TO DO WITH $1"
  fi

}

