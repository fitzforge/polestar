-- Russian (ruRU): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "",
	-- {area:69} Lakeshire · {area:42} Darkshire · {zone:1431} Duskwood
	["Back to the {area:69} gryphon master: fly to {area:42} for {zone:1431}'s second loop."] = "",
	-- {area:69} Lakeshire
	["{area:69} flight master"] = "",

	-- Step 2: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Ее дом стоит на холме к юго-востоку от поселка {area:42}, выше, чем {area:121}.",
	["Inside"] = "Внутри",
	-- {item:1946} Mary's Looking Glass · {npc:511} Insane Ghoul · {zone:1431} Duskwood
	["{item:1946}: the {npc:511} in the cemetery's crypt is level 26; it waits for the {zone:1431} return"] = "{item:1946}: {npc:511} в склепе кладбища – 26-го уровня; ждет возвращения в зону {zone:1431}",

	-- Step 3: Tranquil Gardens Cemetery
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: редкая добыча с существ зоны {zone:1431}",

	-- Step 5: Abercrombie
	["Head west along the road once more."] = "",

	-- Step 7: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Назад: {area:42}",
	-- {area:42} Darkshire
	["Head back east to {area:42}."] = "",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267} – в ратуше",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273} – в таверне",

	-- Step 8: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Цветки гнили",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Ужасные скелеты бродят по склону холма к юго-востоку от города, между поселком {area:42} и кладбищем ({area:121}); с них падают цветки гнили.",

	-- Step 10: Abercrombie
	["Head west to the hermit once more."] = "",

	-- Step 11: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Ребра вурдалака",
	-- {area:492} Raven Hill Cemetery · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "",

	-- Step 13: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "",
	-- {area:94} Raven Hill · {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Fiends = {npc:531} Skeletal Fiend · Skeletal Horrors = {npc:202} Skeletal Horror
	["Head south through the cemetery towards {area:94}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Идите на юг через кладбище к деревне {area:94}. В его южной части бродят скелеты-губители и ужасные скелеты. Среди могил бродит элитный противник {npc:522}: держитесь от него подальше.",

	-- Step 14: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} прячется в доме на западной окраине деревни {area:94}.",

	-- Step 15: Sven's Camp
	-- {zone:1453} Stormwind · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["Next: training, then the flight from {zone:1453} to {area:150} for the {zone:1437}."] = "",

	-- Step 17: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}: в сундуке",

	-- Step 18: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: Яды и {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, в подвале казарм",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/lay – лягте рядом с NPC {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, товары для алхимиков",
	-- {item:4371} Bronze Tube · {object:2096} Trade District · {npc:5519} Billibub Cogspinner
	["{item:4371}: the Auction House, {object:2096}; {npc:5519} keeps one and is nearly always sold out"] = "",

	-- Step 19: Elwynn Forest
	-- {area:94} Raven Hill · {area:87} Goldshire · {zone:1453} Stormwind
	["North from {area:94} through Elwynn: {area:87} is on the road to {zone:1453}."] = "",

	-- Step 20: Class trainer
	["Class trainer"] = "Учитель классовых навыков",
	["Level 22 and 24 spells"] = "Заклинания 22-го и 24-го уровней",

	-- Step 21: Gazin Tenorm
	-- {zone:1453} Stormwind · {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["On into {zone:1453}: {npc:6173} and {npc:6171} are in the Cathedral of Light, on the way to the gryphon master."] = "",
	["Cathedral of Light"] = "Собор Света",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: Искупление",

	-- Step 22: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 23: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Поезд до {zone:1455}",

	-- Step 24: Shaman training
	["Shaman training"] = "Обучение шамана",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "В городе {zone:1453} нет учителя шаманов: сядьте на поезд ({area:2257}) в месте {object:28027} до города {zone:1455}, обучитесь у NPC {npc:258098}, затем вернитесь на поезде.",

	-- Step 25: Rogue training
	["Rogue training"] = "",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Идите дальше на запад, к деревне {area:94}. {object:673515} светится у разрушенного дома к югу от дороги.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "{area:492}, северная часть: ребро может выпасть с любого вурдалака – плотояды, костеглоды, распространители чумы и мозгоеды.",
	-- ["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Идите по дороге на северо-запад мимо кладбища к лагерю {npc:311} на дальнем западном краю леса. {npc:893} стоит рядом со {npc:311}.",
	-- ["Follow the road south from {area:1002} into {area:10}; {area:42} lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "Идите по дороге на юг от развилки {area:1002} в зону {area:10}; поселок {area:42} лежит в восточной части леса.\nНет предмета {item:4371} для задания {quest:174}? Его продает {npc:3133} в доме рядом с домом {npc:276}, запас ограничен; его же продает {npc:1448} ({area:150}).\nДом {npc:276} стоит в восточной части города. {npc:3133} продает инженерные товары в соседнем доме.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Идите по дороге на юг от развилки {area:1002} в зону {zone:1431}; поселок {area:42} лежит в восточной части леса.",
	-- ["For {npc:302}, on the hill south-east of town"] = "Для NPC {npc:302} – на холме к юго-востоку от города",
	-- ["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "Дальше: город {zone:1453} для обучения, затем корабль ({area:17203} – {area:442}) и дальше в зону {zone:1440}.",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Бешеные лютые волки бродят по лесу вокруг кладбища и хижины, где живет {npc:289}, а голодные лютые волки – по холмам к северо-востоку от него. Карликовые ядовитые кругопряды ползают к востоку от кладбища, с них падает яд. С любого вурдалака в северной части кладбища может выпасть клык.",
	-- ["Ride back east along the road to the {area:245}."] = "Езжайте назад на восток по дороге: {area:245}.",
	-- ["Ride back east to {area:42}."] = "Езжайте назад на восток, в поселок {area:42}.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Езжайте на север через Элвиннский лес в город {zone:1453}; Матиас Шоу – в ШРУ, район {object:2100}.",
	-- ["Ride west along the road once more."] = "Еще раз езжайте по дороге на запад.",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Из деревни {area:94} езжайте по дороге на запад в зону {zone:1436}. {npc:7024} следит за башней (в ней засел {npc:7053}) с холмов сразу за границей. Ключ от башни у стража, это {npc:7051} (23-й уровень); дневник Клейвена – в сундуке на вершине.",
	-- ["Ride west to the hermit once more."] = "Еще раз езжайте на запад к отшельнику.",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Скелеты-воины и маги-скелеты бродят среди могил к юго-востоку от поселка {area:42}, под холмом, на котором стоит дом, где живет {npc:302}. С любого скелета в зоне {zone:1431} может выпасть {item:2378}.",
	-- ["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Кладбище лежит к северу от деревни. В его южной части бродят ужасные скелеты и скелеты-губители. Среди могил бродит элитный противник {npc:522}: держитесь от него подальше.",
	-- ["The hermit's shack stands in the woods north-east of the {area:492}."] = "Хижина отшельника стоит в лесу к северо-востоку от кладбища (ориентир: {area:492}).",
	-- ["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "Холмик рыхлой земли – к югу от фермерского дома, у старого пня.",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Обучитесь в городе {zone:1453}, на север через зону {zone:1429}. Затем сядьте на корабль: {area:17203} – {area:442}.",
	-- ["Wolves, spiders and ghouls"] = "Волки, пауки и вурдалаки",
	-- ["{area:492}, south"] = "{area:492}, юг",
	-- ["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "{item:1130}: карликовые ядовитые кругопряды, ядовитые кругопряды и зеленые отшельники",
	-- ["{item:281046}, from the {object:673515}"] = "{item:281046}: с объекта {object:673515}",
	-- ["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}: продает {npc:3133}, запас ограничен. Распродано? Его же продает {npc:1448} ({area:150}).",
	-- ["{npc:2409}, at the north end of town"] = "{npc:2409} – в северной части города",
	-- ["{npc:264}, in the town hall"] = "{npc:264} – в ратуше",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265} – в своем доме у таверны",
	-- ["{npc:268}, in the house behind the town hall"] = "{npc:268} – в доме за ратушей",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "Дом {npc:276} стоит в восточной части города. {npc:3133} продает инженерные товары в соседнем доме.",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}: {spell:2842} и {item:18160}",
	-- ["{npc:633}, at the south end of town"] = "{npc:633} – в южной части города",
	-- ["{npc:663}, by the town hall: from level 23; the {area:10} return hunts the worgen"] = "{npc:663} – у ратуши: с 23-го уровня; охота на воргенов – при возвращении в зону {area:10}",
	-- ["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790} – таверна «Scarlet Raven»",
	-- ["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} стоит к югу от дороги: {area:245}.",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: редкая добыча с существ зоны {zone:1431}",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "В городе {zone:1453} нет учителя шаманов: в районе {object:28027} сядьте на поезд ({area:2257}) до города {zone:1455}, обучитесь у NPC {npc:258098} и вернитесь на поезде к кораблю в {area:442}.",
}
