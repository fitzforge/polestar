-- Russian (ruRU): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Летите сюда: {area:42}",
	-- {area:35} Booty Bay
	["Gyll, {area:35}"] = "Гилл, {area:35}",

	-- Step 2: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:217412} Amaryllis Webb
	["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "Из места {area:42} идите по дороге на восток через {zone:1430} в зону {zone:1435}; Биггс охраняет развилку сразу за границей. {npc:217412} стоит чуть севернее него.",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: три зверька, которых нужно поймать в Нагорье Арати, Пустошах ({zone:1443}) и Тернистой долине",

	-- Step 3: The western swamp
	["The western swamp"] = "Западная часть болота",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Молодые кроколиски, ткачи скорби и болотные ягуары бродят по болоту вокруг дороги.",

	-- Step 5: The Lost Caravan
	["The wrecked caravan lies off the road near Biggs."] = "Разбитый караван лежит в стороне от дороги рядом с Биггсом.",

	-- Step 7: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "Идите по дороге на север к дренеям {area:657}.",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "На восток по дороге сюда: {area:76}. Кристаллы падают с противников {npc:256028}; Нобору бродит по руинам и оставляет свою дубину.",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391} заперт в клетке в северной части святилища. Освободите его и не дайте ему погибнуть по пути наружу; затем его сундук будет ждать у дороги.",

	-- Step 11: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Летите сюда: {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "Обратно на запад через {zone:1430} сюда: {area:42}.",

	-- Step 12: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, дорога к месту {area:17203}",
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, Собор Света",
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, королевская библиотека в крепости",

	-- Step 13: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} ждет в подвале здания {object:2164} ({object:2101}). Используйте {item:6913} у круга призыва и победите призванного суккуба. Если вы взяли задание {quest:65602}, отдайте ему еще и {item:190309}, поставьте ее у того же круга и победите инкуба.",
	["Subdue the succubus"] = "Подчините суккуба",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, если вы его взяли",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, у того же круга",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} привязывает инкуба к вам",

	-- Step 14: Shaman training
	["Shaman training"] = "Обучение шамана",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {npc:1573} Gryth Thurden · {object:32372} Great Forge · {area:271} Southshore
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "В городе {zone:1453} нет учителя шаманов: сядьте на поезд ({area:2257}) в месте {object:28027} до города {zone:1455} и обучитесь у NPC {npc:258098}. {npc:1573} ({object:32372}) тоже летает сюда: {area:271}.",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Летите сюда: {area:271}",

	-- Step 17: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "{npc:2434} незаметно прячется на окраине места {area:271}; убейте его и прочитайте контракт, который он несет.",

	-- Step 18: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Идите по дороге на восток из места {area:287} через {area:1057} сюда: {area:320}.",

	-- Step 19: Northfold Manor
	-- {area:320} Refuge Pointe · {npc:217589} Hay Weevil · {npc:217412} Amaryllis Webb
	["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "Синдикат удерживает ферму к северо-западу от места {area:320}. По ферме ползает {npc:217589}: поймайте одного с помощью набора энтомолога от NPC {npc:217412}, затем отметьте его.",
	-- {npc:217589} Hay Weevil · {quest:93176} My Little Friends
	["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: поймайте для задания {quest:93176}",

	-- Step 21: Thandol Span
	-- {area:205} Dun Modr · {zone:1437} Wetlands · {npc:1075} Rhag Garmason
	["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Идите по дороге на юг через мост сюда: {area:205} ({zone:1437}), где ждет {npc:1075}.",

	-- Step 22: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Эбенезер Ржавый Засов",
	["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Вернитесь на мост: Эбенезер лежит под ним со стороны Нагорья Арати.",

	-- Step 23: Faldir's Cove
	["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "На запад вдоль побережья к бухте гоблинов; Дозорный Лоло следит за ней со скал.",

	-- Step 24: Phizzlethorpe
	["Phizzlethorpe"] = "Физзлторп",
	["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Проводите профессора на пляж к северу от бухты и охраняйте его, пока он работает; наги нападают волнами.",

	-- Step 26: The wrecks
	["The wrecks"] = "Обломки кораблей",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Два затонувших корабля лежат в заливе к западу от бухты. Карты и журналы внутри них; самоцветы лежат на морском дне вокруг. Наги из клана Пронзающего Гребня плавают по всему заливу.",

	-- Step 27: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Для NPC {npc:2487} ({area:35}): сохраните",

	-- Step 28: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Скачите обратно на северо-восток мимо места {area:320}; {npc:2712} и {npc:2713} стоят лагерем на холмах к северу от места {area:314}.",

	-- Step 29: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "Курьер идет по дороге к западу от места {area:314} с двумя стражами; выманите их с дороги.",

	-- Step 30: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} и {npc:2713}",

	-- Step 31: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "Поручение: {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Держитесь рядом с NPC {npc:2713}, пока она пробирается сюда: {area:314} и обратно; по пути на вас нападут орки Орды.",

	-- Step 32: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Для NPC {npc:2711} ({area:271})",

	-- Step 33: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Идите на север мимо места {area:314}; осколки сверкают на холме у места {area:333}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Только если Барабуль дал вам подвеску в Тернистой долине",

	-- Step 34: Drywhisker Gorge
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Кобольды из племени Сухоусов копают в ущелье к востоку от места {area:321} (Орда); обойдите город с севера. С них падают и частицы, и руда для Кразека.",

	-- Step 35: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Радужные осколки лежат в дальнем конце места {area:318}.",

	-- Step 36: Witherbark Village
	-- {area:314} Go'Shek Farm
	["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Тролли из племени Сухокожих живут на холмах к югу от места {area:314}; знахари стоят в деревне, темные охотники охраняют дальний конец долины.",

	-- Step 37: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Каждый ключ лежит у одного из кругов стоячих камней нагорья: к востоку от осколков, у места {area:320} и на западе. {object:2702} стоит к западу от места {area:320}.",

	-- Step 39: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, огр-маг, удерживает пещеру в южном конце долины Сухокожих.",

	-- Step 41: Alterac Mountains
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Идите по дороге на север из места {area:271} в горы. По склонам бродят горные львы; члены Синдиката в месте {area:280} носят перстни-печатки, а {npc:2306} ходит по территории поместья в северной части городка.",

	-- Step 42: Crushridge ogres
	["Crushridge ogres"] = "Огры из клана Раздробленного Хребта",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Огры из клана Раздробленного Хребта удерживают холмы к северу от места {area:280}. Дальше на север в потертом деревянном сундуке лежит {item:3706}; {npc:2320} ({quest:537}) стоит прямо рядом.",

	-- Step 43: Ruins of Alterac
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Фолианты лежат в разрушенной крепости к западу от места {area:280}; руины удерживают темные маги Недремлющего Аргуса.",

	-- Step 44: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "На юго-запад к лагерю Кирин-Тора на берегу озера к западу от места {area:279}, сразу за границей зоны {zone:1421}: там стоит {npc:269127}. Верховный маг Ансарем стоит к юго-востоку от него, у купола.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Для NPC {npc:2542} ({area:35}): сохраните",
	-- {npc:252085} Archmage Celindra
	["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, в городе Даларан",

	-- Step 45: Southshore
	-- {item:2321} Fine Thread · {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance
	["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} для плаща {npc:2438}, у NPC {npc:2381}, если у вас ее нет",
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Для NPC {npc:1440} ({zone:1453}): сохраните",

	-- Step 47: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "Из города {zone:1455} идите через туннель на восток через зону {zone:1426} в зону {zone:1432} и по дороге сюда: {area:144}.",

	-- Step 48: Ironband's Excavation Site
	["South-east along the loch to the dig site."] = "На юго-восток вдоль озера к раскопкам.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north to the draenei of the {area:657}."] = "Идите по дороге на север к дренеям ({area:657}).",
	-- ["Summon Succubus"] = "Призыв суккуба",
}
