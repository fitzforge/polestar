-- French (frFR): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
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
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "Les fouilles du Marteau du crépuscule occupent le coin nord-ouest : des fragments de tablette jonchent le sol, et les Tempétueux de poussière et Grondeurs du désert en portent aussi. Tout sectateur peut laisser tomber un {item:20404} : gardez-en vingt, dix pour {npc:15306} et dix pour {npc:15194} plus tard.",
	["Twilight's Hammer cultists"] = "Sectateurs du Marteau du crépuscule",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Dix de plus pour {quest:8323}",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Fragments de la Tablette du crépuscule ({item:20378})",

	-- Step 4: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Chevauchez vers l'est jusqu'aux ruines de {area:2738}. Le {object:179565} se trouve parmi les bâtiments en ruine, surveillé par des Sentinelles torturées.",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "",

	-- Step 5: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "L'ermite se cache parmi les rochers au sud-est de {area:2738}.",
	["Below ground"] = "",

	-- Step 6: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Campement de Bronzebeard",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand just south-east of the camp."] = "Chevauchez vers le sud-ouest jusqu'au camp des nains près des montagnes du sud et interrogez {npc:15171} et {npc:15170}. La Sacoche de {npc:15190} se trouve dans le sable juste au sud-est du camp.",

	-- Step 7: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} tient le camp des sectateurs à l'extrême sud-ouest.",

	-- Step 8: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use Divine Shield, Feign Death or Vanish. Blink and Power Word: Shield do not drop it."] = "",

	-- Step 9: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "Chevauchez vers le nord par le côté ouest jusqu'au petit camp de Mayna.",

	-- Step 10: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "Le camp de Havunth se trouve juste à l'ouest de {area:3425}.",

	-- Step 11: Hermit Ortell
	["Ride back south-east to the hermit."] = "Revenez vers le sud-est jusqu'à l'ermite.",
	["Hand him the ten texts you kept"] = "Remettez-lui les dix textes que vous avez gardés",

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
	["Wait a moment for {npc:9116}"] = "Patientez un instant pour {npc:9116}",

	-- Step 16: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Braseros de {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "",
	["Angerclaw bears and Felpaw wolves"] = "Ours de la griffe colérique et loups Gangrepatte",
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
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "Suivez la route vers le nord jusqu'à {area:1767}. Les Arbrefer marteleurs portent le cœur ; finissez les griffes sur les Grizzlys de la griffe colérique et les Ravageurs Gangrepatte du nord.",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Arbrefer marteleurs",

	-- Step 19: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "",

	-- Step 20: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Chevauchez vers le nord jusqu'au village des furbolgs Mort-bois, près de l'entrée de la grotte de {area:1769}.",
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
	["Ride back south along the road to the Sanctuary."] = "Revenez vers le sud par la route jusqu'au sanctuaire.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Gardez le {item:11169}, les griffes et le cœur qu'il vous rend",

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
	["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Vous commencez à {area:392}, où le guide précédent vous a renvoyé par la pierre de foyer. Prenez un vol pour {area:415}.",
	-- {npc:6791} Innkeeper Wiley
	["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791} : le guide précédent vous ramène ici par la pierre de foyer, cette étape se coche donc généralement aussitôt",

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
	["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Pierre de foyer vers {area:392} et vol pour {area:976}. Achetez ici deux Barres de thorium à l'hôtel des ventes pour {quest:5801}.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 43: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Chevauchez vers l'est dans les collines. Utilisez le {item:11169} pour invoquer {quest:4005}, puis vainquez-le pour obtenir le totem.",

	-- Step 44: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Chevauchez vers le sud-ouest jusqu'au camp de {npc:7771}, à {area:1938}.",

	-- Step 45: Level 58.98
	["Level 58.98"] = "",
	-- {area:16985} The Shaper's Terrace
	["Top up here to level 58.98 before the hand-ins at {area:16985}: they take you to level 59."] = "",
	-- {npc:7132} Toxic Horror
	["grind on {npc:7132}"] = "",

	-- Step 47: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Prenez la route vers l'ouest qui descend dans le cratère et chevauchez jusqu'à la {area:540}, la grotte silithide au sud. La {npc:10041} attend dans sa salle la plus profonde.",

	-- Step 48: Fire Plume Ridge
	["Use the jars on slain oozes"] = "Utilisez les pots sur les limons tués",

	-- Step 49: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Chevauchez vers le nord jusqu'à {area:541}. Utilisez {npc:10980} à côté de {npc:10977}.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, au fond du refuge",

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
	["Fly to {area:976}."] = "Prenez un vol pour {area:976}.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} à {zone:1457} : gardez-la",

	-- Step 57: Forest Song
	-- {area:3137} Talrendis Point · {area:16} Azshara · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "",

	-- Step 58: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "",

	-- Step 59: Everlook
	-- {area:3137} Talrendis Point · {area:2255} Everlook
	["Ride back to {area:3137} and fly to {area:2255}."] = "Revenez à {area:3137} et prenez un vol pour {area:2255}.",

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
	["{area:2577} (optional)"] = "{area:2577} (facultatif)",
	-- {area:2577} Dire Maul · {zone:1444} Feralas
	["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:2577}, en {zone:1444}, au lieu de tuer des monstres vous y mène plus vite en groupe. Passez cette étape pour monter de niveau en solo.",
	-- {area:2577} Dire Maul · {npc:7446} Rabid Shardtooth
	["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} convient aux niveaux 55 à 60 ; tuer des {npc:7446} ci-dessous vous mène seul au niveau 59.",

	-- Step 66: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Continuez vers l'ouest sur la route jusqu'au camp de {npc:9298}, à côté des sources chaudes.",

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
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "La maison de {npc:11801} se trouve à {area:2361}, à l'est de {npc:11939}.",

	-- Step 82: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",

	-- Step 84: Nighthaven
	-- {area:2361} Nighthaven · {area:442} Auberdine
	["Take the flight path in {area:2361} and fly to {area:442}."] = "Prenez le trajet aérien de {area:2361} et volez jusqu'à {area:442}.",

	-- Step 86: Rut'theran Village
	-- {area:442} Auberdine · {area:702} Rut'theran Village
	["Take the boat from {area:442} to {area:702}."] = "Prenez le bateau d'{area:442} pour {area:702}.",

	-- Step 88: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Prenez le portail pour monter à {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, dans le Temple de la Lune",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}, à la banque",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, au sommet de {area:1658}",

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
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, dans {object:2096}",

	-- Step 95: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth · {area:1997} Bloodvenom Post
	-- plural, as words: Jadefire Shadowstalkers = {npc:7110} Jadefire Shadowstalker
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest.\nCareful: Jadefire Shadowstalkers are level 51-52 and move stealthed. They use Slowing Poison and are found about 550 yd south of {area:1997}.\nCareful: Jadefire Shadowstalkers sneak around and use Slowing Poison."] = "",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} n'a pas de maître des chamans",

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
	["{npc:1852} is a level 61 elite"] = "{npc:1852} est un élite de niveau 61",

	-- Step 104: Andorhal
	["Andorhal"] = "Ruines d'Andorhal",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} attend dans l'auberge en ruine du côté ouest des Ruines d'Andorhal, la ville en ruine au nord du camp. {npc:1852} garde son phylactère au milieu de la ville.",
	["Araj is elite: grouping up is advised."] = "Araj est élite : mieux vaut être en groupe.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",

	-- Step 105: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "Le fantôme de {npc:10778} erre près de la ferme de {area:199}, à l'ouest d'Andorhal. Les Goules jacassantes du champ portent l'autre moitié du charme : combinez les deux moitiés.",
	["Upstairs"] = "",

	-- Step 106: Level 59.78
	["Level 59.78"] = "",
	-- {area:199} Felstone Field
	["Top up here to level 59.78 before the hand-ins at {area:199}: they take you to level 60."] = "",
	["Grind spot"] = "",

	-- Step 108: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Remontez la route vers le nord jusqu'à la scierie et posez le tonneau de termites en son centre.",

	-- Step 109: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (facultatif)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} vit dans une petite hutte au bord de la rivière frontalière, au nord-est du camp de bûcherons. Rendez {quest:5781} si vous l'avez terminée.",

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
	["{area:2057} (optional)"] = "{area:2057} (facultatif)",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {area:28} Western Plaguelands · {area:2279} Stratholme
	["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "",
	-- {area:2057} Scholomance · {quest:5505} The Key to Scholomance · {area:3197} Chillwind Camp
	["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} convient aux niveaux 58 à 60 ; {quest:5505} se rend au {area:3197}, plus bas.",

	-- Step 120: Grind to 60
	["Grind to 60"] = "Monter au niveau 60",
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Traversez la rivière à l'est de {npc:1855} jusqu'à Val-Terreur. Les Esprits de {area:2627} hantent les bois.",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {area:139} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {area:139}"] = "",

	-- Step 122: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "Revenez vers le sud-ouest jusqu'au {area:3197}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "Retournez à {area:1770} : {npc:9861} et {npc:9860} gardent {npc:9517} dans la salle la plus profonde.",
	-- ["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Gravissez {area:537}, au milieu du cratère, et utilisez le {item:14644} près du lac de lave au sommet, avec deux Barres de thorium dans vos sacs. Remplissez les Pots d'échantillon pur vides de {npc:9616} sur les Limons primitifs des mares autour de la crête.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Les Écraseurs térébrants parcourent les dunes entre {area:2743} et {area:3425}, sur votre chemin du retour. {npc:15181} ne propose {quest:8304} qu'à partir du niveau 58.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Prenez un vol pour {area:3137}, en {zone:1447}, et chevauchez vers l'ouest par la route jusqu'à {area:2358}, juste après la frontière d'{zone:1440}.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Suivez la route vers le sud-ouest à la sortie du col jusqu'à {area:3425}.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Redescendez à {area:702}, prenez le bateau pour {area:442} puis le bateau pour {area:17203}. Apportez soixante Etoffes de soie, soixante Etoffes de tisse-mage et soixante {item:14047} pour {npc:14722} : achetez ce qui vous manque à l'hôtel des ventes.",
	-- ["Grind to 58"] = "Monter au niveau 58",
	-- ["Grind to 59"] = "Monter au niveau 59",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Pierre de foyer vers {area:1519} et apprenez vos sorts de niveau 60. C'est la fin de l'itinéraire de progression : consultez ensuite les guides de réputation et de donjons.",
	-- ["Into {zone:1451}"] = "Vers {zone:1451}",
	-- ["Level 60"] = "Niveau 60",
	-- ["Ride back north to {area:2255} and west along the road to the night elf village."] = "Revenez vers le nord jusqu'à {area:2255}, puis vers l'ouest par la route jusqu'au village elfe de la nuit.",
	-- ["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Chevauchez vers le nord hors de {area:415} jusqu'en {zone:1448}, jusqu'au camp des druides sur la route juste après la frontière.",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Chevauchez vers le sud jusqu'à {area:2250}. Protégez {npc:10300} pendant qu'elle allume les torches en route vers l'{object:177404}.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Chevauchez vers l'ouest le long de la paroi nord du cratère jusqu'au col du coin nord-ouest qui monte vers {zone:1451}.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:2057} ({area:2298}, sud-est de {zone:1422}) ou {area:2279} au lieu de tuer des monstres vous y mène plus vite en groupe. Passez cette étape pour monter de niveau en solo.",
	-- ["Shaman training"] = "Entraînement de chaman",
	-- ["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Prenez la route vers l'ouest qui descend dans le cratère et chevauchez jusqu'à {area:540}, la grotte silithide au sud. La {npc:10041} attend dans sa salle la plus profonde.",
	-- ["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Prenez le tunnel de {area:1769} par son entrée du {zone:1452}, à l'ouest de {npc:9298}, et suivez la branche de {area:493} jusqu'à {area:2361}. {npc:11939} étudie au bord du lac.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Prenez le {area:2257} jusqu'à {zone:1455}. {npc:14724} et {npc:14723} veulent chacun soixante Etoffes de laine, soixante Etoffes de soie et soixante Etoffes de tisse-mage, puis soixante {item:14047} : 120 de chaque en tout, de vos sacs ou de l'hôtel des ventes.",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Les ours {npc:7446} parcourent la vallée enneigée au sud de {area:2250}.",
	-- ["Toward the north-west pass"] = "Vers le col nord-ouest",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "tuez des {npc:11741} dans les dunes à l'est de {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "tuez des {npc:14564} à {area:2627}, {zone:1423}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "tuez des {npc:7446} dans la vallée au sud de {area:2250}, {zone:1452}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} est la grotte au fond de {area:1763}, à l'ouest de la route. Utilisez l'{item:12906} sur les quatre braseros à l'intérieur. Tuez les ours de la griffe colérique et les loups Gangrepatte en chemin pour les {item:11172}.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924} : se termine au {zone:1452}, gardez-la",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, si vous avez trente {quest:6031}",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, juste à l'intérieur de la grotte : seulement à partir de Neutre avec les Grumegueule",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}, l'aubergiste",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} campe devant {area:2743}, la ruche ouest. Ramassez de la Silithyst à l'un des geysers rouges voisins et portez-la à l'extracteur de l'Alliance de son camp.",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, aux tentes de l'Alliance",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} attend à {area:1767}. Escortez-la hors des bois et gardez-la en vie.",
	-- ["{object:176091}, if you found the Firewater flask in {zone:1452}"] = "{object:176091}, si vous avez trouvé le flacon d'eau de feu au {zone:1452}",
	-- ["{object:210335} Fragments"] = "Fragments de {object:210335}",
	-- ["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085} : {npc:9298} au {zone:1452}, gardez-la",
	-- ["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} et les Maleterres",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453} n'a pas de maître des chamans : prenez le {area:2257} depuis {object:28027} jusqu'à {zone:1455} et apprenez vos sorts de niveau 60 auprès de {npc:258098}.",
}
