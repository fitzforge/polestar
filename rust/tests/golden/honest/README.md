# golden/honest

References for `forge-judge/tests/honest_parity.rs` `honest_parity_slice`: the honest playtest in legacy mode against the JS `playtest --honest`.

- `orc.json` (filter `forever/horde/`) and `human.json` (filter `forever/alliance/`) hold the findings that `forge-judge/tests/js/honest-ref.js` writes: rule, severity, guide, line, step, title, reason, repair, race, class. They also hold the number of guides played. There is no knowledge base.
- `drop.json` defines the clean guide slice, which the seed, engine and report goldens use too.
  - The guide slice (`../guide/slice`) does not compile cleanly on the data slice (`../world/root/data/forever`), because there is no QuestieDB. Some goal lines name quests, items or objectives the slice lacks, and playtest refuses a pack with compile errors.
  - So `regen.js` compiles the slice, blanks each error line, and repeats until no error is left (3 rounds, 213 lines).
  - The tests build the same pack from the slice and this list (`forge-judge/tests/common` `clean_slice`, in `CARGO_TARGET_TMPDIR`). Line numbers stay as in the slice.
  - A line is blanked, not commented out. With `# ...` comment lines inside steps, `forge writer apply-route` wrote a step's work before the step that accepts its quests (see `../report/README.md`).
- The JS: `playtest-honest.js` from the v2-route branch @ 5af7bbbd6 (last changed in 37a476002), which forge-judge's honest playtest follows. It was copied into a scratch copy of this checkout's `tools/` (rust-retire @ a8f669093) plus `tests/helpers`. Its other modules (`playtest.js`, `planner/geo.js`, the compiler) are this checkout's.
- This checkout's own `playtest-honest.js` is an older version and cannot be the reference:
  - it matches goal lines by their first id only;
  - it throws on `when turnedin|complete|available <quest>`, because `whenHolds` calls `qs.every` on the single quest id that the compiler gives.
- Regenerate (not run in CI): `JS_ROOT=<that scratch tree> node rust/tests/golden/honest/regen.js`. It works on temp copies of the slices.

Not CI-provable: findings that need the knowledge base (`data/local/kb/forever-kb.sqlite`, built from non-shareable sources), and the lines that the full data compiles but the slice drops.
