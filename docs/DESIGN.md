---
name: Polestar
description: "A guiding-star instrument for World of Warcraft: Forever: night grounds under a starlit band, one gold accent, Inter on a hairline grid."
colors:
  # Primary: the one accent (Polestar gold) and the ink on it
  accent: "#e6ba66"
  onAccent: "#0a0d14"
  # Secondary: status
  success: "#6bd999"
  warning: "#fabf4d"
  danger: "#f57373"
  # Tertiary: subject colours, the same in every scheme
  npc: "#94c9ff"
  quest: "#ffd673"
  item: "#c7adff"
  place: "#f5ad85"
  object: "#dbc9a8"
  level: "#f5f7fc"
  skill: "#99e075"
  spell: "#78dbed"
  faction: "#f799c9"
  area: "#edbf99"
  achievement: "#ffa352"
  dungeon: "#a385ff"
  rare: "#ff8052"
  mapUnexplored: "#99a8e6"
  # Another brand's colour, on its own mark only
  discord: "#5865f2"
  # Neutral: grounds (Dusk, the default scheme), darkest to lightest
  sidebar: "#121624"
  footer: "#141927"
  bg: "#181d2d"
  panel: "#1c2234"
  panelAlt: "#232a3f"
  sky: "#283254"
  # Neutral: the text ladder
  text: "#f7f8fd"
  textDim: "#c3cadd"
  textMuted: "#9ba2b9"
  # Neutral: ink, stars, shade
  ink: "#ffffff"
  star: "#ffffff"
  shade: "#000005"
  scrim: "#05080f"
  shadow: "rgba(0, 0, 5, 0.6)"
  # Neutral: washes, ink at a role's alpha (Dusk)
  border: "rgba(255, 255, 255, 0.1)"
  divider: "rgba(255, 255, 255, 0.1)"
  hover: "rgba(255, 255, 255, 0.07)"
  selected: "rgba(255, 255, 255, 0.12)"
  track: "rgba(255, 255, 255, 0.12)"
  progress: "rgba(255, 255, 255, 0.08)"
  toggle: "rgba(255, 255, 255, 0.14)"
  chip: "rgba(255, 255, 255, 0.07)"
  watermark: "rgba(255, 255, 255, 0.028)"
typography:
  hero:
    fontFamily: "Inter, sans-serif"
    fontSize: "26px"
    fontWeight: 600
  display:
    fontFamily: "Inter, sans-serif"
    fontSize: "18px"
    fontWeight: 600
  title:
    fontFamily: "Inter, sans-serif"
    fontSize: "15px"
    fontWeight: 600
  name:
    fontFamily: "Inter, sans-serif"
    fontSize: "15px"
    fontWeight: 600
  goal:
    fontFamily: "Inter, sans-serif"
    fontSize: "14px"
    fontWeight: 500
  heading:
    fontFamily: "Inter, sans-serif"
    fontSize: "13px"
    fontWeight: 600
  body:
    fontFamily: "Inter, sans-serif"
    fontSize: "13px"
    fontWeight: 500
  label:
    fontFamily: "Inter, sans-serif"
    fontSize: "12px"
    fontWeight: 500
  note:
    fontFamily: "Inter, sans-serif"
    fontSize: "12px"
    fontWeight: 400
  number:
    fontFamily: "Inter, sans-serif"
    fontSize: "12px"
    fontWeight: 600
  small:
    fontFamily: "Inter, sans-serif"
    fontSize: "11px"
    fontWeight: 500
  caption:
    fontFamily: "Inter, sans-serif"
    fontSize: "11px"
    fontWeight: 600
rounded:
  square: "0px"
  capsule: "9999px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "12px"
  guide: "14px"
  gutter: "16px"
  side: "24px"
  pad: "32px"
components:
  window:
    backgroundColor: "{colors.bg}"
    textColor: "{colors.text}"
    rounded: "{rounded.square}"
  header-band:
    backgroundColor: "{colors.sky}"
    textColor: "{colors.text}"
    typography: "{typography.hero}"
    padding: "32px 32px 0"
    height: "112px"
  sidebar:
    backgroundColor: "{colors.sidebar}"
    padding: "0 24px"
    width: "240px"
  rail-button:
    backgroundColor: "{colors.sidebar}"
    textColor: "{colors.textDim}"
    typography: "{typography.caption}"
    width: "64px"
    height: "56px"
  rail-button-active:
    backgroundColor: "{colors.selected}"
    textColor: "{colors.text}"
  nav-row:
    textColor: "{colors.textDim}"
    typography: "{typography.body}"
    padding: "0 24px"
    height: "40px"
  nav-row-active:
    backgroundColor: "{colors.selected}"
    textColor: "{colors.text}"
  tab:
    textColor: "{colors.textDim}"
    typography: "{typography.label}"
    padding: "0 12px"
    height: "40px"
  tab-active:
    textColor: "{colors.text}"
  segment:
    textColor: "{colors.textMuted}"
    typography: "{typography.small}"
    padding: "0 10px"
    height: "24px"
  segment-active:
    backgroundColor: "{colors.panelAlt}"
    textColor: "{colors.text}"
  footer-bar:
    backgroundColor: "{colors.footer}"
    padding: "0 32px"
    height: "56px"
  section-header:
    textColor: "{colors.text}"
    typography: "{typography.heading}"
    height: "44px"
  setting-row:
    textColor: "{colors.text}"
    typography: "{typography.body}"
    padding: "0 12px"
    height: "40px"
  button:
    backgroundColor: "{colors.panelAlt}"
    textColor: "{colors.text}"
    typography: "{typography.label}"
    rounded: "{rounded.square}"
    padding: "0 16px"
    height: "28px"
  button-primary:
    backgroundColor: "{colors.accent}"
    textColor: "{colors.onAccent}"
    typography: "{typography.label}"
    rounded: "{rounded.square}"
    padding: "0 16px"
    height: "28px"
  button-ghost:
    textColor: "{colors.text}"
    typography: "{typography.label}"
    padding: "0 16px"
    height: "28px"
  icon-button:
    textColor: "{colors.textDim}"
    size: "22px"
  action-tile:
    backgroundColor: "{colors.panelAlt}"
    textColor: "{colors.text}"
    typography: "{typography.body}"
    padding: "0 12px 0 48px"
    height: "60px"
  chip:
    backgroundColor: "{colors.chip}"
    textColor: "{colors.textDim}"
    typography: "{typography.caption}"
    rounded: "{rounded.capsule}"
    padding: "0 9px"
    height: "20px"
  chip-accent:
    backgroundColor: "rgba(230, 186, 102, 0.16)"
    textColor: "{colors.accent}"
  chip-success:
    backgroundColor: "rgba(107, 217, 153, 0.14)"
    textColor: "{colors.success}"
  chip-warning:
    backgroundColor: "rgba(250, 191, 77, 0.14)"
    textColor: "{colors.warning}"
  chip-dungeon:
    backgroundColor: "rgba(163, 133, 255, 0.14)"
    textColor: "{colors.dungeon}"
  input-search:
    backgroundColor: "rgba(0, 0, 5, 0.35)"
    textColor: "{colors.text}"
    typography: "{typography.label}"
    rounded: "{rounded.square}"
    padding: "0 26px 0 30px"
    height: "30px"
  dropdown:
    backgroundColor: "{colors.panelAlt}"
    textColor: "{colors.text}"
    typography: "{typography.label}"
    padding: "0 26px 0 10px"
    width: "150px"
    height: "28px"
  toggle:
    backgroundColor: "{colors.toggle}"
    rounded: "{rounded.capsule}"
    width: "30px"
    height: "16px"
  toggle-on:
    backgroundColor: "{colors.accent}"
  slider:
    backgroundColor: "{colors.track}"
    width: "112px"
    height: "2px"
  menu:
    backgroundColor: "{colors.panel}"
    padding: "5px 0"
    width: "176px"
  menu-row:
    textColor: "{colors.text}"
    typography: "{typography.label}"
    padding: "0 12px"
    height: "26px"
  list-row:
    textColor: "{colors.text}"
    typography: "{typography.body}"
    padding: "0 20px"
    height: "28px"
  list-row-selected:
    backgroundColor: "{colors.selected}"
  card:
    backgroundColor: "{colors.panelAlt}"
    textColor: "{colors.text}"
    rounded: "{rounded.square}"
    padding: "0 20px"
    height: "78px"
  progress-line:
    backgroundColor: "{colors.progress}"
    height: "2px"
  guide-window:
    backgroundColor: "{colors.bg}"
    textColor: "{colors.text}"
    padding: "0 14px"
    width: "340px"
  guide-tab:
    textColor: "{colors.textMuted}"
    typography: "{typography.small}"
    height: "28px"
  guide-tab-active:
    backgroundColor: "{colors.hover}"
    textColor: "{colors.text}"
  goal-line:
    textColor: "{colors.text}"
    typography: "{typography.goal}"
  goal-line-done:
    textColor: "{colors.textMuted}"
  person-name:
    textColor: "{colors.npc}"
    typography: "{typography.name}"
  rare-alert:
    backgroundColor: "{colors.bg}"
    textColor: "{colors.text}"
    width: "368px"
    height: "112px"
  report-window:
    backgroundColor: "{colors.bg}"
    textColor: "{colors.text}"
    width: "440px"
  planner-bar:
    backgroundColor: "{colors.bg}"
    textColor: "{colors.text}"
    padding: "0 16px 0 14px"
    height: "56px"
  steps-pane:
    backgroundColor: "{colors.sidebar}"
    textColor: "{colors.text}"
    width: "340px"
  step-row:
    textColor: "{colors.text}"
    typography: "{typography.body}"
    padding: "6px 14px 0 16px"
  step-row-selected:
    backgroundColor: "{colors.selected}"
  map-pin:
    backgroundColor: "{colors.scrim}"
    rounded: "{rounded.capsule}"
    size: "24px"
  map-pin-current:
    backgroundColor: "{colors.scrim}"
    rounded: "{rounded.capsule}"
    size: "31px"
  map-label:
    backgroundColor: "{colors.panel}"
    textColor: "{colors.text}"
    typography: "{typography.label}"
    rounded: "{rounded.square}"
    padding: "2px 7px 3px"
  map-banner:
    backgroundColor: "{colors.panel}"
    textColor: "{colors.text}"
    typography: "{typography.body}"
    padding: "0 6px 0 12px"
    height: "36px"
  transport-bar:
    backgroundColor: "{colors.footer}"
    padding: "0 16px"
    height: "56px"
  scrubber:
    backgroundColor: "{colors.track}"
    height: "2px"
  scrubber-fill:
    backgroundColor: "{colors.accent}"
    height: "2px"
  pad-chip:
    backgroundColor: "{colors.chip}"
    textColor: "{colors.text}"
    typography: "{typography.caption}"
    rounded: "{rounded.capsule}"
    padding: "0 7px"
    height: "20px"
  pad-focus:
    backgroundColor: "{colors.hover}"
    borderColor: "{colors.accent}"
    borderWidth: "2px"
  pad-hints:
    backgroundColor: "{colors.panel}"
    textColor: "{colors.textDim}"
    typography: "{typography.small}"
    padding: "4px 12px"
