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
	["{npc:459} (Humans)"] = "",
	-- {item:9576} Tainted Letter · {npc:197} Marshal McBride · {npc:459} Drusilla La Salle · {object:89} Northshire Abbey (no name in this language: may be words)
	["Your first letter ({item:9576}, from {npc:197} after Kobold Camp Cleanup) points you to {npc:459}, the warlock trainer in the little graveyard beside {object:89}. She asks for a book the Defias stole."] = "",

	-- Step 2: The Stolen Books
	-- {object:83763} Stolen Books
	["The {object:83763}"] = "",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["The Defias tent stands in the vineyard east of the Abbey. The book is small: it lies on the ground just right of the tent's opening, beside a blue jug. Three Defias Thugs (level 3-4) guard the tent; pull them one at a time, or step inside the tent and click the book, where they cannot reach you. The book respawns three minutes after someone takes it."] = "",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}, from the {object:83763}"] = "",

	-- Step 3: Summon Imp
	-- {npc:459} Drusilla La Salle · {spell:688} Summon Imp
	["{npc:459} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "",

	-- Step 4: Alamar Grimm (Gnomes)
	-- {npc:460} Alamar Grimm
	["{npc:460} (Gnomes)"] = "",
	-- {item:9577} Tainted Memorandum · {npc:658} Sten Stoutarm · {npc:460} Alamar Grimm
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Your first letter ({item:9577}, from {npc:658} after Dwarven Outfitters) points you to {npc:460}, the warlock trainer upstairs inside Anvilmar. He asks for three Feather Charms."] = "",

	-- Step 5: Feather Charms
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Feather Charms"] = "",
	-- plural, as words: Frostmane Novices = {npc:946} Frostmane Novice
	["The Frostmane Novices (level 3-4) sit at the back of the troll cave south of Anvilmar, near Grek'nir the Cold by the icy pool: take the left tunnel past the entrance. Four kills in five drop a charm, but only two or three novices spawn, so you may wait out their three-minute respawn. They throw frostbolts from range; the Troll Whelps at the cave mouth jump anyone who passes. With the charms, your hearthstone takes you straight back: a new character's is set to Coldridge Valley."] = "",

	-- Step 6: Summon Imp
	-- {npc:460} Alamar Grimm · {spell:688} Summon Imp
	["{npc:460} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "",
}
