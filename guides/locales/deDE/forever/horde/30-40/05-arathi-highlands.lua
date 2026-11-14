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
	-- {npc:2229} Krusk
	["{npc:2229}, inside the inn"] = "{npc:2229}, im Gasthaus",
	-- {object:1763} WANTED
	["The {object:1763} poster by the inn"] = "Das Plakat {object:1763} beim Gasthaus",
	-- {npc:2437} Keeper Bel'varil
	["{npc:2437}, inside"] = "{npc:2437}, drinnen",
	-- {npc:2410} Magus Wordeen Voidglare
	["{npc:2410}, inside"] = "{npc:2410}, drinnen",

	-- Step 7: Gol'dir
	-- {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Head north past Valik's camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side.\nCareful: Stealthed Syndicate spies roam {area:280}, and the buildings hold many Syndicate mobs, mages among them."] = "Geh nach Norden an Valiks Lager vorbei nach {area:280}, dem vom Syndikat gehaltenen Dorf (35-37). {npc:2431} trägt den {item:3704}; {quest:503} sitzt in einem Käfig im Haus an der Nordseite.\nVorsicht: Getarnte Syndikat-Spione streifen durch {area:280}, und die Gebäude beherbergen viele Syndikat-Mobs, darunter Magier.",
	["Inside"] = "Drinnen",
	-- {quest:503} Gol'dir
	["Find where {quest:503} is held, on the top floor"] = "Finde heraus, wo {quest:503} festgehalten wird, im obersten Stockwerk",
	-- {quest:503} Gol'dir
	["{quest:503}, on the top floor"] = "{quest:503}, im obersten Stockwerk",

	-- Step 9: Tarren Mill
	-- {npc:2229} Krusk · {area:272} Tarren Mill
	["{npc:2229} waits inside the inn at {area:272}, back south down the road."] = "{npc:2229} wartet drinnen im Gasthaus bei {area:272}, die Straße zurück nach Süden.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, drinnen",

	-- Step 10: Baron Vardus
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad · {quest:503} Gol'dir
	["{npc:2306} (40) carries the head. He turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village, which lie on your way to the Perenolde manor. If you already met him while freeing {quest:503}, this step is done."] = "{npc:2306} (40) trägt den Kopf. Er taucht jeweils an einer Stelle auf: im Keller des Gasthauses von {area:280} oder in einem der Syndikat-Zeltlager im Hochland nördlich und nordwestlich des Dorfes, die auf deinem Weg zum Herrenhaus Perenolde liegen. Wenn du ihm schon beim Befreien von {quest:503} begegnet bist, ist dieser Schritt erledigt.",

	-- Step 11: Alterac Mountains
	["Perenolde manor"] = "Herrenhaus Perenolde",

	-- Step 12: Lord Aliden Perenolde
	-- {area:1339} Lordamere Lake · {quest:507} Lord Aliden Perenolde · {npc:2317} Elysa
	["Head north-west through the mountains to the Perenolde manor on the northern shore of {area:1339}. {quest:507} (41) waits in a room upstairs: he shields himself, puts you to sleep and heals below half health. {npc:2317} stands beside him."] = "Geh nach Nordwesten durch die Berge zum Herrenhaus Perenolde am Nordufer des {area:1339}. {quest:507} (41) wartet in einem Zimmer oben: Er schützt sich mit einem Schild, schickt dich in den Schlaf und heilt sich unter der Hälfte seiner Gesundheit. {npc:2317} steht neben ihm.",

	-- Step 13: Old Dalaran Ruins: kill these as you meet them
	-- {area:17707} Old Dalaran Ruins
	["{area:17707}: kill these as you meet them"] = "{area:17707}: Töte diese, wenn sie dir begegnen",
	-- {area:279} Dalaran
	-- plural, as words: Dalaran Summoners = {npc:2358} Dalaran Summoner · Elemental Slaves = {npc:2359} Elemental Slave · Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["South along the lake shore to the ruins around the {area:279} crater. The Dalaran Summoners lead Elemental Slaves; the bracers drop from the slaves. Careful: Arcane Sentries (55, elite) and Kirin Tor Guards (55) guard the dome itself and attack the Horde: work the ruins' outer edge and don't go up to the dome."] = "Südlich am Seeufer entlang zu den Ruinen um den Krater von {area:279}. Die Beschwörer von Dalaran führen Elementarsklaven an; die Armschienen fallen von den Sklaven. Vorsicht: Arkane Wächter (55, Elite) und Wachen der Kirin Tor (55) bewachen die Kuppel selbst und greifen die Horde an: Arbeite dich am Außenrand der Ruinen entlang und geh nicht zur Kuppel hinauf.",

	-- Step 15: Tarren Mill
	-- {area:272} Tarren Mill
	["Head back east to {area:272}."] = "Geh zurück nach Osten zu {area:272}.",
	["The magus offers a dungeon errand next: leave it."] = "Der Magus bietet als Nächstes einen Dungeon-Auftrag an: Lass ihn liegen.",

	-- Step 16: Thoradin's Wall
	-- {area:1057} Thoradin's Wall
	["The road east through {area:1057}"] = "Die Straße nach Osten durch {area:1057}",

	-- Step 17: Northfold Manor
	-- {area:272} Tarren Mill · {area:1057} Thoradin's Wall
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["Head east out of {area:272} through {area:1057}. The Syndicate hold the walled manor and its farm north of the road; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "Geh nach Osten aus {area:272} durch {area:1057}. Das Syndikat hält das ummauerte Herrenhaus und seinen Hof nördlich der Straße; ihre Wegelagerer, Söldner und Pfadpirscher tragen die Blutstein-Amulette.\nVorsicht: Wegelagerer (Stufe 30-31) können im Schleichen sein, sodass sie verborgen sein können, wenn du dich näherst.",

	-- Step 18: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["Follow the road east. The violet shards glow just off the road a short way west of {area:321}."] = "Folge der Straße nach Osten. Die violetten Splitter leuchten direkt neben der Straße, ein kurzes Stück westlich von {area:321}.",

	-- Step 19: Hammerfall
	-- {npc:12920} Doctor Gregory Victor
	["{npc:12920}, at the south gate"] = "{npc:12920}, am Südtor",

	-- Step 20: Stromgarde quests for a group
	["Stromgarde quests for a group"] = "Stromgarde-Quests für eine Gruppe",
	-- {npc:2703} Zengu · {quest:639} Sigil of Strom
	["{npc:2703}'s {quest:639} drops from the elite Syndicate (35-38) in Stromgarde's ruins, the west of the highlands. Great XP if you have a group for it: the route passes Stromgarde on its way to the inner circle."] = "{quest:639} von {npc:2703} fällt von den Elite-Syndikatsleuten (35-38) in den Ruinen von Stromgarde, im Westen des Hochlands. Tolle EP, wenn du eine Gruppe dafür hast: Die Route kommt auf dem Weg zum inneren Kreis an Stromgarde vorbei.",

	-- Step 21: Foul Magics with a group
	-- {quest:671} Foul Magics
	["{quest:671} with a group"] = "{quest:671} mit einer Gruppe",
	-- {npc:2706} Tor'gan · {quest:671} Foul Magics · {npc:2783} Marez Cowl
	["{npc:2706}'s next {quest:671} is {npc:2783}, a level 40 elite warlock in Stromgarde's Syndicate quarter."] = "Die nächste {quest:671} von {npc:2706} ist {npc:2783}, ein Elite-Hexenmeister der Stufe 40 im Syndikatsviertel von Stromgarde.",

	-- Step 22: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Nordöstlich von Hammerfall bauen die Drywhisker-Kobolde in der Schlucht ab; die Kobolde am Eingang und die Gräber und Landvermesser weiter drinnen lassen alle die Myzrael-Splitter fallen.\nVorsicht: Jede Koboldart rennt bei niedriger Gesundheit los, um Hilfe zu holen (Kobolde bei 30%, Landvermesser und Gräber bei 15%), was weitere von ihnen heranziehen kann.",

	-- Step 23: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701} liegen am hinteren Ende der Schlucht.",
	["Below ground"] = "Unter der Erde",

	-- Step 24: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Jeder {object:180105} ist ein Ring aus Menhiren; der Schlüssel liegt auf dem Stein in seiner Mitte. Der östliche Kreis liegt auf den Hügeln nordwestlich von {area:321}.\nVorsicht: Jeder mittlere Stein wird von etwa drei Elementaren nahe Stufe 39 bewacht, die gemeinsam angreifen, wenn du den Stein anklickst, ohne sie geräumt zu haben: Brennende Verbannte im Westen, Donnernde Verbannte im Äußeren, Brandende Verbannte im Osten.",

	-- Step 25: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall, far south-west of {area:321}; the Magus stand among them. Pull them one at a time."] = "Die Boulderfist-Rohlinge lagern vor der Halle der Oger, weit südwestlich von {area:321}; die Magi stehen unter ihnen. Zieh sie einzeln.",

	-- Step 26: Fleshstalker raptors
	["Fleshstalker raptors"] = "Hochlandfleischpirscher",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Hochlandfleischpirscher (36-37) jagen im südlichen Hochland, ein Rudel nördlich von {area:316} und ein weiteres auf der Ebene westlich davon. Zieh sie einzeln.",

	-- Step 27: Go'shek Farm
	["Go'shek Farm"] = "Gehöft Go'shek",
	-- {npc:2733} Apothecary Jorell · {area:321} Hammerfall · {item:278462} Packaged Tonics
	["{npc:2733}'s lab shack stands at Go'shek Farm, north-east of the raptors' plain on the way back to {area:321}; the case of {item:278462} is inside."] = "Die Laborhütte von {npc:2733} steht auf dem Gehöft Go'shek, nordöstlich der Raptorenebene auf dem Rückweg nach {area:321}; die Kiste mit {item:278462} ist drinnen.",

	-- Step 28: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "Zurück nach {area:321}",
	-- {area:321} Hammerfall
	["Back north-east to {area:321}."] = "Zurück nach Nordosten nach {area:321}.",
	-- {npc:2792} Gor'mul
	["{npc:2792}, by the gate"] = "{npc:2792}, am Tor",

	-- Step 29: Boulderfist quests for a group
	["Boulderfist quests for a group"] = "Boulderfist-Quests für eine Gruppe",
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms · {npc:2772} Korin Fel · {quest:680} The Real Threat
	["{npc:2771}'s next {quest:678} and {npc:2772}'s {quest:680} are the elite ogres (38-40) in Stromgarde's ogre quarter, on the same group trip as the Sigil."] = "Die nächste {quest:678} von {npc:2771} und {quest:680} von {npc:2772} sind die Elite-Oger (38-40) im Ogerviertel von Stromgarde, auf demselben Gruppenausflug wie das Siegel.",
	-- {npc:2772} Korin Fel
	["{npc:2772}, beside him"] = "{npc:2772}, neben ihm",

	-- Step 30: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head west; the outer circle stands in the middle of the highlands."] = "Geh nach Westen; der äußere Kreis steht in der Mitte des Hochlands.",

	-- Step 31: Circle of West Binding
	-- {area:1057} Thoradin's Wall
	["The western circle is near {area:1057}, north-west of the outer one."] = "Der westliche Kreis ist nahe {area:1057}, nordwestlich des äußeren.",

	-- Step 32: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "Der innere Kreis liegt südlich des westlichen Kreises, östlich von Stromgarde.",
	-- {area:321} Hammerfall
	["The stone's next task needs Fozruk, a level 42 elite who roams west of {area:321}: leave it."] = "Die nächste Aufgabe des Steins braucht Fozruk, einen Elite der Stufe 42, der westlich von {area:321} umherzieht: Lass sie liegen.",

	-- Step 33: Stromgarde
	["Stromgarde"] = "Stromgarde",
	-- {npc:2783} Marez Cowl · {area:325} Tower of Arathor · {npc:2773} Or'Kalar
	["West of the inner circle, Stromgarde's ruins: the Syndicate hold the east half (the Sigil drops from their Conjurors, Prowlers and Magi; {npc:2783} is among them), the Boulderfist the west half by the {area:325} ({npc:2773} waits in one of the roofless houses beside it)."] = "Westlich des inneren Kreises die Ruinen von Stromgarde: Das Syndikat hält die Osthälfte (das Siegel fällt von ihren Beschwörern, Pirschern und Magi; {npc:2783} ist unter ihnen), die Boulderfist die Westhälfte beim {area:325} ({npc:2773} wartet in einem der dachlosen Häuser daneben).",

	-- Step 34: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Geh nach Süden zur Bucht der Goblins an der Südküste. {npc:2766} hält auf der Klippe darüber Wache.",

	-- Step 35: Professor Phizzlethorpe
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Eskortiere den Professor den Hügel hinauf zur Höhle über der Bucht und beschütze ihn, während er arbeitet. Zwei Wasserelementare der Stufe 40 greifen ihn dort aus dem Hinterhalt an, und sie sind immun gegen Frost. Halt sie am Höhleneingang fest, weg von ihm: Findet der Kampf in der Höhle statt, mischt er sich ein, statt zu arbeiten, und es kommen immer mehr Elementare nach.",

	-- Step 37: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}: Töte diese, sobald sie dir begegnen",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "Westlich der Bucht halten die Räuber und Zauberhexerinnen der Säbelflossen (38-40) das Ufer: Zieh sie einzeln. Die beiden Wracks liegen davor im seichten Wasser, die Karten und Logbücher darin; die Edelsteine liegen um die Wracks auf dem Meeresgrund.",
	["Underwater"] = "Unter Wasser",

	-- Step 38: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 41"] = "für {npc:2487} in {area:35}, bei etwa Stufe 41",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {zone:1418} Badlands
	["The next guide crosses the {area:880} into the {zone:1437} and heads for the {zone:1418}."] = "Der nächste Guide überquert die {area:880} ins {zone:1437} und hält auf die {zone:1418} zu.",

	-- Step 39: Back to Hammerfall
	-- {area:321} Hammerfall · {area:880} Thandol Span
	["Only if you ran Stromgarde with a group: back to {area:321} for its hand-ins, then on to the {area:880}."] = "Nur wenn du Stromgarde mit einer Gruppe gemacht hast: zurück nach {area:321} für die Abgaben, dann weiter zur {area:880}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "Die Schläger der Felsfäuste lagern vor der Halle der Oger südlich von {area:321}; die Magier der Felsfäuste stehen zwischen ihnen. Zieh sie einzeln.",
}
