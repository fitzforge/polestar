-- Russian (ruRU): the guide forever/alliance/nightelf/02-darkshore (forever/alliance/nightelf/02-darkshore.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Корабль причаливает к западу от деревни. Распорядитель полетов стоит на холме к югу от таверны; дающие задания – вдоль главной улицы.",
	["The WANTED poster outside the inn"] = "Плакат «РАЗЫСКИВАЕТСЯ» у таверны",

	-- Step 2: The beach
	["The beach"] = "Пляж",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Прибрежные крабы снуют по берегу под деревней; {quest:983} стоит на пляже чуть южнее пристани. На мелководье плавают крепкозубы Темного берега. {object:175207} лежит на берегу чуть южнее деревни.",

	-- Step 3: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649} – в северной части деревни",

	-- Step 4: Auberdine
	-- {npc:3666} Wizbang Cranktoggle
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street. {npc:3666} stands upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "Корабль причаливает к западу от деревни. Распорядитель полетов стоит на холме к югу от таверны; дающие задания расположены вдоль главной улицы. {npc:3666} находится на верхнем этаже таверны: поднимитесь по лестнице внутри, стрелка не различает этажи.",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn"] = "{npc:3666}, верхний этаж таверны",

	-- Step 5: The skeletal turtle
	["The skeletal turtle"] = "Скелет черепахи",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Медведи и лагерь Чернолесья",
	-- {area:442} Auberdine · {item:7586} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "Бешеные косолапы бродят по холмам к югу от {area:442}: используйте {item:7586} на одном из них, чтобы поймать его. Затем поднимитесь к лагерю фурболгов чуть восточнее: пока никого убивать не нужно.",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "",

	-- Step 7: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} стоит у северного края руин. Там обитают проклятые, терзаемые высокорожденные и {npc:2178}; среди них бродит призрак – {npc:3667}, к востоку кружит сова {npc:270196}. Обе скрижали лежат в руинах; {quest:4722} – на берегу к западу от них.",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Реликвии высокорожденных",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "Прочитайте: {object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "Прочитайте: {object:17189}",

	-- Step 8: The red crystal
	["The red crystal"] = "Красный кристалл",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Поднимитесь в горы к востоку (ориентир: {area:447}); {object:175524} лежит на уступе.",

	-- Step 9: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {object:17183} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Серьги грелля",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: сатиры из племени Дет'рилл",

	-- Step 11: Auberdine
	["Fill the tube at the moonwell in the village"] = "Наполните пробирку у лунного колодца в деревне",

	-- Step 12: Blackwood furbolgs
	["Blackwood furbolgs"] = "Фурболги Чернолесья",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Землепроходцы и заклинатели ветра из племени Чернолесья занимают лагерь к юго-востоку (ориентир: {area:442}).",

	-- Step 13: The southern beaches
	["The southern beaches"] = "Южные пляжи",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Идите вдоль побережья на юг мимо руин ({area:447}): одно существо ({quest:4728}) лежит на берегу к западу от Рощи, другое – южнее, рядом с местом {area:450}. Еще три останка лежат дальше на юго-западе среди оракулов и волноловов из племени Серой Мглы (18–20): гайд оставляет их на последний круг, когда вы будете ближе к их уровню.",

	-- Step 14: Ameth'Aran
	-- {area:447} Ameth'Aran
	["Back north to {area:447}: the flame burns in the south of the ruins."] = "Обратно на север в {area:447}: пламя горит в южной части руин.",

	-- Step 15: The red crystal
	["Back north-east into the mountains to the crystal."] = "Назад на северо-восток, в горы, к кристаллу.",

	-- Step 16: Bashal'Aran
	-- {npc:3650} Asterion · {area:442} Auberdine
	["North along the hills to {npc:3650}, then west down to {area:442}."] = "На север вдоль холмов к NPC {npc:3650}, затем на запад вниз в {area:442}.",

	-- Step 18: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "",

	-- Step 19: Manifest Clerk Philmor
	-- {npc:268511} Manifest Clerk Philmor · {npc:483} Elaine Trias · {object:2096} Trade District
	["Off the boat, {npc:268511} stands on the harbor: his shipment goes to {npc:483}' cheese shop in the {object:2096}, beside the flight master."] = "",

	-- Step 20: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Распорядитель полетов: {zone:1453}",
	-- {npc:483} Elaine Trias
	["{npc:483}, in her cheese shop"] = "",
	-- {object:460004} Gatehouse Door (no name in this language: may be words)
	["Up the stairs in her shop: leave the shipment at the {object:460004}"] = "",

	-- Step 21: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:2096} Trade District · {zone:1436} Westfall
	["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "",

	-- Step 22: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Раз уж вы здесь: изучите {spell:202} у NPC {npc:11867} ({object:2096}, 10 серебра); с двуручным оружием воин качается быстрее всего.",

	-- Step 23: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Раз уж вы здесь: изучите владение мечами у NPC {npc:11867} ({object:2096}, 10 серебра); с мечом в правой руке разбойник стабильно качается.",

	-- Step 24: Druid trainer
	["Druid trainer"] = "Учитель друидов",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504} – {zone:1453}; в {area:87} нет учителя друидов",

	-- Step 26: Class trainer
	["Class trainer"] = "Учитель классовых навыков",

	-- Step 27: Shaman trainer
	["Shaman trainer"] = "Учитель шаманов",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446} ({zone:1426}); {area:87}: учителя шаманов нет",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Into {area:148}"] = "Путь в {area:148}",
}
