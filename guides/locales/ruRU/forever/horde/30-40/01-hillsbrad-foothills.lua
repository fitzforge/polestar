-- Russian (ruRU): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Freewind Post flight master
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 2: Thunder Bluff
	-- {area:484} Freewind Post · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "",

	-- Step 3: Ratchet
	-- {area:484} Freewind Post · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 5: Fly to the Crossroads
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 7: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "",
	["Crossroads flight master"] = "",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Крепость Громмаш, если у вас есть это задание",

	-- Step 10: Train
	["Train"] = "Обучение",
	["Train your new spells."] = "Изучите новые заклинания.",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 13: The Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). The quest text says Strong, but it takes a {item:3388}. No elixir: skip the Elixir steps in {area:287}."] = "",
	-- {item:3388} Lesser Troll's Blood Elixir · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}: аукцион или алхимик, для задания {quest:515}.",

	-- Step 14: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "",

	-- Step 15: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "",

	-- Step 16: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "",

	-- Step 17: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Летите сюда: {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "",

	-- Step 19: Tarren Mill
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "",
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, для персонажа {npc:2333}",

	-- Step 20: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Идите по дороге на север от места {area:272} в предгорья Альтерака. {quest:535} ждет у лагеря Синдиката; отдайте ему пиво.",

	-- Step 21: Syndicate missives
	["Syndicate missives"] = "Донесения Синдиката",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-34) around the camps west of the road carry the missives; about one in three drops one."] = "",

	-- Step 24: Helcular's Rod
	-- {area:277} Foothill Caverns · {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod."] = "",

	-- Step 25: Level 30
	["Level 30"] = "",
	-- {area:272} Tarren Mill · {quest:544} Prison Break In · {quest:556} Stone Tokens · {quest:676} The Hammer May Fall · {area:796} Scarlet Monastery · {area:2797} Blackfathom Deeps
	["{area:272}'s {quest:544}, {quest:556} and {quest:676} are offered from level 30. Below it? Keep killing the yetis in these caves until level 30. Or, with a group, run the {area:796} dungeon (Graveyard) or the {area:2797} dungeon instead."] = "",
	-- {npc:2248} Cave Yeti
	["grind on {npc:2248}"] = "",

	-- Step 26: Town hall
	["Town hall"] = "Ратуша",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Дальше – в городок {area:287}, к юго-западу от пещер йети. Ратуша – в западной части городка: {npc:2335} (30) и {npc:2448} внутри, там же городской реестр; рядом висит прокламация. По городку ходят члены совета.",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "{object:1761}, внутри",
	["Inside"] = "Внутри",

	-- Step 27: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "Возвращайтесь на восток сюда: {area:272}.",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside: offered from level 30"] = "",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside: offered from level 30"] = "",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide (from level 30)"] = "",

	-- Step 28: Foothill Caverns
	-- {area:272} Tarren Mill · {item:3710} Rod of Helcular · {object:1768} Flame of Azel · {object:1769} Flame of Veraz
	["Back into the yeti caves west of {area:272} with the {item:3710}. The path splits just inside: the {object:1768} burns on the upper level to the right, the {object:1769} on the lower level to the left, past more yetis."] = "",

	-- Step 29: Flame of Uzel
	["The third flame burns in the smaller cave up in the hills north of the caverns."] = "",

	-- Step 30: Alterac Mountains
	-- {area:279} Dalaran
	["The {area:279} crater"] = "",

	-- Step 31: The Dalaran crater
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens. Careful: Many guards stand in linked pairs and others patrol alone around the camp."] = "",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "",

	-- Step 33: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "Внутри: {area:288}",

	-- Step 34: Torn Fin murlocs
	["Torn Fin murlocs"] = "Мурлоки из племени Рваного Плавника",
	-- {area:271} Southshore
	["The Torn Fin murlocs camp on the beaches south-west of {area:271}'s bay, below the mine."] = "",
	["Torn Fin beach"] = "Пляж мурлоков Рваного Плавника",

	-- Step 35: Helcular's Grave
	-- {area:271} Southshore
	["Head east to {area:271}'s graveyard, on the north-east edge of the town: Helcular's grave lies among the others. Come at it from the north and keep away from the town's guards."] = "",

	-- Step 36: Daggerspine naga
	["Daggerspine naga"] = "Наги из клана Пронзающего Гребня",
	["The Daggerspine naga line the shore south-east of the town."] = "",
	["Daggerspine shore"] = "Берег наг Пронзающего Гребня",

	-- Step 37: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Head back north to {area:272}, east of {area:271}."] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:545} Dalaran Patrols
	["{npc:2410}: he offers {quest:545} after it"] = "",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}: for the 38-39 visit to Alterac"] = "",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}: for the 38-39 visit to Alterac"] = "",
	-- {npc:2229} Krusk · {npc:2316} Gol'dir
	["{npc:2229} now offers {npc:2316} (level 36): leave it for the 38-39 visit."] = "",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "",

	-- Step 38: Elixir of Agony with a group
	-- {quest:515} Elixir of Agony
	["{quest:515} with a group"] = "",
	-- {area:290} Dun Garok · {area:271} Southshore
	["Lydon's next errand is a keg of Shindigger Stout from the cellar of {area:290}, the elite dwarven keep south-east of {area:271}: take it only if you go there with a group."] = "",

	-- Step 39: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "",

	-- Step 40: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "",

	-- Step 41: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "",

	-- Step 42: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "",

	-- Step 44: Shindigger keg
	["Shindigger keg"] = "Бочонок «Землекопского крепкого»",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["The Kegs of Shindigger Stout stand in the cellar of {area:290}, the dwarven keep south-east of {area:271}, beside {npc:2304} (32); every dwarf there is elite (28-32)."] = "",
	["Below ground"] = "",

	-- Step 45: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "Назад: {area:272}",
	-- {area:272} Tarren Mill
	["Head back north to {area:272}."] = "",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "",

	-- Step 46: Arathi Highlands
	["Boulderfist camp"] = "Лагерь клана Тяжелого Кулака",

	-- Step 47: Boulderfist camp
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "",

	-- Step 48: Level 31
	["Level 31"] = "",
	-- {area:321} Hammerfall · {area:796} Scarlet Monastery · {area:2797} Blackfathom Deeps
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["{area:321}'s quests are 32-36. Below 31? Keep killing the Boulderfist Ogres and Enforcers at this camp until level 31. Or, with a group, run the {area:796} dungeon (Graveyard) or the {area:2797} dungeon instead."] = "",
	-- {npc:2562} Boulderfist Ogre
	["grind on {npc:2562}"] = "",

	-- Step 49: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "",
	-- {npc:2706} Tor'gan · {area:272} Tarren Mill
	["{npc:2706}: its Syndicate are by the road in from {area:272}, on the 38-39 visit"] = "",

	-- Step 50: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "",

	-- Step 51: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "",

	-- Step 52: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}."] = "",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "",
	-- {npc:2706} Tor'gan · {npc:2771} Drum Fel · {quest:677} Call to Arms
	["{npc:2706}'s Guile of the Raptor, {npc:2771}'s next {quest:677} and the doctor's Ward Restocking wait for the 38-39 visit."] = "",

	-- Step 53: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:321} Hammerfall
	["{area:321} flight master"] = "",

	-- Step 54: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "",

	-- Step 55: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Учителя: {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Обучитесь, пока вы здесь ({zone:1458}): учителя – здесь: {object:36070}, {object:36073} и {object:36082} (паладины: {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "Преступники и воры Синдиката (32-33) у лагерей к западу от дороги носят донесения; примерно с каждого третьего падает одно.",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "Бочонок стоит с несколькими другими в лагере Синдиката на юго-восточном побережье ({area:287}).",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "Крепость орков в восточном конце дороги. {npc:2851}, распорядитель полетов, стоит у ворот.",
}
