-- Chinese (traditional) (zhTW): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:253092} Alba Fairmoon · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}和{npc:821}站在石塔頂端。{npc:491}在塔內，{npc:878}和{npc:253092}在山丘南側，旅店和獅鷲管理員{npc:523}旁邊。",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}；跳過它提供的免費飛行",

	-- Step 2: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "沿道路向北走。{npc:233}站在屋外，{npc:235}在屋內，{npc:253395}在西邊的穀倉裡。",

	-- Step 3: The Jansen Stead
	["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "沿道路繼續向北。法布隆夫婦坐在被燒毀的農場旁。沿途從田裡的一袋燕麥收集燕麥，並在農場的井裝滿小瓶。",
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "只有在艾爾文森林拾取了{item:1972}時：右鍵點擊它",
	["Fill the vial at the well"] = "在井邊裝滿小瓶",
	["Sacks of Oats"] = "一袋燕麥",

	-- Step 4: Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "幼年血牙野豬和碎屍鳥在農場周圍的田野遊蕩：回程時順便收集肝臟和燉肉用的肉。",

	-- Step 5: Molsen Farm
	-- {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "在薩丁農場西邊。看守傀儡和麥田傀儡在田裡工作；牠們掉落等軸彈簧、陀螺穩定器、{item:732}，有時掉落{item:255155}。{npc:573}是20級稀有怪，在此遊走：別惹它。這一圈的每一段都持續擊殺血牙野豬和碎屍鳥。",
	["Fill the vial at the farm's well"] = "在農場的井裝滿小瓶",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "看守傀儡",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}：碎屍鳥",

	-- Step 6: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "在摩爾森農場西邊，靠近海岸。河爪礦工在採石場工作。",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "河爪礦工",

	-- Step 7: Jangolode Mine
	-- {object:290} Furlbrow's Wardrobe
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Kobold Diggers = {npc:1236} Kobold Digger
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "在摩爾森農場北邊。迪菲亞捕獸者和迪菲亞走私者在礦坑外紮營，狗頭人掘地工在礦坑內工作。{object:290}在礦坑東邊的廢墟旁。",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "狗頭人掘地工",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153}：所有迪菲亞都會掉落",

	-- Step 8: The north coast
	["The north coast"] = "北部海岸",
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "灘行魚人和魚人襲擊者散布在礦坑北邊的海灘。牠們血量低時會逃跑：一次只拉一隻。",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "長灘魚人鰓",

	-- Step 9: The gnoll hills
	["The gnoll hills"] = "豺狼人丘陵",
	-- {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "河爪豺狼人和河爪斥候在海岸與{area:916}之間的丘陵遊蕩。",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "豺狼人的爪子",

	-- Step 11: Saldean's Farm
	["Only if he takes the isosprings alone"] = "只有在他只收等軸彈簧時",

	-- Step 13: The western farms
	["The western farms"] = "西部農場",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "迪菲亞搶劫者和迪菲亞強奪者佔據了{area:108}西邊的農場，位於海岸道路和{area:20}之間。",

	-- Step 15: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20}與迪菲亞丘陵",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "迪菲亞巡路者和迪菲亞拳匪在{area:20}巡邏；迪菲亞路霸（17級）成對巡邏其南邊和東邊的丘陵：把牠們分開拉。鐵匠鋪內的{area:1581}入口是小隊地城。",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}，來自{area:20}周圍的箱子",

	-- Step 16: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "返回{area:108}",
	["Hearthstone on cooldown? Follow the road north-east."] = "爐石在冷卻中？沿道路往東北走。",
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "為了赤脊山{area:69}的{npc:266}",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "為了{zone:1453}{object:28027}的{npc:11026}",

	-- Step 17: Defensive Stance
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "飛往或騎往{zone:1453}。{npc:5480}在{object:2100}訓練戰士；{npc:6089}和{npc:6090}一起站在那裡的{object:2152}旁。{npc:6090}會為了他的杯子和你決鬥。",

	-- Step 18: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "飛往或騎往{zone:1453}。{npc:376}在光明大教堂內。",

	-- Step 19: Shaman training
	["Shaman training"] = "薩滿訓練",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "騎往{zone:1453}。那裡沒有薩滿訓練師：從{object:28027}搭乘{area:2257}前往{zone:1455}，向{npc:258098}學習，然後搭地鐵回來搭船。",

	-- Step 20: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {npc:11026} Sprite Jumpsprocket · {object:28027} Dwarven District · {npc:279} Morgan Pestle · {object:2096} Trade District
	["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "飛往或騎往{zone:1453}。訓練師：{object:2100}（戰士、盜賊）、大教堂（聖騎士、牧師）、{object:2101}（法師、術士）、公園（德魯伊）。{npc:11026}在{object:28027}工作，{npc:279}在{object:2096}。",
	["Level 12, 14 and 16 spells"] = "12、14和16級法術",
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{zone:1439}「收集解藥」（6123）所需的{item:2449}：向鍊金術供應商{npc:1313}購買；草藥學家可改在那裡採集",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}，巫師聖所：{quest:1861}",

	-- Step 21: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494}在{object:2096}西側的運河邊出售釣魚用品；{npc:267118}在港口釣魚，就在前往船的路上。",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}，向{npc:5494}購買",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "河爪豺狼人和河爪斥候在海岸與{area:916}之間的丘陵遊蕩。",
}
