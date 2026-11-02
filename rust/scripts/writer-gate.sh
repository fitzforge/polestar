#!/bin/bash
# The writer gate: the writer of this checkout against a previous writer (default: routes-opt's), both
# writing the saved routes of several finished rounds, both judged by this checkout's judge. Fails when
# this writer has a blocker, a failing player-report check, a record that no longer applies or a
# refused start that the previous writer did not have, compared by what it is (quest, place, rule),
# not by line number (`forge writer gate-diff`). docs/forge/writer.md, "The writer gate".
#
# usage: rust/scripts/writer-gate.sh [--base <rev>] [--new <rev>] [--sets c15,c16,c17] [--starts Orc,Human,...] [--out <dir>]
#   --base    the previous writer's commit (default routes-opt)
#   --new     the new writer's commit (default: this checkout as it is, uncommitted changes included)
#   --sets    the rounds whose routes are written (default: the three newest rounds under $ROUNDS with
#             out/routes/starts.json and commit.txt)
#   --starts  only these starts (the faction's other routes are still read for its shared guides)
#   --out     the run folder (default $GATE/runs/<time>)
# env: ROUNDS  the round folders (<ROUNDS>/<set>/out from forge build, <set>/commit.txt naming the commit
#              it was built from; default /home/fitz/Projects/lodestar-reset-base/scratch/Routes)
#      GATE    the gate's cache: each round's guides and root as the round had them, the previous writers'
#              binaries, trees and their judging (default $ROUNDS/gate)
#      CARGO_TARGET_DIR  where this checkout's forge is built (default rust/target)
# One forge process at a time, each on every core, at nice 19 and through the machine's memory-gated
# slots (/tmp/ctl/bslot.sh, wslot.sh) when it has them.
# Exit 0: passes; 1: fails (the report says what is new); 2: the gate could not run.
set -euo pipefail
HERE=$(dirname "$(realpath "$0")")
CHECKOUT=$(git -C "$HERE" rev-parse --show-toplevel)
ROUNDS=${ROUNDS:-/home/fitz/Projects/lodestar-reset-base/scratch/Routes}
GATE=${GATE:-$ROUNDS/gate}
BASE=routes-opt NEWREV="" SETS="" STARTS="" RUN=""
while [ $# -gt 0 ]; do
	case $1 in
	--base) BASE=$2; shift 2 ;;
	--new) NEWREV=$2; shift 2 ;;
	--sets) SETS=$2; shift 2 ;;
	--starts) STARTS=$2; shift 2 ;;
	--out) RUN=$(realpath -m "$2"); shift 2 ;;
	-h | --help) sed -n '2,/^set -euo/p' "$0" | sed '$d; s/^# \{0,1\}//'; exit 0 ;;
	*) echo "writer-gate: unexpected $1 (--help)" >&2; exit 2 ;;
	esac
done
die() { echo "writer-gate: $*" >&2; exit 2; }
# Memory-gated slots where the machine has them (/tmp/ctl), else run directly; always at low priority.
slot() { local s=/tmp/ctl/$1; shift; if [ -x "$s" ]; then nice -n 19 "$s" "$@"; else nice -n 19 "$@"; fi; }

if [ -z "$SETS" ]; then
	SETS=$(for d in "$ROUNDS"/c*/; do [ -f "$d/out/routes/starts.json" ] && [ -f "$d/commit.txt" ] && basename "$d"; done | sort -V | tail -3 | paste -sd,)
fi
[ -n "$SETS" ] || die "no round with out/routes/starts.json and commit.txt under $ROUNDS"
BASE_SHA=$(git -C "$CHECKOUT" rev-parse --verify "$BASE^{commit}") || die "no commit $BASE"
HEAD_SHA=$(git -C "$CHECKOUT" rev-parse HEAD)
DIRTY=$(git -C "$CHECKOUT" status --porcelain -- rust | head -1)
RUN=${RUN:-$GATE/runs/$(date +%Y%m%d-%H%M%S)}
mkdir -p "$RUN" "$GATE/bin" "$GATE/sets" "$GATE/trees"

# This checkout's forge: the judge of both writers, the comparison, and the new writer unless --new.
TARGET=${CARGO_TARGET_DIR:-$CHECKOUT/rust/target}
(cd "$CHECKOUT/rust" && CARGO_TARGET_DIR=$TARGET slot bslot.sh cargo build --profile quick -p forge -j 16 2>&1 | tail -1) || die "this checkout's forge does not build"
cp "$TARGET/quick/forge" "$RUN/forge"
JUDGE=$RUN/forge

