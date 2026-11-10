-- Chinese (simplified) (zhCN): the guide forever/class/warlock/imp-alliance (forever/class/warlock/imp-alliance.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Alliance)"] = "小鬼（联盟）",
	["Your first demon at level 1-4: the imp, from your start zone's warlock trainer."] = "1-4级的第一个恶魔：小鬼，在你初始地区的术士训练师处获得。",

	-- Step 1: Drusilla La Salle (Humans)
	-- {npc:459} Drusilla La Salle
	["{npc:459} (Humans)"] = "{npc:459}（人类）",
	-- {item:9576} Tainted Letter · {npc:197} Marshal McBride · {npc:459} Drusilla La Salle · {area:24} Northshire Abbey
	["Your first letter ({item:9576}, from {npc:197} after Kobold Camp Cleanup) points you to {npc:459}, the warlock trainer in the little graveyard beside {area:24}. She asks for a book the Defias stole."] = "你的第一封信（完成“剿灭狗头人”后由{npc:197}给予的{item:9576}）会指引你去找{npc:459}，她是{area:24}旁小墓地里的术士训练师。她要你找回一本被迪菲亚偷走的书。",

	-- Step 2: The Stolen Books
	-- {object:83763} Stolen Books
	["The {object:83763}"] = "{object:83763}",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["The Defias tent stands in the vineyard east of the Abbey. The book is small: it lies on the ground just right of the tent's opening, beside a blue jug. Three Defias Thugs (level 3-4) guard the tent; pull them one at a time, or step inside the tent and click the book, where they cannot reach you. The book respawns three minutes after someone takes it."] = "迪菲亚帐篷位于修道院东侧的葡萄园。书很小：就在帐篷入口右侧的地面上，靠近一个蓝色水罐。三名迪菲亚暴徒（3-4 级）守着帐篷；逐个拉出来打，或者走进帐篷，站在他们够不到的位置点击书。书被拾取三分钟后刷新。",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}, from the {object:83763}"] = "{item:6785}，来自{object:83763}",

	-- Step 3: Summon Imp
	-- {npc:459} Drusilla La Salle · {spell:688} Summon Imp
	["{npc:459} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "交还任务时，{npc:459} 会教你 {spell:688}：马上召唤，不花钱，还能帮你战斗。",

	-- Step 4: Alamar Grimm (Gnomes)
	-- {npc:460} Alamar Grimm
	["{npc:460} (Gnomes)"] = "{npc:460}（侏儒）",
	-- {item:9577} Tainted Memorandum · {npc:658} Sten Stoutarm · {npc:460} Alamar Grimm · {area:77} Anvilmar
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Your first letter ({item:9577}, from {npc:658} after Dwarven Outfitters) points you to {npc:460}, the warlock trainer upstairs inside {area:77}. He asks for three Feather Charms."] = "第一封信（完成“矮人的交易”后，由 {npc:658} 给予的 {item:9577}）会让你去找 {area:77} 建筑楼上的术士训练师 {npc:460}。他需要三个羽毛咒符。",

	-- Step 5: Feather Charms
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Feather Charms"] = "羽毛咒符",
	-- {area:77} Anvilmar · {area:132} Coldridge Valley
	-- plural, as words: Frostmane Novices = {npc:946} Frostmane Novice
	["The Frostmane Novices (level 3-4) sit at the back of the troll cave south of {area:77}, near Grek'nir the Cold by the icy pool: take the left tunnel past the entrance. Four kills in five drop a charm, but only two or three novices spawn, so you may wait out their three-minute respawn. They throw frostbolts from range; the Troll Whelps at the cave mouth jump anyone who passes. With the charms, your hearthstone takes you straight back: a new character's is set to {area:132}."] = "霜鬃巨魔新兵（3-4级）在{area:77}南方巨魔洞穴的深处，靠近冰池旁的冷酷的格瑞克尼尔：进入洞口后走左侧通道。掉率约为五只出四个咒符，但只有两三名新兵会刷新，因此可能需要等待三分钟的刷新时间。它们会在远处施放寒冰箭；洞口的巨魔幼崽会袭击路过的人。拿到咒符后可以直接用炉石返回：新角色的炉石绑定在{area:132}。",

	-- Step 6: Summon Imp
	-- {npc:460} Alamar Grimm · {spell:688} Summon Imp
	["{npc:460} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "交还任务时，{npc:460} 会教你 {spell:688}：马上召唤，不花钱，还能帮你战斗。",
}
