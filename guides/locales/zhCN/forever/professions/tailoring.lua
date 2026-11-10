-- Chinese (simplified) (zhCN): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Tailoring
	-- {skill:197} Tailoring
	["Learn {skill:197}"] = "学习{skill:197}",
	-- {skill:197} Tailoring · {item:2589} Linen Cloth
	["Apprentice {skill:197} lets you craft up to 75 for 10c, at any character level. Any {skill:197} trainer of your faction teaches it; the arrow picks the nearest. Keep every {item:2589} you loot: humanoids of level 5-20 drop it. 1-75 takes about 50c of recipes and 7s 20c of vendor goods, plus 144 {item:2589} to gather or buy."] = "初级{skill:197}允许你将技能练至75，学习费用10铜，没有角色等级要求。本阵营的任意{skill:197}训练师都会教；箭头会选择最近的一位。留着拾取到的每块{item:2589}：5-20级人型生物会掉落。1-75约需50铜学习配方、7银20铜购买商人物品，另需收集或购买144个{item:2589}。",

	-- Step 2: Tailoring 1-75: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 1-75: vendor goods"] = "{skill:197} 1–75：商人材料",
	-- {item:2320} Coarse Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 72 {item:2320} (7s 20c); about 7s 20c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "一次买齐整个阶段的用量：72个{item:2320}（7银20铜）；合计约7银20铜。箭头会选择本阵营最近的商人（{zone:1453}：{npc:1347}、{npc:1286}和{npc:5565}；{zone:1454}：{npc:3364}、{npc:3367}和{npc:5817}）。",

	-- Step 3: Linen Cloth
	-- {item:2589} Linen Cloth · {spell:2387} Linen Cloak · {item:7026} Linen Belt
	["144 {item:2589} for {spell:2387} and {item:7026}: humanoids of level 5-20 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "为 {spell:2387} 和 {item:7026} 准备 144 个 {item:2589}：由 5-20 级人型生物掉落，或在拍卖行购买。箭头会按你的等级和阵营选择刷取地点。",

	-- Step 4: Linen Cloak to 15
	-- {spell:2387} Linen Cloak
	["{spell:2387} to 15"] = "制作{spell:2387}，提升至 15",
	-- {spell:2387} Linen Cloak · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{spell:2387} is orange at 1 (yellow 35, green 47, grey 60): about 7 crafts to 15, a point every craft. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 7 {spell:2963} first: it gives points too while not grey. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{spell:2387}在技能1时为橙色（35变黄，47变绿，60变灰）：约制作7次可到15，每次涨一点。每次需要1个{spell:2963}和1个{item:2320}。先制作7个{spell:2963}：它在变灰前也能涨技能。此配方向训练师学习，是数据中度过这段技能点最便宜的方式。",

	-- Step 5: Tailoring recipes at 15
	-- {skill:197} Tailoring
	["{skill:197} recipes at 15"] = "{skill:197}：技能 15 时学习的配方",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} (from 15, 50c)."] = "回去找 {skill:197} 训练师：学习 {spell:8776}（15点起可学，50铜币）。",

	-- Step 6: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "将{item:7026}做到 75",
	-- {item:7026} Linen Belt · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread
	["{item:7026} is orange at 15 (yellow 50, green 67, grey 85): about 65 crafts to 75. Each takes 1 {spell:2963} and 1 {item:2320}. Make the 65 {spell:2963} first: it gives points too while not grey. Each belt takes one bolt; the belts sell to vendors."] = "{item:7026}在15时为橙色（50变黄，67变绿，85变灰）：约制作65次可升至75。每次需要1个{spell:2963}和1个{item:2320}。先制作65个{spell:2963}：尚未变灰时也能提升技能。每条腰带消耗一卷布；做好的腰带卖给商人即可。",

	-- Step 7: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "中级{skill:197}",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:2627} Grarnik Goodstitch · {zone:1434} Stranglethorn Vale · {npc:5153} Jormund Stonebrow · {zone:1455} Ironforge · {npc:4159} Me'lynn · {zone:1457} Darnassus · {npc:252380} Othesia Evengale · {npc:251991} Taleen Shimmerthread · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {npc:3363} Magar · {zone:1454} Orgrimmar · {npc:3704} Mahani · {zone:1413} The Barrens · {npc:11049} Rhiannon Davis · {zone:1456} Thunder Bluff · {spell:2964} Bolt of Woolen Cloth · {spell:2402} Woolen Cape · {spell:1229504} Faction Banner · {spell:2963} Bolt of Linen Cloth · {item:2320} Coarse Thread · {item:2592} Wool Cloth · {item:4306} Silk Cloth
	["Journeyman raises the cap from 75 to 150 for 5s; it needs {skill:197} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:197} trainer teaches it: Alliance {npc:1346} ({zone:1453}), {npc:2627} ({zone:1434}), {npc:5153} ({zone:1455}), {npc:4159} ({zone:1457}), {npc:252380} (Zephras Isle), Sellandus ({zone:1453}), {npc:251991} (Zephras Isle) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}), {npc:2627} ({zone:1434}), {npc:4576} ({zone:1458}), {npc:3363} ({zone:1454}), {npc:3704} ({zone:1413}), {npc:252380} (Zephras Isle), {npc:11049} ({zone:1458}), {npc:251991} (Zephras Isle) and Tepa ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:2964} (from 55, 1s) and {spell:2402} (from 55, 2s 50c). Also learn {spell:1229504} (1s): Forever's {skill:197} camp item, a {spell:2963} and a {item:2320}; each faction has its own. The Camping 101: {skill:197} quest from your starting area's camping guide (after The Great Outdoors) sends you to a tailoring trainer who teaches it free. 75-150 takes about 11s of recipes and 1g 65s 50c of vendor goods, plus 567 {item:2592} and 204 {item:4306} to gather or buy."] = "中级裁缝可将上限从75提高到150，费用5银；需要{skill:197} 50及角色10级，因此技能达到50后，任意一次拜访都可学习。并非所有{skill:197}训练师都教：联盟有{npc:1346}（{zone:1453}）、{npc:2627}（{zone:1434}）、{npc:5153}（{zone:1455}）、{npc:4159}（{zone:1457}）、{npc:252380}（Zephras Isle）、Sellandus（{zone:1453}）、{npc:251991}（Zephras Isle）和{npc:11052}（{zone:1445}）；部落有{npc:2399}（{zone:1424}）、{npc:2627}（{zone:1434}）、{npc:4576}（{zone:1458}）、{npc:3363}（{zone:1454}）、{npc:3704}（{zone:1413}）、{npc:252380}（Zephras Isle）、{npc:11049}（{zone:1458}）、{npc:251991}（Zephras Isle）和Tepa（{zone:1456}）。箭头会选择你阵营最近的训练师。现在学习：{spell:2964}（55起可学，1银）和{spell:2402}（55起可学，2银50铜）。再学{spell:1229504}（1银）：这是无限服的{skill:197}露营物品，需要一份{spell:2963}和一根{item:2320}，每个阵营各有自己的版本。起始地区露营向导提供的Camping 101: {skill:197}任务（完成The Great Outdoors后）会引导你去找可免费教授此技能的裁缝训练师。75-150大约需要11银学习配方、1金65银50铜购买商人物资，另需收集或购买567份{item:2592}和204份{item:4306}。",

	-- Step 8: Tailoring 75-150: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 75-150: vendor goods"] = "{skill:197} 75–150：商人材料",
	-- {item:2321} Fine Thread · {item:2324} Bleach · {item:2604} Red Dye · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 108 {item:2321} (1g 8s), 34 {item:2324} (8s 50c) and 98 {item:2604} (49s); about 1g 65s 50c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "一次买齐这个技能阶段所需的物资：108 个 {item:2321}（1 金 8 银）、34 个 {item:2324}（8 银 50 铜）和 98 个 {item:2604}（49 银币）；总计约 1 金 65 银 50 铜。箭头会选择本阵营最近的商人（{zone:1453}：{npc:1347}、{npc:1286} 和 {npc:5565}；{zone:1454}：{npc:3364}、{npc:3367} 和 {npc:5817}）。",

	-- Step 9: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592}（联盟）",
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt · {npc:98} Riverpaw Taskmaster
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it; or the Auction House. It drops from {npc:98} (level 17-18) here."] = "为{spell:2402}和{spell:3866}准备567个{item:2592}：15-30级人型生物会掉落，也可从拍卖行购买。这里的{npc:98}（17-18级）会掉落。",

	-- Step 10: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592}（部落）",
	-- {item:2592} Wool Cloth · {spell:2402} Woolen Cape · {spell:3866} Stylish Red Shirt · {npc:3263} Bristleback Geomancer
	["567 {item:2592} for {spell:2402} and {spell:3866}: humanoids of level 15-30 drop it; or the Auction House. It drops from {npc:3263} (level 19-20) here."] = "为{spell:2402}和{spell:3866}准备567个{item:2592}：15-30级人型生物会掉落，也可从拍卖行购买。这里的{npc:3263}（19-20级）会掉落。",

	-- Step 11: Silk Cloth (Alliance)
	-- {item:4306} Silk Cloth
	["{item:4306} (Alliance)"] = "{item:4306}（联盟）",
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt · {npc:2240} Syndicate Footpad
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it; or the Auction House. It drops from {npc:2240} (level 32-33) here."] = "为 {spell:3871} 准备 204 个 {item:4306}：由 25-45 级人型生物掉落，或在拍卖行购买。这里的 {npc:2240}（32-33 级）会掉落。",

	-- Step 12: Silk Cloth (Horde)
	-- {item:4306} Silk Cloth
	["{item:4306} (Horde)"] = "{item:4306}（部落）",
	-- {item:4306} Silk Cloth · {spell:3871} Formal White Shirt · {npc:11697} Mannoroc Lasher
	["204 {item:4306} for {spell:3871}: humanoids of level 25-45 drop it; or the Auction House. It drops from {npc:11697} (level 29-30) here."] = "为 {spell:3871} 准备204块 {item:4306}：25—45级人型生物掉落；或从拍卖行购买。这里的 {npc:11697}（29—30级）会掉落。",

	-- Step 13: Woolen Cape to 104
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 104"] = "制作{spell:2402}，提升至 104",
	-- {spell:2402} Woolen Cape · {spell:2964} Bolt of Woolen Cloth · {item:2321} Fine Thread
	["{spell:2402} is orange at 75 (yellow 80, green 97, grey 115): about 42 crafts to 104. Each takes 1 {spell:2964} and 1 {item:2321}. Make the 42 {spell:2964} first: it gives points too while not grey. {spell:2964} is taught from 55 on Forever."] = "{spell:2402} 在75点时为橙色（80变黄，97变绿，115变灰）：制作约42次可到104。每次需要1卷 {spell:2964} 和1根 {item:2321}。先制作42卷 {spell:2964}：尚未变灰时，它也能提升技能。无限服在55点起可学习 {spell:2964}。",

	-- Step 14: Tailoring recipes at 104
	-- {skill:197} Tailoring
	["{skill:197} recipes at 104"] = "{skill:197}：技能 104 时学习的配方",
	-- {skill:197} Tailoring · {spell:3866} Stylish Red Shirt
	["Back to a {skill:197} trainer: {spell:3866} (from 85, 2s 50c)."] = "返回{skill:197}训练师处：学习{spell:3866}（需要技能85，2银50铜）。",

	-- Step 15: Stylish Red Shirt to 135
	-- {spell:3866} Stylish Red Shirt
	["{spell:3866} to 135"] = "制作{spell:3866}，提升至 135",
	-- {spell:3866} Stylish Red Shirt · {spell:2964} Bolt of Woolen Cloth · {item:2604} Red Dye · {item:2321} Fine Thread · {item:2592} Wool Cloth
	["{spell:3866} is orange at 104 (yellow 110, green 127, grey 145): about 49 crafts to 135. Each takes 3 {spell:2964}, 2 {item:2604} and 1 {item:2321}. Make the 147 {spell:2964} first. Three woolen bolts and two {item:2604} a shirt; {item:2592} drops from humanoids of level 15-30."] = "{spell:3866} 在104点时为橙色（110变黄，127变绿，145变灰）：制作约49次可到135。每次需要3卷 {spell:2964}、2份 {item:2604} 和1根 {item:2321}。先制作147卷 {spell:2964}。每件衬衣消耗三卷毛布和两份 {item:2604}；{item:2592} 由15—30级人形生物掉落。",

	-- Step 16: Tailoring recipes at 135
	-- {skill:197} Tailoring
	["{skill:197} recipes at 135"] = "{skill:197}：技能 135 时学习的配方",
	-- {skill:197} Tailoring · {spell:3839} Bolt of Silk Cloth · {spell:3871} Formal White Shirt
	["Back to a {skill:197} trainer: {spell:3839} (from 100, 5s) and {spell:3871} (from 135)."] = "返回 {skill:197} 训练师处：学习 {spell:3839}（技能 100 起可学，5 银）和 {spell:3871}（技能 135 起可学）。",

	-- Step 17: Formal White Shirt to 150
	-- {spell:3871} Formal White Shirt
	["{spell:3871} to 150"] = "{spell:3871}练到150",
	-- {spell:3871} Formal White Shirt · {spell:3839} Bolt of Silk Cloth · {item:2324} Bleach · {item:2321} Fine Thread · {item:4306} Silk Cloth · {skill:197} Tailoring
	["{spell:3871} is orange at 135 (yellow 145, green 150, grey 155): about 17 crafts to 150. Each takes 3 {spell:3839}, 2 {item:2324} and 1 {item:2321}. Make the 51 {spell:3839} first. Silk bolts from here on: {item:4306} drops from humanoids of level 25-45. {item:2324} from tailoring and trade supplies vendors. {skill:197} 150 is a Legacy System milestone."] = "{spell:3871} 在技能135时为橙色（145变黄，150变绿，155变灰）：大约制作17次升到150。每次需要3卷 {spell:3839}、2份 {item:2324} 和1根 {item:2321}。先制作51卷 {spell:3839}。从这里起开始使用丝绸卷：{item:4306} 由25—45级人型生物掉落。{item:2324} 向裁缝和商贸供应商购买。{skill:197} 150是传承系统的一项里程碑。",

	-- Step 18: Tailoring 150-225: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 150-225: vendor goods"] = "{skill:197} 150–225：商人材料",
	-- {item:2321} Fine Thread · {item:4291} Silken Thread · {item:6260} Blue Dye · {item:8343} Heavy Silken Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 44 {item:2321} (44s), 90 {item:4291} (4g 50s), 44 {item:6260} (22s) and 80 {item:8343} (16g); about 21g 16s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "一次买齐本阶段的用量：44根 {item:2321}（44银币）、90根 {item:4291}（4金币50银币）、44份 {item:6260}（22银币）和80根 {item:8343}（16金币）；总计约21金币16银币。箭头会指向本阵营最近的商人（{zone:1453}：{npc:1347}、{npc:1286} 和 {npc:5565}；{zone:1454}：{npc:3364}、{npc:3367} 和 {npc:5817}）。",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7089} Pattern: Azure Silk Cloak · {item:7053} Azure Silk Cloak · {skill:197} Tailoring · {npc:6576} Brienna Starglow · {zone:1444} Feralas · {npc:251997} Norvin Alderman · {zone:1416} Alterac Mountains · {npc:6574} Jun'ha · {zone:1417} Arathi Highlands
	["{item:7089} teaches {item:7053} ({skill:197} 140) for 15s. Sold by Alliance: {npc:6576} ({zone:1444}), limited stock and {npc:251997} ({zone:1416}); Horde: {npc:6574} ({zone:1417}), limited stock and {npc:251997} ({zone:1416})."] = "{item:7089}用于学习{item:7053}（需要{skill:197}140），售价15银币。联盟出售者：{npc:6576}（{zone:1444}，限量）及{npc:251997}（{zone:1416}）；部落出售者：{npc:6574}（{zone:1417}，限量）及{npc:251997}（{zone:1416}）。",

	-- Step 20: Silk Cloth
	-- {item:4306} Silk Cloth · {item:7053} Azure Silk Cloak
	["264 {item:4306} for {item:7053}: humanoids of level 25-45 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "为 {item:7053} 准备 264 个 {item:4306}：由 25-45 级人型生物掉落，或在拍卖行购买。箭头会按你的等级和阵营选择刷取地点。",

	-- Step 21: Mageweave Cloth (Alliance)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Alliance)"] = "{item:4338}（联盟）",
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband · {npc:4467} Vilebranch Soothsayer
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it; or the Auction House. It drops from {npc:4467} (level 46-47) here."] = "为 {item:9998} 和 {item:10024} 准备 900 个 {item:4338}：由 35-50 级人型生物掉落，或在拍卖行购买。这里的 {npc:4467}（46-47 级）会掉落。",

	-- Step 22: Mageweave Cloth (Horde)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Horde)"] = "{item:4338}（部落）",
	-- {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband · {npc:5472} Dunemaul Enforcer
	["900 {item:4338} for {item:9998} and {item:10024}: humanoids of level 35-50 drop it; or the Auction House. It drops from {npc:5472} (level 46-47) here."] = "为 {item:9998} 和 {item:10024} 准备 900 个 {item:4338}：由 35-50 级人型生物掉落，或在拍卖行购买。这里的 {npc:5472}（46-47 级）会掉落。",

	-- Step 23: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "高级{skill:197}",
	-- {skill:197} Tailoring · {npc:1346} Georgio Bolero · {zone:1453} Stormwind City · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {npc:4576} Josef Gregorian · {zone:1458} Undercity · {spell:3865} Bolt of Mageweave · {item:4306} Silk Cloth · {item:4338} Mageweave Cloth · {item:9998} Black Mageweave Vest · {item:10024} Black Mageweave Headband
	["Expert raises the cap from 150 to 225; it needs {skill:197} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:1346} ({zone:1453}) and {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}) and {npc:4576} ({zone:1458}). The arrow picks the nearest of your faction. Learn now: {spell:3865} (from 140). 150-225 takes about 15s of recipes and 21g 16s of vendor goods, plus 264 {item:4306} and 900 {item:4338} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {item:9998} (from 170) and {item:10024} (from 190), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "高级将上限从150提高到225；需要{skill:197}125、角色20级，因此达到125后每次路过都可学习。只有少数训练师教授：联盟为{npc:1346}（{zone:1453}）和{npc:11052}（{zone:1445}）；部落为{npc:2399}（{zone:1424}）和{npc:4576}（{zone:1458}）。箭头会选择本阵营最近的一位。现在学习：{spell:3865}（140起）。150-225约需15银学习配方、21金16银购买商人物品，另需收集或购买264个{item:4306}和900个{item:4338}。来之前把材料全部放进背包（按上面的步骤准备，其余从拍卖行购买）：这些训练师也教授{item:9998}（170起）和{item:10024}（190起），而制作无需工作台，因此可以就在这里制作，达到所需技能时就学新配方。原本要跑 3 趟的事，现在一趟即可完成。",

	-- Step 24: Azure Silk Cloak to 170
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 170"] = "制作{item:7053}，提升至 170",
	-- {item:7053} Azure Silk Cloak · {spell:3839} Bolt of Silk Cloth · {item:6260} Blue Dye · {item:2321} Fine Thread
	["{item:7053} is orange at 150 (yellow 160, green 175, grey 190): about 22 crafts to 170. Each takes 3 {spell:3839}, 2 {item:6260} and 2 {item:2321}. Make the 66 {spell:3839} first. Its recipe is the one bought above; it is the cheapest way through these points in the data."] = "{item:7053} 在技能150时为橙色（160变黄，175变绿，190变灰）：大约制作22次升到170。每次需要3卷 {spell:3839}、2份 {item:6260} 和2根 {item:2321}。先制作66卷 {spell:3839}。配方就是上面买的那张；按数据，这是这一阶段最省钱的冲点方式。",
	["from the recipe in your bags"] = "使用背包里的配方",

	-- Step 25: Tailoring recipes at 170
	-- {skill:197} Tailoring
	["{skill:197} recipes at 170"] = "{skill:197}：技能 170 时学习的配方",
	-- {spell:12048} Black Mageweave Vest
	["Still at the Expert trainer: {spell:12048} (from 170)."] = "继续在高级训练师处学习{spell:12048}（技能 170 起可学）。",

	-- Step 26: Black Mageweave Vest to 197
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 197"] = "制作{item:9998}，提升至 197",
	-- {item:9998} Black Mageweave Vest · {spell:3865} Bolt of Mageweave · {item:4291} Silken Thread
	["{item:9998} is orange at 170 (yellow 185, green 200, grey 215): about 30 crafts to 197. Each takes 2 {spell:3865} and 3 {item:4291}. Make the 60 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data."] = "{item:9998} 在技能170时为橙色（185变黄，200变绿，215变灰）：大约制作30次升到197。每次需要2卷 {spell:3865} 和3根 {item:4291}。先制作60卷 {spell:3865}。训练师可教授此配方，按数据，这是这一阶段最省钱的冲点方式。",

	-- Step 27: Tailoring recipes at 197
	-- {skill:197} Tailoring
	["{skill:197} recipes at 197"] = "{skill:197}：技能 197 时学习的配方",
	-- {spell:12072} Black Mageweave Headband
	["Still at the Expert trainer: {spell:12072} (from 190)."] = "继续在高级训练师处学习{spell:12072}（技能 190 起可学）。",

	-- Step 28: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "将{item:10024}做到 225",
	-- {item:10024} Black Mageweave Headband · {spell:3865} Bolt of Mageweave · {item:8343} Heavy Silken Thread · {skill:197} Tailoring
	["{item:10024} is orange at 197 (yellow 205, green 220, grey 235): about 40 crafts to 225. Each takes 3 {spell:3865} and 2 {item:8343}. Make the 120 {spell:3865} first. The trainer teaches it, and it is the cheapest way through these points in the data. {skill:197} 225 is a Legacy System milestone."] = "{item:10024}在技能197时为橙色（205变黄，220变绿，235变灰）：约制作40次可到225。每次需要3个{spell:3865}和2个{item:8343}。先制作120个{spell:3865}。此配方向训练师学习，是数据中度过这段技能点最便宜的方式。{skill:197}225是传承系统的一个里程碑。",

	-- Step 29: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "专家级{skill:197}",
	-- {skill:197} Tailoring · {npc:11052} Timothy Worthington · {zone:1445} Dustwallow Marsh · {npc:2399} Daryl Stack · {zone:1424} Hillsbrad Foothills · {spell:18401} Bolt of Runecloth · {spell:18402} Runecloth Belt · {item:8170} Rugged Leather · {item:14047} Runecloth · {item:14227} Ironweb Spider Silk
	["Artisan raises the cap from 225 to 300; it needs {skill:197} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:11052} ({zone:1445}); Horde {npc:2399} ({zone:1424}). The arrow picks the nearest of your faction. Learn now: {spell:18401} (from 205) and {spell:18402} (from 210). 225-300 takes about 1g 60s of recipes and 58g of vendor goods, plus 420 {item:8170}, 3195 {item:14047} and 124 {item:14227} to gather or buy."] = "大师级技能将上限从225提高到300；需要 {skill:197} 200和角色35级，因此达到200后，随时拜访都能学习。只有少数训练师教授：联盟的 {npc:11052}（{zone:1445}）；部落的 {npc:2399}（{zone:1424}）。箭头会选择本阵营最近的一位。现在学习：{spell:18401}（205起）和 {spell:18402}（210起）。225—300阶段约需购买1金币60银币的配方和58金币的商人物资，另外还需采集或购买420张 {item:8170}、3195块 {item:14047} 和124份 {item:14227}。",

	-- Step 30: Tailoring 225-300: vendor goods
	-- {skill:197} Tailoring
	["{skill:197} 225-300: vendor goods"] = "{skill:197} 225–300：商人材料",
	-- {item:14341} Rune Thread · {zone:1453} Stormwind City · {npc:1347} Alexandra Bolero · {npc:1286} Edna Mullby · {npc:5565} Jillian Tanner · {zone:1454} Orgrimmar · {npc:3364} Borya · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 116 {item:14341} (58g); about 58g in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1347}, {npc:1286} and {npc:5565}; {zone:1454}: {npc:3364}, {npc:3367} and {npc:5817})."] = "一次买齐整个阶段的用量：116个{item:14341}（58金币）；合计约58金币。箭头会选择本阵营最近的商人（{zone:1453}：{npc:1347}、{npc:1286}和{npc:5565}；{zone:1454}：{npc:3364}、{npc:3367}和{npc:5817}）。",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:14481} Pattern: Runecloth Gloves · {item:13863} Runecloth Gloves · {skill:197} Tailoring · {npc:11189} Qia · {zone:1452} Winterspring
	["{item:14481} teaches {item:13863} ({skill:197} 230) for 1g 60s. Sold by {npc:11189} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:14481} 可教你制作 {item:13863}（{skill:197} 230），售价1金币60银币。由 {npc:11189}（{zone:1452}）限量出售。商人会保有一到两份库存，售出一段时间后补货；它拾取后绑定，因此拍卖行不会有售。",

	-- Step 32: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170}（联盟）",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:1815}, {npc:1816} and {npc:1817} here (level 48-60); the {skill:393} guide routes this."] = "为 {item:13863} 和 {item:13867} 准备420张 {item:8170}：{skill:393}：剥取48—60级野兽；也可在拍卖行购买。在这里剥取 {npc:1815}、{npc:1816} 和 {npc:1817}（48—60级）；{skill:393} 指南会安排相应路线。",

	-- Step 33: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170}（部落）",
	-- {item:8170} Rugged Leather · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {skill:393} Skinning · {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing
	["420 {item:8170} for {item:13863} and {item:13867}: {skill:393}: beasts of level 48-60; or the Auction House. Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378} and {npc:6377} here (level 48-60); the {skill:393} guide routes this."] = "为 {item:13863} 和 {item:13867} 准备420张 {item:8170}：{skill:393}：剥取48—60级野兽；也可在拍卖行购买。在这里剥取 {npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378} 和 {npc:6377}（48—60级）；{skill:393} 指南会安排相应路线。",

	-- Step 34: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047}（联盟）",
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {npc:7027} Blackrock Slayer
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "准备3195个{item:14047}制作{item:13856}、{item:13863}和{item:13867}：45-60级人型生物会掉落；也可从拍卖行购买。这里的{npc:7027}（56-57级）会掉落。",

	-- Step 35: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047}（部落）",
	-- {item:14047} Runecloth · {item:13856} Runecloth Belt · {item:13863} Runecloth Gloves · {item:13867} Runecloth Shoulders · {npc:11880} Twilight Avenger
	["3195 {item:14047} for {item:13856}, {item:13863} and {item:13867}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "准备 3195 个 {item:14047}，用于 {item:13856}、{item:13863} 和 {item:13867}：45-60 级人型生物会掉落，或在拍卖行购买。这里的 {npc:11880}（57-59 级）会掉落。",

	-- Step 36: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227}（联盟）",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:1824} Plague Lurker
	["124 {item:14227} for {item:13867}: it drops from {npc:1824} (level 54-55) at the marked spot, or buy it at the Auction House."] = "准备124个{item:14227}制作{item:13867}：标记位置的{npc:1824}（54-55级）会掉落，也可从拍卖行购买。",

	-- Step 37: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227}（部落）",
	-- {item:14227} Ironweb Spider Silk · {item:13867} Runecloth Shoulders · {npc:11739} Rock Stalker
	["124 {item:14227} for {item:13867}: it drops from {npc:11739} (level 57-59) at the marked spot, or buy it at the Auction House."] = "为 {item:13867} 准备124份 {item:14227}：标记位置的 {npc:11739}（57—59级）会掉落，也可从拍卖行购买。",

	-- Step 38: Runecloth Belt to 234
	-- {item:13856} Runecloth Belt
	["{item:13856} to 234"] = "制作{item:13856}，提升至 234",
	-- {item:13856} Runecloth Belt · {item:14048} Bolt of Runecloth · {item:14341} Rune Thread
	["{item:13856} is yellow at 225 (yellow 225, green 240, grey 255): about 11 crafts to 234. Each takes 3 {item:14048} and 1 {item:14341}. Make the 33 {item:14048} first. {item:14341} from tailoring vendors."] = "{item:13856} 在225点时为黄色（225变黄，240变绿，255变灰）：制作约11次可到234。每次需要3卷 {item:14048} 和1根 {item:14341}。先制作33卷 {item:14048}。{item:14341} 可向裁缝供应商购买。",

	-- Step 39: Runecloth Gloves to 265
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 265"] = "制作{item:13863}，提升至 265",
	-- {item:13863} Runecloth Gloves · {item:14048} Bolt of Runecloth · {item:8170} Rugged Leather · {item:14341} Rune Thread · {npc:11189} Qia · {area:2255} Everlook · {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{item:13863} is orange at 234 (yellow 245, green 260, grey 275): about 43 crafts to 265. Each takes 4 {item:14048}, 4 {item:8170} and 1 {item:14341}. Make the 172 {item:14048} first. {npc:11189} in {area:2255} keeps one pattern at a time; the {area:1769} tunnel from {zone:1448} is the road in, so never kill Timbermaw furbolgs on the way."] = "{item:13863}在234时为橙色（245变黄，260变绿，275变灰）：约制作43次可升至265。每次需要4个{item:14048}、4个{item:8170}和1个{item:14341}。先制作172个{item:14048}。{area:2255}的{npc:11189}每次只出售一张图样；需从{zone:1448}经{area:1769}隧道前往，因此途中千万别杀木喉熊怪。",

	-- Step 40: Runecloth Shoulders to 300
	-- {item:13867} Runecloth Shoulders
	["{item:13867} to 300"] = "制作{item:13867}，提升至 300",
	-- {item:13867} Runecloth Shoulders · {item:14048} Bolt of Runecloth · {item:14227} Ironweb Spider Silk · {item:8170} Rugged Leather · {item:14341} Rune Thread · {item:14504} Pattern: Runecloth Shoulders · {zone:1422} Western Plaguelands · {zone:1451} Silithus · {item:13863} Runecloth Gloves · {item:13864} Runecloth Boots · {npc:7940} Darnall · {zone:1450} Moonglade · {item:14342} Mooncloth · {npc:11189} Qia · {npc:11188} Evie Whirlbrew · {area:2255} Everlook · {item:14256} Felcloth · {item:279943} Spinning Wheel · {npc:248202} Jim'bek · {npc:256735} Mivin Shadowweave · {npc:246017} Unstable Sentinel · {item:254123} Runecloth Cuffs · {zone:2482} Mount Hyjal · {skill:197} Tailoring
	["{item:13867} is orange at 265 (yellow 275, green 290, grey 305): about 62 crafts to 300. Each takes 7 {item:14048}, 2 {item:14227}, 4 {item:8170} and 1 {item:14341}. Make the 434 {item:14048} first. Its pattern ({item:14504}) drops from mobs all over the world and does not bind: buy it at the Auction House. Seven bolts, two {item:14227} and four {item:8170} a craft: the dearest stretch. The spiders of {zone:1422} and {zone:1451} drop the silk (the marked spots), or the Auction House. No pattern on the Auction House? {item:13863} still give a point now and then to 275, and {item:13864} ({npc:7940}, {zone:1450}) to 280, at 4 bolts a craft. {item:14342} (pattern from {npc:11189} or {npc:11188} in {area:2255}; 2 {item:14256} at a Moonwell) stays orange to 270 and yellow to 285, but it can be made once every four days. The {item:279943} patterns (Merchant's Favor sandals and waistcords from {npc:248202} or {npc:256735}; the wheel's blueprint drops from the {npc:246017} in the City of Dalaran) and {item:254123} (Pexmit in {zone:2482}, 10g; we could not confirm that vendor yet) are the other ways on. {skill:197} 300 is a Legacy System milestone."] = "{item:13867}在技能265时为橙色（275变黄，290变绿，305变灰）：约制作62次可到300。每次需要7个{item:14048}、2个{item:14227}、4个{item:8170}和1个{item:14341}。先制作434个{item:14048}。图样（{item:14504}）由世界各地怪物掉落，不绑定：可在拍卖行购买。每次需7卷布、2个{item:14227}和4个{item:8170}：这是最贵的一段。丝可从{zone:1422}和{zone:1451}的蜘蛛获取（已标记位置），或从拍卖行购买。拍卖行没有图样？{item:13863}到275前仍偶尔涨点，{item:13864}（{zone:1450}的{npc:7940}出售）可用到280，每次需4卷布。{item:14342}（图样由{area:2255}的{npc:11189}或{npc:11188}出售；在月亮井用2个{item:14256}制作）到270前为橙色，到285前为黄色，但每4天只能制作一次。其他提升途径还有{item:279943}图样（用商人青睐向{npc:248202}或{npc:256735}购买的便鞋和腰绳图样；纺车蓝图由达拉然城的{npc:246017}掉落），以及{item:254123}（{zone:2482}的 Pexmit 出售，10金币；我们尚未确认该商人）。{skill:197}300是传承系统的一个里程碑。",
	["from the pattern bought at the Auction House"] = "使用拍卖行购买的图样",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:197}"] = "初级{skill:197}",
	-- ["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "专家级需要角色等级 35 且{skill:197}达到 200；会将上限提高到 300。225-300 的材料总价约 845 金币。",
	-- ["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "回到{skill:197}训练师处：{spell:12048}在{skill:197} 185 时可学。",
	-- ["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "回到{skill:197}训练师处：{spell:12072}在{skill:197} 205 时可学。",
	-- ["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "回到{skill:197}训练师处：{spell:2402}在{skill:197} 80 时可学。",
	-- ["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "回到{skill:197}训练师处：{spell:3848}在{skill:197} 110 时可学。",
	-- ["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "回到{skill:197}训练师处：{spell:3852}在{skill:197} 125 时可学。",
	-- ["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "回到{skill:197}训练师处：{spell:8776}在{skill:197} 50 时可学。",
	-- ["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "回到{skill:197}训练师处：{spell:8799}在{skill:197} 180 时可学。",
	-- ["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "高级需要角色等级 20 且{skill:197}达到 125；会将上限提高到 225。150-225 的材料总价约 135 金币。",
	-- ["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "中级需要角色等级 10 且{skill:197}达到 50；会将上限提高到 150。75-150 的材料总价约 17 金币。",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在 Polestar 按你的等级和阵营选出的刷材料地点击杀掉落它的怪物。也可以去拍卖行购买。",
	-- ["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "在 Forever 上，训练师教授的配方以及两大阵营商人出售的配方在 295 之后都不再提升{skill:197}，因此 Polestar 没有最后几点的路线。仍能加点的配方：{item:14342}（需要月亮井）、{item:14137}（需要{item:279943}）、{item:14155}（配方为掉落）、{item:14128}（配方为掉落）、{item:19047}（需要{item:279943}）。",
	-- ["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "160 前为橙色（每次制造都加点），175 前为黄色，190 前为绿色。",
	-- ["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "245 前为橙色（每次制造都加点），260 前为黄色，275 前为绿色。",
	-- ["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "265 前为橙色（每次制造都加点），280 前为黄色，295 前为绿色。",
	-- ["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "40 前为橙色（每次制造都加点），50 前为黄色，60 前为绿色。",
	-- ["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里对{npc:1815}、{npc:1816}、{npc:1817}剥皮（48-60 级的野兽会产出它）；{skill:393}指南有相应路线。也可以去拍卖行购买。",
	-- ["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里对{npc:6369}、{npc:8760}、{npc:6380}、{npc:6379}、{npc:6378}、{npc:6377}剥皮（48-60 级的野兽会产出它）；{skill:393}指南有相应路线。也可以去拍卖行购买。",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剥皮、分解或其他专业制造所得：自己收集，或在拍卖行购买。",
	-- ["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "学会{item:13863}（需要{skill:197} 230）。商人限量出售并会补货。",
	-- ["Teaches {item:254123} (needs {skill:197} 250)."] = "学会{item:254123}（需要{skill:197} 250）。",
	-- ["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "学会{item:7053}（需要{skill:197} 140）。商人限量出售并会补货。",
	-- ["Yellow until 127, green until 145: not every craft gives a point."] = "127 前为黄色，145 前为绿色：不是每次制造都加点。",
	-- ["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "140 前为黄色，155 前为绿色：不是每次制造都加点。{skill:197} 150 是传承系统的里程碑。",
	-- ["Yellow until 190, green until 200: not every craft gives a point."] = "190 前为黄色，200 前为绿色：不是每次制造都加点。",
	-- ["Yellow until 200, green until 215: not every craft gives a point."] = "200 前为黄色，215 前为绿色：不是每次制造都加点。",
	-- ["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "220 前为黄色，235 前为绿色：不是每次制造都加点。{skill:197} 225 是传承系统的里程碑。",
	-- ["Yellow until 240, green until 255: not every craft gives a point."] = "240 前为黄色，255 前为绿色：不是每次制造都加点。",
	-- ["Yellow until 67, green until 85: not every craft gives a point."] = "67 前为黄色，85 前为绿色：不是每次制造都加点。",
	-- ["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "67 前为黄色，85 前为绿色：不是每次制造都加点。75 是初级上限。",
	-- ["Yellow until 97, green until 115: not every craft gives a point."] = "97 前为黄色，115 前为绿色：不是每次制造都加点。",
	-- ["{item:10045} to 50"] = "将{item:10045}做到 50",
	-- ["{item:13856} to 236"] = "将{item:13856}做到 236",
	-- ["{item:13863} to 251"] = "将{item:13863}做到 251",
	-- ["{item:254123} to 295"] = "将{item:254123}做到 295",
	-- ["{item:7026} to 80"] = "将{item:7026}做到 80",
	-- ["{item:7053} to 180"] = "将{item:7053}做到 180",
	-- ["{item:7062} to 185"] = "将{item:7062}做到 185",
	-- ["{item:9998} to 205"] = "将{item:9998}做到 205",
	-- ["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "这里的{npc:11739}（等级 57-59）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "这里的{npc:1824}（等级 54-55）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "这里的{npc:3263}（等级 19-20）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "这里的{npc:5472}（等级 46-47）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "这里的{npc:6006}（等级 52-53）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "这里的{npc:6189}（等级 51-52）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "这里的{npc:7027}（等级 56-57）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "这里的{npc:98}（等级 17-18）会掉落它。也可以去拍卖行购买。",
	-- ["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}：{item:3383}（或去拍卖行购买）",
	-- ["{skill:197} materials for 75-150"] = "{skill:197} 75-150 所需材料",
	-- ["{skill:197} recipes at 110"] = "{skill:197} 110 级配方",
	-- ["{skill:197} recipes at 125"] = "{skill:197} 125 级配方",
	-- ["{skill:197} recipes at 180"] = "{skill:197} 180 级配方",
	-- ["{skill:197} recipes at 185"] = "{skill:197} 185 级配方",
	-- ["{skill:197} recipes at 205"] = "{skill:197} 205 级配方",
	-- ["{skill:197} recipes at 50"] = "{skill:197} 50 级配方",
	-- ["{skill:197} recipes at 80"] = "{skill:197} 80 级配方",
	-- ["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197}可以边升级边练。Forever 的传承系统会在制造专业技能达到 150、225 和 300（中级、高级和专家级的上限）时给予奖励，所以每个节点都很重要。1-75 的材料总价约 1 金币 8 银币。",
	-- ["{spell:2402} to 110"] = "将{spell:2402}做到 110",
	-- ["{spell:3848} to 125"] = "将{spell:3848}做到 125",
	-- ["{spell:3852} to 150"] = "将{spell:3852}做到 150",
}
