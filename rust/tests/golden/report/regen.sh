#!/usr/bin/env bash
# Regenerates rust/tests/golden/report/: the inputs and the JS references of forge-judge/tests/report_parity.rs
# `report_equals_the_js_scripts_on_the_slice`. All of it is built in a temp tree:
#   - root: a copy of ../world/root with an empty knowledge base (synthetic: the tables forge reads, no rows)
#     and guides/ = the clean guide slice (../guide/slice with ../honest/drop.json's lines blanked);
#   - sim: the golden slice worlds (../world/expected) and ../sim/params.json;
#   - inputs (Rust): `forge sim route --walks off` for Orc and Human (the route doc cut to faction and
#     start, and its judge-improved goal stream), `forge writer apply-route` into the clean slice (the
#     guides it rewrote);
#   - references (JS, the route loop's scripts in js/, on the v2-route judge tree <v2-route>@5af7bbbd6,
#     its data/ the data slice): gmeasure.js (v1 and written, to 30 and 61), sdiff.js (the stream against
#     the written walk), honest-ref.js + honest-sum.js (fail findings of the race on the chain).
# Not run in CI. usage: rust/tests/golden/report/regen.sh <v2-route checkout> [forge binary]
set -euo pipefail
V2=$(cd "${1:?usage: regen.sh <v2-route checkout> [forge binary]}" && pwd)
cd "$(dirname "$0")/../../../.."
REPO=$PWD
FORGE=$(realpath "${2:-rust/target/release/forge}")
G=$REPO/rust/tests/golden
OUT=$G/report
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
unset POLESTAR_GRID NAV4_PACK POLESTAR_KB
export POLESTAR_CAS=off POLESTAR_CAS_SKIP=walks

# root, the clean slice, the empty knowledge base, the sim dirs (one for forge, one for the JS)
cp -r "$G/world/root" "$T/root"
cp -r "$G/guide/slice" "$T/root/guides"
node -e '
const fs = require("fs"), path = require("path"), d = JSON.parse(fs.readFileSync(process.argv[1], "utf8"));
for (const [f, ls] of Object.entries(d.lines)) {
	const p = path.join(process.argv[2], f), L = fs.readFileSync(p, "utf8").split("\n");
	for (const n of ls) L[n - 1] = "";
	fs.writeFileSync(p, L.join("\n"));
}' "$G/honest/drop.json" "$T/root/guides"
mkdir -p "$T/root/data/local/kb"
node -e '
const { DatabaseSync } = require("node:sqlite");
new DatabaseSync(process.argv[1]).exec(`create table facts (kind text, id integer, field text, value text, source text, confidence text, agree integer, total integer);
create table verify_in_game (kind text, id integer, conflicts text);
create table mechanics (quest integer, kind text, status text, source text, confidence text, drives integer, sources text);
create table steps (quest integer, n integer, action text, target_kind text, target integer, item integer, fact text, drives integer);`);' "$T/root/data/local/kb/forever-kb.sqlite"
for d in sim simjs; do
	mkdir -p "$T/$d"
	for f in horde alliance; do gunzip -c "$G/world/expected/world-$f.json.gz" > "$T/$d/world-$f.json"; done
	cp "$G/sim/params.json" "$T/$d/"
done
export POLESTAR_GRID=$T/root/data/local/nav4

# inputs: forge's routes and written guides
rm -rf "$OUT/route" "$OUT/written"
mkdir -p "$T/out" "$OUT/route" "$OUT/written"
for s in "Horde Orc horde" "Alliance Human alliance"; do
	set -- $s
	(cd "$T/root" && "$FORGE" sim route --faction "$1" --start "$2" --out "$T/out/$2.json" --root "$T/root" --world-dir "$T/sim" --walks off --threads 4 | tail -1)
	"$FORGE" writer apply-route "$T/out/$2.json" --world "$T/sim/world-$3.json" --out "$T/written/$2" --root "$T/root" | tail -1
	node -e 'const d = require(process.argv[1]); require("fs").writeFileSync(process.argv[2], JSON.stringify({ faction: d.faction, start: d.start }) + "\n");' "$T/out/$2.json" "$OUT/route/$2.json"
	gzip -9 -n -c "$T/out/$2.judge-improved.json" > "$OUT/route/$2.judge-improved.json.gz"
	(cd "$T/written/$2" && find . -name '*.guide' | sort | while read -r f; do
		cmp -s "$f" "$T/root/guides/$f" || { mkdir -p "$OUT/written/$2/$(dirname "$f")"; cp "$f" "$OUT/written/$2/$f"; }
	done)
done

# references: the v2-route judge tree on the data slice
mkdir -p "$T/jr/data" "$T/jr/tests" "$T/ref"
git -C "$V2" archive 5af7bbbd6 tools tests/helpers | tar -x -C "$T/jr"
cp -r "$G/world/root/data/forever" "$G/world/root/data/sources" "$T/jr/data/"
export JUDGE_ROOT=$T/jr SIM=$T/simjs N=0 J=0
for s in "Horde Orc" "Alliance Human"; do
	set -- $s
	for t in "v1 $T/root/guides" "written $T/written/$2"; do
		set -- "$1" "$2" $t
		for to in 30 61; do node "$OUT/js/gmeasure.js" "$4" "$1" "$2" - "$to" --json "$T/ref/gm.json" >/dev/null; node -e 'const d = require(process.argv[1]); console.log(JSON.stringify({ chain: process.argv[2], ...d.row, guides: undefined }));' "$T/ref/gm.json" "$3" >> "$T/ref/rows-$2.jsonl"; done
		POLESTAR_HONEST_JS=$T/jr node rust/crates/forge-judge/tests/js/honest-ref.js "$4" - "$T/ref/honest.json" --data "$T/jr/data/forever" --kb "$T/root/data/local/kb/forever-kb.sqlite"
		JSON_OUT=$T/ref/hsum-$2-$3.json node "$OUT/js/honest-sum.js" "$T/ref/honest.json" "$1" "$2" "$4" >/dev/null
	done
	JSON_OUT=$T/ref/sdiff-$2.json node "$OUT/js/sdiff.js" "$1" "$2" "$T/out/$2.judge-improved.json" "$T/written/$2" >/dev/null
	node -e '
const fs = require("fs"), [dir, race, out] = process.argv.slice(1);
const rows = fs.readFileSync(`${dir}/rows-${race}.jsonl`, "utf8").trim().split("\n").map(JSON.parse);
const sum = (f) => Object.values(JSON.parse(fs.readFileSync(f, "utf8")).own).reduce((a, b) => a + b, 0);
fs.writeFileSync(out, JSON.stringify({ rows, honest: { v1: sum(`${dir}/hsum-${race}-v1.json`), written: sum(`${dir}/hsum-${race}-written.json`) }, stream: JSON.parse(fs.readFileSync(`${dir}/sdiff-${race}.json`, "utf8")) }, null, 1) + "\n");' "$T/ref" "$2" "$OUT/$2.ref.json"
done
for f in horde alliance; do
	gunzip -c "$G/world/expected/world-$f.json.gz" | cmp -s - "$T/simjs/world-$f.json" || { echo "the JS rebuilt the $f world" >&2; exit 1; }
done
