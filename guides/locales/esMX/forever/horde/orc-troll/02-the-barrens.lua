-- Spanish (Latin America) (esMX): the guide forever/horde/orc-troll/02-the-barrens (forever/horde/orc-troll/02-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Crossroads
	-- {area:379} Far Watch Post · {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3464} Gazrog · {npc:3448} Tonga Runetotem
	["You arrive from {area:379}. {npc:3338} stands by the inn; {npc:3429} and {npc:3449} on the tower platform; Helbrim and {npc:3464} by the north gate; {npc:3448} at the south gate."] = "Llegas desde {area:379}. {npc:3338} está junto a la posada; {npc:3429} y {npc:3449}, en la plataforma de la torre; Helbrim y {npc:3464}, junto a la puerta norte; {npc:3448}, en la puerta sur.",

	-- Step 2: Plainstriders and raptors
	["Plainstriders and raptors"] = "Zancudos y raptores",
	-- {area:380} The Crossroads
	["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "Los zancudos de llanura y los raptores Solescama deambulan por las llanuras alrededor de {area:380}.",

	-- Step 4: Zhevra and raptors
	["Zhevra and raptors"] = "Zhebras y raptores",
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze on the same plains; finish the raptor heads as you go."] = "Los Galopadores zhebra ({npc:3242}) pastan en las mismas llanuras; termina las cabezas de raptor de paso.",

	-- Step 5: The Crossroads
	-- {npc:3449} Darsok Swiftdagger
	["{npc:3449}, on the tower platform: needs level 12"] = "{npc:3449}, en la plataforma de la torre: necesita nivel 12",

	-- Step 6: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} acampa junto al camino al este, hacia {area:392}.",

	-- Step 7: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {area:380} The Crossroads
	["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907} está en la loma al norte del campamento Crines de Acero, al este de {area:380}.",

	-- Step 8: Telf Joolam
	-- {npc:5900} Telf Joolam · {zone:1411} Durotar · {area:814} Southfury River
	["{npc:5900} waits on the {zone:1411} bank of the {area:814}, east of the Razormane camp."] = "{npc:5900} espera en la orilla de {area:814} del lado de {zone:1411}, al este del campamento Crines de Acero.",

	-- Step 9: Dustwind Gulch cultists
	-- {area:1898} Dustwind Gulch
	["{area:1898} cultists"] = "Sectarios de {area:1898}",
	-- {area:1898} Dustwind Gulch · {zone:1411} Durotar · {area:370} Drygulch Ravine · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Burning Blade Cultists hold {area:1898} in northern {zone:1411}, by {area:370}; they drop the {item:6652}."] = "Los Sectarios del Filo Ardiente ({npc:3199}) ocupan {area:1898}, en el norte de {zone:1411}, junto a {area:370}; sueltan {item:6652}.",

	-- Step 10: Razormane camp
	["Razormane camp"] = "Campamento Crines de Acero",
	-- {area:380} The Crossroads · {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "Los buscaquas, tejespinas y cazadores ocupan el campamento al este de {area:380}. Las cajas de suministros están en su extremo este. Guerreros: {object:58369} está en el campamento. Chamanes: los jabaespines sueltan {item:5026}. Mata a los Merodeadores de la sabana ({npc:3425}) que encuentres para obtener sus garras.",

	-- Step 11: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} prepara {item:6636} con el alquitrán y la faltriquera. Úsala junto al brasero a su lado para revelar la {npc:5893}, mátala para obtener {item:6655} y luego coloca la brasa en el brasero.",

	-- Step 12: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, tu {item:5176} y {item:263412}",

	-- Step 14: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Sigue el camino al sureste hasta {area:392}, en la costa.",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, en el muelle",

	-- Step 15: Southsea beach
	["Southsea beach"] = "Playa de los Mares del Sur",
	-- {area:392} Ratchet
	["The pirates camp along the beach south of {area:392}. The piles of complicated parts lie in and around their camp."] = "Los piratas acampan a lo largo de la playa al sur de {area:392}. Las pilas de piezas complicadas están dentro y alrededor de su campamento.",

	-- Step 17: Stolen Booty
	-- {object:3767} Drizzlik's Emporium
	["Back to the pirate camp: the boots are in the crate marked {object:3767} at the camp's south end, the lens in the Fragile crate just east of it."] = "De vuelta al campamento pirata: las botas están en la caja marcada {object:3767}, en el extremo sur del campamento, y la lente en la caja Frágil justo al este.",

	-- Step 19: Back to the The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}"] = "De vuelta a {area:380}",
	-- {area:380} The Crossroads
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "Regresa por el camino hasta {area:380}. Los Merodeadores de la sabana ({npc:3425}) cazan a lo largo del camino y en las llanuras al oeste del pueblo: termina las garras antes de entregarlas.",

	-- Step 20: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} The Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} está en el puesto de vigilancia Kolkar, justo al oeste de {area:380}.",

	-- Step 21: Kolkar camps and the Forgotten Pools
	-- {area:386} Forgotten Pools
	["Kolkar camps and the {area:386}"] = "Campamentos Kolkar y {area:386}",
	-- {npc:3389} Regthar Deathgate · {quest:855} Centaur Bracers · {area:386} Forgotten Pools
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom · Savannah Prowlers = {npc:3425} Savannah Prowler
	["The Kolkar camps spread north-west of {npc:3389}; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "Los campamentos Kolkar se extienden al noroeste de {npc:3389}; cualquier Kolkar puede soltar {quest:855}. {area:386} están en medio, con Champiñones cargados ({object:3640}) alrededor del agua. Los Merodeadores de la sabana ({npc:3425}) recorren las mismas llanuras.",
	["Wade into the pools to explore them"] = "Métete en las pozas para explorarlas",

	-- Step 23: Witchwing harpies
	["Witchwing harpies"] = "Arpías Alabruja",
	-- {area:383} Dry Hills · {area:386} Forgotten Pools
	["The harpies nest in the {area:383} north-west of the {area:386}; any of them can drop a talon."] = "Las arpías anidan en {area:383}, al noroeste de {area:386}; cualquiera puede soltar una garra.",

	-- Step 24: The Sludge Fen
	-- {area:382} The Sludge Fen · {object:4141} Control Console · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "Ve al este hasta el sitio de investigación de Ventura y Cía. al oeste de {area:382}. Usa {object:4141}, cierra las tres válvulas alrededor del taladro, usa la consola de nuevo y luego toma {item:5089} de {npc:3471}.",

	-- Step 25: Echeyakee
	-- {quest:881} Echeyakee · {area:382} The Sludge Fen · {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {area:392} Ratchet
	["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn {npc:3338} gave you there to call the white lion out. Then hearth to {area:392}."] = "La guarida de {quest:881} está al sur de {area:382}, al noreste de {area:380}. Usa allí el cuerno que te dio {npc:3338} para hacer salir al león blanco. Luego usa tu piedra de hogar para ir a {area:392}.",

	-- Step 27: The Disruption Ends
	-- {area:380} The Crossroads · {npc:3438} Kreenig Snarlsnout
	["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "De regreso a {area:380}, otra vez el campamento Crines de Acero: las Geománticas y los Defensores ocupan su mitad este; {npc:3438} camina entre ellos.",

	-- Step 29: The Stagnant Oasis
	-- {area:380} The Crossroads
	["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "El oasis está al sureste de {area:380}. Prueba las semillas en la fisura burbujeante en medio del agua.",

	-- Step 30: Raptor Grounds
	-- {area:1697} Raptor Grounds
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["The {area:1697} lie south-west of the oasis. Sunscale Scytheclaws drop the feathers you use on the three nests."] = "{area:1697} están al suroeste del oasis. Los Segadores Solescama ({npc:3256}) sueltan las plumas que usas en los tres nidos.",

	-- Step 32: Lushwater Oasis
	-- {area:387} Lushwater Oasis · {area:380} The Crossroads
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "Los Quijafortes de oasis ({npc:3461}) llenan el agua de {area:387}, al suroeste de {area:380}.",

	-- Step 34: Wenikee Boltbucket
	-- {area:1703} Mor'shan Rampart · {npc:9316} Wenikee Boltbucket
	["Follow the road north to the {area:1703}; {npc:9316} stands just south of it."] = "Sigue el camino al norte hasta {area:1703}; {npc:9316} está justo al sur.",

	-- Step 35: Nugget Slugs
	-- {area:382} The Sludge Fen · {npc:9316} Wenikee Boltbucket
	-- plural, as words: Tool Buckets = {object:161752} Tool Bucket
	["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of {npc:9316}."] = "Los Cubos de herramientas ({object:161752}) están alrededor del campamento de Ventura y Cía. en {area:382}, al este de {npc:9316}.",

	-- Step 37: Witchwing Slayers
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Witchwing Slayers"] = "Destripadoras Alabruja ({npc:3278})",
	-- {area:383} Dry Hills
	["The Slayers hold the western end of the {area:383}, past the harpies you fought before; they drop the rings."] = "Las Destripadoras ocupan el extremo oeste de {area:383}, más allá de las arpías con las que peleaste antes; sueltan los anillos.",
	-- {area:383} Dry Hills · {zone:1413} The Barrens
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["grind on Witchwing Slayers at the {area:383}, {zone:1413}"] = "farmea Destripadoras Alabruja ({npc:3278}) en {area:383}, {zone:1413}",

	-- Step 38: The Crossroads
	-- {area:380} The Crossroads
	["Back to the {area:380}; the next guide starts here."] = "De vuelta a {area:380}; la siguiente guía empieza aquí.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:380}"] = "De vuelta a {area:380}",
	-- ["Back to the {area:380}; the next guide starts here."] = "De vuelta a {area:380}; la siguiente guía empieza aquí.",
	-- ["Head east to the Venture Co. research site west of the {area:382}. Use the {object:4141}, close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471}."] = "Ve al este hasta el sitio de investigación de Ventura y Cía. al oeste de {area:382}. Usa {object:4141}, cierra las tres válvulas alrededor del taladro, usa la consola de nuevo y luego toma {item:5089} de {npc:3471}.",
	-- ["Oasis Snapjaws crowd the water of {area:387}, south-west of the {area:380}."] = "Los Quijafortes de oasis ({npc:3461}) llenan el agua de {area:387}, al suroeste de {area:380}.",
	-- ["On the way back to the {area:380}, the Razormane camp again: Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "De regreso a {area:380}, otra vez el campamento Crines de Acero: las Geománticas y los Defensores ocupan su mitad este; {npc:3438} camina entre ellos.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}."] = "Los zancudos de llanura y los raptores Solescama deambulan por las llanuras alrededor de {area:380}.",
	-- ["Regthar stands at the Kolkar watch post just west of the {area:380}."] = "Regthar está en el puesto de vigilancia Kolkar, justo al oeste de {area:380}.",
	-- ["The Kolkar camps spread north-west of Regthar; every Kolkar can drop {quest:855}. {area:386} lie in their middle, with Laden Mushrooms around the water. Savannah Prowlers roam the same plains."] = "Los campamentos Kolkar se extienden al noroeste de Regthar; cualquier Kolkar puede soltar {quest:855}. {area:386} están en medio, con Champiñones cargados ({object:3640}) alrededor del agua. Los Merodeadores de la sabana ({npc:3425}) recorren las mismas llanuras.",
	-- ["The Tool Buckets sit around the Venture Co. camp in the {area:382}, east of Wenikee."] = "Los Cubos de herramientas ({object:161752}) están alrededor del campamento de Ventura y Cía. en {area:382}, al este de Wenikee.",
	-- ["The oasis lies south-east of the {area:380}. Test the seeds at the bubbling fissure in the middle of the water."] = "El oasis está al sureste de {area:380}. Prueba las semillas en la fisura burbujeante en medio del agua.",
	-- ["The {area:386}"] = "{area:386}",
	-- ["Walk back up the road to the {area:380}. Savannah Prowlers hunt along it and on the plains west of town: finish the claws before you hand them in."] = "Regresa por el camino hasta {area:380}. Los Merodeadores de la sabana ({npc:3425}) cazan a lo largo del camino y en las llanuras al oeste del pueblo: termina las garras antes de entregarlas.",
	-- ["Water Seekers, Thornweavers and Hunters hold the camp east of the {area:380}. The supply crates sit at its eastern end. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}. Kill Savannah Prowlers you pass for their claws."] = "Los buscaquas, tejespinas y cazadores ocupan el campamento al este de {area:380}. Las cajas de suministros están en su extremo este. Guerreros: {object:58369} está en el campamento. Chamanes: los jabaespines sueltan {item:5026}. Mata a los Merodeadores de la sabana ({npc:3425}) que encuentres para obtener sus garras.",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp, east of the {area:380}."] = "{npc:5907} está en la loma al norte del campamento Crines de Acero, al este de {area:380}.",
	-- ["{quest:881}'s lair lies south of the {area:382}, north-east of the {area:380}. Use the horn Sergra gave you there to call the white lion out. Then hearth to {area:392}."] = "La guarida de {quest:881} está al sur de {area:382}, al noreste de {area:380}. Usa allí el cuerno que te dio Sergra para hacer salir al león blanco. Luego usa tu piedra de hogar para ir a {area:392}.",
}
