# Getting started: a skin addon from zero

You will make a separate addon that registers a colour scheme and a skin with
Polestar, see it in game, and know how to find out what went wrong. You need
Polestar 0.3.8 or newer installed (the first with the Skin API, version 2)
and a text editor; nothing else.

## 1. The folder and the TOC

Addons live in the game's `Interface/AddOns/`, one folder each, with a
`.toc` file of the same name. Call yours `Polestar_Skin_<Name>`:

```
Interface/AddOns/
  Polestar/                      <- Polestar itself
  Polestar_Skin_Ember/           <- yours
    Polestar_Skin_Ember.toc
    Ember.lua
```

The prefix matters: Polestar's install check compares every other
`Polestar_*` folder's version with its own and warns about stale ones, and
`Polestar_Skin_*` is the one prefix it leaves alone. Any name that does not
start with `Polestar_` works too (`EmberForPolestar`).

`Polestar_Skin_Ember.toc`:

```
## Interface: 16001
## Title: Polestar Skin: Ember
## Notes: Warm embers for Polestar's windows. Needs Polestar.
## Author: You
## Version: 1.0.0
## X-License: MIT
## Dependencies: Polestar
## Category: Polestar
## Group: Polestar
## X-Polestar-Skin: gs-ember
## LoadOnDemand: 1

Ember.lua
```

- `## Interface` is the client build the addon is for; copy the number from
  `Polestar/Polestar.toc` of the Polestar you have (16001 at the time of
  writing).
- `## Dependencies: Polestar` makes the game load Polestar before you, and
  disables your addon when Polestar is missing. Prefer it. `## OptionalDeps:
  Polestar` also loads Polestar first but keeps your addon enabled without
  it; then your code must cope with `Polestar` being nil (the guard below
  does).
- `## Category: Polestar` and `## Group: Polestar` list your addon with
  Polestar's own in the game's AddOns window.
