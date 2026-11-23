#!/usr/bin/env bash
# tools/ci-guide-texts.sh BASE LOCALES: the guide texts check (forge i18n guides check, docs/TRANSLATING.md "Guide
# texts") as CI runs it (docs/CI.md, "Guide texts"): a translation that drops or adds a line break or a name token, a
# stale translation, a file no guide has. LOCALES: "all", or the languages to check, space-separated (empty: nothing
# to check). Reads this checkout's data/forever and the client tables beside it ($FORGE: the forge binary).
# With BASE a checkout of the branch the change merges into, the same check runs there on the same data and only
# the errors BASE does not have fail: on the public data, some texts read differently from the release data's on
# both sides. With BASE empty (the release data), any error fails.
set -u
base=$1; locales=$2
[ -n "$locales" ] || { echo "Guide texts: no language's texts changed"; exit 0; }
[ "$locales" = all ] && locales=
tmp=$(mktemp -d)
# shellcheck disable=SC2086 # the languages are words
"$FORGE" i18n guides check $locales --root . --data "$PWD/data/forever" > "$tmp/head.txt" 2>&1
grep -v '^error: ' "$tmp/head.txt" | tail -n 12
grep '^error: ' "$tmp/head.txt" | sort -u > "$tmp/head-errors.txt"
if [ -z "$base" ]; then
	cp "$tmp/head-errors.txt" "$tmp/new.txt"
else
	mkdir -p "$base/data"
	ln -sfn "$PWD/data/forever" "$base/data/forever"
	ln -sfn "$PWD/data/sources" "$base/data/sources"
	# shellcheck disable=SC2086
	"$FORGE" i18n guides check $locales --root "$base" --data "$PWD/data/forever" 2>&1 | grep '^error: ' | sort -u > "$tmp/base-errors.txt"
	comm -13 "$tmp/base-errors.txt" "$tmp/head-errors.txt" > "$tmp/new.txt"
fi
if [ -s "$tmp/new.txt" ]; then
	echo "Guide texts: $(wc -l < "$tmp/new.txt") error(s)${base:+ the base does not have}:"
	cat "$tmp/new.txt"
	if [ "${GITHUB_ACTIONS:-}" = true ]; then
		sed -E 's/^error: ([^:]+): /::error file=\1::/' "$tmp/new.txt" | cut -c1-900
		{ echo '## Guide texts'; echo; sed 's/^/- /' "$tmp/new.txt" | head -n 100; echo; } >> "$GITHUB_STEP_SUMMARY"
	fi
	echo 'Fix the translations named (each keeps the English line breaks and {kind:id} tokens), or run forge i18n guides sync after a guide edit.'
	exit 1
fi
echo "Guide texts: ${locales:-every language}: no error${base:+ the base does not have}"
