-- Chinese (traditional) (zhTW): the guide forever/horde/30-40/03-arathi-highlands (forever/horde/30-40/03-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飛往{object:3202}",
	-- {area:35} Booty Bay · {object:3202} Grom'gol · {object:1661} The Undercity
	["From {area:35}, fly to {object:3202}. {object:1661} zeppelin leaves from the tower on the west side of the camp."] = "從{area:35}飛往{object:3202}。前往{object:1661}的飛艇從營地西側的塔出發。",
	-- {zone:1458} Undercity
	["Zeppelin to the {zone:1458}"] = "搭飛艇前往{zone:1458}",

	-- Step 2: Orgrimmar
	-- {object:1661} The Undercity · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{object:1661} has no Hunter or Shaman trainer: take the {zone:1454} zeppelin from the same tower instead and train in the city, then take the {zone:1458} zeppelin from the tower outside {zone:1454}'s main gate."] = "{object:1661}沒有獵人或薩滿訓練師：改從同一座塔搭乘前往{zone:1454}的飛艇，在城裡學習，然後在{zone:1454}正門外的塔搭乘前往{zone:1458}的飛艇。",

	-- Step 3: Thunder Bluff
	-- {spell:18960} Teleport: Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "施放{spell:18960}，搭乘{npc:11798}的飛行路線前往{area:1638}；{npc:3033}在{area:1639}訓練你。然後飛往{zone:1454}，在正門外的塔搭乘前往{zone:1458}的飛艇。",

	-- Step 4: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "{zone:1458}的訓練師",
	-- {zone:1458} Undercity · {object:36070} War Quarter · {object:36073} Rogues' Quarter · {object:36082} Magic Quarter · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "趁你在{zone:1458}時學習：訓練師都在{object:36070}、{object:36073}和{object:36082}（聖騎士：{npc:260093}）。",

	-- Step 5: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "飛往{area:272}",
	-- {zone:1458} Undercity · {area:272} Tarren Mill
	["The zeppelin lands at the towers outside the {zone:1458}: ride down into the city and fly to {area:272}."] = "飛艇降落在{zone:1458}外的塔：騎下去進入城市，然後飛往{area:272}。",

	-- Step 6: Boulderfist camp
	["Boulderfist camp"] = "石拳營地",
	-- {area:272} Tarren Mill · {area:1857} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Ride east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "從{area:272}向東騎出，穿過{area:1857}後沿著道路向東走。石拳巨魔和石拳執行者（32-34級）在道路南邊、{area:313}東南方紮營。",

	-- Step 7: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["The violet shards glow just off the road a short way west of {area:321}."] = "紫色的碎片就在{area:321}西邊不遠處的路旁發光。",

	-- Step 8: Hammerfall
	["The orc stronghold at the eastern end of the road. Urda, the wind rider master, stands by the gate."] = "位於道路東端的獸人要塞。雙足飛龍管理員尤爾達站在大門旁。",

	-- Step 9: Highland raptors
	["Highland raptors"] = "高地迅猛龍",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider
	["Highland Striders roam the hills all around {area:321}; both they and the Thrashers further west drop the eyes."] = "高地闊步龍在{area:321}周圍的山丘上遊蕩；牠們和更西邊的高地長尾龍都會掉落眼睛。",

	-- Step 11: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael."] = "在落錘鎮東北方，枯鬚狗頭人在峽谷中挖礦；峽谷口的枯鬚狗頭人以及深處的枯鬚掘地工和枯鬚勘探員都會掉落密斯賴爾之塵。",

	-- Step 12: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "{object:2701}在峽谷的最深處。",

	-- Step 13: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}."] = "每個{object:180105}都是一圈立石；鑰匙放在中央的石頭上。東邊的法陣在{area:321}西北方的山丘上。",

	-- Step 14: Witherbark Village
	["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village."] = "枯木食人妖佔據東南山丘中的村莊。枯木擲斧者守著外圍的小屋；枯木巫醫和枯木獵頭者佔據村莊中心。",

	-- Step 15: Fleshstalker raptors
	["Fleshstalker raptors"] = "獵獸龍",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "高地獵獸龍（36-37級）在南部高地獵食，一群在{area:316}北邊，另一群在它西邊的平原上。一次拉一隻。",

	-- Step 16: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Ride south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "向西南騎往南岸哥布林的海灣。{npc:2766}在海灣上方的懸崖上守望。",

	-- Step 17: Professor Phizzlethorpe
	["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close."] = "護送教授下到岸邊。途中會有兩個刺脊納迦伏擊他：待在他身邊。",

	-- Step 19: Daggerspine shore
	["Daggerspine shore"] = "刺脊海岸",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "在海灣西邊，刺脊襲擊者和刺脊巫師（38-40級）佔據海岸：一次拉一隻。兩艘沉船在外海的淺水中，海圖和航海日誌在船裡；寶石散落在沉船周圍的海底。",

	-- Step 20: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 44"] = "給{area:35}的{npc:2487}，約44級時",

	-- Step 21: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Ride north; the outer circle stands in the middle of the highlands."] = "向北騎；外圍法陣位於高地中央。",

	-- Step 22: Northfold Manor
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["The Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets."] = "辛迪加佔據西北方有圍牆的莊園及其農場；辛迪加路霸、辛迪加雇傭兵和辛迪加巡路者身上帶著血石護符。",

	-- Step 23: The Stone of West Binding
	-- {object:2689} Stone of West Binding
	["The {object:2689}"] = "{object:2689}",
	-- {area:1857} Thoradin's Wall
	["The western circle is near {area:1857}, where you rode in."] = "西邊的法陣在你進來時經過的{area:1857}附近。",

	-- Step 24: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "內圈法陣在西邊法陣的南邊、激流堡的東邊。",
	["The stone's next task needs Fozruk, a level 42 elite: leave it."] = "這塊石頭的下一個任務需要對付42級精英弗茲魯克：先不要做。",

	-- Step 25: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "返回{area:321}",

	-- Step 26: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "石拳蠻兵在{area:321}南邊的巨魔大廳外紮營；石拳法師站在他們之間。一次拉一隻。",

	-- Step 27: Drum Fel
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms
	["{npc:2771}'s next {quest:678} is against Boulderfist elites: leave it."] = "{npc:2771}的下一個{quest:678}要對付石拳精英：先不要做。",

	-- Step 28: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "進入{zone:1418}",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Ride south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "從阿拉希向西南騎過{area:880}，向南穿過{zone:1437}（避開{area:150}），再向東進入{zone:1432}；道路從{zone:1432}往南離開，進入{zone:1418}。沿路向南前往{area:1877}的哥布林營地。",

	-- Step 29: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}：來自{area:439}的菲茲爾·銅栓的信",

	-- Step 30: The Dustbowl
	-- {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl · {area:340} Kargath
	["Ride west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "沿著道路向西騎；{npc:2921}的營地在前往{area:340}半路上的{area:1878}。",

	-- Step 31: Kargath
	-- {area:340} Kargath
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge."] = "{area:340}是建在本區西緣懸崖中的部落要塞。",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "給{area:75}的赫格拉姆，約42級時",

	-- Step 32: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "次級石元素",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats just west of {npc:2921}'s camp. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards: keep them."] = "小型元素在{npc:2921}營地西邊的平地上漂移。本區每個石元素都可能掉落{npc:6868}要的石元素的碎片：保留它們。",

	-- Step 34: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "石元素",
	-- {area:1878} The Dustbowl
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "較大的石元素站在{area:1878}西北方的山坡上；每一隻都會掉落一塊石板。",

	-- Step 36: Coyotes and buzzards
	["Coyotes and buzzards"] = "山狗與禿鷲",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "老峭壁山狗和巨型禿鷲在{area:1878}南邊的盆地中遊蕩。山狗會掉落顎骨和尖牙；只有禿鷲會掉落翅膀和砂囊。",

	-- Step 37: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "巨型石元素",
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["The Greater Rock Elementals (42-44, well above you) wander the gulches in the south-west; the bracers drop about one kill in five. Pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "巨型石元素（42-44級，遠高於你）在西南方的溝壑中遊蕩；護腕大約每擊殺五隻掉落一次。一次拉一隻，戰鬥之間休息，或者不要去打。途中繼續擊殺你還需要的山狗和禿鷲。",

	-- Step 38: Kargath
	-- {area:340} Kargath
	["Ride north back to {area:340}."] = "向北騎回{area:340}。",

	-- Step 39: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}：只有在你帶著{item:2868}時（{skill:164}或拍賣場）",

	-- Step 41: Stonevault troggs
	["Stonevault troggs"] = "石窟穴居人",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "石窟穴居人在{area:1877}南邊、前往{area:345}途中的洞口周圍挖掘；石窟斷骨者和石窟薩滿會掉落碎片。",

	-- Step 42: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "塞爾杜林坐在{area:1877}南邊{area:345}的矮人遺跡中。",

	-- Step 43: Valley of Fangs
	-- {npc:4618} Martek the Exiled
	["Follow the road north; {npc:4618}'s camp is on the way."] = "沿著道路向北走；{npc:4618}的營地就在路上。",

	-- Step 44: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "沿著道路繼續向北；箱子在{area:1517}挖掘場，位於道路西北方遺跡的底部。",

	-- Step 45: Agmond's End
	-- {area:1877} Valley of Fangs
	["Ride back south down the road, past the {area:1877}."] = "沿著道路向南騎回去，經過{area:1877}。",

	-- Step 46: Hearth to Kargath
	-- {area:340} Kargath
	["Hearth to {area:340}"] = "使用爐石前往{area:340}",

	-- Step 47: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "搭飛艇前往{zone:1454}",
	-- {zone:1454} Orgrimmar · {object:3202} Grom'gol
	["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202}."] = "在{object:3202}西側的塔搭乘前往{zone:1454}的飛艇。",
	["Zeppelin tower"] = "飛艇塔",

	-- Step 49: Thunder Bluff
	-- {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:380} Crossroads
	["Your trainer is in {area:1638}, one flight from {zone:1454}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to the {area:380} from there."] = "你的訓練師在{area:1638}，從{zone:1454}飛一趟即可抵達：{npc:3033}（德魯伊）在{area:1639}，{npc:246344}（聖騎士）。然後從那裡飛往{area:380}。",

	-- Step 51: Regthar Deathgate
	-- {area:380} Crossroads · {area:386} Forgotten Pools · {npc:3389} Regthar Deathgate
	["Ride north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "沿著道路從{area:380}向北騎往{area:386}；{npc:3389}在水邊上方的高地守望。",
	-- {npc:5395} Felgur Twocuts · {zone:1443} Desolace
	["for {npc:5395} in {zone:1443}, in the next guide"] = "給{zone:1443}的{npc:5395}，在下一份指南中",

	-- Step 52: Ratchet
	-- {area:380} Crossroads · {area:392} Ratchet
	["Ride back south to the {area:380} and fly to {area:392}."] = "向南騎回{area:380}，飛往{area:392}。",
	-- {item:3713} Soothing Spices · {zone:1445} Dustwallow Marsh
	["{item:3713}, for \"Swamp Eye\" Jarl in {zone:1445}"] = "{item:3713}，給{zone:1445}的「沼澤之眼」加爾",
	-- {zone:1445} Dustwallow Marsh
	["The next guide heads into {zone:1445}."] = "下一份指南前往{zone:1445}。",

	-- Step 53: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "從{area:392}沿著海岸向南騎往{area:720}。{npc:6236}站在競技場旁：踏上格柵開始戰鬥；挑戰者會一次一個上場，最後是{npc:6238}（33級）。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride west along the road; Lotwil's camp sits in the {area:1878} halfway to {area:340}."] = "沿著道路向西騎；魯特維爾的營地在前往{area:340}半路上的{area:1878}。",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "老峭壁山狗和巨型禿鷲在{area:1878}南邊的盆地中遊蕩。山狗會掉落顎骨和尖牙；只有禿鷲會掉落翅膀和砂囊。",
	-- ["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "較大的石元素站在{area:1878}西北方的山坡上；每一隻都會掉落一塊石板。",
	-- ["The {area:380}"] = "{area:380}",
}
