-- Chinese (simplified) (zhCN): the guide forever/class/warlock/voidwalker-alliance (forever/class/warlock/voidwalker-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Alliance)"] = "虚空行者（联盟）",
	-- {npc:6122} Gakin the Darkbinder
	["Your tank demon at 10: the voidwalker, after a dark sorceress's choker and a fight in {npc:6122}'s crypt."] = "10级的坦克恶魔：虚空行者。先取得一名黑暗女巫的项圈，再到{npc:6122}的墓穴中打一场。",

	-- Step 1: Gakin's Summons (Humans)
	-- {quest:1685} Gakin's Summons
	["{quest:1685} (Humans)"] = "{quest:1685}（人类）",
	-- {npc:6121} Remen Marcot · {area:87} Goldshire · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["At 10 {npc:6121}, in the cellar of the Lion's Pride Inn in {area:87} (the stairs down are in the back room past the butcher's table), sends you to {npc:6122} in {zone:1453}."] = "达到 10 级后，{area:87} 狮王之傲旅店地窖中的 {npc:6121}（下楼梯在肉案后面的里屋）会让你去找 {zone:1453} 的 {npc:6122}。",
	-- {npc:6121} Remen Marcot
	["{npc:6121}, Lion's Pride Inn cellar"] = "{npc:6121}，狮王之傲旅店地窖。",

	-- Step 2: The Slaughtered Lamb (Gnomes)
	-- {quest:1715} The Slaughtered Lamb
	["{quest:1715} (Gnomes)"] = "{quest:1715}（侏儒）",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 10 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257} from {object:171524}. If {npc:6120} does not offer it, go to {npc:6122} anyway: he still gives you the next quest."] = "10级时，{zone:1455}的{object:32383}内的术士训练师{npc:6120}会派你去{zone:1453}找{npc:6122}。从{object:171524}搭乘{area:2257}。如果{npc:6120}不提供任务，仍然直接去找{npc:6122}：他依然会提供后续任务。",

	-- Step 3: Gakin the Darkbinder
	-- {quest:1715} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{quest:1715} is the tavern in the {object:2101}; {npc:6122} is in its cellar, down the stairs inside."] = "{quest:1715} 指的是 {object:2101} 的酒馆；{npc:6122} 在酒馆的地窖里，从店内楼梯下去即可。",

	-- Step 4: Surena Caledon
	-- {npc:881} Surena Caledon · {area:62} Brackwell Pumpkin Patch · {npc:473} Morgan the Collector
	["{npc:881} (level 9) is inside the farmhouse at the {area:62}, south-east Elwynn near the Redridge road. {npc:473} (level 10) and a warrior stand with her and join the fight; Morgan gouges and goes for your imp, so keep him Feared. Put your damage over time on {npc:881} first, Fear the others, and loot her choker before you finish them: it stays yours even if you die after. She throws fireballs from range and is back three minutes after she dies. Have the quest before you kill her, or the choker does not drop."] = "{npc:881}（9级）在艾尔文森林东南部 {area:62} 的农舍内，靠近通往赤脊山的道路。{npc:473}（10级）和一名战士在她身旁，会一起参战；摩根会使用凿击，并攻击你的小鬼，因此要持续恐惧他。先对 {npc:881} 施加持续伤害，恐惧其余敌人，并在解决他们之前拾取她的项圈：即使随后死亡，项圈也仍归你。她会在远处施放火球，死亡三分钟后刷新。必须先接任务再杀她，否则不会掉落项圈。",

	-- Step 5: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:6122}. He hands you the {item:6928}. The circle is hard to find: take the stairs behind {npc:6122} down; part way along the lowest corridor a side stair on the left leads into a room with a glowing purple circle in the middle. Stand on it and use the choker. The voidwalker (level 10, not elite) gets dangerous below 30% health: {spell:14868}, Corruption and {spell:348} with your imp on it, Fear when it gets close. If it beats you, use the choker again. Keep the choker: {npc:6122} takes it back."] = "返回 {npc:6122} 处。他会给你 {item:6928}。法阵不太好找：沿 {npc:6122} 身后的楼梯向下走；在最底层走廊中途，左侧一段楼梯通往一个房间，房间中央有发光的紫色法阵。站上去并使用项圈。虚空行者（10 级，非精英）在生命值低于 30% 时会变得危险：使用 {spell:14868}、腐蚀术和 {spell:348}，让小鬼攻击它；它靠近时使用恐惧术。若打输了，再次使用项圈。保留项圈：{npc:6122} 会收回它。",
	-- {item:6928} Bloodstone Choker
	["{item:6928}, on the circle in the crypt"] = "{item:6928}，在墓穴内的法阵上",
}
