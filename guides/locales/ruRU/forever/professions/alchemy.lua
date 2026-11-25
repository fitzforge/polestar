-- Russian (ruRU): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Alchemy
	-- {skill:171} Alchemy
	["Learn {skill:171}"] = "Изучите: {skill:171}",
	-- {skill:171} Alchemy · {skill:182} Herbalism · {item:2447} Peacebloom · {item:765} Silverleaf
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Apprentice {skill:171} lets you craft up to 75 for 10c, at any character level. Any {skill:171} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:182}: {item:2447} and {item:765} grow in every starting zone, and Empty Vials cost 4c at any alchemy or trade supplies vendor. 1-75 takes about 3s 28c of vendor goods, plus 82 {item:765} and 110 {item:2447} to gather or buy."] = "Подмастерье по {skill:171} позволяет создавать предметы до 75 навыка за 10c на любом уровне персонажа; обучит любой наставник {skill:171} вашей фракции, а стрелка укажет ближайшего. Начните с {skill:182}: {item:2447} и {item:765} растут в каждой стартовой зоне, а пустые колбы стоят 4c у любого продавца алхимии или торговых товаров. На 1-75 уйдёт примерно 3s 28c товаров у продавцов, плюс 82 {item:765} и 110 {item:2447}, которые нужно собрать или купить.",

	-- Step 2: Alchemy 1-75: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 1-75: vendor goods"] = "{skill:171} 1-75: товары торговцев",
	-- {item:3371} Empty Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 82 {item:3371} (3s 28c); about 3s 28c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Купите сразу все для этого этапа: {item:3371} 82 (3с 28м); всего около 3с 28м. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:1286}, {npc:5503} и {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} и {npc:3334}).",

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
	["{item:5997} to 75"] = "{item:5997} до 75",
	-- {item:5997} Elixir of Minor Defense · {item:765} Silverleaf · {item:2447} Peacebloom · {item:3371} Empty Vial
	["{item:5997} is orange at 1 (yellow 55, green 75, grey 95): about 82 crafts to 75. Each takes 1 {item:765}, 1 {item:2447} and 1 {item:3371}. Known from the start and the cheapest way through the Apprentice range. Keep the elixirs (armour while you level) or sell them."] = "{item:5997}: оранжевый на 1 (желтый 55, зеленый 75, серый 95): около 82 изготовлений до 75. Каждое требует 1 {item:765}, 1 {item:2447} и 1 {item:3371}. Известно с самого начала и это самый дешевый способ пройти диапазон Подмастерья. Оставьте эликсиры (броня на прокачке) или продавайте их.",

	-- Step 18: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "{skill:171}: Подмастерье",
	-- {skill:171} Alchemy · {npc:4900} Alchemist Narett · {zone:1445} Dustwallow Marsh · {npc:2837} Jaxin Chong · {zone:1434} Stranglethorn Vale · {npc:3964} Kylanna · {zone:1440} Ashenvale · {npc:5499} Lilyssia Nightbreeze · {zone:1453} Stormwind City · {npc:11042} Sylvanna Forestmoon · {zone:1457} Darnassus · {npc:5177} Tally Berryfizz · {zone:1455} Ironforge · {npc:3009} Bena Winterhoof · {zone:1456} Thunder Bluff · {npc:4609} Doctor Marsh · {zone:1458} Undercity · {npc:2391} Serge Hinott · {zone:1424} Hillsbrad Foothills · {npc:3347} Yelmak · {zone:1454} Orgrimmar · {spell:2331} Minor Mana Potion · {spell:1230564} Mana Well · {item:2447} Peacebloom · {item:3371} Empty Vial · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed
	["Journeyman raises the cap from 75 to 150 for 4s 50c (Classic's price; Forever's is not in the data); it needs {skill:171} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:171} trainer teaches it: Alliance {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) and {npc:5177} ({zone:1455}); Horde {npc:3009} ({zone:1456}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:2391} ({zone:1424}) and {npc:3347} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:2331} (from 25, 1s). Also learn {spell:1230564} (1s): Forever's {skill:171} camp item, 1 {item:2447} and 1 {item:3371}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:171} quest from your starting area's camping guide (after The Great Outdoors) sends you to an alchemy trainer who teaches it free. 75-150 takes about 1s of recipes and 9s 8c of vendor goods, plus 77 {item:785}, 152 {item:2450} and 54 {item:2453} to gather or buy."] = "Ранг «Подмастерье» поднимает предел с 75 до 150 за 4с 50м (цена Classic; цены Forever нет в данных); нужен навык {skill:171} 50 и уровень персонажа 10, так что его можно взять при любом визите начиная с 50. Учат ему не все учителя ({skill:171}): Альянс – {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) и {npc:5177} ({zone:1455}); Орда – {npc:3009} ({zone:1456}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:2391} ({zone:1424}) и {npc:3347} ({zone:1454}). Стрелка выбирает ближайшего для вашей фракции. Изучите сейчас: {spell:2331} (с 25, 1с). Изучите также {spell:1230564} (1с): походный предмет Forever для навыка {skill:171} из 1 {item:2447} и 1 {item:3371}; его ставят в лагере у костра ради усиления. Задание «Основы походной жизни: {skill:171}» от проводника по походной жизни в вашей стартовой зоне (после «Диких просторов») отправит вас к учителю алхимии, который обучит этому бесплатно. На 75-150 уйдет около 1с на рецепты и 9с 8м на товары торговцев, плюс 77 {item:785}, 152 {item:2450} и 54 {item:2453} – добудьте или купите.",

	-- Step 19: Alchemy 75-150: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 75-150: vendor goods"] = "{skill:171} 75-150: товары торговцев",
	-- {item:3371} Empty Vial · {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 77 {item:3371} (3s 8c) and 15 {item:3372} (6s); about 9s 8c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Купите сразу все для этого этапа: {item:3371} 77 (3с 8м) и {item:3372} 15 (6с); всего около 9с 8м. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:1286}, {npc:5503} и {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} и {npc:3334}).",

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
	["{spell:2331} to 90"] = "{spell:2331} до 90",
	-- {spell:2331} Minor Mana Potion · {item:785} Mageroyal · {item:2447} Peacebloom · {item:3371} Empty Vial · {spell:3171} Elixir of Wisdom
	["{spell:2331} is yellow at 75 (yellow 65, green 85, grey 105): about 28 crafts to 90. Each takes 1 {item:785}, 1 {item:2447} and 1 {item:3371}. The trainer teaches it from 25. It is yellow already, so count on about two crafts a point until {spell:3171} takes over at 90. {item:785} grows in the 10-25 zones."] = "{spell:2331}: желтый на 75 (желтый 65, зеленый 85, серый 105): около 28 изготовлений до 90. Каждое требует 1 {item:785}, 1 {item:2447} и 1 {item:3371}. Этому обучает учитель с 25. Уже желтый, так что рассчитывайте примерно на два изготовления на очко, пока на 90 не придет {spell:3171}. {item:785} растет в зонах 10-25 уровня.",

	-- Step 37: Alchemy recipes at 90
	-- {skill:171} Alchemy
	["{skill:171} recipes at 90"] = "{skill:171}: рецепты на 90",
	-- {skill:171} Alchemy · {spell:3171} Elixir of Wisdom
	["Back to an {skill:171} trainer: {spell:3171} (from 90)."] = "Вернитесь к учителю ({skill:171}): {spell:3171} (с 90).",

	-- Step 38: Elixir of Wisdom to 135
	-- {spell:3171} Elixir of Wisdom
	["{spell:3171} to 135"] = "{spell:3171} до 135",
	-- {spell:3171} Elixir of Wisdom · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3371} Empty Vial
	["{spell:3171} is orange at 90 (yellow 120, green 140, grey 160): about 49 crafts to 135. Each takes 1 {item:785}, 2 {item:2450} and 1 {item:3371}. Two {item:2450} and a {item:785} a craft, both from the 10-25 zones; orange to 120."] = "{spell:3171}: оранжевый на 90 (желтый 120, зеленый 140, серый 160): около 49 изготовлений до 135. Каждое требует 1 {item:785}, 2 {item:2450} и 1 {item:3371}. Два {item:2450} и {item:785} на изготовление, оба из зон 10-25 уровня; оранжевый до 120.",

	-- Step 39: Alchemy recipes at 135
	-- {skill:171} Alchemy
	["{skill:171} recipes at 135"] = "{skill:171}: рецепты на 135",
	-- {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir
	["Back to an {skill:171} trainer: {spell:3176} (from 125)."] = "Вернитесь к учителю ({skill:171}): {spell:3176} (с 125).",

	-- Step 40: Lesser Troll's Blood Elixir to 150
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 150"] = "{spell:3176} до 150",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial · {skill:171} Alchemy
	["{spell:3176} is orange at 135 (yellow 150, green 170, grey 190): about 15 crafts to 150, a point every craft. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. {skill:171} 150 is a Legacy System milestone."] = "{spell:3176}: оранжевый на 135 (желтый 150, зеленый 170, серый 190): около 15 изготовлений до 150, по очку за каждое. Каждое требует 2 {item:2453}, 2 {item:2450} и 1 {item:3372}. Два {item:2453} и два {item:2450} на изготовление; {item:2453} растет в зонах 15-30 уровня. {skill:171} 150 – веха системы Наследия.",

	-- Step 41: Alchemy 150-225: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 150-225: vendor goods"] = "{skill:171} 150-225: товары торговцев",
	-- {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 83 {item:3372} (33s 20c); about 33s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Купите сразу все для этого этапа: {item:3372} 83 (33с 20м); всего около 33с 20м. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:1286}, {npc:5503} и {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} и {npc:3334}).",

	-- Step 42: Get Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	-- was: ["{item:3355} (Alliance)"] = "{item:3355} (Альянс)"
	["Get {object:1623} (Alliance)"] = "",
	-- {object:1623} Wild Steelbloom · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	-- was: ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1434} is marked."] = "{object:1623} 40 для {item:8951} (8 из них на 225-300: соберите все сейчас): {skill:182}: {object:1623} (навык 115) в {zone:1442} (15-27), {zone:1417} (30-40) и {zone:1434} (30-45). В {zone:1434} отмечено место, где {object:1623} встречается чаще всего."
	["You need 40 {object:1623} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 43: Get Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	-- was: ["{item:3355} (Horde)"] = "{item:3355} (Орда)"
	["Get {object:1623} (Horde)"] = "",
	-- {object:1623} Wild Steelbloom · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	-- was: ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1442} is marked."] = "{object:1623} 40 для {item:8951} (8 из них на 225-300: соберите все сейчас): {skill:182}: {object:1623} (навык 115) в {zone:1442} (15-27), {zone:1417} (30-40) и {zone:1434} (30-45). В {zone:1442} отмечено место, где {object:1623} встречается чаще всего."
	["You need 40 {object:1623} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1442} is marked. Or buy them at the Auction House."] = "",

	-- Step 44: Get Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["Get {item:3356} (Alliance)"] = "",
	-- {item:3356} Kingsblood · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1440} Ashenvale · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale
	-- was: ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1434} is marked."] = "{item:3356} 39 для {spell:3452}: {skill:182}: {item:3356} (навык 125) в {zone:1440} (18-30), {zone:1437} (20-30) и {zone:1434} (30-45). В {zone:1434} отмечено место, где {item:3356} встречается чаще всего."
	["You need 39 {item:3356} for {skill:171} 150-225: {spell:3452}. {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 45: Get Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["Get {item:3356} (Horde)"] = "",
	-- {item:3356} Kingsblood · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1434} Stranglethorn Vale
	-- was: ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1413} is marked."] = "{item:3356} 39 для {spell:3452}: {skill:182}: {item:3356} (навык 125) в {zone:1413} (10-25), {zone:1440} (18-30) и {zone:1434} (30-45). В {zone:1413} отмечено место, где {item:3356} встречается чаще всего."
	["You need 39 {item:3356} for {skill:171} 150-225: {spell:3452}. {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 46: Get Stranglekelp (Alliance)
	-- {object:2045} Stranglekelp
	["Get {object:2045} (Alliance)"] = "",
	-- {object:2045} Stranglekelp · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	-- was: ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1434} is marked."] = "{object:2045} 39 для {spell:3452}: {skill:182}: {object:2045} (навык 85) в {zone:1437} (20-30), {zone:1434} (30-45) и {zone:1425} (40-50). В {zone:1434} отмечено место, где {object:2045} встречается чаще всего."
	["You need 39 {object:2045} for {skill:171} 150-225: {spell:3452}. {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1434} is marked. Or buy them at the Auction House."] = "",

	-- Step 47: Get Stranglekelp (Horde)
	-- {object:2045} Stranglekelp
	["Get {object:2045} (Horde)"] = "",
	-- {object:2045} Stranglekelp · {skill:171} Alchemy · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	-- was: ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1413} is marked."] = "{object:2045} 39 для {spell:3452}: {skill:182}: {object:2045} (навык 85) в {zone:1413} (10-25), {zone:1434} (30-45) и {zone:1425} (40-50). В {zone:1413} отмечено место, где {object:2045} встречается чаще всего."
	["You need 39 {object:2045} for {skill:171} 150-225: {spell:3452}. {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1413} is marked. Or buy them at the Auction House."] = "",

	-- Step 48: Get Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["Get {object:2046} (Alliance)"] = "",
	-- {object:2046} Goldthorn · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	-- was: ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1417} is marked."] = "{object:2046} 40 для {item:8951} (8 из них на 225-300: соберите все сейчас): {skill:182}: {object:2046} (навык 170) в {zone:1417} (30-40), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1417} отмечено место, где {object:2046} встречается чаще всего."
	["You need 40 {object:2046} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1417} is marked. Or buy them at the Auction House."] = "",

	-- Step 49: Get Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["Get {object:2046} (Horde)"] = "",
	-- {object:2046} Goldthorn · {skill:171} Alchemy · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	-- was: ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1444} is marked."] = "{object:2046} 40 для {item:8951} (8 из них на 225-300: соберите все сейчас): {skill:182}: {object:2046} (навык 170) в {zone:1417} (30-40), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1444} отмечено место, где {object:2046} встречается чаще всего."
	["You need 40 {object:2046} for {skill:171} 150-225: {item:8951} (8 of them for 225-300: get them all now). {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1444} is marked. Or buy them at the Auction House."] = "",

	-- Step 50: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "{skill:171}: Умелец",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {object:2045} Stranglekelp · {object:2046} Goldthorn · {spell:3452} Mana Potion · {item:8951} Elixir of Defense
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4160} ({zone:1457}); Horde {npc:4611} ({zone:1458}). The arrow picks the nearest of your faction. 150-225 takes about 33s 20c of vendor goods, plus 40 {object:1623}, 39 {item:3356}, 39 {object:2045} and 40 {object:2046} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:3452} (from 160) and {item:8951} (from 195), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Ранг «Умелец» поднимает предел со 150 до 225 за 50с (цена Classic; цены Forever нет в данных); нужен навык {skill:171} 125 и уровень персонажа 20, так что его можно взять при любом визите начиная со 125. Учат ему лишь немногие: Альянс – {npc:4160} ({zone:1457}); Орда – {npc:4611} ({zone:1458}). Стрелка выбирает ближайшего для вашей фракции. На 150-225 уйдет около 33с 20м на товары торговцев, плюс 40 {object:1623}, 39 {item:3356}, 39 {object:2045} и 40 {object:2046} – добудьте или купите. Приходите со всем этим в сумках (шаги выше, остальное – с аукциона): эти учителя также обучают {spell:3452} (со 160) и {item:8951} (со 195), а для изготовления не нужен станок, так что создавайте прямо здесь и изучайте каждый рецепт, как только достигнете нужного навыка. Одна поездка вместо 3.",

	-- Step 51: Lesser Troll's Blood Elixir to 160
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 160"] = "{spell:3176} до 160",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial
	["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. If you got here without learning {spell:3176}, learn it now: an earlier step teaches it."] = "{spell:3176}: желтый на 150 (желтый 150, зеленый 170, серый 190): около 12 изготовлений до 160. Каждое требует 2 {item:2453}, 2 {item:2450} и 1 {item:3372}. Два {item:2453} и два {item:2450} на изготовление; {item:2453} растет в зонах 15-30 уровня. Если вы дошли сюда, не выучив {spell:3176}, выучите сейчас: его учит один из прошлых шагов.",

	-- Step 52: Alchemy recipes at 160
	-- {skill:171} Alchemy
	["{skill:171} recipes at 160"] = "{skill:171}: рецепты на 160",
	-- {spell:3452} Mana Potion
	["Still at the Expert trainer: {spell:3452} (from 160)."] = "Вы все еще у учителя ранга «Умелец»: {spell:3452} (с 160).",

	-- Step 53: Mana Potion to 195
	-- {spell:3452} Mana Potion
	["{spell:3452} to 195"] = "{spell:3452} до 195",
	-- {spell:3452} Mana Potion · {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3372} Leaded Vial
	["{spell:3452} is orange at 160 (yellow 180, green 200, grey 220): about 39 crafts to 195. Each takes 1 {item:3820}, 1 {item:3356} and 1 {item:3372}. {item:3820} grows under water along the coasts: bring a water breathing elixir or come up for air. {item:3356} grows in the 20-40 zones."] = "{spell:3452}: оранжевый на 160 (желтый 180, зеленый 200, серый 220): около 39 изготовлений до 195. Каждое требует 1 {item:3820}, 1 {item:3356} и 1 {item:3372}. {item:3820} растет под водой вдоль побережий: возьмите эликсир водного дыхания или поднимайтесь за воздухом. {item:3356} растет в зонах 20-40 уровня.",

	-- Step 54: Alchemy recipes at 195
	-- {skill:171} Alchemy
	["{skill:171} recipes at 195"] = "{skill:171}: рецепты на 195",
	-- {spell:11450} Elixir of Defense
	["Still at the Expert trainer: {spell:11450} (from 195)."] = "Вы все еще у учителя ранга «Умелец»: {spell:11450} (с 195).",

	-- Step 55: Elixir of Defense to 225
	-- {item:8951} Elixir of Defense
	["{item:8951} to 225"] = "{item:8951} до 225",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands · {skill:171} Alchemy
	["{item:8951} is orange at 195 (yellow 215, green 235, grey 255): about 32 crafts to 225. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). {skill:171} 225 is a Legacy System milestone."] = "{item:8951}: оранжевый на 195 (желтый 215, зеленый 235, серый 255): около 32 изготовлений до 225. Каждое требует 1 {item:3355}, 1 {item:3821} и 1 {item:3372}. {item:3355} и {item:3821} – травы зон 30-45 уровня (Тернистая долина, Арати, {zone:1418}). {skill:171} 225 – веха системы Наследия.",

	-- Step 56: Alchemy 225-300: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 225-300: vendor goods"] = "{skill:171} 225-300: товары торговцев",
	-- {item:3372} Leaded Vial · {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:5503} Eldraeith · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 51 {item:3372} (20s 40c) and 86 {item:8925} (4g 30s); about 4g 50s 40c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, {npc:5503} and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "Купите сразу все для этого этапа: {item:3372} 51 (20с 40м) и {item:8925} 86 (4з 30с); всего около 4з 50с 40м. Стрелка выбирает ближайшего продавца вашей фракции ({zone:1453}: {npc:1286}, {npc:5503} и {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} и {npc:3334}).",

	-- Step 57: Recipe: Elixir of Superior Defense
	-- {item:13478} Recipe: Elixir of Superior Defense · {item:13445} Elixir of Greater Defense · {skill:171} Alchemy · {npc:5178} Soolie Berryfizz · {zone:1455} Ironforge · {npc:3348} Kor'geld · {zone:1454} Orgrimmar
	["{item:13478} teaches {item:13445} ({skill:171} 265) for 1g 30s. Sold by Alliance: {npc:5178} ({zone:1455}), limited stock; Horde: {npc:3348} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "",

	-- Step 58: Get Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	-- was: ["{item:8836} (Alliance)"] = "{item:8836} (Альянс)"
	["Get {item:8836} (Alliance)"] = "",
	-- {item:8836} Arthas' Tears · {skill:171} Alchemy · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	-- was: ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1422} is marked."] = "{item:8836} 43 для {item:9154}: {skill:182}: {item:8836} (навык 220) в {zone:1448} (48-55), {zone:1422} (51-58) и {zone:1423} (53-60). В {zone:1422} отмечено место, где {item:8836} встречается чаще всего."
	["You need 43 {item:8836} for {skill:171} 225-300: {item:9154}. {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1422} is marked. Or buy them at the Auction House."] = "",

	-- Step 59: Get Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	-- was: ["{item:8836} (Horde)"] = "{item:8836} (Орда)"
	["Get {item:8836} (Horde)"] = "",
	-- {item:8836} Arthas' Tears · {skill:171} Alchemy · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	-- was: ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1448} is marked."] = "{item:8836} 43 для {item:9154}: {skill:182}: {item:8836} (навык 220) в {zone:1448} (48-55), {zone:1422} (51-58) и {zone:1423} (53-60). В {zone:1448} отмечено место, где {item:8836} встречается чаще всего."
	["You need 43 {item:8836} for {skill:171} 225-300: {item:9154}. {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1448} is marked. Or buy them at the Auction House."] = "",

	-- Step 60: Get Sungrass (Alliance)
	-- {item:8838} Sungrass
	["Get {item:8838} (Alliance)"] = "",
	-- {item:8838} Sungrass · {skill:171} Alchemy · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- was: ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1425} is marked."] = "{item:8838} 43 для {item:13445}: {skill:182}: {item:8838} (навык 230) в {zone:1425} (40-50), {zone:1444} (40-50) и {zone:1447} (45-55). В {zone:1425} отмечено место, где {item:8838} встречается чаще всего."
	["You need 43 {item:8838} for {skill:171} 225-300: {item:13445}. {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1425} is marked. Or buy them at the Auction House."] = "",

	-- Step 61: Get Sungrass (Horde)
	-- {item:8838} Sungrass
	["Get {item:8838} (Horde)"] = "",
	-- {item:8838} Sungrass · {skill:171} Alchemy · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- was: ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1444} is marked."] = "{item:8838} 43 для {item:13445}: {skill:182}: {item:8838} (навык 230) в {zone:1425} (40-50), {zone:1444} (40-50) и {zone:1447} (45-55). В {zone:1444} отмечено место, где {item:8838} встречается чаще всего."
	["You need 43 {item:8838} for {skill:171} 225-300: {item:13445}. {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1444} is marked. Or buy them at the Auction House."] = "",

	-- Step 62: Get Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	-- was: ["{item:13422} (Alliance)"] = "{item:13422} (Альянс)"
	["Get {item:13422} (Alliance)"] = "",
	-- {item:13422} Stonescale Eel · {skill:171} Alchemy · {item:13445} Elixir of Greater Defense · {object:180712} Stonescale Eel Swarm
	["You need 43 {item:13422} for {skill:171} 225-300: {item:13445}. Fish them from the {object:180712} pools at the marked spot. Or buy them at the Auction House."] = "",

	-- Step 63: Get Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	-- was: ["{item:13422} (Horde)"] = "{item:13422} (Орда)"
	["Get {item:13422} (Horde)"] = "",

	-- Step 64: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "{skill:171}: Искусник",
	-- {skill:171} Alchemy · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:13422} Stonescale Eel · {item:9154} Draught of Detect Undead · {item:13423} Stonescale Oil
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:7948} ({zone:1444}); Horde {npc:1386} ({zone:1435}). The arrow picks the nearest of your faction. 225-300 takes about 1g 30s of recipes and 4g 50s 40c of vendor goods, plus 43 {item:8836}, 43 {item:8838} and 43 {item:13422} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9154} (from 230) and {item:13423} (from 250), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "Мастерство поднимает предел с 225 до 300 за 4g 50s (цена Classic; цена Forever в данных отсутствует); требуется 200 {skill:171} и 35 уровень персонажа, так что брать его можно на любом визите с 200. Обучают лишь немногие наставники: Альянс — {npc:7948} ({zone:1444}); Орда — {npc:1386} ({zone:1435}). Стрелка укажет ближайшего к вам по фракции. На 225-300 уйдёт примерно 1g 30s рецептов и 4g 50s 40c товаров у продавцов, плюс 43 {item:8836}, 43 {item:8838} и 43 {item:13422}, которые нужно собрать или купить. Приходите со всем в сумках (шаги выше, остальное с аукциона): эти же наставники обучают {item:9154} (с 230) и {item:13423} (с 250), а для создания не нужен станок — делайте прямо здесь и учите каждый рецепт, достигнув его навыка. Один визит вместо трёх.",

	-- Step 65: Elixir of Defense to 230
	-- {item:8951} Elixir of Defense
	["{item:8951} to 230"] = "{item:8951} до 230",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands
	["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). If you got here without learning {item:8951}, learn it now: an earlier step teaches it."] = "{item:8951}: желтый на 225 (желтый 215, зеленый 235, серый 255): около 8 изготовлений до 230. Каждое требует 1 {item:3355}, 1 {item:3821} и 1 {item:3372}. {item:3355} и {item:3821} – травы зон 30-45 уровня (Тернистая долина, Арати, {zone:1418}). Если вы дошли сюда, не выучив {item:8951}, выучите сейчас: его учит один из прошлых шагов.",

	-- Step 66: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "{skill:171}: рецепты на 230",
	-- {spell:11460} Draught of Detect Undead
	["Still at the Artisan trainer: {spell:11460} (from 230)."] = "Вы все еще у учителя ранга «Искусник»: {spell:11460} (с 230).",

	-- Step 67: Draught of Detect Undead to 265
	-- {item:9154} Draught of Detect Undead
	["{item:9154} to 265"] = "{item:9154} до 265",
	-- {item:9154} Draught of Detect Undead · {item:8836} Arthas' Tears · {item:8925} Crystal Vial · {zone:1448} Felwood · {skill:182} Herbalism
	-- plural, as words: Crystal Vials = {item:8925} Crystal Vial
	["{item:9154} is orange at 230 (yellow 245, green 265, grey 285): about 43 crafts to 265. Each takes 1 {item:8836} and 1 {item:8925}. {item:8836} grow in the Plaguelands and {zone:1448} ({skill:182} 220); Crystal Vials come from alchemy vendors."] = "{item:9154}: оранжевый на 230 (желтый 245, зеленый 265, серый 285): около 43 изготовлений до 265. Каждое требует 1 {item:8836} и 1 {item:8925}. {item:8836} растет в Чумных землях и {zone:1448} ({skill:182} 220); хрустальные колбы продаются у алхимиков.",

	-- Step 68: Alchemy recipes at 265
	-- {skill:171} Alchemy
	["{skill:171} recipes at 265"] = "{skill:171}: рецепты на 265",
	-- {spell:17551} Stonescale Oil
	["Still at the Artisan trainer: {spell:17551} (from 250)."] = "Вы все еще у учителя ранга «Искусник»: {spell:17551} (с 250).",

	-- Step 69: Elixir of Greater Defense to 300
	-- {item:13445} Elixir of Greater Defense
	["{item:13445} to 300"] = "{item:13445} до 300",
	-- {item:13445} Elixir of Greater Defense · {item:13423} Stonescale Oil · {item:8838} Sungrass · {item:8925} Crystal Vial · {item:13422} Stonescale Eel · {skill:171} Alchemy
	["{item:13445} is orange at 265 (yellow 280, green 300, grey 320): about 43 crafts to 300. Each takes 2 {item:13423}, 1 {item:8838} and 1 {item:8925}. Make the 86 {item:13423} (43 crafts) first. {item:13422} comes from the {item:13422} schools on the coasts of the 40-55 zones, or the Auction House (fishers sell them in stacks). {item:8838} grows in the 40-55 zones. {skill:171} 300 is a Legacy System milestone."] = "{item:13445}: оранжевый на 265 (желтый 280, зеленый 300, серый 320): около 43 изготовлений до 300. Каждое требует 2 {item:13423}, 1 {item:8838} и 1 {item:8925}. Сначала сделайте 86 {item:13423} (43 изготовления). {item:13422} попадается в косяках {item:13422} на побережьях зон 40-55 уровня или на аукционе (рыбаки продают их стопками). {item:8838} растет в зонах 40-55 уровня. {skill:171} 300 – веха системы Наследия.",
	["from the recipe in your bags"] = "по рецепту из сумки",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1411} is marked."] = "{item:2447} 110 для {item:5997} и {spell:2331} (28 из них на 75-150: соберите все сейчас): {skill:182}: {item:2447} (навык 1). В {zone:1411} отмечено место, где {item:2447} встречается чаще всего.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1412} is marked."] = "{item:2447} 110 для {item:5997} и {spell:2331} (28 из них на 75-150: соберите все сейчас): {skill:182}: {item:2447} (навык 1). В {zone:1412} отмечено место, где {item:2447} встречается чаще всего.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1420} is marked."] = "{item:2447} 110 для {item:5997} и {spell:2331} (28 из них на 75-150: соберите все сейчас): {skill:182}: {item:2447} (навык 1). В {zone:1420} отмечено место, где {item:2447} встречается чаще всего.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1426} is marked."] = "{item:2447} 110 для {item:5997} и {spell:2331} (28 из них на 75-150: соберите все сейчас): {skill:182}: {item:2447} (навык 1). В {zone:1426} отмечено место, где {item:2447} встречается чаще всего.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1429} is marked."] = "{item:2447} 110 для {item:5997} и {spell:2331} (28 из них на 75-150: соберите все сейчас): {skill:182}: {item:2447} (навык 1). В {zone:1429} отмечено место, где {item:2447} встречается чаще всего.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:1438} is marked."] = "{item:2447} 110 для {item:5997} и {spell:2331} (28 из них на 75-150: соберите все сейчас): {skill:182}: {item:2447} (навык 1). В {zone:1438} отмечено место, где {item:2447} встречается чаще всего.",
	-- ["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1). The densest patch of {item:2447} in {zone:2521} is marked."] = "{item:2447} 110 для {item:5997} и {spell:2331} (28 из них на 75-150: соберите все сейчас): {skill:182}: {item:2447} (навык 1). В {zone:2521} отмечено место, где {item:2447} встречается чаще всего.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1413} is marked."] = "{item:2450} 152 для {spell:3171} и {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2450} (навык 70). В {zone:1413} отмечено место, где {item:2450} встречается чаще всего.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1421} is marked."] = "{item:2450} 152 для {spell:3171} и {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2450} (навык 70). В {zone:1421} отмечено место, где {item:2450} встречается чаще всего.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1432} is marked."] = "{item:2450} 152 для {spell:3171} и {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2450} (навык 70). В {zone:1432} отмечено место, где {item:2450} встречается чаще всего.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1436} is marked."] = "{item:2450} 152 для {spell:3171} и {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2450} (навык 70). В {zone:1436} отмечено место, где {item:2450} встречается чаще всего.",
	-- ["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70). The densest patch of {item:2450} in {zone:1439} is marked."] = "{item:2450} 152 для {spell:3171} и {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2450} (навык 70). В {zone:1439} отмечено место, где {item:2450} встречается чаще всего.",
	-- ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1413} is marked."] = "{item:3356} 39 для {spell:3452}: {skill:182}: {item:3356} (навык 125) в {zone:1413} (10-25), {zone:1440} (18-30) и {zone:1434} (30-45). В {zone:1413} отмечено место, где {item:3356} встречается чаще всего.",
	-- ["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45). The densest patch of {item:3356} in {zone:1434} is marked."] = "{item:3356} 39 для {spell:3452}: {skill:182}: {item:3356} (навык 125) в {zone:1440} (18-30), {zone:1437} (20-30) и {zone:1434} (30-45). В {zone:1434} отмечено место, где {item:3356} встречается чаще всего.",
	-- ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1413} is marked."] = "{object:2045} 39 для {spell:3452}: {skill:182}: {object:2045} (навык 85) в {zone:1413} (10-25), {zone:1434} (30-45) и {zone:1425} (40-50). В {zone:1413} отмечено место, где {object:2045} встречается чаще всего.",
	-- ["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50). The densest patch of {object:2045} in {zone:1434} is marked."] = "{object:2045} 39 для {spell:3452}: {skill:182}: {object:2045} (навык 85) в {zone:1437} (20-30), {zone:1434} (30-45) и {zone:1425} (40-50). В {zone:1434} отмечено место, где {object:2045} встречается чаще всего.",
	-- ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1434} is marked."] = "{object:1623} 40 для {item:8951} (8 из них на 225-300: соберите все сейчас): {skill:182}: {object:1623} (навык 115) в {zone:1442} (15-27), {zone:1417} (30-40) и {zone:1434} (30-45). В {zone:1434} отмечено место, где {object:1623} встречается чаще всего.",
	-- ["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45). The densest patch of {object:1623} in {zone:1442} is marked."] = "{object:1623} 40 для {item:8951} (8 из них на 225-300: соберите все сейчас): {skill:182}: {object:1623} (навык 115) в {zone:1442} (15-27), {zone:1417} (30-40) и {zone:1434} (30-45). В {zone:1442} отмечено место, где {object:1623} встречается чаще всего.",
	-- ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1417} is marked."] = "{object:2046} 40 для {item:8951} (8 из них на 225-300: соберите все сейчас): {skill:182}: {object:2046} (навык 170) в {zone:1417} (30-40), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1417} отмечено место, где {object:2046} встречается чаще всего.",
	-- ["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50). The densest patch of {object:2046} in {zone:1444} is marked."] = "{object:2046} 40 для {item:8951} (8 из них на 225-300: соберите все сейчас): {skill:182}: {object:2046} (навык 170) в {zone:1417} (30-40), {zone:1425} (40-50) и {zone:1444} (40-50). В {zone:1444} отмечено место, где {object:2046} встречается чаще всего.",
	-- ["43 {item:13422} for {item:13445}: {skill:356}. Fish {object:180712} here."] = "{item:13422} 43 для {item:13445}: {skill:356}. Рыбачьте здесь: {object:180712} here.",
	-- ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1422} is marked."] = "{item:8836} 43 для {item:9154}: {skill:182}: {item:8836} (навык 220) в {zone:1448} (48-55), {zone:1422} (51-58) и {zone:1423} (53-60). В {zone:1422} отмечено место, где {item:8836} встречается чаще всего.",
	-- ["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60). The densest patch of {item:8836} in {zone:1448} is marked."] = "{item:8836} 43 для {item:9154}: {skill:182}: {item:8836} (навык 220) в {zone:1448} (48-55), {zone:1422} (51-58) и {zone:1423} (53-60). В {zone:1448} отмечено место, где {item:8836} встречается чаще всего.",
	-- ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1425} is marked."] = "{item:8838} 43 для {item:13445}: {skill:182}: {item:8838} (навык 230) в {zone:1425} (40-50), {zone:1444} (40-50) и {zone:1447} (45-55). В {zone:1425} отмечено место, где {item:8838} встречается чаще всего.",
	-- ["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8838} in {zone:1444} is marked."] = "{item:8838} 43 для {item:13445}: {skill:182}: {item:8838} (навык 230) в {zone:1425} (40-50), {zone:1444} (40-50) и {zone:1447} (45-55). В {zone:1444} отмечено место, где {item:8838} встречается чаще всего.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1413} is marked."] = "{item:2453} 54 для {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2453} (навык 100). В {zone:1413} отмечено место, где {item:2453} встречается чаще всего.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1421} is marked."] = "{item:2453} 54 для {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2453} (навык 100). В {zone:1421} отмечено место, где {item:2453} встречается чаще всего.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1432} is marked."] = "{item:2453} 54 для {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2453} (навык 100). В {zone:1432} отмечено место, где {item:2453} встречается чаще всего.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1436} is marked."] = "{item:2453} 54 для {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2453} (навык 100). В {zone:1436} отмечено место, где {item:2453} встречается чаще всего.",
	-- ["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100). The densest patch of {item:2453} in {zone:1439} is marked."] = "{item:2453} 54 для {spell:3176} (24 из них на 150-225: соберите все сейчас): {skill:182}: {item:2453} (навык 100). В {zone:1439} отмечено место, где {item:2453} встречается чаще всего.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1413} is marked."] = "{item:785} 77 для {spell:2331} и {spell:3171}: {skill:182}: {item:785} (навык 50). В {zone:1413} отмечено место, где {item:785} встречается чаще всего.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1421} is marked."] = "{item:785} 77 для {spell:2331} и {spell:3171}: {skill:182}: {item:785} (навык 50). В {zone:1421} отмечено место, где {item:785} встречается чаще всего.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1432} is marked."] = "{item:785} 77 для {spell:2331} и {spell:3171}: {skill:182}: {item:785} (навык 50). В {zone:1432} отмечено место, где {item:785} встречается чаще всего.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1436} is marked."] = "{item:785} 77 для {spell:2331} и {spell:3171}: {skill:182}: {item:785} (навык 50). В {zone:1436} отмечено место, где {item:785} встречается чаще всего.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:1438} is marked."] = "{item:785} 77 для {spell:2331} и {spell:3171}: {skill:182}: {item:785} (навык 50). В {zone:1438} отмечено место, где {item:785} встречается чаще всего.",
	-- ["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50). The densest patch of {item:785} in {zone:2521} is marked."] = "{item:785} 77 для {spell:2331} и {spell:3171}: {skill:182}: {item:785} (навык 50). В {zone:2521} отмечено место, где {item:785} встречается чаще всего.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1411} is marked."] = "{item:765} 82 для {item:5997}: {skill:182}: {item:765} (навык 1). В {zone:1411} отмечено место, где {item:765} встречается чаще всего.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1412} is marked."] = "{item:765} 82 для {item:5997}: {skill:182}: {item:765} (навык 1). В {zone:1412} отмечено место, где {item:765} встречается чаще всего.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1420} is marked."] = "{item:765} 82 для {item:5997}: {skill:182}: {item:765} (навык 1). В {zone:1420} отмечено место, где {item:765} встречается чаще всего.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1426} is marked."] = "{item:765} 82 для {item:5997}: {skill:182}: {item:765} (навык 1). В {zone:1426} отмечено место, где {item:765} встречается чаще всего.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1429} is marked."] = "{item:765} 82 для {item:5997}: {skill:182}: {item:765} (навык 1). В {zone:1429} отмечено место, где {item:765} встречается чаще всего.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:1438} is marked."] = "{item:765} 82 для {item:5997}: {skill:182}: {item:765} (навык 1). В {zone:1438} отмечено место, где {item:765} встречается чаще всего.",
	-- ["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1). The densest patch of {item:765} in {zone:2521} is marked."] = "{item:765} 82 для {item:5997}: {skill:182}: {item:765} (навык 1). В {zone:2521} отмечено место, где {item:765} встречается чаще всего.",
	-- ["Apprentice {skill:171}"] = "{skill:171}: Ученик",
	-- ["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "Ранг «Искусник» требует уровня персонажа 35 и навыка {skill:171} 200; предел становится 300. Материалы на 225-300 стоят всего около 7з 80с.",
	-- ["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "Вернитесь к учителю ({skill:171}): {spell:11447} – с навыка {skill:171} 190.",
	-- ["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "Вернитесь к учителю ({skill:171}): {spell:1244645} – с навыка {skill:171} 85.",
	-- ["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "Вернитесь к учителю ({skill:171}): {spell:1244647} – с навыка {skill:171} 175.",
	-- ["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "Вернитесь к учителю ({skill:171}): {spell:1244648} – с навыка {skill:171} 230.",
	-- ["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "Вернитесь к учителю ({skill:171}): {spell:7845} – с навыка {skill:171} 165.",
	-- ["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "Ранг «Умелец» требует уровня персонажа 20 и навыка {skill:171} 125; предел становится 225. Материалы на 150-225 стоят всего около 3з 65с.",
	-- ["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "Ловите рыбу: {object:180582} – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "Ловите рыбу: {object:180657} – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "Ловите рыбу: {object:180712} – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "Ранг «Подмастерье» требует уровня персонажа 10 и навыка {skill:171} 50; предел становится 150. Материалы на 75-150 стоят всего около 1з 44с.",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Убивайте существ, с которых он падает, в месте, выбранном Polestar для вашего уровня и фракции. Подойдет и аукцион.",
	-- ["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 130, желтый до 150, зеленый до 170. {skill:171} 150 – рубеж Системы наследия.",
	-- ["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "Оранжевый (очко за каждое изготовление) до 280, желтый до 300, зеленый до 320. {skill:171} 300 – рубеж Системы наследия.",
	-- ["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "Оранжевый (очко за каждое изготовление) до 55, желтый до 75, зеленый до 95. 75 – предел ранга «Ученик».",
	-- ["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:2447}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:2450}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:2453}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:3355}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:3356}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:3357}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:3821}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:765}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:785}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:8836}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{item:8838}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{object:1623}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{object:2046}: собирайте ({skill:182}) – по данным, здесь его больше всего. Подойдет и аукцион.",
	-- ["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks."] = "Обучает: {item:6051} (нужно {skill:171} 100). У торговцев – ограниченный запас, который пополняется.",
	-- ["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "Обучает: {item:8951} (нужно {skill:171} 265). У торговцев – ограниченный запас, который пополняется; часто бывает и на аукционе.",
	-- ["What 1-75 takes that the Auction House sells: 82 {item:765} and 110 {item:2447}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 1-75 и продается на аукционе: 82 {item:765} и 110 {item:2447}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["What 150-225 takes that the Auction House sells: 40 {item:3355}, 39 {item:3356}, 39 {item:3820} and 40 {item:3821}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 150-225 и продается на аукционе: 40 {item:3355}, 39 {item:3356}, 39 {item:3820} и 40 {item:3821}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["What 225-300 takes that the Auction House sells: 43 {item:8836}, 43 {item:8838} and 43 {item:13422}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 225-300 и продается на аукционе: 43 {item:8836}, 43 {item:8838} и 43 {item:13422}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["What 75-150 takes that the Auction House sells: 77 {item:785}, 152 {item:2450} and 54 {item:2453}. The counts drop by what your bags, bank and mail hold."] = "Что нужно на 75-150 и продается на аукционе: 77 {item:785}, 152 {item:2450} и 54 {item:2453}. Количество уменьшается на то, что уже лежит в сумках, банке и на почте.",
	-- ["Yellow until 105, green until 125: not every craft gives a point."] = "Желтый до 105, зеленый до 125: не каждое изготовление дает очко.",
	-- ["Yellow until 160, green until 170: not every craft gives a point."] = "Желтый до 160, зеленый до 170: не каждое изготовление дает очко.",
	-- ["Yellow until 185, green until 205: not every craft gives a point."] = "Желтый до 185, зеленый до 205: не каждое изготовление дает очко.",
	-- ["Yellow until 195, green until 215: not every craft gives a point."] = "Желтый до 195, зеленый до 215: не каждое изготовление дает очко.",
	-- ["Yellow until 210, green until 230: not every craft gives a point."] = "Желтый до 210, зеленый до 230: не каждое изготовление дает очко.",
	-- ["Yellow until 235, green until 255: not every craft gives a point."] = "Желтый до 235, зеленый до 255: не каждое изготовление дает очко.",
	-- ["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "Желтый до 235, зеленый до 255: не каждое изготовление дает очко. {skill:171} 225 – рубеж Системы наследия.",
	-- ["Yellow until 250, green until 270: not every craft gives a point."] = "Желтый до 250, зеленый до 270: не каждое изготовление дает очко.",
	-- ["Yellow until 255, green until 260: not every craft gives a point."] = "Желтый до 255, зеленый до 260: не каждое изготовление дает очко.",
	-- ["Yellow until 265, green until 285: not every craft gives a point."] = "Желтый до 265, зеленый до 285: не каждое изготовление дает очко.",
	-- ["Yellow until 85, green until 105: not every craft gives a point."] = "Желтый до 85, зеленый до 105: не каждое изготовление дает очко.",
	-- ["{item:13422} (Alliance)"] = "{item:13422} (Альянс)",
	-- ["{item:13422} (Horde)"] = "{item:13422} (Орда)",
	-- ["{item:13423} to 259"] = "{item:13423} до 259",
	-- ["{item:2447} (Alliance)"] = "{item:2447} (Альянс)",
	-- ["{item:2447} (Horde)"] = "{item:2447} (Орда)",
	-- ["{item:2450} (Alliance)"] = "{item:2450} (Альянс)",
	-- ["{item:2450} (Horde)"] = "{item:2450} (Орда)",
	-- ["{item:2452} (Alliance)"] = "{item:2452} (Альянс)",
	-- ["{item:2452} (Horde)"] = "{item:2452} (Орда)",
	-- ["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452} добывается из: {item:2450} ({skill:182}) – по данным, здесь их больше всего. Подойдет и аукцион.",
	-- ["{item:2453} (Alliance)"] = "{item:2453} (Альянс)",
	-- ["{item:2453} (Horde)"] = "{item:2453} (Орда)",
	-- ["{item:247239} to 100"] = "{item:247239} до 100",
	-- ["{item:247241} to 200"] = "{item:247241} до 200",
	-- ["{item:247242} to 250"] = "{item:247242} до 250",
	-- ["{item:3355} (Alliance)"] = "{item:3355} (Альянс)",
	-- ["{item:3355} (Horde)"] = "{item:3355} (Орда)",
	-- ["{item:3356} (Alliance)"] = "{item:3356} (Альянс)",
	-- ["{item:3356} (Horde)"] = "{item:3356} (Орда)",
	-- ["{item:3357} (Alliance)"] = "{item:3357} (Альянс)",
	-- ["{item:3357} (Horde)"] = "{item:3357} (Орда)",
	-- ["{item:3821} (Alliance)"] = "{item:3821} (Альянс)",
	-- ["{item:3821} (Horde)"] = "{item:3821} (Орда)",
	-- ["{item:6051} to 150"] = "{item:6051} до 150",
	-- ["{item:6358} (Alliance)"] = "{item:6358} (Альянс)",
	-- ["{item:6358} (Horde)"] = "{item:6358} (Орда)",
	-- ["{item:6359} (Alliance)"] = "{item:6359} (Альянс)",
	-- ["{item:6359} (Horde)"] = "{item:6359} (Орда)",
	-- ["{item:6371} to 165"] = "{item:6371} до 165",
	-- ["{item:730} (Alliance)"] = "{item:730} (Альянс)",
	-- ["{item:730} (Horde)"] = "{item:730} (Орда)",
	-- ["{item:765} (Alliance)"] = "{item:765} (Альянс)",
	-- ["{item:765} (Horde)"] = "{item:765} (Орда)",
	-- ["{item:785} (Alliance)"] = "{item:785} (Альянс)",
	-- ["{item:785} (Horde)"] = "{item:785} (Орда)",
	-- ["{item:8836} (Alliance)"] = "{item:8836} (Альянс)",
	-- ["{item:8836} (Horde)"] = "{item:8836} (Орда)",
	-- ["{item:8838} (Alliance)"] = "{item:8838} (Альянс)",
	-- ["{item:8838} (Horde)"] = "{item:8838} (Орда)",
	-- ["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418})."] = "{item:8951}: желтый на 225 (желтый 215, зеленый 235, серый 255): около 8 изготовлений до 230. Каждое требует 1 {item:3355}, 1 {item:3821} и 1 {item:3372}. {item:3355} и {item:3821} – травы зон 30-45 уровня (Тернистая долина, Арати, {zone:1418}).",
	-- ["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "Добыча здесь: {npc:1958} (уровень 17-18). Подойдет и аукцион.",
	-- ["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "Добыча здесь: {npc:513} (уровень 14-15). Подойдет и аукцион.",
	-- ["{object:1623} (Alliance)"] = "{object:1623} (Альянс)",
	-- ["{object:1623} (Horde)"] = "{object:1623} (Орда)",
	-- ["{object:2045} (Alliance)"] = "{object:2045} (Альянс)",
	-- ["{object:2045} (Horde)"] = "{object:2045} (Орда)",
	-- ["{object:2046} (Alliance)"] = "{object:2046} (Альянс)",
	-- ["{object:2046} (Horde)"] = "{object:2046} (Орда)",
	-- ["{skill:171} 1-75: Auction House"] = "{skill:171} 1-75: аукцион",
	-- ["{skill:171} 150-225: Auction House"] = "{skill:171} 150-225: аукцион",
	-- ["{skill:171} 225-300: Auction House"] = "{skill:171} 225-300: аукцион",
	-- ["{skill:171} 75-150: Auction House"] = "{skill:171} 75-150: аукцион",
	-- ["{skill:171} recipes at 259"] = "{skill:171}: рецепты на 259",
	-- ["{skill:171} recipes at 85"] = "{skill:171}: рецепты на 85",
	-- ["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "{skill:171} качается параллельно с уровнем. Система наследия Forever награждает за профессии производства на навыке 150, 225 и 300 (пределы рангов «Подмастерье», «Умелец» и «Искусник»), так что важен каждый рубеж. Материалы на 1-75 стоят всего около 68с.",
	-- ["{spell:11447} to 215"] = "{spell:11447} до 215",
	-- ["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones."] = "{spell:3176}: желтый на 150 (желтый 150, зеленый 170, серый 190): около 12 изготовлений до 160. Каждое требует 2 {item:2453}, 2 {item:2450} и 1 {item:3372}. Два {item:2453} и два {item:2450} на изготовление; {item:2453} растет в зонах 15-30 уровня.",
	-- ["{spell:7845} to 175"] = "{spell:7845} до 175",
}
