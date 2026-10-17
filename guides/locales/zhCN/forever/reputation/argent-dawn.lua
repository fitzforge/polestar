-- Chinese (simplified) (zhCN): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "银色黎明声望",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401}（联盟）",
	-- {object:2160} The Argent Dawn · {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始为中立。从{area:3197}的{npc:10840}处领取委任徽章并装备：在经典版中，只有装备了{quest:5401}饰品时才会掉落天灾石。Forever的传承外交官特权可提高声望获取。",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401}（部落）",
	-- {object:2160} The Argent Dawn · {npc:10839} Argent Officer Garush · {area:152} The Bulwark · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始为中立。从{area:152}的{npc:10839}处领取委任徽章并装备：在经典版中，只有装备了{quest:5401}饰品时才会掉落天灾石。Forever的传承外交官特权可提高声望获取。",

	-- Step 3: Minion's Scourgestones to Friendly
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones to Friendly"] = "用爪牙的天灾石刷到友善",
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {area:152} The Bulwark · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {item:12844} Argent Dawn Valor Token
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "{zone:1422}各处的食尸鬼和骷髅约有一半几率掉落爪牙的天灾石；这一片怪物密集。每20个交给任意一位银色黎明军官（{area:3197}的普尔哈特、{area:152}的加鲁什、{area:2268}的{npc:11039}）。每次交还还会得到一枚{item:12844}，可在银色黎明军需官处使用。",

	-- Step 4: Invader's Scourgestones to Honored
	-- plural, as words: Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Invader's Scourgestones to Honored"] = "用侵略者的天灾石刷到尊敬",
	-- {item:14047} Runecloth · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "这里的黑暗教徒和暗影法师（58-60级）掉落侵略者的天灾石，还有爪牙的天灾石和{item:14047}。把侵略者的天灾石每10个、爪牙的天灾石每20个交给{area:2268}的{npc:11039}。在经典版中，两者到尊敬后就不再给声望。",

	-- Step 5: Corruptor's Scourgestones and dungeons to Revered
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["Corruptor's Scourgestones and dungeons to Revered"] = "用堕落者的天灾石和地下城刷到崇敬",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {npc:1853} Darkmaster Gandling · {npc:10433} Marduk Blackpool · {npc:1852} Araj the Summoner · {zone:1422} Western Plaguelands
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "从尊敬开始，声望来自堕落者的天灾石（每次交还一个）和在{area:2279}、{area:2057}中击杀天灾军团。堕落者的天灾石由那里的天灾首领（{npc:1853}、{npc:10433}、维克图斯）以及{zone:1422}的{npc:1852}和普特迪乌斯掉落。多刷地下城比任何野外刷怪都快。",
	-- {area:2279} Stratholme · {area:2057} Scholomance
	["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "刷{area:2279}（两个区域）和{area:2057}，击杀沿途所有天灾军团。",

	-- Step 6: Argent Dawn to Exalted
	-- {faction:529} Argent Dawn
	["{faction:529} to Exalted"] = "{faction:529}刷到崇拜",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {item:12843} Corruptor's Scourgestone · {area:2268} Light's Hope Chapel
	["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "继续刷{area:2279}和{area:2057}，并在{area:2268}交还每一个{item:12843}，直到崇拜。",
}
