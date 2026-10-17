-- Chinese (simplified) (zhCN): the guide forever/class/warlock/tome-of-sacrifice (forever/class/warlock/tome-of-sacrifice.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["At 60 {npc:14463} waits in the {area:73}, in western {zone:1419}."] = "60级时，{npc:14463}在{zone:1419}西部的{area:73}等候。",

	-- Step 2: Satyr Blood
	-- {area:2577} Dire Maul · {area:2518} Lariss Pavilion · {area:1099} Camp Mojache · {item:18249} Crescent Key
	["The Wildspawn satyrs of the Warpwood Quarter, {area:2577}'s eastern wing, carry the blood. The back door at {area:2518}, north of {area:1099}, needs the {item:18249}; otherwise go in by {area:2577}'s main entrance. Bring a group."] = "{area:2577}东区扭木广场的荒野萨特携带鲜血。{area:1099}以北{area:2518}的后门需要{item:18249}；否则从{area:2577}的正门进入。请带上小队。",
	-- {item:18603} Satyr Blood
	["{item:18603}, inside the Warpwood Quarter"] = "{item:18603}，在扭木广场内",

	-- Step 3: Tears of the Hederine
	-- {area:2256} Darkwhisper Gorge · {zone:1452} Winterspring
	["The Hederine demons hold {area:2256}, in southern {zone:1452}. They are elite: grouping up is advised."] = "赫达琳恶魔占据着{zone:1452}南部的{area:2256}。它们是精英：建议组队。",

	-- Step 4: Suppression
	-- {npc:14463} Daio the Decrepit · {npc:12396} Doomguard Commander · {area:73} Tainted Scar · {item:18601} Glowing Crystal Prison
	["Hand both in to {npc:14463}, then find the {npc:12396} in the {area:73} and use the {item:18601} on him. He is elite and fights to escape: grouping up is advised."] = "把两样都交给{npc:14463}，然后在{area:73}找到{npc:12396}，对他使用{item:18601}。他是精英，会奋力挣脱：建议组队。",
	-- {item:18601} Glowing Crystal Prison · {npc:12396} Doomguard Commander
	["{item:18601}, on the {npc:12396}"] = "对{npc:12396}使用{item:18601}",

	-- Step 5: Back to Daio the Decrepit
	-- {npc:14463} Daio the Decrepit
	["Back to {npc:14463}"] = "回到{npc:14463}处",
}
