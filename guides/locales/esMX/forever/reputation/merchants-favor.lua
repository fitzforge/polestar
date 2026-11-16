-- Spanish (Latin America) (esMX): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Supply Factions Reputation"] = "Reputación de las facciones de suministros",
	-- {npc:10636} Pack Kodo
	["Forever's trade camps: their best recipes, the Minimule and the {npc:10636} need standing, not only Merchant's Favor."] = "Los campamentos comerciales de Forever: sus mejores recetas, la Minimula y el {npc:10636} requieren reputación, no solo Favor del mercader.",
	["Profession recipes at Friendly and Honored"] = "Recetas de profesión en Amistoso y Honorable",

	-- Step 1: Your first Waylaid Crate or writ
	-- {item:248549} Waylaid Crate
	["Your first {item:248549} or writ"] = "Tu primer {item:248549} o encargo",
	-- {quest:98247} Shipping Label
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["From level 10, mobs anywhere drop Waylaid Crates and sealed writs (Journeyman's, Expert's and Artisan's). Fill a crate with one of the bundles it lists (right-click it), or open a sealed writ: by beta reports, the first time you do either you also get a {quest:98247}. Right-click the label to start its quest. Crates and writs can be traded, so the Auction House sells them too."] = "Desde el nivel 10, los enemigos de cualquier lugar sueltan Cajones arrebatados y encargos sellados (de Oficial, de Experto y de Artesano). Llena un cajón con uno de los lotes que pide (clic derecho en él), o abre un encargo sellado: según informes de la beta, la primera vez que haces cualquiera de las dos cosas también recibes una {quest:98247}. Haz clic derecho en la etiqueta para iniciar su misión. Los cajones y los encargos se pueden comerciar, así que la casa de subastas también los vende.",

	-- Step 2: Three Corners: the Shipping Label
	-- {area:1002} Three Corners · {quest:98247} Shipping Label
	["{area:1002}: the {quest:98247}"] = "{area:1002}: la {quest:98247}",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood · {area:69} Lakeshire · {npc:256390} Marcy Baker
	["The {faction:2586} camp is at {area:1002}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet in western Redridge. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256390} too, but they pay only Merchant's Favor and silver, never reputation."] = "El campamento de {faction:2586} está en {area:1002}, donde se juntan los caminos de {zone:1429}, {zone:1431} y {area:69}, en el oeste de Crestagrana. La etiqueta paga 2000 de reputación una sola vez (y, según informes de la beta, 50 de Favor del mercader): dos tercios del camino a Amistoso. Los cajones llenos también van a {npc:256390}, pero solo pagan Favor del mercader y plata, nunca reputación.",

	-- Step 3: The Crossroads camp: the Shipping Label
	-- {area:380} The Crossroads · {quest:98248} Shipping Label
	["{area:380} camp: the {quest:98248}"] = "Campamento de {area:380}: la {quest:98248}",
	-- {faction:2587} Durotar Supply and Logistics · {npc:256386} Dokimi
	["The {faction:2587} camp stands just outside the west gate of the Crossroads. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256386} too, but they pay only Merchant's Favor and silver, never reputation."] = "El campamento de {faction:2587} está justo afuera de la puerta oeste del Cruce. La etiqueta paga 2000 de reputación una sola vez (y, según informes de la beta, 50 de Favor del mercader): dos tercios del camino a Amistoso. Los cajones llenos también van a {npc:256386}, pero solo pagan Favor del mercader y plata, nunca reputación.",

	-- Step 4: Gather your writs
	["Gather your writs"] = "Junta tus encargos",
	["Craftsman's Writs are the camp's reputation: 75 for a Journeyman writ, 125 for an Expert, 200 for an Artisan. Each asks for one crafted item, the one its title names. Make it or buy it on the Auction House; you need not know the profession. Each writ can be done once a day, and any number of different ones. Take the quest only of writs whose item you have or will buy on the way (right-click the writ), keep the writ in your bags, then tick this: the next steps lead to each customer you hold a writ for."] = "Los encargos de artesano son la reputación del campamento: 75 por un encargo de Oficial, 125 por uno de Experto, 200 por uno de Artesano. Cada uno pide un objeto fabricado, el que nombra su título. Fabrícalo o cómpralo en la casa de subastas; no necesitas conocer la profesión. Cada encargo se puede hacer una vez al día, y todos los distintos que quieras. Toma la misión solo de los encargos cuyo objeto tengas o vayas a comprar por el camino (clic derecho en el encargo), guarda el encargo en tus bolsas, y luego marca esto: los pasos siguientes te llevan a cada cliente para el que tengas un encargo.",
	["Take the quests of the writs you can fill"] = "Toma las misiones de los encargos que puedas cumplir",

	-- Step 5: Duskwood writ customers
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers"] = "Clientes de encargos en {zone:1431}",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}. Customers show no quest mark: right-click them anyway."] = "{npc:3134} está a unos 450 metros al norte de {area:42}. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- {item:6048} Shadow Protection Potion
	["{item:6048}, 75 reputation"] = "{item:6048}, 75 de reputación",
	-- {item:4381} Minor Recombobulator
	["{item:4381}, 75 reputation"] = "{item:4381}, 75 de reputación",
	-- {item:2317} Dark Leather Tunic
	["{item:2317}, 75 reputation"] = "{item:2317}, 75 de reputación",
	-- {item:4245} Small Silk Pack
	["{item:4245}, 75 reputation"] = "{item:4245}, 75 de reputación",

	-- Step 6: Stranglethorn Vale writ customers
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers"] = "Clientes de encargos en {zone:1434}",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {area:1741} Gurubashi Arena · {object:3202} Grom'gol (no name in this language: may be words) · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853}, the goblin transporter's engineer, and {npc:2663}. {npc:14508} stands at the {area:1741}, about 800 yards south of {object:3202}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35} tiene tres clientes: MacKinley «Lobo de Mar» (en el último piso de la posada), {npc:7853}, el ingeniero del transportador goblin, y {npc:2663}. {npc:14508} está en {area:1741}, unos 800 metros al sur de {object:3202}; {npc:261961} está en el norte de Tuercespina. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- {item:3485} Green Iron Gauntlets
	["{item:3485}, 75 reputation"] = "{item:3485}, 75 de reputación",
	-- {item:7506} Gnomish Universal Remote
	["{item:7506}, 75 reputation"] = "{item:7506}, 75 de reputación",
	-- {item:4252} Dark Leather Shoulders
	["{item:4252}, 75 reputation"] = "{item:4252}, 75 de reputación",
	-- {item:3388} Lesser Troll's Blood Elixir
	["{item:3388}, 75 reputation"] = "{item:3388}, 75 de reputación",
	-- {item:10048} Colorful Kilt
	["{item:10048}, 75 reputation"] = "{item:10048}, 75 de reputación",

	-- Step 7: Wetlands writ customers
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers"] = "Clientes de encargos en {zone:1437}",
	-- {npc:8305} Kixxle · {area:205} Dun Modr
	["{npc:8305} stands about 600 yards south of {area:205}. Five Journeyman writs go to him: the most of any customer. Customers show no quest mark: right-click them anyway."] = "{npc:8305} está a unos 600 metros al sur de {area:205}. Cinco encargos de Oficial van para él: el que más tiene de todos los clientes. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- {item:5996} Draught of Water Breathing
	["{item:5996}, 75 reputation"] = "{item:5996}, 75 de reputación",
	-- {item:3484} Green Iron Boots
	["{item:3484}, 75 reputation"] = "{item:3484}, 75 de reputación",
	-- {item:8069} Crafted Solid Shot
	["{item:8069}, 75 reputation"] = "{item:8069}, 75 de reputación",
	-- {item:7284} Red Whelp Gloves
	["{item:7284}, 75 reputation"] = "{item:7284}, 75 de reputación",
	-- {item:4321} Spider Silk Slippers
	["{item:4321}, 75 reputation"] = "{item:4321}, 75 de reputación",

	-- Step 8: Arathi Highlands writ customers
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers"] = "Clientes de encargos en {zone:1417}",
	-- {npc:257296} Muggol Breezebeard · {area:320} Refuge Pointe · {npc:257304} Alyce
	["{npc:257296} is about 250 yards south of {area:320}, {npc:257304} about 700 yards north-west of it. Customers show no quest mark: right-click them anyway."] = "{npc:257296} está a unos 250 metros al sur de {area:320}, {npc:257304} a unos 700 metros al noroeste. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- {item:3383} Elixir of Wisdom
	["{item:3383}, 75 reputation"] = "{item:3383}, 75 de reputación",
	-- {item:11128} Golden Rod
	["{item:11128}, 75 reputation"] = "{item:11128}, 75 de reputación",
	-- {npc:789} Kimberly Hiett · {area:69} Lakeshire
	["bring it: engineers make it; {npc:789} in {area:69} lists it (not yet seen in her window up to level 30), or the Auction House"] = "tráelo: lo fabrican los ingenieros; {npc:789}, en {area:69}, lo tiene en su lista (todavía no visto en su ventana hasta el nivel 30), o la casa de subastas",
	-- {item:4384} Explosive Sheep
	["{item:4384}, 75 reputation"] = "{item:4384}, 75 de reputación",
	-- {item:5958} Fine Leather Pants
	["{item:5958}, 75 reputation"] = "{item:5958}, 75 de reputación",
	-- {item:6263} Blue Overalls
	["{item:6263}, 75 reputation"] = "{item:6263}, 75 de reputación",

	-- Step 9: Hillsbrad Foothills writ customers
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers"] = "Clientes de encargos en {zone:1424}",
	-- {npc:261932} Gorgrash · {npc:3536} Kris Legace · {npc:261928} Webbed Mudsnout Gnoll · {area:271} Southshore
	["{npc:261932} and {npc:3536} are in the east of the foothills; the {npc:261928} hangs in a spider cocoon about 500 yards south-east of {area:271}. Customers show no quest mark: right-click them anyway."] = "{npc:261932} y {npc:3536} están en el este de las laderas; el {npc:261928} cuelga en un capullo de araña a unos 500 metros al sureste de {area:271}. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- {item:3491} Heavy Bronze Mace
	["{item:3491}, 75 reputation"] = "{item:3491}, 75 de reputación",
	["bring it: craft it or buy it at the Auction House"] = "tráelo: fabrícalo o cómpralo en la casa de subastas",
	-- {item:6712} Practice Lock
	["{item:6712}, 75 reputation"] = "{item:6712}, 75 de reputación",
	-- {item:7358} Pilferer's Gloves
	["{item:7358}, 75 reputation"] = "{item:7358}, 75 de reputación",
	-- {item:5634} Free Action Potion
	["{item:5634}, 75 reputation"] = "{item:5634}, 75 de reputación",

	-- Step 10: Alterac Mountains writ customers
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers"] = "Clientes de encargos en {zone:1416}",
	-- {npc:257281} Sos'mol · {npc:257282} Alan Sneeks · {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill
	["{npc:257281} and {npc:257282} are close together in the south-west of the mountains; Syndicate thugs roam around {npc:257282}. {npc:6176} stands on the eastern edge, above {area:272}. Customers show no quest mark: right-click them anyway."] = "{npc:257281} y {npc:257282} están cerca uno del otro en el suroeste de las montañas; hay matones del Sindicato alrededor de {npc:257282}. {npc:6176} está en el borde este, sobre {area:272}. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- {item:3391} Elixir of Ogre Strength
	["{item:3391}, 75 reputation"] = "{item:3391}, 75 de reputación",
	["bring it: leatherworkers make it, or buy it at the Auction House"] = "tráelo: lo fabrican los peleteros, o cómpralo en la casa de subastas",
	-- {item:18662} Heavy Leather Ball
	["{item:18662}, 75 reputation"] = "{item:18662}, 75 de reputación",
	-- {item:5540} Pearl-handled Dagger
	["{item:5540}, 75 reputation"] = "{item:5540}, 75 de reputación",
	-- {item:5507} Ornate Spyglass
	["{item:5507}, 75 reputation"] = "{item:5507}, 75 de reputación",
	-- {item:5766} Lesser Wizard's Robe
	["{item:5766}, 75 reputation"] = "{item:5766}, 75 de reputación",
	-- {item:4317} Phoenix Pants
	["{item:4317}, 75 reputation"] = "{item:4317}, 75 de reputación",

	-- Step 11: Ashenvale writ customers
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers"] = "Clientes de encargos en {zone:1440}",
	-- {area:431} Splintertree Post · {npc:257315} Ash'alari · {npc:257322} Murache · {npc:257316} Cowardly Peon · {npc:257317} Grembly
	["All four stand around {area:431}: {npc:257315} about 850 yards south-west of it, {npc:257322} to the south, the {npc:257316} about 350 yards south-east and {npc:257317} about 650 yards north-east. Customers show no quest mark: right-click them anyway."] = "Los cuatro están alrededor de {area:431}: {npc:257315} a unos 850 metros al suroeste, {npc:257322} al sur, el {npc:257316} a unos 350 metros al sureste y {npc:257317} a unos 650 metros al noreste. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- {item:3385} Lesser Mana Potion
	["{item:3385}, 75 reputation"] = "{item:3385}, 75 de reputación",
	-- {item:7349} Herbalist's Gloves
	["{item:7349}, 75 reputation"] = "{item:7349}, 75 de reputación",
	-- {item:5541} Iridescent Hammer
	["{item:5541}, 75 reputation"] = "{item:5541}, 75 de reputación",
	-- {item:7048} Azure Silk Hood
	["{item:7048}, 75 reputation"] = "{item:7048}, 75 de reputación",
	-- {item:4383} Moonsight Rifle
	["{item:4383}, 75 reputation"] = "{item:4383}, 75 de reputación",

	-- Step 12: A Heavy Quiver for the writ
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ"] = "Un {item:7371} para el encargo",
	-- {item:7371} Heavy Quiver · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1458} Undercity
	["Leatherworkers make the {item:7371}; the bow and gun vendors of {zone:1453}, {zone:1455} and the {zone:1458} sell it. Otherwise buy one at the Auction House."] = "Los peleteros fabrican el {item:7371}; los vendedores de arcos y armas de fuego de {zone:1453}, {zone:1455} y {zone:1458} lo venden. Si no, compra uno en la casa de subastas.",

	-- Step 13: Stonetalon Mountains writ customers
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers"] = "Clientes de encargos en {zone:1442}",
	-- {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["{npc:4201} has a small hut about 550 yards east of {area:460}. Four Journeyman writs go to him. Customers show no quest mark: right-click them anyway."] = "{npc:4201} tiene una chocita a unos 550 metros al este de {area:460}. Cuatro encargos de Oficial van para él. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- {item:3390} Elixir of Lesser Agility
	["{item:3390}, 75 reputation"] = "{item:3390}, 75 de reputación",
	-- {item:2865} Rough Bronze Leggings
	["{item:2865}, 75 reputation"] = "{item:2865}, 75 de reputación",
	-- {item:4373} Shadow Goggles
	["{item:4373}, 75 reputation"] = "{item:4373}, 75 de reputación",
	-- {item:7371} Heavy Quiver
	["{item:7371}, 75 reputation"] = "{item:7371}, 75 de reputación",

	-- Step 14: Thousand Needles writ customers
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers"] = "Clientes de encargos en {zone:1441}",
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {area:484} Freewind Post · {npc:4720} Rizzle Brassbolts · {npc:4706} Razzeric · {npc:4496} Goblin Pit Boss · {npc:6548} Magus Tirth
	["All five stand at the {area:2240} on the {area:439}, south-east of {area:484}: {npc:4720}, the chicken \"Plucky\" Johnson, {npc:4706}, the {npc:4496} and {npc:6548}. Customers show no quest mark: right-click them anyway."] = "Los cinco están en {area:2240}, en {area:439}, al sureste de {area:484}: {npc:4720}, el pollo «Plucky» Johnson, {npc:4706}, el {npc:4496} y {npc:6548}. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- {item:8951} Elixir of Defense
	["{item:8951}, 75 reputation"] = "{item:8951}, 75 de reputación",
	-- {item:3848} Big Bronze Knife
	["{item:3848}, 75 reputation"] = "{item:3848}, 75 de reputación",
	-- {item:4380} Big Bronze Bomb
	["{item:4380}, 75 reputation"] = "{item:4380}, 75 de reputación",
	-- {item:4254} Barbaric Gloves
	["{item:4254}, 75 reputation"] = "{item:4254}, 75 de reputación",
	-- {item:6264} Greater Adept's Robe
	["{item:6264}, 75 reputation"] = "{item:6264}, 75 de reputación",

	-- Step 15: Neutral to Friendly
	["Neutral to Friendly"] = "De Neutral a Amistoso",
	-- {quest:98247} Shipping Label
	["After the {quest:98247}, Friendly is 1000 more: 14 Journeyman writs, 8 Expert or 5 Artisan. Expert and Artisan customers are mostly not in Polestar's data yet: follow the mark the quest puts on your map. Journeyman envelopes drop from mobs of about level 11 to 31; Expert and Artisan ones from higher mobs."] = "Después de la {quest:98247}, Amistoso está a 1000 más: 14 encargos de Oficial, 8 de Experto o 5 de Artesano. Los clientes de Experto y Artesano en su mayoría todavía no están en los datos de Polestar: sigue la marca que la misión pone en tu mapa. Los sobres de Oficial los sueltan enemigos de nivel 11 a 31 más o menos; los de Experto y Artesano, enemigos de más nivel.",

	-- Step 16: Gather your writs again
	["Gather your writs again"] = "Junta tus encargos otra vez",

	-- Step 17: Duskwood writ customers again
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers again"] = "Clientes de encargos en {zone:1431} otra vez",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}, by the road. Customers show no quest mark: right-click them anyway."] = "{npc:3134} está a unos 450 metros al norte de {area:42}, junto al camino. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",

	-- Step 18: Stranglethorn Vale writ customers again
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers again"] = "Clientes de encargos en {zone:1434} otra vez",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {object:3202} Grom'gol (no name in this language: may be words) · {area:1741} Gurubashi Arena · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853} at the zeppelin-style transporter pad and {npc:2663}. {npc:14508} stands about 800 yards south of {object:3202}, by the {area:1741}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35} tiene tres clientes: MacKinley «Lobo de Mar» (en el último piso de la posada), {npc:7853} en la plataforma del transportador y {npc:2663}. {npc:14508} está a unos 800 metros al sur de {object:3202}, junto a {area:1741}; {npc:261961} está en el norte de Tuercespina. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",

	-- Step 19: Wetlands writ customers again
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers again"] = "Clientes de encargos en {zone:1437} otra vez",

	-- Step 20: Arathi Highlands writ customers again
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers again"] = "Clientes de encargos en {zone:1417} otra vez",

	-- Step 21: Hillsbrad Foothills writ customers again
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers again"] = "Clientes de encargos en {zone:1424} otra vez",

	-- Step 22: Alterac Mountains writ customers again
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers again"] = "Clientes de encargos en {zone:1416} otra vez",

	-- Step 23: Ashenvale writ customers again
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers again"] = "Clientes de encargos en {zone:1440} otra vez",

	-- Step 24: A Heavy Quiver for the writ again
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ again"] = "Un {item:7371} para el encargo otra vez",

	-- Step 25: Stonetalon Mountains writ customers again
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers again"] = "Clientes de encargos en {zone:1442} otra vez",

	-- Step 26: Thousand Needles writ customers again
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers again"] = "Clientes de encargos en {zone:1441} otra vez",

	-- Step 27: Friendly to Honored
	["Friendly to Honored"] = "De Amistoso a Honorable",
	-- {skill:197} Tailoring · {skill:165} Leatherworking · {skill:333} Enchanting · {skill:164} Blacksmithing · {skill:202} Engineering · {skill:171} Alchemy · {skill:185} Cooking · {npc:256742} Dianne Softstep · {area:1002} Three Corners · {npc:256672} Kurvelk Shadowhoof · {item:262902} Forged Delivery Receipt · {item:248549} Waylaid Crate · {item:262917} Notarized Shipping Container · {npc:256390} Marcy Baker · {npc:256386} Dokimi · {quest:93862} Crate Return
	["Friendly opens the first gated recipes at the camp's profession vendors ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) and the Uncertified Scribe: {npc:256742} at {area:1002}, {npc:256672} at the south end of the Crossroads camp. The scribe's {item:262902} (15 Merchant's Favor) turns an empty {item:248549} into a {item:262917}; hand it to {npc:256390} or {npc:256386} for 50 reputation ({quest:93862}). Any crate works, so buy the cheapest one the Auction House has. Honored is 6000 more: 80 Journeyman writs, 48 Expert, 30 Artisan, or 120 crate returns (1,800 Favor and 120 crates). Mix both: every writ you can fill, returns with spare Favor. The Legacy perk Diplomat adds up to 10% to every gain."] = "Amistoso abre las primeras recetas bloqueadas en los vendedores de profesiones del campamento ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) y al escriba sin certificar: {npc:256742} en {area:1002}, {npc:256672} en el extremo sur del campamento del Cruce. El {item:262902} del escriba (15 de Favor del mercader) convierte un {item:248549} vacío en un {item:262917}; entrégalo a {npc:256390} o {npc:256386} por 50 de reputación ({quest:93862}). Sirve cualquier cajón, así que compra el más barato que tenga la casa de subastas. Honorable está a 6000 más: 80 encargos de Oficial, 48 de Experto, 30 de Artesano o 120 devoluciones de cajones (1.800 de Favor y 120 cajones). Combina las dos cosas: cada encargo que puedas cumplir, y devoluciones con el Favor que te sobre. La ventaja Diplomático del Legado suma hasta un 10% a cada ganancia.",
	-- {item:262902} Forged Delivery Receipt
	["{item:262902}, 15 Merchant's Favor"] = "{item:262902}, 15 de Favor del mercader",
	-- {quest:93862} Crate Return
	["{quest:93862}: 50 reputation"] = "{quest:93862}: 50 de reputación",

	-- Step 28: Badlands writ customer
	-- {zone:1418} Badlands
	["{zone:1418} writ customer"] = "Cliente de encargos en {zone:1418}",
	-- {npc:2921} Lotwil Veriatus · {area:340} Kargath
	["{npc:2921} works about 550 yards east of {area:340}. He is the only Expert customer Polestar's data knows."] = "{npc:2921} trabaja a unos 550 metros al este de {area:340}. Es el único cliente de Experto que conocen los datos de Polestar.",
	-- {item:6050} Frost Protection Potion
	["{item:6050}, 125 reputation"] = "{item:6050}, 125 de reputación",

	-- Step 29: Honored to Revered
	["Honored to Revered"] = "De Honorable a Reverenciado",
	-- {skill:165} Leatherworking · {skill:164} Blacksmithing · {skill:333} Enchanting · {skill:171} Alchemy · {skill:202} Engineering · {skill:197} Tailoring · {skill:185} Cooking · {item:270887} Advertising License Application · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262896} Forger's Quill
	["Honored opens the rest of the gated recipes ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), the {item:270887} (1,200 Favor from {npc:256389} or {npc:256384}: it starts the quest for a Tradeskill Sign toy) and the scribe's {item:262896} (15 Favor), which swaps a writ you cannot fill for a random one of the same rank. Revered is 12000 more: 160 Journeyman writs, 96 Expert, 60 Artisan, or 240 crate returns (3,600 Favor). Forever's quest data sets no standing limit on Journeyman writs: their customers are the ones in the zone steps above."] = "Honorable abre el resto de las recetas bloqueadas ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), la {item:270887} (1.200 de Favor con {npc:256389} o {npc:256384}: inicia la misión de un juguete de cartel de profesión) y el {item:262896} del escriba (15 de Favor), que cambia un encargo que no puedes cumplir por uno al azar del mismo rango. Reverenciado está a 12000 más: 160 encargos de Oficial, 96 de Experto, 60 de Artesano o 240 devoluciones de cajones (3.600 de Favor). Los datos de misiones de Forever no ponen límite de reputación a los encargos de Oficial: sus clientes son los de los pasos por zona de arriba.",
	-- {item:270887} Advertising License Application
	["{item:270887}, 1,200 Merchant's Favor"] = "{item:270887}, 1.200 de Favor del mercader",

	-- Step 30: Revered to Exalted
	["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- {item:284664} Packmule Treat · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {npc:10636} Pack Kodo
	["Revered opens the {item:284664}, the Minimule pet (1,500 Favor from {npc:256389} or {npc:256384}). Exalted is 21000 more: 280 Journeyman writs, 168 Expert, 105 Artisan, or 420 crate returns (6,300 Favor). Keep 6,000 Favor for the {npc:10636} if you want it."] = "Reverenciado abre el {item:284664}, la mascota Minimula (1.500 de Favor con {npc:256389} o {npc:256384}). Exaltado está a 21000 más: 280 encargos de Oficial, 168 de Experto, 105 de Artesano o 420 devoluciones de cajones (6.300 de Favor). Guarda 6.000 de Favor para el {npc:10636} si lo quieres.",
	-- {item:284664} Packmule Treat
	["{item:284664}, 1,500 Merchant's Favor"] = "{item:284664}, 1.500 de Favor del mercader",

	-- Step 31: Exalted
	["Exalted"] = "Exaltado",
	-- {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262766} Reins of the Pack Kodo · {npc:256736} Huey Sunnydale · {area:1002} Three Corners · {npc:10636} Pack Kodo
	["Exalted opens the camp's tabard (200 Favor) at {npc:256389} or {npc:256384}, and the {item:262766} (6,000 Favor; the mount needs level 60 and Journeyman mount training) at {npc:256736} in {area:1002} or Okamache at the Crossroads camp. The {npc:10636} guide under Collectibles leads you there."] = "Exaltado abre el tabardo del campamento (200 de Favor) con {npc:256389} o {npc:256384}, y las {item:262766} (6.000 de Favor; la montura requiere nivel 60 y el entrenamiento de equitación de Oficial) con {npc:256736} en {area:1002} u Okamache en el campamento del Cruce. La guía de {npc:10636}, en Coleccionables, te lleva hasta allí.",
	-- {item:262765} Azeroth Commerce Authority Tabard
	["{item:262765}, 200 Merchant's Favor"] = "{item:262765}, 200 de Favor del mercader",
	-- {item:262764} Durotar Supply and Logistics Tabard
	["{item:262764}, 200 Merchant's Favor"] = "{item:262764}, 200 de Favor del mercader",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dokimi"] = "Dokimi",
	-- ["Keep filling Waylaid Crates for Dokimi until Exalted."] = "Sigue llenando Cajones arrebatados para Dokimi hasta Exaltado.",
	-- ["Keep filling Waylaid Crates for Dokimi."] = "Sigue llenando Cajones arrebatados para Dokimi.",
	-- ["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "Sigue llenando Cajones arrebatados para {npc:214101} hasta Exaltado.",
	-- ["Keep filling Waylaid Crates for {npc:214101}."] = "Sigue llenando Cajones arrebatados para {npc:214101}.",
	-- ["Merchant's Favor Reputation"] = "Reputación: Favor del mercader",
	-- ["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2586} es la facción de profesiones de la Alianza en Forever. Su campamento está en {area:1002}, en el oeste de {zone:1433}. Desde el nivel 10 los enemigos sueltan Cajones arrebatados: llena cada uno con los bienes que pide su etiqueta y entrega {object:1561} a {npc:214101} en el campamento a cambio de reputación y Merchant's Favor. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{faction:2586} to Exalted"] = "{faction:2586} hasta Exaltado",
	-- ["{faction:2586} to Friendly"] = "{faction:2586} hasta Amistoso",
	-- ["{faction:2586} to Honored"] = "{faction:2586} hasta Honorable",
	-- ["{faction:2586} to Revered"] = "{faction:2586} hasta Reverenciado",
	-- ["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587} es la facción de profesiones de la Horda en Forever. Su campamento está justo afuera de {area:380}, en {zone:1413}. Desde el nivel 10 los enemigos sueltan Cajones arrebatados: llena cada uno con los bienes que pide su etiqueta y entrega {object:1561} a Dokimi en el campamento a cambio de reputación y Merchant's Favor. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- ["{faction:2587} to Exalted"] = "{faction:2587} hasta Exaltado",
	-- ["{faction:2587} to Friendly"] = "{faction:2587} hasta Amistoso",
	-- ["{faction:2587} to Honored"] = "{faction:2587} hasta Honorable",
	-- ["{faction:2587} to Revered"] = "{faction:2587} hasta Reverenciado",
}
