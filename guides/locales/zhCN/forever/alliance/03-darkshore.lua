-- Chinese (simplified) (zhCN): the guide forever/alliance/03-darkshore (forever/alliance/03-darkshore.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Auberdine
	["The boat docks west of the village. The flight master stands on the hill south of the inn; the quest givers are spread along the main street."] = "船停靠在村子西边。飞行管理员站在旅店南边的山丘上；任务发布者分布在主街上。",
	-- {npc:3666} Wizbang Cranktoggle
	["{npc:3666}, by the inn"] = "{npc:3666}，在旅店旁",
	["The WANTED poster outside the inn"] = "旅店外的通缉布告",
	-- {npc:3644} Cerellean Whiteclaw
	["{npc:3644}, on the pier"] = "{npc:3644}，在码头上",
	-- {npc:10216} Gubber Blump · {skill:356} Fishing
	["{npc:10216}, on the pier: only with {skill:356}"] = "{npc:10216}，在码头上：需要{skill:356}",
	-- {npc:3649} Thundris Windweaver
	["{npc:3649}, north end of the village"] = "{npc:3649}，在村子北端",

	-- Step 2: The beach
	["The beach"] = "海滩",
	-- {quest:983} Buzzbox 827 · {object:175207} Beached Sea Creature
	-- plural, as words: Tide Crawlers = {npc:2232} Tide Crawler · Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {object:175207} lies on the shore just south of the village."] = "{npc:2232}在村子下方的岸边爬行；{quest:983}立在码头南边的海滩上。{npc:2185}在浅水中游动。{object:175207}躺在村子南边的岸上。",
	-- plural, as words: Crawler Legs = {item:5385} Crawler Leg
	["Crawler Legs"] = "{item:5385}",
	-- plural, as words: Thresher Eyes = {item:5412} Thresher Eye
	["Thresher Eyes"] = "{item:5412}",
	-- {item:12238} Darkshore Grouper
	["{item:12238}: fish from the pier"] = "{item:12238}：在码头钓鱼",

	-- Step 4: The skeletal turtle
	["The skeletal turtle"] = "骷髅海龟",
	-- {item:12289} Sea Turtle Remains
	["{item:12289}, on the beach west of the docks"] = "{item:12289}，在码头西边的海滩上",

	-- Step 5: Plagued bears
	["Plagued bears"] = "染病的熊",
	-- {area:442} Auberdine · {quest:2139} Tharnariun's Hope
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Rabid Thistle Bears roam the hills just east of {area:442}. Use {quest:2139} on one and lead it back to him."] = "{npc:2164}在{area:442}东边的山丘上游荡。对一只使用{quest:2139}，然后把它引回他身边。",

	-- Step 6: Bears and the Blackwood camp
	["Bears and the Blackwood camp"] = "熊和黑木营地",
	-- {area:442} Auberdine
	-- plural, as words: Rabid Thistle Bears = {npc:2164} Rabid Thistle Bear
	["Kill Rabid Thistle Bears in the hills east of {area:442}, then walk up to the furbolg camp south-east of them: nothing to kill yet."] = "在{area:442}东边的山丘上击杀{npc:2164}，然后走到它们东南方的熊怪营地：暂时不用击杀任何东西。",

	-- Step 7: Ameth'Aran
	-- {npc:3639} Sentinel Tysha Moonblade · {npc:2178} Wailing Highborne · {npc:3667} Anaya Dawnrunner · {npc:270196} Jai'vhanel · {quest:4722} Beached Sea Turtle
	["{npc:3639} stands at the north edge of the ruins. Cursed, Writhing and {npc:2178} haunt them; {npc:3667}'s ghost walks among them, {npc:270196} the owl circles east of them. The two tablets lie in the ruins; a {quest:4722} lies on the shore west of them."] = "{npc:3639}站在废墟北缘。被诅咒的贵族、挣扎的贵族和{npc:2178}在那里出没；{npc:3667}的鬼魂在它们中间游荡，猫头鹰{npc:270196}在它们东边盘旋。两块石板在废墟中；一只{quest:4722}躺在废墟西边的岸上。",
	-- {object:17188} Lay of Ameth'Aran
	["Read the {object:17188}"] = "阅读{object:17188}",
	-- {object:17189} Fall of Ameth'Aran
	["Read the {object:17189}"] = "阅读{object:17189}",
	-- plural, as words: Highborne Relics = {item:5360} Highborne Relic
	["Highborne Relics"] = "{item:5360}",

	-- Step 8: The red crystal
	["The red crystal"] = "红色水晶",
	-- {area:447} Ameth'Aran · {object:175524} Mysterious Red Crystal
	["Climb the eastern mountains east of {area:447}; the {object:175524} sits on a ledge."] = "爬上{area:447}东边的山脉；{object:175524}位于一处岩架上。",

	-- Step 9: Bashal'Aran
	-- {npc:3650} Asterion · {quest:954} Bashal'Aran · {quest:1001} Buzzbox 411 · {quest:4723} Beached Sea Creature
	-- plural, as words: Wild Grells = {npc:2190} Wild Grell · Vile Sprites = {npc:2189} Vile Sprite · Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins; a {quest:4723} lies on the shore on the way to him."] = "沿山丘向北。{npc:3650}在{quest:954}的废墟中等候；废墟里满是野生劣魔和恶灵劣魔，东缘是戴瑟雷萨特。{quest:1001}立在废墟西边的路旁；去找它的路上，岸边躺着一只{quest:4723}。",
	-- plural, as words: Grell Earrings = {item:5336} Grell Earring
	["Grell Earrings"] = "{item:5336}",
	-- {item:5338} Ancient Moonstone Seal
	-- plural, as words: Deth'ryll Satyrs = {npc:2212} Deth'ryll Satyr
	["{item:5338}: Deth'ryll Satyrs"] = "{item:5338}：{npc:2212}",

	-- Step 10: The Tower of Althalaxx
	-- {quest:954} Bashal'Aran · {quest:1002} Buzzbox 323
	["Moonstalkers prowl the hills between {quest:954} and the tower. {quest:1002} stands on the hill west of the tower."] = "月夜猛虎在{quest:954}和塔之间的山丘上潜行。{quest:1002}立在塔西边的山丘上。",
	-- plural, as words: Moonstalker Fangs = {item:5413} Moonstalker Fang
	["Moonstalker Fangs"] = "{item:5413}",

	-- Step 11: Hearth to Auberdine
	-- {area:442} Auberdine
	["Hearth to {area:442}"] = "用炉石返回{area:442}",
	["Fill the tube at the moonwell in the village"] = "在村里的月亮井装满试管",

	-- Step 12: A Lesson to Learn
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Fly from {area:442} to {area:702} and take the portal up to {npc:4217} in the {area:1658}."] = "从{area:442}飞往{area:702}，乘传送门上去找{area:1658}的{npc:4217}。",

	-- Step 13: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {area:442} Auberdine
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} in the north-west, use it there and speak to {npc:11799}. Then fly back to {area:442} from {area:2361}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。{item:15877}在{area:2361}下方{area:656}湖底的容器里：拿一个到西北方的{area:2362}，在那里使用并与{npc:11799}交谈。然后从{area:2361}飞回{area:442}。",
	-- {quest:6122} The Principal Source · {area:445} Cliffspring Falls
	["{quest:6122}: fill the sampler at {area:445}"] = "{quest:6122}：在{area:445}装满取样器",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}，来自湖中的{object:177785}",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "在{area:2362}",
	-- {zone:1439} Darkshore · {zone:1436} Westfall
	["The half pendants lie in {zone:1439} and {zone:1436}: later on the route"] = "两块吊坠碎片在{zone:1439}和{zone:1436}：在路线后面",

	-- Step 14: Blackwood furbolgs
	["Blackwood furbolgs"] = "黑木熊怪",
	-- {area:442} Auberdine
	-- plural, as words: Blackwood Pathfinders = {npc:2167} Blackwood Pathfinder
	["Blackwood Pathfinders and Windtalkers hold the camp south-east of {area:442}."] = "{npc:2167}和黑木风语者占据着{area:442}东南方的营地。",

	-- Step 15: The Ancient Flame
	-- {object:16393} Ancient Flame
	["The {object:16393}"] = "{object:16393}",
	-- {area:447} Ameth'Aran
	["The flame burns in the south of {area:447}."] = "火焰在{area:447}南部燃烧。",

	-- Step 16: The southern beaches
	["The southern beaches"] = "南部海滩",
	-- {area:447} Ameth'Aran · {quest:4728} Beached Sea Creature · {area:450} Remtravel's Excavation
	-- plural, as words: Greymist Oracles = {npc:2207} Greymist Oracle
	["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}. Three more remains lie further south-west among Greymist Oracles and Tidehunters (18-20): the guide leaves them for the last loop, when you are closer to their level."] = "沿海岸向南经过{area:447}：一只{quest:4728}躺在古树之林西边的岸上，另一只在更南边的{area:450}附近。更西南方的灰雾智者和灰雾潮行者（18-20级）之间还有三具遗骸：指南把它们留到最后一轮，那时你的等级更接近它们。",

	-- Step 17: The Grove of the Ancients
	-- {area:448} Grove of the Ancients
	["The {area:448}"] = "{area:448}",
	-- {quest:1003} Buzzbox 525
	-- plural, as words: Grizzled Thistle Bears = {npc:2165} Grizzled Thistle Bear
	["Grizzled Thistle Bears roam the hills around the Grove; {quest:1003} stands west of it among them."] = "{npc:2165}在林地周围的山丘上游荡；{quest:1003}就在林地西边的熊群之中。",
	-- plural, as words: Grizzled Scalps = {item:5414} Grizzled Scalp
	["Grizzled Scalps"] = "{item:5414}",

	-- Step 18: The red crystal
	["Back north-east into the mountains to the crystal."] = "向东北回到山里的水晶处。",

	-- Step 19: Cliffspring Falls
	-- {area:456} Cliffspring River · {area:443} Ruins of Mathystra · {quest:954} Bashal'Aran
	["Follow the hills north to the {area:456} and up to the falls. Two more beached remains lie on the north shore: near the {area:443} and north of {quest:954}."] = "沿山丘向北到{area:456}，再往上到瀑布。北岸还有两具搁浅的遗骸：在{area:443}附近和{quest:954}北边。",
	-- {item:12349} Cliffspring River Sample
	["{item:12349}, at the waterfall"] = "{item:12349}，在瀑布处",
	-- {item:15845} Filled Cliffspring Falls Sampler
	["{item:15845}: at the mouth of the cave by the falls"] = "{item:15845}：在瀑布旁的洞口",

	-- Step 21: Auberdine
	["The WANTED poster"] = "通缉布告",
	-- {item:12347} Filled Cleansing Bowl · {item:12346} Empty Cleansing Bowl · {object:174795} Auberdine Moonwell
	["{item:12347}: fill the {item:12346} at the {object:174795}"] = "",

	-- Step 22: The bay wrecks
	["The bay wrecks"] = "海湾沉船",
	-- {area:442} Auberdine
	-- plural, as words: Reef Crawlers = {npc:2235} Reef Crawler · Encrusted Tide Crawlers = {npc:2233} Encrusted Tide Crawler
	["Two wrecks lie on the sea floor in the bay north of {area:442}; each holds a lockbox. Reef Crawlers and Encrusted Tide Crawlers line this shore."] = "{area:442}北边海湾的海底有两艘沉船，各有一个保险箱。{npc:2235}和{npc:2233}遍布这段海岸。",

	-- Step 23: The Ruins of Mathystra
	-- {area:443} Ruins of Mathystra
	["The {area:443}"] = "{area:443}",
	-- {npc:6667} Gelkak Gyromast
	-- plural, as words: Giant Foreststriders = {npc:2323} Giant Foreststrider · Raging Reef Crawlers = {npc:2236} Raging Reef Crawler
	["{npc:6667} hides on the little island off the ruins. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667}躲在废墟外的小岛上。钥匙碎片掉落自凶猛的森林陆行鸟（上段）、灰雾鱼人（中段）和狂暴暗礁蟹（下段）。",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}: the {object:177792} under the water off the north coast, west of the ruins"] = "{item:15883}：在废墟西边、北部海岸外水下的{object:177792}",

	-- Step 24: The Tower of Althalaxx
	-- {npc:3661} Balthule Shadowstrike · {zone:1440} Ashenvale
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{npc:3661} hides at the foot of the tower among the Dark Strand Fanatics. Keep his letter for Delgren in {zone:1440}."] = "{npc:3661}躲在塔脚下的{npc:2336}中间。保留他的信，交给{zone:1440}的净化者德尔格伦。",
	-- {item:5348} Worn Parchment
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic
	["{item:5348}: Dark Strand Fanatics"] = "{item:5348}：{npc:2336}",

	-- Step 25: The northern Blackwood camp
	["The northern Blackwood camp"] = "",
	-- {area:456} Cliffspring River · {item:12347} Filled Cleansing Bowl · {item:12355} Talisman of Corruption
	["The furbolg camp south of the {area:456} keeps its Nut, Fruit and Grain Stores by the bonfires. With a sample of each and the {item:12347} in your bags, use the bowl by the bonfire closest to the river: it summons Xabraxxis, the satyr corruptor, and the {item:12355} lies in his Demon Bag."] = "",
	["By the bonfire closest to the river: summons Xabraxxis"] = "",
	-- {item:12355} Talisman of Corruption · {object:177624} Xabraxxis' Demon Bag
	["{item:12355}, in {object:177624}"] = "{item:12355}，在{object:177624}里",

	-- Step 26: The cave and the Den Mother
	-- {npc:6788} Den Mother
	["The cave and the {npc:6788}"] = "洞穴和{npc:6788}",
	-- {item:5270} Death Cap · {npc:6788} Den Mother
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls."] = "洞穴在瀑布南边：整个洞里都长着{item:5271}，{item:5270}在最深处。{npc:6788}的巢穴在瀑布南边的山丘上。",
	-- plural, as words: Scaber Stalks = {item:5271} Scaber Stalk
	["Scaber Stalks"] = "{item:5271}",

	-- Step 28: Lunar Fungus and Earthroot
	-- {item:15851} Lunar Fungus · {item:2449} Earthroot
	["{item:15851} and {item:2449}"] = "{item:15851}和{item:2449}",
	-- {area:442} Auberdine · {item:2449} Earthroot · {skill:182} Herbalism · {zone:1439} Darkshore · {zone:1453} Stormwind · {npc:1313} Maria Lumere
	-- plural, as words: Lunar Fungal Blooms = {object:177750} Lunar Fungal Bloom
	["The Lunar Fungal Blooms grow in the moonkin caves in the hills just east of {area:442}; the moonkin there are irritable. {item:2449} needs {skill:182}: herbalists pick it all over {zone:1439}, anyone else brings it from {zone:1453} ({npc:1313}) or the Auction House."] = "{object:177750}生长在{area:442}东边山丘上的枭兽洞穴里；那里的枭兽很暴躁。{item:2449}需要{skill:182}：草药师在{zone:1439}各处都能采到，其他人从{zone:1453}（{npc:1313}）或拍卖行带来。",

	-- Step 29: The Grove of the Ancients
	-- {quest:948} Onu · {npc:270269} Arbal · {npc:11218} Kerlonian Evershade
	["Follow the road south. {quest:948} is the ancient at the Grove; {npc:270269} and {npc:11218} sleep beside him."] = "沿道路向南。{quest:948}是古树之林的古树；{npc:270269}和{npc:11218}睡在他旁边。",
	-- {npc:11218} Kerlonian Evershade · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:11218}: his escort to {area:413} is done on the {zone:1440} leg"] = "{npc:11218}：护送他到{area:413}的任务在{zone:1440}阶段完成",

	-- Step 30: The Master's Glaive
	-- {object:10076} Scrying Bowl · {object:12666} Twilight Tome · {npc:3584} Therylune
	-- plural, as words: Moonstalker Sires = {npc:2237} Moonstalker Sire
	["Moonstalker Sires prowl the woods around the glaive. The {object:10076} and the {object:12666} sit at the bottom of the crater; {npc:3584} stands on its north side."] = "{npc:2237}在主宰之剑周围的树林里潜行。{object:10076}和{object:12666}在陨坑底部；{npc:3584}站在陨坑北侧。",
	-- plural, as words: Fine Moonstalker Pelts = {item:5386} Fine Moonstalker Pelt
	["Fine Moonstalker Pelts"] = "{item:5386}",
	-- {object:10076} Scrying Bowl
	["The {object:10076}"] = "{object:10076}",
	-- {object:12666} Twilight Tome
	["The {object:12666}"] = "{object:12666}",
	-- {item:279279} Peerless Eye
	-- plural, as words: Twilight Disciples = {npc:2338} Twilight Disciple
	["{item:279279}: Twilight Disciples and Thugs"] = "{item:279279}：暮光信徒和暮光暴徒",
	-- {item:5352} Book: The Powers Below
	["Only if a Disciple or Thug dropped {item:5352}: right-click it"] = "仅当暮光信徒或暮光暴徒掉落了{item:5352}：右键点击它",
	-- {zone:1440} Ashenvale
	["Escort her out of the glaive; Therysil takes the turn-in in {zone:1440}"] = "护送她离开主宰之剑；在{zone:1440}交给瑟瑞希尔",

	-- Step 31: Murkdeep's beach
	-- {npc:10323} Murkdeep
	["{npc:10323}'s beach"] = "{npc:10323}的海滩",
	-- {npc:10323} Murkdeep · {area:450} Remtravel's Excavation
	["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches west and south-west of {area:450}."] = "{npc:10323}在主宰之剑西边的海滩上扎营：击杀营火旁的鱼人；他会在第三波带着猎犬出现。{area:450}西边和西南边的海滩上还有三具搁浅的遗骸。",

	-- Step 32: Prospector Remtravel
	-- {area:450} Remtravel's Excavation · {npc:10323} Murkdeep
	["{area:450} lies on the coast south of {npc:10323}'s beach. Protect the prospector while he searches for the fossil."] = "{area:450}在{npc:10323}海滩南边的海岸上。勘察员搜寻化石时保护他。",

	-- Step 34: Auberdine
	["Follow the road north."] = "沿道路向北。",
	-- {quest:87760} Holy Diver · {npc:10219} Gwennyth Bly'Leggonde
	["{quest:87760}: {npc:10219} offers it once all nine beached remains are handed in"] = "{quest:87760}：交齐全部九具搁浅的遗骸后，{npc:10219}会提供这个任务",
	-- {item:15826} Curative Animal Salve
	["She gives you the {item:15826}"] = "她会给你{item:15826}",

	-- Step 35: The naga
	["The naga"] = "纳迦",
	-- {area:443} Ruins of Mathystra · {quest:951} Mathystra Relics
	-- plural, as words: Stormscale Myrmidons = {npc:2181} Stormscale Myrmidon
	["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them, and Stormscale Beastmistresses walk the shore."] = "沿海岸向东北到{area:443}。{quest:951}散落在废墟中；雷鳞侍从、雷鳞巫师和雷鳞战士占据着那里，雷鳞兽王在岸边巡逻。",

	-- Step 36: Back south
	["Back south"] = "返回南方",
	["Hearthstone on cooldown? Follow the coast road back south."] = "炉石在冷却？沿海岸道路返回南方。",
	-- {npc:3616} Onu
	["{npc:3616}, at the Grove"] = "{npc:3616}，在古树之林",

	-- Step 37: Volcor
	-- {npc:3692} Volcor · {area:449} Master's Glaive
	["{npc:3692} hides in the hills east of the {area:449}. Help him back to the road; he fights on his way out."] = "{npc:3692}躲在{area:449}东边的山丘上。帮他回到道路上；他会一路战斗出去。",
	-- {npc:12298} Sickly Deer · {item:15826} Curative Animal Salve · {zone:1439} Darkshore
	["{npc:12298}: use the {item:15826} on them; they roam all of {zone:1439}"] = "{npc:12298}：对它们使用{item:15826}；它们在整个{zone:1439}游荡",

	-- Step 38: Auberdine
	-- {npc:3694} Sentinel Selarin · {npc:3691} Raene Wolfrunner · {area:415} Astranaar · {zone:1440} Ashenvale
	["{npc:3694}: for {npc:3691} in {area:415}, on the later {zone:1440} leg"] = "{npc:3694}：交给{area:415}的{npc:3691}，在之后的{zone:1440}阶段",
	-- {npc:3649} Thundris Windweaver · {npc:1646} Baros Alexston · {zone:1453} Stormwind
	["{npc:3649}: for {npc:1646} in {zone:1453}"] = "{npc:3649}：交给{zone:1453}的{npc:1646}",
	-- {zone:1453} Stormwind
	["Boat to {zone:1453}"] = "乘船前往{zone:1453}",

	-- Step 39: The Great Cat Spirit
	-- {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave
	["Night Elves fly from {area:442} to {area:702}; Skyborne take the boat from the {area:442} dock and learn the Rut'theran flight path there. Take the portal up to {npc:4217} in the {area:1658}."] = "暗夜精灵从{area:442}飞往{area:702}；天裔乘{area:442}码头的船前往，并在那里学习鲁瑟兰村的飞行路线。乘传送门上去找{area:1658}的{npc:4217}。",

	-- Step 40: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "施放{spell:18960}。{npc:11802}在{area:2361}；如果还没有那里的飞行路线，就去学习。",
	-- {npc:11802} Dendrite Starblaze
	["{npc:11802}: the welcome from Sheldras"] = "{npc:11802}：沙德拉斯·月树的问候",

	-- Step 41: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "兽穴里的遗物",
	-- {quest:98394} The Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {area:493} Moonglade · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) and the {npc:272054} (Skyborne) wait in southern {area:493}. The three relics lie in the {area:2363}, east of them. Reports from the first weeks say a relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394}（暗夜精灵）和{npc:272054}（天裔）在{area:493}南部等候。三件遗物在它们东边的{area:2363}里。最初几周的报告称：其他玩家正在拾取某件遗物时，你拾取不到东西：稍等片刻再试。",

	-- Step 42: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "返回{npc:11802}处",
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:702} Rut'theran Village · {area:442} Auberdine
	["Back to {npc:11802} in {area:2361}, then fly to {area:702} (by way of {area:442})."] = "返回{area:2361}的{npc:11802}，然后飞往{area:702}（途经{area:442}）。",

	-- Step 43: To Darnassus
	-- {npc:4217} Mathrengyl Bearwalker · {area:442} Auberdine · {zone:1453} Stormwind
	["Take the portal up to {npc:4217}, then fly back to {area:442} for the boat to {zone:1453}."] = "乘传送门上去找{npc:4217}，然后飞回{area:442}乘船前往{zone:1453}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the coast north-east to the {area:443}. {quest:951} lie among the ruins; Stormscale Myrmidons, Sorceresses and Warriors hold them."] = "沿海岸向东北到{area:443}。{quest:951}散落在废墟中；{npc:2181}、雷鳞巫师和雷鳞战士占据着那里。",
	-- ["Follow the coast south past {area:447}: one {quest:4728} lies on the shore west of the Grove, another further south near {area:450}."] = "沿海岸向南经过{area:447}：一只{quest:4728}躺在古树之林西边的岸上，另一只在更南边的{area:450}附近。",
	-- ["Follow the hills north to the {area:456} and up to the falls. Three more beached remains lie on the north shore: near the {area:443}, north of {quest:954} and west of {quest:954}."] = "沿山丘向北到{area:456}，再往上到瀑布。北岸还有三具搁浅的遗骸：在{area:443}附近、{quest:954}北边和{quest:954}西边。",
	-- ["North along the hills. {npc:3650} waits in the ruins of {quest:954}; Wild Grells and Vile Sprites fill them, Deth'ryll Satyrs the eastern edge. {quest:1001} stands by the road west of the ruins."] = "沿山丘向北。{npc:3650}在{quest:954}的废墟中等候；废墟里满是{npc:2190}和{npc:2189}，东缘是{npc:2212}。{quest:1001}立在废墟西边的路旁。",
	-- ["Read both tablets"] = "阅读两块石板",
	-- ["The cave lies south of the falls: Scaber Stalks grow all through it, the {item:5270} at the very back. The {npc:6788} lairs in the hills south of the falls; {object:177624} lies at the satyr camp north of her."] = "洞穴在瀑布南边：整个洞里都长着{item:5271}，{item:5270}在最深处。{npc:6788}的巢穴在瀑布南边的山丘上；{object:177624}在她北边的萨特营地。",
	-- ["Tide Crawlers scuttle along the shore below the village; {quest:983} stands on the beach just south of the docks. Darkshore Threshers swim in the shallows. The {quest:4723} lies on the shore just south of the village."] = "{npc:2232}在村子下方的岸边爬行；{quest:983}立在码头南边的海滩上。{npc:2185}在浅水中游动。{quest:4723}躺在村子南边的岸上。",
	-- ["{item:15883}: the {object:177790} under the water off the north coast, west of the ruins"] = "{item:15883}：在废墟西边、北部海岸外水下的{object:177790}",
	-- ["{npc:10323} camps on the beach west of the glaive: kill the murlocs at the camp fire; he comes in the third wave with his hound. Three beached remains lie on the beaches south of {area:450}."] = "{npc:10323}在主宰之剑西边的海滩上扎营：击杀营火旁的鱼人；他会在第三波带着猎犬出现。{area:450}南边的海滩上还有三具搁浅的遗骸。",
	-- ["{npc:6667} hides on the little island off the ruins; Stormscale Beastmistresses walk the shore. The key pieces drop from Giant Foreststriders (top), Greymist murlocs (middle) and Raging Reef Crawlers (bottom)."] = "{npc:6667}躲在废墟外的小岛上；雷鳞兽王在岸边巡逻。钥匙碎片掉落自{npc:2323}（上段）、灰雾鱼人（中段）和{npc:2236}（下段）。",
	-- ["{quest:1003} stands west of the Grove."] = "{quest:1003}立在古树之林西边。",
}
