-- Spanish (Spain) (esES): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Vuela a {area:378}",

	-- Step 2: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Ve al este desde {area:378} por el camino hacia el pantano. La {area:403} quemada está junto a él, justo pasada la frontera; el escudo, la insignia y las huellas de pezuña están dentro y al lado de la ruina.",

	-- Step 3: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "En el cruce, toma el camino del norte hasta el poblado ogro de Murohelecho.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, en el borde sur del poblado, donde entra el camino",

	-- Step 4: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire
	["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} espera en {area:2302}, al este del poblado. Síguelo hasta Reethe y mantenlo con vida en la pelea que se desata.",

	-- Step 5: Stinky Ignatz
	["Stinky Ignatz"] = "Ignatz el \"Apestoso\"",
	-- {area:502} Witch Hill
	["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Ve al norte hasta {area:502}. Apestoso está al pie de la colina; escóltalo mientras recoge hojas de cienagrana justo al sur.",

	-- Step 6: Mirefin murlocs
	["Mirefin murlocs"] = "Múrlocs Ancalodo",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Los múrlocs Ancalodo abarrotan la costa al este y noreste de {area:502}; todos sueltan cabezas.",

	-- Step 7: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "\"Ojolodo\" Jarl",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Jarl vive en la {area:497}, al sureste de {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, junto a la mansión",

	-- Step 8: Darkfang spiders
	["Darkfang spiders"] = "Arañas Colmilloumbrío",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator
	["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Vuelve al oeste cruzando el pantano. Los Escupevenenos Colmilloumbrío de las crestas al norte de Murohelecho sueltan las glándulas de veneno. Los Infiltradores de Theramore (35-36) se cuelan por los mismos bosques: usan sigilo, así que fíjate bien.",

	-- Step 9: Darkmist Cavern
	["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Las arañas Niebla Negra pululan en la entrada de la cueva al noroeste de Murohelecho; todas sueltan ojos.",

	-- Step 11: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["Ride east back to the {area:497}."] = "Vuelve al este a la {area:497}.",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "solo si llevas una {item:3853} ({skill:164} o la casa de subastas)",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, ahora que {npc:4791} ha leído el informe",

	-- Step 12: Brackenwall Village
	["Ride back west to Brackenwall with the head."] = "Vuelve al oeste a Murohelecho con la cabeza.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words)
	["For {npc:2519} at {object:3202}, in the next guide"] = "Para {npc:2519} en {object:3202}, en la siguiente guía",

	-- Step 13: Hearth to Ratchet
	-- {area:392} Ratchet
	["Hearth to {area:392}"] = "Usa la piedra de hogar para ir a {area:392}",

	-- Step 15: Melizza Brimbuzzle
	-- {area:607} Valley of Spears · {npc:12277} Melizza Brimbuzzle
	["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Ve al noreste hasta {area:607}. {npc:12277} está retenida en el campamento de centauros Maraudine; libérala y escóltala fuera del valle, hacia el este.",

	-- Step 16: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} espera en el campamento goblin del lado oeste de {area:596}.",

	-- Step 17: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:602} Mannoroc Coven
	["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "La caravana de {npc:11626} se detiene en el camino al borde de {area:602}. Escóltala al este, más allá del aquelarre; los demonios la atacan dos veces.",

	-- Step 18: Scrabblescrew's Camp
	-- {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "La caravana termina en el campamento de {npc:11596}, en el lado este de {area:596}.",

	-- Step 19: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5412} Gurda Wildmane · {npc:11596} Smeed Scrabblescrew
	["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} y {npc:5412} están en el campamento justo al oeste del de {npc:11596}.",

	-- Step 20: Kormek's Hut
	["Ride north up the road to the hut by the road north of the graveyard."] = "Ve al norte por el camino hasta la cabaña junto al camino, al norte del cementerio.",

	-- Step 21: Kodo bones and ghosts
	["Kodo bones and ghosts"] = "Huesos de kodo y fantasmas",
	-- {item:15848} Crate of Ghost Magnets
	["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Recoge los huesos de kodo esparcidos por el cementerio y usa el {item:15848} entre los huesos: los fantasmas que atrae sueltan el ectoplasma.",

	-- Step 24: Thunder Axe Fortress
	-- {area:2407} Kormek's Hut · {item:14523} Demon Pick · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Los Filo Ardiente ocupan la fortaleza al noroeste de {area:2407}. Usa el {item:14523} sobre el {npc:11876} de la fortaleza para conseguir la {item:13542}.",

	-- Step 25: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Ve al oeste hasta la torre de {npc:11863} en {area:2405}, en la costa noroeste.",

	-- Step 26: Slitherblade coast
	["Slitherblade coast"] = "Costa Filozante",
	-- {area:2405} Ethel Rethor · {area:598} Sar'theris Strand · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Las nagas Filozante ocupan la costa al norte de {area:2405}, hasta {area:598}. {npc:12369} guarda {quest:6027} en la punta norte.",

	-- Step 28: Maraudine totems
	["Maraudine totems"] = "Tótems Maraudine",
	-- {area:2405} Ethel Rethor · {area:607} Valley of Spears · {quest:93225} Carved Centaur Totems
	-- plural, as words: Maraudine Scouts = {npc:4654} Maraudine Scout
	["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Ve al sur desde {area:2405} hacia {area:607}. Los Exploradores, Vaqueros, Destructores, Cazavientos y Maleantes Maraudine (36-39) sueltan los {quest:93225}.",

	-- Step 29: Shadowprey Village
	["Ride on south-west to Shadowprey."] = "Sigue al suroeste hasta la Aldea Cazasombras.",

	-- Step 30: Portals of the Legion
	-- {area:602} Mannoroc Coven
	["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Ve al este hasta {area:602}. Usa la Rod of Banishing junto a cada portal demoníaco para cerrar seis.",

	-- Step 31: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {area:597} Ghost Walker Post
	["Ride north from the coven to {npc:5412} at {area:597}."] = "Ve al norte desde el aquelarre hasta {npc:5412}, en {area:597}.",

	-- Step 32: Hearth to Shadowprey
	["Hearth to Shadowprey"] = "Usa la piedra de hogar para ir a la Aldea Cazasombras",
	-- {zone:1434} Stranglethorn Vale
	["The next guide takes you back to {zone:1434}."] = "La siguiente guía te lleva de vuelta a {zone:1434}.",
}
