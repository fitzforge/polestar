-- German (deDE): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "Vier Rüstungsteile mit 30 (Halsberge, Helm, Stulpen, Beinschützer) und ein Schild unterwegs.",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "Mit 20 schickt dich {npc:3354} im {object:172958} zu {npc:6394} in {area:378}.",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "Mit 20 schickt dich {npc:3041}, der Kriegerlehrer von {zone:1456}, zu {npc:6394} in {area:378}.",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "Mit 20 schickt dich {npc:4595}, ein Kriegerlehrer in {zone:1458}, zu {npc:6394} in {area:378}.",

	-- Step 4: Trial at the Field of Giants
	-- {area:378} Camp Taurajo · {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "Flieg nach {area:378}. Südlich des Lagers liegen die Silithid-Buckel verstreut auf dem {area:390}: Die Silithiden dort tragen die Zuckenden Fühler.",
	["Twitching Antennae from the silithid"] = "Zuckende Fühler von den Silithiden",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1838} Brutal Armor
	["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878} Firegaze lagert an der Straße östlich vom {area:380}. {quest:1838} ist eine Quest der Stufe 30; du kannst sie jetzt annehmen und unterwegs dafür sammeln.",

	-- Step 6: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Roogug in {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Roogug ist ein Elite-Stacheleber in {area:1717}, dem Dungeon am Südende des {zone:1413}; er lässt {item:6841} fallen. {area:1717} ist ein Dungeon: Eine Gruppe wird empfohlen.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, von Roogug",

	-- Step 7: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "{area:2160} liegt am Ostende von {area:461} im Steinkrallengebirge. Ihre Kobolde lassen die Rauchigen Eisenblöcke fallen.",
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["Smoky Iron Ingots from the Windshear kobolds"] = "Rauchige Eisenblöcke von den Kobolden der Scherwindmine",

	-- Step 8: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "Minenarbeiter von Hillsbrad",
	-- {zone:1424} Hillsbrad Foothills · {item:7127} Powdered Azurite · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "Die Minenarbeiter von Hillsbrad arbeiten in der Mine im Westen von {zone:1424}; sie lassen {item:7127} fallen. Nimm den Zeppelin von {zone:1454} nach {zone:1420} und reite nach Süden durch {zone:1421}.",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127} from the Hillsbrad Miners"] = "{item:7127} von den Minenarbeitern von Hillsbrad",

	-- Step 9: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "Eisenbarren",
	-- {item:2772} Iron Ore · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "Bergleute verhütten Eisenbarren aus {item:2772} ({skill:186} 125); alle anderen kaufen sie im Auktionshaus in {zone:1454}.",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "Eisenbarren: {npc:8673}",

	-- Step 10: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "Zurück zu {npc:5878} Firegaze an der Straße östlich vom {area:380}. {quest:1848} ist das erste Teil; danach schickt er dich für den Rest zu drei Handwerkern.",

	-- Step 11: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408} ist in {area:367} an der Küste von {zone:1411}.",

	-- Step 12: Satyr Hooves
	-- {area:429} Xavian · {zone:1440} Ashenvale
	["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "Die Satyrn von {area:429} lagern im Osten von {zone:1440}, die Satyrn der Teufelshufe weiter westlich; beide lassen Ungespaltene Satyrhufe fallen.",
	-- {quest:1842} Satyr Hooves
	["Uncloven {quest:1842}"] = "Ungespaltene {quest:1842}",

	-- Step 15: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "{npc:6167} streift durch den Südwesten des Steinkrallengebirges nahe den Schimärenjungen und Jungen Schimären; sie lässt {item:6840} fallen.",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{item:6840} von {npc:6167}",

	-- Step 17: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron
	["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "Nimm den Zeppelin von {zone:1454} nach {zone:1420}; {zone:1458} liegt unter den {area:153}.",

	-- Step 18: Dragonmaw Shinbones
	-- {zone:1437} Wetlands
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "Die Orcs der Dragonmaw lagern in der Mitte des {zone:1437}, südlich der Straße; Räuber, Sumpfläufer, Zenturios, Schattenwärter und Knochenwärter lassen alle die Stabilen Schienbeinknochen ({item:7134}) fallen.",
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Sturdy Dragonmaw Shinbones"] = "Stabile Schienbeinknochen ({item:7134})",
}
