-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Azshara
	-- {zone:1447} Azshara
	["Into {zone:1447}"] = "进入{zone:1447}",
	-- {area:415} Astranaar · {area:2358} Forest Song · {zone:1447} Azshara · {area:1235} Shadowsong Shrine
	["From {area:415}, ride east along the road past {area:2358} into {zone:1447}: {area:1235} lies just over the border, in {zone:1447}'s south-west corner."] = "从{area:415}沿道路向东，经过{area:2358}进入{zone:1447}：{area:1235}就在边界另一侧，位于{zone:1447}西南角。",
	-- {area:1235} Shadowsong Shrine
	["East along the road to {area:1235}"] = "沿道路向东前往{area:1235}",

	-- Step 2: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "神殿位于{zone:1447}西南角，{area:3137}南边。",

	-- Step 3: Talrendis Point
	-- {npc:239822} Commander Truesong · {npc:240482} Berdun Cliffbrew · {area:3137} Talrendis Point
	["Just north-east of the shrine: {npc:239822} and {npc:240482} keep the Alliance camp at {area:3137}."] = "神殿东北方不远处：{npc:239822}和{npc:240482}驻守在{area:3137}的联盟营地。",

	-- Step 4: Shadowsong Shrine spirits
	-- {area:1235} Shadowsong Shrine
	["{area:1235} spirits"] = "",
	-- {area:3137} Talrendis Point · {area:1235} Shadowsong Shrine
	-- plural, as words: Highborne Apparitions = {npc:6116} Highborne Apparition
	["Ride south-west from {area:3137}. Kill the Highborne Apparitions and Lichlings in the ruins around {area:1235}."] = "",

	-- Step 5: Mosshoof Runners
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Mosshoof Runners"] = "苔蹄奔跑者",
	-- {area:3137} Talrendis Point
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["The Mosshoof Runners (45-47) graze the hills north of {area:3137}, on the way to the satyrs."] = "苔蹄奔跑者（45-47级）在{area:3137}北边的山丘上活动，正好在前往萨特的路上。",

	-- Step 6: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "{zone:1447}：沿途击杀以下目标",
	-- {npc:222478} Sentinel Keldara Sunblade
	["The Haldarr satyrs hold the camp north of the shrine. {npc:222478} is held in their camp: free her and walk her out."] = "",
	-- {npc:222478} Sentinel Keldara Sunblade
	["{npc:222478}, in the camp"] = "{npc:222478}，在营地中",
	["Help her escape the camp"] = "帮助她逃出营地",

	-- Step 7: The western shore
	["The western shore"] = "西海岸",
	-- plural, as words: Spitelash Warriors = {npc:6190} Spitelash Warrior
	["The Spitelash Warriors (46-47) and Screamers (47-48) hold the western shore north-east of the satyrs."] = "恶鞭战士（46-47级）和恶鞭尖啸者（47-48级）占据萨特营地东北方的西海岸。",

	-- Step 8: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back south-west to {area:3137}."] = "向西南返回{area:3137}。",
	-- {npc:239822} Commander Truesong · {quest:88809} Preserving Eldarath
	["{npc:239822}: {quest:88809}, the relics drop from the naga of the top-up ahead"] = "{npc:239822}：{quest:88809}，遗物由接下来补经验时击杀的纳迦掉落",
	-- {npc:239822} Commander Truesong · {quest:92345} Beneath Nordrassil · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus
	["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, keep it"] = "{npc:239822}：{quest:92345}，给{zone:1457}的{npc:4217}的任务，留着",

	-- Step 12: Wild honey
	["Wild honey"] = "",
	-- {npc:240482} Berdun Cliffbrew · {item:238501} Pellet Gun · {item:238503} Wild Honey · {area:1237} Valormok
	-- plural, as words: Honey Wasps = {npc:236028} Honey Wasp
	["Shoot a nest with {npc:240482}'s {item:238501}, then loot the Honey Wasps for {item:238503}. Work north through the trees toward Eldarath, away from {area:1237}."] = "",

	-- Step 14: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "从神殿向东北骑行：{npc:8405}在道路上方山丘中的{area:1224}扎营。",

	-- Step 15: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "先下坐骑再与{npc:8395}交谈：他会将你传送到营地上方悬崖上的{npc:8379}之塔。",

	-- Step 16: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "塔顶的学徒会把你送回下面。",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "血精灵在前往{npc:8420}途中的{area:1220}",

	-- Step 17: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s runes stand among the ruins: use his {item:10445} on each. The naga here are the ones the top-up below asks for, so these kills count towards it."] = "{area:1221}的恶鞭纳迦携带{item:13815}。{npc:8507}的符文立在废墟中：对每个使用他的{item:10445}。这里的纳迦正是下面补经验步骤要刷的目标，击杀数会计入。",

	-- Step 18: Level 51.3 on the way north
	["Level 51.3 on the way north"] = "北上途中升到51.3级",
	-- {npc:8395} Sanath Lim-yo · {npc:8420} Kim'jael · {area:1417} Sunken Temple
	-- plural, as words: Spitelash Myrmidons = {npc:6196} Spitelash Myrmidon
	["Top up to level 51.3 on the Spitelash Myrmidons (50-51) of the ruins between {npc:8395}'s camp and the north: the blood elves at {npc:8420}'s camp are 51-53. Or, with a group, run the {area:1417} dungeon instead."] = "在{npc:8395}营地与北部之间的废墟刷恶鞭侍从（50-51级），补到51.3级：{npc:8420}营地的血精灵是51-53级。也可以组队去{area:1417}地下城。",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "反复击杀{npc:6196}补足经验",

	-- Step 19: Lord Sarthiss
	-- {npc:239939} Lord Sarthiss
	-- plural, as words: Eldarath Relics = {item:280608} Eldarath Relic
	["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "无论是否在补经验，这片废墟的恶鞭纳迦都会掉落埃达拉斯圣物。{npc:239939}（52级）站在埃达拉斯废墟中，恶鞭侍从的西南方：单独把他拉出来。",

	-- Step 20: Ekkal
	-- {npc:235903} Ekkal · {npc:8420} Kim'jael
	["{npc:235903} camps by the road north to {npc:8420}: his satyrs are in {npc:8420}'s camp."] = "{npc:235903}在北上通往{npc:8420}的路旁扎营：他要的萨特在{npc:8420}的营地里。",

	-- Step 21: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "苔蹄快步者",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "最近的苔蹄快步者在{area:1224}东北方的山丘上吃草，朝{area:1219}方向；更大的一群在南边的开阔地游荡。\n注意：苔蹄快步者是52-53级，比你高一两级：从兽群边缘一只一只地拉。",

	-- Step 24: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp · {npc:6647} Magister Hawkhelm · {npc:235903} Ekkal
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor · Legashi Soulstealers = {npc:236867} Legashi Soulstealer
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him.\nCareful: the Blood Elf Surveyors are 51-52 and the Reclaimers 52-53, with {npc:6647} (53) among them: take the equipment from the camp's edge and pull the elves one at a time.\n{npc:235903}'s satyrs, rogues and hellcallers (51-53) are the Legashi around {npc:8420}'s camp; the Legashi Soulstealers, Hellraisers and Blackguards (53) further east are not part of it: stay west of them."] = "{npc:8420}在北部的{area:1219}扎营；他的装备散落在他东南方不远处的{area:1220}各处。\n注意：血精灵勘测员是51-52级，回收者是52-53级，其中还有{npc:6647}（53级）：从营地边缘拿装备，一只一只地拉血精灵。\n{npc:235903}要的萨特、盗贼和召狱者（51-53级）是{npc:8420}营地周围的莱加希；更东边的莱加希窃魂者、地狱召唤者和黑衣卫士（53级）不算在内：待在它们西边。",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "{item:20028}，击杀血精灵勘测员和血精灵搜寻者获得",

	-- Step 27: Ekkal
	-- {npc:235903} Ekkal
	["On the road back south, {npc:235903} takes the satyrs."] = "南返途中，把萨特交给{npc:235903}。",

	-- Step 28: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}：{npc:7864}，约10%",

	-- Step 29: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "向西骑行返回{npc:8395}的营地，先下坐骑：他会再次把人传送到克希雷姆那里。",

	-- Step 31: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "{area:1223}",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "恶鞭海妖在{npc:8395}南面、{area:1223}周围的废墟和海滩上游荡。只有海妖掉落珊瑚，恶鞭尖啸者不掉。",

	-- Step 32: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "通过{npc:8395}的传送再次上去。",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "克希雷姆的最后一个任务 “毁灭摩弗拉斯” 要去{area:1417}：跳过。",

	-- Step 34: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "游到{zone:1447}南端外的小岛。如果{npc:8392}不在那里，就发射你的{item:10444}向他发出信号，然后等他降落。",

	-- Step 35: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back to Truesong at {area:3137} before you hearth."] = "用炉石前先回{area:3137}找真歌指挥官。",

	-- Step 37: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "前往{zone:1455}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "你的炉石绑定在{zone:1455}（{zone:1425}指南会把它绑在那里）：用炉石回到旅店。",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "{zone:1455}旅店",

	-- Step 39: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "阿克瑟努斯站在{object:171709}中麦格尼国王旁边。",

	-- Step 40: Royal Historian Archesonus
	-- {quest:3701} The Smoldering Ruins of Thaurissan · {npc:8978} Thauris Balgarr · {zone:1428} Burning Steppes
	-- plural, as words: War Reavers = {npc:7039} War Reaver
	["{quest:3701} is a group quest at this level: its relics stand among War Reavers and Firewalkers of 53-55, with {npc:8978} (57) close by, two to five over you, and the route has no later {zone:1428} visit. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:3701}在这个等级是小队任务：圣物位于53-55级的战争掠夺者和驭火者之间，附近还有{npc:8978}（57级），比你高二到五级，且路线之后不会再来{zone:1428}。建议寻找其他玩家组队完成。独自一人时可跳过。",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "圣物在{zone:1428}：留着",

	-- Step 41: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "飞往{area:348}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飞行管理员",

	-- Step 42: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飞往{area:271}",

	-- Step 43: The Super Snapper FX
	-- {npc:7977} Gammerita · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:7977}（48 级精英）需要 2 人小队。独自一人时可跳过，路线会安排刷怪补回经验。\n{npc:7977}在{area:307}下方的{zone:1425}海岸巡游，从箭头处向南约到75,66，向北约到82,52：如果她不在箭头处，就沿海岸寻找。",

	-- Step 44: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "{area:348}的飞行管理员",

	-- Step 45: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria · {npc:266524} Lieutenant Connar · {area:1438} Nethergarde Keep
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them. Her quest goes to {npc:266524} in {area:1438}, where this guide flies later."] = "从{area:271}向北骑进奥特兰克，再向西到{area:279}的城墙：{npc:34365}站在墙外。她的任务交给{area:1438}的{npc:266524}，本指南之后会飞到那里。",

	-- Step 46: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "从{area:271}沿路骑马向北，穿过奥特兰克前往{area:3197}。",

	-- Step 47: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "{npc:10838}站在营地中央。",

	-- Step 48: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}：沿途击杀以下目标",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "骷髅剥皮者和被奴役的食尸鬼在营地北侧田野活动，这里的天灾亡灵都会掉落天灾石。\n注意：这些亡灵的警戒距离很远，拉到一只时，周围亡灵也会参战。\n注意：{npc:10411}有三个刷新点，每 15 分钟刷新一次，非战斗时会隐形，开战后召唤石翼石像鬼。",

	-- Step 49: Chillwind Camp
	["Ride back south to the camp."] = "向南骑回营地。",
	-- {area:199} Felstone Field · {zone:1452} Winterspring
	["keep it: the {area:199} cauldron waits for the {zone:1452} guide's Chillwind stop, at about 55"] = "留着：{area:199}的大锅留到{zone:1452}指南约55级时的冰风岗停留点",

	-- Step 50: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "飞往{area:2418}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "{area:3197}的飞行管理员",

	-- Step 51: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "飞往{area:69}",

	-- Step 52: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "{area:2418}的飞行管理员",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "从{area:69}向东骑出，沿山口上行进入{zone:1428}：{area:2418}就在山顶。",

	-- Step 53: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "{area:2418}位于燃烧平原东南部，从赤脊山上来的山口顶端。",

	-- Step 54: Level 52 at Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Level 52 at {area:249}"] = "在{area:249}升到52级",
	-- {area:249} Dreadmaul Rock · {area:1417} Sunken Temple
	-- plural, as words: Firegut Ogres = {npc:7033} Firegut Ogre
	["Top up first to level 52 on the Firegut Ogres (50-51) on the near side of {area:249}, north of the Vigil: the Brutes on its east side are 52-53. Or, with a group, run the {area:1417} dungeon instead."] = "先在守望堡北边、{area:249}近侧刷火腹食人魔（50-51级）补到52级：东侧的蛮兵是52-53级。也可以组队去{area:1417}地下城。",
	-- {npc:7033} Firegut Ogre
	["grind on {npc:7033}"] = "反复击杀{npc:7033}补足经验",

	-- Step 55: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	-- plural, as words: Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "火腹食人魔占据守望堡北边的巨石，火腹蛮兵在巨石东侧。\n小心：逃脱的熔火恶犬（60级）在燃烧平原游荡，有几只在{area:249}西边和南边的山坡上：就在巨石上拉食人魔，每次拉怪前先观察四周。",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "{npc:7034}：在地下",

	-- Step 56: Morgan's Vigil
	-- {npc:9177} Oralius · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain
	-- plural, as words: Blackrock Medallions = {item:11467} Blackrock Medallion
	["{npc:9177}' next tasks ({npc:9176}, and fifty Blackrock Medallions) send you among the Blackrock orcs of 55-58 at the foot of {area:254}: skip them."] = "{npc:9177}的后续任务（{npc:9176}和五十枚黑石奖章）会把你送到{area:254}山脚下55-58级的黑石兽人之中：跳过。",

	-- Step 57: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "沿道路向西，然后向北爬到{area:251}上的地精营地。",

	-- Step 58: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}：沿途击杀以下目标",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "在{area:251}东侧山坡，将{npc:7047}打到濒死时对它使用{item:12284}，再拾取留下的精华。\n注意：一只{npc:8981}（56级，稀有）在小龙附近的山坡上走动，周围的{npc:7040}和龙人都是精英：在边缘对一只小龙使用龙灵采集器，每次拉怪前先观察四周。",

	-- Step 59: Ruins of Thaurissan
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {npc:8978} Thauris Balgarr · {object:147516} Dark Iron
	-- plural, as words: War Reavers = {npc:7039} War Reaver · Thaurissan Firewalkers = {npc:7037} Thaurissan Firewalker
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered. Take the ones on the ruins' southern edge, nearest {area:251}.\nCareful: the ruins' War Reavers and Thaurissan Firewalkers are 53-55, and {npc:8978} (57) holds the {object:147516} camp south-west of {area:251}: take the relics at the edge of the ruins, pull one at a time, and keep away from the camp."] = "遗物是散落于{area:251}周围{area:250}的雕刻石块，反复点击直到取回信息。去拿废墟南缘、最靠近{area:251}的那些。\n注意：废墟中的战争掠夺者和索瑞森驭火者是53-55级，{npc:8978}（57级）守着{area:251}西南的{object:147516}营地：在废墟边缘拿遗物，一只一只地拉，远离营地。",

	-- Step 60: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "在{zone:1452}{area:2255}的{quest:4808}处结束：留着",

	-- Step 61: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "打开来自{zone:1427}的{item:10569}，取出其中的{item:10575}，然后告诉{npc:9459}你带来了功绩的证明：无需与幼龙战斗。",
	["Below ground"] = "在地下",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}：从宝藏中获取",

	-- Step 63: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:9461}是 54 级精英，多数职业到 56 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 65: Level 52.08
	["Level 52.08"] = "等级 52.08",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon instead."] = "如果跳过了{quest:4022}，就在这里刷到52.08级，以跟上路线进度。也可以组队去{area:1417}地下城。",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "反复击杀{npc:9690}补足经验",

	-- Step 66: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "沿道路向东骑回守望堡。",

	-- Step 67: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "飞往{area:1438}",

	-- Step 68: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "阿尔达兰在{area:1438}里面。",
	-- {npc:3546} Bernie Heisten · {quest:87295} Deflective Surface
	["{npc:3546}: {quest:87295}, the scales come from the basilisks ahead"] = "{npc:3546}：{quest:87295}，鳞片来自前方的蜥蜴",

	-- Step 69: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "向北骑出{zone:1419}，进入{zone:1435}：{npc:10996}站在从{zone:1419}过来的道路旁。远离东北方的部落城镇{area:75}。",

	-- Step 70: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "听完他的故事后，向南骑回库米沙处。",

	-- Step 71: Back to the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Back to the {zone:1419}"] = "返回{zone:1419}",
	["Bloodmages' camp"] = "血法师营地",

	-- Step 72: The bloodmages
	["The bloodmages"] = "血法师",
	["Drazial and Lynnore stand together by the road. Take any beast requests they still offer before riding south."] = "",

	-- Step 73: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419}：沿途击杀以下目标",
	-- {zone:1419} Blasted Lands · {npc:5982} Black Slayer · {npc:221740} Calefactus the Unleashed · {npc:247015} Vek'zol
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk
	["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "向南骑回{zone:1419}，为血法师收集野兽材料：饥饿的弯牙土狼在血法师营地南边的干燥山丘上游荡，厚甲毒刺蝎在北部中央一带爬行，{npc:5982}秃鹫在整片区域上空盘旋。灰鬃野猪和红石蜥蜴分布在城堡西南的山坡上。\n注意：这里有两个精英游荡：{npc:221740}（50级）在地区中部约44,34一带，{npc:247015}（55级）在约39,32的山脊上。看到它们就换个地方打。",

	-- Step 75: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have. Come at her hill straight from the keep, along the road, and leave by the same way.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32), and the Dreadmaul and Shadowsworn camps around it are 53-55: take the fragments from the mobs on the way from the keep, not beside him."] = "收藏家库米沙在城堡西南侧山丘的{area:2517}等候。沿途{zone:1419}的怪物会掉落不完美的德莱尼水晶碎片，将收集到的交给她。从城堡沿道路直接前往她的山丘，再原路返回。\n注意：费尔库拉、{npc:7664}和伊利法尔都是60级精英。污染者拉瑟莱克会施放{spell:2691}、{spell:8255}和屠杀；生命值降低后还会陆续使用{object:141891}、{spell:10854}，并在15%时激怒。\n注意：55级精英{npc:247015}站在库米沙的山丘旁（约50,35）以及西边（约39,32），周围的恐槌和暗誓营地怪物为53-55级：在从城堡过来的路上从怪物身上拿碎片，别在他旁边打。",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "{npc:7363}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 76: The bloodmages
	-- {zone:1419} Blasted Lands
	["Ride north to the bloodmages' camp beside the road into the {zone:1419}."] = "向北骑到通往{zone:1419}的道路旁的血法师营地。",
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "血法师的第二阶段用增益物品而不是经验来交换同样的材料：跳过。",

	-- Step 77: Bernie Heisten
	-- {npc:3546} Bernie Heisten · {area:1438} Nethergarde Keep
	["Back to {npc:3546} in {area:1438} before you hearth."] = "使用炉石前，先回到{area:1438}的{npc:3546}处。",

	-- Step 78: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "用炉石返回{zone:1455}的旅店。",

	-- Step 79: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "飞往{area:144}",

	-- Step 82: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飞往{area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144}的飞行管理员",

	-- Step 85: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "阿克瑟努斯站在{object:171709}中麦格尼国王旁边：你在燃烧平原阅读的圣物都是他要的。",

	-- Step 86: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飞往{area:150}",

	-- Step 88: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "飞往{area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}的飞行管理员",

	-- Step 89: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "枭兽在{zone:1452}：留着",

	-- Step 92: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "{area:702}的传送门通往{zone:1457}：{npc:9047}在城市北部的{area:1658}等候。",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}：在{area:1658}",
	-- {zone:1455} Ironforge
	["{zone:1455} has no druid trainer"] = "{zone:1455}没有德鲁伊训练师",

	-- Step 93: Mathrengyl Bearwalker
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["{npc:4217} is upstairs in the druids' building of the {area:1658}: go in by its south door."] = "{npc:4217}在{area:1658}德鲁伊建筑的楼上：从南门进入。",
	-- {npc:4217} Mathrengyl Bearwalker
	["{npc:4217}, upstairs"] = "{npc:4217}：在楼上",

	-- Step 94: Astarii Starseeker
	-- {npc:7740} Gracina Spiritmight · {quest:3378} Prayer to Elune · {npc:4090} Astarii Starseeker
	["On the way to {npc:7740}, give the {quest:3378} to {npc:4090} in the Temple of the Moon."] = "",

	-- Step 95: Gracina Spiritmight
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740} stands beside Tyrande in the Temple of the Moon, in the south of the city."] = "{npc:7740}站在城市南部月神殿里的泰兰德身旁。",
	-- {npc:7740} Gracina Spiritmight · {quest:162} Rise of the Silithid · {area:976} Gadgetzan
	["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}：{quest:162}，来自{area:976}",
	-- {npc:5594} Alchemist Pestlezugg · {area:976} Gadgetzan · {zone:1422} Western Plaguelands
	["For {npc:5594} in {area:976}, on the {zone:1422} guide: keep it"] = "交给{area:976}的{npc:5594}（{zone:1422}指南）：先留着",

	-- Step 96: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "通往{zone:1438}的传送门",

	-- Step 97: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}在楼上，就在{npc:7916}上方：从室内上楼，箭头无法区分楼层。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {zone:1438}"] = "返回{zone:1438}",
	-- ["Class trainer"] = "职业训练师",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "爬回废墟上方{area:1224}的{npc:8405}处。",
	-- ["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "爬到{area:249}顶端，把头颅插在松软的土堆上。",
	-- ["Druid training"] = "德鲁伊训练",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "从{zone:1455}飞往{area:150}，乘船前往{area:442}。",
	-- ["Fly from {zone:1455} to {area:69}."] = "从{zone:1455}飞往{area:69}。",
	-- ["Fly to {area:1438}."] = "飞往{area:1438}。",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "飞往{area:150}，乘船前往{area:442}，再乘船前往{area:702}。",
	-- ["For {zone:1453}: keep it"] = "交给{zone:1453}：先留着",
	-- ["From the {area:442} dock, fly to {area:415}."] = "从{area:442}码头飞往{area:415}。",
	-- ["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32): take the fragments from the mobs on the way from the keep, not beside him."] = "收藏家库米沙在城堡西南侧山丘的{area:2517}等候。沿途{zone:1419}的怪物会掉落不完美的德莱尼水晶碎片，将收集到的交给她。\n注意：费尔库拉、{npc:7664}和伊利法尔都是 60 级精英。污染者拉瑟莱克会施放{spell:2691}、{spell:8255}和屠杀；生命值降低后还会陆续使用{object:141891}、{spell:10854}，并在 15% 时激怒。\n注意：55级精英{npc:247015}站在库米沙的山丘旁（约50,35）以及西边（约39,32）：在从城堡过来的路上从怪物身上拿碎片，别在他旁边打。",
	-- ["Level 52"] = "等级 52",
	-- ["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "可选：{npc:8395}要两根完好无损的角鹰兽羽毛，从他营地周围的角鹰兽身上获取。数据显示这个任务没有经验。",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "可选：{npc:8888}的鬼魂站在{area:254}内巨型锁链上他的墓上，只有死者能看见他。如果你反正在山附近死了，复活前让灵魂跑去找他。",
	-- ["Priests and Mages trained here at the end of the Un'Goro guide"] = "牧师和法师已在安戈洛指南的结尾于此处训练过",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "在{area:251}西南方废墟中的{object:147516}营地阅读石板，抄写文本。",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "骑回{area:1438}，飞往{area:348}。枭兽羽毛散落在{area:348}南边和东边的{zone:1425}地上，枭兽在那里游荡；这里的怪物现在比你低很多。",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "沿道路向东离开{zone:1440}进入{zone:1447}，前往{area:3137}的哨兵营地。",
	-- ["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east. Listen to his tale, then ride back south to Kum'isha."] = "向北骑出{zone:1419}，进入{zone:1435}：{npc:10996}站在从{zone:1419}过来的道路旁。远离东北方的部落城镇{area:75}。听完他的故事后，向南骑回库米沙处。",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "从{area:69}向北穿过山口进入{zone:1428}；{area:2418}在山口顶端，位于燃烧平原东南部。",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "游到{area:16}南端外的小岛：{npc:8392}在纪念碑旁等候。",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "游到{zone:1447}南端外的小岛：{npc:8392}在雕像旁等候。",
	-- ["Thaurissan Relics"] = "索瑞森遗物",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "上层精灵的鬼魂在神殿周围的废墟中游荡；哈达尔萨特占据神殿北边不远的营地。",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it. {npc:222478} is held in the satyrs' camp: free her and walk her out."] = "上层精灵的鬼魂在神殿周围的废墟中游荡；哈达尔萨特占据神殿北边不远的营地。{npc:222478}被关押在萨特营地中：解救她并护送她出去。",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}的恶鞭纳迦携带{item:13815}。{npc:8507}的四个符文立在废墟中：对每个使用他的{item:10445}。",
	-- ["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "枭兽羽毛散落于{zone:1425}各处地面，主要在{area:348}以南和以东的枭兽活动区域。这里怪物的等级现在远低于你。",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "最近的苔蹄快步者在{area:1224}东北方的山丘上吃草，朝{area:1219}方向；更大的一群在南边的开阔地游荡。",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "遗物是散布在{area:251}周围{area:250}中的雕刻石块：点击它们直到收集完信息。",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "遗物是散落于{area:251}周围{area:250}的雕刻石块，反复点击直到取回信息。\n阅读{area:251}西南侧废墟中、{object:147516}营地里的石板，抄录内容。\n在{area:251}东侧山坡，将{npc:7047}打到濒死时对它使用{item:12284}，再拾取留下的精华。\n注意：一只{npc:8981}（56级，稀有）在小龙附近的山坡上走动，周围的{npc:7040}和龙人都是精英：在边缘对一只小龙使用龙灵采集器，每次拉怪前先观察四周。",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "神殿位于{area:16}西南角，{area:3137}南边。",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:7977}（48 级精英）需要 2 人小队。独自一人时可跳过，路线会安排刷怪补回经验。",
	-- ["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon instead."] = "前往{area:251}途中，在这里刷{area:249}的食人魔补到52级：交完那里的任务会升到53级。也可以组队去{area:1417}地下城。",
	-- ["Upstairs"] = "在楼上",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "在{area:251}东边山坡上的{npc:7047}快死时对它使用{item:12284}，然后拾取它留下的精华。",
	-- ["Wildkin feathers"] = "枭兽羽毛",
	-- ["grind on {npc:6375}"] = "反复击杀{npc:6375}补足经验",
	-- ["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "刷{npc:7033}升级：{npc:9177}从51级起提供{quest:4283}",
	-- ["grind on {npc:7034}"] = "反复击杀{npc:7034}补足经验",
	-- ["{area:199} cauldron"] = "{area:199}的大锅",
	-- ["{item:11467}; inside"] = "{item:11467}：在屋内",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西边、{area:199}的农舍旁游荡；她的包裹在屋里。",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守卫着安多哈尔西边{area:199}的大锅。",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}在城堡西南方的山丘{area:2517}等候。沿途的{zone:1419}怪物掉落不完美的德莱尼水晶碎片；把你有的都交给她。",
	-- ["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395}要两根完好无损的角鹰兽羽毛，从他营地周围的雷首角鹰兽身上获取，也就是你在这里补经验的那些：大约三只中有一只携带。",
	-- ["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420}在北部的{area:1219}扎营；他的设备散落在他东南边不远的{area:1220}各处。",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176}和黑石兽人占据{area:251}西边、{area:254}脚下的营地和要塞。一次拉一个；每个兽人和座狼都可能掉落奖章，杀到凑够五十个为止。",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176}和黑石兽人占据{area:251}以西、{area:254}山脚的营地与要塞。逐个拉怪，所有兽人和座狼均有几率掉落勋章，持续击杀直到收集五十枚。\n注意：{npc:9176}有一名联动守卫，会一同参战；附近还有第二名士兵巡逻，拉怪前先清理巡逻者。\n注意：Firesworn是60级的火元素，在燃烧平原上游荡，其中一些在黑石营地之间：每次拉怪前先看看，让它们走过去。",
	-- ["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}：黑石兽人掉落奖章，在整个燃烧平原期间保持此任务",
	-- ["{object:175894}, inside"] = "{object:175894}：在屋内",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455}没有德鲁伊训练师：乘传送门上到{zone:1457}，在{area:1658}训练，然后回到{area:702}。",
}
