-- Korean (koKR): the guide forever/reputation/merchants-favor (forever/reputation/merchants-favor.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Supply Factions Reputation"] = "보급 세력 평판",
	-- {npc:10636} Pack Kodo
	["Forever's trade camps: their best recipes, the Minimule and the {npc:10636} need standing, not only Merchant's Favor."] = "Forever의 교역 야영지: 최고 제조법, 미니뮬, {npc:10636}은(는) 상인의 호의뿐 아니라 평판도 필요합니다.",
	["Profession recipes at Friendly and Honored"] = "우호적과 존경에서 여는 전문 기술 제조법",

	-- Step 1: Your first Waylaid Crate or writ
	-- {item:248549} Waylaid Crate
	["Your first {item:248549} or writ"] = "첫 {item:248549} 또는 의뢰서",
	-- {quest:98247} Shipping Label
	-- plural, as words: Waylaid Crates = {item:248549} Waylaid Crate
	["From level 10, mobs anywhere drop Waylaid Crates and sealed writs (Journeyman's, Expert's and Artisan's). Fill a crate with one of the bundles it lists (right-click it), or open a sealed writ: by beta reports, the first time you do either you also get a {quest:98247}. Right-click the label to start its quest. Crates and writs can be traded, so the Auction House sells them too."] = "10레벨부터 어디서든 몹이 파랑 상자와 봉인된 의뢰서(수습, 전문가, 대가)를 떨어뜨립니다. 상자는 목록 중 하나를 담아서 열고(오른쪽 클릭), 봉인된 의뢰서는 그냥 열으세요. 베타 보고에 따르면 처음으로 그렇게 하면 {quest:98247}도 함께 주어집니다. 라벨을 오른쪽 클릭해 그 퀘스트를 시작하세요. 상자와 의뢰서는 거래할 수 있어서 경매장에서도 팔립니다.",

	-- Step 2: Three Corners: the Shipping Label
	-- {area:1002} Three Corners · {quest:98247} Shipping Label
	["{area:1002}: the {quest:98247}"] = "{area:1002}: {quest:98247}",
	-- {faction:2586} Azeroth Commerce Authority · {area:1002} Three Corners · {zone:1429} Elwynn Forest · {zone:1431} Duskwood · {area:69} Lakeshire · {npc:256390} Marcy Baker
	["The {faction:2586} camp is at {area:1002}, where the roads from {zone:1429}, {zone:1431} and {area:69} meet in western Redridge. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256390} too, but they pay only Merchant's Favor and silver, never reputation."] = "{faction:2586} 야영지는 {area:1002}에 있고, {zone:1429}, {zone:1431}, {area:69}에서 온 길이 서쪽 레드리지에서 만납니다. 라벨은 평판 2,000을 한 번 주고(베타 보고대로 상인의 호의 50) 우호적까지의 3분의 2입니다. 채워진 상자도 {npc:256390}에게 가져가지만 그쪽은 상인의 호의와 은화만 주고 평판은 주지 않습니다.",

	-- Step 3: The Crossroads camp: the Shipping Label
	-- {area:380} The Crossroads · {quest:98248} Shipping Label
	["{area:380} camp: the {quest:98248}"] = "{area:380} 야영지: {quest:98248}",
	-- {faction:2587} Durotar Supply and Logistics · {npc:256386} Dokimi
	["The {faction:2587} camp stands just outside the west gate of the Crossroads. The label pays 2000 reputation once (and, by beta reports, 50 Merchant's Favor): two thirds of the way to Friendly. Filled crates go to {npc:256386} too, but they pay only Merchant's Favor and silver, never reputation."] = "{faction:2587} 야영지는 십자로 서문 바로 바깥에 있습니다. 라벨은 평판 2,000을 한 번 주고(베타 보고대로 상인의 호의 50) 우호적까지의 3분의 2입니다. 채워진 상자도 {npc:256386}에게 가져가지만 그쪽은 상인의 호의와 은화만 주고 평판은 주지 않습니다.",

	-- Step 4: Gather your writs
	["Gather your writs"] = "의뢰서를 모으세요",
	["Craftsman's Writs are the camp's reputation: 75 for a Journeyman writ, 125 for an Expert, 200 for an Artisan. Each asks for one crafted item, the one its title names. Make it or buy it on the Auction House; you need not know the profession. Each writ can be done once a day, and any number of different ones. Take the quest only of writs whose item you have or will buy on the way (right-click the writ), keep the writ in your bags, then tick this: the next steps lead to each customer you hold a writ for."] = "장인의 의뢰서가 야영지의 평판입니다. 수습 의뢰서 75, 전문가 125, 대가 200입니다. 각각 제목에 적힌 제작 아이템 하나를 요구합니다. 직접 만들거나 경매장에서 사세요. 전문 기술을 알 필요는 없습니다. 의뢰서는 매일 한 번씩, 서로 다른 것은 몇 개든 할 수 있습니다. 가진 아이템이거나 길에서 살 의뢰서의 퀘스트만 수락하고(의뢰서를 오른쪽 클릭), 의뢰서는 가방에 넣어 두었다가 이 칸을 체크하세요. 다음 단계가 의뢰서를 가진 각 고객에게 안내합니다.",
	["Take the quests of the writs you can fill"] = "채울 수 있는 의뢰서의 퀘스트를 받으세요",

	-- Step 5: Duskwood writ customers
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers"] = "{zone:1431} 의뢰서 고객",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}. Customers show no quest mark: right-click them anyway."] = "{npc:3134}은(는) {area:42}에서 북쪽으로 약 450야드에 서 있습니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",
	-- {item:6048} Shadow Protection Potion
	["{item:6048}, 75 reputation"] = "{item:6048}, 평판 75",
	-- {item:4381} Minor Recombobulator
	["{item:4381}, 75 reputation"] = "{item:4381}, 평판 75",
	-- {item:2317} Dark Leather Tunic
	["{item:2317}, 75 reputation"] = "{item:2317}, 평판 75",
	-- {item:4245} Small Silk Pack
	["{item:4245}, 75 reputation"] = "{item:4245}, 평판 75",

	-- Step 6: Stranglethorn Vale writ customers
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers"] = "{zone:1434} 의뢰서 고객",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {area:1741} Gurubashi Arena · {object:3202} Grom'gol · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853}, the goblin transporter's engineer, and {npc:2663}. {npc:14508} stands at the {area:1741}, about 800 yards south of {object:3202}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35}에 고객이 세 명 있습니다: \"Sea Wolf\" MacKinley(여관 다락), 고블린 수송업자의 기술자 {npc:7853}, 그리고 {npc:2663}. {npc:14508}은(는) {object:3202}에서 남쪽으로 약 800야드, {area:1741}에 서 있고 {npc:261961}은(는) 북부 스트렝글손에 있습니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",
	-- {item:3485} Green Iron Gauntlets
	["{item:3485}, 75 reputation"] = "{item:3485}, 평판 75",
	-- {item:7506} Gnomish Universal Remote
	["{item:7506}, 75 reputation"] = "{item:7506}, 평판 75",
	-- {item:4252} Dark Leather Shoulders
	["{item:4252}, 75 reputation"] = "{item:4252}, 평판 75",
	-- {item:3388} Lesser Troll's Blood Elixir
	["{item:3388}, 75 reputation"] = "{item:3388}, 평판 75",
	-- {item:10048} Colorful Kilt
	["{item:10048}, 75 reputation"] = "{item:10048}, 평판 75",

	-- Step 7: Wetlands writ customers
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers"] = "{zone:1437} 의뢰서 고객",
	-- {npc:8305} Kixxle · {area:205} Dun Modr
	["{npc:8305} stands about 600 yards south of {area:205}. Five Journeyman writs go to him: the most of any customer. Customers show no quest mark: right-click them anyway."] = "{npc:8305}은(는) {area:205}에서 남쪽으로 약 600야드에 서 있습니다. 수습 의뢰서 다섯 개가 그에게 가는데, 어떤 고객보다 많습니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",
	-- {item:5996} Draught of Water Breathing
	["{item:5996}, 75 reputation"] = "{item:5996}, 평판 75",
	-- {item:3484} Green Iron Boots
	["{item:3484}, 75 reputation"] = "{item:3484}, 평판 75",
	-- {item:8069} Crafted Solid Shot
	["{item:8069}, 75 reputation"] = "{item:8069}, 평판 75",
	-- {item:7284} Red Whelp Gloves
	["{item:7284}, 75 reputation"] = "{item:7284}, 평판 75",
	-- {item:4321} Spider Silk Slippers
	["{item:4321}, 75 reputation"] = "{item:4321}, 평판 75",

	-- Step 8: Arathi Highlands writ customers
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers"] = "{zone:1417} 의뢰서 고객",
	-- {npc:257296} Muggol Breezebeard · {area:320} Refuge Pointe · {npc:257304} Alyce
	["{npc:257296} is about 250 yards south of {area:320}, {npc:257304} about 700 yards north-west of it. Customers show no quest mark: right-click them anyway."] = "{npc:257296}은(는) {area:320}에서 남쪽으로 약 250야드, {npc:257304}은(는) 그에서 북서쪽으로 약 700야드에 있습니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",
	-- {item:3383} Elixir of Wisdom
	["{item:3383}, 75 reputation"] = "{item:3383}, 평판 75",
	-- {item:11128} Golden Rod
	["{item:11128}, 75 reputation"] = "{item:11128}, 평판 75",
	-- {npc:789} Kimberly Hiett · {area:69} Lakeshire
	["bring it: engineers make it; {npc:789} in {area:69} lists it (not yet seen in her window up to level 30), or the Auction House"] = "가져오기: 기술자들이 만듭니다. {area:69}의 {npc:789}이(가) 판매합니다(30레벨까지 그녀의 창에서 아직 보이지 않음). 아니면 경매장에서",
	-- {item:4384} Explosive Sheep
	["{item:4384}, 75 reputation"] = "{item:4384}, 평판 75",
	-- {item:5958} Fine Leather Pants
	["{item:5958}, 75 reputation"] = "{item:5958}, 평판 75",
	-- {item:6263} Blue Overalls
	["{item:6263}, 75 reputation"] = "{item:6263}, 평판 75",

	-- Step 9: Hillsbrad Foothills writ customers
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers"] = "{zone:1424} 의뢰서 고객",
	-- {npc:261932} Gorgrash · {npc:3536} Kris Legace · {npc:261928} Webbed Mudsnout Gnoll · {area:271} Southshore
	["{npc:261932} and {npc:3536} are in the east of the foothills; the {npc:261928} hangs in a spider cocoon about 500 yards south-east of {area:271}. Customers show no quest mark: right-click them anyway."] = "{npc:261932}와(과) {npc:3536}은(는) 구릿길 동쪽에 있고, {npc:261928}은(는) {area:271}에서 남동쪽으로 약 500야드의 거미 고치에 매달려 있습니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",
	-- {item:3491} Heavy Bronze Mace
	["{item:3491}, 75 reputation"] = "{item:3491}, 평판 75",
	["bring it: craft it or buy it at the Auction House"] = "가져오기: 직접 만들거나 경매장에서 사세요",
	-- {item:6712} Practice Lock
	["{item:6712}, 75 reputation"] = "{item:6712}, 평판 75",
	-- {item:7358} Pilferer's Gloves
	["{item:7358}, 75 reputation"] = "{item:7358}, 평판 75",
	-- {item:5634} Free Action Potion
	["{item:5634}, 75 reputation"] = "{item:5634}, 평판 75",

	-- Step 10: Alterac Mountains writ customers
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers"] = "{zone:1416} 의뢰서 고객",
	-- {npc:257281} Sos'mol · {npc:257282} Alan Sneeks · {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill
	["{npc:257281} and {npc:257282} are close together in the south-west of the mountains; Syndicate thugs roam around {npc:257282}. {npc:6176} stands on the eastern edge, above {area:272}. Customers show no quest mark: right-click them anyway."] = "{npc:257281}과(와) {npc:257282}은(는) 산 남서쪽에서 서로 가까이 있고, 신디케이트 깡패들이 {npc:257282} 주변을 어슬렁거립니다. {npc:6176}은(는) 동쪽 가장자리, {area:272} 위에 서 있습니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",
	-- {item:3391} Elixir of Ogre Strength
	["{item:3391}, 75 reputation"] = "{item:3391}, 평판 75",
	["bring it: leatherworkers make it, or buy it at the Auction House"] = "가져오기: 가죽세공사들이 만듭니다. 아니면 경매장에서 사세요",
	-- {item:18662} Heavy Leather Ball
	["{item:18662}, 75 reputation"] = "{item:18662}, 평판 75",
	-- {item:5540} Pearl-handled Dagger
	["{item:5540}, 75 reputation"] = "{item:5540}, 평판 75",
	-- {item:5507} Ornate Spyglass
	["{item:5507}, 75 reputation"] = "{item:5507}, 평판 75",
	-- {item:5766} Lesser Wizard's Robe
	["{item:5766}, 75 reputation"] = "{item:5766}, 평판 75",
	-- {item:4317} Phoenix Pants
	["{item:4317}, 75 reputation"] = "{item:4317}, 평판 75",

	-- Step 11: Ashenvale writ customers
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers"] = "{zone:1440} 의뢰서 고객",
	-- {area:431} Splintertree Post · {npc:257315} Ash'alari · {npc:257322} Murache · {npc:257316} Cowardly Peon · {npc:257317} Grembly
	["All four stand around {area:431}: {npc:257315} about 850 yards south-west of it, {npc:257322} to the south, the {npc:257316} about 350 yards south-east and {npc:257317} about 650 yards north-east. Customers show no quest mark: right-click them anyway."] = "네 명 모두 {area:431} 주변에 있습니다: {npc:257315}은(는) 그에서 남서쪽으로 약 850야드, {npc:257322}은(는) 남쪽, {npc:257316}은(는) 남동쪽으로 약 350야드, {npc:257317}은(는) 북동쪽으로 약 650야드에 있습니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",
	-- {item:3385} Lesser Mana Potion
	["{item:3385}, 75 reputation"] = "{item:3385}, 평판 75",
	-- {item:7349} Herbalist's Gloves
	["{item:7349}, 75 reputation"] = "{item:7349}, 평판 75",
	-- {item:5541} Iridescent Hammer
	["{item:5541}, 75 reputation"] = "{item:5541}, 평판 75",
	-- {item:7048} Azure Silk Hood
	["{item:7048}, 75 reputation"] = "{item:7048}, 평판 75",
	-- {item:4383} Moonsight Rifle
	["{item:4383}, 75 reputation"] = "{item:4383}, 평판 75",

	-- Step 12: A Heavy Quiver for the writ
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ"] = "의뢰서용 {item:7371}",
	-- {item:7371} Heavy Quiver · {zone:1453} Stormwind · {zone:1455} Ironforge · {zone:1458} Undercity
	["Leatherworkers make the {item:7371}; the bow and gun vendors of {zone:1453}, {zone:1455} and the {zone:1458} sell it. Otherwise buy one at the Auction House."] = "가죽세공사들이 {item:7371}을(를) 만듭니다. {zone:1453}, {zone:1455}, {zone:1458}의 활과 총 상인이 팔기도 합니다. 아니면 경매장에서 사세요.",

	-- Step 13: Stonetalon Mountains writ customers
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers"] = "{zone:1442} 의뢰서 고객",
	-- {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["{npc:4201} has a small hut about 550 yards east of {area:460}. Four Journeyman writs go to him. Customers show no quest mark: right-click them anyway."] = "{npc:4201}은(는) {area:460}에서 동쪽으로 약 550야드에 작은 오두막을 가지고 있습니다. 수습 의뢰서 네 개가 그에게 갑니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",
	-- {item:3390} Elixir of Lesser Agility
	["{item:3390}, 75 reputation"] = "{item:3390}, 평판 75",
	-- {item:2865} Rough Bronze Leggings
	["{item:2865}, 75 reputation"] = "{item:2865}, 평판 75",
	-- {item:4373} Shadow Goggles
	["{item:4373}, 75 reputation"] = "{item:4373}, 평판 75",
	-- {item:7371} Heavy Quiver
	["{item:7371}, 75 reputation"] = "{item:7371}, 평판 75",

	-- Step 14: Thousand Needles writ customers
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers"] = "{zone:1441} 의뢰서 고객",
	-- {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {area:484} Freewind Post · {npc:4720} Rizzle Brassbolts · {npc:4706} Razzeric · {npc:4496} Goblin Pit Boss · {npc:6548} Magus Tirth
	["All five stand at the {area:2240} on the {area:439}, south-east of {area:484}: {npc:4720}, the chicken \"Plucky\" Johnson, {npc:4706}, the {npc:4496} and {npc:6548}. Customers show no quest mark: right-click them anyway."] = "다섯 명 모두 {area:484} 남동쪽의 {area:439}에 있는 {area:2240}에 있습니다: 닭 \"Plucky\" 존슨 {npc:4720}, {npc:4706}, {npc:4496}, 그리고 {npc:6548}. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",
	-- {item:8951} Elixir of Defense
	["{item:8951}, 75 reputation"] = "{item:8951}, 평판 75",
	-- {item:3848} Big Bronze Knife
	["{item:3848}, 75 reputation"] = "{item:3848}, 평판 75",
	-- {item:4380} Big Bronze Bomb
	["{item:4380}, 75 reputation"] = "{item:4380}, 평판 75",
	-- {item:4254} Barbaric Gloves
	["{item:4254}, 75 reputation"] = "{item:4254}, 평판 75",
	-- {item:6264} Greater Adept's Robe
	["{item:6264}, 75 reputation"] = "{item:6264}, 평판 75",

	-- Step 15: Neutral to Friendly
	["Neutral to Friendly"] = "중립에서 우호적",
	-- {quest:98247} Shipping Label
	["After the {quest:98247}, Friendly is 1000 more: 14 Journeyman writs, 8 Expert or 5 Artisan. Expert and Artisan customers are mostly not in Polestar's data yet: follow the mark the quest puts on your map. Journeyman envelopes drop from mobs of about level 11 to 31; Expert and Artisan ones from higher mobs."] = "{quest:98247} 뒤에는 우호적까지 1,000이 더 필요합니다. 수습 의뢰서 14개, 전문가 8개 또는 대가 5개입니다. 전문가와 대가 고객은 아직 Polestar 데이터에 거의 없으니 퀘스트가 지도에 찍는 표시를 따르세요. 수습 봉투는 약 11~31레벨 몹에게, 전문가와 대가 봉투는 더 높은 몹에게 떨어집니다.",

	-- Step 16: Gather your writs again
	["Gather your writs again"] = "의뢰서를 다시 모으세요",

	-- Step 17: Duskwood writ customers again
	-- {zone:1431} Duskwood
	["{zone:1431} writ customers again"] = "{zone:1431} 의뢰서 고객 (다시)",
	-- {npc:3134} Kzixx · {area:42} Darkshire
	["{npc:3134} stands about 450 yards north of {area:42}, by the road. Customers show no quest mark: right-click them anyway."] = "{npc:3134}은(는) {area:42}에서 북쪽으로 약 450야드에 서 있습니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",

	-- Step 18: Stranglethorn Vale writ customers again
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434} writ customers again"] = "{zone:1434} 의뢰서 고객 (다시)",
	-- {area:35} Booty Bay · {npc:7853} Scooty · {npc:2663} Narkk · {npc:14508} Short John Mithril · {object:3202} Grom'gol · {area:1741} Gurubashi Arena · {npc:261961} Hekshi
	["{area:35} holds three customers: \"Sea Wolf\" MacKinley (on the inn's top floor), {npc:7853} at the zeppelin-style transporter pad and {npc:2663}. {npc:14508} stands about 800 yards south of {object:3202}, by the {area:1741}; {npc:261961} is in northern Stranglethorn. Customers show no quest mark: right-click them anyway."] = "{area:35}에 고객이 세 명 있습니다: \"Sea Wolf\" MacKinley(여관 다락), 고블린 수송업자의 기술자 {npc:7853}, 그리고 {npc:2663}. {npc:14508}은(는) {object:3202}에서 남쪽으로 약 800야드, {area:1741}에 서 있고 {npc:261961}은(는) 북부 스트렝글손에 있습니다. 고객에게는 퀘스트 표시가 없으니 그래도 오른쪽 클릭하세요.",

	-- Step 19: Wetlands writ customers again
	-- {zone:1437} Wetlands
	["{zone:1437} writ customers again"] = "{zone:1437} 의뢰서 고객 (다시)",

	-- Step 20: Arathi Highlands writ customers again
	-- {zone:1417} Arathi Highlands
	["{zone:1417} writ customers again"] = "{zone:1417} 의뢰서 고객 (다시)",

	-- Step 21: Hillsbrad Foothills writ customers again
	-- {zone:1424} Hillsbrad Foothills
	["{zone:1424} writ customers again"] = "{zone:1424} 의뢰서 고객 (다시)",

	-- Step 22: Alterac Mountains writ customers again
	-- {zone:1416} Alterac Mountains
	["{zone:1416} writ customers again"] = "{zone:1416} 의뢰서 고객 (다시)",

	-- Step 23: Ashenvale writ customers again
	-- {zone:1440} Ashenvale
	["{zone:1440} writ customers again"] = "{zone:1440} 의뢰서 고객 (다시)",

	-- Step 24: A Heavy Quiver for the writ again
	-- {item:7371} Heavy Quiver
	["A {item:7371} for the writ again"] = "의뢰서용 {item:7371} (다시)",

	-- Step 25: Stonetalon Mountains writ customers again
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442} writ customers again"] = "{zone:1442} 의뢰서 고객 (다시)",

	-- Step 26: Thousand Needles writ customers again
	-- {zone:1441} Thousand Needles
	["{zone:1441} writ customers again"] = "{zone:1441} 의뢰서 고객 (다시)",

	-- Step 27: Friendly to Honored
	["Friendly to Honored"] = "우호적에서 존경",
	-- {skill:197} Tailoring · {skill:165} Leatherworking · {skill:333} Enchanting · {skill:164} Blacksmithing · {skill:202} Engineering · {skill:171} Alchemy · {skill:185} Cooking · {npc:256742} Dianne Softstep · {area:1002} Three Corners · {npc:256672} Kurvelk Shadowhoof · {item:262902} Forged Delivery Receipt · {item:248549} Waylaid Crate · {item:262917} Notarized Shipping Container · {npc:256390} Marcy Baker · {npc:256386} Dokimi · {quest:93862} Crate Return
	["Friendly opens the first gated recipes at the camp's profession vendors ({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2) and the Uncertified Scribe: {npc:256742} at {area:1002}, {npc:256672} at the south end of the Crossroads camp. The scribe's {item:262902} (15 Merchant's Favor) turns an empty {item:248549} into a {item:262917}; hand it to {npc:256390} or {npc:256386} for 50 reputation ({quest:93862}). Any crate works, so buy the cheapest one the Auction House has. Honored is 6000 more: 80 Journeyman writs, 48 Expert, 30 Artisan, or 120 crate returns (1,800 Favor and 120 crates). Mix both: every writ you can fill, returns with spare Favor. The Legacy perk Diplomat adds up to 10% to every gain."] = "우호적이 야영지 전문 기술 상인의 첫 번째 잠긴 제조법({skill:197} 25, {skill:165} 17, {skill:333} 13, {skill:164} 10, {skill:202} 10, {skill:171} 5, {skill:185} 2)과 미인증 서기({area:1002}의 {npc:256742}, 십자로 야영지 남쪽 끝의 {npc:256672})를 엽니다. 서기의 {item:262902}(상인의 호의 15)가 빈 {item:248549}를 {item:262917}(으)로 바꿉니다. {npc:256390} 또는 {npc:256386}에게 가져가면 평판 50({quest:93862})을 줍니다. 어떤 상자라도 되니 경매장에서 가장 싼 것을 사세요. 존경까지는 6,000이 더 필요합니다. 수습 의뢰서 80개, 전문가 48개, 대가 30개 또는 상자 반환 120회(상인의 호의 1,800과 상자 120개). 둘을 섞으세요. 채울 수 있는 의뢰서는 모두 하고, 남은 호의로 상자를 반환합니다. 유산 특전 외교관은 모든 획득에 최대 10%를 더합니다.",
	-- {item:262902} Forged Delivery Receipt
	["{item:262902}, 15 Merchant's Favor"] = "{item:262902}, 상인의 호의 15",
	-- {quest:93862} Crate Return
	["{quest:93862}: 50 reputation"] = "{quest:93862}: 평판 50",

	-- Step 28: Badlands writ customer
	-- {zone:1418} Badlands
	["{zone:1418} writ customer"] = "{zone:1418} 의뢰서 고객",
	-- {npc:2921} Lotwil Veriatus · {area:340} Kargath
	["{npc:2921} works about 550 yards east of {area:340}. He is the only Expert customer Polestar's data knows."] = "{npc:2921}은(는) {area:340}에서 동쪽으로 약 550야드에서 일합니다. 그가 Polestar 데이터가 아는 유일한 전문가 고객입니다.",
	-- {item:6050} Frost Protection Potion
	["{item:6050}, 125 reputation"] = "{item:6050}, 평판 125",

	-- Step 29: Honored to Revered
	["Honored to Revered"] = "존경에서 평판 우호",
	-- {skill:165} Leatherworking · {skill:164} Blacksmithing · {skill:333} Enchanting · {skill:171} Alchemy · {skill:202} Engineering · {skill:197} Tailoring · {skill:185} Cooking · {item:270887} Advertising License Application · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262896} Forger's Quill
	["Honored opens the rest of the gated recipes ({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1), the {item:270887} (1,200 Favor from {npc:256389} or {npc:256384}: it starts the quest for a Tradeskill Sign toy) and the scribe's {item:262896} (15 Favor), which swaps a writ you cannot fill for a random one of the same rank. Revered is 12000 more: 160 Journeyman writs, 96 Expert, 60 Artisan, or 240 crate returns (3,600 Favor). Forever's quest data sets no standing limit on Journeyman writs: their customers are the ones in the zone steps above."] = "존경이 나머지 잠긴 제조법({skill:165} 28, {skill:164} 21, {skill:333} 16, {skill:171} 15, {skill:202} 9, {skill:197} 6, {skill:185} 1)과 {item:270887}({npc:256389} 또는 {npc:256384}에게서 상인의 호의 1,200: 제작 기술 표시 장난감 퀘스트를 시작합니다)과 서기의 {item:262896}(호의 15)을 엽니다. 후자는 채울 수 없는 의뢰서를 같은 등급의 무작위 의뢰서와 바꿉니다. 평판 우호까지는 12,000이 더 필요합니다. 수습 의뢰서 160개, 전문가 96개, 대가 60개 또는 상자 반환 240회(상인의 호의 3,600). Forever의 퀘스트 데이터는 수습 의뢰서에 선호도 상한을 두지 않으니 그 고객들은 위 구간 단계에 있는 사람들입니다.",
	-- {item:270887} Advertising License Application
	["{item:270887}, 1,200 Merchant's Favor"] = "{item:270887}, 상인의 호의 1,200",

	-- Step 30: Revered to Exalted
	["Revered to Exalted"] = "평판 우호에서 확고",
	-- {item:284664} Packmule Treat · {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {npc:10636} Pack Kodo
	["Revered opens the {item:284664}, the Minimule pet (1,500 Favor from {npc:256389} or {npc:256384}). Exalted is 21000 more: 280 Journeyman writs, 168 Expert, 105 Artisan, or 420 crate returns (6,300 Favor). Keep 6,000 Favor for the {npc:10636} if you want it."] = "평판 우호가 {item:284664}, 미니뮬 애완동물({npc:256389} 또는 {npc:256384}에게서 상인의 호의 1,500)을 엽니다. 확고까지는 21,000이 더 필요합니다. 수습 의뢰서 280개, 전문가 168개, 대가 105개 또는 상자 반환 420회(상인의 호의 6,300). 원하면 {npc:10636}을(를) 위해 호의 6,000을 남겨 두세요.",
	-- {item:284664} Packmule Treat
	["{item:284664}, 1,500 Merchant's Favor"] = "{item:284664}, 상인의 호의 1,500",

	-- Step 31: Exalted
	["Exalted"] = "확고",
	-- {npc:256389} Tamelyn Aldridge · {npc:256384} Gishah · {item:262766} Reins of the Pack Kodo · {npc:256736} Huey Sunnydale · {area:1002} Three Corners · {npc:10636} Pack Kodo
	["Exalted opens the camp's tabard (200 Favor) at {npc:256389} or {npc:256384}, and the {item:262766} (6,000 Favor; the mount needs level 60 and Journeyman mount training) at {npc:256736} in {area:1002} or Okamache at the Crossroads camp. The {npc:10636} guide under Collectibles leads you there."] = "확고가 야영지의 휘장(호의 200)을 {npc:256389} 또는 {npc:256384}에게서, 그리고 {item:262766}(호의 6,000, 탈것은 60레벨과 수습 탈것 훈련 필요)을 {area:1002}의 {npc:256736} 또는 십자로 야영지의 오카마치에게서 엽니다. 수집품 아래의 {npc:10636} 가이드가 그 길을 안내합니다.",
	-- {item:262765} Azeroth Commerce Authority Tabard
	["{item:262765}, 200 Merchant's Favor"] = "{item:262765}, 상인의 호의 200",
	-- {item:262764} Durotar Supply and Logistics Tabard
	["{item:262764}, 200 Merchant's Favor"] = "{item:262764}, 상인의 호의 200",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dokimi"] = "도키미",
	-- ["Keep filling Waylaid Crates for Dokimi until Exalted."] = "확고한 동맹이 될 때까지 도키미에게 줄 잘못 놓인 보급품을 계속 채우십시오.",
	-- ["Keep filling Waylaid Crates for Dokimi."] = "도키미에게 줄 잘못 놓인 보급품을 계속 채우십시오.",
	-- ["Keep filling Waylaid Crates for {npc:214101} until Exalted."] = "확고한 동맹이 될 때까지 {npc:214101}에게 줄 잘못 놓인 보급품을 계속 채우십시오.",
	-- ["Keep filling Waylaid Crates for {npc:214101}."] = "{npc:214101}에게 줄 잘못 놓인 보급품을 계속 채우십시오.",
	-- ["Merchant's Favor Reputation"] = "상인의 호의 평판",
	-- ["The {faction:2586} is the Alliance's tradeskill faction in Forever. Its camp is at {area:1002} in western {zone:1433}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to {npc:214101} at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2586}은(는) Forever에서 얼라이언스의 전문 기술 세력입니다. 야영지는 {zone:1433} 서부의 {area:1002}에 있습니다. 레벨 10부터 몹이 잘못 놓인 보급품을 떨어뜨립니다. 상자마다 라벨에 적힌 물품을 채운 뒤 {object:1561}을(를) 야영지의 {npc:214101}에게 건네면 평판과 Merchant's Favor를 얻습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{faction:2586} to Exalted"] = "{faction:2586}: 확고한 동맹까지",
	-- ["{faction:2586} to Friendly"] = "{faction:2586}: 약간 우호적까지",
	-- ["{faction:2586} to Honored"] = "{faction:2586}: 우호적까지",
	-- ["{faction:2586} to Revered"] = "{faction:2586}: 매우 우호적까지",
	-- ["{faction:2587} is the Horde's tradeskill faction in Forever. Its camp is just outside the {area:380} in the {zone:1413}. From level 10 mobs drop Waylaid Crates: fill each with the goods its label asks for and hand the {object:1561} to Dokimi at the camp for reputation and Merchant's Favor. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:2587}은(는) Forever에서 호드의 전문 기술 세력입니다. 야영지는 {zone:1413}의 {area:380} 바로 바깥에 있습니다. 레벨 10부터 몹이 잘못 놓인 보급품을 떨어뜨립니다. 상자마다 라벨에 적힌 물품을 채운 뒤 {object:1561}을(를) 야영지의 도키미에게 건네면 평판과 Merchant's Favor를 얻습니다. Forever의 외교관 유산 특전은 평판 획득량을 늘려 줍니다.",
	-- ["{faction:2587} to Exalted"] = "{faction:2587}: 확고한 동맹까지",
	-- ["{faction:2587} to Friendly"] = "{faction:2587}: 약간 우호적까지",
	-- ["{faction:2587} to Honored"] = "{faction:2587}: 우호적까지",
	-- ["{faction:2587} to Revered"] = "{faction:2587}: 매우 우호적까지",
}
