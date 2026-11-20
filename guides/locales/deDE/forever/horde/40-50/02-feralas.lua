-- German (deDE): the guide forever/horde/40-50/02-feralas (forever/horde/40-50/02-feralas.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Flieg nach {object:3202}",
	-- {zone:2548} Riverglades · {area:340} Kargath
	["Coming from the {zone:2548}: {area:340}'s flight master stands at the foot of the fortress."] = "Aus {zone:2548} kommend: Der Flugmeister von {area:340} steht am Fuß der Festung.",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Flugmeister in {area:340}",

	-- Step 2: Fly to Grom'gol
	-- {area:75} Stonard
	["{area:75} flight master"] = "Flugmeister in {area:75}",

	-- Step 3: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay · {npc:1514} Mokk the Savage · {zone:1454} Orgrimmar · {object:2076} Bubbling Cauldron
	["The flight lands at {object:3202}. Stranglethorn's harder errands, carried from your first visit, fit you now: the Skullsplitter chief, Zanzil's camps, {area:35}'s pirates, the naga coast and {npc:1514}, before the zeppelin to {zone:1454}. The {object:2076} beside Nimboya has the Skullsplitter chief's quest."] = "Der Flug landet in {object:3202}. Die schwierigeren Aufträge im Schlingendorntal von deinem ersten Besuch passen jetzt zu dir: der Häuptling der Skullsplitter, Zanzils Lager, die Piraten von {area:35}, die Nagaküste und {npc:1514}, bevor du den Zeppelin nach {zone:1454} nimmst. Neben Nimboya steht ein {object:2076}: Er hat die Quest zum Häuptling der Skullsplitter.",
	-- {object:2076} Bubbling Cauldron · {quest:586} Speaking with Gan'zulah
	["the {object:2076}: {quest:586}"] = "{object:2076}: {quest:586}",

	-- Step 4: Zul'Mamwe
	["Zul'Mamwe"] = "Ruinen von Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel · {quest:586} Speaking with Gan'zulah · {npc:1060} Mogh the Undying
	["Ride east to the Skullsplitter ruins east of the Venture Co. mine. The headhunters, berserkers and hunters roam the ruins.\n{npc:1059} (45) carries the Broken Armor for {quest:586}: he walks the south-western ruins with two guards and sometimes stands in a small cave there. Pull the guards first.\nCareful: {npc:1060}, an elite troll (level 44), stands in the southern ruins around 47.7,44.3: pull the headhunters and berserkers away from him."] = "Reite nach Osten zu den Ruinen der Skullsplitter östlich der Mine der Venture Co. Die Kopfjäger, Berserker und Jäger streifen durch die Ruinen.\n{npc:1059} (45) trägt die Zerbrochene Rüstung für {quest:586}: Er läuft mit zwei Wachen durch die südwestlichen Ruinen und steht manchmal in einer kleinen Höhle dort. Zieh zuerst die Wachen.\nVorsicht: {npc:1060}, ein Elite-Troll (Stufe 44), steht in den südlichen Ruinen bei 47.7,44.3: Zieh die Kopfjäger und Berserker von ihm weg.",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} läuft hier herum: schau in den Kreis auf der Karte",

	-- Step 5: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back west to {object:3202}."] = "Zurück nach Westen nach {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "noch einmal {object:2076}: Yennikus Schicksal",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks bask beside the road south, on the ride to {area:35}"] = "{npc:2519}: Die Basilisken sonnen sich neben der Straße nach Süden, auf dem Weg nach {area:35}",

	-- Step 6: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Eisenkieferbasilisken",
	-- {area:35} Booty Bay
	["Ride south along the road towards {area:35}; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "Reite auf der Straße nach Süden Richtung {area:35}; die Basilisken sonnen sich mitten im Dschungel auf den Felsen östlich davon. Ihre Splitter droppen oft.",
	["Below ground"] = "Unter der Erde",

	-- Step 7: Pirate ghosts and Zanzil's camps
	["Pirate ghosts and Zanzil's camps"] = "Piratengeister und Zanzils Lager",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs" · {npc:2534} Zanzil the Outcast
	-- plural, as words: Zanzil Witch Doctors = {npc:1490} Zanzil Witch Doctor
	["On south-west to the jungle north-east of Mistvale: the three ghostly pirates haunt it beside Zanzil's camps. {npc:2535} and {npc:2536} stand together, {npc:2537} further east. Every one of Zanzil's followers can carry the mixture.\nCareful: the Zanzil Witch Doctors (44) cast and the camps are packed: pull from the edge, one at a time. {npc:2534} (46) himself stands in the southern camp around 39.6,58.6, a few steps from {npc:2537}'s ghost: pull {npc:2537} out to the north or east before you fight him."] = "Weiter nach Südwesten in den Dschungel nordöstlich des Nebeltals: Die drei geisterhaften Piraten spuken dort neben Zanzils Lagern. {npc:2535} und {npc:2536} stehen zusammen, {npc:2537} weiter östlich. Jeder von Zanzils Anhängern kann die Mixtur tragen.\nVorsicht: Die Hexendoktoren von Zanzil (44) wirken Zauber und die Lager sind voll: Zieh vom Rand aus, einen nach dem anderen. {npc:2534} (46) selbst steht im südlichen Lager bei 39.6,58.6, ein paar Schritte von {npc:2537} entfernt: Zieh {npc:2537} nach Norden oder Osten heraus, bevor du gegen ihn kämpfst.",

	-- Step 8: Witch Doctor Unbagwa
	-- {npc:1449} Witch Doctor Unbagwa · {npc:1514} Mokk the Savage
	["West into Mistvale: {npc:1449} sits among the gorillas. Any gorilla can drop a fang: hand him ten and stay by him, he calls three waves of gorillas, then {npc:1514}.\nCareful: three waves of gorillas come one after another with little rest between, then {npc:1514}. Start at full health and mana, and stay near Unbagwa. Some classes find it hard alone: a friend makes it easy."] = "Nach Westen ins Nebeltal: {npc:1449} sitzt zwischen den Gorillas. Jeder Gorilla kann einen Reißzahn droppen: Gib ihm zehn und bleib bei ihm, er ruft drei Wellen Gorillas herbei, dann {npc:1514}.\nVorsicht: Drei Wellen Gorillas kommen kurz hintereinander, dann {npc:1514}. Starte mit voller Gesundheit und vollem Mana und bleib in Unbagwas Nähe. Manche Klassen tun sich allein schwer: Mit einem Freund ist es leicht.",

	-- Step 9: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}: töte diese, wenn du sie triffst",
	-- {object:759} Holy Spring · {area:43} Wild Shore · {area:35} Booty Bay
	["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them.\nFollow the coast south. If you still need the {area:43} pirates, take the road past the {area:35} tunnel to the beach before going into town."] = "",

	-- Step 10: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	["Stay on the beach with the swashbucklers (41-43); the charts and the orders lie in their tents and in the rowboat beside the larger camp. Leave the ships alone."] = "",

	-- Step 12: Dudd Fizzlescroll
	-- {quest:95384} Partial Mystical Notes · {npc:260873} Dudd Fizzlescroll · {area:35} Booty Bay
	["If you already have the {quest:95384}, give them to {npc:260873} here in {area:35}."] = "",

	-- Step 14: Booty Bay
	-- {area:35} Booty Bay · {npc:2494} Privateer Bloads · {npc:2486} Fin Fizracket · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["In {area:35}: {npc:2494} on the docks, {npc:2486} by the inn, {npc:2498} inside it, MacKinley, {npc:737} and {npc:773} upstairs."] = "In {area:35}: {npc:2494} an den Docks, {npc:2486} beim Gasthaus, {npc:2498} darin, MacKinley, {npc:737} und {npc:773} oben.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, drinnen",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "„Sea Wolf“ MacKinley, im obersten Stockwerk",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, oben",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}, later in this guide"] = "{npc:773}, oben: für {quest:2864} in {area:976}, später in diesem Guide",

	-- Step 17: Unfinished Wild Shore errands
	-- {area:43} Wild Shore
	["Unfinished {area:43} errands"] = "",
	["If the town rewards just brought you to 42 and you still owe pirate work, use the shore tents, not the ships."] = "",

	-- Step 21: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Flugmeister von {area:35}",

	-- Step 22: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:2519} Kin'weelay · {npc:2465} Far Seer Mok'thardin
	["The flight lands at {object:3202}: {npc:2519} and {npc:2465}, then the zeppelin tower."] = "Der Flug landet in {object:3202}: {npc:2519} und {npc:2465}, dann der Zeppelinturm.",

	-- Step 24: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zeppelin nach {zone:1454}",

	-- Step 25: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "Die Mitte von {zone:1454}",

	-- Step 27: Riding at 40
	["Riding at 40"] = "Reiten mit 40",
	-- {npc:4752} Kildar · {object:172958} Valley of Honor · {npc:3362} Ogunaro Wolfrunner · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel. Skyborne learn it from {npc:265756} at the {area:17684} in {area:16638} on Zephras Isle, with a Galestrider: the skyboat to the isle leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; wenn du es lernst, bekommst du ein Reittier. {npc:4752} unterrichtet Orcs im {object:172958}, beim Zwinger von {npc:3362}. Himmelsgeborene lernen es bei {npc:265756} in {area:17684} in {area:16638} auf Zephras Isle, mit einem Galestrider: Das Himmelsboot zur Insel legt an den Klippen südlich von {area:17045}, nördlich von {zone:1456}, ungefähr alle fünf Minuten ab. Die anderen Reittiere deiner Rasse kosten je 20 Gold: Sammelobjekte, Reittiere · Stufe 40 hat für jedes einen Guide.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, Reitlehrer",
	-- {npc:3362} Ogunaro Wolfrunner · {npc:4752} Kildar
	["Wolves: {npc:3362}, beside {npc:4752}."] = "Wölfe: {npc:3362}, neben {npc:4752}.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Reiten und Galestrider: {npc:265756}, in den {area:17684} in {area:16638} auf Zephras Isle.",

	-- Step 29: Riding at 40
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1411} Durotar
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:7953} in {area:367}, a short ride south of {zone:1454} down the {zone:1411} road, with Zjolnir's raptors (20 gold each) beside him. Ride back to {zone:1454}'s flight master afterwards."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; wenn du es lernst, bekommst du ein Reittier. Jede Rasse lernt es bei ihrem eigenen Rassenlehrer: deiner ist {npc:7953} in {area:367}, ein kurzes Stück südlich von {zone:1454} die Straße von {zone:1411} entlang, mit den Raptoren von Zjolnir (je 20 Gold) neben ihm. Reite danach zurück zum Flugmeister von {zone:1454}.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, Reitlehrer",
	-- {npc:7953} Xar'Ti · {area:367} Sen'jin Village
	["Raptors: Zjolnir, beside {npc:7953} in {area:367}."] = "Raptoren: Zjolnir, neben {npc:7953} in {area:367}.",

	-- Step 30: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "Flieg nach {area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Flugmeister: {zone:1454}",

	-- Step 32: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["Your trainer is in {zone:1456}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins)."] = "Dein Lehrer ist in {zone:1456}: {npc:3033} (Druiden) auf {area:1639}, {npc:246344} (Paladine).",

	-- Step 34: Riding at 40
	-- {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village · {npc:3685} Harb Clawhoof · {zone:1456} Thunder Bluff
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Ride back up to {zone:1456}'s flight master afterwards."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; wenn du es lernst, bekommst du ein Reittier. Jede Rasse lernt es bei ihrem eigenen Rassenlehrer: deiner ist {npc:3690} in {area:222}, mit den Kodos von {npc:3685} (je 20 Gold) neben ihm. Reite danach zurück zum Flugmeister von {zone:1456}.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, Reitlehrer",
	-- {npc:3685} Harb Clawhoof · {npc:3690} Kar Stormsinger · {area:222} Bloodhoof Village
	["Kodos: {npc:3685}, beside {npc:3690} in {area:222}."] = "Kodos: {npc:3685}, neben {npc:3690} in {area:222}.",

	-- Step 35: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "Flieg zum {area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Flugmeister von {zone:1456}",

	-- Step 36: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Flieg nach {area:976}",

	-- Step 39: Ratchet for the Felsteed
	-- {area:392} Ratchet
	["{area:392} for the Felsteed"] = "{area:392} für das Teufelsross",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly from {zone:1454} to {area:392}; {npc:6251} stands on the hill above the docks."] = "Flieg von {zone:1454} nach {area:392}; {npc:6251} steht auf dem Hügel über den Docks.",

	-- Step 40: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Flugmeister in {area:392}",

	-- Step 46: Gadgetzan
	-- {area:976} Gadgetzan · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["Flown in: {area:976}'s quests first, by the flight master, then the {area:2240} is a short ride north over the {zone:1446} border."] = "Eingeflogen: Zuerst die Quests von {area:976} beim Flugmeister, dann ist {area:2240} ein kurzer Ritt nach Norden über die Grenze von {zone:1446}.",

	-- Step 47: Gadgetzan
	-- {area:978} Zul'Farrak · {quest:2864} Tran'rek · {npc:7804} Trenton Lighthammer · {quest:3042} Troll Temper
	["For your {area:978} run, in the next guide: {quest:2864} wants scarab shells, and {npc:7804}, a short walk from the flight master, {quest:3042} from the Sandfury trolls."] = "Für deinen Run durch {area:978} im nächsten Guide: {quest:2864} will Skarabäuspanzer, und {npc:7804}, ein kurzes Stück vom Flugmeister entfernt, {quest:3042} von den Trollen der Sandfury.",

	-- Step 48: Mirage Raceway
	-- {area:976} Gadgetzan · {zone:1446} Tanaris · {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {npc:4454} Fizzle Brassbolts · {npc:4630} Pozzik · {npc:4709} Zamek
	["Flown in to {area:976}: the raceway is a short ride north over the {zone:1446} border.\nThe road from {area:484} to {zone:1446} runs past the {area:2240} on the {area:439}: {npc:4454} is in the gnomes' camp beside the track, {npc:4630} and {npc:4709} by the goblins' camp. {npc:4630} first, then {npc:4709}, who runs off to keep Rizzle busy; then take Rizzle's plans from the gnomes' camp and bring them back to {npc:4630}."] = "Mit dem Flug in {area:976} angekommen: Die Rennstrecke liegt einen kurzen Ritt nördlich, gleich hinter der Grenze zu {zone:1446}.\nDie Straße von {area:484} nach {zone:1446} führt an {area:2240} auf {area:439} vorbei: {npc:4454} ist im Lager der Gnome neben der Piste, {npc:4630} und {npc:4709} beim Lager der Goblins. Erst {npc:4630}, dann {npc:4709}, der losrennt, um Rizzle zu beschäftigen; dann nimm Rizzles Pläne aus dem Lager der Gnome und bring sie zu {npc:4630} zurück.",
	-- {npc:4454} Fizzle Brassbolts · {quest:1137} News for Fizzle · {zone:1418} Badlands
	["{npc:4454}: {quest:1137}, from Martek in the {zone:1418}"] = "{npc:4454}: {quest:1137}, von Martek in {zone:1418}",

	-- Step 49: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "Nach {area:976}",

	-- Step 50: Gadgetzan
	-- {area:976} Gadgetzan · {zone:1446} Tanaris
	["{area:976} is the walled goblin town just past the {zone:1446} border."] = "{area:976} ist die ummauerte Goblinstadt gleich hinter der Grenze von {zone:1446}.",

	-- Step 52: Noonshade Ruins: kill these as you meet them
	-- {area:1937} Noonshade Ruins
	["{area:1937}: kill these as you meet them"] = "{area:1937}: Töte diese, sobald sie dir begegnen",
	-- {area:976} Gadgetzan
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: Luglunket wants five.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Die Banditen und Diebe lagern in den Dünen östlich von {area:976}. Jeder Wüstenläufer kann einen Wasserbeutel tragen: Luglunket will fünf.\nVorsicht: Schurken der Wüstenläufer (Stufe 43-44) bewegen sich getarnt und können sich unbemerkt nähern.",

	-- Step 54: Steamwheedle Port
	["Ride north-east to the goblin harbour on the coast."] = "Reite nach Nordosten zum Goblinhafen an der Küste.",
	-- {npc:7882} Security Chief Bilgewhizzle
	["{npc:7882}, inside"] = "{npc:7882}, drinnen",
	-- {npc:7881} Stoley
	["{npc:7881}, inside"] = "{npc:7881}, drinnen",
	-- {npc:8579} Yeh'kinya · {zone:1444} Feralas
	["{npc:8579}: the screechers live in {zone:1444}, on the next {zone:1444} visit"] = "{npc:8579}: Die Screechers leben in {zone:1444}, beim nächsten Besuch in {zone:1444}",
	-- {npc:260405} Wharfmaster Steamfizzle · {zone:2548} Riverglades
	["{npc:260405}, on the pier: Friz's errand from the {zone:2548}, if you carry it"] = "{npc:260405}, auf dem Pier: Friz' Auftrag aus {zone:2548}, falls du ihn dabeihast",

	-- Step 55: Lost Rigger Cove: kill these as you meet them
	-- {area:1336} Lost Rigger Cove
	["{area:1336}: kill these as you meet them"] = "{area:1336}: Töte diese, sobald sie dir begegnen",
	-- {npc:7883} Andre Firebeard
	["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883} (45), and many more pirates from the town join the fight once it starts: pull his guards away from him first."] = "Südlich an der Küste halten die Südmeerpiraten die Bucht. {npc:7883} und die gestohlene Fracht liegen an den Docks am Ende der Bucht. Jeder Pirat kann einen Hut fallen lassen, die Entführer am häufigsten.\nVorsicht: Zwei oder drei Piraten stehen bei {npc:7883} (45), und viele weitere Piraten aus der Stadt schließen sich dem Kampf an, sobald er beginnt: Zieh zuerst seine Wachen von ihm weg.",
	["Upstairs"] = "Oben",

	-- Step 56: Waterspring Field: kill these as you meet them
	-- {area:985} Waterspring Field
	["{area:985}: kill these as you meet them"] = "{area:985}: töte diese, wenn du sie triffst",
	-- {area:976} Gadgetzan · {npc:7847} Caliph Scorpidsting
	-- plural, as words: Wastewander Rogues = {npc:5615} Wastewander Rogue
	["The shadow mages, rogues and assassins camp south-east of {area:976}.\nSouth-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp.\nCareful: Wastewander Rogues keep Sneak up while out of combat, so hidden rogues can join a fight you start at a camp.\nCareful: Two stealthed Wastewander Rogues travel with him wherever he goes. At his spawn camp, two shadowmages and their minions are close enough to join a fight with him. Out by the towers you can fight him without them."] = "Die Schattenmagier, Schurken und Assassinen lagern südöstlich von {area:976}.\nSüdöstlich von Gadgetzan lagern die Banditen der Wastewander in den Dünen; {npc:7847} steht im östlichen Lager.\nVorsicht: Wastewander Rogues bleiben außerhalb des Kampfes in Verstohlenheit, sodass versteckte Schurken in einen Kampf eingreifen können, den du an einem Lager beginnst.\nVorsicht: Zwei getarnte Wastewander Rogues begleiten ihn, wohin er auch geht. An seinem Spawn-Lager sind zwei Schattenmagier und ihre Diener nah genug, um in den Kampf mit ihm einzugreifen. Draußen bei den Türmen kannst du ihn ohne sie bekämpfen.",

	-- Step 57: Steamwheedle Port
	-- {npc:7881} Stoley · {npc:15165} Haughty Modiste · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["Ride north-east back to the port: {npc:7881}, the {npc:15165} and the Security Chief take what {area:1336} gave you. {area:976} is west of it."] = "Reite nach Nordosten zurück zum Hafen: {npc:7881}, {npc:15165} und der Sicherheitschef nehmen, was {area:1336} dir gegeben hat. {area:976} liegt westlich davon.",
	-- {area:35} Booty Bay
	["for {area:35}, around level 51 (40-50/06)"] = "für {area:35}, etwa um Stufe 51 (40-50/06)",

	-- Step 59: Fly to Freewind Post
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Flugmeister von {area:976}",

	-- Step 61: Camp Mojache
	-- {npc:7777} Rok Orhan · {area:1099} Camp Mojache
	["{npc:7777} walks around {area:1099}: look inside the circle on the map"] = "{npc:7777} läuft um {area:1099} herum: schau in den Kreis auf der Karte",
	-- {npc:8115} Witch Doctor Uzer'i · {npc:263190} Tan'jani · {zone:2548} Riverglades
	["{npc:8115}: {npc:263190}'s errand from the {zone:2548}, if you carry it"] = "{npc:8115}: Auftrag von {npc:263190} aus {zone:2548}, falls du ihn dabeihast",
	-- {npc:8115} Witch Doctor Uzer'i · {zone:1454} Orgrimmar
	["{npc:8115}: for {zone:1454}, around level 45"] = "{npc:8115}: für {zone:1454}, etwa ab Stufe 45",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, drinnen",

	-- Step 62: Gordunni Outpost
	-- {npc:222233} Ohk'zi
	["North of the gnolls the ogres hold a hilltop outpost; pull the ogre-magi to you. The cobalt is in the dirt mounds around the outpost, and the scroll lies on the ground inside it.\nCareful: {npc:222233} (level 43, elite) stands in the outpost: pull the ogres out to you, away from him."] = "Nördlich der Gnolle halten die Oger einen Außenposten auf einem Hügel; zieh die Ogermagier zu dir. Das Kobalt ist in den Erdhügeln um den Außenposten, und die Schriftrolle liegt drinnen auf dem Boden.\nVorsicht: {npc:222233} (Stufe 43, Elite) steht im Außenposten: Zieh die Oger zu dir heraus, weg von ihm.",

	-- Step 63: Woodpaw north camp
	["Woodpaw north camp"] = "Nördliches Lager der Waldpfoten",
	["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane.\nCareful: Every Woodpaw gnoll except the Alpha runs off for help at 15% health, which can pull more gnolls into the fight."] = "Die Woodpaw-Gnolle lagern in den Hügeln direkt nordwestlich von Mojache; jeder von ihnen kann eine Mähne fallen lassen.\nVorsicht: Jeder Woodpaw-Gnoll außer dem Alpha rennt bei 15% Gesundheit los, um Hilfe zu holen, wodurch weitere Gnolle in den Kampf gezogen werden können.",

	-- Step 64: Camp Mojache
	-- {quest:2863} Alpha Strike
	["{quest:2863}: one hour from now"] = "{quest:2863}: eine Stunde ab jetzt",

	-- Step 65: Feralas: kill these as you meet them
	-- {zone:1444} Feralas
	["{zone:1444}: kill these as you meet them"] = "{zone:1444}: töte diese, wenn du sie triffst",
	["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour.\nCareful: Most Alphas sit in small tent camps with 2-4 other gnolls that join the fight, and other gnolls patrol between the camps."] = "Die Sprite Darters schwirren über den Hain direkt westlich von Mojache; fast jeder lässt einen Flügel fallen. Die Woodpaw Alphas führen die Lager südwestlich davon an: Töte sie innerhalb einer Stunde.\nVorsicht: Die meisten Alphas sitzen in kleinen Zeltlagern mit 2-4 anderen Gnollen, die in den Kampf eingreifen, und zwischen den Lagern patrouillieren weitere Gnolle.",

	-- Step 67: Grimtotem camp
	["Grimtotem camp"] = "Lager der Grimmtotem",
	-- {npc:222286} Namida Grimtotem
	["The Grimtotem tauren camp beside the sprite darters' grove; raiders, naturalists and shamans all carry horns.\nCareful: {npc:222286} (level 43, elite) stands in the camp: pull the raiders and shamans away from her."] = "Die Tauren der Grimmtotem lagern neben dem Hain der Grimmlingflitzer; Räuber, Naturalisten und Schamanen tragen alle Hörner.\nVorsicht: {npc:222286} (Stufe 43, Elite) steht im Lager: Zieh die Räuber und Schamanen von ihr weg.",

	-- Step 68: Woodpaw battle map
	["Woodpaw battle map"] = "Schlachtplan der Waldpfoten",
	["The battle map lies in the Woodpaw camp south of Mojache."] = "Der Schlachtplan liegt im Lager der Waldpfoten südlich von Mojache.",

	-- Step 69: Camp Mojache
	-- {zone:1454} Orgrimmar
	["for {zone:1454}, around level 45"] = "für {zone:1454}, etwa ab Stufe 45",

	-- Step 70: The Writhing Deep
	-- {quest:7731} Stinglasher
	["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber.\nCareful: {quest:7731} is level 47: clear the hive around him and pull him alone at full health."] = "Der Bau der Zukk'ash gräbt sich in die Hügel südöstlich des Lagers; {quest:7731} wartet in seiner tiefsten Kammer.\nVorsicht: {quest:7731} ist Stufe 47: Räum den Bau um ihn herum und zieh ihn allein mit voller Gesundheit.",

	-- Step 71: Ruins of Isildien: kill these as you meet them
	-- {area:2522} Ruins of Isildien
	["{area:2522}: kill these as you meet them"] = "{area:2522}: töte diese, wenn du sie triffst",
	-- {area:1105} Feral Scar Vale
	["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb.\nCareful: the Mage-Lords (45-46) and the Shamans cast from range and the ruins are packed: pull one at a time from the edge."] = "Reite vom Bau nach Westen zu den Ogerruinen unterhalb von {area:1105}. Schamanen, Hexenmeister und Raufer füllen sie; die Magierfürsten am Südende tragen die Kugel.\nVorsicht: Die Magierfürsten (45-46) und die Schamanen zaubern aus der Ferne, und die Ruinen sind dicht besetzt: Zieh sie einzeln vom Rand aus.",
	-- {npc:5234} Gordunni Mauler · {area:2522} Ruins of Isildien
	["{npc:5234} walks around {area:2522}: look inside the circle on the map"] = "{npc:5234} läuft um {area:2522} herum: schau in den Kreis auf der Karte",

	-- Step 72: Feral Scar Vale yetis
	-- {area:1105} Feral Scar Vale
	["{area:1105} yetis"] = "Yetis in {area:1105}",
	-- {area:1105} Feral Scar Vale · {npc:5346} Bloodroar the Stalker
	["North-west of the ruins, pull one yeti at a time at the eastern mouth of {area:1105} for thick hides. Careful: larger yetis crowd the cave further west, and {npc:5346}, a level 48 rare, lurks at the far end."] = "",

	-- Step 73: Homing Robot OOX-22/FE
	-- {zone:1444} Feralas · {area:1105} Feral Scar Vale · {area:1108} Forgotten Coast · {area:35} Booty Bay
	["Only with the distress beacon: any beast, gnoll or ogre in {zone:1444} can drop it, about one kill in a hundred; use it to start the quest. The robot sits in a small cave on the north side of {area:1105}, just north-west of the ruins. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit.\nCareful: Three ambushes spawn during the escort, and the robot warns you before each one. The first is 3 yetis, just after the robot leaves the cave and climbs toward the road. The second is 3 gorillas, on the path that runs along the cliff. The third is about 4 gnolls, one of them a caster, where the route turns off toward the dock."] = "Nur mit dem Notsignal: Jedes Tier, jeder Gnoll und jeder Oger in {zone:1444} kann es fallen lassen, ungefähr bei jedem hundertsten Kill; benutze es, um die Quest zu starten. Der Roboter sitzt in einer kleinen Höhle an der Nordseite von {area:1105}, direkt nordwestlich der Ruinen. Eskortiere ihn zum Dock an der {area:1108}; Yetis und Gorillas überfallen dich unterwegs. Seine Belohnung wartet in {area:35} auf einen späteren Besuch.\nVorsicht: Während der Eskorte tauchen drei Hinterhalte auf, und der Roboter warnt dich vor jedem. Der erste sind 3 Yetis, direkt nachdem der Roboter die Höhle verlässt und zur Straße hinaufklettert. Der zweite sind 3 Gorillas, auf dem Pfad entlang der Klippe. Der dritte sind etwa 4 Gnolle, einer davon ein Zauberwirker, dort wo die Route zum Dock abbiegt.",

	-- Step 74: Camp Mojache
	-- {zone:1444} Feralas
	["the Rage Scar yetis, on the next visit to {zone:1444}"] = "die Rage Scar Yetis, beim nächsten Besuch in {zone:1444}",
	-- {npc:7875} Hadoken Swiftstrider · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["{npc:7875}: for {npc:7010} in {zone:1454}"] = "{npc:7875}: für {npc:7010} in {zone:1454}",
	-- {zone:1454} Orgrimmar · {zone:2652} Shen'dralas
	["for {zone:1454}, after {zone:2652}"] = "für {zone:1454}, nach {zone:2652}",
	-- {zone:2652} Shen'dralas · {area:1099} Camp Mojache · {zone:1443} Desolace · {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {npc:7311} Uthel'nay
	["{zone:2652} is next, a ride north from {area:1099} into {zone:1443}: keep your {zone:1454} hand-ins (Neeru, Zilzibin, {npc:4485}, {npc:7311}) for the flight there after it."] = "Als Nächstes kommt {zone:2652}, ein Ritt nach Norden von {area:1099} nach {zone:1443}: Behalte deine Abgaben für {zone:1454} (Neeru, Zilzibin, {npc:4485}, {npc:7311}) für den Flug dorthin danach.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into town. The ships' captains, Seahorn's next request, are for your Stranglethorn stop at about 50."] = "Zurück in die Stadt. Die Schiffskapitäne, Seahorns nächste Bitte, sind für deinen Halt im Schlingendorntal mit etwa 50.",
	-- ["Eastern Wastewander camps"] = "Östliche Lager der Wüstenläufer",
	-- ["Fly to {area:1637}"] = "Flieg nach {area:1637}",
	-- ["Fly to {area:1637}. The Droffers brothers run their shop in the Drag."] = "Flieg nach {area:1637}. Die Gebrüder Droffers führen ihren Laden in der Gasse.",
	-- ["Fly to {area:484}, ride down the lift east of the post and across the salt flats, then south into {zone:1446}."] = "Flieg zum {area:484}, fahr mit dem Aufzug östlich des Postens hinunter und reite über die Salzebenen, dann nach Süden nach {zone:1446}.",
	-- ["Fly to {area:484}, then ride west through the canyons past {area:2237}; the road climbs into the {zone:1444} jungle and on to {area:1099}."] = "Flieg zum {area:484} und reite dann nach Westen durch die Schluchten am {area:2237} vorbei; die Straße steigt in den Dschungel von {zone:1444} hinauf und führt weiter zum {area:1099}.",
	-- ["Fly to {area:75}"] = "Flieg nach {area:75}",
	-- ["Fly to {zone:1454}. From the flight master: the {object:172960}, then the Drag, then the {object:172958}."] = "Flieg nach {zone:1454}. Vom Flugmeister aus: {object:172960}, dann die Gasse, dann {object:172958}.",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Windschreiter: {npc:265756}, in {area:16638} auf der Insel Zephras.",
	-- ["Hearth to {area:1099}"] = "Ruhestein zum {area:1099}",
	-- ["Keep riding west to the coast. The Coast Crawl Deepseers and Snapclaws on the beaches drop OOX-22/FE's distress beacon about one kill in forty: if one drops, use it to start the quest."] = "Reite weiter nach Westen zur Küste. Die Küstenkriechertiefseher und Küstenkriecherschnappklauen an den Stränden lassen etwa bei jedem vierzigsten Kill das Notsignal von OOX-22/FE fallen: Fällt eins, benutze es, um die Quest zu starten.",
	-- ["North-west of the ruins, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "Nordwestlich der Ruinen hausen die Yetis in {area:1105}; jeder Yeti dort kann ein dickes Fell fallen lassen.",
	-- ["Only with the distress beacon: the robot sits in a small cave on the north side of {area:1105}. Escort it to the dock on the {area:1108}; yetis and gorillas ambush you on the way. Its reward waits in {area:35} for a later visit."] = "Nur mit dem Notsignalgeber: Der Roboter sitzt in einer kleinen Höhle auf der Nordseite von {area:1105}. Eskortiere ihn zum Steg an {area:1108}; Yetis und Gorillas überfallen euch unterwegs. Seine Belohnung wartet in {area:35} auf einen späteren Besuch.",
	-- ["Ride back north-west from {area:1978} to {area:75} and fly to {object:3202}."] = "Reite von {area:1978} zurück nach Nordwesten nach {area:75} und flieg nach {object:3202}.",
	-- ["Ride back west to {area:976}."] = "Reite zurück nach Westen nach {area:976}.",
	-- ["Ride south-west to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Reite nach Südwesten zu den Ogerruinen unterhalb von {area:1105}. Schamanen, Hexenmeister und Raufer füllen sie; die Magierlords am Südende tragen die Kugel.",
	-- ["Ride west from the hive to the ogre ruins below {area:1105}. Shamans, warlocks and maulers fill them; the Mage-Lords at the southern end carry the orb."] = "Reite vom Bienenstock nach Westen zu den Ogerruinen unterhalb von {area:1105}. Schamanen, Hexenmeister und Mauler füllen sie; die Magierlords am südlichen Ende tragen die Kugel.",
	-- ["Ride west into the middle of {zone:1444}. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "Reite nach Westen in die Mitte von {zone:1444}. Töte einen {npc:5308}, benutze {item:10699} an seiner Leiche und töte den Geist, der aufsteigt.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:3690} in {area:222}, with {npc:3685}'s kodos (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. In Classic lernt es jedes Volk beim Lehrer seines eigenen Volkes: Deiner ist {npc:3690} in {area:222}, mit den Kodos von {npc:3685} (je 20 Gold) neben ihm. Forever lässt vielleicht jedes Volk bei jedem Reitlehrer lernen (nicht bestätigt): Versuch es zuerst bei {npc:4752} im {object:172958} von {zone:1454}, er ist am nächsten, und überspring diesen Schritt, wenn er es dir beibringt.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, with {npc:4731}'s skeletal horses (20 gold each) beside her. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. In Classic lernt es jedes Volk beim Lehrer seines eigenen Volkes: Deiner ist {npc:4773} in {area:159}, mit den Skelettpferden von {npc:4731} (je 20 Gold) neben ihr. Forever lässt vielleicht jedes Volk bei jedem Reitlehrer lernen (nicht bestätigt): Versuch es zuerst bei {npc:4752} im {object:172958} von {zone:1454}, er ist am nächsten, und überspring diesen Schritt, wenn er es dir beibringt.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. In Classic each race learns it from its own race's trainer: yours is {npc:7953} in {area:367} on the {zone:1411} coast, with Zjolnir's raptors (20 gold each) beside him. Forever may let any race learn from any riding trainer (not confirmed): try {npc:4752} in {zone:1454}'s {object:172958} first, as he is the nearest, and skip this step if he teaches you."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. In Classic lernt es jedes Volk beim Lehrer seines eigenen Volkes: Deiner ist {npc:7953} in {area:367} an der Küste von {zone:1411}, mit Zjolnirs Raptoren (je 20 Gold) neben ihm. Forever lässt vielleicht jedes Volk bei jedem Reitlehrer lernen (nicht bestätigt): Versuch es zuerst bei {npc:4752} im {object:172958} von {zone:1454}, er ist am nächsten, und überspring diesen Schritt, wenn er es dir beibringt.",
	-- ["Riding needs level 40 and costs 100 gold; learning it gives you a mount. {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel; no Skyborne riding trainer is known, so Skyborne try {npc:4752} too. Your race's other mounts are 20 gold each: Collectibles, Mounts · Level 40 has a guide for each."] = "Reiten erfordert Stufe 40 und kostet 100 Gold; beim Erlernen erhältst du ein Reittier. {npc:4752} lehrt Orcs im {object:172958}, beim Zwinger von {npc:3362}; es ist kein Reitlehrer der Himmelsgeborenen bekannt, also versuchen es Himmelsgeborene ebenfalls bei {npc:4752}. Die übrigen Reittiere deines Volkes kosten je 20 Gold: Sammelobjekte, Reittiere · Stufe 40 hat für jedes einen Guide.",
	-- ["Rogue Vale screechers"] = "Kreischer",
	-- ["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Skelettpferde: {npc:4731}, neben {npc:4773} in {area:159}.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often."] = "Weiter südlich an der Küste halten die Südmeerfreibeuter die Bucht. {npc:7883} und die gestohlene Fracht sind auf den Docks am hinteren Ende. Jeder Pirat kann einen Hut fallen lassen, die Entführer am häufigsten.",
	-- ["South along the coast, the Southsea pirates hold the cove. {npc:7883} and the stolen cargo are on the docks at its far end. Any pirate can drop a hat, the kidnappers most often.\nCareful: Two or three pirates stand with {npc:7883}, and many more pirates from the town join the fight once it starts."] = "Südlich an der Küste halten die Piraten der Südsee die Bucht. {npc:7883} und die gestohlene Fracht liegen an den Docks am Ende der Bucht. Jeder Pirat kann einen Hut fallen lassen, die Entführer am häufigsten.\nVorsicht: Zwei oder drei Piraten stehen bei {npc:7883}, und viele weitere Piraten aus der Stadt schließen sich dem Kampf an, sobald er beginnt.",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Südlich von Booty Bay lagern die Schwadroneure der Blutsegelbukaniere an der {area:43}; die Karten und Befehle liegen in ihren Zelten und im Ruderboot neben dem größeren Lager. Jeder Blutsegelbukanier kann Schnupftabak und {npc:2493}s Auge tragen, also töte weiter, bis du beides hast.",
	-- ["Southern Gordunni ruins"] = "Südliche Ruinen der Gordunni",
	-- ["Southern Wastewander camps"] = "Südliche Lager der Wüstenläufer",
	-- ["Sprite darters and Woodpaw alphas"] = "Grimmlingflitzer und Alphas der Waldpfoten",
	-- ["The Woodpaw gnolls camp in the hills just north-west of Mojache; any of them can drop a mane."] = "Die Gnolle der Waldpfoten lagern in den Hügeln gleich nordwestlich von Mojache; jeder kann eine Mähne fallen lassen.",
	-- ["The Zukk'ash hive burrows into the hills south-east of the camp; {quest:7731} waits in its deepest chamber."] = "Der Bau der Zukk'ash gräbt sich in die Hügel südöstlich des Lagers; {quest:7731} wartet in seiner tiefsten Kammer.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties."] = "Die Banditen und Diebe lagern in den Dünen östlich von {area:976}. Jeder Wüstenläufer kann einen Wasserbeutel tragen: Behalte zehn, fünf für jedes von Luglunkets Kopfgeldern.",
	-- ["The bandits and thieves camp in the dunes east of {area:976}. Every Wastewander can carry a water pouch: keep ten, five for each of Luglunket's bounties.\nCareful: Wastewander Rogues (level 43-44) move stealthed, so they can approach unseen."] = "Die Banditen und Diebe lagern in den Dünen östlich von {area:976}. Jeder Wastewander kann einen Wasserbeutel tragen: Behalte zehn, fünf für jedes von Luglunkets Kopfgeldern.\nVorsicht: Wastewander Rogues (Stufe 43-44) bewegen sich getarnt und können sich unbemerkt nähern.",
	-- ["The shadow mages, rogues and assassins camp south-east of {area:976}."] = "Die Schattenmagier, Schurken und Auftragsmörder lagern südöstlich von {area:976}.",
	-- ["The sprite darters flit over the grove just west of Mojache; nearly every one drops a wing. The Woodpaw alphas lead the camps south-west of it: kill them within the hour."] = "Die Grimmlingflitzer schwirren über dem Hain gleich westlich von Mojache; fast jeder lässt einen Flügel fallen. Die Alphas der Waldpfoten führen die Lager südwestlich davon: Töte sie innerhalb der Stunde.",
	-- ["The {object:3202} zeppelin leaves from the tower just north-east of {zone:1454}'s main gate."] = "Der Zeppelin nach {object:3202} startet vom Turm gleich nordöstlich des Haupttors von {zone:1454}.",
	-- ["The {zone:1454} zeppelin leaves from the tower beside {object:3202}; it lands just outside {zone:1454}'s main gate."] = "Der Zeppelin nach {zone:1454} startet vom Turm neben {object:3202}; er landet gleich vor dem Haupttor von {zone:1454}.",
	-- ["Thysta, the flight master, stands just east of the zeppelin tower. Fly to {area:75}: the next guide starts there."] = "Thysta, die Flugmeisterin, steht gleich östlich des Zeppelinturms. Flieg nach {area:75}: Dort beginnt der nächste Guide.",
	-- ["West to the coast: the naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them. Then follow the coast south to {area:35}."] = "Nach Westen zur Küste: Die Naga-Forscher waten am Ufer entlang und tragen die Schilfbündel; {object:759} sprudelt in den Hügeln gleich östlich davon. Folge dann der Küste nach Süden nach {area:35}.",
	-- ["Your trainer is in {area:1638}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly there from {zone:1454}, then on to {area:484}."] = "Dein Lehrer ist in {area:1638}: {npc:3033} (Druiden) auf der {area:1639}, {npc:246344} (Paladine). Flieg von {zone:1454} dorthin, dann weiter zum {area:484}.",
	-- ["Zeppelin to {object:3202}"] = "Zeppelin nach {object:3202}",
	-- ["Zeppelin tower"] = "Zeppelinturm",
	-- ["for the {zone:1425}, around level 48"] = "für das {zone:1425}, etwa ab Stufe 48",
	-- ["for {area:35}, around level 50"] = "für {area:35}, etwa ab Stufe 50",
	-- ["the {object:150075} in the square"] = "{object:150075} auf dem Platz",
	-- ["water pouches in your bags"] = "Wasserbeutel in deinen Taschen",
	-- ["{area:1099} flight master"] = "Flugmeister in {area:1099}",
	-- ["{area:976} is the walled goblin town just past the {area:440} border."] = "{area:976} ist die ummauerte Goblinstadt gleich hinter der Grenze von {area:440}.",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}, im obersten Stockwerk",
	-- ["{npc:4630}: the {item:5852} from {npc:2496}, if you carry them"] = "{npc:4630}: die {item:5852} von {npc:2496}, falls du sie dabeihast",
	-- ["{npc:4706}, beside {npc:4630}"] = "{npc:4706}, neben {npc:4630}",
	-- ["{npc:4773}, riding trainer"] = "{npc:4773}, Reitlehrerin",
	-- ["{npc:6986}, the Drag"] = "{npc:6986}, die Gasse",
	-- ["{npc:7010}, the Drag"] = "{npc:7010}, die Gasse",
	-- ["{npc:7953}, riding trainer"] = "{npc:7953}, Reitlehrer",
	-- ["{npc:8579}: the screechers live in {zone:1444}"] = "{npc:8579}: Die Kreischer leben in {zone:1444}",
}
