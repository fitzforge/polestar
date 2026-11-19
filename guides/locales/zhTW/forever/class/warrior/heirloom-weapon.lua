-- Chinese (traditional) (zhTW): the guide forever/class/warrior/heirloom-weapon (forever/class/warrior/heirloom-weapon.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:71} Defensive Stance
	["{spell:71} and a Weapon (Horde)"] = "{spell:71}和一把武器（部落）",
	-- {spell:71} Defensive Stance · {npc:5810} Uzzek · {area:159} Brill
	["{spell:71} at 10 and a one-hand weapon of your choice: {npc:5810}'s road, {area:159}'s crypt, or the Skybreaker shield."] = "10級時學會{spell:71}，並獲得一把自選的單手武器：{npc:5810}的道路、{area:159}的地穴，或破天者盾牌。",

	-- Step 1: Seena Skybreaker in Valanaar
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar
	["{npc:252377} in {area:16638}"] = "{area:16638}的{npc:252377}",
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {npc:257196} Zaal Stormshield · {area:16629} Shrine of Akir
	["At 10, {npc:252377} stands with the trainers by {area:16638}'s west gate. A cultist, {npc:257196}, holds her family's shield at the {area:16629}."] = "10級時，{npc:252377}和訓練師們站在{area:16638}西門旁。邪教徒{npc:257196}在{area:16629}拿著她家族的盾牌。",

	-- Step 2: Zaal Stormshield
	-- {area:16638} Valanaar · {area:16629} Shrine of Akir · {npc:257196} Zaal Stormshield · {item:263993} Skybreaker Bulwark
	["Head north-west from {area:16638} to the {area:16629}. {npc:257196} stands west of the shrine's approach, among the cult's Guardians, Spiritcallers and Blademasters: pull them one at a time before you take him. He drops the {item:263993}."] = "從{area:16638}向西北前往{area:16629}。{npc:257196}站在神殿通道的西側，混在教派的守衛者、喚靈者和劍師中間：先一個一個拉掉他們，再動他。他掉落{item:263993}。",
	-- {item:263993} Skybreaker Bulwark · {npc:257196} Zaal Stormshield
	["{item:263993}, from {npc:257196}"] = "{item:263993}，來自{npc:257196}",

	-- Step 3: The Skybreaker Bulwark
	-- {npc:252377} Seena Skybreaker · {area:16638} Valanaar · {spell:71} Defensive Stance · {item:275290} Stormforged Protector · {npc:5810} Uzzek
	["Back to {npc:252377} in {area:16638}. She teaches {spell:71} and gives you the {item:275290}, a shield to use it with. {npc:5810}'s road below still gives a weapon later, once you reach Kalimdor."] = "回到{area:16638}找{npc:252377}。她教你{spell:71}，並給你{item:275290}，一面配合它使用的盾牌。下面{npc:5810}的路線在你到達卡利姆多後仍會給一把武器。",

	-- Step 4: Veteran Uzzek (Razor Hill)
	-- {npc:3169} Tarshaw Jaggedscar · {area:362} Razor Hill · {npc:5810} Uzzek · {zone:1413} Barrens · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {zone:1420} Tirisfal Glades · {npc:2131} Austil de Mon · {area:159} Brill
	["At 10, {npc:3169}, the warrior trainer in the barracks of {area:362}, sends you to {npc:5810} in the {zone:1413}. Sorek in {zone:1454}'s {object:172958} offers it too. Any Horde warrior may take one of the two roads, never both: heading to {zone:1420} at 10 anyway? {npc:2131} in {area:159}'s inn offers the other: one fight by {area:159}'s graveyard for the same stance, then the Agamand crypt for an heirloom weapon."] = "10級時，{area:362}兵營裡的戰士訓練師{npc:3169}派你去{zone:1413}的{npc:5810}。{zone:1454}的{object:172958}裡的索瑞克也提供這個任務。任何部落戰士只能走兩條路線中的一條，絕不能都走：10級反正要去{zone:1420}？{area:159}旅店裡的{npc:2131}提供另一條：在{area:159}墓地旁打一場就能拿到同樣的姿態，然後去阿加曼德墓穴拿傳家寶武器。",

	-- Step 5: Veteran Uzzek (Mulgore)
	-- {npc:3063} Krang Stonehoof · {area:222} Bloodhoof Village · {npc:5810} Uzzek · {zone:1413} Barrens · {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff
	["At 10, {npc:3063}, the warrior trainer of {area:222}, sends you to {npc:5810} in the {zone:1413}. {npc:3041} in {zone:1456} offers it too."] = "10級時，{area:222}的戰士訓練師{npc:3063}派你去{zone:1413}的{npc:5810}。{zone:1456}的{npc:3041}也提供這個任務。",

	-- Step 6: Uzzek at Far Watch Post
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["{npc:5810} at {area:379}"] = "{area:379}的{npc:5810}",
	-- {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1412} Mulgore
	["{npc:5810} is easy to miss: he stands under a small canopy by a large tree just west of {area:379}, below the road's south side, with the post in sight to his east. Going straight south from the post does not lead to him. From {zone:1411} cross the bridge west; from {zone:1412} head north past the Crossroads."] = "{npc:5810}很容易錯過：他站在{area:379}正西一棵大樹下的小棚子裡，位於道路南側下方，向東能看見哨站。從哨站直接往南走找不到他。從{zone:1411}向西過橋；從{zone:1412}向北經過十字路口。",

	-- Step 7: Singed Scales in Thunder Ridge
	-- {area:369} Thunder Ridge
	-- plural, as words: Singed Scales = {item:6486} Singed Scale
	["Singed Scales in {area:369}"] = "{area:369}的燒焦的鱗片",
	-- {area:369} Thunder Ridge · {zone:1411} Durotar · {zone:1454} Orgrimmar · {zone:1413} Barrens · {spell:5401} Lizard Bolt
	-- plural, as words: Singed Scales = {item:6486} Singed Scale · Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["You need five Singed Scales. Thunder Lizards (level 9-10) and Lightning Hides (10-11) live down in the {area:369} crevasse in north-west {zone:1411}, south of {zone:1454}: from the {zone:1413} bridge turn left and follow the river north into it. Both drop a scale about four kills in five; both cast {spell:5401}."] = "你需要五個燒焦的鱗片。雷霆蜥蜴（9-10級）和閃電皮蜥蜴（10-11級）生活在{zone:1411}西北{area:369}的裂隙裡，位於{zone:1454}以南：從{zone:1413}的橋向左轉，沿河向北進入。兩者大約五次擊殺掉四片鱗；都會施放{spell:5401}。",
	-- {item:6486} Singed Scale
	["{item:6486}, from the lizards"] = "{item:6486}，來自蜥蜴",

	-- Step 8: Path of Defense
	-- {npc:5810} Uzzek · {area:379} Far Watch Post
	["Back to {npc:5810} under his tree west of {area:379}."] = "回到{npc:5810}身邊，他在{area:379}以西的樹下。",

	-- Step 9: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:1699} Thorn Hill
	["{npc:5878}'s hut sits on top of {area:1699}, east of the Crossroads. Most slopes are too steep: climb the broad ridge on the north or east side."] = "{npc:5878}的小屋在{area:1699}頂上，位於十字路口以東。大多數坡太陡：從北側或東側寬闊的山脊爬上去。",

	-- Step 10: Forged Steel
	-- {object:58369} Stolen Iron Chest · {npc:5878} Thun'grim Firegaze
	["The {object:58369} stands by a broken wagon in the Razormane camp north-west of {npc:5878}, north-east of the Crossroads. Two Razormanes guard it and their hunters pull more quilboar: clear them one at a time, then open the chest (it refills within seconds, so a friend can loot it too)."] = "{object:58369}立在{npc:5878}西北、十字路口東北的鋼鬃營地中一輛破車旁。兩個鋼鬃野豬人守著它，他們的獵人還會引來更多野豬人：一個一個清掉，然後開啟箱子（幾秒內就會補滿，所以朋友也能拾取）。",
	-- {item:6534} Forged Steel Bars · {object:58369} Stolen Iron Chest
	["{item:6534}, from the {object:58369}"] = "{item:6534}，來自{object:58369}",

	-- Step 11: Speak with Dillinger
	-- {npc:2131} Austil de Mon · {area:159} Brill · {npc:1496} Deathguard Dillinger · {npc:5810} Uzzek · {quest:1505} Veteran Uzzek · {quest:1498} Path of Defense
	["At 10, {npc:2131}, the warrior trainer inside the inn of {area:159}, sends you to {npc:1496} by the graveyard on {area:159}'s west edge. This road and {npc:5810}'s exclude each other: drop {quest:1505} or {quest:1498} from your log if you hold one."] = "10級時，{area:159}旅店裡的戰士訓練師{npc:2131}派你去{area:159}西緣墓地旁的{npc:1496}。這條路線與{npc:5810}的路線互斥：工作列裡若有{quest:1505}或{quest:1498}，放棄其中一個。",

	-- Step 12: Deathguard Dillinger
	-- {area:159} Brill · {quest:1818} Speak with Dillinger · {npc:2131} Austil de Mon · {npc:5810} Uzzek
	["Dillinger stands by the graveyard on {area:159}'s west edge. An Orc, Troll, Tauren or Skyborne who took {quest:1818} from {npc:2131} instead of {npc:5810}'s road is led through {area:159} from here."] = "迪林格站在{area:159}西緣的墓地旁。獸人、食人妖、牛頭人或天裔如果在{npc:2131}那裡接了{quest:1818}而不是走{npc:5810}的路線，就會從這裡被引導穿過{area:159}。",

	-- Step 13: Ulag the Cleaver
	-- {npc:6390} Ulag the Cleaver
	["{npc:6390} sleeps in the mausoleum in the graveyard just north of Dillinger. To wake him, click the flat skull plaque on the ground, left of the path to the mausoleum door; the seal lifts and {npc:6390} (level 11, not elite) walks out. Start at full health."] = "{npc:6390}睡在迪林格正北方墓地的陵墓裡。要喚醒他，點選通往陵墓門口的小路左側地面上那塊扁平的頭骨石板；封印會解除，{npc:6390}（11級，非精英）會走出來。滿血再開始。",

	-- Step 14: Coleman Farthing
	-- {npc:1500} Coleman Farthing · {area:2119} Gallows' End Tavern · {area:159} Brill
	["{npc:1500} is in the {area:2119}, the inn on {area:159}'s east side."] = "{npc:1500}在{area:2119}，也就是{area:159}東側的旅店。",

	-- Step 15: The Agamand Family Crypt
	-- {area:158} Agamand Family Crypt
	["The {area:158}"] = "{area:158}",
	-- {area:158} Agamand Family Crypt · {area:157} Agamand Mills · {area:159} Brill
	-- plural, as words: Agamand Weapon Racks = {object:105169} Agamand Weapon Rack
	["The four Agamand Weapon Racks are inside the {area:158} at the north end of {area:157}, north of {area:159}, one rack per room: one in the lowest room, two in the pair of rooms up the stairs, one in the room above those. The axe rack stands in a dark corner. The crypt's undead come in packs of three or more and return quickly; the ones in the top room are not linked. The axe, dagger and mace racks take 15 minutes to refill after someone loots them."] = "四個阿加曼德武器架在{area:157}北端的{area:158}內，位於{area:159}以北，每個房間一個：最低的房間一個，樓梯上那對房間兩個，它們上面那間一個。斧架立在黑暗的角落。墓穴裡的亡靈三隻以上成群出現且回來得很快；頂層的那些不聯動。斧、匕首和錘架被拾取後要15分鐘才會補滿。",

	-- Step 16: Back to Coleman Farthing
	-- {npc:1500} Coleman Farthing
	["Back to {npc:1500}"] = "返回{npc:1500}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The four Agamand Weapon Racks stand among the buildings of {area:157}, north of {area:159}. The mills' undead attack on sight."] = "四個阿加曼德武器架立在{area:159}北邊{area:157}的建築之間。磨坊的不死生物看到你就會攻擊。",
	-- ["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496}站在{area:159}。{npc:6390}在城鎮北邊山丘上的陵墓裡等著：打開大門與他戰鬥。",
}
