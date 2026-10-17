-- Chinese (traditional) (zhTW): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",
	-- {object:172982} Valley of Strength
	["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "雙足飛龍管理員朵拉斯站在{object:172982}的塔上。",

	-- Step 2: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks
	["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}，在雙足飛龍管理員旁邊。先留著：{quest:1483}在石爪山脈，之後再去",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "{object:3972}海報",
	-- {npc:3453} Wharfmaster Dizzywig
	["{npc:3453}, on the dock"] = "{npc:3453}，在碼頭上",

	-- Step 3: Bruuz
	-- {npc:209797} Bruuz · {area:392} Ratchet
	["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797}在{area:392}碼頭外的港口中游動。{npc:209797}是精英：建議組隊。",

	-- Step 4: Baron Longshore
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "海盜在{area:392}南邊的海灘上紮營；{npc:3467}站在營地南端。",

	-- Step 5: Northwatch Hold
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}在更南邊的海岸上。塞拉摩水兵和塞拉摩醫師（15-16級）會掉落勳章；{npc:3393}（20級）和兩名砲手（19級）站在城堡內和城牆上，這也是要塞留到現在才打的原因。",

	-- Step 6: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465}被鎖在要塞內。和他交談開始護送並緊跟著他：出去的路上塞拉摩士兵會攻擊。他會和你一起走回{area:392}。",

	-- Step 8: Raptor Horns
	-- {area:380} Crossroads · {area:1697} Raptor Grounds · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "赤鱗鐮爪龍在{area:380}南邊、{area:1697}周圍的平原狩獵；牠們會掉落角。下次經過{area:392}時繳交。",

	-- Step 9: Crossroads
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}。先留著：下一份指南中{area:1703}的卡德拉克",
	-- {npc:3428} Korran · {area:390} Field of Giants
	["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}：蛋在{area:390}，之後再去",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}，在塔頂",

	-- Step 10: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "從{area:380}向北騎到{area:384}，在{object:19464}裝滿{item:15842}，然後回{area:380}找{npc:3448}。沒有{skill:182}？他旁邊的{npc:3490}出售{item:2449}，每次三個，賣完要等補貨。",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "向{npc:3490}購買{item:2449}；草藥學家可在平原上採集",

	-- Step 11: Level 20
	["Level 20"] = "20級",
	-- {zone:1454} Orgrimmar · {npc:3354} Sorek · {npc:5892} Searn Firewarder · {area:380} Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "{zone:1454}的20級職業任務（{npc:3354}、{npc:5892}、術士和盜賊訓練師）只在20級後才提供，所以飛之前先在這裡升到20級。{area:380}西南方平原上的雷鷹雛鳥（18級）和{area:388}的科卡爾半人馬（14-15級）是最近值得打的怪；你需要的經驗遠不到一級。",
	-- {area:380} Crossroads
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "在{area:380}西南方刷雷鷹雛鳥",

	-- Step 12: Orgrimmar
	-- {area:1637} Orgrimmar · {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "飛往{area:1637}學習20級技能。{npc:3354}在{object:172958}，{npc:5892}在{object:172957}。",

	-- Step 13: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960}是{object:172982}下方的峽谷。",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}，就在幾步之外",

	-- Step 14: Shenthul
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {quest:2460} The Shattered Salute
	["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401}站在{object:172960}。選取他並輸入 /salute 以完成{quest:2460}。",
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}：{npc:7233}，在{area:382}旁",

	-- Step 15: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018}站在城市西側的{object:172961}。",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}：兩份指南後{zone:1458}的{npc:4606}",

	-- Step 16: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "飛往{area:1638}學習20級技能：{npc:3033}在{area:1639}。",

	-- Step 17: Back to the Crossroads
	-- {area:380} Crossroads
	["Back to the {area:380}"] = "返回{area:380}",

	-- Step 18: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389}站在{area:380}西邊不遠的科卡爾半人馬哨站。",

	-- Step 19: Barak Kodobane
	-- {npc:3394} Barak Kodobane · {npc:3389} Regthar Deathgate
	["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394}站在{npc:3389}西北方的科卡爾半人馬營地。",
	-- {item:15852} Kodo Horn
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}：科卡爾營地周圍平原上的落單的草原科多獸",
	-- {item:2449} Earthroot
	["{item:2449}: herbalists pick it here"] = "{item:2449}：草藥學家可在這裡採集",

	-- Step 21: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197}住在{area:2539}，那是從{npc:3389}往西的道路盡頭、剛進入石爪山脈的食人妖村落。",

	-- Step 22: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "向北前往{area:383}。{npc:3682}在丘陵下紮營；他身後山脊上的隱士{npc:261366}，要等{npc:3682}派你上去後才會有工作給你。",

	-- Step 23: Dry Hills
	-- {area:392} Ratchet · {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them, so do both here and skip the Matriarchs by {area:392}. {quest:876} leads the Witchwing harpies in the hills to the west."] = "",

	-- Step 26: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119}和他的水兵佔據{npc:261366}南邊的失事商隊。",

	-- Step 27: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "協助{npc:261366}：{npc:261367}和{area:21}水兵爬上山脊時，待在他身邊",

	-- Step 28: Strange Lockbox
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792}在{area:382}北緣，風險投資公司的塔旁。裡面有{quest:30}所需的{item:15883}。",

	-- Step 29: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "向東前往{area:382}。{npc:3439}在風險投資公司營地裡；{npc:3445}身上帶著鑰匙。",

	-- Step 30: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "伐木機的主人會駕駛它離開營地：跟著他，擊殺任何攻擊他的東西。{area:392}的{npc:3442}接受繳交。",

	-- Step 31: Taskmaster Fizzule
	-- {area:382} Sludge Fen
	["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "工頭費蘇勒管理{area:382}東端的風險投資公司營地。他會攻擊陌生人：在他動手前選取他並 /salute。",

	-- Step 32: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "保持潛行：{npc:7287}身上帶著塔的鑰匙；加里維克斯和他的帶鎖箱在塔頂。加里維克斯是精英：建議組隊。",
	["Venture Co. tower"] = "風險投資公司的塔",

	-- Step 33: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "地區東北角礦坑的風險投資公司監工和風險投資公司執行者會掉落{item:5097}。",

	-- Step 34: Hearth to the Crossroads
	-- {area:380} Crossroads
	["Hearth to the {area:380}"] = "用爐石回到{area:380}",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "他會給你{item:15826}",

	-- Step 35: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:380} Crossroads
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395}在{area:380}東南方{area:388}的科卡爾半人馬之間走動。",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve · {area:380} Crossroads
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}：對牠們使用{item:15826}；牠們在{area:380}周圍的平原各處遊蕩",

	-- Step 36: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "沿{area:458}向南前往{area:378}。",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}，在籠子裡",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}，在營地北緣",

	-- Step 37: Bristleback camps
	["Bristleback camps"] = "刺背營地",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {item:5075} Blood Shard · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "刺背野豬人的營地散布在{area:378}北邊的平原，{area:458}兩側都有。每個刺背野豬人都會掉落獠牙；{npc:3432}的妻子躺在北緣。留一個{item:5075}。灰色科多獸{quest:883}有時在這裡遊蕩：牠的蹄子會開啟任務。",

	-- Step 38: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "步兵多格蘭被鎖在道路西邊的野豬人營地裡。",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "先留著：本指南最後在{zone:1454}找{npc:5875}",

	-- Step 40: Stolen Silver
	-- {area:385} Northwatch Hold
	["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "向東穿過平原往海岸走：被偷的銀子在{area:385}西北方的迅猛龍巢裡。",

	-- Step 41: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901}在{area:392}南邊的山丘上等著，就在你往北的路上。",

	-- Step 43: Ishamuhale
	-- {quest:882} Ishamuhale · {area:392} Ratchet · {area:380} Crossroads
	["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "大型赤鱗迅猛龍{quest:882}在從{area:392}到{area:380}的道路北邊平原狩獵。",

	-- Step 44: Crossroads
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "繳交{quest:4921}後，{npc:3432}會提供{quest:95774}",

	-- Step 46: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396}率領{npc:3389}南邊、{area:387}西岸的科卡爾半人馬。最後一次在{area:380}停留時，把他的頭交給{npc:3389}。",

	-- Step 47: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik · {area:380} Crossroads
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "在沿{area:458}返回{area:378}的路上：營地北邊道路兩側、刺背營地之間的剃鬃劫掠者身上帶著{item:277277}。最後一次在{area:380}停留時交給{npc:3432}。",

	-- Step 48: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "再次沿{area:458}往南前往{area:378}。",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "先留著：下一份指南中{zone:1440}的{npc:12696}",

	-- Step 49: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "電角蜥蜴在{area:378}南邊不遠的平原吃草。藍色雷霆蜥蜴{quest:884}在牠們之間遊蕩：牠的尾刺會開啟任務。",

	-- Step 51: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "雷鷹破雲者在營地南邊同一片平原上空盤旋。",

	-- Step 53: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Harvesters = {npc:3253} Silithid Harvester
	["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "在陶拉祖營地南邊，異種蠍土丘散布在{area:390}；蛋就在土丘裡，異種群居蠍會出來保護。異種收割者很稀有：看到就殺掉取得頭部。",

	-- Step 54: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan
	["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341}在更南邊、通往{area:359}道路上的小營地等著。",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}，在{npc:3341}東邊不遠的樹上",
	-- {npc:5899} Brine · {npc:3341} Gann Stonespire
	["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}，在{npc:3341}西邊不遠",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "在野豬人水坑裝滿{item:7766}",
	-- {object:107045} Spring Well · {area:272} Tarren Mill
	["Keep it: the {object:107045} is beside {area:272}"] = "先留著：{object:107045}在{area:272}旁邊",

	-- Step 55: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {npc:3238} Stormhide · {npc:3341} Gann Stonespire · {quest:885} Washte Pawne
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "在{npc:3341}西邊，鋼鬃野豬人佔據{area:1701}。{npc:3436}在東側，{npc:3434}在南邊，{npc:3435}在西端。洛克·奧克班恩（25級）和鋼鬃戰士（24-25級）比你高幾級；稀有精英{npc:5859}有時會在山脊上走動：別惹他。鋼鬃探路者和鋼鬃捕獵者會掉落鋼鬃背刺匕首，鋼鬃先知會掉落魔杖，鋼鬃戰士會掉落鋼鬃大盾。{npc:3238}蜥蜴和亂齒捕獵者在加恩·石塔與山脊之間的平原遊蕩。稀有的紅色風蛇{quest:885}在山脊上空飛行：牠的羽毛會開啟任務。",
	-- {npc:3238} Stormhide · {npc:3341} Gann Stonespire
	["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}，在{npc:3341}與山脊之間的平原",

	-- Step 56: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "在加恩·石塔南邊，巴爾丹矮人在{area:359}挖掘。巴爾丹挖掘者和巴爾丹工頭在坑中工作；{npc:3392}（26級）身上帶著日誌：單獨把他拉過來。",

	-- Step 58: Bael'dun fortress
	["Bael'dun fortress"] = "巴爾丹要塞",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "巴爾丹士兵、巴爾丹火槍手和巴爾丹軍官守衛著挖掘場東側的要塞；三樣物品都由他們掉落。",

	-- Step 60: The flying machine
	["The flying machine"] = "飛行器",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "矮人的飛行器停在挖掘場內的平台上。",

	-- Step 62: Twitching Antennae
	["Twitching Antennae"] = "抽動的觸鬚",
	-- {area:390} Field of Giants · {area:378} Camp Taurajo
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer
	["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "觸鬚掉落十五分鐘後就會消失，所以現在在往北的回程路上收集：在{area:390}的土丘擊殺異種群居蠍和異種爬行者直到收集五個，然後立刻用爐石回到{area:378}。",
	["Twitching Antennae from the silithid"] = "從異種蠍身上取得抽動的觸鬚",

	-- Step 66: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads
	["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878}在{area:380}東邊的道路旁紮營。",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "他接著提供{quest:1838}（1838，30級）：需要{area:1717}，並會讓你跑遍卡林多和東部王國。戰士職業指南{quest:1838}涵蓋此任務。",

	-- Step 67: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} to train."] = "飛往{area:1637}訓練。",

	-- Step 68: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344}在{area:1638}訓練聖騎士。你還沒有那裡的飛行路線：飛往{area:378}，向西騎過{zone:1412}並搭升降梯上去，在中央高台向{npc:2995}學習飛行路線。",

	-- Step 69: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875}站在{object:172960}。在那裡的召喚法陣使用{item:6626}，擊敗魅魔以束縛她。",

	-- Step 70: Shenthul
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{area:272}的{npc:2391}教授毒藥：先留著",

	-- Step 71: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "飛往{area:1638}訓練：{npc:3033}在{area:1639}。",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "施放{spell:18960}。牛頭人：在見{area:2361}的{npc:11802}之前，先在湖西北岸的{area:2362}合成兩半墜飾。",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885}：在{area:2362}使用一半墜飾",
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}：{npc:3033}的歡迎",

	-- Step 73: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "牛頭人：{npc:11957}在橋上方的南邊山丘等著。天裔精靈：{npc:272054}站在雙橋南邊。然後前往湖東邊的獸穴：解除變形，點擊入口的雕像獲得五分鐘的潛行，避開裡面的靈魂，每種聖物各拿一個；{item:280680}在白貓雕像的腳下。",

	-- Step 75: Turak Runetotem
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{area:2361}的{npc:11798}會載德魯伊飛到那裡",

	-- Step 76: Back to the Crossroads
	-- {area:380} Crossroads · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "飛回{area:380}。下一份指南從這裡開始，沿道路向北前往{area:1703}和{zone:1440}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bruuz"] = "布魯茲",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "草原獅王在丘陵東邊的平原遊蕩，發動過的陷阱就在牠們之間。{quest:876}率領西邊丘陵中的巫翼鷹身人。",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790}在{area:382}北緣，風險投資公司的塔旁。裡面有{quest:30}所需的{item:15883}。",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{area:272}的{npc:2391}教授{spell:2842}：先留著",
}
