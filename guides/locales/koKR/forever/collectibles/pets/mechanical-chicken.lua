-- Korean (koKR): the guide forever/collectibles/pets/mechanical-chicken (forever/collectibles/pets/mechanical-chicken.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: OOX-22/FE Distress Beacon in Feralas
	-- {item:8705} OOX-22/FE Distress Beacon · {zone:1444} Feralas
	["{item:8705} in {zone:1444}"] = "{zone:1444}의 {item:8705}",
	-- {zone:1444} Feralas
	["Each robot starts with a distress beacon that mobs in its zone drop (about 1-2.5% per kill in our data). Start in {zone:1444}."] = "각 로봇은 해당 지역 몬스터가 떨어뜨리는 구조 신호기로 시작합니다(우리 데이터상 처치당 약 1-2.5%). {zone:1444}에서 시작하십시오.",

	-- Step 2: Rescue OOX-22/FE
	["Rescue OOX-22/FE"] = "OOX-22/FE 구출",
	-- {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Take the beacon to OOX-22/FE in a cave near {area:1105}, then escort it to the dock on the {area:1108}. Its turn-in is in {area:35}; keep it for later."] = "{area:1105} 근처 동굴의 OOX-22/FE에게 신호기를 가져간 뒤, {area:1108}의 부두까지 호위하십시오. 완료 보고는 {area:35}에서 하니 나중을 위해 남겨 두십시오.",
	["Escort OOX-22/FE"] = "OOX-22/FE 호위",

	-- Step 3: OOX-17/TN Distress Beacon in Tanaris
	-- {item:8623} OOX-17/TN Distress Beacon · {zone:1446} Tanaris
	["{item:8623} in {zone:1446}"] = "{zone:1446}의 {item:8623}",
	-- {zone:1446} Tanaris
	["Most {zone:1446} mobs can drop OOX-17/TN's beacon (about 0.5-3% per kill in our data)."] = "대부분의 {zone:1446} 몬스터가 OOX-17/TN의 신호기를 떨어뜨릴 수 있습니다(우리 데이터상 처치당 약 0.5-3%).",

	-- Step 4: Rescue OOX-17/TN
	["Rescue OOX-17/TN"] = "OOX-17/TN 구출",
	-- {zone:1446} Tanaris · {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Take the beacon to OOX-17/TN in {zone:1446}, then escort it to {area:977}. Its turn-in is in {area:35} too."] = "{zone:1446}의 OOX-17/TN에게 신호기를 가져간 뒤 {area:977}까지 호위하십시오. 완료 보고도 {area:35}에서 합니다.",
	["Escort OOX-17/TN"] = "OOX-17/TN 호위",

	-- Step 5: OOX-09/HL Distress Beacon in the Hinterlands
	-- {item:8704} OOX-09/HL Distress Beacon · {zone:1425} Hinterlands
	["{item:8704} in the {zone:1425}"] = "{zone:1425}의 {item:8704}",
	-- {zone:1425} Hinterlands
	["Most {zone:1425} mobs can drop OOX-09/HL's beacon (about 1-2.5% per kill in our data)."] = "대부분의 {zone:1425} 몬스터가 OOX-09/HL의 신호기를 떨어뜨릴 수 있습니다(우리 데이터상 처치당 약 1-2.5%).",

	-- Step 6: Rescue OOX-09/HL
	["Rescue OOX-09/HL"] = "OOX-09/HL 구출",
	-- {area:351} Skulk Rock
	["Take the beacon to OOX-09/HL at the head of the river near {area:351}, then escort it to the shore beyond Overlook Cliff."] = "{area:351} 근처 강 상류의 OOX-09/HL에게 신호기를 가져간 뒤, 전망대 절벽 너머 해안까지 호위하십시오.",
	["Escort OOX-09/HL"] = "OOX-09/HL 호위",

	-- Step 7: Oglethorpe Obnoticus in Booty Bay
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay
	["{npc:7406} in {area:35}"] = "{area:35}의 {npc:7406}",
	-- {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {quest:3721} An OOX of Your Own · {item:10398} Mechanical Chicken
	["{npc:7406} is in {area:35}. With all three robots home he offers {quest:3721}, whose reward is the {item:10398}; it needs level 45."] = "{npc:7406}은(는) {area:35}에 있습니다. 로봇 셋이 모두 돌아오면 {quest:3721}을(를) 주며, 보상은 {item:10398}입니다. 45레벨이 필요합니다.",
}
