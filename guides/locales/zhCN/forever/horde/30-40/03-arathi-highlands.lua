-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/03-arathi-highlands (forever/horde/30-40/03-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	-- {area:35} Booty Bay · {object:3202} Grom'gol · {object:1661} The Undercity
	["From {area:35}, fly to {object:3202}. {object:1661} zeppelin leaves from the tower on the west side of the camp."] = "从{area:35}飞往{object:3202}。{object:1661}飞艇从营地西侧的塔楼出发。",
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "乘飞艇前往{zone:1458}",

	-- Step 2: Orgrimmar
	-- {object:1661} The Undercity · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{object:1661} has no Hunter or Shaman trainer: take the {zone:1454} zeppelin from the same tower instead and train in the city, then take the {zone:1458} zeppelin from the tower outside {zone:1454}'s main gate."] = "{object:1661}没有猎人或萨满祭司训练师：改从同一座塔楼乘飞艇前往{zone:1454}，在城里训练，然后从{zone:1454}正门外的塔楼乘飞艇前往{zone:1458}。",

	-- Step 3: Thunder Bluff
	-- {spell:18960} Teleport: Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "施放{spell:18960}，乘{npc:11798}的飞行路线前往{area:1638}；{npc:3033}在{area:1639}训练你。然后飞往{zone:1454}，在正门外的塔上乘坐前往{zone:1458}的飞艇。",

	-- Step 4: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458}的训练师",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "趁在{zone:1458}时训练：训练师在{object:36070}、{object:36073}和{object:36082}（圣骑士：{npc:260093}）。",

	-- Step 5: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飞往{area:272}",
	-- {zone:1458} Undercity · {area:272} Tarren Mill
	["The zeppelin lands at the towers outside the {zone:1458}: ride down into the city and fly to {area:272}."] = "飞艇降落在{zone:1458}外的塔楼：骑下去进城，飞往{area:272}。",

	-- Step 6: Boulderfist camp
	["Boulderfist camp"] = "石拳营地",
	-- {area:272} Tarren Mill · {area:1857} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Ride east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "从{area:272}向东骑出，穿过{area:1857}，沿道路向东。石拳食人魔和石拳执行者（32-34级）在道路南边、{area:313}东南方扎营。",

	-- Step 7: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["The violet shards glow just off the road a short way west of {area:321}."] = "紫色碎片在{area:321}西边不远处的路旁发光。",

	-- Step 8: Hammerfall
	["The orc stronghold at the eastern end of the road. Urda, the wind rider master, stands by the gate."] = "道路东端的兽人要塞。双足飞龙管理员尤尔达站在大门旁。",

	-- Step 9: Highland raptors
	["Highland raptors"] = "高地迅猛龙",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider
	["Highland Striders roam the hills all around {area:321}; both they and the Thrashers further west drop the eyes."] = "高地阔步龙在{area:321}四周的山丘上游荡；它们和更西边的高地长尾龙都会掉落眼睛。",

	-- Step 11: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael."] = "落锤镇东北方，枯须狗头人在峡谷中采矿；峡谷口的枯须狗头人和深处的枯须掘地工、枯须勘探员都会掉落密斯莱尔之尘。",

	-- Step 12: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701}在峡谷最深处。",

	-- Step 13: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}."] = "每个{object:180105}都是一圈立石；钥匙在中心的石头上。东部的法阵在{area:321}西北方的山丘上。",

	-- Step 14: Witherbark Village
	["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village."] = "枯木巨魔占据东南部山丘中的村庄。枯木掷斧者守卫外围的小屋；枯木巫医和枯木猎头者占据村子中心。",

	-- Step 15: Fleshstalker raptors
	["Fleshstalker raptors"] = "猎兽龙",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "高地猎兽龙（36-37级）在南部高地狩猎，一群在{area:316}北边，另一群在其西边的平原上。一次拉一只。",

	-- Step 16: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Ride south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "向西南骑行到南部海岸的地精海湾。{npc:2766}在海湾上方的悬崖上放哨。",

	-- Step 17: Professor Phizzlethorpe
	["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close."] = "护送教授到岸边。途中会有两个刺脊纳迦伏击他：跟紧他。",

	-- Step 19: Daggerspine shore
	["Daggerspine shore"] = "刺脊海岸",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "海湾西边，刺脊袭击者和刺脊巫师（38-40级）占据海岸：一次拉一个。两艘沉船在近海浅水中，海图和日志在船里；宝石在沉船周围的海底。",

	-- Step 20: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 44"] = "交给{area:35}的{npc:2487}，约44级",

	-- Step 21: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Ride north; the outer circle stands in the middle of the highlands."] = "向北骑行；外部法阵位于高地中央。",

	-- Step 22: Northfold Manor
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["The Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets."] = "辛迪加占据西北部有围墙的庄园和农场；辛迪加路霸、辛迪加雇佣兵和辛迪加巡路者携带血石护符。",

	-- Step 23: The Stone of West Binding
	-- {object:2689} Stone of West Binding
	["The {object:2689}"] = "{object:2689}",
	-- {area:1857} Thoradin's Wall
	["The western circle is near {area:1857}, where you rode in."] = "西部法阵在你进来时经过的{area:1857}附近。",

	-- Step 24: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "内部法阵在西部法阵南边、激流堡东边。",
	["The stone's next task needs Fozruk, a level 42 elite: leave it."] = "石头的下一个任务需要击败42级精英弗兹鲁克：放着别管。",

	-- Step 25: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "回到{area:321}",

	-- Step 26: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "石拳蛮兵在{area:321}南边食人魔大厅外扎营；石拳法师站在它们中间。一次拉一个。",

	-- Step 27: Drum Fel
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms
	["{npc:2771}'s next {quest:678} is against Boulderfist elites: leave it."] = "{npc:2771}的下一个{quest:678}要对付石拳精英：放着别管。",

	-- Step 28: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "进入{zone:1418}",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Ride south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "从阿拉希向西南越过{area:880}，向南穿过{zone:1437}（远离{area:150}），向东进入{zone:1432}；道路从{zone:1432}向南通往{zone:1418}。沿路向南到{area:1877}的地精营地。",

	-- Step 29: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}：来自{area:439}的菲兹尔的信",

	-- Step 30: The Dustbowl
	-- {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl · {area:340} Kargath
	["Ride west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "沿道路向西骑行；{npc:2921}的营地在前往{area:340}半途的{area:1878}。",

	-- Step 31: Kargath
	-- {area:340} Kargath
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge."] = "{area:340}是建在地区西缘悬崖中的部落要塞。",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "交给{area:75}的赫格拉姆，约42级",

	-- Step 32: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "次级石元素",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats just west of {npc:2921}'s camp. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards: keep them."] = "小型元素在{npc:2921}营地正西的平地上飘荡。这个地区的每个石元素都可能掉落{npc:6868}要的石元素的碎片：留着它们。",

	-- Step 34: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "石元素",
	-- {area:1878} The Dustbowl
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "更大的{npc:92}站在{area:1878}西北方的山坡上；每个都掉落一块石板。",

	-- Step 36: Coyotes and buzzards
	["Coyotes and buzzards"] = "山狗和秃鹫",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "{npc:2729}和{npc:2831}在{area:1878}南边的盆地中游荡。山狗掉落颚骨和尖牙；只有秃鹫掉落翅膀和胃。",

	-- Step 37: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "巨型石元素",
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["The Greater Rock Elementals (42-44, well above you) wander the gulches in the south-west; the bracers drop about one kill in five. Pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "巨型石元素（42-44级，远高于你）在西南部的沟壑中游荡；护腕约五次击杀掉落一次。一次拉一个，战斗间休息，或者放弃。途中继续击杀还需要的山狗和秃鹫。",

	-- Step 38: Kargath
	-- {area:340} Kargath
	["Ride north back to {area:340}."] = "向北骑回{area:340}。",

	-- Step 39: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}：仅当你携带{item:2868}时（{skill:164}或拍卖行）",

	-- Step 41: Stonevault troggs
	["Stonevault troggs"] = "石窟穴居人",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "石窟穴居人在{area:1877}南边、通往{area:345}路上的洞口周围挖掘；石窟断骨者和石窟萨满祭司掉落薄片。",

	-- Step 42: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "塞尔杜林坐在{area:1877}南边{area:345}的矮人废墟中。",

	-- Step 43: Valley of Fangs
	-- {npc:4618} Martek the Exiled
	["Follow the road north; {npc:4618}'s camp is on the way."] = "沿道路向北；{npc:4618}的营地就在路上。",

	-- Step 44: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "继续沿道路向北；箱子在{area:1517}挖掘场，位于道路西北方的废墟脚下。",

	-- Step 45: Agmond's End
	-- {area:1877} Valley of Fangs
	["Ride back south down the road, past the {area:1877}."] = "沿道路向南骑回，经过{area:1877}。",

	-- Step 46: Hearth to Kargath
	-- {area:340} Kargath
	["Hearth to {area:340}"] = "用炉石返回{area:340}",

	-- Step 47: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202}."] = "在{object:3202}西侧的塔楼乘飞艇前往{zone:1454}。",
	["Zeppelin tower"] = "飞艇塔",

	-- Step 49: Thunder Bluff
	-- {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:380} Crossroads
	["Your trainer is in {area:1638}, one flight from {zone:1454}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to the {area:380} from there."] = "你的训练师在{area:1638}，从{zone:1454}飞一次即到：{area:1639}的{npc:3033}（德鲁伊），{npc:246344}（圣骑士）。然后从那里飞往{area:380}。",

	-- Step 51: Regthar Deathgate
	-- {area:380} Crossroads · {area:386} Forgotten Pools · {npc:3389} Regthar Deathgate
	["Ride north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "从{area:380}沿道路向北骑到{area:386}；{npc:3389}在水边的高地上放哨。",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace
	["for {npc:5395} in {zone:1443}, in the next guide"] = "交给{zone:1443}的{npc:5395}，在下一份指南中",

	-- Step 52: Ratchet
	-- {area:380} Crossroads · {area:392} Ratchet
	["Ride back south to the {area:380} and fly to {area:392}."] = "向南骑回{area:380}，飞往{area:392}。",
	-- {item:3713} Soothing Spices · {zone:1445} Dustwallow Marsh
	["{item:3713}, for \"Swamp Eye\" Jarl in {zone:1445}"] = "{item:3713}，交给{zone:1445}的“沼泽之眼”加尔",
	-- {zone:1445} Dustwallow Marsh
	["The next guide heads into {zone:1445}."] = "下一份指南前往{zone:1445}。",

	-- Step 53: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "从{area:392}沿海岸向南骑到{area:720}。{npc:6236}站在竞技场旁：踏上格栅开始战斗；挑战者依次上场，然后是{npc:6238}（33级）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride west along the road; Lotwil's camp sits in the {area:1878} halfway to {area:340}."] = "沿道路向西骑行；鲁特维尔的营地在前往{area:340}半途的{area:1878}。",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "老峭壁山狗和巨型秃鹫在{area:1878}南边的盆地中游荡。山狗掉落颚骨和尖牙；只有秃鹫掉落翅膀和胃。",
	-- ["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "更大的石元素站在{area:1878}西北方的山坡上；每个都掉落一块石板。",
	-- ["The {area:380}"] = "{area:380}",
}
