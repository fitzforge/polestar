-- Chinese (traditional) (zhTW): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "你的水中旅行形態：快速游泳並能在水下呼吸，另外還有一條腰帶和一個塑像。",

	-- Step 1: A Lesson to Learn
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217}站在{area:1658}。",

	-- Step 2: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。神殿靈珠在{area:2361}下方{area:656}湖底的容器裡：拿一個到西北岸的{area:2362}，在那裡使用它，然後與{npc:11799}交談。",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}，來自湖中的{object:177785}",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "在{area:2362}",

	-- Step 3: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:443} Ruins of Mathystra
	["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "從{area:2361}飛往{area:442}。{object:177792}在北岸外的水下，{area:443}西邊。",

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "從{area:442}搭船前往{zone:1453}，再飛往{area:108}。向西北騎到海岸：{object:177790}在岸外的海底。",

	-- Step 5: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "施放{spell:18960}。在湖的西北岸、{area:2362}附近把兩半組合成{item:15885}，然後去{area:2361}找{npc:11802}。之後飛往{area:702}。",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}：在神殿組合兩半",

	-- Step 6: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up to {npc:4217} in the {area:1658}."] = "搭傳送門上去，到{area:1658}找{npc:4217}。",

	-- Step 7: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033}站在{area:1639}。",

	-- Step 8: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。神殿靈珠躺在{area:656}的湖底，幾分鐘內就會消失：拿到一個後直接游到西北岸的{area:2362}，在那裡使用它，然後與{npc:11799}交談。",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1458} Undercity · {object:177790} Strange Lockbox · {area:240} Dead Field · {area:228} Sepulcher
	["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "搭{npc:11798}的飛行路線前往{zone:1456}，飛往{zone:1454}，再搭飛艇前往{zone:1420}；{zone:1421}在{zone:1458}南邊。{object:177790}在{area:228}北邊、{area:240}西邊的海岸上。",

	-- Step 10: Half Pendant of Aquatic Agility
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {area:380} Crossroads
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "{object:177792}在{area:382}北緣、風險投資公司的塔旁，{area:380}北邊。",

	-- Step 11: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "施放{spell:18960}。在湖的西北岸、{area:2362}附近把兩半組合成{item:15885}，然後去{area:2361}找{npc:11802}。{npc:11798}會載德魯伊飛往{area:1638}。",
}
