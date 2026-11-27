-- Chinese (simplified) (zhCN): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1435} Swamp of Sorrows · {area:271} Southshore · {area:327} Faldir's Cove
	["{zone:1435} first, then north to {area:271}, Alterac and Arathi. For characters of 36 to 38. {area:327}, where the naga and the professor's water elementals are 38-40, is a group stop: skip it if you are alone."] = "先去{zone:1435}，再向北前往{area:271}、奥特兰克和阿拉希。适合36到38级的角色。{area:327}的娜迦和教授的水元素为38-40级，那里是组队站点：单人就跳过。",

	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飞往{area:42}",

	-- Step 2: The Scythe of Elune
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery · {zone:1430} Deadwind Pass · {npc:661} Jonathan Carevin
	["South from {area:42} to the {area:121}, on the way to {zone:1430}: the mound of dirt by the Nightbane worgen (29-31) holds the evidence {npc:661} wants."] = "从{area:42}向南到{area:121}，在去{zone:1430}的路上：夜行狼人（29–31）旁的土堆里有{npc:661}要的证据。",
	-- {object:19030} Mound of Dirt
	["the {object:19030}"] = "{object:19030}",

	-- Step 4: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "{npc:5476}守在沼泽西侧的道路交汇处，{npc:217412}就在他北侧不远处。\n在无限服，{npc:217412}可能不在这里：如果{npc:217412}不提供{quest:93176}，就跳过。",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}：在阿拉希、{zone:1443}和荆棘谷各捕捉一只小动物",

	-- Step 5: The western swamp
	["The western swamp"] = "西部沼泽",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "道路周围的沼泽里游荡着小鳄鱼、沼泽纺丝蛛和沼泽虎。",

	-- Step 7: Father Tuttle
	-- {npc:255597} Father Tuttle · {area:657} Harborage
	["North-west of Watcher Biggs, {npc:255597} (level 34) waits by the road: lead him north to the {area:657}, on your way there. Stay close to him and clear what attacks him; if he falls, abandon the quest and go on."] = "在守望者比格斯西北，{npc:255597}（34级）在路边等候：顺路护送他向北前往{area:657}。紧跟着他，清掉攻击他的怪；如果他死了，放弃任务继续前进。",

	-- Step 8: Harborage
	-- {area:657} Harborage · {npc:254775} Karana · {npc:254770} Pelluk · {npc:1776} Magtoor · {area:76} Fallow Sanctuary
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Follow the road north to the draenei of the {area:657}. {npc:254775} and {npc:254770} stand beside {npc:1776}: their Lost Ones are the ones you meet in the {area:76} anyway."] = "沿路向北前往{area:657}的德莱尼人处。{npc:254775}和{npc:254770}站在{npc:1776}旁边：他们要的失落者就是你在{area:76}本来就会遇到的那些。",
	-- {npc:1776} Magtoor · {npc:255597} Father Tuttle
	["{npc:1776}: {npc:255597}'s escort"] = "{npc:1776}：护送{npc:255597}",

	-- Step 9: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {quest:1389} Draenethyst Crystals · {npc:254797} Lost One · {npc:254775} Karana · {npc:254770} Pelluk · {item:258530} Lucky Lure · {quest:1392} Noboru the Cudgel · {npc:1776} Magtoor
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["East along the road to the {area:76}. The {quest:1389} are the glowing blue crystals among the Lost Ones' tents: click them. Any {npc:254797} counts for {npc:254775}, and the Lost One Fishermen on the sanctuary's west side carry {npc:254770}'s {item:258530}. {quest:1392} walks a long path through the ruins; his cudgel starts a quest for {npc:1776}. Don't wait for him.\nCareful: Noboru is level 39, two over you here: fight him only with a friend or from level 38; otherwise let him pass."] = "沿路向东前往{area:76}。{quest:1389}是失落者帐篷间发着蓝光的水晶：点击它们。任何{npc:254797}都算作{npc:254775}的目标，避难所西侧的失落者渔夫携带{npc:254770}要的{item:258530}。{quest:1392}在废墟中长距离巡逻；他的木棒可开始一个交给{npc:1776}的任务。不必等他。\n小心：诺博鲁为39级，比你高两级：只在有朋友帮忙或达到38级时才打他；否则让他走过去。",
	-- {quest:1392} Noboru the Cudgel
	["from {quest:1392}: he walks a path through the ruins"] = "来自{quest:1392}：他沿一条路线穿过废墟游走",
	-- {item:6071} Draenethyst Crystal
	["{item:6071}, the blue crystals by the tents"] = "{item:6071}，帐篷旁的蓝色水晶",
	-- {item:258530} Lucky Lure · {npc:757} Lost One Fisherman
	["{item:258530}, from a {npc:757}"] = "{item:258530}，从{npc:757}身上获得",
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Lost Ones: Hunters, Muckdwellers, Seers and Riftseekers all count"] = "失落者：猎手、泥居者、先知和裂隙寻求者都算数",

	-- Step 10: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "被毁货车的箱子在{area:76}北端，{npc:5391}的笼子旁。\n小心：营地里到处是38级左右的迷失者。他们2-3个一组相互关联，很多是施法者，而且刷新很快。",

	-- Step 11: Galen Goodward
	-- {npc:5391} Galen Goodward
	-- plural, as words: Lost One Riftseekers = {npc:762} Lost One Riftseeker · Lost Ones = {npc:254797} Lost One
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards. Careful: on the walk out the camp's Lost One Riftseekers (37-38) and their pets, with the Lost Ones around them, turn on {npc:5391}: clear the cage and the start of his path first, stay beside him and pull every attacker onto yourself. Many players lose him the first time; if he dies, abandon the quest and take it again at his cage."] = "{npc:5391}被关在避难所北端的笼子里。救出他，并在护送他出去时保护他存活；之后他的保险箱就在路边。小心：护送出去时，营地里的失落寻隙者（37-38级）和它们的宠物，连同周围的失落者，会攻击{npc:5391}：先清理笼子和他路线的起点，紧跟在他身边，把所有攻击者都拉到自己身上。很多玩家第一次会让他死掉；如果他死了，放弃任务，再到他的笼子处重新接。",

	-- Step 12: Harborage
	-- {npc:5391} Galen Goodward · {area:657} Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "从{npc:5391}的保险箱处沿道路向西，前往{area:657}。",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "{npc:1776}：诺博鲁的木棒",
	-- {npc:1776} Magtoor · {quest:93464} The Visiting Mage · {npc:11863} Azore Aldamort · {zone:1443} Desolace
	["{npc:1776}: {quest:93464}, for {npc:11863} in {zone:1443}, on the {zone:1443} guide at the end of 30-40"] = "{npc:1776}：{quest:93464}，交给{zone:1443}的{npc:11863}，在30-40最后的{zone:1443}指南中",

	-- Step 13: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "沿路向南找{npc:5476}，他在向西离开沼泽的路上。",

	-- Step 14: Duskwood
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "向西穿过{zone:1430}回到{area:42}。",

	-- Step 15: Jonathan Carevin
	-- {npc:661} Jonathan Carevin · {area:42} Darkshire
	["{npc:661}, in {area:42}"] = "{npc:661}，在{area:42}",
	-- {zone:1457} Darnassus
	["His next errand goes to {zone:1457}, off this route: leave it."] = "他下一件差事去{zone:1457}，不在这条路线上：别接。",

	-- Step 16: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飞往{zone:1453}",

	-- Step 17: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}，{area:17203}的路上",

	-- Step 18: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}."] = "{npc:6122}在{object:2101}的{object:2164}地窖里等候。",

	-- Step 19: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122}在{object:2101}{object:2164}的地下室等候。在那里的召唤法阵使用{item:6913}，击败召来的魅魔。如果你接了{quest:65602}，也把{item:190309}交给他，放在同一个法阵上，然后击败梦魇。",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "{npc:5677}，在召唤法阵旁",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}，如果你接了",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}，在同一个法阵",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122}会将梦魇与你绑定",

	-- Step 20: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}，光明大教堂",

	-- Step 22: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}，城堡里的皇家图书馆",

	-- Step 23: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁前往{zone:1455}",

	-- Step 24: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飞往{area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飞行管理员",

	-- Step 25: Southshore
	-- {npc:2276} Magistrate Henry Maleb · {zone:1424} Hillsbrad Foothills
	["{npc:2276}, inside, if the {zone:1424} guide didn't take it: the Syndicate camp is on the way to Arathi"] = "{npc:2276}，在里面，如果{zone:1424}指南里没接：辛迪加营地在去阿拉希的路上",

	-- Step 26: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore · {npc:2276} Magistrate Henry Maleb
	["A {npc:2434} (37-38) lurks stealthed on the edge of {area:271}, and few players find him. Careful: he is a level or two over you; fight him only at full health, or leave him. His contract goes to {npc:2276}. Don't wait for him: the rest of this step doesn't need him."] = "一名{npc:2434}（37-38级）隐身潜伏在{area:271}边缘，很少有玩家能找到他。注意：他比你高一两级；只在满血时与他战斗，否则就别管他。他的合同交给{npc:2276}。不要专门等他：这一步的其余部分不需要他。",
	-- {npc:2434} Shadowy Assassin
	["{npc:2434}, if you spot him"] = "{npc:2434}，如果你发现他",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}：在屋内",

	-- Step 28: Alterac Mountains
	["Syndicate camp"] = "辛迪加营地",

	-- Step 29: Syndicate camp
	-- {area:271} Southshore · {area:272} Tarren Mill
	-- plural, as words: Syndicate Wizards = {npc:2319} Syndicate Wizard
	["North out of {area:271} to the Syndicate camp on the Alterac border, west of {area:272} (Horde): its Footpads and Thieves are the Syndicate Maleb wants, and the documents lie in the camp. Then back to the road and east to Arathi.\nCareful: a few Syndicate Wizards (34-35) stand among the tents and cast from range: pull them one at a time."] = "向北离开{area:271}，前往奥特兰克边境上的辛迪加营地，位于{area:272}（部落）以西：那里的辛迪加盗贼和窃贼就是马雷布要的辛迪加成员，文件就在营地里。然后回到道路上，向东前往阿拉希。\n注意：帐篷间站着几名辛迪加巫师（34-35级），会远程施法：一次只拉一个。",

	-- Step 31: Refuge Pointe
	-- {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["From the Syndicate camp, follow the road east over {area:1057} to {area:320}."] = "从辛迪加营地出发，沿道路向东越过{area:1057}前往{area:320}。",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason · {zone:1437} Wetlands
	["{npc:2700}: {npc:1075}'s plea, from the {zone:1437}"] = "把{npc:1075}在{zone:1437}托付的求援任务交给{npc:2700}。",

	-- Step 32: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "辛迪加占据{area:320}西北侧的农场。\n注意：辛迪加路霸为30-31级，非战斗状态下会使用潜行，因此经常隐身，很难发现。",

	-- Step 33: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit · {item:213562} Bug Catching Net
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: open {npc:217412}'s {item:213565} and use its {item:213562} on one. Don't kill it."] = "干草象鼻虫（{npc:217589}）在{quest:681}农场北端爬行：打开{npc:217412}的{item:213565}，对其中一只使用里面的{item:213562}。不要杀死它。",
	-- {item:213562} Bug Catching Net · {npc:217589} Hay Weevil · {item:213568} Hay Weevil Specimen
	["{item:213562}, on a {npc:217589}: the {item:213568}"] = "{item:213562}，用在{npc:217589}上：{item:213568}",

	-- Step 34: Shards of Myzrael
	-- {quest:681} Northfold Manor · {area:333} Circle of East Binding · {area:314} Go'Shek Farm
	["East from {quest:681} across the north of the Highlands; the shards glitter on the hill by the {area:333}, north of {area:314}."] = "从{quest:681}向东穿过高地北部；碎片在{area:333}旁的山丘上闪闪发光，位于{area:314}以北。",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "仅当格鲁高在荆棘谷给了你坠饰时",

	-- Step 35: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "{area:318}：沿途击杀以下目标",
	-- {area:321} Hammerfall · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop the Motes of Myzrael, not Krazek's ore. Lesser Bloodstone Deposits need {skill:186} 75: mine four ore, buy them at the Auction House, or ask a miner friend. The ore goal is optional; continue with Myzrael if you cannot get it. Careful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "枯须狗头人在部落城镇{area:321}以东的峡谷里采掘，从城镇北侧绕过去。它们掉落密斯莱尔之尘，不掉克拉兹克要的矿石。次级血石矿脉需要{skill:186} 75：开采四块矿石、在拍卖行购买，或请会采矿的朋友帮忙。矿石目标是可选的；拿不到就继续做密斯莱尔的任务。小心：每种狗头人在低血量时都会逃跑求援（枯须狗头人30%，勘探员和掘地工15%），可能引来更多敌人。",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "从这一站附近的{npc:2572}、{npc:2573}和{npc:2574}身上获取{item:4435}",

	-- Step 36: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "碎片在{area:318}的尽头。",
	["Below ground"] = "在地下",

	-- Step 37: Iridescent Shards
	-- {quest:651} Stones of Binding · {object:2691} Stone of East Binding
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{quest:651} is a group quest at this level: three Cresting Exiles (38-39) guard the {object:2691} and attack together. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "在这个等级，{quest:651}是小队任务：三只水浪流放者（38-39级）守卫着{object:2691}，会一起攻击。建议组队，找人一起做。如果你是单人就跳过。",

	-- Step 38: Witherbark Village
	-- {area:318} Drywhisker Gorge · {area:314} Go'Shek Farm · {area:317} Witherbark Village · {npc:2712} Quae
	-- plural, as words: Witherbark Goliaths = {npc:218032} Witherbark Goliath
	["South from {area:318}, past {area:314}, through {area:317} to the far end of the valley: the Shadow Hunters there drop the knife, and the trolls packed around them give most of the tusks. Then the Witch Doctors among the huts for the pouches, on the way back out towards {npc:2712}. Careful: Witherbark Goliaths (35, elite) walk the far end with the Shadow Hunters: pull the Hunters out to you one at a time, away from the Goliaths."] = "从{area:318}向南，经过{area:314}，穿过{area:317}来到山谷尽头。这里的枯木暗影猎手会掉落短刀，附近扎堆的巨魔是獠牙的主要来源。然后往{npc:2712}的方向折返，顺路击杀小屋之间的枯木巫医收集药包。小心，枯木巨怪（35级精英）和枯木暗影猎手都在山谷尽头活动。每次只拉一名暗影猎手，拉到远离巨怪的地方再打。",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "{item:5040}：在地下",

	-- Step 39: Quae
	-- {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["North-west out of the Witherbark valley; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "向西北离开枯木山谷；{npc:2712}和{npc:2713}在{area:314}北侧不远的山丘扎营。",

	-- Step 40: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road from {area:314} west across the Highlands, as far as about 24,45, and back, with two guards: the arrow follows the road west until you meet him. Pull them off the road."] = "被遗忘者信使带着两名卫兵，沿道路从{area:314}向西穿过高地，最远到约24,45处，然后折返：箭头会沿道路向西指引，直到你遇到他。把他们引离道路。",

	-- Step 42: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712}和{npc:2713}",

	-- Step 43: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "{npc:2713}的差事",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "跟随{npc:2713}潜入{area:314}并返回，途中会有部落兽人伏击。\n注意：兽人低血量时会逃跑，{npc:2713}会追击，可能引来更多怪。及时击杀或减速逃跑者。",

	-- Step 44: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "交给{area:271}的{npc:2711}",

	-- Step 45: Stones of Binding
	-- {npc:2712} Quae · {object:2691} Stone of East Binding · {area:314} Go'Shek Farm · {object:2702} Stone of Inner Binding · {area:320} Refuge Pointe
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["From {npc:2712}'s camp, a short way north-east to the {object:2691}, by the shards' hill north of {area:314}. The {object:2702}, where the three keys go, stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "从{npc:2712}的营地向东北走一小段，前往{object:2691}，在{area:314}以北的碎片山丘旁。放置三把钥匙的{object:2702}位于{area:320}以西。\n注意：各法阵的中心石周围约有三只39级元素生物，未清理就点击石头，会一起攻击你：西侧为烈焰流放者，外侧为雷霆流放者，东侧为水浪流放者。",

	-- Step 46: Refuge Pointe
	-- {area:320} Refuge Pointe
	["West along the road to {area:320}."] = "沿道路向西前往{area:320}。",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {object:2689} Stone of West Binding
	["{npc:2789}: {npc:2793}'s cave, west past the {object:2689}"] = "{npc:2789}：{npc:2793}的洞穴，经过{object:2689}再往西",

	-- Step 48: Faldir's Cove
	-- {npc:2768} Professor Phizzlethorpe
	["A group stop: two level 40 water elementals ambush {npc:2768}'s escort, and the Daggerspine naga in the reef are 38-40, with Sorceresses among them. Grouping up is encouraged, look for people to do it with. Skip it if you are alone.\nSouth along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "小队环节：两只40级水元素会伏击{npc:2768}的护送，礁石上的刺脊娜迦为38-40级，其中还有女巫。建议组队，找人一起做。如果你是单人就跳过。\n沿西海岸向南前往地精的海湾；洛洛在海湾上方的岩石上放哨。",

	-- Step 49: Phizzlethorpe
	["Phizzlethorpe"] = "菲兹索普教授",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "护送教授上山，前往海湾上方的洞穴，并在他工作时保护他。那里会有两只40级水元素伏击，它们免疫冰霜。在洞口拦住它们，远离教授；如果在洞内战斗，教授会停下工作参战，水元素也会不断出现。",

	-- Step 51: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}：沿途击杀以下目标",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay.\nCareful: the charts and logs lie deep inside the wrecks: watch your breath bar and come up between them; a water breathing potion makes it easy."] = "两艘沉船在小海湾以西的海里。海图和航海日志在船里面；宝石在它们周围的海底。刺脊纳迦在整个海湾游弋。\n注意：海图和日志在沉船深处：盯着呼吸条，两艘之间上来换气；有水下呼吸药水就轻松了。",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "{npc:2595}：在水下",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "{item:4492}：在水下",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "{npc:2596}：在水下",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "{object:2709}：在水下",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "{object:2707}：在水下",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "{object:2710}：在水下",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "{object:2708}：在水下",

	-- Step 52: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "交给{area:35}的{npc:2487}：保留它",

	-- Step 53: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["South-east through the hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley.\nCareful: {npc:2793} is level 39, a caster, one or two over you here: clear the cave mouth first, then pull him alone at full health."] = "向东南穿过山丘：食人魔法师{npc:2793}占据着枯木山谷南端的洞穴。\n注意：{npc:2793}为39级施法者，比你高一两级：先清理洞口，再在满血时单独拉他。",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "{item:4525}：在地下",

	-- Step 54: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "从{npc:2793}的洞穴向西南前往{area:880}：{npc:2696}站在断裂的桥段上，从北端跳下去找他。{quest:647}必须在15分钟内交给{area:271}的{npc:2705}：直接返回{area:320}，飞往{area:271}。",

	-- Step 56: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "{area:320}的飞行管理员",

	-- Step 57: Brewmeister Bilger
	-- {area:271} Southshore · {npc:2276} Magistrate Henry Maleb · {npc:2277} Loremaster Dibbs · {area:280} Strahnbrad
	["Off the flight, straight to the {area:271} inn. Then {npc:2276} and {npc:2277}, in the town hall, take the Syndicate camp's quests and send you north to {area:280}."] = "下了飞行坐骑，直奔{area:271}旅店。然后到镇厅找{npc:2276}和{npc:2277}，交还辛迪加营地的任务，他们会派你北上前往{area:280}。",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "{npc:2705}，在地下",
	-- {npc:2276} Magistrate Henry Maleb · {area:280} Strahnbrad
	["{npc:2276}: the signet rings are in {area:280}"] = "{npc:2276}：图章戒指在{area:280}",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}, at the end of this guide"] = "交给{zone:1455}的{npc:1356}，在本指南最后",

	-- Step 59: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings."] = "沿道路向北离开{area:271}进入山区。山地狮在山坡上游荡；{area:280}的辛迪加成员戴着图章戒指。",

	-- Step 60: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "{area:281}：沿途击杀以下目标",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "书籍位于{area:280}以西的城堡废墟内，由暗影大法师占据。\n注意：破碎岭好战者生命值低于一半时，会召唤15码内的盟友支援。\n破碎岭虐待者、破碎岭法师、破碎岭执行者和破碎岭好战者（36-39级）是精英；破碎岭食人魔和破碎岭蛮兵（34-35级）不是精英，也携带这些书籍：逐个拉怪，或组队。",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}：破碎岭食人魔",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase · {quest:540} Preserving Knowledge
	["{item:3659}: the {object:1760}, beside Muckrake (40, elite): get it with a group, or abandon {quest:540}; inside"] = "{item:3659}：{object:1760}，在玛克拉克（40级，精英）旁边：组队去拿，或放弃{quest:540}；在里面",

	-- Step 61: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:2417} walks from the arrow north-east through the ruins to about 40,47 and back: if he isn't at the arrow, follow his path."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:2417}是 40 级精英，多数职业到 42 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。\n{npc:2417}会从箭头处向东北穿过废墟，走到约 40,47 处再返回：如果他不在箭头处，请沿他的路线寻找。",

	-- Step 62: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "{area:280}：沿途击杀以下目标",
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps north of the village. Leave him be."] = "注意：辛迪加密探和刺客可能处于隐身状态。刺客还会让你中毒。\n注意：{npc:2306}（40级）每次只出现在一个地点：{area:280}旅店的地窖，或村庄北边的某个辛迪加帐篷营地。别去惹他。",

	-- Step 63: Crushridge ogres
	["Crushridge ogres"] = "破碎岭食人魔",
	-- {area:280} Strahnbrad
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Careful: Nagaz (40) stands far to the north-west by a worn wooden chest, with Syndicate guards: stay with the ogres.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "破碎岭食人魔占据着{area:280}以北的山丘。小心：纳加兹（40级）站在远处西北方的一个破旧木箱旁，身边有辛迪加卫兵：待在食人魔这边。\n破碎岭虐待者、破碎岭法师、破碎岭执行者和破碎岭好战者（36-39级）是精英；破碎岭食人魔和破碎岭蛮兵（34-35级）不是精英，也会掉落指骨：逐个拉怪，或组队。",

	-- Step 65: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "向西南前往{area:279}以西湖岸的肯瑞托营地，刚越过边界进入{zone:1421}：{npc:269127}站在那里。大法师安斯雷姆·鲁因维沃尔站在其东南的穹顶旁。",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "交给{area:35}的{npc:2542}：保留它",

	-- Step 66: Image of Archmage Modera
	-- {npc:269127} Image of Archmage Modera · {quest:92458} Heart of Disruption · {item:277507} Dalaran Sewer Key
	["For your City of Dalaran run, next: the {npc:269127} wants the arcane remnants in the city thinned out and a mote from the heart of the disruption. {quest:92458} brings the {item:277507}, which opens the grate."] = "为接下来的达拉然城之行做准备：{npc:269127}要你削减城中的奥术残余，并从扰动核心取得一颗微粒。{quest:92458}会给你{item:277507}，用来打开栅栏。",

	-- Step 67: City of Dalaran
	["City of Dalaran"] = "达拉然城",
	-- {quest:92457} Starving Arcane · {item:251961} Arcane Mote · {quest:92458} Heart of Disruption
	-- plural, as words: Seeking Remnants = {npc:247003} Seeking Remnant · Saturated Remnants = {npc:247001} Saturated Remnant
	["The City of Dalaran is a dungeon for a group of five at about level 28 to 33: at your level it goes quickly. Its way in is the sewer grate in the city's western wall, by the lake, 30 yards from Modera's camp.\nInside: the Seeking Remnants, Saturated Remnants and Mana Echoes are Modera's {quest:92457}; the {item:251961} for {quest:92458} drops inside too."] = "达拉然城是适合28-33级左右五人小队的地下城：以你的等级会打得很快。入口是城市西墙的下水道栅栏，在湖边，离茉德拉的营地30码。\n副本内：搜寻残余、饱和残余和法力回响是茉德拉的{quest:92457}的目标；{quest:92458}要的{item:251961}也在副本内掉落。",
	-- {quest:92457} Starving Arcane
	["{quest:92457}: the remnants and echoes, inside"] = "{quest:92457}：残余和回响，在副本内",
	-- {quest:92458} Heart of Disruption · {item:251961} Arcane Mote
	["{quest:92458}: the {item:251961}, inside"] = "{quest:92458}：{item:251961}，在里面",

	-- Step 68: Image of Archmage Modera
	["Back out of the grate to Modera's camp on the lake shore."] = "从栅栏出来，返回湖岸边茉德拉的营地。",

	-- Step 71: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "交给{zone:1453}的{npc:1440}：保留它",

	-- Step 72: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "{npc:2438}站在飞行管理员与旅店之间；如果没有{item:2321}，可向他身旁的{npc:2381}购买。",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "{item:2321}，向{npc:2381}购买",

	-- Step 74: Ironforge
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356}：交给{zone:1432}的{npc:1344}，接下来会去",

	-- Step 75: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "飞往{area:144}",

	-- Step 76: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "前往{area:144}",
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "从{zone:1455}出发，穿过{zone:1426}向东的隧道进入{zone:1432}，沿道路前往{area:144}。",

	-- Step 77: Thelsamar
	-- {zone:2548} Riverglades · {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass
	["Leave the {zone:2548} for about level 41: its Western Front has elite patrols. After Stranglethorn, the {zone:2548} guide takes you from {zone:1455} to {area:69}, then through {area:2417}."] = "大约41级再去{zone:2548}，那里的西部前线有精英巡逻。跑完荆棘谷后，按{zone:2548}指南从{zone:1455}前往{area:69}，再穿过{area:2417}。",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}：在地下",

	-- Step 78: Prospector Ironband
	["South-east along the loch to the dig site."] = "沿湖向东南前往挖掘场（铁环挖掘场）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:2434} lurks stealthed on the edge of {area:271}, and few players find him. If you spot him, kill him and read the contract he carries: {npc:2276} takes it. Don't wait for him: the rest of this step doesn't need him."] = "一名{npc:2434}隐身潜伏在{area:271}边缘，很少有玩家能找到他。如果发现他，杀死他并阅读他携带的合同：{npc:2276}会收下它。不要专门等他：这一步的其余部分不需要他。",
	-- ["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "一名{npc:2434}隐身潜伏在{area:271}边缘；杀死他并阅读他携带的合同。",
	-- ["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: About three stealthed Syndicate mobs are inside {npc:2320}'s house. {npc:2320} does not join when they are pulled, and a ranged attack through the doorway brings him out by himself."] = "注意：辛迪加间谍和刺客可能处于潜行状态，刺客还会施毒。\n注意：{npc:2320}的房屋内约有三名潜行辛迪加成员。拉出这些守卫时，{npc:2320}不会参战；清理后可从门外远程攻击，将他单独拉出。",
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "每把钥匙都在高地的一处石圈：碎片以东、{area:320}附近和西部。{object:2702}在{area:320}以西。",
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "三把钥匙分别位于高地上的三个禁锢法阵，位置在碎片区以东、{area:320}附近和高地西侧。{object:2702}位于{area:320}以西。\n注意：各法阵的中心石周围约有三只 39 级元素生物，未清理就点击石头，会一起攻击你：西侧为烈焰流放者，外侧为雷霆流放者，东侧为水浪流放者。",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals. {quest:1392} walks a long path through the ruins: if you meet him, kill him, his cudgel starts a quest for {npc:1776}. Don't wait for him."] = "沿道路向东前往{area:76}。{npc:256028}怪物掉落水晶。{quest:1392}会沿一条很长的路线穿过废墟游走：如果遇到他，就杀了他，他的木棒可以开始一个交给{npc:1776}的任务。不要专门等他。",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "沿道路向东前往{area:76}。{npc:256028}怪物掉落水晶；木棒诺博鲁在废墟中游走，会掉落他的木棒。",
	-- ["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "从{area:327}穿过南边的丘陵向东走：食人魔法师{npc:2793}占据着枯木巨魔山谷南端的洞穴。",
	-- ["East to the Witherbark trolls in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley. Every troll here can drop a tusk."] = "向东前往{area:314}以南山丘中的枯木巨魔处；枯木巫医在村子里，枯木暗影猎手守在山谷尽头。这里的每个巨魔都可能掉落獠牙。",
	-- ["Ebenezer Rustlocke"] = "伊贝尼瑟的尸体",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "护送教授到海湾北边的海滩，在他工作时保护他；纳迦会一波波来袭。",
	-- ["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "沿道路向东离开{area:287}，越过{area:1057}前往{area:320}。",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "沿道路向北离开{area:271}进入山区。山地狮在山坡上游荡；{area:280}的辛迪加成员戴着图章戒指，{npc:2306}在镇子北边的庄园里走动。",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings. {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village."] = "沿道路向北离开{area:271}进入山区。山地狮在山坡上游荡；{area:280}的辛迪加成员戴着图章戒指。{npc:2306}（40级）每次只出现在一个地点：{area:280}旅店的地窖，或村庄北边和西北边高地上的某个辛迪加帐篷营地。",
	-- ["Follow the road north to the draenei of the {area:657}."] = "沿道路向北前往{area:657}的德莱尼人处。",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "沿道路向南过桥，到达{zone:1437}一端的{area:205}，{npc:1075}在那里等候。",
	-- ["For characters of 35 to 37. {area:327}, where the naga and the professor's water elementals are 38-40, is a group stop: skip it if you are alone."] = "适合35到37级角色。{area:327}的纳迦和教授的水元素为38-40级，需要组队：单人就跳过。",
	-- ["For characters of 36 to 38, but {area:327} and the Alterac Syndicate quests are level 40: on purpose, for their experience. {npc:2768}'s two water elementals (40) are immune to frost, and {npc:2306} (40) waits among his Syndicate: pull them one at a time."] = "适合36-38级角色，但{area:327}和奥特兰克辛迪加的任务是40级：这是有意为之，为了它们的经验。{npc:2768}的两个水元素（40级）免疫冰霜，{npc:2306}（40级）在他的辛迪加手下之中等着：一次只拉一个。",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "从{area:42}沿道路向东穿过{zone:1430}进入{zone:1435}；卫兵比格斯守在刚进入的岔路口。{npc:217412}站在他北边不远处。",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "从{zone:1455}出发，穿过{zone:1426}向东的隧道进入{area:38}，沿道路前往{area:144}。",
	-- ["Gyll, {area:35}"] = "盖尔，{area:35}",
	-- ["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s {item:213565}."] = "干草象鼻虫在{quest:681}农场的北端爬行：用{npc:217412}的{item:213565}中的工具捕捉一只。",
	-- ["Head back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "向东北返回，经过{area:320}；{npc:2712}和{npc:2713}在{area:314}北侧山丘扎营。",
	-- ["Head back south from the eastern circle; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "从东边的石环向南返回；{npc:2712}和{npc:2713}在{area:314}北侧不远的山丘扎营。",
	-- ["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "向北经过{area:314}；碎片在{area:333}旁的山丘上闪闪发光。",
	-- ["Inside"] = "在里面",
	-- ["Off the flight, straight to the {area:271} inn."] = "落地后直接前往{area:271}的旅店。",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "向东北骑回，经过{area:320}；{npc:2712}和{npc:2713}在{area:314}以北的山丘扎营。",
	-- ["Shaman training"] = "萨满祭司训练",
	-- ["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "沿西海岸向南，前往地精的海湾；哨兵鲁鲁在海湾上方的岩石上放哨。",
	-- ["South from the {object:2691}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "从{object:2691}向南，经过{area:314}，前往山丘中的{area:317}：枯木巫医站在小屋之间，枯木暗影猎手守在山谷尽头。每个巨魔都可能掉落獠牙。",
	-- ["South from {area:318}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "从{area:318}向南，经过{area:314}，前往山丘中的{area:317}：枯木巫医站在小屋之间，枯木暗影猎手守在山谷尽头。每个巨魔都可能掉落獠牙。",
	-- ["South-east from Northfold to the Witherbark trolls in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley. Every troll here can drop a tusk."] = "从诺斯弗德农场向东南，前往{area:314}南边丘陵中的枯木巨魔处；巫医在村里，暗影猎手守着山谷深处。这里的所有巨魔都有可能掉落獠牙。",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "向西南前往{area:279}以西湖岸的肯瑞托营地，刚越过边界进入{area:130}：{npc:269127}站在那里。大法师安斯雷姆·鲁因维沃尔站在其东南的穹顶旁。",
	-- ["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "跟着{npc:2713}潜入{area:314}再回来；途中部落兽人会突袭你。",
	-- ["Subdue the succubus"] = "制服魅魔",
	-- ["Summon Succubus"] = "召唤魅魔",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "破碎岭食人魔占据着{area:280}以北的山丘。再往北，一个破旧的木箱里装着{item:3706}；{quest:537}的{npc:2320}就站在旁边。",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "破碎岭食人魔占据着{area:280}以北的山丘。再往北，一个破旧的木箱里装着{item:3706}；{quest:537}的{npc:2320}就站在旁边。\n破碎岭虐待者、破碎岭法师、破碎岭执行者和破碎岭好战者（36-39级）是精英；破碎岭食人魔和破碎岭蛮兵（34-35级）不是精英，也会掉落指骨：逐个拉怪，或组队。",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "枯须狗头人在{area:321}（部落）以东的峡谷里挖掘；从北边绕过镇子。它们会掉落微粒和克拉兹克要的矿石。",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "枯须狗头人在部落城镇{area:321}以东峡谷采掘，从城镇北侧绕过。它们会掉落微粒和克拉兹克所需的矿石。\n注意：各种狗头人低血量时都会逃跑求援：普通狗头人于 30%，勘测员和掘地工于 15% 生命值逃跑，可能引来更多敌人。",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "辛迪加占据着{area:320}西北的农场。一只{npc:217589}在农场里爬来爬去：用{npc:217412}的昆虫学入门套装捕捉一只，然后勾掉此项。",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "辛迪加占据{area:320}西北侧农场。{npc:217589}在农场内爬行，用{npc:217412}的昆虫学入门工具包捕捉一只，再勾选完成。\n注意：辛迪加路霸为 30–31 级，非战斗状态下能施放潜行，常常很难发现。",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "枯木巨魔住在{area:314}以南的山丘；枯木巫医在村子里，枯木暗影猎手守在山谷尽头。",
	-- ["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "被遗忘者信使带着两名卫兵在{area:314}以西的路上行走；把他们引离道路。",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "书卷在{area:280}以西的废弃城堡（奥特兰克废墟）中；暗影大法师占据着废墟。",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health."] = "书籍位于{area:280}以西的城堡废墟内，由暗影大法师占据。\n注意：破碎岭好战者生命值低于一半时，会召唤 15 码内的盟友支援。",
	-- ["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "两艘沉船在海湾以西的海湾里。海图和航海日志在船里；宝石在周围的海底。整个海湾都有刺脊纳迦游动。",
	-- ["The wrecked caravan lies off the road near Biggs."] = "被毁的货车在比格斯附近的路边。",
	-- ["The wrecks"] = "沉船",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:2417}是 40 级精英，多数职业到 42 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "走回桥上：伊贝尼瑟的尸体在桥的阿拉希一端下方。",
	-- ["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "沿海岸向西前往地精的海湾（法迪尔海湾）；哨兵鲁鲁在上方的岩石上放哨。",
	-- ["West along the road to {area:320}, on the way to the {object:2689}."] = "沿道路向西前往{area:320}，再继续去{object:2689}。",
	-- ["{area:35} flight master"] = "{area:35}的飞行管理员",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{npc:2438}的披风需要{item:2321}，如果没有就从{npc:2381}处购买",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659}：{object:1760}",
	-- ["{npc:1356}, {object:32356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356}，在{object:32356}：交给{zone:1432}的{npc:1344}，接下来会去",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}：捕捉它，用于{quest:93176}",
	-- ["{npc:2276}, inside, if 30-40/01 didn't take it: the Syndicate camp is on the way to Arathi"] = "{npc:2276}，在室内，如果30-40/01没有接：辛迪加营地就在去阿拉希的路上",
	-- ["{npc:2277}: the parchment"] = "{npc:2277}：羊皮纸",
	-- ["{npc:2438}, if you took his cloak quest"] = "{npc:2438}，如果你接了他的披风任务",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}，在达拉然城中",
	-- ["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "{npc:2700}：交01-hillsbrad-foothills中{npc:1075}的求援任务",
	-- ["{npc:2789}: {npc:2793}'s cave comes after {area:327}"] = "{npc:2789}：{npc:2793}的洞穴安排在{area:327}之后",
	-- ["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "食人魔法师{npc:2793}占据着枯木巨魔山谷南端的洞穴。",
	-- ["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him."] = "{npc:5476}守在沼泽西侧的道路交汇处，{npc:217412}就在他北侧不远处。",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453}没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习。{object:32372}的{npc:1573}也能飞往{area:271}。",
}
