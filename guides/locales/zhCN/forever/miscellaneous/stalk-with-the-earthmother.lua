-- Chinese (simplified) (zhCN): the guide forever/miscellaneous/stalk-with-the-earthmother (forever/miscellaneous/stalk-with-the-earthmother.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff
	["A one-hand blade or mace at 11 from {npc:205729}'s three tests in and around {zone:1456}, for a Tauren of any class."] = "11级时完成{npc:205729}在{zone:1456}内外的三项考验，可获得一把单手剑或单手锤，适合任何职业的牛头人。",

	-- Step 1: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206159} Venture Co Disguise · {npc:3051} Supervisor Fizsprocket
	-- plural, as words: Venture Co. Workers = {npc:2978} Venture Co. Worker
	["{npc:205729} hides in stealth on the main mesa of {zone:1456}, south of its pool: walk to where the arrow points until his outline shows. He hands you the {item:206159}. The quest opens at level 4, but the mine holds Venture Co. Workers (level 8-9), Supervisors (9-10) and {npc:3051} (12): go at 9 or 10."] = "{npc:205729}潜行在{zone:1456}主台地上、水池南边：走到箭头所指的位置，直到他的轮廓显现。他会交给你{item:206159}。任务4级即可接，但矿洞里有风险投资公司工人（8-9级）、监工（9-10级）和{npc:3051}（12级）：建议9或10级再去。",

	-- Step 2: The Venture Co. Mine
	-- {zone:1412} Mulgore · {area:360} The Venture Co. Mine · {object:403041} Blasting Supplies (no name in this language: may be words)
	["Ride down the lift and south-east across {zone:1412} to the {area:360}. Put on the disguise, then open the carts of {object:403041} inside the mine and on the slope outside it; stay on the upper levels where you can, the lower tunnels are packed. Five charges."] = "",
	-- {item:206157} Seaforium Mining Charge · {object:403041} Blasting Supplies (no name in this language: may be words)
	["{item:206157}, from the {object:403041}"] = "",

	-- Step 3: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	["Back to {npc:205729} in {zone:1456}. He gives you the {item:206176} for his next test."] = "回到 {zone:1456} 找 {npc:205729}。他会给你 {item:206176}，用于下一项考验。",

	-- Step 4: Windfury Cones
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones"] = "风怒球果",
	-- {area:819} Windfury Ridge · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones lie on the ground under the harpies' nest trees on {area:819}, north-west of {zone:1456}; the harpies do not drop them. The Windfury Sorceresses (level 9-10) and Matriarchs (10-11) there stand close together: pick the cones from the edges. Once you have eight, use the {item:206176} to grind them."] = "风怒球果 散落在{zone:1456}西北面{area:819}的鹰身人巢树下；鹰身人不会掉落。当地的风怒女巫（9-10级）和族母（10-11级）站得很密：从边缘拾取松果。收集8个后，使用{item:206176}研磨。",
	["the mortar takes all eight"] = "",
	-- {item:206175} Pine Salve
	["grind the eight cones into the {item:206175}"] = "",

	-- Step 5: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:206344} Knife Set
	["Back to {npc:205729}. He hands you the {item:206344} for the last test."] = "",

	-- Step 6: Raw Brilliant Smallfish
	-- {item:6291} Raw Brilliant Smallfish · {npc:8674} Auctioneer Stampi · {npc:3028} Kah Mistrunner · {skill:356} Fishing · {npc:3029} Sewa Mistrunner · {item:6256} Fishing Pole · {item:6529} Shiny Bauble · {item:206344} Knife Set
	["Buy a {item:6291} at the Auction House ({npc:8674}, north of the pool), or fish one yourself: {npc:3028} trains {skill:356} and {npc:3029} beside him sells the {item:6256} and a {item:6529}; the pool on the main mesa gives smallfish at any skill. Then use the {item:206344} on it, wherever you are."] = "",
	-- {item:6291} Raw Brilliant Smallfish
	["{item:6291}: the Auction House, or the pool; the knife takes it"] = "",
	-- {item:206345} Fish Chunks · {npc:205729} Boarton Shadetotem
	["fillet the smallfish into {item:206345} (where players did it, on the way back to {npc:205729})"] = "",

	-- Step 7: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:277988} Hoof-Holstered Blade · {item:278002} Valley Cosh
	["Take your weapon from {npc:205729}: the {item:277988} or the {item:278002}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:205729}. He hands you the {item:206344}: the fish must be filleted in front of him."] = "回到{npc:205729}处。他会给你{item:206344}：必须在他面前把鱼切成鱼片。",
	-- ["Buy a {item:6291} at the Auction House ({npc:8674}, north of the pool), or fish one yourself: {npc:3028} trains {skill:356} and {npc:3029} beside him sells the {item:6256} and a {item:6529}; the pool on the main mesa gives smallfish at any skill."] = "在拍卖行购买一条 {item:6291}（找水池北边的 {npc:8674}），也可以自己钓：{npc:3028} 教授 {skill:356}，身旁的 {npc:3029} 出售 {item:6256} 和 {item:6529}；主台地的水池在任何技能等级都能钓到小鱼。",
	-- ["Loot 5 Seaforium Mining Charges from the {object:403041}"] = "从{object:403041}中拾取5枚塞弗拉姆采矿炸药",
	-- ["Ride down the lift and south-east across {zone:1412} to the {area:360}. Put on the disguise, then open the carts of {object:403041} inside the mine and on the slope outside its far side; stay on the upper levels where you can, the lower tunnels are packed. Five charges."] = "乘升降梯下去，向东南穿过{zone:1412}前往{area:360}。穿上伪装，然后打开矿洞内以及矿洞远端外侧斜坡上的{object:403041}；尽量待在上层，下层隧道怪物密集。共需五枚炸药。",
	-- ["Stand beside {npc:205729} and use the {item:206344} on the smallfish: it only counts next to him. Then take your weapon: the {item:277988} or the {item:278002}."] = "站在 {npc:205729} 身旁，对小鱼使用 {item:206344}：只有在他旁边才算完成。然后领取武器：{item:277988} 或 {item:278002}。",
	-- ["Venture Co. Mine"] = "风险投资公司矿洞",
	-- ["grind the eight cones"] = "研磨8个松果",
	-- ["in front of {npc:205729}"] = "在 {npc:205729} 前面。",
	-- ["{item:6291}: the Auction House, or the pool"] = "{item:6291}：从拍卖行购买，或在水池钓取",
}
