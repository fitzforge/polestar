-- Korean (koKR): the guide forever/reputation/thorium-brotherhood (forever/reputation/thorium-brotherhood.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thorium Brotherhood Reputation"] = "토륨 대장조합 평판",

	-- Step 1: Master Smith Burninate
	-- {area:1446} Thorium Point · {zone:1427} Searing Gorge · {faction:59} Thorium Brotherhood
	["{area:1446}, on the scaffolds in the north-west of {zone:1427}, is the Brotherhood's outpost. The {faction:59} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{zone:1427} 북서쪽 비계 위의 {area:1446}이(가) 대장조합의 전초기지입니다. {faction:59}은(는) 중립에서 시작합니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",

	-- Step 2: Secret Plans: Fiery Flux
	-- {area:1443} Slag Pit · {object:147516} Dark Iron · {item:18945} Dark Iron Residue
	["The plans lie in the {area:1443} of the Cauldron, guarded by {object:147516} dwarves. {object:147516} dwarves also drop {item:18945}, which Burninate takes for Gaining Acceptance."] = "조제법은 용광로의 {area:1443}에 있으며, {object:147516} 드워프가 지킵니다. {object:147516} 드워프는 {item:18945}도 떨어뜨리는데, 버니네이트가 인정받기 퀘스트로 이를 받습니다.",

	-- Step 3: Back to Burninate
	["Back to Burninate"] = "버니네이트에게 돌아가기",

	-- Step 4: Fiery Flux supplies to Friendly
	-- {item:18942} Fiery Flux
	["{item:18942} supplies to Friendly"] = "{item:18942} 보급품: 약간 우호적까지",
	-- {item:3356} Kingsblood · {item:4234} Heavy Leather · {item:18944} Incendosaur Scale · {zone:1427} Searing Gorge
	-- plural, as words: Iron Bars = {item:3575} Iron Bar · Incendosaurs = {npc:9318} Incendosaur
	["Restoring Fiery Flux Supplies repeats in three versions: {item:3356}, Iron Bars or {item:4234}, each with Coal and an {item:18944}. Incendosaurs (level 47-49) in the north of {zone:1427} drop a scale every time; Burninate himself sells Coal."] = "불꽃 융해촉진제 보급품은 {item:3356}, {item:3575}, {item:4234} 세 가지 버전으로 반복되며, 각각 석탄과 {item:18944}이(가) 필요합니다. {zone:1427} 북부의 인센도사우루스(47-49레벨)는 매번 비늘을 떨어뜨립니다. 석탄은 버니네이트가 직접 팝니다.",
	-- {npc:14624} Master Smith Burninate
	["{npc:14624}: Restoring Fiery Flux Supplies"] = "{npc:14624}: 불꽃 융해촉진제 보급품",

	-- Step 5: Lokhtos Darkbargainer to Honored
	-- {npc:12944} Lokhtos Darkbargainer
	["{npc:12944} to Honored"] = "{npc:12944}: 우호적까지",
	-- {npc:12944} Lokhtos Darkbargainer · {area:1584} Blackrock Depths · {item:11099} Dark Iron Ore · {skill:186} Mining · {item:11382} Blood of the Mountain · {item:17010} Fiery Core · {item:17011} Lava Core · {item:17012} Core Leather · {npc:14387} Lothos Riftwaker · {area:1445} Blackrock Mountain · {area:2717} Molten Core
	-- plural, as words: Dark Iron Deposits = {object:165658} Dark Iron Deposit
	["{npc:12944} trades in the Grim Guzzler inside {area:1584}. His Favor Amongst the Brotherhood turn-ins take {item:11099} (mined from Dark Iron Deposits with {skill:186}), {item:11382}, {item:17010}, {item:17011} and {item:17012}. {npc:14387} at the {area:1445} entrance offers attunement to the {area:2717}."] = "{npc:12944}은(는) {area:1584} 안의 험상궂은 주정뱅이 선술집에서 거래합니다. 토륨 대장조합의 평판 퀘스트에는 {item:11099}({skill:186}(으)로 {object:165658}에서 채광), {item:11382}, {item:17010}, {item:17011}, {item:17012}을(를) 제출합니다. {area:1445} 입구의 {npc:14387}이(가) {area:2717} 입장 자격을 줍니다.",
	-- {item:11099} Dark Iron Ore
	["{item:11099}: Favor Amongst the Brotherhood, {item:11099} at Lokhtos, repeatable."] = "{item:11099}: 토륨 대장조합의 평판, 로크토스에게 {item:11099}, 반복 가능.",

	-- Step 6: Thorium Brotherhood to Revered
	-- {faction:59} Thorium Brotherhood
	["{faction:59} to Revered"] = "{faction:59}: 매우 우호적까지",
	-- {area:2717} Molten Core · {item:11382} Blood of the Mountain
	-- plural, as words: Fiery Cores = {item:17010} Fiery Core · Lava Cores = {item:17011} Lava Core · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer
	["The {area:2717} materials carry the rest: Fiery Cores drop from Firewalkers, Flameguards and Firelords, and Lava Cores from Lava Elementals, Lava Reavers and Molten Destroyers there. {item:11382} comes from Molten Destroyers and rarely elsewhere."] = "나머지는 {area:2717} 재료로 채웁니다. {item:17010}은(는) 불꽃 정령, 화염의수호자, 불의군주가, {item:17011}은(는) 그곳의 {npc:12076}, {npc:12100}, {npc:11659}이(가) 떨어뜨립니다. {item:11382}은(는) {npc:11659}에게서 나오며 다른 곳에서는 드물게 나옵니다.",
	-- {area:2717} Molten Core · {item:17010} Fiery Core · {item:17011} Lava Core · {item:17012} Core Leather · {item:11382} Blood of the Mountain
	["{area:2717} materials: Favor Amongst the Brotherhood, {item:17010}, {item:17011}, {item:17012} and {item:11382}, all repeatable at Lokhtos."] = "{area:2717} 재료: 토륨 대장조합의 평판, {item:17010}, {item:17011}, {item:17012}, {item:11382}, 모두 로크토스에게 반복 가능.",

	-- Step 7: Thorium Brotherhood to Exalted
	-- {faction:59} Thorium Brotherhood
	["{faction:59} to Exalted"] = "{faction:59}: 확고한 동맹까지",
	-- {area:2717} Molten Core · {item:11099} Dark Iron Ore
	["Keep turning in {area:2717} materials and {item:11099} at Lokhtos until Exalted."] = "확고한 동맹이 될 때까지 로크토스에게 {area:2717} 재료와 {item:11099}을(를) 계속 제출하세요.",
}
