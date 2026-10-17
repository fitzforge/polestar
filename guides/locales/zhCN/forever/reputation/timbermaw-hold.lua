-- Chinese (simplified) (zhCN): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "木喉要塞声望",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold
	["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576}初始为敌对，隧道里的熊怪会攻击你，直到你达到冷淡。每杀一只死木和冬泉熊怪都会提升声望，所以下面的任务等于双倍回报。Forever的传承外交官特权可提高声望获取。",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:11554} Grazle · {npc:15395} Nafien
	["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "死木熊怪（48-50级）在{zone:1448}南端扎营。保留它们掉落的每一根{item:21377}：{npc:11554}和{npc:15395}之后会收取。",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "回到{npc:11554}那里",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood · {faction:576} Timbermaw Hold
	["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395}在{zone:1448}北部通往{faction:576}的隧道口等候。",

	-- Step 5: Deadwood of the North
	["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "北部的死木熊怪（53-55级）占据着隧道南边不远处的营地。它们的羽毛也要保留。",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "回到{npc:15395}那里",

	-- Step 7: Salfa
	-- {faction:576} Timbermaw Hold · {zone:1452} Winterspring · {npc:11556} Salfa
	["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "穿过{faction:576}到达通往{zone:1452}的出口；{npc:11556}就站在外面。到目前为止的任务和击杀通常能达到冷淡，然后木喉熊怪就会放你通过。如果它们仍显示红色，先在隧道旁多杀些死木熊怪。",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {item:21383} Winterfall Spirit Beads · {npc:11556} Salfa
	["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244}位于{zone:1452}东侧。保留你拾取的每一个{item:21383}：{npc:11556}会收取。",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "回到{npc:11556}那里",

	-- Step 10: Feathers and beads to Friendly
	["Feathers and beads to Friendly"] = "用羽毛和珠串刷到友善",
	-- {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {item:21383} Winterfall Spirit Beads · {area:2244} Winterfall Village
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "“给{npc:11554}的羽毛”、“给{npc:15395}的羽毛”（{item:21377}）以及“给{npc:11556}的珠串”（{item:21383}）可以无限重复；每次击杀死木或冬泉熊怪也算数。{area:2244}是珠串最密集的地方。",
	-- {npc:11556} Salfa
	["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}：给{npc:11556}的珠串",

	-- Step 11: Feathers to Honored
	["Feathers to Honored"] = "用羽毛刷到尊敬",
	-- {npc:15395} Nafien · {npc:11554} Grazle
	["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "隧道旁的北部死木营地是羽毛最密集的地方（那里掉率35%）。把羽毛交给隧道口的{npc:15395}，或南边的{npc:11554}。",
	-- {npc:15395} Nafien
	["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}：给{npc:15395}的羽毛",

	-- Step 12: Timbermaw Hold to Revered
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Revered"] = "{faction:576}刷到崇敬",
	-- {npc:15395} Nafien · {npc:11556} Salfa
	["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "轮流上交死木羽毛（{npc:15395}）和冬泉珠串（{npc:11556}），哪个营地人少就去哪个。",

	-- Step 13: Timbermaw Hold to Exalted
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Exalted"] = "{faction:576}刷到崇拜",
	["Keep turning in feathers and beads until Exalted."] = "继续上交羽毛和珠串，直到崇拜。",
}
