-- Chinese (traditional) (zhTW): the guide forever/exploration/eastern-kingdoms-30-45 (forever/exploration/eastern-kingdoms-30-45.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 30-45"] = "探索：{zone:1415} 30-45",

	-- Step 1: Alterac Mountains (1/2)
	-- {zone:1424} Hillsbrad Foothills
	["Picks up in {zone:1424}, where the 1-30 guide leaves the Horde and passes the Alliance. 15 areas to discover here, levels 27-39."] = "從{zone:1424}接續，1-30指南在那裡與部落分開、經過聯盟。這裡有15個區域要發現，等級27-39。",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "單一角色探索整張世界地圖是一項Forever傳承挑戰（1點帳號共用傳承點數）。",
	-- {area:271} Southshore · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:271} in {zone:1424} and walk north into the {zone:1416}."] = "飛往{zone:1424}的{area:271}，向北走進{zone:1416}。",
	-- {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:272} in {zone:1424} and walk north into the {zone:1416}."] = "飛往{zone:1424}的{area:272}，向北走進{zone:1416}。",
	["any one of these names counts"] = "這些名稱中任何一個都算數",

	-- Step 3: Arathi Highlands (1/2)
	["16 areas to discover here, levels 30-40."] = "這裡有16個區域要發現，等級30-40。",
	-- {zone:1417} Arathi Highlands · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	["The {zone:1417} lie east of the {zone:1416} and {zone:1424}."] = "{zone:1417}位於{zone:1416}和{zone:1424}的東邊。",
	-- {area:320} Refuge Pointe · {area:321} Hammerfall
	["{area:320} in the middle is the Alliance town; {area:321} in the east is Horde."] = "中部的{area:320}是聯盟城鎮；東部的{area:321}是部落城鎮。",
	-- {area:321} Hammerfall · {area:320} Refuge Pointe
	["{area:321} in the east is the Horde town; {area:320} in the middle is Alliance."] = "東部的{area:321}是部落城鎮；中部的{area:320}是聯盟城鎮。",
	-- {area:320} Refuge Pointe · {npc:2835} Cedrik Prose
	["Flight path here: {area:320} ({npc:2835})."] = "此處飛行路線：{area:320}（{npc:2835}）。",
	-- {area:321} Hammerfall
	["Flight path here: {area:321} (Urda)."] = "此處飛行路線：{area:321}（尤爾達）。",
	["Alliance town: Horde characters only need to touch its edge (guards)"] = "聯盟城鎮：部落角色只需碰到邊緣即可（有守衛）",

	-- Step 4: Arathi Highlands (2/2)
	["Horde town: Alliance characters only need to touch its edge (guards)"] = "部落城鎮：聯盟角色只需碰到邊緣即可（有守衛）",
	["elite Syndicate and ogres inside the walls: the discovery triggers at the gate"] = "城牆內有精英辛迪加和巨魔：在大門處就會觸發發現",

	-- Step 5: Badlands (1/2)
	["14 areas to discover here, levels 36-45."] = "這裡有14個區域要發現，等級36-45。",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {object:1668} Dun Algaz · {zone:1432} Loch Modan · {zone:1418} Badlands
	["Cross the {area:880} south into the {zone:1437}, go through the {object:1668} pass into {zone:1432} and take the road south out of {zone:1432} into the {zone:1418}."] = "向南穿過{area:880}進入{zone:1437}，經由{object:1668}山口進入{zone:1432}，再沿道路從{zone:1432}向南進入{zone:1418}。",
	-- {area:144} Thelsamar · {zone:1432} Loch Modan
	["Faster: fly to {area:144} in {zone:1432}."] = "更快的方式：飛往{zone:1432}的{area:144}。",
	-- {area:340} Kargath
	["{area:340} in the west is the Horde town."] = "西部的{area:340}是部落城鎮。",
	-- {area:340} Kargath
	["Flight path here: {area:340} (Gorrik)."] = "此處飛行路線：{area:340}（格里克）。",

	-- Step 7: Riverglades (1/2)
	["14 areas to discover here, levels 36-44."] = "這裡有14個區域要發現，等級36-44。",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1428} Burning Steppes · {zone:1433} Redridge Mountains · {zone:1446} Tanaris · {area:16727} Powderfuse Port · {area:17780} Krol'dok Stronghold
	["The {zone:2548} lie east of the {zone:1418} and the {zone:1428}: the way in is the fork east off the {zone:1433} road (a ship also runs from {zone:1446} to {area:16727}, the neutral goblin port on its coast). {area:17780} is an ogre clan's outdoor dungeon."] = "{zone:2548}位於{zone:1418}和{zone:1428}的東邊：入口是{zone:1433}道路向東的岔路（也有船從{zone:1446}開往其海岸上的中立哥布林港口{area:16727}）。{area:17780}是一個巨魔氏族的野外地城。",

	-- Step 9: Stranglethorn Vale (1/4)
	-- {area:35} Booty Bay · {area:392} Ratchet
	["27 areas to discover here, levels 30-50. {area:35} at the southern tip is a neutral goblin port with a boat to {area:392}."] = "這裡有27個區域要發現，等級30-50。南端的{area:35}是中立哥布林港口，有船開往{area:392}。",
	-- {area:42} Darkshire · {zone:1453} Stormwind · {zone:1431} Duskwood · {zone:1434} Stranglethorn Vale
	["Fly to {area:42} (or {zone:1453}) and take the road south out of {zone:1431} into northern {zone:1434}."] = "飛往{area:42}（或{zone:1453}），沿道路從{zone:1431}向南進入{zone:1434}北部。",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:117} Grom'gol Base Camp
	["Take the zeppelin from {zone:1454} or the {zone:1458} to {area:117}."] = "從{zone:1454}或{zone:1458}搭飛艇前往{area:117}。",
	-- {area:35} Booty Bay
	["Flight path here: {area:35} (Gyll)."] = "此處飛行路線：{area:35}（蓋爾）。",
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	["Flight paths here: {area:35} (Gringer), {object:3202} (Thysta)."] = "此處飛行路線：{area:35}（格林戈）、{object:3202}（塞斯塔）。",

	-- Step 10: Stranglethorn Vale (2/4)
	["free-for-all PvP inside the arena ring"] = "競技場圈內為自由PvP",

	-- Step 11: Stranglethorn Vale (3/4)
	["level 50 area, well above this guide's range"] = "50級區域，遠高於本指南的等級範圍",

	-- Step 12: Stranglethorn Vale (4/4)
	["elite ogres: discover it from the edge"] = "精英巨魔：從邊緣發現它",

	-- Step 13: Swamp of Sorrows (1/2)
	["11 areas to discover here, levels 36-43."] = "這裡有11個區域要發現，等級36-43。",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows
	["Go back north into {zone:1431} and follow its road east through {zone:1430} (level 50+ creatures off the road) into the {zone:1435}."] = "回到北邊的{zone:1431}，沿其道路向東穿過{zone:1430}（路外有50級以上的生物）進入{zone:1435}。",
	-- {area:75} Stonard
	["{area:75} is the Horde town."] = "{area:75}是部落城鎮。",
	-- {area:75} Stonard
	["Flight path here: {area:75} (Breyk)."] = "此處飛行路線：{area:75}（布雷依克）。",
}
