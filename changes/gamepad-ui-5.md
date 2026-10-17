---
section: contributors
---
- A frame of Polestar's whose parent is a game frame, or is under one (the
  map canvases, the minimap, quest reward and talent buttons), is made with
  `Polestar.CreateFrameUnder` (`Core/Init.lua`, ARCHITECTURE "Frames under
  the game's UI"): no parent, then `SetParent`. The gamepad interface hooks
  `CreateFrame` and, for a parent inside one of its open panels, rebuilds
  the panel's buttons in the caller's code, tainted. `tests/lua/wow_stub.lua`'s
  `CreateFrame` fails such a call from addon code and lists it in
  `stub.underGameFrames`.
