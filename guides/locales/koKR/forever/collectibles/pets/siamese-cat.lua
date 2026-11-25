-- Korean (koKR): the guide forever/collectibles/pets/siamese-cat (forever/collectibles/pets/siamese-cat.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Siamese Cat"] = "샴고양이",

	-- Step 1: The Deadmines: Cookie
	-- {area:1581} The Deadmines
	["{area:1581}: Cookie"] = "{area:1581}: 쿠키",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581} is a group of five under {area:20}: the mine mouth is in {area:20}, the instance portal deep inside the mine. Cookie, the murloc cook, waits on a small island under the pirate ship at the far end, an optional boss; his cooking heals him, so interrupt it. He drops the Siamese about 15% of the time in Classic's data: expect several runs. The carrier can be traded, so check the Auction House too."] = "{area:1581}은 {area:20} 아래 5인 던전입니다. 광산 입구는 {area:20}에 있고 인스턴스 차원문은 광산 깊은 곳에 있습니다. 멀록 요리사 쿠키는 끝 쪽 해적선 아래 작은 섬에 있는 선택 보스입니다. 요리가 체력을 회복시키니 차단하세요. 클래식 데이터상 샴 고양이는 약 15%로 떨어지니 여러 번 돌아야 합니다. 운반 상자는 거래 가능하니 경매장도 확인하세요.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, {area:20} 광산 안",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581} portal, inside the {area:20} mine"] = "{area:1581} 입구, {area:20} 광산 안",
	["Cookie"] = "쿠키",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. Cookie, the murloc cook near the ship at the end, drops the Siamese about 15% of the time in our data."] = "{area:1581}은(는) {area:20} 아래의 5인 던전입니다. 던전 입구는 {area:20} 광산 안에 있습니다. 마지막 배 근처의 멀록 요리사 쿠키가 우리 자료상 약 15% 확률로 샴고양이를 떨어뜨립니다.",
}
