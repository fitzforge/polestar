# Polestar documentation

Where each question is answered, grouped by who asks it: players who install
and go, guide authors who write community addons (other people's guides for
Polestar, each a separate addon), contributors who fix and build,
and maintainers who release. Paths are from the repository root.

## The docs

| Doc | Reader | What it answers |
|---|---|---|
| [README.md](../README.md) | players, everyone | What Polestar is, how to install it, what it does, where to go next |
| [CHANGELOG.md](../CHANGELOG.md) | players, guide authors, contributors | What changed in each release, under "For players", "For guide authors" and "For contributors"; what is merged but not released yet is in `changes/` ([changes/README.md](../changes/README.md)) |
| [docs/GUIDE_PACKS.md](GUIDE_PACKS.md) | players, guide authors | What a community addon is and is not, how to tell one from Polestar's own addons, installing one, turning it on or off, who supports it; for authors, the steps from `new` to publishing, what the tools require and what we ask of you. The in-game Community guides page links here |
| [docs/GUIDE_CHEATSHEET.md](GUIDE_CHEATSHEET.md) | guide authors | The guide format on one page: every header line, goal and condition, with what it does and a short example |
| [docs/GUIDE_FORMAT.md](GUIDE_FORMAT.md) | guide authors | The `.guide` language in full: header, steps, goals, conditions, what the compiler fills in, validation, a cookbook |
| [docs/PACKS.md](PACKS.md) | guide authors | The full handbook: how to write, test, publish and update a community addon; every problem the tools or the game can report, with its fix |
| [docs/PACK_FORMAT.md](PACK_FORMAT.md) | guide authors, tool builders | The contract between a community addon and Polestar: `pack.json`, the addon the compiler writes, the rules Polestar enforces, import strings, versioning |
| [docs/skins/](skins/README.md) | skin authors | Building a skin for Polestar from your own addon: the concepts ([README](skins/README.md)), a skin addon from zero ([getting-started](skins/getting-started.md)), every function, field, token, surface, hook, capability and error message ([reference](skins/reference.md)), recipes ([examples](skins/examples.md)), the version policy ([versioning](skins/versioning.md)), publishing, loading on demand and licensing ([publishing](skins/publishing.md)), and what version 2 does not cover yet ([API-GAPS](skins/API-GAPS.md)) |
| [docs/SKINS-API.md](SKINS-API.md) | skin authors | The Skin API's landing page: what version 2 offers, a quick start, where each page of [docs/skins/](skins/README.md) is, the example `addon/Polestar_Skin_Example`, and how it compares with Details!'s skins |
| [docs/API.md](API.md) | addon authors | The calls another addon may build on: guides it plans and changes as it goes, quest state, the guide window's messages; what each takes, returns and fires, and when `Polestar.API.version` goes up |
| [LICENSE-EXCEPTION.md](../LICENSE-EXCEPTION.md) | guide authors, skin authors | The permissions to distribute a compiled community addon or an import string, and a skin addon that uses only the documented Skin API, under terms of your choice |
| [CONTRIBUTING.md](../CONTRIBUTING.md) | players, guide authors, contributors | Ways to help; how to report a wrong step; how to fix a guide; setting up; code changes; which branch a pull request goes to; using an AI agent; commits and pull requests; the licence of contributions |
| [AGENTS.md](../AGENTS.md) and [skills/](../skills) | contributors' coding agents | AGENTS.md points every agent to its skill: `polestar-contributing` (branches, generated files, changelog fragments, what a pull request must not do, posting on issues), `polestar-triage` (checking a report before agreeing it is a bug), `polestar-guide-fix`, `polestar-guide-pack` |
| [SECURITY.md](../SECURITY.md) | everyone | How to report a security problem privately, and what counts as one |
| [docs/TRANSLATING.md](TRANSLATING.md) | translators, contributors | The languages and their status, the locale file and how to fill it, formats, the glossary, the `i18n` commands, adding or reviewing a language |
| [docs/ARCHITECTURE.md](ARCHITECTURE.md) | contributors | The contract between the addon's modules, the compiled guide data, the toolchain and the tests |
| [addon/README.md](../addon/README.md) | contributors | Which addon is which, the modules in load order with each file and its public table, where a hub screen lives, the generated files inside `addon/` |
| [tools/README.md](../tools/README.md) | contributors, maintainers | The commands by group, the `tools/lib` folders, every generated file with its command and inputs, how to tell it is stale, the rebuild order after a data change |
| [tests/README.md](../tests/README.md) | contributors | The test layers, the fake client, the helpers, how to run one test, what needs local data |
| [docs/CI.md](CI.md) | contributors, maintainers | The on-demand GitHub runs for a batch of work (suites, guide compile and playtests, gates): starting one, the public reference data they build, what stays local |
| [docs/SUITE.md](SUITE.md) | contributors | The modules and their scope, which other addons and sites Polestar reads, the data layer, the in-game packs |
| [docs/FORGE.md](FORGE.md) | contributors, maintainers | Polestar Forge, the Rust pipeline that makes the routes: install, `forge build`, finding the game, the data pack, Leffe's navigation maps, the report, why a quest is in or out, overrides, troubleshooting; details in [docs/forge/](forge): [data](forge/data.md), [nav](forge/nav.md), [model](forge/model.md), [routes](forge/routes.md), [writer](forge/writer.md), [judge](forge/judge.md), [learn](forge/learn.md), [i18n](forge/i18n.md), [release](forge/release.md), [internals](forge/internals.md) |
| [docs/ROUTE-FEEL.md](ROUTE-FEEL.md) | contributors, maintainers | How a leveling route feels to play: the flow audit (`node tools/flow-audit.js`) and what it counts per start and class (walking back and forth, quests picked up on the way, quests carried between guides, dungeon trips), the ways to play it measures (dungeons, route choices), and the route-feel gate that holds a release to the shipped guides |
| [docs/RECORDING.md](RECORDING.md) | players, contributors, maintainers | The recording program's contract and public privacy statement: what the Recorder collects, field by field (explorer mode in Forever's new zones included), what is never collected, how Polestar Client and the server handle it, deletion |
| [docs/legacy/SIMULATION-js.md](legacy/SIMULATION-js.md) | contributors | The earlier JavaScript route simulator, which made the routes up to 0.2.x; only `sim compare` remains (`node tools/polestar.js sim compare`). [docs/SIMULATION.md](SIMULATION.md) points from the old name to Forge |
| [docs/DESIGN.md](DESIGN.md) | contributors | The design system: who the windows are for and what they must do, then colour, type, layout and component tokens |
| [docs/NAV_QA.md](NAV_QA.md) | contributors, maintainers | The pathing checks: every problem reported against Shortest Path Forever that touches what Polestar uses from it, the check Polestar holds itself to and the test or in-game step that enforces it |
| [docs/RELEASING.md](RELEASING.md) | maintainers | What ships, setting the version, the release steps from `next` (the admin-bypass push, the release notes and the two Discord texts, closing fixed issues before publishing, the hype-phrase check), release candidates, and the patch (fast-forward + tag) |
| [docs/curseforge/README.md](curseforge/README.md) | maintainers | The CurseForge listing: the summary, the project settings, what to upload where, the gallery, and the description to paste ([description.html](curseforge/description.html), with a [local preview](curseforge/preview.html)) |
| [THIRD_PARTY.md](../THIRD_PARTY.md) | guide authors, maintainers | Where every input comes from, its licence, and what may enter the repository or a release |

