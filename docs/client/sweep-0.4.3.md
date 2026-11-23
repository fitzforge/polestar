# Polestar Client: the folders Polestar 0.4.3 no longer ships

Polestar 0.4.3 folds the release zip from 45 addon folders to 22 (#3507). The
folders below were their own addons up to 0.4.2.2; from 0.4.3 their files are
inside `Polestar`, `Polestar_Guides_Alliance`, `Polestar_Guides_Horde` and
`Polestar_Skins` (a new folder in the zip). The game loads a folder that is still in `Interface/AddOns`,
so an update must delete them. The same list is `FOLDED_ADDONS` in
`rust/crates/forge-release/src/addons.rs` and `tools/lib/dsl/project.js`, and
`FOLDED` in `addon/Polestar/Core/Data.lua` (Polestar names any left installed at
login; `polestar install` deletes them).

| Folder | Now in |
|---|---|
| `Polestar_Looks` | `Polestar/Theme/Looks/` |
| `Polestar_SkinAPI` | `Polestar/Theme/SkinCheck.lua` |
| `Polestar_TabStyles` | `Polestar/UI/TabStyles/` |
| `Polestar_Experimental` | `Polestar/Experimental/` |
| `Polestar_Layout_Atlas` | `Polestar_Skins/Layouts/Atlas/` |
| `Polestar_Skin_Vellum`, `Polestar_Skin_Lumen`, `Polestar_Skin_Beacon`, `Polestar_Skin_Aurora`, `Polestar_Skin_Hairline`, `Polestar_Skin_Umbra`, `Polestar_Skin_Waymark`, `Polestar_Skin_Lanterns`, `Polestar_Skin_Sheen`, `Polestar_Skin_Atlas` | `Polestar_Skins/Skins/<Name>/` |
| `Polestar_Guides_Human`, `Polestar_Guides_Orc`, `Polestar_Guides_Dwarf`, `Polestar_Guides_NightElf`, `Polestar_Guides_Scourge`, `Polestar_Guides_Tauren`, `Polestar_Guides_Gnome`, `Polestar_Guides_Troll`, `Polestar_Guides_Skyborne` | `Polestar_Guides_Alliance/` and `Polestar_Guides_Horde/` (`Guides_<Race>.lua`, `Legs_<Race>.lua`) |

## Never deleted

- `Polestar_Skin_Example`, the Skin API's example: it never ships, a skin author
  copies it in by hand. Its TOC says `## Author: Polestar`.
- Every other `Polestar_Skin_*` (and `Polestar_Layout_*`) folder: skin and layout
  addons by other authors, named so by the Skin API's convention
  (docs/skins/publishing.md).
- `Polestar_Recorder`, which ships in its own zip.

## What the Client does today (0.1.8)

`apps/client/src-tauri/src/addons.rs`: on an update, `installed_folders` takes
every `Polestar` / `Polestar_*` folder (but `Polestar_Recorder`) whose TOC says
`## Author: Polestar` (or a 0.4.2 walking-map region folder) as Polestar's, and
the ones the new zip lacks are swapped out (`obsolete`). 22 of the 24 folders
above carry `## Author: Polestar`, so 0.1.8 already deletes them; it keeps
`Polestar_Skin_Atlas` and `Polestar_Layout_Atlas` (`## Author: TTik3r`), which
no release shipped (only the 0.4.3 previews). It would also delete
`Polestar_Skin_Example`, and any other author's skin whose TOC gave
`## Author: Polestar`.

## The 0.1.9 work item

- Sweep the 24 folders above by name, whatever their TOC's author line (a test
  in `addons.rs` like the `Polestar_Nav_R` one: a 0.4.2.2 install with them and
  a 0.4.3 preview's Atlas folders, a 0.4.3 zip without them, each gone after
  the update; `Polestar_Skins` installed).
- Never take a `Polestar_Skin_*` or `Polestar_Layout_*` folder for Polestar's
  unless it is one of the ten skins or `Polestar_Layout_Atlas` above: the
  example and other authors' skins stay, whatever their TOC's author line (a
  test with `Polestar_Skin_Example` and `Polestar_Skin_Joes`, both
  `## Author: Polestar`, kept).
