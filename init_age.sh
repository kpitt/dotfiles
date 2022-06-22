#!/bin/bash

# This script draws heavily from the Homebrew installer script:
#   https://raw.githubusercontent.com/Homebrew/install/master/install.sh

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

# Single brackets here are for POSIX compatibility when not bash
if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

CONFIG_DIR="$HOME/.config/age"
KEY_FILE_NAME="me.key.txt"

# string formatters
if [[ -t 1 ]]; then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_blue="$(tty_mkbold 34)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
  local arg
  printf "%s" "$1"
  shift
  for arg in "$@"
  do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}

info() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$1"
}

execute() {
  if ! "$@"; then
    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
  fi
}

get_permission() {
  stat -f "%A" "$1"
}

is_command() {
  command -v "$1" > /dev/null
}

test_op() {
  if ! is_command op; then
    return 1
  fi

  local op_version
  op_version="$(op --version 2>/dev/null)"
  [[ "${op_version%%.*}" -ge 2 ]]
}

dir_exists_but_not_private_writable() {
  [[ -d "$1" ]] && [[ "$(get_permission "$1")" != 700 ]]
}

not_private_readable() {
  [[ "$(get_permission "$1")" != [467]00 ]]
}

get_age_public_key() {
  age-keygen -y "$1" 2>/dev/null
}

if ! is_command age-keygen; then
  abort 'You must install `age` encryption before running this script.'
fi

if ! test_op; then
  abort "$(
    cat <<EOABORT
This script requires 1Password CLI 2 which was not found on your system.
Please install 1Password CLI 2 or newer and add it to your PATH.
EOABORT
  )"
fi

# Make sure 1Password is signed in.
info "Signing into 1Password (which may request your password)..."
eval $(op signin)

# Make sure created directory and files are private.
umask 077

if dir_exists_but_not_private_writable "$CONFIG_DIR"; then
  info "Setting private-writable permissions for directory ${CONFIG_DIR}"
  execute chmod 700 "${CONFIG_DIR}"
elif [[ ! -d "$CONFIG_DIR" ]]; then
  info "Creating config directory ${CONFIG_DIR}"
  mkdir -p "$CONFIG_DIR"
fi

KEY_FILE_PATH="${CONFIG_DIR}/${KEY_FILE_NAME}"
if [[ -s "$KEY_FILE_PATH" ]]; then
  age_key="$(get_age_public_key "${KEY_FILE_PATH}")"
  if [[ -z "${age_key}" ]]; then
    abort "$(
      cat <<EOABORT
Existing identity file ${KEY_FILE_PATH} does not contain a valid key.
Move or delete the existing file, then try again.
EOABORT
    )"
  fi
  info "Identity file ${KEY_FILE_PATH} already exists:"
  echo "Public key: ${age_key}"
else
  info "Installing identity file ${KEY_FILE_PATH}:"
  if ! (op document get "age/${KEY_FILE_NAME}" --output="${KEY_FILE_PATH}" 2> /dev/null)
  then
    abort "$(
      cat <<EOABORT
Identity file could not be retrieved from 1Password.
Please make sure that identify file document has been added to 1Password
with name "age/${KEY_FILE_NAME}", then try again.
EOABORT
    )"
  fi
  age_key="$(get_age_public_key "${KEY_FILE_PATH}")"
  echo "Public key: ${age_key}"
fi
if not_private_readable "${KEY_FILE_PATH}"; then
  info "Setting private permissions for identity file..."
  execute chmod "og-rwx" "${KEY_FILE_PATH}"
fi

info "Success!"
echo
