-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{zone:1444}的{item:8705}",
	-- {zone:1444} Feralas
	["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "每個機器人都從一個定位器開始，由所在地區的怪物掉落（依我們的資料，每次擊殺約1-2.5%）。從{zone:1444}開始。",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "拯救OOX-22/FE",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "把定位器帶到{area:1105}附近洞穴裡的OOX-22/FE，然後護送它到{area:1108}的碼頭。它的繳交處在{area:35}；保留到稍後。",
	["Escort OOX-22/FE"] = "護送OOX-22/FE",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{zone:1446}的{item:8623}",
	-- {zone:1446} Tanaris
	["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "大多數{zone:1446}的怪物都可能掉落OOX-17/TN的定位器（依我們的資料，每次擊殺約0.5-3%）。",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "拯救OOX-17/TN",
	-- {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "把定位器帶到{zone:1446}的OOX-17/TN，然後護送它到{area:977}。它的繳交處也在{area:35}。",
	["Escort OOX-17/TN"] = "護送OOX-17/TN",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{zone:1425}的{item:8704}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "大多數{zone:1425}的怪物都可能掉落OOX-09/HL的定位器（依我們的資料，每次擊殺約1-2.5%）。",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "拯救OOX-09/HL",
	-- {area:351} Skulk Rock
	["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "把定位器帶到{area:351}附近河流源頭的OOX-09/HL，然後護送它到望海崖另一頭的岸邊。",
	["Escort OOX-09/HL"] = "護送OOX-09/HL",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{area:35}的{npc:7406}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406}在{area:35}。三個機器人都回家後，他會提供{quest:3721}，獎勵是{item:10398}；需要45級。",
}
