# Releasing the addon

`forge release` builds and releases the addon itself; `forge changelog` keeps the changelog fragments.
Both are the `forge-release` crate (`rust/crates/forge-release`). [RELEASING.md](../RELEASING.md) has
the whole release, step by step; this page has the commands.

| Command | What it does |
|---|---|
| `forge release version [<x.y.z>]` | prints the version, or sets it in `package.json`, `guides/pack.json` and every addon TOC |
| `forge release pack [<dir>]` | the release zips and `SHA256SUMS`; given another pack, that pack's zip |
| `forge release notes <x.y.z>` | the release notes (GitHub, CurseForge, Discord) from the version's CHANGELOG.md section |
| `forge release credits` | rewrites `addon/Polestar/Core/Credits.lua` (the Guiding Stars page) |
| `forge changelog add\|check\|show\|build` | the fragments in `changes/`: write one, check them, preview the release, build CHANGELOG.md |

Every command reads the checkout above the working directory (or above the forge binary); `--root
<dir>` names another one. `--help` on each shows its options.

<!-- ci -->
```sh
forge release --help
forge release pack --help
forge release version --help
forge release notes --help
forge release credits --help
forge changelog --help
```

## The version

The version lives in `package.json`, in `guides/pack.json` (the compiler writes it into
`Polestar_Guides.toc`) and in the `## Version` line of every addon TOC.

```sh
forge release version            # print it; exit 1 if guides/pack.json or a TOC disagrees
forge release version 0.2.0      # set it everywhere; nothing is written when a file has no version to set
```

Versions are `x.y.z`, or `x.y.z-rc.1` for a release candidate.

## The zips

`forge release pack` in the checkout compiles our guides into `addon/Polestar_Guides` (with its race
parts, and its texts in the language folders `Polestar_<locale>`), then writes to `dist/`:

| File | Contents |
|---|---|
| `Polestar-<version>.zip` | `Polestar` (with `LICENSE` and the players' `README.txt`), `Polestar_Guides` and its parts, `Polestar_Nav`, `Polestar_QuestDB` and `Polestar_ItemDB` when built, `Polestar_Codex`, the language folders `Polestar_<locale>` (guide texts and names). The old `Polestar_Guides_<locale>` and `Polestar_Names_<locale>` are never shipped: `pack` names any left in `addon/` so they get deleted |
| `Polestar_Recorder-<version>.zip` | `Polestar_Recorder` with `LICENSE` |
| `SHA256SUMS` | both zips' checksums, as `sha256sum -c` reads them |

It stops before writing anything when the Codex is not built (`forge data codex`), was built with local
extras, or names a local-only source; when an addon's TOC is missing; when the guides have errors; or
without reference data (`forge data build`). A TOC whose version is not `package.json`'s is a warning.

The zips are reproducible on every machine: entries in a fixed order (each folder, then its files by
name; hidden files left out), one fixed timestamp (2026-01-01 00:00), and deflate at level 9 through
zlib-rs, whose output is zlib-ng's byte for byte. The earlier Node tool gave the same bytes where Node
used zlib-ng; Node's bundled zlib gives other bytes for the same files.

Given another pack (a folder holding `pack.json`: `<dir>`, `--pack`, or the nearest one above the
working directory), `forge release pack` builds it with our guides as context and writes
`<pack>/dist/<folder>-<version>.zip`, the version taken from its `pack.json`. `--no-data` builds it
without reference data, as `forge guide compile --no-data` does.

## The changelog fragments

Each change's entry is its own file in `changes/` ([changes/README.md](../../changes/README.md)), so
pull requests never touch the same lines of CHANGELOG.md:

```sh
forge changelog add players --text "Walks between zones go through the real tunnels."
forge changelog check            # CI runs this on every pull request
forge changelog show             # what the next release gathers, as a ## Unreleased section
forge changelog build 0.2.0      # writes ## 0.2.0 (<today>) into CHANGELOG.md, deletes the fragments
```

`add` takes the section (`players`, `authors`, `contributors`, `forge`) and the entry from `--text` or
stdin; plain text becomes one list item wrapped at 78 columns, and the file is named after its first
words (`--name` names it). `build` takes `--date YYYY-MM-DD` (default today, UTC) and refuses a version
CHANGELOG.md has already, an empty `changes/` or a faulty fragment.

## The release notes

`forge release notes 0.2.0` writes `dist/notes-0.2.0.md` (GitHub: players' and guide authors'
entries), `dist/notes-curseforge-0.2.0.md` (players') and `dist/notes-discord-0.2.0.txt` (posts of at
most 2,000 characters). Each paragraph and list item is joined onto one line, since GitHub shows every
line break of a release's notes, and each file starts with a `[[REPLACE ...]]` line for the intro.

## The credits

`forge release credits` rewrites `addon/Polestar/Core/Credits.lua` from `data/credits.json` (the
supporters, highest total first; amounts are never stored) and the merged pull requests on GitHub,
fetched with the GitHub CLI (`gh`, logged in): contributors by merged pull requests, most first, bots
and the logins in `exclude` left out, `names` mapping a login to the name shown.
