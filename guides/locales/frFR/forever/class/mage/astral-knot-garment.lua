-- French (frFR): the guide forever/class/mage/astral-knot-garment (forever/class/mage/astral-knot-garment.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a blouse for Human and Gnome mages in their late 20s."] = "Une robe ou une blouse pour les mages humains et gnomes vers la fin de la vingtaine de niveaux.",

	-- Step 1: Bink (Ironforge)
	-- {npc:5144} Bink · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:5144} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:5144} forme les mages dans le {object:32362} d'{zone:1455}. Prenez ensuite le {area:2257} depuis {object:171524} jusqu'à {zone:1453}.",

	-- Step 2: Jennea Cannon (Stormwind)
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}."] = "{npc:5497} se tient dans le Sanctuaire du Sorcier, la tour du {object:2101}.",

	-- Step 3: High Sorcerer Andromath
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} is in the Wizard's Sanctum too."] = "{quest:1939} se trouve aussi dans le Sanctuaire du Sorcier.",

	-- Step 4: The Tower of Ilgalar
	-- {area:96} Tower of Ilgalar
	["The {area:96}"] = "La {area:96}",
	-- {zone:1429} Elwynn Forest
	["Ride east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "Traversez la {zone:1429} vers l'est jusqu'aux Carmines. La tour du mage déchu Ilgalar se dresse à l'est de la zone ; le traité est dans sa bibliothèque.",

	-- Step 5: Back to Andromath
	["Back to Andromath"] = "Retour auprès d'Andromath",

	-- Step 6: Carrion Recluses
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse
	["Carrion Recluses"] = "Solitaires putrides",
	-- {zone:1431} Duskwood
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Black Widow Hatchlings = {npc:930} Black Widow Hatchling
	["Carrion Recluses lurk in the woods of western {zone:1431} and each one drops the silk. The Black Widow Hatchlings further east drop it now and then."] = "Les Solitaires putrides rôdent dans les bois de l'ouest du {zone:1431} et chacun laisse tomber la soie. Les Jeunes veuves noires plus à l'est la laissent tomber de temps en temps.",

	-- Step 7: Wynne Larson
	-- {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["{npc:1309} works at {object:23296} in the {object:2101}."] = "{npc:1309} travaille chez {object:23296}, dans le {object:2101}.",
}
