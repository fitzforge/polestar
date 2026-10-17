-- Spanish (Latin America) (esMX): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "Cuatro piezas de armadura a nivel 30 (camisote, yelmo, guanteletes, musleras) y un escudo por el camino.",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "A nivel 20, {npc:3354} en {object:172958} te manda con {npc:6394} en {area:378}.",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "A nivel 20, {npc:3041}, el instructor de guerreros de {zone:1456}, te manda con {npc:6394} en {area:378}.",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "A nivel 20, {npc:4595}, un instructor de guerreros de {zone:1458}, te manda con {npc:6394} en {area:378}.",

	-- Step 4: Trial at the Field of Giants
	-- {area:378} Camp Taurajo · {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "Vuela a {area:378}. Al sur del campamento, los Montículos de silítidos salpican la {area:390}: los silítidos de ahí llevan las Antenas agitadas.",
	["Twitching Antennae from the silithid"] = "Antenas agitadas de los silítidos",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1838} Brutal Armor
	["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878} acampa junto al camino al este de {area:380}. {quest:1838} es una misión de nivel 30; puedes aceptarla ya y reunir lo necesario por el camino.",

	-- Step 6: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Roogug en {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Roogug es un jabaespín élite dentro de {area:1717}, el calabozo del extremo sur de {zone:1413}; suelta el {item:6841}. {area:1717} es un calabozo: se recomienda ir en grupo.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, de Roogug",

	-- Step 7: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "La {area:2160} está en el extremo este del {area:461}, en Sierra Espolón. Sus kóbolds sueltan los Lingotes de hierro humeante.",
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["Smoky Iron Ingots from the Windshear kobolds"] = "Lingotes de hierro humeante de los kóbolds Cortaviento",

	-- Step 8: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "Mineros de Trabalomas ({npc:2269})",
	-- {zone:1424} Hillsbrad Foothills · {item:7127} Powdered Azurite · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Los Mineros de Trabalomas ({npc:2269}) trabajan en la mina del oeste de {zone:1424}; sueltan la {item:7127}. Toma el zepelín de {zone:1454} a {zone:1420} y cabalga al sur por {zone:1421}.",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127} from the Hillsbrad Miners"] = "{item:7127} de los Mineros de Trabalomas ({npc:2269})",

	-- Step 9: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "Barras de hierro",
	-- {item:2772} Iron Ore · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Los mineros funden Barras de hierro con {item:2772} ({skill:186} 125); los demás las compran en la casa de subastas de {zone:1454}.",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "Barras de hierro: {npc:8673}",

	-- Step 10: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "Vuelve con {npc:5878} junto al camino al este de {area:380}. {quest:1848} es la primera pieza; luego te manda con tres artesanos para el resto.",

	-- Step 11: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408} está en {area:367}, en la costa de {zone:1411}.",

	-- Step 12: Satyr Hooves
	-- {area:429} Xavian · {zone:1440} Ashenvale
	["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "Los sátiros de {area:429} acampan en el este de {zone:1440}, con los sátiros Putredor más al oeste; ambos sueltan Pezuñas de sátiro sin rajar.",
	-- {quest:1842} Satyr Hooves
	["Uncloven {quest:1842}"] = "{quest:1842} sin rajar",

	-- Step 15: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "La {npc:6167} recorre el suroeste de Sierra Espolón cerca de las Quimeras volantonas y las Quimeras jóvenes; suelta el {item:6840}.",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{item:6840} de la {npc:6167}",

	-- Step 17: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron
	["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "Toma el zepelín de {zone:1454} a {zone:1420}; {zone:1458} está bajo las {area:153}.",

	-- Step 18: Dragonmaw Shinbones
	-- {zone:1437} Wetlands
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "Los orcos Faucedraco acampan en medio de {zone:1437}, al sur del camino; Asaltantes, Correpantanos, Centuriones, Depositarios de sombras y Guardahuesos sueltan las Tibias de Faucedraco robustas ({item:7134}).",
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Sturdy Dragonmaw Shinbones"] = "Tibias de Faucedraco robustas ({item:7134})",
}
