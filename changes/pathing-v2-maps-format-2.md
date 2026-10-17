---
section: contributors
---
- Pathing v2: the walking maps are format 2 (`nav pack`): every node carries a
  ground class (road, gentle or steep slope, indoor, indoor city, hostile-hub
  bits, from `nav layers roads` and `nav layers hubs` and grid v4's surface
  slopes) and every graph edge a cost per faction and its yards. The router
  (`Routing/Costs.lua`, `Path.lua`, `PathGrid.lua`) prices steps by class and
  profile, straightens only over ground no costlier, and returns `job.yards`
  and `job.hubs`; Zephras Isle is packed from our grid. `nav eval` measures a
  maps folder against a baseline (checks A1-A8 (A9, memory, by hand)).
