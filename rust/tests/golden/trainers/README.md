# trainers build golden

JS: a checkout of next at eb7b47840 (next pipeline).
Command: `sh regen.sh $POLESTAR_V1` (`trainers build --data ../data/expected --guides input/guides --recordings input/recordings`).
Inputs: the data golden; input/guides and input/recordings are synthetic (Polestar's own), written for this golden.

Test: rust/crates/forge-data/tests/trainers.rs (byte compare of every file in expected/). Regenerate only when the JS is the reference; CI never runs the generator.

Since the JS command was retired, the generated files' first line names `forge data trainers` instead of `node tools/polestar.js trainers build`; expected/ is the JS output with that line (and the byte counts that include it) as forge writes it.
