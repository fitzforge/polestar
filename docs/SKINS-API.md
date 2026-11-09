# The Skin API: skins and colour schemes for Polestar from your own addon

Polestar's look can be extended by another addon, with no change to Polestar:
a **colour scheme** (the grounds and text of Polestar's own style) or a whole
**skin** (palette, fonts, frame painters, arrow and map icons). Players pick
them under **Settings > Look > Theme**, beside Polestar's own, with a live
preview card, and the name of your addon beside each.

This page is the reference and a walkthrough. The repository has a complete,
commented example, [`addon/Polestar_Skin_Example`](../addon/Polestar_Skin_Example)
("Moonlit": a scheme and a skin), which is never part of a Polestar release.

- [Quick start](#quick-start)
- [The API at a glance](#the-api-at-a-glance)
- [RegisterScheme](#registerscheme)
- [RegisterSkin](#registerskin)
- [Tokens](#tokens)
- [Legibility](#legibility)
- [Painters and the paint kit](#painters-and-the-paint-kit)
- [Hooks: the arrow and the map pins](#hooks-the-arrow-and-the-map-pins)
- [When things go wrong](#when-things-go-wrong)
- [Saved choices, load order, late registration](#saved-choices-load-order-late-registration)
- [Versions and capabilities](#versions-and-capabilities)
- [Walkthrough: Moonlit](#walkthrough-moonlit)
- [Four more to read: the showcase skins](#four-more-to-read-the-showcase-skins)
- [Rationale, compared with Details!](#rationale-compared-with-details)

## Quick start

1. Make an addon folder, for example `MoonlitForPolestar/`, with a `.toc`:

   ```
   ## Interface: 16001
   ## Title: Moonlit for Polestar
   ## Version: 1.0
   ## Dependencies: Polestar
   Moonlit.lua
   ```

   `## Dependencies: Polestar` (or `## OptionalDeps: Polestar`) makes the game
   load Polestar first. Name your folder anything that does not start with
   `Polestar_`, except `Polestar_Skin_<name>`: Polestar's install check
   compares every other `Polestar_*` folder with its own version.

2. In `Moonlit.lua`:

   ```lua
   local ADDON = ...
   local Theme = Polestar and Polestar.Theme
   if not (Theme and Theme.RegisterSkin) then return end -- no Polestar, or one too old

   local ok, err = Theme.RegisterScheme("moonlit", {
   	api = 1, name = "Moonlit", addon = ADDON,
   	tokens = {
   		bg = "#12142af7", panel = "#161937fa", panelAlt = "#1f2347",
   		sidebar = "#0d0f20", footer = "#0f1124", sky = "#2b3060",
   		text = "#f2f3fa", textDim = "#c3c7de", textMuted = "#9ca1c0",
   	},
   	accent = "#afc0ff",
   })
   if not ok then print(ADDON .. ": " .. err) end

   ok, err = Theme.RegisterSkin("moonlit", {
   	api = 1, name = "Moonlit", addon = ADDON,
   	base = "polestar", scheme = "moonlit", font = "fira",
   })
   if not ok then print(ADDON .. ": " .. err) end
   ```

3. `/reload`, open Polestar's settings, Look > Theme, and pick Moonlit.

To try the repository's example, copy (or symlink)
`addon/Polestar_Skin_Example` into the game's `Interface/AddOns/` next to
Polestar. `forge install` and the release zips never include it.

## The API at a glance

All of it is on `Polestar.Theme`:

| Function | What it does |
|---|---|
| `RegisterScheme(id, spec) -> ok, message` | Adds a colour scheme |
| `RegisterSkin(id, spec) -> ok, message` | Adds a skin |
| `API_VERSION` | `1` |
| `HasCapability(name) -> bool`, `Capabilities() -> { name, ... }` | What this Polestar offers ([below](#versions-and-capabilities)) |
| `SkinChoices()`, `SchemeChoices()` | `{ { value, text, addon?, desc?, author? }, ... }`: Polestar's own first, then the registered ones in the order they registered |
| `SkinInfo(id)`, `SchemeInfo(id)` | `{ id, name, addon, author, version, desc, base, scheme, builtin, failed }` |
| `SkinId()` | The skin in use, as drawn (a failed or missing skin is `"polestar"`) |
| `SkinKey()` | The **built-in look** the skin in use is drawn from: a registered skin's `base` |
| `SkinScheme()` | The scheme the skin in use brings, or nil |
| `DrawSkinCard(frame, id)`, `DrawSchemeCard(frame, id)` | The picker's preview: draws that skin or scheme on `frame` without touching the live look |
| `PaletteFor(id)` | The palette a skin would give, with the player's own colours |
| `Color(token)`, `Accent()`, `Wash(name)`, `Media(name)` | Read the palette in use from your painters |
| `SkinKit` | The paint kit ([below](#painters-and-the-paint-kit)) |

`ok` is `false` when the spec is refused, and `message` says why, in English,
for you the author (`"tokens.textMuted is missing (a scheme gives bg, ...)"`).
When `ok` is `true`, `message` is usually nil; it is a sentence when Polestar
corrected something ([Legibility](#legibility)). Refusals and corrections are
also in Polestar's debug log (`/polestar debug`).

**Ids** are a word of letters, digits, `_` or `-`, starting with a letter, 32
characters at most; they are what the player's settings store (`ui.skin`,
`ui.scheme`), so never change one once published. The first addon to register
an id keeps it; a second registration of the same id is refused. Polestar's
own ids (`polestar`, `halo`, `hearth`, `forever`, `blizzard`, `classic`,
`dusk`, `night`, `graphite`, `ellesmere`) are taken.

**Fields common to both specs:**

| Field | Required | |
|---|---|---|
| `name` | yes | Shown in the picker, as given (1-40 characters; translate it yourself if you like) |
| `addon` | yes | Your addon's folder name (the `...` of your file), shown beside the name and in error notes |
| `api` | no (1) | The Skin API version you wrote for; a newer one than this Polestar's is refused |
| `author`, `version` | no | Strings |
| `desc` | no | One sentence, 200 characters at most |
| `strict` | no | `true`: refuse instead of correcting text that would not read |

An unknown field is refused (it is usually a typo), so a spec written for a
later API version must say `api = 2` and is then refused cleanly here.

**Colours** are `"#rrggbb"`, `"#rrggbbaa"`, `{ r, g, b }` or `{ r, g, b, a }`
with every number from 0 to 1, or `{ r = , g = , b = , a = }`.

## RegisterScheme

A scheme is Polestar's own style in other colours: Polestar's frames, band,
hairlines and fonts with your grounds and text. The player picks it under Look
> Theme > Colour scheme, and it works with the Polestar skin and any skin built
on it.

```lua
Theme.RegisterScheme(id, {
	name = "...", addon = ADDON,
	tokens = { ... },          -- required, see below
	accent = "#rrggbb",        -- optional: stands in for Polestar gold
	washes = { border = 0.1 }, -- optional: the white ink's alphas
	strict = false,
})
```

`tokens` must give the six grounds and the text ladder, and may give six more
(Dusk's stand in for those left out):

| Token | | Token | |
|---|---|---|---|
| `bg` | window ground | `text` | primary text (held to 7:1) |
| `panel` | raised panels, popups, menus | `textDim` | secondary text (4.5:1) |
| `panelAlt` | controls: buttons, fields | `textMuted` | hints, captions (4.5:1) |
| `sidebar` | the settings window's sidebar | `ink` | hairlines and washes (white by default) |
| `footer` | window footers | `star` | the band's stars |
| `sky` | the top of the starlit band | `shade`, `scrim` | wells and shadows; the ground under text on zone art |
| | | `onAccent` | text on an accent fill |
| | | `shadow` | the window's drop shadow (its alpha is its strength) |

A scheme gives only these: the status and subject colours (quest gold, NPC
blue, success green...) are the same in every scheme, so a quest reads the
same everywhere. A token that belongs to skins (`accent`, `border`, `quest`...)
is refused with that reason; use `accent` and `washes` instead.

`washes` sets how strong the white ink is for the hairlines and washes, by
name: `border`, `divider`, `hover`, `selected`, `progress`, `track`, `toggle`,
`box`, `thumb`, `swatch`, `chip`, `watermark`, `mover` (0 to 1; Polestar's
defaults are 0.06 to 0.25).

The player's own ground colour, brightness, accent and window border still
apply on top of any scheme.

## RegisterSkin

A skin starts from one of Polestar's looks (its `base`) and changes what it
names:

```lua
Theme.RegisterSkin(id, {
	name = "...", addon = ADDON,
	base = "polestar",     -- "polestar" | "halo" | "hearth" | "forever" | "blizzard" | "classic"
	scheme = "moonlit",    -- base "polestar" only: a registered scheme this skin wears
	tokens = { ... },      -- any palette token, over the base's palette (or the scheme)
	font = "fira",         -- "game" | "inter" | "fira" | "opensans" | { regular = path, medium = path, semibold = path }
	fontSizes = { hero = 24 },
	textShadow = { 1, -1, 0.8 },  -- x, y, alpha; false for none
	icons = { bug = "flag" },     -- glyph -> another glyph or your own texture path
	media = { band = path, bandStars = path, medallion = path },
	arrow = "halo",        -- the arrow a player on "Skin" gets: "3d" | "flat" | "halo" | "hearth"
	mapIcons = "halo",     -- the map icons a player on "Skin" gets: "polestar" | "halo" | "hearth"
	paint = { window = function(frame, base, kit) ... end, ... },
	hooks = { arrow = function(frame, style) ... end, pin = function(pin) ... end },
	onApply = function(id) end,   -- this skin became the one in use
	onLeave = function(id) end,   -- another skin replaced it
	strict = false,
})
```

| Field | What it changes |
|---|---|
| `base` | Everything you leave out comes from this look: its palette, painters, sizes (rows, buttons, the guide window's layout), the game art of `forever`, `blizzard` and `classic`, the arrow and map icons. Modules that vary their own art by skin see your skin as its base (`Theme.SkinKey()`). |
| `scheme` | With `base = "polestar"`: the scheme the skin wears. While the skin is in use the player's scheme has no effect (`Theme.SkinScheme()` tells the Theme page to say so). Without it, a `polestar`-based skin wears the player's scheme. Register the scheme first. |
| `tokens` | Any token of the palette ([Tokens](#tokens)), over the base's palette (or the scheme). On base `polestar`, `accent` stands in for Polestar gold. The player's own accent, window border and arrow colours still win. |
| `font` | The face every Polestar string takes while the player's font is "The skin's font" (the default). Your own files: give at least `regular`; `medium` and `semibold` default to it. Paths are full: `"Interface\\AddOns\\MyAddon\\Fonts\\X.ttf"`. Chinese and Korean clients always use the game's font. |
| `fontSizes` | A role's size: `hero`, `display`, `title`, `heading`, `body`, `label`, `note`, `small`, `number`, `caption`, `goal`, `name`, `mono` (6 to 40). The player's text size scales them. |
| `textShadow` | The shadow under every string; the player's own text-shadow setting wins. |
| `icons` | Polestar's glyphs by name (`bug`, `icon-goto`, `close`, `icon-accept`...: the files in `Media/UI`) drawn as another glyph or your texture. Applies to glyphs drawn after the change; Polestar redraws its windows' glyphs when the skin changes. |
| `media` | `band`, `bandStars`: the header band's sky mask and stars (1024x128, drawn at 1:1 and tinted with `sky` and `star`). `medallion`: the map pins' medallion while the player's map icons follow the skin. |
| `arrow`, `mapIcons` | Which of Polestar's arrow and map icon designs a player gets with these on "Skin" (the default). |
| `paint` | [Painters](#painters-and-the-paint-kit), by kind of frame. |
| `hooks` | [Hooks](#hooks-the-arrow-and-the-map-pins) for the art modules draw themselves. |
| `onApply`, `onLeave` | Called with the skin's id when it becomes, or stops being, the one in use (also at login when it is). For your own frames, if any. |

## Tokens

The palette is a set of named colours every Polestar frame reads through
`Theme.Color(token)`. Besides the scheme tokens above:

- **Status and subjects**: `success`, `warning`, `danger`, `quest`, `npc`,
  `item`, `place`, `object`, `level`, `skill`, `spell`, `faction`, `area`,
  `achievement`, `dungeon`, `rare`.
- **Washes** (colours with alpha): `border`, `divider`, `hover`, `selected`,
  `progress`, `track`, `toggle`, `box`, `thumb`, `swatch`, `chip`,
  `watermark`, `mover`.
- **Roles**: `accent`, `windowBorder` (overridden by the player's window
  border setting), `title`, `textOff`, `link`, `todo`, `later`, `arrive`,
  `manual`, `skipped`, `separator`, `rowLine`, `veil`, `veilWindow`, `menuBg`,
  `inputBg`, `control`, `accentLine`, `padSelect`, `chipAccent`, `icon`,
  `iconHover`, `buttonText`, `personName`, `tabRest`, `rowLabel`, `navRest`.
- **The game looks' own**: `bgBottom`, `skyBottom`, `windowEdge`,
  `frameEdge`, `frameEdgeDark`, `titleLine`.
- **Art**: `mapUnexplored`, `haze`.

A name not in this list is refused as a typo. What each token stands for in
Polestar's own style is in `addon/Polestar/Theme/Theme.lua` (`SCHEMES`,
`SKIN_PALETTES`, `HOUSE_EXTRA`).

## Legibility

Polestar holds its text to a floor on every ground: primary text 7:1, the
secondary and muted text 4.5:1 (WCAG contrast), and the status and subject
colours 4.5:1 on every ground but the band's sky. Your scheme or skin is
checked at registration against that same rule (`Theme.Legibility`,
`Theme.Contrast`); a translucent ground is measured over the window ground,
the window ground over black.

- **Legible**: accepted as given.
- **Grounds too light** for the text: the six grounds are darkened together,
  by the least that makes every text read, and the registration says so:
  `ok = true, message = "textMuted on panelAlt reads 3.9:1, needs 4.5:1; the
  grounds were darkened (-0.12) until the text reads"`. With `strict = true`
  the spec is refused with that reason instead.
- **Text too dark** to read even on the darkest grounds: refused
  (`"... even with the grounds at their darkest"`).

At run time Polestar keeps darkening the grounds if a player's own ground
colour or brightness would drop the text below the floor, as for its own
schemes.

## Painters and the paint kit

Polestar paints its frames by kind through `Theme.Skin(frame, kind)`. A skin
may paint any kind itself:

| Kind | Frames |
|---|---|
| `window` | every window: the settings, the guide menu, the hub, dialogs, popups; also the guide window and the toasts unless you give `guide` / `toast` |
| `guide` | the guide window (a `window` with `frame.psGuide`) |
| `toast` | the toasts and alerts (a `window` with `frame.psLight`) |
| `panel` | menus, popups, raised panels |
| `sidebar`, `inset` | the settings' sidebar, wells |
| `button`, `tile` | buttons (`frame.psTextButton` for a text button), action tiles |
| `dropdown`, `editbox`, `checkbox`, `tab`, `close`, `scrollbar` | the controls |

```lua
paint = {
	window = function(frame, base, kit)
		base(frame)            -- the base look's painter for this kind
		if frame.psBare then return end
		local own = kit.store(frame)
		own.glow = own.glow or frame:CreateTexture(nil, "BORDER")
		...
	end,
}
```

A painter gets:

- `frame`, and these fields on it: `psBare` (the player made this window
  transparent: show no ground), `psBgAlpha` (its ground's opacity, else
  `Theme.GroundAlpha()`), `psBgColor` (a ground colour of its own, `{ r, g, b }`),
  `psNoBorder` (no window border), `psGuide`, `psLight`, `psFocused` (an edit
  box with the cursor), `psSelected` (a selected tab);
- `base`: the painter of your base look for this kind. Call it to keep that
  look and add to it, or leave it out to paint the frame entirely yourself;
- `kit`, also `Polestar.Theme.SkinKit`:

| | |
|---|---|
| `kit.fill(frame, layer?, sub?) -> texture` | The frame's ground: one white texture over it, to tint |
| `kit.gradient(frame, top, bottom)` | That ground as a vertical gradient (`{ r, g, b, a }` each) |
| `kit.border(frame, r, g, b, a, layer?, size?)` | A pixel-exact border (`size` physical pixels, outward) |
| `kit.hideBorder(frame)` | |
| `kit.hoverWash(frame) -> texture` | The highlight under the cursor |
| `kit.store(frame) -> table` | A table on the frame for your own textures and frames: **keep everything you create in it**. Polestar hides all of it whenever another skin paints the frame, so a switch to another skin and back leaves no stray pieces |
| `kit.bare(frame)` | Hide the ground, border, shadow and everything in `kit.store` |

Read colours through `Theme.Color(token)` (and `Theme.Accent()`,
`Theme.Wash(name)`) inside the painter, never once at load: painters run again
whenever the player changes a colour, the scheme, the skin or the UI scale,
and a frame must come out the same every time it is painted. Create a texture
once (in `kit.store`), then only show, hide, tint and place it.

## Hooks: the arrow and the map pins

The waypoint arrow and the map pins are drawn by their own modules, not by
`Theme.Skin`. After painting them, Polestar hands them to your hook:

| Hook | Called with | When |
|---|---|---|
| `arrow` | the arrow's frame (`PolestarNavArrow`), the style in use (`"3d"`, `"flat"`, `"halo"`, `"hearth"`) | after the arrow repaints its look (a theme or arrow setting changed) |
| `pin` | the pin's frame | after a map pin is (re)built or restyled |

Hooks run often (one per pin); keep them cheap and keep what you create on
the frame you are given, created once. Choosing Polestar's own designs is
simpler: `arrow = "halo"`, `mapIcons = "halo"`, `media.medallion`.

## When things go wrong

Every painter, hook, `onApply` and `onLeave` of a registered skin runs under
`pcall`. The first error:

- is noted once in Polestar's error list (it shows in `/polestar report`) as
  `skin <id> (<addon>): <error>`, and Polestar prints one chat line naming
  your skin and addon;
- turns your skin off **for the session**: Polestar repaints everything in
  its own look (`Theme.SkinId()` is `"polestar"`, `Theme.SkinInfo(id).failed`
  holds the error);
- keeps the player's choice: `ui.skin` still names your skin, so after a
  `/reload` (with a fixed addon) it is back.

Nothing of a broken skin runs again that session.

## Saved choices, load order, late registration

- **Load order.** With `## Dependencies: Polestar` or `## OptionalDeps:
  Polestar`, the game loads Polestar first and your file can register at
  once, before the player logs in or after. An addon that must load without
  that line can register on `ADDON_LOADED` for `"Polestar"`. A load-on-demand
  addon registers whenever it loads.
- **A saved choice waiting for its skin.** A player's `ui.skin` (or
  `ui.scheme`) naming a skin or scheme that is not registered (its addon is
  disabled, removed, or not loaded yet) draws Polestar's own look and keeps
  the saved value. When the addon registers it, even later in the session,
  Polestar applies it at once. So disabling a skin addon for a session does
  not lose the player's choice; picking another skin in the settings replaces
  it.
- Polestar keeps nothing of your spec in its saved variables.

## Versions and capabilities

`Theme.API_VERSION` is `1`. It goes up only when a spec written for an older
version would no longer mean the same; additions to it come as capabilities,
so a skin can use a newer feature where it exists and do without elsewhere:

```lua
if Theme.HasCapability("surfaces.pin") then spec.hooks = { pin = paintPin } end
```

The capabilities of version 1: `schemes`, `skins`, `tokens`, `legibility`,
`fonts`, `fontSizes`, `textShadow`, `icons`, `media.band`, `media.bandStars`,
`media.medallion`, `arrow.style`, `mapIcons`, `events` (`onApply`,
`onLeave`), `preview` (the picker's cards), and `surfaces.<kind>` for every
painter kind and hook (`surfaces.window`, `surfaces.guide`, `surfaces.toast`,
`surfaces.panel`, `surfaces.sidebar`, `surfaces.inset`, `surfaces.button`,
`surfaces.tile`, `surfaces.dropdown`, `surfaces.editbox`,
`surfaces.checkbox`, `surfaces.tab`, `surfaces.close`, `surfaces.scrollbar`,
`surfaces.arrow`, `surfaces.pin`). `Theme.Capabilities()` lists them.

Polestar 0.3.6 and older have no `Theme.RegisterSkin`: check for it, as the
quick start does.

## Walkthrough: Moonlit

The example, [`addon/Polestar_Skin_Example/Moonlit.lua`](../addon/Polestar_Skin_Example/Moonlit.lua),
in the order it is written.

1. **Guard.** `Polestar.Theme.RegisterSkin` exists and `API_VERSION >= 1`,
   else the addon does nothing (an old Polestar, or none).
2. **The scheme.** `RegisterScheme("moonlit", ...)` with indigo grounds
   (`bg #12142a` at 97 %, `panel`, `panelAlt`, `sidebar`, `footer`, the band's
   `sky #2b3060`), a silver ladder (`text #f2f3fa`, `textDim #c3c7de`,
   `textMuted #9ca1c0`), pale stars, and a moonlight `accent #afc0ff` used
   where the player has no accent of their own. Its `washes` make the
   hairlines a little stronger on the lighter ground. Every text role reads at
   its floor on every ground as given, so the registration answers `true` with
   no note. Players can pick Moonlit as a scheme with Polestar's own skin.
3. **The skin.** `RegisterSkin("moonlit", ...)`: `base = "polestar"` (the
   house frames, band, sizes), `scheme = "moonlit"`, `font = "fira"` (Fira
   Sans, which Polestar ships), a 24-point `hero`, and Halo's arrow and map
   icons for players who leave those on "Skin".
4. **One painter.** `paint.window` calls `base(frame)` (the house window:
   ground, border, drop shadow), then adds a one-pixel line of the accent
   along the top edge, kept in `kit.store(frame)` so it disappears when the
   player picks another skin, and hidden on a transparent window
   (`frame.psBare`). It reads the accent through `Theme.Color`, so the
   player's own accent colours the line too.
5. **Errors are said.** Each registration's `ok, message` is printed when it
   is a refusal or a correction, so you see at once what to fix.

To make your own: copy the folder, rename the folder and its `.toc`, change
the ids (`moonlit`), names and colours, and register what you need. Start
with a scheme; add a skin when you want fonts, painters or another look as
the base.

## Four more to read: the showcase skins

Beside Moonlit, the repository carries four complete skins, each an addon of
its own (`addon/Polestar_Skin_<Name>`, in the repository only, never in a
release), each written to show one more thing the API can do. Copy them into
`Interface/AddOns/` next to Polestar to try them; their renders and the
reasoning behind each are in the design notes they were built with.

| Skin | What it is | What it shows |
|---|---|---|
| **Vellum** (`Polestar_Skin_Vellum`) | A page of the quest log: dark ink on mottled parchment, a sealing-wax accent, the game's font | A **light** skin: every token given (grounds, ladder, all sixteen subject colours as inks) and still held to the legibility floors; a texture of the skin's own (`Media/paper.tga`) tinted at paint time; painters for window, panel, sidebar, inset and editbox; a layout preset that turns the arrow's words paper-coloured on a plate |
| **Lumen** (`Polestar_Skin_Lumen`) | Head-up: no frame, a cyan line and a tick at each corner, Fira Sans a size down, the flat arrow | A skin that is mostly a **frame treatment** from Polestar's white texture; a `guide` painter beside `window` (the ticks stay while the window is transparent); `fontSizes` for the whole ladder; a preset that turns the house chrome off |
| **Beacon** (`Polestar_Skin_Beacon`) | High contrast: black grounds, white Open Sans a size up, a yellow accent, strong edges | A **scheme and a skin from one addon**; washes raised through tokens; a 2-unit focus ring on fields; a preset that reaches the arrow, pins and route line |
| **Aurora** (`Polestar_Skin_Aurora`) | Polestar's night a step further: a teal-over-violet aurora in the band, grounds that deepen toward the foot, champagne gold | A skin that **extends** the house style: `kit.gradient` for the ground, the `haze` token for the band's light, nothing else changed |

A `preset` (where this Polestar has the `preset` capability) is a table of
Look settings the skin recommends; Polestar offers it on the Theme page
("Apply <skin>'s layout") and never applies it on its own. The four skins
guard it with `Theme.HasCapability("preset")`, so they load on a Polestar
without it.

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
| Waiting for a skin | A window remembers a skin not yet installed and switches when it is | The same: a saved `ui.skin` waits, drawn as Polestar meanwhile, applied when the addon registers | Taken as is: load order and disabled addons should not cost the player their choice |
| Metadata | author, version, site, desc | `author`, `version`, `desc`, plus `addon` (required) | The picker names the addon so a player knows whose skin it is and where to report |
| After-apply callback | `callback(skin, instance)` | `onApply`, `onLeave` | Taken; `onLeave` added so a skin can tidy its own frames |
| Identity | The display name is the key | A stable `id`, the `name` separate | A skin can rename itself (or be translated) without losing every player's saved choice |
| Look | One texture atlas at fixed coordinates, plus settings | Tokens, fonts, media by name, and painters per kind of frame | Polestar has many frames of many shapes, and a palette every frame reads; painters keep a skin working when Polestar adds frames of a known kind |
| Player settings | The skin writes its values over the player's window settings | A skin never writes a setting: it is a layer under the player's own accent, border, ground and arrow colours | Switching skins must not reset what a player chose (Polestar's rule: never change a player's settings behind their back) |
| Errors | Callbacks are not isolated; `InstallSkin` returns false without a reason | Every painter and hook under `pcall`; the first error noted once, the skin off for the session; refusals and corrections say why | A broken third-party skin must never break the guide; an author needs the reason |
| Legibility | Not checked | Every scheme and skin held to the text floors, corrected or refused | Polestar is read at arm's length over a busy game world |
| Versioning | None | `api`, `API_VERSION`, `HasCapability` | Lets a skin target a newer feature and still load on an older Polestar |
| Caching in saved variables | Yes, unless `no_cache` | No | Painters are functions and cannot be saved; a cached copy of an outdated skin would keep drawing after its author fixed it; a removed addon's skin should go with it (the choice waits instead) |
| Control scripts (`OnUpdate`) | Yes | No | Polestar runs nothing every frame while idle; a skin that animates can do it in its own `onApply` frames, at its own cost |
| Per-skin option buttons | `skin_options` in the options panel | Not in version 1 | A skin addon can keep its own saved variables and slash command; per-skin rows in Polestar's settings are a candidate for a later capability |
| Preview | The window itself | A card per skin in the picker, drawn from the skin's own palette and font without applying it | Players choose before they switch |
