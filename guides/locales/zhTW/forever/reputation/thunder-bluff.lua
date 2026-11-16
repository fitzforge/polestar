-- Chinese (traditional) (zhTW): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "雷霆崖聲望",
	-- {zone:1412} Mulgore · {zone:1452} Winterspring · {item:11040} Morrowgrain · {item:14047} Runecloth
	["{zone:1412} quests while you level, {zone:1452} quests and {item:11040} from 55, then {item:14047} to Exalted."] = "練級時做{zone:1412}的任務，55級起做{zone:1452}的任務和交{item:11040}，然後交{item:14047}交到崇拜。",
	-- {faction:81} Thunder Bluff
	["Exalted with {faction:81}"] = "{faction:81}崇拜",

	-- Step 1: Thunder Bluff: how it works
	-- {faction:81} Thunder Bluff
	["{faction:81}: how it works"] = "{faction:81}：運作方式",
	-- {faction:81} Thunder Bluff · {item:11040} Morrowgrain · {npc:14728} Rumstag Proudstrider · {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1412} Mulgore · {area:378} Camp Taurajo · {zone:1441} Thousand Needles
	["{faction:81} reputation comes from quests, {item:11040} and cloth. {npc:14728}, the cloth quartermaster, stands on the central rise among the leatherworkers' and tailors' tents. He takes four one-time donations of 60 cloth (150 each) and then {quest:7825}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:81} also gives a quarter as much to {zone:1454}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:81}'s quests within 5 levels of them: {zone:1412} at 1 to 12, {area:378} and the Crossroads at 13 to 22, {zone:1441} at 25 to 30. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Thunder Bluff's merchants sell to you for 10% less (the Classic rule), the kodo vendor included; at Exalted other races can buy the kodos: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60, once you have mount training. {faction:81} has no tabard or other reward."] = "",
	["his donations are handed in from his window and never enter the log"] = "他的捐獻任務在他的視窗中直接繳交，不會進入任務日誌",

	-- Step 2: Camp Narache (optional hub)
	-- {area:221} Camp Narache
	["{area:221} (optional hub)"] = "{area:221}（可選任務點）",
	-- {area:221} Camp Narache · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2980} Grull Hawkwind · {npc:2981} Chief Hawkwind · {npc:3209} Brave Windfeather
	["Forever pays these old quests in full at any level. {area:221}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "Forever 裡這些舊任務任何等級都足額給分。{zone:1412}南端的{area:221}：25分鐘約1,100點{faction:81}聲望。新手區的任務不分給其他城市。{npc:2980}和{npc:2981}站在營地，{npc:3209}在邊緣。",

	-- Step 3: Greatmother Hawkwind and the plains
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991} and the plains"] = "{npc:2991}與平原",
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991}'s tent is south-east of the camp; the water pitcher stands at the well beside it. Plainstriders graze all around."] = "{npc:2991}的帳篷在營地東南方；水罐就立在旁邊的水井邊。陸行鳥在四周各處吃草。",

	-- Step 4: Camp Narache: hand in
	-- {area:221} Camp Narache
	["{area:221}: hand in"] = "{area:221}：交任務",

	-- Step 5: Seer Graytongue and the cougars
	-- {npc:2982} Seer Graytongue
	["{npc:2982} and the cougars"] = "{npc:2982}與山地獅",
	-- {npc:2982} Seer Graytongue
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:2982} sits on the hill south of the camp; the Mountain Cougars live in those hills."] = "{npc:2982}坐在營地南邊的小山上；山地獅就生活在那些山丘裡。",

	-- Step 6: Camp Narache: the Battleboars
	-- {area:221} Camp Narache
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["{area:221}: the Battleboars"] = "{area:221}：鬥豬",

	-- Step 7: Brambleblade Ravine
	-- {quest:780} The Battleboars · {npc:8554} Chief Sharptusk Thornmantle · {area:358} Brambleblade Ravine · {item:4851} Dirt-stained Map · {quest:781} Attack on Camp Narache
	["{quest:780} graze east of the camp; the Bristleback quilboar and {npc:8554} hold {area:358} beyond them. A {item:4851} lies in the ravine: reading it starts {quest:781}."] = "{quest:780}在營地東邊吃草；刺背野豬人和{npc:8554}佔據著更遠的{area:358}。一張{item:4851}躺在峽谷裡：閱讀它開啟{quest:781}。",

	-- Step 8: Camp Narache: last hand-in
	-- {area:221} Camp Narache
	["{area:221}: last hand-in"] = "{area:221}：最後交任務",
	-- {quest:763} Rites of the Earthmother · {npc:2993} Baine Bloodhoof
	["{quest:763}, +75: to {npc:2993}"] = "{quest:763}，+75：交給{npc:2993}",

	-- Step 10: Bloodhoof Village (optional hub)
	-- {area:222} Bloodhoof Village
	["{area:222} (optional hub)"] = "{area:222}（可選任務點）",
	-- {area:222} Bloodhoof Village · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2993} Baine Bloodhoof · {npc:2947} Harken Windtotem · {npc:2985} Ruul Eagletalon · {npc:3222} Brave Wildrunner · {npc:2988} Morin Cloudstalker
	["Forever pays these old quests in full at any level. {area:222} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes. {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "Forever 裡這些舊任務任何等級都足額給分。{area:222}和{zone:1412}東部：45分鐘約1,000點{faction:81}聲望。{npc:2993}站在村子中間；{npc:2947}、{npc:2985}和{npc:3222}就在附近；{npc:2988}在村子以東的路邊等著。",

	-- Step 11: Eastern Mulgore
	-- {zone:1412} Mulgore
	["Eastern {zone:1412}"] = "{zone:1412}東部",
	-- {quest:99079} Longwalker Malah · {object:2908} Sealed Supply Crate
	["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest."] = "{quest:99079}在東部邊界等著。被毀商隊的{object:2908}在村子東北：開啟它就能接下一個任務。",
	-- {object:2908} Sealed Supply Crate
	["the {object:2908}"] = "{object:2908}",

	-- Step 12: Bloodhoof Village: hand in
	-- {area:222} Bloodhoof Village
	["{area:222}: hand in"] = "{area:222}：交任務",

	-- Step 13: The mine, the centaurs and the plains
	["The mine, the centaurs and the plains"] = "礦井、半人馬與平原",
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes · {zone:1412} Mulgore
	-- plural, as words: Swoops = {npc:2970} Swoop
	["Back to the mine for the workers, supervisors and {quest:765} in the back: his {item:281031} start {quest:98424}, and its other pages lie inside the mine. The Galak centaurs and Herak camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "回到礦洞找工人、監工和最深處的{quest:765}：他的{item:281031}能開啟{quest:98424}，其餘書頁在礦洞裡。加拉克半人馬和赫拉克在村子東邊紮營。斯沃普斯在{zone:1412}到處飛；風怒鷹身女妖在村子東南棲息；白鬃豺狼人在村子西邊紮營。",
	-- {item:281031} Mulgore Expansion Plans · {quest:765} Supervisor Fizsprocket
	["{item:281031}, from {quest:765}"] = "{item:281031}，來自{quest:765}",
	-- {item:281035} Shredder Operation Instructions
	["{item:281035}, inside the mine"] = "{item:281035}，在礦洞裡",

	-- Step 14: Morin Cloudstalker
	-- {quest:98427} Ceasing Operations · {quest:98424} Fizsprocket's Notes
	["{quest:98427}, +150: needs {quest:98424}"] = "{quest:98427}，+150：需要{quest:98424}",

	-- Step 15: The Venture Co. Mine: the Clearcutter
	-- {area:360} The Venture Co. Mine
	["{area:360}: the Clearcutter"] = "{area:360}：清伐者",
	-- {quest:98427} Ceasing Operations
	["The elite shredder Venture Co. Clearcutter works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "精英風險投資公司清伐者在礦洞深處作業，就在菲茲斯普羅基特原先待的位置再往裡：它的鑰匙是給{quest:98427}的。",

	-- Step 16: Bloodhoof Village: last hand-in
	-- {area:222} Bloodhoof Village
	["{area:222}: last hand-in"] = "{area:222}：最後交任務",
	-- {quest:99082} The High Chieftain · {npc:3057} Cairne Bloodhoof · {faction:81} Thunder Bluff
	["{quest:99082}, +10: to {npc:3057} in {faction:81}"] = "{quest:99082}，+10：交給{faction:81}的{npc:3057}",

	-- Step 18: Gloomrise (optional hub)
	-- {area:17044} Gloomrise
	["{area:17044} (optional hub)"] = "{area:17044}（可選任務點）",
	-- {area:17045} Skywatcher Plateau · {faction:81} Thunder Bluff · {zone:1454} Orgrimmar · {npc:259118} Muln Earthfury · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem
	["Forever pays these old quests in full at any level. The Earthen Ring camp on the {area:17045}, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes, plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "Forever 裡這些舊任務任何等級都足額給分。{faction:81}西北{area:17045}上的大地之環營地：20分鐘300點{faction:81}聲望，另外各100點給{zone:1454}和暗矛巨魔，還有450點大地之環。{npc:259118}、{npc:264074}和{npc:264072}站在營地裡。",
	-- {npc:259118} Muln Earthfury · {quest:96259} Defending the Dead · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96259}, +100 ({quest:96261} comes once it is handed in)"] = "{npc:259118}：{quest:96259}，+100（交還後可接{quest:96261}）",
	-- {npc:264074} Mazu'kon · {quest:96241} Talkin' bout Toxins, Mon
	["{npc:264074}: {quest:96241} (Darkspear +100)"] = "{npc:264074}：{quest:96241}（暗矛 +100）",

	-- Step 19: Gloomrise
	-- {area:17044} Gloomrise · {faction:81} Thunder Bluff · {item:273015} Toxin Extractor · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["{area:17044} is the tauren burial ground north of {faction:81}. Use the {item:273015} on the Gnawed Corpses. {npc:264082} waits at the heart of it; her body carries a {item:273658}: read it to start {quest:96294}."] = "{area:17044}是{faction:81}以北的牛頭人墓地。對被啃噬過的屍體使用{item:273015}。{npc:264082}在墓地中心等你；她的屍體上帶著一封{item:273658}：閱讀它來開啟{quest:96294}。",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}，來自{npc:264081}",

	-- Step 20: The Skywatcher camp: hand in
	["The Skywatcher camp: hand in"] = "觀天者營地：交任務",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "交還{quest:96259}後，{npc:259118}才會提供{quest:96261}。",

	-- Step 21: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx · {area:17044} Gloomrise
	["{npc:264082}, at the heart of {area:17044}"] = "{npc:264082}，在{area:17044}中心",

	-- Step 23: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14728} offers the {item:14047} donation, and {quest:7825} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "從這裡開始就是捐布了。毛料、絲綢和魔紋布都要先各捐過一次，{npc:14728}才會提供{item:14047}的捐贈，而{quest:7825}需要{item:14047}。布料可以在拍賣行買，也可以自己刷：人形怪掉落，毛料出自15到25級，絲綢25到40級，魔紋布40到50級，{item:14047}出自50級以上。60級時刷52級以上的怪：等級更低的已經灰了。",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}：刺毛熊怪約每四次擊殺掉一個",

	-- Step 24: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "絲綢：{area:287}和奧特蘭克的辛迪加約每三次擊殺掉一個，或者直接買。",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}：辛迪加",

	-- Step 25: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "魔紋布：{zone:1448}南部的碧火薩特和{zone:1446}的砂槌食人魔約每三次擊殺掉一個，或者直接買。",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}：碧火薩特",

	-- Step 26: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}：{zone:1423}{area:2266}的血色十字軍、{zone:1444}{area:2577}外的戈多克食人魔和{zone:1451}的暮光營地約每三次擊殺掉一個。金幣夠的話拍賣行更快。",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}：{area:2266}外的血色十字軍",

	-- Step 27: Everlook: Storm Shadowhoof
	-- {npc:10303} Storm Shadowhoof · {faction:81} Thunder Bluff · {npc:10806} Ursius · {area:2255} Everlook
	["{npc:10303}'s four quests are level 56 to 60, so they pay in full: 400 {faction:81} reputation. {npc:10806}, an elite bear, walks a loop over the four hills north of {area:2255}: wait on a hilltop for him."] = "{npc:10303}的四個任務是56到60級，所以全額支付：400點{faction:81}聲望。{npc:10806}是一頭精英熊，在{area:2255}以北的四座山丘上繞圈：在山頭上等他。",
	-- {npc:10806} Ursius
	["{npc:10806}, elite"] = "{npc:10806}，精英",

	-- Step 28: Brumeran and Shy-Rotam
	-- {npc:10807} Brumeran · {quest:5056} Shy-Rotam
	["{npc:10807} and {quest:5056}"] = "{npc:10807}和{quest:5056}",
	-- {npc:10807} Brumeran · {area:2255} Everlook · {quest:5056} Shy-Rotam · {item:12733} Sacred Frostsaber Meat · {object:103819} Stone of Shy-Rotam (no name in this language: may be words) · {npc:10306} Trull Failbane · {zone:1454} Orgrimmar · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets · {faction:81} Thunder Bluff
	["{npc:10807}, an elite chimera, spawns south of {area:2255}. For {quest:5056}, kill frostsabers north of {area:2255} until one drops {item:12733} (about one in ten), then use the meat at the {object:103819}, far to the north, and kill the great cat that comes. If you have done {npc:10306}'s Wild Guardians quests (the {zone:1454} guide), the Crazed, Moontouched and Berserk owlbeasts around {area:2255} sometimes drop a {item:12558}: it starts {quest:4882}, 50 {zone:1454} and then 100 {faction:81} reputation in full."] = "{npc:10807}是一隻精英雙頭奇美拉，在{area:2255}以南重新整理。做{quest:5056}要在{area:2255}以北殺霜刃豹，直到掉出{item:12733}（約每十隻一個），然後在遙遠的北方{object:103819}處使用這塊肉，殺掉聞味而來的大貓。如果你做過{npc:10306}的野性守衛系列任務（見{zone:1454}攻略），{area:2255}周圍的瘋狂、月觸和狂暴梟獸偶爾會掉{item:12558}：它開啟{quest:4882}，全額給50點{zone:1454}以及之後的100點{faction:81}聲望。",
	-- {npc:10807} Brumeran
	["{npc:10807}, elite"] = "{npc:10807}，精英",
	-- {item:12733} Sacred Frostsaber Meat
	["{item:12733}, from the frostsabers"] = "{item:12733}，出自霜刃豹",

	-- Step 29: Bloodvenom Post: Trull Failbane
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring
	["{npc:10306} stands at {area:1997}, through the Timbermaw tunnel south of {zone:1452}."] = "{npc:10306}站在{area:1997}，穿過{zone:1452}南邊的木喉隧道即到。",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {faction:81} Thunder Bluff
	["{quest:4882}, +100: to {npc:5770} in {faction:81}"] = "{quest:4882}，+100：交給{faction:81}的{npc:5770}",

	-- Step 30: Thunder Bluff: Nara Wildmane
	-- {npc:5770} Nara Wildmane · {area:1639} Elder Rise · {npc:5769} Arch Druid Hamuul Runetotem
	["{npc:5770} stands on {area:1639}, beside {npc:5769}."] = "{npc:5770}站在{area:1639}上，就在{npc:5769}旁邊。",

	-- Step 31: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040}（可選）",
	-- {quest:3804} Morrowgrain to Thunder Bluff · {item:11040} Morrowgrain · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {npc:6746} Innkeeper Pala · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{quest:3804} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60, but it is slow: the {item:11020} grows one casing every 10 minutes and a casing holds about one {item:11040} on average, so each hand-in takes about 90 minutes of waiting, 18 {quest:3761} and 9 seed packets (90 silver). It runs beside whatever else you do: a little over 30 reputation an hour. The chain before it is level 50. {npc:6746} sends you to {npc:5769} on {area:1639}; he wants 20 {quest:3761}."] = "",

	-- Step 32: Un'Goro Crater: Un'Goro Soil
	-- {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Nearly every beast, plant and silithid in the crater drops {quest:3761}, about one kill in three (the Bloodpetals and the Gorishi wasps about one in two), and the dirt mounds give it too. Take far more than 20: every casing uses 2, about 18 for each {item:11040} hand-in."] = "環形山裡幾乎每種野獸、植物和異種蟲都會掉{quest:3761}，約每三次擊殺掉一個（血瓣花和格里什蜂約每兩次掉一個），土堆也會出。拿的遠多過20個：每個外殼要消耗2個，每次上繳{item:11040}約要18個。",

	-- Step 33: Thunder Bluff: Morrowgrain Research
	-- {npc:9076} Ghede · {npc:9087} Bashana Runetotem · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9076} takes the soil. {npc:9087} sells the {item:11020} (1 gold) and Packets of Tharlendris Seeds (10 silver each). With a seed packet and 2 {quest:3761} in your bags, use the pouch: it grows an {item:11024}, once every 10 minutes. Open each casing: about one in three holds 1 to 5 {item:11040}, the rest common herbs. Use the pouch whenever it is ready while you follow the rest of this guide."] = "{npc:9076}收土壤。{npc:9087}出售{item:11020}（1金）和薩倫迪斯種子包（每個10銀）。揹包裡有種子包和2個{quest:3761}時使用袋子：它會培育出一個{item:11024}，每10分鐘一次。開啟每個外殼：約三分之一裝有1到5個{item:11040}，其餘是普通草藥。在跟隨本攻略餘下步驟的過程中，袋子一冷卻好就用。",
	-- {item:11020} Evergreen Pouch
	["{item:11020}, 1 gold"] = "{item:11020}，1金",
	-- {item:11022} Packet of Tharlendris Seeds
	["{item:11022}, 10 silver each"] = "{item:11022}，每個10銀",

	-- Step 34: Morrowgrain as you go
	-- {item:11040} Morrowgrain
	["{item:11040} as you go"] = "{item:11040}，邊做邊收",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}: use the pouch every 10 minutes and open the casings; {npc:9087} takes it"] = "{item:11040}：每10分鐘用一次袋子並開啟外殼；{npc:9087}收",

	-- Step 35: Bashana Runetotem: Morrowgrain Research
	-- {npc:9087} Bashana Runetotem · {area:1639} Elder Rise · {item:11040} Morrowgrain
	["{npc:9087} stands on {area:1639}. If your 10 {item:11040} are not ready yet, skip this step and go on with the cloth: the cloth steps below list the {item:11040} hand-in too."] = "{npc:9087}站在{area:1639}上。如果你的10個{item:11040}還沒湊齊，跳過這一步先去做捐布：下面的捐布步驟也會列出{item:11040}的上繳。",

	-- Step 36: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825}到尊敬",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth
	["{quest:7825}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a tauren starts at Friendly 1,000: 100 hand-ins; an Undead at Neutral 500 first needs 50 more to reach Friendly). Hand in every 20 you carry, one after another."] = "",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}, if you grow it: {npc:9087} takes it"] = "{item:11040}，如果你有培育：{npc:9087}收",

	-- Step 37: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825}到崇敬",
	-- {item:14047} Runecloth · {item:11040} Morrowgrain · {area:1584} Blackrock Depths · {area:340} Kargath · {npc:9017} Lord Incendius
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}, fewer if you also hand in {item:11040}. {area:1584} pays too: Disharmony of Flame and Disharmony of Fire from Thunderheart at {area:340} ({npc:9017}, 150 in full)."] = "尊敬到崇敬是12,000點：240次上繳，4,800個{item:14047}，如果同時上繳{item:11040}可以少一些。{area:1584}也給聲望：{area:340}雷霆之心給的不和諧之焰與不和之火（{npc:9017}，全額150點）。",
	-- {item:11040} Morrowgrain
	["{item:11040}, if you grow it"] = "{item:11040}，如果你有培育",

	-- Step 38: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825}到崇拜",
	-- {item:14047} Runecloth · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:3685} in {area:222} sells the kodos to every Horde race: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "崇敬到崇拜是21,000點：420次上繳，8,400個{item:14047}。“為了部落！”（雷德的頭顱）和“黑石之王”（奈法利安的頭顱）給每個部落主城200點。崇拜後，{area:222}的{npc:3685}把科多獸賣給每個部落種族：40級科多獸20金，60級巨型科多獸200金（Forever的價格）；經典舊世裡其他種族要崇拜才能購買。",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685}: the kodos"] = "{npc:3685}：科多獸",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "黑暗教徒和暗影法師（58-60級）在這裡會掉落；在這裡每擊殺一隻天譴軍團也會計入{object:92525}（見該指南）。拍賣場也買得到。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "砂槌巨魔（45-48級）在這裡會掉落。拍賣場也買得到。",
	-- ["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7825}，直到{faction:81}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "持續繳交{quest:7825}，每次20個{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "科卡爾半人馬（30-33級）在這裡會掉落。拍賣場也買得到。",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的風險投資公司執行者（16-17級）在這裡會掉落。拍賣場也買得到。",
	-- ["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728}在{faction:81}收取布料以提升{faction:81}聲望。毛料、絲綢、魔紋布和{item:14047}的首次捐獻（各60塊布）只能做一次，每塊布給的聲望最多；之後{quest:7825}可重複到崇拜。與其他種族主城崇拜後，可購買該種族的坐騎。Forever的傳承外交官天賦可提高聲望獲取。",
	-- ["{npc:14728}: {item:14047} delivered"] = "{npc:14728}：{item:14047}已交付",
	-- ["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825}每次繳交需要20個{item:14047}，可無限次重複。以20的倍數攜帶{item:14047}，一次全部連續繳交。{item:14047}：{zone:1423}的黑暗教徒和暗影法師（58-60級），或拍賣場。",
}
