-- Korean (koKR): the guide forever/class/warlock/felhunter-alliance (forever/class/warlock/felhunter-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Alliance)"] = "지옥사냥개 (얼라이언스)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "주문시전자 상대로 쓰는 악마인 지옥사냥개와, 영혼의 조각을 담을 {item:22244}입니다.",

	-- Step 1: Seeking Strahad (Stormwind)
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "30레벨에 {object:2101} {object:2164}의 지하실에 있는 {npc:6122}이(가) {area:392}의 {npc:6251}에게 보냅니다.",

	-- Step 2: Seeking Strahad (Ironforge)
	-- {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6120}, in the {object:32383}, sends you to {npc:6251} in {area:392}."] = "30레벨에 {object:32383}의 {npc:6120}이(가) {area:392}의 {npc:6251}에게 보냅니다.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:6251} Strahad Farsan
	["{area:392} is on the {zone:1413} coast; {npc:6251} stands on the hill in town."] = "{area:392}은(는) {zone:1413} 해안에 있으며, {npc:6251}은(는) 마을 언덕 위에 있습니다.",

	-- Step 4: Krom Stoutarm
	-- {npc:6294} Krom Stoutarm · {object:32356} Hall of Explorers (no name in this language: may be words)
	["{npc:6294} stands in the {object:32356}."] = "{npc:6294}은(는) {object:32356}에 있습니다.",

	-- Step 5: Moldy Tome
	-- {item:6931} Moldy Tome · {area:271} Southshore
	["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931}은(는) 너덜지느러미멀록 야영지를 지나 {area:271} 서쪽 해안에 있습니다.",

	-- Step 6: Tattered Manuscript
	-- {object:92423} Damaged Chest · {area:484} Freewind Post
	["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423}은(는) {area:484} 북쪽 협곡에 있습니다.",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, {object:92423} 안",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "정신 집중의 마법봉",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Bonewarders = {npc:1057} Dragonmaw Bonewarder
	["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "{zone:1437}을(를) 지나는 길 동쪽 언덕에 있는 용아귀부족 해골감시자와 용아귀부족 어둠보초병이 마법봉을 떨어뜨립니다.",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal
	["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "{area:392}의 {npc:6251}에게 돌아가십시오. 그 옆의 소환진에서 {quest:1804}을(를) 사용하고 지옥사냥개를 쓰러뜨려 속박하십시오.",
	-- {npc:6251} Strahad Farsan
	["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: 지옥사냥개를 속박해 줍니다",
}
