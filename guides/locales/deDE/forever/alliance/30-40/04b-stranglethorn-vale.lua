-- German (deDE): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:205} Troll Witchery
	["For characters of 35 to 36, but several quests here are level 37-41: on purpose, for their experience. {quest:205}'s Skullsplitter trolls are 39-42, so pull them one at a time."] = "Für Charaktere der Stufe 35 bis 36, aber mehrere Quests hier sind Stufe 37-41: mit Absicht, wegen ihrer Erfahrung. Die Trolle der Skullsplitter für {quest:205} sind 39-42, also zieh sie einzeln.",

	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "Im {object:2164}, falls du es noch bei dir hast",

	-- Step 2: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",

	-- Step 3: Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Into {zone:1434}"] = "Hinein nach {zone:1434}",

	-- Step 4: Rebel Camp
	-- {zone:1431} Duskwood
	["From {zone:1431} take the road south; the camp sits in the hills west of the road."] = "Nimm von {zone:1431} die Straße nach Süden; das Lager liegt in den Hügeln westlich der Straße.",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: für {npc:773} in {area:35}",

	-- Step 5: Nesingwary's Expedition
	["South along the road: the hunters' tents stand just west of it."] = "Südlich entlang der Straße: Die Zelte der Jäger stehen direkt westlich davon.",
	-- {npc:718} Sir S. J. Erlgadin · {area:37} Lake Nazferiti · {area:101} Kurzen's Compound
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["{npc:718}: the Shadowmaw Panthers prowl around {area:37}, after {area:101}"] = "{npc:718}: Die Schattentatzenpanther streifen um {area:37} umher, nach {area:101}",

	-- Step 6: Bookie Herod
	-- {area:101} Kurzen's Compound
	["East to {area:101}: Herod's records lie in a hut on its west side."] = "Nach Osten zu {area:101}: Herods Aufzeichnungen liegen in einer Hütte auf der Westseite.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "{object:287}, oben",

	-- Step 7: Kurzen's Compound
	-- {spell:7964} Smoke Bomb
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}, unter der Erde",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "{object:288}, unter der Erde",

	-- Step 8: Lake Nazferiti
	-- {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals, and the Shadowmaw Panthers prowl stealthed in the jungle south and east of it."] = "Vom Lager nach Süden zum {area:37}: Die Geologen der Venture Co. in den Lagern an seinem Ufer tragen die Gerommelten Kristalle, und die Schattentatzenpanther schleichen getarnt im Dschungel südlich und östlich davon.",

	-- Step 9: The jungle ruins
	["The jungle ruins"] = "Die Dschungelruinen",
	["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west."] = "Nach Westen durch den Dschungel zu den Trollruinen: Jede birgt eine Steintafel der Trolllegenden, die ersten beiden in den Ruinen südwestlich von Nesingwarys Lager, die letzten beiden auf dem Hügel im Nordwesten.",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "{item:2006}: {object:58}; unter Wasser",

	-- Step 10: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["The haunted island lies just off the shore west of the second tablet: the Lesser Water Elementals rise from the water around it."] = "Die Spukinsel liegt direkt vor der Küste westlich der zweiten Tafel: Die Geringen Wasserelementare steigen aus dem Wasser um sie herum.",

	-- Step 11: The Ruins of Zul'Kunda
	-- {area:102} Ruins of Zul'Kunda
	["The {area:102}"] = "Die {area:102}",
	["North along the coast to the ruins on the hill: the last two tablets lie there. Pick up Green Hills pages as they drop."] = "Nach Norden die Küste entlang zu den Ruinen auf dem Hügel: Dort liegen die letzten beiden Tafeln. Sammle Seiten aus dem Grüne-Hügel-Almanach ein, wenn sie fallen.",

	-- Step 12: Rebel Camp
	-- {area:99} Rebel Camp
	["East to the {area:99}, on the way back to Nesingwary's camp."] = "Nach Osten zum {area:99}, auf dem Rückweg zu Nesingwarys Lager.",
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "{npc:733}: Die Commandos und Headshrinkers im Komplex erledigen",

	-- Step 15: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Schnappkieferkrokilisken",
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to the Skullsplitter ruins."] = "Snapjaw Crocolisks sonnen sich am Fluss mitten im Dschungel, auf dem Weg nach Süden zu den Ruinen der Skullsplitter.",

	-- Step 16: Level 36
	["Level 36"] = "Stufe 36",
	-- {quest:205} Troll Witchery · {area:796} Scarlet Monastery · {area:1316} Razorfen Downs
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{quest:205}'s Skullsplitter trolls are 39-42. Below 36? Keep killing the Snapjaw Crocolisks along the river until level 36. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "Die Skullsplitter-Trolle von {quest:205} sind 39-42. Unter 36? Töte weiter die Snapjaw Crocolisks am Fluss, bis du Stufe 36 hast. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:796} (Waffenkammer) oder den Dungeon {area:1316}.",
	-- {npc:1152} Snapjaw Crocolisk
	["grind on {npc:1152}"] = "Grinde an {npc:1152}",

	-- Step 17: Skullsplitter trolls
	["Skullsplitter trolls"] = "Skullsplitter-Trolle",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Die Skullsplitter-Trolle halten die Ruinen östlich der Straße zwischen Nesingwary und {object:3202}.",

	-- Step 18: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, drinnen",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, oben in der Taverne",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Für Erzmagier Ansirem im {zone:1416}",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, oben",
	-- {npc:773} Krazek · {item:4278} Lesser Bloodstone Ore · {zone:1417} Arathi Highlands · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["{npc:773}, upstairs: this optional quest needs four {item:4278}. Mine Lesser Bloodstone Deposits in {zone:1417} with {skill:186} 75, or buy the ore at the Auction House or ask a miner friend. The kobolds do not drop it; skip this quest if you cannot get the ore."] = "{npc:773}, oben: Diese optionale Quest braucht vier {item:4278}. Bau Geringe Blutsteinablagerungen in {zone:1417} mit {skill:186} 75 ab, kauf das Erz im Auktionshaus oder frag einen befreundeten Bergarbeiter. Die Kobolde lassen es nicht fallen; überspring diese Quest, wenn du nicht an das Erz kommst.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, drinnen",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "„Sea Wolf“ MacKinley, im obersten Stockwerk",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use Smoke Bomb."] = "Headshrinkers stehen tiefer im Komplex; die Commandos lauern getarnt rundherum und in der Höhle, und Herods Geldkassette liegt am Höhleneingang. Sammle Green-Hills-Seiten ein, wenn sie fallen.\nVorsicht: Kurzen Commandos sind Stufe 34-35, keine Elites, und spawnen oft getarnt; kurz vor dem Tod benutzen sie Rauchbombe.",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Zieh eine Runde durch die Trollruinen im Norden und in der Mitte: Jede birgt eine Steintafel der Trolllegenden. Schattentatzenpanther schleichen getarnt im Dschungel darum herum; das Lager der Venture Co. auf {area:37} trägt die Gerommelten Kristalle.",
}
