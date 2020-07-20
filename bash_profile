#
# Header taken from file on Debain RAL (stretch) system:
# /usr/share/doc/adduser/examples/adduser.local.conf.examples/skel/dot.bash_profile
#
# This script file is sourced by bash(1) for login shells.
#
# When a login shell starts, the following script files are sourced, in
# this order:
#
#   /etc/profile          - run by bash(1)
#   /etc/profile.d/*.sh   - additional profile scripts
#   /etc/bash.bashrc      - sourced by /etc/profile file (only for bash(1))
#   $HOME/.bash_profile   - this file
#   $HOME/.bashrc         - sourced by this file (if unchanged)
#
# When a normal (non-login) bash(1) shell starts, the following files are
# sourced:
#
#   /etc/bash.bashrc      - run by bash(1)
#   $HOME/.bashrc         - run by bash(1)
#
# Written by John Zaitseff and released into the public domain.

########## SET UP ENVIRONMENT VARS

#========= CVS stuff
export CVSROOT=:pserver:dadriaan@cvs.rap.ucar.edu:/cvs

#========= PATH stuff
export PATH=/rap/bin:/usr/local/anaconda3/bin${PATH:+:$PATH}

#========= PYTHON stuff
export PYTHONPATH=${PYTHONPATH:+$PYTHONPATH:}${HOME}/git/ConfigMaster
export CONDA_INSTALL=~/anaconda

#========= NCL stuff
#export NCARG_COLORMAPS
#export NCARG_ROOT
#export NCARG_LIB

#========= NETCDF stuff
export NETCDF=/usr/local/netcdf

#========= DS stuff
export DS_COMM_TIMEOUT_MSECS=100000

#========= MAKE stuff
export HOST_OS=LINUX_CX11
export GCC_WARNINGS=-Wall
#export LD_LIBRARY_PATH=/usr/local/gcc/lib:/usr/local/netcdf/lib

export RALCVS=${HOME}/cvs
export INSTALL=${HOME}/exec

export RAP_MAKE_INC_DIR=${RALCVS}/make_include
export RAP_MAKE_BIN_DIR=${RALCVS}/make_bin

#--------- Look at these first
export RAP_INC_DIR=${INSTALL}/include
export RAP_LIB_DIR=${INSTALL}/lib
export RAP_BIN_DIR=${INSTALL}/bin

#--------- Then look at these
export RAP_SHARED_INC_DIR=/rap/include
export RAP_SHARED_LIB_DIR=/rap/lib
export RAP_SHARED_BIN_DIR=/rap/bin

########## LOAD IN OTHER SETTINGS

if [ -f "${HOME}/.bashrc" ]; then
     . "${HOME}/.bashrc"
fi
