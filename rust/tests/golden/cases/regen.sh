#!/usr/bin/env bash
# Regenerates rust/tests/golden/cases/cases-<start>.json.gz: forge-judge/tests/js/cases-dump.js (the
# JS_ROOT checkout's tools/lib/sim/cases.js checkCase on tests/fixtures/sim/cases/reported.json) on the greedy v2
# smooth2 route (`sim route --no-walks`) of Orc Warrior and Human Warrior in the golden slice worlds
# (../world/expected) with ../sim/params.json, data ../world/root/data. Everything runs in a temp tree: a
# copy of $JS_ROOT's tools/ and tests/{fixtures,helpers}, the data slice and the worlds. One patch in
# the copy: v2Setup compiles only the rules.json rules the slice world can check (36 of 39 name quests the
# slice lacks, and compileV2 fails closed on them); the world keeps every rule, so its hash stays the
# golden one. Not run in CI. JS_ROOT is required: a checkout before the JS retirement (e.g. 734380d2a),
# since this one has neither cases.js, `sim route` nor cases-dump.js.
# Run from anywhere: JS_ROOT=<checkout at 734380d2a> rust/tests/golden/cases/regen.sh
set -euo pipefail
if [ -z "${JS_ROOT:-}" ]; then
	echo "usage: JS_ROOT=<checkout at 734380d2a> rust/tests/golden/cases/regen.sh" >&2
	exit 2
fi
JS=$(cd "$JS_ROOT" && pwd)
cd "$(dirname "$0")/../../../.."
REPO=$PWD
G=$REPO/rust/tests/golden
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
mkdir -p "$T/tests" "$T/data" "$T/sim" "$T/out"
cp -r "$JS/tools" "$T/"
cp -r "$JS/tests/fixtures" "$JS/tests/helpers" "$T/tests/"
cp -r "$G/world/root/data/forever" "$G/world/root/data/sources" "$T/data/"
for f in horde alliance; do gunzip -c "$G/world/expected/world-$f.json.gz" > "$T/sim/world-$f.json"; done
cp "$G/sim/params.json" "$T/sim/"
ln -s sim "$T/simdir"
node -e '
const fs = require("fs"), f = process.argv[1];
const was = "rules: rules.loadRules() }));";
const s = fs.readFileSync(f, "utf8");
if (!s.includes(was)) throw new Error("v2Setup patch: line not found");
fs.writeFileSync(f, s.replace(was, "rules: ((all) => { const bad = new Set(rules.checkRules(all, world).errors.map((e) => e.id)); return all.filter((r) => !bad.has(r.id)); })(rules.loadRules()) }));"));
' "$T/tools/commands/sim.js"
cat > "$T/drive-env.js" <<'EOF'
process.chdir(__dirname);
Object.assign(require('./tools/lib/sim/index').DEFAULTS, { simDir: `${__dirname}/sim`, offline: true });
EOF
export POLESTAR_CAS=off POLESTAR_GRID=$T/data/local/nav4
unset NAV4_PACK
(cd "$T" && for s in "Horde Orc" "Alliance Human"; do set -- $s; node tools/polestar.js sim route --faction "$1" --race "$2" --class Warrior --no-walks --offline --sim "$T/sim" | head -2; done)
POLESTAR_JSREF=$T POLESTAR_JS=$T POLESTAR_CHECKOUT=$T node "$JS/rust/crates/forge-judge/tests/js/cases-dump.js" "$T/out"
for f in horde alliance; do
	gunzip -c "$G/world/expected/world-$f.json.gz" | cmp -s - "$T/sim/world-$f.json" || { echo "the JS rebuilt the $f world" >&2; exit 1; }
done
for n in horde-orc-warrior alliance-human-warrior; do gzip -9 -n -c "$T/out/cases-$n.json" > "$G/cases/cases-$n.json.gz"; done
