# The Skin API: skins and colour schemes for Polestar from your own addon

Polestar's look can be extended by another addon, with no change to Polestar:
a **colour scheme** (the grounds and text of Polestar's own style) or a whole
**skin** (palette, fonts, frame painters, the arrow, the map pins, the guide
window, the cards and the buttons). Players pick them under **Settings > Look
> Theme**, beside Polestar's own, with a live preview card and the name of
your addon beside each. The Skin API is in Polestar 0.3.8 and later, at
version 2.

This page is the short form. The developer documentation is in
[docs/skins/](skins/README.md):

| Page | Read it for |
|---|---|
| [Overview](skins/README.md) | the concepts: schemes vs skins, tokens, fonts, media, painters and hooks, variants, the lifecycle, the fallback |
| [Getting started](skins/getting-started.md) | a skin addon from zero: folder, TOC, registration, testing in game, debugging |
| [Reference](skins/reference.md) | every function, field, token (with its default), painter, hook and its parts, capability, and error message |
| [Examples and recipes](skins/examples.md) | the example addon annotated, and recipes to paste |
| [Versioning](skins/versioning.md) | the API version, capabilities, and what Polestar promises to keep working |
| [Publishing](skins/publishing.md) | naming, packaging, loading on demand, where to upload, licensing, screenshots |
| [Gaps](skins/API-GAPS.md) | what version 2 does not cover yet, and known rough edges |

The repository has a complete, commented example,
[`addon/Polestar_Skin_Example`](../addon/Polestar_Skin_Example) ("Moonlit": a
scheme and a skin with two variants and a hook on every surface), which is
never part of a Polestar release. To try it, copy (or symlink) the folder
into the game's `Interface/AddOns/` next to Polestar. The skins in the
release are complete examples too: [the skins in the
download](#more-to-read-the-skins-in-the-download).

## Quick start

1. Make an addon folder, for example `Polestar_Skin_MyMoon/`, with a `.toc`:

   ```
   ## Interface: 16001
   ## Title: Polestar Skin: My Moon
   ## Version: 1.0
   ## Dependencies: Polestar
   ## X-Polestar-Skin: my-moon
   ## LoadOnDemand: 1
   MyMoon.lua
   ```

   `## Dependencies: Polestar` makes the game load Polestar first.
   `## X-Polestar-Skin` names the ids your addon registers, so it can load on
   demand: Polestar loads it when one of its skins is wanted. Name your
   folder `Polestar_Skin_<name>` or anything that does not start with
   `Polestar_`: Polestar's install check compares every other `Polestar_*`
   folder with its own version.

2. In `MyMoon.lua`:

   ```lua
   local ADDON = ...
   local Theme = Polestar and Polestar.Theme
   if not (Theme and Theme.RegisterSkin and (Theme.API_VERSION or 0) >= 2) then return end -- no Polestar, or one too old

   local ok, err = Theme.RegisterScheme("my-moon", {
   	api = 2, name = "My Moon", addon = ADDON,
   	tokens = {
   		bg = "#12142af7", panel = "#161937fa", panelAlt = "#1f2347",
   		sidebar = "#0d0f20", footer = "#0f1124", sky = "#2b3060",
   		text = "#f2f3fa", textDim = "#c3c7de", textMuted = "#9ca1c0",
   	},
   	accent = "#afc0ff",
   })
   if not ok then print(ADDON .. ": " .. err) end

   ok, err = Theme.RegisterSkin("my-moon", {
   	api = 2, name = "My Moon", addon = ADDON,
   	base = "polestar", scheme = "my-moon", font = "fira",
   })
   if not ok then print(ADDON .. ": " .. err) end
   ```

3. `/reload`, open Polestar's settings, Look > Theme, and pick My Moon.

From there: [getting started](skins/getting-started.md) for the whole loop,
the [recipes](skins/examples.md#recipes) for painters, hooks, variants and
art.

## What version 2 offers

- **Schemes and skins** (`RegisterScheme`, `RegisterSkin`), checked as they
  register: unknown fields and tokens refused, every colour checked, the
  text held to legibility floors (grounds moved until it reads, or refused
  with `strict`), and the reason given in plain words.
- **Everything a look is made of**: any palette token, fonts and sizes by
  role, the text shadow, glyphs, the band, medallion, dart and pin textures,
  the windows' drop shadow, a tint over the game art, and which arrow and map
  icon designs players get.
- **Painters** for every kind of frame Polestar paints, with the base look's
  painter and a paint kit (fills, gradients, borders, glows, a picture of the
  game behind a frame, a tint over the game art, a store for your pieces).
- **Hooks** on what Polestar's modules draw themselves, with their parts by
  name: the arrow, the map pins, the guide window (its title, each goal's
  row, its layout and room of your own, every render, the progress, each
  tab, a part you place yourself, its menu, the frame the heads-up card sits
  on), the cards, the toasts and the buttons.
- **Variants**: one design in several versions, picked under the skin's card.
- **A resolver**: tokens and a font answered from where the player is and
  who they play (zone, continent, faction, class), repainted only when the
  answer changes.
- **Presets**: settings a skin recommends, applied and undone only when the
  player asks.
- **Load on demand**: a skin addon that names its ids in its TOC costs
  nothing until one of its skins is wanted; Polestar's own checks load only
  with the first skin another addon registers.
- **A fallback that never breaks the guide**: every painter, hook and
  resolver under `pcall`; the first error noted once and the skin off for
  the session, the player's choice kept; a refused skin the player chose
  said once in chat, naming its addon.
- **Versions and capabilities**: `api`, `API_VERSION`, `HasCapability`, so
  a skin can use a newer feature where it exists and do without elsewhere.

## Layouts: the guide window's structure, apart from its look

A layout is the guide window's structure alone: where its parts sit, which
of them show, how tall the step's header is. It carries no tokens, colours,
fonts or painters, so a skin sits on top of any layout and keeps its look.

```lua
Polestar.Theme.RegisterLayout("ledger", {
	api = 2, name = "Ledger", addon = "Polestar_Layout_Ledger",
	hooks = {
		guideInset = function(name) return name == "upnext" and 12 or 0 end,
		guideShows = function(name, default) if name == "tip" then return false end return default end,
	},
})
```

- **Hooks**: only the structure hooks (`guideLayout`, `guideRender`,
  `guidePlace`, `guideAnchor`, `guideTakes`, `guidePerson`, `guideInset`,
  `guideUpRow`, `guideShows`, `guideSpace`, `guideTitle`, `guideRow`, `guideProgress`),
  with the same arguments a skin's get. Their colours are the skin's
  tokens.
  Any other field or hook is refused.
- **Who answers**: the layout's hook where it has one, else the skin's,
  else Polestar's own. A skin that hooks the same surface keeps it under
  Polestar's own layout.
- **Layout, then skin**: for `guideTitle`, `guideRow`, `guideRender`,
  `guidePlace` and `guideProgress` the skin's hook also runs, after the
  layout's and with the same parts, so the layout lays out and the skin
  styles. The layout's answer wins when it is not nil; the skin's counts
  when the layout's is nil. For `guidePlace` the layout alone decides
  where a part goes.
- **Settings defaults**: the player sets the guide window's parts in its
  settings (`guideWindow.*`: the tabs, the step count, the buttons, the
  target bar, the progress line...), so a layout never hides those parts
  through a hook. It gives its own defaults instead:
  `defaults = { ["guideWindow.tabs"] = false, ["guideWindow.targetBar"] = false }`.
  A setting reads the player's value, else the layout's default, else
  Polestar's. Switching layout changes only the settings the player never
  set, the settings window shows the value in use, and a reset goes back
  to the layout's default.
- **A preset card**: `preset = { label = "Ledger", help = "...", set = {
  ["ui.skin"] = "ledger" } }` puts a card for the layout in the guide
  window's Presets, after Polestar's own (Standard, Compact, Transparent,
  Large text). Picking it chooses the layout, loading its addon, then
  writes `set`: look settings as a skin's preset takes, and the skin the
  layout is drawn for (`ui.skin`), never `ui.layout`. Picking one of
  Polestar's own cards goes back to Polestar's own layout. The card is
  checked while the layout is in use, and its picture is the guide window
  drawn through the layout's hooks; Polestar's own cards draw with
  Polestar's own layout whatever the layout in use. Keep `defaults` out of
  `set`: they stay the layout's soft defaults. A layout that loads on
  demand names its card in its TOC so it shows before the addon loads
  (`## X-Polestar-Layout-Preset: ledger = Ledger`); its picture is then the
  label alone. Capability `layouts.preset`.
- **Leaving**: `onLeave(id, parts, live)` runs once for each guide window
  the layout dressed: the live window (`live` true), then each copy drawing
  with the layout in use, such as the settings preview (`live` false). It
  gives that window's parts their look back and hides the pieces the layout
  made in it; the live window's call also hides pieces outside any guide
  window. A guide window's frame carries `psGuideWindow = true`, so a layout
  can tell which window a piece sits in.
- **The choice**: the setting `ui.layout`, unset for Polestar's own layout.
  `Polestar.Theme.SetLayout("ledger")` picks one (in chat: `/run
  Polestar.Theme.SetLayout("ledger")`), `Polestar.Theme.SetLayout()` goes
  back.
- **Load on demand**: a folder `Polestar_Layout_<Name>` whose TOC says
  `## X-Polestar-Layout: ledger` and `## LoadOnDemand: 1` loads at login
  when the saved layout is its own, and when the player picks it.
- **Errors**: a layout's hook, `onApply` or `onLeave` runs under `pcall`;
  the first error is noted and the layout is off for the session. A
  failing layout leaves the skin in use, and a failing skin leaves the
  layout in use.

The functions and messages are in the
[reference](skins/reference.md#layouts).

## More to read: the skins in the download

Beside Moonlit, the release carries complete skins, each an addon of its
own (`addon/Polestar_Skin_<Name>`) that loads on demand (its TOC declares
its ids with `## X-Polestar-Skin`), and each built only through this API.
Each shows one more thing the API can do; they are the best place to copy
from.

| Skin | What it is | What it shows |
|---|---|---|
| **Vellum** (`Polestar_Skin_Vellum`) | A page of the quest log: dark ink on mottled parchment, a sealing-wax accent and dart, the game's font | A **light** skin: every token given (grounds, ladder, all sixteen subject colours as inks) and still held to the legibility floors; a texture of the skin's own (`Media/paper.tga`) tinted at paint time; painters for window, panel, sidebar, inset and editbox; a preset that puts the arrow's words on a plate and colours the dart |
| **Lumen** (`Polestar_Skin_Lumen`) | Head-up: dark glass with no border or band, a cyan line and a lit tick just outside each corner, Fira Sans a size down, the flat arrow | A skin that is mostly a **frame treatment** from Polestar's white texture and `kit.glow`; a `guide` painter beside `window` (the ticks stay while the window is transparent); `fontSizes` for the whole ladder; a preset that turns the house chrome off |
| **Beacon** (`Polestar_Skin_Beacon`) | High contrast: black grounds, white Open Sans a size up, a yellow accent, strong edges | A **scheme and a skin from one addon**; washes raised through tokens; a 2-unit focus ring on fields; a preset that grows the arrow, the pins and the route line |
| **Aurora** (`Polestar_Skin_Aurora`) | The northern lights over Polestar: an aurora in the guide window's band, the same light along every other window's top, edges that glow teal and violet, a violet halo, a deep night, a green-teal accent | Textures of the skin's own drawn as **light** (`SetBlendMode("ADD")`, `Media/curtain.tga`, `Media/veil.tga`); `kit.gradient` for the ground and gradient pieces of its own; `shadow` in a colour; the `guideTitle` hook laying the aurora over the band wherever it is, and `guideProgress` filling the progress teal into violet |
| **Hairline** (`Polestar_Skin_Hairline`) | The lightest touch: frames of single hairlines on near-black glass, outlined buttons and fields, light condensed type (Barlow Semi Condensed) with room round it, an open chevron arrow, square map pins, the class colour as the accent | Painters that take a look apart (buttons lose their fill); a **font of the skin's own** given as files; `media.dart` / `dartEdge` / `medallion` / `pinFill` / `pinRim`; `shadow = false`; a preset for spacing and `ui.classAccent`; the `guideTitle` hook restyling the rule |
| **Umbra** (`Polestar_Skin_Umbra`) | Dark mode: charcoal windows sunk in a soft vignette, a steel glow on their edges and from the top, a deep, wide shadow; Flat, or WoW Forever, Blizzard or Classic with their art dimmed | A scheme and a skin from **one table of colours**; `variants` that change the base look; `artTint`; gradients on Polestar's white texture for the vignette and the glow; `shadow` |
| **Waymark** (`Polestar_Skin_Waymark`) | The land you're levelling in: dark chart paper with a faint graticule, ruled in brass, a compass rose in each window's corner, the step bar underlined by a dashed route, the continent's loading screen behind the header and down the settings' sidebar, a compass-needle arrow, brass-ringed map marks | `resolve(ctx)`; `kit.gameArt` and `kit.crossfade` for a picture from the player's own client (named by path, never shipped); a tiled texture of the skin's own; `media.dart` / `dartEdge` / `medallion`; the `guideTitle` hook drawing over a part |
| **Lanterns** (`Polestar_Skin_Lanterns`) | Ten moods, each a pair of colours: rounded windows, pill tabs and buttons with a pool of light under the selected tab, tinted grounds, two soft lights in opposite corners, a two-tone progress line | `variants`; `accent2`; painters that **replace** Polestar's square frames with art of the skin's own (a rounded nine-slice, pills) and `shadow` to go with them; `kit.glow`; `guideProgress` and `guideTitle` hooks |
| **Sheen** (`Polestar_Skin_Sheen`) | Glass and gloss: bevelled translucent panes, a gloss over every button and the selected tab, a band of light and a glare across each window, a wide soft shadow, the class colour running into the accent on a glossy progress line | `shadow`; `resolve(ctx)` (class colour, `pinRing`); `kit.glow` and a texture of its own (the glare); painters for buttons, dropdowns, tiles and tabs; `Theme.SkinKit.store` from the `guideProgress` hook |

Their art is drawn in code (`node tools/polestar.js media skin-addons`,
`tools/media/skin-addons.js`) or is the player's own client's (Waymark's
loading screens, by path); Hairline's typeface is OFL (`THIRD_PARTY.md`).

## Rationale, compared with Details!

Details! (the damage meter) has had third-party skins for years, through
`Details:InstallSkin(name, skinTable)`; it was the model to measure against.
How it works, in short: a skin is keyed by its display name and must name
one texture file holding every piece of the window's frame at fixed
coordinates; it carries author, version, site and description; a table of
the window's own settings that the skin writes over the player's when it is
applied (except a list of behaviour settings it may not touch); anchor
offsets for the title bar's icons; options for its status bar; a `callback`
run after the skin is applied, optional `OnUpdate` "control scripts", and
`skin_options`, extra buttons the skin adds to the options panel. Details!
caches each installed skin table in its saved variables so a skin keeps
working after its addon is removed or outdated; a window whose saved skin is
not installed yet uses the default and switches when the skin arrives.
`InstallSkin` answers true or false, with no reason.

What Polestar took, and what it does differently:

| | Details! | Polestar | Why |
|---|---|---|---|
| Waiting for a skin | A window remembers a skin not yet installed and switches when it is | The same: a saved `ui.skin` waits, drawn as Polestar meanwhile, applied when the addon registers (and Polestar loads an addon that declares the skin) | Taken as is: load order and disabled addons should not cost the player their choice |
| Metadata | author, version, site, desc | `author`, `version`, `desc`, plus `addon` (required) | The picker names the addon so a player knows whose skin it is and where to report |
| After-apply callback | `callback(skin, instance)` | `onApply`, `onLeave` | Taken; `onLeave` added so a skin can tidy its own frames |
| Identity | The display name is the key | A stable `id`, the `name` separate | A skin can rename itself (or be translated) without losing every player's saved choice |
| Look | One texture atlas at fixed coordinates, plus settings | Tokens, fonts, media by name, painters per kind of frame, and hooks on the frames Polestar's modules draw, with their parts by name | Polestar has many frames of many shapes, and a palette every frame reads; painters keep a skin working when Polestar adds frames of a known kind |
| Player settings | The skin writes its values over the player's window settings | A skin never writes a setting by itself: it is a layer under the player's own accent, border, ground and arrow colours. Settings it recommends (`preset`) are applied only when the player asks, and undone in one click | Switching skins must not reset what a player chose (Polestar's rule: never change a player's settings behind their back) |
| Errors | Callbacks are not isolated; `InstallSkin` returns false without a reason | Every painter, hook and resolver under `pcall`; the first error noted once, the skin off for the session; refusals and corrections say why | A broken third-party skin must never break the guide; an author needs the reason |
| Legibility | Not checked | Every scheme, skin and variant held to the text floors, corrected or refused | Polestar is read at arm's length over a busy game world |
| Versioning | None | `api`, `API_VERSION`, `HasCapability` | Lets a skin target a newer feature and still load on an older Polestar |
| Caching in saved variables | Yes, unless `no_cache` | No | Painters are functions and cannot be saved; a cached copy of an outdated skin would keep drawing after its author fixed it; a removed addon's skin should go with it (the choice waits instead) |
| Control scripts (`OnUpdate`) | Yes | No | Polestar runs nothing every frame while idle; a skin that animates can do it in its own `onApply` frames, at its own cost |
| Per-skin options | `skin_options` in the options panel | `variants`: versions of the skin, each with its own card under the skin's; free options stay the skin's own (its saved variable, an entry in the guide window's menu) | Players choose a version by eye; Polestar's settings keep to Polestar's own |
| Preview | The window itself | A card per skin and per variant in the picker, drawn from its own palette and font without applying it | Players choose before they switch |
