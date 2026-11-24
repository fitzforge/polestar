-- Spanish (Latin America) (esMX): the guide forever/collectibles/pets/xantish (forever/collectibles/pets/xantish.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8404} Xan'tish
	["{npc:8404}'s Snakes"] = "Serpientes de {npc:8404}",

	-- Step 1: Xan'tish
	-- {npc:8404} Xan'tish · {object:172961} Valley of Spirits · {item:280703} Jungle Boa
	["{npc:8404}, the snake vendor, walks with his three snakes: from the {object:172961} north along the city's west side to the battleground emissaries and back. The waypoint is where his walk starts; if he is not there, follow the road north. He sells four snakes (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8404}, el vendedor de serpientes, camina con sus tres serpientes: desde {object:172961} hacia el norte por el lado oeste de la ciudad hasta los emisarios de los campos de batalla, y de vuelta. El punto de ruta es donde empieza su recorrido; si no está ahí, sigue el camino al norte. Vende cuatro serpientes (50s cada una); la {item:280703} es nueva en Forever. Cada objeto de mascota enseña su compañero cuando lo usas; los objetivos quedan marcados después.",
	-- {item:10360} Black Kingsnake
	["{item:10360}, 50s"] = "{item:10360}, 50 p",
	-- {item:10361} Brown Snake
	["{item:10361}, 50s"] = "{item:10361}, 50 p",
	-- {item:10392} Crimson Snake
	["{item:10392}, 50s"] = "{item:10392}, 50 p",
	["50s"] = "50 p",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8404} sells four snakes in {zone:1454} (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8404} vende cuatro serpientes en {zone:1454} (50 p cada una); la {item:280703} es nueva en Forever. Cada objeto de mascota enseña su compañero al usarlo; los objetivos siguen marcados después.",
}
