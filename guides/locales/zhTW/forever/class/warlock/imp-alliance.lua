-- Chinese (traditional) (zhTW): the guide forever/class/warlock/imp-alliance (forever/class/warlock/imp-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Alliance)"] = "小鬼（聯盟）",
	["Your first demon at level 1-4: the imp, from your start zone's warlock trainer."] = "1-4級的第一個惡魔：小鬼，在你初始地區的術士訓練師處獲得。",

	-- Step 1: Drusilla La Salle (Humans)
	-- {npc:459} Drusilla La Salle
	["{npc:459} (Humans)"] = "{npc:459}（人類）",
	-- {item:9576} Tainted Letter · {npc:197} Marshal McBride · {npc:459} Drusilla La Salle · {area:24} Northshire Abbey
	["Your first letter ({item:9576}, from {npc:197} after Kobold Camp Cleanup) points you to {npc:459}, the warlock trainer in the little graveyard beside {area:24}. She asks for a book the Defias stole."] = "你的第一封信（{item:9576}，完成“清理狗頭人營地”後由{npc:197}給予）讓你去找{npc:459}，即{area:24}旁小墓地裡的術士訓練師。她要一本被迪菲亞偷走的書。",

	-- Step 2: The Stolen Books
	-- {object:83763} Stolen Books
	["The {object:83763}"] = "{object:83763}",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["The Defias tent stands in the vineyard east of the Abbey. The book is small: it lies on the ground just right of the tent's opening, beside a blue jug. Three Defias Thugs (level 3-4) guard the tent; pull them one at a time, or step inside the tent and click the book, where they cannot reach you. The book respawns three minutes after someone takes it."] = "迪菲亞帳篷搭在修道院以東的葡萄園裡。那本書很小：就放在帳篷入口右側的地上，旁邊有個藍色罐子。三個迪菲亞暴徒（3-4級）守著帳篷；一隻一隻地拉，或者走進帳篷再點選書本，他們在那裡夠不到你。書被拿走後三分鐘重新出現。",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}, from the {object:83763}"] = "{item:6785}，來自{object:83763}",

	-- Step 3: Summon Imp
	-- {npc:459} Drusilla La Salle · {spell:688} Summon Imp
	["{npc:459} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "{npc:459}在交付時教你{spell:688}：立刻召喚它，不消耗任何東西，還會和你並肩作戰。",

	-- Step 4: Alamar Grimm (Gnomes)
	-- {npc:460} Alamar Grimm
	["{npc:460} (Gnomes)"] = "{npc:460}（地精）",
	-- {item:9577} Tainted Memorandum · {npc:658} Sten Stoutarm · {npc:460} Alamar Grimm · {area:77} Anvilmar
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Your first letter ({item:9577}, from {npc:658} after Dwarven Outfitters) points you to {npc:460}, the warlock trainer upstairs inside {area:77}. He asks for three Feather Charms."] = "你的第一封信（{item:9577}，完成“矮人裝備”後由{npc:658}給予）讓你去找{npc:460}，即{area:77}內樓上的術士訓練師。他要三個羽毛護符。",

	-- Step 5: Feather Charms
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Feather Charms"] = "羽毛護符",
	-- {area:77} Anvilmar · {area:132} Coldridge Valley
	-- plural, as words: Frostmane Novices = {npc:946} Frostmane Novice
	["The Frostmane Novices (level 3-4) sit at the back of the troll cave south of {area:77}, near Grek'nir the Cold by the icy pool: take the left tunnel past the entrance. Four kills in five drop a charm, but only two or three novices spawn, so you may wait out their three-minute respawn. They throw frostbolts from range; the Troll Whelps at the cave mouth jump anyone who passes. With the charms, your hearthstone takes you straight back: a new character's is set to {area:132}."] = "霜鬃新兵（3-4級）坐在{area:77}以南食人妖洞穴的深處，靠近冰池旁冷酷的格雷克尼爾：進洞後走左邊的通道。五次擊殺中有四次掉落護符，但只會刷出兩三個新兵，所以可能得等他們三分鐘重新出現。他們會遠端投擲寒冰箭；洞口的食人妖幼崽會撲向任何路過的人。湊齊護符後，爐石可以直接送你回去：新角色的爐石繫結在{area:132}。",

	-- Step 6: Summon Imp
	-- {npc:460} Alamar Grimm · {spell:688} Summon Imp
	["{npc:460} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "{npc:460}在交付時教你{spell:688}：立刻召喚它，不消耗任何東西，還會和你並肩作戰。",
}
