#!/usr/bin/env bash
# tools/nav/repack.sh [--check] [--move-pins] [--pack <AddOns>] [--date YYYY-MM-DD] [--work <dir>]
#
# Repacks the walking maps (addon/Polestar_Nav, Polestar_Nav_EK, Polestar_Nav_Kalimdor) from their inputs, in
# order (docs/nav/REPACK.md):
#   1. forge nav pack --leffe: this checkout's forge, its grid joins and cuts, the grid, the ground layers, Leffe's
#      maps and the data build; the cells and the date of the checkout's PACK.json unless --date
#   2. the layers 0.4.2's maps carry on top of a plain pack, and their ground sidecars (tools/lib/nav/repack.js graft)
#   3. the Ironforge cluster rebuild (forge-nav's occupied_floor example; SOURCE pins step 2's manifest)
#   4. the regional import (tools/lib/nav/import-regions.js; inputManifest pins step 3's manifest)
#   5. PACK.json's `repack`: each step's manifest sha256 and the inputs' (tools/lib/nav/repack.js record)
# The inputs' paths come from an env file outside the checkout: $POLESTAR_REPACK_ENV, else
# ${XDG_CONFIG_HOME:-~/.config}/polestar/nav-repack.env (NAV_GRID, NAV_LEFFE, NAV_LAYERS, NAV_DATA, NAV_GRAFT_BASE,
# NAV_GRAFT_PLAIN; docs/nav/REPACK.md).
#
# --check     repack into the work folder and compare with the checkout's maps byte for byte; exit 1 on any difference
# --move-pins when a step's manifest is not the one the next step pins (new joins, a new grid), move the pin in
#             occupied_floor.rs / import-regions.js and go on (review the diff); without it the repack stops there
# --pack      take step 1's output from this folder (a plain `forge nav pack` of the same inputs) instead of packing
# --date      the date of the generated headers (a repack with new inputs)
# --work      keep the steps' folders here (an empty or new folder); by default a temporary folder, removed on success
# Builds forge and occupied_floor (cargo, profile quick; CARGO_TARGET_DIR as set). Peak memory is the pack's:
# run it as a heavy job.
set -euo pipefail

die() { echo "repack: $*" >&2; exit 1; }
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
check=0 move_pins=0 pack= date= work=
while (($#)); do
	case $1 in
		--check) check=1 ;;
		--move-pins) move_pins=1 ;;
		--pack) pack=${2:?--pack needs a folder}; shift ;;
		--date) date=${2:?--date needs YYYY-MM-DD}; shift ;;
		--work) work=${2:?--work needs a folder}; shift ;;
		*) die "unknown argument $1 (see the head of $0)" ;;
	esac
	shift
done
((check && move_pins)) && die "--check compares with the checkout's maps: it moves no pins"

env_file=${POLESTAR_REPACK_ENV:-${XDG_CONFIG_HOME:-$HOME/.config}/polestar/nav-repack.env}
[[ -f $env_file ]] || die "no inputs file $env_file (docs/nav/REPACK.md, \"The inputs\")"
# shellcheck disable=SC1090
source "$env_file"
need() { [[ -n ${!1:-} && -e ${!1}/$2 ]] || die "$1 in $env_file: no $2 there"; }
need NAV_GRID index.json
need NAV_LEFFE .
need NAV_LAYERS hubs.json
need NAV_DATA forever/travel.json
need NAV_GRAFT_BASE Polestar_Nav/PACK.json
need NAV_GRAFT_PLAIN Polestar_Nav/PACK.json
leffe_manifest=$NAV_LEFFE/PACK.json
[[ -f $leffe_manifest ]] || leffe_manifest=$(dirname "$NAV_LEFFE")/PACK.json
[[ -f $leffe_manifest ]] || die "NAV_LEFFE in $env_file: no PACK.json in it or the folder holding it"
wago=$(cd "$NAV_DATA/sources/wago" && for b in */; do [[ -f $b/AreaTable.csv ]] && echo "${b%/}"; done | sort -V | tail -n 1)
[[ -n $wago ]] || die "NAV_DATA in $env_file: no sources/wago/<build>/AreaTable.csv"

shipped=$ROOT/addon/Polestar_Nav/PACK.json
cells=$(node -p "require('$shipped').cells")
date=${date:-$(node -p "require('$shipped').date")}

if [[ -n $work ]]; then
	mkdir -p "$work"
	[[ -z $(ls -A "$work") ]] || die "--work $work is not empty"
	W=$(cd "$work" && pwd)
else
	W=$(mktemp -d "${TMPDIR:-/tmp}/nav-repack.XXXXXX")
	trap 'status=$?; if ((status)); then echo "repack: the steps so far are in $W" >&2; else rm -rf "$W"; fi' EXIT
fi

target=${CARGO_TARGET_DIR:-$ROOT/rust/target}
FORGE=$target/quick/forge
OF=$target/quick/examples/occupied_floor
build() {
	echo "== build: forge, occupied_floor"
	cargo build --manifest-path "$ROOT/rust/Cargo.toml" --profile quick -p forge --bin forge -p forge-nav --example occupied_floor
}
build

