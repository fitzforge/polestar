#!/usr/bin/env bash
# Measures a walking-graph PR against today's nav, on evidence (data/local/research/NavAcceptance.md).
#
#   judge-pr.sh <pr-number> [--keep] [--skip-tests] [--skip-broad] [--rebaseline]
#
# 1. checks the PR out in a temp worktree on disk (../lodestar-pr-<n>; removed at the end unless --keep), with
#    data/forever, data/sources, data/sim and data/local/{nav3,nav4,nav-layers} linked from the main checkout;
# 2. the shipped size: addon/Polestar_Nav and every addon folder the PR adds (MB, files, the largest files), against
#    next's;
# 3. the nav eval corpus (routes.json, the 21 expectations, with A1-A8 against the baseline) and the acceptance set
#    (acceptance.json: the reported walks, the underworld caves, the chokepoint walks) through the eval harness on the
#    PR's Polestar_Nav: per route pass/fail against today's, the harness's load ms and Lua KB after loading both
#    continents (packed) and during searches; today's maps are measured again in the same session, so the times
#    compare;
# 4. the broad sample (broad.js: 2,000 random quest-point pairs, both continents): routed %, detour median/p95, drops,
#    solid-ground vertices, cliffs, search ms median/p95, against today's maps run again just before it with the same
#    number of harness processes;
# 5. the PR's Nav/Chokepoints.lua (chokecheck.js): counts by kind against today's, lift pairs, bridge sides, entries
#    off our grid, the curated passages players use, and today's passages the PR's drawn lines pass that it lacks;
# 6. the nav tests in the PR's tree (forge-addontest's nav, travel and heights tests) and the planner acceptance cases
#    (nav-e2e.rs's ignored "acceptance" tests, added to the PR's copy when it lacks them), against the baseline's failures.
# The tools come from the nav/acceptance worktree (TOOLS); when the PR changes tools/lib/nav/eval, the acceptance
# branch's changes are applied onto the PR's tree and its own harness is used instead. Reports: $OUT (small JSON and
# REPORT.md). Multi-worker steps run through $HEAVY (a nav folder over 200 MB, and the tests) or $LIGHT when those
# lane scripts exist (/tmp/ctl/heavy.sh, light.sh by default), else directly. MAIN and TOOLS default to this checkout.
set -uo pipefail

PR=${1:?usage: judge-pr.sh <pr-number> [--keep] [--skip-tests] [--skip-broad] [--rebaseline]}
shift
KEEP=0 SKIP_TESTS=0 SKIP_BROAD=0 REBASE=0
for a in "$@"; do
	case $a in
	--keep) KEEP=1 ;;
	--skip-tests) SKIP_TESTS=1 ;;
	--skip-broad) SKIP_BROAD=1 ;;
	--rebaseline) REBASE=1 ;;
	*) echo "unknown option $a" >&2; exit 2 ;;
	esac
done

HERE=$(git -C "$(dirname "$0")" rev-parse --show-toplevel)
MAIN=${MAIN:-$HERE}
TOOLS=${TOOLS:-$HERE}
BASE=${BASE:-/tmp/navaccept}
OUT=$BASE/pr-$PR
WT=$(dirname "$MAIN")/lodestar-pr-$PR
HEAVY=${HEAVY-/tmp/ctl/heavy.sh}
LIGHT=${LIGHT-/tmp/ctl/light.sh}
[ -n "$HEAVY" ] && [ ! -x "$HEAVY" ] && HEAVY=
[ -n "$LIGHT" ] && [ ! -x "$LIGHT" ] && LIGHT=
mkdir -p "$OUT"
REPORT=$OUT/REPORT.md
: >"$REPORT"
say() { echo "$*" | tee -a "$REPORT"; }
note() { echo "judge: $*" >&2; }

# The nav tests of the current tree (forge-addontest, the ignored acceptance cases included), one "<ok|FAILED|ignored>
# <name>" line each, into <out>.
navtests() { # <out>
	(cd rust && $HEAVY cargo test --profile quick --locked -p forge-addontest --test addontest -- --include-ignored nav travel heights journey) 2>&1 |
		sed -nE 's/^test (.*) \.\.\. (ok|FAILED|ignored)$/\2 \1/p' | sort -u >"$1"
}

