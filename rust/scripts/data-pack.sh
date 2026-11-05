#!/bin/sh
# The public data pack with a given folder of Leffe's navigation maps, in one command: the walk
# stores (our grid's and Leffe's, the hybrid walks) built on the canonical grid with those maps,
# then `forge data pack` with them and the maps as their own asset. Swapping in a new pack of
# Leffe's is this command with the new folder: the Leffe walk stores are keyed by his maps' hash and
# the grid stores by the grid's, so only what changed is routed again.
#
# usage: rust/scripts/data-pack.sh <Leffe maps folder> <out dir>
# env:   FORGE (default: rust/target/release/forge), ROOT (the checkout the pack's files come from),
#        DATA_ROOT (default ROOT), GUIDES (any guide tree; the walks stage only needs the data),
#        GRID (the canonical grid, after `forge nav prepare`), THREADS (default 6)
set -eu
[ $# -eq 2 ] || { echo "usage: $0 <Leffe maps folder> <out dir>" >&2; exit 2; }
LEFFE=$(realpath "$1")
OUT=$(realpath -m "$2")
HERE=$(dirname "$(realpath "$0")")
FORGE=${FORGE:-$HERE/../target/release/forge}
: "${ROOT:?ROOT: the checkout (data/sources, data/local, tools, addon)}"
: "${GRID:?GRID: the canonical grid}"
: "${GUIDES:?GUIDES: a guide tree}"
DATA_ROOT=${DATA_ROOT:-$ROOT}
THREADS=${THREADS:-6}
"$FORGE" build --guides "$GUIDES" --root "$ROOT" --data-root "$DATA_ROOT" --grid "$GRID" \
	--out "$OUT/build" --starts all --nav hybrid --leffe "$LEFFE" --threads "$THREADS" --until walks
"$FORGE" data pack --root "$ROOT" --walks-from "$OUT/build" --grid "$GRID" --leffe "$LEFFE" --out "$OUT"
