-- Spanish (Latin America) (esMX): the guide forever/class/paladin/lumina-windsinger (forever/class/paladin/lumina-windsinger.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:91862} Lumina Windsinger
	["Rescuing {quest:91862}"] = "Rescate de {quest:91862}",
	-- {item:268484} Moonsilver Blade
	["No item yet: a Forsaken paladin rescue story; its sequel, the {item:268484}, cannot be finished yet."] = "Aún sin objeto: una historia de rescate para paladines Renegados; su continuación, {item:268484}, todavía no se puede terminar.",
	-- {zone:1458} Undercity
	["{zone:1458} and Earthen Ring reputation"] = "Reputación con {zone:1458} y el Anillo de la Tierra",

	-- Step 1: Danitha Morr
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {area:156} Solliden Farmstead
	["{npc:246378} leads the Paladins of Tyr's Watch from inside {area:16602}, on the bluffs north-west of the {area:156}."] = "{npc:246378} dirige a los Paladines de la Guardia de Tyr desde el interior de {area:16602}, en los riscos al noroeste de {area:156}.",

	-- Step 2: The Sepulcher
	-- {zone:1421} Silverpine Forest · {area:228} The Sepulcher · {npc:248840} Trevan Rol · {npc:259611} Deathguard Baldren
	["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Cabalga al sur por {zone:1421} hasta {area:228}. {npc:248840} está en el pueblo; {npc:259611} vigila cerca de la entrada.",

	-- Step 3: The pyre on Fenris Isle
	-- {area:172} Fenris Isle
	["The pyre on {area:172}"] = "La pira de {area:172}",
	-- {area:172} Fenris Isle · {area:228} The Sepulcher
	["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} está en el lago al este de {area:228}. Los restos calcinados están en su orilla.",
	-- {object:566037} Charred Remains
	["from the {object:566037}"] = "de {object:566037}",

	-- Step 4: Fenris Keep
	-- {quest:91862} Lumina Windsinger · {area:235} Fenris Keep
	["{quest:91862} is caged inside {area:235}, at the north end of the isle. The Rot Hide gnolls around her carry the key."] = "{quest:91862} está enjaulada dentro de {area:235}, en el extremo norte de la isla. Los gnolls Putrepellejo a su alrededor llevan la llave.",
	-- {item:267412} Fenris Isle Key
	["{item:267412}, from the Rot Hide gnolls"] = "{item:267412}, de los gnolls Putrepellejo",

	-- Step 5: Free Lumina Windsinger
	-- {npc:248755} Lumina Windsinger
	["Free {npc:248755}"] = "Libera a {npc:248755}",
	["Free her with the key, then stay close while she fights her way out of the keep."] = "Libérala con la llave y quédate cerca mientras se abre paso para salir del castillo.",

	-- Step 6: Back to the The Sepulcher
	-- {area:228} The Sepulcher
	["Back to the {area:228}"] = "Regresa a {area:228}",
	-- {area:235} Fenris Keep · {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["Once she is clear of {area:235}, {npc:259620} waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Cuando sale de {area:235}, {npc:259620} te espera en {area:228}. Habla de nuevo con ella para saber qué pasó en realidad en el camino.",
	-- {npc:259620} Lumina Windsinger · {area:228} The Sepulcher
	["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:228}"] = "Regresa a {area:228}",
	-- ["Once she is clear of {area:235}, Lumina waits for you in the {area:228}. Speak with her again to hear what really happened on the road."] = "Cuando sale de {area:235}, Lumina te espera en {area:228}. Habla de nuevo con ella para saber qué pasó en realidad en el camino.",
	-- ["Ride south through {zone:1421} to the {area:228}. {npc:248840} stands in the town; {npc:259611} keeps watch near its entrance."] = "Cabalga al sur por {zone:1421} hasta {area:228}. {npc:248840} está en el pueblo; {npc:259611} vigila cerca de la entrada.",
	-- ["{area:172} lies in the lake east of the {area:228}. The charred remains are on its shore."] = "{area:172} está en el lago al este de {area:228}. Los restos calcinados están en su orilla.",
	-- ["{npc:259620}, the {area:228}"] = "{npc:259620}, {area:228}",
}
