-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/blade-of-cunning-horde (forever/class/rogue/blade-of-cunning-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Horde)"] = "{item:7298} (Horda)",
	["A dagger at 10 from your home town's rogue quests."] = "Uma adaga no nível 10, das missões de ladino da sua cidade natal.",

	-- Step 1: Therzok
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {quest:1859} Therzok · {zone:1454} Orgrimmar
	["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}."] = "No nível 10, {npc:3170}, o instrutor de ladinos em {area:362}, envia você a {quest:1859} em {zone:1454}.",

	-- Step 2: The Shattered Hand
	-- {quest:1859} Therzok · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words) · {quest:1963} The Shattered Hand
	["{quest:1859} stands in the {object:172960}, the canyon under the {object:172982}. Trolls: take {quest:1963} from him at 10."] = "{quest:1859} fica na {object:172960}, o cânion sob o {object:172982}. Trolls: peguem {quest:1963} com ele no nível 10.",

	-- Step 3: Tazan
	-- {npc:6494} Tazan · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:6494} stands on the {zone:1413} coast south of {area:392}. Kill him for his satchel."] = "{npc:6494} fica no litoral dos {zone:1413}, ao sul de {area:392}. Mate-o para pegar a algibeira.",

	-- Step 4: Back to Therzok
	-- {npc:6446} Therzok
	["Back to {npc:6446}"] = "Volte a {npc:6446}",

	-- Step 5: Tazan's Key
	-- {npc:6466} Gamon · {object:172982} Valley of Strength (no name in this language: may be words) · {item:7208} Tazan's Key · {item:7209} Tazan's Satchel
	["{npc:6466} drinks in the inn in the {object:172982}. Pick his pocket for {item:7208}, then open {item:7209}."] = "{npc:6466} bebe na estalagem do {object:172982}. Bata a carteira dele para pegar a {item:7208} e abra a {item:7209}.",
	-- {item:7209} Tazan's Satchel
	["{item:7209}, once you have the key"] = "{item:7209}, depois de ter a chave",
	-- {item:7295} Tazan's Logbook
	["{item:7295}, from the satchel"] = "{item:7295}, da algibeira",

	-- Step 6: Therzok's reward
	-- {npc:6446} Therzok
	["{npc:6446}'s reward"] = "Recompensa de {npc:6446}",

	-- Step 7: Mennet Carkad
	-- {npc:2130} Marion Call · {area:2119} Gallows' End Tavern · {area:159} Brill · {quest:1885} Mennet Carkad · {zone:1458} Undercity
	["At 10 {npc:2130}, the rogue trainer in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "No nível 10, {npc:2130}, a instrutora de ladinos na {area:2119} em {area:159}, envia você a {quest:1885} na {zone:1458}.",

	-- Step 8: The Rogues' Quarter
	-- {object:36073} Rogues' Quarter (no name in this language: may be words)
	["The {object:36073}"] = "{object:36073}",
	-- {quest:1885} Mennet Carkad · {object:36073} Rogues' Quarter (no name in this language: may be words)
	["{quest:1885} stands in the {object:36073}."] = "{quest:1885} fica no {object:36073}.",

	-- Step 9: Astor Hadren
	-- {npc:6497} Astor Hadren · {area:228} Sepulcher
	["{npc:6497} stands north-east of the {area:228}. Take his Letter of Introduction from him."] = "{npc:6497} fica a nordeste de {area:228}. Pegue com ele a Carta de Apresentação do Astolfo.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "Volte a {npc:6467}",

	-- Step 11: Andron Gant
	-- {npc:6522} Andron Gant
	["{npc:6522}'s ledger sits on the bookshelf beside him."] = "O livro-caixa de {npc:6522} está na estante ao lado dele.",

	-- Step 12: Mennet Carkad and Varimathras
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras
	["{npc:6467} and {npc:2425}"] = "{npc:6467} e {npc:2425}",
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras · {object:36126} Royal Quarter (no name in this language: may be words)
	["{npc:6467} sends the ledger on to {npc:2425} in the Hall of the Dark Lady, the {object:36126}."] = "{npc:6467} envia o livro-caixa a {npc:2425} no Salão da Dama Sombria, o {object:36126}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Tazan"] = "Tazan",
	-- ["{item:7208}: Gamon"] = "{item:7208}: Gamon",
	-- ["{item:7209}: Tazan"] = "{item:7209}: Tazan",
}
