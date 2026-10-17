-- German (deDE): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ironforge
	-- {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:150} to {area:1537} and train."] = "Flieg von {area:150} nach {area:1537} und trainiere.",

	-- Step 2: Druid training
	["Druid training"] = "Druidentraining",
	-- {area:1537} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} hat keinen Druidenlehrer: Nimm die {area:2257} von {object:171524} nach {zone:1453} und trainiere bei {npc:5504}.",

	-- Step 3: Darkshire
	-- {area:42} Darkshire · {npc:1573} Gryth Thurden · {area:1537} Ironforge · {object:32372} Great Forge (no name in this language: may be words) · {npc:352} Dungar Longdrink · {zone:1453} Stormwind · {object:2096} Trade District
	["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Flieg nach {area:42}: {npc:1573} im {object:32372} von {area:1537} oder {npc:352} im {object:2096} von {zone:1453}.",

	-- Step 4: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Nimm vom {zone:1431} die Straße nach Süden ins Schlingendorntal; die Zelte der Jäger stehen gleich westlich der Straße hinter der Abzweigung zum {area:99}.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, aus {zone:1441}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "Junge Tiger und Panther",
	["Both roam the grass around the camp and along the road north."] = "Beide streifen durch das Gras um das Lager und entlang der Straße nach Norden.",

	-- Step 7: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Schlingendorntiger",
	["The adult tigers prowl the hills just south and west of the camp."] = "Die ausgewachsenen Tiger streifen durch die Hügel gleich südlich und westlich des Lagers.",

	-- Step 8: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Die Alten Schlingendorntiger kommen später, auf dem Rückweg vom {area:99}",

	-- Step 9: Rebel Camp
	-- {npc:738} Private Thorsen
	["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Nimm die Straße nach Norden; {npc:738} steht darauf, das Lager liegt in den Hügeln im Westen.",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, in der Hütte",

	-- Step 10: Kurzen's Compound
	-- {area:99} Rebel Camp
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Die Rebellen von Kurzen halten das Lager östlich des {area:99}; arbeite dich am Außenrand entlang, wo Kurzens Dschungelkämpfer und Medizinmänner stehen, und plündere die Vorratskisten bei den Zelten.",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, aus einer Kiste von {object:263}",

	-- Step 11: Bookie Herod
	["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Herods Aufzeichnungen liegen in einer Hütte auf der Westseite des Lagers; seine Geldkassette steht weiter östlich beim Höhleneingang.",

	-- Step 13: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Panther, Raptoren und Alte Tiger",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "Zurück nach Süden an Nesingwary vorbei: Panther und Schlingendornraptoren laufen auf den Lichtungen westlich des Lagers Richtung Küste; die Alten Schlingendorntiger halten die Hügel im Südwesten.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Gluckser, ein seltener Murloc an der Küste westlich des Lagers, lässt den {item:4614} fallen: Nimm ihn mit, falls du ihm begegnest",

	-- Step 15: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729} und die Schmetterschwänze",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, der große Tiger, haust auf der Hügelkuppe südwestlich des Lagers; Schmetterschwänze laufen südlich davon, auf dem Weg nach {area:35}.",

	-- Step 16: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "Hinab nach {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Folge der Hauptstraße durch den ganzen Dschungel nach Süden, vorbei an der Abzweigung nach {object:3202}, bis {area:35} am Südkap.",
	["Gyll, on the top floor by the docks"] = "Gyll, im obersten Stockwerk bei den Docks",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}"] = "{npc:2832}, in der {object:56910}",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank"] = "{npc:2495}, bei der Bank",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern"] = "{npc:773}, in der Taverne",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, in der Taverne",

	-- Step 17: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Geh zurück nach Norden; die {area:310} liegt westlich der Straße mitten im Dschungel. Die Kristallrückenbasilisken dort lassen die Splitter fallen.",

	-- Step 18: Bloodscalp trolls
	["Bloodscalp trolls"] = "Bloodscalp-Trolle",
	["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Die Bloodscalp-Trolle halten die Ruinen an der Küste westlich von Nesingwarys Lager.",

	-- Step 19: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: Sieh dich einfach im Lager der Jäger um",

	-- Step 20: Private Thorsen
	-- {area:99} Rebel Camp
	["Thorsen patrols the road north of camp, toward the {area:99}."] = "Thorsen patrouilliert auf der Straße nördlich des Lagers, Richtung {area:99}.",

	-- Step 21: River crocolisks
	["River crocolisks"] = "Flusskrokilisken",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "Flusskrokilisken schwimmen im Fluss beim {area:99}.",

	-- Step 23: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Schnappkieferkrokilisken",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Schnappkieferkrokilisken sonnen sich an Ufer und Inseln entlang der Küste nördlich von {area:35}.",

	-- Step 24: Booty Bay
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, oben in der Taverne",

	-- Step 25: The haunted island
	["The haunted island"] = "Die Spukinsel",
	["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Folge der Westküste nach Norden; die Spukinsel liegt vor der Küste westlich von Nesingwarys Lager. Erreiche sie einfach.",

	-- Step 26: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} sammelt die {item:2755}: Die Seiten lässt fast jeder Humanoide im Dschungel fallen. Füg die Seiten unterwegs zu Kapiteln zusammen.",

	-- Step 28: Kurzen's Compound
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Kurzens Kopfschrumpfer stehen tiefer im Lager; Kurzens Kommandosoldaten lauern getarnt darum herum und in der Höhle. Heb Seiten der Grünen Hügel auf, wenn sie fallen.",

	-- Step 29: The jungle ruins
	["The jungle ruins"] = "Die Dschungelruinen",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Zieh eine Runde durch die Trollruinen im Norden und in der Mitte: Jede birgt eine Steintafel der Trolllegenden. Schattentatzenpanther schleichen getarnt im Dschungel darum herum; das Lager der Venture Co. auf {area:37} trägt die Gerommelten Kristalle.",
	-- {quest:207} Kurzen's Mystery
	["{quest:207}: four troll legends"] = "{quest:207}: vier Trolllegenden",

	-- Step 30: Rebel Camp
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: für {npc:773} in {area:35}",

	-- Step 32: Skullsplitter trolls
	["Skullsplitter trolls"] = "Skullsplitter-Trolle",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Die Skullsplitter-Trolle halten die Ruinen östlich der Straße zwischen Nesingwary und {object:3202}.",

	-- Step 34: Booty Bay
	-- {zone:1417} Arathi Highlands
	["The ore drops from Drywhisker kobolds in {zone:1417}"] = "Das Erz lassen Kobolde der Trockenstoppel im {zone:1417} fallen",

	-- Step 36: Baron Revilgaz
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Für Erzmagier Ansirem im {zone:1416}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, im {object:56910}",
}
