-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/felhunter-horde (forever/class/warlock/felhunter-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Horde)"] = "Caçador Vil (Horda)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "O Caçador Vil, o demônio para enfrentar conjuradores, e uma {item:22244} para seus fragmentos.",

	-- Step 1: Seeking Strahad (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words) · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:6251} in {area:392}."] = "No nível 30, {npc:5875}, na {object:172960} sob o {object:172982}, envia você a {npc:6251} em {area:392}.",

	-- Step 2: Seeking Strahad (Undercity)
	-- {npc:5675} Carendin Halgar · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 30 {npc:5675}, in the {object:36082}, sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "No nível 30, {npc:5675}, no {object:36082}, envia você a {npc:6251} em {area:392}. O zepelim de {zone:1420} voa para {zone:1411}.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly to {area:392}; {npc:6251} stands on the hill in town."] = "Voe até {area:392}; {npc:6251} fica na colina da cidade.",

	-- Step 4: Jorah Annison
	-- {npc:6293} Jorah Annison · {object:36082} Magic Quarter (no name in this language: may be words)
	["{npc:6293} stands in the {object:36082}."] = "{npc:6293} fica no {object:36082}.",

	-- Step 5: Moldy Tome
	-- {item:6931} Moldy Tome · {area:271} Southshore
	["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "O {item:6931} está na praia a oeste de {area:271}, depois dos acampamentos dos murlocs Rancapina.",

	-- Step 6: Tattered Manuscript
	-- {object:92423} Damaged Chest · {area:484} Freewind Post
	["The {object:92423} lies in the canyon north of {area:484}."] = "O {object:92423} está no cânion ao norte de {area:484}.",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, no {object:92423}",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "Bastões de Canalização",
	-- {zone:1437} Wetlands
	-- plural, as words: Dragonmaw Bonewarders = {npc:1057} Dragonmaw Bonewarder
	["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "Os Guarda-ossos e Guarda-sombras Presa do Dragão dominam as colinas a leste da estrada que cruza {zone:1437}: eles deixam cair os bastões.",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal
	["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "Volte a {npc:6251} em {area:392}. Use o {quest:1804} no círculo de invocação ao lado dele e derrote o Caçador Vil para vinculá-lo.",
	-- {npc:6251} Strahad Farsan
	["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: ele vincula o Caçador Vil a você",
}
