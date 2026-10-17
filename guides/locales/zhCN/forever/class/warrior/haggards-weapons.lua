-- Chinese (simplified) (zhCN): the guide forever/class/warrior/haggards-weapons (forever/class/warrior/haggards-weapons.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Haggard's Weapons"] = "哈迦德的武器",
	-- {spell:71} Defensive Stance
	["{spell:71} and a one-hand weapon of your choice at 10."] = "10级获得{spell:71}和一把自选的单手武器。",

	-- Step 1: Defensive Stance
	-- {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["{npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为他的杯子和你打一架。",

	-- Step 2: Marshal Haggard
	-- {npc:294} Marshal Haggard · {zone:1429} Elwynn Forest · {zone:1453} Stormwind
	["{npc:294}'s house is in eastern {zone:1429}, south of the road from {zone:1453} to Redridge."] = "{npc:294}的房子在{zone:1429}东部，位于{zone:1453}通往赤脊山的道路以南。",

	-- Step 3: Dead-tooth Jack
	-- {npc:6093} Dead-Tooth Jack · {zone:1429} Elwynn Forest · {npc:294} Marshal Haggard
	["{npc:6093} camps in the far south-east of {zone:1429}, south-east of {npc:294}. He carries the key to the strongbox in his camp."] = "{npc:6093}在{zone:1429}最东南端扎营，位于{npc:294}东南。他带着营地里保险箱的钥匙。",
	-- {npc:6093} Dead-Tooth Jack
	["{npc:6093}: his key opens the strongbox"] = "{npc:6093}：他的钥匙能打开保险箱",

	-- Step 4: Back to Marshal Haggard
	-- {npc:294} Marshal Haggard
	["Back to {npc:294}"] = "回到{npc:294}处",
}
