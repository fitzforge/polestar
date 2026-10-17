-- Chinese (traditional) (zhTW): the guide forever/alliance/07-thousand-needles (forever/alliance/07-thousand-needles.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Darkshire
	-- {item:4371} Bronze Tube · {quest:174} Look to the Stars · {npc:3133} Herble Baubbletump · {npc:276} Viktori Prism'Antras · {npc:1448} Neal Allen · {area:150} Menethil Harbor
	["No {item:4371} for {quest:174}? {npc:3133} sells it in the house beside {npc:276}, in limited stock; {npc:1448} in {area:150} sells it too."] = "沒有{quest:174}要的{item:4371}？{npc:3133}在{npc:276}旁邊的房子裡限量出售；{area:150}的{npc:1448}也有賣。",
	-- {npc:352} Dungar Longdrink · {zone:1453} Stormwind
	["From {npc:352} in {zone:1453}"] = "向{zone:1453}的{npc:352}取得",
	-- {npc:6790} Innkeeper Trelayne
	["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}，在旅店",
	-- {npc:840} Watcher Backus
	["{npc:840}, at the north entrance of town"] = "{npc:840}，在城鎮北側入口",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}，在市政廳裡",
	-- {npc:663} Calor
	["{npc:663}, by the town hall"] = "{npc:663}，在市政廳旁",
	-- {item:4371} Bronze Tube · {npc:3133} Herble Baubbletump
	["{item:4371}, from {npc:3133}, if you have none"] = "如果你沒有，向{npc:3133}購買{item:4371}",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, at the east end of town"] = "{npc:276}，在城鎮東端",

	-- Step 2: Nightbane Shadow Weavers
	-- plural, as words: Nightbane Shadow Weavers = {npc:533} Nightbane Shadow Weaver
	["Nightbane Shadow Weavers"] = "夜行織影狼人",
	-- {area:42} Darkshire
	["The worgen hold the woods of Brightwood, west of {area:42} and north of the road. Pull them one at a time."] = "狼人佔據亮木樹林的樹林，在{area:42}西邊、道路北側。一次只拉一隻。",

	-- Step 4: Nightbane Dark Runners
	-- plural, as words: Nightbane Dark Runners = {npc:205} Nightbane Dark Runner
	["Nightbane Dark Runners"] = "夜行黑暗狼人",
	-- {area:42} Darkshire
	["The Dark Runners prowl the woods south of the road, west of {area:42}."] = "黑暗狼人在道路南側、{area:42}西邊的樹林中徘徊。",

	-- Step 6: Blind Mary
	-- {area:42} Darkshire
	["Her house stands on the hill south-east of {area:42}."] = "她的房子在{area:42}東南方的山丘上。",

	-- Step 7: Nightbane Vile Fangs and the Insane Ghoul
	-- {npc:511} Insane Ghoul
	-- plural, as words: Nightbane Vile Fangs = {npc:206} Nightbane Vile Fang
	["Nightbane Vile Fangs and the {npc:511}"] = "夜行邪齒狼人與{npc:511}",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery · {npc:511} Insane Ghoul
	["The strongest worgen roam the woods south of {area:42}, west and south of the {area:121}. The {npc:511} hides in the small crypt by the cemetery."] = "最強的狼人在{area:42}南邊、{area:121}西邊和南邊的樹林中遊蕩。{npc:511}躲在墓園旁的小墓穴裡。",

	-- Step 8: Darkshire
	-- {npc:661} Jonathan Carevin · {npc:633} Elaine Carevin
	["{npc:661}, by {npc:633}'s house"] = "{npc:661}，在{npc:633}的房子旁",

	-- Step 9: Abercrombie
	-- {area:492} Raven Hill Cemetery
	["Ride west along the road; the hermit's shack stands north-east of the {area:492}."] = "沿著道路向西騎；隱士的小屋在{area:492}東北方。",

	-- Step 10: Plague Spreaders
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["Plague Spreaders"] = "瘟疫食屍鬼",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["The Plague Spreaders walk the northern half of the {area:492}. {npc:522}, an elite, wanders the graves: keep away from him."] = "瘟疫食屍鬼在{area:492}北半部走動。精英{npc:522}在墓地之間遊蕩：遠離他。",

	-- Step 11: Sven Yorgen's Camp
	-- {npc:311} Sven Yorgen
	["{npc:311}'s Camp"] = "{npc:311}的營地",

	-- Step 12: Raven Hill Cemetery, west
	-- {area:492} Raven Hill Cemetery
	["{area:492}, west"] = "{area:492}西側",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders, Healers and Warders hold the west part of the cemetery, just east of {npc:311}'s camp."] = "骷髏襲擊者、骷髏醫師和骷髏看守佔據墓地西側，就在{npc:311}營地的東邊。",

	-- Step 13: Sven Yorgen's Camp
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}, in the next guide"] = "交給{zone:1453}的{npc:1212}，在下一份指南",

	-- Step 14: Defias Strongbox
	-- {zone:1431} Duskwood · {area:94} Raven Hill · {zone:1436} Westfall
	["The Defias camp lies in the south-west of {zone:1431}, south of {area:94} near the {zone:1436} border. The strongbox stands among the tents."] = "迪菲亞營地位於{zone:1431}西南部，{area:94}南邊，靠近{zone:1436}邊界。保險箱在帳篷之間。",

	-- Step 15: Vul'Gol Ogre Mound
	-- {object:119} Abercrombie's Crate
	["Ride east to the ogre mound. {object:119} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "向東騎往巨魔山。{object:119}放在入口處的營地裡；裂拳巨魔守衛著它。",
	-- {npc:272273} Lost Watcher · {quest:96138} Merrick's Bow
	["Only if a {npc:272273} dropped {quest:96138}: right-click it"] = "僅限{npc:272273}掉落了{quest:96138}時：右鍵點擊它",

	-- Step 17: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "回到{area:42}",
	-- {npc:482} Elling Trias · {zone:1453} Stormwind
	["For {npc:482} in {zone:1453}, in the next guide"] = "交給{zone:1453}的{npc:482}，在下一份指南",
	-- {npc:263} Lord Ello Ebonlocke
	["{npc:263}, in the town hall"] = "{npc:263}，在市政廳裡",
	-- {npc:268} Sirra Von'Indi
	["{npc:268}, in the house behind the town hall"] = "{npc:268}，在市政廳後面的房子裡",
	["Wait a moment, then speak with her again"] = "稍等一下，然後再和她說話",

	-- Step 18: Menethil Harbor
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}，在旅店裡",
	-- {item:2594} Flagon of Mead · {npc:1464} Innkeeper Helbrek
	["{item:2594}, from {npc:1464}"] = "{item:2594}，向{npc:1464}購買",
	-- {npc:1217} Glorin Steelbrow
	["{npc:1217}, upstairs in the inn"] = "{npc:1217}，在旅店樓上",
	-- {npc:2104} Captain Stoutfist
	["{npc:2104}, by the keep"] = "{npc:2104}，在城堡旁",

	-- Step 19: The wreck of the Third Fleet
	["The wreck of the Third Fleet"] = "第三艦隊的殘骸",
	-- {npc:1159} First Mate Snellig
	-- plural, as words: Cursed Sailors = {npc:1157} Cursed Sailor · Cursed Marines = {npc:1158} Cursed Marine · Giant Wetlands Crocolisks = {npc:2089} Giant Wetlands Crocolisk
	["Follow the coast north to the wrecked ship. Cursed Sailors walk the beach, Cursed Marines the deck; {npc:1159} stands on the beach by the bow. Giant Wetlands Crocolisks lurk on the coast just north of it."] = "沿著海岸向北前往沉船。被詛咒的水手在海灘上走動，被詛咒的水兵在甲板上；{npc:1159}站在船頭旁的海灘上。巨型濕地鱷魚潛伏在它北邊的海岸。",

	-- Step 20: Bluegill Raiders
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Bluegill Raiders"] = "藍腮襲擊者",
	-- plural, as words: Bluegill Raiders = {npc:1418} Bluegill Raider
	["Follow the coast north-east past the wreck: the Bluegill Raiders hold the marsh beyond the Giant Crocolisks."] = "沿著海岸向東北經過沉船：藍腮襲擊者佔據巨型鱷魚後方的沼澤。",

	-- Step 22: Captain Halyndor
	["The captain walks the deck of the wrecked ship; his strongbox sits in the hold."] = "船長在沉船的甲板上走動；他的保險箱在貨艙裡。",

	-- Step 23: Glorin Steelbrow
	-- {npc:1284} Archbishop Benedictus · {zone:1453} Stormwind
	["For {npc:1284} in {zone:1453}, in the next guide"] = "交給{zone:1453}的{npc:1284}，在下一份指南",

	-- Step 24: Whelgar's Excavation Site
	["Follow the road east to the excavation site."] = "沿著道路向東前往挖掘場。",

	-- Step 25: The dig and Sarltooth
	-- {npc:1353} Sarltooth
	["The dig and {npc:1353}"] = "挖掘場與{npc:1353}",
	-- {npc:1353} Sarltooth
	["The relics lie in the dig itself. {npc:1353}, a big Razormaw, prowls the raptor valley just west of it."] = "文物就在挖掘場裡。{npc:1353}是一隻大型刺喉龍，在挖掘場西邊的迅猛龍山谷徘徊。",
	-- {item:2661} Neru Fragment · {object:331} Loose Soil
	["{item:2661}: the {object:331}"] = "{item:2661}：{object:331}",

	-- Step 26: Ormer Ironbraid and Whelgar
	-- {npc:1078} Ormer Ironbraid
	["{npc:1078} and Whelgar"] = "{npc:1078}與維爾加",

	-- Step 27: Dragonmaw camp
	["Dragonmaw camp"] = "龍喉營地",
	["The Dragonmaw orcs camp east of the excavation site. Raiders and Swamprunners carry the war banners."] = "龍喉獸人在挖掘場東邊紮營。龍喉襲擊者和龍喉沼澤行者帶著戰旗。",

	-- Step 28: Captain Stoutfist
	-- {area:150} Menethil Harbor
	["Ride back west along the road to {area:150}."] = "沿著道路向西騎回{area:150}。",
	-- {quest:98221} From the Ashes · {quest:465} Nek'rosh's Gambit
	["{quest:98221}: {quest:465} comes after it on Forever"] = "{quest:98221}：在Forever上，{quest:465}排在它之後",

	-- Step 29: Angerfang Encampment
	-- {area:1036} Angerfang Encampment · {npc:2091} Chieftain Nek'rosh
	["Ride east again to the Dragonmaw camp. The four sets of Attack Plans lie in the {area:1036}; {npc:2091}, an elite, stands in the camp too."] = "再次向東騎到龍喉營地。四份攻擊計畫在{area:1036}；精英{npc:2091}也站在營地裡。",

	-- Step 30: To Theramore
	["To Theramore"] = "前往塞拉摩",
	-- {npc:2104} Captain Stoutfist · {area:2103} Menethil Keep
	["{npc:2104}, in {area:2103}"] = "{npc:2104}，在{area:2103}",
	-- {zone:1437} Wetlands
	["For the Dragonmaw catapult, on the {zone:1437} loop of the next guide"] = "龍喉投石車在下一份指南的{zone:1437}路線中完成",
	-- {area:513} Theramore Isle · {zone:1445} Dustwallow Marsh
	["Take the boat from Menethil's pier to {area:513} in {zone:1445}."] = "從米奈希爾的碼頭搭船前往{zone:1445}的{area:513}。",

	-- Step 31: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "在向南穿過{zone:1413}的道路上，{npc:6244}在道路東邊、{area:378}東北方紮營；從東邊過去，避開部落衛兵。",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}：在{zone:1440}，前往{zone:1443}的路上",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}：夢魔在魅魔旁邊；{item:190309}在{quest:1738}附近",

	-- Step 32: The Great Lift
	-- {zone:1413} Barrens · {area:378} Camp Taurajo · {area:485} The Great Lift · {zone:1441} Thousand Needles
	["From Theramore follow the road west out of Dustwallow into the {zone:1413} and south along it; give {area:378} a wide berth. {area:485} at the {zone:1413}' south end takes you down into {zone:1441}. The journal lies at the foot of the lift."] = "從塞拉摩沿著道路向西離開塵泥沼澤進入{zone:1413}，再沿路向南；遠離{area:378}。{zone:1413}南端的{area:485}帶你往下進入{zone:1441}。日記就在升降梯底下。",
	-- {npc:4048} Falfindel Waywarder · {zone:1444} Feralas
	["For {npc:4048} in {zone:1444}, much later"] = "交給{zone:1444}的{npc:4048}，很久以後",

	-- Step 33: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "沿著峽谷向東前往鹽湖。{area:2240}的哥布林和地精是中立的，兩個陣營都能接他們的任務。",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "交給荊棘谷的{quest:5762}，稍後",

	-- Step 34: The salt flats
	["The salt flats"] = "鹽湖",
	-- {object:19868} Rocket Car Rubble
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Scorpid Terrors = {npc:4139} Scorpid Terror
	["{object:19868} lies all over the flats. Scorpid Reavers, Sparkleshell Tortoises and Saltstone Basilisks roam the north half, Crystalhides, Scorpid Terrors and Snappers the middle, and the Gazers (34-35, five levels above you: one at a time) the far south. Vultures circle over all of it."] = "{object:19868}遍布整片鹽湖。恐蠍劫掠者、鹽殼龜和鹽石蜥蜴在北半部遊蕩，鹽石水晶蜥蜴、恐蠍和鹽殼鉗嘴龜在中間，鹽石凝視者（34-35級，比你高五級：一次一隻）在最南邊。鹽湖禿鷲在整片上空盤旋。",

	-- Step 35: Mirage Raceway
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, later"] = "{npc:4454}：交給{zone:1418}的馬特克，稍後",

	-- Step 36: Back to Menethil
	["Back to Menethil"] = "回到米奈希爾",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dragonmaw catapult"] = "龍喉投石車",
	-- ["Ride east again; the catapult stands at the Dragonmaw camp south of the road."] = "再次向東騎；投石車在道路南邊的龍喉營地裡。",
	-- ["Ride east to the ogre mound. {item:1349} sits in the camp at its entrance; Splinter Fist ogres guard it."] = "向東騎往巨魔山。{item:1349}放在入口處的營地裡；裂拳巨魔守衛著它。",
	-- ["The next step, Defeat Nek'rosh, pits you against an elite chieftain: skip it."] = "下一步「擊敗納克羅西」要你對付一個精英酋長：跳過。",
}
