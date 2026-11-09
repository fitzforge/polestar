-- Chinese (traditional) (zhTW): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
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
	["The bridge"] = "橋",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	-- plural, as words: Prowlers = {npc:118} Prowler
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it. His tools and Thomas's Prowlers and bears are south of the bridge, on the way back."] = "",

	-- Step 4: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "營地在橋的東北方。一捆木柴散落在營地周圍及其北邊的樹林裡。",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "",

	-- Step 5: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "它躺在伐木場西北方的河邊。",

	-- Step 6: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "迪菲亞流浪巫師在{area:86}岸邊紮營；他們也會掉落紅色亞麻面罩。{object:56}在東北岸的魚人村裡。",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "紅色亞麻面罩",

	-- Step 7: The gnoll camps
	["The gnoll camps"] = "豺狼人營地",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "河爪豺狼人在{area:86}西邊的山丘紮營；{quest:91725}就在他們的營地裡。",

	-- Step 8: The Jasperlode Mine's entrance
	-- {area:54} Jasperlode Mine
	["The {area:54}'s entrance"] = "",

	-- Step 9: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "礦坑在豺狼人營地西南方。{item:247816}在入口附近；狗頭人地卜師佔據隧道。",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "",

	-- Step 10: The Tower of Azora
	["Follow the hills south to the tower."] = "沿著山丘向南走到塔。",

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
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}；人類在艾爾文從{npc:963}那裡拿走了它",

	-- Step 17: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "只有在艾爾文森林拾取了{item:1972}時：右鍵點擊它",

	-- Step 18: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "沿路向南，過了岔路口。{npc:233}站在屋外，{npc:235}在屋裡，{npc:253395}在西邊的穀倉裡。幼年怖牙和撕皮鳥在農場周圍的田野遊蕩：順路收集肝臟和燉肉用的肉。",
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
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}和{npc:821}站在石塔頂端。{npc:491}在塔內，{npc:878}在山丘南側，旅店和獅鷲管理員{npc:523}旁邊。",
	-- {npc:234} Gryan Stoutmantle · {npc:963} Deputy Rainer
	["{npc:234}: from {npc:963} at Westbrook"] = "",
	-- {npc:491} Quartermaster Lewis · {zone:1453} Stormwind
	["{npc:491}, inside: back from {zone:1453}"] = "",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}，在{npc:878}旁邊",

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
	["{item:729}: Fleshrippers"] = "{item:729}：碎屍鳥",

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
	["Fill the vial at the farm's well"] = "在農場的井裝滿小瓶",

	-- Step 29: Molsen Farm's Harvest Watchers
	-- {area:918} Molsen Farm
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["{area:918}'s Harvest Watchers"] = "",
	-- {area:918} Molsen Farm · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers and Golems work the fields around {area:918}; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone."] = "",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "看守傀儡",

	-- Step 30: The gnoll hills
	["The gnoll hills"] = "豺狼人丘陵",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["North to the hills above {area:111}: Riverpaw Gnolls and Scouts (level 11-13) roam there, east toward the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer."] = "",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "豺狼人的爪子",

	-- Step 31: The Longshore murlocs
	-- {area:2} Longshore
	["The {area:2} murlocs"] = "",
	-- {area:916} The Jansen Stead
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the north coast from above the mine east toward the {area:916}: work along the beach eastward. They flee at low health: pull one at a time."] = "",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "長灘魚人鰓",

	-- Step 32: Furlbrow's Wardrobe
	-- {object:290} Furlbrow's Wardrobe · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	["{object:290} stands in the ruined house east of the mine, on the way to the {area:916}.\nCareful: Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "",

	-- Step 33: The Jansen Stead
	["Sacks of Oats in the fields around the farm"] = "",
	["Fill the vial at the well"] = "在井邊裝滿小瓶",

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
	["For {npc:266} in {area:69}, Redridge"] = "為了赤脊山{area:69}的{npc:266}",

	-- Step 39: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "向北經過{area:918}回到礦坑：狗頭人掘地工在礦坑內工作。",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "狗頭人掘地工",

	-- Step 40: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "向西南前往海岸，在{area:918}西邊。河爪礦工在採石場工作。",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "河爪礦工",

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
	["Shaman training"] = "薩滿訓練",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "前往{zone:1453}。那裡沒有薩滿祭司訓練師：從{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}處學習技能，然後乘地鐵返回坐船。",

	-- Step 52: Stormwind
	-- {area:1519} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Walk to {area:1519}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters), the Park (Druids)."] = "",
	["In through the main gate (already done if you are in the city)"] = "",
	["Level 12, 14 and 16 spells"] = "12、14和16級法術",

	-- Step 53: Back to Stormwind
	-- {zone:1453} Stormwind
	["Back to {zone:1453}"] = "",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["Ride the tram back: it comes out in {zone:1453}'s {object:28027}, where the errands below start."] = "",

	-- Step 54: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{zone:1439}「收集解藥」（6123）所需的{item:2449}：向鍊金術供應商{npc:1313}購買；草藥學家可改在那裡採集",
	-- {npc:7232} Borgus Steelhand · {object:28027} Dwarven District · {area:442} Auberdine
	["{npc:7232}, {object:28027}: for his brother in {area:442}"] = "",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}，巫師聖所：{quest:1861}",

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
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494}在{object:2096}西側的運河邊出售釣魚用品；{npc:267118}在港口釣魚，就在前往船的路上。",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}，向{npc:5494}購買",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:108}"] = "返回{area:108}",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "迪菲亞巡路者和迪菲亞拳匪在{area:20}巡邏；迪菲亞路霸（17級）成對巡邏其南邊和東邊的丘陵：把牠們分開拉。鐵匠鋪內的{area:1581}入口是小隊地城。",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "迪菲亞搶劫者和迪菲亞強奪者佔據了{area:108}西邊的農場，位於海岸道路和{area:20}之間。",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "飛往或騎往{zone:1453}。訓練師：{object:2100}（戰士、盜賊）、大教堂（聖騎士、牧師）、{object:2101}（法師、術士）、公園（德魯伊）。",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "飛往或騎往{zone:1453}。訓練師：{object:2100}（戰士、盜賊）、大教堂（聖騎士、牧師）、{object:2101}（法師、術士）、公園（德魯伊）。{npc:11026}在{object:28027}工作，{npc:279}在{object:2096}。",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "飛往或騎往{zone:1453}。{npc:376}在光明大教堂內。",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "飛往或騎往{zone:1453}。{npc:5480}在{object:2100}訓練戰士；{npc:6089}和{npc:6090}一起站在那裡的{object:2152}旁。{npc:6090}會為了他的杯子和你決鬥。",
	-- ["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "飛往或步行前往{zone:1453}。訓練師：{object:2100}（戰士、盜賊），大教堂（聖騎士、牧師），{object:2101}（法師、術士），公園（德魯伊）。",
	-- ["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "飛往或步行前往{zone:1453}。{npc:376}在光明大教堂。",
	-- ["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "飛往或步行前往{zone:1453}。{npc:5480}在{object:2100}訓練戰士；{npc:6089}和{npc:6090}一起站在那裡的{object:2152}旁。{npc:6090}會為了他的杯子和你打一架。",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "沿道路從艾爾文森林進入{zone:1436}：法布隆夫妻坐在被燒毀的農場旁，就是道路邊第一座農場。沿途從田裡的燕麥袋中收集燕麥。",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "沿道路向北走。{npc:233}站在屋外，{npc:235}在屋內，{npc:253395}在西邊的穀倉裡。",
	-- ["For {npc:11026} in {zone:1453}'s {object:28027}"] = "為了{zone:1453}{object:28027}的{npc:11026}",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "沿道路繼續向北。法布隆夫婦坐在被燒毀的農場旁。沿途從田裡的一袋燕麥收集燕麥，並在農場的井裝滿小瓶。",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "沿道路繼續向北。法布隆夫婦坐在被燒毀的農場旁。沿途從田裡的一袋燕麥收集燕麥。",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "爐石在冷卻中？沿道路往東北走。",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "灘行魚人和魚人襲擊者散布在礦坑北邊的海灘。牠們血量低時會逃跑：一次只拉一隻。",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "在摩爾森農場北邊。迪菲亞捕獸者和迪菲亞走私者在礦坑外紮營，狗頭人掘地工在礦坑內工作。{object:290}在礦坑東邊的廢墟旁。",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "在摩爾森農場北邊。迪菲亞捕獸者和迪菲亞走私者在礦坑外紮營。{object:290}在礦坑東邊的廢墟旁。",
	-- ["Only if he takes the isosprings alone"] = "只有在他只收等軸彈簧時",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "騎往{zone:1453}。那裡沒有薩滿訓練師：從{object:28027}搭乘{area:2257}前往{zone:1455}，向{npc:258098}學習，然後搭地鐵回來搭船。",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "{npc:117}和河爪斥候（11-13級）在海岸南邊的山丘上遊蕩，從{area:111}上方一直到東邊的{area:916}。更南邊和西邊的狗頭人是13-19級：待在北邊的山丘。",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "河爪豺狼人和河爪斥候在海岸與{area:916}之間的丘陵遊蕩。",
	-- ["Sacks of Oats"] = "一袋燕麥",
	-- ["The gnoll hills"] = "豺狼人丘陵",
	-- ["The north coast"] = "北部海岸",
	-- ["The western farms"] = "西部農場",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "在摩爾森農場西邊，靠近海岸。河爪礦工在採石場工作。",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "在薩丁農場西邊。看守傀儡和麥田傀儡在田裡工作；牠們掉落等軸彈簧、陀螺穩定器、{item:732}，有時掉落{item:255155}。{npc:573}是20級稀有怪，在此遊走：別惹它。這一圈的每一段都持續擊殺血牙野豬和碎屍鳥。",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "幼年血牙野豬和碎屍鳥在農場周圍的田野遊蕩：回程時順便收集肝臟和燉肉用的肉。",
	-- ["{area:20} and the Defias hills"] = "{area:20}與迪菲亞丘陵",
	-- ["{item:254676}, from the crates around {area:20}"] = "{item:254676}，來自{area:20}周圍的箱子",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}和{npc:821}站在石塔頂端。{npc:491}在塔內，{npc:878}和{npc:253092}在山丘南側，旅店和獅鷲管理員{npc:523}旁邊。",
	-- ["{npc:523}; skip the free flight it offers"] = "{npc:523}；跳過它提供的免費飛行",
	-- ["{quest:153}: every Defias drops them"] = "{quest:153}：所有迪菲亞都會掉落",
}
