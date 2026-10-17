-- Korean (koKR): the guide forever/class/mage/destroy-morphaz (forever/class/mage/destroy-morphaz.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "50레벨에 {zone:1447}와(과) {area:1417}을(를) 거치며 얻는 경험치. Forever에서는 클래식의 아이템 보상 선택이 사라졌습니다.",
	["Experience"] = "경험치",

	-- Step 1: Magecraft (Stormwind)
	-- {npc:331} Maginor Dumas · {zone:1453} Stormwind · {object:2101} Mage Quarter · {zone:1455} Ironforge
	["{npc:331}, the Master Mage, stands in the Wizard's Sanctum in {zone:1453}'s {object:2101}; Dink in {zone:1455} gives the same quest."] = "마법사 길드장 {npc:331}은(는) {zone:1453} {object:2101}의 마법사의 성소에 있습니다. {zone:1455}의 딩크도 같은 퀘스트를 줍니다.",

	-- Step 2: Magecraft (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {npc:4567} Pierce Shackleton · {zone:1458} Undercity · {npc:3047} Archmage Shymm · {zone:1456} Thunder Bluff
	["{npc:7311}, one of {zone:1454}'s mage trainers, gives it; so do {npc:4567} in the {zone:1458} and {npc:3047} in {zone:1456}."] = "{zone:1454}의 마법사 상급자 중 한 명인 {npc:7311}이(가) 줍니다. {zone:1458}의 {npc:4567}와(과) {zone:1456}의 {npc:3047}도 줍니다.",

	-- Step 3: Sanath Lim-yo
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara · {area:1221} Ruins of Eldarath · {npc:8379} Archmage Xylem
	["Fly to {area:3137} (Alliance) or {area:1237} (Horde). {npc:8395} camps below his master's tower: from the fork of {zone:1447}'s main road at the {area:1221}, head straight north to the cliffs. He teleports you up to {npc:8379}."] = "{area:3137}(얼라이언스) 또는 {area:1237}(호드)(으)로 날아가세요. {npc:8395}은(는) 스승의 탑 아래에 야영합니다. {zone:1447} 큰길의 {area:1221} 갈림길에서 곧장 북쪽 절벽으로 가세요. 그가 {npc:8379}에게 순간이동시켜 줍니다.",
	-- {npc:8379} Archmage Xylem
	["{npc:8379}, in the tower"] = "탑 안의 {npc:8379}",

	-- Step 4: Glittering Dust
	-- {zone:1447} Azshara
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor
	["The blood elves camp along the cliffs of north-eastern {zone:1447}; Blood Elf Surveyors and Reclaimers drop the dust."] = "블러드 엘프들은 {zone:1447} 북동부 절벽을 따라 야영합니다. 블러드 엘프 감정관과 블러드 엘프 수색꾼이 가루를 떨어뜨립니다.",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395}, who teleports you up to the tower."] = "{npc:8395}에게 돌아가면 탑 위로 순간이동시켜 줍니다.",

	-- Step 6: Enchanted Coral
	-- {area:1221} Ruins of Eldarath
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens walk the ruins and beaches around the {area:1221} and the bay; they carry the coral."] = "원한의꼬리일족 세이렌이 {area:1221}와(과) 만 주변의 폐허와 해변을 돌아다니며, 산호를 가지고 있습니다.",

	-- Step 7: Archmage Xylem again
	-- {npc:8379} Archmage Xylem
	["{npc:8379} again"] = "다시 {npc:8379}",
	-- {npc:8395} Sanath Lim-yo
	["Back to {npc:8395} and up to the tower."] = "{npc:8395}에게 돌아가 탑으로 올라가세요.",

	-- Step 8: Morphaz
	["Morphaz"] = "몰파즈",
	-- {area:1477} Temple of Atal'Hakkar · {area:1417} Sunken Temple · {area:74} Pool of Tears · {item:20085} Arcane Shard
	["Morphaz, a green drake, waits deep in the {area:1477}, the {area:1417} in the {area:74}: a group of five, level 50-54. Kill him for the {item:20085}."] = "녹색 비룡 몰파즈는 {area:74}에 있는 {area:1417}, {area:1477} 깊숙한 곳에서 기다립니다. 5인 파티, 레벨 50-54. 그를 처치해 {item:20085}을(를) 얻으세요.",
	-- {item:20085} Arcane Shard
	["{item:20085}: Morphaz"] = "{item:20085}: 몰파즈",

	-- Step 9: The Arcane Shard
	-- {item:20085} Arcane Shard
	["The {item:20085}"] = "{item:20085}",
	-- {zone:1447} Azshara · {npc:8395} Sanath Lim-yo
	["Back to {zone:1447}, {npc:8395} and the tower."] = "{zone:1447}의 {npc:8395}에게 돌아가 탑으로 가세요.",
}
