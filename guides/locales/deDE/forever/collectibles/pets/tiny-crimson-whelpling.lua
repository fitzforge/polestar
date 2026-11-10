-- German (deDE): the guide forever/collectibles/pets/tiny-crimson-whelpling (forever/collectibles/pets/tiny-crimson-whelpling.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wetlands whelps
	-- {zone:1437} Wetlands
	["{zone:1437} whelps"] = "Welpen in {zone:1437}",
	-- {zone:1437} Wetlands · {area:1037} Grim Batol
	-- plural, as words: Red Whelps = {npc:1042} Red Whelp · Crimson Whelps = {npc:1069} Crimson Whelp · Flamesnorting Whelps = {npc:1044} Flamesnorting Whelp
	["The red whelps live in the hills of the eastern {zone:1437}, towards {area:1037}: about 50 of them, back about five minutes after a kill in Classic's data. Red Whelps (levels 23-24) and Crimson Whelps (25-26) drop the whelpling about once in 650 kills, the Flamesnorting Whelps (26-27) mixed in with them only once in 1,600, so expect a long farm. It can be traded, so the Auction House may be quicker."] = "Die roten Welpen leben in den Hügeln im Osten der {zone:1437}, Richtung {area:1037}: etwa 50 von ihnen, nach den Daten von Classic etwa fünf Minuten nach einem Kill wieder da. Red Whelps (Stufe 23-24) und Crimson Whelps (25-26) lassen den Welpling etwa bei jedem 650. Kill fallen, die Flamesnorting Whelps (26-27) unter ihnen nur bei jedem 1.600., rechne also mit einem langen Farmen. Er ist handelbar, das Auktionshaus geht also vielleicht schneller.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Red, Crimson and Flamesnorting Whelps (levels 23-26) in the eastern {zone:1437} drop it about once in 600-1,600 kills in our data."] = "Die Roten, Purpurroten und Flammenschnaubenden Welpen (Stufe 23-26) im Osten von {zone:1437} droppen ihn laut unseren Daten etwa einmal in 600-1.600 Kills.",
}
