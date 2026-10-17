-- Korean (koKR): the guide forever/class/paladin/holy-mightstone (forever/class/paladin/holy-mightstone.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A one-use stone that makes you much stronger against undead for 10 minutes; the old choice rewards are gone."] = "10분 동안 언데드에게 훨씬 강해지는 1회용 돌입니다. 예전 선택 보상은 사라졌습니다.",

	-- Step 1: Lord Grayson Shadowbreaker
	-- {npc:928} Lord Grayson Shadowbreaker
	["{npc:928} is in the Cathedral of Light."] = "{npc:928}은(는) 빛의 대성당에 있습니다.",

	-- Step 2: Brandur Ironhammer
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward (no name in this language: may be words)
	["{npc:5149} is in the {object:32362}."] = "{npc:5149}은(는) {object:32362}에 있습니다.",

	-- Step 3: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands
	["{npc:10838} commands {area:3197} in the south of the {zone:1422}."] = "{npc:10838}은(는) {zone:1422} 남쪽의 {area:3197}을(를) 지휘합니다.",

	-- Step 4: Minion's Scourgestones
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones"] = "앞잡이의 스컬지석",
	-- {zone:1422} Western Plaguelands
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["The Scourge throughout the {zone:1422} drop Minion's Scourgestones."] = "{zone:1422} 곳곳의 스컬지가 앞잡이의 스컬지석을 떨어뜨립니다.",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:1477} The Temple of Atal'Hakkar · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor · {item:20606} Amber Voodoo Feather
	["{area:1477} lies in the {area:74} in eastern {zone:1435}. Inside, Gasher and {npc:5716} drop the {item:20606}, Hukku and Mijan the Blue, Zolo and Loro the Green."] = "{area:1477}은(는) {zone:1435} 동쪽의 {area:74}에 있습니다. 안에서 게이셔와 {npc:5716}이(가) {item:20606}을(를), 후쿠와 마이잔이 파란색을, 졸로와 로로가 녹색을 떨어뜨립니다.",
	-- {item:20606} Amber Voodoo Feather
	["{item:20606}, inside"] = "{item:20606}, 내부",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}, inside"] = "{item:20607}, 내부",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}, inside"] = "{item:20608}, 내부",
}
