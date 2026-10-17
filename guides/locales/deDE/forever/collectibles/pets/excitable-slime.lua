-- German (deDE): the guide forever/collectibles/pets/excitable-slime (forever/collectibles/pets/excitable-slime.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: WRIGGLE.
	-- {npc:269452} Excitable Slime · {zone:1458} Undercity · {item:278265} Nutritious Slime Sludge
	["Find the {npc:269452}, a critter in the {zone:1458} canals, and /dance with it until it offers WRIGGLE. Buy {item:278265} from a vendor in the canals and bring it back; if the slime seems tired, dance with it again."] = "Such {npc:269452}, ein Kleintier in den Kanälen von {zone:1458}, und mach /dance mit ihm, bis es GLIBBER. anbietet. Kauf {item:278265} bei einem Händler in den Kanälen und bring es zurück; wirkt der Schleim müde, tanz noch einmal mit ihm.",
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle
	["{item:278265}: {npc:4612}, in the canals beside the slime"] = "{item:278265}: {npc:4612}, in den Kanälen neben dem Schleim",
}
