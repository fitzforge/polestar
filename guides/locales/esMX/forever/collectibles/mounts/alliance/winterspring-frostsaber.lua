-- Spanish (Latin America) (esMX): the guide forever/collectibles/mounts/alliance/winterspring-frostsaber (forever/collectibles/mounts/alliance/winterspring-frostsaber.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wintersaber Trainers
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers
	["{npc:10618} stands on top of {area:2241} in the far north of {zone:1452}. Only the Alliance can earn the {faction:589}' favour, from level 58: three repeatable quests worth 50 each, about 840 turn-ins from Neutral to Exalted. Frostsaber Provisions is open from the start, Winterfall Intrusion from halfway through Neutral and Rampaging Giants from Honored. The Wintersaber Trainers Reputation guide takes you through it."] = "{npc:10618} está en lo alto de {area:2241}, en el extremo norte de {zone:1452}. Solo la Alianza puede ganarse el favor de los {faction:589}, desde el nivel 58: tres misiones repetibles que valen 50 cada una, unas 840 entregas de Neutral a Exaltado. Provisiones de sable de escarcha está abierta desde el inicio, Intrusión Nevada desde la mitad de Neutral y Gigantes enfurecidos desde Honorable. La guía de reputación de los Entrenadores de sables de invierno te lleva paso a paso.",

	-- Step 2: Reins of the Winterspring Frostsaber
	-- {faction:589} Wintersaber Trainers
	["The Forever client lists it at 200g and level 60. It runs at full speed yet needs no riding training at all, only Honored with the {faction:589}, so you can skip the 1,000g Journeyman Riding if this is your fast mount."] = "El cliente de Forever lo lista a 200 de oro y nivel 60. Corre a toda velocidad pero no pide ningún entrenamiento de equitación, solo Honorable con los {faction:589}, así que puedes saltarte la Equitación de oficial de 1.000 de oro si esta es tu montura rápida.",
	-- {npc:10618} Rivern Frostwind
	["{npc:10618}, 200g"] = "{npc:10618}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "El cliente de Forever la pone a 200g y nivel 60, y no pide ningún rango de equitación.",
	-- ["{npc:10618} at {area:2241} in northern {zone:1452} offers the repeatable Frostsaber Provisions, Winterfall Intrusion and Rampaging Giants (level 58); they are the whole road to Exalted, so expect weeks of turn-ins."] = "{npc:10618}, en {area:2241}, en el norte de {zone:1452}, ofrece las misiones repetibles Provisiones de sable de hielo, Intrusión Nevada y Gigantes arrasadores (nivel 58); son todo el camino hasta Exaltado, así que prepárate para semanas de entregas.",
}
