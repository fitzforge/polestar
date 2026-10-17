-- Korean (koKR): the guide forever/class/warlock/felhunter-horde (forever/class/warlock/felhunter-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Horde)"] = "지옥사냥개(호드)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "주문시전자를 상대할 악마인 지옥사냥개, 그리고 영혼의 조각을 담을 {item:22244}.",

	-- Step 1: Seeking Strahad (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:6251} in {area:392}."] = "30레벨에 {object:172982} 아래 {object:172960}의 {npc:5875}이(가) {area:392}의 {npc:6251}에게 보냅니다.",

	-- Step 2: Seeking Strahad (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "30레벨에 {object:36082}의 {npc:5675}이(가) {area:392}의 {npc:6251}에게 보냅니다. {zone:1420}에서 비행선을 타면 {zone:1411}(으)로 갑니다.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly to {area:392}; {npc:6251} stands on the hill in town."] = "{area:392}(으)로 날아가십시오. {npc:6251}은(는) 마을 언덕 위에 있습니다.",

	-- Step 4: Jorah Annison
	-- {npc:6293} Jorah Annison · {object:36082} Magic Quarter
	["{npc:6293} stands in the {object:36082}."] = "{npc:6293}은(는) {object:36082}에 있습니다.",

	-- Step 5: Moldy Tome
	-- {item:6931} Moldy Tome · {area:271} Southshore
	["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931}은(는) {area:271} 서쪽 해안, 너덜지느러미멀록 야영지 너머에 있습니다.",

	-- Step 6: Tattered Manuscript
	-- {object:92423} Damaged Chest · {area:484} Freewind Post
	["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423}은(는) {area:484} 북쪽 협곡에 있습니다.",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, {object:92423} 안에",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "정신 집중의 마법봉",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Bonewarders = {npc:1057} Dragonmaw Bonewarder
	["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "{zone:1437}을(를) 지나는 길 동쪽 언덕은 용아귀부족 해골감시자와 용아귀부족 어둠보초병이 차지하고 있습니다. 마법봉은 이들에게서 떨어집니다.",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal
	["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "{area:392}의 {npc:6251}에게 돌아가십시오. 그 옆의 소환진에서 {quest:1804}을(를) 사용하고 지옥사냥개를 물리쳐 속박하십시오.",
	-- {npc:6251} Strahad Farsan
	["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: 지옥사냥개를 당신에게 속박합니다",
}
