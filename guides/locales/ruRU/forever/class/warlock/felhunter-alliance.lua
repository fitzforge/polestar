-- Russian (ruRU): the guide forever/class/warlock/felhunter-alliance (forever/class/warlock/felhunter-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Alliance)"] = "Охотник Скверны (Альянс)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "Охотник Скверны – демон против заклинателей, а также {item:22244} для ваших осколков.",

	-- Step 1: Seeking Strahad (Stormwind)
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "На 30-м уровне {npc:6122} (подвал: {object:2164}, {object:2101}) отправит вас сюда: {npc:6251} ({area:392}).",

	-- Step 2: Seeking Strahad (Ironforge)
	-- {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6120}, in the {object:32383}, sends you to {npc:6251} in {area:392}."] = "На 30-м уровне {npc:6120} ({object:32383}) отправит вас сюда: {npc:6251} ({area:392}).",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:6251} Strahad Farsan
	["{area:392} is on the {zone:1413} coast; {npc:6251} stands on the hill in town."] = "{area:392} – на побережье зоны {zone:1413}; {npc:6251} стоит на холме в городе.",

	-- Step 4: Krom Stoutarm
	-- {npc:6294} Krom Stoutarm · {object:32356} Hall of Explorers
	["{npc:6294} stands in the {object:32356}."] = "{npc:6294} стоит здесь: {object:32356}.",

	-- Step 5: Moldy Tome
	-- {item:6931} Moldy Tome · {area:271} Southshore
	["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "{item:6931} лежит на берегу к западу (ориентир: {area:271}), за лагерями мурлоков из племени Рваного Плавника.",

	-- Step 6: Tattered Manuscript
	-- {object:92423} Damaged Chest · {area:484} Freewind Post
	["The {object:92423} lies in the canyon north of {area:484}."] = "{object:92423} лежит в ущелье к северу (ориентир: {area:484}).",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, внутри: {object:92423}",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "Жезлы направления",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Bonewarders = {npc:1057} Dragonmaw Bonewarder
	["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "Костостражи и хранители теней из клана Драконьей Пасти занимают холмы к востоку от дороги через зону {zone:1437}: жезлы падают с них.",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal
	["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "Назад: {npc:6251} ({area:392}). Используйте {quest:1804} на круге призыва рядом с ним и победите охотника Скверны, чтобы подчинить его.",
	-- {npc:6251} Strahad Farsan
	["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: он привяжет к вам охотника Скверны",
}
