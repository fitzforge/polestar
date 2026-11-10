-- Chinese (simplified) (zhCN): the guide forever/class/mage/arcane-refreshment (forever/class/mage/arcane-refreshment.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10140} Conjure Water · {area:2577} Dire Maul
	["The level 60 {spell:10140}, from a {area:2577} library: drink for you and your group."] = "60级的{spell:10140}，来自{area:2577}的图书馆：为你和小队提供饮料。",
	["Shen'dralar reputation"] = "辛德拉声望",

	-- Step 1: Lorekeeper Lydros
	-- {area:1099} Camp Mojache · {area:2577} Dire Maul · {zone:1444} Feralas · {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key · {item:18594} Powerful Seaforium Charge
	["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing, or through the North wing's courtyard doors with a {item:18249} (it drops from the imp Pusillin in the East wing; a {item:18594} also opens them; Blink no longer gets past). Other mages in your group can take it too: share it."] = "联盟飞往羽月要塞，部落飞往{area:1099}，再骑行前往{zone:1444}中部的{area:2577}。{npc:14368}在图书馆等候，可从西区抵达，或使用{item:18249}打开北区庭院的门进入。钥匙由东区小鬼普希林掉落，{item:18594}也能开门；现在已无法用闪现穿过去。小队里的其他法师也能接取，记得共享任务。",

	-- Step 2: Hydrospawn
	["Hydrospawn"] = "海多斯博恩",
	-- {area:1758} Riptide
	["Hydrospawn, a level 57 elite water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool. A group of five. Frost does nothing to him, so frost mages switch to fire or arcane. {area:1758} hits everyone within 10 yards, so ranged stand back; at a quarter health he calls Hydrolings. The essence always drops; he does not come back until the instance resets."] = "",
	-- {item:18299} Hydrospawn Essence
	["{item:18299}: Hydrospawn"] = "{item:18299}：海多斯博恩",

	-- Step 3: Back to Lydros
	["Back to Lydros"] = "回到莱德罗斯处",
	-- {npc:14368} Lorekeeper Lydros · {spell:10140} Conjure Water
	["{npc:14368}: {spell:10140}, and 200 Shen'dralar reputation"] = "{npc:14368}：学习{spell:10140}，并获得 200 点辛德拉声望",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing (or the North wing with a {item:18249})."] = "飞往羽月要塞（联盟）或{area:1099}（部落），然后骑行到{zone:1444}中部的{area:2577}。{npc:14368}在图书馆等候，经由西区（或持有{item:18249}经由北区）到达。",
	-- ["Hydrospawn, a water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool."] = "水元素海多斯博恩住在厄运之槌东区：追赶小鬼普希林直到他转身迎战，清掉萨特房间，然后沿螺旋坡道下到水池。",
}
