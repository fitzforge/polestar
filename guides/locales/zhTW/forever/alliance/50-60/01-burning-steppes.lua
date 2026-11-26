-- Chinese (traditional) (zhTW): the guide forever/alliance/50-60/01-burning-steppes (forever/alliance/50-60/01-burning-steppes.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3197} Chillwind Camp · {zone:1428} Burning Steppes · {zone:1419} Blasted Lands · {zone:1447} Azshara
	["{area:3197} first, then the {zone:1428} and the {zone:1419}, then {zone:1447}."] = "先去{area:3197}，再去{zone:1428}和{zone:1419}，然後是{zone:1447}。",

	-- Step 1: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "前往{zone:1455}",
	-- {zone:1455} Ironforge · {zone:1425} Hinterlands
	-- was: ["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "你的爐石設定在{zone:1455}（{zone:1425}指南會綁定在那裡）：用爐石回到旅店。"
	["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn from Un'Goro."] = "",
	-- {zone:1455} Ironforge
	["{zone:1455} inn"] = "{zone:1455}旅店",

	-- Step 2: Mystic Ward
	-- {npc:11406} High Priest Rohan · {npc:8405} Ogtinc · {zone:1447} Azshara
	["{npc:11406}: for {npc:8405} in {zone:1447}, at the end of this guide: keep it"] = "",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, at the end of this guide: keep it"] = "",

	-- Step 4: Courier Hammerfall
	-- {npc:10877} Courier Hammerfall
	["{npc:10877} rides around the city's ring on his ram: catch him as he passes."] = "",
	-- {npc:10838} Commander Ashlam Valorfist · {area:3197} Chillwind Camp
	["For {npc:10838} at {area:3197}, the next stop"] = "",

	-- Step 5: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "阿克瑟努斯站在{object:171709}的國王麥格尼身旁。",

	-- Step 6: Royal Historian Archesonus
	-- {quest:3701} The Smoldering Ruins of Thaurissan · {npc:8978} Thauris Balgarr · {zone:1428} Burning Steppes
	-- plural, as words: War Reavers = {npc:7039} War Reaver
	["{quest:3701} is a group quest at this level: its relics stand among War Reavers and Firewalkers of 53-55, with {npc:8978} (57) close by, two to five over you, and the route has no later {zone:1428} visit. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "在這個等級{quest:3701}是小隊任務：聖物位於53-55級的戰爭搶奪者和馭火者之間，附近還有{npc:8978}（57級），比你高二到五級，而且路線之後不會再來{zone:1428}。建議組隊，找人一起完成。如果你是單獨一人就跳過。",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "聖物在{zone:1428}：保留此任務",

	-- Step 7: Fly to Aerie Peak
	-- {area:348} Aerie Peak
	["Fly to {area:348}"] = "飛往{area:348}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飛行管理員",

	-- Step 8: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飛往{area:271}",

	-- Step 10: The Super Snapper FX
	-- {item:9328} Super Snapper FX · {zone:1425} Hinterlands · {area:307} Overlook Cliffs
	["Gammerita need not die: target her and use the {item:9328}. She is a level 48 elite, so keep your distance.\nGammerita walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "",
	-- {item:9328} Super Snapper FX
	["the {item:9328} on Gammerita: no kill"] = "",

	-- Step 11: Fly to Southshore
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "{area:348}飛行管理員",

	-- Step 12: Orphan Matron Aria
	-- {area:271} Southshore · {area:279} Dalaran · {npc:34365} Orphan Matron Aria · {npc:266524} Lieutenant Connar · {area:1438} Nethergarde Keep
	["Ride north from {area:271} into Alterac and west to the walls of {area:279}: {npc:34365} stands outside them. Her quest goes to {npc:266524} in {area:1438}, where this guide flies later."] = "從{area:271}向北騎進奧特蘭克，再往西到{area:279}的城牆：{npc:34365}站在城牆外。她的任務要交給{area:1438}的{npc:266524}，本指南之後會飛到那裡。",

	-- Step 13: Western Plaguelands
	-- {area:271} Southshore · {area:3197} Chillwind Camp
	["Ride north from {area:271} up the road through Alterac to {area:3197}."] = "從{area:271}沿路向北騎行，穿過奧特蘭克前往{area:3197}。",

	-- Step 14: Chillwind Camp
	-- {npc:10838} Commander Ashlam Valorfist
	["{npc:10838} stands in the middle of the camp."] = "{npc:10838}站在營地中央。",

	-- Step 15: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}：遇到就殺",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	-- was: ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "骷髏撕掠者和流涎食屍鬼在營地北面的田野遊蕩；這裡的天災怪都會掉落天災石。\n注意：這些亡靈從很遠就能發現你，拉怪時附近的亡靈會加入戰鬥。\n注意：{npc:10411}（3個重生點，15分鐘重新出現）脫離戰鬥後會隱形，戰鬥一開始就會呼叫石翼石像鬼。"
	["Skeletal Flayers and Slavering Ghouls (50) roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "",

	-- Step 16: Chillwind Camp
	["Ride back south to the camp."] = "向南騎回營地。",
	-- {area:199} Felstone Field · {zone:1422} Western Plaguelands
	["keep it: the {area:199} cauldron waits for the {zone:1422} guide"] = "",

	-- Step 17: Fly to Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["Fly to {area:2418}"] = "飛往{area:2418}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "{area:3197}飛行管理員",

	-- Step 18: Fly to Lakeshire
	-- {area:69} Lakeshire
	["Fly to {area:69}"] = "飛往{area:69}",

	-- Step 19: Morgan's Vigil flight master
	-- {area:2418} Morgan's Vigil
	["{area:2418} flight master"] = "{area:2418}飛行管理員",
	-- {area:69} Lakeshire · {zone:1428} Burning Steppes · {area:2418} Morgan's Vigil
	["Ride east out of {area:69} and up the pass into the {zone:1428}: {area:2418} stands at the top."] = "向東騎出{area:69}，沿山口上行進入{zone:1428}：{area:2418}就在頂端。",

	-- Step 20: Morgan's Vigil
	-- {area:2418} Morgan's Vigil
	["{area:2418} sits in the south-east of the Steppes, at the top of the pass up from Redridge."] = "{area:2418}位於燃燒平原東南部，在從赤脊山上來那條山道的頂端。",

	-- Step 21: Dreadmaul Rock
	-- {area:249} Dreadmaul Rock · {npc:9602} Hahk'Zor · {npc:9604} Gorgon'och
	-- plural, as words: Firegut Ogres = {npc:7033} Firegut Ogre · Escaped Core Hounds = {npc:227746} Escaped Core Hound
	["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: the Firegut Ogres are 50 and the Ogre Mages 51, but the Brutes on the rock's east side are 52: take the ogres on the near side first and pull the Brutes one at a time.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull.\nCareful: the Firegut chiefs {npc:9602} and {npc:9604} (54) stand on the rock's east side among the Brutes: leave them be."] = "",
	-- {npc:7034} Firegut Ogre Mage
	["{npc:7034}, below ground"] = "{npc:7034}，地下",

	-- Step 22: Morgan's Vigil
	-- {npc:9177} Oralius · {npc:9176} Gor'tesh · {area:254} Blackrock Mountain
	-- plural, as words: Blackrock Medallions = {item:11467} Blackrock Medallion
	["{npc:9177}' next tasks ({npc:9176}, and fifty Blackrock Medallions) send you among the Blackrock orcs of 55-58 at the foot of {area:254}: skip them."] = "{npc:9177}的後續任務（{npc:9176}，以及五十個黑石獎章）會讓你深入{area:254}山腳下55-58級的黑石獸人之間：跳過它們。",

	-- Step 23: Flame Crest
	-- {area:251} Flame Crest
	["Follow the road west, then climb north to the goblin camp on {area:251}."] = "沿著道路向西走，然後向北爬上{area:251}的哥布林營地。",

	-- Step 24: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}：遇到就殺",
	-- {item:12284} Draco-Incarcinatrix 900 · {npc:7047} Black Broodling · {area:251} Flame Crest · {npc:8981} Malfunctioning Reaver · {npc:7040} Black Dragonspawn
	-- was: ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "在{area:251}東邊山坡上的{npc:7047}快死時對它使用{item:12284}，然後拾取它留下的精華。\n小心：一隻{npc:8981}（56級，稀有）在小龍附近的山坡上走動，周圍的{npc:7040}和龍人都是精英：對邊緣的小龍使用採集器，每次拉怪前先看看四周。"
	["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, Volchan (60, a rare fire elemental) roams the hills east of {area:251}, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "",

	-- Step 25: Ruins of Thaurissan
	-- {area:250} Ruins of Thaurissan · {area:251} Flame Crest · {npc:8978} Thauris Balgarr · {object:147516} Dark Iron
	-- plural, as words: War Reavers = {npc:7039} War Reaver · Thaurissan Firewalkers = {npc:7037} Thaurissan Firewalker
	["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered. Take the ones on the ruins' southern edge, nearest {area:251}.\nCareful: the ruins' War Reavers and Thaurissan Firewalkers are 53-55, and {npc:8978} (57) holds the {object:147516} camp south-west of {area:251}: take the relics at the edge of the ruins, pull one at a time, and keep away from the camp."] = "聖物是散落在{area:251}周圍{area:250}中的雕刻石塊：點擊它們直到取回資訊。拿遺跡南緣、最靠近{area:251}的那些。\n小心：遺跡的戰爭搶奪者和索瑞森馭火者是53-55級，{npc:8978}（57級）佔據{area:251}西南方的{object:147516}營地：在遺跡邊緣拿聖物，一次拉一隻，並遠離營地。",

	-- Step 26: Flame Crest
	-- {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Ends with {quest:4808} in {area:2255}, {zone:1452}: keep it"] = "在{zone:1452}的{area:2255}交給{quest:4808}：保留此任務",

	-- Step 27: Cyrus Therepentous
	-- {item:10569} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight.\nCareful: Volchan (60, a rare fire elemental) roams the hills around {npc:9459}'s cave: if he is about, wait for him to pass."] = "",
	["Below ground"] = "地下",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}，從寶藏中取得",

	-- Step 29: A Taste of Flame
	-- {npc:9461} Frenzied Black Drake
	-- was: ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "這些是精英怪：建議組隊，找人一起做。{npc:9461}是54級精英：大多數職業在56級可以單挑，但你可能需要幫助。如果你獨自一人就跳過：路線會讓你把經驗刷回來。"
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone."] = "",

	-- Step 31: Morgan's Vigil
	["Ride back east along the road to the Vigil."] = "沿著道路向東騎回摩根的崗哨。",

	-- Step 32: Fly to Nethergarde Keep
	-- {area:1438} Nethergarde Keep
	["Fly to {area:1438}"] = "飛往{area:1438}",

	-- Step 33: Ambassador Ardalan
	-- {area:1438} Nethergarde Keep
	["Ardalan is inside {area:1438}."] = "阿達藍在{area:1438}裡面。",
	-- {npc:266524} Lieutenant Connar · {npc:266508} Sergeant Danneth · {area:1440} Serpent's Coil
	["{npc:266524}: {npc:266508} is in the {area:1440} caverns, on this loop"] = "",
	-- {quest:2990} Thadius Grimshade
	["{quest:2990}, at the top of the keep"] = "{quest:2990}，在要塞頂端",
	-- {npc:8022} Thadius Grimshade · {item:9471} Nekrum's Medallion · {area:978} Zul'Farrak
	["{npc:8022}' next task, {item:9471}, is a {area:978} quest: skip it."] = "{npc:8022}的下一個任務{item:9471}是{area:978}的任務：跳過它。",
	-- {npc:3546} Bernie Heisten · {quest:87295} Deflective Surface
	["{npc:3546}: {quest:87295}, the scales come from the basilisks ahead"] = "{npc:3546}：{quest:87295}，鱗片來自前方的蜥蜴",

	-- Step 34: Swamp of Sorrows
	-- {zone:1419} Blasted Lands · {zone:1435} Swamp of Sorrows · {npc:10996} Fallen Hero · {area:75} Stonard
	["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east."] = "向北騎出{zone:1419}進入{zone:1435}：{npc:10996}站在從{zone:1419}過來的道路旁。遠離東北方的部落城鎮{area:75}。",

	-- Step 35: Fallen Hero of the Horde
	["Listen to his tale, then ride back south to Kum'isha."] = "聽完他的故事，然後向南騎回庫米莎那裡。",

	-- Step 36: Back to the Blasted Lands
	-- {zone:1419} Blasted Lands
	["Back to the {zone:1419}"] = "回到{zone:1419}",

	-- Step 37: Blasted Lands: kill these as you meet them
	-- {zone:1419} Blasted Lands
	["{zone:1419}: kill these as you meet them"] = "{zone:1419}：沿途擊殺以下目標",
	-- {zone:1419} Blasted Lands · {npc:5982} Black Slayer · {npc:221740} Calefactus the Unleashed · {npc:247015} Vek'zol · {npc:8301} Clack the Reaver · {npc:8298} Akubar the Seer · {area:1440} Serpent's Coil · {item:8244} Flawless Draenethyst Sphere
	-- plural, as words: Starving Snickerfangs = {npc:5984} Starving Snickerfang · Scorpok Stingers = {npc:5988} Scorpok Stinger · Ashmane Boars = {npc:5992} Ashmane Boar · Redstone Basilisks = {npc:5990} Redstone Basilisk · Snickerfang Matriarchs = {npc:272386} Snickerfang Matriarch
	["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else.\nCareful: {npc:8301} (53, a rare scorpid) walks the north around 47,36, {npc:8298} (54, rare) the middle around 45,48, and Snickerfang Matriarchs (60) roam the ground east of here, between Kum'isha's hill and the {area:1440} (about 54-62, 31-47): give them room.\nAny mob here may drop a {item:8244}: keep it for Kum'isha."] = "",
	-- {item:8244} Flawless Draenethyst Sphere
	["{item:8244}, a rare drop"] = "",

	-- Step 39: Kum'isha the Collector
	-- {area:2517} Rise of the Defiler · {zone:1419} Blasted Lands · {npc:7664} Razelikh the Defiler · {spell:2691} Mana Burn · {spell:8255} Strong Cleave · {object:141891} Razelikh's Tear · {spell:10854} Flames of Chaos · {npc:247015} Vek'zol
	-- plural, as words: Imperfect Draenethyst Fragments = {item:10593} Imperfect Draenethyst Fragment
	["Kum'isha waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have. Come at her hill straight from the keep, along the road, and leave by the same way.\nCareful: Felcular, {npc:7664} and Ilifar are all level 60 elites. Razelikh casts {spell:2691}, {spell:8255} and Decimate, and as its health drops it adds {object:141891}, {spell:10854} and then Enrage at 15%.\nCareful: {npc:247015}, a level 55 elite, stands by Kum'isha's hill (about 50,35) and to the west (about 39,32), and the Dreadmaul and Shadowsworn camps around it are 53-55: take the fragments from the mobs on the way from the keep, not beside him."] = "收藏家庫米沙在{area:2517}等你，就是要塞西南方的山丘。路上的{zone:1419}怪物會掉落不完美的德萊尼水晶碎片；把你有的都交給她。從要塞沿著道路直接前往她的山丘，再從原路離開。\n小心：菲庫拉、{npc:7664}和伊利法都是60級精英。拉瑟萊克會施放{spell:2691}、{spell:8255}和殘殺，血量下降時還會加上{object:141891}、{spell:10854}，並在15%時狂怒。\n小心：55級精英{npc:247015}站在庫米沙的山丘旁（約50,35）和西邊（約39,32），周圍的恐槌和暗誓營地是53-55級：在從要塞過來的路上向怪物收集碎片，不要在他旁邊打。",
	-- {npc:7363} Kum'isha the Collector
	["{npc:7363} walks around here: look inside the circle on the map"] = "{npc:7363}在這附近走動：看地圖上的圓圈內",

	-- Step 40: Kum'isha the Collector
	-- {zone:1419} Blasted Lands · {item:8244} Flawless Draenethyst Sphere
	["A {zone:1419} mob dropped a {item:8244}: Kum'isha pays for it too."] = "",

	-- Step 41: Sergeant Danneth
	-- {area:1440} Serpent's Coil · {area:1438} Nethergarde Keep · {npc:7728} Kirith the Damned · {npc:7666} Archmage Allistarj
	-- plural, as words: Snickerfang Matriarchs = {npc:272386} Snickerfang Matriarch · Shadowsworn Cultists = {npc:6004} Shadowsworn Cultist
	["Ride east from Kum'isha's hill to the mouth of the {area:1440} caverns, due south of {area:1438}: Danneth hides just inside.\nCareful: Snickerfang Matriarchs (60) roam the ground between Kum'isha's hill and the caverns: watch for them on the ride and go round them, there and back.\nCareful: Shadowsworn Cultists, Thugs and Adepts (51-52) guard the caves, and the deeper chambers hold {npc:7728} (55, elite) and {npc:7666} (58, elite): stay near the mouth, pull one at a time, and lead Danneth straight out.\nWalk him out of the caves and north to {area:1438}: Connar takes him there."] = "",

	-- Step 42: Nethergarde Keep
	-- {area:1438} Nethergarde Keep · {npc:3546} Bernie Heisten
	["Back north into {area:1438}: Connar, then Danneth again once he is home. {npc:3546} takes his scales here too."] = "",
	-- {npc:34365} Orphan Matron Aria · {zone:1423} Eastern Plaguelands · {area:3197} Chillwind Camp
	["For {npc:34365} in Alterac, on the Western & {zone:1423} guide's ride to {area:3197}: keep it"] = "",

	-- Step 43: The bloodmages
	["The bloodmages"] = "血法師",
	-- {zone:1419} Blasted Lands
	["Ride west out of the keep to the bloodmages' camp beside the road into the {zone:1419}."] = "",
	["The bloodmages' second tier pays for the same parts with a buff item and no experience: skip it."] = "血法師的第二階段用增益物品換取同樣的材料，不給經驗值：跳過它。",

	-- Step 44: To Ironforge
	-- {zone:1455} Ironforge
	["Hearth back to {zone:1455}'s inn."] = "用爐石回到{zone:1455}的旅店。",

	-- Step 45: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "飛往{area:144}",

	-- Step 48: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "飛往{area:1537}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144}飛行管理員",

	-- Step 50: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}: the relics you read in the Steppes are his."] = "阿克瑟努斯站在{object:171709}的國王麥格尼身旁：你在燃燒平原閱讀的聖物就是他要的。",

	-- Step 51: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飛往{area:150}",

	-- Step 53: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "飛往{area:415}",
	-- {area:442} Auberdine · {area:415} Astranaar · {zone:1448} Felwood · {zone:1457} Darnassus
	["The boat lands in {area:442}: fly straight on to {area:415}. Erelas, Jenal and Gracina take their deliveries on the {zone:1448} guide's {zone:1457} stop, which goes there anyway."] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}飛行管理員",

	-- Step 54: Into Azshara
	-- {zone:1447} Azshara
	["Into {zone:1447}"] = "進入{zone:1447}",
	-- {area:415} Astranaar · {area:2358} Forest Song · {zone:1447} Azshara · {area:1235} Shadowsong Shrine
	["From {area:415}, ride east along the road past {area:2358} into {zone:1447}: {area:1235} lies just over the border, in {zone:1447}'s south-west corner."] = "從{area:415}沿道路向東騎，經過{area:2358}進入{zone:1447}：{area:1235}就在邊界另一側，位於{zone:1447}西南角。",
	-- {area:1235} Shadowsong Shrine
	["East along the road to {area:1235}"] = "沿道路向東前往{area:1235}",

	-- Step 55: Shadowsong Shrine
	-- {zone:1447} Azshara · {area:3137} Talrendis Point
	["The shrine lies in the south-west corner of {zone:1447}, south of {area:3137}."] = "神殿位於{zone:1447}西南角，在{area:3137}南邊。",

	-- Step 56: Talrendis Point
	-- {npc:239822} Commander Truesong · {npc:240482} Berdun Cliffbrew · {area:3137} Talrendis Point
	["Just north-east of the shrine: {npc:239822} and {npc:240482} keep the Alliance camp at {area:3137}."] = "就在神殿東北方：{npc:239822}和{npc:240482}駐守在{area:3137}的聯盟營地。",

	-- Step 57: Mosshoof Runners
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["Mosshoof Runners"] = "苔蹄奔跑者",
	-- {area:3137} Talrendis Point
	-- plural, as words: Mosshoof Runners = {npc:8759} Mosshoof Runner
	["The Mosshoof Runners (45-47) graze the hills north of {area:3137}, on the way to the satyrs."] = "苔蹄奔跑者（45-47）在{area:3137}北邊的山丘上吃草，就在前往薩特的路上。",

	-- Step 58: Azshara: kill these as you meet them
	-- {zone:1447} Azshara
	["{zone:1447}: kill these as you meet them"] = "{zone:1447}：沿途擊殺以下目標",
	-- {npc:222478} Sentinel Keldara Sunblade
	["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it. {npc:222478} is held in the satyrs' camp: free her and walk her out."] = "精靈貴族的鬼魂在神殿周圍的遺跡中出沒；哈達爾薩特佔據神殿北邊不遠處的營地。{npc:222478}被關在薩特營地裡：救出她並護送她離開。",
	-- {npc:222478} Sentinel Keldara Sunblade
	["{npc:222478}, in the camp"] = "{npc:222478}，在營地裡",

	-- Step 59: The western shore
	["The western shore"] = "西岸",
	-- plural, as words: Spitelash Warriors = {npc:6190} Spitelash Warrior
	["The Spitelash Warriors (46-47) and Screamers (47-48) hold the western shore north-east of the satyrs."] = "惡鞭戰士（46-47）和惡鞭尖叫者（47-48）佔據薩特東北方的西岸。",

	-- Step 60: Talrendis Point
	-- {area:3137} Talrendis Point
	["Back south-west to {area:3137}."] = "向西南返回{area:3137}。",
	-- {npc:239822} Commander Truesong · {quest:88809} Preserving Eldarath · {area:1221} Ruins of Eldarath
	["{npc:239822}: {quest:88809}, the relics drop from the naga of the {area:1221} ahead"] = "",
	-- {npc:239822} Commander Truesong · {quest:92345} Beneath Nordrassil · {npc:4217} Mathrengyl Bearwalker · {zone:1457} Darnassus · {zone:1448} Felwood
	["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, on the {zone:1448} guide: keep it"] = "",

	-- Step 63: Ogtinc
	-- {npc:8405} Ogtinc · {area:1224} Bear's Head
	["Ride north-east from the shrine: {npc:8405} camps at the {area:1224}, in the hills above the road."] = "從神殿向東北騎：{npc:8405}在{area:1224}紮營，位於道路上方的山丘上。",

	-- Step 64: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo · {npc:8379} Archmage Xylem
	["Get off your mount before you talk to {npc:8395}: he teleports you up to {npc:8379}'s tower on the cliff above his camp."] = "和{npc:8395}說話前先下坐騎：他會把你傳送到他營地上方懸崖上{npc:8379}的塔裡。",

	-- Step 65: Archmage Xylem
	["The apprentice at the top of the tower sends you back down."] = "塔頂的學徒會把你送回去。",
	-- {area:1220} Thalassian Base Camp · {npc:8420} Kim'jael
	["The blood elves are at the {area:1220}, on the way to {npc:8420}"] = "血精靈在{area:1220}，就在去{npc:8420}的路上",

	-- Step 66: The Ruins of Eldarath
	-- {area:1221} Ruins of Eldarath
	["The {area:1221}"] = "{area:1221}",
	-- {area:1221} Ruins of Eldarath · {item:13815} Some Rune · {item:10445} Drawing Kit
	-- was: ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}的惡鞭納迦身上帶著{item:13815}。{npc:8507}的四塊符文石立在遺跡之間：對每一塊使用他的{item:10445}。"
	["The Spitelash naga of the {area:1221} carry {item:13815}. Tymor's runes stand among the ruins: use his {item:10445} on each."] = "",

	-- Step 67: Lord Sarthiss
	-- {npc:239939} Lord Sarthiss
	-- plural, as words: Eldarath Relics = {item:280608} Eldarath Relic
	-- was: ["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "不管是否在補等級，這片遺跡的惡鞭納迦都會掉落楚頌的埃達拉斯文物。{npc:239939}（52級）站在埃達拉斯遺跡中，惡鞭侍從的西南方：單獨把他拉出來。"
	["The Spitelash naga of these ruins drop Truesong's Eldarath Relics. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "",

	-- Step 68: Ekkal
	-- {npc:235903} Ekkal · {npc:8420} Kim'jael
	["{npc:235903} camps by the road north to {npc:8420}: his satyrs are in {npc:8420}'s camp."] = "{npc:235903}在往北通往{npc:8420}的道路旁紮營：他要的薩特在{npc:8420}的營地裡。",

	-- Step 69: Mosshoof Coursers
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers"] = "苔蹄快步者",
	-- {area:1224} Bear's Head · {area:1219} Legashi Encampment
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	-- was: ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "最近的苔蹄快步者在{area:1224}東北方、往{area:1219}方向的山丘上覓食；更大的一群在南邊的空地上遊蕩。\n小心：苔蹄快步者是52-53級，在這裡比你高一兩級：從獸群邊緣一次拉一隻。"
	["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53: pull them one at a time from the herd's edge."] = "",

	-- Step 72: Kim'jael
	-- {npc:8420} Kim'jael · {area:1219} Legashi Encampment · {area:1220} Thalassian Base Camp · {npc:6647} Magister Hawkhelm · {npc:235903} Ekkal
	-- plural, as words: Blood Elf Surveyors = {npc:6198} Blood Elf Surveyor · Legashi Soulstealers = {npc:236867} Legashi Soulstealer
	["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him.\nCareful: the Blood Elf Surveyors are 51-52 and the Reclaimers 52-53, with {npc:6647} (53) among them: take the equipment from the camp's edge and pull the elves one at a time.\n{npc:235903}'s satyrs, rogues and hellcallers (51-53) are the Legashi around {npc:8420}'s camp; the Legashi Soulstealers, Hellraisers and Blackguards (53) further east are not part of it: stay west of them."] = "{npc:8420}在北邊的{area:1219}紮營；他的裝備散落在他東南方不遠的{area:1220}各處。\n小心：血精靈勘測員是51-52級，收復者是52-53級，其中還有{npc:6647}（53級）：從營地邊緣拿裝備，一次拉一個精靈。\n{npc:235903}要的薩特、盜賊和地獄召喚者（51-53級）是{npc:8420}營地周圍的萊加希族；更東邊的萊加希竊魂者、地獄喚醒者和黑衛士（53級）不在任務內：待在他們西邊。",
	-- {item:20028} Glittering Dust
	["{item:20028}, from the blood elf surveyors and reclaimers"] = "{item:20028}，來自血精靈勘測員和收復者",

	-- Step 75: Ekkal
	-- {npc:235903} Ekkal
	["On the road back south, {npc:235903} takes the satyrs."] = "往南回去的路上，把薩特交給{npc:235903}。",

	-- Step 76: Rubbing: Rune of Sael'hai
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne
	["{item:7972}: the {npc:7864}, about 10%"] = "{item:7972}：{npc:7864}，約10%",

	-- Step 77: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Ride back west to {npc:8395}'s camp and get off your mount: he teleports you up to Xylem again."] = "向西騎回{npc:8395}的營地並下坐騎：他會再把你傳送到克希雷姆那裡。",

	-- Step 79: The Temple of Zin-Malor
	-- {area:1223} Temple of Zin-Malor
	["The {area:1223}"] = "{area:1223}",
	-- {area:1223} Temple of Zin-Malor · {npc:8395} Sanath Lim-yo
	-- plural, as words: Spitelash Sirens = {npc:6195} Spitelash Siren
	["The Spitelash Sirens wander the ruins and the beach around the {area:1223}, just south of {npc:8395}. Only the Sirens carry the coral, not the Screamers."] = "恨鱗海妖在{area:1223}周圍的廢墟和海灘遊蕩，就在{npc:8395}以南。只有海妖帶著珊瑚，尖嘯者沒有。",

	-- Step 80: Sanath Lim-yo
	-- {npc:8395} Sanath Lim-yo
	["Back north to {npc:8395}'s camp at the foot of the cliff and get off your mount: he teleports you up to Xylem again."] = "",

	-- Step 81: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo
	["Back up through {npc:8395}'s teleport."] = "再次透過{npc:8395}的傳送上去。",
	-- {area:1417} Sunken Temple
	["Xylem's last task, Destroy Morphaz, is in the {area:1417}: skip it."] = "克希雷姆的最後一個任務“消滅莫法茲”在{area:1417}：跳過。",

	-- Step 83: Ravencrest Monument
	-- {zone:1447} Azshara · {npc:8392} Pilot Xiggs Fuselighter · {item:10444} Standard Issue Flare Gun
	["Swim to the small island off the southern tip of {zone:1447}. If {npc:8392} isn't there, fire your {item:10444} to signal him, and wait for him to land."] = "游到{zone:1447}南端外海的小島。如果{npc:8392}不在那裡，發射你的{item:10444}向他發出信號，然後等他降落。",
	-- {zone:1455} Ironforge · {zone:1422} Western Plaguelands
	["Tymor in {zone:1455}, on the {zone:1422} guide's {zone:1455} stop: keep it"] = "",

	-- Step 84: Talrendis Point
	-- {area:3137} Talrendis Point · {zone:1448} Felwood
	["Back to Truesong at {area:3137}: {zone:1448}, the next guide, is a short ride west."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Truesong at {area:3137} before you hearth."] = "用爐石之前先回{area:3137}找楚頌。",
	-- ["Back to {npc:3546} in {area:1438} before you hearth."] = "使用爐石前，先回到{area:1438}的{npc:3546}處。",
	-- ["Bloodmages' camp"] = "血法師營地",
	-- ["Class trainer"] = "職業訓練師",
	-- ["Climb back to {npc:8405} at the {area:1224}, above the ruins."] = "爬回遺跡上方{area:1224}的{npc:8405}處。",
	-- ["Climb to the top of {area:249} and plant the head in the soft dirt mound."] = "爬上{area:249}頂端，把頭顱插在鬆軟的土堆上。",
	-- ["Druid training"] = "德魯伊訓練",
	-- ["Fly from {zone:1455} to {area:150} and take the boat to {area:442}."] = "從{zone:1455}飛往{area:150}，搭船前往{area:442}。",
	-- ["Fly from {zone:1455} to {area:69}."] = "從{zone:1455}飛往{area:69}。",
	-- ["Fly to {area:150} and take the boat to {area:442}, then the boat on to {area:702}."] = "飛往{area:150}，搭船前往{area:442}，再轉船前往{area:702}。",
	-- ["Fly to {area:702}"] = "飛往{area:702}",
	-- ["For {npc:5594} in {area:976}, on the {zone:1422} guide: keep it"] = "給{area:976}的{npc:5594}，在{zone:1422}指南中：保留此任務",
	-- ["For {zone:1453}: keep it"] = "給{zone:1453}：保留此任務",
	-- ["From the {area:442} dock, fly to {area:415}."] = "從{area:442}碼頭飛往{area:415}。",
	-- ["Help her escape the camp"] = "幫助她逃出營地",
	-- ["If you skipped {quest:4022}, grind here to level 52.08 to stay on the route's plan. Or, with a group, run the {area:1417} dungeon instead."] = "如果跳過了{quest:4022}，就在這裡刷到52.08級，以跟上路線進度。也可以組隊去{area:1417}地下城。",
	-- ["Level 51.3 on the way north"] = "往北途中升到51.3級",
	-- ["Level 52 at {area:249}"] = "在{area:249}升到52級",
	-- ["Level 52.08"] = "52.08級",
	-- ["Open the {item:10569} from {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight."] = "打開來自{zone:1427}的{item:10569}取得{item:10575}，然後告訴{npc:9459}你帶來了功績的證明：不必與飛龍戰鬥。",
	-- ["Optional: {npc:8395} wants two Undamaged Hippogryph Feathers from the hippogryphs around his camp. The data lists no experience for it."] = "可選：{npc:8395}要兩根完整的角鷹獸羽毛，從他營地周圍的角鷹獸身上取得。資料沒有列出這個任務的經驗值。",
	-- ["Optional: {npc:8888}'s ghost stands on his tomb on the great chain inside {area:254}, and only the dead can see him. If you die near the mountain anyway, run your spirit to him before resurrecting."] = "可選：{npc:8888}的鬼魂站在{area:254}內巨大鎖鏈上的墳墓上，只有死者能看見他。如果你反正在山附近死了，在復活前讓你的靈魂跑去找他。",
	-- ["Portal to {zone:1438}"] = "傳送門前往{zone:1438}",
	-- ["Priests and Mages trained here at the end of the Un'Goro guide"] = "牧師和法師已在安戈洛指南結尾於此學習過",
	-- ["Read the tablet in the {object:147516} camp among the ruins, south-west of {area:251}, to copy the transcript."] = "閱讀{area:251}西南方遺跡中{object:147516}營地裡的石板，抄下文字。",
	-- ["Ride back south into the {zone:1419} for the bloodmages' beasts: Starving Snickerfangs roam the dry hills south of the bloodmages' camp, Scorpok Stingers scuttle across the middle of the north and {npc:5982} vultures circle over all of it. Ashmane Boars and Redstone Basilisks share the slopes south-west of the keep.\nCareful: two elites roam here: {npc:221740} (50) in the middle of the zone around 44,34, and {npc:247015} (55) on the ridge around 39,32. When you see one, hunt somewhere else."] = "向南騎回{zone:1419}，獵殺血法師要的野獸：饑餓的彎牙土狼在血法師營地南邊的乾燥山丘遊蕩，厚甲毒刺蠍在北部中央爬行，{npc:5982}禿鷲在整片區域上空盤旋。灰鬃野豬和紅石蜥蜴分布在要塞西南方的山坡上。\n小心：這裡有兩隻精英在遊蕩：{npc:221740}（50級）在地區中央約44,34附近，{npc:247015}（55級）在約39,32的山脊上。看到其中一隻就換個地方打。",
	-- ["Ride back to {area:1438} and fly to {area:348}. The Wildkin Feathers lie on the ground across the {zone:1425}, south and east of {area:348}, where the owlbeasts roam; the mobs here are well below you now."] = "騎回{area:1438}，飛往{area:348}。梟獸羽毛散落在{area:348}南邊和東邊、梟獸遊蕩的{zone:1425}各處地上；這裡的怪物現在比你低很多。",
	-- ["Ride east along the road out of {zone:1440} into {zone:1447} to the Sentinels' camp at {area:3137}."] = "沿著道路向東騎出{zone:1440}進入{zone:1447}，前往{area:3137}的哨兵營地。",
	-- ["Ride north out of the {zone:1419} into the {zone:1435}: the {npc:10996} stands by the road from the {zone:1419}. Keep clear of {area:75}, the Horde town to the north-east. Listen to his tale, then ride back south to Kum'isha."] = "向北騎出{zone:1419}進入{zone:1435}：{npc:10996}站在從{zone:1419}過來的道路旁。遠離東北方的部落城鎮{area:75}。聽完他的故事，然後向南騎回庫米莎那裡。",
	-- ["Ride north out of {area:69} through the pass into the {zone:1428}; {area:2418} sits at the top, in the south-east of the Steppes."] = "向北騎出{area:69}，穿過山口進入{zone:1428}；{area:2418}位於頂端，在燃燒平原東南部。",
	-- ["Ride north to the bloodmages' camp beside the road into the {zone:1419}."] = "向北騎到進入{zone:1419}道路旁的血法師營地。",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "骷髏撕掠者和流涎食屍鬼在營地北面的田野遊蕩；這裡的天災怪都會掉落天災石。\n注意：這些亡靈從很遠就能發現你，拉怪時附近的亡靈會加入戰鬥。\n注意：{npc:10411}（3個重生點，15分鐘重新出現）脫離戰鬥後會隱形，戰鬥一開始就會呼叫石翼石像鬼。",
	-- ["Swim to the small island off the southern tip of {area:16}: {npc:8392} waits by the monument."] = "游到{area:16}南端外海的小島：{npc:8392}在紀念碑旁等候。",
	-- ["Swim to the small island off the southern tip of {zone:1447}: {npc:8392} waits by the monument."] = "游到{zone:1447}南端外海的小島：{npc:8392}在紀念碑旁等候。",
	-- ["Thaurissan Relics"] = "索瑞森遺物",
	-- ["The Firegut ogres hold the great rock north of the Vigil, with the Brutes on its east side.\nCareful: Escaped Core Hounds (level 60) roam the Steppes, a few on the slopes west and south of {area:249}: pull the ogres on the rock itself and look around before each pull."] = "火腹巨魔佔據摩根的崗哨北邊的巨石，火腹蠻兵在它的東側。\n小心：逃脫的熔火惡犬（60級）在燃燒平原遊蕩，有幾隻在{area:249}西邊和南邊的山坡上：就在巨石上拉巨魔，每次拉怪前先看看四周。",
	-- ["The Highborne ghosts haunt the ruins around the shrine; the Haldarr satyrs hold the camp just north of it."] = "精靈貴族的鬼魂在神殿周圍的遺跡中出沒；哈達爾薩特佔據神殿北邊不遠處的營地。",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s four runes stand among the ruins: use his {item:10445} on each."] = "{area:1221}的惡鞭納迦身上帶著{item:13815}。{npc:8507}的四塊符文石立在遺跡之間：對每一塊使用他的{item:10445}。",
	-- ["The Spitelash naga of the {area:1221} carry {item:13815}. {npc:8507}'s runes stand among the ruins: use his {item:10445} on each. The naga here are the ones the top-up below asks for, so these kills count towards it."] = "{area:1221}的惡鞭納迦身上帶著{item:13815}。{npc:8507}的符文石立在遺跡之間：對每一塊使用他的{item:10445}。這裡的納迦正是下方補等級步驟要求的目標，所以這些擊殺也會計入。",
	-- ["The Spitelash naga of these ruins drop Truesong's Eldarath Relics, top-up or not. {npc:239939} (52) stands in the ruins of Eldarath, south-west of the Myrmidons: pull him alone."] = "不管是否在補等級，這片遺跡的惡鞭納迦都會掉落楚頌的埃達拉斯文物。{npc:239939}（52級）站在埃達拉斯遺跡中，惡鞭侍從的西南方：單獨把他拉出來。",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south."] = "最近的苔蹄快步者在{area:1224}東北方、往{area:1219}方向的山丘上覓食；更大的一群在南邊的空地上遊蕩。",
	-- ["The nearest Mosshoof Coursers graze the hills north-east of the {area:1224}, toward the {area:1219}; a larger herd roams the open ground to the south.\nCareful: the Mosshoof Coursers are 52-53, a level or two over you here: pull them one at a time from the herd's edge."] = "最近的苔蹄快步者在{area:1224}東北方、往{area:1219}方向的山丘上覓食；更大的一群在南邊的空地上遊蕩。\n小心：苔蹄快步者是52-53級，在這裡比你高一兩級：從獸群邊緣一次拉一隻。",
	-- ["The portal in {area:702} leads up to {zone:1457}: {npc:9047} waits in the {area:1658}, in the north of the city."] = "{area:702}的傳送門通往上方的{zone:1457}：{npc:9047}在城市北邊的{area:1658}等候。",
	-- ["The relics are the carved stones scattered through the {area:250} around {area:251}: click them until the information is recovered."] = "遺物是散布在{area:251}周圍{area:250}的雕刻石塊：點擊它們，直到資訊全部取回。",
	-- ["The shrine lies in the south-west corner of {area:16}, south of {area:3137}."] = "神殿位於{area:16}西南角，在{area:3137}南邊。",
	-- ["The wildkin are in {zone:1452}: keep it"] = "梟獸在{zone:1452}：保留此任務",
	-- ["The {quest:4296}"] = "{quest:4296}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:7977} (level 48 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\n{npc:7977} walks the {zone:1425} shore below the {area:307}, from the arrow south to about 75,66 and north to about 82,52: if she isn't at the arrow, follow the shore."] = "這些是精英怪物：建議組隊，找人一起完成。{npc:7977}（48級精英）需要2人隊伍。如果你是單獨一人就跳過：路線會讓你練級把經驗值補回來。\n{npc:7977}在{area:307}下方的{zone:1425}海岸上走動，從箭頭處往南到約75,66，往北到約82,52：如果她不在箭頭處，就沿著海岸找。",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:9461} is a level 54 elite: most classes solo it at level 56, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "這些是精英怪：建議組隊，找人一起做。{npc:9461}是54級精英：大多數職業在56級可以單挑，但你可能需要幫助。如果你獨自一人就跳過：路線會讓你把經驗刷回來。",
	-- ["Top up first to level 52 on the Firegut Ogres (50-51) on the near side of {area:249}, north of the Vigil: the Brutes on its east side are 52-53. Or, with a group, run the {area:1417} dungeon instead."] = "先在摩根的崗哨北邊、{area:249}近側擊殺火腹巨魔（50-51級），補到52級：東側的火腹蠻兵是52-53級。或者，有小隊的話，改打{area:1417}地城。",
	-- ["Top up to level 51.3 on the Spitelash Myrmidons (50-51) of the ruins between {npc:8395}'s camp and the north: the blood elves at {npc:8420}'s camp are 51-53. Or, with a group, run the {area:1417} dungeon instead."] = "在{npc:8395}營地與北邊之間的遺跡中擊殺惡鞭侍從（50-51級），補到51.3級：{npc:8420}營地的血精靈是51-53級。或者，有小隊的話，改打{area:1417}地城。",
	-- ["Upstairs"] = "樓上",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves."] = "在{area:251}東邊山坡上的{npc:7047}快死時對牠使用{item:12284}，然後拾取牠留下的精華。",
	-- ["Use the {item:12284} on a {npc:7047} on the slopes east of {area:251} just before it dies, then loot the essence it leaves.\nCareful: a {npc:8981} (level 56, rare) walks the slopes by the broodlings, and the {npc:7040} and Wyrmkin around them are elite: use the Incarcinatrix on a broodling at the edge and look around before each pull."] = "在{area:251}東邊山坡上的{npc:7047}快死時對它使用{item:12284}，然後拾取它留下的精華。\n小心：一隻{npc:8981}（56級，稀有）在小龍附近的山坡上走動，周圍的{npc:7040}和龍人都是精英：對邊緣的小龍使用採集器，每次拉怪前先看看四周。",
	-- ["Wildkin feathers"] = "梟獸羽毛",
	-- ["Your Hearthstone is set at {zone:1455} (the {zone:1425} guide binds it there): hearth back to the inn."] = "你的爐石設定在{zone:1455}（{zone:1425}指南會綁定在那裡）：用爐石回到旅店。",
	-- ["grind on {npc:6196}"] = "刷{npc:6196}",
	-- ["grind on {npc:7033}"] = "擊殺{npc:7033}練級",
	-- ["grind on {npc:9690}"] = "刷{npc:9690}",
	-- ["keep it: the {area:199} cauldron waits for the {zone:1452} guide's Chillwind stop, at about 55"] = "保留此任務：{area:199}的大鍋留到{zone:1452}指南在冰風營地的停留點，約55級",
	-- ["{area:199} cauldron"] = "{area:199}的瘟疫之鍋",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "{npc:10778}的鬼魂在{area:200}西邊{area:199}的農舍旁徘徊；她的包裹就在屋裡。",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075}守護著安多哈爾西邊{area:199}的瘟疫之鍋。",
	-- ["{npc:239822}: {quest:88809}, the relics drop from the naga of the top-up ahead"] = "{npc:239822}：{quest:88809}，遺物由前面練級時打的納迦掉落",
	-- ["{npc:239822}: {quest:92345}, for {npc:4217} in {zone:1457}, keep it"] = "{npc:239822}：{quest:92345}，交給{zone:1457}的{npc:4217}，保留此任務",
	-- ["{npc:4217} is upstairs in the druids' building of the {area:1658}: go in by its south door."] = "{npc:4217}在{area:1658}德魯伊建築的樓上：從南門進去。",
	-- ["{npc:4217}, upstairs"] = "{npc:4217}，在樓上",
	-- ["{npc:5111}: the last guide binds here, so this usually ticks at once"] = "{npc:5111}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
	-- ["{npc:7363} waits at the {area:2517}, the hill south-west of the keep. The {zone:1419} mobs on the way drop the Imperfect Draenethyst Fragments; bring her what you have."] = "{npc:7363}在要塞西南方的山丘{area:2517}等候。沿途的{zone:1419}怪物會掉落不完美的德萊尼水晶碎片；把你有的帶給她。",
	-- ["{npc:7740} stands beside Tyrande in the Temple of the Moon, in the south of the city."] = "{npc:7740}站在城市南部月神殿裡的泰蘭妲身旁。",
	-- ["{npc:7740}: {quest:162}, from {area:976}"] = "{npc:7740}：{quest:162}，來自{area:976}",
	-- ["{npc:7907} stands upstairs, above {npc:7916}: go up inside, the arrow cannot tell the floors apart."] = "{npc:7907}站在樓上，在{npc:7916}上方：從裡面走上去，箭頭無法分辨樓層。",
	-- ["{npc:8395} wants two Undamaged Hippogryph Feathers from the Thunderhead hippogryphs around his camp, the ones you top up on here: about one in three carries one."] = "{npc:8395}要兩根完整的角鷹獸羽毛，從他營地周圍的雷首角鷹獸身上取得，也就是你在這裡練級的那些：大約每三隻有一隻會帶著一根。",
	-- ["{npc:8420} camps at the {area:1219} in the north; his equipment lies all over the {area:1220} just south-east of him."] = "{npc:8420}在北邊的{area:1219}紮營；他的裝備散落在他東南方不遠處的{area:1220}各處。",
	-- ["{npc:9047}, in the {area:1658}"] = "{npc:9047}，在{area:1658}",
	-- ["{npc:9176} and the Blackrock orcs hold the camps and the stronghold at the foot of {area:254}, west of {area:251}. Pull them one at a time; every orc and worg may drop a medallion, so kill them until you have fifty.\nCareful: {npc:9176} has a guard linked to him that joins the fight, and a second soldier patrols close by; clear the patrol before pulling.\nCareful: Firesworn, level 60 fire elementals, wander the Steppes, some between the Blackrock camps: look before each pull and let them pass."] = "{npc:9176}和黑石獸人佔據{area:251}西邊、{area:254}山腳下的營地和要塞。一次拉一隻；每個獸人和座狼都可能掉落徽章，所以一直殺到你有五十個為止。\n小心：{npc:9176}身邊有一名連動的守衛會一起參戰，附近還有第二名士兵在巡邏；拉怪前先清掉巡邏的士兵。\n小心：火誓者（60級火元素）在燃燒平原遊蕩，有些在黑石營地之間：每次拉怪前先看看，讓牠們走過去。",
	-- ["{npc:9177}: the Blackrock orcs drop the medallions, keep it open all through the Steppes"] = "{npc:9177}：黑石獸人會掉落徽章，在整個燃燒平原期間保持此任務進行中",
	-- ["{object:175894}, inside"] = "{object:175894}，室內",
	-- ["{zone:1455} has no druid trainer"] = "{zone:1455}沒有德魯伊訓練師",
	-- ["{zone:1455} has no druid trainer: take the portal up to {zone:1457} and train in the {area:1658}, then come back down to {area:702}."] = "{zone:1455}沒有德魯伊訓練師：走傳送門上到{zone:1457}，在{area:1658}學習，然後回到下方的{area:702}。",
}
