-- Korean (koKR): the guide forever/collectibles/pets/chicken-egg (forever/collectibles/pets/chicken-egg.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: CLUCK!
	-- {npc:233} Farmer Saldean · {quest:3861} CLUCK! · {item:11109} Special Chicken Feed · {item:11110} Chicken Egg
	["Find a chicken at {npc:233}'s farm and type /chicken at it until it offers {quest:3861}. Buy {item:11109} from {npc:233}, go back, /cheer at the same chicken, then hand in the feed. The chicken lays an egg: loot it for your {item:11110} pet."] = "{npc:233}의 농장에서 닭을 찾아 {quest:3861} 퀘스트를 줄 때까지 /chicken을 입력하십시오. {npc:233}에게서 {item:11109}을(를) 구매하고 돌아가 같은 닭에게 /cheer를 한 뒤 모이를 건네십시오. 닭이 알을 낳으면 획득해 {item:11110} 애완동물을 얻으십시오.",
	-- {item:11109} Special Chicken Feed · {npc:233} Farmer Saldean
	["{item:11109}, from {npc:233}"] = "{item:11109}, {npc:233}에게서",
	-- {object:161513} Farm Chicken Egg
	["Loot the {object:161513} the chicken lays"] = "닭이 낳은 {object:161513} 획득",
}
