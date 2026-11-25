-- Korean (koKR): the guide forever/collectibles/pets/black-tabby (forever/collectibles/pets/black-tabby.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Dalaran mages
	-- {area:279} Dalaran
	["{area:279} mages"] = "{area:279} 마법사들",
	-- {npc:1920} Dalaran Spellscribe · {area:233} Ambermill · {zone:1421} Silverpine Forest · {npc:7383} Black Tabby · {area:279} Dalaran · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills
	-- plural, as words: Dalaran Shield Guards = {npc:2271} Dalaran Shield Guard
	["The {npc:1920}, a rare level 21 mage at {area:233} in southern {zone:1421}, drops the {npc:7383} about once in 6 kills. It has a single spot and can take hours to come back, so check it whenever you pass. While it is down, the Dalaran Shield Guards, Theurgists and Summoners (level 31-35) at the {area:279} crater, where {zone:1416} meet {zone:1424}, drop it too, but only about once in 500 kills. The cat can be traded: look at the Auction House as well."] = "{npc:1920}은(는) 남부 {zone:1421}의 {area:233}에 있는 21레벨 희귀 마법사로 {npc:7383}을(를) 여섯 번에 한 번꼴로 떨어뜨립니다. 지점이 하나뿐이고 소환까지 몇 시간 걸릴 수 있으니 지날 때마다 확인하세요. 그가 없을 때는 {zone:1416}과 {zone:1424}가 만나는 {area:279} 분화구의 달란 방패수호병, 신술사, 소환사(31-35레벨)도 떨어뜨리지만 약 500회에 한 번입니다. 고양이는 거래할 수 있으니 경매장도 확인하세요.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {npc:1920}, a rare spawn among the mages at {area:233} in southern {zone:1421}, drops it about 17% of the time in our data; the other {area:279} mages at {area:233} and around the {area:279} crater drop it at about 0.2%. Kill the mages until the Spellscribe appears. Alliance players buy it on the Auction House."] = "{zone:1421} 남부 {area:233}의 마법사들 사이에 나타나는 희귀 몹인 {npc:1920}이(가) 우리 자료상 약 17% 확률로 떨어뜨립니다. {area:233}의 다른 {area:279} 마법사와 {area:279} 분화구 주변의 마법사는 약 0.2% 확률입니다. 역술사가 나타날 때까지 마법사를 처치하세요. 얼라이언스 플레이어는 경매장에서 사세요.",
}
