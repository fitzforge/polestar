-- Chinese (simplified) (zhCN): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飞往{area:42}",
	-- {area:42} Darkshire · {zone:1431} Duskwood · {area:69} Lakeshire
	["Fly to {area:42} for {zone:1431}'s second loop: from {area:69}'s gryphon master if you come from the Redridge guide."] = "飞往{area:42}，进行{zone:1431}的第二轮：如果你来自赤脊山指南，从{area:69}的狮鹫管理员处起飞。",

	-- Step 2: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "她的房子在{area:42}东南方的山上，{area:121}上方。",
	["Inside"] = "在里面",
	-- {item:1946} Mary's Looking Glass · {npc:511} Insane Ghoul
	["{item:1946}: the {npc:511}, in the crypt of the cemetery just below"] = "",

	-- Step 3: Tranquil Gardens Cemetery
	-- {npc:511} Insane Ghoul · {area:121} Tranquil Gardens Cemetery · {area:42} Darkshire
	["The {npc:511} (26) hides in the small crypt by the {area:121}, south of {area:42}; the glass is inside."] = "",
	-- {item:1946} Mary's Looking Glass
	["{item:1946}; inside"] = "{item:1946}：在屋内",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}：{zone:1431}怪物的稀有掉落",

	-- Step 4: Viktori Prism'Antras
	-- {area:42} Darkshire · {npc:276} Viktori Prism'Antras
	["North into {area:42}: {npc:276}'s house stands at the east end of town, on the way in."] = "",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}：在屋内",
	-- {quest:177} Look to the Stars · {zone:1431} Duskwood
	["{quest:177}: the ogres of Vul'Gol, on your {zone:1431} return"] = "",

	-- Step 6: Abercrombie
	["Head west along the road once more."] = "再次沿路向西走。",

	-- Step 7: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492}：沿途击杀以下目标",
	-- {npc:311} Sven Yorgen · {area:94} Raven Hill · {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Fiends = {npc:531} Skeletal Fiend · Skeletal Horrors = {npc:202} Skeletal Horror
	["On the way west to {npc:311}: Skeletal Fiends and Skeletal Horrors walk the cemetery's southern half, north of {area:94}. {npc:522}, an elite, wanders the graves: keep away from him."] = "",

	-- Step 8: Gooey Spider Legs
	-- plural, as words: Gooey Spider Legs = {item:2251} Gooey Spider Leg
	["Gooey Spider Legs"] = "粘糊的蜘蛛腿",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Venom Web Spiders = {npc:217} Venom Web Spider · Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["Carrion Recluses lurk in the woods on the way west, and Venom Web Spiders, Pygmy Venom Web Spiders and Green Recluses crawl just south of {npc:311}'s camp: each can drop a leg."] = "食腐独行蛛潜伏在西行路上的树林里，结网毒蜘蛛、小型结网毒蜘蛛和绿色独行蛛在{npc:311}营地南边爬行：每种都可能掉蜘蛛腿。",

	-- Step 9: Lars
	-- {npc:893} Lars · {npc:311} Sven Yorgen
	["{npc:893}, at {npc:311}'s camp"] = "{npc:893}，在{npc:311}的营地",

	-- Step 11: Moonbrook
	-- {quest:67} The Legend of Stalvan · {npc:311} Sven Yorgen · {zone:1436} Westfall · {area:20} Moonbrook · {object:3643} Old Footlocker · {area:42} Darkshire
	["{quest:67}: west from {npc:311}'s camp over the border into {zone:1436} and on to {area:20}, where the {object:3643} stands among the Defias (15-18). Then hearth back to {area:42}."] = "",

	-- Step 12: Moonbrook
	-- {quest:67} The Legend of Stalvan · {object:3643} Old Footlocker · {area:20} Moonbrook · {area:42} Darkshire
	["{quest:67}: the {object:3643} in {area:20}, among the Defias (15-18), holds the next part. Then hearth back to {area:42}."] = "{quest:67}：{area:20}里迪菲亚（15-18）中间的{object:3643}存放着下一部分。然后用炉石回到{area:42}。",

	-- Step 13: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "回到{area:42}",
	-- {area:42} Darkshire
	["Hearth back to {area:42} if you bound at the Scarlet Raven Tavern on the first loop, or head back east along the road."] = "若第一圈时把炉石绑在了血鸦旅店，就炉石回{area:42}；不然就沿大路往东走回去。",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "{npc:265}：在屋内",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}，在市政厅",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}，在市政厅",
	-- {npc:264} Commander Althea Ebonlocke · {npc:289} Abercrombie
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["{npc:264}: the Plague Spreaders, with {npc:289}'s ghouls on the next trip west"] = "",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}，在酒馆里",

	-- Step 14: Clerk Daltry
	-- {quest:68} The Legend of Stalvan · {npc:267} Clerk Daltry
	["{quest:68}: {npc:267}, in the town hall, takes the footlocker's contents."] = "",
	-- {npc:267} Clerk Daltry · {npc:295} Innkeeper Farley · {area:87} Goldshire · {zone:1453} Stormwind
	["{npc:267}: for {npc:295} in {area:87}, on the walk north to {zone:1453}"] = "",

	-- Step 15: Chef Grual
	-- {npc:272} Chef Grual
	["{npc:272} is in the Scarlet Raven Tavern too."] = "{npc:272}也在血鸦旅店里。",
	-- {npc:288} Jitters · {area:94} Raven Hill
	["For {npc:288}, at {area:94} on the way west"] = "给{npc:288}：在西行路上的{area:94}",

	-- Step 16: Chef Grual
	-- {npc:272} Chef Grual
	["{npc:272} is in the Scarlet Raven Tavern."] = "{npc:272}在血鸦旅店里。",

	-- Step 17: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "{item:1598}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "{npc:202}在{area:42}与{area:121}之间、镇子东南方的山坡上游荡；它们掉落{item:1598}。",

	-- Step 19: Abercrombie
	["Head west to the hermit once more."] = "再次向西去找隐士。",

	-- Step 20: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "食尸鬼的肋骨",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms · {npc:503} Lord Malathrom · {npc:771} Commander Felstrom · {npc:1200} Morbent Fel
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters and Bone Chewers (24-27) are the easier kills; Plague Spreaders and Brain Eaters (27-29) drop them too. {npc:522}, an elite, wanders the graves: keep away from him.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds.\nCareful: {npc:503} (31) and {npc:771} (32), both rares, haunt the cemetery's north and west, and {npc:1200} (32, elite) keeps to the house at its western edge: leave them be."] = "",
	-- {npc:604} Plague Spreader · {quest:58} The Night Watch
	["{npc:604}, for {quest:58}"] = "",

	-- Step 22: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288}躲在{area:94}西端的房子里。",

	-- Step 25: Skeletal Raiders
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders"] = "",
	-- {area:492} Raven Hill Cemetery · {npc:311} Sven Yorgen · {npc:522} Mor'Ladim · {npc:771} Commander Felstrom
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["From level 28: the Skeletal Raiders, Healers and Warders stand in the west part of the {area:492}, just east of {npc:311}'s camp.\nCareful: The Warders are 28-29 and the skeletons stand close together: pull one at a time.\nCareful: {npc:522}, an elite (35), wanders these graves too, and {npc:771} (32, rare) haunts the west part: keep away from both."] = "",

	-- Step 26: Sven Yorgen
	-- {zone:1453} Stormwind · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["Next: training, then the flight from {zone:1453} to {area:150} for the {zone:1437}."] = "接下来：学习技能，再从 {zone:1453} 飞往 {area:150}，前往 {zone:1437}。",
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}'s Cathedral, on the walk north"] = "",

	-- Step 28: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "从{area:94}沿路向西进入{zone:1436}。{npc:7024}在刚过边界的山丘上监视{npc:7053}的高塔。守塔的{npc:7051}（23 级）携带钥匙，克拉文·摩特维克的日记在塔顶箱子里。",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}，在箱子里",

	-- Step 29: Master Mathias Shaw
	-- {area:1519} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {area:1519}; Mathias Shaw is at SI:7 in {object:2100}."] = "向北穿过艾尔文森林前往{area:1519}。马迪亚斯·肖尔在{object:2100}的军情七处。",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}：毒药，以及{item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}：{npc:7207}，在兵营地下室",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "在{npc:7207}旁边 /lay down",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}：{npc:1313}，炼金用品",
	-- {item:4371} Bronze Tube · {object:2096} Trade District · {npc:5519} Billibub Cogspinner
	["{item:4371}: the Auction House, {object:2096}; {npc:5519} keeps one and is nearly always sold out"] = "{item:4371}：拍卖行，{object:2096}；{npc:5519}备着一根，但几乎总是售罄",

	-- Step 30: Elwynn Forest
	-- {area:94} Raven Hill · {area:87} Goldshire · {zone:1453} Stormwind
	["North from {area:94} through Elwynn: {area:87} is on the road to {zone:1453}."] = "从 {area:94} 向北穿过艾尔文森林：去 {zone:1453} 的路上会经过 {area:87}。",

	-- Step 31: Class trainer
	["Class trainer"] = "职业训练师",
	["Your new spells"] = "你的新法术",

	-- Step 32: Innkeeper Farley
	-- {quest:69} The Legend of Stalvan · {npc:295} Innkeeper Farley · {area:87} Goldshire
	["{quest:69}: {npc:295} is in {area:87}'s Lion's Pride Inn; the chest with the letter is upstairs."] = "",
	-- {item:910} An Undelivered Letter · {object:1560} Storage Chest
	["{item:910}, from the {object:1560} upstairs"] = "",

	-- Step 33: Caretaker Folsom
	-- {zone:1453} Stormwind · {npc:297} Caretaker Folsom · {object:1561} Sealed Crate
	["On into {zone:1453}: {npc:297} (the arrow shows him) takes the letter; the {object:1561} beside him holds the next clue."] = "",
	-- {object:1561} Sealed Crate
	["{object:1561}, beside him"] = "",

	-- Step 34: Bishop Farthing
	-- {zone:1453} Stormwind · {npc:1212} Bishop Farthing · {npc:1217} Glorin Steelbrow · {area:150} Menethil Harbor
	["On into {zone:1453}: {npc:1212} stands in the Cathedral of Light, on the way to the gryphon master. His next quest is for {npc:1217} in {area:150}, where the flight lands."] = "",
	-- {npc:1212} Bishop Farthing
	["{npc:1212}, in the Cathedral of Light"] = "",
	-- {npc:1217} Glorin Steelbrow · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["For {npc:1217} in {area:150} (the {zone:1437} guide)"] = "",

	-- Step 35: Gazin Tenorm
	-- {zone:1453} Stormwind · {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["On into {zone:1453}: {npc:6173} and {npc:6171} are in the Cathedral of Light, on the way to the gryphon master."] = "继续前往 {zone:1453}：{npc:6173} 和 {npc:6171} 在圣光大教堂，去狮鹫管理员处时顺路经过。",
	["Cathedral of Light"] = "光明大教堂",

	-- Step 36: Gazin Tenorm
	-- {item:6846} Defias Script · {npc:6173} Gazin Tenorm · {quest:1787} The Tome of Divinity
	["The {item:6846} is already with {npc:6173}: take the last part of {quest:1787} from him, in the Cathedral of Light."] = "{item:6846}已经交给{npc:6173}：在光明大教堂里从他那里接取{quest:1787}的最后一部分。",

	-- Step 37: Duthorian Rall
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm
	["{npc:6171} stands in the Cathedral of Light, beside {npc:6173}."] = "{npc:6171}站在光明大教堂里，在{npc:6173}旁边。",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}：救赎",

	-- Step 38: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "{zone:1453}的{object:28027}",

	-- Step 39: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁前往{zone:1455}",

	-- Step 40: Shaman training
	["Shaman training"] = "萨满祭司训练",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453}没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，在{npc:258098}处学习，然后乘地铁返回。",

	-- Step 41: Rogue training
	["Rogue training"] = "学习潜行者技能",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "继续出发前，先在{zone:1453}学习技能。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:69} gryphon master: fly to {area:42} for {zone:1431}'s second loop."] = "返回 {area:69} 的狮鹫管理员处，飞往 {area:42}，进行 {zone:1431} 的第二轮路线。",
	-- ["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "继续向西到{area:94}。{object:673515}在道路南边的废弃房屋旁发光。",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters and Bone Chewers (24-27) are the easier kills; Plague Spreaders and Brain Eaters (27-29) drop them too. {npc:522}, an elite, wanders the graves: keep away from him.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "{area:492}北半部的所有食尸鬼都可能掉落肋骨：{npc:3}和{npc:210}（24-27级）比较好打；{npc:604}和{npc:570}（27-29级）也会掉。精英{npc:522}在墓间游荡：远离他。\n小心：{npc:948}死亡时会施放{spell:3428}，召来额外的敌人。",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "{area:492}北半部的所有食尸鬼都可能掉落肋骨：食腐者、噬骨者、瘟疫食尸鬼和食脑者。",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "{area:492}北半部的所有食尸鬼均有几率掉落肋骨，包括食腐者、噬骨者、瘟疫食尸鬼和食脑者。\n注意：{npc:948}死亡时会施放{spell:3428}，召来额外的敌人。",
	-- ["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "沿道路向西北经过墓地，前往森林最西缘的{npc:311}营地。{npc:893}站在{npc:311}旁边。",
	-- ["Follow the road south from {area:1002} into {area:10}; {area:42} lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "沿道路从{area:1002}向南进入{area:10}；{area:42}位于森林东侧。\n没有{quest:174}所需的{item:4371}？{npc:3133}在{npc:276}旁边的房子里出售，存货有限；{area:150}的{npc:1448}也有售。\n{npc:276}的房子在镇子东端。{npc:3133}在旁边的房子里出售工程学物品。",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "沿道路从{area:1002}向南进入{zone:1431}；{area:42}位于森林东侧。",
	-- ["For {npc:302}, on the hill south-east of town"] = "交给{npc:302}，在镇子东南方的山上",
	-- ["Head back east to {area:42}."] = "向东返回{area:42}。",
	-- ["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "向北穿过艾尔文森林前往{zone:1453}；马迪亚斯·肖尔位于{object:2100}的军情七处。",
	-- ["Head south through the cemetery towards {area:94}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "穿过墓地向南前往{area:94}。骸骨魔和恐怖骸骨在墓地南半部游荡。精英{npc:522}在墓地间徘徊：离他远点。",
	-- ["Level 22 and 24 spells"] = "22级和24级法术",
	-- ["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "下一步：去{zone:1453}训练，然后从{area:17203}乘船前往{area:442}，再去{zone:1440}。",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "疯狂的恐狼在墓地和{npc:289}周围的树林中游荡，饥饿的恐狼在他东北方的山丘上。小型结网毒蜘蛛在墓地东边爬行，掉落毒液。墓地北半部的所有食尸鬼都可能掉落牙齿。",
	-- ["Ride back east along the road to the {area:245}."] = "沿道路向东骑回{area:245}。",
	-- ["Ride back east to {area:42}."] = "向东骑回{area:42}。",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "向北穿过艾尔文森林前往{zone:1453}；马迪亚斯·肖尔在{object:2100}的军情七处。",
	-- ["Ride west along the road once more."] = "再次沿道路向西骑行。",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "沿道路向西离开{area:94}进入{zone:1436}。{npc:7024}在边界内不远的山丘上监视{npc:7053}的塔楼。守卫塔楼的{npc:7051}（23级）身上有钥匙；克拉文的日记在塔顶的箱子里。",
	-- ["Ride west to the hermit once more."] = "再次向西骑行去找隐士。",
	-- ["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the {npc:14235} Blossoms."] = "恐怖骸骨在镇子东南方{area:42}和{area:121}之间的山坡上游荡；它们掉落{npc:14235}之花。",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "骷髅战士和骷髅法师在{area:42}东南方的墓地间游荡，就在山上{npc:302}的房子下方。{zone:1431}的所有骷髅都可能掉落{item:2378}。",
	-- ["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "墓地位于村子北边。恐怖骸骨和骸骨魔在墓地南半部游荡。精英{npc:522}在墓地间徘徊：离他远点。",
	-- ["The hermit's shack stands in the woods north-east of the {area:492}."] = "隐士的小屋在{area:492}东北方的树林里。",
	-- ["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "松土堆在农舍南边的老树桩旁。",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "在{zone:1453}训练，从{zone:1429}向北走。然后从{area:17203}乘船前往{area:442}。",
	-- ["Wolves, spiders and ghouls"] = "狼、蜘蛛和食尸鬼",
	-- ["{area:492}, south"] = "{area:492}，南部",
	-- ["{area:69} flight master"] = "{area:69} 飞行管理员",
	-- ["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "{item:1130}：小型结网毒蜘蛛、结网毒蜘蛛和绿色隐士蛛",
	-- ["{item:1946}: the {npc:511} in the cemetery's crypt is level 26; it waits for the {zone:1431} return"] = "{item:1946}：墓地地穴里的{npc:511}是26级；留到回到{zone:1431}时再做",
	-- ["{item:281046}, from the {object:673515}"] = "{item:281046}，来自{object:673515}",
	-- ["{item:3372}: {npc:1313}, {skill:171} Supplies"] = "{item:3372}：{npc:1313}，{skill:171}用品",
	-- ["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}，向{npc:3133}购买：存货有限。卖完了？{area:150}的{npc:1448}也有售。",
	-- ["{npc:14235} Blossoms"] = "{npc:14235}之花",
	-- ["{npc:2409}, at the north end of town"] = "{npc:2409}，在镇子北端",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}，在酒馆旁她的房子里",
	-- ["{npc:268}, in the house behind the town hall"] = "{npc:268}，在市政厅后面的房子里",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "{npc:276}的房子在镇子东端。{npc:3133}在旁边的房子里出售工程学物品。",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}：{spell:2842}，以及{item:18160}",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}，在镇子南端",
	-- ["{npc:663}, by the town hall: from level 23; the {area:10} return hunts the worgen"] = "{npc:663}，在市政厅旁：23级起；回到{area:10}时猎杀狼人",
	-- ["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}，Scarlet Raven Tavern",
	-- ["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888}站在道路南边的{area:245}。",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}：{zone:1431}怪物的稀有掉落",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453}没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，找{npc:258098}训练，然后乘地铁返回，搭乘前往{area:442}的船。",
}
