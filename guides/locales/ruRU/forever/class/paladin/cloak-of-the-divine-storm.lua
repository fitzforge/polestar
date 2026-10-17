-- Russian (ruRU): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:407778} Divine Storm
	["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "Редкий плащ на 30-м уровне из старой истории о заклинании «{spell:407778}»; пока завершить ее могут только паладины Альянса.",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "Странная сфера",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "Поднимитесь на вершину башни ({area:444}) на севере зоны {zone:1439}. Обыщите там странную сферу: она дает Сферу Алталакса, с которой начинается задание.",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "Странная сфера на вершине башни ({area:444}): щелкните правой кнопкой по Сфере Алталакса, которую она дает",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663} стоит здесь: {area:413}, запад зоны {zone:1440}.",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} is in the Cathedral of Light."] = "{npc:5492} – в Соборе Света.",

	-- Step 4: Ursula Deline
	-- {object:2101} Mage Quarter · {npc:5495} Ursula Deline
	["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "Катерина отправляет вас к чернокнижникам ({object:2101}); от их имени говорит {npc:5495}.",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner
	["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "Призыватели, воители и следопыты из клана Черной Горы стоят лагерем на северо-западе Красногорья; с них падает {item:209778}.",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "Назад к {npc:5495}",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "Частицы Маннорота",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "{area:435} – на юго-востоке зоны {zone:1440}. С бичевательниц Маннорока, опаляющих инферналов, стражей Скверны и гончих Легиона там падают частицы Маннорота.",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth
	["The {object:409311}"] = "{object:409311}",
	-- {object:409311} Spear of Mannoroth · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb
	["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311} стоит в восточном конце каньона ({area:435}). Разбейте сферу на нем; рядом появится {object:409315}.",
	-- {object:409315} Shattered Orb
	["from the {object:409315}"] = "из объекта {object:409315}",

	-- Step 9: Return to Delgren
	-- {area:413} Maestra's Post
	["Back to {area:413}."] = "Назад: {area:413}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311} стоит в восточном конце каньона ({area:435}). Примените на сферу на нем: {spell:11170}; рядом появится {object:409315}.",
}
