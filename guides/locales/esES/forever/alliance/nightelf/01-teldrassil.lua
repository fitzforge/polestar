-- Spanish (Spain) (esES): the guide forever/alliance/nightelf/01-teldrassil (forever/alliance/nightelf/01-teldrassil.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Aldrassil
	-- {area:256} Aldrassil · {area:188} Shadowglen
	["You start at the foot of {area:256}, the great tree of {area:188}."] = "Empiezas al pie de {area:256}, el gran árbol de {area:188}.",
	-- {npc:2077} Melithar Staghelm
	["{npc:2077}, by the path"] = "{npc:2077}, junto al sendero",
	-- {npc:1992} Tarindrella
	["{npc:1992}, south of the tree"] = "{npc:1992}, al sur del árbol",

	-- Step 2: The Balance of Nature
	-- {area:256} Aldrassil · {item:3297} Fel Moss
	-- plural, as words: Young Nightsabers = {npc:2031} Young Nightsaber · Young Thistle Boars = {npc:1984} Young Thistle Boar · Grells = {npc:1988} Grell · Gnarlpine Totems = {item:279082} Gnarlpine Totem
	["Young Nightsabers and Young Thistle Boars roam around {area:256}. Grells carry {item:3297} in the woods west of the tree, where the Gnarlpine Totems stand."] = "Los sables de la Noche jóvenes y los jóvenes jabalíes Cardo deambulan alrededor de {area:256}. Los grells llevan {item:3297} en el bosque al oeste del árbol, donde están los tótems Tuercepinos.",

	-- Step 3: Back at Aldrassil
	-- {area:256} Aldrassil
	["Back at {area:256}"] = "De vuelta en {area:256}",
	-- {npc:2079} Conservator Ilthalaine · {npc:3596} Ayanna Everstride
	["{npc:2079}: a sigil for {npc:3596}"] = "{npc:2079}: un sigilo para {npc:3596}",
	-- {npc:2082} Gilshalan Windwalker
	["{npc:2082}, on the tree's ramp"] = "{npc:2082}, en la rampa del árbol",
	-- {npc:3595} Shanda
	["{npc:3595}, inside the tree"] = "{npc:3595}, dentro del árbol",
	-- {quest:97979} The Goddess Provides · {spell:1259799} Elune's Light · {npc:3595} Shanda
	["{quest:97979}: cast {spell:1259799} and Shadowmeld, then hand it back to {npc:3595}"] = "{quest:97979}: lanza {spell:1259799} y Fusión de las Sombras, y luego entrégasela a {npc:3595}",
	-- {npc:8583} Dirania Silvershine
	["{npc:8583}, east of the tree"] = "{npc:8583}, al este del árbol",

	-- Step 4: North to Shadowthread Cave
	-- {area:257} Shadowthread Cave
	["North to {area:257}"] = "Al norte, hacia {area:257}",
	-- {area:256} Aldrassil · {npc:8584} Iverron · {npc:1994} Githyiss the Vile
	-- plural, as words: Mangy Nightsabers = {npc:2032} Mangy Nightsaber · Thistle Boars = {npc:1985} Thistle Boar
	["Mangy Nightsabers and Thistle Boars roam north of {area:256}, on the way to the cave. {npc:8584} waits in the trees west of the cave mouth; {npc:1994} sits deep inside."] = "Los sables de la Noche sarnosos y los jabalíes Cardo deambulan al norte de {area:256}, camino de la cueva. {npc:8584} espera entre los árboles al oeste de la entrada de la cueva; {npc:1994} está al fondo.",
	-- plural, as words: Webwood Spiders = {npc:1986} Webwood Spider
	["Webwood Spiders"] = "Arañas Tejemadera",

	-- Step 5: Aldrassil
	-- {npc:3593} Alyissia
	["{npc:3593}, the warrior trainer"] = "{npc:3593}, el instructor de guerreros",
	-- {npc:3596} Ayanna Everstride
	["{npc:3596}, the hunter trainer"] = "{npc:3596}, el instructor de cazadores",
	-- {npc:3594} Frahun Shadewhisper
	["{npc:3594}, the rogue trainer"] = "{npc:3594}, el instructor de pícaros",
	-- {npc:3595} Shanda
	["{npc:3595}, the priest trainer, inside the tree"] = "{npc:3595}, el instructor de sacerdotes, dentro del árbol",
	-- {npc:3597} Mardant Strongoak · {area:256} Aldrassil
	["{npc:3597}, the druid trainer at {area:256}"] = "{npc:3597}, el instructor de druidas en {area:256}",

	-- Step 7: Webwood Egg and the antidote
	-- {quest:917} Webwood Egg
	["{quest:917} and the antidote"] = "{quest:917} y el antídoto",
	-- {object:4406} Webwood Eggs · {area:257} Shadowthread Cave · {area:256} Aldrassil
	-- plural, as words: Hyacinth Mushrooms = {item:10639} Hyacinth Mushroom · Grells = {npc:1988} Grell
	["The {object:4406} lie at the back of {area:257}: take the central path, then left where it splits, up to the high ledge. Hyacinth Mushrooms drop from Grells, Moonpetal Lilies grow by the ponds north of {area:256}."] = "Los {object:4406} están al fondo de {area:257}: toma el sendero central, luego a la izquierda donde se divide, hasta la cornisa alta. Los grells sueltan champiñones jacinto; los lirios alunados crecen junto a las charcas al norte de {area:256}.",

	-- Step 8: Aldrassil
	-- {npc:3514} Tenaron Stormgrip
	["{npc:3514}, at the top of the tree"] = "{npc:3514}, en lo alto del árbol",

	-- Step 9: The moonwell and Iverron
	-- {npc:8584} Iverron
	["The moonwell and {npc:8584}"] = "El pozo de la luna y {npc:8584}",
	-- {area:256} Aldrassil · {npc:8584} Iverron · {quest:3522} Iverron's Antidote
	["The moonwell sits north of {area:256}; {npc:8584} is a little further north-west. {quest:3522} lasts five minutes: fill the phial and go straight on to him."] = "El pozo de la luna está al norte de {area:256}; {npc:8584} está un poco más al noroeste. {quest:3522} dura cinco minutos: llena la redoma y ve directo a él.",
	-- {item:5185} Crystal Phial
	["Use the {item:5185} at the moonwell"] = "Usa la {item:5185} en el pozo de la luna",

	-- Step 10: Tenaron Stormgrip
	-- {area:256} Aldrassil · {object:654846} Lost Journal
	["Back to the top of {area:256}. The {object:654846} lies beside him."] = "Vuelve a lo alto de {area:256}. El {object:654846} está a su lado.",

	-- Step 11: Porthannius
	-- {area:188} Shadowglen · {area:256} Aldrassil · {npc:6780} Porthannius · {area:186} Dolanaar
	["Leave {area:188} by the path south-east of {area:256}: {npc:6780} stands beside it, where it goes down towards the road to {area:186}."] = "Sal de {area:188} por el sendero al sureste de {area:256}: {npc:6780} está a su lado, donde baja hacia el camino a {area:186}.",

	-- Step 12: Zenn Foulhoof
	-- {area:188} Shadowglen · {npc:2150} Zenn Foulhoof · {area:186} Dolanaar
	["Follow the road south-west out of {area:188}. {npc:2150} sits beside it just east of {area:186}."] = "",

	-- Step 13: Dolanaar
	-- {npc:265811} Lyreena Duskblade
	["{npc:265811}, by the campfire"] = "{npc:265811}, junto a la hoguera",
	-- {npc:3515} Corithras Moonrage
	["{npc:3515}, south of the inn"] = "{npc:3515}, al sur de la posada",

	-- Step 14: Zenn's Bidding and the Starbreeze moonwell
	-- {quest:488} Zenn's Bidding
	["{quest:488} and the Starbreeze moonwell"] = "{quest:488} y el pozo de la luna de Brisa Estelar",
	-- {area:186} Dolanaar · {area:260} Starbreeze Village
	-- plural, as words: Strigid Owls = {npc:1995} Strigid Owl · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Nightsabers, Strigid Owls and Webwood Lurkers roam all around {area:186} and along the road east. The moonwell is at the west edge of {area:260}."] = "",
	-- {item:5619} Jade Phial
	["Use the {item:5619} at the moonwell"] = "Usa la {item:5619} en el pozo de la luna",
	-- {npc:2150} Zenn Foulhoof
	["{npc:2150}, on the way back"] = "{npc:2150}, a la vuelta",

	-- Step 15: Dolanaar quests
	-- {area:186} Dolanaar
	["{area:186} quests"] = "Misiones de {area:186}",

	-- Step 16: The Great Outdoors
	-- {npc:265811} Lyreena Duskblade · {spell:1229451} Boosted Rest
	["/sit by {npc:265811}'s campfire until you get {spell:1229451}"] = "/sentarse junto a la hoguera de {npc:265811} hasta que tengas {spell:1229451}",
	-- {npc:6286} Zarrin
	["Speak with {npc:6286}, south of the inn"] = "Habla con {npc:6286}, al sur de la posada",

	-- Step 17: East to Starbreeze Village
	-- {area:260} Starbreeze Village
	["East to {area:260}"] = "Al este, hacia {area:260}",
	-- {area:186} Dolanaar · {npc:2150} Zenn Foulhoof · {object:126158} Tallonkai's Dresser
	-- plural, as words: Fel Cones = {object:1673} Fel Cone · Webwood Lurkers = {npc:1998} Webwood Lurker
	["Fel Cones lie under the trees all around {area:186} and {npc:2150}. Nightsabers and Webwood Lurkers keep roaming the road east. {object:126158} is in the house on the hill at the east end of the village."] = "Los conos inferi están bajo los árboles alrededor de {area:186} y {npc:2150}. Los sables de la Noche y los rondadores Tejemadera siguen por el camino al este. {object:126158} está en la casa de la colina, en el extremo este del poblado.",
	["Nightsabers"] = "Sables de la Noche",
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker
	["Webwood Lurkers"] = "Rondadores Tejemadera",

	-- Step 19: Lake Al'Ameth
	-- {npc:2080} Denalan · {quest:919} Timberling Sprouts
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South of Zenn. {npc:2080} tends his saplings on the shore; Lasher Sproutlings and Timberlings wander around him, and the {quest:919} grow among them."] = "Al sur de Zenn. {npc:2080} cuida sus arbolitos en la orilla; los brotes azotadores y los brezomaderas deambulan a su alrededor, y los {quest:919} crecen entre ellos.",

	-- Step 20: Dolanaar
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151} patrols the road west of the village: if she isn't at the arrow, follow the road until you meet her."] = "{npc:2151} patrulla el camino al oeste de la aldea: si no está en la flecha, sigue el camino hasta encontrarla.",
	-- {npc:2151} Moon Priestess Amara
	["{npc:2151}, on the road west of the village"] = "{npc:2151}, en el camino al oeste del poblado",

	-- Step 21: Fel Rock's mouth
	-- {area:258} Fel Rock
	["{area:258}'s mouth"] = "Entrada de {area:258}",

	-- Step 22: Fel Rock
	-- {npc:2038} Lord Melenas
	["{npc:2038} waits inside the cave, at the bottom or up on the ledge; keep to the right."] = "{npc:2038} espera dentro de la cueva, abajo o arriba en la cornisa; ve por la derecha.",

	-- Step 23: The road to Darnassus
	-- {zone:1457} Darnassus
	["The road to {zone:1457}"] = "El camino a {zone:1457}",
	-- {area:258} Fel Rock
	-- plural, as words: Gnarlpine Ambushers = {npc:2152} Gnarlpine Ambusher
	["Gnarlpine Ambushers hide along the road west of {area:258}."] = "Los emboscadores Tuercepinos se esconden a lo largo del camino al oeste de {area:258}.",

	-- Step 24: Ban'ethil Barrow Den
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:7317} Oben Rageclaw
	["The barrow is south of the road. {npc:275744} is held inside, {npc:7317} sleeps in its depths, and the four relic chests sit in the lower rooms."] = "El túmulo está al sur del camino. {npc:275744} está retenida dentro, {npc:7317} duerme en lo más hondo y los cuatro cofres de reliquias están en las salas inferiores.",
	-- plural, as words: Gnarlpine Shamans = {npc:2009} Gnarlpine Shaman
	["Gnarlpine Shamans"] = "Chamanes Tuercepinos",
	-- {npc:7318} Rageclaw
	["{npc:7318}, in the den"] = "{npc:7318}, en la guarida",

	-- Step 25: Escaping Ban'ethil
	-- {npc:275744} Sentinel Lynessa Duskblossom · {npc:2081} Sentinel Kyra Starsong · {area:186} Dolanaar
	["Escort {npc:275744} out of the barrow; {npc:2081} in {area:186} takes the report."] = "Escolta a {npc:275744} fuera del túmulo; {npc:2081} en {area:186} recibe el informe.",
	["Walk Lynessa out and keep her alive"] = "Saca a Lynessa y mantenla con vida",
	-- {area:736} Ban'ethil Hollow
	["{area:736}, outside the barrow"] = "{area:736}, fuera del túmulo",

	-- Step 26: The Pools of Arlithrien
	-- {area:478} Pools of Arlithrien
	["The {area:478}"] = "El {area:478}",
	["South-west of the barrow. The moonwell sits by the pools."] = "Al suroeste del túmulo. El pozo de la luna está junto a las charcas.",
	-- {item:5621} Tourmaline Phial
	["Use the {item:5621} at the moonwell"] = "Usa la {item:5621} en el pozo de la luna",

	-- Step 27: Gnarlpine Hold
	-- {object:6751} Strange Fruited Plant
	["South of the pools. The {object:6751} grows by the Hold."] = "Al sur de las charcas. La {object:6751} crece junto al bastión.",

	-- Step 28: Hearth to Dolanaar
	-- {area:186} Dolanaar
	["Hearth to {area:186}"] = "Usa tu piedra de hogar para ir a {area:186}",

	-- Step 29: Ferocitas the Dream Eater
	-- {area:260} Starbreeze Village · {item:8049} Gnarlpine Necklace
	-- plural, as words: Gnarlpine Mystics = {npc:7235} Gnarlpine Mystic
	["Gnarlpine Mystics and Ferocitas camp north-east of {area:260}. Ferocitas drops the {item:8049}: open it for the jewel."] = "Los místicos Tuercepinos y Ferocitas acampan al noreste de {area:260}. Ferocitas suelta la {item:8049}: ábrela para conseguir la joya.",
	-- {npc:3567} Tallonkai Swiftroot · {area:186} Dolanaar
	["{npc:3567}, back in {area:186}"] = "{npc:3567}, de vuelta en {area:186}",

	-- Step 30: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {area:264} Oracle Glade
	["Take the road north-west from {area:186} towards the {area:264}; she lies hurt beside it."] = "Toma el camino al noroeste desde {area:186} hacia el {area:264}; ella yace herida a su lado.",

	-- Step 31: Oracle Glade
	-- {object:6752} Strange Fronded Plant
	["The moonwell is in the middle of the glade. The {object:6752} grows at its north end."] = "El pozo de la luna está en el centro del claro. La {object:6752} crece en su extremo norte.",
	-- {item:5623} Amethyst Phial
	["Use the {item:5623} at the moonwell"] = "Usa la {item:5623} en el pozo de la luna",
	-- {npc:3519} Sentinel Arynia Cloudsbreak
	["{npc:3519}, by the moonwell"] = "{npc:3519}, junto al pozo de la luna",

	-- Step 32: Bloodfeather harpies
	["Bloodfeather harpies"] = "Arpías Plumasangre",
	["The Bloodfeather harpies nest on the slopes west and north of the glade."] = "Las arpías Plumasangre anidan en las laderas al oeste y al norte del claro.",

	-- Step 33: Sentinel Arynia Cloudsbreak
	["Back to the moonwell."] = "Vuelve al pozo de la luna.",

	-- Step 34: The named harpies
	["The named harpies"] = "Las arpías con nombre",
	-- {npc:272034} Hatescreech · {npc:272044} Windmistress Gaedress · {npc:272046} Witchmother Arysa
	["{npc:272034} and {npc:272044} fly just west of the moonwell, {npc:272046} further north."] = "{npc:272034} y {npc:272044} vuelan justo al oeste del pozo de la luna, {npc:272046} más al norte.",

	-- Step 35: Sentinel Arynia again
	["Sentinel Arynia again"] = "Centinela Arynia otra vez",
	-- {object:673378} Oracle Tree Bark
	["{object:673378}, just west of the moonwell"] = "{object:673378}, justo al oeste del pozo de la luna",

	-- Step 36: Ursal the Mauler
	-- {area:478} Pools of Arlithrien
	["Walk south along the west side of the island. Ursal prowls the far south, below the {area:478}."] = "Ve al sur por el lado oeste de la isla. Ursal merodea por el extremo sur, debajo del {area:478}.",

	-- Step 37: Dolanaar
	-- {area:186} Dolanaar
	["North-east from Ursal's den, back to {area:186}."] = "Al noreste desde la guarida de Ursal, de vuelta a {area:186}.",
	-- {item:3371} Empty Vial · {npc:3614} Narret Shadowgrove · {npc:6094} Byancie
	["{item:3371} from {npc:3614}, beside {npc:6094}"] = "{item:3371} de {npc:3614}, junto a {npc:6094}",
	-- {npc:3600} Laurna Morninglight · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:3600}: {npc:11401} in {zone:1457} takes it"] = "{npc:3600}: la recibe {npc:11401} en {zone:1457}",
	-- {item:159} Refreshing Spring Water · {npc:6736} Innkeeper Keldamyr · {npc:6094} Byancie
	["{item:159} from {npc:6736}, for {npc:6094}"] = "{item:159} de {npc:6736}, para {npc:6094}",
	-- {zone:1457} Darnassus
	["Fandral in {zone:1457} takes it"] = "La recibe Fandral en {zone:1457}",
	-- {npc:3602} Kal · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:3602}: {npc:4217} in {zone:1457} takes it"] = "{npc:3602}: la recibe {npc:4217} en {zone:1457}",

	-- Step 38: Lake Al'Ameth
	-- {npc:2080} Denalan
	-- plural, as words: Lasher Sproutlings = {npc:275703} Lasher Sproutling
	["South-east of Dolanaar, to {npc:2080}. Lasher Sproutlings wander around him on the shore."] = "Al sureste de Dolanaar, hasta {npc:2080}. Los brotes azotadores deambulan a su alrededor en la orilla.",
	-- {npc:2080} Denalan · {quest:922} Rellian Greenspyre · {zone:1457} Darnassus
	["{npc:2080}: {quest:922} in {zone:1457} takes it"] = "{npc:2080}: la recibe {quest:922} en {zone:1457}",
	-- {object:7510} Sprouted Frond
	["{object:7510}, beside him"] = "{object:7510}, a su lado",

	-- Step 39: Dolanaar again
	-- {area:186} Dolanaar
	["{area:186} again"] = "{area:186} otra vez",

	-- Step 40: Taming the Beast
	-- {item:15908} Taming Rod · {area:186} Dolanaar
	-- plural, as words: Webwood Lurkers = {npc:1998} Webwood Lurker · Nightsaber Stalkers = {npc:2043} Nightsaber Stalker · Strigid Screechers = {npc:1996} Strigid Screecher
	["Each of Dazalar's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Cada misión de Dazalar te da una {item:15908}: úsala en la bestia que nombra y devuélvele la vara en {area:186}. Los rondadores Tejemadera merodean alrededor del poblado; los acechadores sable de la noche y los estridadores estrígidos recorren el bosque al sur.",
	-- {npc:1998} Webwood Lurker · {item:15908} Taming Rod
	["{npc:1998}: tame it with the {item:15908}"] = "{npc:1998}: domestícalo con la {item:15908}",
	-- {npc:2043} Nightsaber Stalker · {item:15908} Taming Rod
	["{npc:2043}: tame it with the {item:15908}"] = "{npc:2043}: domestícalo con la {item:15908}",
	-- {npc:1996} Strigid Screecher · {item:15908} Taming Rod
	["{npc:1996}: tame it with the {item:15908}"] = "{npc:1996}: domestícalo con la {item:15908}",
	-- {npc:4146} Jocaste · {zone:1457} Darnassus
	["{npc:4146} in {zone:1457} takes it"] = "La recibe {npc:4146} en {zone:1457}",

	-- Step 41: Sentinel Eralya Leafshadow
	-- {area:186} Dolanaar · {zone:1457} Darnassus
	["Take the road north-west from {area:186} again; she still lies beside it, on the way to {zone:1457}."] = "Toma otra vez el camino al noroeste desde {area:186}; sigue tendida a su lado, camino de {zone:1457}.",

	-- Step 42: Darnassus
	-- {zone:1457} Darnassus · {npc:4241} Mydrannul · {area:1659} Craftsmen's Terrace · {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave · {quest:922} Rellian Greenspyre · {npc:4092} Lariia · {npc:7999} Tyrande Whisperwind · {npc:7316} Sister Aquinne
	["Follow the road west into {zone:1457}. {npc:4241} stands on the {area:1659} just inside the city. {npc:3516} is in the {area:1658} at the north end of the city, {quest:922} just south of it; {npc:4092} and {npc:7999} are in the Temple of the Moon at the south end. {npc:7316} is in the west of the city, on the way to the pink portal down to Rut'theran."] = "Sigue el camino al oeste hasta {zone:1457}. {npc:4241} está en la {area:1659}, justo al entrar en la ciudad. {npc:3516} está en el {area:1658}, en el extremo norte de la ciudad, y {quest:922} justo al sur; {npc:4092} y {npc:7999} están en el Templo de la Luna, en el extremo sur. {npc:7316} está en el oeste de la ciudad, camino del portal rosa que baja a la Aldea Rut'theran.",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, in the {area:1658}"] = "{npc:3516}, en el {area:1658}",
	-- {npc:4146} Jocaste · {area:1658} Cenarion Enclave · {spell:5149} Beast Training
	["{npc:4146}, in the {area:1658}: {spell:5149}"] = "{npc:4146}, en el {area:1658}: {spell:5149}",
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217}, in the {area:1658}"] = "{npc:4217}, en el {area:1658}",
	-- {npc:4092} Lariia
	["{npc:4092}, in the Temple of the Moon"] = "{npc:4092}, en el Templo de la Luna",
	-- {npc:7999} Tyrande Whisperwind · {npc:4092} Lariia
	["{npc:7999}, above {npc:4092}"] = "{npc:7999}, encima de {npc:4092}",
	-- {npc:11401} Priestess Alathea
	["{npc:11401}, in the Temple of the Moon: Starshards"] = "{npc:11401}, en el Templo de la Luna: Fragmentos estelares",

	-- Step 43: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:10118} Nessa Shadowsong · {npc:3838} Vesprystus
	["Take the portal down to {area:702}. {npc:10118} stands on the dock, {npc:3838} by the hippogryphs."] = "Toma el portal hasta {area:702}. {npc:10118} está en el muelle, {npc:3838} junto a los hipogrifos.",

	-- Step 45: Moonglade
	-- {area:442} Auberdine · {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5929} Great Bear Spirit · {area:493} Moonglade · {area:702} Rut'theran Village
	["Learn the {area:442} flight path on the hill south of the inn, then cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path in {area:2361} and fly to {area:702} (by way of {area:442})."] = "Aprende la ruta de vuelo de {area:442} en la colina al sur de la posada y lanza {spell:18960}. {npc:11802} está en {area:2361}; el {quest:5929} está en el bosque al noroeste. Aprende la ruta de vuelo de {area:493} en {area:2361} y vuela a {area:702} (pasando por {area:442}).",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Habla con el {quest:5929}",

	-- Step 46: Back to Darnassus
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Take the portal up from {area:702} to {npc:4217} in the {area:1658}."] = "Toma el portal de {area:702} hasta {npc:4217}, en el {area:1658}.",

	-- Step 47: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "El {object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Go back down to {area:702} and fly to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Vuelve a bajar a {area:702} y vuela a {area:442}. El {object:177525} está en las colinas justo al este del poblado: usa el {item:15208} allí, derrota a Lunaclaw y habla con el {npc:12144}.",

	-- Step 48: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine
	["Fly to {area:702} once more and take the portal up to {npc:4217}, then fly back to {area:442} for the boat."] = "Vuela otra vez a {area:702} y toma el portal hasta {npc:4217}; luego vuelve a volar a {area:442} para el barco.",

	-- Step 49: Auberdine
	-- {npc:4200} Laird · {zone:1453} Stormwind
	["{npc:4200}'s fish stall is by the docks. Then take the boat to {zone:1453}."] = "El puesto de pescado de {npc:4200} está junto a los muelles. Luego toma el barco a {zone:1453}.",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "Barco a {zone:1453}",
	-- {area:17203} Stormwind Harbor · {zone:1429} Elwynn Forest · {zone:1436} Westfall
	["From {area:17203}, ride through the city gates into {zone:1429} and follow the road west to {zone:1436}."] = "Desde {area:17203}, cruza las puertas de la ciudad hacia {zone:1429} y sigue el camino al oeste hasta {zone:1436}.",

	-- Step 50: Defensive Stance
	-- {object:2100} Old Town · {npc:5480} Ilsa Corbin · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["From the harbour walk into {object:2100}. {npc:5480} trains warriors there; {npc:6089} and {npc:6090} stand together by the {object:2152}. {npc:6090} fights you for his mug."] = "Desde el puerto entra en {object:2100}. {npc:5480} entrena a los guerreros allí; {npc:6089} y {npc:6090} están juntos junto al {object:2152}. {npc:6090} pelea contigo por su jarra.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defensive Stance"] = "Actitud defensiva",
	-- ["Each of {npc:3601}'s quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him in {area:186}. Webwood Lurkers creep around the village, Nightsaber Stalkers and Strigid Screechers roam the woods south of it."] = "Cada misión de {npc:3601} te da una {item:15908}: úsala en la bestia que nombra y devuélvele la vara en {area:186}. Los rondadores Tejemadera merodean alrededor del poblado; los acechadores sable de la noche y los estridadores estrígidos recorren el bosque al sur.",
	-- ["Follow the road south-west out of {area:188} to {area:186}."] = "Sigue el camino al suroeste desde {area:188} hasta {area:186}.",
	-- ["Nightsabers, Strigid Owls and Webwood Lurkers live along the road east. The moonwell is at the west edge of {area:260}."] = "Los sables de la Noche, las lechuzas estrígidas y los rondadores Tejemadera viven a lo largo del camino al este. El pozo de la luna está en el borde oeste de {area:260}.",
	-- ["Tame Beast"] = "Domesticar bestia",
	-- ["The {area:264}"] = "{area:264}",
	-- ["{npc:11401}, in the Temple of the Moon: {spell:10797}"] = "{npc:11401}, en el Templo de la Luna: {spell:10797}",
	-- ["{npc:2150} sits by the road just east of {area:186}, on the way to {area:260}."] = "{npc:2150} está sentado junto al camino, justo al este de {area:186}, camino de {area:260}.",
	-- ["{npc:4217}: Bear Form"] = "{npc:4217}: forma de oso",
	-- ["{npc:6089}: Defensive Stance"] = "{npc:6089}: Actitud defensiva",
	-- ["{quest:97979}: cast {spell:1259799} and {spell:20580}, then hand it back to {npc:3595}"] = "{quest:97979}: lanza {spell:1259799} y {spell:20580}, y luego entrégasela a {npc:3595}",
}
