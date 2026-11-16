-- Chinese (traditional) (zhTW): the guide forever/collectibles/pets/tiny-crimson-whelpling (forever/collectibles/pets/tiny-crimson-whelpling.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Wetlands whelps
	-- {zone:1437} Wetlands
	["{zone:1437} whelps"] = "{zone:1437}的雛龍",
	-- {zone:1437} Wetlands · {area:1037} Grim Batol
	-- plural, as words: Red Whelps = {npc:1042} Red Whelp · Crimson Whelps = {npc:1069} Crimson Whelp · Flamesnorting Whelps = {npc:1044} Flamesnorting Whelp
	["The red whelps live in the hills of the eastern {zone:1437}, towards {area:1037}: about 50 of them, back about five minutes after a kill in Classic's data. Red Whelps (levels 23-24) and Crimson Whelps (25-26) drop the whelpling about once in 650 kills, the Flamesnorting Whelps (26-27) mixed in with them only once in 1,600, so expect a long farm. It can be traded, so the Auction House may be quicker."] = "紅色幼龍棲息在{zone:1437}東部的丘陵，靠近{area:1037}：大約50只，按經典舊世的資料，擊殺後約五分鐘重新整理。紅色幼龍（23-24級）和赤色幼龍（25-26級）約每650次擊殺掉落一次幼龍寵物，混在其中的噴火幼龍（26-27級）掉率僅為1,600分之一，所以做好長期刷的準備。它可以交易，所以拍賣行可能更快。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Red, Crimson and Flamesnorting Whelps (levels 23-26) in the eastern {zone:1437} drop it about once in 600-1,600 kills in our data."] = "依我們的資料，{zone:1437}東部的紅色雛龍、深紅雛龍和噴火雛龍（23-26級）大約每600-1,600次擊殺會掉落一次。",
}
