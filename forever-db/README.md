# forever-db: quest data for World of Warcraft: Forever

An open database of World of Warcraft: Forever's quests, NPCs, objects, items, spawn points and
quest steps, built by Polestar's `forge` from the game client and independent open sources. Every
value in `data/` is held by at least one independent source (NOTICE.md credits them all); a value
only one closed or web source knows is left out rather than copied.

This folder is self-contained: nothing in it refers to files outside it.

## What is here

| file | what | edited by |
|---|---|---|
| `data/<table>.jsonl` | the tables, one JSON object per line, sorted by key; an absent field is omitted, never null | `forge data publish` (do not edit) |
| `schema/<table>.schema.json` | each table's JSON Schema (2020-12) | `forge data publish` |
| `datapackage.json` | every file with its size, sha256 and licence (Frictionless Data Package) | `forge data publish` |
| `index.json` | version, client build, schema version, producing commit, row counts, coverage | `forge data publish` |
| `CHANGELOG.md` | per release: rows added and removed, values changed, coverage, values left out | `forge data publish` |
| `corrections/*.json` | our hand-checked fixes (below) | contributors |
| `corrections/LEDGER.md` | what each note-fix record did to this release | `forge data publish` |
| `README.md`, `NOTICE.md`, `LICENSE`, `LICENSE-CC-BY-4.0.txt` | this file, the credits, the licences | maintainers |

The tables:

- `quest` (id; title, level, min_level, races and classes as client masks with 0 for every, side
  0 both / 1 Alliance / 2 Horde, xp, money_copper, type, zone_area, repeatable), `quest_start`,
  `quest_end` (npc, object or item), `quest_objective` (kill, item, object, event, talk; target,
  count), `quest_prereq` (mode all / any, breadcrumb), `quest_reward` (item, choice, rep);
- `npc` (name, subname, level_min, level_max, faction_template, rank), `object` (name, type),
  `item` (name, quest_item), `item_source` (what drops or holds an item; chance only where a
  designed loot table gives one);
- `spawn`: points in world yards on the client Map id (x north, y west, rounded to 0.5 yd; z to
  0.1 yd where known); `ui_map`: each in-game map's frame in world yards, to turn a point into
  map percent;
- `mechanic`, `step` and `note`: how a quest is done, in our own words. A step or note row
  carries a stable `id` (`<quest>:s:<hash>` or `<quest>:n:<hash>`) that keeps when the wording or
  the order changes. `confidence: "unconfirmed"` marks a community note not yet confirmed from game
  data.

## Licences

- **GPL-3.0** (`LICENSE`): the database: `data/quest*.jsonl`, `data/npc.jsonl`, `data/object.jsonl`,
  `data/spawn.jsonl`, `data/item.jsonl`, `data/item_source.jsonl`, `data/ui_map.jsonl`.
- **CC BY 4.0** (`LICENSE-CC-BY-4.0.txt`): our own layer: `data/mechanic.jsonl`, `data/step.jsonl`,
  `data/note.jsonl`, the schemas, the corrections and this documentation.

`datapackage.json` names each table's licence. The sources' credits and licences are in NOTICE.md.

## In game: LibForeverData

`forge data publish --from forever-db --lua <AddOns folder>` writes the library addon
`LibForeverData` from this folder; each `lib-v*` release attaches it. Other addons read it through
`## Dependencies: LibForeverData` (or OptionalDeps) or embed the folder:

```lua
local q = LibForeverData.Quest(783)              -- title, levels, start, finish, objectives, prereqs, rewards
local npc = LibForeverData.Get("npc", q.start[1].id)
for _, p in ipairs(LibForeverData.Spawns("npc", npc.id)) do
  print(LibForeverData.ToUiMap(p.map, p.x, p.y))  -- uiMapID, x%, y%
end
```

`Get`, `Name` and `Ids` answer in LibDingDB's shapes, so an addon that reads one can read the other.
The library keeps its records as text and decodes a record when it is first read: about 3.6 MiB of
memory after loading.

## Versions and releases

- A release is `YYYY.MM.N` (`index.json` `version`), tagged `data-vYYYY.MM.N`, with
  `forever-db-<version>.zip` (this folder) and `forever-db-<version>.sqlite.zst` (the tables as
  one sqlite file) attached.
- `schemaVersion` changes only when a field changes meaning or goes away.
- The library is tagged `lib-v<api>.<version>`, for example `lib-v1.2026.10.1`.

