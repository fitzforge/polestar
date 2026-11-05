-- French (frFR): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, à l'intérieur",

	-- Step 2: Dartol's Rod
	["Dartol's Rod"] = "Bâtonnet de transformation de Dartol",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Les Anciens fous et les Anciens flétris au nord du puits de lune portent la {item:5475} ; le vieux coffre qu'elle ouvre se trouve parmi eux.",

	-- Step 3: The Howling Vale
	-- {area:419} Howling Vale
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Empruntez le tunnel jusqu'au {area:419} ; le tome se trouve dans les ruines à son extrémité ouest.",

	-- Step 5: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Suivez la route vers l'est jusqu'aux camps de satyres de {area:429} ; {npc:3920} se cache à leur lisière.",

	-- Step 6: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} dirige les satyres de {area:429} ; il porte la branche.",

	-- Step 7: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, l'avant-poste elfe de la nuit à l'extrémité est de la route : {npc:3848} s'y trouve.",

	-- Step 8: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "{area:432} : tuez-les au passage",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "Le camp des Réprouvés se trouve dans les bois au sud de {area:2358}.\nDes coffres rouillés se trouvent autour des camps de furbolgs Sombretaillis à l'ouest des Réprouvés ; ouvrez-les jusqu'à ce que l'un d'eux contienne le pommeau.\nAttention : des Réprouvés non élites de niveau 28-30 environ gardent le camp. Certains sont camouflés, et ceux autour de la table attaquent souvent ensemble.",

	-- Step 9: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "{npc:3931} arpente les rives de {quest:1035}, au sud-ouest des coffres ; {object:669176} se trouve au nord du lac, en chemin.\nAttention : d'autres monstres, dont certains sous l'eau, se tiennent près de l'île. Éliminez-les d'abord pour qu'ils ne se joignent pas au combat quand vous attirez l'Oracle.",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176} : pour {npc:3961} à {area:415}",

	-- Step 11: Insane druids
	["Insane druids"] = "Druides fous",
	-- {area:2358} Forest Song
	["The three druids stand together at the Forsaken camp south of {area:2358}.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "Les trois druides se tiennent ensemble au camp des Réprouvés au sud de {area:2358}.\nAttention : le repaire compte de nombreux monstres qui réapparaissent vite, dont des morts-vivants camouflés et des patrouilles : d'autres monstres se joignent souvent au combat.",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "{npc:3940}, à l'intérieur de {area:432}",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "{npc:3941}, à l'intérieur de {area:432}",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "{npc:3942}, à l'intérieur de {area:432}",

	-- Step 12: Satyrnaar
	-- {object:19901} Circle of Imprisonment · {area:430} Satyrnaar · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["The {object:19901} stands in the satyr camp of {area:430}, further east along the road.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "Le {object:19901} se trouve dans le camp des satyres de {area:430}, plus à l'est sur la route.\nAttention : les Voleurs Gangremusc de {area:428} sont souvent camouflés, et {area:430} compte des satyres lanceurs de sorts.",

	-- Step 14: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "Le second {object:19901} se trouve dans la vallée de {area:428}, sur le chemin vers l'ouest.",

	-- Step 16: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "L'Autel caché se trouve sur la colline juste au sud-est du puits de lune ; suivez le sentier sinueux.",

	-- Step 19: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, un furbolg épargné par la corruption, est assis au sud de la route, en contrebas du {area:421}.",

	-- Step 20: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "{npc:3696} et ses gardes campent juste à l'est de {npc:3897}.\nAttention : des loups et des araignées rôdent près du camp et peuvent se joindre au combat. Certains loups vont par deux.",

	-- Step 22: Hearth to Astranaar
	-- {area:415} Astranaar
	["Hearth to {area:415}"] = "Pierre de foyer vers {area:415}",

	-- Step 25: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "Sentinelle Melyria Frostshadow et {npc:3901}",

	-- Step 27: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Prendre un vol pour {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Maître de vol d'{area:415}",

	-- Step 28: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Bateau pour {area:150}",

	-- Step 29: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} se tient à l'étage supérieur du donjon de Menethil.",
	["Inside"] = "À l'intérieur",

	-- Step 31: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "L'épave du Flying Osprey repose dans les hauts-fonds au sud du donjon.",

	-- Step 32: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Lingots de sancteforge",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Les murlocs Branchie-bleue sur la plage au sud-ouest du Port de Menethil portent les lingots.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "{item:2702} ; sous l'eau",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Retournez vers l'ouest par la route jusqu'aux camps de satyres de {area:429}.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Suivez la route vers l'ouest en quittant {area:415} ; le {area:413} se trouve au nord de celle-ci.",
	-- ["From {area:608}"] = "Depuis {area:608}",
	-- ["Geltharis"] = "Geltharis",
	-- ["Insane druids"] = "Les druides fous",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Des Coffres rouillés se trouvent autour des camps de furbolgs Sombretaillis à l'ouest des Réprouvés ; ouvrez-les jusqu'à trouver le Pommeau en fer.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "Prenez le bateau pour {area:150} aux quais d'{area:442}.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "Le camp des Réprouvés se trouve dans les bois au sud de {area:2358}.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "Le puits de lune se trouve dans les collines au nord-est d'{area:415}.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Les trois druides se tiennent ensemble au camp des Réprouvés au sud de {area:2358}.",
	-- ["The two stand together at the western end of the road."] = "Les deux se tiennent ensemble à l'extrémité ouest de la route.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "L'épave du Flying Osprey repose dans les hauts-fonds au sud du donjon.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "L'{npc:3931} arpente la rive du {quest:1035}, au sud-ouest des coffres ; le {object:669176} se trouve au nord du lac, sur le chemin.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "Le {object:19901} se trouve dans le camp de satyres de {area:430}, plus loin à l'est sur la route.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}, l'avant-poste elfe de la nuit à l'extrémité est de la route : {npc:3848} et {npc:221269} s'y trouvent.",
	-- ["{area:429} satyrs"] = "Satyres de {area:429}",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} Steelbrow se tient à l'étage supérieur du Donjon de Menethil.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} et ses gardes campent juste à l'est de {npc:3897}.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970} : pour {npc:1480} au Port de Menethil, à la fin de ce guide",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} et {npc:4962} \"Slim\" Jahn sont tous à l'auberge du Port de Menethil ; Tapoke vous attaque quand vous parlez à {npc:4963}, mais abandonne une fois vaincu. {npc:1480} se tient à quelques pas au nord-est de l'auberge.",
}
