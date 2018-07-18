#!/bin/bash

CASK_DIR="${CASK_DIR:=/usr/local/Caskroom/}"
CURRENT_DIR="${PWD}"
OPTS="${1}"

function update() {
 echo $OPTS
 if [[ "$(which brew)" ]]; then
  brew update
  brew upgrade --cleanup
  brew cleanup -s
  brew prune
 fi
 if [[ -d "${CASK_DIR}" ]]; then
  brew cask upgrade 
  brew cask cleanup
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
 if [[ "$(which npm)" ]]; then
  npm update -g
 fi

 cd "${CURRENT_DIR}"
}

update
