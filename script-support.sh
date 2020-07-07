

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

  # Save existing file if present
  #[ ! -f ~/.$1 ] || mv ~/.$1 ~/.$1.$2
  #check_return_code "Error saving ~/.$1 to ~/.$1.$2"

  # Link to git repo file
  ln -s $3$1 ~/.$1
  check_return_code "Error installing $1 into ~/.$1"
}

