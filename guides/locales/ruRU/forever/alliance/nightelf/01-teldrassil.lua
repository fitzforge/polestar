-- Russian (ruRU): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aldrassil
	-- {area:256} Aldrassil · {area:188} Shadowglen
	["You start at the foot of {area:256}, the great tree of {area:188}."] = "Вы начинаете у подножия великого древа ({area:256}, {area:188}).",
	-- {npc:2077} Melithar Staghelm
	["{npc:2077}, by the path"] = "{npc:2077} – у тропы",
	-- {npc:1992} Tarindrella
	["{npc:1992}, south of the tree"] = "{npc:1992} – к югу от древа",

	-- Step 2: Shadowglen: kill these as you meet them
	-- {area:188} Shadowglen
	["{area:188}: kill these as you meet them"] = "{area:188}: убивайте их по пути",
	-- {area:256} Aldrassil
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Gnarlpine Totems = {item:279082} Gnarlpine Totem · Grells = {npc:1988} Grell
	["Young Nightsabers and Young Thistle Boars (level 1-2) roam around {area:256}: start with them. The Gnarlpine Totems stand in the woods west of the tree, where the Grells (2-3) roam: take them once the beasts are done."] = "Вокруг древа ({area:256}) бродят молодые ночные саблезубы и молодые щетинистые вепри (1-2-го уровня): начните с них. Тотемы племени Кривой Сосны стоят в лесу к западу от древа, где бродят грелли (2-3): займитесь ими, когда закончите со зверями.",

	-- Step 3: The grells west of the tree
	["The grells west of the tree"] = "Грелли к западу от древа",
	-- {item:3297} Fel Moss · {npc:1989} Grellkin
	-- plural, as words: Grells = {npc:1988} Grell
	["Grells (level 2-3) carry {item:3297} in the woods west of the tree, by the totems. The {npc:1989} further north are level 3-4: the Grells by the totems are enough."] = "{item:3297} носят грелли (2-3-го уровня) в лесу к западу от древа, у тотемов. Дальше к северу – {npc:1989} 3-4-го уровня: хватит греллей у тотемов.",

	-- Step 4: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "Снова здесь: {area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}: знак для персонажа {npc:3596}",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082} – на пандусе древа",
	-- {npc:3595} Shanda
	["{npc:3595}: in at the tree's front entrance and up the ramp; upstairs"] = "",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}: примените «{spell:1259799}» и «Слиться с тенью», затем сдайте задание: {npc:3595}",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583} – к востоку от древа",

	-- Step 5: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "На север: {area:257}",
	-- {area:256} Aldrassil · {npc:1994} Githyiss the Vile · {npc:8584} Iverron
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:1994} sits deep inside. {npc:8584} waits in the trees west of the cave mouth."] = "Облезлые ночные саблезубы и щетинистые вепри бродят к северу от древа ({area:256}), по пути к пещере. {npc:1994} – в ее глубине. {npc:8584} ждет среди деревьев к западу от входа в пещеру.",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders; below ground"] = "",

	-- Step 6: Aldrassil
	-- {area:256} Aldrassil · {npc:3593} Alyissia · {npc:3594} Frahun Shadewhisper · {npc:3595} Shanda · {npc:3596} Ayanna Everstride · {npc:3597} Mardant Strongoak
	["The trainers stand upstairs inside {area:256}, along the ramp that winds up the tree: {npc:3593} and {npc:3594} on the first level, {npc:3595} above them, {npc:3596} and {npc:3597} at the top. The arrow cannot tell the levels apart."] = "Учителя стоят наверху внутри древа ({area:256}), вдоль пандуса, вьющегося вверх: {npc:3593} и {npc:3594} – на первом ярусе, {npc:3595} – выше, {npc:3596} и {npc:3597} – на вершине. Стрелка не различает ярусы.",
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer; inside"] = "{npc:3593} – учитель воинов; внутри",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596} – учитель охотников",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594} – учитель разбойников",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer: in at the tree's front entrance and up the ramp"] = "{npc:3595} – учитель жрецов: войдите в древо через главный вход и поднимитесь по пандусу",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597} – учитель друидов ({area:256})",

	-- Step 7: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917} и противоядие",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom · Grells = {npc:1988} Grell
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "{object:4406} лежат в глубине пещеры ({area:257}): идите по центральному проходу, на развилке налево, вверх до высокого уступа. Гиацинтовые грибы падают с греллей, лунные лилии растут у прудов к северу от древа ({area:256}).",
	-- plural, as words: Grells = {npc:1988} Grell
	["Grells"] = "Грелли",

	-- Step 9: Shadowglen
	["Below ground"] = "Под землей",
	-- {quest:97236} Fang of Githyiss
	["{quest:97236}; below ground"] = "",

	-- Step 10: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514} – на вершине древа",

	-- Step 11: The moonwell
	["The moonwell"] = "Лунный колодец",
	-- {area:256} Aldrassil
	["The moonwell sits north of {area:256}."] = "",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "Используйте {item:5185} у лунного колодца",

	-- Step 12: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "Назад на вершину древа ({area:256}). {object:654846} лежит рядом с ним.",
	["Upstairs"] = "Наверху",
	-- {object:654846} Lost Journal
	["{object:654846}, upstairs"] = "",
	-- {npc:3595} Shanda · {area:256} Aldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar
	["{npc:3595}, the priest trainer, on the second level of {area:256} on the way down: {npc:3600} in {area:186} takes it"] = "{npc:3595} – учитель жрецов, на втором ярусе древа ({area:256}) по пути вниз: задание принимает {npc:3600} ({area:186})",

	-- Step 13: Iverron's Antidote
	-- {npc:8583} Dirania Silvershine · {area:256} Aldrassil · {npc:8584} Iverron
	["Take the antidote from {npc:8583} at the foot of {area:256} only now, on the way down: it lasts five minutes. {npc:8584} waits north-west, by the cave: go straight on to him."] = "",

	-- Step 14: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "Покиньте долину ({area:188}) по тропе к юго-востоку от древа ({area:256}): {npc:6780} стоит рядом с ней, где она спускается к дороге на Доланаар ({area:186}).",

	-- Step 15: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "Идите по дороге на юго-запад из {area:188}. {npc:2150} сидит у дороги чуть восточнее места {area:186}.",

	-- Step 16: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811} – у костра",

	-- Step 17: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {npc:6286} Zarrin · {skill:129} First Aid · {npc:6094} Byancie
	["With a profession learned, {npc:265811} also offers its Camping 101, which its trainer takes: alchemy and herbalism beside {npc:6286}, {skill:129} with {npc:6094} in the inn, skinning and leatherworking at the Maneweavers' camp on the road west."] = "Если вы изучили профессию, {npc:265811} также предлагает задание «Походное дело для начинающих», которое принимает учитель этой профессии: алхимия и травничество – рядом с персонажем {npc:6286}, {skill:129} – {npc:6094} в таверне, снятие шкур и кожевничество – в лагере Гривотков на дороге к западу.",
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "Сядьте (/sit) у костра {npc:265811}, пока не получите эффект «{spell:1229451}»",

	-- Step 18: Camping 101: Alchemy
	-- {npc:3603} Cyndra Kindwhisper · {skill:171} Alchemy
	["{npc:3603} takes it once your {skill:171} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:3603} примет его, когда ваш навык {skill:171} достигнет 20: до тех пор собирайте или создавайте предметы, гайд тем временем продолжается.",
	-- {npc:265811} Lyreena Duskblade · {npc:3603} Cyndra Kindwhisper · {npc:6286} Zarrin
	["{npc:265811}: for {npc:3603}, beside {npc:6286}"] = "{npc:265811}: для персонажа {npc:3603}, рядом с персонажем {npc:6286}",

	-- Step 19: Camping 101: Herbalism
	-- {npc:3604} Malorne Bladeleaf · {skill:182} Herbalism
	["{npc:3604} takes it once your {skill:182} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:3604} примет его, когда ваш навык {skill:182} достигнет 20: до тех пор собирайте или создавайте предметы, гайд тем временем продолжается.",
	-- {npc:265811} Lyreena Duskblade · {npc:3604} Malorne Bladeleaf · {npc:6286} Zarrin
	["{npc:265811}: for {npc:3604}, beside {npc:6286}"] = "{npc:265811}: для персонажа {npc:3604}, рядом с персонажем {npc:6286}",

	-- Step 20: Camping 101: First Aid
	-- {npc:6094} Byancie · {skill:129} First Aid
	["{npc:6094} takes it once your {skill:129} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:6094} примет его, когда ваш навык {skill:129} достигнет 20: до тех пор собирайте или создавайте предметы, гайд тем временем продолжается.",
	-- {npc:265811} Lyreena Duskblade · {npc:6094} Byancie
	["{npc:265811}: for {npc:6094} in the inn"] = "{npc:265811}: для персонажа {npc:6094} в таверне",

	-- Step 21: Camping 101: Skinning
	-- {npc:6287} Radnaal Maneweaver · {skill:393} Skinning
	["{npc:6287} takes it once your {skill:393} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:6287} примет его, когда ваш навык {skill:393} достигнет 20: до тех пор собирайте или создавайте предметы, гайд тем временем продолжается.",
	-- {npc:265811} Lyreena Duskblade · {npc:6287} Radnaal Maneweaver
	["{npc:265811}: for {npc:6287}, by the road west"] = "{npc:265811}: для персонажа {npc:6287}, у дороги к западу",

	-- Step 22: Camping 101: Leatherworking
	-- {npc:3605} Nadyia Maneweaver · {skill:165} Leatherworking
	["{npc:3605} takes it once your {skill:165} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:3605} примет его, когда ваш навык {skill:165} достигнет 20: до тех пор собирайте или создавайте предметы, гайд тем временем продолжается.",
	-- {npc:265811} Lyreena Duskblade · {npc:3605} Nadyia Maneweaver
	["{npc:265811}: for {npc:3605}, by the road west"] = "{npc:265811}: для персонажа {npc:3605}, у дороги к западу",

	-- Step 23: Zarrin
	-- {npc:6286} Zarrin
	["{npc:6286}, south of the inn: Camping 101 asks you to learn it"] = "",

	-- Step 24: Cyndra Kindwhisper
	["talk to the trainer"] = "поговорите с учителем",
	-- {npc:3603} Cyndra Kindwhisper · {npc:6286} Zarrin
	["{npc:3603}, beside {npc:6286}"] = "{npc:3603} – рядом с персонажем {npc:6286}",

	-- Step 25: Malorne Bladeleaf
	-- {npc:3604} Malorne Bladeleaf · {npc:6286} Zarrin
	["{npc:3604}, beside {npc:6286}"] = "{npc:3604} – рядом с персонажем {npc:6286}",

	-- Step 26: Byancie
	-- {npc:6094} Byancie
	["{npc:6094}, in the inn"] = "{npc:6094} – в таверне",

	-- Step 27: Dolanaar
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515} – к югу от таверны",
	-- {npc:3608} Aldia
	["{npc:3608}, upstairs"] = "{npc:3608}, наверху",
	-- {npc:3567} Tallonkai Swiftroot
	["{npc:3567}, upstairs"] = "{npc:3567}, наверху",
	-- {npc:3600} Laurna Morninglight
	["{npc:3600}, inside"] = "{npc:3600}, внутри",
	-- {npc:3600} Laurna Morninglight · {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth
	["{npc:3600}: heal {npc:12429} by {area:259}"] = "{npc:3600}: исцелите персонажа {npc:12429} у озера ({area:259})",

	-- Step 28: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151} патрулирует дорогу к западу от деревни: если ее нет у стрелки, идите по дороге, пока не встретите ее.",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151} – на дороге к западу от деревни",

	-- Step 29: Teldrassil: kill these as you meet them
	-- {quest:940} Teldrassil
	["{quest:940}: kill these as you meet them"] = "",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village · {npc:3567} Tallonkai Swiftroot
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker · Befouled Webwoods = {npc:272096} Befouled Webwood
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east; the lurkers also drop the recipe's spider legs. The moonwell is at the west edge of {area:260}.\nCareful: the Befouled Webwoods (10-11) in the woods north-west of {area:186}, around 47-52,34-56, are over you now: take the silk from the Webwood Lurkers and leave the webwoods for {npc:3567}'s quest later. Duskstalker (9, a rare nightsaber) and Oakenscowl (9, elite) roam the woods south of {area:186}, around 54-62,73-77: leave them be."] = "",
	["Nightsabers"] = "Ночные саблезубы",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "Чащобные тенетники",

	-- Step 30: Zenn Foulhoof
	-- {npc:2150} Zenn Foulhoof · {area:186} Dolanaar · {area:260} Starbreeze Village
	["{npc:2150} sits by the road just east of {area:186}, between {area:186} and {area:260}."] = "{npc:2150} сидит у дороги чуть восточнее места {area:186}, между местами {area:186} и {area:260}.",

	-- Step 31: Starbreeze Village
	-- {npc:2107} Gaerolas Talvethren · {object:126158} Tallonkai's Dresser
	["{npc:2107} stands upstairs in a house in the village, east of the moonwell: go up inside, the arrow cannot tell the floors apart. {object:126158} is in the house on the hill at the east end of the village."] = "{npc:2107} стоит наверху в доме в деревне, к востоку от лунного колодца: поднимитесь внутри, стрелка не различает этажи. {object:126158} – в доме на холме в восточной части деревни.",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "Используйте {item:5619} у лунного колодца",
	-- {object:126158} Tallonkai's Dresser
	["{object:126158}; inside"] = "{object:126158}; внутри",

	-- Step 32: Lake Al'Ameth
	-- {npc:2150} Zenn Foulhoof · {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-west of Starbreeze, south of {npc:2150}. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "К юго-западу от Звездного Бриза, к югу от NPC {npc:2150}. {npc:2080} ухаживает за своими саженцами на берегу; вокруг бродят плеточники-ростки и древесники, а среди них растут ростки ({quest:919}).",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}: задание принимает {quest:922} ({zone:1457})",

	-- Step 33: Sentinel Shaya
	-- {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth · {area:186} Dolanaar · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12429} kneels wounded on the rocks at the north edge of {area:259}, on the walk back to {area:186}, with no quest mark over her. Cast {spell:613} (Rank 2) on her, then {spell:1243}: Rank 1 of {spell:613} does not count. She runs off once both land and is back in about 5 minutes."] = "{npc:12429} лежит раненая на камнях у северного края озера ({area:259}), по пути обратно ({area:186}); над ней нет значка задания. Примените на нее «{spell:613}» (2-й уровень), затем «{spell:1243}»: 1-й уровень заклинания «{spell:613}» не засчитывается. Когда оба заклинания сработают, она убегает и возвращается примерно через 5 минут.",
	-- {npc:12429} Sentinel Shaya
	["Heal and fortify {npc:12429}"] = "Исцелите и укрепите: {npc:12429}",

	-- Step 35: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "Вход: {area:258}",

	-- Step 36: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038} ждет в пещере, внизу или наверху на уступе; держитесь правой стороны.",
	-- {npc:2038} Lord Melenas
	["{npc:2038}; below ground"] = "",

	-- Step 37: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "Дорога в город {zone:1457}",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "Душители из племени Кривой Сосны прячутся вдоль дороги к западу от места {area:258}.",

	-- Step 38: Radnaal Maneweaver
	-- {npc:6287} Radnaal Maneweaver
	["{npc:6287}, camped beside the road before Shayla"] = "{npc:6287} – в лагере у дороги, не доходя до Шейлы",

	-- Step 39: Nadyia Maneweaver
	-- {npc:3605} Nadyia Maneweaver · {npc:6287} Radnaal Maneweaver
	["{npc:3605}, beside {npc:6287}"] = "{npc:3605} – рядом с персонажем {npc:6287}",

	-- Step 40: Sentinel Shayla Nightbreeze
	-- {area:261} Gnarlpine Hold
	["West along the road toward the city. Shayla walks this stretch of road, from the arrow south-west to the bend at about 38,54 and back: if she isn't at the arrow, follow the road south-west. Every Gnarlpine furbolg drops fangs: the ambushers on this road, the barrow's and {area:261}'s all count."] = "На запад по дороге к городу. Шейла ходит по этому участку дороги – от стрелки на юго-запад до поворота примерно у 38,54 и обратно: если ее нет у стрелки, идите по дороге на юго-запад. Клыки падают с любого фурболга из племени Кривой Сосны: подходят и душители на этой дороге, и фурболги из обители, и из лагеря ({area:261}).",

	-- Step 41: Darnassus
	-- {quest:922} Rellian Greenspyre · {area:1658} Cenarion Enclave · {npc:7316} Sister Aquinne · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade · {item:279378} Lunar Pendant
	["Into the city through the gate. {quest:922} is just south of the {area:1658} at the north end, {npc:7316} in the west, {npc:7313} and {npc:8396} in the Temple of the Moon at the south end. On the way back out, use Dalia's {item:279378} at the bank and at the city gate; the other two owls wait for your last visit."] = "",
	-- {npc:7313} Priestess A'moora
	["{npc:7313}, in the Temple of the Moon"] = "{npc:7313} – в Храме Луны",
	-- {npc:8396} Sentinel Dalia Sunblade
	["{npc:8396}, beside her"] = "",
	-- {item:279378} Lunar Pendant
	["{item:279378}: the bank, on the way out"] = "",
	["the city gate"] = "",

	-- Step 42: Ban'ethil Barrow Den's entrance
	-- {area:262} Ban'ethil Barrow Den
	["{area:262}'s entrance"] = "",

	-- Step 43: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	-- plural, as words: Gnarlpine Defenders = {npc:2010} Gnarlpine Defender
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms. Its furbolgs drop Shayla's fangs.\nCareful: the barrow's Gnarlpine Defenders, Augurs and Shamans (7-9) stand in threes in the narrow tunnels: pull each group back toward the entrance before you go deeper."] = "Обитель – к югу от дороги. Внутри держат в плену: {npc:275744}; в глубине спит {npc:7317}, а четыре сундука с реликвиями стоят в нижних залах. С ее фурболгов падают клыки для Шайлы.\nОсторожно: защитники, авгуры и шаманы из племени Кривой Сосны (7-9) стоят по трое в узких туннелях: отводите каждую группу назад ко входу, прежде чем идти глубже.",
	-- {item:5220} Gnarlpine Fang
	["{item:5220}: any Gnarlpine furbolg"] = "",
	-- {npc:7317} Oben Rageclaw
	["{npc:7317}, below ground"] = "{npc:7317}, под землей",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "Шаманы из племени Кривой Сосны",

	-- Step 44: Rageclaw
	-- {npc:7318} Rageclaw · {npc:7317} Oben Rageclaw · {area:736} Ban'ethil Hollow · {item:8149} Voodoo Charm
	["{npc:7318} (level 10), {npc:7317}'s soulless body, walks around {area:736} in the den: kill him, then use {npc:7317}'s {item:8149}."] = "{npc:7318} (10-й уровень), бездушное тело NPC {npc:7317}, бродит в логове ({area:736}): убейте его, затем используйте {item:8149} (владелец: {npc:7317}).",
	-- {npc:7318} Rageclaw · {area:736} Ban'ethil Hollow
	["{npc:7318}, in the den; walks around {area:736}: look inside the circle on the map"] = "",

	-- Step 45: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "Выведите из обители: {npc:275744}; отчет принимает {npc:2081} ({area:186}).",
	["Walk Lynessa out and keep her alive"] = "Выведите Линессу, не дав ей погибнуть",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736} – снаружи обители",

	-- Step 46: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "{area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "К юго-западу от обители. Лунный колодец – у озер.",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "Используйте {item:5621} у лунного колодца",

	-- Step 47: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	-- plural, as words: Gnarlpine Avengers = {npc:2013} Gnarlpine Avenger
	["South of the pools. The {object:6751} grows by the Hold; the furbolgs around it drop the rest of the fangs.\nCareful: the Gnarlpine Avengers (9-10) and Augurs here stand close together and many players died at the Hold: pull them one at a time."] = "К югу от озер. {object:6751} растет у лагеря; остальные клыки падают с фурболгов вокруг.\nОсторожно: мстители (9-10) и авгуры из племени Кривой Сосны стоят близко друг к другу, здесь погибло много игроков: выманивайте их по одному.",

	-- Step 49: Seek Redemption!
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {npc:7234} Ferocitas the Dream Eater
	-- plural, as words: Fel Cones = {object:1673} Fel Cone
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}: pick them up on the road east and hand them to {npc:2150} on the way to {npc:7234}."] = "Шишки Скверны лежат под деревьями вокруг места {area:186} и NPC {npc:2150}: подбирайте их на дороге на восток и отдайте NPC {npc:2150} по пути к NPC {npc:7234}.",

	-- Step 50: Ferocitas the Dream Eater
	-- {npc:7234} Ferocitas the Dream Eater · {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and {npc:7234} camp north-east of {area:260}. {npc:7234} drops the {item:8049}: open it for the jewel.\nCareful: {npc:7234} waits near the camp fire with mystics around him, so pulling him without adds is hard."] = "Мистики из племени Кривой Сосны и {npc:7234} стоят лагерем к северо-востоку от места {area:260}. С NPC {npc:7234} падает {item:8049}: откройте его, чтобы достать самоцвет.\nОсторожно: {npc:7234} ждет у костра в окружении мистиков, так что выманить его одного трудно.",
	-- {item:8049} Gnarlpine Necklace · {npc:7234} Ferocitas the Dream Eater
	["{item:8049}, from {npc:7234}"] = "{item:8049}, у персонажа {npc:7234}",

	-- Step 51: Dolanaar
	-- {area:264} Oracle Glade · {area:186} Dolanaar · {npc:3567} Tallonkai Swiftroot
	["The road west to the {area:264} runs through {area:186}: hand {npc:3567} the jewel on the way."] = "Дорога на запад ({area:264}) проходит через {area:186}: по пути отдайте самоцвет: {npc:3567}.",

	-- Step 52: Tallonkai Swiftroot
	-- {npc:3567} Tallonkai Swiftroot · {quest:932} Twisted Hatred · {npc:272116} Xethorr the Wicked · {area:264} Oracle Glade
	-- plural, as words: Befouled Webwoods = {npc:272096} Befouled Webwood
	["{npc:3567}: {quest:932}'s Befouled Webwoods and the elite {npc:272116}'s moss, on the walk to the {area:264}"] = "{npc:3567}: оскверненные тенетники для задания «{quest:932}» и мох элитного противника ({npc:272116}) – по пути сюда: {area:264}",

	-- Step 53: Befouled Webwoods
	-- plural, as words: Befouled Webwoods = {npc:272096} Befouled Webwood
	["Befouled Webwoods"] = "Оскверненные тенетники",
	-- {area:264} Oracle Glade · {npc:272116} Xethorr the Wicked · {item:281023} Mature Fel Moss
	-- plural, as words: Befouled Webwoods = {npc:272096} Befouled Webwood
	["North-west of Dolanaar, on the way to the {area:264}, Befouled Webwoods creep through the woods; {npc:272116} prowls at their east edge and carries the {item:281023}.\n{npc:272116} is elite (level 12): grouping up is advised. Clear the webwoods around him first and pull him on his own."] = "К северо-западу от Доланаара, по пути сюда: {area:264} – по лесу ползают оскверненные тенетники; {npc:272116} рыщет у их восточного края и носит {item:281023}.\n{npc:272116} – элитный противник (12-й уровень): рекомендуется собрать группу. Сначала перебейте тенетников вокруг него, затем выманите его одного.",

	-- Step 54: The Wellspring River
	-- {area:265} Wellspring River
	["The {area:265}"] = "{area:265}",
	-- {area:265} Wellspring River · {npc:272116} Xethorr the Wicked · {area:186} Dolanaar
	-- plural, as words: Mossy Tumors = {item:5170} Mossy Tumor · Befouled Webwoods = {npc:272096} Befouled Webwood
	["West from the webwoods to the {area:265}, then north along it to the glade: the timberlings along its banks drop the Mossy Tumors.\nCareful: {npc:272116}, a level 12 elite, prowls the east edge of the Befouled Webwoods north-west of {area:186}: if you are alone, keep clear of the webwoods and go round him."] = "От чащи тенетников на запад к реке ({area:265}), затем вдоль нее на север до поляны: с древней по берегам падают мшистые опухоли.\nОсторожно: {npc:272116}, элита 12-го уровня, бродит по восточному краю территории оскверненных чащобных тенетников к северо-западу от места {area:186}: если вы один, держитесь подальше от тенетников и обойдите его.",
	-- {item:5170} Mossy Tumor
	["{item:5170}: timberlings"] = "",

	-- Step 55: Oracle Glade
	-- {object:6752} Strange Fronded Plant
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "Лунный колодец – в центре поляны. {object:6752} растет в ее северной части.",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519} – у лунного колодца",
	-- {item:18152} Amethyst Phial
	["Use the {item:18152} at the moonwell"] = "Используйте {item:18152} у лунного колодца",

	-- Step 56: Bloodfeather harpies
	["Bloodfeather harpies"] = "Гарпии из стаи Кровавого Пера",
	-- {quest:938} Mist
	["The Bloodfeather harpies nest on the slopes west and north of the glade. {quest:938}, an injured sabercat, lies by the glade's west wall among them: lead her back to Sentinel Arynia at the moonwell before her time runs out.\nCareful: The harpies stand packed together, so extra ones often join a fight. Casters are mixed in among them."] = "",
	-- {quest:938} Mist
	["{quest:938}, by the west wall"] = "",
	-- {quest:938} Mist
	["Lead {quest:938} to the moonwell"] = "",

	-- Step 57: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "Назад к лунному колодцу.",

	-- Step 58: Hatescreech and Windmistress Gaedress
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress
	["{npc:272034} and {npc:272044}"] = "{npc:272034} и {npc:272044}",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa · {npc:7319} Lady Sathrah
	["{npc:272034} and {npc:272044} (level 10) fly just west of the moonwell. {npc:272046} (12) waits further north for the walk back from {npc:7319}."] = "{npc:272034} и {npc:272044} (10-й уровень) летают чуть западнее лунного колодца. {npc:272046} (12) ждет дальше к северу – на обратном пути от NPC {npc:7319}.",

	-- Step 59: Lady Sathrah
	-- {object:6752} Strange Fronded Plant · {area:266} Wellspring Lake · {npc:7319} Lady Sathrah
	["The {object:6752} grows at the glade's north end, on the way: then north along the island's northern edge by {area:266}, {npc:7319}, a level 12 spider, lurks."] = "{object:6752} растет по пути, в северной части поляны: затем на север вдоль северного края острова у озера ({area:266}) – там затаилась {npc:7319}, паучиха 12-го уровня.",

	-- Step 60: Witchmother Arysa
	-- {npc:272046} Witchmother Arysa
	-- plural, as words: Bloodfeather Matriarchs = {npc:2021} Bloodfeather Matriarch
	["On the way back south to the glade: {npc:272046} (level 12) flies on the slopes north-west of the moonwell, among Bloodfeather Matriarchs (11). Pull the harpies around her first."] = "На обратном пути на юг к поляне: {npc:272046} (12-й уровень) летает на склонах к северо-западу от лунного колодца среди матриархов стаи Кровавого Пера (11). Сначала выманите гарпий вокруг нее.",

	-- Step 61: Sentinel Arynia again
	["Sentinel Arynia again"] = "Снова часовой Арания",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words)
	["{object:673378}, just west of the moonwell"] = "{object:673378} – чуть западнее лунного колодца",
	-- {object:673378} Oracle Tree Bark (no name in this language: may be words) · {zone:1457} Darnassus
	["the same {object:673378}: Fandral in {zone:1457} takes it"] = "",

	-- Step 62: Sentinel Shayla Nightbreeze
	-- {area:186} Dolanaar
	["South from the glade to the road: Shayla walks the road west of {area:186}, from where the path down from the glade meets it south-west to the bend at about 38,54 and back."] = "С поляны на юг к дороге: Шейла ходит по дороге к западу от места {area:186} – от места, где к ней спускается тропа с поляны, на юго-запад до поворота примерно у 38,54 и обратно.",

	-- Step 63: Dolanaar
	-- {area:186} Dolanaar
	["East along the road to {area:186}."] = "На восток по дороге к месту {area:186}.",
	-- {npc:6094} Byancie
	["{npc:6094}, inside"] = "{npc:6094}, внутри",
	-- {item:3371} Empty Vial · {npc:3614} Narret Shadowgrove · {npc:6094} Byancie
	["{item:3371} from {npc:3614}, beside {npc:6094}"] = "{item:3371}: продает {npc:3614}, рядом с персонажем {npc:6094}",
	-- {npc:3600} Laurna Morninglight · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:3600}: {npc:11401} in {zone:1457} takes it"] = "{npc:3600}: задание принимает {npc:11401} ({zone:1457})",
	-- {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr · {npc:6094} Byancie
	["{item:159} from {npc:6736}, for {npc:6094}"] = "{item:159}: продает {npc:6736}, для персонажа {npc:6094}",
	-- {zone:1457} Darnassus
	["Fandral in {zone:1457} takes it"] = "Задание принимает Фэндрал ({zone:1457})",
	-- {npc:3602} Kal · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:3602}: {npc:4217} in {zone:1457} takes it"] = "{npc:3602}: задание принимает {npc:4217} ({zone:1457})",
	-- {npc:3598} Kyra Windblade · {quest:1684} Elanaria · {zone:1457} Darnassus
	["{npc:3598}, the warrior trainer: {quest:1684} in {zone:1457} takes it"] = "",

	-- Step 64: Tallonkai Swiftroot
	-- {npc:3567} Tallonkai Swiftroot · {npc:272116} Xethorr the Wicked
	["Back upstairs to {npc:3567} with the webwoods done and {npc:272116}'s moss."] = "Снова наверх, к персонажу {npc:3567}, когда тенетники перебиты и мох ({npc:272116}) у вас.",

	-- Step 65: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "К юго-востоку от Доланаара: {npc:2080}. Вокруг него на берегу бродят плеточники-ростки.",

	-- Step 66: Ursal the Mauler
	-- {area:259} Lake Al'Ameth · {area:478} Pools of Arlithrien
	["South-west from {area:259}, past the {area:478}: Ursal prowls the far south of the island.\nCareful: Gnarlpine of roughly level 9-11 crowd the camp and sit close together, so it is easy to pull several at once. Take them on singly before you engage Ursal."] = "На юго-запад от места {area:259}, мимо места {area:478}: Урсал бродит на крайнем юге острова.\nОсторожно: лагерь полон фурболгов Кривой Сосны примерно 9-11-го уровня, они стоят близко друг к другу, и легко привлечь нескольких сразу. Перебейте их по одному, прежде чем нападать на Урсала.",

	-- Step 67: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "Снова здесь: {area:186}",
	-- {area:186} Dolanaar · {npc:6094} Byancie · {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr
	["North-east from Ursal's den, back to {area:186}. {npc:6094} takes a {item:159} with the fronds and the vial: if you drank yours, buy another from {npc:6736} in this inn before you hand in."] = "От логова Урсала на северо-восток, обратно в {area:186}. {npc:6094} принимает {item:159} вместе с листьями и флаконом: если вы выпили свою, купите еще у NPC {npc:6736} в этой таверне, прежде чем сдавать.",

	-- Step 68: Taming the Beast
	-- {item:15908} Taming Rod · {area:186} Dolanaar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker · Nightsaber Stalkers = {npc:2043} Nightsaber Stalker · Strigid Screechers = {npc:1996} Strigid Screecher
	["Each of Dazalar's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Каждое задание Дазалара дает вам предмет {item:15908}: примените его на названном звере, затем верните жезл ему ({area:186}). Чащобные тенетники ползают вокруг деревни, ночные саблезубы-охотники и совы-крикуны бродят по лесу к югу от нее.",
	-- {npc:1998} Webwood Lurker · {item:15908} Taming Rod
	["{npc:1998}: tame it with the {item:15908}"] = "{npc:1998}: приручите его с помощью предмета {item:15908}",
	-- {npc:2043} Nightsaber Stalker · {item:15908} Taming Rod
	["{npc:2043}: tame it with the {item:15908}"] = "{npc:2043}: приручите его с помощью предмета {item:15908}",
	-- {npc:1996} Strigid Screecher · {item:15908} Taming Rod
	["{npc:1996}: tame it with the {item:15908}"] = "{npc:1996}: приручите его с помощью предмета {item:15908}",
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457} takes it"] = "Задание принимает {npc:4146} ({zone:1457})",

	-- Step 69: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "Снова идите по дороге на северо-запад от места {area:186}; она по-прежнему лежит у дороги, по пути в город {zone:1457}.",

	-- Step 70: Into Darnassus
	-- {area:1657} Darnassus
	-- was: ["Into {zone:1457}"] = "В зону {zone:1457}"
	["Into {area:1657}"] = "",
	-- {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace
	["{npc:4241}, on the {area:1659} just inside the city"] = "{npc:4241} – {area:1659}, сразу у входа в город",

	-- Step 72: Elanaria
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}, just inside the city."] = "",

	-- Step 73: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:736} Ban'ethil Hollow · {quest:1684} Elanaria
	["Back out of the city gate and east along the road: {quest:1683} stands south of it, by {area:736}. Bring his horn back to {quest:1684}."] = "",
	-- {area:736} Ban'ethil Hollow
	["East from the city gate to {area:736}"] = "",

	-- Step 75: Darnassus
	-- {area:1657} Darnassus · {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace · {area:3425} Cenarion Hold · {npc:4241} Mydrannul · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade
	-- was: ["Follow the road west into {zone:1457} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "Идите по дороге на запад в город {zone:1457} и используйте {item:279378} у таверны ({area:1659}) и у входа в туннель под местом {area:3425} для последних двух сов. {npc:4241} стоит сразу у входа в город: {area:1659}. {npc:3516} – в северной части города ({area:1658}), {quest:922} – чуть южнее; {npc:4092}, {npc:7999}, {npc:7313} и {npc:8396} – в Храме Луны в южной части."
	["Follow the road west into {area:1657} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "",
	-- {npc:4088} Elanaria · {area:1660} Warrior's Terrace · {spell:71} Defensive Stance
	["{npc:4088}, on the {area:1660}: {spell:71}"] = "",
	-- {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace
	["{item:279378}: the inn on the {area:1659}"] = "",

	-- Step 76: Warrior trainer
	["Warrior trainer"] = "Учитель воинов",
	-- {area:1660} Warrior's Terrace · {quest:1684} Elanaria
	["Level 12 spells while you're on the {area:1660}: the warrior trainers stand beside {quest:1684}."] = "Заклинания 12-го уровня, пока вы здесь ({area:1660}): учителя воинов стоят рядом ({quest:1684}).",

	-- Step 78: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516} – здесь: {area:1658}",

	-- Step 79: Cenarion Enclave
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146} ({area:1658}): {spell:5149}",

	-- Step 80: Cenarion Enclave trainers
	-- {area:1658} Cenarion Enclave
	["{area:1658} trainers"] = "Учителя: {area:1658}",
	-- {area:1658} Cenarion Enclave
	["Level 12 spells while you're in the {area:1658}: the hunter, rogue and druid trainers all stand in it."] = "Заклинания 12-го уровня, пока вы здесь ({area:1658}): учителя охотников, разбойников и друидов стоят здесь же.",

	-- Step 82: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217} – здесь: {area:1658}",
	-- {area:3425} Cenarion Hold
	["the tunnel mouth below {area:3425}, on the way south"] = "",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092} – в Храме Луны",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999} – выше, над персонажем {npc:4092}",
	-- {quest:2520} Sathrah's Sacrifice
	["{quest:2520}, standing in the temple's central fountain"] = "",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401} – в Храме Луны: Звездные осколки",

	-- Step 83: Priest trainer
	["Priest trainer"] = "Учитель жрецов",
	-- {npc:11401} Priestess Alathea
	["Level 12 spells while you're in the Temple of the Moon: the priest trainers stand beside {npc:11401}."] = "Заклинания 12-го уровня, пока вы в Храме Луны: учителя жрецов стоят рядом с NPC {npc:11401}.",

	-- Step 84: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 85: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 86: Portal to Teldrassil
	-- {quest:940} Teldrassil
	["Portal to {quest:940}"] = "",

	-- Step 87: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine · {area:442} Auberdine · {npc:4200} Laird
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs. Once you have {quest:6342}, talk to {npc:3838} again and choose the flight to {area:442}: it is free and lands beside {npc:4200}. If the flight map opens instead, close it and talk to him again holding Shift."] = "",
	-- {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine
	["talk to {npc:3838} again: free with {quest:6342}"] = "",

	-- Step 88: Auberdine
	-- {npc:3841} Caylais Moonfeather · {npc:4200} Laird
	["Learn the flight path from {npc:3841} where you land. {npc:4200}'s fish stall is just north of her, by the docks.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "",
	["The WANTED poster outside the inn"] = "Плакат «РАЗЫСКИВАЕТСЯ» у таверны",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart"] = "",

	-- Step 89: Return to Nessa
	-- {area:702} Rut'theran Village · {npc:3841} Caylais Moonfeather · {item:16263} Laird's Response · {npc:10118} Nessa Shadowsong · {area:442} Auberdine
	["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442}."] = "Летите обратно сюда: {area:702} – от {npc:3841}, отдайте {item:16263}: {npc:10118} на пристани, затем летите обратно ({area:442}).",

	-- Step 90: The Long Wash
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Прибрежные крабы снуют по берегу под деревней; {quest:983} стоит на пляже чуть южнее пристани. На мелководье плавают крепкозубы Темного берега. {object:175207} лежит на берегу чуть южнее деревни.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "Лапы краба: прибрежные крабы",
	-- {quest:983} Buzzbox 827 · {zone:1439} Darkshore
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["{quest:983}: Thresher Eyes, on the {zone:1439} guide's first beach stop"] = "",

	-- Step 91: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649} – в северной части деревни",

	-- Step 92: Gubber Blump
	-- {npc:10216} Gubber Blump · {item:12238} Darkshore Grouper
	["Fishers only: {npc:10216} stands on the pier. His {item:12238} is fished from the pier itself."] = "",
	-- {npc:10216} Gubber Blump
	["{npc:10216}, on the pier"] = "{npc:10216} – на пристани",

	-- Step 93: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {area:493} Moonglade · {npc:10897} Sindrayl · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn {area:493}'s flight path from {npc:10897}, south of the lake, for later trips. Then {npc:11800} in {area:2361} flies Druids straight to {area:702} from her gossip: hers is no flight path to learn. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Произнесите {spell:18960}. {npc:11802} – в месте {area:2361}; {quest:5929} – в лесу к северо-западу. Узнайте маршрут полета ({area:493}) у NPC {npc:10897} к югу от озера для будущих поездок. Затем {npc:11800} в месте {area:2361} отправит друидов прямо в {area:702} через диалог: этот маршрут полета изучать не нужно. {npc:11802} стоит наверху в своем здании: поднимитесь внутри, стрелка не различает этажи.",
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Поговорите: {quest:5929}",

	-- Step 94: Back to Darnassus
	-- {npc:10118} Nessa Shadowsong · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:10118} stands on the Rut'theran dock where you land. Then take the portal up to {npc:4217} in the {area:1658}."] = "",

	-- Step 97: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Распорядитель полетов: {area:702}",
	-- {zone:1457} Darnassus
	["Take the portal down from {zone:1457} to the hippogryphs."] = "",

	-- Step 98: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Спуститесь обратно: {area:702}, затем летите сюда: {area:442}. {object:177525} стоит на холмах чуть восточнее деревни: используйте там {item:15208}, победите Лунокогтя и поговорите: {npc:12144}.",

	-- Step 99: Auberdine flight master
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Распорядитель полетов: {area:442}",

	-- Step 100: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442}."] = "Еще раз летите сюда: {area:702} – и поднимитесь через портал к {npc:4217}, затем летите обратно ({area:442}).",

	-- Step 101: Back to Auberdine
	-- {area:442} Auberdine
	["Back to {area:442}"] = "",
	-- {area:702} Rut'theran Village
	["Take the portal down to the hippogryphs at {area:702}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {zone:1453}"] = "Корабль: {zone:1453}",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Примените {spell:18960}. {npc:11802} – здесь: {area:2361}; {quest:5929} – в лесу к северо-западу. Затем {npc:11800} ({area:2361}) доставит друидов прямо сюда: {area:702} – маршрут полета не нужен. {npc:11802} стоит наверху в своем здании: поднимитесь внутри, стрелка не различает этажи.",
	-- ["Each of {npc:3601}'s quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Каждое задание ({npc:3601}) дает вам предмет {item:15908}: примените его на названном звере, затем верните жезл ему ({area:186}). Чащобные тенетники ползают вокруг деревни, ночные саблезубы-охотники и совы-крикуны бродят по лесу к югу от нее.",
	-- ["East to {area:260}"] = "На восток: {area:260}",
	-- ["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442} for the boat."] = "Еще раз летите сюда: {area:702} – и поднимитесь через портал к {npc:4217}, затем летите обратно ({area:442}) к кораблю.",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "Идите по дороге на юго-запад: {area:188} → {area:186}.",
	-- ["Follow the road west into {zone:1457} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "Идите по дороге на запад в город {zone:1457} и используйте {item:279378} у таверны ({area:1659}) и у входа в туннель под местом {area:3425} для последних двух сов. {npc:4241} стоит сразу у входа в город: {area:1659}. {npc:3516} – в северной части города ({area:1658}), {quest:922} – чуть южнее; {npc:4092}, {npc:7999}, {npc:7313} и {npc:8396} – в Храме Луны в южной части.",
	-- ["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "Из гавани идите сюда: {object:2100}. Там воинов обучает {npc:5480}; {npc:6089} и {npc:6090} стоят вместе у таверны ({object:2152}). {npc:6090} сражается с вами за свою кружку.",
	-- ["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "От места {area:17203} езжайте через городские ворота в зону {zone:1429} и по дороге на запад: {zone:1436}.",
	-- ["Hearth to {area:186}"] = "Камень возвращения: {area:186}",
	-- ["Into {zone:1457}"] = "В зону {zone:1457}",
	-- ["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "Узнайте маршрут полета ({area:442}) на холме к югу от таверны, затем примените {spell:18960}. {npc:11802} – здесь: {area:2361}; {quest:5929} – в лесу к северо-западу. Узнайте маршрут полета ({area:493}) здесь: {area:2361} – и летите сюда: {area:702} (через {area:442}).",
	-- ["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:8584} waits in the trees west of the cave mouth; {npc:1994} sits deep inside."] = "Облезлые ночные саблезубы и щетинистые вепри бродят к северу от древа ({area:256}), по пути к пещере. {npc:8584} ждет среди деревьев к западу от входа в пещеру; {npc:1994} – в ее глубине.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "Вдоль дороги на восток живут ночные саблезубы, совы и чащобные тенетники. Лунный колодец – на западном краю деревни ({area:260}).",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east; the lurkers also drop the recipe's spider legs. The moonwell is at the west edge of {area:260}."] = "Ночные саблезубы, совы и чащобные тенетники бродят по всей округе ({area:186}) и вдоль дороги на восток; с тенетников также падают паучьи лапки для рецепта. Лунный колодец – на западном краю деревни ({area:260}).",
	-- ["North-east from Ursal's den, back to {area:186}."] = "От логова Урсала на северо-восток, назад: {area:186}.",
	-- ["South from the glade toward Ursal: Shayla walks the road west of {area:186}, from where the path down from the glade meets it south-west to the bend at about 38,54 and back."] = "С поляны на юг к Урсалу: Шейла ходит по дороге к западу от места {area:186} – от места, где к ней спускается тропа с поляны, на юго-запад до поворота примерно у 38,54 и обратно.",
	-- ["South of the pools. The {object:6751} grows by the Hold; the furbolgs around it drop the rest of the fangs."] = "К югу от озер. {object:6751} растет у Лагеря у Кривой Сосны; остальные клыки падают с фурболгов вокруг.",
	-- ["Speak with {npc:6286}, south of the inn"] = "Поговорите с персонажем {npc:6286} к югу от таверны",
	-- ["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "Спуститесь через портал: {area:702}. {npc:10118} стоит на пристани, {npc:3838} – у гиппогрифов.",
	-- ["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "Поднимитесь через портал ({area:702}) к {npc:4217} ({area:1658}).",
	-- ["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "Идите по дороге на северо-запад ({area:186} → {area:264}); она лежит раненая у дороги.",
	-- ["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "Гарпии из стаи Кровавого Пера гнездятся на склонах к западу и северу от поляны.",
	-- ["The moonwell and {npc:8584}"] = "Лунный колодец и {npc:8584}",
	-- ["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "Лунный колодец – к северу от древа ({area:256}); {npc:8584} – чуть дальше на северо-запад. Задание «{quest:3522}» длится пять минут: наполните флакон и сразу идите к нему.",
	-- ["The named harpies"] = "Именные гарпии",
	-- ["The {area:264}"] = "{area:264}",
	-- ["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "Идите на юг вдоль западной стороны острова. Урсал рыщет на дальнем юге, ниже места {area:478}.",
	-- ["Webwood Spiders"] = "Чащобные тенетники",
	-- ["West along the road from {area:186}, before the turn north to the glade: Shayla walks the road from the arrow south-west to the bend at about 38,54 and back."] = "На запад по дороге от места {area:186}, до поворота на север к поляне: Шейла ходит по дороге от стрелки на юго-запад до поворота примерно у 38,54 и обратно.",
	-- ["West from the webwoods to the {area:265}, then north along it to the glade: the timberlings along its banks drop the Mossy Tumors."] = "От тенетников на запад к реке ({area:265}), затем на север вдоль нее до поляны: мшистые опухоли падают с древесников на ее берегах.",
	-- ["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "Вокруг древа ({area:256}) бродят молодые ночные саблезубы и молодые щетинистые вепри. {item:3297} носят грелли в лесу к западу от древа, где стоят тотемы племени Кривой Сосны.",
	-- ["{area:186} quests"] = "Задания: {area:186}",
	-- ["{npc:11401}, in the Temple of the Moon: {spell:10797}"] = "{npc:11401} – в Храме Луны: {spell:10797}",
	-- ["{npc:2150}, on the way back"] = "{npc:2150} – на обратном пути",
	-- ["{npc:265811}, alchemists: for {npc:3603}"] = "{npc:265811}, алхимики: для персонажа {npc:3603}",
	-- ["{npc:265811}, herbalists: for {npc:3604}"] = "{npc:265811}, травники: для персонажа {npc:3604}",
	-- ["{npc:265811}, leatherworkers: for {npc:3605}"] = "{npc:265811}, кожевники: для персонажа {npc:3605}",
	-- ["{npc:265811}, skinners: for {npc:6287}"] = "{npc:265811}, снятие шкур: для персонажа {npc:6287}",
	-- ["{npc:265811}, {skill:129}: for {npc:6094}"] = "{npc:265811}, {skill:129}: для персонажа {npc:6094}",
	-- ["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034} и {npc:272044} летают чуть западнее лунного колодца, {npc:272046} – дальше к северу.",
	-- ["{npc:3567}, back in {area:186}"] = "{npc:3567} – снова здесь: {area:186}",
	-- ["{npc:3595}, inside the tree"] = "{npc:3595} – внутри древа",
	-- ["{npc:3595}, the priest trainer, on the ramp on the way down: {npc:3600} in {area:186} takes it"] = "{npc:3595} – учитель жрецов, на пандусе по пути вниз: задание принимает {npc:3600} ({area:186})",
	-- ["{npc:3603}, beside {npc:6286}: Camping 101, alchemists"] = "{npc:3603} – рядом с персонажем {npc:6286}: «Походное дело для начинающих», алхимики",
	-- ["{npc:3604}, beside {npc:6286}: Camping 101, herbalists"] = "{npc:3604} – рядом с персонажем {npc:6286}: «Походное дело для начинающих», травники",
	-- ["{npc:3605}, beside him: Camping 101, leatherworkers"] = "{npc:3605} – рядом с ним: «Походное дело для начинающих», кожевники",
	-- ["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "Рыбный прилавок ({npc:4200}) – у пристани. Затем плывите на корабле сюда: {zone:1453}.",
	-- ["{npc:6094}, in the inn: Camping 101, {skill:129}"] = "{npc:6094} – в таверне: «Походное дело для начинающих», {skill:129}",
	-- ["{npc:6287}, camped beside the road before Shayla: Camping 101, skinners"] = "{npc:6287} – в лагере у дороги, не доходя до Шейлы: «Походное дело для начинающих», снятие шкур",
	-- ["{npc:7318}, in the den"] = "{npc:7318} – в логове",
	-- ["{object:7510}, beside him"] = "{object:7510} – рядом с ним",
	-- ["{quest:488} and the Starbreeze moonwell"] = "{quest:488} и лунный колодец Деревни Звездного Ветра",
	-- ["{quest:97979}: cast {spell:1259799} and {spell:20580}, then hand it back to {npc:3595}"] = "{quest:97979}: примените «{spell:1259799}» и «{spell:20580}», затем сдайте задание: {npc:3595}",
}
