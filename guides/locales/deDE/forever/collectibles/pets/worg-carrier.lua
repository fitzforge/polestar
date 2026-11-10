-- German (deDE): the guide forever/collectibles/pets/worg-carrier (forever/collectibles/pets/worg-carrier.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kibler at Flame Crest
	-- {npc:10260} Kibler · {area:251} Flame Crest
	["{npc:10260} at {area:251}"] = "{npc:10260} am {area:251}",
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {item:12262} Empty Worg Pup Cage · {item:12529} Smolderweb Carrier
	["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He gives you an {item:12262}. He also gives En-Ay-Es-Tee-Why (the {item:12529}): take both, they are done in the same run."] = "{npc:10260} steht in der Höhle bei {area:251}, dem Lager im Norden von {zone:1428} östlich von {area:254}. Er gibt dir einen {item:12262}. Er gibt dir auch En-Ay-Es-Tee-Why (den {item:12529}): Nimm beide, sie werden im selben Durchgang erledigt.",

	-- Step 2: Lower Blackrock Spire: Halycon's pups
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}: Halycon's pups"] = "Untere {area:1583}: Halycons Welpen",
	-- {npc:10584} Urok Doomhowl · {npc:10221} Bloodaxe Worg Pup
	["The pups are in Lower Blackrock Spire (a group of five, level 55-60), not Upper: they run with Halycon, the great worg, deep in the dungeon beyond {npc:10584}'s ogres. Use the cage on a living {npc:10221} before the pack is dead. Taking damage interrupts the cast, so let the tank hold the pups and cage one from the side. A rogue or druid can sneak in, cage a pup from a corner, then vanish."] = "Die Welpen sind in der Unteren Schwarzfelsspitze (eine Gruppe von fünf, Stufe 55-60), nicht in der Oberen: Sie laufen mit Halycon, dem großen Worg, tief im Dungeon hinter den Ogern von {npc:10584}. Benutze den Käfig an einem lebenden {npc:10221}, bevor das Rudel tot ist. Schaden unterbricht den Zauber, lass also den Tank die Welpen halten und fange einen von der Seite. Ein Schurke oder Druide kann sich hineinschleichen, einen Welpen aus einer Ecke einfangen und dann verschwinden.",
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "Untere {area:1583}",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "Zurück zu {npc:10260}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Upper {area:1583}"] = "Obere {area:1583}",
	-- ["Upper {area:1583} is a raid group of up to ten, level 58-60. Use {npc:10260}'s cage on a {npc:10221} (Halycon's den) to get the {item:12263}."] = "Die obere {area:1583} ist für eine Schlachtzugsgruppe mit bis zu zehn Spielern, Stufe 58-60. Benutze den Käfig von {npc:10260} an einem {npc:10221} (Halycons Höhle), um {item:12263} zu bekommen.",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} steht am {area:251} im Norden von {zone:1428}, nahe dem Weg zu {area:254}.",
}