---

# Design System: Polestar

## Overview

**Creative North Star: "The Guiding-Star Instrument"**

Polestar is one crafted object in several sizes: the hub (Guides, Lookup, Dungeons, Rares and Options in one shell), the compact guide window that stays on screen for hours, and the small alerts, pins and arrow that sit on the game world. Every window opens under a starlit night-sky band, and every shell carries the Polestar star at its head; below the band the controls are quiet and precisely gridded: 1px hairlines, a white text ladder tinted toward its ground, and one gold accent that marks what you can act on and where you are. It is read at arm's length over a moving 3D world, often beside full UI suites such as EllesmereUI or ElvUI, so it earns trust by looking deliberate, never by being loud.

The world is night by choice and by necessity. The default scheme, Dusk, lifts the original navy-black to a clearly lighter navy (window ground #181d2d); the player may pick Night, Graphite or, only while it is installed, EllesmereUI's own panel colour, and may set their own accent, ground colour, ground opacity and brightness on top. Whatever they pick, the text ladder holds 7:1 and 4.5:1, and a ground too light to carry it is darkened until it reads. There is no light scheme: transparent mode and the waypoint arrow put text straight onto the game world, and the starfield band has no daylight form.

Density is measured rather than compact: 40px setting rows, 28px list rows, a gutter for state glyphs, one focus at a time in the guide window. It refuses the stock addon look: settings boxed in grey group frames or stacked one per full-width row, and eyebrow labels over headings.

**Key Characteristics:**
- Night grounds layered by tone (sidebar darkest, raised panels and controls a step lighter, the sky band lightest), never one flat fill.
- One accent (Polestar gold by default; the player's own or EllesmereUI's by choice) for action, position and the one fact that decides a choice.
- A white text ladder tinted toward the ground, held to 7:1 and 4.5:1 on every ground of every scheme.
- Names wear their subject's colour (NPC blue, quest gold, item lilac), the same in every scheme.
- Inter in three weights on a fixed size ladder, nothing under 11px; Cinzel lives only in the engraved wordmark image.
- 1px physical-pixel hairlines, square corners, capsules only for chips and toggles.
- An authored glyph family (24-unit grid, 2.25 stroke) drawn in code and tinted at runtime; no Unicode stand-ins.
- Short ease-out motion, 120–200ms, that honours reduced motion.

## Intent

This section says what the tokens and components below are for. A surface is finished when it has been reviewed against this whole document.

**Who it is for.** Forever players levelling characters, many of them alts, who want a quick, smooth path without alt-tabbing to a website. They play in long sessions with the game world behind every surface, often beside full UI suites such as EllesmereUI or ElvUI, or the game's own frames. They set Polestar up once in Options, pick or switch guides in the guide menu, then read the guide window at a glance for hours.

**What success looks like.** The guide window and the arrow sit on screen for hours without tiring the eye: legible over any terrain, out of the way in combat, readable at a glance mid-pull. The player knows where they are (guide, step, progress) without reading, trusts the windows because every control looks deliberate, and acts with one click: switch tab, pick a guide, change a setting. Menus feel like a crafted options window, with a clear sidebar, a titled header, tabbed pages and every control on one grid and explained, never like a utility panel. Several guides run side by side in tabs, such as a class quest guide next to the leveling route.

**The guide window: one thing at a time.** The window shows one focus: the person to talk to now, with only that person's goals under it, or a field step's few objectives. Each goal is one line with its counter right after the text ("Kill Zhevra Chargers 3/8"); done goals are checked and dimmed. A single dim "Then:" line names the next person, and "Person 2 of 8" counts them. Tips collapse to one line and open on demand; Up next is off by default. The progress bar at the foot stays faintly visible in transparent mode.

**The guide menu: selecting is not loading.** Choosing a row shows that guide's details: its zone art with the title on the painting, chips, progress, a facts block of real guide data (a Class guide's reward first: an icon tile per item, spell or minion, the item's name in its quality colour, the game's tooltip on hover, a choice under "Choose one", then one line on why it is worth doing; then steps, quests, the zones in order, the guide after it), then the pitch, pros and cons. Loading is explicit, through "Load guide" ("Continue" when it is open) or "Open in new tab", pinned at the bottom. The list is one line per guide, its title with the level range, grouped under folder headers; the load hint is the row's tooltip, not a hint bar. A category with no guide for any faction is left out, and one empty only for this faction fades. On the route choice, each card leads with the zone art, the name and one stat row (levels, travel time, quests) at the same height on every card, then the pitch and at most three pros and two cons, one line each.

**Too early is said, never guessed around.** A Class guide the character cannot start yet (its first quest needs a higher level, or a quest done first) recedes in the guide menu: its title in textDim and "From level 20" (or "Not available yet") at the row's right in Small textMuted, where an open guide says its tab. Opened anyway, the guide window shows an empty state in place of the step: the level glyph in the accent, "Available from level 20" in Display, then who starts it and "Come back at level 20: the guide picks up by itself then." in Note textDim, with "Choose a guide". The arrow points nowhere, and the guide starts by itself when the level (or the quest) is reached; Next still looks at the steps ahead.

