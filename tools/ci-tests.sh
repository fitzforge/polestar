#!/usr/bin/env bash
# tools/ci-tests.sh BASELINE FILE...: the Node tests in FILE... as ci.yml's Tests job runs them (docs/CI.md,
# "Reference data"). With BASELINE a file (next's failures on the same data, .ci/baseline.jsonl), only the failures
# it lacks fail the run (tools/ci-failures.js); with BASELINE empty, any failure does. FILE... may be globs node
# --test expands ("tests/**/*.test.js"). CI_TEST_CONCURRENCY caps the files run at once (default: node's).
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
if [ "$rc" != 0 ] && [ ! -s "$out" ]; then echo "::error::node --test failed ($rc) with no failing test recorded"; exit "$rc"; fi
gh=()
[ "${GITHUB_ACTIONS:-}" = true ] && gh=(--github)
node tools/ci-failures.js compare "$baseline" "$out" "${gh[@]}"
