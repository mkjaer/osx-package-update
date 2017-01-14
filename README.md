# OSX Package Update

This will update packages from custom package managers and clean up afterwards.

## Installation

Clone this project and source `osx-package-update.sh` from your profile file.

For bash (from the directory with the code): `echo "alias update=$(pwd)/osx-package-update.sh" >> ~/.bash_profile`

## Configuration

Configuration variables are in the top of the script.

If you're installing brew casks in a non-default folder it can be set with `CASK_DIR`

## Package support

Currently supported packages:

* brew
* brew cask
* RubyGems (gem)
* Atom (apm)
* Python (pip)
* npm
