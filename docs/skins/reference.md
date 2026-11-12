# Skin API reference

Everything on `Polestar.Theme` a skin addon may use, with every argument,
return value, token, surface, capability and error. The behaviour described
here is what Polestar 0.3.7 does (Skin API version 1); the examples were run
against it. Concepts are in the [overview](README.md); a build from zero is in
[getting started](getting-started.md).

- [Functions](#functions)
  - [RegisterScheme](#registerschemeid-spec)
  - [RegisterSkin](#registerskinid-spec)
  - [Reading the palette](#reading-the-palette)
  - [Asking about skins and schemes](#asking-about-skins-and-schemes)
  - [Version and capabilities](#version-and-capabilities)
  - [Drawing preview cards](#drawing-preview-cards)
  - [Other Theme functions a skin may use](#other-theme-functions-a-skin-may-use)
- [Ids](#ids)
- [Colours](#colours)
- [Common spec fields](#common-spec-fields)
- [Scheme spec](#scheme-spec)
- [Skin spec](#skin-spec)
- [Tokens](#tokens)
- [Font roles](#font-roles)
- [Surfaces: painters](#surfaces-painters)
- [The paint kit](#the-paint-kit)
- [Surfaces: hooks](#surfaces-hooks)
- [Events](#events)
- [Legibility rules](#legibility-rules)
- [Validation and error messages](#validation-and-error-messages)
- [Run-time errors](#run-time-errors)
- [Capabilities](#capabilities)

## Functions

### `RegisterScheme(id, spec)`

Adds a colour scheme the player can pick under Settings > Look > Theme, and
that a skin built on Polestar's own look may wear.

- `id`: string, see [Ids](#ids).
- `spec`: table, see [Scheme spec](#scheme-spec).
- Returns `ok, message`:
  - `true, nil`: accepted as given.
  - `true, "<note>"`: accepted, but Polestar darkened the grounds so the text
    reads; the note says which text on which ground fell short and by how
    much the grounds moved ([Legibility rules](#legibility-rules)).
  - `false, "<reason>"`: refused; nothing was registered. Reasons are listed
    under [Validation](#validation-and-error-messages).
- Registering a scheme that a saved `ui.scheme` (or the skin in use) is
  waiting for repaints Polestar in it at once.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local ok, message = Theme.RegisterScheme("ref-ember", {
	api = 1, name = "Ember", addon = ADDON,
	tokens = {
		bg = "#1a1210f7", panel = "#201613fa", panelAlt = "#2a1e1a",
		sidebar = "#140d0b", footer = "#160f0d", sky = "#3a2420",
		text = "#fbf3ec", textDim = "#d6c6ba", textMuted = "#a8968a",
	},
	accent = "#ffa05a",
})
assert(ok, message)
```

### `RegisterSkin(id, spec)`

Adds a skin: one of Polestar's six looks as its base, with the palette,
fonts, media, art choices and painters the spec names changed.

- `id`: string, see [Ids](#ids).
- `spec`: table, see [Skin spec](#skin-spec).
- Returns `ok, message` with the same meaning as `RegisterScheme`.
- Registering a skin that a saved `ui.skin` is waiting for applies it at
  once (its `onApply` runs, every frame repaints).

```lua
local ADDON = ...
local Theme = Polestar.Theme
local ok, message = Theme.RegisterSkin("ref-ember", {
	api = 1, name = "Ember", addon = ADDON,
	base = "polestar", scheme = "ref-ember", font = "inter",
})
assert(ok, message)
```

### Reading the palette

These read the palette **in use** (the live skin, scheme and the player's
own colours over them). Call them inside painters and hooks, never once at
load: the answers change whenever the player changes a setting.

| Function | Returns | Notes |
|---|---|---|
| `Color(token)` | `r, g, b, a` (0-1) | The token's colour in use. An unknown token answers the `text` colour, so a typo shows up as white text rather than an error. |
| `Accent()` | `r, g, b` | The accent in use: the player's own, their class colour, the skin's or scheme's `accent`, or Polestar gold. |
| `Wash(name)` | `r, g, b, a` | One of the ink washes ([washes](#washes-skins-only)); an unknown name answers `border`. |
| `Hex(token)` | `"ffrrggbb"` | For `|c` colour escapes in text. |
| `Palette()` | table | The whole resolved palette, token -> `{ r, g, b, a }`. Read-only: do not change it. |
| `PaletteFor(id)` | table or nil | The palette skin `id` would give, with the player's own colours over it; nil for an unknown id. What the picker's cards are drawn from. |
| `Media(name)` | path | `"Interface\\AddOns\\Polestar\\Media\\UI\\<name>"` for one of Polestar's own textures (the files in `addon/Polestar/Media/UI`, without `.tga`); a string that already holds `\` or `/` comes back as given. `Media("white")` is the plain white texture every fill is tinted from. |
| `SkinMedia(name)` | path or nil | The live skin's own `media.band`, `media.bandStars` or `media.medallion`, nil when it has none. |
| `Icon(name)` | name or path | A glyph name as the live skin maps it (`icons` in its spec), else `name` itself. Pass the result to `Media`. |
| `GroundAlpha()` | number | The player's window opacity (`ui.bgOpacity`, default 0.94). |
| `WindowBorder()` | `shown, size` | Whether the player has a window border, and its thickness in pixels. |
| `ShowsBand()`, `ShowsRim()` | boolean | Whether the player shows the starlit header band / the accent rim. |
| `Pixel(region)` | number | One physical pixel in `region`'s coordinate space, for crisp lines. |
| `Contrast(c1, c2)` | number | WCAG contrast ratio of two colours (`{ r, g, b }` tables). |
| `Legibility(palette)` | number | How the palette stands against the text floors: >= 1 means every text role reads. |

```lua
local Theme = Polestar.Theme
local r, g, b = Theme.Color("panel")
local ar, ag, ab = Theme.Accent()
local br, bg, bb, ba = Theme.Wash("border")
local white = Theme.Media("white")           -- the texture every fill tints
local own = Theme.Media("Interface\\AddOns\\MySkin\\art.tga") -- comes back unchanged
assert(white:find("Polestar") and own:find("MySkin"))
```

### Asking about skins and schemes

| Function | Returns |
|---|---|
| `SkinId()` | The id of the skin **in use as drawn**: the saved `ui.skin` when that skin is registered and has not failed this session, else `"polestar"`. |
| `SkinKey()` | The **built-in look** the skin in use is drawn from: a registered skin's `base`; a built-in skin's own id. Modules that keep art per look read this, so a skin on `halo` is treated as Halo by them. |
| `SkinScheme()` | The scheme the skin in use brings (`spec.scheme`), or nil. While it is not nil the player's scheme setting has no effect. |
| `SkinArrowStyle()` | The skin in use's `arrow` choice, or nil for its base look's. |
| `SkinMapIcons()` | The skin in use's `mapIcons` choice, or nil. |
| `GameSkin(id?)` | `true` when the skin (in use, or `id`) is drawn in the game's controls and colours: `hearth`, `forever`, `blizzard`, `classic` and skins built on them. |
| `SchemeKey()` | The player's scheme setting as resolved: a registered or built-in scheme id, `"dusk"` for an unknown one. Note it is the **player's** scheme even while a skin's own scheme overrides it; use `SkinScheme()` for that. |
| `SkinChoices()` | The picker's list, in order: `{ { value, text, addon?, desc?, author? }, ... }`. The six built-in skins first, then registered skins in registration order. Built-ins have no `addon`. |
| `SchemeChoices()` | `{ { value, text, addon?, desc? }, ... }`: `dusk`, `night`, `graphite`, then registered schemes. |
| `SkinInfo(id)` | `{ id, name, addon, author, version, desc, base, scheme, builtin, failed }` or nil for an unknown id. `builtin` is a boolean; `failed` is the error string once the skin has failed this session, else nil. For a built-in, `name` is translated and `addon` is nil. |
| `SchemeInfo(id)` | `{ id, name, addon, author, version, desc, builtin }` or nil. |

```lua
local Theme = Polestar.Theme
local info = Theme.SkinInfo("halo")
assert(info.builtin == true and info.addon == nil)
assert(Theme.SkinInfo("no-such-skin") == nil)
for _, c in ipairs(Theme.SkinChoices()) do
	-- c.value is the id to save, c.text the name shown, c.addon who brought it
	assert(type(c.value) == "string" and type(c.text) == "string")
end
```

### Version and capabilities

| | |
|---|---|
| `API_VERSION` | `1`. The number a spec's `api` field is compared with. |
| `HasCapability(name)` | `true` when this Polestar offers capability `name` ([Capabilities](#capabilities)); `false` for anything else, including nil. |
| `Capabilities()` | Every capability name, sorted, as a new table. |

```lua
local Theme = Polestar.Theme
assert(Theme.API_VERSION >= 1)
assert(Theme.HasCapability("skins") and Theme.HasCapability("surfaces.window"))
assert(not Theme.HasCapability("surfaces.minimap"))
assert(#Theme.Capabilities() >= 31)
```

### Drawing preview cards

| | |
|---|---|
| `DrawSkinCard(frame, id)` | Draws skin `id`'s preview (its ground, band, a title and a line in its font, an accent bar and a button, edged by its window border) on `frame`, four units in from its edges, without touching the live look. Creates its textures on the first call (`frame.psSkinCard`); call it again on every redraw. Nothing happens for an unknown id. |
| `DrawSchemeCard(frame, id)` | The same for a scheme, in Polestar's own style with the accent in use. |

Polestar's settings use these; a skin addon with a picker of its own may too.

### Other Theme functions a skin may use

These are Polestar's own, public, and stable in practice, but they are not
part of the Skin API's version promise ([versioning](versioning.md)); check
they exist before calling them.

| | |
|---|---|
| `Refresh()` | Repaints every skinned frame and string and tells the listeners. Call it when something **your skin** reads changed (its own saved variable), never on a timer. |
| `OnChanged(fn)` | Registers `fn` to run after every `Refresh` (a theme or skin change, a colour setting, a UI scale change). For frames of your own that are not painted through `Theme.Skin`. |
| `Skin(frame, kind)` | Paints one of **your own** frames as a Polestar surface of `kind` ([surfaces](#surfaces-painters)) in the skin in use, and keeps it repainted. Returns the frame. |
| `Repaint(frame)` | Paints a skinned frame again (after changing its `psBare` or `psBgAlpha`). |
| `Font(fontString, role)` | Sets a font string to a [role](#font-roles) in the skin in use and keeps it in step with font and skin changes. |
| `Border(frame, r, g, b, a, layer?, size?)` | A pixel-exact border around `frame` (what `kit.border` calls). |
| `Band(parent, layer?, sub?)` | The starlit header band on `parent`: a sky texture (tinted `sky`) with the stars over it, both following the skin's `media`. Returns the sky texture; size and place it. |

## Ids

An id is what a player's settings store (`ui.skin`, `ui.scheme`). Rules:

- A string of letters, digits, `_` or `-`, starting with a letter, 32
  characters at most: `moonlit`, `Moon-Lit_2`. Case matters.
- Never change an id once published: players who picked it would lose it.
- First come, first served: the first addon to register an id keeps it, and
  a second registration of the same id is refused with
  `the id "<id>" is taken (<addon>)`. This includes **your own** second call:
  a skin cannot be registered twice in one session, so changes need a
  `/reload`.
- Skin ids and scheme ids are separate namespaces: the example registers a
  scheme `moonlit` and a skin `moonlit`.
- Taken: Polestar's skins `polestar`, `halo`, `hearth`, `forever`,
  `blizzard`, `classic`; its schemes `dusk`, `night`, `graphite`; and
  `ellesmere` (a scheme another addon provides through its own integration).
- Pick ids unlikely to collide with other skin authors: your addon's name or
  a prefix (`ttk-ember`), not `dark`.

## Colours

Anywhere a spec takes a colour:

| Form | Example |
|---|---|
| `"#rrggbb"` | `"#12142a"` (the `#` is optional) |
| `"#rrggbbaa"` | `"#12142af7"` (alpha as a hex byte) |
| `{ r, g, b }` or `{ r, g, b, a }` | `{ 0.07, 0.08, 0.16 }`, numbers from 0 to 1 |
| `{ r =, g =, b =, a = }` | `{ r = 0.07, g = 0.08, b = 0.16, a = 0.97 }` |

Alpha defaults to 1. Anything else (`"red"`, numbers over 1, a 3-digit hex)
is refused: `token "<name>" is not a colour (give { r, g, b[, a] } in 0-1 or
"#rrggbb")`.

Where alpha matters: the six grounds (a translucent window ground is drawn at
the player's opacity anyway, but the alpha counts in the legibility
measurement), the washes (their alpha *is* their strength), `shadow` (its
alpha is the drop shadow's strength), `veil` and `veilWindow` on Halo.

## Common spec fields

Both specs take these. Any field not listed for the spec is refused as
`unknown field "<name>"` (usually a typo, or a field from a later API version).

| Field | Required | Type and limits | Meaning |
|---|---|---|---|
| `name` | yes | string, 1-40 characters | Shown in the picker as given. Translate it yourself if you like (`GetLocale()`). |
| `addon` | yes | string, 1-40 characters | Your addon's folder name: the first vararg of your file (`local ADDON = ...`). Shown beside the name in the picker and in every error note, so a player knows whose skin it is. |
| `api` | no | whole number >= 1 | The Skin API version you wrote for. Omitted means "any". Larger than this Polestar's `API_VERSION` is refused: `needs Skin API 2; this Polestar has 1 (update Polestar)`. |
| `author` | no | string, 1-40 characters | Shown in the picker's details. |
| `version` | no | string, 1-40 characters | Your skin's version. Polestar does not compare it with anything. |
| `desc` | no | string, 1-200 characters | One sentence, shown as the card's tooltip. |
| `strict` | no | boolean | `true`: refuse a spec whose text would not read, instead of darkening its grounds ([Legibility](#legibility-rules)). |

## Scheme spec

`RegisterScheme(id, spec)`, with the common fields and:

| Field | Required | Meaning |
|---|---|---|
| `tokens` | yes | A table of token -> colour. **Must** give the six grounds and the text ladder: `bg`, `panel`, `panelAlt`, `sidebar`, `footer`, `sky`, `text`, `textDim`, `textMuted`; a missing one is refused as `tokens.<name> is missing (a scheme gives bg, panel, ...)`. **May** give `ink`, `star`, `shade`, `scrim`, `onAccent`, `shadow`; left out, Dusk's stand in. Any status, subject, wash or role token (`quest`, `border`, `title`, `accent`, `windowBorder`...) is refused: `tokens.<name> belongs to a skin, not a scheme`. |
| `accent` | no | A colour that stands in for Polestar gold while the player has no accent of their own and no class accent. |
| `washes` | no | Table of wash name -> alpha (0-1): how strong the white ink is for that wash in this scheme. Names: `border`, `divider`, `hover`, `selected`, `progress`, `track`, `toggle`, `box`, `thumb`, `swatch`, `chip`, `watermark`, `mover`. An unknown name is refused (`unknown wash "<name>"`), a value out of range too (`washes.<name> must be an alpha from 0 to 1`). |

A scheme gives *only* grounds and text: the status and subject colours are
the same in every scheme so a quest reads the same gold everywhere. The
player's own ground colour, panel and sidebar colours, brightness, accent and
window border still apply on top.

```lua
local ADDON = ...
local Theme = Polestar.Theme
-- A full scheme spec. Dusk's values stand in for the six optional tokens.
local ok, message = Theme.RegisterScheme("ref-tide", {
	api = 1, name = "Tide", addon = ADDON, author = "You", version = "1.0",
	desc = "Deep teal grounds under a sea-foam text ladder.",
	tokens = {
		bg = "#0d1a1cf7", panel = "#112224fa", panelAlt = "#17302f",
		sidebar = "#091315", footer = "#0a1517", sky = "#164046",
		text = "#eefaf7", textDim = "#bfe0d8", textMuted = "#8fb5ac",
		ink = "#d8fff4", star = "#d8fff4", shade = "#000a0a", scrim = "#02100f",
		onAccent = "#04201c", shadow = "#000a0a99",
	},
	accent = "#6fe3c9",
	washes = { border = 0.12, divider = 0.1, selected = 0.14 },
	strict = true,
})
assert(ok, message)
```

## Skin spec

`RegisterSkin(id, spec)`, with the common fields and:

| Field | Type | Meaning |
|---|---|---|
| `base` | `"polestar"` (default), `"halo"`, `"hearth"`, `"forever"`, `"blizzard"`, `"classic"` | The look everything you leave out comes from: palette, painters, sizes (rows, buttons, the guide window's layout), the game art of the three game looks, arrow and map icon designs, font, text shadow. Only a built-in may be a base (`base must be one of Polestar's skins: ...`); a registered skin cannot be extended. |
| `scheme` | a registered or built-in scheme id | With `base = "polestar"` only (`scheme goes with base "polestar" (the other looks bring their own grounds)`): the scheme this skin wears, which then overrides the player's scheme (the Theme page greys the scheme control). Must already be registered (`scheme "<id>" is not registered (register it first)`). Without it a `polestar`-based skin wears the player's scheme. |
| `tokens` | table of token -> colour | Any [token](#tokens), laid over the base's palette (over the scheme, on `polestar`). Unknown names are refused. See the per-token notes: a few tokens are derived at run time and a skin's value for them is ignored on some bases. |
| `font` | `"game"`, `"inter"`, `"fira"`, `"opensans"`, or `{ regular =, medium? =, semibold? = }` | The face every Polestar string takes while the player's font setting is "The skin's font" (the default). The table form takes full paths (`"Interface\\AddOns\\MySkin\\Fonts\\X.ttf"`); `medium` defaults to `regular`, `semibold` to `medium`. Chinese and Korean clients always use the game's font. Default: the base's (`fira` on Halo, `game` elsewhere). |
| `fontSizes` | table of role -> number (6-40) | A [font role](#font-roles)'s size in points, before the player's text size scales it. Unknown role: `unknown fontSizes "<role>"`; out of range: `fontSizes.<role> has the wrong type`. |
| `textShadow` | `{ x, y, alpha }` or `false` | The shadow under every string: offset in units, black at `alpha`. `false` means none. All three numbers are required. The player's own text-shadow setting (soft, hard, none) wins. Default: the base's (Halo `{ 0, -1, 0.9 }`, the game looks `{ 1, -1, 1 }`, Polestar a soft `shade`-coloured 1,-1). |
| `icons` | table of glyph name -> glyph name or path | Polestar's glyphs by name (the files in `addon/Polestar/Media/UI`: `bug`, `close`, `gear`, `search`, `icon-goto`, `icon-accept`, `icon-turnin`, `icon-kill`, `chevron-down`...) drawn as another glyph or your own texture (a path holding `\` or `/`). Values must be non-empty strings. Applies to glyphs drawn after the change; Polestar redraws its windows' glyphs when the skin changes. The game looks map `bug -> flag` and `icon-goto -> house` already. |
| `media` | `{ band?, bandStars?, medallion? }` | Paths to your own textures. `band`: the header band's sky mask, `bandStars`: its stars, both 1024x128, drawn at 1:1 from the top left and tinted with `sky` and `star`. `medallion`: the disc under map pin glyphs, used while the player's map icons follow the skin. Unknown keys are refused. Paths are not checked: a wrong one shows as a blank or green texture in game. |
| `arrow` | `"3d"`, `"flat"`, `"halo"`, `"hearth"` | Which of Polestar's arrow designs a player gets while their arrow style is "Skin" (the default). Default: the base's (`3d` for Polestar, `halo` for Halo, `hearth` for the rest). |
| `mapIcons` | `"polestar"`, `"halo"`, `"hearth"` | Which map icon design those players get. Same defaults. |
| `paint` | table of surface -> function | [Painters](#surfaces-painters). Unknown surface: `unknown paint "<name>"`; not a function: `paint.<name> has the wrong type`. |
| `hooks` | `{ arrow? = fn, pin? = fn, guideTitle? = fn }` | [Hooks](#surfaces-hooks) for the arrow, the map pins and the guide window's title row. |
| `onApply`, `onLeave` | functions | [Events](#events). |

Everything is optional except `name` and `addon`: `RegisterSkin("x", { name
= "X", addon = ADDON })` is a valid skin identical to Polestar's own look.

```lua
local ADDON = ...
local Theme = Polestar.Theme
-- Every skin field at once, on the Halo look.
local ok, message = Theme.RegisterSkin("ref-everything", {
	api = 1, name = "Everything", addon = ADDON, author = "You", version = "1.0",
	desc = "Halo with warmer text, Open Sans and a thicker edge.",
	base = "halo",
	tokens = { text = "#fff4e0", textDim = "#d8c8a8", accent = "#ffb347", border = "#ffffff26" },
	font = "opensans",
	fontSizes = { hero = 22, goal = 15 },
	textShadow = { 0, -1, 0.8 },
	icons = { bug = "flag" },
	media = { medallion = "Interface\\AddOns\\" .. ADDON .. "\\medallion.tga" },
	arrow = "flat",
	mapIcons = "polestar",
	paint = {
		window = function(frame, base, kit)
			base(frame)
			if frame.psBare then return end
			local r, g, b = Theme.Accent()
			kit.border(frame, r, g, b, 0.6, nil, 2)
		end,
	},
	hooks = {
		arrow = function(frame, style) end,
		pin = function(pin) end,
	},
	onApply = function(id) end,
	onLeave = function(id) end,
	strict = false,
})
assert(ok, message)
```

## Tokens

The palette is a set of named colours every Polestar frame reads through
`Theme.Color(token)`. A skin may set any token below (an unknown name is
refused: `unknown token "<name>" in tokens`). Defaults are the resolved value
in each base, as hex with `@alpha` where it is under 1; the player's own
colours (accent, grounds, border, arrow) sit on top of all of them.

### Grounds (a scheme must give these)

| Token | Stands for | Polestar (Dusk) | Halo | Hearth | Forever / Blizzard / Classic |
|---|---|---|---|---|---|
| `bg` | the window ground | `#181d2d@0.97` | `#080604@0.84` | `#1e170d@0.95` | `#000000@0.96` / same / `#101010@0.85` |
| `panel` | raised panels, popups, menus, toasts | `#1c2234@0.98` | `#120e0a@0.97` | `#000000@0.92` | `#000000@0.92` |
| `panelAlt` | controls: buttons, fields, dropdowns | `#232a3f` | `#ffffff@0.06` | `#000000` | `#000000` |
| `sidebar` | the settings window's and guide menu's sidebar | `#121624` | `#080604@0` | `#000000@0.30` | `#000000@0.25` / same / `#000000@0` |
| `footer` | window footers | `#141927` | `#080604@0` | `#000000@0` | `#000000@0` |
| `sky` | the top of the starlit header band | `#283254` | `#080604@0` | `#2c200c` | `#2c200c` |

On the Polestar base the player's own background, panel and sidebar colours
and brightness replace these at run time; on the other bases those controls
are off.

### Text ladder (a scheme must give these)

| Token | Stands for | Floor | Dusk | Halo | Hearth | game looks |
|---|---|---|---|---|---|---|
| `text` | primary text | 7:1 on every ground | `#f7f8fd` | `#f4efe6` | `#ffffff` | `#ffffff` |
| `textDim` | secondary text | 4.5:1 | `#c3cadd` | `#c2b9a9` | `#cccccc` | Forever `#ae9d81`, else `#cccccc` |
| `textMuted` | hints, captions, placeholders | 4.5:1 | `#9ba2b9` | `#8f8778` | `#9d9d9d` | `#9d9d9d` |

### Scheme extras (a scheme may give these)

| Token | Stands for | Dusk | Halo | Hearth / game looks |
|---|---|---|---|---|
| `ink` | the colour of hairlines and washes (the washes are `ink` at an alpha) | `#ffffff` | `#ffffff` | `#ffffff` |
| `star` | the band's stars (alpha 0 hides them) | `#ffffff` | `#ffffff@0` | `#ffffff@0` |
| `shade` | wells, text shadows, art fades | `#000005` | `#000000` | `#000000` |
| `scrim` | the dark ground under text on zone art | `#05080f` | `#080604` | `#000000` |
| `onAccent` | text and glyphs on an accent fill (swapped for `text` at run time when that reads better) | `#0a0d14` | `#17130e` | `#17130e` |
| `shadow` | the window drop shadow; its alpha is its strength | `#000005@0.60` | `#080604@0.72` | `#000000@0.70` |

### Status and subject colours (skins only)

Held to 4.5:1 on every ground but `sky`. The same in every scheme; a skin may
recolour them.

| Token | Stands for | Dusk | Halo | Hearth / game looks |
|---|---|---|---|---|
| `success` | done, arrived, positive | `#6bd999` | `#5fd068` | `#1eff00` |
| `warning` | caution, "later" | `#fabf4d` | `#ff9a3c` | `#ff8040` |
| `danger` | errors, elite warnings | `#f57373` | `#ff9a3c` | `#ff8040` |
| `quest` | quest names | `#ffd673` | `#ffe07a` | `#ffd673` |
| `npc` | people to talk to | `#94c9ff` | `#8ccbff` | `#ffffff` |
| `item` | items | `#c7adff` | same | same |
| `place` | places and coordinates | `#f5ad85` | same | same |
| `object` | objects to interact with | `#dbc9a8` | same | same |
| `level` | levels | `#f5f7fc` | same | same |
| `skill` | professions and skills | `#99e075` | same | same |
| `spell` | spells and abilities | `#78dbed` | same | same |
| `faction` | factions and reputation | `#f799c9` | same | same |
| `area` | zones and areas | `#edbf99` | same | same |
| `achievement` | achievements | `#ffa352` | same | same |
| `dungeon` | dungeon and raid entrances | `#a385ff` | same | same |
| `rare` | rare NPCs | `#ff8052` | same | same |

### Washes (skins only)

Translucent ink laid over a ground. On the Polestar base they are `ink` at
the scheme's alpha (a scheme sets the alphas through `washes`); a skin may
give them as full colours instead.

| Token | Where | Dusk | Halo | Hearth | Forever |
|---|---|---|---|---|---|
| `border` | hairline borders of panels and controls | `#ffffff@0.10` | `#ffffff@0.14` | `#6b6b6b` | `#5c4a30` |
| `divider` | lines between sections | `#ffffff@0.10` | `#ffffff@0.12` | `#9a7a34@0.45` | `#ae9d81@0.35` |
| `hover` | the highlight under the cursor | `#ffffff@0.07` | `#ffffff@0.07` | `#ffd100@0.12` | `#ffd100@0.10` |
| `selected` | the selected row or tab | `#ffffff@0.12` | `#ffffff@0.08` | `#6e96ff@0.28` | `#ffd100@0.14` |
| `progress` | progress bar fill | `#ffffff@0.08` | `#ffffff@0.12` | `#000000@0.75` | same |
| `track` | slider and progress tracks | `#ffffff@0.12` | `#ffffff@0.18` | `#000000` | same |
| `toggle` | a toggle's track | `#ffffff@0.14` | `#ffffff@0.16` | `#000000` | same |
| `box` | checkbox boxes | `#ffffff@0.22` | `#ffffff@0.35` | `#8a7a5a` | same |
| `thumb` | slider thumbs, scrollbar thumbs | `#ffffff@0.22` | `#f4efe6` | `#ffe27a` | same |
| `swatch` | colour swatch edges | `#ffffff@0.25` | same | same | same |
| `chip` | small chips and pills | `#ffffff@0.07` | `#ffffff@0.08` | `#000000@0.60` | same |
| `watermark` | the faint wordmark on empty states | `#ffffff@0.028` | same | same | same |
| `mover` | the drag handle's ground while hovered | `#ffffff@0.06` | same | `#ffd100@0.12` | same |

### Roles (skins only)

Derived from other tokens on the Polestar base (the "from" column) unless a
skin gives them; the other bases give them outright, except `closeFill`,
`closeEdge` and `closeGlyph`, which every base derives the same way, and
`windowBorder`, which the player's border settings override on every base.

| Token | Where | Polestar: from | Halo | Hearth | Forever / Blizzard / Classic |
|---|---|---|---|---|---|
| `accent` | the accent, when the player has none of their own | Polestar gold `#e6ba66` (a scheme's `accent` or a skin's `accent` token stands in) | `#ffd100` | `#ffd100` | `#ffd100` |
| `title` | window titles | `text` | `#f4efe6` | `#ffd100` | `#ffd100` |
| `textOff` | disabled text | `textMuted` | `#6e675c` | `#808080` | `#808080` |
| `link` | links | `npc` | `#8ccbff` | `#ffd100` | `#ffd100` |
| `todo` | the current goal's mark | `accent` | `#ffd100` | `#ffd100` | `#ffd100` |
| `later` | goals for later | `warning` | `#ff9a3c` | `#ff8040` | `#ff8040` |
| `arrive` | "you are here" / arrival | `success` | `#5fd068` | `#58c04a` | `#58c04a` |
| `manual` | goals the player ticks by hand | `item` | `#b49cff` | `#c77dff` | `#c77dff` |
| `skipped` | skipped goals | `spell` | `#5cc8d6` | `#71d5ff` | `#71d5ff` |
| `separator` | separators in the guide window | `divider` | `#ffffff@0.12` | `#9a7a34@0.45` | `#ae9d81@0.35` / `#ffd100@0.35` / `#969696@0.45` |
| `rowLine` | lines between rows | `divider` | `#ffffff@0.08` | `#ffffff@0.06` | same |
| `veil` | Halo's veil under the guide window's text | `bg` | `#080604@0.60` | `#000000@0` | same |
| `veilWindow` | Halo's veil under other windows | `bg` | `#080604@0.84` | `#000000@0` | same |
| `menuBg` | menu grounds | `panel` | `#120e0a@0.97` | `#000000@0.92` | same |
| `control` | control grounds | `panelAlt` | `#ffffff@0.06` | `#000000` | same |
| `icon` | glyphs at rest | `textDim` | `#c2b9a9` | `#ffd100` | `#ceb282` / `#e8e8e8` / `#ffd100` |
| `iconHover` | glyphs under the cursor | `text` | `#f4efe6` | `#ffd100` | `#f2d199` / `#ffffff` / `#ffffff` |
| `buttonText` | text on buttons | `text` | `#f4efe6` | `#ffd100` | `#ffd100` |
| `personName` | the name of the person to talk to now | `npc` | `#8ccbff` | `#ffd100` | `#ffd100` |
| `tabRest` | tabs at rest | `textDim` | `#c2b9a9` | `#a38d58` | `#ffd100` |
| `rowLabel` | row labels in the settings | `text` | `#f4efe6` | `#ffffff` | `#ffd100` |
| `navRest` | sidebar entries at rest | `textDim` | `#c2b9a9` | `#cccccc` | `#ffd100` |
| `accentLine` | the line under dropdowns | **derived from the accent at run time; a skin's value is ignored on this base** | `#ffd100@0.35` | `#9a7a34@0.60` | `#ae9d81@0.50` / `#ffd100@0.45` / `#969696@0.60` |
| `padSelect` | the gamepad selection | **ignored on this base** (accent @0.12) | `#ffd100@0.12` | `#ffd100@0.14` | same |
| `chipAccent` | accent-tinted chips | **ignored on this base** (accent @0.16) | `#ffd100@0.16` | `#ffd100@0.16` | same |
| `inputBg` | edit box grounds | **ignored on this base** (`shade` @0.35) | `#000000@0.35` | `#000000` | same |
| `closeFill` | the guide window's close square (shown by a [`guideTitle`](#surfaces-hooks) hook) | `danger` | `danger` | `danger` | `danger` |
| `closeEdge` | the close square's edge | `border` | `border` | `border` | `border` |
| `closeGlyph` | the close square's cross | `text` | `text` | `text` | `text` |
| `windowBorder` | the window border, on every base | the player's border colour, else the accent when they chose that (`ui.borderAccent`), else the skin's `windowBorder`, else `border` | same | same, with `windowEdge` before `border` | same, with `windowEdge` before `border` |

### The game looks' own (skins only)

Read only by Hearth's and the game looks' painters; a skin on `polestar` or
`halo` may set them, but nothing reads them there.

| Token | Where | Hearth | Forever | Blizzard | Classic |
|---|---|---|---|---|---|
| `bgBottom` | the bottom of the window's gradient | `#090704@0.95` | `#000000@0.96` | same | `#101010@0.85` |
| `skyBottom` | the bottom of the band's gradient | `#150f06` | same | same | same |
| `windowEdge` | the window border when the player has no colour of their own | `#5c4518` | `#5c4a30` | `#404040` | `#696969` |
| `frameEdge` | panel edges | `#9a7a34` | same | same | same |
| `frameEdgeDark` | darker panel edges | `#5c4518` | same | same | same |
| `titleLine` | the line under titles, tile and button edges | `#6b5420` | same | same | same |

### Art and brand (skins only)

| Token | Where | Everywhere |
|---|---|---|
| `mapUnexplored` | multiplied onto unexplored map overlays | `#99a8e6` |
| `haze` | the faint blue haze in a night header | `#4a60aa@0.25` |
| `discord` | the Discord mark's colour, where Polestar links its Discord | `#5865f2` |

Not tokens (refused in a spec, but present in `Palette()` for reading):
`arrow`, `arrowNear`, `arrowText`, `arrowNearText` (the player's arrow
colours, else accent and success), `scheme`, `skin`, `skinId`.

```lua
local ADDON = ...
local Theme = Polestar.Theme
-- Recolour only: the house frames, warmer subjects. Reads every token back.
assert(Theme.RegisterSkin("ref-tokens", {
	api = 1, name = "Tokens", addon = ADDON,
	tokens = { quest = "#ffe08a", npc = "#9fd4ff", success = "#7fe0a0", warning = "#ffc266", title = "#fff1c7" },
}))
local pal = Theme.PaletteFor("ref-tokens")
assert(pal.quest[1] == 1 and pal.title[4] == 1)
local ok, why = Theme.RegisterSkin("ref-typo", { name = "Typo", addon = ADDON, tokens = { qeust = "#ffffff" } })
assert(ok == false and why:find('unknown token "qeust"'), why)
```

## Font roles

Every Polestar string has a role; `fontSizes` sets a role's size (6-40
points). The weight is fixed per role; the player's text size (0.8-1.4)
scales every size.

| Role | Weight | Size | Where |
|---|---|---|---|
| `hero` | semibold | 26 (Halo, Hearth and the game looks: 24) | settings page titles |
| `display` | semibold | 18 | the guide's step title, empty-state titles |
| `title` | semibold | 15 | window and guide titles |
| `heading` | semibold | 13 | section headers |
| `body` | medium | 13 | goal lines, row labels |
| `label` | medium | 12 | controls |
| `note` | regular | 12 | tips and descriptions |
| `small` | medium | 11 | secondary lines |
| `number` | semibold | 12 | counters, pin numbers |
| `caption` | semibold | 11 | pills and chips |
| `goal` | medium | 14 | the guide window's goal lines |
| `name` | semibold | 15 | the person to talk to now |
| `mono` | medium | 12 | ids and codes |

Fonts Polestar ships: `inter` (Inter: Regular, Medium, SemiBold), `fira`
(Fira Sans: Regular, Medium, SemiBold), `opensans` (Open Sans: Regular for
regular and medium, Bold for semibold), `game` (the client's font). All cover
Latin, Greek and Cyrillic; Chinese and Korean clients always use `game`.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("ref-type", {
	api = 1, name = "Type", addon = ADDON,
	font = { regular = "Interface\\AddOns\\" .. ADDON .. "\\Fonts\\Mine-Regular.ttf",
		semibold = "Interface\\AddOns\\" .. ADDON .. "\\Fonts\\Mine-Bold.ttf" }, -- medium falls back to regular
	fontSizes = { goal = 15, display = 20 },
}))
local ok, why = Theme.RegisterSkin("ref-type-bad", { name = "Bad", addon = ADDON, fontSizes = { goal = 50 } })
assert(not ok and why:find("fontSizes.goal"), why)
```

## Surfaces: painters

Polestar paints each of its frames by **kind** (`Theme.Skin(frame, kind)`).
A skin may paint any kind itself through `paint.<kind>`:

| Kind | Frames | Marks on the frame |
|---|---|---|
| `window` | every window: settings, guide menu, hub, dialogs, popups, movers; and the guide window and toasts unless you give `guide` / `toast` | `psBare` (the player made it transparent: paint no ground), `psBgAlpha` (its own ground opacity, else `Theme.GroundAlpha()`), `psBgColor` (`{ r, g, b }`: its own ground colour), `psNoBorder` (never a window border), `psGuide`, `psLight` |
| `guide` | the guide window and the class card toast (a `window` with `psGuide`) | as `window` |
| `toast` | toasts, alerts, the party panel, the move bar (a `window` with `psLight`) | as `window` |
| `panel` | menus, popups, raised panels, the fallback for an unknown kind | `psBare` |
| `sidebar` | the settings' and guide menu's sidebar | |
| `inset` | wells inside a window | |
| `button` | buttons, cards, rows that act as buttons | `psTextButton` (a text button, as opposed to a card or row) |
| `tile` | action tiles | |
| `dropdown` | dropdown controls | |
| `editbox` | edit boxes | `psFocused` (has the cursor) |
| `checkbox` | check boxes (the base builds the box in `frame.psSkin.box`) | |
| `tab` | tabs | `psSelected` |
| `close` | close buttons | |
| `scrollbar` | scroll bars (`frame.thumb` or `frame.psThumb` is the thumb) | |

A painter is `function(frame, base, kit)`:

- `frame`: the frame to paint, with the marks above.
- `base`: the painter of your base look for this kind (for `guide` and
  `toast`, the base's `window` painter): `base(frame)` paints the frame as
  the base would. Call it first and add to it, call it and then hide what you
  replace, or leave it out and paint everything yourself.
- `kit`: [the paint kit](#the-paint-kit), also at `Polestar.Theme.SkinKit`.

Rules a painter must follow:

1. **Idempotent.** It runs again whenever the player changes a colour, the
   scheme, the skin, the UI scale, or the frame's own marks. Create textures
   once (keep them in `kit.store(frame)`), then only show, hide, tint and
   place them.
2. **Read colours inside.** `Theme.Color`, `Theme.Accent`, `Theme.Wash` at
   paint time, never captured at load.
3. **Respect `psBare`.** A transparent window shows no ground, border or
   decoration: hide yours.
4. **Everything you create goes in `kit.store(frame)`.** Polestar hides all
   of it when another skin paints the frame, so switching skins leaves no
   stray pieces.
5. **Never create frames (CreateFrame) parented to the frame in a painter**
   unless you must; textures are enough for grounds, lines and edges, and
   frames cost more.
6. **No errors.** One error turns your whole skin off for the session
   ([Run-time errors](#run-time-errors)).

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("ref-paint", {
	api = 1, name = "Paint", addon = ADDON,
	paint = {
		-- Keep the house window, add a two-pixel accent line at its top.
		window = function(frame, base, kit)
			base(frame)
			local own = kit.store(frame)
			if frame.psBare then
				if own.top then own.top:Hide() end
				return
			end
			if not own.top then
				own.top = frame:CreateTexture(nil, "BORDER")
				own.top:SetTexture(Theme.Media("white"))
				own.top:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
				own.top:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
			end
			own.top:SetHeight(2 * Theme.Pixel(frame))
			local r, g, b = Theme.Accent()
			own.top:SetVertexColor(r, g, b, 0.7)
			own.top:Show()
		end,
		-- Replace the house button entirely: a flat accent-tinted ground.
		button = function(frame, base, kit)
			local r, g, b = Theme.Accent()
			kit.fill(frame):SetVertexColor(r, g, b, frame.psTextButton and 0.18 or 0.08)
			kit.border(frame, r, g, b, 0.35)
			kit.hoverWash(frame)
		end,
	},
}))
```

## The paint kit

`kit` (and `Polestar.Theme.SkinKit`):

| Function | Returns | What it does |
|---|---|---|
| `kit.fill(frame, layer?, sub?)` | texture | The frame's ground: one white texture over the whole frame (created on `BACKGROUND` at sub-level -7 the first time, with `layer`/`sub` if given), shown. Tint it with `SetVertexColor`. There is one per frame: the base painters use the same one. |
| `kit.gradient(frame, top, bottom, layer?, sub?)` | texture | That ground as a vertical gradient; `top` and `bottom` are `{ r, g, b, a }`. Falls back to a flat `top` on a client without gradients. |
| `kit.border(frame, r, g, b, a, layer?, size?)` | | A pixel-exact border around the frame: four edge textures, `size` physical pixels thick (default 1), drawn outward so the frame's children never cover it. One border per frame: a second call retints and resizes it. |
| `kit.hideBorder(frame)` | | Hides that border. |
| `kit.hoverWash(frame)` | texture | A `HIGHLIGHT`-layer wash over the frame, tinted with `Theme.Wash("hover")`, shown by the client while the cursor is over it. |
| `kit.store(frame)` | table | A table on the frame for your own textures and frames. Keep everything you create here. Polestar hides everything in it (recursively: tables of textures too) when another skin paints the frame. |
| `kit.bare(frame)` | | Hides the ground, border, drop shadow, veil, nine-slices and everything in `kit.store(frame)`: what a `psBare` window should look like. |

```lua
local ADDON = ...
local Theme = Polestar.Theme
local kit = Theme.SkinKit
assert(type(kit.fill) == "function" and type(kit.gradient) == "function" and type(kit.border) == "function")
assert(type(kit.hideBorder) == "function" and type(kit.hoverWash) == "function")
assert(type(kit.store) == "function" and type(kit.bare) == "function")
assert(Theme.RegisterSkin("ref-kit", {
	api = 1, name = "Kit", addon = ADDON,
	paint = {
		panel = function(frame, base, kit)
			if frame.psBare then return kit.bare(frame) end
			local r, g, b, a = Theme.Color("panel")
			local sr, sg, sb = Theme.Color("shade")
			kit.gradient(frame, { r, g, b, a }, { (r + sr) / 2, (g + sg) / 2, (b + sb) / 2, a })
			kit.border(frame, Theme.Wash("border"))
		end,
	},
}))
```

## Surfaces: hooks

The waypoint arrow, the map pins and the guide window's title row draw
themselves and then hand the frame to your hook, if the skin in use has one. A hook may add to what is drawn
(keep what you create on the frame you are given, created once) and tint
what it can reach; Polestar's own arrow and map icon designs are chosen with
`arrow` and `mapIcons` in the spec, which is simpler and usually enough.

| Hook | Signature | When | What you get |
|---|---|---|---|
| `arrow` | `function(frame, style)` | after the arrow repaints its look: a theme change, an arrow setting changed | `frame`: the arrow's frame (`PolestarNavArrow`, a frame of fixed size holding the dial and the distance text). `style`: `"3d"`, `"flat"`, `"halo"` or `"hearth"`. The dial's parts are **not** exposed as fields on the frame in version 1: you can overlay, not restyle. |
| `pin` | `function(pin)` | after a map pin is built or restyled, for every pin (world map, minimap, numbered route pins) | `pin`: the pin's frame. Its parts are plain fields today (`pin.icon`, `pin.medal`, `pin.mark`, `pin.glow`, `pin.edge`, `pin.text`, `pin.fill`, `pin.ring`, `pin.ring2`, `pin.back`) but they are **not** part of the versioned API: treat them as read-only and check they exist. |
| `guideTitle` | `function(nav, parts)` | after the guide window's style is applied (a skin, theme or window style change), not in the transparent window; the Looks page's preview calls it too, with its own parts | `nav`: the navigator frame (the row with the step count and the menu). `parts`, each in the base's state when the hook runs: `bar` (the title bar texture, a `sky` to `skyBottom` gradient, shown on Hearth), `close` (a close square in `closeFill`, `closeEdge` and `closeGlyph` that hides the window, hidden), `rule` (the line under the navigator), `band` (the house band behind the bars, shown on the Polestar base), `menuRight` (the menu button's inset from the right edge, `8`). Show or hide parts and set `parts.menuRight`: `26` leaves room for the close square. With the bar shown, the rule takes `titleLine`. Under `surfaces.guideTitle`. |

Hooks run often (one per pin per restyle). Keep them cheap; create nothing
on every call.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("ref-hooks", {
	api = 1, name = "Hooks", addon = ADDON, arrow = "halo", mapIcons = "halo",
	hooks = {
		-- A soft accent halo behind the arrow, created once.
		arrow = function(frame, style)
			if not frame.myHalo then
				frame.myHalo = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
				frame.myHalo:SetTexture(Theme.Media("glow"))
				frame.myHalo:SetPoint("TOP", frame, "TOP", 0, 10)
				frame.myHalo:SetSize(96, 96)
				frame.myHalo:SetBlendMode("ADD")
			end
			local r, g, b = Theme.Accent()
			frame.myHalo:SetVertexColor(r, g, b, style == "halo" and 0.25 or 0.15)
			frame.myHalo:Show()
		end,
		-- Dim the pin's medallion a little (a field that may not exist on an older Polestar).
		pin = function(pin)
			if pin.medal and pin.medal.GetVertexColor then
				local r, g, b, a = pin.medal:GetVertexColor()
				pin.medal:SetVertexColor(r, g, b, a * 0.9)
			end
		end,
	},
}))
```

## Events

| Field | Signature | When |
|---|---|---|
| `onApply` | `function(id)` | Your skin became the one in use: the player picked it, or it was the saved choice at login (after settings are read), or your addon registered it while the saved choice waited for it. Called with your skin's id. |
| `onLeave` | `function(id)` | Another skin replaced yours, or yours failed this session (the one case where something of a failed skin still runs, once). |

Both run under `pcall`; an error in them fails the skin like a painter's
would. Use them for frames of your own (show/hide a custom background you
anchor elsewhere), not for Polestar's frames, which painters cover.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local shown = false
assert(Theme.RegisterSkin("ref-events", {
	api = 1, name = "Events", addon = ADDON,
	onApply = function(id) shown = true end,
	onLeave = function(id) shown = false end,
}))
Polestar.Set("ui.skin", "ref-events")
assert(shown == true and Theme.SkinId() == "ref-events")
Polestar.Set("ui.skin", "polestar")
assert(shown == false and Theme.SkinId() == "polestar")
```

## Legibility rules

Polestar holds text to WCAG contrast floors on every ground, and your scheme
or skin is measured against the same rule at registration:

- `text` 7:1, `textDim` and `textMuted` 4.5:1, on each of the six grounds
  (`bg`, `panel`, `panelAlt`, `sidebar`, `footer`, `sky`).
- Every status and subject colour (`quest`, `npc`, `dungeon`...) 4.5:1 on
  each ground but `sky`. For a scheme these colours are Polestar's fixed set,
  so a very light ground can fail on, say, `dungeon on panelAlt`: the fix is
  a darker ground, which is also what Polestar does for you.
- A translucent ground is measured as it is seen: `bg` over black, the other
  grounds over `bg`. Halo's `panelAlt` of white at 6 % counts as near-black.

Outcomes:

| Case | `strict` off (default) | `strict = true` |
|---|---|---|
| everything reads | `true, nil` | `true, nil` |
| grounds too light for the text | the six grounds are darkened **together** (OKLab lightness, alpha kept) by the least that makes every text read; `true, "textMuted on panelAlt reads 3.9:1, needs 4.5:1; the grounds were darkened (-0.12) until the text reads"`. The stored palette is the corrected one. | `false, "textMuted on panelAlt reads 3.9:1, needs 4.5:1"` |
| text too dark to read even on black | `false, "text on bg reads 2.1:1, needs 7:1 even with the grounds at their darkest"` | the same |

At run time Polestar keeps darkening the grounds of a `polestar`-based skin
if the player's own ground colour or brightness would drop the text below
the floor (the other bases have no such controls). A skin's own `text`
tokens on the Polestar base go through the same guard.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local grey = { bg = "#8a8a8a", panel = "#8a8a8a", panelAlt = "#909090", sidebar = "#858585", footer = "#858585", sky = "#959595",
	text = "#ffffff", textDim = "#eeeeee", textMuted = "#dddddd" }
local ok, note = Theme.RegisterScheme("ref-light", { name = "Light", addon = ADDON, tokens = grey })
assert(ok == true and note:find("darkened"), note)
assert(Theme.Legibility(Theme.PaletteFor("polestar")) >= 1)
local refused, why = Theme.RegisterScheme("ref-light-strict", { name = "Light", addon = ADDON, tokens = grey, strict = true })
assert(refused == false and why:find("needs") and not why:find("darkened"), why)
```

## Validation and error messages

A refused spec registers nothing and returns `false, reason`. Refusals and
notes are also written to Polestar's debug log (`/polestar debug` toggles
debug output). The checks run in this order; the first failure is the one
you see:

| Check | Message |
|---|---|
| spec is a table | `the spec must be a table` |
| every field is known | `unknown field "<name>"` |
| id shape | `the id must be a word of letters, digits, _ or - (32 at most), starting with a letter` |
| id free | `the id "<id>" is taken (<addon or Polestar>)` |
| `api` | `api must be a whole number from 1`; `needs Skin API <n>; this Polestar has <m> (update Polestar)` |
| `name` | `name must be a name of 1-40 characters` |
| `addon` | `addon must be your addon's folder name` |
| `author`, `version` | `author must be a string` (also when longer than 40) |
| `desc` | `desc must be a string of 200 characters at most` |
| `tokens` | `tokens must be a table`; `unknown token "<name>" in tokens`; `token "<name>" is not a colour (give { r, g, b[, a] } in 0-1 or "#rrggbb")` |
| scheme: required tokens | `tokens.<name> is missing (a scheme gives bg, panel, panelAlt, sidebar, footer, sky, text, textDim, textMuted)` |
| scheme: skin-only tokens | `tokens.<name> belongs to a skin, not a scheme (a scheme gives the grounds and the text ladder)` |
| scheme: `accent` | `accent is not a colour` |
| scheme: `washes` | `washes must be a table`; `unknown wash "<name>"`; `washes.<name> must be an alpha from 0 to 1` |
| skin: `base` | `base must be one of Polestar's skins: polestar, halo, hearth, forever, blizzard, classic` |
| skin: `scheme` | `scheme goes with base "polestar" (the other looks bring their own grounds)`; `scheme "<id>" is not registered (register it first)` |
| skin: `font` | `font must be "game", "inter", "fira", "opensans" or a table of font files`; `a font table needs regular = "Interface\\AddOns\\...\\file.ttf" (medium, semibold optional)`; `font.<weight> must be a file path` |
| skin: `fontSizes` | `fontSizes must be a table`; `unknown fontSizes "<role>"`; `fontSizes.<role> has the wrong type` (also for a size outside 6-40) |
| skin: `icons`, `media`, `paint`, `hooks` | `<field> must be a table`; `unknown <field> "<key>"` (not for `icons`, where any glyph name is allowed); `<field>.<key> has the wrong type` |
| skin: `textShadow` | `textShadow must be { x, y, alpha } or false` |
| skin: `arrow` | `arrow must be "3d", "flat", "halo" or "hearth"` |
| skin: `mapIcons` | `mapIcons must be "polestar", "halo" or "hearth"` |
| skin: `onApply`, `onLeave` | `<name> must be a function` |
| legibility | see [Legibility rules](#legibility-rules) |

```lua
local ADDON = ...
local Theme = Polestar.Theme
local function refused(pattern, ok, why)
	assert(ok == false and why:find(pattern, 1, true), tostring(why))
end
refused("the spec must be a table", Theme.RegisterSkin("ref-v1", "oops"))
refused('unknown field "colour"', Theme.RegisterSkin("ref-v2", { name = "X", addon = ADDON, colour = "#fff" }))
refused("the id must be a word", Theme.RegisterSkin("2fast", { name = "X", addon = ADDON }))
refused('the id "halo" is taken (Polestar)', Theme.RegisterSkin("halo", { name = "X", addon = ADDON }))
refused("needs Skin API 9", Theme.RegisterSkin("ref-v3", { api = 9, name = "X", addon = ADDON }))
refused("base must be one of", Theme.RegisterSkin("ref-v4", { name = "X", addon = ADDON, base = "moonlit" }))
refused('scheme "nope" is not registered', Theme.RegisterSkin("ref-v5", { name = "X", addon = ADDON, scheme = "nope" }))
refused("arrow must be", Theme.RegisterSkin("ref-v6", { name = "X", addon = ADDON, arrow = "spiral" }))
refused("tokens.textMuted is missing", Theme.RegisterScheme("ref-v7", { name = "X", addon = ADDON,
	tokens = { bg = "#101010", panel = "#141414", panelAlt = "#1a1a1a", sidebar = "#0c0c0c", footer = "#0e0e0e", sky = "#202020", text = "#ffffff", textDim = "#cccccc" } }))
```

## Run-time errors

Every painter, hook, `onApply` and `onLeave` of a registered skin runs under
`pcall`. On the first error, Polestar:

1. records it once in its error list as `skin <id> (<addon>): <error>`
   (shown by `/polestar report`, and `Theme.SkinInfo(id).failed` holds it);
2. prints one chat line: *"The skin <name> (from <addon>) ran into an error,
   so Polestar's own look stands in until you reload. Its addon may need an
   update."*;
3. turns the skin off **for the session**: `Theme.SkinId()` answers
   `"polestar"`, everything is repainted in Polestar's own look, your
   `onLeave` runs once, and none of your painters or hooks run again;
4. keeps the player's choice: `ui.skin` still names your skin, so after a
   `/reload` with a fixed addon it is back without the player doing anything.

A refused registration is not a run-time error: nothing is registered, the
player sees Polestar's own look, and their saved choice waits.

## Capabilities

`Theme.HasCapability(name)` is `true` for each of these in version 1:

| Capability | Means |
|---|---|
| `schemes`, `skins` | `RegisterScheme`, `RegisterSkin` |
| `tokens` | `tokens` in both specs |
| `legibility` | the contrast check, with correction and `strict` |
| `fonts`, `fontSizes`, `textShadow` | those skin fields |
| `icons` | the `icons` map |
| `media.band`, `media.bandStars`, `media.medallion` | each `media` key |
| `arrow.style`, `mapIcons` | the `arrow` and `mapIcons` fields |
| `events` | `onApply`, `onLeave` |
| `preview` | `DrawSkinCard`, `DrawSchemeCard`, cards in the picker |
| `surfaces.window`, `surfaces.guide`, `surfaces.toast`, `surfaces.panel`, `surfaces.sidebar`, `surfaces.inset`, `surfaces.button`, `surfaces.tile`, `surfaces.dropdown`, `surfaces.editbox`, `surfaces.checkbox`, `surfaces.tab`, `surfaces.close`, `surfaces.scrollbar` | each painter kind |
| `surfaces.arrow`, `surfaces.pin`, `surfaces.guideTitle` | each hook |

A later Polestar adds capabilities without raising `API_VERSION`; test for
the one you need and leave the feature out where it is missing
([versioning](versioning.md)).
