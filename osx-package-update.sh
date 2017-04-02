#!/bin/bash

CASK_DIR="${CASK_DIR:=/usr/local/Homebrew/Caskroom/}"
CURRENT_DIR="${PWD}"
OPTS="${1}"

function update() {
 echo $OPTS
 if [[ "$(which brew)" ]]; then
  brew update
  brew upgrade
  brew cleanup
  brew prune
 fi
 if [[ -d "${CASK_DIR}" ]]; then
  for CASK in $(brew cask list); do
    INFO=$(brew cask info $CASK | head -3)
    CURRENT_VERSION=$(echo $INFO | head -1 | cut -d' ' -f2)
    NEW_VERSION=$(echo ${INFO##*/} | cut -d' ' -f1)
    if [[ "${CURRENT_VERSION}" != "${NEW_VERSION}" ]]; then
     brew cask reinstall $CASK
    elif [[ "${CURRENT_VERSION}" == "latest" ]]; then
     if [[ "${OPTS}" == "latest" ]]; then
      brew cask reinstall $CASK
     else
      echo "${CASK} is not using version tags, unable to determine if an update is needed. Use \`brew cask reinstall $CASK\` to manually update."
     fi
    fi
  done
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
