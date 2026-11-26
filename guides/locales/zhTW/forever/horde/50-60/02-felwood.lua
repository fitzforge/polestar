-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/02-felwood (forever/horde/50-60/02-felwood.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1422} Western Plaguelands · {area:152} Bulwark · {zone:1447} Azshara · {zone:1448} Felwood
	["{zone:1422} and the {area:152} first, then {zone:1447} and {zone:1448}."] = "先去{zone:1422}和{area:152}，再去{zone:1447}和{zone:1448}。",

	-- Step 1: Mulgris Deepriver
	-- {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["He camps by the {area:202}, south-east of {area:200}."] = "他在{area:200}東南方的{area:202}旁紮營。",
	["Inside"] = "在裡面",

	-- Step 2: Diseased Wolves
	["Diseased Wolves"] = "生病的狼",
	-- {area:200} Dalson's Tears · {area:202} Writhing Haunt
	["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east. Careful: the biggest are 54: pull them one at a time."] = "狼群在安多哈爾、{area:200}和{area:202}之間的田野遊蕩。在往東騎回去的路上把牠們殺完。注意：最大的有54級：一次拉一隻。",

	-- Step 3: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "{area:200}農舍",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse, the cabinet stands inside and the outhouse is behind it. A {npc:10816} carries the outhouse key; {npc:10836} comes out when you open the outhouse and carries the cabinet key."] = "日記在農舍裡，櫃子在屋內，廁所在屋後。一隻{npc:10816}帶著廁所鑰匙；打開廁所時{npc:10836}會出來，他身上帶著櫃子鑰匙。",

	-- Step 4: Mulgris Deepriver
	["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands guide's sweep at about 55."] = "",

	-- Step 6: High Executor Derrington
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "你在路線之前來這裡時錯過了這一步：現在先做它。它很快，還會開啟後面的任務。",
	-- {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries
	["{item:12814}, from the {object:176092} next to Derrington"] = "{item:12814}，來自德靈頓旁邊的{object:176092}",

	-- Step 7: Box of Incendiaries
	-- {quest:5096} Scarlet Diversions · {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries · {npc:10837} High Executor Derrington
	["{quest:5096} needs a {item:12814} to torch the command tent: take one from the {object:176092} next to {npc:10837}."] = "{quest:5096}需要一個{item:12814}來點燃指揮帳篷：從{npc:10837}旁邊的{object:176092}拿一個。",
	-- {item:12814} Flame in a Bottle · {object:176092} Box of Incendiaries
	["{item:12814}, from the {object:176092}"] = "{item:12814}，來自{object:176092}",

	-- Step 8: Scarlet forward camp
	["Scarlet forward camp"] = "血色十字軍前進營地",
	-- {area:152} Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {item:12814} Flame in a Bottle
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {item:12814} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "從{area:152}沿路向東進入{zone:1422}。血色十字軍的帳篷就在費爾斯通農場後面，在{area:199}和{area:200}之間。用{item:12814}點燃指揮帳篷，插上天譴旗幟。小心：帳篷周圍的血色十字軍最高54級，祈求者會施法：從離指揮帳篷最近的一側進入，別管其他人。",

	-- Step 9: Bulwark
	-- {area:152} Bulwark
	["Ride south-west past Felstone Farm and follow the road west back to the {area:152}."] = "向西南騎過費爾斯通農場，沿著道路向西回到{area:152}。",
	["Derrington's watchtowers and Vandis' cauldron are done on a later visit: keep them."] = "德靈頓的瞭望塔和范蒂絲的大鍋會在之後造訪時完成：先保留。",

	-- Step 11: Paladin trainer
	["Paladin trainer"] = "聖騎士訓練師",
	-- {npc:246152} Shari Stilwell · {zone:1420} Tirisfal Glades · {zone:1454} Orgrimmar
	["{npc:246152} in {zone:1420}; {zone:1454} has no paladin trainer"] = "{npc:246152}在{zone:1420}；{zone:1454}沒有聖騎士訓練師",

	-- Step 12: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",

	-- Step 13: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "{zone:1454}中部",

	-- Step 14: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659} takes the ravasaur claws from Un'Goro; he is in {object:172959}, upstairs in one of its tallest buildings."] = "",
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "",

	-- Step 15: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "飛往{area:1237}",
	-- {zone:1447} Azshara · {zone:1454} Orgrimmar
	["{zone:1447} is a short flight from {zone:1454}: its quests are 51-55, at your level now."] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 16: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}：{quest:91569}，從血精靈祕法師身上取得魔杖",

	-- Step 17: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "{area:1221}：遇到就殺",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "向東騎到海岸上的廢墟。四塊石板散落在廢墟中，由惡鞭納迦（52-55級）守衛：一次拉一隻。",

	-- Step 18: Ruins of Eldarath
	-- {item:10695} Box of Empty Vials · {area:1231} Southridge Beach · {npc:8390} Chemist Cuely · {zone:1458} Undercity
	["Open Cuely's {item:10695} in your bags for the four labelled vials. The tide pools cannot be clicked: stand in each pool and use its own vial from your bags, from {area:1231} north up the coast; Spitelash naga patrol between them. No vials? Abandon the quest and take it again from {npc:8390} in the {zone:1458}."] = "",
	-- {item:10691} Filled Vial Labeled #1 · {area:1231} Southridge Beach
	["{item:10691}: the tide pool on {area:1231}"] = "",
	["#2, north along the shore"] = "",

	-- Step 19: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "瑪克林尼掘地者",
	-- {npc:247473} Izvi Gildfizz · {item:246683} Treasure Trowel 3000
	-- plural, as words: Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment · Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["{npc:247473}'s {item:246683}, in your bags, digs up the Highborne Treasure Fragments: use it on the sands just east of the ruins, where the Makrinni Burrowers (50-51) dig, on the way north-east. The Burrowers and the buried caches there give fragments too."] = "",

	-- Step 20: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "繼續往東北穿過{zone:1447}中部：{npc:235903}在路邊紮營。",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}：{quest:86746}，血精靈營地北邊的薩特",

	-- Step 21: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "向東北騎到{area:1227}上方懸崖的哥布林營地，就在血精靈北邊。",

	-- Step 22: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "血精靈在東北方{area:1227}旁的懸崖上紮營。{npc:8420}的四件裝備在營地周圍的箱子裡；血精靈祕法師身上帶著{npc:247473}的魔杖。\n小心：一個{npc:250023}（55-57級精英）站在營地西緣：從營地東側對付血精靈。",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}，從血精靈祕法師身上取得",

	-- Step 23: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}的營地",
	-- {object:151286} Kaldorei Tome of Summoning (no name in this language: may be words)
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "雷姆托里的營地在基地營東端。閱讀那裡的{object:151286}：在Forever上，旁邊的辛多雷之書接著會要求營地三名軍官的徽印。",

	-- Step 24: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "營地的三名軍官（53級）各帶著一枚徽印：營地中央的{npc:247006}、東端的{npc:247013}，以及在西半部巡邏的{npc:246991}：在他巡邏路線的東側、箭頭指的地方對付他。\n小心：{npc:250023}（55-57級精英）站在營地西緣，靠近霍克海姆巡邏路線的盡頭：等霍克海姆往東走回來。",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}，來自{npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}，來自{npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}，來自{npc:247013}",

	-- Step 25: Magus Rimtori
	-- {quest:91500} An Explosive Gambit · {quest:91497} Seals of the Sin'dorei
	["Back to the Sin'dorei Tome: hand in the seals and take {quest:91500}, which gives you the {quest:91497}. Rimtori does not come from the Tome: stand beside one of the camp's tall crystals and use the {quest:91497} from your bags; its crystal explodes and draws her. Which crystal is linked to her is random: each of the other two summons a hostile infernal instead. She is level 55: start at full health."] = "",
	-- {quest:91497} Seals of the Sin'dorei · {npc:8578} Magus Rimtori
	["Use the {quest:91497} from your bags beside a crystal: {npc:8578} (55) comes to the explosion and drops her head"] = "",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}：交給{area:1237}的{npc:8587}",

	-- Step 26: The Legashi satyrs
	["The Legashi satyrs"] = "雷加希薩特",
	-- {npc:235903} Ekkal · {npc:235892} Prince Halanox
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind.\nCareful: {npc:235892} (55, elite) stands among the satyrs at the north-east end of their hills, around 67,19: take the satyrs nearer the camp and leave him be."] = "",

	-- Step 27: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "向西北回到{npc:8420}那裡。",

	-- Step 28: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "向南騎到{area:1221}的北緣。那裡的惡鞭海妖和惡鞭侍從（50-52）身上帶有{npc:8420}的符文；掉落率不高，沿著邊緣一路打直到掉落為止。",

	-- Step 29: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "帶著符文向北回到{npc:8420}那裡，然後沿道路往西南走。",

	-- Step 30: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "沿道路往西南：薩特任務交給{npc:235903}。",

	-- Step 31: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "向西騎回{area:1237}。",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}：{quest:91531}，交給{zone:1454}的{npc:4485}",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}：這本書要交給{zone:1454}的{npc:3326}",
	-- {npc:8659} Jes'rimon · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {npc:6522} Andron Gant · {zone:1458} Undercity
	["Keep the deliveries: {npc:8659}, {npc:4485} and {npc:3326} are in {zone:1454} next, Magatha in {zone:1456} and {npc:6522} in the {zone:1458} on the next guides."] = "",

	-- Step 32: Sanath Lim-yo
	-- {area:1237} Valormok · {npc:8379} Archmage Xylem
	["Ride east from {area:1237} to Sanath's camp at the foot of the cliff and get off your mount: he teleports you up to {npc:8379}'s tower."] = "",

	-- Step 33: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "塔頂的學徒會把你送回去。",
	["Upstairs"] = "樓上",

	-- Step 35: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "{area:1237}飛行管理員",

	-- Step 36: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:4485} is in the {object:172958}, {npc:3326} in the {object:172960}, and {npc:8659} in {object:172959}, upstairs in one of its tallest buildings."] = "",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow
	["{npc:3326}, the {object:172960}"] = "{npc:3326}，{object:172960}",
	-- {npc:8659} Jes'rimon · {npc:8587} Jediga
	["{npc:8659}: his payment goes back to {npc:8587}, on the flight out"] = "",

	-- Step 37: Class trainer
	["Class trainer"] = "職業訓練師",

	-- Step 38: Druid trainer
	["Druid trainer"] = "德魯伊訓練師",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {zone:1454} Orgrimmar
	["{npc:3034} in {zone:1412}; {zone:1454} has no druid trainer"] = "{npc:3034}在{zone:1412}；{zone:1454}沒有德魯伊訓練師",

	-- Step 39: Fly to Valormok
	-- {zone:1448} Felwood · {area:1237} Valormok · {npc:8587} Jediga · {npc:8659} Jes'rimon · {area:431} Splintertree Post
	["{zone:1448} is next: fly by way of {area:1237}, where {npc:8587} takes {npc:8659}'s payment, then on to {area:431}."] = "",

	-- Step 41: Fly to Splintertree Post
	-- {area:431} Splintertree Post
	["Fly to {area:431}"] = "飛往{area:431}",

	-- Step 43: Emerald Sanctuary
	["The druids' camp is just past the border."] = "德魯伊的營地就在邊界過去一點。",
	-- {npc:10920} Kelek Skykeeper · {npc:10921} Taronn Redfeather · {quest:86577} A Sampling of Putrescence · {zone:1448} Felwood
	["{npc:10920}, beside {npc:10921}: {quest:86577}, the organs of {zone:1448}'s bears and wolves"] = "{npc:10920}，在{npc:10921}旁邊：{quest:86577}，{zone:1448}熊和狼的內臟",
	-- {npc:11554} Grazle
	["{npc:11554}, at the south edge of the camp"] = "{npc:11554}，在營地南緣",
	-- {npc:9529} Maybess Riverbreeze
	["{npc:9529}, on the west side of the camp"] = "{npc:9529}，在營地西側",

	-- Step 44: Deadwood Village
	-- {area:1769} Timbermaw Hold
	["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers."] = "死木熊怪的村莊就在翡翠聖地正南。每殺一個死木熊怪也會提升你在{area:1769}的聲望；留著死木頭飾羽毛。",

	-- Step 45: Southern Jaedenar
	-- {area:1763} Jaedenar
	["Southern {area:1763}"] = "{area:1763}南部",
	-- {area:1763} Jaedenar · {npc:11141} Spirit of Trey Lightforge
	["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds.\nCareful: the {npc:11141} (53, elite) haunts the west end of {area:1763}, around 35,60: pull the cultists and hounds away from him."] = "",

	-- Step 47: The Jaedenar moonwell
	-- {area:1763} Jaedenar
	["The {area:1763} moonwell"] = "{area:1763}月井",
	-- {area:1763} Jaedenar
	["Back north to {area:1763}. Fill Greta's canteen at the corrupted moonwell in the middle of the southern camp."] = "向北回到{area:1763}。在南方營地中央的腐化月井裝滿葛瑞塔的水壺。",

	-- Step 48: Bloodvenom Post
	-- {area:1763} Jaedenar
	["The Horde camp just north of {area:1763}."] = "{area:1763}北邊的部落營地。",
	-- {npc:10306} Trull Failbane · {zone:1452} Winterspring
	["{npc:10306}: the owlbeasts are in {zone:1452}"] = "{npc:10306}：梟獸在{zone:1452}",

	-- Step 49: Shatter Scar Vale
	-- plural, as words: Entropic Beasts = {npc:9878} Entropic Beast
	["East of Bloodvenom Post, the cratered vale where the Entropic Beasts and Horrors roam. Kill two of each, then walk to each of the three fel-water craters."] = "在血毒崗哨東邊，熱能野獸和熱能恐獸遊蕩的坑窪山谷。各擊殺兩隻，然後走到三個魔化水坑的每一個。",
	["Southern crater"] = "南方坑洞",
	["Western crater"] = "西方坑洞",
	["Northern crater"] = "北方坑洞",

	-- Step 50: Statue of Malorne
	-- {object:661778} Statue of Malorne (no name in this language: may be words) · {npc:9996} Winna Hazzard · {area:1997} Bloodvenom Post
	["The {object:661778} stands just south of the vale, by the road north: its bauble starts a quest for {npc:9996} at {area:1997}."] = "瑪洛恩雕像就在山谷南邊、往北的路旁：它的飾物會開啟一個交給{area:1997}的{npc:9996}的任務。",

	-- Step 51: Irontree Woods
	-- {area:1767} Irontree Woods · {npc:10920} Kelek Skykeeper · {npc:9529} Maybess Riverbreeze · {item:11503} Blood Amber · {area:1768} Irontree Cavern
	-- plural, as words: Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north-east to {area:1767}: Angerclaw Grizzlies and Felpaw Ravagers roam the woods for Talo, and their organs are {npc:10920}'s. {npc:9529}'s {item:11503} comes from the Warpwood elementals inside {area:1768}, next."] = "",
	-- {item:277958} Putrescent Bear Organs
	["{item:277958}, from the Angerclaw bears"] = "{item:277958}，來自怒爪熊",
	-- {item:277959} Putrescent Wolf Organs
	["{item:277959}, from the Felpaw wolves"] = "{item:277959}，來自魔爪狼",

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
	["The road ends at {npc:15395}, outside the {area:1769} tunnel in the far north-east."] = "道路盡頭是{npc:15395}，在東北角的{area:1769}隧道外。",

	-- Step 55: Felpaw Village
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {area:1769} Timbermaw Hold
	-- plural, as words: Deadwood Avengers = {npc:7157} Deadwood Avenger
	["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nIf one drops a {quest:8470} (about one kill in thirty), right-click it; don't stay to farm one. {npc:11558} in {area:1769} takes it only from Neutral with the Timbermaw (the {area:1769} reputation guide gets you there): now if they already are, or on the last guide's pass of the cave."] = "",
	-- {quest:8470} Deadwood Ritual Totem
	["{quest:8470}, a rare drop from the Deadwood furbolgs"] = "",

	-- Step 56: Nafien
	-- {quest:8465} Speak to Salfa · {zone:1452} Winterspring
	["Keep {quest:8465} for {zone:1452}."] = "保留{quest:8465}，留到{zone:1452}。",

	-- Step 57: Timbermaw Hold
	-- {npc:11558} Kernda
	["Step into the cave: {npc:11558} stands just inside. She speaks to you only from Neutral with the Timbermaw."] = "",
	-- {npc:11558} Kernda
	["{npc:11558} walks around here: look inside the circle on the map"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {item:13140} dropped: use it to start the quest, then free {npc:11018} from her cage in {area:1770}, the cave at the north end of {area:1763}."] = "掉落了{item:13140}：用它開始任務，然後從{area:1763}北端的洞穴{area:1770}的籠子裡釋放{npc:11018}。",
	-- ["Back at {area:1762}, the Deadwood furbolgs (53-54) are close to the tunnel and every kill raises your Timbermaw reputation."] = "回到{area:1762}，死木熊怪（53-54級）就在隧道附近，每次擊殺都會提升你的木喉聲望。",
	-- ["Below ground"] = "地下",
	-- ["Careful: Den Watchers are level 53-54 and the Deadwood Avengers 54-55; they call nearby allies within 25 yd once below 50% health and run off for help below 15%.\nKeep killing them until one drops a {quest:8470}, about one kill in thirty, then right-click it: {npc:11558} in {area:1769} takes it once the Timbermaw are Neutral to you, now if they already are, or when the last guide passes the cave again at 59."] = "注意：死木守衛為53-54級，死木復仇者為54-55級；生命值低於50%時會呼叫25碼內的同伴，低於15%時會逃跑求援。\n持續擊殺直到掉落{quest:8470}，約三十隻掉一個，然後右鍵點擊它：{area:1769}的{npc:11558}要等木喉對你中立才會接受，若已中立現在就交，否則等最後一份指南在59級再次經過洞穴時繳交。",
	-- ["Cross the river east into {area:2627}, the ruined town in the north-west of the {zone:1423}. {npc:12384} sits in a hut at its edge."] = "向東渡河進入{area:2627}，那是{zone:1423}西北部的廢墟城鎮。{npc:12384}坐在城鎮邊緣的一間小屋裡。",
	-- ["Derrington's watchtowers, Vandis' cauldron and {npc:11615}'s barrel are done on a later visit: keep them."] = "德靈頓的瞭望塔、范蒂絲的大鍋和{npc:11615}的木桶會在之後造訪時完成：先保留。",
	-- ["Diseased Grizzlies"] = "生病的灰熊",
	-- ["Fly to the {area:1497}"] = "飛往{area:1497}",
	-- ["Fly to {area:272}"] = "飛往{area:272}",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo, and their organs are {npc:10920}'s.\n{area:1762}'s Deadwood Den Watchers (53-54) and Avengers (54-55) are next: below level 54, keep hunting the grizzlies and ravagers (51-52) here until 54. The hand-ins at {area:1769}, the {area:2479} and {area:1997} that follow take you most of the way to 55. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "沿著道路向東北前往{area:1767}。樹林東側的扭木食苔者和撕裂者各帶有一個{item:11503}；怒爪灰熊和魔爪劫毀者在同一片樹林遊蕩，是塔羅的任務目標，牠們的內臟則交給{npc:10920}。\n接下來是{area:1762}的死木守衛（53-54級）和復仇者（54-55級）：低於54級時，繼續在這裡獵殺灰熊和劫毀者（51-52級）直到54級。之後在{area:1769}、{area:2479}和{area:1997}的繳交會讓你接近55級。或者，有小隊的話，改打{area:1417}地城或{area:1584}地城。",
	-- ["Follow the road north-east to {area:1767}. The Warpwood Moss Flayers and Shredders on the east side of the woods each carry a {item:11503}; Angerclaw Grizzlies and Felpaw Ravagers roam the same woods for Talo. Below level 54.21, keep hunting the grizzlies and ravagers: the hand-ins at {area:1997} and the {area:2479} take you to level 55. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "沿著道路向東北前往{area:1767}。樹林東側的曲木食苔者和曲木撕裂者各帶有一個{item:11503}；怒爪灰熊和魔爪掠奪者在同一片樹林遊蕩，是塔羅的任務目標。低於54.21級時，繼續獵殺灰熊和掠奪者：{area:1997}和{area:2479}的繳交會讓你升到55級。或者，有隊伍的話，改打{area:1584}地城或{area:1417}地城。",
	-- ["Follow the road north-west. The south of {area:1763}, around its corrupted moonwell, is held by Shadow Council cultists, adepts, guardsmen and their hounds."] = "沿著道路向西北走。{area:1763}南部的腐化月井周圍，由加德納爾祭司、加德納爾精兵、加德納爾守護者和加德納爾惡犬佔據。",
	-- ["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "從{area:152}沿著道路向東進入{zone:1422}。血色十字軍的帳篷就在費爾斯通農場過去一點，位於{area:199}和{area:200}之間。用{object:176092}燒掉指揮帳篷，並插上天災戰旗。注意：帳篷周圍的血色十字軍最高54級，祈咒者會施法：從最靠近指揮帳篷的一側進入，別理其他人。",
	-- ["From {area:2268}'s flight master, fly to the {area:1497}."] = "從{area:2268}的飛行管理員處飛往{area:1497}。",
	-- ["His next hunt, the Diseased Grizzlies (55-56), waits for the Plaguelands visit at about 58."] = "他的下一個狩獵任務，染病的灰熊（55-56級），留到約58級造訪瘟疫之地時再做。",
	-- ["Jadefire moonwell"] = "碧火月井",
	-- ["Keep Little Pamela: Pamela is in {area:2262}, visited again later."] = "保留小潘蜜拉：帕米拉在{area:2262}，之後會再去。",
	-- ["Keep the branch: {npc:5770} is in {zone:1456}."] = "保留樹枝：{npc:5770}在{zone:1456}。",
	-- ["Keep the parcel: {npc:10781} is in the {area:1497}."] = "保留包裹：{npc:10781}在{area:1497}。",
	-- ["Keep {quest:5158}: {npc:5901} is in the {zone:1413}."] = "保留{quest:5158}：{npc:5901}在{zone:1413}。",
	-- ["Keep {quest:6164}: {npc:12384} takes it back on the {zone:1423} guide's {area:2627} stop."] = "保留{quest:6164}：{npc:12384}會在{zone:1423}指南的{area:2627}站收回它。",
	-- ["Knights and magi work the {area:192}; the medics and hunters camp south of it."] = "血色騎士和血色法師在{area:192}工作；血色醫護員和血色獵人在它南邊紮營。",
	-- ["Leave the {area:1497} and ride east along the road through {zone:1420}, past the {area:152}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "離開{area:1497}，沿著道路向東穿過{zone:1420}，經過{area:152}。費爾斯通農場是道路旁的第一座農場；{npc:10778}在屋裡等候。",
	-- ["Level 53"] = "等級53",
	-- ["Level 55"] = "等級55",
	-- ["Only with 5 Deadwood Headdress Feathers"] = "僅限擁有5根死木頭飾羽毛時",
	-- ["Radley and Durgen"] = "萊德雷與杜爾根",
	-- ["Ride back south past {area:1763} to the corrupted moonwell of the Jadefire satyrs and fill {npc:9996}'s flasket there."] = "向南騎回去經過{area:1763}，前往碧火薩特的腐化月井，在那裡裝滿{npc:9996}的小瓶。",
	-- ["Ride back south-east to the Sanctuary."] = "騎回東南方的聖地。",
	-- ["Ride back to the {area:1497}, take the zeppelin to {zone:1454} and fly to {area:431}. Follow the road west out of Splintertree and take the fork north into {zone:1448}."] = "騎回{area:1497}，搭飛艇前往{zone:1454}，再飛往{area:431}。沿著道路向西離開碎木崗哨，在岔路往北進入{zone:1448}。",
	-- ["Ride back west over the river and on to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "向西騎回河對岸，繼續前往{area:192}；{npc:11610}躲在它東北方的山丘上。",
	-- ["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "向東騎往海岸上的遺跡。在沿岸的潮池裝滿科雷的四個瓶子；惡鞭納迦在潮池之間巡邏。",
	-- ["Ride north along the eastern hills; {npc:1855} lives in a small house by the {area:2619}, at the border with the {zone:1423}."] = "沿著東側山丘向北騎；{npc:1855}住在{area:2619}旁的一間小屋，位於與{zone:1423}的邊界。",
	-- ["Ride north up the road again."] = "再次沿著道路向北騎。",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "向西北騎進安多哈爾。{npc:10667}在城鎮西側的廢墟旅店裡等候；裡面的骷髏是54-57級，所以沿著邊緣走。",
	-- ["Ride south past the {area:202} to {area:197}; {npc:10927}'s house stands by the road, and {npc:10936}'s monument is in the graveyard behind it. Kill the Diseased Wolves you meet in the fields on the way."] = "向南騎過{area:202}前往{area:197}；{npc:10927}的房子在路旁，{npc:10936}的紀念碑在房子後面的墓地裡。沿途擊殺田野中遇到的生病的狼。",
	-- ["Ride the road south through {area:361} to the Sanctuary."] = "沿著道路向南穿過{area:361}前往聖地。",
	-- ["Ride the road south through {zone:1448} to the Sanctuary."] = "沿著道路向南穿過{zone:1448}前往聖地。",
	-- ["Ride west to the {area:192}; {npc:11610} hides on the hill north-east of it."] = "向西騎往{area:192}；{npc:11610}躲在它東北方的山丘上。",
	-- ["Ror stands at the far south end of {area:1761}."] = "洛爾站在{area:1761}的最南端。",
	-- ["Scarlet Crusade"] = "血色十字軍",
	-- ["Scarlet forward camp"] = "血色十字軍前進營地",
	-- ["Step into the cave: {npc:11558} stands just inside."] = "走進洞穴：{npc:11558}就站在入口內。",
	-- ["Take the kitten to the same moonwell and release it there with {item:12565}; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "把小貓帶到同一個月井，用{item:12565}在那裡放出牠；牠變成{npc:10042}後，把牠帶回給{npc:9996}，點擊牠來交給她。",
	-- ["Take the kitten to the same moonwell and release it there; once it has turned into a {npc:10042}, bring it back to {npc:9996} and click on it to hand it over."] = "把小貓帶到同一個月井並在那裡放出牠；牠變成{npc:10042}後，把牠帶回給{npc:9996}，點擊牠來交給她。",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "歷史書在安多哈爾市政廳的發黴的書籍之中；逐一打開直到找到正確的那本。",
	-- ["The Deadwood furbolg village just west of the tunnel. {npc:9462} (56) stands among them. {npc:11557}, a friendly furbolg, sits at the north end of the village."] = "就在隧道西邊的死木熊怪村莊。{npc:9462}（56級）站在牠們之中。友善的熊怪{npc:11557}坐在村莊北端。",
	-- ["The Deadwood furbolg village lies just south of the Sanctuary. Every Deadwood kill also raises your {area:1769} reputation; keep the headdress feathers. Keep killing them until level 53.92: the Sanctuary's next hand-ins and {area:1763} want it. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "死木熊怪村莊就在聖地南邊。每擊殺一個死木熊怪也會提升你的{area:1769}聲望；保留頭飾羽毛。持續擊殺到53.92級：聖地接下來的繳交和{area:1763}都需要這個等級。或者，有隊伍的話，改打{area:1417}地城或{area:1584}地城。",
	-- ["The Jadefire moonwell"] = "碧火月井",
	-- ["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "雷加希薩特（51-52）佔據血精靈營地北邊的山丘：{npc:235903}要每種各五隻。",
	-- ["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "瑪克林尼掘地者（50-51級）在廢墟東邊不遠的沙地裡挖掘，就在往東北的路上；牠們和那裡埋藏的寶箱會給出精靈貴族寶藏碎片。",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "血色十字軍的帳篷位於{area:199}和{area:200}之間。用{object:176092}燒掉指揮帳篷，並插上天災戰旗。",
	-- ["The bears roam the hills north and east of the {area:202}."] = "熊在{area:202}北邊和東邊的山丘遊蕩。",
	-- ["The book lies in the ruined inn of {area:2627}; the undead in the town are 54-56, so pull them one at a time.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "書在{area:2627}的廢墟旅店裡；鎮上的不死生物是54-56級，所以一次拉一隻。\n大型白蟻丘遍布{area:2627}東邊的山丘。對經過的每個白蟻丘使用{item:15042}。",
	-- ["The succubus {npc:9518} waits in the middle of {area:1763}, beside the {npc:11020}."] = "魅魔{npc:9518}在{area:1763}中央，{npc:11020}旁邊等候。",
	-- ["The wolves roam the fields between Andorhal, {area:200} and the {area:202}. Finish them on the ride back east."] = "狼群在安多哈爾、{area:200}和{area:202}之間的田野遊蕩。在往東騎回去的路上把牠們殺完。",
	-- ["The {area:152}"] = "{area:152}",
	-- ["Through {area:1769}"] = "穿過{area:1769}",
	-- ["To {zone:1448}"] = "前往{zone:1448}",
	-- ["Top up here to level 52.63 before the hand-ins at {area:200}: they take you to level 53. The Carrion Lurkers (52-53) west of the Scarlet camp are at your level; the Scarlet Mages and Knights (54-56) are higher. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "先在這裡刷到52.63級，再去{area:200}繳交任務，交完會升到53級。血色營地西邊的腐蟲潛伏者（52-53級）與你等級相當；血色法師和血色騎士（54-56級）等級更高。或者，組隊去打{area:1417}地城或{area:2100}地城。",
	-- ["Top up here to level 53 before {npc:10739} sends you after the Diseased Grizzlies (55-56): the Carrion Lurkers (52-53) on the way from {area:200} to the {area:202} are at your level. Or, with a group, run the {area:1417} dungeon or the {area:1584} dungeon instead."] = "在{npc:10739}派你去對付生病的灰熊（55-56級）之前，先在這裡刷到53級：從{area:200}到{area:202}路上的腐蟲潛伏者（52-53級）與你等級相當。或者，組隊去打{area:1417}地城或{area:1584}地城。",
	-- ["Walk into the {area:1769} tunnel beside {npc:15395} and never attack the Timbermaw furbolgs inside. The tunnel opens into {zone:1452}; follow the road east to {area:2255}, the goblin town where the next guide starts."] = "走進{npc:15395}旁邊的{area:1769}隧道，絕對不要攻擊裡面的木喉熊怪。隧道通往{zone:1452}；沿著道路向東前往哥布林城鎮{area:2255}，下一份指南從那裡開始。",
	-- ["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nTake a {object:176092} from the crate next to Derrington for {quest:5096}."] = "你在路線之前來這裡時錯過了這一步：現在先做它。它很快，還會開啟後面的任務。\n從德靈頓旁邊的箱子拿一個{object:176092}，用於{quest:5096}。",
	-- ["grind on Deadwood Avengers at {area:1762}, {zone:1448}"] = "在{zone:1448}的{area:1762}擊殺死木復仇者練等",
	-- ["grind on Scarlet Knights at {area:192}, {zone:1422}"] = "在{zone:1422}的{area:192}擊殺血色騎士練等",
	-- ["grind on {npc:7157}"] = "刷{npc:7157}",
	-- ["grind on {npc:8957}"] = "刷{npc:8957}",
	-- ["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out."] = "{area:190}的血色十字軍是58-60級。騎進去到地圖上標示的高處，俯瞰城鎮，然後離開。",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627}：遇到就擊殺",
	-- ["{item:12565}, at the Jadefire moonwell"] = "{item:12565}，在碧火月井",
	-- ["{npc:10840}, at the graveyard's south end"] = "{npc:10840}，在墓地南端",
	-- ["{npc:11557}: keep 30 {quest:6031} for him; he trades only at Neutral with the Timbermaw; below ground"] = "{npc:11557}：為他保留30塊{quest:6031}；他只在木喉聲望達到中立時才交易；在地下",
	-- ["{npc:11558}, at the tunnel mouth"] = "{npc:11558}，在隧道口",
	-- ["{npc:11558}: the Timbermaw speak to you only from Neutral; walks around here: look inside the circle on the map"] = "{npc:11558}：木喉熊怪只有在中立以上才會和你說話；會在這附近走動：在地圖上的圓圈內找他",
	-- ["{npc:11610}'s last task needs level 53. The Scarlet Knights and Magi (54-55) working the lumber camp just south-west of her are the closest camp."] = "{npc:11610}的最後一個任務需要等級53。在她西南方伐木場工作的血色騎士和血色法師（54-55級）是最近的營地。",
	-- ["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}."] = "{npc:11613}站在伐木場東邊；{npc:11611}守衛著{npc:11610}東北方、通往{area:190}的道路。",
	-- ["{npc:1855}'s hunts are in the {zone:1423}: keep them for later."] = "{npc:1855}的狩獵任務在{zone:1423}：先保留。",
	-- ["{npc:8659} takes the ravasaur claws from Un'Goro; he stands in the {object:172960}, a short walk from the middle of the city."] = "{npc:8659}收下安戈洛的恐龍爪；他站在{object:172960}，從城市中央走一小段路就到。",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}，{object:172960}",
	-- ["{npc:9529}, just west of the camp"] = "{npc:9529}，就在營地西邊",
	-- ["{npc:9529}, on the west side of the Sanctuary"] = "{npc:9529}，在聖地西側",
	-- ["{npc:9996}'s kitten"] = "{npc:9996}的小貓",
	-- ["{npc:9996}: the {quest:86612}"] = "{npc:9996}：{quest:86612}",
	-- ["{object:175894}, beside the house"] = "{object:175894}，在房子旁邊",
	-- ["{quest:5210} goes to {area:2268}: keep it for later."] = "{quest:5210}要交到{area:2268}：先保留。",
	-- ["{quest:5408}: the {area:2627} undead drop them while you wear the {item:12846}"] = "{quest:5408}：佩戴{item:12846}時，{area:2627}的不死生物會掉落",
	-- ["{quest:8470}, a rare drop"] = "{quest:8470}，稀有掉落",
	-- ["{zone:1452}'s quests are 55-58. Below 55 after {npc:9996}'s hand-ins? {area:1762}'s Deadwood furbolgs (53-55) are at your level and on your way north to {area:1769}'s tunnel: kill them until level 55. Every kill also raises your Timbermaw reputation. Careful: the Den Watchers and Avengers call nearby allies once below half health and run off for help when nearly dead: pull one at a time from the village's edge. This is a long top-up for a player who follows only this route. Or, with a group, run the {area:1584} dungeon or the {area:1417} dungeon instead."] = "{zone:1452}的任務是55-58級。繳交完{npc:9996}的任務後還不到55級？{area:1762}的死木熊怪（53-55級）等級剛好，又在你往北前往{area:1769}隧道的路上：殺牠們直到55級。每次擊殺也會提升木喉要塞的聲望。小心：死木守衛和死木復仇者血量低於一半時會呼叫附近的同伴，快死時會逃跑求援：從村莊邊緣一次拉一隻。對只跟著這條路線的玩家來說，這段補經驗會很久。或者，組個小隊改打{area:1584}地城或{area:1417}地城。",
}
