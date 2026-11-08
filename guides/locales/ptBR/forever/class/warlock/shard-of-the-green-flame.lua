-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/shard-of-the-green-flame (forever/class/warlock/shard-of-the-green-flame.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood
	["A rare off-hand for your 50s from {npc:14469} and {npc:14470} in {zone:1448}, the camp that also offers An Imp's Request."] = "Um item de mão secundária raro para os níveis 50, de {npc:14469} e {npc:14470} em {zone:1448}, o acampamento que também oferece Pedido de diabrete.",

	-- Step 1: Niby the Almighty
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood
	-- plural, as words: Flawless Fel Essences = {quest:7602} Flawless Fel Essence
	["At 50 {npc:14469} and his imp {npc:14470} wait on a rise in central {zone:1448} just north-east of Bloodvenom Post: coming north over the Bloodvenom Falls bridge, they stand off the road to the east, past a few oozes. {npc:14469} sends you to {npc:14470}, beside him, who wants three Flawless Fel Essences from three places."] = "",

	-- Step 2: Jaedenar
	["Jaedenar"] = "",
	-- {npc:9516} Lord Banehollow
	-- plural, as words: Jaedenar Legionnaires = {npc:9862} Jaedenar Legionnaire
	["Jaedenar lies just south of Bloodvenom Post, west of the road. Of its two caves, Shadow Hold is the northern one, further up the hill; the other has no Legionnaires. Shadow Hold's tunnels run north under the hills, and the Jaedenar Legionnaires (level 55) stand in its deeper halls, from the first ramps on toward {npc:9516}'s chamber; they Uppercut anyone in melee. Three kills in four give the essence, but only about eleven spawn: clear your way in and wait out a five-minute respawn if you must. The cultists of Jaedenar and Shadow Hold are all hostile."] = "",

	-- Step 3: Azshara
	-- {zone:1447} Azshara
	["The Legashi satyrs (level 51-53) hold the Legash Encampment on {zone:1447}'s northern coast. Every kind drops the essence three times in four; the satyrs burn mana and the Hellcallers rain fire, so pull them singly."] = "",

	-- Step 4: The Dark Portal
	["The Dark Portal"] = "",
	-- {zone:1419} Blasted Lands
	["The Felguard Sentries (level 54) walk around the Dark Portal in the south of the {zone:1419}, each with a felhunter. Leave the level 57 Servants of Razelikh alone: they cannot be killed without their own quest."] = "",

	-- Step 5: Impsy
	-- {npc:14470} Impsy · {item:18626} Fel Fire · {npc:14467} Kroshius
	["Back to {npc:14470}. He hands you the {item:18626}: keep it, it wakes the infernal {npc:14467}."] = "",

	-- Step 6: Kroshius
	-- {npc:14467} Kroshius · {npc:14469} Niby the Almighty · {item:18626} Fel Fire · {npc:14470} Impsy
	["{npc:14467}' remains lie in Shatter Scar Vale, the burnt crater north of {npc:14469}: follow the road north from his camp; the remains lie a little east of it. Use the {item:18626} beside them and wait for him to rise. {npc:14467} is elite (level 55): grouping up is encouraged; a warlock of 55 or more can solo him with Fear and damage over time, or with Enslave Demon, but fire spells do nothing to him and he knocks you back. If you die he heals to full; he rises again three minutes after he dies. An elite infernal patrols the pool south of the remains: pull {npc:14467} away from it. He always drops his core. Lost the {item:18626}? Abandon the quest and take it again from {npc:14470}."] = "",
	-- {item:18626} Fel Fire · {object:179677} Kroshius' Remains (no name in this language: may be words)
	["{item:18626}, at {object:179677}"] = "{item:18626}, em {object:179677}",

	-- Step 7: Back to Niby the Almighty
	-- {npc:14469} Niby the Almighty
	["Back to {npc:14469}"] = "De volta a {npc:14469}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:14469} and his imp {npc:14470} wait in central {zone:1448}, just east of {area:1763}."] = "No nível 50, {npc:14469} e seu diabrete {npc:14470} esperam no centro de {zone:1448}, logo a leste de {area:1763}.",
	-- ["The Felguard Sentries around the {area:72}, in southern {zone:1419}, carry its essence."] = "As Sentinelas Guarda Vil em volta do {area:72}, no sul de {zone:1419}, carregam a essência dele.",
	-- ["The Jaedenar Legionnaires, a short way west of {npc:14469}, carry {area:1763}'s essence."] = "Os Legionários de Jaedenar, pouco a oeste de {npc:14469} carregam a essência de {area:1763}.",
	-- ["The Legashi satyrs of northern {zone:1447} carry {zone:1447}'s essence."] = "Os sátiros Legashi do norte de {zone:1447} carregam a essência de {zone:1447}.",
	-- ["{npc:14467}' remains lie in {area:1766}, north of {npc:14469}. Use the {item:18626} beside them and kill the infernal when he wakes. {npc:14467} is elite: grouping up is advised."] = "Os restos de {npc:14467} estão em {area:1766}, ao norte de {npc:14469}. Use o {item:18626} ao lado deles e mate o infernal quando ele despertar. {npc:14467} é Elite: recomenda-se formar um grupo.",
}
