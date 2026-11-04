#!/bin/sh
# Writes the travel golden with the JavaScript `travel build` (not run in CI):
#   sh regen.sh <JS checkout> [<out dir>]
# Data: ../data/expected (the data golden); sources, recordings, shipped and local crossings: ./input
# (slice.js). No navigation grid (--grid none). input/package.json's version must be the checkout's
# (Polestar_Travel's TOC carries it).
set -eu
js=$(cd "${1:?usage: sh regen.sh <JS checkout> [<out dir>]}" && pwd)
here=$(cd "$(dirname "$0")" && pwd)
out=${2:-$here/expected}
in=$here/input
rm -rf "$out"
mkdir -p "$out"
cd "$js"
node tools/polestar.js travel build --offline --data "$here/../data/expected" --recordings "$in/recordings" \
	--sources "$in/sources" --shipped "$in/crossings.json" --crossings "$in/local/crossings.json" --grid none \
	--json "$out/travel.json" --lua "$out/TravelData.lua" --flight-lua "$out/FlightPaths.lua" --travel-addon "$out/Polestar_Travel"
