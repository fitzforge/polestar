-- Chinese (traditional) (zhTW): the guide forever/horde/30-40/04-dustwallow-marsh (forever/horde/30-40/04-dustwallow-marsh.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",

	-- Step 2: Orgrimmar
	-- {zone:1454} Orgrimmar
	["The middle of {zone:1454}"] = "{zone:1454}中部",

	-- Step 3: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}，給「沼澤之眼」加爾",
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {area:720} Fray Island
	["{npc:3354}, {object:172958}: for {area:720}, later in this guide (offered from level 30)"] = "{npc:3354}，{object:172958}：交給{area:720}，本指南稍後（30級起可接）",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "飛往十字路口",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 5: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428}站在十字路口飛行管理員旁邊。",
	-- {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["for {npc:4485} in {zone:1454}, at the end of this guide"] = "交給{zone:1454}的{npc:4485}，在本指南末尾",

	-- Step 6: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "飛往{area:378}",
	["Crossroads flight master"] = "十字路口飛行管理員",

	-- Step 8: Shady Rest Inn
	-- {area:378} Camp Taurajo · {area:403} Shady Rest Inn
	["Head east from {area:378} along the road into the marsh. The burned-out {area:403} stands beside it just past the border; the shield, the badge and the hoofprints are in and beside the ruin."] = "從{area:378}沿著道路向東進入沼澤。燒毀的{area:403}就在過了邊界不遠的路旁；盾牌、徽章和蹄印都在廢墟裡和廢墟旁。",

	-- Step 10: Brackenwall Village
	["Take the road north at the fork to the ogre village of Brackenwall."] = "在岔路往北走，前往巨魔村莊蕨牆村。",
	-- {npc:4503} Mudcrush Durtfeet
	["{npc:4503}, at the south edge of the village where the road comes in"] = "{npc:4503}，在村莊南緣、道路進村的地方",

	-- Step 11: Stinky Ignatz
	["Stinky Ignatz"] = "伊格納茲",
	-- {area:502} Witch Hill
	["Head north to {area:502}. Stinky stands at the foot of the hill; escort him while he gathers Bogbean Leaves just south of it."] = "向北前往{area:502}。伊格納茲站在山腳下；他在山南邊採集泥豆葉時護送他。",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "黑鰭魚人",
	-- {area:502} Witch Hill
	["The Mirefin murlocs crowd the coast east and north-east of {area:502}; every kind drops heads."] = "黑鰭魚人聚集在{area:502}東邊和東北方的海岸；每一種都會掉落頭顱。",

	-- Step 13: Swamp Eye Jarl
	["Swamp Eye Jarl"] = "「沼澤之眼」加爾",
	-- {area:497} Swamplight Manor · {area:502} Witch Hill
	["Jarl lives in the {area:497} south-east of {area:502}."] = "加爾住在{area:502}東南方的{area:497}。",
	-- {object:20985} Loose Dirt
	["{object:20985}, beside the manor"] = "{object:20985}，在莊園旁",
	-- {quest:1218} Soothing Spices · {zone:1454} Orgrimmar
	["{quest:1218}, if you did not buy them in {zone:1454}"] = "{quest:1218}，如果你沒在{zone:1454}買的話",

	-- Step 14: Brackenwall Village: kill these as you meet them
	-- {area:496} Brackenwall Village
	["{area:496}: kill these as you meet them"] = "{area:496}：遇到這些就殺",
	-- plural, as words: Darkfang Lurkers = {npc:4411} Darkfang Lurker · Theramore Infiltrators = {npc:4834} Theramore Infiltrator · Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["Head west back across the marsh. The Darkfang Lurkers (36-37) and Venomspitters (37-38) on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely.\nThe Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes. Work its outer edge, where the Spiders and Recluses (35-37) stand: the Lurkers and Silkspinners (37-39) deeper in are two or three over you.\nCareful: Darkfang Lurkers (level 36-37) use Sneak to stealth while out of combat and cast Poison once fighting.\nCareful: Stealthed spiders in the same area will attack you on sight.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "向西穿過沼澤回去。蕨牆村北邊山脊上的暗牙潛伏者（36-37級）和暗牙毒液噴吐者（37-38級）會掉落毒囊。塞拉摩間諜（35-36級）在同一片樹林裡潛行：牠們處於潛行狀態，要仔細看。\n暗霧蜘蛛聚集在蕨牆村西北方的洞穴口；每一種都會掉落眼睛。在外圍打，那裡是蜘蛛和隱士蛛（35-37級）：更深處的潛伏者和織絲蛛（37-39級）比你高兩三級。\n小心：暗牙潛伏者（36-37級）在非戰鬥時會潛行，戰鬥中會施放毒素。\n小心：同一區域潛行的蜘蛛看到你就會攻擊。\n小心：暗霧潛伏者會潛行移動，戰鬥中會使用毒素。蜘蛛站得很近，很容易引來額外的怪；從外圍單拉可以減少這種情況。",
	-- plural, as words: Giant Darkfang Spiders = {npc:4415} Giant Darkfang Spider
	["Every Darkfang spider drops them: Lurkers, Spiders, Venomspitters and the Giant Darkfang Spiders"] = "",

	-- Step 16: Questioning Reethe
	-- {npc:4983} Ogron · {area:2302} Quagmire · {npc:5045} Private Hallan
	-- plural, as words: Theramore Skirmishers = {npc:5044} Theramore Skirmisher
	["On the way east, {npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out: {npc:5045} and Theramore Skirmishers (36) join it."] = "往東的路上，{npc:4983}在村莊東邊的{area:2302}等候。跟著他去找雷瑟，在爆發的戰鬥中保住他的性命：{npc:5045}和塞拉摩爭鬥者（36級）會加入戰鬥。",

	-- Step 17: Swamp Eye Jarl
	-- {area:497} Swamplight Manor
	["On east to the {area:497}."] = "繼續向東前往{area:497}。",
	-- {object:20985} Loose Dirt · {npc:4791} Nazeer Bloodpike
	["{object:20985}, now that {npc:4791} has read the report"] = "{object:20985}，現在{npc:4791}已經讀過報告了",
	-- {item:3853} Moonsteel Broadsword · {skill:164} Blacksmithing
	["only if you carry a {item:3853} ({skill:164} or the Auction House)"] = "僅限你帶著{item:3853}時（{skill:164}或拍賣場）",

	-- Step 18: The Theramore Docks
	-- {area:513} Theramore Isle · {object:20925} Captain's Footlocker
	-- plural, as words: Young Murk Threshers = {npc:4388} Young Murk Thresher
	["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer. Young Murk Threshers (40-41) circle in the water around the docks: grab the footlocker and swim straight out."] = "從莊園往東南前往{area:513}：{object:20925}在島嶼東側碼頭外的海底。游進去再游出來，遠離碼頭和城鎮：塞拉摩的守衛是53-57級，在這裡死掉的話，從靈魂醫者那裡跑回來要很久。幼年黑色蛇頸龍（40-41級）在碼頭周圍的水中巡游：拿到置物箱就直接游出去。",
	["Underwater"] = "在水下",

	-- Step 19: Brackenwall Village
	-- {npc:4503} Mudcrush Durtfeet · {npc:4791} Nazeer Bloodpike · {npc:4926} Krog
	["Head back west to Brackenwall with the head: {npc:4503} stands at the south edge of the village where the road comes in, {npc:4791} and {npc:4926} in the village."] = "帶著頭顱向西回到蕨牆村：{npc:4503}站在村莊南緣、道路進村的地方，{npc:4791}和{npc:4926}在村裡。",
	-- {npc:2519} Kin'weelay · {object:3202} Grom'gol
	["For {npc:2519} at {object:3202}, in forever/horde/40-50/01-stranglethorn-vale"] = "交給{object:3202}的{npc:2519}，在（forever/horde/40-50/01-stranglethorn-vale）指南中",

	-- Step 20: Level 36
	["Level 36"] = "36級",
	-- {zone:1443} Desolace
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["{zone:1443}'s last quests are 36-39. Still below 36 after Brackenwall's hand-ins? The Drywallow Crocolisks (35-36) along the river east of the village are the closest at your level: kill them until level 36."] = "{zone:1443}的最後幾個任務是36-39級。繳交完蕨牆村的任務後還不到36級？村莊東邊河岸的塵泥鱷魚（35-36級）是最近且符合你等級的怪：擊殺牠們直到36級。",
	-- plural, as words: Drywallow Crocolisks = {npc:4341} Drywallow Crocolisk
	["Drywallow Crocolisks"] = "塵泥鱷魚",
	-- {npc:4341} Drywallow Crocolisk
	["grind on {npc:4341}"] = "打{npc:4341}練等",

	-- Step 21: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "{area:496}飛行管理員",

	-- Step 22: Ratchet
	-- {npc:3446} Mebok Mizzyrix
	["{npc:3446} stands below Gazlowe's house by the flight master, towards the docks."] = "{npc:3446}站在飛行管理員旁加茲羅的房子下方，靠碼頭那一側。",

	-- Step 23: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Head south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "從{area:392}沿海岸向南到{area:720}。{npc:6236}站在競技場旁：踏上鐵柵格開始戰鬥；挑戰者會一個個上來，最後是{npc:6238}（33級）。",

	-- Step 24: Ratchet flight master
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}飛行管理員",
	-- {area:392} Ratchet
	["Back north along the coast to {area:392}'s flight master."] = "沿著海岸往北回到{area:392}的飛行管理員。",

	-- Step 25: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "飛往{area:2408}",
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["Fly to {area:2408} from the flight master you are next to: {area:392}'s, or Brackenwall's if you had no errand in {area:392}."] = "從你旁邊的飛行管理員飛往{area:2408}：{area:392}的，如果你在{area:392}沒有事要辦，就用蕨牆村的。",

	-- Step 26: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {npc:12340} Drulzegar Skraghook
	["{npc:11624} and {npc:12340} stand in the village."] = "{npc:11624}和{npc:12340}在村子裡。",
	-- {npc:11624} Taiga Wisemane · {quest:5381} Hand of Iruxos · {area:599} Thunder Axe Fortress
	["{npc:11624}: the {quest:5381}, at {area:599} later on this visit"] = "{npc:11624}：{quest:5381}，這次稍後在{area:599}",
	-- {npc:12340} Drulzegar Skraghook · {area:599} Thunder Axe Fortress
	["{npc:12340}: the Slitherblade of Sar'theris Strand, on the way back from {area:599}"] = "{npc:12340}：薩瑟里斯海岸的滑刃魚人，從{area:599}回來的路上",

	-- Step 27: Ghost Walker Post
	-- {area:597} Ghost Walker Post · {npc:5412} Gurda Wildmane · {npc:5395} Felgur Twocuts
	["East along the road to {area:597}; {npc:5412} stands beside {npc:5395}."] = "沿著道路向東前往{area:597}；{npc:5412}站在{npc:5395}旁邊。",
	-- {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty
	["{npc:5395}: his {quest:1366}, from the same Maraudine as Gurda's totems"] = "{npc:5395}：他的{quest:1366}，來自與古爾達的圖騰同一批的瑪勞登半人馬",

	-- Step 28: Valley of Spears
	-- {area:607} Valley of Spears · {item:254432} Carved Centaur Totem · {npc:5395} Felgur Twocuts · {quest:1366} Centaur Bounty · {npc:5402} Khan Hratha
	-- plural, as words: Rock Worms = {npc:11788} Rock Worm
	["West of the post, the Maraudine centaurs hold the {area:607}; every Maraudine can drop a {item:254432} and an ear for {npc:5395}'s {quest:1366}. Stay with the Scouts and Wranglers (36-38) at the valley's eastern edge; the Maulers and Windchasers (38-39) a little further in are up to two over you at 37: pull them one at a time.\nCareful: {npc:5402} and the Rock Worms (41-42, elite) hold the valley's north-western end with the Khan Guards and Marauders (39-40), and the Magram's village in the south-east has Necromancers (42-43): keep east of the arrow."] = "在營地西邊，瑪勞登半人馬佔據{area:607}；每隻瑪勞登都可能掉落{item:254432}，以及{npc:5395}的{quest:1366}要的耳朵。待在山谷東緣打斥候和馴獸者（36-38級）；再往裡一點的重錘手和逐風者（38-39級）在你37級時最多比你高兩級：一次拉一隻。\n注意：{npc:5402}和岩石蟲（41-42級，精英）與可汗衛兵、掠奪者（39-40級）佔據山谷西北端，東南方的瑪格拉姆村莊有亡靈巫師（42-43級）：待在箭頭東邊。",

	-- Step 29: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the Maraudine camp at the valley's western end; free her and escort her out east of the valley.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277}被關在山谷西端的瑪拉多營地；救出她並護送她到山谷以東。\n小心：指令碼刷出的隊伍是仇恨聯動的，而且只在護送期間出現，所以無法事先清掉，也不能一隻只拉。出發前把路上的普通半人馬清掉確實有幫助。",

	-- Step 30: Hornizz Brimbuzzle
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard
	["{npc:6019} waits at the goblin camp on the west side of the {area:596}."] = "{npc:6019}在{area:596}西側的哥布林營地等候。",
	-- {npc:6019} Hornizz Brimbuzzle · {area:602} Mannoroc Coven
	["{npc:6019}: the ghost-o-plasm, after {area:602} at the end of this visit"] = "{npc:6019}：幽質，在這趟最後打完{area:602}之後",

	-- Step 32: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {item:13542} Demon Box
	["North up the road to {area:599}. Clear the middle of the largest building, then use the {item:14523} on the red {object:176581} there. A {npc:11876} (37) comes out: kill it for the {item:13542}. The Burning Blade around it are well under you now."] = "沿道路向北前往{area:599}。清掉最大建築物的中央，然後對那裡紅色的{object:176581}使用{item:14523}。會出現一隻{npc:11876}（37級）：殺掉它取得{item:13542}。周圍的燃刃現在等級遠低於你。",
	-- {item:14523} Demon Pick · {object:176581} Hand of Iruxos Crystal
	["{item:14523}, on the {object:176581}"] = "",

	-- Step 33: Sar'theris Strand
	-- {area:598} Sar'theris Strand
	-- plural, as words: Slitherblade Myrmidons = {npc:4714} Slitherblade Myrmidon
	["West from the fortress to the coast at {area:598}: the Slitherblade Myrmidons, Naga and Sorceresses hold the beach. Pull them one at a time; the Sea Witches and Oracles (34-36) cast from range."] = "從堡壘向西前往海岸的{area:598}：滑刃侍從、納迦和女巫佔據海灘。一次拉一隻；海巫和神諭者（34-36級）會從遠處施法。",

	-- Step 34: Shadowprey Village
	-- {npc:11624} Taiga Wisemane · {area:602} Mannoroc Coven · {npc:12340} Drulzegar Skraghook
	["South down the coast to Shadowprey: {npc:11624} takes the box and sends you to {area:602} with it; {npc:12340} takes the naga."] = "沿海岸向南前往葬影村：{npc:11624}收下盒子，並讓你帶著它前往{area:602}；{npc:12340}收納迦的部分。",

	-- Step 35: Portals of the Legion
	-- {area:602} Mannoroc Coven · {quest:5381} Hand of Iruxos · {npc:11624} Taiga Wisemane · {npc:11937} Demon Portal Guardian
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["Head east to {area:602}. With the {quest:5381} from {npc:11624} in your bags, open a demon portal's ring: a {npc:11937} (38-39) comes out; kill it to close that portal. Six portals. Careful: Infernals, Doomguards and Burning Blade Summoners walk close by many portals and may join in; kill nearby mobs first or drag the guardian away, for example toward the coven's central lake."] = "向東到{area:602}。包裡帶著{npc:11624}給的{quest:5381}時，開啟惡魔傳送門的法陣：會出來一個{npc:11937}（38-39級）；殺掉它就能關上那個傳送門。一共六個門。注意：地獄火、末日守衛和燃燒之刃召喚者常在多個門附近走動，可能加入戰鬥；先清掉附近的怪，或者把守衛往別處拉，比如拉向集會的中央湖。",

	-- Step 36: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {area:2657} Valley of Bones · {zone:1443} Desolace · {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["South-east of the coven, the bone fields of the {area:2657}, where Undead Ravagers roam, at {zone:1443}'s southern edge: keep south of the Magram's village on the way. Use the {item:15848} at the arrow to draw the Magrami Spectres (38-39): they come in numbers, so fight them with your back to the valley's edge. They drop the ghost-o-plasm.\nCareful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields just west of the arrow, well above you: use the crate at the arrow, on the valley's eastern side, and pull the spectres away from them."] = "在法陣東南方，{zone:1443}南緣的{area:2657}白骨荒野，亡靈劫毀者在那裡遊蕩：途中保持在瑪格拉姆村莊南邊。在箭頭處使用{item:15848}引來瑪格拉姆幽靈（38-39級）：它們數量很多，背靠山谷邊緣作戰。它們會掉落幽質。\n注意：瑪格拉姆亡靈可汗和食屍者（45級，精英）在箭頭西邊的白骨荒野遊走，遠高於你：在山谷東側的箭頭處使用箱子，並把幽靈拉離牠們。",

	-- Step 37: Hornizz Brimbuzzle
	-- {area:596} Kodo Graveyard · {area:602} Mannoroc Coven
	["North-west to the goblin camp on the west side of the {area:596}, back past {area:602}: keep west of the Magram's village."] = "向西北返回，經過{area:602}，前往{area:596}西側的哥布林營地：保持在瑪格拉姆村莊西邊。",

	-- Step 38: Shadowprey
	["Shadowprey"] = "暗影村",
	["Hearth to Shadowprey: your hearthstone is still bound there."] = "用爐石回葬影村：你的爐石仍綁定在那裡。",

	-- Step 39: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "從{area:2408}飛往{area:1638}，在{area:1639}找{npc:3033}訓練，再從那裡飛往{zone:1454}。",

	-- Step 40: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飛行管理員",

	-- Step 41: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "回到{area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飛行管理員",

	-- Step 42: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "{npc:4485}站在{object:172958}。",

	-- Step 43: Nogg
	-- {npc:3412} Nogg · {object:172958} Valley of Honor · {npc:4485} Belgrom Rockmaul · {quest:2841} Rig Wars · {area:133} Gnomeregan
	["{npc:3412}'s workshop is in the {object:172958} beside {npc:4485}: hand in {quest:2841} if you ran {area:133}."] = "{npc:3412}的工坊在{npc:4485}旁的{object:172958}裡：如果你跑過{area:133}，就在這裡交{quest:2841}。",

	-- Step 44: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "{zone:1454}的訓練師",
	-- {zone:1458} Undercity
	["Train while you are in the city; everyone else trains in the {zone:1458}, next."] = "趁在城裡時訓練；其他人下一站在{zone:1458}訓練。",
	-- {zone:1458} Undercity
	["The next guide takes the {zone:1458} zeppelin from the tower outside the main gate."] = "下一份指南會在正門外的塔樓乘上前往{zone:1458}的飛艇。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Darkfang spiders"] = "暗牙蜘蛛",
	-- ["For {npc:2519} at {object:3202}, in the next guide"] = "交給{object:3202}的{npc:2519}，在下一份指南",
	-- ["Head east back to the {area:497}."] = "向東回到{area:497}。",
	-- ["Hearth to {area:392}"] = "用爐石回{area:392}",
	-- ["Kodo bones and ghosts"] = "科多獸骨與幽靈",
	-- ["Maraudine totems"] = "瑪洛迪圖騰",
	-- ["North to the goblin camp on the west side of the {area:596}."] = "向北前往{area:596}西側的哥布林營地。",
	-- ["Pick up the kodo bones scattered across the graveyard, and use the {item:15848} among the bones: the ghosts it draws drop the ghost-o-plasm."] = "撿起散落在墳場各處的科多獸骨，並在骨頭之間使用{item:15848}：它吸引來的幽靈會掉落幽靈電漿。",
	-- ["Ride back west to Brackenwall with the head."] = "帶著頭顱向西騎回蕨牆村。",
	-- ["Ride east to {area:602}. Use the Rod of Banishing by each demon portal to close six of them."] = "向東騎往{area:602}。在每個惡魔傳送門旁使用放逐之杖，關閉其中六個。",
	-- ["Ride north from the coven to {npc:5412} at {area:597}."] = "從集會所向北騎往{area:597}的{npc:5412}。",
	-- ["Ride north up the road to the hut by the road north of the graveyard."] = "沿著道路向北騎，前往墳場北邊路旁的小屋。",
	-- ["Ride north-east to the {area:607}. {npc:12277} is held in the Maraudine centaur camp; free her and escort her out east of the valley."] = "向東北騎往{area:607}。{npc:12277}被關在瑪洛迪半人馬的營地裡；釋放她，並護送她往東離開山谷。",
	-- ["Ride on south-west to Shadowprey."] = "繼續向西南騎往葬影村。",
	-- ["Ride south from {area:2405} into the {area:607}. The Maraudine Scouts, Wranglers, Maulers, Windchasers and Marauders (36-39) drop the {quest:93225}."] = "從{area:2405}向南騎進{area:607}。瑪洛迪斥候、瑪洛迪爭鬥者、瑪洛迪虐待者、瑪洛迪逐風者和瑪洛迪掠奪者（36-39級）會掉落{quest:93225}。",
	-- ["Ride west back across the marsh. The Darkfang Venomspitters on the ridges north of Brackenwall drop the venom sacs. Theramore Infiltrators (35-36) sneak through the same woods: they are stealthed, so look closely."] = "向西騎回沼澤另一頭。蕨牆村北邊山脊上的暗牙毒蜘蛛會掉落毒囊。塞拉摩間諜（35-36級）在同一片樹林中潛行：他們處於潛行狀態，要仔細看。",
	-- ["Ride west to {npc:11863}'s tower at {area:2405} on the north-west coast."] = "向西騎往西北海岸{area:2405}的{npc:11863}塔樓。",
	-- ["Slitherblade coast"] = "滑刃海岸",
	-- ["South-east from the manor to {area:513}: the {object:20925} lies on the sea floor off the docks on the isle's east side. Swim in and out and keep off the piers and the town: Theramore's guards are level 53-57, and a death here is a long run back from the spirit healer."] = "從莊園往東南前往{area:513}：{object:20925}在島嶼東側碼頭外的海底。游進去再游出來，遠離碼頭和城鎮：希拉摩的守衛是53-57級，在這裡死掉的話，從靈魂醫者那裡跑回來要很久。",
	-- ["The Burning Blade hold the fortress north-west of {area:2407}. Use the {item:14523} on the {npc:11876} in the fortress to get the {item:13542}."] = "燃刃氏族佔據{area:2407}西北方的堡壘。對堡壘中的{npc:11876}使用{item:14523}，取得{item:13542}。",
	-- ["The Darkmist spiders swarm the cavern mouth north-west of Brackenwall; every kind drops eyes."] = "暗霧蜘蛛聚集在蕨牆村西北方的洞穴入口；每一種都會掉落眼球。",
	-- ["The Slitherblade naga hold the coast north of {area:2405}, up to {area:598}. {npc:12369} guards the {quest:6027} at the far northern tip."] = "滑刃納迦佔據{area:2405}北邊直到{area:598}的海岸。{npc:12369}守護著最北端的{quest:6027}。",
	-- ["The next guide takes you back to {zone:1434}."] = "下一份指南會帶你回到{zone:1434}。",
	-- ["West to Shadowprey."] = "向西前往葬影村。",
	-- ["{npc:11626}'s caravan stops on the road at the edge of {area:602}. Escort it east past the coven; demons attack it twice."] = "{npc:11626}的商隊停在{area:602}邊緣的道路上。護送商隊向東經過集會所；惡魔會攻擊兩次。",
	-- ["{npc:3391}: for {npc:4631} in {area:35}, on the first {area:35} stop of 40-50"] = "{npc:3391}：交給{area:35}的{npc:4631}，在40-50級第一次前往{area:35}時",
	-- ["{npc:4983} waits in the {area:2302} east of the village. Follow him to Reethe and keep him alive through the fight that breaks out."] = "{npc:4983}在村莊東邊的{area:2302}等候。跟著他去找雷瑟，在爆發的戰鬥中保住他的性命。",
	-- ["{npc:5395} and {npc:5412} stand in the post just west of {npc:11596}'s camp."] = "{npc:5395}和{npc:5412}站在{npc:11596}營地西邊的哨站裡。",
	-- ["{npc:5395}: his {quest:1366}, from the same Maraudine"] = "{npc:5395}：他的{quest:1366}，來自同一批瑪勞登",
	-- ["{npc:6791}: the last guide binds here, so this usually ticks at once"] = "{npc:6791}：上一份指南在這裡綁定爐石，所以這一步通常會立即完成",
}
