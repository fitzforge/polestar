---
section: authors
---
- Skins as addons: `Polestar.Theme.RegisterScheme` and
  `Polestar.Theme.RegisterSkin` let another addon add a colour scheme or a
  whole skin (tokens, fonts, media, per-surface painters) without touching
  Polestar, with an API version, a capability query, validation (required
  tokens, legible text) and a fallback to the default skin on any error.
  docs/SKINS-API.md documents it; addon/Polestar_Skin_Example is a small
  working skin to start from.
