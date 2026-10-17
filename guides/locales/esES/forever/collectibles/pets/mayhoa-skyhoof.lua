-- Spanish (Spain) (esES): the guide forever/collectibles/pets/mayhoa-skyhoof (forever/collectibles/pets/mayhoa-skyhoof.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Mayhoa Skyhoof
	-- {npc:268745} Mayhoa Skyhoof · {zone:1454} Orgrimmar · {object:172982} Valley of Strength
	["{npc:268745} walks a long loop through {zone:1454} (from the {object:172982} to the Drag); the waypoint is one point on her path. The carrier costs 60s. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:268745} hace un largo recorrido por {zone:1454} (de {object:172982} a La Calle Mayor); el punto de ruta es solo un punto de su camino. La jaula cuesta 60 p. Cada objeto de mascota te enseña su compañero al usarlo; los objetivos siguen marcados después.",
	["60s"] = "60 p",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:268745} walks a long loop through {zone:1454} (from the {object:172982} to the {object:172959}); the waypoint is one point on her path. The carrier costs 60s. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:268745} hace un largo recorrido por {zone:1454} (del {object:172982} a {object:172959}); el punto de ruta es solo un punto de su camino. La jaula cuesta 60 p. Cada objeto de mascota enseña su compañero al usarlo; los objetivos siguen marcados después.",
}
