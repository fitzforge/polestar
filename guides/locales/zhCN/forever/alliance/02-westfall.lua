-- Chinese (simplified) (zhCN): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}和{npc:821}站在石塔顶上。{npc:491}在塔内，{npc:878}在山丘南侧，旅店和狮鹫管理员{npc:523}旁边。",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}；不要乘坐它提供的免费飞行",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}，在{npc:878}旁边",

	-- Step 2: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "沿道路向北。{npc:233}站在屋外，{npc:235}在屋里，{npc:253395}在西边的谷仓里。",

	-- Step 3: The Jansen Stead
	["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "沿道路继续向北。法布隆夫妇坐在被烧毁的农场旁。沿途从田里的一袋燕麦收集燕麦。",
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "仅当你在艾尔文森林拾取了{item:1972}：右键点击它",
	["Fill the vial at the well"] = "在井里装满药瓶",
	["Sacks of Oats"] = "一袋燕麦",

	-- Step 4: Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "农场周围的田野里游荡着{npc:454}和碎尸鸟：返程时先收集肝脏和炖肉用的肉。",

	-- Step 5: Molsen Farm
	-- {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "在萨丁农场以西。{npc:114}和麦田傀儡在田里干活；它们掉落同位弹簧、陀螺稳定器、{item:732}，有时还有{item:255155}。{npc:573}是20级稀有怪，在此巡逻：别惹它。在这条路线的每一段都继续击杀血牙野猪和碎尸鸟。",
	["Fill the vial at the farm's well"] = "在农场的井里装满药瓶",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "{npc:114}",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}：碎尸鸟",

	-- Step 6: Jangolode Mine
	-- {object:290} Furlbrow's Wardrobe
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "在摩尔森农场以北。迪菲亚捕兽者和迪菲亚走私者在矿洞外扎营。{object:290}在矿洞东边的废墟房屋旁。",
	-- {quest:153} Red Leather Bandanas
	["{quest:153}: every Defias drops them"] = "{quest:153}：每个迪菲亚都会掉落",

	-- Step 7: The north coast
	["The north coast"] = "北部海岸",
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "矿洞北边的海滩上排列着{npc:126}和鱼人袭击者。它们血量低时会逃跑：一次只拉一只。",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "{item:254548}",

	-- Step 8: The gnoll hills
	["The gnoll hills"] = "豺狼人山丘",
	-- {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "{npc:117}和河爪斥候在海岸与{area:916}之间的山丘上游荡。",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "{item:725}",

	-- Step 12: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "向北经过{area:918}回到矿洞：狗头人掘地工在矿洞内干活。",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "{npc:1236}",

	-- Step 13: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "向西南前往海岸，在{area:918}以西。河爪矿工在采石场干活。",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "{npc:1426}",

	-- Step 14: The western farms
	["The western farms"] = "西部农场",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "迪菲亚抢劫者和迪菲亚强夺者占据了{area:108}以西、海岸道路与{area:20}之间的农场。",

	-- Step 16: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20}和迪菲亚山丘",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "迪菲亚巡路者和迪菲亚拳匪在{area:20}巡逻；迪菲亚路霸（17级）成对巡逻其南边和东边的山丘：把它们分开拉。铁匠铺里的{area:1581}入口是团队地下城。",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}，来自{area:20}周围的箱子",

	-- Step 17: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "返回{area:108}",
	["Hearthstone on cooldown? Follow the road north-east."] = "炉石在冷却？沿道路向东北走。",
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "交给赤脊山{area:69}的{npc:266}",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "交给{zone:1453}{object:28027}的{npc:11026}",

	-- Step 18: Defensive Stance
	-- {zone:1453} Stormwind · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "飞往或骑往{zone:1453}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。",

	-- Step 19: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "飞往或骑往{zone:1453}。{npc:376}在光明大教堂。",

	-- Step 20: Shaman training
	["Shaman training"] = "萨满祭司训练",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "骑往{zone:1453}。那里没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习，然后乘地铁返回去坐船。",

	-- Step 21: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter
	["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "飞往或骑往{zone:1453}。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。",
	["Level 12, 14 and 16 spells"] = "12、14和16级法术",
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "为{zone:1439}的任务“收集解药”（6123）准备{item:2449}：在{npc:1313}的炼金用品店购买；草药师可在那里采集",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}，法师圣殿：{quest:1861}",

	-- Step 22: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494}在{object:2096}西边的运河旁出售钓鱼用品；{npc:267118}在港口钓鱼，就在去坐船的路上。",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}，来自{npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "飞往或骑往{zone:1453}。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。{npc:11026}在{object:28027}，{npc:279}在{object:2096}。",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "沿道路继续向北。法布隆夫妇坐在被烧毁的农场旁。沿途从田里的一袋燕麦收集燕麦，并在农场的井里装满药瓶。",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "在摩尔森农场以北。{npc:504}和迪菲亚走私者在矿洞外扎营，{npc:1236}在矿洞内干活。{object:290}在矿洞东边的废墟房屋旁。",
	-- ["Only if he takes the isosprings alone"] = "仅当他只收下同位弹簧时",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "{npc:117}和河爪斥候在海岸与{area:916}之间的山丘上游荡。",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "在摩尔森农场以西，靠近海岸。{npc:1426}在采石场干活。",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}和{npc:821}站在石塔顶上。{npc:491}在塔内，{npc:878}和{npc:253092}在山丘南侧，旅店和狮鹫管理员{npc:523}旁边。",
}
