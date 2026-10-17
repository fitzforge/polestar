-- Korean (koKR): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "알터랙 언덕에 숨겨진 도적 저택 {area:3486}와(과) 첫 임무를 엽니다.",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "{npc:13936} 평판",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "{item:17126}",
	-- {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad
	["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "24레벨에 {npc:13936}에게서 온 {item:17126}(으)로 시작합니다. 데이터상으로는 {zone:1453}의 {npc:332} 또는 {npc:918}, {zone:1454}의 게스트 또는 오르묵을 통해 받습니다. 퀘스트에서 {npc:6707}에게 전할 {item:17125}을(를) 줍니다.",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {zone:1416} Alterac Mountains
	["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "호드는 {area:272}, 얼라이언스는 {area:271}(으)로 비행하십시오. 장원은 {area:272} 동쪽 언덕, {zone:1416}(으)로 올라가는 길 위에 숨어 있습니다. 들어가는 길에 Rite of Cunning을 통과합니다.",
	["Rite of Cunning"] = "Rite of Cunning",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766}: {quest:6701}, 반복 가능",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {area:287} Hillsbrad · {npc:13085} Myrokos Silentform
	["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216}은(는) 장원 남쪽, {area:287} 동부의 비밀결사대 요새인 {area:275} 안에 있습니다. {npc:13085}은(는) 빠르고 조용히 처리하라고 합니다.",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains
	["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "36레벨에 {npc:13085}이(가) 바턴의 정찰 보고서를 가져오라고 보냅니다. 바턴은 {zone:1416} 동쪽의 {area:280}에서 비밀결사대 무리를 이끕니다: 죽이지 말고 소매치기하십시오.",
	-- {item:275482} Barton's Scouting Report
	["{item:275482}: pickpocket Barton"] = "{item:275482}: 바턴 소매치기",

	-- Step 6: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "{npc:13085}에게 돌아가기",
}