# rev_forge <sha>: the forge of a commit, built once into $GATE/bin. A commit from before
# `forge writer apply-routes` gets this checkout's driver for it (forge/src/cli/writer.rs and
# forge/src/gate.rs: the command line only; the writer under test is the commit's own crate).
rev_forge() {
	local sha=$1 bin=$GATE/bin/forge-$1 src=$GATE/src-$1
	if [ ! -x "$bin" ]; then
		# (A worktree left by a failed run is made again: it may hold a half-applied driver.)
		[ -d "$src" ] && git -C "$CHECKOUT" worktree remove --force "$src"
		git -C "$CHECKOUT" worktree add --detach "$src" "$sha" > /dev/null 2>&1 || die "git worktree add $src failed"
		if ! grep -q 'apply-routes' "$src/rust/crates/forge/src/cli/writer.rs"; then
			cp "$CHECKOUT/rust/crates/forge/src/cli/writer.rs" "$src/rust/crates/forge/src/cli/writer.rs"
			cp "$CHECKOUT/rust/crates/forge/src/gate.rs" "$src/rust/crates/forge/src/gate.rs"
			grep -q '^pub mod gate;' "$src/rust/crates/forge/src/lib.rs" || sed -i 's/^pub mod generated;/pub mod gate;\npub mod generated;/' "$src/rust/crates/forge/src/lib.rs"
			sed -n '/^\[dependencies\]/,/^\[[a-z-]*\]$/p' "$src/rust/crates/forge/Cargo.toml" | grep -q '^regex = ' || sed -i 's/^rayon = "1"/rayon = "1"\nregex = "1"/' "$src/rust/crates/forge/Cargo.toml"
		fi
		(cd "$src/rust" && CARGO_TARGET_DIR=$GATE/target slot bslot.sh cargo build --profile quick -p forge -j 16 2>&1 | tail -1 >&2) || die "forge at $sha does not build"
		cp "$GATE/target/quick/forge" "$bin.tmp" && mv "$bin.tmp" "$bin"
		git -C "$CHECKOUT" worktree remove --force "$src"
	fi
	echo "$bin"
}
OLD=$(rev_forge "$BASE_SHA") && [ -x "$OLD" ] || die "no forge for $BASE"
if [ -n "$NEWREV" ]; then
	NEW_SHA=$(git -C "$CHECKOUT" rev-parse --verify "$NEWREV^{commit}") || die "no commit $NEWREV"
	NEW=$(rev_forge "$NEW_SHA") && [ -x "$NEW" ] || die "no forge for $NEWREV"
	NEW_LABEL="$NEWREV (${NEW_SHA:0:9})"
else
	NEW=$JUDGE
	NEW_LABEL="this checkout (${HEAD_SHA:0:9}${DIRTY:+ + uncommitted})"
fi
echo "writer-gate: $BASE (${BASE_SHA:0:9}) -> $NEW_LABEL; sets $SETS; run $RUN"

