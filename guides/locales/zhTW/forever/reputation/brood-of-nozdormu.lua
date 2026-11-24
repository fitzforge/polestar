-- Chinese (traditional) (zhTW): the guide forever/reputation/brood-of-nozdormu (forever/reputation/brood-of-nozdormu.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Brood of Nozdormu Reputation"] = "諾茲多姆的子嗣聲望",
	["The Bronze Dragonflight's ring, upgraded at every standing; a long climb from Hated, mostly in raids."] = "青銅龍軍團的戒指，每提升一級聲望即可升級；從仇恨開始的漫長攀升，主要靠團隊副本。",
	-- {item:21175} The Scepter of the Shifting Sands
	["{item:21175} quest chain"] = "{item:21175}任務線",

	-- Step 1: Baristolth in Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Baristolth in {area:3425}"] = "巴里斯托爾斯在{area:3425}",
	-- {faction:910} Brood of Nozdormu · {npc:15192} Anachronos · {npc:15180} Baristolth of the Shifting Sands · {area:3425} Cenarion Hold · {area:2677} Blackwing Lair · {area:16076} Temple of Ahn'Qiraj
	["The {faction:910} is not in your reputation list until you meet {npc:15192}. {npc:15180}, in the main building of {area:3425}, sends you to him. Meeting him sets you at Hated, 0 of 36,000: Neutral is 42,000 reputation away, and almost all of it comes from raids. {area:2677} and the {area:16076} are not among the first raids Blizzard has announced for Forever: until one of them opens, the 100 from Baristolth's first quest is all the Brood reputation there is. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "在你見到{npc:15192}之前，{faction:910}不會出現在你的聲望列表裡。{area:3425}主建築裡的{npc:15180}會派你去找他。見到他後你會被設為仇恨，0/36,000：到中立還差42,000聲望，而且幾乎全靠團隊副本。{area:2677}和{area:16076}並不在暴雪公佈的首批Forever團隊副本之列：在其中一個開放之前，巴里斯托爾斯第一個任務給的100聲望就是子嗣聲望的全部來源。傳承特長“外交家”可為每次聲望獲取最多加10%；本指南的數字不含它。",

	-- Step 2: Anachronos at the Caverns of Time
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["{npc:15192} at the {area:2300}"] = "{npc:15192}在{area:2300}",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["{npc:15192}, a bronze dragon in elf form, stands at the mouth of the {area:2300} in eastern {zone:1446}, south-east of {area:976}. Walk up to him."] = "{npc:15192}是一條化為人形的青銅龍，站在{zone:1446}東部{area:2300}的入口，位於{area:976}東南。走到他跟前。",
	-- {npc:15192} Anachronos
	["Meet {npc:15192}"] = "與{npc:15192}見面",

	-- Step 3: Back to Baristolth
	["Back to Baristolth"] = "回到巴里斯托爾斯",
	-- {quest:8288} Only One May Rise · {npc:12017} Broodlord Lashlayer · {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {quest:8286} What Tomorrow Brings
	["{quest:8288} wants the head of {npc:12017}, the third boss of {area:2677} (a 40-player raid in {area:254}). Everything after it needs the head, the fragment turn-ins included: until you have it, {quest:8286} is all the Brood reputation there is, solo or not."] = "{quest:8288}要{npc:12017}的頭顱，他是{area:2677}（{area:254}裡的40人團隊副本）的三號首領。之後的一切都需要這顆頭顱，包括碎片交付：在拿到它之前，{quest:8286}就是子嗣聲望的全部來源，無論單刷與否。",

	-- Step 4: Broodlord Lashlayer
	-- {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {npc:12017} Broodlord Lashlayer
	["{area:2677} is a 40-player raid at the top of {area:254}. {npc:12017} always drops his head."] = "{area:2677}是{area:254}頂部的40人團隊副本。{npc:12017}必定掉落他的頭顱。",
	-- {item:20383} Head of the Broodlord Lashlayer
	["{item:20383}: raid of 40"] = "{item:20383}：40人團隊副本",

	-- Step 5: The Path of the Righteous
	-- {quest:8301} The Path of the Righteous · {area:3425} Cenarion Hold · {area:2743} Hive'Zora · {area:2744} Hive'Regal
	-- plural, as words: Silithid Carapace Fragments = {item:20384} Silithid Carapace Fragment · Hive'Ashi Workers = {npc:11721} Hive'Ashi Worker
	["{quest:8301} wants 200 Silithid Carapace Fragments. Every hive silithid drops one to three on most kills: the Hive'Ashi Workers, Stingers, Swarmers and Defenders north and north-west of {area:3425}, and those of {area:2743} in the west and {area:2744} in the south. Almost all of them are elites of level 57 to 60: one at a time solo, faster in a group."] = "{quest:8301}要200塊異種蠍殼碎片。每個蟲巢的異種蠍多數擊殺都會掉一到三塊：{area:3425}以北和西北的亞什蟲巢工蜂、刺蟲、群居者和守衛，以及西面{area:2743}和南面{area:2744}的那些。它們幾乎都是57到60級精英：單刷一次一隻，組隊更快。",

	-- Step 6: Hated to Neutral
	["Hated to Neutral"] = "仇恨到中立",
	-- {quest:8302} The Hand of the Righteous · {area:16076} Temple of Ahn'Qiraj · {item:21230} Ancient Qiraji Artifact · {item:21229} Qiraji Lord's Insignia
	["After The Path, Baristolth takes 200 more fragments for {quest:8302}: 200 reputation, again and again, but only until Neutral. From Hated 500 that is 208 turn-ins, 41,600 fragments, 20,000 to 30,000 elite kills: the only way without the Temple, and a very long one. With the {area:16076} open (a 40-player raid) it is far quicker: every Temple trash mob gives 100 until 2,999 of 3,000 Neutral, about 9,500 a full clear, so four to five clears reach Neutral. Save every {item:21230} and {item:21229} you loot until the trash stops counting: they pay the same later."] = "完成 正義之路 後，流沙守望者巴里斯托爾斯會再收200塊碎片來完成 {quest:8302}：每次200聲望，可反覆交還，但只能到中立。從仇恨500開始，需要交還208次、41,600塊碎片，約擊殺20,000至30,000只精英：這是不打神殿的唯一方式，而且非常漫長。{area:16076} 開放後（40人團隊副本）會快得多：神殿每隻小怪提供100聲望，直到中立2,999/3,000為止，完整清理一次約得9,500，因此四到五次即可達到中立。在小怪不再提供聲望之前，保留所有拾取到的 {item:21230} 和 {item:21229}：以後交還的收益相同。",
	-- {quest:8302} The Hand of the Righteous
	["{quest:8302}: 200 fragments, 200"] = "{quest:8302}：200塊碎片，200",

	-- Step 7: Anachronos's quests
	-- {quest:8303} Anachronos
	["{quest:8303}'s quests"] = "{quest:8303}的任務",
	-- {quest:8303} Anachronos
	["Neutral opens the rest of the Scepter of the Shifting Sands chain. Baristolth sends you back to {quest:8303}."] = "中立會開啟流沙節杖任務的後續。巴里斯托爾斯會把你送回{quest:8303}。",

	-- Step 9: The Crystalline Tear
	-- {object:180633} Crystalline Tear
	["The {object:180633}"] = "那個{object:180633}",
	-- {object:180633} Crystalline Tear · {area:3428} Ahn'Qiraj · {zone:1451} Silithus
	["The {object:180633} is a small red crystal on the ground just outside the gates of {area:3428}, in the far south-west of {zone:1451}. Click it, then stay and watch the vision of the War of the Shifting Sands to its end. If it is cut short, abandon the quest and click the Tear again."] = "{object:180633}是一小塊紅色水晶，就在{area:3428}大門外的地上，位於{zone:1451}最西南。點選它，然後留在這裡，把流沙之戰的幻象看完。如果中途被打斷，放棄任務再點一次淚珠。",
	["Watch the vision"] = "觀看幻象",

	-- Step 10: The Charge of the Dragonflights
	-- {npc:15192} Anachronos · {item:21200} Signet Ring of the Bronze Dragonflight · {quest:8555} The Charge of the Dragonflights
	["{npc:15192} now offers the {item:21200} in three kinds: the Path of the Protector (tanks), of the Conqueror (melee fighters) or of the Invoker (casters). Take one: the other two close. Each standing from Friendly to Exalted brings an upgrade of the same ring, 100 reputation each. {quest:8555} sends you after the three shards of the Scepter of the Shifting Sands."] = "{npc:15192}現在提供三種{item:21200}：保護者之路（坦克）、征服者之路（近戰）或祈求者之路（施法者）。選一種：另外兩種就會關閉。從友善到崇拜，每個聲望等級都會帶來同一枚戒指的升級，各需100聲望。{quest:8555}會派你去尋找流沙節杖的三塊碎片。",
	["Pick one: The Path of the Protector, the Conqueror or the Invoker, 100"] = "三選一：保護者之路、征服者之路或祈求者之路，100",

	-- Step 11: The red shard: Vaelastrasz
	["The red shard: Vaelastrasz"] = "紅色碎片：瓦拉斯塔茲",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair · {quest:8730} Nefarius's Corruption · {item:21138} Red Scepter Shard
	["The red shard: {npc:13020}, the second boss of {area:2677}, gives {quest:8730} before his fight; Nefarian, the last boss, drops the {item:21138} for one raider on the quest each kill. The quest lasts five hours."] = "紅色碎片：{area:2677}的二號首領{npc:13020}會在戰鬥前給{quest:8730}；最終首領奈法利安每次擊殺會為一名接了任務的團隊成員掉落{item:21138}。任務持續五小時。",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair
	["{npc:13020}, {area:2677}: raid of 40"] = "{npc:13020}，{area:2677}：40人團隊副本",
	-- {item:21138} Red Scepter Shard
	["{item:21138}, Nefarian"] = "{item:21138}，奈法利安",

	-- Step 12: The blue shard: Azuregos's ledger
	["The blue shard: Azuregos's ledger"] = "藍色碎片：艾索雷葛斯的賬本",
	-- {npc:15481} Spirit of Azuregos · {zone:1447} Azshara · {npc:11811} Narain Soothfancy · {zone:1446} Tanaris
	["The {npc:15481} stands on the south coast of {zone:1447}. His ledger starts {npc:11811}'s long chain in {zone:1446}."] = "{npc:15481}站在{zone:1447}的南海岸。他的賬本會在{zone:1446}開啟{npc:11811}的長任務鏈。",

	-- Step 13: Narain Soothfancy
	-- {npc:11811} Narain Soothfancy · {area:976} Gadgetzan · {zone:1421} Silverpine Forest · {zone:1446} Tanaris · {npc:8125} Dirge Quikcleave
	["{npc:11811}, a goblin seer, lives in a hut north-east of {area:976}. He sends you three ways at once: to Stewvul's crate in {zone:1421}, to an island off the south coast of {zone:1446}, and to {npc:8125} in {area:976}."] = "{npc:11811}是個哥布林先知，住在{area:976}東北的一座小屋裡。他一次派你走三條路：去{zone:1421}斯圖沃的箱子、去{zone:1446}南海岸外的島嶼，以及去{area:976}的{npc:8125}。",

	-- Step 14: Stewvul's crate
	["Stewvul's crate"] = "斯圖沃的箱子",
	-- {object:180642} Inconspicuous Crate · {area:230} Greymane Wall · {zone:1421} Silverpine Forest
	["The {object:180642} leans on the {area:230} at the south end of {zone:1421}, left of the closed gate."] = "{object:180642}靠在{zone:1421}南端的{area:230}上，在關閉的大門左側。",

	-- Step 15: Meridith the Mermaiden
	-- {object:180652} Freshly Dug Dirt · {area:987} Land's End Beach · {npc:15526} Meridith the Mermaiden · {quest:8599} Love Song for Narain
	["The {object:180652} lies on the farther of two islands south of {area:987}, past the fatigue line. {npc:15526}, on the sea floor south of the beach's crashed gyrocopter, gives {quest:8599} and a three-minute swim-speed blessing that gets you across."] = "{object:180652}位於{area:987}以南兩座島中較遠的那座，已過疲勞線。海灘墜毀旋翼機以南的海底有{npc:15526}，他會給{quest:8599}和一個三分鐘的游泳加速祝福，助你渡海。",

	-- Step 16: The island off Land's End Beach
	-- {area:987} Land's End Beach
	["The island off {area:987}"] = "{area:987}外的島嶼",

	-- Step 17: Back to Narain Soothfancy
	-- {npc:11811} Narain Soothfancy
	["Back to {npc:11811}"] = "回到{npc:11811}",
	-- {quest:8606} Decoy! · {npc:11811} Narain Soothfancy · {area:2255} Everlook · {zone:1452} Winterspring · {npc:15554} Number Two
	["{quest:8606} sends you, disguised with {npc:11811}'s turban, to a drop-off point south of {area:2255} in {zone:1452}. Leave the bag of gold there: {npc:15554}, a level 61 elite, comes for it (group of 3 to 5)."] = "{quest:8606}會讓你戴上{npc:11811}的頭巾偽裝，前往{zone:1452}中{area:2255}以南的交貨點。把金幣袋放在那裡：61級精英{npc:15554}會來取（3到5人隊伍）。",

	-- Step 18: Decoy!
	-- {npc:15554} Number Two
	["{npc:15554}, elite: group of 3 to 5"] = "{npc:15554}，精英：3到5人隊伍",

	-- Step 19: Dirge Quikcleave
	-- {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {area:1121} Isle of Dread · {zone:1444} Feralas
	["{npc:8125} cooks in {area:976}. He sends you to the {area:1121} off southern {zone:1444} for a Chimaerok feast."] = "{npc:8125}在{area:976}做飯。他會派你去{zone:1444}南部外海的{area:1121}赴一場奇美洛克盛宴。",

	-- Step 20: The Isle of Dread
	-- {area:1121} Isle of Dread
	["The {area:1121}"] = "那個{area:1121}",
	-- {npc:12803} Lord Lakmaeran · {area:1121} Isle of Dread
	["{npc:12803} and the Chimaerok on the {area:1121} are elites of level 60 to 62 that respawn every ten minutes: a raid's work. The Chimaerok drop a tenderloin about half the time, Lakmaeran two to four now and then."] = "{npc:12803}和{area:1121}上的奇美洛克是60到62級精英，每十分鐘重生：這是團隊副本的活。奇美洛克約半數掉落裡脊肉，拉克麥拉則偶爾掉兩到四塊。",
	-- {item:21027} Lakmaeran's Carcass · {npc:12803} Lord Lakmaeran
	["{item:21027}, {npc:12803}: raid"] = "{item:21027}、{npc:12803}：團隊副本",

	-- Step 21: Draconic for Dummies, Volume II
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}, Volume II"] = "{quest:8597}，第二卷",
	-- {quest:8620} The Only Prescription · {quest:8597} Draconic for Dummies · {npc:15552} Doctor Weavil · {area:2079} Alcaz Island · {zone:1419} Blasted Lands · {area:2255} Everlook · {zone:1458} Undercity · {npc:11811} Narain Soothfancy
	-- plural, as words: Felguard Elites = {npc:8717} Felguard Elite · Doomguard Commanders = {npc:12396} Doomguard Commander
	["{quest:8620} needs the eight chapters of {quest:8597}, Volume II: from {npc:15552} in his house on {area:2079} (a level 63 elite with guards, raid), the Felguard Elites, Doomguard Commanders and Dreadlords of the {zone:1419}, the Hederine south of {area:2255}, and a book in the {zone:1458}. {npc:11811} hands out the binding when you accept."] = "{quest:8620}需要{quest:8597}第二卷的八個章節：來自{area:2079}他房子裡的{npc:15552}（63級精英，帶守衛，需團隊）、{zone:1419}的惡魔衛士精英、末日守衛指揮官和恐懼魔王、{area:2255}以南的赫達林，以及{zone:1458}的一本書。接受任務時{npc:11811}會給你裝訂本。",
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}: Volume II"] = "{quest:8597}：第二卷",

	-- Step 22: Dirge Quikcleave's Chops
	-- {npc:8125} Dirge Quikcleave
	["{npc:8125}'s Chops"] = "{npc:8125}的肉排",
	-- {npc:8125} Dirge Quikcleave · {item:9061} Goblin Rocket Fuel · {item:8150} Deeprock Salt · {npc:11811} Narain Soothfancy · {item:18562} Elementium Ore · {item:21136} Arcanite Buoy · {object:180669} Swirling Maelstrom · {zone:1447} Azshara · {area:1227} Bay of Storms · {npc:15571} Maws · {item:21137} Blue Scepter Shard
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar · Azerothian Diamonds = {item:12800} Azerothian Diamond · Blue Sapphires = {item:12361} Blue Sapphire
	["{npc:8125} wants 20 {item:9061} and 20 {item:8150} with the meat. {npc:11811} then wants 20 Arcanite Bars, 10 {item:18562}, 10 Azerothian Diamonds and 10 Blue Sapphires, and gives you an {item:21136}: placed at the {object:180669} in {zone:1447}'s {area:1227}, it calls up {npc:15571}, a level 63 boss for a raid. {npc:15571} drops the {item:21137} for one raider on the quest each kill."] = "{npc:8125}要在肉之外再加20個{item:9061}和20個{item:8150}。隨後{npc:11811}要20塊奧金錠、10個{item:18562}、10顆艾澤拉斯鑽石和10顆藍寶石，並給你一個{item:21136}：把它放在{zone:1447}{area:1227}的{object:180669}處，會召喚{npc:15571}，一個63級的團隊副本首領。{npc:15571}每次擊殺會為一名接了任務的團隊成員掉落{item:21137}。",
	-- {item:12360} Arcanite Bar
	["{item:12360}: Alchemists, or the auction house"] = "{item:12360}：鍊金師，或拍賣行",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}: {area:2677}, or the auction house"] = "{item:18562}：{area:2677}，或拍賣行",

	-- Step 23: Maws
	-- {item:21137} Blue Scepter Shard · {npc:15571} Maws
	["{item:21137}, {npc:15571}: raid"] = "{item:21137}、{npc:15571}：團隊副本",

	-- Step 24: The green shard: Eranikus
	["The green shard: Eranikus"] = "綠色碎片：伊蘭尼庫斯",
	-- {npc:15362} Malfurion Stormrage · {npc:5709} Shade of Eranikus · {area:1477} Temple of Atal'Hakkar · {npc:15624} Forest Wisp · {zone:1457} Darnassus · {npc:11832} Keeper Remulos · {zone:1450} Moonglade
	["{npc:15362} appears beside the {npc:5709} at the bottom of the {area:1477} (a five-player dungeon). He sends you to a {npc:15624} outside {zone:1457} (Horde players walk past the city's guards), then to {npc:11832} in {zone:1450}."] = "{npc:15362} 出現在 {area:1477}（五人地下城）底部的 {npc:5709} 旁。他會讓你去找 {zone:1457} 外的一名 {npc:15624}（部落玩家需從城市守衛旁走過），再去找 {zone:1450} 的 {npc:11832}。",
	-- {npc:15362} Malfurion Stormrage · {area:1477} Temple of Atal'Hakkar
	["{npc:15362}, inside the {area:1477}"] = "{npc:15362}，在{area:1477}內",

	-- Step 25: The Forest Wisp
	-- {npc:15624} Forest Wisp
	["The {npc:15624}"] = "這位{npc:15624}",
	-- {npc:15624} Forest Wisp
	["{npc:15624}: 25 (and 25 Cenarion Circle)"] = "{npc:15624}：25（另加25塞納里奧議會）",

	-- Step 26: Keeper Remulos
	-- {quest:8735} The Nightmare's Corruption · {npc:235289} Dragons of Nightmare · {zone:1440} Ashenvale · {zone:1444} Feralas · {zone:1425} Hinterlands · {npc:15625} Twilight Corrupter · {zone:1431} Duskwood
	["{quest:8735} wants a fragment from each of the four {npc:235289} portals: elite dragonkin at the {zone:1440}, {zone:1444} and {zone:1425} portals (5% each) and the {npc:15625} in {zone:1431}. Raid content."] = "{quest:8735} 需要從四座{npc:235289}傳送門各獲得一塊碎片：{zone:1440}、{zone:1444} 和 {zone:1425} 傳送門處的精英龍人（各5%），以及 {zone:1431} 的 {npc:15625}。這是團隊內容。",
	["10 (and 100 Cenarion Circle)"] = "10（另加100塞納里奧議會）",

	-- Step 27: The Ashenvale portal
	-- {zone:1440} Ashenvale
	["The {zone:1440} portal"] = "{zone:1440}傳送門",
	["The four dream portals sit in groves guarded by elite dragonkin of level 60 to 62 that respawn every 30 minutes; each drops the portal's fragment one time in twenty. Raid content."] = "四條夢境傳送門位於樹林中，由60到62級的精英龍人守衛，每30分鐘重生；每個約二十分之一機率掉落該傳送門的碎片。團隊副本內容。",

	-- Step 28: The Duskwood portal
	-- {zone:1431} Duskwood
	["The {zone:1431} portal"] = "{zone:1431}傳送門",
	-- {npc:15625} Twilight Corrupter
	["The {npc:15625} (level 63 boss) always drops its fragment."] = "這位{npc:15625}（63級首領）必定掉落它的碎片。",

	-- Step 29: The Feralas portal
	-- {zone:1444} Feralas
	["The {zone:1444} portal"] = "{zone:1444}傳送門",

	-- Step 30: Hinterlands portal
	-- {zone:1425} Hinterlands
	["{zone:1425} portal"] = "{zone:1425}傳送門",

	-- Step 31: The Nightmare Manifests
	-- {npc:11832} Keeper Remulos · {area:2361} Nighthaven
	["A raid event: follow {npc:11832} toward {area:2361} and keep him alive against Eranikus and his nightmare adds until Tyrande arrives and redeems Eranikus. Do not kill Eranikus."] = "團隊事件：跟隨{npc:11832}向{area:2361}走，在伊蘭尼庫斯和他的夢魘小怪攻擊下保住他，直到泰蘭德趕到並救贖伊蘭尼庫斯。不要殺死伊蘭尼庫斯。",
	["100 (and 100 Cenarion Circle)"] = "100（另加100塞納里奧議會）",
	["The Redemption of Eranikus: raid"] = "伊蘭尼庫斯的救贖：團隊副本",
	["200 (and 200 Cenarion Circle)"] = "200（另加200塞納里奧議會）",

	-- Step 32: The Scepter of the Shifting Sands
	-- {npc:15192} Anachronos · {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj
	["With the three shards, {npc:15192} makes the Scepter of the Shifting Sands. In Classic its first holder rings the {object:180717} once for the whole realm, opening the gates of {area:3428}, and those who finish within ten hours earn the black qiraji crystal mount; whether Forever's realms get that event is not known."] = "集齊三塊碎片後，{npc:15192}會打造流沙節杖。在經典舊世，第一個持有者敲響{object:180717}，全服僅此一次，開啟{area:3428}的大門，十小時內完成的人可獲得黑色其拉水晶坐騎；Forever的伺服器是否會有這個事件尚不清楚。",

	-- Step 33: Scarab Gong
	-- {object:180717} Scarab Gong · {area:3428} Ahn'Qiraj · {npc:15693} Jonathan the Revelator · {quest:8745} Treasure of the Timeless One
	["{object:180717} hangs before the gates of {area:3428}. {npc:15693} appears beside it once the gong has been rung, with {quest:8745}: a weapon and 200 reputation."] = "{object:180717}懸掛在{area:3428}的大門前。銅鑼敲響後，{npc:15693}會出現在它旁邊，帶著{quest:8745}：一件武器和200聲望。",

	-- Step 34: Neutral to Friendly in the Temple
	["Neutral to Friendly in the Temple"] = "在神廟內從中立到友善",
	-- {area:16076} Temple of Ahn'Qiraj · {area:2737} Scarab Wall · {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {area:3454} Ruins of Ahn'Qiraj
	["Neutral to Friendly is 3,000 reputation. Every trash mob of the {area:16076} (a 40-player raid behind the {area:2737}) gives 100, and the Twin Emperors 210 each, until 2,999 of 3,000 Neutral, one point short of Friendly; there they stop. Then hand in one saved {item:21230} (1,000, to {npc:15502}) or {item:21229} (500, to {npc:15503}) to tip you over. The shoulder and boot exchanges of the Temple's tier set need no standing: the token, two idols and ten scarabs to {npc:15502} (shoulders) or {npc:15503} (boots) pay 200 each. The {area:3454} (20 players) give a little from bosses: Kurinnaxx, Moam, Buru and Ayamiss 50 each, Rajaxx 34, Ossirian 100, to Exalted."] = "中立到友善需要3,000聲望。{area:16076}（{area:2737}後面的40人團隊副本）的每個小怪給100，雙子皇帝各給210，直到中立2,999/3,000——離友善還差一點；到那裡就停止了。然後交一塊留存的{item:21230}（1,000，給{npc:15502}）或{item:21229}（500，給{npc:15503}）把你頂過去。神廟套裝的護肩和靴子兌換不需要聲望：把徽記、兩個神像和十個甲蟲交給{npc:15502}（護肩）或{npc:15503}（靴子），各得200。{area:3454}（20人）的首領也給一些：庫林納克斯、莫阿姆、布魯和阿亞米斯各50，拉賈克斯34，奧西里安100，直到崇拜。",
	-- {item:21229} Qiraji Lord's Insignia
	["{item:21229}, Temple bosses"] = "{item:21229}，神廟首領",
	-- {npc:15503} Kandrostrasz
	["{npc:15503}: 500, handed in from his window"] = "{npc:15503}：500，在他的視窗中直接繳交",

	-- Step 35: The ring at Friendly
	["The ring at Friendly"] = "友善戒指",
	-- {npc:15192} Anachronos
	["At Friendly, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "友善時，{npc:15192}會升級你所選路徑的戒指：保護者之路、征服者之路或祈求者之路。帶上你佩戴的戒指；100聲望。",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Friendly ring quest of your path"] = "{npc:15192}：你路徑的友善戒指任務",

	-- Step 36: Friendly to Honored: the turn-ins
	["Friendly to Honored: the turn-ins"] = "友善到尊敬：交付",
	-- {item:21230} Ancient Qiraji Artifact · {quest:8784} Secrets of the Qiraji · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {quest:8595} Mortal Champions · {npc:15727} C'Thun
	["Now hand in what you saved. Each {item:21230} (any Temple trash, 1% to 9%) starts {quest:8784}: 1,000 reputation from {npc:15502}, one of the three bronze dragons inside the Temple. Each {item:21229} (nearly every Temple boss) goes to {npc:15503} for {quest:8595}: 500 here and 100 Cenarion Circle. {npc:15727} gives 2,500, to Exalted. Friendly to Honored is 6,000: six artifacts or twelve insignias. Friendly also opens the helm and leg exchanges of the Temple's tier set (200 reputation each) at {npc:15502} and {npc:15503}."] = "現在把攢下的交出去。每塊{item:21230}（神廟任何小怪，1%到9%）會開啟{quest:8784}：交給神廟內三條青銅龍之一的{npc:15502}，得1,000聲望。每個{item:21229}（幾乎每個神廟首領）交給{npc:15503}完成{quest:8595}：這裡得500，另加100塞納里奧議會。{npc:15727}給2,500，直到崇拜。友善到尊敬需要6,000：六件神器或十二枚徽記。友善還會在{npc:15502}和{npc:15503}處解鎖神廟套裝的頭盔和腿甲兌換（各200聲望）。",
	-- {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos
	["{item:21230}: right-click it, then {npc:15502}"] = "{item:21230}：右鍵點選它，然後找{npc:15502}",
	-- {quest:8595} Mortal Champions
	["{quest:8595}: 1 insignia, 500"] = "{quest:8595}：1枚徽記，500",

	-- Step 37: The ring at Honored
	["The ring at Honored"] = "尊敬戒指",
	-- {npc:15192} Anachronos
	["At Honored, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "尊敬時，{npc:15192}會升級你所選路徑的戒指：保護者之路、征服者之路或祈求者之路。帶上你佩戴的戒指；100聲望。",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Honored ring quest of your path"] = "{npc:15192}：你路徑的尊敬戒指任務",

	-- Step 38: Honored to Revered
	["Honored to Revered"] = "尊敬到崇敬",
	-- {npc:15727} C'Thun · {quest:8595} Mortal Champions · {quest:8789} Imperial Qiraji Armaments · {npc:15380} Arygos · {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["Honored to Revered is 12,000: twelve artifacts, 24 insignias, or a mix with {npc:15727} (2,500). After the first, each insignia is the repeatable {quest:8595}. Every Temple boss sometimes drops an {quest:8789} or Regalia (about one time in twenty): {npc:15380} and {npc:15378}, inside the Temple once {npc:15727} is dead, take it with 3 {item:18562} for 200 and a weapon. Honored opens the chest exchange of the tier set (200)."] = "尊敬到崇敬需要12,000：十二件神器、24枚徽記，或用{npc:15727}（2,500）混搭。第一枚之後，每枚徽記都靠可重複的{quest:8595}。神廟每個首領偶爾會掉落{quest:8789}或徽飾（約二十分之一）：{npc:15727}死後，神廟內的{npc:15380}和{npc:15378}會收下它，外加3個{item:18562}，給200聲望和一件武器。尊敬解鎖套裝胸甲兌換（200）。",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}, {area:2677} or the auction house"] = "{item:18562}，{area:2677}或拍賣行",
	-- {npc:15380} Arygos · {item:18562} Elementium Ore
	["{npc:15380}: Armaments and 3 {item:18562}, 200"] = "{npc:15380}：軍械和3個{item:18562}，200",
	-- {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["{npc:15378}: Regalia and 3 {item:18562}, 200"] = "{npc:15378}：徽飾和3個{item:18562}，200",

	-- Step 39: The ring at Revered
	["The ring at Revered"] = "崇敬戒指",
	-- {npc:15192} Anachronos
	["At Revered, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "崇敬時，{npc:15192}會升級你所選路徑的戒指：保護者之路、征服者之路或祈求者之路。帶上你佩戴的戒指；100聲望。",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Revered ring quest of your path"] = "{npc:15192}：你路徑的崇敬戒指任務",

	-- Step 40: Revered to Exalted
	["Revered to Exalted"] = "崇敬到崇拜",
	-- {npc:15727} C'Thun · {quest:8801} C'Thun's Legacy · {npc:15379} Caelestrasz
	["Revered to Exalted is 21,000: 21 artifacts or 42 insignias, with {npc:15727}'s 2,500 a week. {npc:15727}'s eye starts {quest:8801} for {npc:15379} (200, and 200 Cenarion Circle). At Exalted Anachronos gives the last ring: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker."] = "崇敬到崇拜需要21,000：21件神器或42枚徽記，外加{npc:15727}每週2,500。{npc:15727}之眼會為{npc:15379}開啟{quest:8801}（200，另加200塞納里奧議會）。崇拜時，阿納克洛斯會給最後一枚戒指：卡利姆多保護者、其拉征服者或大祈求者。",

	-- Step 41: The Exalted ring
	["The Exalted ring"] = "崇拜戒指",
	-- {npc:15192} Anachronos
	["At Exalted, {npc:15192} gives the last ring of your path: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker. Bring the Revered ring; 100 reputation."] = "崇拜時，{npc:15192}會給你所選路徑的最後一枚戒指：卡利姆多保護者、其拉征服者或大祈求者。帶上崇敬戒指；100聲望。",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Exalted ring quest of your path"] = "{npc:15192}：你路徑的崇拜戒指任務",
}
