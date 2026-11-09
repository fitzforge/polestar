-- German (deDE): the guide forever/collectibles/mounts/alliance/winterspring-frostsaber (forever/collectibles/mounts/alliance/winterspring-frostsaber.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wintersaber Trainers
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers
	["{npc:10618} stands on top of {area:2241} in the far north of {zone:1452}. Only the Alliance can earn the {faction:589}' favour, from level 58: three repeatable quests worth 50 each, about 840 turn-ins from Neutral to Exalted. Frostsaber Provisions is open from the start, Winterfall Intrusion from halfway through Neutral and Rampaging Giants from Honored. The Wintersaber Trainers Reputation guide takes you through it."] = "{npc:10618} steht auf der Spitze von {area:2241} im äußersten Norden von {zone:1452}. Nur die Allianz kann sich die Gunst der {faction:589} verdienen, ab Stufe 58: drei wiederholbare Quests zu je 50, etwa 840 Abgaben von Neutral bis Ehrfürchtig. Frostsaber Provisions ist von Anfang an offen, Winterfall Intrusion ab der Mitte von Neutral und Rampaging Giants ab Wohlwollend. Der Ruf-Guide für die Wintersäbler-Lehrer führt dich hindurch.",

	-- Step 2: Reins of the Winterspring Frostsaber
	-- {faction:589} Wintersaber Trainers
	["The Forever client lists it at 200g and level 60. It runs at full speed yet needs no riding training at all, only Honored with the {faction:589}, so you can skip the 1,000g Journeyman Riding if this is your fast mount."] = "Der Forever-Client führt es für 200g und Stufe 60. Es läuft mit voller Geschwindigkeit und braucht dennoch keine Reitausbildung, nur Wohlwollend bei den {faction:589}; du kannst dir also das Reiten (Geselle) für 1.000g sparen, wenn dies dein schnelles Reittier ist.",
	-- {npc:10618} Rivern Frostwind
	["{npc:10618}, 200g"] = "{npc:10618}, 200g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Der Forever-Client listet ihn für 200g ab Stufe 60 und verlangt keinen Reitrang.",
	-- ["{npc:10618} at {area:2241} in northern {zone:1452} offers the repeatable Frostsaber Provisions, Winterfall Intrusion and Rampaging Giants (level 58); they are the whole road to Exalted, so expect weeks of turn-ins."] = "{npc:10618} am {area:2241} im Norden von {zone:1452} bietet die wiederholbaren Quests Frostsäblerverpflegung, Eindringlinge der Winterfelle und Tobende Riesen (Stufe 58) an; sie sind der ganze Weg zu Ehrfürchtig, also rechne mit Wochen an Abgaben.",
}
