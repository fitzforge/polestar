-- Korean (koKR): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "50레벨에 운고로 경험치와 치유 물약 두 개. Forever에서는 클래식의 아이템 선택이 사라졌습니다.",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "{spell:18960}을(를) 시전하세요. {npc:12042}은(는) {area:2361}에 서 있습니다. 직업 상급자도 같은 퀘스트를 줍니다.",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "{area:976}(으)로 날아가 서쪽으로 {zone:1449}(으)로 내려가는 긴 비탈까지 가세요. {npc:9619}은(는) 그 아래, 분화구 남동쪽 구석에 진을 치고 있습니다.",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "고리쉬 독침과 {item:22434}",
	-- {item:22434} Bloodcap
	-- plural, as words: Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "분화구 남쪽 벌집의 병정 고리쉬, 일꾼 고리쉬, 갈퀴발톱 고리쉬가 독침을 떨어뜨립니다. {item:22434}을(를) 주는 붉은꽃잎 씨앗은 분화구 서쪽 절반 곳곳에 자랍니다.",

	-- Step 5: Toxic Test
	-- {item:22432} Devilsaur Barb · {npc:6498} Devilsaur
	-- plural, as words: Devilsaurs = {npc:6498} Devilsaur
	["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "{npc:6498}에게 {item:22432}을(를) 사용하세요. 데빌사우루스는 정예(54-55레벨)이며 분화구를 돌아다닙니다. 파티를 권장합니다.",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: {item:22432}(으)로 찌르세요",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion
	["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477}은(는) {zone:1435}의 {area:74}에 있습니다. {npc:8580}이(가) 사원 아래층을 지킵니다. 던전 우두머리이니 파티를 데려가세요.",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "{zone:1449} 남동쪽 구석의 {npc:9619}에게 돌아가세요.",
}
