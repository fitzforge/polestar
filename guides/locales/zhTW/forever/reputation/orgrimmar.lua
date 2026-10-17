-- Chinese (traditional) (zhTW): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "奧格瑪聲望",

	-- Step 1: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {faction:76} Orgrimmar · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726}在{faction:76}收取布料以提升{faction:76}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7832}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",

	-- Step 2: Wool Cloth
	-- {area:381} Boulder Lode Mine
	-- plural, as words: Venture Co. Enforcers = {npc:3283} Venture Co. Enforcer
	["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的風險投資公司執行者（16-17級）在這裡會掉落。拍賣場也買得到。",

	-- Step 4: Silk Cloth
	["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "科卡爾半人馬（30-33級）在這裡會掉落。拍賣場也買得到。",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",

	-- Step 9: Rashona Straglash: Runecloth delivered
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth
	["{npc:14726}: {item:14047} delivered"] = "{npc:14726}：{item:14047}已交付",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832}到尊敬",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832}到崇敬",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7832}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832}到崇拜",
	-- {quest:7832} Additional Runecloth · {faction:76} Orgrimmar · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7832}，直到{faction:76}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
