-- Chinese (traditional) (zhTW): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a one-hand weapon of your choice at 10."] = "10級時學會{spell:71}，並獲得一把自選的單手武器。",

	-- Step 1: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496}站在{area:159}。{npc:6390}在城鎮北邊山丘上的陵墓裡等著：打開大門與他戰鬥。",

	-- Step 2: Coleman Farthing
	-- {npc:1500} Coleman Farthing · {area:2119} Gallows' End Tavern · {area:159} Brill
	["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500}在{area:159}的旅店{area:2119}裡。",

	-- Step 3: Agamand Mills
	-- {area:157} Agamand Mills · {area:159} Brill
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "四個阿加曼德武器架立在{area:159}北邊{area:157}的建築之間。磨坊的不死生物看到你就會攻擊。",

	-- Step 4: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "返回{npc:1500}",
}
