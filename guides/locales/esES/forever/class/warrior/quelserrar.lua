-- Spanish (Spain) (esES): the guide forever/class/warrior/quelserrar (forever/class/warrior/quelserrar.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2577} Dire Maul · {npc:10184} Onyxia
	["A tank sword at 60: a {area:2577} book, then {npc:10184}'s breath tempers the blade (the sword is not in Forever's items yet)."] = "",
	["Shen'dralar reputation"] = "Reputación con los Shen'dralar",

	-- Step 1: Nostro's Compendium of Dragon Slaying
	-- {area:2577} Dire Maul · {npc:11496} Immol'thar · {npc:11501} King Gordok · {zone:1444} Feralas
	["The book is a rare random drop from the bosses of all three {area:2577} wings (Alzzin, Hydrospawn and the rest of the East, Tendris, Illyanna, Kalendris, {npc:11496} and the West, {npc:11501} and the North's guards) and very rarely from the tribute chest; it can be traded, so the auction house may have one. {area:2577} is a five-player dungeon in the ruins of central {zone:1444}: needs a group of five. Right-click the book to start the quest; it stays in your bags."] = "",
	-- {item:18401} Nostro's Compendium of Dragon Slaying
	["from {item:18401}"] = "",

	-- Step 2: Lorekeeper Lydros
	-- {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key · {item:18513} A Dull and Flat Elven Blade · {item:18489} Unfired Ancient Blade
	["{npc:14368} stands in the Athenaeum, the library at the far end of Dire Maul West, past the Court of the Highborne and the Prison of Immol'thar. The West door needs the {item:18249}, which Pusillin drops in Dire Maul East (he runs; chase him), or a rogue to pick it. Clearing to the library needs your group of five. He takes the book, hands you {item:18513} to give straight back, then the {item:18489}. Keep that blade: lose it, and you must abandon the quest and take it again."] = "",
	-- {npc:14368} Lorekeeper Lydros
	["{npc:14368}, in the Athenaeum"] = "",
	-- {npc:14368} Lorekeeper Lydros
	["{npc:14368}: hand back the Dull and Flat Elven Blade"] = "",

	-- Step 3: Onyxia's breath
	-- {npc:10184} Onyxia
	["{npc:10184}'s breath"] = "",
	-- {npc:10184} Onyxia · {area:2159} Onyxia's Lair · {area:511} Wyrmbog · {zone:1445} Dustwallow Marsh · {item:18489} Unfired Ancient Blade · {object:179562} Ancient Heated Blade · {item:18488} Heated Ancient Blade
	["{npc:10184} is the 40-player raid boss of {area:2159}, a cave in the {area:511} of southern {zone:1445}; she returns once a week. Tell the raid first. Late in the fight (around 10-15% health, when she has landed again) use the {item:18489} to plant it in the path of her fire breath, usually by the main tank's feet. When her breath has heated it, click the {object:179562} to take the {item:18488}: from then you have 20 minutes. Her breath can kill you while you plant or pick up the blade; if you die and nobody brings you back before she dies, wait for next week. Planted in the wrong place? Abandon the quest, take it again from Lydros for a new blade."] = "",
	-- {item:18489} Unfired Ancient Blade
	["{item:18489}: plant it in her breath"] = "",
	["click the heated blade on the ground"] = "",

	-- Step 4: Onyxia's corpse
	-- {npc:10184} Onyxia
	["{npc:10184}'s corpse"] = "",
	-- {npc:10184} Onyxia · {item:18488} Heated Ancient Blade · {item:18492} Treated Ancient Blade
	["Kill {npc:10184}, then target her corpse and use the {item:18488} on it before the 20 minutes run out. It becomes the {item:18492}, with no time limit."] = "",
	-- {item:18488} Heated Ancient Blade
	["{item:18488}, on her corpse"] = "",

	-- Step 5: The Forging of Quel'Serrar
	-- {npc:14368} Lorekeeper Lydros · {item:18249} Crescent Key
	["Back to {npc:14368} in the Athenaeum of Dire Maul West: through the West door with the {item:18249} again, and a group to reach the library."] = "",
}
