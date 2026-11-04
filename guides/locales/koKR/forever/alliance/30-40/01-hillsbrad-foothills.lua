-- Korean (koKR): the guide forever/alliance/30-40/01-hillsbrad-foothills (forever/alliance/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hearth to Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["Hearth to {area:2104}"] = "",

	-- Step 2: To Deepwater Tavern
	-- {area:2104} Deepwater Tavern
	["To {area:2104}"] = "",

	-- Step 3: Menethil Harbor
	-- {npc:2104} Captain Stoutfist · {npc:270637} Howin Kindfeather
	["{npc:2104}: for {npc:270637}; on the top floor"] = "",

	-- Step 4: Howin Kindfeather
	-- {zone:1455} Ironforge
	["For King Magni in {zone:1455}, at the end of this guide"] = "{zone:1455}의 국왕 마그니 브론즈비어드에게, 이 가이드 마지막에",

	-- Step 5: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {object:671518} Tattered Spellbook
	["South to the Dragonmaw's {area:1036}: the first catapult stands on the way, and the {object:671518} lies in the camp."] = "남쪽의 용아귀부족 {area:1036}(으)로 가십시오. 가는 길에 첫 번째 투석기가 있고, {object:671518}은(는) 야영지 안에 있습니다.",

	-- Step 7: Angerfang Encampment
	-- {quest:474} Defeat Nek'rosh
	["The next step, {quest:474}, pits you against an elite chieftain: skip it."] = "",
	-- {object:671518} Tattered Spellbook · {npc:2104} Captain Stoutfist
	["{object:671518}: for {npc:2104}"] = "{object:671518}: {npc:2104}에게",

	-- Step 8: Defeat Nek'rosh
	-- {npc:2091} Chieftain Nek'rosh
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2091} is a level 32 elite: most classes solo it at level 34, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Shadowcasters stand on either side of him, and at least one is linked to him, so it joins when he is pulled. Non-elite centurions and captains are spread around his ring of tents."] = "",

	-- Step 9: Golm
	-- {npc:271462} Golm · {item:279996} Goaz Stone
	["{npc:271462} stands in the south-eastern hills: use the {item:279996} beside it."] = "{npc:271462}은(는) 남동쪽 언덕에 있습니다. 그 옆에서 {item:279996}을(를) 사용하십시오.",

	-- Step 10: Dragonmaw Gates: kill these as you meet them
	-- {area:1038} Dragonmaw Gates
	["{area:1038}: kill these as you meet them"] = "",
	-- {area:1038} Dragonmaw Gates · {npc:271338} Ados · {item:279996} Goaz Stone
	["North-east to the {area:1038}: {npc:271338} stands at the gates (use the {item:279996})."] = "",

	-- Step 12: Dun Modr
	-- {area:205} Dun Modr · {npc:271460} Modr · {item:279996} Goaz Stone · {npc:271481} Captive Fire Elemental · {npc:1072} Roggo Harlbarrow
	["North along the road to {area:205}. {npc:271460} stands in the ruins (use the {item:279996}); the {npc:271481} is held on the west side: lead it out to {npc:1072}."] = "길을 따라 북쪽 {area:205}(으)로 가십시오. {npc:271460}은(는) 폐허 안에 있습니다({item:279996} 사용). {npc:271481}은(는) 서쪽에 갇혀 있으니 {npc:1072}에게 데려가십시오.",

	-- Step 14: Waterlogged Envelope
	["Underwater"] = "",

	-- Step 15: The Villards
	["The Villards"] = "",
	-- {npc:5683} Comar Villard · {area:205} Dun Modr · {area:880} Thandol Span · {npc:271322} Essene Villard
	["{npc:5683} waits north of {area:205} by the {area:880}; {npc:271322} a short walk further north-east."] = "",

	-- Step 16: Dun Modr
	-- {npc:1071} Longbraid the Grim
	["{npc:1071} stands in the dwarves' camp."] = "",

	-- Step 17: Thandol Span
	-- {area:205} Dun Modr · {zone:1437} Wetlands · {npc:1075} Rhag Garmason
	["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "",

	-- Step 19: Prospector Whelgar
	["Below ground"] = "",

	-- Step 20: Menethil Harbor
	["West along the road to Menethil."] = "길을 따라 서쪽 메네실 항구로 가십시오.",
	["On the top floor"] = "",

	-- Step 22: Level 31.23
	["Level 31.23"] = "",
	-- {quest:474} Defeat Nek'rosh
	["If you skipped {quest:474}, grind here to level 31.23 to stay on the route's plan."] = "",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "",

	-- Step 24: Boat to Southshore
	-- {area:271} Southshore
	["Boat to {area:271}"] = "{area:271}행 배",

	-- Step 25: Southshore
	-- {npc:2381} Micha Yance · {npc:2438} Bartolo Ginsetti · {npc:2366} Barkeep Kelly
	["Pick up everything in town before heading out. {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "",
	-- {item:3713} Soothing Spices · {npc:2381} Micha Yance
	["{item:3713}, from {npc:2381}"] = "{item:3713}, {npc:2381}에게서",
	-- {npc:2382} Darren Malvew
	["{npc:2382}: the lions come later"] = "{npc:2382}: 사자는 나중에",
	-- {npc:2430} Chef Jessen
	["{npc:2430}, upstairs"] = "",
	-- {npc:2366} Barkeep Kelly · {area:35} Booty Bay
	["{npc:2366}, in the inn: for {area:35} (04-stranglethorn-vale)"] = "{npc:2366}, 여관 안: {area:35}용 (04-stranglethorn-vale)",
	-- {npc:2228} Lieutenant Farren Orinelle
	["{npc:2228}, inside"] = "",
	-- {npc:2711} Phin Odelic
	["{npc:2711}: his trail leads to Arathi"] = "{npc:2711}: 그의 흔적은 아라시 고원으로 이어집니다",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "",

	-- Step 26: On the way
	["On the way"] = "",

	-- Step 27: Torn Fin murlocs
	["Torn Fin murlocs"] = "너덜지느러미멀록",
	-- {area:295} Western Strand · {area:271} Southshore
	["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}.\nCareful: One camp holds a tight cluster of Oracles that all aggro together."] = "",

	-- Step 28: Farren
	["Farren"] = "파렌",
	["Inside"] = "",

	-- Step 29: Murloc heads
	["Murloc heads"] = "멀록 머리",
	["Back to the same murlocs; not every one drops a head."] = "같은 멀록에게 돌아가십시오. 모두 머리를 떨어뜨리지는 않습니다.",

	-- Step 31: Daggerspine naga
	["Daggerspine naga"] = "비수가시일족 나가",
	-- {area:271} Southshore
	["The naga hold the shore south-east of {area:271}."] = "나가가 {area:271} 남동쪽 해안을 차지하고 있습니다.",

	-- Step 34: Farren
	-- {object:2117} Stormwind Keep
	["A report for {object:2117}; inside"] = "",

	-- Step 35: Southshore
	-- {npc:251493} Captain McManus
	["Off the boat, {npc:251493} is the first you meet, north-west of the flight master."] = "",

	-- Step 36: Yeti cave
	["Yeti cave"] = "설인 동굴",
	-- {area:271} Southshore
	["The yetis live in the cave in the hills north of {area:271}, on your way back south."] = "설인은 {area:271} 북쪽 언덕의 동굴에 삽니다. 남쪽으로 돌아가는 길에 있습니다.",
	-- {npc:2438} Bartolo Ginsetti · {item:3719} Hillman's Cloak · {item:2997} Bolt of Woolen Cloth · {item:2321} Fine Thread · {area:271} Southshore
	["{npc:2438} also wants a {item:3719}, a {item:2997} and {item:2321}: crafted or bought; the cloak is turned in when you are back in {area:271} later."] = "{npc:2438}은(는) {item:3719}, {item:2997}, {item:2321}도 원합니다. 제작하거나 구매하십시오. 망토는 나중에 {area:271}에 돌아와서 제출합니다.",

	-- Step 38: Syndicate camp
	["Syndicate camp"] = "비밀결사대 야영지",
	-- {area:287} Hillsbrad · {area:272} Tarren Mill
	["The Syndicate camp sits on the Alterac border in northern {area:287}, west of {area:272} (Horde); the documents lie in the camp."] = "비밀결사대 야영지는 {area:272}(호드) 서쪽, {area:287} 북부의 알터랙 경계에 있습니다. 문서는 야영지 안에 있습니다.",

	-- Step 40: Snapjaws
	["Snapjaws"] = "무쇠턱거북",
	-- {area:271} Southshore · {area:272} Tarren Mill
	["The Snapjaw turtles bask along the river east of {area:271}, south of {area:272} (Horde)."] = "무쇠턱거북이 {area:271} 동쪽, {area:272}(호드) 남쪽 강을 따라 햇볕을 쬡니다.",

	-- Step 44: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "",
	-- {area:271} Southshore
	["{area:271} flight master"] = "",

	-- Step 45: Deeprun Tram
	-- {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge
	["Take the {area:2257} from the {object:28027} to {zone:1455}."] = "{object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가십시오.",
	["Level 30 and 32 spells"] = "30, 32레벨 주문",

	-- Step 48: Deeprun Tram
	-- {npc:2784} King Magni Bronzebeard · {object:171709} High Seat
	["{npc:2784}, the {object:171709}"] = "",

	-- Step 50: Fly to Stormwind City
	-- {zone:1453} Stormwind City
	["Fly to {zone:1453}"] = "{zone:1453}로 비행",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 51: The Islander
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens · {area:392} Ratchet
	["{npc:5479} trains warriors in {object:2100}, beside the Pig and Whistle. {npc:6236} waits on {area:720} in the {zone:1413}, on the way to {area:392} much later (40-50/01)."] = "{npc:5479}은(는) {object:2100}의 돼지와 휘파람 선술집 옆에서 전사를 가르칩니다. {npc:6236}은(는) {zone:1413}의 {area:720}에서 기다립니다. 한참 뒤 {area:392}(으)로 가는 길에 있습니다(40-50/01).",

	-- Step 52: Elling Trias
	-- {object:2096} Trade District
	["The cheese shop in the {object:2096}."] = "{object:2096}의 치즈 가게입니다.",

	-- Step 53: Druid training
	["Druid training"] = "드루이드 수련",
	-- {zone:1455} Ironforge · {npc:5504} Sheldras Moontree · {zone:1453} Stormwind City
	["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455}에는 드루이드 상급자가 없습니다. 전차를 타기 전에 {zone:1453}의 {npc:5504}에게 수련하십시오.",

	-- Step 55: Dashel Stonefist
	-- {npc:4961} Dashel Stonefist · {object:2100} Old Town
	["{npc:4961} waits in the Pig and Whistle tavern in {object:2100}; he and his two thugs fight you, but stop once beaten."] = "{npc:4961}은(는) {object:2100}의 돼지와 휘파람 선술집에서 기다립니다. 그와 부하 둘이 덤벼들지만 쓰러뜨리면 멈춥니다.",

	-- Step 57: Cathedral of Light
	["Cathedral of Light"] = "빛의 대성당",

	-- Step 58: Mage Quarter
	-- {npc:2708} Archmage Malin · {object:2164} Slaughtered Lamb · {npc:211033} Garion Wendell · {npc:5081} Connor Rivers · {object:2101} Mage Quarter
	["{npc:2708} is in the {object:2164}; {npc:211033} near the canal; {npc:5081} south of the {object:2101}."] = "{npc:2708}은(는) {object:2164}에, {npc:211033}은(는) 운하 근처에, {npc:5081}은(는) {object:2101} 남쪽에 있습니다.",
	-- {npc:211033} Garion Wendell
	-- plural, as words: Library Books = {object:386691} Library Book
	["{npc:211033}: only offered once you have handed in library books (the Library Books guide)"] = "",

	-- Step 61: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A new {item:279996}, for the four titan watchers around the {zone:1437}"] = "새 {item:279996}, {zone:1437} 주변 티탄 감시자 넷을 위한 것",
	-- ["A report for {object:2117}"] = "{object:2117}에 보낼 보고서",
	-- ["Back south down the road to the excavation site."] = "길을 따라 남쪽 발굴 현장으로 돌아가십시오.",
	-- ["Destroy the four sets of Attack Plans in the camp for {quest:98221}."] = "{quest:98221}을(를) 위해 야영지의 공격 계획 네 묶음을 파괴하십시오.",
	-- ["Fly to {zone:1453}"] = "{zone:1453}(으)로 비행",
	-- ["Follow the road east to {area:118}."] = "길을 따라 동쪽 {area:118}(으)로 가십시오.",
	-- ["Follow the road north-east into the {area:1025}: {npc:270637} camps beside it, {npc:1244} a short way east."] = "길을 따라 북동쪽 {area:1025}로 가십시오. {npc:270637}은(는) 그 옆에 야영하고 있고, {npc:1244}은(는) 조금 동쪽에 있습니다.",
	-- ["For {npc:2916} in {zone:1455}, at the end of this guide"] = "{zone:1455}의 {npc:2916}에게, 이 가이드 마지막에",
	-- ["From {npc:2432} in {area:271}"] = "{area:271}의 {npc:2432}에게서",
	-- ["Golm"] = "골름",
	-- ["North-east to the {area:1038}: the {npc:271373} are held there, and {npc:271338} stands at the gates (use the {item:279996})."] = "북동쪽 {area:1038}(으)로 가십시오. {npc:271373}이(가) 그곳에 갇혀 있으며, {npc:271338}이(가) 성문에 있습니다({item:279996} 사용).",
	-- ["Pick up everything in town before heading out. Off the boat, {npc:251493} is the first you meet, north-west of the flight master; {npc:2381} and {npc:2438} stand between the flight master and the inn, Farren and {npc:2366} at the inn, Maleb in the town hall."] = "출발 전에 마을의 퀘스트를 모두 수락하십시오. 배에서 내리면 비행 조련사 북서쪽의 {npc:251493}을(를) 먼저 만납니다. {npc:2381}와(과) {npc:2438}은(는) 비행 조련사와 여관 사이에, 파렌과 {npc:2366}은(는) 여관에, 말레브는 마을 회관에 있습니다.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "새끼 붉은용이 성문 서쪽 언덕에, 광기에 물든 썩은발톱이 {area:1025}에, 무쇠턱 랩터가 북쪽 비탈에 가득합니다. 네루는 북동쪽에 있습니다({item:279996} 사용).\n{quest:98283}은(는) 정예이므로 파티를 권장합니다.",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; {npc:271458} stands in the north-east (use the {item:279996}).\n{quest:98283} is elite: grouping up is advised."] = "새끼 붉은용이 성문 서쪽 언덕에, 광기에 물든 썩은발톱이 {area:1025}에, 무쇠턱 랩터가 북쪽 비탈에 가득합니다. {npc:271458}은(는) 북동쪽에 있습니다({item:279996} 사용).\n{quest:98283}은(는) 정예이므로 파티를 권장합니다.",
	-- ["South to the Dragonmaw's {area:1036}; the {object:671518} lies in the camp."] = "남쪽의 용아귀부족 {area:1036}(으)로 가십시오. {object:671518}은(는) 야영지 안에 있습니다.",
	-- ["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one."] = "Goaz Warder들은 웰가의 야영지 바로 서쪽에 있습니다. 그 중 하나 옆에서 그가 준 {item:279996}을(를) 사용하십시오.",
	-- ["The Torn Fin murlocs crowd the {area:295}, south-west of {area:271}."] = "너덜지느러미멀록이 {area:271} 남서쪽 {area:295}에 몰려 있습니다.",
	-- ["The Villards"] = "빌라드 남매",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "다음 단계인 네크로쉬 처치는 정예 족장과 싸워야 합니다. 건너뛰십시오.",
	-- ["West to the farms of {area:287}: place the {item:279386} on the bookkeeping table in the town hall, where {npc:2335} and the councilmen stand."] = "서쪽 {area:287} 농장으로 가십시오. {npc:2335}와(과) 원로들이 있는 마을 회관의 장부 탁자에 {item:279386}을(를) 놓으십시오.",
	-- ["Whelps, raptors and {npc:271458}"] = "새끼 용, 랩터, {npc:271458}",
	-- ["{area:287} town hall"] = "{area:287} 마을 회관",
	-- ["{area:287}'s town hall"] = "{area:287} 마을 회관",
	-- ["{npc:1244}: {quest:98283}, an elite raptor"] = "{npc:1244}: {quest:98283}, 정예 랩터",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} and {npc:270844} stand together by the north gate."] = "{npc:2104}은(는) {area:2103}에 있으며, {npc:2094}와(과) {npc:270844}은(는) 북문 옆에 함께 있습니다.",
	-- ["{npc:2104} stands in {area:2103}; {npc:2094} stands by the north gate."] = "{npc:2104}은(는) {area:2103}에 있으며, {npc:2094}은(는) 북문 옆에 있습니다.",
	-- ["{npc:2104}: for {npc:270637}"] = "{npc:2104}: {npc:270637}에게",
	-- ["{npc:270844}: for {npc:3649} in {area:442} (02-desolace)"] = "{npc:270844}: {area:442}의 {npc:3649}에게 (02-desolace)",
	-- ["{npc:2784}, the {object:171709}"] = "{npc:2784}, {object:171709}",
	-- ["{npc:5683} waits north of {area:205} by the {area:881}; {npc:271322} a short walk further north-east."] = "{npc:5683}은(는) {area:205} 북쪽 {area:881} 옆에서 기다리고, {npc:271322}은(는) 조금 더 북동쪽에 있습니다.",
	-- ["{zone:1455} has no druid trainer: train with {npc:5504} in {zone:1453} before the tram."] = "{zone:1455}에는 드루이드 상급자가 없습니다. 전차를 타기 전에 {zone:1453}의 {npc:5504}에게 수련하십시오.",
}
