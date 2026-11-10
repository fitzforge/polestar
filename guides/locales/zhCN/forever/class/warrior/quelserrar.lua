-- Chinese (simplified) (zhCN): the guide forever/class/warrior/quelserrar (forever/class/warrior/quelserrar.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2577} Dire Maul · {npc:10184} Onyxia
	["A tank sword at 60: a {area:2577} book, then {npc:10184}'s breath tempers the blade (the sword is not in Forever's items yet)."] = "60级坦克剑：先在{area:2577}获得一本书，再用{npc:10184}的龙息淬炼剑刃（无限的物品中尚未加入此剑）。",
	["Shen'dralar reputation"] = "辛德拉声望",

	-- Step 1: Nostro's Compendium of Dragon Slaying
	-- {area:2577} Dire Maul · {npc:11496} Immol'thar · {npc:11501} King Gordok · {zone:1444} Feralas
	["The book is a rare random drop from the bosses of all three {area:2577} wings (Alzzin, Hydrospawn and the rest of the East, Tendris, Illyanna, Kalendris, {npc:11496} and the West, {npc:11501} and the North's guards) and very rarely from the tribute chest; it can be traded, so the auction house may have one. {area:2577} is a five-player dungeon in the ruins of central {zone:1444}: needs a group of five. Right-click the book to start the quest; it stays in your bags."] = "这本书由 {area:2577} 三个区域的首领随机稀有掉落（东区的奥兹恩、海多斯博恩及其他首领，西区的特迪斯、伊琳娜、卡雷迪斯、{npc:11496} 等，以及北区的 {npc:11501} 和卫兵），贡品箱也有极低概率开出；它可以交易，因此拍卖行可能有售。{area:2577} 是位于 {zone:1444} 中部废墟中的五人地下城：需要五人小队。右键点击书本开始任务；书会留在背包里。",
	-- {item:18401} Nostro's Compendium of Dragon Slaying
	["from {item:18401}"] = "来自 {item:18401}",

	-- Step 2: Lorekeeper Lydros
	-- {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key · {item:18513} A Dull and Flat Elven Blade · {item:18489} Unfired Ancient Blade
	["{npc:14368} stands in the Athenaeum, the library at the far end of Dire Maul West, past the Court of the Highborne and the Prison of Immol'thar. The West door needs the {item:18249}, which Pusillin drops in Dire Maul East (he runs; chase him), or a rogue to pick it. Clearing to the library needs your group of five. He takes the book, hands you {item:18513} to give straight back, then the {item:18489}. Keep that blade: lose it, and you must abandon the quest and take it again."] = "{npc:14368} 在厄运之槌西区最深处的图书馆“辛德拉圣殿”，需要经过上层精灵庭院和伊莫塔尔的牢笼。西区大门需要 {item:18249}，钥匙由厄运之槌东区的普希林掉落（他会逃跑，要追上），或者让潜行者开锁。清到图书馆需要五人小队。他会收下书，给你 {item:18513}，当场交回后再给你 {item:18489}。保留这把剑：丢了就只能放弃任务，重新接取。",
	-- {npc:14368} Lorekeeper Lydros
	["{npc:14368}, in the Athenaeum"] = "{npc:14368}，在图书馆内",
	-- {npc:14368} Lorekeeper Lydros
	["{npc:14368}: hand back the Dull and Flat Elven Blade"] = "{npc:14368}：交还黯淡的精灵剑",

	-- Step 3: Onyxia's breath
	-- {npc:10184} Onyxia
	["{npc:10184}'s breath"] = "{npc:10184} 的吐息",
	-- {npc:10184} Onyxia · {area:2159} Onyxia's Lair · {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {item:18489} Unfired Ancient Blade · {object:179562} Ancient Heated Blade · {item:18488} Heated Ancient Blade
	["{npc:10184} is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}; she returns once a week. Tell the raid first. Late in the fight (around 10-15% health, when she has landed again) use the {item:18489} to plant it in the path of her fire breath, usually by the main tank's feet. When her breath has heated it, click the {object:179562} to take the {item:18488}: from then you have 20 minutes. Her breath can kill you while you plant or pick up the blade; if you die and nobody brings you back before she dies, wait for next week. Planted in the wrong place? Abandon the quest, take it again from Lydros for a new blade."] = "{npc:10184} 是 {area:2159} 的 40 人团队首领，该洞穴位于 {zone:1445} 南部的 {area:511}；她每周刷新一次。先告知团队。战斗后期（生命值约剩 10-15%，她再次落地后），使用 {item:18489} 将剑插在她的火焰吐息路径上，通常是主坦克脚边。吐息加热剑后，点击 {object:179562}，取得 {item:18488}：从此时起你有 20 分钟。插剑或拾取时，她的吐息可能会杀死你；若你死亡，且她死前无人复活你，就只能等下周。插错位置了？放弃任务，再从莱德罗斯处重新接受，以取得一把新剑。",
	-- {item:18489} Unfired Ancient Blade
	["{item:18489}: plant it in her breath"] = "{item:18489}：把它插在她的吐息中",
	["click the heated blade on the ground"] = "点击地面上加热过的剑刃",

	-- Step 4: Onyxia's corpse
	-- {npc:10184} Onyxia
	["{npc:10184}'s corpse"] = "{npc:10184}的尸体",
	-- {npc:10184} Onyxia · {item:18488} Heated Ancient Blade · {item:18492} Treated Ancient Blade
	["Kill {npc:10184}, then target her corpse and use the {item:18488} on it before the 20 minutes run out. It becomes the {item:18492}, with no time limit."] = "击杀 {npc:10184}，然后在 20 分钟耗尽前，选中她的尸体并对其使用 {item:18488}。它会变成 {item:18492}，不再有时间限制。",
	-- {item:18488} Heated Ancient Blade
	["{item:18488}, on her corpse"] = "{item:18488}，在她的尸体上",

	-- Step 5: The Forging of Quel'Serrar
	-- {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key
	["Back to {npc:14368} in the Athenaeum of Dire Maul West: through the West door with the {item:18249} again, and a group to reach the library."] = "返回厄运之槌西区图书馆的 {npc:14368} 处：再次用 {item:18249} 从西区大门进入，并组队前往图书馆。",
}
