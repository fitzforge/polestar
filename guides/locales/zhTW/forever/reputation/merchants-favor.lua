-- Chinese (traditional) (zhTW): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Supply Factions Reputation"] = "補給陣營聲望",
	-- {npc:10636} Pack Kodo
	["Forever's trade camps: their best recipes, the Minimule and the {npc:10636} need standing, not only Merchant's Favor."] = "Forever的貿易營地：最好的配方、迷你騾子和{npc:10636}需要聲望等級，而不僅僅是Merchant's Favor。",
	["Profession recipes at Friendly and Honored"] = "友善和尊敬時的專業配方",

	-- Step 1: Your first Waylaid Crate or writ
	-- {item:248549} Waylaid Crate
	["Your first {item:248549} or writ"] = "你的第一個{item:248549}或令狀",
	-- {quest:98247} Shipping Label
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["From level 10, mobs anywhere drop Waylaid Crates and sealed writs (Journeyman's, Expert's and Artisan's). Fill a crate with one of the bundles it lists (right-click it), or open a sealed writ: by beta reports, the first time you do either you also get a {quest:98247}. Right-click the label to start its quest. Crates and writs can be traded, so the Auction House sells them too."] = "從10級起，任何地方的怪物都會掉落被劫的板條箱和密封令狀（中級、高階和大師級）。用它所列出的任意一種包裹（右鍵點選箱子）裝滿箱子，或開啟一份密封令狀：據測試服報告，第一次做其中任一件事時還會得到{quest:98247}。右鍵點選標籤即可接取它的任務。板條箱和令狀都能交易，所以拍賣行也有出售。",

	-- Step 2: Three Corners: the Shipping Label
	-- {area:1002} Three Corners · {quest:98247} Shipping Label
	["{area:1002}: the {quest:98247}"] = "{area:1002}：{quest:98247}",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood · {area:69} Lakeshire · {npc:256390} Marcy Baker
	["The {faction:2586} camp is at {area:1002}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet in western Redridge. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256390} too, but they pay only Merchant's Favor and silver, never reputation."] = "{faction:2586}的營地在{area:1002}，即赤脊山西部{zone:1429}、{zone:1431}和{area:69}的道路交匯處。該標籤一次性給2000點聲望（據測試服報告，還有50點商人的恩惠）：相當於到友善的三分之二。裝滿的板條箱也交給{npc:256390}，但只給商人的恩惠和銀幣，從不給聲望。",

	-- Step 3: The Crossroads camp: the Shipping Label
	-- {area:380} The Crossroads · {quest:98248} Shipping Label
	["{area:380} camp: the {quest:98248}"] = "{area:380}營地：{quest:98248}",
	-- {faction:2587} Durotar Supply and Logistics · {npc:256386} Dokimi
	["The {faction:2587} camp stands just outside the west gate of the Crossroads. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256386} too, but they pay only Merchant's Favor and silver, never reputation."] = "{faction:2587}的營地就在十字路口西門外。該標籤一次性給2000點聲望（據測試服報告，還有50點商人的恩惠）：相當於到友善的三分之二。裝滿的板條箱也交給{npc:256386}，但只給商人的恩惠和銀幣，從不給聲望。",

	-- Step 4: Gather your writs
	["Gather your writs"] = "收集令狀",
	["Craftsman's Writs are the camp's reputation: 75 for a Journeyman writ, 125 for an Expert, 200 for an Artisan. Each asks for one crafted item, the one its title names. Make it or buy it on the Auction House; you need not know the profession. Each writ can be done once a day, and any number of different ones. Take the quest only of writs whose item you have or will buy on the way (right-click the writ), keep the writ in your bags, then tick this: the next steps lead to each customer you hold a writ for."] = "工匠契書就是這裡的聲望：學徒契書75點，專家125點，大師200點。每張都要一件製作物品，就是它標題裡寫的那件。自己做或者去拍賣行買；不需要會這個專業。每張契書每天可做一次，不同種類不限數量。只接你手上已有、或者路上會去買的那些物品的契書任務（右鍵點契書），把契書留在包裡，然後勾選這一步：接下來的步驟會帶你去找每一個你持有契書的客戶。",
	["Take the quests of the writs you can fill"] = "接取你能完成的令狀任務",

	-- Step 5: Duskwood writ customers
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers"] = "{zone:1431}令狀顧客",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}. Customers show no quest mark: right-click them anyway."] = "{npc:3134}站在{area:42}以北約450碼。顧客不顯示任務標記：照樣右鍵點選他們。",
	-- {item:6048} Shadow Protection Potion
	["{item:6048}, 75 reputation"] = "{item:6048}，75點聲望",
	-- {item:4381} Minor Recombobulator
	["{item:4381}, 75 reputation"] = "{item:4381}，75點聲望",
	-- {item:2317} Dark Leather Tunic
	["{item:2317}, 75 reputation"] = "{item:2317}，75點聲望",
	-- {item:4245} Small Silk Pack
	["{item:4245}, 75 reputation"] = "{item:4245}，75點聲望",

	-- Step 6: Stranglethorn Vale writ customers
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers"] = "{zone:1434}令狀顧客",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {area:1741} Gurubashi Arena · {object:3202} Grom'gol · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853}, the goblin transporter's engineer, and {npc:2663}. {npc:14508} stands at the {area:1741}, about 800 yards south of {object:3202}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35}有三位顧客：旅店頂樓的“海狼”麥金利、地精傳送器的工程師{npc:7853}，以及{npc:2663}。{npc:14508}站在{area:1741}，位於{object:3202}以南約800碼；{npc:261961}在荊棘谷北部。顧客不顯示任務標記：照樣右鍵點選他們。",
	-- {item:3485} Green Iron Gauntlets
	["{item:3485}, 75 reputation"] = "{item:3485}，75點聲望",
	-- {item:7506} Gnomish Universal Remote
	["{item:7506}, 75 reputation"] = "{item:7506}，75點聲望",
	-- {item:4252} Dark Leather Shoulders
	["{item:4252}, 75 reputation"] = "{item:4252}，75點聲望",
	-- {item:3388} Lesser Troll's Blood Elixir
	["{item:3388}, 75 reputation"] = "{item:3388}，75點聲望",
	-- {item:10048} Colorful Kilt
	["{item:10048}, 75 reputation"] = "{item:10048}，75點聲望",

	-- Step 7: Wetlands writ customers
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers"] = "{zone:1437}令狀顧客",
	-- {npc:8305} Kixxle · {area:205} Dun Modr
	["{npc:8305} stands about 600 yards south of {area:205}. Five Journeyman writs go to him: the most of any customer. Customers show no quest mark: right-click them anyway."] = "{npc:8305}站在{area:205}以南約600碼。有五份中級令狀要交給他：是所有顧客中最多的。顧客不顯示任務標記：照樣右鍵點選他們。",
	-- {item:5996} Draught of Water Breathing
	["{item:5996}, 75 reputation"] = "{item:5996}，75點聲望",
	-- {item:3484} Green Iron Boots
	["{item:3484}, 75 reputation"] = "{item:3484}，75點聲望",
	-- {item:8069} Crafted Solid Shot
	["{item:8069}, 75 reputation"] = "{item:8069}，75點聲望",
	-- {item:7284} Red Whelp Gloves
	["{item:7284}, 75 reputation"] = "{item:7284}，75點聲望",
	-- {item:4321} Spider Silk Slippers
	["{item:4321}, 75 reputation"] = "{item:4321}，75點聲望",

	-- Step 8: Arathi Highlands writ customers
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers"] = "{zone:1417}令狀顧客",
	-- {npc:257296} Muggol Breezebeard · {area:320} Refuge Pointe · {npc:257304} Alyce
	["{npc:257296} is about 250 yards south of {area:320}, {npc:257304} about 700 yards north-west of it. Customers show no quest mark: right-click them anyway."] = "{npc:257296}在{area:320}以南約250碼，{npc:257304}在其西北約700碼。顧客不顯示任務標記：照樣右鍵點選他們。",
	-- {item:3383} Elixir of Wisdom
	["{item:3383}, 75 reputation"] = "{item:3383}，75點聲望",
	-- {item:11128} Golden Rod
	["{item:11128}, 75 reputation"] = "{item:11128}，75點聲望",
	-- {npc:789} Kimberly Hiett · {area:69} Lakeshire
	["bring it: engineers make it; {npc:789} in {area:69} lists it (not yet seen in her window up to level 30), or the Auction House"] = "帶上它：工程學能做；{area:69}的{npc:789}有賣（30級前沒在她的列表裡見過），或者去拍賣行",
	-- {item:4384} Explosive Sheep
	["{item:4384}, 75 reputation"] = "{item:4384}，75點聲望",
	-- {item:5958} Fine Leather Pants
	["{item:5958}, 75 reputation"] = "{item:5958}，75點聲望",
	-- {item:6263} Blue Overalls
	["{item:6263}, 75 reputation"] = "{item:6263}，75點聲望",

	-- Step 9: Hillsbrad Foothills writ customers
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers"] = "{zone:1424}令狀顧客",
	-- {npc:261932} Gorgrash · {npc:3536} Kris Legace · {npc:261928} Webbed Mudsnout Gnoll · {area:271} Southshore
	["{npc:261932} and {npc:3536} are in the east of the foothills; the {npc:261928} hangs in a spider cocoon about 500 yards south-east of {area:271}. Customers show no quest mark: right-click them anyway."] = "{npc:261932}和{npc:3536}在山麓東部；{npc:261928}掛在{area:271}東南約500碼的蜘蛛繭裡。顧客不顯示任務標記：照樣右鍵點選他們。",
	-- {item:3491} Heavy Bronze Mace
	["{item:3491}, 75 reputation"] = "{item:3491}，75點聲望",
	["bring it: craft it or buy it at the Auction House"] = "帶上它：自己製作或在拍賣行購買",
	-- {item:6712} Practice Lock
	["{item:6712}, 75 reputation"] = "{item:6712}，75點聲望",
	-- {item:7358} Pilferer's Gloves
	["{item:7358}, 75 reputation"] = "{item:7358}，75點聲望",
	-- {item:5634} Free Action Potion
	["{item:5634}, 75 reputation"] = "{item:5634}，75點聲望",

	-- Step 10: Alterac Mountains writ customers
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers"] = "{zone:1416}令狀顧客",
	-- {npc:257281} Sos'mol · {npc:257282} Alan Sneeks · {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill
	["{npc:257281} and {npc:257282} are close together in the south-west of the mountains; Syndicate thugs roam around {npc:257282}. {npc:6176} stands on the eastern edge, above {area:272}. Customers show no quest mark: right-click them anyway."] = "{npc:257281}和{npc:257282}彼此靠近，位於山脈西南部；辛迪加暴徒在{npc:257282}周圍遊蕩。{npc:6176}站在東部邊緣、{area:272}上方。顧客不顯示任務標記：照樣右鍵點選他們。",
	-- {item:3391} Elixir of Ogre Strength
	["{item:3391}, 75 reputation"] = "{item:3391}，75點聲望",
	["bring it: leatherworkers make it, or buy it at the Auction House"] = "帶上它：制皮能做，或者去拍賣行買",
	-- {item:18662} Heavy Leather Ball
	["{item:18662}, 75 reputation"] = "{item:18662}，75點聲望",
	-- {item:5540} Pearl-handled Dagger
	["{item:5540}, 75 reputation"] = "{item:5540}，75點聲望",
	-- {item:5507} Ornate Spyglass
	["{item:5507}, 75 reputation"] = "{item:5507}，75點聲望",
	-- {item:5766} Lesser Wizard's Robe
	["{item:5766}, 75 reputation"] = "{item:5766}，75點聲望",
	-- {item:4317} Phoenix Pants
	["{item:4317}, 75 reputation"] = "{item:4317}，75點聲望",

	-- Step 11: Ashenvale writ customers
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers"] = "{zone:1440}令狀顧客",
	-- {area:431} Splintertree Post · {npc:257315} Ash'alari · {npc:257322} Murache · {npc:257316} Cowardly Peon · {npc:257317} Grembly
	["All four stand around {area:431}: {npc:257315} about 850 yards south-west of it, {npc:257322} to the south, the {npc:257316} about 350 yards south-east and {npc:257317} about 650 yards north-east. Customers show no quest mark: right-click them anyway."] = "四人都在{area:431}附近：{npc:257315}在其西南約850碼，{npc:257322}在南邊，{npc:257316}在東南約350碼，{npc:257317}在東北約650碼。顧客不顯示任務標記：照樣右鍵點選他們。",
	-- {item:3385} Lesser Mana Potion
	["{item:3385}, 75 reputation"] = "{item:3385}，75點聲望",
	-- {item:7349} Herbalist's Gloves
	["{item:7349}, 75 reputation"] = "{item:7349}，75點聲望",
	-- {item:5541} Iridescent Hammer
	["{item:5541}, 75 reputation"] = "{item:5541}，75點聲望",
	-- {item:7048} Azure Silk Hood
	["{item:7048}, 75 reputation"] = "{item:7048}，75點聲望",
	-- {item:4383} Moonsight Rifle
	["{item:4383}, 75 reputation"] = "{item:4383}，75點聲望",

	-- Step 12: A Heavy Quiver for the writ
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ"] = "用{item:7371}交一份令狀",
	-- {item:7371} Heavy Quiver · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1458} Undercity
	["Leatherworkers make the {item:7371}; the bow and gun vendors of {zone:1453}, {zone:1455} and the {zone:1458} sell it. Otherwise buy one at the Auction House."] = "{item:7371}由制皮製作；{zone:1453}、{zone:1455}和{zone:1458}的弓與槍供應商有售。否則就在拍賣行買一個。",

	-- Step 13: Stonetalon Mountains writ customers
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers"] = "{zone:1442}令狀顧客",
	-- {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["{npc:4201} has a small hut about 550 yards east of {area:460}. Four Journeyman writs go to him. Customers show no quest mark: right-click them anyway."] = "{npc:4201}在{area:460}以東約550碼處有一間小屋。有四份中級令狀要交給他。顧客不顯示任務標記：照樣右鍵點選他們。",
	-- {item:3390} Elixir of Lesser Agility
	["{item:3390}, 75 reputation"] = "{item:3390}，75點聲望",
	-- {item:2865} Rough Bronze Leggings
	["{item:2865}, 75 reputation"] = "{item:2865}，75點聲望",
	-- {item:4373} Shadow Goggles
	["{item:4373}, 75 reputation"] = "{item:4373}，75點聲望",
	-- {item:7371} Heavy Quiver
	["{item:7371}, 75 reputation"] = "{item:7371}，75點聲望",

	-- Step 14: Thousand Needles writ customers
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers"] = "{zone:1441}令狀顧客",
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {area:484} Freewind Post · {npc:4720} Rizzle Brassbolts · {npc:4706} Razzeric · {npc:4496} Goblin Pit Boss · {npc:6548} Magus Tirth
	["All five stand at the {area:2240} on the {area:439}, south-east of {area:484}: {npc:4720}, the chicken \"Plucky\" Johnson, {npc:4706}, the {npc:4496} and {npc:6548}. Customers show no quest mark: right-click them anyway."] = "五人都在{area:484}東南、{area:439}上的{area:2240}：{npc:4720}、名叫“普拉基”約翰遜的雞、{npc:4706}、{npc:4496}和{npc:6548}。顧客不顯示任務標記：照樣右鍵點選他們。",
	-- {item:8951} Elixir of Defense
	["{item:8951}, 75 reputation"] = "{item:8951}，75點聲望",
	-- {item:3848} Big Bronze Knife
	["{item:3848}, 75 reputation"] = "{item:3848}，75點聲望",
	-- {item:4380} Big Bronze Bomb
	["{item:4380}, 75 reputation"] = "{item:4380}，75點聲望",
	-- {item:4254} Barbaric Gloves
	["{item:4254}, 75 reputation"] = "{item:4254}，75點聲望",
	-- {item:6264} Greater Adept's Robe
	["{item:6264}, 75 reputation"] = "{item:6264}，75點聲望",

	-- Step 15: Neutral to Friendly
	["Neutral to Friendly"] = "中立到友善",
	-- {quest:98247} Shipping Label
	["After the {quest:98247}, Friendly is 1000 more: 14 Journeyman writs, 8 Expert or 5 Artisan. Expert and Artisan customers are mostly not in Polestar's data yet: follow the mark the quest puts on your map. Journeyman envelopes drop from mobs of about level 11 to 31; Expert and Artisan ones from higher mobs."] = "完成{quest:98247}後，到友善還需1000點：14份中級令狀、8份高階令狀或5份大師級令狀。高階和大師級顧客大多還不在 Polestar 的資料中：跟著任務在地圖上留下的標記走。中級信封由約11-31級的怪物掉落；高階和大師級信封來自更高階的怪物。",

	-- Step 16: Gather your writs again
	["Gather your writs again"] = "再次收集令狀",

	-- Step 17: Duskwood writ customers again
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers again"] = "{zone:1431}令狀顧客（續）",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}, by the road. Customers show no quest mark: right-click them anyway."] = "{npc:3134}站在{area:42}以北約450碼的路邊。顧客不顯示任務標記：照樣右鍵點選他們。",

	-- Step 18: Stranglethorn Vale writ customers again
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers again"] = "{zone:1434}令狀顧客（續）",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {object:3202} Grom'gol · {area:1741} Gurubashi Arena · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853} at the zeppelin-style transporter pad and {npc:2663}. {npc:14508} stands about 800 yards south of {object:3202}, by the {area:1741}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35}有三位顧客：旅店頂樓的“海狼”麥金利、飛艇式傳送平臺旁的{npc:7853}，以及{npc:2663}。{npc:14508}站在{object:3202}以南約800碼的{area:1741}旁；{npc:261961}在荊棘谷北部。顧客不顯示任務標記：照樣右鍵點選他們。",

	-- Step 19: Wetlands writ customers again
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers again"] = "{zone:1437}令狀顧客（續）",

	-- Step 20: Arathi Highlands writ customers again
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers again"] = "{zone:1417}令狀顧客（續）",

	-- Step 21: Hillsbrad Foothills writ customers again
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers again"] = "{zone:1424}令狀顧客（續）",

	-- Step 22: Alterac Mountains writ customers again
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers again"] = "{zone:1416}令狀顧客（續）",

	-- Step 23: Ashenvale writ customers again
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers again"] = "{zone:1440}令狀顧客（續）",

	-- Step 24: A Heavy Quiver for the writ again
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ again"] = "再用{item:7371}交一份令狀",

	-- Step 25: Stonetalon Mountains writ customers again
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers again"] = "{zone:1442}令狀顧客（續）",

	-- Step 26: Thousand Needles writ customers again
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers again"] = "{zone:1441}令狀顧客（續）",

	-- Step 27: Friendly to Honored
	["Friendly to Honored"] = "友善到尊敬",
	-- {skill:197} Tailoring · {skill:165} Leatherworking · {skill:333} Enchanting · {skill:164} Blacksmithing · {skill:202} Engineering · {skill:171} Alchemy · {skill:185} Cooking · {npc:256742} Dianne Softstep · {area:1002} Three Corners · {npc:256672} Kurvelk Shadowhoof · {item:262902} Forged Delivery Receipt · {item:248549} Waylaid Crate · {item:262917} Notarized Shipping Container · {npc:256390} Marcy Baker · {npc:256386} Dokimi · {quest:93862} Crate Return
	["Friendly opens the first gated recipes at the camp's profession vendors ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) and the Uncertified Scribe: {npc:256742} at {area:1002}, {npc:256672} at the south end of the Crossroads camp. The scribe's {item:262902} (15 Merchant's Favor) turns an empty {item:248549} into a {item:262917}; hand it to {npc:256390} or {npc:256386} for 50 reputation ({quest:93862}). Any crate works, so buy the cheapest one the Auction House has. Honored is 6000 more: 80 Journeyman writs, 48 Expert, 30 Artisan, or 120 crate returns (1,800 Favor and 120 crates). Mix both: every writ you can fill, returns with spare Favor. The Legacy perk Diplomat adds up to 10% to every gain."] = "友善解鎖營地專業供應商處的第一批門檻配方（{skill:197}25、{skill:165}17、{skill:333}13、{skill:164}10、{skill:202}10、{skill:171}5、{skill:185}2），以及無證抄寫員：{area:1002}的{npc:256742}、十字路口營地南端的{npc:256672}。抄寫員的{item:262902}（15點商人的恩惠）能把一個空的{item:248549}變成{item:262917}；把它交給{npc:256390}或{npc:256386}可得50點聲望（{quest:93862}）。任何板條箱都行，所以買拍賣行裡最便宜的那個。到尊敬還需6000點：80份中級令狀、48份高階令狀、30份大師級令狀，或交還120個板條箱（1800點恩惠和120個箱子）。兩者混合：能填的令狀都做，剩餘的恩惠用交箱補。傳承特長“外交家”可使每次獲取量最多提高10%。",
	-- {item:262902} Forged Delivery Receipt
	["{item:262902}, 15 Merchant's Favor"] = "{item:262902}，15點商人的恩惠",
	-- {quest:93862} Crate Return
	["{quest:93862}: 50 reputation"] = "{quest:93862}：50點聲望",

	-- Step 28: Badlands writ customer
	-- {zone:1418} Badlands
	["{zone:1418} writ customer"] = "{zone:1418}令狀顧客",
	-- {npc:2921} Lotwil Veriatus · {area:340} Kargath
	["{npc:2921} works about 550 yards east of {area:340}. He is the only Expert customer Polestar's data knows."] = "{npc:2921}在{area:340}以東約550碼工作。他是 Polestar 資料中唯一的高階顧客。",
	-- {item:6050} Frost Protection Potion
	["{item:6050}, 125 reputation"] = "{item:6050}，125點聲望",

	-- Step 29: Honored to Revered
	["Honored to Revered"] = "尊敬到崇敬",
	-- {skill:165} Leatherworking · {skill:164} Blacksmithing · {skill:333} Enchanting · {skill:171} Alchemy · {skill:202} Engineering · {skill:197} Tailoring · {skill:185} Cooking · {item:270887} Advertising License Application · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262896} Forger's Quill
	["Honored opens the rest of the gated recipes ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), the {item:270887} (1,200 Favor from {npc:256389} or {npc:256384}: it starts the quest for a Tradeskill Sign toy) and the scribe's {item:262896} (15 Favor), which swaps a writ you cannot fill for a random one of the same rank. Revered is 12000 more: 160 Journeyman writs, 96 Expert, 60 Artisan, or 240 crate returns (3,600 Favor). Forever's quest data sets no standing limit on Journeyman writs: their customers are the ones in the zone steps above."] = "尊敬解鎖其餘的門檻配方（{skill:165}28、{skill:164}21、{skill:333}16、{skill:171}15、{skill:202}9、{skill:197}6、{skill:185}1）、{item:270887}（在{npc:256389}或{npc:256384}處以1200點恩惠購買：它會開啟專業技能招牌玩具的任務），以及抄寫員的{item:262896}（15點恩惠），可把你無法完成的令狀換成一份同等級的隨機令狀。到崇敬還需12000點：160份中級令狀、96份高階令狀、60份大師級令狀，或交還240個板條箱（3600點恩惠）。Forever 的任務資料對中級令狀沒有聲望限制：它們的顧客就是上面各區域步驟中的那些。",
	-- {item:270887} Advertising License Application
	["{item:270887}, 1,200 Merchant's Favor"] = "{item:270887}，1,200點商人的恩惠",

	-- Step 30: Revered to Exalted
	["Revered to Exalted"] = "崇敬到崇拜",
	-- {item:284664} Packmule Treat · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {npc:10636} Pack Kodo
	["Revered opens the {item:284664}, the Minimule pet (1,500 Favor from {npc:256389} or {npc:256384}). Exalted is 21000 more: 280 Journeyman writs, 168 Expert, 105 Artisan, or 420 crate returns (6,300 Favor). Keep 6,000 Favor for the {npc:10636} if you want it."] = "崇敬解鎖{item:284664}，即迷你騾寵物（在{npc:256389}或{npc:256384}處以1500點恩惠購買）。到崇拜還需21000點：280份中級令狀、168份高階令狀、105份大師級令狀，或交還420個板條箱（6300點恩惠）。如果想要{npc:10636}，請留出6000點恩惠。",
	-- {item:284664} Packmule Treat
	["{item:284664}, 1,500 Merchant's Favor"] = "{item:284664}，1,500點商人的恩惠",

	-- Step 31: Exalted
	["Exalted"] = "崇拜",
	-- {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262766} Reins of the Pack Kodo · {npc:256736} Huey Sunnydale · {area:1002} Three Corners · {npc:10636} Pack Kodo
	["Exalted opens the camp's tabard (200 Favor) at {npc:256389} or {npc:256384}, and the {item:262766} (6,000 Favor; the mount needs level 60 and Journeyman mount training) at {npc:256736} in {area:1002} or Okamache at the Crossroads camp. The {npc:10636} guide under Collectibles leads you there."] = "崇拜後可在{npc:256389}或{npc:256384}處購買營地戰袍（200點恩惠），並可在{area:1002}的{npc:256736}或十字路口營地的奧卡馬奇處購買{item:262766}（6,000點恩惠；坐騎需要60級和中級騎術）。收藏品分類下的{npc:10636}指南會帶你去那裡。",
	-- {item:262765} Azeroth Commerce Authority Tabard
	["{item:262765}, 200 Merchant's Favor"] = "{item:262765}，200點商人的恩惠",
	-- {item:262764} Durotar Supply and Logistics Tabard
	["{item:262764}, 200 Merchant's Favor"] = "{item:262764}，200點商人的恩惠",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dokimi"] = "朵奇米",
	-- ["Keep filling Waylaid Crates for Dokimi until Exalted."] = "繼續為朵奇米裝滿遭攔截的木箱，直到崇拜。",
	-- ["Keep filling Waylaid Crates for Dokimi."] = "繼續為朵奇米裝滿遭攔截的木箱。",
	-- ["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "繼續為{npc:214101}裝滿遭攔截的木箱，直到崇拜。",
	-- ["Keep filling Waylaid Crates for {npc:214101}."] = "繼續為{npc:214101}裝滿遭攔截的木箱。",
	-- ["Merchant's Favor Reputation"] = "商人貢獻點聲望",
	-- ["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2586}是 Forever 中聯盟的專業技能陣營。它的營地在{zone:1433}西部的{area:1002}。從10級起，怪物會掉落遭攔截的木箱：依標籤要求裝滿貨物，然後把{object:1561}交給營地的{npc:214101}，換取聲望和 Merchant's Favor。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{faction:2586} to Exalted"] = "{faction:2586}到崇拜",
	-- ["{faction:2586} to Friendly"] = "{faction:2586}到友好",
	-- ["{faction:2586} to Honored"] = "{faction:2586}到尊敬",
	-- ["{faction:2586} to Revered"] = "{faction:2586}到崇敬",
	-- ["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587}是 Forever 中部落的專業技能陣營。它的營地就在{zone:1413}的{area:380}外面。從10級起，怪物會掉落遭攔截的木箱：依標籤要求裝滿貨物，然後把{object:1561}交給營地的朵奇米，換取聲望和 Merchant's Favor。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{faction:2587} to Exalted"] = "{faction:2587}到崇拜",
	-- ["{faction:2587} to Friendly"] = "{faction:2587}到友好",
	-- ["{faction:2587} to Honored"] = "{faction:2587}到尊敬",
	-- ["{faction:2587} to Revered"] = "{faction:2587}到崇敬",
}
