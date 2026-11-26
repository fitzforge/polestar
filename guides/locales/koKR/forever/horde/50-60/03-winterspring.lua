-- Korean (koKR): the guide forever/horde/50-60/03-winterspring (forever/horde/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1452} Winterspring · {zone:1448} Felwood · {zone:1444} Feralas · {zone:1456} Thunder Bluff
	["{zone:1452} and {zone:1448}, then {zone:1444} and {zone:1456}."] = "{zone:1452}, {zone:1448}, 그다음 {zone:1444}, {zone:1456}.",

	-- Step 1: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "{zone:1452}(으)로",

	-- Step 2: Salfa
	-- {npc:11556} Salfa · {zone:1452} Winterspring · {area:1769} Timbermaw Hold
	["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556}은(는) {area:1769} 터널의 {zone:1452} 쪽 출구, 나오는 바로 그 자리에 서 있습니다.",

	-- Step 3: Donova Snowden
	-- {npc:9298} Donova Snowden · {area:2246} Frostfire Hot Springs
	["Ride south from the tunnel: {npc:9298} camps among the steaming pools of {area:2246}, in the west of the valley."] = "터널에서 남쪽으로 가세요. {npc:9298}은(는) 골짜기 서쪽, {area:2246}의 김이 오르는 웅덩이 사이에 야영하고 있습니다.",
	-- {quest:980} The New Springs
	["{quest:980}, from Krakle in Un'Goro"] = "",
	-- {quest:3909} The Videre Elixir · {npc:7775} Gregan Brewspewer · {zone:1444} Feralas · {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide. {npc:9298}'s next errand, Strange Sources, is at the mouth of {area:2256} among level 59-60 elites: it waits for the last guide's {zone:1452} loop."] = "",

	-- Step 4: Winterspring
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {npc:9298} Donova Snowden
	["Ride east along the road past {area:2251} to {area:2255} first: its yeti and chimaera errands bring you about a quarter of a level, which the Frostfire furbolg camps want; {npc:9298}'s camps come on the ride back west."] = "",

	-- Step 5: Everlook
	-- {area:2255} Everlook
	["{area:2255} is the goblin town on the east side of the valley, past the owlbeast hills."] = "{area:2255}은(는) 골짜기 동쪽, 올빼미야수 언덕 너머의 고블린 마을입니다.",
	["Gregor's quests lead to other zones: keep them."] = "그레고르의 퀘스트는 다른 지역으로 이어집니다. 보관하세요.",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}, inside"] = "{npc:10431}, 내부",

	-- Step 6: Ice Thistle yetis
	["Ice Thistle yetis"] = "얼음엉겅퀴설인",
	-- {area:2255} Everlook
	-- plural, as words: Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti
	["The yeti hills start just south-east of {area:2255}. Every yeti drops fur. Careful: the Ice Thistle Yetis are 55-56: take the 55s one at a time, and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "",

	-- Step 7: Chillwind chimaeras
	["Chillwind chimaeras"] = "서리바람 키메라",
	-- {area:2255} Everlook · {area:2251} Lake Kel'Theril · {area:2245} Mazthoril
	-- plural, as words: Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["The chimaeras roam the snowfields south and west of {area:2255}. Careful: Chillwind Chimaeras are 55-57: take only the 55s, and the Fledgling Chillwinds (53-55) by {area:2251}, which carry the horns too. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "",

	-- Step 8: Everlook
	-- {zone:1423} Eastern Plaguelands · {area:2255} Everlook
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	-- was: ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "우미: 퀘스트를 유지하세요. 온전한 설인 뿔은 {zone:1423} 가이드의 {area:2255} 방문 때(약 57레벨) 모읍니다"
	["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 56"] = "",
	["The Matriarchs and Patriarchs that carry Umi's horns are 56-58: leave them for that later stop."] = "우미의 뿔을 지닌 맹렬한 설인과 덩치큰 설인은 56-58레벨입니다. 나중 방문 때까지 남겨 두세요.",

	-- Step 9: Raging Owlbeasts
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	["Raging Owlbeasts"] = "흉포한 올빼미야수",
	-- {area:2251} Lake Kel'Theril · {area:2255} Everlook · {area:2246} Frostfire Hot Springs
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast
	-- was: ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "흉포한 올빼미야수는 {area:2246}와(과) {area:2255} 사이 길가, {area:2251} 북쪽 언덕을 돌아다닙니다. 주의: 가장 큰 것은 56레벨입니다. 한 번에 한 마리씩 끌어오세요."
	["Ride back west: Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2255} and {area:2246}. Careful: the biggest are level 56: pull them one at a time."] = "",

	-- Step 10: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: 만나는 대로 처치하세요",
	-- {item:14047} Runecloth
	-- plural, as words: Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	-- was: ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "길잡이, 보초, 토템술사가 온천 주변 털보숭이 야영지에 함께 있고, 털복숭이 올빼미야수가 그 사이 비탈을 돌아다닙니다. 토템술사를 먼저 처치하세요. 얻는 {item:14047}은(는) 모두 메일로쉬를 위해 모아 두세요.\n주의: 보초는 56레벨까지 있습니다. 한 번에 한 마리씩 끌어오고 야영지의 토템은 피하세요."
	["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers are 55-56: pull the 55s, one at a time, and keep clear of the camps' totems."] = "",
	-- {item:12771} Empty Firewater Flask
	["{item:12771}: about one Winterfall furbolg in ten carries one; keep killing them until it drops"] = "{item:12771}: 여명의 설원 퍼볼그 열 마리당 한 마리가 지니고 있으니 떨어질 때까지 계속 처치하세요",
	-- {quest:8471} Winterfall Ritual Totem
	["{quest:8471}, a rare drop from the Winterfall furbolgs"] = "눈사태일족 털보숭이가 드물게 떨어뜨리는 {quest:8471}",

	-- Step 11: Donova Snowden
	-- {quest:5084} Falling to Corruption · {object:176091} Deadwood Cauldron · {zone:1448} Felwood
	["{quest:5084} is turned in at the {object:176091} in {zone:1448}, on a later trip."] = "{quest:5084}은(는) 나중에 {zone:1448}에 갈 때 {object:176091}에서 완료합니다.",

	-- Step 12: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "{area:431}(으)로 날아가기",
	-- {zone:1448} Felwood · {area:2255} Everlook · {area:431} Splintertree Post · {area:1237} Valormok
	["{zone:1448}'s southern hand-ins are next: ride back east to {area:2255}'s flight master, fly to {area:431} (by way of {area:1237}) and ride north into {zone:1448}, so the forest is ridden once, south to north."] = "",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "{area:2255} 비행 조련사",

	-- Step 13: Overlord Ror
	-- {zone:1448} Felwood · {area:1761} Deadwood Village
	["Ride north-west along the road into {zone:1448}. Ror stands at the far south end of {area:1761}, just inside the border."] = "",

	-- Step 14: Taronn Redfeather
	["North to the druids' camp."] = "",

	-- Step 16: Maybess Riverbreeze
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the Sanctuary"] = "성소 서쪽의 {npc:9529}",

	-- Step 18: Emerald Sanctuary
	-- {quest:5158} Seeking Spiritual Aid · {npc:5901} Islen Waterseer · {area:392} Ratchet
	["Keep {quest:5158}: {npc:5901} is by {area:392}, on the next guide."] = "",

	-- Step 19: The Jadefire moonwell
	["The Jadefire moonwell"] = "비취불꽃 달샘",
	-- {area:1763} Jaedenar · {npc:9996} Winna Hazzard
	["Ride north-west past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "",

	-- Step 20: Bloodvenom Post
	-- {area:1997} Bloodvenom Post
	["North up the road to {area:1997}."] = "",
	-- {npc:9996} Winna Hazzard · {quest:86612} Stag Lord's Bauble
	["{npc:9996}: the {quest:86612}"] = "{npc:9996}: {quest:86612}",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring · {zone:1423} Eastern Plaguelands
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{npc:10306}'s Moontouched Owlbeasts are 57-58, in {zone:1452}: keep it for the {zone:1423} guide's {zone:1452} stop."] = "",

	-- Step 21: Winna Hazzard's kitten
	-- {npc:9996} Winna Hazzard
	["{npc:9996}'s kitten"] = "{npc:9996}의 새끼 고양이",
	-- {item:12565} Winna's Kitten Carrier · {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard
	["Take the kitten back to the Jadefire moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "",
	-- {item:12565} Winna's Kitten Carrier
	["{item:12565}, at the Jadefire moonwell"] = "비취불꽃 달샘에서 {item:12565}",
	-- {npc:10042} Corrupted Saber · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["Bring the {npc:10042} to {npc:9996} at {area:1997} and click on it to hand it over."] = "{npc:10042}을(를) {area:1997}의 {npc:9996}에게 데려가 클릭해서 넘기십시오.",

	-- Step 23: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "{area:1099}(으)로 날아가기",
	-- {area:1997} Bloodvenom Post
	["{area:1997} flight master"] = "",

	-- Step 25: Evoroot
	-- {item:11242} Evoroot · {npc:7775} Gregan Brewspewer · {area:1114} Ruins of Ravenwind · {npc:9467} Miblon Snarltooth
	["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall.\nOr the front door: {npc:9467} guards it, and the Bait Gregan sells draws him off when you use it beside him. Half the players in our recordings went in that way, half through the wall."] = "",

	-- Step 26: The Videre Elixir
	-- {npc:7775} Gregan Brewspewer · {area:976} Gadgetzan
	["Back south to {npc:7775}. Keep the elixir and don't drink it yet: it kills you, and that is how you meet Gaeriyan by {area:976} later."] = "남쪽의 {npc:7775}에게 돌아가세요. 비약은 보관하고 아직 마시지 마세요. 마시면 죽는데, 나중에 {area:976} 근처에서 가에리얀을 만나는 방법이 바로 그것입니다.",
	-- {item:11243} Videre Elixir · {npc:7775} Gregan Brewspewer
	["{item:11243}, {npc:7775}'s reward"] = "{item:11243}, {npc:7775}의 보상",

	-- Step 28: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "{area:1638}(으)로 날아가기",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408} 비행 조련사",

	-- Step 29: Bluff Runner Windstrider
	-- {npc:10881} Bluff Runner Windstrider · {npc:14728} Rumstag Proudstrider · {area:1641} Hunter Rise
	-- was: ["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881}과(와) {npc:14728}은(는) {area:1641}에 서 있습니다. 럼스태그의 기부는 양모, 비단천, 마법천 각 60개가 필요합니다. 가진 만큼 제출하고 나머지는 건너뛰세요."
	["{npc:10881} and {npc:14728} stand on the central rise, not on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "",

	-- Step 30: Ghede
	-- {npc:9076} Ghede · {area:1639} Elder Rise
	["{npc:9076} stands on {area:1639}."] = "{npc:9076}은(는) {area:1639}에 서 있습니다.",

	-- Step 31: Elder Rise
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful
	["{npc:3033} on {area:1639}; {npc:246344}"] = "{area:1639}의 {npc:3033}, {npc:246344}",
	-- {quest:1123} Rabine Saturna · {zone:1450} Moonglade
	["{quest:1123} waits in {zone:1450}: keep it for later."] = "{quest:1123}은(는) {zone:1450}에서 기다립니다. 나중을 위해 보관하세요.",

	-- Step 32: Bashana Runetotem
	-- {npc:9087} Bashana Runetotem · {item:11103} Seed Voucher · {quest:3782} Morrowgrain Research · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Hand {npc:9087} the {item:11103} for her packets of Tharlendris Seeds. {quest:3782} gives you the {item:11020}: use it with a seed packet and two {quest:3761} in your bags to grow a random herb, sometimes {item:11040}, once every ten minutes. She wants ten, so the quest is optional: take it if you have spare {quest:3761} and want to keep growing it over the next guides."] = "",

	-- Step 34: Magatha Grimtotem
	-- {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise
	["{npc:4046} stands on {area:1639}."] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["Delivery to {npc:4046}, from Jediga in {zone:1447}"] = "",
	-- {npc:4046} Magatha Grimtotem · {zone:1447} Azshara
	["{npc:4046}'s payment goes back to Jediga in {zone:1447}, which the route doesn't pass again: leave it."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can carry the beads; the camps just south of {npc:11556} are the closest."] = "눈사태일족 털보숭이는 누구나 구슬을 지니고 있을 수 있습니다. {npc:11556} 바로 남쪽 야영지가 가장 가깝습니다.",
	-- ["Back at {area:1099}."] = "{area:1099}에 돌아왔습니다.",
	-- ["Back to {area:2255}"] = "{area:2255}(으)로 돌아가기",
	-- ["Below ground"] = "지하",
	-- ["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "두 {item:14047} 기부는 경로 뒤쪽에서 제출합니다. 원한다면 각각 {item:14047} 60개를 보관하세요.",
	-- ["Chillwind chimaeras"] = "서리바람 키메라",
	-- ["Fly to {area:1637}"] = "{area:1637}(으)로 날아가기",
	-- ["From Krakle in Un'Goro"] = "운고로 분화구의 크래클에게서",
	-- ["Frostfire Winterfall camp"] = "얼음불꽃 눈사태일족 야영지",
	-- ["Frostfire Winterfall camps"] = "얼음불꽃 눈사태일족 야영지",
	-- ["Gregor's and Harlo's quests lead to other zones: keep them."] = "그레고르와 하를로의 퀘스트는 다른 지역으로 이어집니다. 보관하세요.",
	-- ["Grind to 55"] = "55레벨까지 사냥",
	-- ["He stands on {area:1641}. Each donation wants cloth from your bags; hand them in when you have it, later in the route."] = "그는 {area:1641}에 서 있습니다. 기부마다 가방 속 옷감이 필요합니다. 나중에 경로 중 옷감이 모이면 건네세요.",
	-- ["In the {object:172958}."] = "{object:172958}에 있습니다.",
	-- ["In the {object:172961}."] = "{object:172961}에 있습니다.",
	-- ["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{object:172961} 안. 기부마다 양모, 비단천, 마법천 60개가 필요합니다. 가진 만큼 제출하고 나머지는 건너뛰세요.",
	-- ["Linken's letter"] = "링쿠의 편지",
	-- ["Matriarchs and Patriarchs hit hard: pull them one at a time."] = "맹렬한 설인과 덩치큰 설인은 세게 때립니다. 한 번에 한 마리씩 끌어오세요.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh."] = "길잡이, 보초, 토템술사가 온천 주변 털보숭이 야영지에 함께 있고, 털복숭이 올빼미야수가 그 사이 비탈을 돌아다닙니다. 토템술사를 먼저 처치하세요. 얻는 {item:14047}은(는) 모두 메일로쉬를 위해 모아 두세요.",
	-- ["Pathfinders, Den Watchers and Totemics share the furbolg camps around the hot springs; Ragged Owlbeasts roam the slopes between them. Kill Totemics first. Save every {item:14047} you loot for Meilosh.\nCareful: the Den Watchers reach 56: pull one at a time and keep clear of the camps' totems."] = "길잡이, 보초, 토템술사가 온천 주변 털보숭이 야영지에 함께 있고, 털복숭이 올빼미야수가 그 사이 비탈을 돌아다닙니다. 토템술사를 먼저 처치하세요. 얻는 {item:14047}은(는) 모두 메일로쉬를 위해 모아 두세요.\n주의: 보초는 56레벨까지 있습니다. 한 번에 한 마리씩 끌어오고 야영지의 토템은 피하세요.",
	-- ["Pristine Yeti Horns"] = "온전한 설인 뿔",
	-- ["Raging Owlbeasts roam the hills north of {area:2251}, by the road between {area:2246} and {area:2255}. Careful: the biggest are level 56: pull them one at a time."] = "흉포한 올빼미야수는 {area:2246}와(과) {area:2255} 사이 길가, {area:2251} 북쪽 언덕을 돌아다닙니다. 주의: 가장 큰 것은 56레벨입니다. 한 번에 한 마리씩 끌어오세요.",
	-- ["Ride back west to {area:2246}."] = "서쪽의 {area:2246}(으)로 돌아가세요.",
	-- ["Ride east, then south down {area:2249}. The Frostmaul giants there are elite level 59: keep to the middle and keep moving. The strange source is at the mouth of {area:2256}, at the south end."] = "동쪽으로 간 뒤 남쪽으로 {area:2249}을(를) 내려가세요. 그곳의 서리망치거인은 59레벨 정예입니다. 가운데로 다니며 멈추지 마세요. 이상한 근원은 남쪽 끝, {area:2256} 입구에 있습니다.",
	-- ["Ride west along the road past {area:2251}; Raging Owlbeasts roam the hills north of it."] = "길을 따라 서쪽으로 {area:2251}을(를) 지나가세요. 흉포한 올빼미야수는 그 북쪽 언덕을 돌아다닙니다.",
	-- ["The chimaeras roam the snowfields south and west of {area:2255}. Stay clear of {area:2245}'s cave: its blue dragonkin are elite."] = "키메라는 {area:2255} 남쪽과 서쪽의 설원을 돌아다닙니다. {area:2245} 동굴은 피하세요. 그곳의 푸른 용족은 정예입니다.",
	-- ["The furbolg village fills the valley north-east of {area:2255}. Kill Shamans first; they heal. {npc:10738} in the cave at the back is elite: stay out."] = "털보숭이 마을이 {area:2255} 북동쪽 골짜기를 가득 메우고 있습니다. 치유하는 주술사를 먼저 처치하세요. 안쪽 동굴의 {npc:10738}은(는) 정예입니다. 들어가지 마세요.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur: work the Ice Thistle Yetis (55-56) and leave the Matriarchs and Patriarchs (56-58), whose horns come on a later visit."] = "설인 언덕은 {area:2255} 바로 남동쪽에서 시작합니다. 모든 설인이 털가죽을 떨어뜨립니다. 얼음엉겅퀴설인(55-56)을 사냥하고, 맹렬한 설인과 덩치큰 설인(56-58)은 남겨 두세요. 뿔은 나중에 다시 올 때 모읍니다.",
	-- ["The yeti hills start just south-east of {area:2255}. Every yeti drops fur; only Matriarchs and Patriarchs drop horns, so keep those for after the turn-in."] = "설인 언덕은 {area:2255} 바로 남동쪽에서 시작합니다. 모든 설인이 털가죽을 떨어뜨리지만, 뿔은 맹렬한 설인과 덩치큰 설인만 떨어뜨리므로 완료 후를 위해 남겨 두세요.",
	-- ["The {item:11242} grows inside a ruined building north of {npc:7775}'s camp, east of the harpies' {area:1114}: climb in through the broken part of its wall."] = "{item:11242}은(는) 하피의 {area:1114} 동쪽, {npc:7775} 야영지 북쪽의 무너진 건물 안에서 자랍니다. 벽의 부서진 곳으로 들어가세요.",
	-- ["Top up here to level 55.04 before the hand-ins at {area:2255}: they take you to level 56. The Ice Thistle Yetis (55-56) are the lowest here; the Matriarchs and Patriarchs (56-58) hit harder. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "{area:2255}에서 퀘스트를 제출하기 전에 이곳에서 55.04레벨까지 올리십시오. 제출하면 56레벨이 됩니다. 이곳에서는 얼음엉겅퀴설인(55-56)이 가장 레벨이 낮고, 맹렬한 얼음엉겅퀴설인과 덩치큰 얼음엉겅퀴설인(56-58)은 더 강하게 공격합니다. 또는 파티와 함께 대신 {area:1584} 던전이나 {area:1583} 던전(아래쪽)을 도십시오.",
	-- ["Umi's third prank targets goblins in {area:976} and Un'Goro: keep it for later."] = "우미의 세 번째 장난은 {area:976}와(과) 운고로 분화구의 고블린을 노립니다. 나중을 위해 보관하세요.",
	-- ["Umi: keep it, the Pristine Yeti Horns come on the {zone:1423} guide's {area:2255} stop at about 57"] = "우미: 퀘스트를 유지하세요. 온전한 설인 뿔은 {zone:1423} 가이드의 {area:2255} 방문 때(약 57레벨) 모읍니다",
	-- ["grind on {npc:7440} at {area:2244}, {zone:1452}"] = "{zone:1452} {area:2244}에서 {npc:7440} 사냥",
	-- ["{item:12771}, a rare drop from the Winterfall furbolgs"] = "눈사태일족 털보숭이가 드물게 떨어뜨리는 {item:12771}",
	-- ["{npc:10307}, beside him"] = "그 옆의 {npc:10307}",
	-- ["{npc:10881} and {npc:14728} stand on {area:1641}. Each of Rumstag's donations takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "{npc:10881}과(와) {npc:14728}은(는) {area:1641}에 서 있습니다. 럼스태그의 기부는 양모, 비단천, 마법천 각 60개가 필요합니다. 가진 만큼 제출하고 나머지는 건너뛰세요.",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: 이전 가이드에서 이곳에 귀환 지점을 정하므로 보통 바로 완료됩니다",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}. He brews the {item:11243} only from an {item:11242} you bring him."] = "드워프 {npc:7775}은(는) {area:1099} 북서쪽 {area:1137}에 야영하고 있습니다. 그는 당신이 가져온 {item:11242}(으)로만 {item:11243}을(를) 만듭니다.",
	-- ["{npc:7775}, a dwarf, camps in the {area:1137} north-west of {area:1099}; he has the elixir."] = "드워프 {npc:7775}은(는) {area:1099} 북서쪽 {area:1137}에 야영하고 있습니다. 그가 비약을 가지고 있습니다.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}."] = "{npc:9087}은(는) {quest:3761}(으)로 기른 {item:11040}을(를) 삽니다.",
	-- ["{npc:9087} buys {item:11040} grown from your {quest:3761}. {quest:3782} wants ten, and the {item:11020} gives one try every ten minutes: take it only if you already have the grain."] = "{npc:9087}이(가) {quest:3761}로 키운 {item:11040}을(를) 삽니다. {quest:3782}은(는) 열 개를 원하고 {item:11020}은(는) 10분마다 한 번 시도하게 합니다. 곡물이 이미 있다면 그것만 쓰세요.",
	-- ["{quest:3909} comes from {npc:7775} in {zone:1444}, later in this guide."] = "{quest:3909}은(는) 이 가이드 후반에 {zone:1444}의 {npc:7775}에게서 받습니다.",
	-- ["{zone:1456} flight master"] = "{zone:1456} 비행 조련사",
}
