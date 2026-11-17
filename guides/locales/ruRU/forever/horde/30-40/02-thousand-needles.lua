-- Russian (ruRU): the guide forever/horde/30-40/02-thousand-needles (forever/horde/30-40/02-thousand-needles.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Дирижабль: {zone:1454}",

	-- Step 2: Alliance Relations
	-- {zone:1454} Orgrimmar · {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits
	["The zeppelin lands at the tower outside {zone:1454}'s main gate. {npc:5639} walks the Drag: if he isn't at the arrow, look along its streets to the south-west. {npc:5640} stands in the {object:172961} on the west side of the city."] = "Дирижабль причаливает к башне у главных ворот города {zone:1454}. {npc:5639} бродит по Аллее Чести: если его нет у стрелки, поищите на улицах к юго-западу. {npc:5640} стоит здесь: {object:172961}, в западной части города.",
	-- {npc:5639} Craven Drok
	["{npc:5639}: offered from level 30"] = "",
	-- {npc:5641} Takata Steelblade · {zone:1443} Desolace
	["for {npc:5641} in {zone:1443}, later in this guide"] = "",

	-- Step 3: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	["Train while you are in the city."] = "",

	-- Step 4: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892} стоит здесь: {object:172957}.",
	-- {npc:5892} Searn Firewarder · {npc:5905} Prate Cloudseer · {area:484} Freewind Post
	["{npc:5892}: for {npc:5905} by {area:484}, later in this guide"] = "",

	-- Step 5: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows
	["{npc:3428}'s {quest:1145} needed level 29 on the last guide's Crossroads stop: take it now, on a short flight to the Crossroads and back."] = "Задание {quest:1145} от NPC {npc:3428} требовало 29-го уровня при остановке в Перекрестке в прошлом гайде: возьмите его сейчас, слетав в Перекресток и обратно.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Распорядитель полетов: {zone:1454}",

	-- Step 6: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "",

	-- Step 7: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	["Crossroads flight master"] = "Распорядитель полетов на Перекрестке",

	-- Step 8: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, later in this guide"] = "для NPC {npc:4483} ({area:439}), позже в этом гайде",

	-- Step 10: Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {area:484} from there."] = "",

	-- Step 11: Islen Waterseer
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:5901} Islen Waterseer · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to {area:484} from {area:392}."] = "",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527} и ваш {item:5177}",

	-- Step 12: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Летите сюда: {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 13: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 15: Prate Cloudseer
	-- {npc:5905} Prate Cloudseer
	["{npc:5905} hides in a small cave in the canyon wall north-east of the post, on the way east."] = "",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}: ваш {item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905} также выдает задание о помощи стихий ({area:1717}) – цепочку 33-40 к оружию бури: forever/class/shaman/call-of-air-horde.",

	-- Step 16: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {area:484} Freewind Post · {quest:1149} Test of Faith
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\n{npc:2986} waits on the mesa just north-east of {area:484}, across the rope bridges.\nFor the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "Вы пропустили это при прошлом посещении этих мест по маршруту: теперь это идёт первым. Это быстро и открывает следующие задания.\n{npc:2986} ждет на плато к северо-востоку от места {area:484}, за веревочными мостами.\nДля задания {quest:1149} сойдите с края досок рядом с ним: вы приземлитесь невредимым.",

	-- Step 17: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {area:484} Freewind Post
	["{npc:2986} waits on the mesa just north-east of {area:484}, across the rope bridges."] = "{npc:2986} ждет на плато к северо-востоку от места {area:484}, за веревочными мостами.",
	-- {npc:2986} Dorn Plainstalker · {npc:4490} Grenka Bloodscreech
	["{npc:2986}: {npc:4490}, in the harpy den west of the post"] = "{npc:2986}: {npc:4490}, в логове гарпий к западу от лагеря",

	-- Step 18: Jandia
	-- {npc:4877} Jandia · {area:484} Freewind Post
	["{npc:4877}, the trade supplies vendor, stands inside {area:484}'s inn."] = "{npc:4877}, торговец товарами для ремесел, стоит в таверне ({area:484}).",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}: the Screeching harpies of {area:487}"] = "{npc:4877}: визгливые гарпии ({area:487})",
	-- {npc:4877} Jandia
	["{npc:4877}: her stolen supplies lie in the same harpy den"] = "{npc:4877}: ее украденные припасы лежат в том же логове гарпий",

	-- Step 19: The Screeching Canyon: kill these as you meet them
	-- {area:483} The Screeching Canyon
	["{area:483}: kill these as you meet them"] = "",
	-- {area:2097} Darkcloud Pinnacle · {area:487} Roguefeather Den · {npc:4877} Jandia · {quest:98069} Stolen Freewind Supplies · {npc:4490} Grenka Bloodscreech · {npc:2986} Dorn Plainstalker
	["West of Freewind Post, below {area:2097}, the harpies of {area:487} (28-30). The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s; her {quest:98069} lie on the ground along the foot of the cliff and in the cave up on top. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her, for {npc:2986}'s claw."] = "К западу от Поста Вольного Ветра, под местом {area:2097}, – гарпии ({area:487}, 28-30). Визгливые гарпии, гарпии Злоперья и призывательницы ветра там нужны для задания NPC {npc:4877}; ее {quest:98069} лежат на земле у подножия утеса и в пещере наверху. {npc:4490} (31) ходит среди них: проредите гарпий вокруг нее, прежде чем нападать, – коготь нужен NPC {npc:2986}.",
	-- {quest:98069} Stolen Freewind Supplies
	["{quest:98069}, on the ground around the den"] = "",
	-- {item:5843} Grenka's Claw · {npc:4490} Grenka Bloodscreech
	["{item:5843}, from {npc:4490}"] = "{item:5843}, с NPC {npc:4490}",

	-- Step 20: Jandia
	-- {area:484} Freewind Post
	["Back east to {area:484}."] = "Обратно на восток: {area:484}.",
	-- {npc:4877} Jandia
	["{npc:4877}, inside the inn"] = "{npc:4877}, в таверне",

	-- Step 21: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {npc:4499} Rok'Alim the Pounder
	["Back across to {npc:2986}'s mesa north-east of the post, then take the lift down to the canyon floor. {npc:2986}'s next test, {npc:4499}, is an elite: leave it."] = "Обратно на плато к NPC {npc:2986}, к северо-востоку от поста, затем спуститесь на подъемнике на дно каньона. Следующее испытание NPC {npc:2986}, {npc:4499}, – элита: оставьте его.",

	-- Step 22: Stormheart
	-- {npc:270094} Stormheart · {area:484} Freewind Post
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:270094} is a level 30 elite: most classes solo it at level 32, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:270094} walks the canyon road east of {area:484}'s lift, on the way to the salt flats: kill him for his heart."] = "Это элитные противники: лучше собраться в группу, поищите, с кем пойти. {npc:270094} – элитный противник 30-го уровня: большинство классов справляются с ним в одиночку на 32-м уровне, но вам может понадобиться помощь. Если вы один, пропустите его: маршрут позволит набрать этот опыт другим способом.\n{npc:270094} ходит по дороге в каньоне к востоку от подъемника ({area:484}), по пути к соляной равнине: убейте его ради сердца.",
	-- {item:279186} Stormheart's Still-beating Heart · {npc:270094} Stormheart
	["{item:279186}, from {npc:270094}"] = "{item:279186}, с NPC {npc:270094}",

	-- Step 23: Moktar Krin
	-- {npc:4483} Moktar Krin
	["Take the lift down and follow the canyon east. {npc:4483} camps on the north-western edge of the salt flats."] = "",

	-- Step 24: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "",
	-- {npc:4452} Kravel Koalbeard · {quest:5762} Hemet Nesingwary
	["{npc:4452}'s crate for {quest:5762} in Stranglethorn, later on the route"] = "",

	-- Step 25: Shimmering Flats: kill these as you meet them
	-- {area:439} Shimmering Flats
	["{area:439}: kill these as you meet them"] = "",
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["North-east of the raceway onto the flats. The Saltstone Basilisks (30-31) sun themselves north-west of it, and the Sparkleshell Tortoises (30-31) wander among them on the western flats; the Salt Flats Scavengers and Vultures circle the eastern flats. Every vulture drops a bone, about one tortoise in three a shell.\nCareful: Scavengers and Vultures use Execute when your health is low. The Sparkleshell Snappers (34-35) crowd round a half-buried ship in the north-east and are over you here: the Tortoises of the western flats drop the shells just as often, so stay with them. Take the venom from the Reavers (31-32) of the north half and leave the Scorpid Terrors (33-34) further south."] = "К северо-востоку от гоночной трассы, на равнину. Просоленные василиски (30-31) греются к северо-западу от нее, а блестопанцирные черепахи (30-31) бродят среди них на западе равнины; солончаковые падальщики и стервятники кружат на востоке. С каждого стервятника падает кость, примерно с каждой третьей черепахи – панцирь.\nОсторожно: падальщики и стервятники применяют «Казнь», когда у вас мало здоровья. Блестопанцирные крепкохваты (34-35) толпятся у полузарытого корабля на северо-востоке и здесь выше вас по уровню: черепахи на западе роняют панцири так же часто, оставайтесь с ними. Яд берите с разорителей (31-32) в северной половине, а скорпидов-убийц (33-34) южнее не трогайте.",
	-- {item:5795} Hardened Tortoise Shell
	-- plural, as words: Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise
	["{item:5795}, from the Sparkleshell Tortoises of the western flats"] = "{item:5795}, с блестопанцирных черепах на западе равнины",
	-- {object:19868} Rocket Car Rubble
	["{object:19868}, all over the northern flats: pick it on the western flats, away from the Snappers"] = "{object:19868} – по всей северной равнине: собирайте на западе, подальше от крепкохватов",
	-- {quest:1104} Salt Flat Venom
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["{quest:1104}, from the Scorpid Reavers of the north half"] = "",

	-- Step 26: Mirage Raceway
	["South-west back to the raceway."] = "",
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: his parts order goes to {quest:1111} in {area:392}, later on the route"] = "",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, at 39"] = "",
	-- {npc:4630} Pozzik · {area:392} Ratchet
	["{npc:4630}: for Gazlowe in {area:392}, later on the route"] = "",

	-- Step 27: Level 32
	["Level 32"] = "Уровень 32",
	-- {zone:1443} Desolace · {area:1717} Razorfen Kraul
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["The flats' south and the silithid dig are 32-35, {zone:1443}'s quests 32-38. Still below 32 after the raceway's hand-ins? Back north on the flats, the Scorpid Reavers (31-32) roam among the basilisks and tortoises: kill them until level 32; leave the Sparkleshell Snappers (34-35) and the Scorpid Terrors (33-34) alone. Or, with a group, run the {area:1717} dungeon instead."] = "Юг равнины и раскопки силитидов – 32-35, задания в зоне {zone:1443} – 32-38. Все еще ниже 32-го после сдачи заданий на трассе? Вернитесь на север равнины: скорпиды-разорители (31-32) бродят среди василисков и черепах – убивайте их до 32-го уровня; блестопанцирных крепкохватов (34-35) и скорпидов-убийц (33-34) не трогайте. Или с группой пройдите подземелье {area:1717}.",
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["Scorpid Reavers"] = "Скорпиды-разорители",
	-- {npc:4140} Scorpid Reaver
	["grind on {npc:4140}"] = "убивайте цель {npc:4140}",

	-- Step 28: The southern flats
	["The southern flats"] = "",
	-- plural, as words: Saltstone Crystalhides = {npc:4151} Saltstone Crystalhide
	["South of the raceway, the Saltstone Crystalhides (32-33) and Gazers (34-35) roam the far end of the flats.\nCareful: the level 35 Gazers can still be two over you: pull them one at a time from the camp's edge, never two together."] = "К югу от трассы, в дальнем конце равнины, бродят просоленные хрусталиски (32-33) и созерцатели (34-35).\nОсторожно: созерцатели 35-го уровня могут быть на два уровня выше вас: выманивайте их по одному с края лагеря, никогда по двое.",

	-- Step 29: The Rustmaul Dig Site
	-- {item:5877} Cracked Silithid Carapace · {npc:4132} Silithid Ravager
	["West of them the silithid swarm the dig site. Searchers and Hive Drones walk among the mounds; the Invaders (34-35) stay inside the hive cave. The first silithid you kill drops a {item:5877}: open it.\nCareful: Hive Drones call for help when they fall to 20% health, and the {npc:4132} (37, rare) walks the dig: take the Searchers and Drones (32-34) outside first, then pull the Invaders (34-35) one at a time from the cave mouth."] = "К западу от них силитиды кишат на раскопках. Искатели и трутни улья бродят среди холмов, а захватчики (34-35) остаются в пещере улья. Первый убитый силитид дает {item:5877}: откройте его.\nОсторожно: трутни улья зовут на помощь при 20% здоровья, а по раскопкам ходит {npc:4132} (37, редкий). Сначала перебейте искателей и трутней (32-34) снаружи, затем выманивайте захватчиков (34-35) по одному от входа в пещеру.",

	-- Step 30: Parts of the Swarm
	["Keep killing silithid at the dig site for the heart, the talons and the carapaces."] = "",

	-- Step 31: Moktar Krin
	-- {npc:4483} Moktar Krin
	["North from the dig to {npc:4483}'s camp on the western edge of the flats."] = "",

	-- Step 32: Mirage Raceway
	-- {area:976} Gadgetzan
	["East to the raceway, on the way south to {area:976}."] = "На восток к трассе, по пути на юг сюда: {area:976}.",

	-- Step 33: Gadgetzan
	-- {zone:1446} Tanaris · {area:976} Gadgetzan · {area:484} Freewind Post
	["South from the raceway over the {zone:1446} border to {area:976}, the walled goblin town: learn its flight path and fly back to {area:484} from there, which is quicker than the walk west across the flats, and the next guides fly straight to {area:976}."] = "На юг от трассы через границу зоны {zone:1446}: {area:976}, гоблинский город за стенами. Откройте там маршрут полета и летите обратно сюда: {area:484}. Это быстрее, чем идти на запад через равнину, а следующие гайды летят прямо в {area:976}.",

	-- Step 35: Freewind Post
	-- {npc:10537} Cliffwatcher Longhorn
	["{npc:10537} stands in the middle of the post, on the way to the flight master."] = "",
	-- {npc:10537} Cliffwatcher Longhorn · {npc:11259} Nataka Longhorn · {zone:1443} Desolace
	["{npc:10537}: for {npc:11259} in {zone:1443}, next"] = "",

	-- Step 36: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "Летите сюда: {area:460}",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "",

	-- Step 38: Scrabblescrew's Camp
	-- {zone:1443} Desolace · {npc:11596} Smeed Scrabblescrew
	["Head south out of Stonetalon into {zone:1443} and follow the road south to {npc:11596}'s camp."] = "",

	-- Step 39: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:11259} Nataka Longhorn · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post, {npc:11259} up on its rise; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "",
	-- {npc:11259} Nataka Longhorn
	["{npc:11259}, up on the rise"] = "",

	-- Step 41: Takata Steelblade and Maurin Bonesplitter
	-- {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter
	["{npc:5641} and {npc:4498}"] = "{npc:5641} и {npc:4498}",

	-- Step 42: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo · {npc:11521} Kodo Apparition
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. At his camp, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time. Careful: leave the kodo skulls on the ground alone: opening one raises a {npc:11521} (37-38) that hits hard."] = "Используйте {item:13892} (от NPC {npc:11596}) на старом, умирающем кодо или на этом: {npc:4702} – на кладбище, и приведите прирученного кодо обратно к NPC {npc:11596}. В его лагере поговорите с кодо: это засчитает его и позволит приручить следующего. Пять кодо, по одному. Осторожно: не трогайте черепа кодо на земле: открыв один, вы поднимете NPC {npc:11521} (37-38), который сильно бьет.",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "",

	-- Step 44: Shadowprey Village
	-- {area:606} Gelkis Village · {npc:268705} Aka'rai · {quest:97265} Hate the Hatefury
	["Head west to the troll village on the coast, keeping clear of the {area:606} on the way. {npc:268705} stands on the path just north of the village.\n{npc:268705} may not be here on Forever: if {npc:268705} doesn't offer {quest:97265}, skip it."] = "",
	-- {npc:268705} Aka'rai · {area:603} Sargeron
	["{npc:268705}: the Hatefury satyrs of {area:603}, later in this guide"] = "",
	-- {npc:11877} Roon Wildmane · {quest:5762} Hemet Nesingwary
	["{npc:11877}: for {quest:5762} in Stranglethorn, next guide"] = "",
	-- {npc:6726} Thalon
	["{npc:6726}, at the village's south-west end"] = "",

	-- Step 45: Ethel Rethor
	-- {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress · {area:2406} Ranazjar Isle
	["Head north along the coast, then inland to the ruined tower of {area:2405}: {npc:11863} waits inside. The coast's clams and naga come after {area:599}, on one walk north to {area:2406}."] = "Идите на север вдоль побережья, затем вглубь суши к разрушенной башне ({area:2405}): внутри ждет {npc:11863}. Моллюски и наги на побережье – после этого места: {area:599}; их вы пройдете за один переход на север сюда: {area:2406}.",

	-- Step 46: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {npc:13019} Burning Blade Seer · {item:20310} Flayed Demon Skin · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {zone:1443} Desolace
	["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it. Leave the red {object:176581} for now: its {npc:11876} is 37, and the second {zone:1443} visit comes back for it."] = "Идите на восток: {area:599}. Избейте культиста Пылающего Клинка и, пока он не умер, используйте на нем {item:6436}, чтобы получить {item:6435}. {npc:13019} стоит на верхнем этаже крепости со Скипетром. Культисты иногда роняют {item:20310} (1-5%); если выпадет, прочитайте. Красный {object:176581} пока не трогайте: {npc:11876} там 37-го уровня, к нему вернетесь во второй визит в зону {zone:1443}.",
	["On the top floor"] = "",

	-- Step 47: Ethel Rethor
	-- {npc:11863} Azore Aldamort
	["Back west to {npc:11863}."] = "",
	-- {npc:11863} Azore Aldamort · {item:15803} Book of the Ancients · {npc:12369} Lord Kragaru · {area:2406} Ranazjar Isle
	["{npc:11863}'s next errand, the {item:15803}, needs {npc:12369} (38) out on {area:2406}: leave it, he is over your level."] = "Следующее поручение NPC {npc:11863} – {item:15803} – требует убить NPC {npc:12369} (38) здесь: {area:2406}. Пропустите его: он выше вашего уровня.",

	-- Step 48: Rackmore's Log
	-- {object:177787} Rackmore's Log · {npc:11863} Azore Aldamort
	["{object:177787} lies on the ground just south-west of {npc:11863}'s tower, on the way down to the shore: read it. Its two keys drop only while you have the quest."] = "{object:177787} лежит на земле к юго-западу от башни, где ждет {npc:11863}, по пути вниз к берегу: прочитайте его. Оба ключа выпадают, только пока у вас есть задание.",

	-- Step 49: Clam beds
	["Clam beds"] = "Отмели с моллюсками",
	-- {item:15874} Soft-shelled Clam · {item:15878} Rackmore's Silver Key
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler · Drysnap Crawlers = {npc:11562} Drysnap Crawler
	["West to the shore. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach: each clam you open on the sea floor, and some crawlers, give a {item:15874}. Open each one in your bags for its meat.\nThe Drysnap Crawlers and Pincers on the same beach carry {item:15878}, about one in seven."] = "На запад к берегу. Гигантские мягкопанцирные моллюски лежат на мелководье, а разъяренные рифовые ползуны бродят по пляжу: каждый моллюск, открытый на морском дне, и некоторые ползуны дают {item:15874}. Откройте каждый в сумке, чтобы достать мясо.\nСухощелкие ползуны и клешнецы на том же пляже носят {item:15878} – примерно один из семи.",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam
	["Giant Softshell Clams, on the sea floor"] = "",
	-- {item:15874} Soft-shelled Clam
	["{item:15874}: open it in your bags"] = "",
	["Underwater"] = "Под водой",
	-- {item:15878} Rackmore's Silver Key
	["{item:15878}, from the Drysnap crabs"] = "{item:15878} – с сухощелких крабов",

	-- Step 50: Sar'theris Strand
	-- {area:598} Sar'theris Strand · {item:15881} Rackmore's Golden Key · {zone:1443} Desolace
	["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), up to two over you at 33: work the Naga and Sorceresses (32-33) of the southern half until the key drops, and leave the north for the second {zone:1443} visit, at 38."] = "Идите дальше на север ({area:598}) за предметом {item:15881}: он может выпасть с любой наги Скользящего Клинка.\nОсторожно: мирмидоны (34-35) держат северную половину пляжа вместе с морскими ведьмами и оракулами (34-36, заклинатели) – до двух уровней выше вас на 33-м. Бейте наг и колдуний (32-33) южной половины, пока не выпадет ключ, а север оставьте на второй визит в зону {zone:1443}, на 38-м уровне.",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881} – с наг Скользящего Клинка",

	-- Step 51: Rackmore's Chest
	-- {area:2406} Ranazjar Isle · {object:177786} Rackmore's Chest · {object:177673} Serpent Statue
	["Swim out to {area:2406} off the far northern tip: {object:177786} stands on the shore beside the {object:177673}. Open it with both keys; leave the statue alone."] = "Плывите к острову ({area:2406}) у северной оконечности: {object:177786} стоит на берегу рядом с объектом {object:177673}. Откройте его обоими ключами; статую не трогайте.",

	-- Step 52: Sargeron
	-- {area:599} Thunder Axe Fortress · {area:603} Sargeron · {npc:268705} Aka'rai
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["Head east past {area:599} and along the northern hills to the satyrs' ruins of {area:603}. Kill every kind you meet for {npc:268705}; the Shadowstalkers walk unseen.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "",
	-- {npc:4671} Hatefury Trickster
	["{npc:4671}, on the way south"] = "",

	-- Step 53: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["South to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health.\nCareful: Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "",

	-- Step 54: Ghost Walker Post
	["South-west down the road to the post."] = "",
	-- {npc:5641} Takata Steelblade · {npc:5640} Keldran · {zone:1454} Orgrimmar
	["{npc:5641}: for {npc:5640} in {zone:1454}, next guide"] = "",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "Следующее поручение {npc:5641} – повелитель демонов с элитной охраной: пропустите его.",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace · {area:607} Valley of Spears
	["{npc:5395} now offers Centaur Bounty: the second {zone:1443} visit, at 38, takes it on its way to the {area:607}."] = "{npc:5395} теперь предлагает задание «Centaur Bounty»: второй визит в зону {zone:1443}, на 38-м уровне, берет его по пути сюда: {area:607}.",

	-- Step 55: Shadowprey Village
	["West to Shadowprey: your hearthstone is bound there."] = "",
	-- {npc:268705} Aka'rai
	["{npc:268705}, on the path just north of the village"] = "",
	-- {item:14547} Hand of Iruxos · {zone:1443} Desolace · {zone:1454} Orgrimmar · {zone:1434} Stranglethorn Vale
	["Taiga's {item:14547}, Drulzegar's Other Fish to Fry and {zone:1443}'s other 37-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "{item:14547} для Тайги, «Other Fish to Fry» Друлзегара и прочие задания 37-40 в зоне {zone:1443} ждут второго визита, на 38-м уровне: следующие гайды летят в {zone:1454} и садятся на дирижабль: {zone:1434}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to {npc:11863}'s tower."] = "Обратно на юг к башне, где ждет {npc:11863}.",
	-- ["Keep north to {area:598}. The Slitherblade Myrmidons, Naga and Sorceresses hold the beach; pull them one at a time. Any Slitherblade can drop {item:15881}."] = "Продолжайте путь на север: {area:598}. Пляж удерживают мирмидоны, наги и колдуньи из клана Скользящего Клинка; выманивайте их по одному. {item:15881} может выпасть с любой наги Скользящего Клинка.",
	-- ["Shadowprey's {quest:5381} and the coast's naga want 33. Below that? The Kolkar centaurs (30-32) of {area:609}, a short way east of {npc:11596}'s camp, are the nearest camp at your level: kill them until level 33. The Scorpashi Lashers (34-35) on the slopes north of the camp are higher. Or, with a group, run the {area:1717} dungeon instead."] = "Задание {quest:5381} из Деревни Ночных Охотников и наги на побережье требуют 33-го уровня. Ниже? Кентавры из племени Колкар (30-32) здесь: {area:609}, недалеко к востоку от лагеря ({npc:11596}), – ближайший лагерь вашего уровня: убивайте их до 33-го уровня. Scorpashi Lashers (34-35) на склонах к северу от лагеря выше уровнем. Или, с группой, пройдите вместо этого подземелье {area:1717}.",
	-- ["Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}. He is well above you: rest to full first. {object:177786} stands on the shore beside the statue: open it with both keys."] = "Плывите к острову у самой северной оконечности ({area:2406}) и используйте {item:15766} на объекте {object:177673}: появится {npc:12369} (38); убейте его, чтобы получить {quest:6027}. Он намного сильнее вас: сначала полностью восстановитесь. {object:177786} стоит на берегу рядом со статуей: откройте его обоими ключами.",
	-- ["grind on {npc:4635}"] = "убивайте цель {npc:4635}",
	-- ["{item:15766}, on the {object:177673}"] = "{item:15766} – на объекте {object:177673}",
}
