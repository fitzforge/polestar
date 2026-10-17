-- Chinese (traditional) (zhTW): the guide forever/horde/undead/01-tirisfal-glades (forever/horde/undead/01-tirisfal-glades.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Undertaker Mordo
	-- {area:154} Deathknell · {npc:1568} Undertaker Mordo
	["You rise in the crypt at the south end of {area:154}. {npc:1568} waits just outside."] = "你在{area:154}南端的墓穴中甦醒。{npc:1568}就在外面等著。",

	-- Step 2: Shadow Priest Sarvis
	-- {area:154} Deathknell
	["Follow the path north into {area:154}; Sarvis stands in front of the church."] = "沿著小路向北進入{area:154}；薩維斯站在教堂前。",

	-- Step 3: Mindless Zombies
	-- plural, as words: Mindless Zombies = {npc:1501} Mindless Zombie
	["Mindless Zombies"] = "無腦的殭屍",
	["The zombies shamble around the graveyard and the houses just east of the church."] = "殭屍在墓地和教堂東邊的房屋周圍蹣跚而行。",

	-- Step 4: Shadow Priest Sarvis
	-- {npc:1661} Novice Elreth
	["{npc:1661}, beside the church"] = "{npc:1661}，在教堂旁",
	-- {npc:2119} Dannal Stern
	["{npc:2119}, the warrior trainer"] = "{npc:2119}，戰士訓練師",
	-- {npc:2122} David Trias
	["{npc:2122}, the rogue trainer"] = "{npc:2122}，盜賊訓練師",
	-- {npc:2123} Dark Cleric Duesten
	["{npc:2123}, the priest trainer in the church"] = "{npc:2123}，教堂裡的牧師訓練師",
	-- {npc:2124} Isabella
	["{npc:2124}, the mage trainer, in the church"] = "{npc:2124}，法師訓練師，在教堂裡",
	-- {npc:2126} Maximillion
	["{npc:2126}, the warlock trainer"] = "{npc:2126}，術士訓練師",
	-- {area:154} Deathknell
	["The {area:154} trainers stand around the church"] = "{area:154}的訓練師們在教堂周圍",

	-- Step 5: Aramis Hammerhand and Venya Marthand
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667}"] = "{npc:244808}與{npc:5667}",
	-- {npc:244808} Aramis Hammerhand · {npc:5667} Venya Marthand
	["{npc:244808} and {npc:5667} stand beside the church."] = "{npc:244808}和{npc:5667}站在教堂旁。",
	-- {npc:1569} Shadow Priest Sarvis · {npc:244808} Aramis Hammerhand
	["{npc:1569}: the scroll for {npc:244808}"] = "{npc:1569}：給{npc:244808}的卷軸",

	-- Step 6: Rattlecages, scavengers and duskbats
	["Rattlecages, scavengers and duskbats"] = "斷骨骷髏、食腐狼和夜行蝙蝠",
	-- {area:154} Deathknell
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton · Young Scavengers = {npc:1508} Young Scavenger · Duskbats = {npc:1512} Duskbat · Ragged Scavengers = {npc:1509} Ragged Scavenger · Mangy Duskbats = {npc:1513} Mangy Duskbat
	["Rattlecage Skeletons wander the ruined houses in the north half of {area:154}. Young Scavengers and Duskbats roam all around the village; the Ragged Scavengers and Mangy Duskbats are on its east side."] = "斷骨骷髏在{area:154}北半部的廢墟房屋間遊蕩。小食腐狼和夜行蝙蝠在村莊各處遊蕩；蓬毛食腐狼和癩皮夜行蝙蝠在村莊東側。",

	-- Step 7: Rattlecage skulls
	["Rattlecage skulls"] = "斷骨骷髏的頭骨",
	-- plural, as words: Rattlecage Skeletons = {npc:1890} Rattlecage Skeleton
	["The Rattlecage Skeletons in the ruined houses drop the skulls."] = "廢墟房屋中的斷骨骷髏會掉落頭骨。",

	-- Step 8: Back to the church
	["Back to the church"] = "回到教堂",
	-- {npc:1570} Executor Arren
	["{npc:1570}, in the church"] = "{npc:1570}，在教堂裡",

	-- Step 9: Aramis Hammerhand and Venya Marthand
	-- {quest:90902} Rediscovering the Light · {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Paladins: {quest:90902} is done once you have healed five {npc:259377} around the church with {spell:635}."] = "聖騎士：用{spell:635}治療教堂周圍五名{npc:259377}後，{quest:90902}即完成。",

	-- Step 10: Scavenging Deathknell
	-- {object:164662} Equipment Boxes · {area:154} Deathknell
	["The {object:164662} lie beside the ruined houses in the north of {area:154}."] = "{object:164662}在{area:154}北部的廢墟房屋旁。",

	-- Step 11: Night Web's Hollow
	-- plural, as words: Young Night Web Spiders = {npc:1504} Young Night Web Spider · Night Web Spiders = {npc:1505} Night Web Spider
	["Head west to the cave. The Young Night Web Spiders sit outside; the Night Web Spiders and the Webbed Victims are inside."] = "向西前往洞穴。小夜行蜘蛛在洞外；夜行蜘蛛和被蛛網纏住的受害者在洞內。",
	-- {npc:244808} Aramis Hammerhand
	["Free six Webbed Victims inside the cave for {npc:244808}"] = "為{npc:244808}解救洞內六名被蛛網纏住的受害者",
	["Webbed Victims"] = "被蛛網纏住的受害者",

	-- Step 12: Back to Deathknell
	-- {area:154} Deathknell
	["Back to {area:154}"] = "返回{area:154}",

	-- Step 13: The Frightened Paladin
	-- {npc:246143} Frightened Paladin
	["The {npc:246143}"] = "{npc:246143}",
	-- {quest:91208} Coming to Terms · {npc:246143} Frightened Paladin
	["{quest:91208}: the {npc:246143} fled into the hills just west of the church."] = "{quest:91208}：{npc:246143}逃到了教堂西邊的山丘上。",
	-- {npc:246143} Frightened Paladin
	["Offer aid to the {npc:246143}"] = "向{npc:246143}伸出援手",

	-- Step 14: The Scarlet farm
	["The Scarlet farm"] = "血色十字軍農場",
	-- {area:154} Deathknell · {npc:1919} Samuel Fipps · {quest:6395} Marla's Last Wish
	-- plural, as words: Scarlet Converts = {npc:1506} Scarlet Convert
	["The Scarlet Converts and Initiates hold the farm east of {area:154}. {npc:1919} wanders between the farmhouses: his remains are for {quest:6395}."] = "血色信徒和血色新兵佔據{area:154}東邊的農場。{npc:1919}在農舍之間遊蕩：他的遺骸用於{quest:6395}。",
	-- {item:16333} Samuel's Remains · {npc:1919} Samuel Fipps
	["{item:16333}, from {npc:1919}"] = "{item:16333}，來自{npc:1919}",

	-- Step 15: Marla's Grave
	-- {object:178090} Marla's Grave · {area:154} Deathknell
	["{object:178090} is in the {area:154} graveyard, beside the church."] = "{object:178090}在{area:154}的墓地，教堂旁邊。",

	-- Step 17: Meven Korgal
	-- {npc:1667} Meven Korgal
	["{npc:1667} stands at the south end of the Scarlet farm."] = "{npc:1667}站在血色十字軍農場的南端。",

	-- Step 19: Calvin Montague
	-- {area:154} Deathknell · {npc:6784} Calvin Montague · {area:156} Solliden Farmstead
	["Leave {area:154} by the road north-east. {npc:6784} stands by the farmhouse at the {area:156}."] = "沿著東北方的道路離開{area:154}。{npc:6784}站在{area:156}的農舍旁。",

	-- Step 20: Gordo
	-- {npc:10666} Gordo · {item:12737} Gloom Weed
	["{npc:10666}, the big abomination, walks the road a little further east. The {item:12737} grows along the road around him."] = "{npc:10666}是一個大型憎惡，在道路更東邊一點走動。{item:12737}沿著他周圍的道路生長。",

	-- Step 21: Brill
	-- {area:159} Brill · {npc:10665} Junior Apothecary Holland · {area:2119} Gallows' End Tavern · {npc:1515} Executor Zygand
	["Follow the road east to {area:159}. {npc:10665} stands at the north-west edge of town; the {area:2119} is the big inn in the middle, with {npc:1515} in front of it."] = "沿著道路向東前往{area:159}。{npc:10665}站在城鎮西北邊緣；{area:2119}是鎮中央的大旅店，{npc:1515}就在門前。",
	-- {npc:246152} Shari Stilwell
	["{npc:246152}, the Paladin trainer"] = "{npc:246152}，聖騎士訓練師",
	-- {npc:1496} Deathguard Dillinger
	["Ask {npc:1496} for his report"] = "向{npc:1496}索取報告",
	-- {area:159} Brill
	["The {area:159} trainers are in and around the inn"] = "{area:159}的訓練師在旅店內外",

	-- Step 22: Discipline
	-- {item:286176} Executor's Motivator
	["Use the {item:286176} on five idle Deathguards around town"] = "對城鎮周圍五名閒置的亡靈衛兵使用{item:286176}",

	-- Step 23: Doom Weed
	-- {quest:5482} Doom Weed · {area:159} Brill
	["The {quest:5482} grows in the graveyard fields just north of {area:159}."] = "{quest:5482}生長在{area:159}北邊的墓地田野中。",

	-- Step 25: Dry Branches
	["Dry Branches"] = "乾樹枝",
	-- {area:159} Brill
	["The Dry Branches lie on the ground around the south-west edge of {area:159}."] = "乾樹枝散落在{area:159}西南邊緣周圍的地上。",

	-- Step 26: Eleanor Shackleton
	["Eleanor camps just south-west of town."] = "她在城鎮西南方紮營。",
	-- {spell:1229451} Boosted Rest
	["/sit by her campfire until you get {spell:1229451}"] = "在她的營火旁/sit，直到獲得{spell:1229451}",

	-- Step 27: Fields west of Brill
	-- {area:159} Brill
	["Fields west of {area:159}"] = "{area:159}西邊的田野",
	-- {npc:1525} Rotting Dead · {area:159} Brill · {npc:10666} Gordo
	-- plural, as words: Ravaged Corpses = {npc:1526} Ravaged Corpse
	["{npc:1525} and Ravaged Corpses shamble through the fields just west of {area:159}; Darkhounds roam a little further west, toward {npc:10666}."] = "{npc:1525}和破碎的屍體在{area:159}西邊的田野中蹣跚而行；黑暗犬在更西邊一點、朝{npc:10666}的方向遊蕩。",

	-- Step 28: Gordo
	-- {npc:10666} Gordo
	["Ask {npc:10666} for his report"] = "向{npc:10666}索取報告",

	-- Step 29: Calvin Montague
	-- {npc:6784} Calvin Montague
	["Walk on west to {npc:6784} and talk to him: he wants a duel."] = "向西走到{npc:6784}那裡和他交談：他想和你決鬥。",
	-- {npc:6784} Calvin Montague
	["Beat {npc:6784} in the duel"] = "在決鬥中擊敗{npc:6784}",

	-- Step 30: Hearth to Brill
	-- {area:159} Brill
	["Hearth to {area:159}"] = "用爐石回{area:159}",

	-- Step 31: Brill
	-- {npc:2132} Carolai Anise
	["{npc:2132}, beside Johaan"] = "{npc:2132}，在喬漢旁邊",
	["in the inn: ask him about cooking"] = "在旅店裡：向他詢問烹飪",
	-- {npc:265944} William Pickman
	["Talk to {npc:265944}"] = "與{npc:265944}交談",
	["The Wanted poster by the inn"] = "旅店旁的通緝告示",
	-- {npc:1499} Magistrate Sevren
	["{npc:1499}, in the town hall"] = "{npc:1499}，在市政廳裡",
	-- {npc:1500} Coleman Farthing
	["{npc:1500}, in the inn"] = "{npc:1500}，在旅店裡",
	-- {item:2320} Coarse Thread · {npc:2118} Abigail Shiel
	["{item:2320} from {npc:2118}, for Gretchen"] = "向{npc:2118}購買{item:2320}，給格莉絲",

	-- Step 32: Greater Duskbats
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats"] = "巨型夜行蝙蝠",
	-- {area:159} Brill
	-- plural, as words: Greater Duskbats = {npc:1553} Greater Duskbat
	["Greater Duskbats fly over the fields around {area:159} and along the road north."] = "巨型夜行蝙蝠在{area:159}周圍的田野上空以及北邊的道路沿線飛行。",

	-- Step 33: Rot Hide graveyards
	["Rot Hide graveyards"] = "腐皮豺狼人的墓地",
	-- {area:159} Brill
	-- plural, as words: Rot Hide Graverobbers = {npc:1941} Rot Hide Graverobber
	["The Rot Hide Graverobbers dig through the graveyards north of {area:159}; all the Rot Hides drop the ichor."] = "腐皮盜墓賊在{area:159}北邊的墓地挖掘；所有腐皮豺狼人都會掉落膿液。",

	-- Step 34: Maggot Eye
	-- {npc:1753} Maggot Eye
	-- plural, as words: Rot Hide Mongrels = {npc:1675} Rot Hide Mongrel
	["The Rot Hide Mongrels hold the hills further north. {npc:1753} (level 11) stands in their camp on the hill south of the shore: clear the gnolls around him first."] = "混血腐皮豺狼人佔據更北邊的山丘。{npc:1753}（等級11）站在海岸南邊山丘上的營地裡：先清掉他周圍的豺狼人。",

	-- Step 35: Vile Fin murlocs
	["Vile Fin murlocs"] = "邪鰭魚人",
	["The Vile Fin murlocs line the north shore."] = "邪鰭魚人分布在北岸。",

	-- Step 36: Brill
	-- {area:159} Brill
	["Follow the road south back to {area:159}."] = "沿著道路向南回到{area:159}。",

	-- Step 37: Deathguard Linnea
	-- {area:159} Brill · {npc:3549} Shelene Rhobart
	["Follow the road south-east from {area:159} past the zeppelin towers. Linnea, Kristof and {npc:3549} camp by the road."] = "沿著道路從{area:159}向東南經過飛艇塔。林奈、克里斯多夫和{npc:3549}在路旁紮營。",
	-- {npc:1495} Deathguard Linnea · {npc:276020} Riptear
	["{npc:1495}: {npc:276020}, an elite abomination in the east"] = "{npc:1495}：{npc:276020}，東邊的一個精英憎惡",
	-- {npc:251001} Deathguard Kristof
	["Ask {npc:251001} for his report"] = "向{npc:251001}索取報告",

	-- Step 38: Magistrate Sevren
	-- {area:159} Brill
	["Back up the road to {area:159}."] = "沿路回到{area:159}。",

	-- Step 39: Agamand Mills
	-- {area:157} Agamand Mills · {npc:1657} Devlin Agamand · {npc:1656} Thurman Agamand · {item:2839} A Letter to Yvette · {npc:3549} Shelene Rhobart
	-- plural, as words: Cracked Skull Soldiers = {npc:1523} Cracked Skull Soldier · Darkeye Bonecasters = {npc:1522} Darkeye Bonecaster · Duskbats = {npc:1512} Duskbat
	["Follow the road north-west to {area:157}. {npc:1657} walks the graveyard south of the mills; Nissa, Gregor and {npc:1656} haunt the mills themselves. Rattlecage and Cracked Skull Soldiers drop the ribs, Darkeye Bonecasters the skulls, and any of them may drop {item:2839}. From here on, kill the Duskbats and Darkhounds you pass: {npc:3549} wants their wings and hides."] = "沿著道路向西北前往{area:157}。{npc:1657}在磨坊南邊的墓地走動；妮薩、格里高和{npc:1656}則在磨坊內徘徊。斷骨骷髏和碎顱士兵會掉落肋骨，暗眼骷髏法師掉落頭骨，牠們都可能掉落{item:2839}。從現在起，擊殺沿途遇到的夜行蝙蝠和黑暗犬：{npc:3549}要牠們的翅膀和外皮。",
	-- {item:2839} A Letter to Yvette
	["{item:2839}, a rare drop"] = "{item:2839}，稀有掉落",
	["Only if the letter dropped"] = "僅限信件有掉落時",

	-- Step 40: Deathguard Simmer
	-- {area:156} Solliden Farmstead
	["Walk south-west to the {area:156}; Simmer stands at the farm."] = "向西南走到{area:156}；希米爾站在農場裡。",

	-- Step 41: Tirisfal Pumpkins
	-- plural, as words: Tirisfal Pumpkins = {object:375} Tirisfal Pumpkin
	["Tirisfal Pumpkins"] = "提里斯法南瓜",
	["The pumpkins grow in the Scarlet-held fields north-west of Solliden."] = "南瓜生長在索利丹西北方、血色十字軍佔據的田地裡。",

	-- Step 42: Crusader's Outpost
	["Crusader's Outpost"] = "十字軍前哨",
	-- {npc:275954} Bareth Dawnstone
	-- plural, as words: Scarlet Warriors = {npc:1535} Scarlet Warrior
	["Scarlet Warriors guard the outpost just west of the pumpkin fields. {npc:275954} is held inside: talk to him and stay with him until he is out."] = "血色戰士守衛著南瓜田西邊的前哨。{npc:275954}被關在裡面：和他交談，一直陪著他直到他脫困。",
	-- {npc:275954} Bareth Dawnstone
	["Escort {npc:275954} out of the outpost"] = "護送{npc:275954}離開前哨",

	-- Step 43: Vile Fin shore
	["Vile Fin shore"] = "邪鰭海岸",
	["More Vile Fin murlocs walk the shore just north of the outpost."] = "更多的邪鰭魚人在前哨北邊的海岸走動。",

	-- Step 44: Paladin: Whispering Forest
	-- {area:16616} Whispering Forest
	["Paladin: {area:16616}"] = "聖騎士：{area:16616}",
	-- {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["Head west into the {area:16616}; {npc:246389} and {npc:259190} camp at its edge."] = "向西進入{area:16616}；{npc:246389}和{npc:259190}在森林邊緣紮營。",

	-- Step 45: Shadowvale
	-- {area:16881} Shadowvale · {item:286269} Glowing Crystal Fragment
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher
	["{area:16881} is the hollow at the west edge of the glades. The Shadowvale Lurchers and Mystics drop the bones; the bottles lie on the ground among them, and the {item:286269} is at the south end."] = "{area:16881}是林地西緣的窪地。暗影谷蹣跚者和暗影谷秘法師會掉落骨頭；瓶子散落在牠們之間的地上，{item:286269}在南端。",

	-- Step 48: Brill
	-- {npc:1560} Yvette Farthing
	["{npc:1560}, in the inn"] = "{npc:1560}，在旅店裡",
	-- {npc:1931} Captured Scarlet Zealot
	["The {npc:1931}, in the town hall basement"] = "{npc:1931}，在市政廳地下室",
	-- {npc:2128} Cain Firesong · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity
	["{npc:2128}: {npc:4568} in the {zone:1458} takes it"] = "{npc:2128}：由{zone:1458}的{npc:4568}接收",

	-- Step 49: Ulag the Cleaver
	-- {npc:1496} Deathguard Dillinger · {area:159} Brill · {npc:6390} Ulag the Cleaver
	["{npc:1496} stands in {area:159}. {npc:6390} waits in the mausoleum on the hill just north of town: open the gate and fight him."] = "{npc:1496}站在{area:159}。{npc:6390}在城鎮北邊山丘上的陵墓裡等候：打開大門和他戰鬥。",

	-- Step 50: Carendin Halgar
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:5675} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "從{area:159}向南走到{area:153}，再往下進入{zone:1458}。{npc:5675}站在{object:36082}。血色十字軍營地就在廢墟西邊。",

	-- Step 51: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:4568} stands in the {object:36082}. The Scarlet camp is just west of the ruins."] = "從{area:159}向南走到{area:153}，再往下進入{zone:1458}。{npc:4568}站在{object:36082}。血色十字軍營地就在廢墟西邊。",

	-- Step 52: The Scarlet camp
	["The Scarlet camp"] = "血色十字軍營地",
	-- {area:159} Brill · {npc:1662} Captain Perrine
	["Follow the road south-west from {area:159} to the Scarlet Crusade camp. {npc:1662} stands at its south end; every Scarlet there can drop a ring."] = "沿著道路從{area:159}向西南前往血色十字軍營地。{npc:1662}站在營地南端；那裡的每個血色十字軍都可能掉落戒指。",

	-- Step 53: Perrine's Chest
	-- {object:37098} Perrine's Chest · {npc:1662} Captain Perrine
	["{object:37098} stands beside {npc:1662} at the camp's south end."] = "{object:37098}在營地南端的{npc:1662}旁邊。",

	-- Step 55: Deathguard Terrence
	-- {area:159} Brill
	["Take the road south-east out of {area:159}; Terrence stands on it short of the zeppelin towers."] = "沿著東南方的道路離開{area:159}；特倫斯站在路上，在飛艇塔之前。",

	-- Step 56: Hadric Harlson
	-- {npc:267009} Hadric Harlson · {npc:1495} Deathguard Linnea
	["{npc:267009} stands at {npc:1495}'s camp."] = "{npc:267009}站在{npc:1495}的營地裡。",

	-- Step 57: Balnir Farmstead
	-- {quest:96897} The Cult of the Damned
	-- plural, as words: Necrotic Crystal Fragments = {item:275851} Necrotic Crystal Fragment
	["{quest:96897} holds the farm just south-east of the camp. The Necrotic Crystal Fragments lie on the ground among the cultists, and the cultists carry some too."] = "{quest:96897}佔據營地東南方的農場。死靈水晶碎片散落在教徒之間的地上，教徒身上也帶著一些。",

	-- Step 58: Balnir graves
	["Balnir graves"] = "巴尼爾墓地",
	-- {quest:99142} Tomb Weed
	-- plural, as words: Bleeding Horrors = {npc:1529} Bleeding Horror · Wandering Spirits = {npc:1532} Wandering Spirit
	["Follow the road east. Bleeding Horrors and Wandering Spirits haunt the graves on the east side of the farmstead, where the {quest:99142} grows."] = "沿著道路向東。可怕的血殭屍和遊蕩的幽靈在農場東側的墓地出沒，{quest:99142}就生長在那裡。",
	-- {item:7227} Balnir Snapdragons
	["{item:7227}, in the farmstead's garden"] = "{item:7227}，在農場的花園裡",

	-- Step 59: Captain Vachon
	-- {npc:1664} Captain Vachon
	-- plural, as words: Scarlet Friars = {npc:1538} Scarlet Friar
	["The Scarlet Friars camp just north-east of the graves; {npc:1664} stands among them."] = "血色苦行修士在墓地東北方紮營；{npc:1664}站在他們之中。",

	-- Step 60: Vicious Night Web Spiders
	-- plural, as words: Vicious Night Web Spiders = {npc:1555} Vicious Night Web Spider
	["Vicious Night Web Spiders"] = "邪惡的夜行蜘蛛",
	-- {npc:276020} Riptear
	["The spiders lurk in the woods at the far east end of the glades. {npc:276020}, a rogue abomination, wanders just north-west of them. {npc:276020} is elite: grouping up is advised."] = "蜘蛛潛伏在林地最東端的樹林裡。{npc:276020}是一個失控的憎惡，在牠們西北方遊蕩。{npc:276020}是精英：建議組隊。",
	-- {item:286326} Riptear's Heart · {npc:276020} Riptear
	["{item:286326}, from {npc:276020}"] = "{item:286326}，來自{npc:276020}",

	-- Step 61: Hides for the Forsaken
	-- plural, as words: Duskbats = {npc:1512} Duskbat
	["Duskbats and Darkhounds roam all along the road back west; finish the wings and hides on the way."] = "夜行蝙蝠和黑暗犬在往西的回程道路沿線遊蕩；順路把翅膀和外皮收集完。",

	-- Step 62: Deathguard Linnea's camp
	-- {npc:1495} Deathguard Linnea
	["{npc:1495}'s camp"] = "{npc:1495}的營地",

	-- Step 63: Brill
	-- {npc:2211} Captured Mountaineer
	["The {npc:2211}, in the town hall basement"] = "{npc:2211}，在市政廳地下室",

	-- Step 64: Captain Melrache
	-- {area:159} Brill · {area:162} Brightwater Lake · {npc:1665} Captain Melrache · {area:459} Scarlet Watch Post
	-- plural, as words: Scarlet Bodyguards = {npc:1660} Scarlet Bodyguard
	["Follow the road north-east from {area:159} past {area:162}. {npc:1665} and his two Scarlet Bodyguards hold the Scarlet watchtower on the north-east coast, north of the {area:459}: pull the bodyguards first."] = "沿著道路從{area:159}向東北經過{area:162}。{npc:1665}和他的兩名血色保鏢佔據東北海岸的血色十字軍瞭望塔，位於{area:459}北邊：先把保鏢拉開。",

	-- Step 65: Executor Zygand
	-- {area:159} Brill
	["Back to {area:159}."] = "回到{area:159}。",

	-- Step 66: Leonid Barthalomew
	-- {area:157} Agamand Mills · {area:16616} Whispering Forest · {npc:246389} Hilda the Breaker
	["Follow the road west past {area:157} to the {area:16616}. Leonid stands just north of {npc:246389}'s camp."] = "沿著道路向西經過{area:157}前往{area:16616}。萊尼德站在{npc:246389}營地北邊。",
	-- {npc:246378} Danitha Morr
	["Listen to Leonid and {npc:246378}, then talk to him again"] = "聽萊尼德和{npc:246378}交談，然後再和他說話",

	-- Step 68: The Undercity
	-- {object:1661} The Undercity · {area:153} Ruins of Lordaeron · {npc:5675} Carendin Halgar · {object:36082} Magic Quarter · {item:6284} Runes of Summoning · {npc:4606} Aelthalyste · {object:36070} War Quarter · {npc:4568} Anastasia Hartwell
	["{object:1661} is under the {area:153}, beside the zeppelin towers. {npc:5675} is in the {object:36082}: use the {item:6284} on the summoning circle beside him and defeat the voidwalker. {npc:4606} is in the {object:36070}. {npc:4568} is in the {object:36082} too."] = "{object:1661}在{area:153}底下，飛艇塔旁邊。{npc:5675}在{object:36082}：在他旁邊的召喚法陣使用{item:6284}，擊敗虛空行者。{npc:4606}在{object:36070}。{npc:4568}也在{object:36082}。",

	-- Step 69: Zeppelin to Durotar
	-- {zone:1411} Durotar
	["Zeppelin to {zone:1411}"] = "搭飛艇前往{zone:1411}",
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Walk south-east from {area:159} to the zeppelin towers outside the {area:153} and board the zeppelin to {zone:1454} (the other one goes to {object:3202})."] = "從{area:159}向東南走到{area:153}外的飛艇塔，搭乘前往{zone:1454}的飛艇（另一艘前往{object:3202}）。",
	["Zeppelin tower"] = "飛艇塔",

	-- Step 70: The Crossroads
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:815} Southfury River · {area:379} Far Watch Post · {area:380} The Crossroads
	["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "飛艇停靠在{zone:1454}正門東北方的塔。沿著道路向南進入{zone:1411}，在{area:379}下方過{area:815}的橋，再沿著道路向西前往{area:380}。",
	-- {npc:3615} Devrak
	["{npc:3615}, the wind rider master"] = "{npc:3615}，雙足飛龍管理員",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The zeppelin lands at the tower just north-east of {zone:1454}'s main gate. Follow the road south into {zone:1411}, cross the {area:815} bridge below {area:379} and follow the road west to the {area:380}."] = "飛艇停靠在{zone:1454}正門東北方的塔。沿著道路向南進入{zone:1411}，在{area:379}下方過{area:815}的橋，再沿著道路向西前往{area:380}。",
}
