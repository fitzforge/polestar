-- Russian (ruRU): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Летите сюда: {area:75}",
	-- {area:1446} Thorium Point
	["From {area:1446}'s flight master."] = "У распорядителя полетов ({area:1446}).",

	-- Step 2: The bloodmages
	["The bloodmages"] = "Волшебники крови",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Езжайте на запад от места {area:75} и на юг через каньон в край {zone:1419}; два волшебника крови стоят у дороги сразу за входом.",

	-- Step 3: The northern beasts
	["The northern beasts"] = "Северные звери",
	-- {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "Для пяти заданий нужны одни и те же части: соберите все за один проход. К западу от дороги на холмах живут грифы ({npc:5982}), голодные хохотуны, скорпоки-острожалы и василиски-смертеглазы.",

	-- Step 4: The eastern slopes
	["The eastern slopes"] = "Восточные склоны",
	["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "К востоку от дороги на склонах пасутся пеплогривые кабаны и хрюггеры, рядом – краснокаменные василиски. Держитесь подальше от зловепрей 52-го уровня дальше к югу.",

	-- Step 5: The bloodmages
	["Ride back north to the bloodmages."] = "Возвращайтесь на север к волшебникам крови.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "Следующие задания снова требуют те же части ради предмета с усилением и не дают опыта: не берите их.",

	-- Step 6: Grind to 48
	["Grind to 48"] = "Набейте 48-й уровень",
	["Only if you are not level 48 yet."] = "Только если у вас еще нет 48-го уровня.",
	["Vulture hills"] = "Холмы грифов",
	-- {npc:5982} Black Slayer · {zone:1419} Blasted Lands
	["grind on {npc:5982} at the northern hills, {zone:1419}"] = "бейте монстров {npc:5982} на северных холмах, {zone:1419}",

	-- Step 7: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Летите сюда: {area:1497}",
	-- {area:75} Stonard · {area:1497} Undercity
	["Ride north back to {area:75} and fly to the {area:1497}."] = "Возвращайтесь на север сюда: {area:75} и летите сюда: {area:1497}.",

	-- Step 8: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
	-- {npc:6741} Innkeeper Norman · {zone:1456} Thunder Bluff
	["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: для города {zone:1456}, примерно на 50-м уровне",

	-- Step 9: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Летите сюда: {area:272}",

	-- Step 10: Gilveradin Sunchaser's camp
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "Лагерь {npc:7801}",
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Езжайте на северо-восток от места {area:272} во {zone:1425} и на восток по дороге; {npc:7801} стоит лагерем на холме к югу от эльфийского поселения ({area:350}).",

	-- Step 11: Highvale
	["Highvale"] = "Высокодолье",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Эльфы Высокодолья стоят лагерем вокруг места {area:350}. Сожгите отчет, заметки и записи в их лагерях. {npc:7780} в плену внутри: выведите его и отбейте засаду по пути.",

	-- Step 12: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "К югу от поселения тролли племени Сухокожих занимают свои деревни. Череп есть у каждого: собрав двадцать, используйте предмет {item:15002}, чтобы сделать пику с тролльими черепами, затем установите ее в деревне.",

	-- Step 13: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "К востоку от деревни на холмах растет фиолетовый цветок.",

	-- Step 14: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "Снова к юго-западу: изгнанник прячется у руин ({area:353}).",

	-- Step 15: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Следуйте по дорогам на восток через {zone:1425} к деревне троллей на восточном побережье.",

	-- Step 16: Saltwater Snapjaws
	-- plural, as words: Saltwater Snapjaws = {npc:2505} Saltwater Snapjaw
	["Saltwater Snapjaws"] = "Морские хрустогрызы",
	-- {npc:2491} Whiskey Slim
	["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "Большие черепахи ползают по пляжам к северу от деревни. Бутылки портвейна ({npc:2491}) тоже лежат на этих пляжах, но его задания нет в маршруте. С черепахи изредка падает аварийный маяк OOX-09/HL: сохраните его.",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, редкая добыча",

	-- Step 17: Rin'ji's Secret
	-- {area:307} Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "Секрет лежит здесь: {area:307}, над пляжем.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "для персонажа {npc:7825} ({zone:1458}), примерно на 50-м уровне",

	-- Step 18: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "Обед: {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "К северу вдоль берега на маленьком острове – корзинка для пикника ({npc:14731}); ее охраняет {npc:14748}.",

	-- Step 19: The Vilebranch temples
	["The Vilebranch temples"] = "Храмы Порочной Ветви",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "К западу от острова охотники за скальпами из племени Порочной Ветви занимают храмы {area:1884} и {area:1917}. Инструменты Углежога лежат у одного из храмов.",

	-- Step 20: The central hills
	["The central hills"] = "Центральные холмы",
	-- {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Среброгривые бродяги, дикие совухи и остроклювы-повелители небес живут на холмах между храмами и местом {area:351}. Применяйте предмет {item:9618} на убитых совухов. С остроклювов-повелителей небес также падают длинные элегантные перья: сохраните десять для второго послания {npc:14738}.",

	-- Step 21: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "Ящики ({item:8684}) лежат у заброшенного лагеря Орды ({area:351}), среди слизней.",

	-- Step 22: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Только с аварийным маяком: робот сидит у истока реки к западу от места {area:351}. Сопроводите его на восток к берегу за местом {area:307}; награда ждет у Карлса Пропеллерза ({area:35}).",

	-- Step 23: Silvermane Howlers
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["Silvermane Howlers"] = "Среброгривые ревуны",
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "К юго-западу среброгривые ревуны бродят по холмам к востоку от деревень Сухокожих.",

	-- Step 24: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Назад на запад сюда: {area:350}; следопыты и стрелки держатся у поселения, разведчики и гонцы – на склонах к югу.",

	-- Step 25: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "для персонажа {npc:6986} ({zone:1454}), примерно на 50-м уровне",

	-- Step 26: Vilebranch soothsayers
	["Vilebranch soothsayers"] = "Ворожеи Порочной Ветви",
	-- {area:355} Altar of Zul · {npc:8636} Morta'gya the Keeper
	["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "По пути на восток: ворожеи из племени Порочной Ветви занимают место {area:355} – храм троллей к югу от центральных холмов. Квиага и {npc:8636} (элита, 50) стоят на вершине: бейте ворожей на нижних ступенях.",

	-- Step 27: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Череп охотника Малкора лежит на груде под руинами Порочной Ветви, его кости – на груде у подножия места {area:354}. Сосуды с порченой кровью стоят на нижних террасах, а {npc:14757} в плену на вершине. Держитесь троп: тролли внутри – элита.",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, на вершине ({area:354})",
	-- {area:355} Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "Его следующая просьба ({area:355}) – для группы.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Езжайте на запад до города дворфов Громового Молота ({area:348}) и оставьте послание у колодца в центре. В городе полно стражников Альянса: быстро зайдите, оставьте и уходите.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "Колодец: {area:348}",

	-- Step 30: Revantusk Village
	-- {area:3317} Revantusk Village
	["The next guide starts here, at {area:3317}."] = "Следующее руководство начинается здесь: {area:3317}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Следуйте по дорогам на восток через край {zone:1425} к деревне троллей на восточном побережье.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Череп охотника Малкора лежит на груде под руинами Порочной Ветви, его кости – на груде у подножия места {area:354}. Сосуды ({spell:19478}) стоят на нижних террасах, а {npc:14757} в плену на вершине. Держитесь троп: тролли внутри – элита.",
	-- ["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Езжайте на северо-восток от места {area:272} в край {zone:1425} и на восток по дороге; {npc:7801} стоит лагерем на холме к югу от эльфийского поселения ({area:350}).",
}
