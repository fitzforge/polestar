---
section: forge
---
- The walking maps and their ground layers moved to forge: `forge nav pack`
  writes Polestar_Nav's maps (byte-identical to the Node writer on the
  1.60.1.70532 grid), `forge nav check` holds them to `PACK.json`, and
  `forge nav layers roads|hubs` build the roads and hostile-hubs layers that
  `forge nav prepare` and the pack read; the road-texture allowlist is now
  `data/road-textures.json`. `polestar nav pack|check|layers` print the forge
  command instead. The addon router's tests write their hand-made maps with
  forge-nav's fixture writer (forge-addontest's navmap).
