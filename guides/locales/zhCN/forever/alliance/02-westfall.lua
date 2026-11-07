-- Chinese (simplified) (zhCN): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Jansen Stead
	-- {area:40} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {area:40}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "沿着大路从艾尔文森林进入{area:40}：法布隆一家就在路边第一座被烧毁的农场旁。这一圈路上碰到的{object:2724}都捡上，剩下的回程时在这边的田里收齐。",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}；人类角色已在艾尔文森林从{npc:963}处接取此任务",

	-- Step 3: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "仅当你在艾尔文森林拾取了{item:1972}：右键点击它",

	-- Step 4: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "沿路向南，过了岔路口。{npc:233}站在屋外，{npc:235}在屋里，{npc:253395}在西边的谷仓里。幼年血牙野猪和碎尸鸟在农场周围的田野游荡：顺路收集肝脏和炖肉用的肉。",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "{npc:235}，在屋里",

	-- Step 5: Goretusk Snouts
	-- plural, as words: Goretusk Snouts = {item:731} Goretusk Snout
	["Goretusk Snouts"] = "{item:731}",
	-- {area:108} Sentinel Hill
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks root in the fields along the road south from Saldean's to {area:108}: take their snouts on the way."] = "{npc:454}在萨丁农场往南去{area:108}的路边田里拱土：顺路把它们的鼻子收了。",

	-- Step 6: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}和{npc:821}站在石塔顶上。{npc:491}在塔内，{npc:878}在山丘南侧，旅店和狮鹫管理员{npc:523}旁边。",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "{npc:491}，在塔内",
	-- {npc:523} Thor
	["{npc:523}; skip the free flight it offers"] = "{npc:523}；不要乘坐它提供的免费飞行",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}，在{npc:878}旁边",

	-- Step 8: Molsen Farm: kill these as you meet them
	-- {area:918} Molsen Farm
	["{area:918}: kill these as you meet them"] = "{area:918}：下面这些，遇到了就顺手杀",
	-- {area:108} Sentinel Hill · {area:918} Molsen Farm · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper · Harvest Watchers = {npc:114} Harvest Watcher · Young Goretusks = {npc:454} Young Goretusk
	["Defias Trappers and Smugglers camp in the fields between {area:108} and {area:918}.\nWest of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone.\nYoung Goretusks and Fleshrippers roam every leg of this loop: their livers and meat are for the pie and the stew."] = "{npc:504}和迪菲亚走私者扎营在{area:108}和{area:918}之间的田里。\n萨丁农场西边：{npc:114}和麦田傀儡在田里干活，掉的魔像同位弹簧、收割机陀螺稳定器、{item:732}，还有偶尔掉的{item:255155}，都留着别卖。{npc:573}是20级稀有，在这一带巡逻，绕开走。\n这一圈路上到处是{npc:454}和碎尸鸟，它们的肝和肉是做馅饼和炖菜的料，见着就杀。",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "{npc:114}",
	["Fill the vial at the farm's well"] = "在农场的井里装满药瓶",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}：碎尸鸟",

	-- Step 9: Furlbrow's Pumpkin Farm: kill these as you meet them
	-- {area:109} Furlbrow's Pumpkin Farm
	["{area:109}: kill these as you meet them"] = "{area:109}：下面这些，遇到了就顺手杀",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead · {object:290} Furlbrow's Wardrobe · {npc:502} Benny Blaanco
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll · Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nMurloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer.\nCareful: {object:290} stands in the ruined house east of the mine, on the way to the {area:916}. Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "这一片的{npc:117}和河爪斥候是11–13级，在海岸南边的山丘上游荡，从{area:111}上方往东一直到{area:916}。更南边和西边的豺狼人是13–19级：待在北边山丘。\n{npc:126}和鱼人袭击者就在矿洞北边的沙滩上晒太阳，它们残血时会逃跑：一只一只拉。\n小心：站得近的豺狼人容易成群加入战斗，一只一只拉更稳妥。\n小心：{object:290}就在矿洞东边那间破屋里，在去{area:916}的路上。屋里有两名迪菲亚把守，其中一个是15级的具名怪{npc:502}，它们是联动的，打一个就来俩。",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "{item:725}",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "{item:254548}",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "怀表就在屋里的{object:290}里",
	-- {quest:153} Red Leather Bandanas · {area:111} Jangolode Mine · {area:916} The Jansen Stead
	["{quest:153}: every Defias drops them, from {area:111} to the {area:916}"] = "{quest:153}：每个迪菲亚都会掉落，{area:111}到{area:916}这一带的都掉。",

	-- Step 10: The Jansen Stead
	["Sacks of Oats in the fields around the farm"] = "在农场周围收集一袋燕麦",
	["Fill the vial at the well"] = "在井里装满药瓶",

	-- Step 12: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "交给赤脊山{area:69}的{npc:266}",

	-- Step 13: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "向北经过{area:918}回到矿洞：狗头人掘地工在矿洞内干活。",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "{npc:1236}",

	-- Step 14: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "向西南前往海岸，在{area:918}以西。河爪矿工在采石场干活。",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "{npc:1426}",

	-- Step 15: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "{area:20}：下面这些，遇到了就顺手杀",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "{npc:589}和迪菲亚强夺者占着{area:108}以西、海岸大路与{area:20}之间的那几座农场。\n小心：{area:113}的那个洞里迪菲亚扎堆，一不小心就会引到好几个。",

	-- Step 17: Moonbrook and the Defias hills
	-- {area:20} Moonbrook
	["{area:20} and the Defias hills"] = "{area:20}和迪菲亚山丘",
	-- {area:20} Moonbrook · {area:1581} The Deadmines
	-- plural, as words: Defias Pathstalkers = {npc:121} Defias Pathstalker
	["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "{npc:121}和迪菲亚拳匪在{area:20}里游荡；迪菲亚路霸（17级）成对在它南边和东边的山丘上巡逻，记得拆开，一只一只拉。铁匠铺里的{area:1581}入口是小队副本，要组队进。\n小心：山丘上的营地都是迪菲亚混编组，等级低的时候很容易一次引到不止一个。",
	-- {item:254676} Suspicious Industrial Supplies · {area:20} Moonbrook
	["{item:254676}, from the crates around {area:20}"] = "{item:254676}，来自{area:20}周围的箱子",

	-- Step 18: Back to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Back to {area:108}"] = "返回{area:108}",
	-- {npc:11026} Sprite Jumpsprocket · {zone:1453} Stormwind · {object:28027} Dwarven District
	["For {npc:11026} in {zone:1453}'s {object:28027}"] = "交给{zone:1453}{object:28027}的{npc:11026}",

	-- Step 20: Defensive Stance
	-- {area:40} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {area:40}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "从{area:40}走去{zone:1453}；从{zone:1455}过来的地铁就停在{object:28027}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。如果{npc:5480}不给{quest:1638}，直接去找{npc:6089}：没那个任务他也给{quest:1639}。",

	-- Step 22: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "走去{zone:1453}。{npc:376}在光明大教堂。",

	-- Step 24: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "{npc:6171}和{npc:6173}在光明大教堂；{npc:6174}在{object:2096}，需要十块{item:2589}（人形怪掉落；拍卖行也有卖）。",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "在包里右键点击他给你的{item:6775}",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "{npc:6172}，在艾尔文森林的{area:86}旁，通往赤脊山的路上",

	-- Step 26: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁去{zone:1455}",

	-- Step 27: Shaman training
	["Shaman training"] = "萨满祭司训练",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "前往{zone:1453}。那里没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习技能，然后乘地铁返回坐船。",

	-- Step 28: Stormwind
	-- {zone:1453} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter
	["Walk to {zone:1453}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "走去{zone:1453}，知道飞行点的话也可以飞过去。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。",
	["Level 12, 14 and 16 spells"] = "12、14和16级法术",

	-- Step 29: Back to Stormwind City
	-- {area:1519} Stormwind City
	["Back to {area:1519}"] = "坐地铁返回{area:1519}",

	-- Step 31: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "为{zone:1439}的任务“收集解药”（6123）准备{item:2449}：在{npc:1313}的炼金用品店购买；草药师可在那里采集",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}，法师圣殿：{quest:1861}",

	-- Step 33: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "顺路找{npc:11867}学{spell:202}（{object:2096}，10银），双手武器是战士升级最快的。",

	-- Step 34: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "顺路找{npc:11867}学{spell:202}（{object:2096}，10银），双手武器是圣骑士升级最快的。",

	-- Step 35: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "顺路找{npc:11867}学法杖（{object:2096}，10银）。猎人的近战武器主要看属性，双手武器属性最高。",

	-- Step 36: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "顺路找{npc:11867}学剑类武器（{object:2096}，10银），主手拿剑，潜行者升级更稳。",

	-- Step 37: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "顺路找{npc:11867}学法杖（{object:2096}，10银），升级时法杖带的法术属性比单手武器高。",

	-- Step 39: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494}在{object:2096}西边的运河旁出售钓鱼用品；{npc:267118}在港口钓鱼，就在去坐船的路上。",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}，来自{npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "迪菲亚巡路者和迪菲亚拳匪在{area:20}巡逻；迪菲亚路霸（17级）成对巡逻其南边和东边的山丘：把它们分开拉。铁匠铺里的{area:1581}入口是团队地下城。",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "迪菲亚抢劫者和迪菲亚强夺者占据了{area:108}以西、海岸道路与{area:20}之间的农场。",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "飞往或骑往{zone:1453}。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "飞往或骑往{zone:1453}。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。{npc:11026}在{object:28027}，{npc:279}在{object:2096}。",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "飞往或骑往{zone:1453}。{npc:376}在光明大教堂。",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "飞往或骑往{zone:1453}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。",
	-- ["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "飞往或步行前往{zone:1453}。训练师：{object:2100}（战士、潜行者），大教堂（圣骑士、牧师），{object:2101}（法师、术士），公园（德鲁伊）。",
	-- ["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "飞往或步行前往{zone:1453}。{npc:376}在光明大教堂。",
	-- ["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "飞往或步行前往{zone:1453}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "沿道路从艾尔文森林进入{zone:1436}：法布隆夫妇坐在被烧毁的农场旁，就是道路边第一座农场。沿途从田里的燕麦袋中收集燕麦。",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "沿道路向北。{npc:233}站在屋外，{npc:235}在屋里，{npc:253395}在西边的谷仓里。",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "沿道路继续向北。法布隆夫妇坐在被烧毁的农场旁。沿途从田里的一袋燕麦收集燕麦，并在农场的井里装满药瓶。",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "沿道路继续向北。法布隆夫妇坐在被烧毁的农场旁。沿途从田里的一袋燕麦收集燕麦。",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "炉石在冷却？沿道路向东北走。",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "矿洞北边的海滩上排列着{npc:126}和鱼人袭击者。它们血量低时会逃跑：一次只拉一只。",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "在摩尔森农场以北。{npc:504}和迪菲亚走私者在矿洞外扎营，{npc:1236}在矿洞内干活。{object:290}在矿洞东边的废墟房屋旁。",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "在摩尔森农场以北。迪菲亚捕兽者和迪菲亚走私者在矿洞外扎营。{object:290}在矿洞东边的废墟房屋旁。",
	-- ["Only if he takes the isosprings alone"] = "仅当他只收下同位弹簧时",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "骑往{zone:1453}。那里没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习，然后乘地铁返回去坐船。",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "{npc:117}和河爪斥候（11-13级）在海岸南边的山丘上游荡，从{area:111}上方一直到东边的{area:916}。更南边和西边的豺狼人是13-19级：待在北边的山丘。",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "{npc:117}和河爪斥候在海岸与{area:916}之间的山丘上游荡。",
	-- ["Sacks of Oats"] = "一袋燕麦",
	-- ["Stormwind City"] = "暴风城",
	-- ["The gnoll hills"] = "豺狼人山丘",
	-- ["The north coast"] = "北部海岸",
	-- ["The western farms"] = "西部农场",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "在摩尔森农场以西，靠近海岸。{npc:1426}在采石场干活。",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "在萨丁农场以西。{npc:114}和麦田傀儡在田里干活；它们掉落同位弹簧、陀螺稳定器、{item:732}，有时还有{item:255155}。{npc:573}是20级稀有怪，在此巡逻：别惹它。在这条路线的每一段都继续击杀血牙野猪和碎尸鸟。",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "农场周围的田野里游荡着{npc:454}和碎尸鸟：返程时先收集肝脏和炖肉用的肉。",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234}和{npc:821}站在石塔顶上。{npc:491}在塔内，{npc:878}和{npc:253092}在山丘南侧，旅店和狮鹫管理员{npc:523}旁边。",
	-- ["{quest:153}: every Defias drops them"] = "{quest:153}：每个迪菲亚都会掉落",
}
