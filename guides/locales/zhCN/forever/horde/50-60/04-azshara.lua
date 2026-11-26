-- Chinese (simplified) (zhCN): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:392} Ratchet · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{area:392}, {zone:1454} and the {zone:1458}, then into the Plaguelands."] = "{area:392}、{zone:1454}和{zone:1458}，然后前往瘟疫之地。",

	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飞往{area:392}",

	-- Step 2: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "莉芙的工作室在{area:392}码头北端；{object:149036}就在里面。",
	["Inside"] = "在里面",

	-- Step 3: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just south of {area:392}, at the water's edge."] = "",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "净化后的水要送到{zone:1448}的{area:2479}：留到之后。",

	-- Step 4: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飞往{area:1637}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}的飞行管理员",

	-- Step 5: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "",

	-- Step 6: Orgrimmar
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172982} Valley of Strength · {zone:1451} Silithus
	["{npc:15188}, {object:172982}: keep it for {zone:1451}"] = "",

	-- Step 7: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} works in the Drag."] = "{npc:7010}在暗巷工作。",

	-- Step 8: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {area:976} Gadgetzan · {zone:1451} Silithus · {zone:2482} Mount Hyjal
	["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1451} guide's first stop, after {zone:2482}."] = "",

	-- Step 9: Vehena
	-- {object:172961} Valley of Spirits
	["In the {object:172961}. Each donation takes sixty Wool, Silk or Mageweave from your bags: hand in what you carry, skip the rest."] = "在 {object:172961} 内。每次捐赠会收取背包中的六十块毛料、丝绸或魔纹布：交还随身带的，其余跳过。",

	-- Step 10: Rashona Straglash
	-- {object:172958} Valley of Honor
	["In the {object:172958}."] = "在{object:172958}。",
	-- {item:14047} Runecloth
	["Both {item:14047} donations are handed in later in the route: save sixty {item:14047} for each if you want them."] = "两项 {item:14047} 捐献都安排在路线后面交还：如果打算完成，每项各留六十块 {item:14047}。",

	-- Step 11: Paladin trainer
	["Paladin trainer"] = "圣骑士训练师",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{zone:1456}的{npc:246344}；{zone:1454}没有圣骑士训练师",

	-- Step 12: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "飞往 {zone:1454} 学习技能。",

	-- Step 13: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "进入{zone:1411}",

	-- Step 14: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "乘飞艇前往{zone:1458}",

	-- Step 15: Chemist Cuely
	-- {npc:8390} Chemist Cuely
	["{npc:8390} works in the Apothecarium."] = "{npc:8390}在炼金房工作。",

	-- Step 16: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "{npc:8390}和{npc:8393}在炼金房工作。",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}，在他旁边",

	-- Step 17: Andron Gant
	-- {npc:6522} Andron Gant · {object:36126} Royal Quarter
	["{npc:6522} stands just outside the Apothecarium, on the way to the {object:36126}."] = "",

	-- Step 18: The Undercity
	-- {object:36126} Royal Quarter
	["Lady Sylvanas holds the {object:36126}."] = "希尔瓦娜斯女士在{object:36126}。",

	-- Step 19: Royal Quarter
	-- {npc:10781} Royal Overseer Bauhaus · {object:36078} Trade Quarter
	["{npc:10781} keeps the census in the {object:36078}, beside the guild and tabard registrars near the bank."] = "",

	-- Step 21: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}，在附近",

	-- Step 22: Jeremiah Payson
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050}要交还给{zone:1422}的{npc:10778}：留着它。",

	-- Step 23: Royal Quarter
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386759} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "仅在背包中带有从{area:159}炼金店取得的书籍《{quest:79095}》时进行，详见《图书馆藏书》指南",

	-- Step 25: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "沿道路向东骑出{zone:1458}；{area:152}扼守着进入{zone:1422}的道路。",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: the termites are in {area:2627}, on the next guide"] = "{npc:11615}：白蚁在{area:2627}，属于下一个指南",

	-- Step 27: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- was: ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "{npc:10778}的农场是{area:152}以东第一座农场。农场里的喋喋不休的食尸鬼携带她护符的另一半；{npc:11075}守着田里的大锅。\n小心：通常有一两只亡灵与他并肩战斗，使用大锅后还可能有更多护锅者来袭。"
	["{npc:10778}'s farm is the first one east of the {area:152}. {npc:11075} guards the cauldron in the field. Careful: one or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "",

	-- Step 28: Janice Felstone
	["Upstairs"] = "在楼上",

	-- Step 30: Good Luck Other-Half-Charm
	-- {item:12722} Good Luck Other-Half-Charm · {item:12723} Good Luck Charm · {npc:10778} Janice Felstone
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["Jabbering Ghouls on Felstone Farm carry the {item:12722}: kill them until one drops it, then right-click the halves in your bags to join them into the {item:12723}, and take it to {npc:10778} upstairs."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north to {npc:8420} with the rune, then south-west along the road."] = "带着符文向北回到{npc:8420}处，然后沿道路向西南走。",
	-- ["Back north-west to {npc:8420}."] = "向西北回到{npc:8420}处。",
	-- ["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "回到辛多雷宝典：交上印记，然后用它召唤{npc:8578}。\n小心：哪块水晶与雷姆托里相连是随机的。另外两块各会召唤出一只敌对的地狱火。",
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "两次{item:14047}捐献都在路线后面交还：开始攒{item:14047}。",
	-- ["Crossroads flight master"] = "十字路口飞行管理员",
	-- ["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "营地的三名军官（53级）各带一枚印记：{npc:247006}在营地中央，{npc:247013}在营地东端，{npc:246991}在营地西半边巡逻：在他巡逻路线的东侧、箭头所指处对付他。\n小心：{npc:250023}（55-57级精英）站在营地西缘，靠近鹰盔巡逻路线的尽头：等鹰盔走回东边再动手。",
	-- ["Fly to the {area:380}"] = "飞往{area:380}",
	-- ["Fly to {area:1237}"] = "飞往{area:1237}",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "飞往{zone:1454}；{npc:4485}在{object:172958}，{npc:3326}和{npc:8659}在{object:172960}。",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "飞往{zone:1454}；{npc:4485}在{object:172958}。",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "在{object:172961}。把毛料、丝绸和魔纹布带在背包里。",
	-- ["Keep the deliveries for {npc:8659}, {npc:6522}, {npc:4485} and {npc:3326}: you pass {zone:1454} and the {zone:1458} next. Magatha's, in {zone:1456}, is off this route: leave it."] = "留着交给{npc:8659}、{npc:6522}、{npc:4485}和{npc:3326}的任务：接下来会经过{zone:1454}和{zone:1458}。{zone:1456}的玛加萨的任务不在这条路线上：先放着。",
	-- ["Makrinni Burrowers"] = "马克林尼掘地者",
	-- ["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "继续向东北穿过{zone:1447}中部：{npc:235903}在路旁扎营。",
	-- ["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1423} guide's way to Un'Goro."] = "仅当{quest:4494}尚未完成时：{npc:7010}在暗巷区工作。{zone:1423}指南前往安戈洛的途中，会在{area:976}向炼金师匹斯特苏格交还。",
	-- ["Open {object:149036} for the {item:10556}"] = "打开{object:149036}拿取{item:10556}",
	-- ["Ride back west to {area:1237}."] = "向西骑回{area:1237}。",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "向东骑往海岸边的废墟。在沿岸的海潮之池装满科雷的四个瓶子；恶鞭纳迦在海潮之池之间巡逻。",
	-- ["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "向东骑到海岸边的废墟。四块石板散落在废墟中，由恶鞭纳迦（52-55级）守卫：一次引一只。",
	-- ["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "沿路骑马向北前往十字路口；{npc:256386}就在那里。逐个打开她给你的箱子，将里面的东西交回。从十字路口继续飞往{area:1237}。",
	-- ["Ride north up the road to the {area:380}; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {zone:1454} from the {area:380}."] = "沿大路向北骑往{area:380}；{npc:256386}站在那里。打开她交给你的每一个箱子，把里面的东西带回来。然后从{area:380}飞往{zone:1454}。",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "向东北骑到{area:1227}上方悬崖上的地精营地，就在血精灵营地北边。",
	-- ["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "向南骑到{area:1221}的北缘。那里的恶鞭海妖和恶鞭侍从（50-52级）携带{npc:8420}的符文；掉率不高，沿着边缘一路刷到掉落为止。",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus."] = "雷姆托里的营地在萨拉斯营地东端。在那里阅读{object:151286}，然后杀死这位大法师。",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "大法师雷姆托里的营地在基地营地东端。阅读那里的{object:151286}，然后击杀魔导师。\n小心：与大法师雷姆托里相连的水晶是随机的。另外两块水晶都会改为召唤一只敌对地狱火。",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "雷姆托里的营地在营地东端。在那里阅读{object:151286}：在无限服，旁边的辛多雷宝典随后会要求营地三名军官的印记。",
	-- ["South-west along the road: {npc:235903} takes the satyrs."] = "沿道路向西南：向{npc:235903}交还萨特任务。",
	-- ["Take the zeppelin from the tower outside {zone:1454} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "从{zone:1454}城外的塔楼乘飞艇前往{zone:1420}，再骑马进入{zone:1458}。希尔瓦娜斯女士坐镇{object:36126}。",
	-- ["The Legashi satyrs"] = "雷加希萨特",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "雷加希萨特（51-52级）占据着血精灵营地以北的山丘：{npc:235903}要每种各五只。",
	-- ["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "马克林尼掘地者（50-51级）在废墟东边不远的沙地里挖掘，正好在往东北的路上；它们和那里埋藏的宝箱会给出上层精灵财宝碎片。",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "血精灵在东北的悬崖上扎营，就在{area:1227}旁边。\n小心：一个{npc:250023}（55-57级精英）站在营地西缘：从营地东侧对付血精灵。",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "血精灵在东北的悬崖上扎营，就在{area:1227}旁边。{npc:8420}的四件装备在营地周围的箱子里；血精灵奥术师身上带着{npc:247473}要的魔杖。\n小心：一个{npc:250023}（55-57级精英）站在营地西缘：从营地东侧对付血精灵。",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "飞艇塔就在{zone:1454}正门东北不远；乘坐前往{zone:1458}的飞艇。",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "塞勒姆的法师塔位于{area:1237}正北的悬崖上：{area:1237}的{npc:8395}可以免费把你传送上去（与他对话）；否则沿北侧的小路盘旋而上。",
	-- ["Zeppelin to the {zone:1458}"] = "乘飞艇前往{zone:1458}",
	-- ["Zeppelin tower"] = "飞艇塔",
	-- ["{area:1221}: kill these as you meet them"] = "{area:1221}：沿途遇到就击杀",
	-- ["{area:1237} flight master"] = "{area:1237}的飞行管理员",
	-- ["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}，来自血精灵奥术师",
	-- ["{item:246721}, from {npc:246991}"] = "{item:246721}，来自{npc:246991}",
	-- ["{item:246722}, from {npc:247013}"] = "{item:246722}，来自{npc:247013}",
	-- ["{item:246725}, from {npc:247006}"] = "{item:246725}，来自{npc:247006}",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "{npc:10778}的农场是{area:152}以东第一座农场。农场里的喋喋不休的食尸鬼携带她护符的另一半；{npc:11075}守着田里的大锅。\n小心：通常有一两只亡灵与他并肩战斗，使用大锅后还可能有更多护锅者来袭。",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}，在炼金房",
	-- ["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}，在{object:172957}：留着它去{zone:1451}",
	-- ["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}：{quest:86746}，血精灵营地北边的萨特",
	-- ["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}：{quest:91569}，从血精灵奥术师身上获取一根魔杖",
	-- ["{npc:256386} stands in the {area:380}. Open each crate she hands you and bring back what is inside."] = "{npc:256386}站在{area:380}。打开她交给你的每一个箱子，把里面的东西带回来。",
	-- ["{npc:256386}'s crates"] = "{npc:256386}的箱子",
	-- ["{npc:3326}, the {object:172960}"] = "{npc:3326}，在{object:172960}",
	-- ["{npc:4485}, {object:172958}: carried from the first {zone:1447} visit, else take it here for {npc:8576} in {area:1237}"] = "{npc:4485}在{object:172958}：首次去{zone:1447}时应已接取并保留；否则在这里接取，带给{area:1237}的{npc:8576}",
	-- ["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901}在{area:392}正北的海岸上扎营。",
	-- ["{npc:6522} stands in the {object:36073}."] = "{npc:6522}站在{object:36073}。",
	-- ["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}：{quest:91531}，交给{zone:1454}的{npc:4485}",
	-- ["{npc:8578}'s camp"] = "{npc:8578}的营地",
	-- ["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}：宝典要交给{zone:1454}的{npc:3326}",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}，在{object:172960}",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050}要交还给{area:28}的{npc:10778}：留着它。",
	-- ["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}：交给{area:1237}的{npc:8587}",
	-- ["{zone:1454} flight master"] = "{zone:1454}飞行管理员",
	-- ["{zone:1456} flight master"] = "{zone:1456}飞行管理员",
}
