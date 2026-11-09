-- German (deDE): the guide forever/collectibles/pets/baby-crocolisk (forever/collectibles/pets/baby-crocolisk.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sewer Beast
	-- {npc:3581} Sewer Beast · {zone:1453} Stormwind · {item:282047} Baby Crocolisk
	["The {npc:3581} is a rare level 50 crocolisk, much tougher than a normal mob of its level. It swims {zone:1453}'s canals and appears at one of six spots, about two hours after it last died; the arrow takes you round them. Below 60, bring a group; at 60, a well-geared character can try it alone. It drops the {item:282047} about once in 70 kills, and the pet binds when picked up, so the Auction House never has it. Horde players can farm it too, but inside an enemy capital."] = "Der {npc:3581} ist ein seltenes Krokilisk der Stufe 50, viel zäher als ein normaler Gegner seiner Stufe. Er schwimmt in den Kanälen von {zone:1453} und erscheint an einer von sechs Stellen, etwa zwei Stunden nach seinem letzten Tod; der Pfeil führt dich um sie herum. Unter Stufe 60 bring eine Gruppe mit; auf 60 kann ein gut ausgerüsteter Charakter es allein versuchen. Er lässt den {item:282047} etwa bei jedem 70. Kill fallen, und das Haustier ist beim Aufheben gebunden, das Auktionshaus hat es also nie. Hordenspieler können ihn auch farmen, aber in einer feindlichen Hauptstadt.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:3581} is a rare level 50 crocolisk that swims {zone:1453}'s canals; early kill counts give about 1.5% per kill. It is friendly to nobody: Horde players can farm it too, but they are in an enemy capital."] = "{npc:3581} ist ein seltenes Krokilisk der Stufe 50, das durch die Kanäle von {zone:1453} schwimmt; frühe Zählungen ergeben etwa 1.5% pro Kill. Es ist niemandem freundlich gesinnt: Auch Hordespieler können es farmen, sind dabei aber in einer feindlichen Hauptstadt.",
}
