-- Spanish (Spain) (esES): the guide forever/class/mage/ju-ju-heaps (forever/class/mage/ju-ju-heaps.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:9514} Arcane Staff
	["Ley or {item:9514} or Orb (Horde)"] = "",
	-- {area:368} Echo Isles
	["A staff or an off-hand orb at 10: Orcs and Trolls on the {area:368}, the Undead at a Tirisfal farm."] = "",

	-- Step 1: Un'thuwa
	["Un'thuwa"] = "Un'thuwa",
	-- {area:367} Sen'jin Village · {zone:1411} Durotar · {area:362} Razor Hill · {zone:1454} Orgrimmar · {quest:1883} Speak with Un'thuwa · {npc:7311} Uthel'nay · {object:172961} Valley of Spirits · {quest:1884} Ju-Ju Heaps · {zone:1458} Undercity · {area:165} Balnir Farmstead
	["Un'thuwa, the troll mage trainer, stands in {area:367} on the {zone:1411} coast south of {area:362}. Orcs coming from {zone:1454} can take {quest:1883} from {npc:7311} in the {object:172961} first; it is only a pointer and Un'thuwa gives {quest:1884} without it. Taking it shuts out the {zone:1458}'s {area:165}."] = "",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill · {area:2119} Gallows' End Tavern · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {quest:1884} Ju-Ju Heaps · {quest:1883} Speak with Un'thuwa · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:368} Echo Isles
	["At 10 {npc:2128}, the {area:159} mage trainer upstairs in the {area:2119}, sends you to {npc:4568} in the {zone:1458}. Taking it shuts out {quest:1884}; if {quest:1883} (from {zone:1454} or {zone:1456}) is in your log, abandon it first or {npc:2128} cannot give you this one. (A Troll who took this one in {area:159} follows the Balnir steps; an Undead who took {quest:1884} in Sen'jin, the {area:368} steps.)"] = "",

	-- Step 3: The Ju-Ju Heaps
	-- {quest:1884} Ju-Ju Heaps
	["The {quest:1884}"] = "{quest:1884}",
	-- plural, as words: Voodoo Trolls = {npc:3206} Voodoo Troll
	["Wade across the shallows south-east of Sen'jin to the main Echo Isle, where Zalazane (level 10) holds his camp with Hexed and Voodoo Trolls (level 8). The heaps you can click are the skull piles inside the raised huts around his camp, one hut holding two, more in the huts to the north; the skulls lying on the ground outside cannot be clicked. Destroy four. There are seven and each comes back 30 seconds after it is destroyed."] = "",
	-- {object:102986} Ju-Ju Heap
	["{object:102986}, four of them"] = "",

	-- Step 4: Back to Un'thuwa
	["Back to Un'thuwa"] = "Vuelve con Un'thuwa",
	["The orb is an off-hand for a one-hand weapon; the staff is a two-hander."] = "",
	-- {item:7508} Ley Orb · {item:9513} Ley Staff
	["Un'thuwa: {item:7508} or {item:9513}"] = "",

	-- Step 5: Anastasia Hartwell
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {object:36082} Magic Quarter
	["Walk south from {area:159} to the {area:153} and take the lift down into the {zone:1458}. Anastasia stands in the {object:36082}, the north-east ring of the city."] = "",

	-- Step 6: The Balnir Farmstead
	-- {quest:1882} The Balnir Farmstead · {area:159} Brill · {area:152} Bulwark · {skill:182} Herbalism
	["{quest:1882} lies south-east of {area:159}, south of the road east to the {area:152}. The snapdragons grow in the farm's garden and look more like bushes than flowers; any of them will do and you need no {skill:182}. They come back within seconds."] = "",

	-- Step 7: Back to Anastasia
	["Back to Anastasia"] = "",
	-- {npc:4568} Anastasia Hartwell · {item:7507} Arcane Orb · {item:9514} Arcane Staff
	["{npc:4568}: {item:7507} or {item:9514}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A staff or an orb at 10 for Horde mages, worth a short trip back to the {area:368}."] = "Un bastón o un orbe a nivel 10 para magos de la Horda; merece la pena volver un momento a las {area:368}.",
	-- ["Un'thuwa stands in {area:367}, on the {zone:1411} coast south of {area:362}."] = "Un'thuwa está en {area:367}, en la costa de {zone:1411}, al sur de {area:362}.",
	-- ["Wade across to the {area:368}, south-east of Sen'jin. Zalazane placed the heaps among his huts on the main isle: click a heap to destroy it."] = "Cruza vadeando hasta las {area:368}, al sureste de Sen'jin. Zalazane puso los montones entre sus chozas de la isla principal: haz clic en un montón para destruirlo.",
}
