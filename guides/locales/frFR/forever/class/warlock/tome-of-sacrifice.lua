-- French (frFR): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {zone:1419} Blasted Lands
	["A rare off-hand at 60, {npc:14463}'s payment for capturing a {npc:12396} in the {zone:1419}."] = "Une main gauche rare au niveau 60, le paiement de {npc:14463} pour la capture d'un {npc:12396} dans {zone:1419}.",

	-- Step 1: Daio the Decrepit
	-- {npc:14463} Daio the Decrepit · {area:73} Tainted Scar · {zone:1419} Blasted Lands
	["At 60 {npc:14463} waits in the {area:73}, the demon-filled hollow in the west of the {zone:1419}. The Scar is full of hard-hitting elites: Soulstone yourself first, then keep to the right-hand wall going in, or ride through mounted. {npc:14463} gives you two errands at once."] = "Au niveau 60, {npc:14463} attend dans la {area:73}, le creux rempli de démons à l'ouest des {zone:1419}. La Balafre est pleine d'élites qui frappent fort : posez d'abord une Pierre d'âme sur vous-même, puis longez le mur de droite en entrant, ou traversez sur votre monture. {npc:14463} vous confie deux courses à la fois.",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {item:18249} Crescent Key · {zone:1444} Feralas
	["The Wildspawn satyrs (level 55-57, elite) fill the Warpwood Quarter, {area:2577}'s eastern wing: bring a group of five. Four in five drop a blood, but they do not come back for two hours and one full clear may come up short of fifteen; reset and run it again. The back door at {area:2518} needs the {item:18249}, which drops inside this wing; until someone has it, go in by {area:2577}'s main gate in central {zone:1444}."] = "Les satyres Wildspawn (niveau 55-57, élites) remplissent le Warpwood Quarter, l'aile est de {area:2577} : venez avec un groupe de cinq. Quatre sur cinq lâchent un sang, mais ils ne reviennent pas avant deux heures et un nettoyage complet peut ne pas suffire pour quinze ; réinitialisez et recommencez. La porte de derrière, au {area:2518}, exige la {item:18249}, qui tombe dans cette aile ; tant que personne ne l'a, entrez par la porte principale de {area:2577}, au centre de {zone:1444}.",
	-- {item:18603} Satyr Blood
	["{item:18603}, from the Wildspawn inside"] = "{item:18603}, sur les Wildspawn à l'intérieur",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring · {spell:7645} Dominate Mind · {spell:710} Banish
	["The Hederine demons (level 57-60, elite) hold {area:2256} in the far south of {zone:1452}: grouping up is encouraged. Two Slayers guard the gorge past the bridge; the western tunnel leads to more Initiates, the easiest of them (watch for their {spell:7645}). A warlock can solo them one at a time with Fear or {spell:710} and damage over time, but slowly. Any of them can drop the Tears, four kills in five."] = "Les démons Hederine (niveau 57-60, élites) tiennent la {area:2256}, à l'extrême sud du {zone:1452} : mieux vaut former un groupe. Deux Tueurs gardent la gorge après le pont ; le tunnel ouest mène à d'autres Initiés, les plus faciles d'entre eux (méfiez-vous de leur {spell:7645}). Un démoniste peut les battre seul un par un avec Peur ou {spell:710} et des dégâts sur la durée, mais lentement. N'importe lequel peut lâcher les larmes, quatre fois sur cinq.",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {spell:45} War Stomp · {item:18605} Imprisoned Doomguard
	["Hand both in to {npc:14463} and take the {item:18601}. Find a {npc:12396} (level 61, elite) standing alone in the {area:73}, open from about 30 yards with your voidwalker on him, and channel the prison on him for about 20 seconds: he attacks you to break free, and his {spell:45} can interrupt the channel, so sacrifice the voidwalker for its shield if you must. Grouping up is encouraged: a second player to tank makes it easy. When the channel finishes he becomes the {item:18605}: click it. If the channel breaks, kill him or run, and try another."] = "Rendez les deux à {npc:14463} et prenez la {item:18601}. Trouvez un {npc:12396} (niveau 61, élite) seul dans la {area:73}, engagez à une trentaine de mètres avec votre marcheur du Vide sur lui, et canalisez la prison sur lui pendant une vingtaine de secondes : il vous attaque pour se libérer, et son {spell:45} peut interrompre la canalisation, sacrifiez donc le marcheur du Vide pour son bouclier s'il le faut. Mieux vaut former un groupe : un second joueur pour encaisser rend la chose facile. Quand la canalisation se termine, il devient le {item:18605} : cliquez dessus. Si la canalisation est interrompue, tuez-le ou fuyez, et essayez sur un autre.",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on a {npc:12396}"] = "{item:18601}, sur un {npc:12396}",
	-- {item:18605} Imprisoned Doomguard
	["{item:18605}, click it"] = "{item:18605}, cliquez dessus",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "Retour auprès de {npc:14463}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "Au niveau 60, {npc:14463} attend dans {area:73}, à l'ouest de {zone:1419}.",
	-- ["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "Rendez les deux à {npc:14463}, puis trouvez {npc:12396} dans {area:73} et utilisez {item:18601} sur lui. Il est élite et se bat pour s'échapper : il est conseillé de grouper.",
	-- ["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "Les démons Hederine tiennent {area:2256}, au sud de {zone:1452}. Ils sont élites : il est conseillé de grouper.",
	-- ["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "Les satyres Follengeance du quartier Crochebois, l'aile est de {area:2577}, portent le sang. La porte de derrière, à {area:2518} au nord de {area:1099}, exige {item:18249} ; sinon, entrez par l'entrée principale de {area:2577}. Venez en groupe.",
	-- ["{item:18601}, on the {npc:12396}"] = "{item:18601}, sur {npc:12396}",
	-- ["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}, dans le quartier Crochebois",
}
