# Forge internals

This page is for people changing Forge itself: how the Rust workspace is laid out, how `forge build`
runs its stages and decides what to redo, how a port was checked against the JavaScript it replaced,
and the rules the code follows. [FORGE.md](../FORGE.md) is the user's entry point; the other pages
explain each part: [data](data.md), [nav](nav.md), [model](model.md), [routes](routes.md),
[writer](writer.md), [judge](judge.md).

## What Forge is for

Forge makes Polestar's leveling routes and writes them into guides, end to end, from the installed
game client and the guide sources:

1. read the game's data and build the reference data (`data/forever`),
2. build each faction's world (quests, givers, camps, areas),
3. price the walks between the places a route can visit,
4. improve each start's route, starting from the shipped (v1) guides,
5. write the improved route into the guides,
6. judge the result and write a report.

It is one Rust workspace built twice from the same code: native (the build pipeline, all cores) and
WebAssembly (the parts a browser tool needs, single-threaded). The addon itself stays Lua.

Two decisions shape everything else:

- **v2 is v1 improved.** Many players use the shipped guides and like them; their reports are about
  missed quests, small things and back-and-forth. Each start's route starts from v1's own order and
  changes only by local edits that make it faster in the model while v1's deliberate orders and the
  guards still hold ([routes](routes.md)).
- **The objective is the fastest route to 60**, measured in the model's hours
  ([model](model.md)). The guards (take a hub's quests, finish an area once, pick up what you pass,
  never come back for work that was available, train on the way, grind little) keep the route the
  kind players want; the judge ([judge](judge.md)) checks them on the written guides.

Routes are class-agnostic: each faction has race start routes for levels 1 to about 12, then a
route from 12 to 60 through that faction's zones and the contested ones. Class quest chains are
separate class guides; group content is not planned into the solo route.

## The workspace

`rust/` is a Cargo workspace (`rust/Cargo.toml`, members `crates/*`, GPL-3.0-only, edition 2021,
Rust 1.87 or newer). Each crate does one job; a crate never reaches into another's files.

| Crate | Holds | Native-only parts | WebAssembly |
|---|---|---|---|
| `forge` | the `forge` binary: `forge build` (the stages, keys, staging root), `forge data pack`/`fetch`, `forge doctor`, and every other command as a subcommand (`src/cli/`) | all of it | no |
| `forge-core` | ids, positions and map frames, race/class masks, content keys, JavaScript-compatible number formatting and rounding | none | yes |
| `forge-gamedata` | the installed client: its storage, BLTE, the client's tables (typed by table definitions read at run time), finding the install, the config file | all of it | builds, not used |
| `forge-data` | the data stage: reference data, the knowledge base, training, travel, trainers, professions, dungeons, codex, gear, the sim inputs | all of it (built-in Lua, SQLite) | no |
| `forge-world` | `data/forever` loaders, prerequisites, the solo filter, availability, camps, areas, the quest atlas, the world builder | file reading | yes |
| `forge-nav` | the walking grid reader, legs, the CCH router, the walk store, Leffe's navigation maps reader, the hybrid backend, the world and walks stages | the router, memory maps, threads | reads walk stores |
| `forge-sim` | the time model, class profiles, the route search and edits, guards, the shared route, the skip and edit ledgers | threads, SQLite | single-threaded |
| `forge-guide` | `.guide` parsing, `when`, tokens, compile, lint, the pack emitter | file walking | parse and lint |
| `forge-writer` | a route written into the guides (`apply-route`) | file I/O | yes |
| `forge-judge` | the headless engine, honest playtest, passed-by, avoidable returns, guide-text metrics, seed tests, the report | SQLite, file I/O | yes |
| `forge-release` | releasing the addon: the release zips (a deterministic ZIP writer), the version, the changelog fragments, the release notes, the credits ([release.md](release.md)) | file I/O | no |
| `forge-wasm` | the route planner in the browser: guide compile from a bundled copy of the data, the judge's walk with the simulator's levels, the judge summary (wasm-bindgen); the `bundle` binary builds its data bundle; `www-build/build.sh` builds the page | the `bundle` binary | it is the browser build |

The browser never runs the router (its bundles are hundreds of MB per continent): it reads walk
stores.

