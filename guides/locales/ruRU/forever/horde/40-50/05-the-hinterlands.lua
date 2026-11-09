-- Russian (ruRU): the guide forever/horde/40-50/05-the-hinterlands (forever/horde/40-50/05-the-hinterlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Летите сюда: {area:272}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "",

	-- Step 2: The Hinterlands
	-- {npc:7801} Gilveradin Sunchaser
	["{npc:7801}'s camp"] = "Лагерь {npc:7801}",

	-- Step 3: Gilveradin Sunchaser's camp
	-- {area:272} Tarren Mill · {zone:1425} The Hinterlands · {npc:7801} Gilveradin Sunchaser · {area:350} Quel'Danil Lodge
	["Ride north-east from {area:272} into the {zone:1425} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Езжайте на северо-восток от места {area:272} во {zone:1425} и на восток по дороге; {npc:7801} стоит лагерем на холме к югу от эльфийского поселения ({area:350}).",

	-- Step 4: Highvale
	["Highvale"] = "Высокодолье",
	-- {area:350} Quel'Danil Lodge · {npc:7780} Rin'ji
	["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way.\nCareful: Groups of about three elves ambush the escort, usually twice."] = "",

	-- Step 5: Violet Tragan
	["East of the village, the violet flower grows in the hills."] = "К востоку от деревни на холмах растет фиолетовый цветок.",
	["Underwater"] = "",

	-- Step 6: Revantusk Village
	-- {zone:1425} The Hinterlands
	["Follow the roads east across the {zone:1425} to the troll village on the eastern coast."] = "Следуйте по дорогам на восток через {zone:1425} к деревне троллей на восточном побережье.",

	-- Step 8: Revantusk Village
	-- {quest:7849} Separation Anxiety · {quest:7845} Kidnapped Elder Torntusk! · {quest:7850} Dark Vessels · {area:354} Jintha'Alor · {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{quest:7849}, {quest:7845} and {quest:7850} are group quests: they send you into {area:354}, whose trolls are elite (46-50). Take them with a group of three or more; skip them if you are alone, the route has you grind the experience back.\n{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "",

	-- Step 9: The Overlook Cliffs: kill these as you meet them
	-- {area:307} The Overlook Cliffs
	["{area:307}: kill these as you meet them"] = "",
	-- {npc:2491} Whiskey Slim · {area:307} The Overlook Cliffs
	["The big turtles crawl along the beaches north of the village, and {npc:2491}'s bottles of port lie on the same beaches, from the village up to the {area:307}: pick them up as you go. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "",
	-- {object:2068} Pupellyverbos Port
	["{object:2068}, on the beaches"] = "",
	-- {item:8704} OOX-09/HL Distress Beacon
	["{item:8704}, a rare drop"] = "{item:8704}, редкая добыча",

	-- Step 10: The Overlook Cliffs: kill these as you meet them
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} is a level 48 elite: most classes solo it at level 50, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 11: Rin'ji's Secret
	-- {area:307} The Overlook Cliffs
	["The secret lies on the {area:307}, above the beach."] = "Секрет лежит здесь: {area:307}, над пляжем.",
	-- {npc:7825} Oran Snakewrithe · {zone:1458} Undercity
	["for {npc:7825} in the {zone:1458}, around level 50"] = "для персонажа {npc:7825} ({zone:1458}), примерно на 50-м уровне",

	-- Step 12: Lard's lunch
	-- {npc:14731} Lard
	["{npc:14731}'s lunch"] = "Обед: {npc:14731}",
	-- {npc:14731} Lard · {npc:14748} Vilebranch Kidnapper
	["North along the coast, {npc:14731}'s picnic basket is on the small island; a {npc:14748} guards it."] = "К северу вдоль берега на маленьком острове – корзинка для пикника ({npc:14731}); ее охраняет {npc:14748}.",

	-- Step 14: Shaol'watha: kill these as you meet them
	-- {area:1917} Shaol'watha
	["{area:1917}: kill these as you meet them"] = "",
	-- {area:1884} Agol'watha · {area:1917} Shaol'watha · {area:351} Skulk Rock · {item:9618} Wildkin Muisek Vessel · {npc:14738} Otho Moji'ko · {spell:7367} Infected Bite · {npc:2925} Silvermane Howler
	-- plural, as words: Silvermane Stalkers = {npc:2926} Silvermane Stalker · Savage Owlbeasts = {npc:2929} Savage Owlbeast · Razorbeak Skylords = {npc:2659} Razorbeak Skylord · Long Elegant Feathers = {item:4589} Long Elegant Feather
	["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples.\nThe Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message.\nCareful: Silvermane Stalkers are level 47-48 and stay stealthed while out of combat. Up close they use {spell:7367}. When a {npc:2925} falls to 50% health or lower, it calls for help from anything within 25 yd."] = "",

	-- Step 15: Skulk Rock
	-- {item:8684} Hinterlands Honey Ripple · {area:351} Skulk Rock
	["The crates of {item:8684} lie around the abandoned Horde camp at {area:351}, among the oozes."] = "Ящики ({item:8684}) лежат у заброшенного лагеря Орды ({area:351}), среди слизней.",

	-- Step 16: Wildkin Muisek
	-- {area:1883} Valorwind Lake
	["Careful: Stealthed wolves and griffons roam the {area:1883} area."] = "",

	-- Step 17: The Altar of Zul: kill these as you meet them
	-- {area:355} The Altar of Zul
	["{area:355}: kill these as you meet them"] = "",
	-- {area:355} The Altar of Zul · {npc:8636} Morta'gya the Keeper
	-- plural, as words: Silvermane Howlers = {npc:2925} Silvermane Howler
	["South-west of the lake, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps.\nSouth-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "",

	-- Step 18: OOX-09/HL
	["OOX-09/HL"] = "OOX-09/HL",
	-- {area:351} Skulk Rock · {area:307} The Overlook Cliffs · {area:35} Booty Bay
	["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}.\nCareful: Two ambushes spawn during the escort: first three wildkin owlbeasts, then three trolls. Before each, the robot halts and announces it senses danger. Oozes, stealthed wolves and a large turtle along the path can join fights, and they respawn even if cleared beforehand."] = "",

	-- Step 19: Gilveradin Sunchaser's camp
	-- {npc:6986} Dran Droffers · {zone:1454} Orgrimmar
	["for {npc:6986} in {zone:1454}, around level 50"] = "для персонажа {npc:6986} ({zone:1454}), примерно на 50-м уровне",

	-- Step 20: Highvale
	-- {area:350} Quel'Danil Lodge
	["Back west to {area:350}; rangers and marksmen stay near the lodge, scouts and outrunners on the slopes south of it."] = "Назад на запад сюда: {area:350}; следопыты и стрелки держатся у поселения, разведчики и гонцы – на склонах к югу.",

	-- Step 21: Jintha'Alor
	-- {area:354} Jintha'Alor · {npc:14757} Elder Torntusk
	["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. The trolls inside are elite: stay with your group and keep to the paths."] = "",
	-- {npc:14757} Elder Torntusk · {area:354} Jintha'Alor
	["{npc:14757}, at the top of {area:354}"] = "{npc:14757}, на вершине ({area:354})",
	-- {area:355} The Altar of Zul
	["His next request, going on to the {area:355}, is for a group."] = "Его следующая просьба ({area:355}) – для группы.",

	-- Step 22: Revantusk Village
	-- {npc:14731} Lard
	["{npc:14731}, inside"] = "",

	-- Step 23: Revantusk Village
	-- {npc:14736} Primal Torntusk · {npc:14731} Lard
	["{npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "{npc:14736} стоит на крыше таверны, над NPC {npc:14731}: поднимитесь наверх, Стрелка не различает высоту.",

	-- Step 25: Level 49.02
	["Level 49.02"] = "",
	-- {quest:7816} Gammerita, Mon! · {area:354} Jintha'Alor · {area:2100} Maraudon
	["If you skipped {quest:7816} or the {area:354} group quests, grind here to level 49.02 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon instead."] = "",
	-- {npc:2505} Saltwater Snapjaw
	["grind on {npc:2505}"] = "",

	-- Step 26: The Atal'ai Exile
	-- {area:353} Shadra'Alor
	["South-west again, the exile hides by the ruins of {area:353}."] = "Снова к юго-западу: изгнанник прячется у руин ({area:353}).",

	-- Step 28: Grim Message
	-- {item:15002} Nimboya's Pike
	["South of the lodge the Witherbark trolls hold their villages. Every one of them carries a skull: with twenty, use {item:15002} to make the Laden Pike, then plant it inside the village."] = "К югу от поселения тролли племени Сухокожих занимают свои деревни. Череп есть у каждого: собрав двадцать, используйте предмет {item:15002}, чтобы сделать пику с тролльими черепами, затем установите ее в деревне.",

	-- Step 29: Aerie Peak
	-- {area:348} Aerie Peak
	["Ride all the way west to the Wildhammer town of {area:348} and place the message by the well in its centre. The town is full of Alliance guards: get in, place it and get out."] = "Езжайте на запад до города дворфов Громового Молота ({area:348}) и оставьте послание у колодца в центре. В городе полно стражников Альянса: быстро зайдите, оставьте и уходите.",
	-- {area:348} Aerie Peak
	["{area:348} well"] = "Колодец: {area:348}",

	-- Step 31: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Летите сюда: {area:75}",
	-- {area:3317} Revantusk Village
	["{area:3317} flight master"] = "",

	-- Step 32: Fel'zerul
	["On the top floor"] = "",

	-- Step 33: Fallen Hero of the Horde
	-- {zone:1419} Blasted Lands
	["The ghostly orc stands by the road where the swamp meets the canyon into the {zone:1419}. Listen to his story."] = "",

	-- Step 35: Fallen Hero of the Horde
	-- {npc:7623} Dispatch Commander Ruag · {area:75} Stonard · {zone:1419} Blasted Lands
	["for {npc:7623} in {area:75}, after the {zone:1419}"] = "",

	-- Step 36: The bloodmages
	["The bloodmages"] = "Волшебники крови",
	-- {area:75} Stonard · {zone:1419} Blasted Lands
	["Ride west out of {area:75} and south through the canyon into the {zone:1419}; the two bloodmages stand by the road just inside."] = "Езжайте на запад от места {area:75} и на юг через каньон в край {zone:1419}; два волшебника крови стоят у дороги сразу за входом.",

	-- Step 37: Serpent's Coil: kill these as you meet them
	-- {area:1440} Serpent's Coil
	["{area:1440}: kill these as you meet them"] = "",
	-- {npc:5982} Black Slayer · {spell:5416} Venom Sting · {npc:8301} Clack the Reaver
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger
	["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills.\nEast of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south.\nCareful: Scorpok Stingers use {spell:5416}; {npc:8301} adds Knockdown."] = "",

	-- Step 38: The bloodmages
	["Ride back north to the bloodmages."] = "Возвращайтесь на север к волшебникам крови.",
	["Their follow-ups ask for the same parts again for a buff item and pay no experience: leave them."] = "Следующие задания снова требуют те же части ради предмета с усилением и не дают опыта: не берите их.",

	-- Step 39: Stonard
	-- {area:75} Stonard
	["Ride back north through the canyon to {area:75}."] = "",
	-- {npc:7643} Bengor · {npc:950} Swamp Talker
	["{npc:7643}'s The {npc:950} is a level 55 quest: leave it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East of the road the Ashmane boars and Grunters root on the slopes beside the Redstone basilisks. Stay away from the level 52 Helboars further south."] = "К востоку от дороги на склонах пасутся пеплогривые кабаны и хрюггеры, рядом – краснокаменные василиски. Держитесь подальше от зловепрей 52-го уровня дальше к югу.",
	-- ["Fly to the {area:1497}"] = "Летите сюда: {area:1497}",
	-- ["Follow the roads east across the {area:47} to the troll village on the eastern coast."] = "Следуйте по дорогам на восток через {area:47} к деревне троллей на восточном побережье.",
	-- ["Follow the roads east across the {area:47} to the troll village on the eastern coast. {npc:14736} stands up on top of the inn, above {npc:14731}: go up, the arrow cannot tell the levels apart."] = "Следуйте по дорогам на восток через {area:47} к деревне троллей на восточном побережье. {npc:14736} стоит на крыше таверны, над NPC {npc:14731}: поднимитесь наверх, Стрелка не различает высоту.",
	-- ["From {area:1446}'s flight master."] = "У распорядителя полетов ({area:1446}).",
	-- ["Grind to 48"] = "Набейте 48-й уровень",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of Tainted Blood sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Череп охотника Малкора лежит на груде под руинами Порочной Ветви, его кости – на груде у подножия места {area:354}. Сосуды с порченой кровью стоят на нижних террасах, а {npc:14757} в плену на вершине. Держитесь троп: тролли внутри – элита.",
	-- ["Huntsman Malkhor's skull lies on a pile below the Vilebranch ruins, his bones on a pile at the foot of {area:354}. The Vessels of {spell:19478} sit on the lower terraces, and {npc:14757} is held at the top. Keep to the paths: the trolls inside are elite."] = "Череп охотника Малкора лежит на груде под руинами Порочной Ветви, его кости – на груде у подножия места {area:354}. Сосуды ({spell:19478}) стоят на нижних террасах, а {npc:14757} в плену на вершине. Держитесь троп: тролли внутри – элита.",
	-- ["On the way back east, the Vilebranch soothsayers hold the {area:355}, the troll temple south of the central hills. Qiaga and {npc:8636} (elite, 50) stand at its top: take the soothsayers on the lower steps."] = "По пути на восток: ворожеи из племени Порочной Ветви занимают место {area:355} – храм троллей к югу от центральных холмов. Квиага и {npc:8636} (элита, 50) стоят на вершине: бейте ворожей на нижних ступенях.",
	-- ["Only if you are not level 48 yet."] = "Только если у вас еще нет 48-го уровня.",
	-- ["Only with the distress beacon: the robot sits at the head of the river west of {area:351}. Escort it east to the shore beyond the {area:307}; its reward waits with Oglethorpe in {area:35}."] = "Только с аварийным маяком: робот сидит у истока реки к западу от места {area:351}. Сопроводите его на восток к берегу за местом {area:307}; награда ждет у Карлса Пропеллерза ({area:35}).",
	-- ["Ride north back to {area:75} and fly to the {area:1497}."] = "Возвращайтесь на север сюда: {area:75} и летите сюда: {area:1497}.",
	-- ["Ride north-east from {area:272} into the {area:47} and east along the road; {npc:7801} camps on the hill south of the elves' {area:350}."] = "Езжайте на северо-восток от места {area:272} во {area:47} и на восток по дороге; {npc:7801} стоит лагерем на холме к югу от эльфийского поселения ({area:350}).",
	-- ["Saltwater Snapjaws"] = "Морские хрустогрызы",
	-- ["Silvermane Howlers"] = "Среброгривые ревуны",
	-- ["South-west, the Silvermane Howlers roam the hills east of the Witherbark villages."] = "К юго-западу среброгривые ревуны бродят по холмам к востоку от деревень Сухокожих.",
	-- ["The Highvale elves camp around {area:350}. Burn the report, the notes and the records in their camps. {npc:7780} is held inside the lodge: lead him out and fight off the ambush on the way."] = "Эльфы Высокодолья стоят лагерем вокруг места {area:350}. Сожгите отчет, заметки и записи в их лагерях. {npc:7780} в плену внутри: выведите его и отбейте засаду по пути.",
	-- ["The Silvermane Stalkers, Savage Owlbeasts and Razorbeak Skylords share the hills between the temples and {area:351}. Use the {item:9618} on the owlbeasts you kill. The Skylords also drop Long Elegant Feathers: keep ten for {npc:14738}'s second message."] = "Среброгривые бродяги, дикие совухи и остроклювы-повелители небес живут на холмах между храмами и местом {area:351}. Применяйте предмет {item:9618} на убитых совухов. С остроклювов-повелителей небес также падают длинные элегантные перья: сохраните десять для второго послания {npc:14738}.",
	-- ["The Vilebranch temples"] = "Храмы Порочной Ветви",
	-- ["The big turtles crawl along the beaches north of the village. {npc:2491}'s port bottles lie on these beaches too, but his quest is not on this route. A snapjaw can drop OOX-09/HL's distress beacon, rarely: keep it."] = "Большие черепахи ползают по пляжам к северу от деревни. Бутылки портвейна ({npc:2491}) тоже лежат на этих пляжах, но его задания нет в маршруте. С черепахи изредка падает аварийный маяк OOX-09/HL: сохраните его.",
	-- ["The central hills"] = "Центральные холмы",
	-- ["The eastern slopes"] = "Восточные склоны",
	-- ["The five quests share the same parts: gather them all in one sweep. West of the road the {npc:5982} vultures, Starving Snickerfangs, Scorpok Stingers and Deatheye basilisks share the hills."] = "Для пяти заданий нужны одни и те же части: соберите все за один проход. К западу от дороги на холмах живут грифы ({npc:5982}), голодные хохотуны, скорпоки-острожалы и василиски-смертеглазы.",
	-- ["The next guide starts here, at {area:3317}."] = "Следующее руководство начинается здесь: {area:3317}.",
	-- ["The northern beasts"] = "Северные звери",
	-- ["Vilebranch soothsayers"] = "Ворожеи Порочной Ветви",
	-- ["Vulture hills"] = "Холмы грифов",
	-- ["West of the island, the Vilebranch scalpers hold the temples of {area:1884} and {area:1917}. Slagtree's tools lie at one of the temples."] = "К западу от острова охотники за скальпами из племени Порочной Ветви занимают храмы {area:1884} и {area:1917}. Инструменты Углежога лежат у одного из храмов.",
	-- ["grind on {npc:5982} at the northern hills, {zone:1419}"] = "бейте монстров {npc:5982} на северных холмах, {zone:1419}",
	-- ["{npc:2926} on the way"] = "{npc:2926} по пути",
	-- ["{npc:6741}: for {zone:1456}, around level 50"] = "{npc:6741}: для города {zone:1456}, примерно на 50-м уровне",
	-- ["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",
}
