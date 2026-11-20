-- Chinese (traditional) (zhTW): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:327} Faldir's Cove
	["For characters of 35 to 37. {area:327}, where the naga and the professor's water elementals are 38-40, is a group stop: skip it if you are alone."] = "適合35到37級的角色。{area:327}的納迦和教授的水元素是38-40級，需要小隊：單獨一人就跳過。",

	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "飛往{area:42}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "{area:35}飛行管理員",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "{npc:5476}守著沼澤西部的路口。{npc:217412}站在他北邊不遠處。\n在 Forever 裡{npc:217412}可能不在這裡：如果{npc:217412}不給{quest:93176}，跳過。",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412}：在阿拉希高地、{zone:1443}和荊棘谷各抓一隻小動物",

	-- Step 4: The western swamp
	["The western swamp"] = "西部沼澤",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "小鹽齒鱷魚、沼澤紡絲蛛和沼澤虎都在道路周圍的沼澤遊蕩。",

	-- Step 6: Father Tuttle
	-- {npc:255597} Father Tuttle · {area:657} Harborage
	["North-west of Watcher Biggs, {npc:255597} (level 34) waits by the road: lead him north to the {area:657}, on your way there. Stay close to him and clear what attacks him; if he falls, abandon the quest and go on."] = "在守望者比格斯西北方，{npc:255597}（34級）在路邊等著：順路帶他向北前往{area:657}。緊跟著他，清掉攻擊他的敵人；如果他倒下了，就放棄任務繼續前進。",

	-- Step 7: Harborage
	-- {area:657} Harborage · {npc:254775} Karana · {npc:254770} Pelluk · {npc:1776} Magtoor · {area:76} Fallow Sanctuary
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Follow the road north to the draenei of the {area:657}. {npc:254775} and {npc:254770} stand beside {npc:1776}: their Lost Ones are the ones you meet in the {area:76} anyway."] = "沿道路向北前往{area:657}的德萊尼。{npc:254775}和{npc:254770}站在{npc:1776}旁邊：他們要的失落者反正你在{area:76}都會遇到。",
	-- {npc:1776} Magtoor · {npc:255597} Father Tuttle
	["{npc:1776}: {npc:255597}'s escort"] = "{npc:1776}：{npc:255597}的護送任務",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {quest:1389} Draenethyst Crystals · {npc:254797} Lost One · {npc:254775} Karana · {npc:254770} Pelluk · {item:258530} Lucky Lure · {quest:1392} Noboru the Cudgel · {npc:1776} Magtoor
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["East along the road to the {area:76}. The {quest:1389} are the glowing blue crystals among the Lost Ones' tents: click them. Any {npc:254797} counts for {npc:254775}, and the Lost One Fishermen on the sanctuary's west side carry {npc:254770}'s {item:258530}. {quest:1392} walks a long path through the ruins; his cudgel starts a quest for {npc:1776}. Don't wait for him.\nCareful: Noboru is level 39, two over you here: fight him only with a friend or from level 38; otherwise let him pass."] = "沿道路向東前往{area:76}。{quest:1389}是失落者帳篷之間發著藍光的水晶：點擊它們。任何{npc:254797}都算在{npc:254775}的任務裡，聖所西側的失落者漁夫身上帶著{npc:254770}的{item:258530}。{quest:1392}沿一條很長的路線穿過廢墟走動；他的木棒會開啟{npc:1776}的任務。不要專門等他。\n小心：諾博魯是39級，比你高兩級：只在有朋友幫忙或38級以上時才打他；否則就讓他過去。",
	-- {quest:1392} Noboru the Cudgel
	["from {quest:1392}: he walks a path through the ruins"] = "來自{quest:1392}：他沿一條路線穿過廢墟走動",
	-- {item:6071} Draenethyst Crystal
	["{item:6071}, the blue crystals by the tents"] = "{item:6071}，帳篷旁的藍色水晶",
	-- {item:258530} Lucky Lure · {npc:757} Lost One Fisherman
	["{item:258530}, from a {npc:757}"] = "{item:258530}，從{npc:757}身上取得",
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Lost Ones: Hunters, Muckdwellers, Seers and Riftseekers all count"] = "失落者：獵人、泥居者、先知和尋隙者都算",

	-- Step 9: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "損毀車隊的箱子在{area:76}北端、{npc:5391}的籠子旁。\n注意：營地到處是38級左右的失落者。它們以2-3隻連組行動，其中許多是施法者，且重新出現很快。",

	-- Step 10: Galen Goodward
	-- {npc:5391} Galen Goodward
	-- plural, as words: Lost One Riftseekers = {npc:762} Lost One Riftseeker · Lost Ones = {npc:254797} Lost One
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards. Careful: on the walk out the camp's Lost One Riftseekers (37-38) and their pets, with the Lost Ones around them, turn on {npc:5391}: clear the cage and the start of his path first, stay beside him and pull every attacker onto yourself. Many players lose him the first time; if he dies, abandon the quest and take it again at his cage."] = "{npc:5391}被關在聖所北端的籠子裡。釋放他並在走出去的路上保護他；之後他的保險箱就在路邊。小心：走出去的路上，營地裡的失落尋隙者（37-38級）和牠們的寵物，連同周圍的失落者，會攻擊{npc:5391}：先清掉籠子和他路線的起點，緊跟在他身邊，把所有攻擊者都拉到自己身上。很多玩家第一次會讓他死掉；如果他死了，就放棄任務，再到他的籠子重新接。",

	-- Step 11: Harborage
	-- {npc:5391} Galen Goodward · {area:657} Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "從{npc:5391}的保險箱沿路向西到{area:657}。",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "{npc:1776}：諾博魯的木棒",
	-- {npc:1776} Magtoor · {quest:93464} The Visiting Mage · {npc:11863} Azore Aldamort · {zone:1443} Desolace
	["{npc:1776}: {quest:93464}, for {npc:11863} in {zone:1443}, on the {zone:1443} guide at the end of 30-40"] = "{npc:1776}：{quest:93464}，給{zone:1443}的{npc:11863}，在30-40末尾的{zone:1443}指南",

	-- Step 12: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "沿路向南到{npc:5476}，在向西離開沼澤的路上。",

	-- Step 14: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "飛往{zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "向西穿過{zone:1430}回到{area:42}。",

	-- Step 15: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}，{area:17203}的路上",

	-- Step 16: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122}在{object:2101}{object:2164}的地窖裡等著。在那裡的召喚法陣使用{item:6913}，擊敗召喚出的魅魔。如果你接了{quest:65602}，也把{item:190309}交給他，放在同一個法陣並擊敗夢魘。",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "{npc:5677}，在召喚法陣處",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}，如果你有接",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}，在同一個法陣",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122}會把夢魘束縛給你",

	-- Step 17: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}，光明大教堂",

	-- Step 19: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}，城堡裡的皇家圖書館",

	-- Step 20: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "乘地鐵前往{zone:1455}",

	-- Step 21: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飛往{area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "{zone:1455}飛行管理員",

	-- Step 22: Southshore
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside, if 30-40/01 didn't take it: the Syndicate camp is on the way to Arathi"] = "{npc:2276}，在裡面，如果30-40/01沒接的話：辛迪加營地在前往阿拉希的路上",

	-- Step 23: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore · {npc:2276} Magistrate Henry Maleb
	["A {npc:2434} (37-38) lurks stealthed on the edge of {area:271}, and few players find him. Careful: he is a level or two over you; fight him only at full health, or leave him. His contract goes to {npc:2276}. Don't wait for him: the rest of this step doesn't need him."] = "一個{npc:2434}（37-38級）隱身潛伏在{area:271}邊緣，很少有玩家能找到他。小心：他比你高一兩級；只在滿血時才打他，否則就別理他。他的契約交給{npc:2276}。不要專門等他：這一步的其餘部分不需要他。",
	-- {npc:2434} Shadowy Assassin
	["{npc:2434}, if you spot him"] = "{npc:2434}，如果你發現他",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}，室內",

	-- Step 25: Alterac Mountains
	["Syndicate camp"] = "辛迪加營地",

	-- Step 26: Syndicate camp
	-- {area:271} Southshore · {area:272} Tarren Mill
	-- plural, as words: Syndicate Wizards = {npc:2319} Syndicate Wizard
	["North out of {area:271} to the Syndicate camp on the Alterac border, west of {area:272} (Horde): its Footpads and Thieves are the Syndicate Maleb wants, and the documents lie in the camp. Then back to the road and east to Arathi.\nCareful: a few Syndicate Wizards (34-35) stand among the tents and cast from range: pull them one at a time."] = "從{area:271}向北前往奧特蘭克邊界上的辛迪加營地，在{area:272}（部落）西邊：那裡的辛迪加腳夫和盜賊就是馬雷布要的辛迪加，文件就在營地裡。然後回到道路上，向東前往阿拉希。\n小心：帳篷之間站著幾個辛迪加巫師（34-35級），會從遠處施法：一次拉一個。",

	-- Step 28: Refuge Pointe
	-- {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["From the Syndicate camp, follow the road east over {area:1057} to {area:320}."] = "從辛迪加營地沿道路向東越過{area:1057}前往{area:320}。",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "{npc:2700}：{npc:1075}的請求，來自 01-hillsbrad-foothills",

	-- Step 29: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "辛迪加佔據著{area:320}西北的農場。\n注意：辛迪加路匪是30-31級，脫離戰鬥時會施放潛行，所以常常處於潛行狀態，很難發現。",

	-- Step 30: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s {item:213565}."] = "",

	-- Step 31: Shards of Myzrael
	-- {quest:681} Northfold Manor · {area:333} Circle of East Binding · {area:314} Go'Shek Farm
	["East from {quest:681} across the north of the Highlands; the shards glitter on the hill by the {area:333}, north of {area:314}."] = "從{quest:681}向東橫越高地北部；碎片在{area:314}北邊、{area:333}旁的山丘上閃閃發光。",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "只有在荊棘谷的戈魯格爾給了你墜飾時",

	-- Step 32: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "{area:318}：遇到就殺",
	-- {area:321} Hammerfall · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop the Motes of Myzrael, not Krazek's ore. Lesser Bloodstone Deposits need {skill:186} 75: mine four ore, buy them at the Auction House, or ask a miner friend. The ore goal is optional; continue with Myzrael if you cannot get it. Careful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "枯鬚狗頭人在部落城鎮{area:321}以東的峽谷裡採掘，從城鎮北側繞過去。牠們掉落密斯賴爾之塵，不掉克拉茲克要的礦石。次級血石礦脈需要{skill:186} 75：開採四塊礦石、在拍賣場購買，或請會採礦的朋友幫忙。礦石目標是可選的；拿不到就繼續做密斯賴爾的任務。小心：每種狗頭人在低血量時都會逃跑求援（枯鬚狗頭人30%，勘探員和掘地工15%），可能引來更多敵人。",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "從這一站附近的{npc:2572}、{npc:2573}和{npc:2574}身上獲取{item:4435}",

	-- Step 33: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "碎片在{area:318}的最深處。",
	["Below ground"] = "地下",

	-- Step 34: Iridescent Shards
	-- {quest:651} Stones of Binding · {object:2691} Stone of East Binding
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{quest:651} is a group quest at this level: three Cresting Exiles (38-39) guard the {object:2691} and attack together. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "在這個等級{quest:651}是小隊任務：三個水浪流放者（38-39級）守護著{object:2691}，會一起攻擊。鼓勵組隊，找人一起做。如果你是一個人就跳過。",

	-- Step 35: Witherbark Village
	-- {area:318} Drywhisker Gorge · {area:314} Go'Shek Farm · {area:317} Witherbark Village
	-- plural, as words: Witherbark Goliaths = {npc:218032} Witherbark Goliath
	["South from {area:318}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk. Careful: Witherbark Goliaths (35, elite) walk the far end with the Shadow Hunters: pull the Hunters out to you one at a time, away from the Goliaths."] = "",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "{item:5040}；地下",

	-- Step 36: Quae
	-- {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["North-west out of the Witherbark valley; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "向西北離開枯木山谷；{npc:2712}和{npc:2713}在{area:314}北邊不遠的丘陵紮營。",

	-- Step 37: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road from {area:314} west across the Highlands, as far as about 24,45, and back, with two guards: the arrow follows the road west until you meet him. Pull them off the road."] = "被遺忘者信差帶著兩名守衛，沿道路從{area:314}向西橫越高地，最遠約到24,45，再走回來：箭頭會沿道路向西指引，直到你遇見他。把他們拉離道路。",

	-- Step 39: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712}與{npc:2713}",

	-- Step 40: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "{npc:2713}的差事",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "跟著{npc:2713}潛入{area:314}再回來；途中部落獸人會突襲你。\n小心：血量低的獸人會逃跑。{npc:2713}會追上去，可能引來更多怪，所以要盡快殺掉或減速逃跑的敵人。",

	-- Step 41: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "給{area:271}的{npc:2711}",

	-- Step 42: Stones of Binding
	-- {npc:2712} Quae · {object:2691} Stone of East Binding · {area:314} Go'Shek Farm · {object:2702} Stone of Inner Binding · {area:320} Refuge Pointe
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["From {npc:2712}'s camp, a short way north-east to the {object:2691}, by the shards' hill north of {area:314}. The {object:2702}, where the three keys go, stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "從{npc:2712}的營地向東北走一小段到{object:2691}，就在{area:314}北邊碎片所在的山丘旁。放三把鑰匙的{object:2702}在{area:320}西邊。\n小心：每塊中央石頭都有大約三隻接近39級的元素守護，如果沒先清掉就點擊石頭，牠們會一起攻擊：西側是烈焰流放者，外圍是雷霆流放者，東側是水浪流放者。",

	-- Step 43: Refuge Pointe
	-- {area:320} Refuge Pointe
	["West along the road to {area:320}."] = "沿道路向西前往{area:320}。",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {object:2689} Stone of West Binding
	["{npc:2789}: {npc:2793}'s cave, west past the {object:2689}"] = "{npc:2789}：{npc:2793}的洞穴，向西經過{object:2689}",

	-- Step 45: Faldir's Cove
	-- {npc:2768} Professor Phizzlethorpe
	["A group stop: two level 40 water elementals ambush {npc:2768}'s escort, and the Daggerspine naga in the reef are 38-40, with Sorceresses among them. Grouping up is encouraged, look for people to do it with. Skip it if you are alone.\nSouth along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "小隊行程：兩隻40級水元素會伏擊{npc:2768}的護送，礁石裡的刺脊納迦是38-40級，其中還有女巫。鼓勵組隊，找人一起做。如果你是一個人就跳過。\n沿西海岸向南前往地精的海灣；洛洛在上方的岩石上守望。",

	-- Step 46: Phizzlethorpe
	["Phizzlethorpe"] = "菲茲索普教授",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "護送教授上山到海灣上方的洞穴，並在他工作時守護他。兩個40級水元素會在那裡伏擊他，而且免疫冰霜。把它們擋在洞口、遠離他：如果戰鬥發生在洞內，教授就會參戰而不工作，還會不斷湧來更多水元素。",

	-- Step 48: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}：遇到就殺",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "兩艘沉船在海灣西邊的海灣裡。海圖和航海日誌在船內；寶石散落在周圍的海床上。刺脊納迦在整個海灣游動。",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "{npc:2595}，水下",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "{item:4492}；水下",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "{npc:2596}，水下",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "{object:2709}；水下",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "{object:2707}；水下",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "{object:2710}；水下",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "{object:2708}；水下",

	-- Step 49: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "給{area:35}的{npc:2487}：先留著",

	-- Step 50: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["South-east through the hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley.\nCareful: {npc:2793} is level 39, a caster, one or two over you here: clear the cave mouth first, then pull him alone at full health."] = "向東南穿過丘陵：食人魔法師{npc:2793}佔據著枯木山谷南端的洞穴。\n小心：{npc:2793}是39級施法者，比你高一兩級：先清掉洞口，然後在滿血時單獨拉他。",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "{item:4525}；地下",

	-- Step 51: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "從{npc:2793}的洞穴向西南到{area:880}：{npc:2696}站在橋的斷口處；從橋的北端跳下去找他。{quest:647}必須在15分鐘內送到{area:271}的{npc:2705}手裡：直接回{area:320}，飛往{area:271}。",

	-- Step 53: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "{area:320}飛行管理員",

	-- Step 54: Brewmeister Bilger
	-- {area:271} Southshore · {npc:2276} Magistrate Henry Maleb · {npc:2277} Loremaster Dibbs · {area:280} Strahnbrad
	["Off the flight, straight to the {area:271} inn. Then {npc:2276} and {npc:2277}, in the town hall, take the Syndicate camp's quests and send you north to {area:280}."] = "下了飛行路線，直接前往{area:271}旅店。然後鎮公所裡的{npc:2276}和{npc:2277}會給你辛迪加營地的任務，派你向北前往{area:280}。",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "{npc:2705}，在地下",
	-- {npc:2276} Magistrate Henry Maleb · {area:280} Strahnbrad
	["{npc:2276}: the signet rings are in {area:280}"] = "{npc:2276}：圖章戒指在{area:280}",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}, at the end of this guide"] = "給{zone:1455}的{npc:1356}，在本指南的最後",

	-- Step 56: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings."] = "沿道路從{area:271}向北進入山區。山地獅在山坡上遊蕩；{area:280}的辛迪加戴著圖章戒指。",

	-- Step 57: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "{area:281}：遇到就殺",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "典籍在{area:280}以西的廢墟要塞裡；阿格斯暗影法師佔著那片廢墟。\n注意：碎脊好戰者血量降到一半以下時，會呼叫15碼內的同伴。\n碎脊重擊者、法師、執行者和好戰者（36-39級）是精英；碎脊食人魔和蠻兵（34-35級）不是精英，也會掉典籍：一次拉一個，或者組隊。",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658}：破碎嶺巨魔",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase · {quest:540} Preserving Knowledge
	["{item:3659}: the {object:1760}, beside Muckrake (40, elite): get it with a group, or abandon {quest:540}; inside"] = "{item:3659}：{object:1760}，在泥耙（40級，精英）旁邊：組隊去拿，或放棄{quest:540}；在裡面",

	-- Step 58: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:2417} walks from the arrow north-east through the ruins to about 40,47 and back: if he isn't at the arrow, follow his path."] = "這些是精英怪物：建議組隊，找人一起打。{npc:2417}是40級精英：大多數職業在42級時可以單刷，但你可能需要幫忙。如果你是獨自一人就跳過：路線會讓你把經驗值練回來。\n{npc:2417}會從箭頭處向東北穿過廢墟走到約40,47再走回來：如果他不在箭頭處，就沿著他的路線找。",

	-- Step 59: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "{area:280}：遇到就殺",
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps north of the village. Leave him be."] = "小心：辛迪加間諜和辛迪加刺客可能處於潛行狀態。刺客還會讓你中毒。\n小心：{npc:2306}（40級）每次只會出現在一個地點：{area:280}旅店的地窖，或村莊北邊的其中一處辛迪加帳篷營地。別去惹他。",

	-- Step 60: Crushridge ogres
	["Crushridge ogres"] = "破碎嶺巨魔",
	-- {area:280} Strahnbrad
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Careful: Nagaz (40) stands far to the north-west by a worn wooden chest, with Syndicate guards: stay with the ogres.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "破碎嶺巨魔佔據{area:280}北邊的丘陵。小心：納加茲（40級）站在遠處西北方一個破舊的木箱旁，身邊有辛迪加守衛：待在巨魔這邊就好。\n破碎嶺虐待者、法師、執行者和戰爭販子（36-39級）是精英；破碎嶺巨魔和蠻兵（34-35級）不是精英，也會掉落指節骨：一次拉一隻，或組隊。",

	-- Step 62: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "向西南前往{area:279}西邊湖岸的祈倫托營地，就在越過邊界進入{zone:1421}之處：{npc:269127}站在那裡。大法師安斯雷姆·魯因維沃爾站在它東南方的穹頂旁。",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "給{area:35}的{npc:2542}：先留著",

	-- Step 63: Image of Archmage Modera
	-- {npc:269127} Image of Archmage Modera · {quest:92458} Heart of Disruption · {item:277507} Dalaran Sewer Key
	["For your City of Dalaran run, next: the {npc:269127} wants the arcane remnants in the city thinned out and a mote from the heart of the disruption. {quest:92458} brings the {item:277507}, which opens the grate."] = "為了你接下來的達拉然城之行：{npc:269127}要你削減城裡的奧術殘影，並從混亂之心取得一顆微粒。{quest:92458}會給你{item:277507}，用來打開柵欄。",

	-- Step 64: City of Dalaran
	["City of Dalaran"] = "達拉然城",
	-- {quest:92457} Starving Arcane · {item:251961} Arcane Mote · {quest:92458} Heart of Disruption
	-- plural, as words: Seeking Remnants = {npc:247003} Seeking Remnant · Saturated Remnants = {npc:247001} Saturated Remnant
	["The City of Dalaran is a dungeon for a group of five at about level 28 to 33: at your level it goes quickly. Its way in is the sewer grate in the city's western wall, by the lake, 30 yards from Modera's camp.\nInside: the Seeking Remnants, Saturated Remnants and Mana Echoes are Modera's {quest:92457}; the {item:251961} for {quest:92458} drops inside too."] = "達拉然城是五人地城，約28到33級：以你的等級會打得很快。入口是城市西牆的下水道柵欄，在湖邊，距離摩德拉的營地30碼。\n裡面：搜尋殘影、飽和殘影和法力回音是摩德拉的{quest:92457}；{quest:92458}的{item:251961}也在裡面掉落。",
	-- {quest:92457} Starving Arcane
	["{quest:92457}: the remnants and echoes, inside"] = "{quest:92457}：殘影和回音，在裡面",
	-- {quest:92458} Heart of Disruption · {item:251961} Arcane Mote
	["{quest:92458}: the {item:251961}, inside"] = "",

	-- Step 65: Image of Archmage Modera
	["Back out of the grate to Modera's camp on the lake shore."] = "從柵欄出來，回到湖岸上摩德拉的營地。",

	-- Step 68: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "給{zone:1453}的{npc:1440}：先留著",

	-- Step 69: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "{npc:2438}站在飛行管理員和旅店之間；要是你沒有{item:2321}，他旁邊的{npc:2381}有賣。",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "{item:2321}，來自{npc:2381}",

	-- Step 71: Ironforge
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356}：給{zone:1432}的{npc:1344}，接下來交",

	-- Step 72: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "飛往{area:144}",

	-- Step 73: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "前往{area:144}",
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "從{zone:1455}走隧道向東穿過{zone:1426}進入{zone:1432}，沿道路前往{area:144}。",

	-- Step 74: Thelsamar
	-- {zone:2548} Riverglades · {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass
	["Leave the {zone:2548} for about level 41: its Western Front has elite patrols. After Stranglethorn, the {zone:2548} guide takes you from {zone:1455} to {area:69}, then through {area:2417}."] = "",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}，地下",

	-- Step 75: Prospector Ironband
	["South-east along the loch to the dig site."] = "沿湖向東南前往挖掘場。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:2434} lurks stealthed on the edge of {area:271}, and few players find him. If you spot him, kill him and read the contract he carries: {npc:2276} takes it. Don't wait for him: the rest of this step doesn't need him."] = "一個{npc:2434}隱身潛伏在{area:271}邊緣，很少有玩家能找到他。如果發現他，殺死他並閱讀他身上的契約：{npc:2276}會收下它。不要專門等他：這一步的其餘部分不需要他。",
	-- ["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "一個{npc:2434}隱身潛伏在{area:271}邊緣；殺死他並閱讀他身上的契約。",
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "每把鑰匙都在高地的一處立石圈：碎片東邊、{area:320}附近，以及西部。{object:2702}在{area:320}西邊。\n小心：每塊中央石頭都有大約三隻接近39級的元素守護，如果沒先清掉就點擊石頭，牠們會一起攻擊：西側石圈是燃燒的流放者，外圍石圈是雷霆流放者，東側石圈是浪峰流放者。",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals. {quest:1392} walks a long path through the ruins: if you meet him, kill him, his cudgel starts a quest for {npc:1776}. Don't wait for him."] = "沿道路向東前往{area:76}。{npc:256028}怪物會掉落水晶。{quest:1392}會沿一條很長的路線穿過廢墟走動：如果遇到他，就殺了他，他的木棒會開始一個交給{npc:1776}的任務。不要專門等他。",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "沿道路向東前往{area:76}。{npc:256028}怪物會掉落水晶；木棒諾博魯在廢墟中走動，會掉落他的木棒。",
	-- ["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "從{area:327}向東穿過南部丘陵：巨魔法師{npc:2793}佔據枯木山谷南端的洞穴。",
	-- ["Ebenezer Rustlocke"] = "伊貝尼瑟的屍體",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "護送教授到海灣北邊的海灘，在他工作時保護他；納迦會一波波來襲。",
	-- ["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "沿道路從{area:287}向東越過{area:1057}前往{area:320}。",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "沿道路從{area:271}向北進入山區。山地獅在山坡上遊蕩；{area:280}的辛迪加戴著圖章戒指，{npc:2306}在鎮北側的莊園庭院走動。",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings. {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village."] = "沿道路從{area:271}向北進入山區。山地獅在山坡上遊蕩；{area:280}的辛迪加戴著圖章戒指。{npc:2306}（40）每次只會出現在一個地點：{area:280}旅店的地窖，或村莊北邊及西北邊高地上的某個辛迪加帳篷營地。",
	-- ["Follow the road north to the draenei of the {area:657}."] = "沿道路向北前往{area:657}的德萊尼人那裡。",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "沿道路向南過橋，前往{zone:1437}那一端的{area:205}，{npc:1075}在那裡等著。",
	-- ["For characters of 36 to 38, but {area:327} and the Alterac Syndicate quests are level 40: on purpose, for their experience. {npc:2768}'s two water elementals (40) are immune to frost, and {npc:2306} (40) waits among his Syndicate: pull them one at a time."] = "適合36到38級的角色，但{area:327}和奧特蘭克辛迪加的任務是40級：這是刻意安排的，為了它們的經驗值。{npc:2768}的兩個水元素（40級）免疫冰霜，{npc:2306}（40級）在他的辛迪加手下之間等著：一次拉一個。",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "從{area:42}沿道路向東穿過{zone:1430}進入{zone:1435}；衛兵比格斯守在入口不遠處的道路岔口。{npc:217412}站在他北邊不遠處。",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "從{zone:1455}走隧道向東穿過{zone:1426}進入{area:38}，沿道路前往{area:144}。",
	-- ["Gyll, {area:35}"] = "蓋爾，{area:35}",
	-- ["Head back south from the eastern circle; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "從東邊的石圈往南走回去；{npc:2712}和{npc:2713}在{area:314}北邊不遠的丘陵紮營。",
	-- ["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "向北經過{area:314}；碎片在{area:333}旁的山丘上閃閃發光。",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "向東北騎回去經過{area:320}；{npc:2712}和{npc:2713}在{area:314}北邊的丘陵紮營。",
	-- ["Shaman training"] = "薩滿訓練",
	-- ["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "沿西海岸向南前往哥布林的海灣；哨兵魯魯在上方的岩石上守望。",
	-- ["South from the {object:2691}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "從{object:2691}向南，經過{area:314}，前往丘陵中的{area:317}：枯木巫醫站在小屋之間，枯木暗影獵手守在山谷遠端。每個食人妖都可能掉落獠牙。",
	-- ["South from {area:318}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "從{area:318}向南，經過{area:314}，前往丘陵中的{area:317}：枯木巫醫站在小屋之間，枯木暗影獵手守在山谷遠端。每個食人妖都可能掉落獠牙。",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "向西南前往{area:279}西邊湖岸的祈倫托營地，就在越過邊界進入{area:130}之處：{npc:269127}站在那裡。大法師安斯雷姆·魯因維沃爾站在它東南方的穹頂旁。",
	-- ["Subdue the succubus"] = "制服魅魔",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "破碎嶺巨魔佔據{area:280}北邊的丘陵。再往北，一個破舊的木箱裡有{item:3706}；{quest:537}的{npc:2320}就站在旁邊。\n破碎嶺搗毀者、法師、執行者和戰爭販子（36-39級）是精英；破碎嶺巨魔和蠻兵（34-35級）不是精英，也會掉落指節骨：一次拉一隻，或組隊。",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "枯鬚狗頭人在{area:321}（部落）東邊的峽谷中挖掘；從北邊繞過城鎮。他們會掉落微粒和克拉澤克要的礦石。",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "辛迪加佔據{area:320}西北方的農場。一隻{npc:217589}在農場裡爬來爬去：用{npc:217412}的昆蟲學入門套件抓一隻，然後勾選完成。",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "枯木食人妖住在{area:314}南邊的丘陵；枯木巫醫站在村子裡，枯木暗影獵手守在山谷遠端。",
	-- ["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "被遺忘者信差帶著兩名守衛走在{area:314}西邊的道路上；把他們拉離道路。",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "書卷在{area:280}西邊的城堡廢墟中；暗影大法師佔據著廢墟。",
	-- ["The wrecked caravan lies off the road near Biggs."] = "失事的商隊在衛兵比格斯附近的路邊。",
	-- ["The wrecks"] = "沉船",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "走回橋上：伊貝尼瑟的屍體在橋的阿拉希那一端下方。",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "如果你沒有，向{npc:2381}購買{npc:2438}的披風所需的{item:2321}",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659}：{object:1760}",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589}：抓住牠，用於{quest:93176}",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}，在達拉然城內",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453}沒有薩滿訓練師：從{object:28027}搭乘{area:2257}前往{zone:1455}，向{npc:258098}學習。{object:32372}的{npc:1573}也能飛往{area:271}。",
}
