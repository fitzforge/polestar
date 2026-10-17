-- German (deDE): the guide forever/collectibles/mounts/neutral/warlock-felsteed (forever/collectibles/mounts/neutral/warlock-felsteed.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Felsteed"] = "Hexenmeister-Teufelsross",
	["Your own mount at 40, summoned anywhere, with no gold spent on a riding horse."] = "Dein eigenes Reittier mit 40, überall beschwörbar, ohne Gold für ein Reitpferd auszugeben.",

	-- Step 1: Summon Felsteed (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "Mit 40 schickt dich {npc:461} in {object:2164} in {object:2101} zu {npc:6251} in {area:392}.",

	-- Step 2: Summon Felsteed (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:5172} in {zone:1455} sends you to {npc:6251} in {area:392}."] = "Mit 40 schickt dich {npc:5172} in {zone:1455} zu {npc:6251} in {area:392}.",

	-- Step 3: Summon Felsteed (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 40 {npc:3326} in the {object:172960} sends you to {npc:6251} in {area:392}."] = "Mit 40 schickt dich {npc:3326} in {object:172960} zu {npc:6251} in {area:392}.",

	-- Step 4: Summon Felsteed (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 40 {npc:4563} in the {object:36082} sends you to {npc:6251} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "Mit 40 schickt dich {npc:4563} in {object:36082} zu {npc:6251} in {area:392}. Der Zeppelin aus {zone:1420} fliegt nach {zone:1411}.",

	-- Step 5: Strahad Farsan in Ratchet
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:6251} in {area:392}"] = "{npc:6251} in {area:392}",
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:380} Crossroads · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {quest:3631} Summon Felsteed
	["{area:392} is on the {zone:1413} coast east of the {area:380}; from the Alliance side, take the boat from {area:35}. {npc:6251}'s follow-up teaches {quest:3631}."] = "{area:392} liegt an der Küste von {zone:1413} östlich von {area:380}; von der Allianzseite aus nimm das Schiff von {area:35}. Die Folgequest von {npc:6251} lehrt dich {quest:3631}.",
}
