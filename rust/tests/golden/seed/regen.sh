#!/usr/bin/env bash
# Regenerates rust/tests/golden/seed/slice.tsv: `node --test` of v1's tests/guides-reported.test.js and
# tests/guides-caves.test.js (from the v1 checkout given as the argument) in a temp copy of this checkout
# (tools/, tests/, addon/) whose guides/ is the clean guide slice (../guide/slice with ../honest/drop.json's
# lines blanked) and whose data/ is the data slice (../world/root/data). One line per top-level test:
# `ok` or `not ok`, a tab, the name as the TAP prints it. Needs lua5.1. Not run in CI.
# usage: rust/tests/golden/seed/regen.sh <v1 checkout>
set -euo pipefail
V1=$(cd "${1:?usage: regen.sh <v1 checkout>}" && pwd)
cd "$(dirname "$0")/../../../.."
REPO=$PWD
G=$REPO/rust/tests/golden
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
cp -r tools tests addon "$T/"
cp "$V1/tests/guides-reported.test.js" "$V1/tests/guides-caves.test.js" "$T/tests/"
cp -r "$G/guide/slice" "$T/guides"
mkdir -p "$T/data"
cp -r "$G/world/root/data/forever" "$G/world/root/data/sources" "$T/data/"
node -e '
const fs = require("fs"), path = require("path"), d = JSON.parse(fs.readFileSync(process.argv[1], "utf8"));
for (const [f, ls] of Object.entries(d.lines)) {
	const p = path.join(process.argv[2], f), L = fs.readFileSync(p, "utf8").split("\n");
	for (const n of ls) L[n - 1] = "";
	fs.writeFileSync(p, L.join("\n"));
}' "$G/honest/drop.json" "$T/guides"
export POLESTAR_CAS=off POLESTAR_GRID=$T/data/local/nav4
unset NAV4_PACK
(cd "$T" && node --test --test-reporter=tap --test-concurrency=1 tests/guides-reported.test.js tests/guides-caves.test.js > tap.txt 2>&1 || true)
node -e '
const out = [];
for (const l of require("fs").readFileSync(process.argv[1], "utf8").split("\n")) {
	const m = /^(not ok|ok) \d+ - (.*)$/.exec(l);
	if (m) out.push(`${m[1]}\t${m[2]}`);
}
if (!out.length) throw new Error("no TAP results");
require("fs").writeFileSync(process.argv[2], out.join("\n") + "\n");
console.error(`${out.length} tests`);' "$T/tap.txt" "$G/seed/slice.tsv"
