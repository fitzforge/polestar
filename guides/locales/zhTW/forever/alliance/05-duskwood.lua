-- Chinese (traditional) (zhTW): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Darkshire
	-- {area:1002} Three Corners · {area:10} Duskwood · {area:42} Darkshire
	["Follow the road south from {area:1002} into {area:10}; {area:42} lies on the east side of the forest."] = "",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}，在市政廳裡",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}，在市政廳後面的房子裡",
	-- {npc:633} Elaine Carevin
	["{npc:633}, at the south end of town; inside"] = "",

	-- Step 3: Darkshire
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too.\n{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "",
	-- {npc:2409} Felicia Maline
	["{npc:2409}, at the north end of town"] = "{npc:2409}，在城鎮北端",
	-- {npc:265} Madame Eva
	["{npc:265}, in her house by the tavern; inside"] = "",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}，向{npc:3133}購買：數量有限。賣完了？{area:150}的{npc:1448}也有賣。",

	-- Step 4: Nightbane Shadow Weaver on the way
	-- {npc:533} Nightbane Shadow Weaver
	["{npc:533} on the way"] = "",

	-- Step 5: Tranquil Gardens Cemetery: kill these as you meet them
	-- {area:121} Tranquil Gardens Cemetery
	["{area:121}: kill these as you meet them"] = "",
	-- {area:42} Darkshire · {npc:302} Blind Mary · {area:10} Duskwood · {item:2378} Skeleton Finger
	-- plural, as words: Skeletal Warriors = {npc:48} Skeletal Warrior · Skeletal Mages = {npc:203} Skeletal Mage
	["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {area:10} can drop a {item:2378}.\nCareful: Because the skeletons stand near each other, running straight in tends to pull several at once."] = "",
	-- {quest:337} An Old History Book · {area:10} Duskwood
	["{quest:337}: a rare drop from {area:10}'s mobs"] = "",

	-- Step 6: Darkshire
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}，在旅店",

	-- Step 7: Skeletal Fiend on the way
	-- {npc:531} Skeletal Fiend
	["{npc:531} on the way"] = "",

	-- Step 8: Skeletal Horror on the way
	-- {npc:202} Skeletal Horror
	["{npc:202} on the way"] = "",

	-- Step 9: Watcher Dodds
	-- {npc:888} Watcher Dodds · {area:245} Yorgen Farmstead
	["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888}站在道路南邊的{area:245}。",

	-- Step 10: Raven Hill
	-- {area:94} Raven Hill · {object:673515} Memory of Valor
	["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "繼續向西前往{area:94}。{object:673515}在道路南邊的廢墟房屋旁發光。",
	-- {item:281046} Raven Hill Tome · {object:673515} Memory of Valor
	["{item:281046}, from the {object:673515}"] = "{item:281046}，來自{object:673515}",

	-- Step 11: Sven's Camp
	-- {npc:311} Sven Yorgen · {npc:893} Lars
	["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "沿著道路向西北經過墓地，前往森林最西緣的{npc:311}營地。{npc:893}站在{npc:311}旁邊。",

	-- Step 12: The Hushed Bank: kill these as you meet them
	-- {area:1097} The Hushed Bank
	["{area:1097}: kill these as you meet them"] = "",
	-- {npc:289} Abercrombie · {area:40} Westfall
	-- plural, as words: Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider
	["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang.\nCareful: Wolves and other spider types share the area along the {area:40} border, so you can easily pull several mobs at once."] = "",

	-- Step 13: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["The hermit's shack stands in the woods north-east of the {area:492}."] = "隱士的小屋在{area:492}東北方的樹林裡。",

	-- Step 14: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "",
	-- {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Skeletal Fiends = {npc:531} Skeletal Fiend
	["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "墓地在村莊北邊。恐怖骸骨和骸骨魔在墓地南半部走動。精英{npc:522}在墓地之間遊蕩：遠離他。",

	-- Step 15: Watcher Dodds
	-- {area:245} Yorgen Farmstead
	["Head back east along the road to the {area:245}."] = "",

	-- Step 16: Yorgen Farmstead
	["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "鬆土堆在農舍南邊的老樹樁旁。",

	-- Step 18: Darkshire
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, inside"] = "",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "",

	-- Step 19: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "她的房子在{area:42}東南方的山丘上，位於{area:121}上方。",
	["Inside"] = "",

	-- Step 21: Abercrombie
	["Head west along the road once more."] = "",

	-- Step 23: Hearth to Darkshire
	-- {area:42} Darkshire
	["Hearth to {area:42}"] = "",

	-- Step 24: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "回到{area:42}",
	-- {area:42} Darkshire
	["Head back east to {area:42}."] = "",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}，在市政廳裡",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}，在旅店裡",

	-- Step 25: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "腐敗之花",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "恐怖骸骨在城鎮東南方、{area:42}與{area:121}之間的山坡上走動；牠們會掉落腐敗之花。",

	-- Step 27: Abercrombie
	["Head west to the hermit once more."] = "",

	-- Step 28: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "食屍鬼的肋骨",
	-- {area:492} Raven Hill Cemetery · {npc:948} Rotted One
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts Summon Flesh Eating Worms as it dies, which brings extra adds."] = "",

	-- Step 30: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288}躲在{area:94}西端的房子裡。",

	-- Step 31: Sven's Camp
	-- {zone:1453} Stormwind · {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1440} Ashenvale
	["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "接下來：到{zone:1453}訓練，然後從{area:17203}搭船前往{area:442}，再前往{zone:1440}。",

	-- Step 33: Agent Kearnen
	-- {area:94} Raven Hill · {area:40} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {area:40}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}，在箱子裡",

	-- Step 34: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}：毒藥，以及{item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}：{npc:7207}，在兵營地下室",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "在{npc:7207}旁邊/lay down",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}：鍊金術供應商{npc:1313}",

	-- Step 35: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "",

	-- Step 36: Gazin Tenorm
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["{npc:6173} and {npc:6171} are in the Cathedral of Light."] = "",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "",

	-- Step 38: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 39: Shaman training
	["Shaman training"] = "薩滿訓練",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {area:442} Auberdine
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453}沒有薩滿訓練師：從{object:28027}搭乘{area:2257}前往{zone:1455}，向{npc:258098}學習，然後搭地鐵回來搭前往{area:442}的船。",

	-- Step 40: Rogue training
	["Rogue training"] = "",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "",

	-- Step 42: Class trainer
	["Class trainer"] = "",
	["Level 22 and 24 spells"] = "22和24級法術",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "{area:492}北半部的每個食屍鬼都可能掉落肋骨：食腐者、噬骨者、瘟疫食屍鬼和食腦者。",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "沿著道路從{area:1002}向南進入{zone:1431}；{area:42}位於森林東側。",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "瘋狂的恐狼在墓地和{npc:289}周圍的樹林遊蕩，饑餓的恐狼在他東北方的山丘上。小型結網毒蜘蛛在墓地東邊爬行，會掉落毒液。墓地北半部的每個食屍鬼都可能掉落尖牙。",
	-- ["Ride back east along the road to the {area:245}."] = "沿著道路向東騎回{area:245}。",
	-- ["Ride back east to {area:42}."] = "向東騎回{area:42}。",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "向北騎過艾爾文森林前往{zone:1453}；馬迪亞斯·肖爾在{object:2100}的軍情七處。",
	-- ["Ride west along the road once more."] = "再次沿著道路向西騎。",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "沿著道路向西離開{area:94}進入{zone:1436}。{npc:7024}在邊界內側的山丘上監視{npc:7053}的塔。守衛塔的{npc:7051}（等級23）身上帶著塔的鑰匙；克拉文的日記在塔頂的箱子裡。",
	-- ["Ride west to the hermit once more."] = "再次向西騎去找隱士。",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "骷髏戰士和骷髏法師在{area:42}東南方的墓地間走動，就在山丘上{npc:302}房子的下方。{zone:1431}的每個骷髏都可能掉落{item:2378}。",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "在{zone:1453}訓練，向北穿過{zone:1429}前往。然後從{area:17203}搭船前往{area:442}。",
	-- ["Wolves, spiders and ghouls"] = "狼、蜘蛛和食屍鬼",
	-- ["{area:492}, south"] = "{area:492}南側",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}，在旅店旁她的房子裡",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "{npc:276}的房子在城鎮東端。{npc:3133}在旁邊的房子裡出售工程學商品。",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}：{spell:2842}，以及{item:18160}",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}，在城鎮南端",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}：{zone:1431}怪物的稀有掉落",
}
