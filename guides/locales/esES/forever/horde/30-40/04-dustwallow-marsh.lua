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

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, para \"Ojolodo\" Jarl",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maestro de vuelo de {zone:1454}",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "Vuela a {area:378}",
	["Crossroads flight master"] = "Maestro de vuelo del Cruce",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "Ve al este desde {area:378} por el camino hacia el pantano. La {area:403} quemada está junto a él, justo pasada la frontera; el escudo, la insignia y las huellas de pezuña están dentro y al lado de la ruina.",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "En el cruce, toma el camino del norte hasta el poblado ogro de Murohelecho.",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}, en el borde sur del poblado, donde entra el camino",

	-- Step 11: Stinky Ignatz
	["Stinky Ignatz"] = "Ignatz el \"Apestoso\"",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "Ve al norte hasta {area:502}. Apestoso está al pie de la colina; escóltalo mientras recoge hojas de cienagrana justo al sur.",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "Múrlocs Ancalodo",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "Los múrlocs Ancalodo abarrotan la costa al este y noreste de {area:502}; todos sueltan cabezas.",

	-- Step 13: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "\"Ojolodo\" Jarl",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "Jarl vive en la {area:497}, al sureste de {area:502}.",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}, junto a la mansión",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "",

	-- Step 14: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "",
	-- plural, as words: Darkfang Lurkers = {npc:4411} Darkfang Lurker · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Lurkers (36-37) and Venomspitters (37-38) on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes. Work its outer edge, where the Spiders and Recluses (35-37) stand: the Lurkers and Silkspinners (37-39) deeper in are two or three over you.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "Vuelve al oeste cruzando el pantano. Los rondadores Colmilloumbrío (36-37) y los escupevenenos (37-38) de las crestas al norte de Murohelecho sueltan las bolsas de veneno. Los infiltradores de Theramore (35-36) se mueven sigilosos por el mismo bosque: van en sigilo, así que fíjate bien.\nLas arañas Niebla Negra abarrotan la entrada de la cueva al noroeste de Murohelecho; todas sueltan ojos. Ve por el borde exterior, donde están las arañas y las reclusas (35-37): las rondadoras y tejesedas (37-39) del interior están dos o tres niveles por encima de ti.\nCuidado: los rondadores Colmilloumbrío (nivel 36-37) usan Acechar fuera de combate y lanzan Veneno al luchar.\nCuidado: las arañas en sigilo de la zona te atacarán en cuanto te vean.\nCuidado: las rondadoras Niebla Negra se mueven en sigilo y usan veneno en combate. Las arañas están muy juntas, así que es fácil que se unan más; atraer objetivos sueltos desde el borde exterior lo reduce.",
	-- plural, as words: Giant Darkfang Spiders = {npc:4415} Giant Darkfang Spider
	["Every Darkfang spider drops them: Lurkers, Spiders, Venomspitters and the Giant Darkfang Spiders"] = "",

	-- Step 16: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire · {npc:5045} Private Hallan
	-- plural, as words: Theramore Skirmishers = {npc:5044} Theramore Skirmisher
	["On the way east, {npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out: {npc:5045} and Theramore Skirmishers (36) join it."] = "De camino al este, {npc:4983} espera en {area:2302}, al este del poblado. Síguelo hasta Reethe y mantenlo con vida en la pelea que se desata: {npc:5045} y varios tramadores de Theramonte (36) se unen a ella.",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["On east to the {area:497}."] = "Sigue al este hasta la {area:497}.",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}, ahora que {npc:4791} ha leído el informe",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "solo si llevas una {item:3853} ({skill:164} o la casa de subastas)",

	-- Step 18: The Theramore Docks
	-- {area:513} Theramore Isle · {object:20925} Captain's Footlocker
	-- plural, as words: Young Murk Threshers = {npc:4388} Young Murk Thresher
	["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer. Young Murk Threshers (40-41) circle in the water around the docks: grab the footlocker and swim straight out."] = "Al sureste desde la mansión hasta {area:513}: {object:20925} está en el fondo del mar frente a los muelles del lado este de la isla. Entra y sal a nado y mantente lejos de los muelles y del pueblo: los guardias de Theramore son de nivel 53-57, y morir aquí supone una larga carrera de vuelta desde el Ángel de la Resurrección. Hay trilladores de la oscuridad jóvenes (40-41) dando vueltas en el agua alrededor de los muelles: coge el baúl y sal nadando directamente.",
	["Underwater"] = "Bajo el agua",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike · {npc:4926} Krog
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} and {npc:4926} in the village."] = "Vuelve al oeste a Murohelecho con la cabeza: {npc:4503} está en el borde sur del poblado, donde entra el camino, y {npc:4791} y {npc:4926} en el poblado.",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows
	["For {npc:2519} at {object:3202}, in the {zone:1434} & {zone:1435} guide"] = "",

	-- Step 20: Level 36
	["Level 36"] = "",
	-- {zone:1443} Desolace
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["{zone:1443}'s last quests are 36-39. Still below 36 after Brackenwall's hand-ins? The Drywallow Crocolisks (35-36) along the river east of the village are the closest at your level: kill them until level 36."] = "Las últimas misiones de {zone:1443} son de nivel 36-39. ¿Sigues por debajo del 36 tras las entregas de Murohelecho? Los crocoliscos secorrones (35-36) del río al este del poblado son los más cercanos a tu nivel: mátalos hasta el nivel 36.",
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["Drywallow Crocolisks"] = "Crocoliscos secorrones",
	-- {npc:4341} Drywallow Crocolisk
	["grind on {npc:4341}"] = "mata {npc:4341} para subir de nivel",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Vuela a {area:392}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "",

	-- Step 22: Ratchet
	-- {npc:3446} Mebok Mizzyrix
	["{npc:3446} stands below Gazlowe's house by the flight master, towards the docks."] = "{npc:3446} está debajo de la casa de Gazlowe, junto al maestro de vuelo, hacia los muelles.",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "",

	-- Step 24: Ratchet flight master
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",
	-- {area:392} Ratchet
	["Back north along the coast to {area:392}'s flight master."] = "Vuelve al norte por la costa hasta el maestro de vuelo de {area:392}.",

	-- Step 25: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "",
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["Fly to {area:2408} from the flight master you are next to: {area:392}'s, or Brackenwall's if you had no errand in {area:392}."] = "Vuela a {area:2408} desde el maestro de vuelo que tengas al lado: el de {area:392}, o el de Murohelecho si no tenías nada que hacer en {area:392}.",

	-- Step 26: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {npc:12340} Drulzegar Skraghook
	["{npc:11624} and {npc:12340} stand in the village."] = "{npc:11624} y {npc:12340} están en el poblado.",
	-- {npc:11624} Taiga Wisemane · {quest:5381} Hand of Iruxos · {area:599} Thunder Axe Fortress
	["{npc:11624}: the {quest:5381}, at {area:599} later on this visit"] = "{npc:11624}: {quest:5381}, en {area:599} más adelante en esta visita",
	-- {npc:12340} Drulzegar Skraghook · {area:599} Thunder Axe Fortress
	["{npc:12340}: the Slitherblade of Sar'theris Strand, on the way back from {area:599}"] = "{npc:12340}: los Filoescurridizo de la Playa de Sar'theris, a la vuelta de {area:599}",

	-- Step 27: Aka'rai
	-- {npc:268705} Aka'rai · {area:2408} Shadowprey Village · {area:603} Sargeron · {area:599} Thunder Axe Fortress
	["{npc:268705} stands by the path out of {area:2408}, on your way east: her Hatefury satyrs are at {area:603}, past {area:599} later on this visit."] = "",

	-- Step 28: Ghost Walker Post
	-- {area:597} Ghost Walker Post · {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["East along the road to {area:597}; {npc:5412} stands beside {npc:5395}."] = "Ve al este por el camino hasta {area:597}; {npc:5412} está junto a {npc:5395}.",
	-- {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["{npc:5395}: his {quest:1366}, from the same Maraudine as Gurda's totems"] = "{npc:5395}: su {quest:1366}, de los mismos Maraudine que los tótems de Gurda",

	-- Step 29: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty · {npc:5402} Khan Hratha
	-- plural, as words: Rock Worms = {npc:11788} Rock Worm
	["West of the post, the Maraudine centaurs hold the {area:607}; every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}. Stay with the Scouts and Wranglers (36-38) at the valley's eastern edge; the Maulers and Windchasers (38-39) a little further in are up to two over you at 37: pull them one at a time.\nCareful: {npc:5402} and the Rock Worms (41-42, elite) hold the valley's north-western end with the Khan Guards and Marauders (39-40), and the Magram's village in the south-east has Necromancers (42-43): keep east of the arrow."] = "Al oeste del puesto, los centauros Maraudine ocupan {area:607}; cualquier Maraudine puede soltar un {item:254432} y una oreja para la {quest:1366} de {npc:5395}. Quédate con los exploradores y los cuatreros (36-38) en el borde este del valle; los machacadores y los cazavientos (38-39), algo más adentro, te sacan hasta dos niveles a nivel 37: atráelos de uno en uno.\nCuidado: {npc:5402} y los Gusanos de piedra (41-42, élite) ocupan el extremo noroeste del valle con los guardias y merodeadores del Khan (39-40), y el poblado Magram del sureste tiene nigromantes (42-43): mantente al este de la flecha.",

	-- Step 30: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",

	-- Step 31: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019} espera en el campamento goblin del lado oeste de {area:596}.",
	-- {npc:6019} Hornizz Brimbuzzle · {area:602} Mannoroc Coven
	["{npc:6019}: the ghost-o-plasm, after {area:602} at the end of this visit"] = "{npc:6019}: el ectoplasma, después de {area:602} al final de esta visita",

	-- Step 33: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["North up the road to {area:599}. Clear the middle of the largest building, then use the {item:14523} on the red {object:176581} there. A {npc:11876} (37) comes out: kill it for the {item:13542}. The Burning Blade around it are well under you now."] = "Ve al norte por el camino hasta {area:599}. Despeja el centro del edificio más grande y usa el {item:14523} en el {object:176581} rojo que hay allí. Sale un {npc:11876} (37): mátalo para conseguir la {item:13542}. Los Filo Ardiente de alrededor ya están muy por debajo de tu nivel.",
	-- {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal
	["{item:14523}, on the {object:176581}"] = "",

	-- Step 34: Sargeron
	-- {area:603} Sargeron
	["East from the fortress to {area:603}, the Hatefury satyrs' ruins in the north-east (32-33, well under you now): two of each kind."] = "",

	-- Step 35: Sar'theris Strand
	-- {area:598} Sar'theris Strand
	-- plural, as words: Slitherblade Myrmidons = {npc:4714} Slitherblade Myrmidon
	-- was: ["West from the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "Ve al oeste desde la fortaleza hasta la costa de {area:598}: los Mirmidones Filozante, las nagas y las hechiceras ocupan la playa. Atráelos de uno en uno; las brujas del mar y los oráculos (34-36) lanzan hechizos a distancia."
	["West past the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "",

	-- Step 36: Shadowprey Village
	-- {npc:268705} Aka'rai · {npc:11624} Taiga Wisemane · {area:602} Mannoroc Coven · {npc:12340} Drulzegar Skraghook
	-- was: ["South down the coast to Shadowprey: {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "Baja al sur por la costa hasta Cazasombras: {npc:11624} recoge la caja y te envía con ella a {area:602}; {npc:12340} recoge lo de las nagas."
	["South down the coast to Shadowprey: {npc:268705} first, on the path into the village; {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "",

	-- Step 37: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "",

	-- Step 38: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {zone:1443} Desolace · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["South-east of the coven, the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge: keep south of the Magram's village on the way. Use the {item:15848} at the arrow to draw the Magrami Spectres (38-39): they come in numbers, so fight them with your back to the valley's edge. They drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "Al sureste del aquelarre, los campos de huesos de {area:2657}, donde vagan los Devastadores no-muertos, en el borde sur de {zone:1443}: mantente al sur del poblado Magram por el camino. Usa el {item:15848} en la flecha para atraer a los espectros Magrami (38-39): vienen en grupo, así que lucha de espaldas al borde del valle. Sueltan el ectoplasma.\nCuidado: los Necrokhans Magram y los devoracadáveres (45, élite) recorren los campos de huesos justo al oeste de la flecha, muy por encima de tu nivel: usa el cajón en la flecha, en el lado este del valle, y aleja a los espectros de ellos.",

	-- Step 39: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard · {area:602} Mannoroc Coven
	["North-west to the goblin camp on the west side of the {area:596}, back past {area:602}: keep west of the Magram's village."] = "Ve al noroeste hasta el campamento goblin del lado oeste de {area:596}, pasando de nuevo por {area:602}: mantente al oeste del poblado Magram.",

	-- Step 40: Shadowprey
	["Shadowprey"] = "",
	["Hearth to Shadowprey: your hearthstone is still bound there."] = "Usa la piedra de hogar para volver a Cazasombras: sigue vinculada allí.",

	-- Step 41: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "",

	-- Step 42: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maestro de vuelo de {area:2408}",

	-- Step 43: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 44: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "",

	-- Step 45: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "",

	-- Step 46: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "Arañas Colmilloumbrío",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "Para {npc:2519} en {object:3202}, en la siguiente guía",
	-- ["Head east back to the {area:497}."] = "Vuelve al este a la {area:497}.",
	-- ["Hearth to {area:392}"] = "Usa la piedra de hogar para ir a {area:392}",
	-- ["Kodo bones and ghosts"] = "Huesos de kodo y fantasmas",
	-- ["Maraudine totems"] = "Tótems Maraudine",
	-- ["North to the goblin camp on the west side of the {area:596}."] = "Al norte, hasta el campamento goblin del lado oeste de {area:596}.",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "Recoge los huesos de kodo esparcidos por el cementerio y usa el {item:15848} entre los huesos: los fantasmas que atrae sueltan el ectoplasma.",
	-- ["Ride back west to Brackenwall with the head."] = "Vuelve al oeste a Murohelecho con la cabeza.",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "Ve al este hasta {area:602}. Usa la Rod of Banishing junto a cada portal demoníaco para cerrar seis.",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "Ve al norte desde el aquelarre hasta {npc:5412}, en {area:597}.",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "Ve al norte por el camino hasta la cabaña junto al camino, al norte del cementerio.",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "Ve al noreste hasta {area:607}. {npc:12277} está retenida en el campamento de centauros Maraudine; libérala y escóltala fuera del valle, hacia el este.",
	-- ["Ride on south-west to Shadowprey."] = "Sigue al suroeste hasta la Aldea Cazasombras.",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "Ve al sur desde {area:2405} hacia {area:607}. Los Exploradores, Vaqueros, Destructores, Cazavientos y Maleantes Maraudine (36-39) sueltan los {quest:93225}.",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "Vuelve al oeste cruzando el pantano. Los Escupevenenos Colmilloumbrío de las crestas al norte de Murohelecho sueltan las glándulas de veneno. Los Infiltradores de Theramore (35-36) se cuelan por los mismos bosques: usan sigilo, así que fíjate bien.",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "Ve al oeste hasta la torre de {npc:11863} en {area:2405}, en la costa noroeste.",
	-- ["Slitherblade coast"] = "Costa Filozante",
	-- ["South down the coast to Shadowprey: {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "Baja al sur por la costa hasta Cazasombras: {npc:11624} recoge la caja y te envía con ella a {area:602}; {npc:12340} recoge lo de las nagas.",
	-- ["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer."] = "Al sureste desde la mansión hasta {area:513}: {object:20925} está en el fondo del mar frente a los muelles del lado este de la isla. Entra y sal a nado y mantente lejos de los muelles y del pueblo: los guardias de Theramore son de nivel 53-57, y morir aquí supone una larga carrera de vuelta desde el Ángel de la Resurrección.",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "Los Filo Ardiente ocupan la fortaleza al noroeste de {area:2407}. Usa el {item:14523} sobre el {npc:11876} de la fortaleza para conseguir la {item:13542}.",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "Las arañas Niebla Negra pululan en la entrada de la cueva al noroeste de Murohelecho; todas sueltan ojos.",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "Las nagas Filozante ocupan la costa al norte de {area:2405}, hasta {area:598}. {npc:12369} guarda {quest:6027} en la punta norte.",
	-- ["The next guide takes you back to {zone:1434}."] = "La siguiente guía te lleva de vuelta a {zone:1434}.",
	-- ["West from the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "Ve al oeste desde la fortaleza hasta la costa de {area:598}: los Mirmidones Filozante, las nagas y las hechiceras ocupan la playa. Atráelos de uno en uno; las brujas del mar y los oráculos (34-36) lanzan hechizos a distancia.",
	-- ["West to Shadowprey."] = "Ve al oeste a la Aldea Cazasombras.",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "La caravana de {npc:11626} se detiene en el camino al borde de {area:602}. Escóltala al este, más allá del aquelarre; los demonios la atacan dos veces.",
	-- ["{npc:3391}: for {npc:4631} in {area:35}, on the first {area:35} stop of 40-50"] = "{npc:3391}: para {npc:4631} en {area:35}, en la primera parada en {area:35} de la guía 40-50",
	-- ["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983} espera en {area:2302}, al este del poblado. Síguelo hasta Reethe y mantenlo con vida en la pelea que se desata.",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395} y {npc:5412} están en el campamento justo al oeste del de {npc:11596}.",
	-- ["{npc:5395}: his {quest:1366}, from the same Maraudine"] = "{npc:5395}: su {quest:1366}, de los mismos Maraudine",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236}: Actitud rabiosa",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}: la guía anterior te vincula aquí, así que esto suele marcarse al instante",
}
