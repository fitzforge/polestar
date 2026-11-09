-- Chinese (simplified) (zhCN): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飞行管理员",

	-- Step 2: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "从{area:2408}飞往{area:1638}，到{area:1639}找{npc:3033}训练；再从那里飞往{zone:1454}。",

	-- Step 3: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "返回{area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飞行管理员",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "{npc:5640}站在城市西侧的{object:172961}。",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "{zone:1454}训练师",
	["Train while you are in the city."] = "趁在城里先训练。",

	-- Step 6: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol
	["Zeppelin to {object:3202}"] = "乘飞艇前往{object:3202}",

	-- Step 7: Grom'gol
	["The zeppelin lands at the tower on the west side of the camp."] = "飞艇降落在营地西侧的塔上。",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}：交给阿拉希高地，路线后面会去",

	-- Step 8: Nesingwary's camp
	["Nesingwary's camp"] = "奈辛瓦里的营地",
	-- {object:3202} Grom'gol · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} takes them on your next Stranglethorn visit."] = "",

	-- Step 9: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "{area:100}：沿途遇到就击杀",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers east of it. Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it. Careful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Back to the road and follow it south all the way to {area:35} at the southern tip of the vale, and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the inn's upper deck."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}：在屋内",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, on the bottom floor"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}：在楼上",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}：在楼上",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飞行管理员",

	-- Step 12: Grom'gol
	-- {npc:2497} Nimboya · {object:3202} Grom'gol
	["{npc:2497} waits in {object:3202}, near the zeppelin tower."] = "{npc:2497} 在飞艇塔附近的 {object:3202} 中等待。",

	-- Step 13: The camp by the river
	["The camp by the river"] = "河边的营地",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["North up the road again. Nesingwary's camp is the one {npc:773} wants investigated: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "",

	-- Step 15: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}：沿途击杀以下目标",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp."] = "荆棘谷猛虎（32级）在营地周围及南边的山丘上游荡，黑豹（32级）在营地西边和西南边的空地上游荡。营地东南方、{area:37}旁的营地中，风险投资公司地质学家带着打磨过的水晶工作。",

	-- Step 16: Nesingwary's camp
	-- {object:3202} Grom'gol
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "深喉猎豹要很久以后才会遇到，在{object:3202}附近",

	-- Step 17: Elder Stranglethorn Tigers
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["Elder Stranglethorn Tigers"] = "",
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp. Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "",

	-- Step 18: Nesingwary's camp
	["Back north to the camp."] = "向北回到营地。",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301}：沿途击杀以下目标",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "向西经过营地，晶背蜥蜴（34-35 级）就在岩石上；再往前村子里的每只血顶巨魔都可能掉落耳朵。\n{npc:729} 是一只 37 级老虎，在营地西南的山顶游荡。\n小心：迅猛龙巢里有幼龙，攻击成年迅猛龙时，它们也会加入战斗。",

	-- Step 21: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "鞭尾迅猛龙",
	-- {object:3202} Grom'gol · {npc:2464} Commander Aggro'gosh
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}."] = "",

	-- Step 22: Grom'gol
	-- {npc:2464} Commander Aggro'gosh · {object:3202} Grom'gol · {npc:2465} Far Seer Mok'thardin
	["{npc:2464} stands in the middle of {object:3202}, {npc:2465} beside the flight master."] = "",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: the Shadowmaw claws and the tigress fang come at the end of this guide"] = "",

	-- Step 23: Level 35
	["Level 35"] = "等级35",
	-- {area:35} Booty Bay · {object:3202} Grom'gol · {area:796} Scarlet Monastery
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{area:35}'s and {object:3202}'s next quests are 35-38. Still below 35 after Aggro'gosh's hand-in? The Lashtail Raptors (35) hunt the jungle just north of {object:3202}: kill them until level 35. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "",
	-- {npc:686} Lashtail Raptor
	["grind on {npc:686}"] = "刷{npc:686}升级",

	-- Step 24: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飞往{area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "{object:3202} 的飞行管理员。",

	-- Step 25: Booty Bay
	-- {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:737} Kebok · {npc:773} Krazek
	["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:737} and {npc:773} on its top floor beside the flight master."] = "",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}：在屋内",

	-- Step 27: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "{area:104}位于格罗姆高营地西北的近海水下。{item:4094}躺在沉没废墟旁的海底；注意呼吸和鱼人。",
	["Underwater"] = "在水下",

	-- Step 28: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "{area:102}：沿途遇到就击杀",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "海边村庄中的血顶猎头者（36—37级）带着皱缩的头颅。\n血顶巨魔占据着礁石北面沿海的废墟及更远处的村庄；每一只都有可能掉落 {item:3915}。继续拾取 {quest:338} 的书页。",

	-- Step 30: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "",

	-- Step 31: Green Hills pages
	["Green Hills pages"] = "荆棘谷的青山书页",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters on your next Stranglethorn visit, at about 40."] = "",

	-- Step 32: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "莫什奥格营地",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time."] = "",

	-- Step 33: Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}."] = "返回{object:3202}。",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2465}：留到forever/horde/40-50/01-stranglethorn-vale指南再做",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2497}：留到forever/horde/40-50/01-stranglethorn-vale指南再做",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "下一份指南会从营地西侧的塔楼乘飞艇前往{zone:1454}。",

	-- Step 34: Level 36
	["Level 36"] = "等级 36",
	-- {object:3202} Grom'gol · {area:796} Scarlet Monastery · {area:1316} Razorfen Downs
	-- plural, as words: Mosh'Ogg Brutes = {npc:1142} Mosh'Ogg Brute
	["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Mosh'Ogg Brutes and Witch Doctors camp in the hills just east of the camp: kill them until level 36, pulling one at a time, then walk back to the zeppelin tower. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "击杀{npc:1142}刷经验",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dustwallow's quests are 35-38. Below 36? Keep killing the Mosh'Ogg Brutes and Witch Doctors here until level 36; pull one at a time. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "尘泥沼泽的任务适合35-38级。还没到36级？在这里继续击杀莫什奥格蛮兵和莫什奥格巫医，直到36级；每次只引一只。也可以组队刷{area:796}地下城的武器库或{area:1316}地下城。",
	-- ["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "食人魔东面的深喉猎豹（37-38级）会隐蔽潜行，直到攻击时才现身；荆棘谷雌虎也在同一区域游荡，偶尔掉落完美的牙齿。钳嘴鳄鱼分布在丛林西面的河边；保留它们的皮交给{npc:2495}。\n小心：深喉猎豹（37-38级）和老年深喉猎豹（42-43级）会在脱战时使用潜行，靠近前都看不见。",
	-- ["Elder tigers and Lashtail raptors"] = "老年猛虎和鞭尾迅猛龙",
	-- ["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "沿道路向北离开{object:3202}；奈辛瓦里的狩猎营地在河东北边的山上。从现在起，留着拾取到的每一页{quest:338}：{npc:716}之后会要。",
	-- ["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "沿道路向南前往山谷南端的{area:35}，从悬崖上的隧道进入。别离开道路：路旁丛林里的怪物比你高得多。部落飞行管理员{npc:2858}在上层甲板等候。",
	-- ["Head north to {area:37}, south-east of Nesingwary's camp: the Venture Co. Geologists (34-36) work the camps by the lake and carry the Tumbled Crystals."] = "向北到奈辛瓦里营地东南方的{area:37}：风险投资公司地质学家（34-36级）在湖边的营地工作，带着打磨过的水晶。",
	-- ["Head south down the coast to {object:3202} and fly to {area:35}."] = "沿海岸向南前往{object:3202}，再飞往{area:35}。",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "{item:2755}的每一页从血顶巨魔和劈颅巨魔身上的掉率约为1%；留着拾取到的每一页，其余的去拍卖行找。{npc:716}会在本指南稍后收取各章节。",
	-- ["Shadowmaw panthers"] = "深喉猎豹",
	-- ["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "老年荆棘谷猛虎（34—35级）在营地西南方的山丘游荡；鞭尾迅猛龙（35—36级）在更南边、朝 {object:3202} 的方向猎食。\n注意：老虎活动区域靠近巨魔营地，引怪不慎会让巨魔加入战斗。",
	-- ["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "鞭尾迅猛龙（35-36级）在{object:3202}东北不远的丛林里捕猎。",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "莫什奥格食人魔在{object:3202}正东的山丘上扎营。杀死一个莫什奥格蛮兵和一个莫什奥格巫医（36-37级）；一次引一个。",
	-- ["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "深喉猎豹（37-38级）在莫什奥格山丘东边和东北方通往湖泊的丛林里潜行；它们会从潜行中发动攻击。沿途拾取你找到的每一页荆棘谷的青山。",
	-- ["Upstairs"] = "在楼上",
	-- ["Venture Co. camp"] = "风险投资公司营地",
	-- ["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "荆棘谷猛虎幼崽在营地西侧徘徊，猎豹幼崽则在营地南侧和东侧。\n向西经过营地。荆棘谷迅猛龙（33-34 级）在空地上狩猎，血顶巨魔占据着海岸废墟：任何血顶巨魔都可能掉落獠牙。它们有极低概率掉落 {item:4614}：掉落后记得阅读。\n小心：巨魔营地有很多巡逻怪，因此其他巨魔经常会加入战斗。",
	-- ["{area:35}'s and {object:3202}'s next quests are 35-38. Below 35? The Lashtail Raptors (35) hunt the slopes south of the camp, on your way back to {object:3202}: kill them until level 35. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "{area:35}和{object:3202}接下来的任务适合35-38级。还没到35级？返回{object:3202}途中，营地南边的山坡上有鞭尾迅猛龙（35级）觅食：击杀它们，直到35级。也可以组队刷{area:796}地下城的图书馆或武器库。",
	-- ["{npc:2465}, beside the flight master: the Shadowmaw and tigress parts come after the trolls"] = "飞行管理员旁的{npc:2465}：暗喉和雌虎的部分在巨魔任务之后再做",
	-- ["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "{npc:773}失踪猎人的营地就是奈辛瓦里的营地：在帐篷间走一圈，调查就会完成。淡水鳄趴在营地下方的河边。",
}
