-- Russian (ruRU): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Orgrimmar
	-- {area:1637} Orgrimmar
	["To {area:1637}"] = "В {area:1637}",
	-- {area:380} Crossroads · {area:1637} Orgrimmar · {npc:3310} Doras · {object:172982} Valley of Strength
	["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "От поселения {area:380} идите по дороге на северо-восток: {area:1637}, вход через главные ворота. {npc:3310}, распорядитель полетов, стоит на башне ({object:172982}).",

	-- Step 2: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Классовые задания: {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} – {object:172961}, на западе города.",

	-- Step 3: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Летите: {area:1638}. {npc:3033} обучает вас – {area:1639}. Небеснорожденные: затем летите обратно в {zone:1454} к дирижаблю.",

	-- Step 4: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Примените {spell:18960}; {npc:11802} – {area:2361}. Безделушки из святилища ({item:15877}) лежат на дне: {area:656} – и исчезают за несколько минут: плывите с одной прямо к месту {area:2362} на северо-западном берегу, используйте ее там и поговорите с NPC {npc:11799}.",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, следующий гайд",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, {area:2362}",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven · {zone:1454} Orgrimmar
	["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798} ({area:2361}) отвозит туда друидов; затем летите в {zone:1454} к дирижаблю",

	-- Step 5: Zeppelin to Tirisfal Glades
	-- {zone:1420} Tirisfal Glades
	["Zeppelin to {zone:1420}"] = "Дирижабль: {zone:1420}",
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {object:3202} Grom'gol
	["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "Башни дирижаблей стоят сразу за главными воротами города {zone:1454}. Садитесь на дирижабль в зону {zone:1420} (другой летит в {object:3202}).",
	["Zeppelin tower"] = "Башня дирижаблей",

	-- Step 6: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} обучает паладинов – {area:159}, недалеко на север по дороге от башен дирижаблей. Возвращайтесь по той же дороге в Серебряный бор.",

	-- Step 7: Into Silverpine
	["Into Silverpine"] = "В Серебряный бор",
	-- {area:153} Ruins of Lordaeron · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "Дирижабль приземляется у башен за пределами места {area:153}. Идите на запад по дороге мимо руин и на юг: {zone:1421}; по дороге дойдите до места {area:228}.",
	["Road to Silverpine"] = "Дорога в Серебряный бор",

	-- Step 8: Sepulcher
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} – городок Отрекшихся у склепа посреди леса. Все нужные NPC стоят у входа в склеп; {npc:2226}, укротитель летучих мышей, – чуть к востоку.",

	-- Step 9: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "Идите по дороге на юг. {object:1627} стоит у дороги, к северу от Деревни Погребальных Костров.",

	-- Step 10: Sepulcher
	-- {area:233} Ambermill
	["{area:233} comes later, on the southern loop"] = "{area:233} – позже, на южном круге",

	-- Step 11: The Dead Field
	-- {area:228} Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "К северу от места {area:228}. {npc:1983} бродит по {area:240}: убейте ее, затем пройдите через поле.",

	-- Step 12: Strange Lockbox
	-- {object:177790} Strange Lockbox · {area:240} The Dead Field · {item:15882} Half Pendant of Aquatic Endurance · {quest:30} Trial of the Sea Lion
	["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790} лежит на побережье к западу от {area:240}. В нем {item:15882} для задания {quest:30}.",

	-- Step 13: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Идите по дороге на северо-восток к дому Йориков: {area:238}.",

	-- Step 14: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} ждет к северо-востоку от дома. Проводите его к NPC {npc:1950}; по пути нападают ворги.",

	-- Step 16: Worgs and murlocs
	["Worgs and murlocs"] = "Ворги и мурлоки",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg · Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Крапчатые ворги ({npc:1766}) рыщут по холмам вокруг дома. Затем идите на юг вдоль берега озера: живорезы ({npc:1767}) и волноловы из племени Злобного Плавника роняют глаза мурлоков.",

	-- Step 17: Hearth to the Sepulcher
	-- {area:228} Sepulcher
	["Hearth to the {area:228}"] = "Камень возвращения: {area:228}",

	-- Step 18: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:228} Sepulcher
	["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593} лежит у паромной пристани на берегу озера к востоку от места {area:228}.",

	-- Step 20: The Ivar Patch
	-- {quest:425} Ivar the Foul
	["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "Снова на север к дому Йориков. {quest:425} прячется недалеко к западу от него.",

	-- Step 21: Fenris Isle
	-- {area:172} Fenris Isle · {area:235} Fenris Keep
	["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Идите вдоль берега озера на юго-восток и плывите: {area:172}. Остров заполнен гноллами из стаи Гнилошкуров; ихор падает со всех. Не заходите в {area:235} на северной стороне, если не идете за дополнительной нишей: гноллы там 18-22 уровня.",
	-- {item:3317} A Talking Head
	["{item:3317}: a rare drop from the gnolls"] = "{item:3317}: редкая добыча с гноллов",
	-- {object:1599} Shallow Grave
	["{object:1599}, just east of the keep"] = "{object:1599}, сразу к востоку от крепости",
	-- {object:112888} Dusty Shelf
	["{object:112888}, inside the keep"] = "{object:112888}, внутри крепости",

	-- Step 22: Sepulcher
	-- {area:228} Sepulcher
	["Swim back and follow the road west to the {area:228}."] = "Плывите обратно и идите по дороге на запад: {area:228}.",
	-- {npc:2121} Shadow Priest Allister · {quest:516} Beren's Peril
	["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}: {quest:516}, на южном круге",
	-- {npc:1938} Dalar Dawnweaver · {quest:98298} Arugal's Folly
	["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}: возьмите, если предложит; может идти после его серии {quest:98298}, которую маршрут не проходит",

	-- Step 23: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "На юго-восток по дороге: {area:233}. Заступники охраняют окраины, маги – город; с обоих падают подвески. Волшебники и дозорные патрулируют дороги вокруг. Держитесь подальше от центра, где стоит {npc:2120}.",

	-- Step 24: Moonrage Bloodhowlers
	-- plural, as words: Moonrage Bloodhowlers = {npc:1924} Moonrage Bloodhowler
	["Moonrage Bloodhowlers"] = "Кровавые ревуны Лунной Ярости ({npc:1924})",
	-- {npc:1938} Dalar Dawnweaver · {quest:98298} Arugal's Folly · {area:233} Ambermill · {item:280375} Worgen Bits
	["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Только если {npc:1938} дал вам {quest:98298}: кровавые ревуны рыщут в лесу к юго-западу от места {area:233}, к востоку от Деревни Погребальных Костров; с них падает {item:280375}.",

	-- Step 25: The refugees
	["The refugees"] = "Беженцы",
	-- {area:230} Greymane Wall
	-- plural, as words: Haggard Refugees = {npc:2053} Haggard Refugee
	["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Больные и изможденные беженцы ({npc:2053}) бредут по дороге к югу от Деревни Погребальных Костров в сторону места {area:230}.",

	-- Step 26: Beren's Peril
	-- {quest:516} Beren's Peril
	-- plural, as words: Ravenclaw Drudgers = {npc:1974} Ravenclaw Drudger
	["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "К северо-востоку от беженцев чернорабочие ({npc:1974}) и стражи Когтя Ворона бродят по руинам ({quest:516}) на юго-востоке леса.",

	-- Step 28: Lordamere Lake shore
	-- {area:1338} Lordamere Lake
	["{area:1338} shore"] = "Берег: {area:1338}",
	-- {area:237} Decrepit Ferry · {area:228} Sepulcher
	-- plural, as words: Vile Fin Lakestalkers = {npc:1909} Vile Fin Lakestalker
	["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Охотники ({npc:1909}) и оракулы из племени Злобного Плавника сидят на берегу озера к югу от места {area:237}, к востоку от места {area:228}.",
	-- {npc:1909} Vile Fin Lakestalker · {area:1338} Lordamere Lake · {zone:1421} Silverpine Forest
	["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "бейте NPC {npc:1909} – {area:1338}, {zone:1421}",

	-- Step 29: Apothecary Renferrel
	-- {npc:2216} Apothecary Lydon · {area:272} Tarren Mill
	["Keep it: {npc:2216} in {area:272}, a later guide"] = "Сохраните: {npc:2216} – {area:272}, в одном из следующих гайдов",

	-- Step 30: Brill
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Идите по дороге на север из Серебряного бора в зону {zone:1420} и дальше: {area:159}. {npc:246152} обучает там паладинов. Башни дирижаблей – недалеко на юг по дороге.",

	-- Step 31: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",
	-- {zone:1420} Tirisfal Glades · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar
	["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Идите по дороге на север из Серебряного бора в зону {zone:1420} и на восток к башням дирижаблей у места {area:153}. Садитесь на дирижабль: {zone:1454}.",

	-- Step 32: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength · {object:173016} Borstan's Firepit
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "Войдите через главные ворота. {npc:268701} стоит здесь: {object:172982}; {object:173016} – в нескольких шагах к северу.",

	-- Step 33: Cleft of Shadow
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:3216} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {npc:3216} stands at its far end."] = "{object:172960} – ущелье под местом {object:172982}; {npc:3216} стоит в дальнем конце.",

	-- Step 34: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} и {npc:3347} держат лавку алхимии на Волоке; {npc:11046} – по соседству.",

	-- Step 35: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "Рогоз и копейник растут вдоль воды – {object:172958}, к востоку от Волока.",

	-- Step 37: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {npc:3310} Doras · {object:172982} Valley of Strength
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684} и {npc:268682} сидят за Крепостью Громмаш – {object:172957}; гладкие валуны ({item:277952}) лежат вокруг них. Обучитесь, пока вы в городе (у друидов и паладинов здесь учителя нет). Следующий гайд начинается у NPC {npc:3310}, распорядителя полетов ({object:172982}).",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, внутри Крепости Громмаш",
	-- {area:380} Crossroads
	["Keep it: Thork at the {area:380}"] = "Сохраните: Торк – {area:380}",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}: {quest:93739}, обход вождей Орды",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Поговорите с NPC {npc:3230} в Крепости Громмаш",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Поговорите с NPC {npc:10540} в Крепости Громмаш",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "К северу от места {area:228}. Плеть ночи бродит здесь: {area:240}. Убейте ее, затем пройдите через поле.",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for {quest:30}."] = "{object:177790} лежит на побережье к западу от места {area:240}. В нем {item:15882} для задания {quest:30}.",
	-- ["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} – городок Отрекшихся у склепа посреди леса. Все нужные NPC стоят у входа в склеп; {npc:2226}, укротитель летучих мышей, – чуть к востоку.",
}
