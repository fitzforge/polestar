-- Russian (ruRU): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Перевал из Ун'Горо выходит сюда: {area:3077} – кладбище на северо-востоке края {zone:1451}. {npc:13220} стоит среди могил.",

	-- Step 2: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Езжайте на юго-запад к руинам ({area:2738}). {object:179565} для персонажа {npc:11801} – в одном из разрушенных домов.",

	-- Step 4: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Вернитесь в Южный Ветер и поднимитесь на башню. Если потревожить улей наверху, вылезут душители из улья Аши; у одного из них – {item:17346}.",

	-- Step 5: Cenarion Hold
	["Ride west to the walled hold in the middle of the desert."] = "Езжайте на запад к обнесенной стеной крепости в центре пустыни.",

	-- Step 6: Dredge and scorpids
	["Dredge and scorpids"] = "Землечерпы и скорпиды",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Землечерпы, камнехвостые скорпиды и песчаные пауки-быстроноги бродят по пескам чуть к северу от крепости.",

	-- Step 7: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Светящиеся осколки табличек лежат вокруг лагеря Сумеречного Молота на дальнем северо-западе; они падают и с пылевихрей и пустынных грохотунов.",

	-- Step 9: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Езжайте на юго-восток сюда: {area:3447}, под скалами Ун'Горо.",

	-- Step 10: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Езжайте на запад к лагерю Орды к северу от места {area:2744}.",

	-- Step 11: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Гейзеры силитиста извергаются по всей южной пустыне. Войдите в оставленный гейзером силитист и отнесите его к экстрактору Орды в лагере Кирики; в бою или верхом вы его теряете.",

	-- Step 12: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Живодеры и скальные пауки-скакуны",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Камнехвостые живодеры и скальные пауки-скакуны бродят по дюнам к юго-западу от лагеря Кирики.",

	-- Step 13: Twilight Vanguard
	["Twilight Vanguard"] = "Авангард Сумеречного Молота",
	-- {npc:11803} Twilight Keeper Exeter · {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} бродит по лагерю авангарда на дальнем юго-западе. С каждого культиста падают зашифрованные сумеречные тексты ({item:20404}), с заданием или без: соберите двадцать – десять для персонажа {npc:15306} и десять для Ортелла.",

	-- Step 14: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Земляные сокрушители и клешневики",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Двигайтесь на север вдоль западных дюн; земляные сокрушители и камнехвостые клешневики встречаются отсюда до крепости.",

	-- Step 15: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} занимает лагерь на западе.",

	-- Step 16: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} стоит на заставе к западу от места {area:3425}. Доберите зашифрованные сумеречные тексты ({item:20404}) до двадцати с культистов здесь.",

	-- Step 17: Cenarion Hold
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, в западной части крепости",

	-- Step 18: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "Сумка лежит в горах на дальнем юге, за Лагерем Бронзоборода. Рядом патрулирует Смертехват, элитный скорпид: хватайте сумку, пока его нет.",

	-- Step 19: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Езжайте на северо-восток сюда: {area:3447}.",
	["The spare texts from the cultists"] = "Лишние тексты с культистов",

	-- Step 20: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Назад: {area:3425}",
	-- {area:2744} Hive'Regal
	["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Задание Мар'алита о Наталии требует 58-го уровня и ведет сюда: {area:2744}, к элите. Пропустите.",

	-- Step 21: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Езжайте на северо-восток сюда: {area:3077}; из края {zone:1451} вы уйдете через перевал рядом.",

	-- Step 22: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:8737} Linken · {npc:9117} J.D. Collie
	["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Через перевал и на восток вдоль северных скал сюда: {area:541}. {npc:8737} стоит у пещеры; {npc:9117} – внутри.",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "Используйте игрушку {npc:10980} на персонаже {npc:10977}",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Сохраните задание {quest:3942}: {npc:9116} – здесь: {area:2479}, по пути следующего руководства через край {zone:1448}.",

	-- Step 23: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Летите сюда: {area:976}. {object:142071} стоит в центре города.",

	-- Step 24: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} and train."] = "Летите сюда: {area:1637} и обучитесь.",

	-- Step 25: The Undercity
	-- {area:1637} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {object:36126} Royal Quarter
	["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Садитесь на дирижабль с башни у города {area:1637} в край {zone:1420} и езжайте в город {zone:1458}. Леди Сильвана – здесь: {object:36126}.",

	-- Step 26: The Bulwark
	-- {area:152} The Bulwark
	["Ride east along the road to the {area:152} on the border."] = "Езжайте на восток по дороге к {area:152} на границе.",

	-- Step 27: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "Ферма ({npc:10778}) – первая к востоку от {area:152}. У болтливых вурдалаков на ферме – вторая половина ее талисмана; {npc:11075} охраняет котел в поле.",

	-- Step 28: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Сторожевые башни и силосы Андорала",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Езжайте на юг в Андорал. {npc:10667} ждет в разрушенной таверне в западной части города. Встаньте в дверях каждой из четырех башен с предметом {item:12815}, чтобы отметить ее; держитесь окраин города. Используйте предмет {item:12627} у силосов в центре города, чтобы выманить временных паразитов.",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10904}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10903}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10902}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Отметьте предметом {item:12815}: {npc:10905}",

	-- Step 29: The Bulwark
	-- {item:14619} Skeletal Fragments · {quest:838} Scholomance
	["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Дитерс предлагает {item:14619} ({quest:838}). Пропустите.",

	-- Step 30: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "На восток по дороге: {npc:11077} охраняет котел ({area:200}).",

	-- Step 31: Northridge Lumber Camp
	["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "На север к лесопилке; поставьте бочку с термитами в центре лесопилки.",

	-- Step 32: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "Либрам лежит дальше к северу, по пути к месту {area:190}.",

	-- Step 33: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Езжайте на восток к хижине {npc:1855} у места {area:2619} и выслушайте его.",

	-- Step 34: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "Щит лежит здесь: {area:201}, к югу от хижины {npc:1855}.",

	-- Step 35: Light's Hope Chapel
	["Ride east across the plaguelands to the chapel."] = "Езжайте на восток через Чумные земли к часовне.",

	-- Step 36: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Воители Плети",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Воители Плети бродят здесь: {area:2270}, к северу от часовни. Проведите предметом {npc:11063} ({item:13156}) над каждым убитым: нужны черепа, которые отзываются.",

	-- Step 38: Pamela Redpath and the Undercroft
	-- {npc:10926} Pamela Redpath · {area:2261} Undercroft
	["{npc:10926} and the {area:2261}"] = "{npc:10926} и {area:2261}",
	-- {area:2262} Darrowshire · {npc:10926} Pamela Redpath · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Езжайте сюда: {area:2262}, на юго-запад; {npc:10926} играет среди домов. {npc:11886} прячется здесь: {area:2261} – склеп чуть к западу от города.",
	-- {npc:10926} Pamela Redpath
	["{npc:10926}'s own errand is not on this route. Skip it."] = "Поручение самой {npc:10926} не входит в маршрут. Пропустите.",

	-- Step 39: Nathanos Blightcaller
	-- {npc:15193} The Banshee Queen · {area:2260} Marris Stead · {area:2261} Undercroft
	["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Защитник ({npc:15193}) занимает дом на ферме ({area:2260}) к северу от места {area:2261}.",
	-- {npc:11878} Nathanos Blightcaller
	["{npc:11878}' errands are not on this route. Skip them."] = "Поручения {npc:11878} не входят в маршрут. Пропустите.",

	-- Step 40: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Езжайте на северо-запад к хижине {npc:1855}.",
	-- {npc:1855} Tirion Fordring
	["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "Следующее задание {npc:1855}, о потерянной чести, не входит в маршрут. Пропустите.",

	-- Step 41: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Езжайте на юго-запад к персонажу {npc:10667} в Андорал.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "Битва за Дарроушир ({npc:10667}) заканчивается боем с элитой. Пропустите.",

	-- Step 42: The Bulwark
	-- {area:152} The Bulwark · {zone:1458} Undercity
	["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "На запад к {area:152}. Следующее руководство начинается здесь: {zone:1458}, недалеко к западу.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride east along the road to the {area:152} on the border."] = "Езжайте на восток по дороге сюда: {area:152}, на границе.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "На запад сюда: {area:152}. Следующее руководство начинается здесь: {zone:1458}, недалеко к западу.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "Ферма ({npc:10778}) – первая к востоку от места {area:152}. У болтливых вурдалаков на ферме – вторая половина ее талисмана; {npc:11075} охраняет котел в поле.",
}
