-- Chinese (simplified) (zhCN): the guide forever/alliance/nightelf/02-darkshore (forever/alliance/nightelf/02-darkshore.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "船停靠在村子西边。飞行管理员站在旅店南边的山丘上；任务发布者分布在主街上。",
	["The WANTED poster outside the inn"] = "旅店外的通缉布告",

	-- Step 2: The beach
	["The beach"] = "海滩",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "{npc:2232}在村子下方的岸边爬行；{quest:983}立在码头南边的海滩上。{npc:2185}在浅水中游动。{object:175207}躺在村子南边的岸上。",

	-- Step 3: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}，在村子北端",

	-- Step 4: Auberdine
	-- {npc:3666} Wizbang Cranktoggle
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street. {npc:3666} stands upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "船停靠在村庄西边。飞行管理员站在旅店南边的山坡上；任务给予者分布在主街两旁。{npc:3666}在旅店楼上：从室内楼梯上去，箭头无法区分楼层。",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn"] = "{npc:3666}，在旅店楼上",

	-- Step 5: The skeletal turtle
	["The skeletal turtle"] = "骷髅海龟",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}：位于码头西侧海滩外的水下",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "熊和黑木营地",
	-- {area:442} Auberdine · {item:7586} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "狂暴蓟熊在{area:442}南边的山丘上游荡：对其中一只使用{item:7586}将其捕获。然后走到它们东边不远处的熊怪营地：暂时无需击杀任何怪物。",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "{npc:3701} 附近的狂暴蓟熊",

	-- Step 7: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639}站在废墟北缘。被诅咒的贵族、挣扎的贵族和{npc:2178}在那里出没；{npc:3667}的鬼魂在它们中间游荡，猫头鹰{npc:270196}在它们东边盘旋。两块石板在废墟中；一只{quest:4722}躺在废墟西边的岸上。",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "{item:5360}",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "阅读{object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "阅读{object:17189}",

	-- Step 8: The red crystal
	["The red crystal"] = "红色水晶",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "爬上{area:447}东边的山脉；{object:175524}位于一处岩架上。",

	-- Step 9: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {object:17183} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "沿山丘向北，{npc:3650}在{quest:954}废墟内等候。野生劣魔和恶灵劣魔遍布废墟，戴瑟雷萨特在东缘活动。{object:17183}位于废墟西侧路边，前去途中，海岸上还有一处{quest:4723}。",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "{item:5336}",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}：{npc:2212}",

	-- Step 11: Auberdine
	["Fill the tube at the moonwell in the village"] = "在村里的月亮井装满试管",

	-- Step 12: Blackwood furbolgs
	["Blackwood furbolgs"] = "黑木熊怪",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "{npc:2167}和黑木风语者占据着{area:442}东南方的营地。",

	-- Step 13: The southern beaches
	["The southern beaches"] = "南部海滩",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "沿海岸向南经过{area:447}：一只{quest:4728}躺在古树之林西边的岸上，另一只在更南边的{area:450}附近。更西南方的灰雾智者和灰雾潮行者（18-20级）之间还有三具遗骸：指南把它们留到最后一轮，那时你的等级更接近它们。",

	-- Step 14: Ameth'Aran
	-- {area:447} Ameth'Aran
	["Back north to {area:447}: the flame burns in the south of the ruins."] = "向北返回{area:447}：火焰在废墟南部燃烧。",

	-- Step 15: The red crystal
	["Back north-east into the mountains to the crystal."] = "向东北回到山里的水晶处。",

	-- Step 16: Bashal'Aran
	-- {npc:3650} Asterion · {area:442} Auberdine
	["North along the hills to {npc:3650}, then west down to {area:442}."] = "沿山丘向北找到{npc:3650}，然后向西下山前往{area:442}。",

	-- Step 18: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "乘船前往{area:17203}",

	-- Step 19: Manifest Clerk Philmor
	-- {npc:268511} Manifest Clerk Philmor · {npc:483} Elaine Trias · {object:2096} Trade District
	["Off the boat, {npc:268511} stands on the harbor: his shipment goes to {npc:483}' cheese shop in the {object:2096}, beside the flight master."] = "下船后，{npc:268511}就站在港口：他的货物要送到{object:2096}、飞行管理员旁边{npc:483}的奶酪店。",

	-- Step 20: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飞行管理员",
	-- {npc:483} Elaine Trias
	["{npc:483}, in her cheese shop"] = "{npc:483}，在她的奶酪店里",
	-- {object:460004} Gatehouse Door (no name in this language: may be words)
	["Up the stairs in her shop: leave the shipment at the {object:460004}"] = "沿她店里的楼梯上楼，把货物留在{object:460004}处",

	-- Step 21: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:2096} Trade District · {zone:1436} Westfall
	["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646}站在{object:2096}西边的{object:2098}。他的罗盘在{zone:1436}的旧居里，途中会经过。",

	-- Step 22: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "顺便：找{npc:11867}学习{spell:202}（{object:2096}，10银币）；双手武器能让战士升级最快。",

	-- Step 23: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "顺便：在{npc:11867}处学习剑（{object:2096}，10银币）；主手持剑能让潜行者稳定升级。",

	-- Step 24: Druid trainer
	["Druid trainer"] = "德鲁伊训练师",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504}在{zone:1453}；{area:87}没有德鲁伊训练师",

	-- Step 26: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 27: Shaman trainer
	["Shaman trainer"] = "萨满祭司训练师",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446}在{zone:1426}；{area:87}没有萨满祭司训练师",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Into {area:148}"] = "前往{area:148}",
}
