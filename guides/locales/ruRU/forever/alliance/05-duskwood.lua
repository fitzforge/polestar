-- Russian (ruRU): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {area:1002} Three Corners · {zone:1431} Duskwood · {area:42} Darkshire
	["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Идите по дороге на юг от развилки {area:1002} в зону {zone:1431}; поселок {area:42} лежит в восточной части леса.",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409} – в северной части города",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790} – таверна «Scarlet Raven»",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern"] = "{npc:265} – в своем доме у таверны",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264} – в ратуше",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268} – в доме за ратушей",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town"] = "{npc:633} – в южной части города",

	-- Step 2: Viktori Prism'Antras
	-- {npc:276} Viktori Prism'Antras · {npc:3133} Herble Baubbletump
	["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "Дом {npc:276} стоит в восточной части города. {npc:3133} продает инженерные товары в соседнем доме.",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}: продает {npc:3133}, запас ограничен. Распродано? Его же продает {npc:1448} ({area:150}).",

	-- Step 3: Tranquil Gardens Cemetery
	-- {area:42} Darkshire · {npc:302} Blind Mary · {zone:1431} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Скелеты-воины и маги-скелеты бродят среди могил к юго-востоку от поселка {area:42}, под холмом, на котором стоит дом, где живет {npc:302}. С любого скелета в зоне {zone:1431} может выпасть {item:2378}.",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: редкая добыча с существ зоны {zone:1431}",

	-- Step 5: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} стоит к югу от дороги: {area:245}.",

	-- Step 6: Raven Hill
	-- {area:94} Raven Hill · {object:673515} Memory of Valor
	["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Идите дальше на запад, к деревне {area:94}. {object:673515} светится у разрушенного дома к югу от дороги.",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{item:281046}: с объекта {object:673515}",

	-- Step 7: Raven Hill Cemetery, south
	-- {area:492} Raven Hill Cemetery
	["{area:492}, south"] = "{area:492}, юг",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Кладбище лежит к северу от деревни. В его южной части бродят ужасные скелеты и скелеты-губители. Среди могил бродит элитный противник {npc:522}: держитесь от него подальше.",

	-- Step 8: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Идите по дороге на северо-запад мимо кладбища к лагерю {npc:311} на дальнем западном краю леса. {npc:893} стоит рядом со {npc:311}.",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "Хижина отшельника стоит в лесу к северо-востоку от кладбища (ориентир: {area:492}).",

	-- Step 10: Wolves, spiders and ghouls
	["Wolves, spiders and ghouls"] = "Волки, пауки и вурдалаки",
	-- {npc:289} Abercrombie
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Бешеные лютые волки бродят по лесу вокруг кладбища и хижины, где живет {npc:289}, а голодные лютые волки – по холмам к северо-востоку от него. Карликовые ядовитые кругопряды ползают к востоку от кладбища, с них падает яд. С любого вурдалака в северной части кладбища может выпасть клык.",

	-- Step 11: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Ride back east along the road to the {area:245}."] = "Езжайте назад на восток по дороге: {area:245}.",

	-- Step 12: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "Холмик рыхлой земли – к югу от фермерского дома, у старого пня.",

	-- Step 14: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Ее дом стоит на холме к юго-востоку от поселка {area:42}, выше, чем {area:121}.",

	-- Step 16: Abercrombie
	["Ride west along the road once more."] = "Еще раз езжайте по дороге на запад.",

	-- Step 18: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Назад: {area:42}",
	-- {area:42} Darkshire
	["Ride back east to {area:42}."] = "Езжайте назад на восток, в поселок {area:42}.",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267} – в ратуше",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273} – в таверне",

	-- Step 19: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Цветки гнили",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Ужасные скелеты бродят по склону холма к юго-востоку от города, между поселком {area:42} и кладбищем ({area:121}); с них падают цветки гнили.",

	-- Step 21: Abercrombie
	["Ride west to the hermit once more."] = "Еще раз езжайте на запад к отшельнику.",

	-- Step 22: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Ребра вурдалака",
	-- {area:492} Raven Hill Cemetery
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "{area:492}, северная часть: ребро может выпасть с любого вурдалака – плотояды, костеглоды, распространители чумы и мозгоеды.",

	-- Step 24: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} прячется в доме на западной окраине деревни {area:94}.",

	-- Step 25: Sven's Camp
	-- {zone:1453} Stormwind · {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1440} Ashenvale
	["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "Дальше: город {zone:1453} для обучения, затем корабль ({area:17203} – {area:442}) и дальше в зону {zone:1440}.",

	-- Step 26: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Из деревни {area:94} езжайте по дороге на запад в зону {zone:1436}. {npc:7024} следит за башней (в ней засел {npc:7053}) с холмов сразу за границей. Ключ от башни у стража, это {npc:7051} (23-й уровень); дневник Клейвена – в сундуке на вершине.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}: в сундуке",

	-- Step 27: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Езжайте на север через Элвиннский лес в город {zone:1453}; Матиас Шоу – в ШРУ, район {object:2100}.",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: Яды и {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, в подвале казарм",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/lay – лягте рядом с NPC {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, товары для алхимиков",

	-- Step 28: Stormwind
	-- {zone:1453} Stormwind · {zone:1429} Elwynn Forest · {area:17203} Stormwind Harbor · {area:442} Auberdine
	["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Обучитесь в городе {zone:1453}, на север через зону {zone:1429}. Затем сядьте на корабль: {area:17203} – {area:442}.",
	["Level 22 and 24 spells"] = "Заклинания 22-го и 24-го уровней",

	-- Step 29: Shaman training
	["Shaman training"] = "Обучение шамана",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {area:442} Auberdine
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "В городе {zone:1453} нет учителя шаманов: в районе {object:28027} сядьте на поезд ({area:2257}) до города {zone:1455}, обучитесь у NPC {npc:258098} и вернитесь на поезде к кораблю в {area:442}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}: {spell:2842} и {item:18160}",
}
