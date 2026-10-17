-- Russian (ruRU): the guide forever/class/mage/nether-lace-garment (forever/class/mage/nether-lace-garment.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a tunic for Undead and Troll mages in their late 20s."] = "Мантия или туника для магов-нежити и магов-троллей ближе к 30-му уровню.",

	-- Step 1: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {object:36082} Magic Quarter · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:4568} stands in the {zone:1458}'s {object:36082}. Trolls take the zeppelin from {zone:1454} to {zone:1420} for her."] = "{npc:4568} стоит здесь: {zone:1458}, {object:36082}. Тролли летят к ней на дирижабле из города {zone:1454} в {zone:1420}.",

	-- Step 2: Deino
	-- {zone:1454} Orgrimmar · {npc:5885} Deino
	["Take the zeppelin to {zone:1454}. {npc:5885} is one of {zone:1454}'s mage trainers."] = "Летите на дирижабле в {zone:1454}. {npc:5885} — один из учителей магов города {zone:1454}.",

	-- Step 3: The Xavian Waterfall
	-- {object:174797} Xavian Waterfall
	["The {object:174797}"] = "Объект: {object:174797}",
	-- {area:429} Xavian · {zone:1440} Ashenvale · {spell:9052} Fill Deino's Flask
	["Satyrs hold the ruins of {area:429} in eastern {zone:1440}. {spell:9052} at the bottom of the highest waterfall."] = "Сатиры занимают руины ({area:429}) на востоке зоны {zone:1440}. {spell:9052}: у подножия самого высокого водопада.",

	-- Step 4: Back to Deino
	-- {npc:5885} Deino
	["Back to {npc:5885}"] = "Вернитесь: {npc:5885}",

	-- Step 5: The Laughing Sisters
	-- {quest:1945} Laughing Sisters
	["The {quest:1945}"] = "Цель: {quest:1945}",
	-- {quest:1945} Laughing Sisters · {area:426} Raynewood Retreat · {zone:1440} Ashenvale
	["The {quest:1945}, dryads, gather near the {area:426} in central {zone:1440}."] = "{quest:1945}, дриады, собираются у места {area:426} в центре зоны {zone:1440}.",

	-- Step 6: Kil'hala
	-- {npc:3484} Kil'hala · {area:380} Crossroads
	["{npc:3484}, a troll tailor, works at the {area:380}."] = "{npc:3484}, портниха-тролль, работает здесь: {area:380}.",
}
