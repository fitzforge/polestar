-- Chinese (simplified) (zhCN): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "雷霆崖声望",

	-- Step 1: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {faction:81} Thunder Bluff · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728}在{faction:81}收取布料以提升{faction:81}声望。首次捐献毛料、丝绸、魔纹布和{item:14047}（各60块）只能做一次，每块布给的声望最多；之后{quest:7825}可重复做到崇拜。与其他种族的主城达到崇拜后，可购买该种族的坐骑。Forever的传承外交官特权可提高声望获取。",

	-- Step 2: Wool Cloth
	-- {area:381} Boulder Lode Mine
	-- plural, as words: Venture Co. Enforcers = {npc:3283} Venture Co. Enforcer
	["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的风险投资公司执行者（16-17级）会掉落。也可以去拍卖行购买。",

	-- Step 4: Silk Cloth
	["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "这里的科卡尔半人马（30-33级）会掉落。也可以去拍卖行购买。",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "这里的砂槌食人魔（45-48级）会掉落。也可以去拍卖行购买。",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "这里的黑暗教徒和暗影法师（58-60级）会掉落；在这里击杀天灾军团也会提升{object:92525}声望（见该指南）。也可以去拍卖行购买。",

	-- Step 9: Rumstag Proudstrider: Runecloth delivered
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth
	["{npc:14728}: {item:14047} delivered"] = "{npc:14728}：已交付{item:14047}",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825}刷到尊敬",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825}每次交还需要20块{item:14047}，可无限重复。按20的倍数带上{item:14047}，一次接一次全部交还。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825}刷到崇敬",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7825}，每次20块{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825}刷到崇拜",
	-- {quest:7825} Additional Runecloth · {faction:81} Thunder Bluff · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7825}，直到{faction:81}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
}
