-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6266} Menara Voidrender
	["A rare cloth robe for your 30s, which {npc:6266} makes from the parts you bring her."] = "Um manto de tecido raro para seus 30 e poucos, que {npc:6266} faz com as partes que você trouxer.",

	-- Step 1: In Search of Menara Voidrender (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "No nível 31, {npc:461} no {object:2164}, no {object:2101}, manda você até {npc:6266} em {area:392}.",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "No nível 31, {npc:5172} em {zone:1455} manda você até {npc:6266} em {area:392}.",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "No nível 31, {npc:3326} na {object:172960} manda você até {npc:6266} em {area:392}.",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "No nível 31, {npc:4563} no {object:36082} manda você até {npc:6266} em {area:392}. O zepelim de {zone:1420} voa para {zone:1411}.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} fica na torre da colina acima de {area:392}, ao lado de {npc:6251}.",

	-- Step 6: Robes of Arcana
	-- {npc:6266} Menara Voidrender · {item:5770} Robes of Arcana · {item:3577} Gold Bar · {item:2776} Gold Ore
	["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "Leve a {npc:6266} um {item:5770}: alfaiates o costuram com um molde que cai; senão, compre um na Casa de Leilões. A tarefa seguinte dela exige uma {item:3577}: fundida de {item:2776}, ou da Casa de Leilões.",

	-- Step 7: Xizk Goodstitch
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {item:3577} Gold Bar
	["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670} vende suprimentos de alfaiataria em {area:35}. Leve a ele a {item:3577}.",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "De volta a {npc:6266}",

	-- Step 9: Desolace demons
	-- {zone:1443} Desolace
	["{zone:1443} demons"] = "Demônios de {zone:1443}",
	-- {area:603} Sargeron · {zone:1443} Desolace
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal
	["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "Os sátiros Furiódio de {area:603}, no nordeste de {zone:1443}, carregam o sangue; os Infernais Menores da Ruínas de Mannoroc, no sul, a pedra.",
	["Vials of Hatefury Blood"] = "Ampolas de Sangue de Furiódio",

	-- Step 10: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "{npc:6266} de novo",

	-- Step 11: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:2670} in {area:35} has the thread for you."] = "{npc:2670} em {area:35} tem a linha para você.",

	-- Step 12: Smoldering Coal
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "Os Exilados em Chamas, elementais do fogo no oeste das {zone:1417}, deixam cair o carvão.",

	-- Step 13: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coal and a {item:6265}. Wait while she completes the robe, then speak to her again."] = "De volta a {npc:6266} com a linha, o carvão e um {item:6265}. Espere enquanto ela termina o manto, depois fale com ela de novo.",
	["Wait for the robe"] = "Espere o manto",
}
