# Examples and recipes

The example addon, annotated, then recipes you can paste into a skin of your
own. Every block below is complete and was run against Polestar 0.3.8's
Skin API (version 2); ids are prefixed so they do not collide with each
other or with the example. In your own addon, replace `local ADDON = ...`
with nothing (it is already the first line of your file) and change the ids.

- [The example addon: Moonlit](#the-example-addon-moonlit)
- [Recipes](#recipes)
  - [Recolour only](#recolour-only)
  - [New fonts](#new-fonts)
  - [A custom header texture and medallion](#a-custom-header-texture-and-medallion)
  - [A custom backing texture for windows](#a-custom-backing-texture-for-windows)
  - [Per-surface tweaks: buttons, edit boxes, tabs](#per-surface-tweaks-buttons-edit-boxes-tabs)
  - [A skin on a game look](#a-skin-on-a-game-look)
  - [One skin in several versions: variants](#one-skin-in-several-versions-variants)
  - [Colours by where the player is: a resolver](#colours-by-where-the-player-is-a-resolver)
  - [The arrow and the pins: your own art and light](#the-arrow-and-the-pins-your-own-art-and-light)
  - [A picture of the game behind a window](#a-picture-of-the-game-behind-a-window)
  - [A dense goal row](#a-dense-goal-row)
  - [Cards of your own above the guide window](#cards-of-your-own-above-the-guide-window)
  - [A toggle of your own, in the window's menu](#a-toggle-of-your-own-in-the-windows-menu)

## The example addon: Moonlit

[`addon/Polestar_Skin_Example`](../../addon/Polestar_Skin_Example) is a
two-file addon: the TOC and `Moonlit.lua`. It registers a scheme and a skin
named Moonlit, and its skin reaches every surface a skin can. In the order
the file is written:

**The TOC.** `## Dependencies: Polestar` (the game loads Polestar first),
`## X-Polestar-Skin: moonlit` (the id it registers) and `## LoadOnDemand: 1`:
the addon costs nothing until a player wants Moonlit. Polestar loads it at
login when Moonlit is the saved skin or scheme, when the player picks it,
and when the settings list the skins.

**The guard.** Polestar must be loaded and have a Skin API of version 2 or
newer; otherwise the file returns and the addon does nothing. This is what
keeps the addon harmless on an older Polestar.

```lua
-- not runnable: excerpt of Moonlit.lua
local ADDON = ...

-- Polestar loads first (## Dependencies: Polestar in the .toc). This file
-- is written for Skin API 2 (Polestar 0.3.8 and later): on an older
-- Polestar, without the API or its hooks, it does nothing.
local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and (Theme.API_VERSION or 0) >= 2) then return end
local kit = Theme.SkinKit
```

**`check`.** Each registration answers `ok, message`. A refusal is printed in
orange with the reason; an accepted spec with a note (grounds moved) is
printed plainly. Every skin addon should do this: the message is written for
you, not the player.

**The scheme.** `api = 2`, nine required tokens (six grounds, three text
colours) in `#rrggbb` and `#rrggbbaa`, three optional ones (`star`, `scrim`,
`onAccent`), a moonlight `accent` that stands in for Polestar gold when the
player has none of their own, and `washes` making the hairlines a little
stronger on the lighter ground. Every text role reads at its floor on every
ground as given, so the registration answers `true` with no note. Players
can pick Moonlit as a scheme under Polestar's own skin.

**`moonline`.** The one piece of art the skin adds everywhere: a line of
moonlight one pixel high along the top (or the bottom) of a frame, created
once in the skin's own store on that frame, then placed, tinted and shown
each time. Polestar hides the store's contents when another skin takes over;
the hooks show the line again each time they run.

```lua
-- not runnable: excerpt of Moonlit.lua
local function moonline(frame, key, token, alpha, bottom)
	local own = kit.store(frame)
	local t = own[key]
	if not t then
		t = frame:CreateTexture(nil, "OVERLAY", nil, 7)
		t:SetTexture(Theme.Media("white"))
		own[key] = t
	end
	local edge = bottom and "BOTTOM" or "TOP"
	t:ClearAllPoints()
	t:SetPoint(edge .. "LEFT", frame, edge .. "LEFT", 0, 0)
	t:SetPoint(edge .. "RIGHT", frame, edge .. "RIGHT", 0, 0)
	t:SetHeight(Theme.Pixel(frame))
	local r, g, b = Theme.Color(token or "accent")
	t:SetVertexColor(r, g, b, alpha or 0.55)
	t:Show()
	return t
end
```

**The skin.** `base = "polestar"` (the house frames, band and sizes),
`scheme = "moonlit"` (so the skin always wears its scheme, whatever scheme
the player picked), tokens over the scheme (`accent2`, the arrow's moonlight;
`glow`, the arrow's light; `pinRing` and `pinFill`, the map pins' rim and
fill), two **variants** ("Full moon" in silver, the default, and "New moon",
a darker night whose variant tokens turn the moonlight blue), `font =
"fira"`, a 24-point `hero`, a softer and wider `shadow` under the windows,
and Halo's arrow and map icons for players who leave those on "Skin".

**One painter.** `paint.window` calls `base(frame)` (the house window:
ground, border, drop shadow), then draws its moonline along the top edge,
and hides it on a transparent window (`psBare`):

```lua
-- not runnable: excerpt of Moonlit.lua
window = function(frame, base, k)
	base(frame)
	-- A transparent window (frame.psBare) shows no ground at all.
	if frame.psBare then
		local own = k.store(frame)
		if own.moon then own.moon:Hide() end
		return
	end
	moonline(frame, "moon")
end,
```

**A hook on every surface.** Each of the fourteen hooks adds the same idea
where it lands, after Polestar's own look is on: a glow of `accent2` behind
the arrow's dial (`kit.glow`), a shadow under the step pins' numbers, the
moonline over the guide window's title, a bar of `accent2` beside the current
goal's row, a rule under the window's parts (`guideLayout` answers the six
units it takes, `guideRender` hides it when no step shows), a line as long as
the part of the guide done (`guideProgress`), a line along the top of the tab
in view, its name at the end of the window's menu, and a moonline on every
card, toast and button (brighter under the mouse). `guideAnchor` answers nil
and `guidePlace` false: Moonlit keeps the heads-up card and every part of the
window where Polestar puts them. Two of them:

```lua
-- not runnable: excerpt of Moonlit.lua
guideRow = function(row, goal, info)
	local own = kit.store(row)
	local bar = own.bar
	if not bar then
		bar = row:CreateTexture(nil, "ARTWORK")
		bar:SetTexture(Theme.Media("white"))
		bar:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -2)
		bar:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 2)
		bar:SetWidth(2)
		own.bar = bar
	end
	bar:SetVertexColor(Theme.Color("accent2"))
	bar:SetShown(info.current and not info.done)
end,
-- ...
guideLayout = function(parts, width, y)
	local rule = moonline(parts.body, "rule", "accent2", 0.4)
	rule:ClearAllPoints()
	rule:SetPoint("TOPLEFT", parts.body, "TOPLEFT", 12, -(y + 3))
	rule:SetWidth(math.max(1, width - 24))
	return 6
end,
```

Things to copy from it: every texture is created once and kept in
`kit.store(frame)` (so Polestar hides it when another skin takes the frame);
it is hidden on a transparent window (`psBare`); colours are read at paint
time through `Theme.Color`, so the player's own accent colours the lines;
`base(frame)` runs first, so everything the house style does still happens;
and a pooled frame (a goal row) gets every piece set on every call.

To make your own: copy the folder, rename it and its `.toc` (keep the
`X-Polestar-Skin` line, with your own ids), change the ids, names and
colours, and register what you need.

## Recipes

### Recolour only

The smallest useful skin is a scheme: grounds and text, nothing else.
Everything Polestar draws follows.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterScheme("rx-slate", {
	api = 2, name = "Slate", addon = ADDON,
	desc = "Cool grey-blue grounds, a crisp white ladder.",
	tokens = {
		bg = "#1b2027f7", panel = "#20262efa", panelAlt = "#2a313b",
		sidebar = "#151a20", footer = "#171c22", sky = "#2e3745",
		text = "#f6f8fb", textDim = "#c9d0da", textMuted = "#9aa4b2",
	},
	accent = "#8ec5ff",
}))
```

To recolour the **roles** too (titles, links, the washes), you need a skin:
those tokens belong to skins. A skin with only `tokens` is Polestar's own
look recoloured, and it still follows the player's scheme unless you give it
one.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("rx-slate", {
	api = 2, name = "Slate", addon = ADDON,
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
	api = 2, name = "Serif", addon = ADDON,
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
	api = 2, name = "Aurora", addon = ADDON,
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
	api = 2, name = "Parchment", addon = ADDON,
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
	api = 2, name = "Controls", addon = ADDON,
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
palette (no scheme: those looks bring their own grounds), may pick the
arrow and map icons, and may tint the game art itself with `artTint`.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("rx-ironforge", {
	api = 2, name = "Ironforge", addon = ADDON,
	desc = "The Classic frame in cold steel, with a cooler gold.",
	base = "classic",
	tokens = {
		windowEdge = "#8a949e", frameEdge = "#a9b3bd", frameEdgeDark = "#5a636c", titleLine = "#6f7984",
		accent = "#ffd56a", title = "#ffd56a", icon = "#dfe6ee", iconHover = "#ffffff",
		separator = "#a9b3bd73", divider = "#a9b3bd73",
	},
	-- The game's own window art and red buttons, drained toward steel.
	artTint = { tint = { 0.85, 0.9, 1 }, desaturate = 0.6, brightness = -0.1 },
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

### One skin in several versions: variants

A light and a dark version, the same design on another base, a choice of
accent: one skin with `variants`, picked under its card, instead of several
skins side by side. A variant names only what it changes.

```lua
local ADDON = ...
local Theme = Polestar.Theme
assert(Theme.RegisterSkin("rx-tide", {
	api = 2, name = "Tide", addon = ADDON,
	desc = "Sea colours, in three versions.",
	base = "polestar",
	tokens = { accent = "#6fe3c9", accent2 = "#2f9e8a" },
	variants = {
		{ id = "shallows", name = "Shallows", desc = "Teal on Polestar's night." },
		{ id = "deep", name = "Deep", desc = "Darker grounds, a blue accent.",
			tokens = { accent = "#5aa8ff", bg = "#070d17f7", panel = "#0a1220fa" } },
		{ id = "harbour", name = "Harbour", desc = "The game's own frame, salted.", base = "hearth",
			artTint = { tint = { 0.8, 0.95, 0.95 }, desaturate = 0.4 } },
	},
	defaultVariant = "shallows",
}))
```

Each variant's text is held to the legibility rule on the look it is drawn
from, as the skin's is. Your hooks and painters run for every variant; ask
`Theme.SkinVariant("rx-tide")` when one should draw differently.

### Colours by where the player is: a resolver

A resolver answers tokens (and a font) from the player's context, asked on
every repaint and on a new zone. Polestar repaints after a new zone only
when the answer changed, so a skin keyed to the faction or the continent
costs nothing at a zone border.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local FACTION = { Alliance = "#5b8cff", Horde = "#e5533d" }
assert(Theme.RegisterSkin("rx-banner", {
	api = 2, name = "Banner", addon = ADDON,
	desc = "Your faction's colour as the accent; your class colour as the second.",
	resolve = function(ctx)
		return { accent = FACTION[ctx.faction] or "#e6ba66", accent2 = ctx.classColor or "#ffffff" }
	end,
}))
```

### The arrow and the pins: your own art and light

The Halo and Hearth arrows draw a dart you can replace (`media.dart`, and
its edge `media.dartEdge`, 128x128, pointing up); Polestar's map pin is a
disc and a rim you can replace (`media.pinFill`, `media.pinRim`, 64x64
masks). The tokens colour them where the player has not: `glow` the arrow's
light, `pinFill` and `pinRing` the pins.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\"
assert(Theme.RegisterSkin("rx-compass", {
	api = 2, name = "Compass", addon = ADDON,
	desc = "A needle for an arrow, brass pins.",
	arrow = "halo",                                   -- the design whose dart is replaced
	media = { dart = MEDIA .. "needle.tga", dartEdge = MEDIA .. "needle-edge.tga",
		pinFill = MEDIA .. "pin-disc.tga", pinRim = MEDIA .. "pin-rim.tga" },
	tokens = { glow = "#ffd27a", pinFill = "#c9a66a", pinRing = "#f5e6c0" },
	hooks = {
		-- The distance under the needle in the title colour.
		arrow = function(frame, style, parts)
			parts.distance:SetTextColor(Theme.Color("title"))
		end,
	},
}))
```

The player's own arrow and pin colours win over the tokens, as everywhere.
Draw the masks white where they show: Polestar tints them.

### A picture of the game behind a window

`kit.gameArt` lays one of the client's own pictures behind a frame's
content, cropped to cover it, faded and kept faint enough for the text over
it; `kit.crossfade` changes it smoothly. With a resolver, the picture can
follow the continent.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local SCREENS = "Interface\\Glues\\LoadingScreens\\"
local LANDS = {
	["Kalimdor"] = { file = SCREENS .. "LoadScreenKalimdor", accent = "#d9a441" },
	["Eastern Kingdoms"] = { file = SCREENS .. "LoadScreenEasternKingdom", accent = "#9bb35a" },
}
local land -- the continent the resolver last answered for
assert(Theme.RegisterSkin("rx-vista", {
	api = 2, name = "Vista", addon = ADDON,
	desc = "The continent you are on, faint behind the guide window's head, in its colour.",
	-- Its answer changes with the continent, so a new continent repaints (and
	-- the painter below changes the picture); a new zone on the same one does not.
	resolve = function(ctx)
		land = LANDS[ctx.continentName or ""]
		return { accent = land and land.accent or "#e6ba66" }
	end,
	paint = {
		guide = function(frame, base, kit)
			base(frame)
			local own = kit.store(frame)
			local file = land and land.file
			if frame.psBare or not file then
				if own.art then own.art:Hide() end
				return
			end
			own.art = kit.gameArt(frame, { file = own.file or file, height = 120, fade = "bottom", alpha = 0.22 })
			if own.file and own.file ~= file then kit.crossfade(own.art, file) end
			own.file = file
		end,
	},
}))
```

The painter reads what the resolver heard last: the resolver runs when the
palette is built, at the first colour read of each repaint, and `base(frame)`
reads colours before the painter reads `land`. Keep `alpha` low (the kit
holds it at 0.35 at most) so the text over the picture keeps its contrast.

### A dense goal row

The `guideRow` hook dresses each goal's row after Polestar painted it. Rows
are pooled, so set everything you use on every call. The goal carries its
count (`progress`), where it is (`map`, `x`, `y`) and its ids.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local kit = Theme.SkinKit
-- The count and the zone at the right of each row.
local function zoneName(map)
	local info = map and C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(map)
	return info and info.name or nil
end
assert(Theme.RegisterSkin("rx-ledger", {
	api = 2, name = "Ledger", addon = ADDON,
	desc = "Each goal's count and zone on its row.",
	hooks = {
		guideRow = function(row, goal, info)
			local own = kit.store(row)
			if not own.side then
				own.side = row:CreateFontString(nil, "OVERLAY")
				Theme.Font(own.side, "small")
				own.side:SetPoint("RIGHT", row, "RIGHT", -6, 0)
			end
			local p, zone = goal.progress, zoneName(goal.map)
			local text = p and (p.cur .. "/" .. p.max) or ""
			if zone and not info.done then text = text == "" and zone or (text .. " · " .. zone) end
			own.side:SetText(text)
			own.side:SetTextColor(Theme.Color(info.current and "text" or "textMuted"))
			own.side:Show()
		end,
	},
}))
```

### Cards of your own above the guide window

`guidePlace` hands you each part of the window before it is placed; answer
`true` and the window leaves it out (its height too) for you to place.
`guideAnchor` puts the heads-up card on your frame.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local card -- a frame above the window, holding While you're here
assert(Theme.RegisterSkin("rx-cards", {
	api = 2, name = "Cards", addon = ADDON,
	desc = "While you're here in a card above the guide window.",
	hooks = {
		guidePlace = function(name, frame, width, height)
			local parts = Theme.GuideParts()
			if name ~= "here" or not parts then return false end
			if not card then
				card = CreateFrame("Frame", nil, parts.window)
				card.psLight = true          -- painted as a toast: the skin's and the player's colours
				Theme.Skin(card, "window")
			end
			card:ClearAllPoints()
			card:SetPoint("BOTTOMLEFT", parts.window, "TOPLEFT", 0, 4)
			card:SetSize(width, height + 12)
			frame:SetParent(card)
			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -6)
			frame:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, -6)
			return true
		end,
		-- After each render: the card shows while it holds a part that shows.
		guideRender = function(view, parts)
			if card then card:SetShown(view ~= nil and parts.here:IsShown() and parts.here:GetParent() == card) end
		end,
		-- The heads-up card sits on the card instead of the window.
		guideAnchor = function()
			return card and card:IsShown() and card or nil
		end,
	},
	onLeave = function() if card then card:Hide() end end,
}))
```

A part you take is yours until you answer anything but `true` again: then
the window puts it back under its own frame and places it. `guideLayout`
does the opposite: it adds room of your own under the window's parts.

### A toggle of your own, in the window's menu

A skin addon may keep settings of its own: a saved variable in its TOC, an
entry in the guide window's menu (`guideMenu`), and a call to
`Theme.Refresh()` when something your painters read has changed (part of
the version promise under `theme.functions`). For a choice between whole
versions of the skin, [variants](#one-skin-in-several-versions-variants)
are simpler: Polestar draws their cards.

TOC line: `## SavedVariables: EmberSkinDB`.

```lua
local ADDON = ...
local Theme = Polestar.Theme
EmberSkinDB = EmberSkinDB or { glow = true }
assert(Theme.RegisterSkin("rx-ember", {
	api = 2, name = "Ember", addon = ADDON,
	desc = "Ember, with an optional glow line (in the guide window's menu).",
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
			end
			own.glow:SetHeight(Theme.Pixel(frame))
			if EmberSkinDB.glow and not frame.psBare then
				local r, g, b = Theme.Accent()
				own.glow:SetVertexColor(r, g, b, 0.6)
				own.glow:Show()
			else
				own.glow:Hide()
			end
		end,
	},
	hooks = {
		guideMenu = function(items, button)
			items[#items + 1] = { separator = true }
			items[#items + 1] = { text = "Ember glow", icon = "star", checked = EmberSkinDB.glow, onClick = function()
				EmberSkinDB.glow = not EmberSkinDB.glow
				Theme.Refresh() -- repaint every window with the new setting
			end }
		end,
	},
}))
```
