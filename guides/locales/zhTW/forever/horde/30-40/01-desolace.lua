-- Chinese (traditional) (zhTW): the guide forever/horde/30-40/01-desolace (forever/horde/30-40/01-desolace.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {area:484} Freewind Post · {area:1637} Orgrimmar
	["From {area:484}, fly to {area:1637}."] = "從{area:484}飛往{area:1637}。",

	-- Step 2: Alliance Relations
	-- {npc:5639} Craven Drok · {npc:5640} Keldran · {object:172961} Valley of Spirits · {npc:4949} Thrall · {object:172957} Valley of Wisdom
	["{npc:5639} waits in the Drag; {npc:5640} stands in the {object:172961} on the west side of the city. Skyborne: {npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:5639}在The Drag等著；{npc:5640}站在城市西側的{object:172961}。天裔精靈：{npc:4949}在{object:172957}的Grommash Hold等著。",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}，Grommash Hold，如果你帶著它",

	-- Step 3: Train
	["Train"] = "訓練",
	["Train your new spells."] = "學習你的新法術。",

	-- Step 4: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:460} Sun Rock Retreat
	["Your trainer is in {area:1638}, one flight away: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to {area:460} from there."] = "你的訓練師在{area:1638}，飛一趟就到：{area:1639}的{npc:3033}（德魯伊）、{npc:246344}（聖騎士）。然後從那裡繼續飛往{area:460}。",

	-- Step 5: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "{zone:1454}的職業任務",
	-- {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["{npc:5892} stands in the {object:172957}."] = "{npc:5892}站在{object:172957}。",

	-- Step 6: Ratchet
	-- {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly to {area:392}. {npc:5901} camps on the coast a short ride south of the town."] = "飛往{area:392}。{npc:5901}在城鎮南邊不遠的海岸紮營。",

	-- Step 7: Prate Cloudseer
	-- {area:484} Freewind Post · {npc:5905} Prate Cloudseer
	["Fly to {area:484}. {npc:5905} hides in a small cave in the canyon wall north-east of the post."] = "飛往{area:484}。{npc:5905}躲在營地東北方峽谷崖壁的小洞穴中。",
	-- {npc:5905} Prate Cloudseer · {item:5178} Air Totem
	["{npc:5905}: your {item:5178}"] = "{npc:5905}：你的{item:5178}",
	-- {npc:5905} Prate Cloudseer · {area:1717} Razorfen Kraul
	["{npc:5905} also starts Elemental Aid ({area:1717}), the 33-40 chain to The Tempest's Weapons: forever/class/shaman/call-of-air-horde."] = "{npc:5905}也會開啟Elemental Aid（{area:1717}），這是通往風暴武器的33-40級任務鏈：forever/class/shaman/call-of-air-horde。",

	-- Step 8: Fly to Sun Rock Retreat
	-- {area:460} Sun Rock Retreat
	["Fly to {area:460}"] = "飛往{area:460}",

	-- Step 9: Gizelton caravan
	["Gizelton caravan"] = "基澤爾頓車隊",
	-- {zone:1443} Desolace · {area:608} Nijel's Point · {npc:11625} Cork Gizelton · {area:609} Kolkar Village
	["Follow the road south-west out of Sun Rock into {zone:1443} and on south past {area:608}. {npc:11625}'s kodo caravan waits by the road north of {area:609}; if it has already left, ride on."] = "沿道路從烈日石居向西南進入{zone:1443}，繼續向南經過{area:608}。{npc:11625}的科多獸商隊在{area:609}北邊的路旁等著；如果已經出發，就繼續騎。",

	-- Step 10: Bodyguard for Hire
	-- {area:609} Kolkar Village · {npc:11625} Cork Gizelton · {area:2617} Scrabblescrew's Camp · {area:597} Ghost Walker Post
	["The caravan rolls south past {area:609}. Kolkar raiders ambush it in waves: kill them before they reach {npc:11625}. It stops by {area:2617}, east of {area:597}."] = "商隊向南經過{area:609}。科卡爾掠奪者會一波波伏擊：在他們接近{npc:11625}之前殺掉。商隊停在{area:597}東邊的{area:2617}旁。",

	-- Step 12: Ghost Walker Post
	-- {npc:5395} Felgur Twocuts · {npc:5641} Takata Steelblade · {npc:4498} Maurin Bonesplitter · {area:596} Kodo Graveyard
	["{npc:5395} stands in the post; {npc:5641} and {npc:4498} wait on the rise west of it, above the {area:596}."] = "{npc:5395}站在哨站裡；{npc:5641}和{npc:4498}在哨站西邊、{area:596}上方的高地等著。",

	-- Step 13: Kodo Roundup
	-- {npc:11596} Smeed Scrabblescrew · {item:13892} Kodo Kombobulator · {npc:4702} Ancient Kodo
	["Use {npc:11596}'s {item:13892} on an Aged, Dying or {npc:4702} in the graveyard and walk the tamed kodo back to {npc:11596}. Five kodos, one at a time."] = "對墓地裡的老邁的科多獸、瀕死的科多獸或{npc:4702}使用{npc:11596}的{item:13892}，把馴服的科多獸帶回給{npc:11596}。共五隻，一次一隻。",

	-- Step 14: Khan Dez'hepah
	-- {area:609} Kolkar Village · {quest:1365} Khan Dez'hepah
	["Ride north-east to {area:609}. {quest:1365} (35) walks among the tents on the east side with a Battle Lord or two (32-33): clear around him, then pull him alone at full health."] = "向東北騎到{area:609}。{quest:1365}（35級）帶著一兩名科卡爾隊長（32-33級）在東側帳篷間走動：先清掉他周圍，再在滿血時單獨把他拉過來。",

	-- Step 15: Sargeron
	-- {area:603} Sargeron
	["North along the eastern hills, the satyrs hold the ruins of {area:603}. The Shadowstalkers walk unseen; the four kinds you need do not."] = "沿東部丘陵向北，薩特佔據{area:603}的廢墟。怨怒巡影者隱形行走；你需要的四種則不會。",

	-- Step 16: Thunder Axe Fortress
	-- {area:599} Thunder Axe Fortress · {item:6436} Burning Gem · {item:6435} Infused Burning Gem · {item:20310} Flayed Demon Skin
	["Ride west to {area:599}. Beat a Burning Blade cultist down, then use the {item:6436} on it before it dies to fill one {item:6435}. They also drop a {item:20310} now and then (1-5%); if one drops, read it."] = "向西騎到{area:599}。把一名燃刃氏族教徒打到殘血，在牠死前對牠使用{item:6436}以填滿一顆{item:6435}。他們偶爾也會掉落{item:20310}（1-5%）；掉了就閱讀它。",

	-- Step 17: Ghost Walker Post
	["Ride back south to the post."] = "向南騎回哨站。",
	-- {npc:5641} Takata Steelblade · {quest:1431} Alliance Relations · {zone:1454} Orgrimmar
	["{npc:5641}'s next {quest:1431} sends you back to {zone:1454} for nothing: leave it."] = "{npc:5641}的下一個{quest:1431}會白白把你派回{zone:1454}：不用理會。",

	-- Step 18: Kolkar ears
	["Kolkar ears"] = "科卡爾耳朵",
	-- {area:609} Kolkar Village
	["Back at {area:609}, every Kolkar can drop an ear."] = "回到{area:609}，每個科卡爾半人馬都可能掉落耳朵。",

	-- Step 19: Shadowstalker scalp
	["Shadowstalker scalp"] = "巡影者頭皮",
	-- {area:603} Sargeron
	-- plural, as words: Hatefury Shadowstalkers = {npc:4674} Hatefury Shadowstalker
	["The Hatefury Shadowstalkers at {area:603} walk unseen until they strike; about one in three carries a scalp."] = "{area:603}的怨怒巡影者在出手前都是隱形的；約三分之一身上帶著頭皮。",

	-- Step 21: Shadowprey Village
	-- {area:606} Gelkis Village
	["Ride south-west to the troll village on the coast, keeping clear of the {area:606} on the way."] = "向西南騎到海岸上的食人妖村落，途中避開{area:606}。",
	-- {npc:11877} Roon Wildmane · {npc:715} Hemet Nesingwary
	["{npc:11877}: for {npc:715} in Stranglethorn"] = "{npc:11877}：給荊棘谷的{npc:715}",

	-- Step 22: Clam beds
	["Clam beds"] = "蚌床",
	-- plural, as words: Giant Softshell Clams = {object:177784} Giant Softshell Clam · Enraged Reef Crawlers = {npc:12347} Enraged Reef Crawler
	["Ride north up the coast. Giant Softshell Clams lie in the shallows and the Enraged Reef Crawlers walk the beach; open each clam in your bags for its meat."] = "沿海岸向北騎。巨型軟殼蚌在淺水中，狂怒的暗礁蟹在海灘上走動；在背包中打開每個蚌取出蚌肉。",

	-- Step 23: Slitherblade Oracles
	-- plural, as words: Slitherblade Oracles = {npc:4718} Slitherblade Oracle
	["Slitherblade Oracles"] = "滑刃智者",
	-- {area:598} Sar'theris Strand
	["Keep north to {area:598}. The Oracles stand among the other naga at its north end; pull one at a time."] = "繼續向北到{area:598}。滑刃智者站在北端的其他納迦之間；一次只拉一隻。",

	-- Step 24: Ethel Rethor
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor
	["{npc:11863} waits in the ruined tower of {area:2405}, inland to the south-east."] = "{npc:11863}在東南方內陸{area:2405}的塔樓廢墟中等著。",

	-- Step 25: Burning Blade Seer
	-- {area:599} Thunder Axe Fortress · {area:2405} Ethel Rethor
	["The Seer stands on the south side of {area:599}, east of {area:2405}. Clear the cultists around it first."] = "火刃先知站在{area:599}南側，{area:2405}東邊。先清掉周圍的教徒。",

	-- Step 26: Ethel Rethor
	["His next errand is not on this route."] = "他的下一個差事不在本路線上。",

	-- Step 27: Ghost Walker Post
	["Ride south-east to the post."] = "向東南騎到哨站。",
	-- {npc:5641} Takata Steelblade
	["{npc:5641}'s next errand sends you after a demon lord with an elite guard: skip it."] = "{npc:5641}的下一個差事要你去對付一名帶著精英守衛的惡魔領主：跳過它。",

	-- Step 28: Gelkis Village
	["Ride south-west towards Shadowprey. The Gelkis centaurs (32-35) around their village are a good camp; fight them until level 32."] = "向西南往葬影村騎。吉爾吉斯半人馬（32-35級）在他們的村子周圍，是很好的刷怪點；打到32級。",
	-- {area:606} Gelkis Village · {zone:1443} Desolace
	-- plural, as words: Gelkis Stampers = {npc:4648} Gelkis Stamper
	["grind on Gelkis Stampers and Windchasers at the {area:606}, {zone:1443}"] = "在{zone:1443}的{area:606}刷吉爾吉斯踐踏者和吉爾吉斯逐風者",

	-- Step 30: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly to {area:1638} from Shadowprey and train with {npc:3033} on {area:1639}, then fly on to {zone:1454}."] = "從葬影村飛往{area:1638}，在{area:1639}向{npc:3033}學習，然後繼續飛往{zone:1454}。",

	-- Step 31: Fly to Orgrimmar
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "{area:2408}的飛行管理員",

	-- Step 32: Zeppelin to the Undercity
	-- {area:1497} Undercity
	["Zeppelin to the {area:1497}"] = "搭飛艇前往{area:1497}",
	-- {zone:1454} Orgrimmar · {area:1497} Undercity
	["Leave {zone:1454} by the main gate; the zeppelin tower stands just north-east of it. Take the {area:1497} zeppelin."] = "從正門離開{zone:1454}；飛艇塔就在它東北方不遠處。搭乘前往{area:1497}的飛艇。",
	["Zeppelin tower"] = "飛艇塔",

	-- Step 33: Garen Largo
	-- {npc:260093} Garen Largo · {area:1497} Undercity
	["{npc:260093} trains Paladins in the {area:1497}."] = "{npc:260093}在{area:1497}訓練聖騎士。",

	-- Step 34: Brazier of Everfount
	-- {area:1497} Undercity · {area:228} Sepulcher · {object:113791} Brazier of Everfount (no name in this language: may be words) · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Do your shopping in the {area:1497} first, then fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "先在{area:1497}採買，再飛往{area:228}。{object:113791}在它西南方不遠的山丘上：擊敗旁邊的Corrupt Manifestation of Water，把它的護腕放進火盆，與{npc:5895}交談，並把{item:7813}留給{npc:5901}。從{area:228}繼續飛往{area:272}。",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}: from Stranglethorn, next guide"] = "給{npc:5901}：來自荊棘谷，下一份指南",

	-- Step 35: Undercity
	-- {quest:515} Elixir of Agony · {item:3388} Strong Troll's Blood Potion · {skill:171} Alchemy · {area:287} Hillsbrad
	["{quest:515} needs a {item:3388}, an {skill:171} item: buy one at the auction house here if you can (or ask an alchemist). No potion: skip the Elixir steps in {area:287}."] = "{quest:515}需要一瓶{item:3388}，這是{skill:171}物品：能的話就在這裡的拍賣場購買（或找鍊金術師）。沒有藥水：跳過{area:287}的藥劑步驟。",
	-- {item:3388} Strong Troll's Blood Potion · {quest:515} Elixir of Agony
	["{item:3388}: auction house or an alchemist, for {quest:515}."] = "{item:3388}：拍賣場或鍊金術師，用於{quest:515}。",
	-- {npc:4551} Michael Garrett
	["{npc:4551}, the bat handler"] = "蝙蝠管理員{npc:4551}",

	-- Step 36: Tarren Mill
	-- {item:3703} Southshore Stout · {npc:2333} Henchman Valik
	["{item:3703}, for {npc:2333}"] = "{item:3703}，給{npc:2333}",
	-- {npc:2770} Tallow · {area:321} Hammerfall
	["{npc:2770}: for {area:321} in Arathi, later on the route"] = "{npc:2770}：給阿拉希高地的{area:321}，之後的路線",
	-- {npc:2229} Krusk · {zone:1413} Barrens
	["{npc:2229}: for the {zone:1413}, later on the route"] = "{npc:2229}：給{zone:1413}，之後的路線",

	-- Step 37: Daggerspine naga
	["Daggerspine naga"] = "刺脊納迦",
	-- {area:271} Southshore
	["Ride south, east of {area:271}, down to the coast. The Daggerspine naga line the shore south-east of the town."] = "向南騎，從{area:271}東邊下到海岸。刺脊納迦散布在城鎮東南方的海岸上。",
	["Daggerspine shore"] = "刺脊海岸",

	-- Step 38: Torn Fin murlocs
	["Torn Fin murlocs"] = "碎鰭魚人",
	-- {area:271} Southshore
	["Follow the shore west past {area:271}'s bay; the Torn Fin murlocs camp on the beaches beyond it."] = "沿海岸向西經過{area:271}的海灣；碎鰭魚人在更遠的海灘上紮營。",
	["Torn Fin beach"] = "碎鰭海灘",

	-- Step 39: Apothecary Lydon
	-- {area:272} Tarren Mill · {area:271} Southshore
	["Ride back north to {area:272}, keeping west of {area:271}."] = "向北騎回{area:272}，保持在{area:271}西邊。",

	-- Step 40: Shindigger keg
	["Shindigger keg"] = "鐵鏟酒桶",
	-- {area:287} Hillsbrad
	["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "酒桶和其他幾個酒桶放在{area:287}東南海岸的辛迪加營地裡。",

	-- Step 41: Back to Tarren Mill
	-- {area:272} Tarren Mill
	["Back to {area:272}"] = "返回{area:272}",
	["Hearth back (or ride north if it is on cooldown)."] = "用爐石回去（如果在冷卻中就向北騎）。",
	-- {object:1729} Tainted Keg · {object:1728} Dusty Rug
	["Place the {object:1729} on the {object:1728} beside the inn"] = "把{object:1729}放在旅店旁的{object:1728}上",

	-- Step 42: Henchman Valik
	-- {area:272} Tarren Mill · {quest:535} Valik
	["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "沿道路從{area:272}向北進入奧特蘭克山麓。{quest:535}在辛迪加營地旁等著；把烈性黑啤酒交給他。",

	-- Step 43: Syndicate missives
	["Syndicate missives"] = "辛迪加信件",
	-- plural, as words: Syndicate Footpads = {npc:2240} Syndicate Footpad
	["The Syndicate Footpads and Thieves (32-33) around the camps west of the road carry the missives; about one in three drops one."] = "道路西邊營地周圍的辛迪加劫匪和辛迪加竊賊（32-33級）身上帶著信件；約三分之一會掉落。",

	-- Step 44: Helcular's Rod
	-- {area:272} Tarren Mill
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti
	["South-west, the Cave and Ferocious Yetis (30-31) fill the caves in the hills west of {area:272}; about one in sixteen carries the rod."] = "往西南，洞穴雪人和兇惡的雪人（30-31級）佔據{area:272}西邊丘陵中的洞穴；約十六分之一身上帶著魔杖。",

	-- Step 45: The Dalaran traitors
	-- {area:279} Dalaran
	["The {area:279} traitors"] = "{area:279}的叛徒",
	-- {area:279} Dalaran · {npc:2411} Ricter · {npc:2412} Alina · {npc:2413} Dermot · {npc:2414} Kegan Darkmar
	-- plural, as words: Worn Stone Tokens = {item:3714} Worn Stone Token
	["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-32) around them drop the Worn Stone Tokens."] = "沿山腳向西前往{area:279}的紫色穹頂。{npc:2411}、{npc:2412}和{npc:2413}（33-34級）一起站在坑洞東緣內側，{npc:2414}（35級）在他們西邊不遠；每人各帶一塊血石。周圍的達拉然持盾守衛和達拉然法師（31-32級）會掉落用舊的石雕。",

	-- Step 46: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back east to {area:272}."] = "向東騎回{area:272}。",
	-- {area:271} Southshore
	["Thaivand's next task ends at {area:271}'s graveyard and the magus offers a dungeon errand: leave both."] = "學徒塞萬德的下一個任務在{area:271}的墓地結束，而法師提供的是地城差事：兩個都不用理會。",

	-- Step 47: Gol'dir
	-- {quest:535} Valik · {area:280} Strahnbrad · {npc:2431} Jailor Borhuin · {item:3704} Rusted Iron Key · {quest:503} Gol'dir
	["Ride north past {quest:535}'s camp to {area:280}, the Syndicate-held village (35-37). {npc:2431} carries the {item:3704}; {quest:503} sits in a cage in the house on the north side."] = "向北經過{quest:535}的營地，前往辛迪加佔據的村落{area:280}（35-37級）。{npc:2431}身上帶著{item:3704}；{quest:503}被關在北側房子的籠子裡。",

	-- Step 48: Tarren Mill
	-- {area:272} Tarren Mill
	["Ride back south to {area:272}."] = "向南騎回{area:272}。",

	-- Step 49: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "飛往{area:1497}",
	-- {area:1497} Undercity · {object:3202} Grom'gol
	["The next guide starts in the {area:1497}, at the {object:3202} zeppelin."] = "下一份指南從{area:1497}的{object:3202}飛艇開始。",
}
