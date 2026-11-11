# Skins for Polestar: developer documentation

Polestar's look can be changed by another addon, with no change to Polestar
itself. Your addon registers a **colour scheme** or a whole **skin** through
`Polestar.Theme`, and players pick it in Polestar's settings next to
Polestar's own, with a preview card and your addon's name beside it. This
folder is for addon authors who want to build one.

| Page | Read it for |
|---|---|
| this page | the concepts: schemes vs skins, tokens, fonts, media, surfaces, lifecycle, fallback |
| [getting-started.md](getting-started.md) | a skin addon from zero: folder, TOC, registration, testing in game, debugging |
| [reference.md](reference.md) | every function, field, token (with meaning and default), surface, hook, event, capability, validation rule and error message |
| [examples.md](examples.md) | the example addon annotated, and recipes: recolour only, new fonts, a custom header texture, a per-surface tweak, a skin on a game look |
| [versioning.md](versioning.md) | the API version, capabilities, and what Polestar promises to keep working |
| [publishing.md](publishing.md) | naming, packaging, CurseForge and GitHub, licensing, screenshots |
| [API-GAPS.md](API-GAPS.md) | what version 1 does not cover yet, and known rough edges |

A complete, commented example lives in the repository:
[`addon/Polestar_Skin_Example`](../../addon/Polestar_Skin_Example) ("Moonlit",
a scheme and a skin). It is never part of a Polestar release.

## What a skin can change

Polestar draws everything from one **palette** (named colours), one **type
ladder** (font faces and sizes by role), a few pieces of **media** (the
header band's sky and stars, the map pins' medallion), and a set of
**painters**, one per kind of frame (window, panel, button, edit box...).
Behind the painters sit **sizes** (row heights, button heights, the guide
window's layout) that come with each of Polestar's own looks. A skin addon
can change the first four and pick from the fifth.

Polestar ships six looks of its own, and every skin you register **extends
one of them** (its `base`):

| Base | Character |
|---|---|
| `polestar` | the house style: a navy night, hairline borders, a starlit header band, the game's font. The only base that takes a colour scheme. |
| `halo` | no frame: a dark veil with soft edges under the text, Fira Sans, the game's gold |
| `hearth` | Polestar's frames in warm game colours: a brown gradient window, the client's red buttons |
| `forever`, `blizzard`, `classic` | the client's own window art (WoW Forever's, the retail-style art, the vanilla files) around Polestar's content |

## Schemes vs skins

A **colour scheme** is the house style in other colours. It gives the six
*grounds* (window, panel, control, sidebar, footer, sky) and the *text
ladder* (primary, secondary, muted), optionally hairline ink, stars, shade,
scrim, on-accent text and shadow, plus an accent that stands in for Polestar
gold. Everything else (frames, fonts, sizes, the status and subject colours
such as quest gold and NPC blue) stays Polestar's. A scheme shows under
**Colour scheme** and works with the Polestar skin and any skin built on it.

A **skin** starts from a base look and changes what it names: any palette
token, the font and sizes, the text shadow, glyphs, the band and medallion
textures, which arrow and map icon design players get, and how any kind of
frame is painted. A skin on `polestar` may also *wear* a scheme (yours or a
built-in), which then overrides the player's scheme while the skin is in
use. A skin shows under **Skin**.

Rule of thumb: start with a scheme. Add a skin when you want fonts,
painters, media or another base.

```lua
local ADDON = ...
local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin) then return end -- no Polestar, or one before 0.3.7

-- A scheme: grounds and text. Players can pick it on its own.
local ok, err = Theme.RegisterScheme("ov-moss", {
	api = 1, name = "Moss", addon = ADDON,
	tokens = {
		bg = "#121a12f7", panel = "#172017fa", panelAlt = "#1f2b1f",
		sidebar = "#0c120c", footer = "#0e150e", sky = "#2a3d2a",
		text = "#f1f7ee", textDim = "#c4d3bf", textMuted = "#96a892",
	},
	accent = "#b7e39a",
})
if not ok then print(ADDON .. ": " .. err) end

-- A skin wearing it, in Inter, with Halo's arrow.
ok, err = Theme.RegisterSkin("ov-moss", {
	api = 1, name = "Moss", addon = ADDON,
	base = "polestar", scheme = "ov-moss", font = "inter", arrow = "halo",
})
if not ok then print(ADDON .. ": " .. err) end
```

## Tokens

A token is a named colour in the palette, such as `bg`, `text`, `quest`,
`border` or `title`. Polestar's frames never hold colours of their own: they
ask `Theme.Color("panel")` when they paint, so a change to a token repaints
everything that uses it. Tokens come in groups:

