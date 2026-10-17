-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飞往{area:42}",
	-- {area:35} Booty Bay
	["Gyll, {area:35}"] = "盖尔，{area:35}",

	-- Step 2: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:217412} Amaryllis Webb
	["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "从{area:42}沿道路向东穿过{zone:1430}进入{zone:1435}；卫兵比格斯守在刚进入的岔路口。{npc:217412}站在他北边不远处。",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}：在阿拉希、{zone:1443}和荆棘谷各捕捉一只小动物",

	-- Step 3: The western swamp
	["The western swamp"] = "西部沼泽",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "道路周围的沼泽里游荡着小鳄鱼、沼泽纺丝蛛和沼泽虎。",

	-- Step 5: The Lost Caravan
	["The wrecked caravan lies off the road near Biggs."] = "被毁的货车在比格斯附近的路边。",

	-- Step 7: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "沿道路向北前往{area:657}的德莱尼人处。",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "沿道路向东前往{area:76}。{npc:256028}怪物掉落水晶；木棒诺博鲁在废墟中游走，会掉落他的木棒。",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391}被关在避难所北端的笼子里。救出他，并在护送他出去时保护他存活；之后他的保险箱就在路边。",

	-- Step 11: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "向西穿过{zone:1430}回到{area:42}。",

	-- Step 12: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}，{area:17203}的路上",
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}，光明大教堂",
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}，城堡里的皇家图书馆",

	-- Step 13: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122}在{object:2101}{object:2164}的地下室等候。在那里的召唤法阵使用{item:6913}，击败召来的魅魔。如果你接了{quest:65602}，也把{item:190309}交给他，放在同一个法阵上，然后击败梦魇。",
	["Subdue the succubus"] = "制服魅魔",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}，如果你接了",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}，在同一个法阵",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122}会将梦魇与你绑定",

	-- Step 14: Shaman training
	["Shaman training"] = "萨满祭司训练",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {npc:1573} Gryth Thurden · {object:32372} Great Forge · {area:271} Southshore
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453}没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习。{object:32372}的{npc:1573}也能飞往{area:271}。",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飞往{area:271}",

	-- Step 17: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "一名{npc:2434}隐身潜伏在{area:271}边缘；杀死他并阅读他携带的合同。",

	-- Step 18: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "沿道路向东离开{area:287}，越过{area:1057}前往{area:320}。",

	-- Step 19: Northfold Manor
	-- {area:320} Refuge Pointe · {npc:217589} Hay Weevil · {npc:217412} Amaryllis Webb
	["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "辛迪加占据着{area:320}西北的农场。一只{npc:217589}在农场里爬来爬去：用{npc:217412}的昆虫学入门套装捕捉一只，然后勾掉此项。",
	-- {npc:217589} Hay Weevil · {quest:93176} My Little Friends
	["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}：捕捉它，用于{quest:93176}",

	-- Step 21: Thandol Span
	-- {area:205} Dun Modr · {zone:1437} Wetlands · {npc:1075} Rhag Garmason
	["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "沿道路向南过桥，到达{zone:1437}一端的{area:205}，{npc:1075}在那里等候。",

	-- Step 22: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "伊贝尼瑟的尸体",
	["Walk back onto the span: Ebenezer lies under its Arathi end."] = "走回桥上：伊贝尼瑟的尸体在桥的阿拉希一端下方。",

	-- Step 23: Faldir's Cove
	["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "沿海岸向西前往地精的海湾（法迪尔海湾）；哨兵鲁鲁在上方的岩石上放哨。",

	-- Step 24: Phizzlethorpe
	["Phizzlethorpe"] = "菲兹索普教授",
	["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "护送教授到海湾北边的海滩，在他工作时保护他；纳迦会一波波来袭。",

	-- Step 26: The wrecks
	["The wrecks"] = "沉船",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "两艘沉船在海湾以西的海湾里。海图和航海日志在船里；宝石在周围的海底。整个海湾都有刺脊纳迦游动。",

	-- Step 27: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "交给{area:35}的{npc:2487}：保留它",

	-- Step 28: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "向东北骑回，经过{area:320}；{npc:2712}和{npc:2713}在{area:314}以北的山丘扎营。",

	-- Step 29: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "被遗忘者信使带着两名卫兵在{area:314}以西的路上行走；把他们引离道路。",

	-- Step 30: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712}和{npc:2713}",

	-- Step 31: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "{npc:2713}的差事",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "跟着{npc:2713}潜入{area:314}再回来；途中部落兽人会突袭你。",

	-- Step 32: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "交给{area:271}的{npc:2711}",

	-- Step 33: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "向北经过{area:314}；碎片在{area:333}旁的山丘上闪闪发光。",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "仅当格鲁高在荆棘谷给了你坠饰时",

	-- Step 34: Drywhisker Gorge
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "枯须狗头人在{area:321}（部落）以东的峡谷里挖掘；从北边绕过镇子。它们会掉落微粒和克拉兹克要的矿石。",

	-- Step 35: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "碎片在{area:318}的尽头。",

	-- Step 36: Witherbark Village
	-- {area:314} Go'Shek Farm
	["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "枯木巨魔住在{area:314}以南的山丘；枯木巫医在村子里，枯木暗影猎手守在山谷尽头。",

	-- Step 37: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "每把钥匙都在高地的一处石圈：碎片以东、{area:320}附近和西部。{object:2702}在{area:320}以西。",

	-- Step 39: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "食人魔法师{npc:2793}占据着枯木巨魔山谷南端的洞穴。",

	-- Step 41: Alterac Mountains
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "沿道路向北离开{area:271}进入山区。山地狮在山坡上游荡；{area:280}的辛迪加成员戴着图章戒指，{npc:2306}在镇子北边的庄园里走动。",

	-- Step 42: Crushridge ogres
	["Crushridge ogres"] = "破碎岭食人魔",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "破碎岭食人魔占据着{area:280}以北的山丘。再往北，一个破旧的木箱里装着{item:3706}；{quest:537}的{npc:2320}就站在旁边。",

	-- Step 43: Ruins of Alterac
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "书卷在{area:280}以西的废弃城堡（奥特兰克废墟）中；暗影大法师占据着废墟。",

	-- Step 44: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "向西南前往{area:279}以西湖岸的肯瑞托营地，刚越过边界进入{zone:1421}：{npc:269127}站在那里。大法师安斯雷姆·鲁因维沃尔站在其东南的穹顶旁。",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "交给{area:35}的{npc:2542}：保留它",
	-- {npc:252085} Archmage Celindra
	["{npc:252085}, in the City of Dalaran"] = "{npc:252085}，在达拉然城中",

	-- Step 45: Southshore
	-- {item:2321} Fine Thread · {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance
	["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{npc:2438}的披风需要{item:2321}，如果没有就从{npc:2381}处购买",
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "交给{zone:1453}的{npc:1440}：保留它",

	-- Step 47: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "从{zone:1455}出发，穿过{zone:1426}向东的隧道进入{zone:1432}，沿道路前往{area:144}。",

	-- Step 48: Ironband's Excavation Site
	["South-east along the loch to the dig site."] = "沿湖向东南前往挖掘场（铁环挖掘场）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north to the draenei of the {area:657}."] = "沿道路向北前往{area:657}的德莱尼人处。",
	-- ["Summon Succubus"] = "召唤魅魔",
}
