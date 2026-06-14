#! /bin/bash

source lib.sh

CURRENT_YEAR=$(date +%Y)
((CURRENT_YEAR-=1))
WEB_STORM="https://download.jetbrains.com/webstorm/WebStorm-$CURRENT_YEAR.2.tar.gz"
RIDER="https://download.jetbrains.com/rider/JetBrains.Rider-$CURRENT_YEAR.1.2.tar.gz"
PY_CHARM="https://download.jetbrains.com/python/pycharm-$CURRENT_YEAR.2.tar.gz"
RUST_ROVER="https://download.jetbrains.com/rustrover/RustRover-$CURRENT_YEAR.2.tar.gz"
IDEA_IU="https://download.jetbrains.com/idea/ideaIU-$CURRENT_YEAR.2.tar.gz"
IDES_URLS=("$WEB_STORM" "$RIDER" "$PY_CHARM" "$RUST_ROVER" "$IDEA_IU")
IDES=("WebStorm" "Rider" "PyCharm" "RustRover" "IdeaIU")
IDES_RESET=("RustRover" "Rider" "IdeaIU" "IntelliJIdea" "WebStorm" "DataGrip" "PhpStorm" "CLion" "PyCharm" "GoLand" "RubyMine")
SELECTED=(0 0 0 0 0)
COMMAND_PREFIX="--"

IDE_PATH="$HOME/apps/IDE/" #Change this value on your path

function main() {
  tag_all "$2"
  case $1 in
    "$COMMAND_PREFIX""help")
      log_help_command "$COMMAND_PREFIX""help" "view all info."
      log_help_command "$COMMAND_PREFIX""install" "process installing"
      log_help_command "$COMMAND_PREFIX""uninstall" "process uninstalling"
      log_help_command "$COMMAND_PREFIX""reset" "reset all licenses 30-days on all IDE"
      log_help_command "$COMMAND_PREFIX""all" "This double tag, selected all apps -> \'example: install ${COMMAND_PREFIX}all\'"
      ;;
    "$COMMAND_PREFIX""install")
      check_dir "$IDE_PATH"
      if [ -z "$2" ]; then
        select_apps "Install"
      fi
      enumerate_selected install
      ;;
    "$COMMAND_PREFIX""uninstall")
      check_dir "$IDE_PATH"
      if [ -z "$2" ]; then
        select_apps "Uninstall"
      fi
      enumerate_selected uninstall
      ;;
    "$COMMAND_PREFIX""reset")
      reset_license
      ;;
    *)
      ./jetbrains_ide_installer_run.sh "$COMMAND_PREFIX""help"
      exit 0
      ;;
  esac
  exit 0
}



function tag_all() {
  if [ -z "$2" ]; then
    return
  fi
  IFS=" " ides_str=${IDES[*]}
  input "Select all?: \"$ides_str\""
  if ! [ "$INPUT_CACHE" == 'y' ]; then
    exit 0
  fi
  if [ "$1" == "${COMMAND_PREFIX}all" ]; then
    for i in "${!SELECTED[@]}"; do
      SELECTED[i]=1
    done
  fi
}

function enumerate_selected() {
  for i in "${!SELECTED[@]}"; do
    if [ "${SELECTED[i]}" == "1" ]; then
      local gz_path
      gz_path=$(find . -maxdepth 1 -type f -name "*${IDES[i]}*.tar.gz")
      local dir_path
      dir_path=$(find . -maxdepth 1 -type d -name "*${IDES[i]}*" 2>/dev/null)
      $1 "$i" "$gz_path" "$dir_path"
    fi
  done
}

function install()  {
  local i=$1
  local gz_path=$2
  local dir_path=$3
  log "Check \"${IDES[i]}\""
  log "$gz_path"
  log "$dir_path"
  if ! [ -d "$dir_path" ] && ! [ -e "$gz_path" ]; then
    warn "\"${IDES[i]}\" installing..."
    download_file "${IDES_URLS[i]}"
  else
    already "\"${IDES[i]}\" already downloaded."
  fi
  if ! [ -d "$dir_path" ]; then
    gz_path=$(find . -maxdepth 1 -type f -name "*.tar.gz")
    tar -xzvf "$gz_path" && rm -rf "$gz_path"
  else
    already "\"${IDES[i]}\" already installed."
  fi
}

function uninstall() {
  local i=$1
  local gz_path=$2
  local dir_path=$3
  log "Check \"${IDES[i]}\""
  if [ -d "$dir_path" ]; then
    error "Removing \"${IDES[i]}\""
    rm -rf "$dir_path"
    success "\"${IDES[i]}\" success removed."
  else
    warn "\"${IDES[i]}\" not founded."
  fi
}

function reset_license() {
  check_dir "$IDE_PATH"
  for i in "${!IDES_RESET[@]}"; do
    local ide=${IDES_RESET[i]}
    echo "Reset trial period: \"$ide\""
    rm -rf ~/.config/$ide*/eval 2> /dev/null
    rm -rf ~/.config/JetBrains/$ide*/eval 2> /dev/null
    sed -i 's/evlsprt//' ~/.config/$ide*/options/other.xml 2> /dev/null
    sed -i 's/evlsprt//' ~/.config/JetBrains/$ide*/options/other.xml 2> /dev/null
  done
  rm -rf ~/.java/.userPrefs 2> /dev/null
}

function select_apps() {
    for i in "${!IDES[@]}"; do
      input "$1 ${IDES[$i]}?"
      if [ "$INPUT_CACHE" == "y" ]; then
        SELECTED[i]=1
      fi
    done
}

function check_dir() {
  if ! [ -d "$1" ]; then
    error "Path not exists \"$1\""
    exit 1
  else
    go_to "$IDE_PATH"
  fi
}

function log_help_command {
  warn "[$1]: \"$2\""
}

main "$1" "$2"
