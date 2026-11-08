-- Korean (koKR): the guide forever/class/mage/nether-lace-garment (forever/class/mage/nether-lace-garment.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a tunic for Horde mages in their late 20s."] = "",

	-- Step 1: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {object:36082} Magic Quarter · {spell:3563} Teleport: Undercity · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:4568} stands in the {zone:1458}'s {object:36082}. Orcs and Trolls use {spell:3563} or take the zeppelin from {zone:1454} to {zone:1420} for her."] = "",

	-- Step 2: Deino
	-- {zone:1454} Orgrimmar · {spell:3567} Teleport: Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:5885} Deino · {object:172961} Valley of Spirits · {item:7269} Deino's Flask
	["Take the zeppelin to {zone:1454} (or use {spell:3567}, which lands you on the upper floor of {object:173161}). {npc:5885} stands with the mage trainers on the lower floor of {object:173161} in the {object:172961}. She hands you {item:7269}."] = "",

	-- Step 3: The Xavian Waterfall
	-- {object:174797} Xavian Waterfall (no name in this language: may be words)
	["The {object:174797}"] = "{object:174797}",
	-- {area:431} Splintertree Post · {area:429} Xavian
	["Fly to {area:431} and swim north up the river past the big lake to its far northern end, where the zone text reads {area:429}; satyrs hold the ruins around it and a few river beasts are in the way. Swim right in under the highest waterfall until you touch the rock wall, then use the flask (you can stay in the water). The waterfalls on the western Falfarren fork do not work."] = "",
	-- {item:7269} Deino's Flask
	["{item:7269}, under the falls"] = "",

	-- Step 4: Back to Deino
	-- {npc:5885} Deino
	["Back to {npc:5885}"] = "{npc:5885}에게 돌아가기",

	-- Step 5: The Laughing Sisters
	-- {quest:1945} Laughing Sisters
	["The {quest:1945}"] = "{quest:1945}",
	-- {quest:1945} Laughing Sisters · {area:426} Raynewood Retreat · {zone:1440} Ashenvale
	["The {quest:1945}, dryads of level 24-25, roam around the {area:426} in central {zone:1440}; every one drops a hair and they come back after 5 minutes. They often resist fire (and some frost and shadow): arcane spells land best. Each runs for help at low health. Keep clear of the guards by the white tower of the retreat, who hit hard."] = "",

	-- Step 6: Kil'hala
	-- {npc:3484} Kil'hala
	["{npc:3484}, a troll tailor, works at the Crossroads. The robe gives intellect, stamina and spirit; the tunic more intellect and stamina but no spirit."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A robe or a tunic for Undead and Troll mages in their late 20s."] = "20레벨대 후반 언데드 및 트롤 마법사를 위한 로브 또는 튜닉.",
	-- ["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. {spell:9052} at the bottom of the highest waterfall."] = "사티로스가 {zone:1440} 동부의 {area:429} 폐허를 차지하고 있습니다. 가장 높은 폭포 아래에서 {spell:9052}을(를) 하세요.",
	-- ["Take the zeppelin to {zone:1454}. {npc:5885} is one of {zone:1454}'s mage trainers."] = "비행선을 타고 {zone:1454}(으)로 가십시오. {npc:5885}은(는) {zone:1454}의 마법사 상급자 중 한 명입니다.",
	-- ["The {quest:1945}, dryads, gather near the {area:426} in central {zone:1440}."] = "드라이어드인 {quest:1945}은(는) {zone:1440} 중앙의 {area:426} 근처에 모여 있습니다.",
	-- ["{npc:3484}, a troll tailor, works at the {area:380}."] = "트롤 재봉사 {npc:3484}은(는) {area:380}에서 일합니다.",
	-- ["{npc:4568} stands in the {zone:1458}'s {object:36082}. Trolls take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568}은(는) {zone:1458} {object:36082}에 있습니다. 트롤은 {zone:1454}에서 비행선을 타고 {zone:1420}(으)로 가십시오.",
}
