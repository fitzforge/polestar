#!/bin/sh
# Build the browser planner into www/ (serve it with any static server: python3 -m http.server --directory www).
#
#   www-build/build.sh <checkout> <sim dir> <local dir> <name>=<pack dir> [<name>=<pack dir> ...]
#
#   <checkout>   a checkout with data/forever, data/sources, addon/Polestar/Polestar.toc and package.json
#   <sim dir>    world-horde.json, world-alliance.json, params.json
#   <local dir>  data/local with planner/art, planner/icons, nav4 (the nav grid) and nav-layers
#   name=dir     the guide sets the page offers (?set=name; the first is the default only when named v1)
#
# Steps: wasm-pack (www/pkg), the data bundle (www/bundle: cargo run --bin bundle), the page and its
# backend worker (build.mjs), the map art, overlays, icons and routed walk legs (export-assets.js).
set -e
here=$(cd "$(dirname "$0")" && pwd)
crate=$(dirname "$here")
root=$1; sim=$2; local=$3; shift 3
[ -n "$root" ] && [ -n "$sim" ] && [ -n "$local" ] && [ $# -gt 0 ] || { sed -n 4,11p "$0"; exit 2; }
sets=""; legsets=""
for s in "$@"; do sets="$sets --set $s"; legsets="$legsets --set $s@Human,Orc,*"; done
cd "$crate"
[ -d "$here/node_modules" ] || (cd "$here" && npm install --no-audit --no-fund)
wasm-pack build --release --target web --out-dir www/pkg --no-typescript
# shellcheck disable=SC2086
cargo run --release --features native --bin bundle -- --root "$root" --sim "$sim" --out www/bundle $sets
node "$here/build.mjs"
# shellcheck disable=SC2086
node "$here/export-assets.js" --out www --local "$local" --nav "$local/nav4" --data "$root/data/forever" --sources "$root/data/sources" --sim "$sim" $legsets
