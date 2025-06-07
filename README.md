# NVIMS

`nvims` is a script to switch between different Neovim configurations on a linux(ish) system. 
Each configuration is referred to as a 'setup' and is located in 
the `~/.config/nvims/` directory. 
Any directory in `~/.config/nvims/` containing 
an `init.lua` file is considered a setup.

## Usage

```sh
nvims [setup_name]
```

## Details

`nvims` is a script to switch between different Neovim configurations. 
Each nvim configuration directory is referred to as a 'setup' and is located in 
the `~/.config/nvims/` directory. Any directory in `~/.config/nvims/` 
containing an `init.lua` file is considered a setup.
No checks are made to ensure that the `init.lua` file is a valid Neovim
configuration file.

This setup allows a default Neovim configuration to be used alongside
multiple custom configurations. This is useful for testing different
plugins, settings, and themes without modifying the default configuration.

Your default Neovim configuration is not affected by this script.
and should remain located in `~/.config/nvim/`.

Package managers like `lazy.nvim` install plugins in `~/.local/share/nvim/`
and `~/.local/state/nvim/` for a default installation.

Each setup will have its own `~/.local/share/nvims/<setup_name>/` 
and `~/.local/share/nvims/<setup_name>/` directories.  These directories
are created by the Package Manager when they install a plugin. 
This allows each setup to have its own set of plugins.

If you decide you don't like a setup and delete it from ~/.config/nvims/
the `~/.local/share/nvims/<setup_name>/` and `~/.local/share/nvims/<setup_name>/`
directories will remain.  You will need to delete them manually.

## Features

- Switch between different Neovim configurations.
- Supports fuzzy search for selecting setups if `fzf` is installed.
- Defaults to a simple selection prompt if `fzf` is not installed.
- Supports Nerd Fonts for enhanced prompt display.
## Install

### Clone the repository
```sh
git clone https://github.com/codesponge/nvims.git
```
## Setup

1. Create the directory `~/.config/nvims`.
2. Add your Neovim setups to this directory.
   Each setup should be a directory containing an `init.lua` file.

## Example

```sh
# List available setups
nvims

# Switch to a specific setup
nvims nvims/setup_name
```

## Environment Variables

- `NVIM_APPNAME`: Gets set to the selected setup's directory name to 
  isolate Neovim configurations.

## Default Values

These are the default values used by the script:

- `nvims_dirname`: Default setups directory name (`nvims`).
- `nvims_dirpath`: Path to the setups directory (`$HOME/.config/nvims`).
- `has_nerd_fonts`: Set to `true` by default. If you don't have Nerd Fonts, set this to `false`.

they can be changed to fit your system/environment.

## Script Details

The script performs the following steps:

1. Checks if the setups directory exists.
2. Generates a list of available setups by checking for directories containing an `init.lua` file.
3. If no argument is provided, prompts the user to select a setup.
4. If an argument is provided, validates the setup name.
5. Sets the `NVIM_APPNAME` environment variable and opens Neovim with the selected setup.
6. If no setup is selected the default Neovim configuration is opened.

## Dependencies
- `Neovim`: The text editor. version NVIM v0.10.2
- `fzf` (optional): For fuzzy search selection.

## License

This project is licensed under the MIT License.

