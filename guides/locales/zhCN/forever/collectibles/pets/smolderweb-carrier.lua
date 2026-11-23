-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/smolderweb-carrier (forever/collectibles/pets/smolderweb-carrier.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{area:251}的{npc:10260}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {item:12264} Worg Carrier
	["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He also gives {npc:10260}'s Exotic Pets (the {item:12264}): take both, they are done in the same run."] = "{npc:10260}站在{area:251}营地的洞穴中，营地位于{zone:1428}北部、{area:254}以东。他还提供{npc:10260}的特殊宠物任务（{item:12264}）：两个都接，一趟可以一起完成。",

	-- Step 2: Lower Blackrock Spire
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "{area:1583}下层",
	-- {area:1583} Blackrock Spire · {area:254} Blackrock Mountain · {npc:10596} Mother Smolderweb
	-- plural, as words: Spire Spider Eggs = {item:12530} Spire Spider Egg
	["Lower {area:1583} is a group of five, level 55-60, inside {area:254}. The Spire Spider Eggs lie around {npc:10596}'s nest in the Skitterweb Tunnels, the spider halls: click them until you have 15 (each gives one to three). Hard-hitting spiderlings can hatch as you loot. By player reports the eggs cannot be looted in a raid group, so keep the party at five or fewer."] = "{area:1583} 下层是位于 {area:254} 内、适合 55-60 级的五人地下城。尖塔蜘蛛卵分布在蛛网隧道蜘蛛大厅内的 {npc:10596} 巢穴周围：持续点击，直到收集到 15 个（每次可获得一至三个）。拾取时可能会孵出伤害很高的小蜘蛛。据玩家报告，团队状态下无法拾取蜘蛛卵，因此队伍人数要保持在五人或以下。",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "回到{npc:10260}处",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Lower {area:1583} is a group of five, level 55-60. Collect 15 Spire Spider Eggs from the nests near {npc:10596}."] = "{area:1583}下层是五人小队地下城，55-60级。在{npc:10596}附近的巢穴中收集15个{item:12530}。",
	-- ["Lower {area:1583} is a group of five, level 55-60. Collect 15 {npc:10374} Eggs from the nests near {npc:10596}."] = "{area:1583}下层是五人小队副本，55-60级。在{npc:10596}附近的巢穴中收集15个{npc:10374}卵。",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260}站在{zone:1428}北部的{area:251}，靠近通往{area:254}的路。",
}