**Dungeons: a quest journal, not a loot browser.** The Dungeons section covers quests, bosses and entrances, with no loot tables or gear browsing. Dungeons are grouped by level, with For your level as the default (a dungeon whose quests are all the other faction's is not yours). A dungeon's page has tabs for its quests, bosses and map. Every quest block shows everything at once: its state, level, requirements, objective, where it starts and ends, its chain, and its rewards as item tiles whose hover is the game's tooltip. One action wears the accent, the one to take now: "Hand in the quests" once a quest here is finished, else "Pick up the quests" while there are quests to take, else "Guide me to the entrance"; the band holds three actions at most. Speed is part of the design: cards paint their art only in view, quest blocks are planned from data and drawn only in view, and every row is pooled.

**Constraints.** A WoW addon draws with Lua frames, textures and FontStrings only, and its textures are power-of-two sizes. Polestar is free and open source under the GPL-3.0, and its code stays readable, as Blizzard's add-on policy asks. No third-party assets, code or text ship beyond what [THIRD_PARTY.md](../THIRD_PARTY.md) credits (the data sources, and Discord's mark beside the link to the Polestar Discord), and EllesmereUI is read only through its public skinning API (accent, panel colour, font). English comes first, and the layout must survive longer localised strings later.

## Colours

A night palette: navy grounds lifted in small OKLab steps, a cool-white text ladder, one warm gold accent, and a fixed family of bright subject colours that names things by kind.

Every colour is a Theme token, resolved per colour as: the player's own value > the class colour (`ui.classAccent`, accent only, lifted toward the text colour until it reads at 4.5:1 on the panel) > "Match EllesmereUI" (installed and on) > the scheme; choosing one accent source turns the others off. The frontmatter holds Dusk, the default scheme, with Polestar gold; Night and Graphite, the wash alphas per scheme and the legibility floors are in `addon/Polestar/Theme/Theme.lua` (`SCHEMES`, `WASH` with `SCHEME_WASH`, and `Theme.LEGIBLE`). Token names are the Theme names, so `{colors.panelAlt}` is `Theme.Color("panelAlt")`. Contrast figures below are measured in Dusk.

