-- Korean (koKR): the guide forever/class/warlock/felhunter-alliance (forever/class/warlock/felhunter-alliance.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6294} Krom Stoutarm · {zone:1455} Ironforge
	["{area:392} is a neutral goblin port on the {zone:1413} coast: the boat from {area:35} docks there. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6294} in {zone:1455}."] = "",

	-- Step 4: Krom Stoutarm
	-- {npc:6294} Krom Stoutarm · {object:32356} Hall of Explorers (no name in this language: may be words) · {quest:1758} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6294} is in the library of the {object:32356}. He wants two lost pieces of the {quest:1758}: one on the {area:287} coast, one in {zone:1441}."] = "",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "",
	-- {item:6931} Moldy Tome · {quest:1802} Tome of the Cabal
	["{item:6931}, from the {quest:1802} on the sand"] = "",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}, a Horde town: keep clear of its guards. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, {object:92423} 안",

	-- Step 7: Back to Krom Stoutarm
	-- {npc:6294} Krom Stoutarm
	["Back to {npc:6294}"] = "",
	-- {npc:6294} Krom Stoutarm · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6294} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "정신 집중의 마법봉",
	-- {area:1036} Angerfang Encampment · {area:150} Menethil Harbor · {area:836} Dun Algaz
	["The Dragonmaw hold {area:1036} in the hills east of the road from {area:150} to {area:836}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "",
	["Rods of Channeling, from the Dragonmaw casters"] = "",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "{area:392}의 {npc:6251}에게 돌아가십시오. 그 옆의 소환진에서 {quest:1804}을(를) 사용하고 지옥사냥개를 쓰러뜨려 속박하십시오.",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "{zone:1437}을(를) 지나는 길 동쪽 언덕에 있는 용아귀부족 해골감시자와 용아귀부족 어둠보초병이 마법봉을 떨어뜨립니다.",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931}은(는) 너덜지느러미멀록 야영지를 지나 {area:271} 서쪽 해안에 있습니다.",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423}은(는) {area:484} 북쪽 협곡에 있습니다.",
	-- ["{area:392} is on the {zone:1413} coast; {npc:6251} stands on the hill in town."] = "{area:392}은(는) {zone:1413} 해안에 있으며, {npc:6251}은(는) 마을 언덕 위에 있습니다.",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: 지옥사냥개를 속박해 줍니다",
	-- ["{npc:6294} stands in the {object:32356}."] = "{npc:6294}은(는) {object:32356}에 있습니다.",
}
