-- Chinese (traditional) (zhTW): the guide forever/alliance/03-darkshore-return (forever/alliance/03-darkshore-return.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	-- {npc:3649} Thundris Windweaver · {npc:3702} Alanndarian Nightsong · {npc:2913} Archaeologist Hollee · {npc:3693} Terenthis · {npc:3694} Sentinel Selarin · {quest:990} Trek to Ashenvale · {npc:3692} Volcor
	["From the dock (or the inn, if you used your Hearthstone), up to the north end of the village first ({npc:3649}, {npc:3702} by the moonwell, {npc:2913}), then down the main street: the WANTED poster outside the inn, {npc:3693} at its east end, where the road leaves south. {npc:3694} ({quest:990}) is beside {npc:3693} only for a few minutes at a time: she comes shortly after someone hands in {npc:3692}'s escort and leaves again about 5 minutes later. If she isn't there, don't wait: the guide offers her quest again when you hand in {npc:3692}'s escort to {npc:3693} yourself. Changing layer can also find her."] = "從碼頭（或旅店，如果你用了爐石）先往上到村子北端（{npc:3649}、月井旁的{npc:3702}、{npc:2913}），再沿主街往下走：旅店外的通緝告示，以及主街東端、道路往南離開處的{npc:3693}。{npc:3694}（{quest:990}）每次只會在{npc:3693}身旁待幾分鐘：有人繳交{npc:3692}的護送任務後不久她就會出現，約5分鐘後又離開。如果她不在，別等：等你自己把{npc:3692}的護送任務交給{npc:3693}時，指南會再提供她的任務。切換位面也可能找到她。",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston
	["{npc:3649}, north end of the village: {npc:1646}'s reply"] = "{npc:3649}，村子北端：交{npc:1646}的回信",
	["The WANTED poster"] = "通緝海報",
	-- {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis · {zone:1453} Stormwind
	["{npc:8997}, a short walk west of {npc:3693}: Argos's message from {zone:1453}"] = "",
	-- {npc:3694} Sentinel Selarin · {npc:3693} Terenthis · {npc:3691} Raene Wolfrunner · {area:415} Astranaar
	["{npc:3694}, beside {npc:3693} if she is there: for {npc:3691} in {area:415}, in the next guide"] = "{npc:3694}，如果她在{npc:3693}身旁：交給{area:415}的{npc:3691}，在下一個指南",

	-- Step 2: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}與{item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["On the way south to the Grove: the Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}, a short way off the road; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "往南前往林地的途中：月光蘑菇花生長在{area:442}東邊丘陵中的梟獸洞穴裡，離道路不遠；那裡的梟獸脾氣暴躁。{item:2449}需要{skill:182}：草藥學家在{zone:1439}各處都能採到，其他人從{zone:1453}（{npc:1313}）或拍賣場帶來。",

	-- Step 4: Onu
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["{quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "{quest:948}是樹林中的上古者；{npc:270269}和{npc:11218}睡在他身旁。",

	-- Step 5: The Grove of the Ancients
	-- {quest:952} Grove of the Ancients
	["The {quest:952}"] = "{quest:952}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "灰斑薊熊在林地周圍的丘陵遊蕩；{quest:1003}就在林地西邊的熊群之中。",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "灰色頭皮",

	-- Step 6: The Master's Glaive
	-- {object:12666} Twilight Tome · {quest:948} Onu · {item:5251} Phial of Scrying · {object:10076} Scrying Bowl
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:12666} sits at the bottom of the crater. For {quest:948}'s quest, use the {item:5251} at the bottom of the crater: it makes the {object:10076}, and you hand the quest in to the bowl."] = "月夜獵豹雄獸在月刃周圍的樹林中遊蕩。{object:12666}在彈坑底部。為了{quest:948}的任務，在彈坑底部使用{item:5251}：它會產生{object:10076}，你把任務繳交給這個碗。",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "優質月夜猛虎毛皮",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "只有在暮光信徒或暮光暴徒掉落{item:5352}時：右鍵點擊它",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "{object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "{object:12666}",
	-- {object:12666} Twilight Tome · {quest:949} The Twilight Camp
	["The {object:12666}, once it has {quest:949}"] = "{object:12666}，在它有了{quest:949}之後",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}：暮光信徒和暮光暴徒",

	-- Step 7: Therylune
	-- {npc:3584} Therylune · {zone:1440} Ashenvale
	["{npc:3584} stands on the north side of the crater: escort her out of the glaive. Therysil takes the turn-in in {zone:1440}."] = "{npc:3584}站在彈坑北側：護送她離開月刃。瑟瑞希爾在{zone:1440}接受繳交。",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "護送她離開月刃；瑟瑞希爾在{zone:1440}接受繳交",

	-- Step 8: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil.\nCareful: Ambushers appear as he passes certain spots: a scout comes out from under the board ramp, and more scouts come out when he checks the tent."] = "{area:450}位於{npc:10323}海灘以南的海岸上。在勘探者尋找化石時保護他。\n注意：他經過某些地點時會出現伏擊者：經過木板坡道下方時會鑽出一名斥候，他檢查帳篷時還會鑽出更多斥候。",

	-- Step 9: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "{npc:10323}的海灘",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Four beached remains lie on the beaches west and south-west of {area:450}: take them on the way north to his camp."] = "{npc:10323}在主宰之劍西邊的海灘上紮營：擊殺營火旁的魚人；他會在第三波帶著獵犬出現。{area:450}西邊和西南邊的海灘上有四具擱淺的遺骸：向北去他營地時順路取走。",

	-- Step 12: The shore west of the Grove
	["The shore west of the Grove"] = "古樹之林以西的岸邊",
	-- {area:442} Auberdine · {quest:4728} Beached Sea Creature
	["On the way north to {area:442}, the last {quest:4728} lies on the shore west of the Grove."] = "在向北去{area:442}的路上，最後一個{quest:4728}在古樹之林以西的岸邊。",

	-- Step 13: Auberdine
	["Follow the road north."] = "沿道路向北。",
	-- {quest:87760} Holy Diver · {npc:10219} Gwennyth Bly'Leggonde
	["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}：交齊全部九具擱淺的骨骸後，{npc:10219}會提供這個任務",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "她會給你{item:15826}",

	-- Step 14: Gershala Nightwhisper
	-- {area:2797} Blackfathom Deeps · {area:414} Zoram Strand · {npc:8997} Gershala Nightwhisper · {npc:3693} Terenthis
	["For your {area:2797} run, on the {area:414} in the next guide: {npc:8997} stands a short walk west of {npc:3693}."] = "為了你的{area:2797}之行，在下一份指南的{area:414}上：{npc:8997}站在{npc:3693}西邊不遠處。",

	-- Step 15: On the way
	["On the way"] = "順路",

	-- Step 16: The naga
	["The naga"] = "納迦",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics · {npc:270294} Baron Marinous
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore. Careful: {npc:270294}, an elite naga (21), walks the ruins among them: pull the naga away from him, or fight him at full health."] = "沿海岸向東北前往{area:443}。{quest:951}散落在廢墟中；雷鱗侍從、雷鱗巫師和雷鱗戰士佔據著廢墟，雷鱗獸王在岸邊走動。小心：精英納迦{npc:270294}（21級）在牠們之間的廢墟中走動：把納迦從他身邊拉開，或滿血再跟他打。",

	-- Step 17: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "{area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667}躲在廢墟外的小島上。鑰匙碎片由兇猛的森林陸行鳥（上段）、灰霧魚人（中段）和狂暴暗礁蟹（下段）掉落。",
	["Underwater"] = "在水下",

	-- Step 18: Strange Lockbox
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}：廢墟西邊、北海岸外水下的{object:177792}",

	-- Step 19: Mist's Edge: kill these as you meet them
	-- {area:452} Mist's Edge
	["{area:452}: kill these as you meet them"] = "{area:452}：遇到就殺",

	-- Step 20: Back south
	["Back south"] = "往南回去",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616}，在古樹之林",

	-- Step 21: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive · {area:455} Blackwood Den
	["{npc:3692} hides in the hills east of the {area:449}, inside {area:455}."] = "{npc:3692}躲在{area:449}以東的山丘中，在{area:455}裡面。",
	-- {npc:3692} Volcor · {area:455} Blackwood Den
	["{npc:3692}, inside {area:455}"] = "{npc:3692}，{area:455}內",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}：對牠們使用{item:15826}；牠們遍布整個{zone:1439}",
	-- {npc:12298} Sickly Deer
	["Cure {npc:12298}"] = "治療{npc:12298}",

	-- Step 22: Escort Volcor
	-- {npc:3692} Volcor
	["Escort {npc:3692}"] = "護送{npc:3692}",
	-- {npc:3692} Volcor · {npc:3693} Terenthis · {area:442} Auberdine
	["Help {npc:3692} back to the road; he fights on his way out. {npc:3693} takes the escort in {area:442} on the next visit there."] = "幫{npc:3692}回到大路上；他會一路戰鬥著離開。下次去{area:442}時，{npc:3693}會接受這次護送。",
	["His walk ends at the road, where Grimclaw waits"] = "他的巡視在道路處結束，怒爪在那裡等候",

	-- Step 23: Auberdine
	-- {quest:990} Trek to Ashenvale · {npc:3694} Sentinel Selarin · {npc:3693} Terenthis · {npc:3692} Volcor
	["No {quest:990} yet? Give it a minute after the hand-in: {npc:3694} comes to {npc:3693}'s side shortly after {npc:3692}'s escort is handed in. Changing layer can also find her."] = "還沒拿到{quest:990}？繳交後等一下：{npc:3692}的護送任務繳交後不久，{npc:3694}就會來到{npc:3693}身旁。切換位面也可能找到她。",
	-- {npc:3694} Sentinel Selarin · {quest:990} Trek to Ashenvale · {npc:3691} Raene Wolfrunner · {area:415} Astranaar · {zone:1440} Ashenvale
	["{npc:3694}, once she comes: {quest:990}, for {npc:3691} in {area:415} on your next {zone:1440} visit"] = "{npc:3694}，等她出現後：{quest:990}，下次到{zone:1440}時交給{area:415}的{npc:3691}",

	-- Step 24: Auberdine flight master
	-- {area:442} Auberdine
	["{area:442} flight master"] = "{area:442}飛行管理員",

	-- Step 25: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "夜精靈從{area:442}飛往{area:702}；天裔精靈從{area:442}碼頭搭船，並在那裡學習魯瑟蘭村的飛行路線。搭傳送門上到{area:1658}找{npc:4217}。",

	-- Step 28: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "施放{spell:18960}",

	-- Step 29: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. No {area:493} flight path yet? Learn it from {npc:10897}, south of the lake: the flight master in {area:2361} flies only Druids, from her gossip, and has none to learn."] = "施放{spell:18960}。{npc:11802}站在{area:2361}他建築的樓上：從裡面走上去，箭頭無法分辨樓層。還沒有{area:493}的飛行路線？向湖南邊的{npc:10897}學習：{area:2361}的飛行管理員只透過對話載德魯伊，也沒有飛行路線可學。",

	-- Step 30: Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802}站在{area:2361}他那棟樓的樓上：從裡面上樓，箭頭分不清樓層。",
	-- {npc:11802} Dendrite Starblaze · {npc:5504} Sheldras Moontree
	["{npc:11802}: the welcome from {npc:5504}"] = "{npc:11802}：{npc:5504}的歡迎",

	-- Step 32: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "怒風獸穴的遺物",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394}（夜精靈）和{npc:272054}（天裔精靈）在{area:493}南部等著。三件聖物在它們東邊的{area:2363}。最初幾週的回報指出，當另一名玩家正在拾取時，聖物不會給你任何東西：稍等一下再試。",

	-- Step 33: Trial of the Sea Lion
	-- {zone:1436} Westfall · {zone:1439} Darkshore · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {spell:499} Cat Form
	["Both half pendants in your bags (the {zone:1436} half from your last {zone:1436} visit, the {zone:1439} half from the north coast): stand by the {area:2362} on the north-west shore of the lake and use a half to join them, then take the pendant to {npc:11802} with the {spell:499} hand-in. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "兩半墜飾都在你的背包裡（{zone:1436}那一半來自你上次造訪{zone:1436}，{zone:1439}那一半來自北海岸）：站在湖西北岸的{area:2362}旁，使用其中一半把它們合起來，然後把墜飾連同{spell:499}的任務一起交給{npc:11802}。{npc:11802}站在他建築的樓上：從裡面走上去，箭頭無法分辨樓層。",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: join the halves at the {area:2362}"] = "{item:15885}：在{area:2362}把兩半合起來",
	-- {npc:11802} Dendrite Starblaze · {quest:5061} Aquatic Form · {npc:4217} Mathrengyl Bearwalker
	["{npc:11802}: {quest:5061}, for {npc:4217}"] = "{npc:11802}：{quest:5061}，交給{npc:4217}",

	-- Step 34: Dendrite Starblaze
	-- {item:15885} Pendant of the Sea Lion · {npc:11802} Dendrite Starblaze · {quest:5061} Aquatic Form
	["The {item:15885} is already with {npc:11802}: take {quest:5061} from him, upstairs in his building."] = "{item:15885}已經交給{npc:11802}：在他建築的樓上向他接取{quest:5061}。",

	-- Step 35: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "返回{npc:11802}處",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Back to {npc:11802} in {area:2361}, then {npc:11800} there flies Druids straight to {area:702}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "回到{area:2361}的{npc:11802}處，再找那裡的{npc:11800}，他能直接把德魯伊送到{area:702}。{npc:11802}在他那棟樓的樓上：從裡面上樓，箭頭分不清樓層。",

	-- Step 38: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1440} Ashenvale
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the road south to {zone:1440}. {npc:4217} is a Druid trainer: learn your new spells from him."] = "透過傳送門上去找 {npc:4217}，再飛回 {area:442}，沿路向南前往 {zone:1440}。{npc:4217} 是德魯伊訓練師：向他學習新法術。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Learn the flight path there if you do not have it."] = "施放{spell:18960}。{npc:11802}站在{area:2361}他建築的樓上：從裡面走上去，箭頭無法分辨樓層。如果你還沒有那裡的飛行路線就學起來。",
	-- ["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "月夜雄虎在月刃周圍的樹林中徘徊。{object:10076}和{object:12666}在坑底；{npc:3584}站在北側。",
	-- ["Moonstalker Sires prowl the woods around the glaive. The {object:12666} sits at the bottom of the crater; {npc:3584} stands on its north side. For {quest:948}'s quest, use the {item:5251} at the bottom of the crater: it makes the {object:10076}, and you hand the quest in to the bowl."] = "月夜雄虎在月刃周圍的樹林中徘徊。{object:12666}在坑底；{npc:3584}站在北側。進行{quest:948}的任務時，在坑底使用{item:5251}：它會變出{object:10076}，然後把任務交給這個碗。",
	-- ["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out. {npc:3693} takes the escort in {area:442} on the next visit there."] = "{npc:3692}躲在{area:449}東邊的山丘上。幫他回到道路上；他會一路戰鬥出去。{npc:3693}會在下次去{area:442}時接下護送任務。",
}
