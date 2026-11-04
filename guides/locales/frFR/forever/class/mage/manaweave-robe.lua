-- French (frFR): the guide forever/class/mage/manaweave-robe (forever/class/mage/manaweave-robe.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1453} Stormwind · {zone:1432} Loch Modan
	["A robe at 15 for Alliance mages, from {zone:1453} and {zone:1432}."] = "Une robe au niveau 15 pour les mages de l'Alliance, entre {zone:1453} et le {zone:1432}.",

	-- Step 1: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire
	["{npc:328} is the {area:87} mage trainer, upstairs in the Lion's Pride Inn."] = "{npc:328} est le maître des mages de {area:87}, à l'étage de l'auberge de la Fierté du lion.",

	-- Step 2: Dink (Ironforge)
	-- {npc:7312} Dink · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:7312} forme les mages dans le {object:32362} d'{zone:1455}. Prenez ensuite le {area:2257} depuis {object:171524} jusqu'à {zone:1453}.",

	-- Step 3: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}: climb the spiral ramp and take the portal near the top. The {item:7247} and the {item:7308} lie on the table behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:5497} se tient au sommet du Sanctuaire des sorciers, la tour violette du {object:2101} : montez la rampe en spirale et prenez le portail près du sommet. Le {item:7247} et l'{item:7308} sont posés sur la table derrière elle (tous deux reviennent 5 minutes après qu'on les a pris). Vous les rendez tous les deux à la fin : gardez-les.",

	-- Step 4: The Blue Recluse
	-- {object:2169} The Blue Recluse · {object:2101} Mage Quarter · {item:7308} Cantation of Manifestation · {spell:122} Frost Nova · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["{object:2169} is the tavern in the {object:2101}. Read the {item:7308} inside to make the invisible Rift Spawns (level 16-17) show: in the basement it brings out one, on the balcony or in the kitchen two, in the main room or by the door three, so read it downstairs. They hit hard and break out of {spell:122} fast. Beat one down: it does not die but sits stunned with a spiral over its head; use the {item:7247} on it while it is stunned, then click the {item:7292} it leaves on the floor (clicking before it appears wastes a charge). You need three, and the cantation works only once every 5 minutes (logging out does not reset it), so plan on three rounds."] = "{object:2169} est la taverne du {object:2101}. Lisez l'{item:7308} à l'intérieur pour faire apparaître les Rejetons de la faille invisibles (niveau 16-17) : au sous-sol, il en fait sortir un, sur le balcon ou dans la cuisine deux, dans la salle principale ou près de la porte trois : lisez-la donc en bas. Ils frappent fort et se libèrent vite de {spell:122}. Affaiblissez-en un : il ne meurt pas mais reste étourdi avec une spirale au-dessus de la tête ; utilisez le {item:7247} sur lui pendant qu'il est étourdi, puis cliquez sur le {item:7292} qu'il laisse au sol (cliquer avant qu'il n'apparaisse gaspille une charge). Il vous en faut trois, et l'incantation ne fonctionne qu'une fois toutes les 5 minutes (se déconnecter ne la réinitialise pas) : prévoyez trois tours.",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}, jusqu'à l'étourdissement",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "{item:7247}, sur le {npc:6492} étourdi",

	-- Step 5: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "Retour auprès de {npc:5497}",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth · {area:149} Silver Stream Mine · {object:2096} Trade District
	["Any humanoid drops {item:2589}, and the Tunnel Rats in the {area:149} drop it while you gather the gems; the Auction House in the {object:2096} sells it. You hand in ten."] = "Tous les humanoïdes laissent tomber de l'{item:2589}, et les Rats des tunnels de la {area:149} en laissent tomber pendant que vous ramassez les gemmes ; l'hôtel des ventes du {object:2096} en vend. Vous en rendez dix.",

	-- Step 7: The Silver Stream Mine
	-- {area:149} Silver Stream Mine
	["The {area:149}"] = "La {area:149}",
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {zone:1432} Loch Modan · {area:149} Silver Stream Mine · {area:144} Thelsamar · {object:271} Miners' League Crates
	["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The {area:149} is at the north end of the loch, north of {area:144}; Tunnel Rat kobolds hold it. The gems come only from the tall stacked {object:271} (the cursor shows a cog over them; single boxes hold nothing): every crate gives one, there are fourteen and they come back after 3 to 5 minutes. You may have to go as deep as the end chamber for six. The same crates serve the dwarves' Filthy Paws quest."] = "Prenez le {area:2257} jusqu'à {zone:1455}, puis la route vers l'est par le tunnel de la porte Sud jusqu'au {zone:1432}. La {area:149} se trouve à l'extrémité nord du loch, au nord de {area:144} ; des kobolds Rat des tunnels l'occupent. Les gemmes ne viennent que des hautes piles de {object:271} (le curseur y affiche un engrenage ; les caisses isolées ne contiennent rien) : chaque caisse en donne une, il y en a quatorze et elles reviennent au bout de 3 à 5 minutes. Vous devrez peut-être aller jusqu'à la salle du fond pour en avoir six. Les mêmes caisses servent à la quête des nains, Pattes sales.",

	-- Step 8: Wynne Larson
	-- {zone:1453} Stormwind · {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["Back to {zone:1453} by the tram. {npc:1309} works at {object:23296} in the {object:2101}."] = "Retournez à {zone:1453} par le tram. {npc:1309} travaille chez {object:23296}, dans le {object:2101}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Humanoids drop {item:2589}; the Auction House in the {object:2096} sells it."] = "Les humanoïdes laissent tomber de l'{item:2589} ; l'hôtel des ventes du {object:2096} en vend.",
	-- ["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The dwarven miners' league left the crates in the {area:149} at the north end of the loch; Tunnel Rat troggs hold the mine."] = "Prenez le {area:2257} jusqu'à {zone:1455}, puis la route vers l'est par le tunnel de la porte Sud jusqu'au {zone:1432}. La Ligue des mineurs nains a laissé les caisses dans la {area:149}, au nord du loch ; des troggs Rat des tunnels occupent la mine.",
	-- ["{npc:328} is the {area:87} mage trainer."] = "{npc:328} est le maître des mages de {area:87}.",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:5497} se tient dans le Sanctuaire du Sorcier, la tour du {object:2101}. Le {item:7247} et l'{item:7308} se trouvent derrière elle.",
	-- ["{object:2169} is the tavern in the {object:2101}. Use the {item:7308} inside to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "{object:2169} est la taverne du {object:2101}. Utilisez l'{item:7308} à l'intérieur pour rendre visible le {npc:6492}, affaiblissez-en un avec vos sorts, puis utilisez le {item:7247} pour poser un coffret et le capturer.",
}
