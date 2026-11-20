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
	["{npc:8416}, by the door of {area:77}; inside"] = "{npc:8416}，在{area:77}門口；室內",

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
	["{area:132}: kill these as you meet them"] = "{area:132}：遇到就殺",
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
	["{npc:836}, inside {area:77}; below ground"] = "{npc:836}，在{area:77}內；地下",
	["Level 4 spells"] = "4級法術",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}，在{area:77}裡面",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out; inside"] = "{npc:8416}，在出門處的門口；室內",
	["The troll cave"] = "食人妖洞穴",

	-- Step 13: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808}在{npc:786}營地東邊的食人妖洞穴裡，不在洞穴上方的山丘上：從洞口進去，沿著隧道走到最深處。",
	-- {item:2004} Grelin Whitebeard's Journal
	["{item:2004}; below ground"] = "{item:2004}；地下",

	-- Step 14: Grelin Whitebeard
	-- {npc:12738} Nori Pridedrift
	["{npc:12738}, next to him"] = "{npc:12738}，在他旁邊",
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant · Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["Iceclaw Bear Pendants, from the Frostmane Troll Whelps on the slopes above the camp"] = "冰爪熊墜飾，來自營地上方山坡上的小霜鬃食人妖",

	-- Step 15: Grund and Gozwin
	-- {area:77} Anvilmar · {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {npc:269075} Snow Leopard Prowler
	["Back north to {area:77} on the way to the tunnel: {npc:2756} stands by {npc:8416} at its door. Gozwin's camp is in the hills just north-west; the {npc:269075} (level 6) prowls around it."] = "往隧道途中向北回到{area:77}：{npc:2756}和{npc:8416}一起站在門口。戈茲溫的營地就在西北方的山丘上；{npc:269075}（6級）在營地周圍徘徊。",
	-- {npc:2756} Grund Drokda
	["{npc:2756}, inside"] = "{npc:2756}，室內",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}，在營地裡",

	-- Step 16: Branstock Khalder
	-- {area:77} Anvilmar · {npc:786} Grelin Whitebeard · {npc:837} Branstock Khalder · {npc:1226} Maxan Anvol · {area:131} Kharanos
	["{area:77} is on the way north from {npc:786}'s camp to the tunnel: {npc:837}, the priest trainer inside, sends priests of level 5 to {npc:1226} in {area:131}."] = "{area:77}位於從{npc:786}的營地向北前往隧道的路上：裡面的牧師訓練師{npc:837}會把5級的牧師派往{area:131}的{npc:1226}處。",
	-- {npc:837} Branstock Khalder · {area:77} Anvilmar
	["{npc:837}, inside {area:77}"] = "{npc:837}，在{area:77}裡面",

	-- Step 17: Call of Earth
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["Back to {npc:257446} in {area:77}. He gives you the {item:6635}: take the rubble-marked path that climbs west from the south of the valley to the Spirit Stone on the ridge, drink the Sapta beside it and speak to the {npc:5891}, then bring its {item:6656} back to Teo."] = "回到{area:77}的{npc:257446}處。他會給你{item:6635}：沿著山谷南邊有碎石標記、向西攀升的小路走到山脊上的靈石，在旁邊喝下靈契並與{npc:5891}交談，然後把牠的{item:6656}帶回給他。",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}，在靈石旁邊",
	-- {npc:257446} Teo Hammerstorm · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {npc:5873} and your {item:5175}"] = "{npc:257446}：{npc:5873}和你的{item:5175}",

	-- Step 18: The tunnel
	["The tunnel"] = "隧道",
	-- {npc:1965} Mountaineer Thalos · {area:77} Anvilmar · {npc:6782} Hands Springsprocket
	["{npc:1965} guards the tunnel out of the valley, east of {area:77}; {npc:6782} stands beside him at its mouth."] = "{npc:1965}守衛著{area:77}東邊通往山谷外的隧道；{npc:6782}站在隧道口他的身旁。",

	-- Step 19: The Great Outdoors
	-- {npc:1241} Tognus Flintfire · {skill:129} First Aid · {npc:2326} Thamner Pol · {area:131} Kharanos · {area:189} Steelgrill's Depot
	["Sit by Eric's campfire (type /sit) and wait for the buff. With a profession learned, Eric also offers its Camping 101, which its trainer takes: blacksmithing with {npc:1241} and {skill:129} with {npc:2326} in {area:131}, mining and engineering at {area:189}."] = "坐在艾瑞克的營火旁（輸入 /sit）並等待增益效果。學會專業技能後，艾瑞克也會提供該專業的「露營入門」，由該專業的訓練師接收：鍛造交給{area:131}的{npc:1241}，{skill:129}交給{npc:2326}，採礦和工程學則在{area:189}。",

	-- Step 20: Camping 101: First Aid
	-- {npc:2326} Thamner Pol · {skill:129} First Aid
	["{npc:2326} takes it once your {skill:129} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:129}技能達到20後，{npc:2326}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265813} Eric Brighthammer · {npc:2326} Thamner Pol · {area:2102} Thunderbrew Distillery
	["{npc:265813}: for {npc:2326} in the {area:2102}"] = "{npc:265813}：交給{area:2102}的{npc:2326}",

	-- Step 21: Camping 101: Mining
	-- {npc:5392} Yarr Hammerstone · {skill:186} Mining
	["{npc:5392} takes it once your {skill:186} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:186}技能達到20後，{npc:5392}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265813} Eric Brighthammer · {npc:5392} Yarr Hammerstone · {area:189} Steelgrill's Depot
	["{npc:265813}: for {npc:5392} at {area:189}"] = "{npc:265813}：交給{area:189}的{npc:5392}",

	-- Step 22: Camping 101: Engineering
	-- {npc:1702} Bronk Guzzlegear · {skill:202} Engineering
	["{npc:1702} takes it once your {skill:202} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:202}技能達到20後，{npc:1702}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265813} Eric Brighthammer · {npc:1702} Bronk Guzzlegear · {area:189} Steelgrill's Depot
	["{npc:265813}: for {npc:1702} at {area:189}"] = "{npc:265813}：交給{area:189}的{npc:1702}",

	-- Step 23: Kharanos
	-- {area:131} Kharanos · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1872} Tharek Blackstone · {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["Follow the road through the tunnel and north-east to {area:131}. Start outside: {npc:1252} and Eric's campfire are in front of the {area:2102}.\n{npc:1872} works the forge west of the distillery.\nThen go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "沿路穿過隧道，向東北到{area:131}。從外面開始：{npc:1252}和埃裡克的營火在{area:2102}前面。\n{npc:1872}在釀酒廠西邊的鐵匠鋪幹活。\n然後進去：旅店老闆{npc:6806}、{npc:1226}和{npc:1267}。{npc:1699}的{skill:185}課程要等你帶著肋排回來才教，那時銅幣也夠了。",
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, below ground"] = "{npc:1241}，地下",
	-- {npc:6806} Tannok Frosthammer
	["{npc:6806}, inside"] = "{npc:6806}，室內",
	-- {npc:1226} Maxan Anvol
	["{npc:1226}, upstairs"] = "{npc:1226}，樓上",
	-- {npc:1226} Maxan Anvol · {npc:12427} Mountaineer Dolf · {area:131} Kharanos
	["{npc:1226}: heal {npc:12427} south of {area:131}"] = "{npc:1226}：治療{area:131}南邊的{npc:12427}",
	["Last: some classes' trainers stand outside"] = "最後處理屋外的職業訓練師：部分職業的訓練師站在外面",

	-- Step 24: Camping 101: Blacksmithing
	-- {npc:1241} Tognus Flintfire · {skill:164} Blacksmithing
	["{npc:1241} takes it once your {skill:164} skill is 20: gather or craft until then, the guide carries on meanwhile."] = "你的{skill:164}技能達到20後，{npc:1241}就會接收它：在那之前先採集或製作，指南會同時繼續進行。",
	-- {npc:265813} Eric Brighthammer · {npc:1241} Tognus Flintfire
	["{npc:265813}: for {npc:1241}, in the cellar west of the distillery"] = "{npc:265813}：交給{npc:1241}，在酒廠西邊的地窖裡",

	-- Step 25: Thamner Pol
	["talk to the trainer"] = "與訓練師交談",
	-- {npc:2326} Thamner Pol
	["{npc:2326}, inside the distillery"] = "{npc:2326}，在酒廠裡面",

	-- Step 26: Tognus Flintfire
	-- {npc:1241} Tognus Flintfire
	["{npc:1241}, in the cellar west of the distillery"] = "{npc:1241}，在酒廠西邊的地窖裡",

	-- Step 27: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "沿著道路從{area:131}向東北前往{zone:1455}道路下方的補給站。",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "{npc:1694}，在他旁邊",

	-- Step 28: Yarr Hammerstone
	-- {npc:5392} Yarr Hammerstone
	["{npc:5392}, at the depot"] = "{npc:5392}，在補給站",

	-- Step 29: Bronk Guzzlegear
	-- {npc:1702} Bronk Guzzlegear · {npc:5392} Yarr Hammerstone
	["{npc:1702}, beside {npc:5392}"] = "{npc:1702}，在{npc:5392}旁邊",

	-- Step 30: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}."] = "{object:176785}在{npc:271546}旁邊，{area:136}以南。",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}：{object:176785}",

	-- Step 31: Mountaineer Gretchen
	-- {area:136} Grizzled Den · {area:131} Kharanos · {area:137} Brewnall Village
	-- plural, as words: Elder Wendigos = {npc:271530} Elder Wendigo
	["Gretchen camps just outside the {area:136}, the wendigo cave south-west of {area:131}. The den comes after {area:137}, once its level 8 Elder Wendigos and Shamans are no longer above you."] = "葛蕾琴在{area:131}西南方的雪怪洞穴{area:136}外紮營。等{area:137}之後，8級的雪怪長者和薩滿不再比你高級時，再去洞穴。",

	-- Step 32: Rumbleshot's Ammo
	-- {npc:1243} Hegnar Rumbleshot
	["{npc:1243} camps south-west of it, by the road to Coldridge."] = "{npc:1243}在它西南紮營，靠近去冷嶺的路。",

	-- Step 33: Dun Morogh: kill these as you meet them
	-- {zone:1426} Dun Morogh
	["{zone:1426}: kill these as you meet them"] = "{zone:1426}：沿途遇到就擊殺",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields from Rumbleshot's camp north-east to {area:131} and the depot: kill them on the walk back."] = "峭壁野豬和小黑熊在朗博肖特的營地往東北到{area:131}和補給站之間的原野上遊蕩：在走回去的路上擊殺牠們。",

	-- Step 34: Mountaineer Dolf
	-- {npc:12427} Mountaineer Dolf · {area:131} Kharanos · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12427} kneels wounded on the ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer, on the walk back from Rumbleshot's camp. Cast {spell:613} (Rank 2) on him, then {spell:1243}: Rank 1 of {spell:613} does not count."] = "{npc:12427}受了傷，跪在{area:131}南邊兩道矮牆之間的山脊上，與獵人寵物訓練師隔著道路相對，就在從朗沙特的營地返回的路上。對他施放{spell:613}（等級2），然後施放{spell:1243}：等級1的{spell:613}不算數。",
	-- {npc:12427} Mountaineer Dolf
	["Heal and fortify {npc:12427}"] = "治療並強化{npc:12427}",

	-- Step 35: Thunderbrew Distillery
	-- {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "路上殺峭壁野豬：它們的肋排在接到{npc:1267}的任務前就會掉落，並且算作任務進度。回到釀酒廠：{npc:1699}傳授{skill:185}，然後把肋排交給{npc:1267}。",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}; upstairs"] = "{item:2894}，來自{npc:1247}；樓上",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it; below ground"] = "",
	-- {npc:1226} Maxan Anvol · {item:16605} Friar's Robes of the Light
	["{npc:1226}, upstairs: {item:16605}"] = "{npc:1226}，在樓上：{item:16605}",
	["Upstairs"] = "樓上",

	-- Step 36: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131}與補給站",
	-- {npc:1269} Razzle Sprysprocket · {area:131} Kharanos
	["The pilots stand at the depot; {npc:1269} is on the road back west, north of {area:131}."] = "駕駛員們站在補給站；{npc:1269}在往西回去的路上，{area:131}以北。",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, on the way back; below ground"] = "{npc:1269}，在回去的路上；在地下",

	-- Step 37: Brewnall Village
	-- {area:137} Brewnall Village · {area:131} Kharanos · {npc:8508} Gretta Ganter · {npc:1374} Rejold Barleybrew · {npc:1375} Marleth Barleybrew
	["{area:137} sits on the lake west of {area:131}. {npc:8508}'s dock is the first stop; {npc:1374} and {npc:1375} are in the village beyond it."] = "{area:137}位於{area:131}西邊的湖畔。先去{npc:8508}所在的碼頭，再到後面的村子找{npc:1374}和{npc:1375}。",
	-- {npc:8508} Gretta Ganter
	["{npc:8508}, on the dock"] = "{npc:8508}，在碼頭上",

	-- Step 38: Brewnall: kill these as you meet them
	["Brewnall: kill these as you meet them"] = "釀酒村：遇到就殺",
	-- {area:137} Brewnall Village
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake and {area:137}."] = "冰爪熊、老峭壁野豬和雪豹在湖和{area:137}周圍的山丘上遊蕩。",

	-- Step 40: Grizzled Den
	-- {area:136} Grizzled Den · {area:131} Kharanos · {npc:271546} Mountaineer Gretchen · {npc:278166} Mountaineer Cornelius · {quest:98326} Frosthowl · {item:280426} Sack of Fish
	-- plural, as words: Elder Wendigos = {npc:271530} Elder Wendigo · Wendigo Shamans = {npc:271486} Wendigo Shaman
	["Back to the {area:136}, the wendigo cave south-west of {area:131} where {npc:271546} camps. Flintfire's shipments lie on the cave floor, {npc:278166} is missing deep inside, and {quest:98326} (level 9) keeps the {item:280426} at the back.\nCareful: Wendigos, Elder Wendigos and Wendigo Shamans (up to level 8) stand close together inside the cave, so fights easily pull several at once; drawing them out one at a time with ranged attacks avoids this."] = "回到{area:136}，也就是{area:131}西南方、{npc:271546}紮營的雪人洞穴。燧火的貨物散落在洞穴地面上，{npc:278166}在洞穴深處失蹤，而{quest:98326}（9級）在最裡面看守著{item:280426}。\n小心：雪人、老雪人和雪人薩滿（最高8級）在洞穴內站得很近，戰鬥很容易一次引來好幾隻；用遠程攻擊一次引一隻出來就能避免。",
	-- {item:280426} Sack of Fish · {quest:98326} Frosthowl
	["{item:280426}: {quest:98326}, at the back"] = "{item:280426}：{quest:98326}，在最裡面",

	-- Step 42: Kharanos
	-- {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery · {npc:1241} Tognus Flintfire · {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1252} stands by Eric's campfire in front of the {area:2102}; {npc:1241} is in the cellar west of it. {npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1252}站在{area:2102}前艾瑞克的營火旁；{npc:1241}在它西邊的地窖裡。{npc:1373}在釀酒廠地下室看守著{item:2686}酒桶。向{npc:1247}購買一瓶{item:2686}，點擊有人看守的酒桶，然後從{npc:1373}的任務視窗把麥酒交給他（沒有任務需要接受）；之後，無人看守的酒桶就能繳交{spell:8553}。",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery; upstairs"] = "{item:2686}，來自釀酒廠的{npc:1247}；樓上",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "地下室的{object:269}",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel; below ground"] = "{npc:1373}，在酒桶旁；地下",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery; below ground"] = "{object:270}在釀酒廠裡；地下",

	-- Step 43: Shimmerweed
	-- {item:2676} Shimmerweed · {area:802} Shimmer Ridge · {area:131} Kharanos
	-- plural, as words: Frostmane Seers = {npc:1397} Frostmane Seer
	["The {item:2676} grows in baskets up on {area:802}, the snowy slope north of the road between {area:131} and Brewnall: climb from the road west of {area:131}. The Frostmane Seers camped on the ridge drop it too."] = "{item:2676}長在{area:802}上的籃子裡，那是{area:131}與布倫諾爾之間道路以北的雪坡：從{area:131}西邊的路上山。山脊上紮營的霜鬃先知也會掉落。",

	-- Step 45: The Gnomeregan road
	-- {area:133} Gnomeregan
	["The {area:133} road"] = "{area:133}道路",
	-- {area:133} Gnomeregan · {area:137} Brewnall Village · {area:135} Frostmane Hold
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["Leper Gnomes wander the {area:133} road north of {area:137} and carry the cogs and gears. {area:135} comes next, in the hills south-west of the village.\nCareful: the Leper Gnomes (8-10) walk the road in twos and threes, and many players died here: pull them one at a time."] = "麻瘋地精在{area:137}北邊的{area:133}道路上遊蕩，身上帶著齒輪和零件。接下來是村莊西南方山丘中的{area:135}。\n小心：麻瘋地精（8-10級）兩三隻一起在路上走動，很多玩家死在這裡：一次只引一隻。",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083}：麻瘋地精",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084}：麻瘋地精",

	-- Step 46: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village
	-- plural, as words: Frostmane Hideskinners = {npc:1122} Frostmane Hideskinner
	["{area:135} is the troll cave in the hills south-west of {area:137}. Kill Headhunters at its mouth and walk through to its far end.\nCareful: the Frostmane Hideskinners inside the Hold are level 9-10 and stand in pairs: pull them one at a time back to the mouth."] = "{area:135}是{area:137}西南方山丘中的食人妖洞穴。在洞口擊殺獵頭者，然後一路走到最深處。\n小心：要塞裡的霜鬃剝皮者是9-10級，成對站立：一次引一隻回洞口。",
	-- {npc:1123} Frostmane Headhunter
	["{npc:1123}, below ground"] = "{npc:1123}，地下",
	["Walk to the far end of the cave until the quest gives explore credit."] = "",

	-- Step 47: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {area:131} Kharanos · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of the road back east from Brewnall to {area:131}. His meats are in the locker in {npc:1271}'s cave, east of his camp. {npc:1271} is an elite yeti: wait out of sight until he wanders off on his patrol, then take the meats and leave before he comes back. You don't need to fight him."] = "{npc:1266}在{area:801}紮營，位於從布倫諾爾向東返回{area:131}的道路以南。他的肉在{npc:1271}洞穴的冷藏櫃裡，在營地以東。{npc:1271}是精英雪人：躲起來等他巡邏走開，然後拿走肉，在他回來前離開。不需要和他戰鬥。",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker; below ground"] = "{item:2667}：肉類冷藏櫃；地下",

	-- Step 48: Kharanos
	-- {area:131} Kharanos · {npc:1252} Senir Whitebeard · {quest:287} Frostmane Hold · {npc:1269} Razzle Sprysprocket
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Snow Leopards = {npc:1201} Snow Leopard · Large Crag Boars = {npc:1126} Large Crag Boar
	["Back east through {area:131}: {npc:1252} by Eric's campfire takes the {quest:287} report, and {npc:1269} the cogs and gears. The Shaman quest here waits for level 10: a Shaman still short of it finishes on the Ice Claw Bears (7-8), Snow Leopards and Large Crag Boars in the fields just south of {area:131}."] = "向東穿過{area:131}回去：營火旁的{npc:1252}接收{quest:287}報告，{npc:1269}接收齒輪和零件。這裡的薩滿任務需要10級：還沒到的薩滿可以在{area:131}南邊原野上的冰爪熊（7-8級）、雪豹和大峭壁野豬身上練完。",
	-- {npc:1252} Senir Whitebeard · {npc:1274} Senator Barin Redstone · {zone:1455} Ironforge
	["{npc:1252}: {npc:1274} in {zone:1455} takes it"] = "{npc:1252}：交給{zone:1455}的{npc:1274}",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, below ground"] = "{npc:1269}，地下",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}：由南門旁的{npc:257597}接收",

	-- Step 49: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1426} Dun Morogh
	["Follow the road north-east from {area:131} to the depot: the whole east of {zone:1426} is one sweep from here."] = "從{area:131}沿路向東北前往補給站，從這裡開始一輪走完{zone:1426}整個東部。",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, beside him"] = "{npc:1377}，在他旁邊",

	-- Step 50: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "沿著道路向東經過補給站，前往{area:138}。",

	-- Step 51: Firewood
	["Firewood"] = "木柴",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "木柴散落在避難所旁結冰湖泊周圍的雪地上。",

	-- Step 53: Minor Ice Elemental on the way
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003} on the way"] = "順路上的{npc:276003}",
	-- {npc:276003} Minor Ice Elemental · {npc:1253} Father Gavin
	["{npc:276003} along the way to {npc:1253}"] = "順路去{npc:1253}的路上{npc:276003}",

	-- Step 54: Misty Pine Refuge: kill these as you meet them
	-- {area:138} Misty Pine Refuge
	["{area:138}: kill these as you meet them"] = "{area:138}：遇到就殺",
	-- {quest:99160} Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["The three rifles lie in the snow around the frozen lake by the refuge. Minor Ice Elementals drift around the lake and along the way: kill them as you go for {quest:99160}.\nFinish off the Minor Ice Elementals around the small lake just west of the refuge if you are still short."] = "三支步槍在營地旁冰湖周圍的雪地裡。小型冰元素在湖邊和路上飄蕩：為{quest:99160}一路殺過去。\n如果數量還不夠，把營地西邊小湖周圍的小型冰元素也清掉。",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, around the small lake"] = "{npc:276003}，在小湖周圍",

	-- Step 56: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325}在結冰湖泊旁，位於冰元素之間。",

	-- Step 61: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "法森在{area:134}西邊俯瞰採掘場的山脊上紮營。與他交談以獲得他的遠視。",

	-- Step 64: Gol'Bolar Quarry
	["The quarry lies just east of Farsen's ridge."] = "採石場就在法森山脊以東。",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}，在採掘場裡",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}：僅限鐵匠",

	-- Step 65: The quarry troggs
	["The quarry troggs"] = "採掘場的穴居人",
	-- {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper
	["Rockjaw Skullthumpers, Bonesnappers and Ambushers share the quarry and the slopes north of it; the Ambushers drop the {item:268548}."] = "石齶擊顱者、石齶碎骨者和石齶伏擊者分布在採掘場及其北邊的山坡上；伏擊者會掉落{item:268548}。",

	-- Step 68: Helm's Bed Lake
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}. Dark Iron Spies sneak around the lake shore east of the quarry; one of them drops the {item:274268}."] = "{area:212}旁、採石場以北的石顎伏擊者，以及更東邊的石顎碎背者掉落{quest:95214}。黑鐵間諜在採石場以東的湖岸潛行；其中一個掉落{item:274268}。",

	-- Step 69: Dun Morogh: kill these as you meet them
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "雪豹和野豬在牧場與採掘場之間的雪地上遊蕩。鐵匠：銅錠可以熔煉{item:2770}取得，或向商業用品商人購買。",

	-- Step 72: Protecting the Herd
	-- {npc:1388} Vagash · {area:38} Loch Modan
	-- was: ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: take him on with a group. Alone, skip it: the {zone:1432} quests ahead make up the experience."] = "這些是精英怪：建議組隊，找人一起做。{npc:1388}是12級精英：請組隊挑戰。單人的話就跳過：前面{zone:1432}的任務能補回經驗。"
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: take him on with a group. Alone, skip it: the {area:38} quests ahead make up the experience."] = "",
	["Below ground"] = "地下",

	-- Step 73: Rudra Amberstill
	-- {zone:1455} Ironforge
	["On the road back west to {zone:1455}."] = "在回西邊{zone:1455}的路上。",

	-- Step 76: South Gate Outpost
	-- {area:806} South Gate Outpost · {area:38} Loch Modan
	-- was: ["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "沿路一直向東，前往{zone:1432}隧道口的{area:806}。"
	["Follow the road all the way east to the {area:806} at the {area:38} tunnel."] = "",

	-- Step 77: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597}在{area:806}西北方農場上方的洞穴裡等候；上山的小路從農場後方開始。",

	-- Step 79: Braldir Ashmantle
	-- {area:38} Loch Modan · {npc:257808} Braldir Ashmantle
	-- was: ["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "穿過隧道進入 {zone:1432}。剛出隧道，路右側就有一條以石塊標記的小徑，沿它向北上山，前往 {npc:257808} 的營地。"
	["Go through the tunnel into {area:38}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "",

	-- Step 80: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}, north of the South Gate; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960}在南門以北的{area:808}等候；矮人屍體就在他西邊的山道上方。",

	-- Step 81: The tunnel post
	["The tunnel post"] = "隧道崗哨",
	-- {area:38} Loch Modan · {npc:1089} Mountaineer Cobbleflint · {npc:1092} Captain Rugelfuss
	-- was: ["East through the South Gate tunnel into {zone:1432}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "向東穿過南門隧道進入{zone:1432}。{npc:1089}和{npc:1092}站在剛出隧道的矮人哨所。"
	["East through the South Gate tunnel into {area:38}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "",

	-- Step 82: Stonesplinter troggs
	["Stonesplinter troggs"] = "碎石穴居人",
	-- plural, as words: Stonesplinter Scouts = {npc:1162} Stonesplinter Scout
	["North of the post, west of the road: the Stonesplinter troggs and scouts camp in the hills. Both drop the Trogg Stone Teeth.\nCareful: pull the Stonesplinter Scouts and Troggs one at a time. Stay at the north edge of the valley; Headsplitter patrols the deeper camps."] = "",

	-- Step 83: Back to the tunnel post
	["Back to the tunnel post"] = "回到隧道崗哨",

	-- Step 84: Thelsamar
	-- {area:144} Thelsamar · {npc:1340} Mountaineer Kadrell · {npc:1963} Vidra Hearthstove · {area:2101} Stoutlager Inn · {npc:1681} Brock Stoneseeker · {npc:1572} Thorgrum Borrelson
	["North up the road to {area:144}. {npc:1340} walks the road through town, {npc:1963} stands outside the {area:2101}, {npc:1681} on the east side of town; {npc:1572} keeps the gryphons."] = "沿道路往北到{area:144}。{npc:1340}在穿過鎮子的路上走動，{npc:1963}站在{area:2101}外，{npc:1681}在鎮子東邊；{npc:1572}看管獅鷲。",
	-- {npc:1572} Thorgrum Borrelson
	["{npc:1572}, the gryphon master"] = "{npc:1572}，獅鷲管理員",
	-- {npc:1572} Thorgrum Borrelson · {npc:4256} Golnir Bouldertoe · {zone:1455} Ironforge
	["{npc:1572}: for {npc:4256} in {zone:1455}"] = "{npc:1572}：交給{zone:1455}的{npc:4256}",

	-- Step 85: The west hills and the Algaz Station
	-- {area:925} Algaz Station
	["The west hills and the {area:925}"] = "西部丘陵和{area:925}",
	-- {npc:1343} Mountaineer Stormpike · {area:925} Algaz Station
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear · Mountain Boars = {npc:1190} Mountain Boar · Forest Lurkers = {npc:1195} Forest Lurker
	["North through the hills west of the road to {npc:1343} at the {area:925}. The Tunnel Rat kobolds dig in the hills on the way; Elder Black Bears, Mountain Boars and Forest Lurkers roam the same ground."] = "往北穿過道路以西的山丘，到{area:925}的{npc:1343}那裡。坑道鼠狗頭人沿途在山丘裡挖洞；老黑熊、山豬和森林潛伏者在同一片地方遊蕩。",
	-- {item:3110} Tunnel Rat Ear
	["{item:3110}: Tunnel Rat kobolds"] = "{item:3110}：坑道鼠狗頭人",
	-- {item:3172} Boar Intestines
	-- plural, as words: Mountain Boars = {npc:1190} Mountain Boar
	["{item:3172}: Mountain Boars"] = "{item:3172}：山豬",
	-- {item:3173} Bear Meat
	-- plural, as words: Elder Black Bears = {npc:1186} Elder Black Bear
	["{item:3173}: Elder Black Bears"] = "{item:3173}：老黑熊",
	-- {item:3174} Spider Ichor
	-- plural, as words: Forest Lurkers = {npc:1195} Forest Lurker
	["{item:3174}: Forest Lurkers"] = "{item:3174}：森林潛伏者",
	-- {npc:5413} Furen Longbeard · {zone:1453} Stormwind
	["{npc:5413} in {zone:1453} takes it"] = "交給{zone:1453}的{npc:5413}",

	-- Step 86: Silver Stream Mine
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["East along the hills to the mine at the north end of the loch: the Miners' League crates sit in its tunnels, among more Tunnel Rats. Shamans: the Tunnel Rat Geomancers (level 12-13) here carry the {item:5026}.\nCareful: the Tunnel Rat Geomancers (12-13) cast from range in the narrow tunnels: pull them one at a time."] = "沿山丘向東前往湖北端的礦坑：礦工聯盟的箱子在坑道裡，周圍有更多坑道鼠。薩滿：這裡的坑道鼠地卜師（12-13級）身上帶有{item:5026}。\n小心：坑道鼠地卜師（12-13級）會在狹窄坑道中遠程施法：一次引一隻。",
	-- {item:2640} Miners' Gear
	["{item:2640}, from the crates"] = "{item:2640}，來自箱子",
	-- {item:5026} Fire Tar
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["{item:5026}: Tunnel Rat Geomancers"] = "{item:5026}：坑道鼠地卜師",

	-- Step 87: Back to the Algaz Station
	-- {area:925} Algaz Station
	["Back to the {area:925}"] = "回到{area:925}",

	-- Step 88: Thelsamar
	-- {area:144} Thelsamar · {npc:1340} Mountaineer Kadrell
	["South down the road to {area:144}, finishing the ears, meat and ichor on the way. {npc:1340} walks the road through town."] = "沿著道路向南前往{area:144}，途中把耳朵、熊肉和蜘蛛膿液收集完。{npc:1340}在穿過城鎮的道路上巡邏。",

	-- Step 89: The Reagent Pouch
	-- {item:6652} Reagent Pouch
	["The {item:6652}"] = "{item:6652}",
	-- {area:923} Stonesplinter Valley
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["South down the road past the tunnel post into {area:923}: the Stonesplinter Seers (level 13-14) stand among the troggs in its middle. Stay out of the far south end, where Shamans and Bonesnappers (level 15-16) camp, and keep clear of Headsplitter (15) on his walk. The Seers come with other troggs and cast from range: pull one at a time."] = "沿道路向南經過隧道哨站進入{area:923}：碎石怪先知（13-14級）站在中間的穴居人之間。別靠近最南端，那裡有薩滿和碎骨者（15-16級）紮營，也要避開巡邏的裂顱者（15級）。先知會和其他穴居人一起出現並遠程施法：一次引一隻。",
	-- {item:6652} Reagent Pouch
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["{item:6652}: Stonesplinter Seers"] = "{item:6652}：碎石怪先知",

	-- Step 90: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "火焰靈石",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["Back north to {npc:257808}'s camp above the tunnel. {npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "向北回到隧道上方{npc:257808}的營地。{npc:257808}會給你{item:6636}。爬上營地上方的山峰，在靈石旁喝下靈契並擊敗{npc:5893}，然後把牠的{item:6655}放進永恆之火神殿頂端的{object:61934}。",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}，在靈石旁邊",

	-- Step 91: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "返回{npc:257597}",
	-- {npc:257597} Bruegs Kindleborn · {zone:1455} Ironforge
	["Back through the tunnel to {npc:257597}' cave above the farm, then west along the road to {zone:1455}."] = "穿過隧道回到農場上方{npc:257597}的洞穴，然後沿道路向西前往{zone:1455}。",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 92: Golnir Bouldertoe
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge · {npc:1573} Gryth Thurden · {area:144} Thelsamar
	["{npc:4256} works at the {object:32372}'s north end, and {npc:1573} keeps the gryphons in the {object:32372}, where the flight from {area:144} lands."] = "{npc:4256}在{object:32372}北端工作，{npc:1573}在{object:32372}照料獅鷲，從{area:144}起飛的航班就降落在這裡。",
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge
	["{npc:4256}, in the {object:32372}"] = "{npc:4256}，在{object:32372}裡",
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge
	["{npc:1573}, the gryphon master in the {object:32372}"] = "{npc:1573}，{object:32372}的獅鷲管理員",

	-- Step 93: Tinker Town
	-- {object:32372} Great Forge · {object:171524} Tinker Town · {object:660964} Misplaced Packages · {object:32383} Forlorn Cavern · {object:32362} Mystic Ward · {object:171709} High Seat · {object:32359} Military Ward
	["East from the {object:32372} into {object:171524}: the {object:660964} lie by its mailbox. From here the guide goes once round the city: north to the {object:32383}, west to the {object:32362}, south through the Commons to the {object:171709}, east through the {object:32359} and back to {object:171524} for the tram."] = "從{object:32372}往東進入{object:171524}：{object:660964}就在它的郵箱旁。從這裡指南繞城一圈：往北到{object:32383}，往西到{object:32362}，往南穿過平民區到{object:171709}，往東穿過{object:32359}，再回到{object:171524}坐地鐵。",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}，在{object:171524}的郵箱旁",

	-- Step 94: Forlorn Cavern
	-- {object:32372} Great Forge · {npc:258098} Eldrun Stormbreaker · {object:32383} Forlorn Cavern · {npc:6120} Lago Blackwrench
	["North of the {object:32372}: {npc:258098}, the shaman trainer, stands at the south end of the {object:32383}, the rogue and warlock trainers and {npc:6120} just north of him."] = "在{object:32372}以北：薩滿訓練師{npc:258098}站在{object:32383}的南端，盜賊和術士訓練師以及{npc:6120}就在他北邊。",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}：由{zone:1453}的{npc:6122}接收",

	-- Step 95: The Tome of Divinity
	-- {item:6775} Tome of Divinity
	["The {item:6775}"] = "{item:6775}",
	-- {object:32383} Forlorn Cavern · {object:32362} Mystic Ward · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["West from the {object:32383} into the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, Tiza and Muiredon on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "從{object:32383}向西進入{object:32362}：{npc:5149}、{npc:6179}和{npc:6178}在{object:32386}內，蒂薩和穆裡頓在樓上：樓梯起點就在{npc:5149}東北邊。乞丐{npc:6175}在城中游蕩。他要十塊{item:2589}：{zone:1426}的穴居人和食人妖會掉落，拍賣行也有出售。",

	-- Step 96: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Head back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "離開{zone:1455}往回走，沿路向東到{area:212}。{npc:6177}死在岸邊：對他使用{item:6866}。在湖邊潛行的黑鐵間諜身上帶著那份名冊。",

	-- Step 98: Mystic Ward
	-- {object:32386} Hall of Mysteries · {object:32362} Mystic Ward
	["The paladin, priest and mage trainers are in the {object:32386}, in the {object:32362}."] = "聖騎士、牧師和法師訓練師在{object:32362}內的{object:32386}裡。",
	-- {npc:258785} High Priestess Mims · {quest:94817} Confounding Flash
	["{npc:258785}: {quest:94817}, her own copy of the letter"] = "{npc:258785}：{quest:94817}，她自己那份信",

	-- Step 99: High Seat
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["South through the Commons: {npc:1274} stands in the {object:171709} with King Magni."] = "往南穿過平民區：{npc:1274}和麥格尼國王一起站在{object:171709}裡。",
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["{npc:1274}, in the {object:171709} with King Magni"] = "{npc:1274}，在{object:171709}裡，和麥格尼國王在一起",

	-- Step 100: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "趁在這裡：向{npc:11865}學習{spell:197}（{object:32359}，10銀）；雙手武器讓聖騎士升級最快。",

	-- Step 101: Military Ward
	-- {object:32359} Military Ward · {npc:11865} Buliwyf Stonehand · {object:32390} Hall of Arms
	["East to the {object:32359}: the warrior trainers and {npc:11865} in the {object:32390}, the hunter trainers beside it."] = "往東到{object:32359}：戰士訓練師和{npc:11865}在{object:32390}裡，獵人訓練師就在旁邊。",

	-- Step 102: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "趁在這裡：向{npc:11865}學習{spell:197}（{object:32359}，10銀）；雙手武器讓戰士升級最快。",

	-- Step 103: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "趁在這裡：向{npc:11865}學習{spell:199}（{object:32359}，10銀）；雙手武器讓戰士升級最快。",

	-- Step 104: Druid trainer
	["Druid trainer"] = "德魯伊訓練師",
	-- {npc:5505} Theridran · {zone:1453} Stormwind · {zone:1426} Dun Morogh
	["{npc:5505} in {zone:1453}; {zone:1426} has no druid trainer"] = "{npc:5505}在{zone:1453}；{zone:1426}沒有德魯伊訓練師",

	-- Step 105: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {object:171524} Tinker Town · {area:2257} Deeprun Tram · {zone:1453} Stormwind
	["East back into {object:171524}: the {area:2257} leaves from its east end. Ride it to {zone:1453}."] = "往東回到{object:171524}裡：{area:2257}從它的東端發車。乘它去{zone:1453}。",

	-- Step 106: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "搭地鐵前往{zone:1453}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {npc:12997} Monty · {item:17117} Rat Catcher's Flute · {npc:13018} Nipsy · {zone:1453} Stormwind
	-- plural, as words: Deeprun Rats = {npc:13016} Deeprun Rat
	-- was: ["On the {zone:1455} platform of the {area:2257}, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end."] = "在{area:2257}的{zone:1455}站臺上，{npc:12997}請你幫忙處理老鼠：用他的{item:17117}對付站臺周圍的礦道老鼠，把它們交上去，然後把他的信帶給{zone:1453}那頭的兄弟{npc:13018}。"
	["On the {zone:1455} platform of the {area:2257}, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end. The tram has no map inside. The city markers show the entrances, not the two brothers."] = "",
	-- {npc:12997} Monty · {zone:1455} Ironforge
	["{npc:12997}, on the {zone:1455} platform"] = "{npc:12997}，在{zone:1455}站臺上",
	-- {npc:13016} Deeprun Rat · {item:17117} Rat Catcher's Flute
	["{npc:13016}: use the {item:17117}"] = "{npc:13016}：使用{item:17117}",
	-- {npc:13016} Deeprun Rat
	["Catch {npc:13016}"] = "抓住{npc:13016}",

	-- Step 107: Nipsy
	-- {zone:1453} Stormwind · {npc:13018} Nipsy · {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Ride the tram to {zone:1453}: {npc:13018} waits on the {zone:1453} platform. {npc:5413} stands in the {object:28027}, just outside the tram."] = "乘地鐵到{zone:1453}：{npc:13018}在{zone:1453}站臺上等著。{npc:5413}站在{object:28027}裡，就在地鐵外面。",
	-- {npc:13018} Nipsy · {zone:1453} Stormwind
	["{npc:13018}, on the {zone:1453} platform"] = "{npc:13018}，在{zone:1453}站臺上",

	-- Step 108: From the tram to Stormwind
	-- {area:1519} Stormwind
	["From the tram to {area:1519}"] = "",

	-- Step 109: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {zone:1436} Westfall · {object:2096} Trade District
	["From the {object:28027} south-west to {object:2098}: {npc:1646}'s compass is in his old house in {zone:1436}, on the way. The flight master and the {object:2096} are south of the square."] = "從{object:28027}往西南到{object:2098}：{npc:1646}的羅盤在{zone:1436}他的老房子裡，順路可取。飛行管理員和{object:2096}在廣場南邊。",

	-- Step 110: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "{zone:1453}飛行管理員",

	-- Step 111: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "趁在這裡：向{npc:11867}學習{spell:202}（{object:2096}，10銀）；雙手武器讓聖騎士升級最快。",

	-- Step 112: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "順便：在{npc:11867}處學習法杖（{object:2096}，10銀幣）；獵人的近戰武器主要看屬性，而雙手武器屬性最多。",

	-- Step 113: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "順便：在{npc:11867}處學習劍（{object:2096}，10銀幣）；主手持劍能讓盜賊穩定升級。",

	-- Step 114: Defensive Stance
	-- {npc:5480} Ilsa Corbin · {object:2100} Old Town · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["{npc:5480} trains warriors in {object:2100}, near Osric's shop; the tram from {zone:1455} arrives in the {object:28027}, north of it. {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "{npc:5480}在{object:2100}奧斯里克的商店附近訓練戰士；從{zone:1455}出發的地鐵抵達其北邊的{object:28027}。{npc:6089}和{npc:6090}一起站在那裡的{object:2152}旁。{npc:6090}會為了他的杯子和你打一架。如果{npc:5480}沒有提供{quest:1638}，就直接去找{npc:6089}：即使沒有該任務，他也會給你{quest:1639}。",

	-- Step 115: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "趁在這裡：向{npc:11867}學習{spell:202}（{object:2096}，10銀）；雙手武器讓戰士升級最快。",

	-- Step 116: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122}在{object:2101}的{object:2164}地下室等候。",
	-- {quest:1688} Surena Caledon · {zone:1436} Westfall
	["{quest:1688}: her choker and The Binding are on {zone:1436}'s east-Elwynn loop"] = "{quest:1688}：她的項圈和「束縛」在{zone:1436}的艾爾文東部環線上",

	-- Step 117: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "順便：在{npc:11867}處學習法杖（{object:2096}，10銀幣）；升級期間，法杖的法術屬性比單手武器更多。",

	-- Step 118: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497}站在{object:2101}的法師塔裡；她會給你一個裝{quest:1861}瀑布水的瓶子。",

	-- Step 119: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "從正門離開{zone:1453}。{quest:1861}瀑布在城門西南方，位於往西前往{zone:1436}的路上：在瀑布底部裝滿{item:7207}。",

	-- Step 120: Goldshire
	-- {zone:1453} Stormwind · {area:87} Goldshire · {zone:1436} Westfall
	["Leave {zone:1453} by the main gate and follow the road south to {area:87}: east Elwynn comes before {zone:1436}."] = "從正門離開{zone:1453}，沿道路往南到{area:87}：先到艾爾文森林東部，再進{zone:1436}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back through the tunnel to {npc:257597}' cave above the farm."] = "穿過隧道回到農場上方{npc:257597}的洞穴。",
	-- ["East through the South Gate tunnel into {zone:1432}. {npc:1089} and {npc:1092} stand at the dwarven post just past it."] = "向東穿過南門隧道進入{zone:1432}。{npc:1089}和{npc:1092}站在剛出隧道的矮人哨所。",
	-- ["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "沿路一直向東，前往{zone:1432}隧道口的{area:806}。",
	-- ["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "沿著道路上到{zone:1455}，向你的職業訓練師學習。{area:2257}從城市東邊的{object:171524}出發。搭乘它前往{zone:1453}。",
	-- ["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "穿過隧道進入 {zone:1432}。剛出隧道，路右側就有一條以石塊標記的小徑，沿它向北上山，前往 {npc:257808} 的營地。",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "從正門離開{zone:1453}，向南前往{area:87}，再沿著道路向東前往{area:62}。{npc:881}（9級）站在農舍旁。",
	-- ["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "烈酒村和{area:133}道路周圍的麻瘋地精身上帶著齒輪和零件。冰爪熊、老峭壁野豬和雪豹在湖周圍的山丘上遊蕩。",
	-- ["Level 4 spells, before Gozwin's camp"] = "4級法術，在前往戈茲溫的營地之前學習",
	-- ["On the {zone:1455} platform of the {area:2257}, {npc:12997} asks for help with the rats: use his {item:17117} on the Deeprun Rats around the platform, hand them in, then take his letter to his brother {npc:13018} at the {zone:1453} end."] = "在{area:2257}的{zone:1455}站臺上，{npc:12997}請你幫忙處理老鼠：用他的{item:17117}對付站臺周圍的礦道老鼠，把它們交上去，然後把他的信帶給{zone:1453}那頭的兄弟{npc:13018}。",
	-- ["Stonesplinter Seers (level 13) stand among the troggs in the south of {area:923}, south of {npc:257808}; Tunnel Rat Geomancers (level 12) work the {area:149} at the north end of the loch. The troggs come in packs and some throw from range: pull one at a time."] = "碎石怪先知（13級）站在{npc:257808}營地南邊、{area:923}南部的穴居人之間；坑道鼠地卜師（12級）在湖北端的{area:149}工作。穴居人成群出現，有些會從遠處投擲：一次拉一隻。",
	-- ["Subdue the voidwalker"] = "制服虛空行者",
	-- ["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "地鐵抵達{object:28027}。{npc:5480}在{object:2100}訓練戰士；{npc:6089}和{npc:6090}一起站在那裡的{object:2152}旁。{npc:6090}會為了他的杯子和你打一架。",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:1388} is a level 12 elite: take him on with a group. Alone, skip it: the {zone:1432} quests ahead make up the experience."] = "這些是精英怪：建議組隊，找人一起做。{npc:1388}是12級精英：請組隊挑戰。單人的話就跳過：前面{zone:1432}的任務能補回經驗。",
	-- ["{item:5026} and the {item:6652}"] = "{item:5026}和{item:6652}",
	-- ["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226}：由{zone:1455}的{npc:258785}接收",
	-- ["{npc:1241}, below ground: Camping 101, blacksmiths"] = "{npc:1241}，在地下：露營入門，鐵匠",
	-- ["{npc:1377}, at the depot"] = "{npc:1377}，在補給站",
	-- ["{npc:1702}, beside him: Camping 101, engineers"] = "{npc:1702}，在他旁邊：露營入門，工程師",
	-- ["{npc:2326}, inside: Camping 101, {skill:129}"] = "{npc:2326}，在裡面：露營入門，{skill:129}",
	-- ["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808}會給你{item:6636}。爬上營地上方的山峰，在靈石旁喝下靈契並擊敗{npc:5893}，然後把牠的{item:6655}放進永恆之火神殿頂端的{object:61934}。",
	-- ["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}，薩滿訓練師，在{object:32372}北邊",
	-- ["{npc:265813}, blacksmiths: for {npc:1241}"] = "{npc:265813}，鐵匠：交給{npc:1241}",
	-- ["{npc:265813}, engineers: for {npc:1702}"] = "{npc:265813}，工程師：交給{npc:1702}",
	-- ["{npc:265813}, miners: for {npc:5392}"] = "{npc:265813}，礦工：交給{npc:5392}",
	-- ["{npc:265813}, {skill:129}: for {npc:2326}"] = "{npc:265813}，{skill:129}：交給{npc:2326}",
	-- ["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756}和{npc:8416}一起站在{area:77}門口。戈茲溫的營地就在西北方的山丘上；{npc:269075}在營地周圍徘徊。",
	-- ["{npc:5392}: Camping 101, miners"] = "{npc:5392}：露營入門，礦工",
	-- ["{zone:1455} class quests"] = "{zone:1455}職業任務",
}
