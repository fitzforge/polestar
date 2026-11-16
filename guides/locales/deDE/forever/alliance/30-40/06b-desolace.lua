-- German (deDE): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1443} Desolace
	["Kodo bones, demons and lost treasure in south {zone:1443}."] = "Kodoknochen, Dämonen und verlorene Schätze im Süden von {zone:1443}.",
	["Short: about one level of quests"] = "Kurz: etwa eine Stufe an Quests",
	-- {zone:1434} Stranglethorn Vale
	["Then on to {zone:1434}"] = "Danach weiter ins {zone:1434}",
	["Stays on the main route"] = "Bleibt auf der Hauptroute",
	["A long trip out to Kalimdor"] = "Eine lange Reise nach Kalimdor",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Flieg nach {area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Flugmeister in {area:144}",

	-- Step 3: Theramore flight master
	["Theramore flight master"] = "Flugmeister von Theramore",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "Geh vom Boot aus den Pier hinauf zu Baldruc, dem Flugmeister am Tor von {area:514}.",

	-- Step 4: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort
	["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}, falls 30-40/02 sie nicht angenommen hat: Das Wrack liegt unterhalb von {npc:11863}s Turm",
	-- {npc:5396} Captain Pentigast
	["{npc:5396}, if 30-40/02 didn't give it"] = "{npc:5396}, falls 30-40/02 sie nicht gegeben hat",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Folge der Straße nach Süden zu {area:2407}.",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019} steht am Rand des {area:596}, südwestlich von {area:2407}; {object:176751} liegen zwischen den Skeletten.",

	-- Step 7: Hornizz Brimbuzzle
	-- {quest:6134} Ghost-o-plasm Round Up · {area:2657} Valley of Bones
	-- plural, as words: Magram Necrokhans = {npc:253274} Magram Necrokhan
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:6134}'s magnets draw the Magrami Spectres a few yards from the Magram Necrokhans and Corpsefeeders (45, elite) in the {area:2657}. Skip it if you are alone."] = "Das sind Elite-Mobs: Eine Gruppe wird empfohlen, such dir Leute dafür. Die Magneten von {quest:6134} locken die Magrami-Gespenster ein paar Meter von den Nekrokhans und Leichenfressern der Magram (45, Elite) im {area:2657} weg. Überspring sie, wenn du allein bist.",

	-- Step 8: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "Ein {npc:217590} krabbelt im {area:596} herum: Fang einen mit dem Werkzeug aus {item:213565} von {npc:217412}.",

	-- Step 9: Maraudine centaurs
	["Maraudine centaurs"] = "Zentauren der Maraudine",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Die Zentauren der Maraudine halten das {area:607} westlich des Friedhofs; jede Art lässt die Totems fallen.",

	-- Step 10: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} wird im Zentaurenlager westlich des Friedhofs festgehalten. Befreie sie und halte sie auf dem Weg hinaus am Leben; sie bleibt am Friedhof stehen.\nVorsicht: Die geskripteten Gruppen sind verbunden und erscheinen nur während der Eskorte, du kannst sie also nicht vorher räumen oder einzeln ziehen. Die normalen Zentauren auf dem Pfad vor dem Start zu räumen hilft dagegen.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "eskortiere {npc:12277} zurück zum Friedhof",

	-- Step 11: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {npc:5760} Lord Azrethoc
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}. Nether Maidens (37-38) hold its north-west side and drop the wings; Doomwarder Captains (38) stand at the south end and drop the blood.\nCareful: Nether Sorceresses (39-40) stand beside the Doomwarder Captains, and {npc:5760}, a level 40 elite, walks the coven's middle: pull the captains away from them. Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Die Dämonen sammeln sich im {area:602} im Süden von {zone:1443}. Nethermaiden (37-38) halten die Nordwestseite und lassen die Flügel fallen; Captains der Verdammniswächter (38) stehen am Südende und lassen das Blut fallen.\nVorsicht: Netherzauberinnen (39-40) stehen neben den Captains der Verdammniswächter, und {npc:5760}, ein Elite der Stufe 40, läuft durch die Mitte des Zirkels: Zieh die Captains von ihnen weg. Die meisten Mobs hier laufen Patrouillen, du ziehst also leicht zusätzliche Mobs.",
	-- {item:6251} Nether Wing
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden
	["{item:6251}, from the Nether Maidens"] = "{item:6251}, von den Nethermaiden",
	-- {item:6252} Doomwarder Blood
	-- plural, as words: Doomwarder Captains = {npc:4680} Doomwarder Captain
	["{item:6252}, from the Doomwarder Captains"] = "{item:6252}, von den Captains der Verdammniswächter",

	-- Step 12: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields further east, with Magram Necromancers (42): pull the Ravagers to you, away from them."] = "Untote Verheerer streifen über die Knochenfelder südlich des Dorfes der Magram, östlich des Zirkels: Der Pfeil führt zu ihrem Westrand. Vorsicht: Nekrokhane und Leichenfresser der Magram (45, Elite) laufen mit Totenbeschwörern der Magram (42) weiter östlich über die Knochenfelder: Zieh die Verheerer zu dir, weg von ihnen.",

	-- Step 13: The ghost magnets
	["The ghost magnets"] = "Die Geistermagneten",
	-- {item:15848} Crate of Ghost Magnets
	["Use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres; the Necrokhans and Corpsefeeders (45, elite) walk close by: keep the group together."] = "Benutze {item:15848} an seinem Pfeil, auf der Ostseite der Felder, um die Magrami-Gespenster anzulocken; die Nekrokhane und Leichenfresser (45, Elite) laufen ganz in der Nähe: Bleibt als Gruppe zusammen.",

	-- Step 14: Mannoroc Coven
	-- {npc:5760} Lord Azrethoc
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Mage Hunters = {npc:4681} Mage Hunter
	["Back at the coven on the way west: the Mana Eaters (37-38) on its north edge and the Mage Hunters (38-39) further in drop the brains. {npc:5760} (40, elite) walks among the Mage Hunters: pull them out to you."] = "Zurück am Zirkel auf dem Weg nach Westen: Die Manafresser (37-38) am Nordrand und die Magierjäger (38-39) weiter drinnen lassen die Gehirne fallen. {npc:5760} (40, Elite) läuft zwischen den Magierjägern: Zieh sie zu dir heraus.",

	-- Step 17: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Folge der Straße nach Westen durch den Norden von {zone:1443} zu den Ruinen von {area:2405}. Dort steht {npc:11863}s Turm auf dem Hügel, auf dem Weg zum Wrack.",
	-- {npc:11863} Azore Aldamort · {quest:93464} The Visiting Mage · {zone:1435} Swamp of Sorrows
	["{npc:11863}: {quest:93464}, from Magtoor in the {zone:1435}"] = "{npc:11863}: {quest:93464}, von Magtoor in den {zone:1435}",

	-- Step 18: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "Die Truhe des Schiffswracks liegt gleich südwestlich von {npc:11863}s Turm.",

	-- Step 19: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest · {zone:1443} Desolace
	["{object:177787} lies beside {object:35251}, if you didn't take it on your first {zone:1443} visit. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} liegt neben {object:35251}, falls du es nicht bei deinem ersten Besuch in {zone:1443} mitgenommen hast. Sein silberner Schlüssel wird von den Trockenschnappkrebsen rund um das Wrack fallen gelassen; der goldene stammt von den Naga der Schlitterklingen an der Nordwestküste, als Nächstes.",
	-- {object:177787} Rackmore's Log
	["{object:177787}, if 30-40/02 didn't take it"] = "{object:177787}, falls 30-40/02 es nicht mitgenommen hat",
	["Underwater"] = "Unter Wasser",

	-- Step 20: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}: Töte diese, sobald sie dir begegnen",
	-- {npc:11863} Azore Aldamort · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Die Naga der Schlitterklingen halten die Nordwestküste nördlich des Turms von {npc:11863}; Karnitols Tasche liegt davor auf dem Meeresgrund, und jeder Naga kann Rackmores goldenen Schlüssel fallen lassen. Schwimm hinaus nach {area:2406} vor der äußersten Nordspitze und benutze {item:15766} an {object:177673}: {npc:12369} (38) erscheint; töte ihn für {quest:6027}.",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, von den Naga der Schlitterklingen",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue
	["{item:15766}, on the {object:177673}"] = "{item:15766}, an {object:177673}",

	-- Step 21: Rackmore's Chest
	-- {object:177673} Serpent Statue
	["Rackmore's chest lies just south-east of the {object:177673}."] = "Rackmores Truhe liegt gleich südöstlich von {object:177673}.",

	-- Step 24: Nijel's Point
	-- {area:608} Nijel's Point · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "Folge der Straße nach Norden zu {area:608}: {npc:5396} steht am Südende, {npc:5638} in der Mitte, {npc:1182} im Norden.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "für {npc:5637} in {zone:1455}: behalte sie",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "für {npc:3980} in {area:271}: behalte sie",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "Flieg nach Theramore",
	["The next guide starts in Theramore."] = "Der nächste Guide beginnt in Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Die Dämonen sammeln sich am {area:602} im Süden von {zone:1443}: Höllenhunde (Mana Eaters, Mage und Ley Hunters), Nether Maidens und Sisters sowie Doomwarder Captains rund um die Grube.\nVorsicht: Die meisten Mobs hier laufen Patrouillenrouten, sodass du leicht zusätzliche Mobs ziehst.",
	-- ["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "Untote Verwüster streifen über die Knochenfelder südlich des Dorfes der Magram, östlich des Zirkels: Der Pfeil führt zu ihrem Westrand. Benutze dann {item:15848} an seinem Pfeil, auf der Ostseite der Felder, um die Magrami-Gespenster anzulocken. Vorsicht: Nekrokhane und Leichenfresser der Magram (45, Elite) laufen mit Nekromanten der Magram (42) über die Knochenfelder zwischen den beiden Pfeilen: Zieh die Verwüster und die Gespenster zu dir, weg von ihnen.",
	-- ["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} liegt neben {object:35251}. Sein silberner Schlüssel wird von den Trockenschnappkrebsen rund um das Wrack fallen gelassen; der goldene stammt von den Naga der Schlitterklingen an der Nordwestküste, als Nächstes.",
}
