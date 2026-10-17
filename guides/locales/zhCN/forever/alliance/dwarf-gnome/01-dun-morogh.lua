-- Chinese (simplified) (zhCN): the guide forever/alliance/dwarf-gnome/01-dun-morogh (forever/alliance/dwarf-gnome/01-dun-morogh.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sten Stoutarm
	-- {area:77} Anvilmar · {npc:658} Sten Stoutarm
	["You start in front of {area:77}, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "你从{area:77}前方出发，那是山谷北端的石厅。{npc:658}在门外等候。",

	-- Step 2: Young wolves
	["Young wolves"] = "幼狼",
	-- {area:77} Anvilmar
	["Ragged Young Wolves roam the snow just south of {area:77}."] = "蓬毛幼狼在{area:77}南边的雪地里游荡。",

	-- Step 3: Anvilmar
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer"] = "{npc:912}，战士训练师",
	-- {npc:926} Bromos Grummner
	["{npc:926}, the paladin trainer"] = "{npc:926}，圣骑士训练师",
	-- {npc:658} Sten Stoutarm · {npc:895} Thorgas Grimson
	["{npc:658}: a rune for {npc:895}"] = "{npc:658}：交给{npc:895}的符文",
	-- {npc:895} Thorgas Grimson
	["{npc:895}, the hunter trainer"] = "{npc:895}，猎人训练师",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}，潜行者训练师",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}，牧师训练师",
	-- {npc:658} Sten Stoutarm · {quest:98581} Archaic Rune
	["{npc:658}: read the {quest:98581}"] = "{npc:658}：阅读{quest:98581}",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}，在{area:77}里面",
	-- {npc:944} Marryk Nurribit · {area:77} Anvilmar
	["{npc:944}, the mage trainer, inside {area:77}"] = "{npc:944}，法师训练师，在{area:77}里面",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}，在{area:77}里面",
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}，在{npc:658}旁边",
	-- {area:77} Anvilmar
	["Inside {area:77}"] = "在{area:77}里面",

	-- Step 4: The troggs
	["The troggs"] = "穴居人",
	-- {area:77} Anvilmar
	-- plural, as words: Rockjaw Troggs = {npc:707} Rockjaw Trogg · Burly Rockjaw Troggs = {npc:724} Burly Rockjaw Trogg
	["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of {area:77}."] = "{npc:707}和{npc:724}在{area:77}南边的谷底到处挖掘。",

	-- Step 5: Back to Anvilmar
	-- {area:77} Anvilmar
	["Back to {area:77}"] = "返回{area:77}",
	["A few more troggs outside if you are short"] = "如果还不够，就在外面再杀几个穴居人",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}"] = "{npc:8416}，在{area:77}门口",

	-- Step 6: Talin Keeneye
	-- {npc:714} Talin Keeneye · {item:10438} Felix's Box
	["{npc:714}'s camp is at the west end of the valley. {item:10438} lies in the snow south of it, his Chest by the troll cave and his Bucket of Bolts east of the cave: grab them as you pass."] = "{npc:714}的营地在山谷西端。{item:10438}在营地南边的雪地里，菲利克斯的箱子在巨魔洞穴旁，菲利克斯的螺钉桶在洞穴东边：路过时拿上。",

	-- Step 7: The boars
	["The boars"] = "野猪",
	-- {npc:714} Talin Keeneye
	-- plural, as words: Small Crag Boars = {npc:708} Small Crag Boar
	["Small Crag Boars graze around {npc:714}'s camp and along the west side of the valley."] = "{npc:708}在{npc:714}的营地周围和山谷西侧吃草。",

	-- Step 9: Grelin Whitebeard
	-- {npc:786} Grelin Whitebeard · {npc:12738} Nori Pridedrift
	["{npc:786} and {npc:12738} camp at the south-west edge of the valley, below the troll cave."] = "{npc:786}和{npc:12738}在山谷西南边缘、巨魔洞穴下方扎营。",
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["A few Frostmane Troll Whelps if you are short"] = "如果还不够，再杀几只{npc:706}",

	-- Step 10: The troll cave
	["The troll cave"] = "巨魔洞穴",
	-- {npc:786} Grelin Whitebeard
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Frostmane Troll Whelps fill the slopes south and east of {npc:786}'s camp."] = "{npc:706}遍布{npc:786}营地南边和东边的山坡。",
	-- plural, as words: Feather Charms = {item:6753} Feather Charm · Frostmane Novices = {npc:946} Frostmane Novice
	["Feather Charms, from the Frostmane Novices"] = "{item:6753}，来自{npc:946}",

	-- Step 11: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift · {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:12738}: timed, five minutes to reach {npc:836} in {area:77}"] = "{npc:12738}：限时任务，五分钟内赶到{area:77}找{npc:836}",

	-- Step 12: Anvilmar
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside {area:77}."] = "德南的热酒只持续五分钟：直接向北到{area:77}里面找{npc:836}。",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:836}, inside {area:77}"] = "{npc:836}，在{area:77}里面",
	["Level 4 spells, before Gozwin's camp"] = "4级法术，在去戈兹温营地之前",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756}站在{area:77}门口的{npc:8416}旁边。戈兹温的营地在西北方不远处的山丘上；{npc:269075}在营地周围潜行。",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}，在营地里",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808}在{npc:786}营地东边的巨魔洞穴里面，不在上方的山丘上：从洞口进去，沿隧道走到最深处。",

	-- Step 15: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}，在他旁边",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "{item:264356}，来自营地上方山坡上的{npc:706}",

	-- Step 16: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "回到{area:77}找{npc:257446}。他会给你{item:6635}：沿着山谷南部向西攀升、标有碎石的小路走到山脊上的灵魂石，在旁边喝下圣水并与{npc:5891}交谈，然后把它的{item:6656}带回给Teo。",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}，在灵魂石旁",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}：{npc:5873}和你的{item:5175}",

	-- Step 17: The tunnel
	["The tunnel"] = "隧道",
	-- {npc:1965} Mountaineer Thalos · {area:77} Anvilmar · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965}守卫着{area:77}东边离开山谷的隧道；{npc:6782}站在隧道口他的旁边。",

	-- Step 18: Kharanos
	-- {area:131} Kharanos · {npc:1267} Ragnar Thunderbrew · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1872} Tharek Blackstone
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Follow the road through the tunnel and north-east to {area:131}. Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. {npc:1252}, Eric and his campfire are outside the {area:2102}. {npc:6806}, {npc:1226} and {npc:1267} are inside. {npc:1872} works the forge."] = "沿道路穿过隧道，向东北到{area:131}。沿途击杀{npc:1125}：在接到{npc:1267}的任务前掉落的排骨也算数。{npc:1252}、艾瑞克和他的营火在{area:2102}外面。{npc:6806}、{npc:1226}和{npc:1267}在里面。{npc:1872}在熔炉旁工作。",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, in the distillery"] = "{npc:6806}，在酒厂里",
	-- {npc:1226} Maxan Anvol · {npc:6806} Tannok Frosthammer
	["{npc:1226}, next to {npc:6806}"] = "{npc:1226}，在{npc:6806}旁边",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}"] = "{item:2894}，来自{npc:1247}",

	-- Step 19: The Great Outdoors
	-- {npc:1699} Gremlock Pilsnor
	["Sit by Eric's campfire (type /sit) and wait for the buff, then {npc:1699} in the distillery teaches you cooking."] = "坐在艾瑞克的营火旁（输入/sit）等待增益效果，然后酒厂里的{npc:1699}会教你烹饪。",
	-- {npc:1699} Gremlock Pilsnor
	["Speak with {npc:1699}"] = "与{npc:1699}交谈",

	-- Step 20: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "沿道路从{area:131}向东北到{zone:1455}道路下方的钢架补给站。",

	-- Step 21: Boars and bears
	["Boars and bears"] = "野猪和熊",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "{npc:1125}和{npc:1128}在{area:131}和补给站周围的田野里游荡。",

	-- Step 24: The Grizzled Den
	-- {quest:313} The Grizzled Den · {area:131} Kharanos
	["{quest:313} is the wendigo cave south-west of {area:131}. Flintfire's shipments lie on the cave floor."] = "{quest:313}是{area:131}西南方的雪怪洞穴。燧火的货物在洞穴地上。",

	-- Step 26: Mountaineer Cornelius
	-- {area:136} Grizzled Den
	["Cornelius is missing in the {area:136}: find him inside, then go back to Gretchen."] = "Cornelius在{area:136}失踪了：在里面找到他，然后回去找Gretchen。",

	-- Step 28: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131}和补给站",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, at the depot"] = "{npc:1377}，在补给站",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, by the depot"] = "{npc:1269}，在补给站旁",

	-- Step 29: Rumbleshot's Ammo
	-- {area:802} Shimmer Ridge · {npc:1243} Hegnar Rumbleshot
	["The ammo crate sits in the Frostmane camp on {area:802}; {npc:1243} camps south of it, by the road to Coldridge."] = "弹药箱在{area:802}的霜鬃营地里；{npc:1243}在它南边、通往寒脊山谷的路旁扎营。",

	-- Step 30: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village
	["{area:135} is the troll cave in the hills west of {area:137}. Kill Headhunters at its mouth and walk through to its far end."] = "{area:135}是{area:137}西边山丘里的巨魔洞穴。击杀洞口的霜鬃猎头者，然后一直走到洞穴尽头。",

	-- Step 31: Brewnall Village
	-- {area:137} Brewnall Village · {area:135} Frostmane Hold
	["{area:137} sits on the lake north-west of {area:135}."] = "{area:137}在{area:135}西北方的湖边。",

	-- Step 32: Gnomes, bears and leopards
	["Gnomes, bears and leopards"] = "侏儒、熊和雪豹",
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "烈酒村和{area:133}道路周围的{npc:1211}带着齿轮。{npc:1196}、{npc:1127}和{npc:1201}在湖周围的山丘上游荡。",

	-- Step 35: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1373}守着酒厂地下室的{item:2686}酒桶。从{npc:1247}处买一杯{item:2686}，点击有人看守的酒桶，然后在{npc:1373}的任务窗口中把酒交给他（没有任务可接）；之后，无人看守的酒桶就能放入{spell:8553}。",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery"] = "{item:2686}，来自酒厂里的{npc:1247}",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "地下室里的{object:269}",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel"] = "{npc:1373}，在酒桶旁",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery"] = "酒厂里的{object:270}",

	-- Step 37: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "沿道路向东经过补给站到{area:138}。",

	-- Step 38: Firewood
	["Firewood"] = "木柴",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "木柴散落在避难所旁结冰湖泊周围的雪地里。",

	-- Step 40: The cold
	["The cold"] = "寒冷",
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["Minor Ice Elementals drift around the frozen lake by the refuge. The three rifles are in the snow around it."] = "{npc:276003}在避难所旁的结冰湖泊周围飘荡。三把步枪在周围的雪地里。",

	-- Step 42: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325}在结冰的湖边，冰元素之间。",

	-- Step 45: Gol'Bolar Quarry
	["The quarry lies south-east of the ranch."] = "采掘场在农场东南方。",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}：仅限铁匠",

	-- Step 46: The quarry troggs
	["The quarry troggs"] = "采掘场的穴居人",
	-- {area:212} Helm's Bed Lake · {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper · Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher
	["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "{npc:1115}遍布采掘场；{area:212}旁的{npc:1116}掉落{item:268548}。",

	-- Step 47: Foreman Stonebrow and Quarrymaster Thesten
	-- {npc:1254} Foreman Stonebrow · {npc:1256} Quarrymaster Thesten
	["{npc:1254} and {npc:1256}"] = "{npc:1254}和{npc:1256}",

	-- Step 48: Stolen Blasting Powder
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}."] = "采掘场北边{area:212}旁的{npc:1116}和更东边的{npc:1118}掉落{quest:95214}。",

	-- Step 49: Leopards and boars
	["Leopards and boars"] = "雪豹和野猪",
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Blacksmiths = {area:3421} Blacksmith · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "{npc:1201}和野猪在农场与采掘场之间的雪地里游荡。铁匠：{item:2840}可以通过熔炼{item:2770}获得，或从商人处购买。",

	-- Step 52: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960}在{area:808}等候；矮人的尸体在他西边的山口上。",

	-- Step 53: Hearth to Kharanos
	-- {area:131} Kharanos
	["Hearth to {area:131}"] = "用炉石返回{area:131}",
	-- {npc:1231} Grif Wildheart
	["{npc:1231}, at the smithy"] = "{npc:1231}，在铁匠铺",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}：交给南门旁的{npc:257597}",
	-- {npc:1226} Maxan Anvol · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:1226}: {npc:376} in {zone:1453} takes it"] = "{npc:1226}：交给{zone:1453}的{npc:376}",
	-- {npc:1226} Maxan Anvol · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226}：交给{zone:1455}的{npc:258785}",

	-- Step 54: Taming the Beast
	-- {item:15908} Taming Rod · {area:131} Kharanos
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar · Snow Leopards = {npc:1201} Snow Leopard · Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the {area:131} smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of {area:131}."] = "格瑞夫的每个任务都会给你一根{item:15908}：对他指定的野兽使用，然后把驯兽棒带回{area:131}铁匠铺交给他。{npc:1126}、{npc:1201}和{npc:1196}都在{area:131}南边和东边的田野里游荡。",
	-- {npc:1126} Large Crag Boar · {item:15908} Taming Rod
	["{npc:1126}: tame it with the {item:15908}"] = "{npc:1126}：用{item:15908}驯服它",
	-- {npc:1201} Snow Leopard · {item:15908} Taming Rod
	["{npc:1201}: tame it with the {item:15908}"] = "{npc:1201}：用{item:15908}驯服它",
	-- {npc:1196} Ice Claw Bear · {item:15908} Taming Rod
	["{npc:1196}: tame it with the {item:15908}"] = "{npc:1196}：用{item:15908}驯服它",
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455} takes it"] = "交给{zone:1455}的{npc:10090}",

	-- Step 55: Shimmerweed
	-- {item:2676} Shimmerweed · {area:137} Brewnall Village
	["{item:2676} bushes grow on the hills around {area:137}."] = "{item:2676}生长在{area:137}周围的山丘上。",

	-- Step 58: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "沿道路一直向东到{zone:1432}隧道处的{area:806}。",

	-- Step 59: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597}在{area:806}西北方农场上方的洞穴里等候；上去的小路从农场后面开始。",

	-- Step 60: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "穿过隧道进入{zone:1432}。刚过隧道，道路右侧有一条用石头标记的小路爬上山丘，向北通往{npc:257808}的营地。",

	-- Step 61: Fire Tar and the Reagent Pouch
	-- {item:5026} Fire Tar · {item:6652} Reagent Pouch
	["{item:5026} and the {item:6652}"] = "{item:5026}和{item:6652}",
	-- {area:923} Stonesplinter Valley · {npc:257808} Braldir Ashmantle · {area:149} Silver Stream Mine
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer · Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "{npc:1166}（13级）站在{npc:257808}南边、{area:923}南部的穴居人之间；{npc:1174}（12级）在湖北端的{area:149}工作。穴居人成群出现，有些会远程投掷：一次拉一个。",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652}：{npc:1166}",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026}：{npc:1174}",

	-- Step 62: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "火之灵魂石",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808}会给你{item:6636}。爬到他营地上方的山顶，在灵魂石旁喝下圣水并击败{npc:5893}，然后把它的{item:6655}放进永恒之火神龛顶上的{object:61934}。",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}，在灵魂石旁",

	-- Step 63: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "返回{npc:257597}处",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "穿过隧道回到农场上方{npc:257597}的洞穴。",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 64: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "Farsen在{area:134}西边可俯瞰采掘场的山脊上扎营。与他交谈获得远视。",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}，在采掘场里",

	-- Step 65: Spies and Bonesnappers
	["Spies and Bonesnappers"] = "间谍和断骨者",
	-- {area:212} Helm's Bed Lake · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Bonesnappers = {npc:1117} Rockjaw Bonesnapper
	["Rockjaw Bonesnappers prowl the quarry and {area:212}; Dark Iron Spies sneak around the lake shore. One spy drops the {item:274268}."] = "{npc:1117}在采掘场和{area:212}潜行；黑铁间谍在湖岸周围潜伏。其中一个间谍掉落{item:274268}。",

	-- Step 68: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of Brewnall. His meats are in the locker in {npc:1271}'s cave to the north-east of his camp: grab them and leave quickly."] = "{npc:1266}在烈酒村南边的{area:801}扎营。他的肉在他营地东北方{npc:1271}洞穴里的柜子里：拿到就快跑。",

	-- Step 69: The Tome of Divinity
	-- {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["Follow the road up to {zone:1455} and take the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "沿道路上到{zone:1455}，走{object:32362}：{npc:5149}、{npc:6179}和{npc:6178}在{object:32386}。乞丐{npc:6175}在城里游荡。他要十块{item:2589}：{zone:1426}的穴居人和巨魔会掉落，拍卖行也有卖。",
	-- {quest:2997} Tome of Divinity
	["From the {quest:2997} she gives you"] = "从她给你的{quest:2997}获得",

	-- Step 70: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Ride back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "骑出{zone:1455}，沿道路向东到{area:212}。{npc:6177}死在湖岸边：对他使用{item:6866}。在湖边潜伏的黑铁间谍带着文稿。",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["Use the {item:6866} on {npc:6177}"] = "对{npc:6177}使用{item:6866}",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}：黑铁间谍",

	-- Step 71: Muiredon Battleforge
	-- {npc:6179} Tiza Battleforge
	["{npc:6179}: Redemption"] = "{npc:6179}：救赎",

	-- Step 72: Ironforge class quests
	-- {zone:1455} Ironforge
	["{zone:1455} class quests"] = "{zone:1455}职业任务",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern
	["{npc:10090} is in the {object:32390}, {npc:258785} in the {object:32386}, {npc:6120} in the {object:32383}."] = "{npc:10090}在{object:32390}，{npc:258785}在{object:32386}，{npc:6120}在{object:32383}。",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}：交给{zone:1453}的{npc:6122}",

	-- Step 73: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "沿道路上到{zone:1455}，找你的职业训练师学习。{area:2257}从城市东部的{object:171524}出发。乘它前往{zone:1453}。",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}，在{object:171524}的邮箱旁",
	-- {npc:258098} Eldrun Stormbreaker · {object:32372} Great Forge
	["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}，萨满祭司训练师，在{object:32372}北边",

	-- Step 74: Defensive Stance
	-- {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "地铁到达{object:28027}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。",

	-- Step 75: Desperate Prayer
	-- {npc:376} High Priestess Laurena
	["{npc:376} is in the Cathedral of Light."] = "{npc:376}在光明大教堂。",

	-- Step 76: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122}在{object:2101}的{object:2164}地下室等候。",

	-- Step 77: Surena Caledon
	-- {zone:1453} Stormwind · {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "从正门离开{zone:1453}，向南到{area:87}，再沿道路向东到{area:62}。{npc:881}（9级）站在农舍旁。",

	-- Step 78: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {zone:1436} Westfall · {area:87} Goldshire
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {zone:1436} is next, west of {area:87}."] = "回去找{npc:6122}。在{object:2164}地下室的召唤法阵处使用{item:6928}，击败召唤出的虚空行者。下一站是{area:87}西边的{zone:1436}。",
	["Subdue the voidwalker"] = "制服虚空行者",

	-- Step 79: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497}站在{object:2101}的法师圣殿塔里；她会给你一个瓶子，用于{quest:1861}的瀑布。",

	-- Step 80: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "从正门离开{zone:1453}。{quest:1861}瀑布在城门西南方，就在向西前往{zone:1436}的路上：在瀑布底部装满{item:7207}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Braldir gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of {object:148418}."] = "Braldir会给你{item:6636}。爬到他营地上方的山顶，在灵魂石旁喝下圣水并击败{npc:5893}，然后把它的{item:6655}放进{object:148418}神龛顶上的{object:61934}。",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "从正门离开{zone:1453}，向南到{area:87}，再沿道路向东到{area:62}。{quest:1688}（9级）站在农舍旁。",
}
