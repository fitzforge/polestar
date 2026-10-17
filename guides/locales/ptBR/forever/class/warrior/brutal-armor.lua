-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "Quatro peças de armadura no nível 30 (camisão, elmo, manoplas, perneiras) e um escudo no caminho.",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "No nível 20, {npc:3354} no {object:172958} manda você a {npc:6394} no {area:378}.",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "No nível 20, {npc:3041}, o instrutor de guerreiro de {zone:1456}, manda você a {npc:6394} no {area:378}.",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "No nível 20, {npc:4595}, um instrutor de guerreiro de {zone:1458}, manda você a {npc:6394} no {area:378}.",

	-- Step 4: Trial at the Field of Giants
	-- {area:378} Camp Taurajo · {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "Voe até o {area:378}. Ao sul do acampamento, os Montes de Terra Silitídeos salpicam o {area:390}: os silitídeos de lá levam as Antenas Agitadas.",
	["Twitching Antennae from the silithid"] = "Antenas Agitadas dos silitídeos",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1838} Brutal Armor
	["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878} acampa junto à estrada a leste da {area:380}. {quest:1838} é uma missão de nível 30; você pode pegá-la agora e coletar para ela no caminho.",

	-- Step 6: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Rugug em {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Rugug é um javaligno de elite dentro de {area:1717}, a masmorra no extremo sul de {zone:1413}; ele deixa cair o {item:6841}. {area:1717} é uma masmorra: é recomendado formar grupo.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, de Rugug",

	-- Step 7: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "A {area:2160} fica no extremo leste do {area:461}, na Cordilheira das Torres de Pedra. Os kobolds de lá deixam cair os Lingotes Fumegantes de Ferro.",
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["Smoky Iron Ingots from the Windshear kobolds"] = "Lingotes Fumegantes de Ferro dos kobolds de Rochedo Cortavento",

	-- Step 8: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "Mineradores de Eira dos Montes",
	-- {zone:1424} Hillsbrad Foothills · {item:7127} Powdered Azurite · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Os Mineradores de Eira dos Montes trabalham na mina no oeste de {zone:1424}; eles deixam cair a {item:7127}. Pegue o zepelim de {zone:1454} até {zone:1420} e cavalgue para o sul por {zone:1421}.",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127} from the Hillsbrad Miners"] = "{item:7127} dos Mineradores de Eira dos Montes",

	-- Step 9: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "Barras de Ferro",
	-- {item:2772} Iron Ore · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Mineradores fundem Barras de Ferro a partir de {item:2772} ({skill:186} 125); os demais as compram na casa de leilões de {zone:1454}.",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "Barras de Ferro: {npc:8673}",

	-- Step 10: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "De volta a {npc:5878}, junto à estrada a leste da {area:380}. {quest:1848} é a primeira peça; depois ele manda você a três artesãos para o resto.",

	-- Step 11: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408} está em {area:367}, na costa de {zone:1411}.",

	-- Step 12: Satyr Hooves
	-- {area:429} Xavian · {zone:1440} Ashenvale
	["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "Os sátiros de {area:429} acampam no leste de {zone:1440}, com os sátiros Malmíscar mais a oeste; ambos deixam cair Cascos Não Fendidos de Sátiro.",
	-- {quest:1842} Satyr Hooves
	["Uncloven {quest:1842}"] = "{quest:1842} intactos",

	-- Step 15: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "A {npc:6167} vaga pelo sudoeste da Cordilheira das Torres de Pedra perto das Quimeras Filhotes e Jovens; ela deixa cair o {item:6840}.",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{item:6840} da {npc:6167}",

	-- Step 17: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron
	["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "Pegue o zepelim de {zone:1454} até {zone:1420}; {zone:1458} fica embaixo das {area:153}.",

	-- Step 18: Dragonmaw Shinbones
	-- {zone:1437} Wetlands
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "Os orcs Presa do Dragão acampam no meio de {zone:1437}, ao sul da estrada; Saqueadores, Corre-brejos, Centuriões, Guarda-sombras e Guarda-ossos deixam cair Tíbias Firmes de Presa do Dragão.",
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Sturdy Dragonmaw Shinbones"] = "Tíbias Firmes de Presa do Dragão",
}
