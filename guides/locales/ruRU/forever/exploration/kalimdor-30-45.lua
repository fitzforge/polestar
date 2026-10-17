-- Russian (ruRU): the guide forever/exploration/kalimdor-30-45 (forever/exploration/kalimdor-30-45.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1414} Kalimdor
	["Exploration: {zone:1414} 30-45"] = "Исследование: {zone:1414}, 30-45",

	-- Step 1: Desolace (1/2)
	-- {zone:1413} Barrens · {zone:1443} Desolace · {zone:1445} Dustwallow Marsh
	["Picks up west of the {zone:1413}, in {zone:1443}, and ends in {zone:1445}. 15 areas to discover here, levels 30-39."] = "Продолжение к западу от зоны {zone:1413}, в зоне {zone:1443}; завершение – в зоне {zone:1445}. Местностей для открытия: 15, уровни 30-39.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Исследование всей карты мира одним персонажем – испытание наследия Forever (1 очко наследия на всю учетную запись).",
	-- {zone:1442} Stonetalon Mountains · {zone:1443} Desolace · {area:608} Nijel's Point
	["Take the road south-west out of the {zone:1442} into {zone:1443}; {area:608} in the north is the Alliance town."] = "Идите по дороге на юго-запад из зоны {zone:1442} в зону {zone:1443}; {area:608} на севере – город Альянса.",
	-- {area:460} Sun Rock Retreat · {zone:1443} Desolace · {area:2408} Shadowprey Village
	["Fly to {area:460} and take the road south-west into {zone:1443}; {area:2408} on the west coast is the Horde town."] = "Летите сюда: {area:460} – и по дороге на юго-запад в зону {zone:1443}; {area:2408} на западном побережье – город Орды.",
	-- {area:608} Nijel's Point · {npc:6706} Baritanas Skyriver
	["Flight path here: {area:608} ({npc:6706})."] = "Маршрут полета здесь: {area:608} ({npc:6706}).",
	-- {area:2408} Shadowprey Village
	["Flight path here: {area:2408} (Thalon)."] = "Маршрут полета здесь: {area:2408} (Фалон).",
	["Alliance town: Horde characters only need to touch its edge (guards)"] = "Город Альянса: персонажам Орды достаточно коснуться его края (стража)",

	-- Step 2: Desolace (2/2)
	["Horde town: Alliance characters only need to touch its edge (guards)"] = "Город Орды: персонажам Альянса достаточно коснуться его края (стража)",

	-- Step 3: Shen'dralas
	["7 areas to discover here."] = "Местностей для открытия: 7.",
	-- {zone:2652} Shen'dralas · {zone:1443} Desolace · {zone:1412} Mulgore · {area:2657} Valley of Bones
	["{zone:2652}, the ruins between {zone:1443} and {zone:1412}, is entered from southern {zone:1443} through the {area:2657}."] = "{zone:2652} – руины между зонами {zone:1443} и {zone:1412}; вход – с юга зоны {zone:1443} через {area:2657}.",

	-- Step 4: Feralas (1/2)
	["16 areas to discover here, levels 41-60."] = "Местностей для открытия: 16, уровни 41-60.",
	-- {zone:1443} Desolace · {zone:1444} Feralas
	["Go back into southern {zone:1443}; the road continues south into {zone:1444}."] = "Вернитесь на юг зоны {zone:1443}; дорога продолжается на юг в зону {zone:1444}.",
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast
	["{area:1116} on {area:1120} is the Alliance town (boat from the {area:1108})."] = "{area:1116} ({area:1120}) – город Альянса (корабль отсюда: {area:1108}).",
	-- {area:1099} Camp Mojache
	["{area:1099} in the east is the Horde town."] = "{area:1099} на востоке – город Орды.",
	-- {area:489} Thalanaar · {npc:8019} Fyldren Moonfeather
	["Flight paths here: {area:489} (Thyssiana), Feathermoon ({npc:8019})."] = "Маршруты полета здесь: {area:489} (Тиссиана), Крепость Оперенной Луны ({npc:8019}).",
	-- {area:1099} Camp Mojache
	["Flight path here: {area:1099} (Shyn)."] = "Маршрут полета здесь: {area:1099} (Шин).",
	["level 60 area, well above this guide's range"] = "местность 60-го уровня, намного выше диапазона этого гайда",

	-- Step 6: Dustwallow Marsh
	["7 areas to discover here, levels 36-61."] = "Местностей для открытия: 7, уровни 36-61.",
	-- {area:150} Menethil Harbor · {area:513} Theramore Isle
	["Fly to Theramore (or take the boat from {area:150}); {area:513} is the Alliance town."] = "Летите на остров Терамор (или плывите на корабле отсюда: {area:150}); {area:513} – город Альянса.",
	-- {zone:1445} Dustwallow Marsh · {zone:1413} Barrens · {area:496} Brackenwall Village
	["{zone:1445} is east of the southern {zone:1413}; {area:496} in the north-west is the Horde town."] = "{zone:1445} – к востоку от южной части зоны {zone:1413}; {area:496} на северо-западе – город Орды.",
	["Flight path here: Theramore (Baldruc)."] = "Маршрут полета здесь: остров Терамор (Балдрик).",
	-- {area:496} Brackenwall Village
	["Flight path here: {area:496} (Shardi)."] = "Маршрут полета здесь: {area:496} (Щербушка).",
	["any one of these names counts"] = "засчитывается любое из этих названий",
	["Horde town: Alliance characters only need to touch its edge (guards); any one of these names counts"] = "Город Орды: персонажам Альянса достаточно коснуться его края (стража); засчитывается любое из этих названий",
	["level 61 area, well above this guide's range"] = "местность 61-го уровня, намного выше диапазона этого гайда",
	["Alliance town: Horde characters only need to touch its edge (guards); any one of these names counts"] = "Город Альянса: персонажам Орды достаточно коснуться его края (стража); засчитывается любое из этих названий",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:1108}"] = "{area:1108}",
}
