-- Russian (ruRU): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	["Fly to Darkshire"] = "",
	-- {object:3204} Booty Bay (no name in this language: may be words)
	["{object:3204} flight master"] = "",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him."] = "",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}: три зверька, которых нужно поймать в Нагорье Арати, Пустошах ({zone:1443}) и Тернистой долине",

	-- Step 4: The western swamp
	["The western swamp"] = "Западная часть болота",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Молодые кроколиски, ткачи скорби и болотные ягуары бродят по болоту вокруг дороги.",

	-- Step 6: The Harborage
	["The Harborage"] = "",
	["Follow the road north to the draenei of the Harborage."] = "",

	-- Step 7: Fallow Sanctuary
	["Fallow Sanctuary"] = "",
	-- {npc:256028} The Lost One
	["East along the road to the Fallow Sanctuary. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "",

	-- Step 8: The Lost Caravan
	-- {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the Fallow Sanctuary, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391} заперт в клетке в северной части святилища. Освободите его и не дайте ему погибнуть по пути наружу; затем его сундук будет ждать у дороги.",

	-- Step 13: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Летите сюда: {zone:1453}",
	-- {zone:1430} Deadwind Pass
	["Back west through {zone:1430} to Darkshire."] = "",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, Darkshire"] = "",

	-- Step 14: Stormwind
	-- {npc:1141} Angus Stern
	["{npc:1141}, Stormwind Harbor road"] = "",

	-- Step 15: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} ждет в подвале здания {object:2164} ({object:2101}). Используйте {item:6913} у круга призыва и победите призванного суккуба. Если вы взяли задание {quest:65602}, отдайте ему еще и {item:190309}, поставьте ее у того же круга и победите инкуба.",
	["Subdue the succubus"] = "Подчините суккуба",
	["Summon Succubus"] = "Призыв суккуба",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, если вы его взяли",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, у того же круга",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} привязывает инкуба к вам",

	-- Step 16: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, Собор Света",

	-- Step 18: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, королевская библиотека в крепости",

	-- Step 19: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Поезд до {zone:1455}",

	-- Step 20: Fly to Southshore
	-- {quest:538} Southshore
	["Fly to {quest:538}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 22: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {quest:538} Southshore
	["A {npc:2434} lurks unseen on the edge of {quest:538}; kill him and read the contract he carries."] = "",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 25: Refuge Pointe
	-- {object:2685} Refuge Pointe (no name in this language: may be words)
	["Follow the road east out of Hillsbrad over Thoradin's Wall to {object:2685}."] = "",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "",

	-- Step 26: Northfold Manor
	-- {object:2685} Refuge Pointe (no name in this language: may be words) · {npc:217589} Hay Weevil · {npc:217412} Amaryllis Webb
	["The Syndicate hold the farm north-west of {object:2685}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "",
	-- {npc:217589} Hay Weevil · {quest:93176} My Little Friends
	["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}: поймайте для задания {quest:93176}",

	-- Step 27: Witherbark Village
	["South-east from Northfold to the Witherbark trolls in the hills south of Go'Shek Farm; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley. Every troll here can drop a tusk."] = "",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "",

	-- Step 28: Shards of Myzrael
	["Head north past Go'Shek Farm; the shards glitter on the hill by the Circle of East Binding."] = "",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Только если Барабуль дал вам подвеску в Тернистой долине",

	-- Step 29: Drywhisker Gorge: kill these as you meet them
	["Drywhisker Gorge: kill these as you meet them"] = "",
	["The Drywhisker kobolds dig in the gorge east of Hammerfall (Horde); skirt the town to the north. They drop both the motes and Krazek's ore.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "{item:4435}: с противников {npc:2572}, {npc:2573} и {npc:2574}, рядом с этой точкой",

	-- Step 30: Iridescent Shards
	["The shards lie at the far end of Drywhisker Gorge."] = "",
	["Below ground"] = "",

	-- Step 31: Stones of Binding
	-- {object:2685} Refuge Pointe (no name in this language: may be words) · {object:2702} Stone of Inner Binding
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {object:2685} and in the west. The {object:2702} stands west of {object:2685}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "",

	-- Step 32: Quae
	-- {object:2685} Refuge Pointe (no name in this language: may be words) · {npc:2712} Quae · {npc:2713} Kinelory
	["Head back north-east past {object:2685}; {npc:2712} and {npc:2713} camp in the hills north of Go'Shek Farm."] = "",

	-- Step 33: Forsaken Courier
	["The courier walks the road west of Go'Shek Farm with two guards; pull them off the road."] = "",

	-- Step 34: Circle of Outer Binding
	["Circle of Outer Binding"] = "",

	-- Step 35: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} и {npc:2713}",

	-- Step 36: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "Поручение: {npc:2713}",
	-- {npc:2713} Kinelory
	["Stay with {npc:2713} while she sneaks into Go'Shek Farm and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "",

	-- Step 37: Quae
	-- {npc:2711} Phin Odelic · {quest:538} Southshore
	["For {npc:2711} in {quest:538}"] = "",

	-- Step 38: Circle of West Binding
	["Circle of West Binding"] = "",

	-- Step 39: Faldir's Cove
	["Faldir's Cove"] = "",
	["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "",

	-- Step 40: Phizzlethorpe
	["Phizzlethorpe"] = "Физзлторп",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "",

	-- Step 42: The Drowned Reef: kill these as you meet them
	["The Drowned Reef: kill these as you meet them"] = "",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Два затонувших корабля лежат в заливе к западу от бухты. Карты и журналы внутри них; самоцветы лежат на морском дне вокруг. Наги из клана Пронзающего Гребня плавают по всему заливу.",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "",

	-- Step 43: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {object:3204} Booty Bay (no name in this language: may be words)
	["For {npc:2487} in {object:3204}: keep it"] = "",

	-- Step 45: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, огр-маг, удерживает пещеру в южном конце долины Сухокожих.",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "",

	-- Step 47: Fly to Southshore
	-- {object:2685} Refuge Pointe (no name in this language: may be words)
	["{object:2685} flight master"] = "",

	-- Step 49: Gavin's Naze
	["Gavin's Naze"] = "",
	-- {quest:538} Southshore · {npc:2306} Baron Vardus
	["Follow the road north out of {quest:538} into the mountains. Mountain lions roam the slopes; the Syndicate in Strahnbrad wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "",

	-- Step 50: Ruins of Alterac: kill these as you meet them
	["Ruins of Alterac: kill these as you meet them"] = "",
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger
	["The tomes lie in the ruined keep west of Strahnbrad; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health."] = "",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}: огры из клана Раздробленного Хребта",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase
	["{item:3659}: the {object:1760}; inside"] = "",

	-- Step 51: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 52: Strahnbrad: kill these as you meet them
	["Strahnbrad: kill these as you meet them"] = "",
	-- {npc:2320} Nagaz
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: About three stealthed Syndicate mobs are inside {npc:2320}'s house. {npc:2320} does not join when they are pulled, and a ranged attack through the doorway brings him out by himself."] = "",

	-- Step 53: Crushridge ogres
	["Crushridge ogres"] = "Огры из клана Раздробленного Хребта",
	-- {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	["The Crushridge ogres hold the hills north of Strahnbrad. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "",
	["Inside"] = "Внутри",

	-- Step 55: Dalaran
	["Dalaran"] = "",
	-- {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of Dalaran, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "",
	-- {npc:2542} Catelyn the Blade · {object:3204} Booty Bay (no name in this language: may be words)
	["For {npc:2542} in {object:3204}: keep it"] = "",

	-- Step 57: Southshore
	-- {item:2321} Fine Thread · {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance
	["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} для плаща {npc:2438}, у NPC {npc:2381}, если у вас ее нет",
	-- {npc:2438} Bartolo Ginsetti
	["{npc:2438}, if you took his cloak quest"] = "",
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Для NPC {npc:1440} ({zone:1453}): сохраните",

	-- Step 60: Ironforge
	-- {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}, {object:32356}: for {npc:1344} in {zone:1432}, next"] = "",

	-- Step 62: Thelsamar
	["Thelsamar"] = "",
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to Thelsamar."] = "",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "",

	-- Step 63: Prospector Ironband
	["South-east along the loch to the dig site."] = "На юго-восток вдоль озера к раскопкам.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "{npc:2434} незаметно прячется на окраине места {area:271}; убейте его и прочитайте контракт, который он несет.",
	-- ["Back west through {zone:1430} to {area:42}."] = "Обратно на запад через {zone:1430} сюда: {area:42}.",
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Каждый ключ лежит у одного из кругов стоячих камней нагорья: к востоку от осколков, у места {area:320} и на западе. {object:2702} стоит к западу от места {area:320}.",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "На восток по дороге сюда: {area:76}. Кристаллы падают с противников {npc:256028}; Нобору бродит по руинам и оставляет свою дубину.",
	-- ["East to the Witherbark trolls in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley. Every troll here can drop a tusk."] = "На восток к троллям из племени Сухокожих на холмах к югу от места {area:314}; знахари стоят в деревне, темные охотники охраняют дальний конец долины. Клык может выпасть с любого тролля здесь.",
	-- ["Ebenezer Rustlocke"] = "Эбенезер Ржавый Засов",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Проводите профессора на пляж к северу от бухты и охраняйте его, пока он работает; наги нападают волнами.",
	-- ["Fly to {area:271}"] = "Летите сюда: {area:271}",
	-- ["Fly to {area:42}"] = "Летите сюда: {area:42}",
	-- ["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Идите по дороге на восток из места {area:287} через {area:1057} сюда: {area:320}.",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Идите по дороге на север из места {area:271} в горы. По склонам бродят горные львы; члены Синдиката в месте {area:280} носят перстни-печатки, а {npc:2306} ходит по территории поместья в северной части городка.",
	-- ["Follow the road north to the draenei of the {area:657}."] = "Идите по дороге на север к дренеям {area:657}.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Идите по дороге на юг через мост сюда: {area:205} ({zone:1437}), где ждет {npc:1075}.",
	-- ["For {npc:2487} in {area:35}: keep it"] = "Для NPC {npc:2487} ({area:35}): сохраните",
	-- ["For {npc:2542} in {area:35}: keep it"] = "Для NPC {npc:2542} ({area:35}): сохраните",
	-- ["For {npc:2711} in {area:271}"] = "Для NPC {npc:2711} ({area:271})",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "Из места {area:42} идите по дороге на восток через {zone:1430} в зону {zone:1435}; Биггс охраняет развилку сразу за границей. {npc:217412} стоит чуть севернее него.",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "Из города {zone:1455} идите через туннель на восток через зону {zone:1426} в зону {zone:1432} и по дороге сюда: {area:144}.",
	-- ["Gyll, {area:35}"] = "Гилл, {area:35}",
	-- ["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Идите на север мимо места {area:314}; осколки сверкают на холме у места {area:333}.",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Скачите обратно на северо-восток мимо места {area:320}; {npc:2712} и {npc:2713} стоят лагерем на холмах к северу от места {area:314}.",
	-- ["Shaman training"] = "Обучение шамана",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "На юго-запад к лагерю Кирин-Тора на берегу озера к западу от места {area:279}, сразу за границей зоны {zone:1421}: там стоит {npc:269127}. Верховный маг Ансарем стоит к юго-востоку от него, у купола.",
	-- ["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Держитесь рядом с NPC {npc:2713}, пока она пробирается сюда: {area:314} и обратно; по пути на вас нападут орки Орды.",
	-- ["Summon Succubus"] = "Призыв суккуба",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Огры из клана Раздробленного Хребта удерживают холмы к северу от места {area:280}. Дальше на север в потертом деревянном сундуке лежит {item:3706}; {npc:2320} ({quest:537}) стоит прямо рядом.",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Кобольды из племени Сухоусов копают в ущелье к востоку от места {area:321} (Орда); обойдите город с севера. С них падают и частицы, и руда для Кразека.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "Синдикат удерживает ферму к северо-западу от места {area:320}. По ферме ползает {npc:217589}: поймайте одного с помощью набора энтомолога от NPC {npc:217412}, затем отметьте его.",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Тролли из племени Сухокожих живут на холмах к югу от места {area:314}; знахари стоят в деревне, темные охотники охраняют дальний конец долины.",
	-- ["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "Курьер идет по дороге к западу от места {area:314} с двумя стражами; выманите их с дороги.",
	-- ["The shards lie at the far end of {area:318}."] = "Радужные осколки лежат в дальнем конце места {area:318}.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Фолианты лежат в разрушенной крепости к западу от места {area:280}; руины удерживают темные маги Недремлющего Аргуса.",
	-- ["The wrecked caravan lies off the road near Biggs."] = "Разбитый караван лежит в стороне от дороги рядом с Биггсом.",
	-- ["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "Сундук разбитого каравана стоит в северной части места {area:76}, рядом с клеткой NPC {npc:5391}.\nОсторожно: лагерь полон Заблудших около 38-го уровня. Они стоят связанными группами по 2-3, многие из них заклинатели, и возрождаются они быстро.",
	-- ["The wrecks"] = "Обломки кораблей",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Вернитесь на мост: Эбенезер лежит под ним со стороны Нагорья Арати.",
	-- ["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "На запад вдоль побережья к бухте гоблинов; Дозорный Лоло следит за ней со скал.",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659}: {object:1760}",
	-- ["{npc:1141}, {area:17203} road"] = "{npc:1141}, дорога к месту {area:17203}",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, в городе Даларан",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "В городе {zone:1453} нет учителя шаманов: сядьте на поезд ({area:2257}) в месте {object:28027} до города {zone:1455} и обучитесь у NPC {npc:258098}. {npc:1573} ({object:32372}) тоже летает сюда: {area:271}.",
}
