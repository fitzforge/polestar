#!/usr/bin/env bash
# Byte parity of the Rust compiler against the JS one (this worktree's tools/lib).
# usage: POLESTAR_JSREF=<scratch dir> [POLESTAR_CHECKOUT=<checkout>] rust/crates/forge-guide/tests/parity.sh [mini own main v2 ...] (default: all)
#   POLESTAR_JSREF: references and Rust outputs go to $POLESTAR_JSREF/guide; v2 compiles $POLESTAR_JSREF/repaired.
#   POLESTAR_CHECKOUT: main compiles a copy of its guides/ (needed for main only).
# References: node rust/crates/forge-guide/tests/js-ref.js <guides> $POLESTAR_JSREF/guide/ref-<name>
# (made when missing or with REF=1). Prints every differing file; exit 1 on any difference.
set -u
usage() { echo "usage: POLESTAR_JSREF=<scratch dir> [POLESTAR_CHECKOUT=<checkout>] $0 [mini own main v2 ...]" >&2; exit 2; }
[ -n "${POLESTAR_JSREF:-}" ] || usage
cd "$(dirname "$0")/../../../.."
OUT=$POLESTAR_JSREF/guide
mkdir -p "$OUT"
BIN="rust/target/release/forge guide"
declare -A SRC=([mini]=rust/crates/forge-guide/tests/fixtures/mini [own]=guides [main]=$OUT/main-guides [v2]=$POLESTAR_JSREF/repaired)
case " ${*:-mini own main v2} " in
*" main "*)
	if [ ! -d "$OUT/main-guides" ]; then
		[ -n "${POLESTAR_CHECKOUT:-}" ] || usage
		cp -r "$POLESTAR_CHECKOUT/guides" "$OUT/main-guides"
	fi
	;;
esac
(cd rust && cargo build --release -q -p forge) || exit 2
status=0
for name in "${@:-mini own main v2}"; do
	for n in $name; do
		src=${SRC[$n]}
		ref=$OUT/ref-$n
		if [ ! -d "$ref" ] || [ "${REF:-0}" = 1 ]; then node rust/crates/forge-guide/tests/js-ref.js "$src" "$ref" || exit 2; fi
		rs=$OUT/rs-$n
		rm -rf "$rs"
		start=$(date +%s.%N)
		$BIN compile --guides "$src" --out "$rs/pack" --force --format json --time > "$rs.json" 2> "$rs.err"
		mkdir -p "$rs" && mv "$rs.json" "$rs/diagnostics.json"
		end=$(date +%s.%N)
		echo "== $n: rust $(grep '^time' "$rs.err")"
		if diff -rq "$ref" "$rs" > "$rs.diff"; then echo "   identical"; else status=1; sed 's/^/   /' "$rs.diff"; fi
	done
done
exit $status
