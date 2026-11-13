-- Chinese (simplified) (zhCN): the guide forever/alliance/06-wetlands (forever/alliance/06-wetlands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "施放{spell:18960}",

	-- Step 2: Trial of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. With both half pendants in your bags, stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then go to {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "施放{spell:18960}。背包里带着两半坠饰，站到湖西北岸的{area:2362}旁，使用其中一半将它们合并，再去{area:2361}找{npc:11802}。{npc:11802}在建筑的楼上：从屋内上楼，箭头无法区分楼层。",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}：在{area:2362}合并两半坠饰",

	-- Step 3: Aquatic Form
	-- {quest:5061} Aquatic Form · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Take {quest:5061} from {npc:11802}, upstairs in his building. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}."] = "到{npc:11802}所在建筑的楼上接取{quest:5061}，再找{area:2361}的{npc:11800}，她可以让德鲁伊直接飞往{area:702}。",

	-- Step 5: Mathrengyl Bearwalker
	-- {area:1658} Cenarion Enclave · {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the portal up to the {area:1658}, then fly back to {area:442} for the boat to {area:150}."] = "通过传送门上去，到{area:1658}，再飞回{area:442}，坐船前往{area:150}。",

	-- Step 7: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "飞往{area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}的飞行管理员",

	-- Step 8: Into Darnassus
	-- {zone:1457} Darnassus
	["Into {zone:1457}"] = "进入{zone:1457}",

	-- Step 11: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "乘船前往{area:150}",
	-- {area:442} Auberdine · {area:150} Menethil Harbor
	["Take the boat from {area:442}'s dock to {area:150}."] = "从{area:442}的码头坐船前往{area:150}。",

	-- Step 12: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飞往{area:150}",
	-- {zone:1453} Stormwind City
	["{zone:1453} flight master"] = "{zone:1453}飞行管理员",

	-- Step 13: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}，在旅店里",
	-- {item:2594} Flagon of Dwarven Honeymead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}，向{npc:1464}购买",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep; on the top floor"] = "{npc:2104}，在要塞处；顶层",
	-- {npc:2104} Captain Stoutfist · {quest:98221} From the Ashes · {area:1036} Angerfang Encampment
	["{npc:2104}: {quest:98221}, the Attack Plans in the {area:1036}"] = "{npc:2104}：{quest:98221}，收集{area:1036}的Attack Plans",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}，在旅店北边的码头上",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks"] = "{npc:2094}，在码头旁",
	-- {npc:270844} Sylessa Duskwhisper · {npc:2094} James Halloran
	["{npc:270844}, beside {npc:2094} by the docks"] = "{npc:270844}，在码头旁的{npc:2094}身边",
	-- {npc:2097} Harlo Barnaby · {npc:1071} Longbraid the Grim · {area:205} Dun Modr
	["{npc:2097}, by the north gate: {npc:1071} takes it on 30-40/01-hillsbrad-foothills' {area:205} stop"] = "{npc:2097}，在北门旁：在30-40/01-hillsbrad-foothills路线停靠{area:205}时，交给{npc:1071}",

	-- Step 14: Nord'el
	-- {item:279915} Nord'el · {area:150} Menethil Harbor
	["{item:279915} lies on the shore just south of {area:150}, a short walk past the town's south end. Then follow the coast north out of town to the hovels."] = "{item:279915}位于{area:150}南边不远的岸边，出城南端走几步即到。然后沿海岸向北出城，前往鱼人小屋。",

	-- Step 15: The Bluegill hovels
	["The Bluegill hovels"] = "蓝腮鱼人小屋",
	-- {area:1022} Bluegill Marsh · {object:261} Damaged Crate · {object:142151} Sealed Barrel · {object:259} Half-buried Barrel
	["Follow the coast north out of Menethil into {area:1022}. Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "从米奈希尔沿海岸向北进入{area:1022}。鱼人棚屋里有三个容器，从南往北依次是：{object:261}、{object:142151}，最后是北端的{object:259}。",

	-- Step 16: The Lost Fleet: kill these as you meet them
	-- {area:1039} The Lost Fleet
	["{area:1039}: kill these as you meet them"] = "{area:1039}：沿途击杀以下目标",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk · Fen Creepers = {npc:1040} Fen Creeper
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it.\nCareful: Fen Creepers hide in stealth where the river splits close to the ghost ship, and they can join a fight."] = "沿海岸向北前往沉船。被诅咒的水手在海滩上活动，被诅咒的水兵在甲板上；{npc:1159}位于船头旁海滩。巨型湿地鳄鱼潜伏在稍北侧的海岸。\n注意：幽灵船附近河道分岔处有潜行的沼泽爬行者，可能加入战斗。",

	-- Step 17: Menethil Harbor
	-- {npc:2094} James Halloran · {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist · {npc:1239} First Mate Fitzsimmons
	["In from the north: {npc:2094} by the docks, {npc:1242} on the pier, {npc:2104} in the keep, then {npc:1239} in the inn."] = "从北面进城：{npc:2094}在码头旁，{npc:1242}在栈桥上，{npc:2104}在要塞内，然后去旅店找{npc:1239}。",
	-- {npc:270844} Sylessa Duskwhisper
	["{npc:270844}, beside him"] = "{npc:270844}，在他身边",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649} in {area:442}, on this guide's boat trip: keep it"] = "交给{area:442}的{npc:3649}，在本指南的乘船途中完成：先留着",
	-- {npc:1242} Karl Boran · {npc:2104} Captain Stoutfist
	["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}：交给城堡里的{npc:2104}",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, on the top floor"] = "{npc:2104}，位于最顶层",
	-- {object:2117} Stormwind Keep
	["For Bolvar Fordragon in {object:2117}: keep it"] = "交给{object:2117}的伯瓦尔·弗塔根公爵：先留着",

	-- Step 18: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "船长在沉船甲板上走动；他的保险箱在货舱里。",

	-- Step 19: Raptor valley
	["Raptor valley"] = "迅猛龙山谷",
	-- {quest:295} Ormer's Revenge
	["Follow the road east: the bigger raptors for {quest:295} hunt in the valley just west of the excavation site."] = "沿路向东：{quest:295}所需的较大迅猛龙就在挖掘场西边的山谷里活动。",

	-- Step 20: Whelgar's Excavation Site
	-- {npc:1078} Ormer Ironbraid · {npc:1077} Prospector Whelgar
	["The excavation site sits on the hill south of the road: {npc:1078} at the top, {npc:1077} below ground."] = "挖掘场在道路南面的山丘上：{npc:1078}在顶上，{npc:1077}在地下。",

	-- Step 21: Whelgar's Excavation Site: kill these as you meet them
	-- {area:118} Whelgar's Excavation Site
	["{area:118}: kill these as you meet them"] = "{area:118}：沿途击杀以下目标",
	-- {npc:1353} Sarltooth · {object:331} Loose Soil
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it.\nGoaz Warders (elite, 32) stand among the relics and the {object:331}: pull them away one at a time, or work around them."] = "圣物就在挖掘场里。{npc:1353}是一只大型刺喉龙，在挖掘场西边不远的迅猛龙山谷中徘徊。\n戈阿兹守卫者（32级精英）站在圣物和{object:331}之间：逐个引开，或绕开它们。",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}：{object:331}",

	-- Step 22: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078}和维尔加",
	-- {npc:1077} Prospector Whelgar · {item:279993} Titanic Keystone
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["{npc:1077}, below ground: the {item:279993}, from the elite Goaz Warders"] = "{npc:1077}，在地下：{item:279993}由精英戈阿兹守卫者掉落",

	-- Step 23: Goaz Warders
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["Goaz Warders"] = "戈阿兹守卫者",
	-- {item:279996} Goaz Stone · {npc:270892} Goaz Warder
	-- plural, as words: Goaz Warders = {npc:270892} Goaz Warder
	["The Goaz Warders stand just west of Whelgar's camp: use the {item:279996} he gave you beside one.\n{npc:270892} is elite: grouping up is advised."] = "戈阿兹守卫者就在维尔加营地的西边：在其中一只旁边使用他给你的{item:279996}。\n{npc:270892}是精英，建议组队。",

	-- Step 24: Prospector Whelgar
	["Below ground"] = "在地下",

	-- Step 25: Prospector Whelgar
	-- {item:279996} Goaz Stone · {zone:1437} Wetlands · {area:205} Dun Modr
	["A new {item:279996}, for the four titan watchers around the {zone:1437}; below ground. Their hearts drop from level 32 elites on the {area:205} visit"] = "新的{item:279996}，用于{zone:1437}各处的四名泰坦看守；在地下。他们的心脏由前往{area:205}时遇到的32级精英掉落",

	-- Step 26: Angerfang Encampment
	-- {zone:1455} Ironforge · {npc:2091} Chieftain Nek'rosh · {quest:98221} From the Ashes
	["North from the dig into the Dragonmaw camp: click the four sets of Attack Plans. The {zone:1455} plan lies at the camp's west end, the other three further east. {npc:2091}, an elite, stands apart to the south-east: {quest:98221} doesn't need him."] = "从挖掘场向北进入龙喉营地，点击四份Attack Plans。{zone:1455}的计划在营地西端，其余三份在更东面。精英{npc:2091}单独站在东南方，{quest:98221}不需要击杀他。",
	-- {item:3337} Dragonmaw War Banner
	["{item:3337}: the camp's Raiders and Swamprunners"] = "{item:3337}：营地里的龙喉袭击者和龙喉沼泽行者掉落",

	-- Step 27: Rethiel the Greenwarden
	-- {area:1025} Green Belt · {npc:1244} Rethiel the Greenwarden · {quest:277} Fire Taboo · {zone:1437} Wetlands
	["Follow the road east to the {area:1025}; {npc:1244} stands by the river. {quest:277}'s flint came with you from your last {zone:1437} visit."] = "沿路向东前往{area:1025}；{npc:1244}站在河边。{quest:277}所需的燧石是你上次来{zone:1437}时带上的。",

	-- Step 28: Howin Kindfeather
	-- {npc:270637} Howin Kindfeather · {npc:1244} Rethiel the Greenwarden
	["{npc:270637} camps among the Fenrunners, just west of {npc:1244}."] = "{npc:270637}的营地在{npc:1244}西边不远，周围是藓皮沼泽行者。",
	-- {area:1038} Dragonmaw Gates · {zone:1437} Wetlands
	-- plural, as words: Razormaw Incisors = {item:280103} Razormaw Incisor
	["Razormaw Incisors: from the raptors by the {area:1038}, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "刺喉龙门牙：由{area:1038}附近的迅猛龙掉落，在30-40/01-hillsbrad-foothills的{zone:1437}路线中收集",
	-- {quest:98246} Trying Times
	["{quest:98246}: the Razormaw eggs, on the same loop"] = "{quest:98246}：同一趟路线上的刺喉龙蛋",

	-- Step 29: Einar Stonegrip
	-- {npc:270637} Howin Kindfeather · {npc:2093} Einar Stonegrip
	["East from {npc:270637}: {npc:2093} stands beside the road."] = "从{npc:270637}向东走：{npc:2093}站在路边。",
	-- {npc:2093} Einar Stonegrip · {npc:2094} James Halloran
	["{npc:2093}: for {npc:2094} in Menethil"] = "{npc:2093}：交给米奈希尔的{npc:2094}",

	-- Step 30: Fen Creepers along the river
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["Fen Creepers along the river"] = "沿河的沼泽爬行者",
	-- {npc:2093} Einar Stonegrip · {area:1024} Sundown Marsh · {npc:1244} Rethiel the Greenwarden
	-- plural, as words: Fen Creepers = {npc:1040} Fen Creeper
	["North-west from {npc:2093} to the river: Fen Creepers hide in its pools and along its banks all the way west to {area:1024}. Work west along it until you have twelve, then back east to {npc:1244}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "从{npc:2093}向西北到河边：沼泽爬行者藏在水潭和两岸，一直向西分布到{area:1024}。沿河向西击杀十二只，再向东返回{npc:1244}处。\n注意：沼泽爬行者脱战后会不时使用潜行，进入潜行状态后很难看见。",

	-- Step 31: Rethiel the Greenwarden
	-- {quest:98283} Carnage · {zone:1437} Wetlands
	["{quest:98283}, an elite raptor, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "{quest:98283}，一只精英迅猛龙，在30-40/01-hillsbrad-foothills的{zone:1437}路线中处理",

	-- Step 32: Captain Stoutfist
	-- {area:150} Menethil Harbor · {area:2104} Deepwater Tavern · {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep · {npc:1217} Glorin Steelbrow · {npc:2094} James Halloran
	["Hearth back to {area:150} if you bound at the {area:2104}, or walk west along the road: {npc:2104} stands on the top floor of {area:2103}, {npc:1217} in the {area:2104} south of it, {npc:2094} by the docks on the way to the boat."] = "若已在{area:2104}绑定炉石，就用炉石返回{area:150}；否则沿道路向西步行。{npc:2104}在{area:2103}的顶层，{npc:1217}在其南侧的{area:2104}内，{npc:2094}在前往乘船处途中的码头旁。",
	["On the top floor"] = "在最顶层",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of 30-40/01-hillsbrad-foothills"] = "用于龙喉投石车，在30-40/01-hillsbrad-foothills的{zone:1437}路线中处理",
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern
	["{npc:1217}, in the {area:2104}"] = "{npc:1217}，在{area:2104}",
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind City
	["For {npc:1284} in {zone:1453}, at the end of this guide"] = "交给{zone:1453}的{npc:1284}，在本指南末尾完成",
	-- {npc:2094} James Halloran
	["{npc:2094}, by the docks, on the way to the boat"] = "{npc:2094}，在码头旁，去坐船时顺路经过",

	-- Step 33: Boat to Auberdine
	-- {area:442} Auberdine
	["The boat to {area:442} leaves from the far end of Menethil's western pier."] = "前往{area:442}的船从米奈希尔西侧栈桥的尽头出发。",

	-- Step 34: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}, up the road from the dock."] = "{npc:3649}站在{area:442}北端，从码头沿路往上走即到。",
	-- {item:279915} Nord'el · {npc:270844} Sylessa Duskwhisper · {area:150} Menethil Harbor
	["{item:279915}, from {npc:270844} in {area:150}"] = "{item:279915}，来自{area:150}的{npc:270844}",

	-- Step 35: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} stands at the north end of {area:442}."] = "{npc:3649}在{area:442}北端。",
	-- {area:442} Auberdine
	["Alexston's reply, if you still carry it (the route hands it in on 03-darkshore-return's first {area:442} stop)"] = "巴隆斯·阿历克斯顿的回信，如果还带在身上（路线已安排在03-darkshore-return首次到{area:442}时交还）",

	-- Step 36: Auberdine
	-- {npc:3693} Terenthis
	["{npc:3693} stands by the flight master."] = "{npc:3693}站在飞行管理员旁。",
	-- {npc:3693} Terenthis · {zone:1439} Darkshore
	["{npc:3693}: Volcor's escort from the end of {zone:1439}"] = "{npc:3693}：{zone:1439}末尾的沃科尔护送任务",

	-- Step 37: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "飞往{area:415}",

	-- Step 38: Shindrell Swiftfire
	-- {npc:3845} Shindrell Swiftfire · {area:415} Astranaar
	["{npc:3845} stands by {area:415}'s flight master."] = "{npc:3845}站在{area:415}的飞行管理员旁。",
	-- {quest:4581} Kayneth Stillwind · {area:2358} Forest Song
	["For {quest:4581} at {area:2358}"] = "去{area:2358}交{quest:4581}",

	-- Step 39: Astranaar
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}：在屋内",

	-- Step 40: Melyria and Illiyana
	-- {npc:3901} Illiyana
	["Melyria and {npc:3901}"] = "哨兵梅丽瑞亚·霜影和{npc:3901}",
	-- {area:415} Astranaar
	["The two stand together at the western end of the road, south-west of {area:415}."] = "两人一起站在{area:415}西南、道路的西端。",

	-- Step 41: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "沿道路向东到{area:419}；{npc:3916}站在月亮井旁。",

	-- Step 42: Dartol's Rod
	["Dartol's Rod"] = "达图尔的变形魔棒",
	-- {item:5475} Wooden Key
	-- plural, as words: Withered Ancients = {npc:3919} Withered Ancient
	["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "月亮井北边的疯狂的古树和{npc:3919}带着{item:5475}；它能打开的旧箱子就在它们中间。",

	-- Step 44: Anilia
	-- {area:429} Xavian · {npc:3920} Anilia
	["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "沿道路向东到{area:429}的萨特营地；{npc:3920}躲在营地边缘。",

	-- Step 45: Geltharis
	-- {npc:4619} Geltharis · {area:429} Xavian
	["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619}率领{area:429}的萨特；树枝在他身上。",

	-- Step 46: Forest Song
	-- {area:2358} Forest Song · {npc:3848} Kayneth Stillwind · {npc:221269} Maseara Autumnmoon
	["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there, {npc:221269} a few steps east of her."] = "{area:2358}是道路东端的暗夜精灵前哨：{npc:3848}站在那里，{npc:221269}在她东边几步远。",
	-- {npc:221269} Maseara Autumnmoon · {area:430} Satyrnaar
	["{npc:221269}: her husband's trail in {area:430}, on the way back from the lake"] = "{npc:221269}：在{area:430}追寻她丈夫的踪迹，从湖边返回时顺路完成",

	-- Step 47: The Dor'Danil Barrow Den: kill these as you meet them
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}: kill these as you meet them"] = "{area:432}：沿途击杀以下目标",
	-- {area:2358} Forest Song
	["The Forsaken's camp lies in the woods south of {area:2358}.\nRusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel.\nCareful: Non-elite Forsaken of about level 28-30 guard the camp. Some of them are stealthed, and the ones around the table often aggro together."] = "被遗忘者的营地位于{area:2358}南侧树林中。\n被遗忘者营地西侧的林荫熊怪营地周围有生锈的箱子，不断打开，直到找到剑柄。\n注意：营地由约 28–30 级的非精英被遗忘者守卫，部分敌人处于潜行状态，桌子周围的敌人通常会一同参战。",

	-- Step 48: Fallen Sky Lake
	-- {npc:3931} Shadethicket Oracle · {quest:1035} Fallen Sky Lake · {object:669176} Gleaming Crescent Pendant
	["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way.\nCareful: Other mobs, some of them underwater, sit near the island. Clear them first so they don't join the fight when you pull the Oracle."] = "{npc:3931}在箱子西南侧的{quest:1035}岸边巡逻；途中可在湖北侧找到{object:669176}。\n注意：岛屿附近还有其他怪物，部分位于水下。先清理周围，避免拉神谕者时其他敌人加入战斗。",
	-- {object:669176} Gleaming Crescent Pendant · {npc:3961} Maliynn · {area:415} Astranaar
	["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}：交给{area:415}的{npc:3961}",

	-- Step 49: Satyrnaar
	-- {area:430} Satyrnaar · {area:2358} Forest Song · {object:19901} Circle of Imprisonment · {item:281014} Vine-Wrapped Scroll · {area:428} Night Run
	-- plural, as words: Felmusk Rogues = {npc:3759} Felmusk Rogue
	["North from the lake to the satyr camp of {area:430}, just west of {area:2358}: the {object:19901} stands in it, and Kurothel's Knapsack lies beside it with the {item:281014}.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "从湖边向北前往{area:2358}西边不远处的{area:430}萨特营地：{object:19901}就在营地里，旁边是库洛瑟尔的背包，里面有{item:281014}。\n注意：{area:428}的魔草潜行者经常潜行，{area:430}也有萨特施法者。",
	-- {item:281014} Vine-Wrapped Scroll
	["{item:281014}, from Kurothel's Knapsack"] = "{item:281014}，从Kurothel's Knapsack中获取",

	-- Step 50: Kayneth Stillwind
	-- {npc:3848} Kayneth Stillwind · {quest:1012} Insane Druids · {area:432} The Dor'Danil Barrow Den
	["Optional: {npc:3848} also offers {quest:1012}, three level 32 druids deep in {area:432}, a cave of quickly respawning, stealthed mobs, and back to her afterwards. It is above your level here: take it only if you are grouped or want the extra XP; the guide doesn't need it."] = "可选：{npc:3848}还提供{quest:1012}，需要到{area:432}深处对付3名32级德鲁伊，之后再回来找她。洞内有潜行怪物，刷新也很快。此任务目前高于路线等级，仅在组队或想多拿经验时接取；主线流程不需要完成。",
	-- {npc:221269} Maseara Autumnmoon
	["{npc:221269}, a few steps east"] = "{npc:221269}，在东边几步远",

	-- Step 51: The Dor'Danil Barrow Den's entrance
	-- {area:432} The Dor'Danil Barrow Den
	["{area:432}'s entrance"] = "{area:432}的入口",

	-- Step 52: Insane druids
	["Insane druids"] = "发狂的德鲁伊",
	-- {area:432} The Dor'Danil Barrow Den · {npc:3940} Taneel Darkwood · {npc:3941} Uthil Mooncall · {npc:3942} Mavoris Cloudsbreak
	["The three druids are inside {area:432}, apart from each other: go in at its mouth, south of the Forsaken camp, not over the hill above them. {npc:3940} is in the eastern halls, {npc:3941} deepest down at the north-east end and {npc:3942} at the western end.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "3名德鲁伊分散在{area:432}内：从被遗忘者营地南面的洞口进入，别从他们上方的山丘翻过去。{npc:3940}在东侧洞厅，{npc:3941}在东北端最深处，{npc:3942}在西端。\n注意：洞内怪物密集、刷新很快，还有潜行亡灵和巡逻队，战斗时容易引来其他敌人。",
	-- {npc:3940} Taneel Darkwood · {area:432} The Dor'Danil Barrow Den
	["{npc:3940}, inside {area:432}"] = "{npc:3940}，位于{area:432}内部",
	-- {npc:3941} Uthil Mooncall · {area:432} The Dor'Danil Barrow Den
	["{npc:3941}, inside {area:432}"] = "{npc:3941}，位于{area:432}内部",
	-- {npc:3942} Mavoris Cloudsbreak · {area:432} The Dor'Danil Barrow Den
	["{npc:3942}, inside {area:432}"] = "{npc:3942}，位于{area:432}内部",

	-- Step 54: Night Run
	-- {object:19901} Circle of Imprisonment · {area:428} Night Run
	["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "第二个{object:19901}在{area:428}的山谷里，就在向西的路上。",

	-- Step 56: Hidden Shrine
	["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "隐蔽的神龛在月亮井东南方不远处的山丘上；沿蜿蜒的小路上去。",

	-- Step 58: The Howling Vale
	-- {area:419} Howling Vale · {npc:3792} Terrowulf Packlord
	-- plural, as words: Terrowulf Fleshrippers = {npc:3789} Terrowulf Fleshripper
	["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end. Careful: Terrowulf Fleshrippers and Shadow Weavers (28-30) stand in tight packs around the tome, and the {npc:3792}, a level 32 rare, walks the vale. Pull the wolves one at a time from the tunnel and let the Packlord pass first."] = "穿过隧道进入{area:419}；书在西端的废墟里。小心：恐狼撕裂者和织影狼人（28-30级）在书周围密集成群，32级稀有怪{npc:3792}在山谷中游荡。从隧道口把狼一只一只拉过来，先让族长走过去。",

	-- Step 59: Astranaar
	-- {npc:3691} Raene Wolfrunner · {npc:3961} Maliynn · {npc:3894} Pelturas Whitemoon
	["{npc:3691} and {npc:3961} are in the inn; {npc:3894} is inside the building just south of it."] = "{npc:3691}和{npc:3961}在旅店内；{npc:3894}在旅店正南方的建筑内。",
	-- {npc:3961} Maliynn
	["{npc:3961}, in the inn"] = "{npc:3961}，在旅店里",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside the building south of the inn"] = "{npc:3894}，在旅店南侧的建筑内",

	-- Step 60: Krolg
	-- {npc:3897} Krolg · {area:421} Mystral Lake · {item:5462} Dartol's Rod of Transformation
	["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}. Use {item:5462} near him first: he only speaks to you in furbolg form."] = "{npc:3897}是一个未受腐蚀的熊怪，坐在{area:421}下方道路的南边。先在他附近使用{item:5462}：他只会和熊怪形态的你交谈。",

	-- Step 61: Ran Bloodtooth
	-- {npc:3696} Ran Bloodtooth · {npc:3897} Krolg
	["{npc:3696} and his guards camp just east of {npc:3897}.\nCareful: Wolves and spiders roam near the camp and can join a fight. Some of the wolves come in pairs."] = "{npc:3696}和守卫就在{npc:3897}东侧扎营。\n注意：营地附近有游荡的狼和蜘蛛，可能加入战斗；部分狼会两只一起出现。",
	-- {item:5388} Ran Bloodtooth's Skull · {npc:3696} Ran Bloodtooth
	["{item:5388}, from {npc:3696}"] = "{item:5388}，击杀{npc:3696}获得",

	-- Step 63: Melyria and Illiyana
	-- {npc:3897} Krolg · {area:416} Shrine of Aessina · {npc:3901} Illiyana
	["West from {npc:3897} along the southern hills to the {area:416}: Melyria and {npc:3901} stand together by it."] = "从{npc:3897}沿南面山丘向西前往{area:416}：哨兵梅丽瑞亚·霜影和{npc:3901}一起站在旁边。",

	-- Step 64: Delgren the Purifier
	-- {area:413} Maestra's Post
	["North to {area:413}."] = "向北前往{area:413}。",

	-- Step 65: Astranaar
	-- {area:415} Astranaar · {npc:3691} Raene Wolfrunner
	["South-east along the road to {area:415}: {npc:3691} in the inn, the flight master at the west end."] = "沿路向东南前往{area:415}：{npc:3691}在旅店里，飞行管理员在西端。",

	-- Step 66: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飞往{area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "{area:415}的飞行管理员",

	-- Step 68: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飞往{area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn."] = "{npc:1571}是米奈希尔旅店旁的飞行管理员。",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "{area:150}的飞行管理员",

	-- Step 70: Ironforge priests
	-- {zone:1455} Ironforge
	["{zone:1455} priests"] = "{zone:1455}的牧师",
	-- {npc:11406} High Priest Rohan · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {object:32362} Mystic Ward
	["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406}和{npc:258785}在{object:32362}的{object:32386}。",

	-- Step 71: Tram to Stormwind City
	-- {zone:1453} Stormwind City
	["Tram to {zone:1453}"] = "乘地铁前往{zone:1453}",

	-- Step 72: Cathedral of Light
	["Cathedral of Light"] = "光明大教堂",
	-- {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind City · {object:28027} Dwarven District · {object:2098} Cathedral Square
	["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "从{object:171524}乘{area:2257}前往{zone:1453}的{object:28027}，然后步行到{object:2098}。",
	-- {npc:4982} Thomas
	["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}，在光明大教堂",

	-- Step 73: Stormwind Keep
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["Only if you looted {quest:337} in {zone:1431}"] = "仅当你在{zone:1431}拾取了{quest:337}",

	-- Step 74: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["Back to the Cathedral of Light: {npc:928} stands inside."] = "回到光明大教堂：{npc:928}站在里面。",
	-- {npc:2228} Lieutenant Farren Orinelle · {area:271} Southshore
	["For {npc:2228} in {area:271}: keep it"] = "交给{area:271}的{npc:2228}：先留着",

	-- Step 75: Jorgen and Elling Trias
	-- {npc:4959} Jorgen · {npc:482} Elling Trias
	["{npc:4959} and {npc:482}"] = "{npc:4959}和{npc:482}",
	-- {npc:482} Elling Trias · {object:2096} Trade District
	["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}，在{object:2096}的奶酪店",

	-- Step 76: Trade District
	-- {area:42} Darkshire
	["Next: fly to {area:42}."] = "下一步：飞往{area:42}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to {area:150}: {npc:2104} stands on the top floor of {area:2103}."] = "沿路向西返回{area:150}：{npc:2104}站在{area:2103}顶层。",
	-- ["Flagon of Mead, from {npc:1464}"] = "Flagon of Mead，向{npc:1464}购买",
	-- ["In {zone:1453}, join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then {npc:11800} in {area:2361} flies Druids straight to {area:702}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "在{zone:1453}将两半坠饰合成{item:15885}，然后施放{spell:18960}：{npc:11802}在{area:2361}。之后，{area:2361}的{npc:11800}可让德鲁伊直接飞往{area:702}。{npc:11802}站在楼上：从屋内上楼，箭头无法区分楼层。",
	-- ["Inside"] = "在里面",
	-- ["Red whelps fill the hills west of the gates, Maddened Rotclaws the {area:1025}, Razormaws the northern slopes; Neru stands in the north-east (use the {item:279996}).\nFen Creepers hide in the marsh pools north-west of the {area:1025}.\nCareful: When out of combat, Fen Creepers cast Sneak from time to time, so they are stealthed and hard to see."] = "红色雏龙分布在大门西面的山丘，疯狂的腐爪出没于{area:1025}，刺喉龙在北面山坡活动；奈尔鲁在东北面（使用{item:279996}）。\n沼泽爬行者藏在{area:1025}西北的沼泽水潭中。\n小心：脱离战斗时，沼泽爬行者会不时施放Sneak，进入潜行，难以发现。",
	-- ["South-east along the road to {area:415}: {npc:3691} in the inn, {npc:3961} and {npc:3894} inside, the flight master at the west end."] = "沿路向东南前往{area:415}：{npc:3691}在旅店内，{npc:3961}和{npc:3894}在里面，飞行管理员在西端。",
	-- ["South-east from the dig to the Dragonmaw camp. The four sets of Attack Plans lie in the {area:1036}; {npc:2091}, an elite, stands in the camp too."] = "从挖掘场向东南前往龙喉营地。四份Attack Plans分布在{area:1036}；精英{npc:2091}也在营地中。",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "穿过隧道进入{area:419}；书在西端的废墟里。",
	-- ["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "圣物就在挖掘场里。{npc:1353}是一只大型刺喉龙，在挖掘场西边不远的迅猛龙山谷中徘徊。",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}.\nCareful: The den has many mobs that respawn quickly, including stealthed undead and patrols, so extra mobs often join a fight."] = "三名德鲁伊一起站在{area:2358}南侧的被遗忘者营地内。\n注意：洞穴内怪物较多，刷新很快，还有潜行亡灵和巡逻队，战斗时经常会引来其他敌人。",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road.\nCareful: The Felmusk Rogues in {area:428} often go stealthed, and {area:430} has satyr casters."] = "沿路继续向东，{object:19901}位于{area:430}的萨特营地。\n注意：{area:428}的魔草潜行者经常潜行，{area:430}也有萨特施法者。",
	-- ["{area:1025}: kill these as you meet them"] = "{area:1025}：沿途击杀以下目标",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}是道路东端的暗夜精灵前哨：{npc:3848}站在那里。",
	-- ["{item:15885}: join the two halves"] = "{item:15885}：合并两块碎片",
	-- ["{npc:3649} stands at the north end of {area:442}, {npc:3693} and {npc:3694} by the flight master."] = "{npc:3649}站在{area:442}北端，{npc:3693}和{npc:3694}在飞行管理员旁。",
	-- ["{npc:3649}: Alexston's reply, if you took it in {zone:1453}"] = "{npc:3649}：如果此前在{zone:1453}接取，交付巴隆斯·阿历克斯顿的回信",
	-- ["{npc:3691}, in the inn"] = "{npc:3691}，在旅店里",
	-- ["{npc:3694}: for {npc:3691} in {area:415}"] = "{npc:3694}：交给{area:415}的{npc:3691}",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}是一个未受腐蚀的熊怪，坐在{area:421}下方道路的南边。",
}
