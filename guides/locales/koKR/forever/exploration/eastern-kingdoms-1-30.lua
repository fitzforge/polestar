-- Korean (koKR): the guide forever/exploration/eastern-kingdoms-1-30 (forever/exploration/eastern-kingdoms-1-30.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1415} Eastern Kingdoms
	["Exploration: {zone:1415} 1-30"] = "탐험: {zone:1415} 1-30",

	-- Step 1: Elwynn Forest (1/2)
	-- {zone:1429} Elwynn Forest · {zone:1426} Dun Morogh
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Alliance starts in {zone:1429}; dwarves and gnomes can begin at the {zone:1426} step. 12 areas to discover here, levels 5-10."] = "지역을 발견하면 그 레벨에 맞는 경험치를 얻으므로 레벨업과 함께 진행할 수 있습니다. 얼라이언스는 {zone:1429}에서 시작하며, 드워프와 노움은 {zone:1426} 단계부터 시작해도 됩니다. 이곳에서 발견할 지역은 12곳, 레벨 5-10입니다.",
	["Exploring the entire world map on one character is a Forever Legacy Challenge (1 account-wide Legacy Point)."] = "한 캐릭터로 세계 지도 전체를 탐험하는 것은 Forever 유산 도전 과제입니다(계정 공통 유산 점수 1점).",
	-- {area:9} Northshire Valley · {zone:1429} Elwynn Forest · {area:87} Goldshire
	["{area:9} opens onto {zone:1429}; {area:87} is south down the road."] = "{area:9}에서 나가면 {zone:1429}입니다. {area:87}은(는) 길을 따라 남쪽에 있습니다.",

	-- Step 2: Elwynn Forest (2/2)
	["any one of these names counts"] = "이 이름 중 하나만 발견해도 됩니다",

	-- Step 3: Westfall (1/2)
	["14 areas to discover here, levels 9-18."] = "이곳에서 발견할 지역은 14곳, 레벨 9-18입니다.",
	-- {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:120} Westbrook Garrison
	["{zone:1436} borders {zone:1429} to the west: follow the road out past the {area:120}."] = "{zone:1436}은(는) {zone:1429}의 서쪽에 붙어 있습니다. {area:120}을(를) 지나 길을 따라 나가세요.",
	-- {area:108} Sentinel Hill
	["Flight path here: {area:108} (Thor)."] = "이곳의 비행 경로: {area:108} (토르).",

	-- Step 5: Duskwood (1/2)
	["13 areas to discover here, levels 10-30."] = "이곳에서 발견할 지역은 13곳, 레벨 10-30입니다.",
	-- {zone:1431} Duskwood · {zone:1436} Westfall · {zone:1429} Elwynn Forest · {area:42} Darkshire
	["{zone:1431} is east of {zone:1436} and south of {zone:1429}. Its road runs east to {area:42}."] = "{zone:1431}은(는) {zone:1436}의 동쪽, {zone:1429}의 남쪽에 있습니다. 길이 동쪽으로 {area:42}까지 이어집니다.",
	-- {area:42} Darkshire · {npc:2409} Felicia Maline
	["Flight path here: {area:42} ({npc:2409})."] = "이곳의 비행 경로: {area:42} ({npc:2409}).",

	-- Step 7: Redridge Mountains (1/2)
	["11 areas to discover here, levels 15-24."] = "이곳에서 발견할 지역은 11곳, 레벨 15-24입니다.",
	-- {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood
	["Redridge starts at {area:1002}, where the roads from {zone:1429} and {zone:1431} meet."] = "붉은마루 산맥은 {zone:1429}와(과) {zone:1431}에서 오는 길이 만나는 {area:1002}에서 시작됩니다.",
	-- {area:69} Lakeshire · {npc:931} Ariena Stormfeather
	["Flight path here: {area:69} ({npc:931})."] = "이곳의 비행 경로: {area:69} ({npc:931}).",

	-- Step 9: Dun Morogh (1/3)
	["18 areas to discover here, levels 4-12."] = "이곳에서 발견할 지역은 18곳, 레벨 4-12입니다.",
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind City · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "{zone:1453}의 {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가세요(또는 {zone:1455}(으)로 날아가세요). 그런 다음 성문을 통해 도시를 나가세요.",

	-- Step 12: Loch Modan (1/2)
	["11 areas to discover here, levels 10-18."] = "이곳에서 발견할 지역은 11곳, 레벨 10-18입니다.",
	-- {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:925} Algaz Station
	["Leave {zone:1426} east through the gate tunnel; it opens into {zone:1432} at {area:925}."] = "동쪽 관문 터널을 지나 {zone:1426}을(를) 떠나세요. 터널은 {area:925}에서 {zone:1432}(으)로 이어집니다.",
	-- {area:144} Thelsamar · {npc:1572} Thorgrum Borrelson
	["Flight path here: {area:144} ({npc:1572})."] = "이곳의 비행 경로: {area:144} ({npc:1572}).",

	-- Step 14: Wetlands (1/2)
	["15 areas to discover here, levels 20-30."] = "이곳에서 발견할 지역은 15곳, 레벨 20-30입니다.",
	-- {area:925} Algaz Station · {area:836} Dun Algaz · {zone:1437} Wetlands
	["From {area:925}, the road north through the {area:836} pass leads into the {zone:1437}."] = "{area:925}에서 {area:836} 고개를 지나 북쪽으로 가는 길이 {zone:1437}(으)로 이어집니다.",
	-- {area:150} Menethil Harbor · {npc:1571} Shellei Brondir
	["Flight path here: {area:150} ({npc:1571})."] = "이곳의 비행 경로: {area:150} ({npc:1571}).",
	-- {area:1038} Dragonmaw Gates · {area:1037} Grim Batol
	["the discovery triggers at the {area:1038}: do not go into {area:1037} itself"] = "{area:1038}에서 발견됩니다. {area:1037} 안으로는 들어가지 마세요",

	-- Step 16: Hillsbrad Foothills (1/2)
	["12 areas to discover here, levels 20-31."] = "이곳에서 발견할 지역은 12곳, 레벨 20-31입니다.",
	-- {area:881} Thandol Span · {zone:1437} Wetlands · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {zone:1424} Hillsbrad Foothills
	["Cross the {area:881} in northern {zone:1437} into the {zone:1417} (level 30+ creatures off the road), follow the road west past {area:320} and on into {zone:1424}."] = "{zone:1437} 북쪽의 {area:881}을(를) 건너 {zone:1417}(으)로 가세요(길 밖에는 레벨 30 이상 몬스터). 길을 따라 서쪽으로 {area:320}을(를) 지나 {zone:1424}(으)로 가세요.",
	-- {area:271} Southshore · {npc:2432} Darla Harris
	["Flight path here: {area:271} ({npc:2432})."] = "이곳의 비행 경로: {area:271} ({npc:2432}).",
	-- {area:272} Tarren Mill
	["Horde guards: touch the edge of {area:272} and move on"] = "호드 경비병: {area:272}의 가장자리만 밟고 지나가세요",

	-- Step 18: Silverpine Forest (1/2)
	["15 areas to discover here, levels 10-20."] = "이곳에서 발견할 지역은 15곳, 레벨 10-20입니다.",
	-- {area:287} Hillsbrad · {area:285} Southpoint Tower · {zone:1421} Silverpine Forest · {area:228} Sepulcher
	["Follow the road west from {area:287} past {area:285} into {zone:1421}, Horde country with Horde guards at the {area:228}."] = "{area:287}에서 길을 따라 서쪽으로 {area:285}을(를) 지나 {zone:1421}(으)로 가세요. 호드 지역이며 {area:228}에 호드 경비병이 있습니다.",
	-- {area:228} Sepulcher
	["Horde guards: touch the edge of {area:228} and move on"] = "호드 경비병: {area:228}의 가장자리만 밟고 지나가세요",

	-- Step 20: Tirisfal Glades (1/3)
	["17 areas to discover here, levels 5-10."] = "이곳에서 발견할 지역은 17곳, 레벨 5-10입니다.",
	-- {zone:1420} Tirisfal Glades · {area:159} Brill · {area:154} Deathknell · {zone:1458} Undercity
	["Silverpine's road north leads into {zone:1420}. {area:159}, {area:154} and the {zone:1458} ruins are Horde ground."] = "은빛소나무 숲의 북쪽 길은 {zone:1420}(으)로 이어집니다. {area:159}, {area:154}, {zone:1458} 폐허는 호드 지역입니다.",
	-- {area:153} Ruins of Lordaeron
	["Horde guards: touch the edge of {area:153} and move on"] = "호드 경비병: {area:153}의 가장자리만 밟고 지나가세요",

	-- Step 21: Tirisfal Glades (2/3)
	-- {area:159} Brill
	["Horde guards: touch the edge of {area:159} and move on"] = "호드 경비병: {area:159}의 가장자리만 밟고 지나가세요",

	-- Step 22: Tirisfal Glades (3/3)
	-- {area:154} Deathknell
	["Horde guards: touch the edge of {area:154} and move on"] = "호드 경비병: {area:154}의 가장자리만 밟고 지나가세요",

	-- Step 23: Tirisfal Glades (1/3)
	-- {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["Discovering an area gives experience scaled to its level, so this runs alongside leveling. Horde starts in {zone:1420}; orcs, trolls and tauren arrive by zeppelin from {zone:1454}. 17 areas to discover here, levels 5-10."] = "지역을 발견하면 그 레벨에 맞는 경험치를 얻으므로 레벨업과 함께 진행할 수 있습니다. 호드는 {zone:1420}에서 시작하며, 오크, 트롤, 타우렌은 {zone:1454}에서 비행선을 타고 옵니다. 이곳에서 발견할 지역은 17곳, 레벨 5-10입니다.",
	-- {area:154} Deathknell · {zone:1420} Tirisfal Glades · {area:159} Brill · {zone:1458} Undercity
	["{area:154} opens onto {zone:1420}; {area:159} is east along the road. Orcs, trolls and tauren arrive at the zeppelin tower by the {zone:1458}."] = "{area:154}에서 나가면 {zone:1420}입니다. {area:159}은(는) 길을 따라 동쪽에 있습니다. 오크, 트롤, 타우렌은 {zone:1458} 옆의 비행선 탑에 도착합니다.",

	-- Step 26: Silverpine Forest (1/2)
	-- {zone:1421} Silverpine Forest · {zone:1420} Tirisfal Glades · {area:159} Brill
	["{zone:1421} is south of {zone:1420}: follow the road south from {area:159}."] = "{zone:1421}은(는) {zone:1420}의 남쪽에 있습니다. {area:159}에서 길을 따라 남쪽으로 가세요.",
	-- {area:228} Sepulcher · {npc:2226} Karos Razok
	["Flight path here: {area:228} ({npc:2226})."] = "이곳의 비행 경로: {area:228} ({npc:2226}).",

	-- Step 28: Hillsbrad Foothills (1/2)
	-- {zone:1424} Hillsbrad Foothills · {area:285} Southpoint Tower · {area:272} Tarren Mill · {area:271} Southshore
	["At the south end of Silverpine the road turns east into {zone:1424} by {area:285}. {area:272} in the north-east is the Horde town; {area:271} is Alliance."] = "은빛소나무 숲 남쪽 끝에서 길은 {area:285} 옆에서 동쪽으로 꺾여 {zone:1424}(으)로 이어집니다. 북동쪽의 {area:272}은(는) 호드 마을이고, {area:271}은(는) 얼라이언스 마을입니다.",
	-- {area:272} Tarren Mill
	["Flight path here: {area:272} (Zarise)."] = "이곳의 비행 경로: {area:272} (자라이즈).",

	-- Step 29: Hillsbrad Foothills (2/2)
	-- {area:271} Southshore
	["Alliance guards: touch the edge of {area:271} and move on"] = "얼라이언스 경비병: {area:271}의 가장자리만 밟고 지나가세요",

	-- Step 30: Wetlands (1/2)
	-- {area:287} Hillsbrad · {zone:1417} Arathi Highlands · {area:881} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor
	["Walk east from {area:287} into the {zone:1417} (level 30+ creatures off the road), south to the {area:881} bridge, and across it into the {zone:1437}. {area:150} is an Alliance town."] = "{area:287}에서 동쪽으로 걸어 {zone:1417}(으)로 가세요(길 밖에는 레벨 30 이상 몬스터). 남쪽의 {area:881} 다리로 가서 건너면 {zone:1437}입니다. {area:150}은(는) 얼라이언스 마을입니다.",

	-- Step 31: Wetlands (2/2)
	-- {area:150} Menethil Harbor
	["Alliance guards: touch the edge of {area:150} and move on"] = "얼라이언스 경비병: {area:150}의 가장자리만 밟고 지나가세요",

	-- Step 32: Loch Modan (1/2)
	-- {area:836} Dun Algaz · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:925} Algaz Station
	["The {area:836} pass in south-eastern {zone:1437} leads down into {zone:1432} by {area:925}."] = "{zone:1437} 남동쪽의 {area:836} 고개를 내려가면 {area:925} 옆의 {zone:1432}입니다.",

	-- Step 33: Loch Modan (2/2)
	-- {area:144} Thelsamar
	["Alliance guards: touch the edge of {area:144} and move on"] = "얼라이언스 경비병: {area:144}의 가장자리만 밟고 지나가세요",

	-- Step 34: Dun Morogh (1/3)
	-- {area:925} Algaz Station · {zone:1426} Dun Morogh · {area:131} Kharanos · {zone:1455} Ironforge
	["From {area:925} take the tunnel west into {zone:1426}. {area:131} and {zone:1455}'s gates are Alliance ground."] = "{area:925}에서 서쪽 터널을 지나 {zone:1426}(으)로 가세요. {area:131}와(과) {zone:1455} 성문은 얼라이언스 지역입니다.",

	-- Step 35: Dun Morogh (2/3)
	-- {area:809} Gates of Ironforge
	["Alliance guards: touch the edge of {area:809} and move on; any one of these names counts"] = "얼라이언스 경비병: {area:809}의 가장자리만 밟고 지나가세요. 이 이름 중 하나만 발견해도 됩니다",
	-- {area:131} Kharanos
	["Alliance guards: touch the edge of {area:131} and move on"] = "얼라이언스 경비병: {area:131}의 가장자리만 밟고 지나가세요",

	-- Step 36: Dun Morogh (3/3)
	-- {area:132} Coldridge Valley
	["Alliance guards: touch the edge of {area:132} and move on; any one of these names counts"] = "얼라이언스 경비병: {area:132}의 가장자리만 밟고 지나가세요. 이 이름 중 하나만 발견해도 됩니다",

	-- Step 37: Duskwood (1/2)
	-- {zone:1458} Undercity · {zone:1454} Orgrimmar · {area:117} Grom'gol Base Camp · {zone:1434} Stranglethorn Vale · {zone:1431} Duskwood
	["Hearth or fly back to the {zone:1458} (or go to {zone:1454}), take the zeppelin to {area:117} in {zone:1434} and walk north along the road into {zone:1431}. Northern Stranglethorn is level 30+ off the road."] = "귀환석을 쓰거나 날아서 {zone:1458}(으)로 돌아가세요(또는 {zone:1454}(으)로 가세요). 비행선을 타고 {zone:1434}의 {area:117}(으)로 간 뒤 길을 따라 북쪽으로 걸어 {zone:1431}(으)로 가세요. 북부 가시덤불 골짜기는 길 밖이 레벨 30 이상입니다.",
	-- {area:42} Darkshire
	["Alliance guards: touch the edge of {area:42} and move on"] = "얼라이언스 경비병: {area:42}의 가장자리만 밟고 지나가세요",

	-- Step 39: Westfall (1/2)
	-- {zone:1436} Westfall · {zone:1431} Duskwood · {area:108} Sentinel Hill
	["{zone:1436} borders {zone:1431} to the west. {area:108} is an Alliance town."] = "{zone:1436}은(는) {zone:1431}의 서쪽에 붙어 있습니다. {area:108}은(는) 얼라이언스 마을입니다.",

	-- Step 40: Westfall (2/2)
	-- {area:108} Sentinel Hill
	["Alliance guards: touch the edge of {area:108} and move on"] = "얼라이언스 경비병: {area:108}의 가장자리만 밟고 지나가세요",

	-- Step 41: Elwynn Forest (1/2)
	["12 areas to discover here, levels 5-10."] = "이곳에서 발견할 지역은 12곳, 레벨 5-10입니다.",
	-- {zone:1429} Elwynn Forest · {zone:1436} Westfall · {zone:1431} Duskwood · {area:87} Goldshire · {area:9} Northshire Valley · {zone:1453} Stormwind City
	["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429}은(는) {zone:1436}와(과) {zone:1431}의 북쪽에 있습니다. {area:87}, {area:9}, {zone:1453} 성문은 경비병이 있는 얼라이언스 지역입니다.",
	-- {zone:1453} Stormwind City
	["Alliance guards: touch the edge of {zone:1453} and move on; any one of these names counts"] = "얼라이언스 경비병: {zone:1453}의 가장자리만 밟고 지나가세요. 이 이름 중 하나만 발견해도 됩니다",
	-- {area:9} Northshire Valley
	["Alliance guards: touch the edge of {area:9} and move on"] = "얼라이언스 경비병: {area:9}의 가장자리만 밟고 지나가세요",
	-- {area:87} Goldshire
	["Alliance guards: touch the edge of {area:87} and move on"] = "얼라이언스 경비병: {area:87}의 가장자리만 밟고 지나가세요",

	-- Step 43: Redridge Mountains (1/2)
	-- {zone:1429} Elwynn Forest · {area:1002} Three Corners · {area:69} Lakeshire
	["Go east through {zone:1429} to {area:1002}, where Redridge starts. {area:69} is an Alliance town."] = "{zone:1429}을(를) 지나 동쪽의 {area:1002}(으)로 가세요. 여기서 붉은마루 산맥이 시작됩니다. {area:69}은(는) 얼라이언스 마을입니다.",
	-- {area:69} Lakeshire
	["Alliance guards: touch the edge of {area:69} and move on"] = "얼라이언스 경비병: {area:69}의 가장자리만 밟고 지나가세요",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Flight path here: {area:228} ({npc:2226})."] = "이곳의 비행 경로: {area:228} ({npc:2226}).",
	-- ["Horde guards: touch the edge of {area:228} and move on"] = "호드 경비병: {area:228}의 가장자리만 밟고 지나가세요",
	-- ["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455} (or fly to {zone:1455}), then leave the city through its gates."] = "{zone:1453}의 {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가세요(또는 {zone:1455}(으)로 날아가세요). 그런 다음 성문을 통해 도시를 나가세요.",
	-- ["The {area:228}"] = "{area:228}",
	-- ["{zone:1429} is north of {zone:1436} and {zone:1431}. {area:87}, {area:9} and {zone:1453}'s gates are Alliance ground with guards."] = "{zone:1429}은(는) {zone:1436}와(과) {zone:1431}의 북쪽에 있습니다. {area:87}, {area:9}, {zone:1453} 성문은 경비병이 있는 얼라이언스 지역입니다.",
}
