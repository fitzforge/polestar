-- Chinese (traditional) (zhTW): the guide forever/reputation/centaur-clans (forever/reputation/centaur-clans.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Gelkis and Magram Centaur Reputation"] = "",
	-- {zone:1443} Desolace
	["{zone:1443}'s feuding clans, reworked in Forever: pick one, buy its friendship, and trade totems for recipes."] = "",
	-- {quest:93224} Carved Centaur Totems
	["12 recipes for {quest:93224} at the clan quartermasters, no standing needed"] = "部族軍需官處可用{quest:93224}兌換12種配方，不需要聲望",
	-- {npc:5601} Khan Jehn
	["{npc:5601}'s quest: a clan title and a choice of three rare level 35 weapons"] = "",

	-- Step 1: Pick your clan
	["Pick your clan"] = "",
	-- {zone:1443} Desolace · {npc:5396} Captain Pentigast · {area:608} Nijel's Point · {quest:1382} Strange Alliance · {quest:1385} Brutal Politics · {npc:5412} Gurda Wildmane · {quest:1368} Gelkis Alliance · {quest:1367} Magram Alliance · {quest:93224} Carved Centaur Totems
	["The Gelkis (south-west {zone:1443}) and the Magram (south-east) are at war: every kill of one clan gives the other 20 and costs its own clan 100, and every quest of one clan costs the other five times what it pays (Buying Friendship: 3,000 for yours, 15,000 off the other), so you can only climb with one. Both start Neutral. Forever's quests are worth far more than kills now. Alliance: {npc:5396} at {area:608} offers {quest:1382} (Gelkis) and {quest:1385} (Magram). Horde: {npc:5412} offers {quest:1368} and {quest:1367}. Take the one of your clan, and {quest:93224}: each clan's Buying Friendship (3,000) is offered once you bring the totems back. Then tick the task. The guide goes on with the Gelkis; take the Magram's quests instead and it goes to the Magram half. Forever pays these quests in full at any level."] = "吉爾吉斯（{zone:1443}西南）與瑪格拉姆（東南）正在交戰：每殺一名某部族成員，另一部族增加20點聲望，被殺的部族則扣100點；而某一部族的每個任務，都會讓另一部族扣掉其獎勵的五倍（「收買友誼」：你的部族得3,000點，另一部族扣15,000點），所以只能提升其中一方。兩者初始都是中立。現在Forever的任務獎勵遠高於擊殺。聯盟：{area:608}的{npc:5396}提供{quest:1382}（吉爾吉斯）和{quest:1385}（瑪格拉姆）。部落：{npc:5412}提供{quest:1368}和{quest:1367}。接取你所選部族的任務和{quest:93224}：帶回圖騰後，就會提供該部族的「收買友誼」（3,000點）。然後勾選此項。指南接下來走吉爾吉斯路線；改接瑪格拉姆的任務，就會跳到瑪格拉姆部分。在Forever中，這些任務在任何等級都給予全額獎勵。",
	-- {quest:1382} Strange Alliance
	["{quest:1382}: Gelkis"] = "",
	["Take the quests of one clan"] = "",

	-- Step 2: Carved Centaur Totems
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) in the camps along the eastern road, south of {area:608}, drop the totems, and so do the Magram and the Maraudine. Bring five back, then take your clan's Buying Friendship (Gelkis below; the Magram's instead for the Magram)."] = "{area:608}以南、東邊道路沿線營地裡的科卡爾半人馬（30-33級）會掉落圖騰，瑪格拉姆和瑪洛迪半人馬也會掉。帶回五個，然後接取你所選部族的「收買友誼」（下面是吉爾吉斯的；瑪格拉姆則接瑪格拉姆的）。",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Kolkar centaurs"] = "{item:254432}：科卡爾半人馬",

	-- Step 3: Gelkis or Magram
	["Gelkis or Magram"] = "吉爾吉斯或瑪格拉姆",
	["No clan's quests in your log: the guide goes on with the Gelkis. For the Magram, take their choice quest and Buying Friendship and the guide goes to the Magram half."] = "任務日誌中沒有任何部族的任務：指南按吉爾吉斯路線繼續。若選瑪格拉姆，接取他們的選擇任務和「收買友誼」，指南就會跳到瑪格拉姆部分。",

	-- Step 4: Gelkis: the choice quest
	["Gelkis: the choice quest"] = "吉爾吉斯：選擇任務",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village
	["The Gelkis half starts with the clan's choice quest from the giver you just handed the totems to: {npc:5397}'s quests in {area:606} follow from it, and Buying Friendship alone does not open them."] = "吉爾吉斯部分從你剛交圖騰的那位任務給予者提供的部族選擇任務開始：{area:606}的{npc:5397}的任務由此展開，只完成「收買友誼」並不會開啟它們。",

	-- Step 5: Gelkis Village: Uthek the Wise and Molkar
	-- {area:606} Gelkis Village · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606}: {npc:5397} and {npc:253140}"] = "",
	-- {area:606} Gelkis Village · {zone:1443} Desolace · {npc:5397} Uthek the Wise · {npc:253140} Molkar
	["{area:606} sits in the hills of south-west {zone:1443}; {npc:5397} stands at its heart. {npc:253140}, the Gelkis quartermaster, is at the south end of the village. Buying Friendship alone takes you from Neutral to Friendly."] = "",

	-- Step 6: Gelkis: the Kolkar camps
	["Gelkis: the Kolkar camps"] = "",
	-- {area:608} Nijel's Point · {item:6079} Crude Charm
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}, along the eastern road. About one in four drops a {item:6079}."] = "",
	-- {item:6079} Crude Charm
	["{item:6079}: Kolkar centaurs"] = "",

	-- Step 7: Gelkis: Magram Village
	-- {area:604} Magram Village
	["Gelkis: {area:604}"] = "",
	-- {area:604} Magram Village
	["The Sacks of Meat lie about {area:604}, in the south-east. Every Magram you kill on the way pays the Gelkis 20."] = "",
	-- {item:6069} Crudely Dried Meat
	["{item:6069}: Sacks of Meat"] = "",
	-- {npc:4640} Magram Wrangler
	["{npc:4640}: 20 Gelkis"] = "",
	-- {npc:4641} Magram Windchaser
	["{npc:4641}: 20 Gelkis"] = "",

	-- Step 8: Gelkis: Ongeku
	-- {quest:1373} Ongeku
	["Gelkis: {quest:1373}"] = "",
	-- {npc:5397} Uthek the Wise · {zone:1435} Swamp of Sorrows · {quest:1373} Ongeku · {area:76} Fallow Sanctuary · {area:75} Stonard
	["Back to {npc:5397}, then east to the {zone:1435}: {quest:1373} (level 37) waits by a black cauldron in {area:76}, north-east of {area:75}."] = "",

	-- Step 9: Gelkis: totems and kills to Honored
	["Gelkis: totems and kills to Honored"] = "",
	-- {npc:253140} Molkar · {quest:92812} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {item:10008} White Bandit Mask · {item:5739} Barbaric Harness
	-- plural, as words: Greater Mystic Essences = {item:11135} Greater Mystic Essence
	["Friendly to Honored is 6,000; after the clan's quests you are about 4,000 into it, so 2,000 to go. {npc:253140}'s {quest:92812} takes 5 {quest:93224} for 750, again and again: three turn-ins, 15 totems. The Maraudine centaurs (level 36-40) of western {zone:1443} drop them; the totems do not bind, so the auction house is the other source. Magram kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village also has three craft orders for 1,000 each: Halea wants 3 Greater Mystic Essences, {npc:253140} a {item:10008} (tailoring) and Talra a {item:5739} (leatherworking). Legacy Diplomat adds up to 10%."] = "友好到尊敬需要6,000；完成部族任務後約已有4,000，還差2,000。{npc:253140}的{quest:92812}每次收取5個{quest:93224}，獎勵750聲望，可以一再繳交：共需三次、15個圖騰。{zone:1443}西部的瑪洛迪半人馬（36-40級）會掉落；圖騰不綁定，所以也可以從拍賣場購買。每殺一個瑪格拉姆半人馬增加20，但Forever的擊殺資料將上限設在友好末尾，距離尊敬還差1點。友好時，村裡還有三項製作訂單，每項獎勵1,000：Halea需要3個強效秘法精華，{npc:253140}需要一件{item:10008}（裁縫），Talra需要一件{item:5739}（製皮）。傳承的外交官最多增加10%。",
	-- {item:254432} Carved Centaur Totem
	["{item:254432}: Maraudine centaurs"] = "",

	-- Step 10: Gelkis: Uthek the Wise sends you to the valley
	-- {npc:5397} Uthek the Wise
	["Gelkis: {npc:5397} sends you to the valley"] = "吉爾吉斯：{npc:5397}派你前往山谷",
	-- {npc:5397} Uthek the Wise · {npc:253177} Nerlokh · {quest:93034} Valley of Bones · {zone:1443} Desolace · {zone:2652} Shen'dralas · {quest:92811} Economic Warfare
	["At Honored and level 35, {npc:5397} sends you east to {npc:253177}, a Gelkis scout at the western mouth of the {quest:93034}, where the south of {zone:1443} runs into {zone:2652}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Gelkis, and each costs the Magram five times what it pays. Honored to Revered is 12,000; the valley pays 10,625 of it, {quest:92811} the rest."] = "在尊敬且35級時，{npc:5397}會派你向東去找{npc:253177}，一名吉爾吉斯斥候，位於{quest:93034}的西側入口，也就是{zone:1443}南部與{zone:2652}相接處。山谷的步驟依照Forever的任務資料：記錄遊玩過程的玩家還沒有人做過這些任務，所以地點或順序可能有誤。山谷的每個任務都要求你保持吉爾吉斯尊敬，而每個任務都會讓瑪格拉姆扣掉其獎勵的五倍。尊敬到崇敬需要12,000點；山谷提供其中的10,625點，其餘由{quest:92811}補足。",

	-- Step 11: Gelkis: Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}"] = "吉爾吉斯：{npc:253177}",
	-- {npc:253177} Nerlokh · {npc:11559} Outcast Necromancer
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253177} waits at the valley's western mouth. He wants six Undead Ravagers put to rest and the ritual garb of an {npc:11559}: the outcasts are Gelkis exiles who took up the Magram's necromancy."] = "依任務資料：{npc:253177}在山谷西側入口等著。他要你讓六隻不死掠奪者安息，並取得一名{npc:11559}的儀式長袍：流放者是學了瑪格拉姆死靈術的吉爾吉斯流亡者。",

	-- Step 12: Gelkis: the valley's mouth
	["Gelkis: the valley's mouth"] = "吉爾吉斯：山谷入口",
	-- {quest:92846} Outcast Necromancers · {npc:253177} Nerlokh · {npc:253136} Orgrul
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253177} north-east to {npc:253136}'s post at its northern mouth; players have met them all along it. {npc:253136}'s Magram are hostile to a friend of the Gelkis. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "依任務資料：不死掠奪者和{quest:92846}遍布山谷，從{npc:253177}一直往東北到山谷北側入口{npc:253136}的崗哨；玩家在整條路上都遇到過他們。{npc:253136}的瑪格拉姆對吉爾吉斯的朋友有敵意。45級精英食屍者在山谷中走動，會攻擊任何人。",

	-- Step 13: Gelkis: Facing the Truth
	-- {quest:93041} Facing the Truth
	["Gelkis: {quest:93041}"] = "吉爾吉斯：{quest:93041}",
	-- {npc:253177} Nerlokh · {item:255941} Gelkis Necromantic Garb · {npc:5397} Uthek the Wise · {item:255945} Accursed Skull
	["From the quest data: {npc:253177} gives you a {item:255941} to show {npc:5397}, with an {item:255945} you find yourself: a freshly cursed skull, hoarded in the jaws of one of the valley's giant skeletons. The game's data has no spot for it."] = "依任務資料：{npc:253177}會給你一件{item:255941}拿給{npc:5397}看，另外還要一個你自己找到的{item:255945}：一個剛被詛咒的頭骨，藏在山谷中一具巨大骷髏的嘴裡。遊戲資料中沒有它的位置。",
	-- {item:255945} Accursed Skull
	["{item:255945}: in a giant skeleton's jaws"] = "{item:255945}：在一具巨大骷髏的嘴裡",

	-- Step 14: Gelkis: Uthek the Wise and Mulara
	-- {npc:5397} Uthek the Wise · {npc:253713} Mulara
	["Gelkis: {npc:5397} and {npc:253713}"] = "吉爾吉斯：{npc:5397}與{npc:253713}",
	-- {npc:5397} Uthek the Wise · {area:606} Gelkis Village · {npc:253713} Mulara · {npc:253140} Molkar · {quest:92812} Economic Warfare
	["From the quest data: back west to {npc:5397} in {area:606}. She needs Tears of Theradras: {npc:253713}, the Voice of Theradras, keeps them in the cave in the south of the village, past {npc:253140}. Ask her for them on {npc:5397}'s behalf and bring three back. {npc:253140} takes {quest:92812} on the way."] = "依任務資料：向西回到{area:606}的{npc:5397}那裡。她需要瑟萊德絲之淚：瑟萊德絲之聲{npc:253713}把它們放在村莊南部的洞穴裡，要經過{npc:253140}。代{npc:5397}向她索取，帶回三個。途中{npc:253140}會收下{quest:92812}。",
	-- {npc:253713} Mulara
	["{npc:253713}, in the cave"] = "{npc:253713}，在洞穴裡",
	["three Tears of Theradras"] = "三個瑟萊德絲之淚",

	-- Step 15: Gelkis: Test Your Theory
	-- {quest:93045} Test Your Theory
	["Gelkis: {quest:93045}"] = "吉爾吉斯：{quest:93045}",
	-- {npc:5397} Uthek the Wise · {item:6071} Draenethyst Crystal · {item:256061} Uthek's Draenethyst Staff · {item:255945} Accursed Skull · {npc:253177} Nerlokh
	["From the quest data: {npc:5397} gives you her staff and a {item:6071}. Put them together into {item:256061}, take it to the ritual site by the pond just east of the village and dispel the curse on the {item:255945}. Then east again to {npc:253177}."] = "依任務資料：{npc:5397}會給你她的法杖和一個{item:6071}。把它們組合成{item:256061}，帶到村莊東邊不遠水池旁的儀式地點，驅散{item:255945}上的詛咒。然後再向東去找{npc:253177}。",
	-- {item:255945} Accursed Skull
	["dispel the {item:255945} by the pond"] = "在水池旁驅散{item:255945}的詛咒",

	-- Step 16: Gelkis: back to Nerlokh
	-- {npc:253177} Nerlokh
	["Gelkis: back to {npc:253177}"] = "吉爾吉斯：回到{npc:253177}處",
	-- {npc:253177} Nerlokh · {item:271794} Centaur Spear · {item:271795} Wanderer's Broadsword · {item:271799} Desert Crawler's Claw
	["From the quest data: {npc:253177} pays 500 and your pick of three weapons for level 35: {item:271794} (polearm), {item:271795} (two-handed sword) or {item:271799} (dagger). Then he has two jobs deeper in the valley."] = "依任務資料：{npc:253177}會給你500點，並讓你從三把35級武器中選一把：{item:271794}（長柄武器）、{item:271795}（雙手劍）或{item:271799}（匕首）。之後他在山谷更深處還有兩個差事。",

	-- Step 17: Gelkis: the heart of the valley
	["Gelkis: the heart of the valley"] = "吉爾吉斯：山谷中心",
	-- {npc:253177} Nerlokh · {npc:253446} Haggard Bones · {item:256061} Uthek's Draenethyst Staff
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: east of {npc:253177}, in the heart of the valley, the Magram hold Gelkis Captives: free five. Among them lie {npc:253446}, failed summons stuck in the ground: lay eight to rest with {item:256061}, which the quest gives you. Corpsefeeders and Magram Necrokhans, elite and level 45, walk the valley and attack a friend of the Gelkis: let them pass before you pull."] = "依任務資料：在{npc:253177}東邊的山谷中心，瑪格拉姆關押著吉爾吉斯俘虜：救出五名。他們之間躺著{npc:253446}，是卡在地裡的失敗召喚物：用任務給你的{item:256061}讓八具安息。45級精英食屍者和瑪格拉姆死靈可汗在山谷中走動，會攻擊吉爾吉斯的朋友：等他們走過再拉怪。",
	-- {npc:253446} Haggard Bones
	["Lay {npc:253446} to rest"] = "讓{npc:253446}安息",
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive
	["free five Gelkis Captives"] = "救出五名吉爾吉斯俘虜",

	-- Step 18: Gelkis: Checking Things Out
	-- {quest:93122} Checking Things Out
	["Gelkis: {quest:93122}"] = "吉爾吉斯：{quest:93122}",
	-- {npc:253177} Nerlokh · {zone:2652} Shen'dralas · {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253177}'s next order takes you deeper into {zone:2652} to scout two places: the {area:16675}, a Magram camp south-east of the valley, and the {area:16676}, the exiles' camp west of the Shen'dralar town, further south."] = "依任務資料：{npc:253177}的下一道命令要你深入{zone:2652}偵察兩個地點：{area:16675}，山谷東南方的瑪格拉姆營地；以及{area:16676}，流亡者在辛德拉城鎮西邊、更南方的營地。",

	-- Step 19: Gelkis: the Magram Front and the Outcast Hideaway
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway
	["Gelkis: the {area:16675} and the {area:16676}"] = "吉爾吉斯：{area:16675}與{area:16676}",
	-- {area:16675} Magram Front · {area:16676} Outcast Hideaway · {npc:254040} Rokren · {npc:253177} Nerlokh
	-- plural, as words: Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: walk into the Magram camp at the {area:16675}, then south-west into the {area:16676}, where Outcast Necrokhans, elite and level 45, stand guard. In a tent there {npc:254040}, a Gelkis the outcasts hold, asks you to get him out: escort him clear of the hideaway, then tell {npc:253177}."] = "依任務資料：走進{area:16675}的瑪格拉姆營地，然後向西南進入{area:16676}，那裡有45級精英流放者死靈可汗守衛。那裡的一頂帳篷裡，被流放者關押的吉爾吉斯人{npc:254040}請你救他出去：護送他離開藏身處，然後告訴{npc:253177}。",
	-- {npc:254040} Rokren
	["escort {npc:254040} out of the hideaway"] = "護送{npc:254040}離開藏身處",

	-- Step 20: Gelkis: Nerlokh's last order
	-- {npc:253177} Nerlokh
	["Gelkis: {npc:253177}'s last order"] = "吉爾吉斯：{npc:253177}的最後命令",
	-- {npc:253177} Nerlokh
	["From the quest data: with the Magram's warriors busy at the Front, {npc:253177} sees a chance at their khan."] = "依任務資料：瑪格拉姆的戰士們忙於前線，{npc:253177}看見了對付他們可汗的機會。",

	-- Step 21: Gelkis: Khan Jehn
	-- {npc:5601} Khan Jehn
	["Gelkis: {npc:5601}"] = "",
	-- {npc:5601} Khan Jehn · {area:604} Magram Village · {npc:253177} Nerlokh · {npc:5397} Uthek the Wise · {item:271801} Abandoned Ferocity · {item:271802} Bludgeon of Betrayed Virtues · {item:271805} Thrice-Damned Effigy
	-- plural, as words: Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: {npc:5601} (level 37) leads the Magram from the west side of {area:604}, north-east of {npc:253177}. The village is hostile to a friend of the Gelkis, and two Magram Necrokhans, elite and level 45, stand a little west of the khan. {npc:5397} pays 6,000, a title, and your pick of three rare level 35 weapons: {item:271801} (two-handed axe: Strength, Stamina, Agility), {item:271802} (one-handed mace: Strength, Stamina, Agility) or {item:271805} (off-hand: Spirit, Intellect, Stamina). The quest costs the Magram 30,000."] = "",

	-- Step 22: Gelkis: totems to Exalted
	["Gelkis: totems to Exalted"] = "",
	-- {quest:92812} Economic Warfare
	["From Revered on only {quest:92812} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems. Nothing is sold for standing; the recipes below need only totems."] = "",

	-- Step 23: Gelkis done
	["Gelkis done"] = "吉爾吉斯完成",
	["No Gelkis quests done: on to the Magram, south-east."] = "沒有完成任何吉爾吉斯任務：前往東南方的瑪格拉姆。",

	-- Step 24: Magram Village: Warug and Gorhak
	-- {area:604} Magram Village · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604}: {npc:5398} and {npc:253139}"] = "",
	-- {area:604} Magram Village · {zone:1443} Desolace · {npc:5398} Warug · {npc:253139} Gorhak
	["{area:604} fills the valley of south-east {zone:1443}; {npc:5398} stands on its north side, {npc:253139}, the Magram quartermaster, near the lake. Buying Friendship alone takes you from Neutral to Friendly."] = "",

	-- Step 25: Magram: the Kolkar camps
	["Magram: the Kolkar camps"] = "",
	-- {area:608} Nijel's Point
	["The Kolkar centaurs (level 30-33) hold the camps south of {area:608}."] = "",

	-- Step 26: Magram: Broken Tears
	-- {quest:1369} Broken Tears
	["Magram: {quest:1369}"] = "",
	-- {area:606} Gelkis Village
	["The Tears of Theradras are crystals in the cave behind {area:606}, in the south-west. Every Gelkis you kill on the way pays the Magram 20."] = "",
	-- {quest:1369} Broken Tears · {object:22246} Tear of Theradras
	["{quest:1369}: the {object:22246} crystals"] = "",
	-- {npc:4648} Gelkis Stamper
	["{npc:4648}: 20 Magram"] = "",
	-- {npc:4649} Gelkis Windchaser
	["{npc:4649}: 20 Magram"] = "",

	-- Step 27: Magram: Gizmo for Warug
	-- {quest:1371} Gizmo for Warug
	["Magram: {quest:1371}"] = "",
	-- {npc:5398} Warug · {item:4392} Advanced Target Dummy · {item:4234} Heavy Leather · {item:4389} Gyrochronatom · {item:4382} Bronze Framework · {item:4387} Iron Strut · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["{npc:5398} wants an {item:4392}: engineers make it (4 {item:4234}, a {item:4389}, a {item:4382} and an {item:4387}); others buy one. It pays 1,000 and a choice of two engineering schematics, the {item:269900} or the {item:269902}."] = "",
	-- {item:4392} Advanced Target Dummy
	["{item:4392}: made by engineers, or bought"] = "",

	-- Step 28: Magram: totems and kills to Honored
	["Magram: totems and kills to Honored"] = "",
	-- {quest:1371} Gizmo for Warug · {npc:253139} Gorhak · {quest:92811} Economic Warfare · {quest:93224} Carved Centaur Totems · {zone:1443} Desolace · {npc:5398} Warug · {quest:92743} A Conqueror's Crown · {item:254392} Conqueror's Helm · {zone:1418} Badlands · {quest:92841} Valley of Bones
	-- plural, as words: Greater Shadow Protection Potions = {item:13459} Greater Shadow Protection Potion · Massive Iron Axes = {item:3855} Massive Iron Axe
	["Friendly to Honored is 6,000; after the clan's quests you are about 3,000 into it (4,000 with {quest:1371}), so 2,000 to 3,000 to go. {npc:253139}'s {quest:92811} takes 5 {quest:93224} for 750, again and again; the Maraudine centaurs (level 36-40) of western {zone:1443} drop them, and the totems do not bind, so the auction house is the other source. Gelkis kills add 20 each, but Forever's kill data stops them at the end of Friendly, 1 short of Honored. At Friendly the village has two craft orders for 1,000 each: Mirda's 3 Greater Shadow Protection Potions and Grolkar's 2 Massive Iron Axes (blacksmithing). {npc:5398}'s {quest:92743} (1,000) is no craft order: he wants a {item:254392} from a crypt in the {zone:1418}, and Forever's quest pages put it in his chain before the {quest:92841}, so bring it before you reach Honored. Legacy Diplomat adds up to 10%."] = "友好到尊敬需要6,000點；完成部族任務後大約已有3,000點（做了{quest:1371}則有4,000點），還差2,000到3,000點。{npc:253139}的{quest:92811}可以一再繳交，每次收取5個{quest:93224}，獎勵750點；{zone:1443}西部的瑪洛迪半人馬（36-40級）會掉落圖騰，而且圖騰不綁定，所以也可以從拍賣場購買。每擊殺一個吉爾吉斯增加20點，但Forever的擊殺資料在友好末尾、距離尊敬還差1點時就會停止。友好時村裡有兩個製作訂單，每個獎勵1,000點：Mirda要3瓶強效暗影防護藥水，Grolkar要2把巨型鐵斧（鍛造）。{npc:5398}的{quest:92743}（1,000點）不是製作訂單：他需要{zone:1418}一處墓穴裡的{item:254392}，Forever的任務頁面把它放在{quest:92841}之前的任務鏈中，所以在達到尊敬前就帶來。傳承的外交官最多增加10%。",

	-- Step 29: Magram: Warug sends you to the valley
	-- {npc:5398} Warug
	["Magram: {npc:5398} sends you to the valley"] = "瑪格拉姆：{npc:5398}派你前往山谷",
	-- {quest:92743} A Conqueror's Crown · {npc:5398} Warug · {npc:253136} Orgrul · {area:604} Magram Village · {quest:92841} Valley of Bones · {quest:92811} Economic Warfare
	["At Honored and level 35, after {quest:92743}, {npc:5398} sends you to {npc:253136} at the south end of {area:604}, the northern mouth of the {quest:92841}. The valley steps follow Forever's quest data: nobody who records their play has done these quests yet, so a spot or the order may be off. Every valley quest asks you to stay Honored with the Magram, and each costs the Gelkis five times what it pays. Honored to Revered is 12,000; the valley pays 11,125 of it, {quest:92811} the rest."] = "在尊敬且35級時，完成{quest:92743}後，{npc:5398}會派你去找{area:604}南端的{npc:253136}，也就是{quest:92841}的北側入口。山谷的步驟依照Forever的任務資料：記錄遊玩過程的玩家還沒有人做過這些任務，所以地點或順序可能有誤。山谷的每個任務都要求你保持瑪格拉姆尊敬，而每個任務都會讓吉爾吉斯扣掉其獎勵的五倍。尊敬到崇敬需要12,000點；山谷提供其中的11,125點，其餘由{quest:92811}補足。",

	-- Step 30: Magram: Orgrul
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}"] = "瑪格拉姆：{npc:253136}",
	-- {npc:253136} Orgrul · {quest:92846} Outcast Necromancers
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: {npc:253136} wants bones from the valley's Undead Ravagers (the quest log counts them in hundreds) and six {quest:92846} dead: Gelkis exiles meddling with the Magram's new magic."] = "依任務資料：{npc:253136}要山谷中不死掠奪者的骨頭（任務日誌以百為單位計數），以及六名死掉的{quest:92846}：插手瑪格拉姆新魔法的吉爾吉斯流亡者。",

	-- Step 31: Magram: the valley's mouth
	["Magram: the valley's mouth"] = "瑪格拉姆：山谷入口",
	-- {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager
	["From the quest data: the Undead Ravagers and the {quest:92846} fill the valley from {npc:253136} south-west to {npc:253177}'s post at its western mouth; players have met them all along it. {npc:253177} is a Gelkis scout. Corpsefeeders, elite and level 45, walk the valley and attack anyone."] = "依任務資料：不死掠奪者和{quest:92846}遍布山谷，從{npc:253136}一直往西南到山谷西側入口{npc:253177}的崗哨；玩家在整條路上都遇到過他們。{npc:253177}是一名吉爾吉斯斥候。45級精英食屍者在山谷中走動，會攻擊任何人。",
	-- plural, as words: Gently Cursed Bones = {item:254663} Gently Cursed Bone · Undead Ravagers = {npc:11561} Undead Ravager
	["Gently Cursed Bones: Undead Ravagers"] = "輕度詛咒的骨頭：不死掠奪者",

	-- Step 32: Magram: Corrupting Tears
	-- {quest:92847} Corrupting Tears
	["Magram: {quest:92847}"] = "瑪格拉姆：{quest:92847}",
	-- {npc:253136} Orgrul · {item:254841} Petrified Bark · {item:254840} Imbued Tears · {npc:5398} Warug
	["From the quest data: {npc:253136} wants three {item:254841} from the valley's accursed trees (the game's data has no spot for them) and three {item:254840}: {npc:5398} keeps the crystals you took from the Gelkis, so ask him."] = "依任務資料：{npc:253136}要三個來自山谷中受詛咒之樹的{item:254841}（遊戲資料中沒有它們的位置），以及三個{item:254840}：你從吉爾吉斯那裡拿到的水晶在{npc:5398}手上，所以去問他。",
	-- {item:254841} Petrified Bark
	["{item:254841}: the valley's accursed trees"] = "{item:254841}：山谷中受詛咒的樹",

	-- Step 33: Magram: Proof of Concept
	-- {quest:92873} Proof of Concept
	["Magram: {quest:92873}"] = "瑪格拉姆：{quest:92873}",
	-- {npc:253136} Orgrul · {item:254870} Rudimentary Necromancy Staff
	-- plural, as words: Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager · Well Cursed Bones = {item:254842} Well Cursed Bone
	["From the quest data: {npc:253136} gives you a {item:254870}. He laid out two skeletons on the hill just east of his post: put the staff to use there, and the Nascent Undead Ravagers give the Well Cursed Bones."] = "依任務資料：{npc:253136}會給你一根{item:254870}。他在崗哨東邊不遠的山丘上擺了兩具骷髏：在那裡使用法杖，新生的不死掠奪者會給你精心詛咒的骨頭。",
	-- plural, as words: Well Cursed Bones = {item:254842} Well Cursed Bone · Nascent Undead Ravagers = {npc:253360} Nascent Undead Ravager
	["Well Cursed Bones: Nascent Undead Ravagers"] = "精心詛咒的骨頭：新生的不死掠奪者",

	-- Step 34: Magram: Orgrul's next tasks
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s next tasks"] = "瑪格拉姆：{npc:253136}的下一批任務",
	-- {npc:253136} Orgrul · {item:271796} Blade of the Magram Clan · {item:271797} Staff of Revelations · {item:271798} Desperate Barrier
	["From the quest data: {npc:253136} pays 500 and your pick of three items for level 35: {item:271796} (one-handed sword), {item:271797} (staff) or {item:271798} (shield)."] = "依任務資料：{npc:253136}會給你500點，並讓你從三件35級物品中選一件：{item:271796}（單手劍）、{item:271797}（法杖）或{item:271798}（盾牌）。",

	-- Step 35: Magram: the heart of the valley
	["Magram: the heart of the valley"] = "瑪格拉姆：山谷中心",
	-- {npc:253136} Orgrul · {npc:253446} Haggard Bones
	-- plural, as words: Gelkis Captives = {npc:253431} Gelkis Captive · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["From the quest data: south-east of {npc:253136}, in the heart of the valley, the Magram keep Gelkis Captives: kill five. The {npc:253446} there are failed summons stuck in the ground: raise ten with the Enhanced Necromancy Staff Orgrul gave you, and kill the ones that fight back. Corpsefeeders, elite and level 45, walk the valley and attack anyone; the Magram Necrokhans, elite too, leave a friend of the Magram alone."] = "依任務資料：在{npc:253136}東南方的山谷中心，瑪格拉姆關押著吉爾吉斯俘虜：殺死五名。那裡的{npc:253446}是卡在地裡的失敗召喚物：用奧格魯給你的強化死靈法杖喚起十具，並殺掉反擊的那些。45級精英食屍者在山谷中走動，會攻擊任何人；同為精英的瑪格拉姆死靈可汗則不會理會瑪格拉姆的朋友。",
	-- {npc:253446} Haggard Bones
	["Raise or slay {npc:253446}"] = "喚起或殺死{npc:253446}",

	-- Step 36: Magram: Bristleback Retreat
	-- {quest:93066} Bristleback Retreat
	["Magram: {quest:93066}"] = "瑪格拉姆：{quest:93066}",
	-- {npc:253136} Orgrul · {quest:93066} Bristleback Retreat
	["From the quest data: back to {npc:253136}, then east to {quest:93066} for his next order."] = "依任務資料：回到{npc:253136}那裡，然後向東前往{quest:93066}接受他的下一道命令。",

	-- Step 37: Magram: the quilboar
	["Magram: the quilboar"] = "瑪格拉姆：野豬人",
	-- {quest:93066} Bristleback Retreat · {npc:253527} Kog'thug the Brave · {npc:255678} Quolga the Wise · {npc:253851} Hagiak · {area:16675} Magram Front
	["From the quest data: the Bristleback quilboar hold {quest:93066}, east of the valley. {npc:253527} (elite, level 43) and {npc:255678} (elite, level 42) lead them: leave those two be. Then report to {npc:253851} at the {area:16675}, south of the Retreat."] = "依任務資料：刺背野豬人佔據山谷東邊的{quest:93066}。{npc:253527}（精英，43級）和{npc:255678}（精英，42級）率領他們：別碰這兩個。然後到撤退地南邊的{area:16675}向{npc:253851}回報。",

	-- Step 38: Magram: Hagiak at the Magram Front
	-- {npc:253851} Hagiak · {area:16675} Magram Front
	["Magram: {npc:253851} at the {area:16675}"] = "瑪格拉姆：{area:16675}的{npc:253851}",
	-- {npc:253851} Hagiak · {area:16676} Outcast Hideaway
	["From the quest data: {npc:253851} sends you south-west to the {area:16676}, the exiles' camp west of the Shen'dralar town."] = "依任務資料：{npc:253851}派你向西南前往{area:16676}，也就是流亡者在辛德拉城鎮西邊的營地。",

	-- Step 39: Magram: the Outcast Hideaway
	-- {area:16676} Outcast Hideaway
	["Magram: the {area:16676}"] = "瑪格拉姆：{area:16676}",
	-- {item:256892} Stolen Supplies · {quest:92846} Outcast Necromancers · {npc:253136} Orgrul · {npc:253177} Nerlokh
	-- plural, as words: Outcast Scouts = {npc:254283} Outcast Scout · Outcast Necrokhans = {npc:253275} Outcast Necrokhan
	["From the quest data: Outcast Scouts and Marauders hold the hideaway, with Outcast Necrokhans, elite and level 45, among them. The {item:256892} are crates in its west. The quest wants {quest:92846} here too; players have met them only in the valley between {npc:253136} and {npc:253177} so far, so take them there if the hideaway has none."] = "依任務資料：流放者斥候和流放者掠奪者佔據著藏身處，其間還有45級精英流放者死靈可汗。{item:256892}是藏身處西側的箱子。這個任務也要求在這裡擊殺{quest:92846}；目前玩家只在{npc:253136}和{npc:253177}之間的山谷遇到過他們，所以如果藏身處沒有，就到那裡打。",
	-- {item:256892} Stolen Supplies
	["{item:256892}: crates"] = "{item:256892}：箱子",

	-- Step 40: Magram: back to Hagiak
	-- {npc:253851} Hagiak
	["Magram: back to {npc:253851}"] = "瑪格拉姆：回到{npc:253851}處",

	-- Step 41: Magram: Orgrul's ritual
	-- {npc:253136} Orgrul
	["Magram: {npc:253136}'s ritual"] = "瑪格拉姆：{npc:253136}的儀式",
	-- {quest:93196} Khan Jehn · {npc:253136} Orgrul
	["From the quest data: {quest:93196} has been slain by outsiders working for the Gelkis, and {npc:253136} means to raise him."] = "依任務資料：{quest:93196}被替吉爾吉斯辦事的外人殺死了，{npc:253136}打算讓他復活。",

	-- Step 42: Magram: Khan Jehn
	-- {quest:93196} Khan Jehn
	["Magram: {quest:93196}"] = "",
	-- {item:257517} Ultimate Necromancy Staff · {area:604} Magram Village · {quest:93196} Khan Jehn · {item:271800} Scavenged Magram Armament · {item:271803} Greatstaff of the Necrokhans · {item:271804} Soulsplatter Mace
	["From the quest data: take the {item:257517} to the ritual site, a tent by the lake in the middle of {area:604}, and raise {quest:93196}. The risen khan takes the quest: 6,000, a title, and your pick of three rare level 35 weapons: {item:271800} (polearm: Stamina, attack power, Agility), {item:271803} (staff: Intellect, Stamina, Spirit) or {item:271804} (main-hand mace: Intellect, Stamina, Spirit). The quest costs the Gelkis 30,000."] = "",
	-- {quest:93196} Khan Jehn
	["raise {quest:93196} at the tent by the lake"] = "在湖邊的帳篷復活{quest:93196}",

	-- Step 43: Magram: totems to Exalted
	["Magram: totems to Exalted"] = "",
	-- {quest:92811} Economic Warfare
	["From Revered on only {quest:92811} is left: Revered to Exalted is 21,000, 28 turn-ins, 140 totems."] = "",

	-- Step 44: The totem recipes
	["The totem recipes"] = "",
	-- {quest:93224} Carved Centaur Totems · {item:273613} Enchant Bracer - Lesser Agility · {item:250941} Greater Frenzy Potion · {item:250538} Hard Gold Gauntlet · {item:250606} Iron Morningstar · {item:252462} Mystic Thick Armor Kit · {item:253973} Silk Reagent Bag · {item:10011} Stormcloth Gloves · {item:274490} Centaur Hoofwarmers · {item:269900} Centaur Banner Deployment Device · {item:269902} Hoof-Shaped Foot Pedal
	["Both quartermasters sell the same 12 recipes for {quest:93224}, no standing needed: {item:273613} and - Lesser Healing Power; Greater Spellblasting and {item:250941}; {item:250538} and {item:250606} plans; {item:252462}, {item:253973}, {item:10011} and {item:274490} patterns; the {item:269900} and {item:269902} schematics. Keep the totems you need for them before you hand the rest in."] = "兩名軍需官都出售相同的12種配方，用{quest:93224}兌換，不需要聲望：{item:273613}和附魔護腕 - 次級治療能量；強效法爆藥水和{item:250941}；{item:250538}和{item:250606}設計圖；{item:252462}、{item:253973}、{item:10011}和{item:274490}圖樣；以及{item:269900}和{item:269902}結構圖。交出其餘圖騰之前，先留下兌換所需的份量。",
}
