-- Chinese (traditional) (zhTW): the guide forever/exploration/kalimdor-30-45 (forever/exploration/kalimdor-30-45.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1414} Kalimdor
	["Exploration: {zone:1414} 30-45"] = "探索：{zone:1414} 30-45",

	-- Step 1: Desolace (1/2)
	-- {zone:1413} Barrens · {zone:1443} Desolace · {zone:1445} Dustwallow Marsh
	["Picks up west of the {zone:1413}, in {zone:1443}, and ends in {zone:1445}. 15 areas to discover here, levels 30-39."] = "從{zone:1413}西邊的{zone:1443}接續，在{zone:1445}結束。這裡有15個區域要發現，等級30-39。",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "單一角色探索整張世界地圖是一項Forever傳承挑戰（1點帳號共用傳承點數）。",
	-- {zone:1442} Stonetalon Mountains · {zone:1443} Desolace · {area:608} Nijel's Point
	["Take the road south-west out of the {zone:1442} into {zone:1443}; {area:608} in the north is the Alliance town."] = "沿道路從{zone:1442}往西南進入{zone:1443}；北部的{area:608}是聯盟城鎮。",
	-- {area:460} Sun Rock Retreat · {zone:1443} Desolace · {area:2408} Shadowprey Village
	["Fly to {area:460} and take the road south-west into {zone:1443}; {area:2408} on the west coast is the Horde town."] = "飛往{area:460}，沿道路往西南進入{zone:1443}；西岸的{area:2408}是部落城鎮。",
	-- {area:608} Nijel's Point · {npc:6706} Baritanas Skyriver
	["Flight path here: {area:608} ({npc:6706})."] = "此處飛行路線：{area:608}（{npc:6706}）。",
	-- {area:2408} Shadowprey Village
	["Flight path here: {area:2408} (Thalon)."] = "此處飛行路線：{area:2408}（薩隆）。",
	["Alliance town: Horde characters only need to touch its edge (guards)"] = "聯盟城鎮：部落角色只需碰到邊緣即可（有守衛）",

	-- Step 2: Desolace (2/2)
	["Horde town: Alliance characters only need to touch its edge (guards)"] = "部落城鎮：聯盟角色只需碰到邊緣即可（有守衛）",

	-- Step 3: Shen'dralas
	["7 areas to discover here."] = "這裡有7個區域要發現。",
	-- {zone:2652} Shen'dralas · {zone:1443} Desolace · {zone:1412} Mulgore · {area:2657} Valley of Bones
	["{zone:2652}, the ruins between {zone:1443} and {zone:1412}, is entered from southern {zone:1443} through the {area:2657}."] = "{zone:2652}是{zone:1443}和{zone:1412}之間的廢墟，從{zone:1443}南部經由{area:2657}進入。",

	-- Step 4: Feralas (1/2)
	["16 areas to discover here, levels 41-60."] = "這裡有16個區域要發現，等級41-60。",
	-- {zone:1443} Desolace · {zone:1444} Feralas
	["Go back into southern {zone:1443}; the road continues south into {zone:1444}."] = "回到{zone:1443}南部；道路繼續向南通往{zone:1444}。",
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast
	["{area:1116} on {area:1120} is the Alliance town (boat from the {area:1108})."] = "{area:1120}上的{area:1116}是聯盟城鎮（從{area:1108}搭船）。",
	-- {area:1099} Camp Mojache
	["{area:1099} in the east is the Horde town."] = "東部的{area:1099}是部落城鎮。",
	-- {area:489} Thalanaar · {npc:8019} Fyldren Moonfeather
	["Flight paths here: {area:489} (Thyssiana), Feathermoon ({npc:8019})."] = "此處飛行路線：{area:489}（賽希亞娜）、羽月要塞（{npc:8019}）。",
	-- {area:1099} Camp Mojache
	["Flight path here: {area:1099} (Shyn)."] = "此處飛行路線：{area:1099}（夏恩）。",
	["level 60 area, well above this guide's range"] = "60級區域，遠高於本指南的等級範圍",

	-- Step 6: Dustwallow Marsh
	["7 areas to discover here, levels 36-61."] = "這裡有7個區域要發現，等級36-61。",
	-- {area:150} Menethil Harbor · {area:513} Theramore Isle
	["Fly to Theramore (or take the boat from {area:150}); {area:513} is the Alliance town."] = "飛往塞拉摩島（或從{area:150}搭船）；{area:513}是聯盟城鎮。",
	-- {zone:1445} Dustwallow Marsh · {zone:1413} Barrens · {area:496} Brackenwall Village
	["{zone:1445} is east of the southern {zone:1413}; {area:496} in the north-west is the Horde town."] = "{zone:1445}在{zone:1413}南部的東邊；西北部的{area:496}是部落城鎮。",
	["Flight path here: Theramore (Baldruc)."] = "此處飛行路線：塞拉摩島（巴德拉克）。",
	-- {area:496} Brackenwall Village
	["Flight path here: {area:496} (Shardi)."] = "此處飛行路線：{area:496}（沙爾迪）。",
	["any one of these names counts"] = "這些名稱中任何一個都算數",
	["Horde town: Alliance characters only need to touch its edge (guards); any one of these names counts"] = "部落城鎮：聯盟角色只需碰到邊緣即可（有守衛）；這些名稱中任何一個都算數",
	["level 61 area, well above this guide's range"] = "61級區域，遠高於本指南的等級範圍",
	["Alliance town: Horde characters only need to touch its edge (guards); any one of these names counts"] = "聯盟城鎮：部落角色只需碰到邊緣即可（有守衛）；這些名稱中任何一個都算數",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1108}"] = "{area:1108}",
}
