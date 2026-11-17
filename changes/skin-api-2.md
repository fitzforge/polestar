---
section: contributors
---
- Skin API 2: layouts, the guide window's structure apart from its look.
  `Theme.RegisterLayout(id, spec)` takes the structure hooks (`guideLayout`,
  `guideRender`, `guidePlace`, `guideAnchor`, `guideTakes`, `guidePerson`,
  `guideInset`, `guideUpRow`, `guideShows`, `guideSpace`, and `guideTitle`,
  `guideRow` and `guideProgress`) and sits under any skin: the layout's hook
  answers first, then the skin's, then Polestar's own. The choice is
  `ui.layout` (`Theme.SetLayout(id)`; unset is Polestar's own layout). A
  `Polestar_Layout_<Name>` addon names its layouts with
  `## X-Polestar-Layout`, may load on demand, and is left out of the install
  check's version warning. Capability `layouts`. No layout is in use until a
  player picks one.
- Skin API 2: a layout gives defaults for any of Polestar's settings but
  `ui.layout` and `ui.skin` (`defaults = { ["guideWindow.tabs"] = false, ... }`)
  instead of hiding parts the player can set. A setting reads the player's
  value, then the layout's default, then Polestar's; a reset goes back to the
  layout's default.
- Skin API 2: a layout can put its own card in the guide window's Presets
  (`preset = { label, help, set }`, capability `layouts.preset`). Picking it
  chooses the layout, loading its addon. A guide window copy draws with a
  layout of its own (`Theme.SkinHookFor`, `Theme.SkinHookValueFor`), and a
  layout's `onLeave(id, parts, live)` runs once for each guide window it
  dressed, the settings preview too.
- Skin API 2: new guide window hooks for skins and layouts: `guideTakes` (a
  goal shown on a card of its own), `guidePerson` (the step's header, laid
  out and sized), `guideInset` (the step's card and Up next set in from the
  left edge), `guideUpRow` (each Up next row), `guideSpace` (a gap or height
  of the window's layout: Up next's rows, the tip's room, the XP row) and
  `guideShows` (the tip, finished goals kept in place, Up next without its
  heading, a goals area that never scrolls, the class quest card on the
  chain's first step only, a notice without its ×, Along the way, the XP row
  and the Journey in compact mode, and `markWash`: the row the arrow points
  at lit by a wash instead of the bar). `Polestar.UI.GuideFrame.MarkRow(row, on)`
  marks a row a layout draws itself; `guidePlace "classCard"` places the class
  quest card. A skin or layout addon that loads on demand loads when picked.
