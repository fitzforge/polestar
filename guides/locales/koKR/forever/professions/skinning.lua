-- Korean (koKR): the guide forever/professions/skinning (forever/professions/skinning.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Skinning
	-- {skill:393} Skinning
	["Learn {skill:393}"] = "{skill:393} 배우기",
	-- {skill:393} Skinning · {item:7005} Skinning Knife
	["Any {skill:393} trainer of your faction teaches Apprentice {skill:393} (character level 5); the arrow picks the nearest. Buy a {item:7005} from a trade goods or general vendor: keep it in your bags, you cannot skin without it."] = "진영의 모든 {skill:393} 상급자가 초급 {skill:393}을(를) 가르칩니다(캐릭터 레벨 5). 화살표가 가장 가까운 곳을 가리킵니다. 직업용품 상인이나 잡화 상인에게서 {item:7005}을(를) 사세요. 없으면 가죽을 벗길 수 없으니 가방에 넣어 두세요.",

	-- Step 2: Beasts 1-9: Elwynn Forest (1-50)
	-- {zone:1429} Elwynn Forest
	["Beasts 1-9: {zone:1429} (1-50)"] = "야수 1-9: {zone:1429} (1-50)",
	-- {npc:1922} Gray Forest Wolf · {npc:525} Mangy Wolf · {npc:524} Rockhide Boar · {npc:113} Stonetusk Boar · {npc:69} Timber Wolf · {npc:822} Young Forest Bear · {npc:299} Young Wolf · {skill:393} Skinning
	["Kill and skin {npc:1922} (7), {npc:525} (5), Prowler (9), {npc:524} (7), {npc:113} (5), {npc:69} (2), {npc:822} (8), {npc:299} (1) along the loop until {skill:393} 50; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 1-10."] = "순환 경로를 따라 {skill:393} 50까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:1922} (7), {npc:525} (5), 굶주린 늑대 (9), {npc:524} (7), {npc:113} (5), {npc:69} (2), {npc:822} (8), {npc:299} (1). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 1-10.",
	-- {npc:1922} Gray Forest Wolf
	["{npc:1922}, Prowler"] = "{npc:1922}, 굶주린 늑대",
	-- {npc:822} Young Forest Bear
	["Prowler, {npc:822}"] = "굶주린 늑대, {npc:822}",

	-- Step 3: Beasts 1-9: Dun Morogh (1-50)
	-- {zone:1426} Dun Morogh
	["Beasts 1-9: {zone:1426} (1-50)"] = "야수 1-9: {zone:1426} (1-50)",
	-- {npc:1125} Crag Boar · {npc:1127} Elder Crag Boar · {npc:1196} Ice Claw Bear · {npc:1199} Juvenile Snow Leopard · {npc:1126} Large Crag Boar · {npc:704} Ragged Timber Wolf · {npc:705} Ragged Young Wolf · {npc:1689} Scarred Crag Boar · {npc:708} Small Crag Boar · {npc:1201} Snow Leopard · {npc:1138} Snow Tracker Wolf · {npc:1131} Winter Wolf · {npc:1128} Young Black Bear · {skill:393} Skinning
	["Kill and skin {npc:1125} (5), {npc:1127} (7), {npc:1196} (7), {npc:1199} (5), {npc:1126} (6), {npc:704} (2), {npc:705} (1), {npc:1689} (9), {npc:708} (3), {npc:1201} (7), {npc:1138} (6), {npc:1131} (7), {npc:1128} (5) along the loop until {skill:393} 50; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 1-10."] = "순환 경로를 따라 {skill:393} 50까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:1125} (5), {npc:1127} (7), {npc:1196} (7), {npc:1199} (5), {npc:1126} (6), {npc:704} (2), {npc:705} (1), {npc:1689} (9), {npc:708} (3), {npc:1201} (7), {npc:1138} (6), {npc:1131} (7), {npc:1128} (5). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 1-10.",

	-- Step 4: Beasts 1-8: Teldrassil (1-50)
	-- {zone:1438} Teldrassil
	["Beasts 1-8: {zone:1438} (1-50)"] = "야수 1-8: {zone:1438} (1-50)",
	-- {npc:2033} Elder Nightsaber · {npc:2032} Mangy Nightsaber · {npc:2043} Nightsaber Stalker · {npc:1985} Thistle Boar · {npc:2031} Young Nightsaber · {npc:1984} Young Thistle Boar · {skill:393} Skinning
	["Kill and skin {npc:2033} (8), {npc:2032} (2), Nightsaber (5), {npc:2043} (7), {npc:1985} (2), {npc:2031} (1), {npc:1984} (1) along the loop until {skill:393} 50; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 1-10."] = "순환 경로를 따라 {skill:393} 50까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:2033} (8), {npc:2032} (2), 흑호 (5), {npc:2043} (7), {npc:1985} (2), {npc:2031} (1), {npc:1984} (1). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 1-10.",
	["Nightsaber"] = "흑호",

	-- Step 5: Beasts 1-9: Durotar (1-50)
	-- {zone:1411} Durotar
	["Beasts 1-9: {zone:1411} (1-50)"] = "야수 1-9: {zone:1411} (1-50)",
	-- {npc:3126} Armored Scorpid · {npc:3123} Bloodtalon Scythemaw · {npc:3122} Bloodtalon Taillasher · {npc:3125} Clattering Scorpid · {npc:3099} Dire Mottled Boar · {npc:3110} Dreadmaw Crocolisk · {npc:3121} Durotar Tiger · {npc:3100} Elder Mottled Boar · {npc:3098} Mottled Boar · {npc:3124} Scorpid Worker · {npc:3130} Thunder Lizard · {npc:3127} Venomtail Scorpid · {skill:393} Skinning
	["Kill and skin {npc:3126} (7), {npc:3123} (8), {npc:3122} (6), {npc:3125} (5), {npc:3099} (6), {npc:3110} (9), {npc:3121} (7), {npc:3100} (8), {npc:3098} (1), {npc:3124} (3), {npc:3130} (9), {npc:3127} (9) along the loop until {skill:393} 50; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 1-10."] = "순환 경로를 따라 {skill:393} 50까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:3126} (7), {npc:3123} (8), {npc:3122} (6), {npc:3125} (5), {npc:3099} (6), {npc:3110} (9), {npc:3121} (7), {npc:3100} (8), {npc:3098} (1), {npc:3124} (3), {npc:3130} (9), {npc:3127} (9). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 1-10.",

	-- Step 6: Beasts 1-9: Mulgore (1-50)
	-- {zone:1412} Mulgore
	["Beasts 1-9: {zone:1412} (1-50)"] = "야수 1-9: {zone:1412} (1-50)",
	-- {npc:2956} Adult Plainstrider · {npc:2957} Elder Plainstrider · {npc:3035} Flatland Cougar · {npc:3566} Flatland Prowler · {npc:2972} Kodo Calf · {npc:2961} Mountain Cougar · {npc:2959} Prairie Stalker · {npc:2958} Prairie Wolf · {npc:2960} Prairie Wolf Alpha · {skill:393} Skinning
	["Kill and skin {npc:2956} (6), Battleboar (3), {npc:2957} (8), {npc:3035} (7), {npc:3566} (9), {npc:2972} (7), {npc:2961} (3), Plainstrider (1), {npc:2959} (7), {npc:2958} (5), {npc:2960} (9) along the loop until {skill:393} 50; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 1-10."] = "순환 경로를 따라 {skill:393} 50까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:2956} (6), 전투멧돼지 (3), {npc:2957} (8), {npc:3035} (7), {npc:3566} (9), {npc:2972} (7), {npc:2961} (3), 초원타조 (1), {npc:2959} (7), {npc:2958} (5), {npc:2960} (9). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 1-10.",
	-- {npc:2961} Mountain Cougar
	["{npc:2961}, Plainstrider"] = "{npc:2961}, 초원타조",
	-- {npc:2961} Mountain Cougar
	["Battleboar, {npc:2961}"] = "전투멧돼지, {npc:2961}",
	["Battleboar, Plainstrider"] = "전투멧돼지, 초원타조",

	-- Step 7: Beasts 1-9: Tirisfal Glades (1-50)
	-- {zone:1420} Tirisfal Glades
	["Beasts 1-9: {zone:1420} (1-50)"] = "야수 1-9: {zone:1420} (1-50)",
	-- {npc:1548} Cursed Darkhound · {npc:1547} Decrepit Darkhound · {npc:1553} Greater Duskbat · {npc:1513} Mangy Duskbat · {npc:1549} Ravenous Darkhound · {npc:1554} Vampiric Duskbat · {skill:393} Skinning
	["Kill and skin {npc:1548} (7), {npc:1547} (5), Duskbat (1), {npc:1553} (6), {npc:1513} (3), {npc:1549} (9), {npc:1554} (8) along the loop until {skill:393} 50; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 1-10."] = "순환 경로를 따라 {skill:393} 50까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:1548} (7), {npc:1547} (5), 그늘박쥐 (1), {npc:1553} (6), {npc:1513} (3), {npc:1549} (9), {npc:1554} (8). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 1-10.",
	-- {npc:1513} Mangy Duskbat
	["{npc:1513}, Duskbat"] = "{npc:1513}, 그늘박쥐",
	["Duskbat"] = "그늘박쥐",
	-- {npc:1513} Mangy Duskbat
	["Duskbat, {npc:1513}"] = "그늘박쥐, {npc:1513}",

	-- Step 8: Journeyman Skinning
	-- {skill:393} Skinning
	["Journeyman {skill:393}"] = "수습 {skill:393}",
	-- {skill:393} Skinning
	["Journeyman {skill:393} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:393} trainer of your faction."] = "수습 {skill:393}은(는) 최대 숙련도를 150(으)로 올립니다. 숙련도 50, 캐릭터 레벨 10이(가) 필요합니다. 화살표가 진영의 가장 가까운 {skill:393} 상급자를 가리킵니다.",

	-- Step 9: Beasts 10-16: Westfall (50-100)
	-- {zone:1436} Westfall
	["Beasts 10-16: {zone:1436} (50-100)"] = "야수 10-16: {zone:1436} (50-100)",
	-- {npc:833} Coyote Packleader · {npc:454} Young Goretusk · {npc:547} Great Goretusk · {skill:393} Skinning
	["Kill and skin Coyote (10), {npc:833} (11), {npc:454} (12), Goretusk (14), {npc:547} (16, needs 60) along the loop until {skill:393} 100; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 10-20."] = "순환 경로를 따라 {skill:393} 100까지 다음 야수를 처치하고 가죽을 벗기세요: 코요테 (10), {npc:833} (11), {npc:454} (12), 뿔엄니멧돼지 (14), {npc:547} (16, 숙련도 60). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 10-20.",
	-- {npc:547} Great Goretusk
	["{npc:547}, Goretusk"] = "{npc:547}, 뿔엄니멧돼지",
	-- {npc:454} Young Goretusk
	["Coyote, {npc:454}"] = "코요테, {npc:454}",
	-- {npc:454} Young Goretusk
	["{npc:454}, Coyote"] = "{npc:454}, 코요테",
	-- {npc:833} Coyote Packleader
	["{npc:833}, Goretusk"] = "{npc:833}, 뿔엄니멧돼지",
	-- {npc:833} Coyote Packleader
	["{npc:833}, Coyote"] = "{npc:833}, 코요테",
	["Goretusk"] = "뿔엄니멧돼지",

	-- Step 10: Beasts 10-16: Loch Modan (50-100)
	-- {zone:1432} Loch Modan
	["Beasts 10-16: {zone:1432} (50-100)"] = "야수 10-16: {zone:1432} (50-100)",
	-- {npc:1190} Mountain Boar · {npc:1186} Elder Black Bear · {npc:1188} Grizzled Black Bear · {npc:1693} Loch Crocolisk · {npc:1191} Mangy Mountain Boar · {npc:1189} Black Bear Patriarch · {npc:1192} Elder Mountain Boar · {skill:393} Skinning
	["Kill and skin {npc:1190} (10), {npc:1186} (11), {npc:1188} (13), {npc:1693} (14), {npc:1191} (14), {npc:1189} (16, needs 60), {npc:1192} (16, needs 60) along the loop until {skill:393} 100; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 10-20."] = "순환 경로를 따라 {skill:393} 100까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:1190} (10), {npc:1186} (11), {npc:1188} (13), {npc:1693} (14), {npc:1191} (14), {npc:1189} (16, 숙련도 60), {npc:1192} (16, 숙련도 60). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 10-20.",

	-- Step 11: Beasts 11-19: Darkshore (50-100)
	-- {zone:1439} Darkshore
	["Beasts 11-19: {zone:1439} (50-100)"] = "야수 11-19: {zone:1439} (50-100)",
	-- {npc:2163} Thistle Bear · {npc:2164} Rabid Thistle Bear · {npc:2165} Grizzled Thistle Bear · {npc:2070} Moonstalker Runt · {npc:2237} Moonstalker Sire · {npc:3823} Ghostpaw Runner · {npc:2071} Moonstalker Matriarch · {skill:393} Skinning
	["Kill and skin {npc:2163} (11), {npc:2164} (13), Moonstalker (14), {npc:2165} (16, needs 60), {npc:2070} (16, needs 60), {npc:2237} (17, needs 70), {npc:3823} (19, needs 90), {npc:2071} (19, needs 90) along the loop until {skill:393} 100; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 10-20."] = "순환 경로를 따라 {skill:393} 100까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:2163} (11), {npc:2164} (13), 달표범 (14), {npc:2165} (16, 숙련도 60), {npc:2070} (16, 숙련도 60), {npc:2237} (17, 숙련도 70), {npc:3823} (19, 숙련도 90), {npc:2071} (19, 숙련도 90). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 10-20.",
	-- {npc:2164} Rabid Thistle Bear
	["Moonstalker, {npc:2164}"] = "달표범, {npc:2164}",
	-- {npc:2165} Grizzled Thistle Bear
	["Moonstalker, {npc:2165}"] = "달표범, {npc:2165}",
	-- {npc:2164} Rabid Thistle Bear
	["{npc:2164}, Moonstalker"] = "{npc:2164}, 달표범",

	-- Step 12: Beasts 8-19: The Barrens (50-100)
	-- {zone:1413} The Barrens
	["Beasts 8-19: {zone:1413} (50-100)"] = "야수 8-19: {zone:1413} (50-100)",
	-- {npc:3110} Dreadmaw Crocolisk · {npc:2957} Elder Plainstrider · {npc:2960} Prairie Wolf Alpha · {npc:3127} Venomtail Scorpid · {npc:3244} Greater Plainstrider · {npc:3415} Savannah Huntress · {npc:3254} Sunscale Lashtail · {npc:3246} Fleeting Plainstrider · {npc:3243} Savannah Highmane · {npc:3255} Sunscale Screecher · {npc:3242} Zhevra Runner · {npc:3234} Lost Barrens Kodo · {npc:3425} Savannah Prowler · {npc:3241} Savannah Patriarch · {npc:3245} Ornery Plainstrider · {npc:3256} Sunscale Scytheclaw · {npc:3426} Zhevra Charger · {npc:3236} Barrens Kodo · {skill:393} Skinning
	["Kill and skin {npc:3110} (9), {npc:2957} (8), {npc:2960} (9), {npc:3127} (9), {npc:3244} (11), {npc:3415} (11), {npc:3254} (11), {npc:3246} (12), {npc:3243} (12), {npc:3255} (13), {npc:3242} (13), {npc:3234} (14), {npc:3425} (14), {npc:3241} (15), {npc:3245} (16, needs 60), {npc:3256} (16, needs 60), {npc:3426} (17, needs 70), {npc:3236} (19, needs 90) along the loop until {skill:393} 100; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 10-25."] = "순환 경로를 따라 {skill:393} 100까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:3110} (9), {npc:2957} (8), {npc:2960} (9), {npc:3127} (9), {npc:3244} (11), {npc:3415} (11), {npc:3254} (11), {npc:3246} (12), {npc:3243} (12), {npc:3255} (13), {npc:3242} (13), {npc:3234} (14), {npc:3425} (14), {npc:3241} (15), {npc:3245} (16, 숙련도 60), {npc:3256} (16, 숙련도 60), {npc:3426} (17, 숙련도 70), {npc:3236} (19, 숙련도 90). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 10-25.",

	-- Step 13: Beasts 10-16: Silverpine Forest (50-100)
	-- {zone:1421} Silverpine Forest
	["Beasts 10-16: {zone:1421} (50-100)"] = "야수 10-16: {zone:1421} (50-100)",
	-- {npc:1778} Ferocious Grizzled Bear · {npc:1766} Mottled Worg · {npc:1797} Giant Grizzled Bear · {npc:1923} Bloodsnout Worg · {skill:393} Skinning
	["Kill and skin Worg (10), {npc:1778} (11), {npc:1766} (11), {npc:1797} (12), {npc:1923} (16, needs 60) along the loop until {skill:393} 100; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 10-20."] = "순환 경로를 따라 {skill:393} 100까지 다음 야수를 처치하고 가죽을 벗기세요: 검은늑대 (10), {npc:1778} (11), {npc:1766} (11), {npc:1797} (12), {npc:1923} (16, 숙련도 60). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 10-20.",
	-- {npc:1778} Ferocious Grizzled Bear
	["Worg, {npc:1778}"] = "검은늑대, {npc:1778}",
	["Worg"] = "검은늑대",
	-- {npc:1766} Mottled Worg
	["{npc:1766}, Worg"] = "{npc:1766}, 검은늑대",

	-- Step 14: Beasts 19-20: Duskwood (100-125)
	-- {zone:1431} Duskwood
	["Beasts 19-20: {zone:1431} (100-125)"] = "야수 19-20: {zone:1431} (100-125)",
	-- {npc:213} Starving Dire Wolf · {npc:565} Rabid Dire Wolf · {skill:393} Skinning
	["Kill and skin {npc:213} (19), {npc:565} (20) along the loop until {skill:393} 125; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 18-30."] = "순환 경로를 따라 {skill:393} 125까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:213} (19), {npc:565} (20). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 18-30.",

	-- Step 15: Beasts 21-23: Stonetalon Mountains (100-125)
	-- {zone:1442} Stonetalon Mountains
	["Beasts 21-23: {zone:1442} (100-125)"] = "야수 21-23: {zone:1442} (100-125)",
	-- {npc:4012} Pridewing Wyvern · {npc:4044} Blackened Basilisk · {npc:4067} Twilight Runner · {skill:393} Skinning
	["Kill and skin {npc:4012} (21, needs 105), {npc:4044} (23, needs 115), {npc:4067} (23, needs 115) along the loop until {skill:393} 125; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 15-27."] = "순환 경로를 따라 {skill:393} 125까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:4012} (21, 숙련도 105), {npc:4044} (23, 숙련도 115), {npc:4067} (23, 숙련도 115). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 15-27.",

	-- Step 16: Beasts 21-23: Hillsbrad Foothills (100-125)
	-- {zone:1424} Hillsbrad Foothills
	["Beasts 21-23: {zone:1424} (100-125)"] = "야수 21-23: {zone:1424} (100-125)",
	-- {npc:2351} Gray Bear · {npc:2354} Vicious Gray Bear · {npc:2384} Starving Mountain Lion · {skill:393} Skinning
	["Kill and skin {npc:2351} (21, needs 105), {npc:2354} (22, needs 110), {npc:2384} (23, needs 115) along the loop until {skill:393} 125; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 20-30."] = "순환 경로를 따라 {skill:393} 125까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:2351} (21, 숙련도 105), {npc:2354} (22, 숙련도 110), {npc:2384} (23, 숙련도 115). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 20-30.",

	-- Step 17: Expert Skinning
	-- {skill:393} Skinning
	["Expert {skill:393}"] = "숙련 {skill:393}",
	-- {skill:393} Skinning
	["Expert {skill:393} raises the cap to 225; it needs skill 125 and character level 20. The arrow picks the nearest {skill:393} trainer of your faction."] = "숙련 {skill:393}은(는) 최대 숙련도를 225(으)로 올립니다. 숙련도 125, 캐릭터 레벨 20이(가) 필요합니다. 화살표가 진영의 가장 가까운 {skill:393} 상급자를 가리킵니다.",

	-- Step 18: Beasts 21-29: Wetlands (125-150)
	-- {zone:1437} Wetlands
	["Beasts 21-29: {zone:1437} (125-150)"] = "야수 21-29: {zone:1437} (125-150)",
	-- {npc:1417} Young Wetlands Crocolisk · {npc:1020} Mottled Raptor · {npc:1015} Highland Raptor · {npc:1400} Wetlands Crocolisk · {npc:1016} Highland Lashtail · {npc:1021} Mottled Screecher · {npc:2089} Giant Wetlands Crocolisk · {npc:1022} Mottled Scytheclaw · {npc:1023} Mottled Razormaw · {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {skill:393} Skinning
	["Kill and skin {npc:1417} (21), {npc:1020} (22), {npc:1015} (23), {npc:1400} (23), {npc:1016} (24), {npc:1021} (24), {npc:2089} (25), {npc:1022} (25), {npc:1023} (26, needs 130), {npc:1018} (27, needs 135), {npc:1019} (29, needs 145) along the loop until {skill:393} 150; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 20-30."] = "순환 경로를 따라 {skill:393} 150까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:1417} (21), {npc:1020} (22), {npc:1015} (23), {npc:1400} (23), {npc:1016} (24), {npc:1021} (24), {npc:2089} (25), {npc:1022} (25), {npc:1023} (26, 숙련도 130), {npc:1018} (27, 숙련도 135), {npc:1019} (29, 숙련도 145). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 20-30.",

	-- Step 19: Beasts 21-27: Stonetalon Mountains (125-150)
	-- {zone:1442} Stonetalon Mountains
	["Beasts 21-27: {zone:1442} (125-150)"] = "야수 21-27: {zone:1442} (125-150)",
	-- {npc:4012} Pridewing Wyvern · {npc:4044} Blackened Basilisk · {npc:4067} Twilight Runner · {npc:4031} Fledgling Chimaera · {npc:4042} Singed Basilisk · {npc:4041} Scorched Basilisk · {skill:393} Skinning
	["Kill and skin {npc:4012} (21), {npc:4044} (23), {npc:4067} (23), {npc:4031} (25), {npc:4042} (25), {npc:4041} (27, needs 135) along the loop until {skill:393} 150; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 15-27."] = "순환 경로를 따라 {skill:393} 150까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:4012} (21), {npc:4044} (23), {npc:4067} (23), {npc:4031} (25), {npc:4042} (25), {npc:4041} (27, 숙련도 135). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 15-27.",

	-- Step 20: Beasts 21-27: Hillsbrad Foothills (125-150)
	-- {zone:1424} Hillsbrad Foothills
	["Beasts 21-27: {zone:1424} (125-150)"] = "야수 21-27: {zone:1424} (125-150)",
	-- {npc:2351} Gray Bear · {npc:2354} Vicious Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {skill:393} Skinning
	["Kill and skin {npc:2351} (21), {npc:2354} (22), {npc:2384} (23), {npc:2356} (25), {npc:2385} (27, needs 135) along the loop until {skill:393} 150; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 20-30."] = "순환 경로를 따라 {skill:393} 150까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:2351} (21), {npc:2354} (22), {npc:2384} (23), {npc:2356} (25), {npc:2385} (27, 숙련도 135). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 20-30.",

	-- Step 21: Beasts 30-34: Stranglethorn Vale (150-175)
	-- {zone:1434} Stranglethorn Vale
	["Beasts 30-34: {zone:1434} (150-175)"] = "야수 30-34: {zone:1434} (150-175)",
	-- {npc:1150} River Crocolisk · {npc:683} Young Panther · {npc:855} Young Stranglethorn Raptor · {npc:681} Young Stranglethorn Tiger · {npc:688} Stone Maw Basilisk · {npc:1108} Mistvale Gorilla · {npc:682} Stranglethorn Tiger · {npc:685} Stranglethorn Raptor · {npc:689} Crystal Spine Basilisk · {npc:1085} Elder Stranglethorn Tiger · {skill:393} Skinning
	["Kill and skin {npc:1150} (30), {npc:683} (30), {npc:855} (30), {npc:681} (30), {npc:688} (31, needs 155), {npc:1108} (32, needs 160), Panther (32, needs 160), {npc:682} (32, needs 160), {npc:685} (33, needs 165), {npc:689} (34, needs 170), {npc:1085} (34, needs 170) along the loop until {skill:393} 175; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 30-45."] = "순환 경로를 따라 {skill:393} 175까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:1150} (30), {npc:683} (30), {npc:855} (30), {npc:681} (30), {npc:688} (31, 숙련도 155), {npc:1108} (32, 숙련도 160), 퓨마 (32, 숙련도 160), {npc:682} (32, 숙련도 160), {npc:685} (33, 숙련도 165), {npc:689} (34, 숙련도 170), {npc:1085} (34, 숙련도 170). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 30-45.",
	-- {npc:682} Stranglethorn Tiger
	["Panther, {npc:682}"] = "퓨마, {npc:682}",

	-- Step 22: Beasts 30-39: Stranglethorn Vale (175-200)
	-- {zone:1434} Stranglethorn Vale
	["Beasts 30-39: {zone:1434} (175-200)"] = "야수 30-39: {zone:1434} (175-200)",
	-- {npc:1150} River Crocolisk · {npc:683} Young Panther · {npc:855} Young Stranglethorn Raptor · {npc:681} Young Stranglethorn Tiger · {npc:688} Stone Maw Basilisk · {npc:1108} Mistvale Gorilla · {npc:682} Stranglethorn Tiger · {npc:685} Stranglethorn Raptor · {npc:689} Crystal Spine Basilisk · {npc:1085} Elder Stranglethorn Tiger · {npc:686} Lashtail Raptor · {npc:1151} Saltwater Crocolisk · {npc:1152} Snapjaw Crocolisk · {npc:854} Young Jungle Stalker · {npc:684} Shadowmaw Panther · {npc:690} Cold Eye Basilisk · {skill:393} Skinning
	["Kill and skin {npc:1150} (30), {npc:683} (30), {npc:855} (30), {npc:681} (30), {npc:688} (31), {npc:1108} (32), Panther (32), {npc:682} (32), {npc:685} (33), {npc:689} (34), {npc:1085} (34), {npc:686} (35), {npc:1151} (35), {npc:1152} (35), {npc:854} (36, needs 180), {npc:684} (37, needs 185), {npc:690} (39, needs 195) along the loop until {skill:393} 200; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 30-45."] = "순환 경로를 따라 {skill:393} 200까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:1150} (30), {npc:683} (30), {npc:855} (30), {npc:681} (30), {npc:688} (31), {npc:1108} (32), 퓨마 (32), {npc:682} (32), {npc:685} (33), {npc:689} (34), {npc:1085} (34), {npc:686} (35), {npc:1151} (35), {npc:1152} (35), {npc:854} (36, 숙련도 180), {npc:684} (37, 숙련도 185), {npc:690} (39, 숙련도 195). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 30-45.",

	-- Step 23: Artisan Skinning
	-- {skill:393} Skinning
	["Artisan {skill:393}"] = "전문 {skill:393}",
	-- {skill:393} Skinning
	["Artisan {skill:393} raises the cap to 300; it needs skill 200 and character level 35. The arrow picks the nearest {skill:393} trainer of your faction."] = "전문 {skill:393}은(는) 최대 숙련도를 300(으)로 올립니다. 숙련도 200, 캐릭터 레벨 35이(가) 필요합니다. 화살표가 진영의 가장 가까운 {skill:393} 상급자를 가리킵니다.",

	-- Step 24: Beasts 35-42: Badlands (200-225)
	-- {zone:1418} Badlands
	["Beasts 35-42: {zone:1418} (200-225)"] = "야수 35-42: {zone:1418} (200-225)",
	-- {npc:2727} Crag Coyote · {npc:2731} Ridge Stalker · {npc:2728} Feral Crag Coyote · {npc:2729} Elder Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch · {npc:2730} Rabid Crag Coyote · {skill:393} Skinning
	["Kill and skin {npc:2727} (35), {npc:2731} (36), {npc:2728} (37), {npc:2729} (38), {npc:2732} (38), {npc:2734} (40), {npc:2730} (42, needs 210) along the loop until {skill:393} 225; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 35-45."] = "순환 경로를 따라 {skill:393} 225까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:2727} (35), {npc:2731} (36), {npc:2728} (37), {npc:2729} (38), {npc:2732} (38), {npc:2734} (40), {npc:2730} (42, 숙련도 210). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 35-45.",

	-- Step 25: Beasts 42-49: The Hinterlands (225-250)
	-- {zone:1425} The Hinterlands
	["Beasts 42-49: {zone:1425} (225-250)"] = "야수 42-49: {zone:1425} (225-250)",
	-- {npc:2927} Vicious Owlbeast · {npc:2924} Silvermane Wolf · {npc:2928} Primitive Owlbeast · {npc:2929} Savage Owlbeast · {npc:2926} Silvermane Stalker · {npc:2505} Saltwater Snapjaw · {skill:393} Skinning
	["Kill and skin {npc:2927} (42), {npc:2924} (43), {npc:2928} (44), {npc:2929} (46, needs 230), {npc:2926} (47, needs 235), {npc:2505} (49, needs 245) along the loop until {skill:393} 250; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 40-50."] = "순환 경로를 따라 {skill:393} 250까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:2927} (42), {npc:2924} (43), {npc:2928} (44), {npc:2929} (46, 숙련도 230), {npc:2926} (47, 숙련도 235), {npc:2505} (49, 숙련도 245). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 40-50.",

	-- Step 26: Beasts 48-54: Un'Goro Crater (250-275)
	-- {zone:1449} Un'Goro Crater
	["Beasts 48-54: {zone:1449} (250-275)"] = "야수 48-54: {zone:1449} (250-275)",
	-- {npc:9165} Fledgling Pterrordax · {npc:6507} Ravasaur Hunter · {npc:6506} Ravasaur Runner · {npc:9162} Young Diemetradon · {npc:6514} Un'Goro Gorilla · {npc:6508} Venomhide Ravasaur · {npc:9167} Frenzied Pterrordax · {npc:6513} Un'Goro Stomper · {npc:6516} Un'Goro Thunderer · {npc:9164} Elder Diemetradon · {npc:11735} Stonelash Scorpid · {skill:393} Skinning
	["Kill and skin {npc:9165} (48), Ravasaur (48), {npc:6507} (49), {npc:6506} (49), {npc:9162} (49), Pterrordax (50), {npc:6514} (50), {npc:6508} (50), Diemetradon (51, needs 255), {npc:9167} (51, needs 255), {npc:6513} (51, needs 255), {npc:6516} (52, needs 260), {npc:9164} (53, needs 265), {npc:11735} (54, needs 270) along the loop until {skill:393} 275; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 48-55."] = "순환 경로를 따라 {skill:393} 275까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:9165} (48), 라바사우루스 (48), {npc:6507} (49), {npc:6506} (49), {npc:9162} (49), 테러닥스 (50), {npc:6514} (50), {npc:6508} (50), 디메트로돈 (51, 숙련도 255), {npc:9167} (51, 숙련도 255), {npc:6513} (51, 숙련도 255), {npc:6516} (52, 숙련도 260), {npc:9164} (53, 숙련도 265), {npc:11735} (54, 숙련도 270). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 48-55.",
	-- {npc:6514} Un'Goro Gorilla
	["Pterrordax, {npc:6514}"] = "테러닥스, {npc:6514}",
	["Diemetradon"] = "디메트로돈",
	["Pterrordax"] = "테러닥스",
	-- {npc:6506} Ravasaur Runner
	["{npc:6506}, Ravasaur"] = "{npc:6506}, 라바사우루스",
	-- {npc:6506} Ravasaur Runner
	["Ravasaur, {npc:6506}"] = "라바사우루스, {npc:6506}",

	-- Step 27: Beasts 48-54: Un'Goro Crater (275-300)
	-- {zone:1449} Un'Goro Crater
	["Beasts 48-54: {zone:1449} (275-300)"] = "야수 48-54: {zone:1449} (275-300)",
	-- {npc:9165} Fledgling Pterrordax · {npc:6507} Ravasaur Hunter · {npc:6506} Ravasaur Runner · {npc:9162} Young Diemetradon · {npc:6514} Un'Goro Gorilla · {npc:6508} Venomhide Ravasaur · {npc:9167} Frenzied Pterrordax · {npc:6513} Un'Goro Stomper · {npc:6516} Un'Goro Thunderer · {npc:9164} Elder Diemetradon · {npc:11735} Stonelash Scorpid · {skill:393} Skinning
	["Kill and skin {npc:9165} (48), Ravasaur (48), {npc:6507} (49), {npc:6506} (49), {npc:9162} (49), Pterrordax (50), {npc:6514} (50), {npc:6508} (50), Diemetradon (51), {npc:9167} (51), {npc:6513} (51), {npc:6516} (52), {npc:9164} (53), {npc:11735} (54) along the loop until {skill:393} 300; skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above. Zone level 48-55."] = "순환 경로를 따라 {skill:393} 300까지 다음 야수를 처치하고 가죽을 벗기세요: {npc:9165} (48), 라바사우루스 (48), {npc:6507} (49), {npc:6506} (49), {npc:9162} (49), 테러닥스 (50), {npc:6514} (50), {npc:6508} (50), 디메트로돈 (51), {npc:9167} (51), {npc:6513} (51), {npc:6516} (52), {npc:9164} (53), {npc:11735} (54). 숙련도가 허용하는 가장 높은 레벨의 야수를 벗기세요. L 레벨 야수는 20레벨까지 숙련도 (L-10)x10, 그 이상은 Lx5가 필요합니다. 지역 레벨 48-55.",
	-- {npc:9164} Elder Diemetradon
	["{npc:9164}, Diemetradon"] = "{npc:9164}, 디메트로돈",
	-- {npc:9164} Elder Diemetradon
	["Pterrordax, {npc:9164}"] = "테러닥스, {npc:9164}",
}
