-- Korean (koKR): the guide forever/collectibles/pets/disgusting-oozeling (forever/collectibles/pets/disgusting-oozeling.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Oozes
	["Oozes"] = "수액괴물",
	-- {item:20768} Oozing Bag · {npc:12387} Large Vile Slime · {zone:1422} Western Plaguelands · {item:20769} Disgusting Oozeling
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime · Devouring Oozes = {npc:1808} Devouring Ooze
	["Oozes drop the {item:20768} about once in 20-30 kills; the best are the Vile Slimes, Devouring Oozes and the {npc:12387} in the ooze field of eastern {zone:1422} (level 54-57). Open every bag: most hold potions or herbs, and only about one bag in 50 holds the {item:20769}, so expect over a thousand kills. Both the bags and the pet can be traded: unopened bags on the Auction House are lottery tickets, the pet itself the sure buy."] = "점액질은 {item:20768}을(를) 20~30회에 한 번 떨어뜨립니다. 동부 {zone:1422} 점액 들판의 악성 슬라임, 포식 점액질, {npc:12387}(54-57레벨)이 가장 좋습니다. 모든 주머니를 여세요. 대부분 물약이나 약초이고 {item:20769}이(가) 들어 있는 주머니는 약 50개에 하나이니 천 번 이상 처치할 각오를 하세요. 주머니와 애완동물 모두 거래 가능합니다. 미개봉 주머니는 복권이고 애완동물은 확실한 구매입니다.",
	-- plural, as words: Oozing Bags = {item:20768} Oozing Bag
	["Open your Oozing Bags"] = "스며나오는 가방 열기",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Oozes drop the {item:20768}: the Vile Slimes, Large Vile Slimes and Devouring Oozes of Western Plaguelands, and the oozes of {zone:1448}, {zone:1449} and {zone:1423}, at about 0.07-0.09% per kill in our data. The waypoint is a {npc:1806} spawn in eastern {zone:1422}."] = "수액괴물이 {item:20768}을(를) 떨어뜨립니다. 서부 역병지대의 오염된 진흙괴물, 거대한 오염된 진흙괴물, 포식성 수액괴물, 그리고 {zone:1448}, {zone:1449}, {zone:1423}의 수액괴물이 우리 데이터상 처치당 약 0.07-0.09% 확률로 떨어뜨립니다. 경유지는 {zone:1422} 동쪽의 {npc:1806} 출현 지점입니다.",
	-- ["Open the {item:20768} from your bags."] = "가방에서 {item:20768}을(를) 여십시오.",
	-- ["Vile Slimes, {zone:1422}"] = "오염된 진흙괴물, {zone:1422}",
}
