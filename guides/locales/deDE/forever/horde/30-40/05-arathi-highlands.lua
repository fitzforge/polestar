-- German (deDE): the guide forever/horde/30-40/05-arathi-highlands (forever/horde/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin nach {zone:1458}",

	-- Step 2: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Lehrer in {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Trainiere, solange du in {zone:1458} bist: Die Lehrer stehen im {object:36070}, im {object:36073} und im {object:36082} (Paladine: {npc:260093}).",

	-- Step 3: Calder Gray
	-- {npc:270038} Calder Gray
	["{npc:270038} stands in the Apothecarium."] = "{npc:270038} steht im Apothekarium.",
	-- {npc:270038} Calder Gray · {zone:1441} Thousand Needles
	["{npc:270038}: Stormheart's heart from {zone:1441}"] = "{npc:270038}: Stormhearts Herz aus {zone:1441}",

	-- Step 4: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Flieg nach {area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Flugmeister der {zone:1458}",

	-- Step 5: Tarren Mill
	-- {npc:2229} Krusk · {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow
	["{npc:2229}, {npc:2410} and {npc:2437} are inside the inn; {npc:2770} stands outside it."] = "{npc:2229}, {npc:2410} und {npc:2437} sind im Gasthaus; {npc:2770} steht draußen davor.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, drinnen",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}, drinnen",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {item:279469} Grimy Key
	["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410}: {quest:93680}, der {item:279469} ist bei den Verrätern",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}, drinnen",
	-- {npc:2770} Tallow · {npc:2771} Drum Fel · {area:321} Hammerfall
	["{npc:2770}: for {npc:2771} in {area:321}, later in this guide"] = "{npc:2770}: für {npc:2771} in {area:321}, später in diesem Guide",
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}, für {npc:2333}",

	-- Step 6: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik · {npc:2229} Krusk
	["Follow the road north out of {area:272} into the Alterac foothills: {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "Folge der Straße aus {area:272} nach Norden in die Ausläufer des Alteracgebirges: {quest:535} wartet beim Lager des Syndikats. Er bietet seinen Auftrag nur an, solange du Infiltration von {npc:2229} hast: Gib ihm sofort das Starkbier, und seine Belohnung ist das Syndikatsschreiben, das Krusk will. Ein Schreiben vom Syndikat hier tut dasselbe: Hast du eins in den Taschen, überspringt der Guide {quest:535}.",

	-- Step 7: Syndicate missives
	["Syndicate missives"] = "Schreiben des Syndikats",
	-- {quest:535} Valik
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one."] = "Nur, wenn du das Schreiben von {quest:535} nicht bekommen hast: Die Schleicher und Diebe des Syndikats (32-34) um die Lager westlich der Straße tragen auch Schreiben; etwa jeder dritte lässt eins fallen.",

	-- Step 8: Alterac Mountains
	-- {npc:246848} Kirin Tor Guard
	["West along the foot of the hills, south of the road: a {npc:246848} (55) walks that road from the north-east down into the traitors' camp."] = "Geh am Fuß der Hügel nach Westen, südlich der Straße: Eine {npc:246848} (55) läuft diese Straße von Nordosten hinunter ins Lager der Verräter.",
	-- {area:279} Dalaran
	["South of the {area:279} crater's camp"] = "Südlich des Lagers im Krater von {area:279}",

	-- Step 9: The Dalaran crater
	-- {area:279} Dalaran
	["The {area:279} crater"] = "Der Krater von {area:279}",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token · Kirin Tor Guards = {npc:246848} Kirin Tor Guard · Kirin Tor Enforcers = {npc:276215} Kirin Tor Enforcer
	["From the south, walk up into the camp below the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together in the camp, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens: the ones on the camp's west side are furthest from the Guard's road.\nCareful: Kirin Tor Guards (55) attack the Horde on sight, and one of them patrols the road that comes down into the camp from the north-east and walks right up to the traitors: he has killed many players here. Watch for him, let him walk back up the road, then pull the traitors. Many of the camp's guards stand in linked pairs and others patrol alone. Arcane Sentries (55, elite) and Kirin Tor Enforcers (55) stand around the violet dome itself: keep to the camp below the rim."] = "Geh von Süden hinauf ins Lager unter der violetten Kuppel von {area:279}. {npc:2411}, {npc:2412} und {npc:2413} (33-34) stehen zusammen im Lager, {npc:2414} (35) etwas westlich von ihnen; jeder trägt ein Blutsteinstück. Die Schildwachen und Theurgen (31-33) um sie herum lassen die Abgenutzten Steinmarken fallen: Die auf der Westseite des Lagers sind am weitesten von der Straße der Wache entfernt.\nVorsicht: Wachen der Kirin Tor (55) greifen die Horde sofort an, und eine davon patrouilliert die Straße, die von Nordosten ins Lager herunterkommt, und läuft direkt bis zu den Verrätern: Sie hat hier schon viele Spieler getötet. Achte auf sie, lass sie die Straße wieder hinauflaufen, dann zieh die Verräter. Viele Wachen des Lagers stehen in verbundenen Paaren, andere patrouillieren allein. Arkane Wächter (55, Elite) und Vollstrecker der Kirin Tor (55) stehen um die violette Kuppel selbst: Bleib im Lager unterhalb des Rands.",
	-- {item:279469} Grimy Key
	["{item:279469}: an object to loot, by the traitors"] = "{item:279469}: ein Objekt zum Plündern, bei den Verrätern",
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Worn Stone Tokens, from the Shield Guards and Theurgists on the camp's west side"] = "Abgenutzte Steinmarken, von den Schildwachen und Theurgen auf der Westseite des Lagers",

	-- Step 11: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east along the foothills to {area:272}: everything from the first loop is handed in inside the inn."] = "Geh an den Ausläufern entlang zurück nach Osten nach {area:272}: Alles aus der ersten Runde wird im Gasthaus abgegeben.",

	-- Step 13: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north up the road past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Geh die Straße nach Norden hinauf am Lager von {quest:535} vorbei nach {area:280}, dem vom Syndikat gehaltenen Dorf (35-37). {npc:2431} trägt den {item:3704}; {quest:503} sitzt in einem Käfig im Haus an der Nordseite.\nVorsicht: Getarnte Syndikat-Spione streifen durch {area:280}, und die Gebäude beherbergen viele Syndikat-Mobs, darunter Magier.",
	["Inside"] = "Drinnen",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "Finde heraus, wo {quest:503} festgehalten wird, im obersten Stockwerk",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}, im obersten Stockwerk",
	-- {npc:2229} Krusk · {npc:2423} Lord Aliden Perenolde · {area:1339} Lordamere Lake
	["{npc:2229} will offer {npc:2423} (41, in his manor far up {area:1339}) for this: leave it, he is over your level."] = "{npc:2229} bietet dafür {npc:2423} an (41, in seinem Herrenhaus weit oben am {area:1339}): Lass es liegen, er liegt über deiner Stufe.",

	-- Step 14: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707}: Töte diese, wenn sie dir begegnen",
	-- {area:280} Strahnbrad · {area:1357} Gallows' Corner · {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["From {area:280} follow the road south-west to {area:1357} and on west to the ruins north of the {area:279} crater, along the lake shore. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "Folge von {area:280} der Straße nach Südwesten bis {area:1357} und weiter nach Westen zu den Ruinen nördlich des Kraters von {area:279}, am Seeufer entlang. Die Beschwörer von Dalaran führen Elementarsklaven an; die Armschienen fallen von den Sklaven. Vorsicht: Arkane Wächter (55, Elite) und Wachen der Kirin Tor (55) bewachen die Kuppel selbst und greifen die Horde an: Arbeite dich am Außenrand der Ruinen entlang und geh nicht zur Kuppel hinauf.",

	-- Step 15: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "Zurück nach {area:272}",
	-- {area:272} Tarren Mill
	["Hearth back to {area:272} (your hearthstone is bound there), or walk back south-east along the road out of Alterac."] = "Nimm den Ruhestein zurück nach {area:272} (dein Ruhestein ist dort gebunden) oder lauf die Straße aus Alterac nach Südosten zurück.",

	-- Step 16: Tarren Mill
	-- {area:272} Tarren Mill
	["Hearth back to {area:272}: your hearthstone is bound there."] = "Nimm den Ruhestein zurück nach {area:272}: Dein Ruhestein ist dort gebunden.",
	["The magus offers a dungeon errand next: leave it."] = "Der Magus bietet als Nächstes einen Dungeon-Auftrag an: Lass ihn liegen.",

	-- Step 17: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "Die Straße nach Osten durch {area:1057}",

	-- Step 18: Boulderfist camp
	["Boulderfist camp"] = "Lager der Felsfäuste",
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "Verlasse {area:272} nach Osten durch {area:1057} und folge der Straße nach Osten. Die Boulderfist-Oger und -Vollstrecker (32-34) lagern südlich der Straße, südlich von {area:313}; die Vollstrecker bleiben in der Höhle dort.",
	["Below ground"] = "Unter der Erde",

	-- Step 19: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "Folge der Straße nach Osten. Die violetten Splitter leuchten direkt neben der Straße, ein kurzes Stück westlich von {area:321}.",

	-- Step 20: Hammerfall
	-- {npc:2851} Urda · {npc:15126} Rutherford Twing · {quest:8263} Defiler's Basic Care Package · {zone:1461} Arathi Basin
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "Die Orc-Festung am östlichen Ende der Straße. {npc:2851}, der Windreitermeister, steht am Tor.\n{npc:15126} bietet das {quest:8263} erst an, wenn du bei den Entweihten ({zone:1461}) Freundlich bist: Überspringe es, wenn er es nicht anbietet.",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, am Tor",
	-- {npc:12920} Doctor Gregory Victor · {skill:129} First Aid
	["{npc:12920}, at the south gate. If {npc:12920} offers nothing, another player may be running his {skill:129} quest Triage: he can be busy for a few minutes. Wait, then talk to him again."] = "{npc:12920}, am Südtor. Wenn {npc:12920} nichts anbietet, macht vielleicht gerade ein anderer Spieler seine {skill:129}-Quest Triage: Er kann ein paar Minuten beschäftigt sein. Warte und sprich ihn dann erneut an.",

	-- Step 21: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "Stromgarde-Quests für eine Gruppe",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "{quest:639} von {npc:2703} fällt von den Elite-Syndikatsleuten (35-38) in den Ruinen von Stromgarde, im Westen des Hochlands. Tolle EP, wenn du eine Gruppe dafür hast: Die Route kommt auf dem Weg zum inneren Kreis an Stromgarde vorbei.",

	-- Step 22: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Nordöstlich von Hammerfall bauen die Drywhisker-Kobolde in der Schlucht ab; die Kobolde am Eingang und die Gräber und Landvermesser weiter drinnen lassen alle die Myzrael-Splitter fallen.\nVorsicht: Jede Koboldart rennt bei niedriger Gesundheit los, um Hilfe zu holen (Kobolde bei 30%, Landvermesser und Gräber bei 15%), was weitere von ihnen heranziehen kann.",

	-- Step 23: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} liegen am hinteren Ende der Schlucht.",

	-- Step 24: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Jeder {object:180105} ist ein Ring aus Menhiren; der Schlüssel liegt auf dem Stein in seiner Mitte. Der östliche Kreis liegt auf den Hügeln nordwestlich von {area:321}.\nVorsicht: Jeder mittlere Stein wird von etwa drei Elementaren nahe Stufe 39 bewacht, die gemeinsam angreifen, wenn du den Stein anklickst, ohne sie geräumt zu haben: Brennende Verbannte im Westen, Donnernde Verbannte im Äußeren, Brandende Verbannte im Osten.",

	-- Step 25: Witherbark Village
	["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Südlich von Hammerfall halten die Witherbark-Trolle das Dorf in den Hügeln. Axtwerfer bewachen die äußeren Hütten; die Hexendoktoren und Kopfjäger halten das Herz des Dorfes. Vorsicht: Alle drei Trollarten fliehen bei 15% Gesundheit, um Hilfe zu holen, was weitere Trolle aus den nahen Lagern heranziehen kann.",

	-- Step 26: Highland raptors and Plains Creepers
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["Highland raptors and Plains Creepers"] = "Hochland-Raptoren und Plains Creepers",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider · Plains Creepers = {npc:2563} Plains Creeper
	["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "Auf dem Rückweg nach Norden streifen Highland Striders durch die Hügel rund um {area:321} und lassen die Augen fallen, und südlich davon spinnen die Plains Creepers (32-33) ihre Netze im Gras; sie tragen die Spinnenseide.",
	-- {item:278225} Surgical Spidersilk
	-- plural, as words: Plains Creepers = {npc:2563} Plains Creeper
	["{item:278225}, from Plains Creepers"] = "{item:278225}, von Plains Creepersn",

	-- Step 27: Hammerfall
	-- {area:321} Hammerfall
	["Back north to {area:321}: the doctor stands at the south gate."] = "Zurück nach Norden nach {area:321}: Der Doktor steht am Südtor.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate. If he won't take the silk, another player may be running Triage: wait a few minutes and talk to him again."] = "{npc:12920}, am Südtor. Wenn er die Seide nicht annimmt, macht vielleicht gerade ein anderer Spieler Triage: Warte ein paar Minuten und sprich ihn erneut an.",
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}, am Südtor",

	-- Step 28: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "Die Boulderfist-Rohlinge lagern vor der Halle der Oger, weit südwestlich von {area:321}; die Magi stehen unter ihnen. Zieh sie einzeln.",

	-- Step 29: Fleshstalker raptors
	["Fleshstalker raptors"] = "Hochlandfleischpirscher",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Hochlandfleischpirscher (36-37) jagen im südlichen Hochland, ein Rudel nördlich von {area:316} und ein weiteres auf der Ebene westlich davon. Zieh sie einzeln.",

	-- Step 30: Go'shek Farm
	["Go'shek Farm"] = "Gehöft Go'shek",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "Die Laborhütte von {npc:2733} steht auf dem Gehöft Go'shek, nordöstlich der Raptorenebene auf dem Rückweg nach {area:321}; die Kiste mit {item:278462} ist drinnen.",

	-- Step 31: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Zurück nach {area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "Zurück nach Nordosten nach {area:321}.",

	-- Step 32: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "Boulderfist-Quests für eine Gruppe",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "Die nächste {quest:678} von {npc:2771} und {quest:680} von {npc:2772} sind die Elite-Oger (38-40) im Ogerviertel von Stromgarde, auf demselben Gruppenausflug wie das Siegel.",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}, neben ihm",

	-- Step 33: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "Geh nach Westen; der äußere Kreis steht in der Mitte des Hochlands.",

	-- Step 34: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "Der westliche Kreis ist nahe {area:1057}, nordwestlich des äußeren.",

	-- Step 35: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "Der innere Kreis liegt südlich des westlichen Kreises, östlich von Stromgarde.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "Die nächste Aufgabe des Steins braucht Fozruk, einen Elite der Stufe 42, der westlich von {area:321} umherzieht: Lass sie liegen.",

	-- Step 36: Stromgarde
	["Stromgarde"] = "Stromgarde",
	-- {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "Westlich des inneren Kreises die Ruinen von Stromgarde: Das Syndikat hält die Osthälfte (das Siegel fällt von ihren Beschwörern, Pirschern und Magi), die Boulderfist die Westhälfte beim {area:325} ({npc:2773} wartet in einem der dachlosen Häuser daneben).",

	-- Step 37: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Geh nach Süden zur Bucht der Goblins an der Südküste. {npc:2766} hält auf der Klippe darüber Wache.",

	-- Step 38: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Eskortiere den Professor den Hügel hinauf zur Höhle über der Bucht und beschütze ihn, während er arbeitet. Zwei Wasserelementare der Stufe 40 greifen ihn dort aus dem Hinterhalt an, und sie sind immun gegen Frost. Halt sie am Höhleneingang fest, weg von ihm: Findet der Kampf in der Höhle statt, mischt er sich ein, statt zu arbeiten, und es kommen immer mehr Elementare nach.",

	-- Step 40: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}: Töte diese, sobald sie dir begegnen",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "Westlich der Bucht halten die Räuber und Zauberhexerinnen der Säbelflossen (38-40) das Ufer: Zieh sie einzeln. Die beiden Wracks liegen davor im seichten Wasser, die Karten und Logbücher darin; die Edelsteine liegen um die Wracks auf dem Meeresgrund.",
	["Underwater"] = "Unter Wasser",

	-- Step 41: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "für {npc:2487} in {area:35}, bei etwa Stufe 41",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "Der nächste Guide überquert die {area:880} ins {zone:1437} und hält auf die {zone:1418} zu.",

	-- Step 42: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "Nur wenn du Stromgarde mit einer Gruppe gemacht hast: zurück nach {area:321} für die Abgaben, dann weiter zur {area:880}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Head back east to {area:272}."] = "Geh zurück nach Osten zu {area:272}.",
	-- ["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "Geh nach Osten aus {area:272} durch {area:1057}. Das Syndikat hält das ummauerte Herrenhaus und seinen Hof nördlich der Straße; ihre Wegelagerer, Söldner und Pfadpirscher tragen die Blutstein-Amulette.\nVorsicht: Wegelagerer (Stufe 30-31) können im Schleichen sein, sodass sie verborgen sein können, wenn du dich näherst.",
	-- ["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Geh nach Norden an Valiks Lager vorbei nach {area:280}, dem vom Syndikat gehaltenen Dorf (35-37). {npc:2431} trägt den {item:3704}; {quest:503} sitzt in einem Käfig im Haus an der Nordseite.\nVorsicht: Getarnte Syndikat-Spione streifen durch {area:280}, und die Gebäude beherbergen viele Syndikat-Mobs, darunter Magier.",
	-- ["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "Geh nach Nordwesten durch die Berge zum Herrenhaus Perenolde am Nordufer des {area:1339}. {quest:507} (41) wartet in einem Zimmer oben: Er schützt sich mit einem Schild, schickt dich in den Schlaf und heilt sich unter der Hälfte seiner Gesundheit. {npc:2317} steht neben ihm.",
	-- ["Perenolde manor"] = "Herrenhaus Perenolde",
	-- ["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "Südlich am Seeufer entlang zu den Ruinen um den Krater von {area:279}. Die Beschwörer von Dalaran führen Elementarsklaven an; die Armschienen fallen von den Sklaven. Vorsicht: Arkane Wächter (55, Elite) und Wachen der Kirin Tor (55) bewachen die Kuppel selbst und greifen die Horde an: Arbeite dich am Außenrand der Ruinen entlang und geh nicht zur Kuppel hinauf.",
	-- ["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "Die Schläger der Felsfäuste lagern vor der Halle der Oger südlich von {area:321}; die Magier der Felsfäuste stehen zwischen ihnen. Zieh sie einzeln.",
	-- ["The {object:1763} poster by the inn"] = "Das Plakat {object:1763} beim Gasthaus",
	-- ["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "Westlich des inneren Kreises die Ruinen von Stromgarde: Das Syndikat hält die Osthälfte (das Siegel fällt von ihren Beschwörern, Pirschern und Magi; {npc:2783} ist unter ihnen), die Boulderfist die Westhälfte beim {area:325} ({npc:2773} wartet in einem der dachlosen Häuser daneben).",
	-- ["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "{npc:2229} wartet drinnen im Gasthaus bei {area:272}, die Straße zurück nach Süden.",
	-- ["{npc:2229}, inside the inn"] = "{npc:2229}, im Gasthaus",
	-- ["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "{npc:2306} (40) trägt den Kopf. Er taucht jeweils an einer Stelle auf: im Keller des Gasthauses von {area:280} oder in einem der Syndikat-Zeltlager im Hochland nördlich und nordwestlich des Dorfes, die auf deinem Weg zum Herrenhaus Perenolde liegen. Wenn du ihm schon beim Befreien von {quest:503} begegnet bist, ist dieser Schritt erledigt.",
	-- ["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "Die nächste {quest:671} von {npc:2706} ist {npc:2783}, ein Elite-Hexenmeister der Stufe 40 im Syndikatsviertel von Stromgarde.",
	-- ["{quest:671} with a group"] = "{quest:671} mit einer Gruppe",
}
