-- Chinese (simplified) (zhCN): the guide forever/alliance/03-darkshore-return (forever/alliance/03-darkshore-return.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {npc:3649} Thundris Windweaver · {npc:3702} Alanndarian Nightsong · {npc:2913} Archaeologist Hollee · {npc:3693} Terenthis · {npc:3694} Sentinel Selarin
	["From the dock, up to the north end of the village first ({npc:3649}, {npc:3702} by the moonwell, {npc:2913}), then down the main street: the WANTED poster outside the inn, {npc:3693} at its east end, where the road leaves south. {npc:3694} stands beside {npc:3693} by the flight master; if she isn't there, she has been killed and respawns shortly: wait a moment."] = "",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston
	["{npc:3649}, north end of the village: {npc:1646}'s reply"] = "",
	["The WANTED poster"] = "通缉布告",
	-- {npc:3694} Sentinel Selarin · {npc:3693} Terenthis · {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3694}, beside {npc:3693}: for {npc:3691} in {area:415}, in the next guide"] = "",

	-- Step 3: Onu
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["{quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "{quest:948}是古树之林中的古树，{npc:270269}和{npc:11218}在他旁边沉睡。",

	-- Step 4: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}和{item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "{object:177750}生长在{area:442}东边山丘上的枭兽洞穴里；那里的枭兽很暴躁。{item:2449}需要{skill:182}：草药师在{zone:1439}各处都能采到，其他人从{zone:1453}（{npc:1313}）或拍卖行带来。",

	-- Step 5: The Grove of the Ancients
	-- {quest:952} Grove of the Ancients
	["The {quest:952}"] = "{quest:952}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "{npc:2165}在林地周围的山丘上游荡；{quest:1003}就在林地西边的熊群之中。",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "{item:5414}",

	-- Step 6: The Master's Glaive
	-- {object:10076} Scrying Bowl · {object:12666} Twilight Tome · {npc:3584} Therylune
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "{npc:2237}在主宰之剑周围的树林里潜行。{object:10076}和{object:12666}在陨坑底部；{npc:3584}站在陨坑北侧。",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "{item:5386}",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "护送她离开主宰之剑；在{zone:1440}交给瑟瑞希尔",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "仅当暮光信徒或暮光暴徒掉落了{item:5352}：右键点击它",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "{object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "{object:12666}",
	-- {object:12666} Twilight Tome · {quest:949} The Twilight Camp
	["The {object:12666}, once it has {quest:949}"] = "",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}：暮光信徒和暮光暴徒",

	-- Step 7: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil.\nCareful: Ambushers appear as he passes certain spots: a scout comes out from under the board ramp, and more scouts come out when he checks the tent."] = "{area:450}位于{npc:10323}所在海滩的南侧海岸。保护勘察员寻找化石。\n注意：他经过特定地点时会触发伏击：经过木板坡道时，一名斥候会从下方出现；检查帐篷时，还会出现更多斥候。",

	-- Step 8: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "{npc:10323}的海滩",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Four beached remains lie on the beaches west and south-west of {area:450}: take them on the way north to his camp."] = "{npc:10323}在主宰之剑西侧海滩扎营。击杀营火旁的鱼人，他会在第三波与猎犬一同出现。{area:450}以西和西南的海滩上共有四处搁浅残骸，向北前往营地时顺路接取。",

	-- Step 11: The shore west of the Grove
	["The shore west of the Grove"] = "古树之林西侧海岸",
	-- {area:442} Auberdine · {quest:4728} Beached Sea Creature
	["On the way north to {area:442}, the last {quest:4728} lies on the shore west of the Grove."] = "向北返回{area:442}时，最后一处{quest:4728}位于古树之林西侧海岸。",

	-- Step 12: Auberdine
	["Follow the road north."] = "沿道路向北。",
	-- {quest:87760} Holy Diver · {npc:10219} Gwennyth Bly'Leggonde
	["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}：交齐全部九具搁浅的遗骸后，{npc:10219}会提供这个任务",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "她会给你{item:15826}",

	-- Step 13: On the way
	["On the way"] = "顺路完成",

	-- Step 14: The naga
	["The naga"] = "纳迦",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore."] = "沿海岸向东北到{area:443}。{quest:951}散落在废墟中；雷鳞侍从、雷鳞巫师和雷鳞战士占据着那里，雷鳞兽王在岸边巡逻。",

	-- Step 15: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "{area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667}躲在废墟外的小岛上。钥匙碎片掉落自凶猛的森林陆行鸟（上段）、灰雾鱼人（中段）和狂暴暗礁蟹（下段）。",
	["Underwater"] = "在水下",

	-- Step 16: Strange Lockbox
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}：在废墟西边、北部海岸外水下的{object:177792}",

	-- Step 17: Mist's Edge: kill these as you meet them
	-- {area:452} Mist's Edge
	["{area:452}: kill these as you meet them"] = "{area:452}：沿途击杀以下目标",

	-- Step 18: Back south
	["Back south"] = "返回南方",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616}，在古树之林",

	-- Step 19: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive · {npc:3693} Terenthis · {area:442} Auberdine
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out. {npc:3693} takes the escort in {area:442} on the next visit there."] = "{npc:3692} 藏在 {area:449} 东侧的山中。护送他返回道路；途中他会参与战斗。下次回到 {area:442} 时，找 {npc:3693} 交护送任务。",
	-- {npc:3692} Volcor · {area:455} Blackwood Den
	["{npc:3692}, inside {area:455}"] = "{npc:3692}，位于{area:455}内部",
	["His walk ends at the road, where Grimclaw waits"] = "他走到道路上、锐爪等候的位置就结束护送",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}：对它们使用{item:15826}；它们在整个{zone:1439}游荡",
	-- {npc:12298} Sickly Deer
	["Cure {npc:12298}"] = "",

	-- Step 21: Auberdine flight master
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}的飞行管理员",

	-- Step 22: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "暗夜精灵从{area:442}飞往{area:702}；天裔乘{area:442}码头的船前往，并在那里学习鲁瑟兰村的飞行路线。乘传送门上去找{area:1658}的{npc:4217}。",

	-- Step 25: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "施放{spell:18960}",

	-- Step 26: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Learn the flight path there if you do not have it."] = "施放{spell:18960}。{npc:11802}在{area:2361}他所在建筑的楼上：从室内上去，箭头无法区分楼层。如果还没有那里的飞行路线，就去学习。",

	-- Step 27: Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802}在{area:2361}他所在建筑的楼上：从室内上去，箭头无法区分楼层。",
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802}: the welcome from Sheldras"] = "{npc:11802}：沙德拉斯·月树的问候",

	-- Step 29: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "兽穴的圣物",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394}（暗夜精灵）和{npc:272054}（天裔）在{area:493}南部等候。三件遗物在它们东边的{area:2363}里。最初几周的报告称：其他玩家正在拾取某件遗物时，你拾取不到东西：稍等片刻再试。",

	-- Step 30: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "回到{npc:11802}处",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Back to {npc:11802} in {area:2361}, then {npc:11800} there flies Druids straight to {area:702}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "返回{area:2361}的{npc:11802}，然后那里的{npc:11800}会把德鲁伊直接送到{area:702}。{npc:11802}在他所在建筑的楼上：从室内上去，箭头无法区分楼层。",

	-- Step 32: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1440} Ashenvale
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the road south to {zone:1440}."] = "通过传送门上去找 {npc:4217}，再飞回 {area:442}，沿路向南前往 {zone:1440}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["From the dock, up to the north end of the village first ({npc:3702} by the moonwell, {npc:2913}), then down the main street: the WANTED poster outside the inn, {npc:3693} at its east end, where the road leaves south."] = "从码头先上行到村庄北端（{npc:3702} 在月亮井旁，还有 {npc:2913}），再沿主街往下走：通缉告示在旅店外，{npc:3693} 在主街东端、道路向南出村的位置。",
	-- ["{npc:3694}: for {npc:3691} in {area:415}, in the next guide"] = "{npc:3694}：交给 {area:415} 的 {npc:3691}，见下一篇指南",
}
