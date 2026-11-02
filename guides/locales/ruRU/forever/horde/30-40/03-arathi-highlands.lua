-- Russian (ruRU): the guide forever/horde/30-40/03-arathi-highlands (forever/horde/30-40/03-arathi-highlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 2: Orgrimmar
	-- {object:1661} The Undercity · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{object:1661} has no Hunter or Shaman trainer: take the {zone:1454} zeppelin from the same tower instead and train in the city, then take the {zone:1458} zeppelin from the tower outside {zone:1454}'s main gate."] = "Здесь ({object:1661}) нет учителей охотников и шаманов: садитесь на дирижабль с той же башни ({zone:1454}) и обучитесь в городе, затем садитесь на дирижабль ({zone:1458}) с башни у главных ворот ({zone:1454}).",

	-- Step 3: Thunder Bluff
	-- {zone:1450} Moonglade · {npc:11798} Bunthen Plainswind · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Cast Teleport: {zone:1450} and take {npc:11798}'s flight to {zone:1456}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- Step 4: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Учителя: {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Обучитесь, пока вы здесь ({zone:1458}): учителя – здесь: {object:36070}, {object:36073} и {object:36082} (паладины: {npc:260093}).",

	-- Step 5: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Летите сюда: {area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 7: Boulderfist camp
	["Boulderfist camp"] = "Лагерь клана Тяжелого Кулака",
	-- {area:272} Tarren Mill · {area:1857} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "",
	["Below ground"] = "",

	-- Step 8: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["The violet shards glow just off the road a short way west of {area:321}."] = "Фиолетовые осколки светятся у дороги, недалеко к западу от места {area:321}.",

	-- Step 10: Hammerfall
	-- {npc:2851} Urda
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "Крепость орков в восточном конце дороги. {npc:2851}, распорядитель полетов, стоит у ворот.",

	-- Step 11: Highland raptors
	["Highland raptors"] = "Ящеры нагорья",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider
	["Highland Striders roam the hills all around {area:321}; both they and the Thrashers further west drop the eyes."] = "Долгоноги нагорья бродят по холмам вокруг места {area:321}; глаза падают и с них, и с твердозубов дальше к западу.",

	-- Step 13: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "",

	-- Step 14: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} – в дальнем конце ущелья.",

	-- Step 15: Witherbark Village
	["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village.\nCareful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "",

	-- Step 16: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "",

	-- Step 17: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head north; the outer circle stands in the middle of the highlands."] = "",

	-- Step 18: Fleshstalker raptors
	["Fleshstalker raptors"] = "Ящеры-плотоглоты",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Плотоглоты нагорья (36-37) охотятся на южном нагорье: стая к северу от места {area:316} и еще одна на равнине к западу. Выманивайте по одному.",

	-- Step 19: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "",

	-- Step 20: Professor Phizzlethorpe
	["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close.\nCareful: The ambush is two level 40 water elementals, and they are immune to frost. If the fight happens inside the cave, the professor joins in instead of working and further elementals keep appearing; holding the elementals at the cave entrance, away from him, lets him finish with only the first two to deal with."] = "",

	-- Step 22: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "К западу от бухты налетчики и колдуньи из клана Пронзающего Гребня (38-40) занимают берег: выманивайте по одному. Два затонувших корабля лежат на мелководье, карты и журналы – внутри; самоцветы лежат на дне вокруг кораблей.",
	["Underwater"] = "",

	-- Step 23: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 44"] = "для персонажа {npc:2487} ({area:35}), примерно на 44-м уровне",

	-- Step 24: Circle of West Binding: kill these as you meet them
	-- {area:334} Circle of West Binding
	["{area:334}: kill these as you meet them"] = "",
	-- {area:1857} Thoradin's Wall
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["The western circle is near {area:1857}, where you came in.\nThe Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "",

	-- Step 25: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "Внутренний круг – к югу от западного, к востоку от Стромгарда.",
	["The stone's next task needs Fozruk, a level 42 elite: leave it."] = "Следующее задание камня требует убить Фозрука (элита 42-го уровня): не берите его.",

	-- Step 26: Hearth to Hammerfall
	-- {area:321} Hammerfall
	["Hearth to {area:321}"] = "",

	-- Step 27: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Назад: {area:321}",

	-- Step 28: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "Громилы из клана Тяжелого Кулака стоят лагерем у чертога огров к югу от места {area:321}; среди них – волхвы. Выманивайте по одному.",

	-- Step 29: Drum Fel
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms
	["{npc:2771}'s next {quest:678} is against Boulderfist elites: leave it."] = "Следующее задание ({quest:678}, {npc:2771}) – против элитных огров Тяжелого Кулака: не берите его.",

	-- Step 30: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "В край {zone:1418}",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "",

	-- Step 31: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: письмо Пшикса Медноштифа ({area:439})",

	-- Step 32: Kargath
	-- {area:340} Kargath
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge."] = "{area:340} – крепость Орды в скалах у западного края зоны.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "для Хелгрума ({area:75}), примерно на 42-м уровне",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "",

	-- Step 33: The Dustbowl
	-- {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl · {area:340} Kargath
	["Head west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "",

	-- Step 34: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Младшие каменные элементали",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats just west of {npc:2921}'s camp. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards: keep them."] = "Маленькие элементали бродят по равнине чуть к западу от лагеря {npc:2921}. С любого каменного элементаля в зоне могут падать осколки каменного элементаля для {npc:6868}: сохраните их.",

	-- Step 36: Apocryphan's Rest: kill these as you meet them
	-- {area:337} Apocryphan's Rest
	["{area:337}: kill these as you meet them"] = "",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Старые скальные койоты и гигантские канюки бродят по низине к югу от {area:1878}. С койотов падают и челюсти, и клыки; крылья и желудки – только с канюков.",

	-- Step 37: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Тельдарин сидит среди руин дворфов ({area:345}), к югу от места {area:1877}.",

	-- Step 38: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "",
	-- {area:1878} The Dustbowl · {area:1877} Valley of Fangs · {area:345} Agmond's End
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab.\nThe Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "",

	-- Step 39: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Идите дальше на север по дороге; сундук – на раскопках ({area:1517}), у подножия руин к северо-западу от дороги.",

	-- Step 41: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "",

	-- Step 42: Rock Elemental Shards
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["Rock Elemental Shards"] = "",
	-- {zone:1418} Badlands · {npc:6868} Jarkal Mossmeld · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Every rock elemental in the {zone:1418} drops {npc:6868}'s shards: the Lesser Rock Elementals (37) on the flats west of {npc:2921}'s camp are the safe ones, about one kill in five. Only the Greater Rock Elementals (42-44, well above you) in the south-western gulches drop {npc:2921}'s bracers, also about one kill in five: pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "",

	-- Step 44: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: только если у вас есть {item:2868} ({skill:164} или аукцион)",

	-- Step 45: Kargath
	-- {area:340} Kargath
	["Head north back to {area:340}."] = "",

	-- Step 46: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите сюда: {object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "",

	-- Step 47: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 49: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "",

	-- Step 50: Fly to Crossroads
	-- {area:380} Crossroads
	["Fly to {area:380}"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 52: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:380} Crossroads
	["{area:380} flight master"] = "",

	-- Step 54: Thunder Bluff
	-- {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:380} Crossroads
	["Your trainer is in {area:1638}, one flight from {zone:1454}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to the {area:380} from there."] = "Ваш учитель – в городе {area:1638}, в одном перелете от города {zone:1454}: {npc:3033} (друиды), ориентир: {area:1639}; {npc:246344} (паладины). Оттуда летите дальше сюда: {area:380}.",

	-- Step 55: Back to Crossroads
	-- {area:380} Crossroads
	["Back to {area:380}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 57: Regthar Deathgate
	-- {area:380} Crossroads · {area:386} Forgotten Pools · {npc:3389} Regthar Deathgate
	["Head north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "Используйте {spell:18960} и летите сюда: {area:1638} (распорядитель полетов: {npc:11798}); учитель: {npc:3033} ({area:1639}). Затем летите сюда: {zone:1454} и садитесь на дирижабль ({zone:1458}) с башни у главных ворот.",
	-- ["Coyotes and buzzards"] = "Койоты и канюки",
	-- ["Daggerspine shore"] = "Берег наг Пронзающего Гребня",
	-- ["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}."] = "{object:180105} – это кольцо стоячих камней; ключ лежит на камне в центре. Восточный круг – на холмах к северо-западу от места {area:321}.",
	-- ["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close."] = "Сопроводите профессора к берегу. По пути на него нападут две наги из клана Пронзающего Гребня: держитесь рядом.",
	-- ["Follow the road north; {npc:4618}'s camp is on the way."] = "Идите по дороге на север; лагерь {npc:4618} – по пути.",
	-- ["From {area:35}, fly to {object:3202}. {object:1661} zeppelin leaves from the tower on the west side of the camp."] = "Из места {area:35} летите сюда: {object:3202}. Дирижабль ({object:1661}) отправляется с башни в западной части лагеря.",
	-- ["Greater Rock Elementals"] = "Большие каменные элементали",
	-- ["Hearth to {area:340}"] = "Камень возвращения: {area:340}",
	-- ["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael."] = "К северо-востоку от Павшего Молота кобольды из племени Сухоусов копают в ущелье; с кобольдов у входа и с землекопов и геодезистов в глубине падает «Мощь Мизраэли».",
	-- ["Ride back south down the road, past the {area:1877}."] = "Возвращайтесь на юг по дороге, мимо места {area:1877}.",
	-- ["Ride back south to the {area:380} and fly to {area:392}."] = "Возвращайтесь на юг сюда: {area:380} и летите сюда: {area:392}.",
	-- ["Ride east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "Езжайте на восток от места {area:272} через место {area:1857} и дальше по дороге на восток. Огры и головорезы из клана Тяжелого Кулака (32-34) стоят лагерем к югу от дороги, к юго-востоку от места {area:313}.",
	-- ["Ride north back to {area:340}."] = "Возвращайтесь на север сюда: {area:340}.",
	-- ["Ride north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "Езжайте на север по дороге от места {area:380} сюда: {area:386}; {npc:3389} стоит на возвышенности над водой.",
	-- ["Ride north; the outer circle stands in the middle of the highlands."] = "Езжайте на север; внешний круг – в центре нагорья.",
	-- ["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Езжайте на юг вдоль побережья от места {area:392} сюда: {area:720}. {npc:6236} стоит у арены: встаньте на решетку, чтобы начать бой; противники выходят по одному, затем {npc:6238} (33).",
	-- ["Ride south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Езжайте на юго-запад из Арати через место {area:880}, на юг через край {zone:1437} (обходите место {area:150}) и на восток в край {zone:1432}; из края {zone:1432} дорога ведет на юг в край {zone:1418}. Следуйте по ней на юг к лагерю гоблинов ({area:1877}).",
	-- ["Ride south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Езжайте на юго-запад к бухте гоблинов на южном побережье. {npc:2766} стоит на скале над ней.",
	-- ["Ride west along the road; Lotwil's camp sits in the {area:1878} halfway to {area:340}."] = "Езжайте на запад по дороге; лагерь Лотвиля – здесь: {area:1878}, на полпути к месту {area:340}.",
	-- ["Ride west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "Езжайте на запад по дороге; лагерь {npc:2921} – в {area:1878}, на полпути к месту {area:340}.",
	-- ["Rock Elementals"] = "Каменные элементали",
	-- ["Stonevault troggs"] = "Трогги Каменного Свода",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202}."] = "Садитесь на дирижабль ({zone:1454}) с башни в западной части лагеря ({object:3202}).",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Старые скальные койоты и гигантские канюки бродят по низине к югу от места {area:1878}. С койотов падают и челюсти, и клыки; крылья и желудки – только с канюков.",
	-- ["The Greater Rock Elementals (42-44, well above you) wander the gulches in the south-west; the bracers drop about one kill in five. Pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Большие каменные элементали (42-44, намного выше вас) бродят по ущельям на юго-западе; наручи падают примерно с каждого пятого. Выманивайте по одному и отдыхайте между боями – или пропустите их. По пути добивайте нужных вам койотов и канюков.",
	-- ["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "Трогги племени Каменного Свода копают у входов в пещеры к югу от места {area:1877}, по пути к месту {area:345}; хлопья падают с костегрызов и шаманов.",
	-- ["The Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets."] = "Синдикат занимает обнесенную стеной усадьбу и ферму на северо-западе; амулеты Кровавого камня носят проходимцы, наемники и налетчики Синдиката.",
	-- ["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village."] = "Тролли племени Сухокожих занимают деревню на юго-восточных холмах. Метатели топоров охраняют крайние хижины; знахари и охотники за головами – в центре деревни.",
	-- ["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Каменные элементали покрупнее стоят на склонах к северо-западу от {area:1878}; с каждого падает плита.",
	-- ["The next guide heads into {zone:1445}."] = "Следующее руководство ведет в край {zone:1445}.",
	-- ["The western circle is near {area:1857}, where you rode in."] = "Западный круг – у места {area:1857}, где вы въехали.",
	-- ["The zeppelin lands at the towers outside the {zone:1458}: ride down into the city and fly to {area:272}."] = "Дирижабль причаливает к башням у города ({zone:1458}): спуститесь в город и летите сюда: {area:272}.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {object:2689}"] = "{object:2689}",
	-- ["Zeppelin to the {zone:1458}"] = "Дирижабль: {zone:1458}",
	-- ["Zeppelin tower"] = "Башня дирижаблей",
	-- ["for {npc:5395} in {zone:1443}, in the next guide"] = "для персонажа {npc:5395} ({zone:1443}), в следующем руководстве",
	-- ["{item:3713}, for \"Swamp Eye\" Jarl in {zone:1445}"] = "{item:3713}, для Ярла «Болотного Глаза» ({zone:1445})",
}
