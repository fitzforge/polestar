#!/usr/bin/env bash
# Regenerates rust/tests/golden/engine/: forge-judge/tests/js/engine-chain.js (this checkout's addon on
# tests/lua/stub_world.lua through playtest.js's SIMULATE, lua5.1, stucks skipped) on temp copies of the
# clean guide slice (../guide/slice with ../honest/drop.json's lines blanked) and the data slice
# (../world/root/data/forever): orc.json, human.json (Warrior chains from 01-durotar and 01-elwynn-forest);
# fx-{warrior,mage}.json on engine_parity.rs's fixture guides (written to rust/target/judge-ref/engine-fixtures
# by its fixtures_* tests, run first); rilua-orc/: engine-program.js's Lua program of the Orc chain, its pack
# and files.json, with the repository and pack paths written as @REPO@ and @PACK@. Needs node, lua5.1 and
# cargo. Not run in CI. Run from anywhere: rust/tests/golden/engine/regen.sh
set -euo pipefail
cd "$(dirname "$0")/../../../.."
REPO=$PWD
G=$REPO/rust/tests/golden
JS=$REPO/rust/crates/forge-judge/tests/js
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
cp -r "$G/guide/slice" "$T/slice"
cp -r "$G/world/root/data/forever" "$T/forever"
node -e '
const fs = require("fs"), path = require("path"), d = JSON.parse(fs.readFileSync(process.argv[1], "utf8"));
for (const [f, ls] of Object.entries(d.lines)) {
	const p = path.join(process.argv[2], f), L = fs.readFileSync(p, "utf8").split("\n");
	for (const n of ls) L[n - 1] = "";
	fs.writeFileSync(p, L.join("\n"));
}' "$G/honest/drop.json" "$T/slice"
unset POLESTAR_GRID NAV4_PACK POLESTAR_CHECKOUT
node "$JS/engine-chain.js" "$T/slice" forever/horde/orc-troll/01-durotar.guide Orc Horde WARRIOR "$T/forever" "$G/engine/orc.json" skip
node "$JS/engine-chain.js" "$T/slice" forever/alliance/human/01-elwynn-forest.guide Human Alliance WARRIOR "$T/forever" "$G/engine/human.json" skip
# (The slice_fixtures_* tests write the fixture guides first, then compare with the goldens this script
# is about to replace: that comparison may fail here, so only the written guides are checked.)
(cd rust && cargo test -q --profile quick -p forge-judge --test judge -- --exact engine_parity::slice_fixtures_warrior engine_parity::slice_fixtures_mage >/dev/null 2>&1 || true)
test -f "$REPO/rust/target/judge-ref/engine-fixtures/forever/alliance/fx/01-a.guide"
FX=$REPO/rust/target/judge-ref/engine-fixtures
node "$JS/engine-chain.js" "$FX" forever/alliance/fx/01-a.guide Human Alliance WARRIOR "$T/forever" "$G/engine/fx-warrior.json" skip
node "$JS/engine-chain.js" "$FX" forever/alliance/fx/01-a.guide Human Alliance MAGE "$T/forever" "$G/engine/fx-mage.json" skip
node "$JS/engine-program.js" "$T/rilua-orc" "$T/slice" forever/horde/orc-troll/01-durotar.guide Orc Horde WARRIOR "$T/forever" skip
rm -rf "$G/engine/rilua-orc"
mkdir -p "$G/engine/rilua-orc"
cp -r "$T/rilua-orc/pack" "$T/rilua-orc/files.json" "$G/engine/rilua-orc/"
node -e '
const fs = require("fs"), [dir, repo, out] = process.argv.slice(1);
const p = fs.readFileSync(`${dir}/program.lua`, "utf8").split(`${dir}/pack`).join("@PACK@").split(repo).join("@REPO@");
const left = p.match(/\/(home|tmp)\/[^"\s]*/g);
if (left) throw new Error(`paths left in program.lua: ${left.slice(0, 3)}`);
fs.writeFileSync(`${out}/program.lua`, p);' "$T/rilua-orc" "$REPO" "$G/engine/rilua-orc"
