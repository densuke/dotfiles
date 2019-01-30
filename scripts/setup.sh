#!/bin/bash

REPOS="https://github.com/densuke/dotfiles.git"
PUSH="git@github.com:densuke/dotfiles.git"
PREFIX="${HOME}/.dotfiles"

info() {
  echo "[info] $1"
}

warn() {
 echo "[warn] $1" > /dev/stderr
}

err() {
  echo "[fatal] $1" > /dev/stderr
  exit "${ERRNO}"
}

NEED=""
which make >& /dev/null || NEED="${NEED} make"
which bash >& /dev/null || NEED="${NEED} bash"
which git >& /dev/null || NEED="${NEED} git"
if [ "${NEED}" ]; then
  warn "install required tools...(may be need password)"
  sudo apt-get update
  sudo apt-get install -y ${NEED} 
  for item in ${NEED}; do
    which ${item}} >/dev/null || ERRNO=1 err "Unable to install ${item}"
  done
fi

if [ -d "${PREFIX}" ]; then
 err "prefix(${PREFIX})is already exists."
fi

git clone "${REPOS}" "${PREFIX}"
cd "${PREFIX}"
git remote set-url --push origin "${PUSH}"
info "changed push method using ssh"

make all
