-- French (frFR): the guide forever/class/rogue/blade-of-cunning-horde (forever/class/rogue/blade-of-cunning-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Horde)"] = "{item:7298} (Horde)",
	["A dagger at 10 from your home town's rogue quests."] = "Une dague au niveau 10, grâce aux quêtes de voleur de votre ville natale.",

	-- Step 1: Therzok
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {quest:1859} Therzok · {zone:1454} Orgrimmar · {quest:1963} The Shattered Hand
	["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}. It is only a pointer: an Orc already in {zone:1454} can skip it and take {quest:1963} from {quest:1859} straight away."] = "",

	-- Step 2: The Shattered Hand
	-- {quest:1859} Therzok · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:1963} The Shattered Hand
	["{quest:1859} stands in the {object:172960}, the canyon under the {object:172982}. Trolls: take {quest:1963} from him at 10."] = "{quest:1859} se tient dans la {object:172960}, le canyon sous la {object:172982}. Trolls : prenez {quest:1963} auprès de lui au niveau 10.",

	-- Step 3: Tazan
	-- {npc:6494} Tazan · {area:391} Merchant Coast · {area:392} Ratchet
	["{npc:6494} (level 13, not elite) is a troll pirate on the {area:391} south of {area:392}: he walks the fenced hill path between the lower pirate camp by the beached ship and the upper camp by a big tree. Fight him at the foot of the hill, away from the camps. He always drops his satchel and is back 4 1/2 minutes after a death; one satchel per kill, so two rogues need two kills. Hand the satchel in unopened: picking its lock now destroys it and you must kill him again."] = "",

	-- Step 4: Back to Therzok
	-- {npc:6446} Therzok
	["Back to {npc:6446}"] = "Retour auprès de {npc:6446}",

	-- Step 5: Tazan's Key
	-- {quest:1859} Therzok · {npc:6466} Gamon · {object:172982} Valley of Strength · {item:7208} Tazan's Key · {item:7209} Tazan's Satchel · {spell:1804} Pick Lock
	["{quest:1859} hands the satchel back: now open it. {npc:6466} (level 12) kneels by the innkeeper in the inn in the {object:172982}; stealth up and pick his pocket for {item:7208} (do not kill him: the key almost never drops). Players often kill him, so you may wait up to 5 minutes for him. Then use the key on {item:7209} in your bags. If you have trained {spell:1804}, you can pick the satchel's lock instead."] = "",
	-- {item:7208} Tazan's Key
	["{item:7208}: Pick Pocket Gamon"] = "",
	-- {item:7209} Tazan's Satchel
	["{item:7209}, once you have the key"] = "{item:7209}, une fois la clé en main",
	-- {item:7295} Tazan's Logbook
	["{item:7295}, from the satchel"] = "{item:7295}, dans la sacoche",

	-- Step 6: Therzok's reward
	-- {npc:6446} Therzok
	["{npc:6446}'s reward"] = "Récompense de {npc:6446}",

	-- Step 7: Mennet Carkad
	-- {npc:2130} Marion Call · {area:2119} Gallows' End Tavern · {area:159} Brill · {quest:1885} Mennet Carkad · {zone:1458} Undercity
	["At 10 {npc:2130}, the rogue trainer upstairs in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "",

	-- Step 8: The Rogues' Quarter
	-- {object:36073} Rogues' Quarter
	["The {object:36073}"] = "Le {object:36073}",
	-- {quest:1885} Mennet Carkad · {object:36073} Rogues' Quarter
	["{quest:1885} stands in the {object:36073}."] = "{quest:1885} se tient dans le {object:36073}.",

	-- Step 9: Astor Hadren
	-- {npc:6497} Astor Hadren · {area:228} Sepulcher · {zone:1458} Undercity
	["{npc:6497} (level 13) walks the road between the {area:228} and the {zone:1458}, north of the {area:228}. He looks like a friendly traveller with no quest mark. Talk to him and pick both of his answers: he turns hostile. Kill him for the letter (it always drops). Fight him away from guards, who can take the kill and leave no loot; only one rogue per kill gets the letter. He is back 5 minutes after a death."] = "",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "Retour auprès de {npc:6467}",

	-- Step 11: Andron Gant
	-- {npc:6522} Andron Gant
	["{npc:6522} is in the Apothecarium, in its biggest room, where two huge guards watch a small bridge. His ledger is on the bookshelf in the back room behind him, not the shelf on the wall next to him."] = "",

	-- Step 12: Mennet Carkad and Varimathras
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras
	["{npc:6467} and {npc:2425}"] = "{npc:6467} et {npc:2425}",
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras · {object:36126} Royal Quarter · {npc:6522} Andron Gant
	["{npc:6467} sends the ledger on to {npc:2425}, the big demon in the middle of the Hall of the Dark Lady in the {object:36126}, past its elite guards; the way in is the passage off the Apothecarium. If you lose the ledger, take another from {npc:6522}'s bookshelf."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:2130}, the rogue trainer in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "Au niveau 10, {npc:2130}, la maîtresse des voleurs de la {area:2119} à {area:159}, vous envoie voir {quest:1885} à {zone:1458}.",
	-- ["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}."] = "Au niveau 10, {npc:3170}, le maître des voleurs de {area:362}, vous envoie voir {quest:1859} à {zone:1454}.",
	-- ["Tazan"] = "Tazan",
	-- ["{item:7208}: Gamon"] = "{item:7208} : Gamon",
	-- ["{item:7209}: Tazan"] = "{item:7209} : Tazan",
	-- ["{npc:6466} drinks in the inn in the {object:172982}. Pick his pocket for {item:7208}, then open {item:7209}."] = "{npc:6466} boit à l'auberge de la {object:172982}. Faites-lui les poches pour obtenir la {item:7208}, puis ouvrez la {item:7209}.",
	-- ["{npc:6467} sends the ledger on to {npc:2425} in the Hall of the Dark Lady, the {object:36126}."] = "{npc:6467} transmet le registre à {npc:2425}, dans la salle de la Dame noire, le {object:36126}.",
	-- ["{npc:6494} stands on the {zone:1413} coast south of {area:392}. Kill him for his satchel."] = "{npc:6494} se tient sur la côte des {zone:1413} au sud de {area:392}. Tuez-le pour prendre sa sacoche.",
	-- ["{npc:6497} stands north-east of the {area:228}. Take his Letter of Introduction from him."] = "{npc:6497} se tient au nord-est du {area:228}. Prenez-lui sa lettre d'introduction.",
	-- ["{npc:6522}'s ledger sits on the bookshelf beside him."] = "Le registre de {npc:6522} se trouve sur l'étagère à côté de lui.",
}
