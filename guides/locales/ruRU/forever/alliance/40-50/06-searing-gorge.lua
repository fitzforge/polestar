-- Russian (ruRU): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:6734} Innkeeper Hearthstove
	["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: предыдущий гайд возвращает вас сюда камнем возвращения, так что это обычно отмечается сразу",

	-- Step 2: Thorium Point
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:1446} Thorium Point
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "Из места {area:144} езжайте на юг в {zone:1418}, затем на запад мимо ордынского городка {area:340} (обойдите его стороной) и вверх по тропе: {zone:1427}. {area:1446} — лагерь с лесами на северо-западном краю.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Доска: {object:179827}",

	-- Step 3: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "Ночной эльф стоит один к западу от места {area:1446}. Выслушайте его историю.",

	-- Step 4: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Каларан стоит на краю Котлована, к югу от места {area:1446}. Выслушайте его историю.",

	-- Step 5: Golems and elementals
	["Golems and elementals"] = "Големы и элементали",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Тяжелые боевые големы патрулируют дно Котлована под Калараном; среди них плавают элементали магмы. Масло падает с големов и элементалей, сердца — с элементалей.",

	-- Step 7: Dark Iron dwarves
	-- {object:147516} Dark Iron
	["{object:147516} dwarves"] = "Дворфы: {object:147516}",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Надсмотрщики и поработители гоняют рабов по всему Котловану, и у любого из них может быть {item:10551}. Кузнецы работают у печей в центре ({item:18959}), наблюдатели стоят на южных гребнях (подзорная труба наблюдателя). С любого противника ({object:147516}) может выпасть {item:11818}: сохраните его.",

	-- Step 8: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Большие лавовые пауки",
	["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Пауки бродят по плато и лавовым озерам на юго-западе ущелья.",

	-- Step 10: The Slag Pit
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} открывается на севере Котлована. Тайные планы лежат на его верхнем уступе; пламезавры плавают в лавовых озерах дальше внутри, так что выманивайте их к краю. Держитесь подальше от NPC {npc:14621} и его элитной стражи в глубине.",

	-- Step 12: The Grimesilt outhouse
	["The Grimesilt outhouse"] = "Нужник Карьера Грязнули",
	-- {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Езжайте на восток через Котлован на юго-восток: {area:247}. Пленнику в деревянном нужнике нужны 15 шт. {item:4306} и восемь убитых геологов из клана Черного Железа с карьера вокруг. Нужник также открывается ключом, если вы его нашли.",
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "Следующее задание пленника, «Учетная книга из Танариса» ({zone:1446}), ведет в {zone:1435} и {zone:1445}: пропустите.",

	-- Step 13: Dorius Stonetender
	-- {object:147516} Dark Iron · {object:175704} Singed Letter · {area:1959} Dustfire Valley
	["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "Дворф стоит у дороги на карьере. Идите за ним на север по дороге и отбивайте засады ({object:147516}). Когда все закончится, прочтите {object:175704}, который он оставит на дороге ({area:1959}).",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, later"] = "Для NPC {npc:8256} ({zone:1455}), позже",
}
