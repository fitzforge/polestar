-- Spanish (Spain) (esES): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Supply Factions Reputation"] = "Reputación de las facciones de suministros",
	-- {npc:10636} Pack Kodo
	["Forever's trade camps: their best recipes, the Minimule and the {npc:10636} need standing, not only Merchant's Favor."] = "Los campamentos comerciales de Forever: sus mejores recetas, la Minimula y el {npc:10636} requieren reputación, no solo Favor del mercader.",
	["Profession recipes at Friendly and Honored"] = "Recetas de profesión en Amistoso y Honorable",

	-- Step 1: Reach level 10
	["Reach level 10"] = "",
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["Waylaid Crates and writs open from level 10."] = "",

	-- Step 2: Buy a Waylaid Crate: Apprentice Textiles
	-- {item:248684} Waylaid Crate: Apprentice Textiles
	["Buy a {item:248684}"] = "",
	["Mobs drop crates from level 10 too; every crate fills the same way."] = "",

	-- Step 3: Get 40 Linen Cloth
	-- {item:2589} Linen Cloth
	["Get 40 {item:2589}"] = "",
	-- {item:2318} Light Leather
	["Humanoids drop it, or the Auction House. 20 {item:2318} fills this crate too."] = "",

	-- Step 4: Fill the Waylaid Crate
	-- {item:248549} Waylaid Crate
	["Fill the {item:248549}"] = "",
	-- {item:248765} Sealed Apprentice Crate
	["Right-clicking the crate turns it into a {item:248765}."] = "",

	-- Step 5: Start the Shipping Label quest · the label in your bags
	-- {quest:98247} Shipping Label
	["Start the {quest:98247} quest · the label in your bags"] = "",
	-- {quest:98247} Shipping Label
	["The first crate or writ comes with a {quest:98247}."] = "",

	-- Step 6: Hand in the Shipping Label · Marcy Baker, Three Corners, Redridge
	-- {quest:98247} Shipping Label · {npc:256390} Marcy Baker · {area:1002} Three Corners
	["Hand in the {quest:98247} · {npc:256390}, {area:1002}, Redridge"] = "",
	["It pays 2,000 reputation, two thirds of the way to Friendly."] = "",

	-- Step 7: Hand in the Shipping Label · Dokimi, outside the Crossroads, The Barrens
	-- {quest:98248} Shipping Label · {npc:256386} Dokimi · {zone:1413} The Barrens
	["Hand in the {quest:98248} · {npc:256386}, outside the Crossroads, {zone:1413}"] = "",

	-- Step 8: Hand in the Sealed Apprentice Crate · Marcy Baker, Three Corners, Redridge
	-- {item:248765} Sealed Apprentice Crate · {npc:256390} Marcy Baker · {area:1002} Three Corners
	["Hand in the {item:248765} · {npc:256390}, {area:1002}, Redridge"] = "",
	["Merchant's Favor and silver; crates give no reputation."] = "",

	-- Step 9: Hand in the Sealed Apprentice Crate · Dokimi, outside the Crossroads, The Barrens
	-- {item:248765} Sealed Apprentice Crate · {npc:256386} Dokimi · {zone:1413} The Barrens
	["Hand in the {item:248765} · {npc:256386}, outside the Crossroads, {zone:1413}"] = "",

	-- Step 10: Get a Sealed Journeyman's Writ
	-- {item:262888} Sealed Journeyman's Writ
	["Get a {item:262888}"] = "",
	["Mobs of about level 11 to 31 drop them; the Auction House sells writs too."] = "",

	-- Step 11: Open the Sealed Journeyman's Writ
	-- {item:262888} Sealed Journeyman's Writ
	["Open the {item:262888}"] = "",
	["Inside is one Craftsman's Writ for a crafted item."] = "",

	-- Step 12: Start the quest on your Craftsman's Writ
	["Start the quest on your Craftsman's Writ"] = "",
	["Each writ once a day; as many different writs a day as you like."] = "",
	["Right-click the Craftsman's Writ in your bags"] = "",

	-- Step 13: Bring your writ to Kzixx · north of Darkshire, Duskwood
	-- {npc:3134} Kzixx · {area:42} Darkshire · {zone:1431} Duskwood
	["Bring your writ to {npc:3134} · north of {area:42}, {zone:1431}"] = "",
	["No quest mark: right-click them."] = "",
	-- {item:6048} Shadow Protection Potion
	["{item:6048}, 75 reputation"] = "{item:6048}, 75 de reputación",
	-- {item:4381} Minor Recombobulator
	["{item:4381}, 75 reputation"] = "{item:4381}, 75 de reputación",
	-- {item:2317} Dark Leather Tunic
	["{item:2317}, 75 reputation"] = "{item:2317}, 75 de reputación",
	-- {item:4245} Small Silk Pack
	["{item:4245}, 75 reputation"] = "{item:4245}, 75 de reputación",

	-- Step 14: Bring your writ to "Sea Wolf" MacKinley · Booty Bay inn, top floor
	-- {area:35} Booty Bay
	["Bring your writ to \"Sea Wolf\" MacKinley · {area:35} inn, top floor"] = "",
	["No quest mark: right-click them. MacKinley is on the top floor of the inn."] = "",
	-- {item:3485} Green Iron Gauntlets
	["{item:3485}, 75 reputation"] = "{item:3485}, 75 de reputación",

	-- Step 15: Bring your writ to Scooty · Booty Bay's goblin transporter
	-- {npc:7853} Scooty · {area:35} Booty Bay
	["Bring your writ to {npc:7853} · {area:35}'s goblin transporter"] = "",
	-- {item:7506} Gnomish Universal Remote
	["{item:7506}, 75 reputation"] = "{item:7506}, 75 de reputación",

	-- Step 16: Bring your writ to Narkk · Booty Bay
	-- {npc:2663} Narkk · {area:35} Booty Bay
	["Bring your writ to {npc:2663} · {area:35}"] = "",
	-- {item:4252} Dark Leather Shoulders
	["{item:4252}, 75 reputation"] = "{item:4252}, 75 de reputación",

	-- Step 17: Bring your writ to Short John Mithril · Gurubashi Arena, Stranglethorn Vale
	-- {npc:14508} Short John Mithril · {area:1741} Gurubashi Arena · {zone:1434} Stranglethorn Vale
	["Bring your writ to {npc:14508} · {area:1741}, {zone:1434}"] = "",
	-- {item:3388} Lesser Troll's Blood Elixir
	["{item:3388}, 75 reputation"] = "{item:3388}, 75 de reputación",

	-- Step 18: Bring your writ to Hekshi · northern Stranglethorn Vale
	-- {npc:261961} Hekshi · {zone:1434} Stranglethorn Vale
	["Bring your writ to {npc:261961} · northern {zone:1434}"] = "",
	-- {item:10048} Colorful Kilt
	["{item:10048}, 75 reputation"] = "{item:10048}, 75 de reputación",

	-- Step 19: Bring your writ to Kixxle · south of Dun Modr, Wetlands
	-- {npc:8305} Kixxle · {area:205} Dun Modr · {zone:1437} Wetlands
	["Bring your writ to {npc:8305} · south of {area:205}, {zone:1437}"] = "",
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

	-- Step 20: Bring your writ to Muggol Breezebeard · south of Refuge Pointe, Arathi Highlands
	-- {npc:257296} Muggol Breezebeard · {area:320} Refuge Pointe · {zone:1417} Arathi Highlands
	["Bring your writ to {npc:257296} · south of {area:320}, {zone:1417}"] = "",
	-- {item:3383} Elixir of Wisdom
	["{item:3383}, 75 reputation"] = "{item:3383}, 75 de reputación",
	-- {item:11128} Golden Rod
	["{item:11128}, 75 reputation"] = "{item:11128}, 75 de reputación",

	-- Step 21: Get the Explosive Sheep for your writ
	-- {item:4384} Explosive Sheep
	["Get the {item:4384} for your writ"] = "",
	["Any player's craft counts, so the Auction House works; you need not know the profession."] = "",

	-- Step 22: Bring your writ to Alyce · north-west of Refuge Pointe, Arathi Highlands
	-- {npc:257304} Alyce · {area:320} Refuge Pointe · {zone:1417} Arathi Highlands
	["Bring your writ to {npc:257304} · north-west of {area:320}, {zone:1417}"] = "",
	-- {item:4384} Explosive Sheep
	["{item:4384}, 75 reputation"] = "{item:4384}, 75 de reputación",
	-- {item:5958} Fine Leather Pants
	["{item:5958}, 75 reputation"] = "{item:5958}, 75 de reputación",
	-- {item:6263} Blue Overalls
	["{item:6263}, 75 reputation"] = "{item:6263}, 75 de reputación",

	-- Step 23: Get the Practice Lock for your writ
	-- {item:6712} Practice Lock
	["Get the {item:6712} for your writ"] = "",

	-- Step 24: Bring your writ to Gorgrash · eastern Hillsbrad Foothills
	-- {npc:261932} Gorgrash · {zone:1424} Hillsbrad Foothills
	["Bring your writ to {npc:261932} · eastern {zone:1424}"] = "",
	-- {item:3491} Heavy Bronze Mace
	["{item:3491}, 75 reputation"] = "{item:3491}, 75 de reputación",
	-- {item:6712} Practice Lock
	["{item:6712}, 75 reputation"] = "{item:6712}, 75 de reputación",

	-- Step 25: Bring your writ to Kris Legace · eastern Hillsbrad Foothills
	-- {npc:3536} Kris Legace · {zone:1424} Hillsbrad Foothills
	["Bring your writ to {npc:3536} · eastern {zone:1424}"] = "",
	-- {item:7358} Pilferer's Gloves
	["{item:7358}, 75 reputation"] = "{item:7358}, 75 de reputación",

	-- Step 26: Bring your writ to Webbed Mudsnout Gnoll · a spider cocoon south-east of Southshore
	-- {npc:261928} Webbed Mudsnout Gnoll · {area:271} Southshore
	["Bring your writ to {npc:261928} · a spider cocoon south-east of {area:271}"] = "",
	-- {item:5634} Free Action Potion
	["{item:5634}, 75 reputation"] = "{item:5634}, 75 de reputación",

	-- Step 27: Get the Heavy Leather Ball for your writ
	-- {item:18662} Heavy Leather Ball
	["Get the {item:18662} for your writ"] = "",

	-- Step 28: Bring your writ to Sos'mol · south-west Alterac Mountains
	-- {npc:257281} Sos'mol · {zone:1416} Alterac Mountains
	["Bring your writ to {npc:257281} · south-west {zone:1416}"] = "",
	-- {item:3391} Elixir of Ogre Strength
	["{item:3391}, 75 reputation"] = "{item:3391}, 75 de reputación",
	-- {item:18662} Heavy Leather Ball
	["{item:18662}, 75 reputation"] = "{item:18662}, 75 de reputación",

	-- Step 29: Bring your writ to Alan Sneeks · south-west Alterac Mountains
	-- {npc:257282} Alan Sneeks · {zone:1416} Alterac Mountains
	["Bring your writ to {npc:257282} · south-west {zone:1416}"] = "",
	["No quest mark: right-click them. Syndicate thugs roam around him."] = "",
	-- {item:5540} Pearl-handled Dagger
	["{item:5540}, 75 reputation"] = "{item:5540}, 75 de reputación",
	-- {item:5507} Ornate Spyglass
	["{item:5507}, 75 reputation"] = "{item:5507}, 75 de reputación",
	-- {item:5766} Lesser Wizard's Robe
	["{item:5766}, 75 reputation"] = "{item:5766}, 75 de reputación",

	-- Step 30: Bring your writ to Bath'rah the Windwatcher · above Tarren Mill, Alterac Mountains
	-- {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill · {zone:1416} Alterac Mountains
	["Bring your writ to {npc:6176} · above {area:272}, {zone:1416}"] = "",
	-- {item:4317} Phoenix Pants
	["{item:4317}, 75 reputation"] = "{item:4317}, 75 de reputación",

	-- Step 31: Get the Lesser Mana Potion for your writ
	-- {item:3385} Lesser Mana Potion
	["Get the {item:3385} for your writ"] = "",

	-- Step 32: Bring your writ to Ash'alari · south-west of Splintertree Post, Ashenvale
	-- {npc:257315} Ash'alari · {area:431} Splintertree Post · {zone:1440} Ashenvale
	["Bring your writ to {npc:257315} · south-west of {area:431}, {zone:1440}"] = "",
	-- {item:3385} Lesser Mana Potion
	["{item:3385}, 75 reputation"] = "{item:3385}, 75 de reputación",

	-- Step 33: Bring your writ to Murache · south of Splintertree Post, Ashenvale
	-- {npc:257322} Murache · {area:431} Splintertree Post · {zone:1440} Ashenvale
	["Bring your writ to {npc:257322} · south of {area:431}, {zone:1440}"] = "",
	-- {item:7349} Herbalist's Gloves
	["{item:7349}, 75 reputation"] = "{item:7349}, 75 de reputación",

	-- Step 34: Bring your writ to Cowardly Peon · south-east of Splintertree Post, Ashenvale
	-- {npc:257316} Cowardly Peon · {area:431} Splintertree Post · {zone:1440} Ashenvale
	["Bring your writ to {npc:257316} · south-east of {area:431}, {zone:1440}"] = "",
	-- {item:5541} Iridescent Hammer
	["{item:5541}, 75 reputation"] = "{item:5541}, 75 de reputación",
	-- {item:7048} Azure Silk Hood
	["{item:7048}, 75 reputation"] = "{item:7048}, 75 de reputación",

	-- Step 35: Bring your writ to Grembly · north-east of Splintertree Post, Ashenvale
	-- {npc:257317} Grembly · {area:431} Splintertree Post · {zone:1440} Ashenvale
	["Bring your writ to {npc:257317} · north-east of {area:431}, {zone:1440}"] = "",
	-- {item:4383} Moonsight Rifle
	["{item:4383}, 75 reputation"] = "{item:4383}, 75 de reputación",

	-- Step 36: Get the Heavy Quiver for your writ
	-- {item:7371} Heavy Quiver
	["Get the {item:7371} for your writ"] = "",

	-- Step 37: Bring your writ to Ziz Fizziks · east of Sun Rock Retreat, Stonetalon Mountains
	-- {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat · {zone:1442} Stonetalon Mountains
	["Bring your writ to {npc:4201} · east of {area:460}, {zone:1442}"] = "",
	-- {item:3390} Elixir of Lesser Agility
	["{item:3390}, 75 reputation"] = "{item:3390}, 75 de reputación",
	-- {item:2865} Rough Bronze Leggings
	["{item:2865}, 75 reputation"] = "{item:2865}, 75 de reputación",
	-- {item:4373} Shadow Goggles
	["{item:4373}, 75 reputation"] = "{item:4373}, 75 de reputación",
	-- {item:7371} Heavy Quiver
	["{item:7371}, 75 reputation"] = "{item:7371}, 75 de reputación",

	-- Step 38: Get the Elixir of Defense for your writ
	-- {item:8951} Elixir of Defense
	["Get the {item:8951} for your writ"] = "",

	-- Step 39: Bring your writ to Rizzle Brassbolts · Mirage Raceway, Thousand Needles
	-- {npc:4720} Rizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1441} Thousand Needles
	["Bring your writ to {npc:4720} · {area:2240}, {zone:1441}"] = "",
	-- {item:8951} Elixir of Defense
	["{item:8951}, 75 reputation"] = "{item:8951}, 75 de reputación",

	-- Step 40: Bring your writ to "Plucky" Johnson · Mirage Raceway, Thousand Needles
	-- {area:2240} Mirage Raceway · {zone:1441} Thousand Needles
	["Bring your writ to \"Plucky\" Johnson · {area:2240}, {zone:1441}"] = "",
	-- {item:3848} Big Bronze Knife
	["{item:3848}, 75 reputation"] = "{item:3848}, 75 de reputación",

	-- Step 41: Bring your writ to Razzeric · Mirage Raceway, Thousand Needles
	-- {npc:4706} Razzeric · {area:2240} Mirage Raceway · {zone:1441} Thousand Needles
	["Bring your writ to {npc:4706} · {area:2240}, {zone:1441}"] = "",
	-- {item:4380} Big Bronze Bomb
	["{item:4380}, 75 reputation"] = "{item:4380}, 75 de reputación",

	-- Step 42: Bring your writ to Goblin Pit Boss · Mirage Raceway, Thousand Needles
	-- {npc:4496} Goblin Pit Boss · {area:2240} Mirage Raceway · {zone:1441} Thousand Needles
	["Bring your writ to {npc:4496} · {area:2240}, {zone:1441}"] = "",
	-- {item:4254} Barbaric Gloves
	["{item:4254}, 75 reputation"] = "{item:4254}, 75 de reputación",

	-- Step 43: Bring your writ to Magus Tirth · Mirage Raceway, Thousand Needles
	-- {npc:6548} Magus Tirth · {area:2240} Mirage Raceway · {zone:1441} Thousand Needles
	["Bring your writ to {npc:6548} · {area:2240}, {zone:1441}"] = "",
	-- {item:6264} Greater Adept's Robe
	["{item:6264}, 75 reputation"] = "{item:6264}, 75 de reputación",

	-- Step 44: Bring your writ to Lotwil Veriatus · east of Kargath, Badlands
	-- {npc:2921} Lotwil Veriatus · {area:340} Kargath · {zone:1418} Badlands
	["Bring your writ to {npc:2921} · east of {area:340}, {zone:1418}"] = "",
	-- {item:6050} Frost Protection Potion
	["{item:6050}, 125 reputation"] = "{item:6050}, 125 de reputación",

	-- Step 45: Reach Friendly
	["Reach Friendly"] = "",
	-- {quest:98247} Shipping Label
	["After the {quest:98247}, about 14 Journeyman writs, 8 Expert or 5 Artisan."] = "",

	-- Step 46: Buy a Forged Delivery Receipt · Dianne Softstep, Three Corners, Redridge
	-- {item:262902} Forged Delivery Receipt · {npc:256742} Dianne Softstep · {area:1002} Three Corners
	["Buy a {item:262902} · {npc:256742}, {area:1002}, Redridge"] = "",
	-- {item:248549} Waylaid Crate
	["15 Merchant's Favor. It turns an empty {item:248549} into 50 reputation."] = "",

	-- Step 47: Buy a Forged Delivery Receipt · Kurvelk Shadowhoof, outside the Crossroads, The Barrens
	-- {item:262902} Forged Delivery Receipt · {npc:256672} Kurvelk Shadowhoof · {zone:1413} The Barrens
	["Buy a {item:262902} · {npc:256672}, outside the Crossroads, {zone:1413}"] = "",

	-- Step 48: Buy a Waylaid Crate: Apprentice Textiles
	-- {item:248549} Waylaid Crate
	["The receipt works on any {item:248549}, so the cheapest will do."] = "",

	-- Step 49: Use the receipt on the crate
	["Use the receipt on the crate"] = "",
	-- {item:262917} Notarized Shipping Container
	["It makes a {item:262917}."] = "",

	-- Step 50: Hand in the Notarized Shipping Container · Marcy Baker, Three Corners, Redridge
	-- {item:262917} Notarized Shipping Container · {npc:256390} Marcy Baker · {area:1002} Three Corners
	["Hand in the {item:262917} · {npc:256390}, {area:1002}, Redridge"] = "",
	["50 reputation."] = "",

	-- Step 51: Hand in the Notarized Shipping Container · Dokimi, outside the Crossroads, The Barrens
	-- {item:262917} Notarized Shipping Container · {npc:256386} Dokimi · {zone:1413} The Barrens
	["Hand in the {item:262917} · {npc:256386}, outside the Crossroads, {zone:1413}"] = "",

	-- Step 87: Bring your writ to Lotwil Veriatus · east of Kargath, Badlands
	["No quest mark: right-click them. The one Expert customer in the data."] = "",

	-- Step 88: Reach Honored
	["Reach Honored"] = "",
	-- {item:262896} Forger's Quill
	["Writs and crate returns, as before; Honored opens the {item:262896} and the last recipes."] = "",

	-- Step 89: Reach Revered
	["Reach Revered"] = "",
	["Writs and crate returns, as before."] = "",

	-- Step 90: Buy the Packmule Treat · Tamelyn Aldridge, Three Corners, Redridge
	-- {item:284664} Packmule Treat · {npc:256389} Tamelyn Aldridge · {area:1002} Three Corners
	["Buy the {item:284664} · {npc:256389}, {area:1002}, Redridge"] = "",
	["1,500 Merchant's Favor: the Minimule pet."] = "",

	-- Step 91: Buy the Packmule Treat · Gishah, outside the Crossroads, The Barrens
	-- {item:284664} Packmule Treat · {npc:256384} Gishah · {zone:1413} The Barrens
	["Buy the {item:284664} · {npc:256384}, outside the Crossroads, {zone:1413}"] = "",

	-- Step 92: Reach Exalted
	["Reach Exalted"] = "",
	["21,000 more: about 280 Journeyman writs or 420 crate returns."] = "",

	-- Step 93: Buy your camp's tabard · Tamelyn Aldridge, Three Corners, Redridge
	-- {npc:256389} Tamelyn Aldridge · {area:1002} Three Corners
	["Buy your camp's tabard · {npc:256389}, {area:1002}, Redridge"] = "",
	-- {npc:10636} Pack Kodo
	["200 Merchant's Favor. The {npc:10636} (6,000) has its own guide under Collectibles."] = "",

	-- Step 94: Buy your camp's tabard · Gishah, outside the Crossroads, The Barrens
	-- {npc:256384} Gishah · {zone:1413} The Barrens
	["Buy your camp's tabard · {npc:256384}, outside the Crossroads, {zone:1413}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:7371} for the writ"] = "Un {item:7371} para el encargo",
	-- ["A {item:7371} for the writ again"] = "Un {item:7371} para el encargo otra vez",
	-- ["After the {quest:98247}, Friendly is 1000 more: 14 Journeyman writs, 8 Expert or 5 Artisan. Expert and Artisan customers are mostly not in Polestar's data yet: follow the mark the quest puts on your map. Journeyman envelopes drop from mobs of about level 11 to 31; Expert and Artisan ones from higher mobs."] = "Después de la {quest:98247}, Amistoso está a 1000 más: 14 encargos de Oficial, 8 de Experto o 5 de Artesano. Los clientes de Experto y Artesano en su mayoría todavía no están en los datos de Polestar: sigue la marca que la misión pone en tu mapa. Los sobres de Oficial los sueltan enemigos de nivel 11 a 31 más o menos; los de Experto y Artesano, enemigos de más nivel.",
	-- ["All five stand at the {area:2240} on the {area:439}, south-east of {area:484}: {npc:4720}, the chicken \"Plucky\" Johnson, {npc:4706}, the {npc:4496} and {npc:6548}. Customers show no quest mark: right-click them anyway."] = "Los cinco están en {area:2240}, en {area:439}, al sureste de {area:484}: {npc:4720}, el pollo \"Plucky\" Johnson, {npc:4706}, el {npc:4496} y {npc:6548}. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["All four stand around {area:431}: {npc:257315} about 850 yards south-west of it, {npc:257322} to the south, the {npc:257316} about 350 yards south-east and {npc:257317} about 650 yards north-east. Customers show no quest mark: right-click them anyway."] = "Los cuatro están alrededor de {area:431}: {npc:257315} a unos 850 metros al suroeste, {npc:257322} al sur, el {npc:257316} a unos 350 metros al sureste y {npc:257317} a unos 650 metros al noreste. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["Craftsman's Writs are the camp's reputation: 75 for a Journeyman writ, 125 for an Expert, 200 for an Artisan. Each asks for one crafted item, the one its title names. Make it or buy it on the Auction House; you need not know the profession. Each writ can be done once a day, and any number of different ones. Take the quest only of writs whose item you have or will buy on the way (right-click the writ), keep the writ in your bags, then tick this: the next steps lead to each customer you hold a writ for."] = "Los encargos de artesano son la reputación del campamento: 75 por un encargo de Oficial, 125 por uno de Experto, 200 por uno de Artesano. Cada uno pide un objeto fabricado, el que nombra su título. Fabrícalo o cómpralo en la casa de subastas; no necesitas conocer la profesión. Cada encargo se puede hacer una vez al día, y todos los distintos que quieras. Toma la misión solo de los encargos cuyo objeto tengas o vayas a comprar por el camino (clic derecho en el encargo), guarda el encargo en tus bolsas, y luego marca esto: los pasos siguientes te llevan a cada cliente para el que tengas un encargo.",
	-- ["Dokimi"] = "Dokimi",
	-- ["Exalted"] = "Exaltado",
	-- ["Exalted opens the camp's tabard (200 Favor) at {npc:256389} or {npc:256384}, and the {item:262766} (6,000 Favor; the mount needs level 60 and Journeyman mount training) at {npc:256736} in {area:1002} or Okamache at the Crossroads camp. The {npc:10636} guide under Collectibles leads you there."] = "Exaltado abre el tabardo del campamento (200 de Favor) con {npc:256389} o {npc:256384}, y las {item:262766} (6.000 de Favor; la montura requiere nivel 60 y el entrenamiento de equitación de Oficial) con {npc:256736} en {area:1002} u Okamache en el campamento del Cruce. La guía de {npc:10636}, en Coleccionables, te lleva hasta allí.",
	-- ["Friendly opens the first gated recipes at the camp's profession vendors ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) and the Uncertified Scribe: {npc:256742} at {area:1002}, {npc:256672} at the south end of the Crossroads camp. The scribe's {item:262902} (15 Merchant's Favor) turns an empty {item:248549} into a {item:262917}; hand it to {npc:256390} or {npc:256386} for 50 reputation ({quest:93862}). Any crate works, so buy the cheapest one the Auction House has. Honored is 6000 more: 80 Journeyman writs, 48 Expert, 30 Artisan, or 120 crate returns (1,800 Favor and 120 crates). Mix both: every writ you can fill, returns with spare Favor. The Legacy perk Diplomat adds up to 10% to every gain."] = "Amistoso abre las primeras recetas bloqueadas en los vendedores de profesiones del campamento ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) y al escriba sin certificar: {npc:256742} en {area:1002}, {npc:256672} en el extremo sur del campamento del Cruce. El {item:262902} del escriba (15 de Favor del mercader) convierte un {item:248549} vacío en un {item:262917}; entrégalo a {npc:256390} o {npc:256386} por 50 de reputación ({quest:93862}). Sirve cualquier cajón, así que compra el más barato que tenga la casa de subastas. Honorable está a 6000 más: 80 encargos de Oficial, 48 de Experto, 30 de Artesano o 120 devoluciones de cajones (1.800 de Favor y 120 cajones). Combina las dos cosas: cada encargo que puedas cumplir, y devoluciones con el Favor que te sobre. La ventaja Diplomático del Legado suma hasta un 10% a cada ganancia.",
	-- ["Friendly to Honored"] = "De Amistoso a Honorable",
	-- ["From level 10, mobs anywhere drop Waylaid Crates and sealed writs (Journeyman's, Expert's and Artisan's). Fill a crate with one of the bundles it lists (right-click it), or open a sealed writ: by beta reports, the first time you do either you also get a {quest:98247}. Right-click the label to start its quest. Crates and writs can be traded, so the Auction House sells them too."] = "Desde el nivel 10, los enemigos de cualquier lugar sueltan cajones saqueados y encargos sellados (de Oficial, de Experto y de Artesano). Llena un cajón con uno de los lotes que pide (clic derecho en él), o abre un encargo sellado: según informes de la beta, la primera vez que haces cualquiera de las dos cosas también recibes una {quest:98247}. Haz clic derecho en la etiqueta para iniciar su misión. Los cajones y los encargos se pueden comerciar, así que la casa de subastas también los vende.",
	-- ["Gather your writs"] = "Junta tus encargos",
	-- ["Gather your writs again"] = "Junta tus encargos otra vez",
	-- ["Honored opens the rest of the gated recipes ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), the {item:270887} (1,200 Favor from {npc:256389} or {npc:256384}: it starts the quest for a Tradeskill Sign toy) and the scribe's {item:262896} (15 Favor), which swaps a writ you cannot fill for a random one of the same rank. Revered is 12000 more: 160 Journeyman writs, 96 Expert, 60 Artisan, or 240 crate returns (3,600 Favor). Forever's quest data sets no standing limit on Journeyman writs: their customers are the ones in the zone steps above."] = "Honorable abre el resto de las recetas bloqueadas ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), la {item:270887} (1.200 de Favor con {npc:256389} o {npc:256384}: inicia la misión de un juguete de cartel de profesión) y el {item:262896} del escriba (15 de Favor), que cambia un encargo que no puedes cumplir por uno al azar del mismo rango. Reverenciado está a 12000 más: 160 encargos de Oficial, 96 de Experto, 60 de Artesano o 240 devoluciones de cajones (3.600 de Favor). Los datos de misiones de Forever no ponen límite de reputación a los encargos de Oficial: sus clientes son los de los pasos por zona de arriba.",
	-- ["Honored to Revered"] = "De Honorable a Reverenciado",
	-- ["Keep filling Waylaid Crates for Dokimi until Exalted."] = "Sigue llenando Cajones saqueados para Dokimi hasta Exaltado.",
	-- ["Keep filling Waylaid Crates for Dokimi."] = "Sigue llenando Cajones saqueados para Dokimi.",
	-- ["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "Sigue llenando Cajones saqueados para {npc:214101} hasta Exaltado.",
	-- ["Keep filling Waylaid Crates for {npc:214101}."] = "Sigue llenando Cajones saqueados para {npc:214101}.",
	-- ["Leatherworkers make the {item:7371}; the bow and gun vendors of {zone:1453}, {zone:1455} and the {zone:1458} sell it. Otherwise buy one at the Auction House."] = "Los peleteros fabrican el {item:7371}; los vendedores de arcos y armas de fuego de {zone:1453}, {zone:1455} y {zone:1458} lo venden. Si no, compra uno en la casa de subastas.",
	-- ["Merchant's Favor Reputation"] = "Reputación: Favor de mercader",
	-- ["Neutral to Friendly"] = "De Neutral a Amistoso",
	-- ["Revered opens the {item:284664}, the Minimule pet (1,500 Favor from {npc:256389} or {npc:256384}). Exalted is 21000 more: 280 Journeyman writs, 168 Expert, 105 Artisan, or 420 crate returns (6,300 Favor). Keep 6,000 Favor for the {npc:10636} if you want it."] = "Reverenciado abre el {item:284664}, la mascota Minimula (1.500 de Favor con {npc:256389} o {npc:256384}). Exaltado está a 21000 más: 280 encargos de Oficial, 168 de Experto, 105 de Artesano o 420 devoluciones de cajones (6.300 de Favor). Guarda 6.000 de Favor para el {npc:10636} si lo quieres.",
	-- ["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- ["Take the quests of the writs you can fill"] = "Toma las misiones de los encargos que puedas cumplir",
	-- ["The {faction:2586} camp is at {area:1002}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet in western Redridge. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256390} too, but they pay only Merchant's Favor and silver, never reputation."] = "El campamento de {faction:2586} está en {area:1002}, donde se juntan los caminos de {zone:1429}, {zone:1431} y {area:69}, en el oeste de Crestagrana. La etiqueta paga 2000 de reputación una sola vez (y, según informes de la beta, 50 de Favor del mercader): dos tercios del camino a Amistoso. Los cajones llenos también van a {npc:256390}, pero solo pagan Favor del mercader y plata, nunca reputación.",
	-- ["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "La {faction:2586} es la facción de profesiones de la Alianza en Forever. Su campamento está en {area:1002}, al oeste de {zone:1433}. Desde el nivel 10 los enemigos sueltan Cajones saqueados: llena cada uno con los bienes que pide su etiqueta y entrega el {object:1561} a {npc:214101} en el campamento a cambio de reputación y Favor del mercader. La ventaja de Legado Diplomático de Forever aumenta la reputación obtenida.",
	-- ["The {faction:2587} camp stands just outside the west gate of the Crossroads. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256386} too, but they pay only Merchant's Favor and silver, never reputation."] = "El campamento de {faction:2587} está justo afuera de la puerta oeste del Cruce. La etiqueta paga 2000 de reputación una sola vez (y, según informes de la beta, 50 de Favor del mercader): dos tercios del camino a Amistoso. Los cajones llenos también van a {npc:256386}, pero solo pagan Favor del mercader y plata, nunca reputación.",
	-- ["Your first {item:248549} or writ"] = "Tu primer {item:248549} o encargo",
	-- ["bring it: craft it or buy it at the Auction House"] = "tráelo: fabrícalo o cómpralo en la casa de subastas",
	-- ["bring it: engineers make it; {npc:789} in {area:69} lists it (not yet seen in her window up to level 30), or the Auction House"] = "tráelo: lo fabrican los ingenieros; {npc:789}, en {area:69}, lo tiene en su lista (todavía no visto en su ventana hasta el nivel 30), o la casa de subastas",
	-- ["bring it: leatherworkers make it, or buy it at the Auction House"] = "tráelo: lo fabrican los peleteros, o cómpralo en la casa de subastas",
	-- ["{area:1002}: the {quest:98247}"] = "{area:1002}: la {quest:98247}",
	-- ["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853} at the zeppelin-style transporter pad and {npc:2663}. {npc:14508} stands about 800 yards south of {object:3202}, by the {area:1741}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35} tiene tres clientes: \"Lobo de Mar\" MacKinley (en el último piso de la posada), {npc:7853} en la plataforma del transportador y {npc:2663}. {npc:14508} está a unos 800 metros al sur de {object:3202}, junto a {area:1741}; {npc:261961} está en el norte de Tuercespina. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853}, the goblin transporter's engineer, and {npc:2663}. {npc:14508} stands at the {area:1741}, about 800 yards south of {object:3202}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35} tiene tres clientes: \"Lobo de Mar\" MacKinley (en el último piso de la posada), {npc:7853}, el ingeniero del transportador goblin, y {npc:2663}. {npc:14508} está en {area:1741}, unos 800 metros al sur de {object:3202}; {npc:261961} está en el norte de Tuercespina. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["{area:380} camp: the {quest:98248}"] = "Campamento de {area:380}: la {quest:98248}",
	-- ["{faction:2586} to Exalted"] = "{faction:2586} a Exaltado",
	-- ["{faction:2586} to Friendly"] = "{faction:2586} a Amistoso",
	-- ["{faction:2586} to Honored"] = "{faction:2586} a Honorable",
	-- ["{faction:2586} to Revered"] = "{faction:2586} a Venerado",
	-- ["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587} es la facción de profesiones de la Horda en Forever. Su campamento está justo a las afueras de {area:380}, en {zone:1413}. Desde el nivel 10 los enemigos sueltan Cajones saqueados: llena cada uno con los bienes que pide su etiqueta y entrega el {object:1561} a Dokimi en el campamento a cambio de reputación y Favor del mercader. La ventaja de Legado Diplomático de Forever aumenta la reputación obtenida.",
	-- ["{faction:2587} to Exalted"] = "{faction:2587} a Exaltado",
	-- ["{faction:2587} to Friendly"] = "{faction:2587} a Amistoso",
	-- ["{faction:2587} to Honored"] = "{faction:2587} a Honorable",
	-- ["{faction:2587} to Revered"] = "{faction:2587} a Venerado",
	-- ["{item:262764}, 200 Merchant's Favor"] = "{item:262764}, 200 de Favor del mercader",
	-- ["{item:262765}, 200 Merchant's Favor"] = "{item:262765}, 200 de Favor del mercader",
	-- ["{item:262902}, 15 Merchant's Favor"] = "{item:262902}, 15 de Favor del mercader",
	-- ["{item:270887}, 1,200 Merchant's Favor"] = "{item:270887}, 1.200 de Favor del mercader",
	-- ["{item:284664}, 1,500 Merchant's Favor"] = "{item:284664}, 1.500 de Favor del mercader",
	-- ["{npc:257281} and {npc:257282} are close together in the south-west of the mountains; Syndicate thugs roam around {npc:257282}. {npc:6176} stands on the eastern edge, above {area:272}. Customers show no quest mark: right-click them anyway."] = "{npc:257281} y {npc:257282} están cerca uno del otro en el suroeste de las montañas; hay matones del Sindicato alrededor de {npc:257282}. {npc:6176} está en el borde este, sobre {area:272}. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["{npc:257296} is about 250 yards south of {area:320}, {npc:257304} about 700 yards north-west of it. Customers show no quest mark: right-click them anyway."] = "{npc:257296} está a unos 250 metros al sur de {area:320}, {npc:257304} a unos 700 metros al noroeste. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["{npc:261932} and {npc:3536} are in the east of the foothills; the {npc:261928} hangs in a spider cocoon about 500 yards south-east of {area:271}. Customers show no quest mark: right-click them anyway."] = "{npc:261932} y {npc:3536} están en el este de las laderas; el {npc:261928} cuelga en un capullo de araña a unos 500 metros al sureste de {area:271}. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["{npc:2921} works about 550 yards east of {area:340}. He is the only Expert customer Polestar's data knows."] = "{npc:2921} trabaja a unos 550 metros al este de {area:340}. Es el único cliente de Experto que conocen los datos de Polestar.",
	-- ["{npc:3134} stands about 450 yards north of {area:42}, by the road. Customers show no quest mark: right-click them anyway."] = "{npc:3134} está a unos 450 metros al norte de {area:42}, junto al camino. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["{npc:3134} stands about 450 yards north of {area:42}. Customers show no quest mark: right-click them anyway."] = "{npc:3134} está a unos 450 metros al norte de {area:42}. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["{npc:4201} has a small hut about 550 yards east of {area:460}. Four Journeyman writs go to him. Customers show no quest mark: right-click them anyway."] = "{npc:4201} tiene una casita a unos 550 metros al este de {area:460}. Cuatro encargos de Oficial van para él. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["{npc:8305} stands about 600 yards south of {area:205}. Five Journeyman writs go to him: the most of any customer. Customers show no quest mark: right-click them anyway."] = "{npc:8305} está a unos 600 metros al sur de {area:205}. Cinco encargos de Oficial van para él: el que más tiene de todos los clientes. Los clientes no muestran marca de misión: haz clic derecho en ellos igual.",
	-- ["{quest:93862}: 50 reputation"] = "{quest:93862}: 50 de reputación",
	-- ["{zone:1416} writ customers"] = "Clientes de encargos en {zone:1416}",
	-- ["{zone:1416} writ customers again"] = "Clientes de encargos en {zone:1416} otra vez",
	-- ["{zone:1417} writ customers"] = "Clientes de encargos en {zone:1417}",
	-- ["{zone:1417} writ customers again"] = "Clientes de encargos en {zone:1417} otra vez",
	-- ["{zone:1418} writ customer"] = "Cliente de encargos en {zone:1418}",
	-- ["{zone:1424} writ customers"] = "Clientes de encargos en {zone:1424}",
	-- ["{zone:1424} writ customers again"] = "Clientes de encargos en {zone:1424} otra vez",
	-- ["{zone:1431} writ customers"] = "Clientes de encargos en {zone:1431}",
	-- ["{zone:1431} writ customers again"] = "Clientes de encargos en {zone:1431} otra vez",
	-- ["{zone:1434} writ customers"] = "Clientes de encargos en {zone:1434}",
	-- ["{zone:1434} writ customers again"] = "Clientes de encargos en {zone:1434} otra vez",
	-- ["{zone:1437} writ customers"] = "Clientes de encargos en {zone:1437}",
	-- ["{zone:1437} writ customers again"] = "Clientes de encargos en {zone:1437} otra vez",
	-- ["{zone:1440} writ customers"] = "Clientes de encargos en {zone:1440}",
	-- ["{zone:1440} writ customers again"] = "Clientes de encargos en {zone:1440} otra vez",
	-- ["{zone:1441} writ customers"] = "Clientes de encargos en {zone:1441}",
	-- ["{zone:1441} writ customers again"] = "Clientes de encargos en {zone:1441} otra vez",
	-- ["{zone:1442} writ customers"] = "Clientes de encargos en {zone:1442}",
	-- ["{zone:1442} writ customers again"] = "Clientes de encargos en {zone:1442} otra vez",
}
