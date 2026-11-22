#!/usr/bin/env bash
# tools/ci-tests.sh BASELINE FILE...: the Node tests in FILE... as ci.yml's Tests job runs them (docs/CI.md,
# "Reference data"). With BASELINE a file (next's failures on the same data, .ci/baseline.jsonl), only the failures
# it lacks fail the run (tools/ci-failures.js); with BASELINE empty, any failure does. FILE... may be globs node
# --test expands ("tests/**/*.test.js"). CI_TEST_CONCURRENCY caps the files run at once (default: node's).
# CI_BASE: the base checkout (a baseline without passing tests tells a new test by its name there); CI_UNSEEN_OK=1:
# a failure of a test next has not run only warns (this repository's own branches, which Release data checks).
set -u
baseline=$1; shift
conc=()
[ -n "${CI_TEST_CONCURRENCY:-}" ] && conc=(--test-concurrency="$CI_TEST_CONCURRENCY")
if [ -z "$baseline" ]; then
	exec node --test --test-timeout=900000 "${conc[@]}" "$@"
fi
out=${RUNNER_TEMP:-/tmp}/ci-failures-$$.jsonl
rc=0
node --test --test-timeout=900000 "${conc[@]}" --test-reporter=spec --test-reporter-destination=stdout \
	--test-reporter=./tools/ci-failures.js --test-reporter-destination="$out" "$@" || rc=$?
# A run that failed without a failing test (a crash, a timeout of the runner itself) has nothing to compare.
if [ "$rc" != 0 ] && ! grep -qv '"ok":true' "$out" 2>/dev/null; then echo "::error::node --test failed ($rc) with no failing test recorded"; exit "$rc"; fi
opts=()
[ "${GITHUB_ACTIONS:-}" = true ] && opts+=(--github)
[ "${CI_UNSEEN_OK:-}" = 1 ] && opts+=(--unseen-ok)
[ -n "${CI_BASE:-}" ] && [ -d "$CI_BASE" ] && opts+=(--base "$CI_BASE")
node tools/ci-failures.js compare "$baseline" "$out" "${opts[@]}"
