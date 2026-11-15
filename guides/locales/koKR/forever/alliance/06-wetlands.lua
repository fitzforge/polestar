-- Korean (koKR): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "",

	-- Step 2: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. With both half pendants in your bags, stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then go to {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}: {area:2362}에서 반쪽 합치기",

	-- Step 3: Aquatic Form
	-- {quest:5061} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take {quest:5061} from {npc:11802}, upstairs in his building. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "",

	-- Step 5: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the portal up to the {area:1658}, then fly back to {area:442} for the boat to {area:150}."] = "",

	-- Step 7: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 8: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "배를 타고 {area:150}(으)로",
	-- {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the boat from {area:442}'s dock to {area:150}."] = "",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "{area:150}(으)로 비행",
	-- {zone:1453} Stormwind City
	["{zone:1453} flight master"] = "",

	-- Step 13: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, 여관 안",
	-- {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}, {npc:1464}에게서",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes · {area:1036} Angerfang Encampment
	["{npc:2104}: {quest:98221}, the Attack Plans in the {area:1036}"] = "",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, 여관 북쪽 부두 위",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "",
	-- {npc:270844} Sylessa Duskwhisper · {npc:2094} James Halloran
	["{npc:270844}, beside {npc:2094} by the docks"] = "{npc:270844}, 부두 옆 {npc:2094} 곁",
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {area:205} Dun Modr
	["{npc:2097}, by the north gate: {npc:1071} takes it on 30-40/01-hillsbrad-foothills' {area:205} stop"] = "",

	-- Step 14: James Halloran
	-- {area:17732} Excavation Site: Wetlands · {npc:2094} James Halloran
	["For your {area:17732} run, later in this guide: {npc:2094}, by the docks, wants hides from the raptors inside."] = "{area:17732} 공략용(이 가이드 후반): 부두 옆의 {npc:2094}이(가) 내부 랩터의 가죽을 원합니다.",

	-- Step 15: Nord'el
	-- {item:279915} Nord'el · {area:150} Menethil Harbor
	["{item:279915} lies on the shore just south of {area:150}, a short walk past the town's south end. Then follow the coast north out of town to the hovels."] = "{item:279915}은(는) {area:150} 바로 남쪽 해안에 있습니다. 마을 남쪽 끝을 지나 조금만 걸어가면 됩니다. 그런 다음 해안을 따라 북쪽으로 마을을 벗어나 오두막까지 가세요.",

	-- Step 16: The Bluegill hovels
	["The Bluegill hovels"] = "푸른아가미 오두막",
	-- {area:1022} Bluegill Marsh · {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into {area:1022}. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "",

	-- Step 17: The Lost Fleet: kill these as you meet them
	-- {area:1039} The Lost Fleet
	["{area:1039}: kill these as you meet them"] = "",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "",
	-- {npc:1158} Cursed Marine · {npc:270589} Nightveiled Rotheap
	["{npc:1158}; careful: {npc:270589}, a level 31 elite, roams this coast"] = "{npc:1158}; 주의: 31레벨 정예 {npc:270589}이(가) 이 해안을 돌아다닙니다",

	-- Step 18: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "",
	-- {npc:270844} Sylessa Duskwhisper
	["{npc:270844}, beside him"] = "{npc:270844}, 그의 곁",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649} in {area:442}, on this guide's boat trip: keep it"] = "이 가이드의 배 여행 중 {area:442}의 {npc:3649}에게: 보관하세요",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: 성채 안의 {npc:2104}에게",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "{object:2117}의 볼바르 폴드라곤에게: 보관하세요",

	-- Step 19: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "선장은 난파선 갑판을 걸어다니고, 그의 금고는 선창에 있습니다.",

	-- Step 20: Raptor valley
	["Raptor valley"] = "랩터 계곡",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "",

	-- Step 21: Whelgar's Excavation Site
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "",

	-- Step 22: Whelgar's Excavation Site: kill these as you meet them
	-- {area:118} Whelgar's Excavation Site
	["{area:118}: kill these as you meet them"] = "",
	-- {npc:1353} Sarltooth · {object:331} Loose Soil
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: pull them away one at a time, or work around them."] = "유물은 발굴지 안에 있습니다. 커다란 무쇠턱 랩터인 {npc:1353}은(는) 그 바로 서쪽의 랩터 계곡을 어슬렁거립니다.\nGoaz Warder(정예, 32)가 유물과 {object:331} 사이에 서 있습니다. 하나씩 끌어내거나 피해서 작업하십시오.",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}: {object:331}",

	-- Step 23: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078}와(과) 웰가르",
	-- {npc:1077} Prospector Whelgar · {item:279993} Titanic Keystone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["{npc:1077}, below ground: the {item:279993}, from the elite Goaz Warders"] = "",

	-- Step 24: Goaz Warders
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["Goaz Warders"] = "",
	-- {item:279996} Goaz Stone · {npc:270892} Goaz Warder
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\n{npc:270892} is elite: grouping up is advised."] = "",

	-- Step 25: Prospector Whelgar
	["Below ground"] = "지하",

	-- Step 26: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {area:205} Dun Modr
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {area:205} visit"] = "",

	-- Step 27: Angerfang Encampment
	-- {zone:1455} Ironforge · {npc:2091} Chieftain Nek'rosh · {quest:98221} From the Ashes
	["North from the dig into the Dragonmaw camp: click the four sets of Attack Plans. The {zone:1455} plan lies at the camp's west end, the other three further east. {npc:2091}, an elite, stands apart to the south-east: {quest:98221} doesn't need him."] = "",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "",

	-- Step 28: Rethiel the Greenwarden
	-- {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the {area:1025}; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "",

	-- Step 29: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "",
	-- {area:1038} Dragonmaw Gates · {zone:1437} Wetlands
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor
	["Razormaw Incisors: from the raptors by the {area:1038}, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",
	-- {quest:98246} Trying Times
	["{quest:98246}: the Razormaw eggs, on the same loop"] = "",

	-- Step 30: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "",

	-- Step 31: Fen Creepers along the river
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers along the river"] = "",
	-- {npc:2093} Einar Stonegrip · {area:1024} Sundown Marsh · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["North-west from {npc:2093} to the river: Fen Creepers hide in its pools and along its banks all the way west to {area:1024}. Work west along it until you have twelve, then back east to {npc:1244}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "",

	-- Step 32: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {zone:1437} Wetlands
	["{quest:98283}, an elite raptor, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",

	-- Step 33: Rethiel the Greenwarden
	-- {area:17732} Excavation Site: Wetlands · {npc:1244} Rethiel the Greenwarden · {npc:260808} Highland Horror
	["For your {area:17732} run, on the way back west: {npc:1244} wants the root core of a {npc:260808} inside."] = "{area:17732} 공략용(서쪽으로 돌아가는 길): {npc:1244}은(는) 내부의 {npc:260808}에게서 나오는 뿌리 핵을 원합니다.",

	-- Step 34: Excavation Site: Wetlands
	-- {area:17732} Excavation Site: Wetlands · {npc:260808} Highland Horror · {npc:1244} Rethiel the Greenwarden · {npc:260326} Relic Guardian · {item:270865} Titan Relic · {npc:1077} Prospector Whelgar
	["{area:17732} is a dungeon for a group of five at about level 28 to 31. Its entrance lies just south of the road west, east of Whelgar's dig.\nInside: the Thicket raptors and Shadetooth drop the hides for Halloran, a {npc:260808} the root core for {npc:1244}. Saltspine, Shadetooth and the {npc:260326} are the bosses; the {npc:260326} drops a {item:270865}, which starts a quest for {npc:1077}."] = "{area:17732}은(는) 약 28~31레벨 5인 파티용 던전입니다. 입구는 서쪽 길 바로 남쪽, 웰가르의 발굴지 동쪽에 있습니다.\n내부: Thicket 랩터와 Shadetooth가 할로란에게 줄 가죽을, {npc:260808}이(가) {npc:1244}에게 줄 뿌리 핵을 떨어뜨립니다. Saltspine, Shadetooth, {npc:260326}이(가) 우두머리이며, {npc:260326}은(는) {npc:1077}에게 가는 퀘스트를 시작하는 {item:270865}을(를) 떨어뜨립니다.",
	-- {quest:98815} Highland Hides
	["{quest:98815}: the hides, inside"] = "{quest:98815}: 가죽, 내부",
	-- {quest:95646} Horrors in the Highland
	["{quest:95646}: the root core, inside"] = "{quest:95646}: 뿌리 핵, 내부",

	-- Step 35: Prospector Whelgar
	-- {item:270865} Titan Relic · {area:17732} Excavation Site: Wetlands · {npc:1077} Prospector Whelgar
	["The {item:270865} from your {area:17732} run: {npc:1077} is below ground in his dig, west of the entrance on the way back west."] = "{area:17732} 공략에서 얻은 {item:270865}: {npc:1077}은(는) 서쪽으로 돌아가는 길, 입구 서쪽의 발굴지 지하에 있습니다.",
	-- {npc:1077} Prospector Whelgar
	["{npc:1077}, below ground"] = "{npc:1077}, 지하",
	-- {npc:1077} Prospector Whelgar · {npc:5387} High Explorer Magellas · {zone:1455} Ironforge
	["{npc:1077}: for {npc:5387} in {zone:1455}, at the end of this guide"] = "{npc:1077}: {zone:1455}의 {npc:5387}에게, 이 가이드 마지막에",

	-- Step 36: Captain Stoutfist
	-- {area:150} Menethil Harbor · {area:2104} Deepwater Tavern · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1217} Glorin Steelbrow · {npc:2094} James Halloran
	["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:1217} in the {area:2104} south of it, {npc:2094} by the docks on the way to the boat."] = "",
	["On the top floor"] = "",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "",
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["{npc:1217}, in the {area:2104}"] = "",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind City
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks, on the way to the boat"] = "",

	-- Step 37: Level 28
	["Level 28"] = "28레벨",
	-- {zone:1437} Wetlands · {zone:1440} Ashenvale
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Still below level 28? That happens when you start this guide here without the {zone:1437} and {zone:1440} quests of the guides before it: top up on the Bluegill Raiders along the coast just south of Menethil before the boat, so {zone:1440}'s level 28-32 quests aren't too hard."] = "아직 28레벨 미만입니까? 이전 가이드의 {zone:1437} 및 {zone:1440} 퀘스트 없이 여기서 이 가이드를 시작하면 그렇게 됩니다. 배를 타기 전에 메네실 항구 바로 남쪽 해안의 푸른아가미 약탈자를 잡아 경험치를 채우십시오. 그래야 {zone:1440}의 28-32레벨 퀘스트가 너무 어렵지 않습니다.",
	-- {npc:1418} Bluegill Raider
	["grind on {npc:1418}"] = "{npc:1418} 사냥",

	-- Step 38: James Halloran
	-- {npc:2094} James Halloran
	["Your Excavation Site hides: {npc:2094}, by the docks."] = "발굴 현장 가죽: 부두 옆의 {npc:2094}.",

	-- Step 39: Boat to Auberdine
	-- {area:442} Auberdine
	["The boat to {area:442} leaves from the far end of Menethil's western pier."] = "",

	-- Step 40: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}, up the road from the dock."] = "{npc:3649}은(는) 부두에서 길을 따라 올라간 {area:442}의 북쪽 끝에 서 있습니다.",
	-- {item:279915} Nord'el · {npc:270844} Sylessa Duskwhisper · {area:150} Menethil Harbor
	["{item:279915}, from {npc:270844} in {area:150}"] = "{item:279915}, {area:150}의 {npc:270844}에게서",

	-- Step 41: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}."] = "",
	-- {area:442} Auberdine
	["Alexston's reply, if you still carry it (the route hands it in on 03-darkshore-return's first {area:442} stop)"] = "",

	-- Step 42: Auberdine
	-- {npc:3693} Terenthis
	["{npc:3693} stands by the flight master."] = "",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "{npc:3693}: {zone:1439} 마지막의 볼코르 호위",

	-- Step 43: Gershala Nightwhisper
	-- {area:2797} Blackfathom Deeps · {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis
	["Your {area:2797} brain stems: {npc:8997} stands a short walk west of {npc:3693}."] = "{area:2797}의 뇌줄기: {npc:8997}은(는) {npc:3693}에서 서쪽으로 조금 걸어가면 서 있습니다.",

	-- Step 44: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "",

	-- Step 45: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire · {area:415} Astranaar
	["{npc:3845} stands by {area:415}'s flight master."] = "",
	-- {quest:4581} Kayneth Stillwind · {area:2358} Forest Song
	["For {quest:4581} at {area:2358}"] = "",

	-- Step 46: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "",

	-- Step 47: Raene Wolfrunner
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691} stands in the inn, beside the innkeeper."] = "{npc:3691}은(는) 여관 안 여관주인 옆에 서 있습니다.",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {zone:1439} Darkshore
	["{npc:3691}: {quest:990}, if you still carry it from {zone:1439}"] = "{npc:3691}: {quest:990}, {zone:1439}에서 받아 아직 가지고 있다면",

	-- Step 48: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "파수꾼 멜리리아 프로스트섀도와 {npc:3901}",
	-- {area:415} Astranaar
	["The two stand together at the western end of the road, south-west of {area:415}."] = "",

	-- Step 49: Therysil
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["{npc:3585} stands at the {area:416}, a short walk from Melyria and {npc:3901}."] = "{npc:3585}은(는) {area:416}에 서 있으며, 멜리리아와 {npc:3901}에게서 조금만 걸어가면 됩니다.",
	-- {npc:3585} Therysil · {quest:945} Therylune's Escape · {zone:1439} Darkshore
	["{npc:3585}: {quest:945}, if you still carry it from {zone:1439}"] = "{npc:3585}: {quest:945}, {zone:1439}에서 받아 아직 가지고 있다면",

	-- Step 50: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "길을 따라 동쪽으로 {area:419}까지 가세요. {npc:3916}은(는) 달샘 옆에 서 있습니다.",

	-- Step 51: Dartol's Rod
	["Dartol's Rod"] = "다르톨의 변신마법봉",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "달샘 북쪽의 광기어린 고대정령과 부패한 고대정령이 {item:5475}을(를) 지니고 있습니다. 그 열쇠로 여는 낡은 궤짝은 그들 사이에 있습니다.",

	-- Step 53: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "길을 따라 동쪽으로 {area:429}의 사티로스 야영지까지 가십시오. {npc:3920}은(는) 야영지 가장자리에 숨어 있습니다.",

	-- Step 54: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619}은(는) {area:429} 사티로스의 우두머리이며 나뭇가지를 지니고 있습니다.",

	-- Step 55: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind · {npc:221269} Maseara Autumnmoon
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there, {npc:221269} a few steps east of her."] = "길 동쪽 끝의 나이트 엘프 전초기지 {area:2358}: {npc:3848}이(가) 그곳에 있고, {npc:221269}은(는) 그녀에게서 동쪽으로 몇 걸음 떨어져 있습니다.",
	-- {npc:221269} Maseara Autumnmoon · {area:430} Satyrnaar
	["{npc:221269}: her husband's trail in {area:430}, on the way back from the lake"] = "{npc:221269}: 호수에서 돌아오는 길에 {area:430}에서 남편의 흔적 찾기",

	-- Step 56: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "",

	-- Step 57: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: {area:415}의 {npc:3961}에게",

	-- Step 58: Satyrnaar
	-- {area:430} Satyrnaar · {area:2358} Forest Song · {object:19901} Circle of Imprisonment · {object:673431} Kurothel's Knapsack (no name in this language: may be words) · {item:281014} Vine-Wrapped Scroll · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["North from the lake to the satyr camp of {area:430}, just west of {area:2358}: the {object:19901} stands in it, and {object:673431} lies beside it with the {item:281014}.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "호수에서 북쪽으로, {area:2358} 바로 서쪽에 있는 {area:430}의 사티로스 야영지로 가십시오. 그 안에 {object:19901}이(가) 있고, 그 옆에 {item:281014}이(가) 든 {object:673431}이(가) 있습니다.\n주의: {area:428}의 펠머스크 도적은 은신해 있는 경우가 많고, {area:430}에는 사티로스 주문시전자가 있습니다.",
	-- {item:281014} Vine-Wrapped Scroll · {object:673431} Kurothel's Knapsack (no name in this language: may be words)
	["{item:281014}, from {object:673431}"] = "{item:281014}, {object:673431}에서",

	-- Step 59: Kayneth Stillwind
	-- {npc:3848} Kayneth Stillwind · {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Optional: {npc:3848} also offers {quest:1012}, three level 32 druids deep in {area:432}, a cave of quickly respawning, stealthed mobs, and back to her afterwards. It is above your level here: take it only if you are grouped or want the extra XP; the guide doesn't need it."] = "",
	-- {npc:221269} Maseara Autumnmoon
	["{npc:221269}, a few steps east"] = "{npc:221269}, 동쪽으로 몇 걸음",

	-- Step 60: The Dor'Danil Barrow Den's entrance
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}'s entrance"] = "",

	-- Step 61: Insane druids
	["Insane druids"] = "미치광이 드루이드",
	-- {area:432} The Dor'Danil Barrow Den · {npc:3940} Taneel Darkwood · {npc:3941} Uthil Mooncall · {npc:3942} Mavoris Cloudsbreak
	["The three druids are inside {area:432}, apart from each other: go in at its mouth, south of the Forsaken camp, not over the hill above them. {npc:3940} is in the eastern halls, {npc:3941} deepest down at the north-east end and {npc:3942} at the western end.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "",

	-- Step 63: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "두 번째 {object:19901}은(는) 서쪽으로 가는 길, {area:428} 골짜기에 있습니다.",

	-- Step 65: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "제단은 달샘 바로 남동쪽 언덕 위에 있습니다. 구불구불한 길을 따라 올라가십시오.",

	-- Step 67: The Howling Vale
	-- {area:419} Howling Vale · {npc:3792} Terrowulf Packlord
	-- plural, as words: Terrowulf Fleshrippers = {npc:3789} Terrowulf Fleshripper
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end. Careful: Terrowulf Fleshrippers and Shadow Weavers (28-30) stand in tight packs around the tome, and the {npc:3792}, a level 32 rare, walks the vale. Pull the wolves one at a time from the tunnel and let the Packlord pass first."] = "굴을 지나 {area:419}(으)로 들어가십시오. 마법책은 서쪽 끝 폐허에 있습니다. 주의: 공포늑대 살점찢개와 그림자술사(28-30)가 마법책 주위에 빽빽하게 무리 지어 있고, 32레벨 희귀 몹인 {npc:3792}이(가) 골짜기를 돌아다닙니다. 굴에서 늑대를 하나씩 끌어내고, 무리 우두머리가 먼저 지나가게 두십시오.",

	-- Step 68: Astranaar
	-- {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["{npc:3691} and {npc:3961} are in the inn; {npc:3894} is inside the building just south of it."] = "",
	-- {npc:3961} Maliynn
	["{npc:3961}, in the inn"] = "",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside the building south of the inn"] = "",

	-- Step 69: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake · {item:5462} Dartol's Rod of Transformation
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}. Use {item:5462} near him first: he only speaks to you in furbolg form."] = "타락하지 않은 펄볼그 {npc:3897}은(는) {area:421} 아래 길 남쪽에 앉아 있습니다. 먼저 그의 근처에서 {item:5462}을(를) 사용하세요. 그는 펄볼그 모습일 때만 말을 겁니다.",

	-- Step 70: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "",
	-- {item:5388} Ran Bloodtooth's Skull · {npc:3696} Ran Bloodtooth
	["{item:5388}, from {npc:3696}"] = "",

	-- Step 72: Melyria and Illiyana
	-- {npc:3897} Krolg · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {area:416}: Melyria and {npc:3901} stand together by it."] = "",

	-- Step 73: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {quest:967} The Tower of Althalaxx · {zone:1439} Darkshore
	["{npc:3663}: {quest:967}, if you still carry it from {zone:1439}"] = "{npc:3663}: {quest:967}, {zone:1439}에서 받아 아직 가지고 있다면",

	-- Step 74: Delgren the Purifier
	-- {area:413} Maestra's Post
	["North to {area:413}."] = "",

	-- Step 75: Astranaar
	-- {area:415} Astranaar · {npc:3691} Raene Wolfrunner
	["South-east along the road to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "",

	-- Step 76: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "{area:442}(으)로 비행",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "",

	-- Step 78: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "{area:1537}(으)로 비행",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 80: High Explorer Magellas
	-- {quest:98824} Prehistoric Prism · {npc:5387} High Explorer Magellas · {object:32356} Hall of Explorers (no name in this language: may be words) · {object:32372} Great Forge (no name in this language: may be words)
	["{quest:98824}: {npc:5387} stands in the {object:32356}, north-east of the {object:32372}."] = "{quest:98824}: {npc:5387}은(는) {object:32372} 북동쪽의 {object:32356}에 서 있습니다.",

	-- Step 81: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "{zone:1455} 사제",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406}와(과) {npc:258785}은(는) {object:32362}의 {object:32386}에 있습니다.",

	-- Step 82: Tram to Stormwind City
	-- {zone:1453} Stormwind City
	["Tram to {zone:1453}"] = "지하철을 타고 {zone:1453}(으)로",

	-- Step 83: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square
	["{npc:1646} stands in the {object:2098}."] = "{npc:1646}은(는) {object:2098}에 서 있습니다.",
	-- {npc:1646} Baros Alexston · {quest:97914} Expanding Horizons · {npc:3649} Thundris Windweaver
	["{npc:1646}: {quest:97914}, {npc:3649}'s letter, if you still carry it"] = "{npc:1646}: {quest:97914}, 아직 가지고 있다면 {npc:3649}의 편지",

	-- Step 84: Cathedral of Light
	["Cathedral of Light"] = "빛의 대성당",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind City · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "{object:171524}에서 {area:2257}을(를) 타고 {zone:1453}의 {object:28027}(으)로 간 뒤, {object:2098}까지 걸어가세요.",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, 빛의 대성당 안",

	-- Step 85: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "{zone:1431}에서 {quest:337}을(를) 획득한 경우에만",

	-- Step 86: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "빛의 대성당으로 돌아가세요. {npc:928}이(가) 안에 서 있습니다.",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "{area:271}의 {npc:2228}에게: 보관하세요",

	-- Step 87: Warden Thelwater
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square
	["For your {area:717} run: {npc:1719} keeps the {area:717}'s gate, south of the {object:2098}."] = "{area:717} 공략용: {npc:1719}은(는) {object:2098} 남쪽에서 {area:717} 입구를 지키고 있습니다.",

	-- Step 88: Warden Thelwater
	-- {npc:1719} Warden Thelwater · {quest:389} Bazil Thredd · {npc:1646} Baros Alexston
	["{npc:1719}: {quest:389}, from {npc:1646}"] = "{npc:1719}: {npc:1646}에게서 받은 {quest:389}",

	-- Step 90: Stockade
	-- {area:717} Stockade · {npc:1719} Warden Thelwater · {object:2098} Cathedral Square · {npc:1663} Dextren Ward · {quest:389} Bazil Thredd
	["{area:717} is a dungeon for a group of five, about levels 23 to 29, and a run takes under an hour. Its gate is {npc:1719}'s, south of the {object:2098}.\nInside: the Defias prisoners, convicts and insurgents for Thelwater, {npc:1663}'s hand for Millstipe, and {quest:389} at the far end."] = "{area:717}은(는) 약 23~29레벨 5인 파티용 던전이며, 공략에 1시간이 채 걸리지 않습니다. 입구는 {object:2098} 남쪽, {npc:1719}이(가) 지키는 문입니다.\n내부: 텔워터를 위한 데피아즈단 죄수, 죄인, 폭도, 밀스타이프를 위한 {npc:1663}의 손, 그리고 맨 끝의 {quest:389}.",

	-- Step 91: Warden Thelwater
	-- {npc:1719} Warden Thelwater
	["{npc:1719}, at the gate"] = "{npc:1719}, 입구",

	-- Step 93: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959}와(과) {npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, {object:2096}의 치즈 가게",

	-- Step 94: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "다음: {area:42}(으)로 날아가세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "길 동쪽 끝의 나이트 엘프 전초기지 {area:2358}: {npc:3848}이(가) 그곳에 있습니다.",
	-- ["{npc:3691}, in the inn"] = "{npc:3691}, 여관 안",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "타락하지 않은 펄볼그 {npc:3897}은(는) {area:421} 아래 길 남쪽에 앉아 있습니다.",
}
