#!/usr/bin/env bash
# The scenario tests on a release zip (docs/RELEASING.md, step 5): what a player sees, hears and has done for
# them in a capital, in fights, on a flight, with a full quest log, on the first run and after updating from
# the live release, with the work each event costs (forge-addontest's `scenes` tests,
# crates/forge-addontest/tests/scenes). Unpacks the zip (and the Recorder's zip beside it, when there) into a
# fresh AddOns folder, the live release's zip into another for the update scene, and runs every scene once,
# timing budgets enforced, nothing else on the machine.
#   rust/scripts/scenes.sh dist/Polestar-0.4.2.zip --previous <Polestar-0.4.1.1.zip of the live release>
#   rust/scripts/scenes.sh --dir <AddOns folder> --previous-dir <AddOns folder>   (already unpacked)
# The last line is `scenes: PASS <n>/<n>` (exit 0) or `scenes: FAIL ...` (exit 1); 2 for a usage error.
set -uo pipefail
cd "$(git rev-parse --show-toplevel)" || exit 2

usage() {
	echo "usage: rust/scripts/scenes.sh <Polestar-x.y.z.zip> --previous <live release's Polestar zip> [-- <cargo test filter>]" >&2
	echo "       rust/scripts/scenes.sh --dir <AddOns> --previous-dir <AddOns> [-- <filter>]" >&2
	exit 2
}

zip="" prev="" dir="" prevdir="" filter=()
while [ $# -gt 0 ]; do
	case "$1" in
	--previous) prev=${2:-}; shift 2 || usage ;;
	--dir) dir=${2:-}; shift 2 || usage ;;
	--previous-dir) prevdir=${2:-}; shift 2 || usage ;;
	--) shift; filter=("$@"); break ;;
	-*) usage ;;
	*) [ -z "$zip" ] || usage; zip=$1; shift ;;
	esac
done
[ -n "$zip" ] || [ -n "$dir" ] || usage
[ -n "$prev" ] || [ -n "$prevdir" ] || { echo "scenes: --previous <the live release's zip> is needed (the update scene)" >&2; usage; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
unpack() { # <zip> <AddOns folder>: the zip and its Recorder zip beside it
	local z=$1 out=$2 rec
	[ -f "$z" ] || { echo "scenes: FAIL no zip at $z"; exit 1; }
	mkdir -p "$out"
	unzip -q "$z" -d "$out" || { echo "scenes: FAIL could not unpack $z"; exit 1; }
	rec=$(dirname "$z")/$(basename "$z" | sed 's/^Polestar-/Polestar_Recorder-/')
	[ -f "$rec" ] && unzip -q -o "$rec" -d "$out"
	return 0
}
if [ -n "$zip" ]; then
	dir=$tmp/new/AddOns
	unpack "$zip" "$dir"
	echo "zip: $zip sha256 $(sha256sum "$zip" | cut -d' ' -f1)"
fi
if [ -n "$prev" ]; then
	prevdir=$tmp/old/AddOns
	unpack "$prev" "$prevdir"
fi
echo "scenes.sh ${zip:-"--dir $dir"} --previous ${prev:-"--previous-dir $prevdir"}"
[ -f "$dir/Polestar/Polestar.toc" ] || { echo "scenes: FAIL no Polestar/Polestar.toc in $dir"; exit 1; }
[ -f "$prevdir/Polestar/Polestar.toc" ] || { echo "scenes: FAIL no Polestar/Polestar.toc in $prevdir"; exit 1; }

unset POLESTAR_TIMING_BUDGETS
log=$tmp/scenes.log
(cd rust && POLESTAR_ADDON_DIR=$(realpath "$dir") POLESTAR_PREVIOUS_ADDON_DIR=$(realpath "$prevdir") \
	cargo test --profile quick --locked -p forge-addontest --test scenes -- --test-threads 1 "${filter[@]}") 2>&1 | tee "$log"
rc=${PIPESTATUS[0]}

summary=$(grep -E '^test result:' "$log" | tail -1)
passed=$(sed -nE 's/.* ([0-9]+) passed.*/\1/p' <<<"$summary")
failed=$(sed -nE 's/.* ([0-9]+) failed.*/\1/p' <<<"$summary")
skipped=$(grep -c '^scene skipped' "$log")
total=$((${passed:-0} + ${failed:-0}))
if [ "$rc" = 0 ] && [ "${failed:-1}" = 0 ] && [ "$skipped" = 0 ] && [ "$total" -gt 0 ]; then
	echo "scenes: PASS $passed/$total"
	exit 0
fi
names=$(grep -E '^test .* FAILED$' "$log" | sed -E 's/^test (.*) \.\.\. FAILED$/\1/' | paste -sd' ' -)
[ "$skipped" -gt 0 ] && skipnote=" ($skipped skipped)" || skipnote=""
echo "scenes: FAIL ${failed:-?} of $total failed${names:+: $names}$skipnote (cargo exit $rc)"
exit 1
