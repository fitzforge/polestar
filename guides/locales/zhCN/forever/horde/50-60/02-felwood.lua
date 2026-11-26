-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1422} Western Plaguelands · {area:152} Bulwark · {zone:1447} Azshara · {zone:1448} Felwood
	["{zone:1422} and the {area:152} first, then {zone:1447} and {zone:1448}."] = "先去{zone:1422}和{area:152}，再去{zone:1447}和{zone:1448}。",

	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "他在{area:200}东南的{area:202}旁扎营。",
	["Inside"] = "在里面",

	-- Step 2: Diseased Wolves
	["Diseased Wolves"] = "生病的狼",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east. Careful: the biggest are 54: pull them one at a time."] = "狼在安多哈尔、{area:200}和{area:202}之间的田野里游荡。向东骑回去的路上把它们杀完。小心：最大的有54级，一次只拉一只。",

	-- Step 3: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "{area:200}的农舍",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "日记在农舍里，柜子在屋里，厕所在屋后。一个{npc:10816}带着厕所钥匙；打开厕所时{npc:10836}会出来，他带着柜子钥匙。",

	-- Step 4: Mulgris Deepriver
	["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands guide's sweep at about 55."] = "",

	-- Step 6: High Executor Derrington
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "你在路线之前来这里时错过了这一步：现在先做它。它很快，还会开启后面的任务。",
	-- {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries
	["{item:12814}, from the {object:176092} next to Derrington"] = "{item:12814}，来自德灵顿旁边的{object:176092}",

	-- Step 7: Box of Incendiaries
	-- {quest:5096} Scarlet Diversions · {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries · {npc:10837} High Executor Derrington
	["{quest:5096} needs a {item:12814} to torch the command tent: take one from the {object:176092} next to {npc:10837}."] = "{quest:5096}需要一个{item:12814}来点燃指挥帐篷：从{npc:10837}旁边的{object:176092}拿一个。",
	-- {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries
	["{item:12814}, from the {object:176092}"] = "{item:12814}，来自{object:176092}",

	-- Step 8: Scarlet forward camp
	["Scarlet forward camp"] = "血色十字军前线营地",
	-- {area:152} Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {item:12814} Flame in a Bottle
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {item:12814} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "从{area:152}沿路向东进入{zone:1422}。血色十字军的帐篷就在费尔斯通农场后面，在{area:199}和{area:200}之间。用{item:12814}点燃指挥帐篷，插上天灾旗帜。小心：帐篷周围的血色十字军最高54级，祈求者会施法：从离指挥帐篷最近的一侧进入，别管其他人。",

	-- Step 9: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "向西南骑过费尔斯通农场，沿道路向西回到{area:152}。",
	["Derrington's watchtowers and Vandis' cauldron are done on a later visit: keep them."] = "德灵顿的哨塔和范蒂丝的瘟疫之锅留到之后再来时完成：留着它们。",

	-- Step 11: Paladin trainer
	["Paladin trainer"] = "圣骑士训练师",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "{npc:246152}在{zone:1420}；{zone:1454}没有圣骑士训练师",

	-- Step 12: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "乘飞艇前往{zone:1454}",

	-- Step 13: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "{zone:1454}中央",

	-- Step 14: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659} takes the ravasaur claws from Un'Goro; he is in {object:172959}, upstairs in one of its tallest buildings."] = "",
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "",

	-- Step 15: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "飞往{area:1237}",
	-- {zone:1447} Azshara · {zone:1454} Orgrimmar
	["{zone:1447} is a short flight from {zone:1454}: its quests are 51-55, at your level now."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}飞行管理员",

	-- Step 16: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}：{quest:91569}，从血精灵奥术师身上获取一根魔杖",

	-- Step 17: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}：沿途遇到就击杀",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "向东骑到海岸边的废墟。四块石板散落在废墟中，由恶鞭纳迦（52-55级）守卫：一次引一只。",

	-- Step 18: Ruins of Eldarath
	-- {item:10695} Box of Empty Vials · {area:1231} Southridge Beach · {npc:8390} Chemist Cuely · {zone:1458} Undercity
	["Open Cuely's {item:10695} in your bags for the four labelled vials. The tide pools cannot be clicked: stand in each pool and use its own vial from your bags, from {area:1231} north up the coast; Spitelash naga patrol between them. No vials? Abandon the quest and take it again from {npc:8390} in the {zone:1458}."] = "",
	-- {item:10691} Filled Vial Labeled #1 · {area:1231} Southridge Beach
	["{item:10691}: the tide pool on {area:1231}"] = "",
	["#2, north along the shore"] = "",

	-- Step 19: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "马克林尼掘地者",
	-- {npc:247473} Izvi Gildfizz · {item:246683} Treasure Trowel 3000
	-- plural, as words: Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment · Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["{npc:247473}'s {item:246683}, in your bags, digs up the Highborne Treasure Fragments: use it on the sands just east of the ruins, where the Makrinni Burrowers (50-51) dig, on the way north-east. The Burrowers and the buried caches there give fragments too."] = "",

	-- Step 20: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "继续向东北穿过{zone:1447}中部：{npc:235903}在路旁扎营。",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}：{quest:86746}，血精灵营地北边的萨特",

	-- Step 21: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "向东北骑到{area:1227}上方悬崖上的地精营地，就在血精灵营地北边。",

	-- Step 22: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "血精灵在东北的悬崖上扎营，就在{area:1227}旁边。{npc:8420}的四件装备在营地周围的箱子里；血精灵奥术师身上带着{npc:247473}要的魔杖。\n小心：一个{npc:250023}（55-57级精英）站在营地西缘：从营地东侧对付血精灵。",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}，来自血精灵奥术师",

	-- Step 23: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}的营地",
	-- {object:151286} Kaldorei Tome of Summoning
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "雷姆托里的营地在营地东端。在那里阅读{object:151286}：在Forever服务器上，旁边的辛多雷宝典随后会要求营地三名军官的印记。",

	-- Step 24: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "营地的三名军官（53级）各带一枚印记：{npc:247006}在营地中央，{npc:247013}在营地东端，{npc:246991}在营地西半边巡逻：在他巡逻路线的东侧、箭头所指处对付他。\n小心：{npc:250023}（55-57级精英）站在营地西缘，靠近鹰盔巡逻路线的尽头：等鹰盔走回东边再动手。",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}，来自{npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}，来自{npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}，来自{npc:247013}",

	-- Step 25: Magus Rimtori
	-- {quest:91500} An Explosive Gambit · {quest:91497} Seals of the Sin'dorei
	["Back to the Sin'dorei Tome: hand in the seals and take {quest:91500}, which gives you the {quest:91497}. Rimtori does not come from the Tome: stand beside one of the camp's tall crystals and use the {quest:91497} from your bags; its crystal explodes and draws her. Which crystal is linked to her is random: each of the other two summons a hostile infernal instead. She is level 55: start at full health."] = "",
	-- {quest:91497} Seals of the Sin'dorei · {npc:8578} Magus Rimtori
	["Use the {quest:91497} from your bags beside a crystal: {npc:8578} (55) comes to the explosion and drops her head"] = "",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}：交给{area:1237}的{npc:8587}",

	-- Step 26: The Legashi satyrs
	["The Legashi satyrs"] = "雷加希萨特",
	-- {npc:235903} Ekkal · {npc:235892} Prince Halanox
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind.\nCareful: {npc:235892} (55, elite) stands among the satyrs at the north-east end of their hills, around 67,19: take the satyrs nearer the camp and leave him be."] = "",

	-- Step 27: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "向西北回到{npc:8420}处。",

	-- Step 28: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "向南骑到{area:1221}的北缘。那里的恶鞭海妖和恶鞭侍从（50-52级）携带{npc:8420}的符文；掉率不高，沿着边缘一路刷到掉落为止。",

	-- Step 29: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "带着符文向北回到{npc:8420}处，然后沿道路向西南走。",

	-- Step 30: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "沿道路向西南：向{npc:235903}交还萨特任务。",

	-- Step 31: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "向西骑回{area:1237}。",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}：{quest:91531}，交给{zone:1454}的{npc:4485}",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}：宝典要交给{zone:1454}的{npc:3326}",
	-- {npc:8659} Jes'rimon · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {npc:6522} Andron Gant · {zone:1458} Undercity
	["Keep the deliveries: {npc:8659}, {npc:4485} and {npc:3326} are in {zone:1454} next, Magatha in {zone:1456} and {npc:6522} in the {zone:1458} on the next guides."] = "",

	-- Step 32: Sanath Lim-yo
	-- {area:1237} Valormok · {npc:8379} Archmage Xylem
	["Ride east from {area:1237} to Sanath's camp at the foot of the cliff and get off your mount: he teleports you up to {npc:8379}'s tower."] = "",

	-- Step 33: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "塔顶的学徒会把你送回下面。",
	["Upstairs"] = "在楼上",

	-- Step 35: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "{area:1237}的飞行管理员",

	-- Step 36: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:4485} is in the {object:172958}, {npc:3326} in the {object:172960}, and {npc:8659} in {object:172959}, upstairs in one of its tallest buildings."] = "",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow
	["{npc:3326}, the {object:172960}"] = "{npc:3326}，在{object:172960}",
	-- {npc:8659} Jes'rimon · {npc:8587} Jediga
	["{npc:8659}: his payment goes back to {npc:8587}, on the flight out"] = "",

	-- Step 37: Class trainer
	["Class trainer"] = "职业训练师",

	-- Step 38: Druid trainer
	["Druid trainer"] = "德鲁伊训练师",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034} 在 {zone:1412}；{zone:1454} 没有德鲁伊训练师",

	-- Step 39: Fly to Valormok
	-- {zone:1448} Felwood · {area:1237} Valormok · {npc:8587} Jediga · {npc:8659} Jes'rimon · {area:431} Splintertree Post
	["{zone:1448} is next: fly by way of {area:1237}, where {npc:8587} takes {npc:8659}'s payment, then on to {area:431}."] = "",

	-- Step 41: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "飞往{area:431}",

	-- Step 43: Emerald Sanctuary
	["The druids' camp is just past the border."] = "德鲁伊的营地就在边界过去一点。",
	-- {npc:10920} Kelek Skykeeper · {npc:10921} Taronn Redfeather · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}, beside {npc:10921}: {quest:86577}, the organs of {zone:1448}'s bears and wolves"] = "{npc:10920}，在{npc:10921}旁：{quest:86577}，收集{zone:1448}熊和狼的器官",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}，在营地南缘",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the camp"] = "{npc:9529}，在营地西侧",

	-- Step 44: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "死木熊怪的村庄就在翡翠圣地正南。每杀一个死木熊怪也会提升你在{area:1769}的声望；留着死木头饰羽毛。",

	-- Step 45: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "{area:1763}南部",
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: pull the cultists and hounds away from him."] = "",

	-- Step 47: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "{area:1763}的月亮井",
	-- {area:1763} Jaedenar
	["Back north to {area:1763}. Fill Greta's canteen at the corrupted moonwell in the middle of the southern camp."] = "向北回到{area:1763}。在南部营地中央被腐化的月亮井装满格雷塔的水壶。",

	-- Step 48: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "{area:1763}正北的部落营地。",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}：枭兽在{zone:1452}",

	-- Step 49: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "在血毒岗哨东边，是{npc:9878}和热能恐兽游荡的坑洼山谷。每种各杀两只，然后走到三个邪能水坑的每一个那里。",
	["Southern crater"] = "南部水坑",
	["Western crater"] = "西部水坑",
	["Northern crater"] = "北部水坑",

	-- Step 50: Statue of Malorne
	-- {object:661778} Statue of Malorne (no name in this language: may be words) · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "玛洛恩雕像就在山谷正南、往北的道路旁：它的饰物会开启一个交给{area:1997}的{npc:9996}的任务。",

	-- Step 51: Irontree Woods
	-- {area:1767} Irontree Woods · {npc:10920} Kelek Skykeeper · {npc:9529} Maybess Riverbreeze · {item:11503} Blood Amber · {area:1768} Irontree Cavern
	-- plural, as words: Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}: Angerclaw Grizzlies and Felpaw Ravagers roam the woods for Talo, and their organs are {npc:10920}'s. {npc:9529}'s {item:11503} comes from the Warpwood elementals inside {area:1768}, next."] = "",
	-- {item:277958} Putrescent Bear Organs
	["{item:277958}, from the Angerclaw bears"] = "{item:277958}，来自怒爪灰熊",
	-- {item:277959} Putrescent Wolf Organs
	["{item:277959}, from the Felpaw wolves"] = "{item:277959}，来自魔爪狼",

	-- Step 52: Irontree Woods
	-- {area:1768} Irontree Cavern
	["Below ground: from the Warpwood elementals inside {area:1768}"] = "",

	-- Step 53: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {quest:6031} Runecloth · {area:1769} Timbermaw Hold
	["Only from Friendly with the Timbermaw: {npc:11557}, in the tunnel near its {zone:1448} mouth, gives {quest:6031} then (the {area:1769} reputation guide gets you there)."] = "",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}: keep 30 {quest:6031} for him; below ground"] = "",

	-- Step 54: Nafien
	-- {npc:15395} Nafien · {area:1769} Timbermaw Hold
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "道路的尽头是{npc:15395}，就在遥远东北的{area:1769}隧道外。",

	-- Step 55: Felpaw Village
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nIf one drops a {quest:8470} (about one kill in thirty), right-click it; don't stay to farm one. {npc:11558} in {area:1769} takes it only from Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): now if they already are, or on the last guide's pass of the cave."] = "",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop from the Deadwood furbolgs"] = "",

	-- Step 56: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "留着{quest:8465}去{zone:1452}。",

	-- Step 57: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She speaks to you only from Neutral with the Timbermaw."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "{npc:11558}在附近巡逻，请在地图标示的圆圈内寻找",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "拾取到{item:13140}后，使用它开始任务，再到{area:1763}北端的洞穴{area:1770}中，将{npc:11018}从笼子里救出。",
	-- ["Back at the {area:2479}."] = "返回{area:2479}。",
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "回到{area:1762}，死木熊怪（53-54级）就在隧道附近，每杀一个都会提升你的木喉要塞声望。",
	-- ["Below ground"] = "在地下",
	-- ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "小心：死木守卫为53-54级，死木复仇者为54-55级；生命值低于50%时会呼叫25码内的盟友，低于15%时会逃跑求援。\n继续击杀，直到掉落一个{quest:8470}，约每三十只掉一个，然后右键点击：木喉声望达到中立后，就能交给{area:1769}的{npc:11558}；已经中立就现在交，否则等最后一份指南在59级再次经过洞穴时再交。",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%."] = "小心：洞穴守卫为 53-54 级，生命值低于 50% 时会呼叫 25 码内的同伴援助，低于 15% 时还会逃跑求援。",
	-- ["Careful: Den Watchers are level 53-54; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nBelow level 54.54, keep fighting the Deadwood here after {npc:15395}'s count: the hand-ins at {area:1769} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "注意：死木守卫为53-54级；生命值低于50%时会呼叫25码内的盟友，低于15%时会逃跑求援。\n达到{npc:15395}要求的击杀数后，如果还没到54.54级，就继续在这里击杀死木熊怪；去{area:1769}和{area:2479}交还任务后就能升到55级。也可组队挑战{area:1584}副本或{area:1417}副本。\n继续击杀，直到掉落一个{quest:8470}，约每三十只掉一个，然后右键点击：木喉声望达到中立后，就能交给{area:1769}的{npc:11558}；已经中立就现在交，否则等最后一份指南在59级再次经过洞穴时再交。",
	-- ["Cross the river east into {area:2627}, the ruined town in the north-west of the {zone:1423}. {npc:12384} sits in a hut at its edge."] = "向东渡河进入{area:2627}，这是位于{zone:1423}西北部的废弃城镇。{npc:12384}坐在城镇边缘的一间小屋里。",
	-- ["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "德灵顿的哨塔、范蒂丝的瘟疫之锅和{npc:11615}的木桶留到之后再来时完成：留着它们。",
	-- ["Diseased Grizzlies"] = "生病的灰熊",
	-- ["Fly to the {area:1497}"] = "飞往{area:1497}",
	-- ["Fly to {area:272}"] = "飞往{area:272}",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s.\n{area:1762}'s Deadwood Den Watchers (53-54) and Avengers (54-55) are next: below level 54, keep hunting the grizzlies and ravagers (51-52) here until 54. The hand-ins at {area:1769}, the {area:2479} and {area:1997} that follow take you most of the way to 55. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "沿道路向东北前往{area:1767}。树林东侧的曲木食苔者和曲木撕裂者各带着一块{item:11503}；怒爪灰熊和魔爪掠夺者也在同一片树林里游荡，是塔罗要的目标，它们的器官交给{npc:10920}。\n接下来是{area:1762}的死木守卫（53-54级）和死木复仇者（54-55级）：不到54级的话，就在这里继续击杀灰熊和掠夺者（51-52级）直到54级。之后在{area:1769}、{area:2479}和{area:1997}交还任务，基本能把你带到55级。也可组队挑战{area:1417}地下城或{area:1584}地下城。",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo."] = "沿道路向东北前往{area:1767}。树林东侧的曲木食苔者和曲木撕裂者各带着一块{item:11503}；怒爪灰熊和魔爪掠夺者在同一片树林里游荡，是塔罗要的。",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "沿道路向东北前往{area:1767}。树林东侧的曲木食苔者和曲木撕裂者各带着一块{item:11503}；怒爪灰熊和魔爪掠夺者也在同一片树林里游荡，是塔罗要的目标。若还没到54.21级，就继续击杀灰熊和掠夺者；去{area:1997}和{area:2479}交完任务即可到55级。也可组队挑战{area:1584}副本或{area:1417}副本。",
	-- ["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "沿道路向西北。{area:1763}南部那口被腐化的月亮井周围被暗影议会的加德纳尔祭司、加德纳尔精兵、卫兵和恶犬占据。",
	-- ["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "从{area:152}沿路向东进入{zone:1422}。血色十字军的帐篷就在费尔斯通农场再往前一点，位于{area:199}和{area:200}之间。用{object:176092}点燃指挥帐篷，并插上天灾战旗。小心：帐篷周围的血色十字军最高54级，祈求者会施法：从离指挥帐篷最近的一侧进入，别惹其他人。",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "从{area:2268}的飞行管理员处飞往{area:1497}。",
	-- ["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands visit at about 58."] = "他的下一个狩猎任务——患病的灰熊（55-56级）——留到约58级再来瘟疫之地时完成。",
	-- ["Jadefire moonwell"] = "碧火月亮井",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "保留“小帕米拉”：帕米拉在 {area:2262}，稍后还会再去。",
	-- ["Keep the branch: {npc:5770} is in {zone:1456}."] = "留着树枝：{npc:5770}在{zone:1456}。",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "留着包裹：{npc:10781}在{area:1497}。",
	-- ["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "留着{quest:5158}：{npc:5901}在{zone:1413}。",
	-- ["Keep {quest:6164}: {npc:12384} takes it back on the {zone:1423} guide's {area:2627} stop."] = "留着{quest:6164}：{npc:12384}会在{zone:1423}指南的{area:2627}一站收回它。",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "血色骑士和血色占星师在{area:192}干活；血色医护员和血色猎人在它南边扎营。",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "离开{area:1497}，沿道路向东穿过{zone:1420}，经过{area:152}。费尔斯通农场是路边的第一座农场；{npc:10778}在房子里等候。",
	-- ["Level 52.63"] = "等级 52.63",
	-- ["Level 53"] = "等级 53",
	-- ["Level 53.02"] = "等级 53.02",
	-- ["Level 53.2"] = "等级 53.2",
	-- ["Level 53.34"] = "等级 53.34",
	-- ["Level 54.1"] = "等级 54.1",
	-- ["Level 54.45"] = "等级 54.45",
	-- ["Level 54.54"] = "等级 54.54",
	-- ["Level 54.7"] = "等级 54.7",
	-- ["Level 54.87"] = "等级 54.87",
	-- ["Level 55"] = "等级 55",
	-- ["Only if a {item:13140} dropped: use it to start the quest, then free {npc:11018} in her cage in {area:1770}, the cave at the north end of {area:1763}, and escort her out."] = "仅当掉落了{item:13140}时：使用它开始任务，然后到{area:1763}北端的洞穴{area:1770}里，把笼子里的{npc:11018}救出来，并护送她出去。",
	-- ["Only if you rescued {npc:11018}: the succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "仅当你救出了{npc:11018}时：魅魔{npc:9518}在{area:1763}中部，就在{npc:11020}旁边等候。",
	-- ["Only with 5 Deadwood Headdress Feathers"] = "仅当你有5根死木头饰羽毛时",
	-- ["Radley and Durgen"] = "莱德雷和杜尔根",
	-- ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "向南骑过{area:1763}，前往碧火萨特那口被腐化的月亮井，在那里装满{npc:9996}的小瓶。",
	-- ["Ride back south-east to the Sanctuary."] = "向东南骑回翡翠圣地。",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "骑回{area:1497}，乘飞艇前往{zone:1454}，飞往{area:431}。沿道路向西离开碎木岗哨，在岔路口向北进入{zone:1448}。",
	-- ["Ride back west over the river and on to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "向西骑回河对岸，继续前往{area:192}；{npc:11610}躲在它东北的山上。",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "向东骑往海岸边的废墟。在沿岸的海潮之池装满科雷的四个瓶子；恶鞭纳迦在海潮之池之间巡逻。",
	-- ["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "沿东边的山丘向北骑行；{npc:1855}住在{area:2619}旁的一间小房子里，就在与{zone:1423}的交界处。",
	-- ["Ride north up the road again."] = "再次沿道路向北骑行。",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "向西北骑进安多哈尔。{npc:10667}在城镇西侧被毁的旅店里等候；里面的骷髅是54-57级，所以沿着边缘走。",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "向南骑过{area:202}前往{area:197}；{npc:10927}的房子在路旁，{npc:10936}的纪念碑在房后的墓地里。路上把在田野里遇到的生病的狼都杀掉。",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "沿道路向南穿过{area:361}前往翡翠圣地。",
	-- ["Ride the road south through {zone:1448} to the Sanctuary."] = "沿道路向南穿过{zone:1448}前往翡翠圣地。",
	-- ["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "向西骑往{area:192}；{npc:11610}躲在它东北的山上。",
	-- ["Ror stands at the far south end of {area:1761}."] = "洛尔站在{area:1761}最南端。",
	-- ["Scarlet Crusade"] = "血色十字军",
	-- ["Scarlet forward camp"] = "血色十字军前线营地",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "走进洞穴：{npc:11558}就在入口内侧。",
	-- ["Take the kitten to the same moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "把小猫带到同一口月亮井，用{item:12565}在那里放出它；它变成{npc:10042}后，把它带回{npc:9996}那里，点击它交给她。",
	-- ["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "把小猫带到同一口月亮井并在那里放出它；它变成{npc:10042}后，把它带回{npc:9996}那里，点击它交给她。",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "达隆郡的历史就在安多哈尔市政厅里的发霉的书籍中间；一本本打开，直到找到正确的那本。",
	-- ["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "隧道正西的死木熊怪村庄。{npc:9462}（56级）站在它们中间。{npc:11557}是一个友善的熊怪，坐在村庄北端。",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "死木熊怪的村庄就在翡翠圣地正南。每杀一个死木熊怪也会提升你在{area:1769}的声望；留着死木头饰羽毛。",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "死木熊怪的村庄就在翡翠圣地南边不远处。每击杀一个死木熊怪也会提升 {area:1769} 声望；留着死木头饰羽毛。继续击杀，直到 53.92 级：翡翠圣地接下来的交任务环节和 {area:1763} 的路线需要达到这个进度。也可组队前往 {area:1417} 副本或 {area:1584} 副本。",
	-- ["The Jadefire moonwell"] = "碧火月亮井",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "雷加希萨特（51-52级）占据着血精灵营地以北的山丘：{npc:235903}要每种各五只。",
	-- ["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "马克林尼掘地者（50-51级）在废墟东边不远的沙地里挖掘，正好在往东北的路上；它们和那里埋藏的宝箱会给出上层精灵财宝碎片。",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "血色十字军的帐篷在{area:199}和{area:200}之间。用{object:176092}点燃指挥帐篷，并插上天灾战旗。",
	-- ["The bears roam the hills north and east of the {area:202}."] = "熊在{area:202}北边和东边的山丘上游荡。",
	-- ["The bears roam the hills north and east of the {area:202}. Below level 53.02, keep hunting them after the eighth: the hand-ins at the {area:202} take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "熊在{area:202}北侧和东侧的山丘上游荡。若未到53.02级，击杀八只后继续刷；{area:202}的任务交还后会升到54级。也可以组队刷{area:1417}副本或{area:1584}副本。",
	-- ["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "账本在{area:2627}被毁的旅店里；镇上的亡灵是54-56级，所以一次只拉一只。\n大型白蚁丘遍布{area:2627}东边的山丘。对经过的每个白蚁丘使用{item:15042}。",
	-- ["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "魅魔{npc:9518}在{area:1763}中央，位于{npc:11020}旁边。",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "狼在安多哈尔、{area:200}和{area:202}之间的田野里游荡。向东骑回去的路上把它们杀完。",
	-- ["The {area:152}"] = "{area:152}",
	-- ["Through {area:1769}"] = "穿过{area:1769}",
	-- ["To {zone:1448}"] = "前往{zone:1448}",
	-- ["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Carrion Lurkers (52-53) west of the Scarlet camp are at your level; the Scarlet Mages and Knights (54-56) are higher. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "先在此刷到 52.63 级，再去 {area:200} 交任务，交完即可到 53 级。血色营地西边的腐虫潜伏者（52-53 级）与你等级相当；血色法师和血色骑士（54-56 级）等级更高。也可组队前往 {area:1417} 副本或 {area:2100} 副本。",
	-- ["Top up here to level 53 before {npc:10739} sends you after the Diseased Grizzlies (55-56): the Carrion Lurkers (52-53) on the way from {area:200} to the {area:202} are at your level. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "在{npc:10739}派你去对付生病的灰熊（55-56级）之前，先在这里补到53级：从{area:200}到{area:202}途中的腐虫潜伏者（52-53级）与你等级相当。也可组队前往{area:1417}地下城或{area:1584}地下城。",
	-- ["Top up here to level 53.02 before the hand-ins at {area:202}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "先在此刷到 53.02 级，再去 {area:202} 交任务，交完即可到 54 级。也可组队前往 {area:1417} 副本或 {area:1584} 副本。",
	-- ["Top up here to level 53.2 before the hand-ins at {area:152}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "先在此刷到 53.2 级，再去 {area:152} 交任务，交完即可到 54 级。也可组队前往 {area:1417} 副本或 {area:1584} 副本。",
	-- ["Top up here to level 53.34 before the hand-ins at {area:1763}: they take you to level 54. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "先在此刷到 53.34 级，再去 {area:1763} 交任务，交完即可到 54 级。也可组队前往 {area:1417} 副本或 {area:1584} 副本。",
	-- ["Top up here to level 54.1 before the hand-ins at {area:361}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.1 级，再去 {area:361} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- ["Top up here to level 54.45 before the hand-ins at {area:1769}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.45 级，再去 {area:1769} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- ["Top up here to level 54.54 before the hand-ins at {area:2479}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.54 级，再去 {area:2479} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- ["Top up here to level 54.7 before the hand-ins at {area:1997} : they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.7 级，再去 {area:1997} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- ["Top up here to level 54.87 before the hand-ins at {area:2255}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到 54.87 级，再去 {area:2255} 交任务，交完即可到 55 级。也可组队前往 {area:1584} 副本或 {area:1417} 副本。",
	-- ["Top up here to level 54.87 before the hand-ins in {zone:1452}: they take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "先在此刷到54.87级，再去{zone:1452}交任务，交完即可到55级。也可组队挑战{area:1584}副本或{area:1417}副本。",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "走进{npc:15395}旁边的{area:1769}隧道，千万别攻击里面的木喉熊怪。隧道出口在{zone:1452}；沿道路向东前往地精城镇{area:2255}，下一个指南从那里开始。",
	-- ["Walk {npc:11018} out of {area:1770} and keep her alive until she is out of the cave."] = "护送{npc:11018}离开{area:1770}，保护她直到走出洞穴。",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nTake a {object:176092} from the crate next to Derrington for {quest:5096}."] = "你在路线之前来这里时错过了这一步：现在先做它。它很快，还会开启后面的任务。\n从德灵顿旁边的箱子里拿一个{object:176092}，用于{quest:5096}。",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "在{zone:1448}的{area:1762}刷死木复仇者",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "在{zone:1422}的{area:192}刷血色骑士",
	-- ["grind on {npc:10605}"] = "击杀{npc:10605}刷经验",
	-- ["grind on {npc:1816}"] = "击杀{npc:1816}刷经验",
	-- ["grind on {npc:1817}"] = "击杀{npc:1817}刷经验",
	-- ["grind on {npc:1821}"] = "击杀{npc:1821}刷经验",
	-- ["grind on {npc:7101}"] = "击杀{npc:7101}刷经验",
	-- ["grind on {npc:7125}"] = "反复击杀{npc:7125}补足经验",
	-- ["grind on {npc:7153}"] = "反复击杀{npc:7153}补足经验",
	-- ["grind on {npc:7155}"] = "反复击杀{npc:7155}补足经验",
	-- ["grind on {npc:7156}"] = "击杀{npc:7156}刷经验",
	-- ["grind on {npc:7157}"] = "击杀{npc:7157}刷经验",
	-- ["grind on {npc:8957}"] = "击杀{npc:8957}刷经验",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "{area:190}的血色十字军是58-60级。骑到地图上标记的高处，俯瞰城镇，然后离开。",
	-- ["{area:2268} flight master"] = "{area:2268}的飞行管理员",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627}：遇到就击杀",
	-- ["{item:12565}, at the Jadefire moonwell"] = "{item:12565}，在碧火月亮井",
	-- ["{npc:10840} stands at the south end of the {area:197} graveyard, where the road from {area:272} comes in."] = "{npc:10840} 站在 {area:197} 墓地南端，来自 {area:272} 的道路入口处。",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}，在墓地南端",
	-- ["{npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it."] = "{npc:10927} 的房子在路旁，{npc:10936} 的纪念碑在屋后的墓地里。",
	-- ["{npc:10927}, upstairs"] = "{npc:10927}：在楼上",
	-- ["{npc:11016}, below ground"] = "{npc:11016}：在地下",
	-- ["{npc:11018}, below ground"] = "{npc:11018}，在地下",
	-- ["{npc:11020}, below ground"] = "{npc:11020}：在地下",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw"] = "{npc:11557}：为他留30块{quest:6031}；他只在木喉要塞声望达到中立时才交易",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557}：为他留着 30 个 {quest:6031}；木喉声望达到中立后才肯交易；在地下",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}，在隧道口",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}：木喉熊怪只会在声望达到中立后与你交谈；他在附近巡逻，请在地图标示的圆圈内寻找",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}的最后一个任务需要53级。在她西南不远的伐木场干活的血色骑士和血色占星师（54-55级）是最近的刷怪点。",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613}站在伐木场东边；{npc:11611}守着{npc:11610}东北、通往{area:190}的道路。",
	-- ["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "{npc:1855}的狩猎任务在{zone:1423}：留到之后。",
	-- ["{npc:8659} takes the ravasaur claws from Un'Goro; he stands in the {object:172960}, a short walk from the middle of the city."] = "{npc:8659}接收来自安戈洛的暴掠龙爪；他站在{object:172960}，离城中心步行不远。",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}，在{object:172960}",
	-- ["{npc:9529}, just west of the camp"] = "{npc:9529}，在营地正西",
	-- ["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}，在翡翠圣地西侧",
	-- ["{npc:9996}'s kitten"] = "{npc:9996}的小猫",
	-- ["{npc:9996}: the {quest:86612}"] = "{npc:9996}：{quest:86612}",
	-- ["{object:175894}, beside the house"] = "{object:175894}，在房子旁边",
	-- ["{object:175924}, inside"] = "{object:175924}，在室内",
	-- ["{quest:5058}, inside"] = "{quest:5058}：在屋内",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210}要前往{area:2268}：留到之后。",
	-- ["{quest:5408}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5408}：佩戴{item:12846}时，{area:2627}的亡灵会掉落它们",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}，稀有掉落",
	-- ["{zone:1452}'s quests are 55-58. Below 55 after {npc:9996}'s hand-ins? {area:1762}'s Deadwood furbolgs (53-55) are at your level and on your way north to {area:1769}'s tunnel: kill them until level 55. Every kill also raises your Timbermaw reputation. Careful: the Den Watchers and Avengers call nearby allies once below half health and run off for help when nearly dead: pull one at a time from the village's edge. This is a long top-up for a player who follows only this route. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "{zone:1452}的任务为55-58级。交完{npc:9996}的任务后还不到55级？{area:1762}的死木熊怪（53-55级）正适合你的等级，也在你北上前往{area:1769}隧道的路上：击杀它们直到55级。每次击杀还会提升木喉声望。小心：死木守卫和死木复仇者生命值低于一半时会呼叫附近盟友，濒死时会逃跑求援：从村子边缘一次拉一只。只走这条路线的玩家需要花较长时间补经验。也可组队挑战{area:1584}地下城或{area:1417}地下城。",
}
