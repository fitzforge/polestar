---
section: forge
---
- The walks stage uses the machine: the hybrid's two passes (our grid's and
  Leffe's maps') run side by side, a band's routes for all its danger tables
  at once, and the walks document's bands are assembled, merged and written on
  threads. A walk store is read as its file lays it out (no table built) and
  written back only when it gained answers. Leffe's decoded maps get 4,096 MB
  in the walks stage (2,048 MB decoded each piece about nine times over), and
  threads asking for a piece being decoded wait for it instead of decoding it
  again. Same walks files and stores, byte for byte; c15's walks on c16's
  world: 296 s to 141 s on 12 threads, a round's second walks pass (70 new
  pairs) 106 s to 47 s.
