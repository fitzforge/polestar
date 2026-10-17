-- Chinese (simplified) (zhCN): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328}"] = "Tyr's Watch与{spell:7328}",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "{spell:7328}可复活倒下的盟友，另有一把武器和一面盾牌，给新的被遗忘者圣骑士。",

	-- Step 1: Shari Stilwell
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "在{area:159}训练圣骑士的{npc:246152}会让你去西海岸的修会要塞。",

	-- Step 2: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels
	["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602}位于{area:156}西北的悬崖上。{npc:246349}在大门口等候。",

	-- Step 3: Murlocs at the Gates
	["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "邪鳍鱼人潜伏在要塞东边道路沿线的悬崖上，以及西边湖泊周围的营地里。",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "{npc:250283}",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "{npc:250282}",

	-- Step 5: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378}在要塞内领导修会；{npc:246393}站在一旁。",

	-- Step 6: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {item:246213} Sturdy Lumber · {npc:259431} Rudolph Gelhardt
	["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317}占据着要塞西南方{area:16616}中的废弃村庄{area:16881}。{item:246213}堆放在其中一座房屋的地窖里；{npc:259431}指挥官在他的部下之间走动。",
	-- {object:554626} Lumber Pile (no name in this language: may be words)
	["{object:554626}, in the root cellar"] = "{object:554626}，在地窖里",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges"] = "{npc:259434}",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots"] = "{npc:259433}",

	-- Step 7: Back to the keep
	["Back to the keep"] = "回到要塞",

	-- Step 8: A Lesson in Divinity
	-- {npc:246378} Danitha Morr
	["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378}在12级时提供第一堂神圣课程。",

	-- Step 9: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "从{area:159}向南走到{area:153}，再下到{zone:1458}。{npc:10181}在{object:36126}接见臣民；{npc:257648}在{object:36078}乞讨。",

	-- Step 10: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot · Scarlet Friars = {npc:1538} Scarlet Friar
	["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648}需要10块{item:2589}。{npc:1537}和{npc:1538}大约十次掉落三次；如果你身上已经有一些，带上即可。",

	-- Step 12: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "回到{area:16602}。{npc:246378}会给你{item:6866}；{npc:257655}在要塞楼下等候。",

	-- Step 13: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life · {npc:257663} Deathguard Falgan · {npc:246378} Danitha Morr
	["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "{area:812}位于林地的最东端。对{npc:257663}使用{item:6866}，然后与他交谈。如果弄丢了圣物，{npc:246378}会再给你一个。",

	-- Step 14: The Scarlet attack plans
	["The Scarlet attack plans"] = "血色十字军的进攻计划",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "在{area:812}周围扎营的{npc:239036}身上带着进攻计划。",

	-- Step 15: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "回到{area:16602}：比尔穆斯收下计划，{npc:246378}教你{spell:7328}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{object:181686}, in the root cellar"] = "{object:181686}，在地窖里",
}
