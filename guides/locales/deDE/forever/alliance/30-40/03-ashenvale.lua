-- German (deDE): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 2: Dartol's Rod
	["Dartol's Rod"] = "Dartols Rute der Transformation",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Die Wahnsinnigen und Welken Urtume nördlich des Mondbrunnens tragen den {item:5475}; die abgenutzte Truhe, die er öffnet, steht zwischen ihnen.",

	-- Step 3: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Nimm den Tunnel ins Gebiet {area:419}; der Foliant liegt in den Ruinen an seinem Westende.",

	-- Step 5: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Folge der Straße nach Osten zu den Satyrlagern von {area:429}; {npc:3920} versteckt sich an ihrem Rand.",

	-- Step 6: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} führt die Satyrn von {area:429} an; er trägt den Zweig.",

	-- Step 7: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, der Außenposten der Nachtelfen am Ostende der Straße: {npc:3848} steht dort.",

	-- Step 8: Bottle of Disease
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "",

	-- Step 10: Satyrnaar
	-- {object:19901} Circle of Imprisonment · {area:430} Satyrnaar · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["The {object:19901} stands in the satyr camp of {area:430}, further east along the road.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "",

	-- Step 11: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "",
	-- {area:2358} Forest Song
	["The three druids stand together at the Forsaken camp south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "",

	-- Step 12: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: für {npc:3961} in {area:415}",

	-- Step 14: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Der zweite {object:19901} liegt im Tal {area:428}, auf dem Weg nach Westen.",

	-- Step 16: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "Der Schrein liegt auf dem Hügel gleich südöstlich des Mondbrunnens; folge dem gewundenen Pfad hinauf.",

	-- Step 19: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, ein Furbolg, den die Verderbnis nicht berührt hat, sitzt südlich der Straße unterhalb vom {area:421}.",

	-- Step 20: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "",

	-- Step 22: Hearth to Astranaar
	-- {area:415} Astranaar
	["Hearth to {area:415}"] = "",

	-- Step 25: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Melyria und {npc:3901}",

	-- Step 27: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "",

	-- Step 28: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "",

	-- Step 30: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep.\nThe wreck of the Flying Osprey lies in the shallows south of the keep."] = "",
	["Inside"] = "",

	-- Step 31: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Lichtschmiedeblöcke",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Die Murlocs der Blaukiemen am Strand südwestlich von Menethil tragen die Blöcke.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "",

	-- Step 33: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 34: Deeprun Tram
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Zurück nach Westen über die Straße zu den Satyrlagern von {area:429}.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Folge der Straße von {area:415} aus nach Westen; {area:413} liegt nördlich davon.",
	-- ["From {area:608}"] = "Start: {area:608}",
	-- ["Geltharis"] = "Geltharis",
	-- ["Insane druids"] = "Wahnsinnige Druiden",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Rostige Truhen stehen rund um die Furbolglager des Schattendickichts westlich der Verlassenen; öffne sie, bis eine den Knauf enthält.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "{area:150}: Nimm das Boot vom Steg in {area:442}.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "Das Lager der Verlassenen liegt in den Wäldern südlich von {area:2358}.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "Der Mondbrunnen liegt in den Hügeln nordöstlich von {area:415}.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Die drei Druiden stehen zusammen im Lager der Verlassenen südlich von {area:2358}.",
	-- ["The two stand together at the western end of the road."] = "Die beiden stehen zusammen am Westende der Straße.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "Das Wrack der Flying Osprey liegt im seichten Wasser südlich der Burg.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "Das {npc:3931} läuft am Ufer des {quest:1035} entlang, südwestlich der Truhen; der {object:669176} liegt unterwegs nördlich des Sees.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "Der {object:19901} steht im Satyrlager von {area:430}, weiter östlich an der Straße.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}, der Außenposten der Nachtelfen am Ostende der Straße: {npc:3848} und {npc:221269} stehen dort.",
	-- ["{area:429} satyrs"] = "Satyrn von {area:429}",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} steht im oberen Stockwerk der Burg von Menethil.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} und seine Wachen lagern gleich östlich von {npc:3897}.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: für {npc:1480} in Menethil, am Ende dieses Guides",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} und {npc:4962} Jahn sind alle im Gasthaus von Menethil; Tapoke greift dich an, wenn du mit {npc:4963} sprichst, gibt aber auf, sobald er besiegt ist. {npc:1480} steht ein kurzes Stück nordöstlich des Gasthauses.",
}
