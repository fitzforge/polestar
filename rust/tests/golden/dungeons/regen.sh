#!/bin/sh
# Writes the dungeons golden with the JavaScript `dungeons build` (not run in CI):
#   sh regen.sh <JS checkout> <scratch dir> [<out dir>]
# Journal: ./input/ForeverDungeonJournal (synthetic, DungeonJournal 1.6.0's layout); data: the data
# golden (../data/expected), copied into <scratch dir> because the command writes dungeons.json there.
set -eu
js=$(cd "${1:?usage: sh regen.sh <JS checkout> <scratch dir> [<out dir>]}" && pwd)
here=$(cd "$(dirname "$0")" && pwd)
scratch=${2:?usage: sh regen.sh <JS checkout> <scratch dir> [<out dir>]}/dungeons-data
out=${3:-$here/expected}
rm -rf "$scratch"
mkdir -p "$scratch" "$out"
cp "$here"/../data/expected/*.json "$scratch"/
cd "$js"
node tools/polestar.js dungeons build --source "$here/input/ForeverDungeonJournal" --data "$scratch"
cp "$scratch/dungeons.json" "$out/dungeons.json"
