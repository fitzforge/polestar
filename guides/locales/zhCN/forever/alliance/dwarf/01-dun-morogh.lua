-- Chinese (simplified) (zhCN): the guide forever/alliance/dwarf/01-dun-morogh (forever/alliance/dwarf/01-dun-morogh.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sten Stoutarm
	-- {npc:658} Sten Stoutarm
	["You start in front of Anvilmar, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "",

	-- Step 2: Young wolves
	["Young wolves"] = "幼狼",
	["Ragged Young Wolves roam the snow just south of Anvilmar."] = "",

	-- Step 3: Anvilmar
	["Anvilmar"] = "",
	-- {npc:658} Sten Stoutarm · {npc:895} Thorgas Grimson
	["{npc:658}: a rune for {npc:895}"] = "{npc:658}：交给{npc:895}的符文",
	-- {npc:658} Sten Stoutarm · {quest:98581} Archaic Rune
	["{npc:658}: read the {quest:98581}"] = "{npc:658}：阅读{quest:98581}",
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}，在{npc:658}旁边",
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer; inside"] = "",
	-- {npc:926} Bromos Grummner
	["{npc:926}, the paladin trainer"] = "{npc:926}，圣骑士训练师",
	-- {npc:895} Thorgas Grimson
	["{npc:895}, the hunter trainer"] = "{npc:895}，猎人训练师",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}，潜行者训练师",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}，牧师训练师",
	-- {npc:257446} Teo Hammerstorm
	["{npc:257446}, inside Anvilmar"] = "",
	["Inside Anvilmar"] = "",
	-- {npc:460} Alamar Grimm
	["{npc:460}, inside Anvilmar"] = "",

	-- Step 4: The troggs
	["The troggs"] = "穴居人",
	-- plural, as words: Rockjaw Troggs = {npc:707} Rockjaw Trogg · Burly Rockjaw Troggs = {npc:724} Burly Rockjaw Trogg
	["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of Anvilmar."] = "",

	-- Step 5: Back to Anvilmar
	["Back to Anvilmar"] = "",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, by the door of Anvilmar; inside"] = "",

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

	-- Step 10: Coldridge Valley: kill these as you meet them
	["Coldridge Valley: kill these as you meet them"] = "",
	-- {npc:786} Grelin Whitebeard
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Frostmane Troll Whelps fill the slopes south and east of {npc:786}'s camp."] = "{npc:706}遍布{npc:786}营地南边和东边的山坡。",
	-- plural, as words: Feather Charms = {item:6753} Feather Charm · Frostmane Novices = {npc:946} Frostmane Novice
	["Feather Charms, from the Frostmane Novices"] = "{item:6753}，来自{npc:946}",

	-- Step 11: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift · {npc:836} Durnan Furcutter
	["{npc:12738}: timed, five minutes to reach {npc:836} in Anvilmar"] = "",

	-- Step 12: Anvilmar
	-- {npc:836} Durnan Furcutter
	["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside Anvilmar."] = "",
	-- {npc:836} Durnan Furcutter
	["{npc:836}, inside Anvilmar; below ground"] = "",
	["Level 4 spells, before Gozwin's camp"] = "4级法术，在去戈兹温营地之前",
	-- {npc:460} Alamar Grimm
	["{npc:460}: Summon Imp"] = "",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out; inside"] = "",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of Anvilmar. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "",
	-- {npc:2756} Grund Drokda
	["{npc:2756}, inside"] = "",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}，在营地里",
	["The troll cave"] = "巨魔洞穴",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808}在{npc:786}营地东边的巨魔洞穴里面，不在上方的山丘上：从洞口进去，沿隧道走到最深处。",
	-- {item:2004} Grelin Whitebeard's Journal
	["{item:2004}; below ground"] = "",

	-- Step 15: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}，在他旁边",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "{item:264356}，来自营地上方山坡上的{npc:706}",

	-- Step 16: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in Anvilmar. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}，在灵魂石旁",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}：{npc:5873}和你的{item:5175}",

	-- Step 17: The tunnel
	["The tunnel"] = "隧道",
	-- {npc:1965} Mountaineer Thalos · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of Anvilmar; {npc:6782} stands beside him at its mouth."] = "",

	-- Step 18: Kharanos
	["Kharanos"] = "",
	-- {npc:1252} Senir Whitebeard
	["Follow the road through the tunnel and north-east to Kharanos. Start outside: {npc:1252} and Eric's campfire are in front of the Thunderbrew Distillery."] = "",

	-- Step 19: The Great Outdoors
	["Sit by Eric's campfire (type /sit) and wait for the buff."] = "坐在艾瑞克的营火旁（输入 /sit），等待获得增益效果。",

	-- Step 20: Kharanos
	-- {npc:1872} Tharek Blackstone · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["{npc:1872} works the forge west of the distillery.\nThen go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "",
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, below ground"] = "",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, inside"] = "",
	-- {npc:1226} Maxan Anvol
	["{npc:1226}, upstairs"] = "",
	["Last: some classes' trainers stand outside"] = "最后处理屋外的职业训练师：部分职业的训练师站在外面",

	-- Step 21: Steelgrill's Depot
	["Steelgrill's Depot"] = "",
	-- {zone:1455} Ironforge
	["Follow the road north-east from Kharanos to the depot below the {zone:1455} road."] = "",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "{npc:1694}，在他旁边",

	-- Step 22: Mountaineer Gretchen
	["Gretchen camps just outside the Grizzled Den, the wendigo cave south-west of Kharanos."] = "",

	-- Step 23: The Grizzled Den
	-- {npc:278166} Mountaineer Cornelius
	["Flintfire's shipments lie on the cave floor, and {npc:278166} is missing somewhere inside.\nCareful: Wendigos stand close together inside the cave, so fights easily pull several at once; drawing them out one at a time with ranged attacks from outside avoids this."] = "弗林特菲尔的货物散落在洞穴地面上，{npc:278166}在洞里某处失踪了。\n小心：洞里的雪人彼此站得很近，战斗时很容易一次引来好几只；在洞外用远程攻击一只一只地引出来就能避免。",

	-- Step 24: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen
	["The {object:176785} sits next to {npc:271546}, south of the Grizzled Den."] = "",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}：{object:176785}",

	-- Step 26: Rumbleshot's Ammo
	-- {npc:1243} Hegnar Rumbleshot
	["{npc:1243} camps south-west of it, by the road to Coldridge."] = "",

	-- Step 27: Dun Morogh: kill these as you meet them
	-- {zone:1426} Dun Morogh
	["{zone:1426}: kill these as you meet them"] = "",
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields from Rumbleshot's camp north-east to Kharanos and the depot: kill them on the walk back."] = "",

	-- Step 28: Kharanos
	-- {npc:1252} Senir Whitebeard · {npc:1241} Tognus Flintfire
	["{npc:1252} stands by Eric's campfire in front of the Thunderbrew Distillery; {npc:1241} is in the cellar west of it."] = "",

	-- Step 29: Thunderbrew Distillery
	["Thunderbrew Distillery"] = "",
	-- {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}; upstairs"] = "",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it; below ground"] = "",
	["Upstairs"] = "",

	-- Step 30: Kharanos and the depot
	["Kharanos and the depot"] = "",
	-- {npc:1269} Razzle Sprysprocket
	["The pilots stand at the depot; {npc:1269} is on the road back west, north of Kharanos."] = "",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, beside him"] = "{npc:1377}，在他旁边",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, on the way back; below ground"] = "{npc:1269}，在回程路上；在地下",

	-- Step 31: Brewnall Village
	["Brewnall Village"] = "",
	-- {npc:8508} Gretta Ganter · {npc:1374} Rejold Barleybrew · {npc:1375} Marleth Barleybrew
	["Brewnall Village sits on the lake west of Kharanos. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "",
	-- {npc:8508} Gretta Ganter
	["{npc:8508}, on the dock"] = "{npc:8508}，在码头上",
	-- {npc:1196} Ice Claw Bear
	["{npc:1196}, on the way to the Hold"] = "{npc:1196}，前往据点的路上顺手击杀",
	-- {npc:1127} Elder Crag Boar
	["{npc:1127}, on the way"] = "{npc:1127}，沿途击杀",
	-- {npc:1201} Snow Leopard
	["{npc:1201}, on the way"] = "{npc:1201}，沿途击杀",

	-- Step 32: Frostmane Hold
	-- {quest:287} Frostmane Hold · {npc:1374} Rejold Barleybrew
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["{quest:287} is the troll cave in the hills south-west of Brewnall Village. Ice Claw Bears, Elder Crag Boars and Snow Leopards you kill on the way count for {npc:1374}. Kill Headhunters at its mouth and walk through to its far end."] = "",
	-- {npc:1123} Frostmane Headhunter
	["{npc:1123}, below ground"] = "",

	-- Step 33: Gnomeregan: kill these as you meet them
	["Gnomeregan: kill these as you meet them"] = "",
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the Gnomeregan road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083}：麻疯侏儒",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084}：麻疯侏儒",

	-- Step 36: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the Barleybrew Scalder."] = "",
	-- {npc:1252} Senir Whitebeard · {npc:1274} Senator Barin Redstone · {zone:1455} Ironforge
	["{npc:1252}: {npc:1274} in {zone:1455} takes it"] = "{npc:1252}：交给{zone:1455}的{npc:1274}",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery; upstairs"] = "",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "地下室里的{object:269}",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel; below ground"] = "",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery; below ground"] = "",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, below ground"] = "",

	-- Step 37: Shimmerweed
	-- {item:2676} Shimmerweed
	-- plural, as words: Frostmane Seers = {npc:1397} Frostmane Seer
	["The {item:2676} grows in baskets up on Shimmer Ridge, the snowy slope north of the road between Kharanos and Brewnall: climb from the road west of Kharanos. The Frostmane Seers camped on the ridge drop it too."] = "",

	-- Step 39: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {npc:1271} Old Icebeard
	["{npc:1266} camps in Chill Breeze Valley, south of the road back east from Brewnall to Kharanos. His meats are in the locker in {npc:1271}'s cave, east of his camp. {npc:1271} is an elite yeti: wait out of sight until he wanders off on his patrol, then take the meats and leave before he comes back. You don't need to fight him."] = "",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker; below ground"] = "",

	-- Step 40: Kharanos
	["Back east through Kharanos: the class quests here wait for level 10."] = "",
	-- {npc:1231} Grif Wildheart
	["{npc:1231}, at the smithy"] = "{npc:1231}，在铁匠铺",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}：交给南门旁的{npc:257597}",
	-- {npc:1226} Maxan Anvol · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:1226}: {npc:376} in {zone:1453} takes it"] = "{npc:1226}：交给{zone:1453}的{npc:376}",

	-- Step 41: Steelgrill's Depot
	-- {zone:1426} Dun Morogh
	["Follow the road north-east from Kharanos to the depot: the whole east of {zone:1426} is one sweep from here."] = "",

	-- Step 42: Misty Pine Refuge
	["Misty Pine Refuge"] = "",
	["Follow the road east past the depot to Misty Pine Refuge."] = "",

	-- Step 43: Firewood
	["Firewood"] = "木柴",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "木柴散落在避难所旁结冰湖泊周围的雪地里。",

	-- Step 45: Minor Ice Elemental on the way
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003} on the way"] = "",
	-- {npc:276003} Minor Ice Elemental · {npc:1253} Father Gavin
	["{npc:276003} along the way to {npc:1253}"] = "",

	-- Step 46: Misty Pine Refuge: kill these as you meet them
	["Misty Pine Refuge: kill these as you meet them"] = "",
	-- {quest:99160} Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["The three rifles lie in the snow around the frozen lake by the refuge. Minor Ice Elementals drift around the lake and along the way: kill them as you go for {quest:99160}.\nFinish off the Minor Ice Elementals around the small lake just west of the refuge if you are still short."] = "",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, around the small lake"] = "{npc:276003}，在小湖周围",

	-- Step 48: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325}在结冰的湖边，冰元素之间。",

	-- Step 51: Taming the Beast
	-- {item:15908} Taming Rod
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar · Snow Leopards = {npc:1201} Snow Leopard · Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the Kharanos smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of Kharanos."] = "",
	-- {npc:1126} Large Crag Boar · {item:15908} Taming Rod
	["{npc:1126}: tame it with the {item:15908}"] = "{npc:1126}：用{item:15908}驯服它",
	-- {npc:1126} Large Crag Boar
	["Tame {npc:1126}"] = "",
	-- {npc:1201} Snow Leopard · {item:15908} Taming Rod
	["{npc:1201}: tame it with the {item:15908}"] = "{npc:1201}：用{item:15908}驯服它",
	-- {npc:1201} Snow Leopard
	["Tame {npc:1201}"] = "",
	-- {npc:1196} Ice Claw Bear · {item:15908} Taming Rod
	["{npc:1196}: tame it with the {item:15908}"] = "{npc:1196}：用{item:15908}驯服它",
	-- {npc:1196} Ice Claw Bear
	["Tame {npc:1196}"] = "",
	["Tame Beast"] = "驯服野兽",
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455} takes it"] = "交给{zone:1455}的{npc:10090}",

	-- Step 54: Earthseer Farsen
	-- {object:149024} Gol'Bolar Quarry (no name in this language: may be words)
	["Farsen camps on the ridge overlooking the {object:149024} from the west. Talk to him for his farsight."] = "",

	-- Step 57: Gol'Bolar Quarry
	["The quarry lies just east of Farsen's ridge."] = "",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}，在采掘场里",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}：仅限铁匠",

	-- Step 58: The quarry troggs
	["The quarry troggs"] = "采掘场的穴居人",
	-- {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper
	["Rockjaw Skullthumpers, Bonesnappers and Ambushers share the quarry and the slopes north of it; the Ambushers drop the {item:268548}."] = "{npc:1115}、石腭碎骨者和石腭伏击者分布在采掘场及其北边的山坡上；伏击者掉落{item:268548}。",

	-- Step 60: Helm's Bed Lake
	["Helm's Bed Lake"] = "",
	-- {quest:95214} Stolen Blasting Powder · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by Helm's Bed Lake, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Dark Iron Spies sneak around the lake shore east of the quarry; one of them drops the {item:274268}."] = "",

	-- Step 61: Dun Morogh: kill these as you meet them
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "{npc:1201}和野猪在农场与采掘场之间的雪地里游荡。铁匠：{item:2840}可以通过熔炼{item:2770}获得，或从商人处购买。",

	-- Step 65: Protecting the Herd
	-- {npc:1388} Vagash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: most classes solo it at level 14, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",
	["Below ground"] = "",

	-- Step 66: Amberstill Ranch
	["Amberstill Ranch"] = "",
	-- {zone:1455} Ironforge
	["On the road back west to {zone:1455}."] = "",

	-- Step 68: South Gate Outpost
	["South Gate Outpost"] = "",
	-- {zone:1432} Loch Modan
	["Follow the road all the way east to the South Gate Outpost at the {zone:1432} tunnel."] = "",

	-- Step 69: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["{npc:257597} waits in a cave above the farm north-west of the South Gate Outpost; the path up starts behind the farm."] = "",

	-- Step 71: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "",

	-- Step 72: Fire Tar and the Reagent Pouch
	-- {item:5026} Fire Tar · {item:6652} Reagent Pouch
	["{item:5026} and the {item:6652}"] = "{item:5026}和{item:6652}",
	-- {npc:257808} Braldir Ashmantle
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer · Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["Stonesplinter Seers (level 13) stand among the troggs in the south of Stonesplinter Valley, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the Silver Stream Mine at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652}：{npc:1166}",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026}：{npc:1174}",

	-- Step 73: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "火之灵魂石",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808}会给你{item:6636}。爬到他营地上方的山顶，在灵魂石旁喝下圣水并击败{npc:5893}，然后把它的{item:6655}放进永恒之火神龛顶上的{object:61934}。",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}，在灵魂石旁",

	-- Step 74: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "返回{npc:257597}处",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "穿过隧道回到农场上方{npc:257597}的洞穴。",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 75: North Gate Outpost
	["North Gate Outpost"] = "",
	-- {npc:1960} Pilot Hammerfoot
	["{npc:1960} waits at the North Gate Outpost, north of the South Gate; the dwarven corpse lies up the pass to the west of him."] = "",

	-- Step 76: The tunnel post
	["The tunnel post"] = "",
	-- {zone:1432} Loch Modan · {npc:1089} Mountaineer Cobbleflint · {npc:1092} Captain Rugelfuss
	["East through the South Gate tunnel into {zone:1432}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "",

	-- Step 77: Stonesplinter troggs
	["Stonesplinter troggs"] = "",
	["North of the post, west of the road: the Stonesplinter troggs and scouts camp in the hills. Both drop the Trogg Stone Teeth."] = "",

	-- Step 78: Back to the tunnel post
	["Back to the tunnel post"] = "",

	-- Step 79: Thelsamar
	["Thelsamar"] = "",
	-- {npc:1340} Mountaineer Kadrell · {npc:1963} Vidra Hearthstove · {npc:1681} Brock Stoneseeker · {npc:1572} Thorgrum Borrelson
	["North up the road to Thelsamar. {npc:1340} walks the road through town, {npc:1963} stands outside the Stoutlager Inn, {npc:1681} on the east side of town; {npc:1572} keeps the gryphons."] = "",
	-- {npc:1572} Thorgrum Borrelson
	["{npc:1572}, the gryphon master"] = "{npc:1572}，狮鹫管理员",
	-- {npc:1572} Thorgrum Borrelson · {npc:4256} Golnir Bouldertoe · {zone:1455} Ironforge
	["{npc:1572}: for {npc:4256} in {zone:1455}"] = "",

	-- Step 80: The west hills and the Algaz Station
	["The west hills and the Algaz Station"] = "",
	-- {npc:1343} Mountaineer Stormpike
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear · Mountain Boars = {npc:1190} Mountain Boar · Forest Lurkers = {npc:1195} Forest Lurker
	["North through the hills west of the road to {npc:1343} at the Algaz Station. The Tunnel Rat kobolds dig in the hills on the way; Elder Black Bears, Mountain Boars and Forest Lurkers roam the same ground."] = "",
	-- {item:3110} Tunnel Rat Ear
	["{item:3110}: Tunnel Rat kobolds"] = "",
	-- {item:3172} Boar Intestines
	-- plural, as words: Mountain Boars = {npc:1190} Mountain Boar
	["{item:3172}: Mountain Boars"] = "",
	-- {item:3173} Bear Meat
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear
	["{item:3173}: Elder Black Bears"] = "",
	-- {item:3174} Spider Ichor
	-- plural, as words: Forest Lurkers = {npc:1195} Forest Lurker
	["{item:3174}: Forest Lurkers"] = "",
	-- {npc:5413} Furen Longbeard · {zone:1453} Stormwind
	["{npc:5413} in {zone:1453} takes it"] = "",

	-- Step 81: Silver Stream Mine
	["Silver Stream Mine"] = "",
	["East along the hills to the mine at the north end of the loch: the Miners' League crates sit in its tunnels, among more Tunnel Rats."] = "",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates"] = "",

	-- Step 82: Back to the Algaz Station
	["Back to the Algaz Station"] = "",

	-- Step 83: Thelsamar
	["South down the road to Thelsamar, finishing the ears, meat and ichor on the way."] = "",

	-- Step 84: Golnir Bouldertoe
	-- {object:32372} Great Forge · {npc:4256} Golnir Bouldertoe · {npc:1573} Gryth Thurden
	["The gryphons land in the {object:32372}: {npc:4256} works at its north end, and {npc:1573} keeps the gryphons where you landed."] = "",
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge
	["{npc:4256}, in the {object:32372}"] = "{npc:4256}，在{object:32372}里",
	-- {npc:1573} Gryth Thurden
	["{npc:1573}, the gryphon master where you landed"] = "{npc:1573}，落地处的狮鹫管理员",

	-- Step 85: Tinker Town
	-- {object:32372} Great Forge · {object:171524} Tinker Town · {object:660964} Misplaced Packages · {object:32383} Forlorn Cavern · {object:32362} Mystic Ward · {object:171709} High Seat · {object:32359} Military Ward
	["East from the {object:32372} into {object:171524}: the {object:660964} lie by its mailbox. From here the guide goes once round the city: north to the {object:32383}, west to the {object:32362}, south through the Commons to the {object:171709}, east through the {object:32359} and back to {object:171524} for the tram."] = "",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}，在{object:171524}的邮箱旁",

	-- Step 86: Forlorn Cavern
	-- {object:32372} Great Forge · {npc:258098} Eldrun Stormbreaker · {object:32383} Forlorn Cavern · {npc:6120} Lago Blackwrench
	["North of the {object:32372}: {npc:258098}, the shaman trainer, stands at the south end of the {object:32383}, the rogue and warlock trainers and {npc:6120} just north of him."] = "",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}：交给{zone:1453}的{npc:6122}",

	-- Step 87: The Tome of Divinity
	-- {object:32383} Forlorn Cavern · {object:32362} Mystic Ward · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["West from the {object:32383} into the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, {npc:6179} and {npc:6178} on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "",
	-- {quest:2997} Tome of Divinity
	["From the {quest:2997} she gives you"] = "从她给你的{quest:2997}获得",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["Use the {item:6866} on {npc:6177}"] = "对{npc:6177}使用{item:6866}",

	-- Step 88: Narm Faulk
	-- {zone:1455} Ironforge · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Head back out of {zone:1455} and east along the road to Helm's Bed Lake. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}：黑铁间谍",

	-- Step 90: Muiredon Battleforge
	-- {npc:6179} Tiza Battleforge
	["{npc:6179}: Redemption"] = "{npc:6179}：救赎",

	-- Step 91: Mystic Ward
	-- {object:32386} Hall of Mysteries · {object:32362} Mystic Ward
	["The paladin, priest and mage trainers are in the {object:32386}, in the {object:32362}."] = "",

	-- Step 92: High Seat
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["South through the Commons: {npc:1274} stands in the {object:171709} with King Magni."] = "",
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["{npc:1274}, in the {object:171709} with King Magni"] = "{npc:1274}，在{object:171709}里，和麦格尼国王在一起",

	-- Step 93: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn Two-Handed Axes from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 94: Military Ward
	-- {object:32359} Military Ward · {npc:11865} Buliwyf Stonehand · {object:32390} Hall of Arms
	["East to the {object:32359}: the warrior trainers and {npc:11865} in the {object:32390}, the hunter trainers beside it."] = "",
	-- {npc:10090} Belia Thundergranite
	["{npc:10090}: Beast Training"] = "",

	-- Step 95: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn Two-Handed Axes from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 96: Buliwyf Stonehand
	-- {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn Two-Handed Maces from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 97: Druid trainer
	["Druid trainer"] = "德鲁伊训练师",
	-- {npc:5505} Theridran · {zone:1453} Stormwind · {zone:1426} Dun Morogh
	["{npc:5505} in {zone:1453}; {zone:1426} has no druid trainer"] = "",

	-- Step 98: The Deeprun Tram
	["The Deeprun Tram"] = "",
	-- {object:171524} Tinker Town · {zone:1453} Stormwind
	["East back into {object:171524}: the Deeprun Tram leaves from its east end. Ride it to {zone:1453}."] = "",
	["Deeprun Tram"] = "",

	-- Step 99: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",
	-- {zone:1455} Ironforge · {npc:12997} Monty · {item:17117} Rat Catcher's Flute · {npc:13018} Nipsy · {zone:1453} Stormwind
	-- plural, as words: Deeprun Rats = {npc:13016} Deeprun Rat
	["On the {zone:1455} platform of the Deeprun Tram, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end."] = "",
	-- {npc:12997} Monty · {zone:1455} Ironforge
	["{npc:12997}, on the {zone:1455} platform"] = "",
	-- {npc:13016} Deeprun Rat · {item:17117} Rat Catcher's Flute
	["{npc:13016}: use the {item:17117}"] = "",

	-- Step 100: Nipsy
	-- {zone:1453} Stormwind · {npc:13018} Nipsy · {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Ride the tram to {zone:1453}: {npc:13018} waits on the {zone:1453} platform. {npc:5413} stands in the {object:28027}, just outside the tram."] = "",
	-- {npc:13018} Nipsy · {zone:1453} Stormwind
	["{npc:13018}, on the {zone:1453} platform"] = "",

	-- Step 101: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {zone:1436} Westfall · {object:2096} Trade District
	["From the {object:28027} south-west to {object:2098}: {npc:1646}'s compass is in his old house in {zone:1436}, on the way. The flight master and the {object:2096} are south of the square."] = "",

	-- Step 102: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飞行管理员",

	-- Step 103: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 104: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "顺便：在{npc:11867}处学习法杖（{object:2096}，10银币）；猎人的近战武器主要看属性，而双手武器属性最多。",

	-- Step 105: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "顺便：在{npc:11867}处学习剑（{object:2096}，10银币）；主手持剑能让潜行者稳定升级。",

	-- Step 106: Defensive Stance
	["Defensive Stance"] = "防御姿态",
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "",
	-- {npc:6089} Harry Burlguard
	["{npc:6089}: Defensive Stance"] = "{npc:6089}：防御姿态",

	-- Step 107: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Two-Handed Swords from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 108: Desperate Prayer
	-- {npc:376} High Priestess Laurena
	["{npc:376} is in the Cathedral of Light."] = "",

	-- Step 109: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "顺便：在{npc:11867}处学习法杖（{object:2096}，10银币）；升级期间，法杖的法术属性比单手武器更多。",

	-- Step 110: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122}在{object:2101}的{object:2164}地下室等候。",

	-- Step 112: Surena Caledon
	-- {zone:1453} Stormwind · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to Goldshire and east along the road to the Brackwell Pumpkin Patch. {npc:881} (level 9) stands by its farmhouse."] = "",

	-- Step 113: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {zone:1436} Westfall
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. Goldshire and east Elwynn are next, then {zone:1436}."] = "",
	["Subdue the voidwalker"] = "制服虚空行者",
	["Summon Voidwalker"] = "",

	-- Step 114: Goldshire
	["Goldshire"] = "",
	-- {zone:1453} Stormwind · {zone:1436} Westfall
	["Leave {zone:1453} by the main gate and follow the road south to Goldshire: east Elwynn comes before {zone:1436}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:77}"] = "返回{area:77}",
	-- ["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "回到{area:77}找{npc:257446}。他会给你{item:6635}：沿着山谷南部向西攀升、标有碎石的小路走到山脊上的灵魂石，在旁边喝下圣水并与{npc:5891}交谈，然后把它的{item:6656}带回给Teo。",
	-- ["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "{npc:1125}和{npc:1128}在{area:131}和补给站周围的田野里游荡。",
	-- ["Crag Boars and Young Black Bears roam the fields from Rumbleshot's camp north-east to {area:131} and the depot: kill them on the walk back."] = "{npc:1125}和{npc:1128}在从隆布沙特的营地往东北到{area:131}和补给站之间的田野里游荡：回程路上击杀它们。",
	-- ["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the {area:131} smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of {area:131}."] = "格瑞夫的每个任务都会给你一根{item:15908}：对他指定的野兽使用，然后把驯兽棒带回{area:131}铁匠铺交给他。{npc:1126}、{npc:1201}和{npc:1196}都在{area:131}南边和东边的田野里游荡。",
	-- ["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "Farsen在{area:134}西边可俯瞰采掘场的山脊上扎营。与他交谈获得远视。",
	-- ["Follow the road east past the depot to {area:138}."] = "沿道路向东经过补给站到{area:138}。",
	-- ["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "沿道路从{area:131}向东北到{zone:1455}道路下方的钢架补给站。",
	-- ["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "沿道路上到{zone:1455}，找你的职业训练师学习。{area:2257}从城市东部的{object:171524}出发。乘它前往{zone:1453}。",
	-- ["From {area:40}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "从{area:40}步行前往{zone:1453}；从{zone:1455}出发的地铁到达{object:28027}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。如果{npc:5480}没有提供{quest:1638}，直接去找{npc:6089}：不需要那个任务他也会给你{quest:1639}。",
	-- ["Gretchen camps just outside the {area:136}, the wendigo cave south-west of {area:131}."] = "这位巡山人在{area:136}外扎营；那是{area:131}西南边的雪怪洞穴。",
	-- ["Inside {area:77}"] = "在{area:77}里面",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "从正门离开{zone:1453}，向南到{area:87}，再沿道路向东到{area:62}。{npc:881}（9级）站在农舍旁。",
	-- ["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "烈酒村和{area:133}道路周围的{npc:1211}带着齿轮。{npc:1196}、{npc:1127}和{npc:1201}在湖周围的山丘上游荡。",
	-- ["Ragged Young Wolves roam the snow just south of {area:77}."] = "蓬毛幼狼在{area:77}南边的雪地里游荡。",
	-- ["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Dark Iron Spies sneak around the lake shore east of the quarry; one of them drops the {item:274268}."] = "采掘场北边{area:212}旁的{npc:1116}和更东边的{npc:1118}掉落{quest:95214}。黑铁间谍在采掘场东边的湖岸附近潜行；其中一个掉落{item:274268}。",
	-- ["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "{npc:1115}遍布采掘场；{area:212}旁的{npc:1116}掉落{item:268548}。",
	-- ["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of {area:77}."] = "{npc:707}和{npc:724}在{area:77}南边的谷底到处挖掘。",
	-- ["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "{npc:1166}（13级）站在{npc:257808}南边、{area:923}南部的穴居人之间；{npc:1174}（12级）在湖北端的{area:149}工作。穴居人成群出现，有些会远程投掷：一次拉一个。",
	-- ["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside {area:77}."] = "德南的热酒只持续五分钟：直接向北到{area:77}里面找{npc:836}。",
	-- ["The pilots stand at the depot; {npc:1269} is on the road back west, north of {area:131}."] = "飞行员们在补给站；{npc:1269}在往西回去的路上，位于{area:131}北边。",
	-- ["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "地铁到达{object:28027}。{npc:5480}在{object:2100}训练战士；{npc:6089}和{npc:6090}一起站在那里的{object:2152}旁。{npc:6090}会为了他的杯子和你打一架。",
	-- ["The {area:2257}"] = "{area:2257}",
	-- ["You start in front of {area:77}, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "你从{area:77}前方出发，那是山谷北端的石厅。{npc:658}在门外等候。",
	-- ["{area:131} and the depot"] = "{area:131}和补给站",
	-- ["{area:135} is the troll cave in the hills south-west of {area:137}. Ice Claw Bears, Elder Crag Boars and Snow Leopards you kill on the way count for {npc:1374}. Kill Headhunters at its mouth and walk through to its far end."] = "{area:135}是{area:137}西南边山丘里的巨魔洞穴。沿途击杀的冰爪熊、老峭壁野猪和雪豹都计入{npc:1374}的任务。先击杀洞口的猎头者，再穿过洞穴走到另一端。",
	-- ["{area:137} sits on the lake west of {area:131}. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "{area:137}位于{area:131}西边的湖畔。先去{npc:8508}所在的码头，再到后面的村子找{npc:1374}和{npc:1375}。",
	-- ["{npc:1127}, on the way"] = "{npc:1127}，沿途击杀",
	-- ["{npc:1201}, on the way"] = "{npc:1201}，沿途击杀",
	-- ["{npc:1252} stands by Eric's campfire in front of the {area:2102}; {npc:1241} is in the cellar west of it."] = "{npc:1252}站在{area:2102}前方埃瑞克的营火旁；{npc:1241}在它西边的地窖里。",
	-- ["{npc:12738}: timed, five minutes to reach {npc:836} in {area:77}"] = "{npc:12738}：限时任务，五分钟内赶到{area:77}找{npc:836}",
	-- ["{npc:1377}, at the depot"] = "{npc:1377}，在补给站",
	-- ["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965}守卫着{area:77}东边离开山谷的隧道；{npc:6782}站在隧道口他的旁边。",
	-- ["{npc:257446}, inside {area:77}"] = "{npc:257446}，在{area:77}里面",
	-- ["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597}在{area:806}西北方农场上方的洞穴里等候；上去的小路从农场后面开始。",
	-- ["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}，萨满祭司训练师，在{object:32372}北边",
	-- ["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756}站在{area:77}门口的{npc:8416}旁边。戈兹温的营地在西北方不远处的山丘上；{npc:269075}在营地周围潜行。",
	-- ["{npc:460}, inside {area:77}"] = "{npc:460}，在{area:77}里面",
	-- ["{npc:5505} in {zone:1453}; {area:1} has no druid trainer"] = "{npc:5505}在{zone:1453}；{area:1}没有德鲁伊训练师",
	-- ["{zone:1455} class quests"] = "{zone:1455}职业任务",
}
