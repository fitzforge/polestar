-- German (deDE): the guide forever/collectibles/pets/mayhoa-skyhoof (forever/collectibles/pets/mayhoa-skyhoof.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mayhoa Skyhoof
	-- {npc:268745} Mayhoa Skyhoof · {zone:1454} Orgrimmar · {object:172957} Valley of Wisdom · {object:172958} Valley of Honor
	["{npc:268745}, the girl with puppies, walks a long loop through {zone:1454}: from the {object:172957} through the Drag to the {object:172958} and back. The waypoint is where she is seen most, on the road between the Drag and the {object:172958}; if she is not there, walk the loop. The carrier costs 60s. She carries one pup at a time: if she has none, another player just bought it, so come back later. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:268745}, das Mädchen mit den Welpen, geht eine lange Runde durch {zone:1454}: von der {object:172957} durch die Drag zur {object:172958} und zurück. Der Wegpunkt ist dort, wo man sie am häufigsten sieht, auf der Straße zwischen der Drag und der {object:172958}; ist sie nicht da, geh die Runde ab. Der Korb kostet 60s. Sie trägt einen Welpen auf einmal: Hat sie keinen, hat ihn gerade ein anderer Spieler gekauft, komm also später wieder. Jeder Haustiergegenstand lehrt seinen Begleiter, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
	["60s"] = "60s",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:268745} walks a long loop through {zone:1454} (from the {object:172982} to the Drag); the waypoint is one point on her path. The carrier costs 60s. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:268745} läuft eine lange Runde durch {zone:1454} (von {object:172982} bis zur Gasse); der Wegpunkt ist ein Punkt auf ihrem Weg. Der Transportkorb kostet 60s. Jeder Haustiergegenstand lehrt dich beim Benutzen seinen Begleiter; die Ziele bleiben danach abgehakt.",
}