# A pin in source (a 64-hex constant on its line) moved to the manifest a step made, or the repack stops.
pin() { # <file> <sed pattern capturing the pin> <manifest> <what>
	local file=$1 pinned actual
	pinned=$(sed -n "$2" "$file")
	[[ $pinned =~ ^[0-9a-f]{64}$ ]] || die "no pin found in $file"
	actual=$(sha256sum < "$3/Polestar_Nav/PACK.json" | cut -c1-64)
	[[ $pinned == "$actual" ]] && return 1
	((move_pins)) || die "$4 is $actual, ${file#"$ROOT"/} pins $pinned: the inputs changed the maps. Review the step, then run again with --move-pins"
	sed -i "s/$pinned/$actual/" "$file"
	echo "moved the pin in ${file#"$ROOT"/}: $pinned -> $actual"
}

echo "== 1. forge nav pack (cells $cells, date $date)"
if [[ -n $pack ]]; then
	[[ -f $pack/Polestar_Nav/PACK.json ]] || die "--pack $pack: no Polestar_Nav/PACK.json"
	cp -a "$pack" "$W/pack"
	echo "taken from --pack"
else
	# forge nav pack reads data/forever, data/sources/wago and data/crossings.json under --root.
	mkdir -p "$W/root/data"
	ln -s "$NAV_DATA/forever" "$W/root/data/forever"
	ln -s "$NAV_DATA/sources" "$W/root/data/sources"
	ln -s "$ROOT/data/crossings.json" "$W/root/data/crossings.json"
	mkdir "$W/pack"
	"$FORGE" nav pack --dir "$NAV_GRID" --layers "$NAV_LAYERS" --leffe "$NAV_LEFFE" --cells "$cells" --date "$date" \
		--root "$W/root" --out "$W/pack/Polestar_Nav" 2> "$W/pack.log" || { tail -n 20 "$W/pack.log" >&2; die "forge nav pack failed (log: $W/pack.log)"; }
fi

echo "== 2. graft 0.4.2's layers and ground sidecars"
node "$ROOT/tools/lib/nav/repack.js" graft "$NAV_GRAFT_BASE" "$NAV_GRAFT_PLAIN" "$W/pack" "$W/derived"

echo "== 3. Ironforge cluster rebuild"
of_rs=$ROOT/rust/crates/forge-nav/examples/occupied_floor.rs
if pin "$of_rs" 's/^const SOURCE: &str = "\([0-9a-f]*\)";$/\1/p' "$W/derived" "the grafted manifest"; then build; fi
"$OF" "$W/derived" "$W/of"
cp -a "$W/derived" "$W/rebuilt"
cp -a "$W/of/." "$W/rebuilt/"

echo "== 4. regional import"
import_js=$ROOT/tools/lib/nav/import-regions.js
pin "$import_js" "s/^const inputManifest = '\([0-9a-f]*\)';$/\1/p" "$W/rebuilt" "the rebuilt manifest" || true
if ((check)); then
	OUT=$W/out
	for toc in Polestar_Nav/Polestar_Nav.toc Polestar_Nav_EK/Polestar_Nav_EK.toc Polestar_Nav_Kalimdor/Polestar_Nav_Kalimdor.toc; do
		mkdir -p "$OUT/$(dirname "$toc")"
		cp "$ROOT/addon/$toc" "$OUT/$toc"
	done
else
	OUT=$ROOT/addon
fi
node "$import_js" "$W/rebuilt" "$OUT"

echo "== 5. record the pins and the inputs"
inputs=("leffe/PACK.json=$leffe_manifest")
for f in index.json aids.json areas.json lifts.json; do [[ -f $NAV_GRID/$f ]] && inputs+=("grid/$f=$NAV_GRID/$f"); done
inputs+=("layers/hubs.json=$NAV_LAYERS/hubs.json")
[[ -f $NAV_LAYERS/roads/index.json ]] && inputs+=("layers/roads/index.json=$NAV_LAYERS/roads/index.json")
for f in zones.json map-frames.json travel.json spawnz.json; do inputs+=("data/forever/$f=$NAV_DATA/forever/$f"); done
inputs+=("data/sources/wago/$wago/AreaTable.csv=$NAV_DATA/sources/wago/$wago/AreaTable.csv")
inputs+=("data/crossings.json=$ROOT/data/crossings.json" "joins.json=$ROOT/rust/crates/forge-nav/src/pack/joins.json")
node "$ROOT/tools/lib/nav/repack.js" record "$OUT" "$W" "$NAV_GRAFT_BASE" "$NAV_GRAFT_PLAIN" "${inputs[@]}"

"$FORGE" nav check --out "$OUT/Polestar_Nav"
if ((check)); then
	echo "== compare with the checkout's maps"
	node "$ROOT/tools/lib/nav/repack.js" compare "$OUT" "$ROOT/addon"
else
	node "$ROOT/tools/lib/nav/repack.js" compare "$OUT" "$OUT"
fi
