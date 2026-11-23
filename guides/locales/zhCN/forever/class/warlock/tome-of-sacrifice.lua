-- Chinese (simplified) (zhCN): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {zone:1419} Blasted Lands
	["A rare off-hand at 60, {npc:14463}'s payment for capturing a {npc:12396} in the {zone:1419}."] = "60级的稀有副手，是{npc:14463}对你在{zone:1419}捕获{npc:12396}的报酬。",

	-- Step 1: Daio the Decrepit
	-- {npc:14463} Daio the Decrepit · {area:73} Tainted Scar · {zone:1419} Blasted Lands
	["At 60 {npc:14463} waits in the {area:73}, the demon-filled hollow in the west of the {zone:1419}. The Scar is full of hard-hitting elites: Soulstone yourself first, then keep to the right-hand wall going in, or ride through mounted. {npc:14463} gives you two errands at once."] = "60级时，{npc:14463} 在 {zone:1419} 西部、恶魔遍布的洼地 {area:73} 等候。那里到处都是攻击很痛的精英：先给自己绑好灵魂石，再贴着右侧墙壁进去，或者骑坐骑冲过去。{npc:14463} 会同时给你两项差事。",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {item:18249} Crescent Key · {zone:1444} Feralas
	["The Wildspawn satyrs (level 55-57, elite) fill the Warpwood Quarter, {area:2577}'s eastern wing: bring a group of five. Four in five drop a blood, but they do not come back for two hours and one full clear may come up short of fifteen; reset and run it again. The back door at {area:2518} needs the {item:18249}, which drops inside this wing; until someone has it, go in by {area:2577}'s main gate in central {zone:1444}."] = "荒野萨特（55-57 级，精英）遍布 {area:2577} 东翼的扭木区：带上五人小队。大约每五只中有四只掉落一份血，但要两小时才会刷新，完整清一遍可能凑不齐十五份；重置后再来一次。{area:2518} 的后门需要 {item:18249}，钥匙就在这一区域掉落；队伍里有人拿到之前，从 {zone:1444} 中部的 {area:2577} 正门进入。",
	-- {item:18603} Satyr Blood
	["{item:18603}, from the Wildspawn inside"] = "{item:18603}，从内部的荒野系列敌人身上获得",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring · {spell:7645} Dominate Mind · {spell:710} Banish
	["The Hederine demons (level 57-60, elite) hold {area:2256} in the far south of {zone:1452}: grouping up is encouraged. Two Slayers guard the gorge past the bridge; the western tunnel leads to more Initiates, the easiest of them (watch for their {spell:7645}). A warlock can solo them one at a time with Fear or {spell:710} and damage over time, but slowly. Any of them can drop the Tears, four kills in five."] = "赫达琳恶魔（57—60级精英）占据了 {zone:1452} 最南端的 {area:2256}：建议组队。过桥后的峡谷由两名屠杀者把守；西侧隧道通往更多新兵，它们是其中最容易对付的（小心它们的 {spell:7645}）。术士可以用恐惧或 {spell:710} 配合持续伤害逐只单杀，但速度较慢。这些恶魔都可能掉落眼泪，掉率约为五分之四。",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {spell:45} War Stomp · {item:18605} Imprisoned Doomguard
	["Hand both in to {npc:14463} and take the {item:18601}. Find a {npc:12396} (level 61, elite) standing alone in the {area:73}, open from about 30 yards with your voidwalker on him, and channel the prison on him for about 20 seconds: he attacks you to break free, and his {spell:45} can interrupt the channel, so sacrifice the voidwalker for its shield if you must. Grouping up is encouraged: a second player to tank makes it easy. When the channel finishes he becomes the {item:18605}: click it. If the channel breaks, kill him or run, and try another."] = "把两样都交给 {npc:14463}，领取 {item:18601}。在 {area:73} 找一只落单的 {npc:12396}（61级精英），从约30码外让虚空行者攻击它，并对它引导监牢约20秒：它会攻击你以挣脱，{spell:45} 还可能打断引导，必要时牺牲虚空行者来获得护盾。建议组队：有另一位玩家扛住就很容易。引导完成后它会变成 {item:18605}：点击它。如果引导中断，就杀掉它或逃跑，再换一只尝试。",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on a {npc:12396}"] = "对 {npc:12396} 使用 {item:18601}",
	-- {item:18605} Imprisoned Doomguard
	["{item:18605}, click it"] = "{item:18605}，点击它",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "回到{npc:14463}处",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "60级时，{npc:14463}在{zone:1419}西部的{area:73}等候。",
	-- ["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "把两样都交给{npc:14463}，然后在{area:73}找到{npc:12396}，对他使用{item:18601}。他是精英，会奋力挣脱：建议组队。",
	-- ["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "赫达琳恶魔占据着{zone:1452}南部的{area:2256}。它们是精英：建议组队。",
	-- ["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "{area:2577}东区扭木广场的荒野萨特携带鲜血。{area:1099}以北{area:2518}的后门需要{item:18249}；否则从{area:2577}的正门进入。请带上小队。",
	-- ["{item:18601}, on the {npc:12396}"] = "对{npc:12396}使用{item:18601}",
	-- ["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}，在扭木广场内",
}
