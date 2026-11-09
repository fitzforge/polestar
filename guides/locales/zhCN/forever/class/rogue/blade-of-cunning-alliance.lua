-- Chinese (simplified) (zhCN): the guide forever/class/rogue/blade-of-cunning-alliance (forever/class/rogue/blade-of-cunning-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Alliance)"] = "{item:7298}（联盟）",
	["A dagger at 10 from your home town's rogue quests."] = "10级时来自你家乡潜行者任务的匕首。",

	-- Step 1: Seek out SI: 7
	-- {npc:917} Keryn Sylvius · {area:87} Goldshire · {npc:332} Master Mathias Shaw · {zone:1453} Stormwind · {spell:921} Pick Pocket
	["At 10 {npc:917}, the rogue trainer upstairs in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}. Train {spell:921} if you lack it: this chain needs it."] = "10级时，{area:87} 狮王之傲旅店楼上的盗贼训练师 {npc:917} 会给你一个包裹，要交给 {zone:1453} 的 {npc:332}。如果还没学会 {spell:921}，就先学习：这条任务线会用到它。",

	-- Step 2: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north to {zone:1453}. Shaw stands upstairs in the SI:7 building in {object:2100} (the quest says the Barracks; it means SI:7)."] = "向北前往 {zone:1453}。肖尔在 {object:2100} 的军情七处建筑楼上（任务写的是兵营，实际指军情七处）。",

	-- Step 3: Defias Dockmaster
	-- {npc:6846} Defias Dockmaster · {area:797} Jerod's Landing · {area:87} Goldshire · {spell:921} Pick Pocket · {spell:2070} Sap
	["The {npc:6846} (level 10, a goblin) works in the dock house at {area:797}, on the river at Elwynn's southern edge, south of {area:87}. Stealth in and {spell:921} him from behind: the schedule never drops from his corpse. Do not open with {spell:2070} or a fight: he calls in three waves of bodyguards. Keep away from the fireplaces in the house; they burn you out of stealth. He is back 2 to 5 minutes after a death."] = "{npc:6846}（10级，地精）在 {area:797} 的码头屋内工作，位于艾尔文森林南缘的河边、{area:87} 以南。潜行进去，从背后对他使用 {spell:921}：他的尸体绝不会掉落日程表。不要先用 {spell:2070}，也不要开战：他会叫来三波保镖。远离屋内壁炉，否则会被烧出潜行。死亡后他会在2到5分钟内刷新。",
	-- {spell:921} Pick Pocket · {npc:6846} Defias Dockmaster · {item:7675} Defias Shipping Schedule
	["{spell:921} the {npc:6846} for the {item:7675}"] = "对{npc:6846}使用{spell:921}，获得{item:7675}",

	-- Step 4: Back to Mathias Shaw
	["Back to Mathias Shaw"] = "回到马迪亚斯·肖尔处",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7"] = "{npc:332}，军情七处",

	-- Step 5: Road to Salvation
	-- {npc:1234} Hogral Bakkan · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 10 {npc:1234}, the rogue trainer in the {area:2102} in {area:131}, sends you to {npc:5165} in {zone:1455}."] = "10级时，{area:131}{area:2102}的潜行者训练师{npc:1234}会让你去找{zone:1455}的{npc:5165}。",

	-- Step 6: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {object:32383} Forlorn Cavern · {zone:1455} Ironforge
	["{npc:5165} is in the {object:32383}, the rogue quarter in the north of {zone:1455}: go into the building with a shady dealer outside and down the stairs."] = "{npc:5165}在{zone:1455}北部的盗贼区{object:32383}：进入门外站着一名可疑商人的建筑，然后下楼。",

	-- Step 7: Onin MacHammar
	-- {area:133} Gnomeregan · {npc:6886} Onin MacHammar · {npc:1211} Leper Gnome
	["Head west to {area:133}. Beside the road to its entrance stands a wooden spiral tower: {npc:6886} waits stealthed on the top platform, next to a level 10 {npc:1211}, so you only see him up close."] = "向西前往{area:133}。通往入口的路旁有一座木制螺旋塔：{npc:6886}潜行待在顶部平台，旁边有一名10级的{npc:1211}，所以只有靠近才能看见他。",

	-- Step 8: Back to Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard
	["Back to {npc:5165}"] = "回到{npc:5165}处",

	-- Step 9: The Apple Falls
	-- {npc:3599} Jannok Breezesong · {area:186} Dolanaar · {npc:4163} Syurna · {zone:1457} Darnassus
	["At 10 {npc:3599}, the rogue trainer in the {area:186} inn, gives you a rose for {npc:4163} in {zone:1457}. If you lose the rose, abandon the quest and take it again."] = "10级时，{area:186} 旅店内的盗贼训练师 {npc:3599} 会给你一朵玫瑰，要交给 {zone:1457} 的 {npc:4163}。如果丢了玫瑰，就放弃任务再重接。",

	-- Step 10: Syurna
	-- {zone:1457} Darnassus · {npc:4163} Syurna · {area:1658} Cenarion Enclave
	["Head west to {zone:1457}. {npc:4163} is below ground in the {area:1658}: the way down is the opening at the foot of the split tree left of the Arch Druid's tree, near the nightsaber trainer. Her map marker shows above ground."] = "向西前往{zone:1457}。{npc:4163}在{area:1658}的地下：下去的入口在大德鲁伊所在树木左侧、那棵分叉树的根部，靠近夜刃豹训练师。她的地图标记显示在地面上。",

	-- Step 11: Sethir the Ancient
	-- {npc:6909} Sethir the Ancient · {area:264} Oracle Glade · {spell:2983} Sprint
	["{npc:6909} (level 12 satyr) lives out on a great branch north of the {area:264}: go through the V-shaped gap in the wall north of the glade and out along the branch. Pick his pocket for the journal; killing him does not give it, and a fight brings out three Minions of Sethir. He walks between the main branch and a side branch: wait stealthed at the far end of the main branch and pick him from behind when he comes back. Then {spell:2983} away. He is back 8 1/2 minutes after a death."] = "{npc:6909} 是12级萨特，住在 {area:264} 北面的巨大树枝上：穿过林地北侧墙上的V形缺口，沿树枝往外走。对他使用偷窃来取得日记；击杀不会掉落，开战还会引来三个塞希尔的爪牙。他会在主树枝和一根侧枝之间走动：潜行到主树枝远端等待，等他回来时从背后偷窃，然后用 {spell:2983} 跑开。他死亡后8分半刷新。",
	-- {item:7737} Sethir's Journal
	["Pick Pocket Sethir the Ancient for {item:7737}"] = "对远古者塞希尔使用搜索，获得{item:7737}",

	-- Step 12: Back to Syurna
	-- {npc:4163} Syurna
	["Back to {npc:4163}"] = "回到{npc:4163}处",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:3599}, the rogue trainer in {area:186}, gives you a rose for {npc:4163} in {zone:1457}."] = "10级时，{area:186}的潜行者训练师{npc:3599}会给你一朵玫瑰，交给{zone:1457}的{npc:4163}。",
	-- ["At 10 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}."] = "10级时，{area:87}Lion's Pride Inn的潜行者训练师{npc:917}会给你一个包裹，交给{zone:1453}的{npc:332}。",
	-- ["Ride north to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "向北骑行到{zone:1453}；马迪亚斯·肖尔在{object:2100}的军情七处。",
	-- ["Ride west to {zone:1457}. {npc:4163} stands in the north-west of the city."] = "向西骑行到{zone:1457}。{npc:4163}站在城市西北部。",
	-- ["The {npc:6846} stands by the river at Elwynn's southern edge, south of {area:87}. He carries the shipping schedule."] = "{npc:6846}站在艾尔文森林南缘的河边，{area:87}南边。他带着货运时间表。",
	-- ["{npc:5165} stands in the north of {zone:1455}."] = "{npc:5165}站在{zone:1455}北部。",
	-- ["{npc:6886} waits near {area:133}, in western {zone:1426}."] = "{npc:6886}在{zone:1426}西部的{area:133}附近等候。",
	-- ["{npc:6909} lives in the north of {zone:1438}, north-east of {zone:1457}. Take his journal."] = "{npc:6909}住在{zone:1438}北部，{zone:1457}东北方。拿走他的日记。",
}
