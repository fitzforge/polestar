-- Chinese (traditional) (zhTW): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1470} Ghak Healtouch · {area:144} Thelsamar · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:1470} is below ground in {area:144}, by the inn, where the flight lands. His mushrooms grow in the {area:1517} dig at the {zone:1418}' northern edge, on this guide's loop back north."] = "{npc:1470}在{area:144}的地下，旅店旁邊，就在飛行降落處。他要的蘑菇長在{zone:1418}北緣的{area:1517}挖掘場，在本指南向北折返的路線上。",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}：在地下",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "從{zone:1432}向南騎，穿過山口進入{zone:1418}；{npc:2860}在挖掘場紮營。",
	-- {quest:706} Fiery Blaze Enchantments · {item:4612} Black Drake's Heart
	["{quest:706}: its {item:4612} is a rare drop, so the work and hand-in are optional too"] = "{quest:706}：它的{item:4612}是稀有掉落，所以收集和繳交也都是可選的",

	-- Step 4: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888}獨自在挖掘場東南方的{area:1898}紮營。",

	-- Step 5: Agmond's End
	-- {npc:269577} Dorgaron · {item:278404} Pristine Mattock · {quest:739} Murdaloc
	["{npc:269577}'s {item:278404} lies in the middle of the Stonevault trogg camp, where {quest:739} walks."] = "{npc:269577}的{item:278404}在石窟穴居人營地中央，{quest:739}在那裡走動。",

	-- Step 6: Valley of Fangs
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["{npc:2817}: Blue Pearls from Stranglethorn"] = "{npc:2817}：來自荊棘谷的藍珍珠",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "{npc:2817}的下一個任務不給經驗值：跳過它。",

	-- Step 7: Boss Tho'grun
	-- {npc:2944} Boss Tho'grun · {area:342} Camp Boff · {zone:1418} Badlands
	["{npc:2944} does not stay at {area:342}: he walks a long loop around the {zone:1418} with his guards, from the camp in the west along the south of the zone to about 61,69, north to about 49,49 and back west to the camp. The arrow follows his loop west from here until you meet him."] = "{npc:2944}不會待在{area:342}：他會帶著護衛在{zone:1418}繞一大圈巡邏，從西邊的營地沿著區域南部走到約61,69，再向北到約49,49，然後向西回到營地。箭頭會從這裡沿著他的路線向西指引，直到你遇到他。",

	-- Step 8: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "向東騎回{area:1898}。",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "{npc:2888}的下一個任務是精英狩獵：跳過它。",

	-- Step 9: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "滾燙的雛龍在{npc:2888}東邊的峽谷中築巢；別惹烈焰守護者（精英）。{item:4612}很少掉落：刷怪時掉了就拿著。",

	-- Step 11: Dorgaron
	-- {npc:269577} Dorgaron · {zone:1432} Loch Modan
	["{npc:269577} camps at the foot of the pass into {zone:1432}, on the way north."] = "{npc:269577}在通往{zone:1432}的山口下紮營，就在北上的路上。",

	-- Step 12: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "進入{zone:1432}",

	-- Step 13: Ironband's Excavation Site
	-- {zone:1432} Loch Modan
	["Ride north through the pass into {zone:1432} and east along the south shore to Ironband's camp."] = "向北騎穿過山口進入{zone:1432}，再沿南岸向東到鐵帶的營地。",

	-- Step 14: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "進入{zone:1418}",

	-- Step 15: Badlands
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "{area:1517}挖掘場",

	-- Step 16: The Uldaman dig
	-- {area:1517} Uldaman · {zone:1418} Badlands
	["Back through the pass: the Stonevault troggs dig outside {area:1517} at the {zone:1418}' northern edge. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "穿過山口回去：石窟穴居人在{zone:1418}北緣、{area:1517}外面挖洞。雕花甕和紫紅色蘑菇叢就在他們的洞穴和隧道裡，在地城外面。",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "{item:8047}：在地下",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "{object:2743}：在地下",

	-- Step 17: Back to Loch Modan
	-- {zone:1432} Loch Modan
	["Back to {zone:1432}"] = "返回{zone:1432}",

	-- Step 18: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "向北騎回鐵環挖掘場的營地。",

	-- Step 19: Thelsamar
	-- {area:144} Thelsamar
	["Ride west along the loch to {area:144}."] = "沿湖向西騎到{area:144}。",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "飛往{area:271}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "{area:144}飛行管理員",

	-- Step 21: Southshore
	-- {npc:3980} Raleigh the Devout
	["{npc:3980} preaches by the inn."] = "{npc:3980}在旅店旁佈道。",
	-- {npc:3980} Raleigh the Devout
	["{npc:3980}, upstairs"] = "{npc:3980}，樓上",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "虔誠的萊雷恩的下一個差事在{area:796}：跳過它。",

	-- Step 22: Loremaster Dibbs
	-- {npc:2277} Loremaster Dibbs · {area:271} Southshore
	["{npc:2277} stands in {area:271}, by the inn."] = "{npc:2277}在{area:271}的旅店旁邊。",

	-- Step 24: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "沿道路從{area:271}往東北騎進{zone:1425}；{area:348}就在邊界後方。{npc:5635}在頂層主持，{quest:1450}照料獅鷲棲所，{npc:7884}站在旅店旁。",
	-- {quest:1450} Gryphon Master Talonaxe
	["{quest:1450}, inside"] = "{quest:1450}，室內",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}，室內",

	-- Step 25: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634}在{area:348}東邊的路上紮營。",

	-- Step 26: Witherbark villages
	["Witherbark villages"] = "枯木食人妖村落",
	-- {npc:5634} Rhapsody Shindigger · {npc:270772} Witch Doctor Ti'ik
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace.\nCareful: {npc:270772} (49) and his Hexed Larvae (45) keep to the huts of the western village, around 25,64: take the necklaces from the trolls outside."] = "前兩個籠子一起放在{npc:5634}南邊的枯木村落；第三個在東邊的下一個村落。每隻枯木食人妖都可能掉落項鍊。\n小心：{npc:270772}（49級）和他的妖術幼蟲（45級）待在西邊村落的小屋附近，約在25,64：從外面的食人妖身上拿項鍊。",

	-- Step 27: Aerie Peak
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top; inside"] = "{npc:5636}，在頂層的飛行管理員旁邊；在裡面",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "沙拉克·鷹斧的下一個任務留到之後的{zone:1425}指南。",

	-- Step 28: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "飛往{area:150}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "{area:348}飛行管理員",

	-- Step 30: Theramore
	["Theramore"] = "塞拉摩島",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}，頂樓",

	-- Step 31: Morgan Stern
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}，室內",

	-- Step 32: Mudsprocket
	["Mudsprocket"] = "泥鏈營地",
	-- {area:511} Wyrmbog · {npc:270723} Drazzit Dripvalve · {npc:270727} Gizzix Grimegurgle
	["Take the road south-west out of Theramore to Mudsprocket, the goblin camp at the edge of the {area:511}. {npc:270723} and {npc:270727} stand together in the camp."] = "從塞拉摩沿道路往西南走到{area:511}邊緣的地精營地泥鏈營地。{npc:270723}和{npc:270727}一起站在營地裡。",

	-- Step 33: The Wyrmbog
	-- {area:511} Wyrmbog
	["The {area:511}"] = "{area:511}",
	-- {item:280092} Wyrmtail
	-- plural, as words: Searing Hatchlings = {npc:4323} Searing Hatchling · Firemane Scalebanes = {npc:4328} Firemane Scalebane
	["The {item:280092} grows in the bog east of the camp: gather it first. Then the Searing Hatchlings and Whelps (41-43) and the Firemane dragonkin nest in the bog north and west of Mudsprocket, on the way back; all of them drop the shed scales.\nCareful: the Firemane Scalebanes and Flamecallers are 43-44 and cast fire: pull them one at a time."] = "{item:280092}長在營地東邊的沼澤裡：先採集它。之後回程時，灼熱幼龍和雛龍（41-43）以及火鬃龍類在泥鏈營地北邊和西邊的沼澤築巢；牠們都會掉落蛻下的鱗片。\n小心：火鬃逆鱗守衛和喚焰者是43-44級，會施放火焰法術：一次只拉一隻。",

	-- Step 34: Mudsprocket
	["Then ride back north-east to Theramore's flight master."] = "然後往東北騎回塞拉摩的飛行管理員。",

	-- Step 35: Theramore flight master
	["Theramore flight master"] = "塞拉摩飛行管理員",

	-- Step 37: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "術士：{quest:3631}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["From Theramore, ride north into the {zone:1413} to {area:392}, or fly if you know its flight path. {npc:6251} teaches in the house by the bank."] = "從塞拉摩向北騎進{zone:1413}，前往{area:392}；如果知道飛行路線也可以直接飛。{npc:6251}在銀行旁的房子裡教學。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "飛往{area:392}；{npc:6251}在銀行旁的房子裡授課。之後飛回塞拉摩島。",
	-- ["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "飛往{area:608}，向南騎過{zone:1443}進入{zone:1444}，沿道路前往{area:1108}的碼頭；船會駛往{area:1116}，下一份指南從那裡開始。",
	-- ["Inside {area:498}"] = "在{area:498}內部",
	-- ["On to Feathermoon"] = "前往羽月要塞",
	-- ["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "向北騎到{area:144}，飛往{area:271}。{npc:3980}在旅店旁傳道。",
	-- ["Ride north-east out of {area:271} on the road into the {area:47}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "沿道路從{area:271}往東北騎進{area:47}；{area:348}就在邊界後方。{npc:5635}在頂層主持，{quest:1450}照料獅鷲棲所，{npc:7884}站在旅店旁。",
	-- ["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. Falstad holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "沿道路從{area:271}往東北騎進{zone:1425}；{area:348}就在邊界後方。弗斯塔德·蠻錘在頂層主持，{quest:1450}照料獅鷲棲所，{npc:7884}站在旅店旁。",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "從{zone:1432}向南騎，穿過山口進入{zone:1418}；{npc:2860}在挖掘場紮營。",
	-- ["Ride west across the {area:3} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "向西騎過{area:3}，前往{area:342}的火煙巨魔營地。{npc:2944}站在營地中央，周圍有火煙獵龍者和火煙虐待者。",
	-- ["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "向西騎過{zone:1418}，前往{area:342}的火煙巨魔營地。{npc:2944}站在營地中央，周圍有火煙獵龍者和火煙虐待者。",
	-- ["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "向西騎到{zone:1418}中部的{area:1877}；{npc:2817}在流放者馬特克旁邊紮營。",
	-- ["Take the boat to Theramore from the far pier."] = "從最遠的碼頭搭船前往塞拉摩島。",
	-- ["Talonaxe's next task waits for a later {area:47} guide."] = "沙拉克·鷹斧的下一個任務留到之後的{area:47}指南。",
	-- ["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "殘破的骷髏躺在石窟穴居人營地的邊緣；殺死埃格蒙德的{quest:739}就在石窟斷骨者之間走動。",
	-- ["grind on {npc:2725} at {area:339}, {zone:1418}"] = "在{zone:1418}的{area:339}刷{npc:2725}",
	-- ["{npc:1573}, the {object:32372}"] = "{npc:1573}，{object:32372}",
	-- ["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616}站在船靠岸的碼頭上。",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888}獨自在挖掘場東南方的{area:1898}紮營。",
	-- ["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "{npc:5634}的雞尾酒需要卡林多的材料：跳過它。",
	-- ["{npc:7744}; below ground"] = "{npc:7744}；在地下",
	-- ["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884}會持續收購項鍊：多的都交出去",
}
