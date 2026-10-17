-- Chinese (traditional) (zhTW): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "木喉要塞聲望",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold
	["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576}初始為敵對，在你達到冷淡之前，隧道裡的熊怪會攻擊你。擊殺的每一隻死木和冬泉熊怪都會提升聲望，所以下面的任務有雙重收益。Forever的傳承外交官天賦可提高聲望獲取。",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:11554} Grazle · {npc:15395} Nafien
	["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "死木熊怪（48-50級）在{zone:1448}南端紮營。留著牠們掉落的每一個{item:21377}：{npc:11554}和{npc:15395}之後會收。",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "返回{npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood · {faction:576} Timbermaw Hold
	["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395}在{zone:1448}北部通往{faction:576}的隧道口等著。",

	-- Step 5: Deadwood of the North
	["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "北方的死木熊怪（53-55級）佔據隧道南邊不遠的營地。牠們的羽毛也要留著。",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "返回{npc:15395}",

	-- Step 7: Salfa
	-- {faction:576} Timbermaw Hold · {zone:1452} Winterspring · {npc:11556} Salfa
	["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "穿過{faction:576}，到達通往{zone:1452}的出口；{npc:11556}就站在外面。到目前為止的任務和擊殺通常能達到冷淡，木喉熊怪就會讓你通過。如果牠們仍顯示紅色，先在隧道附近多殺些死木熊怪。",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {item:21383} Winterfall Spirit Beads · {npc:11556} Salfa
	["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "{area:2244}位於{zone:1452}東側。留著你拾取的每一個{item:21383}：{npc:11556}會收。",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "返回{npc:11556}",

	-- Step 10: Feathers and beads to Friendly
	["Feathers and beads to Friendly"] = "羽毛和念珠到友好",
	-- {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {item:21383} Winterfall Spirit Beads · {area:2244} Winterfall Village
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "給{npc:11554}的羽毛、給{npc:15395}的羽毛（死木頭飾羽毛）和給{npc:11556}的念珠（{item:21383}）可以無限次重複；每次擊殺死木或冬泉熊怪也會計入。{area:2244}是念珠最密集的地點。",
	-- {npc:11556} Salfa
	["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}：給{npc:11556}的念珠",

	-- Step 11: Feathers to Honored
	["Feathers to Honored"] = "羽毛到尊敬",
	-- {npc:15395} Nafien · {npc:11554} Grazle
	["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "隧道旁的北方死木營地是羽毛最密集的地點（那裡掉落率35%）。把羽毛交給隧道口的{npc:15395}，或南邊的{npc:11554}。",
	-- {npc:15395} Nafien
	["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}：給{npc:15395}的羽毛",

	-- Step 12: Timbermaw Hold to Revered
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Revered"] = "{faction:576}到崇敬",
	-- {npc:15395} Nafien · {npc:11556} Salfa
	["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "輪流收集死木羽毛（{npc:15395}）和冬泉念珠（{npc:11556}），看哪個營地人比較少。",

	-- Step 13: Timbermaw Hold to Exalted
	-- {faction:576} Timbermaw Hold
	["{faction:576} to Exalted"] = "{faction:576}到崇拜",
	["Keep turning in feathers and beads until Exalted."] = "持續繳交羽毛和念珠直到崇拜。",
}