`docs/preview/` holds renders of the addon's windows (`node tools/polestar.js
preview`); `docs/assets/` holds the README's art and screenshots.

## The moving parts

Data flows from the game client and local sources into reference data, from
there into the data addons and the compiled guides, and from `addon/` into
the game. The Recorder sends play back into the reference data; Forge turns
reference data into the leveling routes and writes them into the guides.

```mermaid
flowchart LR
  client["Client tables<br/>via wago.tools"] --> databuild
  installed["Installed addons<br/>in the game"] --> databuild
  recordings["data/recordings"] --> databuild
  databuild["forge data build"] --> forever[("data/forever<br/>reference data")]
  installed --> builders
  forever --> builders["Data addon builds<br/>questdb, codex, travel,<br/>maps, qol, trainers"]
  forever --> compiler["Guide compiler<br/>forge guide lint, compile"]
  forever --> forge["Forge<br/>forge build"]
  forge --> drafted["Routes written<br/>into the guides"]
  drafted --> guides["guides/<br/>.guide files"]
  guides --> compiler
  compiler --> pg["addon/Polestar_Guides"]
  builders --> addon["addon/"]
  pg --> addon
  addon -->|install| game["The game"]
  game -->|"Recorder, forge record import/pull"| recordings
```

`data/forever`, `data/recordings` and the local data addons stay on the
machine that built them; [tools/README.md](../tools/README.md) lists every
generated file, whether it is committed, and the order to rebuild in.

## Glossary

- **Hub**: Polestar's main window: a rail of sections (Guides, Lookup, Dungeons, Rares) with Options at its foot (`UI/Picker.lua`).
- **Guide menu**: the hub's Guides section, where a player picks a guide.
- **Guide window**: the small window that shows the current step and its goals while playing (`UI/GuideFrame.lua` and the `UI/GuideFrame*.lua` files beside it).
- **Guide**: one route, written as a `.guide` file and compiled to Lua; its id reads like `forever/alliance/human/01-elwynn-forest`.
- **Step**: one stop in a guide: a title, optional conditions and tip, and at least one goal.
- **Goal**: one thing to do in a step, as a verb and its arguments (`accept 783`, `kill`, `goto`, `turnin`...).
- **Pack**: an addon of guides for Polestar, built by the compiler from a folder with a `pack.json` (the folder is a pack too); Polestar's own is `Polestar_Guides` (pack id `guides`). **Community addon**: every other pack, a separate addon made and supported by its author, listed under Community guides ([GUIDE_PACKS.md](GUIDE_PACKS.md)).
- **Reference data**: the game facts in `data/forever/*.json` (quests, NPCs, objects, items, zones, map frames and more) that the compiler and the data builds read; built locally by `forge data build`.
- **Data addon**: a companion addon that carries data, not code, mostly loaded on demand: `Polestar_QuestDB`, `Polestar_ItemDB`, `Polestar_Codex`, `Polestar_Travel`.
- **Codex**: Lookup's database of items, mounts, pets, recipes, NPCs, rares, quests, zones, dungeons and treasures, with where each comes from (`forge data codex`, the `Polestar_Codex` addon).
- **QuestDB**: the quest database behind quest markers and tooltips (`forge data questdb`, the `Polestar_QuestDB` addon).
- **ItemDB**: item stats for the gear advice (`forge data itemdb` and `forge data gear`, the `Polestar_ItemDB` addon).
- **Recorder**: the optional `Polestar_Recorder` addon that records play (off on its own; on while Polestar Client shares, which it does by default; [RECORDING.md](RECORDING.md)); `forge record import` (this PC) and `forge record pull` (the recording server) turn its chunks into `data/recordings`.
- **Playground**: the real addon running in a browser against a simulated world (`node tools/polestar.js play`).
- **Forge**: the Rust pipeline that makes the leveling routes from the installed game and the guides (each race's start zone, then one shared route per faction), writes the leveling guides and plays them through the route check (`forge build`, [FORGE.md](FORGE.md)).
- **Simulator**: the earlier JavaScript route model that made the routes up to 0.2.x, kept for `sim compare`, `lint`'s solo filter and the planner's clock ([legacy/SIMULATION-js.md](legacy/SIMULATION-js.md)); Forge's model is [forge/model.md](forge/model.md).
- **Playtest**: playing a pack's guides to the end in the real addon, once per class they branch on (`node tools/polestar.js playtest`).
