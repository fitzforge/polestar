---
section: authors
---
- A large community pack can load on demand: `"load": "on-demand"` in
  `pack.json` writes each faction's guides into a part of their own
  (`<folder>_Alliance`, `<folder>_Horde`) that Polestar loads for a character
  of that faction, and every guide's steps to be read when the guide is
  opened, as Polestar's own pack and race parts already are. A converted pack
  of 1,261 guides goes from one 43 MB file loaded whole to a 1 MB core and a
  17 to 20 MB part for the faction. Without the key a pack is built as
  before. (thanks neopterygii)
