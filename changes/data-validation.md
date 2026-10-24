---
section: contributors
---
- `forge data build` checks each build before it replaces `data/forever`: the
  field statistics (quests with a giver and ender, ids the data knows, givers in
  their zone, race and class masks, spawns, the AreaTable rows, our guides' name
  tokens per kind, compile errors, names the translations have) against the last
  good build's. A large shift stops the build, leaves the data as it was and says
  which fields moved; `--accept` takes an intended change. `forge data check`
  does the same for the data as it is: a checkout without `data/sources` now
  fails it instead of silently writing `{object:81}` for Sentinel Hill.
- The data gate also watches what the sim's leveling reads: quests with a
  reward spell, quest XP (count and sum), the XP values the knowledge base
  changed, corrections, class training rows, riding trainers and mount
  vendors; a new correction or a 0.5% move in quest XP needs `--accept`.
