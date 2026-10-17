-- Korean (koKR): the guide forever/professions/cooking (forever/professions/cooking.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Cooking
	-- {skill:185} Cooking
	["Learn {skill:185}"] = "{skill:185} 배우기",
	-- {skill:185} Cooking
	["Any {skill:185} trainer of your faction teaches Apprentice {skill:185} (character level 5); the arrow picks the nearest."] = "진영의 모든 {skill:185} 상급자가 초급 {skill:185}을(를) 가르칩니다(캐릭터 레벨 5). 화살표가 가장 가까운 곳을 가리킵니다.",

	-- Step 2: Charred Wolf Meat: ingredients
	-- {spell:2538} Charred Wolf Meat
	["{spell:2538}: ingredients"] = "{spell:2538}: 재료",
	-- {zone:1429} Elwynn Forest
	["Prowler (86%) in {zone:1429}, or wherever the arrow points"] = "{zone:1429}의 굶주린 늑대 (86%), 또는 화살표가 가리키는 곳",

	-- Step 3: Charred Wolf Meat (1-50)
	-- {spell:2538} Charred Wolf Meat · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:2538} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2538}은(는) 1부터 주황색입니다(노란색 45, 회색 85). 50까지 약 50번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 4: Roasted Boar Meat: ingredients
	-- {spell:2540} Roasted Boar Meat
	["{spell:2540}: ingredients"] = "{spell:2540}: 재료",
	-- {npc:1689} Scarred Crag Boar · {npc:1127} Elder Crag Boar · {zone:1426} Dun Morogh
	["{npc:1689} (38%), {npc:1127} (36%) in {zone:1426}, or wherever the arrow points"] = "{zone:1426}의 {npc:1689} (38%), {npc:1127} (36%), 또는 화살표가 가리키는 곳",

	-- Step 5: Roasted Boar Meat (1-50)
	-- {spell:2540} Roasted Boar Meat · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:2540} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:2540}은(는) 1부터 주황색입니다(노란색 45, 회색 85). 50까지 약 50번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 6: Brilliant Smallfish: shopping
	-- {item:6290} Brilliant Smallfish
	["{item:6290}: shopping"] = "{item:6290}: 구매",
	["The arrow picks the nearest vendor of your faction for each item."] = "화살표가 아이템마다 진영의 가장 가까운 상인을 가리킵니다.",

	-- Step 7: Brilliant Smallfish: ingredients
	-- {item:6290} Brilliant Smallfish
	["{item:6290}: ingredients"] = "{item:6290}: 재료",
	-- {area:702} Rut'theran Village
	["{area:702} docks"] = "{area:702} 부두",
	-- {item:6291} Raw Brilliant Smallfish · {skill:356} Fishing
	["Catch about 50 {item:6291} here by fishing (see the {skill:356} guide)."] = "이곳에서 낚시로 {item:6291} 약 50개를 잡으세요({skill:356} 가이드 참고).",

	-- Step 8: Brilliant Smallfish (1-50)
	-- {item:6290} Brilliant Smallfish · {object:29784} Basic Campfire · {skill:185} Cooking · {item:6291} Raw Brilliant Smallfish · {zone:1438} Teldrassil
	["{item:6290} is orange from 1 (yellow at 45, grey at 85): about 50 crafts to 50. Cook at any fire: {object:29784} comes with {skill:185}. {item:6291} is the common catch in {zone:1438}'s waters."] = "{item:6290}은(는) 1부터 주황색입니다(노란색 45, 회색 85). 50까지 약 50번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다. {item:6291}은(는) {zone:1438} 물가에서 흔히 낚입니다.",

	-- Step 9: Roasted Boar Meat: ingredients
	-- {npc:3099} Dire Mottled Boar · {npc:3100} Elder Mottled Boar · {zone:1411} Durotar
	["{npc:3099} (99%), {npc:3100} (74%) in {zone:1411}, or wherever the arrow points"] = "{zone:1411}의 {npc:3099} (99%), {npc:3100} (74%), 또는 화살표가 가리키는 곳",

	-- Step 11: Charred Wolf Meat: ingredients
	-- {npc:2960} Prairie Wolf Alpha · {npc:2959} Prairie Stalker · {zone:1412} Mulgore
	["{npc:2960} (82%), {npc:2959} (77%) in {zone:1412}, or wherever the arrow points"] = "{zone:1412}의 {npc:2960} (82%), {npc:2959} (77%), 또는 화살표가 가리키는 곳",

	-- Step 13: Charred Wolf Meat: ingredients
	-- {npc:1549} Ravenous Darkhound · {zone:1420} Tirisfal Glades
	["{npc:1549} (88%) in {zone:1420}, or wherever the arrow points"] = "{zone:1420}의 {npc:1549} (88%), 또는 화살표가 가리키는 곳",

	-- Step 15: Journeyman Cooking
	-- {skill:185} Cooking
	["Journeyman {skill:185}"] = "수습 {skill:185}",
	-- {skill:185} Cooking
	["Journeyman {skill:185} raises the cap to 150; it needs skill 50 and character level 10: the arrow picks the nearest {skill:185} trainer of your faction."] = "수습 {skill:185}은(는) 최대 숙련도를 150으로 올립니다. 숙련도 50, 캐릭터 레벨 10이 필요합니다. 화살표가 진영의 가장 가까운 {skill:185} 상급자를 가리킵니다.",

	-- Step 16: Goretusk Liver Pie: shopping
	-- {item:724} Goretusk Liver Pie
	["{item:724}: shopping"] = "{item:724}: 구매",

	-- Step 17: Goretusk Liver Pie: ingredients
	-- {item:724} Goretusk Liver Pie
	["{item:724}: ingredients"] = "{item:724}: 재료",
	-- {npc:547} Great Goretusk · {npc:157} Goretusk · {zone:1436} Westfall
	["{npc:547} (35%), {npc:157} (34%) in {zone:1436}, or wherever the arrow points"] = "{zone:1436}의 {npc:547} (35%), {npc:157} (34%), 또는 화살표가 가리키는 곳",

	-- Step 18: Goretusk Liver Pie (50-100)
	-- {item:724} Goretusk Liver Pie · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:724} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:724}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 100까지 약 52번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 19: Loch Frenzy Delight: shopping
	-- {item:6316} Loch Frenzy Delight
	["{item:6316}: shopping"] = "{item:6316}: 구매",

	-- Step 20: Loch Frenzy Delight: ingredients
	-- {item:6316} Loch Frenzy Delight
	["{item:6316}: ingredients"] = "{item:6316}: 재료",
	-- {npc:1193} Loch Frenzy · {zone:1432} Loch Modan
	["{npc:1193} (50%) in {zone:1432}, or wherever the arrow points"] = "{zone:1432}의 {npc:1193} (50%), 또는 화살표가 가리키는 곳",

	-- Step 21: Loch Frenzy Delight (50-100)
	-- {item:6316} Loch Frenzy Delight · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:6316} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:6316}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 100까지 약 52번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 22: Rainbow Fin Albacore: shopping
	-- {item:5095} Rainbow Fin Albacore
	["{item:5095}: shopping"] = "{item:5095}: 구매",

	-- Step 23: Rainbow Fin Albacore: ingredients
	-- {item:5095} Rainbow Fin Albacore
	["{item:5095}: ingredients"] = "{item:5095}: 재료",
	-- {area:442} Auberdine
	["{area:442} docks"] = "{area:442} 부두",
	-- {item:6361} Raw Rainbow Fin Albacore · {skill:356} Fishing
	["Catch about 68 {item:6361} here by fishing (see the {skill:356} guide)."] = "이곳에서 낚시로 {item:6361} 약 68개를 잡으세요({skill:356} 가이드 참고).",

	-- Step 24: Rainbow Fin Albacore (50-110)
	-- {item:5095} Rainbow Fin Albacore · {object:29784} Basic Campfire · {skill:185} Cooking · {skill:356} Fishing · {area:442} Auberdine · {item:6361} Raw Rainbow Fin Albacore
	["{item:5095} is orange from 50 (yellow at 90, grey at 130): about 68 crafts to 110. Cook at any fire: {object:29784} comes with {skill:185}. {skill:356} off the {area:442} docks catches {item:6361}."] = "{item:5095}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 110까지 약 68번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다. {area:442} 부두에서 {skill:356}을(를) 하면 {item:6361}이(가) 낚입니다.",

	-- Step 25: Strider Stew: shopping
	-- {item:5477} Strider Stew
	["{item:5477}: shopping"] = "{item:5477}: 구매",

	-- Step 26: Strider Stew: ingredients
	-- {item:5477} Strider Stew
	["{item:5477}: ingredients"] = "{item:5477}: 재료",
	-- {npc:3244} Greater Plainstrider · {zone:1413} The Barrens
	["{npc:3244} (33%) in {zone:1413}, or wherever the arrow points"] = "{zone:1413}의 {npc:3244} (33%), 또는 화살표가 가리키는 곳",

	-- Step 27: Strider Stew (50-100)
	-- {item:5477} Strider Stew · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5477} is orange from 50 (yellow at 90, grey at 130): about 52 crafts to 100. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5477}은(는) 50부터 주황색입니다(노란색 90, 회색 130). 100까지 약 52번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 28: Crocolisk Steak: shopping
	-- {spell:3370} Crocolisk Steak
	["{spell:3370}: shopping"] = "{spell:3370}: 구매",

	-- Step 29: Crocolisk Steak: ingredients
	-- {spell:3370} Crocolisk Steak
	["{spell:3370}: ingredients"] = "{spell:3370}: 재료",
	-- {npc:1400} Wetlands Crocolisk · {zone:1437} Wetlands
	["{npc:1400} (50%) in {zone:1437}, or wherever the arrow points"] = "{zone:1437}의 {npc:1400} (50%), 또는 화살표가 가리키는 곳",

	-- Step 30: Crocolisk Steak (100-125)
	-- {spell:3370} Crocolisk Steak · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3370} is orange from 100 (yellow at 120, grey at 160): about 26 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}은(는) 100부터 주황색입니다(노란색 120, 회색 160). 125까지 약 26번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 31: Lean Venison: shopping
	-- {item:5480} Lean Venison
	["{item:5480}: shopping"] = "{item:5480}: 구매",

	-- Step 32: Lean Venison: ingredients
	-- {item:5480} Lean Venison
	["{item:5480}: ingredients"] = "{item:5480}: 재료",
	-- {npc:3818} Elder Shadowhorn Stag · {zone:1440} Ashenvale
	["{npc:3818} (53%) in {zone:1440}, or wherever the arrow points"] = "{zone:1440}의 {npc:3818} (53%), 또는 화살표가 가리키는 곳",

	-- Step 33: Lean Venison (110-125)
	-- {item:5480} Lean Venison · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5480} is orange from 110 (yellow at 150, grey at 190): about 15 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}은(는) 110부터 주황색입니다(노란색 150, 회색 190). 125까지 약 15번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 34: Crispy Lizard Tail: shopping
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: shopping"] = "{item:5479}: 구매",

	-- Step 35: Crispy Lizard Tail: ingredients
	-- {item:5479} Crispy Lizard Tail
	["{item:5479}: ingredients"] = "{item:5479}: 재료",
	-- {npc:3239} Thunderhead · {zone:1413} The Barrens
	["{npc:3239} (59%), Owatanka (35%) in {zone:1413}, or wherever the arrow points"] = "{zone:1413}의 {npc:3239} (59%), 오와탄카 (35%), 또는 화살표가 가리키는 곳",

	-- Step 36: Crispy Lizard Tail (100-125)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5479} is orange from 100 (yellow at 140, grey at 180): about 25 crafts to 125. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}은(는) 100부터 주황색입니다(노란색 140, 회색 180). 125까지 약 25번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 37: Expert Cooking
	-- {skill:185} Cooking
	["Expert {skill:185}"] = "숙련 {skill:185}",
	-- {skill:185} Cooking · {item:16072} Expert Cookbook
	["Expert {skill:185} raises the cap to 225; it needs skill 125 and character level 20: it is a book, {item:16072}; the arrow picks its nearest seller for your faction. Buy it and read it."] = "숙련 {skill:185}은(는) 최대 숙련도를 225로 올립니다. 숙련도 125, 캐릭터 레벨 20이 필요합니다. 책 {item:16072}(으)로 배우며, 화살표가 진영의 가장 가까운 판매 상인을 가리킵니다. 사서 읽으세요.",
	-- {item:16072} Expert Cookbook · {skill:185} Cooking
	["Buy and read {item:16072} (Expert {skill:185})"] = "{item:16072} 사서 읽기 (숙련 {skill:185})",

	-- Step 40: Crocolisk Steak (125-130)
	-- {spell:3370} Crocolisk Steak · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3370} is yellow from 125 (yellow at 120, grey at 160): about 7 crafts to 130. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3370}은(는) 125부터 노란색입니다(노란색 120, 회색 160). 130까지 약 7번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 41: Curiously Tasty Omelet: shopping
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: shopping"] = "{spell:3376}: 구매",

	-- Step 42: Curiously Tasty Omelet: ingredients
	-- {spell:3376} Curiously Tasty Omelet
	["{spell:3376}: ingredients"] = "{spell:3376}: 재료",
	-- {npc:1018} Highland Razormaw · {npc:1019} Elder Razormaw · {zone:1437} Wetlands
	["{npc:1018} (72%), {npc:1019} (67%) in {zone:1437}, or wherever the arrow points"] = "{zone:1437}의 {npc:1018} (72%), {npc:1019} (67%), 또는 화살표가 가리키는 곳",

	-- Step 43: Curiously Tasty Omelet (130-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3376} is orange from 130 (yellow at 170, grey at 210): about 46 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}은(는) 130부터 주황색입니다(노란색 170, 회색 210). 175까지 약 46번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 46: Lean Venison (125-150)
	-- {item:5480} Lean Venison · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5480} is orange from 125 (yellow at 150, grey at 190): about 25 crafts to 150. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5480}은(는) 125부터 주황색입니다(노란색 150, 회색 190). 150까지 약 25번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 49: Curiously Tasty Omelet (150-175)
	-- {spell:3376} Curiously Tasty Omelet · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3376} is orange from 150 (yellow at 170, grey at 210): about 26 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3376}은(는) 150부터 주황색입니다(노란색 170, 회색 210). 175까지 약 26번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 52: Crispy Lizard Tail (125-140)
	-- {item:5479} Crispy Lizard Tail · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:5479} is orange from 125 (yellow at 140, grey at 180): about 15 crafts to 140. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:5479}은(는) 125부터 주황색입니다(노란색 140, 회색 180). 140까지 약 15번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 53: Hot Lion Chops: shopping
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: shopping"] = "{spell:3398}: 구매",

	-- Step 54: Hot Lion Chops: ingredients
	-- {spell:3398} Hot Lion Chops
	["{spell:3398}: ingredients"] = "{spell:3398}: 재료",
	-- {npc:2385} Feral Mountain Lion · {zone:1424} Hillsbrad Foothills
	["{npc:2385} (56%) in {zone:1424}, or wherever the arrow points"] = "{zone:1424}의 {npc:2385} (56%), 또는 화살표가 가리키는 곳",

	-- Step 55: Hot Lion Chops (140-175)
	-- {spell:3398} Hot Lion Chops · {object:29784} Basic Campfire · {skill:185} Cooking
	["{spell:3398} is orange from 140 (yellow at 175, grey at 215): about 35 crafts to 175. Cook at any fire: {object:29784} comes with {skill:185}."] = "{spell:3398}은(는) 140부터 주황색입니다(노란색 175, 회색 215). 175까지 약 35번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 56: Roast Raptor: shopping
	-- {item:12210} Roast Raptor
	["{item:12210}: shopping"] = "{item:12210}: 구매",

	-- Step 57: Roast Raptor: ingredients
	-- {item:12210} Roast Raptor
	["{item:12210}: ingredients"] = "{item:12210}: 재료",
	-- {npc:4352} Bloodfen Screecher · {npc:4351} Bloodfen Raptor · {zone:1445} Dustwallow Marsh
	["{npc:4352} (52%), {npc:4351} (51%) in {zone:1445}, or wherever the arrow points"] = "{zone:1445}의 {npc:4352} (52%), {npc:4351} (51%), 또는 화살표가 가리키는 곳",

	-- Step 58: Roast Raptor (175-215)
	-- {item:12210} Roast Raptor · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:12210} is orange from 175 (yellow at 215, grey at 255): about 40 crafts to 215. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12210}은(는) 175부터 주황색입니다(노란색 215, 회색 255). 215까지 약 40번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 59: Heavy Kodo Stew: shopping
	-- {item:12215} Heavy Kodo Stew
	["{item:12215}: shopping"] = "{item:12215}: 구매",

	-- Step 60: Heavy Kodo Stew: ingredients
	-- {item:12215} Heavy Kodo Stew
	["{item:12215}: ingredients"] = "{item:12215}: 재료",
	-- {npc:4701} Dying Kodo · {npc:4702} Ancient Kodo · {npc:4700} Aged Kodo · {zone:1443} Desolace
	["{npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%) in {zone:1443}, or wherever the arrow points"] = "{zone:1443}의 {npc:4701} (55%), {npc:4702} (54%), {npc:4700} (40%), 또는 화살표가 가리키는 곳",

	-- Step 61: Heavy Kodo Stew (215-225)
	-- {item:12215} Heavy Kodo Stew · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:12215} is orange from 215 (yellow at 240, grey at 280): about 10 crafts to 225. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}은(는) 215부터 주황색입니다(노란색 240, 회색 280). 225까지 약 10번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 62: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1455} Ironforge
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1455} sends you; it needs skill 225 and level 35."] = "전문 {skill:185}은(는) {area:976}({zone:1446})의 {npc:8125}에게 배웁니다. {zone:1455}의 요리 상급자가 보내 줍니다. 숙련도 225, 레벨 35가 필요합니다.",

	-- Step 63: Dirge Quikcleave
	-- {skill:185} Cooking · {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {zone:1446} Tanaris · {zone:1454} Orgrimmar
	["Artisan {skill:185} comes from {npc:8125} in {area:976} ({zone:1446}). The cooking trainer in {zone:1454} sends you; it needs skill 225 and level 35."] = "전문 {skill:185}은(는) {area:976}({zone:1446})의 {npc:8125}에게 배웁니다. {zone:1454}의 요리 상급자가 보내 줍니다. 숙련도 225, 레벨 35가 필요합니다.",

	-- Step 65: Alterac Swiss
	-- {quest:6610} Clamlette Surprise · {item:8932} Alterac Swiss
	["{quest:6610} asks for 20 {item:8932} (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest."] = "{quest:6610}에는 {item:8932} 20개가 필요합니다(퀘스트 목록 확인). 여관주인과 음식 상인이 팔며, 화살표가 가장 가까운 곳을 가리킵니다.",

	-- Step 66: Giant Eggs
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs"] = "거대한 알",
	-- {zone:1448} Felwood
	-- plural, as words: Giant Eggs = {item:12207} Giant Egg
	["Giant Eggs drop from the Ironbeak owls of {zone:1448}."] = "거대한 알은 {zone:1448}의 무쇠부리 올빼미가 떨어뜨립니다.",

	-- Step 67: Zesty Clam Meat
	-- {item:7974} Zesty Clam Meat · {npc:8125} Dirge Quikcleave
	["{item:7974} has no drop data: buy it at the Gadgetzan Auction House, next to {npc:8125}, or open clams looted from coastal creatures."] = "{item:7974}은(는) 획득 데이터가 없습니다. 가젯잔 경매장({npc:8125} 옆)에서 사거나, 해안 생물에게서 얻은 조개를 여세요.",

	-- Step 68: Dirge Quikcleave
	-- {skill:185} Cooking
	["Artisan {skill:185}"] = "전문 {skill:185}",

	-- Step 71: Heavy Kodo Stew (225-240)
	-- {item:12215} Heavy Kodo Stew · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:12215} is orange from 225 (yellow at 240, grey at 280): about 15 crafts to 240. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12215}은(는) 225부터 주황색입니다(노란색 240, 회색 280). 240까지 약 15번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",

	-- Step 72: Monster Omelet: shopping
	-- {item:12218} Monster Omelet
	["{item:12218}: shopping"] = "{item:12218}: 구매",

	-- Step 73: Monster Omelet: ingredients
	-- {item:12218} Monster Omelet
	["{item:12218}: ingredients"] = "{item:12218}: 재료",
	-- {npc:7099} Ironbeak Hunter · {zone:1448} Felwood
	["{npc:7099} (40%) in {zone:1448}, or wherever the arrow points"] = "{zone:1448}의 {npc:7099} (40%), 또는 화살표가 가리키는 곳",

	-- Step 74: Monster Omelet (240-300)
	-- {item:12218} Monster Omelet · {object:29784} Basic Campfire · {skill:185} Cooking
	["{item:12218} is orange from 240 (yellow at 265, grey at 305): about 105 crafts to 300. Cook at any fire: {object:29784} comes with {skill:185}."] = "{item:12218}은(는) 240부터 주황색입니다(노란색 265, 회색 305). 300까지 약 105번 만드세요. 아무 불에서나 요리하세요. {object:29784}은(는) {skill:185}와(과) 함께 배웁니다.",
}
