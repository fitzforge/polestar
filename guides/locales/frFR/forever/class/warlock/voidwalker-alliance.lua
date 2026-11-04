-- French (frFR): the guide forever/class/warlock/voidwalker-alliance (forever/class/warlock/voidwalker-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Alliance)"] = "Marcheur du Vide (Alliance)",
	-- {npc:6122} Gakin the Darkbinder
	["Your tank demon at 10: the voidwalker, after a dark sorceress's choker and a fight in {npc:6122}'s crypt."] = "Votre démon-tank au niveau 10 : le marcheur du Vide, après le collier d'une sorcière noire et un combat dans la crypte de {npc:6122}.",

	-- Step 1: Gakin's Summons (Humans)
	-- {quest:1685} Gakin's Summons
	["{quest:1685} (Humans)"] = "{quest:1685} (Humains)",
	-- {npc:6121} Remen Marcot · {area:87} Goldshire · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["At 10 {npc:6121}, in the cellar of the Lion's Pride Inn in {area:87} (the stairs down are in the back room past the butcher's table), sends you to {npc:6122} in {zone:1453}."] = "Au niveau 10, {npc:6121}, dans la cave de l'auberge de la Fierté du lion à {area:87} (l'escalier qui descend est dans l'arrière-salle, après l'étal du boucher), vous envoie voir {npc:6122} à {zone:1453}.",
	-- {npc:6121} Remen Marcot
	["{npc:6121}, Lion's Pride Inn cellar"] = "{npc:6121}, cave de l'auberge de la Fierté du lion",

	-- Step 2: The Slaughtered Lamb (Gnomes)
	-- {quest:1715} The Slaughtered Lamb
	["{quest:1715} (Gnomes)"] = "{quest:1715} (Gnomes)",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 10 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257} from {object:171524}. If {npc:6120} does not offer it, go to {npc:6122} anyway: he still gives you the next quest."] = "Au niveau 10, {npc:6120}, le maître des démonistes de la {object:32383} de {zone:1455}, vous envoie voir {npc:6122} à {zone:1453}. Prenez le {area:2257} depuis {object:171524}. Si {npc:6120} ne la propose pas, allez quand même voir {npc:6122} : il vous donne malgré tout la quête suivante.",

	-- Step 3: Gakin the Darkbinder
	-- {quest:1715} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{quest:1715} is the tavern in the {object:2101}; {npc:6122} is in its cellar, down the stairs inside."] = "{quest:1715} est la taverne du {object:2101} ; {npc:6122} est dans sa cave, en bas de l'escalier intérieur.",

	-- Step 4: Surena Caledon
	-- {npc:881} Surena Caledon · {area:62} Brackwell Pumpkin Patch · {npc:473} Morgan the Collector
	["{npc:881} (level 9) is inside the farmhouse at the {area:62}, south-east Elwynn near the Redridge road. {npc:473} (level 10) and a warrior stand with her and join the fight; Morgan gouges and goes for your imp, so keep him Feared. Put your damage over time on {npc:881} first, Fear the others, and loot her choker before you finish them: it stays yours even if you die after. She throws fireballs from range and is back three minutes after she dies. Have the quest before you kill her, or the choker does not drop."] = "{npc:881} (niveau 9) est dans la ferme du {area:62}, au sud-est de la forêt d'Elwynn, près de la route des Carmines. {npc:473} (niveau 10) et un guerrier se tiennent avec elle et se joignent au combat ; Morgan utilise Suriner et s'en prend à votre diablotin, gardez-le donc sous Peur. Mettez d'abord vos dégâts sur la durée sur {npc:881}, apeurez les autres, et ramassez son collier avant de les achever : il reste à vous même si vous mourez ensuite. Elle lance des boules de feu à distance et revient trois minutes après sa mort. Ayez la quête avant de la tuer, sinon le collier ne tombe pas.",

	-- Step 5: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:6122}. He hands you the {item:6928}. The circle is hard to find: take the stairs behind {npc:6122} down; part way along the lowest corridor a side stair on the left leads into a room with a glowing purple circle in the middle. Stand on it and use the choker. The voidwalker (level 10, not elite) gets dangerous below 30% health: {spell:14868}, Corruption and {spell:348} with your imp on it, Fear when it gets close. If it beats you, use the choker again. Keep the choker: {npc:6122} takes it back."] = "Retournez voir {npc:6122}. Il vous remet le {item:6928}. Le cercle est difficile à trouver : prenez l'escalier derrière {npc:6122} pour descendre ; à mi-chemin du couloir le plus bas, un escalier latéral à gauche mène à une salle avec un cercle violet lumineux au milieu. Placez-vous dessus et utilisez le collier. Le marcheur du Vide (niveau 10, pas élite) devient dangereux sous 30 % de vie : {spell:14868}, Corruption et {spell:348} avec votre diablotin sur lui, Peur quand il s'approche. S'il vous bat, utilisez de nouveau le collier. Gardez le collier : {npc:6122} le reprend.",
	-- {item:6928} Bloodstone Choker
	["{item:6928}, on the circle in the crypt"] = "{item:6928}, sur le cercle de la crypte",
}
