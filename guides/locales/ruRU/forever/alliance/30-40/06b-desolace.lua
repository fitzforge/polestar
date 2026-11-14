-- Russian (ruRU): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Летите сюда: {area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Распорядитель полетов: {area:144}",

	-- Step 3: Theramore flight master
	["Theramore flight master"] = "Распорядитель полетов: Терамор",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "Сойдя с корабля, поднимитесь по пирсу к Балдрику, распорядителю полетов у ворот ({area:514}).",

	-- Step 4: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort
	["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}, если гайд 30-40/02 его не взял: обломки корабля лежат под башней NPC {npc:11863}",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Идите по дороге на юг: {area:2407}.",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019} стоит на краю места {area:596}, к юго-западу от места {area:2407}; {object:176751} лежат среди скелетов.",

	-- Step 7: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "По месту {area:596} ползает {npc:217590}: поймайте его инструментом из набора {item:213565} (его дает {npc:217412}).",

	-- Step 8: Maraudine centaurs
	["Maraudine centaurs"] = "Кентавры из племени Мародин",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Кентавры из племени Мародин занимают {area:607} к западу от кладбища; тотемы падают со всех.",

	-- Step 9: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} держат в лагере кентавров к западу от кладбища. Освободите ее и сохраните ей жизнь по пути наружу; она останавливается у кладбища.\nОсторожно: заскриптованные группы связаны между собой и появляются только во время сопровождения, так что их нельзя зачистить заранее или выманивать по одной. Но зачистка обычных кентавров на пути перед началом помогает.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "сопроводите NPC {npc:12277} обратно к кладбищу",

	-- Step 10: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Демоны собираются здесь: {area:602}, юг зоны {zone:1443}: гончие Скверны (пожиратели маны, охотники на магов и охотники за магией), девы и сестры Пустоты, а вокруг ямы – капитаны тюремщиков судеб.\nОсторожно: большинство противников здесь ходят патрулями, так что легко привлечь лишних.",

	-- Step 11: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "Опустошители-отрекшиеся бродят по костяным полям к югу от деревни племени Маграм, к востоку от Ковена: стрелка ведет к их западному краю. Затем используйте {item:15848} у его стрелки, на восточной стороне полей, чтобы приманить призраков из племени Маграм. Осторожно: некроханы Маграм и трупоеды (45, элитные) ходят по костяным полям между двумя стрелками вместе с некромантами Маграм (42): подтягивайте опустошителей и призраков к себе, подальше от них.",

	-- Step 14: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Идите по дороге на запад через север зоны {zone:1443} к руинам: {area:2405}. Там на холме стоит башня NPC {npc:11863}, по пути к обломкам корабля.",

	-- Step 15: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "Сундук разбитого корабля лежит чуть юго-западнее башни NPC {npc:11863}.",

	-- Step 16: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest
	["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} лежит рядом с объектом {object:35251}. Его серебряный ключ падает с крабов Сухого Щелчка вокруг обломков корабля; золотой – с наг Скользящего Клинка на северо-западном побережье, далее.",
	["Underwater"] = "Под водой",

	-- Step 17: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}: убивайте их, когда встретите",
	-- {npc:11863} Azore Aldamort · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words) · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Наги Скользящего Клинка занимают северо-западное побережье к северу от башни NPC {npc:11863}; сумка Карнитола лежит на морском дне напротив, а золотой ключ Ракмора может упасть с любой наги. Доплывите до места {area:2406} у дальней северной оконечности и используйте {item:15766} на объекте {object:177673}: появится {npc:12369} (38); убейте его ради предмета {quest:6027}.",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, с наг Скользящего Клинка",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words)
	["{item:15766}, on the {object:177673}"] = "{item:15766}, на объекте {object:177673}",

	-- Step 18: Rackmore's Chest
	-- {object:177673} Serpent Statue (no name in this language: may be words)
	["Rackmore's chest lies just south-east of the {object:177673}."] = "Сундук Ракмора лежит чуть юго-восточнее объекта {object:177673}.",

	-- Step 21: Nijel's Point
	-- {area:608} Nijel's Point · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "Идите по дороге на север: {area:608}. {npc:5396} стоит в южной части, {npc:5638} – в центре, {npc:1182} – на севере.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "для NPC {npc:5637} ({zone:1455}): сохраните",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "для NPC {npc:3980} ({area:271}): сохраните",

	-- Step 22: Fly to Theramore
	["Fly to Theramore"] = "Летите на Терамор",
	["The next guide starts in Theramore."] = "Следующий гайд начинается на Тераморе.",
}
