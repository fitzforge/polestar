-- French (frFR): the guide forever/collectibles/pets/musical-gustjumper (forever/collectibles/pets/musical-gustjumper.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Aéronef depuis {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either)."] = "L'{zone:2521} est l'île de départ des Éolides ; d'après les retours de la bêta, tout le monde peut la visiter. Un brise-ciel part du côté nord de {area:279} environ toutes les cinq minutes (un autre vole depuis le nord des {zone:1456} ; chaque faction peut prendre l'un ou l'autre).",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Aéronef vers {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Aéronef depuis les {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either)."] = "L'{zone:2521} est l'île de départ des Éolides ; d'après les retours de la bêta, tout le monde peut la visiter. Un brise-ciel part des falaises au sud du {area:17045}, au nord des {zone:1456}, environ toutes les cinq minutes (un autre vole depuis {area:279} ; chaque faction peut prendre l'un ou l'autre).",

	-- Step 3: Sing to the frogs
	["Sing to the frogs"] = "Chanter pour les grenouilles",
	-- {area:16635} Thendal Village · {item:268109} Musical Gustjumper
	["From {area:16635} follow the road south, then cut across the field to the top of the waterfall: five frogs sit together on a rock there, by a log. Mobs patrol nearby, so a level 1 character should watch its back. Stand by the rock, target a frog and type /sing. The frogs sing back, the group disappears and one frog hops onto the log beside you: click it to take the {item:268109}, then use it to learn the pet. The item is not bound until you use it, so a friend on the island can sing again and trade you one."] = "Depuis {area:16635}, suivez la route vers le sud, puis coupez à travers le champ jusqu'en haut de la cascade : cinq grenouilles y sont assises ensemble sur un rocher, près d'un tronc. Des monstres patrouillent à proximité, un personnage de niveau 1 doit donc surveiller ses arrières. Placez-vous près du rocher, ciblez une grenouille et tapez /chanter. Les grenouilles chantent en retour, le groupe disparaît et une grenouille saute sur le tronc à côté de vous : cliquez dessus pour prendre le {item:268109}, puis utilisez-le pour apprendre la mascotte. L'objet n'est pas lié tant que vous ne l'utilisez pas : un ami sur l'île peut donc chanter de nouveau et vous en échanger un.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Target one of the frogs here and type /sing; a {item:268109} appears. Interact with it to get the pet."] = "Ciblez une des grenouilles ici et tapez /sing ; un {item:268109} apparaît. Interagissez avec pour obtenir la mascotte.",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} est l'île de départ des Éolides ; tout le monde peut s'y rendre. Un aéronef part des falaises au sud du {area:17045}, au nord des {zone:1456}, environ toutes les cinq minutes (un autre part de {area:279} ; chaque faction peut prendre l'un ou l'autre). Passez cette étape si vous êtes déjà sur l'île.",
	-- ["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} est l'île de départ des Éolides ; tout le monde peut s'y rendre. Un aéronef part du côté nord de {area:279} environ toutes les cinq minutes (un autre part du nord des {zone:1456} ; chaque faction peut prendre l'un ou l'autre). Passez cette étape si vous êtes déjà sur l'île.",
}
