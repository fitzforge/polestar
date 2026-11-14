-- German (deDE): the guide forever/alliance/40-50/04-tanaris (forever/alliance/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Mirage Raceway
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {npc:4454} Fizzle Brassbolts
	["The {area:2240} lies on the {area:439} in south-east {zone:1441}: {npc:4454} is in the gnomes' camp beside the track, Zamek by the goblin camp."] = "{area:2240} liegt auf {area:439} im Südosten von {zone:1441}: {npc:4454} ist im Lager der Gnome neben der Strecke, Zamek beim Goblinlager.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454}: {quest:1137}, von Martek in {zone:1418}",

	-- Step 4: Gadgetzan
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Ride south-east off the {area:439} into {zone:1446}. {area:976} is just inside the border."] = "Reite vom Gebiet {area:439} nach Südosten nach {zone:1446}. {area:976} liegt gleich hinter der Grenze.",
	-- {quest:2864} Tran'rek
	["{quest:2864}, north side of town"] = "{quest:2864}, an der Nordseite der Stadt",
	-- {npc:7407} Chief Engineer Bilgewhizzle
	["{npc:7407}, by the water tower"] = "{npc:7407}, beim Wasserturm",
	-- {npc:7408} Spigot Operator Luglunket
	["{npc:7408}, next to him"] = "{npc:7408}, neben ihm",
	-- {npc:7763} Curgle Cranklehop · {area:702} Rut'theran Village
	["{npc:7763}: his crate goes to {area:702}, later"] = "{npc:7763}: Seine Kiste geht später nach {area:702}",

	-- Step 5: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7407} Chief Engineer Bilgewhizzle · {quest:2768} Divino-matic Rod
	["For your {area:978} run, later in this guide: {quest:2864} wants scarab shells, {npc:7407}, by the water tower, his {quest:2768} back, and Trenton Lighthammer Troll Temper from the Sandfury trolls."] = "Für deinen Run durch {area:978}, später in diesem Guide: {quest:2864} will Skarabäuspanzer, {npc:7407} beim Wasserturm seinen {quest:2768} zurück, und Trenton Lighthammer Troll Temper von den Trollen der Sandfury.",

	-- Step 6: Steamwheedle Port
	["Ride east across the dunes to the goblin harbour on the north-east coast."] = "Reite nach Osten über die Dünen zum Goblinhafen an der Nordostküste.",
	["The Wanted poster beside him"] = "Der Steckbrief neben ihm",
	-- {npc:7847} Caliph Scorpidsting · {area:976} Gadgetzan
	["The same poster: {npc:7847} comes much later, after {area:976}"] = "Derselbe Steckbrief: {npc:7847} kommt viel später, nach {area:976}",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}, drinnen",
	-- {npc:7881} Stoley
	["{npc:7881}, in the port's tavern; inside"] = "{npc:7881}, in der Taverne des Hafens; drinnen",

	-- Step 7: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}: Töte diese, sobald sie dir begegnen",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Reite zurück nach Westen in Richtung {area:976}. Die Wastewander-Banditen und -Diebe halten die Dünen auf dem Weg; jeder von ihnen kann einen Wasserbeutel tragen.\nVorsicht: Wastewander Rogues (Stufe 43-44) bewegen sich getarnt, sodass sie sich unbemerkt nähern können.",

	-- Step 9: Waterspring Field
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp."] = "Die stärkeren Wastewander-Schurken, -Schattenmagier und -Assassinen lagern südöstlich von {area:976}, südlich der Banditen. Lass {npc:7847} in der Mitte des südlichen Lagers für später übrig.\nVorsicht: Wastewander Rogues bleiben außerhalb des Kampfes im Schleichen, sodass versteckte Schurken in einen Kampf eingreifen können, den du an einem Lager beginnst.",

	-- Step 10: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}: Töte diese, sobald sie dir begegnen",
	-- {npc:7883} Andre Firebeard · {npc:7881} Stoley
	["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Folge der Küste nach Süden zur Piratenbucht. Südmeerpiraten drängen sich am Strand und auf den Booten: Arbeite dich am Rand entlang und zieh einzeln. {npc:7883} steht auf der anderen Seite; die gestohlene Fracht von {npc:7881} liegt im Lager.\nVorsicht: Zwei oder drei Piraten stehen bei {npc:7883}, und viele weitere Piraten aus der Stadt greifen in den Kampf ein, sobald er beginnt.",
	-- {quest:2873} Stoley's Shipment
	["{quest:2873}; upstairs"] = "{quest:2873}; oben",

	-- Step 11: Steamwheedle Port
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}, drinnen",
	-- {area:35} Booty Bay · {zone:1425} Hinterlands
	["\"Sea Wolf\" MacKinley in {area:35}: the route takes you there at the end of the {zone:1425} guide, keep it"] = "„Sea Wolf“ MacKinley in {area:35}: Die Route bringt dich am Ende des Guides für {zone:1425} dorthin, behalte es",

	-- Step 12: Noonshade Ruins
	["Careful: Thieves cast Disarm. Rogues stay hidden with Sneak. Assassins use Execute when your health is at 20% or lower."] = "Vorsicht: Diebe wirken Entwaffnen. Schurken bleiben mit Schleichen versteckt. Assassinen benutzen Hinrichten, wenn deine Gesundheit bei 20 % oder darunter liegt.",

	-- Step 14: The pool by Sandsorrow Watch
	-- {area:979} Sandsorrow Watch
	["The pool by {area:979}"] = "Der Teich bei der {area:979}",
	-- {area:979} Sandsorrow Watch · {item:8584} Untapped Dowsing Widget
	["Ride north-west to the Sandfury troll camp at {area:979}. Use the {item:8584} at the edge of its pool; the trolls stand close, so pull the nearest first."] = "Reite nach Nordwesten zum Trolllager der Sandfury bei der {area:979}. Benutze den {item:8584} am Rand des Teichs; die Trolle stehen dicht beieinander, also zieh zuerst den nächsten.",
	-- {item:8585} Tapped Dowsing Widget
	["Gives the {item:8585}"] = "Gibt dir den {item:8585}",
	-- {area:979} Sandsorrow Watch
	["Pool by {area:979}"] = "Teich bei der {area:979}",

	-- Step 15: Zul'Farrak
	-- {area:978} Zul'Farrak · {quest:3042} Troll Temper · {npc:7604} Sergeant Bly · {quest:2768} Divino-matic Rod
	["{area:978} is a dungeon for a group of five; its quests here are level 45 to 47. Its gate lies about 400 yards north of the pool.\nInside: the Scarabs drop the shells, every Sandfury troll can drop {quest:3042}, and {npc:7604} carries the {quest:2768}."] = "{area:978} ist ein Dungeon für eine Gruppe aus fünf Spielern; seine Quests hier sind Stufe 45 bis 47. Das Tor liegt etwa 400 Meter nördlich des Teichs.\nDrinnen: Die Skarabäen lassen die Panzer fallen, jeder Troll der Sandfury kann {quest:3042} fallen lassen, und {npc:7604} trägt {quest:2768} bei sich.",
	-- {quest:2865} Scarab Shells
	["{quest:2865}: the Scarabs, inside"] = "{quest:2865}: die Skarabäen, drinnen",
	-- {quest:3042} Troll Temper
	["{quest:3042}: the Sandfury trolls, inside"] = "{quest:3042}: die Trolle der Sandfury, drinnen",
	-- {quest:2768} Divino-matic Rod · {npc:7604} Sergeant Bly
	["{quest:2768}: {npc:7604}, inside"] = "{quest:2768}: {npc:7604}, drinnen",

	-- Step 17: Tran'rek
	-- {area:978} Zul'Farrak · {npc:7876} Tran'rek
	["Your {area:978} scarab shells: {npc:7876}, on the north side of town."] = "Deine Skarabäuspanzer aus {area:978}: {npc:7876}, auf der Nordseite der Stadt.",

	-- Step 18: Chief Engineer Bilgewhizzle
	-- {quest:2768} Divino-matic Rod · {npc:7407} Chief Engineer Bilgewhizzle
	["The {quest:2768}: {npc:7407}, by the water tower."] = "{quest:2768}: {npc:7407}, beim Wasserturm.",

	-- Step 19: Trenton Lighthammer
	-- {quest:3042} Troll Temper · {npc:7804} Trenton Lighthammer
	["The {quest:3042}: {npc:7804}, in town."] = "{quest:3042}: {npc:7804}, in der Stadt.",

	-- Step 20: The Broken Pillar
	-- {area:1938} Broken Pillar
	["The {area:1938}"] = "Die {area:1938}",
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {quest:3161} Gahz'ridian
	["Ride south to the dig camp at the {area:1938}. {npc:7771} hands you a detector helm: wear it to see the {quest:3161} mounds, which lie thick in the sand around the camp and south-west toward the ogres."] = "Reite nach Süden zum Grabungslager an der {area:1938}. {npc:7771} gibt dir einen Detektorhelm: Trag ihn, um die Hügel von {quest:3161} zu sehen, die dicht im Sand rund um das Lager und nach Südwesten Richtung Oger liegen.",

	-- Step 22: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "Reite nach Nordwesten zum Centipaar-Bau in den Dünen. Jeder Centipaar kann Insektenteile fallen lassen.\nVorsicht: Centipaar Swarmers wirken {npc:4196} sowohl im als auch außerhalb des Kampfes, was kleine Adds bringt, die dich unterbrechen.",

	-- Step 23: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager · {quest:3362} Thistleshrub Valley
	-- plural, as words: Dunemaul Ogres = {npc:5471} Dunemaul Ogre
	["Ride south-west to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first.\nWhy the grind to 47: the {quest:3362} comes next, with mobs of 48-50 and quests of level 50. Grind it on the Dunemaul Ogres (45-46) at the compound's south end, the safer camp, not on the Brutes."] = "Reite nach Südwesten zum Lager der Oger. Schläger und Vollstrecker (46-48) füllen es; {npc:12046} (49) steht mit Wachen um sich herum in der Mitte: Räum sie zuerst weg.\nWarum der Grind bis 47: Als Nächstes kommt {quest:3362}, mit Mobs der Stufe 48-50 und Quests der Stufe 50. Grinde dafür an den Dunemaul-Ogern (45-46) am Südende des Lagers, dem sichereren Lager, nicht an den Schlägern.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "{npc:12046}, unter der Erde",
	-- {npc:5471} Dunemaul Ogre
	["grind on {npc:5471}, at the compound's south end"] = "Grinde an {npc:5471}, am Südende des Lagers",

	-- Step 24: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362}: Töte diese, sobald sie dir begegnen",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "Reite nach Süden in {quest:3362}. Die Dew Collectors lassen die Drüsen fallen; nur manche sind voll, also behalte die Laden. Gnarled Thistleshrubs und Rootshapers teilen sich das Tal. Die Thistleshrubs sind 48-50, über deiner Stufe: Zieh einzeln.\nVorsicht: Die anderen Thistleshrub-Mobs im Gebiet sind Stufe 49-50 und wandern viel umher, sodass du leicht zusätzliche Mobs ziehst.",

	-- Step 25: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Eskorte von {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port
	["The little turtle {npc:5955} hides at the north end of the valley. Lead him home to his wife {npc:6015}, by the water just east of {area:977}: he walks slowly and the desert's beasts go for him, so keep him alive."] = "Die kleine Schildkröte {npc:5955} versteckt sich am Nordende des Tals. Führe ihn heim zu seiner Frau {npc:6015}, am Wasser gleich östlich von {area:977}: Er läuft langsam und die Bestien der Wüste greifen ihn an, also halte ihn am Leben.",

	-- Step 26: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back west to {area:976}: {npc:11758} stands on the east side of town, where you come in."] = "Reite zurück nach Westen nach {area:976}: {npc:11758} steht an der Ostseite der Stadt, wo du hereinkommst.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, drinnen",

	-- Step 27: Caliph Scorpidsting
	-- {area:985} Waterspring Field · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "Reite nach Südosten zum {area:985}. {npc:7847} steht in der Mitte des südlichen Wastewander-Lagers: Räum zuerst um ihn herum.\nVorsicht: Zwei getarnte Wastewander Rogues begleiten ihn, wohin er auch geht. An seinem Spawn-Lager sind zwei Schattenmagier und ihre Diener nah genug, um in einen Kampf mit ihm einzugreifen. Draußen bei den Türmen kannst du ihn ohne sie bekämpfen.",

	-- Step 28: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Reite südlich am {area:1938} vorbei zum {area:981}, den Tunneln der Hazzali; die Ausrüstung von Scrimshank liegt tief drinnen.\nVorsicht: Ein Käfer bewacht die Ausrüstung. Viele Käfer patrouillieren in den Tunneln, einige davon Stufe 50, sodass Kämpfe oft zusätzliche Adds ziehen.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "{item:8593}; unter der Erde",

	-- Step 29: Gadgetzan
	-- {zone:1457} Darnassus
	["for {zone:1457}, next"] = "für {zone:1457}, als Nächstes",

	-- Step 30: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Flieg nach {area:442}",
	-- {zone:1457} Darnassus · {npc:7763} Curgle Cranklehop · {area:442} Auberdine · {area:150} Menethil Harbor · {area:348} Aerie Peak
	["{zone:1457} first, while you are on this side of the sea: Troyas' answer, {npc:7763}'s crate, Tyrande and the soil errand, then the boat from {area:442} to {area:150} and the gryphon to {area:348}."] = "Zuerst {zone:1457}, solange du auf dieser Seite des Meeres bist: Troyas' Antwort, die Kiste von {npc:7763}, Tyrande und der Auftrag mit der Erde, dann das Schiff von {area:442} nach {area:150} und der Greif nach {area:348}.",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Flugmeister von {area:976}",

	-- Step 31: Teldrassil
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:3838} Vesprystus
	["Take the boat from {area:442}'s dock to {area:702}; {npc:3838}, the hippogryph master, stands on the rise just east of the landing: learn the flight path on the way up to the village."] = "Nimm das Boot vom Steg in {area:442} nach {area:702}; {npc:3838}, der Hippogryphenmeister, steht auf der Anhöhe gleich östlich der Anlegestelle: Lerne die Flugroute auf dem Weg hinauf zum Dorf.",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Flugmeister von {area:702}",

	-- Step 32: Rut'theran Village
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907} steht oben, über {npc:7916}: Geh drinnen hinauf, der Pfeil kann die Stockwerke nicht unterscheiden.",
	-- {npc:7907} Daryn Lightwind · {zone:1446} Tanaris
	["{npc:7907}'s next errand goes to {zone:1446}: skip it."] = "Der nächste Auftrag von {npc:7907} führt nach {zone:1446}: Überspring ihn.",
	-- {npc:7916} Erelas Ambersky · {zone:1425} Hinterlands
	["{npc:7916}: the feathers lie in the {zone:1425}, next"] = "{npc:7916}: Die Federn liegen im {zone:1425}, als Nächstes",
	["the book on her table"] = "das Buch auf ihrem Tisch",

	-- Step 34: Temple of the Moon
	["Temple of the Moon"] = "Tempel des Mondes",
	-- {zone:1457} Darnassus
	["Step through the portal into {zone:1457}. The Temple of the Moon is in the south of the city."] = "Tritt durch das Portal nach {zone:1457}. Der Tempel des Mondes liegt im Süden der Stadt.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, beside her"] = "{npc:7740}, neben ihr",

	-- Step 38: Cenarion Enclave
	-- {npc:3516} Arch Druid Fandral Staghelm
	["{npc:3516}, at the top of the tree"] = "{npc:3516}, oben im Baum",

	-- Step 39: Class trainer
	["Class trainer"] = "Klassenlehrer",

	-- Step 40: Cenarion Enclave
	-- {zone:1449} Un'Goro Crater
	["the soil comes from {zone:1449}, later"] = "die Erde kommt später aus {zone:1449}",

	-- Step 41: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal nach {zone:1438}",

	-- Step 43: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",

	-- Step 44: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "Flieg nach {area:348}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Flugmeister von {area:150}",

	-- Step 45: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Flieg nach {area:271}",

	-- Step 46: Hinterlands
	-- {area:348} Aerie Peak · {area:271} Southshore · {zone:1425} Hinterlands
	["No flight path to {area:348} yet: ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border."] = "Noch keine Flugroute nach {area:348}: Reite auf der Straße nach Nordosten aus {area:271} hinaus ins {zone:1425}; {area:348} liegt gleich hinter der Grenze.",

	-- Step 47: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master"] = "{npc:5636}, neben dem Flugmeister",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}, drinnen",

	-- Step 50: Sprinkle's Secret Ingredient
	["Underwater"] = "Unter Wasser",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:976} to Theramore, take the boat to {area:150} and fly to {area:1537}. Train."] = "Flieg von {area:976} nach Theramore, nimm das Boot zum Ort {area:150} und flieg nach {area:1537}. Trainiere.",
	-- ["Fly to {area:348}. {zone:1425} guide starts here."] = "Flieg nach {area:348}. Der Guide für {zone:1425} beginnt hier.",
	-- ["Follow the coast south to the pirate cove. Southsea pirates crowd the beach and the boats: work along the edge and pull one at a time. {npc:7883} stands on the far side; {npc:7881}'s stolen cargo lies in the camp."] = "Folge der Küste nach Süden zur Piratenbucht. Piraten der Südmeerfreibeuter drängen sich am Strand und auf den Booten: Arbeite dich am Rand entlang und zieh einen nach dem anderen. {npc:7883} steht auf der anderen Seite; die gestohlene Fracht von {npc:7881} liegt im Lager.",
	-- ["From the {area:1108} dock, boat to Feathermoon and fly to {area:489}, then ride east through {zone:1441} to the {area:2240} on the {area:439}. {npc:4454} and {npc:4630} are in the camps beside the track; {npc:4709} stands by the goblin camp."] = "Nimm vom Steg im Gebiet {area:1108} das Boot nach Feathermoon und flieg nach {area:489}, dann reite nach Osten durch {zone:1441} zur {area:2240} im Gebiet {area:439}. {npc:4454} und {npc:4630} sind in den Lagern neben der Rennstrecke; {npc:4709} steht beim Goblinlager.",
	-- ["He runs off to keep Rizzle busy"] = "Er läuft los, um Rizzle abzulenken",
	-- ["Hearth to {area:976}."] = "Ruhestein nach {area:976}.",
	-- ["Ride back west to {area:976}."] = "Reite zurück nach Westen nach {area:976}.",
	-- ["Ride back west toward {area:976}. The Wastewander bandits and thieves hold the dunes on the way; any of them can carry a water pouch."] = "Reite zurück nach Westen Richtung {area:976}. Die Banditen und Diebe der Wüstenläufer halten unterwegs die Dünen; jeder von ihnen kann einen Wasserbeutel tragen.",
	-- ["Ride north-west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts."] = "Reite nach Nordwesten zum Stock der Centipaar in den Dünen. Jeder Centipaar kann Insektenteile droppen.",
	-- ["Ride south into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley. The Thistleshrubs are 48-50, above you: pull one at a time."] = "Reite nach Süden ins {quest:3362}. Die Disteltausammler droppen die Drüsen; nur manche sind gefüllt, also behalte die Gefüllte Taudrüse. Knorrige Distelwandler und Distelwurzelformer teilen sich das Tal. Die Distelwandler sind Stufe 48-50, über dir: Zieh einen nach dem anderen.",
	-- ["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside."] = "Reite nach Süden an {area:1938} vorbei zu {area:981}, den Tunneln der Hazzali; Scrimshanks Ausrüstung liegt tief darin.",
	-- ["Ride south-east off the {area:439} into {area:440}. {area:976} is just inside the border."] = "Reite vom Gebiet {area:439} nach Südosten nach {area:440}. {area:976} liegt gleich hinter der Grenze.",
	-- ["Ride south-east to {area:985}. {npc:7847} stands in the middle of the southern Wastewander camp: clear around him first."] = "Reite nach Südosten zum {area:985}. {npc:7847} steht in der Mitte des südlichen Lagers der Wüstenläufer: Räum zuerst um ihn herum.",
	-- ["Rizzle's plans"] = "Rizzles Pläne",
	-- ["The Wanted poster by {npc:7882}"] = "Der Steckbrief bei {npc:7882}",
	-- ["The tougher Wastewander rogues, shadow mages and assassins camp south-east of {area:976}, south of the bandits. Leave {npc:7847} in the middle of the southern camp for later."] = "Die stärkeren Schurken, Schattenmagier und Auftragsmörder der Wüstenläufer lagern südöstlich von {area:976}, südlich der Banditen. Lass {npc:7847} in der Mitte des südlichen Lagers für später.",
	-- ["Wastewander bandits"] = "Banditen der Wüstenläufer",
	-- ["While {npc:4709} keeps Rizzle talking, his plans lie unguarded in the gnome camp across the track."] = "Während {npc:4709} Rizzle in ein Gespräch verwickelt, liegen dessen Pläne unbewacht im Gnomenlager auf der anderen Seite der Rennstrecke.",
	-- ["for {zone:1457}: the route takes you there at 47"] = "für {zone:1457}: Die Route führt dich mit 47 dorthin",
	-- ["grind on {npc:5474}"] = "Grinde an {npc:5474}",
	-- ["{npc:11758}, on the east side of town"] = "{npc:11758}, an der Ostseite der Stadt",
	-- ["{npc:7583}'s next ingredient grows in the {zone:1425}, and the route never brings it back: skip it."] = "Die nächste Zutat von {npc:7583} wächst im {zone:1425}, und die Route führt dich nie wieder dorthin: Überspring sie.",
	-- ["{npc:7881}'s next delivery goes back to {area:35}: skip it."] = "Die nächste Lieferung von {npc:7881} geht zurück nach {area:35}: Überspring sie.",
	-- ["{npc:7881}, in the port's tavern"] = "{npc:7881}, in der Taverne des Hafens",
}
