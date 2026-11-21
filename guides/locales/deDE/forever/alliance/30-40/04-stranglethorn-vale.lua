-- German (deDE): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Boot nach {area:35}",
	-- {area:392} Ratchet · {area:35} Booty Bay
	["The boat from {area:392}'s dock crosses to {area:35}, on Stranglethorn's southern cape."] = "Das Boot vom Steg von {area:392} fährt nach {area:35}, auf Schlingendorntals südlicher Landspitze.",

	-- Step 2: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil
	-- was: ["Bind your hearthstone at the inn: it is your way back here from the north of the jungle at the end of the loop."] = "Binde deinen Ruhestein im Gasthaus: Er ist dein Weg hierher zurück aus dem Norden des Dschungels am Ende der Runde."
	["{npc:4631} stands on the dock where the boat lands. Bind your hearthstone at the inn: it is your way back here from the north of the jungle at the end of the loop."] = "",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the dock"] = "",
	-- {npc:4631} Wharfmaster Lozgil · {npc:2496} Baron Revilgaz
	["{npc:4631}: for {npc:2496}, upstairs in the tavern"] = "",
	-- {npc:3945} Caravaneer Ruzzgot
	["{npc:3945}, on the dock"] = "",
	-- {npc:3945} Caravaneer Ruzzgot · {npc:267} Clerk Daltry · {area:42} Darkshire
	["{npc:3945}: for {npc:267} in {area:42}, where the second Stranglethorn loop starts"] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "{npc:2495}, bei der Bank; drinnen",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, drinnen",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern
	["{npc:6807}, {object:56910}; upstairs"] = "{npc:6807}, {object:56910}; oben",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}; upstairs"] = "{npc:2832}, im {object:56910}; oben",
	-- {npc:773} Krazek · {npc:738} Private Thorsen · {area:99} Rebel Camp
	["{npc:773}, in the tavern; upstairs: {npc:738} is at the {area:99}, on the way"] = "{npc:773}, in der Taverne; oben: {npc:738} ist beim {area:99}, auf dem Weg",
	-- {npc:773} Krazek
	["{npc:773}: Nesingwary's camp, on the way"] = "{npc:773}: Nesingwarys Lager, auf dem Weg",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, in der Taverne",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, oben in der Taverne",
	-- {npc:250660} The Baron · {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Agents = {npc:260429} Venture Co. Agent
	["{npc:250660}'s next errand sends you into the Venture Co. house at {area:37}, among Venture Co. Agents (39): leave it."] = "",

	-- Step 3: North to Nesingwary's Expedition
	-- {area:100} Nesingwary's Expedition
	["North to {area:100}"] = "Nach Norden zur {area:100}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Follow the main road north the length of the jungle, past the {object:3202} turn-off, to the hunters' camp just west of the road."] = "Folge der Hauptstraße nach Norden durch den ganzen Dschungel, an der Abzweigung zum {object:3202} vorbei, zum Jägerlager direkt westlich der Straße.",

	-- Step 4: Nesingwary's Expedition
	-- {npc:773} Krazek · {quest:201} Investigate the Camp
	["The hunters' tents stand just west of the road. {npc:773}'s {quest:201} only asks you to look around it."] = "Die Zelte der Jäger stehen direkt westlich der Straße. {npc:773}s {quest:201} will nur, dass du dich dort umsiehst.",
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: Sieh dich einfach im Lager der Jäger um",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, aus {zone:1441}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "Junge Tiger und Panther",
	["Both roam the grass around the camp and along the road north."] = "Beide streifen durch das Gras um das Lager und entlang der Straße nach Norden.",

	-- Step 6: River crocolisks
	["River crocolisks"] = "Flusskrokilisken",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks (30-31) swim the river right beside Nesingwary's camp and up toward the {area:99}."] = "Flusskrokilisken (30-31) schwimmen im Fluss direkt neben Nesingwarys Lager und hinauf Richtung {area:99}.",

	-- Step 10: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Schlingendorntiger",
	["The adult tigers prowl the hills just south and west of the camp."] = "Die ausgewachsenen Tiger streifen durch die Hügel gleich südlich und westlich des Lagers.",

	-- Step 11: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Die Alten Schlingendorntiger kommen später, auf dem Rückweg vom {area:99}",

	-- Step 12: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Panther, Raptoren und Alte Tiger",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "Zurück nach Süden an Nesingwary vorbei: Panther und Schlingendornraptoren laufen auf den Lichtungen westlich des Lagers Richtung Küste; die Alten Schlingendorntiger halten die Hügel im Südwesten.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle (37, rare) on the coast west of camp drops the {item:4614}: four levels over you, leave him unless you are grouped"] = "Gluckser (37, Rare) an der Küste westlich des Lagers lässt den {item:4614} fallen: vier Stufen über dir, lass ihn aus, außer du bist in einer Gruppe",
	-- {object:661516} Thoroughly Scavenged Supplies
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["{object:661516}, a looted crate west of Nesingwary's camp: the Stolen Shipments lie in the Bloodscalp ruins on the coast, for the second Stranglethorn loop"] = "{object:661516}, eine geplünderte Kiste westlich von Nesingwarys Lager: Die Gestohlenen Lieferungen liegen in den Ruinen der Bloodscalp an der Küste, für die zweite Runde durch Schlingendorn",

	-- Step 13: Sir S. J. Erlgadin
	-- {area:99} Rebel Camp
	["Back east to Nesingwary's camp on the way north to the {area:99}."] = "Zurück nach Osten zu Nesingwarys Lager auf dem Weg nach Norden zum {area:99}.",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["keep it: the Shadowmaw Panthers (37-38) wait for the 40-50 Stranglethorn guide"] = "Behalte sie: Die Schattentatzenpanther (37-38) warten auf den Schlingendorn-Guide für 40-50",

	-- Step 14: Rebel Camp
	-- {npc:738} Private Thorsen · {quest:215} Jungle Secrets · {quest:200} Bookie Herod · {area:99} Rebel Camp
	-- plural, as words: Kurzen's Agents = {npc:775} Kurzen's Agent
	["Take the road north; the camp sits in the hills to the west.\n{npc:738} offers {quest:215} only while he is out of the camp: about every half hour he walks down the path to the road, where two Kurzen's Agents ambush him. Help him kill them and take the quest at once, before he walks back up. He isn't there? Leave it: the guide passes {quest:200}, which follows from it, as well.\n{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "Nimm die Straße nach Norden; das Lager liegt in den Hügeln im Westen.\n{npc:738} bietet {quest:215} nur an, solange er außerhalb des Lagers ist: Etwa jede halbe Stunde geht er den Pfad zur Straße hinab, wo zwei Kurzens Agenten ihm auflauern. Hilf ihm, sie zu töten, und nimm die Quest sofort an, bevor er wieder hinaufgeht. Ist er nicht da? Lass es: Der Guide kommt später auch bei {quest:200} vor, das daran anschließt.\n{npc:738} verbringt die meiste Zeit oben am Ende des Pfads des {area:99}, bei den Hütten, und geht hin und wieder hinab zur Straße und zurück (etwa acht Minuten). Ist er nicht beim Pfeil, suche entlang dieses Pfads.",
	-- {npc:738} Private Thorsen
	["{npc:738}, at the foot of the path"] = "{npc:738}, am Fuß des Pfads",
	-- {npc:738} Private Thorsen
	["{npc:738}: at the top of the path by the huts, or on his walk down it"] = "{npc:738}: oben am Ende des Pfads bei den Hütten, oder auf seinem Weg hinab",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, in der Hütte",
	-- {npc:469} Lieutenant Doren · {quest:200} Bookie Herod · {area:101} Kurzen's Compound
	["{npc:469}: {quest:200}'s records lie at the edge of {area:101}, next"] = "{npc:469}: Die Aufzeichnungen von {quest:200} liegen am Rand von {area:101}, als Nächstes",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}, later in this guide"] = "{npc:770}: für {npc:773} in {area:35}, weiter hinten in diesem Guide",

	-- Step 15: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "{area:101}: Töte diese, sobald sie dir begegnen",
	-- {area:99} Rebel Camp · {quest:200} Bookie Herod
	-- plural, as words: Kurzen Elites = {npc:939} Kurzen Elite
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents. {quest:200}'s records lie in a hut on the compound's west side. Careful: Kurzen Elites and Witch Doctors (36) hold the compound's eastern half, by the cave: stay on its west side."] = "Die Kurzen-Rebellen halten das Lager östlich des {area:99}; arbeite am Außenrand, wo Jungle Fighters und Medicine Men stehen, und plündere die Vorratskisten bei den Zelten. Die Aufzeichnungen von {quest:200} liegen in einer Hütte an der Westseite des Komplexes. Vorsicht: Elitekämpfer und Hexendoktoren der Kurzen (36) halten die östliche Hälfte des Komplexes, bei der Höhle: Bleib auf seiner Westseite.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, in the hut"] = "{object:287}, in der Hütte",
	["The strongbox is deeper in, by the cave: on the northern loop (04b)"] = "Die Geldkassette ist weiter drinnen, bei der Höhle: auf der nördlichen Runde (04b)",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, aus einer Kiste von {object:263}",

	-- Step 16: Level 33.2
	["Level 33.2"] = "Stufe 33,2",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Kurzen Jungle Fighters = {npc:937} Kurzen Jungle Fighter
	["The elder tigers next are 34-35: short of 33.2? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "Die Alten Tiger als Nächstes sind 34-35: Noch unter 33,2? Bleib bei Kurzens Dschungelkämpfern und Medizinmännern am Außenrand des Komplexes, bis du Stufe 33,2 hast. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:796} (Bibliothek).",
	-- {npc:937} Kurzen Jungle Fighter
	["grind on {npc:937}"] = "Grinde an {npc:937}",

	-- Step 18: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}: Töte diese, sobald sie dir begegnen",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "Vorsicht: Trollcamps liegen nahe beim Tigergebiet, und Trolle können in einen Kampf eingreifen, wenn du unvorsichtig ziehst.\nVorsicht: Im Raptornest sind junge Raptoren, die in den Kampf eingreifen, wenn du die ausgewachsenen angreifst.",

	-- Step 19: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} sammelt die {item:2755}: Die Seiten lässt fast jeder Humanoide im Dschungel fallen. Füg die Seiten unterwegs zu Kapiteln zusammen.",
	-- {npc:729} Sin'Dall
	["Keep it for another visit: {npc:729} (37) prowls the Lashtail hill."] = "",
	-- {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["keep it: the Lashtail Raptors come on the second loop (04b), around {npc:729}'s hill"] = "Behalte sie: Die Schmetterschwänze kommen in der zweiten Runde (04b), rund um den Hügel von {npc:729}",

	-- Step 20: The Savage Coast
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk · Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["From Nesingwary's camp head west to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "Von Nesingwarys Lager westwärts zur {area:310} nahe der Küste; die Kristallrückenbasilisken um sie herum lassen die Splitter fallen.\nDie Spukinsel liegt direkt vor der Küste südwestlich der Mine: Erreiche einfach ihr Ufer. Vorsicht: ihre Geringen Wasserelementare sind 36-37: Bleib nicht stehen. Die Blutskalp-Ruinen von Zul'Kunda im Norden warten auf die zweite Schlingendorntal-Runde.",
	["The haunted island"] = "Die Spukinsel",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay
	["Hearth back to {area:35}."] = "Kehr per Ruhestein nach {area:35} zurück.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, drinnen",
	-- {npc:2495} Drizzlik
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{npc:2495}: the Snapjaw Crocolisks, on the northern loop"] = "{npc:2495}: die Snapjaw Crocolisks, auf der nördlichen Runde",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, oben",
	-- {npc:773} Krazek · {npc:770} Corporal Kaleb
	["{npc:773}, from {npc:770}"] = "{npc:773}, von {npc:770}",
	-- {npc:737} Kebok
	["{npc:737}'s Bloodscalp ears wait for the second Stranglethorn loop: keep the quest."] = "Die Bloodscalp-Ohren für {npc:737} warten auf die zweite Runde durch Schlingendorn: Behalte die Quest.",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}: the water elementals rise around the haunted island, on the northern loop"] = "{npc:2496}: Die Wasserelementare steigen rund um die Geisterinsel auf, auf der nördlichen Runde",

	-- Step 22: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Flugmeister von {area:35}",

	-- Step 24: Collin Mauren
	-- {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:4078} is in the {object:2164}, in the {object:2101}."] = "{npc:4078} ist im {object:2164}, im {object:2101}.",

	-- Step 25: Class training
	["Class training"] = "Klassentraining",
	-- {object:2096} Trade District · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:5504} Sheldras Moontree · {zone:1455} Ironforge
	["Your level 34 ranks: the class trainers stand around the {object:2096}, {object:2100}, the Cathedral and the {object:2101}; {npc:5504}, the druid trainer, stands north-west of the {object:2101}. Shamans train in {zone:1455}, later in 30-40."] = "Deine Ränge für Stufe 34: Die Klassenlehrer stehen um {object:2096}, {object:2100}, die Kathedrale und das {object:2101}; {npc:5504}, der Druidenlehrer, steht nordwestlich des {object:2101}. Schamanen lernen in {zone:1455}, später in 30-40.",

	-- Step 27: Fly to Stonetalon Peak
	-- {area:467} Stonetalon Peak
	["Fly to {area:467}"] = "Flieg zum {area:467}",
	-- {area:467} Stonetalon Peak · {zone:1443} Desolace · {area:415} Astranaar · {area:465} Charred Vale
	["You know the {area:467} flight: it lands closer to {zone:1443} than {area:415} does. From the peak, follow the road south through the mountains to the {area:465}."] = "Du kennst die Flugroute zum {area:467}: Sie landet näher an {zone:1443} als {area:415}. Folge vom Gipfel der Straße nach Süden durch die Berge ins {area:465}.",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Flugmeister von {area:442}",

	-- Step 28: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Flieg nach {area:415}",

	-- Step 29: Fly to Astranaar
	-- {area:415} Astranaar · {quest:1738} Heartswood
	["Warlocks fly to {area:415} for the {quest:1738}, on the way west."] = "Hexenmeister fliegen auf dem Weg nach Westen für {quest:1738} nach {area:415}.",

	-- Step 30: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then take the road west to Stonetalon."] = "Von {area:415} geh nach Nordwesten in die Hügel: {quest:1738} ist ein leuchtender Baum nördlich der Straße nach {area:413}. Falls du {quest:65602} angenommen hast, liegt die {item:190309} in einem Haus zwischen den Bäumen nördlich von {area:413} (26.6,22.0). Nimm dann die Straße nach Westen zum Steinkrallengebirge.",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, nördlich von {area:413}",

	-- Step 31: Stonetalon Mountains
	-- {area:608} Nijel's Point
	["The road to {area:608}"] = "Die Straße nach {area:608}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bind your hearthstone at the inn: it is your way back here from the north of the jungle at the end of the loop."] = "Binde deinen Ruhestein im Gasthaus: Er ist dein Weg hierher zurück aus dem Norden des Dschungels am Ende der Runde.",
	-- ["Bloodscalp trolls"] = "Bloodscalp-Trolle",
	-- ["Down to {area:35}"] = "Hinab nach {area:35}",
	-- ["East of Zul'Kunda"] = "Östlich von Zul'Kunda",
	-- ["Fly from {area:150} to {area:1537} and train."] = "Flieg von {area:150} nach {area:1537} und trainiere.",
	-- ["Fly to {area:108}"] = "Flieg nach {area:108}",
	-- ["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Flieg nach {area:42}: {npc:1573} im {object:32372} von {area:1537} oder {npc:352} im {object:2096} von {zone:1453}.",
	-- ["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Folge der Hauptstraße durch den ganzen Dschungel nach Süden, vorbei an der Abzweigung nach {object:3202}, bis {area:35} am Südkap.",
	-- ["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape. Bind your hearthstone at the inn: it is your way back here from Nesingwary's camp at the end of the jungle loop."] = "Folge der Hauptstraße durch den ganzen Dschungel nach Süden, vorbei an der Abzweigung nach {object:3202}, bis {area:35} am Südkap. Binde deinen Ruhestein im Gasthaus: Damit kommst du am Ende der Dschungelrunde von Nesingwarys Lager hierher zurück.",
	-- ["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Folge der Westküste nach Norden; die Spukinsel liegt vor der Küste westlich von Nesingwarys Lager. Erreiche sie einfach.",
	-- ["For Archmage Ansirem in {zone:1416}"] = "Für Erzmagier Ansirem im {zone:1416}",
	-- ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach it. The Bloodscalp trolls hold the ruins on the coast to the north."] = "Von {area:108} führt der Weg nach Süden aus {zone:1436} in den Nordwesten von Schlingendorntal, zur {area:310} nahe der Küste; die Crystal Spine Basilisks rundherum lassen die Splitter fallen.\nDie Geisterinsel liegt direkt vor der Küste südwestlich der Mine: Erreiche sie einfach. Die Bloodscalp-Trolle halten die Ruinen an der Küste im Norden.",
	-- ["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach its edge. Careful: its Lesser Water Elementals are 36-37: don't stay. The Bloodscalp ruins of Zul'Kunda to the north wait for the second Stranglethorn loop."] = "Von {area:108} führt der Weg nach Süden aus {zone:1436} in den Nordwesten von Schlingendorntal, zur {area:310} nahe der Küste; die Kristallrückenbasilisken rundherum lassen die Splitter fallen.\nDie Geisterinsel liegt direkt vor der Küste südwestlich der Mine: Erreiche einfach ihren Rand. Vorsicht: Ihre Geringen Wasserelementare sind 36-37: Bleib nicht dort. Die Bloodscalp-Ruinen von Zul'Kunda im Norden warten auf die zweite Runde durch Schlingendorn.",
	-- ["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Nimm vom {zone:1431} die Straße nach Süden ins Schlingendorntal; die Zelte der Jäger stehen gleich westlich der Straße hinter der Abzweigung zum {area:99}.",
	-- ["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Gluckser, ein seltener Murloc an der Küste westlich des Lagers, lässt den {item:4614} fallen: Nimm ihn mit, falls du ihm begegnest",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Kurzens Kopfschrumpfer stehen tiefer im Lager; Kurzens Kommandosoldaten lauern getarnt darum herum und in der Höhle. Heb Seiten der Grünen Hügel auf, wenn sie fallen.",
	-- ["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Herods Aufzeichnungen liegen in einer Hütte auf der Westseite des Lagers; seine Geldkassette steht weiter östlich beim Höhleneingang.",
	-- ["Level 33.6"] = "Stufe 33,6",
	-- ["Level 34"] = "Stufe 34",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Zieh eine Runde durch die Trollruinen im Norden und in der Mitte: Jede birgt eine Steintafel der Trolllegenden. Schattentatzenpanther schleichen getarnt im Dschungel darum herum; das Lager der Venture Co. auf {area:37} trägt die Gerommelten Kristalle.",
	-- ["River Crocolisks swim the river by the {area:99}."] = "Flusskrokilisken schwimmen im Fluss beim {area:99}.",
	-- ["Short of 33.6? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.6. Or, with a group, run the {area:796} dungeon (Library) instead."] = "Noch unter 33,6? Bleib bei den Kurzen Jungle Fighters und Medicine Men am Außenrand des Komplexes, bis du Stufe 33,6 hast. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:796} (Bibliothek).",
	-- ["Skullsplitter trolls"] = "Skullsplitter-Trolle",
	-- ["Snapjaw Crocolisks"] = "Schnappkieferkrokilisken",
	-- ["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Schnappkieferkrokilisken sonnen sich an Ufer und Inseln entlang der Küste nördlich von {area:35}.",
	-- ["Take the road north; the camp sits in the hills to the west.\n{npc:738} offers {quest:215} only while he is out of the camp: about every half hour he walks down the path to the road, where two Kurzen's Agents ambush him. Help him kill them and take the quest at once, before he walks back up. He isn't there? Leave it: the guide passes {quest:200}, which follows from it, as well."] = "Folge der Straße nach Norden; das Lager liegt in den Hügeln im Westen.\n{npc:738} bietet {quest:215} nur an, solange er außerhalb des Lagers ist: Etwa jede halbe Stunde geht er den Pfad hinunter zur Straße, wo ihn zwei von Kurzens Agenten überfallen. Hilf ihm, sie zu töten, und nimm die Quest sofort an, bevor er wieder hinaufgeht. Er ist nicht da? Dann lass sie aus: Der Guide lässt auch die Folgequest {quest:200} aus.",
	-- ["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Nimm die Straße nach Norden; {npc:738} patrouilliert darauf, das Lager liegt in den Hügeln im Westen.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Nimm die Straße nach Norden; {npc:738} steht darauf, das Lager liegt in den Hügeln im Westen.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Die Bloodscalp-Trolle halten die Ruinen an der Küste westlich von Nesingwarys Lager.",
	-- ["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Die Rebellen von Kurzen halten das Lager östlich des {area:99}; arbeite dich am Außenrand entlang, wo Kurzens Dschungelkämpfer und Medizinmänner stehen, und plündere die Vorratskisten bei den Zelten.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Die Skullsplitter-Trolle halten die Ruinen östlich der Straße zwischen Nesingwary und {object:3202}.",
	-- ["The jungle ruins"] = "Die Dschungelruinen",
	-- ["The jungle's quests climb to 37 from here: short of 33.2? Keep on the Stranglethorn Tigers in the hills just south and west of the camp until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "Die Quests im Dschungel steigen von hier an bis 37: Unter 33,2? Bleib bei den Stranglethorn Tigers in den Hügeln direkt südlich und westlich des Lagers, bis du Stufe 33,2 hast. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:796} (Bibliothek).",
	-- ["The ore drops from Drywhisker kobolds in {zone:1417}"] = "Das Erz lassen Kobolde der Trockenstoppel im {zone:1417} fallen",
	-- ["The quests from here on are 37: if you are short of 34, keep on the elder tigers in the hills south-west of Nesingwary's camp until level 34. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "Die Quests von hier an sind Stufe 37: Falls du unter 34 bist, bleib bei den Elder Tigers in den Hügeln südwestlich von Nesingwarys Lager, bis du Stufe 34 hast. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:796} (Bibliothek oder Waffenkammer).",
	-- ["Thorsen patrols the road north of camp, toward the {area:99}."] = "Thorsen patrouilliert auf der Straße nördlich des Lagers, Richtung {area:99}.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Geh zurück nach Norden; die {area:310} liegt westlich der Straße mitten im Dschungel. Die Kristallrückenbasilisken dort lassen die Splitter fallen.",
	-- ["grind on {npc:1085}"] = "Grinde an {npc:1085}",
	-- ["grind on {npc:682}"] = "Grinde an {npc:682}",
	-- ["keep it: {npc:729} (37) comes in the 40-50 Stranglethorn guide, at about 41"] = "Behalte sie: {npc:729} (37) kommt im Schlingendorn-Guide für 40-50, mit etwa 41",
	-- ["{area:150} flight master"] = "Flugmeister von {area:150}",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} hat keinen Druidenlehrer: Nimm die {area:2257} von {object:171524} nach {zone:1453} und trainiere bei {npc:5504}.",
	-- ["{area:301}: kill these as you meet them"] = "{area:301}: Töte diese, sobald sie dir begegnen",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}, bei der Bank",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, in der {object:56910}",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}, im obersten Stockwerk bei den Docks",
	-- ["{npc:729} and the Lashtail raptors"] = "{npc:729} und die Schmetterschwänze",
	-- ["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, der große Tiger, haust auf der Hügelkuppe südwestlich des Lagers; Schmetterschwänze laufen südlich davon, auf dem Weg nach {area:35}.",
	-- ["{npc:737}, upstairs"] = "{npc:737}, oben",
	-- ["{npc:737}: the Tumbled Crystals, on the northern loop"] = "{npc:737}: die Tumbled Crystals, auf der nördlichen Runde",
	-- ["{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "{npc:738} verbringt die meiste Zeit oben am Pfad des {area:99}, bei den Hütten, und läuft hin und wieder den Pfad hinunter zur Straße und zurück (etwa acht Minuten). Wenn er nicht am Pfeil ist, such den Pfad ab.",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: für {npc:773} in {area:35}",
	-- ["{npc:773}, in the tavern"] = "{npc:773}, in der Taverne",
	-- ["{npc:773}, in the tavern; upstairs"] = "{npc:773}, in der Taverne; oben",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: vier Trolllegenden",
}
