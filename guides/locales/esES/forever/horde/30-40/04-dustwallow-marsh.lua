-- Spanish (Spain) (esES): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelín a {zone:1454}",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, para \"Ojolodo\" Jarl",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor
	["{npc:3354}, {object:172958}: for Fray Island, later in this guide (offered from level 30)"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "",

	-- Step 6: Fly to Camp Taurajo
	["Fly to Camp Taurajo"] = "",
	["Crossroads flight master"] = "",

	-- Step 8: Shady Rest Inn
	-- {object:21077} Shady Rest Inn (no name in this language: may be words)
	["Head east from Camp Taurajo along the road into the marsh. The burned-out {object:21077} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "En el cruce, toma el camino del norte hasta el poblado ogro de Murohelecho.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, en el borde sur del poblado, donde entra el camino",

	-- Step 11: Questioning Reethe
	-- {npc:4983} Ogron
	["{npc:4983} waits in the Quagmire east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "",

	-- Step 12: Stinky Ignatz
	["Stinky Ignatz"] = "Ignatz el \"Apestoso\"",
	["Head north to Witch Hill. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "",

	-- Step 13: Mirefin murlocs
	["Mirefin murlocs"] = "Múrlocs Ancalodo",
	["The Mirefin murlocs crowd the coast east and north-east of Witch Hill; every kind drops heads."] = "",

	-- Step 14: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "\"Ojolodo\" Jarl",
	["Jarl lives in the Swamplight Manor south-east of Witch Hill."] = "",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, junto a la mansión",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "",

	-- Step 15: Brackenwall Village: kill these as you meet them
	-- {object:21082} Brackenwall Village (no name in this language: may be words)
	["{object:21082}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Venomspitters = {npc:4414} Darkfang Venomspitter · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkfang Lurkers = {npc:4411} Darkfang Lurker · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "",

	-- Step 17: Swamp Eye Jarl
	["Head east back to the Swamplight Manor."] = "",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, ahora que {npc:4791} ha leído el informe",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "solo si llevas una {item:3853} ({skill:164} o la casa de subastas)",

	-- Step 18: The Theramore Docks
	["Underwater"] = "",

	-- Step 19: Level 37.5
	["Level 37.5"] = "",
	-- {zone:1443} Desolace
	["{zone:1443}'s last quests and Alterac are 38-41. Below 37.5? Keep killing the Mirefin murlocs along the north-east coast, past Witch Hill, until level 37.5. Or, with a group, run the Razorfen Downs dungeon or the Scarlet Monastery dungeon (Armory) instead."] = "",
	-- {npc:4362} Mirefin Coastrunner
	["grind on {npc:4362}"] = "",

	-- Step 20: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} in the village."] = "",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words)
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "",

	-- Step 21: Fly to Ratchet
	["Fly to Ratchet"] = "",
	-- {object:21082} Brackenwall Village (no name in this language: may be words)
	["{object:21082} flight master"] = "",

	-- Step 22: Ratchet
	["Ratchet"] = "",
	-- {npc:3391} Gazlowe · {npc:3446} Mebok Mizzyrix
	["{npc:3391} waits upstairs in the house by the flight master; {npc:3446} stands below it, towards the docks."] = "",
	-- {npc:3391} Gazlowe · {object:3204} Booty Bay (no name in this language: may be words)
	["{npc:3391}'s next errand takes you to {object:3204}, off this part of the route: leave it."] = "",

	-- Step 23: The Affray
	-- {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from Ratchet to Fray Island. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236}: Berserker Stance"] = "{npc:6236}: Actitud rabiosa",

	-- Step 24: Fly to Shadowprey Village
	-- {object:176946} Shadowprey Village (no name in this language: may be words)
	["Fly to {object:176946}"] = "",
	["Ratchet flight master"] = "",

	-- Step 25: Shadowprey Village
	-- {npc:11624} Taiga Wisemane
	["{npc:11624} stands in the village."] = "",

	-- Step 26: Portals of the Legion
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to Mannoroc Coven. Use the Rod of Banishing by each demon portal to close six of them.\nCareful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",
	["Mannoroc Coven"] = "",

	-- Step 27: Ghost Walker Post
	-- {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["North to the post; {npc:5412} stands beside {npc:5395}."] = "",

	-- Step 28: Valley of Spears
	["Valley of Spears"] = "",
	-- {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["West of the post, the Maraudine centaurs hold the Valley of Spears. Every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}."] = "",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle
	["{npc:6019} waits at the goblin camp on the west side of the Kodo Graveyard."] = "",

	-- Step 31: The Valley of Bones
	["The Valley of Bones"] = "",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Head south-east to the bone fields of the Valley of Bones, where Undead Ravagers roam. At the far south-east, use the {item:15848} to draw the Magrami Spectres: they drop the ghost-o-plasm."] = "",

	-- Step 32: Hornizz Brimbuzzle
	["North to the goblin camp on the west side of the Kodo Graveyard."] = "",

	-- Step 34: Shadowprey
	["Shadowprey"] = "",
	["West to Shadowprey."] = "",

	-- Step 35: Thunder Bluff
	-- {object:176946} Shadowprey Village (no name in this language: may be words) · {zone:1456} Thunder Bluff · {npc:3033} Turak Runetotem · {object:50507} Elder Rise (no name in this language: may be words) · {zone:1454} Orgrimmar
	["Fly from {object:176946} to {zone:1456} and train with {npc:3033} on {object:50507}; fly on to {zone:1454} from there."] = "",

	-- Step 36: Fly to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454}"] = "",
	-- {object:176946} Shadowprey Village (no name in this language: may be words)
	["{object:176946} flight master"] = "",

	-- Step 37: Back to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Back to {zone:1454}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 38: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars
	["{npc:3412}, in the {object:172958} beside {npc:4485}: {quest:2841}, if you ran Gnomeregan"] = "",

	-- Step 39: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "Arañas Colmilloumbrío",
	-- ["Fly to {area:378}"] = "Vuela a {area:378}",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "Para {npc:2519} en {object:3202}, en la siguiente guía",
	-- ["Hearth to Shadowprey"] = "Usa la piedra de hogar para ir a la Aldea Cazasombras",
	-- ["Hearth to {area:392}"] = "Usa la piedra de hogar para ir a {area:392}",
	-- ["Jarl lives in the {area:497} south-east of {area:502}."] = "Jarl vive en la {area:497}, al sureste de {area:502}.",
	-- ["Kodo bones and ghosts"] = "Huesos de kodo y fantasmas",
	-- ["Maraudine totems"] = "Tótems Maraudine",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Recoge los huesos de kodo esparcidos por el cementerio y usa el {item:15848} entre los huesos: los fantasmas que atrae sueltan el ectoplasma.",
	-- ["Ride back west to Brackenwall with the head."] = "Vuelve al oeste a Murohelecho con la cabeza.",
	-- ["Ride east back to the {area:497}."] = "Vuelve al este a la {area:497}.",
	-- ["Ride east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Ve al este desde {area:378} por el camino hacia el pantano. La {area:403} quemada está junto a él, justo pasada la frontera; el escudo, la insignia y las huellas de pezuña están dentro y al lado de la ruina.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Ve al este hasta {area:602}. Usa la Rod of Banishing junto a cada portal demoníaco para cerrar seis.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "Ve al norte desde el aquelarre hasta {npc:5412}, en {area:597}.",
	-- ["Ride north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Ve al norte hasta {area:502}. Apestoso está al pie de la colina; escóltalo mientras recoge hojas de cienagrana justo al sur.",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "Ve al norte por el camino hasta la cabaña junto al camino, al norte del cementerio.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Ve al noreste hasta {area:607}. {npc:12277} está retenida en el campamento de centauros Maraudine; libérala y escóltala fuera del valle, hacia el este.",
	-- ["Ride on south-west to Shadowprey."] = "Sigue al suroeste hasta la Aldea Cazasombras.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Ve al sur desde {area:2405} hacia {area:607}. Los Exploradores, Vaqueros, Destructores, Cazavientos y Maleantes Maraudine (36-39) sueltan los {quest:93225}.",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Vuelve al oeste cruzando el pantano. Los Escupevenenos Colmilloumbrío de las crestas al norte de Murohelecho sueltan las glándulas de veneno. Los Infiltradores de Theramore (35-36) se cuelan por los mismos bosques: usan sigilo, así que fíjate bien.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Ve al oeste hasta la torre de {npc:11863} en {area:2405}, en la costa noroeste.",
	-- ["Slitherblade coast"] = "Costa Filozante",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Los Filo Ardiente ocupan la fortaleza al noroeste de {area:2407}. Usa el {item:14523} sobre el {npc:11876} de la fortaleza para conseguir la {item:13542}.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Las arañas Niebla Negra pululan en la entrada de la cueva al noroeste de Murohelecho; todas sueltan ojos.",
	-- ["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Los múrlocs Ancalodo abarrotan la costa al este y noreste de {area:502}; todos sueltan cabezas.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Las nagas Filozante ocupan la costa al norte de {area:2405}, hasta {area:598}. {npc:12369} guarda {quest:6027} en la punta norte.",
	-- ["The caravan ends at {npc:11596}'s camp on the east side of the {area:596}."] = "La caravana termina en el campamento de {npc:11596}, en el lado este de {area:596}.",
	-- ["The next guide takes you back to {zone:1434}."] = "La siguiente guía te lleva de vuelta a {zone:1434}.",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "La caravana de {npc:11626} se detiene en el camino al borde de {area:602}. Escóltala al este, más allá del aquelarre; los demonios la atacan dos veces.",
	-- ["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} espera en {area:2302}, al este del poblado. Síguelo hasta Reethe y mantenlo con vida en la pelea que se desata.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} y {npc:5412} están en el campamento justo al oeste del de {npc:11596}.",
	-- ["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} espera en el campamento goblin del lado oeste de {area:596}.",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
}
