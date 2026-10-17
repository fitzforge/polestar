-- French (frFR): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} et une arme à une main au choix au niveau 10.",

	-- Step 1: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496} se tient à {area:159}. {npc:6390} attend dans le mausolée sur la colline juste au nord du bourg : ouvrez la grille et combattez-le.",

	-- Step 2: Coleman Farthing
	-- {npc:1500} Coleman Farthing · {area:2119} Gallows' End Tavern · {area:159} Brill
	["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500} est à l'auberge, la {area:2119}, à {area:159}.",

	-- Step 3: Agamand Mills
	-- {area:157} Agamand Mills · {area:159} Brill
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "Les quatre Râteliers d'armes Agamand se trouvent parmi les bâtiments des {area:157}, au nord de {area:159}. Les morts-vivants des moulins attaquent à vue.",

	-- Step 4: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "Retournez voir {npc:1500}",
}
