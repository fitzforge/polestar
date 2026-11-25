-- Korean (koKR): the guide forever/professions/enchanting (forever/professions/enchanting.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Enchanting
	-- {skill:333} Enchanting
	["Learn {skill:333}"] = "{skill:333} 배우기",
	-- {skill:333} Enchanting · {npc:3606} Alanna Raveneye · {zone:1438} Teldrassil · {npc:11068} Betty Quin · {zone:1453} Stormwind City · {npc:257004} Eaysaa Brightgust · {npc:11070} Lalina Summermoon · {zone:1457} Darnassus · {npc:257020} Nasalanna Windsinger · {npc:11065} Thonys Pillarstone · {zone:1455} Ironforge · {npc:11066} Jhag · {zone:1454} Orgrimmar · {npc:11067} Malcomb Wynn · {zone:1458} Undercity · {npc:11071} Mot Dawnstrider · {zone:1456} Thunder Bluff · {npc:266881} Pa'zula · {zone:1411} Durotar · {npc:5695} Vance Undergloom · {zone:1420} Tirisfal Glades · {item:6217} Copper Rod · {item:247786} Mote of Magic · {npc:11072} Kitta Firewind · {area:91} Tower of Azora · {zone:1429} Elwynn Forest · {area:367} Sen'jin Village · {item:10940} Strange Dust
	["Apprentice {skill:333} lets you craft up to 75 for 10c, at any character level. Not every {skill:333} trainer teaches it: Alliance {npc:3606} ({zone:1438}), {npc:11068} ({zone:1453}), {npc:257004} (Zephras Isle), {npc:11070} ({zone:1457}), {npc:257020} (Zephras Isle) and {npc:11065} ({zone:1455}); Horde {npc:257004} (Zephras Isle), {npc:11066} ({zone:1454}), {npc:11067} ({zone:1458}), {npc:11071} ({zone:1456}), {npc:257020} (Zephras Isle), {npc:266881} ({zone:1411}) and {npc:5695} ({zone:1420}). The arrow picks the nearest of your faction. Buy a {item:6217} and {item:247786} from an enchanting supplies vendor (in the capitals and on Zephras Isle; the starting-area trainers have none beside them, and the next step's arrow picks the nearest). From now on, disenchant every green you do not wear: that is where the dust and essences come from. Two starter quests teach Disenchant on a quest item: An Enchanting Lesson from {npc:11072} ({area:91}, {zone:1429}) and A Pain in the Neck from {npc:266881} ({area:367}, {zone:1411}). 1-75 takes about 50c of recipes and 4s 44c of vendor goods, plus 51 {item:10940} to gather or buy."] = "초급 {skill:333}은(는) 10코퍼로 75까지 제작할 수 있게 해 주며, 캐릭터 레벨 제한이 없습니다. 모든 {skill:333} 상급자가 가르치지는 않습니다: 얼라이언스는 {npc:3606}({zone:1438}), {npc:11068}({zone:1453}), {npc:257004}(제프라스 섬), {npc:11070}({zone:1457}), {npc:257020}(제프라스 섬), {npc:11065}({zone:1455}), 호드는 {npc:257004}(제프라스 섬), {npc:11066}({zone:1454}), {npc:11067}({zone:1458}), {npc:11071}({zone:1456}), {npc:257020}(제프라스 섬), {npc:266881}({zone:1411}), {npc:5695}({zone:1420})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 마법부여 재료 상인에게서 {item:6217}와(과) {item:247786}을(를) 사세요(대도시와 제프라스 섬에 있습니다. 시작 지역 상급자 옆에는 없으며, 다음 단계의 화살표가 가장 가까운 상인을 가리킵니다). 이제부터 입지 않는 녹색 아이템은 모두 마력 추출하세요. 가루와 정수는 거기서 나옵니다. 퀘스트 아이템으로 마력 추출을 가르쳐 주는 입문 퀘스트가 두 개 있습니다: {npc:11072}({area:91}, {zone:1429})의 마법부여 수업 퀘스트와 {npc:266881}({area:367}, {zone:1411})의 퀘스트입니다. 1-75에는 제조법 약 50코퍼와 상인 재료 약 4실버 44코퍼, 그리고 채집하거나 살 {item:10940} 51개가 듭니다.",

	-- Step 2: Enchanting 1-75: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 1-75: vendor goods"] = "{skill:333} 1-75: 상인 재료",
	-- {item:6217} Copper Rod · {item:247786} Mote of Magic · {zone:1453} Stormwind City · {npc:1318} Jessara Cordell · {zone:1454} Orgrimmar · {npc:3346} Kithas
	-- was: ["Buy the whole bracket's share in one go: 1 {item:6217} (1s 24c) and 32 {item:247786} (3s 20c); about 4s 44c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286} and {npc:1318}; {zone:1454}: {npc:3367}, {npc:3346} and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:6217} 1개(1실버 24코퍼)와(과) {item:247786} 32개(3실버 20코퍼). 모두 약 4실버 44코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1286}, {npc:1318}; {zone:1454}: {npc:3367}, {npc:3346}, {npc:5817})."
	["Buy the whole bracket's share in one go: 1 {item:6217} (1s 24c) and 32 {item:247786} (3s 20c); about 4s 44c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1318}; {zone:1454}: {npc:3346})."] = "",

	-- Step 3: Get Strange Dust
	-- {item:10940} Strange Dust
	["Get {item:10940}"] = "",
	-- {item:10940} Strange Dust · {skill:333} Enchanting · {spell:7420} Enchant Chest - Inferior Stamina
	["You need 51 {item:10940} for {skill:333} 1-75: {spell:7420}. {skill:333}: disenchant green items of item level 5-20. Or buy them at the Auction House."] = "",

	-- Step 4: Enchant Bracer - Inferior Stamina to 25
	-- {spell:7418} Enchant Bracer - Inferior Stamina
	["{spell:7418} to 25"] = "{spell:7418}: 25까지",
	-- {spell:7418} Enchant Bracer - Inferior Stamina · {item:247786} Mote of Magic · {item:6218} Runed Copper Rod
	["{spell:7418} is orange at 1 (yellow 20, green 22, grey 25): about 31 crafts to 25. Each takes 1 {item:247786}. One {item:247786} (10c) a craft; grey at 25 on Forever. Make the {item:6218} first: the recipe needs it in your bags, so keep it there. Enchant any item for that slot in your bags, even a grey one."] = "{spell:7418}은(는) 1에 주황색입니다(노란색 20, 초록색 22, 회색 25). 25까지 약 31번 만드세요. 한 번에 {item:247786} 1개. 제작당 {item:247786}(10코퍼) 한 개. Forever에서는 25에서 회색입니다. 먼저 {item:6218}을(를) 만드세요. 제조법이 가방에 그것을 요구하니 거기 두세요. 가방 안의 그 칸에 맞는 아이템이면 어떤 것이든, 회색이라도 부여할 수 있습니다.",
	["a tool: keep it in your bags"] = "도구: 가방에 넣어 두세요",

	-- Step 5: Enchanting recipes at 25
	-- {skill:333} Enchanting
	["{skill:333} recipes at 25"] = "25에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:7420} Enchant Chest - Inferior Stamina · {spell:1230643} Enchanted Lute · {item:4470} Simple Wood · {item:10940} Strange Dust
	["Back to an {skill:333} trainer: {spell:7420} (from 15, 50c). Also learn {spell:1230643} (1s): Forever's {skill:333} camp item, 1 {item:4470} and 1 {item:10940}, placed at a campsite beside a campfire for its buff. The Camping 101: {skill:333} quest from your starting area's camping guide (after The Great Outdoors) sends you to an enchanting trainer who teaches it free."] = "{skill:333} 상급자에게 돌아가세요: {spell:7420}(15부터, 50코퍼). {spell:1230643}(1실버)도 배우세요. Forever의 {skill:333} 야영 아이템으로, {item:4470} 1개와 {item:10940} 1개가 들고 모닥불 옆 야영지에 설치하면 강화 효과를 줍니다. 시작 지역의 야영 가이드에 있는 야영 기초 101: {skill:333} 퀘스트(위대한 야외 다음)가 부여술 상급자에게 보내며, 거기서 무료로 가르칩니다.",

	-- Step 6: Enchant Chest - Inferior Stamina to 75
	-- {spell:7420} Enchant Chest - Inferior Stamina
	["{spell:7420} to 75"] = "{spell:7420}: 75까지",
	-- {spell:7420} Enchant Chest - Inferior Stamina · {item:10940} Strange Dust · {item:10938} Lesser Magic Essence · {spell:7423} Minor Absorption
	["{spell:7420} is orange at 25 (yellow 70, green 90, grey 110): about 51 crafts to 75. Each takes 1 {item:10940}. One {item:10940} a craft: the dust most level 5-20 greens break into, armour above all. {item:10938} (from weapons) does the same job through Bracer - Minor Deflect or Chest - {spell:7423} if you have more of it. Enchant any item for that slot in your bags, even a grey one."] = "{spell:7420}은(는) 25에 주황색입니다(노란색 70, 초록색 90, 회색 110). 75까지 약 51번 만드세요. 한 번에 {item:10940} 1개. 제작당 {item:10940} 한 개. 5-20레벨 녹색 아이템이 주로 부서져 나오는 가루이며, 방어구가 가장 많습니다. {item:10938}(무기에서)은(는) 더 많이 가졌다면 팔찌 - 작은 회피이나 가슴보호구 - {spell:7423}으로 같은 일을 합니다. 가방 안의 그 칸에 맞는 아이템이면 어떤 것이든, 회색이라도 부여할 수 있습니다.",

	-- Step 7: Journeyman Enchanting
	-- {skill:333} Enchanting
	["Journeyman {skill:333}"] = "수습 {skill:333}",
	-- {skill:333} Enchanting · {npc:5157} Gimble Thistlefuzz · {zone:1455} Ironforge · {npc:1317} Lucan Cordell · {zone:1453} Stormwind City · {npc:4213} Taladan · {zone:1457} Darnassus · {npc:7949} Xylinnia Starshine · {zone:1444} Feralas · {npc:3345} Godan · {zone:1454} Orgrimmar · {npc:4616} Lavinia Crowe · {zone:1458} Undercity · {npc:3011} Teg Dawnstrider · {zone:1456} Thunder Bluff · {spell:7771} Enchant Cloak - Minor Protection · {item:1210} Shadowgem · {item:6338} Silver Rod · {item:10938} Lesser Magic Essence · {item:10940} Strange Dust · {item:11083} Soul Dust
	["Journeyman raises the cap from 75 to 150 for 5s (Classic's price; Forever's is not in the data); it needs {skill:333} 50 and character level 10, so you can take it on any visit from 50. Not every {skill:333} trainer teaches it: Alliance {npc:5157} ({zone:1455}), {npc:1317} ({zone:1453}), {npc:4213} ({zone:1457}) and {npc:7949} ({zone:1444}); Horde {npc:3345} ({zone:1454}), {npc:4616} ({zone:1458}) and {npc:3011} ({zone:1456}). The arrow picks the nearest of your faction. Learn now: {spell:7771} (from 70, 2s). 75-150 takes about 2s of recipes, plus 1 {item:1210}, 1 {item:6338}, 4 {item:10938}, 121 {item:10940} and 20 {item:11083} to gather or buy."] = "수습 단계는 5실버(클래식 가격이며, Forever 가격은 데이터에 없습니다)로 최대 숙련도를 75에서 150으로 올립니다. {skill:333} 50과 캐릭터 레벨 10이 필요하므로, 50이 되면 언제 들러도 배울 수 있습니다. 모든 {skill:333} 상급자가 가르치지는 않습니다: 얼라이언스는 {npc:5157}({zone:1455}), {npc:1317}({zone:1453}), {npc:4213}({zone:1457}), {npc:7949}({zone:1444}), 호드는 {npc:3345}({zone:1454}), {npc:4616}({zone:1458}), {npc:3011}({zone:1456})입니다. 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:7771}(70부터, 2실버). 75-150에는 제조법 약 2실버, 그리고 채집하거나 살 {item:1210} 1개, {item:6338} 1개, {item:10938} 4개, {item:10940} 121개, {item:11083} 20개가 듭니다.",

	-- Step 8: Enchanting 75-150: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 75-150: vendor goods"] = "{skill:333} 75-150: 상인 재료",
	-- {item:10938} Lesser Magic Essence
	["Buy the whole bracket's share in one go: 4 {item:10938} (32s). The arrow picks the nearest seller of your faction. {item:10938}: no vendor of the other faction sells it; that side gathers or buys it at the Auction House (next steps)."] = "이 구간에 필요한 몫을 한 번에 사십시오: {item:10938} 4개(32실버). 화살표가 진영의 가장 가까운 판매 상인을 가리킵니다. {item:10938}: 반대 진영의 상인은 팔지 않으므로, 그쪽은 채집하거나 경매장에서 삽니다(다음 단계).",

	-- Step 9: Get Shadowgem
	-- {item:1210} Shadowgem
	["Get {item:1210}"] = "",
	-- {item:1210} Shadowgem · {skill:333} Enchanting · {item:6339} Runed Silver Rod · {object:1731} Copper Vein · {object:1732} Tin Vein · {object:1733} Silver Vein
	["You need 1 {item:1210} for {skill:333} 75-150: {item:6339}. {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining. Or buy it at the Auction House."] = "",

	-- Step 10: Get Silver Rod
	-- {item:6338} Silver Rod
	["Get {item:6338}"] = "",
	-- {item:6338} Silver Rod · {skill:333} Enchanting · {item:6339} Runed Silver Rod · {skill:164} Blacksmithing
	["You need 1 {item:6338} for {skill:333} 75-150: {item:6339}. {skill:164}: {item:6338}. Or buy it at the Auction House."] = "",

	-- Step 11: Get Strange Dust
	-- {item:10940} Strange Dust · {skill:333} Enchanting · {spell:7420} Enchant Chest - Inferior Stamina · {spell:7771} Enchant Cloak - Minor Protection · {item:6339} Runed Silver Rod
	["You need 121 {item:10940} for {skill:333} 75-150: {spell:7420}, {spell:7771} and {item:6339}. {skill:333}: disenchant green items of item level 5-20. Or buy them at the Auction House."] = "",

	-- Step 12: Get Soul Dust
	-- {item:11083} Soul Dust
	["Get {item:11083}"] = "",
	-- {item:11083} Soul Dust · {skill:333} Enchanting · {spell:13501} Enchant Bracer - Lesser Stamina
	["You need 20 {item:11083} for {skill:333} 75-150: {spell:13501}. {skill:333}: disenchant green items of item level 21-30. Or buy them at the Auction House."] = "",

	-- Step 13: Enchanting 75-150: Auction House
	-- {skill:333} Enchanting
	["{skill:333} 75-150: Auction House"] = "{skill:333} 75-150: 경매장",
	-- {item:10938} Lesser Magic Essence
	["What 75-150 takes that the Auction House sells and no step above farms: 4 {item:10938}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 14: Enchant Chest - Inferior Stamina to 90
	-- {spell:7420} Enchant Chest - Inferior Stamina
	["{spell:7420} to 90"] = "{spell:7420}: 90까지",
	-- {spell:7420} Enchant Chest - Inferior Stamina · {item:10940} Strange Dust · {item:10938} Lesser Magic Essence · {spell:7423} Minor Absorption
	["{spell:7420} is yellow at 75 (yellow 70, green 90, grey 110): about 22 crafts to 90. Each takes 1 {item:10940}. One {item:10940} a craft: the dust most level 5-20 greens break into, armour above all. {item:10938} (from weapons) does the same job through Bracer - Minor Deflect or Chest - {spell:7423} if you have more of it. Enchant any item for that slot in your bags, even a grey one. If you got here without learning {spell:7420}, learn it now: an earlier step teaches it."] = "{spell:7420}은(는) 75에서 노란색입니다(노란색 70, 초록색 90, 회색 110): 90까지 약 22번 제작. 매번 {item:10940} 1개가 필요합니다. 제작마다 {item:10940} 하나: 5-20레벨 초록색 아이템 대부분, 특히 방어구에서 나오는 가루입니다. {item:10938}(무기에서)이 더 많다면 손목 - 하급 방어 또는 가슴 - {spell:7423}(으)로 같은 역할을 합니다. 가방에 있는 해당 부위 아이템이면 회색이라도 마법부여하십시오. {spell:7420}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 15: Enchant Cloak - Minor Protection to 130
	-- {spell:7771} Enchant Cloak - Minor Protection
	["{spell:7771} to 130"] = "{spell:7771}: 130까지",
	-- {spell:7771} Enchant Cloak - Minor Protection · {item:10940} Strange Dust
	["{spell:7771} is orange at 90 (yellow 110, green 130, grey 150): about 48 crafts to 130. Each takes 2 {item:10940}. Two {item:10940} a craft (the trainer teaches it from 70 for 2s); keep disenchanting the greens of the 10-20 zones. Enchant any item for that slot in your bags, even a grey one."] = "{spell:7771}은(는) 90에 주황색입니다(노란색 110, 초록색 130, 회색 150). 130까지 약 48번 만드세요. 한 번에 {item:10940} 2개. 제작당 {item:10940} 두 개(상급자가 70에서 2실버에 가르침). 10-20 구간의 녹색 아이템을 계속 분해하세요. 가방 안의 그 칸에 맞는 아이템이면 어떤 것이든, 회색이라도 부여할 수 있습니다.",

	-- Step 16: Enchanting recipes at 130
	-- {skill:333} Enchanting
	["{skill:333} recipes at 130"] = "130에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:7795} Runed Silver Rod · {spell:13501} Enchant Bracer - Lesser Stamina
	["Back to an {skill:333} trainer: {spell:7795} (from 100) and {spell:13501} (from 130)."] = "{skill:333} 상급자에게 돌아가세요: {spell:7795}(100부터), {spell:13501}(130부터).",

	-- Step 17: Enchant Bracer - Lesser Stamina to 150
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 150"] = "{spell:13501}: 150까지",
	-- {spell:13501} Enchant Bracer - Lesser Stamina · {item:11083} Soul Dust · {item:6339} Runed Silver Rod · {item:10938} Lesser Magic Essence · {skill:333} Enchanting
	["{spell:13501} is orange at 130 (yellow 155, green 175, grey 195): about 20 crafts to 150, a point every craft. Each takes 1 {item:11083}. One {item:11083} a craft (level 21-30 greens). Make the {item:6339} first: the recipe needs it in your bags, so keep it there. {item:10938} (4 for 75-150): Alliance: {skill:333}: disenchant green items of item level 5-15; or the Auction House. Enchant any item for that slot in your bags, even a grey one. {skill:333} 150 is a Legacy System milestone."] = "{spell:13501}은(는) 130에 주황색입니다(노란색 155, 초록색 175, 회색 195). 150까지 약 20번 만드십시오. 만들 때마다 1점씩 오릅니다. 하나에 {item:11083} 1개가 듭니다. 제작마다 {item:11083} 하나(21-30레벨 녹색 아이템). 먼저 {item:6339}을(를) 만드십시오. 제조법에 가방 안의 그것이 필요하니 가방에 두십시오. {item:10938}(75-150에 4개): 얼라이언스: {skill:333}: 아이템 레벨 5-15 녹색 아이템 마력 추출, 또는 경매장. 가방에 있는 해당 부위 아이템이면 회색이라도 아무것에나 마법을 부여하십시오. {skill:333} 150은(는) 유산 시스템 달성 목표입니다.",

	-- Step 18: Get Iridescent Pearl (Alliance)
	-- {item:5500} Iridescent Pearl
	-- was: ["{item:5500} (Alliance)"] = "{item:5500} (얼라이언스)"
	["Get {item:5500} (Alliance)"] = "",
	-- {item:5500} Iridescent Pearl · {skill:333} Enchanting · {item:11130} Runed Golden Rod
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["You need 1 {item:5500} for {skill:333} 150-225: {item:11130}. Open the Giant Clams at the marked spot. Or buy it at the Auction House."] = "",

	-- Step 19: Get Iridescent Pearl (Horde)
	-- {item:5500} Iridescent Pearl
	-- was: ["{item:5500} (Horde)"] = "{item:5500} (호드)"
	["Get {item:5500} (Horde)"] = "",

	-- Step 20: Get Greater Astral Essence
	-- {item:11082} Greater Astral Essence
	["Get {item:11082}"] = "",
	-- {item:11082} Greater Astral Essence · {skill:333} Enchanting · {item:11130} Runed Golden Rod
	["You need 1 {item:11082} for {skill:333} 150-225: {item:11130}. {skill:333}: disenchant green items of item level 16-25. Or buy it at the Auction House."] = "",

	-- Step 21: Get Soul Dust
	-- {item:11083} Soul Dust · {skill:333} Enchanting · {item:11130} Runed Golden Rod · {spell:13501} Enchant Bracer - Lesser Stamina · {spell:13637} Enchant Boots - Lesser Agility
	["You need 71 {item:11083} for {skill:333} 150-225: {item:11130}, {spell:13501} and {spell:13637}. {skill:333}: disenchant green items of item level 21-30. Or buy them at the Auction House."] = "",

	-- Step 22: Get Golden Rod
	-- {item:11128} Golden Rod
	["Get {item:11128}"] = "",
	-- {item:11128} Golden Rod · {skill:333} Enchanting · {item:11130} Runed Golden Rod · {skill:164} Blacksmithing
	["You need 1 {item:11128} for {skill:333} 150-225: {item:11130}. {skill:164}: {item:11128}. Or buy it at the Auction House."] = "",

	-- Step 23: Get Greater Mystic Essence
	-- {item:11135} Greater Mystic Essence
	["Get {item:11135}"] = "",
	-- {item:11135} Greater Mystic Essence · {skill:333} Enchanting · {item:11145} Runed Truesilver Rod
	["You need 1 {item:11135} for {skill:333} 150-225: {item:11145}. {skill:333}: disenchant green items of item level 26-35. Or buy it at the Auction House."] = "",

	-- Step 24: Get Vision Dust
	-- {item:11137} Vision Dust
	["Get {item:11137}"] = "",
	-- {item:11137} Vision Dust · {skill:333} Enchanting · {item:11145} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense
	["You need 21 {item:11137} for {skill:333} 150-225: {item:11145} and {spell:13746}. {skill:333}: disenchant green items of item level 31-40. Or buy them at the Auction House."] = "",

	-- Step 25: Get Truesilver Rod
	-- {item:11144} Truesilver Rod
	["Get {item:11144}"] = "",
	-- {item:11144} Truesilver Rod · {skill:333} Enchanting · {item:11145} Runed Truesilver Rod · {skill:164} Blacksmithing
	["You need 1 {item:11144} for {skill:333} 150-225: {item:11145}. {skill:164}: {item:11144}. Or buy it at the Auction House."] = "",

	-- Step 26: Enchanting 150-225: Auction House
	-- {skill:333} Enchanting
	["{skill:333} 150-225: Auction House"] = "{skill:333} 150-225: 경매장",
	-- {item:7971} Black Pearl
	["What 150-225 takes that the Auction House sells and no step above farms: 1 {item:7971}. The counts drop by what your bags, bank and mail hold."] = "",

	-- Step 27: Expert Enchanting
	-- {skill:333} Enchanting
	["Expert {skill:333}"] = "숙련 {skill:333}",
	-- {skill:333} Enchanting · {npc:11072} Kitta Firewind · {zone:1429} Elwynn Forest · {npc:11074} Hgarth · {zone:1442} Stonetalon Mountains · {spell:13628} Runed Golden Rod · {item:5500} Iridescent Pearl · {item:7971} Black Pearl · {item:11082} Greater Astral Essence · {item:11083} Soul Dust · {item:11128} Golden Rod · {item:11135} Greater Mystic Essence · {item:11137} Vision Dust · {item:11144} Truesilver Rod · {spell:13637} Enchant Boots - Lesser Agility · {item:11145} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense
	["Expert raises the cap from 150 to 225 for 50s (Classic's price; Forever's is not in the data); it needs {skill:333} 125 and character level 20, so you can take it on any visit from 125. Only a few trainers teach it: Alliance {npc:11072} ({zone:1429}); Horde {npc:11074} ({zone:1442}). The arrow picks the nearest of your faction. Learn now: {spell:13628} (from 150). 150-225 takes 1 {item:5500}, 1 {item:7971}, 1 {item:11082}, 71 {item:11083}, 1 {item:11128}, 1 {item:11135}, 21 {item:11137} and 1 {item:11144} to gather or buy. Come with all of it in your bags (the steps above, the rest from the Auction House): these trainers also teach {spell:13637} (from 160), {item:11145} (from 200) and {spell:13746} (from 205), and the crafts need no station, so craft right here and learn each recipe as you reach its skill. One trip instead of 3."] = "숙련 단계는 50실버(클래식 가격이며, Forever 가격은 데이터에 없습니다)로 최대 숙련도를 150에서 225으로 올립니다. {skill:333} 125와 캐릭터 레벨 20이 필요하므로, 125부터 언제 들러도 배울 수 있습니다. 가르치는 상급자는 몇 명뿐입니다: 얼라이언스 {npc:11072}({zone:1429}), 호드 {npc:11074}({zone:1442}). 화살표가 진영의 가장 가까운 상급자를 가리킵니다. 지금 배우세요: {spell:13628}(150부터). 150-225에는 {item:5500} 1개, {item:7971} 1개, {item:11082} 1개, {item:11083} 71개, {item:11128} 1개, {item:11135} 1개, {item:11137} 21개, {item:11144} 1개를 채집하거나 구매해야 합니다. 모두 가방에 넣어 오세요(위의 단계, 나머지는 경매장에서). 이 상급자들은 {spell:13637}(160부터), {item:11145}(200부터), {spell:13746}(205부터)도 가르치고, 제작에는 작업대가 필요 없으니 여기서 바로 만들고 숙련도에 도달할 때마다 제조법을 배우세요. 3번 대신 한 번의 여행입니다.",

	-- Step 28: Enchant Bracer - Lesser Stamina to 160
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 160"] = "{spell:13501}: 160까지",
	-- {spell:13501} Enchant Bracer - Lesser Stamina · {item:11083} Soul Dust · {item:11130} Runed Golden Rod
	["{spell:13501} is orange at 150 (yellow 155, green 175, grey 195): about 11 crafts to 160. Each takes 1 {item:11083}. One {item:11083} a craft (level 21-30 greens). Make the {item:11130} now, while it still gives a point: a later recipe needs it in your bags, so keep it there. Enchant any item for that slot in your bags, even a grey one. If you got here without learning {spell:13501}, learn it now: an earlier step teaches it."] = "{spell:13501}은(는) 150에서 주황색입니다(노란색 155, 초록색 175, 회색 195): 160까지 약 11번 제작. 매번 {item:11083} 1개가 필요합니다. 제작마다 {item:11083} 하나(21-30레벨 초록색 아이템). 아직 숙련도가 오를 때 지금 {item:11130}을(를) 만드십시오: 나중 제조법이 가방에 있어야 하니 보관하십시오. 가방에 있는 해당 부위 아이템이면 회색이라도 마법부여하십시오. {spell:13501}을(를) 배우지 않고 여기까지 왔다면 지금 배우십시오: 앞의 단계에서 가르칩니다.",

	-- Step 29: Enchanting recipes at 160
	-- {skill:333} Enchanting
	["{skill:333} recipes at 160"] = "160에서 {skill:333} 제조법",
	-- {spell:13637} Enchant Boots - Lesser Agility
	["Still at the Expert trainer: {spell:13637} (from 160)."] = "계속 숙련 상급자에게서: {spell:13637}(160부터).",

	-- Step 30: Enchant Boots - Lesser Agility to 205
	-- {spell:13637} Enchant Boots - Lesser Agility
	["{spell:13637} to 205"] = "{spell:13637}: 205까지",
	-- {spell:13637} Enchant Boots - Lesser Agility · {item:11083} Soul Dust
	["{spell:13637} is orange at 160 (yellow 180, green 200, grey 220): about 59 crafts to 205. Each takes 1 {item:11083}. {item:11083} again. Enchant any item for that slot in your bags, even a grey one."] = "{spell:13637}은(는) 160에 주황색입니다(노란색 180, 초록색 200, 회색 220). 205까지 약 59번 만드세요. 한 번에 {item:11083} 1개. {item:11083}이(가) 다시 필요합니다. 가방 안의 그 칸에 맞는 아이템이면 어떤 것이든, 회색이라도 부여할 수 있습니다.",

	-- Step 31: Enchanting recipes at 205
	-- {skill:333} Enchanting
	["{skill:333} recipes at 205"] = "205에서 {skill:333} 제조법",
	-- {spell:13702} Runed Truesilver Rod · {spell:13746} Enchant Cloak - Greater Defense
	["Still at the Expert trainer: {spell:13702} (from 200) and {spell:13746} (from 205)."] = "계속 숙련 상급자에게서: {spell:13702}(200부터)과(와) {spell:13746}(205부터).",

	-- Step 32: Enchant Cloak - Greater Defense to 225
	-- {spell:13746} Enchant Cloak - Greater Defense
	["{spell:13746} to 225"] = "{spell:13746}: 225까지",
	-- {spell:13746} Enchant Cloak - Greater Defense · {item:11137} Vision Dust · {item:11145} Runed Truesilver Rod · {item:7971} Black Pearl · {skill:333} Enchanting
	["{spell:13746} is orange at 205 (yellow 225, green 245, grey 265): about 20 crafts to 225, a point every craft. Each takes 1 {item:11137}. One {item:11137} a craft (level 31-40 greens). Make the {item:11145} first: the recipe needs it in your bags, so keep it there. {item:7971} (1 for 150-225): {item:7971} is a rare drop (no mob gives it one time in 50): buy it at the Auction House, or keep the ones you find. Enchant any item for that slot in your bags, even a grey one. {skill:333} 225 is a Legacy System milestone."] = "{spell:13746}은(는) 205에 주황색입니다(노란색 225, 초록색 245, 회색 265). 225까지 약 20번 만드세요, 매번 포인트가 오릅니다. 한 번에 {item:11137} 1개. 제작당 {item:11137} 한 개(31-40레벨 녹색 아이템). 먼저 {item:11145}을(를) 만드세요. 제조법이 가방에 그것을 요구하니 거기 두세요. {item:7971}(150-225에 1개): {item:7971}은(는) 희귀 드롭입니다(어떤 몹도 50분의 1로 주지 않습니다). 경매장에서 사거나 찾은 것을 간직하세요. 가방 안의 그 칸에 맞는 아이템이면 어떤 것이든, 회색이라도 부여할 수 있습니다. {skill:333} 225은(는) 유산 시스템 이정표입니다.",

	-- Step 33: Artisan Enchanting
	-- {skill:333} Enchanting
	["Artisan {skill:333}"] = "전문 {skill:333}",
	-- {skill:333} Enchanting · {npc:11073} Annora · {area:1517} Uldaman · {zone:1418} Badlands · {spell:13815} Enchant Gloves - Agility · {item:8831} Purple Lotus · {item:11137} Vision Dust · {item:11176} Dream Dust
	["Artisan raises the cap from 225 to 300 for 5g (Classic's price; Forever's is not in the data); it needs {skill:333} 200 and character level 35, so you can take it on any visit from 200. {npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group. Learn now: {spell:13815} (from 210). 225-300 takes about 2g 20s of recipes and 1g 70s of vendor goods, plus 34 {item:8831}, 39 {item:11137} and 208 {item:11176} to gather or buy."] = "전문 단계는 5골드(클래식 가격이며, Forever 가격은 데이터에 없습니다)로 최대 숙련도를 225에서 300으로 올립니다. {skill:333} 200과 캐릭터 레벨 35가 필요하므로, 200부터 언제 들러도 배울 수 있습니다. {npc:11073}이(가) {area:1517} 던전({zone:1418}) 안에서 전문 {skill:333}을(를) 가르칩니다. 파티를 데려가세요. 지금 배우세요: {spell:13815}(210부터). 225-300에는 제조법 약 2골드 20실버와 상인 재료 1골드 70실버, 그리고 {item:8831} 34개, {item:11137} 39개, {item:11176} 208개를 채집하거나 구매해야 합니다.",

	-- Step 34: Enchanting 225-300: vendor goods
	-- {skill:333} Enchanting
	["{skill:333} 225-300: vendor goods"] = "{skill:333} 225-300: 상인 재료",
	-- {item:8925} Crystal Vial · {zone:1453} Stormwind City · {npc:1286} Edna Mullby · {npc:1325} Jasper Fel · {zone:1454} Orgrimmar · {npc:3367} Felika · {npc:3348} Kor'geld · {npc:3334} Rekkul
	["Buy the whole bracket's share in one go: 34 {item:8925} (1g 70s); about 1g 70s in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286}, Eldraeith and {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348} and {npc:3334})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:8925} 34개(1골드 70실버). 모두 약 1골드 70실버. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1286}, Eldraeith, {npc:1325}; {zone:1454}: {npc:3367}, {npc:3348}, {npc:3334}).",

	-- Step 35: Formula: Lesser Mana Oil
	-- {item:20754} Formula: Lesser Mana Oil · {item:20747} Lesser Mana Oil · {skill:333} Enchanting · {npc:15419} Kania · {zone:1451} Silithus
	["{item:20754} teaches {item:20747} ({skill:333} 250) for 1g. Sold by {npc:15419} ({zone:1451})."] = "{item:20754}은(는) 1골드에 {item:20747}({skill:333} 250)을(를) 가르칩니다. {npc:15419}({zone:1451})이(가) 팝니다.",

	-- Step 36: Formula: Enchant Shield - Greater Stamina
	-- {item:16217} Formula: Enchant Shield - Greater Stamina · {spell:20017} Enchant Shield - Greater Stamina · {skill:333} Enchanting · {npc:4229} Mythrin'dir · {zone:1457} Darnassus · {npc:4561} Daniel Bartlett · {zone:1458} Undercity
	["{item:16217} teaches {spell:20017} ({skill:333} 265) for 1g 20s. Sold by Alliance: {npc:4229} ({zone:1457}), limited stock; Horde: {npc:4561} ({zone:1458}), limited stock. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it."] = "{item:16217}은(는) 1골드 20실버에 {spell:20017}({skill:333} 265)을(를) 가르칩니다. 얼라이언스 판매: {npc:4229}({zone:1457}), 수량 제한; 호드 판매: {npc:4561}({zone:1458}), 수량 제한. 판매자는 한두 개를 재고로 두고 판매 후 얼마 지나면 다시 들여놓습니다. 주울 때 귀속되므로 경매장에는 절대 없습니다.",

	-- Step 37: Get Purple Lotus (Alliance)
	-- {item:8831} Purple Lotus
	-- was: ["{item:8831} (Alliance)"] = "{item:8831} (얼라이언스)"
	["Get {item:8831} (Alliance)"] = "",
	-- {item:8831} Purple Lotus · {skill:333} Enchanting · {item:20747} Lesser Mana Oil · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- was: ["34 {item:8831} for {item:20747}: {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8831} in {zone:1425} is marked."] = "{item:20747}에 필요한 {item:8831} 34개: {skill:182}: {item:8831}(숙련도 210) {zone:1425}(40-50), {zone:1444}(40-50), {zone:1447}(45-55). {zone:1425}(40-50)에서 가장 많이 나는 {item:8831} 지역이 표시됩니다."
	["You need 34 {item:8831} for {skill:333} 225-300: {item:20747}. {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8831} in {zone:1425} is marked. Or buy them at the Auction House."] = "",

	-- Step 38: Get Purple Lotus (Horde)
	-- {item:8831} Purple Lotus
	-- was: ["{item:8831} (Horde)"] = "{item:8831} (호드)"
	["Get {item:8831} (Horde)"] = "",
	-- {item:8831} Purple Lotus · {skill:333} Enchanting · {item:20747} Lesser Mana Oil · {skill:182} Herbalism · {zone:1425} The Hinterlands · {zone:1444} Feralas · {zone:1447} Azshara
	-- was: ["34 {item:8831} for {item:20747}: {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8831} in {zone:1444} is marked."] = "{item:20747}에 필요한 {item:8831} 34개: {skill:182}: {item:8831}(숙련도 210) {zone:1425}(40-50), {zone:1444}(40-50), {zone:1447}(45-55). {zone:1444}(40-50)에서 가장 많이 나는 {item:8831} 지역이 표시됩니다."
	["You need 34 {item:8831} for {skill:333} 225-300: {item:20747}. {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8831} in {zone:1444} is marked. Or buy them at the Auction House."] = "",

	-- Step 39: Get Vision Dust
	-- {item:11137} Vision Dust · {skill:333} Enchanting · {spell:13815} Enchant Gloves - Agility
	["You need 39 {item:11137} for {skill:333} 225-300: {spell:13815}. {skill:333}: disenchant green items of item level 31-40. Or buy them at the Auction House."] = "",

	-- Step 40: Get Dream Dust
	-- {item:11176} Dream Dust
	["Get {item:11176}"] = "",
	-- {item:11176} Dream Dust · {skill:333} Enchanting · {item:20747} Lesser Mana Oil · {spell:20017} Enchant Shield - Greater Stamina
	["You need 208 {item:11176} for {skill:333} 225-300: {item:20747} and {spell:20017}. {skill:333}: disenchant green items of item level 41-50. Or buy them at the Auction House."] = "",

	-- Step 41: Enchant Gloves - Agility to 253
	-- {spell:13815} Enchant Gloves - Agility
	["{spell:13815} to 253"] = "{spell:13815}: 253까지",
	-- {spell:13815} Enchant Gloves - Agility · {item:11137} Vision Dust · {npc:11073} Annora
	["{spell:13815} is orange at 225 (yellow 230, green 250, grey 270): about 39 crafts to 253. Each takes 1 {item:11137}. {npc:11073} teaches it with Artisan: learn it on that visit. {item:11137} again; bring about 40. Enchant any item for that slot in your bags, even a grey one."] = "{spell:13815}은(는) 225에 주황색입니다(노란색 230, 초록색 250, 회색 270). 253까지 약 39번 만드세요. 한 번에 {item:11137} 1개. {npc:11073}이(가) 전문과 함께 가르치니 그 방문에서 배우세요. {item:11137}이(가) 다시 필요합니다. 약 40개를 가져오세요. 가방 안의 그 칸에 맞는 아이템이면 어떤 것이든, 회색이라도 부여할 수 있습니다.",

	-- Step 42: Lesser Mana Oil to 275
	-- {item:20747} Lesser Mana Oil
	["{item:20747} to 275"] = "{item:20747}: 275까지",
	-- {item:20747} Lesser Mana Oil · {item:11176} Dream Dust · {item:8831} Purple Lotus · {item:8925} Crystal Vial · {npc:15419} Kania · {area:3425} Cenarion Hold · {zone:1451} Silithus
	["{item:20747} is orange at 253 (yellow 260, green 270, grey 280): about 34 crafts to 275. Each takes 1 {item:11176}, 1 {item:8831} and 1 {item:8925}. One {item:11176} (level 41-50 greens) and one {item:8831} (herbalists) a craft; the oil sells well. {npc:15419} sells the formula at the inn of {area:3425} ({zone:1451}): fly there, the mobs around it are level 55 and up."] = "{item:20747}은(는) 253에 주황색입니다(노란색 260, 초록색 270, 회색 280). 275까지 약 34번 만드세요. 한 번에 {item:11176} 1개, {item:8831} 1개, {item:8925} 1개. 제작당 {item:11176}(41-50레벨 녹색 아이템) 한 개와 {item:8831}(약초채집가) 한 개. 기름은 잘 팔립니다. {npc:15419}이(가) {area:3425}({zone:1451})의 여관에서 제조법을 팝니다. 그곳으로 날아가세요. 주변 몹은 55레벨 이상입니다.",
	["from the recipe in your bags"] = "가방에 있는 제조법으로",

	-- Step 43: Enchant Shield - Greater Stamina to 300
	-- {spell:20017} Enchant Shield - Greater Stamina
	["{spell:20017} to 300"] = "{spell:20017}: 300까지",
	-- {spell:20017} Enchant Shield - Greater Stamina · {item:11176} Dream Dust · {skill:333} Enchanting
	["{spell:20017} is orange at 275 (yellow 285, green 305, grey 325): about 29 crafts to 300. Each takes 6 {item:11176}. Six {item:11176} a craft: the dearest stretch, so disenchant every level 41-50 green you find. Enchant any item for that slot in your bags, even a grey one. {skill:333} 300 is a Legacy System milestone."] = "{spell:20017}은(는) 275에 주황색입니다(노란색 285, 초록색 305, 회색 325). 300까지 약 29번 만드세요. 한 번에 {item:11176} 6개. 제작당 {item:11176} 여섯 개. 가장 비싼 구간이니 찾는 41-50레벨 녹색 아이템은 모두 분해하세요. 가방 안의 그 칸에 맞는 아이템이면 어떤 것이든, 회색이라도 부여할 수 있습니다. {skill:333} 300은(는) 유산 시스템 이정표입니다.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["1 {item:11082} for {item:11130}: {skill:333}: disenchant green items of item level 16-25."] = "{item:11130}에 쓸 {item:11082} 1개: {skill:333}: 아이템 레벨 16-25 녹색 아이템 마력 추출.",
	-- ["1 {item:11128} for {item:11130}: {skill:164}: {item:11128}."] = "{item:11130}에 쓸 {item:11128} 1개: {skill:164}: {item:11128} 제작.",
	-- ["1 {item:11135} for {item:11145}: {skill:333}: disenchant green items of item level 26-35."] = "{item:11145}에 쓸 {item:11135} 1개: {skill:333}: 아이템 레벨 26-35 녹색 아이템 마력 추출.",
	-- ["1 {item:11144} for {item:11145}: {skill:164}: {item:11144}."] = "{item:11145}에 쓸 {item:11144} 1개: {skill:164}: {item:11144} 제작.",
	-- ["1 {item:1210} for {item:6339}: {item:1210} turns up in about one {object:1731}, {object:1732} or {object:1733} in 100: keep the ones you find while mining."] = "{item:6339}에 쓸 {item:1210} 1개: {item:1210}은(는) {object:1731}, {object:1732}, {object:1733} 약 100개 중 하나에서 나옵니다. 채광하며 얻은 것은 보관하십시오.",
	-- ["1 {item:5500} for {item:11130}: open the Giant Clams at the marked spot."] = "{item:11130}에 필요한 {item:5500} 1개: 표시된 곳의 대합를 여세요.",
	-- ["1 {item:6338} for {item:6339}: {skill:164}: {item:6338}."] = "{item:6339}에 쓸 {item:6338} 1개: {skill:164}: {item:6338} 제작.",
	-- ["121 {item:10940} for {spell:7420}, {spell:7771} and {item:6339}: {skill:333}: disenchant green items of item level 5-20."] = "{spell:7420}, {spell:7771}, {item:6339}에 쓸 {item:10940} 121개: {skill:333}: 아이템 레벨 5-20 녹색 아이템 마력 추출.",
	-- ["20 {item:11083} for {spell:13501}: {skill:333}: disenchant green items of item level 21-30."] = "{spell:13501}에 쓸 {item:11083} 20개: {skill:333}: 아이템 레벨 21-30 녹색 아이템 마력 추출.",
	-- ["208 {item:11176} for {item:20747} and {spell:20017}: {skill:333}: disenchant green items of item level 41-50."] = "{item:20747}와(과) {spell:20017}에 쓸 {item:11176} 208개: {skill:333}: 아이템 레벨 41-50 녹색 아이템 마력 추출.",
	-- ["21 {item:11137} for {item:11145} and {spell:13746}: {skill:333}: disenchant green items of item level 31-40."] = "{item:11145}와(과) {spell:13746}에 쓸 {item:11137} 21개: {skill:333}: 아이템 레벨 31-40 녹색 아이템 마력 추출.",
	-- ["34 {item:8831} for {item:20747}: {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8831} in {zone:1425} is marked."] = "{item:20747}에 필요한 {item:8831} 34개: {skill:182}: {item:8831}(숙련도 210) {zone:1425}(40-50), {zone:1444}(40-50), {zone:1447}(45-55). {zone:1425}(40-50)에서 가장 많이 나는 {item:8831} 지역이 표시됩니다.",
	-- ["34 {item:8831} for {item:20747}: {skill:182}: {item:8831} (skill 210) in {zone:1425} (40-50), {zone:1444} (40-50) and {zone:1447} (45-55). The densest patch of {item:8831} in {zone:1444} is marked."] = "{item:20747}에 필요한 {item:8831} 34개: {skill:182}: {item:8831}(숙련도 210) {zone:1425}(40-50), {zone:1444}(40-50), {zone:1447}(45-55). {zone:1444}(40-50)에서 가장 많이 나는 {item:8831} 지역이 표시됩니다.",
	-- ["39 {item:11137} for {spell:13815}: {skill:333}: disenchant green items of item level 31-40."] = "{spell:13815}에 쓸 {item:11137} 39개: {skill:333}: 아이템 레벨 31-40 녹색 아이템 마력 추출.",
	-- ["51 {item:10940} for {spell:7420}: {skill:333}: disenchant green items of item level 5-20."] = "{spell:7420}에 쓸 {item:10940} 51개: {skill:333}: 아이템 레벨 5-20 녹색 아이템 마력 추출.",
	-- ["71 {item:11083} for {item:11130}, {spell:13501} and {spell:13637}: {skill:333}: disenchant green items of item level 21-30."] = "{item:11130}, {spell:13501}, {spell:13637}에 쓸 {item:11083} 71개: {skill:333}: 아이템 레벨 21-30 녹색 아이템 마력 추출.",
	-- ["Apprentice {skill:333}"] = "초급 {skill:333}",
	-- ["Artisan needs character level 35 and {skill:333} 200; it raises the cap to 300. Materials for 225-300 are worth about 30s in all."] = "전문은(는) 캐릭터 레벨 35, {skill:333} 200이(가) 필요하며 최대 숙련도를 300(으)로 올립니다. 225-300 재료는 모두 약 30실버입니다.",
	-- ["Back to an {skill:333} trainer: {spell:13501} is taught from {skill:333} 155."] = "{skill:333} 상급자에게 돌아가세요. {spell:13501}은(는) {skill:333} 155부터 배울 수 있습니다.",
	-- ["Back to an {skill:333} trainer: {spell:13661} is taught from {skill:333} 200."] = "{skill:333} 상급자에게 돌아가세요. {spell:13661}은(는) {skill:333} 200부터 배울 수 있습니다.",
	-- ["Back to an {skill:333} trainer: {spell:13935} is taught from {skill:333} 255."] = "{skill:333} 상급자에게 돌아가세요. {spell:13935}은(는) {skill:333} 255부터 배울 수 있습니다.",
	-- ["Back to an {skill:333} trainer: {spell:13948} is taught from {skill:333} 270."] = "{skill:333} 상급자에게 돌아가세요. {spell:13948}은(는) {skill:333} 270부터 배울 수 있습니다.",
	-- ["Back to an {skill:333} trainer: {spell:7426} is taught from {skill:333} 90."] = "{skill:333} 상급자에게 돌아가세요. {spell:7426}은(는) {skill:333} 90부터 배울 수 있습니다.",
	-- ["Back to an {skill:333} trainer: {spell:7788} is taught from {skill:333} 120."] = "{skill:333} 상급자에게 돌아가세요. {spell:7788}은(는) {skill:333} 120부터 배울 수 있습니다.",
	-- ["Buy the whole bracket's share in one go: 1 {item:6217} (1s 24c) and 32 {item:247786} (3s 20c); about 4s 44c in all. The arrow picks the nearest seller of your faction ({zone:1453}: {npc:1286} and {npc:1318}; {zone:1454}: {npc:3367}, {npc:3346} and {npc:5817})."] = "이 구간에 필요한 몫을 한 번에 사세요: {item:6217} 1개(1실버 24코퍼)와(과) {item:247786} 32개(3실버 20코퍼). 모두 약 4실버 44코퍼. 화살표가 진영의 가장 가까운 판매자를 가리킵니다({zone:1453}: {npc:1286}, {npc:1318}; {zone:1454}: {npc:3367}, {npc:3346}, {npc:5817}).",
	-- ["Expert needs character level 20 and {skill:333} 125; it raises the cap to 225. Materials for 150-225 are worth about 13s in all."] = "숙련은(는) 캐릭터 레벨 20, {skill:333} 125이(가) 필요하며 최대 숙련도를 225(으)로 올립니다. 150-225 재료는 모두 약 13실버입니다.",
	-- ["Journeyman needs character level 10 and {skill:333} 50; it raises the cap to 150. Materials for 75-150 are worth about 7g 51s in all."] = "수습은(는) 캐릭터 레벨 10, {skill:333} 50이(가) 필요하며 최대 숙련도를 150(으)로 올립니다. 75-150 재료는 모두 약 7골드 51실버입니다.",
	-- ["Open Giant Clams here. The Auction House works too."] = "이곳에서 {object:2744}을(를) 여세요. 경매장도 됩니다.",
	-- ["Orange (a point every craft) until 135, yellow until 155, green until 175. Enchant your own gear: any item for that slot will do. {skill:333} 150 is a Legacy System milestone."] = "135까지 주황색(만들 때마다 1점), 155까지 노란색, 175까지 초록색입니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다. {skill:333} 150은(는) 유산 시스템 단계입니다.",
	-- ["Orange (a point every craft) until 20, yellow until 22, green until 25. Enchant your own gear: any item for that slot will do."] = "20까지 주황색(만들 때마다 1점), 22까지 노란색, 25까지 초록색입니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	-- ["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do."] = "80까지 주황색(만들 때마다 1점), 100까지 노란색, 120까지 초록색입니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	-- ["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do. 75 is the Apprentice cap."] = "80까지 주황색(만들 때마다 1점), 100까지 노란색, 120까지 초록색입니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다. 75은(는) 초급 최대치입니다.",
	-- ["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "무두질, 마력 추출 또는 다른 전문 기술로 얻는 재료입니다. 직접 모으거나 경매장에서 사세요.",
	-- ["Teaches {spell:13419} (needs {skill:333} 110). Vendors sell it in limited stock that restocks."] = "{spell:13419}을(를) 배웁니다({skill:333} 110 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",
	-- ["What 1-75 takes that the Auction House sells: 51 {item:10940}. The counts drop by what your bags, bank and mail hold."] = "1-75 구간에 필요한 것 중 경매장에서 파는 것: {item:10940} 51개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 150-225 takes that the Auction House sells: 1 {item:5500}, 1 {item:7971}, 1 {item:11082}, 71 {item:11083}, 1 {item:11128}, 1 {item:11135}, 21 {item:11137} and 1 {item:11144}. The counts drop by what your bags, bank and mail hold."] = "150-225 구간에 필요한 것 중 경매장에서 파는 것: {item:5500} 1개, {item:7971} 1개, {item:11082} 1개, {item:11083} 71개, {item:11128} 1개, {item:11135} 1개, {item:11137} 21개, {item:11144} 1개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 225-300 takes that the Auction House sells: 34 {item:8831}, 39 {item:11137} and 208 {item:11176}. The counts drop by what your bags, bank and mail hold."] = "225-300 구간에 필요한 것 중 경매장에서 파는 것: {item:8831} 34개, {item:11137} 39개, {item:11176} 208개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["What 75-150 takes that the Auction House sells: 1 {item:1210}, 1 {item:6338}, 4 {item:10938}, 121 {item:10940} and 20 {item:11083}. The counts drop by what your bags, bank and mail hold."] = "75-150 구간에 필요한 것 중 경매장에서 파는 것: {item:1210} 1개, {item:6338} 1개, {item:10938} 4개, {item:10940} 121개, {item:11083} 20개. 가방, 은행, 우편함에 있는 만큼 수량이 줄어듭니다.",
	-- ["Yellow until 110, green until 130: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "110까지 노란색, 130까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	-- ["Yellow until 140, green until 160: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "140까지 노란색, 160까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	-- ["Yellow until 170, green until 190: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "170까지 노란색, 190까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	-- ["Yellow until 175, green until 195: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "175까지 노란색, 195까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	-- ["Yellow until 200, green until 220: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "200까지 노란색, 220까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	-- ["Yellow until 220, green until 240: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 225 is a Legacy System milestone."] = "220까지 노란색, 240까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다. {skill:333} 225은(는) 유산 시스템 단계입니다.",
	-- ["Yellow until 245, green until 265: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "245까지 노란색, 265까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	-- ["Yellow until 275, green until 295: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "275까지 노란색, 295까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	-- ["Yellow until 290, green until 310: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 300 is a Legacy System milestone."] = "290까지 노란색, 310까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다. {skill:333} 300은(는) 유산 시스템 단계입니다.",
	-- ["{item:1210} (Alliance)"] = "{item:1210} (얼라이언스)",
	-- ["{item:1210} (Horde)"] = "{item:1210} (호드)",
	-- ["{item:1210} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:1210}은(는) {object:1731} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["{item:5500} (Alliance)"] = "{item:5500} (얼라이언스)",
	-- ["{item:5500} (Horde)"] = "{item:5500} (호드)",
	-- ["{item:7971} (Alliance)"] = "{item:7971} (얼라이언스)",
	-- ["{item:7971} (Horde)"] = "{item:7971} (호드)",
	-- ["{item:8153} (Alliance)"] = "{item:8153} (얼라이언스)",
	-- ["{item:8153} (Horde)"] = "{item:8153} (호드)",
	-- ["{item:8153} comes from {item:8831} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:8153}은(는) {item:8831} 채집지에서 나옵니다({skill:182}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",
	-- ["{item:8831} (Alliance)"] = "{item:8831} (얼라이언스)",
	-- ["{item:8831} (Horde)"] = "{item:8831} (호드)",
	-- ["{npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group"] = "{npc:11073}은(는) {area:1517} 던전({zone:1418}) 안에서 전문 {skill:333}을(를) 가르칩니다. 파티를 꾸려 가세요",
	-- ["{npc:5431} (level 48-50) drop it here. The Auction House works too."] = "이곳의 {npc:5431}(48-50레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{npc:922} (level 40-41) drop it here. The Auction House works too."] = "이곳의 {npc:922}(40-41레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",
	-- ["{skill:164}: {item:11128} (or the Auction House)"] = "{skill:164}: {item:11128} (또는 경매장)",
	-- ["{skill:164}: {item:11144} (or the Auction House)"] = "{skill:164}: {item:11144} (또는 경매장)",
	-- ["{skill:164}: {item:6338} (or the Auction House)"] = "{skill:164}: {item:6338} (또는 경매장)",
	-- ["{skill:171}: {item:6371} (or the Auction House)"] = "{skill:171}: {item:6371} (또는 경매장)",
	-- ["{skill:333} 1-75: Auction House"] = "{skill:333} 1-75: 경매장",
	-- ["{skill:333} 225-300: Auction House"] = "{skill:333} 225-300: 경매장",
	-- ["{skill:333} materials for 150-225"] = "{skill:333} 재료(150-225)",
	-- ["{skill:333} materials for 225-300"] = "{skill:333} 재료(225-300)",
	-- ["{skill:333} materials for 75-150"] = "{skill:333} 재료(75-150)",
	-- ["{skill:333} recipes at 155"] = "155에서 {skill:333} 제조법",
	-- ["{skill:333} recipes at 180"] = "180에서 {skill:333} 제조법",
	-- ["{skill:333} recipes at 292"] = "292에서 {skill:333} 제조법",
	-- ["{skill:333} recipes at 90"] = "90에서 {skill:333} 제조법",
	-- ["{skill:333} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 4g 3s in all."] = "{skill:333}은(는) 레벨업과 함께 진행합니다. Forever의 유산 시스템은 제작 전문 기술 숙련도 150, 225, 300(수습, 숙련, 전문 최대치)에 보상을 주므로, 각 단계가 중요합니다. 1-75 재료는 모두 약 4골드 3실버입니다.",
	-- ["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}: 고급(녹색) 장비 마력 추출 (또는 경매장)",
	-- ["{spell:13419} to 150"] = "{spell:13419}: 150까지",
	-- ["{spell:13501} is orange at 150 (yellow 155, green 175, grey 195): about 11 crafts to 160. Each takes 1 {item:11083}. One {item:11083} a craft (level 21-30 greens). Make the {item:11130} now, while it still gives a point: a later recipe needs it in your bags, so keep it there. Enchant any item for that slot in your bags, even a grey one."] = "{spell:13501}은(는) 150에 주황색입니다(노란색 155, 초록색 175, 회색 195). 160까지 약 11번 만드십시오. 하나에 {item:11083} 1개가 듭니다. 제작마다 {item:11083} 하나(21-30레벨 녹색 아이템). 아직 점수를 주는 지금 {item:11130}을(를) 만드십시오. 이후 제조법에 가방 안의 그것이 필요하니 가방에 두십시오. 가방에 있는 해당 부위 아이템이면 회색이라도 아무것에나 마법을 부여하십시오.",
	-- ["{spell:13661} to 225"] = "{spell:13661}: 225까지",
	-- ["{spell:13935} to 292"] = "{spell:13935}: 292까지",
	-- ["{spell:13948} to 300"] = "{spell:13948}: 300까지",
	-- ["{spell:7420} is yellow at 75 (yellow 70, green 90, grey 110): about 22 crafts to 90. Each takes 1 {item:10940}. One {item:10940} a craft: the dust most level 5-20 greens break into, armour above all. {item:10938} (from weapons) does the same job through Bracer - Minor Deflect or Chest - {spell:7423} if you have more of it. Enchant any item for that slot in your bags, even a grey one."] = "{spell:7420}은(는) 75에서 노란색입니다(노란색 70, 초록색 90, 회색 110). 90까지 약 22번 만드세요. 한 번에 {item:10940} 1개. 제작당 {item:10940} 한 개. 5-20레벨 녹색 아이템이 주로 부서져 나오는 가루이며, 방어구가 가장 많습니다. {item:10938}(무기에서)은(는) 더 많이 가졌다면 팔찌 - 작은 회피이나 가슴보호구 - {spell:7423}으로 같은 일을 합니다. 가방 안의 그 칸에 맞는 아이템이면 어떤 것이든, 회색이라도 부여할 수 있습니다.",
	-- ["{spell:7426} to 120"] = "{spell:7426}: 120까지",
	-- ["{spell:7428} to 75"] = "{spell:7428}: 75까지",
	-- ["{spell:7428} to 90"] = "{spell:7428}: 90까지",
	-- ["{spell:7788} to 130"] = "{spell:7788}: 130까지",
	-- ["{spell:7861} to 155"] = "{spell:7861}: 155까지",
}