link_data() { # <tree>
	local t=$1
	mkdir -p "$t/data/local"
	for d in forever sources sim; do [ -e "$t/data/$d" ] || ln -s "$MAIN/data/$d" "$t/data/$d"; done
	for d in nav3 nav4 nav-layers; do [ -e "$t/data/local/$d" ] || ln -s "$MAIN/data/local/$d" "$t/data/local/$d"; done
}

# Baselines (today's nav: the TOOLS tree's addon/Polestar_Nav, next plus the acceptance tooling).
baseline() {
	link_data "$TOOLS"
	cd "$TOOLS" || exit 1
	if [ $REBASE = 1 ] || [ ! -s "$BASE/base-eval.json" ]; then node tools/polestar.js nav eval --out "$BASE/base-eval.json" >"$BASE/base-eval.txt" 2>&1; fi
	if [ $REBASE = 1 ] || [ ! -s "$BASE/base-accept.json" ]; then node tools/polestar.js nav eval --routes tools/lib/nav/eval/acceptance.json --out "$BASE/base-accept.json" >"$BASE/base-accept.txt" 2>&1; fi
	if [ $SKIP_BROAD = 0 ]; then
		[ -s "$BASE/pairs.json" ] || node tools/lib/nav/eval/broad.js sample --per 1000 --out "$BASE/pairs.json"
		if [ $REBASE = 1 ] || [ ! -s "$BASE/base-broad.json" ]; then $LIGHT node tools/lib/nav/eval/broad.js run --nav addon/Polestar_Nav --pairs "$BASE/pairs.json" --workers 4 --out "$BASE/base-broad.json" >"$BASE/base-broad.txt" 2>&1; fi
	fi
	if [ $SKIP_TESTS = 0 ] && { [ $REBASE = 1 ] || [ ! -s "$BASE/base-tests.txt" ]; }; then
		navtests "$BASE/base-tests.txt"
	fi
}

# The failing tests of a navtests file (the open acceptance cases apart), one name per line.
failing() { grep '^FAILED ' "$1" | cut -d' ' -f2- | grep -v '::acceptance_' | sort -u; }
tapcount() { awk '$1=="ok"{p++} $1=="FAILED"{f++} END{print "pass " p+0 ", fail " f+0}' "$1"; }

mb() { du -sm "$1" 2>/dev/null | cut -f1; }

note "baselines in $BASE"
baseline

# 1. The PR in a worktree.
cd "$MAIN" || exit 1
git fetch -q origin "pull/$PR/head:refs/remotes/origin/pr/$PR" || { echo "cannot fetch PR $PR" >&2; exit 1; }
git fetch -q origin next
if [ -d "$WT" ]; then git worktree remove --force "$WT" 2>/dev/null || rm -rf "$WT"; git worktree prune; fi
git worktree add -q --detach "$WT" "origin/pr/$PR" || exit 1
cd "$WT" || exit 1
if grep -qs 'filter=lfs' .gitattributes; then note "git lfs pull"; git lfs pull >/dev/null 2>&1 || note "git lfs pull failed"; fi
link_data "$WT"
HEAD_SHA=$(git rev-parse --short HEAD)
MB=$(git merge-base HEAD origin/next)

say "# Nav PR #$PR ($HEAD_SHA) against next ($(git rev-parse --short origin/next)), $(date '+%Y-%m-%d %H:%M')"
say ""
say "$(gh pr view "$PR" --json title,author,additions,deletions,changedFiles --jq '"\(.title) by \(.author.login): \(.changedFiles) files, +\(.additions) -\(.deletions)"' 2>/dev/null)"
say ""

# 2. Shipped size.
say "## Shipped size"
say ""
NEW_ADDONS=$(git diff --name-only --diff-filter=A "$MB" HEAD -- addon | cut -d/ -f2 | sort -u | while read -r d; do git cat-file -e "origin/next:addon/$d" 2>/dev/null || echo "$d"; done)
say "| folder | next MB | PR MB | PR files |"
say "|---|---|---|---|"
for d in Polestar_Nav $NEW_ADDONS; do
	say "| addon/$d | $(mb "$TOOLS/addon/$d" || echo 0) | $(mb "$WT/addon/$d") | $(find "$WT/addon/$d" -type f 2>/dev/null | wc -l) |"
