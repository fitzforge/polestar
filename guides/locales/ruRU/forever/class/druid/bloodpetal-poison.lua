-- Russian (ruRU): the guide forever/class/druid/bloodpetal-poison (forever/class/druid/bloodpetal-poison.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Experience in Un'Goro at 50 and two healing potions; Forever removed the Classic item choice."] = "Опыт в Кратере Ун'Горо на 50-м уровне и два лечебных зелья; в Forever убрали выбор предмета из Classic.",

	-- Step 1: Loganaar
	-- {spell:18960} Teleport: Moonglade · {npc:12042} Loganaar · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:12042} stands in {area:2361}; your class trainer offers the same quest."] = "Примените {spell:18960}. {npc:12042} стоит здесь: {area:2361}; ваш учитель класса дает то же задание.",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Fly to {area:976}, ride west to the long ramp down into {zone:1449}: {npc:9619} camps at its foot, in the south-east corner of the crater."] = "Летите сюда: {area:976}. Скачите на запад к длинному спуску в {zone:1449}: {npc:9619} разбил лагерь у его подножия, в юго-восточном углу кратера.",

	-- Step 3: Gorishi Stings and Bloodcap
	-- {item:22434} Bloodcap
	-- plural, as words: Gorishi Stings = {item:22435} Gorishi Sting
	["Gorishi Stings and {item:22434}"] = "Жала Гориши и {item:22434}",
	-- {item:22434} Bloodcap
	-- plural, as words: Bloodpetal Sprouts = {object:164958} Bloodpetal Sprout
	["The Gorishi wasps, workers and reavers of the hive in the south of the crater drop the stings; the Bloodpetal Sprouts that give the {item:22434} grow all over the crater's western half."] = "Осы, рабочие и разорители из улья Гориши на юге кратера оставляют жала; побеги кровоцвета, дающие {item:22434}, растут по всей западной половине кратера.",

	-- Step 5: Toxic Test
	-- {item:22432} Devilsaur Barb · {npc:6498} Devilsaur
	-- plural, as words: Devilsaurs = {npc:6498} Devilsaur
	["Use the {item:22432} on a {npc:6498}. Devilsaurs are elite (level 54-55) and roam the crater: grouping up is advised."] = "Используйте {item:22432} на цели {npc:6498}. Девизавры — элитные (уровень 54-55) и бродят по кратеру: лучше собрать группу.",
	-- {npc:6498} Devilsaur · {item:22432} Devilsaur Barb
	["{npc:6498}: stab it with the {item:22432}"] = "{npc:6498}: уколите его ({item:22432})",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:8580} Atal'alarion
	["{area:1477} lies in the {area:74} in the {zone:1435}. {npc:8580} guards the bottom of the temple: a dungeon boss, so bring a group."] = "{area:1477} находится здесь: {area:74} ({zone:1435}). {npc:8580} охраняет дно храма: это босс подземелья, так что возьмите группу.",

	-- Step 8: A Better Ingredient
	-- {npc:9619} Torwa Pathfinder · {zone:1449} Un'Goro Crater
	["Back to {npc:9619} in the south-east corner of {zone:1449}."] = "Вернитесь к Землепроходцу {npc:9619} в юго-восточный угол кратера: {zone:1449}.",
}
