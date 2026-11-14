-- Spanish (Latin America) (esMX): the guide forever/class/warlock/shard-of-the-green-flame (forever/class/warlock/shard-of-the-green-flame.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood
	["A rare off-hand for your 50s from {npc:14469} and {npc:14470} in {zone:1448}, the camp that also offers An Imp's Request."] = "Un objeto de mano izquierda raro para tus 50 de {npc:14469} y {npc:14470} en {zone:1448}, el campamento que también ofrece Pedido de un diablillo.",

	-- Step 1: Niby the Almighty
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls
	-- plural, as words: Flawless Fel Essences = {quest:7602} Flawless Fel Essence
	["At 50 {npc:14469} and his imp {npc:14470} wait on a rise in central {zone:1448} just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. {npc:14469} sends you to {npc:14470}, beside him, who wants three Flawless Fel Essences from three places."] = "A nivel 50, {npc:14469} y su diablillo {npc:14470} esperan en una elevación en el centro de {zone:1448}, justo al noreste de {area:1997}: viniendo al norte por el puente de {area:1765}, están fuera del camino hacia el este, pasando unos mocos. {npc:14469} te manda con {npc:14470}, a su lado, que quiere tres Esencias viles impecables de tres lugares.",

	-- Step 2: Azshara
	-- {zone:1447} Azshara
	["The Legashi satyrs (level 51-53) hold the Legash Encampment on {zone:1447}'s northern coast. Every kind drops the essence three times in four; the satyrs burn mana and the Hellcallers rain fire, so pull them singly."] = "Los sátiros Legashi (nivel 51-53) ocupan el Campamento Legashi en la costa norte de {zone:1447}. Todos los tipos sueltan la esencia tres de cada cuatro veces; los sátiros queman maná y los clamainfiernos hacen llover fuego, así que atráelos de a uno.",

	-- Step 3: Jaedenar
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {area:1770} Shadow Hold · {npc:9516} Lord Banehollow
	-- plural, as words: Jaedenar Legionnaires = {npc:9862} Jaedenar Legionnaire
	["{area:1763} lies just south of {area:1997}, west of the road. The guide waits for level 53 first: its Legionnaires are 55. Of its two caves, {area:1770} is the northern one, further up the hill; the other has no Legionnaires. {area:1770}'s tunnels run north under the hills, and the Jaedenar Legionnaires (level 55) stand in its deeper halls, from the first ramps on toward {npc:9516}'s chamber; they Uppercut anyone in melee. Three kills in four give the essence, but only about eleven spawn: clear your way in and wait out a five-minute respawn if you must. The cultists of {area:1763} and {area:1770} are all hostile."] = "{area:1763} está justo al sur de {area:1997}, al oeste del camino. La guía espera primero al nivel 53: sus Legionarios son de nivel 55. De sus dos cuevas, {area:1770} es la del norte, más arriba en la colina; la otra no tiene Legionarios. Los túneles de {area:1770} van hacia el norte bajo las colinas, y los Legionarios Jaedenar (nivel 55) están en sus salas más profundas, desde las primeras rampas hasta la cámara de {npc:9516}; usan Gancho contra quien esté cuerpo a cuerpo. Tres de cada cuatro muertes dan la esencia, pero solo aparecen unos once: abre camino hacia adentro y espera a que reaparezcan (cinco minutos) si hace falta. Todos los sectarios de {area:1763} y {area:1770} son hostiles.",

	-- Step 4: The Dark Portal
	-- {area:72} The Dark Portal · {zone:1419} Blasted Lands
	["The Felguard Sentries (level 54) walk around the {area:72} in the south of the {zone:1419}, each with a felhunter. Leave the level 57 Servants of Razelikh alone: they cannot be killed without their own quest."] = "Los centinelas guardia vil (nivel 54) caminan alrededor de {area:72}, en el sur de {zone:1419}, cada uno con un manáfago. Deja en paz a los siervos de Razelikh de nivel 57: no se pueden matar sin su propia misión.",

	-- Step 5: Impsy
	-- {npc:14470} Impsy · {item:18626} Fel Fire · {npc:14467} Kroshius
	["Back to {npc:14470}. He hands you the {item:18626}: keep it, it wakes the infernal {npc:14467}."] = "De vuelta con {npc:14470}. Te da {item:18626}: guárdalo, despierta al infernal {npc:14467}.",

	-- Step 6: Kroshius
	-- {npc:14467} Kroshius · {area:1766} Shatter Scar Vale · {npc:14469} Niby the Almighty · {item:18626} Fel Fire · {npc:14470} Impsy
	["{npc:14467}' remains lie in {area:1766}, the burnt crater north of {npc:14469}: follow the road north from his camp; the remains lie a little east of it. Use the {item:18626} beside them and wait for him to rise. {npc:14467} is elite (level 55): grouping up is encouraged; a warlock of 55 or more can solo him with Fear and damage over time, or with Enslave Demon, but fire spells do nothing to him and he knocks you back. If you die he heals to full; he rises again three minutes after he dies. An elite infernal patrols the pool south of the remains: pull {npc:14467} away from it. He always drops his core. Lost the {item:18626}? Abandon the quest and take it again from {npc:14470}."] = "Los restos de {npc:14467} están en {area:1766}, el cráter quemado al norte de {npc:14469}: sigue el camino al norte desde su campamento; los restos están un poco al este. Usa {item:18626} a su lado y espera a que se levante. {npc:14467} es élite (nivel 55): se recomienda agruparse; un brujo de nivel 55 o más puede hacerlo solo con Miedo y daño en el tiempo, o con Esclavizar demonio, pero los hechizos de fuego no le hacen nada y te empuja. Si mueres, se cura por completo; vuelve a levantarse tres minutos después de morir. Un infernal élite patrulla la poza al sur de los restos: aleja a {npc:14467} de ella. Siempre suelta su núcleo. ¿Perdiste {item:18626}? Abandona la misión y vuelve a tomarla con {npc:14470}.",
	-- {item:18626} Fel Fire · {object:179677} Kroshius' Remains (no name in this language: may be words)
	["{item:18626}, at {object:179677}"] = "{item:18626}, en {object:179677}",

	-- Step 7: Back to Niby the Almighty
	-- {npc:14469} Niby the Almighty
	["Back to {npc:14469}"] = "Regresa con {npc:14469}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:14469} and his imp {npc:14470} wait in central {zone:1448}, just east of {area:1763}."] = "A nivel 50, {npc:14469} y su diablillo {npc:14470} esperan en el centro de {zone:1448}, justo al este de {area:1763}.",
	-- ["The Felguard Sentries around the {area:72}, in southern {zone:1419}, carry its essence."] = "Los Avizores guardia vil alrededor de {area:72}, en el sur de {zone:1419}, llevan su esencia.",
	-- ["The Jaedenar Legionnaires, a short way west of {npc:14469}, carry {area:1763}'s essence."] = "Los Legionarios Jaedenar ({npc:9862}), un poco al oeste de {npc:14469}, llevan la esencia de {area:1763}.",
	-- ["The Legashi satyrs of northern {zone:1447} carry {zone:1447}'s essence."] = "Los sátiros Legashi del norte de {zone:1447} llevan la esencia de {zone:1447}.",
	-- ["{npc:14467}' remains lie in {area:1766}, north of {npc:14469}. Use the {item:18626} beside them and kill the infernal when he wakes. {npc:14467} is elite: grouping up is advised."] = "Los restos de {npc:14467} están en {area:1766}, al norte de {npc:14469}. Usa {item:18626} junto a ellos y mata al infernal cuando despierte. {npc:14467} es élite: se recomienda ir en grupo.",
}
