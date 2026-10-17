-- Spanish (Spain) (esES): the guide forever/class/priest/benediction (forever/class/priest/benediction.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:18608} Benediction
	["{item:18608} and Anathema"] = "{item:18608} y Anatema",
	-- {npc:14494} Eris Havenfire · {item:18608} Benediction
	["{npc:14494}'s splinter and the two Eyes make {item:18608}, the epic priest staff that turns into Anathema."] = "La astilla de {npc:14494} y los dos Ojos forman {item:18608}, el bastón épico de sacerdote que se convierte en Anatema.",

	-- Step 1: The Eye of Shadow
	-- {item:18646} The Eye of Divinity · {object:179703} Cache of the Firelord · {npc:12018} Majordomo Executus · {area:2717} Molten Core · {item:18665} The Eye of Shadow · {npc:12397} Lord Kazzak
	-- plural, as words: Doomguard Commanders = {npc:12396} Doomguard Commander
	["You need {item:18646} first: it comes from the {object:179703} after {npc:12018} in {area:2717}. {item:18665} drops from elite demons ({npc:12397}, a world boss, always; Doomguard Commanders and Manahounds rarely); it binds when equipped, so buying one works too."] = "Primero necesitas {item:18646}: sale de {object:179703} tras {npc:12018} en {area:2717}. {item:18665} lo sueltan demonios élite ({npc:12397}, un jefe del mundo, siempre; los comandantes guardia apocalíptico y los canes de maná, rara vez); se liga al equiparlo, así que también puedes comprarlo.",

	-- Step 2: Eris Havenfire
	-- {item:18646} The Eye of Divinity · {npc:14494} Eris Havenfire · {zone:1423} Eastern Plaguelands · {item:8956} Oil of Immolation
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion
	["Equip {item:18646} to see {npc:14494}, a ghost on the mountainside in the north-west of the {zone:1423}. Come with full mana, Major Mana Potions and {item:8956}: if you fail, the event takes about two hours to return."] = "Equípate {item:18646} para ver a {npc:14494}, un fantasma en la ladera del noroeste de {zone:1423}. Ven con el maná lleno, pociones de maná sublimes y {item:8956}: si fallas, el evento tarda unas dos horas en volver.",

	-- Step 3: The Balance of Light and Shadow
	-- {spell:139} Renew
	["Save 50 peasants before 15 die. Kill the skeletons that attack them, cure their diseases (the purple ones first) and heal the wounded with {spell:139}. Friends may buff you beforehand but must stay out of the fight, or a demon appears and kills everyone."] = "Salva a 50 campesinos antes de que mueran 15. Mata a los esqueletos que los atacan, cura sus enfermedades (primero los morados) y sana a los heridos con {spell:139}. Tus amigos pueden darte beneficios antes, pero deben quedarse fuera del combate o aparecerá un demonio que matará a todos.",

	-- Step 4: Benediction
	-- {item:18608} Benediction
	["With both Eyes in your bags: {item:18608}"] = "Con ambos Ojos en tus bolsas: {item:18608}",
}
