#!/bin/sh
# Writes the professions golden with the JavaScript `profession build --offline` (not run in CI):
#   sh regen.sh <JS checkout> [<out dir>]
# Data: input/data/items.json with the world slice's npcs.json and objects.json beside it (copied
# into a temporary folder, as the test does); sources: input/sources.
# expected/: professions.json, report.txt (stdout), warnings.txt (stderr's `warning:` lines).
set -eu
js=$(cd "${1:?usage: sh regen.sh <JS checkout> [<out dir>]}" && pwd)
here=$(cd "$(dirname "$0")" && pwd)
out=${2:-$here/expected}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/data" "$out"
cp "$here/input/data/items.json" "$here/../world/root/data/forever/npcs.json" "$here/../world/root/data/forever/objects.json" "$tmp/data/"
cd "$out"
node "$js/tools/polestar.js" profession build --offline --data "$tmp/data" --sources "$here/input/sources" --out professions.json \
	>report.txt 2>"$tmp/stderr"
grep '^warning: ' "$tmp/stderr" >warnings.txt || true
