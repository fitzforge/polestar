---
section: forge
---
- The Codex reads the client's GroupFinderActivity table (`forge data
  sources` fetches it with the others): each dungeon page takes its range
  and group size from it and gains `floor`, the higher of the range's bottom
  and players' 25th percentile entry level (data/codex/recorded.json's new
  `dungeons` block, 5 people with a boss kill or more). The two exceptions
  are cited in data/codex/levels.json.