- `## X-Polestar-Skin` names the ids your addon registers (several:
  `gs-ember, gs-ember-dark`; one id covers a skin and a scheme of that id).
  With it, `## LoadOnDemand: 1` keeps your addon out of memory until a
  player wants one of its skins: Polestar loads it at login when the
  player's saved skin or scheme is yours, when they pick it, and when the
  settings list the skins so your card shows
  ([installed skin addons](reference.md#installed-skin-addons)). Without
  `LoadOnDemand` the game loads your addon at login as usual. Never set
  `LoadOnDemand` without the `X-Polestar-Skin` line: Polestar would never
  load it.

## 2. The code

`Ember.lua`:

```lua
local ADDON = ...   -- the folder name, "Polestar_Skin_Ember"

-- Polestar 0.3.7 and older have no Skin API: do nothing on them.
local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and Theme.API_VERSION and Theme.API_VERSION >= 2) then return end

-- Show a refusal, or a note about something Polestar corrected, in chat.
local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

-- The colour scheme: six grounds and three text colours. Players can pick
-- it on its own, under Colour scheme.
check("scheme", Theme.RegisterScheme("gs-ember", {
	api = 2,
	name = "Ember",
	addon = ADDON,
	author = "You",
	version = "1.0.0",
	desc = "Warm embers: deep brown grounds under cream text.",
	tokens = {
		bg = "#1a1210f7", panel = "#201613fa", panelAlt = "#2b1f1a",
		sidebar = "#140d0b", footer = "#160f0d", sky = "#3b2520",
		text = "#fbf3ec", textDim = "#d6c6ba", textMuted = "#a8968a",
		star = "#ffd9b0", onAccent = "#2a1408",
	},
	accent = "#ffa05a",
	washes = { border = 0.1, divider = 0.1 },
}))

-- The skin: Polestar's own frames wearing that scheme, in Inter, with a
-- slightly larger goal line and the flat arrow.
check("skin", Theme.RegisterSkin("gs-ember", {
	api = 2,
	name = "Ember",
	addon = ADDON,
	author = "You",
	version = "1.0.0",
	desc = "Polestar in ember light, set in Inter.",
	base = "polestar",
	scheme = "gs-ember",
	font = "inter",
	fontSizes = { goal = 15 },
	arrow = "flat",
}))
```

That is a complete skin. The ids (`gs-ember`) are what players' settings
store: pick them once and never change them. The scheme and the skin may
share an id (they are separate namespaces), and a skin's `scheme` must be
registered before the skin.

## 3. See it in game

1. Start the game (or `/reload` if it is running: new addon folders need a
   full restart, changed files only a reload).
2. Check the AddOns window shows "Polestar Skin: Ember" enabled (loaded on
   demand: the game lists it as such until Polestar loads it).
3. `/polestar options` opens Polestar's settings. Under **Look > Theme**, the
   **Skin** cards now include Ember with "Polestar_Skin_Ember" under it and
   your `desc` as its tooltip; **Colour scheme** includes Ember too. Picking
   either repaints everything at once.
4. Try the player's controls on top of your skin: accent colour, background
   colour, brightness, window border, text size. Your skin should look right
   under all of them, because it reads the palette rather than fixing
   colours.

## 4. Change, reload, repeat

Edit `Ember.lua`, save, `/reload`. A skin cannot be registered twice in one
session (the second call answers `the id "gs-ember" is taken
(Polestar_Skin_Ember)`), so a reload is the loop. The player's saved choice
survives the reload, so you stay on your skin while you iterate.

Things worth trying next, each a few lines:

- Swap `font = "inter"` for `"fira"`, `"opensans"`, `"game"`, or your own
  `.ttf` files: `font = { regular = "Interface\\AddOns\\Polestar_Skin_Ember\\Fonts\\X-Regular.ttf", semibold = "...\\X-Bold.ttf" }`.
- Recolour subjects: `tokens = { quest = "#ffd27a", npc = "#9fd4ff" }` in
  the skin spec (not the scheme: those tokens belong to skins).
- Start from another look: `base = "halo"` (drop `scheme`, give `tokens`
  over Halo's palette instead).
- Offer it in two versions: `variants = { { id = "ember", name = "Ember" },
  { id = "ash", name = "Ash", tokens = { accent = "#c8c0b8" } } }`, picked
  under your skin's card ([variants](reference.md#variants)).
- Add a painter, or a hook on the arrow, the guide window, the cards or the
  buttons: see the [recipes](examples.md#recipes).

## 5. When something is wrong

**Nothing shows in the picker.** The registration was refused or never
ran.

- Is the addon enabled, and does the chat show a line from your `check`?
  A refusal prints the reason: a missing token, a colour that is not one,
  an unknown field (a typo), an id already taken, an `api` newer than the
  Polestar installed. If the player had chosen your skin, Polestar says it
  too, once: "The skin gs-ember (from Polestar_Skin_Ember) could not be
  added: <reason>. Polestar's own look stands in."
- No line at all: the guard returned early (Polestar missing or older than
  0.3.8), or your file is not listed in the TOC, or a Lua error stopped the
  file before the registration (see below). With `## LoadOnDemand: 1`,
  check the `## X-Polestar-Skin` line names your ids exactly: Polestar loads
  your addon only for those.
- Every registration answers "the Skin API's checks did not load": the
  `Polestar_SkinAPI` folder that comes with Polestar is missing or disabled
  in the AddOns window. Reinstall or enable Polestar's folders.
- Polestar's debug log also records refusals and corrections as `scheme
  <id> (<addon>): refused: <reason>`: `/polestar debug` turns debug output on.

**A Lua error.** Turn on *Display Lua Errors* in the game's interface
options (or install an error-catching addon) so a syntax error in your file
shows instead of silently loading nothing. The error names your file and
line.

**It shows, but looks like Polestar's own look.** Either the registration
answered with a note (the grounds were darkened: read it and give darker
grounds yourself, or lighter text), or a painter or hook raised an error
*after* registration. In the second case Polestar printed one line, "The
skin Ember (from Polestar_Skin_Ember) ran into an error, so Polestar's own
look stands in until you reload", recorded the error (it is in `/polestar
report`'s list and in `Polestar.Theme.SkinInfo("gs-ember").failed`), and
turned the skin off for the session. Fix it and `/reload`.

**The colours are not what I gave.** The player's own settings sit over a
skin: their accent (or class colour), their background/panel/sidebar colour
and brightness on the house style, their window border and arrow colours.
Right-click a colour control in Polestar's settings to reset it. Also, a
scheme's grounds are darkened when text would not read on them: the
registration's message says so.

**My painter runs but my texture is never visible.** Check `frame.psBare`
(a transparent window shows nothing), the draw layer (`BORDER` sits over the
`BACKGROUND` fill), and that you `:Show()` it: Polestar hides everything in
`kit.store(frame)` when another skin paints the frame, and does not show it
again for you.

**It worked, then another addon's skin broke.** Ids collide: the first
addon to register an id keeps it. Use a prefix of your own.

Read the error messages table in the [reference](reference.md#validation-and-error-messages)
for every refusal and what it means.
