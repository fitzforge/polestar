-- Spanish (Latin America) (esMX): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aldrassil
	-- {area:256} Aldrassil · {area:188} Shadowglen
	["You start at the foot of {area:256}, the great tree of {area:188}."] = "Empiezas al pie de {area:256}, el gran árbol de {area:188}.",
	-- {npc:2077} Melithar Staghelm
	["{npc:2077}, by the path"] = "{npc:2077}, junto al sendero",
	-- {npc:1992} Tarindrella
	["{npc:1992}, south of the tree"] = "{npc:1992}, al sur del árbol",

	-- Step 2: Shadowglen: kill these as you meet them
	-- {area:188} Shadowglen
	["{area:188}: kill these as you meet them"] = "{area:188}: mata a estos según te los encuentres",
	-- {area:256} Aldrassil · {item:3297} Fel Moss
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Grells = {npc:1988} Grell · Gnarlpine Totems = {item:279082} Gnarlpine Totem
	["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "Los sables de la noche jóvenes y los jabalíes cardo jóvenes deambulan alrededor de {area:256}. Los grells llevan {item:3297} en el bosque al oeste del árbol, donde están los tótems de Tuercepinos.",

	-- Step 3: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "De vuelta en {area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}: un sello para {npc:3596}",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082}, en la rampa del árbol",
	-- {npc:3595} Shanda
	["{npc:3595}: in at the tree's front entrance and up the ramp; upstairs"] = "{npc:3595}: entra por la puerta principal del árbol y sube la rampa; arriba",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}: lanza {spell:1259799} y Fusión de las sombras, y luego entrégasela a {npc:3595}",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583}, al este del árbol",

	-- Step 4: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "Al norte, a {area:257}",
	-- {area:256} Aldrassil · {npc:1994} Githyiss the Vile · {npc:8584} Iverron
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:1994} sits deep inside. {npc:8584} waits in the trees west of the cave mouth."] = "Los sables de la noche sarnosos y los jabalíes cardo recorren el norte de {area:256}, de camino a la cueva. {npc:1994} está al fondo de ella. {npc:8584} espera entre los árboles al oeste de la entrada de la cueva.",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders; below ground"] = "Arañas Tejemadera; bajo tierra",

	-- Step 5: Aldrassil
	-- {area:256} Aldrassil · {npc:3593} Alyissia · {npc:3594} Frahun Shadewhisper · {npc:3595} Shanda · {npc:3596} Ayanna Everstride · {npc:3597} Mardant Strongoak
	["The trainers stand upstairs inside {area:256}, along the ramp that winds up the tree: {npc:3593} and {npc:3594} on the first level, {npc:3595} above them, {npc:3596} and {npc:3597} at the top. The arrow cannot tell the levels apart."] = "Los instructores están arriba dentro de {area:256}, a lo largo de la rampa que sube en espiral por el árbol: {npc:3593} y {npc:3594} en el primer nivel, {npc:3595} encima de ellos, {npc:3596} y {npc:3597} en la cima. La flecha no distingue los niveles.",
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer; inside"] = "{npc:3593}, la instructora de guerreros; adentro",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596}, la instructora de cazadores",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594}, el instructor de pícaros",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer: in at the tree's front entrance and up the ramp"] = "{npc:3595}, la instructora de sacerdotes: entra por la puerta principal del árbol y sube la rampa",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597}, el instructor de druidas en {area:256}",

	-- Step 6: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917} y el antídoto",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom · Grells = {npc:1988} Grell
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "{object:4406} están al fondo de {area:257}: toma el camino central y luego a la izquierda donde se divide, hasta la cornisa alta. Los grells sueltan los champiñones jacinto; los lirios alunados crecen junto a los estanques al norte de {area:256}.",
	-- plural, as words: Grells = {npc:1988} Grell
	["Grells"] = "Grells",

	-- Step 8: Shadowglen
	["Below ground"] = "Bajo tierra",
	-- {quest:97236} Fang of Githyiss
	["{quest:97236}; below ground"] = "{quest:97236}; bajo tierra",

	-- Step 9: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514}, en lo alto del árbol",

	-- Step 10: The moonwell
	["The moonwell"] = "El pozo de la luna",
	-- {area:256} Aldrassil
	["The moonwell sits north of {area:256}."] = "El pozo de la luna está al norte de {area:256}.",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "Usa {item:5185} en el pozo de la luna",

	-- Step 11: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "De vuelta a lo alto de {area:256}. {object:654846} está a su lado.",
	["Upstairs"] = "Arriba",
	-- {object:654846} Lost Journal
	["{object:654846}, upstairs"] = "{object:654846}, arriba",
	-- {npc:3595} Shanda · {area:256} Aldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar
	["{npc:3595}, the priest trainer, on the second level of {area:256} on the way down: {npc:3600} in {area:186} takes it"] = "{npc:3595}, la instructora de sacerdotes, en el segundo nivel de {area:256} al bajar: {npc:3600} en {area:186} la recibe",

	-- Step 12: Iverron's Antidote
	-- {npc:8583} Dirania Silvershine · {area:256} Aldrassil · {npc:8584} Iverron
	["Take the antidote from {npc:8583} at the foot of {area:256} only now, on the way down: it lasts five minutes. {npc:8584} waits north-west, by the cave: go straight on to him."] = "Toma el antídoto de {npc:8583}, al pie de {area:256}, recién ahora, de bajada: dura cinco minutos. {npc:8584} espera al noroeste, junto a la cueva: ve directo hacia él.",

	-- Step 13: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "Sal de {area:188} por el sendero al sureste de {area:256}: {npc:6780} está junto a él, donde baja hacia el camino a {area:186}.",

	-- Step 14: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "Sigue el camino al suroeste desde {area:188}. {npc:2150} está sentado junto a él, justo al este de {area:186}.",

	-- Step 15: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811}, junto a la fogata",

	-- Step 16: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {npc:6286} Zarrin · {skill:129} First Aid · {npc:6094} Byancie
	["With a profession learned, {npc:265811} also offers its Camping 101, which its trainer takes: alchemy and herbalism beside {npc:6286}, {skill:129} with {npc:6094} in the inn, skinning and leatherworking at the Maneweavers' camp on the road west."] = "Con una profesión aprendida, {npc:265811} también ofrece su Campamento 101, que recibe su instructor: alquimia y herboristería junto a {npc:6286}, {skill:129} con {npc:6094} en la posada, desuello y peletería en el campamento de los Tejecrín en el camino al oeste.",
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "/sit junto a la fogata de {npc:265811} hasta obtener {spell:1229451}",

	-- Step 17: Camping 101: Alchemy
	-- {npc:3603} Cyndra Kindwhisper · {skill:171} Alchemy
	["{npc:3603} takes it once your {skill:171} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:3603} la recibe cuando tu habilidad de {skill:171} llegue a 20: recolecta o fabrica hasta entonces; mientras tanto, la guía sigue.",
	-- {npc:265811} Lyreena Duskblade · {npc:3603} Cyndra Kindwhisper · {npc:6286} Zarrin
	["{npc:265811}: for {npc:3603}, beside {npc:6286}"] = "{npc:265811}: para {npc:3603}, junto a {npc:6286}",

	-- Step 18: Camping 101: Herbalism
	-- {npc:3604} Malorne Bladeleaf · {skill:182} Herbalism
	["{npc:3604} takes it once your {skill:182} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:3604} la recibe cuando tu habilidad de {skill:182} llegue a 20: recolecta o fabrica hasta entonces; mientras tanto, la guía sigue.",
	-- {npc:265811} Lyreena Duskblade · {npc:3604} Malorne Bladeleaf · {npc:6286} Zarrin
	["{npc:265811}: for {npc:3604}, beside {npc:6286}"] = "{npc:265811}: para {npc:3604}, junto a {npc:6286}",

	-- Step 19: Camping 101: First Aid
	-- {npc:6094} Byancie · {skill:129} First Aid
	["{npc:6094} takes it once your {skill:129} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:6094} la recibe cuando tu habilidad de {skill:129} llegue a 20: recolecta o fabrica hasta entonces; mientras tanto, la guía sigue.",
	-- {npc:265811} Lyreena Duskblade · {npc:6094} Byancie
	["{npc:265811}: for {npc:6094} in the inn"] = "{npc:265811}: para {npc:6094} en la posada",

	-- Step 20: Camping 101: Skinning
	-- {npc:6287} Radnaal Maneweaver · {skill:393} Skinning
	["{npc:6287} takes it once your {skill:393} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:6287} la recibe cuando tu habilidad de {skill:393} llegue a 20: recolecta o fabrica hasta entonces; mientras tanto, la guía sigue.",
	-- {npc:265811} Lyreena Duskblade · {npc:6287} Radnaal Maneweaver
	["{npc:265811}: for {npc:6287}, by the road west"] = "{npc:265811}: para {npc:6287}, junto al camino al oeste",

	-- Step 21: Camping 101: Leatherworking
	-- {npc:3605} Nadyia Maneweaver · {skill:165} Leatherworking
	["{npc:3605} takes it once your {skill:165} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "{npc:3605} la recibe cuando tu habilidad de {skill:165} llegue a 20: recolecta o fabrica hasta entonces; mientras tanto, la guía sigue.",
	-- {npc:265811} Lyreena Duskblade · {npc:3605} Nadyia Maneweaver
	["{npc:265811}: for {npc:3605}, by the road west"] = "{npc:265811}: para {npc:3605}, junto al camino al oeste",

	-- Step 22: Zarrin
	-- {npc:6286} Zarrin
	["{npc:6286}, south of the inn: Camping 101 asks you to learn it"] = "{npc:6286}, al sur de la posada: Campamento básico te pide aprenderla",

	-- Step 23: Cyndra Kindwhisper
	["talk to the trainer"] = "habla con el instructor",
	-- {npc:3603} Cyndra Kindwhisper · {npc:6286} Zarrin
	["{npc:3603}, beside {npc:6286}"] = "{npc:3603}, junto a {npc:6286}",

	-- Step 24: Malorne Bladeleaf
	-- {npc:3604} Malorne Bladeleaf · {npc:6286} Zarrin
	["{npc:3604}, beside {npc:6286}"] = "{npc:3604}, junto a {npc:6286}",

	-- Step 25: Byancie
	-- {npc:6094} Byancie
	["{npc:6094}, in the inn"] = "{npc:6094}, en la posada",

	-- Step 26: Dolanaar
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515}, al sur de la posada",
	-- {npc:3608} Aldia
	["{npc:3608}, upstairs"] = "{npc:3608}, arriba",
	-- {npc:3567} Tallonkai Swiftroot
	["{npc:3567}, upstairs"] = "{npc:3567}, arriba",
	-- {npc:3600} Laurna Morninglight
	["{npc:3600}, inside"] = "{npc:3600}, adentro",
	-- {npc:3600} Laurna Morninglight · {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth
	["{npc:3600}: heal {npc:12429} by {area:259}"] = "{npc:3600}: cura a {npc:12429} junto a {area:259}",

	-- Step 27: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151} patrulla el camino al oeste de la aldea: si no está en la flecha, sigue el camino hasta encontrarla.",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151}, en el camino al oeste de la aldea",

	-- Step 28: Teldrassil: kill these as you meet them
	-- {quest:940} Teldrassil
	["{quest:940}: kill these as you meet them"] = "{quest:940}: mata a estos según te los encuentres",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east; the lurkers also drop the recipe's spider legs. The moonwell is at the west edge of {area:260}."] = "Los sables de la noche, búhos estrígidos y acechadores Tejemadera recorren todo alrededor de {area:186} y a lo largo del camino al este; los acechadores también sueltan las patas de araña de la receta. El pozo de la luna está en el borde oeste de {area:260}.",
	["Nightsabers"] = "Sables de la noche",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "Rondadores Tejemadera",

	-- Step 29: Zenn Foulhoof
	-- {npc:2150} Zenn Foulhoof · {area:186} Dolanaar · {area:260} Starbreeze Village
	["{npc:2150} sits by the road just east of {area:186}, between {area:186} and {area:260}."] = "{npc:2150} está sentado junto al camino justo al este de {area:186}, entre {area:186} y {area:260}.",

	-- Step 30: Starbreeze Village
	-- {npc:2107} Gaerolas Talvethren · {object:126158} Tallonkai's Dresser
	["{npc:2107} stands upstairs in a house in the village, east of the moonwell: go up inside, the arrow cannot tell the floors apart. {object:126158} is in the house on the hill at the east end of the village."] = "{npc:2107} está arriba en una casa de la aldea, al este del pozo de la luna: sube por adentro, la flecha no distingue los pisos. {object:126158} está en la casa de la colina, en el extremo este de la aldea.",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "Usa {item:5619} en el pozo de la luna",
	-- {object:126158} Tallonkai's Dresser
	["{object:126158}; inside"] = "{object:126158}; adentro",

	-- Step 31: Lake Al'Ameth
	-- {npc:2150} Zenn Foulhoof · {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-west of Starbreeze, south of {npc:2150}. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "Al suroeste de Brisa Estelar, al sur de {npc:2150}. {npc:2080} cuida sus retoños en la orilla; los brotes de azotador y los arbolitos deambulan a su alrededor, y {quest:919} crecen entre ellos.",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}: {quest:922} en {zone:1457} la recibe",

	-- Step 32: Sentinel Shaya
	-- {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth · {area:186} Dolanaar · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12429} kneels wounded on the rocks at the north edge of {area:259}, on the walk back to {area:186}, with no quest mark over her. Cast {spell:613} (Rank 2) on her, then {spell:1243}: Rank 1 of {spell:613} does not count. She runs off once both land and is back in about 5 minutes."] = "{npc:12429} está arrodillada y herida en las rocas del borde norte de {area:259}, de camino de vuelta a {area:186}, sin marca de misión sobre ella. Lánzale {spell:613} (rango 2) y luego {spell:1243}: el rango 1 de {spell:613} no cuenta. Se va corriendo en cuanto recibe ambos y vuelve en unos 5 minutos.",
	-- {npc:12429} Sentinel Shaya
	["Heal and fortify {npc:12429}"] = "Cura y fortalece a {npc:12429}",

	-- Step 34: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "Entrada de {area:258}",

	-- Step 35: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038} espera dentro de la cueva, abajo o arriba en la cornisa; mantente a la derecha.",
	-- {npc:2038} Lord Melenas
	["{npc:2038}; below ground"] = "{npc:2038}; bajo tierra",

	-- Step 36: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "El camino a {zone:1457}",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "Los emboscadores Tuercepinos se esconden a lo largo del camino al oeste de {area:258}.",

	-- Step 37: Radnaal Maneweaver
	-- {npc:6287} Radnaal Maneweaver
	["{npc:6287}, camped beside the road before Shayla"] = "{npc:6287}, acampado junto al camino antes de Shayla",

	-- Step 38: Nadyia Maneweaver
	-- {npc:3605} Nadyia Maneweaver · {npc:6287} Radnaal Maneweaver
	["{npc:3605}, beside {npc:6287}"] = "{npc:3605}, junto a {npc:6287}",

	-- Step 39: Sentinel Shayla Nightbreeze
	-- {area:261} Gnarlpine Hold
	["West along the road toward the city. Shayla walks this stretch of road, from the arrow south-west to the bend at about 38,54 and back: if she isn't at the arrow, follow the road south-west. Every Gnarlpine furbolg drops fangs: the ambushers on this road, the barrow's and {area:261}'s all count."] = "Al oeste por el camino hacia la ciudad. Shayla recorre este tramo del camino, desde la flecha al suroeste hasta la curva en 38,54 aproximadamente, y de regreso: si no está en la flecha, sigue el camino al suroeste. Todos los fúrbolg Tuercepinos sueltan colmillos: cuentan los emboscadores de este camino, los del túmulo y los de {area:261}.",

	-- Step 40: Darnassus
	-- {quest:922} Rellian Greenspyre · {area:1658} Cenarion Enclave · {npc:7316} Sister Aquinne · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade · {item:279378} Lunar Pendant
	["Into the city through the gate. {quest:922} is just south of the {area:1658} at the north end, {npc:7316} in the west, {npc:7313} and {npc:8396} in the Temple of the Moon at the south end. On the way back out, use Dalia's {item:279378} at the bank and at the city gate; the other two owls wait for your last visit."] = "Entra a la ciudad por la puerta. {quest:922} está justo al sur de {area:1658}, en el extremo norte, {npc:7316} al oeste, {npc:7313} y {npc:8396} en el Templo de la Luna, en el extremo sur. Al salir, usa el {item:279378} de Dalia en el banco y en la puerta de la ciudad; los otros dos búhos esperan a tu última visita.",
	-- {npc:7313} Priestess A'moora
	["{npc:7313}, in the Temple of the Moon"] = "{npc:7313}, en el Templo de la Luna",
	-- {npc:8396} Sentinel Dalia Sunblade
	["{npc:8396}, beside her"] = "{npc:8396}, a su lado",
	-- {item:279378} Lunar Pendant
	["{item:279378}: the bank, on the way out"] = "{item:279378}: el banco, a la salida",
	["the city gate"] = "la puerta de la ciudad",

	-- Step 41: Ban'ethil Barrow Den's entrance
	-- {area:262} Ban'ethil Barrow Den
	["{area:262}'s entrance"] = "Entrada de {area:262}",

	-- Step 42: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	-- plural, as words: Gnarlpine Defenders = {npc:2010} Gnarlpine Defender
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms. Its furbolgs drop Shayla's fangs.\nCareful: the barrow's Gnarlpine Defenders, Augurs and Shamans (7-9) stand in threes in the narrow tunnels: pull each group back toward the entrance before you go deeper."] = "El túmulo está al sur del camino. {npc:275744} está retenida adentro, {npc:7317} duerme en lo más hondo, y los cuatro cofres de reliquias están en las salas de abajo. Sus fúrbolgs sueltan los colmillos de Shayla.\nCuidado: los defensores, augures y chamanes Tuercepinos (7-9) del túmulo están en grupos de tres en los túneles estrechos: atrae a cada grupo hacia la entrada antes de avanzar más.",
	-- {item:5220} Gnarlpine Fang
	["{item:5220}: any Gnarlpine furbolg"] = "{item:5220}: cualquier fúrbolg Tuercepinos",
	-- {npc:7317} Oben Rageclaw
	["{npc:7317}, below ground"] = "{npc:7317}, bajo tierra",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "Chamanes Tuercepinos",
	-- {npc:7318} Rageclaw · {area:736} Ban'ethil Hollow
	["{npc:7318}, in the den; walks around {area:736}: look inside the circle on the map"] = "{npc:7318}, en la guarida; recorre {area:736}: busca dentro del círculo del mapa",

	-- Step 43: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "Escolta a {npc:275744} fuera del túmulo; {npc:2081} en {area:186} recibe el informe.",
	["Walk Lynessa out and keep her alive"] = "Saca a Lynessa y mantenla con vida",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736}, fuera del túmulo",

	-- Step 44: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "{area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "Al suroeste del túmulo. El pozo de la luna está junto a las pozas.",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "Usa {item:5621} en el pozo de la luna",

	-- Step 45: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	["South of the pools. The {object:6751} grows by the Hold; the furbolgs around it drop the rest of the fangs."] = "Al sur de las pozas. {object:6751} crece junto al Bastión; los fúrbolgs de alrededor sueltan el resto de los colmillos.",

	-- Step 47: Seek Redemption!
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {npc:7234} Ferocitas the Dream Eater
	-- plural, as words: Fel Cones = {object:1673} Fel Cone
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}: pick them up on the road east and hand them to {npc:2150} on the way to {npc:7234}."] = "Las piñas viles están bajo los árboles por todo {area:186} y alrededor de {npc:2150}: recógelas por el camino al este y dáselas a {npc:2150} de camino a {npc:7234}.",

	-- Step 48: Ferocitas the Dream Eater
	-- {npc:7234} Ferocitas the Dream Eater · {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and {npc:7234} camp north-east of {area:260}. {npc:7234} drops the {item:8049}: open it for the jewel.\nCareful: {npc:7234} waits near the camp fire with mystics around him, so pulling him without adds is hard."] = "Los místicos Tuercepinos y {npc:7234} acampan al noreste de {area:260}. {npc:7234} suelta {item:8049}: ábrelo para sacar la joya.\nCuidado: {npc:7234} espera junto a la hoguera del campamento rodeado de místicos, así que es difícil atraerlo sin que se sumen otros.",
	-- {item:8049} Gnarlpine Necklace · {npc:7234} Ferocitas the Dream Eater
	["{item:8049}, from {npc:7234}"] = "{item:8049}, de {npc:7234}",

	-- Step 49: Dolanaar
	-- {area:264} Oracle Glade · {area:186} Dolanaar · {npc:3567} Tallonkai Swiftroot
	["The road west to the {area:264} runs through {area:186}: hand {npc:3567} the jewel on the way."] = "El camino al oeste hasta {area:264} pasa por {area:186}: dale la joya a {npc:3567} por el camino.",
	-- {npc:3567} Tallonkai Swiftroot · {quest:932} Twisted Hatred · {npc:272116} Xethorr the Wicked · {area:264} Oracle Glade
	-- plural, as words: Befouled Webwoods = {npc:272096} Befouled Webwood
	["{npc:3567}: {quest:932}'s Befouled Webwoods and the elite {npc:272116}'s moss, on the walk to the {area:264}"] = "{npc:3567}: las Tejemadera corrompidas de {quest:932} y el musgo del élite {npc:272116}, de camino a {area:264}",

	-- Step 50: Befouled Webwoods
	-- plural, as words: Befouled Webwoods = {npc:272096} Befouled Webwood
	["Befouled Webwoods"] = "Tejemadera corrompidas",
	-- {area:264} Oracle Glade · {npc:272116} Xethorr the Wicked · {item:281023} Mature Fel Moss
	-- plural, as words: Befouled Webwoods = {npc:272096} Befouled Webwood
	["North-west of Dolanaar, on the way to the {area:264}, Befouled Webwoods creep through the woods; {npc:272116} prowls at their east edge and carries the {item:281023}.\n{npc:272116} is elite (level 12): grouping up is advised. Clear the webwoods around him first and pull him on his own."] = "Al noroeste de Dolanaar, de camino a {area:264}, las Tejemadera corrompidas se arrastran por el bosque; {npc:272116} merodea por su borde este y lleva {item:281023}.\n{npc:272116} es élite (nivel 12): se recomienda ir en grupo. Primero limpia las Tejemadera a su alrededor y atráelo solo.",

	-- Step 51: The Wellspring River
	-- {area:265} Wellspring River
	["The {area:265}"] = "{area:265}",
	-- {area:265} Wellspring River
	-- plural, as words: Mossy Tumors = {item:5170} Mossy Tumor
	["West from the webwoods to the {area:265}, then north along it to the glade: the timberlings along its banks drop the Mossy Tumors."] = "Al oeste desde las Tejemadera hasta {area:265}, y luego al norte a lo largo de él hasta el claro: los brezomaderas de sus orillas sueltan los tumores musgosos.",
	-- {item:5170} Mossy Tumor
	["{item:5170}: timberlings"] = "{item:5170}: arbolitos",

	-- Step 52: Oracle Glade
	-- {object:6752} Strange Fronded Plant
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "El pozo de la luna está en medio del claro. {object:6752} crece en su extremo norte.",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519}, junto al pozo de la luna",
	-- {item:18152} Amethyst Phial
	["Use the {item:18152} at the moonwell"] = "Usa {item:18152} en el pozo de la luna",

	-- Step 53: Bloodfeather harpies
	["Bloodfeather harpies"] = "Arpías Sangrepluma",
	-- {quest:938} Mist
	["The Bloodfeather harpies nest on the slopes west and north of the glade. {quest:938}, an injured sabercat, lies by the glade's west wall among them: lead her back to Sentinel Arynia at the moonwell before her time runs out.\nCareful: The harpies stand packed together, so extra ones often join a fight. Casters are mixed in among them."] = "Las arpías Plumasangre anidan en las laderas al oeste y al norte del claro. {quest:938}, una felina herida, yace junto a la pared oeste del claro, entre ellas: llévala de vuelta con la centinela Arynia, en el pozo de la luna, antes de que se acabe el tiempo.\nCuidado: Las arpías están muy juntas, así que muchas veces se suman otras a la pelea. Hay lanzadoras de hechizos mezcladas entre ellas.",
	-- {quest:938} Mist
	["{quest:938}, by the west wall"] = "{quest:938}, junto a la pared oeste",
	-- {quest:938} Mist
	["Lead {quest:938} to the moonwell"] = "Lleva a {quest:938} al pozo de la luna",

	-- Step 54: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "De vuelta al pozo de la luna.",

	-- Step 55: The named harpies
	["The named harpies"] = "Las arpías con nombre",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa
	["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034} y {npc:272044} vuelan justo al oeste del pozo de la luna; {npc:272046}, más al norte.",

	-- Step 56: Lady Sathrah
	-- {object:6752} Strange Fronded Plant · {npc:272046} Witchmother Arysa · {area:266} Wellspring Lake · {npc:7319} Lady Sathrah
	["The {object:6752} grows at the glade's north end, on the way: then north of {npc:272046}, along the island's northern edge by {area:266}, {npc:7319}, a level 12 spider, lurks."] = "{object:6752} crece en el extremo norte del claro, por el camino: luego, al norte de {npc:272046}, a lo largo del borde norte de la isla junto a {area:266}, acecha {npc:7319}, una araña de nivel 12.",

	-- Step 57: Sentinel Arynia again
	["Sentinel Arynia again"] = "Otra vez la centinela Arynia",
	-- {object:673378} Oracle Tree Bark
	["{object:673378}, just west of the moonwell"] = "{object:673378}, justo al oeste del pozo de la luna",
	-- {object:673378} Oracle Tree Bark · {zone:1457} Darnassus
	["the same {object:673378}: Fandral in {zone:1457} takes it"] = "la misma {object:673378}: la recibe Fandral en {zone:1457}",

	-- Step 58: Sentinel Shayla Nightbreeze
	-- {area:186} Dolanaar
	["South from the glade toward Ursal: Shayla walks the road west of {area:186}, from where the path down from the glade meets it south-west to the bend at about 38,54 and back."] = "Al sur desde el claro hacia Ursal: Shayla recorre el camino al oeste de {area:186}, desde donde el sendero que baja del claro se une a él, al suroeste hasta la curva en 38,54 aproximadamente, y de regreso.",

	-- Step 59: Ursal the Mauler
	-- {area:478} Pools of Arlithrien
	["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}.\nCareful: Gnarlpine of roughly level 9-12 crowd the camp and sit close together, so it is easy to pull several at once. Take them on singly before you engage Ursal."] = "Camina al sur por el lado oeste de la isla. Ursal merodea por el extremo sur, debajo de {area:478}.\nCuidado: Los Tuercepinos, de nivel 9-12 más o menos, llenan el campamento y están muy juntos, así que es fácil atraer a varios a la vez. Enfréntalos de a uno antes de ir por Ursal.",

	-- Step 60: Dolanaar
	-- {area:186} Dolanaar
	["North-east from Ursal's den, back to {area:186}."] = "Al noreste desde la guarida de Ursal, de vuelta a {area:186}.",
	-- {npc:6094} Byancie
	["{npc:6094}, inside"] = "{npc:6094}, adentro",
	-- {item:3371} Empty Vial · {npc:3614} Narret Shadowgrove · {npc:6094} Byancie
	["{item:3371} from {npc:3614}, beside {npc:6094}"] = "{item:3371} de {npc:3614}, junto a {npc:6094}",
	-- {npc:3600} Laurna Morninglight · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:3600}: {npc:11401} in {zone:1457} takes it"] = "{npc:3600}: {npc:11401} en {zone:1457} la recibe",
	-- {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr · {npc:6094} Byancie
	["{item:159} from {npc:6736}, for {npc:6094}"] = "{item:159} de {npc:6736}, para {npc:6094}",
	-- {zone:1457} Darnassus
	["Fandral in {zone:1457} takes it"] = "Fandral en {zone:1457} la recibe",
	-- {npc:3602} Kal · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:3602}: {npc:4217} in {zone:1457} takes it"] = "{npc:3602}: {npc:4217} en {zone:1457} la recibe",
	-- {npc:3598} Kyra Windblade · {quest:1684} Elanaria · {zone:1457} Darnassus
	["{npc:3598}, the warrior trainer: {quest:1684} in {zone:1457} takes it"] = "{npc:3598}, la instructora de guerreros: la recibe {quest:1684} en {zone:1457}",

	-- Step 61: Tallonkai Swiftroot
	-- {npc:3567} Tallonkai Swiftroot · {npc:272116} Xethorr the Wicked
	["Back upstairs to {npc:3567} with the webwoods done and {npc:272116}'s moss."] = "Sube de vuelta con {npc:3567} con las tejemaderas listas y el musgo de {npc:272116}.",

	-- Step 62: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "Al sureste de Dolanaar, con {npc:2080}. Los retoños de azotador ({npc:275703}) deambulan a su alrededor en la orilla.",

	-- Step 63: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "{area:186} otra vez",
	-- {npc:6094} Byancie · {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr
	["{npc:6094} takes a {item:159} with the fronds and the vial: if you drank yours, buy another from {npc:6736} in this inn before you hand in."] = "{npc:6094} recibe un {item:159} con las frondas y el vial: si te bebiste el tuyo, compra otro a {npc:6736} en esta posada antes de entregar.",

	-- Step 64: Taming the Beast
	-- {item:15908} Taming Rod · {area:186} Dolanaar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker · Nightsaber Stalkers = {npc:2043} Nightsaber Stalker · Strigid Screechers = {npc:1996} Strigid Screecher
	["Each of Dazalar's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Cada misión de Dazalar te da una {item:15908}: úsala en la bestia que nombra y luego llévale la vara a {area:186}. Los rondadores Tejemadera ({npc:1998}) se arrastran alrededor de la aldea; los acechadores sable de la noche ({npc:2043}) y los estridadores estrígidos ({npc:1996}) deambulan por el bosque al sur.",
	-- {npc:1998} Webwood Lurker · {item:15908} Taming Rod
	["{npc:1998}: tame it with the {item:15908}"] = "{npc:1998}: domestícalo con la {item:15908}",
	-- {npc:2043} Nightsaber Stalker · {item:15908} Taming Rod
	["{npc:2043}: tame it with the {item:15908}"] = "{npc:2043}: domestícalo con la {item:15908}",
	-- {npc:1996} Strigid Screecher · {item:15908} Taming Rod
	["{npc:1996}: tame it with the {item:15908}"] = "{npc:1996}: domestícalo con la {item:15908}",
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457} takes it"] = "{npc:4146} en {zone:1457} la recibe",

	-- Step 65: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "Toma otra vez el camino al noroeste desde {area:186}; ella sigue tendida a su lado, de camino a {zone:1457}.",

	-- Step 66: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "A {zone:1457}",
	-- {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace
	["{npc:4241}, on the {area:1659} just inside the city"] = "{npc:4241}, en {area:1659}, justo al entrar a la ciudad",

	-- Step 68: Elanaria
	-- {quest:1684} Elanaria · {area:1660} Warrior's Terrace
	["{quest:1684} stands on the {area:1660}, just inside the city."] = "{quest:1684} está en {area:1660}, justo al entrar a la ciudad.",

	-- Step 69: Vorlus Vilehoof
	-- {quest:1683} Vorlus Vilehoof · {area:736} Ban'ethil Hollow · {quest:1684} Elanaria
	["Back out of the city gate and east along the road: {quest:1683} stands south of it, by {area:736}. Bring his horn back to {quest:1684}."] = "Sal otra vez por la puerta de la ciudad y ve al este por el camino: {quest:1683} está al sur, junto a {area:736}. Llévale su cuerno a {quest:1684}.",

	-- Step 71: Darnassus
	-- {zone:1457} Darnassus · {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace · {area:3425} Cenarion Hold · {npc:4241} Mydrannul · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7313} Priestess A'moora · {npc:8396} Sentinel Dalia Sunblade
	["Follow the road west into {zone:1457} and use the {item:279378} at the inn on the {area:1659} and at the tunnel mouth below {area:3425} for the last two owls. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092}, {npc:7999}, {npc:7313} and {npc:8396} are in the Temple of the Moon at the south end."] = "Sigue el camino al oeste hasta {zone:1457} y usa {item:279378} en la posada de {area:1659} y en la boca del túnel bajo {area:3425} para los dos últimos búhos. {npc:4241} está en {area:1659}, justo al entrar a la ciudad. {npc:3516} está en {area:1658}, en el extremo norte de la ciudad, y {quest:922} justo al sur; {npc:4092}, {npc:7999}, {npc:7313} y {npc:8396} están en el Templo de la Luna, en el extremo sur.",
	-- {npc:4088} Elanaria · {area:1660} Warrior's Terrace · {spell:71} Defensive Stance
	["{npc:4088}, on the {area:1660}: {spell:71}"] = "{npc:4088}, en {area:1660}: {spell:71}",
	-- {item:279378} Lunar Pendant · {area:1659} Craftsmen's Terrace
	["{item:279378}: the inn on the {area:1659}"] = "{item:279378}: la posada de {area:1659}",

	-- Step 72: Warrior trainer
	["Warrior trainer"] = "Instructor de guerreros",
	-- {area:1660} Warrior's Terrace · {quest:1684} Elanaria
	["Level 12 spells while you're on the {area:1660}: the warrior trainers stand beside {quest:1684}."] = "Hechizos de nivel 12 mientras estás en {area:1660}: los instructores de guerreros están junto a {quest:1684}.",

	-- Step 74: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516}, en {area:1658}",

	-- Step 75: Cenarion Enclave
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146}, en {area:1658}: {spell:5149}",

	-- Step 76: Cenarion Enclave trainers
	-- {area:1658} Cenarion Enclave
	["{area:1658} trainers"] = "Instructores de {area:1658}",
	-- {area:1658} Cenarion Enclave
	["Level 12 spells while you're in the {area:1658}: the hunter, rogue and druid trainers all stand in it."] = "Hechizos de nivel 12 mientras estás en {area:1658}: los instructores de cazadores, pícaros y druidas están todos ahí.",

	-- Step 78: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217}, en {area:1658}",
	-- {area:3425} Cenarion Hold
	["the tunnel mouth below {area:3425}, on the way south"] = "la boca del túnel bajo {area:3425}, de camino al sur",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092}, en el Templo de la Luna",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999}, encima de {npc:4092}",
	-- {quest:2520} Sathrah's Sacrifice
	["{quest:2520}, standing in the temple's central fountain"] = "{quest:2520}, parado en la fuente central del templo",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401}, en el Templo de la Luna: Fragmentos estelares",

	-- Step 79: Priest trainer
	["Priest trainer"] = "Instructor de sacerdotes",
	-- {npc:11401} Priestess Alathea
	["Level 12 spells while you're in the Temple of the Moon: the priest trainers stand beside {npc:11401}."] = "Hechizos de nivel 12 mientras estás en el Templo de la Luna: los instructores de sacerdotes están junto a {npc:11401}.",

	-- Step 80: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Ya que estás aquí: aprende Bastones con {npc:11866} ({area:1660}, 10 de plata); en un cazador, el arma cuerpo a cuerpo vale sobre todo por sus estadísticas, y las de dos manos son las que más tienen.",

	-- Step 81: Ilyenia Moonfire
	-- {npc:11866} Ilyenia Moonfire · {area:1660} Warrior's Terrace
	["While you're here: learn Staves from {npc:11866} ({area:1660}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Ya que estás aquí: aprende Bastones con {npc:11866} ({area:1660}, 10 de plata); un bastón tiene más estadísticas de hechizo que un arma de una mano mientras subes de nivel.",

	-- Step 82: Portal to Teldrassil
	-- {quest:940} Teldrassil
	["Portal to {quest:940}"] = "Portal a {quest:940}",

	-- Step 83: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine · {area:442} Auberdine · {npc:4200} Laird
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs. Once you have {quest:6342}, talk to {npc:3838} again and choose the flight to {area:442}: it is free and lands beside {npc:4200}. If the flight map opens instead, close it and talk to him again holding Shift."] = "Toma el portal de bajada a {area:702}. {npc:10118} está en el muelle, {npc:3838} junto a los hipogrifos. Cuando tengas {quest:6342}, vuelve a hablar con {npc:3838} y elige el vuelo a {area:442}: es gratis y aterriza junto a {npc:4200}. Si se abre el mapa de vuelo, ciérralo y vuelve a hablarle manteniendo Mayús.",
	-- {npc:3838} Vesprystus · {quest:6342} Flight to Auberdine
	["talk to {npc:3838} again: free with {quest:6342}"] = "vuelve a hablar con {npc:3838}: gratis con {quest:6342}",

	-- Step 84: Auberdine
	-- {npc:3841} Caylais Moonfeather · {npc:4200} Laird
	["Learn the flight path from {npc:3841} where you land. {npc:4200}'s fish stall is just north of her, by the docks.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "Aprende la ruta de vuelo con {npc:3841} donde aterrizas. El puesto de pescado de {npc:4200} está justo al norte de ella, junto a los muelles.\nEl barco atraca al oeste de la aldea. El maestro de vuelo está en la colina al sur de la posada; los que dan misiones están repartidos por la calle principal.",
	["The WANTED poster outside the inn"] = "El cartel de SE BUSCA fuera de la posada",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart"] = "{npc:3666}, arriba en la posada: sube por la escalera de adentro, la flecha no distingue los pisos",

	-- Step 85: Return to Nessa
	-- {area:702} Rut'theran Village · {npc:3841} Caylais Moonfeather · {item:16263} Laird's Response · {npc:10118} Nessa Shadowsong · {area:442} Auberdine
	["Fly back to {area:702} from {npc:3841}, hand {item:16263} to {npc:10118} on the dock, then fly back to {area:442}."] = "Vuela de vuelta a {area:702} con {npc:3841}, dale {item:16263} a {npc:10118} en el muelle y luego vuela de vuelta a {area:442}.",

	-- Step 86: The Long Wash
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "Los Reptadores de marea ({npc:2232}) corretean por la orilla bajo el pueblo; {quest:983} está en la playa, justo al sur de los muelles. Los Trilladores de Costa Oscura ({npc:2185}) nadan en los bajíos. {object:175207} yace en la orilla, justo al sur del pueblo.",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "Patas de reptador: los reptadores de la marea",

	-- Step 87: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}, en el extremo norte del pueblo",

	-- Step 88: Gubber Blump
	-- {npc:10216} Gubber Blump · {item:12238} Darkshore Grouper
	["Fishers only: {npc:10216} stands on the pier. His {item:12238} is fished from the pier itself."] = "Solo pescadores: {npc:10216} está en el muelle. Su {item:12238} se pesca desde el propio muelle.",
	-- {npc:10216} Gubber Blump
	["{npc:10216}, on the pier"] = "{npc:10216}, en el muelle",

	-- Step 89: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Lanza {spell:18960}. {npc:11802} está en {area:2361}; {quest:5929} está en el bosque al noroeste. Luego {npc:11800}, en {area:2361}, lleva a los druidas directo a {area:702}, sin necesidad de ruta de vuelo. {npc:11802} está en el piso de arriba de su edificio: sube por adentro, la flecha no distingue los pisos.",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Habla con {quest:5929}",

	-- Step 90: Back to Darnassus
	-- {npc:10118} Nessa Shadowsong · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:10118} stands on the Rut'theran dock where you land. Then take the portal up to {npc:4217} in the {area:1658}."] = "{npc:10118} está en el muelle de Rut'theran, donde aterrizas. Luego toma el portal de subida hasta {npc:4217}, en {area:1658}.",

	-- Step 93: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Baja de vuelta a {area:702} y vuela a {area:442}. {object:177525} está en las colinas justo al este del pueblo: usa {item:15208} allí, derrota a Garraluna y habla con {npc:12144}.",

	-- Step 94: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442}."] = "Vuela a {area:702} una vez más y toma el portal de subida hasta {npc:4217}, luego vuela de vuelta a {area:442}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {zone:1453}"] = "Barco a {zone:1453}",
	-- ["Each of {npc:3601}'s quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Cada misión de {npc:3601} te da una {item:15908}: úsala en la bestia que nombra y luego llévale la vara a {area:186}. Los rondadores Tejemadera se arrastran alrededor de la aldea; los acechadores sable de la noche y los estridadores estrígidos deambulan por el bosque al sur.",
	-- ["East to {area:260}"] = "Al este, a {area:260}",
	-- ["Fel Cones lie under the trees all around {area:186} and {npc:2150}. Nightsabers and Webwood Lurkers keep roaming the road east. {object:126158} is in the house on the hill at the east end of the village."] = "Las bellotas viles están bajo los árboles por todo {area:186} y alrededor de {npc:2150}. Los sables de la noche y los rondadores Tejemadera siguen deambulando por el camino al este. {object:126158} está en la casa de la colina, en el extremo este de la aldea.",
	-- ["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442} for the boat."] = "Vuela a {area:702} una vez más y toma el portal para subir con {npc:4217}; luego vuela de vuelta a {area:442} para el barco.",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "Sigue el camino al suroeste desde {area:188} hasta {area:186}.",
	-- ["Follow the road west into {zone:1457}. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092} and {npc:7999} are in the Temple of the Moon at the south end. {npc:7316} is in the west of the city, on the way to the pink portal down to Rut'theran."] = "Sigue el camino al oeste hacia {zone:1457}. {npc:4241} está en {area:1659}, justo al entrar en la ciudad. {npc:3516} está en {area:1658}, en el extremo norte de la ciudad, y {quest:922} justo al sur; {npc:4092} y {npc:7999} están en el Templo de la Luna, en el extremo sur. {npc:7316} está en el oeste de la ciudad, de camino al portal rosa que baja a Rut'theran.",
	-- ["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "Desde el puerto entra en {object:2100}. {npc:5480} entrena a los guerreros allí; {npc:6089} y {npc:6090} están juntos junto a {object:2152}. {npc:6090} pelea contigo por su jarra.",
	-- ["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "Desde {area:17203}, cabalga por las puertas de la ciudad hacia {zone:1429} y sigue el camino al oeste hasta {zone:1436}.",
	-- ["Gnarlpine Mystics and Ferocitas camp north-east of {area:260}. Ferocitas drops the {item:8049}: open it for the jewel."] = "Los místicos Tuercepinos y Ferocitas acampan al noreste de {area:260}. Ferocitas suelta {item:8049}: ábrelo para obtener la joya.",
	-- ["Hearth to {area:186}"] = "Usa la piedra de hogar para ir a {area:186}",
	-- ["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "Consigue la ruta de vuelo de {area:442} en la colina al sur de la posada y luego lanza {spell:18960}. {npc:11802} está en {area:2361}; {quest:5929} está en el bosque al noroeste. Consigue la ruta de vuelo de {area:493} en {area:2361} y vuela a {area:702} (pasando por {area:442}).",
	-- ["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:8584} waits in the trees west of the cave mouth; {npc:1994} sits deep inside."] = "Los sables de la noche sarnosos y los jabalíes cardo deambulan al norte de {area:256}, de camino a la cueva. {npc:8584} espera entre los árboles al oeste de la entrada de la cueva; {npc:1994} está en lo profundo.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "Los sables de la noche, las lechuzas estrígidas y los rondadores Tejemadera viven a lo largo del camino al este. El pozo de la luna está en el borde oeste de {area:260}.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east. The moonwell is at the west edge of {area:260}."] = "Los sables de la noche, las lechuzas estrígidas y los rondadores Tejemadera rondan por todo {area:186} y a lo largo del camino al este. El pozo de la luna está en el borde oeste de {area:260}.",
	-- ["South of Zenn. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "Al sur de Zenn. {npc:2080} cuida sus brotes en la orilla; los retoños de azotador y los brezomaderas deambulan a su alrededor, y {quest:919} crecen entre ellos.",
	-- ["South of the pools. The {object:6751} grows by the Hold."] = "Al sur de las pozas. {object:6751} crece junto a las Tierras de los Tuercepinos.",
	-- ["Speak with {npc:6286}, south of the inn"] = "Habla con {npc:6286}, al sur de la posada",
	-- ["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "Toma el portal para bajar a {area:702}. {npc:10118} está en el muelle; {npc:3838}, junto a los hipogrifos.",
	-- ["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "Toma el portal para subir desde {area:702} con {npc:4217} en {area:1658}.",
	-- ["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "Toma el camino al noroeste desde {area:186} hacia {area:264}; ella yace herida a su lado.",
	-- ["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "Las arpías Sangrepluma anidan en las laderas al oeste y al norte del claro.",
	-- ["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms."] = "El túmulo está al sur del camino. {npc:275744} está retenida dentro, {npc:7317} duerme en sus profundidades y los cuatro cofres de reliquias están en las salas inferiores.",
	-- ["The moonwell and {npc:8584}"] = "El pozo de la luna y {npc:8584}",
	-- ["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "El pozo de la luna está al norte de {area:256}; {npc:8584} está un poco más al noroeste. {quest:3522} dura cinco minutos: llena el vial y ve directo con él.",
	-- ["The {area:264}"] = "{area:264}",
	-- ["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "Camina al sur por el lado oeste de la isla. Ursal merodea por el extremo sur, bajo {area:478}.",
	-- ["Webwood Spiders"] = "Arañas Tejemadera",
	-- ["West along the road from {area:186}, before the turn north to the glade: Shayla walks the road from the arrow south-west to the bend at about 38,54 and back."] = "Al oeste por el camino desde {area:186}, antes del desvío al norte hacia el claro: Shayla recorre el camino desde la flecha al suroeste hasta la curva en 38,54 aproximadamente, y de regreso.",
	-- ["{area:186} quests"] = "Misiones de {area:186}",
	-- ["{npc:11401}, in the Temple of the Moon: {spell:10797}"] = "{npc:11401}, en el templo de la Luna: {spell:10797}",
	-- ["{npc:2150} sits by the road just east of {area:186}, on the way to {area:260}."] = "{npc:2150} está sentado junto al camino justo al este de {area:186}, de camino a {area:260}.",
	-- ["{npc:2150}, on the way back"] = "{npc:2150}, a la vuelta",
	-- ["{npc:265811}, alchemists: for {npc:3603}"] = "{npc:265811}, alquimistas: para {npc:3603}",
	-- ["{npc:265811}, herbalists: for {npc:3604}"] = "{npc:265811}, herboristas: para {npc:3604}",
	-- ["{npc:265811}, leatherworkers: for {npc:3605}"] = "{npc:265811}, peleteros: para {npc:3605}",
	-- ["{npc:265811}, skinners: for {npc:6287}"] = "{npc:265811}, desolladores: para {npc:6287}",
	-- ["{npc:265811}, {skill:129}: for {npc:6094}"] = "{npc:265811}, {skill:129}: para {npc:6094}",
	-- ["{npc:3567}, back in {area:186}"] = "{npc:3567}, de vuelta en {area:186}",
	-- ["{npc:3593}, the warrior trainer"] = "{npc:3593}, la instructora de guerreros",
	-- ["{npc:3595}, inside the tree"] = "{npc:3595}, dentro del árbol",
	-- ["{npc:3595}, the priest trainer, inside the tree"] = "{npc:3595}, la instructora de sacerdotes, dentro del árbol",
	-- ["{npc:3595}, the priest trainer, on the ramp on the way down: {npc:3600} in {area:186} takes it"] = "{npc:3595}, la instructora de sacerdotes, en la rampa al bajar: {npc:3600} en {area:186} la recibe",
	-- ["{npc:3603}, beside {npc:6286}: Camping 101, alchemists"] = "{npc:3603}, junto a {npc:6286}: Campamento 101, alquimistas",
	-- ["{npc:3604}, beside {npc:6286}: Camping 101, herbalists"] = "{npc:3604}, junto a {npc:6286}: Campamento 101, herboristas",
	-- ["{npc:3605}, beside him: Camping 101, leatherworkers"] = "{npc:3605}, a su lado: Campamento 101, peleteros",
	-- ["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "El puesto de pescado de {npc:4200} está junto a los muelles. Luego toma el barco a {zone:1453}.",
	-- ["{npc:6094}, in the inn: Camping 101, {skill:129}"] = "{npc:6094}, en la posada: Campamento 101, {skill:129}",
	-- ["{npc:6287}, camped beside the road before Shayla: Camping 101, skinners"] = "{npc:6287}, acampado junto al camino antes de Shayla: Campamento 101, desolladores",
	-- ["{npc:7318}, in the den"] = "{npc:7318}, en la guarida",
	-- ["{object:7510}, beside him"] = "{object:7510}, a su lado",
	-- ["{quest:488} and the Starbreeze moonwell"] = "{quest:488} y el pozo de la luna de Brisa Estelar",
	-- ["{quest:97979}: cast {spell:1259799} and {spell:20580}, then hand it back to {npc:3595}"] = "{quest:97979}: lanza {spell:1259799} y {spell:20580}, y luego entrégasela a {npc:3595}",
}
