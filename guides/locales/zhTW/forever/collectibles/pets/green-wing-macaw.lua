-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/green-wing-macaw (forever/collectibles/pets/green-wing-macaw.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: The Deadmines: Defias Pirates
	-- {area:1581} The Deadmines
	-- plural, as words: Defias Pirates = {npc:657} Defias Pirate
	["{area:1581}: Defias Pirates"] = "{area:1581}：迪菲亞海盜",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	-- plural, as words: Defias Pirates = {npc:657} Defias Pirate
	["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Defias Pirates on and around the ship drop the macaw about 3.5% of the time in our data."] = "{area:1581}是{area:20}底下的五人地城；副本傳送門在{area:20}的礦坑裡。根據我們的資料，船上和船周圍的迪菲亞海盜大約有3.5%機率掉落這隻金剛鸚鵡。",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581} portal, inside the {area:20} mine"] = "{area:1581}傳送門，在{area:20}的礦坑裡",
	-- plural, as words: Defias Pirates = {npc:657} Defias Pirate
	["Defias Pirates"] = "迪菲亞海盜",
}
