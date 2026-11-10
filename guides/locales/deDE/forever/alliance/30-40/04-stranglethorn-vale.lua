-- German (deDE): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 3: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Nimm vom {zone:1431} die Straße nach Süden ins Schlingendorntal; die Zelte der Jäger stehen gleich westlich der Straße hinter der Abzweigung zum {area:99}.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, aus {zone:1441}",

	-- Step 4: Young tigers and panthers
	["Young tigers and panthers"] = "Junge Tiger und Panther",
	["Both roam the grass around the camp and along the road north."] = "Beide streifen durch das Gras um das Lager und entlang der Straße nach Norden.",

	-- Step 8: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Schlingendorntiger",
	["The adult tigers prowl the hills just south and west of the camp."] = "Die ausgewachsenen Tiger streifen durch die Hügel gleich südlich und westlich des Lagers.",

	-- Step 9: Level 33.2
	["Level 33.2"] = "",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["The jungle's quests climb to 37 from here: short of 33.2? Keep on the Stranglethorn Tigers in the hills just south and west of the camp until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "",
	-- {npc:682} Stranglethorn Tiger
	["grind on {npc:682}"] = "",

	-- Step 10: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Die Alten Schlingendorntiger kommen später, auf dem Rückweg vom {area:99}",

	-- Step 11: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Panther, Raptoren und Alte Tiger",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "Zurück nach Süden an Nesingwary vorbei: Panther und Schlingendornraptoren laufen auf den Lichtungen westlich des Lagers Richtung Küste; die Alten Schlingendorntiger halten die Hügel im Südwesten.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Gluckser, ein seltener Murloc an der Küste westlich des Lagers, lässt den {item:4614} fallen: Nimm ihn mit, falls du ihm begegnest",

	-- Step 12: Sir S. J. Erlgadin
	-- {area:99} Rebel Camp
	["Back east to Nesingwary's camp on the way north to the {area:99}."] = "",

	-- Step 13: Rebel Camp
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["Take the road north; the camp sits in the hills to the west.\n{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, in der Hütte",
	-- {npc:469} Lieutenant Doren · {quest:200} Bookie Herod · {area:101} Kurzen's Compound
	["{npc:469}: {quest:200}'s records lie at the edge of {area:101}, next"] = "",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}, later in this guide"] = "",

	-- Step 14: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "",
	-- {area:99} Rebel Camp · {quest:200} Bookie Herod
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents. {quest:200}'s records lie in a hut on the compound's west side."] = "",
	-- {object:287} Bookie Herod's Records
	["{object:287}, in the hut"] = "",
	["The strongbox is deeper in, by the cave: on the northern loop (04b)"] = "",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, aus einer Kiste von {object:263}",

	-- Step 15: Level 33.6
	["Level 33.6"] = "",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Kurzen Jungle Fighters = {npc:937} Kurzen Jungle Fighter
	["Short of 33.6? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.6. Or, with a group, run the {area:796} dungeon (Library) instead."] = "",
	-- {npc:937} Kurzen Jungle Fighter
	["grind on {npc:937}"] = "",

	-- Step 17: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 18: Level 34
	["Level 34"] = "",
	-- {area:796} Scarlet Monastery
	["The quests from here on are 37: if you are short of 34, keep on the elder tigers in the hills south-west of Nesingwary's camp until level 34. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "",
	-- {npc:1085} Elder Stranglethorn Tiger
	["grind on {npc:1085}"] = "",

	-- Step 19: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} sammelt die {item:2755}: Die Seiten lässt fast jeder Humanoide im Dschungel fallen. Füg die Seiten unterwegs zu Kapiteln zusammen.",

	-- Step 20: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729} und die Schmetterschwänze",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, der große Tiger, haust auf der Hügelkuppe südwestlich des Lagers; Schmetterschwänze laufen südlich davon, auf dem Weg nach {area:35}.",

	-- Step 21: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "Hinab nach {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Folge der Hauptstraße durch den ganzen Dschungel nach Süden, vorbei an der Abzweigung nach {object:3202}, bis {area:35} am Südkap.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern
	["{npc:6807}, {object:56910}; upstairs"] = "",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}; upstairs"] = "",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern; upstairs"] = "",
	-- {npc:773} Krazek · {npc:770} Corporal Kaleb
	["{npc:773}, from {npc:770}"] = "",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, in der Taverne",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals, on the northern loop"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, oben in der Taverne",

	-- Step 22: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 24: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "",
	-- {area:108} Sentinel Hill · {zone:1436} Westfall · {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach it. The Bloodscalp trolls hold the ruins on the coast to the north."] = "",
	["The haunted island"] = "Die Spukinsel",

	-- Step 25: River crocolisks
	["River crocolisks"] = "Flusskrokilisken",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "Flusskrokilisken schwimmen im Fluss beim {area:99}.",

	-- Step 26: Private Thorsen
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",

	-- Step 27: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: Sieh dich einfach im Lager der Jäger um",

	-- Step 28: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "",
	-- {npc:2495} Drizzlik
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{npc:2495}: the Snapjaw Crocolisks, on the northern loop"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}: the water elementals rise around the haunted island, on the northern loop"] = "",

	-- Step 29: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Flieg nach {zone:1453}",

	-- Step 31: Collin Mauren
	-- {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:4078} is in the {object:2164}, in the {object:2101}."] = "",

	-- Step 32: Druid training
	["Druid training"] = "Druidentraining",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{npc:5504}, the druid trainer, stands in {zone:1453}, north-west of the {object:2101}."] = "",

	-- Step 34: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 35: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then take the road west to Stonetalon."] = "",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, nördlich von {area:413}",

	-- Step 36: Stonetalon Mountains
	-- {area:608} Nijel's Point
	["The road to {area:608}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodscalp trolls"] = "Bloodscalp-Trolle",
	-- ["Fly from {area:150} to {area:1537} and train."] = "Flieg von {area:150} nach {area:1537} und trainiere.",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Flieg nach {area:42}: {npc:1573} im {object:32372} von {area:1537} oder {npc:352} im {object:2096} von {zone:1453}.",
	-- ["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Folge der Westküste nach Norden; die Spukinsel liegt vor der Küste westlich von Nesingwarys Lager. Erreiche sie einfach.",
	-- ["For Archmage Ansirem in {zone:1416}"] = "Für Erzmagier Ansirem im {zone:1416}",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Kurzens Kopfschrumpfer stehen tiefer im Lager; Kurzens Kommandosoldaten lauern getarnt darum herum und in der Höhle. Heb Seiten der Grünen Hügel auf, wenn sie fallen.",
	-- ["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Herods Aufzeichnungen liegen in einer Hütte auf der Westseite des Lagers; seine Geldkassette steht weiter östlich beim Höhleneingang.",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Zieh eine Runde durch die Trollruinen im Norden und in der Mitte: Jede birgt eine Steintafel der Trolllegenden. Schattentatzenpanther schleichen getarnt im Dschungel darum herum; das Lager der Venture Co. auf {area:37} trägt die Gerommelten Kristalle.",
	-- ["Skullsplitter trolls"] = "Skullsplitter-Trolle",
	-- ["Snapjaw Crocolisks"] = "Schnappkieferkrokilisken",
	-- ["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Schnappkieferkrokilisken sonnen sich an Ufer und Inseln entlang der Küste nördlich von {area:35}.",
	-- ["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Nimm die Straße nach Norden; {npc:738} patrouilliert darauf, das Lager liegt in den Hügeln im Westen.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Nimm die Straße nach Norden; {npc:738} steht darauf, das Lager liegt in den Hügeln im Westen.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Die Bloodscalp-Trolle halten die Ruinen an der Küste westlich von Nesingwarys Lager.",
	-- ["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Die Rebellen von Kurzen halten das Lager östlich des {area:99}; arbeite dich am Außenrand entlang, wo Kurzens Dschungelkämpfer und Medizinmänner stehen, und plündere die Vorratskisten bei den Zelten.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Die Skullsplitter-Trolle halten die Ruinen östlich der Straße zwischen Nesingwary und {object:3202}.",
	-- ["The jungle ruins"] = "Die Dschungelruinen",
	-- ["The ore drops from Drywhisker kobolds in {zone:1417}"] = "Das Erz lassen Kobolde der Trockenstoppel im {zone:1417} fallen",
	-- ["Thorsen patrols the road north of camp, toward the {area:99}."] = "Thorsen patrouilliert auf der Straße nördlich des Lagers, Richtung {area:99}.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Geh zurück nach Norden; die {area:310} liegt westlich der Straße mitten im Dschungel. Die Kristallrückenbasilisken dort lassen die Splitter fallen.",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} hat keinen Druidenlehrer: Nimm die {area:2257} von {object:171524} nach {zone:1453} und trainiere bei {npc:5504}.",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}, bei der Bank",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, in der {object:56910}",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}, im obersten Stockwerk bei den Docks",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: für {npc:773} in {area:35}",
	-- ["{npc:773}, in the tavern"] = "{npc:773}, in der Taverne",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: vier Trolllegenden",
}
