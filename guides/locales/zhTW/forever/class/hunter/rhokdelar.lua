-- Chinese (traditional) (zhTW): the guide forever/class/hunter/rhokdelar (forever/class/hunter/rhokdelar.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Rhok'delar and Lok'delar"] = "洛克德拉爾與羅可德拉爾",
	["The hunter's epic bow chain: in Classic the stave and sinew became Rhok'delar and Lok'delar (unconfirmed in Forever)."] = "獵人的史詩弓任務鏈：在經典版中，法杖和弓弦會變成洛克德拉爾和羅可德拉爾（Forever中尚未確認）。",

	-- Step 1: The Ancient Petrified Leaf
	-- {item:18703} Ancient Petrified Leaf
	["The {item:18703}"] = "{item:18703}",
	-- {area:2717} Molten Core · {area:254} Blackrock Mountain · {npc:12018} Majordomo Executus · {object:179703} Cache of the Firelord · {item:18703} Ancient Petrified Leaf
	["{area:2717} is a 40-player raid inside {area:254}. When {npc:12018} yields, the {object:179703} appears; it holds the {item:18703} about half the time, one per kill, so it may take several weeks of raids. Right-click the leaf to start the quest."] = "{area:2717}是{area:254}裡的40人團隊副本。{npc:12018}倒下後會出現{object:179703}；其中約有一半機率裝有{item:18703}，每次一個，所以可能需要好幾周的團隊副本。右鍵點選石葉即可開始任務。",
	-- {item:18703} Ancient Petrified Leaf
	["from the {item:18703}"] = "從{item:18703}取得",

	-- Step 2: Vartrus the Ancient
	-- {npc:14526} Hastat the Ancient · {area:1767} Irontree Woods · {zone:1448} Felwood · {area:1998} Talonbranch Glade · {area:1997} Bloodvenom Post · {quest:7636} Stave of the Ancients
	["Vartrus, Stoma and {npc:14526} are petrified trees on a small island in a ring-shaped lake in {area:1767}, north {zone:1448}. Their spirits only appear when someone carrying the leaf climbs the island's little hill to its east edge. Alliance: fly to {area:1998}; Horde: fly to {area:1997}. Vartrus gives {quest:7636}, Stoma A Proper String, Hastat the quiver; each can be handed in on its own."] = "瓦特魯斯、斯托瑪和{npc:14526}是{area:1767}環狀湖泊小島上的石化樹木，位於{zone:1448}北部。只有攜帶石葉的人爬上島上的小丘、走到東側邊緣，它們的靈魂才會出現。聯盟：飛往{area:1998}；部落：飛往{area:1997}。瓦特魯斯給{quest:7636}，斯托瑪給“合適的弓弦”，哈斯塔特給箭袋任務；三者可以分別交付。",
	-- {npc:14526} Hastat the Ancient
	["{npc:14526}: the quiver, last in this guide"] = "{npc:14526}：箭袋，本指南最後一步",

	-- Step 3: Before the demons
	["Before the demons"] = "惡魔之前",
	-- {item:9224} Potion of Demon Slaying · {skill:171} Alchemy · {spell:19878} Track Demons
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion
	["The four demons are level 60 elites disguised as friendly travellers; talk to one and say you know what it is, and it turns into its demon form. Fight every one alone: no pet (dismiss it), no other player's heal, buff or attack once the fight starts, or the demon calls you a coward and vanishes, with a 3 hour wait for it to return (also after it dies). Buffs and potions you take before the pull are fine, and a friend may stand by to kill wandering monsters or enemy players, as long as they never touch the demon or you. Bring a {item:9224} ({skill:171} or the auction house), Major Mana Potions for the long kites, and a melee weapon with the Demonslaying enchant if you can. {spell:19878}, from your trainer, shows the disguised demons on the minimap. In a group, set loot to free for all so you can loot the head."] = "這四個惡魔是60級精英，偽裝成友善的旅行者；和其中一個對話，說你知道它是什麼，它就會變回惡魔形態。每一場都要單獨打：不帶寵物（解散它），戰鬥開始後不能有其他玩家的治療、增益或攻擊，否則惡魔會罵你懦夫然後消失，要等3小時才回來（它死後也一樣）。拉怪前上的增益和藥水沒問題，朋友也可以在旁邊殺遊蕩的怪物或敵對玩家，只要他們不碰惡魔也不碰你。帶一個{item:9224}（{skill:171}或拍賣行）、對付長時間風箏的大藍藥，條件允許再帶一把附了屠魔的武器。訓練師給的{spell:19878}能在地圖上顯示偽裝的惡魔。組隊時把拾取設成自由拾取，好拿它的頭。",
	-- {spell:19878} Track Demons
	["Learn {spell:19878} and get demon-slaying potions"] = "學會{spell:19878}，並備好屠魔藥水",

	-- Step 4: Simone the Inconspicuous
	-- {npc:14527} Simone the Inconspicuous · {spell:19878} Track Demons · {npc:14533} Simone the Seductress · {spell:421} Chain Lightning · {spell:3034} Viper Sting · {spell:23205} Temptress' Kiss
	["{npc:14527}, a troll with a wolf, walks a long path that starts at the lake in western Un'Goro and can reach the south of the crater; use {spell:19878}. Talk to her and she becomes {npc:14533}, and her wolf Precious a Felstalker. The hardest of the four: Freezing Trap Precious and pull Simone well away from it, or kite Precious away and kill it first, let Simone reset and come back for her alone. Her {spell:421} hits hard, so drain her mana with {spell:3034} (a 15-second cooldown on Forever) and keep her busy; her {spell:23205} cuts your ranged attack power, so finish her in melee. Loot her head before Precious breaks free."] = "{npc:14527}是一名帶著狼的巨魔，沿一條長路線行走，從安戈洛西部的湖泊出發，最遠可到環形山南部；用{spell:19878}找她。與她交談後她會變成{npc:14533}，她的狼普雷舍斯也會變成魔犬。四者中最難的一個：先冰凍陷阱定住普雷舍斯，把西蒙妮拉到遠處開怪；或者把普雷舍斯風箏走、先殺掉它，讓西蒙妮脫戰復位後再單獨對付她。她的{spell:421}傷害很高，所以用{spell:3034}抽乾她的法力（Forever 中15秒冷卻）並不斷干擾她；她的{spell:23205}會降低你的遠端攻強，所以改用近戰解決她。在普雷舍斯掙脫之前拾取她的頭顱。",

	-- Step 5: Franklin the Friendly
	-- {npc:14529} Franklin the Friendly · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14534} Klinfran the Crazed · {spell:3043} Scorpid Sting · {spell:23257} Demonic Frenzy · {spell:19801} Tranquilizing Shot · {spell:2974} Wing Clip · {spell:2973} Raptor Strike
	["{npc:14529}, a human, wanders the western {zone:1428} south of {area:254}. Talk to him and he becomes {npc:14534}, the easiest of the four. Keep {spell:3043} on him the whole fight: while it lasts he barely hurts you. When he goes into {spell:23257}, remove it with {spell:19801} and never stand in melee while it is up; between frenzies you can fight him in melee with {spell:2974} and {spell:2973}. He cannot leave the {zone:1428}, so kite him around the trees if needed."] = "{npc:14529}是人類，在{area:254}南邊的{zone:1428}西部遊蕩。與他交談後他會變成{npc:14534}，是四者中最容易的。整場戰鬥都保持{spell:3043}：只要它還在，他幾乎傷不到你。當他進入{spell:23257}狀態時，用{spell:19801}驅散，狀態存在期間絕不要站在近戰範圍；狂暴間歇可以用{spell:2974}和{spell:2973}與他近戰。他無法離開{zone:1428}，必要時繞著樹風箏他。",

	-- Step 6: Nelson the Nice
	-- {npc:14536} Nelson the Nice · {area:3428} Ahn'Qiraj · {zone:1451} Silithus · {npc:14530} Solenor the Slayer · {spell:23272} Soul Flame · {spell:13809} Frost Trap · {spell:5384} Feign Death · {spell:2974} Wing Clip · {npc:14761} Creeping Doom · {spell:2643} Multi-Shot
	["{npc:14536}, a gnome, walks around the gates of {area:3428} in the far south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. He enrages with {spell:23272} as he turns: drop a {spell:13809}, {spell:5384}, and he resets without the enrage. {spell:2974} roots him for a long time; while rooted he fears you and sends beetles ({npc:14761}): kill them fast with traps and {spell:2643} before they wear you down."] = "{npc:14536}是個地精，在{zone:1451}最西南方的{area:3428}大門附近走動。與他交談，他會變成{npc:14530}。變身時他會施放{spell:23272}進入狂怒：放下一個{spell:13809}，再用{spell:5384}，即可讓他重置並消除狂怒。{spell:2974}能長時間將他定身；被定身時，他會恐懼你並召來甲蟲（{npc:14761}）：用陷阱和{spell:2643}迅速消滅牠們，以免被持續消耗。",

	-- Step 7: Artorius the Amiable
	-- {npc:14531} Artorius the Amiable · {zone:1452} Winterspring · {area:2255} Everlook · {npc:14535} Artorius the Doombringer · {spell:23298} Demonic Doom · {spell:5118} Aspect of the Cheetah · {spell:1978} Serpent Sting · {spell:23299} Stinging Trauma · {spell:23257} Demonic Frenzy · {spell:19801} Tranquilizing Shot
	["{npc:14531}, a tauren, walks a loop in the rocks of northern {zone:1452}, north of {area:2255}. Talk to him and he becomes {npc:14535}. Within 30 yards of him {spell:23298} hits hard: keep your distance and kite him the whole fight, {spell:5118} on, south down the road. {spell:1978} on him adds {spell:23299}, extra Nature damage, so keep it ticking while you run; his {spell:23257} can be removed with {spell:19801}, but distance matters more. It is a long fight: bring mana potions and plan your kiting path."] = "{npc:14531}是牛頭人，在{zone:1452}北部{area:2255}以北的岩石間繞圈行走。與他交談後他會變成{npc:14535}。在他30碼內{spell:23298}傷害很高：保持距離，整場風箏他，開著{spell:5118}沿路向南跑。在他身上保持{spell:1978}會附加{spell:23299}的額外自然傷害，所以邊跑邊維持它；他的{spell:23257}可以用{spell:19801}驅散，但距離更重要。這是一場持久戰：帶上法力藥水，規劃好風箏路線。",

	-- Step 8: Onyxia
	["Onyxia"] = "奧妮克希亞",
	-- {area:2159} Onyxia's Lair · {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {item:18705} Mature Black Dragon Sinew
	["Onyxia is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}; she returns once a week. She drops one {item:18705} in about two kills of five, lootable without the quest, so only one hunter per kill gets it: settle who first."] = "奧妮克希亞是{area:2159}的40人團隊副本首領，那裡是{zone:1445}南部{area:511}中的一處洞穴；她每週重新整理一次。她約每五次擊殺中有兩次掉落一個{item:18705}，沒有任務也能拾取，所以每次只有一名獵人能拿到：先商量好歸屬。",
	-- {item:18705} Mature Black Dragon Sinew
	["{item:18705}, from Onyxia"] = "{item:18705}，來自奧妮克希亞",

	-- Step 9: Back to the Ancients
	["Back to the Ancients"] = "返回古樹",

	-- Step 10: Rhok'delar and Lok'delar
	-- {item:18707} Ancient Rune Etched Stave · {item:18724} Enchanted Black Dragon Sinew · {item:18715} Lok'delar, Stave of the Ancient Keepers
	["Not confirmed in Forever. In Classic, using the {item:18707} with the {item:18724} in your bags made Rhok'delar, and talking to Vartrus once more then gave {item:18715}, at no extra cost."] = "Forever中尚未確認。在經典版中，背包裡有{item:18724}時使用{item:18707}即可製成洛克德拉爾，然後再和古樹瓦特魯斯交談一次，就會給你{item:18715}，不需額外花費。",
	-- {item:18707} Ancient Rune Etched Stave
	["{item:18707}, by Vartrus"] = "{item:18707}，由古樹瓦特魯斯給予",
	-- {npc:14524} Vartrus the Ancient
	["{npc:14524}: Lok'delar in Classic"] = "{npc:14524}：經典版中的羅可德拉爾",

	-- Step 11: Azuregos
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos · {zone:1447} Azshara · {area:2245} Mazthoril · {area:2255} Everlook · {zone:1452} Winterspring
	["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, stands in southern {zone:1447}, returns only every two to four days and drops it nearly every kill. The elite Cobalt dragonkin in and around {area:2245}, the cave south of {area:2255} in {zone:1452}, drop it about once in 200 kills; Manaclaw there a little more often. Skip the rest of this guide if you do not want the quiver."] = "哈斯塔特的箭袋需要{item:18704}。{npc:6109}是一名團隊副本世界首領，站在{zone:1447}南部，每兩到四天才重新整理一次，幾乎每次必掉。{area:2245}（{zone:1452}中{area:2255}南邊的洞穴）內及其周邊的精英鈷藍龍類約每200次擊殺掉落一次；那裡的法力之爪掉落略多。如果不需要箭袋，可以跳過本篇攻略的其餘內容。",
	-- {item:18704} Mature Blue Dragon Sinew · {npc:6109} Azuregos
	["{item:18704}, from {npc:6109}"] = "{item:18704}，來自{npc:6109}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Azuregos"] = "艾索雷葛斯",
	-- ["Hastat's quiver needs the {item:18704}. {npc:6109}, a world boss for a raid, roams the south of {zone:1447} and drops it most of the time; the Cobalt dragonkin of {zone:1452} drop it very rarely. Skip the rest of this guide if you do not want the quiver."] = "古樹哈斯塔特的箭袋需要{item:18704}。{npc:6109}是需要團隊的世界首領，在{zone:1447}南部遊蕩，大多會掉落；{zone:1452}的深藍龍族極少掉落。如果你不想要箭袋，跳過本指南其餘部分。",
	-- ["Onyxia drops the {item:18705}; she is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}."] = "奧妮克希亞會掉落{item:18705}；她是{area:2159}的40人團隊首領，巢穴位於{zone:1445}南部{area:511}的洞穴中。",
	-- ["The {object:179703} appears in {area:2717} when {npc:12018} yields; it holds the {item:18703} about half the time. {area:2717} is a 40-player raid inside {area:254}. Right-click the leaf to start the quest."] = "{npc:12018}投降時，{object:179703}會出現在{area:2717}；約有一半機率內含{item:18703}。{area:2717}是{area:254}內的40人團隊副本。右鍵點擊葉子開始任務。",
	-- ["Vartrus, Stoma and {npc:14526} stand together in the north of {zone:1448}. Alliance: {area:1998} is the nearest flight point; Horde: {area:1997}."] = "古樹瓦特魯斯、古樹斯托瑪和{npc:14526}一起站在{zone:1448}北部。聯盟：最近的飛行點是{area:1998}；部落：{area:1997}。",
	-- ["{npc:14527}, a troll, stands in the west of {zone:1449}. Talk to her and she becomes {npc:14533}, with a pet of her own. Alone, without your pet."] = "食人妖{npc:14527}站在{zone:1449}西部。和她交談，她會變成{npc:14533}，還帶著自己的寵物。單獨對付，不帶寵物。",
	-- ["{npc:14529}, a human, stands in the west of the {zone:1428}. Talk to him and he becomes {npc:14534}. Alone, without your pet."] = "人類{npc:14529}站在{zone:1428}西部。和他交談，他會變成{npc:14534}。單獨對付，不帶寵物。",
	-- ["{npc:14531}, a tauren, waits in the north-east of {zone:1452}. Talk to him and he becomes {npc:14535}. Fight every demon alone and without your pet: help of any kind makes it vanish. Loot the head."] = "牛頭人{npc:14531}在{zone:1452}東北部等著。和他交談，他會變成{npc:14535}。每個惡魔都要單獨且不帶寵物對付：任何形式的幫助都會讓它消失。拾取頭顱。",
	-- ["{npc:14536}, a gnome, stands in the south-west of {zone:1451}. Talk to him and he becomes {npc:14530}. Alone, without your pet; keep away from the beetles he calls."] = "地精{npc:14536}站在{zone:1451}西南部。和他交談，他會變成{npc:14530}。單獨對付，不帶寵物；遠離他召喚的甲蟲。",
}
