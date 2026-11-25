-- Chinese (simplified) (zhCN): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1445} Dustwallow Marsh · {zone:1434} Stranglethorn Vale · {zone:1435} Swamp of Sorrows
	["{zone:1445} first, then {zone:1434} and the {zone:1435}."] = "先去{zone:1445}，再去{zone:1434}和{zone:1435}。",

	-- Step 1: Theramore
	["Theramore"] = "塞拉摩",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260}站在旅店附近；往南几步的商人{npc:4897}出售加尔要的香料。",
	-- {quest:1260} Morgan Stern
	["{quest:1260}, inside"] = "{quest:1260}：在屋内",
	-- {npc:4964} Commander Samaul · {area:514} Foothold Citadel
	["{npc:4964}, on the top floor of {area:514}"] = "{npc:4964}，在{area:514}顶层",
	-- {npc:271167} Guard Jameson · {quest:98233} Sword in the Slime
	["{npc:271167}: {quest:98233}, from the oozes on the way back east"] = "{npc:271167}：{quest:98233}，在向东返回途中击杀软泥怪",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}，交给“沼泽之眼”加尔",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point · {quest:1265} The Missing Diplomat · {npc:4967} Archmage Tervosh
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	-- was: ["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it.\n{npc:4967} waits at the foot of the tower: once you have looked around, hand the quest in to him there, not in Theramore."] = "沿道路向西北离开塞拉摩，前往{area:503}的瞭望塔。泥石穴居龟在周围的沼泽中游荡。\n{npc:4967}在塔脚下等候：四处查看后，直接在那里向他交任务，不用回塞拉摩。"
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it.\nIf {quest:1265} isn't done yet: {npc:4967} waits at the foot of the tower once you have looked around. Hand the quest in to him there, not in Theramore, and take his next errand on the spot."] = "",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, at the tower"] = "{npc:4967}，在塔旁",

	-- Step 3: Swamplight Manor
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house. Jarl wants three {quest:1218}: if you passed {npc:4897}, buy them from her in Theramore first."] = "沿道路向北前往废弃的庄园；加尔住在旁边的棚屋里，松土就在房子的拐角处。加尔需要三份{quest:1218}：如果之前错过了{npc:4897}，先去塞拉摩找她购买。",
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["{quest:1218}: {npc:4897} in Theramore, if you left without them"] = "{quest:1218}：如果离开时没买，找塞拉摩岛的{npc:4897}",
	["with the spices from Theramore"] = "带上从塞拉摩买的香料",

	-- Step 4: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "伊格纳兹",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "伊格纳兹在庄园西边、{area:504}下方的沼泽中等候。带他去找睡菜叶，别让沼泽生物靠近他。",

	-- Step 5: North Point Tower
	-- {npc:4966} Private Hendel · {npc:4967} Archmage Tervosh · {npc:4968} Lady Jaina Proudmoore
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders.\n{npc:4967} and {npc:4968} wait beside the tower: once he yields, hand in to both on the spot."] = "{npc:4966}和几名逃兵占据高塔。他会转为敌对，攻击他直到投降。\n注意：亨德尔下士转为敌对时，两名守卫也会参战；他投降后，守卫会逃跑。\n{npc:4967}和{npc:4968}在塔旁等候：他投降后，当场向两人交任务。",

	-- Step 6: Darkmist Cavern
	-- plural, as words: Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "暗雾蜘蛛在沼泽西北侧洞穴周围筑巢，所有蜘蛛都会掉落眼球。\n注意：暗雾潜伏者会潜行移动，并在战斗中施毒。蜘蛛分布密集，容易引来其他敌人，可从外围逐个拉怪。",

	-- Step 7: Mudcrush Durtfeet
	["Head south to the giant's hut in the middle of the marsh."] = "向南前往沼泽中央巨人的小屋。",

	-- Step 8: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes."] = "烧毁的旅店在向西通往{zone:1413}的路上；卫兵的徽章在灰烬中。",

	-- Step 9: Corrosive Swamp Oozes
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze
	["Corrosive Swamp Oozes"] = "腐蚀性的沼泽软泥怪",
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze · Elder Daggermaws = {npc:272384} Elder Daggermaw · Bubbling Swamp Oozes = {npc:4394} Bubbling Swamp Ooze
	["On the way back east, the Corrosive Swamp Oozes (38-40) creep through the marsh south of the road, between the middle of the marsh and Theramore: one of them carries Jameson's training sword. Careful: Elder Daggermaws (48-49) lurk in the water among them, and the larger Bubbling Swamp Oozes (39-40) are elite: leave both alone."] = "向东返回途中，腐蚀性的沼泽软泥怪（38-40级）在道路南边的沼泽里蠕动，位于沼泽中央和塞拉摩岛之间：其中一只带着詹姆森的训练剑。小心：年迈的匕喉鳄（48-49级）潜伏在它们之间的水中，体型更大的起泡的沼泽软泥怪（39-40级）是精英：两者都别碰。",

	-- Step 10: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. The officers are in {area:514}."] = "沿道路向东返回塞拉摩。军官们在{area:514}里。",
	["On the top floor"] = "在最顶层",
	-- {npc:4948} Adjutant Tesoran
	["{npc:4948}, on the top floor"] = "{npc:4948}，位于最顶层",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}：在屋内",
	-- {npc:4794} Morgan Stern · {zone:1435} Swamp of Sorrows
	["{npc:4794}: the crawlers are on the {zone:1435} shore, keep it"] = "{npc:4794}：螃蟹在{zone:1435}岸边，先留着任务",

	-- Step 11: Mirefin murlocs
	["Mirefin murlocs"] = "黑鳍鱼人",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}."] = "黑鳍鱼人聚集在{area:497}以外的北部海岸。",

	-- Step 12: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "仅当你携带{item:3853}（铁匠制造品）时",

	-- Step 14: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "逃兵在道路南边、{npc:4503}小屋西边扎营。",

	-- Step 15: Foothold Citadel
	-- {npc:4944} Captain Garran Vimes · {area:514} Foothold Citadel
	["Back east along the road to Theramore: {npc:4944} takes the deserters' news on the top floor of {area:514}, and the flight master stands by its gate."] = "",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}，位于最顶层",

	-- Step 16: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飞往{area:392}",
	["Theramore flight master"] = "塞拉摩飞行管理员",

	-- Step 18: Fly to Ratchet
	-- {npc:6236} Klannoc Macleod · {area:720} Fray Island · {area:392} Ratchet · {area:150} Menethil Harbor
	["{npc:6236}'s Affray first: {area:720} lies just south of {area:392}. The boat to {area:150} leaves from Theramore afterwards."] = "",

	-- Step 20: The Affray
	-- {area:720} Fray Island · {area:391} Merchant Coast · {area:392} Ratchet · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	-- was: ["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "向北骑往{area:392}的路上，{area:720}位于镇子南边的{area:391}近海：涉水穿过沙洲浅滩。{npc:6236}会让四名挑战者和{npc:6238}（33级）依次与你交战。"
	["{area:720} lies off the {area:391} just south of {area:392}: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "击败挑战者和{npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236}接下来提供“捕风者”（1791）：旋风武器任务线最后有一个精英，见战士职业指南“旋风武器”。",

	-- Step 21: Fly to Theramore
	["Fly to Theramore"] = "飞往塞拉摩岛",
	-- {area:150} Menethil Harbor
	["Back to Theramore for the boat to {area:150}."] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 22: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "乘船前往{area:150}",

	-- Step 23: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飞往{zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "{area:150}的飞行管理员",

	-- Step 25: Riding at 40
	["Riding at 40"] = "40级骑术",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:4732}在{zone:1429}东部的{area:88}教授人类，旁边是{npc:384}的马。无限服可能允许任何种族向任何骑术训练师学习（未确认）。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}：其他颜色，20金",

	-- Step 26: Riding at 40
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:279} Dalaran
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. Skyborne learn it from {npc:265756}, the stablemaster and riding trainer at the {area:17684} in {area:16638} on Zephras Isle, who also sells the Galestriders: the skyboat to the isle leaves the north side of {area:279} about every five minutes. Collectibles, Mounts · Level 40 lists the Galestriders."] = "达到 40 级并准备 100 金即可学习骑术，学习时会获得坐骑。天裔可向{npc:265756}学习；这名兽栏管理员兼骑术训练师位于泽风岛的{area:16638}，在{area:17684}处，同时出售疾风陆行鸟。前往岛屿的飞空艇约每五分钟从{area:279}北侧出发。在“收集→坐骑·40 级”可查看疾风陆行鸟。",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "骑术和疾风陆行鸟：找泽风岛上{area:16638}的{area:17684}处的{npc:265756}。",
	-- {area:279} Dalaran
	["Skyboat to Zephras Isle: the north side of {area:279}, about every five minutes."] = "前往泽风岛的飞空艇：约每五分钟从{area:279}北侧出发。",

	-- Step 27: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "乘船前往{area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet · {zone:1413} Barrens
	["The boat to {area:35} leaves from {area:392}'s dock, below the flight master. Without the {area:392} flight path: follow the road west out of the marsh into the {zone:1413} and north up the coast to {area:392}, and learn it there."] = "",

	-- Step 28: Boat to Booty Bay
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["Level 40 with 100 gold later on? {npc:4732} teaches riding at {area:88} in {zone:1429}: Collectibles, Mounts · Level 40 has the trip."] = "之后到了40级、有100金？{npc:4732}在{zone:1429}的{area:88}教授骑术：收藏品“坐骑 · 40级”有这趟行程。",

	-- Step 30: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飞往{area:35}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "{area:42}的飞行管理员",

	-- Step 31: Booty Bay
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}：在楼上",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "交给{area:99}的{npc:770}，在北部环线上",
	-- {npc:2494} Privateer Bloads · {area:35} Booty Bay
	["{npc:2494}' Akiris by the Bundle waits for the level-48 {area:35} stop (its naga are 43-44): leave it for now."] = "{npc:2494}的「一捆海蛇草」暂缓，等48级回{area:35}时再做（任务要打的纳迦是43–44级）。",
	-- {npc:2487} Fleet Master Seahorn · {quest:669} Sunken Treasure · {area:327} Faldir's Cove
	["{npc:2487}, top floor: {quest:669}, if you did {area:327} with a group"] = "{npc:2487}，顶层：{quest:669}，如果你和小队完成了{area:327}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the Skullsplitter trolls, on the northern loop"] = "楼上的{npc:737}：劈颅巨魔，在北部环线再做",
	-- {npc:737} Kebok · {area:37} Lake Nazferiti
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals, at {area:37} on the northern loop"] = "{npc:737}。走北线时到{area:37}收集打磨过的水晶。",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}'s Zanzil's Secret waits for the same stop (Zanzil's village is 43-44): leave it for now."] = "{npc:2498}的「赞吉尔的秘密」也留到那次再做。赞吉尔的村子里是43–44级的怪。",
	["Seahorn's next errand goes back to Arathi: skip it."] = "海角的下一个差事要回阿拉希：跳过。",

	-- Step 32: Kebok
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["Already have all eight Tumbled Crystals? Hand them to {npc:737} now."] = "已经集齐8块打磨过的水晶？现在就交给{npc:737}。",

	-- Step 33: Booty Bay
	-- {npc:2542} Catelyn the Blade
	["{npc:2542}, upstairs"] = "{npc:2542}：在楼上",
	["Upstairs"] = "在楼上",

	-- Step 34: Bloodsail camp
	["Bloodsail camp"] = "血帆营地",
	-- plural, as words: Bloodsail Mages = {npc:1562} Bloodsail Mage
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks.\nCareful: the Bloodsail Mages and Warlocks here are level 40-43 and cast from range: pull one at a time and fight with your back to the open beach."] = "从隧道出城，沿海岸向北；信在沙滩上的血帆营地里，帅小伙子邓肯在那里走动。\n小心：这里的血帆法师和血帆术士是40-43级，会远程施法：一次引一个，背对开阔的沙滩作战。",

	-- Step 35: Booty Bay
	-- {quest:597} The Bloodsail Buccaneers · {area:35} Booty Bay · {area:43} Wild Shore
	["Seahorn's next task, {quest:597}, waits for the level-48 {area:35} stop with the {area:43} camp (41-43): leave it for now."] = "舰队指挥官卡拉·海角的后续任务{quest:597}暂缓，等48级回{area:35}并前往{area:43}营地时再做（营地的怪是41–43级）。",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}，位于最顶层",
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624}在西北海岸外游动，在北部环线上",

	-- Step 36: Booty Bay
	["You missed this on the route's earlier visit here: take it now, before the Bloodsail camp. Its gorillas live on the hills just above the camp."] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "“海狼”马克基雷，位于最顶层",

	-- Step 37: Bloodsail pirates: kill these as you meet them
	["Bloodsail pirates: kill these as you meet them"] = "血帆海盗：沿途击杀以下目标",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	-- was: ["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye: take them from the Raiders and Mages (39-41) at the Bloodsail camp on the beach just north of town, where you found the letter. Leave the {area:43} camp south of town (Warlocks and Swashbucklers 41-43) for the level-48 visit."] = "每个血帆海盗都会掉落鼻烟，其中一个带着{npc:2493}的眼睛：去镇子北边不远的沙滩血帆营地（就是找到信的地方），从血帆袭击者和血帆法师（39-41级）身上获取。镇子南边的{area:43}营地（术士和暴徒，41-43级）留到48级再去。"
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye: take them from the Raiders and Mages (39-41) at the Bloodsail camp on the beach just north of town, where you found the letter. Leave the {area:43} camp south of town (Warlocks and Swashbucklers 41-43) for the level-48 visit.\nCareful: Rippa (44, a rare crocolisk) swims the shore beside the camp: stay out of the water."] = "",

	-- Step 38: Gorilla hills
	["Gorilla hills"] = "猩猩山丘",
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["From the Bloodsail camp, climb into the Mistvale hills just east of it: the Elder Mistvale Gorillas (40) there drop the giblets."] = "",

	-- Step 39: Booty Bay
	-- {npc:2488} Deeg
	["Back down to town: Shaky stands at the tunnel mouth; {npc:2488} and MacKinley are on the top floor."] = "",
	-- {npc:2486} Fin Fizracket · {npc:1514} Mokk the Savage · {area:35} Booty Bay
	["{npc:2486}'s Stranglethorn Fever ({npc:1514}) waits for the level-48 {area:35} stop: leave it for now."] = "{npc:2486}的荆棘谷热病（{npc:1514}）留到48级回{area:35}时再做：暂时先放着。",
	-- {area:35} Booty Bay
	["MacKinley's Voodoo Dues waits for the level-48 {area:35} stop, with Zanzil's village: leave it for now."] = "「海狼」马克基雷的「讨债行动」暂缓，等48级回{area:35}、去赞吉尔的村子时再做。",

	-- Step 40: Stoley's Debt
	-- {quest:2872} Stoley's Debt · {area:35} Booty Bay
	["\"Sea Wolf\" MacKinley, on the top floor, offers {quest:2872} from level 40 (under 40, this guide's last {area:35} stop offers it again)."] = "",
	-- {zone:1446} Tanaris
	["\"Sea Wolf\" MacKinley: for Stoley in {zone:1446}, keep it"] = "",

	-- Step 41: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "丛林捕猎者",
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers roam the slopes west of the mine."] = "丛林捕猎者在矿洞西侧的山坡上游荡。",

	-- Step 42: Zul'Mamwe's Mystics and the Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Zul'Mamwe's Mystics and the Shadowmaw Panthers"] = "祖玛维的秘法师和深喉猎豹",
	-- {npc:739} Brother Nimetz
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["East from the stalkers' slopes to the ruins of Zul'Mamwe: the Skullsplitter Mystics (39-40) in its northern half carry {npc:739}'s fetishes. Careful: the Witch Doctors, Berserkers and Headhunters (41-44) hold the ruins' southern half: stay north. Then north-west toward the coast: the Shadowmaw Panthers (37-38) prowl the jungle west of the ruins, often stealthed."] = "从捕猎者所在的山坡向东前往祖玛维废墟：废墟北半部的劈颅秘法师（39-40级）身上带着{npc:739}要的神像。注意：巫医、狂暴者和猎头者（41-44级）占据废墟南半部，待在北边。然后向西北朝海岸走：深喉猎豹（37-38级）在废墟以西的丛林中游荡，经常处于潜行状态。",
	-- {item:2466} Skullsplitter Fetish
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic
	["{item:2466}, from the Skullsplitter Mystics"] = "{item:2466}，来自劈颅秘法师",

	-- Step 43: The north-west coast
	["The north-west coast"] = "西北海岸",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Go on north-west to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "继续向西北前往西北海岸的海湾。{object:2744}在海底，里面有珍珠；{npc:2624}在它们中间游动，掉落{item:4034}。",
	-- {item:4611} Blue Pearl
	["{item:4611}; underwater"] = "{item:4611}：在水下",

	-- Step 44: Sin'Dall
	-- {npc:729} Sin'Dall
	["North-east from the bay toward Nesingwary's camp: {npc:729}, the great tiger (37), lairs on the hilltop just south-west of the camp."] = "从海湾向东北朝奈辛瓦里远征队营地走：巨虎{npc:729}（37级）盘踞在营地西南不远的山顶上。",

	-- Step 45: Hemet Nesingwary
	-- {npc:718} Sir S. J. Erlgadin
	["{npc:718}, beside him"] = "{npc:718}，在他旁边",

	-- Step 46: Ajeck Rouack
	-- {npc:717} Ajeck Rouack
	["{npc:717}, beside the other hunters"] = "{npc:717}，在其他猎人旁边",

	-- Step 49: Arbor Tarantula
	-- {npc:217588} Arbor Tarantula · {area:99} Rebel Camp · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit · {item:213562} Bug Catching Net
	["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: open {npc:217412}'s {item:213565} and use its {item:213562} on one. Don't kill it."] = "{npc:217588}在奈辛瓦里营地东南方的丛林中爬行，在前往{area:99}的路上：打开{npc:217412}的{item:213565}，对其中一只使用里面的{item:213562}。不要杀死它。",
	-- {item:213562} Bug Catching Net · {npc:217588} Arbor Tarantula · {item:213566} Arbor Tarantula Specimen
	["{item:213562}, on an {npc:217588}: the {item:213566}"] = "{item:213562}，用在{npc:217588}上：{item:213566}",

	-- Step 50: Rebel Camp
	["Head north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "向东北经过奈辛瓦里远征队营地，再沿道路向北前往山谷最北端的营地。",

	-- Step 51: Brother Nimetz
	-- {npc:739} Brother Nimetz · {area:301} Savage Coast · {npc:2277} Loremaster Dibbs · {area:271} Southshore · {zone:1418} Badlands · {zone:1425} Hinterlands
	["{npc:739}: the {area:301} report bundle for {npc:2277} in {area:271}, on the {zone:1418} & {zone:1425} guide: keep it"] = "{npc:739}：给{area:271}的{npc:2277}的{area:301}报告，在{zone:1418}和{zone:1425}指南中做：先留着",

	-- Step 52: Kurzen's Compound
	-- {area:99} Rebel Camp · {area:101} Kurzen's Compound · {npc:218230} Wendel Mathers · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Subchiefs = {npc:978} Kurzen Subchief
	["East from the {area:99} to {area:101}: {npc:218230} is caged at its western edge. The Kurzen Subchiefs (35-36) and Elites (36-37) carry his cage key; the fighter's uniform lies in a supply crate in the compound's eastern part.\nCareful: {npc:813}, an elite of 39-40, stands at the compound's north end beside three of the Subchiefs: take the key from the Subchiefs and Elites further south and leave him be."] = "从{area:99}向东前往{area:101}：{npc:218230}被关在其西侧边缘。库尔森副首领（35-36级）和库尔森精英（36-37级）身上带着他的囚笼钥匙；战士制服在营地东部的一个补给箱里。\n注意：39-40级精英{npc:813}站在营地北端，旁边有三个副首领：从更南边的副首领和精英身上拿钥匙，别惹他。",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage, if you didn't take it on the 30-40 loop"] = "{npc:218230}，在笼子里，如果30-40级路线中没接的话",
	-- {item:216616} Compound Cage Key
	["{item:216616}, from the Subchiefs (or the Elites)"] = "{item:216616}，来自副首领（或精英）",
	-- {item:216617} Kurzen Fighter's Uniform
	["{item:216617}, in the supply crate deep in the cave"] = "{item:216617}，在洞穴深处的补给箱里",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, back at his cage on the way out"] = "{npc:218230}，离开时回到他的笼子旁",
	-- {npc:218229} Captain Aransas · {area:35} Booty Bay
	["For {npc:218229} in {area:35}, at the end of the jungle loop"] = "交给{area:35}的{npc:218229}，在丛林环线的终点",

	-- Step 53: Lake Nazferiti
	-- {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal · Venture Co. Agents = {npc:260429} Venture Co. Agent · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Head south from the compound to {area:37}. The Venture Co. Geologists in the shore camps carry the Tumbled Crystals; Venture Co. Agents (39) walk among them. Stay on the shore: stealthed Shadowmaw Panthers prowl the jungle south and east of the lake."] = "从营地向南前往{area:37}。湖岸营地的风险投资公司地质学家会掉落打磨过的水晶，风险投资公司密探（39级）在他们之间走动。沿湖岸走，湖以南和以东的丛林里有深喉猎豹潜行游荡。",

	-- Step 54: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:728}是 40 级精英，多数职业到 42 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 55: Ruins of Zul'Mamwe: kill these as you meet them
	-- {area:103} Ruins of Zul'Mamwe
	["{area:103}: kill these as you meet them"] = "{area:103}：沿途击杀以下目标",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do.\nFollow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "劈颅巨魔占据矿洞以东的废墟，所有巨魔都有几率掉落獠牙，它们的豹子则必定掉落。\n沿路向东北前往{area:310}的风险投资公司营地，矿工、勘测员和工头会掉落水晶。\n注意：营地周围有潜行的深喉猎豹和荆棘谷雌虎。",
	-- {item:1524} Skullsplitter Tusk
	["{item:1524}, from the trolls of the ruins"] = "{item:1524}，来自废墟中的巨魔",

	-- Step 56: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:730}是 43 级精英，多数职业到 45 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 60: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:731}是 43 级精英，多数职业到 45 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。\n注意：附近有老虎和潜行的暗影黑豹，先清理再拉首领。拉到{npc:731}时，它会召集 20 码内的生物支援。",

	-- Step 62: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road south to {area:35}."] = "沿路向南前往{area:35}。",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}：在楼上",

	-- Step 63: Kebok
	-- {area:37} Lake Nazferiti
	["The crystals gathered at {area:37}"] = "在{area:37}收集的水晶",

	-- Step 64: Booty Bay
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}：交给{zone:1446}的{quest:2864}，留着",

	-- Step 65: Stoley's Debt
	-- {quest:2872} Stoley's Debt
	["If you didn't take {quest:2872} on the earlier stop: \"Sea Wolf\" MacKinley, on the top floor."] = "",

	-- Step 66: Fly to Stormwind
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飞行管理员",

	-- Step 67: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141}在{object:2169}做饭；{npc:5384}在{object:28027}。",
	-- {npc:5694} High Sorcerer Andromath · {npc:5464} Watchmaster Sorigal · {area:42} Darkshire
	["{npc:5694}: for {npc:5464} in {area:42}, on the way to the swamp"] = "{npc:5694}：交给{area:42}的{npc:5464}，前往沼泽时顺路做",

	-- Step 68: Stormwind
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}，在{object:2117}的皇家图书馆",

	-- Step 70: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "圣骑士：{quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}，在光明大教堂",

	-- Step 71: Stormwind City
	["Stormwind City"] = "暴风城",

	-- Step 72: Warlock: Summon Felsteed
	-- {quest:4488} Summon Felsteed
	["Warlock: {quest:4488}"] = "术士：{quest:4488}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}，在{object:2164}：{area:392}的{npc:6251}在下一份指南结尾接收",

	-- Step 74: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "飞往{area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}的飞行管理员",

	-- Step 77: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:4753}在{zone:1457}教授暗夜精灵，旁边是{npc:4730}的豹：从{area:17203}乘船前往{area:442}，再飞往{area:702}。无限服可能允许任何种族向任何骑术训练师学习（未确认），例如{zone:1429}{area:88}的{npc:4732}。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}：其他颜色，20金",

	-- Step 79: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飞往{area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}的飞行管理员",

	-- Step 80: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "乘船前往{area:17203}",

	-- Step 81: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飞往{area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飞行管理员",

	-- Step 82: Darkshire
	-- {npc:5464} Watchmaster Sorigal
	["{npc:5464}, by the flight master"] = "{npc:5464}，在飞行管理员旁边",

	-- Step 84: Misty Valley
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "卷轴在比格斯北边的沼泽里。其北边的沼泽漫步者可能掉落卡德加的空间收敛研究笔记。",

	-- Step 85: Amaryllis Webb
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends · {zone:1417} Arathi Highlands
	["{npc:217412}: {quest:93176}, from the {zone:1417} guide"] = "把走{zone:1417}路线时接到的「{quest:93176}」交给{npc:217412}。",

	-- Step 86: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["{npc:5476} stands by the road junction in the west of the swamp."] = "{npc:5476}站在沼泽西侧的道路交汇处。",

	-- Step 87: The sunken temple
	["The sunken temple"] = "沉没的神庙",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Head east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "向东前进；沿途的纠缠恐兽也会掉落研究笔记。在{area:74}边缘搜寻，神庙的废墟在那里露出水面。",

	-- Step 88: Misty Reed Strand
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler · Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Silt Crawlers (40-41) crowd the north end of the eastern shore, and the driftwood washes up along it from there.\nCareful: the big Monstrous Crawlers (43-44) further south on the shore are over you: take the legs at the north end and pick up the driftwood without pulling them."] = "淤泥蟹（40-41）聚集在东岸北端，浮木也从那里沿岸冲上来。\n小心：岸边更南面的巨型淤泥蟹（43-44）等级比你高：在北端收集蟹腿，捡浮木时别引到它们。",
	-- {item:5938} Pristine Crawler Leg
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler
	["{item:5938}, from the Silt Crawlers"] = "{item:5938}，来自淤泥蟹",

	-- Step 89: Watcher Biggs
	-- {area:1438} Nethergarde Keep
	["for {area:1438}, just south of the swamp"] = "",

	-- Step 90: Into the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Into the {zone:1419}"] = "",
	-- {zone:1419} Blasted Lands · {area:75} Stonard · {area:1438} Nethergarde Keep · {npc:5982} Black Slayer
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang
	["Follow the road south-east from Biggs to the pass into the {zone:1419}, keeping clear of {area:75}, the Horde town to the north-east.\nDown the pass, the road bends east to {area:1438}. Careful: {npc:5982} vultures (46) and Starving Snickerfangs (45) hunt in the dry hills south of the road: stay on it and keep moving."] = "",
	-- {zone:1419} Blasted Lands
	["The pass to the {zone:1419}"] = "",
	-- {area:1438} Nethergarde Keep
	["The road to {area:1438}"] = "",

	-- Step 91: Nethergarde Keep
	-- {npc:5385} Watcher Mahar Ba · {npc:5393} Quartermaster Lungertz
	["{npc:5385} is upstairs in the keep and {npc:5393} inside it; the gryphon master stands south of the keep."] = "",
	-- {npc:5385} Watcher Mahar Ba
	["{npc:5385}, upstairs"] = "{npc:5385}：在楼上",

	-- Step 92: Fly to Stormwind
	-- {area:1438} Nethergarde Keep
	["{area:1438} flight master"] = "{area:1438}的飞行管理员",

	-- Step 93: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "交给{area:348}的{npc:5635}：留着",

	-- Step 94: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁前往{zone:1455}",

	-- Step 97: Ironforge
	-- {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["{npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:2786} in the {object:32383}."] = "{npc:5637}在{object:32356}旁的寻物公司大厅，{npc:2786}在{object:32383}。",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453}没有萨满祭司训练师",

	-- Step 99: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:4772}在{area:803}教授矮人，位于{area:131}东边通往{zone:1432}的路上，旁边是{npc:1261}的山羊。无限 可能允许任何种族向任何骑术训练师学习（未确认）。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}：其他颜色，20金",

	-- Step 101: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:7954}在{area:131}东边不远的{area:189}教授侏儒，旁边是{npc:7955}的机械陆行鸟。无限 可能允许任何种族向任何骑术训练师学习（未确认）。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}：其他颜色，20金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["\"Sea Wolf\" MacKinley: keep it, for the level-48 {area:35} stop, with Zanzil's village"] = "“海狼”麦金利：先留着，到48级回{area:35}时和赞吉尔的村子一起做",
	-- ["Alone, you skip Nesingwary's three elite hunts: take their experience from the Skullsplitter trolls of Zul'Mamwe instead, just east of the mine, so every kill also counts for {npc:737}'s tusks. Or, with a group, run the {area:1517} dungeon instead."] = "单人时跳过奈辛瓦里的三个精英狩猎任务，改在矿洞东边的祖玛维废墟击杀劈颅巨魔补足经验，每次击杀也能收集{npc:737}需要的獠牙。也可组队挑战{area:1517}副本。",
	-- ["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: catch one with the tool from {npc:217412}'s {item:213565}."] = "奈辛瓦里远征队营地东南边、通往{area:99}的丛林里有{npc:217588}：用{npc:217412}的{item:213565}里的工具捕捉一只。",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "40级且有100金币时即可学习骑术，学会后会获得一匹坐骑。目前不知道天裔的骑术训练师在哪；Forever 客户端把{spell:1285849}归入同一个骑术技能，所以{zone:1429}东部{area:88}的{npc:4732}（离{zone:1453}最近的训练师）应该能教（未确认）。疾风陆行鸟由泽风岛{area:16638}的{npc:265756}出售；见“收藏品”中的“坐骑 · 40级”。",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {area:12}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:4732}在{area:12}东部的{area:88}教授人类，旁边是{npc:384}的马。无限 可能允许任何种族向任何骑术训练师学习（未确认）。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {area:12}. Collectibles, Mounts · Level 40 lists every colour."] = "40级且有100金时可以学习骑术，学会后会获得一匹坐骑。{npc:4753}在{zone:1457}教授暗夜精灵，旁边是{npc:4730}的豹：从{area:17203}乘船前往{area:442}，再飞往{area:702}。无限 可能允许任何种族向任何骑术训练师学习（未确认），例如{area:12}{area:88}的{npc:4732}。收藏指南“坐骑 · 40级”列出了所有颜色。",
	-- ["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "回到塞拉摩：特沃什和吉安娜女士在{area:514}的塔里等候。",
	-- ["Bloodsail pirates"] = "血帆海盗",
	-- ["Cold Eye Basilisks"] = "冷眼蜥蜴",
	-- ["Cortello's scroll"] = "科泰罗的卷轴",
	-- ["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye: take them from the Raiders and Mages (39-41) at the Bloodsail camp on the beach just north of town, where you found the letter. Leave the {area:43} camp south of town (Warlocks and Swashbucklers 41-43) for the level-48 visit."] = "每个血帆海盗都会掉落鼻烟，其中一个带着{npc:2493}的眼睛：去镇子北边不远的沙滩血帆营地（就是找到信的地方），从血帆袭击者和血帆法师（39-41级）身上获取。镇子南边的{area:43}营地（术士和暴徒，41-43级）留到48级再去。",
	-- ["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}.\nCareful: the {area:43} camp's Warlocks and Swashbucklers are level 41-43, a level or more above you, and stand close together: pull them singly from the edge."] = "每个血帆海盗都掉落鼻烟，其中一个携带{npc:2493}的眼睛；血帆流氓在镇子北边的岸上游荡。海图和命令在{area:35}南边{area:43}的海盗营地里。\n小心：{area:43}营地的血帆术士和血帆流氓是41-43级，比你高一级或更多，而且站得很近：从边缘一个一个引。",
	-- ["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "每个赞吉尔的追随者都可能掉落药剂；{npc:2537}在营地南部走动。",
	-- ["Fly to {area:144}"] = "飞往{area:144}",
	-- ["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "飞往{area:42}，向东骑行穿过{zone:1430}进入{zone:1435}；{npc:5476}站在刚过边界的路旁。",
	-- ["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "沿道路向东返回塞拉摩。特沃什、吉安娜女士和军官们在塔楼和{area:514}里。",
	-- ["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "沿道路向东北前往{area:310}的风险投资公司营地；矿工、勘探员和工头掉落水晶。",
	-- ["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "沿道路向西北离开塞拉摩，前往{area:503}的瞭望塔。泥石穴居龟在周围的沼泽中游荡。",
	-- ["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it.\n{npc:4967} waits at the foot of the tower: once you have looked around, hand the quest in to him there, not in Theramore."] = "沿道路向西北离开塞拉摩，前往{area:503}的瞭望塔。泥石穴居龟在周围的沼泽中游荡。\n{npc:4967}在塔脚下等候：四处查看后，直接在那里向他交任务，不用回塞拉摩。",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "疾风陆行鸟：{npc:265756}，在泽风岛的{area:16638}。",
	-- ["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "交还牙齿后留下：会来三波猩猩，最后是{npc:1514}。满血再战。",
	-- ["Head back down to town; Shaky stands at the tunnel mouth."] = "回到镇上；“病鬼”菲利普站在隧道口。",
	-- ["Head inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets."] = "向内陆前往迷雾谷猩猩所在的山丘。老迈的迷雾谷猩猩掉落内脏。",
	-- ["Head north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "向西北进入{zone:1413}，沿海岸北上到{area:392}：前往{area:35}的船从那里的码头出发，{area:392}的狮鹫管理员就站在码头上方。",
	-- ["If you skipped {quest:193}, grind here to level 42.06 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "如果跳过了{quest:193}，在这里刷怪补到42.06级，以跟上路线进度。也可以组队刷{area:1517}地下城。",
	-- ["If you skipped {quest:196}, grind here to level 42.1 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "如果跳过了{quest:196}，在这里刷怪补到42.1级，以跟上路线进度。也可以组队刷{area:1517}地下城。",
	-- ["If you skipped {quest:208}, grind here to level 42.16 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "如果跳过了{quest:208}，在这里刷怪补到42.16级，以跟上路线进度。也可以组队刷{area:1517}地下城。",
	-- ["If you skipped {quest:543}, grind here to level 42.46 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "如果跳过了{quest:543}，在这里刷怪补到42.46级，以跟上路线进度。也可以组队刷{area:1517}地下城。",
	-- ["Inside"] = "在里面",
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "克兰诺克·马克雷德接下来提供“捕风者”（1791）：{spell:1680}武器任务线最后有一个精英，见战士职业指南“旋风武器”。",
	-- ["Level 42.06"] = "等级42.06",
	-- ["Level 42.1"] = "等级42.1",
	-- ["Level 42.16"] = "等级42.16",
	-- ["Level 42.16 at Zul'Mamwe"] = "在祖玛维废墟升到42.16级",
	-- ["Level 42.46"] = "等级 42.46",
	-- ["MacKinley's next task sends you after elite ogres: skip it."] = "马克基雷的下一个任务要你对付精英食人魔：跳过。",
	-- ["Mudrock tortoises"] = "泥石海龟",
	-- ["Naga Explorers"] = "纳迦探险者",
	-- ["No flight path to {area:144} yet: ride out of {zone:1455}'s gates, east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "还没有{area:144}的飞行路线？骑出{zone:1455}城门，向东穿过{zone:1426}和隧道进入{zone:1432}，再沿路前往{area:144}。",
	-- ["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "向北骑往{area:392}的路上，{area:720}位于镇子南边的{area:391}近海：涉水穿过沙洲浅滩。{npc:6236}会让四名挑战者和{npc:6238}（33级）依次与你交战。",
	-- ["On the way north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "向北前往{area:392}的路上，{area:720}位于镇子南边的{area:391}近海：涉水穿过沙洲浅滩。{npc:6236}会让四名挑战者和{npc:6238}（33级）依次与你交战。",
	-- ["Optional: Cortello's scroll lies inside one of the three Bloodsail ships anchored off the coast just south of {area:35}, on a middle or lower deck, and is not always on the same ship. Their crews are 42-45 pirates: clear your way from the edge, one at a time, and leave the captains (45-48), whom the route comes back for at 48."] = "可选：科泰罗的卷轴在{area:35}南边不远处海岸外停泊的三艘血帆海盗船之一里，位于中层或下层甲板，而且不一定每次都在同一艘船上。船员是42-45级的海盗：从边缘开始逐个清理，别碰船长（45-48级），路线会在48级时回来对付他们。",
	-- ["Ride back down to town; Shaky stands at the tunnel mouth."] = "骑回镇上；“病鬼”菲利普站在隧道口。",
	-- ["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "沿道路向西骑回；{npc:217412}站在比格斯北边不远处。",
	-- ["Ride east out of {zone:1426} through the tunnel into {zone:1432} and on along the road to {area:144}."] = "从{zone:1426}向东骑行，穿过隧道进入{zone:1432}，再沿路前往{area:144}。",
	-- ["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "向东骑行；沿途的纠缠恐兽也会掉落研究笔记。在{area:74}边缘搜寻，神庙的废墟在那里露出水面。",
	-- ["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "从塞拉摩沿尘泥沼泽的道路向西进入{zone:1413}，再向北到海岸上的{area:392}。向{npc:16227}学习飞行路线，然后在码头乘船前往{area:35}。",
	-- ["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "向内陆骑行到迷雾谷猩猩所在的山丘。老迈的迷雾谷猩猩掉落内脏；{npc:1449}坐在它们中间。",
	-- ["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "向北骑行到道路西边的山丘。{npc:2535}和{npc:2536}一起站在赞吉尔村子北边不远处。",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "骑乘向东北经过奈辛瓦里营地，再沿道路向北前往山谷最北端的营地。",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "向东北经过奈辛瓦里营地，沿道路向北前往山谷顶端的营地。途中，奈辛瓦里营地东南方的丛林里有一只{npc:217588}：用昆虫学入门工具包捕捉一只，然后勾选。",
	-- ["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "从矿井向西北骑行到西北海岸的海湾。{object:2744}在海底，里面有珍珠；{npc:2624}在它们中间游动，掉落{item:4034}。",
	-- ["Ride north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "向西北骑进{zone:1413}，沿海岸北上到{area:392}：前往{area:35}的船从那里的码头出发，{area:392}的狮鹫管理员就站在码头上方。",
	-- ["Ride south down the road to {area:35}."] = "沿路向南骑行到{area:35}。",
	-- ["Ride south out of {zone:1432} through the pass into the {area:3}; {npc:2860} camps at the dig."] = "向南骑出{zone:1432}，穿过山口进入{area:3}；{npc:2860}在挖掘场扎营。",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "向南骑出{zone:1432}，穿过山口进入{zone:1418}；{npc:2860}在挖掘场扎营。",
	-- ["Ride south to the giant's hut in the middle of the marsh."] = "向南骑行到沼泽中央巨人的小屋。",
	-- ["Seahorn now offers {quest:604}: leave it. Its three captains are level 45-48 with crews around them, and the route brings you back to Seahorn at 48 for it."] = "舰队指挥官卡拉·海角现在会提供{quest:604}，先不要接。任务中的三名船长为45-48级，周围都有船员；路线会在48级时再次返回这里处理此任务。",
	-- ["Seahorn's Bloodsail Buccaneers: keep it for the level-48 {area:35} stop, with the {area:43} camp."] = "海角的血帆海盗任务：先留着，到48级回{area:35}时和{area:43}营地一起做。",
	-- ["Skullsplitter ruins"] = "劈颅巨魔废墟",
	-- ["Still short of level 42.16 after the hunts you did? Make up the rest on the Cold Eye Basilisks by the {area:310}, on your way south to {area:35}. Or, with a group, run the {area:1517} dungeon instead."] = "完成所选狩猎任务后，还没到42.16级？向南前往{area:35}途中，在{area:310}旁击杀冷眼蜥蜴补足经验。也可组队挑战{area:1517}副本。",
	-- ["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "沿道路向北前往废弃的庄园；加尔住在旁边的棚屋里，松土就在房子的拐角处。",
	-- ["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "从{object:28027}乘{area:2257}。{npc:5637}在{object:32356}旁的寻物公司大厅，{npc:1356}在大厅内，{npc:2786}在{object:32383}。下一份指南飞往{area:144}。",
	-- ["The Bloodsail captains"] = "血帆船长",
	-- ["The Cold Eye Basilisks lie on the rocks west of the mine."] = "冷眼蜥蜴趴在矿井西边的岩石上。",
	-- ["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "黑雾蜘蛛在沼泽西北部的洞穴周围筑巢；每只蜘蛛都会掉落眼睛。",
	-- ["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "黑鳍鱼人聚集在{area:497}以外的北部海岸；在旁边的海龟身上收集完舌头。",
	-- ["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "泥石海龟和泥石刺壳龟在庄园东北方的岸边晒太阳。",
	-- ["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "劈颅巨魔占据矿井东边不远的废墟；任何巨魔都可能掉落獠牙，它们的猎豹必定掉落。",
	-- ["The boat leaves from Theramore: report to {npc:4944} on the top floor of {area:514} on the way to the docks."] = "船从塞拉摩出发：去码头途中，先到{area:514}顶层向{npc:4944}报到。",
	-- ["The burned inn stands on the road west, toward the {area:17}; the guard's badge lies in the ashes."] = "被烧毁的旅店在向西通往{area:17}的道路上；卫兵徽章就在灰烬中。",
	-- ["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "烧毁的旅店在向西通往{zone:1413}的路上；卫兵的徽章在灰烬中，蹄印在旅店旁的泥地里。",
	-- ["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "船长们站在停泊于{area:43}外的船上，每艘有42-45级的海盗船员：斯蒂沃特（45）和尼哈鲁（46）在较近的甲板上，{npc:2546}（48）在旗舰上。42级时这需要组队，或留到指南最后；如果要去，先清理每层甲板。科泰罗的卷轴在岸边的沉船上。",
	-- ["The driftwood washes up along the eastern shore."] = "浮木冲上东岸。",
	-- ["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "纳迦在血帆营地北边的海滩上搜寻；它们掉落芦苇。",
	-- ["The riddle's next scroll lies in western Dustwallow: skip it."] = "谜题的下一张卷轴在尘泥沼泽西部：跳过。",
	-- ["Unbagwa's ritual"] = "安巴格瓦的仪式",
	-- ["Warlock: {quest:3631}"] = "术士：{quest:3631}",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "你在路线之前来这里时错过了这一步：现在先做它。它很快，还会开启后面的任务。",
	-- ["Zanzil's village"] = "赞吉尔的村子",
	-- ["for Stoley in {zone:1446}: keep it"] = "交给{zone:1446}的斯杜雷：留着",
	-- ["for Stoley in {zone:1446}: keep it; on the top floor"] = "留给{zone:1446}的斯杜雷；任务在最顶层接取",
	-- ["for the flight back to {npc:6251} at 43"] = "用于43级时飞回{npc:6251}处",
	-- ["for the {area:8} later"] = "之后用于{area:8}",
	-- ["for the {zone:1435} later"] = "之后用于{zone:1435}",
	-- ["for {area:1438}: keep it"] = "交给{area:1438}：留着",
	-- ["for {npc:2616} in Theramore: keep it"] = "交给塞拉摩的{npc:2616}：留着",
	-- ["grind on {npc:667}"] = "击杀{npc:667}刷经验",
	-- ["grind on {npc:690}"] = "反复击杀{npc:690}补足经验",
	-- ["grind on {npc:766}"] = "反复击杀{npc:766}补足经验",
	-- ["keep it: the {area:43} camp's charts and Swashbucklers (41-43) wait for the level-48 {area:35} stop"] = "先留着：{area:43}营地的海图和血帆暴徒（41-43级）留到48级回{area:35}时再做",
	-- ["{area:43}: kill these as you meet them"] = "{area:43}：沿途击杀以下目标",
	-- ["{item:216617}, in the supply crate"] = "{item:216617}，在补给箱里",
	-- ["{item:5938}, from the Silt Crawlers on the same shore"] = "{item:5938}，来自同一段海岸的淤泥蟹",
	-- ["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}：交给{zone:1432}的{npc:1344}，留着",
	-- ["{npc:1449}, inside {area:1742}"] = "{npc:1449}，位于{area:1742}内部",
	-- ["{npc:1470} is below ground in {area:144}, by the inn. His mushrooms grow in the {area:1517} dig in the {zone:1418}; the next guide takes you there and back through {area:144}."] = "{npc:1470}在{area:144}旅店旁的地下。他需要的蘑菇长在{zone:1418}的{area:1517}挖掘场，下一份指南会前往那里，并在返回时经过{area:144}。",
	-- ["{npc:1470}, below ground"] = "{npc:1470}：在地下",
	-- ["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}：{quest:93176}，来自 30-40/05-arathi-highlands",
	-- ["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}：捕捉它，用于{quest:93176}",
	-- ["{npc:2487}, top floor"] = "{npc:2487}，顶楼",
	-- ["{npc:2494}: keep it, its naga (43-44) wait for the level-48 {area:35} stop"] = "{npc:2494}：先留着，其纳迦（43-44级）等48级再来{area:35}时处理",
	-- ["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}的下一个赞吉尔差事从{zone:1441}开始：跳过。",
	-- ["{npc:2498}, inside: keep it, Zanzil's village (43-44) waits for the level-48 {area:35} stop"] = "{npc:2498}，在室内：先留着，赞吉尔的村庄（43-44级）等48级再来{area:35}时处理",
	-- ["{npc:2535} and {npc:2536}"] = "{npc:2535}和{npc:2536}",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888}独自在挖掘场东南方的{area:1898}扎营。",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966}和几个逃兵占据着塔楼。他会攻击你：打到他投降为止。",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders."] = "{npc:4966}和几名逃兵占据高塔。他会转为敌对，攻击他直到投降。\n注意：亨德尔下士转为敌对时，两名守卫也会参战；他投降后，守卫会逃跑。",
	-- ["{npc:4967}, upstairs"] = "{npc:4967}：在楼上",
	-- ["{npc:4968}, on the top floor"] = "{npc:4968}，位于最顶层",
	-- ["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}：交给{area:1438}，留着",
	-- ["{npc:6236}: Berserker Stance"] = "{npc:6236}：狂暴姿态",
	-- ["{npc:717}, beside them"] = "{npc:717}，在他们旁边",
	-- ["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910}是港口上方的高楼；大多数任务给予者在它的各层或下方码头。",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}，交给“沼泽之眼”加尔",
	-- ["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260}站在旅店附近；往南几步的商人{npc:4897}出售加尔要的香料。",
	-- ["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706}：它的{item:4612}掉率很低，所以任务和交还也都是可选的",
	-- ["{zone:1455} flight master"] = "{zone:1455}飞行管理员",
}
