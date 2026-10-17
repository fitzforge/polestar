-- Chinese (traditional) (zhTW): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "開啟{area:3486}（奧特蘭克丘陵中隱藏的盜賊據點）及其最初的任務。",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "{npc:13936}聲望",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "{item:17126}",
	-- {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad
	["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "24級時，{npc:13936}的{item:17126}會開啟此任務；依資料，你會透過{zone:1453}的{npc:332}或{npc:918}，或{zone:1454}的蓋斯特或奧莫克收到它。任務會給你{item:17125}，交給{npc:6707}。",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {zone:1416} Alterac Mountains
	["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "部落飛往{area:272}，聯盟飛往{area:271}。莊園隱藏在{area:272}東邊的山丘中，沿小路往上進入{zone:1416}；狡詐儀式是你進入的通行方式。",
	["Rite of Cunning"] = "狡詐儀式",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766}：{quest:6701}，可重複",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {area:287} Hillsbrad · {npc:13085} Myrokos Silentform
	["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216}在{area:275}內，那是{area:287}東部、莊園南邊的辛迪加要塞。{npc:13085}說：要快又要安靜。",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains
	["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "36級時，{npc:13085}派你去取巴爾頓的偵察報告。巴爾頓率領一支辛迪加隊伍在{zone:1416}東部的{area:280}：偷他的口袋，不要殺他。",
	-- {item:275482} Barton's Scouting Report
	["{item:275482}: pickpocket Barton"] = "{item:275482}：對巴爾頓偷竊",

	-- Step 6: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "返回{npc:13085}",
}
