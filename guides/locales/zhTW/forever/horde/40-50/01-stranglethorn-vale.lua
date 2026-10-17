-- Chinese (traditional) (zhTW): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
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
	-- {area:2408} Shadowprey Village · {area:392} Ratchet
	["From {area:2408} fly to {area:392}."] = "從{area:2408}飛往{area:392}。",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "搭船前往{area:35}",
	-- {area:35} Booty Bay · {area:392} Ratchet
	["The boat to {area:35} docks at the end of {area:392}'s pier."] = "前往{area:35}的船停靠在{area:392}碼頭的盡頭。",
	-- {area:392} Ratchet
	["{area:392} pier"] = "{area:392}碼頭",

	-- Step 3: Booty Bay
	-- {area:35} Booty Bay
	["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "船在{area:35}的港口靠岸。任務給予者站在港口周圍的木棧道上和旅店裡。",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}"] = "給{zone:1446}的斯杜雷",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}：給{area:976}的{quest:2864}",

	-- Step 4: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "從隧道出城；字條在{area:35}北邊不遠的海盜海灣裡。",

	-- Step 6: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "在藏寶海灣南邊，血帆流氓在{area:43}紮營；海圖和命令在他們的帳篷裡。任何血帆海盜都可能帶著鼻煙和{npc:2493}的眼睛，所以持續擊殺直到兩樣都拿到。",

	-- Step 8: The Bloodsail ships
	["The Bloodsail ships"] = "血帆海盜船",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon · {quest:624} Cortello's Riddle
	["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "三艘船停在{area:43}外海。船員42-45級，斯蒂沃特船長45級，尼哈魯船長46級，{npc:2546}48級：41級時這是小隊的戰鬥，或留到本指南結束時。如果要去，就游過去，一次只把一名船員拉到船舷邊。船甲板上有一張卷軸{quest:624}：拿走它。",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "留待之後在{zone:1435}的一站",

	-- Step 10: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "沿道路從{area:35}向北出城；巫醫安巴格瓦坐在{area:1737}道路東邊的山丘上。",

	-- Step 11: Mistvale gorillas
	["Mistvale gorillas"] = "迷霧谷猩猩",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "猩猩在巫醫安巴格瓦周圍的山谷遊蕩。老邁的迷霧谷猩猩會掉落內臟；任何一隻都可能掉落尖牙。",

	-- Step 12: Mokk the Savage
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "把尖牙交給巫醫安巴格瓦並待在他身邊：他會召來三波猩猩，然後是{npc:1514}。一次對付一隻。",

	-- Step 13: Zanzil's camps
	["Zanzil's camps"] = "贊吉爾的營地",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "在迷霧谷東北方，流亡者贊吉爾的追隨者在叢林中紮營；每一個都可能帶著混合物。",

	-- Step 14: Venture Co. mine
	["Venture Co. mine"] = "風險投資公司礦坑",
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "再往北，風險投資公司的哥布林在道路東邊的礦坑挖掘；礦工、工頭、勘探員和修理工都會掉落水晶。",

	-- Step 15: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Ride north-west to {object:3202}."] = "向西北騎到{object:3202}。",
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "留待之後：{zone:1425}，約48級",

	-- Step 16: Nesingwary's Expedition
	["Ride north up the road; the hunters camp on the hill above the river."] = "沿道路向北騎；獵人在河流上方的山丘上紮營。",

	-- Step 17: Zul'Kunda
	["Zul'Kunda"] = "祖昆達廢墟",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "遠征隊營地西邊，血頂酋長{npc:1061}和{npc:1062}一起站在祖昆達廢墟中。先清掉他們的守衛，再把他們拉過來。",

	-- Step 18: Hearth to Grom'gol
	-- {object:3202} Grom'gol
	["Hearth to {object:3202}"] = "用爐石回到{object:3202}",
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "{object:2076}，在{npc:2497}旁邊",

	-- Step 19: Jungle stalkers
	["Jungle stalkers"] = "叢林捕獵者",
	-- {object:3202} Grom'gol
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "叢林捕獵者迅猛龍在{object:3202}南邊的叢林狩獵，一直延伸到西海岸。",

	-- Step 20: Naga shore and the Holy Spring
	-- {object:759} Holy Spring
	["Naga shore and the {object:759}"] = "納迦海岸與{object:759}",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "沿海岸向南。納迦探險者在岸邊涉水，身上帶著蘆葦束；{object:759}就在他們東邊的丘陵中冒泡。",

	-- Step 21: Booty Bay
	-- {area:35} Booty Bay
	["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "向南騎到{area:35}。「病鬼」菲力浦在碼頭上等著。",

	-- Step 22: Pirate ghosts
	["Pirate ghosts"] = "海盜鬼魂",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "三個海盜鬼魂在{area:35}北邊、贊吉爾營地附近的叢林出沒：{npc:2535}和{npc:2536}站在一起，{npc:2537}在更東邊。",

	-- Step 23: Zul'Mamwe
	["Zul'Mamwe"] = "祖瑪維廢墟",
	-- {npc:1059} Ana'thek the Cruel
	["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "向北騎到風險投資公司礦坑東邊的劈顱食人妖廢墟；一次只拉一隻劈顱獵頭者或劈顱狂戰士。{npc:1059}守在西南方的廢墟，一堆祖瑪維顱骨堆在廢墟北側。每個劈顱食人妖都可能掉落獠牙或項鍊：項鍊最花時間，所以在廢墟北邊的劈顱戰士營地持續擊殺，直到收集完畢。",
	["Skullsplitter warriors"] = "劈顱戰士",

	-- Step 24: Balia'mah Ruins
	["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "下一批祖瑪維顱骨堆在劈顱戰士營地北邊不遠的小廢墟中。",

	-- Step 25: Ziata'jai Ruins
	-- {object:3202} Grom'gol
	["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "最後一批顱骨堆在往西不遠的廢墟中，就在返回{object:3202}的路上。",

	-- Step 26: Grom'gol Base Camp
	-- {object:3202} Grom'gol
	["Ride west to {object:3202}."] = "向西騎到{object:3202}。",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "{object:2076}",

	-- Step 27: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "用爐石回到{area:35}",

	-- Step 28: Fly to Grom'gol
	-- {object:3202} Grom'gol
	["Fly to {object:3202}"] = "飛往{object:3202}",

	-- Step 29: Nesingwary's Expedition
	["Ride north up the road to the hunters' camp."] = "沿道路向北騎到獵人營地。",

	-- Step 30: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "進入{zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "繼續向北騎進{zone:1431}，再沿道路向東穿過{zone:1430}進入沼澤。{npc:1776}在{area:657}等著，那是靠近{zone:1430}入口的德萊尼營地。",

	-- Step 31: Stonard
	-- {area:75} Stonard
	["Ride east to {area:75}, in the reeds south of the road."] = "向東騎到道路南邊蘆葦叢中的{area:75}。",

	-- Step 32: Draenethyst crystals
	["Draenethyst crystals"] = "德萊尼水晶",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "向東北騎到{area:76}。水晶沿著通往{npc:5391}籠子的路分布。",

	-- Step 33: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391}被關在沼澤東北部的{area:76}。釋放他並跟著他出去，擊退追趕他的沼澤生物。",

	-- Step 34: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "木棒諾博魯在{area:76}西南方的空地遊蕩；他的木棒會開啟一個任務。",

	-- Step 35: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}."] = "他的保險箱在{area:75}北邊他的舊營地。",

	-- Step 36: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "鹽齒鱷魚",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "鹽齒鱷魚在{npc:5391}營地周圍和往南到{area:75}的水池中打滾；約四隻有一隻掉落側腹肉。",

	-- Step 37: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "沿道路向西騎到{area:657}的德萊尼營地，靠近{zone:1430}的入口。",

	-- Step 38: Misty Reed Post
	-- {area:75} Stonard
	["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "向東騎回去經過{area:75}，沿道路向東南前往海岸上的小型部落哨站。",

	-- Step 39: Sawtooth snappers
	["Sawtooth snappers"] = "鹽齒鉗嘴鱷",
	["The snappers line the strand south of the post."] = "鹽齒鉗嘴鱷散布在哨站南邊的海灘上。",

	-- Step 40: Misty Reed Post
	-- {zone:1446} Tanaris
	["The next guide starts here and takes you to {zone:1446}."] = "下一份指南從這裡開始，帶你前往{zone:1446}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {area:657}"] = "{area:657}",
}
