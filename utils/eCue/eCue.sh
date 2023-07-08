#!/usr/bin/env bash
set -euo pipefail

trap 'cleanup' EXIT

function cleanup() {
  rm "$cue1" "$cue2"
}

file1="$1"
file2="$2"

cue1="$(mktemp --suffix .cue)"
cue2="$(mktemp --suffix .cue)"

cue import "$file1" --force --path '#schema:' --outfile "$cue1"
cue import "$file2" --force --path '#schema:' --outfile "$cue2"

cue vet "$cue1" -d '#schema' "$file2"
cue vet "$cue2" -d '#schema' "$file1"
