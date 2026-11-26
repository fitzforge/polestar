#!/usr/bin/env bash
# tools/ci-route-gate.sh BASE CHANGED OUT: the route-integrity gate (#3654, docs/CI.md "Route integrity") for a change
# that edits leveling guides, against BASE (a checkout of the branch it merges into), on this checkout's
# data/forever. CHANGED: the changed paths, one a line. Writes OUT/route-integrity.md and exits 1 when a check fails:
#   1. playtest of the edited guides and the next 3 of each one's chain: nothing stuck or failing;
#   2. playtest --honest on both trees: no failing finding the base does not have (a lost prerequisite, an accept
#      the character cannot take, a hand-in with nothing to hand in...);
#   3. what the edited guides lose (tools/ci-route-gate.js removals): every quest that leaves the route is named in
#      the pull request's description ($PR_BODY);
#   4. the level model ($POLESTAR_GATES/model, one class) on both trees for the factions the chain belongs to: no
#      guide end reached more than 0.3 level lower.
# Needs $FORGE; the model needs $POLESTAR_GATES (the self-hosted runner's gate kit).
set -u
base=$1; changed=$2; out=$(realpath -m "$3")
mkdir -p "$out"
here=$(pwd)
gate() { node "$here/tools/ci-route-gate.js" "$@"; }
mapfile -t chain < <(gate chain "$base" "$changed" | sed '/^$/d')
if [ "${#chain[@]}" = 0 ]; then echo "Route integrity: no leveling guide edited" | tee "$out/route-integrity.md"; exit 0; fi
rc=0
md=$out/route-integrity.md
{ echo '## Route integrity'; echo; echo "Edited guides and the next 3 of their chains: ${chain[*]}"; echo; } > "$md"

# 1. The chain, played.
: > "$out/playtest.txt"
for id in "${chain[@]}"; do node tools/polestar.js playtest --filter "$id" >> "$out/playtest.txt" 2>&1 || rc=1; done
stuck=$(grep -E '^(stuck|fail) ' "$out/playtest.txt" || true)
{
	echo '### Playtest of the chain'; echo
	if [ -n "$stuck" ]; then echo '```'; echo "$stuck" | head -n 40; echo '```'; else echo "Every play of the ${#chain[@]} guides reaches the end."; fi
	echo
} >> "$md"

# 2. Honest playtest, both trees on the same data.
mkdir -p "$base/data"
[ -e "$base/data/forever" ] || ln -sfn "$here/data/forever" "$base/data/forever"
[ -e "$base/data/sources" ] || ln -sfn "$here/data/sources" "$base/data/sources"
node tools/polestar.js playtest --honest --format json > "$out/honest-head.json" 2> "$out/honest-head.err"
(cd "$base" && node tools/polestar.js playtest --honest --format json) > "$out/honest-base.json" 2> "$out/honest-base.err"
if [ -s "$out/honest-head.json" ] && [ -s "$out/honest-base.json" ]; then
	gate honest "$out/honest-base.json" "$out/honest-head.json" >> "$md" || rc=1
else
	{ echo '### Honest playtest'; echo; echo 'Could not play one of the trees:'; echo '```'; tail -n 5 "$out/honest-head.err" "$out/honest-base.err"; echo '```'; } >> "$md"
	rc=1
fi
echo >> "$md"

# 3. What the edited guides lose.
gate removals "$base" "$changed" --body-env PR_BODY >> "$md" || rc=1
echo >> "$md"

# 4. The level model, before and after, for the chain's factions (a shared guide: both).
factions=()
for id in "${chain[@]}"; do
	case "$id" in */horde/*) f=Horde ;; */alliance/*) f=Alliance ;; *) f=both ;; esac
	for x in $([ "$f" = both ] && echo Alliance Horde || echo "$f"); do [[ " ${factions[*]} " == *" $x "* ]] || factions+=("$x"); done
done
model=${POLESTAR_GATES:-}/model/run-rested.sh
if [ ! -x "$model" ]; then
	{ echo '### Levels at guide ends (level model)'; echo; echo 'The level model is not on this runner.'; } >> "$md"
	rc=1
else
	pids=()
	for f in "${factions[@]}"; do
		OUT=$out CLASSES=WARRIOR "$model" "head-$f" "$here/guides" "$f" > /dev/null 2>&1 & pids+=($!)
		OUT=$out CLASSES=WARRIOR "$model" "base-$f" "$base/guides" "$f" > /dev/null 2>&1 & pids+=($!)
	done
	for p in "${pids[@]}"; do wait "$p" || true; done
	for f in "${factions[@]}"; do
		if [ -s "$out/base-$f.json" ] && [ -s "$out/head-$f.json" ]; then
			echo "#### $f" >> "$md"
			gate levels "$out/base-$f.json" "$out/head-$f.json" | sed '1,2d' >> "$md" || rc=1
		else
			{ echo "#### $f"; echo; echo 'The level model did not finish:'; echo '```'; tail -n 5 "$out/head-$f.log" "$out/base-$f.log" 2>/dev/null; echo '```'; } >> "$md"
			rc=1
		fi
	done
fi
echo; cat "$md"
exit "$rc"
