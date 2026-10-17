-- Chinese (simplified) (zhCN): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "海达希亚水元素声望",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {faction:749} Hydraxian Waterlords
	["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278}站在{zone:1447}东海岸外的一座小岛上；游过去或沿浅滩走过去。{faction:749}初始为中立。Forever的传承外交官特权可提高声望获取。",

	-- Step 2: Dust Stormers and Desert Rumblers
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers"] = "灰尘风暴和沙漠奔行者",
	-- {zone:1451} Silithus
	["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "这两种元素都在{zone:1451}西北部游荡；沙漠奔行者聚集在稍北一些的地方。",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {zone:1423} Eastern Plaguelands · {item:17309} Discordant Bracers
	["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "对{zone:1423}中被污染的水元素使用{item:17310}，然后拾取它们的{item:17309}（12个）。",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "回到{npc:13278}处",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {quest:6821} Eye of the Emberseer
	["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "黑石塔上层的{npc:9816}掉落{quest:6821}。需要一支团队。",

	-- Step 6: The Molten Core
	-- {npc:11668} Firelord · {npc:11658} Molten Giant · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {area:2717} Molten Core
	["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "在{area:2717}中击杀一个{npc:11668}、一个{npc:11658}、一只{npc:11673}和一个{npc:12101}。{area:2717}中的每个元素和首领也都会提升海达希亚水元素声望。",

	-- Step 7: Agent of Hydraxis
	-- {quest:6823} Agent of Hydraxis · {npc:13278} Duke Hydraxis · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {item:22754} Eternal Quintessence
	["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823}需要尊敬。尊敬时，{npc:13278}会给予{item:17333}，用来熄灭{area:2717}中的符文以召唤{npc:12018}；崇敬时给予可重复使用的{item:22754}。",

	-- Step 8: Hands of the Enemy
	-- {area:2717} Molten Core
	["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "从{area:2717}带回鲁西弗隆之手、基赫纳斯之手、沙斯拉尔之手和萨弗隆之手。",

	-- Step 9: Hydraxian Waterlords to Revered
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Revered"] = "{faction:749}刷到崇敬",
	-- {area:2717} Molten Core
	["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "剩下的靠通关{area:2717}。首领总能给声望；在经典版中，小怪到一定声望后就不再给海达希亚水元素声望，所以后期主要靠首领。",

	-- Step 10: Hydraxian Waterlords to Exalted
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Exalted"] = "{faction:749}刷到崇拜",
	-- {area:2717} Molten Core
	["Keep clearing the {area:2717} until Exalted."] = "继续通关{area:2717}，直到崇拜。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "对{zone:1423}中被污染的水元素使用{item:17310}，然后拾取它们的{item:17309}（12个）。我们的数据中没有这些元素的刷新点。",
	-- ["{npc:9816} in Upper {area:1583} drops the {quest:6821}. This needs a raid group."] = "{area:1583}上层的{npc:9816}掉落{quest:6821}。这需要团队。",
}
