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
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands."] = "{zone:1451}, {zone:1448}, {zone:1452} et les Maleterres.",
	["Takes you all the way to 60"] = "Vous mène jusqu'au niveau 60",
	["Stays on the main route"] = "Reste sur l'itinéraire principal",
	-- {area:493} Moonglade
	["{area:493} flight path on the way"] = "Trajet aérien de {area:493} en chemin",
	["Lots of flying between zones"] = "Beaucoup de vols entre les zones",

	-- Step 1: Back from Mount Hyjal
	-- {zone:2482} Mount Hyjal
	["Back from {zone:2482}"] = "",
	-- {zone:1452} Winterspring · {area:392} Ratchet
	["Coming back from Hyjal? Finish the nearby {zone:1452} errands first. Once you reach 60 you can stop; {area:392} and the rest of the guide are still there if you want to finish your quest log."] = "",
	-- {npc:11755} Harlo Wigglesworth · {area:2255} Everlook
	["{npc:11755}, in {area:2255}"] = "",

	-- Step 2: Winterfall Village
	-- {npc:11556} Salfa · {quest:8464} Winterfall Activity · {area:2255} Everlook · {npc:10738} High Chief Winterfall
	["{npc:11556}'s {quest:8464} waited for this visit: the furbolg village lies just east of {area:2255}, with Shaman (56-57), Den Watchers (55-56) and Ursa (57-58). Kill the Shaman first, they heal. {npc:10738} in the cave at the back is elite: stay out."] = "{quest:8464} de {npc:11556} attendait cette visite : le village furbolg se trouve juste à l'est de {area:2255}, avec des Chamans (56-57), des Guetteurs de la tanière (55-56) et des Ursa (57-58). Tuez d'abord les Chamans, ils soignent. Le {npc:10738}, dans la grotte au fond, est élite : n'y allez pas.",

	-- Step 3: Starfall Village
	-- {area:2253} Starfall Village
	["Ride north-west up the road to {area:2253}."] = "Remontez la route vers le nord-ouest jusqu'au {area:2253}.",

	-- Step 4: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "Camp de {npc:10301}",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride back east past {area:2255} and south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Revenez vers l'est en passant {area:2255}, puis descendez la vallée vers le sud-est jusqu'à la caisse endommagée de {npc:10301}, dans la neige à {area:2245}, avec son chariot détruit juste à l'est.",

	-- Step 5: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "Fournitures de {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Ramassez les fournitures autour du chariot et reprenez l'amulette de {npc:10301} aux chouettards voisins.",

	-- Step 6: Ranshalla
	-- {npc:10300} Ranshalla · {area:2250} Owl Wing Thicket · {area:2255} Everlook · {object:177404} Altar of Elune
	["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300} attend au {area:2250}, au sud d'{area:2255}.\nProtégez {npc:10300} pendant qu'elle allume les torches sur le chemin de l'{object:177404}.",

	-- Step 9: Donova Snowden
	["Keep this for the next visit to the gorge mouth"] = "",

	-- Step 10: Everlook flight master
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",
	["Maethrya, the Alliance flight master"] = "",

	-- Step 11: Marshal's Refuge flight master
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Maître de vol de {area:541}",
	["Gryfe, the flight master"] = "",

	-- Step 12: Reach Ratchet
	-- {area:392} Ratchet
	["Reach {area:392}"] = "",
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:16227} Bragok
	["Reach {area:392} by an available route. If your flight master offers Theramore instead, fly there, ride west into the {zone:1413} and follow the road north to {area:392}. Speak to {npc:16227} in town if you still need the flight path."] = "",

	-- Step 13: Ratchet flight master
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",

	-- Step 14: Ratchet
	-- {npc:8496} Liv Rizzlefix · {area:392} Ratchet · {zone:1452} Winterspring · {area:2255} Everlook · {area:541} Marshal's Refuge
	["{npc:8496} is in {area:392}. From {zone:1452}, leave by Maethrya in {area:2255}; from Un'Goro, leave by Gryfe at {area:541}."] = "",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}, à l'intérieur",

	-- Step 15: Fly to Talrendis Point
	-- {area:3137} Talrendis Point
	["Fly to {area:3137}"] = "Prendre un vol pour {area:3137}",

	-- Step 16: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 17: The Emerald Sanctuary
	-- {area:3137} Talrendis Point · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "Depuis {area:3137}, chevauchez jusqu'en {zone:1448} : le {area:2479} est le camp des druides sur la route, juste après la frontière de {zone:1440}.",
	["Inside"] = "À l'intérieur",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Patientez un instant pour {npc:9116}",

	-- Step 18: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Braseros de {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "{area:1770} est la grotte au fond de {area:1763}, à l'ouest de la route. Utilisez l'{item:12906} sur les quatre braseros à l'intérieur. Tuez les ours de la griffe colérique et les loups Gangrepatte que vous croisez pour les {item:11172}.\nAttention : des monstres du Conseil des ombres de niveau 53-55 remplissent la grotte et viennent souvent en grands groupes liés, beaucoup avec des étourdissements. Un groupe de 2-3 joueurs est conseillé.\nLes Tisseurs des ténèbres, Démonistes et Massacreurs de Jaedenar d'ici lâchent une {item:13140}, environ une victime sur trente : continuez à les tuer jusqu'à ce qu'elle tombe. Elle ouvre la cellule de {npc:11018}, l'elfe de la nuit retenue dans la grotte.",
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
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}, dans sa cellule ; sous terre",

	-- Step 19: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "Faites-la sortir de {area:1770} et gardez-la en vie jusqu'à ce qu'elle soit hors de la grotte : dégagez d'abord le chemin du retour.",

	-- Step 21: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager · Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north.\nCareful: Ancient Irontree Walkers, level 59 elites, stand among the treants in the middle of {area:1767}: take the Stompers on the north side (about 48,21)."] = "Suivez la route vers le nord jusqu'à {area:1767}. Les Arbrefer marteleurs portent le cœur ; finissez les griffes sur les Grizzlys de la griffe colérique et les Ravageurs Gangrepatte du nord.\nAttention : des Anciens marcheurs Arbrefer, des élites de niveau 59, se tiennent parmi les tréants au milieu de {area:1767} : prenez les marteleurs du côté nord (vers 48,21).",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Arbrefer marteleurs",

	-- Step 22: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598} attend au {area:1767}. Escortez-la hors des bois et gardez-la en vie.\nAttention : trois {quest:5086} vous tendent une embuscade peu après le début de l'escorte.",

	-- Step 23: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Chevauchez vers le nord jusqu'au village des furbolgs Mort-bois, près de l'entrée de la grotte de {area:1769}.",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085} : {npc:9298} au {zone:1452}, gardez-la",

	-- Step 24: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {npc:9518} Rakaiah
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber. The succubus {npc:9518} waits on the way, with Trey Lightforge's remains beside her.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "Retournez dans {area:1770} : {npc:9861} et {npc:9860} gardent {npc:9517} dans sa salle la plus profonde. La succube {npc:9518} attend en chemin, avec les restes de Trey Lightforge à côté d'elle.\nAttention : les trois boss combattent ensemble. Tuez d'abord les monstres proches pour ne pas attirer d'ennemis en plus.",
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

	-- Step 25: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "Revenez vers le sud par la route jusqu'au sanctuaire.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, à l'intérieur",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Gardez le {item:11169}, les griffes et le cœur qu'il vous rend",

	-- Step 26: Forest Song
	-- {zone:1448} Felwood · {area:3137} Talrendis Point · {npc:3848} Kayneth Stillwind · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Ride south out of {zone:1448} toward {area:3137}: {npc:3848}'s camp at {area:2358} is just over the {zone:1440} border, on the way."] = "Chevauchez vers le sud en sortant de {zone:1448} en direction de {area:3137} : le camp de {npc:3848} au {area:2358} se trouve juste après la frontière de {zone:1440}, sur le chemin.",

	-- Step 28: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",
	-- {npc:9616} Laris Geardawdle · {zone:1455} Ironforge · {zone:1452} Winterspring · {area:976} Gadgetzan
	["{npc:9616}'s jars went to {zone:1455} on the {zone:1452} guide's {zone:1455} stop: fly straight to {area:976}."] = "Les jarres de {npc:9616} sont allées à {zone:1455} lors de l'étape à {zone:1455} du guide de {zone:1452} : prenez directement un vol pour {area:976}.",
	-- {area:3137} Talrendis Point
	["{area:3137} flight master"] = "Maître de vol de {area:3137}",

	-- Step 29: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",

	-- Step 30: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 31: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maître de vol de {area:150}",

	-- Step 32: Laris Geardawdle
	["Its jars are filled on the Un'Goro visit"] = "Ses pots se remplissent lors de la visite à Un'Goro",

	-- Step 33: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 35: Fly to Gadgetzan
	["Theramore flight master"] = "Maître de vol de Theramore",

	-- Step 36: Gadgetzan
	-- {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Prenez un vol pour {area:976}. Achetez ici deux Barres de thorium à l'hôtel des ventes pour {quest:5801}.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, à l'intérieur",
	-- {npc:5411} Krinkle Goodsteel · {area:537} Fire Plume Ridge
	["{npc:5411}: take this before {area:537}"] = "",

	-- Step 37: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Chevauchez vers l'est dans les collines. Utilisez le {item:11169} pour invoquer {quest:4005}, puis vainquez-le pour obtenir le totem.",

	-- Step 38: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Chevauchez vers le sud-ouest jusqu'au camp de {npc:7771}, à {area:1938}.",

	-- Step 40: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Prenez la route vers l'ouest qui descend dans le cratère et chevauchez jusqu'à la {area:540}, la grotte silithide au sud. La {npc:10041} attend dans sa salle la plus profonde.",

	-- Step 41: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Gravissez {area:537}, au milieu du cratère, et utilisez le {item:14644} près du lac de lave au sommet, avec deux Barres de thorium dans vos sacs. Remplissez les Pots d'échantillon pur vides de {npc:9616} sur les Limons primitifs des mares autour de la crête.",
	["Use the jars on slain oozes"] = "Utilisez les pots sur les limons tués",

	-- Step 42: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Chevauchez vers le nord jusqu'à {area:541}. Utilisez {npc:10980} à côté de {npc:10977}.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, sous terre",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, au fond du refuge",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "Effrayez {npc:10977} avec {npc:10980}",

	-- Step 43: Fly to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Fly to {area:3425}"] = "Prendre un vol pour {area:3425}",

	-- Step 44: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} se tient à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",
	-- {npc:17082} Rifleman Torrig · {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora
	["{npc:17082}, at the Alliance tents: for {npc:17080} at {area:2743}"] = "{npc:17082}, aux tentes de l'Alliance : pour le {npc:17080} à {area:2743}",
	-- {npc:15181} Commander Mar'alith
	["{npc:15181}: Bronzebeard's Encampment comes later, on the way south"] = "{npc:15181} : le campement de Barbe-de-bronze viendra plus tard, en route vers le sud",
	-- {npc:15183} Geologist Larksbane
	["{npc:15183}: the tablet fragments come from the Twilight dig"] = "{npc:15183} : les fragments de tablette viennent des fouilles du crépuscule",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: his Twilight texts come from the dig after the next stop here"] = "{npc:15306} : ses textes du crépuscule viennent des fouilles, après la prochaine étape ici",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189}, upstairs"] = "{npc:15189}, à l'étage",

	-- Step 45: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451} : tuez-les au passage",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["From the hold, west into the sands: Dredge Crushers dig there; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Depuis le fort, à l'ouest dans les sables : des Ecraseurs térébrants y creusent ; des Pinceurs Cinglepierre, des Écorcheurs et des Traqueuses des rochers chassent dans les mêmes sables.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741} se promène par ici : cherchez dans le cercle sur la carte",

	-- Step 46: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "{npc:15190}, à l'étage à côté de {npc:15189}",

	-- Step 47: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "{area:2742} : tuez-les au passage",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell · {area:2742} Hive'Ashi
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Twilight Avengers = {npc:11880} Twilight Avenger · Twilight Flamereavers = {npc:15201} Twilight Flamereaver
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later.\nCareful: take the texts from the Twilight Avengers and Geolords; leave the Twilight Flamereavers (60) and stay out of the hive's mouth, where the {area:2742} elites (59-60) wait."] = "Les fouilles du Marteau du crépuscule occupent le coin nord-ouest : des fragments de tablette jonchent le sol, et les Tempétueux de poussière et Grondeurs du désert en portent aussi. Tout sectateur peut laisser tomber un {item:20404} : gardez-en vingt, dix pour {npc:15306} et dix pour {npc:15194} plus tard.\nAttention : prenez les textes sur les Vengeurs du crépuscule et les Géoseigneurs ; laissez les Flammes ravageuses du crépuscule (60) et restez hors de l'entrée de la ruche, où attendent les élites de {area:2742} (59-60).",
	["Twilight's Hammer cultists"] = "Sectateurs du Marteau du crépuscule",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Fragments de la Tablette du crépuscule ({item:20378})",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Dix de plus pour {quest:8323}",

	-- Step 48: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {spell:642} Divine Shield · {spell:5384} Feign Death · {spell:17} Power Word: Shield
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080} campe devant {area:2743}, la ruche ouest. Ramassez de la silithyste à l'un des geysers rouges proches et portez-la jusqu'à l'extracteur de l'Alliance, à son camp.\nAttention : vous perdez la silithyste si vous montez en selle, vous camouflez, utilisez {spell:642}, {spell:5384} ou Disparition. Transfert et {spell:17} ne la font pas tomber.",

	-- Step 50: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Chevauchez vers l'est jusqu'aux ruines de {area:2738}. Le {object:179565} se trouve parmi les bâtiments en ruine, surveillé par des Sentinelles torturées.",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "{object:179565} ; à l'intérieur",

	-- Step 51: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "L'ermite se cache parmi les rochers au sud-est de {area:2738}.",
	["Below ground"] = "Sous terre",

	-- Step 52: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Campement de Bronzebeard",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand south-east of the camp, where Deathclasp, an elite scorpid, patrols: grab it while he is away."] = "Chevauchez vers le sud-ouest jusqu'au camp des nains près des montagnes du sud et interrogez {npc:15171} et {npc:15170}. La Sacoche de {npc:15190} se trouve dans le sable au sud-est du camp, là où patrouille Poigne-de-mort, un scorpide élite : prenez-la pendant qu'il est éloigné.",

	-- Step 53: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["Careful: the Twilight Keepers are level 60, a level or two over you: clear the cultists around each one first and fight the keeper at full health.\n{npc:11803} holds the cultists' camp in the far south-west."] = "Attention : les Gardiens du crépuscule sont niveau 60, un ou deux niveaux au-dessus de vous : éliminez d'abord les sectateurs autour de chacun et affrontez le gardien avec toute votre vie.\nLe {npc:11803} tient le camp des sectateurs, tout au sud-ouest.",

	-- Step 54: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp.\nCareful: Mayna is level 60: clear her camp first and fight her at full health."] = "Chevauchez vers le nord le long du côté ouest jusqu'au petit camp de Mayna.\nAttention : Mayna est niveau 60 : nettoyez d'abord son camp et affrontez-la avec toute votre vie.",

	-- Step 55: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}.\nCareful: Havunth is level 60: clear his camp first and fight him at full health."] = "Le camp d'Havunth se trouve juste à l'ouest de {area:3425}.\nAttention : Havunth est niveau 60 : nettoyez d'abord son camp et affrontez-le avec toute votre vie.",

	-- Step 56: Hermit Ortell
	["Ride back south-east to the hermit."] = "Revenez vers le sud-est jusqu'à l'ermite.",
	["Hand him the ten texts you kept"] = "Remettez-lui les dix textes que vous avez gardés",

	-- Step 57: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} se tient à l'étage de son bâtiment : montez par l'intérieur, la flèche ne distingue pas les étages.",

	-- Step 58: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "Prenez un vol pour {area:976}.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} à {zone:1457} : gardez-la",

	-- Step 59: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Prendre un vol pour {area:2255}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maître de vol de {area:976}",

	-- Step 68: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Hederine Slayers = {npc:7463} Hederine Slayer · Rabid Shardtooths = {npc:7446} Rabid Shardtooth
	["Follow {npc:9298}'s directions south to the mouth of {area:2256}. Careful: Frostmaul Giants and Preservers (59-60, elite) stand on both sides of the road just north of it: keep to the road on the east side (about 62,67) and don't stop. The point is at the gorge's mouth: touch it and turn back north. Don't ride into the gorge: Hederine Slayers, Initiates and Manastalkers (57-60, elite) stand from just past the mouth to its far end, and Rabid Shardtooths (59) roam the way in."] = "",
	["The road past the Frostmaul giants"] = "",
	-- {area:2256} Darkwhisper Gorge
	["The road to {area:2256}"] = "",

	-- Step 69: Starfall Village
	-- {area:2255} Everlook · {area:2253} Starfall Village
	["Ride north up the valley, past {area:2255}, to {area:2253}."] = "Remontez la vallée vers le nord, en passant {area:2255}, jusqu'à {area:2253}.",

	-- Step 71: Felwood
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "Les {quest:5086}",

	-- Step 72: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "Attention : des Anciens marcheurs Bois-de-fer, des élites de niveau 59, se tiennent parmi les {quest:5086} : attaquez les Horreurs à la pointe nord-est du camp (vers 50.6,22.4), une à la fois, et cherchez un marcheur des yeux avant chaque attaque.",

	-- Step 73: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["{npc:11558} stands just inside the {area:1769} cave: she speaks to you from Neutral with the Timbermaw, which the Winterfall furbolgs you ground in {zone:1452} brought you to."] = "{npc:11558} se tient juste à l'entrée de la grotte de {area:1769} : elle vous parle à partir de Neutre auprès des Grumegueules, réputation que vous ont value les furbolgs Tombe-hiver tués dans le {zone:1452}.",
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "{npc:11558}, juste à l'entrée de la grotte : se promène ici : cherchez à l'intérieur du cercle sur la carte",

	-- Step 74: Kernda
	-- {area:1762} Felpaw Village · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then."] = "Le totem Mort-bois de {area:1762}, si {npc:11558} ne l'a pas pris à ce moment-là.",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558} : se promène ici : cherchez à l'intérieur du cercle sur la carte",

	-- Step 75: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth · {zone:1452} Winterspring
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw: the {zone:1452} top-up on the Winterfall furbolgs gets you both."] = "{npc:11557}, juste à l'entrée de la grotte à côté de {npc:11558}, prend trente {quest:6031} à partir d'Amical auprès des Grumegueules : le complément d'expérience sur les furbolgs Tombe-hiver dans le {zone:1452} vous apporte les deux.",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557} ; sous terre",

	-- Step 79: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452} : tuez-les au passage",
	-- {spell:5384} Feign Death
	["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "Les furbolgs Tombe-hiver de l'ouest laissent tomber les perles.\nAttention : rendre la quête fait apparaître trois ou quatre embusqués Tombe-hiver de niveau 56-57 qui vous attaquent ; vous pouvez leur échapper en monture, camouflé ou avec {spell:5384}, et ils se rassemblent ensuite près du lac, ce qui vous permet de prendre la quête suivante.",

	-- Step 83: Umber
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Prenez le tunnel de {area:1769} par son entrée du {zone:1452}, à l'ouest de {npc:9298}, et suivez la branche de {area:493} jusqu'à {area:2361}. {npc:11939} étudie au bord du lac.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} se promène autour de {area:2361} : cherchez dans le cercle sur la carte",

	-- Step 84: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "La maison de {npc:11801} se trouve à {area:2361}, à l'est de {npc:11939}.",

	-- Step 87: Sindrayl
	-- {npc:10897} Sindrayl · {area:493} Moonglade · {area:2361} Nighthaven
	["{npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn."] = "{npc:10897}, le maître de vol de {area:493}, se tient au sud du lac, à l'extérieur de {area:2361} : apprenez le trajet aérien auprès d'elle. La maîtresse de vol de {area:2361} même ne transporte que les druides, via son dialogue, et n'a pas de trajet aérien à apprendre.",

	-- Step 88: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",

	-- Step 89: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "Le vol atterrit au {area:702}. {npc:7916} se tient à quelques pas au nord-ouest du maître de vol.",

	-- Step 91: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Prenez le portail pour monter à {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, dans le Temple de la Lune",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}, à la banque",

	-- Step 93: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, au sommet de {area:1658}",

	-- Step 94: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portail vers {zone:1438}",

	-- Step 95: Fly to Auberdine
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maître de vol du {area:702}",

	-- Step 97: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Prendre un vol pour {zone:1453}",

	-- Step 98: Stormwind
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, qui se promène le long des canaux",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "Pour {npc:10778} : gardez-la",

	-- Step 99: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, au SI:7",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} au {area:3197} : gardez-la",

	-- Step 100: Stormwind
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

	-- Step 101: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 102: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "Prenez le {area:2257} jusqu'à {zone:1455}. {npc:14724} et {npc:14723} prennent chacun soixante Étoffes de laine, soixante Étoffes de soie et soixante Étoffes de tisse-mage, puis soixante {item:14047} : rendez ce que vous portez (ou achetez à l'hôtel des ventes), laissez le reste.",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} n'a pas de maître des chamans",

	-- Step 103: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prendre un vol pour {area:271}",

	-- Step 107: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} est un élite de niveau 61",
	-- {quest:6184} Flint Shadowmore · {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["{quest:6184}: the agents' remains lie at the {area:2260} in the {zone:1423}"] = "{quest:6184} : les restes des agents se trouvent à {area:2260}, dans les {zone:1423}",
	-- {npc:11053} High Priestess MacDonnell · {area:201} Gahrron's Withering
	["{npc:11053}: {area:201}'s cauldron, on this loop"] = "{npc:11053} : le chaudron de {area:201}, sur cette boucle",

	-- Step 108: Andorhal
	["Andorhal"] = "Ruines d'Andorhal",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} attend dans l'auberge en ruine du côté ouest des Ruines d'Andorhal, la ville en ruine au nord du camp. {npc:1852} garde son phylactère au milieu de la ville.",
	["Araj is elite: grouping up is advised."] = "Araj est élite : mieux vaut être en groupe.",

	-- Step 109: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "Le fantôme de {npc:10778} erre près de la ferme de {area:199}, à l'ouest d'Andorhal. Les Goules jacassantes du champ portent l'autre moitié du charme : combinez les deux moitiés.",
	["Upstairs"] = "À l'étage",

	-- Step 110: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Remontez la route vers le nord jusqu'à la scierie et posez le tonneau de termites en son centre.",

	-- Step 111: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the Northridge lumber camp's edge."] = "{npc:11610} se cache en bordure du camp de bûcherons de Northridge.",

	-- Step 112: Radley and Durgen
	["Radley and Durgen"] = "Radley et Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} parcourt le camp de Crête-du-Nord à l'est de {npc:11610} ; {npc:11611} garde la tour à l'approche sud de {area:190}.\nAttention : des gardes se tiennent au pied de la tour et un autre en fait le tour en patrouille. Éliminez-les avant d'engager Durgen pour qu'ils ne se joignent pas au combat.",

	-- Step 113: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["{npc:11610} hides at the lumber camp's edge."] = "{npc:11610} se cache en bordure du camp de bûcherons.",

	-- Step 114: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Surplomb de {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Montez sur la colline à l'ouest de {area:190} pour dominer la ville.\nAttention : les sentinelles postées à la porte peuvent détecter les joueurs camouflés. D'autres sentinelles se trouvent dans la ville, et un élite patrouille à proximité.",

	-- Step 115: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1839} Scarlet High Clerist
	-- plural, as words: Scarlet Paladins = {npc:1834} Scarlet Paladin
	["Careful: Scarlet Paladins (55-56) and priests guard {item:12954} inside {area:190}'s town hall. They are elite, and a {npc:1839} (63, elite) stands near the book. Go in with your group; stay out of the Clerist's reach."] = "",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "",

	-- Step 117: Gahrron's Withering
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath · {item:12955} Redpath's Shield
	["Ride south-east to {area:201}: {npc:11078} guards the cauldron, and {item:12955} lies east of the barn."] = "Chevauchez vers le sud-est jusqu'à {area:201} : le {npc:11078} garde le chaudron, et le {item:12955} se trouve à l'est de la grange.",
	-- {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp
	["For {npc:11053} at {area:3197}, at the end of this guide"] = "Pour la {npc:11053} au {area:3197}, à la fin de ce guide",

	-- Step 119: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (facultatif)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} vit dans une petite hutte au bord de la rivière frontalière, au nord-est du camp de bûcherons. Rendez {quest:5781} si vous l'avez terminée.",

	-- Step 120: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "Le lac pour {quest:5845}",

	-- Step 121: Of Lost Honor
	["Underwater"] = "Sous l'eau",

	-- Step 122: Light's Hope Chapel
	["Ride south-east from the lake to the chapel."] = "Chevauchez vers le sud-est depuis le lac jusqu'à la chapelle.",

	-- Step 124: Carlin Redpath: the Scourge Champions
	-- {npc:11063} Carlin Redpath
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{npc:11063}: the Scourge Champions"] = "",

	-- Step 125: Caretaker Alen
	-- {npc:11038} Caretaker Alen · {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: {npc:11140} is in {area:2627}, keep it"] = "{npc:11038}, près des tombes au sud de la chapelle : {npc:11140} est à {area:2627}, gardez-la",

	-- Step 126: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Champions du Fléau",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Les Champions du Fléau (59) parcourent {area:2270}, au nord de {area:2268}. Passez le {item:13156} de {npc:11063} au-dessus de chacun d'eux une fois tué : les crânes qui entrent en résonance sont ceux qu'il veut. Attirez-les un par un.",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}, sur les Champions du Fléau",

	-- Step 127: Light's Hope Chapel
	-- {npc:10667} Chromie
	["{npc:10667} in Andorhal: keep it"] = "{npc:10667} à Andorhal : gardez-la",

	-- Step 128: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Chevauchez vers le nord jusqu'à la lisière nord-est de {area:2277}.\nAttention : les trolls le long du chemin vers {area:2273} sont de niveau 57-59. Ils fuient quand leur vie est basse et appellent à l'aide, alors ils ramènent souvent des renforts.",

	-- Step 129: Tirion Fordring
	-- {quest:5845} Of Lost Honor
	["{quest:5845}: the route takes it and fetches the Symbol, so its hand-in holds"] = "{quest:5845} : l'itinéraire la prend et va chercher le Symbole, donc son rendu est maintenu",

	-- Step 130: Egan
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {npc:11140} Egan
	["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "Traversez la rivière à l'est de la cabane de {npc:1855} jusqu'à {area:2627} : {npc:11140} se tient près de la cabane en ruine d'Augustus.",

	-- Step 131: Level 59.85
	["Level 59.85"] = "Niveau 59.85",
	-- {npc:11140} Egan · {area:2627} Terrordale · {area:2261} Undercroft · {area:2298} Caer Darrow · {npc:10667} Chromie · {area:3197} Chillwind Camp · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["The Terrordale Spirits haunt the woods around {npc:11140}. Top up here to level 59.85 while you stand in {area:2627}: the hand-ins still to come (the {area:2261}, {area:2298}, {npc:10667} and {area:3197}) take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "Les Esprits de Val-Terreur hantent les bois autour de {npc:11140}. Montez ici jusqu'au niveau 59.85 tant que vous êtes à {area:2627} : les rendus encore à venir ({area:2261}, {area:2298}, {npc:10667} et {area:3197}) vous font passer au niveau 60. Ou, en groupe, faites plutôt le donjon {area:2057} ou le donjon {area:2279}.",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "tuez des {npc:14564} à {area:2627}, {zone:1423}",

	-- Step 132: Marris Stead
	-- {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride south to the {area:2260}, the farm north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it. Coming close enough to see the Blightcaller in front of the house completes the scouting.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "Chevauchez vers le sud jusqu'à {area:2260}, la ferme au nord-ouest de {area:2262}. Les restes des trois agents sont des silhouettes d'ossements au sol : un près de la route au sud de la ferme, un sur la colline à l'est de la maison, un sur le tertre devant elle. S'approcher assez pour voir le Flétrisseur devant la maison achève la reconnaissance.\nAttention : {npc:11878} (élite de niveau 62) et ses chiens élites se tiennent devant la maison : prenez les restes du tertre par le côté et ne l'attirez pas. Vous n'avez pas à le combattre.",

	-- Step 133: Undercroft
	-- {area:2261} Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Chevauchez vers le sud-ouest jusqu'à {area:2261}. Le monticule de terre se trouve à l'intérieur. {npc:11886} est élite : mieux vaut être en groupe.\nAttention : environ quatre renforts non élites accompagnent Mercutio. Ils marchent jusqu'à la tombe au lieu d'apparaître sur place.",

	-- Step 135: Chromie
	-- {npc:10667} Chromie · {area:3197} Chillwind Camp
	["{npc:10667} waits upstairs in the ruined inn on the west side of Andorhal, on the way back to {area:3197}."] = "{npc:10667} attend à l'étage de l'auberge en ruine, dans la partie ouest d'Andorhal, sur le chemin du retour vers le {area:3197}.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, à l'étage",

	-- Step 137: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "Revenez vers le sud-ouest jusqu'au {area:3197}.",
	-- {zone:1453} Stormwind
	["Flint's next task goes to {zone:1453}: you are level 60 now, skip it."] = "La tâche suivante de Flint mène à {zone:1453} : vous êtes maintenant niveau 60, passez-la.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "Retournez à {area:1770} : {npc:9861} et {npc:9860} gardent {npc:9517} dans la salle la plus profonde.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Les Écraseurs térébrants parcourent les dunes entre {area:2743} et {area:3425}, sur votre chemin du retour. {npc:15181} ne propose {quest:8304} qu'à partir du niveau 58.",
	-- ["Fly from {area:541} to {area:392}."] = "Prenez un vol de {area:541} jusqu'à {area:392}.",
	-- ["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Prenez un vol pour {area:3137} en {area:16} et chevauchez vers l'ouest le long de la route jusqu'au {area:2358}, juste après la frontière d'{zone:1440}.",
	-- ["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Prenez un vol pour {area:3137}, en {zone:1447}, et chevauchez vers l'ouest par la route jusqu'à {area:2358}, juste après la frontière d'{zone:1440}.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Suivez la route vers le sud-ouest à la sortie du col jusqu'à {area:3425}.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Suivez les indications de {npc:9298} Snowden jusqu'à l'entrée de {area:2256}, après les Géants Cognegivre : passez-les un par un.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Redescendez à {area:702}, prenez le bateau pour {area:442} puis le bateau pour {area:17203}. Apportez soixante Etoffes de soie, soixante Etoffes de tisse-mage et soixante {item:14047} pour {npc:14722} : achetez ce qui vous manque à l'hôtel des ventes.",
	-- ["Grind to 58"] = "Monter au niveau 58",
	-- ["Grind to 59"] = "Monter au niveau 59",
	-- ["Grind to 60"] = "Monter au niveau 60",
	-- ["Havunth's camp sits just west of {area:3425}."] = "Le camp de Havunth se trouve juste à l'ouest de {area:3425}.",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Pierre de foyer vers {area:1519} et apprenez vos sorts de niveau 60. C'est la fin de l'itinéraire de progression : consultez ensuite les guides de réputation et de donjons.",
	-- ["Hearth to {area:3425}"] = "Pierre de foyer vers {area:3425}",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["Into {zone:1451}"] = "Vers {zone:1451}",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Continuez vers l'ouest sur la route jusqu'au camp de {npc:9298}, à côté des sources chaudes.",
	-- ["Learn the flight path in {area:2361}."] = "Apprenez le trajet aérien à {area:2361}.",
	-- ["Level 60"] = "Niveau 60",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "Revenez à {area:3137} et prenez un vol pour {area:2255}.",
	-- ["Ride north along the west side to Mayna's small camp."] = "Chevauchez vers le nord par le côté ouest jusqu'au petit camp de Mayna.",
	-- ["Ride north out of {area:415} into {area:361} to the druids' camp on the road just past the border."] = "Sortez d'{area:415} vers le nord jusqu'en {area:361}, jusqu'au camp des druides sur la route, juste après la frontière.",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Chevauchez vers le sud jusqu'à {area:2250}. Protégez {npc:10300} pendant qu'elle allume les torches en route vers l'{object:177404}.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Chevauchez vers l'ouest le long de la paroi nord du cratère jusqu'au col du coin nord-ouest qui monte vers {zone:1451}.",
	-- ["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:2057} ({area:2298}, au sud-est des {area:28}) ou {area:2279} au lieu de tuer des monstres en boucle vous y amène plus vite en groupe. Passez cette étape pour monter seul.",
	-- ["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:2057} ({area:2298}, sud-est de {zone:1422}) ou {area:2279} au lieu de tuer des monstres vous y mène plus vite en groupe. Passez cette étape pour monter de niveau en solo.",
	-- ["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Faire {area:2577}, en {zone:1444}, au lieu de tuer des monstres vous y mène plus vite en groupe. Passez cette étape pour monter de niveau en solo.",
	-- ["Shaman training"] = "Entraînement de chaman",
	-- ["Sixty {item:2592}, if you carry them"] = "Soixante {item:2592}, si vous en avez",
	-- ["Stormwind City"] = "Cité de Hurlevent",
	-- ["Take the boat from {area:442} to {area:702}."] = "Prenez le bateau d'{area:442} pour {area:702}.",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "Prenez le trajet aérien de {area:2361} et volez jusqu'à {area:442}.",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Prenez le tunnel de {area:1769} par son entrée côté {area:618}, à l'ouest de {npc:9298}, et suivez la branche vers {area:493} jusqu'à {area:2361}. {npc:11939} étudie sur la rive du lac.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Prenez le {area:2257} jusqu'à {zone:1455}. {npc:14724} et {npc:14723} veulent chacun soixante Etoffes de laine, soixante Etoffes de soie et soixante Etoffes de tisse-mage, puis soixante {item:14047} : 120 de chaque en tout, de vos sacs ou de l'hôtel des ventes.",
	-- ["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "Les fouilles du Marteau du crépuscule occupent le coin nord-ouest : des fragments de tablette jonchent le sol, et les Tempétueux de poussière et Grondeurs du désert en portent aussi. Tout sectateur peut laisser tomber un {item:20404} : gardez-en vingt, dix pour {npc:15306} et dix pour {npc:15194} plus tard.",
	-- ["The main route to 60: {zone:1451}, {zone:1448}, {zone:1452} and the Plaguelands, with the hand-ins in {zone:1453}, {zone:1455} and {spell:437801} on the way."] = "L'itinéraire principal jusqu'au niveau 60 : {zone:1451}, {zone:1448}, {zone:1452} et les Maleterres, avec les rendus à {zone:1453}, à {zone:1455} et à {spell:437801} en chemin.",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Les ours {npc:7446} parcourent la vallée enneigée au sud de {area:2250}.",
	-- ["To {area:392}"] = "Vers {area:392}",
	-- ["Toward the north-west pass"] = "Vers le col nord-ouest",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Vous commencez à {area:392}, où le guide précédent vous a renvoyé par la pierre de foyer. Prenez un vol pour {area:415}.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "tuez des {npc:11741} dans les dunes à l'est de {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "tuez des {npc:14564} à {area:2627}, {area:139}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "tuez des {npc:7446} dans la vallée au sud de {area:2250}, {zone:1452}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} est la grotte au fond de {area:1763}, à l'ouest de la route. Utilisez l'{item:12906} sur les quatre braseros à l'intérieur. Tuez les ours de la griffe colérique et les loups Gangrepatte en chemin pour les {item:11172}.",
	-- ["{area:2057} (optional)"] = "{area:2057} (facultatif)",
	-- ["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} convient aux niveaux 58 à 60 ; {quest:5505} se rend au {area:3197}, plus bas.",
	-- ["{area:2577} (optional)"] = "{area:2577} (facultatif)",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} convient aux niveaux 55 à 60 ; tuer des {npc:7446} ci-dessous vous mène seul au niveau 59.",
	-- ["{area:3425} flight master"] = "Maître de vol de {area:3425}",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300} : son escorte viendra plus tard sur l'itinéraire",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924} : se termine au {zone:1452}, gardez-la",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, si vous avez trente {quest:6031}",
	-- ["{npc:11557}, if you have thirty {quest:6031}; below ground"] = "{npc:11557}, si vous avez trente {quest:6031} ; sous terre",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, juste à l'intérieur de la grotte : seulement à partir de Neutre avec les Grumegueule",
	-- ["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} tient le camp des sectateurs à l'extrême sud-ouest.",
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
