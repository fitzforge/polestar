-- Russian (ruRU): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Распорядитель полетов: {area:2408}",

	-- Step 2: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "",

	-- Step 3: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	["Train while you are in the city."] = "",

	-- Step 6: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Летите: {area:392}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["{area:35} first: the goblins' boat sails there from {area:392}, and every {area:35} quest is for the north of the vale, which you then walk up into."] = "Сначала {area:35}: туда ходит корабль гоблинов из места {area:392}, а все задания из места {area:35} ведут на север долины, куда вы затем подниметесь пешком.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 7: Ratchet
	-- {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["{npc:3391} waits upstairs in the house by the flight master; {quest:1111} stands on the docks, beside the boat."] = "{npc:3391} ждет на втором этаже дома у распорядителя полетов; {quest:1111} стоит на причале, рядом с кораблем.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, на втором этаже",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631} in {area:35}, where the boat goes"] = "{npc:3391}: для NPC {npc:4631} в месте {area:35}, куда идет корабль",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "{quest:1111}, на причале",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "Детали Шестерень надо вернуть Кравелу в место {area:439}, это не по маршруту: оставьте их.",

	-- Step 8: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Корабль: {area:35}",

	-- Step 9: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil · {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:2858} Gringer
	["{npc:4631} stands on the pier where the boat docks. {npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs, {npc:2858} the flight master on the upper deck."] = "{npc:4631} стоит на пирсе, где причаливает корабль. Лавка NPC {npc:2495} — в здании к востоку от таверны; {npc:2498} на нижнем этаже таверны, {npc:2496}, {npc:737} и {npc:773} — наверху, {npc:2858}, распорядитель полетов, — на верхней палубе.",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the pier"] = "{npc:4631}, на пирсе",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, on the bottom floor"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs"] = "{npc:2496}, на втором этаже",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",

	-- Step 10: Grom'gol
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	["Leave {area:35} through the tunnel and follow the road north to {object:3202}, the orc camp on the west side of the vale. Stay on the road: the jungle beside it is above your level."] = "Покиньте {area:35} через туннель и идите по дороге на север к месту {object:3202} — лагерю орков на западной стороне долины. Не сходите с дороги: джунгли рядом выше вашего уровня.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: для Нагорья Арати, позже по маршруту",

	-- Step 11: Nesingwary's camp
	["Nesingwary's camp"] = "Лагерь Эрнестуэя",
	-- {object:3202} Grom'gol · {npc:773} Krazek · {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. {npc:773} wants it investigated: walk among its tents. From here on, keep every page of The {item:2755} you loot: {npc:716} takes them on your next Stranglethorn visit."] = "Идите по дороге на север из места {object:3202}; охотничий лагерь Эрнестуэя – на холме к северо-востоку от реки. {npc:773} просит его осмотреть: пройдите между палатками. С этого момента сохраняйте каждую страницу из книги «{item:2755}»: {npc:716} примет их при следующем посещении Тернистой долины.",

	-- Step 12: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk · Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["River Crocolisks lie along the river below the camp. Young Stranglethorn Tigers prowl west of the camp, Young Panthers east of it. Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it. Careful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "Речные кроколиски лежат вдоль реки ниже лагеря. Молодые тигры Тернистой долины бродят к западу от лагеря, молодые пантеры — к востоку. Идите на запад мимо лагеря. Ящеры Тернистой долины (33-34) охотятся на полянах, а тролли Кровавого Скальпа занимают руины на побережье: с любого из них может выпасть клык. {item:4614} выпадает с них очень редко: если выпадет, прочтите. Осторожно: в лагерях троллей много патрулей, поэтому к бою часто присоединяются другие тролли.",

	-- Step 14: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Venture Co. Agents = {npc:260429} Venture Co. Agent
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists (34-36), who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: Venture Co. Agents (39) stand among the geologists in the western camps by the Venture Co. house: work the eastern camps, away from them."] = "Тигры Тернистой долины (32) бродят по холмам вокруг лагеря и к югу от него, пантеры (32) – по полянам к западу и юго-западу. Геологи Торговой компании (34-36), у которых упавшие кристаллы, работают в лагерях у места {area:37}, к юго-востоку от лагеря. Осторожно: агенты Торговой компании (39) стоят среди геологов в западных лагерях у дома Торговой компании: работайте в восточных лагерях, подальше от них.",
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["Tumbled Crystals, from the geologists of the eastern camps"] = "Упавшие кристаллы – с геологов восточных лагерей",

	-- Step 15: Nesingwary's camp
	-- {object:3202} Grom'gol
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "Тенебрюхие пантеры будут гораздо позже, у объекта {object:3202}",

	-- Step 16: Elder Stranglethorn Tigers
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["Elder Stranglethorn Tigers"] = "",
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp. Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 17: Nesingwary's camp
	["Back north to the camp."] = "Обратно на север к лагерю.",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}: {npc:729} (37) waits for your next Nesingwary stop, at about 40 in forever/horde/40-50/01-stranglethorn-vale"] = "{npc:717}: {npc:729} (37) ждет следующего визита к Несингвэри, примерно на 40-м уровне в forever/horde/40-50/01-stranglethorn-vale",

	-- Step 18: Thoroughly Scavenged Supplies
	-- {object:661516} Thoroughly Scavenged Supplies (no name in this language: may be words) · {quest:97328} Anything of Value · {area:102} Ruins of Zul'Kunda
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["On the walk west from Nesingwary's camp, a pile of {object:661516} lies by the path: it starts {quest:97328}, whose Stolen Shipments lie in the {area:102} on the coast ahead."] = "По пути на запад от лагеря Несингвэри у тропы лежат тщательно обысканные припасы ({object:661516}): они начинают задание {quest:97328}, а украденные грузы лежат впереди на побережье: {area:102}.",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\nLeave {npc:729}, the level 37 tiger on the hilltop south-west of the camp, for now: he is two over you here, and the 40-50 Stranglethorn guide comes back to him.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "К западу за лагерем на скалах сидят хрустальные василиски (34-35); любой тролль Кровавого Скальпа в деревне дальше может уронить ухо.\n{npc:729}, тигра 37-го уровня на вершине холма к юго-западу от лагеря, пока не трогайте: он на два уровня выше вас, а гайд по Тернистой долине 40-50 вернется к нему.\nОсторожно: в гнезде ящеров есть детеныши, которые вступают в бой, когда вы нападаете на взрослых.",

	-- Step 20: Zimmix Sputterspark
	-- {npc:268992} Zimmix Sputterspark · {area:102} Ruins of Zul'Kunda · {item:277957} Primitive Key · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Scouts = {npc:588} Bloodscalp Scout · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["{npc:268992} is held at the east edge of the {area:102}; the Stolen Shipments lie among the ruins around him. The Bloodscalp Scouts, Hunters and Mystics (34-35) there carry his {item:277957}. Then lead him out of the ruins: {npc:4631} in {area:35} takes the news and the shipments.\nCareful: Bloodscalp Berserkers and Headhunters (36-37) and Witch Doctors (37, casters) hold the ruins north and west of {npc:268992}, close to the northern shipments (around 24.9,9.6): pick the shipments in the southern ruins by {npc:268992} first, and pull one at a time if you go north."] = "{npc:268992} в плену у восточного края места {area:102}; украденные грузы лежат среди руин вокруг него. Разведчики, охотники и мистики из племени Кровавого Скальпа (34-35) носят его {item:277957}. Затем выведите его из руин: {npc:4631} ({area:35}) примет новости и грузы.\nОсторожно: берсерки и охотники за головами из племени Кровавого Скальпа (36-37) и знахари (37, заклинатели) занимают руины к северу и западу от NPC {npc:268992}, рядом с северными грузами (около 24.9,9.6): сначала соберите грузы в южных руинах рядом с NPC {npc:268992}, а если пойдете на север, выманивайте по одному.",
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["Stolen Shipments, in the ruins"] = "Украденные грузы – в руинах",
	-- {item:277957} Primitive Key
	-- plural, as words: Bloodscalp Scouts = {npc:588} Bloodscalp Scout
	["{item:277957}, from the Bloodscalp Scouts, Hunters and Mystics"] = "{item:277957} – с разведчиков, охотников и мистиков из племени Кровавого Скальпа",
	-- {npc:268992} Zimmix Sputterspark
	["Escort {npc:268992} out of the ruins and keep him alive: Lozgil takes the news once he is safe."] = "Выведите NPC {npc:268992} из руин и сохраните ему жизнь: Подгребай примет новости, когда он будет в безопасности.",

	-- Step 22: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "",
	-- {object:3202} Grom'gol · {npc:2464} Commander Aggro'gosh
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor · Carnivorous Weeds = {npc:269175} Carnivorous Weed
	["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}. Careful: the 36s can be two over you: pull them one at a time. Carnivorous Weeds (36-38) are rooted in the jungle south of the raptors: walk around them."] = "На обратном пути на юг ({object:3202}) в джунглях между лагерем и местом {object:3202} охотятся ящеры-кнутохвосты (35-36): они засчитываются и для Хемета, и для NPC {npc:2464}. Осторожно: 36-е могут быть на два уровня выше вас – выманивайте по одному. Хищные сорняки (36-38) растут в джунглях к югу от ящеров: обходите их.",

	-- Step 23: Grom'gol
	-- {npc:2464} Commander Aggro'gosh · {object:3202} Grom'gol · {npc:2497} Nimboya · {npc:2465} Far Seer Mok'thardin
	["{npc:2464} stands in the middle of {object:3202}, {npc:2497} near the zeppelin tower, {npc:2465} beside the flight master."] = "{npc:2464} стоит в центре места {object:3202}, {npc:2497} — у башни дирижаблей, {npc:2465} — рядом с распорядителем полетов.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: the Shadowmaw claws and the tigress fang come at the end of this guide"] = "",

	-- Step 24: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Летите: {area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 25: Booty Bay
	-- {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:4631} Wharfmaster Lozgil
	["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master. {npc:4631} stands on the pier."] = "Лавка NPC {npc:2495} – в здании к востоку от таверны; {npc:2498} на нижнем этаже таверны, {npc:2496}, {npc:737} и {npc:773} – наверху, рядом с распорядителем полетов. {npc:4631} стоит на пристани.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:4631} Wharfmaster Lozgil
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["{npc:4631}, on the pier: the Stolen Shipments"] = "{npc:4631}, на пирсе: украденные грузы",
	-- {npc:4631} Wharfmaster Lozgil · {npc:268992} Zimmix Sputterspark
	["{npc:4631}: {npc:268992} is safe"] = "{npc:4631}: {npc:268992} в безопасности",

	-- Step 26: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "Летите: {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 27: Level 35
	["Level 35"] = "",
	-- {quest:629} The Vile Reef · {area:35} Booty Bay · {object:3202} Grom'gol
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter · Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["{quest:629}'s and Zul'Kunda's quests are next, with Bloodscalp Headhunters of 36-37. Still below 35 after {area:35}'s hand-ins? The Elder Stranglethorn Tigers (34-35) roam the hills north of {object:3202}, below Nesingwary's camp: kill them until level 35. The Lashtail Raptors (35-36) beside them are a level higher."] = "Далее задания «{quest:629}» и задания Зул'Кунды, с охотниками за головами из племени Кровавого Скальпа 36-37 уровня. Все еще ниже 35 после сдачи заданий в месте {area:35}? Старые тигры Тернистой долины (34-35) бродят по холмам к северу от места {object:3202}, ниже лагеря Эрнестуэя: убивайте их до 35 уровня. Ящеры-кнутохвосты (35-36) рядом с ними на уровень выше.",
	-- {npc:1085} Elder Stranglethorn Tiger
	["grind on {npc:1085}"] = "",

	-- Step 28: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "К северо-западу от Лагеря Гром'гол под водой у побережья лежит {area:104}. {item:4094} лежит на морском дне у затонувших руин; следите за дыханием и мурлоками.",
	["Underwater"] = "Под водой",

	-- Step 29: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "",
	-- {item:3915} Bloody Bone Necklace · {item:2755} Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads. Careful: the 37s can be two over you: pull them one at a time from the village's edge, never into the middle with the Witch Doctors.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of The {item:2755}."] = "Сушеные головы носят охотники за головами из племени Кровавого Скальпа (36-37) в деревне на побережье. Осторожно: 37-е могут быть на два уровня выше вас: выманивайте их по одному с края деревни, никогда не лезьте в центр к знахарям.\nТролли Кровавого Скальпа занимают руины на побережье к северу от рифа и деревню за ними; с любого может выпасть {item:3915}. Продолжайте собирать страницы из книги «{item:2755}».",

	-- Step 31: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them; the 38s can be two over you: pull them one at a time and leave the Elders alone."] = "К востоку от холмов Мош'Огг тенебрюхие пантеры (37-38) крадутся по джунглям в сторону озера; там же бродят тигрицы Тернистой долины, с которых иногда падает безупречный клык. Кроколиски-хрустогрызы лежат вдоль реки сразу к западу от джунглей; сохраняйте их шкуры для NPC {npc:2495}. Осторожно: тенебрюхие пантеры (37-38 уровня) и старые тенебрюхие пантеры (42-43 уровня) вне боя используют Незаметность, поэтому не видны, пока вы не подойдете близко; 38-е могут быть на два уровня выше вас: выманивайте их по одному, а старых не трогайте.",

	-- Step 32: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Лагерь Мош'Огг",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time. Careful: the 37s can be two over you: take them from the camp's western edge, never two together."] = "Огры из клана Мош'Огг стоят лагерем на холмах чуть восточнее места {object:3202}, по пути назад. Убейте 10 громил и 5 знахарей (36-37); выманивайте по одному. Осторожно: 37-е могут быть на два уровня выше вас: атакуйте с западного края лагеря, никогда не берите двоих сразу.",

	-- Step 33: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "Вернитесь: {object:3202}.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "Следующий гайд садится на дирижабль в город {zone:1454} у башни на западной стороне лагеря.",

	-- Step 34: Level 36
	["Level 36"] = "",
	-- {object:3202} Grom'gol
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Snapjaw Crocolisks (35-36) line the river just east of the camp, below the Mosh'Ogg hills: kill them until level 36, then walk back to the zeppelin tower. Leave the Mosh'Ogg ogres (36-37) above them alone."] = "Задания Пылевых топей 35-38 уровня. Все еще ниже 36 после сдачи заданий в месте {object:3202}? Кроколиски-хрустогрызы (35-36) лежат вдоль реки сразу к востоку от лагеря, ниже холмов Мош'Огг: убивайте их до 36 уровня, затем возвращайтесь к башне дирижаблей. Огров Мош'Огг (36-37) над ними не трогайте.",
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Кроколиски-хрустогрызы",
	-- {npc:1152} Snapjaw Crocolisk
	["grind on {npc:1152}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Elder tigers and Lashtail raptors"] = "Старые тигры и ящеры-кнутохвосты",
	-- ["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Идите по дороге на север из места {object:3202}; охотничий лагерь Эрнестуэя — на холме к северо-востоку от реки. С этого момента сохраняйте каждую страницу из книги «{quest:338}»: позже их попросит {npc:716}.",
	-- ["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Идите по дороге на юг к месту {area:35} на южной оконечности долины и войдите через туннель в скалах. Не сходите с дороги: джунгли рядом намного выше вашего уровня. {npc:2858}, распорядитель полетов Орды, ждет на верхней палубе.",
	-- ["Green Hills pages"] = "Страницы «Зеленых холмов»",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "Страницы книги «{item:2755}» падают с шансом около 1% каждая с троллей из племен Кровавого Скальпа и Дробителей Черепов; сохраняйте каждую найденную страницу, а остальные поищите на аукционе. {npc:716} принимает главы позже в этом гайде.",
	-- ["Shadowmaw panthers"] = "Тенебрюхие пантеры",
	-- ["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Ящеры-кнутохвосты (35-36) охотятся в джунглях чуть северо-восточнее места {object:3202}.",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time."] = "Огры из клана Мош'Огг стоят лагерем на холмах чуть восточнее места {object:3202}, по пути назад. Убейте 10 громил и 5 знахарей (36-37); выманивайте по одному.",
	-- ["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "Тенебрюхие пантеры (37-38) крадутся по джунглям к востоку от холмов Мош'Огг и на северо-восток к озеру; они нападают из невидимости. Собирайте по пути каждую страницу «Зеленых холмов».",
	-- ["The camp by the river"] = "Лагерь у реки",
	-- ["Venture Co. camp"] = "Лагерь Торговой компании",
	-- ["Zeppelin to {object:3202}"] = "Дирижабль: {object:3202}",
	-- ["from {npc:4723}"] = "с NPC {npc:4723}",
	-- ["{item:5852}, in {object:20691}"] = "{item:5852}, в объекте {object:20691}",
	-- ["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master."] = "Лавка NPC {npc:2495} — в здании к востоку от таверны; {npc:2498} на нижнем этаже таверны, {npc:2496}, {npc:737} и {npc:773} — наверху, рядом с распорядителем полетов.",
	-- ["{npc:2496}: Cozzle's footlocker is at {area:37}, later in this guide"] = "{npc:2496}: сундучок Козла находится у места {area:37}, позже в этом гайде",
	-- ["{npc:2496}: for Pozzik at the {area:2240}, on the way to {zone:1446} around level 43"] = "{npc:2496}: для Поззика на месте {area:2240}, по пути в {zone:1446} примерно на 43-м уровне",
	-- ["{npc:4723} (38) is inside the Venture Co. house on {area:37}'s west shore, among the geologists: his key opens {object:20691} in the same house, which holds the blueprints for {npc:2496}. Careful: Venture Co. Agents (39) stand in and around the house: clear the doorway before you go in."] = "{npc:4723} (38) находится в доме Торговой компании на западном берегу места {area:37}, среди геологов: его ключ открывает {object:20691} в том же доме, где лежат чертежи для NPC {npc:2496}. Осторожно: агенты Торговой компании (39) стоят в доме и вокруг него: расчистите вход, прежде чем войти.",
	-- ["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "Лагерь пропавших охотников ({npc:773}) — это лагерь Эрнестуэя: пройдите между палатками, и расследование завершится. Речные кроколиски лежат вдоль реки ниже лагеря.",
}
