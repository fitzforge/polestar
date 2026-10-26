#!/bin/sh
# Writes the trainers golden with the JavaScript `trainers build` (not run in CI):
#   sh regen.sh <JS checkout> [<out dir>]
# Data: ../data/expected (the data golden); guides and recordings: ./input.
set -eu
js=$(cd "${1:?usage: sh regen.sh <JS checkout> [<out dir>]}" && pwd)
here=$(cd "$(dirname "$0")" && pwd)
out=${2:-$here/expected}
mkdir -p "$out"
cd "$js"
node tools/polestar.js trainers build --data "$here/../data/expected" --guides "$here/input/guides" \
	--recordings "$here/input/recordings" --out "$out/trainers.json" --lua "$out/ClassTrainers.lua"
