-- Korean (koKR): the guide forever/class/warrior/whirlwind-weapon (forever/class/warrior/whirlwind-weapon.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2458} Berserker Stance · {spell:1680} Whirlwind
	["{spell:2458} at 30 and a {spell:1680} axe, sword or warhammer at 40."] = "30레벨에 {spell:2458}, 40레벨에 {spell:1680} 도끼, 검 또는 전투망치.",

	-- Step 1: The Islander (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 돼지와 휘파람 선술집 옆 {object:2100}의 {npc:5479}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 2: The Islander (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 {zone:1455}의 전사 상급자 {npc:5113}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 3: The Islander (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3354} in the {object:172958} sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 {object:172958}의 {npc:3354}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 4: The Islander (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 {zone:1456}의 전사 상급자 {npc:3041}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 5: The Islander (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "30레벨에 {zone:1458}의 전사 상급자 {npc:4595}이(가) {zone:1413} {area:720}의 {npc:6236}에게 보냅니다.",

	-- Step 6: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "{area:392}에서 해안을 따라 남쪽으로 {area:720}까지 가십시오. {npc:6236}은(는) 투기장 옆에 있습니다. 쇠창살을 밟으면 싸움이 시작됩니다. 도전자가 한 명씩 나온 뒤 {npc:6238}(33)이(가) 나옵니다.",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "도전자들과 {npc:6238} 물리치기",

	-- Step 7: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills · {item:3357} Liferoot · {item:3901} Bloodscalp Tusk · {quest:1714} Essence of the Exile
	["{npc:6176} camps in the south-east of {zone:1416}, above {zone:1424}; his cauldron stands beside him. He asks for a {item:3357}, a {item:3901} and the {quest:1714}, which his cauldron brews from three charms."] = "{npc:6176}은(는) {zone:1424} 위쪽, {zone:1416} 남동쪽에서 야영하며 가마솥이 옆에 있습니다. {item:3357}, {item:3901}, 그리고 가마솥에서 부적 세 개로 끓이는 {quest:1714}을(를) 요구합니다.",

	-- Step 8: The exiles of Arathi
	["The exiles of Arathi"] = "아라시 고원의 떠도는 정령",
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Three kinds of elemental exiles roam {zone:1417}: Burning Exiles in the north-west, Thundering Exiles in the middle, Cresting Exiles in the north-east. Each drops its charm."] = "세 종류의 떠도는 정령이 {zone:1417}을(를) 돌아다닙니다. 북서쪽에는 떠도는 불의 정령, 중앙에는 떠도는 천둥 정령, 북동쪽에는 떠도는 물의 정령이 있습니다. 각각 자신의 부적을 떨어뜨립니다.",
	-- {item:4479} Burning Charm
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:4479} from the Burning Exiles"] = "{item:4479}, 떠도는 불의 정령에게서",
	-- {item:4480} Thundering Charm
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:4480} from the Thundering Exiles"] = "{item:4480}, 떠도는 천둥 정령에게서",
	-- {item:4481} Cresting Charm
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:4481} from the Cresting Exiles"] = "{item:4481}, 떠도는 물의 정령에게서",

	-- Step 9: Essence of the Exile
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["{item:3357}: {skill:182}, or the auction house"] = "{item:3357}: {skill:182} 또는 경매장",

	-- Step 10: Bloodscalp Tusk
	-- {zone:1434} Stranglethorn Vale · {item:3901} Bloodscalp Tusk
	["The Bloodscalp trolls hold the north-west of {zone:1434}; they drop the {item:3901}."] = "붉은머리부족 트롤이 {zone:1434} 북서쪽을 차지하고 있으며, {item:3901}을(를) 떨어뜨립니다.",

	-- Step 11: The Summoning
	-- {quest:1712} Cyclonian · {npc:6176} Bath'rah the Windwatcher · {item:6894} Whirlwind Heart
	["{quest:1712} waits just north of {npc:6176}'s camp and carries the {item:6894}. {quest:1712} is elite: grouping up is advised."] = "{quest:1712}은(는) {npc:6176}의 야영지 바로 북쪽에서 기다리며 {item:6894}을(를) 가지고 있습니다. {quest:1712}은(는) 정예입니다. 파티를 권장합니다.",
	-- {item:6894} Whirlwind Heart · {quest:1712} Cyclonian
	["{item:6894} from {quest:1712}"] = "{item:6894}, {quest:1712}에게서",
}
