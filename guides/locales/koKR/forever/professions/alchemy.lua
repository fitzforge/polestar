-- Korean (koKR): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Alchemy
	-- {skill:171} Alchemy
	["Learn {skill:171}"] = "{skill:171} 배우기",
	-- {skill:171} Alchemy · {skill:182} Herbalism · {item:2447} Peacebloom · {item:765} Silverleaf
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Apprentice {skill:171} lets you craft up to 75 for 10c, at any character level. Any {skill:171} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:182}: {item:2447} and {item:765} grow in every starting zone, and Empty Vials cost 4c at any alchemy or trade supplies vendor. 1-75 takes about 3s 28c of vendor goods, plus 82 {item:765} and 110 {item:2447} to gather or buy."] = "초급 {skill:171}은(는) 10코퍼로 75까지 제작할 수 있게 해 주며, 캐릭터 레벨 제한이 없습니다. 당신 진영의 어떤 {skill:171} 상급자에게서나 가르치며, 화살표가 가장 가까운 이를 가리킵니다. {skill:182}와(과) 함께 하세요: {item:2447}와(과) {item:765}은(는) 모든 시작 지대에 자라고, 유리 약병은 어떤 연금술 또는 무역 용품 상인에게서나 4코퍼입니다. 1-75에는 상인 재료 약 3실버 28코퍼와 함께 채집하거나 구매할 {item:765} 82개, {item:2447} 110개가 필요합니다.",

	-- Step 2: Alchemy 1-75: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 1-75: vendor goods"] = "{skill:171} 1-75: 상인 재료",
	-- {item:3371} Empty Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 82 {item:3371} (3s 28c); about 3s 28c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:3371} 82개(3실버 28코퍼). 모두 약 3실버 28코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1286}, {npc:5503}, {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348}, {npc:3334}).",

	-- Step 3: Get Silverleaf (Elwynn Forest)
	-- {item:765} Silverleaf · {zone:1429} Elwynn Forest
	["Get {item:765} ({zone:1429})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1429} is marked. Or buy them at the Auction House."] = "",

	-- Step 4: Get Silverleaf (Dun Morogh)
	-- {item:765} Silverleaf · {zone:1426} Dun Morogh
	["Get {item:765} ({zone:1426})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1426} is marked. Or buy them at the Auction House."] = "",

	-- Step 5: Get Silverleaf (Teldrassil)
	-- {item:765} Silverleaf · {zone:1438} Teldrassil
	["Get {item:765} ({zone:1438})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1438} Teldrassil
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1438} is marked. Or buy them at the Auction House."] = "",

	-- Step 6: Get Silverleaf (Zephras Isle)
	-- {item:765} Silverleaf · {zone:2521} Zephras Isle
	["Get {item:765} ({zone:2521})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:2521} is marked. Or buy them at the Auction House."] = "",

	-- Step 7: Get Silverleaf (Durotar)
	-- {item:765} Silverleaf · {zone:1411} Durotar
	["Get {item:765} ({zone:1411})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1411} Durotar
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1411} is marked. Or buy them at the Auction House."] = "",

	-- Step 8: Get Silverleaf (Mulgore)
	-- {item:765} Silverleaf · {zone:1412} Mulgore
	["Get {item:765} ({zone:1412})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1412} Mulgore
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1412} is marked. Or buy them at the Auction House."] = "",

	-- Step 9: Get Silverleaf (Tirisfal Glades)
	-- {item:765} Silverleaf · {zone:1420} Tirisfal Glades
	["Get {item:765} ({zone:1420})"] = "",
	-- {item:765} Silverleaf · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["You need 82 {item:765} for {skill:171} 1-75: {item:5997}. {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1420} is marked. Or buy them at the Auction House."] = "",

	-- Step 10: Get Peacebloom (Elwynn Forest)
	-- {item:2447} Peacebloom · {zone:1429} Elwynn Forest
	["Get {item:2447} ({zone:1429})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1429} is marked. Or buy them at the Auction House."] = "",

	-- Step 11: Get Peacebloom (Dun Morogh)
	-- {item:2447} Peacebloom · {zone:1426} Dun Morogh
	["Get {item:2447} ({zone:1426})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1426} is marked. Or buy them at the Auction House."] = "",

	-- Step 12: Get Peacebloom (Teldrassil)
	-- {item:2447} Peacebloom · {zone:1438} Teldrassil
	["Get {item:2447} ({zone:1438})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1438} Teldrassil
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1438} is marked. Or buy them at the Auction House."] = "",

	-- Step 13: Get Peacebloom (Zephras Isle)
	-- {item:2447} Peacebloom · {zone:2521} Zephras Isle
	["Get {item:2447} ({zone:2521})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:2521} is marked. Or buy them at the Auction House."] = "",

	-- Step 14: Get Peacebloom (Durotar)
	-- {item:2447} Peacebloom · {zone:1411} Durotar
	["Get {item:2447} ({zone:1411})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1411} Durotar
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1411} is marked. Or buy them at the Auction House."] = "",

	-- Step 15: Get Peacebloom (Mulgore)
	-- {item:2447} Peacebloom · {zone:1412} Mulgore
	["Get {item:2447} ({zone:1412})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1412} Mulgore
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1412} is marked. Or buy them at the Auction House."] = "",

	-- Step 16: Get Peacebloom (Tirisfal Glades)
	-- {item:2447} Peacebloom · {zone:1420} Tirisfal Glades
	["Get {item:2447} ({zone:1420})"] = "",
	-- {item:2447} Peacebloom · {skill:171} Alchemy · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["You need 110 {item:2447} for {skill:171} 1-75: {item:5997} and {spell:2331} (28 of them for 75-150: get them all now). {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1420} is marked. Or buy them at the Auction House."] = "",

	-- Step 17: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997}: 75까지",
	-- {item:5997} Elixir of Minor Defense · {item:765} Silverleaf · {item:2447} Peacebloom · {item:3371} Empty Vial
	["{item:5997} is orange at 1 (yellow 55, green 75, grey 95): about 82 crafts to 75. Each takes 1 {item:765}, 1 {item:2447} and 1 {item:3371}. Known from the start and the cheapest way through the Apprentice range. Keep the elixirs (armour while you level) or sell them."] = "{item:5997}은(는) 1에 주황색입니다(노란색 55, 초록색 75, 회색 95). 75까지 약 82번 만드십시오. 한 번에 {item:765} 1개, {item:2447} 1개, {item:3371} 1개가 듭니다. 처음부터 알려져 있고 초급 구간을 통과하는 가장 저렴한 방법입니다. 엘릭서(레벨을 올리는 동안 방어구 역할)를 직접 쓰거나 판매하세요.",

	-- Step 18: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "수습 {skill:171}",
	-- {skill:171} Alchemy · {npc:4900} Alchemist Narett · {zone:1445} Dustwallow Marsh · {npc:2837} Jaxin Chong · {zone:1434} Stranglethorn Vale · {npc:3964} Kylanna · {zone:1440} Ashenvale · {npc:5499} Lilyssia Nightbreeze · {zone:1453} Stormwind City · {npc:11042} Sylvanna Forestmoon · {zone:1457} Darnassus · {npc:5177} Tally Berryfizz · {zone:1455} Ironforge · {npc:3009} Bena Winterhoof · {zone:1456} Thunder Bluff · {npc:4609} Doctor Marsh · {zone:1458} Undercity · {npc:2391} Serge Hinott · {zone:1424} Hillsbrad Foothills · {npc:3347} Yelmak · {zone:1454} Orgrimmar · {spell:2331} Minor Mana Potion · {spell:1230564} Mana Well · {item:2447} Peacebloom · {item:3371} Empty Vial · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed
	["Journeyman raises the cap from 75 to 150 for 4s 50c (Classic's price; Forever's is not in the data); it needs {skill:171} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:171} trainer teaches it: Alliance {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) and {npc:5177} ({zone:1455}); Horde {npc:3009} ({zone:1456}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:2391} ({zone:1424}) and {npc:3347} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:2331} (from 25, 1s). Also learn {spell:1230564} (1s): Forever's {skill:171} camp item, 1 {item:2447} and 1 {item:3371}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:171} quest from your starting area's camping guide (after The Great Outdoors) sends you to an alchemy trainer who teaches it free. 75-150 takes about 1s of recipes and 9s 8c of vendor goods, plus 77 {item:785}, 152 {item:2450} and 54 {item:2453} to gather or buy."] = "수습 단계는 4실버 50코퍼(클래식 가격이며, Forever 가격은 데이터에 없습니다)로 최대 숙련도를 75에서 150으로 올립니다. {skill:171} 50과 캐릭터 레벨 10이 필요하므로, 50이 되면 언제 들러도 배울 수 있습니다. 모든 {skill:171} 상급자가 가르치지는 않습니다: 얼라이언스는 {npc:4900}({zone:1445}), {npc:2837}({zone:1434}), {npc:3964}({zone:1440}), {npc:5499}({zone:1453}), {npc:11042}({zone:1457}), {npc:5177}({zone:1455}), 호드는 {npc:3009}({zone:1456}), {npc:4609}({zone:1458}), {npc:2837}({zone:1434}), {npc:2391}({zone:1424}), {npc:3347}({zone:1454})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:2331}(25부터, 1실버). {spell:1230564}(1실버)도 배우세요. Forever의 {skill:171} 야영 아이템으로, {item:2447} 1개와 {item:3371} 1개가 들며, 야영지의 모닥불 옆에 놓으면 강화 효과를 줍니다. 시작 지역의 야영 안내인이 ('드넓은 야외' 이후) 주는 '야영 입문: {skill:171}' 퀘스트는 이것을 무료로 가르쳐 주는 연금술 상급자에게 보내 줍니다. 75-150에는 제조법 약 1실버와 상인 재료 약 9실버 8코퍼, 그리고 채집하거나 살 {item:785} 77개, {item:2450} 152개, {item:2453} 54개가 듭니다.",

	-- Step 19: Alchemy 75-150: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 75-150: vendor goods"] = "{skill:171} 75-150: 상인 재료",
	-- {item:3371} Empty Vial · {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 77 {item:3371} (3s 8c) and 15 {item:3372} (6s); about 9s 8c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:3371} 77개(3실버 8코퍼)와(과) {item:3372} 15개(6실버). 모두 약 9실버 8코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1286}, {npc:5503}, {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348}, {npc:3334}).",

	-- Step 20: Get Mageroyal (Westfall)
	-- {item:785} Mageroyal · {zone:1436} Westfall
	["Get {item:785} ({zone:1436})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1436} Westfall
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1436} is marked. Or buy them at the Auction House."] = "",

	-- Step 21: Get Mageroyal (Loch Modan)
	-- {item:785} Mageroyal · {zone:1432} Loch Modan
	["Get {item:785} ({zone:1432})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1432} Loch Modan
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1432} is marked. Or buy them at the Auction House."] = "",

	-- Step 22: Get Mageroyal (Teldrassil)
	-- {item:785} Mageroyal · {zone:1438} Teldrassil
	["Get {item:785} ({zone:1438})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1438} Teldrassil
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1438} is marked. Or buy them at the Auction House."] = "",

	-- Step 23: Get Mageroyal (Zephras Isle)
	-- {item:785} Mageroyal · {zone:2521} Zephras Isle
	["Get {item:785} ({zone:2521})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:2521} is marked. Or buy them at the Auction House."] = "",

	-- Step 24: Get Mageroyal (The Barrens)
	-- {item:785} Mageroyal · {zone:1413} The Barrens
	["Get {item:785} ({zone:1413})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1413} The Barrens
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 25: Get Mageroyal (Silverpine Forest)
	-- {item:785} Mageroyal · {zone:1421} Silverpine Forest
	["Get {item:785} ({zone:1421})"] = "",
	-- {item:785} Mageroyal · {skill:171} Alchemy · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["You need 77 {item:785} for {skill:171} 75-150: {spell:2331} and {spell:3171}. {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1421} is marked. Or buy them at the Auction House."] = "",

	-- Step 26: Get Briarthorn (Westfall)
	-- {item:2450} Briarthorn · {zone:1436} Westfall
	["Get {item:2450} ({zone:1436})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1436} is marked. Or buy them at the Auction House."] = "",

	-- Step 27: Get Briarthorn (Loch Modan)
	-- {item:2450} Briarthorn · {zone:1432} Loch Modan
	["Get {item:2450} ({zone:1432})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1432} is marked. Or buy them at the Auction House."] = "",

	-- Step 28: Get Briarthorn (Darkshore)
	-- {item:2450} Briarthorn · {zone:1439} Darkshore
	["Get {item:2450} ({zone:1439})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1439} is marked. Or buy them at the Auction House."] = "",

	-- Step 29: Get Briarthorn (The Barrens)
	-- {item:2450} Briarthorn · {zone:1413} The Barrens
	["Get {item:2450} ({zone:1413})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 30: Get Briarthorn (Silverpine Forest)
	-- {item:2450} Briarthorn · {zone:1421} Silverpine Forest
	["Get {item:2450} ({zone:1421})"] = "",
	-- {item:2450} Briarthorn · {skill:171} Alchemy · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["You need 152 {item:2450} for {skill:171} 75-150: {spell:3171} and {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1421} is marked. Or buy them at the Auction House."] = "",

	-- Step 31: Get Bruiseweed (Westfall)
	-- {item:2453} Bruiseweed · {zone:1436} Westfall
	["Get {item:2453} ({zone:1436})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1436} is marked. Or buy them at the Auction House."] = "",

	-- Step 32: Get Bruiseweed (Loch Modan)
	-- {item:2453} Bruiseweed · {zone:1432} Loch Modan
	["Get {item:2453} ({zone:1432})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1432} is marked. Or buy them at the Auction House."] = "",

	-- Step 33: Get Bruiseweed (Darkshore)
	-- {item:2453} Bruiseweed · {zone:1439} Darkshore
	["Get {item:2453} ({zone:1439})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1439} is marked. Or buy them at the Auction House."] = "",

	-- Step 34: Get Bruiseweed (The Barrens)
	-- {item:2453} Bruiseweed · {zone:1413} The Barrens
	["Get {item:2453} ({zone:1413})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 35: Get Bruiseweed (Silverpine Forest)
	-- {item:2453} Bruiseweed · {zone:1421} Silverpine Forest
	["Get {item:2453} ({zone:1421})"] = "",
	-- {item:2453} Bruiseweed · {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["You need 54 {item:2453} for {skill:171} 75-150: {spell:3176} (24 of them for 150-225: get them all now). {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1421} is marked. Or buy them at the Auction House."] = "",

	-- Step 36: Minor Mana Potion to 90
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 90"] = "{spell:2331}: 90까지",
	-- {spell:2331} Minor Mana Potion · {item:785} Mageroyal · {item:2447} Peacebloom · {item:3371} Empty Vial · {spell:3171} Elixir of Wisdom
	["{spell:2331} is yellow at 75 (yellow 65, green 85, grey 105): about 28 crafts to 90. Each takes 1 {item:785}, 1 {item:2447} and 1 {item:3371}. The trainer teaches it from 25. It is yellow already, so count on about two crafts a point until {spell:3171} takes over at 90. {item:785} grows in the 10-25 zones."] = "{spell:2331}은(는) 75에서 노란색입니다(노란색 65, 초록색 85, 회색 105). 90까지 약 28번 만드십시오. 한 번에 {item:785} 1개, {item:2447} 1개, {item:3371} 1개가 듭니다. 상급자는 25부터 가르칩니다. 이미 노란색이니 {spell:3171}이(가) 90에서 이어받을 때까지 포인트당 약 두 번 만드십시오. {item:785}은(는) 10-25 구간에 자랍니다.",

	-- Step 37: Alchemy recipes at 90
	-- {skill:171} Alchemy
	["{skill:171} recipes at 90"] = "90에서 {skill:171} 제조법",
	-- {skill:171} Alchemy · {spell:3171} Elixir of Wisdom
	["Back to an {skill:171} trainer: {spell:3171} (from 90)."] = "{skill:171} 상급자에게 돌아가세요: {spell:3171}(90부터).",

	-- Step 38: Elixir of Wisdom to 135
	-- {spell:3171} Elixir of Wisdom
	["{spell:3171} to 135"] = "{spell:3171}: 135까지",
	-- {spell:3171} Elixir of Wisdom · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3371} Empty Vial
	["{spell:3171} is orange at 90 (yellow 120, green 140, grey 160): about 49 crafts to 135. Each takes 1 {item:785}, 2 {item:2450} and 1 {item:3371}. Two {item:2450} and a {item:785} a craft, both from the 10-25 zones; orange to 120."] = "{spell:3171}은(는) 90에 주황색입니다(노란색 120, 초록색 140, 회색 160). 135까지 약 49번 만드십시오. 한 번에 {item:785} 1개, {item:2450} 2개, {item:3371} 1개가 듭니다. 제작당 {item:2450} 2개와 {item:785} 1개, 둘 다 10-25 구간에서 나옵니다; 120까지 주황색입니다.",

	-- Step 39: Alchemy recipes at 135
	-- {skill:171} Alchemy
	["{skill:171} recipes at 135"] = "135에서 {skill:171} 제조법",
	-- {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir
	["Back to an {skill:171} trainer: {spell:3176} (from 125)."] = "{skill:171} 상급자에게 돌아가세요: {spell:3176}(125부터).",

	-- Step 40: Lesser Troll's Blood Elixir to 150
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 150"] = "{spell:3176}: 150까지",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial · {skill:171} Alchemy
	["{spell:3176} is orange at 135 (yellow 150, green 170, grey 190): about 15 crafts to 150, a point every craft. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. {skill:171} 150 is a Legacy System milestone."] = "{spell:3176}은(는) 135에 주황색입니다(노란색 150, 초록색 170, 회색 190). 150까지 약 15번 만드십시오, 만들 때마다 1점씩 오릅니다. 한 번에 {item:2453} 2개, {item:2450} 2개, {item:3372} 1개가 듭니다. 제작당 {item:2453} 2개와 {item:2450} 2개; {item:2453}은(는) 15-30 구간에 자랍니다. {skill:171} 150은(는) 유산 시스템 이정표입니다.",

	-- Step 41: Alchemy 150-225: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 150-225: vendor goods"] = "{skill:171} 150-225: 상인 재료",
	-- {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 83 {item:3372} (33s 20c); about 33s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:3372} 83개(33실버 20코퍼). 모두 약 33실버 20코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1286}, {npc:5503}, {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348}, {npc:3334}).",

	-- Step 42: Get Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	-- was: ["{item:3355} (Alliance)"] = "{item:3355} (얼라이언스)"
	["Get {object:1623} (Alliance)"] = "",
	-- {object:1623} Wild Steelbloom · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	-- was: ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1434} is marked."] = "{item:8951}에 필요한 {object:1623} 40개(225-300에 8개: 지금 모두 채집하세요): {skill:182}: {object:1623}(숙련도 115) {zone:1442}(15-27), {zone:1417}(30-40), {zone:1434}(30-45). {zone:1434}(30-45)에서 가장 많이 나는 {object:1623} 지역이 표시됩니다."
	["You need 40 {object:1623} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 43: Get Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	-- was: ["{item:3355} (Horde)"] = "{item:3355} (호드)"
	["Get {object:1623} (Horde)"] = "",
	-- {object:1623} Wild Steelbloom · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	-- was: ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1442} is marked."] = "{item:8951}에 필요한 {object:1623} 40개(225-300에 8개: 지금 모두 채집하세요): {skill:182}: {object:1623}(숙련도 115) {zone:1442}(15-27), {zone:1417}(30-40), {zone:1434}(30-45). {zone:1442}(15-27)에서 가장 많이 나는 {object:1623} 지역이 표시됩니다."
	["You need 40 {object:1623} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1442} is marked. Or buy them at the Auction House."] = "",

	-- Step 44: Get Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["Get {item:3356} (Alliance)"] = "",
	-- {item:3356} Kingsblood · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1440} Ashenvale · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale
	-- was: ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1434} is marked."] = "{spell:3452}에 필요한 {item:3356} 39개: {skill:182}: {item:3356}(숙련도 125) {zone:1440}(18-30), {zone:1437}(20-30), {zone:1434}(30-45). {zone:1434}(30-45)에서 가장 많이 나는 {item:3356} 지역이 표시됩니다."
	["You need 39 {item:3356} for {skill:171} 150-225: {spell:3452}. {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 45: Get Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["Get {item:3356} (Horde)"] = "",
	-- {item:3356} Kingsblood · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1434} Stranglethorn Vale
	-- was: ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1413} is marked."] = "{spell:3452}에 필요한 {item:3356} 39개: {skill:182}: {item:3356}(숙련도 125) {zone:1413}(10-25), {zone:1440}(18-30), {zone:1434}(30-45). {zone:1413}(10-25)에서 가장 많이 나는 {item:3356} 지역이 표시됩니다."
	["You need 39 {item:3356} for {skill:171} 150-225: {spell:3452}. {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 46: Get Stranglekelp (Alliance)
	-- {object:2045} Stranglekelp
	["Get {object:2045} (Alliance)"] = "",
	-- {object:2045} Stranglekelp · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	-- was: ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1434} is marked."] = "{spell:3452}에 필요한 {object:2045} 39개: {skill:182}: {object:2045}(숙련도 85) {zone:1437}(20-30), {zone:1434}(30-45), {zone:1425}(40-50). {zone:1434}(30-45)에서 가장 많이 나는 {object:2045} 지역이 표시됩니다."
	["You need 39 {object:2045} for {skill:171} 150-225: {spell:3452}. {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 47: Get Stranglekelp (Horde)
	-- {object:2045} Stranglekelp
	["Get {object:2045} (Horde)"] = "",
	-- {object:2045} Stranglekelp · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	-- was: ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1413} is marked."] = "{spell:3452}에 필요한 {object:2045} 39개: {skill:182}: {object:2045}(숙련도 85) {zone:1413}(10-25), {zone:1434}(30-45), {zone:1425}(40-50). {zone:1413}(10-25)에서 가장 많이 나는 {object:2045} 지역이 표시됩니다."
	["You need 39 {object:2045} for {skill:171} 150-225: {spell:3452}. {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 48: Get Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["Get {object:2046} (Alliance)"] = "",
	-- {object:2046} Goldthorn · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	-- was: ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1417} is marked."] = "{item:8951}에 필요한 {object:2046} 40개(225-300에 8개: 지금 모두 채집하세요): {skill:182}: {object:2046}(숙련도 170) {zone:1417}(30-40), {zone:1425}(40-50), {zone:1444}(40-50). {zone:1417}(30-40)에서 가장 많이 나는 {object:2046} 지역이 표시됩니다."
	["You need 40 {object:2046} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1417} is marked. Or buy them at the Auction House."] = "",

	-- Step 49: Get Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["Get {object:2046} (Horde)"] = "",
	-- {object:2046} Goldthorn · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	-- was: ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1444} is marked."] = "{item:8951}에 필요한 {object:2046} 40개(225-300에 8개: 지금 모두 채집하세요): {skill:182}: {object:2046}(숙련도 170) {zone:1417}(30-40), {zone:1425}(40-50), {zone:1444}(40-50). {zone:1444}(40-50)에서 가장 많이 나는 {object:2046} 지역이 표시됩니다."
	["You need 40 {object:2046} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1444} is marked. Or buy them at the Auction House."] = "",

	-- Step 50: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "숙련 {skill:171}",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {object:2045} Stranglekelp · {object:2046} Goldthorn · {spell:3452} Mana Potion · {item:8951} Elixir of Defense
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4160} ({zone:1457}); Horde {npc:4611} ({zone:1458}). The arrow picks the nearest of your faction. 150-225 takes about 33s 20c of vendor goods, plus 40 {object:1623}, 39 {item:3356}, 39 {object:2045} and 40 {object:2046} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:3452} (from 160) and {item:8951} (from 195), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "숙련 단계는 50실버(클래식 가격이며, Forever 가격은 데이터에 없습니다)로 최대 숙련도를 150에서 225로 올립니다. {skill:171} 125와 캐릭터 레벨 20이 필요하므로, 125가 되면 언제 들러도 배울 수 있습니다. 가르치는 상급자는 몇 명뿐입니다: 얼라이언스는 {npc:4160}({zone:1457}), 호드는 {npc:4611}({zone:1458})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 150-225에는 상인 재료 약 33실버 20코퍼, 그리고 채집하거나 살 {object:1623} 40개, {item:3356} 39개, {object:2045} 39개, {object:2046} 40개가 듭니다. 모든 재료를 가방에 챙겨서 오세요(위 단계에서 모으고, 나머지는 경매장에서). 이 상급자들은 {spell:3452}(160부터)와(과) {item:8951}(195부터)도 가르치며, 제작에 작업대가 필요 없으므로 바로 여기서 만들고 숙련도에 도달할 때마다 제조법을 배우세요. 세 번 올 것을 한 번에 끝냅니다.",

	-- Step 51: Lesser Troll's Blood Elixir to 160
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 160"] = "{spell:3176}: 160까지",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial
	["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. If you got here without learning {spell:3176}, learn it now: an earlier step teaches it."] = "{spell:3176}은(는) 150에서 노란색입니다(노란색 150, 초록색 170, 회색 190): 160까지 약 12번 제작. 매번 {item:2453} 2개, {item:2450} 2개, {item:3372} 1개가 필요합니다. 제작마다 {item:2453} 두 개와 {item:2450} 두 개. {item:2453}은(는) 15-30레벨 지역에서 자랍니다. {spell:3176}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 52: Alchemy recipes at 160
	-- {skill:171} Alchemy
	["{skill:171} recipes at 160"] = "160에서 {skill:171} 제조법",
	-- {spell:3452} Mana Potion
	["Still at the Expert trainer: {spell:3452} (from 160)."] = "계속 숙련 상급자에게서: {spell:3452}(160부터).",

	-- Step 53: Mana Potion to 195
	-- {spell:3452} Mana Potion
	["{spell:3452} to 195"] = "{spell:3452}: 195까지",
	-- {spell:3452} Mana Potion · {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3372} Leaded Vial
	["{spell:3452} is orange at 160 (yellow 180, green 200, grey 220): about 39 crafts to 195. Each takes 1 {item:3820}, 1 {item:3356} and 1 {item:3372}. {item:3820} grows under water along the coasts: bring a water breathing elixir or come up for air. {item:3356} grows in the 20-40 zones."] = "{spell:3452}은(는) 160에 주황색입니다(노란색 180, 초록색 200, 회색 220). 195까지 약 39번 만드십시오. 한 번에 {item:3820} 1개, {item:3356} 1개, {item:3372} 1개가 듭니다. {item:3820}은(는) 해안가 수중에서 자랍니다: 수중 호흡 엘릭서를 가져오거나 숨을 쉬러 수면으로 오르세요. {item:3356}은(는) 20-40 구간에 자랍니다.",

	-- Step 54: Alchemy recipes at 195
	-- {skill:171} Alchemy
	["{skill:171} recipes at 195"] = "195에서 {skill:171} 제조법",
	-- {spell:11450} Elixir of Defense
	["Still at the Expert trainer: {spell:11450} (from 195)."] = "계속 숙련 상급자에게서: {spell:11450}(195부터).",

	-- Step 55: Elixir of Defense to 225
	-- {item:8951} Elixir of Defense
	["{item:8951} to 225"] = "{item:8951}: 225까지",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands · {skill:171} Alchemy
	["{item:8951} is orange at 195 (yellow 215, green 235, grey 255): about 32 crafts to 225. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). {skill:171} 225 is a Legacy System milestone."] = "{item:8951}은(는) 195에 주황색입니다(노란색 215, 초록색 235, 회색 255). 225까지 약 32번 만드십시오. 한 번에 {item:3355} 1개, {item:3821} 1개, {item:3372} 1개가 듭니다. {item:3355}와(과) {item:3821}은(는) 30-45 구간의 약초입니다(스트렝글손, 아라시, {zone:1418}). {skill:171} 225은(는) 유산 시스템 이정표입니다.",

	-- Step 56: Alchemy 225-300: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 225-300: vendor goods"] = "{skill:171} 225-300: 상인 재료",
	-- {item:3372} Leaded Vial · {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 51 {item:3372} (20s 40c) and 86 {item:8925} (4g 30s); about 4g 50s 40c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:3372} 51개(20실버 40코퍼)와(과) {item:8925} 86개(4골드 30실버). 모두 약 4골드 50실버 40코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1286}, {npc:5503}, {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348}, {npc:3334}).",

	-- Step 57: Recipe: Elixir of Superior Defense
	-- {item:13478} Recipe: Elixir of Superior Defense · {item:13445} Elixir of Greater Defense · {skill:171} Alchemy · {npc:5178} Soolie Berryfizz · {zone:1455} Ironforge · {npc:3348} Kor'geld · {zone:1454} Orgrimmar
	["{item:13478} teaches {item:13445} ({skill:171} 265) for 1g 30s. Sold by Alliance: {npc:5178} ({zone:1455}), limited stock; Horde: {npc:3348} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "{item:13478}은(는) 1골드 30실버에 {item:13445}({skill:171} 265)을(를) 가르칩니다. 얼라이언스 판매: {npc:5178}({zone:1455}), 수량 제한; 호드 판매: {npc:3348}({zone:1454}), 수량 제한. 판매자는 한두 개를 재고로 두고 판매 후 얼마 지나면 다시 들여놓습니다; 경매장에도 자주 있습니다.",

	-- Step 58: Get Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	-- was: ["{item:8836} (Alliance)"] = "{item:8836} (얼라이언스)"
	["Get {item:8836} (Alliance)"] = "",
	-- {item:8836} Arthas' Tears · {skill:171} Alchemy · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	-- was: ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1422} is marked."] = "{item:9154}에 필요한 {item:8836} 43개: {skill:182}: {item:8836}(숙련도 220) {zone:1448}(48-55), {zone:1422}(51-58), {zone:1423}(53-60). {zone:1422}(51-58)에서 가장 많이 나는 {item:8836} 지역이 표시됩니다."
	["You need 43 {item:8836} for {skill:171} 225-300: {item:9154}. {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1422} is marked. Or buy them at the Auction House."] = "",

	-- Step 59: Get Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	-- was: ["{item:8836} (Horde)"] = "{item:8836} (호드)"
	["Get {item:8836} (Horde)"] = "",
	-- {item:8836} Arthas' Tears · {skill:171} Alchemy · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	-- was: ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1448} is marked."] = "{item:9154}에 필요한 {item:8836} 43개: {skill:182}: {item:8836}(숙련도 220) {zone:1448}(48-55), {zone:1422}(51-58), {zone:1423}(53-60). {zone:1448}(48-55)에서 가장 많이 나는 {item:8836} 지역이 표시됩니다."
	["You need 43 {item:8836} for {skill:171} 225-300: {item:9154}. {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1448} is marked. Or buy them at the Auction House."] = "",

	-- Step 60: Get Sungrass (Alliance)
	-- {item:8838} Sungrass
	["Get {item:8838} (Alliance)"] = "",
	-- {item:8838} Sungrass · {skill:171} Alchemy · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- was: ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1425} is marked."] = "{item:13445}에 필요한 {item:8838} 43개: {skill:182}: {item:8838}(숙련도 230) {zone:1425}(40-50), {zone:1444}(40-50), {zone:1447}(45-55). {zone:1425}(40-50)에서 가장 많이 나는 {item:8838} 지역이 표시됩니다."
	["You need 43 {item:8838} for {skill:171} 225-300: {item:13445}. {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1425} is marked. Or buy them at the Auction House."] = "",

	-- Step 61: Get Sungrass (Horde)
	-- {item:8838} Sungrass
	["Get {item:8838} (Horde)"] = "",
	-- {item:8838} Sungrass · {skill:171} Alchemy · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- was: ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1444} is marked."] = "{item:13445}에 필요한 {item:8838} 43개: {skill:182}: {item:8838}(숙련도 230) {zone:1425}(40-50), {zone:1444}(40-50), {zone:1447}(45-55). {zone:1444}(40-50)에서 가장 많이 나는 {item:8838} 지역이 표시됩니다."
	["You need 43 {item:8838} for {skill:171} 225-300: {item:13445}. {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1444} is marked. Or buy them at the Auction House."] = "",

	-- Step 62: Get Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	-- was: ["{item:13422} (Alliance)"] = "{item:13422} (얼라이언스)"
	["Get {item:13422} (Alliance)"] = "",
	-- {item:13422} Stonescale Eel · {skill:171} Alchemy · {item:13445} Elixir of Greater Defense · {object:180712} Stonescale Eel Swarm
	["You need 43 {item:13422} for {skill:171} 225-300: {item:13445}. Fish them from the {object:180712} pools at the marked spot. Or buy them at the Auction House."] = "",

	-- Step 63: Get Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	-- was: ["{item:13422} (Horde)"] = "{item:13422} (호드)"
	["Get {item:13422} (Horde)"] = "",

	-- Step 64: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "전문 {skill:171}",
	-- {skill:171} Alchemy · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:13422} Stonescale Eel · {item:9154} Draught of Detect Undead · {item:13423} Stonescale Oil
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:7948} ({zone:1444}); Horde {npc:1386} ({zone:1435}). The arrow picks the nearest of your faction. 225-300 takes about 1g 30s of recipes and 4g 50s 40c of vendor goods, plus 43 {item:8836}, 43 {item:8838} and 43 {item:13422} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9154} (from 230) and {item:13423} (from 250), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "전문 단계는 4골드 50실버(클래식 가격이며, Forever 가격은 데이터에 없습니다)로 최대 숙련도를 225에서 300으로 올립니다. {skill:171} 200과 캐릭터 레벨 35이 필요하므로, 200이 되면 언제 들러도 배울 수 있습니다. 가르치는 상급자는 몇 명뿐입니다: 얼라이언스는 {npc:7948}({zone:1444}), 호드는 {npc:1386}({zone:1435})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 225-300에는 제조법 약 1골드 30실버와 상인 재료 4골드 50실버 40코퍼, 그리고 채집하거나 구매할 {item:8836} 43개, {item:8838} 43개, {item:13422} 43개가 필요합니다. 모두 가방에 넣어 오세요(위의 단계, 나머지는 경매장에서): 이 상급자들은 {item:9154}(230부터)와 {item:13423}(250부터)도 가르치고, 제작에는 작업대가 필요 없으니 여기서 바로 만들고 숙련도에 도달할 때마다 제조법을 배우세요. 3번 대신 한 번의 여행입니다.",

	-- Step 65: Elixir of Defense to 230
	-- {item:8951} Elixir of Defense
	["{item:8951} to 230"] = "{item:8951}: 230까지",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands
	["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). If you got here without learning {item:8951}, learn it now: an earlier step teaches it."] = "{item:8951}은(는) 225에서 노란색입니다(노란색 215, 초록색 235, 회색 255): 230까지 약 8번 제작. 매번 {item:3355} 1개, {item:3821} 1개, {item:3372} 1개가 필요합니다. {item:3355}와(과) {item:3821}은(는) 30-45레벨 지역의 약초입니다(가시덤불 골짜기, 아라시, {zone:1418}). {item:8951}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 66: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "230에서 {skill:171} 제조법",
	-- {spell:11460} Draught of Detect Undead
	["Still at the Artisan trainer: {spell:11460} (from 230)."] = "계속 전문 상급자에게서: {spell:11460}(230부터).",

	-- Step 67: Draught of Detect Undead to 265
	-- {item:9154} Draught of Detect Undead
	["{item:9154} to 265"] = "{item:9154}: 265까지",
	-- {item:9154} Draught of Detect Undead · {item:8836} Arthas' Tears · {item:8925} Crystal Vial · {zone:1448} Felwood · {skill:182} Herbalism
	-- plural, as words: Crystal Vials = {item:8925} Crystal Vial
	["{item:9154} is orange at 230 (yellow 245, green 265, grey 285): about 43 crafts to 265. Each takes 1 {item:8836} and 1 {item:8925}. {item:8836} grow in the Plaguelands and {zone:1448} ({skill:182} 220); Crystal Vials come from alchemy vendors."] = "{item:9154}은(는) 230에 주황색입니다(노란색 245, 초록색 265, 회색 285). 265까지 약 43번 만드십시오. 한 번에 {item:8836} 1개와(과) {item:8925} 1개가 듭니다. {item:8836}은(는) 스컬지 땅과 {zone:1448}에서 자랍니다({skill:182} 220); 수정 약병은 연금술 상인에게서 나옵니다.",

	-- Step 68: Alchemy recipes at 265
	-- {skill:171} Alchemy
	["{skill:171} recipes at 265"] = "265에서 {skill:171} 제조법",
	-- {spell:17551} Stonescale Oil
	["Still at the Artisan trainer: {spell:17551} (from 250)."] = "계속 전문 상급자에게서: {spell:17551}(250부터).",

	-- Step 69: Elixir of Greater Defense to 300
	-- {item:13445} Elixir of Greater Defense
	["{item:13445} to 300"] = "{item:13445}: 300까지",
	-- {item:13445} Elixir of Greater Defense · {item:13423} Stonescale Oil · {item:8838} Sungrass · {item:8925} Crystal Vial · {item:13422} Stonescale Eel · {skill:171} Alchemy
	["{item:13445} is orange at 265 (yellow 280, green 300, grey 320): about 43 crafts to 300. Each takes 2 {item:13423}, 1 {item:8838} and 1 {item:8925}. Make the 86 {item:13423} (43 crafts) first. {item:13422} comes from the {item:13422} schools on the coasts of the 40-55 zones, or the Auction House (fishers sell them in stacks). {item:8838} grows in the 40-55 zones. {skill:171} 300 is a Legacy System milestone."] = "{item:13445}은(는) 265에 주황색입니다(노란색 280, 초록색 300, 회색 320). 300까지 약 43번 만드십시오. 한 번에 {item:13423} 2개, {item:8838} 1개, {item:8925} 1개가 듭니다. 먼저 {item:13423} 86개(43회 제작)를 만드십시오. {item:13422}은(는) 40-55 구간 해안의 {item:13422} 떼 또는 경매장에서 나옵니다(낚시꾼이 묶음으로 판매합니다). {item:8838}은(는) 40-55 구간에 자랍니다. {skill:171} 300은(는) 유산 시스템 이정표입니다.",
	["from the recipe in your bags"] = "가방에 있는 제조법으로",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1411} is marked."] = "{item:5997} 및 {spell:2331}에 필요한 {item:2447} 110개(75-150에 28개: 지금 모두 채집하세요): {skill:182}: {item:2447}(숙련도 1). {zone:1411}에서 가장 많이 나는 {item:2447} 지역이 표시됩니다.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1412} is marked."] = "{item:5997} 및 {spell:2331}에 필요한 {item:2447} 110개(75-150에 28개: 지금 모두 채집하세요): {skill:182}: {item:2447}(숙련도 1). {zone:1412}에서 가장 많이 나는 {item:2447} 지역이 표시됩니다.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1420} is marked."] = "{item:5997} 및 {spell:2331}에 필요한 {item:2447} 110개(75-150에 28개: 지금 모두 채집하세요): {skill:182}: {item:2447}(숙련도 1). {zone:1420}에서 가장 많이 나는 {item:2447} 지역이 표시됩니다.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1426} is marked."] = "{item:5997} 및 {spell:2331}에 필요한 {item:2447} 110개(75-150에 28개: 지금 모두 채집하세요): {skill:182}: {item:2447}(숙련도 1). {zone:1426}에서 가장 많이 나는 {item:2447} 지역이 표시됩니다.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1429} is marked."] = "{item:5997} 및 {spell:2331}에 필요한 {item:2447} 110개(75-150에 28개: 지금 모두 채집하세요): {skill:182}: {item:2447}(숙련도 1). {zone:1429}에서 가장 많이 나는 {item:2447} 지역이 표시됩니다.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1438} is marked."] = "{item:5997} 및 {spell:2331}에 필요한 {item:2447} 110개(75-150에 28개: 지금 모두 채집하세요): {skill:182}: {item:2447}(숙련도 1). {zone:1438}에서 가장 많이 나는 {item:2447} 지역이 표시됩니다.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:2521} is marked."] = "{item:5997} 및 {spell:2331}에 필요한 {item:2447} 110개(75-150에 28개: 지금 모두 채집하세요): {skill:182}: {item:2447}(숙련도 1). {zone:2521}에서 가장 많이 나는 {item:2447} 지역이 표시됩니다.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1413} is marked."] = "{spell:3171} 및 {spell:3176}에 필요한 {item:2450} 152개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2450}(숙련도 70). {zone:1413}에서 가장 많이 나는 {item:2450} 지역이 표시됩니다.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1421} is marked."] = "{spell:3171} 및 {spell:3176}에 필요한 {item:2450} 152개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2450}(숙련도 70). {zone:1421}에서 가장 많이 나는 {item:2450} 지역이 표시됩니다.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1432} is marked."] = "{spell:3171} 및 {spell:3176}에 필요한 {item:2450} 152개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2450}(숙련도 70). {zone:1432}에서 가장 많이 나는 {item:2450} 지역이 표시됩니다.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1436} is marked."] = "{spell:3171} 및 {spell:3176}에 필요한 {item:2450} 152개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2450}(숙련도 70). {zone:1436}에서 가장 많이 나는 {item:2450} 지역이 표시됩니다.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1439} is marked."] = "{spell:3171} 및 {spell:3176}에 필요한 {item:2450} 152개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2450}(숙련도 70). {zone:1439}에서 가장 많이 나는 {item:2450} 지역이 표시됩니다.",
	-- ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1413} is marked."] = "{spell:3452}에 필요한 {item:3356} 39개: {skill:182}: {item:3356}(숙련도 125) {zone:1413}(10-25), {zone:1440}(18-30), {zone:1434}(30-45). {zone:1413}(10-25)에서 가장 많이 나는 {item:3356} 지역이 표시됩니다.",
	-- ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1434} is marked."] = "{spell:3452}에 필요한 {item:3356} 39개: {skill:182}: {item:3356}(숙련도 125) {zone:1440}(18-30), {zone:1437}(20-30), {zone:1434}(30-45). {zone:1434}(30-45)에서 가장 많이 나는 {item:3356} 지역이 표시됩니다.",
	-- ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1413} is marked."] = "{spell:3452}에 필요한 {object:2045} 39개: {skill:182}: {object:2045}(숙련도 85) {zone:1413}(10-25), {zone:1434}(30-45), {zone:1425}(40-50). {zone:1413}(10-25)에서 가장 많이 나는 {object:2045} 지역이 표시됩니다.",
	-- ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1434} is marked."] = "{spell:3452}에 필요한 {object:2045} 39개: {skill:182}: {object:2045}(숙련도 85) {zone:1437}(20-30), {zone:1434}(30-45), {zone:1425}(40-50). {zone:1434}(30-45)에서 가장 많이 나는 {object:2045} 지역이 표시됩니다.",
	-- ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1434} is marked."] = "{item:8951}에 필요한 {object:1623} 40개(225-300에 8개: 지금 모두 채집하세요): {skill:182}: {object:1623}(숙련도 115) {zone:1442}(15-27), {zone:1417}(30-40), {zone:1434}(30-45). {zone:1434}(30-45)에서 가장 많이 나는 {object:1623} 지역이 표시됩니다.",
	-- ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1442} is marked."] = "{item:8951}에 필요한 {object:1623} 40개(225-300에 8개: 지금 모두 채집하세요): {skill:182}: {object:1623}(숙련도 115) {zone:1442}(15-27), {zone:1417}(30-40), {zone:1434}(30-45). {zone:1442}(15-27)에서 가장 많이 나는 {object:1623} 지역이 표시됩니다.",
	-- ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1417} is marked."] = "{item:8951}에 필요한 {object:2046} 40개(225-300에 8개: 지금 모두 채집하세요): {skill:182}: {object:2046}(숙련도 170) {zone:1417}(30-40), {zone:1425}(40-50), {zone:1444}(40-50). {zone:1417}(30-40)에서 가장 많이 나는 {object:2046} 지역이 표시됩니다.",
	-- ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1444} is marked."] = "{item:8951}에 필요한 {object:2046} 40개(225-300에 8개: 지금 모두 채집하세요): {skill:182}: {object:2046}(숙련도 170) {zone:1417}(30-40), {zone:1425}(40-50), {zone:1444}(40-50). {zone:1444}(40-50)에서 가장 많이 나는 {object:2046} 지역이 표시됩니다.",
	-- ["43 {item:13422} for {item:13445}: {skill:356}. Fish {object:180712} here."] = "{item:13445}에 필요한 {item:13422} 43개: {skill:356}. 여기서 {object:180712}를(을) 낚으세요.",
	-- ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1422} is marked."] = "{item:9154}에 필요한 {item:8836} 43개: {skill:182}: {item:8836}(숙련도 220) {zone:1448}(48-55), {zone:1422}(51-58), {zone:1423}(53-60). {zone:1422}(51-58)에서 가장 많이 나는 {item:8836} 지역이 표시됩니다.",
	-- ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1448} is marked."] = "{item:9154}에 필요한 {item:8836} 43개: {skill:182}: {item:8836}(숙련도 220) {zone:1448}(48-55), {zone:1422}(51-58), {zone:1423}(53-60). {zone:1448}(48-55)에서 가장 많이 나는 {item:8836} 지역이 표시됩니다.",
	-- ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1425} is marked."] = "{item:13445}에 필요한 {item:8838} 43개: {skill:182}: {item:8838}(숙련도 230) {zone:1425}(40-50), {zone:1444}(40-50), {zone:1447}(45-55). {zone:1425}(40-50)에서 가장 많이 나는 {item:8838} 지역이 표시됩니다.",
	-- ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1444} is marked."] = "{item:13445}에 필요한 {item:8838} 43개: {skill:182}: {item:8838}(숙련도 230) {zone:1425}(40-50), {zone:1444}(40-50), {zone:1447}(45-55). {zone:1444}(40-50)에서 가장 많이 나는 {item:8838} 지역이 표시됩니다.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1413} is marked."] = "{spell:3176}에 필요한 {item:2453} 54개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2453}(숙련도 100). {zone:1413}에서 가장 많이 나는 {item:2453} 지역이 표시됩니다.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1421} is marked."] = "{spell:3176}에 필요한 {item:2453} 54개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2453}(숙련도 100). {zone:1421}에서 가장 많이 나는 {item:2453} 지역이 표시됩니다.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1432} is marked."] = "{spell:3176}에 필요한 {item:2453} 54개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2453}(숙련도 100). {zone:1432}에서 가장 많이 나는 {item:2453} 지역이 표시됩니다.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1436} is marked."] = "{spell:3176}에 필요한 {item:2453} 54개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2453}(숙련도 100). {zone:1436}에서 가장 많이 나는 {item:2453} 지역이 표시됩니다.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1439} is marked."] = "{spell:3176}에 필요한 {item:2453} 54개(150-225에 24개: 지금 모두 채집하세요): {skill:182}: {item:2453}(숙련도 100). {zone:1439}에서 가장 많이 나는 {item:2453} 지역이 표시됩니다.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1413} is marked."] = "{spell:2331} 및 {spell:3171}에 필요한 {item:785} 77개: {skill:182}: {item:785}(숙련도 50). {zone:1413}에서 가장 많이 나는 {item:785} 지역이 표시됩니다.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1421} is marked."] = "{spell:2331} 및 {spell:3171}에 필요한 {item:785} 77개: {skill:182}: {item:785}(숙련도 50). {zone:1421}에서 가장 많이 나는 {item:785} 지역이 표시됩니다.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1432} is marked."] = "{spell:2331} 및 {spell:3171}에 필요한 {item:785} 77개: {skill:182}: {item:785}(숙련도 50). {zone:1432}에서 가장 많이 나는 {item:785} 지역이 표시됩니다.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1436} is marked."] = "{spell:2331} 및 {spell:3171}에 필요한 {item:785} 77개: {skill:182}: {item:785}(숙련도 50). {zone:1436}에서 가장 많이 나는 {item:785} 지역이 표시됩니다.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1438} is marked."] = "{spell:2331} 및 {spell:3171}에 필요한 {item:785} 77개: {skill:182}: {item:785}(숙련도 50). {zone:1438}에서 가장 많이 나는 {item:785} 지역이 표시됩니다.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:2521} is marked."] = "{spell:2331} 및 {spell:3171}에 필요한 {item:785} 77개: {skill:182}: {item:785}(숙련도 50). {zone:2521}에서 가장 많이 나는 {item:785} 지역이 표시됩니다.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1411} is marked."] = "{item:5997}에 필요한 {item:765} 82개: {skill:182}: {item:765}(숙련도 1). {zone:1411}에서 가장 많이 나는 {item:765} 지역이 표시됩니다.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1412} is marked."] = "{item:5997}에 필요한 {item:765} 82개: {skill:182}: {item:765}(숙련도 1). {zone:1412}에서 가장 많이 나는 {item:765} 지역이 표시됩니다.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1420} is marked."] = "{item:5997}에 필요한 {item:765} 82개: {skill:182}: {item:765}(숙련도 1). {zone:1420}에서 가장 많이 나는 {item:765} 지역이 표시됩니다.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1426} is marked."] = "{item:5997}에 필요한 {item:765} 82개: {skill:182}: {item:765}(숙련도 1). {zone:1426}에서 가장 많이 나는 {item:765} 지역이 표시됩니다.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1429} is marked."] = "{item:5997}에 필요한 {item:765} 82개: {skill:182}: {item:765}(숙련도 1). {zone:1429}에서 가장 많이 나는 {item:765} 지역이 표시됩니다.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1438} is marked."] = "{item:5997}에 필요한 {item:765} 82개: {skill:182}: {item:765}(숙련도 1). {zone:1438}에서 가장 많이 나는 {item:765} 지역이 표시됩니다.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:2521} is marked."] = "{item:5997}에 필요한 {item:765} 82개: {skill:182}: {item:765}(숙련도 1). {zone:2521}에서 가장 많이 나는 {item:765} 지역이 표시됩니다.",
	-- ["Apprentice {skill:171}"] = "초급 {skill:171}",
	-- ["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "전문은(는) 캐릭터 레벨 35, {skill:171} 200이(가) 필요하며 최대 숙련도를 300(으)로 올립니다. 225-300 재료는 모두 약 7골드 80실버입니다.",
	-- ["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "{skill:171} 상급자에게 돌아가세요. {spell:11447}은(는) {skill:171} 190부터 배울 수 있습니다.",
	-- ["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "{skill:171} 상급자에게 돌아가세요. {spell:1244645}은(는) {skill:171} 85부터 배울 수 있습니다.",
	-- ["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "{skill:171} 상급자에게 돌아가세요. {spell:1244647}은(는) {skill:171} 175부터 배울 수 있습니다.",
	-- ["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "{skill:171} 상급자에게 돌아가세요. {spell:1244648}은(는) {skill:171} 230부터 배울 수 있습니다.",
	-- ["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "{skill:171} 상급자에게 돌아가세요. {spell:7845}은(는) {skill:171} 165부터 배울 수 있습니다.",
	-- ["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "숙련은(는) 캐릭터 레벨 20, {skill:171} 125이(가) 필요하며 최대 숙련도를 225(으)로 올립니다. 150-225 재료는 모두 약 3골드 65실버입니다.",
	-- ["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "{object:180582}에서 낚시하세요. 데이터상 가장 많은 곳입니다. 경매장도 됩니다.",
	-- ["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "{object:180657}에서 낚시하세요. 데이터상 가장 많은 곳입니다. 경매장도 됩니다.",
	-- ["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "{object:180712}에서 낚시하세요. 데이터상 가장 많은 곳입니다. 경매장도 됩니다.",
	-- ["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "수습은(는) 캐릭터 레벨 10, {skill:171} 50이(가) 필요하며 최대 숙련도를 150(으)로 올립니다. 75-150 재료는 모두 약 1골드 44실버입니다.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Polestar가 레벨과 진영에 맞춰 고른 사냥터에서 이것을 떨어뜨리는 몹을 처치하세요. 경매장도 됩니다.",
	-- ["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "130까지 주황색(만들 때마다 1점), 150까지 노란색, 170까지 초록색입니다. {skill:171} 150은 유산 시스템 단계입니다.",
	-- ["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "280까지 주황색(만들 때마다 1점), 300까지 노란색, 320까지 초록색입니다. {skill:171} 300은 유산 시스템 단계입니다.",
	-- ["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "55까지 주황색(만들 때마다 1점), 75까지 노란색, 95까지 초록색입니다. 75는 초급 최대치입니다.",
	-- ["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:2447}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:2450}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:2453}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:3355}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:3356}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:3357}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:3821}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:765}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:785}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:8836}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:8838}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {object:1623}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {object:2046}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks."] = "{item:6051}을(를) 배웁니다({skill:171} 100 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",
	-- ["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "{item:8951}을(를) 배웁니다({skill:171} 265 필요). 상인이 한정 수량으로 팔며 재입고됩니다. 경매장에도 자주 있습니다.",
	-- ["What 1-75 takes that the Auction House sells: 82 {item:765} and 110 {item:2447}. The counts drop by what your bags, bank and mail hold."] = "1-75 구간에 필요한 것 중 경매장에서 파는 것: {item:765} 82개, {item:2447} 110개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 150-225 takes that the Auction House sells: 40 {item:3355}, 39 {item:3356}, 39 {item:3820} and 40 {item:3821}. The counts drop by what your bags, bank and mail hold."] = "150-225 구간에 필요한 것 중 경매장에서 파는 것: {item:3355} 40개, {item:3356} 39개, {item:3820} 39개, {item:3821} 40개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 225-300 takes that the Auction House sells: 43 {item:8836}, 43 {item:8838} and 43 {item:13422}. The counts drop by what your bags, bank and mail hold."] = "225-300 구간에 필요한 것 중 경매장에서 파는 것: {item:8836} 43개, {item:8838} 43개, {item:13422} 43개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 75-150 takes that the Auction House sells: 77 {item:785}, 152 {item:2450} and 54 {item:2453}. The counts drop by what your bags, bank and mail hold."] = "75-150 구간에 필요한 것 중 경매장에서 파는 것: {item:785} 77개, {item:2450} 152개, {item:2453} 54개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["Yellow until 105, green until 125: not every craft gives a point."] = "105까지 노란색, 125까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 160, green until 170: not every craft gives a point."] = "160까지 노란색, 170까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 185, green until 205: not every craft gives a point."] = "185까지 노란색, 205까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 195, green until 215: not every craft gives a point."] = "195까지 노란색, 215까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 210, green until 230: not every craft gives a point."] = "210까지 노란색, 230까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 235, green until 255: not every craft gives a point."] = "235까지 노란색, 255까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "235까지 노란색, 255까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. {skill:171} 225는 유산 시스템 단계입니다.",
	-- ["Yellow until 250, green until 270: not every craft gives a point."] = "250까지 노란색, 270까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 255, green until 260: not every craft gives a point."] = "255까지 노란색, 260까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 265, green until 285: not every craft gives a point."] = "265까지 노란색, 285까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["Yellow until 85, green until 105: not every craft gives a point."] = "85까지 노란색, 105까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",
	-- ["{item:13422} (Alliance)"] = "{item:13422} (얼라이언스)",
	-- ["{item:13422} (Horde)"] = "{item:13422} (호드)",
	-- ["{item:13423} to 259"] = "{item:13423}: 259까지",
	-- ["{item:2447} (Alliance)"] = "{item:2447} (얼라이언스)",
	-- ["{item:2447} (Horde)"] = "{item:2447} (호드)",
	-- ["{item:2450} (Alliance)"] = "{item:2450} (얼라이언스)",
	-- ["{item:2450} (Horde)"] = "{item:2450} (호드)",
	-- ["{item:2452} (Alliance)"] = "{item:2452} (얼라이언스)",
	-- ["{item:2452} (Horde)"] = "{item:2452} (호드)",
	-- ["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452}은(는) {item:2450} 채집지에서 나옵니다({skill:182}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["{item:2453} (Alliance)"] = "{item:2453} (얼라이언스)",
	-- ["{item:2453} (Horde)"] = "{item:2453} (호드)",
	-- ["{item:247239} to 100"] = "{item:247239}: 100까지",
	-- ["{item:247241} to 200"] = "{item:247241}: 200까지",
	-- ["{item:247242} to 250"] = "{item:247242}: 250까지",
	-- ["{item:3355} (Alliance)"] = "{item:3355} (얼라이언스)",
	-- ["{item:3355} (Horde)"] = "{item:3355} (호드)",
	-- ["{item:3356} (Alliance)"] = "{item:3356} (얼라이언스)",
	-- ["{item:3356} (Horde)"] = "{item:3356} (호드)",
	-- ["{item:3357} (Alliance)"] = "{item:3357} (얼라이언스)",
	-- ["{item:3357} (Horde)"] = "{item:3357} (호드)",
	-- ["{item:3821} (Alliance)"] = "{item:3821} (얼라이언스)",
	-- ["{item:3821} (Horde)"] = "{item:3821} (호드)",
	-- ["{item:6051} to 150"] = "{item:6051}: 150까지",
	-- ["{item:6358} (Alliance)"] = "{item:6358} (얼라이언스)",
	-- ["{item:6358} (Horde)"] = "{item:6358} (호드)",
	-- ["{item:6359} (Alliance)"] = "{item:6359} (얼라이언스)",
	-- ["{item:6359} (Horde)"] = "{item:6359} (호드)",
	-- ["{item:6371} to 165"] = "{item:6371}: 165까지",
	-- ["{item:730} (Alliance)"] = "{item:730} (얼라이언스)",
	-- ["{item:730} (Horde)"] = "{item:730} (호드)",
	-- ["{item:765} (Alliance)"] = "{item:765} (얼라이언스)",
	-- ["{item:765} (Horde)"] = "{item:765} (호드)",
	-- ["{item:785} (Alliance)"] = "{item:785} (얼라이언스)",
	-- ["{item:785} (Horde)"] = "{item:785} (호드)",
	-- ["{item:8836} (Alliance)"] = "{item:8836} (얼라이언스)",
	-- ["{item:8836} (Horde)"] = "{item:8836} (호드)",
	-- ["{item:8838} (Alliance)"] = "{item:8838} (얼라이언스)",
	-- ["{item:8838} (Horde)"] = "{item:8838} (호드)",
	-- ["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418})."] = "{item:8951}은(는) 225에서 노란색입니다(노란색 215, 초록색 235, 회색 255). 230까지 약 8번 만드십시오. 한 번에 {item:3355} 1개, {item:3821} 1개, {item:3372} 1개가 듭니다. {item:3355}와(과) {item:3821}은(는) 30-45 구간의 약초입니다(스트렝글손, 아라시, {zone:1418}).",
	-- ["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "이곳의 {npc:1958}(17-18레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "이곳의 {npc:513}(14-15레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{object:1623} (Alliance)"] = "{object:1623} (얼라이언스)",
	-- ["{object:1623} (Horde)"] = "{object:1623} (호드)",
	-- ["{object:2045} (Alliance)"] = "{object:2045} (얼라이언스)",
	-- ["{object:2045} (Horde)"] = "{object:2045} (호드)",
	-- ["{object:2046} (Alliance)"] = "{object:2046} (얼라이언스)",
	-- ["{object:2046} (Horde)"] = "{object:2046} (호드)",
	-- ["{skill:171} 1-75: Auction House"] = "{skill:171} 1-75: 경매장",
	-- ["{skill:171} 150-225: Auction House"] = "{skill:171} 150-225: 경매장",
	-- ["{skill:171} 225-300: Auction House"] = "{skill:171} 225-300: 경매장",
	-- ["{skill:171} 75-150: Auction House"] = "{skill:171} 75-150: 경매장",
	-- ["{skill:171} recipes at 259"] = "259에서 {skill:171} 제조법",
	-- ["{skill:171} recipes at 85"] = "85에서 {skill:171} 제조법",
	-- ["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "{skill:171}은(는) 레벨업과 함께 진행합니다. Forever의 유산 시스템은 제작 전문 기술 숙련도 150, 225, 300(수습, 숙련, 전문 최대치)에 보상을 주므로, 각 단계가 중요합니다. 1-75 재료는 모두 약 68실버입니다.",
	-- ["{spell:11447} to 215"] = "{spell:11447}: 215까지",
	-- ["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones."] = "{spell:3176}은(는) 150에서 노란색입니다(노란색 150, 초록색 170, 회색 190). 160까지 약 12번 만드십시오. 한 번에 {item:2453} 2개, {item:2450} 2개, {item:3372} 1개가 듭니다. 제작당 {item:2453} 2개와 {item:2450} 2개; {item:2453}은(는) 15-30 구간에 자랍니다.",
	-- ["{spell:7845} to 175"] = "{spell:7845}: 175까지",
}
