-- Portuguese (Brazil) (ptBR): the guide forever/class/paladin/holy-mightstone (forever/class/paladin/holy-mightstone.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A one-use stone that makes you much stronger against undead for 10 minutes; the old choice rewards are gone."] = "Uma pedra de uso único que o deixa muito mais forte contra mortos-vivos por 10 minutos; as antigas recompensas à escolha foram removidas.",

	-- Step 1: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["{npc:928} is in the Cathedral of Light."] = "{npc:928} fica na Catedral da Luz.",

	-- Step 2: Brandur Ironhammer
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:5149} is in the {object:32362}."] = "{npc:5149} fica na {object:32362}.",

	-- Step 3: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands
	["{npc:10838} commands {area:3197} in the south of the {zone:1422}."] = "{npc:10838} comanda o {area:3197}, no sul das {zone:1422}.",

	-- Step 4: Minion's Scourgestones
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones"] = "Pedras do Flagelo do Lacaio",
	-- {zone:1422} Western Plaguelands
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["The Scourge throughout the {zone:1422} drop Minion's Scourgestones."] = "O Flagelo em todas as {zone:1422} solta Pedras do Flagelo do Lacaio.",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor · {item:20606} Amber Voodoo Feather
	["{area:1477} lies in the {area:74} in eastern {zone:1435}. Inside, Gasher and {npc:5716} drop the {item:20606}, Hukku and Mijan the Blue, Zolo and Loro the Green."] = "{area:1477} fica no {area:74}, no leste do {zone:1435}. Lá dentro, Talho e {npc:5716} soltam a {item:20606}, Hukkah e Mirran a azul, Zolo e Lorro a verde.",
	-- {item:20606} Amber Voodoo Feather
	["{item:20606}, inside"] = "{item:20606}, lá dentro",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}, inside"] = "{item:20607}, lá dentro",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}, inside"] = "{item:20608}, lá dentro",
}
