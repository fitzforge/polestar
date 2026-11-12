---
section: authors
---
- Skins as addons, Skin API 2: `Polestar.Theme.RegisterScheme` and
  `Polestar.Theme.RegisterSkin` let another addon add a colour scheme or a
  whole skin without touching Polestar: tokens, fonts, media (the band, the
  medallion, the arrow's dart, the map pin's disc and rim), painters for
  every kind of frame with a paint kit (fills, gradients, borders, glows, a
  picture of the game behind a frame, a tint over the game's art), the
  windows' shadow, variants the player picks under the skin's card, a
  resolver that answers colours from the player's zone, faction and class,
  and presets applied only when the player asks.
- Skin hooks reach what Polestar's modules draw, with their parts by name:
  the arrow, the map pins, the guide window (each goal's row, its layout and
  room of the skin's own, every render, the progress, each tab, a part the
  skin places itself, its menu, the heads-up card's edge), the cards, the
  toasts and the buttons.
- A skin addon that names its skins in its TOC (`## X-Polestar-Skin`) may
  load on demand: Polestar loads it for a saved choice, the player's pick or
  the settings' list. Specs are checked (required tokens, legible text) and
  a refusal says why; an API version and capabilities let a skin use newer
  features where they exist; any error falls back to Polestar's own look for
  the session. docs/SKINS-API.md and docs/skins document it all, and
  addon/Polestar_Skin_Example (Moonlit) is a working skin to start from.
