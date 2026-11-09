-- Chinese (traditional) (zhTW): the guide forever/horde/07-ashenvale (forever/horde/07-ashenvale.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Zoram'gar Outpost
	-- {area:2897} Zoram'gar Outpost
	["Fly to {area:2897}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "",

	-- Step 2: Zoram'gar Outpost
	-- {npc:12736} Je'neu Sancrea
	["{npc:12736} stands in the outpost."] = "",

	-- Step 3: Blackfathom Deeps ruins
	-- {area:2797} Blackfathom Deeps
	["{area:2797} ruins"] = "{area:2797}遺跡",
	["The way to the Sapphires is through the sunken ruins at the north end of the strand: go down the stairs into the pit."] = "前往藍寶石的路要穿過海岸北端沉沒的遺跡：從階梯走下坑洞。",

	-- Step 4: Sapphires of Aku'Mai
	["Sapphires of Aku'Mai"] = "阿庫麥爾藍寶石",
	-- {area:2797} Blackfathom Deeps
	["The Sapphires are blue crystals on the walls of the tunnels leading to the {area:2797} portal, underground and outside the instance: swim down from the pit, under the wall, into the cave. The satyrs and naga in the tunnels are elite: grouping up is advised. The crystals respawn quickly, so there is no need to go deep."] = "藍寶石是通往{area:2797}傳送門的隧道牆上的藍色水晶，位於地下、副本之外：從坑洞往下游，穿過牆下進入洞穴。隧道裡的薩特和納迦是精英：建議組隊。水晶重生得很快，不必深入。",

	-- Step 5: Zoram'gar Outpost
	["Back to Zoram'gar from the ruins before heading east for good."] = "",
	-- {npc:12736} Je'neu Sancrea · {area:2797} Blackfathom Deeps
	["{npc:12736} offers a {area:2797} quest next; leave it unless you have a group."] = "{npc:12736}接著會提供一個{area:2797}任務；除非你有小隊，否則先不要做。",

	-- Step 6: Ruins of Stardust fountain
	-- {area:418} Ruins of Stardust
	["{area:418} fountain"] = "{area:418}的噴泉",
	-- {area:418} Ruins of Stardust · {npc:12678} Ursangous · {item:7767} Empty Blue Waterskin
	["The fountain stands in the middle of the {area:418}, where {npc:12678} roams: use the {item:7767} there."] = "",

	-- Step 7: Ursangous
	-- {area:415} Astranaar · {npc:12678} Ursangous · {area:418} Ruins of Stardust · {area:421} Mystral Lake
	["Follow the main road east past {area:415} (Alliance: keep to the road). {npc:12678}, a big grizzly, roams the {area:418} south of the road, west of {area:421}. His paw starts the next hunt quest."] = "沿著主要道路向東經過{area:415}（聯盟據點：沿著道路走）。{npc:12678}是一頭大灰熊，在道路南邊、{area:421}西邊的{area:418}遊蕩。牠的爪子會開始下一個狩獵任務。",

	-- Step 8: Alonso
	-- {npc:210995} Alonso · {area:421} Mystral Lake
	["{npc:210995}, a Forever addition, stands on the west shore of {area:421} with three quick Dragonslayer quests."] = "{npc:210995}是 Forever 新增的角色，站在{area:421}西岸，有三個快速的屠龍者任務。",
	-- {npc:210995} Alonso · {area:1276} Talondeep Path
	["{npc:210995} walks around the {area:1276}: the map marks where to look"] = "",

	-- Step 9: King of the Foulweald
	-- {area:421} Mystral Lake · {item:16972} Karang's Banner · {object:178206} Foulweald Totem Mound (no name in this language: may be words) · {npc:12918} Chief Murgut
	["The Foulweald furbolgs hold the woods east of {area:421}, south of the road. Place {item:16972} on the {object:178206} and guard it: the furbolgs come to tear it down. {npc:12918} comes last; his totem drops in the basket."] = "汙林熊怪佔據{area:421}東邊、道路南邊的樹林。把{item:16972}放在{object:178206}上並守住它：熊怪會來把它拆掉。{npc:12918}最後出現；他的圖騰會掉在籃子裡。",

	-- Step 10: Torek's Assault
	-- {npc:12858} Torek · {area:2360} Silverwing Outpost · {npc:12860} Duriel Moonfire
	["Keep east on the road. {npc:12858} waits south-west of the Warsong lumber camp. He and his grunts storm the {area:2360}: let them take aggro and stay with {npc:12858} until {npc:12860} is dead."] = "沿著道路繼續向東。{npc:12858}在戰歌伐木營地西南方等候。他和他的步兵會猛攻{area:2360}：讓他們吸引仇恨，跟著{npc:12858}直到{npc:12860}死亡。",

	-- Step 11: Sharptalon
	-- {npc:12676} Sharptalon
	["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp, on the way north to Splintertree. Her claw starts the next hunt quest."] = "",

	-- Step 14: Splintertree Post
	-- {npc:12196} Innkeeper Kaylisk
	["{npc:12196}, beside her"] = "",
	-- {npc:12718} Gurda Ragescar
	["{npc:12718}: only if you carry the manual pages"] = "{npc:12718}：只有在你帶著手冊書頁時",

	-- Step 15: Felmusk satyrs
	["Felmusk satyrs"] = "魔草薩特",
	["North-west of Splintertree, the Felmusk satyrs camp in the woods. Every satyr can drop horns."] = "在碎木崗哨西北方，魔草薩特在樹林中紮營。每個薩特都可能掉落角。",

	-- Step 16: Shadumbra
	-- {npc:12677} Shadumbra · {area:426} Raynewood Retreat
	["{npc:12677}, a shadow panther, stalks the woods around {area:426}, west of the Felmusk camp. Her head starts the next hunt quest."] = "{npc:12677}是一隻暗影豹，在魔草營地西邊的{area:426}周圍的樹林中潛行。她的頭顱會開始下一個狩獵任務。",

	-- Step 17: Tideress
	-- {area:421} Mystral Lake · {npc:12759} Tideress · {item:16408} Befouled Water Globe · {quest:25} Stonetalon Standstill · {npc:12737} Mastok Wrilehiss
	["Back south-west to {area:421}. {npc:12759}, a corrupted water elemental, drifts around the lake's island and under the water. She drops the {item:16408} only once you have {quest:25} from {npc:12737}; it starts a quest for Splintertree."] = "",

	-- Step 18: Mystral Lake
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["Befouled Water Elementals drift around the lake's shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "",
	["Underwater"] = "",
	["Gazebo"] = "涼亭",

	-- Step 24: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {area:2897} Zoram'gar Outpost
	["{area:2897} flight master"] = "",

	-- Step 25: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:246344} Alodan the Hopeful
	["Paladins know {area:1638}'s flight path from {npc:246344}'s training."] = "",

	-- Step 26: Skywatcher Plateau
	-- {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore
	["The Earthen Ring camp and its three quests stand up on {area:17045}, north of {zone:1456}. Fly to {zone:1456} if you know its flight path and take a lift down, else fly to {area:378} and walk north through {zone:1412}; the arrow then leads round to the plateau's north end and up onto it."] = "",
	["North of Thunder Bluff"] = "",

	-- Step 28: The Earthen Ring
	["The Earthen Ring"] = "陶土議會",
	-- {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem · {npc:259118} Muln Earthfury · {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}. From {zone:1456}, take a lift down; coming on foot from {area:378}, keep north past the bluffs."] = "",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96261} comes once this is handed in"] = "",

	-- Step 29: Gloomrise: kill these as you meet them
	-- {area:17044} Gloomrise
	["{area:17044}: kill these as you meet them"] = "",
	-- {area:17044} Gloomrise · {npc:264074} Mazu'kon · {item:273015} Toxin Extractor · {item:273181} Crystalline Silk · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["North of the camp, spiders overrun the burial ground at {area:17044}. Use {npc:264074}'s {item:273015} on the Gnawed Corpses; the Spinners drop the {item:273181}. {npc:264082} sits at the north end: her {item:273658} starts {quest:96294}."] = "在營地北邊，蜘蛛佔據了{area:17044}的墓地。對{npc:264096}使用{npc:264074}的{item:273015}；紡絲蜘蛛會掉落{item:273181}。{npc:264082}在北端：她的{item:273658}會開始{quest:96294}。",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}，來自{npc:264081}",
	-- plural, as words: Gloomrise Toxin Samples = {item:273001} Gloomrise Toxin Sample · Gnawed Corpses = {npc:264096} Gnawed Corpse
	["Gloomrise Toxin Samples, from the Gnawed Corpses"] = "鬱湧毒素樣本，來自{npc:264096}",

	-- Step 30: The Earthen Ring
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "",

	-- Step 32: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx · {area:17044} Gloomrise · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	["{npc:264082} sits at the north end of {area:17044}; her {item:273658} starts {quest:96294}. {npc:264082} is elite: grouping up is advised."] = "",
	-- {item:273658} Bloody Parchment · {npc:264082} Broodmother Valraxx
	["{item:273658}, from {npc:264082}: it does not drop for everyone"] = "",

	-- Step 33: The Earthen Ring
	-- {zone:1456} Thunder Bluff · {area:378} Camp Taurajo
	["Back south to the camp, then up into {zone:1456} for the flight to {area:378}."] = "向南回到營地，然後上到{zone:1456}搭乘飛往{area:378}的飛行路線。",

	-- Step 34: Class trainer
	["Class trainer"] = "",

	-- Step 35: Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["{zone:1456}'s central rise"] = "",

	-- Step 36: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:2995} Tal
	["Into {area:1638} by a lift: {npc:2995}, the wind rider master, stands on the central rise. Take his flight path if you don't know it yet."] = "",
	-- {npc:3057} Cairne Bloodhoof · {area:1638} Thunder Bluff · {quest:93739} Exploring the Horde
	["Speak with {npc:3057}, in {area:1638}: {quest:93739}"] = "與{area:1638}的{npc:3057}交談：{quest:93739}",
	-- {npc:3057} Cairne Bloodhoof
	["Talk to {npc:3057}"] = "",

	-- Step 37: Ansekhwa
	-- {spell:199} Two-Handed Maces · {npc:11869} Ansekhwa
	["While you're here: learn {spell:199} from {npc:11869} (10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 38: Fly to Camp Taurajo
	-- {area:378} Camp Taurajo
	["Fly to {area:378}"] = "飛往{area:378}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 39: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:485} Great Lift
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole south of {area:378}, on the road to the {area:485}."] = "",
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["for {npc:5901}, south of {area:392}: next guide"] = "給{area:392}南邊的{npc:5901}：下一份指南",

	-- Step 40: Tear of the Moons
	-- {area:485} Great Lift · {area:359} Bael Modan · {npc:3421} Feegly the Exiled · {object:3646} General Twinbraid's Strongbox · {npc:3414} General Twinbraid
	["On the road south to the {area:485}, turn east into the {area:359} dig. {npc:3421} hides at its south edge. {object:3646} stands on the bottom floor of the dwarves' fortress, beside {npc:3414} (30) and his Officers (26): pull them to you one at a time."] = "",
	-- {object:3646} General Twinbraid's Strongbox
	["{object:3646}; below ground"] = "",

	-- Step 41: Great Lift
	-- {area:485} Great Lift · {zone:1441} Thousand Needles
	["{area:485}, down into {zone:1441}"] = "",

	-- Step 42: Freewind Post's lift
	-- {area:484} Freewind Post
	["{area:484}'s lift"] = "",

	-- Step 43: Freewind Post
	-- {area:484} Freewind Post
	["Ride the lift down, then follow the road east through the canyons to {area:484}, a Tauren village on top of the mesas. Its lift is on the north side."] = "搭升降梯下去，然後沿著道路向東穿過峽谷前往{area:484}，這是一座位於台地頂端的牛頭人村莊。它的升降梯在北側。",
	-- {npc:10377} Elu
	["{npc:10377}, by the wind rider master"] = "{npc:10377}，在雙足飛龍管理員旁",
	-- {npc:10537} Cliffwatcher Longhorn
	["The Wanted poster beside {npc:10537}"] = "{npc:10537}旁的通緝告示",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}; inside the inn"] = "",
	-- {npc:4877} Jandia
	["{npc:4877}: her stolen supplies lie in the same harpy den"] = "",
	-- {npc:11116} Innkeeper Abeqwa · {npc:4877} Jandia
	["{npc:11116}, beside {npc:4877}"] = "",

	-- Step 44: Alien Egg
	["Take the lift down. The egg lies in a nest on the canyon floor in one of three spots: south-east of the mesas (52.3,55.2), east (56.4,50.4) or south-west (37.6,56.1)."] = "搭升降梯下去。蛋在峽谷底部的巢裡，位於三處之一：台地東南方（52.3,55.2）、東方（56.4,50.4）或西南方（37.6,56.1）。",

	-- Step 45: Galak centaurs
	["Galak centaurs"] = "加拉克半人馬",
	-- {npc:10617} Galak Messenger · {area:2237} Whitereach Post
	["The Galak camps fill the canyon north of Freewind; Scouts, Wranglers and Windchasers share every camp. A lone {npc:10617} walks between the camps: kill him when you meet him, his note starts a quest for {area:2237}."] = "加拉克營地遍布亂風崗北邊的峽谷；每個營地都有加拉克斥候、加拉克爭鬥者和加拉克逐風者。有一個落單的{npc:10617}在營地之間走動：遇到就殺了他，他的信會開始一個交給{area:2237}的任務。",

	-- Step 46: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {quest:1149} Test of Faith
	["{npc:2986} stands on a mesa top east of the Galak camps. For the {quest:1149}, walk off the end of the planks beside him: you land safely."] = "{npc:2986}站在加拉克營地東邊的台地頂上。為了{quest:1149}，從他旁邊的木板盡頭走下去：你會安全落地。",
	-- {npc:2986} Dorn Plainstalker
	["{npc:2986}, below ground"] = "",

	-- Step 48: Darkcloud Pinnacle
	-- {area:2097} Darkcloud Pinnacle
	-- plural, as words: Document Chests = {object:176344} Document Chest
	["West of Freewind, the Grimtotem camps below {area:2097}. The Secret Notes are in Document Chests at the south-east, south-west and north-west camps."] = "在亂風崗西邊，恐怖圖騰在{area:2097}下方紮營。密信放在東南、西南和西北營地的{object:176344}裡。",
	-- {object:176344} Document Chest
	["{object:176344}, north-west camp"] = "{object:176344}，西北營地",
	-- {object:176344} Document Chest
	["{object:176344}, south-west camp"] = "{object:176344}，西南營地",
	-- {object:176344} Document Chest
	["{object:176344}, south-east camp"] = "{object:176344}，東南營地",

	-- Step 49: Level 28.9
	["Level 28.9"] = "",
	-- {npc:10646} Lakota Windsong · {area:2797} Blackfathom Deeps · {area:1717} Razorfen Kraul
	["Short of 28.9? The Grimtotem around these camps (25-28) are the right level: kill a few more before the climb to {npc:10646}. Past it, this step skips itself. Or, with a group, run the {area:2797} dungeon or the {area:1717} dungeon instead."] = "",
	-- {area:2097} Darkcloud Pinnacle
	["Grimtotem camps below {area:2097}"] = "",
	-- {npc:10759} Grimtotem Stomper
	["grind on {npc:10759}"] = "",

	-- Step 50: Lakota Windsong
	-- {area:2097} Darkcloud Pinnacle · {npc:10646} Lakota Windsong · {npc:10896} Arnak Grimtotem
	["Climb the path to the top of {area:2097}. {npc:10646} is held captive beside {npc:10896} (29): clear the guards and {npc:10896} first, then free her and protect her on the walk down; Grimtotem ambushers come at you on the way."] = "沿著小路爬到{area:2097}頂端。{npc:10646}被囚禁在{npc:10896}（29級）旁邊：先清掉守衛和{npc:10896}，再救出她，並在下山途中保護她；路上會有恐怖圖騰伏擊者來攻擊你。",

	-- Step 51: Highperch
	-- {area:482} Highperch · {npc:10427} Pao'ka Swiftmountain · {area:2237} Whitereach Post
	["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}.\nCareful: Wyverns at level 28-29 fly overhead and can be pulled without warning. A group of three wyverns can ambush you once you pass the first pillar at the bottom."] = "",

	-- Step 52: Whitereach Post
	-- {npc:10428} Motega Firemane · {zone:1456} Thunder Bluff
	["{npc:10428}'s next quest, Sacred Fire, ends in {zone:1456}, off this route. Skip it."] = "{npc:10428}的下一個任務「聖火」在{zone:1456}完成，不在這條路線上。跳過。",

	-- Step 54: Hypercapacitor Gizmo
	-- {npc:10992} Enraged Panther
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:10992} is a level 30 elite: most classes solo it at level 32, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 55: Whitereach Post
	-- {npc:10720} Galak Assassin · {npc:10638} Kanati Greycloud
	["Kill the {npc:10720} that comes for {npc:10638}"] = "擊殺前來對付{npc:10638}的{npc:10720}",

	-- Step 58: Level 29.49
	["Level 29.49"] = "",
	-- {quest:5151} Hypercapacitor Gizmo · {area:487} Roguefeather Den · {area:2797} Blackfathom Deeps · {area:796} Scarlet Monastery
	["If you skipped {quest:5151} and are still short of 29.49, kill harpies here first: {area:487} is your next stop anyway. Past it, this step skips itself. Or, with a group, run the {area:2797} dungeon or the {area:796} dungeon (Graveyard) instead."] = "",
	-- {npc:4101} Screeching Roguefeather
	["grind on {npc:4101}"] = "",

	-- Step 59: The Screeching Canyon: kill these as you meet them
	-- {area:483} The Screeching Canyon
	["{area:483}: kill these as you meet them"] = "",
	-- {area:487} Roguefeather Den · {npc:4490} Grenka Bloodscreech · {npc:4877} Jandia · {quest:98069} Stolen Freewind Supplies
	["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s; her {quest:98069} lie on the ground along the foot of the cliff and in the cave up on top."] = "",
	-- {quest:98069} Stolen Freewind Supplies
	["{quest:98069}, on the ground around the den"] = "",

	-- Step 60: Freewind Post
	-- {area:484} Freewind Post · {area:487} Roguefeather Den · {npc:2986} Dorn Plainstalker
	["Back east to {area:484}: it lies on the way from {area:487} to {npc:2986}'s mesa."] = "",
	-- {npc:10645} Thalia Amberhide
	["{npc:10645}, inside"] = "",
	-- {npc:4877} Jandia
	["{npc:4877}, inside"] = "",

	-- Step 61: Test of Endurance
	-- {npc:2986} Dorn Plainstalker
	["{npc:2986}'s mesa is north-east of Freewind."] = "",
	-- {npc:2986} Dorn Plainstalker · {quest:1151} Test of Strength · {quest:1150} Test of Endurance
	["{npc:2986} offers {quest:1151} once {quest:1150} is in"] = "",

	-- Step 62: Rok'Alim the Pounder
	-- {npc:4499} Rok'Alim the Pounder · {area:482} Highperch · {area:2237} Whitereach Post
	["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}, back west past {area:2237}. {npc:4499} is elite: grouping up is advised."] = "",

	-- Step 63: Freewind Post
	-- {area:484} Freewind Post · {area:2240} Mirage Raceway · {area:439} Shimmering Flats
	["Back to {area:484}. The {area:2240}'s quests come with the next visit to the {area:439}, at 33."] = "",
	-- {zone:1454} Orgrimmar
	["The next guide flies on from here to the Crossroads and {zone:1454}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south-west to {area:421}. Befouled Water Elementals drift around its shores; the gazebo stands on the island, overlooking the Alliance outpost."] = "向西南回到{area:421}。污濁的水元素在湖岸周圍漂浮；涼亭在島上，俯瞰著聯盟前哨。",
	-- ["Back west to Zoram'gar before heading east for good."] = "在永久往東之前，先向西回到左拉姆加。",
	-- ["East of Zoram'gar, the Thistlefur furbolgs fill the village and the hills around their hold."] = "在左拉姆加東邊，薊皮熊怪佔據村莊和他們巢穴周圍的山丘。",
	-- ["Fly from {area:392} to {area:2897} on the {zone:1440} coast."] = "從{area:392}飛往{zone:1440}海岸的{area:2897}。",
	-- ["Fly from {zone:1456} to {area:378} and take the road south to the {area:1718} at the bottom of the {zone:1413}."] = "從{zone:1456}飛往{area:378}，沿著道路向南前往{zone:1413}底端的{area:1718}。",
	-- ["Fly from {zone:1456} to {area:378}. {npc:5899}'s hut stands on the ridge above the quilboar watering hole south of the camp, on the road to the {area:1718}."] = "從{zone:1456}飛往{area:378}。{npc:5899}的小屋在營地南邊野豬人飲水處上方的山脊上，位於前往{area:1718}的路上。",
	-- ["Fly to {area:1638} if you know the flight path. If not, fly to {area:378}, ride west into {zone:1412} past {area:222} to {area:1638} and take its flight path from {npc:2995} on the central rise."] = "如果你知道飛行路線，就飛往{area:1638}。如果不知道，飛往{area:378}，向西騎進{zone:1412}經過{area:222}前往{area:1638}，並在中央高地向{npc:2995}取得飛行路線。",
	-- ["Follow the canyon east out of the mesas onto the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "沿著峽谷向東離開台地，進入鹽灘。{area:2240}的哥布林和地精是中立的，會給雙方陣營任務。",
	-- ["Follow the canyon west to {area:2237}."] = "沿著峽谷向西前往{area:2237}。",
	-- ["Gazebo"] = "涼亭",
	-- ["Grimtotem camps"] = "恐怖圖騰營地",
	-- ["His crate is for Stranglethorn, later on the route"] = "他的箱子要送到荊棘谷，在路線稍後",
	-- ["Inside the hold, Troll Chests lie along the tunnels. {npc:12818} is held deep inside: free him and protect him all the way out, then he runs home to {area:428}."] = "巢穴裡的隧道沿途散落著食人妖的箱子。{npc:12818}被關在深處：救出他並一路保護他出去，之後他會跑回{area:428}。",
	-- ["Naga brazier"] = "納迦火盆",
	-- ["North up the road to {area:431} and {area:428} beside it."] = "沿著道路向北前往{area:431}和旁邊的{area:428}。",
	-- ["Shadumbra"] = "薩杜布拉",
	-- ["Sharptalon"] = "沙普塔隆",
	-- ["South of Darkcloud, the harpies of {area:487}. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her. The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s."] = "暗雲峰南邊是{area:487}的鷹身人。{npc:4490}（31級）在牠們之間走動：先清掉她周圍的鷹身人再拉她。那裡的尖嘯的鷹身人、尖嘯的遊蕩者和尖嘯的喚風者是{npc:4877}的任務目標。",
	-- ["Take a lift down from {zone:1456}. The Earthen Ring camp stands north of the bluffs: {npc:264074}, {npc:264072} and {npc:259118}."] = "從{zone:1456}搭升降梯下去。陶土議會營地位於峭壁北邊：{npc:264074}、{npc:264072}和{npc:259118}。",
	-- ["The fountain stands in the middle of the {area:418}: use the {item:7767} there."] = "噴泉位於{area:418}中央：在那裡使用{item:7767}。",
	-- ["The next guide flies on from here to {zone:1454}."] = "下一份指南會從這裡飛往{zone:1454}。",
	-- ["The salt flats"] = "鹽灘",
	-- ["The {area:1718}"] = "{area:1718}",
	-- ["Thistlefur Hold"] = "薊皮熊怪的巢穴",
	-- ["Tideress"] = "泰德雷斯",
	-- ["Ursangous"] = "烏薩苟斯",
	-- ["West of Whitereach the wyverns nest on the {area:482} cliffs; the eggs lie in the nests. {npc:10427} waits on the east side of the nesting grounds: free him and keep him alive on the walk back to {area:2237}."] = "在白沙崗哨西邊，雙足飛龍在{area:482}的懸崖上築巢；蛋就在巢裡。{npc:10427}在築巢區東側等候：救出他，並在走回{area:2237}的路上保護他存活。",
	-- ["{item:273658}, from {npc:264082}"] = "{item:273658}，來自{npc:264082}",
	-- ["{npc:10079}, at the top of the lift"] = "{npc:10079}，在升降梯頂端",
	-- ["{npc:12676}, a big nightsaber, prowls the woods south-east of the Warsong lumber camp. Her claw starts the next hunt quest."] = "{npc:12676}是一隻大型夜刃豹，在戰歌伐木營地東南方的樹林中徘徊。她的爪子會開始下一個狩獵任務。",
	-- ["{npc:12717} walks north up the strand to a naga brazier. Put the brazier out, then guard him through the naga waves until Vorsha is dead."] = "{npc:12717}會沿著海岸向北走到一座納迦火盆。熄滅火盆，然後在一波波納迦來襲時保護他，直到鞭笞者沃爾沙死亡。",
	-- ["{npc:12717}: starts his escort at once"] = "{npc:12717}：會立刻開始他的護送任務",
	-- ["{npc:12759}, a corrupted water elemental, drifts in {area:421}. Her {item:16408} starts a quest for Splintertree."] = "{npc:12759}是一隻被腐化的水元素，在{area:421}中漂浮。她的{item:16408}會開始一個交給碎木崗哨的任務。",
	-- ["{npc:12867} stands at the lumber camp. The night elf Outrunners stalk the woods south-east of it; they stealth, so watch for them."] = "{npc:12867}站在伐木營地。夜精靈的梣谷先驅者在營地東南方的樹林中潛行；他們會潛行，要留意。",
	-- ["{npc:4454}: his letter goes to Martek in the {zone:1418}, around level 38"] = "{npc:4454}：他的信要交給{zone:1418}的馬特克，約38級時",
	-- ["{npc:4499}, a hard-hitting rock elemental, walks the cliffs of {area:482}. {npc:4499} is elite: grouping up is advised."] = "{npc:4499}是一隻攻擊力很強的石元素，在{area:482}的懸崖上走動。{npc:4499}是精英：建議組隊。",
	-- ["{npc:4877}, the trade supplies vendor: the Screeching harpies of {area:487}"] = "{npc:4877}，商業用品商人：{area:487}的尖嘯的鷹身人",
	-- ["{object:19868} lies all over the flats north of the raceway. Scorpid Reavers and Sparkleshell Tortoises roam the north half, Salt Flats Scavengers circle overhead, and Saltstone Basilisks graze west of the track. The Crystalhides roam the middle of the flats and the Gazers (34-35, five levels above you: one at a time) the far south."] = "{object:19868}散落在賽道北邊的鹽灘各處。恐蠍劫掠者和鹽殼龜在北半部遊蕩，鹽湖食腐鷲在上空盤旋，鹽石蜥蜴在賽道西邊覓食。鹽石水晶蜥蜴在鹽灘中央遊蕩，鹽石凝視者（34-35級，比你高五級：一次拉一隻）在最南邊。",
}
