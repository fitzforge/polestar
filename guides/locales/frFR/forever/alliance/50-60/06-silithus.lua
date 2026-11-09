-- French (frFR): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} et les Maleterres",

	-- Step 1: To Ratchet
	-- {area:392} Ratchet
	["To {area:392}"] = "Vers {area:392}",

	-- Step 2: Fly to Talrendis Point
	-- {area:3137} Talrendis Point
	["Fly to {area:3137}"] = "Prendre un vol pour {area:3137}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",

	-- Step 3: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 4: The Emerald Sanctuary
	-- {area:3137} Talrendis Point · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "",
	["Inside"] = "À l'intérieur",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Patientez un instant pour {npc:9116}",

	-- Step 5: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Braseros de {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "",
	["Angerclaw bears and Felpaw wolves"] = "Ours de la griffe colérique et loups Gangrepatte",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "{object:176159}, sous terre",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}, sous terre",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}, sous terre",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}, sous terre",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "",

	-- Step 6: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "",

	-- Step 8: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "Suivez la route vers le nord jusqu'à {area:1767}. Les Arbrefer marteleurs portent le cœur ; finissez les griffes sur les Grizzlys de la griffe colérique et les Ravageurs Gangrepatte du nord.",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Arbrefer marteleurs",

	-- Step 9: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598} attend au {area:1767}. Escortez-la hors des bois et gardez-la en vie.\nAttention : trois {quest:5086} vous tendent une embuscade peu après le début de l'escorte.",

	-- Step 10: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Chevauchez vers le nord jusqu'au village des furbolgs Mort-bois, près de l'entrée de la grotte de {area:1769}.",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085} : {npc:9298} au {zone:1452}, gardez-la",

	-- Step 11: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {npc:9518} Rakaiah
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber. The succubus {npc:9518} waits on the way, with Trey Lightforge's remains beside her.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "{npc:9518}, sous terre",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}, sous terre",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "{npc:9861}, sous terre",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}, sous terre",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517} ; sous terre",

	-- Step 12: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "Revenez vers le sud par la route jusqu'au sanctuaire.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, à l'intérieur",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Gardez le {item:11169}, les griffes et le cœur qu'il vous rend",

	-- Step 14: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- {area:3137} Talrendis Point
	["{area:3137} flight master"] = "Maître de vol de {area:3137}",

	-- Step 15: Gadgetzan
	-- {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, à l'intérieur",

	-- Step 16: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Chevauchez vers l'est dans les collines. Utilisez le {item:11169} pour invoquer {quest:4005}, puis vainquez-le pour obtenir le totem.",

	-- Step 17: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Chevauchez vers le sud-ouest jusqu'au camp de {npc:7771}, à {area:1938}.",

	-- Step 19: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Prenez la route vers l'ouest qui descend dans le cratère et chevauchez jusqu'à la {area:540}, la grotte silithide au sud. La {npc:10041} attend dans sa salle la plus profonde.",

	-- Step 20: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Gravissez {area:537}, au milieu du cratère, et utilisez le {item:14644} près du lac de lave au sommet, avec deux Barres de thorium dans vos sacs. Remplissez les Pots d'échantillon pur vides de {npc:9616} sur les Limons primitifs des mares autour de la crête.",
	["Use the jars on slain oozes"] = "Utilisez les pots sur les limons tués",

	-- Step 21: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Chevauchez vers le nord jusqu'à {area:541}. Utilisez {npc:10980} à côté de {npc:10977}.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, sous terre",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, au fond du refuge",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "",

	-- Step 22: Fly to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Fly to {area:3425}"] = "Prendre un vol pour {area:3425}",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Maître de vol de {area:541}",

	-- Step 23: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "",

	-- Step 24: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "{area:2742} : tuez-les au passage",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "Les fouilles du Marteau du crépuscule occupent le coin nord-ouest : des fragments de tablette jonchent le sol, et les Tempétueux de poussière et Grondeurs du désert en portent aussi. Tout sectateur peut laisser tomber un {item:20404} : gardez-en vingt, dix pour {npc:15306} et dix pour {npc:15194} plus tard.",
	["Twilight's Hammer cultists"] = "Sectateurs du Marteau du crépuscule",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Fragments de la Tablette du crépuscule ({item:20378})",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Dix de plus pour {quest:8323}",

	-- Step 25: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {spell:642} Divine Shield · {spell:5384} Feign Death · {spell:17} Power Word: Shield
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080} campe devant {area:2743}, la ruche ouest. Ramassez de la silithyste à l'un des geysers rouges proches et portez-la jusqu'à l'extracteur de l'Alliance, à son camp.\nAttention : vous perdez la silithyste si vous montez en selle, vous camouflez, utilisez {spell:642}, {spell:5384} ou Disparition. Transfert et {spell:17} ne la font pas tomber.",

	-- Step 28: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Chevauchez vers l'est jusqu'aux ruines de {area:2738}. Le {object:179565} se trouve parmi les bâtiments en ruine, surveillé par des Sentinelles torturées.",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "{object:179565} ; à l'intérieur",

	-- Step 29: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "L'ermite se cache parmi les rochers au sud-est de {area:2738}.",
	["Below ground"] = "Sous terre",

	-- Step 30: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Campement de Bronzebeard",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand just south-east of the camp."] = "Chevauchez vers le sud-ouest jusqu'au camp des nains près des montagnes du sud et interrogez {npc:15171} et {npc:15170}. La Sacoche de {npc:15190} se trouve dans le sable juste au sud-est du camp.",

	-- Step 31: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} tient le camp des sectateurs à l'extrême sud-ouest.",

	-- Step 32: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "Chevauchez vers le nord par le côté ouest jusqu'au petit camp de Mayna.",

	-- Step 33: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "Le camp de Havunth se trouve juste à l'ouest de {area:3425}.",

	-- Step 34: Hermit Ortell
	["Ride back south-east to the hermit."] = "Revenez vers le sud-est jusqu'à l'ermite.",
	["Hand him the ten texts you kept"] = "Remettez-lui les dix textes que vous avez gardés",

	-- Step 35: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 36: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "Prenez un vol pour {area:976}.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} à {zone:1457} : gardez-la",

	-- Step 37: Forest Song
	-- {area:3137} Talrendis Point · {zone:1447} Azshara · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Prenez un vol pour {area:3137}, en {zone:1447}, et chevauchez vers l'ouest par la route jusqu'à {area:2358}, juste après la frontière d'{zone:1440}.",

	-- Step 38: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Prendre un vol pour {area:2255}",

	-- Step 41: Starfall Village
	-- {area:2253} Starfall Village
	["Ride north-west up the road to {area:2253}."] = "",

	-- Step 43: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "Camp de {npc:10301}",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride back east past {area:2255} and south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 44: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "Fournitures de {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Ramassez les fournitures autour du chariot et reprenez l'amulette de {npc:10301} aux chouettards voisins.",

	-- Step 45: Ranshalla
	-- {npc:10300} Ranshalla · {area:2250} Owl Wing Thicket · {area:2255} Everlook · {object:177404} Altar of Elune
	["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300} attend au {area:2250}, au sud d'{area:2255}.\nProtégez {npc:10300} pendant qu'elle allume les torches sur le chemin de l'{object:177404}.",

	-- Step 46: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Suivez les indications de {npc:9298} Snowden jusqu'à l'entrée de {area:2256}, après les Géants Cognegivre : passez-les un par un.",

	-- Step 47: Starfall Village
	-- {area:2255} Everlook · {area:2253} Starfall Village
	["Ride north up the valley, past {area:2255}, to {area:2253}."] = "",

	-- Step 49: Dire Maul (optional)
	-- {area:2577} Dire Maul
	["{area:2577} (optional)"] = "{area:2577} (facultatif)",
	-- {area:2577} Dire Maul · {zone:1444} Feralas
	["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:2577}, en {zone:1444}, au lieu de tuer des monstres vous y mène plus vite en groupe. Passez cette étape pour monter de niveau en solo.",
	-- {area:2577} Dire Maul · {area:2627} Terrordale
	["{area:2577} fits levels 55 to 60; alone, the {area:2627} grind at the end of this guide gets you to 60."] = "",

	-- Step 50: Felwood
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "",

	-- Step 52: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["{npc:11558} stands just inside the {area:1769} cave: she speaks to you from Neutral with the Timbermaw, which the Winterfall furbolgs you ground in {zone:1452} brought you to."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "",

	-- Step 53: Kernda
	-- {area:1762} Felpaw Village · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "",

	-- Step 54: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth · {zone:1452} Winterspring
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw: the {zone:1452} top-up on the Winterfall furbolgs gets you both."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "",

	-- Step 58: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452} : tuez-les au passage",
	-- {spell:5384} Feign Death
	["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "Les furbolgs Tombe-hiver de l'ouest laissent tomber les perles.\nAttention : rendre la quête fait apparaître trois ou quatre embusqués Tombe-hiver de niveau 56-57 qui vous attaquent ; vous pouvez leur échapper en monture, camouflé ou avec {spell:5384}, et ils se rassemblent ensuite près du lac, ce qui vous permet de prendre la quête suivante.",

	-- Step 62: Umber
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Prenez le tunnel de {area:1769} par son entrée du {zone:1452}, à l'ouest de {npc:9298}, et suivez la branche de {area:493} jusqu'à {area:2361}. {npc:11939} étudie au bord du lac.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} se promène autour de {area:2361} : cherchez dans le cercle sur la carte",

	-- Step 63: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "La maison de {npc:11801} se trouve à {area:2361}, à l'est de {npc:11939}.",

	-- Step 65: Nighthaven
	-- {area:2361} Nighthaven
	["Learn the flight path in {area:2361}."] = "",

	-- Step 66: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",

	-- Step 67: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "",

	-- Step 69: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Prenez le portail pour monter à {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, dans le Temple de la Lune",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}, à la banque",

	-- Step 71: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, au sommet de {area:1658}",

	-- Step 72: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portail vers {zone:1438}",

	-- Step 73: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maître de vol du {area:702}",

	-- Step 74: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 75: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Prendre un vol pour {zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maître de vol de {area:150}",

	-- Step 76: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14722} prend soixante Étoffes de soie, soixante Étoffes de tisse-mage et soixante {item:14047} : rendez ce que vous portez (ou achetez à l'hôtel des ventes), laissez le reste.",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "{item:4306}, depuis vos sacs",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "{item:4338}, depuis vos sacs",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, dans {object:2096}",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "{item:2592}, depuis vos sacs",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "{item:14047}, depuis vos sacs",

	-- Step 77: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 78: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} n'a pas de maître des chamans",

	-- Step 79: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prendre un vol pour {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 83: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} est un élite de niveau 61",
	-- {quest:6184} Flint Shadowmore · {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["{quest:6184}: the agents' remains lie at the {area:2260} in the {zone:1423}"] = "",

	-- Step 84: Andorhal
	["Andorhal"] = "Ruines d'Andorhal",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} attend dans l'auberge en ruine du côté ouest des Ruines d'Andorhal, la ville en ruine au nord du camp. {npc:1852} garde son phylactère au milieu de la ville.",
	["Araj is elite: grouping up is advised."] = "Araj est élite : mieux vaut être en groupe.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, à l'étage",

	-- Step 85: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "Le fantôme de {npc:10778} erre près de la ferme de {area:199}, à l'ouest d'Andorhal. Les Goules jacassantes du champ portent l'autre moitié du charme : combinez les deux moitiés.",
	["Upstairs"] = "À l'étage",

	-- Step 86: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Remontez la route vers le nord jusqu'à la scierie et posez le tonneau de termites en son centre.",

	-- Step 87: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (facultatif)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} vit dans une petite hutte au bord de la rivière frontalière, au nord-est du camp de bûcherons. Rendez {quest:5781} si vous l'avez terminée.",

	-- Step 88: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 89: Of Lost Honor
	["Underwater"] = "Sous l'eau",

	-- Step 91: Egan
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {npc:11140} Egan
	["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "",

	-- Step 92: Marris Stead
	-- {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride south to the {area:2260}, the farm north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it. Coming close enough to see the Blightcaller in front of the house completes the scouting.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "",

	-- Step 94: Scholomance (optional)
	-- {area:2057} Scholomance
	["{area:2057} (optional)"] = "{area:2057} (facultatif)",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {area:28} Western Plaguelands · {area:2279} Stratholme
	["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:2057} ({area:2298}, au sud-est des {area:28}) ou {area:2279} au lieu de tuer des monstres en boucle vous y amène plus vite en groupe. Passez cette étape pour monter seul.",
	-- {area:2057} Scholomance · {quest:5505} The Key to Scholomance · {area:3197} Chillwind Camp
	["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} convient aux niveaux 58 à 60 ; {quest:5505} se rend au {area:3197}, plus bas.",

	-- Step 95: Level 59.93
	["Level 59.93"] = "",
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {area:3197} Chillwind Camp · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there. Top up here to level 59.93 before the hand-ins at {area:3197}: they take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "tuez des {npc:14564} à {area:2627}, {zone:1423}",

	-- Step 97: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "Revenez vers le sud-ouest jusqu'au {area:3197}.",
	-- {zone:1453} Stormwind
	["Flint's next task goes to {zone:1453}: you are level 60 now, skip it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "Retournez à {area:1770} : {npc:9861} et {npc:9860} gardent {npc:9517} dans la salle la plus profonde.",
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "Retournez dans {area:1770} : {npc:9861} et {npc:9860} gardent {npc:9517} dans sa salle la plus profonde.\nAttention : les trois boss combattent ensemble. Tuez d'abord les monstres proches pour ne pas attirer d'ennemis en plus.",
	-- ["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Traversez la rivière à l'est de {npc:1855} jusqu'à Val-Terreur. Les Esprits de {area:2627} hantent les bois.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Les Écraseurs térébrants parcourent les dunes entre {area:2743} et {area:3425}, sur votre chemin du retour. {npc:15181} ne propose {quest:8304} qu'à partir du niveau 58.",
	-- ["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Prenez un vol pour {area:3137} en {area:16} et chevauchez vers l'ouest le long de la route jusqu'au {area:2358}, juste après la frontière d'{zone:1440}.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Suivez la route vers le sud-ouest à la sortie du col jusqu'à {area:3425}.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Redescendez à {area:702}, prenez le bateau pour {area:442} puis le bateau pour {area:17203}. Apportez soixante Etoffes de soie, soixante Etoffes de tisse-mage et soixante {item:14047} pour {npc:14722} : achetez ce qui vous manque à l'hôtel des ventes.",
	-- ["Grind to 58"] = "Monter au niveau 58",
	-- ["Grind to 59"] = "Monter au niveau 59",
	-- ["Grind to 60"] = "Monter au niveau 60",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Pierre de foyer vers {area:1519} et apprenez vos sorts de niveau 60. C'est la fin de l'itinéraire de progression : consultez ensuite les guides de réputation et de donjons.",
	-- ["Hearth to {area:3425}"] = "Pierre de foyer vers {area:3425}",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Pierre de foyer vers {area:392} et vol pour {area:976}. Achetez ici deux Barres de thorium à l'hôtel des ventes pour {quest:5801}.",
	-- ["Into {zone:1451}"] = "Vers {zone:1451}",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Continuez vers l'ouest sur la route jusqu'au camp de {npc:9298}, à côté des sources chaudes.",
	-- ["Level 60"] = "Niveau 60",
	-- ["Ride back north to {area:2255} and west along the road to the night elf village."] = "Revenez vers le nord jusqu'à {area:2255}, puis vers l'ouest par la route jusqu'au village elfe de la nuit.",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "Revenez à {area:3137} et prenez un vol pour {area:2255}.",
	-- ["Ride north out of {area:415} into {area:361} to the druids' camp on the road just past the border."] = "Sortez d'{area:415} vers le nord jusqu'en {area:361}, jusqu'au camp des druides sur la route, juste après la frontière.",
	-- ["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Chevauchez vers le nord hors de {area:415} jusqu'en {zone:1448}, jusqu'au camp des druides sur la route juste après la frontière.",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Chevauchez vers le sud jusqu'à {area:2250}. Protégez {npc:10300} pendant qu'elle allume les torches en route vers l'{object:177404}.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Chevauchez vers l'ouest le long de la paroi nord du cratère jusqu'au col du coin nord-ouest qui monte vers {zone:1451}.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:2057} ({area:2298}, sud-est de {zone:1422}) ou {area:2279} au lieu de tuer des monstres vous y mène plus vite en groupe. Passez cette étape pour monter de niveau en solo.",
	-- ["Shaman training"] = "Entraînement de chaman",
	-- ["Sixty {item:2592}, if you carry them"] = "Soixante {item:2592}, si vous en avez",
	-- ["Stormwind City"] = "Cité de Hurlevent",
	-- ["Take the boat from {area:442} to {area:702}."] = "Prenez le bateau d'{area:442} pour {area:702}.",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "Prenez le trajet aérien de {area:2361} et volez jusqu'à {area:442}.",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Prenez le tunnel de {area:1769} par son entrée côté {area:618}, à l'ouest de {npc:9298}, et suivez la branche vers {area:493} jusqu'à {area:2361}. {npc:11939} étudie sur la rive du lac.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest.\nCareful: Jadefire Shadowstalkers are level 51-52 and move stealthed. They use {spell:7992} and are found about 550 yd south of {area:1997}.\nCareful: Jadefire Shadowstalkers sneak around and use {spell:7992}."] = "Prenez le {area:2257} jusqu'à {zone:1455}. {npc:14724} et {npc:14723} prennent chacun soixante Étoffes de laine, soixante Étoffes de soie et soixante Étoffes de tisse-mage, puis soixante {item:14047} : rendez ce que vous portez (ou achetez à l'hôtel des ventes), laissez le reste.\nAttention : les Traqueurs des ombres Jadefeu sont de niveau 51-52 et se déplacent camouflés. Ils utilisent {spell:7992} et se trouvent à environ 550 m au sud de {area:1997}.\nAttention : les Traqueurs des ombres Jadefeu rôdent camouflés et utilisent {spell:7992}.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Prenez le {area:2257} jusqu'à {zone:1455}. {npc:14724} et {npc:14723} veulent chacun soixante Etoffes de laine, soixante Etoffes de soie et soixante Etoffes de tisse-mage, puis soixante {item:14047} : 120 de chaque en tout, de vos sacs ou de l'hôtel des ventes.",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Les ours {npc:7446} parcourent la vallée enneigée au sud de {area:2250}.",
	-- ["Toward the north-west pass"] = "Vers le col nord-ouest",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Vous commencez à {area:392}, où le guide précédent vous a renvoyé par la pierre de foyer. Prenez un vol pour {area:415}.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "tuez des {npc:11741} dans les dunes à l'est de {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "tuez des {npc:14564} à {area:2627}, {area:139}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "tuez des {npc:7446} dans la vallée au sud de {area:2250}, {zone:1452}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} est la grotte au fond de {area:1763}, à l'ouest de la route. Utilisez l'{item:12906} sur les quatre braseros à l'intérieur. Tuez les ours de la griffe colérique et les loups Gangrepatte en chemin pour les {item:11172}.",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "{area:1770} est la grotte au fond de {area:1763}, à l'ouest de la route. Utilisez l'{item:12906} sur les quatre braseros à l'intérieur. Tuez les ours de la griffe colérique et les loups Gangrepatte que vous croisez pour les {item:11172}.\nAttention : des monstres du Conseil des ombres de niveau 53-55 remplissent la grotte et viennent souvent en grands groupes liés, beaucoup avec des étourdissements. Un groupe de 2-3 joueurs est conseillé.",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} convient aux niveaux 55 à 60 ; tuer des {npc:7446} ci-dessous vous mène seul au niveau 59.",
	-- ["{area:3425} flight master"] = "Maître de vol de {area:3425}",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300} : son escorte viendra plus tard sur l'itinéraire",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924} : se termine au {zone:1452}, gardez-la",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, si vous avez trente {quest:6031}",
	-- ["{npc:11557}, if you have thirty {quest:6031}; below ground"] = "{npc:11557}, si vous avez trente {quest:6031} ; sous terre",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, juste à l'intérieur de la grotte : seulement à partir de Neutre avec les Grumegueule",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw; walks around here: look inside the circle on the map"] = "{npc:11558}, juste à l'entrée de la grotte : seulement à partir de Neutre avec les Grumegueules ; se promène ici : cherchez à l'intérieur du cercle sur la carte",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}, l'aubergiste",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} campe devant {area:2743}, la ruche ouest. Ramassez de la Silithyst à l'un des geysers rouges voisins et portez-la à l'extracteur de l'Alliance de son camp.",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, aux tentes de l'Alliance",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791} : le guide précédent vous ramène ici par la pierre de foyer, cette étape se coche donc généralement aussitôt",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} attend à {area:1767}. Escortez-la hors des bois et gardez-la en vie.",
	-- ["{object:176091}, if you found the Firewater flask in {area:618}"] = "{object:176091}, si vous avez trouvé la flasque d'eau de feu au {area:618}",
	-- ["{object:176091}, if you found the Firewater flask in {zone:1452}"] = "{object:176091}, si vous avez trouvé le flacon d'eau de feu au {zone:1452}",
	-- ["{object:210335} Fragments"] = "Fragments de {object:210335}",
	-- ["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "{quest:5085} : {npc:9298} au {area:618}, gardez-la",
	-- ["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "{zone:1451}, {area:361}, {area:618} et les Maleterres",
	-- ["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453} n'a pas de maître des chamans : prenez le {area:2257} depuis {object:28027} jusqu'à {zone:1455} et apprenez vos sorts de niveau 60 auprès de {npc:258098}.",
}
