-- Chinese (simplified) (zhCN): the guide forever/class/mage/staff-or-orb-alliance (forever/class/mage/staff-or-orb-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:9514} Arcane Staff
	["Ley or {item:9514} or Orb (Alliance)"] = "魔网、{item:9514}或宝珠（联盟）",
	["A staff or an off-hand orb at 10 from your home town's mage trainer; Skyborne add a wand."] = "10级时在主城的法师训练师处获得一根法杖或一个副手宝珠；天行者额外获得一根魔杖。",

	-- Step 1: Anathamaas Aetherwind (Valanaar)
	-- {npc:252373} Anathamaas Aetherwind · {area:16638} Valanaar · {npc:256507} Belann Windwood
	["At 10 {npc:252373}, the {area:16638} mage trainer, sends you to {npc:256507}, the staff merchant a few steps away in the same town."] = "10 级时，{area:16638}的法师训练师{npc:252373}会让你去找同镇几步外的法杖商人{npc:256507}。",

	-- Step 2: The Windstone Formations
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The Windstone Formations"] = "风石阵",
	-- {area:16636} Falaath Village
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["The bough lies on the ground among the Windstone Formations, the wind shrine on the rise west of Fillion's camp, south of {area:16636}. It does not sparkle, so look at the ground by the stones; there are two spots for it."] = "树枝落在风石阵之间的地面上，即菲里昂·炎风营地西侧高地、{area:16636}以南的风之神殿。它不会闪光，要仔细查看石块旁地面，共有两个刷新位置。",

	-- Step 3: Back to Belann Windwood
	-- {npc:256507} Belann Windwood
	["Back to {npc:256507}"] = "返回{npc:256507}处",
	-- {quest:1861} Mirror Lake · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{quest:1861} (the next steps) waits for you with {npc:5497} in {zone:1453}, at about 15."] = "约 15 级时，可在{zone:1453}向{npc:5497}接取{quest:1861}，接着按后续步骤完成。",

	-- Step 4: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire · {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {quest:1879} Speak with Bink · {area:131} Kharanos · {quest:1861} Mirror Lake · {npc:5144} Bink
	["At 10 {npc:328}, the {area:87} mage trainer, upstairs in the Lion's Pride Inn, sends you to {npc:5497} in {zone:1453}. Taking it shuts out {quest:1879}, the {area:131} trainer's errand; {quest:1861} and {npc:5144}'s Gizmonitor shut out each other, so you get one staff or orb."] = "",

	-- Step 5: Magis Sparkmantle (Kharanos)
	-- {npc:1228} Magis Sparkmantle · {area:131} Kharanos · {area:2102} Thunderbrew Distillery · {npc:5144} Bink · {zone:1455} Ironforge · {quest:1860} Speak with Jennea · {area:87} Goldshire · {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake · {npc:328} Zaldimar Wefhellt
	["At 10 {npc:1228}, the {area:131} mage trainer in the {area:2102}, sends you to {npc:5144} in {zone:1455}. Taking it shuts out {quest:1860}, the {area:87} trainer's errand; {npc:5144}'s Gizmonitor and {npc:5497}'s {quest:1861} shut out each other, so you get one staff or orb. (A Gnome who took {npc:328}'s quest in {area:87} instead follows the {quest:1861} steps; a Human who took this one, the Gizmonitor steps.)"] = "",

	-- Step 6: Jennea Cannon
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5497} Jennea Cannon · {item:7207} Jennea's Flask · {quest:1861} Mirror Lake
	["Follow the road north into {zone:1453} and west to the {object:2101}. {npc:5497} stands at the top of the Wizard's Sanctum, the tall violet tower: climb the spiral ramp and step into the portal near the top, which puts you beside her. She hands you {item:7207}. Skyborne mages take {quest:1861} from her when they first reach {zone:1453}, at about 15."] = "沿道路向北进入 {zone:1453}，再向西前往 {object:2101}。{npc:5497} 站在巫师圣殿的顶端，那是一座紫色高塔：沿螺旋坡道向上，走进接近塔顶处的传送门，就会来到她身边。她会给你 {item:7207}。天裔法师首次到达 {zone:1453} 时，大约15级，可向她接受 {quest:1861}。",

	-- Step 7: The Mirror Lake waterfall
	-- {quest:1861} Mirror Lake
	["The {quest:1861} waterfall"] = "{quest:1861}瀑布",
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate and head south-west to the waterfall that feeds {quest:1861}. Wade in under the falling water to the rock behind it and use {item:7207} there (a 5 second cast); it fails anywhere else. Level 10 Defias casters stand on the rocks either side of the falls and shoot from range: pull them one at a time or fill the flask from the water."] = "从正门离开{zone:1453}，向西南前往流入{quest:1861}的瀑布。涉水进入瀑布下方，贴到后方岩石，再使用{item:7207}，施法五秒；其他位置无效。瀑布两侧岩石上有 10 级迪菲亚施法者，会远程攻击，可逐个拉出，或从水中装满药瓶。",
	-- {item:7207} Jennea's Flask
	["{item:7207}, under the falls"] = "在瀑布下使用{item:7207}",

	-- Step 8: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "回到{npc:5497}那里",
	["Back up the Wizard's Sanctum and through the portal. The orb is an off-hand for a one-hand weapon; the staff is a two-hander."] = "再次登上巫师圣殿，通过传送门。宝珠是与单手武器搭配的副手物品，法杖则是双手武器。",
	-- {npc:5497} Jennea Cannon · {item:7508} Ley Orb · {item:9513} Ley Staff
	["{npc:5497}: {item:7508} or {item:9513}"] = "{npc:5497}：{item:7508}或{item:9513}",

	-- Step 9: Bink
	-- {npc:5144} Bink · {object:32362} Mystic Ward · {zone:1455} Ironforge · {object:32386} Hall of Mysteries
	["{npc:5144} teaches mages in the {object:32362}, at the back of {zone:1455} past the {object:32386}."] = "{npc:5144}在{zone:1455}深处、经过{object:32386}后的{object:32362}教导法师。",

	-- Step 10: Bink's Toolbox
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["Head west along the road to {area:133}. Just north of its entrance stand two huts; the toolbox is in the taller, eastern one, the hut with the lift: a small grey box on the ground floor, half under the table beside the lift. Leper Gnomes (level 8) guard the huts: pull them singly. There is only one toolbox and it takes 15 minutes to come back after someone opens it, so wait nearby if it is gone."] = "沿路向西前往{area:133}。入口北侧有两间小屋，工具箱在东侧较高、带升降梯的那间内，是底层桌子旁、半藏在桌下的小灰箱。8 级麻疯侏儒守卫小屋，逐个拉怪。工具箱只有一个，被打开后十五分钟刷新；如果没有，就在附近等候。",

	-- Step 11: Back to Bink
	-- {npc:5144} Bink
	["Back to {npc:5144}"] = "返回{npc:5144}",
	-- {npc:5144} Bink · {item:7507} Arcane Orb · {item:9514} Arcane Staff
	["{npc:5144}: {item:7507} or {item:9514}"] = "{npc:5144}：{item:7507}或{item:9514}",

	-- Step 12: Belann Windwood's wand (optional)
	-- {npc:256507} Belann Windwood
	["{npc:256507}'s wand (optional)"] = "{npc:256507} 的魔杖（可选）",
	-- {npc:256507} Belann Windwood · {area:16638} Valanaar · {zone:2521} Zephras Isle · {npc:252373} Anathamaas Aetherwind · {item:262668} Wind-Infused Bough · {area:16636} Falaath Village · {item:263430} Windbough Wand
	-- plural, as words: Windstone Formations = {object:697118} Windstone Formation
	["{npc:256507}'s quest is open to Human and Gnome mages too, if you ever visit {area:16638} on {zone:2521}, the Skyborne home: {npc:252373}, the town's mage trainer, sends you to {npc:256507} next door, who wants a {item:262668} from the ground by the Windstone Formations south of {area:16636}, for the {item:263430}. It does not shut out the staff or the orb."] = "人类和侏儒法师也能接受 {npc:256507} 的任务。如果你前往天裔的家园 {zone:2521} 上的 {area:16638}，镇上的法师训练师 {npc:252373} 会让你去找隔壁的 {npc:256507}。后者要你从 {area:16636} 南侧的风石阵附近地面拾取一个 {item:262668}，以换取 {item:263430}。这个任务不影响你获取法杖或宝珠。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:1228}, the {area:131} mage trainer in the {area:2102}, sends you to {npc:5144} in {zone:1455}. Taking it shuts out {npc:5497}'s {quest:1861}; you get one staff-or-orb quest. (A Gnome who took {npc:328}'s quest in {area:87} instead follows the {quest:1861} steps; a Human who took this one, the Gizmonitor steps.)"] = "10级时，{area:131} 的法师训练师 {npc:1228} 会从 {area:2102} 派你去 {zone:1455} 找 {npc:5144}。接受此任务后就无法接取 {npc:5497} 的 {quest:1861}；法杖或宝珠奖励任务只能选一条路线。（若侏儒接了 {area:87} 中 {npc:328} 的任务，则应按 {quest:1861} 的步骤进行；若人类接了这里的任务，则按 法师文档存储器 的步骤进行。）",
	-- ["At 10 {npc:328}, the {area:87} mage trainer, upstairs in the Lion's Pride Inn, sends you to {npc:5497} in {zone:1453}. Taking it shuts out {npc:5144}'s quest in {zone:1455}; you get one staff-or-orb quest."] = "10 级时，{area:87}法师训练师{npc:328}在狮王之傲旅店楼上，会让你前往{zone:1453}找{npc:5497}。接取后便无法再做{zone:1455}的{npc:5144}所提供的路线，法杖或宝珠任务只能选一条。",
}
