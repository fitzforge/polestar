-- Spanish (Latin America) (esMX): the guide forever/collectibles/pets/bitter-baitling (forever/collectibles/pets/bitter-baitling.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Riggle Bassbait
	-- {item:276275} Bitter Baitling · {item:274026} Extravagant Extravaganza Coin · {area:35} Booty Bay · {npc:15077} Riggle Bassbait · {quest:8193} Master Angler · {skill:356} Fishing
	["The {item:276275} costs one {item:274026}, the prize for winning the Stranglethorn Fishing Extravaganza. The contest runs on Sundays from 2 to 4 pm server time: be on the {area:35} docks by {npc:15077} when it starts. {quest:8193} is not a quest you take: {npc:15077} takes the fish straight from his window when you bring them. Bring your best {skill:356} skill and lures so no fish gets away, a mount and empty bags, and bind your hearthstone in {area:35}."] = "El {item:276275} cuesta una {item:274026}, el premio por ganar el torneo de pesca de Tuercespina. El torneo es los domingos de 2 a 4 p. m., hora del servidor: ve a los muelles de {area:35}, junto a {npc:15077}, antes de que empiece. {quest:8193} no es una misión que se tome: {npc:15077} recibe los peces directamente desde su ventana cuando se los llevas. Lleva tu mejor habilidad de {skill:356} y carnadas para que no se escape ningún pez, una montura y bolsas vacías, y vincula tu piedra de hogar en {area:35}.",

	-- Step 2: Schools of Tastyfish
	["Schools of Tastyfish"] = "Bancos de pez sabroso",
	-- {item:19807} Speckled Tastyfish · {area:35} Booty Bay
	["While the contest runs, schools of {item:19807} appear along the Stranglethorn coast, none inside {area:35}. Fish 40 {item:19807} from them; each school lasts only a few casts, so ride on to the next as soon as one is gone. The arrow takes you up the west coast north of {area:35}; more schools lie further north and just south of {area:35}."] = "Mientras dura el concurso, aparecen bancos de {item:19807} a lo largo de la costa de Tuercespina, ninguno dentro de {area:35}. Pesca 40 {item:19807} en ellos; cada banco dura solo unos pocos lanzamientos, así que sigue al siguiente apenas se agote uno. La flecha te lleva por la costa oeste al norte de {area:35}; hay más bancos más al norte y justo al sur de {area:35}.",

	-- Step 3: Back to Riggle Bassbait
	-- {npc:15077} Riggle Bassbait
	["Back to {npc:15077}"] = "De vuelta con {npc:15077}",
	-- {npc:15077} Riggle Bassbait · {npc:15078} Jang
	["Hurry back and hand the 40 Tastyfish to {npc:15077}: the first players to do so win, and the winners get the coin with their prize. If you are too late to win, {npc:15078} still pays a little gold for every 5 Tastyfish."] = "Vuelve rápido y entrégale los 40 peces sabrosos a {npc:15077}: los primeros jugadores en hacerlo ganan, y los ganadores reciben la moneda con su premio. Si llegas tarde para ganar, {npc:15078} igual paga algo de oro por cada 5 peces sabrosos.",
	-- {npc:15077} Riggle Bassbait
	["The winner's coin, from {npc:15077}"] = "La moneda del ganador, de {npc:15077}",

	-- Step 4: Jang
	-- {npc:15078} Jang · {npc:15077} Riggle Bassbait · {area:35} Booty Bay · {item:276275} Bitter Baitling
	["{npc:15078}, {npc:15077}'s apprentice, stands beside him on the {area:35} docks and trades the {item:276275} for the coin."] = "{npc:15078}, el aprendiz de {npc:15077}, está a su lado en los muelles de {area:35} y cambia el {item:276275} por la moneda.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {item:276275} is a fishing reward: {npc:15078} trades it for one {item:274026}, a reward of the fishing contest {npc:15078} runs in {area:35}. The coin's exact source is not published yet."] = "El {item:276275} es una recompensa de pesca: {npc:15078} lo cambia por una {item:274026}, recompensa del concurso de pesca que {npc:15078} organiza en {area:35}. Aún no se ha publicado de dónde sale exactamente la moneda.",
	-- ["{npc:15078} stands on the {area:35} docks."] = "{npc:15078} está en los muelles de {area:35}.",
}
