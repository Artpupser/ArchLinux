function exception_handler() {
    error "Error: $1"
    exit 1
}

function get_value_from_txt() {
    local prefix=$1
    local filename=$2
    local separator="${3:-=}"
    grep "^$1" "$2" | cut -d"$separator" -f2
}

function install_quest() {
    input "Install $1?"
    if [ "$INPUT_CACHE" == "y" ]; then
      check_and_install "$1"
    fi
}

function input {
  while true; do
    log "> $1 [y/n]"
    read -r value
    if ! [ "$value" == "y" ] && ! [ "$value" == "n" ]; then
      error "Your answer: \"$value\""
      continue
    fi
    break
  done
  INPUT_CACHE=$value
}

function download_file() {
  wget $1
}

function check_and_install_str() {
    str=$1
    IFS=' ' read -r -a apps <<< "$str"
    for i in "${!apps[@]}"; do
      check_and_install "${apps[$i]}"
    done
}

function error() {
    echo -e "\e[31m$1\e[0m"
}

function log() {
    echo -e "\e[0m$1"
}

function warn() {
    echo -e "\e[33m$1\e[0m"
}

function already() {
    echo -e "\e[36m$1\e[0m"
}

function success() {
    echo -e "\e[32m$1\e[0m"
}

function go_to() {
  cd "$1" || return
}

function go_home() {
  go_to "$HOME"
}

function check_and_install {
    local package=$1
    log "Check \"$package\"..."
    if ! yay -Q "$package" &> /dev/null; then
      warn "Installing \"$package\""
      yay -S --noconfirm "$package"
    else
      already "$package already installed."
    fi
}

function create_dir() {
    if ! [ -d "$PWD/$1" ]; then
        mkdir "$PWD/$1"
    fi
}
