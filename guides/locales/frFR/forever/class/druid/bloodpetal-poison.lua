-- French (frFR): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "De l'expérience à Un'Goro au niveau 50 et deux potions de soins ; Forever a retiré le choix d'objet de Classic.",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Lancez {spell:18960}. {npc:12042} se tient à {area:2361} ; votre maître de classe propose la même quête.",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "Prenez un vol pour {area:976}, puis allez à l'ouest jusqu'à la longue rampe qui descend dans {zone:1449} : {npc:9619} campe à son pied, dans le coin sud-est du cratère.",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "Dards de Gorishi et {item:22434}",
	-- {item:22434} Bloodcap
	-- plural, as words: Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "Les Guêpes, Ouvriers et Ravageurs Gorishi de la ruche au sud du cratère laissent tomber les dards ; les Pousses de Pétale-de-sang qui donnent le {item:22434} poussent dans toute la moitié ouest du cratère.",

	-- Step 5: Toxic Test
	-- {item:22432} Devilsaur Barb · {npc:6498} Devilsaur
	-- plural, as words: Devilsaurs = {npc:6498} Devilsaur
	["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "Utilisez l'{item:22432} sur un {npc:6498}. Les Diablosaures sont élites (niveau 54-55) et parcourent le cratère : un groupe est conseillé.",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498} : piquez-le avec l'{item:22432}",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion
	["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477} se trouve dans {area:74}, dans {zone:1435}. {npc:8580} garde le fond du temple : c'est un boss de donjon, venez en groupe.",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "Retournez voir {npc:9619} dans le coin sud-est de {zone:1449}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Lancez Téléportation : {zone:1450}. {npc:12042} se tient à {area:2361} ; votre maître de classe propose la même quête.",
}
