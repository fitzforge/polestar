# Examples and recipes

The example addon, annotated, then recipes you can paste into a skin of your
own. Every block below is complete and was run against Polestar 0.3.7's
Skin API; ids are prefixed so they do not collide with each other or with
the example. In your own addon, replace `local ADDON = ...` with nothing
(it is already the first line of your file) and change the ids.

- [The example addon: Moonlit](#the-example-addon-moonlit)
- [Recipes](#recipes)
  - [Recolour only](#recolour-only)
  - [New fonts](#new-fonts)
  - [A custom header texture and medallion](#a-custom-header-texture-and-medallion)
  - [A custom backing texture for windows](#a-custom-backing-texture-for-windows)
  - [Per-surface tweaks: buttons, edit boxes, tabs](#per-surface-tweaks-buttons-edit-boxes-tabs)
  - [A skin on a game look](#a-skin-on-a-game-look)
  - [Marking the arrow and the pins](#marking-the-arrow-and-the-pins)
  - [A variant switch with your own saved variable](#a-variant-switch-with-your-own-saved-variable)

## The example addon: Moonlit

[`addon/Polestar_Skin_Example`](../../addon/Polestar_Skin_Example) is a
two-file addon: the TOC and `Moonlit.lua`. It registers a scheme and a skin
named Moonlit. In the order the file is written:

**The guard.** Polestar must be loaded (`## Dependencies: Polestar`) and
have a Skin API of version 1 or newer; otherwise the file returns and the
addon does nothing. This is what keeps the addon harmless on Polestar 0.3.6.

```lua
-- not runnable: excerpt of Moonlit.lua
local ADDON = ...
local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and Theme.API_VERSION and Theme.API_VERSION >= 1) then return end
```

**`check`.** Each registration answers `ok, message`. A refusal is printed in
orange with the reason; an accepted spec with a note (grounds darkened) is
printed plainly. Every skin addon should do this: the message is written for
you, not the player.

**The scheme.** Nine required tokens (six grounds, three text colours) in
`#rrggbb` and `#rrggbbaa`, three optional ones (`star`, `scrim`,
`onAccent`), a moonlight `accent` that stands in for Polestar gold when the
player has none of their own, and `washes` making the hairlines a little
stronger on the lighter ground. Every text role reads at its floor on every
ground as given, so the registration answers `true` with no note. Players
can pick Moonlit as a scheme under Polestar's own skin.

**The skin.** `base = "polestar"` (the house frames, band and sizes),
`scheme = "moonlit"` (so the skin always wears its scheme, whatever scheme
the player picked), `font = "fira"`, a 24-point `hero`, and Halo's arrow and
map icons for players who leave those on "Skin".

**One painter.** `paint.window` calls `base(frame)` (the house window:
ground, border, drop shadow), then adds a one-unit line of the accent along
the top edge:

```lua
-- not runnable: excerpt of Moonlit.lua
window = function(frame, base, kit)
	base(frame)
	local own = kit.store(frame)
	if frame.psBare then
		if own.moon then own.moon:Hide() end
		return
	end
	if not own.moon then
		own.moon = frame:CreateTexture(nil, "BORDER")
		own.moon:SetTexture(Theme.Media("white"))
		own.moon:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		own.moon:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
		own.moon:SetHeight(1)
	end
	local r, g, b = Theme.Color("accent")
	own.moon:SetVertexColor(r, g, b, 0.55)
	own.moon:Show()
end,
```

Four things to copy from it: the texture is created once and kept in
`kit.store(frame)` (so Polestar hides it when another skin takes the frame);
it is hidden on a transparent window (`psBare`); the colour is read at paint
time through `Theme.Color`, so the player's own accent colours the line; and
`base(frame)` runs first, so everything the house style does still happens.

To make your own: copy the folder, rename it and its `.toc`, change the ids,
names and colours, and register what you need.

## Recipes

### Recolour only

The smallest useful skin is a scheme: grounds and text, nothing else.
Everything Polestar draws follows.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterScheme("rx-slate", {
	api = 1, name = "Slate", addon = ADDON,
	desc = "Cool grey-blue grounds, a crisp white ladder.",
	tokens = {
		bg = "#1b2027f7", panel = "#20262efa", panelAlt = "#2a313b",
		sidebar = "#151a20", footer = "#171c22", sky = "#2e3745",
		text = "#f6f8fb", textDim = "#c9d0da", textMuted = "#9aa4b2",
	},
	accent = "#8ec5ff",
}))
```

To recolour the **subjects** too (quest gold, NPC blue, the success green),
or any role token, you need a skin: those tokens belong to skins. A skin with
only `tokens` is Polestar's own look recoloured, and it still follows the
player's scheme unless you give it one.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("rx-slate", {
	api = 1, name = "Slate", addon = ADDON,
	desc = "Polestar's frames in Slate, with softer subject colours.",
	base = "polestar", scheme = "rx-slate",
	tokens = {
		quest = "#ffd98a", npc = "#9fd0ff", item = "#d0bdff", place = "#ffc2a3",
		success = "#8fe3b0", warning = "#ffd27a", danger = "#ff9b9b",
		title = "#ffffff", link = "#9fd0ff",
	},
}))
```

### New fonts

Polestar ships `inter`, `fira` and `opensans`; name one, or ship your own
`.ttf` files and give full paths. Sizes are per role, before the player's
text size scales them.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local FONTS = "Interface\\AddOns\\" .. ADDON .. "\\Fonts\\"
assert(Theme.RegisterSkin("rx-serif", {
	api = 1, name = "Serif", addon = ADDON,
	desc = "Polestar set in a book face, larger goals, no text shadow.",
	base = "polestar",
	font = {
		regular = FONTS .. "Book-Regular.ttf",
		medium = FONTS .. "Book-Medium.ttf",   -- optional: defaults to regular
		semibold = FONTS .. "Book-Bold.ttf",   -- optional: defaults to medium
	},
	fontSizes = { goal = 15, body = 14, display = 20, hero = 24 },
	textShadow = false,
}))
```

The player's font setting still wins: your face applies while it is on "The
skin's font" (the default). Chinese and Korean clients always use the game's
font, so a skin never has to ship CJK glyphs. Give the font's licence in your
zip ([publishing](publishing.md#licensing)).

### A custom header texture and medallion

The starlit band across every window header is two 1024x128 textures: a sky
mask tinted with `sky`, and stars tinted with `star`, drawn at 1:1 from the
top left (a header of width w shows the leftmost w pixels). Replace one or
both; the medallion is the disc under map pin glyphs while the player's map
icons follow the skin.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\"
assert(Theme.RegisterSkin("rx-aurora", {
	api = 1, name = "Aurora", addon = ADDON,
	desc = "A northern-lights header and a rune medallion on the map.",
	base = "polestar",
	tokens = { sky = "#1b3a3f", star = "#b8ffe6" },  -- what the band's textures are tinted with
	media = {
		band = MEDIA .. "aurora-band.tga",        -- 1024x128, white where the sky shows
		bandStars = MEDIA .. "aurora-stars.tga",  -- 1024x128, white sparks on transparent
		medallion = MEDIA .. "rune-medallion.tga", -- square, the disc under pin glyphs
	},
	mapIcons = "polestar",
}))
```

Design the mask for tinting: paint it in white and grey on transparency and
let the `sky` token colour it, so the player's brightness and background
settings still make sense. A band that fades to transparent at its bottom
edge sits on any ground.

### A custom backing texture for windows

A painter that keeps the house window (ground, border, shadow) and lays your
own texture over the ground: a paper grain, a vignette, a corner ornament.
The texture lives in `kit.store(frame)` so a skin switch hides it.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local GRAIN = "Interface\\AddOns\\" .. ADDON .. "\\Media\\grain.tga"
assert(Theme.RegisterSkin("rx-parchment", {
	api = 1, name = "Parchment", addon = ADDON,
	desc = "A faint paper grain over every Polestar window.",
	base = "polestar",
	paint = {
		window = function(frame, base, kit)
			base(frame)
			local own = kit.store(frame)
			if frame.psBare then
				if own.grain then own.grain:Hide() end
				return
			end
			if not own.grain then
				-- Just above the ground fill (BACKGROUND -7), under everything else.
				own.grain = frame:CreateTexture(nil, "BACKGROUND", nil, -6)
				own.grain:SetTexture(GRAIN, "REPEAT", "REPEAT")
				own.grain:SetAllPoints(frame)
				if own.grain.SetHorizTile then own.grain:SetHorizTile(true); own.grain:SetVertTile(true) end
			end
			-- Tile at 1:1 whatever the window's size, and fade with the player's opacity.
			local w, h = frame:GetWidth() or 256, frame:GetHeight() or 256
			own.grain:SetTexCoord(0, w / 256, 0, h / 256)
			local alpha = frame.psBgAlpha or Theme.GroundAlpha()
			own.grain:SetVertexColor(1, 1, 1, 0.18 * alpha)
			own.grain:Show()
		end,
	},
}))
```

For the texture to tile, `SetTexture(path, "REPEAT", "REPEAT")` and the
tiling flags are both needed on current clients, and the file's size must be
a power of two (256x256 here). Textures on `BACKGROUND` at sub-level -6 sit
just over the fill Polestar paints at -7 and under every panel and string.

### Per-surface tweaks: buttons, edit boxes, tabs

Replace a kind's painter entirely when the house version is not what you
want. Each painter is small: a fill, a border, a hover wash, read from the
palette. Marks on the frame tell you its state.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("rx-controls", {
	api = 1, name = "Controls", addon = ADDON,
	desc = "Accent-filled text buttons, underlined edit boxes, bar tabs.",
	base = "polestar",
	paint = {
		-- Text buttons (W.Button) get a solid accent fill with dark ink; cards
		-- and rows painted as buttons keep the house ground.
		button = function(frame, base, kit)
			if not frame.psTextButton then return base(frame) end
			local r, g, b = Theme.Accent()
			kit.fill(frame):SetVertexColor(r, g, b, 0.9)
			kit.hideBorder(frame)
			kit.hoverWash(frame):SetVertexColor(1, 1, 1, 0.12)
		end,
		-- Edit boxes: no box, a two-pixel line under the text, lit in the
		-- accent while focused.
		editbox = function(frame, base, kit)
			local sr, sg, sb = Theme.Color("shade")
			kit.fill(frame):SetVertexColor(sr, sg, sb, 0.2)
			kit.hideBorder(frame)
			local own = kit.store(frame)
			if not own.line then
				own.line = frame:CreateTexture(nil, "BORDER")
				own.line:SetTexture(Theme.Media("white"))
				own.line:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
				own.line:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
			end
			own.line:SetHeight(2 * Theme.Pixel(frame))
			if frame.psFocused then
				local r, g, b = Theme.Accent()
				own.line:SetVertexColor(r, g, b, 0.9)
			else
				own.line:SetVertexColor(Theme.Wash("border"))
			end
			own.line:Show()
		end,
		-- Tabs: the house tab, plus a wash behind the selected one.
		tab = function(frame, base, kit)
			base(frame)
			local own = kit.store(frame)
			if not own.wash then
				own.wash = frame:CreateTexture(nil, "BACKGROUND", nil, -5)
				own.wash:SetTexture(Theme.Media("white"))
				own.wash:SetAllPoints(frame)
			end
			if frame.psSelected then
				own.wash:SetVertexColor(Theme.Wash("selected"))
				own.wash:Show()
			else
				own.wash:Hide()
			end
		end,
	},
}))
```

Things to keep in mind: `kit.fill` is the same texture the base painter
uses, so painting it yourself and then calling `base(frame)` would overwrite
your tint; call `base` first or not at all. `kit.hoverWash` returns the
highlight texture, so you can retint it. Reading `Theme.Accent()` inside
the painter means the player's accent and class colour carry through.

### A skin on a game look

The three game looks (`forever`, `blizzard`, `classic`) and Hearth draw the
client's own art and controls. A skin on one of them gives tokens over that
palette (no scheme: those looks bring their own grounds), and may pick the
arrow and map icons.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("rx-ironforge", {
	api = 1, name = "Ironforge", addon = ADDON,
	desc = "The Classic frame with steel edges and a cooler gold.",
	base = "classic",
	tokens = {
		windowEdge = "#8a949e", frameEdge = "#a9b3bd", frameEdgeDark = "#5a636c", titleLine = "#6f7984",
		accent = "#ffd56a", title = "#ffd56a", icon = "#dfe6ee", iconHover = "#ffffff",
		separator = "#a9b3bd73", divider = "#a9b3bd73",
	},
	arrow = "hearth",
	mapIcons = "hearth",
}))
assert(Theme.SkinInfo("rx-ironforge").base == "classic")
```

A skin on a game look is a "game skin" to the rest of Polestar
(`Theme.GameSkin()` is true): it gets the client's check boxes, sliders and
red buttons, the game font with its hard shadow, and Hearth's sizes. The
player's background, panel, sidebar and brightness controls are off for it,
as they are for the base.

### Marking the arrow and the pins

Choose Polestar's designs with `arrow` and `mapIcons`; add to them with
hooks. The hooks receive the arrow's frame (with the style in use) and each
pin's frame; create your pieces once, on the frame you are given.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("rx-beacon", {
	api = 1, name = "Beacon", addon = ADDON,
	desc = "A soft glow behind the arrow's dial.",
	base = "polestar", arrow = "flat", mapIcons = "halo",
	hooks = {
		arrow = function(frame, style)
			local glow = frame.rxGlow
			if not glow then
				glow = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
				glow:SetTexture(Theme.Media("glow"))
				glow:SetBlendMode("ADD")
				glow:SetPoint("TOP", frame, "TOP", 0, 12)
				glow:SetSize(88, 88)
				frame.rxGlow = glow
			end
			local r, g, b = Theme.Accent()
			glow:SetVertexColor(r, g, b, style == "flat" and 0.22 or 0.12)
			glow:Show()
		end,
	},
}))
```

The arrow hook runs when the arrow's look changes, the pin hook once per pin
per restyle: do not create textures on every call, and keep the work to a
few method calls. A pin frame's parts (`pin.medal`, `pin.icon`...) are
Polestar's internals today ([versioning](versioning.md#what-is-not-covered));
check for them before touching them.

### A variant switch with your own saved variable

A skin addon may keep settings of its own: a saved variable in its TOC, a
slash command, and a call to `Theme.Refresh()` when something your painters
read has changed. `Refresh` is Polestar's own function, public but outside
the Skin API's version promise, so check it exists.

TOC line: `## SavedVariables: EmberSkinDB`.

```lua
local ADDON = ...
local Theme = Polestar.Theme
EmberSkinDB = EmberSkinDB or { glow = true }
assert(Theme.RegisterSkin("rx-ember", {
	api = 1, name = "Ember", addon = ADDON,
	desc = "Ember, with an optional glow line (/emberskin glow).",
	base = "polestar",
	paint = {
		window = function(frame, base, kit)
			base(frame)
			local own = kit.store(frame)
			if not own.glow then
				own.glow = frame:CreateTexture(nil, "BORDER")
				own.glow:SetTexture(Theme.Media("white"))
				own.glow:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
				own.glow:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
				own.glow:SetHeight(1)
			end
			if EmberSkinDB.glow and not frame.psBare then
				local r, g, b = Theme.Accent()
				own.glow:SetVertexColor(r, g, b, 0.6)
				own.glow:Show()
			else
				own.glow:Hide()
			end
		end,
	},
}))
SLASH_EMBERSKIN1 = "/emberskin"
SlashCmdList.EMBERSKIN = function(msg)
	if msg == "glow" then
		EmberSkinDB.glow = not EmberSkinDB.glow
		if Theme.Refresh then Theme.Refresh() end -- repaint every window with the new setting
	end
end
SlashCmdList.EMBERSKIN("glow")
assert(EmberSkinDB.glow == false)
```

Per-skin rows inside Polestar's own settings window are not part of version
1; a slash command or your own small options frame is the way until a
capability for them exists.
