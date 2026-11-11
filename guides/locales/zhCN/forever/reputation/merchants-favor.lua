-- Chinese (simplified) (zhCN): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Supply Factions Reputation"] = "补给阵营声望",
	-- {npc:10636} Pack Kodo
	["Forever's trade camps: their best recipes, the Minimule and the {npc:10636} need standing, not only Merchant's Favor."] = "无限的贸易营地：最好的配方、迷你骡子和{npc:10636}需要声望等级，而不仅仅是商人青睐。",
	["Profession recipes at Friendly and Honored"] = "友善和尊敬时的专业配方",

	-- Step 1: Your first Waylaid Crate or writ
	-- {item:248549} Waylaid Crate
	["Your first {item:248549} or writ"] = "你的第一个{item:248549}或文书",
	-- {quest:98247} Shipping Label
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["From level 10, mobs anywhere drop Waylaid Crates and sealed writs (Journeyman's, Expert's and Artisan's). Fill a crate with one of the bundles it lists (right-click it), or open a sealed writ: by beta reports, the first time you do either you also get a {quest:98247}. Right-click the label to start its quest. Crates and writs can be traded, so the Auction House sells them too."] = "从 10 级起，任何地方的怪物都可能掉落遭劫的板条箱和密封文书（中级、高级和大师级）。按箱子列出的选项装入一批物资（右键点击箱子），或打开一份密封文书：据测试版报告，首次进行其中任意一种操作时，还会获得 {quest:98247}。右键点击标签可开始其任务。板条箱和文书可以交易，因此拍卖行也有出售。",

	-- Step 2: Three Corners: the Shipping Label
	-- {area:1002} Three Corners · {quest:98247} Shipping Label
	["{area:1002}: the {quest:98247}"] = "{area:1002}：{quest:98247}",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood · {area:69} Lakeshire · {npc:256390} Marcy Baker
	["The {faction:2586} camp is at {area:1002}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet in western Redridge. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256390} too, but they pay only Merchant's Favor and silver, never reputation."] = "{faction:2586} 的营地位于赤脊山西部的 {area:1002}，{zone:1429}、{zone:1431} 和 {area:69} 来的道路在此交会。标签一次性提供2000声望（据测试反馈还给50点商人青睐）：已完成到友善所需进度的三分之二。装满的箱子也交给 {npc:256390}，但只奖励商人青睐和银币，绝不提供声望。",

	-- Step 3: The Crossroads camp: the Shipping Label
	-- {area:380} The Crossroads · {quest:98248} Shipping Label
	["{area:380} camp: the {quest:98248}"] = "{area:380} 营地：{quest:98248}",
	-- {faction:2587} Durotar Supply and Logistics · {npc:256386} Dokimi
	["The {faction:2587} camp stands just outside the west gate of the Crossroads. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256386} too, but they pay only Merchant's Favor and silver, never reputation."] = "{faction:2587}的营地就在十字路口西门外。货运标签可一次性获得2000声望（据测试服反馈，还会获得50 Merchant's Favor），达到友善所需声望的三分之二。装满的箱子也交给{npc:256386}，但只奖励Merchant's Favor和银币，不给声望。",

	-- Step 4: Gather your writs
	["Gather your writs"] = "收集你的文书。",
	["Craftsman's Writs are the camp's reputation: 75 for a Journeyman writ, 125 for an Expert, 200 for an Artisan. Each asks for one crafted item, the one its title names. Make it or buy it on the Auction House; you need not know the profession. Each writ can be done once a day, and any number of different ones. Take the quest only of writs whose item you have or will buy on the way (right-click the writ), keep the writ in your bags, then tick this: the next steps lead to each customer you hold a writ for."] = "",
	["Take the quests of the writs you can fill"] = "接受你能完成的文书任务",

	-- Step 5: Duskwood writ customers
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers"] = "{zone:1431}的文书委托人",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}. Customers show no quest mark: right-click them anyway."] = "{npc:3134} 站在 {area:42} 以北约450码处。顾客头顶没有任务标记：仍然右键点击他们。",
	-- {item:6048} Shadow Protection Potion
	["{item:6048}, 75 reputation"] = "{item:6048}，75 点声望",
	-- {item:4381} Minor Recombobulator
	["{item:4381}, 75 reputation"] = "{item:4381}，75 点声望",
	-- {item:2317} Dark Leather Tunic
	["{item:2317}, 75 reputation"] = "{item:2317}，75 点声望",
	-- {item:4245} Small Silk Pack
	["{item:4245}, 75 reputation"] = "{item:4245}，75 点声望",

	-- Step 6: Stranglethorn Vale writ customers
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers"] = "{zone:1434}的文书委托人",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {area:1741} Gurubashi Arena · {object:3202} Grom'gol · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853}, the goblin transporter's engineer, and {npc:2663}. {npc:14508} stands at the {area:1741}, about 800 yards south of {object:3202}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35}有三位顾客：“海狼”马金利（在旅店顶层）、地精传送器的工程师{npc:7853}，以及{npc:2663}。{npc:14508}站在{area:1741}，位于{object:3202}以南约800码处；{npc:261961}在荆棘谷北部。顾客头上没有任务标记：照样右键点击他们。",
	-- {item:3485} Green Iron Gauntlets
	["{item:3485}, 75 reputation"] = "{item:3485}，75 点声望",
	-- {item:7506} Gnomish Universal Remote
	["{item:7506}, 75 reputation"] = "{item:7506}，75 点声望",
	-- {item:4252} Dark Leather Shoulders
	["{item:4252}, 75 reputation"] = "{item:4252}，75 点声望",
	-- {item:3388} Lesser Troll's Blood Elixir
	["{item:3388}, 75 reputation"] = "",
	-- {item:10048} Colorful Kilt
	["{item:10048}, 75 reputation"] = "{item:10048}，75 点声望",

	-- Step 7: Wetlands writ customers
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers"] = "{zone:1437}的文书委托人",
	-- {npc:8305} Kixxle · {area:205} Dun Modr
	["{npc:8305} stands about 600 yards south of {area:205}. Five Journeyman writs go to him: the most of any customer. Customers show no quest mark: right-click them anyway."] = "{npc:8305}站在{area:205}以南约600码处。有5种中级文书要交给他，是所有客户中最多的。客户不会显示任务标记：直接右键点击即可。",
	-- {item:5996} Draught of Water Breathing
	["{item:5996}, 75 reputation"] = "",
	-- {item:3484} Green Iron Boots
	["{item:3484}, 75 reputation"] = "{item:3484}，75 点声望",
	-- {item:8069} Crafted Solid Shot
	["{item:8069}, 75 reputation"] = "{item:8069}，75 点声望",
	-- {item:7284} Red Whelp Gloves
	["{item:7284}, 75 reputation"] = "{item:7284}，75 点声望",
	-- {item:4321} Spider Silk Slippers
	["{item:4321}, 75 reputation"] = "{item:4321}，75 点声望",

	-- Step 8: Arathi Highlands writ customers
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers"] = "{zone:1417}的文书委托人",
	-- {npc:257296} Muggol Breezebeard · {area:320} Refuge Pointe · {npc:257304} Alyce
	["{npc:257296} is about 250 yards south of {area:320}, {npc:257304} about 700 yards north-west of it. Customers show no quest mark: right-click them anyway."] = "{npc:257296} 位于 {area:320} 以南约 250 码，{npc:257304} 位于其西北约 700 码。顾客头上没有任务标记：直接右键交谈。",
	-- {item:3383} Elixir of Wisdom
	["{item:3383}, 75 reputation"] = "{item:3383}，75 点声望",
	-- {item:11128} Golden Rod
	["{item:11128}, 75 reputation"] = "{item:11128}，75 点声望",
	-- {npc:789} Kimberly Hiett · {area:69} Lakeshire
	["bring it: engineers make it; {npc:789} in {area:69} lists it (not yet seen in her window up to level 30), or the Auction House"] = "",
	-- {item:4384} Explosive Sheep
	["{item:4384}, 75 reputation"] = "{item:4384}，75 点声望",
	-- {item:5958} Fine Leather Pants
	["{item:5958}, 75 reputation"] = "{item:5958}，75 点声望",
	-- {item:6263} Blue Overalls
	["{item:6263}, 75 reputation"] = "{item:6263}，75 点声望",

	-- Step 9: Hillsbrad Foothills writ customers
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers"] = "{zone:1424}的文书委托人",
	-- {npc:261932} Gorgrash · {npc:3536} Kris Legace · {npc:261928} Webbed Mudsnout Gnoll · {area:271} Southshore
	["{npc:261932} and {npc:3536} are in the east of the foothills; the {npc:261928} hangs in a spider cocoon about 500 yards south-east of {area:271}. Customers show no quest mark: right-click them anyway."] = "{npc:261932} 和 {npc:3536} 位于丘陵东部；{npc:261928} 被吊在 {area:271} 东南约 500 码处的蜘蛛茧里。顾客头上没有任务标记：直接右键交谈。",
	-- {item:3491} Heavy Bronze Mace
	["{item:3491}, 75 reputation"] = "{item:3491}，75 点声望",
	["bring it: craft it or buy it at the Auction House"] = "带上它：自己制作，或在拍卖行购买",
	-- {item:6712} Practice Lock
	["{item:6712}, 75 reputation"] = "{item:6712}，75 点声望",
	-- {item:7358} Pilferer's Gloves
	["{item:7358}, 75 reputation"] = "{item:7358}，75 点声望",
	-- {item:5634} Free Action Potion
	["{item:5634}, 75 reputation"] = "{item:5634}，75 点声望",

	-- Step 10: Alterac Mountains writ customers
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers"] = "{zone:1416}的文书委托人",
	-- {npc:257281} Sos'mol · {npc:257282} Alan Sneeks · {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill
	["{npc:257281} and {npc:257282} are close together in the south-west of the mountains; Syndicate thugs roam around {npc:257282}. {npc:6176} stands on the eastern edge, above {area:272}. Customers show no quest mark: right-click them anyway."] = "{npc:257281}和{npc:257282}在山脉西南部，彼此很近；{npc:257282}周围有辛迪加暴徒游荡。{npc:6176}站在东缘、{area:272}上方。客户没有任务标记：仍然右键点击他们。",
	-- {item:3391} Elixir of Ogre Strength
	["{item:3391}, 75 reputation"] = "",
	["bring it: leatherworkers make it, or buy it at the Auction House"] = "",
	-- {item:18662} Heavy Leather Ball
	["{item:18662}, 75 reputation"] = "{item:18662}，75 点声望",
	-- {item:5540} Pearl-handled Dagger
	["{item:5540}, 75 reputation"] = "{item:5540}，75 点声望",
	-- {item:5507} Ornate Spyglass
	["{item:5507}, 75 reputation"] = "{item:5507}，75 点声望",
	-- {item:5766} Lesser Wizard's Robe
	["{item:5766}, 75 reputation"] = "{item:5766}，75 点声望",
	-- {item:4317} Phoenix Pants
	["{item:4317}, 75 reputation"] = "{item:4317}，75 点声望",

	-- Step 11: Ashenvale writ customers
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers"] = "{zone:1440}的文书委托人",
	-- {area:431} Splintertree Post · {npc:257315} Ash'alari · {npc:257322} Murache · {npc:257316} Cowardly Peon · {npc:257317} Grembly
	["All four stand around {area:431}: {npc:257315} about 850 yards south-west of it, {npc:257322} to the south, the {npc:257316} about 350 yards south-east and {npc:257317} about 650 yards north-east. Customers show no quest mark: right-click them anyway."] = "4位都在{area:431}周围：{npc:257315}在其西南约850码，{npc:257322}在南面，{npc:257316}在东南约350码，{npc:257317}在东北约650码。客户不会显示任务标记：直接右键点击即可。",
	-- {item:3385} Lesser Mana Potion
	["{item:3385}, 75 reputation"] = "{item:3385}，75 点声望",
	-- {item:7349} Herbalist's Gloves
	["{item:7349}, 75 reputation"] = "{item:7349}，75 点声望",
	-- {item:5541} Iridescent Hammer
	["{item:5541}, 75 reputation"] = "{item:5541}，75 点声望",
	-- {item:7048} Azure Silk Hood
	["{item:7048}, 75 reputation"] = "{item:7048}，75 点声望",
	-- {item:4383} Moonsight Rifle
	["{item:4383}, 75 reputation"] = "{item:4383}，75 点声望",

	-- Step 12: A Heavy Quiver for the writ
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ"] = "为文书准备一份 {item:7371}",
	-- {item:7371} Heavy Quiver · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1458} Undercity
	["Leatherworkers make the {item:7371}; the bow and gun vendors of {zone:1453}, {zone:1455} and the {zone:1458} sell it. Otherwise buy one at the Auction House."] = "制皮可制作{item:7371}；{zone:1453}、{zone:1455}及{zone:1458}的弓箭和枪械商人也有出售。否则可在拍卖行买一个。",

	-- Step 13: Stonetalon Mountains writ customers
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers"] = "{zone:1442}的文书委托人",
	-- {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["{npc:4201} has a small hut about 550 yards east of {area:460}. Four Journeyman writs go to him. Customers show no quest mark: right-click them anyway."] = "{npc:4201} 的小屋位于 {area:460} 以东约 550 码。四份中级订单都要交给他。顾客头上没有任务标记：直接右键交谈。",
	-- {item:3390} Elixir of Lesser Agility
	["{item:3390}, 75 reputation"] = "{item:3390}，75 点声望",
	-- {item:2865} Rough Bronze Leggings
	["{item:2865}, 75 reputation"] = "{item:2865}，75 点声望",
	-- {item:4373} Shadow Goggles
	["{item:4373}, 75 reputation"] = "{item:4373}，75 点声望",
	-- {item:7371} Heavy Quiver
	["{item:7371}, 75 reputation"] = "{item:7371}，75 点声望",

	-- Step 14: Thousand Needles writ customers
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers"] = "{zone:1441}的文书委托人",
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {area:484} Freewind Post · {npc:4720} Rizzle Brassbolts · {npc:4706} Razzeric · {npc:4496} Goblin Pit Boss · {npc:6548} Magus Tirth
	["All five stand at the {area:2240} on the {area:439}, south-east of {area:484}: {npc:4720}, the chicken \"Plucky\" Johnson, {npc:4706}, the {npc:4496} and {npc:6548}. Customers show no quest mark: right-click them anyway."] = "五名目标都在 {area:484} 东南方、{area:439} 上的 {area:2240}：{npc:4720}、小鸡胆大的约翰森、{npc:4706}、{npc:4496} 和 {npc:6548}。顾客头上没有任务标记：直接右键点击他们。",
	-- {item:8951} Elixir of Defense
	["{item:8951}, 75 reputation"] = "",
	-- {item:3848} Big Bronze Knife
	["{item:3848}, 75 reputation"] = "{item:3848}，75 点声望",
	-- {item:4380} Big Bronze Bomb
	["{item:4380}, 75 reputation"] = "{item:4380}，75 点声望",
	-- {item:4254} Barbaric Gloves
	["{item:4254}, 75 reputation"] = "{item:4254}，75 点声望",
	-- {item:6264} Greater Adept's Robe
	["{item:6264}, 75 reputation"] = "{item:6264}，75 点声望",

	-- Step 15: Neutral to Friendly
	["Neutral to Friendly"] = "中立到友善",
	-- {quest:98247} Shipping Label
	["After the {quest:98247}, Friendly is 1000 more: 14 Journeyman writs, 8 Expert or 5 Artisan. Expert and Artisan customers are mostly not in Polestar's data yet: follow the mark the quest puts on your map. Journeyman envelopes drop from mobs of about level 11 to 31; Expert and Artisan ones from higher mobs."] = "完成 {quest:98247} 后，到友善还需 1000 点：14 份中级订单、8 份高级订单或 5 份大师级订单。高级和大师级订单的顾客大多尚未收录在 Polestar 数据中：跟着任务在地图上标出的地点走。中级信封由约 11 至 31 级怪物掉落；高级和大师级信封来自更高等级怪物。",

	-- Step 16: Gather your writs again
	["Gather your writs again"] = "再次收集文书",

	-- Step 17: Duskwood writ customers again
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers again"] = "再次拜访{zone:1431}的文书委托人",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}, by the road. Customers show no quest mark: right-click them anyway."] = "{npc:3134} 站在 {area:42} 以北约450码的路边。顾客头顶没有任务标记：仍然右键点击他们。",

	-- Step 18: Stranglethorn Vale writ customers again
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers again"] = "再次拜访{zone:1434}的文书委托人",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {object:3202} Grom'gol · {area:1741} Gurubashi Arena · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853} at the zeppelin-style transporter pad and {npc:2663}. {npc:14508} stands about 800 yards south of {object:3202}, by the {area:1741}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35}有三位顾客：“海狼”马金利（在旅店顶层）、在飞艇式传送平台的{npc:7853}，以及{npc:2663}。{npc:14508}站在{object:3202}以南约800码处，靠近{area:1741}；{npc:261961}在荆棘谷北部。顾客头上没有任务标记：照样右键点击他们。",

	-- Step 19: Wetlands writ customers again
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers again"] = "再次拜访{zone:1437}的文书委托人",

	-- Step 20: Arathi Highlands writ customers again
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers again"] = "再次拜访{zone:1417}的文书委托人",

	-- Step 21: Hillsbrad Foothills writ customers again
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers again"] = "再次拜访{zone:1424}的文书委托人",

	-- Step 22: Alterac Mountains writ customers again
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers again"] = "再次拜访{zone:1416}的文书委托人",

	-- Step 23: Ashenvale writ customers again
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers again"] = "再次拜访{zone:1440}的文书委托人",

	-- Step 24: A Heavy Quiver for the writ again
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ again"] = "再次为文书准备一份 {item:7371}",

	-- Step 25: Stonetalon Mountains writ customers again
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers again"] = "再次拜访{zone:1442}的文书委托人",

	-- Step 26: Thousand Needles writ customers again
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers again"] = "再次拜访{zone:1441}的文书委托人",

	-- Step 27: Friendly to Honored
	["Friendly to Honored"] = "友善到尊敬",
	-- {skill:197} Tailoring · {skill:165} Leatherworking · {skill:333} Enchanting · {skill:164} Blacksmithing · {skill:202} Engineering · {skill:171} Alchemy · {skill:185} Cooking · {npc:256742} Dianne Softstep · {area:1002} Three Corners · {npc:256672} Kurvelk Shadowhoof · {item:262902} Forged Delivery Receipt · {item:248549} Waylaid Crate · {item:262917} Notarized Shipping Container · {npc:256390} Marcy Baker · {npc:256386} Dokimi · {quest:93862} Crate Return
	["Friendly opens the first gated recipes at the camp's profession vendors ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) and the Uncertified Scribe: {npc:256742} at {area:1002}, {npc:256672} at the south end of the Crossroads camp. The scribe's {item:262902} (15 Merchant's Favor) turns an empty {item:248549} into a {item:262917}; hand it to {npc:256390} or {npc:256386} for 50 reputation ({quest:93862}). Any crate works, so buy the cheapest one the Auction House has. Honored is 6000 more: 80 Journeyman writs, 48 Expert, 30 Artisan, or 120 crate returns (1,800 Favor and 120 crates). Mix both: every writ you can fill, returns with spare Favor. The Legacy perk Diplomat adds up to 10% to every gain."] = "友善后可在营地专业商人处购买第一批有声望要求的配方（{skill:197} 25、{skill:165} 17、{skill:333} 13、{skill:164} 10、{skill:202} 10、{skill:171} 5、{skill:185} 2），还可使用Uncertified Scribe的服务：{npc:256742}在{area:1002}，{npc:256672}在十字路口营地南端。其出售的{item:262902}（15 Merchant's Favor）可将空的{item:248549}变成{item:262917}；交给{npc:256390}或{npc:256386}可获得50声望（{quest:93862}）。任何箱子都行，买拍卖行最便宜的即可。到尊敬还需6000声望：相当于80份中级文书、48份高级文书、30份大师级文书，或归还120个箱子（需要1,800 Merchant's Favor和120个箱子）。两种方式搭配：能交的文书都交，用多余的Merchant's Favor归还箱子。Legacy特长Diplomat可使每次声望获取最多提高10%。",
	-- {item:262902} Forged Delivery Receipt
	["{item:262902}, 15 Merchant's Favor"] = "{item:262902}，15 点商人青睐。",
	-- {quest:93862} Crate Return
	["{quest:93862}: 50 reputation"] = "{quest:93862}：50 点声望",

	-- Step 28: Badlands writ customer
	-- {zone:1418} Badlands
	["{zone:1418} writ customer"] = "{zone:1418}的文书客户",
	-- {npc:2921} Lotwil Veriatus · {area:340} Kargath
	["{npc:2921} works about 550 yards east of {area:340}. He is the only Expert customer Polestar's data knows."] = "{npc:2921} 在 {area:340} 以东约550码处工作。他是 Polestar 数据中唯一已知的高级客户。",
	-- {item:6050} Frost Protection Potion
	["{item:6050}, 125 reputation"] = "{item:6050}，125声望",

	-- Step 29: Honored to Revered
	["Honored to Revered"] = "尊敬到崇敬",
	-- {skill:165} Leatherworking · {skill:164} Blacksmithing · {skill:333} Enchanting · {skill:171} Alchemy · {skill:202} Engineering · {skill:197} Tailoring · {skill:185} Cooking · {item:270887} Advertising License Application · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262896} Forger's Quill
	["Honored opens the rest of the gated recipes ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), the {item:270887} (1,200 Favor from {npc:256389} or {npc:256384}: it starts the quest for a Tradeskill Sign toy) and the scribe's {item:262896} (15 Favor), which swaps a writ you cannot fill for a random one of the same rank. Revered is 12000 more: 160 Journeyman writs, 96 Expert, 60 Artisan, or 240 crate returns (3,600 Favor). Forever's quest data sets no standing limit on Journeyman writs: their customers are the ones in the zone steps above."] = "尊敬可解锁其余有声望门槛的配方（{skill:165}28个、{skill:164}21个、{skill:333}16个、{skill:171}15个、{skill:202}9个、{skill:197}6个、{skill:185}1个）、{item:270887}（向{npc:256389}或{npc:256384}花1,200点商人青睐购买：它会开启获得商业技能路标玩具的任务），以及铭文师的{item:262896}（15点商人青睐），可将无法完成的文书随机换成同阶另一张。到崇敬还需12000声望：160张中级文书、96张高级文书、60张大师级文书，或交还240箱（3,600点商人青睐）。无限服任务数据没有给中级文书设置声望上限：其客户就是上方各地区步骤中的人。",
	-- {item:270887} Advertising License Application
	["{item:270887}, 1,200 Merchant's Favor"] = "{item:270887}，1,200点商人青睐",

	-- Step 30: Revered to Exalted
	["Revered to Exalted"] = "崇敬到崇拜",
	-- {item:284664} Packmule Treat · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {npc:10636} Pack Kodo
	["Revered opens the {item:284664}, the Minimule pet (1,500 Favor from {npc:256389} or {npc:256384}). Exalted is 21000 more: 280 Journeyman writs, 168 Expert, 105 Artisan, or 420 crate returns (6,300 Favor). Keep 6,000 Favor for the {npc:10636} if you want it."] = "崇敬后开放 {item:284664}，即迷你骡宠物（向 {npc:256389} 或 {npc:256384} 支付 1,500 商人青睐）。到崇拜还需 21000 点：280 份中级订单、168 份高级订单、105 份大师级订单，或归还 420 个箱子（6,300 商人青睐）。如果想要 {npc:10636}，留着 6,000 商人青睐。",
	-- {item:284664} Packmule Treat
	["{item:284664}, 1,500 Merchant's Favor"] = "{item:284664}，1,500点商人青睐",

	-- Step 31: Exalted
	["Exalted"] = "崇拜",
	-- {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262766} Reins of the Pack Kodo · {npc:256736} Huey Sunnydale · {area:1002} Three Corners · {npc:10636} Pack Kodo
	["Exalted opens the camp's tabard (200 Favor) at {npc:256389} or {npc:256384}, and the {item:262766} (6,000 Favor; the mount needs level 60 and Journeyman mount training) at {npc:256736} in {area:1002} or Okamache at the Crossroads camp. The {npc:10636} guide under Collectibles leads you there."] = "崇拜后可向{npc:256389}或{npc:256384}购买营地战袍（200 Merchant's Favor），向{area:1002}的{npc:256736}或十字路口营地的奥卡玛什购买{item:262766}（6,000 Merchant's Favor；坐骑需要60级及中级骑术）。收藏品下的{npc:10636}指南会带你前往。",
	-- {item:262765} Azeroth Commerce Authority Tabard
	["{item:262765}, 200 Merchant's Favor"] = "{item:262765}，200点商人青睐",
	-- {item:262764} Durotar Supply and Logistics Tabard
	["{item:262764}, 200 Merchant's Favor"] = "{item:262764}，200点商人青睐",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:18662} for the writ"] = "为文书准备一份 {item:18662}",
	-- ["A {item:18662} for the writ again"] = "再次为文书准备一份 {item:18662}",
	-- ["An {item:4384} for the writ"] = "为文书准备一个{item:4384}",
	-- ["An {item:4384} for the writ again"] = "再次为文书准备一个{item:4384}",
	-- ["Craftsman's Writs are the camp's reputation: 75 for a Journeyman writ, 125 for an Expert, 200 for an Artisan. Each asks for one crafted item, named in its quest (not always the writ's title: a {item:3388} writ wants a Strong Troll's Blood Potion). Make it or buy it on the Auction House; you need not know the profession. Each writ can be done once a day, and any number of different ones. Take the quest only of writs whose item you have or will buy on the way (right-click the writ), keep the writ in your bags, then tick this: the next steps lead to each customer you hold a writ for."] = "工匠文书是营地声望的来源：中级文书奖励75，高级125，大师级200。每份文书要求一件制作物品，以任务中写明的为准（不一定与文书标题一致：例如{item:3388}文书实际需要Strong Troll's Blood Potion）。可以自行制作或到拍卖行购买，无需学会对应专业。每种文书每天可完成一次，不同种类数量不限。只接取你已有所需物品、或准备沿途购买的文书任务（右键点击文书），将文书留在背包里，然后勾选此项：后续步骤会带你拜访所持文书对应的每位客户。",
	-- ["Dokimi"] = "多基米",
	-- ["Elixir of Ogre's Strength, 75 reputation"] = "食人魔力量药剂，75声望",
	-- ["Elixir of Water Breathing, 75 reputation"] = "水下呼吸饮剂，75声望",
	-- ["Engineers make the {item:4384}; {npc:789} sells it in {area:69} (Alliance). Otherwise buy one at the Auction House."] = "工程师可制作 {item:4384}；{area:69} 的 {npc:789} 也出售（联盟）。否则去拍卖行买一个。",
	-- ["Keep filling Waylaid Crates for Dokimi until Exalted."] = "继续为多基米装满{item:248549}，直到崇拜。",
	-- ["Keep filling Waylaid Crates for Dokimi."] = "继续为多基米装满{item:248549}。",
	-- ["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "继续为{npc:214101}装满{item:248549}，直到崇拜。",
	-- ["Keep filling Waylaid Crates for {npc:214101}."] = "继续为{npc:214101}装满{item:248549}。",
	-- ["Leatherworkers make the {item:18662}, and the Auction House has it. Its only vendor is {npc:14860} at the Darkmoon Faire, which Forever has not shown yet: go there only if the Faire is in town."] = "制皮师可以制作 {item:18662}，拍卖行也有售。唯一出售它的商人是暗月马戏团的 {npc:14860}，而无限尚未展示马戏团：只有马戏团进驻时才去。",
	-- ["Merchant's Favor Reputation"] = "商人青睐声望",
	-- ["Strong Troll's Blood Potion, 75 reputation"] = "Strong Troll's Blood Potion，75声望",
	-- ["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2586}是 Forever 中联盟的商业技能阵营。它的营地位于{zone:1433}西部的{area:1002}。从10级起怪物会掉落{item:248549}：按标签要求装满货物，把{object:1561}交给营地的{npc:214101}以换取声望和Merchant's Favor。Forever的传承外交官特权可提高声望获取。",
	-- ["{faction:2586} to Exalted"] = "{faction:2586}刷到崇拜",
	-- ["{faction:2586} to Friendly"] = "{faction:2586}刷到友善",
	-- ["{faction:2586} to Honored"] = "{faction:2586}刷到尊敬",
	-- ["{faction:2586} to Revered"] = "{faction:2586}刷到崇敬",
	-- ["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587}是 Forever 中部落的商业技能阵营。它的营地就在{zone:1413}的{area:380}外。从10级起怪物会掉落{item:248549}：按标签要求装满货物，把{object:1561}交给营地的多基米以换取声望和Merchant's Favor。Forever的传承外交官特权可提高声望获取。",
	-- ["{faction:2587} to Exalted"] = "{faction:2587}刷到崇拜",
	-- ["{faction:2587} to Friendly"] = "{faction:2587}刷到友善",
	-- ["{faction:2587} to Honored"] = "{faction:2587}刷到尊敬",
	-- ["{faction:2587} to Revered"] = "{faction:2587}刷到崇敬",
	-- ["{item:13445}, 75 reputation"] = "{item:13445}，75声望",
}
