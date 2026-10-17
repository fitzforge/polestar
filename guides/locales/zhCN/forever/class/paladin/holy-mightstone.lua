-- Chinese (simplified) (zhCN): the guide forever/class/paladin/holy-mightstone (forever/class/paladin/holy-mightstone.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A one-use stone that makes you much stronger against undead for 10 minutes; the old choice rewards are gone."] = "一次性石头，10分钟内大幅增强你对亡灵的战斗力；旧的可选奖励已经取消。",

	-- Step 1: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["{npc:928} is in the Cathedral of Light."] = "{npc:928}在光明大教堂。",

	-- Step 2: Brandur Ironhammer
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward
	["{npc:5149} is in the {object:32362}."] = "{npc:5149}在{object:32362}。",

	-- Step 3: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands
	["{npc:10838} commands {area:3197} in the south of the {zone:1422}."] = "{npc:10838}指挥着{zone:1422}南部的{area:3197}。",

	-- Step 4: Minion's Scourgestones
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones"] = "{item:12840}",
	-- {zone:1422} Western Plaguelands
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["The Scourge throughout the {zone:1422} drop Minion's Scourgestones."] = "{zone:1422}各处的天灾都会掉落{item:12840}。",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor · {item:20606} Amber Voodoo Feather
	["{area:1477} lies in the {area:74} in eastern {zone:1435}. Inside, Gasher and {npc:5716} drop the {item:20606}, Hukku and Mijan the Blue, Zolo and Loro the Green."] = "{area:1477}位于{zone:1435}东部的{area:74}。在里面，加什尔和{npc:5716}掉落{item:20606}，胡库和米杉掉落蓝色，祖罗和洛若尔掉落绿色。",
	-- {item:20606} Amber Voodoo Feather
	["{item:20606}, inside"] = "{item:20606}，在里面",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}, inside"] = "{item:20607}，在里面",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}, inside"] = "{item:20608}，在里面",
}
