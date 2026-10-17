-- French (frFR): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "Quatre pièces d'armure au niveau 30 (haubert, heaume, gantelets, jambières) et un bouclier en chemin.",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "Au niveau 20, {npc:3354}, dans la {object:172958}, vous envoie voir {npc:6394} à {area:378}.",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "Au niveau 20, {npc:3041}, maître des guerriers de {zone:1456}, vous envoie voir {npc:6394} à {area:378}.",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "Au niveau 20, {npc:4595}, maître des guerriers de {zone:1458}, vous envoie voir {npc:6394} à {area:378}.",

	-- Step 4: Trial at the Field of Giants
	-- {area:378} Camp Taurajo · {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "Prenez un vol pour {area:378}. Au sud du camp, les Antres des silithides parsèment {area:390} : les silithides qui s'y trouvent portent les Antennes mobiles.",
	["Twitching Antennae from the silithid"] = "Antennes mobiles sur les silithides",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1838} Brutal Armor
	["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878} campe au bord de la route à l'est de {area:380}. {quest:1838} est une quête de niveau 30 ; vous pouvez la prendre maintenant et rassembler ce qu'il faut en chemin.",

	-- Step 6: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Roogug dans {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Roogug est un huran élite dans {area:1717}, le donjon au sud de {zone:1413} ; il lâche la {item:6841}. {area:1717} est un donjon : mieux vaut former un groupe.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, sur Roogug",

	-- Step 7: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "{area:2160} se trouve à l'extrémité est de {area:461}, dans les Serres-Rocheuses. Ses kobolds lâchent les Lingots de fer cendré.",
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["Smoky Iron Ingots from the Windshear kobolds"] = "Lingots de fer cendré sur les kobolds des Cisailles",

	-- Step 8: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "Mineurs d'Hillsbrad ({npc:2269})",
	-- {zone:1424} Hillsbrad Foothills · {item:7127} Powdered Azurite · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Les Mineurs d'Hillsbrad ({npc:2269}) travaillent dans la mine de l'ouest de {zone:1424} ; ils lâchent {item:7127}. Prenez le zeppelin d'{zone:1454} à {zone:1420} et chevauchez vers le sud à travers {zone:1421}.",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127} from the Hillsbrad Miners"] = "{item:7127} sur les Mineurs d'Hillsbrad ({npc:2269})",

	-- Step 9: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "Barres de fer",
	-- {item:2772} Iron Ore · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Les mineurs fondent les Barres de fer à partir de {item:2772} ({skill:186} 125) ; les autres les achètent à l'hôtel des ventes d'{zone:1454}.",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "Barres de fer : {npc:8673}",

	-- Step 10: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "Retournez voir {npc:5878} au bord de la route à l'est de {area:380}. {quest:1848} est la première pièce ; il vous envoie ensuite voir trois artisans pour le reste.",

	-- Step 11: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408} est à {area:367}, sur la côte de {zone:1411}.",

	-- Step 12: Satyr Hooves
	-- {area:429} Xavian · {zone:1440} Ashenvale
	["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "Les satyres de {area:429} campent dans l'est d'{zone:1440}, les satyres Gangremusc plus à l'ouest ; les deux lâchent des Sabots fendus de satyre.",
	-- {quest:1842} Satyr Hooves
	["Uncloven {quest:1842}"] = "{quest:1842} fendus",

	-- Step 15: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "La {npc:6167} rôde au sud-ouest des Serres-Rocheuses près des Petites chimères et des Jeunes chimères ; elle lâche la {item:6840}.",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{item:6840} sur la {npc:6167}",

	-- Step 17: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron
	["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "Prenez le zeppelin d'{zone:1454} pour {zone:1420} ; {zone:1458} se trouve sous les {area:153}.",

	-- Step 18: Dragonmaw Shinbones
	-- {zone:1437} Wetlands
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "Les orcs Dragonmaw campent au milieu des {zone:1437}, au sud de la route ; Ecumeurs, Arpenteurs, Centurions, Veilleurs des ombres et Gardiens Dragonmaw lâchent tous les Solides tibias de Dragonmaw ({item:7134}).",
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Sturdy Dragonmaw Shinbones"] = "Solides tibias de Dragonmaw ({item:7134})",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:287} Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Les Mineurs d'{area:287} travaillent dans la mine à l'ouest de {zone:1424} ; ils lâchent l'{item:7127}. Prenez le zeppelin d'{zone:1454} pour {zone:1420} et chevauchez vers le sud à travers {zone:1421}.",
	-- ["{area:287} Miners"] = "Mineurs d'{area:287}",
	-- ["{item:7127} from the {area:287} Miners"] = "{item:7127} sur les Mineurs d'{area:287}",
}
