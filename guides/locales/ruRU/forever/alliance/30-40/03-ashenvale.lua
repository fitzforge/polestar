-- Russian (ruRU): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Летите сюда: {area:150}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Распорядитель полетов: {zone:1453}",

	-- Step 2: Red Jack Flint
	-- {npc:4455} Red Jack Flint · {area:2103} Menethil Keep
	["{npc:4455} stands by {area:2103}'s door, just north of the flight master."] = "{npc:4455} стоит у двери ({area:2103}), чуть к северу от распорядителя полетов.",
	-- {quest:1132} Fiora Longears
	["For {quest:1132} in Theramore's inn, where this guide's boat goes"] = "Для задания {quest:1132} в таверне Терамора, куда плывет корабль этого руководства",

	-- Step 3: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern · {npc:4963} Mikhail · {npc:5082} Vincent Hyal
	["{npc:1217} stands in the {area:2104}, south of the keep, where {npc:4963} and {npc:5082} wait too."] = "{npc:1217} стоит в таверне ({area:2104}) к югу от крепости, где также ждут {npc:4963} и {npc:5082}.",
	["Inside"] = "Внутри",

	-- Step 4: Deepwater Tavern
	-- {quest:1248} The Missing Diplomat · {npc:4963} Mikhail
	["Tapoke Jahn (34) slips out of the tavern once you take {quest:1248}: stay close behind him. He turns on you outside, a friend joins him, and he gives up once badly hurt. If you lose him the quest fails: abandon it and take it again from {npc:4963}."] = "",

	-- Step 5: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Обломки «Flying Osprey» лежат на мелководье к югу от крепости.",

	-- Step 6: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Слитки светлостали",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Слитки у мурлоков из племени Синежабрых на пляже к юго-западу от Менетила.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "",

	-- Step 7: Glorin Steelbrow
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["For {npc:1416} in {zone:1453}, after Stranglethorn"] = "",

	-- Step 9: Theramore
	["Theramore"] = "Терамор",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Распорядитель полетов стоит у ворот ({area:514}); {npc:5083} и {npc:4964} – внутри цитадели.",
	-- {npc:5083} Clerk Lendry
	["{npc:5083}, on the top floor"] = "",
	-- {npc:4964} Commander Samaul
	["{npc:4964}, on the top floor"] = "",
	-- {npc:4964} Commander Samaul · {area:503} Sentry Point
	["{npc:4964}: {area:503} is the watchtower on the road west, next"] = "",
	-- {quest:1132} Fiora Longears
	["{quest:1132}, inside the inn in the north of town"] = "{quest:1132} – в таверне на севере городка",
	-- {npc:4456} Fiora Longears · {area:415} Astranaar
	["{npc:4456}'s next errand goes to {area:415}, off this route: leave it."] = "",
	-- {quest:1132} Fiora Longears · {zone:1441} Thousand Needles
	["{quest:1132}: the wyverns are in {zone:1441}, later in this guide"] = "",

	-- Step 10: Sentry Point
	-- {area:503} Sentry Point · {area:403} Shady Rest Inn · {npc:4967} Archmage Tervosh
	["Follow the road north-west out of Theramore to the watchtower at {area:503}, where the road to the {area:403} turns west. Look around the tower: {npc:4967} appears at its foot, and you hand the quest in to him there."] = "",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, at the foot of the tower"] = "",
	-- {npc:4967} Archmage Tervosh · {npc:4966} Private Hendel · {area:504} North Point Tower · {zone:1445} Dustwallow Marsh
	["{npc:4967}: {npc:4966} holds {area:504}, for the {zone:1445} visit at 39"] = "",
	-- {npc:4966} Private Hendel · {zone:1445} Dustwallow Marsh
	["Take Tervosh's next errand now: he stands here only right after the hand-in. {npc:4966} waits for the next {zone:1445} visit, at about 39."] = "",

	-- Step 11: The Shady Rest Inn
	-- {zone:1413} Barrens
	["Follow the road west to the burned inn on the road toward the {zone:1413}: the black shield and Reethe's guard badge lie in the ashes and the hoofprints are in the mud beside the inn."] = "",
	-- {object:21042} Theramore Guard Badge
	["{object:21042}: for Captain Vimes, on the way back through Theramore"] = "",

	-- Step 12: Into Barrens
	-- {zone:1413} Barrens
	["Into {zone:1413}"] = "В зону {zone:1413}",

	-- Step 13: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "По пути на юг через зону {zone:1413}: {npc:6244} стоит лагерем к востоку от дороги, к северо-востоку от места {area:378}; подходите с востока и держитесь подальше от стражей Орды.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: в зоне {zone:1440}, по пути в зону {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: инкуб, рядом с суккубом; {item:190309} – рядом с целью задания «{quest:1738}»",

	-- Step 14: Myriam Moonsinger
	-- {npc:12866} Myriam Moonsinger · {area:1316} Razorfen Downs · {area:485} Great Lift
	-- plural, as words: Razorfen Battleguards = {npc:7873} Razorfen Battleguard · Death's Head Cultists = {npc:7872} Death's Head Cultist
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:12866} stands by the entrance of {area:1316}, a few hundred yards north-east of the top of the {area:485}; the Razorfen Battleguards, Thornweavers and Death's Head Cultists (33-34, elite) hold the thorny slopes around her. Skip it if you are alone."] = "",

	-- Step 15: Henrig Lonebrow's Journal
	-- {area:485} Great Lift · {zone:1441} Thousand Needles · {item:5791} Henrig Lonebrow's Journal · {area:2097} Darkcloud Pinnacle
	["Down the {area:485} into {zone:1441}. Careful: wait on the platform until the lift is level with it before you step on, and stay on it until it stops; the drop beside it kills. {item:5791} lies a couple of hundred yards north-east of the lift's foot, in {area:2097}, where the Grimtotems (25-27) camp."] = "",
	-- {item:5791} Henrig Lonebrow's Journal · {npc:4048} Falfindel Waywarder · {area:482} Highperch
	["{item:5791}: for {npc:4048}, just past {area:482}"] = "",

	-- Step 16: Highperch
	-- {area:482} Highperch
	["West to the wyverns' cliffs at {area:482}. Every wyvern there can drop a venom sac."] = "",

	-- Step 17: Falfindel Waywarder
	-- {npc:4048} Falfindel Waywarder · {area:482} Highperch · {zone:1444} Feralas · {area:489} Thalanaar · {area:1717} Razorfen Kraul
	["{npc:4048} camps north of {area:482}, just over the border into {zone:1444} on the path up to {area:489}: hand him the journal. His next quest is inside {area:1717}: leave it."] = "",

	-- Step 18: Thousand Needles
	-- {area:484} Freewind Post
	["East through the canyons. {area:484}, a Horde camp with guards, sits on the mesa here: keep to the canyon floor and give the foot of its lifts a wide berth."] = "На восток через каньоны. Здесь на плато стоит {area:484} – лагерь Орды со стражей: держитесь дна каньона и обходите подножие его подъемников стороной.",
	-- {area:482} Highperch
	["The canyons east of {area:482}"] = "",

	-- Step 20: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Идите по каньонам на восток к соляным равнинам. Гоблины и гномы ({area:2240}) нейтральны и дают задания обеим фракциям.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Для задания «{quest:5762}» в Тернистой долине, позже",

	-- Step 21: Mirage Raceway: kill these as you meet them
	-- {area:2240} Mirage Raceway
	["{area:2240}: kill these as you meet them"] = "{area:2240}: убивайте их по пути",
	-- {object:19868} Rocket Car Rubble · {npc:5935} Ironeye the Invincible
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Saltstone Gazers = {npc:4150} Saltstone Gazer · Scorpid Terrors = {npc:4139} Scorpid Terror
	-- was: ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half."] = "{object:19868} разбросаны по всей равнине. Скорпиды-разорители и солончаковые падальщики бродят в северной половине, блестопанцирные черепахи (30-31) – в середине равнины: бейте их ради панцирей. Осторожно: блестопанцирные крепкохваты (34-35) бродят по всей равнине, а просоленные взорени (34-35) и скорпиды-убийцы (33-34) держат дальний юг: не трогайте их и держитесь северной половины."
	["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half.\nCareful: {npc:5935} (37, rare) roams the south-east of the flats, around 83-88,71-84: leave it be."] = "",
	-- {item:5795} Hardened Tortoise Shell
	-- plural, as words: Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise
	["{item:5795}, from the Sparkleshell Tortoises"] = "{item:5795} – с блестопанцирных черепах",
	-- {npc:4078} Collin Mauren · {zone:1453} Stormwind
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["Crystalized Scale, from the Saltstone Basilisks: eight for {npc:4078} in {zone:1453}"] = "",

	-- Step 22: Mirage Raceway
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: for {quest:1111} on {area:392}'s dock, where this guide ends"] = "",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, at the end of 30-40"] = "",
	-- {npc:4630} Pozzik · {npc:3391} Gazlowe · {area:392} Ratchet
	["{npc:4630}: for {npc:3391} in {area:392}, on the way to the boat"] = "",

	-- Step 23: Into Tanaris
	-- {zone:1446} Tanaris
	["Into {zone:1446}"] = "В зону {zone:1446}",
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris
	["From the raceway follow the road south out of the {area:439} into {zone:1446}."] = "",

	-- Step 24: Gadgetzan
	-- {area:976} Gadgetzan · {npc:7823} Bera Stonehammer
	["{area:976} is a short walk down the road; keep to it. {npc:7823}, the Alliance flight master, stands inside the walls."] = "",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "Лететь на остров Терамор",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Распорядитель полетов: {area:976}",

	-- Step 26: Theramore
	-- {npc:4456} Fiora Longears · {npc:4948} Adjutant Tesoran · {area:514} Foothold Citadel · {npc:4941} Caz Twosprocket
	["{npc:4456} is in the north of town, Captain Vimes and {npc:4948} on the top floor of {area:514}; {npc:4941} stands in the town."] = "",
	-- {zone:1445} Dustwallow Marsh
	["Vimes's next errand, The Deserters, is for the {zone:1445} visit at 39: leave it."] = "",

	-- Step 27: Ratchet
	-- {zone:1413} Barrens · {area:392} Ratchet · {area:35} Booty Bay · {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["From Theramore follow the road north-west through the marsh into the {zone:1413} and up the coast to {area:392}: Stranglethorn starts at {area:35}, across the sea. {area:392}'s gryphon master stands above the dock; {npc:3391} is upstairs in the house above it; {quest:1111} waits on the dock by the boat."] = "",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631}, on {area:35}'s dock where the boat lands"] = "",
	-- {quest:1111} Wharfmaster Dizzywig · {quest:1039} The Barrens Port · {npc:8026} Thyn'tel Bladeweaver · {zone:1457} Darnassus
	["{quest:1111}: {quest:1039}, from {npc:8026} in {zone:1457}"] = "",
	-- {quest:1111} Wharfmaster Dizzywig · {npc:3945} Caravaneer Ruzzgot · {area:35} Booty Bay
	["{quest:1111}: for {npc:3945} in {area:35}, where the boat lands"] = "",
	-- {area:2240} Mirage Raceway
	["Dizzywig's next errand goes back to the {area:2240}, which the route next visits at 45: leave it."] = "",

	-- Step 28: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Корабль: {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Обратно на запад по дороге к лагерям сатиров ({area:429}).",
	-- ["Boat to {area:150}"] = "Корабль: {area:150}",
	-- ["Dartol's Rod"] = "Жезл Дартола",
	-- ["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Идите по дороге на восток к лагерям сатиров ({area:429}); {npc:3920} прячется на их окраине.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Идите по дороге на запад из места {area:415}; {area:413} — к северу от нее.",
	-- ["From {area:608}"] = "Откуда: {area:608}",
	-- ["Geltharis"] = "Гелтарис",
	-- ["Insane druids"] = "Обезумевшие друиды",
	-- ["Melyria and {npc:3901}"] = "Мелирия и {npc:3901}",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Ржавые сундуки стоят вокруг лагерей фурболгов из Чащобы к западу от Отрекшихся; открывайте их, пока в одном не найдется навершие.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "Плывите на корабле в {area:150} с причалов места {area:442}.",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Пройдите по туннелю сюда: {area:419}; фолиант лежит в руинах в западной части.",
	-- ["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "{item:5475} у безумных и высохших древняков к северу от лунного колодца; старый сундук, который он открывает, стоит среди них.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "Лагерь Отрекшихся — в лесу к югу от места {area:2358}.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "Лунный колодец — на холмах к северо-востоку от места {area:415}.",
	-- ["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Второй {object:19901} — в долине ({area:428}), по пути на запад.",
	-- ["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "Святилище стоит на холме чуть юго-восточнее лунного колодца; поднимитесь по извилистой тропе.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Три друида стоят вместе в лагере Отрекшихся к югу от места {area:2358}.",
	-- ["The two stand together at the western end of the road."] = "Обе стоят вместе в западном конце дороги.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Обломки «Flying Osprey» лежат на мелководье к югу от крепости.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "{npc:3931} бродит по берегу ({quest:1035}) к юго-западу от сундуков; {object:669176} лежит к северу от озера, по пути.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "{object:19901} стоит в лагере сатиров ({area:430}), дальше на восток по дороге.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358} — застава ночных эльфов в восточном конце дороги: там стоят {npc:3848} и {npc:221269}.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358} — застава ночных эльфов в восточном конце дороги: там стоит {npc:3848}.",
	-- ["{area:429} satyrs"] = "Сатиры: {area:429}",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} стоит на верхнем этаже Крепости Менетил.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} и его стража стоят лагерем чуть восточнее: {npc:3897}.",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, фурболг, не тронутый порчей, сидит к югу от дороги ниже места {area:421}.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: для NPC {npc:1480} в Менетиле, в конце этого гайда",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} ведет сатиров ({area:429}); ветвь у него.",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} и {npc:4962} — все в таверне Менетила; Тапоке нападает, когда вы говорите с NPC {npc:4963}, но сдается после поражения. {npc:1480} стоит недалеко к северо-востоку от таверны.",
	-- ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half."] = "{object:19868} разбросаны по всей равнине. Скорпиды-разорители и солончаковые падальщики бродят в северной половине, блестопанцирные черепахи (30-31) – в середине равнины: бейте их ради панцирей. Осторожно: блестопанцирные крепкохваты (34-35) бродят по всей равнине, а просоленные взорени (34-35) и скорпиды-убийцы (33-34) держат дальний юг: не трогайте их и держитесь северной половины.",
	-- ["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: для NPC {npc:3961} ({area:415})",
}
