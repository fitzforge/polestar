-- Russian (ruRU): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "Водный облик для путешествий: быстрое плавание и дыхание под водой, а заодно пояс и идол.",

	-- Step 1: A Lesson to Learn
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} stands in the {area:1658}."] = "{npc:4217} находится здесь: {area:1658}.",

	-- Step 2: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Примените {spell:18960}. {npc:11802} находится здесь: {area:2361}. Безделушки из святилища лежат в контейнерах на дне озера ({area:656}) ниже места {area:2361}: отнесите одну к святилищу на северо-западном берегу ({area:2362}), используйте ее там и поговорите: {npc:11799}.",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877} из контейнера в озере ({object:177785})",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "У святилища: {area:2362}",

	-- Step 3: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:443} Ruins of Mathystra
	["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "Летите отсюда: {area:2361}, сюда: {area:442}. {object:177792} лежит под водой у северного побережья, к западу от места {area:443}.",

	-- Step 4: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "Плывите на корабле из места {area:442} в город {zone:1453} и летите сюда: {area:108}. Скачите на северо-запад к побережью: {object:177790} лежит на морском дне недалеко от берега.",

	-- Step 5: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Примените {spell:18960}. Соедините две половинки, чтобы получить предмет {item:15885}, у святилища ({area:2362}) на северо-западном берегу озера, затем поговорите: {npc:11802} ({area:2361}). После этого летите сюда: {area:702}.",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885}: соедините половинки у святилища",

	-- Step 6: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up to {npc:4217} in the {area:1658}."] = "Поднимитесь через портал к {npc:4217}. Локация: {area:1658}.",

	-- Step 7: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands on {area:1639}."] = "{npc:3033} стоит здесь: {area:1639}.",

	-- Step 8: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Примените {spell:18960}. {npc:11802} находится здесь: {area:2361}. Безделушки из святилища лежат на дне озера ({area:656}) и через несколько минут исчезают: плывите с одной прямо к святилищу на северо-западном берегу ({area:2362}), используйте ее там и поговорите: {npc:11799}.",

	-- Step 9: Half Pendant of Aquatic Endurance
	-- {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1458} Undercity · {object:177790} Strange Lockbox · {area:240} Dead Field · {area:228} Sepulcher
	["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "Летите с помощью NPC {npc:11798} в город {zone:1456}, затем в город {zone:1454} и на дирижабле в зону {zone:1420}; зона {zone:1421} к югу от города {zone:1458}. {object:177790} лежит на побережье к западу от места {area:240}, к северу от места {area:228}.",

	-- Step 10: Half Pendant of Aquatic Agility
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {area:380} Crossroads
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "{object:177792} лежит на северной окраине места {area:382}, у башни Торговой компании, к северу от места {area:380}.",

	-- Step 11: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Примените {spell:18960}. Соедините две половинки, чтобы получить предмет {item:15885}, у святилища ({area:2362}) на северо-западном берегу озера, затем поговорите: {npc:11802} ({area:2361}). {npc:11798} отвозит друидов сюда: {area:1638}.",
}
