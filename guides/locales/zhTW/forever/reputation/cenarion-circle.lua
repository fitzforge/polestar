-- Chinese (traditional) (zhTW): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "塞納里奧議會聲望",
	-- {zone:1451} Silithus
	["Nature resistance enchants and patterns, badge gear and Forever's new {zone:1451} patterns, from {zone:1451}'s camps."] = "自然抗性附魔和圖樣、徽章裝備以及Forever新增的{zone:1451}圖樣，來自{zone:1451}的營地。",
	-- {zone:1451} Silithus
	["Forever's new {zone:1451} patterns for Tailors, Leatherworkers and Blacksmiths, Friendly and Honored"] = "Forever為裁縫、制皮和鍛造新增的{zone:1451}圖樣，友善和尊敬",

	-- Step 1: The emissary in Ironforge
	-- {zone:1455} Ironforge
	["The emissary in {zone:1455}"] = "{zone:1455}的特使",
	-- {npc:15187} Cenarion Emissary Jademoon · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15187} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "可選，只有後續的挖掘任務才需要：{npc:15187}讓你帶著{quest:8275}去{zone:1451}，那是一封值10點聲望的信。如果你已經在{zone:1451}，就跳過。",

	-- Step 2: The emissary in Orgrimmar
	-- {zone:1454} Orgrimmar
	["The emissary in {zone:1454}"] = "{zone:1454}的特使",
	-- {npc:15188} Cenarion Emissary Blackhoof · {zone:1451} Silithus · {quest:8276} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15188} sends you to {zone:1451} with {quest:8276}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "可選，只有後續的挖掘任務才需要：{npc:15188}讓你帶著{quest:8276}去{zone:1451}，那是一封值10點聲望的信。如果你已經在{zone:1451}，就跳過。",

	-- Step 3: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {faction:609} Cenarion Circle · {npc:15270} Huum Wildmane · {quest:8318} Secret Communication · {item:20404} Encrypted Twilight Text
	["{area:3425} is the walled druid camp in north-central {zone:1451}, with flight points for both sides. Everyone starts Neutral with the {faction:609} (druids at 2,000 of 3,000). Bor and {npc:15270} stand together in the main building. {quest:8318} opens the {item:20404} turn-ins for good. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3425}是{zone:1451}中北部有圍牆的德魯伊營地，兩陣營都有飛行點。所有人對{faction:609}都從中立起步（德魯伊為3,000中的2,000）。博爾和{npc:15270}一起站在主建築裡。{quest:8318}會永久開放{item:20404}的交納。傳承特長“外交家”可使每次獲取量最多提高10%；本指南中的數字不含它。",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, level 60"] = "{npc:15270}，60級",

	-- Step 4: The cultist camp west of Cenarion Hold
	-- {area:3425} Cenarion Hold
	["The cultist camp west of {area:3425}"] = "{area:3425}以西的教徒營地",
	-- {item:20404} Encrypted Twilight Text · {npc:11804} Twilight Keeper Havunth
	-- plural, as words: Wind Stones = {object:180461} Wind Stone
	["The nearest Twilight's Hammer camp lies just south-west of the Hold. Avengers, Geolords and Stonecallers (level 57 to 59) each drop an {item:20404} about a third of the time, and every cultist kill is 1 reputation. {npc:11804} walks the edge of the camp. Keep every cultist robe, cowl and mantle you loot: they are the Twilight Trappings for the Wind Stones later."] = "最近的暮光之錘營地就在要塞西南。復仇者、地質領主和喚石者（57到59級）各約三分之一機率掉落一份{item:20404}，而每殺一個教徒得1點聲望。{npc:11804}在營地邊緣走動。拾到的每一件教徒長袍、頭巾和披肩都留著：它們就是之後風石所需的暮光裝束。",

	-- Step 5: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "返回{area:3425}",

	-- Step 6: Cultists until the top of Friendly, texts saved
	["Cultists until the top of Friendly, texts saved"] = "刷教徒直到友善滿，文字留著",
	-- {npc:11880} Twilight Avenger · {item:20404} Encrypted Twilight Text · {area:2742} Hive'Ashi · {npc:15308} Twilight Prophet · {npc:15306} Bor Wildmane
	["Neutral to Honored is 9,000 reputation (7,000 for druids). Every {npc:11880}, Geolord, Stonecaller, Master and Overlord gives 1 reputation until 5,999 of 6,000 Friendly, one point short of Honored; there they stop. Save every {item:20404} and leave the quests of the next steps for later: each kill below that point is a free point on top of its text, and the texts and quests pay the same at any standing. A text drops about every third kill, so 30 kills make 30 reputation and 10 texts (100 reputation later). Four camps: south-west of the Hold (39,44), the far west (26,34), the far south-west (19,84) and the north-east below {area:2742} (66,18: Overlords, and Flamereavers that count until the top of Honored). The {npc:15308} (87% text) walks between 18,31 and 23,69. Texts sell on the auction house if you would rather buy. At 5,999 Friendly the last point into Honored comes from a Flamereaver, Twilight Keeper or Marauder, or from your first 10 texts at {npc:15306}."] = "從中立到尊敬需要9,000點聲望（德魯伊7,000點）。每個{npc:11880}、地質領主、喚石者、大師和霸主都給1點聲望，直到友善的5,999/6,000，離尊敬只差一點；到那裡他們就停止給聲望。把每份{item:20404}都留著，後續步驟的任務也留到以後做：在那一點之前的每次擊殺，除了文字之外還白得一點；而文字和任務在任何聲望等級都付同樣的點數。約每三次擊殺掉一份文字，所以30次擊殺可得30點聲望和10份文字（之後值100點）。四個營地：要塞西南（39,44）、最西邊（26,34）、最西南（19,84）和{area:2742}下方的東北（66,18：霸主，以及計入到尊敬滿的裂焰者）。{npc:15308}（87%掉文字）在18,31和23,69之間走動。如果你寧願花錢，文字在拍賣行有售。友善5,999時，進入尊敬的最後一點來自裂焰者、暮光守護者或掠奪者，或者在{npc:15306}處交最初10份文字。",
	["Kills alone to the top of Friendly is 8,999 kills (6,999 for druids), but the texts they drop (about 3,000) are worth 30,000 more: most of the way to Exalted."] = "只靠擊殺刷到友善滿需要8,999次擊殺（德魯伊6,999次），但他們掉落的文字（約3,000份）還能再值30,000點：足夠走到崇拜的大部分路程。",
	-- {item:20732} Formula: Enchant Cloak - Greater Fire Resistance · {item:22251} Cenarion Herb Bag · {item:22758} Sylvan Shoulders
	["Friendly (3,000) opens Kania's {item:20732} (10g), Mishta's {item:22251} (2g) and {item:22758} (5g), and Forever's new Friendly gloves patterns (7g 50s)."] = "友善（3,000）解鎖卡尼亞的{item:20732}（10金）、米什塔的{item:22251}（2金）和{item:22758}（5金），以及Forever新增的友善手套圖樣（7金50銀）。",
	-- {item:20404} Encrypted Twilight Text
	["{item:20404}: save them"] = "{item:20404}：留著",
	-- {npc:15201} Twilight Flamereaver
	["{npc:15201}: still counts at 5,999 Friendly"] = "{npc:15201}：友善5,999時仍計入",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100, for the last point"] = "{npc:15306}：10份文字，100，用於最後一點",

	-- Step 7: Vyral the Vile
	-- {quest:8321} Vyral the Vile · {area:3446} Twilight's Run · {zone:1451} Silithus
	-- plural, as words: Twilight Masters = {npc:11883} Twilight Master
	["{quest:8321} (level 61, not elite) waits at the back of {area:3446}, the cave in the north-east of {zone:1451}. Flamereavers and Twilight Masters guard the way: the Flamereavers count until the top of Honored, the Masters stop at the top of Friendly like the other cultists."] = "{quest:8321}（61級，非精英）等在{area:3446}深處，那是{zone:1451}東北的洞穴。裂焰者和暮光大師把守道路：裂焰者計入到尊敬滿，而大師和其他教徒一樣在友善滿時停止。",

	-- Step 8: Silithus quests at Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451} quests at {area:3425}"] = "{zone:1451}任務：{area:3425}",
	-- {quest:8280} Securing the Supply Lines · {quest:8275} Taking Back Silithus · {npc:15196} Deathclasp · {npc:15174} Calandrath · {quest:8307} Desert Recipe · {item:20452} Smoked Desert Dumplings · {npc:15189} Beetix Ficklespragg
	["Now cash in the one-time quests: about 1,700 reputation alone, 2,400 with the group quests. They are level 55 to 60, so they pay in full at 60. {quest:8280} needs {quest:8275} first. {npc:15196} is an elite scorpid with two guards (group of 2 or 3). {npc:15174}'s {quest:8307} is for Cooks: its recipe makes the {item:20452} he wants. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "現在去完成一次性任務：單人任務約1,700聲望，加上小隊任務共2,400。這些任務為55到60級，所以60級時能拿到全額聲望。{quest:8280}需要先完成{quest:8275}。{npc:15196}是一隻精英蠍子，帶兩個護衛（需2到3人小隊）。{npc:15174}的{quest:8307}是給烹飪者的：其配方可做出他要的{item:20452}。{npc:15189}站在他所在建築的樓上：從室內上樓，箭頭無法區分樓層。",
	-- {npc:15191} Windcaller Proudhorn · {quest:8275} Taking Back Silithus
	["{npc:15191}, after {quest:8275}"] = "{npc:15191}，完成{quest:8275}後",
	-- {npc:15196} Deathclasp
	["Wanted poster: {npc:15196}, elite"] = "通緝令：{npc:15196}，精英",
	-- {npc:15174} Calandrath
	["{npc:15174}, for Cooks"] = "{npc:15174}，給廚師",

	-- Step 9: Around Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Around {area:3425}"] = "{area:3425}一帶",
	-- {object:180503} Sandy Cookbook
	-- plural, as words: Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer · Dredge Strikers = {npc:11740} Dredge Striker
	["Stonelash Scorpids and Sand Skitterers roam the sands around the Hold; Dredge Strikers dig north-east of it. The {object:180503} lies in the cultist camp south-west of the Hold."] = "石鞭蠍和沙地疾行者在要塞周圍的沙地上游蕩；挖掘打擊者在要塞東北挖掘。{object:180503}在要塞西南的教徒營地裡。",

	-- Step 10: Back at the Hold
	["Back at the Hold"] = "回到要塞",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}站在他所在建築的樓上：從室內上樓，箭頭無法區分樓層。",

	-- Step 11: Stonelash and Dredge Crushers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash and Dredge Crushers"] = "石鞭蠍與挖掘粉碎者",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker · Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash Flayers, Pincers and Rock Stalkers live south and south-west of the Hold; their stingers and fangs drop about one time in ten. Dredge Crushers dig south and west of the Hold."] = "石鞭撕掠者、石鞭鉗蟲和岩石潛伏者住在要塞以南和西南；它們的毒刺和獠牙約十次擊殺掉一個。挖掘粉碎者在要塞以南和以西挖掘。",
	-- {item:20452} Smoked Desert Dumplings · {object:180503} Sandy Cookbook
	["{item:20452}, from the {object:180503}"] = "{item:20452}，來自{object:180503}",
	-- {item:20452} Smoked Desert Dumplings · {item:20424} Sandworm Meat · {item:3713} Soothing Spices
	["{item:20452}, from {item:20424} and {item:3713}"] = "{item:20452}，來自{item:20424}和{item:3713}",

	-- Step 12: Noggle Ficklespragg and Proudhorn
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} and Proudhorn"] = "{npc:15190}和傲角",
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189}和{npc:15190}站在他們所在建築的樓上：從室內上樓，箭頭無法區分樓層。",

	-- Step 13: The Ravaged Twilight Camp
	-- {area:3100} Ravaged Twilight Camp
	["The {area:3100}"] = "{area:3100}",
	-- {zone:1451} Silithus
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["The broken camp in the far north-west of {zone:1451}: the Twilight Tablet Fragments lie on the ground among the ruins."] = "{zone:1451}最西北的破敗營地：暮光石板碎片散落在廢墟之間的地上。",

	-- Step 14: Larksbane
	["Larksbane"] = "拉克斯班",

	-- Step 15: Hermit Ortell
	-- {npc:15194} Hermit Ortell · {zone:1451} Silithus · {quest:8319} Encrypted Twilight Texts · {quest:8349} Bor Wildmane
	["{npc:15194} hides in the hills of eastern {zone:1451}. He also decodes {quest:8319} for a chance at a scroll of beckoning, but {quest:8349} pays the reputation: keep the texts for Bor."] = "{npc:15194}藏在{zone:1451}東部的山丘裡。他也能解讀{quest:8319}，有機會得到一張召喚卷軸，但{quest:8349}才給聲望：把文字留給博爾。",

	-- Step 16: The three Twilight Keepers
	["The three Twilight Keepers"] = "三位暮光守護者",
	["Each Keeper is a level 60, not elite, alone at a camp edge, and always drops its chapter: Mayna in the far west camp, Havunth in the camp south-west of the Hold, Exeter in the far south-west camp beside the Twilight Lord."] = "每位守護者都是60級非精英，獨自守在營地邊緣，必定掉落它那一章：梅娜在最西邊的營地，哈文斯在要塞西南的營地，埃克塞特在最西南的營地、暮光領主旁邊。",

	-- Step 17: Back to Ortell
	["Back to Ortell"] = "回到奧特爾",

	-- Step 18: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "銅鬚營地",
	-- {zone:1451} Silithus · {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {quest:8304} Dearest Natalia · {item:20379} Noggle's Satchel · {npc:15196} Deathclasp · {spell:10101} Knock Away
	["The dwarves' camp in the south of {zone:1451}. Talk {npc:15171} and {npc:15170} through their whole stories for {quest:8304}. {item:20379} lies on the mountain south-east of the camp. {npc:15196} lives up the trail east of the camp: an elite, and his {spell:10101} can throw you off the cliff."] = "矮人營地在{zone:1451}南部。把{npc:15171}和{npc:15170}的完整故事聽完，可獲得{quest:8304}。{item:20379}在營地東南的山上。{npc:15196}住在營地以東的小路上：他是精英，他的{spell:10101}能把你打下懸崖。",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170}"] = "{npc:15171}和{npc:15170}",
	-- {item:20385} Deathclasp's Pincer
	["{item:20385}, elite: group of 2 or 3"] = "{item:20385}，精英：2或3人隊伍",

	-- Step 19: Back to Cenarion Hold with news
	-- {area:3425} Cenarion Hold
	["Back to {area:3425} with news"] = "帶著訊息回到{area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190}站在他所在建築的樓上：從室內上樓，箭頭無法區分樓層。",
	["Natalia, elite: group up"] = "納塔莉亞，精英：組隊",

	-- Step 20: Rubbings and brains
	["Rubbings and brains"] = "拓片與大腦",
	-- {object:210337} Glyphed Crystal (no name in this language: may be words) · {item:20453} Geologist's Transcription Kit · {area:2742} Hive'Ashi · {area:2743} Hive'Zora · {area:2744} Hive'Regal · {quest:8308} Brann Bronzebeard's Lost Letter
	["Rutgar and Frankal hand out the next two quests at their camp. Each hive has a {object:210337} to rub with the {item:20453}, and its silithid drop the brains: {area:2742} north of the Hold, {area:2743} in the west, {area:2744} in the south. Inside {area:2744} waits Mistress Natalia (level 62 elite, mind control and fear; group of 3 to 5). Now and then a hive silithid drops {quest:8308}: it starts a quest for Rutgar worth 100."] = "魯特加和弗蘭卡爾在他們的營地發放接下來的兩個任務。每個蟲巢都有一個{object:210337}，可用{item:20453}拓印，而蟲巢的異種蠍會掉落大腦：要塞以北的{area:2742}、西邊的{area:2743}、南邊的{area:2744}。{area:2744}深處有納塔莉亞女士（62級精英，精神控制和恐懼；3到5人隊伍）。蟲巢異種蠍偶爾會掉落{quest:8308}：它會開啟一個給魯特加的任務，值100點。",
	-- {item:20456} Hive'Regal Rubbing · {area:2744} Hive'Regal
	["{item:20456}, deep in {area:2744}"] = "{item:20456}，在{area:2744}深處",
	-- {quest:8308} Brann Bronzebeard's Lost Letter
	["{quest:8308}, a rare drop"] = "{quest:8308}，稀有掉落",

	-- Step 21: Mistress Natalia
	["Mistress Natalia"] = "納塔莉亞女士",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	["Optional: Natalia waits deep in {area:2744}, the hive in the south of {zone:1451}. She is a level 62 elite who mind-controls, fears and heals herself below half health: bring a group of 3 to 5 and interrupt her heals."] = "可選：納塔莉亞等在{area:2744}深處，那是{zone:1451}南部的蟲巢。她是62級精英，會精神控制、恐懼，並在血量低於一半時自愈：帶3到5人隊伍，打斷她的治療。",
	["Mistress Natalia: group of 3 to 5"] = "納塔莉亞女士：3到5人隊伍",

	-- Step 22: The Calling
	-- {quest:8314} Unraveling the Mystery · {quest:8315} The Calling · {npc:15183} Geologist Larksbane · {area:3257} Bones of Grakkarond · {npc:14862} Emissary Roman'khan
	["{quest:8314} leads to {quest:8315}: {npc:15183} sends you to the {area:3257} to summon {npc:14862}, a level 63 boss for a raid of about 20. Take it only with a raid."] = "{quest:8314}會引向{quest:8315}：{npc:15183}讓你去{area:3257}召喚{npc:14862}，一個63級首領，需要約20人團隊。只在有團隊時再去。",
	["raid of 20"] = "20人團隊",
	-- {item:20465} Crystal Unlocking Mechanism · {npc:14862} Emissary Roman'khan
	["{item:20465}, {npc:14862}: raid of 20"] = "{item:20465}，{npc:14862}：20人團隊",

	-- Step 23: The New Frontier, Thunder Bluff
	-- {quest:1123} Rabine Saturna · {npc:10881} Bluff Runner Windstrider · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:1123}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10881} sends you to {npc:5769} on {area:1639}, who sends you to {quest:1123} in {area:2361}, {zone:1450}."] = "可選：{quest:1123}的任務鏈在七個55到57級任務中共給525點塞納里奧聲望，60級時給全額。{npc:10881}讓你去{area:1639}的{npc:5769}那裡，後者再讓你去{zone:1450}的{area:2361}找{quest:1123}。",

	-- Step 24: The New Frontier, Darnassus
	-- {quest:6762} Rabine Saturna · {npc:10878} Herald Moonstalker · {npc:3516} Arch Druid Fandral Staghelm · {npc:4217} Mathrengyl Bearwalker · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:6762}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10878} sends you to {npc:3516}, who sends you to {npc:4217}, who sends you to {quest:6762} in {area:2361}, {zone:1450}."] = "可選：{quest:6762}的任務鏈在七個55到57級任務中共給525點塞納里奧聲望，60級時給全額。{npc:10878}讓你去{npc:3516}那裡，後者讓你去{npc:4217}那裡，再讓你去{zone:1450}的{area:2361}找{quest:6762}。",

	-- Step 25: Rabine Saturna
	-- {quest:1123} Rabine Saturna · {area:2361} Nighthaven · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest · {zone:1451} Silithus
	["{quest:1123} lives in {area:2361}. She sends you to {npc:13220} at {area:3077}, the camp in the north-east corner of {zone:1451}."] = "{quest:1123}住在{area:2361}。她讓你去{area:3077}的{npc:13220}那裡，那是{zone:1451}東北角的營地。",

	-- Step 26: Southwind Village
	-- {area:2738} Southwind Village · {area:3425} Cenarion Hold · {object:178553} Hive'Ashi Pod
	-- plural, as words: Tortured Druids = {npc:12178} Tortured Druid
	["The Tortured Druids and Sentinels roam the ruins of {area:2738}, south-east of {area:3425}; the {object:178553} sits on the top floor of its wasp-circled tower."] = "受折磨的德魯伊和哨兵在{area:2738}的廢墟中游蕩，位於{area:3425}東南；{object:178553}在它那座被黃蜂環繞的塔頂。",

	-- Step 27: Umber in Nighthaven
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} in {area:2361}"] = "{area:2361}的{npc:11939}",

	-- Step 28: Quests elsewhere
	["Quests elsewhere"] = "其他地區的任務",
	-- {faction:609} Cenarion Circle · {zone:1414} Kalimdor · {npc:10739} Mulgris Deepriver · {zone:1422} Western Plaguelands · {area:2100} Maraudon · {quest:1123} Rabine Saturna · {item:18501} Felvine Shard · {area:2577} Dire Maul
	["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. Forever pays them in full at any level: The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) 75 and 75, Corruption of Earth and Seed ({area:2100}, level 51) 150. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "{faction:609}的其他任務分佈在{zone:1414}和瘟疫之地。Forever 裡任何等級都足額給分：《野生動物也受苦》（{npc:10739}，{zone:1422}，54級和56級）75和75，《大地與種子的腐化》（{area:2100}，51級）150。《惡魔藤蔓的碎片》（{quest:1123}，60級，{item:18501}來自{area:2577}的阿茲辛）給150，它的聖物箱任務任何等級再給100。",
	-- {zone:1422} Western Plaguelands · {area:2100} Maraudon
	["Do the {zone:1422} and {area:2100} quests while you level; at 60 they may pay a fraction."] = "升級時就做{zone:1422}和{area:2100}的任務；到60級時它們可能只給一小部分獎勵。",

	-- Step 29: Encrypted Twilight Texts to Revered
	-- {quest:8319} Encrypted Twilight Texts
	["{quest:8319} to Revered"] = "{quest:8319}到崇敬",
	-- {npc:15306} Bor Wildmane · {quest:8319} Encrypted Twilight Texts · {npc:14479} Twilight Lord Everun · {item:20733} Formula: Enchant Cloak - Greater Nature Resistance · {item:22773} Pattern: Sylvan Crown
	["Honored to Revered is 12,000 reputation. {npc:15306} takes 10 {quest:8319} for 100 reputation, again and again, until Exalted: 120 turn-ins (1,200 texts) to Revered without the quests, or about 950 texts after them. Hand in the texts you saved now. The cultists no longer count, but the Flamereavers, Twilight Keepers, Marauders and Templars count until 11,999 of 12,000 Honored, and the {npc:14479} and Prophet until Exalted. Honored opens Kania's {item:20733} (10g), Mishta's {item:22773} (5g) and Forever's new Honored patterns (7g 50s each)."] = "從尊敬到崇敬需要12,000點聲望。{npc:15306}收10份{quest:8319}給100點聲望，可反覆交，直到崇拜：不做任務的話，到崇敬需要交120次（1,200份文字）；做完任務後約需950份文字。現在就把留著的文字交掉。教徒不再計入，但裂焰者、暮光守護者、掠奪者和聖殿騎士計入，直到尊敬的11,999/12,000；{npc:14479}和先知計入到崇拜。尊敬解鎖卡尼亞的{item:20733}（10金）、米什塔的{item:22773}（5金）和Forever新增的尊敬圖樣（每份7金50銀）。",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100"] = "{npc:15306}：10份文字，100",

	-- Step 30: Field Duty, level 60
	-- {quest:8507} Field Duty
	["{quest:8507}, level 60"] = "{quest:8507}，60級",
	-- {npc:15540} Windcaller Kaldon · {area:3425} Cenarion Hold · {quest:8507} Field Duty · {npc:15440} Captain Blackanvil · {area:2743} Hive'Zora · {npc:15612} Krug Skullsplit · {area:2744} Hive'Regal · {item:20809} Tactical Assignment · {item:7936} Ornate Mithril Boots · {npc:15542} Twilight Marauder · {quest:9338} Allegiance to Cenarion Circle
	-- plural, as words: Heavy Runecloth Bandages = {item:14530} Heavy Runecloth Bandage
	["{npc:15540} stands by the moonwell of {area:3425}. {quest:8507} (25 reputation, repeatable) sends you with unsigned papers to your side's captain: {npc:15440}'s Ironforge Brigade outside {area:2743} (Alliance) or {npc:15612}'s Orgrimmar Legion outside {area:2744} (Horde). Use the papers first, then talk to the captain: a level 60 elite silithid attacks; keep the captain alive and he signs. Kaldon then lets you pick a Combat, Logistics or {item:20809}, each holding a random briefing worth 50 reputation and a badge: 30 hive silithid kills (elites), goods such as 30 Heavy Runecloth Bandages or 3 {item:7936}, or one Templar, {npc:15542} or scout report. One badge of each kind buys {quest:9338} at Kaldon: 200 reputation, repeatable. A full round is about 375 reputation."] = "{npc:15540}站在{area:3425}的月井旁。{quest:8507}（25點聲望，可重複）會讓你帶著未簽署的檔案去找本陣營的隊長：{area:2743}外{npc:15440}的鐵爐堡旅（聯盟），或{area:2744}外{npc:15612}的奧格瑪軍團（部落）。先使用檔案，再和隊長交談：一隻60級精英異種蠍會攻擊；讓隊長活下來，他就會簽字。然後卡爾東讓你選擇戰鬥、後勤或{item:20809}，每份都含一份隨機簡報，值50點聲望和一枚徽章：30隻蟲巢異種蠍（精英）、30卷厚符文布繃帶或3個{item:7936}之類的貨物，或一位聖殿騎士、{npc:15542}或偵察報告。在卡爾東處每種各一枚徽章可換{quest:9338}：200點聲望，可重複。完整一輪約375點聲望。",
	["Allegiance: one Combat, Logistics and Tactical badge, 200"] = "效忠：戰鬥、後勤和戰術徽章各一枚，200",
	-- {quest:8800} Cenarion Battlegear · {npc:15176} Vargus
	["{quest:8800}: {npc:15176}'s badge gear"] = "{quest:8800}：{npc:15176}的徽章裝備",

	-- Step 31: Templars and the Abyssal Council
	["Templars and the Abyssal Council"] = "聖殿騎士與深淵議會",
	-- {object:180456} Lesser Wind Stone · {item:20513} Abyssal Crest · {quest:8361} Abyssal Contacts · {npc:15270} Huum Wildmane · {quest:8331} Aurel Goldleaf · {item:14344} Large Brilliant Shard · {object:180461} Wind Stone · {item:20514} Abyssal Signet
	["Wearing a full set of Twilight Trappings (cultist Cowl, Mantle and Robe, about 8%, 8% and 6% per cultist) lets you use a {object:180456}: two stand in each of the three western camps. A random Abyssal Templar appears: a level 60 elite for 1 to 3 players, 5 reputation until the top of Honored and an {item:20513} 93% of the time. The summon uses up the set (and later the medallion and ring too), and if the elemental gets away they are gone: summon only when you can win. {quest:8361} pays 100 for the first crest; after that Bor takes 3 crests for 50. From Friendly, {npc:15270} sends you to {quest:8331}: 3 crests and a {item:14344} buy the Medallion of Station that, worn with a set, opens the larger {object:180461} for a Duke (level 62 elite, group of 5; 25 reputation, {item:20514} 85%)."] = "穿齊一套暮光裝束（教徒的頭巾、披肩和長袍，每隻教徒約8%、8%和6%）就能使用{object:180456}：三個西部營地各立著兩個。會隨機出現一位深淵聖殿騎士：60級精英，適合1到3名玩家，給5點聲望直到尊敬滿，並且93%機率掉落{item:20513}。召喚會消耗整套裝束（之後還要消耗勳章和戒指），而且如果元素逃掉，它們就沒了：只在有把握取勝時才召喚。{quest:8361}為第一枚紋章給100點；之後博爾收3枚紋章給50點。從友善起，{npc:15270}會讓你去接{quest:8331}：3枚紋章和一塊{item:14344}可換身份勳章；它與套裝一起穿戴時，能開啟更大的{object:180461}，召喚一位公爵（62級精英，5人隊伍；25點聲望，85%機率掉{item:20514}）。",
	-- {item:20513} Abyssal Crest
	["{item:20513}: Templar, group of 1 to 3"] = "{item:20513}：聖殿騎士，1到3人隊伍",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Friendly"] = "{npc:15270}，友善",
	-- {item:14344} Large Brilliant Shard
	["3 crests and a {item:14344}: the Medallion of Station"] = "3枚紋章和一塊{item:14344}：身份勳章",
	-- {item:20514} Abyssal Signet
	["{item:20514}: Duke, group of 5"] = "{item:20514}：公爵，5人隊伍",

	-- Step 32: Signets and scepters to Exalted
	["Signets and scepters to Exalted"] = "印戒與權杖：到崇拜",
	-- {quest:8363} Abyssal Signets · {npc:15282} Aurel Goldleaf · {item:20515} Abyssal Scepter · {quest:9248} A Humble Offering · {quest:8343} Goldleaf's Discovery · {quest:8341} Lords of the Council · {object:180466} Greater Wind Stone · {item:22252} Satchel of Cenarius · {item:22660} Gaea's Embrace · {item:22756} Sylvan Vest · {npc:15176} Vargus
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["Revered to Exalted is 21,000 reputation: 210 text turn-ins (2,100 texts), or less with the rest. From Honored, Bor takes 3 {quest:8363} for 100 (each Duke also gives 25, to Exalted), and {npc:15282} takes one {item:20515} for {quest:9248} (200, once). From Revered, {quest:8343} leads to {quest:8341}: 3 signets and 5 Large Brilliant Shards buy the Ring of Lordship, and set, medallion and ring open the {object:180466} for an Abyssal Lord: a level 63 boss for a raid of about 20, 50 reputation, and an {item:20515}. Bor pays 200 for the first scepter and 150 for each 3 after. Revered opens Mishta's {item:22252} (5g), {item:22660} (9g) and {item:22756} (5g); Exalted is the standing for Champion's Battlegear at {npc:15176}."] = "從崇敬到崇拜需要21,000點聲望：交210次文字（2,100份），加上其他途徑會更少。從尊敬起，博爾收3個{quest:8363}給100點（每個公爵也給25點，直到崇拜），{npc:15282}收一個{item:20515}用於{quest:9248}（200點，一次）。從崇敬起，{quest:8343}會引向{quest:8341}：3枚印戒和5塊大塊魔光碎片可換領主之戒，而套裝、勳章和戒指能開啟{object:180466}，召喚一位深淵領主：63級首領，約20人團隊，50點聲望，外加一個{item:20515}。博爾為第一根權杖付200點，之後每3根付150點。崇敬解鎖米什塔的{item:22252}（5金）、{item:22660}（9金）和{item:22756}（5金）；崇拜是{npc:15176}處冠軍戰鬥裝備所需的聲望。",
	["10 texts: 100"] = "10份文字：100",
	-- {quest:8363} Abyssal Signets
	["3 {quest:8363}: 100, Honored"] = "3個{quest:8363}：100，尊敬",
	-- {item:20515} Abyssal Scepter
	["{item:20515}: Lord, raid of 20"] = "{item:20515}：領主，20人團隊",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Revered"] = "{npc:15270}，崇敬",
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["3 signets and 5 Large Brilliant Shards: the Ring of Lordship"] = "3枚印戒和5塊大塊魔光碎片：領主之戒",
	-- {quest:8364} Abyssal Scepters
	["3 {quest:8364}: 150, Revered"] = "3個{quest:8364}：150，崇敬",

	-- Step 33: The Ruins of Ahn'Qiraj, when they open
	-- {area:3454} Ruins of Ahn'Qiraj
	["The {area:3454}, when they open"] = "{area:3454}，開放後",
	-- {area:2737} Scarab Wall · {zone:1451} Silithus · {quest:8791} The Fall of Ossirian · {npc:15185} Brood of Nozdormu · {npc:15498} Windcaller Yessendra · {npc:15500} Keyl Swiftclaw · {npc:15499} Warden Haro · {npc:16091} Dirk Thunderwood · {quest:9023} The Perfect Poison · {item:22217} Kurinnaxx's Venom Sac · {area:19} Zul'Gurub · {npc:15471} Lieutenant General Andorov · {item:22219} Plans: Jagged Obsidian Shield · {item:22191} Obsidian Mail Tunic
	["A 20-player raid behind the {area:2737} in the far south-west of {zone:1451}. A full clear is about 1,600 Cenarion reputation: the trash 3 each until 20,999 of 21,000 Revered, Kurinnaxx, Moam, Buru and Ayamiss 150 each and Ossirian 300, to Exalted. Ossirian's head starts {quest:8791} (200 here and 200 {npc:15185}). Their drops buy the ring (Honored), cloak (Revered) and weapon (Exalted) quests of {npc:15498}, {npc:15500} and {npc:15499} in the Hold, 100 reputation each. {npc:16091} in the Hold pays 100 once for {quest:9023}: {item:22217} from here and Venoxis's from {area:19}. {npc:15471} sells {item:22219} (Revered, 5g) and {item:22191} (Exalted, 8g) inside."] = "位於{zone:1451}最西南{area:2737}之後的20人團隊副本。全通約1,600點塞納里奧聲望：小怪每隻3點，直到崇敬的20,999/21,000；庫林納克斯、莫阿姆、布魯和阿亞米斯各150點，奧西里安300點，直到崇拜。奧西里安的頭顱會開啟{quest:8791}（這裡200點，另加{npc:15185}的200點）。他們的掉落可以換取要塞裡{npc:15498}、{npc:15500}和{npc:15499}的戒指（尊敬）、披風（崇敬）和武器（崇拜）任務，各100點聲望。要塞的{npc:16091}為{quest:9023}一次性支付100點：這裡的{item:22217}和{area:19}溫諾希斯的物品。{npc:15471}在裡面出售{item:22219}（崇敬，5金）和{item:22191}（崇拜，8金）。",

	-- Step 34: Venoxis's Venom Sac, Zul'Gurub
	-- {quest:9023} The Perfect Poison · {npc:14507} High Priest Venoxis · {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale
	["Optional, for {quest:9023}: {npc:14507} is the first boss of {area:19}, a 20-player raid in north-east {zone:1434}."] = "可選，為{quest:9023}：{npc:14507}是{area:19}的第一個首領，那是{zone:1434}東北的20人團隊副本。",
	-- {item:22216} Venoxis's Venom Sac
	["{item:22216}: raid of 20"] = "{item:22216}：20人團隊",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "深淵紋章、深淵徽記和深淵節杖在完成各自的開頭任務後，就能在{npc:15306}處重複繳交。",
	-- ["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "暮光加密文件可重複：{npc:15306}會一再收取更多文件。教徒營地是收集它們的地方。",
	-- ["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "從這裡開始，{area:3454}團隊副本和深淵議會的繳交物（紋章、徽記、節杖）提供大部分聲望。",
	-- ["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "繼續在暮光營地刷。穿上暮光服飾（暮光教徒套裝加上身份勳章，來自{npc:15282}的身份勳章任務）就能在風之石召喚深淵聖殿騎士；牠們的深淵紋章交給{npc:15306}。",
	-- ["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "繼續打{area:3454}並繳交深淵議會的徽章，直到崇拜。",
	-- ["Optional, 100 reputation once: {quest:9419}. Your side's camp sits by a hive: {npc:17080}'s by {area:2743} (Alliance), {npc:17079}'s by {area:2744} (Horde). Silithyst rises from glowing geysers around the desert: walk through one, carry the Silithyst to your camp's Silithyst Extractor, then talk to the camp's leader. It is a world PvP objective: players of the other side can take it from you."] = "可選，一次性100點聲望：{quest:9419}。你所在陣營的營地就在蟲巢旁：{npc:17080}的營地在{area:2743}旁（聯盟），{npc:17079}的在{area:2744}旁（部落）。希利蘇斯晶體從沙漠各處的發光噴泉升起：走進其中一個，把晶體帶到你營地的希利蘇斯晶體萃取器，然後和營地首領交談。這是一個世界PvP目標：敵對陣營的玩家可以從你手中奪走它。",
	-- ["Silithyst"] = "希利蘇斯晶體",
	-- ["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "暮光之錘教徒佔據{zone:1451}西部的營地。{quest:8320}和暮光喚石者混雜在這裡；任何教徒都可能掉落{item:20404}。每擊殺一個教徒也會計入{faction:609}聲望。只有在你60級並接了{quest:8320}時，擊殺地王才會計入該任務。",
	-- ["deliver Silithyst at the extractor"] = "把希利蘇斯晶體送到萃取器",
	-- ["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425}是{zone:1451}中北部有圍牆的城鎮。鮑爾和{npc:15270}一起站在裡面。{faction:609}一開始是中立。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{faction:609} to Exalted"] = "{faction:609}到崇拜",
	-- ["{faction:609} to Honored"] = "{faction:609}到尊敬",
	-- ["{faction:609} to Revered"] = "{faction:609}到崇敬",
	-- ["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}：暮光加密文件",
	-- ["{quest:8320} needs level 60"] = "{quest:8320}需要60級",
}
