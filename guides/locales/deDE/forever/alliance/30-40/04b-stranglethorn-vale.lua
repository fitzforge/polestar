-- German (deDE): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 35 to 36, but several quests here are level 37-38: on purpose, for their experience. The water elementals are 36-37: pull them one at a time."] = "Für Charaktere der Stufe 35 bis 36, aber mehrere Quests hier sind Stufe 37-38: mit Absicht, wegen ihrer Erfahrung. Die Wasserelementare sind 36-37: Zieh sie einzeln.",

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
	["{npc:770}, if 30-40/04 didn't give it: for {npc:773} in {area:35}"] = "{npc:770}, falls 30-40/04 sie dir nicht gegeben hat: für {npc:773} in {area:35}",

	-- Step 5: Nesingwary's Expedition
	-- {npc:717} Ajeck Rouack
	["South along the road: the hunters' tents stand just west of it. {npc:717} and Hemet gave you these on the first loop: take them now only if you didn't."] = "Nach Süden entlang der Straße: Die Zelte der Jäger stehen gleich westlich davon. {npc:717} und Hemet haben dir diese in der ersten Runde gegeben: Nimm sie jetzt nur an, falls nicht.",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}. Keep it for the later visit if you skip {npc:729} on the raptor hill."] = "",
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:715}, if 30-40/04 didn't give it: the Lashtail Raptors, after the jungle ruins"] = "{npc:715}, falls 30-40/04 sie dir nicht gegeben hat: die Schmetterschwänze, nach den Dschungelruinen",

	-- Step 6: Bookie Herod
	-- {area:101} Kurzen's Compound
	["East to {area:101}: Herod's records lie in a hut on its west side."] = "Nach Osten zu {area:101}: Herods Aufzeichnungen liegen in einer Hütte auf der Westseite.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "{object:287}, oben",

	-- Step 7: Kurzen's Compound
	-- {npc:218230} Wendel Mathers · {spell:7964} Smoke Bomb · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["{npc:218230}, a cook, is caged at the compound's western edge: take his quest now and keep it, his cage key and the fighter's uniform come on the 40-50 Stranglethorn guide, when the Subchiefs and Elites are your level. Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}. {npc:813}, an elite of 39-40, stands at the compound's north end: leave him be."] = "{npc:218230}, ein Koch, sitzt am Westrand des Komplexes in einem Käfig: Nimm seine Quest jetzt an und behalte sie. Sein Käfigschlüssel und die Kämpferuniform kommen im Schlingendorn-Guide für 40-50, wenn die Unterhäuptlinge und Elites deine Stufe haben. Kopfschrumpfer stehen tiefer im Komplex; die Kommandosoldaten lauern getarnt rundherum und in der Höhle, und Herods Geldkassette liegt am Höhleneingang. Sammle Green-Hills-Seiten ein, wenn sie fallen.\nVorsicht: Kurzens Kommandosoldaten sind Stufe 34-35, keine Elites, und spawnen oft getarnt; kurz vor dem Tod benutzen sie {spell:7964}. {npc:813}, ein Elite der Stufe 39-40, steht am Nordende des Komplexes: Lass ihn in Ruhe.",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage"] = "{npc:218230}, in seinem Käfig",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}, unter der Erde",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "{object:288}, unter der Erde",

	-- Step 8: The jungle ruins
	["The jungle ruins"] = "Die Dschungelruinen",
	["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west.\nCareful: the Saltscale murlocs on the shore near the second tablet are elite (35-37): swim to the tablet from the water and keep clear of them."] = "Nach Westen durch den Dschungel zu den Trollruinen: Jede birgt eine Steintafel der Trolllegenden, die ersten beiden in den Ruinen südwestlich von Nesingwarys Lager, die letzten beiden auf dem Hügel im Nordwesten.\nVorsicht: Die Saltscale-Murlocs am Ufer nahe der zweiten Tafel sind Elites (35-37): Schwimm vom Wasser aus zur Tafel und halte Abstand zu ihnen.",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "{item:2006}: {object:58}; unter Wasser",

	-- Step 9: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["The haunted island lies just off the shore west of the second tablet: the Lesser Water Elementals rise from the water around it."] = "Die Spukinsel liegt direkt vor der Küste westlich der zweiten Tafel: Die Geringen Wasserelementare steigen aus dem Wasser um sie herum.",

	-- Step 10: The Ruins of Zul'Kunda
	-- {area:102} Ruins of Zul'Kunda
	["The {area:102}"] = "Die {area:102}",
	-- {npc:268992} Zimmix Sputterspark · {item:277957} Primitive Key
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["North along the coast to the ruins on the hill: the last two tablets lie there. {npc:268992}, a goblin, is caged beside the third tablet: any Bloodscalp can drop his {item:277957}, then lead him out of the ruins. The Stolen Shipments lie at the ruins' east edge. Pick up Green Hills pages as they drop.\nCareful: the Bloodscalp Berserkers, Headhunters and Witch Doctors (36-37) hold the ruins' core: pull them one at a time."] = "Nach Norden die Küste entlang zu den Ruinen auf dem Hügel: Dort liegen die letzten beiden Tafeln. {npc:268992}, ein Goblin, sitzt neben der dritten Tafel in einem Käfig: Jeder Bloodscalp kann seinen {item:277957} fallen lassen; führ ihn dann aus den Ruinen. Die Gestohlenen Lieferungen liegen am Ostrand der Ruinen. Sammle Green-Hills-Seiten ein, wenn sie fallen.\nVorsicht: Die Berserker, Kopfjäger und Hexendoktoren der Bloodscalp (36-37) halten das Zentrum der Ruinen: Pull sie einzeln.",
	-- {npc:268992} Zimmix Sputterspark
	["{npc:268992}, in his cage beside the third tablet"] = "{npc:268992}, in seinem Käfig neben der dritten Tafel",
	-- {item:277957} Primitive Key
	["{item:277957}, from the Bloodscalp trolls"] = "{item:277957}, von den Blutskalptrollen",
	-- {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["For {npc:4631} in {area:35}, at the end of this loop"] = "Für {npc:4631} in {area:35}, am Ende dieser Runde",

	-- Step 11: Sin'Dall on the raptor hill
	-- {npc:729} Sin'Dall
	["{npc:729} on the raptor hill"] = "",
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["Check the hilltop on your way to the raptors. If {npc:729} isn't here or you can't pull her alone, keep moving; {npc:717} can take the paw on the later visit."] = "",
	-- {npc:729} Sin'Dall
	["{npc:729}'s hill"] = "",
	-- {npc:729} Sin'Dall
	["{npc:729} (37) prowls the hilltop."] = "",

	-- Step 12: The Lashtail raptors
	["The Lashtail raptors"] = "Die Schmetterschwanzraptoren",
	-- {quest:187} Tiger Mastery · {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["East from the ruins, hunt Lashtail Raptors around the hill south-west of Nesingwary's camp. If you have {quest:187}, are at least 36 and see {npc:729} (37) alone, you can take her paw here or leave the hunt for your next visit."] = "",

	-- Step 13: Ajeck Rouack
	-- {npc:717} Ajeck Rouack
	["Hand the paw to {npc:717} beside Hemet."] = "",

	-- Step 14: Nesingwary's Expedition
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["{npc:715}: the Jungle Stalkers come in 40-50"] = "{npc:715}: Die Dschungelpirscher kommen in 40-50",

	-- Step 15: Rebel Camp
	-- {area:99} Rebel Camp
	["North-east up the road to the {area:99}, then back south through the jungle."] = "Nach Nordosten die Straße hinauf zum {area:99}, dann zurück nach Süden durch den Dschungel.",
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "{npc:733}: Die Commandos und Headshrinkers im Komplex erledigen",
	-- plural, as words: Skullsplitter Witch Doctors = {npc:670} Skullsplitter Witch Doctor
	["keep it: the Skullsplitter Witch Doctors (41-42) wait for the 40-50 Stranglethorn guide"] = "behalten: Die Hexendoktoren der Skullsplitter (41-42) warten auf den Schlingendorntal-Guide 40-50",

	-- Step 16: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Schnappkieferkrokilisken",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to {area:35}."] = "Schnappkieferkrokilisken sonnen sich am Fluss mitten im Dschungel, auf dem Weg nach Süden nach {area:35}.",

	-- Step 17: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, drinnen",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, oben in der Taverne",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Für Erzmagier Ansirem im {zone:1416}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, oben",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, oben",
	-- {npc:773} Krazek · {item:4278} Lesser Bloodstone Ore · {zone:1417} Arathi Highlands · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["{npc:773}, upstairs: this optional quest needs four {item:4278}. Mine Lesser Bloodstone Deposits in {zone:1417} with {skill:186} 75, or buy the ore at the Auction House or ask a miner friend. The kobolds do not drop it; skip this quest if you cannot get the ore."] = "{npc:773}, oben: Diese optionale Quest braucht vier {item:4278}. Bau Geringe Blutsteinablagerungen in {zone:1417} mit {skill:186} 75 ab, kauf das Erz im Auktionshaus oder frag einen befreundeten Bergarbeiter. Die Kobolde lassen es nicht fallen; überspring diese Quest, wenn du nicht an das Erz kommst.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, drinnen",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "„Sea Wolf“ MacKinley, im obersten Stockwerk",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks"] = "{npc:4631}, an den Docks",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East from the ruins to the hilltop south-west of Nesingwary's camp: the Lashtail Raptors run in the jungle around it. Leave {npc:729}, the great tiger (37) on the hilltop, to the 40-50 Stranglethorn guide: you're about 35 here. Then on to the hunters' tents."] = "Von den Ruinen nach Osten zur Hügelkuppe südwestlich von Nesingwarys Lager: Die Schmetterschwänze laufen im Dschungel drumherum. Überlass {npc:729}, den großen Tiger (37) auf der Hügelkuppe, dem Schlingendorntal-Guide 40-50: Du bist hier etwa 35. Dann weiter zu den Zelten der Jäger.",
	-- ["East to the {area:99}, on the way back to Nesingwary's camp."] = "Nach Osten zum {area:99}, auf dem Rückweg zu Nesingwarys Lager.",
	-- ["For characters of 35 to 36, but several quests here are level 37-41: on purpose, for their experience. {quest:205}'s Skullsplitter trolls are 39-42, so pull them one at a time."] = "Für Charaktere der Stufe 35 bis 36, aber mehrere Quests hier sind Stufe 37-41: mit Absicht, wegen ihrer Erfahrung. Die Trolle der Skullsplitter für {quest:205} sind 39-42, also zieh sie einzeln.",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "Headshrinkers stehen tiefer im Komplex; die Commandos lauern getarnt rundherum und in der Höhle, und Herods Geldkassette liegt am Höhleneingang. Sammle Green-Hills-Seiten ein, wenn sie fallen.\nVorsicht: Kurzen Commandos sind Stufe 34-35, keine Elites, und spawnen oft getarnt; kurz vor dem Tod benutzen sie {spell:7964}.",
	-- ["Level 36"] = "Stufe 36",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Zieh eine Runde durch die Trollruinen im Norden und in der Mitte: Jede birgt eine Steintafel der Trolllegenden. Schattentatzenpanther schleichen getarnt im Dschungel darum herum; das Lager der Venture Co. auf {area:37} trägt die Gerommelten Kristalle.",
	-- ["North along the coast to the ruins on the hill: the last two tablets lie there. Pick up Green Hills pages as they drop."] = "Nach Norden die Küste entlang zu den Ruinen auf dem Hügel: Dort liegen die letzten beiden Tafeln. Sammle Seiten aus dem Grüne-Hügel-Almanach ein, wenn sie fallen.",
	-- ["Skullsplitter trolls"] = "Skullsplitter-Trolle",
	-- ["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to the Skullsplitter ruins."] = "Snapjaw Crocolisks sonnen sich am Fluss mitten im Dschungel, auf dem Weg nach Süden zu den Ruinen der Skullsplitter.",
	-- ["South along the road: the hunters' tents stand just west of it."] = "Südlich entlang der Straße: Die Zelte der Jäger stehen direkt westlich davon.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals, and the Shadowmaw Panthers prowl stealthed in the jungle south and east of it."] = "Vom Lager nach Süden zum {area:37}: Die Geologen der Venture Co. in den Lagern an seinem Ufer tragen die Gerommelten Kristalle, und die Schattentatzenpanther schleichen getarnt im Dschungel südlich und östlich davon.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals. Careful: Venture Co. Agents (39) walk among them: take the Geologists on the camps' edges, one at a time. Shadowmaw Panthers (37-38) prowl stealthed in the jungle south and east of the lake: keep to the shore camps."] = "Vom Komplex nach Süden zum {area:37}: Die Geologen der Venture Co. in den Lagern an seinem Ufer tragen die Gerommelten Kristalle. Vorsicht: Agenten der Venture Co. (39) laufen zwischen ihnen herum: Nimm dir die Geologen am Rand der Lager einzeln vor. Schattentatzenpanther (37-38) schleichen getarnt im Dschungel südlich und östlich des Sees: Bleib bei den Lagern am Ufer.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Die Skullsplitter-Trolle halten die Ruinen östlich der Straße zwischen Nesingwary und {object:3202}.",
	-- ["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west."] = "Nach Westen durch den Dschungel zu den Trollruinen: Jede birgt eine Steintafel der Trolllegenden, die ersten beiden in den Ruinen südwestlich von Nesingwarys Lager, die letzten beiden auf dem Hügel im Nordwesten.",
	-- ["grind on {npc:1152}"] = "Grinde an {npc:1152}",
	-- ["{npc:717}, if 30-40/04 didn't give it: {npc:729}, in the 40-50 Stranglethorn guide"] = "{npc:717}, falls 30-40/04 sie dir nicht gegeben hat: {npc:729}, im Schlingendorn-Guide für 40-50",
	-- ["{npc:718}: the Shadowmaw Panthers prowl around {area:37}, after {area:101}"] = "{npc:718}: Die Schattentatzenpanther streifen um {area:37} umher, nach {area:101}",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: für {npc:773} in {area:35}",
	-- ["{quest:205}'s Skullsplitter trolls are 39-42. Below 36? Keep killing the Snapjaw Crocolisks along the river until level 36. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "Die Skullsplitter-Trolle von {quest:205} sind 39-42. Unter 36? Töte weiter die Snapjaw Crocolisks am Fluss, bis du Stufe 36 hast. Oder lauf mit einer Gruppe stattdessen den Dungeon {area:796} (Waffenkammer) oder den Dungeon {area:1316}.",
}
