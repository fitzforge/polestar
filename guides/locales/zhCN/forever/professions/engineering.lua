-- Chinese (simplified) (zhCN): the guide forever/professions/engineering (forever/professions/engineering.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Engineering
	-- {skill:202} Engineering
	["Learn {skill:202}"] = "学习{skill:202}",
	-- {skill:202} Engineering · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2835} Rough Stone · {item:2770} Copper Ore · {item:2840} Copper Bar
	["Apprentice {skill:202} lets you craft up to 75 for 10c, at any character level. Any {skill:202} trainer of your faction teaches it; the arrow picks the nearest. Buy a {item:5956} and pair it with {skill:186}: {item:2835} and {item:2770} are the first parts. 1-75 takes about 4s 15c of recipes and 18s 18c of vendor goods, plus 46 {item:2835} and 75 {item:2840} to gather or buy."] = "初级 {skill:202} 将制作技能上限提高到75，费用10铜币，无角色等级要求。本阵营任何 {skill:202} 训练师都能教授；箭头会选择最近的一位。购买一把 {item:5956}，并搭配 {skill:186}：最先需要的材料是 {item:2835} 和 {item:2770}。1—75阶段约需购买4银15铜的配方和18银18铜的商人物资，另外还需采集或购买46块 {item:2835} 和75块 {item:2840}。",

	-- Step 2: Engineering 1-75: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 1-75: vendor goods"] = "{skill:202} 1–75：商人材料",
	-- {item:2880} Weak Flux · {item:5956} Blacksmith Hammer · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 18 {item:2880} (18s) and {item:5956} (a tool: one, kept in your bags, 18c); about 18s 18c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286}; {zone:1454}: {npc:3367}, Gorina and {npc:5817})."] = "一次买齐这个技能阶段所需的物资：18 个 {item:2880}（18 银币）和 {item:5956}（工具：只要一个，放在背包里保留，18 铜币）；总计约 18 银 18 铜。箭头会选择本阵营最近的商人（{zone:1453}：{npc:5519}、{npc:5514} 和 {npc:1286}；{zone:1454}：{npc:3367}、高里纳和 {npc:5817}）。",
	["a tool, keep it in your bags"] = "工具，留在背包里",

	-- Step 3: Rough Stone (Elwynn Forest)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1429} Elwynn Forest
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1429} is marked."] = "为 {spell:3918} 准备46个 {item:2835}：{skill:186}：开采 {object:1731}（技能1）；也可在拍卖行购买。已标出 {zone:1429} 中 {object:1731} 最密集的矿点群。",

	-- Step 4: Rough Stone (Dun Morogh)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1426} Dun Morogh
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1426} is marked."] = "为 {spell:3918} 准备46个 {item:2835}：{skill:186}：开采 {object:1731}（技能1）；也可在拍卖行购买。已标出 {zone:1426} 中 {object:1731} 最密集的矿点群。",

	-- Step 5: Rough Stone (Darkshore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1439} Darkshore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1439} is marked."] = "为 {spell:3918} 准备46个 {item:2835}：{skill:186}：开采 {object:1731}（技能1）；也可在拍卖行购买。已标出 {zone:1439} 中 {object:1731} 最密集的矿点群。",

	-- Step 6: Rough Stone (Zephras Isle)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:2521} Zephras Isle
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:2521} is marked."] = "为 {spell:3918} 准备46个 {item:2835}：{skill:186}：开采 {object:1731}（技能1）；也可在拍卖行购买。已标出 {zone:2521} 中 {object:1731} 最密集的矿点群。",

	-- Step 7: Rough Stone (Durotar)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1411} Durotar
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1411} is marked."] = "为 {spell:3918} 准备46个 {item:2835}：{skill:186}：开采 {object:1731}（技能1）；也可在拍卖行购买。已标出 {zone:1411} 中 {object:1731} 最密集的矿点群。",

	-- Step 8: Rough Stone (Mulgore)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1412} Mulgore
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1412} is marked."] = "为 {spell:3918} 准备46个 {item:2835}：{skill:186}：开采 {object:1731}（技能1）；也可在拍卖行购买。已标出 {zone:1412} 中 {object:1731} 最密集的矿点群。",

	-- Step 9: Rough Stone (Tirisfal Glades)
	-- {item:2835} Rough Stone · {spell:3918} Rough Blasting Powder · {skill:186} Mining · {object:1731} Copper Vein · {zone:1420} Tirisfal Glades
	["46 {item:2835} for {spell:3918}: {skill:186}: {object:1731} (skill 1); or the Auction House. The densest cluster of {object:1731} in {zone:1420} is marked."] = "为 {spell:3918} 准备46个 {item:2835}：{skill:186}：开采 {object:1731}（技能1）；也可在拍卖行购买。已标出 {zone:1420} 中 {object:1731} 最密集的矿点群。",

	-- Step 10: Rough Blasting Powder to 35
	-- {spell:3918} Rough Blasting Powder
	["{spell:3918} to 35"] = "制作{spell:3918}，提升至 35",
	-- {spell:3918} Rough Blasting Powder · {item:2835} Rough Stone · {item:2770} Copper Ore
	-- plural, as words: Copper Veins = {object:1731} Copper Vein
	["{spell:3918} is orange at 1 (yellow 20, green 30, grey 40): about 46 crafts to 35. Each takes 1 {item:2835}. One {item:2835} a craft; {item:2835} comes with the {item:2770} from Copper Veins."] = "{spell:3918}在1时为橙色（20变黄，30变绿，40变灰）：约制作46次可升至35。每次需要1个{item:2835}。每次一个{item:2835}；采铜矿获取{item:2770}时也会得到{item:2835}。",

	-- Step 11: Engineering recipes at 35
	-- {skill:202} Engineering
	["{skill:202} recipes at 35"] = "{skill:202}：技能 35 时学习的配方",
	-- {skill:202} Engineering · {spell:3922} Handful of Copper Bolts · {spell:1230656} Reagent Bot · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:3922} (from 30, 1s 15c). Also learn {spell:1230656} (1s): Forever's {skill:202} camp item, placed at a campsite beside a campfire. It takes a {spell:3922} and a {spell:3924}, which you learn at 30 and 50, so it gives no points. The Camping 101: {skill:202} quest from your starting area's camping guide (after The Great Outdoors) sends you to an engineering trainer who teaches it free."] = "返回 {skill:202} 训练师处：学习 {spell:3922}（技能 30 起可学，1 银 15 铜）。同时学习 {spell:1230656}（1 银）：这是无限的 {skill:202} 露营物品，可放在营地的营火旁。它需要一个 {spell:3922} 和一个 {spell:3924}，两者分别在技能 30 和 50 时学习，因此制作它不会提升技能。起始地区的露营向导在“广阔天地”之后提供的露营 101: {skill:202} 任务，会让你去找一名工程学训练师，由其免费教授。",

	-- Step 12: Handful of Copper Bolts to 57
	-- {spell:3922} Handful of Copper Bolts
	["{spell:3922} to 57"] = "制作{spell:3922}，提升至 57",
	-- {spell:3922} Handful of Copper Bolts · {item:2840} Copper Bar · {item:5956} Blacksmith Hammer · {skill:186} Mining · {item:2770} Copper Ore
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{spell:3922} is orange at 35 (yellow 45, green 52, grey 60): about 33 crafts to 57. Each takes 1 {item:2840}. One {item:2840} a craft. Keep the bolts: Practice Locks and later gadgets take them. Needs an anvil nearby. {item:5956} is a tool: keep it in your bags. {item:2840} (75 for 1-75): {skill:186}: smelt {item:2770}; or the Auction House."] = "{spell:3922}在技能35时为橙色（45变黄，52变绿，60变灰）：约制作33次可到57。每次需要1个{item:2840}。也就是每次1个{item:2840}。保留螺栓：练习锁及之后的装置会用到。附近需要有铁砧。{item:5956}是工具：保留在背包中。{item:2840}（1-75需75个）：通过{skill:186}熔炼{item:2770}，或从拍卖行购买。",

	-- Step 13: Engineering recipes at 57
	-- {skill:202} Engineering
	["{skill:202} recipes at 57"] = "{skill:202}：技能 57 时学习的配方",
	-- {skill:202} Engineering · {spell:7430} Arclight Spanner · {spell:3924} Copper Tube
	["Back to an {skill:202} trainer: {spell:7430} (from 50, 1s 50c) and {spell:3924} (from 50, 1s 50c)."] = "返回 {skill:202} 训练师处：学习 {spell:7430}（技能 50 起可学，1 银 50 铜）和 {spell:3924}（技能 50 起可学，1 银 50 铜）。",

	-- Step 14: Copper Tube to 75
	-- {spell:3924} Copper Tube
	["{spell:3924} to 75"] = "{spell:3924}练到75",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux · {item:6219} Arclight Spanner
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is orange at 57 (yellow 80, green 95, grey 110): about 18 crafts to 75, a point every craft. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby. Make the {item:6219} now, while it still gives a point: a later recipe needs it in your bags, so keep it there."] = "{spell:3924} 在技能 57 时为橙色（80 变黄、95 变绿、110 变灰）：约制作 18 次可升到 75，每次制作提升一点。每次需要 2 个 {item:2840} 和 1 个 {item:2880}，即两块铜锭和一个 {item:2880}（锻造和工程学供应商出售）。附近需要有铁砧。趁制作仍能提升技能，现在就制作 {item:6219}：后面的配方需要它在背包里，因此要一直保留。",
	["a tool: keep it in your bags"] = "工具：放在背包里",

	-- Step 15: Journeyman Engineering
	-- {skill:202} Engineering
	["Journeyman {skill:202}"] = "中级{skill:202}",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {npc:1676} Finbus Geargrind · {zone:1431} Duskwood · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:11029} Trixie Quikswitch · {npc:11031} Franklin Lloyd · {zone:1458} Undercity · {npc:3412} Nogg · {zone:1454} Orgrimmar · {spell:3929} Coarse Blasting Powder · {spell:3930} Crafted Heavy Shot · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2840} Copper Bar · {item:2841} Bronze Bar · {item:2842} Silver Bar
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:202} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:202} trainer teaches it: Alliance {npc:8736} ({zone:1446}), {npc:1676} ({zone:1431}), {npc:5518} ({zone:1453}), {npc:5174} ({zone:1455}) and {npc:11029} ({zone:1455}); Horde {npc:8736} ({zone:1446}), {npc:11031} ({zone:1458}), {npc:3412} ({zone:1454}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:3929} (from 75, 2s 50c) and {spell:3930} (from 75, 2s 50c). 75-150 takes about 5s of recipes and 45s of vendor goods, plus 15 {item:2836}, 27 {item:2838}, 72 {item:2840}, 61 {item:2841} and 2 {item:2842} to gather or buy."] = "中级将技能上限从 75 提高到 150，费用为 5 银币（经典旧世价格；数据中没有无限服的价格）；需要 {skill:202} 50 和角色等级 10，因此达到 50 后，任意一次来访都可学习。并非所有 {skill:202} 训练师都教授：联盟为 {npc:8736}（{zone:1446}）、{npc:1676}（{zone:1431}）、{npc:5518}（{zone:1453}）、{npc:5174}（{zone:1455}）和 {npc:11029}（{zone:1455}）；部落为 {npc:8736}（{zone:1446}）、{npc:11031}（{zone:1458}）、{npc:3412}（{zone:1454}）和罗克希克（{zone:1454}）。箭头会指向你所属阵营最近的一位。现在学习：{spell:3929}（技能 75 起，2 银币 50 铜币）和 {spell:3930}（技能 75 起，2 银币 50 铜币）。75-150 阶段约需 5 银币的配方和 45 银币的商人材料，另需采集或购买 15 个 {item:2836}、27 个 {item:2838}、72 个 {item:2840}、61 个 {item:2841} 和 2 个 {item:2842}。",

	-- Step 16: Engineering 75-150: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 75-150: vendor goods"] = "{skill:202} 75–150：商人材料",
	-- {item:2880} Weak Flux · {zone:1453} Stormwind City · {npc:5519} Billibub Cogspinner · {npc:5514} Brooke Stonebraid · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 45 {item:2880} (45s); about 45s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5519}, {npc:5514} and {npc:1286}; {zone:1454}: {npc:3367}, Gorina and {npc:5817})."] = "一次买齐整个阶段的用量：45个{item:2880}（45银）；合计约45银。箭头会选择本阵营最近的商人（{zone:1453}：{npc:5519}、{npc:5514}和{npc:1286}；{zone:1454}：{npc:3367}、高里纳和{npc:5817}）。",

	-- Step 17: Coarse Stone (Westfall)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1436} Westfall
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1436} is marked."] = "准备 15 个 {item:2836}，用于 {spell:3930}：通过 {skill:186} 开采 {object:1732}（技能 65），或在拍卖行购买。已标记 {zone:1436} 中 {object:1732} 最密集的区域。",

	-- Step 18: Coarse Stone (Loch Modan)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1432} is marked."] = "准备 15 个 {item:2836}，用于 {spell:3930}：通过 {skill:186} 开采 {object:1732}（技能 65），或在拍卖行购买。已标记 {zone:1432} 中 {object:1732} 最密集的区域。",

	-- Step 19: Coarse Stone (Darkshore)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1439} Darkshore
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1439} is marked."] = "准备 15 个 {item:2836}，用于 {spell:3930}：通过 {skill:186} 开采 {object:1732}（技能 65），或在拍卖行购买。已标记 {zone:1439} 中 {object:1732} 最密集的区域。",

	-- Step 20: Coarse Stone (The Barrens)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1413} is marked."] = "准备 15 个 {item:2836}，用于 {spell:3930}：通过 {skill:186} 开采 {object:1732}（技能 65），或在拍卖行购买。已标记 {zone:1413} 中 {object:1732} 最密集的区域。",

	-- Step 21: Coarse Stone (Silverpine Forest)
	-- {item:2836} Coarse Stone · {spell:3930} Crafted Heavy Shot · {skill:186} Mining · {object:1732} Tin Vein · {zone:1421} Silverpine Forest
	["15 {item:2836} for {spell:3930}: {skill:186}: {object:1732} (skill 65); or the Auction House. The densest cluster of {object:1732} in {zone:1421} is marked."] = "准备 15 个 {item:2836}，用于 {spell:3930}：通过 {skill:186} 开采 {object:1732}（技能 65），或在拍卖行购买。已标记 {zone:1421} 中 {object:1732} 最密集的区域。",

	-- Step 22: Heavy Stone (Arathi Highlands)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "准备 27 个 {item:2838}，用于 {spell:3945}：通过 {skill:186} 开采 {object:1735}（技能 125），或在拍卖行购买。已标记 {zone:1417} 中 {object:1735} 最密集的区域。",

	-- Step 23: Heavy Stone (Ashenvale)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1440} Ashenvale
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1440} is marked."] = "准备 27 个 {item:2838}，用于 {spell:3945}：通过 {skill:186} 开采 {object:1735}（技能 125），或在拍卖行购买。已标记 {zone:1440} 中 {object:1735} 最密集的区域。",

	-- Step 24: Heavy Stone (The Barrens)
	-- {item:2838} Heavy Stone · {spell:3945} Heavy Blasting Powder · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1413} The Barrens
	["27 {item:2838} for {spell:3945}: {skill:186}: {object:1735} (skill 125); or the Auction House. The densest cluster of {object:1735} in {zone:1413} is marked."] = "准备 27 个 {item:2838}，用于 {spell:3945}：通过 {skill:186} 开采 {object:1735}（技能 125），或在拍卖行购买。已标记 {zone:1413} 中 {object:1735} 最密集的区域。",

	-- Step 26: Crafted Heavy Shot to 94
	-- {spell:3930} Crafted Heavy Shot
	["{spell:3930} to 94"] = "制作{spell:3930}，提升至 94",
	-- {spell:3930} Crafted Heavy Shot · {spell:3929} Coarse Blasting Powder · {item:2840} Copper Bar · {skill:186} Mining · {item:2770} Copper Ore
	["{spell:3930} is orange at 75 (yellow 85, green 90, grey 95): about 15 crafts to 94. Each takes 1 {spell:3929} and 1 {item:2840} and makes 200. Make the 15 {spell:3929} first: it gives points too while not grey. The {spell:3929} in each gives its own point while it is not grey: two chances a craft. Sell the shot to hunters or a vendor. {item:2840} (72 for 75-150): {skill:186}: smelt {item:2770}; or the Auction House."] = "{spell:3930} 在技能75时为橙色（85变黄，90变绿，95变灰）：大约制作15次升到94。每次需要1份 {spell:3929} 和1块 {item:2840}，产出200发。先制作15份 {spell:3929}：只要尚未变灰，制作它也能涨点。每次所用的 {spell:3929} 在未变灰时也有自己的涨点机会：相当于每次有两次涨点机会。弹药可卖给猎人或商人。{item:2840}（75—150共需72块）：{skill:186}：熔炼 {item:2770}；或从拍卖行购买。",

	-- Step 27: Copper Tube to 100
	-- {spell:3924} Copper Tube
	["{spell:3924} to 100"] = "{spell:3924}练到100",
	-- {spell:3924} Copper Tube · {item:2840} Copper Bar · {item:2880} Weak Flux
	-- plural, as words: Copper Bars = {item:2840} Copper Bar
	["{spell:3924} is yellow at 94 (yellow 80, green 95, grey 110): about 14 crafts to 100. Each takes 2 {item:2840} and 1 {item:2880}. Two Copper Bars and a {item:2880} a craft (blacksmithing and engineering suppliers). Needs an anvil nearby."] = "{spell:3924} 在技能 94 时为黄色（80 变黄、95 变绿、110 变灰）：约制作 14 次可到 100。每次需要 2 个 {item:2840} 和 1 个 {item:2880}。即每次两块铜锭和一个 {item:2880}（由锻造和工程学供应商出售）。附近需要铁砧。",

	-- Step 28: Engineering recipes at 100
	-- {skill:202} Engineering
	["{skill:202} recipes at 100"] = "100点的{skill:202}配方",
	-- {skill:202} Engineering · {spell:8334} Practice Lock
	["Back to an {skill:202} trainer: {spell:8334} (from 100)."] = "返回{skill:202}训练师处，学习{spell:8334}（技能 100 起可学）。",

	-- Step 29: Practice Lock to 125
	-- {item:6712} Practice Lock
	["{item:6712} to 125"] = "制作{item:6712}，提升至 125",
	-- {item:6712} Practice Lock · {item:2841} Bronze Bar · {spell:3922} Handful of Copper Bolts · {item:2880} Weak Flux · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	-- plural, as words: Practice Locks = {item:6712} Practice Lock
	["{item:6712} is orange at 100 (yellow 115, green 122, grey 130): about 31 crafts to 125. Each takes 1 {item:2841}, 2 {spell:3922} and 1 {item:2880}. Make the 29 {spell:3922} first. Use the 33 {spell:3922} you made earlier; the counts above leave them out. Practice Locks sell to rogues, or open them yourself. Needs an anvil nearby. {item:2841} (61 for 75-150): {skill:186}: smelt {item:2840} and {item:3576}; or the Auction House."] = "{item:6712} 在技能 100 时为橙色（115 变黄、122 变绿、130 变灰）：约制作 31 次可升到 125。每次需要 1 个 {item:2841}、2 个 {spell:3922} 和 1 个 {item:2880}。先制作 29 个 {spell:3922}。同时用上先前制作的 33 个 {spell:3922}；上方材料数量未将它们计入。练习锁可以卖给潜行者，也可以自己打开。附近需要有铁砧。{item:2841}（75-150 阶段需 61 个）：通过 {skill:186} 熔炼 {item:2840} 和 {item:3576}，或在拍卖行购买。",

	-- Step 30: Engineering recipes at 125
	-- {skill:202} Engineering
	["{skill:202} recipes at 125"] = "{skill:202} 125 级配方",
	-- {skill:202} Engineering · {spell:3945} Heavy Blasting Powder
	["Back to an {skill:202} trainer: {spell:3945} (from 125)."] = "返回{skill:202}训练师处，学习{spell:3945}（技能 125 起可学）。",

	-- Step 31: Heavy Blasting Powder to 140
	-- {spell:3945} Heavy Blasting Powder
	["{spell:3945} to 140"] = "制作{spell:3945}，提升至 140",
	-- {spell:3945} Heavy Blasting Powder · {item:2838} Heavy Stone
	-- plural, as words: Iron Deposits = {object:1735} Iron Deposit · Iron Grenades = {item:4390} Iron Grenade
	["{spell:3945} is yellow at 125 (yellow 125, green 135, grey 145): about 27 crafts to 140. Each takes 1 {item:2838}. One {item:2838} a craft (Iron Deposits). Keep some: Iron Grenades take one each."] = "{spell:3945} 在技能 125 时为黄色（125 变黄、135 变绿、145 变灰）：约制作 27 次可到 140。每次需要 1 个 {item:2838}。即每次一个 {item:2838}（来自铁矿石）。留下一些：每颗铁皮手雷都要用一个。",

	-- Step 32: Engineering recipes at 140
	-- {skill:202} Engineering
	["{skill:202} recipes at 140"] = "{skill:202}：技能 140 时学习的配方",
	-- {skill:202} Engineering · {spell:3973} Silver Contact · {spell:3950} Big Bronze Bomb
	["Back to an {skill:202} trainer: {spell:3973} (from 90) and {spell:3950} (from 140)."] = "回到{skill:202}训练师处：学习{spell:3973}（90起）和{spell:3950}（140起）。",

	-- Step 33: Big Bronze Bomb to 150
	-- {spell:3950} Big Bronze Bomb
	["{spell:3950} to 150"] = "{spell:3950}练到150",
	-- {spell:3950} Big Bronze Bomb · {item:4377} Heavy Blasting Powder · {item:2841} Bronze Bar · {spell:3973} Silver Contact · {item:2842} Silver Bar · {skill:186} Mining · {item:2775} Silver Ore · {skill:202} Engineering
	["{spell:3950} is yellow at 140 (yellow 140, green 165, grey 190): about 10 crafts to 150. Each takes 2 {item:4377}, 3 {item:2841} and 1 {spell:3973} and makes 3. Make the 10 {spell:3973} (2 crafts) first. Use the 20 {item:4377} you made earlier; the counts above leave them out. The trainer teaches it, and it is the cheapest way through these points in the data. Needs an anvil nearby. {item:2842} (2 for 75-150): {skill:186}: smelt {item:2775}; or the Auction House. {skill:202} 150 is a Legacy System milestone."] = "{spell:3950}在技能140时为黄色（140变黄，165变绿，190变灰）：约制作10次可到150。每次需要2个{item:4377}、3个{item:2841}和1个{spell:3973}，产出3个。先制作10个{spell:3973}（制作2次）。用之前做好的20个{item:4377}；上方统计未将其计入。此配方向训练师学习，是数据中度过这段技能点最便宜的方式。附近需要有铁砧。{item:2842}（75-150需2个）：通过{skill:186}熔炼{item:2775}，或从拍卖行购买。{skill:202}150是传承系统的一个里程碑。",

	-- Step 34: Expert Engineering
	-- {skill:202} Engineering
	["Expert {skill:202}"] = "高级{skill:202}",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {zone:1454} Orgrimmar · {spell:9271} Aquadynamic Fish Attractor · {spell:3953} Bronze Framework · {item:2319} Medium Leather · {item:2592} Wool Cloth · {item:2836} Coarse Stone · {item:2838} Heavy Stone · {item:2841} Bronze Bar · {item:2842} Silver Bar · {item:3575} Iron Bar · {item:3860} Mithril Bar · {item:7912} Solid Stone
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}) and {npc:5174} ({zone:1455}); Horde {npc:8736} ({zone:1446}) and Roxxik ({zone:1454}). The arrow picks the nearest of your faction. Learn now: {spell:9271} (from 150) and {spell:3953} (from 145). 150-225 takes about 31s of vendor goods, plus 19 {item:2319}, 19 {item:2592}, 31 {item:2836}, 74 {item:2838}, 100 {item:2841}, 6 {item:2842}, 81 {item:3575}, 19 {item:3860} and 62 {item:7912} to gather or buy."] = "高级将技能上限从 150 提高到 225，费用为 50 银币（经典旧世价格；数据中没有无限服的价格）；需要 {skill:202} 125 和角色等级 20，因此达到 125 后，任意一次来访都可学习。只有少数训练师教授：联盟为 {npc:8736}（{zone:1446}）和 {npc:5174}（{zone:1455}）；部落为 {npc:8736}（{zone:1446}）和罗克希克（{zone:1454}）。箭头会指向你所属阵营最近的一位。现在学习：{spell:9271}（技能 150 起）和 {spell:3953}（技能 145 起）。150-225 阶段约需 31 银币的商人材料，另需采集或购买 19 个 {item:2319}、19 个 {item:2592}、31 个 {item:2836}、74 个 {item:2838}、100 个 {item:2841}、6 个 {item:2842}、81 个 {item:3575}、19 个 {item:3860} 和 62 个 {item:7912}。",

	-- Step 35: Engineering 150-225: vendor goods
	-- {skill:202} Engineering
	["{skill:202} 150-225: vendor goods"] = "{skill:202} 150–225：商人材料",
	-- {item:6530} Nightcrawlers · {zone:1453} Stormwind City · {npc:5494} Catherine Leland · {npc:1286} Edna Mullby · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3333} Shankys · {npc:5817} Shimra
	["Buy the whole bracket's share in one go: 31 {item:6530} (31s); about 31s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:5494} and {npc:1286}; {zone:1454}: {npc:3367}, {npc:3333} and {npc:5817})."] = "一次买齐整个阶段的用量：31个{item:6530}（31银）；合计约31银。箭头会选择本阵营最近的商人（{zone:1453}：{npc:5494}和{npc:1286}；{zone:1454}：{npc:3367}、{npc:3333}和{npc:5817}）。",

	-- Step 36: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319}（联盟）",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384} and {npc:2354} here (level 18-30); the {skill:393} guide routes this."] = "为 {spell:3953} 准备19张 {item:2319}：{skill:393}：剥取18—30级野兽；或从拍卖行购买。在这里剥取 {npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、钳嘴龟、{npc:2384} 和 {npc:2354}（18—30级）；{skill:393} 指南提供相应路线。",

	-- Step 37: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319}（部落）",
	-- {item:2319} Medium Leather · {spell:3953} Bronze Framework · {skill:393} Skinning · {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag
	["19 {item:2319} for {spell:3953}: {skill:393}: beasts of level 18-30; or the Auction House. Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811} and {npc:3817} here (level 18-30); the {skill:393} guide routes this."] = "为{spell:3953}准备19个{item:2319}：通过{skill:393}剥取18-30级野兽，或从拍卖行购买。在这里剥取{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}和{npc:3817}（18-30级）；{skill:393}指南提供了对应路线。",

	-- Step 38: Wool Cloth
	-- {item:2592} Wool Cloth · {spell:3953} Bronze Framework
	["19 {item:2592} for {spell:3953}: humanoids of level 15-30 drop it; or the Auction House. The arrow picks a farm spot for your level and faction."] = "为 {spell:3953} 准备19块 {item:2592}：15—30级人形生物会掉落；也可在拍卖行购买。箭头会根据你的等级和阵营选择一处刷取地点。",

	-- Step 39: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836}（联盟）",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1432} Loch Modan · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1432} (10-20), {zone:1440} (18-30) and {zone:1424} (20-30); or the Auction House. The densest cluster of {object:1732} in {zone:1432} is marked."] = "为 {item:6533} 准备31个 {item:2836}：{skill:186}：在 {zone:1432}（10—20级）、{zone:1440}（18—30级）和 {zone:1424}（20—30级）开采 {object:1732}（技能65）；也可在拍卖行购买。已标出 {zone:1432} 中 {object:1732} 最密集的矿点群。",

	-- Step 40: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836}（部落）",
	-- {item:2836} Coarse Stone · {item:6533} Aquadynamic Fish Attractor · {skill:186} Mining · {object:1732} Tin Vein · {zone:1413} The Barrens · {zone:1440} Ashenvale · {zone:1424} Hillsbrad Foothills
	["31 {item:2836} for {item:6533}: {skill:186}: {object:1732} (skill 65) in {zone:1413} (10-25), {zone:1440} (18-30) and {zone:1424} (20-30); or the Auction House. The densest cluster of {object:1732} in {zone:1440} is marked."] = "为 {item:6533} 准备 31 个 {item:2836}：通过 {skill:186} 开采 {zone:1413}（10-25 级）、{zone:1440}（18-30 级）和 {zone:1424}（20-30 级）的 {object:1732}（需要技能 65），或在拍卖行购买。已标记 {zone:1440} 中 {object:1732} 最密集的位置。",

	-- Step 41: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838}（联盟）",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {zone:1443} Desolace
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1417} (30-40), {zone:1434} (30-45) and {zone:1443} (30-40); or the Auction House. The densest cluster of {object:1735} in {zone:1417} is marked."] = "为 {spell:3967} 准备 74 个 {item:2838}：通过 {skill:186} 开采 {zone:1417}（30-40 级）、{zone:1434}（30-45 级）和 {zone:1443}（30-40 级）的 {object:1735}（需要技能 125），或在拍卖行购买。已标记 {zone:1417} 中 {object:1735} 最密集的位置。",

	-- Step 42: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838}（部落）",
	-- {item:2838} Heavy Stone · {spell:3967} Big Iron Bomb · {skill:186} Mining · {object:1735} Iron Deposit · {zone:1441} Thousand Needles · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale
	["74 {item:2838} for {spell:3967}: {skill:186}: {object:1735} (skill 125) in {zone:1441} (25-35), {zone:1417} (30-40) and {zone:1434} (30-45); or the Auction House. The densest cluster of {object:1735} in {zone:1441} is marked."] = "准备 74 个 {item:2838}，用于 {spell:3967}：通过 {skill:186} 开采 {object:1735}（技能 125），产地有 {zone:1441}（25-35 级）、{zone:1417}（30-40 级）和 {zone:1434}（30-45 级）；或在拍卖行购买。已标记 {zone:1441} 中 {object:1735} 最密集的区域。",

	-- Step 43: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912}（联盟）",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1434} Stranglethorn Vale · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1434} (30-45), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1434} is marked."] = "为 {item:10505} 准备62个 {item:7912}：{skill:186}：在 {zone:1434}（30—45级）、{zone:1425}（40—50级）和 {zone:1444}（40—50级）开采 {object:2040}（技能175）；也可在拍卖行购买。已标出 {zone:1434} 中 {object:2040} 最密集的矿点群。",

	-- Step 44: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912}（部落）",
	-- {item:7912} Solid Stone · {item:10505} Solid Blasting Powder · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["62 {item:7912} for {item:10505}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "为 {item:10505} 准备62块 {item:7912}：{skill:186}：开采 {zone:1443}（30—40级）、{zone:1425}（40—50级）和 {zone:1444}（40—50级）的 {object:2040}（技能175）；或从拍卖行购买。已标记 {zone:1443} 中 {object:2040} 最密集的区域。",

	-- Step 45: Aquadynamic Fish Attractor to 166
	-- {item:6533} Aquadynamic Fish Attractor
	["{item:6533} to 166"] = "制作{item:6533}，提升至 166",
	-- {item:6533} Aquadynamic Fish Attractor · {item:2841} Bronze Bar · {item:6530} Nightcrawlers · {spell:3929} Coarse Blasting Powder · {skill:186} Mining · {item:2840} Copper Bar · {item:3576} Tin Bar
	["{item:6533} is yellow at 150 (yellow 150, green 160, grey 170): about 31 crafts to 166. Each takes 2 {item:2841}, 1 {item:6530} and 1 {spell:3929} and makes 3. Make the 31 {spell:3929} first. {item:6530} come from trade and fishing suppliers; the attractors sell to fishermen. {item:2841} (100 for 150-225): {skill:186}: smelt {item:2840} and {item:3576}; or the Auction House."] = "{item:6533} 在技能150时为黄色（150变黄，160变绿，170变灰）：大约制作31次升到166。每次需要2块 {item:2841}、1个 {item:6530} 和1份 {spell:3929}，产出3个。先制作31份 {spell:3929}。{item:6530} 可向商贸或钓鱼供应商购买；制成的诱饵可卖给钓鱼玩家。{item:2841}（150—225共需100块）：{skill:186}：熔炼 {item:2840} 和 {item:3576}；或从拍卖行购买。",

	-- Step 46: Bronze Framework to 175
	-- {spell:3953} Bronze Framework
	["{spell:3953} to 175"] = "将{spell:3953}做到 175",
	-- {spell:3953} Bronze Framework · {item:2841} Bronze Bar · {item:2319} Medium Leather · {item:2592} Wool Cloth
	-- plural, as words: Bronze Frameworks = {spell:3953} Bronze Framework
	["{spell:3953} is yellow at 166 (yellow 145, green 170, grey 195): about 19 crafts to 175. Each takes 2 {item:2841}, 1 {item:2319} and 1 {item:2592}. Bronze Frameworks are parts for later gadgets; the extras sell to vendors."] = "{spell:3953}在技能166时为黄色（145变黄，170变绿，195变灰）：约制作19次可到175。每次需要2个{item:2841}、1个{item:2319}和1个{item:2592}。青铜框架是之后装置的零件；多余的可卖给商人。",

	-- Step 47: Engineering recipes at 175
	-- {skill:202} Engineering
	["{skill:202} recipes at 175"] = "{skill:202} 175 级配方",
	-- {skill:202} Engineering · {spell:12585} Solid Blasting Powder
	["Back to an {skill:202} trainer: {spell:12585} (from 175)."] = "返回{skill:202}训练师处，学习{spell:12585}（技能 175 起可学）。",

	-- Step 48: Solid Blasting Powder to 191
	-- {item:10505} Solid Blasting Powder
	["{item:10505} to 191"] = "制作{item:10505}，提升至 191",
	-- {item:10505} Solid Blasting Powder · {item:7912} Solid Stone
	-- plural, as words: Mithril Deposits = {object:2040} Mithril Deposit
	["{item:10505} is yellow at 175 (yellow 175, green 185, grey 195): about 31 crafts to 191. Each takes 2 {item:7912}. Two {item:7912} a craft (Mithril Deposits). Make plenty: the triggers, slugs and Gyro-Shot all use it."] = "{item:10505} 在技能175时为黄色（175变黄，185变绿，195变灰）：大约制作31次升到191。每次需要2块 {item:7912}。每次用两块 {item:7912}（来自秘银矿脉）。多做一些：扳机、弹头和 秘银螺旋弹 都要用到。",

	-- Step 49: Engineering recipes at 191
	-- {skill:202} Engineering
	["{skill:202} recipes at 191"] = "{skill:202}：技能 191 时学习的配方",
	-- {skill:202} Engineering · {spell:3967} Big Iron Bomb
	["Back to an {skill:202} trainer: {spell:3967} (from 190)."] = "返回{skill:202}训练师处，学习{spell:3967}（技能 190 起可学）。",

	-- Step 50: Big Iron Bomb to 210
	-- {spell:3967} Big Iron Bomb
	["{spell:3967} to 210"] = "制作{spell:3967}，提升至 210",
	-- {spell:3967} Big Iron Bomb · {item:3575} Iron Bar · {spell:3945} Heavy Blasting Powder · {spell:3973} Silver Contact · {item:2842} Silver Bar · {item:2838} Heavy Stone · {npc:5174} Springspindle Fizzlegear · {zone:1455} Ironforge · {npc:5518} Lilliam Sparkspindle · {zone:1453} Stormwind City · {npc:4586} Graham Van Talen · {zone:1458} Undercity · {area:392} Ratchet · {spell:20220} Gnomish Engineering · {npc:7944} Tinkmaster Overspark · {npc:7406} Oglethorpe Obnoticus · {area:35} Booty Bay · {item:4407} Accurate Scope · {npc:8126} Nixx Sprocketspring · {area:976} Gadgetzan · {item:10507} Solid Dynamite · {npc:2675} Explosive Sheep · {skill:186} Mining · {item:2775} Silver Ore · {item:2772} Iron Ore
	-- plural, as words: Silver Contacts = {spell:3973} Silver Contact · Mithril Tubes = {item:10559} Mithril Tube · Big Iron Bombs = {spell:3967} Big Iron Bomb
	["{spell:3967} is yellow at 191 (yellow 190, green 210, grey 230): about 27 crafts to 210. Each takes 3 {item:3575}, 3 {spell:3945} and 1 {spell:3973} and makes 2. Make the 74 {spell:3945} and 30 {spell:3973} (6 crafts) first. Use the 7 {spell:3945} you made earlier; the counts above leave them out. A {item:2842} makes five Silver Contacts (grey by now: no points, but no trip to a vendor either); the {spell:3945} comes from {item:2838}. Each craft makes two bombs. Specialisation (optional): at 200 and character level 30, {npc:5174} ({zone:1455}), {npc:5518} ({zone:1453}), {npc:4586} ({zone:1458}) or Tinkerwiz ({area:392}) sends you to {spell:20220} ({npc:7944}, {zone:1455}, or {npc:7406}, {area:35}: 6 Mithril Tubes, an {item:4407} and 2 Advanced Target Dummies) or Goblin Engineering ({npc:8126}, {area:976}: 20 Big Iron Bombs, 20 {item:10507} and 5 {npc:2675}). The {item:4407} schematic now binds when picked up, but the quest takes a scope someone else made. The membership card lasts 14 days of play; renewing it costs 2g. You can take only one; neither is needed for 300, and the beta never tested them (it stopped at level 30). Needs an anvil nearby. {item:2842} (6 for 150-225): {skill:186}: smelt {item:2775}; or the Auction House. {item:3575} (81 for 150-225): {skill:186}: smelt {item:2772}; or the Auction House."] = "{spell:3967} 在技能 191 时为黄色（190 变黄，210 变绿，230 变灰）：约制作 27 次可到 210。每次需要 3 个 {item:3575}、3 个 {spell:3945} 和 1 个 {spell:3973}，产出 2 个。先制作 74 个 {spell:3945} 和 30 个 {spell:3973}（制作 6 次）。用上之前做好的 7 个 {spell:3945}；上述数量未将它们计入。一个 {item:2842} 可制成五个银触媒（此时已变灰，不再加技能点，但也无需再跑商人）；{spell:3945} 用 {item:2838} 制作。每次制作产出两个炸弹。专精（可选）：技能达到 200 且角色等级 30 时，{npc:5174}（{zone:1455}）、{npc:5518}（{zone:1453}）、{npc:4586}（{zone:1458}）或廷克维斯（{area:392}）会指引你学习 {spell:20220}（找 {zone:1455} 的 {npc:7944}，或 {area:35} 的 {npc:7406}：需要 6 个秘银管、一个 {item:4407} 和 2 个高级假人）或地精工程学（找 {area:976} 的 {npc:8126}：需要 20 个大铁炸弹、20 个 {item:10507} 和 5 个 {npc:2675}）。{item:4407} 的设计图现为拾取后绑定，但任务接受他人制作的瞄准镜。会员卡有效期为 14 天游戏时间，续期需 2 金币。只能选择一种专精；冲到 300 都不需要它们，而且测试版从未测试过这两种专精（测试止于 30 级）。附近需要有铁砧。{item:2842}（150-225 阶段需 6 个）：通过 {skill:186} 熔炼 {item:2775}，或从拍卖行购买。{item:3575}（150-225 阶段需 81 个）：通过 {skill:186} 熔炼 {item:2772}，或从拍卖行购买。",

	-- Step 51: Engineering recipes at 210
	-- {skill:202} Engineering
	["{skill:202} recipes at 210"] = "{skill:202} 210 级配方",
	-- {skill:202} Engineering · {spell:12596} Hi-Impact Mithril Slugs
	["Back to an {skill:202} trainer: {spell:12596} (from 210)."] = "返回{skill:202}训练师处，学习{spell:12596}（技能 210 起可学）。",

	-- Step 52: Hi-Impact Mithril Slugs to 225
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 225"] = "将{item:10512}做到 225",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:186} Mining · {item:3858} Mithril Ore · {skill:202} Engineering
	["{item:10512} is yellow at 210 (yellow 210, green 230, grey 250): about 19 crafts to 225. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Use the 19 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {item:3860} (19 for 150-225): {skill:186}: smelt {item:3858}; or the Auction House. {skill:202} 225 is a Legacy System milestone."] = "{item:10512} 在210点时为黄色（210变黄，230变绿，250变灰）：制作约19次可到225。每次需要1块 {item:3860} 和1份 {item:10505}，产出200发。使用之前做好的19份 {item:10505}；上面的数量未包含它们。每次制作消耗一块 {item:3860} 和一份 {item:10505}；猎人会购买这些弹头。附近需要有铁砧。{item:3860}（150—225阶段需要19块）：{skill:186}：熔炼 {item:3858}；也可在拍卖行购买。{skill:202} 达到225是传承系统的一个里程碑。",

	-- Step 53: Artisan Engineering
	-- {skill:202} Engineering
	["Artisan {skill:202}"] = "专家级{skill:202}",
	-- {skill:202} Engineering · {npc:8736} Buzzek Bracketswing · {zone:1446} Tanaris · {item:3860} Mithril Bar · {item:7912} Solid Stone · {item:12359} Thorium Bar · {item:14047} Runecloth
	["Artisan raises the cap from 225 to 300 for 4g 50s (Classic's price; Forever's is not in the data); it needs {skill:202} 200 and character level 35, so you can take it on any visit from 200. Only a few trainers teach it: Alliance {npc:8736} ({zone:1446}); Horde {npc:8736} ({zone:1446}). The arrow picks the nearest of your faction. 225-300 takes about 2g 80s of recipes, plus 118 {item:3860}, 212 {item:7912}, 156 {item:12359} and 24 {item:14047} to gather or buy."] = "大师级技能将上限从225提高到300，费用4金币50银币（经典旧世价格；数据中没有无限服的价格）；需要 {skill:202} 200和角色35级，因此达到200后，随时拜访都能学习。只有少数训练师教授：联盟的 {npc:8736}（{zone:1446}）；部落的 {npc:8736}（{zone:1446}）。箭头会选择本阵营最近的一位。225—300阶段约需购买2金币80银币的配方，另外还需采集或购买118块 {item:3860}、212块 {item:7912}、156块 {item:12359} 和24块 {item:14047}。",

	-- Step 54: Schematic: Thorium Widget
	-- {item:16042} Schematic: Thorium Widget · {item:15994} Thorium Widget · {skill:202} Engineering · {npc:5175} Gearcutter Cogspinner · {zone:1455} Ironforge · {npc:3413} Sovik · {zone:1454} Orgrimmar
	["{item:16042} teaches {item:15994} ({skill:202} 260) for 1g 20s. Sold by Alliance: {npc:5175} ({zone:1455}), limited stock; Horde: {npc:3413} ({zone:1454}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too."] = "{item:16042} 可教会制作 {item:15994}（{skill:202} 260），售价 1 金 20 银。出售者：联盟 {npc:5175}（{zone:1455}），限量；部落 {npc:3413}（{zone:1454}），限量。商人通常只备一两份，售出一段时间后补货；拍卖行也经常有售。",

	-- Step 55: Schematic: Thorium Tube
	-- {item:16047} Schematic: Thorium Tube · {item:16000} Thorium Tube · {skill:202} Engineering · {npc:260565} Kor'gar · {zone:2548} Riverglades · {npc:11185} Xizzer Fizzbolt · {zone:1452} Winterspring
	["{item:16047} teaches {item:16000} ({skill:202} 275) for 1g 60s. Sold by Alliance: {npc:260565} ({zone:2548}) and {npc:11185} ({zone:1452}), limited stock; Horde: {npc:11185} ({zone:1452}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:16047}用于学习{item:16000}（需要{skill:202}275），售价1金60银。联盟出售者：{npc:260565}（{zone:2548}）和{npc:11185}（{zone:1452}），限量供应；部落出售者：{npc:11185}（{zone:1452}），限量供应。商人库存为1-2份，售出一段时间后才会补货；此图纸拾取绑定，拍卖行买不到。",

	-- Step 56: Solid Stone (Alliance)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55); or the Auction House. The densest cluster of {object:2040} in {zone:1425} is marked."] = "准备 212 个 {item:7912}，用于 {item:10512} 和 {item:10513}：通过 {skill:186} 开采 {object:2040}（技能 175），产地有 {zone:1425}（40-50 级）、{zone:1444}（40-50 级）和 {zone:1447}（45-55 级）；或在拍卖行购买。已标记 {zone:1425} 中 {object:2040} 最密集的区域。",

	-- Step 57: Solid Stone (Horde)
	-- {item:7912} Solid Stone · {item:10512} Hi-Impact Mithril Slugs · {item:10513} Mithril Gyro-Shot · {skill:186} Mining · {object:2040} Mithril Deposit · {zone:1443} Desolace · {zone:1425} The Hinterlands · {zone:1444} Feralas
	["212 {item:7912} for {item:10512} and {item:10513}: {skill:186}: {object:2040} (skill 175) in {zone:1443} (30-40), {zone:1425} (40-50) and {zone:1444} (40-50); or the Auction House. The densest cluster of {object:2040} in {zone:1443} is marked."] = "为{item:10512}和{item:10513}准备212个{item:7912}：通过{skill:186}在{zone:1443}（30-40级）、{zone:1425}（40-50级）和{zone:1444}（40-50级）开采{object:2040}（需要技能175），或从拍卖行购买。已标记{zone:1443}中{object:2040}最密集的区域。",

	-- Step 58: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047}（联盟）",
	-- {item:14047} Runecloth · {item:15994} Thorium Widget · {npc:7027} Blackrock Slayer
	["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:7027} (level 56-57) here."] = "为 {item:15994} 准备24块 {item:14047}：45—60级人形生物会掉落；也可在拍卖行购买。这里的 {npc:7027}（56—57级）会掉落。",

	-- Step 59: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047}（部落）",
	-- {item:14047} Runecloth · {item:15994} Thorium Widget · {npc:11880} Twilight Avenger
	["24 {item:14047} for {item:15994}: humanoids of level 45-60 drop it; or the Auction House. It drops from {npc:11880} (level 57-59) here."] = "准备 24 个 {item:14047}，用于 {item:15994}：45-60 级人型生物会掉落，或在拍卖行购买。这里的 {npc:11880}（57-59 级）会掉落。",

	-- Step 60: Hi-Impact Mithril Slugs to 245
	-- {item:10512} Hi-Impact Mithril Slugs
	["{item:10512} to 245"] = "将{item:10512}做到 245",
	-- {item:10512} Hi-Impact Mithril Slugs · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder · {skill:186} Mining · {item:3858} Mithril Ore
	["{item:10512} is yellow at 225 (yellow 210, green 230, grey 250): about 62 crafts to 245. Each takes 1 {item:3860} and 1 {item:10505} and makes 200. Make the 50 {item:10505} first. Use the 12 {item:10505} you made earlier; the counts above leave them out. One {item:3860} and one {item:10505} a craft; hunters buy the slugs. Needs an anvil nearby. {item:3860} (118 for 225-300): {skill:186}: smelt {item:3858}; or the Auction House."] = "{item:10512} 在225点时为黄色（210变黄，230变绿，250变灰）：制作约62次可到245。每次需要1块 {item:3860} 和1份 {item:10505}，产出200发。先制作50份 {item:10505}。使用之前做好的12份 {item:10505}；上面的数量未包含它们。每次制作消耗一块 {item:3860} 和一份 {item:10505}；猎人会购买这些弹头。附近需要有铁砧。{item:3860}（225—300阶段需要118块）：{skill:186}：熔炼 {item:3858}；也可在拍卖行购买。",

	-- Step 61: Engineering recipes at 245
	-- {skill:202} Engineering
	["{skill:202} recipes at 245"] = "{skill:202} 245 级配方",
	-- {skill:202} Engineering · {spell:12621} Mithril Gyro-Shot
	["Back to an {skill:202} trainer: {spell:12621} (from 245)."] = "返回{skill:202}训练师处，学习{spell:12621}（技能 245 起可学）。",

	-- Step 62: Mithril Gyro-Shot to 265
	-- {item:10513} Mithril Gyro-Shot
	["{item:10513} to 265"] = "制作{item:10513}，提升至 265",
	-- {item:10513} Mithril Gyro-Shot · {item:3860} Mithril Bar · {item:10505} Solid Blasting Powder
	-- plural, as words: Mithril Bars = {item:3860} Mithril Bar
	["{item:10513} is yellow at 245 (yellow 245, green 265, grey 285): about 28 crafts to 265. Each takes 2 {item:3860} and 2 {item:10505} and makes 200. Make the 56 {item:10505} first. Two Mithril Bars and two {item:10505} a craft. Needs an anvil nearby."] = "{item:10513} 在技能 245 时为黄色（245 变黄、265 变绿、285 变灰）：约制作 28 次可到 265。每次需要 2 个 {item:3860} 和 2 个 {item:10505}，产出 200 个。先制作 56 个 {item:10505}。即每次两块秘银锭和两个 {item:10505}。附近需要铁砧。",

	-- Step 63: Thorium Widget to 287
	-- {item:15994} Thorium Widget
	["{item:15994} to 287"] = "制作{item:15994}，提升至 287",
	-- {item:15994} Thorium Widget · {item:12359} Thorium Bar · {item:14047} Runecloth · {skill:186} Mining · {item:10620} Thorium Ore
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:15994} is orange at 265 (yellow 280, green 290, grey 300): about 24 crafts to 287. Each takes 3 {item:12359} and 1 {item:14047}. Three Thorium Bars and a {item:14047} a craft; the widgets are parts for the later Thorium gadgets. Needs an anvil nearby. {item:12359} (156 for 225-300): {skill:186}: smelt {item:10620}; or the Auction House."] = "{item:15994} 在技能 265 时为橙色（280 变黄、290 变绿、300 变灰）：约制作 24 次可升到 287。每次需要 3 个 {item:12359} 和 1 个 {item:14047}，即三块瑟银锭和一个 {item:14047}；这些零件用于后续的瑟银装置。附近需要有铁砧。{item:12359}（225-300 阶段需 156 个）：通过 {skill:186} 熔炼 {item:10620}，或在拍卖行购买。",
	["from the recipe in your bags"] = "使用背包里的配方",

	-- Step 64: Thorium Tube to 300
	-- {item:16000} Thorium Tube
	["{item:16000} to 300"] = "将{item:16000}做到 300",
	-- {item:16000} Thorium Tube · {item:12359} Thorium Bar · {skill:202} Engineering
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["{item:16000} is orange at 287 (yellow 295, green 305, grey 315): about 14 crafts to 300. Each takes 6 {item:12359}. The schematic binds when picked up; six Thorium Bars a craft. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "{item:16000} 在技能 287 时为橙色（295 变黄、305 变绿、315 变灰）：约制作 14 次可升到 300。每次需要 6 个 {item:12359}。结构图拾取后绑定；每次制作消耗六块瑟银锭。附近需要有铁砧。{skill:202} 达到 300 是传承系统的一个里程碑。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Apprentice {skill:202}"] = "初级{skill:202}",
	-- ["Artisan needs character level 35 and {skill:202} 200; it raises the cap to 300. Materials for 225-300 are worth about 67g in all."] = "专家级需要角色等级 35 且{skill:202}达到 200；会将上限提高到 300。225-300 的材料总价约 67 金币。",
	-- ["Back to an {skill:202} trainer: {spell:12585}, {spell:12596} are taught from {skill:202} 210."] = "回到{skill:202}训练师处：{spell:12585}、{spell:12596}在{skill:202} 210 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:12590} is taught from {skill:202} 175."] = "回到{skill:202}训练师处：{spell:12590}在{skill:202} 175 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:12621} is taught from {skill:202} 245."] = "回到{skill:202}训练师处：{spell:12621}在{skill:202} 245 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:3922} is taught from {skill:202} 45."] = "回到{skill:202}训练师处：{spell:3922}在{skill:202} 45 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:3923} is taught from {skill:202} 60."] = "回到{skill:202}训练师处：{spell:3923}在{skill:202} 60 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:3924} is taught from {skill:202} 80."] = "回到{skill:202}训练师处：{spell:3924}在{skill:202} 80 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:3926} is taught from {skill:202} 95."] = "回到{skill:202}训练师处：{spell:3926}在{skill:202} 95 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:3929} is taught from {skill:202} 85."] = "回到{skill:202}训练师处：{spell:3929}在{skill:202} 85 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:3937} is taught from {skill:202} 105."] = "回到{skill:202}训练师处：{spell:3937}在{skill:202} 105 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:3942} is taught from {skill:202} 125."] = "回到{skill:202}训练师处：{spell:3942}在{skill:202} 125 时可学。",
	-- ["Back to an {skill:202} trainer: {spell:3945} is taught from {skill:202} 125."] = "回到{skill:202}训练师处：{spell:3945}在{skill:202} 125 时可学。",
	-- ["Expert needs character level 20 and {skill:202} 125; it raises the cap to 225. Materials for 150-225 are worth about 15g in all."] = "高级需要角色等级 20 且{skill:202}达到 125；会将上限提高到 225。150-225 的材料总价约 15 金币。",
	-- ["Journeyman needs character level 10 and {skill:202} 50; it raises the cap to 150. Materials for 75-150 are worth about 3g 23s in all."] = "中级需要角色等级 10 且{skill:202}达到 50；会将上限提高到 150。75-150 的材料总价约 3 金币 23 银币。",
	-- ["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "在 Polestar 按你的等级和阵营选出的刷材料地点击杀掉落它的怪物。也可以去拍卖行购买。",
	-- ["Orange (a point every craft) until 20, yellow until 30, green until 40."] = "20 前为橙色（每次制造都加点），30 前为黄色，40 前为绿色。",
	-- ["Orange (a point every craft) until 280, yellow until 290, green until 300. Needs an anvil nearby."] = "280 前为橙色（每次制造都加点），290 前为黄色，300 前为绿色。需要在铁砧附近。",
	-- ["Orange (a point every craft) until 295, yellow until 305, green until 315. Needs an anvil nearby. {skill:202} 300 is a Legacy System milestone."] = "295 前为橙色（每次制造都加点），305 前为黄色，315 前为绿色。需要在铁砧附近。{skill:202} 300 是传承系统的里程碑。",
	-- ["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里对{npc:2248}、{npc:2356}、{npc:2385}、{npc:2351}、钳嘴龟、{npc:2384}、{npc:2354}剥皮（18-30 级的野兽会产出它）；{skill:393}指南有相应路线。也可以去拍卖行购买。",
	-- ["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "在这里对{npc:3809}、{npc:3810}、{npc:3818}、{npc:3823}、{npc:3811}、{npc:3817}剥皮（18-30 级的野兽会产出它）；{skill:393}指南有相应路线。也可以去拍卖行购买。",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "剥皮、分解或其他专业制造所得：自己收集，或在拍卖行购买。",
	-- ["Teaches {item:15994} (needs {skill:202} 260). Vendors sell it in limited stock that restocks; the Auction House often has it too."] = "学会{item:15994}（需要{skill:202} 260）。商人限量出售并会补货；拍卖行也常有。",
	-- ["Teaches {item:16000} (needs {skill:202} 275). Vendors sell it in limited stock that restocks."] = "学会{item:16000}（需要{skill:202} 275）。商人限量出售并会补货。",
	-- ["Yellow until 110, green until 125: not every craft gives a point. Needs an anvil nearby."] = "110 前为黄色，125 前为绿色：不是每次制造都加点。需要在铁砧附近。",
	-- ["Yellow until 130, green until 155: not every craft gives a point. Needs an anvil nearby."] = "130 前为黄色，155 前为绿色：不是每次制造都加点。需要在铁砧附近。",
	-- ["Yellow until 135, green until 145: not every craft gives a point."] = "135 前为黄色，145 前为绿色：不是每次制造都加点。",
	-- ["Yellow until 150, green until 175: not every craft gives a point. Needs an anvil nearby. {skill:202} 150 is a Legacy System milestone."] = "150 前为黄色，175 前为绿色：不是每次制造都加点。需要在铁砧附近。{skill:202} 150 是传承系统的里程碑。",
	-- ["Yellow until 170, green until 195: not every craft gives a point."] = "170 前为黄色，195 前为绿色：不是每次制造都加点。",
	-- ["Yellow until 195, green until 215: not every craft gives a point. Needs an anvil nearby."] = "195 前为黄色，215 前为绿色：不是每次制造都加点。需要在铁砧附近。",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby."] = "230 前为黄色，250 前为绿色：不是每次制造都加点。需要在铁砧附近。",
	-- ["Yellow until 230, green until 250: not every craft gives a point. Needs an anvil nearby. {skill:202} 225 is a Legacy System milestone."] = "230 前为黄色，250 前为绿色：不是每次制造都加点。需要在铁砧附近。{skill:202} 225 是传承系统的里程碑。",
	-- ["Yellow until 265, green until 285: not every craft gives a point. Needs an anvil nearby."] = "265 前为黄色，285 前为绿色：不是每次制造都加点。需要在铁砧附近。",
	-- ["Yellow until 45, green until 60: not every craft gives a point."] = "45 前为黄色，60 前为绿色：不是每次制造都加点。",
	-- ["Yellow until 52, green until 60: not every craft gives a point. Needs an anvil nearby."] = "52 前为黄色，60 前为绿色：不是每次制造都加点。需要在铁砧附近。",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby."] = "75 前为黄色，90 前为绿色：不是每次制造都加点。需要在铁砧附近。",
	-- ["Yellow until 75, green until 90: not every craft gives a point. Needs an anvil nearby. 75 is the Apprentice cap."] = "75 前为黄色，90 前为绿色：不是每次制造都加点。需要在铁砧附近。75 是初级上限。",
	-- ["Yellow until 90, green until 95: not every craft gives a point."] = "90 前为黄色，95 前为绿色：不是每次制造都加点。",
	-- ["Yellow until 95, green until 110: not every craft gives a point. Needs an anvil nearby."] = "95 前为黄色，110 前为绿色：不是每次制造都加点。需要在铁砧附近。",
	-- ["{item:10498} to 210"] = "将{item:10498}做到 210",
	-- ["{item:10513} to 264"] = "将{item:10513}做到 264",
	-- ["{item:15994} to 288"] = "将{item:15994}做到 288",
	-- ["{item:2592} (Alliance)"] = "{item:2592}（联盟）",
	-- ["{item:2592} (Horde)"] = "{item:2592}（部落）",
	-- ["{item:2835} (Alliance)"] = "{item:2835}（联盟）",
	-- ["{item:2835} (Horde)"] = "{item:2835}（部落）",
	-- ["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835}来自{object:1731}（{skill:186}）；这里是数据中最密集的矿点。也可以去拍卖行购买。",
	-- ["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836}来自{object:1732}（{skill:186}）；这里是数据中最密集的矿点。也可以去拍卖行购买。",
	-- ["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838}来自{object:1735}（{skill:186}）；这里是数据中最密集的矿点。也可以去拍卖行购买。",
	-- ["{item:5956}: a tool, keep it in your bags"] = "{item:5956}：工具，放在背包里",
	-- ["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912}来自{object:2040}（{skill:186}）；这里是数据中最密集的矿点。也可以去拍卖行购买。",
	-- ["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "这里的{npc:3263}（等级 19-20）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "这里的{npc:6189}（等级 51-52）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "这里的{npc:7027}（等级 56-57）会掉落它。也可以去拍卖行购买。",
	-- ["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "这里的{npc:98}（等级 17-18）会掉落它。也可以去拍卖行购买。",
	-- ["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}：熔炼{item:10620}（或去拍卖行购买）",
	-- ["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}：熔炼{item:2770}（或去拍卖行购买）",
	-- ["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}：熔炼{item:2840}（或去拍卖行购买）",
	-- ["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}：熔炼{item:3575}（或去拍卖行购买）",
	-- ["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}：熔炼{item:3858}（或去拍卖行购买）",
	-- ["{skill:202} materials for 1-75"] = "{skill:202} 1-75 所需材料",
	-- ["{skill:202} materials for 150-225"] = "{skill:202} 150-225 所需材料",
	-- ["{skill:202} materials for 225-300"] = "{skill:202} 225-300 所需材料",
	-- ["{skill:202} materials for 75-150"] = "{skill:202} 75-150 所需材料",
	-- ["{skill:202} recipes at 111"] = "{skill:202} 111 级配方",
	-- ["{skill:202} recipes at 139"] = "{skill:202} 139 级配方",
	-- ["{skill:202} recipes at 45"] = "{skill:202} 45 级配方",
	-- ["{skill:202} recipes at 60"] = "{skill:202} 60 级配方",
	-- ["{skill:202} recipes at 80"] = "{skill:202} 80 级配方",
	-- ["{skill:202} recipes at 85"] = "{skill:202} 85 级配方",
	-- ["{skill:202} recipes at 95"] = "{skill:202} 95 级配方",
	-- ["{skill:202} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 62s in all."] = "{skill:202}可以边升级边练。Forever 的传承系统会在制造专业技能达到 150、225 和 300（中级、高级和专家级的上限）时给予奖励，所以每个节点都很重要。1-75 的材料总价约 62 银币。",
	-- ["{spell:3918} to 37"] = "将{spell:3918}做到 37",
	-- ["{spell:3920} to 45"] = "将{spell:3920}做到 45",
	-- ["{spell:3922} to 60"] = "将{spell:3922}做到 60",
	-- ["{spell:3923} to 75"] = "将{spell:3923}做到 75",
	-- ["{spell:3923} to 80"] = "将{spell:3923}做到 80",
	-- ["{spell:3924} to 85"] = "将{spell:3924}做到 85",
	-- ["{spell:3926} to 111"] = "将{spell:3926}做到 111",
	-- ["{spell:3929} to 95"] = "将{spell:3929}做到 95",
	-- ["{spell:3937} to 125"] = "将{spell:3937}做到 125",
	-- ["{spell:3942} to 150"] = "将{spell:3942}做到 150",
	-- ["{spell:3945} to 139"] = "将{spell:3945}做到 139",
}
