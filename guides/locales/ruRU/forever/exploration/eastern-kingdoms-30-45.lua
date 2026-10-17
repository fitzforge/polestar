-- Russian (ruRU): the guide forever/exploration/eastern-kingdoms-30-45 (forever/exploration/eastern-kingdoms-30-45.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 30-45"] = "Исследование: {zone:1415}, 30-45",

	-- Step 1: Alterac Mountains (1/2)
	-- {zone:1424} Hillsbrad Foothills
	["Picks up in {zone:1424}, where the 1-30 guide leaves the Horde and passes the Alliance. 15 areas to discover here, levels 27-39."] = "Продолжение в зоне {zone:1424}, где гайд 1-30 оставляет Орду и через которую проводит Альянс. Местностей для открытия: 15, уровни 27-39.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "Исследование всей карты мира одним персонажем – испытание наследия Forever (1 очко наследия на всю учетную запись).",
	-- {area:271} Southshore · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:271} in {zone:1424} and walk north into the {zone:1416}."] = "Летите сюда: {area:271} ({zone:1424}) – и идите на север в зону {zone:1416}.",
	-- {area:272} Tarren Mill · {zone:1424} Hillsbrad Foothills · {zone:1416} Alterac Mountains
	["Fly to {area:272} in {zone:1424} and walk north into the {zone:1416}."] = "Летите сюда: {area:272} ({zone:1424}) – и идите на север в зону {zone:1416}.",
	["any one of these names counts"] = "засчитывается любое из этих названий",

	-- Step 3: Arathi Highlands (1/2)
	["16 areas to discover here, levels 30-40."] = "Местностей для открытия: 16, уровни 30-40.",
	-- {zone:1417} Arathi Highlands · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	["The {zone:1417} lie east of the {zone:1416} and {zone:1424}."] = "{zone:1417} – к востоку от зон {zone:1416} и {zone:1424}.",
	-- {area:320} Refuge Pointe · {area:321} Hammerfall
	["{area:320} in the middle is the Alliance town; {area:321} in the east is Horde."] = "{area:320} в центре – город Альянса; {area:321} на востоке – Орды.",
	-- {area:321} Hammerfall · {area:320} Refuge Pointe
	["{area:321} in the east is the Horde town; {area:320} in the middle is Alliance."] = "{area:321} на востоке – город Орды; {area:320} в центре – Альянса.",
	-- {area:320} Refuge Pointe · {npc:2835} Cedrik Prose
	["Flight path here: {area:320} ({npc:2835})."] = "Маршрут полета здесь: {area:320} ({npc:2835}).",
	-- {area:321} Hammerfall
	["Flight path here: {area:321} (Urda)."] = "Маршрут полета здесь: {area:321} (Урда).",
	["Alliance town: Horde characters only need to touch its edge (guards)"] = "Город Альянса: персонажам Орды достаточно коснуться его края (стража)",

	-- Step 4: Arathi Highlands (2/2)
	["Horde town: Alliance characters only need to touch its edge (guards)"] = "Город Орды: персонажам Альянса достаточно коснуться его края (стража)",
	["elite Syndicate and ogres inside the walls: the discovery triggers at the gate"] = "за стенами – элитные члены Синдиката и огры: открытие засчитывается у ворот",

	-- Step 5: Badlands (1/2)
	["14 areas to discover here, levels 36-45."] = "Местностей для открытия: 14, уровни 36-45.",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {object:1668} Dun Algaz · {zone:1432} Loch Modan · {zone:1418} Badlands
	["Cross the {area:880} south into the {zone:1437}, go through the {object:1668} pass into {zone:1432} and take the road south out of {zone:1432} into the {zone:1418}."] = "Пересеките {area:880} на юг в зону {zone:1437}, пройдите перевал ({object:1668}) в зону {zone:1432} и по дороге на юг из зоны {zone:1432} – в зону {zone:1418}.",
	-- {area:144} Thelsamar · {zone:1432} Loch Modan
	["Faster: fly to {area:144} in {zone:1432}."] = "Быстрее: летите сюда: {area:144} ({zone:1432}).",
	-- {area:340} Kargath
	["{area:340} in the west is the Horde town."] = "{area:340} на западе – город Орды.",
	-- {area:340} Kargath
	["Flight path here: {area:340} (Gorrik)."] = "Маршрут полета здесь: {area:340} (Горрик).",

	-- Step 7: Riverglades (1/2)
	["14 areas to discover here, levels 36-44."] = "Местностей для открытия: 14, уровни 36-44.",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1428} Burning Steppes · {zone:1433} Redridge Mountains · {zone:1446} Tanaris · {area:16727} Powderfuse Port · {area:17780} Krol'dok Stronghold
	["The {zone:2548} lie east of the {zone:1418} and the {zone:1428}: the way in is the fork east off the {zone:1433} road (a ship also runs from {zone:1446} to {area:16727}, the neutral goblin port on its coast). {area:17780} is an ogre clan's outdoor dungeon."] = "{zone:2548} – к востоку от зон {zone:1418} и {zone:1428}: вход – развилка на восток от дороги в зоне {zone:1433} (также ходит корабль из зоны {zone:1446}. Цель: {area:16727} – нейтральный гоблинский порт на ее побережье). {area:17780} – подземелье клана огров под открытым небом.",

	-- Step 9: Stranglethorn Vale (1/4)
	-- {area:35} Booty Bay · {area:392} Ratchet
	["27 areas to discover here, levels 30-50. {area:35} at the southern tip is a neutral goblin port with a boat to {area:392}."] = "Местностей для открытия: 27, уровни 30-50. {area:35} на южной оконечности – нейтральный гоблинский порт с кораблем сюда: {area:392}.",
	-- {area:42} Darkshire · {zone:1453} Stormwind · {zone:1431} Duskwood · {zone:1434} Stranglethorn Vale
	["Fly to {area:42} (or {zone:1453}) and take the road south out of {zone:1431} into northern {zone:1434}."] = "Летите сюда: {area:42} (или {zone:1453}) – и по дороге на юг из зоны {zone:1431} в северную часть зоны {zone:1434}.",
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {area:117} Grom'gol Base Camp
	["Take the zeppelin from {zone:1454} or the {zone:1458} to {area:117}."] = "Сядьте на дирижабль ({zone:1454} или {zone:1458}). Цель: {area:117}.",
	-- {area:35} Booty Bay
	["Flight path here: {area:35} (Gyll)."] = "Маршрут полета здесь: {area:35} (Гилл).",
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	["Flight paths here: {area:35} (Gringer), {object:3202} (Thysta)."] = "Маршруты полета здесь: {area:35} (Грингер), {object:3202} (Тиста).",

	-- Step 10: Stranglethorn Vale (2/4)
	["free-for-all PvP inside the arena ring"] = "внутри круга арены – PvP «каждый сам за себя»",

	-- Step 11: Stranglethorn Vale (3/4)
	["level 50 area, well above this guide's range"] = "местность 50-го уровня, намного выше диапазона этого гайда",

	-- Step 12: Stranglethorn Vale (4/4)
	["elite ogres: discover it from the edge"] = "элитные огры: открывайте с края",

	-- Step 13: Swamp of Sorrows (1/2)
	["11 areas to discover here, levels 36-43."] = "Местностей для открытия: 11, уровни 36-43.",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows
	["Go back north into {zone:1431} and follow its road east through {zone:1430} (level 50+ creatures off the road) into the {zone:1435}."] = "Вернитесь на север в зону {zone:1431} и по ее дороге на восток через зону {zone:1430} (вне дороги существа 50+ уровня) – в зону {zone:1435}.",
	-- {area:75} Stonard
	["{area:75} is the Horde town."] = "{area:75} – город Орды.",
	-- {area:75} Stonard
	["Flight path here: {area:75} (Breyk)."] = "Маршрут полета здесь: {area:75} (Брейк).",
}
