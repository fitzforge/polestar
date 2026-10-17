-- Chinese (simplified) (zhCN): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "塞纳里奥议会声望",

	-- Step 1: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {npc:15270} Huum Wildmane · {faction:609} Cenarion Circle
	["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425}是{zone:1451}中北部有城墙的城镇。博尔和{npc:15270}一起站在里面。{faction:609}初始为中立。Forever的传承外交官特权可提高声望获取。",
	-- {quest:8320} Twilight Geolords
	["{quest:8320} needs level 60"] = "{quest:8320}需要60级",

	-- Step 2: Twilight Base Camp
	-- {zone:1451} Silithus · {quest:8320} Twilight Geolords · {item:20404} Encrypted Twilight Text · {faction:609} Cenarion Circle
	["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "暮光之锤的信徒占据着{zone:1451}西部的营地。{quest:8320}和暮光唤石者混在这里；任何信徒都可能掉落{item:20404}。每次击杀信徒也会提升{faction:609}声望。只有你60级并接了{quest:8320}时，击杀暮光地王才算数。",

	-- Step 3: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "回到{area:3425}",

	-- Step 4: Encrypted Twilight Texts to Friendly
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts to Friendly"] = "用{item:20404}刷到友善",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "“暮光密文信”可重复：{npc:15306}会一次又一次收取更多密文。信徒营地就是刷它们的地方。",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}：暮光密文信",

	-- Step 5: Cenarion Circle to Honored
	-- {faction:609} Cenarion Circle
	["{faction:609} to Honored"] = "{faction:609}刷到尊敬",
	-- {npc:15282} Aurel Goldleaf · {npc:15306} Bor Wildmane
	-- plural, as words: Wind Stones = {object:180461} Wind Stone · Abyssal Crests = {item:20513} Abyssal Crest
	["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "继续刷暮光营地。穿上暮光信徒套装并带上暮光信徒身份勋章（来自{npc:15282}的“身份勋章”任务），就能在{object:180461}召唤深渊圣殿骑士；它们的{item:20513}交给{npc:15306}。",

	-- Step 6: Cenarion Circle to Revered
	-- {faction:609} Cenarion Circle
	["{faction:609} to Revered"] = "{faction:609}刷到崇敬",
	-- {area:3454} Ruins of Ahn'Qiraj
	["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "从这里开始，{area:3454}团队副本和深渊议会的上交物品（纹章、徽记、节杖）提供大部分声望。",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Abyssal Crests = {item:20513} Abyssal Crest · Abyssal Signets = {item:20514} Abyssal Signet · Abyssal Scepters = {item:20515} Abyssal Scepter
	["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "完成初始任务后，{item:20513}、{item:20514}和{item:20515}都可以在{npc:15306}处重复上交。",

	-- Step 7: Cenarion Circle to Exalted
	-- {faction:609} Cenarion Circle
	["{faction:609} to Exalted"] = "{faction:609}刷到崇拜",
	-- {area:3454} Ruins of Ahn'Qiraj
	["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "继续刷{area:3454}并上交深渊议会的徽章，直到崇拜。",
}