## Contributing

The tables are generated; nobody edits `data/`. A fix goes into `corrections/`, and the next
`forge data publish` applies it. Each change is a pull request; its checks rebuild the release and
show the value diff.

### Corrections: `corrections/{quests,npcs,objects,items,mechanics}.json`

One file per section, keyed by id. Each entry fixes one fact, names the independent source it was
checked against, and says in our own words what was wrong:

```json
"91921": {
	"set": { "pre": [91920] },
	"source": { "kind": "in-game-check", "ref": "issue 640" },
	"note": "Return to Quinn (Again) is offered only after Wild Eyes is handed in."
}
```

- `quests`: `set` replaces fields (title, level, minLevel, races, classes, start, end, pre, preAny,
  preAll, objectives, xp, escort, ...).
- `npcs`, `objects`: `set` replaces fields (rank, name, ...); `addSpawns` adds
  `{ "<uiMapID>": { "f": "e" | "l", "pts": [[x, y], ...] } }` in map percent.
- `items`: `removeDrops` `{ npc: [ids], object: [ids] }` and `removeVendors` `[ids]` drop wrong sources.
- `mechanics`: by quest id, `params` `[{ kind, ...fields }]` and `steps` `{ "<n>": { set } }`.

`source` is `{ kind, ref }` or a list of them. `kind` is one of `recording` (a Polestar Recorder
session), `in-game-check` (a player's or maintainer's check in game, such as an issue report),
`client` (the game client's tables and caches), `eg` (EG Link), `cmangos` (CMaNGOS / VMaNGOS),
`tdb` (ForeverTDB), `questie`, `pfquest` or `factoruide`; `ref` says which table, field, recording
or issue. Positions: stand on the spot in game and record it, or give the recording.

### Note fixes: `corrections/notes.json`

Steps and notes are regenerated each release, so a fix to one is a record keyed by the row's `id`
(from `data/step.jsonl` or `data/note.jsonl`), not an edit of the row. A record does one thing:

```json
"2:s:1a2b3c4d": { "set": { "fact": "Kill Sharptalon south of the road." }, "source": { "kind": "in-game-check", "ref": "issue 712" }, "note": "He patrols south of the road, not north." },
"2:n:5e6f7a8b": { "drop": true, "source": { "kind": "recording", "ref": "session 41" }, "note": "There is no timer." },
"2:n:9c0d1e2f": { "promote": "game-data", "source": { "kind": "recording", "ref": "sessions 40 and 44" }, "note": "Two players saw it." },
"sharptalon-elite": { "add": { "quest": 2, "kind": "danger", "fact": "Sharptalon hits hard; bring a friend.", "basis": "community" }, "source": { "kind": "in-game-check", "ref": "issue 713" }, "note": "Reported by two players." }
```

- `set`: fields of the row: `fact`, `basis` (`game-data` or `community`), `place`
  (`{ map, x, y }` in world yards), `count` (steps) or `kind` (notes). An optional `was` with the
  fields as the record's author saw them makes the record conflict, instead of overwriting, when
  the row has changed since.
- `drop: true` removes the row; `promote: "game-data"` ships a confirmed community row at normal
  confidence; `add` is a new step (`action`) or note (`kind`: timer, spawn, danger, requirement,
  tip) of a quest, which gets its id from the same rule as the generated rows.
- `source.kind` is one of `in-game-check`, `recording`, `client`, `eg`, `cmangos`, `tdb`,
  `questie`, `pfquest`.

`corrections/LEDGER.md` lists each record as applied, stale (its row is gone, or the release
already says the same: the record can go) or conflicting (it cannot be applied as written).

### Checking an edit

```
forge data check-corrections                  # shapes, sources, the ids named; exits 1 on an error
forge data publish --out forever-db           # the release again (the maintainer's full build)
forge data publish --check forever-db         # the guard: schemas, source names, copied-data
                                              # fingerprints; a conflicting note fix fails, a stale one warns
```

## Disclaimer

World of Warcraft and Blizzard Entertainment are trademarks or registered trademarks of Blizzard
Entertainment, Inc. in the U.S. and/or other countries. World of Warcraft names and game data ©
Blizzard Entertainment. This database is not made, endorsed or supported by Blizzard Entertainment,
and this project is not affiliated with Blizzard. Names, ids and numbers describe the game for
players; no game assets, and no game text beyond names and titles, are included.
