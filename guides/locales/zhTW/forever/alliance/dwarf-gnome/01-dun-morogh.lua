-- Chinese (traditional) (zhTW): the guide forever/alliance/dwarf-gnome/01-dun-morogh (forever/alliance/dwarf-gnome/01-dun-morogh.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:658} Sten Stoutarm · {npc:895} Thorgas Grimson
	["{npc:658}: a rune for {npc:895}"] = "{npc:658}：給{npc:895}的符文",
	-- {npc:658} Sten Stoutarm · {quest:98581} Archaic Rune
	["{npc:658}: read the {quest:98581}"] = "{npc:658}：閱讀{quest:98581}",
	-- {npc:713} Balir Frosthammer · {npc:658} Sten Stoutarm
	["{npc:713}, next to {npc:658}"] = "{npc:713}，在{npc:658}旁邊",
	-- {npc:912} Thran Khorman
	["{npc:912}, the warrior trainer"] = "{npc:912}，戰士訓練師",
	-- {npc:926} Bromos Grummner
	["{npc:926}, the paladin trainer"] = "{npc:926}，聖騎士訓練師",
	-- {npc:895} Thorgas Grimson
	["{npc:895}, the hunter trainer"] = "{npc:895}，獵人訓練師",
	-- {npc:916} Solm Hargrin
	["{npc:916}, the rogue trainer"] = "{npc:916}，盜賊訓練師",
	-- {npc:837} Branstock Khalder
	["{npc:837}, the priest trainer"] = "{npc:837}，牧師訓練師",
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["{npc:257446}, inside {area:77}"] = "{npc:257446}，在{area:77}裡面",
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
	["A few more troggs outside if you are short"] = "如果還不夠，到外面再殺幾隻穴居人",
	-- {npc:8416} Felix Whindlebolt · {area:77} Anvilmar
	["{npc:8416}, by the door of {area:77}"] = "{npc:8416}，在{area:77}門口",

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
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp
	["A few Frostmane Troll Whelps if you are short"] = "如果還不夠，再殺幾隻小霜鬃食人妖",

	-- Step 10: The troll cave
	["The troll cave"] = "食人妖洞穴",
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
	["{npc:836}, inside {area:77}"] = "{npc:836}，在{area:77}裡面",
	["Level 4 spells, before Gozwin's camp"] = "4級法術，在前往戈茲溫的營地之前學習",
	-- {npc:8416} Felix Whindlebolt
	["{npc:8416}, at the door on the way out"] = "",

	-- Step 13: Grund and Gozwin
	-- {npc:2756} Grund Drokda · {npc:8416} Felix Whindlebolt · {area:77} Anvilmar · {npc:269075} Snow Leopard Prowler
	["{npc:2756} stands by {npc:8416} at the door of {area:77}. Gozwin's camp is in the hills just north-west; the {npc:269075} prowls around it."] = "{npc:2756}和{npc:8416}一起站在{area:77}門口。戈茲溫的營地就在西北方的山丘上；{npc:269075}在營地周圍徘徊。",
	-- {item:277976} Gozwin's Mechanic's Log
	["{item:277976}, in the camp"] = "{item:277976}，在營地裡",

	-- Step 14: Grik'nir the Cold
	-- {npc:808} Grik'nir the Cold · {npc:786} Grelin Whitebeard
	["{npc:808} is inside the troll cave east of {npc:786}'s camp, not on the hill above it: go in at the mouth and follow the tunnel to the back."] = "{npc:808}在{npc:786}營地東邊的食人妖洞穴裡，不在洞穴上方的山丘上：從洞口進去，沿著隧道走到最深處。",

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

	-- Step 18: Kharanos
	-- {area:131} Kharanos · {npc:1267} Ragnar Thunderbrew · {npc:1252} Senir Whitebeard · {area:2102} Thunderbrew Distillery
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar
	["Follow the road through the tunnel and north-east to {area:131}. Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. Start outside: {npc:1252} and Eric's campfire are in front of the {area:2102}."] = "",

	-- Step 19: The Great Outdoors
	["Sit by Eric's campfire (type /sit) and wait for the buff."] = "",

	-- Step 20: Tharek Blackstone
	-- {npc:1872} Tharek Blackstone
	["{npc:1872} works the forge west of the distillery."] = "",

	-- Step 21: Thunderbrew Distillery
	-- {npc:6806} Tannok Frosthammer · {npc:1226} Maxan Anvol · {npc:1267} Ragnar Thunderbrew · {npc:1699} Gremlock Pilsnor · {skill:185} Cooking
	["Then go in: {npc:6806}, the innkeeper, {npc:1226} and {npc:1267}. {npc:1699}'s {skill:185} lesson waits for the return with the ribs, when the copper is there for it."] = "",
	-- {item:2894} Rhapsody Malt · {npc:1247} Innkeeper Belm
	["{item:2894}, from {npc:1247}"] = "{item:2894}，來自{npc:1247}",
	["Last: some classes' trainers stand outside"] = "",

	-- Step 22: Steelgrill's Depot
	-- {area:131} Kharanos · {zone:1455} Ironforge
	["Follow the road north-east from {area:131} to the depot below the {zone:1455} road."] = "沿著道路從{area:131}向東北前往{zone:1455}道路下方的補給站。",
	-- {npc:1694} Loslor Rudge
	["{npc:1694}, beside him"] = "",

	-- Step 23: Boars and bears
	["Boars and bears"] = "野豬與熊",
	-- {area:131} Kharanos
	-- plural, as words: Crag Boars = {npc:1125} Crag Boar · Young Black Bears = {npc:1128} Young Black Bear
	["Crag Boars and Young Black Bears roam the fields around {area:131} and the depot."] = "峭壁野豬和小黑熊在{area:131}和補給站周圍的原野上遊蕩。",

	-- Step 24: Kharanos
	-- {npc:1699} Gremlock Pilsnor · {skill:185} Cooking · {npc:1267} Ragnar Thunderbrew
	["Back in the distillery: {npc:1699} teaches {skill:185}, then the ribs go to {npc:1267}."] = "",
	-- {npc:1699} Gremlock Pilsnor
	["{npc:1699}: Camping 101 asks you to learn it"] = "",
	-- {npc:1699} Gremlock Pilsnor
	["Speak with {npc:1699}"] = "與{npc:1699}交談",

	-- Step 26: Mountaineer Gretchen
	-- {area:136} Grizzled Den · {area:131} Kharanos
	["Gretchen camps just outside the {area:136}, the wendigo cave south-west of {area:131}."] = "",

	-- Step 27: The Grizzled Den
	-- {object:460004} Mountaineer Cornelius (no name in this language: may be words)
	["Flintfire's shipments lie on the cave floor, and {object:460004} is missing somewhere inside."] = "",

	-- Step 29: Rumbleshot's Ammo
	-- {object:176785} Ammo Crate · {npc:271546} Mountaineer Gretchen · {area:136} Grizzled Den · {npc:1243} Hegnar Rumbleshot
	["The {object:176785} sits next to {npc:271546}, south of the {area:136}; {npc:1243} camps south-west of it, by the road to Coldridge."] = "{object:176785}在{area:136}南邊的{npc:271546}旁邊；{npc:1243}在它西南邊、通往寒脊山谷的路旁紮營。",
	-- {item:13850} Rumbleshot's Ammo · {object:176785} Ammo Crate
	["{item:13850}: the {object:176785}"] = "{item:13850}：{object:176785}",

	-- Step 30: Kharanos and the depot
	-- {area:131} Kharanos
	["{area:131} and the depot"] = "{area:131}與補給站",
	-- {npc:1377} Pilot Stonegear
	["{npc:1377}, at the depot"] = "{npc:1377}，在補給站",
	-- {npc:1269} Razzle Sprysprocket
	["{npc:1269}, by the depot"] = "{npc:1269}，在補給站旁邊",

	-- Step 31: Brewnall Village
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

	-- Step 32: Frostmane Hold
	-- {area:135} Frostmane Hold · {area:137} Brewnall Village · {npc:1374} Rejold Barleybrew
	-- plural, as words: Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["{area:135} is the troll cave in the hills south-west of {area:137}. Ice Claw Bears, Elder Crag Boars and Snow Leopards you kill on the way count for {npc:1374}. Kill Headhunters at its mouth and walk through to its far end."] = "",

	-- Step 33: Gnomes, bears and leopards
	["Gnomes, bears and leopards"] = "地精、熊與雪豹",
	-- {area:133} Gnomeregan
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome · Ice Claw Bears = {npc:1196} Ice Claw Bear · Elder Crag Boars = {npc:1127} Elder Crag Boar · Snow Leopards = {npc:1201} Snow Leopard
	["Leper Gnomes around Brewnall and the {area:133} road carry the cogs and gears. Ice Claw Bears, Elder Crag Boars and Snow Leopards roam the hills around the lake."] = "烈酒村和{area:133}道路周圍的麻瘋地精身上帶著齒輪和零件。冰爪熊、老峭壁野豬和雪豹在湖周圍的山丘上遊蕩。",
	-- {item:3083} Restabilization Cog
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3083}: Leper Gnomes"] = "{item:3083}：麻瘋地精",
	-- {item:3084} Gyromechanic Gear
	-- plural, as words: Leper Gnomes = {npc:1211} Leper Gnome
	["{item:3084}: Leper Gnomes"] = "{item:3084}：麻瘋地精",

	-- Step 36: Kharanos
	-- {npc:1373} Jarven Thunderbrew · {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm · {spell:8553} Barleybrew Scalder
	["{npc:1373} guards the {item:2686} barrels in the distillery basement. Buy a {item:2686} from {npc:1247}, click the guarded barrel, then hand the ale to {npc:1373} from his quest window (there is no quest to accept); after that, the unguarded barrel takes the {spell:8553}."] = "{npc:1373}看守著釀製廠地下室的{item:2686}酒桶。向{npc:1247}購買一杯{item:2686}，點擊受到看守的酒桶，然後透過他的任務視窗把酒交給{npc:1373}（沒有任務需要接受）；之後，無人看守的酒桶就能拿到{spell:8553}。",
	-- {item:2686} Thunder Ale · {npc:1247} Innkeeper Belm
	["{item:2686}, from {npc:1247} in the distillery"] = "{item:2686}，來自釀製廠裡的{npc:1247}",
	-- {object:269} Guarded Thunder Ale Barrel
	["The {object:269} in the basement"] = "地下室的{object:269}",
	-- {npc:1373} Jarven Thunderbrew
	["{npc:1373}, beside the barrel"] = "{npc:1373}，在酒桶旁邊",
	-- {object:270} Unguarded Thunder Ale Barrel
	["The {object:270} in the distillery"] = "釀製廠裡的{object:270}",
	-- {npc:1252} Senir Whitebeard · {npc:1274} Senator Barin Redstone · {zone:1455} Ironforge
	["{npc:1252}: {npc:1274} in {zone:1455} takes it"] = "",

	-- Step 38: Misty Pine Refuge
	-- {area:138} Misty Pine Refuge
	["Follow the road east past the depot to {area:138}."] = "沿著道路向東經過補給站，前往{area:138}。",

	-- Step 39: Firewood
	["Firewood"] = "木柴",
	["The firewood lies in the snow around the frozen lake by the refuge."] = "木柴散落在避難所旁結冰湖泊周圍的雪地上。",

	-- Step 41: Treacherous Cold
	-- {quest:99160} Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["The three rifles lie in the snow around the frozen lake by the refuge. Minor Ice Elementals drift around the lake and along the way: kill them as you go for {quest:99160}."] = "",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, on the way"] = "",

	-- Step 42: Rime's Wrath
	-- plural, as words: Minor Ice Elementals = {npc:276003} Minor Ice Elemental
	["Finish off the Minor Ice Elementals around the small lake just west of the refuge if you are still short."] = "",
	-- {npc:276003} Minor Ice Elemental
	["{npc:276003}, around the small lake"] = "",

	-- Step 44: Avala's Core
	-- {item:286325} Avala's Core
	["{item:286325} is by the frozen lake, among the ice elementals."] = "{item:286325}在結冰湖泊旁，位於冰元素之間。",

	-- Step 47: Gol'Bolar Quarry
	["The quarry lies south-east of the ranch."] = "採掘場位於牧場東南方。",
	-- {npc:1698} Frast Dokner
	["{npc:1698}: blacksmiths only"] = "{npc:1698}：僅限鐵匠",

	-- Step 48: The quarry troggs
	["The quarry troggs"] = "採掘場的穴居人",
	-- {area:212} Helm's Bed Lake · {item:268548} Empty Powder Keg
	-- plural, as words: Rockjaw Skullthumpers = {npc:1115} Rockjaw Skullthumper · Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher
	["Rockjaw Skullthumpers fill the quarry; Rockjaw Ambushers by {area:212} drop the {item:268548}."] = "石齶擊顱者遍布採掘場；{area:212}旁的石齶伏擊者會掉落{item:268548}。",

	-- Step 49: Foreman Stonebrow and Quarrymaster Thesten
	-- {npc:1254} Foreman Stonebrow · {npc:1256} Quarrymaster Thesten
	["{npc:1254} and {npc:1256}"] = "{npc:1254}和{npc:1256}",

	-- Step 50: Stolen Blasting Powder
	-- {area:212} Helm's Bed Lake · {quest:95214} Stolen Blasting Powder
	-- plural, as words: Rockjaw Ambushers = {npc:1116} Rockjaw Ambusher · Rockjaw Backbreakers = {npc:1118} Rockjaw Backbreaker
	["Rockjaw Ambushers by {area:212}, north of the quarry, and Rockjaw Backbreakers further east drop the {quest:95214}."] = "採掘場北邊{area:212}旁的石齶伏擊者，以及更東邊的石齶碎脊者，會掉落{quest:95214}。",

	-- Step 51: Leopards and boars
	["Leopards and boars"] = "雪豹與野豬",
	-- {item:2770} Copper Ore
	-- plural, as words: Snow Leopards = {npc:1201} Snow Leopard · Blacksmiths = {area:3421} Blacksmith · Copper Bars = {item:2840} Copper Bar
	["Snow Leopards and boars roam the snow between the ranch and the quarry. Blacksmiths: Copper Bars come from smelting {item:2770} or the trade vendors."] = "雪豹和野豬在牧場與採掘場之間的雪地上遊蕩。鐵匠：銅錠可以熔煉{item:2770}取得，或向商業用品商人購買。",

	-- Step 54: North Gate Outpost
	-- {npc:1960} Pilot Hammerfoot · {area:808} North Gate Outpost
	["{npc:1960} waits at the {area:808}; the dwarven corpse lies up the pass to the west of him."] = "{npc:1960}在{area:808}等候；矮人屍體在他西邊的山路上方。",

	-- Step 55: Hearth to Kharanos
	-- {area:131} Kharanos
	["Hearth to {area:131}"] = "使用爐石前往{area:131}",
	-- {npc:1231} Grif Wildheart
	["{npc:1231}, at the smithy"] = "{npc:1231}，在鐵匠舖",
	-- {npc:258113} Ingrid Dunwald · {npc:257597} Bruegs Kindleborn
	["{npc:258113}: {npc:257597} by the South Gate takes it"] = "{npc:258113}：由南門旁的{npc:257597}接收",
	-- {npc:1226} Maxan Anvol · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:1226}: {npc:376} in {zone:1453} takes it"] = "{npc:1226}：由{zone:1453}的{npc:376}接收",
	-- {npc:1226} Maxan Anvol · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:1226}: {npc:258785} in {zone:1455} takes it"] = "{npc:1226}：由{zone:1455}的{npc:258785}接收",

	-- Step 56: Taming the Beast
	-- {item:15908} Taming Rod · {area:131} Kharanos
	-- plural, as words: Large Crag Boars = {npc:1126} Large Crag Boar · Snow Leopards = {npc:1201} Snow Leopard · Ice Claw Bears = {npc:1196} Ice Claw Bear
	["Each of Grif Wildheart's quests hands you a {item:15908}: use it on the beast he names, then bring the rod back to him at the {area:131} smithy. Large Crag Boars, Snow Leopards and Ice Claw Bears all roam the fields just south and east of {area:131}."] = "格瑞夫的每個任務都會給你一根{item:15908}：對他指定的野獸使用，然後把馴獸棒帶回{area:131}鐵匠舖交給他。大峭壁野豬、雪豹和冰爪熊都在{area:131}南邊和東邊的原野上遊蕩。",
	-- {npc:1126} Large Crag Boar · {item:15908} Taming Rod
	["{npc:1126}: tame it with the {item:15908}"] = "{npc:1126}：用{item:15908}馴服牠",
	-- {npc:1201} Snow Leopard · {item:15908} Taming Rod
	["{npc:1201}: tame it with the {item:15908}"] = "{npc:1201}：用{item:15908}馴服牠",
	-- {npc:1196} Ice Claw Bear · {item:15908} Taming Rod
	["{npc:1196}: tame it with the {item:15908}"] = "{npc:1196}：用{item:15908}馴服牠",
	-- {npc:10090} Belia Thundergranite · {zone:1455} Ironforge
	["{npc:10090} in {zone:1455} takes it"] = "由{zone:1455}的{npc:10090}接收",

	-- Step 57: Shimmerweed
	-- {item:2676} Shimmerweed · {area:137} Brewnall Village
	["{item:2676} bushes grow on the hills around {area:137}."] = "{item:2676}灌木生長在{area:137}周圍的山丘上。",

	-- Step 60: Earthseer Farsen
	-- {area:134} Gol'Bolar Quarry
	["Farsen camps on the ridge overlooking the {area:134} from the west. Talk to him for his farsight."] = "法森在{area:134}西邊俯瞰採掘場的山脊上紮營。與他交談以獲得他的遠視。",
	-- {npc:1977} Senator Mehr Stonehallow
	["{npc:1977}, in the quarry"] = "{npc:1977}，在採掘場裡",

	-- Step 61: Spies and Bonesnappers
	["Spies and Bonesnappers"] = "間諜與斷骨者",
	-- {area:212} Helm's Bed Lake · {item:274268} Dark Iron Map
	-- plural, as words: Rockjaw Bonesnappers = {npc:1117} Rockjaw Bonesnapper
	["Rockjaw Bonesnappers prowl the quarry and {area:212}; Dark Iron Spies sneak around the lake shore, on the way east to the South Gate. One spy drops the {item:274268}."] = "",

	-- Step 62: South Gate Outpost
	-- {area:806} South Gate Outpost · {zone:1432} Loch Modan
	["Follow the road all the way east to the {area:806} at the {zone:1432} tunnel."] = "沿著道路一路向東，前往{zone:1432}隧道處的{area:806}。",

	-- Step 63: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {area:806} South Gate Outpost
	["{npc:257597} waits in a cave above the farm north-west of the {area:806}; the path up starts behind the farm."] = "{npc:257597}在{area:806}西北方農場上方的洞穴裡等候；上山的小路從農場後方開始。",

	-- Step 64: Braldir Ashmantle
	-- {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle
	["Go through the tunnel into {zone:1432}. Just past it, a path marked by stones climbs the hills on the right of the road north to {npc:257808}'s camp."] = "穿過隧道進入{zone:1432}。過了隧道不遠，道路右側有一條以石頭標記的小路，向北爬上山丘通往{npc:257808}的營地。",

	-- Step 65: Fire Tar and the Reagent Pouch
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

	-- Step 66: The Fire Spirit Stone
	["The Fire Spirit Stone"] = "火焰靈石",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember · {object:61934} Brazier of the Dormant Flame
	["{npc:257808} gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of Eternal Flame."] = "{npc:257808}會給你{item:6636}。爬上營地上方的山峰，在靈石旁喝下靈契並擊敗{npc:5893}，然後把牠的{item:6655}放進永恆之火神殿頂端的{object:61934}。",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the Spirit Stone"] = "{item:6636}，在靈石旁邊",

	-- Step 67: Back to Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn
	["Back to {npc:257597}"] = "返回{npc:257597}",
	-- {npc:257597} Bruegs Kindleborn
	["Back through the tunnel to {npc:257597}' cave above the farm."] = "穿過隧道回到農場上方{npc:257597}的洞穴。",
	-- {npc:257597} Bruegs Kindleborn · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:257597}：{npc:2523}、你的{item:5176}和{item:263412}",

	-- Step 70: Tundra MacGrann
	-- {npc:1266} Tundra MacGrann · {area:801} Chill Breeze Valley · {npc:1271} Old Icebeard
	["{npc:1266} camps in {area:801}, south of Brewnall. His meats are in the locker in {npc:1271}'s cave, north-east of his camp. {npc:1271} is an elite yeti: wait out of sight until he wanders off on his patrol, then take the meats and leave before he comes back. You don't need to fight him."] = "",
	-- {item:2667} MacGrann's Dried Meats
	["{item:2667}: the meat locker"] = "{item:2667}：肉櫃",

	-- Step 71: The Tome of Divinity
	-- {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:5149} Brandur Ironhammer · {npc:6179} Tiza Battleforge · {npc:6178} Muiredon Battleforge · {object:32386} Hall of Mysteries · {npc:6175} John Turner · {item:2589} Linen Cloth · {zone:1426} Dun Morogh
	["Follow the road up to {zone:1455} and take the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}, {npc:6179} and {npc:6178} on its upper floor: the stairs up start just north-east of {npc:5149}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "",
	-- {quest:2997} Tome of Divinity
	["From the {quest:2997} she gives you"] = "來自她給你的{quest:2997}",

	-- Step 72: Narm Faulk
	-- {zone:1455} Ironforge · {area:212} Helm's Bed Lake · {npc:6177} Narm Faulk · {item:6866} Symbol of Life
	["Head back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["Use the {item:6866} on {npc:6177}"] = "對{npc:6177}使用{item:6866}",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}：黑鐵間諜",

	-- Step 73: Honor Students
	-- {area:1537} Ironforge · {zone:1432} Loch Modan · {area:144} Thelsamar · {npc:1681} Brock Stoneseeker · {area:2101} Stoutlager Inn
	["Instead of walking back up to {area:1537}, go east through the South Gate tunnel into {zone:1432} and follow the road north to {area:144}. {npc:1681} stands on the east side of town, past the {area:2101}; his errand pays for a flight back to {area:1537}."] = "",
	-- {npc:1572} Thorgrum Borrelson
	["{npc:1572}, the gryphon master"] = "",

	-- Step 74: Golnir Bouldertoe
	-- {npc:4256} Golnir Bouldertoe · {object:32372} Great Forge
	["{npc:4256}, in the {object:32372}"] = "",
	-- {npc:1573} Gryth Thurden
	["{npc:1573}, the gryphon master where you landed"] = "",

	-- Step 75: Muiredon Battleforge
	-- {npc:6179} Tiza Battleforge
	["{npc:6179}: Redemption"] = "{npc:6179}：救贖",

	-- Step 76: Ironforge class quests
	-- {zone:1455} Ironforge
	["{zone:1455} class quests"] = "{zone:1455}職業任務",
	-- {npc:10090} Belia Thundergranite · {object:32390} Hall of Arms · {npc:258785} High Priestess Mims · {object:32386} Hall of Mysteries · {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern
	["{npc:10090} is in the {object:32390}, {npc:258785} in the {object:32386}, {npc:6120} in the {object:32383}."] = "{npc:10090}在{object:32390}，{npc:258785}在{object:32386}，{npc:6120}在{object:32383}。",
	-- {npc:6120} Lago Blackwrench · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6120}: {npc:6122} in {zone:1453} takes it"] = "{npc:6120}：由{zone:1453}的{npc:6122}接收",

	-- Step 77: The Deeprun Tram
	-- {area:2257} Deeprun Tram
	["The {area:2257}"] = "{area:2257}",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["Follow the road up to {zone:1455} and train with your class trainer. The {area:2257} leaves from {object:171524}, in the east of the city. Ride it to {zone:1453}."] = "沿著道路上到{zone:1455}，向你的職業訓練師學習。{area:2257}從城市東邊的{object:171524}出發。搭乘它前往{zone:1453}。",
	-- {npc:1274} Senator Barin Redstone · {object:171709} High Seat
	["{npc:1274}, in the {object:171709} with King Magni"] = "",
	-- {object:660964} Misplaced Packages · {object:171524} Tinker Town
	["{object:660964}, by the mailbox in {object:171524}"] = "{object:660964}，在{object:171524}的郵箱旁",
	-- {npc:258098} Eldrun Stormbreaker · {object:32372} Great Forge
	["{npc:258098}, the shaman trainer, north of the {object:32372}"] = "{npc:258098}，薩滿訓練師，在{object:32372}北邊",

	-- Step 78: Defensive Stance
	-- {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["The tram arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "地鐵抵達{object:28027}。{npc:5480}在{object:2100}訓練戰士；{npc:6089}和{npc:6090}一起站在那裡的{object:2152}旁。{npc:6090}會為了他的杯子和你打一架。",

	-- Step 79: Desperate Prayer
	-- {npc:376} High Priestess Laurena
	["{npc:376} is in the Cathedral of Light."] = "{npc:376}在光明大教堂裡。",

	-- Step 80: Gakin the Darkbinder
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "{npc:6122}在{object:2101}的{object:2164}地下室等候。",

	-- Step 81: Surena Caledon
	-- {zone:1453} Stormwind · {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "從正門離開{zone:1453}，向南前往{area:87}，再沿著道路向東前往{area:62}。{npc:881}（9級）站在農舍旁。",

	-- Step 82: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb · {zone:1436} Westfall · {area:87} Goldshire
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls. {zone:1436} is next, west of {area:87}."] = "回到{npc:6122}處。在{object:2164}地下室的召喚法陣使用{item:6928}，擊敗被召喚出來的虛空行者。下一站是{area:87}西邊的{zone:1436}。",
	["Subdue the voidwalker"] = "制服虛空行者",

	-- Step 83: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "{npc:5497}站在{object:2101}的法師塔裡；她會給你一個裝{quest:1861}瀑布水的瓶子。",

	-- Step 84: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "從正門離開{zone:1453}。{quest:1861}瀑布在城門西南方，位於向西前往{zone:1436}的路上：在瀑布底下裝滿{item:7207}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Braldir gives you the {item:6636}. Climb to the peak above his camp, drink the Sapta beside the Spirit Stone and defeat the {npc:5893}, then place its {item:6655} in the {object:61934}, atop the Shrine of {object:148418}."] = "他會給你{item:6636}。爬上營地上方的山峰，在靈石旁喝下靈契並擊敗{npc:5893}，然後把牠的{item:6655}放進{object:148418}神殿頂端的{object:61934}。",
	-- ["Cornelius is missing in the {area:136}: find him inside, then go back to Gretchen."] = "巡山人在{area:136}失蹤了：到洞裡找到他，然後回到格雷徹處。",
	-- ["Follow the road through the tunnel and north-east to {area:131}. Kill the Crag Boars on the way: their ribs drop before you have {npc:1267}'s quest and count toward it. {npc:1252}, Eric and his campfire are outside the {area:2102}. {npc:6806}, {npc:1226} and {npc:1267} are inside. {npc:1872} works the forge."] = "沿著道路穿過隧道，向東北前往{area:131}。途中擊殺峭壁野豬：在接到{npc:1267}的任務之前，牠們就會掉落肋排，並算入該任務。{npc:1252}、埃瑞克和他的營火在{area:2102}外面。{npc:6806}、{npc:1226}和{npc:1267}在裡面。{npc:1872}在鍛爐工作。",
	-- ["Follow the road up to {zone:1455} and take the {object:32362}: {npc:5149}, {npc:6179} and {npc:6178} are in the {object:32386}. {npc:6175}, a beggar, wanders the city. He asks for ten {item:2589}: the troggs and trolls of {zone:1426} drop it, and the Auction House sells it."] = "沿著道路上到{zone:1455}，走{object:32362}：{npc:5149}、{npc:6179}和{npc:6178}在{object:32386}裡。{npc:6175}是個乞丐，在城裡四處遊蕩。他要十份{item:2589}：{zone:1426}的穴居人和食人妖會掉落，拍賣場也有賣。",
	-- ["Leave {zone:1453} by the main gate, go south to {area:87} and east along the road to the {area:62}. {quest:1688} (level 9) stands by its farmhouse."] = "從正門離開{zone:1453}，向南前往{area:87}，再沿著道路向東前往{area:62}。{quest:1688}（9級）站在農舍旁。",
	-- ["Minor Ice Elementals drift around the frozen lake by the refuge. The three rifles are in the snow around it."] = "{npc:276003}在避難所旁的結冰湖泊周圍漂浮。三把步槍就在周圍的雪地上。",
	-- ["Ride back out of {zone:1455} and east along the road to {area:212}. {npc:6177} lies dead by its shore: use the {item:6866} on him. The Dark Iron Spies sneaking around the lake carry the script."] = "騎出{zone:1455}，沿著道路向東前往{area:212}。{npc:6177}倒在湖岸邊：對他使用{item:6866}。在湖邊潛行的黑鐵間諜身上帶著文稿。",
	-- ["Rockjaw Bonesnappers prowl the quarry and {area:212}; Dark Iron Spies sneak around the lake shore. One spy drops the {item:274268}."] = "石齶斷骨者在採掘場和{area:212}一帶出沒；黑鐵間諜在湖岸周圍潛行。其中一名間諜會掉落{item:274268}。",
	-- ["Sit by Eric's campfire (type /sit) and wait for the buff, then {npc:1699} in the distillery teaches you cooking."] = "坐在埃瑞克的營火旁（輸入 /sit）等待增益效果，然後由釀製廠裡的{npc:1699}教你烹飪。",
	-- ["The ammo crate sits in the Frostmane camp on {area:802}; {npc:1243} camps south of it, by the road to Coldridge."] = "彈藥箱位於{area:802}的霜鬃營地裡；{npc:1243}在營地南邊、通往寒脊山谷的路旁紮營。",
	-- ["The cold"] = "寒冷",
	-- ["{area:135} is the troll cave in the hills west of {area:137}. Kill Headhunters at its mouth and walk through to its far end."] = "{area:135}是{area:137}西邊山丘中的食人妖洞穴。在洞口擊殺霜鬃獵頭者，並一路走到洞穴最深處。",
	-- ["{area:137} sits on the lake north-west of {area:135}."] = "{area:137}位於{area:135}西北方的湖邊。",
	-- ["{npc:1226}, next to {npc:6806}"] = "{npc:1226}，在{npc:6806}旁邊",
	-- ["{npc:1266} camps in {area:801}, south of Brewnall. His meats are in the locker in {npc:1271}'s cave to the north-east of his camp: grab them and leave quickly."] = "{npc:1266}在烈酒村南邊的{area:801}紮營。他的肉在營地東北方{npc:1271}洞穴裡的箱子中：拿了就快走。",
	-- ["{npc:6806}, in the distillery"] = "{npc:6806}，在釀製廠裡",
	-- ["{quest:313} is the wendigo cave south-west of {area:131}. Flintfire's shipments lie on the cave floor."] = "{quest:313}是{area:131}西南方的雪人洞穴。燧火的貨物就散落在洞穴地上。",
}
