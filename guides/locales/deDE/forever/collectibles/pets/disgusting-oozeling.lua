-- German (deDE): the guide forever/collectibles/pets/disgusting-oozeling (forever/collectibles/pets/disgusting-oozeling.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Oozes
	["Oozes"] = "Schlammbestien",
	-- {item:20768} Oozing Bag · {npc:12387} Large Vile Slime · {zone:1422} Western Plaguelands · {item:20769} Disgusting Oozeling
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime · Devouring Oozes = {npc:1808} Devouring Ooze
	["Oozes drop the {item:20768} about once in 20-30 kills; the best are the Vile Slimes, Devouring Oozes and the {npc:12387} in the ooze field of eastern {zone:1422} (level 54-57). Open every bag: most hold potions or herbs, and only about one bag in 50 holds the {item:20769}, so expect over a thousand kills. Both the bags and the pet can be traded: unopened bags on the Auction House are lottery tickets, the pet itself the sure buy."] = "Schleime lassen den {item:20768} etwa bei jedem 20.-30. Kill fallen; am besten sind die Vile Slimes, Devouring Oozes und der {npc:12387} im Schleimfeld im Osten von {zone:1422} (Stufe 54-57). Öffne jede Tasche: Die meisten enthalten Tränke oder Kräuter, und nur etwa jede 50. Tasche enthält den {item:20769}, rechne also mit über tausend Kills. Sowohl die Taschen als auch das Haustier sind handelbar: Ungeöffnete Taschen im Auktionshaus sind Lose, das Haustier selbst der sichere Kauf.",
	-- plural, as words: Oozing Bags = {item:20768} Oozing Bag
	["Open your Oozing Bags"] = "Öffne deine Oozing Bags",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oozes drop the {item:20768}: the Vile Slimes, Large Vile Slimes and Devouring Oozes of Western Plaguelands, and the oozes of {zone:1448}, {zone:1449} and {zone:1423}, at about 0.07-0.09% per kill in our data. The waypoint is a {npc:1806} spawn in eastern {zone:1422}."] = "Schlammer droppen den {item:20768}: die Bösen Brühschleimer, Großen bösen Brühschleimer und Verschlingenden Brühschlammer in den Westlichen Pestländern sowie die Schlammer in {zone:1448}, {zone:1449} und {zone:1423}, laut unseren Daten zu etwa 0,07-0,09% pro Kill. Der Wegpunkt ist ein Spawn von {npc:1806} im Osten von {zone:1422}.",
	-- ["Open the {item:20768}"] = "Öffne den {item:20768}",
	-- ["Open the {item:20768} from your bags."] = "Öffne den {item:20768} aus deinen Taschen.",
	-- ["Vile Slimes, {zone:1422}"] = "Böse Brühschleimer, {zone:1422}",
}
