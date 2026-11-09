-- Chinese (simplified) (zhCN): the guide forever/class/rogue/blade-of-cunning-horde (forever/class/rogue/blade-of-cunning-horde.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Horde)"] = "{item:7298}（部落）",
	["A dagger at 10 from your home town's rogue quests."] = "10级时来自家乡潜行者任务的一把匕首。",

	-- Step 1: Therzok
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {quest:1859} Therzok · {zone:1454} Orgrimmar · {quest:1963} The Shattered Hand
	["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}. It is only a pointer: an Orc already in {zone:1454} can skip it and take {quest:1963} from {quest:1859} straight away."] = "10级时，{area:362}的盗贼训练师{npc:3170}会派你去{zone:1454}找{quest:1859}。这只是引导任务：已经在{zone:1454}的兽人可以跳过，直接从{quest:1859}处接受{quest:1963}。",

	-- Step 2: The Shattered Hand
	-- {quest:1859} Therzok · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:1963} The Shattered Hand
	["{quest:1859} stands in the {object:172960}, the canyon under the {object:172982}. Trolls: take {quest:1963} from him at 10."] = "{quest:1859}站在{object:172960}，也就是{object:172982}下方的峡谷里。巨魔：10级时从他那里接受{quest:1963}。",

	-- Step 3: Tazan
	-- {npc:6494} Tazan · {area:391} Merchant Coast · {area:392} Ratchet
	["{npc:6494} (level 13, not elite) is a troll pirate on the {area:391} south of {area:392}: he walks the fenced hill path between the lower pirate camp by the beached ship and the upper camp by a big tree. Fight him at the foot of the hill, away from the camps. He always drops his satchel and is back 4 1/2 minutes after a death; one satchel per kill, so two rogues need two kills. Hand the satchel in unopened: picking its lock now destroys it and you must kill him again."] = "{npc:6494}（13 级，非精英）是一名巨魔海盗，位于 {area:392} 南侧的 {area:391}：他沿着有围栏的山路，在搁浅船只旁的下层海盗营地与大树旁的上层营地之间来回走动。在山脚下远离营地的地方与他战斗。他必定掉落背包，死亡 4 分半后刷新；每次只掉一个背包，因此两名潜行者需要击杀两次。交还背包前不要打开：现在开锁会毁掉它，你就必须再杀他一次。",

	-- Step 4: Back to Therzok
	-- {npc:6446} Therzok
	["Back to {npc:6446}"] = "回到{npc:6446}那里",

	-- Step 5: Tazan's Key
	-- {quest:1859} Therzok · {npc:6466} Gamon · {object:172982} Valley of Strength · {item:7208} Tazan's Key · {item:7209} Tazan's Satchel · {spell:1804} Pick Lock
	["{quest:1859} hands the satchel back: now open it. {npc:6466} (level 12) kneels by the innkeeper in the inn in the {object:172982}; stealth up and pick his pocket for {item:7208} (do not kill him: the key almost never drops). Players often kill him, so you may wait up to 5 minutes for him. Then use the key on {item:7209} in your bags. If you have trained {spell:1804}, you can pick the satchel's lock instead."] = "{quest:1859}会把背包还给你：现在打开它。{npc:6466}（12级）跪在{object:172982}旅店的旅店老板旁；潜行靠近，偷窃获得{item:7208}（不要杀他：钥匙几乎不会掉落）。玩家常常会杀他，因此可能需要等最多5分钟。然后用钥匙打开背包中的{item:7209}。如果已经学会{spell:1804}，也可以直接撬开背包的锁。",
	-- {item:7208} Tazan's Key
	["Pick Pocket Gamon for {item:7208}"] = "从加摩尔身上偷取{item:7208}",
	-- {item:7209} Tazan's Satchel
	["{item:7209}, once you have the key"] = "{item:7209}，拿到钥匙后",
	-- {item:7295} Tazan's Logbook
	["{item:7295}, from the satchel"] = "{item:7295}，来自挎包",

	-- Step 6: Therzok's reward
	-- {npc:6446} Therzok
	["{npc:6446}'s reward"] = "{npc:6446}的奖励",

	-- Step 7: Mennet Carkad
	-- {npc:2130} Marion Call · {area:2119} Gallows' End Tavern · {area:159} Brill · {quest:1885} Mennet Carkad · {zone:1458} Undercity
	["At 10 {npc:2130}, the rogue trainer upstairs in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "10级时，{area:159}的{area:2119}楼上的盗贼训练师{npc:2130}会派你去{zone:1458}找{quest:1885}。",

	-- Step 8: The Rogues' Quarter
	-- {object:36073} Rogues' Quarter
	["The {object:36073}"] = "{object:36073}",
	-- {quest:1885} Mennet Carkad · {object:36073} Rogues' Quarter
	["{quest:1885} stands in the {object:36073}."] = "{quest:1885}站在{object:36073}。",

	-- Step 9: Astor Hadren
	-- {npc:6497} Astor Hadren · {area:228} Sepulcher · {zone:1458} Undercity
	["{npc:6497} (level 13) walks the road between the {area:228} and the {zone:1458}, north of the {area:228}. He looks like a friendly traveller with no quest mark. Talk to him and pick both of his answers: he turns hostile. Kill him for the letter (it always drops). Fight him away from guards, who can take the kill and leave no loot; only one rogue per kill gets the letter. He is back 5 minutes after a death."] = "{npc:6497}（13级）在 {area:228} 北面、{area:228} 与 {zone:1458} 之间的道路上行走。他看起来像友善的旅人，没有任务标记。与他交谈，选过他的两个对话选项后，他会转为敌对。杀死他取得信件（必定掉落）。远离卫兵再战斗，否则卫兵可能抢走击杀，导致无法拾取；每次击杀只有一名潜行者能拿到信。他死亡后5分钟刷新。",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "回到{npc:6467}那里",

	-- Step 11: Andron Gant
	-- {npc:6522} Andron Gant
	["{npc:6522} is in the Apothecarium, in its biggest room, where two huge guards watch a small bridge. His ledger is on the bookshelf in the back room behind him, not the shelf on the wall next to him."] = "{npc:6522}在炼金房最大的一间房里，那里有两名高大守卫看守一座小桥。他的账本在他身后里间的书架上，不在他旁边墙上的架子上。",

	-- Step 12: Mennet Carkad and Varimathras
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras
	["{npc:6467} and {npc:2425}"] = "{npc:6467}与{npc:2425}",
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras · {object:36126} Royal Quarter · {npc:6522} Andron Gant
	["{npc:6467} sends the ledger on to {npc:2425}, the big demon in the middle of the Hall of the Dark Lady in the {object:36126}, past its elite guards; the way in is the passage off the Apothecarium. If you lose the ledger, take another from {npc:6522}'s bookshelf."] = "{npc:6467}会让你把账本继续送给{npc:2425}，就是{object:36126}中黑暗女王大厅中央的巨大恶魔，需要经过精英守卫；入口是炼金房旁的通道。若弄丢账本，可从{npc:6522}的书架再拿一本。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:2130}, the rogue trainer in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "10级时，{area:159}{area:2119}的潜行者训练师{npc:2130}会让你去{zone:1458}找{quest:1885}。",
	-- ["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}."] = "10级时，{area:362}的潜行者训练师{npc:3170}会让你去{zone:1454}找{quest:1859}。",
	-- ["Tazan"] = "塔赞",
	-- ["{item:7208}: Gamon"] = "{item:7208}：加摩尔",
	-- ["{item:7209}: Tazan"] = "{item:7209}：塔赞",
	-- ["{npc:6466} drinks in the inn in the {object:172982}. Pick his pocket for {item:7208}, then open {item:7209}."] = "{npc:6466}在{object:172982}的旅店里喝酒。从他身上偷取{item:7208}，然后打开{item:7209}。",
	-- ["{npc:6467} sends the ledger on to {npc:2425} in the Hall of the Dark Lady, the {object:36126}."] = "{npc:6467}会把账本转交给{object:36126}的{npc:2425}。",
	-- ["{npc:6494} stands on the {zone:1413} coast south of {area:392}. Kill him for his satchel."] = "{npc:6494}站在{area:392}南边的{zone:1413}海岸。杀死他拿到他的挎包。",
	-- ["{npc:6497} stands north-east of the {area:228}. Take his Letter of Introduction from him."] = "{npc:6497}站在{area:228}东北边。从他那里拿到阿斯托的介绍信。",
	-- ["{npc:6522}'s ledger sits on the bookshelf beside him."] = "{npc:6522}的账本放在他身旁的书架上。",
}
