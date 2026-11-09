-- Russian (ruRU): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "",

	-- Step 4: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Дворфы Тенегорна стоят лагерем чуть севернее раскопок; смятая карта лежит среди их палаток. Кирка Ржанца – у проходчиков и темнопрядов. По склонам вокруг бродят скальные койоты.",

	-- Step 5: The excavation crate
	["The excavation crate"] = "Ящик с раскопок",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "",

	-- Step 6: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "Следующее поручение Ржанца ведет сюда: {area:1517}. Пропустите его.",

	-- Step 7: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} и {npc:2817} стоят лагерем вместе ({area:1877}), в центре зоны {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Моллюски – на северо-западном побережье Тернистой долины, в следующем гайде: сохраните задание",

	-- Step 8: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Разбитый скелет лежит чуть восточнее огров, на краю лагеря троггов из племени Каменного Свода; хлопья падают с костегрызов и шаманов вокруг. Тельдарин сидит у разрушенного лагеря дальше к югу.",

	-- Step 9: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "",
	-- {quest:739} Murdaloc · {spell:5242} Battle Shout · {spell:1160} Demoralizing Shout · {area:340} Kargath
	-- plural, as words: Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "Огры из клана Гнилобрюхов стоят лагерем чуть южнее долины; лом падает с любого из них. Над равниной к востоку кружат канюки.\nРазбитый скелет лежит на краю лагеря троггов из племени Каменного Свода; убийца Агмонда ({quest:739}) ходит среди костегрызов.\nОсторожно: повелители из клана Гнилобрюхов – 44-45-го уровня. Они применяют {spell:5242} и {spell:1160}, а при здоровье ниже 50% зовут на помощь союзников в радиусе 15 м. Семеро из них стоят примерно в 750 м к югу (ориентир: {area:340}).",
	-- {quest:739} Murdaloc · {zone:1418} Badlands
	["{quest:739} himself (42) walks among the Bonesnappers: leave him for the later {zone:1418} guide at 43, and kill the Bonesnappers for this quest now."] = "",

	-- Step 10: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "",

	-- Step 11: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Младшие каменные элементали",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus · {npc:1470} Ghak Healtouch
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards."] = "Младшие каменные элементали бродят здесь: {area:1878}, к западу от {npc:2921}; осколки каменных элементалей для NPC {npc:1470} могут выпасть из любого каменного элементаля.",

	-- Step 13: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Head north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "",

	-- Step 14: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:345} Agmond's End
	["Head south down the road: {npc:4618} and {npc:2817} camp in the {area:1877}, on the way to {area:345}."] = "",
	-- {npc:4454} Fizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["For {npc:4454} at the {area:2240}: the {zone:1446} guide passes him at 45, keep it"] = "",

	-- Step 15: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "для NPC {npc:2786} ({zone:1455}): сохраните задание",

	-- Step 16: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Каменные элементали",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Каменные элементали бродят к юго-востоку от {npc:2921}; на равнине к западу от них – гигантские канюки и старые скальные койоты.",

	-- Step 17: Lotwil Veriatus
	-- {npc:2921} Lotwil Veriatus · {item:4628} Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s last test is optional: five {item:4628}, which only the Greater Rock Elementals (42-44) in the south-western gulches drop, about one kill in five, well above your level. Take it only if you can handle them one at a time; otherwise hand in the slabs and move on."] = "",

	-- Step 18: Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["South-west into the gulches: only the Greater Rock Elementals there drop the bracers."] = "",

	-- Step 20: Lucien Tosselwrench
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus · {item:2868} Patterned Bronze Bracers
	["{npc:2920}, beside {npc:2921}, trades for {item:2868}, a blacksmith's craft: this step shows only when you carry a pair."] = "",
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, рядом с {npc:2921}",

	-- Step 21: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 22: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "",

	-- Step 23: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 25: Theramore flight master
	["Theramore flight master"] = "",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "",

	-- Step 26: Nijel's Point
	-- {npc:5638} Kreldig Ungor
	["{npc:5638}: the wreck is on the north-west coast, at the end of the loop"] = "",

	-- Step 27: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Идите по дороге на юг. Цель: {area:2407}.",

	-- Step 28: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} стоит на краю места {area:596}, к юго-западу (ориентир: {area:2407}); {object:176751} лежат среди скелетов. По кладбищу ползает {npc:217590}: поймайте одного с помощью набора начинающего энтомолога и отметьте цель.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: поймайте для задания «Мои маленькие друзья»",

	-- Step 29: Maraudine centaurs
	["Maraudine centaurs"] = "Кентавры из племени Мародин",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Кентавры из племени Мародин занимают {area:607} к западу от кладбища; тотемы падают со всех.",

	-- Step 30: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "сопроводите {npc:12277} обратно к кладбищу",

	-- Step 31: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "",

	-- Step 32: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Опустошители-отрекшиеся бродят по костяным полям к югу от деревни племени Маграм, к востоку от Ковена; на дальнем юго-востоке используйте {item:15848}, чтобы приманить призраков из племени Маграм.",

	-- Step 35: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Идите по дороге на запад через север зоны {zone:1443} к руинам ({area:2405}). Там на холме, по пути к обломкам корабля, стоит башня {npc:11863}.",

	-- Step 36: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "Сундук с разбитого корабля лежит на берегу чуть западнее башни {npc:11863}.",

	-- Step 37: Claim Rackmore's Treasure!
	["Underwater"] = "",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Идите по дороге на север. Цель: {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "для NPC {npc:5637} ({zone:1455}): сохраните задание",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "для NPC {npc:3980} ({area:271}): сохраните задание",

	-- Step 39: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "",
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, вождь кентавров, стоит лагерем на северо-западном побережье, к северу от башни {npc:11863}.",

	-- Step 44: Fly to Theramore
	["Fly to Theramore"] = "Лететь на остров Терамор",
	["The next guide starts in Theramore."] = "Следующий гайд начинается на острове Терамор.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Идите по дороге на запад через север зоны {zone:1443} к руинам ({area:2405}); сундук с разбитого корабля лежит на берегу чуть западнее.",
	-- ["Greater Rock Elementals"] = "Большие каменные элементали",
	-- ["Lesser Rock Elementals"] = "Младшие каменные элементали",
	-- ["Ogres and buzzards"] = "Огры и канюки",
	-- ["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Вернитесь на запад к дороге и идите по ней на юг из зоны {zone:1432} через перевал в зону {zone:1418}. {npc:2910} и {npc:2860} стоят лагерем бок о бок у раскопок.",
	-- ["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Езжайте на северо-восток к заброшенным раскопкам; ящик с припасами лежит там среди огров из клана Гнилобрюхов.",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Езжайте на северо-восток к руинам дворфов на севере зоны {zone:1418}; сундук стоит среди дворфов Тенегорна. {npc:2745} поблизости – элита: держитесь от него подальше.",
	-- ["Ride south to {area:345}."] = "Езжайте на юг. Цель: {area:345}.",
	-- ["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Езжайте на запад. Цель: {area:1878}; в ее центре у своих машин работает {npc:2921}.",
	-- ["Shadowforge camp"] = "Лагерь Тенегорна",
	-- ["Take the boat to Theramore from the far pier."] = "Сядьте на корабль до острова Терамор у дальнего причала.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Огры из клана Гнилобрюхов стоят лагерем чуть южнее долины; лом падает с любого из них. Над равниной к востоку кружат канюки.",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Большие каменные элементали (42-й уровень) ходят в дальнем юго-западном углу, под местом {area:342}; выманивайте по одному. Лом падает и с охотников на драконов и извергов из клана Гнилобрюхов ({area:342}).",
	-- ["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Младшие каменные элементали бродят здесь: {area:1878}, к западу от {npc:2921}.",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Разбитый скелет лежит чуть восточнее огров, на краю лагеря троггов из племени Каменного Свода; хлопья падают с костегрызов и шаманов вокруг. Тельдарин сидит у разрушенного лагеря дальше к югу.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Демоны собираются здесь: {area:602}, юг зоны {zone:1443}: гончие Скверны (пожиратели маны, охотники на магов и охотники за магией), девы и сестры Пустоты, а вокруг ямы – капитаны тюремщиков судеб.",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Распорядитель полетов стоит у ворот ({area:514}); {npc:5083} и {npc:4964} – внутри цитадели.",
	-- ["The next guide starts in Theramore."] = "Следующий гайд начинается на острове Терамор.",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "Следующее задание скелета, «Мурдалок», подождет до более позднего гайда по зоне {zone:1418} на 43-м уровне.",
	-- ["Theramore"] = "Остров Терамор",
	-- ["for the Dustwallow loop in the next guide"] = "для круга по Пылевым топям в следующем гайде",
	-- ["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "для NPC {npc:4454} ({area:439}): гайд по зоне {zone:1446} проходит там на 45-м уровне, сохраните задание",
	-- ["only if you carry {item:2868} (a blacksmith's craft)"] = "только если у вас есть {item:2868} (изделие кузнеца)",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "Караван (это {npc:11626}) останавливается на дороге к востоку (ориентир: {area:606}). Возьмите задание и идите с кодо мимо места {area:602}, убивая нападающих демонов; потом поговорите со {npc:11596} в его лагере к востоку (ориентир: {area:596}).",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "Башня {npc:11863} стоит на холме к востоку от обломков корабля.",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} держат в лагере кентавров к западу от кладбища. Освободите ее и защищайте по пути наружу; она остановится у кладбища.",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}, в таверне",
	-- ["{npc:2921}'s next test needs crafted gear: skip it."] = "Для следующего испытания {npc:2921} нужно изготовленное снаряжение: пропустите его.",
	-- ["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {area:3}."] = "{npc:4618} и {npc:2817} стоят лагерем вместе ({area:1877}), в центре зоны {area:3}.",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "Следующее задание {npc:5638}, {item:6245}, – добыча на дальнем побережье: пропустите его.",
}
