-- Chinese (simplified) (zhCN): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Horde)"] = "{spell:71}和一把武器（部落）",
	-- {spell:71} Defensive Stance · {npc:5810} Uzzek · {area:159} Brill
	["{spell:71} at 10 and a one-hand weapon of your choice: {npc:5810}'s road, {area:159}'s crypt, or the Skybreaker shield."] = "10级时的{spell:71}和一把自选的单手武器：{npc:5810}的路线、{area:159}的墓穴，或破天者之盾。",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{area:16638}的{npc:252377}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "10级时，{npc:252377}与训练师们站在{area:16638}西门旁。教徒{npc:257196}在{area:16629}持有她家的盾牌。",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "从 {area:16638} 向西北前往 {area:16629}。{npc:257196} 站在神殿入口通路的西侧，周围是教团的守护者、唤灵者和剑圣：先逐个拉出来清掉，再对付他。他会掉落 {item:263993}。",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}，由{npc:257196}掉落",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:5810} Uzzek
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:5810}'s road below still gives a weapon later, once you reach Kalimdor."] = "回到{area:16638}找{npc:252377}。她会教你{spell:71}，并给你配套使用的盾牌{item:275290}。抵达卡利姆多后，沿下方{npc:5810}的任务路线继续，之后仍会获得武器。",

	-- Step 4: Veteran Uzzek (Razor Hill)
	-- {npc:3169} Tarshaw Jaggedscar · {area:362} Razor Hill · {npc:5810} Uzzek · {zone:1413} Barrens · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {zone:1420} Tirisfal Glades · {npc:2131} Austil de Mon · {area:159} Brill
	["At 10, {npc:3169}, the warrior trainer in the barracks of {area:362}, sends you to {npc:5810} in the {zone:1413}. Sorek in {zone:1454}'s {object:172958} offers it too. Any Horde warrior may take one of the two roads, never both: heading to {zone:1420} at 10 anyway? {npc:2131} in {area:159}'s inn offers the other: one fight by {area:159}'s graveyard for the same stance, then the Agamand crypt for an heirloom weapon."] = "10级时，{area:362}兵营里的战士训练师{npc:3169}会让你去找{zone:1413}的{npc:5810}。{zone:1454}的{object:172958}里的索瑞克也提供此任务。所有部落战士都可以选择两条路线之一，但不能两条都做：如果10级本来就要去{zone:1420}，{area:159}旅店里的{npc:2131}提供另一条路线：先在{area:159}墓地旁打一场，学会同样的姿态，再去阿加曼德墓穴取一把传家武器。",

	-- Step 5: Veteran Uzzek (Mulgore)
	-- {npc:3063} Krang Stonehoof · {area:222} Bloodhoof Village · {npc:5810} Uzzek · {zone:1413} Barrens · {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff
	["At 10, {npc:3063}, the warrior trainer of {area:222}, sends you to {npc:5810} in the {zone:1413}. {npc:3041} in {zone:1456} offers it too."] = "10级时，{area:222} 的战士训练师 {npc:3063} 会派你去找 {zone:1413} 的 {npc:5810}。{zone:1456} 的 {npc:3041} 也提供这个任务。",

	-- Step 6: Uzzek at Far Watch Post
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["{npc:5810} at {area:379}"] = "{area:379}的{npc:5810}",
	-- {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:5810} is easy to miss: he stands under a small canopy by a large tree just west of {area:379}, below the road's south side, with the post in sight to his east. Going straight south from the post does not lead to him. From {zone:1411} cross the bridge west; from {zone:1412} head north past the Crossroads."] = "{npc:5810} 很容易错过：他在 {area:379} 西边不远处的一棵大树旁，站在路南下方的小棚子里，向东能看见哨站。从哨站直接向南走找不到他。从 {zone:1411} 来就向西过桥；从 {zone:1412} 来则向北，经过十字路口。",

	-- Step 7: Singed Scales in Thunder Ridge
	-- {area:369} Thunder Ridge
	-- plural, as words: Singed Scales = {item:6486} Singed Scale
	["Singed Scales in {area:369}"] = "{area:369}的烧焦的鳞片",
	-- {area:369} Thunder Ridge · {zone:1411} Durotar · {zone:1454} Orgrimmar · {zone:1413} Barrens · {spell:5401} Lizard Bolt
	-- plural, as words: Singed Scales = {item:6486} Singed Scale · Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["You need five Singed Scales. Thunder Lizards (level 9-10) and Lightning Hides (10-11) live down in the {area:369} crevasse in north-west {zone:1411}, south of {zone:1454}: from the {zone:1413} bridge turn left and follow the river north into it. Both drop a scale about four kills in five; both cast {spell:5401}."] = "需要五片烧焦的鳞片。雷霆蜥蜴（9-10级）和闪电蜥蜴（10-11级）生活在{zone:1411}西北部、{zone:1454}以南的{area:369}裂谷底部：从{zone:1413}的桥过来后左转，沿河向北进入。两者掉鳞片的概率都约为五只出四片；两者都会施放{spell:5401}。",
	-- {item:6486} Singed Scale
	["{item:6486}, from the lizards"] = "{item:6486}，从蜥蜴身上获得",

	-- Step 8: Path of Defense
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["Back to {npc:5810} under his tree west of {area:379}."] = "回到 {area:379} 西边树下的 {npc:5810} 处。",

	-- Step 9: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads. Most slopes are too steep: climb the broad ridge on the north or east side."] = "{npc:5878} 的小屋在十字路口东侧的 {area:1699} 顶上。大多数山坡太陡：从北侧或东侧的宽阔山脊爬上去。",

	-- Step 10: Forged Steel
	-- {object:58369} Stolen Iron Chest · {npc:5878} Thun'grim Firegaze
	["The {object:58369} stands by a broken wagon in the Razormane camp north-west of {npc:5878}, north-east of the Crossroads. Two Razormanes guard it and their hunters pull more quilboar: clear them one at a time, then open the chest (it refills within seconds, so a friend can loot it too)."] = "{object:58369} 在 {npc:5878} 西北侧的钢鬃营地，靠着一辆损坏的货车，位于十字路口东北方。两名钢鬃野猪人守着箱子，猎手还会引来更多野猪人：逐只清掉，再开箱（箱内物品几秒内就会刷新，朋友也能拾取）。",
	-- {item:6534} Forged Steel Bars · {object:58369} Stolen Iron Chest
	["{item:6534}, from the {object:58369}"] = "{item:6534}，来自{object:58369}",

	-- Step 11: Speak with Dillinger
	-- {npc:2131} Austil de Mon · {area:159} Brill · {npc:1496} Deathguard Dillinger · {npc:5810} Uzzek · {quest:1505} Veteran Uzzek · {quest:1498} Path of Defense
	["At 10, {npc:2131}, the warrior trainer inside the inn of {area:159}, sends you to {npc:1496} by the graveyard on {area:159}'s west edge. This road and {npc:5810}'s exclude each other: drop {quest:1505} or {quest:1498} from your log if you hold one."] = "10级时，{area:159} 旅店内的战士训练师 {npc:2131} 会派你去找 {area:159} 西边缘墓地旁的 {npc:1496}。这条任务线与 {npc:5810} 的任务线互斥：如果任务日志里有 {quest:1505} 或 {quest:1498}，先放弃。",

	-- Step 12: Deathguard Dillinger
	-- {area:159} Brill · {quest:1818} Speak with Dillinger · {npc:2131} Austil de Mon · {npc:5810} Uzzek
	["Dillinger stands by the graveyard on {area:159}'s west edge. An Orc, Troll, Tauren or Skyborne who took {quest:1818} from {npc:2131} instead of {npc:5810}'s road is led through {area:159} from here."] = "亡灵卫兵迪林格尔站在 {area:159} 西边缘的墓地旁。如果兽人、巨魔、牛头人或天裔角色接受了 {npc:2131} 的 {quest:1818}，而非选择 {npc:5810} 的任务线，接下来就会从这里沿 {area:159} 的路线进行。",

	-- Step 13: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} sleeps in the mausoleum in the graveyard just north of Dillinger. To wake him, click the flat skull plaque on the ground, left of the path to the mausoleum door; the seal lifts and {npc:6390} (level 11, not elite) walks out. Start at full health."] = "{npc:6390} 沉睡在迪林格正北边墓地的陵墓内。要唤醒他，点击通往陵墓大门的小径左侧、地上的扁平骷髅石板；封印解除后，{npc:6390}（11 级，非精英）就会走出来。满血再开始。",

	-- Step 14: Coleman Farthing
	-- {npc:1500} Coleman Farthing · {area:2119} Gallows' End Tavern · {area:159} Brill
	["{npc:1500} is in the {area:2119}, the inn on {area:159}'s east side."] = "{npc:1500} 在 {area:159} 东边的旅店 {area:2119} 内。",

	-- Step 15: The Agamand Family Crypt
	-- {area:158} Agamand Family Crypt
	["The {area:158}"] = "{area:158}",
	-- {area:158} Agamand Family Crypt · {area:157} Agamand Mills · {area:159} Brill
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks are inside the {area:158} at the north end of {area:157}, north of {area:159}, one rack per room: one in the lowest room, two in the pair of rooms up the stairs, one in the room above those. The axe rack stands in a dark corner. The crypt's undead come in packs of three or more and return quickly; the ones in the top room are not linked. The axe, dagger and mace racks take 15 minutes to refill after someone loots them."] = "四个阿加曼德武器架位于 {area:159} 以北、{area:157} 北端的 {area:158} 内，每间房一个：最底层房间一个，上楼后的一对房间里各一个，再上一层的房间一个。斧架在一个阴暗角落。地穴中的亡灵每群至少三只，刷新很快；顶层房间的敌人不会一起参战。斧、匕首和锤的武器架被拾取后，需要15分钟才会补满。",

	-- Step 16: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "回到{npc:1500}那里",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "四个{object:105169}立在{area:159}北边{area:157}的建筑之间。磨坊里的亡灵见人就打。",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496}站在{area:159}。{npc:6390}在镇子北边山丘上的陵墓里等着：打开大门与他战斗。",
	-- ["{npc:1500} is in the inn, the {area:2119}, in {area:159}."] = "{npc:1500}在{area:159}的旅店{area:2119}里。",
	-- ["{spell:71} and a one-hand weapon of your choice at 10."] = "10级时的{spell:71}和一把自选的单手武器。",
}
