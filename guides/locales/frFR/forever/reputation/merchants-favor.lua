-- French (frFR): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Supply Factions Reputation"] = "Réputation : factions de ravitaillement",
	-- {npc:10636} Pack Kodo
	["Forever's trade camps: their best recipes, the Minimule and the {npc:10636} need standing, not only Merchant's Favor."] = "Les camps de commerce de Forever : leurs meilleures recettes, le Minimule et le {npc:10636} demandent de la réputation, pas seulement des Merchant's Favor.",
	["Profession recipes at Friendly and Honored"] = "Recettes de métier à Amical et Honoré",

	-- Step 1: Your first Waylaid Crate or writ
	-- {item:248549} Waylaid Crate
	["Your first {item:248549} or writ"] = "Votre première {item:248549} ou commande",
	-- {quest:98247} Shipping Label
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["From level 10, mobs anywhere drop Waylaid Crates and sealed writs (Journeyman's, Expert's and Artisan's). Fill a crate with one of the bundles it lists (right-click it), or open a sealed writ: by beta reports, the first time you do either you also get a {quest:98247}. Right-click the label to start its quest. Crates and writs can be traded, so the Auction House sells them too."] = "Dès le niveau 10, les monstres de partout laissent des caisses détournées et des commandes scellées (de compagnon, d'expert et d'artisan). Remplissez une caisse avec l'un des lots qu'elle indique (clic droit dessus), ou ouvrez une commande scellée : d'après les retours de la bêta, la première fois que vous faites l'un ou l'autre, vous recevez aussi une {quest:98247}. Faites un clic droit sur l'étiquette pour lancer sa quête. Caisses et commandes s'échangent, l'hôtel des ventes en vend donc aussi.",

	-- Step 2: Three Corners: the Shipping Label
	-- {area:1002} Three Corners · {quest:98247} Shipping Label
	["{area:1002}: the {quest:98247}"] = "{area:1002} : l'{quest:98247}",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood · {area:69} Lakeshire · {npc:256390} Marcy Baker
	["The {faction:2586} camp is at {area:1002}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet in western Redridge. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256390} too, but they pay only Merchant's Favor and silver, never reputation."] = "Le camp de l'{faction:2586} se trouve à {area:1002}, là où se rejoignent les routes de la {zone:1429}, du {zone:1431} et de {area:69}, dans l'ouest des Carmines. L'étiquette rapporte une fois 2000 de réputation (et, d'après les retours de la bêta, 50 Merchant's Favor) : les deux tiers du chemin vers Amical. Les caisses remplies se rendent aussi à {npc:256390}, mais elles ne rapportent que des Merchant's Favor et de l'argent, jamais de réputation.",

	-- Step 3: The Crossroads camp: the Shipping Label
	-- {area:380} The Crossroads · {quest:98248} Shipping Label
	["{area:380} camp: the {quest:98248}"] = "Camp de {area:380} : l'{quest:98248}",
	-- {faction:2587} Durotar Supply and Logistics · {npc:256386} Dokimi
	["The {faction:2587} camp stands just outside the west gate of the Crossroads. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256386} too, but they pay only Merchant's Favor and silver, never reputation."] = "",

	-- Step 4: Gather your writs
	["Gather your writs"] = "Rassemblez vos commandes",
	["Craftsman's Writs are the camp's reputation: 75 for a Journeyman writ, 125 for an Expert, 200 for an Artisan. Each asks for one crafted item, the one its title names. Make it or buy it on the Auction House; you need not know the profession. Each writ can be done once a day, and any number of different ones. Take the quest only of writs whose item you have or will buy on the way (right-click the writ), keep the writ in your bags, then tick this: the next steps lead to each customer you hold a writ for."] = "",
	["Take the quests of the writs you can fill"] = "Acceptez les quêtes des commandes que vous pouvez remplir",

	-- Step 5: Duskwood writ customers
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers"] = "{zone:1431} : clients des commandes",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}. Customers show no quest mark: right-click them anyway."] = "{npc:3134} se tient à environ 450 mètres au nord de {area:42}. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- {item:6048} Shadow Protection Potion
	["{item:6048}, 75 reputation"] = "{item:6048}, 75 de réputation",
	-- {item:4381} Minor Recombobulator
	["{item:4381}, 75 reputation"] = "{item:4381}, 75 de réputation",
	-- {item:2317} Dark Leather Tunic
	["{item:2317}, 75 reputation"] = "{item:2317}, 75 de réputation",
	-- {item:4245} Small Silk Pack
	["{item:4245}, 75 reputation"] = "{item:4245}, 75 de réputation",

	-- Step 6: Stranglethorn Vale writ customers
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers"] = "{zone:1434} : clients des commandes",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {area:1741} Gurubashi Arena · {object:3202} Grom'gol (no name in this language: may be words) · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853}, the goblin transporter's engineer, and {npc:2663}. {npc:14508} stands at the {area:1741}, about 800 yards south of {object:3202}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "",
	-- {item:3485} Green Iron Gauntlets
	["{item:3485}, 75 reputation"] = "{item:3485}, 75 de réputation",
	-- {item:7506} Gnomish Universal Remote
	["{item:7506}, 75 reputation"] = "{item:7506}, 75 de réputation",
	-- {item:4252} Dark Leather Shoulders
	["{item:4252}, 75 reputation"] = "{item:4252}, 75 de réputation",
	-- {item:3388} Lesser Troll's Blood Elixir
	["{item:3388}, 75 reputation"] = "{item:3388}, 75 de réputation",
	-- {item:10048} Colorful Kilt
	["{item:10048}, 75 reputation"] = "{item:10048}, 75 de réputation",

	-- Step 7: Wetlands writ customers
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers"] = "{zone:1437} : clients des commandes",
	-- {npc:8305} Kixxle · {area:205} Dun Modr
	["{npc:8305} stands about 600 yards south of {area:205}. Five Journeyman writs go to him: the most of any customer. Customers show no quest mark: right-click them anyway."] = "{npc:8305} se tient à environ 600 mètres au sud de {area:205}. Cinq commandes de compagnon vont à lui : le plus de tous les clients. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- {item:5996} Draught of Water Breathing
	["{item:5996}, 75 reputation"] = "{item:5996}, 75 de réputation",
	-- {item:3484} Green Iron Boots
	["{item:3484}, 75 reputation"] = "{item:3484}, 75 de réputation",
	-- {item:8069} Crafted Solid Shot
	["{item:8069}, 75 reputation"] = "{item:8069}, 75 de réputation",
	-- {item:7284} Red Whelp Gloves
	["{item:7284}, 75 reputation"] = "{item:7284}, 75 de réputation",
	-- {item:4321} Spider Silk Slippers
	["{item:4321}, 75 reputation"] = "{item:4321}, 75 de réputation",

	-- Step 8: Arathi Highlands writ customers
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers"] = "{zone:1417} : clients des commandes",
	-- {npc:257296} Muggol Breezebeard · {area:320} Refuge Pointe · {npc:257304} Alyce
	["{npc:257296} is about 250 yards south of {area:320}, {npc:257304} about 700 yards north-west of it. Customers show no quest mark: right-click them anyway."] = "{npc:257296} est à environ 250 mètres au sud de {area:320}, {npc:257304} à environ 700 mètres au nord-ouest. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- {item:3383} Elixir of Wisdom
	["{item:3383}, 75 reputation"] = "{item:3383}, 75 de réputation",
	-- {item:11128} Golden Rod
	["{item:11128}, 75 reputation"] = "{item:11128}, 75 de réputation",
	-- {npc:789} Kimberly Hiett · {area:69} Lakeshire
	["bring it: engineers make it; {npc:789} in {area:69} lists it (not yet seen in her window up to level 30), or the Auction House"] = "",
	-- {item:4384} Explosive Sheep
	["{item:4384}, 75 reputation"] = "{item:4384}, 75 de réputation",
	-- {item:5958} Fine Leather Pants
	["{item:5958}, 75 reputation"] = "{item:5958}, 75 de réputation",
	-- {item:6263} Blue Overalls
	["{item:6263}, 75 reputation"] = "{item:6263}, 75 de réputation",

	-- Step 9: Hillsbrad Foothills writ customers
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers"] = "{zone:1424} : clients des commandes",
	-- {npc:261932} Gorgrash · {npc:3536} Kris Legace · {npc:261928} Webbed Mudsnout Gnoll · {area:271} Southshore
	["{npc:261932} and {npc:3536} are in the east of the foothills; the {npc:261928} hangs in a spider cocoon about 500 yards south-east of {area:271}. Customers show no quest mark: right-click them anyway."] = "{npc:261932} et {npc:3536} sont dans l'est des contreforts ; le {npc:261928} pend dans un cocon d'araignée à environ 500 mètres au sud-est d'{area:271}. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- {item:3491} Heavy Bronze Mace
	["{item:3491}, 75 reputation"] = "{item:3491}, 75 de réputation",
	["bring it: craft it or buy it at the Auction House"] = "apportez-le : fabriquez-le ou achetez-le à l'hôtel des ventes",
	-- {item:6712} Practice Lock
	["{item:6712}, 75 reputation"] = "{item:6712}, 75 de réputation",
	-- {item:7358} Pilferer's Gloves
	["{item:7358}, 75 reputation"] = "{item:7358}, 75 de réputation",
	-- {item:5634} Free Action Potion
	["{item:5634}, 75 reputation"] = "{item:5634}, 75 de réputation",

	-- Step 10: Alterac Mountains writ customers
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers"] = "{zone:1416} : clients des commandes",
	-- {npc:257281} Sos'mol · {npc:257282} Alan Sneeks · {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill
	["{npc:257281} and {npc:257282} are close together in the south-west of the mountains; Syndicate thugs roam around {npc:257282}. {npc:6176} stands on the eastern edge, above {area:272}. Customers show no quest mark: right-click them anyway."] = "{npc:257281} et {npc:257282} sont proches l'un de l'autre dans le sud-ouest des montagnes ; des nervis du Syndicat rôdent autour de {npc:257282}. {npc:6176} se tient sur le bord est, au-dessus de {area:272}. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- {item:3391} Elixir of Ogre Strength
	["{item:3391}, 75 reputation"] = "{item:3391}, 75 de réputation",
	["bring it: leatherworkers make it, or buy it at the Auction House"] = "",
	-- {item:18662} Heavy Leather Ball
	["{item:18662}, 75 reputation"] = "{item:18662}, 75 de réputation",
	-- {item:5540} Pearl-handled Dagger
	["{item:5540}, 75 reputation"] = "{item:5540}, 75 de réputation",
	-- {item:5507} Ornate Spyglass
	["{item:5507}, 75 reputation"] = "{item:5507}, 75 de réputation",
	-- {item:5766} Lesser Wizard's Robe
	["{item:5766}, 75 reputation"] = "{item:5766}, 75 de réputation",
	-- {item:4317} Phoenix Pants
	["{item:4317}, 75 reputation"] = "{item:4317}, 75 de réputation",

	-- Step 11: Ashenvale writ customers
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers"] = "{zone:1440} : clients des commandes",
	-- {area:431} Splintertree Post · {npc:257315} Ash'alari · {npc:257322} Murache · {npc:257316} Cowardly Peon · {npc:257317} Grembly
	["All four stand around {area:431}: {npc:257315} about 850 yards south-west of it, {npc:257322} to the south, the {npc:257316} about 350 yards south-east and {npc:257317} about 650 yards north-east. Customers show no quest mark: right-click them anyway."] = "Les quatre se tiennent autour d'{area:431} : {npc:257315} à environ 850 mètres au sud-ouest, {npc:257322} au sud, le {npc:257316} à environ 350 mètres au sud-est et {npc:257317} à environ 650 mètres au nord-est. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- {item:3385} Lesser Mana Potion
	["{item:3385}, 75 reputation"] = "{item:3385}, 75 de réputation",
	-- {item:7349} Herbalist's Gloves
	["{item:7349}, 75 reputation"] = "{item:7349}, 75 de réputation",
	-- {item:5541} Iridescent Hammer
	["{item:5541}, 75 reputation"] = "{item:5541}, 75 de réputation",
	-- {item:7048} Azure Silk Hood
	["{item:7048}, 75 reputation"] = "{item:7048}, 75 de réputation",
	-- {item:4383} Moonsight Rifle
	["{item:4383}, 75 reputation"] = "{item:4383}, 75 de réputation",

	-- Step 12: A Heavy Quiver for the writ
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ"] = "Un {item:7371} pour la commande",
	-- {item:7371} Heavy Quiver · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1458} Undercity
	["Leatherworkers make the {item:7371}; the bow and gun vendors of {zone:1453}, {zone:1455} and the {zone:1458} sell it. Otherwise buy one at the Auction House."] = "Les travailleurs du cuir fabriquent le {item:7371} ; les vendeurs d'arcs et d'armes à feu de {zone:1453}, de {zone:1455} et de {zone:1458} le vendent. Sinon, achetez-en un à l'hôtel des ventes.",

	-- Step 13: Stonetalon Mountains writ customers
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers"] = "{zone:1442} : clients des commandes",
	-- {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["{npc:4201} has a small hut about 550 yards east of {area:460}. Four Journeyman writs go to him. Customers show no quest mark: right-click them anyway."] = "{npc:4201} a une petite hutte à environ 550 mètres à l'est de la {area:460}. Quatre commandes de compagnon vont à lui. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- {item:3390} Elixir of Lesser Agility
	["{item:3390}, 75 reputation"] = "{item:3390}, 75 de réputation",
	-- {item:2865} Rough Bronze Leggings
	["{item:2865}, 75 reputation"] = "{item:2865}, 75 de réputation",
	-- {item:4373} Shadow Goggles
	["{item:4373}, 75 reputation"] = "{item:4373}, 75 de réputation",
	-- {item:7371} Heavy Quiver
	["{item:7371}, 75 reputation"] = "{item:7371}, 75 de réputation",

	-- Step 14: Thousand Needles writ customers
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers"] = "{zone:1441} : clients des commandes",
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {area:484} Freewind Post · {npc:4720} Rizzle Brassbolts · {npc:4706} Razzeric · {npc:4496} Goblin Pit Boss · {npc:6548} Magus Tirth
	["All five stand at the {area:2240} on the {area:439}, south-east of {area:484}: {npc:4720}, the chicken \"Plucky\" Johnson, {npc:4706}, the {npc:4496} and {npc:6548}. Customers show no quest mark: right-click them anyway."] = "Les cinq se tiennent au {area:2240}, sur les {area:439}, au sud-est du {area:484} : {npc:4720}, le poulet Johnson « le Brave », {npc:4706}, le {npc:4496} et le {npc:6548}. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- {item:8951} Elixir of Defense
	["{item:8951}, 75 reputation"] = "{item:8951}, 75 de réputation",
	-- {item:3848} Big Bronze Knife
	["{item:3848}, 75 reputation"] = "{item:3848}, 75 de réputation",
	-- {item:4380} Big Bronze Bomb
	["{item:4380}, 75 reputation"] = "{item:4380}, 75 de réputation",
	-- {item:4254} Barbaric Gloves
	["{item:4254}, 75 reputation"] = "{item:4254}, 75 de réputation",
	-- {item:6264} Greater Adept's Robe
	["{item:6264}, 75 reputation"] = "{item:6264}, 75 de réputation",

	-- Step 15: Neutral to Friendly
	["Neutral to Friendly"] = "De Neutre à Amical",
	-- {quest:98247} Shipping Label
	["After the {quest:98247}, Friendly is 1000 more: 14 Journeyman writs, 8 Expert or 5 Artisan. Expert and Artisan customers are mostly not in Polestar's data yet: follow the mark the quest puts on your map. Journeyman envelopes drop from mobs of about level 11 to 31; Expert and Artisan ones from higher mobs."] = "Après l'{quest:98247}, Amical est à 1000 de plus : 14 commandes de compagnon, 8 d'expert ou 5 d'artisan. Les clients des commandes d'expert et d'artisan ne sont pour la plupart pas encore dans les données de Polestar : suivez la marque que la quête place sur votre carte. Les enveloppes de compagnon tombent des monstres d'environ niveau 11 à 31 ; celles d'expert et d'artisan de monstres plus forts.",

	-- Step 16: Gather your writs again
	["Gather your writs again"] = "Rassemblez de nouveau vos commandes",

	-- Step 17: Duskwood writ customers again
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers again"] = "{zone:1431} : clients des commandes, de nouveau",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}, by the road. Customers show no quest mark: right-click them anyway."] = "{npc:3134} se tient à environ 450 mètres au nord de {area:42}, près de la route. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",

	-- Step 18: Stranglethorn Vale writ customers again
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers again"] = "{zone:1434} : clients des commandes, de nouveau",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {object:3202} Grom'gol (no name in this language: may be words) · {area:1741} Gurubashi Arena · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853} at the zeppelin-style transporter pad and {npc:2663}. {npc:14508} stands about 800 yards south of {object:3202}, by the {area:1741}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "",

	-- Step 19: Wetlands writ customers again
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers again"] = "{zone:1437} : clients des commandes, de nouveau",

	-- Step 20: Arathi Highlands writ customers again
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers again"] = "{zone:1417} : clients des commandes, de nouveau",

	-- Step 21: Hillsbrad Foothills writ customers again
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers again"] = "{zone:1424} : clients des commandes, de nouveau",

	-- Step 22: Alterac Mountains writ customers again
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers again"] = "{zone:1416} : clients des commandes, de nouveau",

	-- Step 23: Ashenvale writ customers again
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers again"] = "{zone:1440} : clients des commandes, de nouveau",

	-- Step 24: A Heavy Quiver for the writ again
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ again"] = "Un {item:7371} pour la commande, de nouveau",

	-- Step 25: Stonetalon Mountains writ customers again
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers again"] = "{zone:1442} : clients des commandes, de nouveau",

	-- Step 26: Thousand Needles writ customers again
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers again"] = "{zone:1441} : clients des commandes, de nouveau",

	-- Step 27: Friendly to Honored
	["Friendly to Honored"] = "D'Amical à Honoré",
	-- {skill:197} Tailoring · {skill:165} Leatherworking · {skill:333} Enchanting · {skill:164} Blacksmithing · {skill:202} Engineering · {skill:171} Alchemy · {skill:185} Cooking · {npc:256742} Dianne Softstep · {area:1002} Three Corners · {npc:256672} Kurvelk Shadowhoof · {item:262902} Forged Delivery Receipt · {item:248549} Waylaid Crate · {item:262917} Notarized Shipping Container · {npc:256390} Marcy Baker · {npc:256386} Dokimi · {quest:93862} Crate Return
	["Friendly opens the first gated recipes at the camp's profession vendors ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) and the Uncertified Scribe: {npc:256742} at {area:1002}, {npc:256672} at the south end of the Crossroads camp. The scribe's {item:262902} (15 Merchant's Favor) turns an empty {item:248549} into a {item:262917}; hand it to {npc:256390} or {npc:256386} for 50 reputation ({quest:93862}). Any crate works, so buy the cheapest one the Auction House has. Honored is 6000 more: 80 Journeyman writs, 48 Expert, 30 Artisan, or 120 crate returns (1,800 Favor and 120 crates). Mix both: every writ you can fill, returns with spare Favor. The Legacy perk Diplomat adds up to 10% to every gain."] = "",
	-- {item:262902} Forged Delivery Receipt
	["{item:262902}, 15 Merchant's Favor"] = "{item:262902}, 15 Merchant's Favor",
	-- {quest:93862} Crate Return
	["{quest:93862}: 50 reputation"] = "{quest:93862} : 50 de réputation",

	-- Step 28: Badlands writ customer
	-- {zone:1418} Badlands
	["{zone:1418} writ customer"] = "{zone:1418} : client des commandes",
	-- {npc:2921} Lotwil Veriatus · {area:340} Kargath
	["{npc:2921} works about 550 yards east of {area:340}. He is the only Expert customer Polestar's data knows."] = "{npc:2921} travaille à environ 550 mètres à l'est de {area:340}. C'est le seul client de commandes d'expert que connaissent les données de Polestar.",
	-- {item:6050} Frost Protection Potion
	["{item:6050}, 125 reputation"] = "{item:6050}, 125 de réputation",

	-- Step 29: Honored to Revered
	["Honored to Revered"] = "D'Honoré à Révéré",
	-- {skill:165} Leatherworking · {skill:164} Blacksmithing · {skill:333} Enchanting · {skill:171} Alchemy · {skill:202} Engineering · {skill:197} Tailoring · {skill:185} Cooking · {item:270887} Advertising License Application · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262896} Forger's Quill
	["Honored opens the rest of the gated recipes ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), the {item:270887} (1,200 Favor from {npc:256389} or {npc:256384}: it starts the quest for a Tradeskill Sign toy) and the scribe's {item:262896} (15 Favor), which swaps a writ you cannot fill for a random one of the same rank. Revered is 12000 more: 160 Journeyman writs, 96 Expert, 60 Artisan, or 240 crate returns (3,600 Favor). Forever's quest data sets no standing limit on Journeyman writs: their customers are the ones in the zone steps above."] = "Honoré ouvre le reste des recettes réservées ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), la {item:270887} (1 200 Merchant's Favor auprès de {npc:256389} ou de {npc:256384} : elle lance la quête d'un jouet, un panneau de métier) et la {item:262896} du scribe (15 Merchant's Favor), qui échange une commande que vous ne pouvez pas remplir contre une autre au hasard du même rang. Révéré est à 12000 de plus : 160 commandes de compagnon, 96 d'expert, 60 d'artisan, ou 240 retours de caisse (3 600 Merchant's Favor). Les données de quêtes de Forever ne fixent aucune limite de réputation aux commandes de compagnon : leurs clients sont ceux des étapes de zone ci-dessus.",
	-- {item:270887} Advertising License Application
	["{item:270887}, 1,200 Merchant's Favor"] = "{item:270887}, 1 200 Merchant's Favor",

	-- Step 30: Revered to Exalted
	["Revered to Exalted"] = "De Révéré à Exalté",
	-- {item:284664} Packmule Treat · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {npc:10636} Pack Kodo
	["Revered opens the {item:284664}, the Minimule pet (1,500 Favor from {npc:256389} or {npc:256384}). Exalted is 21000 more: 280 Journeyman writs, 168 Expert, 105 Artisan, or 420 crate returns (6,300 Favor). Keep 6,000 Favor for the {npc:10636} if you want it."] = "Révéré ouvre la {item:284664}, la mascotte Minimule (1 500 Merchant's Favor auprès de {npc:256389} ou de {npc:256384}). Exalté est à 21000 de plus : 280 commandes de compagnon, 168 d'expert, 105 d'artisan, ou 420 retours de caisse (6 300 Merchant's Favor). Gardez 6 000 Merchant's Favor pour le {npc:10636} si vous le voulez.",
	-- {item:284664} Packmule Treat
	["{item:284664}, 1,500 Merchant's Favor"] = "{item:284664}, 1 500 Merchant's Favor",

	-- Step 31: Exalted
	["Exalted"] = "Exalté",
	-- {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262766} Reins of the Pack Kodo · {npc:256736} Huey Sunnydale · {area:1002} Three Corners · {npc:10636} Pack Kodo
	["Exalted opens the camp's tabard (200 Favor) at {npc:256389} or {npc:256384}, and the {item:262766} (6,000 Favor; the mount needs level 60 and Journeyman mount training) at {npc:256736} in {area:1002} or Okamache at the Crossroads camp. The {npc:10636} guide under Collectibles leads you there."] = "",
	-- {item:262765} Azeroth Commerce Authority Tabard
	["{item:262765}, 200 Merchant's Favor"] = "{item:262765}, 200 Merchant's Favor",
	-- {item:262764} Durotar Supply and Logistics Tabard
	["{item:262764}, 200 Merchant's Favor"] = "{item:262764}, 200 Merchant's Favor",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:18662} for the writ"] = "Un {item:18662} pour la commande",
	-- ["A {item:18662} for the writ again"] = "Un {item:18662} pour la commande, de nouveau",
	-- ["An {item:4384} for the writ"] = "Un {item:4384} pour la commande",
	-- ["An {item:4384} for the writ again"] = "Un {item:4384} pour la commande, de nouveau",
	-- ["Craftsman's Writs are the camp's reputation: 75 for a Journeyman writ, 125 for an Expert, 200 for an Artisan. Each asks for one crafted item, named in its quest (not always the writ's title: a {spell:3176} writ wants a {item:3388}). Make it or buy it on the Auction House; you need not know the profession. Each writ can be done once a day, and any number of different ones. Take the quest only of writs whose item you have or will buy on the way (right-click the writ), keep the writ in your bags, then tick this: the next steps lead to each customer you hold a writ for."] = "Les commandes d'artisanat font la réputation du camp : 75 pour une commande de compagnon, 125 pour une d'expert, 200 pour une d'artisan. Chacune demande un objet fabriqué, nommé dans sa quête (pas toujours celui du titre de la commande : une commande d'{spell:3176} veut une {item:3388}). Fabriquez-le ou achetez-le à l'hôtel des ventes ; vous n'avez pas besoin de connaître le métier. Chaque commande se fait une fois par jour, et autant de commandes différentes que vous voulez. N'acceptez la quête que des commandes dont vous avez l'objet ou que vous achèterez en chemin (clic droit sur la commande), gardez la commande dans vos sacs, puis cochez ceci : les étapes suivantes mènent à chaque client dont vous avez une commande.",
	-- ["Dokimi"] = "Dokimi",
	-- ["Engineers make the {item:4384}; {npc:789} sells it in {area:69} (Alliance). Otherwise buy one at the Auction House."] = "Les ingénieurs fabriquent le {item:4384} ; {npc:789} le vend à {area:69} (Alliance). Sinon, achetez-en un à l'hôtel des ventes.",
	-- ["Exalted opens the camp's tabard (200 Favor) at {npc:256389} or {npc:256384}, and the {item:262766} (6,000 Favor; the mount needs level 60 and Journeyman mount training) at {npc:256736} in {area:1002} or Okamache at the {area:380} camp. The {npc:10636} guide under Collectibles leads you there."] = "Exalté ouvre le tabard du camp (200 Merchant's Favor) chez {npc:256389} ou {npc:256384}, et les {item:262766} (6 000 Merchant's Favor ; la monture demande le niveau 60 et l'apprentissage de la monte de compagnon) chez {npc:256736} à {area:1002} ou Okamache au camp de {area:380}. Le guide du {npc:10636}, dans Objets de collection, vous y mène.",
	-- ["Friendly opens the first gated recipes at the camp's profession vendors ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) and the Uncertified Scribe: {npc:256742} at {area:1002}, {npc:256672} at the south end of the {area:380} camp. The scribe's {item:262902} (15 Merchant's Favor) turns an empty {item:248549} into a {item:262917}; hand it to {npc:256390} or {npc:256386} for 50 reputation ({quest:93862}). Any crate works, so buy the cheapest one the Auction House has. Honored is 6000 more: 80 Journeyman writs, 48 Expert, 30 Artisan, or 120 crate returns (1,800 Favor and 120 crates). Mix both: every writ you can fill, returns with spare Favor. The Legacy perk Diplomat adds up to 10% to every gain."] = "Amical ouvre les premières recettes réservées chez les vendeurs de métiers du camp ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) et le scribe non certifié : {npc:256742} à {area:1002}, {npc:256672} à l'extrémité sud du camp de {area:380}. Le {item:262902} du scribe (15 Merchant's Favor) transforme une {item:248549} vide en {item:262917} ; remettez-le à {npc:256390} ou à {npc:256386} contre 50 de réputation ({quest:93862}). N'importe quelle caisse convient : achetez la moins chère de l'hôtel des ventes. Honoré est à 6000 de plus : 80 commandes de compagnon, 48 d'expert, 30 d'artisan, ou 120 retours de caisse (1 800 Merchant's Favor et 120 caisses). Mélangez les deux : toutes les commandes que vous pouvez remplir, des retours avec les Merchant's Favor en trop. L'atout Diplomate de l'Héritage ajoute jusqu'à 10 % à chaque gain.",
	-- ["Keep filling Waylaid Crates for Dokimi until Exalted."] = "Continuez à remplir des Caisses détournées pour Dokimi jusqu'à Exalté.",
	-- ["Keep filling Waylaid Crates for Dokimi."] = "Continuez à remplir des Caisses détournées pour Dokimi.",
	-- ["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "Continuez à remplir des Caisses détournées pour {npc:214101} jusqu'à Exalté.",
	-- ["Keep filling Waylaid Crates for {npc:214101}."] = "Continuez à remplir des Caisses détournées pour {npc:214101}.",
	-- ["Leatherworkers make the {item:18662}, and the Auction House has it. Its only vendor is {npc:14860} at the Darkmoon Faire, which Forever has not shown yet: go there only if the Faire is in town."] = "Les travailleurs du cuir fabriquent le {item:18662}, et l'hôtel des ventes en a. Son seul vendeur est {npc:14860} à la foire de Sombrelune, que Forever n'a pas encore montrée : n'y allez que si la foire est en ville.",
	-- ["Merchant's Favor Reputation"] = "Réputation : Faveur marchande",
	-- ["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "L'{faction:2586} est la faction de métiers de l'Alliance dans Forever. Son camp se trouve à {area:1002}, dans l'ouest de {zone:1433}. Dès le niveau 10, les monstres laissent tomber des Caisses détournées : remplissez chacune des marchandises demandées sur son étiquette et remettez la {object:1561} à {npc:214101} au camp contre de la réputation et des Merchant's Favor. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["The {faction:2587} camp stands just outside the west gate of the {area:380}. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256386} too, but they pay only Merchant's Favor and silver, never reputation."] = "Le camp de {faction:2587} se trouve juste devant la porte ouest de {area:380}. L'étiquette rapporte une fois 2000 de réputation (et, d'après les retours de la bêta, 50 Merchant's Favor) : les deux tiers du chemin vers Amical. Les caisses remplies se rendent aussi à {npc:256386}, mais elles ne rapportent que des Merchant's Favor et de l'argent, jamais de réputation.",
	-- ["{area:35} holds three customers: \"Sea Wolf\" MacKinley, {npc:7853} at the zeppelin-style transporter pad and {npc:2663}. {npc:14508} stands about 800 yards south of {object:3202}, by the {area:1741}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35} compte trois clients : MacKinley « Loup de mer », {npc:7853} près de la plateforme du transporteur façon zeppelin et {npc:2663}. {npc:14508} se tient à environ 800 mètres au sud de Grom'gol, près de l'{area:1741} ; {npc:261961} est dans le nord de Strangleronce. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- ["{area:35} holds three customers: \"Sea Wolf\" MacKinley, {npc:7853}, the goblin transporter's engineer, and {npc:2663}. {npc:14508} stands at the {area:1741}, about 800 yards south of {object:3202}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35} compte trois clients : MacKinley « Loup de mer », {npc:7853}, l'ingénieur du transporteur gobelin, et {npc:2663}. {npc:14508} se tient à l'{area:1741}, à environ 800 mètres au sud de Grom'gol ; {npc:261961} est dans le nord de Strangleronce. Les clients n'affichent aucune marque de quête : faites quand même un clic droit sur eux.",
	-- ["{faction:2586} to Exalted"] = "{faction:2586} : Exalté",
	-- ["{faction:2586} to Friendly"] = "{faction:2586} : Amical",
	-- ["{faction:2586} to Honored"] = "{faction:2586} : Honoré",
	-- ["{faction:2586} to Revered"] = "{faction:2586} : Révéré",
	-- ["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587} est la faction de métiers de la Horde dans Forever. Son camp se trouve juste à l'extérieur de {area:380}, dans {zone:1413}. Dès le niveau 10, les monstres laissent tomber des Caisses détournées : remplissez chacune des marchandises demandées sur son étiquette et remettez la {object:1561} à Dokimi au camp contre de la réputation et des Merchant's Favor. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{faction:2587} to Exalted"] = "{faction:2587} : Exalté",
	-- ["{faction:2587} to Friendly"] = "{faction:2587} : Amical",
	-- ["{faction:2587} to Honored"] = "{faction:2587} : Honoré",
	-- ["{faction:2587} to Revered"] = "{faction:2587} : Révéré",
}
