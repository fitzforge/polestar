-- Russian (ruRU): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "В таверну: {zone:1455}",

	-- Step 2: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Летите сюда: {area:144}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Распорядитель полетов: {zone:1455}",

	-- Step 3: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "",

	-- Step 4: Searing Gorge
	["The Grimesilt outhouse"] = "Нужник Карьера Грязнули",

	-- Step 5: The Grimesilt outhouse
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}: the {area:247} is just inside, in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Из места {area:144} езжайте на юг в {zone:1418}, затем на запад мимо ордынского городка {area:340} (обойдите его стороной) и вверх по тропе: {zone:1427}. {area:247} – сразу за входом, на юго-востоке. Пленнику в деревянном нужнике нужны 15 шт. {item:4306} и восемь убитых геологов из клана Черного Железа с карьера вокруг. Нужник также открывается ключом, если вы его нашли.",

	-- Step 6: The Grimesilt outhouse
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "Следующее задание пленника, «Учетная книга из Танариса» ({zone:1446}), ведет в {zone:1435} и {zone:1445}: пропустите.",

	-- Step 7: Level 48.27
	["Level 48.27"] = "",
	-- {item:3985} Monogrammed Sash
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan."] = "",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "",

	-- Step 8: Dorius Stonetender
	-- {area:247} Grimesilt Dig Site · {area:1959} Dustfire Valley · {object:175704} Singed Letter
	["Dorius stands by the road beside the {area:247}. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "Дориус стоит у дороги рядом с местом {area:247}. Сопроводите его на северо-восток ({area:1959}) и сохраните ему жизнь; когда все закончится, прочтите {object:175704}, который он оставит на дороге.",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, at the end of this guide"] = "Для NPC {npc:8256} ({zone:1455}), в конце этого гайда",

	-- Step 9: Thorium Point
	-- {area:1446} Thorium Point
	["Ride west along the north of the Gorge to {area:1446}, the scaffolded camp on the north-west rim."] = "Езжайте на запад вдоль северной части ущелья: {area:1446} – лагерь с лесами на северо-западном краю.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Доска: {object:179827}",

	-- Step 11: Zamael Lunthistle
	-- {npc:8436} Zamael Lunthistle · {area:1442} Firewatch Ridge · {area:1446} Thorium Point · {npc:8282} Highlord Mastrogonde · {quest:3377} Prayer to Elune
	-- plural, as words: Twilight Fire Guards = {npc:5861} Twilight Fire Guard
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:8436} stands inside the Twilight camp at {area:1442}, west of {area:1446}, among Twilight Fire Guards, Idolaters and Geomancers (level 48-49 elites), with {npc:8282} (level 51, rare elite) beside him: {quest:3377} needs a group of 4. Skip it if you are alone."] = "Это элитные противники: лучше собраться в группу, поищите, с кем пойти. {npc:8436} стоит в лагере Сумеречного Молота ({area:1442}), к западу от места {area:1446}, среди стражей огня, идолопоклонников и геомантов из культа Сумеречного Молота (элитные противники 48-49 уровня), а рядом с ним – {npc:8282} (51-й уровень, редкий элитный): для задания «{quest:3377}» нужна группа из 4 человек. Если вы один, пропустите его.",

	-- Step 14: Searing Lava Spiders
	-- plural, as words: Searing Lava Spiders = {npc:5857} Searing Lava Spider
	["Searing Lava Spiders"] = "Опаляющие лавовые пауки",
	-- {npc:8436} Zamael Lunthistle
	["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to Velarok."] = "Пауки бродят по плато и лавовым озерам к югу от NPC {npc:8436}, по пути к Велароку.",

	-- Step 15: Velarok Windblade
	["Velarok Windblade"] = "Веларок Клинок Ветра",
	-- {area:1446} Thorium Point
	["Velarok stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Веларок стоит на краю Котлована, к югу от места {area:1446}. Выслушайте его историю.",

	-- Step 18: Golems and elementals
	["Golems and elementals"] = "Големы и элементали",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Velarok; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Тяжелые боевые големы патрулируют дно Котлована под Велароком; среди них плавают элементали магмы. Масло падает с големов и элементалей, сердца – с элементалей.",

	-- Step 20: Dark Iron dwarves: kill these as you meet them
	["Dark Iron dwarves: kill these as you meet them"] = "",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "Надсмотрщики и поработители гоняют рабов по всему Котловану, и у любого из них может быть {item:10551}. Кузнецы работают у печей в центре ({item:18959}), наблюдатели стоят на южных гребнях (подзорная труба наблюдателя). С любого противника ({object:147516}) может выпасть {item:11818}: сохраните его.\nОсторожно: поработители из клана Черного Железа (45-46-й уровень), когда их выманивают, зовут на помощь союзников в пределах 15 ярдов, бросают сеть с расстояния до 15 ярдов и применяют кровопускание в ближнем бою.",

	-- Step 23: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "",
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} открывается на севере Котлована. Тайные планы лежат на его верхнем уступе; пламезавры плавают в лавовых озерах дальше внутри, так что выманивайте их к краю. Держитесь подальше от NPC {npc:14621} и его элитной стражи в глубине.",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "",

	-- Step 24: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 26: Level 48.66
	["Level 48.66"] = "",
	-- {quest:7701} WANTED: Overseer Maltorius
	["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan."] = "",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "",

	-- Step 28: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 30: The Torch of Retribution
	["Listen to Velarok's story once more."] = "Еще раз выслушайте историю Веларока.",

	-- Step 31: Velarok Windblade
	-- {quest:3453} The Torch of Retribution · {quest:3462} Squire Maltrake
	["{quest:3453} lies on the ground at Velarok's feet; {quest:3462} stands beside him."] = "Задание «{quest:3453}» лежит на земле у ног Веларока; задание «{quest:3462}» стоит рядом с ним.",
	-- {quest:3462} Squire Maltrake · {area:1446} Thorium Point
	["{quest:3462}: hand it in on the way back to {area:1446}"] = "{quest:3462}: сдайте по пути обратно в {area:1446}",

	-- Step 32: Sentry Braziers
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Sentry Braziers"] = "Сторожевые жаровни",
	-- {object:149047} Torch of Retribution
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Carry the {object:149047} south along the rim of the Cauldron and light the four Sentry Braziers, from the south-west round to the south-east."] = "Несите предмет {object:149047} на юг вдоль края Котлована и зажгите четыре сторожевые жаровни, с юго-запада по кругу до юго-востока.",

	-- Step 33: Level 48.98
	["Level 48.98"] = "",
	-- {quest:3452} The Flame's Casing
	["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan."] = "",
	-- {npc:5844} Dark Iron Slaver
	["grind on {npc:5844}"] = "",

	-- Step 34: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",
	["Below ground"] = "Под землей",

	-- Step 36: Squire Maltrake
	-- {npc:8509} Squire Maltrake · {area:1446} Thorium Point
	["{npc:8509} and the dragonflight's hoard are beside Velarok, on the rim south of {area:1446}."] = "{npc:8509} и сокровищница драконов стоят рядом с Велароком, на краю к югу от места {area:1446}.",
	-- {object:149502} Hoard of the Black Dragonflight · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous · {zone:1428} Burning Steppes
	["The {object:149502} it gives holds a {item:10575}: keep it for {npc:9459} in the {zone:1428}"] = "В сокровищнице ({object:149502}), которую он откроет, лежит {item:10575}: сохраните для NPC {npc:9459} ({zone:1428})",

	-- Step 38: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Лететь в {area:1537}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "",

	-- Step 39: Hall of Explorers
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: слизни водятся в локации {zone:1448}, сохраните задание",

	-- Step 40: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "Четыре оттиска рун в локации {zone:1447}: сохраните задание",

	-- Step 41: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 42: Xiggs Fuselighter
	-- {object:32359} Military Ward
	["Xiggs waits in the {object:32359}."] = "Ксиггс ждет в районе {object:32359}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["For {npc:8256} in {area:1537}, later"] = "Для NPC {npc:8256} ({area:1537}), позже",
	-- ["Greater Lava Spiders"] = "Большие лавовые пауки",
	-- ["The night elf stands alone west of {area:1446}. Hear his story."] = "Ночной эльф стоит один к западу от места {area:1446}. Выслушайте его историю.",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: предыдущий гайд возвращает вас сюда камнем возвращения, так что это обычно отмечается сразу",
	-- ["{object:147516} dwarves"] = "Дворфы: {object:147516}",
}