### Primary
- **Polestar Gold** (#e6ba66, `accent`): the colour of action and position: primary button fills, toggles when on, slider fills, the 2px selection bar, the active tab's underline and glyph, the current goal's glyph, focused field borders (at 80%), the checks in checkboxes and menus, progress fills, the waypoint arrow until it nears its target, the focus ring on map pins; and the chip that decides a choice (a guide's level range, "Your level", "Recommended"), and on the game's reward panel the frame and coin on the reward to take. The emblem wears it too, so the mark follows the player's accent.
- **Night Ink on Gold** (#0a0d14, `onAccent`): labels and glyphs on accent fills (10.7:1 on gold). When a player's accent is too dark to carry it, the light text colour takes over automatically, whichever contrasts more.

### Secondary
- **Done Jade** (#6bd999, `success`): completion and gain: done-goal checks, complete counters, finished-guide checks, the "Done", "Ready to turn in" and "Your current route" chips, the arrow as it closes on its target, the up arrow on a quest reward that is an upgrade and the tooltip's upgrade line.
- **Amber Warning** (#fabf4d, `warning`): what this character cannot do yet or what needs attention: requirements in Lookup, an unavailable Codex, a paused recorder, an untaken flight path, an instance lockout, and the release stage's chip ("BETA") beside the version.
- **Coral Danger** (#f57373, `danger`): destructive actions ("Reset all settings", "Click again to confirm") and kill objectives on the map.

### Tertiary
The subject colours. A thing's name wears its kind's colour, the same in every scheme, held at 4.5:1 on every ground except the sky band (only titles sit on the band).
- **NPC Sky** (#94c9ff, `npc`): people to talk to and creatures to kill, the person in focus, "Then:" names.
- **Quest Gold** (#ffd673, `quest`): quest names, the "!" and "?" markers, level ranges on the world map.
- **Item Lilac** (#c7adff, `item`): items, mounts, recipes; collect and vendor markers.
- **Place Peach** (#f5ad85, `place`): places and zones; interact and event markers.
- **Object Parchment** (#dbc9a8, `object`): objects and treasures.
- **Level White** (#f5f7fc, `level`), **Skill Leaf** (#99e075, `skill`), **Spell Cyan** (#78dbed, `spell`), **Faction Rose** (#f799c9, `faction`), **Area Sand** (#edbf99, `area`), **Achievement Orange** (#ffa352, `achievement`): their kinds in goal lines and tooltips.
- **Portal Violet** (#a385ff, `dungeon`): dungeon and raid entrances, and group content: a goal's group line in the guide window ("Elite: group advised", "Dungeon: Dire Maul", "Group of 3 advised") and the guide menu's "Group" chip.
- **Rare Ember** (#ff8052, `rare`): rare NPCs.
- **Unexplored Periwinkle** (#99a8e6, `mapUnexplored`): a tint multiplied onto the game's own unexplored map art; it never carries text, so it sits outside the legibility guard.

A colour from outside the palette (item quality, quest difficulty) is moved toward the text colour until it reads at 4.5:1 on the lightest ground a name sits on (`Theme.Legible`); the raw client colour survives only as a border, such as a reward tile's quality frame.

### Brand
- **Discord Blurple** (#5865F2, `discord`): Discord's own mark, wherever Polestar links the Polestar Discord (the report window, the invite's copy window, the welcome's start page, the foot of the sidebar), as Discord's brand guidelines give it. A logo, never text, so it sits outside the legibility guard; nothing else wears it.

### Neutral
- **Deep Dusk** (#121624, `sidebar`): the sidebar and the section rail, the darkest ground.
- **Footer Dusk** (#141927, `footer`): the footer bar.
- **Dusk Navy** (#181d2d, `bg`): every window's ground, painted at the player's ground opacity (94% by default).
- **Raised Dusk** (#1c2234, `panel`): raised panels and the popup menu, at 98%.
- **Control Slate** (#232a3f, `panelAlt`): buttons, dropdowns, cards, action tiles, the selected filter segment.
- **Band Sky** (#283254, `sky`): the top of the header band; the band's mask fades it into whatever ground lies beneath.
- **Starlight** (#f7f8fd, `text`): titles, labels, goal lines, values; 15.8:1 on the window ground and never under 11.8:1, even on the sky.
- **Dim Starlight** (#c3cadd, `textDim`): subtitles, secondary lines, idle glyphs, inactive navigation; never under 7.6:1.
- **Far Starlight** (#9ba2b9, `textMuted`): counts, the version, placeholders, done goals, the least important line; never under 4.9:1.
- **White Ink** (#ffffff, `ink`): every hairline and wash is ink at a role's alpha (the `border`, `divider`, `hover`, `selected`, `track`, `progress`, `toggle`, `chip` and `watermark` tokens). Dusk and Graphite carry a little more ink than Night: hairlines 10% against 8%, selection 12% against 9%, hover 7% against 6%.
- **Star White** (#ffffff, `star`): the band's stars.
- **Shade** (#000005, `shade`): wells (the search field and checkbox at 35%, insets at 25%), text shadows, art fades.
- **Scrim** (#05080f, `scrim`): dark grounds under text and pins on zone art and the map.
- **Window Shadow** (`shadow`, shade at 60%): the one drop shadow.

### Schemes
Dusk is the default; Night is the original deep navy-black (window ground #0a0d16); Graphite is neutral slate with the faintest cool cast (#212325); EllesmereUI, offered only while it is installed, derives every ground from its panel colour by Dusk's own OKLab lightness steps (sidebar −0.03, footer −0.02, window 0, panel +0.02, controls +0.055, sky +0.09 with 1.6× chroma) and takes the rest of its ladder from Graphite. A custom ground colour is derived the same way; Brightness moves every ground's lightness by up to ±0.2; the legibility guard runs last. Status and subject colours never change between schemes.

### Named Rules
**The One Accent Rule.** Apart from the emblem, which always wears it, the accent marks only what you can act on, where you are, and the one chip that decides a choice: primary buttons, toggles that are on, selection bars, the active tab, the current goal, focus, progress. Counters stay in text (success once complete), names wear their subject colour, idle glyphs sit in textDim.

**The Floor Rule.** Primary text reads at 7:1, and secondary text, muted text and subject colours at 4.5:1, on every ground of every scheme (subject colours excepting the sky band, where only titles sit). A ground that would break it is darkened until it holds; an outside colour is lifted until it reads.

**The Tokens-Only Rule.** No colour literals: every region paints through a token (`W.Color`, `W.Painter`, `Theme.Skin`, `Theme.Band`), so a scheme, accent or brightness change repaints live without a reload. Plain white appears only to leave a texture at its own colours (the game's icons, the pin frame).

## Typography

**Default Font:** the game's own font (`STANDARD_TEXT_FONT`), so Polestar reads like the rest of the game's UI
**Optional Font:** Inter SemiBold (600), Medium (500) and Regular (400), or EllesmereUI's while following it
**Identity Lettering:** the engraved POLESTAR wordmark, cut from Cinzel and shipped only as rendered images, each drawn 1:1 for where it shows (caps 15px in the sidebar, 22px on About and the game's Settings canvas) and grown by a fraction of a pixel so its hairlines and serifs hold at sidebar size

**Character:** One neutral face in three weights, sized for arm's-length reading over a busy world; weight steps and a short size ladder carry the hierarchy, and colour names things rather than ranking them. The face is the player's choice under Appearance: the game's font (the default), Inter, or EllesmereUI's while following it; zhCN, zhTW and koKR clients always get the game's font. The weights below are Inter's; in the game's font, which has one weight, the size ladder carries the hierarchy. Sizes are UI units at scale 1 and grow with the UI scale, the menu scale and the guide window's own scale.

### Hierarchy
- **Hero** (600, 26px): shell page titles, the route choice's title, the welcome's page titles, and a dungeon page's title on its painting.
- **Display** (600, 18px): a selection's name on its painting (guide, lookup and rare details), route card names, empty-state titles.
- **Title** (600, 15px): dungeon card names, quest and boss titles in the journal, the rare alert's name, the copy and report windows' titles, the welcome's column titles.
- **Name** (600, 15px): the person or place in focus in the guide window.
- **Goal** (500, 14px): the guide window's goal lines.
- **Heading** (600, 13px): section headers, each followed by a hairline.
- **Body** (500, 13px): list and navigation rows, setting labels, card and action-tile titles.
- **Label** (500, 12px): controls: buttons, tabs, dropdown values, menu rows, the search field, the "Then:" line.
- **Note** (400, 12px): subtitles, descriptions, tips, pitches; wrapped notes add 3–4px between lines.
- **Number** (600, 12px): counters, percentages, slider values, counts, the step number.
- **Small** (500, 11px): secondary lines, guide-window tabs, filter segments, the version.
- **Caption** (600, 11px): chips and section-rail labels.

### Named Rules
**The Arm's-Length Rule.** Nothing below 11px anywhere, chips included; goal lines are 14px and white while open.

**The Engraved-Once Rule.** Cinzel exists only as the wordmark images beside the emblem. UI text is never set in it, and the wordmark is never typeset live. Its tagline, "A community project", is UI text: Small (sidebar) or Note (About) in textDim, on the wordmark's ink edge.

## Layout

Every hub and options window lays out on one grid. The options window is 960×680; the hub is 1184×680 (a 64px section rail, the 240px sidebar, then a 506px list pane and a 372px details pane). Top down: the header band (0–112), the tab band (112–152), and one hairline across every column at 152 where navigation and content begin. Left edges: 24 in the sidebar, 32 in the main column; state glyphs (done checks, quest states, kill order) sit in the gutter left of the 32 edge, so every title in a column starts on the same line.

- **Sidebar:** the lockup centred on the page title's line (centre y 47): the emblem (36px, heading the rail column, or left of the wordmark with its ink on the 24 edge where a shell has no rail), the wordmark (caps 15px, its ink on the 24 edge) and "A community project" 6px under it in Small textDim. The search under the lockup, its foot on the band's 112 line; the navigation 12px under the search; the version at the foot, level with the rail's Options label, and the release stage's chip 8px after it; at the end of that line the Polestar Discord's mark (20px in a 28px button, in its own colour, its ink on the right-hand 24 edge), the invite on a click.
- **Header:** the page title at 32/32, a muted subtitle 8px under it, at most two lines in a 32px box, the last words giving way to an ellipsis past the second; the close button 12px in from the top-right corner, the title and subtitle clear of it. The title keeps its place with or without a subtitle.
- **Tab band:** tabs from x 20, each 24px wider than its label, 4px apart, standing on the band's hairline; filter segments at the right, inset to mirror the first tab. One tab is no choice: the row goes and the body moves up, unless the band holds a filter or a status line.
- **Body:** a scrolling column (60px per wheel notch). Settings run in two columns 24px apart, as 40px rows under 44px section headers. The footer bar is 56px: reset and reload on the left, Close on the right, at the 32 inset with 8px between buttons; a shell without footer actions drops the bar.
- **Guide menu:** list rows 28px under 32px folder headers, Home cards 78px tall in two columns 10px apart, the details pane inset 24 with the zone painting ending on the 152 line.
- **Dungeon journal:** two-column cards (a 72px painting over a 40px stats line, 16px apart); quest blocks between hairlines with an 88px label column; reward tiles 200×32, 8px apart.
- **Route choice:** cards 272 wide with an 18px inset and 12px between, under a 112px header and over a 56px footer; stat rows, chips, rules and bullets align across cards.
- **Guide window:** 340 wide by default (260–560 by its grip), 14px inset; a 28px tab strip, a 34px navigator, goal rows from 24px with 15px glyphs at x 14 and text at 39, a 26px progress footer.
- **Route planner:** a browser page, not a game window, so it keeps its own lines rather than the 112 and 152: a 56px top bar, a 56px transport bar, and between them three panes: the 340px steps pane on the sidebar ground, the map edge to edge, and a 340px pane on the window ground (the character sheet, or the step editor while editing), each split from the map by a hairline and headed by a 44px row (Heading, its count in Number textMuted). Text sits 16px in from the left. It is laid out for desktop browsers from 1280px wide: the panes keep their width and the map takes the rest; there is no phone layout.
- **Scale, not breakpoints:** windows are fixed sizes that scale with the UI scale and the Menu scale setting; labels truncate against their control, so longer localised strings never push the grid.

### Named Rules
**The Shared Line Rule.** Every pane of a shell meets the same lines: the 112 band edge, the 152 hairline, the 24 and 32 left edges. A new section lays out on them, never beside them.

**The Row Rule.** A setting is one 40px row: label left, control 12px from the right edge, a faint hairline beneath, its description in the row's tooltip, and right-click to restore the default.

## Elevation & Depth

Depth is tonal first. Grounds step up in OKLab lightness (sidebar, footer, window, raised panel, control, sky), so the sidebar recedes and a button stands forward without a shadow. Only windows cast one: a soft nine-sliced shade that spreads 16px and drops 4px, scaled with the ground's opacity. The popup menu lifts by one ground step and a hairline; cards and tiles sit on the control ground with a hairline. Text shadows serve legibility over the game world, never depth.

### Shadow Vocabulary
- **Window shadow** (`box-shadow: 0 4px 24px rgba(0, 0, 5, 0.6)`, the CSS reading of the Media/UI/shadow nine-slice: 16px spread, 4px drop, shade at 60% × the ground opacity + 10%): every top-level window and the rare alert; it goes with the ground in transparent mode.
- **Text shadow** (`text-shadow: 1px 1px 0 rgba(0, 0, 5, 0.6)`): every string, the game's own 1px font shadow, in shade, except dark ink on an accent fill (a primary button's label), which takes none: under dark glyphs on a light ground it smears.
- **Text on art** (`text-shadow: 0 1px 0 rgba(0, 0, 5, 0.85)`): names on zone paintings and in the rare alert's band.
- **Text on the world** (an outline plus `text-shadow: 1px 1px 0 rgb(0, 0, 5)`, 80% for the arrow): the transparent guide window, coordinates, flight timers, the waypoint arrow.

Glows are light, not depth: a soft additive halo around the guiding marks, in their own colour.

### Named Rules
**The Windows-Only Shadow Rule.** A shadow means "this is a window over the game". Panels, menus, cards and chips never cast one; they lift by tone and hairline. The player may turn the window shadow off (`ui.shadow`, Appearance > Windows); nothing else ever gains one.

**The Player's Frame Rule.** The house look is the default; the player may override it, live, under Appearance > Windows, each setting reset by a right-click: the window border on or off (`ui.border`), its colour (the scheme's hairline, the accent at 80% via `ui.borderAccent`, or their own `ui.borderColor`; the `windowBorder` token) and thickness (`ui.borderSize`, 1–4 physical pixels, growing outward so no child covers it), the starlit band (`ui.band`) and the shadow (`ui.shadow`). These paint every window the same (options, hub, guide window, rare alert, route choice, welcome, copy window, report window); no setting here carries text, so none needs the legibility guard.

**The Starlight Rule.** Only the guiding marks glow: the emblem on About (12% of the accent) and the empty state's glyph (16% of its colour), the waypoint arrow (45%) and its arrival halo, and the waypoint's map pin (50%). Panels, buttons and cards never glow.

**The Starlit Band Rule.** Every window opens under the night-sky band (transparent mode aside, which draws no ground, and unless the player turned the band off: then the header sits on the plain ground): the scheme's sky tinting a mask that fades out by 108px, scattered stars thinning downward, one faint constellation toward the right, clear of the title. It is drawn at 1024×128, 1:1, and cropped, never stretched. The band that stands in for missing zone art always stays.

## Shapes

Square-cornered rectangles everywhere, edged by 1px hairlines snapped to the physical pixel at any UI scale. The only curves are capsules (two half circles and a middle) for chips (20px tall) and toggle tracks (30×16), and circles for toggle knobs and slider thumbs (12px) and map-pin discs. Markers are bars, not boxes: a 2px accent bar for selection and position, a 2px underline for the active tab, 2–3px progress lines. Zone paintings are rectangular crops with a 40px shade along the top and a fade over the bottom 62% into the ground.

The identity shape is the Polestar emblem: a four-point guiding star whose long north and south rays break through a fine ring, short east and west rays inside it. It appears in the accent at 36px at the head of the rail (or beside the wordmark), at 64px on About (48px on the game's Settings canvas), 56px in the welcome's lockup, and 36px in the guide window's empty state, on the route choice and on the welcome's later pages (each in its glow where noted), as a hollow double-ring engraving at 2.8% ink behind empty states only, and as the four-point mark at the centre of map pins. The emblem, wordmark and tagline always travel together as one lockup: the wordmark and tagline stacked, centred on the emblem.

Icons come from one authored family drawn in code: filled silhouettes and round-capped strokes on a 24-unit grid, stroke 2.25, rendered white at 32px and tinted at runtime. Every goal verb has its glyph (accept "!", turn in "?", kill, collect, go to, talk, …), the controls share the same hand (check, close, chevrons, search, menu, sliders, the bug that reports a problem), and an unknown verb falls back to the note glyph, never a missing texture. Every texture is drawn in code (tools/media) at a power-of-two size: glyphs at 32px, the band at 1024×128, the shadow at 64px. No third-party art ships but one mark: zone paintings are read from the player's own client, the wordmark ships as an image, not the font, and Discord's logo, only ever beside the link to the Polestar Discord, is Discord's symbol as Discord publishes it, scaled whole and filled in its own colour.

### Named Rules
**The Square-and-Capsule Rule.** Rectangles are square. Only chips and toggle tracks are capsules, and only knobs, thumbs and pin discs are circles; nothing else is rounded.

## Components

### Buttons
- **Shape:** square, 28px tall (32 on route cards), at least 72px wide: the label plus 16px each side, an optional 13px glyph 6px before the label.
- **Default:** the control ground with a hairline border, the label in text.
- **Primary:** an accent fill with an accent border, label and glyph in onAccent; one per view ("Load guide", "Continue", "Guide me", "Set waypoint", the recommended route).
- **Ghost:** no fill or border, only the hover wash ("Decide later").
- **Hover / Press:** the hover wash laid over the fill; on press the label nudges down 1px, like a key going in.
- **Disabled:** a button fades to 50%, a setting row to 45%, an icon button's glyph to 35%.
- **Confirm:** a consequential action arms on the first click ("Click again to confirm", in danger) and acts only on a second click within 3 seconds.
- **Icon buttons:** a 16–28px hit area with the glyph at 60% of it unless set (the shell's close: 14px in 28px), textDim at rest, text under the cursor, the accent while "on"; the glyph nudges 1px on press too.
- **Action tiles:** 60px tall on the control ground, an 18px glyph at 16 in the accent (danger for "Reset all settings"), a Body title and one Small line in textMuted; for consequential actions only.

### Links
- **Style:** an address shown as text, never in a field: Label (or Note) in the accent, no box, a 20px hit area hugging the text (`W.Link`).
- **Hover:** the label turns from the accent to the text colour, over a 1px accent underline 2px below it; the tooltip says "Click to copy".
- **Click:** the game cannot open links, so a link opens the copy window (`PolestarCopy`) with the address selected, ready to copy.

### Chips
- **Style:** a 20px capsule, Caption text, 9px each side.
- **Kinds:** neutral (the chip wash, textDim text); accent (the accent at 16%, accent text) for the one fact that decides a choice: a guide's level range, "Your level", "Recommended"; success (success at 14%) for "Done", "Ready to turn in" and "Your current route"; warning (warning at 14%) for the release stage ("BETA") after the version, set in one place (`ns.stage`) and gone once there is none.
- **Use:** only where true: never a zero count, never a filler tag.

### Cards / Containers
- **Corner Style:** square.
- **Background:** the control ground with a hairline and the hover wash; zone-art cards carry the painting on top, inset 1px, the name in Display or Title on its fade.
- **Shadow Strategy:** none; see Elevation & Depth.
- **Selection:** a 1px accent hairline: along the top edge of a selected Home card; all round the recommended route, 90% along the top and 45% on the other edges.
- **Internal Padding:** 18px on route cards; text on the 32 edge in panes.
- **Never nested:** a card is one whole option (an open guide, a route, a dungeon), never a wrapper for sections.

### Inputs / Fields
- **Search:** 30px tall, a shade well (35%) with a hairline border, a 13px search glyph and the placeholder in textMuted, text inset 30px left and 26px right, a clear button once there is text. **Focus:** the border lights in the accent at 80%.
- **Copy box:** the search field's well and border without the glyph: 30px tall (multi-line: 16px a line plus 16), Label text inset 10px. Read-only: it selects its text when focused or clicked, and typing puts the text back. Reports and positions meant for copying sit in one, inside the copy window; an address in a page is a link (see Links).
- **Text area:** the copy box's well and border, editable (the report's "What went wrong?": three lines, 250 letters at most), its placeholder in textMuted until something is typed; focus lights the border as in the search field. Escape leaves it; Tab moves on to the report.
- **Toggle:** a 30×16 capsule 12px from the row's edge. Off: the toggle wash with a textDim knob; on: the accent with an onAccent knob. The 12px knob slides in 120ms, ease-out.
- **Switch:** the toggle's capsule and knob on their own (`W.Switch`), 24px tall, for state that is not a setting: a community addon shown or hidden on the Community guides page. A click flips it; its tooltip says what it does.
- **Slider:** a 112px, 2px track in the track wash with an accent fill and a 12px round thumb in text; the value right of it (Number, textDim, 44px wide); the wheel steps it; right-click restores the default.
- **Dropdown:** a 150×28 button on the control ground, the value in Label text, a 12px chevron in textDim; its choices open in the shared menu with an accent check on the current one.
- **Colour swatch:** a 34×18 chip with a 2px inset fill and a swatch-wash border; while no own value is set, where the colour comes from ("Dusk", "EllesmereUI") sits left of it in Small textMuted; right-click restores.
- **Checkbox:** a 14px shade well (35%) with a box-wash border and a 12px accent check.
- **Disabled:** the whole row fades to 45%.

### Navigation
- **Section rail:** 64px on the sidebar ground; 56px buttons of an 18px glyph over a Caption label in textDim, the first level with the sidebar's first row, Options at the foot. Active: the selection wash, a 2px accent bar at the window's edge, the glyph in the accent, the label in text.
- **Sidebar rows:** 40px; a 16px glyph at 24, the Body label 12px after it, the count (Number, textMuted) right at 24. Active: the selection wash, a 2px accent bar at the left, the glyph in the accent, the label in text. A row with nothing in it recedes (textMuted at 55%, no count) but stays reachable. A row that needs the player's attention carries a 6px warning dot at the right edge in place of the count (Options > Community guides while a community addon has problems). A heading row (the guide menu's "Community guides") is a muted label at the text edge with no glyph: it names the rows after it and is not a choice.
- **Shell tabs:** 40px, Label text in textDim; active in text over a 2px accent underline; the hover wash under the cursor.
- **Filter segments:** 24px buttons at the right of the tab row, 10px each side of a Small label in textMuted, 2px apart; the selected one on the control ground in text.
- **Guide-window tabs:** 28px, a 12px category glyph, a Small label and the guide's level range after it in parentheses, as the guide menu's rows ("The Barrens (19–24)"; none for a guide without levels). Active: the hover wash, a 2px accent underline, the accent glyph, a text label with its range in textDim, and the room to read its title (up to 150px); the rest textMuted, range included. A narrow tab truncates its title, never its range (the range tells same-named guides apart); a tab too narrow for its range shows its glyph alone. A tab's close appears only under the cursor, the label making room for it; six tabs at most.
- **Popup menu:** one shared menu on the raised ground with a hairline: 26px rows (a 14px glyph at 10, Label text at 32), 9px separators, a 12px accent check on the current choice. It grows out of its trigger with a 120ms fade and a 4px drop, and closes on any outside click or Escape.
- **Scrollbar:** a 2px thumb in the thumb wash on a 6px strip, 4px wide under the cursor, at least 24px tall.

### The Starlit Header Band
112px across the main column: the band, the page title in Hero at 32/32, the subtitle in Note textDim (two lines at most), the close in the corner. On a dungeon page the zone painting fills the band and the title sits on it with a back chevron in the gutter; the rare alert carries a 64px band with its glyph ring, name and facts.

### The Guide Window
A compact instrument read at a glance. From the top: the tab strip; a slim navigator (prev, the step number, next, Skip, the bug, menu): prev and next only look at another step, Skip (the 11px skip glyph and a Small label in textDim, a ghost button left of the bug) moves on for good, and the bug (an icon button left of the menu, there while a guide is open) opens the report window on the step on screen; an optional banner (a step just skipped with its Undo, a skipped step on screen with "Unskip it", a step looked at with "Back to step N", …); then one focus: the person to talk to now (or the object, or a field step's place) with its verb glyph in textDim and its name in Name type (npc, object, or text for a place), the zone under it in Small textDim, and only their goals: one 14px line each with a 15px verb glyph, the counter right after the text ("Kill Kobold Vermin 7/10") in text, success once complete; every goal but a note carries its 18px tick box at the row's right edge (tick it done, tick again to undo; a goal the game counts itself shows its check at 45%); an optional goal's line ends in "optional" in warning, so an extra is unmistakable and never reads as the route, with a Small "Skip" link in textDim beside its tick ("Undo" once skipped, the line then ending in "skipped" in textMuted under the skip glyph). One thing to do is one line: a quest started by an item is its accept, with how to get the item under it ("Runed Scroll: kill Aean Swiftriver (rare elite)"), and a field step's "Go to" its own place is the header, not a row. The current goal alone takes the accent glyph, and it is where the arrow leads (the header only once nothing else is open); the goal or person the arrow points at carries a 2px accent mark at the row's edge; done goals check in success and dim to textMuted, the check landing with a short back-out pop. A "Then: …" line names the next person in their colour, "Person 2 of 8" counts them, and a 3px progress bar with its percent closes the window. Tips collapse to one line.
- **Standard:** the window ground at the player's opacity, a hairline, the shadow, the band behind the tab strip and navigator.
- **Transparent:** no fills, borders or shadow; every string outlined; the progress track stays as a faint 15% ink line; the chrome (tabs, navigator, grip) shows only while the cursor is over the window, fading in at 120ms and out at 180ms.
- **Combat:** stays as it is by default (a fade on every pull reads as blinking while questing); fades to 35% or hides, by setting.
- **Journey:** while the travel route has more than one leg, right under the focus it leads to (the way to this person, before "Then:" names the next): a 30px header like Up next's, "Journey" in Small textMuted with the remaining time (Number, text) and distance (Number, textDim) at the right before its chevron, folding the rest away on a click; "To" and the destination in its place colour on the goal text edge; then a 24px row per leg (38 with a departure line in Small textDim), its number in the gutter, a 13px glyph of the leg or the chokepoint it ends at, the caption truncating against a fixed time column. The current leg alone wears the accent glyph and the 2px selection bar, its caption and time in text; later legs sit in textDim and textMuted. A lone walk shows nothing: the arrow already gives its distance and time. Times tick without moving anything.

### Zone Art
A zone's own world-map painting, drawn from the player's client, 20% desaturated so it sits in the night palette, zoomed past the whole map and framed around a place; a 40px shade along the top for chips and buttons, a fade over the bottom 62% into the ground. Where the art is missing, a stretch of the starlit band stands in.

### The Rare Alert
368px wide: a 64px band with the kind's glyph in a 36px ring (rare ember, or object parchment for treasures), the name in Title and one Small line of facts, then "Set waypoint" (primary) and "Show rare" or "Show treasure". Its one authored moment: it settles in 18px from above over 300ms as it fades up over 200ms. A 2px accent hairline drains while it waits and holds while the cursor is on it.

### The Transport Alert
The rare alert's quieter sibling, with no band and no buttons: a 320 × 56 window (the window skin, so it follows the Player's Frame Rule), 72px from the top of the screen, the transport's glyph (`icon-boat`) in a 32px ring in the place colour, what is coming in Title text ("Boat to Menethil Harbor", "Arriving at Booty Bay") and a live countdown in Small textDim ("Arrives in 0:28"). A 2px accent hairline drains to the arrival; it fades in over 120ms, never slides, and leaves six seconds after the arrival or on a click. Its sound is the game's own for that transport, never an alert chime.

### The Welcome
A window 560 wide, centred on the screen, once per new character (`PolestarCharDB.welcomeSeen`, the welcome's version; characters Polestar already knew are marked seen without it), and the surface where Polestar is most expressive. It takes the height of its tallest page, so it never jumps; a shorter page sits in the room that leaves, a little above centre. Every page opens under a 176px hero: the starlit band at 1:1 over its top 128px, the ✕ 12px in from the corner (on a scrim disc over a painting), dragged by the hero. Over the band, the Little Dipper drawn in code: seven stars (a small core in a soft halo, 30–80% ink by magnitude) joined by 1px hairlines at 16% ink that stop short of each star, turned half a night so its handle leads down to Polaris, and Polaris is the page's emblem. It is decoration only, never a control. Four pages on the account's first character, two for later ones (setup and route are left out while `PolestarDB.welcomeSeen` is set; About and `/polestar welcome` show all four): **welcome**: the lockup in the hero (the 56px emblem in its glow as Polaris, the wordmark and "Leveling guides for World of Warcraft: Forever" in Note textDim stacked 20px after its ink and centred on it); on the 32 edge "Hello, <name>" in Hero ("Welcome to Polestar" without a name), one Body line in textDim on what Polestar does, then three columns 24px apart split by hairlines (the guide window, the arrow, every guide), each a 20px accent glyph, a Title and two Small lines in textMuted. **setup**: "Make it yours" in Hero and a Note subtitle low on the hero's 32 edge, the 36px emblem and the Dipper on its right; the two switches as toggle rows with their description inline in Small textMuted (label and switch on the page's edges), then "Colour scheme" (Heading) and a Small line in textMuted on what the schemes are, with one swatch card per scheme on offer: a small window in that scheme's grounds (sky, sidebar with its selection bar, text lines, a control and the accent button) over its name, the selected one edged by a 1px accent hairline all round; a click applies it live, right-click restores the default. **route**: "Route style" in Hero and a Note subtitle (how the arrow walks you, changed any time in Options) low on the hero's 32 edge, the 36px go-to glyph (the welcome page's arrow) in its glow as Polaris and the Dipper on its right; three cards 12px apart, Fastest, Balanced and Roads, each its name in Label over what the style does in Note textMuted on the panelAlt ground, all as tall as the tallest and edged like the scheme cards (the chosen one by a 1px accent hairline all round), Balanced's "Recommended" accent chip riding its top edge 12px in from the right; a click sets the style live, right-click puts Balanced back; 20px under them, a Note line in textDim on what every style keeps you away from. **start**: the suggested guide's zone painting fills the hero (the band stands in, with the emblem and the Dipper, when there is no art), its title in Hero on the fade and under it the level range as an accent chip and "Your first guide, for your level 4 Human Warrior" in Note textDim (what is unknown left out); without a suggestion, "Choose your first guide" and why. Below, the guide's pitch in Body textDim, then notes under hairlines, each a Heading and Note text: the beta callout with the warning chip while `ns.routesBeta` is set (how the routes were tested, and to skip a wrong step and tell us on Discord); "Join us on Discord" led by the 16px Discord mark in its own colour (8px before the heading, on its line), with "Feedback, bug reports and news" in Small textMuted and the invite as a link at the right (`discord.gg/…`, the scheme left off), which opens the copy window; what community guides are and where to learn more. The footer bar: the step dots centred (the current page a 16×4 accent capsule, the others 4px textMuted dots; moved into the room between the buttons only when these would come within 16px), Skip (ghost) on the left and Back and Next (primary) on the right; on the last page Back takes Skip's place and "Browse guides" and "Start guide" (primary; "Choose a guide" without a suggestion) hold the right. Motion: the window fades in; the hero settles 8px up as it fades in (180ms, ease-out); a page change cross-fades the hero and the page (120ms) while the current dot grows. It never opens in combat, during a cinematic or over the route choice (it steps aside for one and comes back on its page); Escape, the ✕, Skip and both guide buttons close it and mark the character and the account seen.

### The Copy Window
A small window, 360 wide, named `PolestarCopy`, on the dialog strata: a 56px band with the title in Title and the ✕ (14px in 28px), then on the 24 edge one Note line in textDim saying how to copy it ("Selected for you: copy it with Ctrl+C (Cmd+C on a Mac), then press Escape."), 12px under the band, and 10px under it a copy box (multi-line when the text is) holding the text, selected and focused when it opens. Dragged by its band; Escape or the ✕ closes it. It holds text meant for pasting elsewhere: `/polestar where`'s guide lines, and the Polestar Discord's invite, which carries Discord's mark before the title (28px, in its own colour) and its own Note line saying what the Discord is for.

### The Report Window
440 wide, named `PolestarReport`, on the dialog strata; the guide window's bug, its menu's "Report a problem" and `/polestar report` open it. The 56px band with "Report a problem" in Title and the ✕; on the 24 edge, 12px under the band, what the report is about in Note textDim on one line ("Step 3 of 8 · Kobold Camp · Elwynn Forest"); "What went wrong?" (Label) over a three-line text area, focused as the window opens; "Your report" (Label) with "Select report" (the view's one primary) at the right of its row, over a read-only copy box in Small as tall as the report, so it is read whole before it is copied; a hairline, then Discord's mark (32px, in its own colour) beside "Polestar on Discord" (Heading), a Note line in textDim (copy the report, switch to Discord and paste it; not in the server yet, get the invite once) and "Get the invite" (default) on the text's edge, which opens the invite in the copy window. The report is the window's only text to copy: the game opens no links, so a member copies once and a newcomer fetches the invite once. 16px above each label, 6–8px under it. Dragged by its band; Escape leaves a field, then closes the window. The report itself is in docs/ARCHITECTURE.md ("Reporting a problem").

### About
One column on the 32 edge, top down: the hero (the 64px emblem in its glow, the 22px-cap wordmark, "A community project · Leveling guides for World of Warcraft: Forever." in Note textDim, the version in Small textMuted with the release stage's chip); "Why Polestar", the manifesto, as Body paragraphs in textDim (free and open source under the GPL-3.0 rather than paywalled; not claiming to be the fastest or smoothest guide, a free alternative that gets better with time, the one paragraph in text so it stands out; built and shaped by its community; still in beta while `ns.stage` is set), then its closing line apart in Title and text, never the accent; then Commands in Note textDim, a "Show the welcome again" button (default) under the commands it introduces, Credits in Note textDim, and Maintenance as two action tiles.

### Map Pins and the Waypoint Arrow
Pins put a glyph in its kind's colour on a dark scrim disc (kill in danger, collect and vendor in item, interact in place, turn-in and available in quest; 16px on the world map, 14 on the minimap; turn-ins 18 and 16). The current guide step's quests grow 1.3× inside an accent ring; with "dim others" on, the rest recede to 60%; spawn areas are soft discs at 32%. A guide step's spawn regions cover every place its mobs or objects spawn: each region the stretch a goal's camps share (up to 700 yards across), a 20% fill inside a 70% outline 1.5px wide, so it reads at world map scale and never hides under a pin; the arrow's goal's in the arrow's colour on the world map and the minimap (cut at the minimap's rim), a region of only its other places at 60%; the step's other goals' in place at 60% (35% for other places), on the world map only, so the minimap stays about where the arrow leads. The arrow turns toward its target in its far colour (`arrow`: the accent unless the player picked their own, `nav.arrowColor`) and shifts to its near colour (`arrowNear`: success unless `nav.arrowNearColor`) over the last 250 yards, then becomes a pulsing ring in the near colour; the waypoint's map pin and the travel route's stops wear the far colour. Its distance and ETA are outlined text with an 80% shade shadow; text in a chosen colour uses its legible form (`arrowText`, `arrowNearText`: lifted toward the text colour until it reads at 4.5:1, as `Theme.Legible` does), the arrow itself keeps the colour as picked. The arrow is always movable: drag it anywhere.

Where the game gives no position (the Deeprun Tram), the arrow never vanishes: on a ride it keeps the leg's glyph and caption, otherwise its dial gives way to "No position here" in textDim over the label, and it points again the moment a position returns.

On a Hearthstone or teleport leg a travel button sits 6px under the arrow's foot: the quest buttons' 36px tile (panel ground, inset icon, hairline turning accent on hover, the game's cooldown sweep), with no label because the arrow's caption already says what it does. Right-clicking the arrow or the tile opens the menu with one row: "Skip this leg" on a Hearthstone, teleport, flight, ride or portal (the rest of the trip is planned without it), "Mark this leg done" on a walk or a lift. There is no compass strip: the arrow is the one bearing instrument, and a second one along the top of the screen would only repeat it.

### Quest Reward Marks
On the game's own reward panel (the quest giver's detail and reward pages and the quest log), Polestar marks the choices on their item icons and never over their names, with no words. Every choice that is an upgrade for the player's spec carries the up arrow (`qol-upgrade`, success) in the icon's top-left corner, where the client puts its own bag upgrade arrow: a 20px badge whose tip lands on the icon's corner. The reward to take, the one auto-pick would choose, is framed: a 2px accent frame just outside the icon, clear of the client's quality border, on a 1px shade keyline so it holds on the parchment and on dark skins. The one that sells for most takes the coin (`qol-coin`, accent) in the icon's top-right corner, beside any upgrade arrow; when no choice is an upgrade it is also the one framed. Both badges are glyphs on a 70% shade rim drawn into the texture, so they read on any icon. The percentage is on the tooltip, never the panel ("+12% upgrade · Head").

### The Route Planner
A page in a desktop browser (`node tools/polestar.js planner`) that plays a guide's route on the game's map for guide authors, and edits it in place. It is the addon's world laid flat: the same grounds, accent, subject colours, Inter weights, hairlines and glyph family, every colour a CSS custom property named after its Theme token (`--panelAlt` is `panelAlt`), which the map renderer reads once as it starts. It offers no scheme, accent or font choice: Dusk, Polestar gold and Inter. Every string carries the game's 1px text shadow, numbers are tabular, and nothing it shows from the game ships.
- **Top bar:** 56px on the window ground under the starlit band at 1:1, cropped to the bar. The 28px emblem in the accent and "Planner" in Title, a hairline divider, Library (ghost), the pack in Body textDim, a chevron and the guide in Title, undo and redo; at the right Playback and Edit as 28px filter segments, the character (its class and race icons, name, side and start level on a 32px shade well), the connection dot (6px, success or danger), Changes (ghost) and Compile, the page's one primary.
- **Steps pane:** a legend of the time split, then each guide's header (56px on the window ground, pinned to the top of the list while its steps scroll: the title in Heading with its level range on an accent chip, its time and level span in Small textMuted, the next guide at the right in textDim). Each step is a row: its start time (Number textMuted, 46px), its number (Number textMuted; the accent when selected), the title in Body, and its time (Number textDim; warning when it rests on an estimate) over a 40×2px bar split into travel (npc), combat (danger), interact (place) and wait (textMuted). Under it one 20px Label line per goal at a 60px indent: its icon, the verb in textDim, the name in its subject colour; a skipped goal is struck through at 60%; then "N more" and a kill summary in Small textMuted. Selected: the selection wash and the 2px accent bar at the left. A step that does not apply to the character fades to 45%; diagnostics show as a warning glyph and a count, in danger when one is an error.
- **Icons:** two families (see The Two Families Rule). Glyphs are CSS masks painted in the current colour. Game icons are square in a 1px hairline frame on the inset well, read from the author's own client and cached locally, never committed or shipped (THIRD_PARTY.md), as zone paintings are.
- **Character sheet:** the level in Hero with the XP in Number textDim, a 2px accent XP bar, fact rows (32px, the label in textDim at the left, the value at the right, a hairline under each; a place in its place colour), then collapsible sections under 44px Heading rows with a chevron: the quest log (quest names in quest gold with the "!" or "?" icon, objectives in textMuted, "Ready" in success; a quest that changed flashes the accent wash once), quest items (item lilac, the count in Number) and flight paths.
- **Step editor:** the right pane in Edit. Step fields are 40px rows: a 64px label column in Label textDim, borderless inputs with a hairline under them; focus puts the shade well under the field and lights its hairline in the accent at 80%. Goals are cards on the control ground with a hairline: a 36px head (the goal's icon at 18px, the verb as a quiet dropdown, its source line, small icon buttons to locate, move, insert and delete), fields in a 72px label column, and the goal's source line in the system monospace on the inset well, the one place the page shows code. A selected card's border is the accent at 80%, a card with an error the danger colour. Diagnostics are rows of a status glyph, the line number and the message.
- **Map:** the centre pane, edge to edge on the sea (the art's own filler, else the sidebar ground). Its controls float over it: a 44px head row on a scrim fade (70% to nothing) whose dropdowns and ghost buttons sit on the scrim at 55%; a zoom stack of 30px buttons on the raised ground at 94% with a hairline; a 36px activity banner of the same make, centred 16px above the foot, saying in one line what is happening now with its icon and the one action that fits it; the route legend at the bottom left.
- **Route lines:** walking is a solid line: the current leg 4.5px in the accent over a shade casing, past legs 2.5px in textDim at 40%, the legs ahead 2px in textDim at 50%, dashed 6 on and 5 off. Flights are short dashes in spell cyan (4 on, 5 off), boats long dashes in NPC sky (18 on, 6 off), each brighter on the current leg. The search between spawns inside a kill or collect area is thinner and fainter still: it is not a leg of the route. Teleports draw no line.
- **Pins:** a 24px scrim disc holding the goal's game icon (a square icon in a circle mask, a cut-out client mark whole) or the verb's glyph in its subject colour. The current goal's pin grows 1.3× (31px) inside a 2px accent ring on a 2.5px scrim rim at 85%, so it holds on light terrain, with the Starlight glow (the accent at 50%); done goals recede to 60% and lose most of their colour. Kill and collect areas are discs in the subject colour (32% fill, 55% edge), spawn points 6px dots in it, go-to and explore radii a dashed accent ring at 80%. The character is the Polestar arrow, 40px in the accent over its glow, turned to its heading.
- **Map labels:** the current goal's name in a pill (the raised ground, a hairline, Label text). Zone names in Caption, upper case and letter-spaced 0.12em, on the text-on-art shadow; continents 13px at 0.2em in textDim. That lettering belongs to the map and never labels a heading. Labels are placed greedily, the current one first, and never cover a pin, another label or the map's controls; one that fits nowhere is left out.
- **Handles (Edit):** each located goal is a 15px disc in its subject colour with a 2px ink edge (18px with an accent edge under the cursor; hollow, on the scrim at 55%, where the place is implied rather than written), dragged to move it; a radius shows as an ink ring at 80% that drags too, in the accent under the cursor. A drag writes the .guide file.
- **Transport bar:** 56px on the footer ground: play (a 32px button on the control ground, its glyph in the accent), previous and next step, the clock (Number, the total in textMuted), the scrubber, the speed (a 72px dropdown) and the route's totals in Small textMuted, the estimated steps in warning. The scrubber is a 40px hit area over a 2px track wash with an accent fill and a 12px thumb in text that grows 1.15× under the cursor; 1×6px ticks mark guide bounds (hairline) and level-ups (quest gold at 45%); its tooltip is Small on the raised ground with a hairline.
- **Windows over the page:** the library (the guide menu: a 380px list on the sidebar ground beside the guide's details under a 216px zone painting), the Changes drawer (400px, from the right) and toasts (the raised ground, a status glyph) cast the window shadow and come in over 180ms; the library dims the page behind it with the scrim at 55%. Popovers and menus lift by tone and hairline only, as in the addon.

### Gamepad
Ported from Ding! by Yendi (@moust4ki). With a gamepad, the window that holds it marks one widget as focused: the mouse's hover wash, held, under a 2px accent ring at 90% just inside the widget's edges (the focus the One Accent Rule names), on setting rows, buttons, list rows and goal lines alike. Buttons are chips (`G.Glyph`): a 20px circle for a face button (Xbox's letter in Caption, PlayStation's shape drawn in the glyph family: cross, circle, square, triangle) and for a D-pad direction (the chevron), a 20px capsule 7px each side for the rest ("LB", "RT", "Ctrl"), "+" in Small textDim between the buttons of a combination; the chip wash, the name in text, never the accent. The hint bar sits 8px under the window, on the panel ground with a hairline: chip, 6px, the action in Small textDim, 16px to the next, wrapping to the window's width (300 at least) rather than leaving one out. It lists only what no button on screen shows: the D-pad, A, X and Y on the focused widget, LB / RB; B sits as a chip 4px left of the window's close button instead. A binding row carries its key as chips at the right edge, "Not bound" in Small textMuted, "Press a button…" in the accent while it waits, who else has a key in danger. Without a gamepad none of it shows, and the words speak of the mouse and the keyboard.

### Motion
Three durations: 120ms for shells opening, menus, page changes, toggles and chrome appearing; 180ms for content changing in place and the route choice opening; 200ms for progress fills and the combat fade. A strong (quartic) ease-out for anything entering or answering the player, and a small back-out pop for a check landing. Options pages fade in without moving; the next person slides up 6px as it fades in; the rare alert settles 18px from above. Reduced motion snaps every movement (offset, size, scale, width) and keeps fades at 60% of their length. Nothing runs per frame unless something is moving.

### Named Rules
**The Selection Bar Rule.** A 2px accent bar at an edge marks the one selected or current thing: the active rail section and sidebar row (left edge), the active tab (underline), the selected list row, the goal or person the arrow points at. It is never decoration.

**The Two Families Rule.** On the planner page, controls and verbs wear the authored glyphs and things wear the game's own icons: a goal shows the icon of what it is about (the quest marker, the item, the spell, the class), the character its class and race. Where the game has no icon for it (a kill, a place) or the icon is missing, the verb's glyph stands in, in the subject colour; a game icon never marks a control.

## Do's and Don'ts

### Do:
- **Do** paint every colour through a Theme token (`W.Color`, `W.Painter`, `Theme.Skin`, `Theme.Band`) so schemes, accents and brightness repaint live.
- **Do** keep the accent for action and position (primary buttons, toggles that are on, the 2px selection bar, the active tab, the current goal, focused fields, progress fills) and for the one chip that decides a choice.
- **Do** colour a thing's name by its kind (npc, quest, item, place…) and leave verbs and counters in text.
- **Do** lift any colour from outside the palette with `Theme.Legible` before it carries text.
- **Do** lay every new section on the shell grid: the 112 band, the 152 hairline, the 24 and 32 edges, state glyphs in the gutter.
- **Do** build settings as 40px label-left, control-right rows, two columns to a page, with the description in the row's tooltip and right-click to reset.
- **Do** draw new icons into the glyph family (24-unit grid, 2.25 stroke, white at 32px, tinted at runtime) and new art in code at power-of-two sizes.
- **Do** show the emblem watermark (2.8% ink) only behind an empty state.
- **Do** nudge a pressed button's label or an icon button's glyph down 1px, open popups from their trigger with a 120ms fade and a 4px drop, and honour reduced motion.

### Don't:
- **Don't** ship a light scheme: transparent mode and the arrow put text on the game world, and the band has no daylight form.
- **Don't** fall back to the stock addon look: settings grouped in bordered grey boxes or stacked one per full-width row, or eyebrow labels above headings; a section is a heading and its hairline.
- **Don't** write a colour literal; plain white that leaves a texture at its own colours (the game's icons, the pin frame) is the only exception.
- **Don't** put the accent on counters, names or decoration, and don't use the accent bar as a stripe on cards, callouts or banners.
- **Don't** set text below 11px, or in Cinzel.
- **Don't** stretch the starfield band; crop it at 1:1.
- **Don't** give panels, menus, cards or chips a drop shadow or a glow; only windows cast a shadow, and only the guiding marks glow.
- **Don't** show a tab row for a single tab unless it holds a filter or a status line, or a footer bar without actions.
- **Don't** stand Unicode characters or emoji in for icons, and don't ship third-party art; Discord's mark beside the link to the Polestar Discord is the one exception, as Discord publishes it.
- **Don't** apply EllesmereUI's frame art; read only its accent, panel colour and font through its skinning API.
