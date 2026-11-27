-- Chinese (traditional) (zhTW): the guide forever/alliance/nightelf/02-darkshore (forever/alliance/nightelf/02-darkshore.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it.\nThe boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "你在路線之前來這裡時錯過了這一步：現在先做它。它很快，還會開啟後面的任務。\n船停靠在村子西邊。飛行管理員站在旅店南邊的山丘上；任務給予者分布在主街沿線。",
	["The WANTED poster outside the inn"] = "旅店外的通緝海報",

	-- Step 2: The beach
	["The beach"] = "海灘",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "潮行蟹在村子下方的海岸爬行；{quest:983}站在碼頭南邊不遠的海灘上。黑海岸蛇頸龍在淺水中游動。{object:175207}在村子南邊不遠的岸上。",

	-- Step 3: Auberdine
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}，在村子北端",

	-- Step 4: Auberdine
	-- {npc:3666} Wizbang Cranktoggle
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street. {npc:3666} stands upstairs in the inn: take the stairs inside, the arrow cannot tell the floors apart."] = "船停靠在村莊西邊。飛行管理員站在旅店南邊的山坡上；任務給予者分佈在主街兩旁。{npc:3666}在旅店樓上：從室內樓梯上去，箭頭無法區分樓層。",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, upstairs in the inn"] = "{npc:3666}，在旅店樓上",

	-- Step 6: The skeletal turtle
	["The skeletal turtle"] = "海龜骨骸",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks; underwater"] = "{item:12289}，在碼頭西邊的海灘上；在水下",

	-- Step 7: Buzzbox 827
	-- {quest:983} Buzzbox 827
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler
	["Only if you still carry {quest:983}'s quest: the Tide Crawlers scuttle along the shore below the village, and {quest:983} stands on the beach just south of the docks."] = "只有在你還帶著{quest:983}的任務時：潮汐爬行者在村子下方的海岸爬行，{quest:983}站在碼頭南邊不遠的海灘上。",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg · Tide Crawlers = {npc:2232} Tide Crawler
	["Crawler Legs: the Tide Crawlers"] = "爬行者的腿：潮汐爬行者",

	-- Step 8: Darkshore Threshers
	-- plural, as words: Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Darkshore Threshers"] = "",
	-- {quest:983} Buzzbox 827 · {area:452} Mist's Edge · {quest:1001} Buzzbox 411 · {quest:954} Bashal'Aran
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["{quest:983} stands on the beach just south of the docks: once his crawler legs are in, he asks for Thresher Eyes. The Darkshore Threshers (12-14) swim in the shallows off the docks and up the shore to {area:452}; {quest:1001}, who takes the eyes, stands north of {quest:954} at the end of the first loop."] = "",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes; underwater"] = "長尾鯊之眼；水下",

	-- Step 9: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "熊與黑木營地",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	-- was: ["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "狂暴薊熊在{area:442}以南的丘陵裡遊蕩：對其中一隻使用{item:7586}把它捕獲。然後走到它們正東的熊怪營地：現在還沒有要殺的東西。"
	["Rabid Thistle Bears roam the hills south of {area:442}: use {quest:2139} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "",
	-- {npc:3701} Tharnariun Treetender
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["the Rabid Thistle Bears nearest {npc:3701}"] = "距{npc:3701}最近的狂暴薊熊",

	-- Step 10: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639}站在廢墟北緣。被詛咒的精靈貴族、悲苦的精靈貴族和{npc:2178}在廢墟中出沒；{npc:3667}的鬼魂在它們之間走動，貓頭鷹{npc:270196}在它們東邊盤旋。兩塊石板在廢墟中；一個{quest:4722}在廢墟西邊的岸上。",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "精靈貴族的聖物",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "閱讀{object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "閱讀{object:17189}",

	-- Step 11: The red crystal
	["The red crystal"] = "紅色水晶",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "爬上{area:447}東邊的山脈；{object:175524}在一處岩架上。",

	-- Step 12: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	-- was: ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "沿丘陵向北。{npc:3650}在{quest:954}的廢墟裡等候；野生格里爾和邪惡小精靈遍佈其中，東邊是德塞利爾薩特。{object:17183}在廢墟以西的路旁；去他那邊的海岸上有一件{quest:4723}。"
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road north-north-west of {npc:3650}; a {quest:4723} lies on the shore on the way to him."] = "",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "劣魔耳環",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}：戴瑟雷薩特",

	-- Step 13: Buzzbox 411
	-- {quest:4723} Beached Sea Creature · {quest:1001} Buzzbox 411 · {area:442} Auberdine
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["North-north-west of Asterion by the road, past the {quest:4723}: {quest:1001} wants Moonstalker Fangs next, from the second loop's hills. Then south-west down to {area:442}."] = "",

	-- Step 14: Auberdine
	-- {npc:3693} Terenthis · {npc:3649} Thundris Windweaver
	["{npc:3693}: for {npc:3649}, at the north end of the village"] = "",
	-- {npc:6301} Gorbold Steelhand · {zone:1439} Darkshore
	["{npc:6301}, on the way north: the bay wrecks, on your next {zone:1439} visit"] = "",

	-- Step 15: Auberdine
	-- {npc:3701} Tharnariun Treetender
	["{npc:3701}: the bears are on the loop ahead"] = "",
	-- {npc:3649} Thundris Windweaver · {area:445} Cliffspring Falls
	["{npc:3649}: his sample comes from the {area:445}, at the end of the next loop"] = "",
	["Fill the tube at the moonwell in the village"] = "在村子的月井裝滿試管",

	-- Step 16: Cerellean Whiteclaw
	-- {npc:3644} Cerellean Whiteclaw · {npc:3667} Anaya Dawnrunner · {area:447} Ameth'Aran · {zone:1439} Darkshore
	["{npc:3644} waits where the pier meets the shore. {npc:3667} (16), whose pendant he wants, walks {area:447} on the loop ahead: from level 14.5 you take it there, else on your next {zone:1439} visit."] = "",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}，在碼頭上",

	-- Step 17: Rabid Thistle Bear on the way
	-- {npc:2164} Rabid Thistle Bear
	["{npc:2164} on the way"] = "{npc:2164}，順路",

	-- Step 18: Moonstalkers on the way
	["Moonstalkers on the way"] = "",
	-- {area:442} Auberdine · {area:456} Cliffspring River
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["The Moonstalkers (14-15) roam the hills of the loop ahead, south of {area:442} and around the {area:456} at its end: any of them drops the fangs. Leave the Moonstalker Sires (17-18) and Matriarchs (19-20) south of the Grove."] = "",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "月夜猛虎的牙齒",

	-- Step 19: Blackwood furbolgs
	["Blackwood furbolgs"] = "黑木熊怪",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder · Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	-- was: ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "黑木探路者和黑木風語者佔據{area:442}東南方的營地。\n小心：風語者（13-14級）會遠程施法，熊怪都是兩兩站在一起：一次拉一隻。"
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}; Rabid Thistle Bears roam the hills around it.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "",

	-- Step 20: The southern beaches
	["The southern beaches"] = "南部海灘",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "沿海岸向南經過{area:447}：一個{quest:4728}在古樹之林西邊的岸上，另一個在更南邊的{area:450}附近。更西南方的灰霧智者和灰霧潮行者（18-20級）之間還有三具骨骸：指南把它們留到最後一輪，那時你的等級更接近牠們。",

	-- Step 21: Onu
	-- {quest:952} Grove of the Ancients · {npc:3616} Onu · {npc:11218} Kerlonian Evershade
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["From the beached creature, head east to the {quest:952}. Watch for level 16 bears and level 17 Moonstalker Sires between the beach and the grove; go around them. {npc:3616} stands beside Arbal and the sleeping {npc:11218}."] = "",

	-- Step 22: Ameth'Aran
	-- {area:447} Ameth'Aran
	["Back north to {area:447}: the flame burns in the south of the ruins."] = "往北回到{area:447}：火焰在廢墟南部燃燒。",

	-- Step 23: Anaya's Pendant
	-- {npc:3667} Anaya Dawnrunner · {npc:2184} Lady Moongazer
	["Careful: {npc:3667} (16) is over you: pull her on her own at full health. {npc:2184}, a rare (17), also walks the ruins: leave her be."] = "",
	-- {item:5382} Anaya's Pendant · {npc:3667} Anaya Dawnrunner
	["{item:5382}: {npc:3667}'s ghost walks the ruins"] = "",

	-- Step 24: The red crystal
	["Back north-east into the mountains to the crystal."] = "向東北回到山中的水晶那裡。",

	-- Step 26: Bashal'Aran
	-- {npc:3650} Asterion · {area:456} Cliffspring River
	["North along the hills to {npc:3650}, then on north-east to the {area:456}."] = "",

	-- Step 27: Cliffspring Falls
	-- {area:456} Cliffspring River · {npc:6788} Den Mother
	-- plural, as words: Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["North-east up the {area:456} to the falls: fill the sampler at the water there. Moonstalkers (14-15) roam the hills around the river.\nCareful: Encrusted Tide Crawlers (17-20) line the shore below the falls and the {npc:6788}'s bears (18-19) lair in the hills south of them: keep to the river."] = "",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}，在瀑布",

	-- Step 28: Buzzbox 323
	-- {quest:1002} Buzzbox 323 · {object:17185} Buzzbox 525 · {zone:1439} Darkshore
	["{quest:1002} stands on the hill above the falls. He offers {object:17185} next: its bears are far south, for your next {zone:1439} visit."] = "",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs: the Moonstalkers around the river"] = "",

	-- Step 29: Beached Sea Turtle
	-- {quest:4725} Beached Sea Turtle · {quest:954} Bashal'Aran · {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Greymist Warriors = {npc:2205} Greymist Warrior
	["West along the north shore: the {quest:4725} lies on the beach north of {quest:954}, among Reef Crawlers and Greymist Warriors (15). Then south-west down to {area:442}."] = "",

	-- Step 30: Auberdine
	-- {npc:3657} Sentinel Elissa Starbreeze · {npc:3693} Terenthis · {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["{npc:3657}, beside {npc:3693}: for Balthule at the {area:444}, on your next {zone:1439} visit"] = "",
	-- {npc:3701} Tharnariun Treetender · {npc:6788} Den Mother · {zone:1439} Darkshore
	["{npc:3701}: the {npc:6788}, on your next {zone:1439} visit"] = "",
	-- {npc:3583} Barithras Moonshade · {area:445} Cliffspring Falls · {zone:1439} Darkshore
	["{npc:3583}: the cave by the {area:445}, on your next {zone:1439} visit"] = "",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}, on the walk from the boat"] = "",

	-- Step 31: Elisa Steelhand
	["talk to the trainer"] = "與訓練師交談",

	-- Step 32: Kurdram Stonehammer
	-- {npc:6297} Kurdram Stonehammer · {npc:6300} Elisa Steelhand · {quest:97948} Camping 101: Mining
	["{npc:6297}, beside {npc:6300}: {quest:97948}"] = "{npc:6297}，在{npc:6300}旁邊：{quest:97948}",

	-- Step 33: Jenna Lemkenilli
	-- {npc:11037} Jenna Lemkenilli · {npc:6300} Elisa Steelhand · {quest:97941} Camping 101: Engineering
	["{npc:11037}, beside {npc:6300}: {quest:97941}"] = "{npc:11037}，在{npc:6300}旁邊：{quest:97941}",

	-- Step 34: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {quest:4763} The Blackwood Corrupted · {zone:1439} Darkshore
	["From level 15 {npc:3649} also has {quest:4763}: its samples come from the northern Blackwood camp on your next {zone:1439} visit. Fill its bowl at the moonwell in the middle of the village now."] = "",
	-- {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell
	["{item:12347}: fill the {item:12346} at the {object:174795}"] = "{item:12347}：在{object:174795}裝滿{item:12346}",

	-- Step 35: Cerellean Whiteclaw
	-- {npc:3644} Cerellean Whiteclaw
	-- was: ["{npc:3644}, where the pier meets the shore, on the way to the boat"] = "{npc:3644}，在碼頭與岸邊相接處，就在去搭船的路上"
	["{npc:3644} waits where the pier meets the shore, on the way to the boat."] = "",

	-- Step 36: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "乘船前往{area:17203}",

	-- Step 37: Manifest Clerk Philmor
	-- {npc:268511} Manifest Clerk Philmor · {npc:483} Elaine Trias · {object:2096} Trade District
	["Off the boat, {npc:268511} stands on the harbor: his shipment goes to {npc:483}' cheese shop in the {object:2096}, beside the flight master."] = "下船後，{npc:268511}站在港口：他的貨物要送到{object:2096}裡{npc:483}的乳酪店，就在飛行管理員旁邊。",

	-- Step 38: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飛行管理員",
	-- {npc:483} Elaine Trias
	["{npc:483}, in her cheese shop"] = "{npc:483}，在她的乳酪店裡",
	-- {object:460004} Gatehouse Door (no name in this language: may be words)
	["Up the stairs in her shop: leave the shipment at the {object:460004}"] = "上她店裡的樓梯：把貨物留在{object:460004}處",

	-- Step 39: Baros Alexston
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {object:2096} Trade District · {zone:1436} Westfall · {npc:3649} Thundris Windweaver · {area:442} Auberdine
	-- was: ["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646}站在{object:2098}裡，在{object:2096}以西：他的羅盤在{zone:1436}的老房子裡，順路可取。"
	["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way. His reply to {npc:3649} goes back to {area:442} with you."] = "",
	-- {npc:1646} Baros Alexston · {npc:3649} Thundris Windweaver
	["{npc:1646}: {npc:3649}'s letter"] = "",
	-- {npc:1646} Baros Alexston · {quest:97926} Making Do · {npc:3649} Thundris Windweaver · {zone:1439} Darkshore
	["{npc:1646}: {quest:97926}, for {npc:3649} on your next {zone:1439} visit"] = "",

	-- Step 40: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "趁在這裡：向{npc:11867}學習{spell:202}（{object:2096}，10銀）；雙手武器讓戰士升級最快。",

	-- Step 41: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "順便：在{npc:11867}處學習劍（{object:2096}，10銀幣）；主手持劍能讓盜賊穩定升級。",

	-- Step 42: Druid trainer
	["Druid trainer"] = "德魯伊訓練師",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {area:87} Goldshire
	["{npc:5504} in {zone:1453}; {area:87} has no druid trainer"] = "{npc:5504}在{zone:1453}；{area:87}沒有德魯伊訓練師",

	-- Step 44: Class trainer
	["Class trainer"] = "職業訓練師",

	-- Step 45: Shaman trainer
	["Shaman trainer"] = "薩滿訓練師",
	-- {npc:257446} Teo Hammerstorm · {zone:1426} Dun Morogh · {area:87} Goldshire
	["{npc:257446} in {zone:1426}; {area:87} has no shaman trainer"] = "{npc:257446}在{zone:1426}；{area:87}沒有薩滿訓練師",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "黑木探路者和黑木風語者佔據{area:442}東南方的營地。",
	-- ["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}.\nCareful: the Windtalkers (13-14) cast from range and the furbolgs stand in pairs: pull them one at a time."] = "黑木探路者和黑木風語者佔據{area:442}東南方的營地。\n小心：風語者（13-14級）會遠程施法，熊怪都是兩兩站在一起：一次拉一隻。",
	-- ["Into {area:148}"] = "前往{area:148}",
	-- ["North along the hills to {npc:3650}, then west down to {area:442}."] = "沿山丘往北到{npc:3650}，再往西下去到{area:442}。",
	-- ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {object:17183} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "沿丘陵向北。{npc:3650}在{quest:954}的廢墟裡等候；野生格里爾和邪惡小精靈遍佈其中，東邊是德塞利爾薩特。{object:17183}在廢墟以西的路旁；去他那邊的海岸上有一件{quest:4723}。",
	-- ["Rabid Thistle Bears roam the hills south of {area:442}: use {item:7586} on one to capture it. Then walk up to the furbolg camp just east of them: nothing to kill yet."] = "狂暴薊熊在{area:442}以南的丘陵裡遊蕩：對其中一隻使用{item:7586}把它捕獲。然後走到它們正東的熊怪營地：現在還沒有要殺的東西。",
	-- ["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "船停靠在村子西邊。飛行管理員站在旅店南邊的山丘上；任務給予者分布在主街沿線。",
	-- ["{item:5382}: {npc:3667}, level 16; pull her away from the Highborne"] = "{item:5382}：{npc:3667}，16級；把她從精靈貴族身邊拉開",
	-- ["{npc:1646} stands in {object:2098}, west of the {object:2096}: his compass is in his old house in {zone:1436}, on the way."] = "{npc:1646}站在{object:2098}裡，在{object:2096}以西：他的羅盤在{zone:1436}的老房子裡，順路可取。",
	-- ["{npc:3644}, on the pier"] = "{npc:3644}，在碼頭上",
	-- ["{npc:3644}, where the pier meets the shore, on the way to the boat"] = "{npc:3644}，在碼頭與岸邊相接處，就在去搭船的路上",
}
