-- Chinese (simplified) (zhCN): the guide forever/professions/alchemy (forever/professions/alchemy.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Alchemy
	-- {skill:171} Alchemy
	["Learn {skill:171}"] = "学习{skill:171}",
	-- {skill:171} Alchemy · {skill:182} Herbalism · {item:2447} Peacebloom · {item:765} Silverleaf
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Apprentice {skill:171} lets you craft up to 75 for 10c, at any character level. Any {skill:171} trainer of your faction teaches it; the arrow picks the nearest. Pair it with {skill:182}: {item:2447} and {item:765} grow in every starting zone, and Empty Vials cost 4c at any alchemy or trade supplies vendor. 1-75 takes about 3s 28c of vendor goods, plus 82 {item:765} and 110 {item:2447} to gather or buy."] = "初级{skill:171}的技能上限为75，学习费用10铜币，角色等级不限。向本阵营任意{skill:171}训练师学习即可；箭头指向最近的一位。建议搭配{skill:182}：所有初始地区都有{item:2447}和{item:765}，空瓶在任意炼金或杂货供应商处售价4铜币。1-75所需商人物资约3银28铜，另需采集或购买82个{item:765}和110个{item:2447}。",

	-- Step 2: Alchemy 1-75: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 1-75: vendor goods"] = "{skill:171} 1–75：商人材料",
	-- {item:3371} Empty Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 82 {item:3371} (3s 28c); about 3s 28c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "一次买齐本阶段的用量：82个 {item:3371}（3银28铜）；总计约3银28铜。箭头会指向本阵营最近的商人（{zone:1453}：{npc:1286}、艾达伊斯 和 {npc:1325}；{zone:1454}：{npc:3367}、{npc:3348} 和 {npc:3334}）。",

	-- Step 3: Silverleaf (Elwynn Forest)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1429} is marked."] = "准备82个{item:765}制作{item:5997}：{skill:182}：采集{item:765}（技能1）；或从拍卖行购买。已标记{zone:1429}中{item:765}最密集的位置。",

	-- Step 4: Silverleaf (Dun Morogh)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1426} is marked."] = "准备82个{item:765}制作{item:5997}：{skill:182}：采集{item:765}（技能1）；或从拍卖行购买。已标记{zone:1426}中{item:765}最密集的位置。",

	-- Step 5: Silverleaf (Teldrassil)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1438} Teldrassil
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1438} is marked."] = "准备82个{item:765}制作{item:5997}：{skill:182}：采集{item:765}（技能1）；或从拍卖行购买。已标记{zone:1438}中{item:765}最密集的位置。",

	-- Step 6: Silverleaf (Zephras Isle)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:2521} is marked."] = "准备82个{item:765}制作{item:5997}：{skill:182}：采集{item:765}（技能1）；或从拍卖行购买。已标记{zone:2521}中{item:765}最密集的位置。",

	-- Step 7: Silverleaf (Durotar)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1411} Durotar
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1411} is marked."] = "准备82个{item:765}制作{item:5997}：{skill:182}：采集{item:765}（技能1）；或从拍卖行购买。已标记{zone:1411}中{item:765}最密集的位置。",

	-- Step 8: Silverleaf (Mulgore)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1412} Mulgore
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1412} is marked."] = "准备82个{item:765}制作{item:5997}：{skill:182}：采集{item:765}（技能1）；或从拍卖行购买。已标记{zone:1412}中{item:765}最密集的位置。",

	-- Step 9: Silverleaf (Tirisfal Glades)
	-- {item:765} Silverleaf · {item:5997} Elixir of Minor Defense · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["82 {item:765} for {item:5997}: {skill:182}: {item:765} (skill 1); or the Auction House. The densest patch of {item:765} in {zone:1420} is marked."] = "准备82个{item:765}制作{item:5997}：{skill:182}：采集{item:765}（技能1）；或从拍卖行购买。已标记{zone:1420}中{item:765}最密集的位置。",

	-- Step 10: Peacebloom (Elwynn Forest)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1429} Elwynn Forest
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1429} is marked."] = "准备 110 个 {item:2447}，用于 {item:5997} 和 {spell:2331}（75-150 阶段需要其中 28 个，现在一并采齐）：通过 {skill:182} 采集 {item:2447}（技能 1），或在拍卖行购买。已标记 {zone:1429} 中 {item:2447} 最密集的区域。",

	-- Step 11: Peacebloom (Dun Morogh)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1426} Dun Morogh
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1426} is marked."] = "准备 110 个 {item:2447}，用于 {item:5997} 和 {spell:2331}（75-150 阶段需要其中 28 个，现在一并采齐）：通过 {skill:182} 采集 {item:2447}（技能 1），或在拍卖行购买。已标记 {zone:1426} 中 {item:2447} 最密集的区域。",

	-- Step 12: Peacebloom (Teldrassil)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1438} Teldrassil
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1438} is marked."] = "准备 110 个 {item:2447}，用于 {item:5997} 和 {spell:2331}（75-150 阶段需要其中 28 个，现在一并采齐）：通过 {skill:182} 采集 {item:2447}（技能 1），或在拍卖行购买。已标记 {zone:1438} 中 {item:2447} 最密集的区域。",

	-- Step 13: Peacebloom (Zephras Isle)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:2521} is marked."] = "准备 110 个 {item:2447}，用于 {item:5997} 和 {spell:2331}（75-150 阶段需要其中 28 个，现在一并采齐）：通过 {skill:182} 采集 {item:2447}（技能 1），或在拍卖行购买。已标记 {zone:2521} 中 {item:2447} 最密集的区域。",

	-- Step 14: Peacebloom (Durotar)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1411} Durotar
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1411} is marked."] = "准备 110 个 {item:2447}，用于 {item:5997} 和 {spell:2331}（75-150 阶段需要其中 28 个，现在一并采齐）：通过 {skill:182} 采集 {item:2447}（技能 1），或在拍卖行购买。已标记 {zone:1411} 中 {item:2447} 最密集的区域。",

	-- Step 15: Peacebloom (Mulgore)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1412} Mulgore
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1412} is marked."] = "准备 110 个 {item:2447}，用于 {item:5997} 和 {spell:2331}（75-150 阶段需要其中 28 个，现在一并采齐）：通过 {skill:182} 采集 {item:2447}（技能 1），或在拍卖行购买。已标记 {zone:1412} 中 {item:2447} 最密集的区域。",

	-- Step 16: Peacebloom (Tirisfal Glades)
	-- {item:2447} Peacebloom · {item:5997} Elixir of Minor Defense · {spell:2331} Minor Mana Potion · {skill:182} Herbalism · {zone:1420} Tirisfal Glades
	["110 {item:2447} for {item:5997} and {spell:2331} (28 of them for 75-150: pick them all now): {skill:182}: {item:2447} (skill 1); or the Auction House. The densest patch of {item:2447} in {zone:1420} is marked."] = "准备 110 个 {item:2447}，用于 {item:5997} 和 {spell:2331}（75-150 阶段需要其中 28 个，现在一并采齐）：通过 {skill:182} 采集 {item:2447}（技能 1），或在拍卖行购买。已标记 {zone:1420} 中 {item:2447} 最密集的区域。",

	-- Step 17: Elixir of Minor Defense to 75
	-- {item:5997} Elixir of Minor Defense
	["{item:5997} to 75"] = "{item:5997}练到75",
	-- {item:5997} Elixir of Minor Defense · {item:765} Silverleaf · {item:2447} Peacebloom · {item:3371} Empty Vial
	["{item:5997} is orange at 1 (yellow 55, green 75, grey 95): about 82 crafts to 75. Each takes 1 {item:765}, 1 {item:2447} and 1 {item:3371}. Known from the start and the cheapest way through the Apprentice range. Keep the elixirs (armour while you level) or sell them."] = "{item:5997}在技能1时为橙色（55变黄，75变绿，95变灰）：约制作82次可到75。每次需要1个{item:765}、1个{item:2447}和1个{item:3371}。一开始就会这个配方，是度过初级阶段最便宜的方式。可以保留药剂（练级时增加护甲）或出售。",

	-- Step 18: Journeyman Alchemy
	-- {skill:171} Alchemy
	["Journeyman {skill:171}"] = "中级{skill:171}",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:4900} Alchemist Narett · {zone:1445} Dustwallow Marsh · {npc:2837} Jaxin Chong · {zone:1434} Stranglethorn Vale · {npc:3964} Kylanna · {zone:1440} Ashenvale · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:5499} Lilyssia Nightbreeze · {zone:1453} Stormwind City · {npc:11042} Sylvanna Forestmoon · {npc:5177} Tally Berryfizz · {zone:1455} Ironforge · {npc:3009} Bena Winterhoof · {zone:1456} Thunder Bluff · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {npc:4609} Doctor Marsh · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {npc:2391} Serge Hinott · {zone:1424} Hillsbrad Foothills · {npc:3347} Yelmak · {zone:1454} Orgrimmar · {spell:2331} Minor Mana Potion · {spell:1230564} Mana Well · {item:2447} Peacebloom · {item:3371} Empty Vial · {item:785} Mageroyal · {item:2450} Briarthorn · {item:2453} Bruiseweed
	["Journeyman raises the cap from 75 to 150 for 4s 50c (Classic's price; Forever's is not in the data); it needs {skill:171} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:171} trainer teaches it: Alliance {npc:4160} ({zone:1457}), {npc:4900} ({zone:1445}), {npc:2837} ({zone:1434}), {npc:3964} ({zone:1440}), {npc:7948} ({zone:1444}), {npc:5499} ({zone:1453}), {npc:11042} ({zone:1457}) and {npc:5177} ({zone:1455}); Horde {npc:3009} ({zone:1456}), {npc:4611} ({zone:1458}), {npc:4609} ({zone:1458}), {npc:2837} ({zone:1434}), {npc:1386} ({zone:1435}), {npc:2391} ({zone:1424}) and {npc:3347} ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:2331} (from 25, 1s). Also learn {spell:1230564} (1s): Forever's {skill:171} camp item, 1 {item:2447} and 1 {item:3371}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:171} quest from your starting area's camping guide (after The Great Outdoors) sends you to an alchemy trainer who teaches it free. 75-150 takes about 1s of recipes and 9s 8c of vendor goods, plus 77 {item:785}, 152 {item:2450} and 54 {item:2453} to gather or buy."] = "中级训练将技能上限从 75 提高到 150，费用 4 银 50 铜（经典怀旧服价格；数据中没有无限的价格）；要求 {skill:171} 50 和角色 10 级，所以技能达到 50 后，任何一次经过都可以学习。并非所有 {skill:171} 训练师都能教授：联盟有 {npc:4160}（{zone:1457}）、{npc:4900}（{zone:1445}）、{npc:2837}（{zone:1434}）、{npc:3964}（{zone:1440}）、{npc:7948}（{zone:1444}）、{npc:5499}（{zone:1453}）、{npc:11042}（{zone:1457}）和 {npc:5177}（{zone:1455}）；部落有 {npc:3009}（{zone:1456}）、{npc:4611}（{zone:1458}）、{npc:4609}（{zone:1458}）、{npc:2837}（{zone:1434}）、{npc:1386}（{zone:1435}）、{npc:2391}（{zone:1424}）和 {npc:3347}（{zone:1454}）。箭头会选择本阵营最近的一位。现在学习：{spell:2331}（技能 25 起，1 银币）。也学习 {spell:1230564}（1 银币）：这是无限的 {skill:171} 露营物品，需要 1 个 {item:2447} 和 1 个 {item:3371}，在营地的营火旁放置可获得增益。起始地区的露营向导在“广阔天地”之后提供露营 101: {skill:171} 任务，让你去找炼金术训练师免费学习。75-150 阶段的配方约花费 1 银币，商人物资约 9 银 8 铜，另外还要采集或购买 77 个 {item:785}、152 个 {item:2450} 和 54 个 {item:2453}。",

	-- Step 19: Alchemy 75-150: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 75-150: vendor goods"] = "{skill:171} 75–150：商人材料",
	-- {item:3371} Empty Vial · {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 77 {item:3371} (3s 8c) and 15 {item:3372} (6s); about 9s 8c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "一次买齐整个技能阶段所需的份量：77 个 {item:3371}（3 银 8 铜）和 15 个 {item:3372}（6 银）；合计约 9 银 8 铜。箭头会选择离你最近的本阵营商人（{zone:1453}：{npc:1286}、艾达伊斯 和 {npc:1325}；{zone:1454}：{npc:3367}、{npc:3348} 和 {npc:3334}）。",

	-- Step 20: Mageroyal (Westfall)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1436} Westfall
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1436} is marked."] = "为 {spell:2331} 和 {spell:3171} 准备77份 {item:785}：{skill:182}：采集 {item:785}（技能50）；或从拍卖行购买。已标记 {zone:1436} 中 {item:785} 最密集的区域。",

	-- Step 21: Mageroyal (Loch Modan)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1432} Loch Modan
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1432} is marked."] = "为 {spell:2331} 和 {spell:3171} 准备77份 {item:785}：{skill:182}：采集 {item:785}（技能50）；或从拍卖行购买。已标记 {zone:1432} 中 {item:785} 最密集的区域。",

	-- Step 22: Mageroyal (Teldrassil)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1438} Teldrassil
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1438} is marked."] = "为 {spell:2331} 和 {spell:3171} 准备77份 {item:785}：{skill:182}：采集 {item:785}（技能50）；或从拍卖行购买。已标记 {zone:1438} 中 {item:785} 最密集的区域。",

	-- Step 23: Mageroyal (Zephras Isle)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:2521} Zephras Isle
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:2521} is marked."] = "为 {spell:2331} 和 {spell:3171} 准备77份 {item:785}：{skill:182}：采集 {item:785}（技能50）；或从拍卖行购买。已标记 {zone:2521} 中 {item:785} 最密集的区域。",

	-- Step 24: Mageroyal (The Barrens)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1413} The Barrens
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1413} is marked."] = "为 {spell:2331} 和 {spell:3171} 准备77份 {item:785}：{skill:182}：采集 {item:785}（技能50）；或从拍卖行购买。已标记 {zone:1413} 中 {item:785} 最密集的区域。",

	-- Step 25: Mageroyal (Silverpine Forest)
	-- {item:785} Mageroyal · {spell:2331} Minor Mana Potion · {spell:3171} Elixir of Wisdom · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["77 {item:785} for {spell:2331} and {spell:3171}: {skill:182}: {item:785} (skill 50); or the Auction House. The densest patch of {item:785} in {zone:1421} is marked."] = "为 {spell:2331} 和 {spell:3171} 准备77份 {item:785}：{skill:182}：采集 {item:785}（技能50）；或从拍卖行购买。已标记 {zone:1421} 中 {item:785} 最密集的区域。",

	-- Step 26: Briarthorn (Westfall)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1436} is marked."] = "为{spell:3171}和{spell:3176}准备152个{item:2450}（其中24个用于150-225阶段：现在一次采齐）：通过{skill:182}采集{item:2450}（需要技能70），或在拍卖行购买。已标记{zone:1436}中{item:2450}最密集的区域。",

	-- Step 27: Briarthorn (Loch Modan)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1432} is marked."] = "为{spell:3171}和{spell:3176}准备152个{item:2450}（其中24个用于150-225阶段：现在一次采齐）：通过{skill:182}采集{item:2450}（需要技能70），或在拍卖行购买。已标记{zone:1432}中{item:2450}最密集的区域。",

	-- Step 28: Briarthorn (Darkshore)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1439} is marked."] = "为{spell:3171}和{spell:3176}准备152个{item:2450}（其中24个用于150-225阶段：现在一次采齐）：通过{skill:182}采集{item:2450}（需要技能70），或在拍卖行购买。已标记{zone:1439}中{item:2450}最密集的区域。",

	-- Step 29: Briarthorn (The Barrens)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1413} is marked."] = "为{spell:3171}和{spell:3176}准备152个{item:2450}（其中24个用于150-225阶段：现在一次采齐）：通过{skill:182}采集{item:2450}（需要技能70），或在拍卖行购买。已标记{zone:1413}中{item:2450}最密集的区域。",

	-- Step 30: Briarthorn (Silverpine Forest)
	-- {item:2450} Briarthorn · {spell:3171} Elixir of Wisdom · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["152 {item:2450} for {spell:3171} and {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2450} (skill 70); or the Auction House. The densest patch of {item:2450} in {zone:1421} is marked."] = "为{spell:3171}和{spell:3176}准备152个{item:2450}（其中24个用于150-225阶段：现在一次采齐）：通过{skill:182}采集{item:2450}（需要技能70），或在拍卖行购买。已标记{zone:1421}中{item:2450}最密集的区域。",

	-- Step 31: Bruiseweed (Westfall)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1436} Westfall
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1436} is marked."] = "为 {spell:3176} 准备54株 {item:2453}（其中24株用于150—225阶段：现在就全部采好）：{skill:182}：采集 {item:2453}（技能100）；也可在拍卖行购买。已标出 {zone:1436} 中 {item:2453} 最密集的区域。",

	-- Step 32: Bruiseweed (Loch Modan)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1432} Loch Modan
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1432} is marked."] = "为 {spell:3176} 准备54株 {item:2453}（其中24株用于150—225阶段：现在就全部采好）：{skill:182}：采集 {item:2453}（技能100）；也可在拍卖行购买。已标出 {zone:1432} 中 {item:2453} 最密集的区域。",

	-- Step 33: Bruiseweed (Darkshore)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1439} Darkshore
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1439} is marked."] = "为 {spell:3176} 准备54株 {item:2453}（其中24株用于150—225阶段：现在就全部采好）：{skill:182}：采集 {item:2453}（技能100）；也可在拍卖行购买。已标出 {zone:1439} 中 {item:2453} 最密集的区域。",

	-- Step 34: Bruiseweed (The Barrens)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1413} The Barrens
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1413} is marked."] = "为 {spell:3176} 准备54株 {item:2453}（其中24株用于150—225阶段：现在就全部采好）：{skill:182}：采集 {item:2453}（技能100）；也可在拍卖行购买。已标出 {zone:1413} 中 {item:2453} 最密集的区域。",

	-- Step 35: Bruiseweed (Silverpine Forest)
	-- {item:2453} Bruiseweed · {spell:3176} Lesser Troll's Blood Elixir · {skill:182} Herbalism · {zone:1421} Silverpine Forest
	["54 {item:2453} for {spell:3176} (24 of them for 150-225: pick them all now): {skill:182}: {item:2453} (skill 100); or the Auction House. The densest patch of {item:2453} in {zone:1421} is marked."] = "为 {spell:3176} 准备54株 {item:2453}（其中24株用于150—225阶段：现在就全部采好）：{skill:182}：采集 {item:2453}（技能100）；也可在拍卖行购买。已标出 {zone:1421} 中 {item:2453} 最密集的区域。",

	-- Step 36: Minor Mana Potion to 90
	-- {spell:2331} Minor Mana Potion
	["{spell:2331} to 90"] = "制作{spell:2331}，提升至 90",
	-- {spell:2331} Minor Mana Potion · {item:785} Mageroyal · {item:2447} Peacebloom · {item:3371} Empty Vial · {spell:3171} Elixir of Wisdom
	["{spell:2331} is yellow at 75 (yellow 65, green 85, grey 105): about 28 crafts to 90. Each takes 1 {item:785}, 1 {item:2447} and 1 {item:3371}. The trainer teaches it from 25. It is yellow already, so count on about two crafts a point until {spell:3171} takes over at 90. {item:785} grows in the 10-25 zones."] = "{spell:2331} 在技能 75 时为黄色（65 变黄、85 变绿、105 变灰）：约制作 28 次可升到 90。每次需要 1 个 {item:785}、1 个 {item:2447} 和 1 个 {item:3371}。训练师在技能 25 起即可教授。配方已经是黄色，因此预计每升一点需要制作约两次，直到 90 时改用 {spell:3171}。{item:785} 生长在 10-25 级地区。",

	-- Step 37: Alchemy recipes at 90
	-- {skill:171} Alchemy
	["{skill:171} recipes at 90"] = "{skill:171}：技能 90 时学习的配方",
	-- {skill:171} Alchemy · {spell:3171} Elixir of Wisdom
	["Back to an {skill:171} trainer: {spell:3171} (from 90)."] = "返回{skill:171}训练师处，学习{spell:3171}（技能 90 起可学）。",

	-- Step 38: Elixir of Wisdom to 135
	-- {spell:3171} Elixir of Wisdom
	["{spell:3171} to 135"] = "制作{spell:3171}，提升至 135",
	-- {spell:3171} Elixir of Wisdom · {item:785} Mageroyal · {item:2450} Briarthorn · {item:3371} Empty Vial
	["{spell:3171} is orange at 90 (yellow 120, green 140, grey 160): about 49 crafts to 135. Each takes 1 {item:785}, 2 {item:2450} and 1 {item:3371}. Two {item:2450} and a {item:785} a craft, both from the 10-25 zones; orange to 120."] = "{spell:3171} 在技能90时为橙色（120变黄，140变绿，160变灰）：大约制作49次升到135。每次需要1份 {item:785}、2份 {item:2450} 和1个 {item:3371}。每次使用的两份 {item:2450} 和一份 {item:785} 都产自10—25级地区；到120前保持橙色。",

	-- Step 39: Alchemy recipes at 135
	-- {skill:171} Alchemy
	["{skill:171} recipes at 135"] = "{skill:171}：技能 135 时学习的配方",
	-- {skill:171} Alchemy · {spell:3176} Lesser Troll's Blood Elixir
	["Back to an {skill:171} trainer: {spell:3176} (from 125)."] = "返回{skill:171}训练师处，学习{spell:3176}（技能 125 起可学）。",

	-- Step 40: Lesser Troll's Blood Elixir to 150
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 150"] = "{spell:3176}练到150",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial · {skill:171} Alchemy
	["{spell:3176} is orange at 135 (yellow 150, green 170, grey 190): about 15 crafts to 150, a point every craft. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones. {skill:171} 150 is a Legacy System milestone."] = "{spell:3176} 在135点时为橙色（150变黄，170变绿，190变灰）：制作约15次可到150，每次必升一点。每次需要2株 {item:2453}、2株 {item:2450} 和1个 {item:3372}。每次制作消耗两株 {item:2453} 和两株 {item:2450}；{item:2453} 生长在15—30级地区。{skill:171} 达到150是传承系统的一个里程碑。",

	-- Step 41: Alchemy 150-225: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 150-225: vendor goods"] = "{skill:171} 150–225：商人材料",
	-- {item:3372} Leaded Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 83 {item:3372} (33s 20c); about 33s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "一次买齐本阶段所需：83个{item:3372}（33银20铜）；总计约33银20铜。箭头指向本阵营最近的出售者（{zone:1453}：{npc:1286}、艾达伊斯和{npc:1325}；{zone:1454}：{npc:3367}、{npc:3348}和{npc:3334}）。",

	-- Step 42: Wild Steelbloom (Alliance)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Alliance)"] = "{object:1623}（联盟）",
	-- {object:1623} Wild Steelbloom · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest patch of {object:1623} in {zone:1434} is marked."] = "为 {item:8951} 准备 40 个 {object:1623}（其中 8 个用于 225-300 阶段：现在一并采齐）：通过 {skill:182} 在 {zone:1442}（15-27 级）、{zone:1417}（30-40 级）和 {zone:1434}（30-45 级）采集 {object:1623}（技能 115），或从拍卖行购买。已标记 {zone:1434} 中 {object:1623} 最密集的区域。",

	-- Step 43: Wild Steelbloom (Horde)
	-- {object:1623} Wild Steelbloom
	["{object:1623} (Horde)"] = "{object:1623}（部落）",
	-- {object:1623} Wild Steelbloom · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1442} Stonetalon Mountains · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["40 {object:1623} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:1623} (skill 115) in {zone:1442} (15-27), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest patch of {object:1623} in {zone:1442} is marked."] = "为 {item:8951} 准备 40 个 {object:1623}（其中 8 个用于 225-300 阶段：现在一并采齐）：通过 {skill:182} 在 {zone:1442}（15-27 级）、{zone:1417}（30-40 级）和 {zone:1434}（30-45 级）采集 {object:1623}（技能 115），或从拍卖行购买。已标记 {zone:1442} 中 {object:1623} 最密集的区域。",

	-- Step 44: Kingsblood (Alliance)
	-- {item:3356} Kingsblood
	["{item:3356} (Alliance)"] = "{item:3356}（联盟）",
	-- {item:3356} Kingsblood · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1440} Ashenvale · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale
	["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1440} (18-30), {zone:1437} (20-30) and {zone:1434} (30-45); or the Auction House. The densest patch of {item:3356} in {zone:1434} is marked."] = "为 {spell:3452} 准备 39 个 {item:3356}：通过 {skill:182} 采集 {zone:1440}（18-30 级）、{zone:1437}（20-30 级）和 {zone:1434}（30-45 级）的 {item:3356}（需要技能 125），或在拍卖行购买。已标记 {zone:1434} 中 {item:3356} 最密集的区域。",

	-- Step 45: Kingsblood (Horde)
	-- {item:3356} Kingsblood
	["{item:3356} (Horde)"] = "{item:3356}（部落）",
	-- {item:3356} Kingsblood · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1434} Stranglethorn Vale
	["39 {item:3356} for {spell:3452}: {skill:182}: {item:3356} (skill 125) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1434} (30-45); or the Auction House. The densest patch of {item:3356} in {zone:1413} is marked."] = "准备 39 个 {item:3356}，用于 {spell:3452}：通过 {skill:182} 采集 {item:3356}（技能 125），产地有 {zone:1413}（10-25 级）、{zone:1440}（18-30 级）和 {zone:1434}（30-45 级）；或在拍卖行购买。已标记 {zone:1413} 中 {item:3356} 最密集的区域。",

	-- Step 46: Stranglekelp (Alliance)
	-- {object:2045} Stranglekelp
	["{object:2045} (Alliance)"] = "{object:2045}（联盟）",
	-- {object:2045} Stranglekelp · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1437} Wetlands · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1437} (20-30), {zone:1434} (30-45) and {zone:1425} (40-50); or the Auction House. The densest patch of {object:2045} in {zone:1434} is marked."] = "准备 39 个 {object:2045}，用于 {spell:3452}：通过 {skill:182} 采集 {object:2045}（技能 85），产地有 {zone:1437}（20-30 级）、{zone:1434}（30-45 级）和 {zone:1425}（40-50 级）；或在拍卖行购买。已标记 {zone:1434} 中 {object:2045} 最密集的区域。",

	-- Step 47: Stranglekelp (Horde)
	-- {object:2045} Stranglekelp
	["{object:2045} (Horde)"] = "{object:2045}（部落）",
	-- {object:2045} Stranglekelp · {spell:3452} Mana Potion · {skill:182} Herbalism · {zone:1413} The Barrens · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands
	["39 {object:2045} for {spell:3452}: {skill:182}: {object:2045} (skill 85) in {zone:1413} (10-25), {zone:1434} (30-45) and {zone:1425} (40-50); or the Auction House. The densest patch of {object:2045} in {zone:1413} is marked."] = "为 {spell:3452} 准备39株 {object:2045}：{skill:182}：在 {zone:1413}（10—25级）、{zone:1434}（30—45级）和 {zone:1425}（40—50级）采集 {object:2045}（技能85）；也可在拍卖行购买。已标出 {zone:1413} 中 {object:2045} 最密集的区域。",

	-- Step 48: Goldthorn (Alliance)
	-- {object:2046} Goldthorn
	["{object:2046} (Alliance)"] = "{object:2046}（联盟）",
	-- {object:2046} Goldthorn · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest patch of {object:2046} in {zone:1417} is marked."] = "为 {item:8951} 准备 40 个 {object:2046}（其中 8 个用于 225-300 阶段：现在一并采齐）：通过 {skill:182} 在 {zone:1417}（30-40 级）、{zone:1425}（40-50 级）和 {zone:1444}（40-50 级）采集 {object:2046}（技能 170），或从拍卖行购买。已标记 {zone:1417} 中 {object:2046} 最密集的区域。",

	-- Step 49: Goldthorn (Horde)
	-- {object:2046} Goldthorn
	["{object:2046} (Horde)"] = "{object:2046}（部落）",
	-- {object:2046} Goldthorn · {item:8951} Elixir of Defense · {skill:182} Herbalism · {zone:1417} Arathi Highlands · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["40 {object:2046} for {item:8951} (8 of them for 225-300: pick them all now): {skill:182}: {object:2046} (skill 170) in {zone:1417} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest patch of {object:2046} in {zone:1444} is marked."] = "为 {item:8951} 准备 40 个 {object:2046}（其中 8 个用于 225-300 阶段：现在一并采齐）：通过 {skill:182} 在 {zone:1417}（30-40 级）、{zone:1425}（40-50 级）和 {zone:1444}（40-50 级）采集 {object:2046}（技能 170），或从拍卖行购买。已标记 {zone:1444} 中 {object:2046} 最密集的区域。",

	-- Step 50: Expert Alchemy
	-- {skill:171} Alchemy
	["Expert {skill:171}"] = "高级{skill:171}",
	-- {skill:171} Alchemy · {npc:4160} Ainethil · {zone:1457} Darnassus · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:4611} Doctor Herbert Halsey · {zone:1458} Undercity · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {object:1623} Wild Steelbloom · {item:3356} Kingsblood · {object:2045} Stranglekelp · {object:2046} Goldthorn · {spell:3452} Mana Potion · {item:8951} Elixir of Defense
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:4160} ({zone:1457}) and {npc:7948} ({zone:1444}); Horde {npc:4611} ({zone:1458}) and {npc:1386} ({zone:1435}). The arrow picks the nearest of your faction. 150-225 takes about 33s 20c of vendor goods, plus 40 {object:1623}, 39 {item:3356}, 39 {object:2045} and 40 {object:2046} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:3452} (from 160) and {item:8951} (from 195), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "高级将技能上限从 150 提高到 225，费用为 50 银币（经典旧世价格；数据中没有无限服的价格）；需要 {skill:171} 125 和角色等级 20，因此达到 125 后，任意一次来访都可学习。只有少数训练师教授：联盟为 {npc:4160}（{zone:1457}）和 {npc:7948}（{zone:1444}）；部落为 {npc:4611}（{zone:1458}）和 {npc:1386}（{zone:1435}）。箭头会指向你所属阵营最近的一位。150-225 阶段约需 33 银币 20 铜币的商人材料，另需采集或购买 40 个 {object:1623}、39 个 {item:3356}、39 个 {object:2045} 和 40 个 {object:2046}。来之前把材料全部备齐放进背包（按上方步骤收集，其余从拍卖行购买）：这些训练师还教授 {spell:3452}（技能 160 起）和 {item:8951}（技能 195 起），且制作无需工作台，可直接在此制作，达到相应技能点就学习配方。这样只需跑一趟，无需跑 3 趟。",

	-- Step 51: Lesser Troll's Blood Elixir to 160
	-- {spell:3176} Lesser Troll's Blood Elixir
	["{spell:3176} to 160"] = "制作{spell:3176}，提升至 160",
	-- {spell:3176} Lesser Troll's Blood Elixir · {item:2453} Bruiseweed · {item:2450} Briarthorn · {item:3372} Leaded Vial
	["{spell:3176} is yellow at 150 (yellow 150, green 170, grey 190): about 12 crafts to 160. Each takes 2 {item:2453}, 2 {item:2450} and 1 {item:3372}. Two {item:2453} and two {item:2450} a craft; {item:2453} grows in the 15-30 zones."] = "{spell:3176} 在技能150时为黄色（150变黄，170变绿，190变灰）：大约制作12次升到160。每次需要2份 {item:2453}、2份 {item:2450} 和1个 {item:3372}。每次需两份 {item:2453} 和两份 {item:2450}；{item:2453} 生长在15—30级地区。",

	-- Step 52: Alchemy recipes at 160
	-- {skill:171} Alchemy
	["{skill:171} recipes at 160"] = "{skill:171}：技能 160 时学习的配方",
	-- {spell:3452} Mana Potion
	["Still at the Expert trainer: {spell:3452} (from 160)."] = "继续在高级训练师处学习{spell:3452}（技能 160 起可学）。",

	-- Step 53: Mana Potion to 195
	-- {spell:3452} Mana Potion
	["{spell:3452} to 195"] = "制作{spell:3452}，提升至 195",
	-- {spell:3452} Mana Potion · {item:3820} Stranglekelp · {item:3356} Kingsblood · {item:3372} Leaded Vial
	["{spell:3452} is orange at 160 (yellow 180, green 200, grey 220): about 39 crafts to 195. Each takes 1 {item:3820}, 1 {item:3356} and 1 {item:3372}. {item:3820} grows under water along the coasts: bring a water breathing elixir or come up for air. {item:3356} grows in the 20-40 zones."] = "{spell:3452} 在技能160时为橙色（180变黄，200变绿，220变灰）：大约制作39次升到195。每次需要1份 {item:3820}、1份 {item:3356} 和1个 {item:3372}。{item:3820} 生长在沿海水下：带上水下呼吸药剂，或及时浮出水面换气。{item:3356} 生长在20—40级地区。",

	-- Step 54: Alchemy recipes at 195
	-- {skill:171} Alchemy
	["{skill:171} recipes at 195"] = "{skill:171}：技能 195 时学习的配方",
	-- {spell:11450} Elixir of Defense
	["Still at the Expert trainer: {spell:11450} (from 195)."] = "继续在高级训练师处学习{spell:11450}（技能 195 起可学）。",

	-- Step 55: Elixir of Defense to 225
	-- {item:8951} Elixir of Defense
	["{item:8951} to 225"] = "{item:8951}练到225",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands · {skill:171} Alchemy
	["{item:8951} is orange at 195 (yellow 215, green 235, grey 255): about 32 crafts to 225. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418}). {skill:171} 225 is a Legacy System milestone."] = "{item:8951} 在技能 195 时为橙色（215 变黄，235 变绿，255 变灰）：约制作 32 次可到 225。每次需要 1 个 {item:3355}、1 个 {item:3821} 和 1 个 {item:3372}。{item:3355} 和 {item:3821} 产于 30-45 级区域（荆棘谷、阿拉希和 {zone:1418}）。{skill:171} 225 是传承系统的一个里程碑。",

	-- Step 56: Alchemy 225-300: vendor goods
	-- {skill:171} Alchemy
	["{skill:171} 225-300: vendor goods"] = "{skill:171} 225–300：商人材料",
	-- {item:3372} Leaded Vial · {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 51 {item:3372} (20s 40c) and 86 {item:8925} (4g 30s); about 4g 50s 40c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "一次买齐整个阶段的用量：51个{item:3372}（20银40铜）和86个{item:8925}（4金30银）；合计约4金50银40铜。箭头会选择本阵营最近的商人（{zone:1453}：{npc:1286}、艾达伊斯和{npc:1325}；{zone:1454}：{npc:3367}、{npc:3348}和{npc:3334}）。",

	-- Step 57: Recipe: Elixir of Superior Defense
	-- {item:13478} Recipe: Elixir of Superior Defense · {item:13445} Elixir of Greater Defense · {skill:171} Alchemy · {npc:5178} Soolie Berryfizz · {zone:1455} Ironforge · {npc:3348} Kor'geld · {zone:1454} Orgrimmar
	["{item:13478} teaches {item:13445} ({skill:171} 265) for 1g 30s. Sold by Alliance: {npc:5178} ({zone:1455}), limited stock; Horde: {npc:3348} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "{item:13478} 可学会 {item:13445}（需要 {skill:171} 265），售价 1 金币 30 银币。联盟由 {npc:5178}（{zone:1455}）限量出售；部落由 {npc:3348}（{zone:1454}）限量出售。商人通常备货一两份，售出一段时间后补货；拍卖行也常有出售。",

	-- Step 58: Arthas' Tears (Alliance)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Alliance)"] = "{item:8836}（联盟）",
	-- {item:8836} Arthas' Tears · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60); or the Auction House. The densest patch of {item:8836} in {zone:1422} is marked."] = "为 {item:9154} 准备 43 个 {item:8836}：通过 {skill:182} 在 {zone:1448}（48-55 级）、{zone:1422}（51-58 级）和 {zone:1423}（53-60 级）采集 {item:8836}（技能 220），或从拍卖行购买。已标记 {zone:1422} 中 {item:8836} 最密集的区域。",

	-- Step 59: Arthas' Tears (Horde)
	-- {item:8836} Arthas' Tears
	["{item:8836} (Horde)"] = "{item:8836}（部落）",
	-- {item:8836} Arthas' Tears · {item:9154} Draught of Detect Undead · {skill:182} Herbalism · {zone:1448} Felwood · {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands
	["43 {item:8836} for {item:9154}: {skill:182}: {item:8836} (skill 220) in {zone:1448} (48-55), {zone:1422} (51-58) and {zone:1423} (53-60); or the Auction House. The densest patch of {item:8836} in {zone:1448} is marked."] = "为 {item:9154} 准备 43 个 {item:8836}：通过 {skill:182} 在 {zone:1448}（48-55 级）、{zone:1422}（51-58 级）和 {zone:1423}（53-60 级）采集 {item:8836}（技能 220），或从拍卖行购买。已标记 {zone:1448} 中 {item:8836} 最密集的区域。",

	-- Step 60: Sungrass (Alliance)
	-- {item:8838} Sungrass
	["{item:8838} (Alliance)"] = "{item:8838}（联盟）",
	-- {item:8838} Sungrass · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8838} in {zone:1425} is marked."] = "为 {item:13445} 准备 43 个 {item:8838}：通过 {skill:182} 在 {zone:1425}（40-50 级）、{zone:1444}（40-50 级）和 {zone:1447}（45-55 级）采集 {item:8838}（技能 230），或从拍卖行购买。已标记 {zone:1425} 中 {item:8838} 最密集的区域。",

	-- Step 61: Sungrass (Horde)
	-- {item:8838} Sungrass
	["{item:8838} (Horde)"] = "{item:8838}（部落）",
	-- {item:8838} Sungrass · {item:13445} Elixir of Greater Defense · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["43 {item:8838} for {item:13445}: {skill:182}: {item:8838} (skill 230) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest patch of {item:8838} in {zone:1444} is marked."] = "为 {item:13445} 准备 43 个 {item:8838}：通过 {skill:182} 在 {zone:1425}（40-50 级）、{zone:1444}（40-50 级）和 {zone:1447}（45-55 级）采集 {item:8838}（技能 230），或从拍卖行购买。已标记 {zone:1444} 中 {item:8838} 最密集的区域。",

	-- Step 62: Stonescale Eel (Alliance)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Alliance)"] = "{item:13422}（联盟）",
	-- {item:13422} Stonescale Eel · {item:13445} Elixir of Greater Defense · {skill:356} Fishing · {object:180712} Stonescale Eel Swarm
	["43 {item:13422} for {item:13445}: {skill:356}; or the Auction House. Fish {object:180712} here."] = "为 {item:13445} 准备 43 个 {item:13422}：通过 {skill:356} 获取，或从拍卖行购买。在此处的 {object:180712} 中垂钓。",

	-- Step 63: Stonescale Eel (Horde)
	-- {item:13422} Stonescale Eel
	["{item:13422} (Horde)"] = "{item:13422}（部落）",

	-- Step 64: Artisan Alchemy
	-- {skill:171} Alchemy
	["Artisan {skill:171}"] = "专家级{skill:171}",
	-- {skill:171} Alchemy · {npc:7948} Kylanna Windwhisper · {zone:1444} Feralas · {npc:1386} Rogvar · {zone:1435} Swamp of Sorrows · {item:8836} Arthas' Tears · {item:8838} Sungrass · {item:13422} Stonescale Eel · {item:9154} Draught of Detect Undead · {item:13423} Stonescale Oil
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:171} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:7948} ({zone:1444}); Horde {npc:1386} ({zone:1435}). The arrow picks the nearest of your faction. 225-300 takes about 1g 30s of recipes and 4g 50s 40c of vendor goods, plus 43 {item:8836}, 43 {item:8838} and 43 {item:13422} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9154} (from 230) and {item:13423} (from 250), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "大师级将技能上限从 225 提高到 300，费用为 4 金币 50 银币（经典旧世价格；数据中没有无限服的价格）；需要 {skill:171} 200 和角色等级 35，因此达到 200 后，任意一次来访都可学习。只有少数训练师教授：联盟为 {npc:7948}（{zone:1444}）；部落为 {npc:1386}（{zone:1435}）。箭头会指向你所属阵营最近的一位。225-300 阶段约需 1 金币 30 银币的配方和 4 金币 50 银币 40 铜币的商人材料，另需采集或购买 43 个 {item:8836}、43 个 {item:8838} 和 43 个 {item:13422}。来之前把材料全部备齐放进背包（按上方步骤收集，其余从拍卖行购买）：这些训练师还教授 {item:9154}（技能 230 起）和 {item:13423}（技能 250 起），且制作无需工作台，可直接在此制作，达到相应技能点就学习配方。这样只需跑一趟，无需跑 3 趟。",

	-- Step 65: Elixir of Defense to 230
	-- {item:8951} Elixir of Defense
	["{item:8951} to 230"] = "{item:8951}练到230",
	-- {item:8951} Elixir of Defense · {item:3355} Wild Steelbloom · {item:3821} Goldthorn · {item:3372} Leaded Vial · {zone:1418} Badlands
	["{item:8951} is yellow at 225 (yellow 215, green 235, grey 255): about 8 crafts to 230. Each takes 1 {item:3355}, 1 {item:3821} and 1 {item:3372}. {item:3355} and {item:3821} are the herbs of the 30-45 zones (Stranglethorn, Arathi, the {zone:1418})."] = "{item:8951} 在技能 225 时为黄色（215 变黄，235 变绿，255 变灰）：约制作 8 次可到 230。每次需要 1 个 {item:3355}、1 个 {item:3821} 和 1 个 {item:3372}。{item:3355} 和 {item:3821} 产于 30-45 级区域（荆棘谷、阿拉希和 {zone:1418}）。",

	-- Step 66: Alchemy recipes at 230
	-- {skill:171} Alchemy
	["{skill:171} recipes at 230"] = "230点的{skill:171}配方",
	-- {spell:11460} Draught of Detect Undead
	["Still at the Artisan trainer: {spell:11460} (from 230)."] = "仍在大师级训练师这里：学习 {spell:11460}（技能 230 起）。",

	-- Step 67: Draught of Detect Undead to 265
	-- {item:9154} Draught of Detect Undead
	["{item:9154} to 265"] = "{item:9154}练到265",
	-- {item:9154} Draught of Detect Undead · {item:8836} Arthas' Tears · {item:8925} Crystal Vial · {zone:1448} Felwood · {skill:182} Herbalism
	-- plural, as words: Crystal Vials = {item:8925} Crystal Vial
	["{item:9154} is orange at 230 (yellow 245, green 265, grey 285): about 43 crafts to 265. Each takes 1 {item:8836} and 1 {item:8925}. {item:8836} grow in the Plaguelands and {zone:1448} ({skill:182} 220); Crystal Vials come from alchemy vendors."] = "{item:9154} 在技能 230 时为橙色（245 变黄，265 变绿，285 变灰）：约制作 43 次可到 265。每次需要 1 个 {item:8836} 和 1 个 {item:8925}。{item:8836} 生长在瘟疫之地和 {zone:1448}（需要 {skill:182} 220）；水晶瓶由炼金材料商出售。",

	-- Step 68: Alchemy recipes at 265
	-- {skill:171} Alchemy
	["{skill:171} recipes at 265"] = "{skill:171}：技能 265 时学习的配方",
	-- {spell:17551} Stonescale Oil
	["Still at the Artisan trainer: {spell:17551} (from 250)."] = "仍在大师级训练师处：学习{spell:17551}（需要技能250）。",

	-- Step 69: Elixir of Greater Defense to 300
	-- {item:13445} Elixir of Greater Defense
	["{item:13445} to 300"] = "{item:13445}练到300",
	-- {item:13445} Elixir of Greater Defense · {item:13423} Stonescale Oil · {item:8838} Sungrass · {item:8925} Crystal Vial · {item:13422} Stonescale Eel · {skill:171} Alchemy
	["{item:13445} is orange at 265 (yellow 280, green 300, grey 320): about 43 crafts to 300. Each takes 2 {item:13423}, 1 {item:8838} and 1 {item:8925}. Make the 86 {item:13423} (43 crafts) first. {item:13422} comes from the {item:13422} schools on the coasts of the 40-55 zones, or the Auction House (fishers sell them in stacks). {item:8838} grows in the 40-55 zones. {skill:171} 300 is a Legacy System milestone."] = "{item:13445} 在技能 265 时为橙色（280 变黄，300 变绿，320 变灰）：约制作 43 次可到 300。每次需要 2 个 {item:13423}、1 个 {item:8838} 和 1 个 {item:8925}。先制作 86 个 {item:13423}（制作 43 次）。{item:13422} 可从 40-55 级区域沿海的 {item:13422} 鱼群中钓到，也可从拍卖行购买（钓鱼玩家会整组出售）。{item:8838} 生长在 40-55 级区域。{skill:171} 300 是传承系统的一个里程碑。",
	["from the recipe in your bags"] = "使用背包中的配方",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:171}"] = "初级{skill:171}",
	-- ["Artisan needs character level 35 and {skill:171} 200; it raises the cap to 300. Materials for 225-300 are worth about 7g 80s in all."] = "专家级需要角色等级35级且{skill:171}达到200；上限提高到300。225-300所需材料总价约7金80银。",
	-- ["Back to an {skill:171} trainer: {spell:11447} is taught from {skill:171} 190."] = "回到{skill:171}训练师处：{skill:171}达到190即可学习{spell:11447}。",
	-- ["Back to an {skill:171} trainer: {spell:11450} is taught from {skill:171} 215."] = "回到{skill:171}训练师处：{skill:171}达到215即可学习{spell:11450}。",
	-- ["Back to an {skill:171} trainer: {spell:11460} is taught from {skill:171} 245."] = "回到{skill:171}训练师处：{skill:171}达到245即可学习{spell:11460}。",
	-- ["Back to an {skill:171} trainer: {spell:1244645} is taught from {skill:171} 85."] = "回到{skill:171}训练师处：{skill:171}达到85即可学习{spell:1244645}。",
	-- ["Back to an {skill:171} trainer: {spell:1244647} is taught from {skill:171} 175."] = "回到{skill:171}训练师处：{skill:171}达到175即可学习{spell:1244647}。",
	-- ["Back to an {skill:171} trainer: {spell:1244648} is taught from {skill:171} 230."] = "回到{skill:171}训练师处：{skill:171}达到230即可学习{spell:1244648}。",
	-- ["Back to an {skill:171} trainer: {spell:17551} is taught from {skill:171} 250."] = "回到{skill:171}训练师处：{skill:171}达到250即可学习{spell:17551}。",
	-- ["Back to an {skill:171} trainer: {spell:7845} is taught from {skill:171} 165."] = "回到{skill:171}训练师处：{skill:171}达到165即可学习{spell:7845}。",
	-- ["Expert needs character level 20 and {skill:171} 125; it raises the cap to 225. Materials for 150-225 are worth about 3g 65s in all."] = "高级需要角色等级20级且{skill:171}达到125；上限提高到225。150-225所需材料总价约3金65银。",
	-- ["Fish {object:180582}; this is where the data has most of them. The Auction House works too."] = "在{object:180582}钓鱼；数据显示这里最多。也可以去拍卖行购买。",
	-- ["Fish {object:180657}; this is where the data has most of them. The Auction House works too."] = "在{object:180657}钓鱼；数据显示这里最多。也可以去拍卖行购买。",
	-- ["Fish {object:180712}; this is where the data has most of them. The Auction House works too."] = "在{object:180712}钓鱼；数据显示这里最多。也可以去拍卖行购买。",
	-- ["Journeyman needs character level 10 and {skill:171} 50; it raises the cap to 150. Materials for 75-150 are worth about 1g 44s in all."] = "中级需要角色等级10级且{skill:171}达到50；上限提高到150。75-150所需材料总价约1金44银。",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在Polestar根据你的等级和阵营选择的刷怪点击杀掉落它的怪物。也可以去拍卖行购买。",
	-- ["Orange (a point every craft) until 130, yellow until 150, green until 170. {skill:171} 150 is a Legacy System milestone."] = "130之前为橙色（每次制作得1点），150之前为黄色，170之前为绿色。{skill:171}150是传承系统的里程碑。",
	-- ["Orange (a point every craft) until 280, yellow until 300, green until 320. {skill:171} 300 is a Legacy System milestone."] = "280之前为橙色（每次制作得1点），300之前为黄色，320之前为绿色。{skill:171}300是传承系统的里程碑。",
	-- ["Orange (a point every craft) until 55, yellow until 75, green until 95. 75 is the Apprentice cap."] = "55之前为橙色（每次制作得1点），75之前为黄色，95之前为绿色。75是初级上限。",
	-- ["Pick {item:2447} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:2447}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:2450} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:2450}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:2453} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:2453}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:3355} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:3355}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:3356} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:3356}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:3357} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:3357}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:3821} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:3821}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:765} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:765}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:785} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:785}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:8836} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:8836}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {item:8838} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{item:8838}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {object:1623} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{object:1623}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Pick {object:2046} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "用{skill:182}采集{object:2046}；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["Teaches {item:6051} (needs {skill:171} 100). Vendors sell it in limited stock that restocks."] = "教授{item:6051}（需要{skill:171}100）。商人限量出售，会定期补货。",
	-- ["Teaches {item:8951} (needs {skill:171} 265). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "教授{item:8951}（需要{skill:171}265）。商人限量出售，会定期补货；拍卖行也常有。",
	-- ["Yellow until 105, green until 125: not every craft gives a point."] = "105之前为黄色，125之前为绿色：并非每次制作都能获得技能点。",
	-- ["Yellow until 160, green until 170: not every craft gives a point."] = "160之前为黄色，170之前为绿色：并非每次制作都能获得技能点。",
	-- ["Yellow until 185, green until 205: not every craft gives a point."] = "185之前为黄色，205之前为绿色：并非每次制作都能获得技能点。",
	-- ["Yellow until 195, green until 215: not every craft gives a point."] = "195之前为黄色，215之前为绿色：并非每次制作都能获得技能点。",
	-- ["Yellow until 210, green until 230: not every craft gives a point."] = "210之前为黄色，230之前为绿色：并非每次制作都能获得技能点。",
	-- ["Yellow until 235, green until 255: not every craft gives a point."] = "235之前为黄色，255之前为绿色：并非每次制作都能获得技能点。",
	-- ["Yellow until 235, green until 255: not every craft gives a point. {skill:171} 225 is a Legacy System milestone."] = "235之前为黄色，255之前为绿色：并非每次制作都能获得技能点。{skill:171}225是传承系统的里程碑。",
	-- ["Yellow until 250, green until 270: not every craft gives a point."] = "250之前为黄色，270之前为绿色：并非每次制作都能获得技能点。",
	-- ["Yellow until 255, green until 260: not every craft gives a point."] = "255之前为黄色，260之前为绿色：并非每次制作都能获得技能点。",
	-- ["Yellow until 265, green until 285: not every craft gives a point."] = "265之前为黄色，285之前为绿色：并非每次制作都能获得技能点。",
	-- ["Yellow until 85, green until 105: not every craft gives a point."] = "85之前为黄色，105之前为绿色：并非每次制作都能获得技能点。",
	-- ["{item:13423} to 259"] = "{item:13423}练到259",
	-- ["{item:2447} (Alliance)"] = "{item:2447}（联盟）",
	-- ["{item:2447} (Horde)"] = "{item:2447}（部落）",
	-- ["{item:2450} (Alliance)"] = "{item:2450}（联盟）",
	-- ["{item:2450} (Horde)"] = "{item:2450}（部落）",
	-- ["{item:2452} (Alliance)"] = "{item:2452}（联盟）",
	-- ["{item:2452} (Horde)"] = "{item:2452}（部落）",
	-- ["{item:2452} comes from {item:2450} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:2452}来自{item:2450}采集点（{skill:182}）；这里是数据中分布最密集的地点。也可以去拍卖行购买。",
	-- ["{item:2453} (Alliance)"] = "{item:2453}（联盟）",
	-- ["{item:2453} (Horde)"] = "{item:2453}（部落）",
	-- ["{item:247239} to 100"] = "{item:247239}练到100",
	-- ["{item:247241} to 200"] = "{item:247241}练到200",
	-- ["{item:247242} to 250"] = "{item:247242}练到250",
	-- ["{item:3355} (Alliance)"] = "{item:3355}（联盟）",
	-- ["{item:3355} (Horde)"] = "{item:3355}（部落）",
	-- ["{item:3357} (Alliance)"] = "{item:3357}（联盟）",
	-- ["{item:3357} (Horde)"] = "{item:3357}（部落）",
	-- ["{item:3821} (Alliance)"] = "{item:3821}（联盟）",
	-- ["{item:3821} (Horde)"] = "{item:3821}（部落）",
	-- ["{item:6051} to 150"] = "{item:6051}练到150",
	-- ["{item:6358} (Alliance)"] = "{item:6358}（联盟）",
	-- ["{item:6358} (Horde)"] = "{item:6358}（部落）",
	-- ["{item:6359} (Alliance)"] = "{item:6359}（联盟）",
	-- ["{item:6359} (Horde)"] = "{item:6359}（部落）",
	-- ["{item:6371} to 165"] = "{item:6371}练到165",
	-- ["{item:730} (Alliance)"] = "{item:730}（联盟）",
	-- ["{item:730} (Horde)"] = "{item:730}（部落）",
	-- ["{item:765} (Alliance)"] = "{item:765}（联盟）",
	-- ["{item:765} (Horde)"] = "{item:765}（部落）",
	-- ["{item:785} (Alliance)"] = "{item:785}（联盟）",
	-- ["{item:785} (Horde)"] = "{item:785}（部落）",
	-- ["{npc:1958} (level 17-18) drop it here. The Auction House works too."] = "这里的{npc:1958}（17-18级）会掉落。也可以去拍卖行购买。",
	-- ["{npc:513} (level 14-15) drop it here. The Auction House works too."] = "这里的{npc:513}（14-15级）会掉落。也可以去拍卖行购买。",
	-- ["{skill:171} recipes at 165"] = "165点的{skill:171}配方",
	-- ["{skill:171} recipes at 175"] = "175点的{skill:171}配方",
	-- ["{skill:171} recipes at 200"] = "200点的{skill:171}配方",
	-- ["{skill:171} recipes at 215"] = "215点的{skill:171}配方",
	-- ["{skill:171} recipes at 250"] = "250点的{skill:171}配方",
	-- ["{skill:171} recipes at 259"] = "259点的{skill:171}配方",
	-- ["{skill:171} recipes at 85"] = "85点的{skill:171}配方",
	-- ["{skill:171} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 68s in all."] = "{skill:171}可以边升级边练。Forever的传承系统会在制造专业技能达到150、225和300（中级、高级和专家级上限）时给予奖励，所以每个节点都很重要。1-75所需材料总价约68银。",
	-- ["{spell:11447} to 215"] = "{spell:11447}练到215",
	-- ["{spell:2331} to 85"] = "{spell:2331}练到85",
	-- ["{spell:7845} to 175"] = "{spell:7845}练到175",
}
