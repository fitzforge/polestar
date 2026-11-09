-- Chinese (simplified) (zhCN): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Crossroads
	["Fly to Crossroads"] = "飞往十字路口",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 2: The road west
	["The road west"] = "",
	["The road west past Seereth's camp"] = "",

	-- Step 3: Malaka'jin
	-- {npc:3995} Witch Doctor Jin'Zil · {area:2539} Malaka'jin · {area:1076} Webwinder Path
	["Follow the road west past Regthar's bunkers and Seereth's camp into Stonetalon: {npc:3995} waits below ground in {area:2539}, at the foot of the {area:1076}."] = "沿路向西，经过雷戈萨的地堡和希雷斯的营地，进入石爪山脉：{npc:3995} 在 {area:1076} 脚下、{area:2539} 的地下等候。",
	-- {npc:3995} Witch Doctor Jin'Zil
	["{npc:3995}, below ground"] = "{npc:3995}：在地下",

	-- Step 4: Sun Rock Retreat
	-- {area:1076} Webwinder Path · {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["Up the {area:1076} past {npc:4201} and west to {area:460}."] = "沿 {area:1076} 上行，经过 {npc:4201}，再向西到 {area:460}。",
	-- {npc:11862} Tsunaman · {npc:12736} Je'neu Sancrea
	["{npc:11862}: {npc:12736} at Zoram'gar, next guide"] = "{npc:11862}：交给佐拉姆加的 {npc:12736}，见下一篇指南",
	-- {npc:11860} Maggran Earthbinder · {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["{npc:11860}: {npc:12576} is at the {area:1718}, later in this guide"] = "{npc:11860}：{npc:12576} 在 {area:1718}，在本篇指南后续步骤完成",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}：从血怒鹰身人获取闪光的太阳石",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}，在大门外",

	-- Step 5: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "盖亚之种",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock.\nCareful: Pridewings around the lake can aggro as a linked group."] = "盖亚之种散布在烈日石居以北、{area:464} 南岸周围的草丛中。\n小心：湖边的雄翼双足飞龙可能会整群联动进入战斗。",

	-- Step 6: Stonetalon Mountains: kill these as you meet them
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442}: kill these as you meet them"] = "{zone:1442}：沿途击杀以下目标",
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "沿道路向北朝{area:467}前进。巨角鹿沿途吃草；腐蚀兽、夜行虎和灵龙在山峰下方的树林中游荡，塞纳里奥德鲁伊占据那里的树林。",

	-- Step 7: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}的下一个任务“奥达努斯”在{zone:1440}的联盟一方。跳过。",

	-- Step 8: The Charred Vale: kill these as you meet them
	-- {area:465} The Charred Vale
	["{area:465}: kill these as you meet them"] = "{area:465}：沿途遇到就击杀",
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "烈日石居西南方是烧焦的{area:465}。把{item:16205}种在谷底的土堆里；火元素掉落{item:16312}。血怒鹰身人和血怒伏击者在北侧筑巢，血怒杀戮者和血怒游荡者在南侧。",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}，来自任何血怒鹰身人",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "盖亚土堆",

	-- Step 9: Sun Rock Retreat
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}，在{npc:11862}旁边",
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}，在上方的岩架上",

	-- Step 10: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Head back down the {area:1076} to {area:2539}."] = "沿 {area:1076} 下行，返回 {area:2539}。",

	-- Step 11: To Camp Taurajo
	-- {area:378} Camp Taurajo
	["To {area:378}"] = "",

	-- Step 12: Camp Taurajo
	-- {area:2539} Malaka'jin · {area:378} Camp Taurajo
	["From {area:2539} follow the road east to Seereth's camp, then south-east across the plains to {area:378}."] = "从 {area:2539} 沿路向东到希雷斯的营地，再向东南穿过平原，前往 {area:378}。",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}，在营地北缘",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}，在笼子里",

	-- Step 13: Grunt Logmar
	-- {npc:5911} Grunt Logmar · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["{npc:5911} stands by the flight master. His {npc:268623} (23) is elite: grouping up is advised; the two Encroaching Soldiers are not."] = "",
	-- {npc:5911} Grunt Logmar · {npc:3341} Gann Stonespire
	["{npc:5911}: the soldiers and the pillager camp just east of {npc:3341}, on the way south"] = "",

	-- Step 15: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "{npc:5899}的小屋在{area:378}南边野猪人水坑上方的山脊上，就在前往{area:359}的路上。",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}：{area:272}的红色水袋",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}：蓝色水袋在{zone:1440}装满，见下一个指南",

	-- Step 16: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan · {npc:14242} Sulhasa
	["{npc:3341} walks the road south toward {area:359}, between about 46,75 and 46,81: if he isn't at the arrow, follow the road until you meet him. {npc:14242} sits up in the tree just east of the road at 47.9,77.5."] = "",
	-- {npc:3341} Gann Stonespire · {area:1701} Blackthorn Ridge
	["{npc:3341} walks around {area:1701}: look inside the circle on the map"] = "{npc:3341}在{area:1701}附近巡逻，请在地图标出的圆圈内寻找",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}，在{npc:3341}正东的树上",

	-- Step 17: Wrongly Blamed, Justly Corrected
	-- {npc:14242} Sulhasa · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["A few steps east of {npc:14242}'s tree, a small camp: two Encroaching Soldiers and the {npc:268623} for Logmar. The {npc:268623} is elite: grouping up is advised."] = "",

	-- Step 18: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone.\nCareful: Excavators (level 21-22) and Foremen (level 22-23) run off for help once they fall to 15% health, so more dwarves can join the fight."] = "加恩·石塔以南，巴尔丹矮人正在{area:359}挖掘。挖掘工和工头在坑中工作；{npc:3392}（26级）带着日志：单独把他引出来。\n小心：挖掘工（21-22级）和工头（22-23级）在生命值降至15%时会逃跑求援，可能引来更多矮人参战。",
	-- {npc:3375} Bael'dun Foreman · {area:359} Bael Modan
	["{npc:3375} walks around {area:359}: look inside the circle on the map"] = "{npc:3375}在{area:359}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 19: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {quest:885} Washte Pawne · {spell:1752} Sinister Strike
	-- plural, as words: Razormane Stalkers = {npc:3457} Razormane Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest.\nCareful: Razormane Stalkers move around in stealth and hit with {spell:1752}, so they can join a fight without warning."] = "加恩·石塔西边的 {area:1701} 被钢鬃野猪人占据。{npc:3436} 在东侧，{npc:3434} 在南边，{npc:3435} 在最西端。洛克·奥克班恩（25 级）和战狂（24-25 级）比你高几级；稀有精英 {npc:5859} 有时会沿山脊巡逻：别招惹它。探路者和钢鬃捕猎者掉落 钢鬃背刺匕首，先知掉落 烧焦的钢鬃魔杖，战狂掉落 钢鬃大盾。{quest:885} 是一条稀有红色风蛇，会在山脊上空飞行：它的羽毛可以开启任务。\n小心：钢鬃捕猎者会潜行移动，并使用 {spell:1752} 攻击，可能毫无预警地加入战斗。",

	-- Step 20: Field to Clear
	-- {npc:3341} Gann Stonespire · {npc:3238} Stormhide
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["On the way back east to {npc:3341}: Hecklefang Stalkers and {npc:3238} lizards roam the plain between the ridge and his camp."] = "向东返回 {npc:3341} 处的途中：乱齿捕猎者和 {npc:3238} 蜥蜴在山脊与他营地之间的平原游荡。",
	-- {npc:4128} Hecklefang Stalker · {area:1156} Southern Barrens
	["{npc:4128} walks around {area:1156}: look inside the circle on the map"] = "{npc:4128}在{area:1156}附近巡逻，请在地图标出的圆圈内寻找",

	-- Step 22: Bael'dun fortress
	["Bael'dun fortress"] = "巴尔丹城堡",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them.\nCareful: Riflemen (level 24-25) Shoot from 5-30 yd, so nearby ones can join a fight from range."] = "巴尔丹士兵、巴尔丹火枪手 和 巴尔丹军官 守卫着挖掘场东侧的堡垒；它们会掉落全部三种物品。\n小心：巴尔丹火枪手（24—25级）的射击射程为5—30码，附近的敌人可能从远处加入战斗。",

	-- Step 24: The flying machine
	["The flying machine"] = "飞行器",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "矮人的飞行器停在挖掘场内的平台上。",

	-- Step 26: Great Lift
	-- {area:1718} Great Lift
	["The top of the {area:1718}"] = "",

	-- Step 27: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "巴尔莫丹西南方，{npc:12576} 在 {area:1718} 顶端等待。",

	-- Step 28: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "{area:1718}",
	-- {npc:10079} Brave Moonhorn · {area:1718} Great Lift · {npc:12576} Grish Longrunner
	["{npc:10079} stands at the top of the {area:1718}, beside {npc:12576}."] = "{npc:10079}站在{area:1718}顶部，在{npc:12576}旁边。",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}，在升降梯顶部",

	-- Step 31: Grunt Logmar
	-- {npc:5911} Grunt Logmar
	["{npc:5911}, beside the flight master"] = "",

	-- Step 32: Fly to Crossroads
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "{area:378}的飞行管理员",

	-- Step 33: The Crossroads
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}，在塔顶",

	-- Step 34: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飞往{area:392}",
	["Crossroads flight master"] = "十字路口飞行管理员",

	-- Step 35: Merchant Coast
	-- {quest:874} Mahren Skyseer · {area:392} Ratchet
	["{quest:874} camps on the shore just north of {area:392}'s flight master."] = "{quest:874} 在 {area:392} 飞行管理员北边不远处的海岸扎营。",

	-- Step 36: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}是一头巨大的鱼龙，在{area:391}外的浅水中游动，位于{npc:3388}东边。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "协助{npc:261366}：当{npc:261367}和{area:21}水兵走上山脊时，待在他身边",
	-- ["Back to the {area:380}"] = "返回{area:380}",
	-- ["Bristleback camps"] = "刺背野猪人营地",
	-- ["Bruuz"] = "布鲁兹",
	-- ["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "施放{spell:18960}。牛头人：在{area:2361}见{npc:11802}之前，先在湖西北岸的{area:2362}把两半坠饰合在一起。",
	-- ["Dogran is chained up in the quilboar camp west of the road."] = "多格兰被锁在道路西边的野猪人营地里。",
	-- ["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "双足飞龙管理员多拉斯站在{object:172982}的塔上。",
	-- ["Down the {area:458} to {area:378} again."] = "再次沿{area:458}向南前往{area:378}。",
	-- ["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "向东穿过平原前往海岸：被偷的银子在{area:385}西北的一个迅猛龙巢穴里。",
	-- ["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "向东前往{area:382}。{npc:3439}停在风险投资公司营地里；{npc:3445}带着钥匙。",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "在野猪人的水坑装满{item:7766}",
	-- ["Fizzule is by the Venture Co. tower north of the {area:382}. Use {item:8051} to fire TWO flares before approaching him, then target him and /salute. Keep that order: he attacks strangers who have not signalled first."] = "菲兹尔位于{area:382}以北的风险投资公司塔楼附近。先用{item:8051}发射两次信号弹，再靠近、选中他并输入/salute。务必按此顺序操作，没有先打信号就靠近会被他攻击。",
	-- ["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "费苏勒管理着{area:382}东端的风险投资公司营地。他会攻击陌生人：在他动手前选中他并 /salute。",
	-- ["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "飞回{area:380}。下一个指南从这里开始，沿道路向北前往{area:1703}和{zone:1440}。",
	-- ["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "飞往{area:1637}训练20级技能。{npc:3354}在{object:172958}，{npc:5892}在{object:172957}。",
	-- ["Fly to {area:1637} to train."] = "飞往{area:1637}训练。",
	-- ["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "飞往{area:1638}训练20级技能：{npc:3033}在{area:1639}。",
	-- ["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "飞往{area:1638}训练：{npc:3033}在{area:1639}。",
	-- ["Follow the {area:458} south to {area:378}."] = "沿{area:458}向南前往{area:378}。",
	-- ["He gives you the {item:15826}"] = "他会给你{item:15826}",
	-- ["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "他接下来会提供{quest:1838}（1838，30级）：它需要{area:1717}，还会让你跑遍卡利姆多和东部王国。战士职业指南{quest:1838}涵盖了它。",
	-- ["Hearth to the {area:380}"] = "用炉石回到{area:380}",
	-- ["Keep it: the {object:107045} is beside {area:272}"] = "留着它：{object:107045}在{area:272}旁边",
	-- ["Keep it: {npc:12696} in {zone:1440}, next guide"] = "留着它：交给{zone:1440}的{npc:12696}，见下一个指南",
	-- ["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "留着它：交给{zone:1454}的{npc:5875}，在本指南结尾",
	-- ["Kolkar camp"] = "科卡尔营地",
	-- ["Level 20"] = "20级",
	-- ["Lost Barrens Kodos roam the plains around the Kolkar camp north-west of {npc:3389}; herbalists pick {item:2449} there too."] = "落单的草原科多兽在{npc:3389}西北的科卡尔营地周围平原上游荡；草药师也可以在那里采集{item:2449}。",
	-- ["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "向北前往{area:383}。{npc:3682}在山下扎营；他身后山脊上的隐士{npc:261366}要等{npc:3682}派你上去后才会给你任务。",
	-- ["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "沿{area:458}返回{area:378}的路上：营地北边道路两侧刺背野猪人营地中的钢鬃掠夺者携带{item:277277}。最后一次在{area:380}停留时交给{npc:3432}。",
	-- ["Pickpocket {npc:7287} for the tower key before opening the lockbox. Gallywix and his lockbox are at the top; the key does not open that box, which still needs Lockpicking. Gallywix is elite: grouping up is advised. If you postpone this optional job, resume it in the Class guide Poisons (Horde)."] = "打开保险箱前，先从{npc:7287}身上偷取塔楼钥匙。加里维克斯和他的保险箱在塔顶；这把钥匙打不开该保险箱，仍需开锁技能。加里维克斯是精英，建议组队。这段自选工作可以稍后从职业指南“毒药（部落）”继续。",
	-- ["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "从{area:380}向北骑到{area:384}，在{object:19464}装满{item:15842}，然后回到{area:380}找{npc:3448}。没有{skill:182}？他旁边的{npc:3490}出售{item:2449}，每次三个，之后要等他补货。",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "草原狮王在山丘东边的平原上游荡，爆炸陷阱就散落在它们中间。{quest:876}率领着西边山丘里的巫翼鹰身人。",
	-- ["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "陶拉祖营地南边，{object:3685}遍布{area:390}；蛋就在土丘里，{npc:3252}会出来保护它们。{npc:3253}很稀有：如果看到，杀死它取下它的头。",
	-- ["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "在加恩南边，巴尔丹矮人在{area:359}挖掘。巴尔丹挖掘者和巴尔丹工头在坑里干活；{npc:3392}（26级）带着日志：单独把他引出来。",
	-- ["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "保持潜行：{npc:7287}带着塔的钥匙；加里维克斯和他的保险箱在塔顶。加里维克斯是精英：建议组队。",
	-- ["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "赤鳞镰爪龙在{area:380}南边的平原上、{area:1697}一带捕猎；它们掉落角。下次路过{area:392}时交还。",
	-- ["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "牛头人：{npc:11957}在桥上方的南边山丘上等候。天裔：{npc:272054}站在双桥南边。然后前往湖东边的兽穴：解除变形，点击入口处的雕像获得五分钟潜行，避开里面的灵魂，每种遗物各拿一件；{item:280680}在白色猎豹雕像脚下。",
	-- ["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "巴尔丹士兵、巴尔丹火枪手和巴尔丹军官守卫着挖掘场东侧的城堡；三样物品都由他们掉落。",
	-- ["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "刺背野猪人的营地遍布{area:378}北边的平原，位于{area:458}两侧。每个刺背野猪人都会掉落獠牙；{npc:3432}的妻子躺在北缘。留一个{item:5075}。{quest:883}是一头灰色科多兽，有时会在这里游荡：它的蹄子可以开始一个任务。",
	-- ["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "地区东北角矿洞的风险投资公司监督和风险投资公司执行者掉落{item:5097}。",
	-- ["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "触角掉落十五分钟后就会消失，所以趁现在北返时收集：在{area:390}的土丘旁杀异种群居蝎和异种爬行者，直到拿到五个，然后立刻用炉石回到{area:378}。",
	-- ["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "{zone:1454}的20级职业任务（{npc:3354}、{npc:5892}、术士和潜行者训练师）20级才提供，所以飞走前先在这里升到20级。{area:380}西南平原上的雷鹰雏鸟（18级）和{area:388}的科卡尔半人马（14-15级）是最近的值得击杀的怪物；你需要的经验远不到一级。",
	-- ["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "海盗在{area:392}南边的海滩上扎营；{npc:3467}站在营地南端。",
	-- ["The {area:2363}"] = "{area:2363}",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960}是{object:172982}下方的峡谷。",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790}位于{area:382}北缘、风险投资公司的塔旁。里面装着{quest:30}所需的{item:15883}。",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792}位于{area:382}北缘、风险投资公司的塔旁。里面装着{quest:30}所需的{item:15883}。",
	-- ["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "雷鹰破云者在营地南边同一片平原上空盘旋。",
	-- ["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "电角蜥蜴在{area:378}正南的平原上吃草。{quest:884}是一只蓝色的雷霆蜥蜴，在它们中间游荡：它的尾刺可以开始一个任务。",
	-- ["Twitching Antennae"] = "颤抖的触角",
	-- ["Twitching Antennae from the silithid"] = "从异种蝎身上获取颤抖的触角",
	-- ["Venture Co. tower"] = "风险投资公司的塔",
	-- ["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "在{npc:3341}西边，钢鬃野猪人占据着{area:1701}。{npc:3436}在东侧，{npc:3434}在南边，{npc:3435}在西端。洛克（25级）和钢鬃战士（24-25级）比你高几级；稀有精英{npc:5859}有时会在山脊上走动：别惹他。钢鬃探路者和钢鬃捕猎者掉落钢鬃背刺匕首，钢鬃先知掉落烧焦的钢鬃魔杖，钢鬃战士掉落钢鬃大盾。{npc:3238}和乱齿捕猎者在加恩与山脊之间的平原上游荡。{quest:885}是一条稀有的红色风蛇，在山脊上空飞行：它的羽毛可以开始一个任务。",
	-- ["While you are in the dig: {npc:3421} hides at the south edge of the dig; {object:3646} sits at the bottom of the excavation."] = "既然来到挖掘场：{npc:3421} 藏在挖掘场南缘，{object:3646} 就在挖掘坑底。",
	-- ["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "维兹克兰克驾驶伐木机离开营地：跟着他，杀死所有攻击他的敌人。在{area:392}向{npc:3442}交还。",
	-- ["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "在{area:380}西南刷雷鹰雏鸟",
	-- ["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}在更南边的海岸上。塞拉摩水兵和塞拉摩医师（15-16级）掉落勋章；{npc:3393}（20级）和两名炮手（19级）在城堡里和城墙上，所以要塞要等到现在才来。",
	-- ["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}：科卡尔营地周围平原上的落单的草原科多兽",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}：在{area:2362}使用其中一半",
	-- ["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "向{npc:3490}购买{item:2449}；草药师可以在平原上采集",
	-- ["{item:2449}: herbalists pick it here"] = "{item:2449}：草药师可在这里采集",
	-- ["{npc:11798} in {area:2361} flies druids there"] = "{area:2361}的{npc:11798}载德鲁伊飞往那里",
	-- ["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}：{npc:3033}的问候",
	-- ["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}：对它们使用{item:15826}；它们在{area:380}周围的平原上游荡",
	-- ["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797}在{area:392}码头外的港湾里游动。{npc:209797}是精英：建议组队。",
	-- ["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{area:272}的{npc:2391}教授毒药：留着它",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{area:272}的{npc:2391}教授{spell:2842}：留着它",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344}在{area:1638}训练圣骑士。你还没有那里的飞行路线：飞往{area:378}，向西骑马穿过{zone:1412}，乘升降梯上去，在中央高台的{npc:2995}处开通飞行路线。",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119}和他的水兵守着{npc:261366}南边被毁的商队。",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "{npc:262119}和他的水兵守着{npc:261366}南边被毁的商队。这些水兵会互相联动，拉到一个会引来其余敌人。从边缘引怪后拉开距离，它们脱战距离较短，可以逐个清理营地，再对付下士。",
	-- ["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}，在{npc:3341}与山脊之间的平原上",
	-- ["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341}在更南边通往{area:359}的道路旁的一个小营地里等候。",
	-- ["{npc:3341} waits in a small camp further south, on the road toward {area:359}; {npc:14242} sits up in the tree just east of him."] = "{npc:3341} 在更南面、通往 {area:359} 的道路旁的小营地里等候；{npc:14242} 坐在他东侧不远处的树上。",
	-- ["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389}站在{area:380}正西的科卡尔哨所。",
	-- ["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394}站在{npc:3389}西北的科卡尔营地里。",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395}在{area:380}东南的{area:388}，在科卡尔半人马中间走动。",
	-- ["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396}率领着{area:387}西岸的科卡尔半人马，位于{npc:3389}南边。最后一次在{area:380}停留时把他的头颅交给{npc:3389}。",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401}站在{object:172960}。选中他并输入 /salute 来完成{quest:2460}。",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}. Before leaving town, learn Lockpicking and bring {item:5060}; practise before attempting the tower lockbox. Keep the {item:8051} supplied with {quest:2458}. Gallywix is elite, so arrange help or leave that optional part for later."] = "{npc:3401}位于{object:172960}。选中他并输入/salute，完成{quest:2460}。离城前先学会开锁并带上{item:5060}，前往塔顶保险箱前先练习开锁。保留{quest:2458}任务提供的{item:8051}。加里维克斯是精英，可先找帮手，或稍后再做这段自选任务。",
	-- ["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}：蛋在{area:390}，稍后进行",
	-- ["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}。留着它：交给{area:1703}的卡德拉克，见下一个指南",
	-- ["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{quest:4921}交还后，{npc:3432}会提供{quest:95774}",
	-- ["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}，在双足飞龙管理员旁边。留着它：{quest:1483}在石爪山脉，稍后进行",
	-- ["{npc:3446}, beside the {object:3972} poster"] = "{npc:3446}，在{object:3972}告示旁边",
	-- ["{npc:3453}, on the dock"] = "{npc:3453}，在码头上",
	-- ["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465}被锁在要塞里。和他交谈开始护送，并紧跟着他：出去的路上会有塞拉摩士兵袭击。他会和你一起走回{area:392}。",
	-- ["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197}住在{area:2539}，那是从{npc:3389}处向西的道路尽头、刚进入石爪山脉的巨魔村庄。",
	-- ["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875}站在{object:172960}。在那里的召唤法阵上使用{item:6626}，击败魅魔来束缚她。",
	-- ["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878}在{area:380}东边的路旁扎营。",
	-- ["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}，就在{npc:3341}西边",
	-- ["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901}在{area:392}南边的山上等候，就在你北上的路上。",
	-- ["{npc:5909}, a few steps away"] = "{npc:5909}，就在几步之外",
	-- ["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018}站在城西侧的{object:172961}。",
	-- ["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}：{zone:1458}的{npc:4606}，见后面第二个指南",
	-- ["{object:3646}; below ground"] = "{object:3646}：在地下",
	-- ["{object:3972} poster"] = "{object:3972}告示",
	-- ["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}：{npc:7233}，在{area:382}旁",
	-- ["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}是一只大型赤鳞迅猛龙，在从{area:392}到{area:380}的道路北边的平原上捕猎。",
}
