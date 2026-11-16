-- Spanish (Latin America) (esMX): the guide forever/collectibles/pets/baby-crocolisk (forever/collectibles/pets/baby-crocolisk.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sewer Beast
	-- {npc:3581} Sewer Beast · {zone:1453} Stormwind · {item:282047} Baby Crocolisk
	["The {npc:3581} is a rare level 50 crocolisk, much tougher than a normal mob of its level. It swims {zone:1453}'s canals and appears at one of six spots, about two hours after it last died; the arrow takes you round them. Below 60, bring a group; at 60, a well-geared character can try it alone. It drops the {item:282047} about once in 70 kills, and the pet binds when picked up, so the Auction House never has it. Horde players can farm it too, but inside an enemy capital."] = "La {npc:3581} es un crocolisco raro de nivel 50, mucho más duro que un enemigo normal de su nivel. Nada por los canales de {zone:1453} y aparece en uno de seis lugares, unas dos horas después de su última muerte; la flecha te lleva por ellos. Por debajo de 60, lleva un grupo; a 60, un personaje bien equipado puede intentarlo solo. Suelta el {item:282047} más o menos una vez cada 70 muertes, y la mascota se liga al recogerla, así que la casa de subastas nunca la tiene. Los jugadores de la Horda también pueden farmearla, pero dentro de una capital enemiga.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:3581} is a rare level 50 crocolisk that swims {zone:1453}'s canals; early kill counts give about 1.5% per kill. It is friendly to nobody: Horde players can farm it too, but they are in an enemy capital."] = "{npc:3581} es un crocolisco raro de nivel 50 que nada por los canales de {zone:1453}; los primeros recuentos de muertes dan alrededor de 1.5% por muerte. No es amistoso con nadie: los jugadores de la Horda también pueden cazarlo, pero están en una capital enemiga.",
}
