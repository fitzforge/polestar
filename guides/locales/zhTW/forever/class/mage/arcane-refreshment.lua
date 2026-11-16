-- Chinese (traditional) (zhTW): the guide forever/class/mage/arcane-refreshment (forever/class/mage/arcane-refreshment.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10140} Conjure Water · {area:2577} Dire Maul
	["The level 60 {spell:10140}, from a {area:2577} library: drink for you and your group."] = "60級的{spell:10140}，來自{area:2577}的圖書館：為你和小隊提供飲料。",
	["Shen'dralar reputation"] = "辛德拉聲望",

	-- Step 1: Lorekeeper Lydros
	-- {area:1099} Camp Mojache · {area:2577} Dire Maul · {zone:1444} Feralas · {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key · {item:18594} Powerful Seaforium Charge
	["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing, or through the North wing's courtyard doors with a {item:18249} (it drops from the imp Pusillin in the East wing; a {item:18594} also opens them; Blink no longer gets past). Other mages in your group can take it too: share it."] = "",

	-- Step 2: Hydrospawn
	["Hydrospawn"] = "海多斯博恩",
	-- {area:1758} Riptide
	["Hydrospawn, a level 57 elite water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool. A group of five. Frost does nothing to him, so frost mages switch to fire or arcane. {area:1758} hits everyone within 10 yards, so ranged stand back; at a quarter health he calls Hydrolings. The essence always drops; he does not come back until the instance resets."] = "海多斯博恩是一隻57級精英水元素，住在扭木廣場（厄運之槌東區）：追著小鬼普希林直到他轉身應戰，清掉薩特的房間，然後沿著螺旋坡道下到水池。需要五人小隊。冰霜對他無效，所以冰法要改用火焰或奧術。{area:1758}會擊中10碼內的所有人，所以遠程要站遠一點；他血量剩四分之一時會召喚小水元素。精華必定掉落；副本重置前他不會再出現。",
	-- {item:18299} Hydrospawn Essence
	["{item:18299}: Hydrospawn"] = "{item:18299}：海多斯博恩",

	-- Step 3: Back to Lydros
	["Back to Lydros"] = "返回博學者萊德羅斯",
	-- {npc:14368} Lorekeeper Lydros · {spell:10140} Conjure Water
	["{npc:14368}: {spell:10140}, and 200 Shen'dralar reputation"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to Feathermoon (Alliance) or {area:1099} (Horde) and ride to {area:2577} in central {zone:1444}. {npc:14368} waits in the Athenaeum, the library, reached through the West wing (or the North wing with a {item:18249})."] = "飛往羽月要塞（聯盟）或{area:1099}（部落），然後騎往{zone:1444}中部的{area:2577}。{npc:14368}在圖書館等著，經由西區抵達（持有{item:18249}也可走北區）。",
	-- ["Hydrospawn, a water elemental, lives in the Warpwood Quarter (Dire Maul East): chase the imp Pusillin until he turns to fight, clear the satyr room, then take the spiral ramp down to the pool."] = "水元素海多斯博恩住在Warpwood Quarter（厄運之槌東區）：追趕小鬼普希林直到他轉身應戰，清掉薩特房間，然後沿螺旋坡道下到水池。",
}
