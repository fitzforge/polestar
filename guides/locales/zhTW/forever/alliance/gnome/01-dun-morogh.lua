-- Chinese (traditional) (zhTW): the guide forever/alliance/gnome/01-dun-morogh (forever/alliance/gnome/01-dun-morogh.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Sten Stoutarm
	-- {area:77} Anvilmar · {npc:658} Sten Stoutarm
	["You start in front of {area:77}, the stone hall at the north end of the valley. {npc:658} waits outside the door."] = "你從{area:77}前方開始，那是山谷北端的石廳。{npc:658}在門外等候。",

	-- Step 2: Young wolves
	["Young wolves"] = "幼狼",
	-- {area:77} Anvilmar
	["Ragged Young Wolves roam the snow just south of {area:77}."] = "蓬毛幼狼在{area:77}南邊的雪地上遊蕩。",

	-- Step 3: Anvilmar
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}，在{npc:658}旁邊",
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer"] = "{npc:912}，戰士訓練師",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}，盜賊訓練師",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}，牧師訓練師",
	-- {npc:944} Marryk Nurribit · {area:77} Anvilmar
	["{npc:944}, the mage trainer, inside {area:77}"] = "{npc:944}，法師訓練師，在{area:77}裡面",
	-- {npc:460} Alamar Grimm · {area:77} Anvilmar
	["{npc:460}, inside {area:77}"] = "{npc:460}，在{area:77}裡面",
	-- {area:77} Anvilmar
	["Inside {area:77}"] = "{area:77}裡面",

	-- Step 4: The troggs
	["The troggs"] = "穴居人",
	-- {area:77} Anvilmar
	-- plural, as words: Rockjaw Troggs = {npc:707} Rockjaw Trogg · Burly Rockjaw Troggs = {npc:724} Burly Rockjaw Trogg
	["Rockjaw Troggs and Burly Rockjaw Troggs dig all over the valley floor south of {area:77}."] = "石齶穴居人和壯實的石齶怪在{area:77}南邊的谷地各處挖掘。",

	-- Step 5: Back to Anvilmar
	-- {area:77} Anvilmar
	["Back to {area:77}"] = "返回{area:77}",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}; inside"] = "",

	-- Step 6: Talin Keeneye
	-- {npc:714} Talin Keeneye · {item:10438} Felix's Box
	["{npc:714}'s camp is at the west end of the valley. {item:10438} lies in the snow south of it, his Chest by the troll cave and his Bucket of Bolts east of the cave: grab them as you pass."] = "{npc:714}的營地在山谷西端。{item:10438}在營地南邊的雪地上，他的箱子在食人妖洞穴旁，他的螺栓桶在洞穴東邊：經過時順手拿取。",

	-- Step 7: The boars
	["The boars"] = "野豬",
	-- {npc:714} Talin Keeneye
	-- plural, as words: Small Crag Boars = {npc:708} Small Crag Boar
	["Small Crag Boars graze around {npc:714}'s camp and along the west side of the valley."] = "小型峭壁野豬在{npc:714}的營地周圍和山谷西側覓食。",

	-- Step 9: Grelin Whitebeard
	-- {npc:786} Grelin Whitebeard · {npc:12738} Nori Pridedrift
	["{npc:786} and {npc:12738} camp at the south-west edge of the valley, below the troll cave."] = "{npc:786}和{npc:12738}在山谷西南邊緣、食人妖洞穴下方紮營。",

	-- Step 10: Coldridge Valley: kill these as you meet them
	-- {area:132} Coldridge Valley
	["{area:132}: kill these as you meet them"] = "",
	-- {npc:786} Grelin Whitebeard
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Frostmane Troll Whelps fill the slopes south and east of {npc:786}'s camp."] = "小霜鬃食人妖遍布{npc:786}營地南邊和東邊的山坡。",
	-- plural, as words: Feather Charms = {item:6753} Feather Charm · Frostmane Novices = {npc:946} Frostmane Novice
	["Feather Charms, from the Frostmane Novices"] = "羽毛符咒，來自霜鬃食人妖新兵",

	-- Step 11: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift · {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:12738}: timed, five minutes to reach {npc:836} in {area:77}"] = "{npc:12738}：限時任務，五分鐘內抵達{area:77}的{npc:836}處",

	-- Step 12: Anvilmar
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["The Scalding Mornbrew lasts five minutes: go straight north to {npc:836} inside {area:77}."] = "熱酒只能維持五分鐘：直接向北前往{area:77}裡的{npc:836}。",
	-- {npc:836} Durnan Furcutter · {area:77} Anvilmar
	["{npc:836}, inside {area:77}; below ground"] = "",
	["Level 4 spells, before Gozwin's camp"] = "4級法術，在前往戈茲溫的營地之前學習",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}，在{area:77}裡面",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out; inside"] = "",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756}和{npc:8416}一起站在{area:77}門口。戈茲溫的營地就在西北方的山丘上；{npc:269075}在營地周圍徘徊。",
	-- {npc:2756} Grund Drokda
	["{npc:2756}, inside"] = "",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}，在營地裡",
	["The troll cave"] = "食人妖洞穴",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808}在{npc:786}營地東邊的食人妖洞穴裡，不在洞穴上方的山丘上：從洞口進去，沿著隧道走到最深處。",
	-- {item:2004} Grelin Whitebeard's Journal
	["{item:2004}; below ground"] = "",

	-- Step 15: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}，在他旁邊",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "冰爪熊墜飾，來自營地上方山坡上的小霜鬃食人妖",

	-- Step 16: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "回到{area:77}的{npc:257446}處。他會給你{item:6635}：沿著山谷南邊有碎石標記、向西攀升的小路走到山脊上的靈石，在旁邊喝下靈契並與{npc:5891}交談，然後把牠的{item:6656}帶回給他。",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}，在靈石旁邊",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}：{npc:5873}和你的{item:5175}",

	-- Step 17: The tunnel
	["The tunnel"] = "隧道",
	-- {npc:1965} Mountaineer Thalos · {area:77} Anvilmar · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965}守衛著{area:77}東邊通往山谷外的隧道；{npc:6782}站在隧道口他的身旁。",

	-- Step 18: The Great Outdoors
	["Sit by Eric's campfire (type /sit) and wait for the buff."] = "",

	-- Step 19: Kharanos
	-- {area:131} Kharanos · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1872} Tharek Blackstone · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["Follow the road through the tunnel and north-east to {area:131}. Start outside: {npc:1252} and Eric's campfire are in front of the {area:2102}.\n{npc:1872} works the forge west of the distillery.\nThen go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "",
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, below ground"] = "",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, inside"] = "",
	-- {npc:1226} Maxan Anvol
	["{npc:1226}, upstairs"] = "",
	["Last: some classes' trainers stand outside"] = "",

	-- Step 20: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "沿著道路從{area:131}向東北前往{zone:1455}道路下方的補給站。",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "",

	-- Step 21: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}."] = "",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}：{object:176785}",

	-- Step 22: Mountaineer Gretchen
	-- {area:136} Grizzled Den · {area:131} Kharanos
	["Gretchen camps just outside the {area:136}, the wendigo cave south-west of {area:131}."] = "",

	-- Step 23: The Grizzled Den
	-- {npc:278166} Mountaineer Cornelius
	["Flintfire's shipments lie on the cave floor, and {npc:278166} is missing somewhere inside.\nCareful: Wendigos stand close together inside the cave, so fights easily pull several at once; drawing them out one at a time with ranged attacks from outside avoids this."] = "",

	-- Step 25: Rumbleshot's Ammo
	-- {npc:1243} Hegnar Rumbleshot
	["{npc:1243} camps south-west of it, by the road to Coldridge."] = "",

	-- Step 26: Dun Morogh: kill these as you meet them
	-- {zone:1426} Dun Morogh
	["{zone:1426}: kill these as you meet them"] = "",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields from Rumbleshot's camp north-east to {area:131} and the depot: kill them on the walk back."] = "",

	-- Step 27: Kharanos
	-- {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1241} Tognus Flintfire
	["{npc:1252} stands by Eric's campfire in front of the {area:2102}; {npc:1241} is in the cellar west of it."] = "",

	-- Step 28: Thunderbrew Distillery
	-- {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}; upstairs"] = "",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it; below ground"] = "",
	["Upstairs"] = "",

	-- Step 29: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131}與補給站",
	-- {npc:1269} Razzle Sprysprocket · {area:131} Kharanos
	["The pilots stand at the depot; {npc:1269} is on the road back west, north of {area:131}."] = "",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, beside him"] = "",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, on the way back; below ground"] = "",

	-- Step 30: Brewnall Village
	-- {area:137} Brewnall Village · {area:131} Kharanos · {npc:8508} Gretta Ganter · {npc:1374} Rejold Barleybrew · {npc:1375} Marleth Barleybrew
	["{area:137} sits on the lake west of {area:131}. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "",
	-- {npc:8508} Gretta Ganter
	["{npc:8508}, on the dock"] = "",
	-- {npc:1196} Ice Claw Bear
	["{npc:1196}, on the way to the Hold"] = "",
	-- {npc:1127} Elder Crag Boar
	["{npc:1127}, on the way"] = "",
	-- {npc:1201} Snow Leopard
	["{npc:1201}, on the way"] = "",

	-- Step 31: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village · {npc:1374} Rejold Barleybrew
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["{area:135} is the troll cave in the hills south-west of {area:137}. Ice Claw Bears, Elder Crag Boars and Snow Leopards you kill on the way count for {npc:1374}. Kill Headhunters at its mouth and walk through to its far end."] = "",
	-- {npc:1123} Frostmane Headhunter
	["{npc:1123}, below ground"] = "",

	-- Step 32: Gnomeregan: kill these as you meet them
	-- {area:133} Gnomeregan
	["{area:133}: kill these as you meet them"] = "",
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "烈酒村和{area:133}道路周圍的麻瘋地精身上帶著齒輪和零件。冰爪熊、老峭壁野豬和雪豹在湖周圍的山丘上遊蕩。",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083}：麻瘋地精",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084}：麻瘋地精",

	-- Step 35: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "",
	-- {npc:1252} Senir Whitebeard · {npc:1274} Senator Barin Redstone · {zone:1455} Ironforge
	["{npc:1252}: {npc:1274} in {zone:1455} takes it"] = "",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery; upstairs"] = "",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "地下室的{object:269}",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel; below ground"] = "",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery; below ground"] = "",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, below ground"] = "",

	-- Step 36: Shimmerweed
	-- {item:2676} Shimmerweed · {area:802} Shimmer Ridge · {area:131} Kharanos
	-- plural, as words: Frostmane Seers = {npc:1397} Frostmane Seer
	["The {item:2676} grows in baskets up on {area:802}, the snowy slope north of the road between {area:131} and Brewnall: climb from the road west of {area:131}. The Frostmane Seers camped on the ridge drop it too."] = "",

	-- Step 38: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {area:131} Kharanos · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of the road back east from Brewnall to {area:131}. His meats are in the locker in {npc:1271}'s cave, east of his camp. {npc:1271} is an elite yeti: wait out of sight until he wanders off on his patrol, then take the meats and leave before he comes back. You don't need to fight him."] = "",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker; below ground"] = "",

	-- Step 39: Kharanos
	-- {area:131} Kharanos
	["Back east through {area:131}: the class quests here wait for level 10."] = "",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}：由南門旁的{npc:257597}接收",
	-- {npc:1226} Maxan Anvol · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226}：由{zone:1455}的{npc:258785}接收",

	-- Step 40: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1426} Dun Morogh
	["Follow the road north-east from {area:131} to the depot: the whole east of {zone:1426} is one sweep from here."] = "",

	-- Step 41: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "沿著道路向東經過補給站，前往{area:138}。",

	-- Step 42: Firewood
	["Firewood"] = "木柴",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "木柴散落在避難所旁結冰湖泊周圍的雪地上。",

	-- Step 44: Minor Ice Elemental on the way
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003} on the way"] = "",
	-- {npc:276003} Minor Ice Elemental · {npc:1253} Father Gavin
	["{npc:276003} along the way to {npc:1253}"] = "",

	-- Step 45: Misty Pine Refuge: kill these as you meet them
	-- {area:138} Misty Pine Refuge
	["{area:138}: kill these as you meet them"] = "",
	-- {quest:99160} Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["The three rifles lie in the snow around the frozen lake by the refuge. Minor Ice Elementals drift around the lake and along the way: kill them as you go for {quest:99160}.\nFinish off the Minor Ice Elementals around the small lake just west of the refuge if you are still short."] = "",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, around the small lake"] = "",

	-- Step 47: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325}在結冰湖泊旁，位於冰元素之間。",

	-- Step 52: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "法森在{area:134}西邊俯瞰採掘場的山脊上紮營。與他交談以獲得他的遠視。",

	-- Step 55: Gol'Bolar Quarry
	["The quarry lies just east of Farsen's ridge."] = "",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}，在採掘場裡",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}：僅限鐵匠",

	-- Step 56: The quarry troggs
	["The quarry troggs"] = "採掘場的穴居人",
	-- {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper
	["Rockjaw Skullthumpers, Bonesnappers and Ambushers share the quarry and the slopes north of it; the Ambushers drop the {item:268548}."] = "",

	-- Step 58: Helm's Bed Lake
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Dark Iron Spies sneak around the lake shore east of the quarry; one of them drops the {item:274268}."] = "",

	-- Step 59: Dun Morogh: kill these as you meet them
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "雪豹和野豬在牧場與採掘場之間的雪地上遊蕩。鐵匠：銅錠可以熔煉{item:2770}取得，或向商業用品商人購買。",

	-- Step 62: Protecting the Herd
	-- {npc:1388} Vagash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: most classes solo it at level 14, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",
	["Below ground"] = "",

	-- Step 63: Rudra Amberstill
	-- {zone:1455} Ironforge
	["On the road back west to {zone:1455}."] = "",

	-- Step 66: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "",

	-- Step 67: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597}在{area:806}西北方農場上方的洞穴裡等候；上山的小路從農場後方開始。",

	-- Step 69: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "",

	-- Step 70: Fire Tar and the Reagent Pouch
	-- {item:5026} Fire Tar · {item:6652} Reagent Pouch
	["{item:5026} and the {item:6652}"] = "{item:5026}和{item:6652}",
	-- {area:923} Stonesplinter Valley · {npc:257808} Braldir Ashmantle · {area:149} Silver Stream Mine
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer · Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "碎石怪先知（13級）站在{npc:257808}營地南邊、{area:923}南部的穴居人之間；坑道鼠地卜師（12級）在湖北端的{area:149}工作。穴居人成群出現，有些會從遠處投擲：一次拉一隻。",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652}：碎石怪先知",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026}：坑道鼠地卜師",

	-- Step 71: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "火焰靈石",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808}會給你{item:6636}。爬上營地上方的山峰，在靈石旁喝下靈契並擊敗{npc:5893}，然後把牠的{item:6655}放進永恆之火神殿頂端的{object:61934}。",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}，在靈石旁邊",

	-- Step 72: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "返回{npc:257597}",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "穿過隧道回到農場上方{npc:257597}的洞穴。",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 73: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}, north of the South Gate; the dwarven corpse lies up the pass to the west of him."] = "",

	-- Step 74: The tunnel post
	["The tunnel post"] = "",
	-- {zone:1432} Loch Modan · {npc:1089} Mountaineer Cobbleflint · {npc:1092} Captain Rugelfuss
	["East through the South Gate tunnel into {zone:1432}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "",

	-- Step 75: Stonesplinter troggs
	["Stonesplinter troggs"] = "",
	["North of the post, west of the road: the Stonesplinter troggs and scouts camp in the hills. Both drop the Trogg Stone Teeth."] = "",

	-- Step 76: Back to the tunnel post
	["Back to the tunnel post"] = "",

	-- Step 77: Thelsamar
	-- {area:144} Thelsamar · {npc:1340} Mountaineer Kadrell · {npc:1963} Vidra Hearthstove · {area:2101} Stoutlager Inn · {npc:1681} Brock Stoneseeker · {npc:1572} Thorgrum Borrelson
	["North up the road to {area:144}. {npc:1340} walks the road through town, {npc:1963} stands outside the {area:2101}, {npc:1681} on the east side of town; {npc:1572} keeps the gryphons."] = "",
	-- {npc:1572} Thorgrum Borrelson
	["{npc:1572}, the gryphon master"] = "",
	-- {npc:1572} Thorgrum Borrelson · {npc:4256} Golnir Bouldertoe · {zone:1455} Ironforge
	["{npc:1572}: for {npc:4256} in {zone:1455}"] = "",

	-- Step 78: The west hills and the Algaz Station
	-- {area:925} Algaz Station
	["The west hills and the {area:925}"] = "",
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear · Mountain Boars = {npc:1190} Mountain Boar · Forest Lurkers = {npc:1195} Forest Lurker
	["North through the hills west of the road to {npc:1343} at the {area:925}. The Tunnel Rat kobolds dig in the hills on the way; Elder Black Bears, Mountain Boars and Forest Lurkers roam the same ground."] = "",
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

	-- Step 79: Silver Stream Mine
	["East along the hills to the mine at the north end of the loch: the Miners' League crates sit in its tunnels, among more Tunnel Rats."] = "",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates"] = "",

	-- Step 80: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "",

	-- Step 81: Thelsamar
	-- {area:144} Thelsamar
	["South down the road to {area:144}, finishing the ears, meat and ichor on the way."] = "",

	-- Step 82: Golnir Bouldertoe
	-- {object:32372} Great Forge · {npc:4256} Golnir Bouldertoe · {npc:1573} Gryth Thurden
	["The gryphons land in the {object:32372}: {npc:4256} works at its north end, and {npc:1573} keeps the gryphons where you landed."] = "",
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge
	["{npc:4256}, in the {object:32372}"] = "",
	-- {npc:1573} Gryth Thurden
	["{npc:1573}, the gryphon master where you landed"] = "",

	-- Step 83: Tinker Town
	-- {object:32372} Great Forge · {object:171524} Tinker Town · {object:660964} Misplaced Packages · {object:32383} Forlorn Cavern · {object:32362} Mystic Ward · {object:171709} High Seat · {object:32359} Military Ward
	["East from the {object:32372} into {object:171524}: the {object:660964} lie by its mailbox. From here the guide goes once round the city: north to the {object:32383}, west to the {object:32362}, south through the Commons to the {object:171709}, east through the {object:32359} and back to {object:171524} for the tram."] = "",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}，在{object:171524}的郵箱旁",

	-- Step 84: Forlorn Cavern
	-- {object:32372} Great Forge · {npc:258098} Eldrun Stormbreaker · {object:32383} Forlorn Cavern · {npc:6120} Lago Blackwrench
	["North of the {object:32372}: {npc:258098}, the shaman trainer, stands at the south end of the {object:32383}, the rogue and warlock trainers and {npc:6120} just north of him."] = "",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}：由{zone:1453}的{npc:6122}接收",

	-- Step 85: The Tome of Divinity
	-- {item:6775} Tome of Divinity
	["The {item:6775}"] = "",
	-- {object:32383} Forlorn Cavern · {object:32362} Mystic Ward · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["West from the {object:32383} into the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, Tiza and Muiredon on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "",

	-- Step 86: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Head back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "",

	-- Step 88: Mystic Ward
	-- {object:32386} Hall of Mysteries · {object:32362} Mystic Ward
	["The paladin, priest and mage trainers are in the {object:32386}, in the {object:32362}."] = "",

	-- Step 89: High Seat
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["South through the Commons: {npc:1274} stands in the {object:171709} with King Magni."] = "",
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["{npc:1274}, in the {object:171709} with King Magni"] = "",

	-- Step 90: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 91: Military Ward
	-- {object:32359} Military Ward · {npc:11865} Buliwyf Stonehand · {object:32390} Hall of Arms
	["East to the {object:32359}: the warrior trainers and {npc:11865} in the {object:32390}, the hunter trainers beside it."] = "",

	-- Step 92: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 93: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 94: Druid trainer
	["Druid trainer"] = "",
	-- {npc:5505} Theridran · {zone:1453} Stormwind · {zone:1426} Dun Morogh
	["{npc:5505} in {zone:1453}; {zone:1426} has no druid trainer"] = "",

	-- Step 95: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {object:171524} Tinker Town · {area:2257} Deeprun Tram · {zone:1453} Stormwind
	["East back into {object:171524}: the {area:2257} leaves from its east end. Ride it to {zone:1453}."] = "",

	-- Step 96: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {npc:12997} Monty · {item:17117} Rat Catcher's Flute · {npc:13018} Nipsy · {zone:1453} Stormwind
	-- plural, as words: Deeprun Rats = {npc:13016} Deeprun Rat
	["On the {zone:1455} platform of the {area:2257}, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end."] = "",
	-- {npc:12997} Monty · {zone:1455} Ironforge
	["{npc:12997}, on the {zone:1455} platform"] = "",
	-- {npc:13016} Deeprun Rat · {item:17117} Rat Catcher's Flute
	["{npc:13016}: use the {item:17117}"] = "",
	-- {npc:13016} Deeprun Rat
	["Catch {npc:13016}"] = "",

	-- Step 97: Nipsy
	-- {zone:1453} Stormwind · {npc:13018} Nipsy · {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Ride the tram to {zone:1453}: {npc:13018} waits on the {zone:1453} platform. {npc:5413} stands in the {object:28027}, just outside the tram."] = "",
	-- {npc:13018} Nipsy · {zone:1453} Stormwind
	["{npc:13018}, on the {zone:1453} platform"] = "",

	-- Step 98: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {zone:1436} Westfall · {object:2096} Trade District
	["From the {object:28027} south-west to {object:2098}: {npc:1646}'s compass is in his old house in {zone:1436}, on the way. The flight master and the {object:2096} are south of the square."] = "",

	-- Step 99: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 100: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "",

	-- Step 101: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "",

	-- Step 102: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "",

	-- Step 103: Defensive Stance
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "",

	-- Step 104: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "",

	-- Step 105: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122}在{object:2101}的{object:2164}地下室等候。",

	-- Step 106: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "",

	-- Step 107: Surena Caledon
	-- {zone:1453} Stormwind · {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "從正門離開{zone:1453}，向南前往{area:87}，再沿著道路向東前往{area:62}。{npc:881}（9級）站在農舍旁。",

	-- Step 108: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {area:87} Goldshire · {zone:1436} Westfall
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {area:87} and east Elwynn are next, then {zone:1436}."] = "",
	["Subdue the voidwalker"] = "制服虛空行者",

	-- Step 109: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497}站在{object:2101}的法師塔裡；她會給你一個裝{quest:1861}瀑布水的瓶子。",

	-- Step 110: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "從正門離開{zone:1453}。{quest:1861}瀑布在城門西南方，位於往西前往{zone:1436}的路上：在瀑布底部裝滿{item:7207}。",

	-- Step 111: Goldshire
	-- {zone:1453} Stormwind · {area:87} Goldshire · {zone:1436} Westfall
	["Leave {zone:1453} by the main gate and follow the road south to {area:87}: east Elwynn comes before {zone:1436}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "峭壁野豬和小黑熊在{area:131}和補給站周圍的原野上遊蕩。",
	-- ["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "沿著道路上到{zone:1455}，向你的職業訓練師學習。{area:2257}從城市東邊的{object:171524}出發。搭乘它前往{zone:1453}。",
	-- ["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "石齶擊顱者遍布採掘場；{area:212}旁的石齶伏擊者會掉落{item:268548}。",
	-- ["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "地鐵抵達{object:28027}。{npc:5480}在{object:2100}訓練戰士；{npc:6089}和{npc:6090}一起站在那裡的{object:2152}旁。{npc:6090}會為了他的杯子和你打一架。",
	-- ["{npc:1377}, at the depot"] = "{npc:1377}，在補給站",
	-- ["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}，薩滿訓練師，在{object:32372}北邊",
	-- ["{zone:1455} class quests"] = "{zone:1455}職業任務",
}
