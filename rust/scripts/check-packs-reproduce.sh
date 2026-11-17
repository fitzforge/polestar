#!/usr/bin/env bash
# Do the committed compiled guide packs reproduce from a given reference data folder? In a temporary
# worktree of HEAD, with <data dir>/forever as data/forever and <data dir>/sources as data/sources (the
# client's AreaTable), it runs `forge i18n guides sync`, `forge guide compile` and `forge guide compile
# experimental`, then lists every file they changed. A guide pull request compiled with the maintainers'
# data leaves nothing to list.
#
# usage: rust/scripts/check-packs-reproduce.sh <data dir>
# env:   FORGE (default: rust/target/release/forge, then forge on PATH)
# exit:  0 the packs reproduce; 1 the files listed differ; 2 it could not run
set -euo pipefail
[ $# -eq 1 ] || { echo "usage: $0 <data dir holding forever/ and sources/>" >&2; exit 2; }
DATA=$(realpath "$1")
for d in forever sources; do
	[ -d "$DATA/$d" ] || { echo "$DATA/$d: no such folder" >&2; exit 2; }
done
ROOT=$(git rev-parse --show-toplevel)
FORGE=${FORGE:-$ROOT/rust/target/release/forge}
[ -x "$FORGE" ] || FORGE=$(command -v forge) || { echo "no forge: build it (cargo build --release -p forge in rust/) or set FORGE" >&2; exit 2; }
FORGE=$(realpath "$FORGE")

WT=$(mktemp -d)
LOG=$(mktemp)
cleanup() { git -C "$ROOT" worktree remove --force "$WT" 2>/dev/null || rm -rf "$WT"; rm -f "$LOG"; }
trap cleanup EXIT
git -C "$ROOT" worktree add --detach --quiet "$WT" HEAD
ln -s "$DATA/forever" "$WT/data/forever"
ln -s "$DATA/sources" "$WT/data/sources"
cd "$WT"
for step in "i18n guides sync" "guide compile" "guide compile experimental"; do
	# shellcheck disable=SC2086 # the step is its words
	"$FORGE" $step --root . > "$LOG" 2>&1 || { cat "$LOG" >&2; echo "forge $step failed" >&2; exit 2; }
	grep -E '^areas:' "$LOG" || true
done
changed=$(git status --porcelain)
if [ -n "$changed" ]; then
	echo "$changed"
	git diff --stat | tail -1
	echo "the compiled packs do not reproduce from $DATA at $(git rev-parse --short HEAD): the files above differ"
	exit 1
fi
echo "the compiled packs reproduce from $DATA at $(git rev-parse --short HEAD)"