# Each round's inputs as the round had them: its guides at the commit it was built from (the routes'
# `from` lines point into them) and its stage root with those guides.
for s in ${SETS//,/ }; do
	O=$ROUNDS/$s/out
	[ -f "$O/routes/starts.json" ] || die "$O/routes: no saved routes"
	P=$GATE/sets/$s
	[ -f "$P/ready" ] && continue
	rm -rf "$P" && mkdir -p "$P"
	git -C "$CHECKOUT" archive "$(cut -d' ' -f1 "$ROUNDS/$s/commit.txt")" guides | tar -x -C "$P"
	cp -a "$O/.forge/root" "$P/root" && rm "$P/root/guides" && ln -s ../guides "$P/root/guides"
	touch "$P/ready"
done

# The records both writers apply are this checkout's: a previous writer's trees are kept per records.
# (The judge's planner parts read the route fixes from the environment, as the build sets them.)
export POLESTAR_ROUTE_FIXES=$CHECKOUT/data/route-fixes.json
REC=$(cat "$CHECKOUT"/data/{places,guide-fixes,route-fixes}.json | sha256sum | cut -c1-12)
STARTS_ARG=() JUDGE_STARTS=()
if [ -n "$STARTS" ]; then
	STARTS_ARG=(--starts "$STARTS")
	for x in ${STARTS//,/ }; do JUDGE_STARTS+=(--start "$x"); done
fi

# write <forge> <set> <guides out>: every start of the set's routes, as forge build's guides stage. A
# start the writer left without a status (the process died) is marked failed.
write() {
	local bin=$1 s=$2 dest=$3 O=$ROUNDS/$2/out P=$GATE/sets/$2 st starts=${STARTS//,/ }
	rm -rf "$dest" && mkdir -p "$dest"
	slot wslot.sh "$bin" writer apply-routes "$O/routes" --sim "$O/.forge/sim" --out "$dest" \
		--root "$P/root" --data "$O/data/forever" --checkout "$CHECKOUT" "${STARTS_ARG[@]}" > "$dest/apply.txt" 2>&1 || true
	[ -n "$starts" ] || starts=$(python3 -c 'import json,sys; print(" ".join(r["start"] for r in json.load(open(sys.argv[1]))))' "$O/routes/starts.json")
	for st in $starts; do
		[ -f "$dest/$st.status" ] || echo "failed: no status (the writer died: $(tail -1 "$dest/apply.txt"))" > "$dest/$st.status"
		# (A failed start's partial tree goes: the judge reads only written starts.)
		grep -qx ok "$dest/$st.status" || rm -rf "${dest:?}/$st"
	done
}

# This checkout's judge: the route check and the player-report checks per start. With <ref> (the
# previous writer's judged run), a start whose tree is the same as there takes its checks from there.
judge() {
	local s=$1 dir=$2 ref=${3:-} O=$ROUNDS/$1/out P=$GATE/sets/$1
	# (The check holds ~10 GB on 16 threads for ten starts; when its memory-capped slot kills it, it
	# runs again on fewer threads.)
	local th
	for th in 16 6; do
		slot wslot.sh "$JUDGE" judge check "$dir/guides" --root "$P/root" --sim "$O/.forge/sim" --routes "$O/routes" \
			--route-fixes "$POLESTAR_ROUTE_FIXES" --out "$dir" --threads $th "${JUDGE_STARTS[@]}" > "$dir/check.txt" 2>&1 || true
		[ -f "$dir/check.json" ] && break
	done
	[ -f "$dir/check.json" ] || die "the judge failed on $dir (check.txt)"
	for st in "$dir"/guides/*.status; do
		st=$(basename "$st" .status)
		[ -d "$dir/guides/$st/forever" ] || continue
		if [ -n "$ref" ] && [ -f "$ref/guides/$st.seed.json" ] && diff -rq "$dir/guides/$st" "$ref/guides/$st" > /dev/null 2>&1; then
			cp "$ref/guides/$st.seed.json" "$dir/guides/$st.seed.json"
			continue
		fi
		slot wslot.sh "$JUDGE" judge seed-tests --guides "$dir/guides/$st" --data "$O/data/forever" --root "$P/root" --json > "$dir/guides/$st.seed.json" 2> /dev/null || true
	done
}

# One forge process at a time (each uses every core inside: the writer's factions on threads, the
# judge's starts on --threads 16). The previous writer's trees and their judging are cached by its
# commit, the records and this checkout's judge code (forge-judge, forge-guide), so a gate run after
# the first one writes and judges only the new writer's trees.
JUDGE_KEY=$( (git -C "$CHECKOUT" rev-parse HEAD:rust/crates/forge-judge HEAD:rust/crates/forge-guide; git -C "$CHECKOUT" diff HEAD -- rust/crates/forge-judge rust/crates/forge-guide) | sha256sum | cut -c1-12)
for s in ${SETS//,/ }; do
	T=$GATE/trees/${BASE_SHA:0:12}-$REC${STARTS:+-${STARTS//,/_}}/$s
	if [ ! -f "$T/done" ]; then
		write "$OLD" "$s" "$T/guides"
		! grep -qs 'no status' "$T"/guides/*.status || die "the previous writer died on $s ($T/guides/apply.txt)"
		touch "$T/done"
	fi
	J=$T/judged-$JUDGE_KEY
	if [ ! -f "$J/check.json" ]; then
		rm -rf "$J" && mkdir -p "$J" && cp -a --reflink=auto "$T/guides" "$J/guides"
		judge "$s" "$J"
	fi
	mkdir -p "$RUN/old" && cp -a --reflink=auto "$J" "$RUN/old/$s"
	write "$NEW" "$s" "$RUN/new/$s/guides"
	judge "$s" "$RUN/new/$s" "$RUN/old/$s"
done

"$JUDGE" writer gate-diff "$RUN/old" "$RUN/new" --out "$RUN/gate.md" \
	--labels "$BASE (${BASE_SHA:0:9}),$NEW_LABEL"
