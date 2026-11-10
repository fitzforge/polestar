-- Spanish (Latin America) (esMX): the guide forever/alliance/03-darkshore (forever/alliance/03-darkshore.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Auberdine
	-- {npc:3644} Cerellean Whiteclaw · {npc:3649} Thundris Windweaver · {npc:3666} Wizbang Cranktoggle
	["The boat docks west of the village: {npc:3644} waits where the pier meets the shore. Go up to {npc:3649} at the north end of the village first, then down the main street to the inn. The flight master stands on the hill south of the inn. {npc:3666} stands upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}, en el muelle",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, en el extremo norte del pueblo",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}"] = "{npc:3649}: para {npc:1646} en {zone:1453}",
	["The WANTED poster outside the inn"] = "El cartel de SE BUSCA fuera de la posada",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn"] = "",
	-- {npc:10219} Gwennyth Bly'Leggonde · {zone:1438} Teldrassil
	["{npc:10219} (Night Elves have it from {zone:1438})"] = "",
	-- {npc:10216} Gubber Blump
	["{npc:10216}, on the pier"] = "",

	-- Step 3: Gubber Blump
	-- {npc:10216} Gubber Blump · {item:12238} Darkshore Grouper
	["Fishers only: {npc:10216} stands on the pier. His {item:12238} is fished from the pier itself."] = "",

	-- Step 4: The beach
	["The beach"] = "La playa",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Los Reptadores de marea ({npc:2232}) corretean por la orilla bajo el pueblo; {quest:983} está en la playa, justo al sur de los muelles. Los Trilladores de Costa Oscura ({npc:2185}) nadan en los bajíos. {object:175207} yace en la orilla, justo al sur del pueblo.",
	-- {item:12238} Darkshore Grouper
	["{item:12238}: fish from the pier"] = "{item:12238}: pesca desde el muelle",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg
	["Crawler Legs"] = "Patas de reptador",

	-- Step 5: Auberdine
	-- {quest:3524} Washed Ashore
	-- plural, as words: Beached Sea Turtles = {quest:4722} Beached Sea Turtle
	["{quest:3524}: the Beached Sea Turtles up the coast offer their quests only once it is handed in"] = "",

	-- Step 6: The skeletal turtle
	["The skeletal turtle"] = "La tortuga esquelética",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "",

	-- Step 7: Plagued bears
	["Plagued bears"] = "Osos apestados",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills just east of {area:442}. Use {quest:2139} on one and lead it back to him."] = "Los osos cardo rabiosos rondan las colinas justo al este de {area:442}. Usa {quest:2139} en uno y llévalo de vuelta con él.",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "",

	-- Step 8: Rabid Thistle Bear on the way
	-- {npc:2164} Rabid Thistle Bear
	["{npc:2164} on the way"] = "",

	-- Step 9: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "Osos y el campamento Bosque Negro",
	-- {area:442} Auberdine
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Kill Rabid Thistle Bears in the hills east of {area:442}, then walk up to the furbolg camp south-east of them: nothing to kill yet."] = "Mata osos cardo rabiosos en las colinas al este de {area:442} y luego sube al campamento fúrbolg al sureste de ellos: aún no hay que matar nada.",

	-- Step 10: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639} está en el borde norte de las ruinas. Altonatos malditos, Altonatos en pena y {npc:2178} las rondan; el fantasma de {npc:3667} camina entre ellos y la lechuza {npc:270196} vuela en círculos al este. Las dos tablillas están en las ruinas; {quest:4722} yace en la orilla al oeste de ellas.",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "Reliquias de Altonato",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "Lee {object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "Lee {object:17189}",

	-- Step 11: The red crystal
	["The red crystal"] = "El cristal rojo",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "Sube a las montañas al este de {area:447}; el {object:175524} está en una cornisa.",

	-- Step 13: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "Ve al norte por las colinas. {npc:3650} espera en las ruinas de {quest:954}; están llenas de grells salvajes y duendes viles, y los sátiros Deth'ryll ocupan el borde este. {quest:1001} está junto al camino al oeste de las ruinas; un {quest:4723} yace en la orilla de camino hacia él.",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "Pendientes grell",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}: sátiros Deth'ryll",

	-- Step 14: Auberdine
	["Fill the tube at the moonwell in the village"] = "Llena el tubo en el pozo de la luna del pueblo",

	-- Step 15: A Lesson to Learn
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Fly from {area:442} to {area:702} and take the portal up to {npc:4217} in the {area:1658}."] = "Vuela de {area:442} a {area:702} y toma el portal para subir con {npc:4217} en {area:1658}.",

	-- Step 18: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 19: Trial of the Lake
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {quest:29} Trial of the Lake · {area:442} Auberdine
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. {quest:29} runs on a timer: no teleport or Hearthstone until {npc:11799} has it. Then fly back to {area:442} from {area:2361}."] = "",
	-- {quest:6122} The Principal Source · {area:445} Cliffspring Falls
	["{quest:6122}: fill the sampler at {area:445}"] = "{quest:6122}: llena el muestreador en {area:445}",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, de un {object:177785} en el lago",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "En {area:2362}",
	-- {zone:1439} Darkshore · {zone:1436} Westfall
	["The half pendants lie in {zone:1439} and {zone:1436}: later on the route"] = "Los medios colgantes están en {zone:1439} y {zone:1436}: más adelante en la ruta",

	-- Step 20: Blackwood furbolgs
	["Blackwood furbolgs"] = "Fúrbolgs Bosque Negro",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "Los abrecaminos y soplavientos Bosque Negro ocupan el campamento al sureste de {area:442}.",

	-- Step 21: The Ancient Flame
	-- {object:16393} Ancient Flame
	["The {object:16393}"] = "{object:16393}",
	-- {area:447} Ameth'Aran
	["The flame burns in the south of {area:447}."] = "La llama arde en el sur de {area:447}.",

	-- Step 22: The red crystal
	["Back north-east into the mountains to the crystal."] = "Vuelve al noreste, a las montañas, hasta el cristal.",

	-- Step 23: Cliffspring Falls
	-- {area:456} Cliffspring River · {area:443} Ruins of Mathystra · {quest:954} Bashal'Aran
	["Follow the hills north to the {area:456} and up to the falls. Two more beached remains lie on the north shore: near the {area:443} and north of {quest:954}."] = "Sigue las colinas hacia el norte hasta {area:456} y sube a las cascadas. Hay dos restos varados más en la costa norte: cerca de {area:443} y al norte de {quest:954}.",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}, en la cascada",
	-- {item:15845} Filled Cliffspring Falls Sampler
	["{item:15845}: at the mouth of the cave by the falls"] = "{item:15845}: en la entrada de la cueva junto a las cascadas",
	-- {item:12237} Fine Crab Chunks · {npc:2233} Encrusted Tide Crawler · {npc:2235} Reef Crawler
	["{item:12237} from {npc:2233} and {npc:2235}, by this stop"] = "",

	-- Step 25: Auberdine
	-- {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell
	["{item:12347}: fill the {item:12346} at the {object:174795}"] = "",

	-- Step 26: Mist's Edge
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes; underwater"] = "",

	-- Step 27: The bay wrecks
	["The bay wrecks"] = "Los naufragios de la bahía",
	-- {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore.\nCareful: The murlocs inside the wrecks are close together and fast. They often swim through the hull walls and holes, so you will usually pull extra murlocs."] = "",
	-- {item:12191} Silver Dawning's Lockbox
	["{item:12191}; underwater"] = "",
	-- {item:12192} Mist Veil's Lockbox
	["{item:12192}; underwater"] = "",

	-- Step 29: Darkshore: kill these as you meet them
	-- {zone:1439} Darkshore
	["{zone:1439}: kill these as you meet them"] = "",
	-- {quest:954} Bashal'Aran · {quest:1002} Buzzbox 323
	["Moonstalkers prowl the hills between {quest:954} and the tower. {quest:1002} stands on the hill west of the tower."] = "Los Acechalunas merodean por las colinas entre {quest:954} y la torre. {quest:1002} está en la colina al oeste de la torre.",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "Colmillos de Acechalunas",

	-- Step 31: The Tower of Althalaxx
	-- {npc:3661} Balthule Shadowstrike · {zone:1440} Ashenvale
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["East of Buzzbox 323, {npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "",
	-- {item:5348} Worn Parchment
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{item:5348}: Dark Strand Fanatics"] = "{item:5348}: fanáticas de la Facción Oscura",

	-- Step 32: The cave and the Den Mother
	-- {npc:6788} Den Mother
	["The cave and the {npc:6788}"] = "La cueva y la {npc:6788}",
	-- {item:5270} Death Cap · {npc:6788} Den Mother
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls."] = "La cueva está al sur de las cascadas: los Boletos rudos ({item:5271}) crecen por toda ella y {item:5270}, al fondo. {npc:6788} tiene su guarida en las colinas al sur de las cascadas.",
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["Scaber Stalks; below ground"] = "",
	-- {item:5270} Death Cap
	["{item:5270}; below ground"] = "",

	-- Step 33: The northern Blackwood camp
	["The northern Blackwood camp"] = "",
	-- {area:456} Cliffspring River · {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell · {item:12355} Talisman of Corruption
	["The furbolg camp south of the {area:456} keeps its Nut, Fruit and Grain Stores by the bonfires. With a sample of each and the {item:12347} in your bags (the {item:12346} is filled at the {object:174795}), use the bowl by the bonfire closest to the river: it summons Xabraxxis, the satyr corruptor, and the {item:12355} lies in his Demon Bag."] = "",
	["By the bonfire closest to the river: summons Xabraxxis"] = "",
	-- {item:12355} Talisman of Corruption · {object:177624} Xabraxxis' Demon Bag
	["{item:12355}, in {object:177624}"] = "{item:12355}, en {object:177624}",

	-- Step 34: The cave and the Den Mother
	["Careful: If you attack one cub, the other cubs and often the mother join the fight, so expect to take on several at the same time."] = "",
	-- {npc:6788} Den Mother
	["{npc:6788}, below ground"] = "",

	-- Step 35: Auberdine
	-- {quest:948} Onu · {zone:1439} Darkshore
	["For {quest:948} at the Grove, on {zone:1439}'s southern loop after the trip east"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south"] = "De vuelta al sur",
	-- ["Back to {npc:11802}"] = "De vuelta con {npc:11802}",
	-- ["Back to {npc:11802} in {area:2361}, then fly to {area:702} (by way of {area:442})."] = "Vuelve con {npc:11802} en {area:2361} y luego vuela a {area:702} (pasando por {area:442}).",
	-- ["Boat to {zone:1453}"] = "Barco a {zone:1453}",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. Then fly back to {area:442} from {area:2361}."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}. Los Adornos de altar ({item:15877}) están en los contenedores del fondo de {area:656}, debajo de {area:2361}: lleva uno a {area:2362}, al noroeste, úsalo allí y habla con {npc:11799}. Luego vuela de vuelta a {area:442} desde {area:2361}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}; aprende allí la ruta de vuelo si no la tienes.",
	-- ["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "Escóltala fuera de la guja; la entrega se hace a Therysil en {zone:1440}",
	-- ["Fine Moonstalker Pelts"] = "Pelambres de Acechalunas refinadas",
	-- ["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore."] = "Sigue la costa al noreste hasta {area:443}. {quest:951} están entre las ruinas; las ocupan myrmidones, hechiceras y guerreros Escama Tormentosa, y las maestras de bestias Escama Tormentosa recorren la orilla.",
	-- ["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them."] = "Sigue la costa al noreste hasta {area:443}. {quest:951} están entre las ruinas; las ocupan myrmidones, hechiceras y guerreros Escama Tormentosa.",
	-- ["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}."] = "Sigue la costa hacia el sur más allá de {area:447}: un {quest:4728} yace en la orilla al oeste del Páramo de los Ancianos y otro más al sur, cerca de {area:450}.",
	-- ["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "Sigue la costa hacia el sur más allá de {area:447}: un {quest:4728} yace en la orilla al oeste del Páramo de los Ancianos y otro más al sur, cerca de {area:450}. Otros tres restos yacen más al suroeste entre oráculos Brumagris y cazamareas Brumagris (18-20): la guía los deja para la última vuelta, cuando estés más cerca de su nivel.",
	-- ["Follow the hills north to the {area:456} and up to the falls. Three more beached remains lie on the north shore: near the {area:443}, north of {quest:954} and west of {quest:954}."] = "Sigue las colinas hacia el norte hasta {area:456} y sube a las cascadas. Hay tres restos varados más en la costa norte: cerca de {area:443}, al norte de {quest:954} y al oeste de {quest:954}.",
	-- ["Follow the road north."] = "Sigue el camino al norte.",
	-- ["Follow the road south. {quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "Sigue el camino al sur. {quest:948} es el anciano del Páramo de los Ancianos; {npc:270269} y {npc:11218} duermen a su lado.",
	-- ["Grizzled Scalps"] = "Cueros cabelludos grisáceos",
	-- ["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "Los osos cardo grisáceos rondan por las colinas alrededor de la Arboleda; {quest:1003} está al oeste de ella, entre ellos.",
	-- ["Hearth to {area:442}"] = "Usa la Piedra de hogar para volver a {area:442}",
	-- ["Hearthstone on cooldown? Follow the coast road back south."] = "¿Piedra de hogar en tiempo de reutilización? Sigue el camino de la costa de vuelta al sur.",
	-- ["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "Los patriarcas Acechalunas merodean por el bosque alrededor de la guja. {object:10076} y {object:12666} están en el fondo del cráter; {npc:3584} está en su lado norte.",
	-- ["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "Los elfos de la noche vuelan de {area:442} a {area:702}; los Cielonatos toman el barco desde el muelle de {area:442} y aprenden allí la ruta de vuelo de la Aldea Rut'theran. Toma el portal para subir con {npc:4217} en {area:1658}.",
	-- ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins."] = "Ve al norte por las colinas. {npc:3650} espera en las ruinas de {quest:954}; están llenas de grells salvajes y duendes viles, y los sátiros Deth'ryll ocupan el borde este. {quest:1001} está junto al camino al oeste de las ruinas.",
	-- ["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "Solo si un discípulo o matón soltó {item:5352}: haz clic derecho en él",
	-- ["Read both tablets"] = "Lee ambas tablillas",
	-- ["Scaber Stalks"] = "Boletos rudos",
	-- ["She gives you the {item:15826}"] = "Ella te da el {item:15826}",
	-- ["Take the portal up to {npc:4217}, then fly back to {area:442} for the boat to {zone:1453}."] = "Toma el portal para subir con {npc:4217} y luego vuela de vuelta a {area:442} para tomar el barco a {zone:1453}.",
	-- ["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "Las flores de hongo lunar crecen en las cuevas de lechúcicos de las colinas justo al este de {area:442}; los lechúcicos de allí son irritables. {item:2449} requiere {skill:182}: los herboristas la recogen por todo {zone:1439}; los demás la traen de {zone:1453} ({npc:1313}) o de la casa de subastas.",
	-- ["The WANTED poster"] = "El cartel de SE BUSCA",
	-- ["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "El barco atraca al oeste del pueblo. El maestro de vuelo está en la colina al sur de la posada; los asignadores de misiones están repartidos por la calle principal.",
	-- ["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls; {object:177624} lies at the satyr camp north of her."] = "La cueva está al sur de las cascadas: los Boletos rudos ({item:5271}) crecen por toda ella y {item:5270}, al fondo. {npc:6788} tiene su guarida en las colinas al sur de las cascadas; {object:177624} está en el campamento sátiro al norte de ella.",
	-- ["The naga"] = "Los naga",
	-- ["The relics of the Barrow Dens"] = "Las reliquias del Túmulo de Tempestira",
	-- ["The southern beaches"] = "Las playas del sur",
	-- ["The {area:443}"] = "{area:443}",
	-- ["The {area:448}"] = "{area:448}",
	-- ["The {object:10076}"] = "{object:10076}",
	-- ["The {object:12666}"] = "{object:12666}",
	-- ["Thresher Eyes"] = "Ojos de trillador",
	-- ["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {quest:4723} lies on the shore just south of the village."] = "Los Reptadores de marea ({npc:2232}) corretean por la orilla bajo el pueblo; {quest:983} está en la playa, justo al sur de los muelles. Los Trilladores de Costa Oscura ({npc:2185}) nadan en los bajíos. {quest:4723} yace en la orilla, justo al sur del pueblo.",
	-- ["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore."] = "Hay dos naufragios en el fondo de la bahía al norte de {area:442}; cada uno tiene una caja fuerte. Los reptadores de arrecife y los reptadores de marea escamados recorren esta costa.",
	-- ["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil."] = "{area:450} está en la costa al sur de la playa de {npc:10323}. Protege al prospector mientras busca el fósil.",
	-- ["{item:12289}, on the beach west of the docks"] = "{item:12289}, en la playa al oeste de los muelles",
	-- ["{item:15851} and {item:2449}"] = "{item:15851} y {item:2449}",
	-- ["{item:15883}: the {object:177790} under the water off the north coast, west of the ruins"] = "{item:15883}: {object:177790}, bajo el agua frente a la costa norte, al oeste de las ruinas",
	-- ["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}: {object:177792}, bajo el agua frente a la costa norte, al oeste de las ruinas",
	-- ["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}: discípulos y matones Crepusculares",
	-- ["{npc:10216}, on the pier: only with {skill:356}"] = "{npc:10216}, en el muelle: solo con {skill:356}",
	-- ["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches south of {area:450}."] = "{npc:10323} acampa en la playa al oeste de la guja: mata a los múrlocs junto a la fogata; él llega en la tercera oleada con su perro. Hay tres restos varados en las playas al sur de {area:450}.",
	-- ["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches west and south-west of {area:450}."] = "{npc:10323} acampa en la playa al oeste de la guja: mata a los múrlocs junto a la fogata; él llega en la tercera oleada con su perro. Hay tres restos varados en las playas al oeste y al suroeste de {area:450}.",
	-- ["{npc:10323}'s beach"] = "La playa de {npc:10323}",
	-- ["{npc:11218}: his escort to {area:413} is done on the {zone:1440} leg"] = "{npc:11218}: su escolta hasta {area:413} se hace en el tramo de {zone:1440}",
	-- ["{npc:11802}: the welcome from Sheldras"] = "{npc:11802}: la bienvenida de Sheldras Árbol Lunar",
	-- ["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}: usa el {item:15826} en ellos; rondan por todo {zone:1439}",
	-- ["{npc:3616}, at the Grove"] = "{npc:3616}, en el Páramo de los Ancianos",
	-- ["{npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "{npc:3661} se esconde al pie de la torre entre las fanáticas de la Facción Oscura. Guarda su carta para Delgren el Purificador en {zone:1440}.",
	-- ["{npc:3666}, by the inn"] = "{npc:3666}, junto a la posada",
	-- ["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out."] = "{npc:3692} se esconde en las colinas al este de {area:449}. Ayúdalo a volver al camino; pelea mientras sale.",
	-- ["{npc:3694}: for {npc:3691} in {area:415}, on the later {zone:1440} leg"] = "{npc:3694}: para {npc:3691} en {area:415}, en el tramo posterior de {zone:1440}",
	-- ["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} se esconde en la islita frente a las ruinas. Las piezas de la llave las sueltan los zancudos del bosque gigantes (parte superior), los múrlocs Brumagris (parte central) y los reptadores de arrecife enfurecidos (parte inferior).",
	-- ["{npc:6667} hides on the little island off the ruins; Stormscale Beastmistresses walk the shore. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667} se esconde en la islita frente a las ruinas; las Stormscale Beastmistresses recorren la orilla. Las piezas de la llave las sueltan los zancudos del bosque gigantes (parte superior), los múrlocs Brumagris (parte central) y los reptadores de arrecife enfurecidos (parte inferior).",
	-- ["{quest:1003} stands west of the Grove."] = "{quest:1003} está al oeste del Páramo de los Ancianos.",
	-- ["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}: {npc:10219} la ofrece cuando hayas entregado los nueve restos varados",
	-- ["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (elfos de la noche) y {npc:272054} (Cielonato) esperan en el sur de {area:493}. Las tres reliquias están en {area:2363}, al este de ellos. Según informes de las primeras semanas, una reliquia no da botín mientras otro jugador la saquea: espera un momento y vuelve a intentarlo.",
}