done
say "| addon/ (all) | $(mb "$TOOLS/addon") | $(mb "$WT/addon") | $(find "$WT/addon" -type f | wc -l) |"
NEW_DATA=$(git diff --name-only --diff-filter=A "$MB" HEAD | grep -v '^addon/' | cut -d/ -f1-2 | sort | uniq -c | sort -rn | head -8)
say ""
say "New files outside addon/ (by folder): $(echo "$NEW_DATA" | awk '{printf "%s %s; ", $2, $1}')"
say ""
say "Largest files in the PR's addon folders:"
say '```'
for d in Polestar_Nav $NEW_ADDONS; do find "$WT/addon/$d" -type f -printf '%s %p\n' 2>/dev/null; done | sort -rn | head -12 | awk -v wt="$WT/" '{sub(wt, "", $2); printf "%8.1f MB  %s\n", $1 / 1048576, $2}' | tee -a "$REPORT"
say '```'
say "Polestar_Nav.toc: $(grep -E '^## (LoadOnDemand|SavedVariables|Dependencies|RequiredDeps|Interface)' "$WT/addon/Polestar_Nav/Polestar_Nav.toc" 2>/dev/null | tr '\n' ' ')"
say ""

# Which tools judge it: ours (on the PR's Polestar_Nav), or the PR's tree with the acceptance changes applied.
RUN=$TOOLS
if [ -n "$(git diff --name-only "$MB" HEAD -- tools/lib/nav/eval)" ]; then
	note "the PR changes tools/lib/nav/eval: applying the acceptance branch onto its tree"
	if (cd "$TOOLS" && git diff origin/next -- tools/lib/nav/eval tests/nav-eval.test.js) | git apply --3way --whitespace=nowarn; then
		RUN=$WT
	else
		note "the acceptance changes do not apply; judging with the acceptance tools on its maps"
	fi
fi
say "Judged with the eval tools of: $RUN"
say ""
NAV=$WT/addon/Polestar_Nav
NAVMB=$(mb "$NAV")
LANE=$LIGHT
[ "${NAVMB:-0}" -gt 200 ] && LANE=$HEAVY

# 3. The eval corpus and the acceptance set.
cd "$RUN" || exit 1
note "nav eval on today's maps and on the PR (routes.json, acceptance.json)"
$LANE sh -c "node tools/polestar.js nav eval --nav '$TOOLS/addon/Polestar_Nav' --out '$OUT/base-eval.json' >'$OUT/base-eval.txt' 2>&1; \
	node tools/polestar.js nav eval --nav '$NAV' --baseline '$OUT/base-eval.json' --out '$OUT/eval.json' >'$OUT/eval.txt' 2>&1; \
	node tools/polestar.js nav eval --nav '$TOOLS/addon/Polestar_Nav' --routes tools/lib/nav/eval/acceptance.json --out '$OUT/base-accept.json' >'$OUT/base-accept.txt' 2>&1; \
	node tools/polestar.js nav eval --nav '$NAV' --routes tools/lib/nav/eval/acceptance.json --out '$OUT/accept.json' >'$OUT/accept.txt' 2>&1"
[ -s "$OUT/base-eval.json" ] || cp "$BASE/base-eval.json" "$OUT/base-eval.json"
[ -s "$OUT/base-accept.json" ] || cp "$BASE/base-accept.json" "$OUT/base-accept.json"
say "## Acceptance set (reported walks, underworld caves)"
say ""
if [ -s "$OUT/accept.json" ]; then node tools/lib/nav/eval/verdicts.js "$OUT/base-accept.json" "$OUT/accept.json" | tee -a "$REPORT" >/dev/null; else say "The harness did not run on the PR's maps: $(tail -3 "$OUT/accept.txt")"; fi
say ""
say "## nav eval corpus (the 21 expectations; A1-A8 against the baseline)"
say ""
if [ -s "$OUT/eval.json" ]; then
	node tools/lib/nav/eval/verdicts.js "$OUT/base-eval.json" "$OUT/eval.json" | tail -3 | tee -a "$REPORT" >/dev/null
	say ""
	say '```'
	grep -E '^(A[0-9]|balanced|nav eval: (no|an) acceptance)' "$OUT/eval.txt" | tee -a "$REPORT" >/dev/null
	say '```'
	say ""
	node tools/lib/nav/eval/verdicts.js "$OUT/base-eval.json" "$OUT/eval.json" | grep -E '\| (pass|FAIL|n/a) \| \*\*' | tee -a "$REPORT" >/dev/null
