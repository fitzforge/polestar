-- French (frFR): the guide forever/class/warlock/imp-alliance (forever/class/warlock/imp-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Imp (Alliance)"] = "Diablotin (Alliance)",
	["Your first demon at level 1-4: the imp, from your start zone's warlock trainer."] = "Votre premier démon, au niveau 1-4 : le diablotin, auprès du maître des démonistes de votre zone de départ.",

	-- Step 1: Drusilla La Salle (Humans)
	-- {npc:459} Drusilla La Salle
	["{npc:459} (Humans)"] = "{npc:459} (Humains)",
	-- {item:9576} Tainted Letter · {npc:197} Marshal McBride · {npc:459} Drusilla La Salle · {area:24} Northshire Abbey
	["Your first letter ({item:9576}, from {npc:197} after Kobold Camp Cleanup) points you to {npc:459}, the warlock trainer in the little graveyard beside {area:24}. She asks for a book the Defias stole."] = "Votre première lettre ({item:9576}, de {npc:197} après Nettoyer le camp des kobolds) vous mène à {npc:459}, la maîtresse des démonistes dans le petit cimetière à côté de l'{area:24}. Elle demande un livre volé par les Défias.",

	-- Step 2: The Stolen Books
	-- {object:83763} Stolen Books
	["The {object:83763}"] = "Les {object:83763}",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["The Defias tent stands in the vineyard east of the Abbey. The book is small: it lies on the ground just right of the tent's opening, beside a blue jug. Three Defias Thugs (level 3-4) guard the tent; pull them one at a time, or step inside the tent and click the book, where they cannot reach you. The book respawns three minutes after someone takes it."] = "La tente des Défias se dresse dans le vignoble à l'est de l'abbaye. Le livre est petit : il est posé au sol juste à droite de l'entrée de la tente, à côté d'une cruche bleue. Trois Nervis défias (niveau 3-4) gardent la tente ; attirez-les un par un, ou entrez dans la tente et cliquez sur le livre, là où ils ne peuvent pas vous atteindre. Le livre réapparaît trois minutes après avoir été pris.",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}, from the {object:83763}"] = "{item:6785}, dans les {object:83763}",

	-- Step 3: Summon Imp
	-- {npc:459} Drusilla La Salle · {spell:688} Summon Imp
	["{npc:459} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "{npc:459} vous apprend {spell:688} quand vous rendez la quête : invoquez-le tout de suite, il ne coûte rien et combat à vos côtés.",

	-- Step 4: Alamar Grimm (Gnomes)
	-- {npc:460} Alamar Grimm
	["{npc:460} (Gnomes)"] = "{npc:460} (Gnomes)",
	-- {item:9577} Tainted Memorandum · {npc:658} Sten Stoutarm · {npc:460} Alamar Grimm · {area:77} Anvilmar
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Your first letter ({item:9577}, from {npc:658} after Dwarven Outfitters) points you to {npc:460}, the warlock trainer upstairs inside {area:77}. He asks for three Feather Charms."] = "Votre première lettre ({item:9577}, de {npc:658} après Tailleur chez les nains) vous mène à {npc:460}, le maître des démonistes à l'étage d'{area:77}. Il demande trois Charmes de plume.",

	-- Step 5: Feather Charms
	-- plural, as words: Feather Charms = {item:6753} Feather Charm
	["Feather Charms"] = "Charmes de plume",
	-- {area:77} Anvilmar · {area:132} Coldridge Valley
	-- plural, as words: Frostmane Novices = {npc:946} Frostmane Novice
	["The Frostmane Novices (level 3-4) sit at the back of the troll cave south of {area:77}, near Grek'nir the Cold by the icy pool: take the left tunnel past the entrance. Four kills in five drop a charm, but only two or three novices spawn, so you may wait out their three-minute respawn. They throw frostbolts from range; the Troll Whelps at the cave mouth jump anyone who passes. With the charms, your hearthstone takes you straight back: a new character's is set to {area:132}."] = "Les Novices Frostmane (niveau 3-4) se tiennent au fond de la grotte des trolls au sud d'{area:77}, près de Grik'nir le Froid au bord du bassin gelé : prenez le tunnel de gauche après l'entrée. Quatre fois sur cinq, ils lâchent un charme, mais seuls deux ou trois novices apparaissent, vous devrez donc peut-être attendre leur réapparition de trois minutes. Ils lancent des éclairs de givre à distance ; les Jeunes trolls à l'entrée de la grotte sautent sur quiconque passe. Une fois les charmes en main, votre pierre de foyer vous ramène tout droit : celle d'un nouveau personnage est liée à la {area:132}.",

	-- Step 6: Summon Imp
	-- {npc:460} Alamar Grimm · {spell:688} Summon Imp
	["{npc:460} teaches you {spell:688} at the hand-in: summon it right away, it costs nothing and fights beside you."] = "{npc:460} vous apprend {spell:688} quand vous rendez la quête : invoquez-le tout de suite, il ne coûte rien et combat à vos côtés.",
}
