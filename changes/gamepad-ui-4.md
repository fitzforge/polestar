---
section: contributors
---
- Polestar draws on Blizzard's map frames through `Polestar.MapCanvas`
  (`Nav/MapCanvas.lua`, ARCHITECTURE "MapCanvas"): its own frames on the
  map's canvas, the map only read. No module adds a data provider or a pin
  pool, acquires a pin or calls a map method that writes: a value written
  into the map's tables taints the gamepad interface's secure code. No frame
  there has a click script either (the gamepad's navigation reads it back as
  it scans the map): pins take clicks from `GLOBAL_MOUSE_DOWN` and
  `GLOBAL_MOUSE_UP`. The route lines (`Maps/RouteLines.lua`) are one such
  frame; `Nav/Journey.lua` tells Polestar's pins under the mouse with
  `Pins.WorldPinOf` and lets the target go on a Shift-click of its pin
  through `Pins.OnWorldClick`. `tests/lua/wow_stub.lua` fakes the map
  frames' shape (`stub.newMapCanvas`) and `stub.guardMap` fails any write of
  addon code into them; `tests/nav-mapcanvas.test.js` draws everything with
  the maps guarded, with either interface, and pins what Polestar reads
  there.
