-- French (frFR): the guide forever/collectibles/pets/disgusting-oozeling (forever/collectibles/pets/disgusting-oozeling.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Oozes
	["Oozes"] = "Limons",
	-- {item:20768} Oozing Bag · {npc:12387} Large Vile Slime · {zone:1422} Western Plaguelands · {item:20769} Disgusting Oozeling
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime · Devouring Oozes = {npc:1808} Devouring Ooze
	["Oozes drop the {item:20768} about once in 20-30 kills; the best are the Vile Slimes, Devouring Oozes and the {npc:12387} in the ooze field of eastern {zone:1422} (level 54-57). Open every bag: most hold potions or herbs, and only about one bag in 50 holds the {item:20769}, so expect over a thousand kills. Both the bags and the pet can be traded: unopened bags on the Auction House are lottery tickets, the pet itself the sure buy."] = "Les limons lâchent le {item:20768} environ une fois sur 20 à 30 ; les meilleurs sont les Gelées maléfiques, les Limons dévorants et la {npc:12387} dans le champ de limons de l'est des {zone:1422} (niveau 54-57). Ouvrez chaque sac : la plupart contiennent des potions ou des herbes, et seul environ un sac sur 50 contient le {item:20769}, attendez-vous donc à plus d'un millier de victimes. Les sacs comme la mascotte peuvent être échangés : les sacs non ouverts de l'hôtel des ventes sont des billets de loterie, la mascotte elle-même l'achat sûr.",
	-- plural, as words: Oozing Bags = {item:20768} Oozing Bag
	["Open your Oozing Bags"] = "Ouvrez vos Sacs vaseux",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oozes drop the {item:20768}: the Vile Slimes, Large Vile Slimes and Devouring Oozes of Western Plaguelands, and the oozes of {zone:1448}, {zone:1449} and {zone:1423}, at about 0.07-0.09% per kill in our data. The waypoint is a {npc:1806} spawn in eastern {zone:1422}."] = "Les limons laissent tomber le {item:20768} : les Gelées maléfiques, Grandes gelées maléfiques et Limons dévorants des Maleterres de l'ouest, et les limons de {zone:1448}, du {zone:1449} et des {zone:1423}, à environ 0.07-0.09% par mort selon nos données. Le point de passage est une apparition de {npc:1806} à l'est des {zone:1422}.",
	-- ["Open the {item:20768}"] = "Ouvrir le {item:20768}",
	-- ["Open the {item:20768} from your bags."] = "Ouvrez le {item:20768} depuis vos sacs.",
	-- ["Vile Slimes, {zone:1422}"] = "Gelées maléfiques, {zone:1422}",
}
