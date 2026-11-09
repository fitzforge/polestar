-- Chinese (simplified) (zhCN): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "神殿位于{zone:1447}西南角，{area:3137}南边。",

	-- Step 2: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "{zone:1447}：沿途击杀以下目标",
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "上层精灵的鬼魂在神殿周围的废墟中游荡；哈达尔萨特占据神殿北边不远的营地。",

	-- Step 5: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "从神殿向东北骑行：{npc:8405}在道路上方山丘中的{area:1224}扎营。",

	-- Step 6: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "苔蹄快步者",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "最近的苔蹄快步者在{area:1224}东北方的山丘上吃草，朝{area:1219}方向；更大的一群在南边的开阔地游荡。",

	-- Step 9: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "可选：{npc:8395}要两根完好无损的角鹰兽羽毛，从他营地周围的角鹰兽身上获取。数据显示这个任务没有经验。",
	-- {npc:6375} Thunderhead Hippogryph
	["grind on {npc:6375}"] = "反复击杀{npc:6375}补足经验",

	-- Step 10: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "",

	-- Step 11: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "",

	-- Step 12: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420}在北部的{area:1219}扎营；他的设备散落在他东南边不远的{area:1220}各处。",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "",
	-- {npc:6196} Spitelash Myrmidon
	["grind on {npc:6196}"] = "反复击杀{npc:6196}补足经验",

	-- Step 13: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {npc:8507} Tymor · {item:10445} Drawing Kit
	["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}的恶鞭纳迦携带{item:13815}。{npc:8507}的四个符文立在废墟中：对每个使用他的{item:10445}。",

	-- Step 17: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}：{npc:7864}，约10%",

	-- Step 18: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 20: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "",

	-- Step 21: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "",

	-- Step 23: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter
	["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "游到{zone:1447}南端外的小岛：{npc:8392}在雕像旁等候。",

	-- Step 24: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "前往{area:2101}",

	-- Step 25: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飞往{area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144}的飞行管理员",

	-- Step 27: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "阿克瑟努斯站在{object:171709}中麦格尼国王旁边。",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "圣物在{zone:1428}：留着",

	-- Step 28: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "飞往{area:348}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飞行管理员",

	-- Step 29: Wildkin feathers
	["Wildkin feathers"] = "枭兽羽毛",
	-- {zone:1425} Hinterlands · {area:348} Aerie Peak
	-- plural, as words: Wildkin Feathers = {item:10819} Wildkin Feather
	["The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "枭兽羽毛散落于{zone:1425}各处地面，主要在{area:348}以南和以东的枭兽活动区域。这里怪物的等级现在远低于你。",

	-- Step 30: The Super Snapper FX
	-- {npc:7977} Gammerita
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:7977}（48 级精英）需要 2 人小队。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 32: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飞往{area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "{area:348}的飞行管理员",

	-- Step 33: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "从{area:271}沿路骑马向北，穿过奥特兰克前往{area:3197}。",

	-- Step 34: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "{npc:10838}站在营地中央。",

	-- Step 35: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}：沿途击杀以下目标",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "骷髅剥皮者和被奴役的食尸鬼在营地北侧田野活动，这里的天灾亡灵都会掉落天灾石。\n注意：这些亡灵的警戒距离很远，拉到一只时，周围亡灵也会参战。\n注意：{npc:10411}有三个刷新点，每 15 分钟刷新一次，非战斗时会隐形，开战后召唤石翼石像鬼。",

	-- Step 36: Chillwind Camp
	["Ride back south to the camp."] = "向南骑回营地。",

	-- Step 37: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西边、{area:199}的农舍旁游荡；她的包裹在屋里。",
	["Upstairs"] = "在楼上",
	-- {object:175894} Janice's Parcel
	["{object:175894}, inside"] = "{object:175894}：在屋内",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "交给{zone:1453}：先留着",

	-- Step 38: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "{area:199}的大锅",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守卫着安多哈尔西边{area:199}的大锅。",

	-- Step 40: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "飞往{area:2418}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "{area:3197}的飞行管理员",

	-- Step 41: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "{area:2418}位于燃烧平原东南部，从赤脊山上来的山口顶端。",

	-- Step 42: Dreadmaul Rock
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side."] = "火腹食人魔占据守望堡北边的巨石，火腹蛮兵在巨石东侧。",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "{npc:7034}：在地下",
	-- {npc:7033} Firegut Ogre · {npc:9177} Oralius · {quest:4283} FIFTY! YEP!
	["grind on {npc:7033}: {npc:9177} gives {quest:4283} from level 51"] = "刷{npc:7033}升级：{npc:9177}从51级起提供{quest:4283}",

	-- Step 43: Morgan's Vigil
	-- {npc:9177} Oralius
	["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}：黑石兽人掉落奖章，在整个燃烧平原期间保持此任务",

	-- Step 44: Level 52
	["Level 52"] = "等级 52",
	-- {area:249} Dreadmaul Rock · {area:251} Flame Crest · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Top up here to level 52 on the ogres of {area:249}, on the way to {area:251}: the hand-ins there take you to level 53. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "前往{area:251}途中，在这里刷{area:249}的食人魔补到52级：交完那里的任务会升到53级。也可以组队去{area:1417}副本或{area:2100}副本。",
	-- {npc:7034} Firegut Ogre Mage
	["grind on {npc:7034}"] = "反复击杀{npc:7034}补足经验",

	-- Step 45: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "沿道路向西，然后向北爬到{area:251}上的地精营地。",

	-- Step 46: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}：沿途击杀以下目标",
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {object:147516} Dark Iron · {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered.\nRead the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript.\nUse the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "遗物是散落于{area:251}周围{area:250}的雕刻石块，反复点击直到取回信息。\n阅读{area:251}西南侧废墟中、{object:147516}营地里的石板，抄录内容。\n在{area:251}东侧山坡，将{npc:7047}打到濒死时对它使用{item:12284}，再拾取留下的精华。",

	-- Step 47: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "在{zone:1452}{area:2255}的{quest:4808}处结束：留着",

	-- Step 48: Cyrus Therepentous
	["Below ground"] = "在地下",

	-- Step 49: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "这些是精英敌人，建议寻找其他玩家组队完成。{npc:9461}是 54 级精英，多数职业到 56 级可以尝试单独击败，但可能仍需帮助。独自一人时可跳过，路线会安排刷怪补回经验。",

	-- Step 51: Level 52.08
	["Level 52.08"] = "等级 52.08",
	-- {quest:4022} A Taste of Flame · {area:1417} Sunken Temple · {area:2100} Maraudon
	["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "如果跳过了{quest:4022}，就在这里刷到52.08级，以跟上路线进度。也可以组队去{area:1417}副本或{area:2100}副本。",
	-- {npc:9690} Ember Worg
	["grind on {npc:9690}"] = "反复击杀{npc:9690}补足经验",

	-- Step 52: Blackrock Stronghold
	-- {npc:9176} Gor'tesh · {area:254} Blackrock Mountain · {area:251} Flame Crest
	["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling."] = "{npc:9176}和黑石兽人占据{area:251}以西、{area:254}山脚的营地与要塞。逐个拉怪，所有兽人和座狼均有几率掉落勋章，持续击杀直到收集五十枚。\n注意：{npc:9176}有一名联动守卫，会一同参战；附近还有第二名士兵巡逻，拉怪前先清理巡逻者。",
	-- {item:11467} Blackrock Medallion
	["{item:11467}; inside"] = "{item:11467}：在屋内",

	-- Step 53: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "沿道路向东骑回守望堡。",

	-- Step 54: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock
	["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "爬到{area:249}顶端，把头颅插在松软的土堆上。",

	-- Step 56: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "飞往{area:1438}",
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "{area:2418}的飞行管理员",

	-- Step 57: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear (no name in this language: may be words) · {spell:10854} Flames of Chaos
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%."] = "收藏家库米沙在城堡西南侧山丘的{area:2517}等候。沿途{zone:1419}的怪物会掉落不完美的德莱尼水晶碎片，将收集到的交给她。\n注意：费尔库拉、{npc:7664}和伊利法尔都是 60 级精英。污染者拉瑟莱克会施放{spell:2691}、{spell:8255}和屠杀；生命值降低后还会陆续使用{object:141891}、{spell:10854}，并在 15% 时激怒。",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "{npc:7363}在附近巡逻，请在地图标示的圆圈内寻找",

	-- Step 65: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飞往{area:150}",

	-- Step 67: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "飞往{area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}的飞行管理员",

	-- Step 68: Rut'theran Village
	-- {zone:1452} Winterspring
	["The wildkin are in {zone:1452}: keep it"] = "枭兽在{zone:1452}：留着",

	-- Step 69: Druid training
	["Druid training"] = "德鲁伊训练",
	-- {zone:1455} Ironforge · {zone:1457} Darnassus · {area:1658} Cenarion Enclave · {area:702} Rut'theran Village
	["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455}没有德鲁伊训练师：乘传送门上到{zone:1457}，在{area:1658}训练，然后回到{area:702}。",

	-- Step 70: Back to Teldrassil
	-- {zone:1438} Teldrassil
	["Back to {zone:1438}"] = "返回{zone:1438}",

	-- Step 71: Daryn Lightwind
	-- {npc:7907} Daryn Lightwind · {npc:7916} Erelas Ambersky
	["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}在楼上，就在{npc:7916}上方：从室内上楼，箭头无法区分楼层。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "爬回废墟上方{area:1224}的{npc:8405}处。",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "从{zone:1455}飞往{area:150}，乘船前往{area:442}。",
	-- ["Fly from {zone:1455} to {area:69}."] = "从{zone:1455}飞往{area:69}。",
	-- ["Fly to {area:1438}."] = "飞往{area:1438}。",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "飞往{area:150}，乘船前往{area:442}，再乘船前往{area:702}。",
	-- ["From the {area:442} dock, fly to {area:415}."] = "从{area:442}码头飞往{area:415}。",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "可选：{npc:8888}的鬼魂站在{area:254}内巨型锁链上他的墓上，只有死者能看见他。如果你反正在山附近死了，复活前让灵魂跑去找他。",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "在{area:251}西南方废墟中的{object:147516}营地阅读石板，抄写文本。",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "骑回{area:1438}，飞往{area:348}。枭兽羽毛散落在{area:348}南边和东边的{zone:1425}地上，枭兽在那里游荡；这里的怪物现在比你低很多。",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "沿道路向东离开{zone:1440}进入{zone:1447}，前往{area:3137}的哨兵营地。",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "从{area:69}向北穿过山口进入{zone:1428}；{area:2418}在山口顶端，位于燃烧平原东南部。",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "游到{area:16}南端外的小岛：{npc:8392}在纪念碑旁等候。",
	-- ["Thaurissan Relics"] = "索瑞森遗物",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "遗物是散布在{area:251}周围{area:250}中的雕刻石块：点击它们直到收集完信息。",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "神殿位于{area:16}西南角，{area:3137}南边。",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "在{area:251}东边山坡上的{npc:7047}快死时对它使用{item:12284}，然后拾取它留下的精华。",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}：上一份指南在这里绑定炉石，所以这一步通常会立即完成",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}在城堡西南方的山丘{area:2517}等候。沿途的{zone:1419}怪物掉落不完美的德莱尼水晶碎片；把你有的都交给她。",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty."] = "{npc:9176}和黑石兽人占据{area:251}西边、{area:254}脚下的营地和要塞。一次拉一个；每个兽人和座狼都可能掉落奖章，杀到凑够五十个为止。",
}
