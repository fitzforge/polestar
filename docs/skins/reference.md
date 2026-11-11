# Skin API reference

Everything on `Polestar.Theme` a skin addon may use, with every argument,
return value, token, surface, hook, capability and error. The behaviour
described here is what Polestar 0.3.8 does (Skin API version 2); the examples
were run against it. Concepts are in the [overview](README.md); a build from
zero is in [getting started](getting-started.md).

- [Functions](#functions)
  - [RegisterScheme](#registerschemeid-spec)
  - [RegisterSkin](#registerskinid-spec)
  - [Reading the palette](#reading-the-palette)
  - [Asking about skins and schemes](#asking-about-skins-and-schemes)
  - [Installed skin addons](#installed-skin-addons)
  - [Version and capabilities](#version-and-capabilities)
  - [Drawing preview cards](#drawing-preview-cards)
  - [Presets](#presets)
  - [Other Theme functions a skin may use](#other-theme-functions-a-skin-may-use)
- [Ids](#ids)
- [Colours](#colours)
- [Common spec fields](#common-spec-fields)
- [Scheme spec](#scheme-spec)
- [Skin spec](#skin-spec)
- [Variants](#variants)
- [The resolver](#the-resolver)
- [Shadow and art tint](#shadow-and-art-tint)
- [Tokens](#tokens)
- [Font roles](#font-roles)
- [Surfaces: painters](#surfaces-painters)
- [The paint kit](#the-paint-kit)
- [Surfaces: hooks](#surfaces-hooks)
  - [The arrow and the map pins](#the-arrow-and-the-map-pins)
  - [The guide window](#the-guide-window)
  - [Cards, toasts and buttons](#cards-toasts-and-buttons)
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
  - `true, "<note>"`: accepted, but Polestar moved the grounds so the text
    reads; the note says which text on which ground fell short and by how
    much the grounds moved ([Legibility rules](#legibility-rules)).
  - `false, "<reason>"`: refused; nothing was registered. Reasons are listed
    under [Validation](#validation-and-error-messages).
- Registering a scheme that a saved `ui.scheme` (or the skin in use) is
  waiting for repaints Polestar in it at once.
- The checks a spec goes through come with Polestar in a folder of their own,
  `Polestar_SkinAPI`, which loads on demand: the first scheme or skin another
  addon registers loads it, so a player who uses no skin addon never does.
  If that folder is missing or disabled in the AddOns list, every
  registration answers `false, "the Skin API's checks did not load (is the
  Polestar_SkinAPI folder installed and enabled?)"`.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local ok, message = Theme.RegisterScheme("ref-ember", {
	api = 2, name = "Ember", addon = ADDON,
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
fonts, media, art choices, painters and hooks the spec names changed.

- `id`: string, see [Ids](#ids).
- `spec`: table, see [Skin spec](#skin-spec).
- Returns `ok, message` with the same meaning as `RegisterScheme`.
- Registering a skin that a saved `ui.skin` is waiting for applies it at
  once (its `onApply` runs, every frame repaints).
- A refused skin the player has chosen (their saved `ui.skin` names it) also
  says so once in chat, naming your addon, so the report reaches you: *The
  skin `<id>` (from `<addon>`) could not be added: `<reason>`. Polestar's own
  look stands in.* A refused skin nobody chose stays silent; the reason is
  in the return value and the debug log.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local ok, message = Theme.RegisterSkin("ref-ember", {
	api = 2, name = "Ember", addon = ADDON,
	base = "polestar", scheme = "ref-ember", font = "inter",
})
assert(ok, message)
```

### Reading the palette

These read the palette **in use** (the live skin, its variant, its resolver,
the scheme and the player's own colours over them). Call them inside
painters and hooks, never once at load: the answers change whenever the
player changes a setting.

| Function | Returns | Notes |
|---|---|---|
| `Color(token)` | `r, g, b, a` (0-1) | The token's colour in use. An unknown token answers the `text` colour, so a typo shows up as white text rather than an error. |
| `Accent()` | `r, g, b` | The accent in use: the player's own, their class colour, the skin's or scheme's `accent`, or Polestar gold. |
| `Wash(name)` | `r, g, b, a` | One of the ink washes ([washes](#washes-skins-only)); an unknown name answers `border`. |
| `Hex(token)` | `"ffrrggbb"` | For `\|c` colour escapes in text. |
| `Palette()` | table | The whole resolved palette, token -> `{ r, g, b, a }`. Read-only: do not change it. |
| `PaletteFor(id)` | table or nil | The palette skin `id` would give, with the player's own colours over it; nil for an unknown id. What the picker's cards are drawn from. |
| `SkinToken(name)` | `r, g, b, a` or nil | A token the skin in use gives **itself** (in its `tokens`, its variant's or its resolver's), as resolved; nil when it leaves the token to Polestar. Polestar's modules read their skin-only colours this way (the pins' `pinRing` and `pinFill`, the arrow's `glow`) and keep their own default otherwise. |
| `Media(name)` | path | `"Interface\\AddOns\\Polestar\\Media\\UI\\<name>"` for one of Polestar's own textures (the files in `addon/Polestar/Media/UI`, without `.tga`); a string that already holds `\` or `/` comes back as given. `Media("white")` is the plain white texture every fill is tinted from. |
| `SkinMedia(name)` | path or nil | The live skin's own `media.<name>` (its variant's first), nil when it has none. |
| `Icon(name)` | name or path | A glyph name as the live skin maps it (`icons` in its spec), else `name` itself. Pass the result to `Media`. |
| `GroundAlpha()` | number | The player's window opacity (`ui.bgOpacity`, default 0.94). |
| `WindowBorder()` | `shown, size` | Whether the player has a window border, and its thickness in pixels. |
| `ShowsBand()`, `ShowsRim()` | boolean | Whether the player shows the starlit header band / the accent rim. |
| `ReduceMotion()` | boolean | The player asked for less motion: keep your own pieces still (the kit's `crossfade` is instant then). |
| `Pixel(region)` | number | One physical pixel in `region`'s coordinate space, for crisp lines. |
| `Contrast(c1, c2)` | number | WCAG contrast ratio of two colours (`{ r, g, b }` tables). |
| `Legibility(palette)` | number | How the palette stands against the text floors: >= 1 means every text role reads. |
| `IsLightPalette(palette)` | boolean | Whether the palette's text is darker than its window ground (a light scheme, [Legibility](#legibility-rules)). |

```lua
local Theme = Polestar.Theme
local r, g, b = Theme.Color("panel")
local ar, ag, ab = Theme.Accent()
local br, bg, bb, ba = Theme.Wash("border")
local white = Theme.Media("white")           -- the texture every fill tints
local own = Theme.Media("Interface\\AddOns\\MySkin\\art.tga") -- comes back unchanged
assert(white:find("Polestar") and own:find("MySkin"))
assert(Theme.SkinToken("pinFill") == nil)    -- Polestar's own look gives no pin fill of its own
```

### Asking about skins and schemes

| Function | Returns |
|---|---|
| `SkinId()` | The id of the skin **in use as drawn**: the saved `ui.skin` when that skin is registered and has not failed this session, else `"polestar"`. |
| `SkinKey()` | The **built-in look** the skin in use is drawn from: a registered skin's `base` (or its variant's); a built-in skin's own id. Modules that keep art per look read this, so a skin on `halo` is treated as Halo by them. |
| `SkinScheme()` | The scheme the skin in use brings (`spec.scheme`, or its variant's), or nil. While it is not nil the player's scheme setting has no effect. |
| `SkinArrowStyle()` | The skin in use's `arrow` choice (or its variant's), or nil for its base look's. |
| `SkinMapIcons()` | The skin in use's `mapIcons` choice, or nil. |
| `SkinVariants(id)` | The [variants](#variants) of skin `id` for a picker: `{ { id, name, desc }, ... }` in the skin's order, or nil for a skin without them. |
| `SkinVariant(id)` | The variant of skin `id` in use: the player's pick while the skin still has it, else the skin's `defaultVariant`; nil for a skin without variants. |
| `GameSkin(id?)` | `true` when the skin (in use, or `id`) is drawn in the game's controls and colours: `hearth`, `forever`, `blizzard`, `classic` and skins drawn from them. |
| `SchemeKey()` | The player's scheme setting as resolved: a registered or built-in scheme id, `"dusk"` for an unknown one. Note it is the **player's** scheme even while a skin's own scheme overrides it; use `SkinScheme()` for that. |
| `SkinChoices()` | The picker's list, in order: `{ { value, text, addon?, desc?, author? }, ... }`. The six built-in skins first, then registered skins in registration order. Built-ins have no `addon`. Asking for it first loads every [installed skin addon](#installed-skin-addons) that can load, so the list is complete. |
| `SchemeChoices()` | `{ { value, text, addon?, desc?, author? }, ... }`: `dusk`, `night`, `graphite`, then registered schemes. |
| `SkinInfo(id)` | `{ id, name, addon, author, version, desc, base, scheme, builtin, failed, api }` or nil for an unknown id. `builtin` is a boolean; `failed` is the error string once the skin has failed this session, else nil; `api` is the Skin API version the spec was written for (its `api`, `1` when it gave none; a built-in answers `API_VERSION`). For a built-in, `name` is translated and `addon` is nil. |
| `SchemeInfo(id)` | `{ id, name, addon, author, version, desc, builtin, api }` or nil. |

```lua
local Theme = Polestar.Theme
local info = Theme.SkinInfo("halo")
assert(info.builtin == true and info.addon == nil and info.api == Theme.API_VERSION)
assert(Theme.SkinInfo("no-such-skin") == nil)
assert(Theme.SkinVariants("halo") == nil and Theme.SkinVariant("halo") == nil)
for _, c in ipairs(Theme.SkinChoices()) do
	-- c.value is the id to save, c.text the name shown, c.addon who brought it
	assert(type(c.value) == "string" and type(c.text) == "string")
end
```

### Installed skin addons

A skin addon may name the skins and schemes it registers in its TOC, the
way a guide pack names itself:

```
## X-Polestar-Skin: ember, ember-dark
## LoadOnDemand: 1
```

With that line Polestar knows the addon before it is loaded, so it may load
on demand and cost the player nothing until one of its skins is wanted.
Polestar loads it (out of combat; in a fight, once the fight ends):

- at login, when the saved `ui.skin` or `ui.scheme` is one of its ids;
- when the player picks one of its ids;
- when the settings list the skins (`SkinChoices()`), so its cards show
  in the picker. This loads every installed skin addon once a session.

One id covers a skin and a scheme of that id (they are separate
namespaces). An addon with the line but without `## LoadOnDemand: 1` is
loaded by the game at login as usual, and is listed all the same.

| Function | Returns |
|---|---|
| `InstalledSkins()` | Every installed addon that declares skins, loaded or not: `{ { addon, title, notes, ids = { id, ... }, loaded, reason }, ... }`. `reason` is the client's (`"DISABLED"`, `"INTERFACE_VERSION"`, `"DEP_MISSING"`...) when the addon cannot load, nil when it is loaded or can load. |
| `LoadSkinAddon(id)` | `ok, why`: loads the installed addon that declares skin or scheme `id` when it is not loaded and can be. `true` once `id` is registered (also when it already was); else `false` and why: the client's reason (`"DISABLED"`...), `"in combat: it loads once the fight ends"`, `"its addon <addon> is loaded but did not register it"`, `"its addon <addon> loaded but did not register it"`, or `"no installed addon declares it (## X-Polestar-Skin)"`. |
| `LoadInstalledSkins()` | How many it loaded: every installed skin addon that can load, once a session, out of combat. `SkinChoices()` calls it. |

```lua
local Theme = Polestar.Theme
for _, rec in ipairs(Theme.InstalledSkins()) do
	assert(type(rec.addon) == "string" and #rec.ids > 0)
end
local ok, why = Theme.LoadSkinAddon("no-such-skin")
assert(ok == false and why:find("X-Polestar-Skin", 1, true), why)
assert(Theme.LoadSkinAddon("halo") == true) -- registered already
```

### Version and capabilities

| | |
|---|---|
| `API_VERSION` | `2`. The number a spec's `api` field is compared with ([versioning](versioning.md)). |
| `HasCapability(name)` | `true` when this Polestar offers capability `name` ([Capabilities](#capabilities)); `false` for anything else, including nil. |
| `Capabilities()` | Every capability name, sorted, as a new table. |
| `SkinSurfaces()` | The surfaces a skin can reach, sorted: `{ paint = { kind, ... }, hooks = { name, ... } }` (the [painter kinds](#surfaces-painters) and the [hooks](#surfaces-hooks)). |
| `SkinHooks(surface)` | Whether the skin in use hooks `surface` (and has not failed). |

```lua
local Theme = Polestar.Theme
assert(Theme.API_VERSION >= 2)
assert(Theme.HasCapability("skins") and Theme.HasCapability("surfaces.window"))
assert(Theme.HasCapability("surfaces.guideRow") and Theme.HasCapability("variants"))
assert(not Theme.HasCapability("surfaces.minimap"))
assert(#Theme.Capabilities() >= 64)
assert(#Theme.SkinSurfaces().hooks == 14 and #Theme.SkinSurfaces().paint == 14)
```

### Drawing preview cards

| | |
|---|---|
| `DrawSkinCard(frame, id, variant?)` | Draws skin `id`'s preview (its ground, band, a title and a line in its font, an accent bar and a button, edged by its window border) on `frame`, four units in from its edges, without touching the live look. `variant`: one of the skin's [variants](#variants), else the one in use. Creates its textures on the first call (`frame.psSkinCard`); call it again on every redraw. Nothing happens for an unknown id. |
| `DrawSchemeCard(frame, id)` | The same for a scheme, in Polestar's own style with the accent in use. |

Polestar's settings use these, and they load with the settings window (its
folder `Polestar_Options`, loaded the first time the settings open), not at
login. A skin addon with a picker of its own checks they exist, or loads
that folder first, out of combat: `C_AddOns.LoadAddOn("Polestar_Options")`.

```lua
local Theme = Polestar.Theme
if not Theme.DrawSkinCard and not InCombatLockdown() then C_AddOns.LoadAddOn("Polestar_Options") end
if Theme.DrawSkinCard then
	local card = CreateFrame("Frame")
	card:SetSize(120, 72)
	Theme.DrawSkinCard(card, "halo")
end
```

### Presets

A skin may recommend settings to go with it (roomier rows, an outline on
the text, its own panel colour): `preset = { [setting] = value }` in its
spec, keyed by the setting's path as Polestar stores it (`"ui.fontOutline"`,
`"ui.headingSize"`). A variant may carry its own preset, laid over the
skin's. Each value is checked when the skin registers: the setting exists
(Polestar registers all of its settings as it loads, before your addon), the
value has its default's type (a colour setting, default `false`, takes a
colour), and it is a look setting: the sections that decide what Polestar
does (`behavior`, `gear`, `talents`, `alts`, `party`, `lookup`, `routePlan`,
`gamepad`, `dungeons`) and `ui.skin` itself are refused.

A preset is **never applied by choosing the skin**. The Theme page offers
"Apply <skin>'s layout" while the chosen skin has one. These come with the
settings window, like the preview cards:

| | |
|---|---|
| `SkinPreset(id)` | A copy of skin `id`'s preset (its variant's over it), or nil. |
| `ApplySkinPreset(id)` | Sets each value through Polestar's settings (a value equal to its default is not stored), repaints once, and remembers what each setting was, including a colour source it turned off (your own accent turns the class accent off). `true`, or `false, "this skin has no preset"`. |
| `UndoSkinPreset()` | Puts every setting back; `true`, or `false` with nothing to undo. Applying a second preset before undoing keeps the first one's "before", so Undo always returns to where the player was. The undo lasts for the session. |
| `SkinPresetApplied()` | The skin whose preset Undo would take back, or nil. |

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("ref-preset", {
	api = 2, name = "Preset", addon = ADDON,
	preset = { ["ui.fontOutline"] = "outline", ["ui.headingSize"] = 1.2 },
}))
if Theme.SkinPreset then
	assert(Theme.SkinPreset("ref-preset")["ui.headingSize"] == 1.2)
	assert(Theme.SkinPreset("halo") == nil)
end
local ok, why = Theme.RegisterSkin("ref-preset-bad", { name = "X", addon = ADDON, preset = { ["behavior.autoAccept"] = true } })
assert(ok == false and why:find("not a look setting"), why)
```

### Other Theme functions a skin may use

Polestar's own functions a skin with frames of its own needs. Under the
capability `theme.functions` these are part of the Skin API's version
promise ([versioning](versioning.md)): they keep their arguments and meaning
within an `API_VERSION`.

| | |
|---|---|
| `Refresh()` | Repaints every skinned frame and string and tells the listeners. Call it when something **your skin** reads changed (its own saved variable), never on a timer. |
| `OnChanged(fn)` | Registers `fn` to run after every `Refresh` (a theme or skin change, a colour setting, a UI scale change). For frames of your own that are not painted through `Theme.Skin`. |
| `Skin(frame, kind)` | Paints one of **your own** frames as a Polestar surface of `kind` ([surfaces](#surfaces-painters)) in the skin in use, and keeps it repainted. Returns the frame. |
| `Repaint(frame)` | Paints a skinned frame again (after changing its `psBare` or `psBgAlpha`). |
| `Font(fontString, role)` | Sets a font string to a [role](#font-roles) in the skin in use and keeps it in step with font and skin changes. |
| `Border(frame, r, g, b, a, layer?, size?)` | A pixel-exact border around `frame` (what `kit.border` calls). |
| `Band(parent, layer?, sub?)` | The starlit header band on `parent`: a sky texture (tinted `sky`) with the stars over it, both following the skin's `media`. Returns the sky texture; size and place it. |
| `TintArt(texture, r, g, b, a)` | Colours a piece of game art `r, g, b, a` (white when nil) with the skin in use's [`artTint`](#shadow-and-art-tint) over it. Polestar's game looks draw every piece of their art through it, so a skin's tint reaches all of it and goes when the skin does; a painter that draws game art of its own may do the same. |

Polestar has other public `Theme` functions (`Metric`, `FontSpec`,
`SetFontScale`...). A skin may call them, but they are not part of the
promise: check they exist and expect them to move with Polestar's needs.

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
- A variant's id follows the same shape and is the skin's own: two skins may
  both have a variant `dark`.

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

A few fields (`shadow.color`, `artTint.tint`, and the kit's `color` options)
take a **token's name** as well as a colour: `"accent2"` means that token as
the palette resolves it at paint time.

## Common spec fields

Both specs take these. Any field not listed for the spec is refused as
`unknown field "<name>"` (usually a typo, or a field from a later API version).

| Field | Required | Type and limits | Meaning |
|---|---|---|---|
| `name` | yes | string, 1-40 characters | Shown in the picker as given. Translate it yourself if you like (`GetLocale()`). |
| `addon` | yes | string, 1-40 characters | Your addon's folder name: the first vararg of your file (`local ADDON = ...`). Shown beside the name in the picker and in every error note, so a player knows whose skin it is. |
| `api` | no | whole number >= 1 | The Skin API version you wrote for; omitted counts as `1`. Larger than this Polestar's `API_VERSION` is refused: `needs Skin API 3; this Polestar has 2 (update Polestar)`. A spec for an older version is accepted and means what it meant ([versioning](versioning.md)). |
| `author` | no | string, 1-40 characters | Shown in the picker's details. |
| `version` | no | string, 1-40 characters | Your skin's version. Polestar does not compare it with anything. |
| `desc` | no | string, 1-200 characters | One sentence, shown as the card's tooltip. |
| `strict` | no | boolean | `true`: refuse a spec whose text would not read, instead of moving its grounds ([Legibility](#legibility-rules)). |

## Scheme spec

`RegisterScheme(id, spec)`, with the common fields and:

| Field | Required | Meaning |
|---|---|---|
| `tokens` | yes | A table of token -> colour. **Must** give the six grounds and the text ladder: `bg`, `panel`, `panelAlt`, `sidebar`, `footer`, `sky`, `text`, `textDim`, `textMuted`; a missing one is refused as `tokens.<name> is missing (a scheme gives bg, panel, ...)`. **May** give `ink`, `star`, `shade`, `scrim`, `onAccent`, `shadow` (left out, Dusk's stand in) and the [status and subject colours](#status-and-subject-colours) (`success`, `quest`, `npc`...; left out, Polestar's stand in). Any other token (a wash, a role, the game looks' own: `border`, `title`, `accent`, `windowBorder`, `bgBottom`...) is refused: `tokens.<name> belongs to a skin, not a scheme (a scheme gives the grounds, the text ladder and the subject colours)`. |
| `accent` | no | A colour that stands in for Polestar gold while the player has no accent of their own and no class accent. |
| `washes` | no | Table of wash name -> alpha (0-1): how strong the white ink is for that wash in this scheme. Names: `border`, `divider`, `hover`, `selected`, `progress`, `track`, `toggle`, `box`, `thumb`, `swatch`, `chip`, `watermark`, `mover`. An unknown name is refused (`unknown wash "<name>"`), a value out of range too (`washes.<name> must be an alpha from 0 to 1`). |

A scheme gives grounds and text. Polestar's status and subject colours are
drawn for night grounds and are the same in every dark scheme, so a quest
reads the same gold everywhere; a **light** scheme (dark text on parchment)
gives its own, dark enough for its grounds. The player's own ground colour,
panel and sidebar colours, brightness, accent and window border still apply
on top.

```lua
local ADDON = ...
local Theme = Polestar.Theme
-- A full scheme spec. Dusk's values stand in for the optional tokens left out.
local ok, message = Theme.RegisterScheme("ref-tide", {
	api = 2, name = "Tide", addon = ADDON, author = "You", version = "1.0",
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
| `tokens` | table of token -> colour | Any [token](#tokens), laid over the base's palette (over the scheme, on `polestar`). Unknown names are refused. |
| `font` | `"game"`, `"inter"`, `"fira"`, `"opensans"`, or `{ regular =, medium? =, semibold? = }` | The face every Polestar string takes while the player's font setting is "The skin's font" (the default). The table form takes full paths (`"Interface\\AddOns\\MySkin\\Fonts\\X.ttf"`); `medium` defaults to `regular`, `semibold` to `medium`. Chinese and Korean clients always use the game's font. Default: the base's (`fira` on Halo, `game` elsewhere). |
| `fontSizes` | table of role -> number (6-40) | A [font role](#font-roles)'s size in points, before the player's text size scales it. Unknown role: `unknown fontSizes "<role>"`; out of range: `fontSizes.<role> must be a number from 6 to 40`. |
| `textShadow` | `{ x, y, alpha }` or `false` | The shadow under every string: offset in units, black at `alpha`. `false` means none. All three numbers are required. The player's own text-shadow setting (soft, hard, none) wins. Default: the base's (Halo `{ 0, -1, 0.9 }`, the game looks `{ 1, -1, 1 }`, Polestar a soft `shade`-coloured 1,-1). |
| `icons` | table of glyph name -> glyph name or path | Polestar's glyphs by name (the files in `addon/Polestar/Media/UI`: `bug`, `close`, `gear`, `search`, `icon-goto`, `icon-accept`, `icon-turnin`, `icon-kill`, `chevron-down`...) drawn as another glyph or your own texture (a path holding `\` or `/`). Values must be non-empty strings. Applies to glyphs drawn after the change; Polestar redraws its windows' glyphs when the skin changes. The game looks map `bug -> flag` and `icon-goto -> house` already. |
| `media` | `{ band?, bandStars?, medallion?, dart?, dartEdge?, pinFill?, pinRim? }` | Paths to your own textures. `band`: the header band's sky mask, `bandStars`: its stars, both 1024x128, drawn at 1:1 from the top left and tinted with `sky` and `star`. `medallion`: the disc under map pin glyphs, used while the player's map icons follow the skin. `dart`, `dartEdge`: the arrow's dart and its edge on the `halo` and `hearth` arrow designs (128x128, pointing up; the dart is tinted with the arrow's colour). `pinFill`, `pinRim`: the disc and the rim of Polestar's own map pin (64x64 masks, white where they show, tinted with the pin's fill and rim colours). Unknown keys are refused. Paths are not checked: a wrong one shows as a blank or green texture in game. |
| `arrow` | `"3d"`, `"flat"`, `"halo"`, `"hearth"` | Which of Polestar's arrow designs a player gets while their arrow style is "Skin" (the default). Default: the base's (`3d` for Polestar, `halo` for Halo, `hearth` for the rest). |
| `mapIcons` | `"polestar"`, `"halo"`, `"hearth"` | Which map icon design those players get. Same defaults. |
| `shadow` | `{ size?, drop?, alpha?, color? }` or `false` | The drop shadow under your windows ([Shadow and art tint](#shadow-and-art-tint)). |
| `artTint` | `{ tint?, brightness?, desaturate? }` | A tint over the game art of a game look ([Shadow and art tint](#shadow-and-art-tint)). |
| `variants`, `defaultVariant` | a list of variants, a variant id | One design in several versions, picked under the skin's card ([Variants](#variants)). |
| `resolve` | function | Tokens and a font answered from the player's context: zone, faction, class ([The resolver](#the-resolver)). |
| `preset` | table of setting path -> value | Settings the skin recommends, applied only when the player asks ([Presets](#presets)). |
| `paint` | table of surface -> function | [Painters](#surfaces-painters). Unknown surface: `unknown paint "<name>"`; not a function: `paint.<name> has the wrong type`. |
| `hooks` | table of hook name -> function | [Hooks](#surfaces-hooks): the arrow, the map pins, the guide window's parts, the cards, the toasts and the buttons. Unknown hook: `unknown hooks "<name>"`. |
| `onApply`, `onLeave` | functions | [Events](#events). |

Everything is optional except `name` and `addon`: `RegisterSkin("x", { name
= "X", addon = ADDON })` is a valid skin identical to Polestar's own look.

```lua
local ADDON = ...
local Theme = Polestar.Theme
-- Every skin field at once, on the Halo look.
local ok, message = Theme.RegisterSkin("ref-everything", {
	api = 2, name = "Everything", addon = ADDON, author = "You", version = "1.0",
	desc = "Halo with warmer text, Open Sans and a thicker edge.",
	base = "halo",
	tokens = { text = "#fff4e0", textDim = "#d8c8a8", accent = "#ffb347", border = "#ffffff26", glow = "#ffd9a0" },
	font = "opensans",
	fontSizes = { hero = 22, goal = 15 },
	textShadow = { 0, -1, 0.8 },
	icons = { bug = "flag" },
	media = { medallion = "Interface\\AddOns\\" .. ADDON .. "\\medallion.tga" },
	arrow = "flat",
	mapIcons = "polestar",
	shadow = { size = 16, alpha = 0.5 },
	artTint = { desaturate = 0.3 },          -- nothing to tint on Halo; a variant on a game look uses it
	variants = {
		{ id = "warm", name = "Warm" },
		{ id = "night", name = "Night", desc = "On WoW Forever's art, dimmed.", base = "forever",
			artTint = { tint = { 0.8, 0.8, 0.95 }, brightness = -0.3 } },
	},
	defaultVariant = "warm",
	resolve = function(ctx)
		if ctx.faction == "Horde" then return { accent = "#ff7a4d" } end
	end,
	preset = { ["ui.fontOutline"] = "outline" },
	paint = {
		window = function(frame, base, kit)
			base(frame)
			if frame.psBare then return end
			local r, g, b = Theme.Accent()
			kit.border(frame, r, g, b, 0.6, nil, 2)
		end,
	},
	hooks = {
		arrow = function(frame, style, parts) end,
		pin = function(pin, parts, kind) end,
	},
	onApply = function(id) end,
	onLeave = function(id) end,
	strict = false,
})
assert(ok, message)
```

## Variants

One design in several versions: a skin's `variants` list them, and the
player picks one under the skin's card on the Theme page (one card per
variant, each drawn in its own look). The pick is kept per skin, in
`ui.skinVariants.<skin id>`, through a switch to another skin and back.

| Field | |
|---|---|
| `variants` | A list (at least one) of `{ id, name, desc?, ... }`: `id` a word like a skin id (unique in this skin), `name` 1-40 characters, `desc` up to 200, shown on its card. |
| `defaultVariant` | The id of the variant a player gets before picking one. Default: the first. Only with `variants`. |

A variant changes what it names and keeps the rest of the skin:

- `tokens` and `media` are laid **over** the skin's own;
- `base`, `scheme`, `arrow`, `preset`, `artTint` and `shadow` **replace**
  the skin's (a variant may be drawn from another base: `scheme` then goes
  with `base = "polestar"` as for a skin).

Each variant that changes the base, scheme or tokens is held to the
[legibility rules](#legibility-rules) on the look it is drawn from; a
correction is noted in the message as `variants[<n>]: ...`, and with
`strict` it refuses the spec. A pick the skin no longer has (an update
removed it) draws the default variant. `SkinVariants(id)` lists them,
`SkinVariant(id)` says which is in use, `DrawSkinCard(frame, id, variant)`
draws one, and the resolver hears it as `ctx.variant`.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("ref-dusk-dawn", {
	api = 2, name = "Dusk and dawn", addon = ADDON,
	tokens = { accent = "#ffb36b" },
	variants = {
		{ id = "dusk", name = "Dusk", desc = "Warm light." },
		{ id = "dawn", name = "Dawn", desc = "Cool light.", tokens = { accent = "#8fc8ff" } },
		{ id = "game", name = "In the game's frame", base = "classic" },
	},
	defaultVariant = "dusk",
}))
assert(#Theme.SkinVariants("ref-dusk-dawn") == 3)
Polestar.Set("ui.skin", "ref-dusk-dawn")
assert(Theme.SkinVariant("ref-dusk-dawn") == "dusk" and Theme.SkinKey() == "polestar")
Polestar.Set("ui.skinVariants.ref-dusk-dawn", "game")
assert(Theme.SkinKey() == "classic" and Theme.GameSkin())
Polestar.Set("ui.skin", "polestar")
```

## The resolver

A skin may answer some of its tokens, and its font, from where the player
is and who they play, instead of fixing them in the spec: `resolve =
function(ctx) return tokens, font end`.

- **When it is asked**: every time the palette is built (each repaint: a
  setting, the skin or its variant changed), and again on a loading screen
  or a new zone, when Polestar repaints only if the answer changed (a skin
  keyed to the continent repaints on a new continent, not at every zone
  border).
- **`ctx`**: `zone` and `continent` (the game's map ids, `uiMapID`, of the
  player's zone and its continent), `continentName`, `faction`
  (`"Alliance"` or `"Horde"`), `class` (the client's class file name,
  `"WARRIOR"`...), `classColor` (`{ r, g, b }`, 0-1), `variant` (the skin's
  variant in use, or nil), and `elvui` (the ElvUI addon's engine table when
  that addon is loaded, else nil, for a skin that follows its colours). A
  field the client cannot say yet is nil.
- **`tokens`**: a table of token -> colour as in the spec (any [token](#tokens)),
  laid over the skin's and its variant's tokens; nil for none.
- **`font`**: as the spec's `font` (`"fira"`, or a table of files); nil keeps
  the skin's.
- A resolver that raises, or answers a token or font a spec could not give,
  turns the skin off for the session like a painter's error
  ([Run-time errors](#run-time-errors)); the error reads `resolve: <why>`.
- Its answer is not known at registration, so it is not measured there:
  give grounds and text that read. On the `polestar` base the run-time
  guard still moves the grounds when the text would not read.

Keep it cheap and answer from `ctx` alone: it runs on every repaint.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("ref-waymark", {
	api = 2, name = "Waymark", addon = ADDON,
	desc = "A cooler accent in the Eastern Kingdoms, your class colour on the arrow's light.",
	resolve = function(ctx)
		local t = { accent = ctx.continentName == "Eastern Kingdoms" and "#8fc8ff" or "#ffc46b" }
		if ctx.classColor then t.glow = ctx.classColor end
		return t
	end,
}))
```

## Shadow and art tint

**`shadow`**: the drop shadow under the skin's windows (every surface
painted as `window`: the settings, the guide window, the toasts).

| Field | | Default |
|---|---|---|
| `size` | how far the shadow spreads, 0-64 units | the house's |
| `drop` | how far down it falls, -32 to 32 units | the house's |
| `alpha` | its strength, 0-1 | 0.6 |
| `color` | a colour or a token's name | the `shadow` token |

`shadow = false` draws none. The player's own shadow setting (on or off, and
its strength) still applies, and a transparent window has no shadow.
Unknown fields are refused (`unknown field "<name>" in shadow`), as are
numbers out of range (`shadow.size must be a number from 0 to 64`).

**`artTint`**: a tint over the game art a game look draws (the window art,
plates and red buttons of `hearth`, `forever`, `blizzard` and `classic`).

| Field | | Default |
|---|---|---|
| `tint` | a colour or a token's name, multiplied into the art | white (no tint) |
| `brightness` | -1 (darker) to 1 (brighter) | 0 |
| `desaturate` | 0 (as drawn) to 1 (grey) | 0 |

It applies while the skin is drawn from a game look (its base, or its
variant's); on `polestar` and `halo` there is no game art and it does
nothing. It reaches the art the base's painters draw and every piece the
game looks draw through `Theme.TintArt`, and goes with the skin.

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

### Status and subject colours

Held to 4.5:1 on every ground but `sky`. The same in every dark scheme; a
skin may recolour them, and a light scheme gives its own.

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
| `accentLine` | the line under dropdowns | the accent @0.35 | `#ffd100@0.35` | `#9a7a34@0.60` | `#ae9d81@0.50` / `#ffd100@0.45` / `#969696@0.60` |
| `padSelect` | the gamepad selection | the accent @0.12 | `#ffd100@0.12` | `#ffd100@0.14` | same |
| `chipAccent` | accent-tinted chips | the accent @0.16 | `#ffd100@0.16` | `#ffd100@0.16` | same |
| `inputBg` | edit box grounds | `shade` @0.35 | `#000000@0.35` | `#000000` | same |
| `closeFill` | the guide window's close square (shown by a [`guideTitle`](#the-guide-window) hook) | `danger` | `danger` | `danger` | `danger` |
| `closeEdge` | the close square's edge | `border` | `border` | `border` | `border` |
| `closeGlyph` | the close square's cross | `text` | `text` | `text` | `text` |
| `windowBorder` | the window border, on every base | the player's border colour, else the accent when they chose that (`ui.borderAccent`), else the skin's `windowBorder`, else `border` | same | same, with `windowEdge` before `border` | same, with `windowEdge` before `border` |

On the Polestar base, `accentLine`, `padSelect`, `chipAccent` and `inputBg`
follow the accent (and `shade`) at run time unless the skin gives them.

### The arrow, the pins and a second accent (skins only)

Polestar's own frames do not read `accent2`; the arrow and the pins read the
other three only when the skin gives them (`Theme.SkinToken`), and keep their
own colours otherwise.

| Token | Where | Default |
|---|---|---|
| `accent2` | a second accent for a skin's own pieces (a duotone skin: Moonlit's moonlight), read with `Theme.Color("accent2")` or the kit's `color` options | the accent in use |
| `glow` | the arrow's light: the flat arrow's glow, the halo behind the arrival ring, a travel instruction's sign | the arrow's own colour |
| `pinRing` | the rim of Polestar's map pins and the tint of the map marks' medallions, where neither the pin nor the player's medallion colour gives one | none (the art as drawn) |
| `pinFill` | the fill of Polestar's map pins where the pin has no colour of its own, and the numbered pins of the steps ahead while their colour setting is on its default | the accent |

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
colours, else accent and success), `arrowGlow` (the skin's `glow`, else the
arrival colour), `scheme`, `skin`, `skinId`.

```lua
local ADDON = ...
local Theme = Polestar.Theme
-- Recolour only: the house frames, warmer subjects. Reads every token back.
assert(Theme.RegisterSkin("ref-tokens", {
	api = 2, name = "Tokens", addon = ADDON,
	tokens = { quest = "#ffe08a", npc = "#9fd4ff", success = "#7fe0a0", warning = "#ffc266", title = "#fff1c7",
		accent2 = "#9fd4ff", pinFill = "#ffe08a" },
}))
local pal = Theme.PaletteFor("ref-tokens")
assert(pal.quest[1] == 1 and pal.title[4] == 1 and pal.accent2[3] == 1)
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
	api = 2, name = "Type", addon = ADDON,
	font = { regular = "Interface\\AddOns\\" .. ADDON .. "\\Fonts\\Mine-Regular.ttf",
		semibold = "Interface\\AddOns\\" .. ADDON .. "\\Fonts\\Mine-Bold.ttf" }, -- medium falls back to regular
	fontSizes = { goal = 15, display = 20 },
}))
local ok, why = Theme.RegisterSkin("ref-type-bad", { name = "Bad", addon = ADDON, fontSizes = { goal = 50 } })
assert(not ok and why:find("fontSizes.goal must be a number from 6 to 40", 1, true), why)
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

After a `window` painter, Polestar draws the skin's [`shadow`](#shadow-and-art-tint)
(when it has one), and after any painter on a game look, its `artTint`.

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
	api = 2, name = "Paint", addon = ADDON,
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

`kit` (and `Polestar.Theme.SkinKit`). A colour option of the kit (`color`,
`tint`) takes a token's name or `{ r, g, b[, a] }`.

| Function | Returns | What it does |
|---|---|---|
| `kit.fill(frame, layer?, sub?)` | texture | The frame's ground: one white texture over the whole frame (created on `BACKGROUND` at sub-level -7 the first time, with `layer`/`sub` if given), shown. Tint it with `SetVertexColor`. There is one per frame: the base painters use the same one. |
| `kit.gradient(frame, from, to, layer?, sub?, orient?)` | texture | That ground as a gradient; `from` and `to` are `{ r, g, b, a }`: top and bottom, or left and right with `orient = "HORIZONTAL"`. Falls back to a flat `from` on a client without gradients. |
| `kit.border(frame, r, g, b, a, layer?, size?)` | | A pixel-exact border around the frame: four edge textures, `size` physical pixels thick (default 1), drawn outward so the frame's children never cover it. One border per frame: a second call retints and resizes it. |
| `kit.hideBorder(frame)` | | Hides that border. |
| `kit.hoverWash(frame)` | texture | A `HIGHLIGHT`-layer wash over the frame, tinted with `Theme.Wash("hover")`, shown by the client while the cursor is over it. |
| `kit.store(frame)` | table | Your skin's own table on the frame, for your textures and frames. Each skin gets its own store on a frame, also on a frame a hook hands you (one Polestar does not paint with `Theme.Skin`). Polestar hides everything in it (recursively: tables of textures too) when another skin paints the frame or the skin in use changes; your hooks show their pieces again when they run. |
| `kit.bare(frame)` | | Hides the ground, border, drop shadow, veil, nine-slices and everything in `kit.store(frame)`: what a `psBare` window should look like. |
| `kit.color(c, default?)` | `r, g, b, a` | A kit colour as numbers: a token's name (as resolved now) or `{ r, g, b[, a] }`; else `default`; else white. |
| `kit.glow(frame, opts?)` | texture | A soft light (Polestar's `glow` texture, additive) centred on a point of the frame, kept in the frame's store under `"glow:" .. (opts.key or opts.point or "CENTER")`. `opts`: `key`, `point` (default `"CENTER"`), `offset` (`{ x, y }`), `size` (a number or `{ w, h }`, default 96), `color` (default `"accent"`), `layer` (default `"BACKGROUND"`), `sub` (default -5), `blend` (default `"ADD"`). Shown; call it again on every paint. |
| `kit.gameArt(frame, opts)` | texture | One of the client's own pictures (a loading screen, journal art) laid behind the frame's content, cropped to cover the frame, desaturated, tinted and faded; laid out again when the frame resizes. `opts.file` (a path or a file id) is required. Optional: `key` (default `"art"`), `layer`/`sub` (`"BACKGROUND"`, -6), `crop` (`"stretch"` stretches instead of cropping), `aspect` (the picture's width / height, default 4/3), `focus` (0-1: which part stays when the top and bottom are cropped, default 0.5), `coords` (`{ left, right, top, bottom }` of the file), `width`/`height` (a fixed size instead of the frame's), `anchors` (a list of `SetPoint` arguments), `tint` (default white), `alpha` (at most 0.35, default 0.2), `fade` (`"bottom"` (default), `"top"`, `"both"`, `"left"`, `"right"`, `"none"`), `desaturate` (0-1, default 0.7). A bad `file` or `fade` raises. |
| `kit.crossfade(texture, file, seconds?)` | | Changes the picture of a `kit.gameArt` texture to `file`, fading over `seconds` (0.6 by default); at once while hidden or when the player asked for less motion. On another texture it just sets the file. |
| `kit.tintArt(frame, opts)` | | Tints the game art the base look drew on the frame (its nine-slices, plates and red buttons): `opts` as [`artTint`](#shadow-and-art-tint). What the base sets again on its next paint is tinted again; another skin puts it all back. Polestar calls it with the skin's own `artTint` after each painter. |

```lua
local ADDON = ...
local Theme = Polestar.Theme
local kit = Theme.SkinKit
assert(type(kit.fill) == "function" and type(kit.gradient) == "function" and type(kit.border) == "function")
assert(type(kit.hideBorder) == "function" and type(kit.hoverWash) == "function")
assert(type(kit.store) == "function" and type(kit.bare) == "function")
assert(type(kit.glow) == "function" and type(kit.gameArt) == "function" and type(kit.crossfade) == "function")
assert(type(kit.tintArt) == "function" and type(kit.color) == "function")
assert(Theme.RegisterSkin("ref-kit", {
	api = 2, name = "Kit", addon = ADDON,
	paint = {
		panel = function(frame, base, kit)
			if frame.psBare then return kit.bare(frame) end
			local r, g, b, a = Theme.Color("panel")
			local sr, sg, sb = kit.color("shade")
			kit.gradient(frame, { r, g, b, a }, { (r + sr) / 2, (g + sg) / 2, (b + sb) / 2, a })
			kit.border(frame, Theme.Wash("border"))
		end,
		-- A sidebar lit from its left edge, and a glow in its corner.
		sidebar = function(frame, base, kit)
			base(frame)
			local r, g, b = kit.color("accent")
			kit.gradient(frame, { r, g, b, 0.12 }, { r, g, b, 0 }, nil, nil, "HORIZONTAL")
			kit.glow(frame, { point = "TOPLEFT", size = 64, color = "accent2" })
		end,
	},
}))
```

## Surfaces: hooks

The art modules draw their own frames and then hand them to your hook, if
the skin in use has one: the arrow, the map pins, the guide window's parts,
the cards and toasts, and the buttons Polestar puts on the screen. A hook may
add to what is drawn (keep what you create in `kit.store(frame)`, created
once) and restyle the parts it is handed; Polestar's own arrow and map icon
designs are chosen with `arrow` and `mapIcons` in the spec, which is simpler
and usually enough.

Every hook runs after Polestar's own look is on, under the same `pcall` as
the painters, and each has its capability `surfaces.<name>`. With no skin
hooking a point, Polestar costs one lookup there. Hooks run often (one per
pin per restyle, one per goal row per render): keep them cheap and create
nothing on every call. The parts a hook is handed are named by the API and
keep their names; anything else you reach inside the frames is Polestar's
own ([versioning](versioning.md#what-is-not-covered)).

### The arrow and the map pins

| Hook | Signature | When | What you get |
|---|---|---|---|
| `arrow` | `function(frame, style, parts)` | after the arrow repaints its look: a theme or skin change, an arrow setting changed | `frame`: the arrow (`PolestarNavArrow`). `style`: `"3d"`, `"flat"`, `"halo"` or `"hearth"`. `parts` (`arrow.parts`): `dial` (the frame the arrow turns on), `body` and `glow` (the flat arrow and its light), `dart` and `dartEdge` (the Halo and Hearth arrow and its edge), `ring` (the arrival ring), `halo` (the glow behind it), `distance`, `label`, `eta`, `timer` (the texts), `travel` (the travel leg's icon). Which parts show depends on the style: restyle them in the hook, show and hide your own. |
| `pin` | `function(pin, parts, kind)` | after a map or minimap pin is built or restyled (every theme change restyles them all) | `pin`: the pin's frame. `kind`: `"pin"` (Polestar's pin, an icon pin, a numbered step pin) or `"mark"` (a map mark on its medallion). `parts` (`pin.parts`): `fill` and `rim` (Polestar's pin), `icon` (an icon pin's glyph), `backdrop` (the dark disc under an icon), `ring` (a ring around an icon), `glow` (its light), `edge` (the pointer of a minimap pin held at the minimap's edge), `text` (a step pin's number), `medallion` and `dashed` (a map mark's disc and dashed ring). A pin shows only the parts its kind uses. |

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("ref-hooks", {
	api = 2, name = "Hooks", addon = ADDON, arrow = "halo", mapIcons = "halo",
	hooks = {
		-- A soft accent light behind the arrow's dial, made once by the kit.
		arrow = function(frame, style, parts)
			Theme.SkinKit.glow(parts.dial, { key = "halo", size = 96, color = "accent", sub = -7 })
			parts.distance:SetShadowColor(0, 0, 0, 1)
		end,
		-- Dim the medallion under each map mark a little.
		pin = function(pin, parts, kind)
			if kind == "mark" then
				local r, g, b, a = parts.medallion:GetVertexColor()
				parts.medallion:SetVertexColor(r, g, b, (a or 1) * 0.9)
			end
		end,
	},
}))
```

### The guide window

`Theme.GuideParts()` hands over the guide window's frames, to place things
by and to restyle (capability `guideParts`): `window`, `strip` (the tabs),
`nav` (the step bar), `body`, `card` (the step), `person` (its header),
`goals` (the scroll of goal rows), `rows` (the goal rows, pooled), `tip`,
`after` ("Then:"), `along`, `upnext`, `empty` (no guide), `band` (the house
band), `banner`, `foot` (the progress), `line` (its bar), `here` (While
you're here). One table, the same every time; nil before the window is
built.

| Hook | Signature | When | What you get |
|---|---|---|---|
| `guideTitle` | `function(nav, parts)` | after the guide window's style is applied (a skin, theme or window style change), not in the transparent window; the Looks page's preview calls it too, with its own parts | `nav`: the navigator frame (the row with the step count and the menu). `parts`, each in the base's state when the hook runs: `bar` (the title bar texture, a `sky` to `skyBottom` gradient, shown on Hearth), `close` (a close square in `closeFill`, `closeEdge` and `closeGlyph` that hides the window, hidden), `rule` (the line under the navigator), `band` (the house band behind the bars, shown on the Polestar base), `menuRight` (the menu button's inset from the right edge, `8`). Show or hide parts and set `parts.menuRight`: `26` leaves room for the close square. With the bar shown, the rule takes `titleLine`. |
| `guideRow` | `function(row, goal, info)` | after Polestar painted a goal row, at every render and repaint, for each row shown | `row`: the row. Rows are pooled: the same row shows other goals later, so set every piece you use each time. `goal`: the goal it shows (fields below). `info`: `current` (the goal the arrow is on), `done`, `skipped` (booleans; the same table each time). |
| `guideLayout` | `function(parts, width, y)` -> height | at every layout of the window (a step, a size or a setting changed), after Polestar placed its parts | `parts`: `GuideParts()`. `width`: the window's width. `y`: how far down the body Polestar's parts reach. Place your own frames from `y` down and answer the height they take (a number; nothing or 0 for none): the window grows by it. |
| `guideRender` | `function(view, parts)` | after every render of the window | `view`: the step on screen (`index`, `title`, `note`, `status`, `goals`: the goals below), or nil when the window shows no step (no guide open, a guide finished). `parts`: `GuideParts()`. |
| `guideProgress` | `function(foot, frac)` | after the progress is painted (every render) | `foot`: the progress part (its bar is `GuideParts().line`). `frac`: how much of the guide is done, 0-1. |
| `guideAnchor` | `function()` -> frame | each time the heads-up card is placed on the window's edge | Answer a frame of yours (your own cards above the window) and the heads-up card sits on its edge instead of the window's; nil keeps the window's. Not asked while the player gives the card a spot of its own. |
| `guideTab` | `function(button, parts, active)` | after Polestar painted a tab of the strip, at every render of the strip and repaint | `button`: the tab. `parts`: `selected` (the active tab's wash), `bar` (its line), `label`, `range` (the guide's levels), `icon`, `close`. `active`: whether it is the tab in view. |
| `guidePlace` | `function(name, frame, width, height)` -> true | at every layout, for each part about to be placed, laid out and shown | `name`: `"tip"` (the step's tip, in the card), `"banner"`, `"here"` (While you're here), `"after"` ("Then:"), `"along"`, `"upnext"`, `"party"`, `"xp"`. `frame`: that part; `width`: the window's; `height`: the part's. Answer `true` and the window leaves the part out, its height too: place it yourself (`SetParent`, `SetPoint`), on a card of yours above the window for example. Answer anything else and the window places it; a part you moved under a frame of yours goes back under its own then. |
| `guideMenu` | `function(items, button)` | each time the window's menu opens (the list is made anew every time) | `items`: the entries, `{ text, icon?, checked?, disabled?, onClick?, tip? }` or `{ separator = true }` (`icon` a glyph name); add, remove or reorder them. `button`: the menu button. |

The goal a `guideRow` hook gets (and each of `view.goals`) is the Engine's
step view of it. The fields a dense row reads:

| Field | |
|---|---|
| `t` | the goal's kind: `"accept"`, `"turnin"`, `"kill"`, `"collect"`, `"goto"`, `"talk"`, `"use"`... |
| `status` | `"done"`, `"active"`, `"pending"`, `"skipped"` or `"na"` |
| `text`, `verb`, `subject`, `subjectKind`, `detail` | the row's words: the plain line, its verb, what it names and its kind (`"quest"`, `"npc"`, `"item"`, `"place"`, `"object"`...), and the line under it (`"for Kobold Camp Cleanup"`) or nil |
| `progress` | `{ cur, max }` for a count (`3` of `10`), or nil |
| `quest`, `npc`, `npcName`, `item` | ids (and the person's name) |
| `map`, `x`, `y` | where it is: the zone's map id and its 0-100 coordinates, or nil |
| `lvl` | where the step names spots to choose from, the level range of the one chosen, or nil |
| `optional`, `manual` | an optional goal; one the player ticks by hand |
| `index` | its place in the step |

```lua
local ADDON = ...
local Theme = Polestar.Theme
local kit = Theme.SkinKit
assert(Theme.RegisterSkin("ref-dense", {
	api = 2, name = "Dense", addon = ADDON,
	desc = "A count on each goal's row, a line under the window.",
	hooks = {
		-- The count at the right of each row, made once per row, set every time.
		guideRow = function(row, goal, info)
			local own = kit.store(row)
			if not own.count then
				own.count = row:CreateFontString(nil, "OVERLAY")
				Theme.Font(own.count, "small")
				own.count:SetPoint("RIGHT", row, "RIGHT", -6, 0)
			end
			local p = goal.progress
			own.count:SetText(p and (p.cur .. "/" .. p.max) or "")
			own.count:SetTextColor(Theme.Color(info.done and "textMuted" or "textDim"))
			own.count:Show()
		end,
		-- Six units of room under the window's parts, a rule across them.
		guideLayout = function(parts, width, y)
			local own = kit.store(parts.body)
			if not own.rule then
				own.rule = parts.body:CreateTexture(nil, "ARTWORK")
				own.rule:SetTexture(Theme.Media("white"))
			end
			own.rule:ClearAllPoints()
			own.rule:SetPoint("TOPLEFT", parts.body, "TOPLEFT", 12, -(y + 3))
			own.rule:SetSize(math.max(1, width - 24), Theme.Pixel(parts.body))
			own.rule:SetVertexColor(Theme.Wash("divider"))
			own.rule:Show()
			return 6
		end,
		-- The rule only under a step.
		guideRender = function(view, parts)
			local own = kit.store(parts.body)
			if own.rule then own.rule:SetShown(view ~= nil) end
		end,
	},
}))
```

### Cards, toasts and buttons

| Hook | Signature | When | What you get |
|---|---|---|---|
| `card` | `function(frame, kind, parts)` | after the card's look is applied: it shows, a setting or the skin changed | `kind`: `"headsup"` (the heads-up card above or below the guide window: a class quest or a dungeon ready) or `"classcard"` (the class quest card in the guide window). `parts`: `titles` and `bodies` (lists of the font strings Polestar sizes as titles and bodies), `accents` (a list of the regions it colours in the accent; may be empty). |
| `toast` | `function(frame, kind, parts)` | the same, for the toasts | `kind`: `"rare"` (the rare alert), `"transport"` (the heads-up before a boat, zeppelin or tram comes in), `"whilehere"` (While you're here, while the guide window is hidden). `parts` as the cards'. |
| `actionButton` | `function(button, kind, parts, hover)` | after Polestar painted the button, and as the mouse enters and leaves it | `kind`: `"item"`, `"hearth"`, `"target"`, `"rare"`, `"bag"` (the action buttons), `"travel"` (the arrow's travel button), `"launcher"` (the floating button). `parts`: `ground`, `icon`, `highlight`, and where the button has them `cooldown`, `count`, `hotkey`, `label`, `badge`, `glow`. `hover`: the mouse is on it. |

```lua
local ADDON = ...
local Theme = Polestar.Theme
local kit = Theme.SkinKit
-- A line in the accent along the top of every card, toast and button.
local function topLine(frame, alpha)
	local own = kit.store(frame)
	if not own.top then
		own.top = frame:CreateTexture(nil, "OVERLAY")
		own.top:SetTexture(Theme.Media("white"))
		own.top:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		own.top:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	end
	own.top:SetHeight(Theme.Pixel(frame))
	local r, g, b = kit.color("accent")
	own.top:SetVertexColor(r, g, b, alpha)
	own.top:Show()
end
assert(Theme.RegisterSkin("ref-lines", {
	api = 2, name = "Lines", addon = ADDON,
	hooks = {
		card = function(frame, kind, parts) topLine(frame, 0.8) end,
		toast = function(frame, kind, parts) topLine(frame, kind == "rare" and 1 or 0.6) end,
		actionButton = function(button, kind, parts, hover) topLine(button, hover and 1 or 0.4) end,
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
anchor elsewhere), not for Polestar's frames, which painters and hooks
cover. A change of variant is not an event: the skin stays in use, and
everything repaints.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local shown = false
assert(Theme.RegisterSkin("ref-events", {
	api = 2, name = "Events", addon = ADDON,
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
or skin (and each of its variants) is measured against the same rule at
registration:

- `text` 7:1, `textDim` and `textMuted` 4.5:1, on each of the six grounds
  (`bg`, `panel`, `panelAlt`, `sidebar`, `footer`, `sky`).
- Every status and subject colour (`quest`, `npc`, `dungeon`...) 4.5:1 on
  each ground but `sky`. A scheme that leaves these to Polestar keeps its
  night colours, so a very light ground can fail on, say, `dungeon on
  panelAlt`: the message then names the ground (`panelAlt is too light for
  Polestar's subject colours (dungeon reads 1.1:1, needs 4.5:1)`), and the
  fix is a darker ground, or subject colours of your own.
- A translucent ground is measured as it is seen: `bg` over black, the other
  grounds over `bg`. Halo's `panelAlt` of white at 6 % counts as near-black.

Outcomes:

| Case | `strict` off (default) | `strict = true` |
|---|---|---|
| everything reads | `true, nil` | `true, nil` |
| grounds too close to the text | the six grounds are moved **together** (OKLab lightness, alpha kept) by the least that makes every text read: darkened under light text, **lightened** under dark text (a light palette, `Theme.IsLightPalette`); `true, "textMuted on panelAlt reads 3.9:1, needs 4.5:1; the grounds were darkened (-0.12) until the text reads"`. The stored palette is the corrected one. | `false, "textMuted on panelAlt reads 3.9:1, needs 4.5:1"` |
| text that cannot read even at the far end | `false, "text on bg reads 2.1:1, needs 7:1 even with the grounds at their darkest"` (or "lightest") | the same |

A variant's note or refusal starts with `variants[<n>]: `.

At run time Polestar keeps the grounds of a `polestar`-based skin legible
when the player's own ground colour or brightness would drop the text below
the floor (the other bases have no such controls), moving them the way the
palette is drawn: a light palette is lifted, never sent down to its own dark
text. A skin's own `text` tokens on the Polestar base go through the same
guard.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local grey = { bg = "#8a8a8a", panel = "#8a8a8a", panelAlt = "#909090", sidebar = "#858585", footer = "#858585", sky = "#959595",
	text = "#ffffff", textDim = "#eeeeee", textMuted = "#dddddd" }
local ok, note = Theme.RegisterScheme("ref-light", { api = 2, name = "Light", addon = ADDON, tokens = grey })
assert(ok == true and note:find("darkened"), note)
assert(Theme.Legibility(Theme.PaletteFor("polestar")) >= 1)
local refused, why = Theme.RegisterScheme("ref-light-strict", { api = 2, name = "Light", addon = ADDON, tokens = grey, strict = true })
assert(refused == false and why:find("needs") and not why:find("darkened"), why)
```

## Validation and error messages

A refused spec registers nothing and returns `false, reason`. Refusals and
notes are also written to Polestar's debug log (`/polestar debug` toggles
debug output). The checks run in this order; the first failure is the one
you see:

| Check | Message |
|---|---|
| the checks are there | `the Skin API's checks did not load (is the Polestar_SkinAPI folder installed and enabled?)` |
| spec is a table | `the spec must be a table` |
| every field is known | `unknown field "<name>"` |
| id shape | `the id must be a word of letters, digits, _ or - (32 at most), starting with a letter` |
| id free | `the id "<id>" is taken (<addon or Polestar>)` |
| `api` | `api must be a whole number from 1`; `needs Skin API <n>; this Polestar has <m> (update Polestar)` |
| `name` | `name must be a name of 1-40 characters` |
| `addon` | `addon must be your addon's folder name` |
| `author`, `version` | `author must be a string of 40 characters at most` |
| `desc` | `desc must be a string of 200 characters at most` |
| `tokens` | `tokens must be a table`; `unknown token "<name>" in tokens`; `token "<name>" is not a colour (give { r, g, b[, a] } in 0-1 or "#rrggbb")` |
| scheme: required tokens | `tokens.<name> is missing (a scheme gives bg, panel, panelAlt, sidebar, footer, sky, text, textDim, textMuted)` |
| scheme: skin-only tokens | `tokens.<name> belongs to a skin, not a scheme (a scheme gives the grounds, the text ladder and the subject colours)` |
| scheme: `accent` | `accent is not a colour` |
| scheme: `washes` | `washes must be a table`; `unknown wash "<name>"`; `washes.<name> must be an alpha from 0 to 1` |
| skin: `base` | `base must be one of Polestar's skins: polestar, halo, hearth, forever, blizzard, classic` |
| skin: `scheme` | `scheme goes with base "polestar" (the other looks bring their own grounds)`; `scheme "<id>" is not registered (register it first)` |
| skin: `font` | `font must be "game", "inter", "fira", "opensans" or a table of font files`; `a font table needs regular = "Interface\\AddOns\\...\\file.ttf" (medium, semibold optional)`; `font.<weight> must be a file path` |
| skin: `fontSizes` | `fontSizes must be a table`; `unknown fontSizes "<role>"`; `fontSizes.<role> must be a number from 6 to 40` |
| skin: `icons`, `media`, `paint`, `hooks` | `<field> must be a table`; `unknown <field> "<key>"` (not for `icons`, where any glyph name is allowed); `<field>.<key> has the wrong type` |
| skin: `textShadow` | `textShadow must be { x, y, alpha } or false` |
| skin: `arrow` | `arrow must be "3d", "flat", "halo" or "hearth"` |
| skin: `mapIcons` | `mapIcons must be "polestar", "halo" or "hearth"` |
| skin: `preset` | `preset must be a table of setting = value`; `preset is empty`; `preset key "<key>" is not a setting path (like "ui.scale")`; `preset.<path> is not a look setting (a preset changes how Polestar looks, never what it does)`; `preset: Polestar has no setting "<path>"`; `preset.<path> must be false or a colour`; `preset.<path> must be a <type>, like its default`; `preset.<path> holds a nested table` |
| skin: `onApply`, `onLeave`, `resolve` | `<name> must be a function` |
| skin: `shadow` | `shadow must be { size, drop, alpha, color } or false`; `unknown field "<name>" in shadow`; `shadow.size must be a number from 0 to 64`; `shadow.drop must be a number from -32 to 32`; `shadow.alpha must be a number from 0 to 1`; `shadow.color must be a token's name or a colour` |
| skin: `artTint` | `artTint must be { tint, brightness, desaturate }`; `unknown field "<name>" in artTint`; `artTint.tint must be a token's name or a colour`; `artTint.brightness must be a number from -1 to 1`; `artTint.desaturate must be a number from 0 to 1` |
| skin: `variants` | `variants must be a list of { id, name, ... }`; `variants[<n>] must be a table`; `unknown field "<name>" in variants[<n>]`; `variants[<n>].id must be a word of letters, digits, _ or - (32 at most), starting with a letter`; `the variant id "<id>" is given twice`; `variants[<n>].name must be a string of 40 characters at most`; `variants[<n>].desc must be a string of 200 characters at most`; then each of its fields as the skin's, named `variants[<n>].<field>` |
| skin: `defaultVariant` | `defaultVariant goes with variants`; `defaultVariant must be one of the variants' ids` |
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
refused('unknown hooks "minimap"', Theme.RegisterSkin("ref-v8", { name = "X", addon = ADDON, hooks = { minimap = function() end } }))
refused("shadow.alpha must be a number from 0 to 1", Theme.RegisterSkin("ref-v9", { name = "X", addon = ADDON, shadow = { alpha = 2 } }))
refused('the variant id "a" is given twice', Theme.RegisterSkin("ref-v10", { name = "X", addon = ADDON,
	variants = { { id = "a", name = "A" }, { id = "a", name = "B" } } }))
refused("defaultVariant goes with variants", Theme.RegisterSkin("ref-v11", { name = "X", addon = ADDON, defaultVariant = "a" }))
```

## Run-time errors

Every painter, hook, resolver, `onApply` and `onLeave` of a registered skin
runs under `pcall`. On the first error, Polestar:

1. records it once in its error list as `skin <id> (<addon>): <error>`
   (shown by `/polestar report`, and `Theme.SkinInfo(id).failed` holds it;
   a resolver's error starts with `resolve: `);
2. prints one chat line: *"The skin <name> (from <addon>) ran into an error,
   so Polestar's own look stands in until you reload. Its addon may need an
   update."*;
3. turns the skin off **for the session**: `Theme.SkinId()` answers
   `"polestar"`, everything is repainted in Polestar's own look, your
   `onLeave` runs once, and none of your painters, hooks or resolver run
   again;
4. keeps the player's choice: `ui.skin` still names your skin, so after a
   `/reload` with a fixed addon it is back without the player doing anything.

A refused registration is not a run-time error: nothing is registered, the
player sees Polestar's own look, and their saved choice waits. When the
player had chosen that skin, one chat line says so, naming your addon and
the reason ([RegisterSkin](#registerskinid-spec)).

## Capabilities

`Theme.HasCapability(name)` is `true` for each of these in version 2. The
ones marked **2** arrived with version 2 (Polestar 0.3.8); the rest were in
version 1, the API's preview before it.

| Capability | Means |
|---|---|
| `schemes`, `skins` | `RegisterScheme`, `RegisterSkin` |
| `tokens` | `tokens` in both specs |
| `legibility` | the contrast check, with correction and `strict` |
| `lightSchemes` | light palettes lifted instead of darkened; schemes may give the subject colours |
| `fonts`, `fontSizes`, `textShadow` | those skin fields |
| `icons` | the `icons` map |
| `media.band`, `media.bandStars`, `media.medallion` | each `media` key |
| `media.dart` (**2**) | `media.dart` and `media.dartEdge`: the arrow's dart |
| `media.pins` (**2**) | `media.pinFill` and `media.pinRim`: Polestar's map pin |
| `arrow.style`, `mapIcons` | the `arrow` and `mapIcons` fields |
| `events` | `onApply`, `onLeave` |
| `preview` | `DrawSkinCard`, `DrawSchemeCard`, cards in the picker |
| `preset` | `preset`, and the functions that apply and undo it |
| `guideParts` (**2**) | `Theme.GuideParts()` |
| `variants` (**2**) | `variants`, `defaultVariant`, `SkinVariants`, `SkinVariant`, the variant cards |
| `resolve` (**2**) | `resolve` |
| `shadow` (**2**), `artTint` (**2**) | those skin fields |
| `tokens.accent2` (**2**), `tokens.glow` (**2**), `tokens.pins` (**2**) | the tokens `accent2`; `glow`; `pinRing` and `pinFill` |
| `kit.glow`, `kit.gameArt`, `kit.crossfade`, `kit.tintArt`, `kit.color` (**2**) | those kit functions |
| `kit.gradient.horizontal` (**2**) | `kit.gradient`'s `"HORIZONTAL"` |
| `arrow.parts` (**2**), `pin.parts` (**2**) | the parts the `arrow` and `pin` hooks are handed |
| `skins.installed` (**2**) | `## X-Polestar-Skin`, `InstalledSkins`, `LoadSkinAddon`, `LoadInstalledSkins` |
| `theme.functions` (**2**) | the [Theme functions](#other-theme-functions-a-skin-may-use) under the version promise |
| `surfaces.window`, `surfaces.guide`, `surfaces.toast`, `surfaces.panel`, `surfaces.sidebar`, `surfaces.inset`, `surfaces.button`, `surfaces.tile`, `surfaces.dropdown`, `surfaces.editbox`, `surfaces.checkbox`, `surfaces.tab`, `surfaces.close`, `surfaces.scrollbar` | each painter kind |
| `surfaces.arrow`, `surfaces.pin`, `surfaces.guideTitle` | those hooks |
| `surfaces.guideRow`, `surfaces.guideLayout`, `surfaces.guideRender`, `surfaces.guideProgress`, `surfaces.guideAnchor`, `surfaces.guideTab`, `surfaces.guidePlace`, `surfaces.guideMenu`, `surfaces.card`, `surfaces.toast`, `surfaces.actionButton` (**2**) | those hooks |

Note `surfaces.toast` names both the `toast` painter kind and the `toast`
hook: both are in version 2. A later Polestar adds capabilities without
raising `API_VERSION`; test for the one you need and leave the feature out
where it is missing ([versioning](versioning.md)).
