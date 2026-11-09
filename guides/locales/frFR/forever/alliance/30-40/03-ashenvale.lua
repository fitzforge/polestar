-- French (frFR): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Prendre un vol pour {area:150}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Maître de vol de {zone:1453}",

	-- Step 2: Red Jack Flint
	-- {npc:4455} Red Jack Flint
	["{npc:4455} stands on the dock just north of the flight master."] = "",
	-- {quest:1132} Fiora Longears
	["For {quest:1132} on Theramore's docks, where this guide's boat lands"] = "",

	-- Step 3: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} se tient à l'étage supérieur du donjon de Menethil.",
	["Inside"] = "À l'intérieur",

	-- Step 4: Deepwater Tavern
	-- {quest:1248} The Missing Diplomat · {npc:4963} Mikhail
	["Tapoke Jahn (34) slips out of the tavern once you take {quest:1248}: stay close behind him. He turns on you outside, a friend joins him, and he gives up once badly hurt. If you lose him the quest fails: abandon it and take it again from {npc:4963}."] = "",

	-- Step 5: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "L'épave du Flying Osprey repose dans les hauts-fonds au sud du donjon.",

	-- Step 6: Lightforge Ingots
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Les murlocs Branchie-bleue sur la plage au sud-ouest du Port de Menethil portent les lingots.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "{item:2702} ; sous l'eau",

	-- Step 7: Glorin Steelbrow
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["For {npc:1416} in {zone:1453}, after Stranglethorn"] = "",

	-- Step 9: Theramore
	["Theramore"] = "Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "Le maître de vol se tient près de la porte de {area:514} ; {npc:5083} et {npc:4964} sont dans la citadelle.",
	-- {npc:5083} Clerk Lendry
	["{npc:5083}, on the top floor"] = "{npc:5083}, au dernier étage",
	-- {npc:4964} Commander Samaul
	["{npc:4964}, on the top floor"] = "{npc:4964}, au dernier étage",
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
	["Into {zone:1413}"] = "Vers les {zone:1413}",

	-- Step 12: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "Sur la route vers le sud à travers les {zone:1413}, {npc:6244} campe à l'est de la route, au nord-est du {area:378} ; arrivez par l'est et évitez les gardes de la Horde.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738} : en {zone:1440}, en route vers {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602} : l'incube, à côté de la succube ; la {item:190309} est près de {quest:1738}",

	-- Step 13: Highperch
	-- {area:485} Great Lift · {zone:1441} Thousand Needles · {area:482} Highperch
	["Down the {area:485} into {zone:1441}, then west to the wyverns' cliffs at {area:482}. Every wyvern there can drop a venom sac."] = "",

	-- Step 14: Thousand Needles
	-- {area:482} Highperch
	["The canyons east of {area:482}"] = "",

	-- Step 16: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Suivez les canyons vers l'est jusqu'aux Salines. Les gobelins et les gnomes de {area:2240} sont neutres et donnent des quêtes aux deux factions.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Pour {quest:5762} à Strangleronce, plus tard",

	-- Step 17: Mirage Raceway: kill these as you meet them
	-- {area:2240} Mirage Raceway
	["{area:2240}: kill these as you meet them"] = "{area:2240} : tuez-les au passage",
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
	["Fly to Theramore"] = "Volez jusqu'à Theramore",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maître de vol de {area:976}",

	-- Step 22: Theramore
	-- {npc:4456} Fiora Longears · {area:514} Foothold Citadel · {npc:4941} Caz Twosprocket
	["{npc:4456} is in the north of town, Captain Vimes in {area:514}; {npc:4941} stands in the town."] = "",

	-- Step 23: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Retournez vers l'ouest par la route jusqu'aux camps de satyres de {area:429}.",
	-- ["Dartol's Rod"] = "Bâtonnet de transformation de Dartol",
	-- ["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- ["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Suivez la route vers l'est jusqu'aux camps de satyres de {area:429} ; {npc:3920} se cache à leur lisière.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Suivez la route vers l'ouest en quittant {area:415} ; le {area:413} se trouve au nord de celle-ci.",
	-- ["From {area:608}"] = "Depuis {area:608}",
	-- ["Geltharis"] = "Geltharis",
	-- ["Hearth to {area:415}"] = "Pierre de foyer vers {area:415}",
	-- ["Insane druids"] = "Druides fous",
	-- ["Lightforge Ingots"] = "Lingots de sancteforge",
	-- ["Melyria and {npc:3901}"] = "Sentinelle Melyria Frostshadow et {npc:3901}",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Des Coffres rouillés se trouvent autour des camps de furbolgs Sombretaillis à l'ouest des Réprouvés ; ouvrez-les jusqu'à trouver le Pommeau en fer.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "Prenez le bateau pour {area:150} aux quais d'{area:442}.",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Empruntez le tunnel jusqu'au {area:419} ; le tome se trouve dans les ruines à son extrémité ouest.",
	-- ["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Les Anciens fous et les Anciens flétris au nord du puits de lune portent la {item:5475} ; le vieux coffre qu'elle ouvre se trouve parmi eux.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "Le camp des Réprouvés se trouve dans les bois au sud de {area:2358}.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "Le camp des Réprouvés se trouve dans les bois au sud de {area:2358}.\nDes coffres rouillés se trouvent autour des camps de furbolgs Sombretaillis à l'ouest des Réprouvés ; ouvrez-les jusqu'à ce que l'un d'eux contienne le pommeau.\nAttention : des Réprouvés non élites de niveau 28-30 environ gardent le camp. Certains sont camouflés, et ceux autour de la table attaquent souvent ensemble.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "Le puits de lune se trouve dans les collines au nord-est d'{area:415}.",
	-- ["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Le second {object:19901} se trouve dans la vallée de {area:428}, sur le chemin vers l'ouest.",
	-- ["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "L'Autel caché se trouve sur la colline juste au sud-est du puits de lune ; suivez le sentier sinueux.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Les trois druides se tiennent ensemble au camp des Réprouvés au sud de {area:2358}.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "Les trois druides se tiennent ensemble au camp des Réprouvés au sud de {area:2358}.\nAttention : le repaire compte de nombreux monstres qui réapparaissent vite, dont des morts-vivants camouflés et des patrouilles : d'autres monstres se joignent souvent au combat.",
	-- ["The two stand together at the western end of the road."] = "Les deux se tiennent ensemble à l'extrémité ouest de la route.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "L'épave du Flying Osprey repose dans les hauts-fonds au sud du donjon.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "L'{npc:3931} arpente la rive du {quest:1035}, au sud-ouest des coffres ; le {object:669176} se trouve au nord du lac, sur le chemin.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "{npc:3931} arpente les rives de {quest:1035}, au sud-ouest des coffres ; {object:669176} se trouve au nord du lac, en chemin.\nAttention : d'autres monstres, dont certains sous l'eau, se tiennent près de l'île. Éliminez-les d'abord pour qu'ils ne se joignent pas au combat quand vous attirez l'Oracle.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "Le {object:19901} se trouve dans le camp de satyres de {area:430}, plus loin à l'est sur la route.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "Le {object:19901} se trouve dans le camp des satyres de {area:430}, plus à l'est sur la route.\nAttention : les Voleurs Gangremusc de {area:428} sont souvent camouflés, et {area:430} compte des satyres lanceurs de sorts.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}, l'avant-poste elfe de la nuit à l'extrémité est de la route : {npc:3848} et {npc:221269} s'y trouvent.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, l'avant-poste elfe de la nuit à l'extrémité est de la route : {npc:3848} s'y trouve.",
	-- ["{area:415} flight master"] = "Maître de vol d'{area:415}",
	-- ["{area:429} satyrs"] = "Satyres de {area:429}",
	-- ["{area:432}: kill these as you meet them"] = "{area:432} : tuez-les au passage",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} Steelbrow se tient à l'étage supérieur du Donjon de Menethil.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} et ses gardes campent juste à l'est de {npc:3897}.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "{npc:3696} et ses gardes campent juste à l'est de {npc:3897}.\nAttention : des loups et des araignées rôdent près du camp et peuvent se joindre au combat. Certains loups vont par deux.",
	-- ["{npc:3894}, inside"] = "{npc:3894}, à l'intérieur",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, un furbolg épargné par la corruption, est assis au sud de la route, en contrebas du {area:421}.",
	-- ["{npc:3940}, inside {area:432}"] = "{npc:3940}, à l'intérieur de {area:432}",
	-- ["{npc:3941}, inside {area:432}"] = "{npc:3941}, à l'intérieur de {area:432}",
	-- ["{npc:3942}, inside {area:432}"] = "{npc:3942}, à l'intérieur de {area:432}",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970} : pour {npc:1480} au Port de Menethil, à la fin de ce guide",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} dirige les satyres de {area:429} ; il porte la branche.",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} et {npc:4962} \"Slim\" Jahn sont tous à l'auberge du Port de Menethil ; Tapoke vous attaque quand vous parlez à {npc:4963}, mais abandonne une fois vaincu. {npc:1480} se tient à quelques pas au nord-est de l'auberge.",
	-- ["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176} : pour {npc:3961} à {area:415}",
}
