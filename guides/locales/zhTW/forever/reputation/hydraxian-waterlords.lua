-- Chinese (traditional) (zhTW): the guide forever/reputation/hydraxian-waterlords (forever/reputation/hydraxian-waterlords.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Hydraxian Waterlords Reputation"] = "海達希亞水元素聲望",

	-- Step 1: Duke Hydraxis
	-- {npc:13278} Duke Hydraxis · {zone:1447} Azshara · {faction:749} Hydraxian Waterlords
	["{npc:13278} stands on a small island off the eastern coast of {zone:1447}; swim or walk the shallows out to him. The {faction:749} start out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:13278}站在{zone:1447}東海岸外的一座小島上；游泳或涉過淺灘到他那裡。{faction:749}一開始是中立。Forever的傳承外交官天賦可提高聲望獲取。",

	-- Step 2: Dust Stormers and Desert Rumblers
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["Dust Stormers and Desert Rumblers"] = "灰塵風暴與沙漠奔行者",
	-- {zone:1451} Silithus
	["Both elementals roam north-western {zone:1451}; the Rumblers cluster a little further north."] = "這兩種元素都在{zone:1451}西北部遊蕩；沙漠奔行者聚集在稍微更北的地方。",

	-- Step 3: Poisoned Water
	-- {item:17310} Aspect of Neptulon · {zone:1423} Eastern Plaguelands · {item:17309} Discordant Bracers
	["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12)."] = "對{zone:1423}中毒的水元素使用{item:17310}，然後拾取牠們的{item:17309}（12個）。",

	-- Step 4: Back to Duke Hydraxis
	-- {npc:13278} Duke Hydraxis
	["Back to {npc:13278}"] = "返回{npc:13278}",

	-- Step 5: Eye of the Emberseer
	-- {npc:9816} Pyroguard Emberseer · {quest:6821} Eye of the Emberseer
	["{npc:9816} in Upper Blackrock Spire drops the {quest:6821}. This needs a raid group."] = "黑石塔上層的{npc:9816}會掉落{quest:6821}。這需要團隊。",

	-- Step 6: The Molten Core
	-- {npc:11668} Firelord · {npc:11658} Molten Giant · {npc:11673} Ancient Core Hound · {npc:12101} Lava Surger · {area:2717} Molten Core
	["Kill a {npc:11668}, a {npc:11658}, an {npc:11673} and a {npc:12101} in the {area:2717}. Every {area:2717} elemental and boss also counts toward the Waterlords."] = "在{area:2717}擊殺一個{npc:11668}、一個{npc:11658}、一個{npc:11673}和一個{npc:12101}。{area:2717}的每個元素和首領也都會計入此聲望。",

	-- Step 7: Agent of Hydraxis
	-- {quest:6823} Agent of Hydraxis · {npc:13278} Duke Hydraxis · {item:17333} Aqual Quintessence · {area:2717} Molten Core · {npc:12018} Majordomo Executus · {item:22754} Eternal Quintessence
	["{quest:6823} needs Honored. At Honored, {npc:13278} hands out {item:17333}, used to douse the runes in the {area:2717} that summon {npc:12018}; at Revered, the reusable {item:22754}."] = "{quest:6823}需要尊敬。達到尊敬時，{npc:13278}會發放{item:17333}，用來熄滅{area:2717}中召喚{npc:12018}的符文；達到崇敬時則給可重複使用的{item:22754}。",

	-- Step 8: Hands of the Enemy
	-- {area:2717} Molten Core
	["Bring the Hands of Lucifron, Gehennas, Shazzrah and Sulfuron from the {area:2717}."] = "帶回{area:2717}的魯西弗隆之手、基赫納斯之手、沙斯拉爾之手和薩弗隆之手。",

	-- Step 9: Hydraxian Waterlords to Revered
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Revered"] = "{faction:749}到崇敬",
	-- {area:2717} Molten Core
	["{area:2717} clears carry the rest. Bosses always count; in Classic, trash kills stop giving Waterlords reputation partway up, so late on the bosses do the work."] = "其餘的靠清{area:2717}。首領一定會計入；在經典版中，小怪的聲望在中途就會停止，所以後期要靠首領。",

	-- Step 10: Hydraxian Waterlords to Exalted
	-- {faction:749} Hydraxian Waterlords
	["{faction:749} to Exalted"] = "{faction:749}到崇拜",
	-- {area:2717} Molten Core
	["Keep clearing the {area:2717} until Exalted."] = "繼續清{area:2717}直到崇拜。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Use the {item:17310} on the poisoned water elementals of {zone:1423}, then loot their {item:17309} (12). Our data has no spawn points for those elementals."] = "對{zone:1423}中毒的水元素使用{item:17310}，然後拾取牠們的{item:17309}（12個）。我們的資料沒有這些水元素的重生點。",
}
