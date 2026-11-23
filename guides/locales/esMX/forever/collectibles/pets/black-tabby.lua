-- Spanish (Latin America) (esMX): the guide forever/collectibles/pets/black-tabby (forever/collectibles/pets/black-tabby.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Dalaran mages
	-- {area:279} Dalaran
	["{area:279} mages"] = "Magos de {area:279}",
	-- {npc:1920} Dalaran Spellscribe · {area:233} Ambermill · {zone:1421} Silverpine Forest · {npc:7383} Black Tabby · {area:279} Dalaran · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	-- plural, as words: Dalaran Shield Guards = {npc:2271} Dalaran Shield Guard
	["The {npc:1920}, a rare level 21 mage at {area:233} in southern {zone:1421}, drops the {npc:7383} about once in 6 kills. It has a single spot and can take hours to come back, so check it whenever you pass. While it is down, the Dalaran Shield Guards, Theurgists and Summoners (level 31-35) at the {area:279} crater, where {zone:1416} meet {zone:1424}, drop it too, but only about once in 500 kills. The cat can be traded: look at the Auction House as well."] = "El {npc:1920}, un mago raro de nivel 21 en {area:233}, en el sur de {zone:1421}, suelta el {npc:7383} más o menos una vez cada 6 muertes. Tiene un solo lugar y puede tardar horas en volver, así que revísalo cada vez que pases. Mientras no esté, los guardias escudo, teúrgos e invocadores de Dalaran (nivel 31-35) del cráter de {area:279}, donde {zone:1416} se junta con {zone:1424}, también lo sueltan, pero solo más o menos una vez cada 500 muertes. El gato se puede comerciar: mira también en la casa de subastas.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:1920}, a rare spawn among the mages at {area:233} in southern {zone:1421}, drops it about 17% of the time in our data; the other {area:279} mages at {area:233} and around the {area:279} crater drop it at about 0.2%. Kill the mages until the Spellscribe appears. Alliance players buy it on the Auction House."] = "El {npc:1920}, un raro entre los magos de {area:233} al sur de {zone:1421}, lo suelta cerca del 17% de las veces según nuestros datos; los demás magos de {area:279} en {area:233} y alrededor del cráter de {area:279}, cerca del 0.2%. Mata magos hasta que aparezca el Escribachizo. Los jugadores de la Alianza lo compran en la casa de subastas.",
}