else
	say "The harness did not run on the PR's maps: $(tail -3 "$OUT/eval.txt")"
fi
say ""

# 4. The broad sample.
if [ $SKIP_BROAD = 0 ]; then
	W=$(node tools/lib/nav/eval/broad.js workers --nav "$NAV")
	[ "$LANE" = "$LIGHT" ] && [ "$W" -gt 4 ] && W=4 # the light lane: at most 4 workers
	note "broad sample on today's maps then the PR, $W harness processes each (lane $(basename "$LANE"))"
	$LANE sh -c "node tools/lib/nav/eval/broad.js run --nav '$TOOLS/addon/Polestar_Nav' --pairs '$BASE/pairs.json' --workers $W --out '$OUT/base-broad.json' >'$OUT/base-broad.txt' 2>&1; \
		node tools/lib/nav/eval/broad.js run --nav '$NAV' --pairs '$BASE/pairs.json' --workers $W --out '$OUT/broad.json' >'$OUT/broad.txt' 2>&1"
	[ -s "$OUT/base-broad.json" ] || cp "$BASE/base-broad.json" "$OUT/base-broad.json"
	say "## Broad sample: $(node -e 'const p=require(process.argv[1]);console.log(`${p.pairs.length} quest-point pairs, ${p.min}-${p.max} yd apart, seed ${p.seed}`)' "$BASE/pairs.json")"
	say ""
	if [ -s "$OUT/broad.json" ]; then node tools/lib/nav/eval/broad.js compare "$OUT/base-broad.json" "$OUT/broad.json" | tee -a "$REPORT" >/dev/null; else say "Did not run: $(tail -3 "$OUT/broad.txt")"; fi
	say ""
fi

# 5. Chokepoints.
say "## Chokepoints (Nav/Chokepoints.lua)"
say ""
LINES="$OUT/accept.json,$OUT/eval.json"
[ -s "$OUT/broad.json" ] && LINES="$LINES,$OUT/broad.json"
node tools/lib/nav/eval/chokecheck.js --nav "$NAV" --ref "$TOOLS/addon/Polestar_Nav" --lines "$LINES" 2>&1 | tee -a "$REPORT" >/dev/null
say ""

# 6. Tests.
if [ $SKIP_TESTS = 0 ]; then
	cd "$WT" || exit 1
	E2E=rust/crates/forge-addontest/tests/addontest/nav-e2e.rs
	if ! grep -q 'nav acceptance: the planner' "$E2E"; then
		sed -n '/^\/\/ ---- nav acceptance: the planner/,$p' "$TOOLS/$E2E" >>"$E2E"
		ADDED=" (the acceptance block added to the PR's copy)"
	fi
	note "nav tests in the PR's tree"
	navtests "$OUT/tests.txt"
	say "## Nav tests"
	say ""
	say "next: $(tapcount "$BASE/base-tests.txt"); PR: $(tapcount "$OUT/tests.txt")"
	NEWFAIL=$(comm -13 <(failing "$BASE/base-tests.txt") <(failing "$OUT/tests.txt"))
	FIXED=$(comm -23 <(failing "$BASE/base-tests.txt") <(failing "$OUT/tests.txt"))
	say ""
	say "Failing on the PR, not on next: ${NEWFAIL:-none}"
	say ""
	say "Failing on next, passing on the PR: ${FIXED:-none}"
	say ""
	say "Planner acceptance cases${ADDED:-}:"
	say '```'
	grep '::acceptance_' "$OUT/tests.txt" | tee -a "$REPORT" >/dev/null
	say '```'
fi

if [ $KEEP = 0 ]; then
	cd "$MAIN" && git worktree remove --force "$WT" && git worktree prune
else
	note "worktree kept: $WT"
fi
note "report: $REPORT"
