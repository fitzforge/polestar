-- Chinese (traditional) (zhTW): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "銀色黎明聲望",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401}（聯盟）",
	-- {object:2160} The Argent Dawn · {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始為中立。向{area:3197}的{npc:10840}領取委任狀並裝備：在經典版中，只有裝備{quest:5401}飾品時才會掉落天譴石。Forever的傳承外交官天賦可提高聲望獲取。",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401}（部落）",
	-- {object:2160} The Argent Dawn · {npc:10839} Argent Officer Garush · {area:813} The Bulwark · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:813} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160}初始為中立。向{area:813}的{npc:10839}領取委任狀並裝備：在經典版中，只有裝備{quest:5401}飾品時才會掉落天譴石。Forever的傳承外交官天賦可提高聲望獲取。",

	-- Step 3: Minion's Scourgestones to Friendly
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones to Friendly"] = "爪牙的天譴石到友好",
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {area:813} The Bulwark · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {item:12844} Argent Dawn Valor Token
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:813}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "{zone:1422}各處的食屍鬼和骷髏約有一半機率掉落爪牙的天譴石；這一帶很密集。每次20個交給任一銀色黎明軍官（{area:3197}的普爾哈特、{area:813}的加魯什、{area:2268}的{npc:11039}）。每次繳交也會得到一個{item:12844}，可在銀色黎明軍需官處使用。",

	-- Step 4: Invader's Scourgestones to Honored
	-- plural, as words: Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Invader's Scourgestones to Honored"] = "侵略者的天譴石到尊敬",
	-- {item:14047} Runecloth · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落侵略者的天譴石，還有爪牙的天譴石和{item:14047}。侵略者的每次10個、爪牙的每次20個交給{area:2268}的{npc:11039}。在經典版中，兩者到尊敬後就不再提供聲望。",

	-- Step 5: Corruptor's Scourgestones and dungeons to Revered
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["Corruptor's Scourgestones and dungeons to Revered"] = "墮落者的天譴石與地城到崇敬",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {npc:1853} Darkmaster Gandling · {npc:10433} Marduk Blackpool · {npc:1852} Araj the Summoner · {zone:1422} Western Plaguelands
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "從尊敬開始，墮落者的天譴石（每次繳交一個）和在{area:2279}及{area:2057}擊殺天譴軍團可提升聲望。墮落者的天譴石由那裡的天譴首領（{npc:1853}、{npc:10433}、維克圖斯）以及{zone:1422}的{npc:1852}和普特迪烏斯掉落。多跑地城比任何野外刷怪都快。",
	-- {area:2279} Stratholme · {area:2057} Scholomance
	["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "跑{area:2279}（兩個區域）和{area:2057}，擊殺沿途每一隻天譴軍團。",

	-- Step 6: Argent Dawn to Exalted
	-- {faction:529} Argent Dawn
	["{faction:529} to Exalted"] = "{faction:529}到崇拜",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {item:12843} Corruptor's Scourgestone · {area:2268} Light's Hope Chapel
	["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "持續跑{area:2279}和{area:2057}，並在{area:2268}繳交每一個{item:12843}，直到崇拜。",
}
