-- Korean (koKR): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328}"] = "티르의 감시단과 {spell:7328}",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "쓰러진 아군을 되살리는 {spell:7328}와(과), 새내기 포세이큰 성기사를 위한 무기와 방패입니다.",

	-- Step 1: Shari Stilwell
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "{area:159}에서 성기사를 가르치는 {npc:246152}이(가) 서해안에 있는 기사단의 요새로 보냅니다.",

	-- Step 2: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels
	["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602}은(는) {area:156} 북서쪽 절벽 위에 있습니다. {npc:246349}이(가) 성문에서 기다립니다.",

	-- Step 3: Murlocs at the Gates
	["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "썩은지느러미멀록은 요새 동쪽 길가의 절벽과 서쪽 호수 주변 야영지에 숨어 있습니다.",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "Vile Fin Attacker",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "Vile Fin Seer",

	-- Step 5: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378}은(는) 요새 안에서 기사단을 이끌며, {npc:246393}이(가) 그 옆에 서 있습니다.",

	-- Step 6: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {item:246213} Sturdy Lumber · {npc:259431} Rudolph Gelhardt
	["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317}이(가) 저택 남서쪽 {area:16616}의 폐허 마을 {area:16881}을(를) 차지하고 있습니다. {item:246213}은(는) 한 집의 뿌리 저장고에 쌓여 있고, 사령관 {npc:259431}이(가) 자신의 빛바랜 자들 사이를 돌아다닙니다.",
	-- {object:554626} Lumber Pile (no name in this language: may be words)
	["{object:554626}, in the root cellar"] = "{object:554626}, 뿌리 저장고 안",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges"] = "Tarnished Drudge",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots"] = "Tarnished Zealot",

	-- Step 7: Back to the keep
	["Back to the keep"] = "요새로 돌아가기",

	-- Step 8: A Lesson in Divinity
	-- {npc:246378} Danitha Morr
	["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378}이(가) 12레벨에 첫 번째 신성 수업을 줍니다.",

	-- Step 9: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "{area:159}에서 남쪽으로 걸어 {area:153}(으)로 간 뒤 {zone:1458}(으)로 내려가십시오. {npc:10181}은(는) {object:36126}에, {npc:257648}은(는) {object:36078}에서 구걸하고 있습니다.",

	-- Step 10: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot · Scarlet Friars = {npc:1538} Scarlet Friar
	["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648}에게 {item:2589} 10개가 필요합니다. 붉은십자군 광신도와 붉은십자군 수사가 열에 세 번 정도 떨어뜨립니다. 이미 가지고 있다면 챙겨 가십시오.",

	-- Step 12: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "{area:16602}(으)로 돌아가십시오. {npc:246378}이(가) {item:6866}을(를) 주며, {npc:257655}은(는) 요새 아래층에서 기다립니다.",

	-- Step 13: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life · {npc:257663} Deathguard Falgan · {npc:246378} Danitha Morr
	["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "{area:812}은(는) 숲 동쪽 끝에 있습니다. {npc:257663}에게 {item:6866}을(를) 사용한 뒤 대화하십시오. 상징을 잃어버리면 {npc:246378}이(가) 하나 더 줍니다.",

	-- Step 14: The Scarlet attack plans
	["The Scarlet attack plans"] = "붉은십자군 공격 계획",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "{area:812} 주변에 진을 친 Scarlet Crusader들이 공격 계획을 가지고 있습니다.",

	-- Step 15: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "{area:16602}(으)로 돌아가십시오. Billmuth가 계획을 받고, {npc:246378}이(가) {spell:7328}을(를) 가르칩니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{object:181686}, in the root cellar"] = "{object:181686}, 뿌리 저장고 안",
}
