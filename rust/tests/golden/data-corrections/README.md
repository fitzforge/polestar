# data build corrections golden

What corrections do without Forever's quest data: `data build` on the data golden's input slice
(../data/input, no QuestieDB), with `corrections.json` here instead of the slice's.

- An existing record is corrected (quest 15, item 159).
- An absent record becomes the record when the correction can stand alone (quest 990001: title,
  giver and turn-in; NPC 990101: name and spawns).
- Otherwise it is reported as unused in meta.json's warnings (quest 990002, NPC 990102, object
  990201, item 990301).

`expected.json`: the touched records, `counts.corrections`/`correctionsCreated` and the warnings
that name corrections. Test: rust/crates/forge-data/tests/data_corrections.rs. The expected file is
written by the Rust build (`FORGE_GOLDEN_BLESS=1`); review its diff before committing.
