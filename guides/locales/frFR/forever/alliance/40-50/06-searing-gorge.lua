-- French (frFR): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "Vers {area:2101}",

	-- Step 2: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "Vers la {zone:1427}",

	-- Step 3: Searing Gorge
	["The Grimesilt outhouse"] = "Les toilettes de Crasseboue",

	-- Step 4: The Grimesilt outhouse
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}: the {area:247} is just inside, in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "",

	-- Step 5: The Grimesilt outhouse
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "La tâche suivante du prisonnier, Grand livre de {zone:1446}, vous envoie au {zone:1435} et au {zone:1445} : passez-la.",

	-- Step 6: Level 48.27
	["Level 48.27"] = "Niveau 48.27",
	-- {item:3985} Monogrammed Sash · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "tuez en boucle : {npc:5839}",

	-- Step 7: Dorius Stonetender
	-- {area:247} Grimesilt Dig Site · {area:1959} Dustfire Valley · {object:175704} Singed Letter
	["Dorius stands by the road beside the {area:247}. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "",
	-- {npc:8256} Curator Thorius · {area:1537} Ironforge
	["For {npc:8256} in {area:1537}, later"] = "Pour {npc:8256} à {area:1537}, plus tard",

	-- Step 8: Thorium Point
	-- {area:1446} Thorium Point
	["Ride west along the north of the Gorge to {area:1446}, the scaffolded camp on the north-west rim."] = "",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Le panneau {object:179827}",

	-- Step 10: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "L'elfe de la nuit Zamael Lunthistle se tient seul à l'ouest du {area:1446}. Écoutez son histoire.",

	-- Step 13: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Araignées de lave incendiaires",
	-- {npc:8436} Zamael Lunthistle · {npc:8479} Velarok Windblade
	["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to {npc:8479}."] = "",

	-- Step 14: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "",

	-- Step 17: Golems and elementals
	["Golems and elementals"] = "Golems et élémentaires",
	-- {npc:8479} Velarok Windblade
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below {npc:8479}; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "",

	-- Step 19: Dark Iron dwarves: kill these as you meet them
	-- {object:147516} Dark Iron
	["{object:147516} dwarves: kill these as you meet them"] = "",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "",

	-- Step 22: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "{zone:1427} : tuez-les au passage",
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} s'ouvre au nord du Chaudron. Les Plans secrets : Flux embrasé se trouvent sur sa corniche supérieure ; les Incendosaures nagent dans les bassins de lave plus loin, attirez-les vers le bord. Restez loin de {npc:14621} et de ses gardes élites au fond.",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "{item:18922} ; sous terre",

	-- Step 23: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:14621} est un élite de niveau 50 : la plupart des classes le battent seules au niveau 52, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 25: Level 48.66
	["Level 48.66"] = "Niveau 48.66",
	-- {quest:7701} WANTED: Overseer Maltorius · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "tuez en boucle : {npc:9318}",

	-- Step 27: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:5860} (élite de niveau 50) demande un groupe de 3. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 29: Level 48.98
	["Level 48.98"] = "Niveau 48.98",
	-- {quest:3452} The Flame's Casing · {area:2100} Maraudon · {area:978} Zul'Farrak
	["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan. Or, with a group, run the {area:2100} dungeon or the {area:978} dungeon instead."] = "",
	-- {npc:5844} Dark Iron Slaver
	["grind on {npc:5844}"] = "tuez en boucle : {npc:5844}",

	-- Step 30: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {quest:3181} demande un groupe de 2. Passez-la si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",
	["Below ground"] = "Sous terre",

	-- Step 33: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "Maître de vol de {area:1446}",

	-- Step 34: Class trainer
	["Class trainer"] = "Maître de classe",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["For {npc:8256} in {zone:1455}, later"] = "Pour {npc:8256} à {zone:1455}, plus tard",
	-- ["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {area:51}. {area:1446} is the scaffolded camp on the north-west rim."] = "Depuis {area:144}, chevauchez vers le sud jusqu'aux {zone:1418}, puis vers l'ouest après {area:340}, la ville de la Horde (gardez vos distances), et montez le sentier jusqu'à la {area:51}. {area:1446} est le camp à échafaudages sur le rebord nord-ouest.",
	-- ["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "Depuis {area:144}, chevauchez vers le sud jusqu'aux {zone:1418}, puis vers l'ouest au-delà de la ville horde de {area:340} (gardez vos distances) et montez la piste jusqu'à la {zone:1427}. Le {area:1446} est le camp échafaudé sur le rebord nord-ouest.",
	-- ["Greater Lava Spiders"] = "Araignées de lave incendiaires",
	-- ["Hearth to {area:2101}"] = "Pierre de foyer vers {area:2101}",
	-- ["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Les Golems de guerre lourds patrouillent au fond du Chaudron sous Velarok Lamevent ; les Elémentaires de magma dérivent parmi eux. Golems et élémentaires laissent tomber l'huile, les élémentaires les cœurs.",
	-- ["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan."] = "Si vous avez passé {item:3985} ou Face à Negolash, tuez des monstres ici jusqu'au niveau 48.27 pour suivre le plan de l'itinéraire.",
	-- ["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan."] = "Si vous avez passé {quest:3452}, tuez des monstres ici jusqu'au niveau 48.98 pour suivre le plan de l'itinéraire.",
	-- ["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan."] = "Si vous avez passé {quest:7701}, tuez des monstres ici jusqu'au niveau 48.66 pour suivre le plan de l'itinéraire.",
	-- ["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Velarok Lamevent se tient sur le rebord du Chaudron, au sud du {area:1446}. Écoutez son histoire.",
	-- ["On the way"] = "En chemin",
	-- ["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Traversez le Chaudron vers l'est jusqu'à {area:247}, au sud-est. Le prisonnier dans les latrines en bois veut 15 {item:4306} et huit Géologues Sombrefer ({npc:5839}) tués sur le site de fouilles alentour. Les latrines s'ouvrent aussi avec la clé, si vous en avez trouvé une.",
	-- ["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one.\nThe dwarf stands by the road at the dig site. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "Chevauchez vers l'est à travers le Chaudron jusqu'au {area:247}, au sud-est. Le prisonnier des toilettes en bois veut 15 {item:4306} et huit Géologues Sombrefer tués sur le site de fouilles alentour. Les toilettes s'ouvrent aussi avec la clé, si vous en avez trouvé une.\nLe nain se tient près de la route, au site de fouilles. Une fois terminé, lisez {object:175704} qu'il laisse sur la route dans la {area:1959}.",
	-- ["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Les Sous-chefs Sombrefer et les Esclavagistes Sombrefer mènent les esclaves dans tout le Chaudron, et chacun d'eux peut porter une {item:10551}. Les Forge-vapeur Sombrefer travaillent aux fourneaux du centre (la {item:18959}), les Guetteurs Sombrefer se tiennent sur les crêtes sud (la Longue-vue de guetteur). Tout {object:147516} peut laisser tomber la {item:11818} : gardez-la.",
	-- ["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "Le nain Dorius Stonetender se tient près de la route sur le site de fouilles. Suivez-le vers le nord le long de la route et repoussez les embuscades {object:147516}. Une fois terminé, lisez la {object:175704} qu'il laisse sur la route dans la {area:1959}.",
	-- ["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Les araignées errent sur les plateaux et autour des bassins de lave au sud-ouest de la gorge.",
	-- ["The spiders roam the plateaus and lava pools in the south-west of the gorge.\nHeavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts.\nTaskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "Les araignées parcourent les plateaux et les mares de lave au sud-ouest de la gorge.\nDes Golems de guerre lourds patrouillent au fond du Chaudron, sous Kalaran ; des Élémentaires de magma dérivent parmi eux. Golems et élémentaires lâchent l'huile, les élémentaires les cœurs.\nLes Sous-chefs et les Esclavagistes mènent les esclaves dans tout le Chaudron, et n'importe lequel peut porter une {item:10551}. Les Forge-vapeur travaillent aux fourneaux du centre (la {item:18959}), les Guetteurs se tiennent sur les crêtes du sud (la longue-vue). N'importe quel {object:147516} peut lâcher la {item:11818} : gardez-la.\nAttention : les Esclavagistes Sombrefer (niveau 45-46) appellent à l'aide les alliés dans un rayon de 15 m quand vous les attirez, lancent Filet jusqu'à 15 m et utilisent Pourfendre au corps à corps.",
	-- ["{area:1442}: kill these as you meet them"] = "{area:1442} : tuez-les au passage",
	-- ["{item:10551} on the way"] = "{item:10551} en chemin",
	-- ["{npc:5844} along the way to {area:1446}"] = "{npc:5844} sur le chemin de {area:1446}",
	-- ["{npc:5846} along the way to {area:1446}"] = "{npc:5846} sur le chemin de {area:1446}",
	-- ["{npc:5858} on the way"] = "{npc:5858} en chemin",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734} : le guide précédent vous ramène ici par la pierre de foyer, cette étape se coche donc généralement aussitôt",
	-- ["{npc:9318} along the way to {area:1446}"] = "{npc:9318} sur le chemin de {area:1446}",
	-- ["{npc:9318} on the way"] = "{npc:9318} en chemin",
	-- ["{object:147516} dwarves"] = "Nains {object:147516}",
}
