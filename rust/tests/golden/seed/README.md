# golden/seed

References for `forge-judge/tests/seed_parity.rs` `seed_tests_equal_node_on_the_slice`.

- `slice.tsv` has one line per top-level test of `node --test tests/guides-reported.test.js tests/guides-caves.test.js`: `ok` or `not ok`, a tab, then the name as the TAP prints it. A `# SKIP` test counts as passed. There are 138 lines, 137 names (one name appears twice).
- The tests: v1's two files, a checkout of next @ eb7b47840 (tests/guides-reported.test.js last changed in a6eb7a87b). forge-judge's seed tests port them, and they have 3 tests more than this checkout's copy. Both files were copied into a temp copy of this checkout (rust-retire @ a8f669093: tools/, tests/, addon/).
- The tree's inputs:
  - `guides/` is the clean guide slice: `../guide/slice` with `../honest/drop.json`'s lines blanked.
  - `data/` is the data slice (`../world/root/data`).
  - There is no navigation build and no site list cache, so those tests skip.
- The test's root holds this checkout's `forever-db/corrections` and `addon/Polestar_Nav/Nav/Nav1.lua`, as the JS tree had them.
- Most tests fail on the slice (121 of 137): they name guides or quests outside it. Parity is in pass/fail per name.
- Regenerate (not run in CI): `rust/tests/golden/seed/regen.sh <v1 checkout>`. It needs lua5.1.

On the raw slice (no lines dropped), 2 tests differ: #553 (Elwynn) and #357 (Durotar). In node, the addon's `E.GetGuide()` is nil for a guide that has compile errors, and the Lua script throws. The Rust port plays the compiled guide anyway. [INFERENCE: the addon does not open a guide that compiled with errors; on the full data these guides compile cleanly.]

Not CI-provable: v1's full guides and the r8 written guides on the full data (most tests need zones outside the slice), and the site list cache and navigation build tests.
