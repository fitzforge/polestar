-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飛往{object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "",

	-- Step 2: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "",

	-- Step 3: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "叢林捕獵者",
	-- {object:3202} Grom'gol
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "叢林捕獵者（40-41級）在{object:3202}南邊的海岸獵食。牠們比你高很多：一次拉一隻，戰鬥之間休息。",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "飛往{area:35}",
	-- {object:3202} Grom'gol
	["{object:3202} flight master"] = "",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "",
	["Inside"] = "",

	-- Step 7: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "從隧道出城；字條在{area:35}北邊不遠的海盜海灣裡。",

	-- Step 8: Booty Bay
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "",

	-- Step 9: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "在藏寶海灣南邊，血帆流氓在{area:43}紮營；海圖和命令在他們的帳篷裡。任何血帆海盜都可能帶著鼻煙和{npc:2493}的眼睛，所以持續擊殺直到兩樣都拿到。",

	-- Step 11: The Bloodsail ships
	["The Bloodsail ships"] = "血帆海盜船",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["Optional, and tough at 41: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "留待之後在{zone:1435}的一站",

	-- Step 12: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "沿道路從{area:35}向北出城；巫醫安巴格瓦坐在{area:1737}道路東邊的山丘上。",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "",

	-- Step 13: Mistvale gorillas
	["Mistvale gorillas"] = "迷霧谷猩猩",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "猩猩在巫醫安巴格瓦周圍的山谷遊蕩。老邁的迷霧谷猩猩會掉落內臟；任何一隻都可能掉落尖牙。",

	-- Step 14: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "把尖牙交給巫醫安巴格瓦並待在他身邊：他會召來三波猩猩，然後是{npc:1514}。一次對付一隻。",

	-- Step 16: Venture Co. mine
	["Venture Co. mine"] = "風險投資公司礦坑",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "",

	-- Step 18: Nesingwary's camp
	["Nesingwary's camp"] = "奈辛瓦里的營地",
	["Head north up the road; the hunters camp on the hill above the river."] = "",

	-- Step 20: Zul'Kunda
	["Zul'Kunda"] = "祖昆達廢墟",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {quest:586} Speaking with Gan'zulah · {area:1517} Uldaman
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "",
	-- {quest:586} Speaking with Gan'zulah
	["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "",

	-- Step 21: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}，在{npc:2497}旁邊",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "",

	-- Step 22: Jungle stalkers
	["Jungle stalkers"] = "叢林捕獵者",
	-- {object:3202} Grom'gol
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "叢林捕獵者迅猛龍在{object:3202}南邊的叢林狩獵，一直延伸到西海岸。",

	-- Step 23: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "沿海岸向南。納迦探險者在岸邊涉水，身上帶著蘆葦束；{object:759}就在他們東邊的丘陵中冒泡。",

	-- Step 24: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "",
	-- {npc:6807} Innkeeper Skindle
	["{npc:6807}, upstairs"] = "",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "",

	-- Step 25: Zanzil's camps
	["Zanzil's camps"] = "贊吉爾的營地",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "在迷霧谷東北方，流亡者贊吉爾的追隨者在叢林中紮營；每一個都可能帶著混合物。",

	-- Step 26: Pirate ghosts
	["Pirate ghosts"] = "海盜鬼魂",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "三個海盜鬼魂在{area:35}北邊、贊吉爾營地附近的叢林出沒：{npc:2535}和{npc:2536}站在一起，{npc:2537}在更東邊。",

	-- Step 27: Zul'Mamwe
	["Zul'Mamwe"] = "祖瑪維廢墟",
	-- {npc:1059} Ana'thek the Cruel
	["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "",
	["Skullsplitter warriors"] = "劈顱戰士",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "",
	["Below ground"] = "",

	-- Step 28: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "",
	-- {object:3202} Grom'gol
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "",

	-- Step 29: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Head west to {object:3202}."] = "",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "",

	-- Step 31: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "",

	-- Step 32: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "鐵齶蜥蜴",
	-- {area:35} Booty Bay · {object:3202} Grom'gol
	["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "",

	-- Step 33: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Ride on north to {object:3202}."] = "",

	-- Step 35: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "",

	-- Step 37: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 38: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "",

	-- Step 42: Level 42.68
	["Level 42.68"] = "",
	-- {quest:192} Panther Mastery · {quest:195} Raptor Mastery · {area:1517} Uldaman
	["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "",

	-- Step 43: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "",

	-- Step 45: Level 42.74
	["Level 42.74"] = "",
	-- {quest:208} Big Game Hunter · {area:1517} Uldaman
	["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "",

	-- Step 49: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "進入{zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "",

	-- Step 50: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road. Bind here."] = "",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "",
	-- {npc:6930} Innkeeper Karakul
	["{npc:6930}, upstairs"] = "",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "",

	-- Step 51: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "鹽齒鱷魚",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "鹽齒鱷魚在{npc:5391}營地周圍和往南到{area:75}的水池中打滾；約四隻有一隻掉落側腹肉。",

	-- Step 52: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "木棒諾博魯在{area:76}西南方的空地遊蕩；他的木棒會開啟一個任務。",

	-- Step 53: Draenethyst crystals
	["Draenethyst crystals"] = "德萊尼水晶",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "向東北騎到{area:76}。水晶沿著通往{npc:5391}籠子的路分布。",

	-- Step 54: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391}被關在沼澤東北部的{area:76}。釋放他並跟著他出去，擊退追趕他的沼澤生物。",

	-- Step 55: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "",

	-- Step 56: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "搭船前往{area:35}",
	-- ["Fly to {area:392}"] = "飛往{area:392}",
	-- ["From {area:2408} fly to {area:392}."] = "從{area:2408}飛往{area:392}。",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "再往北，風險投資公司的哥布林在道路東邊的礦坑挖掘；礦工、工頭、勘探員和修理工都會掉落水晶。",
	-- ["Hearth to {area:35}"] = "用爐石回到{area:35}",
	-- ["Hearth to {object:3202}"] = "用爐石回到{object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "他的保險箱在{area:75}北邊他的舊營地。",
	-- ["Into the {area:8}"] = "進入{area:8}",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "繼續向北騎進{zone:1431}，再沿道路向東穿過{zone:1430}進入沼澤。{npc:1776}在{area:657}等著，那是靠近{zone:1430}入口的德萊尼營地。",
	-- ["Naga shore and the {object:759}"] = "納迦海岸與{object:759}",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "向東騎回去經過{area:75}，沿道路向東南前往海岸上的小型部落哨站。",
	-- ["Ride east to {area:75}, in the reeds south of the road."] = "向東騎到道路南邊蘆葦叢中的{area:75}。",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "向北騎到風險投資公司礦坑東邊的劈顱食人妖廢墟；一次只拉一隻劈顱獵頭者或劈顱狂戰士。{npc:1059}守在西南方的廢墟，一堆祖瑪維顱骨堆在廢墟北側。每個劈顱食人妖都可能掉落獠牙或項鍊：項鍊最花時間，所以在廢墟北邊的劈顱戰士營地持續擊殺，直到收集完畢。",
	-- ["Ride north up the road to the hunters' camp."] = "沿道路向北騎到獵人營地。",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "沿道路向北騎；獵人在河流上方的山丘上紮營。",
	-- ["Ride north-west to {object:3202}."] = "向西北騎到{object:3202}。",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "向南騎到{area:35}。「病鬼」菲力浦在碼頭上等著。",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "沿道路向西騎到{area:657}的德萊尼營地，靠近{zone:1430}的入口。",
	-- ["Ride west to {object:3202}."] = "向西騎到{object:3202}。",
	-- ["Sawtooth snappers"] = "鹽齒鉗嘴鱷",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "船在{area:35}的港口靠岸。任務給予者站在港口周圍的木棧道上和旅店裡。",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "前往{area:35}的船停靠在{area:392}碼頭的盡頭。",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "最後一批顱骨堆在往西不遠的廢墟中，就在返回{object:3202}的路上。",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "下一份指南從這裡開始，帶你前往{zone:1446}。",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "下一批祖瑪維顱骨堆在劈顱戰士營地北邊不遠的小廢墟中。",
	-- ["The snappers line the strand south of the post."] = "鹽齒鉗嘴鱷散布在哨站南邊的海灘上。",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "三艘船停在{area:43}外海。船員42-45級，斯蒂沃特船長45級，尼哈魯船長46級，{npc:2546}48級：41級時這是小隊的戰鬥，或留到本指南結束時。如果要去，就游過去，一次只把一名船員拉到船舷邊。船甲板上有一張卷軸{quest:624}：拿走它。",
	-- ["The {area:657}"] = "{area:657}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "遠征隊營地西邊，血頂酋長{npc:1061}和{npc:1062}一起站在祖昆達廢墟中。先清掉他們的守衛，再把他們拉過來。",
	-- ["for Stoley in {zone:1446}"] = "給{zone:1446}的斯杜雷",
	-- ["for a later stop in the {area:8}"] = "留待之後在{area:8}的一站",
	-- ["for later: the {zone:1425}, around level 48"] = "留待之後：{zone:1425}，約48級",
	-- ["the {object:2076}, beside {npc:2497}"] = "{object:2076}，在{npc:2497}旁邊",
	-- ["{area:392} pier"] = "{area:392}碼頭",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}：給{area:976}的{quest:2864}",
}
