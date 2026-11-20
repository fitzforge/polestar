-- Chinese (traditional) (zhTW): the guide forever/horde/50-60/04-azshara (forever/horde/50-60/04-azshara.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Jes'rimon
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}，{object:172960}",

	-- Step 2: Orgrimmar
	-- {npc:15188} Cenarion Emissary Blackhoof · {object:172957} Valley of Wisdom · {zone:1451} Silithus
	["{npc:15188}, {object:172957}: keep it for {zone:1451}"] = "{npc:15188}，{object:172957}：保留給{zone:1451}",

	-- Step 3: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} works in the Drag."] = "{npc:7010}在暗巷工作。",

	-- Step 4: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {area:976} Gadgetzan · {zone:1423} Eastern Plaguelands
	["Only if {quest:4494} isn't done yet: {npc:7010} works in the Drag. Pestlezugg takes it in {area:976} on the {zone:1423} guide's way to Un'Goro."] = "只在{quest:4494}還沒完成時：{npc:7010}在暗巷工作。{zone:1423}指南前往安戈洛的途中，會在{area:976}把它繳交給沛斯托格。",

	-- Step 5: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 6: Liv Rizzlefix
	-- {area:392} Ratchet · {object:149036} Marvon's Chest
	["Liv's workshop is at the north end of {area:392}'s docks; {object:149036} stands inside it."] = "莉芙的工作室在{area:392}碼頭北端；{object:149036}就在裡面。",
	["Inside"] = "在裡面",

	-- Step 7: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} camps on the shore just north of {area:392}."] = "{npc:5901}在{area:392}北邊不遠處的岸邊紮營。",
	-- {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Cleansed Water goes to the {area:2479} in {zone:1448}: keep it for later."] = "淨化過的水要送到{zone:1448}的{area:2479}：保留到稍後。",

	-- Step 8: Dokimi's crates
	-- {npc:256386} Dokimi
	["{npc:256386}'s crates"] = "{npc:256386}的箱子",
	-- {npc:256386} Dokimi · {area:1237} Valormok
	["Ride north up the road to the Crossroads; {npc:256386} stands there. Open each crate she hands you and bring back what is inside. Fly on to {area:1237} from the Crossroads."] = "沿著道路向北騎到十字路口；{npc:256386}站在那裡。打開她交給你的每個箱子，把裡面的東西帶回來。再從十字路口飛往{area:1237}。",

	-- Step 9: Fly to Valormok
	-- {area:1237} Valormok
	["Fly to {area:1237}"] = "飛往{area:1237}",
	["Crossroads flight master"] = "十字路口飛行管理員",

	-- Step 10: Valormok
	-- {npc:247473} Izvi Gildfizz · {quest:91569} Blue Gold
	["{npc:247473}: {quest:91569}, a wand from the blood elves' arcanists"] = "{npc:247473}：{quest:91569}，從血精靈祕法師身上取得魔杖",

	-- Step 11: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "",
	["Ride east to the ruins on the coast. The four tablets lie among the ruins, guarded by Spitelash naga (52-55): pull them one at a time."] = "向東騎到海岸上的廢墟。四塊石板散落在廢墟中，由惡鞭納迦（52-55級）守衛：一次拉一隻。",

	-- Step 12: Ruins of Eldarath
	["Ride east to the ruins on the coast. Fill Cuely's four vials at the tide pools along the shore; Spitelash naga patrol between them."] = "向東騎往海岸上的遺跡。在沿岸的潮池裝滿科雷的四個瓶子；惡鞭納迦在潮池之間巡邏。",

	-- Step 13: Makrinni Burrowers
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower
	["Makrinni Burrowers"] = "瑪克林尼掘地者",
	-- plural, as words: Makrinni Burrowers = {npc:247470} Makrinni Burrower · Highborne Treasure Fragments = {item:246684} Highborne Treasure Fragment
	["The Makrinni Burrowers (50-51) dig in the sands just east of the ruins, on the way north-east; they and the buried caches there give up the Highborne Treasure Fragments."] = "瑪克林尼掘地者（50-51級）在廢墟東邊不遠的沙地裡挖掘，就在往東北的路上；牠們和那裡埋藏的寶箱會給出精靈貴族寶藏碎片。",

	-- Step 14: Ekkal
	-- {zone:1447} Azshara · {npc:235903} Ekkal
	["On north-east across the middle of {zone:1447}: {npc:235903} camps by the road."] = "繼續往東北穿過{zone:1447}中部：{npc:235903}在路邊紮營。",
	-- {npc:235903} Ekkal · {quest:86746} The Legashi Threat
	["{npc:235903}: {quest:86746}, the satyrs north of the blood elves' camp"] = "{npc:235903}：{quest:86746}，血精靈營地北邊的薩特",

	-- Step 15: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}, just north of the blood elves."] = "向東北騎到{area:1227}上方懸崖的哥布林營地，就在血精靈北邊。",

	-- Step 16: Thalassian Base Camp
	-- {area:1227} Bay of Storms · {npc:8420} Kim'jael · {npc:247473} Izvi Gildfizz · {npc:250023} Blackmaw Thrall
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["The blood elves camp on the cliffs in the north-east, by the {area:1227}. {npc:8420}'s four pieces of equipment lie in the crates around the camp; the Blood Elf Arcanists carry {npc:247473}'s wand.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "血精靈在東北方{area:1227}旁的懸崖上紮營。{npc:8420}的四件裝備在營地周圍的箱子裡；血精靈祕法師身上帶著{npc:247473}的魔杖。\n小心：一個{npc:250023}（55-57級精英）站在營地西緣：從營地東側對付血精靈。",
	-- {item:246680} Mana-Siphoning Wand
	-- plural, as words: Blood Elf Arcanists = {npc:246920} Blood Elf Arcanist
	["{item:246680}, from the Blood Elf Arcanists"] = "{item:246680}，從血精靈祕法師身上取得",

	-- Step 17: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "{npc:8578}的營地",
	-- {object:151286} Kaldorei Tome of Summoning (no name in this language: may be words)
	["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there: on Forever the Sin'dorei Tome beside it then asks for the seals of the camp's three officers."] = "雷姆托里的營地在基地營東端。閱讀那裡的{object:151286}：在Forever上，旁邊的辛多雷之書接著會要求營地三名軍官的徽印。",

	-- Step 18: Seals of the Sin'dorei
	-- {npc:247006} Lieutenant Suncrest · {npc:247013} Ranger Lydrea · {npc:246991} Magister Hawkhelm · {npc:250023} Blackmaw Thrall
	["Each of the camp's three officers (53) carries a seal: {npc:247006} in the middle of the camp, {npc:247013} at its eastern end, and {npc:246991}, who walks its western half: take him on the east side of his walk, where the arrow points.\nCareful: the {npc:250023}, a level 55-57 elite, stands at the camp's western edge, close to the far end of Hawkhelm's walk: wait for Hawkhelm to come back east."] = "營地的三名軍官（53級）各帶著一枚徽印：營地中央的{npc:247006}、東端的{npc:247013}，以及在西半部巡邏的{npc:246991}：在他巡邏路線的東側、箭頭指的地方對付他。\n小心：{npc:250023}（55-57級精英）站在營地西緣，靠近霍克海姆巡邏路線的盡頭：等霍克海姆往東走回來。",
	-- {item:246725} Seal of the Warden · {npc:247006} Lieutenant Suncrest
	["{item:246725}, from {npc:247006}"] = "{item:246725}，來自{npc:247006}",
	-- {item:246721} Seal of the Warrior · {npc:246991} Magister Hawkhelm
	["{item:246721}, from {npc:246991}"] = "{item:246721}，來自{npc:246991}",
	-- {item:246722} Seal of the Ranger · {npc:247013} Ranger Lydrea
	["{item:246722}, from {npc:247013}"] = "{item:246722}，來自{npc:247013}",

	-- Step 19: Magus Rimtori
	-- {npc:8578} Magus Rimtori
	["Back to the Sin'dorei Tome: hand in the seals, then use it to call {npc:8578}.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "回到辛多雷之書：交上徽印，然後用它召喚{npc:8578}。\n小心：哪顆水晶連結雷姆托里是隨機的。另外兩顆各會召喚出一隻敵對的地獄火。",
	-- {quest:91538} Sin'dorei Tome of Summoning · {npc:8587} Jediga · {area:1237} Valormok
	["{quest:91538}: for {npc:8587} in {area:1237}"] = "{quest:91538}：交給{area:1237}的{npc:8587}",

	-- Step 20: The Legashi satyrs
	["The Legashi satyrs"] = "雷加希薩特",
	-- {npc:235903} Ekkal
	["The Legashi satyrs (51-52) hold the hills north of the blood elves' camp: {npc:235903} wants five of each kind."] = "雷加希薩特（51-52）佔據血精靈營地北邊的山丘：{npc:235903}要每種各五隻。",

	-- Step 21: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-west to {npc:8420}."] = "向西北回到{npc:8420}那裡。",

	-- Step 22: Ruins of Eldarath: Some Rune
	-- {area:1221} Ruins of Eldarath · {npc:8420} Kim'jael
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["Ride south to the northern edge of the {area:1221}. The Spitelash Sirens and Myrmidons (50-52) there carry {npc:8420}'s rune; it doesn't drop often, so work your way along the edge until it does."] = "向南騎到{area:1221}的北緣。那裡的惡鞭海妖和惡鞭侍從（50-52）身上帶有{npc:8420}的符文；掉落率不高，沿著邊緣一路打直到掉落為止。",

	-- Step 23: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north to {npc:8420} with the rune, then south-west along the road."] = "帶著符文向北回到{npc:8420}那裡，然後沿道路往西南走。",

	-- Step 24: Ekkal
	-- {npc:235903} Ekkal
	["South-west along the road: {npc:235903} takes the satyrs."] = "沿道路往西南：薩特任務交給{npc:235903}。",

	-- Step 25: Ag'tor Bloodfist
	-- {area:1237} Valormok
	["Ride back west to {area:1237}."] = "向西騎回{area:1237}。",
	-- {npc:8576} Ag'tor Bloodfist · {quest:91531} Revenge Exacted · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:8576}: {quest:91531}, for {npc:4485} in {zone:1454}"] = "{npc:8576}：{quest:91531}，交給{zone:1454}的{npc:4485}",
	-- {npc:8587} Jediga · {npc:3326} Zevrost · {zone:1454} Orgrimmar
	["{npc:8587}: the tome goes to {npc:3326} in {zone:1454}"] = "{npc:8587}：這本書要交給{zone:1454}的{npc:3326}",
	-- {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {npc:4485} Belgrom Rockmaul · {npc:3326} Zevrost · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1456} Thunder Bluff
	["Keep the deliveries for {npc:8659}, {npc:6522}, {npc:4485} and {npc:3326}: you pass {zone:1454} and the {zone:1458} next. Magatha's, in {zone:1456}, is off this route: leave it."] = "保留要交給{npc:8659}、{npc:6522}、{npc:4485}和{npc:3326}的任務：接下來會經過{zone:1454}和{zone:1458}。瑪加薩的任務在{zone:1456}，不在這條路線上：先放著。",

	-- Step 26: Archmage Xylem
	-- {area:1237} Valormok · {npc:8395} Sanath Lim-yo
	["Xylem's tower stands on the cliff just north of {area:1237}: {npc:8395}, in {area:1237}, teleports you up for free (talk to him); otherwise the path winds up its north side."] = "賽倫的塔位於{area:1237}北邊不遠的懸崖上：{area:1237}的{npc:8395}可以免費把你傳送上去（和他對話）；不然就從北側的蜿蜒小路上去。",
	["Upstairs"] = "樓上",

	-- Step 28: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "{area:1237}飛行管理員",

	-- Step 29: Paladin trainer
	["Paladin trainer"] = "聖騎士訓練師",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{zone:1456}的{npc:246344}；{zone:1454}沒有聖騎士訓練師",

	-- Step 30: Orgrimmar
	-- {zone:1454} Orgrimmar
	["Fly to {zone:1454} and train."] = "飛往{zone:1454}並訓練。",

	-- Step 31: Belgrom Rockmaul
	-- {zone:1454} Orgrimmar · {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {npc:3326} Zevrost · {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["Fly to {zone:1454}; {npc:4485} is in the {object:172958}, {npc:3326} and {npc:8659} in the {object:172960}."] = "飛往{zone:1454}；{npc:4485}在{object:172958}，{npc:3326}和{npc:8659}在{object:172960}。",
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow
	["{npc:3326}, the {object:172960}"] = "{npc:3326}，{object:172960}",

	-- Step 32: Into Durotar
	-- {zone:1411} Durotar
	["Into {zone:1411}"] = "進入{zone:1411}",

	-- Step 33: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "搭飛艇前往{zone:1458}",

	-- Step 34: Chemist Cuely
	-- {npc:8390} Chemist Cuely · {npc:8393} Thersa Windsong
	["{npc:8390} and {npc:8393} work in the Apothecarium."] = "{npc:8390}和{npc:8393}在鍊金房工作。",
	-- {npc:8393} Thersa Windsong
	["{npc:8393}, beside him"] = "{npc:8393}，在他旁邊",

	-- Step 35: Andron Gant
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter
	["{npc:6522} stands in the {object:36073}."] = "{npc:6522}站在{object:36073}。",

	-- Step 36: The Undercity
	-- {object:36126} Royal Quarter
	["Lady Sylvanas holds the {object:36126}."] = "希爾瓦娜斯女士在{object:36126}。",

	-- Step 39: Jeremiah Payson
	-- {npc:8403} Jeremiah Payson
	["{npc:8403}, nearby"] = "{npc:8403}，在附近",

	-- Step 40: Jeremiah Payson
	-- {quest:5050} Good Luck Charm · {npc:10778} Janice Felstone · {zone:1422} Western Plaguelands
	["{quest:5050} goes back to {npc:10778} in the {zone:1422}: keep it."] = "{quest:5050}要交回給{zone:1422}的{npc:10778}：保留此任務。",

	-- Step 41: Royal Quarter
	-- {quest:79095} The Apothecary's Metaphysical Primer · {area:159} Brill
	-- plural, as words: Library Books = {object:386691} Library Book
	["Only with {quest:79095} from {area:159}'s alchemy shop in your bags (the Library Books guide)"] = "僅在揹包中帶有從{area:159}鍊金店取得的書籍《{quest:79095}》時進行，詳見《圖書館藏書》指南",

	-- Step 43: The Bulwark
	-- {zone:1458} Undercity · {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["Ride east out of the {zone:1458} along the road; the {area:152} guards the way into the {zone:1422}."] = "從{zone:1458}沿路向東騎；{area:152}守著進入{zone:1422}的路。",
	-- {npc:11615} Mickey Levine · {area:2627} Terrordale
	["{npc:11615}: the termites are in {area:2627}, on the next guide"] = "{npc:11615}：白蟻在{area:2627}，屬於下一份指南",

	-- Step 45: Felstone Field
	-- {npc:10778} Janice Felstone · {area:152} The Bulwark · {npc:11075} Cauldron Lord Bilemaw
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field.\nCareful: One or two undead usually fight alongside him, and more cauldron lords can attack after you use the cauldron."] = "{npc:10778}的農場是{area:152}以東第一座農場。農場裡的喋喋不休的食屍鬼攜帶她護符的另一半；{npc:11075}守著田裡的大鍋。\n小心：通常有一兩隻亡靈與他並肩戰鬥，使用大鍋後還可能有更多護鍋者來襲。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Both {item:14047} donations are handed in later in the route: start saving {item:14047}."] = "兩個{item:14047}捐獻都在路線稍後繳交：開始存{item:14047}。",
	-- ["Fly to the {area:380}"] = "飛往{area:380}",
	-- ["Fly to {zone:1454}; {npc:4485} is in the {object:172958}."] = "飛往{zone:1454}；{npc:4485}在{object:172958}。",
	-- ["In the {object:172958}."] = "在{object:172958}。",
	-- ["In the {object:172961}. Have the Wool, Silk and Mageweave in your bags."] = "在{object:172961}。背包裡要有毛料、絲綢和魔紋布。",
	-- ["Open {object:149036} for the {item:10556}"] = "打開{object:149036}取得{item:10556}",
	-- ["Rimtori's camp is at the east end of the base camp. Read the {object:151286} there, then kill the Magus.\nCareful: Which crystal is linked to Rimtori is random. Each of the other two summons a hostile infernal instead."] = "雷姆托里的營地在基地營的東端。閱讀那裡的{object:151286}，然後殺死法師。\n小心：哪一顆水晶與雷姆托里相連是隨機的。另外兩顆各會召喚出一隻敵對的地獄火。",
	-- ["The blood elves camp on the cliffs in the north-east, by the {area:1227}.\nCareful: a {npc:250023}, a level 55-57 elite, stands at the west edge of the camp: work the blood elves from its east side."] = "血精靈在東北方{area:1227}旁的懸崖上紮營。\n小心：一個{npc:250023}（55-57級精英）站在營地西緣：從營地東側對付血精靈。",
	-- ["The zeppelin tower stands just north-east of {zone:1454}'s main gate; take the {zone:1458} zeppelin."] = "飛艇塔就在{zone:1454}正門東北方不遠處；搭乘前往{zone:1458}的飛艇。",
	-- ["Zeppelin tower"] = "飛艇塔",
	-- ["{npc:11044}, in the Apothecarium"] = "{npc:11044}，在 Apothecarium",
	-- ["{quest:5050} goes back to {npc:10778} in the {area:28}: keep it."] = "{quest:5050}要交回給{area:28}的{npc:10778}：保留此任務。",
}
