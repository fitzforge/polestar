-- German (deDE): the guide forever/class/rogue/blade-of-cunning-horde (forever/class/rogue/blade-of-cunning-horde.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Horde)"] = "{item:7298} (Horde)",
	["A dagger at 10 from your home town's rogue quests."] = "Ein Dolch mit Stufe 10 aus den Schurkenquests deiner Heimatstadt.",

	-- Step 1: Therzok
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {quest:1859} Therzok · {zone:1454} Orgrimmar
	["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}."] = "Mit 10 schickt dich {npc:3170}, der Schurkenlehrer in {area:362}, zu {quest:1859} in {zone:1454}.",

	-- Step 2: The Shattered Hand
	-- {quest:1859} Therzok · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:1963} The Shattered Hand
	["{quest:1859} stands in the {object:172960}, the canyon under the {object:172982}. Trolls: take {quest:1963} from him at 10."] = "{quest:1859} steht in {object:172960}, der Schlucht unter {object:172982}. Trolle: Nehmt mit 10 {quest:1963} bei ihm an.",

	-- Step 3: Tazan
	-- {npc:6494} Tazan · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:6494} stands on the {zone:1413} coast south of {area:392}. Kill him for his satchel."] = "{npc:6494} steht an der Küste von {zone:1413} südlich von {area:392}. Töte ihn für seine Tasche.",

	-- Step 4: Back to Therzok
	-- {npc:6446} Therzok
	["Back to {npc:6446}"] = "Zurück zu {npc:6446}",

	-- Step 5: Tazan's Key
	-- {npc:6466} Gamon · {object:172982} Valley of Strength · {item:7208} Tazan's Key · {item:7209} Tazan's Satchel
	["{npc:6466} drinks in the inn in the {object:172982}. Pick his pocket for {item:7208}, then open {item:7209}."] = "{npc:6466} trinkt im Gasthaus im {object:172982}. Bestiehl ihn um {item:7208} und öffne dann {item:7209}.",
	-- {item:7209} Tazan's Satchel
	["{item:7209}, once you have the key"] = "{item:7209}, sobald du den Schlüssel hast",
	-- {item:7295} Tazan's Logbook
	["{item:7295}, from the satchel"] = "{item:7295}, aus der Tasche",

	-- Step 6: Therzok's reward
	-- {npc:6446} Therzok
	["{npc:6446}'s reward"] = "Belohnung von {npc:6446}",

	-- Step 7: Mennet Carkad
	-- {npc:2130} Marion Call · {area:2119} Gallows' End Tavern · {area:159} Brill · {quest:1885} Mennet Carkad · {zone:1458} Undercity
	["At 10 {npc:2130}, the rogue trainer in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "Mit 10 schickt dich {npc:2130}, der Schurkenlehrer in {area:2119} in {area:159}, zu {quest:1885} in {zone:1458}.",

	-- Step 8: The Rogues' Quarter
	-- {object:36073} Rogues' Quarter
	["The {object:36073}"] = "{object:36073}",
	-- {quest:1885} Mennet Carkad · {object:36073} Rogues' Quarter
	["{quest:1885} stands in the {object:36073}."] = "{quest:1885} steht in {object:36073}.",

	-- Step 9: Astor Hadren
	-- {npc:6497} Astor Hadren · {area:228} Sepulcher
	["{npc:6497} stands north-east of the {area:228}. Take his Letter of Introduction from him."] = "{npc:6497} steht nordöstlich von {area:228}. Nimm sein Vorstellungsschreiben von ihm entgegen.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "Zurück zu {npc:6467}",

	-- Step 11: Andron Gant
	-- {npc:6522} Andron Gant
	["{npc:6522}'s ledger sits on the bookshelf beside him."] = "Das Geschäftsbuch von {npc:6522} liegt im Bücherregal neben ihm.",

	-- Step 12: Mennet Carkad and Varimathras
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras
	["{npc:6467} and {npc:2425}"] = "{npc:6467} und {npc:2425}",
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:6467} sends the ledger on to {npc:2425} in the Hall of the Dark Lady, the {object:36126}."] = "{npc:6467} schickt das Geschäftsbuch weiter an {npc:2425} in der Halle der Dunklen Fürstin, {object:36126}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Tazan"] = "Tazan",
	-- ["{item:7208}: Gamon"] = "{item:7208}: Gamon",
	-- ["{item:7209}: Tazan"] = "{item:7209}: Tazan",
}
