-- Chinese (traditional) (zhTW): the guide forever/horde/tauren/01-mulgore (forever/horde/tauren/01-mulgore.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Camp Narache
	-- {area:221} Camp Narache · {npc:2980} Grull Hawkwind
	["You start on the mesa of {area:221}. {npc:2980} and the chief stand by the big tent in the middle."] = "你從{area:221}的平頂山開始。{npc:2980}和鷹風酋長站在中央的大帳篷旁。",

	-- Step 2: The Hunt Begins
	["Plainstriders roam the grass all around the camp."] = "平原陸行鳥在營地周圍的草地上遊蕩。",

	-- Step 3: Grull Hawkwind
	-- {npc:3059} Harutt Thunderhorn
	["{npc:3059}, the warrior trainer"] = "戰士訓練師{npc:3059}",
	-- {npc:3061} Lanka Farshot
	["{npc:3061}, the hunter trainer"] = "獵人訓練師{npc:3061}",
	-- {npc:3062} Meela Dawnstrider
	["{npc:3062}, the shaman trainer in camp"] = "營地裡的薩滿訓練師{npc:3062}",
	-- {npc:3060} Gart Mistrunner
	["{npc:3060}, the druid trainer beside him"] = "他旁邊的德魯伊訓練師{npc:3060}",

	-- Step 4: Greatmother Hawkwind
	-- {npc:2991} Greatmother Hawkwind · {item:4755} Water Pitcher
	["{npc:2991} sits by the tent on the camp's eastern edge; the {item:4755} stands next to her."] = "{npc:2991}坐在營地東緣的帳篷旁；{item:4755}就在她旁邊。",

	-- Step 6: The Hunt Continues
	-- {npc:6775} Antur Fallow · {npc:2980} Grull Hawkwind
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:6775} stands at the west end of the camp, at the north-west corner of the hills where the Mountain Cougars prowl: take his quest, hunt the cougars from there south and east, then come back up to {npc:2980}."] = "{npc:6775}站在營地西端，山獅出沒的丘陵西北角：接他的任務，從那裡往南和往東獵殺山獅，然後回到{npc:2980}那裡。",

	-- Step 7: Grull Hawkwind
	-- {npc:3209} Brave Windfeather · {npc:2980} Grull Hawkwind
	["{npc:3209}, next to {npc:2980}"] = "{npc:3209}，在{npc:2980}旁邊",

	-- Step 8: Seer Graytongue
	["Follow the path south out of camp to the Seer's tent at the foot of the hills."] = "沿小徑向南出營地，前往山腳下灰舌先知的帳篷。",

	-- Step 9: The shrine of An'she and Mu'sha
	["The shrine of An'she and Mu'sha"] = "安希與Mu'sha的神殿",
	-- {object:660739} Ritual Fire (no name in this language: may be words)
	["The incense burns out in ten minutes: run straight east along the southern hills to the {object:660739}."] = "薰香十分鐘就會燒完：沿南邊的丘陵直接向東跑到{object:660739}。",

	-- Step 10: Brambleblade Ravine
	-- {npc:8554} Chief Sharptusk Thornmantle · {object:3076} Dirt-stained Map
	["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {object:3076} lies on the ground in the camp."] = "鬥豬在神殿北邊吃草；刺背野豬人佔據東北方的峽谷。{npc:8554}站在峽谷東端，{object:3076}就在營地的地上。",

	-- Step 11: Camp Narache
	["Back west to the camp."] = "向西回到營地。",

	-- Step 12: Seer Ravenfeather
	-- {npc:5888} Seer Ravenfeather · {area:221} Camp Narache · {quest:1516} Call of Earth
	["{npc:5888} stands in {area:221}. {quest:1516} needs level 4, which you reach with the turn-ins here."] = "{npc:5888}站在{area:221}。{quest:1516}需要4級，在這裡繳交任務就能達到。",

	-- Step 13: Ritual Salve
	-- {area:358} Brambleblade Ravine
	-- plural, as words: Bristleback Shamans = {npc:2953} Bristleback Shaman
	["Back east to {area:358}: the Bristleback Shamans stand among the quilboar there."] = "向東回到{area:358}：刺背薩滿站在那裡的野豬人之間。",

	-- Step 14: Call of Earth
	-- {npc:5888} Seer Ravenfeather · {npc:5891} Minor Manifestation of Earth · {item:6635} Earth Sapta · {item:6656} Rough Quartz
	["Back to {npc:5888} in the camp. The {npc:5891} waits on the mesa east of the camp: drink the {item:6635} there to see it, then take the {item:6656} back to the Seer."] = "回到營地找{npc:5888}。{npc:5891}在營地東邊的平頂山上等著：在那裡喝下{item:6635}才能看見它，然後把{item:6656}帶回給先知。",
	-- {npc:5888} Seer Ravenfeather · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5888}: {npc:5873} and your {item:5175}"] = "{npc:5888}：{npc:5873}和你的{item:5175}",

	-- Step 15: Kaga Wildhoof
	-- {area:220} Red Cloud Mesa · {npc:265810} Kaga Wildhoof · {area:222} Bloodhoof Village · {spell:1229451} Boosted Rest
	["Follow the road north out of {area:220}. {npc:265810} waits on the road just south of {area:222}; /sit by her campfire until you get {spell:1229451}."] = "沿道路從{area:220}向北走。{npc:265810}在{area:222}南邊不遠的路上等著；在她的營火旁 /sit，直到獲得{spell:1229451}。",
	-- {spell:1229451} Boosted Rest
	["/sit by Kaga's campfire until you get {spell:1229451}"] = "在Kaga的營火旁 /sit，直到獲得{spell:1229451}",

	-- Step 16: Bloodhoof Village
	-- {npc:3067} Pyall Silentstride
	["Speak with {npc:3067}"] = "與{npc:3067}交談",

	-- Step 17: Poison Water
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Prairie Wolves and Adult Plainstriders roam the plains around the village."] = "草原狼和成年平原陸行鳥在村子周圍的平原遊蕩。",

	-- Step 19: Winterhoof Water Well
	["The well lies south-east of the village."] = "水井在村子東南方。",

	-- Step 21: Chakuyak and Thunderhorn Totem
	-- {quest:96130} Chakuyak · {quest:756} Thunderhorn Totem
	["{quest:96130} and {quest:756}"] = "{quest:96130}與{quest:756}",
	-- {quest:96130} Chakuyak
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker · Flatland Cougars = {npc:3035} Flatland Cougar
	["{quest:96130}, a lone wolf, prowls the plains west of the village. Prairie Stalkers and Flatland Cougars roam the plains north and west of it."] = "孤狼{quest:96130}在村子西邊的平原徘徊。草原捕食者和平原獅在村子北邊和西邊的平原遊蕩。",

	-- Step 22: Back to Bloodhoof
	["Back to Bloodhoof"] = "返回血蹄村",
	-- {npc:2993} Baine Bloodhoof · {npc:3057} Cairne Bloodhoof · {zone:1456} Thunder Bluff
	["{npc:2993}, for {npc:3057} in {zone:1456}"] = "{npc:2993}，給{zone:1456}的{npc:3057}",
	-- {npc:2948} Mull Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:2948}, for Hamuul in {zone:1456}"] = "{npc:2948}，給{zone:1456}的大德魯伊哈繆爾·符文圖騰",

	-- Step 23: Sparring Match
	-- {npc:3063} Krang Stonehoof
	-- plural, as words: Novice Warriors = {npc:10721} Novice Warrior
	["{npc:3063}'s quest: beat three Novice Warriors (or players in duels) next to him."] = "{npc:3063}的任務：在他旁邊擊敗三名新戰士（或在決鬥中擊敗玩家）。",

	-- Step 25: Ahab Wheathoof
	-- {npc:277182} Ahab Wheathoof · {item:287505} Tender Strider Meat
	["{npc:277182} stands at the north edge of the village. Kyle wants {item:287505} from plainstriders."] = "{npc:277182}站在村子北緣。Kyle想要從平原陸行鳥取得的{item:287505}。",

	-- Step 26: Thunderhorn Water Well
	-- {item:4809} Ambercorn · {quest:766} Mazzranache · {quest:761} Swoop Hunting
	-- plural, as words: Well Stones = {item:4808} Well Stone
	["The well lies north of the village. Well Stones sit around the well, {item:4809} lies under the trees nearby. Kill wolves, cougars, plainstriders and swoops on the way for {quest:766} and {quest:761}."] = "水井在村子北邊。水井石放在井的周圍，{item:4809}在附近的樹下。途中擊殺狼、山獅、平原陸行鳥和猛鷲，完成{quest:766}和{quest:761}。",

	-- Step 27: Bloodhoof Village
	-- {npc:277182} Ahab Wheathoof
	["{npc:277182}, at the north end of the village"] = "{npc:277182}，在村子北端",

	-- Step 28: Swoop Hunting
	["Swoops glide over the plains all around Bloodhoof."] = "猛鷲在血蹄村周圍的平原上空滑翔。",

	-- Step 29: Morin Cloudstalker
	-- {npc:2988} Morin Cloudstalker · {area:396} Winterhoof Water Well
	["{npc:2988} camps by the {area:396} south-east of Bloodhoof."] = "{npc:2988}在血蹄村東南方的{area:396}旁紮營。",

	-- Step 30: Longwalker Malah
	-- {npc:275789} Malah Longwind · {area:821} Rolling Plains
	["{npc:275789} stands on the {area:821} a little east of the well."] = "{npc:275789}站在水井東邊不遠的{area:821}。",

	-- Step 31: Galak centaurs and Prairie Wolf Alphas
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Galak centaurs and Prairie Wolf Alphas"] = "加拉克半人馬與草原狼前鋒",
	-- {area:821} Rolling Plains
	-- plural, as words: Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["The Galak centaurs camp on the plains north of the {area:821}; Herak leads them. Prairie Wolf Alphas roam among the wolves."] = "加拉克半人馬在{area:821}北邊的平原紮營；由『掠取者』赫拉克率領。草原狼前鋒在狼群之中遊蕩。",

	-- Step 32: The Ravaged Caravan
	-- {zone:1456} Thunder Bluff
	["The wrecked caravan lies north-west of the centaurs, east of the road to {zone:1456}."] = "失事的商隊在半人馬西北方、通往{zone:1456}的道路東邊。",

	-- Step 34: Mazzranache
	["Finish the wolf heart, cougar femur, plainstrider scale and swoop gizzard on the plains around the village."] = "在村子周圍的平原收集完狼心、山獅股骨、平原陸行鳥鱗片和猛鷲砂囊。",

	-- Step 36: Morin Cloudstalker
	-- {area:396} Winterhoof Water Well
	["Back south-east to the {area:396}."] = "向東南回到{area:396}。",

	-- Step 37: The Venture Co. Mine
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes
	["The goblins work the mine in the hills north-east of the well. {quest:765} stands in the back of the mine; his {item:281031} start {quest:98424}, and the other pages lie inside the mine."] = "哥布林在水井東北方丘陵的礦坑工作。{quest:765}站在礦坑深處；他的{item:281031}會開啟{quest:98424}，其他書頁在礦坑裡。",

	-- Step 38: Wildmane Water Well
	-- {zone:1456} Thunder Bluff · {area:398} Wildmane Water Well · {zone:1412} Mulgore
	["Cross north-west past {zone:1456} to the {area:398} in the far north of {zone:1412}."] = "向西北經過{zone:1456}，前往{zone:1412}最北邊的{area:398}。",

	-- Step 39: Dangers of the Windfury
	-- {area:819} Windfury Ridge
	["The Windfury harpies hold {area:819}, north and west of the well."] = "風怒鷹身人佔據水井北邊和西邊的{area:819}。",

	-- Step 40: Seer Wiserunner
	-- {npc:2984} Seer Wiserunner · {area:404} Bael'dun Digsite
	["{npc:2984} stands at the edge of the {area:404}, south of the well."] = "{npc:2984}站在{area:404}邊緣，水井南邊。",

	-- Step 41: Dwarven Digging
	-- {area:404} Bael'dun Digsite · {area:222} Bloodhoof Village
	-- plural, as words: Prospector's Picks = {item:4702} Prospector's Pick
	["The dwarves of the {area:404} carry the Prospector's Picks. Smash them at the forge in {area:222}."] = "{area:404}的矮人身上帶著勘察員的鋤頭。在{area:222}的熔爐砸毀它們。",

	-- Step 42: Sharing the Land
	-- {area:818} Palemane Rock · {npc:272203} Perith Stormhoof
	["The Palemane gnolls hold {area:818}, south of the digsite and west of Bloodhoof. {npc:272203} is held in their camp: lead him out."] = "白鬃豺狼人佔據{area:818}，位於挖掘場南邊、血蹄村西邊。{npc:272203}被關在他們的營地裡：帶他出來。",

	-- Step 45: Red Rocks
	-- {area:225} Red Rocks · {zone:1456} Thunder Bluff · {npc:3233} Lorekeeper Raintotem · {npc:2994} Ancestral Spirit
	-- plural, as words: Bristleback Interlopers = {npc:3232} Bristleback Interloper
	["Head north to {area:225}, east of {zone:1456}. {npc:3233} stands at the foot of the rocks; the Bristleback Interlopers dig at the burial ground and the {npc:2994} waits on top."] = "向北前往{zone:1456}東邊的{area:225}。{npc:3233}站在岩石底部；刺背干涉者在墓地挖掘，{npc:2994}在頂上等著。",
	-- {area:225} Red Rocks
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler
	["Flatland Prowlers roam the plains around {area:225}"] = "平原徘徊者在{area:225}周圍的平原遊蕩",

	-- Step 46: Thunder Bluff
	-- {npc:2995} Tal · {npc:3057} Cairne Bloodhoof
	["Ride a lift up to the mesas. {npc:2995} keeps the wind riders on the central rise; {npc:3057} stands in the great tent there."] = "搭升降梯上到平頂山。{npc:2995}在中央高台照料雙足飛龍；{npc:3057}站在那裡的大帳篷裡。",

	-- Step 47: Traditions of the Bluff
	-- {npc:269068} Eylah Sunhorn · {npc:3014} Nida Winterhoof · {npc:3012} Nata Dawnstrider · {npc:3005} Mahu · {npc:3027} Naal Mistrunner · {item:278078} Prepared Incense
	["{npc:269068} wants tauren incense: buy its four parts from {npc:3014} the herbalist, {npc:3012} the enchanting supplier, {npc:3005} the leatherworking supplier and {npc:3027} the cooking supplier, then combine them into {item:278078}."] = "{npc:269068}想要牛頭人的薰香：向草藥商{npc:3014}、附魔供應商{npc:3012}、製皮供應商{npc:3005}和烹飪供應商{npc:3027}購買四種材料，然後合成{item:278078}。",
	-- {item:278079} Bundle of Herbs · {npc:3014} Nida Winterhoof
	["{item:278079}, from {npc:3014}"] = "{item:278079}，向{npc:3014}購買",
	-- {item:278080} Bundle of Dried Cedar Twigs · {npc:3012} Nata Dawnstrider
	["{item:278080}, from {npc:3012}"] = "{item:278080}，向{npc:3012}購買",
	-- {item:278081} Sinew Thread · {npc:3005} Mahu
	["{item:278081}, from {npc:3005}"] = "{item:278081}，向{npc:3005}購買",
	-- {item:278083} Ceremonial Flint and Tinder · {npc:3027} Naal Mistrunner
	["{item:278083}, from {npc:3027}"] = "{item:278083}，向{npc:3027}購買",

	-- Step 48: Hunter Rise
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Use the {item:278078} at the ceremonial mat and burner on the south-facing cliff of {area:1641}."] = "在{area:1641}朝南的懸崖上，對儀式墊和香爐使用{item:278078}。",
	-- {item:278078} Prepared Incense · {area:1641} Hunter Rise
	["Spread the {item:278078} off {area:1641}"] = "在{area:1641}撒下{item:278078}",
	-- {npc:3441} Melor Stonehoof · {quest:860} Sergra Darkthorn · {area:380} Crossroads
	["{npc:3441}: for {quest:860} at the {area:380}"] = "{npc:3441}：給{area:380}的{quest:860}",

	-- Step 50: Elder Rise
	-- {npc:5769} Arch Druid Hamuul Runetotem · {npc:3448} Tonga Runetotem · {area:380} Crossroads
	["{npc:5769}: for {npc:3448} at the {area:380}"] = "{npc:5769}：給{area:380}的{npc:3448}",

	-- Step 52: Turak Runetotem
	-- {npc:6746} Innkeeper Pala · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:6746} on the central rise sends you to {npc:3033} on {area:1639}."] = "中央高台的{npc:6746}會派你去{area:1639}找{npc:3033}。",

	-- Step 53: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {quest:5930} Great Bear Spirit
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the north-western woods."] = "施放{spell:18960}。{npc:11802}在{area:2361}；{quest:5930}在西北方的樹林中。",

	-- Step 54: Back to Thunder Bluff
	-- {area:222} Bloodhoof Village · {area:1639} Elder Rise
	["Hearth to {area:222} and ride north to {area:1639}."] = "用爐石回到{area:222}，向北騎到{area:1639}。",

	-- Step 55: Yaw Sharpmane
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod · {npc:2956} Adult Plainstrider · {npc:2959} Prairie Stalker
	["Ride down to {area:222} and tame with the {item:15908}: an {npc:2956} on the plains, a {npc:2959} north of the village, a Swoop to the north-west."] = "騎下山到{area:222}，用{item:15908}馴服：平原上的一隻{npc:2956}、村子北邊的一隻{npc:2959}，以及西北方的一隻猛鷲。",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "用{item:15908}馴服牠",

	-- Step 56: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {zone:1412} Mulgore · {item:15710} Cenarion Lunardust
	["The stone stands in the pass out of {zone:1412}, on your way east. Use the {item:15710} there and defeat Lunaclaw."] = "石頭位於離開{zone:1412}的山口，就在你往東的路上。在那裡使用{item:15710}並擊敗月爪梟獸。",

	-- Step 57: Crossroads
	-- {zone:1412} Mulgore · {area:380} Crossroads · {quest:860} Sergra Darkthorn · {npc:3448} Tonga Runetotem · {zone:1413} The Barrens
	["Leave {zone:1412} by the south-eastern pass and follow the road to the {area:380}. {quest:860} stands by the inn, {npc:3448} at the south gate. {zone:1413} guide starts here."] = "從東南方的山口離開{zone:1412}，沿道路前往{area:380}。{quest:860}站在旅店旁，{npc:3448}在南門。{zone:1413}指南從這裡開始。",

	-- Step 58: Class turn-ins in Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Class turn-ins in {area:1638}"] = "{area:1638}的職業任務繳交",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Battleboars graze north of the shrine; the Bristleback quilboar hold the ravine to the north-east. {npc:8554} stands at its eastern end, and the {item:4851} lies on the ground in the camp."] = "鬥豬在神殿北邊吃草；刺背野豬人佔據東北方的峽谷。{npc:8554}站在峽谷東端，{item:4851}就在營地的地上。",
	-- ["The {area:380}"] = "{area:380}",
}
