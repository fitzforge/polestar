-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:35} Booty Bay · {zone:1447} Azshara · {zone:1444} Feralas · {zone:1446} Tanaris
	["{area:35} first, then {zone:1447}, {zone:1444} and {zone:1446}."] = "先去{area:35}，再去{zone:1447}、{zone:1444}和{zone:1446}。",

	-- Step 2: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飛往{area:35}",

	-- Step 3: Booty Bay
	-- {area:75} Stonard · {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["The flight from {area:75} lands on {area:35}'s upper deck. {npc:7406} has his workshop on the upper ring of the bay."] = "從{area:75}起飛的航班降落在{area:35}的上層平台。{npc:7406}的工作室在海灣的上層環道。",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "{npc:7406}，在屋裡",
	-- {zone:1446} Tanaris
	["\"Sea Wolf\" MacKinley, on the top floor: Stoley's shipment from {zone:1446}"] = "頂樓的「海狼」麥金利：史托利來自{zone:1446}的貨物",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "{npc:2487}，在同一棟樓的陽臺上",

	-- Step 4: Whiskey Slim
	-- {npc:2491} Whiskey Slim · {area:35} Booty Bay
	["{npc:2491} sits in the {area:35} inn."] = "{npc:2491}坐在{area:35}旅店裡。",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "{npc:2491}，在旅店裡",

	-- Step 5: The Bloodsail ships
	["The Bloodsail ships"] = "血帆海盜船",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "在藏寶海灣以南，三艘血帆海盜船停在{area:43}外的海面上：{npc:2550}、{npc:2548}和{npc:2546}各帶船員站在一層甲板上。游過去，一艘一艘清。",

	-- Step 7: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "這些是精英怪：建議組隊，找人一起做。{quest:8552}需要2人小隊。單人可以跳過：本路線會安排你把經驗刷回來。",

	-- Step 12: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飛往{object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}的飛行管理員",

	-- Step 13: Grom'gol Base Camp
	-- {area:117} Grom'gol Base Camp · {npc:2497} Nimboya · {object:2076} Bubbling Cauldron
	["The flight lands at {area:117}; {npc:2497} stands by the {object:2076}."] = "航班降落在{area:117}；{npc:2497}站在{object:2076}旁邊。",

	-- Step 14: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "返回{object:3202}",

	-- Step 15: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "這些是精英怪：建議組隊，找人一起做。{npc:818}（47級精英）需要2人小隊。單人可以跳過：本路線會安排你把經驗刷回來。\n注意：兩名約45級的精英法系護衛與{npc:818}站在一起，會隨他一起加入戰鬥。",
	["Below ground"] = "地下",

	-- Step 17: Saving Yenniku
	["while he is alive: the gem fills; don't kill him"] = "趁他活著：寶石會充滿；不要殺死他",
	-- {item:3912} Soul Gem
	["Use the {item:3912} on Yenniku"] = "對耶尼庫使用{item:3912}",

	-- Step 19: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",

	-- Step 20: Zilzibin Drumlore
	-- {zone:1454} Orgrimmar · {npc:7010} Zilzibin Drumlore · {zone:1446} Tanaris
	["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}."] = "經過{zone:1454}前往飛行管理員的路上，順道進入暗巷區：{npc:7010}收下來自{zone:1446}的昆蟲報告。",
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010}, the Drag"] = "{npc:7010}，暗巷區",

	-- Step 21: Zilzibin Drumlore
	-- {quest:4494} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1447} Azshara · {area:1237} Valormok
	["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, it waits: if you reach 50 in {zone:1447}, this guide brings you back for it from {area:1237}; else the {zone:1447} guide at 55 offers it again."] = "",

	-- Step 22: Dran Droffers
	["The Droffers' shop is a few steps further into the Drag."] = "德羅佛斯的商店在暗巷區再往裡走幾步。",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}，在城裡",

	-- Step 23: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172959} The Drag · {quest:4300} Bone-Bladed Weapons · {zone:1447} Azshara
	["{npc:8659}, in {object:172959}, upstairs in one of its tallest buildings, has {quest:4300} for later; then your class trainer before you leave for {zone:1447}."] = "",
	-- {npc:8659} Jes'rimon · {object:172959} The Drag
	["{npc:8659}, upstairs in {object:172959}"] = "",

	-- Step 24: Zor Lonetree
	-- {npc:4047} Zor Lonetree · {object:172957} Valley of Wisdom · {npc:4791} Nazeer Bloodpike · {zone:1445} Dustwallow Marsh
	["{npc:4047} stands in the {object:172957}: {npc:4791}'s report from {zone:1445}."] = "",

	-- Step 26: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "騎進{zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "沿著道路從碎木崗哨向東騎。{npc:11548}在路旁不遠的{area:1235}等候，位於聯盟{area:3137}西邊幾步遠：從西邊過去，避開艾薩拉哨兵和加羅迪努斯（精英）。",

	-- Step 27: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "{area:1236}：遇到就殺",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "精靈貴族的鬼魂在神殿北邊的遺跡中出沒；哈達爾薩特在更北邊一點紮營。",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "{npc:6117}在{area:1235}一帶走動：檢視地圖上的圓圈範圍",

	-- Step 28: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "回到神殿的{npc:11548}處；待在{area:3137}守衛的西邊。",

	-- Step 29: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "沿著道路向北前往部落營地{area:1237}。",

	-- Step 30: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {zone:1447} Azshara · {area:1637} Orgrimmar · {quest:4493} March of the Silithid · {zone:1456} Thunder Bluff
	["You reached 50 in {zone:1447}: fly back to {area:1637} for {quest:4493} and your level 50 training, then on to {zone:1456}."] = "",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "{area:1237}飛行管理員",

	-- Step 31: Zilzibin Drumlore
	-- {npc:7010} Zilzibin Drumlore
	["{npc:7010} is in the Drag; your class trainer next."] = "",

	-- Step 32: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "{zone:1454}的飛行管理員",

	-- Step 34: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and Magatha are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "飛往{zone:1456}；它在前往{area:1099}的路上。還沒有那裡的飛行路線？飛往{area:378}，然後向西騎過{zone:1412}。哈繆爾和瑪加薩在{area:1639}；德魯伊和聖騎士在這裡學習（{npc:3033}、{npc:246344}）。",
	-- {npc:6746} Innkeeper Pala
	["{npc:6746}, at the inn: for Hamuul"] = "{npc:6746}，在旅店：給哈繆爾",
	-- {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{npc:5769}, on the {area:1639}"] = "{npc:5769}，在{area:1639}",

	-- Step 35: Thunder Bluff
	-- {quest:3761} Un'Goro Soil
	["{quest:3761} is gathered in the next guide."] = "{quest:3761}在下一份指南中收集。",

	-- Step 36: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飛往{area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "{zone:1456}飛行管理員",

	-- Step 38: Camp Mojache
	-- {npc:8115} Witch Doctor Uzer'i
	["{npc:8115}, if you don't carry it yet: the materials come on this loop"] = "",
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}：熊在{zone:1448}",
	-- {npc:7776} Talo Thornhoof
	["{npc:7776}: the Northspring harpies, at the far end of this loop"] = "",

	-- Step 39: Talo Thornhoof
	-- {quest:3062} Dark Heart · {npc:8075} Edana Hatetalon
	["{quest:3062}: {npc:8075} (level 50, elite) roosts above the Northspring harpies this loop ends at. Grouping up is advised: skip it if you are alone."] = "",

	-- Step 40: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "亂羽角鷹獸",
	-- {quest:3128} Natural Materials
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body. Nearly every one also drops the sinew and metallic fragments for {quest:3128}."] = "",

	-- Step 41: Hippogryph nests
	["Hippogryph nests"] = "角鷹獸巢穴",
	-- {area:2522} Ruins of Isildien · {object:142071} Egg-O-Matic
	["The hippogryph nests are on the hills to the south, around the {area:2522}; each holds an egg for the {object:142071}."] = "角鷹獸巢穴位於南邊的山丘上，在{area:2522}周圍；每個巢裡都有一顆要給{object:142071}的蛋。",

	-- Step 43: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "小精龍",
	-- {item:9589} Encrusted Minerals
	-- was: ["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "精靈龍在營地西邊的樹林中飛舞。對你殺死的每一隻使用容器。"
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill; they carry the {item:9589} too."] = "",

	-- Step 45: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "森林漫遊者",
	-- {zone:1444} Feralas · {npc:272401} Vale Screamer
	-- plural, as words: Splintered Logs = {item:9590} Splintered Log
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths. They carry the Splintered Logs too.\nCareful: a {npc:272401} (level 60) flies over the forest west of the camp: keep clear of it."] = "",

	-- Step 47: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	-- was: ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "向西北騎往{area:1108}；{npc:14637}在碼頭等候。"
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "",

	-- Step 48: Forgotten Coast: the water and the shore
	-- {area:1108} Forgotten Coast
	["{area:1108}: the water and the shore"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker · {npc:14637} Zorbin Fandazzle
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray · Water Elemental Cores = {item:18958} Water Elemental Core · Sea Elementals = {npc:5461} Sea Elemental · Deep Striders = {npc:5360} Deep Strider
	["The Sea Sprays (46-48) wash along the shore just south of the dock and drop the Water Elemental Cores, as the Sea Elementals (47-49) do. The Wave and Deep Striders (47-49) wade in the water off the same beach: zap them with {item:18904} first, and shrunken they lose their elite strength.\nThe Ultra-Shrinker lasts two hours: {npc:14637} has a second round once these are done."] = "",
	-- {item:18958} Water Elemental Core
	-- plural, as words: Sea Sprays = {npc:5462} Sea Spray
	["{item:18958}, from the Sea Sprays"] = "{item:18958}，從巨型海元素身上取得",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Deep Striders = {npc:5360} Deep Strider
	["{item:18904}, on the Wave and Deep Striders in the water"] = "{item:18904}，對水中的海浪巨人和深海巨人使用",

	-- Step 50: Forgotten Coast: the giants' hills
	-- {area:1108} Forgotten Coast
	["{area:1108}: the giants' hills"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	-- was: ["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "海元素和巨型海元素在碼頭周圍的海岸邊漂流。\n大地行者和峭壁巨人在碼頭北邊的山丘上遊蕩。先用{item:18904}電擊每一隻：縮小後牠們就不再是精英。每個被縮小的巨人都會掉落殘渣；也對牠的屍體使用靈魂精華容器。"
	["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too.\nThe Sea Elementals and Sea Sprays along the shore have the last cores."] = "",

	-- Step 52: Northspring harpies
	["Northspring harpies"] = "北泉鷹身人",
	["The Northspring harpies nest on the ridges in the far north-west, past the giants' hills. The Windcallers heal, so kill them first and pull one at a time."] = "北泉鷹身人在遙遠西北方的山脊上築巢，就在巨人的山丘過去。北泉喚風者會治療，所以先殺牠們，並且一次拉一隻。",

	-- Step 53: Edana Hatetalon
	-- {npc:8075} Edana Hatetalon
	["{npc:8075} (level 50, elite) roosts on the cliff just north of the harpies' nests. Clear the harpies around her first."] = "",

	-- Step 54: Rage Scar yetis
	["Rage Scar yetis"] = "",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east towards the camp, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}，稀有掉落",

	-- Step 55: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "返回{area:1099}",
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}，在屋裡",

	-- Step 57: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飛往{area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "{area:1099}飛行管理員",

	-- Step 58: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}，在屋裡",

	-- Step 61: Gadgetzan
	-- {area:976} Gadgetzan · {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{area:976}'s Auction House is the last one before Un'Goro. There, {npc:9623} (Chasing {npc:9623}) asks for a {item:10561}, an {skill:202} item, before her escort: buy one here if you want that chain."] = "{area:976}的拍賣場是安戈洛之前的最後一個。在那裡，{npc:9623}（追捕{npc:9623}）會在護送前要一個{item:10561}，這是一件{skill:202}物品：如果你想做這條任務線，就在這裡買一個。",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}，在雙足飛龍管理員旁",

	-- Step 62: The Egg-O-Matic
	-- {object:142071} Egg-O-Matic
	["The {object:142071}"] = "{object:142071}",
	-- {object:142071} Egg-O-Matic
	["The {object:142071}, in the middle of town"] = "{object:142071}，在城鎮中央",

	-- Step 63: Marin Noggenfogger
	-- {zone:1449} Un'Goro Crater
	["Pestlezugg's samples come from {zone:1449}."] = "匹斯特蘇格的樣本來自{zone:1449}。",

	-- Step 64: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "沿著道路向南前往{area:1938}；{npc:7771}在旁邊紮營。從這裡往西的道路會下到{zone:1449}，下一份指南從那裡開始。",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "保留{quest:3444}：{npc:7771}的箱子要在下次造訪時打開。",

	-- Step 65: The Dunemaul Compound
	-- {area:1938} Broken Pillar · {npc:12046} Gor'marok the Ravager · {npc:11758} Andi Lynn · {zone:1446} Tanaris
	["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, if you still carry it from {zone:1446}."] = "",

	-- Step 66: Thistleshrub Valley
	-- {quest:3362} Thistleshrub Valley · {npc:7876} Tran'rek · {zone:1446} Tanaris · {area:976} Gadgetzan
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	-- was: ["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "從營地往西，在前往安戈洛坡道的路上：{quest:3362}的長瘤的灌木獸和灌木塑根者（48-50）是{npc:7876}的任務，從你第一次造訪{zone:1446}時就帶著了。牠們到處遊蕩：一次拉一隻。下一份指南在{area:976}停留時向{npc:7876}繳交，連同{npc:11758}的任務一起。"
	["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (49-50) are {npc:7876}'s, carried from your second {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back north-east to {npc:8420}."] = "向東北回到{npc:8420}處。",
	-- ["Class trainer"] = "職業訓練師",
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "從{area:1237}飛往{zone:1454}，走出正門前往飛艇塔，搭乘飛艇前往{object:3202}。",
	-- ["Fly to the {area:1497}"] = "飛往{area:1497}",
	-- ["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "飛往{zone:1456}；它在前往{area:1099}的路上。還沒有那裡的飛行路線？飛往{area:378}，然後向西騎過{zone:1412}。哈繆爾和{npc:4046}在{area:1639}；德魯伊和聖騎士在這裡學習（{npc:3033}、{npc:246344}）。",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "沿著道路向南走；蜥蜴在叢林中段、道路東邊的岩石上曬太陽。牠們的碎片很常掉落。",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "在{area:3317}的飛行管理員處飛往{area:1497}。",
	-- ["Highborne and Haldarr satyrs"] = "精靈貴族與哈達爾薩特",
	-- ["Ironjaw Basilisks"] = "鐵齶蜥蜴",
	-- ["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "保留要交給{npc:4046}、{npc:8659}和{npc:6522}的貨物：你稍後會經過{zone:1456}、{zone:1454}和{zone:1458}。",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "保留{area:1417}，交給{zone:1446}的{npc:7771}。",
	-- ["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "保留{npc:8659}的報酬和阿格圖的{quest:3504}：下次造訪時帶回{area:1237}。",
	-- ["On the way through {zone:1454} to the flight master, step into the Drag: {npc:7010} takes the insect report from {zone:1446}, and its experience shortens the top-up to 50 in {zone:1447}."] = "經過{zone:1454}前往飛行管理員的路上，順道進入暗巷區：{npc:7010}收下來自{zone:1446}的昆蟲報告，獲得的經驗能縮短在{zone:1447}補到50級的時間。",
	-- ["Only once all three robots are home"] = "三個機器人都回家後才能做",
	-- ["Paladin trainer"] = "聖騎士訓練師",
	-- ["Ride into {area:16}"] = "騎進{area:16}",
	-- ["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "向東北騎往{area:1227}上方懸崖上的哥布林營地。",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "向西北騎往{area:1108}；{npc:14637}在碼頭等候。",
	-- ["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "向西南騎往遺跡。四塊石板在遺跡之間，由惡鞭納迦看守；任何惡鞭海妖或惡鞭侍從都可能帶著{npc:8420}的符文。",
	-- ["Ride west back to {area:1237}."] = "向西騎回{area:1237}。",
	-- ["Sea elementals"] = "海元素",
	-- ["South of the {area:1938} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end: {npc:11758}'s quest, carried from your first {zone:1446} visit."] = "{area:1938}南邊是沙槌食人魔的營地，{npc:12046}在營地東端：這是{npc:11758}的任務，從你第一次造訪{zone:1446}時就帶著了。",
	-- ["Take the zeppelin back to {zone:1454}."] = "搭飛艇回到{zone:1454}。",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "在{zone:1458}外的塔搭乘前往{zone:1454}的飛艇，然後飛往{area:431}。",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "海元素和巨型海元素在碼頭周圍的岸邊沖刷。",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "海元素和巨型海元素在碼頭周圍的海岸邊漂流。\n大地行者和峭壁巨人在碼頭北邊的山丘上遊蕩。先用{item:18904}電擊每一隻：縮小後牠們就不再是精英。每個被縮小的巨人都會掉落殘渣；也對牠的屍體使用靈魂精華容器。",
	-- ["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "雷首角鷹獸在{area:1237}南邊的山丘上空飛翔。",
	-- ["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "血精靈的營地就在{npc:8420}南邊。他的四件裝備在營地周圍的箱子裡。",
	-- ["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "精靈龍在營地西邊的樹林中飛舞。對你殺死的每一隻使用容器。",
	-- ["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "角鷹獸在營地西南方的山丘上築巢。殺一隻，然後對牠的屍體使用靈魂精華容器。",
	-- ["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "樹人在營地和{zone:1444}中部之間的林間道路上遊蕩；數量不多，沿著小路找找。",
	-- ["The {object:2076} beside {npc:2519}"] = "{npc:2519}旁邊的{object:2076}",
	-- ["To {object:3202}"] = "前往{object:3202}",
	-- ["Undamaged Hippogryph Feathers"] = "完整的角鷹獸羽毛",
	-- ["Upstairs"] = "樓上",
	-- ["West from the compound, on the way to Un'Goro's ramp: {quest:3362}'s Gnarled Thistleshrubs and Rootshapers (48-50) are {npc:7876}'s, carried from your first {zone:1446} visit. They wander a lot: pull them one at a time. {npc:7876} takes them on the next guide's {area:976} stop, with {npc:11758}'s."] = "從營地往西，在前往安戈洛坡道的路上：{quest:3362}的長瘤的灌木獸和灌木塑根者（48-50）是{npc:7876}的任務，從你第一次造訪{zone:1446}時就帶著了。牠們到處遊蕩：一次拉一隻。下一份指南在{area:976}停留時向{npc:7876}繳交，連同{npc:11758}的任務一起。",
	-- ["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "克希雷姆的塔位於{area:1237}北邊的懸崖上；小路沿著它的北側蜿蜒而上。",
	-- ["Zapped giants"] = "被縮小的巨人",
	-- ["{area:1108}: kill these as you meet them"] = "{area:1108}：遇到就殺",
	-- ["{area:75} flight master"] = "{area:75}飛行管理員",
	-- ["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344}在{zone:1456}；{zone:1454}沒有聖騎士訓練師",
	-- ["{npc:7010}, the Drag: if you still carry it"] = "{npc:7010}，暗巷區：如果你還帶著它",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}：熊在{zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825}站在{object:36082}。",
	-- ["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "{npc:7876}的焦油和匹斯特蘇格的樣本都來自{zone:1449}。",
	-- ["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}，在營地東緣：沒有經驗值，只能傳送到艾薩拉的高塔",
	-- ["{npc:8659}, the {object:172960}"] = "{npc:8659}，{object:172960}",
	-- ["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761}在下一份指南中收集；{npc:4046}的報酬稍後交回給{npc:8587}。",
	-- ["{quest:4494} needs level 50: {npc:7010}, in the Drag, gives it from then on. Under 50, the {zone:1447} guide at 55 offers it again."] = "{quest:4494}需要50級：之後可向暗巷區的{npc:7010}接受。未滿50級的話，55級的{zone:1447}指南會再提供一次。",
}
