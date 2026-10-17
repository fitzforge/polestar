-- Korean (koKR): the guide forever/class/mage/nether-lace-garment (forever/class/mage/nether-lace-garment.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a tunic for Undead and Troll mages in their late 20s."] = "20레벨대 후반 언데드 및 트롤 마법사를 위한 로브 또는 튜닉.",

	-- Step 1: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {object:36082} Magic Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:4568} stands in the {zone:1458}'s {object:36082}. Trolls take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568}은(는) {zone:1458} {object:36082}에 있습니다. 트롤은 {zone:1454}에서 비행선을 타고 {zone:1420}(으)로 가십시오.",

	-- Step 2: Deino
	-- {zone:1454} Orgrimmar · {npc:5885} Deino
	["Take the zeppelin to {zone:1454}. {npc:5885} is one of {zone:1454}'s mage trainers."] = "비행선을 타고 {zone:1454}(으)로 가십시오. {npc:5885}은(는) {zone:1454}의 마법사 상급자 중 한 명입니다.",

	-- Step 3: The Xavian Waterfall
	-- {object:174797} Xavian Waterfall (no name in this language: may be words)
	["The {object:174797}"] = "{object:174797}",
	-- {area:429} Xavian · {zone:1440} Ashenvale · {spell:9052} Fill Deino's Flask
	["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. {spell:9052} at the bottom of the highest waterfall."] = "사티로스가 {zone:1440} 동부의 {area:429} 폐허를 차지하고 있습니다. 가장 높은 폭포 아래에서 {spell:9052}을(를) 하세요.",

	-- Step 4: Back to Deino
	-- {npc:5885} Deino
	["Back to {npc:5885}"] = "{npc:5885}에게 돌아가기",

	-- Step 5: The Laughing Sisters
	-- {quest:1945} Laughing Sisters
	["The {quest:1945}"] = "{quest:1945}",
	-- {quest:1945} Laughing Sisters · {area:426} Raynewood Retreat · {zone:1440} Ashenvale
	["The {quest:1945}, dryads, gather near the {area:426} in central {zone:1440}."] = "드라이어드인 {quest:1945}은(는) {zone:1440} 중앙의 {area:426} 근처에 모여 있습니다.",

	-- Step 6: Kil'hala
	-- {npc:3484} Kil'hala · {area:380} Crossroads
	["{npc:3484}, a troll tailor, works at the {area:380}."] = "트롤 재봉사 {npc:3484}은(는) {area:380}에서 일합니다.",
}