- **grounds** and the **text ladder**: what a scheme gives;
- **status and subjects**: `success`, `warning`, `danger`, `quest`, `npc`,
  `item`, `place`, `dungeon`, `rare`... the same in every scheme so a quest
  reads the same gold everywhere; a skin may recolour them;
- **washes**: translucent ink for hairlines, hover, selection, tracks;
- **roles**: `title`, `link`, `todo`, `icon`, `buttonText`... derived from the
  groups above on the house style, given outright by the other looks;
- a few for the game looks' art.

Every token, its meaning and its default in each base is in the
[reference](reference.md#tokens). The **player's own choices sit on top** of
every skin: their accent colour (or class colour), their window border
colour, their arrow colours, and on the house style their background, panel
and sidebar colours and brightness. A skin is a layer under the player, never
over them, and never writes a setting.

## Fonts

A skin names the face every Polestar string uses while the player's font
setting is "The skin's font" (the default): one Polestar ships (`game`,
`inter`, `fira`, `opensans`) or your own files, at three weights. Sizes are
set per **role** (`hero`, `display`, `title`, `heading`, `body`, `goal`...);
the player's text size scales them. Chinese and Korean clients always use
the game's font.

## Media

Three textures may be yours: the header band's sky mask and its stars (both
1024x128, drawn at 1:1 from the top left, tinted with the `sky` and `star`
tokens) and the medallion under map pin glyphs. Polestar's own glyphs
(`bug`, `close`, `gear`, the goal icons...) can be swapped by name for
another glyph or your own texture. The arrow and the map icons are chosen
from Polestar's designs by name.

## Surfaces and painters

Polestar paints each frame by **kind**: `window`, `guide` (the guide
window), `toast`, `panel`, `sidebar`, `inset`, `button`, `tile`, `dropdown`,
`editbox`, `checkbox`, `tab`, `close`, `scrollbar`. A skin may supply a
**painter** for any kind: a function that receives the frame, the base
look's painter for that kind, and a **paint kit** (a fill, a gradient, a
pixel-exact border, a hover wash, and a store for the skin's own pieces).
Call the base painter and add to it, or paint the frame from scratch.

Three **hooks** reach the art Polestar's modules draw themselves: `arrow`
(after the waypoint arrow repaints), `pin` (after a map pin is built or
restyled) and `guideTitle` (after the guide window's style is applied: a
title bar and a close square in place of the band).

Painters run again whenever anything they depend on changes, so they must be
idempotent: create once, then show, hide, tint and place.

## Lifecycle

1. **Load order.** `## Dependencies: Polestar` in your TOC makes the game
   load Polestar first, so your file can register at the top level. Without
   it, register on `ADDON_LOADED` for `"Polestar"`.
2. **Registration** validates the spec (shape, ids, colours, and that the
   text reads on the grounds) and answers `ok, message`. A refused spec
   registers nothing and says why. Ids are first come, first served, and a
   skin cannot be registered twice in a session: changes need `/reload`.
3. **Picking.** The player chooses under Settings > Look > Theme. A saved
   choice that names a skin not yet registered draws Polestar's own look and
   **waits**: when the addon registers it, even later in the session, it is
   applied at once. Disabling a skin addon does not lose the player's choice.
4. **In use.** `onApply(id)` runs when your skin becomes the one in use (at
   login too); painters and hooks run as frames paint; `onLeave(id)` runs when
   another skin replaces yours.
5. **Repaints** happen on every setting change, skin change and UI scale
   change; everything is recomputed from the palette, so a skin never caches
   colours.

Polestar keeps nothing of your spec in its saved variables: a removed addon's
skin goes with it, and the player's saved choice waits for its return.

## Fallback and errors

A skin must never break the guide. Every painter, hook, `onApply` and
`onLeave` runs under `pcall`. The first error is recorded once (it shows in
`/polestar report`), one chat line names your skin and addon, and your skin
is turned off for the rest of the session: Polestar repaints everything in
its own look and keeps the player's choice, so a `/reload` with a fixed
addon brings it back. Details in the
[reference](reference.md#run-time-errors).

## Versions and capabilities

`Theme.API_VERSION` is `1`. It rises only when a spec written for an older
version would no longer mean the same; additions come as **capabilities**
(`Theme.HasCapability("surfaces.pin")`), so a skin can use a newer feature
where it exists and do without elsewhere. A spec may say which version it
was written for (`api = 1`); one written for a newer Polestar is refused
cleanly. The policy is in [versioning.md](versioning.md).