Crate names and paths: `rust/crates/forge-<name>`, Rust paths `forge_<name>::...`.

## The binary

`forge` has one entry point (`crates/forge/src/main.rs`). `forge build` and `forge data pack|fetch`
live there; `forge doctor` and every other command is a module in `crates/forge/src/cli/` with
`pub fn main()`, reading its arguments through `cli::args()`:

| Command | Module | Does |
|---|---|---|
| `forge build` | `main.rs`, `lib.rs` | the whole pipeline, stage by stage |
| `forge doctor` | `cli/doctor.rs` | what Forge finds: client, builds, quest data, data pack, Leffe's maps, grid |
| `forge data ...` | `cli/data.rs` | the data builders one at a time ([data](data.md)) |
| `forge gamedata ...` | `cli/gamedata.rs` | list and export the client's tables |
| `forge guide compile\|lint` | `cli/guide.rs` | the guide compiler ([writer](writer.md)) |
| `forge guide seed\|publish\|check-generated` | `cli/guide.rs`, `generated.rs` | the seed, the generated guides in the checkout, the check that they are not edited ([FORGE.md](../FORGE.md#fixing-a-generated-guide)) |
| `forge judge ...` | `cli/judge.rs` | one guide pack, the report, seed tests ([judge](judge.md)) |
| `forge sim ...` | `cli/sim.rs` | route cuts, the shared route, guards, `why`, `skips` ([routes](routes.md)) |
| `forge walks ...` | `cli/walks.rs` | the world and walks stages on their own ([nav](nav.md)) |
| `forge writer apply-route` | `cli/writer.rs` | write one route into the guides ([writer](writer.md)) |

Every command prints its usage with `--help` and exits 0. Developer-only tools stay separate
binaries in the `forge-devtools` crate (`travel-parity`, `navcch`, `landing_diff`); build one with
`cargo build --release -p forge-devtools --bin <name>`. `sim-hash` is forge-sim's own binary, so it
also builds for WebAssembly.

## `forge build`: stages, keys, staging

`forge build --out <dir>` runs eight stages into `--out`, then writes the fixes ledger:

| Stage | Writes | Made by |
|---|---|---|
| grid | `grid/` (the walking grid, from the game; skipped when `--grid` names one) | `forge-nav` |
| data | `data/forever/` | `forge-data` |
| prepare | the grid's `walk/`: road masks, walk graphs, zone mixes | `forge-nav` |
| world | `world/world-<faction>.json` | `forge-nav` (grid floors) + `forge-world` |
| walks | `walks/walks-<faction>.bin`, the walk store | `forge-nav` |
| routes | `routes/<start>.json`, `.skips.json`, `.edits.json` | `forge-sim` (v1's chains by `forge-judge`) |
| guides | `guides/<start>/` | `forge-writer` |
| report | `report.md`, `report.json` | `forge-judge` |
| (every run) | `fixes.md`, `fixes.json`, the report's Fixes section | `forge` (`ledger.rs`) |

The build reads one checkout's fixes (`--checkout`): `forever-db/corrections` in the data
stage (its rows of what each correction did go to `.forge/corrections.json`), `data/route-fixes.json`
in the routes stage. With `forge/seed/SEED.json` in the checkout the input guides are staged in
`.forge/input-guides`: `guides/` with each generated guide replaced by its seed (`generated.rs`).

**Keys.** Each stage's key is the BLAKE3 hash of its version string (`DATA_VERSION`,
`WORLD_VERSION`, ... in `crates/forge/src/lib.rs`), the bytes of its inputs and the keys of the
stages it reads. The key is stored in `<out>/.forge/<stage>.key`; when the new key equals the stored
one and the stage's outputs are in place, the stage is skipped. Large external trees (the walking
grid, `data/sources`) are keyed by a manifest of their files' paths, sizes and modification times
instead of their bytes. A key never hashes source text that does not change the output.

**Bump a stage's version** when your change alters what it writes for the same inputs; otherwise
old outputs survive. Nothing else invalidates a stage.

**Staging root.** Every stage reads a repository-shaped folder, `<out>/.forge/root`: its
`data/forever` is the data stage's output; `data/sources`, `data/local`, `tools`, `addon` and
`forever-db` (the corrections the seed tests read) link to the checkout's (or the data pack's);
`guides` to the input guides. The sim stages also read
`<out>/.forge/sim` (`world-*.json`, `walks-*.bin`, `params.json`). This is why a stage's library
code can take "a checkout" and work the same inside a build.

