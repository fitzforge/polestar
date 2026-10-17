-- French (frFR): the guide forever/collectibles/pets/disgusting-oozeling (forever/collectibles/pets/disgusting-oozeling.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Oozing Bag
	-- {item:20768} Oozing Bag · {zone:1448} Felwood · {zone:1449} Un'Goro Crater · {zone:1423} Eastern Plaguelands · {npc:1806} Vile Slime · {zone:1422} Western Plaguelands
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime · Large Vile Slimes = {npc:12387} Large Vile Slime · Devouring Oozes = {npc:1808} Devouring Ooze
	["Oozes drop the {item:20768}: the Vile Slimes, Large Vile Slimes and Devouring Oozes of Western Plaguelands, and the oozes of {zone:1448}, {zone:1449} and {zone:1423}, at about 0.07-0.09% per kill in our data. The waypoint is a {npc:1806} spawn in eastern {zone:1422}."] = "Les limons laissent tomber le {item:20768} : les Gelées maléfiques, Grandes gelées maléfiques et Limons dévorants des Maleterres de l'ouest, et les limons de {zone:1448}, du {zone:1449} et des {zone:1423}, à environ 0.07-0.09% par mort selon nos données. Le point de passage est une apparition de {npc:1806} à l'est des {zone:1422}.",
	-- {zone:1422} Western Plaguelands
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime
	["Vile Slimes, {zone:1422}"] = "Gelées maléfiques, {zone:1422}",

	-- Step 2: Open the Oozing Bag
	-- {item:20768} Oozing Bag
	["Open the {item:20768}"] = "Ouvrir le {item:20768}",
	-- {item:20768} Oozing Bag
	["Open the {item:20768} from your bags."] = "Ouvrez le {item:20768} depuis vos sacs.",
}
