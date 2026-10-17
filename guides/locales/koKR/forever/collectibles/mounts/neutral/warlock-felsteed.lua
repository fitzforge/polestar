-- Korean (koKR): the guide forever/collectibles/mounts/neutral/warlock-felsteed (forever/collectibles/mounts/neutral/warlock-felsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Felsteed"] = "흑마법사 지옥마",
	["Your own mount at 40, summoned anywhere, with no gold spent on a riding horse."] = "40레벨에 얻는 나만의 탈것입니다. 어디서나 소환할 수 있고, 말에 골드를 쓸 필요가 없습니다.",

	-- Step 1: Summon Felsteed (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "40레벨이 되면 {object:2101} 안 {object:2164}의 {npc:461}이(가) {area:392}의 {npc:6251}에게 보냅니다.",

	-- Step 2: Summon Felsteed (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:5172} in {zone:1455} sends you to {npc:6251} in {area:392}."] = "40레벨이 되면 {zone:1455}의 {npc:5172}이(가) {area:392}의 {npc:6251}에게 보냅니다.",

	-- Step 3: Summon Felsteed (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:3326} in the {object:172960} sends you to {npc:6251} in {area:392}."] = "40레벨이 되면 {object:172960}의 {npc:3326}이(가) {area:392}의 {npc:6251}에게 보냅니다.",

	-- Step 4: Summon Felsteed (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 40 {npc:4563} in the {object:36082} sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "40레벨이 되면 {object:36082}의 {npc:4563}이(가) {area:392}의 {npc:6251}에게 보냅니다. {zone:1420}에서 출발하는 비행선은 {zone:1411}(으)로 갑니다.",

	-- Step 5: Strahad Farsan in Ratchet
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:6251} in {area:392}"] = "{area:392}의 {npc:6251}",
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:380} Crossroads · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {quest:3631} Summon Felsteed
	["{area:392} is on the {zone:1413} coast east of the {area:380}; from the Alliance side, take the boat from {area:35}. {npc:6251}'s follow-up teaches {quest:3631}."] = "{area:392}은(는) {area:380} 동쪽 {zone:1413} 해안에 있습니다. 얼라이언스는 {area:35}에서 배를 타십시오. {npc:6251}의 후속 퀘스트가 {quest:3631}을(를) 가르칩니다.",
}
