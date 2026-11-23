-- German (deDE): the guide forever/collectibles/pets/xantish (forever/collectibles/pets/xantish.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8404} Xan'tish
	["{npc:8404}'s Snakes"] = "Schlangen von {npc:8404}",

	-- Step 1: Xan'tish
	-- {npc:8404} Xan'tish · {object:172961} Valley of Spirits · {item:280703} Jungle Boa
	["{npc:8404}, the snake vendor, walks with his three snakes: from the {object:172961} north along the city's west side to the battleground emissaries and back. The waypoint is where his walk starts; if he is not there, follow the road north. He sells four snakes (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8404}, der Schlangenhändler, geht mit seinen drei Schlangen spazieren: von der {object:172961} nach Norden an der Westseite der Stadt entlang zu den Schlachtfeld-Gesandten und zurück. Der Wegpunkt ist der Beginn seines Wegs; ist er nicht da, folge der Straße nach Norden. Er verkauft vier Schlangen (je 50s); die {item:280703} ist neu in Forever. Jeder Haustiergegenstand lehrt seinen Begleiter, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
	-- {item:10360} Black Kingsnake
	["{item:10360}, 50s"] = "{item:10360}, 50s",
	-- {item:10361} Brown Snake
	["{item:10361}, 50s"] = "{item:10361}, 50s",
	-- {item:10392} Crimson Snake
	["{item:10392}, 50s"] = "{item:10392}, 50s",
	["50s"] = "50s",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8404} sells four snakes in {zone:1454} (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8404} verkauft vier Schlangen in {zone:1454} (je 50s); {item:280703} ist neu in Forever. Jeder Haustiergegenstand lehrt beim Benutzen seinen Begleiter; die Ziele bleiben danach abgehakt.",
}
