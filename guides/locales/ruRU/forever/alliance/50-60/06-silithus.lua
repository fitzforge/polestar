-- Russian (ruRU): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {area:361} Felwood · {area:618} Winterspring
	["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "",

	-- Step 2: Twilight Base Camp: kill these as you meet them
	-- {area:2739} Twilight Base Camp
	["{area:2739}: kill these as you meet them"] = "",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "Раскопки культа Сумеречного Молота занимают северо-западный угол: фрагменты табличек лежат на земле, их также носят пылевихри и пустынные грохотуны. С любого культиста может упасть {item:20404}: сохраните двадцать – десять для персонажа {npc:15306} и десять позже для персонажа {npc:15194}.",
	["Twilight's Hammer cultists"] = "Культисты Сумеречного Молота",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Еще десять для задания «{quest:8323}»",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Фрагменты Сумеречной таблички",

	-- Step 4: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Езжайте на восток к руинам ({area:2738}). {object:179565} лежит среди разрушенных зданий под охраной истерзанных часовых.",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "",

	-- Step 5: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "Отшельник прячется среди скал к юго-востоку (ориентир: {area:2738}).",
	["Below ground"] = "",

	-- Step 6: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Лагерь Бронзоборода",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand just south-east of the camp."] = "Езжайте на юго-запад к лагерю дворфов у южных гор и расспросите: {npc:15171} и {npc:15170}. Сумка {npc:15190} лежит в песке чуть юго-восточнее лагеря.",

	-- Step 7: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} удерживает лагерь культистов на дальнем юго-западе.",

	-- Step 8: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use Divine Shield, Feign Death or Vanish. Blink and Power Word: Shield do not drop it."] = "",

	-- Step 9: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "Езжайте на север вдоль западной стороны к маленькому лагерю Майны.",

	-- Step 10: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "Лагерь Хавунта – чуть западнее (ориентир: {area:3425}).",

	-- Step 11: Hermit Ortell
	["Ride back south-east to the hermit."] = "Езжайте назад на юго-восток к отшельнику.",
	["Hand him the ten texts you kept"] = "Отдайте ему десять сохраненных текстов",

	-- Step 13: Fly to Talrendis Point
	-- {area:3137} Talrendis Point
	["Fly to {area:3137}"] = "",
	-- {area:3425} Cenarion Hold
	["{area:3425} flight master"] = "",

	-- Step 15: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:415} Astranaar · {area:361} Felwood
	["Ride north out of {area:415} into {area:361} to the druids' camp on the road just past the border."] = "",
	["Inside"] = "",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Подождите немного {npc:9116}",

	-- Step 16: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Жаровни: {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "",
	["Angerclaw bears and Felpaw wolves"] = "Медведи злобных когтей и волки-сквернолапы",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "",

	-- Step 18: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "Идите по дороге на север: {area:1767}. Сердце носят топотуны Железнолесья; когти доберите с гризли злобных когтей и опустошителей-сквернолапов на севере.",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Топотуны Железнолесья",

	-- Step 19: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "",

	-- Step 20: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Езжайте на север к деревне фурболгов из племени Мертвого Леса у входа в пещеру ({area:1769}).",
	-- {object:176091} Deadwood Cauldron · {area:618} Winterspring
	["{object:176091}, if you found the Firewater flask in {area:618}"] = "",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {area:618} Winterspring
	["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "",

	-- Step 21: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "",

	-- Step 22: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "Езжайте по дороге назад на юг к Святилищу.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Сохраните {item:11169}, когти и сердце, которые он вернет",

	-- Step 24: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",
	-- {area:3137} Talrendis Point
	["{area:3137} flight master"] = "",

	-- Step 25: Ratchet
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "",

	-- Step 26: Astranaar
	-- {area:392} Ratchet · {area:415} Astranaar
	["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Вы начинаете здесь: {area:392} – сюда вас вернул камень возвращения в прошлом гайде. Летите сюда: {area:415}.",
	-- {npc:6791} Innkeeper Wiley
	["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: предыдущий гайд возвращает вас сюда камнем возвращения, так что это обычно отмечается сразу",

	-- Step 27: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "",

	-- Step 28: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 29: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge
	["Take the {area:2257} to {zone:1455}."] = "",

	-- Step 30: Stormwind
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "",

	-- Step 31: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "",

	-- Step 32: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 33: Ironforge
	["Its jars are filled on the next Un'Goro visit"] = "",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "",

	-- Step 34: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 36: Light's Hope Chapel
	-- {area:3197} Chillwind Camp · {area:2268} Light's Hope Chapel
	["Ride on north to {area:3197} and fly to {area:2268}."] = "",

	-- Step 37: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "",

	-- Step 38: Light's Hope Chapel
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal: keep it"] = "",

	-- Step 39: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "",

	-- Step 40: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "",

	-- Step 41: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 42: Gadgetzan
	-- {area:392} Ratchet · {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Камень возвращения: {area:392}, затем летите сюда: {area:976}. Купите здесь на аукционе два ториевых слитка для задания «{quest:5801}».",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 43: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Езжайте на восток в холмы. Используйте {item:11169}, чтобы призвать: {quest:4005}, затем победите его ради тотема.",

	-- Step 44: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Езжайте на юго-запад к лагерю ({npc:7771}): {area:1938}.",

	-- Step 45: Level 58.98
	["Level 58.98"] = "",
	-- {area:16985} The Shaper's Terrace
	["Top up here to level 58.98 before the hand-ins at {area:16985}: they take you to level 59."] = "",
	-- {npc:7132} Toxic Horror
	["grind on {npc:7132}"] = "",

	-- Step 47: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Спуститесь по дороге на запад в кратер и езжайте к месту {area:540} – пещере силитидов на юге. {npc:10041} ждет в самом дальнем зале.",

	-- Step 48: Fire Plume Ridge
	["Use the jars on slain oozes"] = "Используйте флаконы на убитых слизнюках",

	-- Step 49: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Езжайте на север: {area:541}. Используйте {npc:10980} рядом с персонажем {npc:10977}.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737} – в глубине лагеря",

	-- Step 51: It's Dangerous to Go Alone
	-- {npc:9376} Blazerunner
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9376} is a level 56 elite: most classes solo it at level 58, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 52: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "",

	-- Step 53: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 56: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "Летите сюда: {area:976}.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} ({zone:1457}): сохраните задание",

	-- Step 57: Forest Song
	-- {area:3137} Talrendis Point · {area:16} Azshara · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "",

	-- Step 58: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",

	-- Step 59: Everlook
	-- {area:3137} Talrendis Point · {area:2255} Everlook
	["Ride back to {area:3137} and fly to {area:2255}."] = "Езжайте назад: {area:3137}, затем летите сюда: {area:2255}.",

	-- Step 60: Ranshalla
	-- {npc:10300} Ranshalla · {area:2250} Owl Wing Thicket · {area:2255} Everlook · {object:177404} Altar of Elune
	["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "",

	-- Step 61: Level 59.11
	["Level 59.11"] = "",
	-- {quest:3962} It's Dangerous to Go Alone
	["If you skipped {quest:3962}, grind here to level 59.11 to stay on the route's plan."] = "",
	-- {npc:7441} Winterfall Totemic
	["grind on {npc:7441}"] = "",

	-- Step 63: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "",

	-- Step 65: Dire Maul (optional)
	-- {area:2577} Dire Maul
	["{area:2577} (optional)"] = "{area:2577} (по желанию)",
	-- {area:2577} Dire Maul · {zone:1444} Feralas
	["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "В группе быстрее пройти подземелье {area:2577} ({zone:1444}), чем убивать мобов. Пропустите этот шаг, чтобы качаться в одиночку.",
	-- {area:2577} Dire Maul · {npc:7446} Rabid Shardtooth
	["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} подходит для 55–60 уровней; убийство мобов ({npc:7446}) ниже доведет вас до 59-го в одиночку.",

	-- Step 66: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Двигайтесь по дороге дальше на запад к лагерю {npc:9298} у горячих источников.",

	-- Step 72: Winterspring: kill these as you meet them
	-- {area:618} Winterspring
	["{area:618}: kill these as you meet them"] = "",
	["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with Feign Death, and they then gather by the lake so you can take the next quest."] = "",

	-- Step 76: Felpaw Village
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw; walks around here: look inside the circle on the map"] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}, if you have thirty {quest:6031}; below ground"] = "",

	-- Step 78: Umber
	-- {area:1769} Timbermaw Hold · {area:618} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "",

	-- Step 79: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "Дом ({npc:11801}) стоит здесь: {area:2361}, к востоку (ориентир: {npc:11939}).",

	-- Step 82: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",

	-- Step 84: Nighthaven
	-- {area:2361} Nighthaven · {area:442} Auberdine
	["Take the flight path in {area:2361} and fly to {area:442}."] = "Воспользуйтесь маршрутом полета ({area:2361}) и летите сюда: {area:442}.",

	-- Step 86: Rut'theran Village
	-- {area:442} Auberdine · {area:702} Rut'theran Village
	["Take the boat from {area:442} to {area:702}."] = "Плывите на корабле: {area:442} → {area:702}.",

	-- Step 88: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Поднимитесь через портал: {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740} – в Храме Луны",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155} – в банке",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516} – наверху ({area:1658})",

	-- Step 89: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "",

	-- Step 90: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "",

	-- Step 91: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "",

	-- Step 92: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 94: Stormwind
	-- {npc:14722} Clavicus Knavingham · {quest:6031} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {quest:6031}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722} – здесь: {object:2096}",

	-- Step 95: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth · {area:1997} Bloodvenom Post
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest.\nCareful: Jadefire Shadowstalkers are level 51-52 and move stealthed. They use Slowing Poison and are found about 550 yd south of {area:1997}.\nCareful: Jadefire Shadowstalkers sneak around and use Slowing Poison."] = "",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "В городе {zone:1453} нет учителя шаманов",

	-- Step 97: Stormwind City
	["Stormwind City"] = "",
	-- {item:2592} Wool Cloth
	["Sixty {item:2592}, if you carry them"] = "",

	-- Step 99: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 103: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} – элитный противник 61-го уровня",

	-- Step 104: Andorhal
	["Andorhal"] = "Андорал",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} ждет в разрушенной таверне в западной части Андорала – разрушенного города к северу от лагеря. {npc:1852} охраняет свою филактерию в центре города.",
	["Araj is elite: grouping up is advised."] = "Араж – элитный противник: лучше собрать группу.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",

	-- Step 105: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "Призрак {npc:10778} бродит у дома ({area:199}) к западу от Андорала. Вторую половину амулета носят болтливые вурдалаки на поле: соедините обе половины.",
	["Upstairs"] = "",

	-- Step 106: Level 59.78
	["Level 59.78"] = "",
	-- {area:199} Felstone Field
	["Top up here to level 59.78 before the hand-ins at {area:199}: they take you to level 60."] = "",
	["Grind spot"] = "",

	-- Step 108: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Езжайте по дороге на север к лесопилке и поставьте бочку с термитами в ее центре.",

	-- Step 109: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (по желанию)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} живет в маленькой хижине у пограничной реки, к северо-востоку от лесопилки. Сдайте задание «{quest:5781}», если выполнили его.",

	-- Step 111: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "",

	-- Step 112: Of Lost Honor
	["Underwater"] = "",

	-- Step 116: Into Western Plaguelands
	-- {area:28} Western Plaguelands
	["Into {area:28}"] = "",

	-- Step 119: Scholomance (optional)
	-- {area:2057} Scholomance
	["{area:2057} (optional)"] = "{area:2057} (по желанию)",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {area:28} Western Plaguelands · {area:2279} Stratholme
	["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "",
	-- {area:2057} Scholomance · {quest:5505} The Key to Scholomance · {area:3197} Chillwind Camp
	["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} подходит для 58–60 уровней; задание «{quest:5505}» сдается ниже ({area:3197}).",

	-- Step 120: Grind to 60
	["Grind to 60"] = "Качайтесь до 60-го уровня",
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Перейдите реку к востоку от {npc:1855}: {area:2627}. В тамошних лесах бродят духи долины Ужаса.",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {area:139} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {area:139}"] = "",

	-- Step 122: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "Езжайте назад на юго-запад: {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "Снова сюда: {area:1770}. В самом дальнем зале {npc:9861} и {npc:9860} охраняют: {npc:9517}.",
	-- ["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Поднимитесь в центре кратера: {area:537} – и используйте {item:14644} у лавового озера наверху, имея в сумках два ториевых слитка. Наполните чистые флаконы для образцов от {npc:9616} на первобытных слизнюках в водоемах вокруг гряды.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Земляные сокрушители бродят по дюнам между местами {area:2743} и {area:3425}, на обратном пути. {npc:15181} предлагает задание «{quest:8304}» только с 58-го уровня.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Летите сюда: {area:3137} ({zone:1447}) – и езжайте по дороге на запад: {area:2358}, сразу за границей зоны {zone:1440}.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "От перевала идите по дороге на юго-запад: {area:3425}.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Спуститесь обратно: {area:702}, плывите на корабле сюда: {area:442} – и дальше сюда: {area:17203}. Принесите {npc:14722} по шестьдесят шт. шелкового материала, магической ткани и предмета {item:14047}: недостающее купите на аукционе.",
	-- ["Grind to 58"] = "Качайтесь до 58-го уровня",
	-- ["Grind to 59"] = "Качайтесь до 59-го уровня",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Камень возвращения: {area:1519}. Изучите заклинания 60-го уровня. На этом маршрут прокачки заканчивается: дальше смотрите гайды по репутации и подземельям.",
	-- ["Into {zone:1451}"] = "В зону {zone:1451}",
	-- ["Level 60"] = "60-й уровень",
	-- ["Ride back north to {area:2255} and west along the road to the night elf village."] = "Езжайте назад на север: {area:2255}, затем по дороге на запад к деревне ночных эльфов.",
	-- ["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Езжайте на север ({area:415} → {zone:1448}) к лагерю друидов на дороге сразу за границей.",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Езжайте на юг: {area:2250}. Защищайте персонажа {npc:10300}, пока она зажигает факелы по пути сюда: {object:177404}.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Езжайте на запад вдоль северной стены кратера к перевалу в северо-западном углу, который ведет в зону {zone:1451}.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "В группе быстрее пройти подземелье {area:2057} ({area:2298}, юго-восток зоны {zone:1422}) или {area:2279}, чем убивать мобов. Пропустите этот шаг, чтобы качаться в одиночку.",
	-- ["Shaman training"] = "Обучение шамана",
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Спуститесь по дороге на запад в кратер и езжайте сюда: {area:540} – пещера силитидов на юге. {npc:10041} ждет в самом дальнем зале.",
	-- ["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Войдите в туннель ({area:1769}) со стороны зоны {zone:1452}, к западу от {npc:9298}, и идите по ответвлению ({area:493}) до места {area:2361}. {npc:11939} занимается исследованиями на берегу озера.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Поезжайте на метро ({area:2257}) сюда: {zone:1455}. {npc:14724} и {npc:14723} хотят по шестьдесят шт. шерсти, шелкового материала и магической ткани, затем по шестьдесят шт. предмета {item:14047}: всего по 120 каждого – из ваших сумок или с аукциона.",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Медведи ({npc:7446}) бродят по снежной долине к югу от места {area:2250}.",
	-- ["Toward the north-west pass"] = "К северо-западному перевалу",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "убивайте мобов ({npc:11741}) в дюнах к востоку от места {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "убивайте мобов ({npc:14564}): {area:2627}, {zone:1423}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "убивайте мобов ({npc:7446}) в долине к югу от места {area:2250}, {zone:1452}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} – пещера в глубине храма ({area:1763}), к западу от дороги. Используйте {item:12906} на четырех жаровнях внутри. По пути убивайте медведей злобных когтей и волков-сквернолапов ради предмета {item:11172}.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: завершается здесь: {zone:1452} – сохраните задание",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, если у вас есть тридцать шт. {quest:6031}",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558} – сразу у входа в пещеру: только с уровня «Равнодушие» у Древобрюхов",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}, хозяйка таверны",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} стоит лагерем у западного улья ({area:2743}). Возьмите силитист у одного из красных гейзеров поблизости и отнесите его в экстрактор Альянса в его лагере.",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082} – у палаток Альянса",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} ждет здесь: {area:1767}. Выведите ее из леса, не дав погибнуть.",
	-- ["{object:176091}, if you found the Firewater flask in {zone:1452}"] = "{object:176091}, если вы нашли флягу из-под огненной воды ({zone:1452})",
	-- ["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} ({zone:1452}), сохраните задание",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} и Чумные земли",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "В городе {zone:1453} нет учителя шаманов: поезжайте на метро ({area:2257}) из места {object:28027} сюда: {zone:1455} – и изучите заклинания 60-го уровня у персонажа {npc:258098}.",
}
