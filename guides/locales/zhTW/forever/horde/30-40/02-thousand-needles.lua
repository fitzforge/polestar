-- Chinese (traditional) (zhTW): the guide forever/horde/30-40/02-thousand-needles (forever/horde/30-40/02-thousand-needles.guide).
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

	-- Step 2: Alliance Relations
	-- {zone:1454} Orgrimmar · {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits
	["The zeppelin lands at the tower outside {zone:1454}'s main gate. {npc:5639} walks the Drag: if he isn't at the arrow, look along its streets to the south-west. {npc:5640} stands in the {object:172961} on the west side of the city."] = "飛艇停靠在{zone:1454}正門外的塔上。{npc:5639}在暗巷區四處走動：如果他不在箭頭處，就沿著西南方的街道尋找。{npc:5640}站在城市西側的{object:172961}。",
	-- {npc:5639} Craven Drok
	["{npc:5639}: offered from level 30"] = "{npc:5639}：30級起可接",
	-- {npc:5641} Takata Steelblade · {zone:1443} Desolace
	["for {npc:5641} in {zone:1443}, later in this guide"] = "交給{zone:1443}的{npc:5641}，本指南稍後",

	-- Step 3: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "{zone:1454}的訓練師",
	["Train while you are in the city."] = "趁在城裡時訓練。",

	-- Step 4: Searn Firewarder
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892}站在{object:172957}。",
	-- {npc:5892} Searn Firewarder · {npc:5905} Prate Cloudseer · {area:484} Freewind Post
	["{npc:5892}: for {npc:5905} by {area:484}, later in this guide"] = "{npc:5892}：為了{area:484}旁的{npc:5905}，本攻略後面會用到",

	-- Step 5: Fly to the Crossroads
	["Fly to the Crossroads"] = "飛往十字路口",
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows
	["{npc:3428}'s {quest:1145} needed level 29 on the last guide's Crossroads stop: take it now, on a short flight to the Crossroads and back."] = "{npc:3428}的{quest:1145}在上一份指南到十字路口時需要29級：現在接取，短程飛去十字路口再飛回來。",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 6: Korran
	-- {npc:3428} Korran
	["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428}站在十字路口飛行管理員旁邊。",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "{npc:3428}：交給{zone:1454}的{npc:4485}",

	-- Step 7: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "回到{area:1637}",
	["Crossroads flight master"] = "十字路口飛行管理員",

	-- Step 8: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor
	["{npc:4485} stands in the {object:172958}."] = "{npc:4485}站在{object:172958}。",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, later in this guide"] = "給本指南稍後在{area:439}的{npc:4483}",

	-- Step 10: Thunder Bluff
	-- {zone:1454} Orgrimmar · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {area:484} from there."] = "從{zone:1454}飛往{area:1638}，在{area:1639}找{npc:3033}訓練，再從那裡飛往{area:484}。",

	-- Step 11: Islen Waterseer
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {npc:5901} Islen Waterseer · {area:484} Freewind Post
	["Fly from {zone:1454} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to {area:484} from {area:392}."] = "從{zone:1454}飛往{area:392}。{npc:5901}在鎮子南邊不遠處的海岸紮營；再從{area:392}飛往{area:484}。",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}：{npc:3527}和你的{item:5177}",

	-- Step 12: Fly to Freewind Post
	-- {area:484} Freewind Post
	["Fly to {area:484}"] = "飛往{area:484}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飛行管理員",

	-- Step 13: Fly to Freewind Post
	-- {area:392} Ratchet
	["{area:392} flight master"] = "{area:392}飛行管理員",

	-- Step 15: Prate Cloudseer
	-- {npc:5905} Prate Cloudseer
	["{npc:5905} hides in a small cave in the canyon wall north-east of the post, on the way east."] = "{npc:5905}躲在哨站東北峽谷崖壁上的一個小山洞裡，就在往東去的路上。",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}：你的{item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905}也會開啟Elemental Aid（{area:1717}），這是通往風暴武器的33-40級任務鏈：forever/class/shaman/call-of-air-horde。",

	-- Step 16: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {area:484} Freewind Post
	["{npc:2986} waits on the mesa just north-east of {area:484}, across the rope bridges."] = "{npc:2986}在{area:484}東北方不遠的平頂山上等你，要走過吊橋。",
	-- {npc:2986} Dorn Plainstalker · {npc:4490} Grenka Bloodscreech
	["{npc:2986}: {npc:4490}, in the harpy den west of the post"] = "{npc:2986}：{npc:4490}，在崗哨西邊的鷹身人巢穴",

	-- Step 17: Jandia
	-- {npc:4877} Jandia · {area:484} Freewind Post
	["{npc:4877}, the trade supplies vendor, stands inside {area:484}'s inn."] = "商業供應商{npc:4877}站在{area:484}的旅店裡。",
	-- {npc:4877} Jandia · {area:487} Roguefeather Den
	["{npc:4877}: the Screeching harpies of {area:487}"] = "{npc:4877}：{area:487}的尖嘯鷹身人",
	-- {npc:4877} Jandia
	["{npc:4877}: her stolen supplies lie in the same harpy den"] = "",

	-- Step 18: The Screeching Canyon: kill these as you meet them
	-- {area:483} The Screeching Canyon
	["{area:483}: kill these as you meet them"] = "",
	-- {area:2097} Darkcloud Pinnacle · {area:487} Roguefeather Den · {npc:4877} Jandia · {quest:98069} Stolen Freewind Supplies · {npc:4490} Grenka Bloodscreech · {npc:2986} Dorn Plainstalker
	["West of Freewind Post, below {area:2097}, the harpies of {area:487} (28-30). The Screeching Harpies, Roguefeathers and Windcallers there are {npc:4877}'s; her {quest:98069} lie on the ground along the foot of the cliff and in the cave up on top. {npc:4490} (31) walks among them: thin out the harpies around her before you pull her, for {npc:2986}'s claw."] = "亂風崗西邊、{area:2097}下方是{area:487}的鷹身人（28-30）。那裡的尖嘯鷹身人、亂羽鷹身人和喚風者都是{npc:4877}的目標；她的{quest:98069}散落在懸崖腳下的地上和頂上的洞穴裡。{npc:4490}（31）在牠們之間走動：先清掉她周圍的鷹身人再拉她，為了{npc:2986}要的爪子。",
	-- {quest:98069} Stolen Freewind Supplies
	["{quest:98069}, on the ground around the den"] = "",
	-- {item:5843} Grenka's Claw · {npc:4490} Grenka Bloodscreech
	["{item:5843}, from {npc:4490}"] = "{item:5843}，來自{npc:4490}",

	-- Step 19: Jandia
	-- {area:484} Freewind Post
	["Back east to {area:484}."] = "往東回到{area:484}。",
	-- {npc:4877} Jandia
	["{npc:4877}, inside the inn"] = "{npc:4877}，在旅店裡",

	-- Step 20: Dorn Plainstalker
	-- {npc:2986} Dorn Plainstalker · {npc:4499} Rok'Alim the Pounder
	["Back across to {npc:2986}'s mesa north-east of the post, then take the lift down to the canyon floor. {npc:2986}'s next test, {npc:4499}, is an elite: leave it."] = "走回營地東北方{npc:2986}所在的平頂山，然後搭升降梯下到峽谷底部。{npc:2986}的下一個考驗{npc:4499}是精英：不要接。",

	-- Step 21: Stormheart
	-- {npc:270094} Stormheart · {area:484} Freewind Post
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:270094} is a level 30 elite: most classes solo it at level 32, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:270094} walks the canyon road east of {area:484}'s lift, on the way to the salt flats: kill him for his heart."] = "這些是精英怪物：建議組隊，找人一起打。{npc:270094}是30級精英：大多數職業在32級時可以單刷，但你可能需要幫忙。如果你是獨自一人就跳過：路線會讓你把經驗值練回來。\n{npc:270094}在{area:484}升降梯東邊的峽谷道路上走動，就在前往鹽平原的路上：殺了他取得心臟。",
	-- {item:279186} Stormheart's Still-beating Heart · {npc:270094} Stormheart
	["{item:279186}, from {npc:270094}"] = "{item:279186}，來自{npc:270094}",

	-- Step 22: Moktar Krin
	-- {npc:4483} Moktar Krin
	["Take the lift down and follow the canyon east. {npc:4483} camps on the north-western edge of the salt flats."] = "乘升降機下去，沿峽谷向東。{npc:4483}在鹽灘西北緣紮營。",

	-- Step 23: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "{area:2240}的地精和侏儒是中立的，向兩個陣營提供任務。",
	-- {npc:4452} Kravel Koalbeard · {quest:5762} Hemet Nesingwary
	["{npc:4452}'s crate for {quest:5762} in Stranglethorn, later on the route"] = "{npc:4452}的箱子要交給荊棘谷的{quest:5762}，在路線後面",

	-- Step 24: Shimmering Flats: kill these as you meet them
	-- {area:439} Shimmering Flats
	["{area:439}: kill these as you meet them"] = "{area:439}：遇到就殺",
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["North-east of the raceway onto the flats. The Saltstone Basilisks (30-31) sun themselves north-west of it, and the Sparkleshell Tortoises (30-31) wander among them on the western flats; the Salt Flats Scavengers and Vultures circle the eastern flats. Every vulture drops a bone, about one tortoise in three a shell.\nCareful: Scavengers and Vultures use Execute when your health is low. The Sparkleshell Snappers (34-35) crowd round a half-buried ship in the north-east and are over you here: the Tortoises of the western flats drop the shells just as often, so stay with them. Take the venom from the Reavers (31-32) of the north half and leave the Scorpid Terrors (33-34) further south."] = "從賽道往東北走進鹽沼。鹽石蜥蜴（30-31）在賽道西北方曬太陽，鹽殼龜（30-31）在西側鹽沼的蜥蜴之間遊蕩；鹽湖食腐鷲和禿鷲在東側鹽沼盤旋。每隻禿鷲都會掉骨頭，大約三隻龜掉一個殼。\n注意：食腐鷲和禿鷲會在你血量低時使用斬殺。鹽殼鉗嘴龜（34-35）聚集在東北方一艘半埋的船周圍，等級比你高：西側鹽沼的鹽殼龜掉殼機率一樣，所以待在牠們那邊。從北半部的恐蠍搶奪者（31-32）身上取毒液，別碰更南邊的恐蠍（33-34）。",
	-- {item:5795} Hardened Tortoise Shell
	-- plural, as words: Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise
	["{item:5795}, from the Sparkleshell Tortoises of the western flats"] = "{item:5795}，來自西側鹽沼的鹽殼龜",
	-- {object:19868} Rocket Car Rubble
	["{object:19868}, all over the northern flats: pick it on the western flats, away from the Snappers"] = "{object:19868}，遍布北側鹽沼：在西側鹽沼撿，遠離鉗嘴龜",
	-- {quest:1104} Salt Flat Venom
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["{quest:1104}, from the Scorpid Reavers of the north half"] = "{quest:1104}，來自北半部的蠍子掠奪者",

	-- Step 25: Mirage Raceway
	["South-west back to the raceway."] = "向西南回到賽道。",
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: his parts order goes to {quest:1111} in {area:392}, later on the route"] = "{npc:4452}：他的零件訂單要送給{area:392}的{quest:1111}，在後面的路線上",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: his letter goes to Martek in the {zone:1418}, at 39"] = "{npc:4454}：他的信要交給{zone:1418}的馬特克，39級時",
	-- {npc:4630} Pozzik · {area:392} Ratchet
	["{npc:4630}: for Gazlowe in {area:392}, later on the route"] = "{npc:4630}：交給{area:392}的加茲魯維，路線後面會去",

	-- Step 26: Level 32
	["Level 32"] = "32級",
	-- {zone:1443} Desolace · {area:1717} Razorfen Kraul
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Scorpid Terrors = {npc:4139} Scorpid Terror
	["The flats' south and the silithid dig are 32-35, {zone:1443}'s quests 32-38. Still below 32 after the raceway's hand-ins? Back north on the flats, the Scorpid Reavers (31-32) roam among the basilisks and tortoises: kill them until level 32; leave the Sparkleshell Snappers (34-35) and the Scorpid Terrors (33-34) alone. Or, with a group, run the {area:1717} dungeon instead."] = "鹽沼南部和異種蠍挖掘場是32-35級，{zone:1443}的任務是32-38級。賽道繳交完還不到32級？回到鹽沼北邊，恐蠍搶奪者（31-32）在蜥蜴和龜之間遊蕩：殺到32級；別碰鹽殼鉗嘴龜（34-35）和恐蠍（33-34）。或者有小隊的話，改打{area:1717}地城。",
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver
	["Scorpid Reavers"] = "恐蠍搶奪者",
	-- {npc:4140} Scorpid Reaver
	["grind on {npc:4140}"] = "擊殺{npc:4140}練等",

	-- Step 27: The southern flats
	["The southern flats"] = "南部的鹽灘",
	-- plural, as words: Saltstone Crystalhides = {npc:4151} Saltstone Crystalhide
	["South of the raceway, the Saltstone Crystalhides (32-33) and Gazers (34-35) roam the far end of the flats.\nCareful: the level 35 Gazers can still be two over you: pull them one at a time from the camp's edge, never two together."] = "賽道南邊，鹽石水晶蜥蜴（32-33）和凝視者（34-35）在鹽沼盡頭遊蕩。\n注意：35級的凝視者可能仍比你高兩級：從營地邊緣一次拉一隻，絕不要同時拉兩隻。",

	-- Step 28: The Rustmaul Dig Site
	-- {item:5877} Cracked Silithid Carapace · {npc:4132} Silithid Ravager
	["West of them the silithid swarm the dig site. Searchers and Hive Drones walk among the mounds; the Invaders (34-35) stay inside the hive cave. The first silithid you kill drops a {item:5877}: open it.\nCareful: Hive Drones call for help when they fall to 20% health, and the {npc:4132} (37, rare) walks the dig: take the Searchers and Drones (32-34) outside first, then pull the Invaders (34-35) one at a time from the cave mouth."] = "牠們西邊，異種蠍佔據了挖掘場。搜尋者和巢穴雄蜂在土堆間走動；入侵者（34-35）待在巢穴洞穴裡。你殺的第一隻異種蠍會掉落{item:5877}：打開它。\n注意：巢穴雄蜂血量降到20%時會呼救，而{npc:4132}（37，稀有）在挖掘場走動：先在外面清掉搜尋者和雄蜂（32-34），再從洞口一次拉一隻入侵者（34-35）。",

	-- Step 29: Parts of the Swarm
	["Keep killing silithid at the dig site for the heart, the talons and the carapaces."] = "在挖掘場繼續擊殺異種蟲，收集心臟、利爪和甲殼。",

	-- Step 30: Moktar Krin
	-- {npc:4483} Moktar Krin
	["North from the dig to {npc:4483}'s camp on the western edge of the flats."] = "從挖掘場向北到鹽灘西緣{npc:4483}的營地。",

	-- Step 31: Mirage Raceway
	-- {area:976} Gadgetzan
	["East to the raceway, on the way south to {area:976}."] = "向東前往賽車場，順路再向南前往{area:976}。",

	-- Step 32: Gadgetzan
	-- {zone:1446} Tanaris · {area:976} Gadgetzan · {area:484} Freewind Post
	["South from the raceway over the {zone:1446} border to {area:976}, the walled goblin town: learn its flight path and fly back to {area:484} from there, which is quicker than the walk west across the flats, and the next guides fly straight to {area:976}."] = "從賽車場向南越過{zone:1446}邊界前往{area:976}，那座有城牆的哥布林城鎮：學會那裡的飛行路線，然後從那裡飛回{area:484}，比向西走過平原更快，而且接下來的指南會直接飛往{area:976}。",

	-- Step 34: Freewind Post
	-- {npc:10537} Cliffwatcher Longhorn
	["{npc:10537} stands in the middle of the post, on the way to the flight master."] = "",
	-- {npc:10537} Cliffwatcher Longhorn · {npc:11259} Nataka Longhorn · {zone:1443} Desolace
	["{npc:10537}: for {npc:11259} in {zone:1443}, next"] = "{npc:10537}：交給{zone:1443}的{npc:11259}，在下一份指南中",

	-- Step 35: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "飛往{area:460}",
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "{area:484}飛行管理員",

	-- Step 37: Scrabblescrew's Camp
	-- {zone:1443} Desolace · {npc:11596} Smeed Scrabblescrew
	["Head south out of Stonetalon into {zone:1443} and follow the road south to {npc:11596}'s camp."] = "向南離開石爪山脈進入{zone:1443}，沿道路向南到{npc:11596}的營地。",

	-- Step 38: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:11259} Nataka Longhorn · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post, {npc:11259} up on its rise; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395}站在哨站裡，{npc:11259}在哨站上方的高地；{npc:5641}和{npc:4498}在哨站西邊的高地上等候，俯瞰{area:596}。",
	-- {npc:11259} Nataka Longhorn
	["{npc:11259}, up on the rise"] = "{npc:11259}，在高地上",

	-- Step 40: Takata Steelblade and Maurin Bonesplitter
	-- {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter
	["{npc:5641} and {npc:4498}"] = "{npc:5641}和{npc:4498}",

	-- Step 41: Kodo Graveyard
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo · {npc:11521} Kodo Apparition
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. At his camp, talk to the kodo: that counts it and lets you tame the next. Five kodos, one at a time. Careful: leave the kodo skulls on the ground alone: opening one raises a {npc:11521} (37-38) that hits hard."] = "對墓地裡的老科多獸、垂死的科多獸或{npc:4702}使用{npc:11596}給的{item:13892}，然後把馴服的科多獸帶回{npc:11596}那裡。在他的營地與科多獸對話：這樣就會計數，並讓你能馴服下一隻。共五隻科多獸，一次一隻。小心：別碰地上的科多獸頭骨：打開後會召喚出一隻打得很痛的{npc:11521}（37-38級）。",
	-- {npc:4702} Ancient Kodo
	["on an Aged, Dying or {npc:4702} in the graveyard; don't kill it"] = "對墓地裡的年老的、垂死的或{npc:4702}使用；別把它殺了",
	-- {npc:11596} Smeed Scrabblescrew
	["the tamed kodo, at {npc:11596}'s camp: talk to it, five times"] = "被馴服的科多獸，在{npc:11596}的營地：和它對話，五次",

	-- Step 43: Shadowprey Village
	-- {area:606} Gelkis Village · {npc:268705} Aka'rai · {quest:97265} Hate the Hatefury
	["Head west to the troll village on the coast, keeping clear of the {area:606} on the way. {npc:268705} stands on the path just north of the village.\n{npc:268705} may not be here on Forever: if {npc:268705} doesn't offer {quest:97265}, skip it."] = "向西到海岸邊的巨魔村，路上避開{area:606}。{npc:268705}站在村子正北的小路上。\n在 Forever 裡{npc:268705}可能不在這裡：如果{npc:268705}不給{quest:97265}，跳過。",
	-- {npc:268705} Aka'rai · {area:603} Sargeron
	["{npc:268705}: the Hatefury satyrs of {area:603}, later in this guide"] = "{npc:268705}：{area:603}的憎怒薩特，本指南稍後",
	-- {npc:11877} Roon Wildmane · {quest:5762} Hemet Nesingwary
	["{npc:11877}: for {quest:5762} in Stranglethorn, next guide"] = "{npc:11877}：交給荊棘谷的{quest:5762}，在下一份指南中",
	-- {npc:6726} Thalon
	["{npc:6726}, at the village's south-west end"] = "{npc:6726}，在村子西南端",

	-- Step 44: Ethel Rethor
	-- {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort · {area:599} Thunder Axe Fortress · {area:2406} Ranazjar Isle
	["Head north along the coast, then inland to the ruined tower of {area:2405}: {npc:11863} waits inside. The coast's clams and naga come after {area:599}, on one walk north to {area:2406}."] = "沿著海岸向北走，然後往內陸前往{area:2405}的廢棄塔樓：{npc:11863}在裡面等你。海岸的蚌和納迦留到{area:599}之後，一路往北走向{area:2406}時再處理。",

	-- Step 45: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {npc:13019} Burning Blade Seer · {item:20310} Flayed Demon Skin · {object:176581} Hand of Iruxos Crystal · {npc:11876} Demon Spirit · {zone:1443} Desolace
	["Head east to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. The {npc:13019} stands on the fortress's top floor with the Sceptre. The cultists also drop a {item:20310} now and then (1-5%); if one drops, read it. Leave the red {object:176581} for now: its {npc:11876} is 37, and the second {zone:1443} visit comes back for it."] = "向東前往{area:599}。把一名燃燒之刃信徒打到殘血，在牠死前對牠使用{item:6436}，就能充能一個{item:6435}。{npc:13019}帶著權杖站在要塞的頂樓。信徒偶爾也會掉落{item:20310}（1-5%）；如果掉落了，就閱讀它。紅色的{object:176581}先不要碰：它的{npc:11876}是37級，第二次造訪{zone:1443}時會再回來處理。",
	["On the top floor"] = "頂層",

	-- Step 46: Ethel Rethor
	-- {npc:11863} Azore Aldamort
	["Back west to {npc:11863}."] = "向西返回{npc:11863}那裡。",
	-- {npc:11863} Azore Aldamort · {item:15803} Book of the Ancients · {npc:12369} Lord Kragaru · {area:2406} Ranazjar Isle
	["{npc:11863}'s next errand, the {item:15803}, needs {npc:12369} (38) out on {area:2406}: leave it, he is over your level."] = "{npc:11863}的下一個差事{item:15803}需要對付{area:2406}上的{npc:12369}（38級）：先別接，他的等級比你高。",

	-- Step 47: Rackmore's Log
	-- {object:177787} Rackmore's Log · {npc:11863} Azore Aldamort
	["{object:177787} lies on the ground just south-west of {npc:11863}'s tower, on the way down to the shore: read it. Its two keys drop only while you have the quest."] = "{object:177787}躺在{npc:11863}塔樓西南方不遠處的地上，就在下往海岸的路上：閱讀它。它的兩把鑰匙只有在你接了任務時才會掉落。",

	-- Step 48: Clam beds
	["Clam beds"] = "蚌床",
	-- {item:15874} Soft-shelled Clam · {item:15878} Rackmore's Silver Key
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler · Drysnap Crawlers = {npc:11562} Drysnap Crawler
	["West to the shore. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach: each clam you open on the sea floor, and some crawlers, give a {item:15874}. Open each one in your bags for its meat.\nThe Drysnap Crawlers and Pincers on the same beach carry {item:15878}, about one in seven."] = "向西前往海岸。巨型軟殼蚌躺在淺水中，狂怒的礁石爬行者在海灘上走動：你在海底打開的每個蚌，以及部分爬行者，都會給你一個{item:15874}。在背包中打開每一個以取得蚌肉。\n同一片海灘上的乾鉗爬行者和乾鉗鉗蟹身上帶有{item:15878}，大約七隻掉一把。",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam
	["Giant Softshell Clams, on the sea floor"] = "巨型軟殼蛤，在海底",
	-- {item:15874} Soft-shelled Clam
	["{item:15874}: open it in your bags"] = "{item:15874}：在揹包裡開啟",
	["Underwater"] = "在水下",
	-- {item:15878} Rackmore's Silver Key
	["{item:15878}, from the Drysnap crabs"] = "{item:15878}，來自乾鉗螃蟹",

	-- Step 49: Sar'theris Strand
	-- {area:598} Sar'theris Strand · {item:15881} Rackmore's Golden Key · {zone:1443} Desolace
	["Keep north to {area:598} for {item:15881}: any Slitherblade can drop it.\nCareful: the Myrmidons (34-35) hold the beach's northern half with the Sea Witches and Oracles (34-36, casters), up to two over you at 33: work the Naga and Sorceresses (32-33) of the southern half until the key drops, and leave the north for the second {zone:1443} visit, at 38."] = "繼續往北前往{area:598}取得{item:15881}：任何滑刃納迦都可能掉落。\n小心：海灘北半部有滑刃侍衛（34-35級），還有海巫和神諭者（34-36級，施法者），在33級時最多比你高兩級：在南半部打納迦和女巫（32-33級）直到鑰匙掉落，北部留到38級第二次造訪{zone:1443}時再處理。",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}，來自滑刃納迦",

	-- Step 50: Rackmore's Chest
	-- {area:2406} Ranazjar Isle · {object:177786} Rackmore's Chest · {object:177673} Serpent Statue
	["Swim out to {area:2406} off the far northern tip: {object:177786} stands on the shore beside the {object:177673}. Open it with both keys; leave the statue alone."] = "游到最北端外海的{area:2406}：{object:177786}就在岸邊的{object:177673}旁。用兩把鑰匙打開它；別碰雕像。",

	-- Step 51: Sargeron
	-- {area:599} Thunder Axe Fortress · {area:603} Sargeron · {npc:268705} Aka'rai
	-- plural, as words: Hatefury Rogues = {npc:4670} Hatefury Rogue
	["Head east past {area:599} and along the northern hills to the satyrs' ruins of {area:603}. Kill every kind you meet for {npc:268705}; the Shadowstalkers walk unseen.\nCareful: Hatefury Rogues use Hide when they spawn, so they are stealthed until you find them."] = "向東經過{area:599}，沿北邊的山丘前往{area:603}的薩特廢墟。為了{npc:268705}，遇到的每一種都殺掉；暗影潛伏者無形無蹤。\n注意：憎怒盜賊重新整理時會使用隱藏，所以在你發現它們之前一直處於潛行狀態。",
	-- {npc:4671} Hatefury Trickster
	["{npc:4671}, on the way south"] = "{npc:4671}，在南下的路上",

	-- Step 52: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	-- plural, as words: Kolkar Battle Lords = {npc:4636} Kolkar Battle Lord
	["South to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health.\nCareful: Kolkar Battle Lords call nearby allies within 30 yd once they fall to 20% health."] = "向南到{area:609}。{quest:1365}（35級）和一兩名戰鬥領主（32-33級）在東邊的帳篷之間走動：先清掉他周圍的怪，然後滿狀態單獨拉他。\n注意：科卡爾戰鬥領主血量降到20%時會呼叫30碼內附近的同伴。",

	-- Step 53: Ghost Walker Post
	["South-west down the road to the post."] = "沿道路向西南到哨站。",
	-- {npc:5641} Takata Steelblade · {npc:5640} Keldran · {zone:1454} Orgrimmar
	["{npc:5641}: for {npc:5640} in {zone:1454}, next guide"] = "{npc:5641}：交給{zone:1454}的{npc:5640}，在下一份指南中",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "{npc:5641}的下一個差事要你去對付一名帶著精英守衛的惡魔領主：跳過它。",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace · {area:607} Valley of Spears
	["{npc:5395} now offers Centaur Bounty: the second {zone:1443} visit, at 38, takes it on its way to the {area:607}."] = "{npc:5395}現在會提供「半人馬賞金」：38級第二次造訪{zone:1443}時，會在前往{area:607}的路上接取。",

	-- Step 54: Shadowprey Village
	["West to Shadowprey: your hearthstone is bound there."] = "向西前往暗影村：你的爐石綁在那裡。",
	-- {npc:268705} Aka'rai
	["{npc:268705}, on the path just north of the village"] = "{npc:268705}，在村子北邊不遠處的小路上",
	-- {item:14547} Hand of Iruxos · {zone:1443} Desolace · {zone:1454} Orgrimmar · {zone:1434} Stranglethorn Vale
	["Taiga's {item:14547}, Drulzegar's Other Fish to Fry and {zone:1443}'s other 37-40 quests wait for the second visit, at 38: the next guides fly to {zone:1454} and take the zeppelin to {zone:1434}."] = "泰加的{item:14547}、德魯澤加的「另有要事」以及{zone:1443}其他37-40級任務都留到38級第二次造訪時再做：接下來的指南會飛往{zone:1454}，再搭飛艇前往{zone:1434}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to {npc:11863}'s tower."] = "向南返回{npc:11863}的塔樓。",
	-- ["Keep north to {area:598}. The Slitherblade Myrmidons, Naga and Sorceresses hold the beach; pull them one at a time. Any Slitherblade can drop {item:15881}."] = "繼續向北前往{area:598}。滑刃侍從、滑刃納迦和滑刃女巫佔據著海灘；一次拉一隻。任何滑刃納迦都可能掉落{item:15881}。",
	-- ["Shadowprey's {quest:5381} and the coast's naga want 33. Below that? The Kolkar centaurs (30-32) of {area:609}, a short way east of {npc:11596}'s camp, are the nearest camp at your level: kill them until level 33. The Scorpashi Lashers (34-35) on the slopes north of the camp are higher. Or, with a group, run the {area:1717} dungeon instead."] = "葬影村的{quest:5381}和海岸的納迦需要33級。還沒到？{npc:11596}營地東邊不遠處{area:609}的科卡爾半人馬（30-32級）是離你最近、等級合適的營地：擊殺牠們直到33級。營地北邊山坡上的荒土鞭尾蠍（34-35級）等級更高。或者，組隊去打{area:1717}地城。",
	-- ["Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}. He is well above you: rest to full first. {object:177786} stands on the shore beside the statue: open it with both keys."] = "從最北端游到{area:2406}，對{object:177673}使用{item:15766}：{npc:12369}（38）會出現；殺死他以取得{quest:6027}。他比你高出不少等級：先休息到滿血。{object:177786}就在雕像旁的岸邊：用兩把鑰匙打開它。",
	-- ["grind on {npc:4635}"] = "擊殺{npc:4635}練等",
	-- ["{item:15766}, on the {object:177673}"] = "{item:15766}，對{object:177673}使用",
}