**Where the inputs come from.** `--root` names the checkout (default: the nearest folder above the
current one with `data/sources`). Without one, the build reads the public data pack
(`forge data fetch`) and builds the grid from the game (or takes `--grid`). The client: `--wow`, `$POLESTAR_WOW_DIR`, the remembered
folder, then a search ([FORGE.md](../FORGE.md#how-forge-finds-the-game)).

## How a port was checked

Every stage replaced a JavaScript tool that already shipped routes or data, and landed only when it
matched it:

- **Byte parity** where the output is a file: the data builders, the guide compiler, travel,
  trainers, professions, dungeons, codex and gear write the same bytes as the JavaScript builder run
  fresh on the same inputs. The goldens under rust/tests/golden hold the JavaScript output and the
  tests rerun these comparisons (`travel-parity` against a live JavaScript travel build).
- **Event parity** for the model: every event's level and time equal the JavaScript evaluator's on
  v1's chains (within the reference file's rounding).
- **Row parity** for the knowledge base's SQLite file (typed rows compared table by table).
- **Native equals WebAssembly**: `sim-hash` runs the same replays under both and compares hashes.

JavaScript number semantics are kept where outputs depend on them (`forge-core::jsnum`: `toFixed`,
`Math.round`, `String(number)`, `-0` printed as `0`). Comparisons written as `!(a < b)` stay that
way because they differ from `a >= b` when a value is NaN; the workspace's clippy settings allow
these forms (`rust/Cargo.toml`, `[workspace.lints.clippy]`).

## Building, testing, CI

```sh
cd rust
cargo build --release -p forge          # target/release/forge
cargo test --release --workspace        # parity tests skip with a reason when their inputs are missing
cargo fmt --all --check
cargo clippy --workspace --all-targets --release -- -D warnings
cargo check --target wasm32-unknown-unknown --no-default-features --lib \
  -p forge-core -p forge-guide -p forge-world -p forge-sim -p forge-nav -p forge-judge -p forge-writer -p forge-gamedata \
  -p forge-wasm
(cd crates/forge-wasm && wasm-pack build --release --target web --out-dir www/pkg --no-typescript)
```

The browser planner's page (`crates/forge-wasm/www-build/build.sh <checkout> <sim dir> <local dir>
name=<guides> ...`) also bundles the JavaScript planner page from `tools/planner` (`build.mjs`,
esbuild) and its static assets (`export-assets.js`); those steps stay JavaScript.

The forge workflow (`.github/workflows/forge.yml`) runs these on every change under `rust/`, checks
every command's `--help` and every documentation block marked `<!-- ci -->`
(`rust/scripts/doc-commands.sh`), builds the `forge` binary for Linux, Windows and macOS, and
attaches them to a `forge-v*` release.

Parity tests that need the game client, a built grid or the JavaScript references skip with a note
when those are missing, so CI passes without them; run them locally before changing a stage.

Large builds use a lot of memory (a walks stage, a full test run). On a shared machine cap them,
for example `systemd-run --user --scope -p MemoryMax=6G -p MemorySwapMax=0 cargo test ...`, and
use `-j 4`.

## Rules for the work

- Every number in the docs and the report is measured on committed code.
- Tests pin behaviour (parity, rules, edge cases), not wording.
- Nothing is called better than v1 without the judge's numbers and a player's read of the guides.
- Every Forge result records the data it ran on, so a public-data build is never mistaken for an
  official one.
- Dependencies must be GPL-3.0-compatible (MIT, Apache-2.0, BSD, zlib, CC0). Credits and licences:
  [rust/NOTICE.md](../../rust/NOTICE.md) and the data pack's `manifest.json`.
- Private material never enters the repository or the data pack; `forge data pack` refuses to
  build when it finds any ([data](data.md)).

## Environment variables

Every variable Forge reads. Command-line options win over them where both exist.

| Variable | Read by | Meaning | Default |
|---|---|---|---|
| `POLESTAR_WOW_DIR` | every command that reads the game | the game folder (the one holding `.build.info`) | the remembered folder, then a search ([FORGE.md](../FORGE.md#how-forge-finds-the-game)) |
| `POLESTAR_FORGE_CONFIG` | every command that reads the game | the config file that remembers the game folder | `polestar-forge/config.toml` in your config folder |
| `POLESTAR_GRID` | `forge build`, `forge doctor`, `forge nav prepare`, `forge sim`, `forge judge`, `forge writer`, `forge walks` | a built walking grid (`--grid` wins) | `forge build`: builds one into `<out>/grid`; the other commands: `data/local/nav4` |
| `POLESTAR_LEFFE_NAV` | `forge build`, `forge doctor`, `forge walks walks` | Leffe's navigation maps, private (the folder with `Nav.xml` or `Nav/Nav.xml`; `--leffe` wins) | none: without his maps the hybrid runs on the data pack's saved Leffe walks |
| `POLESTAR_LEFFE_NAV_CACHE_MB` | `forge walks walks` with `POLESTAR_NAV=leffe` | the cache for Leffe's decoded map pieces, in MB | 1,024 (`forge build` and the hybrid use 2,048) |
| `POLESTAR_NAV` | `forge walks walks` only | the walks backend: `grid`, `leffe` or `hybrid` (`forge build` takes `--nav`) | `hybrid` when `POLESTAR_LEFFE_NAV` names the maps or his saved walks lie beside the store, else `grid` |
| `POLESTAR_NAV_FP` | `forge build` (walks), `forge data pack` | the walk model tag written into walks files and the pack's manifest | `forge-<walks version>` |
| `POLESTAR_DATA_PACK` | `forge data fetch`, `forge build`, `forge doctor` | the data pack folder (`--dest` / `--pack` win) | `polestar/data-pack` in your data folder |
| `POLESTAR_DATA_PACK_URL` | `forge data fetch` | the pack's index (`--url` wins) | `polestar-data-pack.json` of the `data-pack` release |
| `POLESTAR_KB` | `forge build` (routes), `forge sim` | the knowledge base file | `data/local/kb/forever-kb.sqlite` |
| `POLESTAR_ROUTES` | `forge sim why`, `forge sim skips` | a routes folder (`--dir` / `--out` win) | none |
| `POLESTAR_ROUTE_FIXES` | `forge build` (routes), `forge sim` | a route fixes file to use instead of the checkout's ([routes](routes.md#11-overrides)) | `data/route-fixes.json` in the checkout |
| `POLESTAR_V1_SEEDS` | `forge sim route`, `widen`, `shared` | a folder of saved seed chains (`v1-<faction>-<race>-on.json`) used instead of reading the guides | unset: the seed comes from the current guides |
| `POLESTAR_DATA_TIMES` | `forge data build` | set: print the time of each step | unset |
| `POLESTAR_TIME` | `forge guide compile` | set: print the time of each step | unset |
| `FOREVER_TDB` | `forge data build --kb` | a TrinityCore world database (SQLite), local evidence | `forever-tdb/world.sqlite` under the local folder (`data/local`, or `--local`) |
| `WOW_FOREVER_ADDONS` | `forge data build` | the AddOns folder to look in first for Forever's quest data | the AddOns folders of the installs Forge finds |
| `SOURCE_DATE_EPOCH` | `forge data build` | the build time the data builders record (reproducible builds) | now |

## Crates we build on

| Need | Crate |
|---|---|
| threads | `rayon` |
| content keys | `blake3` |
| the client's tables in Lua addons | `mlua` (Lua 5.1, built in) |
| SQLite (the knowledge base) | `rusqlite` (bundled) |
| the router | `cch` (our contraction hierarchy) |
| memory-mapped files | `memmap2` |
| compression | `flate2`, `miniz_oxide` |
| the data pack | `tar`, `ureq` |
| deterministic maths across targets | `libm` |
| benchmarks, property tests | `criterion`, `proptest` |

Adopt a crate where the current change needs it; don't rewrite finished, parity-tested code to fit
one.
