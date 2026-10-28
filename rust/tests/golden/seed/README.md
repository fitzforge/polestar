# golden/seed

The reference for `forge-judge/tests/judge/seed_parity.rs` `seed_tests_match_the_reference_on_the_slice`.

- `slice.tsv` has one line per seed test (`forge judge seed-tests`): `ok` or `not ok`, a tab, then the test's name.
- The tree the tests run on:
  - the guides are the clean guide slice: `../guide/slice` with `../honest/drop.json`'s lines blanked;
  - the data is the data slice (`../world/root/data`);
  - the root holds this checkout's `forever-db/corrections` and `addon/Polestar_Nav/Nav/Nav1.lua`. There is no navigation build and no site list cache, so those tests skip (and pass).
- Most tests fail on the slice (123 of 139): they name guides or quests outside it. The test checks the pass/fail of each name, and that no test was added or removed unnoticed.
- The reference is the Rust run's own. It was first the Node run of the tests these port, `node --test tests/guides-reported.test.js tests/guides-caves.test.js`. With the JS toolchain retired, it was regenerated from Rust: all 138 Node tests kept their pass/fail, plus the one test added since (the Undead Paladin's Tirisfal report).
- Regenerate after adding, removing or changing a seed test, and check the diff:
  `FORGE_REGEN_SEED=1 cargo test --profile quick -p forge-judge --test judge seed_parity`
