-- Spanish (Spain) (esES): the guide forever/class/mage/nether-lace-garment (forever/class/mage/nether-lace-garment.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a tunic for Undead and Troll mages in their late 20s."] = "Una toga o una túnica para magos no-muertos y trols de casi nivel 30.",

	-- Step 1: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {object:36082} Magic Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:4568} stands in the {zone:1458}'s {object:36082}. Trolls take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568} está en {object:36082} de {zone:1458}. Los trols toman el zepelín de {zone:1454} a {zone:1420} para verla.",

	-- Step 2: Deino
	-- {zone:1454} Orgrimmar · {npc:5885} Deino
	["Take the zeppelin to {zone:1454}. {npc:5885} is one of {zone:1454}'s mage trainers."] = "Toma el zepelín a {zone:1454}. {npc:5885} es uno de los instructores de magos de {zone:1454}.",

	-- Step 3: The Xavian Waterfall
	-- {object:174797} Xavian Waterfall (no name in this language: may be words)
	["The {object:174797}"] = "{object:174797}",
	-- {area:429} Xavian · {zone:1440} Ashenvale · {spell:9052} Fill Deino's Flask
	["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. {spell:9052} at the bottom of the highest waterfall."] = "Los sátiros ocupan las ruinas de {area:429} en el este de {zone:1440}. {spell:9052} al pie de la cascada más alta.",

	-- Step 4: Back to Deino
	-- {npc:5885} Deino
	["Back to {npc:5885}"] = "Vuelve con {npc:5885}",

	-- Step 5: The Laughing Sisters
	-- {quest:1945} Laughing Sisters
	["The {quest:1945}"] = "Las {quest:1945}",
	-- {quest:1945} Laughing Sisters · {area:426} Raynewood Retreat · {zone:1440} Ashenvale
	["The {quest:1945}, dryads, gather near the {area:426} in central {zone:1440}."] = "Las {quest:1945}, unas dríadas, se reúnen cerca de {area:426}, en el centro de {zone:1440}.",

	-- Step 6: Kil'hala
	-- {npc:3484} Kil'hala · {area:380} Crossroads
	["{npc:3484}, a troll tailor, works at the {area:380}."] = "{npc:3484}, una sastre trol, trabaja en {area:380}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. Fill {item:7269} at the bottom of the highest waterfall."] = "Los sátiros ocupan las ruinas de {area:429} en el este de {zone:1440}. Llena el {item:7269} al pie de la cascada más alta.",
}
