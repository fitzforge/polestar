-- French (frFR): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Vers {zone:1455}",

	-- Step 2: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Prendre un vol pour {area:144}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 3: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "Vers la {zone:1427}",

	-- Step 4: Searing Gorge
	["The Grimesilt outhouse"] = "Les toilettes de Crasseboue",

	-- Step 5: The Grimesilt outhouse
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}: the {area:247} is just inside, in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Depuis {area:144}, chevauchez vers le sud jusqu'aux {zone:1418}, puis vers l'ouest en passant la ville hordeuse de {area:340} (gardez vos distances) et montez le sentier jusqu'à la {zone:1427} : {area:247} se trouve juste à l'entrée, au sud-est. Le prisonnier dans les latrines en bois veut 15 {item:4306} et huit Géologues Sombrefer tués sur le site de fouilles alentour. Les latrines s'ouvrent aussi avec la clé, si vous en avez trouvé une.",

	-- Step 6: The Grimesilt outhouse
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "La tâche suivante du prisonnier, Grand livre de {zone:1446}, vous envoie au {zone:1435} et au {zone:1445} : passez-la.",

	-- Step 7: Level 48.27
	["Level 48.27"] = "Niveau 48.27",
	-- {item:3985} Monogrammed Sash
	["If you skipped The {item:3985} or Facing Negolash, grind here to level 48.27 to stay on the route's plan."] = "Si vous avez passé {item:3985} ou Face à Negolash, tuez des monstres ici jusqu'au niveau 48.27 pour suivre le plan de l'itinéraire.",
	-- {npc:5839} Dark Iron Geologist
	["grind on {npc:5839}"] = "tuez en boucle : {npc:5839}",

	-- Step 8: Dorius Stonetender
	-- {area:247} Grimesilt Dig Site · {area:1959} Dustfire Valley · {object:175704} Singed Letter
	["Dorius stands by the road beside the {area:247}. Escort him north-east to {area:1959} and keep him alive; when it is over, read the {object:175704} he leaves on the road."] = "Dorius Stonetender se tient au bord de la route, à côté de {area:247}. Escortez-le vers le nord-est jusqu'à la {area:1959} et gardez-le en vie ; une fois terminé, lisez la {object:175704} qu'il laisse sur la route.",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, at the end of this guide"] = "Pour {npc:8256} à {zone:1455}, à la fin de ce guide",

	-- Step 9: Thorium Point
	-- {area:1446} Thorium Point
	["Ride west along the north of the Gorge to {area:1446}, the scaffolded camp on the north-west rim."] = "Chevauchez vers l'ouest par le nord de la gorge jusqu'au {area:1446}, le camp à échafaudages sur le rebord nord-ouest.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Le panneau {object:179827}",

	-- Step 11: Zamael Lunthistle
	-- {npc:8436} Zamael Lunthistle · {area:1442} Firewatch Ridge · {area:1446} Thorium Point · {npc:8282} Highlord Mastrogonde · {quest:3377} Prayer to Elune
	-- plural, as words: Twilight Fire Guards = {npc:5861} Twilight Fire Guard
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:8436} stands inside the Twilight camp at {area:1442}, west of {area:1446}, among Twilight Fire Guards, Idolaters and Geomancers (level 48-49 elites), with {npc:8282} (level 51, rare elite) beside him: {quest:3377} needs a group of 4. Skip it if you are alone."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:8436} se tient dans le camp du Crépuscule de {area:1442}, à l'ouest de {area:1446}, parmi les Gardefeux, les Idolâtres et les Géomanciens du crépuscule (élites de niveau 48-49), avec {npc:8282} (niveau 51, élite rare) à côté de lui : {quest:3377} demande un groupe de 4. Passez-la si vous êtes seul.",

	-- Step 14: Searing Lava Spiders
	-- plural, as words: Searing Lava Spiders = {npc:5857} Searing Lava Spider
	["Searing Lava Spiders"] = "Araignées de lave incendiaires",
	-- {npc:8436} Zamael Lunthistle
	["The spiders roam the plateaus and lava pools south of {npc:8436}, on the way to Velarok."] = "Les araignées errent sur les plateaux et autour des bassins de lave au sud de {npc:8436}, sur le chemin de Velarok.",

	-- Step 15: Velarok Windblade
	["Velarok Windblade"] = "Velarok Lamevent",
	-- {area:1446} Thorium Point
	["Velarok stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Velarok Lamevent se tient sur le rebord du Chaudron, au sud du {area:1446}. Écoutez son histoire.",

	-- Step 18: Golems and elementals
	["Golems and elementals"] = "Golems et élémentaires",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Velarok; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Les Golems de guerre lourds patrouillent au fond du Chaudron sous Velarok Lamevent ; les Elémentaires de magma dérivent parmi eux. Golems et élémentaires laissent tomber l'huile, les élémentaires les cœurs.",

	-- Step 20: Dark Iron dwarves: kill these as you meet them
	["Dark Iron dwarves: kill these as you meet them"] = "Nains Sombrefer : tuez-les au passage",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	-- plural, as words: Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "Les Sous-chefs Sombrefer et les Esclavagistes Sombrefer mènent les esclaves dans tout le Chaudron, et chacun d'eux peut porter une {item:10551}. Les Forge-vapeur Sombrefer travaillent aux fourneaux du centre (la {item:18959}), les Guetteurs Sombrefer se tiennent sur les crêtes sud (la Longue-vue de guetteur). Tout {object:147516} peut laisser tomber la {item:11818} : gardez-la.\nAttention : les Esclavagistes Sombrefer (niveau 45-46) appellent à l'aide les alliés dans un rayon de 15 m quand on les attire, lancent Filet jusqu'à 15 m et utilisent Pourfendre au corps à corps.",

	-- Step 23: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "{zone:1427} : tuez-les au passage",
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} s'ouvre au nord du Chaudron. Les Plans secrets : Flux embrasé se trouvent sur sa corniche supérieure ; les Incendosaures nagent dans les bassins de lave plus loin, attirez-les vers le bord. Restez loin de {npc:14621} et de ses gardes élites au fond.",
	-- {item:18922} Secret Plans: Fiery Flux
	["{item:18922}; below ground"] = "{item:18922} ; sous terre",

	-- Step 24: Searing Gorge: kill these as you meet them
	-- {npc:14621} Overseer Maltorius
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:14621} is a level 50 elite: most classes solo it at level 52, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:14621} est un élite de niveau 50 : la plupart des classes le battent seules au niveau 52, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 26: Level 48.66
	["Level 48.66"] = "Niveau 48.66",
	-- {quest:7701} WANTED: Overseer Maltorius
	["If you skipped {quest:7701}, grind here to level 48.66 to stay on the route's plan."] = "Si vous avez passé {quest:7701}, tuez des monstres ici jusqu'au niveau 48.66 pour suivre le plan de l'itinéraire.",
	-- {npc:9318} Incendosaur
	["grind on {npc:9318}"] = "tuez en boucle : {npc:9318}",

	-- Step 28: The Flame's Casing
	-- {npc:5860} Twilight Dark Shaman
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:5860} (level 50 elite) needs a group of 3. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:5860} (élite de niveau 50) demande un groupe de 3. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 30: The Torch of Retribution
	["Listen to Velarok's story once more."] = "Écoutez encore une fois l'histoire de Velarok.",

	-- Step 31: Velarok Windblade
	-- {quest:3453} The Torch of Retribution · {quest:3462} Squire Maltrake
	["{quest:3453} lies on the ground at Velarok's feet; {quest:3462} stands beside him."] = "{quest:3453} se trouve par terre aux pieds de Velarok ; {quest:3462} se tient à côté de lui.",
	-- {quest:3462} Squire Maltrake · {area:1446} Thorium Point
	["{quest:3462}: hand it in on the way back to {area:1446}"] = "{quest:3462} : rendez-la sur le chemin du retour vers le {area:1446}",

	-- Step 32: Sentry Braziers
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Sentry Braziers"] = "Braseros de sentinelle",
	-- {object:149047} Torch of Retribution
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Carry the {object:149047} south along the rim of the Cauldron and light the four Sentry Braziers, from the south-west round to the south-east."] = "Portez la {object:149047} vers le sud le long du rebord du Chaudron et allumez les quatre Braseros de sentinelle, du sud-ouest jusqu'au sud-est.",

	-- Step 33: Level 48.98
	["Level 48.98"] = "Niveau 48.98",
	-- {quest:3452} The Flame's Casing
	["If you skipped {quest:3452}, grind here to level 48.98 to stay on the route's plan."] = "Si vous avez passé {quest:3452}, tuez des monstres ici jusqu'au niveau 48.98 pour suivre le plan de l'itinéraire.",
	-- {npc:5844} Dark Iron Slaver
	["grind on {npc:5844}"] = "tuez en boucle : {npc:5844}",

	-- Step 34: Margol's Horn
	-- {quest:3181} The Horn of the Beast
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:3181} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {quest:3181} demande un groupe de 2. Passez-la si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",
	["Below ground"] = "Sous terre",

	-- Step 36: Squire Maltrake
	-- {npc:8509} Squire Maltrake · {area:1446} Thorium Point
	["{npc:8509} and the dragonflight's hoard are beside Velarok, on the rim south of {area:1446}."] = "{npc:8509} et le trésor du Vol draconique se trouvent à côté de Velarok, sur le rebord au sud du {area:1446}.",
	-- {object:149502} Hoard of the Black Dragonflight · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous · {zone:1428} Burning Steppes
	["The {object:149502} it gives holds a {item:10575}: keep it for {npc:9459} in the {zone:1428}"] = "Le {object:149502} qu'elle vous donne contient une {item:10575} : gardez-la pour {npc:9459} dans les {zone:1428}",

	-- Step 38: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Prendre un vol pour {area:1537}",
	-- {area:1446} Thorium Point
	["{area:1446} flight master"] = "Maître de vol de {area:1446}",

	-- Step 39: Hall of Explorers
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616} : les limons sont au {zone:1448}, gardez-la",

	-- Step 40: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "Quatre estampages de runes en {zone:1447} : gardez-la",

	-- Step 41: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 42: Xiggs Fuselighter
	-- {object:32359} Military Ward
	["Xiggs waits in the {object:32359}."] = "Xiggs attend dans le {object:32359}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["For {npc:8256} in {area:1537}, later"] = "Pour {npc:8256} à {area:1537}, plus tard",
	-- ["For {npc:8256} in {zone:1455}, later"] = "Pour {npc:8256} à {zone:1455}, plus tard",
	-- ["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "Depuis {area:144}, chevauchez vers le sud jusqu'aux {zone:1418}, puis vers l'ouest au-delà de la ville horde de {area:340} (gardez vos distances) et montez la piste jusqu'à la {zone:1427}. Le {area:1446} est le camp échafaudé sur le rebord nord-ouest.",
	-- ["Greater Lava Spiders"] = "Araignées de lave incendiaires",
	-- ["Hearth to {area:2101}"] = "Pierre de foyer vers {area:2101}",
	-- ["On the way"] = "En chemin",
	-- ["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one.\nThe dwarf stands by the road at the dig site. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "Chevauchez vers l'est à travers le Chaudron jusqu'au {area:247}, au sud-est. Le prisonnier des toilettes en bois veut 15 {item:4306} et huit Géologues Sombrefer tués sur le site de fouilles alentour. Les toilettes s'ouvrent aussi avec la clé, si vous en avez trouvé une.\nLe nain se tient près de la route, au site de fouilles. Une fois terminé, lisez {object:175704} qu'il laisse sur la route dans la {area:1959}.",
	-- ["The night elf stands alone west of {area:1446}. Hear his story."] = "L'elfe de la nuit Zamael Lunthistle se tient seul à l'ouest du {area:1446}. Écoutez son histoire.",
	-- ["The spiders roam the plateaus and lava pools in the south-west of the gorge.\nHeavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts.\nTaskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "Les araignées parcourent les plateaux et les mares de lave au sud-ouest de la gorge.\nDes Golems de guerre lourds patrouillent au fond du Chaudron, sous Kalaran ; des Élémentaires de magma dérivent parmi eux. Golems et élémentaires lâchent l'huile, les élémentaires les cœurs.\nLes Sous-chefs et les Esclavagistes mènent les esclaves dans tout le Chaudron, et n'importe lequel peut porter une {item:10551}. Les Forge-vapeur travaillent aux fourneaux du centre (la {item:18959}), les Guetteurs se tiennent sur les crêtes du sud (la longue-vue). N'importe quel {object:147516} peut lâcher la {item:11818} : gardez-la.\nAttention : les Esclavagistes Sombrefer (niveau 45-46) appellent à l'aide les alliés dans un rayon de 15 m quand vous les attirez, lancent Filet jusqu'à 15 m et utilisent Pourfendre au corps à corps.",
	-- ["{item:10551} on the way"] = "{item:10551} en chemin",
	-- ["{npc:5844} along the way to {area:1446}"] = "{npc:5844} sur le chemin de {area:1446}",
	-- ["{npc:5846} along the way to {area:1446}"] = "{npc:5846} sur le chemin de {area:1446}",
	-- ["{npc:5858} on the way"] = "{npc:5858} en chemin",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734} : le guide précédent vous ramène ici par la pierre de foyer, cette étape se coche donc généralement aussitôt",
	-- ["{npc:9318} along the way to {area:1446}"] = "{npc:9318} sur le chemin de {area:1446}",
	-- ["{npc:9318} on the way"] = "{npc:9318} en chemin",
	-- ["{object:147516} dwarves"] = "Nains {object:147516}",
}
