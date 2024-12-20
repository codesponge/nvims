#!/bin/bash
_version="0.1.0"
#default values
nvims_dirname='nvims'  #default setups directory name
nvims_dirpath="$HOME/.config/$nvims_dirname"
default=false
usage() {
cat <<EOF
Usage: nvims [setup_name]

When no argument is provided, nvims will let you choose a setup
from the available setups in $nvims_dirpath directory.

NVIMS
nvims switches between different Neovim configurations
located in ~/.config/$nvims_dirname/ directory.
for clarity, we call each configuration a 'setup'.
Any directory in ~/.config/$nvims_dirname/ containing
an init.lua file is considered a setup.

EOF
}

# generate a list of avail`able setups by checking
# directories in nvims_dirpath containing init.lua file
# and add the directory name to the array
setups=() # array to store available setups
for setup in $nvims_dirpath/*; do
    if [ -f "$setup/init.lua" ]; then
        setup_name=$(basename "$setup")
        setups+=("$setup_name")
    fi
done
list_setups() {
    echo "Available setups:"
    for setup in "${setups[@]}"; do
        echo "  $setup"
    done
}
# if there are no setups, print an error message and exit
if [ ! -d "$nvims_dirpath" ]; then
    echo "Directory $nvims_dirpath does not exist."
    echo "To use nvims, create the directory and add setups to it."
    exit 1
fi

if [ ${#setups[@]} -eq 0 ]; then
    echo "No setups found in $nvims_dirpath."
    exit 1
fi

# if no argument is provided, let user choose a setup using select if fzf is not installed
if [ -z "$1" ]; then
    if command -v fzf &> /dev/null; then
        setup_name=$(printf "%s\n" "${setups[@]}" | \
        fzf)
    else
        echo "Available setups:"
        select setup_name in "${setups[@]}"; do
            break
        done
    fi
    #verify that a setup was selected and that the choice is in the setups array
    if [[ ! " ${setups[*]} " =~ " ${setup_name} " ]]; then
        list_setups
        echo "No valid setup selected, using default setup"
        default=true
    fi

else
    # if argument is provided, use it as setup name
    # after checking if it is a valid setup
    if [[ ! " ${setups[*]} " =~ " ${1} " ]]; then
        echo "Invalid setup name: $1"
        list_setups
        usage
        exit 1
    fi
    setup_name=$1
    #remove $1 from script arguments
    shift
fi

path_to_setup="$nvims_dirpath/$setup_name"
short_path_to_setup="$nvims_dirname/$setup_name"

# set environment variables and open nvim passing script arguments to it
if [ "$default" = true ]; then
  nvim $@
else
  NVIM_APPNAME="$short_path_to_setup" nvim $@
fi