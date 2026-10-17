-- Chinese (traditional) (zhTW): the guide forever/alliance/03-darkshore (forever/alliance/03-darkshore.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "船停靠在村子西邊。飛行管理員站在旅店南邊的山丘上；任務給予者分布在主街沿線。",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, by the inn"] = "{npc:3666}，在旅店旁",
	["The WANTED poster outside the inn"] = "旅店外的通緝海報",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}，在碼頭上",
	-- {npc:10216} Gubber Blump · {skill:356} Fishing
	["{npc:10216}, on the pier: only with {skill:356}"] = "{npc:10216}，在碼頭上：只有在學會{skill:356}時",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}，在村子北端",

	-- Step 2: The beach
	["The beach"] = "海灘",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "潮行蟹在村子下方的海岸爬行；{quest:983}站在碼頭南邊不遠的海灘上。黑海岸蛇頸龍在淺水中游動。{object:175207}在村子南邊不遠的岸上。",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg
	["Crawler Legs"] = "蟹腿",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes"] = "蛇頸龍的眼球",
	-- {item:12238} Darkshore Grouper
	["{item:12238}: fish from the pier"] = "{item:12238}：在碼頭釣魚",

	-- Step 4: The skeletal turtle
	["The skeletal turtle"] = "海龜骨骸",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks"] = "{item:12289}，在碼頭西邊的海灘上",

	-- Step 5: Plagued bears
	["Plagued bears"] = "染病的熊",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills just east of {area:442}. Use {quest:2139} on one and lead it back to him."] = "狂暴薊熊在{area:442}東邊不遠的丘陵遊蕩。對一隻使用{quest:2139}，把牠帶回給他。",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "熊與黑木營地",
	-- {area:442} Auberdine
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Kill Rabid Thistle Bears in the hills east of {area:442}, then walk up to the furbolg camp south-east of them: nothing to kill yet."] = "在{area:442}東邊的丘陵擊殺狂暴薊熊，然後走到牠們東南方的熊怪營地：目前還不用殺任何東西。",

	-- Step 7: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639}站在廢墟北緣。被詛咒的精靈貴族、悲苦的精靈貴族和{npc:2178}在廢墟中出沒；{npc:3667}的鬼魂在它們之間走動，貓頭鷹{npc:270196}在它們東邊盤旋。兩塊石板在廢墟中；一個{quest:4722}在廢墟西邊的岸上。",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "閱讀{object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "閱讀{object:17189}",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "精靈貴族的聖物",

	-- Step 8: The red crystal
	["The red crystal"] = "紅色水晶",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "爬上{area:447}東邊的山脈；{object:175524}在一處岩架上。",

	-- Step 9: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "沿丘陵向北。{npc:3650}在{quest:954}的廢墟中等著；野生劣魔和惡靈劣魔遍布廢墟，戴瑟雷薩特在東緣。{quest:1001}站在廢墟西邊的路旁；前往它的路上，岸邊有一個{quest:4723}。",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "劣魔耳環",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}：戴瑟雷薩特",

	-- Step 10: The Tower of Althalaxx
	-- {quest:954} Bashal'Aran · {quest:1002} Buzzbox 323
	["Moonstalkers prowl the hills between {quest:954} and the tower. {quest:1002} stands on the hill west of the tower."] = "月夜猛虎在{quest:954}與高塔之間的丘陵徘徊。{quest:1002}站在高塔西邊的山丘上。",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "月夜猛虎的牙齒",

	-- Step 11: Hearth to Auberdine
	-- {area:442} Auberdine
	["Hearth to {area:442}"] = "用爐石回到{area:442}",
	["Fill the tube at the moonwell in the village"] = "在村子的月井裝滿試管",

	-- Step 12: A Lesson to Learn
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Fly from {area:442} to {area:702} and take the portal up to {npc:4217} in the {area:1658}."] = "從{area:442}飛往{area:702}，搭傳送門上到{area:1658}找{npc:4217}。",

	-- Step 13: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {area:442} Auberdine
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. Then fly back to {area:442} from {area:2361}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。神殿靈珠在{area:2361}下方{area:656}湖底的容器裡：拿一個到西北方的{area:2362}，在那裡使用並與{npc:11799}交談。然後從{area:2361}飛回{area:442}。",
	-- {quest:6122} The Principal Source · {area:445} Cliffspring Falls
	["{quest:6122}: fill the sampler at {area:445}"] = "{quest:6122}：在{area:445}裝滿採樣器",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}，從湖中的{object:177785}取得",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "在{area:2362}",
	-- {zone:1439} Darkshore · {zone:1436} Westfall
	["The half pendants lie in {zone:1439} and {zone:1436}: later on the route"] = "兩半墜飾在{zone:1439}和{zone:1436}：之後的路線",

	-- Step 14: Blackwood furbolgs
	["Blackwood furbolgs"] = "黑木熊怪",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "黑木探路者和黑木風語者佔據{area:442}東南方的營地。",

	-- Step 15: The Ancient Flame
	-- {object:16393} Ancient Flame
	["The {object:16393}"] = "{object:16393}",
	-- {area:447} Ameth'Aran
	["The flame burns in the south of {area:447}."] = "火焰在{area:447}南部燃燒。",

	-- Step 16: The southern beaches
	["The southern beaches"] = "南部海灘",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "沿海岸向南經過{area:447}：一個{quest:4728}在古樹之林西邊的岸上，另一個在更南邊的{area:450}附近。更西南方的灰霧智者和灰霧潮行者（18-20級）之間還有三具骨骸：指南把它們留到最後一輪，那時你的等級更接近牠們。",

	-- Step 17: The Grove of the Ancients
	-- {area:448} Grove of the Ancients
	["The {area:448}"] = "{area:448}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "灰斑薊熊在林地周圍的丘陵遊蕩；{quest:1003}就在林地西邊的熊群之中。",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "灰色頭皮",

	-- Step 18: The red crystal
	["Back north-east into the mountains to the crystal."] = "向東北回到山中的水晶那裡。",

	-- Step 19: Cliffspring Falls
	-- {area:456} Cliffspring River · {area:443} Ruins of Mathystra · {quest:954} Bashal'Aran
	["Follow the hills north to the {area:456} and up to the falls. Two more beached remains lie on the north shore: near the {area:443} and north of {quest:954}."] = "沿丘陵向北到{area:456}，再往上到瀑布。北岸還有兩具擱淺的骨骸：在{area:443}附近和{quest:954}北邊。",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}，在瀑布",
	-- {item:15845} Filled Cliffspring Falls Sampler
	["{item:15845}: at the mouth of the cave by the falls"] = "{item:15845}：在瀑布旁的洞口",

	-- Step 21: Auberdine
	["The WANTED poster"] = "通緝海報",
	-- {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell
	["{item:12347}: fill the {item:12346} at the {object:174795}"] = "",

	-- Step 22: The bay wrecks
	["The bay wrecks"] = "海灣沉船",
	-- {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore."] = "兩艘沉船在{area:442}北邊的海灣海底；每艘都有一個鎖箱。暗礁蟹和硬殼潮行蟹散布在這片海岸。",

	-- Step 23: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "{area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667}躲在廢墟外的小島上。鑰匙碎片由兇猛的森林陸行鳥（上段）、灰霧魚人（中段）和狂暴暗礁蟹（下段）掉落。",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}：廢墟西邊、北海岸外水下的{object:177792}",

	-- Step 24: The Tower of Althalaxx
	-- {npc:3661} Balthule Shadowstrike · {zone:1440} Ashenvale
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "{npc:3661}躲在塔底的暗灘狂熱者之間。把他的信留給{zone:1440}的淨化者德爾葛蘭。",
	-- {item:5348} Worn Parchment
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{item:5348}: Dark Strand Fanatics"] = "{item:5348}：暗灘狂熱者",

	-- Step 25: The northern Blackwood camp
	["The northern Blackwood camp"] = "",
	-- {area:456} Cliffspring River · {item:12347} Filled Cleansing Bowl · {item:12355} Talisman of Corruption
	["The furbolg camp south of the {area:456} keeps its Nut, Fruit and Grain Stores by the bonfires. With a sample of each and the {item:12347} in your bags, use the bowl by the bonfire closest to the river: it summons Xabraxxis, the satyr corruptor, and the {item:12355} lies in his Demon Bag."] = "",
	["By the bonfire closest to the river: summons Xabraxxis"] = "",
	-- {item:12355} Talisman of Corruption · {object:177624} Xabraxxis' Demon Bag
	["{item:12355}, in {object:177624}"] = "{item:12355}，在{object:177624}裡",

	-- Step 26: The cave and the Den Mother
	-- {npc:6788} Den Mother
	["The cave and the {npc:6788}"] = "洞穴與{npc:6788}",
	-- {item:5270} Death Cap · {npc:6788} Den Mother
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls."] = "洞穴在瀑布南邊：粗柄蘑菇長滿整個洞穴，{item:5270}在最深處。{npc:6788}的巢穴在瀑布南邊的丘陵中。",
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["Scaber Stalks"] = "粗柄蘑菇",

	-- Step 28: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}與{item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "月光蘑菇花生長在{area:442}東邊不遠丘陵中的梟獸洞穴裡；那裡的梟獸脾氣暴躁。{item:2449}需要{skill:182}：草藥學家在{zone:1439}各處都能採到，其他人從{zone:1453}（{npc:1313}）或拍賣場帶來。",

	-- Step 29: The Grove of the Ancients
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["Follow the road south. {quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "沿道路向南。{quest:948}是古樹之林的古樹；{npc:270269}和{npc:11218}睡在他旁邊。",
	-- {npc:11218} Kerlonian Evershade · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:11218}: his escort to {area:413} is done on the {zone:1440} leg"] = "{npc:11218}：護送他到{area:413}的任務在{zone:1440}路段完成",

	-- Step 30: The Master's Glaive
	-- {object:10076} Scrying Bowl · {object:12666} Twilight Tome · {npc:3584} Therylune
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "月夜雄虎在月刃周圍的樹林中徘徊。{object:10076}和{object:12666}在坑底；{npc:3584}站在北側。",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "優質月夜猛虎毛皮",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "{object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "{object:12666}",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}：暮光信徒和暮光暴徒",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "只有在暮光信徒或暮光暴徒掉落{item:5352}時：右鍵點擊它",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "護送她離開月刃；瑟瑞希爾在{zone:1440}接受繳交",

	-- Step 31: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "{npc:10323}的海灘",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches west and south-west of {area:450}."] = "{npc:10323}在月刃西邊的海灘紮營：擊殺營火旁的魚人；他會在第三波帶著獵犬出現。{area:450}西邊和西南邊的海灘上還有三具擱淺的骨骸。",

	-- Step 32: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil."] = "{area:450}位於{npc:10323}海灘南邊的海岸。在勘察員尋找化石時保護他。",

	-- Step 34: Auberdine
	["Follow the road north."] = "沿道路向北。",
	-- {quest:87760} Holy Diver · {npc:10219} Gwennyth Bly'Leggonde
	["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}：交齊全部九具擱淺的骨骸後，{npc:10219}會提供這個任務",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "她會給你{item:15826}",

	-- Step 35: The naga
	["The naga"] = "納迦",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore."] = "沿海岸向東北前往{area:443}。{quest:951}散落在廢墟中；雷鱗侍從、雷鱗巫師和雷鱗戰士佔據著廢墟，雷鱗獸王在岸邊走動。",

	-- Step 36: Back south
	["Back south"] = "往南回去",
	["Hearthstone on cooldown? Follow the coast road back south."] = "爐石在冷卻中？沿海岸道路往南回去。",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616}，在古樹之林",

	-- Step 37: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out."] = "{npc:3692}躲在{area:449}東邊的丘陵中。幫他回到道路上；他會一路戰鬥出去。",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}：對牠們使用{item:15826}；牠們遍布整個{zone:1439}",

	-- Step 38: Auberdine
	-- {npc:3694} Sentinel Selarin · {npc:3691} Raene Wolfrunner · {area:415} Astranaar · {zone:1440} Ashenvale
	["{npc:3694}: for {npc:3691} in {area:415}, on the later {zone:1440} leg"] = "{npc:3694}：之後{zone:1440}路段時給{area:415}的{npc:3691}",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}"] = "{npc:3649}：給{zone:1453}的{npc:1646}",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "搭船前往{zone:1453}",

	-- Step 39: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "夜精靈從{area:442}飛往{area:702}；天裔精靈從{area:442}碼頭搭船，並在那裡學習魯瑟蘭村的飛行路線。搭傳送門上到{area:1658}找{npc:4217}。",

	-- Step 40: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "施放{spell:18960}。{npc:11802}在{area:2361}；如果還沒有那裡的飛行路線就學一下。",
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802}: the welcome from Sheldras"] = "{npc:11802}：沙德拉斯·月樹的歡迎",

	-- Step 41: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "怒風獸穴的聖物",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394}（夜精靈）和{npc:272054}（天裔精靈）在{area:493}南部等著。三件聖物在它們東邊的{area:2363}。最初幾週的回報指出，當另一名玩家正在拾取時，聖物不會給你任何東西：稍等一下再試。",

	-- Step 42: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "返回{npc:11802}",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village · {area:442} Auberdine
	["Back to {npc:11802} in {area:2361}, then fly to {area:702} (by way of {area:442})."] = "回到{area:2361}找{npc:11802}，然後飛往{area:702}（途經{area:442}）。",

	-- Step 43: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1453} Stormwind
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the boat to {zone:1453}."] = "搭傳送門上去找{npc:4217}，然後飛回{area:442}搭船前往{zone:1453}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them."] = "沿海岸向東北前往{area:443}。{quest:951}散落在廢墟中；雷鱗侍從、雷鱗巫師和雷鱗戰士佔據著廢墟。",
	-- ["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}."] = "沿海岸向南經過{area:447}：一個{quest:4728}在古樹之林西邊的岸上，另一個在更南邊的{area:450}附近。",
	-- ["Follow the hills north to the {area:456} and up to the falls. Three more beached remains lie on the north shore: near the {area:443}, north of {quest:954} and west of {quest:954}."] = "沿丘陵向北到{area:456}，再往上到瀑布。北岸還有三具擱淺的骨骸：在{area:443}附近、{quest:954}北邊和{quest:954}西邊。",
	-- ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins."] = "沿丘陵向北。{npc:3650}在{quest:954}的廢墟中等著；野生劣魔和惡靈劣魔遍布廢墟，戴瑟雷薩特在東緣。{quest:1001}站在廢墟西邊的路旁。",
	-- ["Read both tablets"] = "閱讀兩塊石板",
	-- ["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls; {object:177624} lies at the satyr camp north of her."] = "洞穴在瀑布南邊：粗柄蘑菇長滿整個洞穴，{item:5270}在最深處。{npc:6788}的巢穴在瀑布南邊的丘陵中；{object:177624}在她北邊的薩特營地。",
	-- ["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {quest:4723} lies on the shore just south of the village."] = "潮行蟹在村子下方的海岸爬行；{quest:983}站在碼頭南邊不遠的海灘上。黑海岸蛇頸龍在淺水中游動。{quest:4723}在村子南邊不遠的岸上。",
	-- ["{item:15883}: the {object:177790} under the water off the north coast, west of the ruins"] = "{item:15883}：廢墟西邊、北海岸外水下的{object:177790}",
	-- ["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches south of {area:450}."] = "{npc:10323}在月刃西邊的海灘紮營：擊殺營火旁的魚人；他會在第三波帶著獵犬出現。{area:450}南邊的海灘上還有三具擱淺的骨骸。",
	-- ["{npc:6667} hides on the little island off the ruins; Stormscale Beastmistresses walk the shore. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667}躲在廢墟外的小島上；Stormscale Beastmistress在岸邊走動。鑰匙碎片由兇猛的森林陸行鳥（上段）、灰霧魚人（中段）和狂暴暗礁蟹（下段）掉落。",
	-- ["{quest:1003} stands west of the Grove."] = "{quest:1003}站在古樹之林西邊。",
}
