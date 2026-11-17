-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Theramore
	["Theramore"] = "塞拉摩",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260}站在旅店附近；往南幾步的商業用品供應商{npc:4897}販售加爾要的香料。",
	-- {quest:1260} Morgan Stern
	["{quest:1260}, inside"] = "",
	-- {npc:4964} Commander Samaul · {area:514} Foothold Citadel
	["{npc:4964}, on the top floor of {area:514}"] = "",
	-- {npc:271167} Guard Jameson · {quest:98233} Sword in the Slime
	["{npc:271167}: {quest:98233}, from the oozes on the way back east"] = "{npc:271167}：{quest:98233}，來自回東邊路上的軟泥怪",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}，給「沼澤之眼」加爾",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point · {npc:4967} Archmage Tervosh
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it.\n{npc:4967} waits at the foot of the tower: once you have looked around, hand the quest in to him there, not in Theramore."] = "沿著道路從塞拉摩向西北前往{area:503}的瞭望塔。泥石穴居龜在周圍的沼澤中遊蕩。\n{npc:4967}在塔下等候：四處查看過後，就在那裡把任務交給他，而不是在塞拉摩。",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, at the tower"] = "{npc:4967}，在塔旁",

	-- Step 3: Swamplight Manor
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house. Jarl wants three {quest:1218}: if you passed {npc:4897}, buy them from her in Theramore first."] = "沿著道路向北前往毀壞的莊園；加爾住在旁邊的棚屋裡，鬆動的泥土在房子的轉角處。加爾要三個{quest:1218}：如果你經過了{npc:4897}，先在塞拉摩向她買。",
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["{quest:1218}: {npc:4897} in Theramore, if you left without them"] = "{quest:1218}：塞拉摩的{npc:4897}，如果你離開時沒接",
	["with the spices from Theramore"] = "帶著從塞拉摩買來的香料",

	-- Step 4: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "伊格納茲",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "伊格納茲在莊園西邊、{area:504}下方的沼澤裡等候。帶他去找他的藥草葉子，別讓沼澤生物靠近他。",

	-- Step 5: North Point Tower
	-- {npc:4966} Private Hendel · {npc:4967} Archmage Tervosh · {npc:4968} Lady Jaina Proudmoore
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders.\n{npc:4967} and {npc:4968} wait beside the tower: once he yields, hand in to both on the spot."] = "{npc:4966}和幾個逃兵佔據著塔樓。他會攻擊你：把他打到投降為止。\n小心：亨德爾有兩名衛兵，會在他轉為敵對時加入戰鬥。他投降後衛兵就會逃走。\n{npc:4967}和{npc:4968}在塔旁等候：他投降後，當場向兩人交付任務。",

	-- Step 6: Darkmist Cavern
	-- plural, as words: Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "",

	-- Step 7: Mudcrush Durtfeet
	["Head south to the giant's hut in the middle of the marsh."] = "向南前往沼澤中央巨人的小屋。",

	-- Step 8: The Shady Rest Inn
	-- {zone:1413} Barrens
	["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes."] = "燒毀的旅店位於西邊通往{zone:1413}的道路上；衛兵的徽章就在灰燼中。",

	-- Step 9: Corrosive Swamp Oozes
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze
	["Corrosive Swamp Oozes"] = "腐蝕性的沼澤軟泥怪",
	-- plural, as words: Corrosive Swamp Oozes = {npc:4392} Corrosive Swamp Ooze · Elder Daggermaws = {npc:272384} Elder Daggermaw · Bubbling Swamp Oozes = {npc:4394} Bubbling Swamp Ooze
	["On the way back east, the Corrosive Swamp Oozes (38-40) creep through the marsh south of the road, between the middle of the marsh and Theramore: one of them carries Jameson's training sword. Careful: Elder Daggermaws (48-49) lurk in the water among them, and the larger Bubbling Swamp Oozes (39-40) are elite: leave both alone."] = "回東邊的路上，腐蝕性的沼澤軟泥怪（38-40級）在道路南邊、沼澤中央與塞拉摩之間的沼澤中爬行：其中一隻帶著詹姆森的訓練用劍。小心：老鉗嘴鱷（48-49級）潛伏在它們之間的水中，體型較大的起泡的沼澤軟泥怪（39-40級）是精英：兩者都別碰。",

	-- Step 10: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. The officers are in {area:514}."] = "沿著道路向東回到塞拉摩。軍官們都在{area:514}。",
	["On the top floor"] = "",
	-- {npc:4948} Adjutant Tesoran
	["{npc:4948}, on the top floor"] = "",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "",
	-- {npc:4794} Morgan Stern · {zone:1435} Swamp of Sorrows
	["{npc:4794}: the crawlers are on the {zone:1435} shore, keep it"] = "",

	-- Step 11: Mirefin murlocs
	["Mirefin murlocs"] = "黑鰭魚人",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}."] = "黑鰭魚人聚集在{area:497}以北的海岸。",

	-- Step 12: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "只有在你帶著{item:3853}（鐵匠製作）時",

	-- Step 14: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "逃兵在道路南邊、{npc:4503}小屋西邊紮營。",

	-- Step 16: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the way north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "往北前往{area:392}的途中，{area:720}位於城鎮南邊的{area:391}外海：涉水走過沙洲淺灘。{npc:6236}會派出四名挑戰者，然後是{npc:6238}（33級），一次一個。",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "擊敗挑戰者和{npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "{npc:6236}接著會提供捕風者（1791）：旋風斬武器任務線的最後有一個精英，收錄在戰士職業指南「旋風斬武器」中。",

	-- Step 17: Foothold Citadel
	-- {npc:4944} Captain Garran Vimes · {area:514} Foothold Citadel
	["The boat leaves from Theramore: report to {npc:4944} on the top floor of {area:514} on the way to the docks."] = "",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "",

	-- Step 18: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "搭船前往{area:150}",

	-- Step 19: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飛往{zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "",

	-- Step 21: Riding at 40
	["Riding at 40"] = "40級騎術",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40級且有100金幣時就能學騎術，學會後會得到一匹坐騎。{npc:4732}在{zone:1429}東部的{area:88}教導人類，旁邊是{npc:384}的馬匹。Forever 可能允許任何種族向任何騎術訓練師學習（未確認）。收藏品的「坐騎 · 40級」列出所有顏色。",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}：其他顏色，20金",

	-- Step 22: Riding at 40
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:279} Dalaran
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. Skyborne learn it from {npc:265756}, the stablemaster and riding trainer at the {area:17684} in {area:16638} on Zephras Isle, who also sells the Galestriders: the skyboat to the isle leaves the north side of {area:279} about every five minutes. Collectibles, Mounts · Level 40 lists the Galestriders."] = "",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "騎術與逐風者：{npc:265756}，在微風島{area:16638}的{area:17684}。",
	-- {area:279} Dalaran
	["Skyboat to Zephras Isle: the north side of {area:279}, about every five minutes."] = "",

	-- Step 23: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "搭船前往{area:35}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {area:35} Booty Bay
	["Head north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "向西北進入{zone:1413}，沿海岸北上到{area:392}：前往{area:35}的船從那裡的碼頭出發，{area:392}的獅鷲管理員就在碼頭上方。",

	-- Step 24: Boat to Booty Bay
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["Level 40 with 100 gold later on? {npc:4732} teaches riding at {area:88} in {zone:1429}: Collectibles, Mounts · Level 40 has the trip."] = "之後到了40級且有100金幣？{npc:4732}在{zone:1429}的{area:88}教授騎術：收藏品的「坐騎 · 40級」有這趟行程。",

	-- Step 26: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飛往{area:35}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "",

	-- Step 27: Booty Bay
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "給{area:99}的{npc:770}，在北部環線上",
	-- {npc:2494} Privateer Bloads · {area:35} Booty Bay
	["{npc:2494}: keep it, its naga (43-44) wait for the level-48 {area:35} stop"] = "{npc:2494}：先留著，它的納迦（43-44級）等到48級的{area:35}行程再做",
	-- {npc:2487} Fleet Master Seahorn · {quest:669} Sunken Treasure · {area:327} Faldir's Cove
	["{npc:2487}, top floor: {quest:669}, if you did {area:327} with a group"] = "{npc:2487}，頂樓：{quest:669}，如果你和小隊打過{area:327}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the Skullsplitter trolls, on the northern loop"] = "",
	-- {npc:2498} Crank Fizzlebub · {area:35} Booty Bay
	["{npc:2498}, inside: keep it, Zanzil's village (43-44) waits for the level-48 {area:35} stop"] = "{npc:2498}，在裡面：先留著，贊吉爾的村莊（43-44）等到48級回{area:35}時再處理",
	["Seahorn's next errand goes back to Arathi: skip it."] = "海角的下一個任務會回到阿拉希：跳過。",
	-- {npc:2542} Catelyn the Blade
	["{npc:2542}, upstairs"] = "",
	["Upstairs"] = "樓上",

	-- Step 28: Bloodsail camp
	["Bloodsail camp"] = "血帆營地",
	-- plural, as words: Bloodsail Mages = {npc:1562} Bloodsail Mage
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks.\nCareful: the Bloodsail Mages and Warlocks here are level 40-43 and cast from range: pull one at a time and fight with your back to the open beach."] = "從隧道離開城鎮，沿著海岸向北走；信件在海灘上的血帆營地裡，「帥小子」鄧肯在那裡走動。\n小心：這裡的血帆法師和血帆術士是40-43級，會遠程施法：一次拉一隻，背對開闊的沙灘戰鬥。",

	-- Step 29: Booty Bay
	-- {area:43} Wild Shore · {area:35} Booty Bay
	["keep it: the {area:43} camp's charts and Swashbucklers (41-43) wait for the level-48 {area:35} stop"] = "先留著：{area:43}營地的海圖和血帆亡命徒（41-43）等到48級回{area:35}時再處理",
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624}在西北海岸外游動，在北部環線上",

	-- Step 30: Bloodsail pirates: kill these as you meet them
	["Bloodsail pirates: kill these as you meet them"] = "血帆海盜：遇到就殺",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye: take them from the Raiders and Mages (39-41) at the Bloodsail camp on the beach just north of town, where you found the letter. Leave the {area:43} camp south of town (Warlocks and Swashbucklers 41-43) for the level-48 visit."] = "每個血帆海盜都會掉落鼻煙，其中一個身上有{npc:2493}的眼睛：在城鎮北邊不遠、你找到信件的海灘血帆營地，從襲擊者和法師（39-41）身上取得。城鎮南邊的{area:43}營地（術士和亡命徒41-43）留到48級再去。",

	-- Step 31: Booty Bay
	-- {npc:2486} Fin Fizracket · {npc:1514} Mokk the Savage · {area:35} Booty Bay
	["{npc:2486}'s Stranglethorn Fever ({npc:1514}) waits for the level-48 {area:35} stop: leave it for now."] = "{npc:2486}的荊棘谷熱病（{npc:1514}）等到48級回{area:35}時再處理：先別管。",
	-- {area:35} Booty Bay · {area:43} Wild Shore
	["Seahorn's Bloodsail Buccaneers: keep it for the level-48 {area:35} stop, with the {area:43} camp."] = "海角的血帆海盜：留到48級回{area:35}時，和{area:43}營地一起處理。",

	-- Step 32: Booty Bay
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "你在路線之前來這裡時錯過了這一步：現在先做它。它很快，還會開啟後面的任務。",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",

	-- Step 33: Gorilla hills
	["Gorilla hills"] = "猩猩山丘",
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Head inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets."] = "往內陸前往迷霧谷猩猩的山丘。老邁的迷霧谷猩猩會掉落內臟。",

	-- Step 34: Booty Bay
	["Head back down to town; Shaky stands at the tunnel mouth."] = "回到山下的城鎮；病鬼站在隧道口。",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it; on the top floor"] = "給{zone:1446}的斯杜雷：保留此任務；在頂樓",
	-- {area:35} Booty Bay
	["\"Sea Wolf\" MacKinley: keep it, for the level-48 {area:35} stop, with Zanzil's village"] = "「海狼」麥金利：先留著，等48級回{area:35}時和贊吉爾的村莊一起處理",

	-- Step 35: Cortello's scroll
	["Cortello's scroll"] = "科泰羅的卷軸",
	-- {area:35} Booty Bay
	["Optional: Cortello's scroll lies inside one of the three Bloodsail ships anchored off the coast just south of {area:35}, on a middle or lower deck, and is not always on the same ship. Their crews are 42-45 pirates: clear your way from the edge, one at a time, and leave the captains (45-48), whom the route comes back for at 48."] = "可選：科泰羅的卷軸在{area:35}南邊不遠、停泊在外海的三艘血帆海盜船之一裡，位於中層或下層甲板，而且不一定每次都在同一艘船上。船員是42-45級的海盜：從邊緣一隻一隻清出路來，並避開船長（45-48），路線會在48級時回來對付他們。",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "稍後用於{zone:1435}",

	-- Step 36: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "叢林捕獵者",
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers roam the slopes west of the mine."] = "叢林潛獵者在礦坑西邊的山坡上遊蕩。",

	-- Step 37: Zul'Mamwe's Mystics and the Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Zul'Mamwe's Mystics and the Shadowmaw Panthers"] = "祖瑪維的秘法師與深喉獵豹",
	-- {npc:739} Brother Nimetz
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic · Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["East from the stalkers' slopes to the ruins of Zul'Mamwe: the Skullsplitter Mystics (39-40) in its northern half carry {npc:739}'s fetishes. Careful: the Witch Doctors, Berserkers and Headhunters (41-44) hold the ruins' southern half: stay north. Then north-west toward the coast: the Shadowmaw Panthers (37-38) prowl the jungle west of the ruins, often stealthed."] = "從潛獵者的山坡向東前往祖瑪維廢墟：北半部的劈顱秘法師（39-40）身上有{npc:739}要的神像。小心：巫醫、狂戰士和獵頭者（41-44）佔據廢墟南半部：待在北邊。接著往西北朝海岸走：深喉獵豹（37-38）在廢墟西邊的叢林中徘徊，經常處於潛行狀態。",
	-- {item:2466} Skullsplitter Fetish
	-- plural, as words: Skullsplitter Mystics = {npc:780} Skullsplitter Mystic
	["{item:2466}, from the Skullsplitter Mystics"] = "{item:2466}，從劈顱秘法師身上取得",

	-- Step 38: The north-west coast
	["The north-west coast"] = "西北海岸",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Go on north-west to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "繼續向西北前往西北海岸的海灣。巨型蚌殼躺在海底，裡面有珍珠；{npc:2624}在牠們之間游動，會掉落{item:4034}。",
	-- {item:4611} Blue Pearl
	["{item:4611}; underwater"] = "",

	-- Step 39: Sin'Dall
	-- {npc:729} Sin'Dall
	["North-east from the bay toward Nesingwary's camp: {npc:729}, the great tiger (37), lairs on the hilltop just south-west of the camp."] = "從海灣向東北朝奈辛瓦里的營地前進：巨虎{npc:729}（37）盤踞在營地西南方不遠的山頂上。",

	-- Step 40: Hemet Nesingwary
	-- {npc:718} Sir S. J. Erlgadin
	["{npc:718}, beside him"] = "{npc:718}，在他旁邊",
	-- {npc:717} Ajeck Rouack
	["{npc:717}, beside them"] = "{npc:717}，在他們旁邊",

	-- Step 43: Arbor Tarantula
	-- {npc:217588} Arbor Tarantula · {area:99} Rebel Camp · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: catch one with the tool from {npc:217412}'s {item:213565}."] = "",

	-- Step 44: Rebel Camp
	["Head north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "向東北經過奈辛瓦里的營地，沿著道路向北走到山谷頂端的營地。",

	-- Step 45: Brother Nimetz
	-- {npc:739} Brother Nimetz · {area:301} Savage Coast · {npc:2277} Loremaster Dibbs · {area:271} Southshore · {zone:1418} Badlands · {zone:1425} Hinterlands
	["{npc:739}: the {area:301} report bundle for {npc:2277} in {area:271}, on the {zone:1418} & {zone:1425} guide: keep it"] = "{npc:739}：要交給{area:271}{npc:2277}的{area:301}報告包，在{zone:1418}與{zone:1425}指南中：先留著",

	-- Step 46: Kurzen's Compound
	-- {area:99} Rebel Camp · {area:101} Kurzen's Compound · {npc:218230} Wendel Mathers · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Subchiefs = {npc:978} Kurzen Subchief
	["East from the {area:99} to {area:101}: {npc:218230} is caged at its western edge. The Kurzen Subchiefs (35-36) and Elites (36-37) carry his cage key; the fighter's uniform lies in a supply crate in the compound's eastern part.\nCareful: {npc:813}, an elite of 39-40, stands at the compound's north end beside three of the Subchiefs: take the key from the Subchiefs and Elites further south and leave him be."] = "從{area:99}向東前往{area:101}：{npc:218230}被關在西側邊緣。庫爾森副首領（35-36）和庫爾森精英（36-37）身上有他的牢籠鑰匙；戰士的制服在營地東側的補給箱裡。\n小心：39-40級的精英{npc:813}站在營地北端，旁邊有三名副首領：從更南邊的副首領和精英身上取得鑰匙，別去惹他。",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage, if you didn't take it on the 30-40 loop"] = "{npc:218230}，在他的牢籠裡，如果你在30-40路線沒有接的話",
	-- {item:216616} Compound Cage Key
	["{item:216616}, from the Subchiefs (or the Elites)"] = "{item:216616}，從副首領（或精英）身上取得",
	-- {item:216617} Kurzen Fighter's Uniform
	["{item:216617}, in the supply crate"] = "{item:216617}，在補給箱裡",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, back at his cage on the way out"] = "{npc:218230}，離開時回到他的籠子旁",
	-- {npc:218229} Captain Aransas · {area:35} Booty Bay
	["For {npc:218229} in {area:35}, at the end of the jungle loop"] = "給{area:35}的{npc:218229}，在叢林環線的終點",

	-- Step 47: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 48: Ruins of Zul'Mamwe: kill these as you meet them
	-- {area:103} Ruins of Zul'Mamwe
	["{area:103}: kill these as you meet them"] = "",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do.\nFollow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "",

	-- Step 49: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 53: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "",

	-- Step 55: Booty Bay
	-- {area:35} Booty Bay
	["Follow the road south to {area:35}."] = "沿著道路向南前往{area:35}。",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}：給{zone:1446}的{quest:2864}，保留此任務",

	-- Step 56: Fly to Stormwind
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 57: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141}在{object:2169}烹飪；{npc:5384}在{object:28027}。",
	-- {npc:5694} High Sorcerer Andromath · {npc:5464} Watchmaster Sorigal · {area:42} Darkshire
	["{npc:5694}: for {npc:5464} in {area:42}, on the way to the swamp"] = "",

	-- Step 58: Stormwind
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}，在{object:2117}的皇家圖書館",

	-- Step 60: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "聖騎士：{quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}，在光明大教堂裡",

	-- Step 61: Stormwind City
	["Stormwind City"] = "",

	-- Step 62: Warlock: Summon Felsteed
	-- {quest:4488} Summon Felsteed
	["Warlock: {quest:4488}"] = "術士：{quest:4488}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}，在{object:2164}：由{area:392}的{npc:6251}在下一份指南結尾接收",

	-- Step 64: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "",

	-- Step 67: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "40級且有100金幣時就能學騎術，學會後會得到一匹坐騎。{npc:4753}在{zone:1457}教導夜精靈，旁邊是{npc:4730}的豹：從{area:17203}搭船到{area:442}，再飛往{area:702}。Forever 可能允許任何種族向任何騎術訓練師學習（未確認），例如{zone:1429}{area:88}的{npc:4732}。收藏品的「坐騎 · 40級」列出所有顏色。",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}：其他顏色，20金",

	-- Step 69: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "飛往{area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "{area:702}飛行管理員",

	-- Step 70: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "",

	-- Step 71: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飛往{area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "",

	-- Step 72: Darkshire
	-- {npc:5464} Watchmaster Sorigal
	["{npc:5464}, by the flight master"] = "",

	-- Step 74: Misty Valley
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "卷軸在比格斯北邊的沼澤裡。它北邊的沼澤漫步者可能會掉落卡德加的空間收斂研究筆記。",

	-- Step 76: Cortello's Riddle
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}：{quest:93176}，來自30-40級的阿拉希高地指南",

	-- Step 77: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["{npc:5476} stands by the road junction in the west of the swamp."] = "",

	-- Step 78: The sunken temple
	["The sunken temple"] = "沉沒的神廟",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Head east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "向東走；沿途的糾纏恐獸也會掉落研究筆記。在{area:74}邊緣搜尋，神廟遺跡就在那裡露出水面。",

	-- Step 79: Misty Reed Strand
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler · Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The Silt Crawlers (40-41) crowd the north end of the eastern shore, and the driftwood washes up along it from there.\nCareful: the big Monstrous Crawlers (43-44) further south on the shore are over you: take the legs at the north end and pick up the driftwood without pulling them."] = "淤泥蟹（40-41）聚集在東岸北端，浮木也從那裡沿著海岸被沖上岸。\n小心：海岸更南邊的大型巨型淤泥蟹（43-44）等級比你高：在北端收集蟹腿，撿浮木時別引到牠們。",
	-- {item:5938} Pristine Crawler Leg
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler
	["{item:5938}, from the Silt Crawlers"] = "{item:5938}，從淤泥蟹身上取得",

	-- Step 80: Watcher Biggs
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "給{area:1438}：保留此任務",

	-- Step 83: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "給{area:348}的{npc:5635}：保留此任務",

	-- Step 84: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 87: Ironforge
	-- {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["{npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:2786} in the {object:32383}."] = "{npc:5637}在{object:32356}旁的尋物公司大廳裡，{npc:2786}在{object:32383}。",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453}沒有薩滿訓練師",

	-- Step 89: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40級且有100金幣時就能學騎術，學會後會得到一匹坐騎。{npc:4772}在{area:803}教導矮人，位於{area:131}東邊通往{zone:1432}的路上，旁邊是{npc:1261}的山羊。Forever 可能允許任何種族向任何騎術訓練師學習（未確認）。收藏品的「坐騎 · 40級」列出所有顏色。",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}：其他顏色，20金",

	-- Step 91: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40級且有100金幣時就能學騎術，學會後會得到一匹坐騎。{npc:7954}在{area:189}教導地精，就在{area:131}東邊，旁邊是{npc:7955}的機械陸行鳥。Forever 可能允許任何種族向任何騎術訓練師學習（未確認）。收藏品的「坐騎 · 40級」列出所有顏色。",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}：其他顏色，20金",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "40級且有100金幣時就能學騎術，學會後會得到一匹坐騎。目前沒有已知的天裔精靈騎術訓練師；Forever 用戶端把{spell:1285849}歸在唯一的騎術技能下，所以離{zone:1453}最近的訓練師，也就是{zone:1429}東部{area:88}的{npc:4732}，應該能教（未確認）。逐風者由微風島{area:16638}的{npc:265756}販售；收藏品的「坐騎 · 40級」列出了牠們。",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {area:12}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "40級且有100金幣時就能學騎術，學會後會得到一匹坐騎。{npc:4732}在{area:12}東部的{area:88}教導人類，旁邊是{npc:384}的馬匹。Forever 可能允許任何種族向任何騎術訓練師學習（未確認）。收藏品的「坐騎 · 40級」列出所有顏色。",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {area:12}. Collectibles, Mounts · Level 40 lists every colour."] = "40級且有100金幣時就能學騎術，學會後會得到一匹坐騎。{npc:4753}在{zone:1457}教導夜精靈，旁邊是{npc:4730}的豹：從{area:17203}搭船到{area:442}，再飛往{area:702}。Forever 可能允許任何種族向任何騎術訓練師學習（未確認），例如{area:12}{area:88}的{npc:4732}。收藏品的「坐騎 · 40級」列出所有顏色。",
	-- ["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "回到塞拉摩：特沃許和珍娜·普勞德摩爾一起在{area:514}的塔裡等候。",
	-- ["Bloodsail pirates"] = "血帆海盜",
	-- ["Cold Eye Basilisks"] = "冷眼蜥蜴",
	-- ["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}.\nCareful: the {area:43} camp's Warlocks and Swashbucklers are level 41-43, a level or more above you, and stand close together: pull them singly from the edge."] = "每個血帆海盜都會掉落鼻煙，其中一個帶著{npc:2493}的眼睛；血帆流氓在城鎮北邊的岸上走動。海圖和命令在{area:35}南邊{area:43}的海盜營地裡。\n小心：{area:43}營地的血帆術士和血帆流氓是41-43級，比你高一級以上，而且站得很近：從邊緣一隻一隻拉。",
	-- ["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "每個贊吉爾信徒都可能掉落混合物；{npc:2537}在營地南部走動。",
	-- ["Fly to {area:144}"] = "飛往{area:144}",
	-- ["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "飛往{area:42}，向東騎過{zone:1430}進入{zone:1435}；{npc:5476}就站在剛過邊界的路旁。",
	-- ["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "沿著道路向東回到塞拉摩。特沃許、珍娜·普勞德摩爾和軍官們都在塔裡和{area:514}。",
	-- ["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "沿著道路向東北前往{area:310}的風險投資公司營地；礦工、勘探員和工頭會掉落水晶。",
	-- ["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "沿著道路從塞拉摩向西北前往{area:503}的瞭望塔。泥石穴居龜在周圍的沼澤中遊蕩。",
	-- ["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "交出獠牙後留下來：會來三波猩猩，最後是{npc:1514}。滿血再戰。",
	-- ["Klannoc offers The Windwatcher next (1791): the {spell:1680} weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "克蘭諾克接著會提供捕風者（1791）：{spell:1680}武器任務線的最後有一個精英，收錄在戰士職業指南中。",
	-- ["MacKinley's next task sends you after elite ogres: skip it."] = "馬克基雷的下一個任務要你去打精英巨魔：跳過。",
	-- ["Mudrock tortoises"] = "泥石海龜",
	-- ["Naga Explorers"] = "納迦探險者",
	-- ["No flight path to {area:144} yet: ride out of {zone:1455}'s gates, east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "還沒有{area:144}的飛行路線：騎出{zone:1455}的大門，向東穿過{zone:1426}和隧道進入{zone:1432}，再沿道路前往{area:144}。",
	-- ["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "往北騎向{area:392}的途中，{area:720}位於城鎮南邊的{area:391}外海：涉水走過沙洲淺灘。{npc:6236}會派出四名挑戰者，然後是{npc:6238}（33級），一次一個。",
	-- ["Ride back down to town; Shaky stands at the tunnel mouth."] = "騎回城鎮；病鬼站在隧道口。",
	-- ["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "沿著道路向西騎回去；{npc:217412}站在比格斯北邊不遠處。",
	-- ["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "向東騎；沿途的糾纏恐獸也會掉落研究筆記。在{area:74}邊緣搜尋，神廟遺跡就在那裡露出水面。",
	-- ["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "從塞拉摩沿著塵泥沼澤的道路向西騎進{zone:1413}，再向北前往海岸邊的{area:392}。向{npc:16227}取得飛行路線，然後在碼頭搭船前往{area:35}。",
	-- ["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "向內陸騎往迷霧谷猩猩的山丘。老邁的迷霧谷猩猩會掉落內臟；{npc:1449}坐在牠們之間。",
	-- ["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "向北騎往道路西邊的山丘。{npc:2535}和{npc:2536}一起站在贊吉爾村莊北邊。",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "向東北騎過奈辛瓦里的營地，沿著道路向北前往山谷頂端的營地。途中，奈辛瓦里營地東南方的叢林裡有{npc:217588}在爬行：用昆蟲學入門工具包抓一隻，然後勾選完成。",
	-- ["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "從礦坑向西北騎往西北海岸的海灣。巨型蚌殼躺在海底，裡面有珍珠；{npc:2624}在牠們之間游動，會掉落{item:4034}。",
	-- ["Ride north-west into the {zone:1413} and up the coast to {area:392}: the boat to {area:35} leaves from its dock, and {area:392}'s gryphon master stands just above it."] = "向西北騎進{zone:1413}，沿海岸北上到{area:392}：前往{area:35}的船從那裡的碼頭出發，{area:392}的獅鷲管理員就在碼頭上方。",
	-- ["Ride south out of {zone:1432} through the pass into the {area:3}; {npc:2860} camps at the dig."] = "從{zone:1432}向南騎，穿過山口進入{area:3}；{npc:2860}在挖掘場紮營。",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "從{zone:1432}向南騎，穿過山口進入{zone:1418}；{npc:2860}在挖掘場紮營。",
	-- ["Ride south to the giant's hut in the middle of the marsh."] = "向南騎往沼澤中央巨人的小屋。",
	-- ["Skullsplitter ruins"] = "劈顱遺跡",
	-- ["The Bloodsail captains"] = "血帆船長",
	-- ["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "暗霧蜘蛛在沼澤西北部的洞穴周圍築巢；每隻蜘蛛都會掉落眼睛。",
	-- ["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "黑鰭魚人聚集在{area:497}以北的海岸；在牠們旁邊的海龜身上收集完舌頭。",
	-- ["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "泥石海龜和泥石刺殼龜在莊園東北方的岸邊曬太陽。",
	-- ["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "劈顱食人妖佔據礦坑東邊的遺跡；他們每一個都可能掉落獠牙，他們的豹子則一定會掉。",
	-- ["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "燒毀的旅店位於西邊通往{zone:1413}的道路上；衛兵的徽章就在灰燼中，蹄印則在旅店旁的泥地上。",
	-- ["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "船長們站在停泊於{area:43}外海的船上，每艘都有42-45級的海盜船員：斯蒂沃特船長（45）和尼哈魯船長（46）在較近的甲板上，{npc:2546}（48）在旗艦上。42級時這是小隊的戰鬥，或留到指南最後再打；如果要去，先清空每層甲板。科泰羅的卷軸在岸邊的船骸上。",
	-- ["The driftwood washes up along the eastern shore."] = "浮木沖上東岸。",
	-- ["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "納迦在血帆營地北邊的海灘上搜尋；牠們會掉落蘆葦。",
	-- ["The riddle's next scroll lies in western Dustwallow: skip it."] = "謎題的下一份卷軸在塵泥沼澤西部：跳過。",
	-- ["Unbagwa's ritual"] = "安巴格瓦的儀式",
	-- ["Warlock: {quest:3631}"] = "術士：{quest:3631}",
	-- ["Zanzil's village"] = "贊吉爾的村莊",
	-- ["for the flight back to {npc:6251} at 43"] = "為了在43級時飛回{npc:6251}",
	-- ["for the {area:8} later"] = "稍後用於{area:8}",
	-- ["for {npc:2616} in Theramore: keep it"] = "給塞拉摩的{npc:2616}：保留此任務",
	-- ["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}：給{zone:1432}的{npc:1344}，保留此任務",
	-- ["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}：抓一隻，用於{quest:93176}",
	-- ["{npc:2487}, top floor"] = "{npc:2487}，頂樓",
	-- ["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "{npc:2498}的下一個贊吉爾任務從{zone:1441}開始：跳過。",
	-- ["{npc:2535} and {npc:2536}"] = "{npc:2535}與{npc:2536}",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888}獨自在挖掘場東南方的{area:1898}紮營。",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966}和幾個逃兵佔據著塔樓。他會攻擊你：把他打到投降為止。",
	-- ["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}：給{area:1438}，保留此任務",
	-- ["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910}是港口上方的高大建築；大多數任務給予者都在它的各樓層或下方的碼頭。",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}，給「沼澤之眼」加爾",
	-- ["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260}站在旅店附近；往南幾步的商業用品供應商{npc:4897}販售加爾要的香料。",
	-- ["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706}：它的{item:4612}是稀有掉落，所以收集和繳交也都是可選的",
}
