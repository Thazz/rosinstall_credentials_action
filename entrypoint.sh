#!/bin/bash

set -euo pipefail

# Check if rosinstall file existst
if [[ -e $INPUT_ROSINSTALL_FILE ]]; then 
    echo "::error::Input file $INPUT_ROSINSTALL_FILE doesn't exist"
    exit 1
fi

TMP_FILE=tmp.rosinstall
export GITHUB_CREDENTIALS=$INPUT_CREDENTIALS

sed -i 's/https:\/\/github\.com/https:\/\/\$\{GITHUB_CREDENTIALS\}@github\.com/g' "$INPUT_ROSINSTALL_FILE"
envsubst < "$INPUT_ROSINSTALL_FILE" > "$TMP_FILE"
rm "$INPUT_ROSINSTALL_FILE"
mv "$TMP_FILE" "$INPUT_ROSINSTALL_FILE"

echo "Successfully injected credentials."

exit 0