-- Korean (koKR): the guide forever/alliance/30-40/02-desolace (forever/alliance/30-40/02-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Menethil Harbor
	-- {zone:1455} Ironforge · {npc:1573} Gryth Thurden
	["From {zone:1455}'s {npc:1573}"] = "{zone:1455}의 {npc:1573}에게서",

	-- Step 2: Auberdine
	-- {area:442} Auberdine
	["Take the boat to {area:442} from Menethil's docks."] = "메네실 항구의 부두에서 {area:442}행 배를 타십시오.",

	-- Step 3: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {area:1276} Talondeep Path
	["From {area:415} ride north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then back past {area:415} to the {area:1276}."] = "{area:415}에서 북서쪽 언덕으로 가십시오. {quest:1738}은(는) {area:413}(으)로 가는 길 북쪽의 빛나는 나무입니다. {quest:65602}을(를) 수락했다면 {item:190309}은(는) {area:413} 북쪽 나무 사이의 집 안에 있습니다(26.6,22.0). 그다음 {area:415}을(를) 지나 {area:1276}(으)로 돌아가십시오.",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, {area:413} 북쪽",

	-- Step 4: Talondeep Path
	-- {area:415} Astranaar · {area:1276} Talondeep Path
	["From {area:415} head south-west to the {area:1276}, a tunnel through the mountains into Stonetalon."] = "{area:415}에서 남서쪽 {area:1276}(으)로 가십시오. 산을 뚫고 돌발톱 산맥으로 이어지는 터널입니다.",

	-- Step 5: Nijel's Point
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {zone:1443} Desolace · {area:608} Nijel's Point
	["Follow the road west past {area:460} (Horde) and south-west through the {area:465} into {zone:1443}; {area:608} stands at the top of the pass."] = "길을 따라 서쪽으로 {area:460}(호드)을(를) 지나, 남서쪽 {area:465}을(를) 거쳐 {zone:1443}(으)로 가십시오. {area:608}은(는) 고개 꼭대기에 있습니다.",

	-- Step 6: Sargeron
	-- {area:603} Sargeron · {area:608} Nijel's Point
	["The Hatefury satyrs hold the ruins of {area:603}, east of {area:608}."] = "서릿발분노 사티로스가 {area:608} 동쪽 {area:603} 폐허를 차지하고 있습니다.",

	-- Step 8: Malem chest
	["Malem chest"] = "말렘의 궤짝",
	-- {area:608} Nijel's Point
	["The chest lies in the ruins south-west of {area:608}."] = "궤짝은 {area:608} 남서쪽 폐허에 있습니다.",

	-- Step 10: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress
	["{npc:11863}'s tower stands on the hill west of {area:599}: take his quest first, the sceptre he wants is in the fortress."] = "{npc:11863}의 탑은 {area:599} 서쪽 언덕에 있습니다. 먼저 그의 퀘스트를 수락하십시오. 그가 원하는 홀은 요새 안에 있습니다.",

	-- Step 11: Dalinda Malem
	-- {npc:5644} Dalinda Malem · {area:608} Nijel's Point
	["{npc:5644} hides inside the Burning Blade's fortress south-west of {area:608}."] = "{npc:5644}은(는) {area:608} 남서쪽에 있는 불타는칼날단의 요새 안에 숨어 있습니다.",

	-- Step 12: Tyranis Malem and the Seer
	-- {npc:5643} Tyranis Malem
	["{npc:5643} and the Seer"] = "{npc:5643}와(과) 현자",
	-- {npc:5643} Tyranis Malem · {npc:13019} Burning Blade Seer
	["Her brother {npc:5643} (36) walks the fortress with the Burning Blade cultists (30-33): pull him alone. The {npc:13019} keeps the sceptre in the fortress's main building."] = "그녀의 오빠 {npc:5643}(36)는 불타는 칼날단 사교도(30-33)와 함께 요새를 돌아다닙니다. 그만 따로 끌어오세요. {npc:13019}은(는) 요새 본관에 홀을 가지고 있습니다.",

	-- Step 13: Escort Dalinda Malem
	-- {npc:5644} Dalinda Malem
	["Escort {npc:5644}"] = "{npc:5644} 호위",
	["Out of Thunder Axe Fortress"] = "천둥도끼 요새 밖으로",
	-- {npc:5644} Dalinda Malem · {npc:5642} Vahlarriel Demonslayer · {area:608} Nijel's Point
	["Lead {npc:5644} out of the fortress; she walks off once you are clear of it. {npc:5642} takes the turn-in at {area:608} at the end of the guide."] = "{npc:5644}을(를) 요새 밖으로 데려가십시오. 요새를 벗어나면 그녀가 떠납니다. 가이드 마지막에 {area:608}에서 {npc:5642}에게 완료 보고를 하십시오.",

	-- Step 15: Scorpashi venom
	["Scorpashi venom"] = "스콜파시 독",
	-- {area:2407} Kormek's Hut
	["The Scorpashi scorpids hunt the hills around {area:2407} on the road south."] = "스콜파시 전갈이 남쪽 길의 {area:2407} 주변 언덕에서 사냥합니다.",

	-- Step 16: Cork Gizelton
	-- {area:2407} Kormek's Hut
	["The Gizelton Caravan waits at {area:2407}."] = "기젤톤 대상단은 {area:2407}에서 기다립니다.",

	-- Step 17: Escort the caravan
	["Escort the caravan"] = "대상단 호위",
	-- {area:609} Kolkar Village · {area:2617} Scrabblescrew's Camp
	["Walk with the caravan south past {area:609}; Kolkar ambushers jump it on the way. Stay close until it stops at {area:2617}. The ambushers are 34-35 and come in waves: skip it if you are below 33."] = "대상단과 함께 {area:609}을(를) 지나 남쪽으로 걸어가십시오. 도중에 콜카르일족 매복병이 습격합니다. {area:2617}에서 멈출 때까지 가까이 있으십시오. 매복병은 34-35레벨이며 여러 차례 몰려오니, 33레벨 미만이면 건너뛰십시오.",

	-- Step 18: Smeed Scrabblescrew
	-- {npc:11596} Smeed Scrabblescrew · {area:609} Kolkar Village · {area:596} Kodo Graveyard
	["{npc:11596}'s camp is on the road south of {area:609}, by the {area:596}."] = "{npc:11596}의 야영지는 {area:609} 남쪽 길가, {area:596} 옆에 있습니다.",

	-- Step 19: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4700} Aged Kodo
	-- plural, as words: Aged Kodos = {npc:4700} Aged Kodo
	["Use {npc:11596}'s {item:13892} on an {npc:4700} and walk the tamed kodo back to his camp, five times; Aged Kodos also drop the hides."] = "{npc:11596}의 {item:13892}을(를) {npc:4700}에게 사용하고 길들인 코도를 그의 야영지로 데려가십시오. 다섯 번 반복합니다. 늙은 코도는 가죽도 떨어뜨립니다.",

	-- Step 21: Kolkar Village
	-- {area:609} Kolkar Village · {npc:5752} Corporal Melkins
	["The Kolkar roam the plains around {area:609}; their ears are for {npc:5752}."] = "콜카르일족이 {area:609} 주변 평원을 돌아다닙니다. 귀는 {npc:5752}에게 가져가십시오.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Take the boat to {area:442} from Menethil's docks. {npc:3649} stands in {area:442}, north of the flight master."] = "메네실 항구의 부두에서 {area:442}행 배를 타십시오. {npc:3649}은(는) {area:442}의 비행 조련사 북쪽에 있습니다.",
	-- ["The {area:1276}"] = "{area:1276}",
	-- ["{npc:3649}: {item:279915}, from Sylessa in Menethil"] = "{npc:3649}: {item:279915}, 메네실 항구의 Sylessa에게서",
}
