-- Chinese (traditional) (zhTW): the guide forever/class/warlock/voidwalker-alliance (forever/class/warlock/voidwalker-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Alliance)"] = "虛空行者（聯盟）",
	-- {npc:6122} Gakin the Darkbinder
	["Your tank demon at 10: the voidwalker, after a dark sorceress's choker and a fight in {npc:6122}'s crypt."] = "10級的坦克惡魔：虛空行者。先取得一名黑暗女巫的項圈，再到{npc:6122}的墓穴中打一場。",

	-- Step 1: Gakin's Summons (Humans)
	-- {quest:1685} Gakin's Summons
	["{quest:1685} (Humans)"] = "{quest:1685}（人類）",
	-- {npc:6121} Remen Marcot · {area:87} Goldshire · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["At 10 {npc:6121}, in the cellar of the Lion's Pride Inn in {area:87} (the stairs down are in the back room past the butcher's table), sends you to {npc:6122} in {zone:1453}."] = "10級時，{area:87}獅王之傲旅店地窖裡的{npc:6121}（下去的樓梯在裡屋、經過屠夫的桌子）會讓你去找{zone:1453}的{npc:6122}。",
	-- {npc:6121} Remen Marcot
	["{npc:6121}, Lion's Pride Inn cellar"] = "{npc:6121}，獅王之傲旅店地窖",

	-- Step 2: The Slaughtered Lamb (Gnomes)
	-- {quest:1715} The Slaughtered Lamb
	["{quest:1715} (Gnomes)"] = "{quest:1715}（地精）",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 10 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257} from {object:171524}. If {npc:6120} does not offer it, go to {npc:6122} anyway: he still gives you the next quest."] = "10級時，{zone:1455}的{object:32383}裡的術士訓練師{npc:6120}會讓你去找{zone:1453}的{npc:6122}。從{object:171524}乘{area:2257}過去。如果{npc:6120}沒有給你任務，也直接去找{npc:6122}：他照樣會給你下一個任務。",

	-- Step 3: Gakin the Darkbinder
	-- {quest:1715} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{quest:1715} is the tavern in the {object:2101}; {npc:6122} is in its cellar, down the stairs inside."] = "{quest:1715}是{object:2101}裡的旅店；{npc:6122}在其地窖，從裡面樓梯下去。",

	-- Step 4: Surena Caledon
	-- {npc:881} Surena Caledon · {area:62} Brackwell Pumpkin Patch · {npc:473} Morgan the Collector
	["{npc:881} (level 9) is inside the farmhouse at the {area:62}, south-east Elwynn near the Redridge road. {npc:473} (level 10) and a warrior stand with her and join the fight; Morgan gouges and goes for your imp, so keep him Feared. Put your damage over time on {npc:881} first, Fear the others, and loot her choker before you finish them: it stays yours even if you die after. She throws fireballs from range and is back three minutes after she dies. Have the quest before you kill her, or the choker does not drop."] = "{npc:881}（9級）在{area:62}的農舍裡，位於艾爾文森林東南、靠近赤脊山道路。{npc:473}（10級）和一名戰士與她站在一起，會加入戰鬥；摩根會鑿擊並攻擊你的小鬼，所以讓他一直處於恐懼狀態。先給{npc:881}上持續傷害，恐懼其他人，在解決他們之前先拾取她的項圈：即便之後你死了，項圈也歸你。她從遠處扔火球，死後三分鐘重新出現。殺她之前要先接到任務，否則項圈不會掉落。",

	-- Step 5: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:6122}. He hands you the {item:6928}. The circle is hard to find: take the stairs behind {npc:6122} down; part way along the lowest corridor a side stair on the left leads into a room with a glowing purple circle in the middle. Stand on it and use the choker. The voidwalker (level 10, not elite) gets dangerous below 30% health: {spell:14868}, Corruption and {spell:348} with your imp on it, Fear when it gets close. If it beats you, use the choker again. Keep the choker: {npc:6122} takes it back."] = "回到{npc:6122}。他把{item:6928}交給你。法陣很難找：走{npc:6122}身後的樓梯下去；走到最底層走廊的中段，左側有一條側梯通向一箇中間有發光紫色法陣的房間。站在法陣上使用項圈。虛空行者（10級，非精英）血量低於30%時很危險：讓小鬼攻擊它，用{spell:14868}、腐蝕術和{spell:348}，它靠近時用恐懼。如果它打敗你，再用一次項圈。項圈要留著：{npc:6122}會收回。",
	-- {item:6928} Bloodstone Choker
	["{item:6928}, on the circle in the crypt"] = "{item:6928}，在墓穴的法陣上",
}
