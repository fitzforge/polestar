-- French (frFR): the guide forever/class/rogue/the-eye-of-bhossca (forever/class/rogue/the-eye-of-bhossca.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277246} Ruby-Adorned Blade · {area:796} Scarlet Monastery
	["The {item:277246}, C's payment for a solo job inside the {area:796}."] = "{item:277246}, le paiement de C pour une mission en solo dans le {area:796}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "La boîte aux lettres de C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. C's next note waits there once you are 25."] = "{object:410369} est un coffre près de {area:204}, dans le sud de la Forêt des Pins argentés (Silverpine Forest), juste au sud du {area:236}. La note suivante de C vous y attend une fois au niveau 25.",

	-- Step 2: The Scarlet Monastery
	-- {area:796} Scarlet Monastery
	["The {area:796}"] = "Le {area:796}",
	-- {zone:1420} Tirisfal Glades
	["The monastery stands in the far north-east of {zone:1420}. Go in alone; C advises a disguise from the monastery's grounds before you enter."] = "Le monastère se dresse à l'extrême nord-est de {zone:1420}. Entrez seul ; C conseille de prendre un déguisement aux abords du monastère avant d'entrer.",
	-- {area:796} Scarlet Monastery
	["Find the Eye of Bhossca inside the {area:796}."] = "Trouvez l'Œil de Bhossca dans le {area:796}.",

	-- Step 3: Back to the dead drop
	["Back to the dead drop"] = "Retour à la boîte aux lettres",
	-- {object:410369} Dead Drop
	["Place the eye in the {object:410369} near Pyrewood. C's payment is the second Eye of Bhossca quest at the same chest."] = "Déposez l'œil dans {object:410369}, près de Bois-du-Bûcher. Le paiement de C est la seconde quête « L'Œil de Bhossca », au même coffre.",
}
