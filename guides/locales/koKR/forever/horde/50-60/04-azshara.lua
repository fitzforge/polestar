-- Korean (koKR): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{object:172960}의 {npc:8659}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{object:172957}의 {npc:15188}: {zone:1451}을(를) 위해 보관하세요",

	-- Step 2: Fly to the Crossroads
	-- {area:380} Crossroads
	["Fly to the {area:380}"] = "{area:380}(으)로 날아가기",

	-- Step 3: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "{npc:256386}의 상자",
	-- {npc:256386} Dokimi · {area:380} Crossroads
	["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386}은(는) {area:380}에 서 있습니다. 그녀가 건네는 상자를 하나씩 열어 안에 든 것을 가져가세요.",

	-- Step 4: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "{area:392}(으)로 날아가기",

	-- Step 5: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "리브의 작업장은 {area:392} 부두 북쪽 끝에 있으며, {object:149036}은(는) 그 안에 있습니다.",

	-- Step 6: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901}은(는) {area:392} 바로 북쪽 해안에 야영하고 있습니다.",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "정화된 물은 {zone:1448}의 {area:2479}(으)로 갑니다. 나중을 위해 보관하세요.",

	-- Step 7: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",

	-- Step 8: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "{object:172961}에 있습니다. 양모 옷감, 비단 옷감, 마법 옷감을 가방에 넣어 두세요.",

	-- Step 9: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "{object:172958}에 있습니다.",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "{item:14047} 기부 두 개는 나중에 경로 중 완료합니다. {item:14047}을(를) 모으기 시작하세요.",

	-- Step 10: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "{area:1237}(으)로 날아가기",

	-- Step 12: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "동쪽 해안의 폐허로 가세요. 해안을 따라 있는 조수 웅덩이에서 큘리의 약병 네 개를 채우세요. 원한의꼬리일족 나가가 그 사이를 순찰합니다.",

	-- Step 13: Thalassian Base Camp
	-- {area:1227} Bay of Storms
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}."] = "블러드 엘프는 북동쪽 {area:1227} 옆 절벽에 야영하고 있습니다.",

	-- Step 14: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}의 야영지",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "림토리의 야영지는 주 야영지 동쪽 끝에 있습니다. 그곳에서 {object:151286}을(를) 읽은 뒤 마법사를 처치하세요.",

	-- Step 15: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "서쪽의 {area:1237}(으)로 돌아가세요.",

	-- Step 16: Belgrom Rockmaul
	-- {area:1637} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["Fly to {area:1637}; {npc:4485} is in the {object:172958}."] = "{area:1637}(으)로 날아가세요. {npc:4485}은(는) {object:172958}에 있습니다.",

	-- Step 17: Zeppelin to the Undercity
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "{zone:1458}행 비행선",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "비행선 탑은 {zone:1454} 정문 바로 북동쪽에 있습니다. {zone:1458}행 비행선을 타세요.",
	["Zeppelin tower"] = "비행선 탑",

	-- Step 18: The Apothecarium
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "그 옆의 {npc:8393}",

	-- Step 19: Royal Quarter
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "근처의 {npc:8403}",
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050}은(는) {zone:1422}의 {npc:10778}에게 돌아갑니다. 보관하세요.",

	-- Step 21: Prompt Potion Runner
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "연금술 실험실의 {npc:11044}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Open {object:149036} for the {item:10556}"] = "{object:149036}을(를) 열어 {item:10556} 얻기",
}
