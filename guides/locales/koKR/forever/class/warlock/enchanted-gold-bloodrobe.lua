-- Korean (koKR): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6266} Menara Voidrender
	["A rare cloth robe for your 30s, which {npc:6266} makes from the parts you bring her."] = "30레벨대를 위한 희귀 천 로브. 가져온 재료로 {npc:6266}이(가) 만들어 줍니다.",

	-- Step 1: In Search of Menara Voidrender (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "31레벨에 {object:2101} {object:2164}의 {npc:461}이(가) {area:392}의 {npc:6266}에게 보냅니다.",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "31레벨에 {zone:1455}의 {npc:5172}이(가) {area:392}의 {npc:6266}에게 보냅니다.",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "31레벨에 {object:172960}의 {npc:3326}이(가) {area:392}의 {npc:6266}에게 보냅니다.",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "31레벨에 {object:36082}의 {npc:4563}이(가) {area:392}의 {npc:6266}에게 보냅니다. {zone:1420}에서 출발하는 비행선이 {zone:1411}(으)로 갑니다.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266}은(는) {area:392} 위 언덕의 탑에서 {npc:6251} 옆에 서 있습니다.",

	-- Step 6: Robes of Arcana
	-- {npc:6266} Menara Voidrender · {item:5770} Robes of Arcana · {item:3577} Gold Bar · {item:2776} Gold Ore
	["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "{npc:6266}에게 {item:5770}을(를) 가져가십시오: 재봉사는 몹이 떨어뜨리는 도안으로 만들 수 있고, 아니면 경매장에서 구매하십시오. 다음 심부름에는 {item:3577}이(가) 필요합니다: {item:2776}을(를) 제련하거나 경매장에서 구하십시오.",

	-- Step 7: Xizk Goodstitch
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {item:3577} Gold Bar
	["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670}은(는) {area:35}에서 재봉 용품을 팝니다. 그에게 {item:3577}을(를) 가져가십시오.",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "{npc:6266}에게 돌아가기",

	-- Step 9: Desolace demons
	-- {zone:1443} Desolace
	["{zone:1443} demons"] = "{zone:1443}의 악마",
	-- {area:603} Sargeron · {zone:1443} Desolace
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal
	["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "{zone:1443} 북동쪽 {area:603}의 서릿발분노 사티로스가 피를, 남쪽 만노로크 소굴의 하급 지옥불정령이 돌을 가지고 있습니다.",
	["Vials of Hatefury Blood"] = "서릿발분노의 사티로스 피",

	-- Step 10: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "다시 {npc:6266}에게",

	-- Step 11: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:2670} in {area:35} has the thread for you."] = "{area:35}의 {npc:2670}이(가) 실을 가지고 있습니다.",

	-- Step 12: Smoldering Coal
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "{zone:1417} 서부의 불의 정령인 떠도는 불의 정령이 석탄을 떨어뜨립니다.",

	-- Step 13: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coal and a {item:6265}. Wait while she completes the robe, then speak to her again."] = "실, 석탄, {item:6265}을(를) 가지고 {npc:6266}에게 돌아가십시오. 로브를 완성할 때까지 기다린 뒤 다시 말을 거십시오.",
	["Wait for the robe"] = "로브 완성 기다리기",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of {area:602}, in the south, the stone."] = "{zone:1443} 북동쪽 {area:603}의 서릿발분노 사티로스가 피를, 남쪽 {area:602}의 하급 지옥불정령이 돌을 가지고 있습니다.",
}
