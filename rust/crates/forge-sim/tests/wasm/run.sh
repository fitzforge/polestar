#!/bin/sh
# Native == wasm determinism: the same route's action hash from the native sim-hash and from
# the wasm32-wasip1 build under node's WASI. Run from rust/; it builds forge-sim's sim-hash bin both
# ways first (target dir: $CARGO_TARGET_DIR, else target/).
# Default inputs: the goldens (rust/tests/golden/world and sim: the slice's Horde world, params.json,
# v1's Orc chain), walks off. POLESTAR_SIMDIR (world-horde.json, params.json, walks-horde.bin) and
# POLESTAR_SIM_JS (v1-horde-orc-on.json) select a local sim dir and seed instead, walks on as well.
set -e
export RAYON_NUM_THREADS=${RAYON_NUM_THREADS:-4}
T=${CARGO_TARGET_DIR:-target}
cargo build -q --release -p forge-sim --bin sim-hash
cargo build -q --release -p forge-sim --bin sim-hash --no-default-features --target wasm32-wasip1
if [ -n "${POLESTAR_SIMDIR:-}" ]; then
	SIM=$POLESTAR_SIMDIR
	SEEDS=${POLESTAR_SIM_JS:?POLESTAR_SIM_JS: the seed dir}
	SEED=v1-horde-orc-on.json
	RUNS="off 2000 0|on 2000 0|on 2000 1"
else
	SIM=$T/sim-hash-golden
	SEEDS=$SIM
	SEED=v1-horde-orc-off.json
	RUNS="off 2000 0|off 2000 1"
	mkdir -p $SIM
	gzip -dc tests/golden/world/expected/world-horde.json.gz > $SIM/world-horde.json
	gzip -dc tests/golden/sim/$SEED.gz > $SIM/$SEED
	cp tests/golden/sim/params.json $SIM/
fi
IFS='|'
for args in $RUNS; do
	IFS=' '
	n=$("$T/release/sim-hash" "$SIM" "$SEEDS/$SEED" $args)
	w=$(node --no-warnings crates/forge-sim/tests/wasm/run-wasi.mjs "$T/wasm32-wasip1/release/sim-hash.wasm" "$SIM" "$SEEDS" $SEED $args)
	echo "walks/tries/camps $args"
	echo "  native $n"
	echo "  wasm   $w"
	[ "$n" = "$w" ] || { echo "MISMATCH"; exit 1; }
	IFS='|'
done
echo "native == wasm"
