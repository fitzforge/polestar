-- Chinese (simplified) (zhCN): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	["Fly to Darkshire"] = "",
	-- {zone:1431} Duskwood
	["Back to the Lakeshire gryphon master: fly to Darkshire for {zone:1431}'s second loop."] = "",
	["Lakeshire flight master"] = "",

	-- Step 2: Blind Mary
	["Her house stands on the hill south-east of Darkshire, above the Tranquil Gardens Cemetery."] = "",
	["Inside"] = "在里面",
	-- {item:1946} Mary's Looking Glass · {npc:511} Insane Ghoul · {zone:1431} Duskwood
	["{item:1946}: the {npc:511} in the cemetery's crypt is level 26; it waits for the {zone:1431} return"] = "",

	-- Step 3: Tranquil Gardens Cemetery
	["Tranquil Gardens Cemetery"] = "",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}：{zone:1431}怪物的稀有掉落",

	-- Step 5: Abercrombie
	["Head west along the road once more."] = "",

	-- Step 7: Back to Darkshire
	["Back to Darkshire"] = "",
	["Head back east to Darkshire."] = "",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}，在市政厅",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}，在酒馆里",

	-- Step 8: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "{item:1598}",
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between Darkshire and the Tranquil Gardens Cemetery, south-east of town; they drop the Rot Blossoms."] = "",

	-- Step 10: Abercrombie
	["Head west to the hermit once more."] = "",

	-- Step 11: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "食尸鬼的肋骨",
	-- {npc:948} Rotted One
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the Raven Hill Cemetery's northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts Summon Flesh Eating Worms as it dies, which brings extra adds."] = "",

	-- Step 13: Raven Hill Cemetery: kill these as you meet them
	["Raven Hill Cemetery: kill these as you meet them"] = "",
	-- {object:102} Raven Hill (no name in this language: may be words) · {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Fiends = {npc:531} Skeletal Fiend · Skeletal Horrors = {npc:202} Skeletal Horror
	["Head south through the cemetery towards {object:102}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "",

	-- Step 14: Jitters
	-- {npc:288} Jitters · {object:102} Raven Hill (no name in this language: may be words)
	["{npc:288} hides in the house at the west end of {object:102}."] = "",

	-- Step 15: Sven's Camp
	-- {zone:1453} Stormwind · {object:1162} Menethil Harbor (no name in this language: may be words) · {zone:1437} Wetlands
	["Next: training, then the flight from {zone:1453} to {object:1162} for the {zone:1437}."] = "",

	-- Step 17: Agent Kearnen
	-- {object:102} Raven Hill (no name in this language: may be words) · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {object:102} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}，在箱子里",

	-- Step 18: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}：毒药，以及{item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}：{npc:7207}，在兵营地下室",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "在{npc:7207}旁边 /lay down",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}：{npc:1313}，炼金用品",

	-- Step 19: Elwynn Forest
	-- {object:102} Raven Hill (no name in this language: may be words) · {zone:1453} Stormwind
	["North from {object:102} through Elwynn: Goldshire is on the road to {zone:1453}."] = "",

	-- Step 20: Class trainer
	["Class trainer"] = "职业训练师",
	["Level 22 and 24 spells"] = "22级和24级法术",

	-- Step 21: Gazin Tenorm
	-- {zone:1453} Stormwind · {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["On into {zone:1453}: {npc:6173} and {npc:6171} are in the Cathedral of Light, on the way to the gryphon master."] = "",
	["Cathedral of Light"] = "光明大教堂",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}：救赎",

	-- Step 23: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地铁前往{zone:1455}",

	-- Step 24: Shaman training
	["Shaman training"] = "萨满祭司训练",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the Deeprun Tram from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "",

	-- Step 25: Rogue training
	["Rogue training"] = "",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:42}"] = "回到{area:42}",
	-- ["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "继续向西到{area:94}。{object:673515}在道路南边的废弃房屋旁发光。",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "{area:492}北半部的所有食尸鬼都可能掉落肋骨：食腐者、噬骨者、瘟疫食尸鬼和食脑者。",
	-- ["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "沿道路向西北经过墓地，前往森林最西缘的{npc:311}营地。{npc:893}站在{npc:311}旁边。",
	-- ["Follow the road south from {area:1002} into {area:10}; {area:42} lies on the east side of the forest.\nNo {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "沿道路从{area:1002}向南进入{area:10}；{area:42}位于森林东侧。\n没有{quest:174}所需的{item:4371}？{npc:3133}在{npc:276}旁边的房子里出售，存货有限；{area:150}的{npc:1448}也有售。\n{npc:276}的房子在镇子东端。{npc:3133}在旁边的房子里出售工程学物品。",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "沿道路从{area:1002}向南进入{zone:1431}；{area:42}位于森林东侧。",
	-- ["For {npc:302}, on the hill south-east of town"] = "交给{npc:302}，在镇子东南方的山上",
	-- ["Head south through the cemetery towards {area:94}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "穿过墓地向南前往{area:94}。骸骨魔和恐怖骸骨在墓地南半部游荡。精英{npc:522}在墓地间徘徊：离他远点。",
	-- ["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "她的房子在{area:42}东南方的山上，{area:121}上方。",
	-- ["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "下一步：去{zone:1453}训练，然后从{area:17203}乘船前往{area:442}，再去{zone:1440}。",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "疯狂的恐狼在墓地和{npc:289}周围的树林中游荡，饥饿的恐狼在他东北方的山丘上。小型结网毒蜘蛛在墓地东边爬行，掉落毒液。墓地北半部的所有食尸鬼都可能掉落牙齿。",
	-- ["Ride back east along the road to the {area:245}."] = "沿道路向东骑回{area:245}。",
	-- ["Ride back east to {area:42}."] = "向东骑回{area:42}。",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "向北穿过艾尔文森林前往{zone:1453}；马迪亚斯·肖尔在{object:2100}的军情七处。",
	-- ["Ride west along the road once more."] = "再次沿道路向西骑行。",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "沿道路向西离开{area:94}进入{zone:1436}。{npc:7024}在边界内不远的山丘上监视{npc:7053}的塔楼。守卫塔楼的{npc:7051}（23级）身上有钥匙；克拉文的日记在塔顶的箱子里。",
	-- ["Ride west to the hermit once more."] = "再次向西骑行去找隐士。",
	-- ["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "{npc:202}在{area:42}与{area:121}之间、镇子东南方的山坡上游荡；它们掉落{item:1598}。",
	-- ["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the {npc:14235} Blossoms."] = "恐怖骸骨在镇子东南方{area:42}和{area:121}之间的山坡上游荡；它们掉落{npc:14235}之花。",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "骷髅战士和骷髅法师在{area:42}东南方的墓地间游荡，就在山上{npc:302}的房子下方。{zone:1431}的所有骷髅都可能掉落{item:2378}。",
	-- ["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "墓地位于村子北边。恐怖骸骨和骸骨魔在墓地南半部游荡。精英{npc:522}在墓地间徘徊：离他远点。",
	-- ["The hermit's shack stands in the woods north-east of the {area:492}."] = "隐士的小屋在{area:492}东北方的树林里。",
	-- ["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "松土堆在农舍南边的老树桩旁。",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "在{zone:1453}训练，从{zone:1429}向北走。然后从{area:17203}乘船前往{area:442}。",
	-- ["Wolves, spiders and ghouls"] = "狼、蜘蛛和食尸鬼",
	-- ["{area:492}, south"] = "{area:492}，南部",
	-- ["{item:1130}: Pygmy Venom Web Spiders, Venom Web Spiders and Green Recluses"] = "{item:1130}：小型结网毒蜘蛛、结网毒蜘蛛和绿色隐士蛛",
	-- ["{item:1946}: the {npc:511} in the cemetery's crypt is level 26; it waits for the {area:10} return"] = "{item:1946}：墓地地穴里的{npc:511}是26级；留到回到{area:10}时再做",
	-- ["{item:281046}, from the {object:673515}"] = "{item:281046}，来自{object:673515}",
	-- ["{item:3372}: {npc:1313}, {skill:171} Supplies"] = "{item:3372}：{npc:1313}，{skill:171}用品",
	-- ["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}，向{npc:3133}购买：存货有限。卖完了？{area:150}的{npc:1448}也有售。",
	-- ["{npc:14235} Blossoms"] = "{npc:14235}之花",
	-- ["{npc:2409}, at the north end of town"] = "{npc:2409}，在镇子北端",
	-- ["{npc:264}, in the town hall"] = "{npc:264}，在市政厅",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}，在酒馆旁她的房子里",
	-- ["{npc:268}, in the house behind the town hall"] = "{npc:268}，在市政厅后面的房子里",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "{npc:276}的房子在镇子东端。{npc:3133}在旁边的房子里出售工程学物品。",
	-- ["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288}躲在{area:94}西端的房子里。",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}：{spell:2842}，以及{item:18160}",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}，在镇子南端",
	-- ["{npc:663}, by the town hall: from level 23; the {area:10} return hunts the worgen"] = "{npc:663}，在市政厅旁：23级起；回到{area:10}时猎杀狼人",
	-- ["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}，Scarlet Raven Tavern",
	-- ["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888}站在道路南边的{area:245}。",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}：{zone:1431}怪物的稀有掉落",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453}没有萨满祭司训练师：从{object:28027}乘{area:2257}前往{zone:1455}，找{npc:258098}训练，然后乘地铁返回，搭乘前往{area:442}的船。",
}
