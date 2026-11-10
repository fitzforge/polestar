-- Chinese (simplified) (zhCN): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "雷霆崖声望",
	-- {zone:1412} Mulgore · {zone:1452} Winterspring · {item:11040} Morrowgrain · {item:14047} Runecloth
	["{zone:1412} quests while you level, {zone:1452} quests and {item:11040} from 55, then {item:14047} to Exalted."] = "",
	-- {faction:81} Thunder Bluff
	["Exalted with {faction:81}"] = "{faction:81}崇拜",

	-- Step 1: Thunder Bluff: how it works
	-- {faction:81} Thunder Bluff
	["{faction:81}: how it works"] = "{faction:81}：规则说明",
	-- {faction:81} Thunder Bluff · {item:11040} Morrowgrain · {npc:14728} Rumstag Proudstrider · {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1412} Mulgore · {area:378} Camp Taurajo · {zone:1441} Thousand Needles
	["{faction:81} reputation comes from quests, {item:11040} and cloth. {npc:14728}, the cloth quartermaster, stands on the central rise among the leatherworkers' and tailors' tents. He takes four one-time donations of 60 cloth (150 each) and then {quest:7825}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:81} also gives a quarter as much to {zone:1454}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:81}'s quests within 5 levels of them: {zone:1412} at 1 to 12, {area:378} and the Crossroads at 13 to 22, {zone:1441} at 25 to 30. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Thunder Bluff's merchants sell to you for 10% less (the Classic rule), the kodo vendor included; at Exalted other races can buy the kodos: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60, once you have mount training. {faction:81} has no tabard or other reward."] = "{faction:81}声望来自任务、{item:11040}和布料。布匹军需官{npc:14728}站在中央高地的制皮与裁缝帐篷之间。他接收四种一次性捐赠，每种60块布（各150声望），之后可无限重复{quest:7825}，每20块{item:14047}换50声望。每获得一点{faction:81}声望，{zone:1454}、{zone:1458}和暗矛巨魔也会获得四分之一。练级时，应在与任务相差不超过5级时完成{faction:81}的任务：1至12级做{zone:1412}，13至22级做{area:378}和十字路口，25至30级做{zone:1441}。传承特长“外交家”最多增加10%。奖励：尊敬后，雷霆崖商人的售价降低10%（经典旧世规则），包括科多兽商人；崇拜后，其他种族也能购买科多兽：40级科多兽20金币，60级大型科多兽200金币，均需先接受坐骑训练。{faction:81}没有战袍或其他奖励。",

	-- Step 2: Camp Narache (optional hub)
	-- {area:221} Camp Narache
	["{area:221} (optional hub)"] = "{area:221}（可选任务点）",
	-- {area:221} Camp Narache · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2980} Grull Hawkwind · {npc:2981} Chief Hawkwind · {npc:3209} Brave Windfeather
	["Forever pays these old quests in full at any level. {area:221}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "",

	-- Step 3: Greatmother Hawkwind and the plains
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991} and the plains"] = "{npc:2991}和平原",
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991}'s tent is south-east of the camp; the water pitcher stands at the well beside it. Plainstriders graze all around."] = "{npc:2991} 的帐篷在营地东南面；水罐在旁边的水井处。陆行鸟在周围各处吃草。",

	-- Step 4: Camp Narache: hand in
	-- {area:221} Camp Narache
	["{area:221}: hand in"] = "{area:221}：交任务",

	-- Step 5: Seer Graytongue and the cougars
	-- {npc:2982} Seer Graytongue
	["{npc:2982} and the cougars"] = "{npc:2982} 与狮子",
	-- {npc:2982} Seer Graytongue
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:2982} sits on the hill south of the camp; the Mountain Cougars live in those hills."] = "{npc:2982} 坐在营地南边的山上；山狮生活在那些山丘中。",

	-- Step 6: Camp Narache: the Battleboars
	-- {area:221} Camp Narache
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["{area:221}: the Battleboars"] = "{area:221}：斗猪。",

	-- Step 7: Brambleblade Ravine
	-- {quest:780} The Battleboars · {npc:8554} Chief Sharptusk Thornmantle · {area:358} Brambleblade Ravine · {item:4851} Dirt-stained Map · {quest:781} Attack on Camp Narache
	["{quest:780} graze east of the camp; the Bristleback quilboar and {npc:8554} hold {area:358} beyond them. A {item:4851} lies in the ravine: reading it starts {quest:781}."] = "{quest:780} 在营地东侧觅食；更远处的 {area:358} 被刺背野猪人和 {npc:8554} 占据。峡谷里有一张 {item:4851}：阅读可开始 {quest:781}。",

	-- Step 8: Camp Narache: last hand-in
	-- {area:221} Camp Narache
	["{area:221}: last hand-in"] = "{area:221}：最后一次交任务",
	-- {quest:763} Rites of the Earthmother · {npc:2993} Baine Bloodhoof
	["{quest:763}, +75: to {npc:2993}"] = "{quest:763}，+75 点声望：交给 {npc:2993}",

	-- Step 10: Bloodhoof Village (optional hub)
	-- {area:222} Bloodhoof Village
	["{area:222} (optional hub)"] = "{area:222}（可选任务点）",
	-- {area:222} Bloodhoof Village · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2993} Baine Bloodhoof · {npc:2947} Harken Windtotem · {npc:2985} Ruul Eagletalon · {npc:3222} Brave Wildrunner · {npc:2988} Morin Cloudstalker
	["Forever pays these old quests in full at any level. {area:222} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes. {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "",

	-- Step 11: Eastern Mulgore
	-- {zone:1412} Mulgore
	["Eastern {zone:1412}"] = "{zone:1412} 东部",
	-- {quest:99079} Longwalker Malah · {object:2908} Sealed Supply Crate
	["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest."] = "",
	-- {object:2908} Sealed Supply Crate
	["the {object:2908}"] = "{object:2908}",

	-- Step 12: Bloodhoof Village: hand in
	-- {area:222} Bloodhoof Village
	["{area:222}: hand in"] = "{area:222}：交任务",

	-- Step 13: The mine, the centaurs and the plains
	["The mine, the centaurs and the plains"] = "矿洞、半人马与平原",
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes · {zone:1412} Mulgore
	-- plural, as words: Swoops = {npc:2970} Swoop
	["Back to the mine for the workers, supervisors and {quest:765} in the back: his {item:281031} start {quest:98424}, and its other pages lie inside the mine. The Galak centaurs and Herak camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "",
	-- {item:281031} Mulgore Expansion Plans · {quest:765} Supervisor Fizsprocket
	["{item:281031}, from {quest:765}"] = "",
	-- {item:281035} Shredder Operation Instructions
	["{item:281035}, inside the mine"] = "",

	-- Step 14: Morin Cloudstalker
	-- {quest:98427} Ceasing Operations · {quest:98424} Fizsprocket's Notes
	["{quest:98427}, +150: needs {quest:98424}"] = "",

	-- Step 15: The Venture Co. Mine: the Clearcutter
	-- {area:360} The Venture Co. Mine
	["{area:360}: the Clearcutter"] = "",
	-- {quest:98427} Ceasing Operations
	["The elite shredder Venture Co. Clearcutter works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "",

	-- Step 16: Bloodhoof Village: last hand-in
	-- {area:222} Bloodhoof Village
	["{area:222}: last hand-in"] = "{area:222}：最后一次交任务",
	-- {quest:99082} The High Chieftain · {npc:3057} Cairne Bloodhoof · {faction:81} Thunder Bluff
	["{quest:99082}, +10: to {npc:3057} in {faction:81}"] = "{quest:99082}，+10：交给 {faction:81} 的 {npc:3057}",

	-- Step 18: Gloomrise (optional hub)
	-- {area:17044} Gloomrise
	["{area:17044} (optional hub)"] = "{area:17044}（可选任务点）",
	-- {area:17045} Skywatcher Plateau · {faction:81} Thunder Bluff · {zone:1454} Orgrimmar · {npc:259118} Muln Earthfury · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem
	["Forever pays these old quests in full at any level. The Earthen Ring camp on the {area:17045}, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes, plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "",
	-- {npc:259118} Muln Earthfury · {quest:96259} Defending the Dead · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96259}, +100 ({quest:96261} comes once it is handed in)"] = "{npc:259118}：{quest:96259}，+100（交还后可接{quest:96261}）",
	-- {npc:264074} Mazu'kon · {quest:96241} Talkin' bout Toxins, Mon
	["{npc:264074}: {quest:96241} (Darkspear +100)"] = "{npc:264074}：{quest:96241}（暗矛+100）",

	-- Step 19: Gloomrise
	-- {area:17044} Gloomrise · {faction:81} Thunder Bluff · {item:273015} Toxin Extractor · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["{area:17044} is the tauren burial ground north of {faction:81}. Use the {item:273015} on the Gnawed Corpses. {npc:264082} waits at the heart of it; her body carries a {item:273658}: read it to start {quest:96294}."] = "{area:17044} 是 {faction:81} 北侧的牛头人墓地。对啃噬过的尸体使用 {item:273015}。{npc:264082} 在墓地中央等待；她的尸体上有一份 {item:273658}：阅读后可开始 {quest:96294}。",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}，从暮升织网者获取",

	-- Step 20: The Skywatcher camp: hand in
	["The Skywatcher camp: hand in"] = "观天者 营地：交还任务",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "交还{quest:96259}后，{npc:259118}才会提供{quest:96261}。",

	-- Step 21: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx · {area:17044} Gloomrise
	["{npc:264082}, at the heart of {area:17044}"] = "{npc:264082}，位于{area:17044}的中心",

	-- Step 23: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14728} offers the {item:14047} donation, and {quest:7825} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "接下来靠交布。必须先交完毛料、丝绸和魔纹布，{npc:14728}才会开放{item:14047}捐献，而{quest:7825}又要求先完成{item:14047}捐献。可在拍卖行买布，也可自行刷取：人型生物会掉落，15到25级掉毛料，25到40级掉丝绸，40到50级掉魔纹布，50级及以上掉{item:14047}。60级时刷52级或更高的怪物：更低的已是灰色。",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}：蓟皮熊怪约每击杀四只掉落一个",

	-- Step 24: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "丝绸：{area:287} 和奥特兰克的辛迪加约每三次击杀掉落一次，也可以购买。",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}：辛迪加",

	-- Step 25: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "魔纹布：{zone:1448} 南部的碧火萨特和 {zone:1446} 的砂槌食人魔大约每击杀三只掉落一次，也可以购买。",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}：碧火萨特",

	-- Step 26: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}：{zone:1423}的{area:2266}血色成员、{zone:1444}的{area:2577}外戈多克食人魔，以及{zone:1451}的暮光营地敌人，约每击杀3个掉落一次。若有金币，拍卖行更快。",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}：{area:2266} 外的血色十字军",

	-- Step 27: Everlook: Storm Shadowhoof
	-- {npc:10303} Storm Shadowhoof · {faction:81} Thunder Bluff · {npc:10806} Ursius · {area:2255} Everlook
	["{npc:10303}'s four quests are level 56 to 60, so they pay in full: 400 {faction:81} reputation. {npc:10806}, an elite bear, walks a loop over the four hills north of {area:2255}: wait on a hilltop for him."] = "{npc:10303} 的四个任务为 56 至 60 级，因此提供全额奖励：共 400 点 {faction:81} 声望。{npc:10806} 是一只精英熊，会绕着 {area:2255} 北侧的四座山丘巡游：在山顶等它。",
	-- {npc:10806} Ursius
	["{npc:10806}, elite"] = "{npc:10806}，精英",

	-- Step 28: Brumeran and Shy-Rotam
	-- {npc:10807} Brumeran · {quest:5056} Shy-Rotam
	["{npc:10807} and {quest:5056}"] = "{npc:10807}和{quest:5056}",
	-- {npc:10807} Brumeran · {area:2255} Everlook · {quest:5056} Shy-Rotam · {item:12733} Sacred Frostsaber Meat · {object:103819} Stone of Shy-Rotam (no name in this language: may be words) · {npc:10306} Trull Failbane · {zone:1454} Orgrimmar · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets · {faction:81} Thunder Bluff
	["{npc:10807}, an elite chimera, spawns south of {area:2255}. For {quest:5056}, kill frostsabers north of {area:2255} until one drops {item:12733} (about one in ten), then use the meat at the {object:103819}, far to the north, and kill the great cat that comes. If you have done {npc:10306}'s Wild Guardians quests (the {zone:1454} guide), the Crazed, Moontouched and Berserk owlbeasts around {area:2255} sometimes drop a {item:12558}: it starts {quest:4882}, 50 {zone:1454} and then 100 {faction:81} reputation in full."] = "精英奇美拉{npc:10807}出现在{area:2255}南面。做{quest:5056}时，在{area:2255}北面击杀霜刃豹，直到掉落{item:12733}（约十分之一概率），然后在最北面的{object:103819}使用肉，击杀出现的巨型猫科野兽。如果已完成{npc:10306}的“冬泉谷的枭兽”任务（{zone:1454}指南），{area:2255}周围的狂乱、月光和狂暴枭兽有时会掉落{item:12558}：它触发{quest:4882}，先奖励50点{zone:1454}声望，再奖励100点{faction:81}声望，均为全额。",
	-- {npc:10807} Brumeran
	["{npc:10807}, elite"] = "{npc:10807}，精英",
	-- {item:12733} Sacred Frostsaber Meat
	["{item:12733}, from the frostsabers"] = "{item:12733}，来自霜刃豹。",

	-- Step 29: Bloodvenom Post: Trull Failbane
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring
	["{npc:10306} stands at {area:1997}, through the Timbermaw tunnel south of {zone:1452}."] = "{npc:10306} 站在 {area:1997}，穿过 {zone:1452} 南边的木喉隧道即可到达。",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {faction:81} Thunder Bluff
	["{quest:4882}, +100: to {npc:5770} in {faction:81}"] = "{quest:4882}，+100：交给{faction:81}的{npc:5770}",

	-- Step 30: Thunder Bluff: Nara Wildmane
	-- {npc:5770} Nara Wildmane · {area:1639} Elder Rise · {npc:5769} Arch Druid Hamuul Runetotem
	["{npc:5770} stands on {area:1639}, beside {npc:5769}."] = "{npc:5770} 站在 {area:1639}，位于 {npc:5769} 身旁。",

	-- Step 31: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040}（可选）",
	-- {quest:3804} Morrowgrain to Thunder Bluff · {item:11040} Morrowgrain · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {npc:6746} Innkeeper Pala · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{quest:3804} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60, but it is slow: the {item:11020} grows one casing every 10 minutes and a casing holds about one {item:11040} on average, so each hand-in takes about 90 minutes of waiting, 18 {quest:3761} and 9 seed packets (90 silver). It runs beside whatever else you do: a little over 30 reputation an hour. The chain before it is level 50. {npc:6746} sends you to {npc:5769} on {area:1639}; he wants 20 {quest:3761}."] = "",

	-- Step 32: Un'Goro Crater: Un'Goro Soil
	-- {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Nearly every beast, plant and silithid in the crater drops {quest:3761}, about one kill in three (the Bloodpetals and the Gorishi wasps about one in two), and the dirt mounds give it too. Take far more than 20: every casing uses 2, about 18 for each {item:11040} hand-in."] = "环形山里几乎所有野兽、植物和异种虫都会掉落{quest:3761}，约三只出一个（血瓣花和格里什飞虫约两只出一个），土堆也会提供。不要只拿20个，要多拿很多：每个壳消耗2个，每次交还{item:11040}约消耗18个。",

	-- Step 33: Thunder Bluff: Morrowgrain Research
	-- {npc:9076} Ghede · {npc:9087} Bashana Runetotem · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9076} takes the soil. {npc:9087} sells the {item:11020} (1 gold) and Packets of Tharlendris Seeds (10 silver each). With a seed packet and 2 {quest:3761} in your bags, use the pouch: it grows an {item:11024}, once every 10 minutes. Open each casing: about one in three holds 1 to 5 {item:11040}, the rest common herbs. Use the pouch whenever it is ready while you follow the rest of this guide."] = "{npc:9076} 接受泥土。{npc:9087} 出售 {item:11020}（1金币）和萨伦迪斯种子包（每包10银币）。背包中有一包种子和2份 {quest:3761} 时，使用袋子：会长出一个 {item:11024}，每10分钟可用一次。打开每个外壳：约三分之一会装有1到5份 {item:11040}，其余则是普通草药。继续按本指南行动时，只要袋子冷却完成就使用。",
	-- {item:11020} Evergreen Pouch
	["{item:11020}, 1 gold"] = "{item:11020}，1 金",
	-- {item:11022} Packet of Tharlendris Seeds
	["{item:11022}, 10 silver each"] = "{item:11022}，每个10银",

	-- Step 34: Morrowgrain as you go
	-- {item:11040} Morrowgrain
	["{item:11040} as you go"] = "沿途收集 {item:11040}",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}: use the pouch every 10 minutes and open the casings; {npc:9087} takes it"] = "{item:11040}：每10分钟使用一次袋子，并打开外壳；交给{npc:9087}",

	-- Step 35: Bashana Runetotem: Morrowgrain Research
	-- {npc:9087} Bashana Runetotem · {area:1639} Elder Rise · {item:11040} Morrowgrain
	["{npc:9087} stands on {area:1639}. If your 10 {item:11040} are not ready yet, skip this step and go on with the cloth: the cloth steps below list the {item:11040} hand-in too."] = "{npc:9087} 站在 {area:1639}。如果还没准备好10份 {item:11040}，跳过此步骤，继续交布：下面的布料步骤也列出了 {item:11040} 的交还。",

	-- Step 36: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825}刷到尊敬",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth
	["{quest:7825}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a tauren starts at Friendly 1,000: 100 hand-ins; an Undead at Neutral 500 first needs 50 more to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7825}：每 20 个 {item:14047} 换取 50 点声望，可以无限重复。从友善到尊敬需要 6,000 点：交还 120 次，共 2,400 个 {item:14047}，再扣除任务已提供的声望（牛头人起始为友善 1,000 点：需交还 100 次；亡灵起始为中立 500 点，先额外交还 50 次才能达到友善）。把身上每 20 个作为一组，逐次交还。",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}, if you grow it: {npc:9087} takes it"] = "{item:11040}，如果你有种：{npc:9087}会收取",

	-- Step 37: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825}刷到崇敬",
	-- {item:14047} Runecloth · {item:11040} Morrowgrain · {area:1584} Blackrock Depths · {area:340} Kargath · {npc:9017} Lord Incendius
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}, fewer if you also hand in {item:11040}. {area:1584} pays too: Disharmony of Flame and Disharmony of Fire from Thunderheart at {area:340} ({npc:9017}, 150 in full)."] = "从尊敬到崇敬需要12,000点：交还240次，共4,800块 {item:14047}；如果也交还 {item:11040}，则会更少。{area:1584} 也能提供声望：{area:340} 的桑德哈特提供“不和谐的烈焰”和“不和谐的火焰”（{npc:9017}，全额150点）。",
	-- {item:11040} Morrowgrain
	["{item:11040}, if you grow it"] = "{item:11040}，如果你自己种植。",

	-- Step 38: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825}刷到崇拜",
	-- {item:14047} Runecloth · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:3685} in {area:222} sells the kodos to every Horde race: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "从崇敬到崇拜需要 21,000 点：交还 420 次，共 8,400 个 {item:14047}。“为部落而战！”（雷德的头颅）和“黑石之王”（奈法利安的头颅）各向所有部落城市提供 200 点。崇拜后，{area:222} 的 {npc:3685} 会向所有部落种族出售科多兽：40 级科多兽 20 金币，60 级大型科多兽 200 金币（无限的价格）；经典旧世中，其他种族需要崇拜才能购买。",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685}: the kodos"] = "{npc:3685}：科多兽。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the mine for the workers, supervisors and {quest:765}. The Galak centaurs and {npc:275767} camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "回到矿洞对付劳工、监督者并完成 {quest:765}。加拉克半人马和 {npc:275767} 扎营在村庄东边。猛鹫在 {zone:1412} 各处飞翔；风怒鹰身人在村庄东南方栖息；白鬃豺狼人则在村庄西边扎营。",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "这里的黑暗教徒和暗影法师（58-60级）会掉落；在这里击杀天灾军团也会提升{object:92525}声望（见该指南）。也可以去拍卖行购买。",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "这里的砂槌食人魔（45-48级）会掉落。也可以去拍卖行购买。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The Earthen Ring camp on the {area:17045}, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes (60 at a fifth), plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "在经典旧世中，低于你6级及以上的任务奖励会减少（60级时为五分之一）；一份无限服测试版反馈称仍获得全额。第一次交还就能看出实际情况：如果只有五分之一，跳过这些任务据点。{faction:81} 西北面 {area:17045} 的大地之环营地：20分钟可得300点 {faction:81} 声望（按五分之一则为60），另有 {zone:1454} 和暗矛巨魔各100点，以及大地之环450点。{npc:259118}、{npc:264074} 和 {npc:264072} 站在营地里。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:221}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes (220 at a fifth). Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "在经典旧世中，比你低至少 6 级的任务声望奖励会减少（60 级时降至五分之一）；一份无限测试版报告称，任务仍提供全额声望。第一次交还任务时就能看出：如果只给五分之一，就跳过这些任务点。{zone:1412} 最南端的 {area:221}：25 分钟约提供 1,100 点 {faction:81} 声望（按五分之一计算为 220 点）。起始地区任务不会向其他城市提供共享声望。{npc:2980} 和 {npc:2981} 站在营地中，{npc:3209} 在营地边缘。",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:222} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes (200 at a fifth). {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "经典旧世中，比你低至少6级的任务奖励会减少（60级时为五分之一）；一份无限测试版报告称其奖励全额声望。第一次交还任务即可确认：若只有五分之一，就跳过这些任务区。{area:222}和{zone:1412}东部：约45分钟可获得1,000点{faction:81}声望（五分之一时为200）。{npc:2993}站在村子中央；{npc:2947}、{npc:2985}和{npc:3222}就在附近；{npc:2988}在村子东面的路旁等候。",
	-- ["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7825}，直到{faction:81}崇拜。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "继续交还{quest:7825}，每次20块{item:14047}。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "这里的科卡尔半人马（30-33级）会掉落。也可以去拍卖行购买。",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "{area:381}的风险投资公司执行者（16-17级）会掉落。也可以去拍卖行购买。",
	-- ["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728}在{faction:81}收取布料以提升{faction:81}声望。首次捐献毛料、丝绸、魔纹布和{item:14047}（各60块）只能做一次，每块布给的声望最多；之后{quest:7825}可重复做到崇拜。与其他种族的主城达到崇拜后，可购买该种族的坐骑。Forever的传承外交官特权可提高声望获取。",
	-- ["{npc:14728}: {item:14047} delivered"] = "{npc:14728}：已交付{item:14047}",
	-- ["{quest:3804} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60, but it is slow: the {item:11020} grows one casing every 10 minutes and a casing holds about one {item:11040} on average, so each hand-in takes about 90 minutes of waiting, 18 {quest:3761} and 9 seed packets (90 silver). It runs beside whatever else you do: a little over 30 reputation an hour. The chain before it is level 50 (in Classic a fifth at 60). {npc:6746} sends you to {npc:5769} on {area:1639}; he wants 20 {quest:3761}."] = "{quest:3804} 每次用 10 个 {item:11040} 换 50 点声望，可以无限重复，60 级时仍提供全额奖励，但速度很慢：{item:11020} 每 10 分钟长出一个果荚，每个果荚平均含约一个 {item:11040}，因此每次交还约需等待 90 分钟、消耗 18 个 {quest:3761} 和 9 包种子（90 银）。可以一边做其他事一边种：每小时略多于 30 点声望。前置任务链为 50 级（经典旧世中 60 级时只有五分之一奖励）。{npc:6746} 会让你去找 {area:1639} 的 {npc:5769}；他需要 20 个 {quest:3761}。",
	-- ["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825}每次交还需要20块{item:14047}，可无限重复。按20的倍数带上{item:14047}，一次接一次全部交还。{item:14047}：{zone:1423}的黑暗教徒和暗影法师（58-60级），或拍卖行。",
	-- ["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest. {quest:764} mine is further north-east; the elite shredder Venture Co. Clearcutter works deep inside."] = "{quest:99079}在东部边界旁等候。被劫掠商队的{object:2908}在村庄东北方：打开后开启后续任务。{quest:764}矿洞在更远的东北方；风险投资公司的精英伐木机在深处作业。",
	-- ["{zone:1452}'s level 56-60 quests, {item:11040} and {item:14047} to Exalted, with {zone:1412}'s old quests as an optional extra."] = "{zone:1452}的56-60级任务，加上{item:11040}和{item:14047}刷到崇拜；{zone:1412}的旧任务可选做。",
}
