-- German (deDE): the guide forever/collectibles/pets/smolderweb-carrier (forever/collectibles/pets/smolderweb-carrier.guide).
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
	-- {npc:10260} Kibler · {area:251} Flame Crest · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {item:12264} Worg Carrier
	["{npc:10260} stands inside the cave at {area:251}, the camp in northern {zone:1428} east of {area:254}. He also gives {npc:10260}'s Exotic Pets (the {item:12264}): take both, they are done in the same run."] = "{npc:10260} steht in der Höhle bei {area:251}, dem Lager im Norden von {zone:1428} östlich von {area:254}. Er gibt dir auch {npc:10260}'s Exotic Pets (den {item:12264}): Nimm beide, sie werden im selben Durchgang erledigt.",

	-- Step 2: Lower Blackrock Spire
	-- {area:1583} Blackrock Spire
	["Lower {area:1583}"] = "Untere {area:1583}",
	-- {area:1583} Blackrock Spire · {area:254} Blackrock Mountain · {npc:10596} Mother Smolderweb
	-- plural, as words: Spire Spider Eggs = {item:12530} Spire Spider Egg
	["Lower {area:1583} is a group of five, level 55-60, inside {area:254}. The Spire Spider Eggs lie around {npc:10596}'s nest in the Skitterweb Tunnels, the spider halls: click them until you have 15 (each gives one to three). Hard-hitting spiderlings can hatch as you loot. By player reports the eggs cannot be looted in a raid group, so keep the party at five or fewer."] = "Die Untere {area:1583} ist eine Gruppe von fünf, Stufe 55-60, im {area:254}. Die Spire Spider Eggs liegen um das Nest von {npc:10596} in den Skitterweb Tunnels, den Spinnenhallen: Klicke sie an, bis du 15 hast (jedes gibt ein bis drei). Hart zuschlagende Spinnenbrut kann beim Plündern schlüpfen. Laut Spielerberichten können die Eier nicht in einer Schlachtzugsgruppe geplündert werden, halte die Gruppe also bei fünf oder weniger.",

	-- Step 3: Back to Kibler
	-- {npc:10260} Kibler
	["Back to {npc:10260}"] = "Zurück zu {npc:10260}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Lower {area:1583} is a group of five, level 55-60. Collect 15 Spire Spider Eggs from the nests near {npc:10596}."] = "Die Untere {area:1583} ist für eine Gruppe von fünf, Stufe 55-60. Sammle 15 Spitzenspinneneier aus den Nestern nahe {npc:10596}.",
	-- ["{npc:10260} stands at {area:251} in northern {zone:1428}, near the {area:254} path."] = "{npc:10260} steht am {area:251} im Norden der {zone:1428}, nahe dem Pfad zum {area:254}.",
}
