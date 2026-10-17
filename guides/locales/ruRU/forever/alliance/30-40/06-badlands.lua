-- Russian (ruRU): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Вернитесь на запад к дороге и идите по ней на юг из зоны {zone:1432} через перевал в зону {zone:1418}. {npc:2910} и {npc:2860} стоят лагерем бок о бок у раскопок.",

	-- Step 2: Shadowforge camp
	["Shadowforge camp"] = "Лагерь Тенегорна",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Дворфы Тенегорна стоят лагерем чуть севернее раскопок; смятая карта лежит среди их палаток. Кирка Ржанца – у проходчиков и темнопрядов. По склонам вокруг бродят скальные койоты.",

	-- Step 3: The excavation crate
	["The excavation crate"] = "Ящик с раскопок",
	["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Езжайте на северо-восток к заброшенным раскопкам; ящик с припасами лежит там среди огров из клана Гнилобрюхов.",

	-- Step 4: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "Следующее поручение Ржанца ведет сюда: {area:1517}. Пропустите его.",

	-- Step 5: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} и {npc:2817} стоят лагерем вместе ({area:1877}), в центре зоны {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Моллюски – на северо-западном побережье Тернистой долины, в следующем гайде: сохраните задание",

	-- Step 6: Ogres and buzzards
	["Ogres and buzzards"] = "Огры и канюки",
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Огры из клана Гнилобрюхов стоят лагерем чуть южнее долины; лом падает с любого из них. Над равниной к востоку кружат канюки.",

	-- Step 7: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "Разбитый скелет лежит чуть восточнее огров, на краю лагеря троггов из племени Каменного Свода; хлопья падают с костегрызов и шаманов вокруг. Тельдарин сидит у разрушенного лагеря дальше к югу.",
	-- {zone:1418} Badlands
	["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "Следующее задание скелета, «Мурдалок», подождет до более позднего гайда по зоне {zone:1418} на 43-м уровне.",

	-- Step 8: Valley of Fangs
	-- {npc:4454} Fizzle Brassbolts · {area:439} Shimmering Flats · {zone:1446} Tanaris
	["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "для NPC {npc:4454} ({area:439}): гайд по зоне {zone:1446} проходит там на 45-м уровне, сохраните задание",

	-- Step 9: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Езжайте на запад. Цель: {area:1878}; в ее центре у своих машин работает {npc:2921}.",

	-- Step 10: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Младшие каменные элементали",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Младшие каменные элементали бродят здесь: {area:1878}, к западу от {npc:2921}.",

	-- Step 12: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Каменные элементали",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Каменные элементали бродят к юго-востоку от {npc:2921}; на равнине к западу от них – гигантские канюки и старые скальные койоты.",

	-- Step 14: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "Большие каменные элементали",
	-- {area:342} Camp Boff
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental · Dustbelcher Wyrmhunters = {npc:2716} Dustbelcher Wyrmhunter
	["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Большие каменные элементали (42-й уровень) ходят в дальнем юго-западном углу, под местом {area:342}; выманивайте по одному. Лом падает и с охотников на драконов и извергов из клана Гнилобрюхов ({area:342}).",

	-- Step 15: Lotwil Veriatus
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, рядом с {npc:2921}",
	-- {item:2868} Patterned Bronze Bracers
	["only if you carry {item:2868} (a blacksmith's craft)"] = "только если у вас есть {item:2868} (изделие кузнеца)",
	-- {npc:2921} Lotwil Veriatus
	["{npc:2921}'s next test needs crafted gear: skip it."] = "Для следующего испытания {npc:2921} нужно изготовленное снаряжение: пропустите его.",

	-- Step 16: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Езжайте на северо-восток к руинам дворфов на севере зоны {zone:1418}; сундук стоит среди дворфов Тенегорна. {npc:2745} поблизости – элита: держитесь от него подальше.",

	-- Step 18: Theldurin the Lost
	-- {area:345} Agmond's End
	["Ride south to {area:345}."] = "Езжайте на юг. Цель: {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "для NPC {npc:2786} ({zone:1455}): сохраните задание",

	-- Step 19: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn"] = "{npc:1470}, в таверне",

	-- Step 20: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "Сядьте на корабль до острова Терамор у дальнего причала.",

	-- Step 21: Theramore
	["Theramore"] = "Остров Терамор",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Распорядитель полетов стоит у ворот ({area:514}); {npc:5083} и {npc:4964} – внутри цитадели.",
	["for the Dustwallow loop in the next guide"] = "для круга по Пылевым топям в следующем гайде",

	-- Step 23: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Идите по дороге на запад через север зоны {zone:1443} к руинам ({area:2405}). Там на холме, по пути к обломкам корабля, стоит башня {npc:11863}.",

	-- Step 24: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "Сундук с разбитого корабля лежит на берегу чуть западнее башни {npc:11863}.",

	-- Step 25: Lord Kragaru
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, вождь кентавров, стоит лагерем на северо-западном побережье, к северу от башни {npc:11863}.",

	-- Step 27: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {item:6245} Karnitol's Satchel
	["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "Следующее задание {npc:5638}, {item:6245}, – добыча на дальнем побережье: пропустите его.",

	-- Step 28: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Идите по дороге на юг. Цель: {area:2407}.",

	-- Step 29: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} стоит на краю места {area:596}, к юго-западу (ориентир: {area:2407}); {object:176751} лежат среди скелетов. По кладбищу ползает {npc:217590}: поймайте одного с помощью набора начинающего энтомолога и отметьте цель.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: поймайте для задания «Мои маленькие друзья»",

	-- Step 30: Maraudine centaurs
	["Maraudine centaurs"] = "Кентавры из племени Мародин",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Кентавры из племени Мародин занимают {area:607} к западу от кладбища; тотемы падают со всех.",

	-- Step 31: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} держат в лагере кентавров к западу от кладбища. Освободите ее и защищайте по пути наружу; она остановится у кладбища.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "сопроводите {npc:12277} обратно к кладбищу",

	-- Step 33: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:606} Gelkis Village · {area:602} Mannoroc Coven · {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "Караван (это {npc:11626}) останавливается на дороге к востоку (ориентир: {area:606}). Возьмите задание и идите с кодо мимо места {area:602}, убивая нападающих демонов; потом поговорите со {npc:11596} в его лагере к востоку (ориентир: {area:596}).",

	-- Step 34: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Демоны собираются здесь: {area:602}, юг зоны {zone:1443}: гончие Скверны (пожиратели маны, охотники на магов и охотники за магией), девы и сестры Пустоты, а вокруг ямы – капитаны тюремщиков судеб.",

	-- Step 35: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Опустошители-отрекшиеся бродят по костяным полям к югу от деревни племени Маграм, к востоку от Ковена; на дальнем юго-востоке используйте {item:15848}, чтобы приманить призраков из племени Маграм.",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Идите по дороге на север. Цель: {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "для NPC {npc:5637} ({zone:1455}): сохраните задание",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "для NPC {npc:3980} ({area:271}): сохраните задание",

	-- Step 39: Fly to Theramore
	["Fly to Theramore"] = "Лететь на остров Терамор",
	["The next guide starts in Theramore."] = "Следующий гайд начинается на острове Терамор.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Идите по дороге на запад через север зоны {zone:1443} к руинам ({area:2405}); сундук с разбитого корабля лежит на берегу чуть западнее.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "Башня {npc:11863} стоит на холме к востоку от обломков корабля.",
}
