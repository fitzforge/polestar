-- Korean (koKR): the guide forever/collectibles/pets/disgusting-oozeling (forever/collectibles/pets/disgusting-oozeling.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Oozing Bag
	-- {item:20768} Oozing Bag · {zone:1448} Felwood · {zone:1449} Un'Goro Crater · {zone:1423} Eastern Plaguelands · {npc:1806} Vile Slime · {zone:1422} Western Plaguelands
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime · Large Vile Slimes = {npc:12387} Large Vile Slime · Devouring Oozes = {npc:1808} Devouring Ooze
	["Oozes drop the {item:20768}: the Vile Slimes, Large Vile Slimes and Devouring Oozes of Western Plaguelands, and the oozes of {zone:1448}, {zone:1449} and {zone:1423}, at about 0.07-0.09% per kill in our data. The waypoint is a {npc:1806} spawn in eastern {zone:1422}."] = "수액괴물이 {item:20768}을(를) 떨어뜨립니다. 서부 역병지대의 오염된 진흙괴물, 거대한 오염된 진흙괴물, 포식성 수액괴물, 그리고 {zone:1448}, {zone:1449}, {zone:1423}의 수액괴물이 우리 데이터상 처치당 약 0.07-0.09% 확률로 떨어뜨립니다. 경유지는 {zone:1422} 동쪽의 {npc:1806} 출현 지점입니다.",
	-- {zone:1422} Western Plaguelands
	-- plural, as words: Vile Slimes = {npc:1806} Vile Slime
	["Vile Slimes, {zone:1422}"] = "오염된 진흙괴물, {zone:1422}",

	-- Step 2: Open the Oozing Bag
	-- {item:20768} Oozing Bag
	["Open the {item:20768}"] = "{item:20768} 열기",
	-- {item:20768} Oozing Bag
	["Open the {item:20768} from your bags."] = "가방에서 {item:20768}을(를) 여십시오.",
}
