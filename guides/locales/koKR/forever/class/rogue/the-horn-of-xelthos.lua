-- Korean (koKR): the guide forever/class/rogue/the-horn-of-xelthos (forever/class/rogue/the-horn-of-xelthos.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277210} Pyrewood Signet Ring · {area:236} Shadowfang Keep
	["The {item:277210}, C's payment for a solo job inside {area:236}."] = "{item:277210}, {area:236} 안에서 혼자 해내는 일에 대한 C의 보수입니다.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "C의 비밀 보관함",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest in a house just outside {area:204} in southern Silverpine, south of {area:236}. Open it and read C's note: the job has to be done alone, out of any group."] = "",

	-- Step 2: Veenix
	-- {npc:4086} Veenix · {area:461} Windshear Crag · {area:460} Sun Rock Retreat · {area:467} Stonetalon Peak · {item:210187} Venture Co. Work Order · {spell:921} Pick Pocket
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon, a short way north-east of {area:460}. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers (level 18) working around him carry them in their pockets. Stealth up behind one and {spell:921} it; killing them does not give it."] = "",
	-- {spell:921} Pick Pocket · {npc:3989} Venture Co. Logger · {item:210187} Venture Co. Work Order
	["{spell:921} a {npc:3989} for a {item:210187}"] = "",

	-- Step 3: Shadowfang Keep
	-- {item:210186} Breaching Charge · {item:5140} Flash Powder · {item:210213} Sister's Half-Key · {item:210212} Brother's Half-Key
	["Go in alone and use the {item:210186} at the courtyard gate. Players also report a freed prisoner opening the courtyard door for you: if you die while he is opening it, stay dead until it is open; it stays open once you release. If you know Vanish, bring {item:5140} and check its cooldown before entering; keep it ready for a failed approach. Pickpocket the sister in the dining hall for the {item:210213}, then the brother in the room reached by turning right at the top of the stairs for the {item:210212} (a level 20 rogue without Vanish may need ranks in Master of Deception to reach the second one unseen). Combine them somewhere safe: this breaks stealth. Free a bag slot first: opening the chest with full bags can use up the key without giving the horn. Return to the courtyard stables and use the combined key on the chest for the horn. Stay clear of the nearby elites; the minimum quest level does not guarantee a safe approach."] = "",
	-- {item:210183} Horn of Xelthos · {area:236} Shadowfang Keep
	["{item:210183}, inside {area:236}"] = "{item:210183}, {area:236} 내부",

	-- Step 4: Back to the dead drop
	["Back to the dead drop"] = "비밀 보관함으로 돌아가기",
	-- {object:410369} Dead Drop
	["Place the horn in the {object:410369} near Pyrewood. The payment may not appear immediately: check a capital mailbox for C's follow-up letter on your next planned city visit, then return to this chest for the reward quest. Do not repeat the dungeon just because the payment is not yet offered."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Go in alone. The {item:210186} gets you past the courtyard gate; the data does not say where in the keep the horn lies."] = "혼자 들어가십시오. {item:210186}(으)로 안뜰 문을 통과할 수 있습니다. 뿔피리가 요새 어디에 있는지는 데이터에 나와 있지 않습니다.",
	-- ["Place the horn in the {object:410369} near Pyrewood. C's payment is the second {item:210183} quest at the same chest."] = "장작나무 마을 근처의 {object:410369}에 뿔피리를 넣으십시오. C의 보수는 같은 상자의 두 번째 {item:210183} 퀘스트입니다.",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. Read C's note."] = "{object:410369}은(는) 은빛소나무 숲 남쪽, {area:236} 바로 남쪽의 {area:204} 근처에 있는 상자입니다. C의 쪽지를 읽으십시오.",
	-- ["{npc:4086}, a goblin friendly to both factions, stands among the Venture Co. in the {area:461}, east Stonetalon. Horde fly to {area:460}; Alliance to {area:467}. He wants a {item:210187} before he hands over explosives: the Venture Co. Loggers around him carry them."] = "양 진영 모두에게 우호적인 고블린 {npc:4086}은(는) 돌발톱 산맥 동쪽 {area:461}의 투자개발회사 사이에 있습니다. 호드는 {area:460}(으)로, 얼라이언스는 {area:467}(으)로 비행하십시오. 폭발물을 넘기기 전에 {item:210187}을(를) 원하며, 주변의 투자개발회사 나무꾼이 가지고 있습니다.",
}
