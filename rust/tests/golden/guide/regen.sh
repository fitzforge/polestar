#!/usr/bin/env bash
# Regenerates rust/tests/golden/guide/expected/<name> with the JS compiler (tools/lib/dsl through
# rust/crates/forge-guide/tests/js-ref.js) of the checkout given as $JS_ROOT (default: this one),
# on the committed inputs and the committed data slice rust/tests/golden/world/root/data/forever.
# Not run in CI. Run from anywhere: rust/tests/golden/guide/regen.sh
set -eu
cd "$(dirname "$0")/../../../.."
JS_ROOT=${JS_ROOT:-$PWD}
G=rust/tests/golden/guide
for pair in "mini rust/crates/forge-guide/tests/fixtures/mini" "slice $G/slice"; do
	set -- $pair
	node "$JS_ROOT/rust/crates/forge-guide/tests/js-ref.js" "$2" "$G/expected/$1" --data rust/tests/golden/world/root/data/forever
done
