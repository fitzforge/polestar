-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/xantish (forever/collectibles/pets/xantish.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:8404} Xan'tish
	["{npc:8404}'s Snakes"] = "As cobras de {npc:8404}",

	-- Step 1: Xan'tish
	-- {npc:8404} Xan'tish · {object:172961} Valley of Spirits (no name in this language: may be words) · {item:280703} Jungle Boa
	["{npc:8404}, the snake vendor, walks with his three snakes: from the {object:172961} north along the city's west side to the battleground emissaries and back. The waypoint is where his walk starts; if he is not there, follow the road north. He sells four snakes (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8404}, o vendedor de cobras, anda com as três cobras dele: do Vale dos Espíritos, para o norte pelo lado oeste da cidade, até os emissários de campo de batalha e de volta. O marcador de rota é onde o passeio dele começa; se ele não estiver lá, siga a estrada para o norte. Ele vende quatro cobras (50s cada); {item:280703} é novo no Forever. Cada item de mascote ensina o companheiro quando você o usa; as metas continuam marcadas depois.",
	-- {item:10360} Black Kingsnake
	["{item:10360}, 50s"] = "{item:10360}, 50s",
	-- {item:10361} Brown Snake
	["{item:10361}, 50s"] = "{item:10361}, 50s",
	-- {item:10392} Crimson Snake
	["{item:10392}, 50s"] = "{item:10392}, 50s",
	["50s"] = "50s",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:8404} sells four snakes in {zone:1454} (50s each); the {item:280703} is new in Forever. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:8404} vende quatro cobras em {zone:1454} (50s cada); a {item:280703} é nova no Forever. Cada item de mascote ensina o mascote quando usado; os objetivos continuam marcados depois.",
}
