#!/bin/bash

CASK_DIR="/usr/local/Homebrew/Caskroom/"
CURRENT_DIR="${PWD}"

function update() {
 if [[ "$(which brew)" ]]; then
  brew update
  brew upgrade
  brew cleanup
  brew prune
 fi
 if [[ -d "${CASK_DIR}" ]]; then
  brew cask install $(brew cask list) 2>/dev/null
  brew cask cleanup
  # Delete old versions of cask
  for folder in $(ls -d "${CASK_DIR}"/*/); do
   cd $folder
   if [[ $(ls | wc -l) -gt 1  ]]; then
     echo $folder is greater than 1
     echo "Deleting: " $(ls | sort -r | tail -n +2)
     rm -r $(ls | sort -r | tail -n +2)
   fi
  done
 fi
 if [[ "$(which apm)" ]]; then
  apm update --no-confirm
  apm upgrade --no-confirm
 fi
 if [[ "$(which pip)" ]]; then
  pip install --upgrade $(pip list --outdated --format=legacy | cut -f 1 -d " ") 2>/dev/null
 fi
 if [[ "$(which gem)" ]]; then
  gem update $(gem list --local | cut -f 1 -d " ")
 fi
 if [[ ! -z "$(which npm)" ]]; then
  npm update -g
 fi

 cd "${CURRENT_DIR}"
}

update
