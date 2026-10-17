-- German (deDE): the guide forever/collectibles/mounts/horde/skeletal-horse (forever/collectibles/mounts/horde/skeletal-horse.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn to ride
	["Learn to ride"] = "Lerne reiten",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 40 {npc:4773} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Horde race ride these."] = "Der Stall von {npc:4773} und {npc:4731} ist in {area:159}, {zone:1420}. Ab Stufe 40 lehrt {npc:4773} {skill:762} (100g laut Blizzards Designern), und beim Erlernen bekommst du ein Reittier. Im Forever-Client dürfen alle Hordevölker diese reiten.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, Reitlehrer",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Wähle eine Farbe",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731} verkauft die anderen Farben (je 20g im Forever-Client). Kaufe, was du willst, oder nichts, wenn dir dein erhaltenes Reittier gefällt.",
	-- {item:13331} Red Skeletal Horse
	["{item:13331}, 20g"] = "{item:13331}, 20g",
	-- {item:13332} Blue Skeletal Horse
	["{item:13332}, 20g"] = "{item:13332}, 20g",
	-- {item:13333} Brown Skeletal Horse
	["{item:13333}, 20g"] = "{item:13333}, 20g",
	-- {npc:267354} Black Skeletal Horse
	["{npc:267354} is a new Forever horse (level 40) whose source is not known yet."] = "{npc:267354} ist ein neues Forever-Pferd (Stufe 40), dessen Quelle noch unbekannt ist.",
}
