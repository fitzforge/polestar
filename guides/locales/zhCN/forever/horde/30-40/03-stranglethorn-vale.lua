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
	-- {area:2408} Shadowprey Village · {area:976} Gadgetzan · {area:439} Shimmering Flats · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} (or from {area:976}, after the {area:439}' south) to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "",

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

	-- Step 6: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飞往{area:392}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["{area:35} first: the goblins' boat sails there from {area:392}, and every {area:35} quest is for the north of the vale, which you then walk up into."] = "先去{area:35}：地精的船从{area:392}开往那里，而且{area:35}的任务全都在荆棘谷北部，之后你会一路向北走过去。",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飞行管理员",

	-- Step 7: Ratchet
	-- {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["{npc:3391} waits upstairs in the house by the flight master; {quest:1111} stands on the docks, beside the boat."] = "{npc:3391}在飞行管理员旁边那栋房子的楼上；{quest:1111}站在码头上，船的旁边。",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}：在楼上",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631} in {area:35}, where the boat goes"] = "{npc:3391}：交给{area:35}的{npc:4631}，船就开往那里",
	-- {quest:1111} Wharfmaster Dizzywig
	["{quest:1111}, on the docks"] = "{quest:1111}：在码头上",
	-- {area:439} Shimmering Flats
	["Dizzywig's parts go back to Kravel in the {area:439}, off the route: leave them."] = "迪兹维格的零件要送回{area:439}的克拉维尔，不在路线上：别接。",

	-- Step 8: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "乘船前往{area:35}",

	-- Step 9: Booty Bay
	-- {npc:4631} Wharfmaster Lozgil · {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:2858} Gringer
	["{npc:4631} stands on the pier where the boat docks. {npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs, {npc:2858} the flight master on the upper deck."] = "{npc:4631}站在船靠岸的码头上。{npc:2495}的商店在旅店东边的建筑里；{npc:2498}在旅店底层，{npc:2496}、{npc:737}和{npc:773}在楼上，飞行管理员{npc:2858}在上层甲板。",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the pier"] = "{npc:4631}：在码头上",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}：在屋内",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside, on the bottom floor"] = "{npc:2498}，在建筑内的底层",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs"] = "{npc:2496}：在楼上",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}：在楼上",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}：在楼上",

	-- Step 10: Grom'gol
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	["Leave {area:35} through the tunnel and follow the road north to {object:3202}, the orc camp on the west side of the vale. Stay on the road: the jungle beside it is above your level."] = "穿过隧道离开{area:35}，沿道路向北前往荆棘谷西侧的兽人营地{object:3202}。别离开道路：路旁丛林里的怪物比你等级高。",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}：交给阿拉希高地，路线后面会去",

	-- Step 11: Nesingwary's camp
	["Nesingwary's camp"] = "奈辛瓦里的营地",
	-- {object:3202} Grom'gol · {npc:773} Krazek · {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. {npc:773} wants it investigated: walk among its tents. From here on, keep every page of The {item:2755} you loot: {npc:716} takes them on your next Stranglethorn visit."] = "沿道路向北离开{object:3202}；奈辛瓦里的狩猎营地在河东北边的山上。{npc:773}要你调查那里：在帐篷间走一圈。从现在起，留着拾取到的每一页{item:2755}：下次来荆棘谷时{npc:716}会收取。",

	-- Step 12: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "{area:100}：沿途遇到就击杀",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk · Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["River Crocolisks lie along the river below the camp. Young Stranglethorn Tigers prowl west of the camp, Young Panthers east of it. Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it. Careful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "淡水鳄趴在营地下方的河边。荆棘谷猛虎幼崽在营地西侧徘徊，猎豹幼崽则在营地东侧。向西经过营地。荆棘谷迅猛龙（33-34级）在空地上狩猎，血顶巨魔占据着海岸废墟：任何血顶巨魔都可能掉落獠牙。它们有极低概率掉落{item:4614}：掉落后记得阅读。小心：巨魔营地有很多巡逻怪，因此其他巨魔经常会加入战斗。",

	-- Step 14: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}：沿途击杀以下目标",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Venture Co. Agents = {npc:260429} Venture Co. Agent
	-- was: ["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists (34-36), who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: Venture Co. Agents (39) stand among the geologists in the western camps by the Venture Co. house: work the eastern camps, away from them."] = "荆棘谷猛虎（32级）在营地周围及南边的山丘上游荡，黑豹（32级）在营地西边和西南边的空地上游荡。风险投资公司地质学家（34-36级）带着打磨过的水晶，在营地东南方{area:37}旁的营地中工作。小心：西边靠近风险投资公司房子的营地里，地质学家之间有风险投资公司特工（39级）：去东边的营地，远离他们。"
	["Stranglethorn Tigers (32) roam the hills west of the camp and east of it toward the lake: the arrow takes the eastern ones, on your way to the geologists. Panthers (32) roam the clearings west and south-west of the camp. The Venture Co. Geologists (34-36), who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: Venture Co. Agents (39) stand among the geologists in the western camps by the Venture Co. house: work the eastern camps, away from them."] = "",
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["Tumbled Crystals, from the geologists of the eastern camps"] = "打磨过的水晶，击杀东边营地的地质学家获取",

	-- Step 15: Nesingwary's camp
	-- {object:3202} Grom'gol
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "深喉猎豹要很久以后才会遇到，在{object:3202}附近",

	-- Step 16: Elder Stranglethorn Tigers
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["Elder Stranglethorn Tigers"] = "老年荆棘谷猛虎",
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp. Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "老年荆棘谷猛虎（34-35级）在营地西南侧的山丘上游荡。注意：猛虎区域附近有巨魔营地，引怪时稍不留神就会引来巨魔。",

	-- Step 17: Nesingwary's camp
	["Back north to the camp."] = "向北回到营地。",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}: {npc:729} (37) waits for your next Nesingwary stop, at about 40 in forever/horde/40-50/01-stranglethorn-vale"] = "{npc:717}：{npc:729}（37级）留到下次来奈辛瓦里营地时再做，约40级，见forever/horde/40-50/01-stranglethorn-vale",

	-- Step 18: Thoroughly Scavenged Supplies
	-- {npc:268992} Zimmix Sputterspark
	["The supplies lie beside the path to the coast. Look for the stolen shipments in the southern ruins near {npc:268992}."] = "",

	-- Step 19: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301}：沿途击杀以下目标",
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["Continue west to the Crystal Spine Basilisks (34-35) on the rocks. The Bloodscalp trolls in the village beyond drop ears.\nLeave {npc:729} on the hilltop. {npc:717}'s hunt for him comes on the next Stranglethorn visit.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "",

	-- Step 20: Zimmix Sputterspark
	-- {npc:268992} Zimmix Sputterspark · {area:102} Ruins of Zul'Kunda · {item:277957} Primitive Key · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Scouts = {npc:588} Bloodscalp Scout · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["{npc:268992} is held at the east edge of the {area:102}; the Stolen Shipments lie among the ruins around him. The Bloodscalp Scouts, Hunters and Mystics (34-35) there carry his {item:277957}. Then lead him out of the ruins: {npc:4631} in {area:35} takes the news and the shipments.\nCareful: Bloodscalp Berserkers and Headhunters (36-37) and Witch Doctors (37, casters) hold the ruins north and west of {npc:268992}, close to the northern shipments (around 24.9,9.6): pick the shipments in the southern ruins by {npc:268992} first, and pull one at a time if you go north."] = "{npc:268992}被关在{area:102}东边缘；被盗的货物散落在他周围的废墟中。那里的血顶斥候、猎手和秘法师（34-35级）身上带着他的{item:277957}。然后护送他走出废墟：{area:35}的{npc:4631}会接收消息和货物。\n小心：{npc:268992}北边和西边的废墟里有血顶狂战士、猎头者（36-37级）和巫医（37级，施法者），离北边的货物（约24.9,9.6）很近：先拾取{npc:268992}附近南边废墟的货物，如果去北边，一次引一只。",
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["Stolen Shipments, in the ruins"] = "被盗的货物，在废墟中",
	-- {item:277957} Primitive Key
	-- plural, as words: Bloodscalp Scouts = {npc:588} Bloodscalp Scout
	["{item:277957}, from the Bloodscalp Scouts, Hunters and Mystics"] = "{item:277957}，击杀血顶斥候、猎手和秘法师获取",
	-- {npc:268992} Zimmix Sputterspark
	["Escort {npc:268992} out of the ruins and keep him alive: Lozgil takes the news once he is safe."] = "护送{npc:268992}走出废墟并保证他存活：他安全后，罗兹基尔会接收消息。",

	-- Step 21: Nesingwary's camp
	-- {npc:729} Sin'Dall
	["Keep {npc:729} for the next Stranglethorn visit."] = "",

	-- Step 22: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "鞭尾迅猛龙",
	-- {object:3202} Grom'gol · {npc:2464} Commander Aggro'gosh
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor · Carnivorous Weeds = {npc:269175} Carnivorous Weed
	["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}. Careful: the 36s can be two over you: pull them one at a time. Carnivorous Weeds (36-38) are rooted in the jungle south of the raptors: walk around them."] = "向南返回{object:3202}途中，鞭尾迅猛龙（35-36级）在营地与{object:3202}之间的丛林里出没：它们同时计入赫米特和{npc:2464}的任务进度。小心：36级的可能比你高两级：一次引一只。食肉杂草（36-38级）扎根在迅猛龙南边的丛林里：绕开它们。",

	-- Step 23: Grom'gol
	-- {npc:2464} Commander Aggro'gosh · {object:3202} Grom'gol · {npc:2497} Nimboya · {npc:2465} Far Seer Mok'thardin
	["{npc:2464} stands in the middle of {object:3202}, {npc:2497} near the zeppelin tower, {npc:2465} beside the flight master."] = "{npc:2464}站在{object:3202}中央，{npc:2497}在飞艇塔附近，{npc:2465}在飞行管理员旁边。",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: the Shadowmaw claws and the tigress fang come at the end of this guide"] = "{npc:2465}：深喉猎豹的爪子和雌虎的牙齿到本指南末尾再收集",

	-- Step 24: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飞往{area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "{object:3202} 的飞行管理员。",

	-- Step 25: Booty Bay
	-- {npc:2495} Drizzlik · {npc:2498} Crank Fizzlebub · {npc:2496} Baron Revilgaz · {npc:737} Kebok · {npc:773} Krazek · {npc:4631} Wharfmaster Lozgil
	["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master. {npc:4631} stands on the pier."] = "{npc:2495}的商店在旅店东边的建筑里；{npc:2498}在旅店底层，{npc:2496}、{npc:737}和{npc:773}在楼上飞行管理员旁边。{npc:4631}站在码头上。",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}：在屋内",
	-- {npc:4631} Wharfmaster Lozgil
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment
	["{npc:4631}, on the pier: the Stolen Shipments"] = "{npc:4631}，在码头上：被盗的货物",
	-- {npc:4631} Wharfmaster Lozgil · {npc:268992} Zimmix Sputterspark
	["{npc:4631}: {npc:268992} is safe"] = "{npc:4631}：{npc:268992}平安无事",

	-- Step 26: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飞往{object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飞行管理员",

	-- Step 27: Level 35
	["Level 35"] = "等级35",
	-- {quest:629} The Vile Reef · {area:35} Booty Bay · {object:3202} Grom'gol
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter · Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["{quest:629}'s and Zul'Kunda's quests are next, with Bloodscalp Headhunters of 36-37. Still below 35 after {area:35}'s hand-ins? The Elder Stranglethorn Tigers (34-35) roam the hills north of {object:3202}, below Nesingwary's camp: kill them until level 35. The Lashtail Raptors (35-36) beside them are a level higher."] = "接下来是{quest:629}和祖昆达的任务，那里的血顶猎头者为36-37级。交还{area:35}的任务后还不到35级？老年荆棘谷猛虎（34-35级）在{object:3202}北面的山丘上游荡，就在奈辛瓦里营地下方：杀到35级为止。旁边的鞭尾迅猛龙（35-36级）要高一级。",
	-- {npc:1085} Elder Stranglethorn Tiger
	["grind on {npc:1085}"] = "刷{npc:1085}升级",

	-- Step 28: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "{area:104}位于格罗姆高营地西北的近海水下。{item:4094}躺在沉没废墟旁的海底；注意呼吸和鱼人。",
	["Underwater"] = "在水下",

	-- Step 29: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "{area:102}：沿途遇到就击杀",
	-- {item:3915} Bloody Bone Necklace · {item:2755} Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads. Careful: the 37s can be two over you: pull them one at a time from the village's edge, never into the middle with the Witch Doctors.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of The {item:2755}."] = "海边村庄中的血顶猎头者（36-37级）带着皱缩的头颅。小心：37级的可能比你高两级：从村子边缘一次引一个，千万别冲进有巫医的村子中央。\n血顶巨魔占据着礁石北面沿海的废墟及更远处的村庄；每一只都有可能掉落{item:3915}。继续拾取{item:2755}的书页。",

	-- Step 31: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them; the 38s can be two over you: pull them one at a time and leave the Elders alone."] = "在莫什奥格山丘东侧，深喉猎豹（37-38级）在通往湖泊的丛林中潜行；荆棘谷雌虎也在同一区域游荡，偶尔掉落完美的牙齿。钳嘴鳄鱼分布在丛林正西侧的河边，保留它们的皮交给{npc:2495}。注意：深喉猎豹（37-38级）和老年深喉猎豹（42-43级）会在非战斗状态下使用潜行，靠近后才会现身；38级的可能比你高两级：一次引一个，别碰老年深喉猎豹。",

	-- Step 32: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "莫什奥格营地",
	-- {object:3202} Grom'gol
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time. Careful: the 37s can be two over you: take them from the camp's western edge, never two together."] = "回程途中，莫什奥格食人魔的营地位于{object:3202}正东的山丘上。击杀10名莫什奥格蛮兵和5名莫什奥格巫医（36-37级），一次引一个。注意：37级的可能比你高两级：从营地西缘下手，绝不要同时打两个。",

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
	-- {object:3202} Grom'gol
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Snapjaw Crocolisks (35-36) line the river just east of the camp, below the Mosh'Ogg hills: kill them until level 36, then walk back to the zeppelin tower. Leave the Mosh'Ogg ogres (36-37) above them alone."] = "尘泥沼泽的任务为35-38级。交还{object:3202}的任务后还不到36级？钳嘴鳄鱼（35-36级）分布在营地正东、莫什奥格山丘下方的河边：杀到36级，然后走回飞艇塔。别碰上方的莫什奥格食人魔（36-37级）。",
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "钳嘴鳄鱼",
	-- {npc:1152} Snapjaw Crocolisk
	["grind on {npc:1152}"] = "刷{npc:1152}升级",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dustwallow's quests are 35-38. Below 36? Keep killing the Mosh'Ogg Brutes and Witch Doctors here until level 36; pull one at a time. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "尘泥沼泽的任务适合35-38级。还没到36级？在这里继续击杀莫什奥格蛮兵和莫什奥格巫医，直到36级；每次只引一只。也可以组队刷{area:796}地下城的武器库或{area:1316}地下城。",
	-- ["Dustwallow's quests are 35-38. Still below 36 after {object:3202}'s hand-ins? The Mosh'Ogg Brutes and Witch Doctors camp in the hills just east of the camp: kill them until level 36, pulling one at a time, then walk back to the zeppelin tower."] = "尘泥沼泽的任务适合35-38级。交还{object:3202}的任务后仍未到36级，就前往营地正东侧山丘上的食人魔营地，击杀莫什奥格蛮兵和莫什奥格巫医，直到36级。每次只引一只，然后步行返回飞艇塔。",
	-- ["East of the Mosh'Ogg hills, Shadowmaw Panthers (37-38) stalk the jungle towards the lake; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}. Careful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "在莫什奥格山丘东侧，深喉猎豹（37-38级）在通往湖泊的丛林中潜行；荆棘谷雌虎也在同一区域游荡，偶尔掉落雌虎的牙齿。钳嘴鳄鱼分布在丛林正西侧的河边，保留它们的皮交给{npc:2495}。注意：深喉猎豹（37-38级）和老年深喉猎豹（42-43级）会在非战斗状态下使用潜行，靠近后才会现身。",
	-- ["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "食人魔东面的深喉猎豹（37-38级）会隐蔽潜行，直到攻击时才现身；荆棘谷雌虎也在同一区域游荡，偶尔掉落完美的牙齿。钳嘴鳄鱼分布在丛林西面的河边；保留它们的皮交给{npc:2495}。\n小心：深喉猎豹（37-38级）和老年深喉猎豹（42-43级）会在脱战时使用潜行，靠近前都看不见。",
	-- ["Elder tigers and Lashtail raptors"] = "老年猛虎和鞭尾迅猛龙",
	-- ["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "从{area:2408}飞往{area:1638}，到{area:1639}找{npc:3033}训练；再从那里飞往{zone:1454}。",
	-- ["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "沿道路向北离开{object:3202}；奈辛瓦里的狩猎营地在河东北边的山上。从现在起，留着拾取到的每一页{quest:338}：{npc:716}之后会要。",
	-- ["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "沿道路向南前往山谷南端的{area:35}，从悬崖上的隧道进入。别离开道路：路旁丛林里的怪物比你高得多。部落飞行管理员{npc:2858}在上层甲板等候。",
	-- ["Green Hills pages"] = "荆棘谷的青山书页",
	-- ["Head north to {area:37}, south-east of Nesingwary's camp: the Venture Co. Geologists (34-36) work the camps by the lake and carry the Tumbled Crystals."] = "向北到奈辛瓦里营地东南方的{area:37}：风险投资公司地质学家（34-36级）在湖边的营地工作，带着打磨过的水晶。",
	-- ["Head south down the coast to {object:3202} and fly to {area:35}."] = "沿海岸向南前往{object:3202}，再飞往{area:35}。",
	-- ["On the walk west from Nesingwary's camp, a pile of {object:661516} lies by the path: it starts {quest:97328}, whose Stolen Shipments lie in the {area:102} on the coast ahead."] = "从奈辛瓦里营地向西走时，路边有一堆被搜刮一空的补给：它会开始{quest:97328}，任务所需的被盗的货物就在前方海岸的{area:102}。",
	-- ["On your way back south to {object:3202}, the Lashtail Raptors (35-36) hunt the jungle between the camp and {object:3202}: they count for Hemet and for {npc:2464}."] = "向南返回{object:3202}途中，鞭尾迅猛龙（35-36级）在营地与{object:3202}之间的丛林里出没：它们同时计入赫米特·奈辛瓦里和{npc:2464}的任务进度。",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "{item:2755}的每一页从血顶巨魔和劈颅巨魔身上的掉率约为1%；留着拾取到的每一页，其余的去拍卖行找。{npc:716}会在本指南稍后收取各章节。",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters on your next Stranglethorn visit, at about 40."] = "血顶巨魔和劈颅巨魔掉落{item:2755}各书页的几率约为1%；留好拾取到的每一页，其余的去拍卖行找。下次约40级返回荆棘谷时，{npc:716}会收取各章节。",
	-- ["Shadowmaw panthers"] = "深喉猎豹",
	-- ["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists (34-36), who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: Venture Co. Agents (39) stand among the geologists in the western camps by the Venture Co. house: work the eastern camps, away from them."] = "荆棘谷猛虎（32级）在营地周围及南边的山丘上游荡，黑豹（32级）在营地西边和西南边的空地上游荡。风险投资公司地质学家（34-36级）带着打磨过的水晶，在营地东南方{area:37}旁的营地中工作。小心：西边靠近风险投资公司房子的营地里，地质学家之间有风险投资公司特工（39级）：去东边的营地，远离他们。",
	-- ["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp. Careful: their camps are crowded, with Venture Co. Agents (39) among the geologists (36-38): pull from the camps' edges, one at a time."] = "荆棘谷猛虎（32级）在营地周围及南边的山丘上游荡，黑豹（32级）在营地西边和西南边的空地上游荡。营地东南方、{area:37}旁的营地中，风险投资公司地质学家带着打磨过的水晶工作。小心：他们的营地很拥挤，地质学家（36-38级）之间还有风险投资公司特工（39级）：从营地边缘一次引一只。",
	-- ["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of The {item:2755}."] = "海边村庄中的血顶猎头者（36-37级）带着皱缩的头颅。\n血顶巨魔占据着礁石北面沿海的废墟及更远处的村庄；每一只都有可能掉落 {item:3915}。继续拾取 {item:2755} 的书页。",
	-- ["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "老年荆棘谷猛虎（34—35级）在营地西南方的山丘游荡；鞭尾迅猛龙（35—36级）在更南边、朝 {object:3202} 的方向猎食。\n注意：老虎活动区域靠近巨魔营地，引怪不慎会让巨魔加入战斗。",
	-- ["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "鞭尾迅猛龙（35-36级）在{object:3202}东北不远的丛林里捕猎。",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}, on your way back. Kill 10 Brutes and 5 Witch Doctors (36-37); pull them one at a time."] = "回程途中，莫什奥格食人魔的营地位于{object:3202}正东的山丘上。击杀10名莫什奥格蛮兵和5名莫什奥格巫医（36-37级），一次引一个。",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "莫什奥格食人魔在{object:3202}正东的山丘上扎营。杀死一个莫什奥格蛮兵和一个莫什奥格巫医（36-37级）；一次引一个。",
	-- ["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "深喉猎豹（37-38级）在莫什奥格山丘东边和东北方通往湖泊的丛林里潜行；它们会从潜行中发动攻击。沿途拾取你找到的每一页荆棘谷的青山。",
	-- ["The camp by the river"] = "河边的营地",
	-- ["The zeppelin lands at the tower on the west side of the camp."] = "飞艇降落在营地西侧的塔上。",
	-- ["Upstairs"] = "在楼上",
	-- ["Venture Co. camp"] = "风险投资公司营地",
	-- ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\nLeave {npc:729}, the level 37 tiger on the hilltop south-west of the camp, for now: he is two over you here, and the 40-50 Stranglethorn guide comes back to him.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "向西经过营地，晶背蜥蜴（34-35级）就在岩石上；再往前村子里的每只血顶巨魔都可能掉落耳朵。\n营地西南山顶上的37级老虎{npc:729}先别管：他比你高两级，40-50级荆棘谷指南会再回来找他。\n小心：迅猛龙巢里有幼龙，攻击成年迅猛龙时，它们也会加入战斗。",
	-- ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "向西经过营地，晶背蜥蜴（34-35 级）就在岩石上；再往前村子里的每只血顶巨魔都可能掉落耳朵。\n{npc:729} 是一只 37 级老虎，在营地西南的山顶游荡。\n小心：迅猛龙巢里有幼龙，攻击成年迅猛龙时，它们也会加入战斗。",
	-- ["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "荆棘谷猛虎幼崽在营地西侧徘徊，猎豹幼崽则在营地南侧和东侧。\n向西经过营地。荆棘谷迅猛龙（33-34 级）在空地上狩猎，血顶巨魔占据着海岸废墟：任何血顶巨魔都可能掉落獠牙。它们有极低概率掉落 {item:4614}：掉落后记得阅读。\n小心：巨魔营地有很多巡逻怪，因此其他巨魔经常会加入战斗。",
	-- ["Zeppelin to {object:3202}"] = "乘飞艇前往{object:3202}",
	-- ["from {npc:4723}"] = "从{npc:4723}身上获取",
	-- ["grind on {npc:1142}"] = "击杀{npc:1142}刷经验",
	-- ["grind on {npc:686}"] = "刷{npc:686}升级",
	-- ["{area:35}'s and {object:3202}'s next quests are 35-38. Below 35? The Lashtail Raptors (35) hunt the slopes south of the camp, on your way back to {object:3202}: kill them until level 35. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "{area:35}和{object:3202}接下来的任务适合35-38级。还没到35级？返回{object:3202}途中，营地南边的山坡上有鞭尾迅猛龙（35级）觅食：击杀它们，直到35级。也可以组队刷{area:796}地下城的图书馆或武器库。",
	-- ["{area:35}'s and {object:3202}'s next quests are 35-38. Still below 35 after Aggro'gosh's hand-in? The Lashtail Raptors (35) hunt the jungle just north of {object:3202}: kill them until level 35."] = "{area:35}和{object:3202}接下来的任务为35-38级。向阿格罗戈什交还任务后还没到35级？{object:3202}正北边的丛林里有鞭尾迅猛龙（35级）觅食：击杀它们，直到35级。",
	-- ["{item:5852}, in {object:20691}"] = "{item:5852}：在{object:20691}里",
	-- ["{npc:2465}, beside the flight master: the Shadowmaw and tigress parts come after the trolls"] = "飞行管理员旁的{npc:2465}：暗喉和雌虎的部分在巨魔任务之后再做",
	-- ["{npc:2495}'s shop is in the building east of the inn; {npc:2498} is on the inn's bottom floor, {npc:2496}, {npc:737} and {npc:773} upstairs beside the flight master."] = "{npc:2495}的商店在旅店东边的建筑里；{npc:2498}在旅店底层，{npc:2496}、{npc:737}和{npc:773}在楼上飞行管理员旁边。",
	-- ["{npc:2496}: Cozzle's footlocker is at {area:37}, later in this guide"] = "{npc:2496}：考兹尔的提箱在{area:37}，本指南稍后会去",
	-- ["{npc:2496}: for Pozzik at the {area:2240}, on the way to {zone:1446} around level 43"] = "{npc:2496}：交给{area:2240}的波兹克，大约43级前往{zone:1446}时顺路",
	-- ["{npc:2497} waits in {object:3202}, near the zeppelin tower."] = "{npc:2497} 在飞艇塔附近的 {object:3202} 中等待。",
	-- ["{npc:4723} (38) is inside the Venture Co. house on {area:37}'s west shore, among the geologists: his key opens {object:20691} in the same house, which holds the blueprints for {npc:2496}. Careful: Venture Co. Agents (39) stand in and around the house: clear the doorway before you go in."] = "{npc:4723}（38级）在{area:37}西岸的风险投资公司房屋里，周围都是地质学家：他的钥匙能打开同一栋房屋里的{object:20691}，里面装着给{npc:2496}的蓝图。小心：风险投资公司特工（39级）站在房屋内外：进去之前先清理门口。",
	-- ["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "{npc:773}失踪猎人的营地就是奈辛瓦里的营地：在帐篷间走一圈，调查就会完成。淡水鳄趴在营地下方的河边。",
}
