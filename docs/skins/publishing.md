# Publishing a skin

A skin is an addon of its own: you build it, you publish it, you support it.
Polestar shows your addon's name beside your skin so players know whose it
is. This page covers naming, packaging, where to upload, licensing, and
screenshots.

## Naming

- **Folder and TOC**: `Polestar_Skin_<Name>` (`Polestar_Skin_Ember`,
  `Polestar_Skin_Ember.toc`). Polestar's install check warns players about
  `Polestar_*` folders whose version lags behind its own; `Polestar_Skin_*`
  is exempt, so your addon keeps its own version numbers. Any name not
  starting with `Polestar_` is fine too. Never `Polestar_<Something>`
  without `Skin_`: that reads as one of Polestar's own parts and trips the
  check.
- **TOC title**: `## Title: Polestar Skin: <Name>` keeps the AddOns list
  sorted with Polestar's parts; `## Category: Polestar` and `## Group:
  Polestar` group it with them on clients that support those fields.
- **Ids** (`RegisterSkin("ember", ...)`) are forever: they are what players'
  settings store. Pick ids that will not collide with other skin authors
  (`ember` is likely to; `ttk-ember` or `ember-ttk` is not), and never
  rename one after release. The displayed `name` can change freely.
- **One addon, several skins** is fine: register each with its own id. A
  family ("Ember", "Ember Light", "Ember Mono") usually shares one scheme.

## What goes in the zip

```
Polestar_Skin_Ember/
  Polestar_Skin_Ember.toc
  Ember.lua
  README.md          (what it is, screenshots, where to report problems)
  LICENSE
  Fonts/             (only if you ship font files; see Licensing)
  Media/             (your band, stars, medallion, glyph textures)
```

Zip the folder itself (the zip contains `Polestar_Skin_Ember/...`), so
players and addon apps unpack it straight into `Interface/AddOns`. Keep the
TOC's `## Version` in step with your release tag.

Textures must be what the client loads: `.tga` (32-bit, uncompressed or
RLE) or `.blp`, with power-of-two sizes. The header band and its stars are
1024x128; a medallion is square (64x64 or 128x128 is plenty). Font files are
`.ttf`. Paths in your spec are full, from `Interface\\AddOns\\<folder>\\`.
Polestar cannot check that a file exists: a missing texture draws blank or
green, a missing font falls back to the game's.

## Dependencies and client versions

- `## Dependencies: Polestar` in your TOC: the game loads Polestar first and
  disables your addon when Polestar is missing. Use `## OptionalDeps:
  Polestar` only if your addon does something useful without Polestar.
- `## Interface: <build>`: the client build. Copy it from the Polestar you
  test against (`Polestar/Polestar.toc`); an out-of-date number makes the
  game mark the addon "out of date" (players can still load it).
- Your addon needs **Polestar 0.3.7 or newer** (the first with the Skin API).
  Say so on the listing. On older Polestars the guard at the top of your
  file returns and nothing happens; players do not see an error, only no
  skin.
- A newer Polestar may add capabilities your skin does not use: nothing to
  do. If you later use one, test for it with `Theme.HasCapability` so the
  same release works on both ([versioning](versioning.md)).

## Where to upload

- **CurseForge** and **Wago**: a new addon project for World of Warcraft:
  Forever (the Classic game version matching the TOC's Interface). Mark
  **Polestar as a required dependency** on the listing, so the app installs
  it with your skin. Category: UI / Skins (or whatever the site offers
  closest to it).
- **GitHub** (or any Git host): a repository with the addon folder at its
  root or under `addon/`, and a release with the zip attached per version
  tag. A `.pkgmeta`-style packager workflow is optional; the zip is a folder.
- Your own site or Discord is fine too; say where updates come from.

On the listing, state in the first lines: it is a skin for Polestar, needs
Polestar 0.3.7+, what it changes (scheme, fonts, frames), and where to
report problems. Players who run into an error see a chat line naming your
addon ([run-time errors](reference.md#run-time-errors)); make it easy for
them to find you.

## Licensing

Your skin is your code and your art. Polestar is GPL-3.0-only, with an
additional permission for skin addons in
[LICENSE-EXCEPTION.md](../../LICENSE-EXCEPTION.md#skin-addons): an addon that
changes Polestar's look only by calling the documented Skin API may be
licensed as its author chooses.

- Pick a licence for your addon (MIT, GPL-3.0, CC BY, all rights reserved),
  ship the text as `LICENSE`, and name it with `## X-License` in the TOC.
- The permission does not cover an addon that copies or modifies Polestar's
  code. The example addon (`Polestar_Skin_Example`) is CC0-1.0, so copying
  its painter or any of its code into your skin carries no conditions.
- **Fonts**: ship only fonts whose licence allows redistribution (SIL OFL,
  Apache). Polestar's bundled Inter, Fira Sans and Open Sans are available
  to your skin by name (`font = "fira"`) without shipping them. Do not ship
  the game's fonts.
- **Art**: Polestar's own art, textures and fonts keep their licences
  ([THIRD_PARTY.md](../../THIRD_PARTY.md)); do not copy them, textures from
  other addons, or the game client's files into your zip. Reference Polestar's glyphs
  by name (`icons = { bug = "flag" }`) and the client's textures by path if
  you need them; draw your own band, stars and medallion.
- Polestar's name: "for Polestar" and "Polestar skin" in your title and
  description are fine and helpful. Do not present the skin as made by
  Polestar's authors.

## Screenshots

Players pick skins by eye; show them what they get.

- Take screenshots at the game's default UI scale, 1920x1080 or wider,
  with Polestar's settings window open on **Look > Theme** (your card
  selected) and the **guide window** visible over the world at the same
  time: those two show grounds, text ladder, controls, band, accent and the
  guide window's own layout in one frame.
- One more with the **waypoint arrow** and a **map** open if your skin picks
  an arrow or map icon design or ships a medallion.
- Show the skin **as registered**, before the player's own accent or
  background colour; say in the caption which Polestar settings were at
  their defaults.
- Keep the shot honest: no retouching of colours, no other addons' frames in
  the way unless the skin is meant to match them.
- Polestar's own preview renders, for comparison of framing, are in
  `docs/preview/` of the repository.

## Releasing an update

1. Change what you need; `/reload` and look at every window you touched
   (settings, guide menu, guide window, a toast, the arrow, a map).
2. Bump `## Version` in the TOC and `version` in your specs.
3. Zip the folder, tag, upload, and note the change on the listing. If the
   update **needs a newer Polestar** (a new capability used without a
   guard), say so in the first line of the notes.
4. Never change an id. If you must replace a skin, register the new id and
   keep the old one registered as an alias (same spec) for a release or two,
   so players' saved choice still resolves.

## Support

Problems players report come in three kinds, and the chat line or
`/polestar report` tells them apart:

- **Refused at registration**: your skin is missing from the picker and the
  debug log holds `skin <id> (<addon>): refused: <reason>`. Fix the spec.
- **Failed in the session**: the player saw "The skin <name> (from <addon>)
  ran into an error" and Polestar's look stood in; `Polestar.Theme.SkinInfo("<id>").failed`
  has the error text with your file and line. Fix the painter or hook.
- **Looks wrong but works**: usually the player's own colour settings over
  your skin, or a Polestar design change under a token you did not set. Ask
  for a screenshot with Look > Theme open.

If Polestar itself seems at fault (an API answer that contradicts the
[reference](reference.md)), open an issue on Polestar's repository with the
spec that shows it: the Skin API is tested against its documentation.
