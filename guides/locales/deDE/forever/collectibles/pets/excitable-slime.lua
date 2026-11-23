-- German (deDE): the guide forever/collectibles/pets/excitable-slime (forever/collectibles/pets/excitable-slime.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Nutritious Slime Sludge
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle · {zone:1458} Undercity
	["Buy {item:278265} from {npc:4612} in the {zone:1458} canals first (25 copper for a stack of 5): you hand it in as soon as the slime offers its quest."] = "Kaufe zuerst {item:278265} bei {npc:4612} in den Kanälen von {zone:1458} (25 Kupfer für einen 5er-Stapel): Du gibst es ab, sobald der Schleim seine Quest anbietet.",
	-- {item:278265} Nutritious Slime Sludge · {npc:4612} Boyle
	["{item:278265}: {npc:4612}, in the canals"] = "{item:278265}: {npc:4612}, in den Kanälen",

	-- Step 2: WRIGGLE.
	-- {npc:269452} Excitable Slime · {npc:4612} Boyle · {quest:97583} WRIGGLE.
	["Find an {npc:269452}, a little critter in the canal water beside {npc:4612}, target it and /dance at it, again and again, until it dances back and offers {quest:97583}; this takes many tries. Hand in the sludge right away. If the slime seems tired, /dance with it again before you hand in."] = "Finde einen {npc:269452}, ein kleines Tierchen im Kanalwasser neben {npc:4612}, wähle es als Ziel und tippe wieder und wieder /dance darauf, bis es zurücktanzt und {quest:97583} anbietet; das braucht viele Versuche. Gib den Schlamm sofort ab. Wirkt der Schleim müde, tanze noch einmal mit ihm, bevor du abgibst.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find the {npc:269452}, a critter in the {zone:1458} canals, and /dance with it until it offers WRIGGLE. Buy {item:278265} from a vendor in the canals and bring it back; if the slime seems tired, dance with it again."] = "Such {npc:269452}, ein Kleintier in den Kanälen von {zone:1458}, und mach /dance mit ihm, bis es GLIBBER. anbietet. Kauf {item:278265} bei einem Händler in den Kanälen und bring es zurück; wirkt der Schleim müde, tanz noch einmal mit ihm.",
	-- ["{item:278265}: {npc:4612}, in the canals beside the slime"] = "{item:278265}: {npc:4612}, in den Kanälen neben dem Schleim",
}
