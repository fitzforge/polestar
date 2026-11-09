-- Korean (koKR): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Goldshire
	-- {zone:1453} Stormwind · {zone:1436} Westfall · {area:87} Goldshire · {npc:241} Remy "Two Times" · {npc:240} Marshal Dughan · {quest:40} A Fishy Peril · {quest:35} Further Concerns · {quest:109} Report to Gryan Stoutmantle
	["On the road from {zone:1453} to {zone:1436}, {area:87} is the first stop: {npc:241} stands outside the inn, {npc:240} beside him. {npc:241}'s {quest:40} goes straight to Dughan, who then gives {quest:35}; his {quest:109} goes with you to {zone:1436}."] = "",
	-- {npc:240} Marshal Dughan · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:240}: for {npc:234} at {area:108}"] = "",

	-- Step 2: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {area:18} Crystal Lake · {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["East along the road past {area:18}: {npc:248242} and {npc:248248} stand at the foot of the tower."] = "",

	-- Step 3: The bridge
	["The bridge"] = "다리",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	-- plural, as words: Prowlers = {npc:118} Prowler
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it. His tools and Thomas's Prowlers and bears are south of the bridge, on the way back."] = "",

	-- Step 4: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "야영지는 다리 북동쪽에 있습니다. 장작 더미는 야영지 주변과 북쪽 숲에 있습니다.",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "",

	-- Step 5: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "벌목장 북서쪽 강가에 있습니다.",

	-- Step 6: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "데피아즈단 견습마술사가 {area:86} 기슭에 야영하며, 붉은 리넨 복면도 떨어뜨립니다. {object:56}은(는) 북동쪽 기슭의 멀록 마을에 있습니다.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "붉은 리넨 복면",

	-- Step 7: The gnoll camps
	["The gnoll camps"] = "놀 야영지",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "갈퀴발일족 놀이 {area:86} 서쪽 언덕에 야영하며, {quest:91725}은(는) 그들의 야영지에 있습니다.",

	-- Step 8: The Jasperlode Mine's entrance
	-- {area:54} Jasperlode Mine
	["The {area:54}'s entrance"] = "",

	-- Step 9: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "광산은 놀 야영지 남서쪽에 있습니다. {item:247816}은(는) 입구 근처에 있으며, 코볼트 흙점쟁이가 터널을 차지하고 있습니다.",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "",

	-- Step 10: The Tower of Azora
	["Follow the hills south to the tower."] = "언덕을 따라 남쪽 탑으로 가십시오.",

	-- Step 11: Downstream
	-- {item:247813} Waterlogged Saw
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["East along the road, then into the river south of the bridge: the {item:247813}, Axe and Toolbox lie in it. Prowlers and Young Forest Bears roam its banks."] = "",

	-- Step 14: Goldshire
	-- {area:87} Goldshire · {zone:1436} Westfall · {npc:240} Marshal Dughan
	["Follow the road west to {area:87}, on the way to {zone:1436}: {npc:240} stands outside the inn."] = "",

	-- Step 15: The Jansen Stead
	-- {zone:1436} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}; 인간이 엘윈의 {npc:963}에게서 빼앗았습니다",

	-- Step 17: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "엘윈 숲에서 {item:1972}을(를) 획득한 경우에만: 오른쪽 클릭하십시오",

	-- Step 18: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "도로를 따라 남쪽, 갈림길을 지나서. {npc:233}은 밖에, {npc:235}는 집 안에, {npc:253395}는 서쪽 헛간에 있습니다. 어린 멧돼지와 살찢이가 농장 주변 들판을 돌아다닙니다: 가는 길에 간과 스튜 고기를 먼저 모으세요.",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "",

	-- Step 19: Goretusk Snouts
	-- plural, as words: Goretusk Snouts = {item:731} Goretusk Snout
	["Goretusk Snouts"] = "",
	-- {area:108} Sentinel Hill
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks root in the fields along the road south from Saldean's to {area:108}: take their snouts on the way."] = "",

	-- Step 20: Sentinel Hill's tower and Thor
	-- {area:108} Sentinel Hill · {npc:523} Thor
	["{area:108}'s tower and {npc:523}"] = "",
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:523} Thor · {npc:878} Scout Galiaan · {npc:1323} Osric Strang · {zone:1453} Stormwind · {npc:279} Morgan Pestle · {object:2096} Trade District · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town · {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {npc:352} Dungar Longdrink
	["{npc:234} and {npc:821} stand at the top of the stone tower, {npc:491} inside it, {npc:523} the gryphon master on the south side of the hill with {npc:878} beside him. {npc:523} gives you Lewis' note for {npc:1323} with a free flight to {zone:1453}: take it now. In {zone:1453}, {npc:279}'s shop is in the {object:2096} by the gryphons, {npc:1323}'s shop, {object:2156}, in {object:2100}; {npc:1646} stands in {object:2098} on the way back to {npc:352}, the gryphon master."] = "",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "",
	-- {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:878}, beside {npc:523}"] = "",
	-- {npc:523} Thor · {zone:1453} Stormwind
	["{npc:523}: the free flight he offers goes to {zone:1453}"] = "",

	-- Step 21: Osric Strang
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, {object:2096}, by the gryphons"] = "",
	-- {npc:1323} Osric Strang · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town
	["{npc:1323}, {object:2156} in {object:2100}"] = "",
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {zone:1436} Westfall
	["{npc:1646}, {object:2098}: his compass is in his old house in {zone:1436}"] = "",
	-- {npc:352} Dungar Longdrink
	["{npc:352}, the gryphon master"] = "",

	-- Step 22: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}와(과) {npc:821}은(는) 돌탑 꼭대기에 있습니다. {npc:491}은(는) 탑 안에, {npc:878}은(는) 언덕 남쪽의 여관과 그리폰 조련사 {npc:523} 옆에 있습니다.",
	-- {npc:234} Gryan Stoutmantle · {npc:963} Deputy Rainer
	["{npc:234}: from {npc:963} at Westbrook"] = "",
	-- {npc:491} Quartermaster Lewis · {zone:1453} Stormwind
	["{npc:491}, inside: back from {zone:1453}"] = "",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}, {npc:878} 옆",

	-- Step 24: Goretusk Livers as you go
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Goretusk Livers as you go"] = "",
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Goretusks and Young Goretusks root along every leg of this loop: kill the ones you pass for the pie's livers."] = "",

	-- Step 25: Stringy Vulture Meat as you go
	-- {item:729} Stringy Vulture Meat
	["{item:729} as you go"] = "",
	["Fleshrippers circle the fields along this loop: kill the ones you pass for the stew's meat."] = "",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: 식인독수리",

	-- Step 26: Red Leather Bandanas as you go
	-- {quest:153} Red Leather Bandanas
	["{quest:153} as you go"] = "",
	-- {item:829} Red Leather Bandana · {object:290} Furlbrow's Wardrobe
	["Every Defias on this loop can drop a {item:829}: the Trappers and Smugglers, and the guards at {object:290}."] = "",

	-- Step 27: Defias Trappers and Smugglers
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Defias Trappers and Smugglers"] = "",
	-- {area:108} Sentinel Hill · {area:918} Molsen Farm
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["North-west from {area:108} toward {area:918}: Defias Trappers and Smugglers camp in the fields between them."] = "",

	-- Step 28: Molsen Farm's well
	-- {area:918} Molsen Farm
	["{area:918}'s well"] = "",
	["Fill the vial at the farm's well"] = "농장 우물에서 약병 채우기",

	-- Step 29: Molsen Farm's Harvest Watchers
	-- {area:918} Molsen Farm
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["{area:918}'s Harvest Watchers"] = "",
	-- {area:918} Molsen Farm · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers and Golems work the fields around {area:918}; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone."] = "",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "허수아비골렘 보초",

	-- Step 30: The gnoll hills
	["The gnoll hills"] = "놀 언덕",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["North to the hills above {area:111}: Riverpaw Gnolls and Scouts (level 11-13) roam there, east toward the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer."] = "",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "놀의 앞발",

	-- Step 31: The Longshore murlocs
	-- {area:2} Longshore
	["The {area:2} murlocs"] = "",
	-- {area:916} The Jansen Stead
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the north coast from above the mine east toward the {area:916}: work along the beach eastward. They flee at low health: pull one at a time."] = "",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "기나긴 해안 멀록 아가미",

	-- Step 32: Furlbrow's Wardrobe
	-- {object:290} Furlbrow's Wardrobe · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	["{object:290} stands in the ruined house east of the mine, on the way to the {area:916}.\nCareful: Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "",

	-- Step 33: The Jansen Stead
	["Sacks of Oats in the fields around the farm"] = "",
	["Fill the vial at the well"] = "우물에서 약병 채우기",

	-- Step 34: Finish the Goretusk Livers
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Finish the Goretusk Livers"] = "",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Still short of eight? Young Goretusks root in the fields just west of {area:107}."] = "",

	-- Step 35: Finish the Stringy Vulture Meat
	-- {item:729} Stringy Vulture Meat
	["Finish the {item:729}"] = "",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Fleshrippers = {npc:199} Young Fleshripper
	["Still short of three? Young Fleshrippers circle the fields north-west of {area:107}."] = "",

	-- Step 37: Finish the Red Leather Bandanas
	-- {quest:153} Red Leather Bandanas
	["Finish the {quest:153}"] = "",
	-- {area:108} Sentinel Hill
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Still short of fifteen? Defias Trappers camp in the fields just west of {area:108}."] = "",

	-- Step 38: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "붉은마루 산맥 {area:69}의 {npc:266}에게",

	-- Step 39: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "{area:918}을(를) 지나 다시 북쪽의 광산으로 가십시오. 코볼트 채굴꾼이 안에서 일합니다.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "코볼트 채굴꾼",

	-- Step 40: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "남서쪽 해안, {area:918} 서쪽으로 가십시오. 갈퀴발일족 광부가 채석장에서 일합니다.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "갈퀴발일족 광부",

	-- Step 41: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {object:1166} Alexston's Chest · {area:219} Alexston Farmstead · {npc:1646} Baros Alexston · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}. {object:1166} stands in the farmhouse at the {area:219}, among them: {npc:1646}' compass is inside.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "",
	-- {item:2998} A Simple Compass · {object:1166} Alexston's Chest
	["{item:2998}, from {object:1166}"] = "",

	-- Step 44: Defensive Stance
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "",

	-- Step 46: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "",

	-- Step 48: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "",

	-- Step 49: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 50: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 51: Shaman training
	["Shaman training"] = "주술사 수련",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "{zone:1453}으로 가세요. 샤먼 훈련사가 없습니다: {object:28027}에서 {area:2257}을 타고 {zone:1455}로 가서 {npc:258098}에게 훈련받고, 배를 위해 트램을 타고 돌아오세요.",

	-- Step 52: Stormwind
	-- {area:1519} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Walk to {area:1519}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters), the Park (Druids)."] = "",
	["In through the main gate (already done if you are in the city)"] = "",
	["Level 12, 14 and 16 spells"] = "12, 14, 16레벨 주문",

	-- Step 53: Back to Stormwind
	-- {zone:1453} Stormwind
	["Back to {zone:1453}"] = "",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["Ride the tram back: it comes out in {zone:1453}'s {object:28027}, where the errands below start."] = "",

	-- Step 54: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{zone:1439}의 약재 모으기(6123)에 필요한 {item:2449}: {npc:1313}, 연금술 용품. 약초채집가는 대신 그곳에서 채집하세요",
	-- {npc:7232} Borgus Steelhand · {object:28027} Dwarven District · {area:442} Auberdine
	["{npc:7232}, {object:28027}: for his brother in {area:442}"] = "",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, 마법사의 성소: {quest:1861}",

	-- Step 56: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 57: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 58: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 59: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 60: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 62: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494}은(는) {object:2096} 바로 서쪽 운하를 따라 낚시 용품을 판매합니다. {npc:267118}은(는) 배로 가는 길의 항구에서 낚시를 합니다.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, {npc:5494}에게서",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:108}"] = "{area:108}(으)로 돌아가기",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "데피아즈단 정찰병과 데피아즈단 복면강도가 {area:20}을(를) 돌아다니고, 데피아즈단 노상강도(17레벨)가 남쪽과 동쪽 언덕을 둘씩 순찰합니다. 떼어서 상대하십시오. 대장간 안의 {area:1581} 입구는 파티 던전입니다.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "데피아즈단 강탈자와 데피아즈단 약탈자가 해안 도로와 {area:20} 사이, {area:108} 서쪽 농장들을 차지하고 있습니다.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "{zone:1453}(으)로 날아가거나 말을 타고 가세요. 상급자: {object:2100}(전사, 도적), 대성당(성기사, 사제), {object:2101}(마법사, 흑마법사), 공원(드루이드).",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "{zone:1453}(으)로 날아가거나 말을 타고 가세요. 상급자: {object:2100}(전사, 도적), 대성당(성기사, 사제), {object:2101}(마법사, 흑마법사), 공원(드루이드). {npc:11026}은(는) {object:28027}에서, {npc:279}은(는) {object:2096}에서 일합니다.",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "{zone:1453}(으)로 비행하거나 이동하십시오. {npc:376}은(는) 빛의 대성당에 있습니다.",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{zone:1453}(으)로 비행하거나 이동하십시오. {npc:5480}은(는) {object:2100}에서 전사를 가르치며, {npc:6089}와(과) {npc:6090}은(는) 그곳 {object:2152} 옆에 함께 있습니다. {npc:6090}이(가) 자기 잔을 걸고 결투를 합니다.",
	-- ["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "{zone:1453}으로 날아가거나 걸어가세요. 훈련사: {object:2100} (전사, 도적), 대성당 (성기사, 사제), {object:2101} (마법사, 흑마법사), 공원 (드루이드).",
	-- ["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "{zone:1453}으로 날아가거나 걸어가세요. {npc:376}은 빛의 대성당에 있습니다.",
	-- ["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{zone:1453}으로 날아가거나 걸어가세요. {npc:5480}은 {object:2100}에서 전사를 훈련시킵니다; {npc:6089}와 {npc:6090}이 그곳 {object:2152} 옆에 함께 서 있습니다. {npc:6090}이 자기 컵을 위해 싸웁니다.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "{zone:1436}으로 가는 엘윈 도로를 따라가세요: 퍼브로우 가족이 불에 탄 농장 옆에 앉아 있습니다, 도로 첫 번째 농장입니다. 가는 길에 들판의 귀리 자루에서 귀리를 수집하세요.",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "길을 따라 북쪽으로 가십시오. {npc:233}은(는) 밖에, {npc:235}은(는) 집 안에, {npc:253395}은(는) 서쪽 헛간에 있습니다.",
	-- ["For {npc:11026} in {zone:1453}'s {object:28027}"] = "{zone:1453} {object:28027}의 {npc:11026}에게",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "길을 따라 더 북쪽으로 가십시오. 펄브로우 부부가 불탄 농장 옆에 앉아 있습니다. 가는 길에 밭의 귀리 부대에서 귀리를 모으고, 농장 우물에서 약병을 채우십시오.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "길을 따라 더 북쪽으로 가십시오. 펄브로우 부부가 불탄 농장 옆에 앉아 있습니다. 가는 길에 밭의 귀리 부대에서 귀리를 모으십시오.",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "귀환석이 재사용 대기 중이라면 북동쪽 길을 따라가십시오.",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "멀록 길잡이와 멀록 약탈꾼이 광산 북쪽 해변에 늘어서 있습니다. 생명력이 낮으면 도망치니 하나씩 끌어오십시오.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "몰센 농장 북쪽입니다. 데피아즈단 덫사냥꾼과 데피아즈단 밀수업자가 광산 밖에 진을 치고, 코볼트 채굴꾼이 안에서 일합니다. {object:290}은(는) 광산 동쪽의 폐가 옆에 있습니다.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "몰센 농장 북쪽입니다. 데피아즈단 덫사냥꾼과 데피아즈단 밀수업자가 광산 밖에 진을 치고 있습니다. {object:290}은(는) 광산 동쪽의 폐가 옆에 있습니다.",
	-- ["Only if he takes the isosprings alone"] = "그가 골렘 등가용수철만 받을 때만",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "{zone:1453}(으)로 가십시오. 주술사 상급자가 없으니 {object:28027}에서 {area:2257}을(를) 타고 {zone:1455}(으)로 가서 {npc:258098}에게 수련한 뒤, 전차를 타고 돌아와 배를 타십시오.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "강발 그놀과 정찰대(11-13레벨)가 해안 남쪽의 언덕을 돌아다닙니다, {area:111} 위에서 동쪽으로 {area:916}까지. 더 남쪽과 서쪽의 그놀은 13-19레벨입니다: 북쪽 언덕에 머무르세요.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "갈퀴발 놀과 갈퀴발일족 정찰병이 해안과 {area:916} 사이 언덕을 돌아다닙니다.",
	-- ["Sacks of Oats"] = "귀리 부대",
	-- ["The gnoll hills"] = "놀 언덕",
	-- ["The north coast"] = "북쪽 해안",
	-- ["The western farms"] = "서쪽 농장들",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "몰센 농장 서쪽, 해안 방향입니다. 갈퀴발일족 광부가 채석장에서 일합니다.",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "살딘 농장 서쪽입니다. 허수아비골렘 보초와 허수아비골렘이 밭에서 일하며, 골렘 등가용수철, 허수아비골렘 회전안정기, {item:732}, 가끔 {item:255155}을(를) 떨어뜨립니다. 20레벨 희귀 몹 {npc:573}이(가) 이곳을 돌아다니니 건드리지 마십시오. 이 경로의 모든 구간에서 뿔엄니멧돼지와 식인독수리를 계속 처치하십시오.",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "새끼 뿔엄니멧돼지와 식인독수리가 농장 주변 밭을 돌아다닙니다. 돌아가는 길에 간과 스튜용 고기를 모으기 시작하십시오.",
	-- ["{area:20} and the Defias hills"] = "{area:20}와(과) 데피아즈단 언덕",
	-- ["{item:254676}, from the crates around {area:20}"] = "{item:254676}, {area:20} 주변 상자에서",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}와(과) {npc:821}은(는) 돌탑 꼭대기에 있습니다. {npc:491}은(는) 탑 안에, {npc:878}와(과) {npc:253092}은(는) 언덕 남쪽의 여관과 그리폰 조련사 {npc:523} 옆에 있습니다.",
	-- ["{npc:523}; skip the free flight it offers"] = "{npc:523}; 제공되는 무료 비행은 건너뛰십시오",
	-- ["{quest:153}: every Defias drops them"] = "{quest:153}: 모든 데피아즈단이 떨어뜨립니다",
}
