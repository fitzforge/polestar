-- Korean (koKR): the guide forever/class/warrior/brutal-armor (forever/class/warrior/brutal-armor.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Four armor pieces at 30 (hauberk, helm, gauntlets, legguards) and a shield on the way."] = "30레벨에 방어구 네 부위(사슬 갑옷, 투구, 건틀릿, 다리보호구), 도중에 방패도 얻습니다.",

	-- Step 1: Speak with Ruga (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3354} in the {object:172958} sends you to {npc:6394} in {area:378}."] = "20레벨에 {object:172958}의 {npc:3354}이(가) 당신을 {area:378}의 {npc:6394}에게 보냅니다.",

	-- Step 2: Speak with Ruga (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6394} in {area:378}."] = "20레벨에 {zone:1456}의 전사 상급자 {npc:3041}이(가) 당신을 {area:378}의 {npc:6394}에게 보냅니다.",

	-- Step 3: Speak with Ruga (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo
	["At 20, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6394} in {area:378}."] = "20레벨에 {zone:1458}의 전사 상급자 {npc:4595}이(가) 당신을 {area:378}의 {npc:6394}에게 보냅니다.",

	-- Step 4: Trial at the Field of Giants
	-- {area:378} Camp Taurajo · {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound
	["Fly to {area:378}. South of the camp the Silithid Mounds dot the {area:390}: the silithid there carry the Twitching Antennae."] = "{area:378}(으)로 날아가세요. 야영지 남쪽 {area:390}에 실리시드 흙더미가 흩어져 있으며, 그곳의 실리시드가 꿈틀거리는 더듬이를 지니고 있습니다.",
	["Twitching Antennae from the silithid"] = "실리시드에게서 꿈틀거리는 더듬이",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1838} Brutal Armor
	["{npc:5878} camps beside the road east of the {area:380}. {quest:1838} is a level 30 quest; you can take it now and gather for it on the way."] = "{npc:5878}은(는) {area:380} 동쪽 길가에 진을 치고 있습니다. {quest:1838}은(는) 30레벨 퀘스트이지만 지금 받아서 가는 길에 재료를 모을 수 있습니다.",

	-- Step 6: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "{area:1717}의 루구그",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {item:6841} Vial of Phlogiston
	["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "루구그는 {zone:1413} 남쪽 끝의 던전인 {area:1717} 안의 정예 가시멧돼지족이며 {item:6841}을(를) 떨어뜨립니다. {area:1717}은(는) 던전이니 파티를 권장합니다.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, 루구그에게서",

	-- Step 7: Windshear Mine
	-- {area:2160} Windshear Mine · {area:461} Windshear Crag
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["The {area:2160} lies at the east end of {area:461} in Stonetalon. Its kobolds drop the Smoky Iron Ingots."] = "{area:2160}은(는) 돌발톱 산맥 {area:461}의 동쪽 끝에 있습니다. 그곳 코볼트가 연기나는 철제 주괴를 떨어뜨립니다.",
	-- plural, as words: Smoky Iron Ingots = {item:7126} Smoky Iron Ingot
	["Smoky Iron Ingots from the Windshear kobolds"] = "칼바람 코볼트에게서 연기나는 철제 주괴",

	-- Step 8: Hillsbrad Miners
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["Hillsbrad Miners"] = "{npc:2269}",
	-- {zone:1424} Hillsbrad Foothills · {item:7127} Powdered Azurite · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["The Hillsbrad Miners work the mine in the west of {zone:1424}; they drop the {item:7127}. Take the zeppelin from {zone:1454} to {zone:1420} and ride south through {zone:1421}."] = "{npc:2269}은(는) {zone:1424} 서쪽의 광산에서 일하며 {item:7127}을(를) 떨어뜨립니다. {zone:1454}에서 비행선을 타고 {zone:1420}(으)로 간 뒤 {zone:1421}을(를) 지나 남쪽으로 가세요.",
	-- {item:7127} Powdered Azurite
	-- plural, as words: Hillsbrad Miners = {npc:2269} Hillsbrad Miner
	["{item:7127} from the Hillsbrad Miners"] = "{item:7127}, {npc:2269}에게서",

	-- Step 9: Iron Bars
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars"] = "철 주괴",
	-- {item:2772} Iron Ore · {skill:186} Mining · {zone:1454} Orgrimmar
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Miners smelt Iron Bars from {item:2772} ({skill:186} 125); everyone else buys them at the auction house in {zone:1454}."] = "채광사는 {item:2772}을(를) 제련해 철 주괴를 만들고({skill:186} 125), 그 외에는 {zone:1454} 경매장에서 사세요.",
	-- {npc:8673} Auctioneer Thathung
	-- plural, as words: Iron Bars = {item:3575} Iron Bar
	["Iron Bars: {npc:8673}"] = "철 주괴: {npc:8673}",

	-- Step 10: Brutal Hauberk
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads · {quest:1848} Brutal Hauberk
	["Back to {npc:5878} beside the road east of the {area:380}. {quest:1848} is the first piece; he then sends you to three crafters for the rest."] = "{area:380} 동쪽 길가의 {npc:5878}에게 돌아가세요. {quest:1848}이(가) 첫 번째 부위이며, 그 후 나머지를 위해 장인 세 명에게 보냅니다.",

	-- Step 11: Ula'elek
	-- {npc:6408} Ula'elek · {area:367} Sen'jin Village · {zone:1411} Durotar
	["{npc:6408} is in {area:367} on the {zone:1411} coast."] = "{npc:6408}은(는) {zone:1411} 해안의 {area:367}에 있습니다.",

	-- Step 12: Satyr Hooves
	-- {area:429} Xavian · {zone:1440} Ashenvale
	["The {area:429} satyrs camp in eastern {zone:1440}, with the Felmusk satyrs further west; both drop Uncloven Satyr Hooves."] = "{area:429} 사티로스는 {zone:1440} 동부에 진을 치고 있고, 검은유혹의 사티로스는 더 서쪽에 있습니다. 둘 다 사티로스 통발굽을 떨어뜨립니다.",
	-- {quest:1842} Satyr Hooves
	["Uncloven {quest:1842}"] = "통발굽 {quest:1842}",

	-- Step 15: Chimaeric Horn
	-- {npc:6167} Chimaera Matriarch · {item:6840} Galvanized Horn
	-- plural, as words: Young Chimaeras = {npc:4032} Young Chimaera
	["The {npc:6167} roams the south-west of Stonetalon near the Fledgling and Young Chimaeras; she drops the {item:6840}."] = "{npc:6167}은(는) 돌발톱 산맥 남서쪽에서 어린 키메라, 새끼 키메라 근처를 돌아다니며 {item:6840}을(를) 떨어뜨립니다.",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840} from the {npc:6167}"] = "{npc:6167}에게서 {item:6840}",

	-- Step 17: Velora Nitely
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {area:153} Ruins of Lordaeron
	["Take the zeppelin from {zone:1454} to {zone:1420}; the {zone:1458} lies below the {area:153}."] = "{zone:1454}에서 비행선을 타고 {zone:1420}(으)로 가세요. {zone:1458}은(는) {area:153} 아래에 있습니다.",

	-- Step 18: Dragonmaw Shinbones
	-- {zone:1437} Wetlands
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["The Dragonmaw orcs camp in the middle of the {zone:1437}, south of the road; Raiders, Swamprunners, Centurions, Shadowwarders and Bonewarders all drop the Sturdy Dragonmaw Shinbones."] = "용아귀부족 오크는 {zone:1437} 한가운데, 길 남쪽에 진을 치고 있습니다. 약탈자, 늪길잡이, 백인대장, 어둠보초병, 해골감시자 모두 {item:7134}을(를) 떨어뜨립니다.",
	-- plural, as words: Sturdy Dragonmaw Shinbones = {item:7134} Sturdy Dragonmaw Shinbone
	["Sturdy Dragonmaw Shinbones"] = "{item:7134}",
}
