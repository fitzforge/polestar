-- Korean (koKR): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2842} Poisons
	["{spell:2842} (Alliance)"] = "{spell:2842} (얼라이언스)",
	-- {spell:2842} Poisons · {item:7676} Thistle Tea
	["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever에서는 {spell:2842}을(를) 상급자가 아니라 이 연계 퀘스트로 배웁니다. {item:7676} 제조법도 함께 얻습니다.",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332} at SI:7 in {object:2100} sends you to {npc:7024} in {zone:1436}."] = "20레벨에 {object:2100} SI:7의 {npc:332}이(가) {zone:1436}의 {npc:7024}에게 보냅니다.",

	-- Step 2: Agent Kearnen
	-- {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {npc:7051} Malformed Defias Drone
	["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024}은(는) {zone:1436} 동쪽 끝, {zone:1431} 경계 근처 언덕에서 {npc:7053}의 탑을 감시합니다. 탑을 지키는 {npc:7051}(레벨 23)이(가) 열쇠를 가지고 있으며, 클라벤의 일지는 꼭대기의 상자에 있습니다.",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}, in the {object:123214}"] = "{object:123214} 안의 {item:7908}",

	-- Step 3: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "엘윈 숲을 지나 북쪽 {zone:1453}(으)로 달려가십시오. 마티아스 쇼는 {object:2100}의 SI:7에 있습니다.",

	-- Step 4: Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207}은(는) SI:7 병영 지하실에 있습니다. 그 옆에서 /lay down을 입력해 진찰을 받으십시오.",
	["/lay down"] = "/lay down",

	-- Step 5: The cure's ingredients
	["The cure's ingredients"] = "치료제 재료",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {item:8431} Spool of Light Chartreuse Silk Thread · {item:3372} Leaded Vial · {item:4371} Bronze Tube
	["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "모두 {zone:1453}에 있습니다: 검프 남매가 {item:3421}을(를) 팔고, {item:8431}은(는) 도시 안에 놓여 있으며, 가까운 상인이 {item:3372}와(과) {item:4371}을(를) 팝니다.",

	-- Step 6: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "{npc:7207}에게 돌아가기",
}
