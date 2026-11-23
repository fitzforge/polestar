-- German (deDE): the guide forever/collectibles/pets/black-tabby (forever/collectibles/pets/black-tabby.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Dalaran mages
	-- {area:279} Dalaran
	["{area:279} mages"] = "Magier von {area:279}",
	-- {npc:1920} Dalaran Spellscribe · {area:233} Ambermill · {zone:1421} Silverpine Forest · {npc:7383} Black Tabby · {area:279} Dalaran · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	-- plural, as words: Dalaran Shield Guards = {npc:2271} Dalaran Shield Guard
	["The {npc:1920}, a rare level 21 mage at {area:233} in southern {zone:1421}, drops the {npc:7383} about once in 6 kills. It has a single spot and can take hours to come back, so check it whenever you pass. While it is down, the Dalaran Shield Guards, Theurgists and Summoners (level 31-35) at the {area:279} crater, where {zone:1416} meet {zone:1424}, drop it too, but only about once in 500 kills. The cat can be traded: look at the Auction House as well."] = "Der {npc:1920}, ein seltener Magier der Stufe 21 bei {area:233} im Süden von {zone:1421}, lässt die {npc:7383} etwa bei jedem 6. Kill fallen. Er hat nur einen Platz und braucht oft Stunden, um wiederzukommen, also schau nach, wann immer du vorbeikommst. Solange er tot ist, lassen sie auch die Dalaran Shield Guards, Theurgists und Summoners (Stufe 31-35) am Krater von {area:279} fallen, wo {zone:1416} und {zone:1424} aufeinandertreffen, aber nur etwa bei jedem 500. Kill. Die Katze ist handelbar: Schau auch im Auktionshaus nach.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:1920}, a rare spawn among the mages at {area:233} in southern {zone:1421}, drops it about 17% of the time in our data; the other {area:279} mages at {area:233} and around the {area:279} crater drop it at about 0.2%. Kill the mages until the Spellscribe appears. Alliance players buy it on the Auction House."] = "Der {npc:1920}, ein seltener Spawn unter den Magiern bei {area:233} im Süden von {zone:1421}, droppt sie laut unseren Daten in etwa 17 % der Fälle; die anderen Magier von {area:279} bei {area:233} und rund um den Krater von {area:279} droppen sie mit etwa 0,2 %. Töte die Magier, bis der Zauberschreiber erscheint. Allianzspieler kaufen sie im Auktionshaus.",
}
