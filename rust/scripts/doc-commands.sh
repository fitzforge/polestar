#!/usr/bin/env bash
# The documentation's commands must run: every forge command's --help, and every fenced block in
# docs/FORGE.md and docs/forge/*.md marked with a `<!-- ci -->` line just before it (blocks that
# need no game client, data or network). Usage: rust/scripts/doc-commands.sh [path/to/forge]
set -uo pipefail
FORGE=$(realpath "${1:-$(git rev-parse --show-toplevel)/rust/target/release/forge}" 2>/dev/null)
cd "$(git rev-parse --show-toplevel)"
[ -x "$FORGE" ] || { echo "no forge binary at $FORGE (cargo build --release -p forge)"; exit 2; }
BIN=$(mktemp -d)
trap 'rm -rf "$BIN"' EXIT
ln -s "$FORGE" "$BIN/forge"
export PATH="$BIN:$PATH"
fail=0
run() {
	local what=$1
	shift
	if out=$("$@" 2>&1); then
		echo "ok    $what"
	else
		echo "FAIL  $what (exit $?)"
		echo "$out" | head -20 | sed 's/^/      /'
		fail=1
	fi
}

for args in "--help" "--version" "build --help" "data pack --help" "data fetch --help" "data build --help" \
	"doctor --help" "data --help" "gamedata --help" "guide --help" "judge --help" "judge report --help" \
	"judge seed-tests --help" "judge route-status --help" "judge feedback --help" "nav --help" "nav prepare --help" "sim --help" "walks --help" "writer --help" \
	"release --help" "release pack --help" "release version --help" "release notes --help" "release credits --help" "changelog --help" "i18n --help"; do
	# shellcheck disable=SC2086
	run "forge $args" forge $args
done

for doc in docs/FORGE.md docs/forge/*.md; do
	while read -r block; do
		while IFS= read -r line; do
			line=${line%%#*}
			[ -z "${line// /}" ] && continue
			run "$doc: $line" bash -c "$line"
		done < "$block"
		rm -f "$block"
	done < <(BIN=$BIN awk '
		/^<!-- ci -->[[:space:]]*$/ { want = 1; next }
		want && /^```(sh|bash)?[[:space:]]*$/ { inblock = 1; want = 0; n++; out = ENVIRON["BIN"] "/" n ".sh"; printf "" > out; next }
		inblock && /^```[[:space:]]*$/ { inblock = 0; close(out); print out; fflush(); next }
		inblock { print > out; next }
		{ want = 0 }
	' "$doc")
done
exit $fail
