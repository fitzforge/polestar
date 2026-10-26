#!/bin/sh
# Writes the gear golden with the JavaScript `gear build` (not run in CI):
#   sh regen.sh <JS checkout> [<out dir>]
# The JS reads its own checkout's package.json, Weights.lua, Polestar_ItemDB and wowsims cache, so it runs
# from a scratch root: a copy of <JS checkout>/tools plus input/root. ForeverLevelingBiS: input/AddOns.
# builtAt is pinned to 2026-10-22T00:00:00.000Z (pin-date.js). expected/: the files it writes, by path
# under the root, and stdout.txt.
set -eu
js=$(cd "${1:?usage: sh regen.sh <JS checkout> [<out dir>]}" && pwd)
here=$(cd "$(dirname "$0")" && pwd)
out=${2:-$here/expected}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cp -r "$js/tools" "$tmp/tools"
cp -r "$here/input/root/." "$tmp/"
# The gear command module itself (tools/polestar.js loads every command, some of them test helpers).
(cd "$tmp" && node -r "$here/pin-date.js" -e "require('./tools/commands/gear.js').run(['build', '--addons', process.argv[1]]).then((c) => { process.exitCode = c; })" "$here/input/AddOns") >"$tmp/stdout.txt"
rm -rf "$out"
mkdir -p "$out"
for f in addon/Polestar_ItemDB/Forever.lua addon/Polestar_ItemDB/Polestar_ItemDB.toc addon/Polestar_ItemDB/LICENSE-DATA.txt \
	addon/Polestar/Gear/SpecData.lua addon/Polestar/Gear/LICENSE-DATA.txt data/forever/gear/report.json; do
	mkdir -p "$out/$(dirname "$f")"
	cp "$tmp/$f" "$out/$f"
done
cp "$tmp/stdout.txt" "$out/stdout.txt"
