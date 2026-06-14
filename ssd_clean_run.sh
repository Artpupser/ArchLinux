#! /bin/bash

source "./lib.sh"

input "Clean on all mounted files systems?"

{
if [ "$INPUT_CACHE" == "y" ]; then
  sudo fstrim -va /
else
  sudo fstrim -v /
fi
} || exception_handler "${LINENO}"

success "Success cleaned!"