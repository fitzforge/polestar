-- French (frFR): the guide forever/class/mage/astral-knot-garment (forever/class/mage/astral-knot-garment.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a blouse for Alliance mages in their late 20s."] = "Une robe ou une blouse pour les mages de l'Alliance vers la fin de la vingtaine de niveaux.",

	-- Step 1: Bink (Ironforge)
	-- {npc:5144} Bink · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:5144} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:5144} forme les mages dans le {object:32362} d'{zone:1455}. Prenez ensuite le {area:2257} depuis {object:171524} jusqu'à {zone:1453}.",

	-- Step 2: Jennea Cannon (Stormwind)
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}; the portal near the top of the spiral ramp takes you to her."] = "{npc:5497} se tient au sommet du Sanctuaire des sorciers, la tour violette du {object:2101} ; le portail près du haut de la rampe en spirale vous mène à elle.",

	-- Step 3: High Sorcerer Andromath (Skyborne)
	-- {npc:5694} High Sorcerer Andromath
	["{npc:5694} (Skyborne)"] = "{npc:5694} (Éolides)",
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5694} High Sorcerer Andromath · {npc:5497} Jennea Cannon
	["You do not need a letter: at 26 climb the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:5694} waits on the spiral walkway, just past the door of the portal room near the top, and has the quest for you. ({npc:5497} may also offer you {npc:5694}, the pointer quest; it is only a pointer and you can skip it.)"] = "Vous n'avez pas besoin de lettre : au niveau 26, montez dans le Sanctuaire des sorciers, la tour violette du {object:2101} de {zone:1453}. {npc:5694} attend sur la passerelle en spirale, juste après la porte de la salle des portails, près du sommet, et a la quête pour vous. ({npc:5497} peut aussi vous proposer {npc:5694}, la quête d'orientation ; ce n'est qu'une indication et vous pouvez la passer.)",

	-- Step 4: High Sorcerer Andromath
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} waits on the spiral walkway of the Wizard's Sanctum, just past the door of the portal room as you walk down from the trainers."] = "{quest:1939} attend sur la passerelle en spirale du Sanctuaire des sorciers, juste après la porte de la salle des portails quand vous descendez depuis les maîtres de classe.",

	-- Step 5: The Tower of Ilgalar
	-- {area:96} Tower of Ilgalar
	["The {area:96}"] = "La {area:96}",
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {area:96} Tower of Ilgalar · {spell:2691} Mana Burn
	["Head east through {zone:1429} into Redridge, or fly to {area:69}. The {area:96} stands alone in the east of the zone. Climb to the very top floor (not the one below): the treatise is the book sticking out of the shelf where the stairs come up. Two gnoll dogs and a gnoll caster guard the shelf; the dogs' {spell:2691} interrupts the click, so fight them on the stairs out of their sight. Morganth (level 26 elite) stands across the top floor: you do not need him, keep to the left edge of the ramp so he stays put. The book is back two seconds after anyone takes it. If you die, your ghost can run up and come back to life beside it."] = "Traversez la {zone:1429} vers l'est jusqu'aux Carmines, ou volez jusqu'à {area:69}. La {area:96} se dresse isolée à l'est de la zone. Montez jusqu'au tout dernier étage (pas celui d'en dessous) : le traité est le livre qui dépasse de l'étagère là où arrive l'escalier. Deux chiens gnolls et un lanceur de sorts gnoll gardent l'étagère ; la {spell:2691} des chiens interrompt le clic, combattez-les donc dans l'escalier, hors de leur vue. Morganth (élite de niveau 26) se tient de l'autre côté du dernier étage : vous n'avez pas besoin de lui, restez sur le bord gauche de la rampe pour qu'il ne bouge pas. Le livre revient deux secondes après que quelqu'un l'a pris. Si vous mourez, votre fantôme peut remonter et revenir à la vie à côté.",

	-- Step 6: Back to Andromath
	["Back to Andromath"] = "Retour auprès d'Andromath",

	-- Step 7: Carrion Recluses
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse
	["Carrion Recluses"] = "Solitaires putrides",
	-- {area:492} Raven Hill Cemetery · {zone:1431} Duskwood · {spell:3609} Paralyzing Poison · {npc:522} Mor'Ladim
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Black Widow Hatchlings = {npc:930} Black Widow Hatchling
	["{area:492} in western {zone:1431}: the six Carrion Recluses (level 25-26, green, {spell:3609}) walk the graves, the central statue and the riverbank, and every one drops a silk; they come back after 5 minutes. The Black Widow Hatchlings (24-25) on the slopes east of the cemetery drop it about one time in six, so mix them in while you wait. {npc:522}, a level 35 elite skeleton, walks the cemetery: watch for him."] = "{area:492}, dans l'ouest du {zone:1431} : les six Solitaires putrides (niveau 25-26, verts, {spell:3609}) arpentent les tombes, la statue centrale et la berge, et chacun laisse tomber une soie ; ils reviennent au bout de 5 minutes. Les Jeunes veuves noires (24-25) sur les pentes à l'est du cimetière la laissent tomber environ une fois sur six : mêlez-les à vos victimes en attendant. {npc:522}, un squelette élite de niveau 35, arpente le cimetière : méfiez-vous de lui.",

	-- Step 8: Wynne Larson
	-- {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["{npc:1309} works at {object:23296} in the {object:2101}. The robe gives intellect, stamina and spirit; the blouse more intellect and stamina but no spirit."] = "{npc:1309} travaille chez {object:23296}, dans le {object:2101}. La robe donne intelligence, endurance et esprit ; la blouse plus d'intelligence et d'endurance mais pas d'esprit.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A robe or a blouse for Human and Gnome mages in their late 20s."] = "Une robe ou une blouse pour les mages humains et gnomes vers la fin de la vingtaine de niveaux.",
	-- ["Carrion Recluses lurk in the woods of western {zone:1431} and each one drops the silk. The Black Widow Hatchlings further east drop it now and then."] = "Les Solitaires putrides rôdent dans les bois de l'ouest du {zone:1431} et chacun laisse tomber la soie. Les Jeunes veuves noires plus à l'est la laissent tomber de temps en temps.",
	-- ["Ride east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "Traversez la {zone:1429} vers l'est jusqu'aux Carmines. La tour du mage déchu Ilgalar se dresse à l'est de la zone ; le traité est dans sa bibliothèque.",
	-- ["{npc:1309} works at {object:23296} in the {object:2101}."] = "{npc:1309} travaille chez {object:23296}, dans le {object:2101}.",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}."] = "{npc:5497} se tient dans le Sanctuaire du Sorcier, la tour du {object:2101}.",
	-- ["{quest:1939} is in the Wizard's Sanctum too."] = "{quest:1939} se trouve aussi dans le Sanctuaire du Sorcier.",
}
