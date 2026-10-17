-- Russian (ruRU): the guide forever/alliance/50-60/02-felwood (forever/alliance/50-60/02-felwood.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {area:415} Astranaar
	["Take the boat from {area:702} to {area:442} and fly to {area:415}."] = "Плывите на корабле: {area:702} → {area:442}, затем летите сюда: {area:415}.",

	-- Step 2: Grazle
	-- {area:415} Astranaar · {zone:1448} Felwood · {npc:11554} Grazle · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448}. {npc:11554} the furbolg stands by the road just south of the {area:2479}."] = "Езжайте на север ({area:415} → {zone:1448}). Фурболг {npc:11554} стоит у дороги чуть южнее места {area:2479}.",

	-- Step 3: Deadwood Village
	-- {npc:11554} Grazle
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["The Deadwood furbolgs live in the village just south-west of {npc:11554}; keep the Deadwood Headdress Feathers they drop."] = "Фурболги из племени Мертвого Леса живут в деревне чуть юго-западнее (ориентир: {npc:11554}); сохраняйте перья из головного убора Мертвого Леса, которые с них падают.",

	-- Step 4: Grazle
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} waits at the north end of {zone:1448}"] = "{npc:15395} ждет в северной части зоны {zone:1448}",
	["Five feathers buy a little Timbermaw reputation"] = "Пять перьев дают немного репутации у Древобрюхов",

	-- Step 5: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {npc:9528} Arathandris Silversky · {npc:11554} Grazle
	["{npc:9528}, in the ruins just east of {npc:11554}"] = "{npc:9528} – в руинах чуть восточнее (ориентир: {npc:11554})",

	-- Step 6: Jadefire Glen
	-- {npc:9454} Xavathras
	["The Jadefire satyrs hold the glen west of the road, with {npc:9454} at its back."] = "Сатиры из племени Нефритового Пламени занимают долину к западу от дороги; {npc:9454} – в ее глубине.",

	-- Step 7: Jaedenar
	-- {area:1763} Jaedenar · {item:13140} Blood Red Key · {npc:11018} Arko'narin · {area:1770} Shadow Hold
	["{area:1763} is the ruined temple north of the glen. Some of its cultists drop a {item:13140}, about one kill in thirty: it opens {npc:11018}'s cell in {area:1770}, the cave at the back. If it drops, clear the way out before you free her; if not, skip her quests."] = "{area:1763} – разрушенный храм к северу от долины. С некоторых его культистов падает {item:13140}, примерно с одного из тридцати: он открывает камеру, где сидит {npc:11018} ({area:1770}, пещера в глубине). Если ключ выпал, расчистите путь к выходу, прежде чем освобождать ее; если нет, пропустите ее задания.",
	-- {item:13140} Blood Red Key
	["{item:13140}, a rare drop"] = "{item:13140}: редкая добыча",
	-- {npc:11016} Captured Arko'narin · {area:1770} Shadow Hold
	["{npc:11016}, in {area:1770}"] = "{npc:11016} – здесь: {area:1770}",
	["Keep her alive until she is out of the cave"] = "Не дайте ей погибнуть, пока она не выйдет из пещеры",

	-- Step 9: Jaedenar again
	-- {area:1763} Jaedenar
	["{area:1763} again"] = "Снова: {area:1763}",
	-- {item:12922} Empty Canteen · {area:1763} Jaedenar · {npc:11018} Arko'narin · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Use the {item:12922} at the corrupted moonwell in the middle of {area:1763}. If you freed {npc:11018}, go back into {area:1770} for the succubus {npc:9518}; Trey Lightforge's remains lie beside her."] = "Используйте {item:12922} у оскверненного лунного колодца в центре храма ({area:1763}). Если вы освободили персонажа {npc:11018}, вернитесь сюда: {area:1770} – за суккубом {npc:9518}; рядом с ней лежат останки Трея Светогорна.",

	-- Step 10: Oozes
	["Oozes"] = "Слизнюки",
	-- {area:1763} Jaedenar · {area:1765} Bloodvenom Falls
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Cursed and Tainted Oozes slide about the streams and fel pools around {area:1763} and {area:1765}: kill them and use Laris's Empty Ooze Jars on their remains."] = "Проклятые и нечистые слизнюки ползают по ручьям и озерам скверны вокруг мест {area:1763} и {area:1765}: убивайте их и используйте на останках пустые флаконы, полученные у Лариса.",

	-- Step 11: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["Follow the road north to the cratered vale and walk to each crater, killing the Entropic Beasts and Horrors between them."] = "Идите по дороге на север в долину с кратерами и обойдите каждый кратер, убивая по пути энтропических зверей и энтропических ужасов.",
	["First crater"] = "Первый кратер",
	["Second crater"] = "Второй кратер",
	["Third crater"] = "Третий кратер",

	-- Step 12: Jadefire Run
	-- {area:2618} Jadefire Run · {npc:10648} Xavaric · {quest:939} Flute of Xavaric · {item:11674} Jadefire Felbind
	["{area:2618} is the satyr valley in the north-west, with {npc:10648} at its far end. He drops the {quest:939}; every Jadefire satyr can drop {item:11674}."] = "{area:2618} – долина сатиров на северо-западе; {npc:10648} – в ее дальнем конце. С него падает {quest:939}; с любого сатира из племени Нефритового Пламени может упасть {item:11674}.",

	-- Step 13: Irontree Woods
	-- {area:1767} Irontree Woods · {area:2618} Jadefire Run · {item:11503} Blood Amber
	["The Warpwood treants of {area:1767}, east of {area:2618}, carry the {item:11503}."] = "{item:11503} носят древни-криводревы ({area:1767}, к востоку от места {area:2618}).",

	-- Step 14: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride east to the night elf camp at {area:1998}."] = "Езжайте на восток к лагерю ночных эльфов: {area:1998}.",

	-- Step 15: Nafien
	-- {area:1769} Timbermaw Hold · {npc:15395} Nafien
	["Follow the road north to the cave mouth of {area:1769}; {npc:15395} guards it."] = "Идите по дороге на север ко входу в пещеру ({area:1769}); его охраняет {npc:15395}.",

	-- Step 16: Felpaw Village
	-- {area:1762} Felpaw Village · {quest:8470} Deadwood Ritual Totem
	["The Deadwood furbolgs of {area:1762} fill the hills west of the cave. The Avengers can drop a {quest:8470}."] = "Фурболги из племени Мертвого Леса ({area:1762}) заполняют холмы к западу от пещеры. С мстителей может упасть {quest:8470}.",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop"] = "{quest:8470}: редкая добыча",

	-- Step 17: Nafien
	-- {zone:1452} Winterspring
	["Salfa stands at the {zone:1452} end of the tunnel: keep it"] = "Сальфа стоит у выхода из туннеля в зону {zone:1452}: сохраните задание",

	-- Step 18: Timbermaw Hold
	-- {npc:11558} Kernda · {npc:11557} Meilosh
	["Step into the cave: {npc:11558} and {npc:11557} stand just inside."] = "Войдите в пещеру: {npc:11558} и {npc:11557} стоят сразу у входа.",
	-- {npc:11558} Kernda
	["{npc:11558}: the Timbermaw speak to you only from Neutral"] = "{npc:11558}: Древобрюхи разговаривают с вами только начиная с уровня «Равнодушие»",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: thirty {quest:6031}, handed in when you pass through again at 57"] = "{npc:11557}: тридцать шт. {quest:6031}, сдаются, когда вы снова пройдете здесь на 57-м уровне",

	-- Step 19: The Emerald Sanctuary
	-- {area:1998} Talonbranch Glade
	["Fly from {area:1998} to the Sanctuary's end of the road, or ride south along it."] = "Летите ({area:1998}) к концу дороги у Святилища или езжайте по ней на юг.",
	-- {zone:1457} Darnassus
	["The vial is filled in {zone:1457}: keep it"] = "Склянка наполняется здесь: {zone:1457} – сохраните задание",
	-- {zone:1413} Barrens
	["Ends in the {zone:1413}: keep it"] = "Завершается здесь: {zone:1413} – сохраните задание",

	-- Step 20: Everlook
	-- {area:1769} Timbermaw Hold · {area:1998} Talonbranch Glade · {zone:1452} Winterspring · {area:2255} Everlook
	["Ride north to {area:1769} (or fly back to {area:1998} first) and through the tunnel into {zone:1452}; follow the road east to the goblin town of {area:2255}."] = "Езжайте на север: {area:1769} (или сначала летите обратно: {area:1998}), и через туннель в зону {zone:1452}; идите по дороге на восток к городу гоблинов: {area:2255}.",
}
