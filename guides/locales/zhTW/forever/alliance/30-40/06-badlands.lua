-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "",

	-- Step 4: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "暗爐矮人在挖掘場北邊紮營；揉皺的地圖在他們的帳篷之間。暗爐隧道工和暗爐巫師身上帶著雷杜爾的鋤頭。峭壁山狗在周圍的山坡上遊蕩。",

	-- Step 5: The excavation crate
	["The excavation crate"] = "挖掘箱",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "",

	-- Step 6: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "雷杜爾的下一個任務要進入{area:1517}：跳過。",

	-- Step 7: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618}和{npc:2817}一起在{zone:1418}中部的{area:1877}紮營。",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "蚌殼在荊棘谷的西北海岸，在下一份指南中：保留此任務",

	-- Step 8: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "破損的骷髏就在巨魔東邊、石窟穴居人營地的邊緣；周圍的石窟斷骨者和石窟薩滿會掉落碎片。塞爾杜林坐在更南邊的廢棄營地旁。",

	-- Step 9: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "",
	-- {quest:739} Murdaloc · {spell:5242} Battle Shout · {spell:1160} Demoralizing Shout · {area:340} Kargath
	-- plural, as words: Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "",
	-- {quest:739} Murdaloc · {zone:1418} Badlands
	["{quest:739} himself (42) walks among the Bonesnappers: leave him for the later {zone:1418} guide at 43, and kill the Bonesnappers for this quest now."] = "",

	-- Step 10: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "",

	-- Step 11: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "次級石元素",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus · {npc:1470} Ghak Healtouch
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards."] = "",

	-- Step 13: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Head north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "",

	-- Step 14: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:345} Agmond's End
	["Head south down the road: {npc:4618} and {npc:2817} camp in the {area:1877}, on the way to {area:345}."] = "",
	-- {npc:4454} Fizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["For {npc:4454} at the {area:2240}: the {zone:1446} guide passes him at 45, keep it"] = "",

	-- Step 15: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "給{zone:1455}的{npc:2786}：保留此任務",

	-- Step 16: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "石元素",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "石元素在{npc:2921}東南方遊蕩；巨型禿鷲和老峭壁山狗則在牠們西邊的平原上。",

	-- Step 17: Lotwil Veriatus
	-- {npc:2921} Lotwil Veriatus · {item:4628} Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s last test is optional: five {item:4628}, which only the Greater Rock Elementals (42-44) in the south-western gulches drop, about one kill in five, well above your level. Take it only if you can handle them one at a time; otherwise hand in the slabs and move on."] = "",

	-- Step 18: Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["South-west into the gulches: only the Greater Rock Elementals there drop the bracers."] = "",

	-- Step 20: Lucien Tosselwrench
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus · {item:2868} Patterned Bronze Bracers
	["{npc:2920}, beside {npc:2921}, trades for {item:2868}, a blacksmith's craft: this step shows only when you carry a pair."] = "",
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}，在{npc:2921}旁邊",

	-- Step 21: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "",

	-- Step 22: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "",

	-- Step 23: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "",

	-- Step 25: Theramore flight master
	["Theramore flight master"] = "",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "",

	-- Step 26: Nijel's Point
	-- {npc:5638} Kreldig Ungor
	["{npc:5638}: the wreck is on the north-west coast, at the end of the loop"] = "",

	-- Step 27: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "沿著道路向南前往{area:2407}。",

	-- Step 28: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019}站在{area:2407}西南方的{area:596}邊緣；{object:176751}散落在骸骨之間。墓地裡有{npc:217590}在爬行：用昆蟲學入門工具包抓一隻，然後勾選完成。",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}：抓一隻，用於任務「My Little Friends」",

	-- Step 29: Maraudine centaurs
	["Maraudine centaurs"] = "瑪洛迪半人馬",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "瑪洛迪半人馬佔據墓地西邊的{area:607}；每一種都會掉落圖騰。",

	-- Step 30: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "護送{npc:12277}回到墓地附近",

	-- Step 31: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "",

	-- Step 32: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "亡靈劫掠者在瑪格拉姆村南邊、瑪諾洛克集會所東邊的白骨原野上遊蕩；在最東南方使用{item:15848}引來瑪格拉姆鬼魂。",

	-- Step 35: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "沿著道路向西穿過{zone:1443}北部，前往{area:2405}的廢墟。{npc:11863}的塔就在那裡的山丘上，在前往船骸的路上。",

	-- Step 36: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "失事船隻的箱子就在{npc:11863}的塔西邊不遠的岸上。",

	-- Step 37: Claim Rackmore's Treasure!
	["Underwater"] = "",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "沿著道路向北前往{area:608}。",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "給{zone:1455}的{npc:5637}：保留此任務",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "給{area:271}的{npc:3980}：保留此任務",

	-- Step 39: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "",
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}是一名半人馬首領，在{npc:11863}的塔北邊的西北海岸紮營。",

	-- Step 44: Fly to Theramore
	["Fly to Theramore"] = "飛往塞拉摩",
	["The next guide starts in Theramore."] = "下一份指南從塞拉摩開始。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "沿著道路向西穿過{zone:1443}北部，前往{area:2405}的廢墟；失事船隻的箱子就在廢墟西邊的岸上。",
	-- ["Greater Rock Elementals"] = "巨型石元素",
	-- ["Lesser Rock Elementals"] = "次級石元素",
	-- ["Ogres and buzzards"] = "巨魔與禿鷲",
	-- ["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "向西騎回道路，沿路向南離開{zone:1432}，穿過山口進入{zone:1418}。{npc:2910}和{npc:2860}在挖掘場並肩紮營。",
	-- ["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "向東北騎往廢棄的挖掘場；補給箱就在那裡的火煙巨魔之間。",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "向東北騎往{zone:1418}北部的矮人遺跡；箱子在暗爐矮人之間。附近的{npc:2745}是精英：離他遠一點。",
	-- ["Ride south to {area:345}."] = "向南騎往{area:345}。",
	-- ["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "向西騎進{area:1878}；{npc:2921}在中央的機器旁工作。",
	-- ["Shadowforge camp"] = "暗爐營地",
	-- ["Take the boat to Theramore from the far pier."] = "在最遠的碼頭搭船前往塞拉摩。",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "火煙巨魔就在山谷南邊紮營；他們每一個都會掉落廢料。禿鷲在東邊的平原上空盤旋。",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "巨型石元素（42級）在{area:342}下方的西南角落走動；一次拉一隻。{area:342}的火煙獵龍者和火煙虐待者也會掉落廢料。",
	-- ["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "次級石元素在{npc:2921}西邊的{area:1878}遊蕩。",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "破損的骷髏就在巨魔東邊、石窟穴居人營地的邊緣；周圍的石窟斷骨者和石窟薩滿會掉落碎片。塞爾杜林坐在更南邊的廢棄營地旁。",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "惡魔聚集在{zone:1443}南部的{area:602}：魔犬（噬法魔犬、法師獵手和靈能獵犬）、地獄魔女和地獄修女，以及坑洞周圍的末日看守隊長。",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "飛行管理員站在{area:514}的大門旁；{npc:5083}和{npc:4964}在要塞裡面。",
	-- ["The next guide starts in Theramore."] = "下一份指南從塞拉摩開始。",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "骷髏的下一個任務「莫達洛克」要等到43級的{zone:1418}指南再做。",
	-- ["Theramore"] = "塞拉摩",
	-- ["for the Dustwallow loop in the next guide"] = "用於下一份指南的塵泥沼澤環線",
	-- ["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "給{area:439}的{npc:4454}：{zone:1446}指南會在45級時經過那裡，保留此任務",
	-- ["only if you carry {item:2868} (a blacksmith's craft)"] = "只有在你帶著{item:2868}（鐵匠製作）時",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "{npc:11626}的商隊停在{area:606}東邊的路上。接下任務，跟著科多獸走過{area:602}，擊殺撲向牠們的惡魔；之後到{area:596}東邊的營地與{npc:11596}交談。",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "{npc:11863}的塔位於船骸東邊的山丘上。",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277}被關在墓地西邊的半人馬營地。救出她，並在離開途中保護她存活；她會在墓地旁停下。",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}，在旅店裡",
	-- ["{npc:2921}'s next test needs crafted gear: skip it."] = "{npc:2921}的下一個測試需要製作的裝備：跳過。",
	-- ["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {area:3}."] = "{npc:4618}和{npc:2817}一起在{area:3}中部的{area:1877}紮營。",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "{npc:5638}的下一個任務{item:6245}是遠處海岸的掉落物：跳過。",
}
