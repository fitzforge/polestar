-- Chinese (traditional) (zhTW): the guide forever/class/warlock/felhunter-alliance (forever/class/warlock/felhunter-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Alliance)"] = "地獄獵犬（聯盟）",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "地獄獵犬是對付施法者的惡魔，另附一個{item:22244}存放靈魂碎片。",

	-- Step 1: Seeking Strahad (Stormwind)
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan
	["At 30 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in Ratchet."] = "",

	-- Step 2: Seeking Strahad (Ironforge)
	-- {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern · {npc:6251} Strahad Farsan
	["At 30 {npc:6120}, in the {object:32383}, sends you to {npc:6251} in Ratchet."] = "",

	-- Step 3: Strahad Farsan
	-- {zone:1413} Barrens · {object:3204} Booty Bay (no name in this language: may be words) · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6294} Krom Stoutarm · {zone:1455} Ironforge
	["Ratchet is a neutral goblin port on the {zone:1413} coast: the boat from {object:3204} docks there. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6294} in {zone:1455}."] = "",

	-- Step 4: Krom Stoutarm
	-- {npc:6294} Krom Stoutarm · {object:32356} Hall of Explorers · {quest:1758} Tome of the Cabal · {zone:1441} Thousand Needles
	["{npc:6294} is in the library of the {object:32356}. He wants two lost pieces of the {quest:1758}: one on the Hillsbrad coast, one in {zone:1441}."] = "",

	-- Step 5: Moldy Tome
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of Southshore, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "",
	-- {item:6931} Moldy Tome · {quest:1802} Tome of the Cabal
	["{item:6931}, from the {quest:1802} on the sand"] = "",

	-- Step 6: Tattered Manuscript
	-- {object:19840} Freewind Post (no name in this language: may be words)
	["The centaur cave opens in the cliffs north of {object:19840}, a Horde town: keep clear of its guards. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}，在{object:92423}裡",

	-- Step 7: Back to Krom Stoutarm
	-- {npc:6294} Krom Stoutarm
	["Back to {npc:6294}"] = "",
	-- {npc:6294} Krom Stoutarm · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6294} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "導能魔棒",
	-- {object:1162} Menethil Harbor (no name in this language: may be words) · {object:1668} Dun Algaz
	["The Dragonmaw hold Angerfang Encampment in the hills east of the road from {object:1162} to {object:1668}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "",
	["Rods of Channeling, from the Dragonmaw casters"] = "",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in Ratchet. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30 {npc:6120}, in the {object:32383}, sends you to {npc:6251} in {area:392}."] = "30級時，{object:32383}的{npc:6120}會派你去找{area:392}的{npc:6251}。",
	-- ["At 30 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "30級時，{object:2101}{object:2164}地窖裡的{npc:6122}會派你去找{area:392}的{npc:6251}。",
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "返回{area:392}找{npc:6251}。對他身旁的召喚法陣使用{quest:1804}，擊敗地獄獵犬以束縛牠。",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "龍喉白骨守衛和龍喉暗影守衛佔據{zone:1437}道路東側的丘陵：魔棒由他們掉落。",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931}在{area:271}西邊的海岸上，過了碎鰭魚人的營地。",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423}在{area:484}北邊的峽谷中。",
	-- ["{area:392} is on the {zone:1413} coast; {npc:6251} stands on the hill in town."] = "{area:392}在{zone:1413}海岸；{npc:6251}站在鎮上的山丘上。",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}：他會把地獄獵犬束縛給你",
	-- ["{npc:6294} stands in the {object:32356}."] = "{npc:6294}站在{object:32356}。",
}
