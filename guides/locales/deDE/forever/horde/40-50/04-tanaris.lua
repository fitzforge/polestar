-- German (deDE): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Flieg nach {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 3: Gadgetzan
	-- {npc:7876} Tran'rek · {area:979} Sandsorrow Watch
	["The flight lands beside {npc:7876}. Take the town's quests before riding west to {area:979}."] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, neben dem Windreitermeister",

	-- Step 5: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "Benutze westlich von Gadgetzan das {item:8584} neben dem Wasserloch im Trolllager.",

	-- Step 6: Senior Surveyor Fizzledowser
	-- {area:976} Gadgetzan · {npc:7771} Marvon Rivetseeker
	["Back east to Fizzledowser on the west side of {area:976}; {npc:7771} is south from there."] = "",

	-- Step 7: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "Nach Westen entlang der Straße nach Süden; {npc:7771} lagert bei den Ruinen an der {area:1938}. Leg seinen {item:9978} an: Er zeigt die vergrabenen Ornamente, hier und rund um das {area:983}.",

	-- Step 8: Broken Pillar: kill these as you meet them
	-- {area:1938} Broken Pillar
	["{area:1938}: kill these as you meet them"] = "",
	-- {area:982} Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "Südlich von {area:982} halten die Oger der Dünenbrecher ihr Truppenlager, mit {npc:12046} am östlichen Ende. Grab zwischen den Kämpfen {quest:3161}-Ornamente aus.",
	["Below ground"] = "",

	-- Step 9: Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["West, the Centipaar insects swarm around their hives; any of them drops the parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "",

	-- Step 10: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "",
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}, seltene Beute",

	-- Step 11: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Eskorte: {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955} wartet im Tal. Bring ihn den ganzen Weg zu seiner Frau {npc:6015} in {area:977}, nach Nordosten durch die Wüste: Bleib nah bei ihm, geh langsam für ihn und wehr ab, was ihn angreift. Steig nicht auf und nutz keinen Ruhestein außerhalb seiner Reichweite. {npc:8579} steht auch im Hafen.",

	-- Step 13: Slake That Thirst
	-- {spell:686} Shadow Bolt
	["Careful: Shadow Mages (level 42-43) call a Voidwalker while out of combat and attack with Immolate and {spell:686}. Thieves can Disarm you, Rogues move around in Sneak, and Assassins use Execute once you are at 20% health or less."] = "",

	-- Step 14: Gadgetzan
	["Use the Model 4711-FTZ Power Source Bilgewhizzle gave you: a two-hour timer starts"] = "",

	-- Step 15: Gadgetzan
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "{item:8526} wächst im {zone:1425}, etwa auf Stufe 48",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",

	-- Step 16: Tanaris Field Sampling
	-- {area:976} Gadgetzan
	-- plural, as words: Blisterpaw Hyenas = {npc:5426} Blisterpaw Hyena · Glasshide Basilisks = {npc:5419} Glasshide Basilisk · Scorpid Hunters = {npc:5422} Scorpid Hunter
	["Just south of {area:976} the Blisterpaw Hyenas, Glasshide Basilisks and Scorpid Hunters share the dunes. Each can drop an untested sample: use it, and it either passes as an acceptable one or is lost. Keep killing until you have eight of each."] = "",

	-- Step 18: Scrimshank's gear
	["Scrimshank's gear"] = "Scrimshanks Ausrüstung",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "",

	-- Step 19: OOX-17/TN
	["OOX-17/TN"] = "OOX-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}.\nCareful: The escort has two ambushes. Three level 47 scorpids attack near the start. Near the end, by the beach, three Wastewander humans attack: one mage and two assassins, around level 44."] = "",

	-- Step 20: Gadgetzan
	-- {npc:5204} Apothecary Zinge · {zone:1458} Undercity
	["for {npc:5204} in the {zone:1458}, around level 52"] = "",
	-- {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["for {npc:7010} in {zone:1454}, around level 50"] = "für {npc:7010} in {zone:1454}, etwa auf Stufe 50",

	-- Step 21: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "",

	-- Step 22: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "",

	-- Step 23: Searing Gorge
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "{area:247}",

	-- Step 24: The Grimesilt Dig Site
	-- {area:16727} Powderfuse Port · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:16727}, ride into the {zone:1427} by its eastern pass, then west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "das {object:173265}",

	-- Step 26: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "Reite nach Nordwesten durch die Schlucht; {area:1446} ist das Lager mit den Gerüsten im Nordwesten.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Das Brett {object:179827}",

	-- Step 27: The Cauldron's slavers and golems
	-- {area:246} The Cauldron
	["{area:246}'s slavers and golems"] = "",
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	-- plural, as words: Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Heavy War Golems = {npc:5854} Heavy War Golem
	["Ride south from {area:1446} into the Cauldron: the Dark Iron Taskmasters and Slavers drive the slaves on the paths, and the Heavy War Golems patrol the floor below {npc:8479}."] = "",

	-- Step 28: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "",

	-- Step 31: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "",
	-- {npc:8479} Velarok Windblade · {item:11818} Grimesilt Outhouse Key · {area:1443} The Slag Pit
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Greater Lava Spiders = {npc:5858} Greater Lava Spider · Incendosaurs = {npc:9318} Incendosaur · Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Heavy War Golems patrol the Cauldron below {npc:8479} and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it.\nThe Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge.\n{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}, seltene Beute",

	-- Step 33: Thorium Point
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	["Ride back north to {area:1446}, just past {npc:8479}."] = "",

	-- Step 34: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "Die Öfen der Dampfschmiede",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Die Dampfschmiede der Dunkeleisenzwerge arbeiten an den Öfen mitten im Kessel; die Hälfte trägt {item:10551}, jeder zehnte {item:18959}. Sklaven, Sklavenhändler und Zuchtmeister tragen auch Dolche.",

	-- Step 35: Velarok Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "Seine nächste Bitte braucht das {item:10552} von Elitekultisten: Lass sie aus.",

	-- Step 37: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "Ausgucke der Dunkeleisenzwerge",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Die Ausgucke der Dunkeleisenzwerge stehen auf den Kämmen um die Wachtürme südlich des Kessels; etwa jeder zehnte trägt {item:18960}.",

	-- Step 38: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "Nur mit dem {item:11818}: zurück nach Osten zum {object:173265} an der Grabungsstätte.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Boot nach {area:35}",
	-- ["Dark Iron Lookouts"] = "Ausgucke der Dunkeleisenzwerge",
	-- ["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "Flieg nach {area:1637} und trainiere: Der Trainingshalt im nächsten Guide ist {zone:1458}, wo es keinen Jäger- oder Schamanenlehrer gibt. Flieg dann nach {area:392}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "Flieg nach {area:1638}, trainiere bei {npc:3033} auf der Anhöhe ({area:1639}) und flieg dann nach {area:392}.",
	-- ["Fly to {area:340}"] = "Flieg nach {area:340}",
	-- ["Fly to {area:392}"] = "Flieg nach {area:392}",
	-- ["From the {area:35} flight master, above the harbour."] = "Vom Flugmeister in {area:35}, oberhalb des Hafens.",
	-- ["From {area:1099}'s flight master."] = "Vom Flugmeister in {area:1099}.",
	-- ["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "Weiter südlich liegt die Ausrüstung von Junior Surveyor Scrimshank am Eingang eines Baus der Centipaar.",
	-- ["Greater Lava Spiders"] = "Große Lavaspinnen",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Schwere Kriegsgolems patrouillieren im Kessel unter Kalaran und lassen das Öl fallen; die Magmaelementare und Lodernden Elementare zwischen ihnen lassen die Herzen fallen. Die Zuchtmeister und Sklavenhändler der Dunkeleisenzwerge treiben die Sklaven auf den Wegen an; ein Sklavenhändler kann {item:11818} fallen lassen: Behalte ihn.",
	-- ["Kalaran stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "Kalaran steht allein südlich von {area:1446}, am Rand des Kessels. Hör dir seine Geschichte an.",
	-- ["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "Nur mit dem Notsignalgeber: OOX-17/TN sitzt südöstlich von Scrimshanks Bau. Eskortiere ihn nach Norden nach {area:977}; seine Belohnung wartet bei Oglethorpe in {area:35}.",
	-- ["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "Reite zurück nach Norden zur {area:1446}. Bleib hier: Der nächste Guide beginnt mit dem Flug nach {area:75}.",
	-- ["Ride south-west to {area:976}."] = "Reite nach Südwesten nach {area:976}.",
	-- ["South down the road again."] = "Wieder die Straße hinunter nach Süden.",
	-- ["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "Südöstlich von Gadgetzan lagern die Banditen der Wüstenläufer in den Dünen; {npc:7847} steht im östlichen Lager.",
	-- ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Nimm den Pass auf der Westseite von {area:340} in die {zone:1427} und reite dann nach Südwesten zur Grabungsstätte. {object:173265} steht an ihrem Südende; die Geologen der Dunkeleisenzwerge graben gleich nördlich davon. Bring 15 {item:4306} mit (gibt es im Auktionshaus).",
	-- ["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Die Ausgucke der Dunkeleisenzwerge stehen auf den Kämmen um die Wachtürme südlich des Kessels; etwa jeder zehnte trägt {item:18960}.",
	-- ["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Die Dampfschmiede der Dunkeleisenzwerge arbeiten an den Öfen mitten im Kessel; die Hälfte trägt {item:10551}, jeder zehnte {item:18959}. Sklaven, Sklavenhändler und Zuchtmeister tragen auch Dolche.",
	-- ["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Die Großen Lavaspinnen streifen über die Plateaus und Lavabecken im Südwesten der Schlucht.",
	-- ["The Steamsmiths' furnaces"] = "Die Öfen der Dampfschmiede",
	-- ["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "Das Boot nach {area:35} legt am Pier von {area:392} an, unterhalb des Hügels des Flugmeisters.",
	-- ["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "Westlich des Truppenlagers füllen die Kakteenwesen das Tal; nur die Disteltausammler tragen eine Taudrüse. Die meisten Mobs in {zone:1446} können selten den OOX-17/TN-Notsignalgeber fallen lassen: Behalte ihn, wenn du einen siehst.",
	-- ["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "Im Westen schwärmen die Insekten der Centipaar um ihre Baue; jedes kann die Teile fallen lassen.",
	-- ["the {object:150075} in the square"] = "der {object:150075} auf dem Platz",
	-- ["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443} öffnet sich im Norden des Kessels. Incendosaurier schwimmen in ihren Lavabecken: Pull sie an den Rand. Die geheimen Pläne liegen auf dem oberen Sims der Grube.",
	-- ["{area:392} pier"] = "Pier von {area:392}",
}
