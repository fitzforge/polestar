-- French (frFR): the guide forever/class/paladin/holy-mightstone (forever/class/paladin/holy-mightstone.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A one-use stone that makes you much stronger against undead for 10 minutes; the old choice rewards are gone."] = "Une pierre à usage unique qui vous rend bien plus fort contre les morts-vivants pendant 10 minutes ; les anciennes récompenses au choix ont disparu.",

	-- Step 1: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["{npc:928} is in the Cathedral of Light."] = "{npc:928} se trouve dans la cathédrale de la Lumière.",

	-- Step 2: Brandur Ironhammer
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward
	["{npc:5149} is in the {object:32362}."] = "{npc:5149} se trouve dans le {object:32362}.",

	-- Step 3: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands
	["{npc:10838} commands {area:3197} in the south of the {zone:1422}."] = "{npc:10838} commande le {area:3197}, dans le sud des {zone:1422}.",

	-- Step 4: Minion's Scourgestones
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones"] = "Pierres du Fléau des serviteurs",
	-- {zone:1422} Western Plaguelands
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["The Scourge throughout the {zone:1422} drop Minion's Scourgestones."] = "Les membres du Fléau dans toutes les {zone:1422} laissent tomber des Pierres du Fléau des serviteurs.",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "Le {area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor · {item:20606} Amber Voodoo Feather
	["{area:1477} lies in the {area:74} in eastern {zone:1435}. Inside, Gasher and {npc:5716} drop the {item:20606}, Hukku and Mijan the Blue, Zolo and Loro the Green."] = "{area:1477} se trouve dans le {area:74}, dans l'est du {zone:1435}. À l'intérieur, Balafreur et {npc:5716} laissent tomber la {item:20606}, Hukku et Mijan la bleue, Zolo et Loro la verte.",
	-- {item:20606} Amber Voodoo Feather
	["{item:20606}, inside"] = "{item:20606}, à l'intérieur",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}, inside"] = "{item:20607}, à l'intérieur",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}, inside"] = "{item:20608}, à l'intérieur",
}
