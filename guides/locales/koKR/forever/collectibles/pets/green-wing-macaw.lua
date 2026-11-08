-- Korean (koKR): the guide forever/collectibles/pets/green-wing-macaw (forever/collectibles/pets/green-wing-macaw.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Deadmines: Defias Pirates
	-- {area:1581} The Deadmines
	-- plural, as words: Defias Pirates = {npc:657} Defias Pirate
	["{area:1581}: Defias Pirates"] = "{area:1581}: 데피아즈단 해적",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	-- plural, as words: Defias Pirates = {npc:657} Defias Pirate
	["{area:1581} is a group of five at level 17-26, under {area:20}: go in at the {area:20} mine and follow the tunnel down to the instance portal. The Defias Pirates (elite, level 19-20) on and around the ship at the far end drop the macaw about once in 30 kills, so plan on several runs; a character well past the dungeon's level clears it alone. The cage can be traded: look at the Auction House too."] = "",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, {area:20} 광산 안",
	-- {area:1581} The Deadmines
	["{area:1581} portal, at the bottom of the mine"] = "",
	-- plural, as words: Defias Pirates = {npc:657} Defias Pirate
	["Defias Pirates, on the ship"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Defias Pirates"] = "데피아즈단 해적",
	-- ["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Defias Pirates on and around the ship drop the macaw about 3.5% of the time in our data."] = "{area:1581}은(는) {area:20} 아래의 5인 던전입니다. 던전 입구는 {area:20} 광산 안에 있습니다. 배 위와 주변의 데피아즈단 해적이 우리 자료상 약 3.5% 확률로 마코앵무새를 떨어뜨립니다.",
	-- ["{area:1581} portal, inside the {area:20} mine"] = "{area:1581} 입구, {area:20} 광산 안",
}
