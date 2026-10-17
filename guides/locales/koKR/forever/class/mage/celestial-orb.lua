-- Korean (koKR): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515}와(과) 천상의 지팡이",
	["An off-hand orb or a staff for the late 30s, your pick."] = "30대 후반용 보조장비 구슬이나 지팡이 중 선택.",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{zone:1453} {object:2101}의 마법사의 성소에 있는 {npc:5497}이(가) 당신을 {npc:6546}에게 다시 보냅니다. {zone:1455}의 빙크도 같은 퀘스트를 줍니다.",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{zone:1454}의 마법사 상급자 중 하나인 {npc:5885}이(가) 당신을 {npc:6546}에게 다시 보냅니다. {zone:1458}의 {npc:4568}와(과) {zone:1456}의 {npc:3048}도 같은 퀘스트를 줍니다.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}."] = "{npc:6546}의 오두막은 테라모어 서쪽 늪 깊숙한 곳, {area:508} 바로 북쪽에 있습니다.",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "불타는칼날단 소환사는 {zone:1443} 남부의 {area:602}에서 활동합니다. 누구든 {item:7291}을(를) 지니고 있습니다.",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {npc:6549} Demon of the Orb
	["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546}이(가) 오두막 옆에서 구슬 속 악마를 끌어냅니다. {npc:6549}은(는) 정예이니 파티를 권장합니다. 악마가 구슬로 돌아가기까지 3분이 있습니다.",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {object:178824} Meeting Stone · {npc:7023} Obsidian Sentinel
	["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517}은(는) {zone:1418} 북부, {object:178824} 옆에 있는 5인 던전입니다. 안에서 {npc:7023}을(를) 물리치고 동력원을 얻으세요.",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges
	["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "{npc:6546}에게 돌아가세요. 그녀가 오두막 옆에 마나 균열을 엽니다. 10분 안에 {quest:1957} 12마리를 처치하세요.",
}
