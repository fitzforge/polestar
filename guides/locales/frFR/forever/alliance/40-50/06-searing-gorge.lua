-- French (frFR): the guide forever/alliance/40-50/06-searing-gorge (forever/alliance/40-50/06-searing-gorge.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:6734} Innkeeper Hearthstove
	["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734} : le guide précédent vous ramène ici par la pierre de foyer, cette étape se coche donc généralement aussitôt",

	-- Step 2: Thorium Point
	-- {area:144} Thelsamar · {zone:1418} Badlands · {area:340} Kargath · {zone:1427} Searing Gorge · {area:1446} Thorium Point
	["From {area:144} ride south into the {zone:1418}, then west past the Horde town of {area:340} (give it room) and up the trail into {zone:1427}. {area:1446} is the scaffolded camp on the north-west rim."] = "Depuis {area:144}, chevauchez vers le sud jusqu'aux {zone:1418}, puis vers l'ouest au-delà de la ville horde de {area:340} (gardez vos distances) et montez la piste jusqu'à la {zone:1427}. Le {area:1446} est le camp échafaudé sur le rebord nord-ouest.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "Le panneau {object:179827}",

	-- Step 3: Zamael Lunthistle
	-- {area:1446} Thorium Point
	["The night elf stands alone west of {area:1446}. Hear his story."] = "L'elfe de la nuit Zamael Lunthistle se tient seul à l'ouest du {area:1446}. Écoutez son histoire.",

	-- Step 4: Kalaran Windblade
	-- {area:1446} Thorium Point
	["Kalaran stands on the rim of the Cauldron, south of {area:1446}. Listen to his story."] = "Velarok Lamevent se tient sur le rebord du Chaudron, au sud du {area:1446}. Écoutez son histoire.",

	-- Step 5: Golems and elementals
	["Golems and elementals"] = "Golems et élémentaires",
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Magma Elementals = {npc:5855} Magma Elemental
	["Heavy War Golems patrol the floor of the Cauldron below Kalaran; Magma Elementals drift among them. Golems and elementals drop the oil, elementals the hearts."] = "Les Golems de guerre lourds patrouillent au fond du Chaudron sous Velarok Lamevent ; les Elémentaires de magma dérivent parmi eux. Golems et élémentaires laissent tomber l'huile, les élémentaires les cœurs.",

	-- Step 7: Dark Iron dwarves
	-- {object:147516} Dark Iron
	["{object:147516} dwarves"] = "Nains {object:147516}",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere · {object:147516} Dark Iron · {item:11818} Grimesilt Outhouse Key
	["Taskmasters and Slavers drive the slaves all over the Cauldron, and any of them can carry a {item:10551}. The Steamsmiths work at the furnaces in the middle (the {item:18959}), the Lookouts stand on the southern ridges (the Spyglass). Any {object:147516} may drop the {item:11818}: keep it."] = "Les Sous-chefs Sombrefer et les Esclavagistes Sombrefer mènent les esclaves dans tout le Chaudron, et chacun d'eux peut porter une {item:10551}. Les Forge-vapeur Sombrefer travaillent aux fourneaux du centre (la {item:18959}), les Guetteurs Sombrefer se tiennent sur les crêtes sud (la Longue-vue de guetteur). Tout {object:147516} peut laisser tomber la {item:11818} : gardez-la.",

	-- Step 8: Greater Lava Spiders
	-- plural, as words: Greater Lava Spiders = {npc:5858} Greater Lava Spider
	["Greater Lava Spiders"] = "Araignées de lave incendiaires",
	["The spiders roam the plateaus and lava pools in the south-west of the gorge."] = "Les araignées errent sur les plateaux et autour des bassins de lave au sud-ouest de la gorge.",

	-- Step 10: The Slag Pit
	-- {area:1443} The Slag Pit · {npc:14621} Overseer Maltorius
	-- plural, as words: Incendosaurs = {npc:9318} Incendosaur
	["{area:1443} opens in the north of the Cauldron. The Secret Plans lie on its upper ledge; Incendosaurs swim in the lava pools further in, so pull them to the edge. Stay clear of {npc:14621} and his elite guards deep inside."] = "{area:1443} s'ouvre au nord du Chaudron. Les Plans secrets : Flux embrasé se trouvent sur sa corniche supérieure ; les Incendosaures nagent dans les bassins de lave plus loin, attirez-les vers le bord. Restez loin de {npc:14621} et de ses gardes élites au fond.",

	-- Step 12: The Grimesilt outhouse
	["The Grimesilt outhouse"] = "Les toilettes de Crasseboue",
	-- {area:247} Grimesilt Dig Site · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["Ride east across the Cauldron to the {area:247} in the south-east. The prisoner in the wooden outhouse wants 15 {item:4306} and eight dead Dark Iron Geologists from the dig site around it. The outhouse also opens with the key, if you found one."] = "Traversez le Chaudron vers l'est jusqu'à {area:247}, au sud-est. Le prisonnier dans les latrines en bois veut 15 {item:4306} et huit Géologues Sombrefer ({npc:5839}) tués sur le site de fouilles alentour. Les latrines s'ouvrent aussi avec la clé, si vous en avez trouvé une.",
	-- {zone:1446} Tanaris · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh
	["The prisoner's next task, Ledger from {zone:1446}, sends you to the {zone:1435} and {zone:1445}: skip it."] = "La tâche suivante du prisonnier, Grand livre de {zone:1446}, vous envoie au {zone:1435} et au {zone:1445} : passez-la.",

	-- Step 13: Dorius Stonetender
	-- {object:147516} Dark Iron · {object:175704} Singed Letter · {area:1959} Dustfire Valley
	["The dwarf stands by the road at the dig site. Follow him north along the road and fight off the {object:147516} ambushes. When it is over, read the {object:175704} he leaves on the road in {area:1959}."] = "Le nain Dorius Stonetender se tient près de la route sur le site de fouilles. Suivez-le vers le nord le long de la route et repoussez les embuscades {object:147516}. Une fois terminé, lisez la {object:175704} qu'il laisse sur la route dans la {area:1959}.",
	-- {npc:8256} Curator Thorius · {zone:1455} Ironforge
	["For {npc:8256} in {zone:1455}, later"] = "Pour {npc:8256} à {zone:1455}, plus tard",
}
