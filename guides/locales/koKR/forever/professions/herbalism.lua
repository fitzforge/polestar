-- Korean (koKR): the guide forever/professions/herbalism (forever/professions/herbalism.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Herbalism
	-- {skill:182} Herbalism
	["Learn {skill:182}"] = "{skill:182} 배우기",
	-- {skill:182} Herbalism
	["Any {skill:182} trainer of your faction teaches Apprentice {skill:182} (character level 5); the arrow picks the nearest."] = "진영의 {skill:182} 상급자 누구에게서나 초급 {skill:182}을(를) 배울 수 있습니다(캐릭터 레벨 5). 화살표가 가장 가까운 상급자를 가리킵니다.",

	-- Step 2: Silverleaf & Earthroot: Elwynn Forest (1-50)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {skill:182} Herbalism
	["Pick every {item:2447} (1, orange), {item:765} (1, orange), {item:2449} (from 15) you pass and circle the waypoints until {skill:182} 50. Zone level 1-10."] = "지나가는 {item:2447}(1, 주황색), {item:765}(1, 주황색), {item:2449}(15부터)을(를) 모두 채집하고, {skill:182} 50까지 경유지를 도세요. 지역 레벨 1-10.",

	-- Step 8: Journeyman Herbalism
	-- {skill:182} Herbalism
	["Journeyman {skill:182}"] = "수습 {skill:182}",
	-- {skill:182} Herbalism
	["Journeyman {skill:182} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:182} trainer of your faction."] = "수습 {skill:182}은(는) 최대 숙련도를 150(으)로 올립니다. 숙련도 50, 캐릭터 레벨 10이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:182} 상급자를 가리킵니다.",

	-- Step 9: Briarthorn & Stranglekelp: Westfall (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "지나가는 {item:2447}(1, 노란색), {item:765}(1, 노란색), {item:2449}(15, 노란색), {item:785}(50, 주황색), {item:2450}(70부터), {item:3820}(85부터)을(를) 모두 채집하고, {skill:182} 100까지 경유지를 도세요. 지역 레벨 10-20.",

	-- Step 10: Mageroyal & Briarthorn: Loch Modan (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70) you pass and circle the waypoints until {skill:182} 100. Zone level 10-20."] = "지나가는 {item:2447}(1, 노란색), {item:765}(1, 노란색), {item:2449}(15, 노란색), {item:785}(50, 주황색), {item:2450}(70부터)을(를) 모두 채집하고, {skill:182} 100까지 경유지를 도세요. 지역 레벨 10-20.",

	-- Step 12: Briarthorn & Stranglekelp: The Barrens (50-100)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {skill:182} Herbalism
	["Pick every {item:2447} (1, yellow), {item:765} (1, yellow), {item:2449} (15, yellow), {item:785} (50, orange), {item:2450} (from 70), {item:3820} (from 85) you pass and circle the waypoints until {skill:182} 100. Zone level 10-25."] = "지나가는 {item:2447}(1, 노란색), {item:765}(1, 노란색), {item:2449}(15, 노란색), {item:785}(50, 주황색), {item:2450}(70부터), {item:3820}(85부터)을(를) 모두 채집하고, {skill:182} 100까지 경유지를 도세요. 지역 레벨 10-25.",

	-- Step 14: Bruiseweed: Redridge Mountains (100-125)
	-- {item:2447} Peacebloom · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:2453} (100, orange) you pass and circle the waypoints until {skill:182} 125. Zone level 15-25."] = "지나가는 {item:2447}(1, 초록색), {item:2449}(15, 초록색), {item:785}(50, 초록색), {item:2450}(70, 노란색), {item:2453}(100, 주황색)을(를) 모두 채집하고, {skill:182} 125까지 경유지를 도세요. 지역 레벨 15-25.",

	-- Step 15: Bruiseweed & Wild Steelbloom: Thousand Needles (100-125)
	-- {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 25-35."] = "지나가는 {item:2453}(100, 주황색), {object:1623}(115부터)을(를) 모두 채집하고, {skill:182} 125까지 경유지를 도세요. 지역 레벨 25-35.",

	-- Step 16: Bruiseweed & Wild Steelbloom: Hillsbrad Foothills (100-125)
	-- {item:2447} Peacebloom · {item:765} Silverleaf · {item:2449} Earthroot · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {skill:182} Herbalism
	["Pick every {item:2447} (1, green), {item:765} (1, green), {item:2449} (15, green), {item:785} (50, green), {item:2450} (70, yellow), {item:3820} (85, orange), {item:2453} (100, orange), {object:1623} (from 115) you pass and circle the waypoints until {skill:182} 125. Zone level 20-30."] = "지나가는 {item:2447}(1, 초록색), {item:765}(1, 초록색), {item:2449}(15, 초록색), {item:785}(50, 초록색), {item:2450}(70, 노란색), {item:3820}(85, 주황색), {item:2453}(100, 주황색), {object:1623}(115부터)을(를) 모두 채집하고, {skill:182} 125까지 경유지를 도세요. 지역 레벨 20-30.",

	-- Step 17: Expert Herbalism
	-- {skill:182} Herbalism
	["Expert {skill:182}"] = "숙련 {skill:182}",
	-- {skill:182} Herbalism
	["Expert {skill:182} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:182} trainer of your faction."] = "숙련 {skill:182}은(는) 최대 숙련도를 225(으)로 올립니다. 숙련도 125, 캐릭터 레벨 20이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:182} 상급자를 가리킵니다.",

	-- Step 18: Grave Moss & Kingsblood: Duskwood (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange) you pass and circle the waypoints until {skill:182} 160. Zone level 18-30."] = "지나가는 {item:785}(50, 초록색), {item:2450}(70, 초록색), {item:2453}(100, 노란색), {object:1623}(115, 주황색), {object:1628}(120, 주황색), {item:3356}(125, 주황색)을(를) 모두 채집하고, {skill:182} 160까지 경유지를 도세요. 지역 레벨 18-30.",

	-- Step 19: Kingsblood & Liferoot: Alterac Mountains (125-160)
	-- {item:785} Mageroyal · {item:2450} Briarthorn · {item:3820} Stranglekelp · {item:2453} Bruiseweed · {object:1623} Wild Steelbloom · {object:1628} Grave Moss · {item:3356} Kingsblood · {item:3357} Liferoot · {skill:182} Herbalism
	["Pick every {item:785} (50, green), {item:2450} (70, green), {item:3820} (85, yellow), {item:2453} (100, yellow), {object:1623} (115, orange), {object:1628} (120, orange), {item:3356} (125, orange), {item:3357} (from 150) you pass and circle the waypoints until {skill:182} 160. Zone level 30-40."] = "지나가는 {item:785}(50, 초록색), {item:2450}(70, 초록색), {item:3820}(85, 노란색), {item:2453}(100, 노란색), {object:1623}(115, 주황색), {object:1628}(120, 주황색), {item:3356}(125, 주황색), {item:3357}(150부터)을(를) 모두 채집하고, {skill:182} 160까지 경유지를 도세요. 지역 레벨 30-40.",

	-- Step 20: Fadeleaf & Goldthorn: Swamp of Sorrows (160-185)
	-- {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {skill:182} Herbalism
	["Pick every {item:3820} (85, green), {item:3356} (125, yellow), {item:3357} (150, orange), {item:3818} (160, orange), {item:3821} (from 170) you pass and circle the waypoints until {skill:182} 185. Zone level 35-45."] = "지나가는 {item:3820}(85, 초록색), {item:3356}(125, 노란색), {item:3357}(150, 주황색), {item:3818}(160, 주황색), {item:3821}(170부터)을(를) 모두 채집하고, {skill:182} 185까지 경유지를 도세요. 지역 레벨 35-45.",

	-- Step 21: Goldthorn & Khadgar's Whisker: Swamp of Sorrows (185-200)
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, yellow), {item:3818} (160, yellow), {item:3821} (170, orange), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 200. Zone level 35-45."] = "지나가는 {item:3356}(125, 초록색), {item:3357}(150, 노란색), {item:3818}(160, 노란색), {item:3821}(170, 주황색), {object:2043}(185, 주황색)을(를) 모두 채집하고, {skill:182} 200까지 경유지를 도세요. 지역 레벨 35-45.",

	-- Step 22: Artisan Herbalism
	-- {skill:182} Herbalism
	["Artisan {skill:182}"] = "전문 {skill:182}",
	-- {skill:182} Herbalism
	["Artisan {skill:182} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:182} trainer of your faction."] = "전문 {skill:182}은(는) 최대 숙련도를 300(으)로 올립니다. 숙련도 200, 캐릭터 레벨 35이(가) 필요합니다. 화살표는 진영의 가장 가까운 {skill:182} 상급자를 가리킵니다.",

	-- Step 23: Khadgar's Whisker: Swamp of Sorrows (200-210) cont.
	-- {object:2043} Khadgar's Whisker · {zone:1435} Swamp of Sorrows
	["{object:2043}: {zone:1435} (200-210) cont."] = "{object:2043}: {zone:1435} (200-210) (계속)",
	-- {item:3356} Kingsblood · {item:3357} Liferoot · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {skill:182} Herbalism
	["Pick every {item:3356} (125, green), {item:3357} (150, green), {item:3818} (160, yellow), {item:3821} (170, yellow), {object:2043} (185, orange) you pass and circle the waypoints until {skill:182} 210. Zone level 35-45."] = "지나가는 {item:3356}(125, 초록색), {item:3357}(150, 초록색), {item:3818}(160, 노란색), {item:3821}(170, 노란색), {object:2043}(185, 주황색)을(를) 모두 채집하고, {skill:182} 210까지 경유지를 도세요. 지역 레벨 35-45.",

	-- Step 24: Firebloom & Purple Lotus: Badlands (210-230)
	-- {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {item:3818} Fadeleaf · {item:3821} Goldthorn · {object:2043} Khadgar's Whisker · {item:4625} Firebloom · {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick every {object:1623} (115, green), {item:3356} (125, green), {item:3818} (160, green), {item:3821} (170, yellow), {object:2043} (185, yellow), {item:4625} (205, orange), {item:8831} (210, orange) you pass and circle the waypoints until {skill:182} 230. Zone level 35-45."] = "지나가는 {object:1623}(115, 초록색), {item:3356}(125, 초록색), {item:3818}(160, 초록색), {item:3821}(170, 노란색), {object:2043}(185, 노란색), {item:4625}(205, 주황색), {item:8831}(210, 주황색)을(를) 모두 채집하고, {skill:182} 230까지 경유지를 도세요. 지역 레벨 35-45.",

	-- Step 25: Sungrass & Gromsblood: Blasted Lands (230-260)
	-- {item:4625} Firebloom · {item:8838} Sungrass · {item:8846} Gromsblood · {skill:182} Herbalism
	["Pick every {item:4625} (205, yellow), {item:8838} (230, orange), {item:8846} (from 250) you pass and circle the waypoints until {skill:182} 260. Zone level 45-55."] = "지나가는 {item:4625}(205, 노란색), {item:8838}(230, 주황색), {item:8846}(250부터)을(를) 모두 채집하고, {skill:182} 260까지 경유지를 도세요. 지역 레벨 45-55.",

	-- Step 26: Dreamfoil & Mountain Silversage: Felwood (260-285)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {skill:182} Herbalism
	["Pick every {item:8836} (220, yellow), {item:8838} (230, yellow), {item:8846} (250, orange), {item:13464} (260, orange), {item:13463} (from 270), {item:13465} (from 280) you pass and circle the waypoints until {skill:182} 285. Zone level 48-55."] = "지나가는 {item:8836}(220, 노란색), {item:8838}(230, 노란색), {item:8846}(250, 주황색), {item:13464}(260, 주황색), {item:13463}(270부터), {item:13465}(280부터)을(를) 모두 채집하고, {skill:182} 285까지 경유지를 도세요. 지역 레벨 48-55.",

	-- Step 27: Mountain Silversage & Plaguebloom: Felwood (285-300)
	-- {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:8846} Gromsblood · {item:13464} Golden Sansam · {item:13463} Dreamfoil · {item:13465} Mountain Silversage · {item:13466} Plaguebloom · {skill:182} Herbalism
	["Pick every {item:8836} (220, green), {item:8838} (230, green), {item:8846} (250, yellow), {item:13464} (260, yellow), {item:13463} (270, orange), {item:13465} (280, orange), {item:13466} (285, orange) you pass and circle the waypoints until {skill:182} 300. Zone level 48-55."] = "지나가는 {item:8836}(220, 초록색), {item:8838}(230, 초록색), {item:8846}(250, 노란색), {item:13464}(260, 노란색), {item:13463}(270, 주황색), {item:13465}(280, 주황색), {item:13466}(285, 주황색)을(를) 모두 채집하고, {skill:182} 300까지 경유지를 도세요. 지역 레벨 48-55.",
}
