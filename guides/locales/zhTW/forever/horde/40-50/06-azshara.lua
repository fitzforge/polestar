-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/06-azshara (forever/horde/40-50/06-azshara.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飛往{object:3202}",
	-- {area:75} Stonard
	["{area:75} flight master"] = "",

	-- Step 3: To Grom'gol
	-- {object:3202} Grom'gol
	["To {object:3202}"] = "前往{object:3202}",
	-- {area:75} Stonard · {area:117} Grom'gol Base Camp
	["The flight from {area:75} lands at {area:117}."] = "",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飛往{area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay · {npc:7406} Oglethorpe Obnoticus
	["Continue south to {area:35}. {npc:7406} has his workshop on the upper ring of the bay."] = "繼續向南前往{area:35}。{npc:7406}的工作室在海灣的上層環道。",
	-- {npc:7406} Oglethorpe Obnoticus
	["{npc:7406}, inside"] = "",
	["Only once all three robots are home"] = "三個機器人都回家後才能做",
	-- {npc:2491} Whiskey Slim
	["{npc:2491}, in the inn"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, on the balcony of the same building"] = "",

	-- Step 7: The Bloodsail ships
	["The Bloodsail ships"] = "血帆海盜船",
	-- {area:43} Wild Shore · {npc:2550} Captain Stillwater · {npc:2548} Captain Keelhaul · {npc:2546} Fleet Master Firallon
	["South of Booty Bay, three Bloodsail ships lie off the {area:43}: {npc:2550}, {npc:2548} and {npc:2546} each stand on a deck with their crews. Swim out and work from ship to ship."] = "",

	-- Step 9: Monogrammed Sash
	-- {quest:8552} The Monogrammed Sash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:8552} needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 14: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 15: Back to Grom'gol
	-- {object:3202} Grom'gol
	["Back to {object:3202}"] = "返回{object:3202}",

	-- Step 16: The Mind's Eye
	-- {npc:818} Mai'Zoth
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:818} (level 47 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back.\nCareful: Two elite caster guards, around level 45, stand with {npc:818} and join the fight together with him."] = "",
	["Below ground"] = "",

	-- Step 20: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",

	-- Step 22: Ride into Azshara
	-- {zone:1447} Azshara
	["Ride into {zone:1447}"] = "騎進{zone:1447}",
	-- {npc:11548} Loh'atu · {area:1235} Shadowsong Shrine · {area:3137} Talrendis Point
	-- plural, as words: Azshara Sentinels = {npc:11276} Azshara Sentinel
	["Ride east along the road out of Splintertree. {npc:11548} waits at the {area:1235} just off the road, a few steps west of the Alliance's {area:3137}: come in from the west and keep clear of the Azshara Sentinels and Jarrodenus (elite)."] = "沿著道路從碎木崗哨向東騎。{npc:11548}在路旁不遠的{area:1235}等候，位於聯盟{area:3137}西邊幾步遠：從西邊過去，避開艾薩拉哨兵和加羅迪努斯（精英）。",

	-- Step 23: Haldarr Encampment: kill these as you meet them
	-- {area:1236} Haldarr Encampment
	["{area:1236}: kill these as you meet them"] = "",
	["The Highborne ghosts haunt the ruins just north of the shrine; the Haldarr satyrs camp a little further north."] = "精靈貴族的鬼魂在神殿北邊的遺跡中出沒；哈達爾薩特在更北邊一點紮營。",
	-- {npc:6117} Highborne Lichling · {area:1235} Shadowsong Shrine
	["{npc:6117} walks around {area:1235}: look inside the circle on the map"] = "",

	-- Step 24: Level 50
	["Level 50"] = "",
	-- {quest:4493} March of the Silithid · {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar · {zone:1447} Azshara · {area:2100} Maraudon · {area:1417} Sunken Temple
	["Top up here to level 50: {quest:4493}, from {npc:7010} in {zone:1454} at the end of {zone:1447}, needs it. Or, with a group, run the {area:2100} dungeon or the {area:1417} dungeon instead."] = "",
	-- {npc:6125} Haldarr Satyr
	["grind on {npc:6125}"] = "",

	-- Step 25: Loh'atu
	-- {npc:11548} Loh'atu · {area:3137} Talrendis Point
	["Back to {npc:11548} at the shrine; stay west of the {area:3137} guards."] = "回到神殿的{npc:11548}處；待在{area:3137}守衛的西邊。",

	-- Step 26: Valormok
	-- {area:1237} Valormok
	["Follow the road north to {area:1237}, the Horde camp."] = "沿著道路向北前往部落營地{area:1237}。",
	-- {npc:8395} Sanath Lim-yo
	["{npc:8395}, at the east edge of the camp: no experience, only a teleport to Azshara Tower"] = "{npc:8395}，在營地東緣：沒有經驗值，只能傳送到艾薩拉的高塔",

	-- Step 28: Undamaged Hippogryph Feathers
	-- plural, as words: Undamaged Hippogryph Feathers = {item:10450} Undamaged Hippogryph Feather
	["Undamaged Hippogryph Feathers"] = "完整的角鷹獸羽毛",
	-- {area:1237} Valormok
	-- plural, as words: Thunderhead Hippogryphs = {npc:6375} Thunderhead Hippogryph
	["The Thunderhead Hippogryphs fly over the hills just south of {area:1237}."] = "雷首角鷹獸在{area:1237}南邊的山丘上空飛翔。",

	-- Step 30: Kim'jael
	-- {area:1227} Bay of Storms
	["Ride north-east to the goblin's camp on the cliffs above the {area:1227}."] = "向東北騎往{area:1227}上方懸崖上的哥布林營地。",

	-- Step 31: Thalassian Base Camp
	-- {npc:8420} Kim'jael
	["The blood elves' camp lies just south of {npc:8420}. His four pieces of equipment lie in the crates around the camp."] = "血精靈的營地就在{npc:8420}南邊。他的四件裝備在營地周圍的箱子裡。",

	-- Step 33: Ruins of Eldarath: kill these as you meet them
	-- {area:1221} Ruins of Eldarath
	["{area:1221}: kill these as you meet them"] = "",
	-- {npc:8420} Kim'jael
	["Ride south-west to the ruins. The four tablets lie among the ruins, guarded by Spitelash naga; any Siren or Myrmidon can carry {npc:8420}'s rune."] = "向西南騎往遺跡。四塊石板在遺跡之間，由惡鞭納迦看守；任何惡鞭海妖或惡鞭侍從都可能帶著{npc:8420}的符文。",

	-- Step 34: Kim'jael
	-- {npc:8420} Kim'jael
	["Back north-east to {npc:8420}."] = "向東北回到{npc:8420}處。",

	-- Step 35: Jediga
	-- {area:1237} Valormok
	["Ride west back to {area:1237}."] = "向西騎回{area:1237}。",
	-- {npc:4046} Magatha Grimtotem · {npc:8659} Jes'rimon · {npc:6522} Andron Gant · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Keep the deliveries for {npc:4046}, {npc:8659} and {npc:6522}: you pass {zone:1456}, {zone:1454} and the {zone:1458} later."] = "保留要交給{npc:4046}、{npc:8659}和{npc:6522}的貨物：你稍後會經過{zone:1456}、{zone:1454}和{zone:1458}。",

	-- Step 36: Archmage Xylem
	-- {area:1237} Valormok
	["Xylem's tower stands on the cliff just north of {area:1237}; the path winds up its north side."] = "克希雷姆的塔位於{area:1237}北邊的懸崖上；小路沿著它的北側蜿蜒而上。",
	["Upstairs"] = "",

	-- Step 38: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "飛往{area:1637}",
	-- {area:1237} Valormok
	["{area:1237} flight master"] = "",

	-- Step 39: Orgrimmar
	-- {npc:8659} Jes'rimon · {object:172960} Cleft of Shadow
	["{npc:8659}, the {object:172960}"] = "{npc:8659}，{object:172960}",
	-- {npc:6986} Dran Droffers
	["{npc:6986}, the Drag"] = "{npc:6986}，在城裡",

	-- Step 40: Orgrimmar
	-- {npc:8659} Jes'rimon · {quest:3504} Betrayed · {area:1237} Valormok
	["Keep {npc:8659}'s payment and Ag'tor's {quest:3504}: they go back to {area:1237} on a later visit."] = "保留{npc:8659}的報酬和阿格圖的{quest:3504}：下次造訪時帶回{area:1237}。",

	-- Step 41: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 42: Fly to Thunder Bluff
	-- {area:1638} Thunder Bluff
	["Fly to {area:1638}"] = "飛往{area:1638}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 43: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {area:1099} Camp Mojache · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:4046} Magatha Grimtotem · {area:1639} Elder Rise · {npc:3033} Turak Runetotem · {npc:246344} Alodan the Hopeful
	["Fly to {zone:1456}; it is on the way to {area:1099}. No flight path there yet? Fly to {area:378} and ride west through {zone:1412}. Hamuul and {npc:4046} are on the {area:1639}; Druids and Paladins train here ({npc:3033}, {npc:246344})."] = "飛往{zone:1456}；它在前往{area:1099}的路上。還沒有那裡的飛行路線？飛往{area:378}，然後向西騎過{zone:1412}。哈繆爾和{npc:4046}在{area:1639}；德魯伊和聖騎士在這裡學習（{npc:3033}、{npc:246344}）。",

	-- Step 44: Class trainer
	["Class trainer"] = "",

	-- Step 45: Thunder Bluff
	-- {quest:3761} Un'Goro Soil · {npc:4046} Magatha Grimtotem · {npc:8587} Jediga
	["{quest:3761} is gathered in the next guide; {npc:4046}'s payment goes back to {npc:8587} later."] = "{quest:3761}在下一份指南中收集；{npc:4046}的報酬稍後交回給{npc:8587}。",

	-- Step 46: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "飛往{area:1099}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "",

	-- Step 47: Camp Mojache
	-- {npc:7776} Talo Thornhoof · {zone:1448} Felwood
	["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}：熊在{zone:1448}",

	-- Step 48: Frayfeather Hippogryphs
	-- plural, as words: Frayfeather Hippogryphs = {npc:5300} Frayfeather Hippogryph
	["Frayfeather Hippogryphs"] = "亂羽角鷹獸",
	["The hippogryphs nest on the hills south-west of the camp. Kill one, then use the Muisek Vessel on its body."] = "角鷹獸在營地西南方的山丘上築巢。殺一隻，然後對牠的屍體使用靈魂精華容器。",

	-- Step 50: Sprite Darters
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["Sprite Darters"] = "小精龍",
	["The faerie dragons flit around the woods just west of the camp. Use the vessel on each one you kill."] = "精靈龍在營地西邊的樹林中飛舞。對你殺死的每一隻使用容器。",

	-- Step 52: Wandering Forest Walkers
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker
	["Wandering Forest Walkers"] = "森林漫遊者",
	-- {zone:1444} Feralas
	["The treants wander the forest roads between the camp and the middle of {zone:1444}; there are only a few, so look along the paths."] = "樹人在營地和{zone:1444}中部之間的林間道路上遊蕩；數量不多，沿著小路找找。",

	-- Step 55: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray · Land Walkers = {npc:5357} Land Walker · Cliff Giants = {npc:5358} Cliff Giant
	["The Sea Elementals and Sea Sprays wash along the shore around the dock.\nThe Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "",

	-- Step 57: Back to Camp Mojache
	-- {area:1099} Camp Mojache
	["Back to {area:1099}"] = "返回{area:1099}",

	-- Step 58: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "飛往{area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "",

	-- Step 59: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}，在雙足飛龍管理員旁",
	-- {npc:7876} Tran'rek · {zone:1449} Un'Goro Crater
	["{npc:7876}'s tar and Pestlezugg's samples come from {zone:1449}."] = "{npc:7876}的焦油和匹斯特蘇格的樣本都來自{zone:1449}。",

	-- Step 60: Marvon Rivetseeker
	-- {area:1938} Broken Pillar · {npc:7771} Marvon Rivetseeker · {zone:1449} Un'Goro Crater
	["Ride south along the road to the {area:1938}; {npc:7771} camps beside it. From here the road west leads down into {zone:1449}, where the next guide starts."] = "沿著道路向南前往{area:1938}；{npc:7771}在旁邊紮營。從這裡往西的道路會下到{zone:1449}，下一份指南從那裡開始。",
	-- {quest:3444} The Stone Circle · {npc:7771} Marvon Rivetseeker
	["Keep {quest:3444}: {npc:7771}'s chest is opened on a later visit."] = "保留{quest:3444}：{npc:7771}的箱子要在下次造訪時打開。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly from {area:1237} to {zone:1454}, walk out of the main gate to the zeppelin towers and take the zeppelin to {object:3202}."] = "從{area:1237}飛往{zone:1454}，走出正門前往飛艇塔，搭乘飛艇前往{object:3202}。",
	-- ["Fly to the {area:1497}"] = "飛往{area:1497}",
	-- ["Follow the road south; the basilisks bask on the rocks east of it in the middle of the jungle. Their shards drop often."] = "沿著道路向南走；蜥蜴在叢林中段、道路東邊的岩石上曬太陽。牠們的碎片很常掉落。",
	-- ["From {area:3317}'s flight master, fly to the {area:1497}."] = "在{area:3317}的飛行管理員處飛往{area:1497}。",
	-- ["Highborne and Haldarr satyrs"] = "精靈貴族與哈達爾薩特",
	-- ["Ironjaw Basilisks"] = "鐵齶蜥蜴",
	-- ["Keep {area:1417} for {npc:7771} in {zone:1446}."] = "保留{area:1417}，交給{zone:1446}的{npc:7771}。",
	-- ["Ride into {area:16}"] = "騎進{area:16}",
	-- ["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "向西北騎往{area:1108}；{npc:14637}在碼頭等候。",
	-- ["Sea elementals"] = "海元素",
	-- ["Take the zeppelin back to {zone:1454}."] = "搭飛艇回到{zone:1454}。",
	-- ["Take the zeppelin to {zone:1454} from the tower outside the {zone:1458}, then fly to {area:431}."] = "在{zone:1458}外的塔搭乘前往{zone:1454}的飛艇，然後飛往{area:431}。",
	-- ["The Land Walkers and Cliff Giants roam the hills north of the dock. Zap each one with {item:18904} first: shrunken, they are no longer elite. Every zapped giant drops residue; use the Muisek Vessel on its body too."] = "大地行者和峭壁巨人在碼頭北邊的山丘上遊蕩。先用{item:18904}電擊每一隻：縮小後牠們就不再是精英。每個被縮小的巨人都會掉落殘渣；也對牠的屍體使用靈魂精華容器。",
	-- ["The Sea Elementals and Sea Sprays wash along the shore around the dock."] = "海元素和巨型海元素在碼頭周圍的岸邊沖刷。",
	-- ["The {object:2076} beside {npc:2519}"] = "{npc:2519}旁邊的{object:2076}",
	-- ["Zapped giants"] = "被縮小的巨人",
	-- ["{npc:7776}: the bears are in {zone:1448}"] = "{npc:7776}：熊在{zone:1448}",
	-- ["{npc:7825} stands in the {object:36082}."] = "{npc:7825}站在{object:36082}。",
}
