-- Russian (ruRU): the guide forever/horde/03-silverpine-forest (forever/horde/03-silverpine-forest.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Orgrimmar
	-- {npc:3310} Doras · {object:172982} Valley of Strength · {npc:268701} Thatog
	["Walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}; {npc:268701} by the bank below it."] = "",

	-- Step 2: Borstan
	-- {object:173016} Borstan's Firepit
	["{object:173016} is a few steps north."] = "",

	-- Step 3: Neeru Fireblade
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:829} Neeru Fireblade
	["The {object:172960} is the canyon under the {object:172982}; {quest:829} stands at its far end."] = "{object:172960} – ущелье под местом {object:172982}; {quest:829} стоит в дальнем конце.",

	-- Step 4: The Drag
	-- {npc:3348} Kor'geld · {npc:3347} Yelmak · {npc:11046} Whuut
	["{npc:3348} and {npc:3347} run the alchemy shop in the Drag; {npc:11046} is next door."] = "{npc:3348} и {npc:3347} держат лавку алхимии на Волоке; {npc:11046} – по соседству.",

	-- Step 5: Valley of Honor
	-- {object:172958} Valley of Honor
	["The cattails and speargrass grow along the water in the {object:172958}, east of the Drag."] = "Рогоз и копейник растут вдоль воды – {object:172958}, к востоку от Волока.",

	-- Step 6: Class trainer
	["Class trainer"] = "Учитель классовых навыков",
	["Train while you are in the city: Druids and Paladins have no trainer here."] = "",

	-- Step 7: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 8: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 9: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 12: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them."] = "",

	-- Step 13: Thrall
	-- {npc:4949} Thrall · {quest:98024} Journey to the Crossroads · {quest:93739} Exploring the Horde · {quest:95350} Welcome to Azeroth
	["{npc:4949} stands in Grommash Hold. He offers {quest:98024} and {quest:93739} once {quest:95350} is handed in."] = "",
	-- {npc:4949} Thrall
	["{npc:4949}, inside Grommash Hold"] = "{npc:4949}, внутри Крепости Громмаш",
	-- {npc:4949} Thrall · {zone:1413} Barrens
	["{npc:4949}: keep it, Thork at the Crossroads in the {zone:1413} guide"] = "",
	-- {npc:4949} Thrall · {quest:93739} Exploring the Horde
	["{npc:4949}: {quest:93739}, a tour of the Horde's leaders"] = "{npc:4949}: {quest:93739}, обход вождей Орды",
	-- {npc:3230} Nazgrel
	["Speak with {npc:3230}, in Grommash Hold"] = "Поговорите с NPC {npc:3230} в Крепости Громмаш",
	-- {npc:3230} Nazgrel
	["Talk to {npc:3230}"] = "",
	-- {npc:10540} Vol'jin
	["Speak with {npc:10540}, in Grommash Hold"] = "Поговорите с NPC {npc:10540} в Крепости Громмаш",
	-- {npc:10540} Vol'jin
	["Talk to {npc:10540}"] = "",

	-- Step 14: Nazgrel
	-- {npc:3230} Nazgrel
	["{npc:3230}, in Grommash Hold"] = "",

	-- Step 15: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 16: Brill
	-- {area:159} Brill · {npc:1738} Deathguard Terrence · {npc:1518} Apothecary Johaan
	["{area:159} is a short walk north up the road from the zeppelin towers: {npc:1738} stands by the road into town, {npc:1518} in the apothecary's house on the west side of the square."] = "",
	-- {npc:1518} Apothecary Johaan
	["{npc:1518}, inside"] = "",

	-- Step 17: Hadric Harlson
	-- {npc:1495} Deathguard Linnea · {npc:267009} Hadric Harlson
	["Back down the road past the zeppelin towers and east to {npc:1495}'s camp: {npc:267009} stands beside her."] = "",

	-- Step 18: The Cult of the Damned
	-- {npc:267009} Hadric Harlson
	-- plural, as words: Dark Neophytes = {npc:267006} Dark Neophyte · Dark Enforcers = {npc:275437} Dark Enforcer · Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["The cultists camp a short walk south-east of {npc:267009}. Dark Neophytes and Dark Enforcers drop the Necrotic Crystal Fragments; more fragments, black crystals, lie on the ground among the tents."] = "",

	-- Step 20: Brill
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152} trains Paladins in {area:159}, a short walk north up the road from the zeppelin towers. Come back down the same road for Silverpine."] = "{npc:246152} обучает паладинов – {area:159}, недалеко на север по дороге от башен дирижаблей. Возвращайтесь по той же дороге в Серебряный бор.",

	-- Step 22: The Sepulcher
	-- {area:228} The Sepulcher · {npc:2226} Karos Razok
	["{area:228} is the Forsaken crypt-town in the middle of the forest. Everyone you need stands around the crypt entrance; {npc:2226}, the bat handler, is just east of it."] = "{area:228} – городок Отрекшихся у склепа посреди леса. Все нужные NPC стоят у входа в склеп; {npc:2226}, укротитель летучих мышей, – чуть к востоку.",
	-- {npc:1952} High Executor Hadrec
	["{npc:1952}, below ground"] = "",

	-- Step 24: Border Crossings
	-- {object:1627} Dalaran Crate
	["Follow the road south. The {object:1627} sits beside it, north of Pyrewood."] = "Идите по дороге на юг. {object:1627} стоит у дороги, к северу от Деревни Погребальных Костров.",

	-- Step 25: The Dead Field
	-- {area:228} The Sepulcher · {npc:1983} Nightlash · {area:240} The Dead Field
	["North of the {area:228}. {npc:1983} haunts the {area:240}: kill it, then walk across the field."] = "К северу от места {area:228}. {npc:1983} бродит по {area:240}: убейте ее, затем пройдите через поле.",

	-- Step 26: Malden's Orchard
	-- {area:238} Malden's Orchard
	["Follow the road north-east to the Yoricks' house at {area:238}."] = "Идите по дороге на северо-восток к дому Йориков: {area:238}.",

	-- Step 27: Mottled Worgs
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs"] = "Крапчатые ворги",
	-- plural, as words: Mottled Worgs = {npc:1766} Mottled Worg
	["Mottled Worgs prowl the hills around the house."] = "Крапчатые ворги рыщут по холмам вокруг дома.",

	-- Step 28: Escorting Erland
	-- {npc:1978} Deathstalker Erland · {npc:1950} Rane Yorick
	["{npc:1978} waits north-east of the house. Escort him back to {npc:1950}; worgs attack on the way."] = "{npc:1978} ждет к северо-востоку от дома. Проводите его к NPC {npc:1950}; по пути нападают ворги.",
	-- {npc:1978} Deathstalker Erland
	["{npc:1978}, inside"] = "",

	-- Step 31: The Sepulcher
	-- {npc:1938} Dalar Dawnweaver · {area:227} Valgan's Field
	["{npc:1938}: his books lie in the {area:227} farmhouse, on the walk north"] = "",
	-- {npc:1937} Apothecary Renferrel · {zone:1458} Undercity
	["{npc:1937}: Zinge in the {zone:1458}, on the way to the zeppelin at the end"] = "",
	-- {area:233} Ambermill
	["{area:233} comes later, down the lake shore"] = "",

	-- Step 32: Valgan's Field farmhouse
	-- {area:227} Valgan's Field
	["{area:227} farmhouse"] = "",
	-- {area:227} Valgan's Field · {object:1571} Dusty Spellbooks · {npc:1770} Moonrage Darkrunner
	["On the road north, the farmhouse at {area:227}: go upstairs, the {object:1571} lie on the floor in the back room. Looting them brings a {npc:1770}."] = "",
	-- {object:1571} Dusty Spellbooks
	["{object:1571}; upstairs"] = "",

	-- Step 33: Quinn Yorick
	["North again to the Yoricks' house."] = "Снова на север к дому Йориков.",
	-- {npc:1951} Quinn Yorick
	["{npc:1951}, inside"] = "",

	-- Step 34: Vile Fin murlocs
	["Vile Fin murlocs"] = "Мурлоки из племени Злобного Плавника",
	-- plural, as words: Vile Fin Shredders = {npc:1767} Vile Fin Shredder
	["Follow the lake shore south-east from the Yoricks' house: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "",

	-- Step 35: The Decrepit Ferry
	-- {object:1593} Corpse Laden Boat · {area:233} Ambermill
	["Follow the lake shore south from the murlocs: the {object:1593} lies at the ferry landing, on the way to {area:233}."] = "",

	-- Step 36: Ambermill
	-- {area:233} Ambermill · {npc:2120} Archmage Ataeric
	["Keep south along the shore from the ferry to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Stay out of the middle, where {npc:2120} stands."] = "",

	-- Step 37: The Sepulcher
	-- {area:228} The Sepulcher
	["Back north-west up the road to the {area:228}."] = "Обратно на северо-запад по дороге: {area:228}.",
	-- {npc:1937} Apothecary Renferrel
	["{npc:1937}: for Quinn, on the road north at the end"] = "{npc:1937}: для Квинна, на дороге на север в конце",
	-- {npc:1938} Dalar Dawnweaver
	["{npc:1938}, just north of Allister"] = "",
	-- {npc:1499} Magistrate Sevren · {area:159} Brill
	["{npc:1499} in {area:159}, on the way to the zeppelin at the end"] = "",

	-- Step 38: The Ivar Patch
	-- {zone:1420} Tirisfal Glades · {area:238} Malden's Orchard · {quest:425} Ivar the Foul
	["Take the road north toward {zone:1420}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Идите по дороге на север ({zone:1420}): дом Йориков ({area:238}) по пути. {quest:425} прячется недалеко к западу от него.",
	["Inside"] = "Внутри",

	-- Step 40: Magistrate Sevren
	-- {area:159} Brill · {npc:1499} Magistrate Sevren
	["{area:159} is a short walk north up the road from the zeppelin towers; {npc:1499} is in the town hall."] = "",

	-- Step 42: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:2050} Raleigh Andrean · {npc:7683} Alessandro Luca · {npc:11044} Doctor Martin Felben · {npc:5204} Apothecary Zinge · {npc:2055} Master Apothecary Faranell
	["{object:1661} lies under the {area:153}, beside the zeppelin towers. {npc:2050} stands at the inn by the way down; {npc:7683} on the way down to the Apothecarium, where {npc:11044} and {npc:5204} stand beside {npc:2055}."] = "",
	-- {npc:11044} Doctor Martin Felben
	["{npc:11044}, in the Apothecarium"] = "{npc:11044}, в Районе Фармацевтов",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, in the Apothecarium"] = "",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}: Helbrim at the Crossroads, in the next guide"] = "",
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093}, the {area:1497}'s paladin trainer"] = "",

	-- Step 43: Lady Sylvanas Windrunner
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter
	["{npc:10181} holds court in the {object:36126}."] = "",
	-- {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {quest:93739} Exploring the Horde
	["Speak with {npc:10181}, in the {object:36126}: {quest:93739}"] = "Поговорите с NPC {npc:10181} ({object:36126}): {quest:93739}",
	-- {npc:10181} Lady Sylvanas Windrunner
	["Talk to {npc:10181}"] = "",

	-- Step 44: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 45: Orgrimmar
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{zone:1454}'s {object:172982}"] = "",

	-- Step 46: Valley of Strength
	-- {npc:268701} Thatog · {object:172982} Valley of Strength
	["Walk in through the main gate. {npc:268701} stands in the {object:172982}."] = "",

	-- Step 52: Sayoc
	-- {spell:197} Two-Handed Axes · {npc:11868} Sayoc · {object:172958} Valley of Honor
	["While you're here: learn {spell:197} from {npc:11868} ({object:172958}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 54: Valley of Wisdom
	-- {npc:268684} Thra · {npc:268682} Migi · {object:172957} Valley of Wisdom · {area:379} Far Watch Post
	-- plural, as words: Smooth Boulders = {item:277952} Smooth Boulder
	["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide walks from here to {area:379} and the Crossroads."] = "",

	-- Step 55: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {npc:4049} Seereth Stonebreak
	["{npc:4047}: {npc:4049}, on the road into Stonetalon in the next guide"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At the {area:2362}"] = "Здесь: {area:2362}",
	-- ["Cast {spell:18960}; {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Примените {spell:18960}; {npc:11802} – {area:2361}. Безделушки из святилища ({item:15877}) лежат на дне: {area:656} – и исчезают за несколько минут: плывите с одной прямо к месту {area:2362} на северо-западном берегу, используйте ее там и поговорите с NPC {npc:11799}.",
	-- ["Cast {spell:18960}; {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Примените {spell:18960}; {npc:11802} стоит наверху в своем здании – {area:2361}: поднимитесь внутри, стрелка не различает этажи. Безделушки из святилища лежат на дне: {area:656} – и исчезают за несколько минут: плывите с одной прямо к месту {area:2362} на северо-западном берегу, используйте ее там и поговорите с NPC {npc:11799}.",
	-- ["Druid trainer"] = "Учитель друидов",
	-- ["Fly to {area:1637}"] = "Летите: {area:1637}",
	-- ["Fly to {area:1638}: {npc:3033} trains you on {area:1639}. Skyborne: fly back to {zone:1454} for the zeppelin afterwards."] = "Летите: {area:1638}. {npc:3033} обучает вас – {area:1639}. Небеснорожденные: затем летите обратно в {zone:1454} к дирижаблю.",
	-- ["Follow the lake shore south-east and swim out to {area:172}. Rot Hide gnolls cover the island; every type drops ichor. Stay out of {area:235} on its north side unless you go for the optional niche: the gnolls there are level 18-22."] = "Идите вдоль берега озера на юго-восток и плывите: {area:172}. Остров заполнен гноллами из стаи Гнилошкуров; ихор падает со всех. Не заходите в {area:235} на северной стороне, если не идете за дополнительной нишей: гноллы там 18-22 уровня.",
	-- ["Follow the lake shore south-east toward {area:172}: the Vile Fin Shredders and Tidehunters along it drop the murloc eyes."] = "Идите вдоль берега озера на юго-восток ({area:172}): живорезы и волноловы из племени Злобного Плавника на берегу роняют глаза мурлоков.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and east to the zeppelin towers outside the {area:153}. Take the zeppelin to {zone:1454}."] = "Идите по дороге на север из Серебряного бора в зону {zone:1420} и на восток к башням дирижаблей у места {area:153}. Садитесь на дирижабль: {zone:1454}.",
	-- ["Follow the road north out of Silverpine into {zone:1420} and on to {area:159}: {npc:246152} trains Paladins there. The zeppelin towers are a short walk south down the road."] = "Идите по дороге на север из Серебряного бора в зону {zone:1420} и дальше: {area:159}. {npc:246152} обучает там паладинов. Башни дирижаблей – недалеко на юг по дороге.",
	-- ["From the {area:380}, follow the road north-east to {area:1637} and walk in by the main gate. {npc:3310}, the wind rider master, stands on the tower in the {object:172982}."] = "От поселения {area:380} идите по дороге на северо-восток: {area:1637}, вход через главные ворота. {npc:3310}, распорядитель полетов, стоит на башне ({object:172982}).",
	-- ["Hearth to the {area:228}"] = "Камень возвращения: {area:228}",
	-- ["Into Silverpine"] = "В Серебряный бор",
	-- ["Keep it: Thork at the {area:380}"] = "Сохраните: Торк – {area:380}",
	-- ["Keep it: {npc:2216} in {area:272}, a later guide"] = "Сохраните: {npc:2216} – {area:272}, в одном из следующих гайдов",
	-- ["Moonrage Bloodhowlers"] = "Кровавые ревуны Лунной Ярости ({npc:1924})",
	-- ["Mottled Worgs prowl the hills around the house. Then walk south along the lake shore: the Vile Fin Shredders and Tidehunters there drop the murloc eyes."] = "Крапчатые ворги ({npc:1766}) рыщут по холмам вокруг дома. Затем идите на юг вдоль берега озера: живорезы ({npc:1767}) и волноловы из племени Злобного Плавника роняют глаза мурлоков.",
	-- ["North again to the Yoricks' house. {quest:425} lurks a short walk west of it."] = "Снова на север к дому Йориков. {quest:425} прячется недалеко к западу от него.",
	-- ["North of the {area:228}. Nightlash haunts the {area:240}: kill it, then walk across the field."] = "К северу от места {area:228}. Плеть ночи бродит здесь: {area:240}. Убейте ее, затем пройдите через поле.",
	-- ["North-east of the refugees, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "К северо-востоку от беженцев чернорабочие ({npc:1974}) и стражи Когтя Ворона бродят по руинам ({quest:516}) на юго-востоке леса.",
	-- ["Only if {npc:1938} gave you {quest:98298}: the Bloodhowlers prowl the woods south-west of {area:233}, east of Pyrewood; they drop the {item:280375}."] = "Только если {npc:1938} дал вам {quest:98298}: кровавые ревуны рыщут в лесу к юго-западу от места {area:233}, к востоку от Деревни Погребальных Костров; с них падает {item:280375}.",
	-- ["Road to Silverpine"] = "Дорога в Серебряный бор",
	-- ["South down the shore to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "На юг вдоль берега: {area:233}. Заступники охраняют окраины, маги – город; с обоих падают подвески. Волшебники и дозорные патрулируют дороги вокруг. Держитесь подальше от центра, где стоит {npc:2120}.",
	-- ["South-east down the road to {area:233}. Protectors guard the outskirts and Mages the town; both drop pendants. Wizards and Watchers patrol the roads around it. Stay out of the middle, where {npc:2120} stands."] = "На юго-восток по дороге: {area:233}. Заступники охраняют окраины, маги – город; с обоих падают подвески. Волшебники и дозорные патрулируют дороги вокруг. Держитесь подальше от центра, где стоит {npc:2120}.",
	-- ["South-west of Ambermill, the Ravenclaw Drudgers and Guardians haunt the ruins of {quest:516} in the south-east of the forest."] = "К юго-западу от Янтарной мельницы, в руинах {quest:516} на юго-востоке леса, бродят чернорабочие и стражи Когтя Ворона.",
	-- ["Swim back and follow the road west to the {area:228}."] = "Плывите обратно и идите по дороге на запад: {area:228}.",
	-- ["Swim back to the shore and follow it south: the Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, on the way to {area:233}."] = "Плывите обратно к берегу и идите по нему на юг: охотники и оракулы из племени Злобного Плавника сидят на берегу озера к югу от места {area:237}, по пути: {area:233}.",
	-- ["Take the road north toward {area:85}: the Yoricks' house at {area:238} is on the way. {quest:425} lurks a short walk west of it."] = "Идите по дороге на север ({area:85}): дом Йориков ({area:238}) по пути. {quest:425} прячется недалеко к западу от него.",
	-- ["The Sickly and Haggard Refugees shamble along the road south of Pyrewood toward the {area:230}."] = "Больные и изможденные беженцы ({npc:2053}) бредут по дороге к югу от Деревни Погребальных Костров в сторону места {area:230}.",
	-- ["The Vile Fin Lakestalkers and Oracles sit on the lake shore south of the {area:237}, east of the {area:228}."] = "Охотники ({npc:1909}) и оракулы из племени Злобного Плавника сидят на берегу озера к югу от места {area:237}, к востоку от места {area:228}.",
	-- ["The refugees"] = "Беженцы",
	-- ["The zeppelin lands at the towers outside the {area:153}. Walk west along the road past the ruins and south into {zone:1421}; follow the road to the {area:228}."] = "Дирижабль приземляется у башен за пределами места {area:153}. Идите на запад по дороге мимо руин и на юг: {zone:1421}; по дороге дойдите до места {area:228}.",
	-- ["The zeppelin towers stand just outside {zone:1454}'s main gate. Take the zeppelin to {zone:1420} (the other one goes to {object:3202})."] = "Башни дирижаблей стоят сразу за главными воротами города {zone:1454}. Садитесь на дирижабль в зону {zone:1420} (другой летит в {object:3202}).",
	-- ["The {area:228}"] = "{area:228}",
	-- ["The {object:1593} lies at the ferry landing on the lake shore east of the {area:228}."] = "{object:1593} лежит у паромной пристани на берегу озера к востоку от места {area:228}.",
	-- ["The {object:177790} lies on the coast west of the {area:240}. It holds the {item:15882} for Trial of the Sea Lion."] = "{object:177790} лежит на побережье к западу от {area:240}. В нем {item:15882} для задания Испытание Морского Льва.",
	-- ["To {area:1637}"] = "В {area:1637}",
	-- ["Walk in through the main gate. {npc:268701} stands in the {object:172982}; {object:173016} is a few steps north."] = "Войдите через главные ворота. {npc:268701} стоит здесь: {object:172982}; {object:173016} – в нескольких шагах к северу.",
	-- ["Worgs and murlocs"] = "Ворги и мурлоки",
	-- ["Zeppelin to {zone:1420}"] = "Дирижабль: {zone:1420}",
	-- ["Zeppelin tower"] = "Башня дирижаблей",
	-- ["grind on {npc:1909} at {area:1338}, {zone:1421}"] = "бейте NPC {npc:1909} – {area:1338}, {zone:1421}",
	-- ["{area:1338} shore"] = "Берег: {area:1338}",
	-- ["{area:1637} flight master"] = "Распорядитель полетов: {area:1637}",
	-- ["{area:233} comes later, on the southern loop"] = "{area:233} – позже, на южном круге",
	-- ["{item:15877}, from a {object:177785} in the lake"] = "{item:15877} – из объекта {object:177785} в озере",
	-- ["{item:3317}: a rare drop from the gnolls"] = "{item:3317}: редкая добыча с гноллов",
	-- ["{npc:11798} in {area:2361} flies druids there; then fly on to {zone:1454} for the zeppelin"] = "{npc:11798} ({area:2361}) отвозит туда друидов; затем летите в {zone:1454} к дирижаблю",
	-- ["{npc:11799}, at the {area:2362}"] = "{npc:11799}, {area:2362}",
	-- ["{npc:1938}: take it if he offers it; it may follow his {quest:98298} series, which the route does not run"] = "{npc:1938}: возьмите, если предложит; может идти после его серии {quest:98298}, которую маршрут не проходит",
	-- ["{npc:2121}: {quest:516}, on the south loop"] = "{npc:2121}: {quest:516}, на южном круге",
	-- ["{npc:2121}: {quest:516}, on the southern loop"] = "{npc:2121}: {quest:516}, на южном круге",
	-- ["{npc:268684} and {npc:268682} sit behind Grommash Hold in the {object:172957}; the Smooth Boulders lie around them. Train while you are in the city (Druids and Paladins have no trainer here). The next guide starts at {npc:3310}, the wind rider master in the {object:172982}."] = "{npc:268684} и {npc:268682} сидят за Крепостью Громмаш – {object:172957}; гладкие валуны ({item:277952}) лежат вокруг них. Обучитесь, пока вы в городе (у друидов и паладинов здесь учителя нет). Следующий гайд начинается у NPC {npc:3310}, распорядителя полетов ({object:172982}).",
	-- ["{npc:4949} offers {quest:98024} and {quest:93739} once {quest:95350} is handed in to him."] = "{npc:4949} предлагает задания {quest:98024} и {quest:93739}, когда вы сдадите ему {quest:95350}.",
	-- ["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} – {object:172961}, на западе города.",
	-- ["{object:112888}, inside the keep"] = "{object:112888}, внутри крепости",
	-- ["{object:1599}, just east of the keep"] = "{object:1599}, сразу к востоку от крепости",
	-- ["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, следующий гайд",
	-- ["{zone:1454} class quests"] = "Классовые задания: {zone:1454}",
}
