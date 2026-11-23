#!/usr/bin/env bash
# The timing budgets, enforced: every forge-addontest test holding a figure read off a clock to a budget
# (assert_timing!, crates/forge-addontest/src/timing.rs) and the Node tests doing the same (assertTiming,
# tests/helpers/timing.js), one at a time. CI only warns on them (POLESTAR_TIMING_BUDGETS=warn: GitHub's shared
# runners are neither quiet nor alike); the release gate runs this with nothing else on the machine
# (docs/RELEASING.md, step 3). The tests are found by their assert_timing!/assertTiming calls: a call in a #[test]
# function runs that test, a call in a helper runs its whole file.
#   rust/scripts/timing-budgets.sh          run them (the Node ones read data/forever: build it first)
#   rust/scripts/timing-budgets.sh --list   print the cargo test filters and the Node test files
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
DIR=rust/crates/forge-addontest/tests/addontest

# forge-addontest's filters: module::test, or module:: for a helper's file. A module is its file's (main.rs's
# `#[path = "<file>"] mod <name>;`, else the file's own name).
filters() {
	local f mod
	for f in $(grep -l 'assert_timing!' "$DIR"/*.rs | sort); do
		mod=$(awk -v file="$(basename "$f")" '/^#\[path = "/ { p = $0; sub(/^#\[path = "/, "", p); sub(/"\]$/, "", p); next } /^mod / && p == file { sub(/^mod /, ""); sub(/;$/, ""); print; exit } { p = "" }' "$DIR/main.rs")
		[ -n "$mod" ] || mod=$(basename "$f" .rs | tr - _)
		awk -v mod="$mod" '
			/^#\[test\]/ { test = 1; next }
			/^(pub )?fn [a-z0-9_]+/ { name = $0; sub(/^(pub )?fn /, "", name); sub(/[(<].*/, "", name); isTest = test; test = 0 }
			/^#\[/ { next }
			/assert_timing!/ && !seen[name]++ { print (isTest ? mod "::" name : mod "::") }
		' "$f"
	done | sort -u
}

NODE=$(grep -l 'assertTiming(' tests/*.test.js | grep -v -x tests/profile-budget.test.js | sort)

if [ "${1:-}" = --list ]; then
	filters
	echo "$NODE"
	exit 0
fi

unset POLESTAR_TIMING_BUDGETS
# shellcheck disable=SC2046
(cd rust && cargo test --profile quick --locked -p forge-addontest --test addontest -- --test-threads 1 $(filters))
# shellcheck disable=SC2086
node --test --test-concurrency=1 $NODE
