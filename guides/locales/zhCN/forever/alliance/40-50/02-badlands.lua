-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Valley of Fangs
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["{npc:2817}: Blue Pearls from Stranglethorn"] = "{npc:2817}：交付荆棘谷取得的蓝珍珠",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "{npc:2817}的下一个任务不给经验：跳过。",

	-- Step 3: Boss Tho'grun
	-- {zone:1418} Badlands · {area:342} Camp Boff · {npc:2944} Boss Tho'grun
	["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "向西骑过{zone:1418}，到{area:342}的火烟营地。{npc:2944}站在营地中央，周围是火烟猎龙者和火烟虐待者。",

	-- Step 4: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "向东骑回{area:1898}。",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "{npc:2888}的下一个任务是精英狩猎：跳过。",

	-- Step 5: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "{npc:2725}在{npc:2888}东边的峡谷里筑巢；别惹{npc:2726}（精英）。{item:4612}很少掉落：刷怪时掉了就拿上。",

	-- Step 7: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "进入{zone:1432}",

	-- Step 8: Ironband's Excavation Site
	-- {zone:1432} Loch Modan
	["Ride north through the pass into {zone:1432} and east along the south shore to Ironband's camp."] = "",

	-- Step 9: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "进入{zone:1418}",

	-- Step 10: Badlands
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "{area:1517}挖掘场",

	-- Step 11: The Uldaman dig
	-- {area:1517} Uldaman · {zone:1418} Badlands
	["Back through the pass: the Stonevault troggs dig outside {area:1517} at the {zone:1418}' northern edge. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "{item:8047}：在地下",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "{object:2743}：在地下",

	-- Step 12: Back to Loch Modan
	-- {zone:1432} Loch Modan
	["Back to {zone:1432}"] = "返回{zone:1432}",

	-- Step 13: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "向北骑回铁环挖掘场的营地。",

	-- Step 14: Thelsamar
	-- {area:144} Thelsamar
	["Ride west along the loch to {area:144}."] = "",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}：在地下",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飞往{area:271}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144}的飞行管理员",

	-- Step 16: Southshore
	-- {npc:3980} Raleigh the Devout
	["{npc:3980} preaches by the inn."] = "{npc:3980}在旅店旁布道。",
	-- {npc:3980} Raleigh the Devout
	["{npc:3980}, upstairs"] = "{npc:3980}：在楼上",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "虔诚的莱雷恩的下一个差事在{area:796}：跳过。",

	-- Step 18: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "沿道路向东北骑出{area:271}，进入{zone:1425}；{area:348}就在边界后面。{npc:5635}在顶层，{quest:1450}照看狮鹫棚，{npc:7884}站在旅店旁。",
	-- {quest:1450} Gryphon Master Talonaxe
	["{quest:1450}, inside"] = "{quest:1450}：在屋内",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}：在屋内",
	-- {npc:7744} Innkeeper Thulfram
	["{npc:7744}: the last guide binds here, so this usually ticks at once; below ground"] = "{npc:7744}在地下；上份指南已经在这里绑定炉石，通常会立即标记完成",

	-- Step 19: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634}在{area:348}东边的路上扎营。",

	-- Step 20: Witherbark villages
	["Witherbark villages"] = "枯木村庄",
	-- {npc:5634} Rhapsody Shindigger
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace."] = "前两个笼子一起在{npc:5634}南边的枯木村庄里；第三个在东边的下一个村庄里。每个枯木巨魔都可能掉落项链。",

	-- Step 21: Aerie Peak
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884}会继续收购项链：交上多余的",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top; inside"] = "{npc:5636}，位于高处飞行管理员旁的屋内",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "狮鹫管理员沙拉克·鹰斧的下一个任务留到之后的{zone:1425}指南。",

	-- Step 22: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飞往{area:150}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "{area:348}的飞行管理员",

	-- Step 24: Theramore
	["Theramore"] = "塞拉摩岛",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616}站在船停靠的码头上。",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}，位于最顶层",
	-- {npc:4968} Lady Jaina Proudmoore
	["{npc:4968}, on the top floor"] = "{npc:4968}，位于最顶层",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}：在屋内",

	-- Step 25: Cortello's Riddle
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "进入{area:498}内部",

	-- Step 26: Theramore flight master
	["Theramore flight master"] = "塞拉摩飞行管理员",

	-- Step 28: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "术士：{quest:3631}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["From Theramore, ride north into the {zone:1413} to {area:392}, or fly if you know its flight path. {npc:6251} teaches in the house by the bank."] = "从塞拉摩岛向北骑进{zone:1413}到{area:392}，如果你有它的飞行路线就直接飞过去。{npc:6251}在银行旁的房子里授课。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Blue Pearls from Stranglethorn"] = "来自荆棘谷的{item:4611}",
	-- ["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "飞往{area:392}；{npc:6251}在银行旁的房子里授课。之后飞回塞拉摩岛。",
	-- ["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "飞往{area:608}，向南骑过{zone:1443}进入{zone:1444}，沿道路到{area:1108}的码头；船会渡海前往{area:1116}，下一份指南从那里开始。",
	-- ["On to Feathermoon"] = "前往羽月要塞",
	-- ["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "向北骑到{area:144}，飞往{area:271}。{npc:3980}在旅店旁布道。",
	-- ["Ride north-east out of {area:271} on the road into the {area:47}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "沿道路向东北骑出{area:271}，进入{area:47}；{area:348}就在边界后面。{npc:5635}在顶层，{quest:1450}照看狮鹫棚，{npc:7884}站在旅店旁。",
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "沿道路向东北骑出{area:271}，进入{zone:1425}；{area:348}就在边界后面。弗斯塔德·蛮锤在顶层，{quest:1450}照看狮鹫棚，{npc:7884}站在旅店旁。",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "向南骑出{zone:1432}，穿过山口进入{zone:1418}；{npc:2860}在挖掘场扎营。",
	-- ["Ride west across the {area:3} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "向西骑过{area:3}，到{area:342}的火烟营地。{npc:2944}站在营地中央，周围是火烟猎龙者和火烟虐待者。",
	-- ["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "向西骑到{zone:1418}中部的{area:1877}；{npc:2817}在流放者马特克旁边扎营。",
	-- ["Take the boat to Theramore from the far pier."] = "从最远的码头乘船前往塞拉摩岛。",
	-- ["Talonaxe's next task waits for a later {area:47} guide."] = "狮鹫管理员沙拉克·鹰斧的下一个任务留到之后的{area:47}指南。",
	-- ["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "破损的骷髅在石窟穴居人营地边缘；杀死埃格蒙德的凶手{quest:739}在石窟断骨者中间巡逻。",
	-- ["grind on {npc:2725} at {area:339}, {zone:1418}"] = "在{zone:1418}的{area:339}刷{npc:2725}",
	-- ["{npc:1573}, the {object:32372}"] = "{npc:1573}，{object:32372}",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888}独自在挖掘场东南方的{area:1898}扎营。",
	-- ["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "{npc:5634}的鸡尾酒需要卡利姆多的材料：跳过。",
	-- ["{npc:5636}, beside the flight master at the top"] = "{npc:5636}，在顶层飞行管理员旁边",
}
