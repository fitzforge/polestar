-- German (deDE): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 2: Red Jack Flint
	-- {npc:4455} Red Jack Flint
	["{npc:4455} stands on the dock just north of the flight master."] = "",
	-- {quest:1132} Fiora Longears
	["For {quest:1132} on Theramore's docks, where this guide's boat lands"] = "",

	-- Step 3: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} steht im oberen Stockwerk der Burg von Menethil.",
	["Inside"] = "",

	-- Step 4: Deepwater Tavern
	-- {quest:1248} The Missing Diplomat · {npc:4963} Mikhail
	["Tapoke Jahn (34) slips out of the tavern once you take {quest:1248}: stay close behind him. He turns on you outside, a friend joins him, and he gives up once badly hurt. If you lose him the quest fails: abandon it and take it again from {npc:4963}."] = "",

	-- Step 5: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Das Wrack der Flying Osprey liegt im seichten Wasser südlich der Burg.",

	-- Step 6: Lightforge Ingots
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Die Murlocs der Blaukiemen am Strand südwestlich von Menethil tragen die Blöcke.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "",

	-- Step 7: Glorin Steelbrow
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["For {npc:1416} in {zone:1453}, after Stranglethorn"] = "",

	-- Step 9: Theramore
	["Theramore"] = "Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Der Flugmeister steht am Tor von {area:514}; {npc:5083} und {npc:4964} sind in der Zitadelle.",
	-- {npc:5083} Clerk Lendry
	["{npc:5083}, on the top floor"] = "",
	-- {npc:4964} Commander Samaul
	["{npc:4964}, on the top floor"] = "",
	-- {quest:1132} Fiora Longears
	["{quest:1132}, on the docks"] = "",
	-- {npc:4456} Fiora Longears · {area:415} Astranaar
	["{npc:4456}'s next errand goes to {area:415}, off this route: leave it."] = "",
	-- {quest:1132} Fiora Longears · {zone:1441} Thousand Needles
	["{quest:1132}: the wyverns are in {zone:1441}, later in this guide"] = "",

	-- Step 10: The Shady Rest Inn
	-- {zone:1413} Barrens
	["Follow the road west out of Theramore to the burned inn on the road toward the {zone:1413}: the black shield lies in the ashes and the hoofprints are in the mud beside the inn."] = "",

	-- Step 11: Into Barrens
	-- {zone:1413} Barrens
	["Into {zone:1413}"] = "",

	-- Step 12: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "Auf der Straße nach Süden durch das {zone:1413} lagert {npc:6244} östlich der Straße, nordöstlich von {area:378}; komm von Osten und halte dich von den Wachen der Horde fern.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: in {zone:1440}, auf dem Weg nach {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: der Inkubus, neben dem Sukkubus; das {item:190309} liegt nahe {quest:1738}",

	-- Step 13: Highperch
	-- {area:485} Great Lift · {zone:1441} Thousand Needles · {area:482} Highperch
	["Down the {area:485} into {zone:1441}, then west to the wyverns' cliffs at {area:482}. Every wyvern there can drop a venom sac."] = "",

	-- Step 14: Thousand Needles
	-- {area:482} Highperch
	["The canyons east of {area:482}"] = "",

	-- Step 16: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Folge den Schluchten nach Osten zur Salzebene. Die Goblins und Gnome der {area:2240} sind neutral und geben beiden Fraktionen Quests.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Für {quest:5762} im Schlingendorntal, später",

	-- Step 17: Mirage Raceway: kill these as you meet them
	-- {area:2240} Mirage Raceway
	["{area:2240}: kill these as you meet them"] = "",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Snappers (tortoises) the whole flats. Saltstone Basilisks and Crystalhides hold the middle; the Gazers (34-35) only the far south."] = "",
	-- {npc:4078} Collin Mauren · {zone:1453} Stormwind
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["Crystalized Scale, from the Saltstone Basilisks: eight for {npc:4078} in {zone:1453}"] = "",

	-- Step 18: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, at the end of 30-40"] = "",

	-- Step 19: Into Tanaris
	-- {zone:1446} Tanaris
	["Into {zone:1446}"] = "",
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris
	["From the raceway follow the road south out of the {area:439} into {zone:1446}."] = "",

	-- Step 20: Gadgetzan
	-- {area:976} Gadgetzan · {npc:7823} Bera Stonehammer
	["{area:976} is a short walk down the road; keep to it. {npc:7823}, the Alliance flight master, stands inside the walls."] = "",

	-- Step 21: Fly to Theramore
	["Fly to Theramore"] = "Flieg nach Theramore",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 22: Theramore
	-- {npc:4456} Fiora Longears · {area:514} Foothold Citadel · {npc:4941} Caz Twosprocket
	["{npc:4456} is in the north of town, Captain Vimes in {area:514}; {npc:4941} stands in the town."] = "",

	-- Step 23: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Schiff nach {area:150}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Zurück nach Westen über die Straße zu den Satyrlagern von {area:429}.",
	-- ["Dartol's Rod"] = "Dartols Rute der Transformation",
	-- ["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Folge der Straße nach Osten zu den Satyrlagern von {area:429}; {npc:3920} versteckt sich an ihrem Rand.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Folge der Straße von {area:415} aus nach Westen; {area:413} liegt nördlich davon.",
	-- ["From {area:608}"] = "Start: {area:608}",
	-- ["Geltharis"] = "Geltharis",
	-- ["Insane druids"] = "Wahnsinnige Druiden",
	-- ["Lightforge Ingots"] = "Lichtschmiedeblöcke",
	-- ["Melyria and {npc:3901}"] = "Melyria und {npc:3901}",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Rostige Truhen stehen rund um die Furbolglager des Schattendickichts westlich der Verlassenen; öffne sie, bis eine den Knauf enthält.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "{area:150}: Nimm das Boot vom Steg in {area:442}.",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Nimm den Tunnel ins Gebiet {area:419}; der Foliant liegt in den Ruinen an seinem Westende.",
	-- ["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Die Wahnsinnigen und Welken Urtume nördlich des Mondbrunnens tragen den {item:5475}; die abgenutzte Truhe, die er öffnet, steht zwischen ihnen.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "Das Lager der Verlassenen liegt in den Wäldern südlich von {area:2358}.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "Der Mondbrunnen liegt in den Hügeln nordöstlich von {area:415}.",
	-- ["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Der zweite {object:19901} liegt im Tal {area:428}, auf dem Weg nach Westen.",
	-- ["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "Der Schrein liegt auf dem Hügel gleich südöstlich des Mondbrunnens; folge dem gewundenen Pfad hinauf.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Die drei Druiden stehen zusammen im Lager der Verlassenen südlich von {area:2358}.",
	-- ["The two stand together at the western end of the road."] = "Die beiden stehen zusammen am Westende der Straße.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Das Wrack der Flying Osprey liegt im seichten Wasser südlich der Burg.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "Das {npc:3931} läuft am Ufer des {quest:1035} entlang, südwestlich der Truhen; der {object:669176} liegt unterwegs nördlich des Sees.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "Der {object:19901} steht im Satyrlager von {area:430}, weiter östlich an der Straße.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}, der Außenposten der Nachtelfen am Ostende der Straße: {npc:3848} und {npc:221269} stehen dort.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, der Außenposten der Nachtelfen am Ostende der Straße: {npc:3848} steht dort.",
	-- ["{area:429} satyrs"] = "Satyrn von {area:429}",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} steht im oberen Stockwerk der Burg von Menethil.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} und seine Wachen lagern gleich östlich von {npc:3897}.",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, ein Furbolg, den die Verderbnis nicht berührt hat, sitzt südlich der Straße unterhalb vom {area:421}.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: für {npc:1480} in Menethil, am Ende dieses Guides",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} führt die Satyrn von {area:429} an; er trägt den Zweig.",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} und {npc:4962} Jahn sind alle im Gasthaus von Menethil; Tapoke greift dich an, wenn du mit {npc:4963} sprichst, gibt aber auf, sobald er besiegt ist. {npc:1480} steht ein kurzes Stück nordöstlich des Gasthauses.",
	-- ["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: für {npc:3961} in {area:415}",
}
