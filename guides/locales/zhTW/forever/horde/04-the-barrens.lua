-- Chinese (traditional) (zhTW): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Crossroads
	["Fly to Crossroads"] = "",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "",

	-- Step 2: The road west
	["The road west"] = "",
	["The road west past Seereth's camp"] = "",

	-- Step 3: Malaka'jin
	-- {npc:3995} Witch Doctor Jin'Zil · {area:2539} Malaka'jin · {area:1076} Webwinder Path
	["Follow the road west past Regthar's bunkers and Seereth's camp into Stonetalon: {npc:3995} waits below ground in {area:2539}, at the foot of the {area:1076}."] = "",
	-- {npc:3995} Witch Doctor Jin'Zil
	["{npc:3995}, below ground"] = "",

	-- Step 4: Sun Rock Retreat
	-- {area:1076} Webwinder Path · {npc:4201} Ziz Fizziks · {area:460} Sun Rock Retreat
	["Up the {area:1076} past {npc:4201} and west to {area:460}."] = "",
	-- {npc:11862} Tsunaman · {npc:12736} Je'neu Sancrea
	["{npc:11862}: {npc:12736} at Zoram'gar, next guide"] = "",
	-- {npc:11860} Maggran Earthbinder · {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["{npc:11860}: {npc:12576} is at the {area:1718}, later in this guide"] = "",
	-- {npc:11860} Maggran Earthbinder
	-- plural, as words: Glittering Sunstones = {item:277936} Glittering Sunstone
	["{npc:11860}: Glittering Sunstones from the Bloodfury harpies"] = "{npc:11860}：從血怒鷹身人身上取得閃亮日長石",
	-- {npc:4198} Braelyn Firehand
	["{npc:4198}, outside the gate"] = "{npc:4198}，在大門外",

	-- Step 5: Gaea Seeds
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["Gaea Seeds"] = "蓋亞之種",
	-- {area:464} Mirkfallon Lake
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["The Gaea Seeds lie in the grass around the southern shore of {area:464}, north of Sun Rock.\nCareful: Pridewings around the lake can aggro as a linked group."] = "",

	-- Step 6: Stonetalon Mountains: kill these as you meet them
	-- {zone:1442} Stonetalon Mountains
	["{zone:1442}: kill these as you meet them"] = "",
	-- {area:467} Stonetalon Peak
	-- plural, as words: Antlered Coursers = {npc:4018} Antlered Courser · Sap Beasts = {npc:4020} Sap Beast · Twilight Runners = {npc:4067} Twilight Runner · Fey Dragons = {npc:4016} Fey Dragon
	["Follow the road north toward {area:467}. Antlered Coursers graze along the way; the Sap Beasts, Twilight Runners and Fey Dragons roam the woods below the Peak, and the Cenarion druids hold the grove there."] = "沿著道路向北前往{area:467}。巨角鹿在沿途覓食；腐蝕獸、夜行虎和靈龍在山峰下方的樹林中遊蕩，塞納里奧德魯伊則佔據那裡的樹林。",

	-- Step 7: Sun Rock Retreat
	-- {npc:4198} Braelyn Firehand · {zone:1440} Ashenvale
	["{npc:4198}'s next quest, Ordanus, is on the Alliance side of {zone:1440}. Skip it."] = "{npc:4198}的下一個任務「奧達努斯」在{zone:1440}的聯盟那一側。跳過。",

	-- Step 8: The Charred Vale: kill these as you meet them
	-- {area:465} The Charred Vale
	["{area:465}: kill these as you meet them"] = "",
	-- {area:465} The Charred Vale · {item:16312} Incendrites
	-- plural, as words: Gaea Seeds = {item:16205} Gaea Seed
	["South-west of Sun Rock lies the burned {area:465}. Plant the Gaea Seeds in the dirt mounds on the valley floor; the fire elementals drop {item:16312}. Bloodfury Harpies and Ambushers nest on the north side, Slayers and Roguefeathers to the south."] = "烈日石居西南方是燒焦的{area:465}。把蓋亞之種種在谷底的土堆裡；火元素會掉落{item:16312}。血怒鷹身人和血怒伏擊者在北側築巢，血怒殺戮者和血怒遊蕩者在南側。",
	-- {item:277936} Glittering Sunstone
	["{item:277936}, from any Bloodfury harpy"] = "{item:277936}，來自任何血怒鷹身人",
	-- plural, as words: Gaea Dirt Mounds = {object:177929} Gaea Dirt Mound
	["Gaea Dirt Mounds"] = "蓋亞土堆",

	-- Step 9: Sun Rock Retreat
	-- {npc:11861} Mor'rogal · {npc:11862} Tsunaman
	["{npc:11861}, beside {npc:11862}"] = "{npc:11861}，在{npc:11862}旁邊",
	-- {npc:11862} Tsunaman
	["{npc:11862}, up on the ledge"] = "{npc:11862}，在上方的岩架上",

	-- Step 10: Malaka'jin
	-- {area:1076} Webwinder Path · {area:2539} Malaka'jin
	["Head back down the {area:1076} to {area:2539}."] = "",

	-- Step 11: To Camp Taurajo
	-- {area:378} Camp Taurajo
	["To {area:378}"] = "",

	-- Step 12: Camp Taurajo
	-- {area:2539} Malaka'jin · {area:378} Camp Taurajo
	["From {area:2539} follow the road east to Seereth's camp, then south-east across the plains to {area:378}."] = "",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}，在營地北緣",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}，在籠子裡",

	-- Step 13: Grunt Logmar
	-- {npc:5911} Grunt Logmar · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["{npc:5911} stands by the flight master. His {npc:268623} (23) is elite: grouping up is advised; the two Encroaching Soldiers are not."] = "",
	-- {npc:5911} Grunt Logmar · {npc:3341} Gann Stonespire
	["{npc:5911}: the soldiers and the pillager camp just east of {npc:3341}, on the way south"] = "",

	-- Step 15: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {area:359} Bael Modan
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}, on the way to {area:359}."] = "{npc:5899}的小屋在{area:378}南邊、野豬人水坑上方的山脊上，在前往{area:359}的路上。",
	-- {npc:5899} Brine · {area:272} Tarren Mill
	["{npc:5899}: the red waterskin from {area:272}"] = "{npc:5899}：來自{area:272}的紅色水袋",
	-- {npc:5899} Brine · {zone:1440} Ashenvale
	["{npc:5899}: the blue waterskin is filled in {zone:1440}, next guide"] = "{npc:5899}：藍色水袋在下一份指南的{zone:1440}裝滿",

	-- Step 16: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan · {npc:14242} Sulhasa
	["{npc:3341} walks the road south toward {area:359}, between about 46,75 and 46,81: if he isn't at the arrow, follow the road until you meet him. {npc:14242} sits up in the tree just east of the road at 47.9,77.5."] = "",
	-- {npc:3341} Gann Stonespire · {area:1701} Blackthorn Ridge
	["{npc:3341} walks around {area:1701}: look inside the circle on the map"] = "",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}，在{npc:3341}東邊不遠的樹上",

	-- Step 17: Wrongly Blamed, Justly Corrected
	-- {npc:14242} Sulhasa · {npc:268623} Outraged Pillager
	-- plural, as words: Encroaching Soldiers = {npc:268622} Encroaching Soldier
	["A few steps east of {npc:14242}'s tree, a small camp: two Encroaching Soldiers and the {npc:268623} for Logmar. The {npc:268623} is elite: grouping up is advised."] = "",

	-- Step 18: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone.\nCareful: Excavators (level 21-22) and Foremen (level 22-23) run off for help once they fall to 15% health, so more dwarves can join the fight."] = "",
	-- {npc:3375} Bael'dun Foreman · {area:359} Bael Modan
	["{npc:3375} walks around {area:359}: look inside the circle on the map"] = "",

	-- Step 19: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {quest:885} Washte Pawne · {spell:1752} Sinister Strike
	-- plural, as words: Razormane Stalkers = {npc:3457} Razormane Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest.\nCareful: Razormane Stalkers move around in stealth and hit with {spell:1752}, so they can join a fight without warning."] = "",

	-- Step 20: Field to Clear
	-- {npc:3341} Gann Stonespire · {npc:3238} Stormhide
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["On the way back east to {npc:3341}: Hecklefang Stalkers and {npc:3238} lizards roam the plain between the ridge and his camp."] = "",
	-- {npc:4128} Hecklefang Stalker · {area:1156} Southern Barrens
	["{npc:4128} walks around {area:1156}: look inside the circle on the map"] = "",

	-- Step 22: Bael'dun fortress
	["Bael'dun fortress"] = "巴爾丹要塞",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them.\nCareful: Riflemen (level 24-25) Shoot from 5-30 yd, so nearby ones can join a fight from range."] = "",

	-- Step 24: The flying machine
	["The flying machine"] = "飛行器",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "矮人的飛行器停在挖掘場內的平台上。",

	-- Step 26: Great Lift
	-- {area:1718} Great Lift
	["The top of the {area:1718}"] = "",

	-- Step 27: Great Lift
	-- {npc:12576} Grish Longrunner · {area:1718} Great Lift
	["South-west of Bael Modan, {npc:12576} waits at the top of the {area:1718}."] = "",

	-- Step 28: The Great Lift
	-- {area:1718} Great Lift
	["The {area:1718}"] = "{area:1718}",
	-- {npc:10079} Brave Moonhorn · {area:1718} Great Lift · {npc:12576} Grish Longrunner
	["{npc:10079} stands at the top of the {area:1718}, beside {npc:12576}."] = "",
	-- {npc:10079} Brave Moonhorn
	["{npc:10079}, at the top of the lift"] = "{npc:10079}，在升降梯頂端",

	-- Step 31: Grunt Logmar
	-- {npc:5911} Grunt Logmar
	["{npc:5911}, beside the flight master"] = "",

	-- Step 32: Fly to Crossroads
	-- {area:378} Camp Taurajo
	["{area:378} flight master"] = "",

	-- Step 33: The Crossroads
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}，在塔頂",

	-- Step 34: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "飛往{area:392}",
	["Crossroads flight master"] = "",

	-- Step 35: Merchant Coast
	-- {quest:874} Mahren Skyseer · {area:392} Ratchet
	["{quest:874} camps on the shore just north of {area:392}'s flight master."] = "",

	-- Step 36: Isha Awak
	-- {quest:873} Isha Awak · {area:391} Merchant Coast · {npc:3388} Mahren Skyseer
	["{quest:873}, a big threshadon, swims in the shallows off the {area:391}, east of {npc:3388}."] = "{quest:873}是一隻巨大的長頸龍，在{area:391}外的淺水中游動，位於{npc:3388}東邊。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "協助{npc:261366}：{npc:261367}和{area:21}水兵爬上山脊時，待在他身邊",
	-- ["Back to the {area:380}"] = "返回{area:380}",
	-- ["Bristleback camps"] = "刺背營地",
	-- ["Bruuz"] = "布魯茲",
	-- ["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "施放{spell:18960}。牛頭人：在見{area:2361}的{npc:11802}之前，先在湖西北岸的{area:2362}合成兩半墜飾。",
	-- ["Dogran is chained up in the quilboar camp west of the road."] = "步兵多格蘭被鎖在道路西邊的野豬人營地裡。",
	-- ["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "雙足飛龍管理員朵拉斯站在{object:172982}的塔上。",
	-- ["Down the {area:458} to {area:378} again."] = "再次沿{area:458}往南前往{area:378}。",
	-- ["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "向東穿過平原往海岸走：被偷的銀子在{area:385}西北方的迅猛龍巢裡。",
	-- ["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "向東前往{area:382}。{npc:3439}在風險投資公司營地裡；{npc:3445}身上帶著鑰匙。",
	-- ["Fill the {item:7766} at the quilboar watering hole"] = "在野豬人水坑裝滿{item:7766}",
	-- ["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "工頭費蘇勒管理{area:382}東端的風險投資公司營地。他會攻擊陌生人：在他動手前選取他並 /salute。",
	-- ["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "飛回{area:380}。下一份指南從這裡開始，沿道路向北前往{area:1703}和{zone:1440}。",
	-- ["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "飛往{area:1637}學習20級技能。{npc:3354}在{object:172958}，{npc:5892}在{object:172957}。",
	-- ["Fly to {area:1637} to train."] = "飛往{area:1637}訓練。",
	-- ["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "飛往{area:1638}學習20級技能：{npc:3033}在{area:1639}。",
	-- ["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "飛往{area:1638}訓練：{npc:3033}在{area:1639}。",
	-- ["Follow the {area:458} south to {area:378}."] = "沿{area:458}向南前往{area:378}。",
	-- ["He gives you the {item:15826}"] = "他會給你{item:15826}",
	-- ["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "他接著提供{quest:1838}（1838，30級）：需要{area:1717}，並會讓你跑遍卡林多和東部王國。戰士職業指南{quest:1838}涵蓋此任務。",
	-- ["Hearth to the {area:380}"] = "用爐石回到{area:380}",
	-- ["Keep it: the {object:107045} is beside {area:272}"] = "先留著：{object:107045}在{area:272}旁邊",
	-- ["Keep it: {npc:12696} in {zone:1440}, next guide"] = "先留著：下一份指南中{zone:1440}的{npc:12696}",
	-- ["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "先留著：本指南最後在{zone:1454}找{npc:5875}",
	-- ["Level 20"] = "20級",
	-- ["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "向北前往{area:383}。{npc:3682}在丘陵下紮營；他身後山脊上的隱士{npc:261366}，要等{npc:3682}派你上去後才會有工作給你。",
	-- ["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "在沿{area:458}返回{area:378}的路上：營地北邊道路兩側、刺背營地之間的剃鬃劫掠者身上帶著{item:277277}。最後一次在{area:380}停留時交給{npc:3432}。",
	-- ["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "從{area:380}向北騎到{area:384}，在{object:19464}裝滿{item:15842}，然後回{area:380}找{npc:3448}。沒有{skill:182}？他旁邊的{npc:3490}出售{item:2449}，每次三個，賣完要等補貨。",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "草原獅王在丘陵東邊的平原遊蕩，發動過的陷阱就在牠們之間。{quest:876}率領西邊丘陵中的巫翼鷹身人。",
	-- ["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "在陶拉祖營地南邊，異種蠍土丘散布在{area:390}；蛋就在土丘裡，異種群居蠍會出來保護。異種收割者很稀有：看到就殺掉取得頭部。",
	-- ["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "在加恩·石塔南邊，巴爾丹矮人在{area:359}挖掘。巴爾丹挖掘者和巴爾丹工頭在坑中工作；{npc:3392}（26級）身上帶著日誌：單獨把他拉過來。",
	-- ["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "保持潛行：{npc:7287}身上帶著塔的鑰匙；加里維克斯和他的帶鎖箱在塔頂。加里維克斯是精英：建議組隊。",
	-- ["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "赤鱗鐮爪龍在{area:380}南邊、{area:1697}周圍的平原狩獵；牠們會掉落角。下次經過{area:392}時繳交。",
	-- ["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "牛頭人：{npc:11957}在橋上方的南邊山丘等著。天裔精靈：{npc:272054}站在雙橋南邊。然後前往湖東邊的獸穴：解除變形，點擊入口的雕像獲得五分鐘的潛行，避開裡面的靈魂，每種聖物各拿一個；{item:280680}在白貓雕像的腳下。",
	-- ["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "巴爾丹士兵、巴爾丹火槍手和巴爾丹軍官守衛著挖掘場東側的要塞；三樣物品都由他們掉落。",
	-- ["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "刺背野豬人的營地散布在{area:378}北邊的平原，{area:458}兩側都有。每個刺背野豬人都會掉落獠牙；{npc:3432}的妻子躺在北緣。留一個{item:5075}。灰色科多獸{quest:883}有時在這裡遊蕩：牠的蹄子會開啟任務。",
	-- ["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "地區東北角礦坑的風險投資公司監工和風險投資公司執行者會掉落{item:5097}。",
	-- ["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "觸鬚掉落十五分鐘後就會消失，所以現在在往北的回程路上收集：在{area:390}的土丘擊殺異種群居蠍和異種爬行者直到收集五個，然後立刻用爐石回到{area:378}。",
	-- ["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "{zone:1454}的20級職業任務（{npc:3354}、{npc:5892}、術士和盜賊訓練師）只在20級後才提供，所以飛之前先在這裡升到20級。{area:380}西南方平原上的雷鷹雛鳥（18級）和{area:388}的科卡爾半人馬（14-15級）是最近值得打的怪；你需要的經驗遠不到一級。",
	-- ["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "海盜在{area:392}南邊的海灘上紮營；{npc:3467}站在營地南端。",
	-- ["The {area:2363}"] = "{area:2363}",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960}是{object:172982}下方的峽谷。",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177790}在{area:382}北緣，風險投資公司的塔旁。裡面有{quest:30}所需的{item:15883}。",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792}在{area:382}北緣，風險投資公司的塔旁。裡面有{quest:30}所需的{item:15883}。",
	-- ["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "雷鷹破雲者在營地南邊同一片平原上空盤旋。",
	-- ["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "電角蜥蜴在{area:378}南邊不遠的平原吃草。藍色雷霆蜥蜴{quest:884}在牠們之間遊蕩：牠的尾刺會開啟任務。",
	-- ["Twitching Antennae"] = "抽動的觸鬚",
	-- ["Twitching Antennae from the silithid"] = "從異種蠍身上取得抽動的觸鬚",
	-- ["Venture Co. tower"] = "風險投資公司的塔",
	-- ["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "在{npc:3341}西邊，鋼鬃野豬人佔據{area:1701}。{npc:3436}在東側，{npc:3434}在南邊，{npc:3435}在西端。洛克·奧克班恩（25級）和鋼鬃戰士（24-25級）比你高幾級；稀有精英{npc:5859}有時會在山脊上走動：別惹他。鋼鬃探路者和鋼鬃捕獵者會掉落鋼鬃背刺匕首，鋼鬃先知會掉落魔杖，鋼鬃戰士會掉落鋼鬃大盾。{npc:3238}蜥蜴和亂齒捕獵者在加恩·石塔與山脊之間的平原遊蕩。稀有的紅色風蛇{quest:885}在山脊上空飛行：牠的羽毛會開啟任務。",
	-- ["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "伐木機的主人會駕駛它離開營地：跟著他，擊殺任何攻擊他的東西。{area:392}的{npc:3442}接受繳交。",
	-- ["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "在{area:380}西南方刷雷鷹雛鳥",
	-- ["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}在更南邊的海岸上。塞拉摩水兵和塞拉摩醫師（15-16級）會掉落勳章；{npc:3393}（20級）和兩名砲手（19級）站在城堡內和城牆上，這也是要塞留到現在才打的原因。",
	-- ["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852}：科卡爾營地周圍平原上的落單的草原科多獸",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}：在{area:2362}使用一半墜飾",
	-- ["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "向{npc:3490}購買{item:2449}；草藥學家可在平原上採集",
	-- ["{item:2449}: herbalists pick it here"] = "{item:2449}：草藥學家可在這裡採集",
	-- ["{npc:11798} in {area:2361} flies druids there"] = "{area:2361}的{npc:11798}會載德魯伊飛到那裡",
	-- ["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}：{npc:3033}的歡迎",
	-- ["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296}：對牠們使用{item:15826}；牠們在{area:380}周圍的平原各處遊蕩",
	-- ["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797}在{area:392}碼頭外的港口中游動。{npc:209797}是精英：建議組隊。",
	-- ["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{area:272}的{npc:2391}教授毒藥：先留著",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{area:272}的{npc:2391}教授{spell:2842}：先留著",
	-- ["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344}在{area:1638}訓練聖騎士。你還沒有那裡的飛行路線：飛往{area:378}，向西騎過{zone:1412}並搭升降梯上去，在中央高台向{npc:2995}學習飛行路線。",
	-- ["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119}和他的水兵佔據{npc:261366}南邊的失事商隊。",
	-- ["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}，在{npc:3341}與山脊之間的平原",
	-- ["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341}在更南邊、通往{area:359}道路上的小營地等著。",
	-- ["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389}站在{area:380}西邊不遠的科卡爾半人馬哨站。",
	-- ["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394}站在{npc:3389}西北方的科卡爾半人馬營地。",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395}在{area:380}東南方{area:388}的科卡爾半人馬之間走動。",
	-- ["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396}率領{npc:3389}南邊、{area:387}西岸的科卡爾半人馬。最後一次在{area:380}停留時，把他的頭交給{npc:3389}。",
	-- ["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401}站在{object:172960}。選取他並輸入 /salute 以完成{quest:2460}。",
	-- ["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428}：蛋在{area:390}，之後再去",
	-- ["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}。先留著：下一份指南中{area:1703}的卡德拉克",
	-- ["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "繳交{quest:4921}後，{npc:3432}會提供{quest:95774}",
	-- ["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}，在雙足飛龍管理員旁邊。先留著：{quest:1483}在石爪山脈，之後再去",
	-- ["{npc:3453}, on the dock"] = "{npc:3453}，在碼頭上",
	-- ["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465}被鎖在要塞內。和他交談開始護送並緊跟著他：出去的路上塞拉摩士兵會攻擊。他會和你一起走回{area:392}。",
	-- ["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197}住在{area:2539}，那是從{npc:3389}往西的道路盡頭、剛進入石爪山脈的食人妖村落。",
	-- ["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875}站在{object:172960}。在那裡的召喚法陣使用{item:6626}，擊敗魅魔以束縛她。",
	-- ["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878}在{area:380}東邊的道路旁紮營。",
	-- ["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}，在{npc:3341}西邊不遠",
	-- ["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901}在{area:392}南邊的山丘上等著，就在你往北的路上。",
	-- ["{npc:5909}, a few steps away"] = "{npc:5909}，就在幾步之外",
	-- ["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018}站在城市西側的{object:172961}。",
	-- ["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}：兩份指南後{zone:1458}的{npc:4606}",
	-- ["{object:3972} poster"] = "{object:3972}海報",
	-- ["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458}：{npc:7233}，在{area:382}旁",
	-- ["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "大型赤鱗迅猛龍{quest:882}在從{area:392}到{area:380}的道路北邊平原狩獵。",
}
