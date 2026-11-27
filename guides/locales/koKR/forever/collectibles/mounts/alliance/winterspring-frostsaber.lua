-- Korean (koKR): the guide forever/collectibles/mounts/alliance/winterspring-frostsaber (forever/collectibles/mounts/alliance/winterspring-frostsaber.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wintersaber Trainers
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers
	["{npc:10618} stands on top of {area:2241} in the far north of {zone:1452}. Only the Alliance can earn the {faction:589}' favour, from level 58: three repeatable quests worth 50 each, about 840 turn-ins from Neutral to Exalted. Frostsaber Provisions is open from the start, Winterfall Intrusion from halfway through Neutral and Rampaging Giants from Honored. The Wintersaber Trainers Reputation guide takes you through it."] = "{npc:10618}은(는) {zone:1452} 최북단 {area:2241} 꼭대기에 있습니다. 얼라이언스만 58레벨부터 {faction:589}의 호의를 얻을 수 있습니다. 각각 50인 반복 퀘스트 세 개로 중립에서 확고한 동맹까지 약 840회 제출이 필요합니다. 서리갈기 보급품은 처음부터, 겨울굴 침입은 중립 절반부터, 날뛰는 거인은 우호적부터 열립니다. 겨울갈기 조련사 평판 가이드가 안내합니다.",

	-- Step 2: Reins of the Winterspring Frostsaber
	-- {faction:589} Wintersaber Trainers
	["The Forever client lists it at 200g and level 60. It runs at full speed yet needs no riding training at all, only Honored with the {faction:589}, so you can skip the 1,000g Journeyman Riding if this is your fast mount."] = "Forever 클라이언트에는 200골드, 60레벨로 나옵니다. 전속도로 달리는데 승마 훈련이 전혀 필요 없고 {faction:589}과(와) 우호적만 되면 되니, 빠른 탈것으로 쓴다면 수습 승마 1,000골드를 건너뛰어도 됩니다.",
	-- {npc:10618} Rivern Frostwind
	["{npc:10618}, 200g"] = "{npc:10618}, 200골드",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Forever client lists it at 200g and level 60, and asks for no riding rank."] = "Forever 클라이언트에서는 200골드, 60레벨이며 탈것 기술 등급은 요구하지 않습니다.",
	-- ["{npc:10618} at {area:2241} in northern {zone:1452} offers the repeatable Frostsaber Provisions, Winterfall Intrusion and Rampaging Giants (level 58); they are the whole road to Exalted, so expect weeks of turn-ins."] = "{zone:1452} 북쪽 {area:2241}의 {npc:10618}이(가) 반복 퀘스트 눈호랑이의 먹이, 눈사태일족의 침략, 광란의 거인(58레벨)을 줍니다. 확고한 동맹까지 가는 유일한 길이므로 몇 주 동안 퀘스트를 반복할 각오를 하십시오.",
	-- ["{zone:1452} Frostsaber"] = "{zone:1452} 눈호랑이",
}
