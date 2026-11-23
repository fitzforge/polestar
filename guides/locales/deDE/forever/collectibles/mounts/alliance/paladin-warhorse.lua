-- German (deDE): the guide forever/collectibles/mounts/alliance/paladin-warhorse (forever/collectibles/mounts/alliance/paladin-warhorse.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse"] = "Schlachtross des Paladins",
	["Your first mount at 40, summoned at will: a paladin buys no horse."] = "Dein erstes Reittier auf Stufe 40, jederzeit beschworen: Ein Paladin kauft kein Pferd.",

	-- Step 1: The Tome of Nobility (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {npc:5149} Brandur Ironhammer · {area:2257} Deeprun Tram
	["At 40 {npc:6179}, upstairs in the {object:32386}, sends you to {npc:6171} in {zone:1453} ({npc:5149} downstairs gives the same errand; take one). Take the {area:2257} to {zone:1453}."] = "Auf Stufe 40 schickt dich {npc:6179}, oben in der {object:32386}, zu {npc:6171} in {zone:1453} ({npc:5149} unten gibt denselben Auftrag; nimm einen). Nimm die {area:2257} nach {zone:1453}.",

	-- Step 4: Summon Warhorse
	-- {npc:6171} Duthorian Rall · {quest:1661} The Tome of Nobility · {spell:13819} Summon Warhorse
	["{npc:6171} stands in the Cathedral of Light. At 40 he offers {quest:1661}: accept it and hand it straight back to learn {spell:13819}. Paladins do not buy a horse."] = "{npc:6171} steht in der Kathedrale des Lichts. Auf Stufe 40 bietet er {quest:1661} an: Nimm sie an und gib sie sofort zurück, um {spell:13819} zu lernen. Paladine kaufen kein Pferd.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 40 {npc:5149} in the {object:32362} sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "Auf Stufe 40 schickt dich {npc:5149} im {object:32362} zu {npc:6171} in der Kathedrale des Lichts in {zone:1453}. Nimm die Tiefenbahn von {zone:1455} nach {zone:1453}.",
	-- ["{npc:6171} stands in the Cathedral of Light. Turning in the {item:6779} teaches {spell:13819}; Paladins do not buy a mount."] = "{npc:6171} steht in der Kathedrale des Lichts. Das Abgeben des {item:6779} lehrt {spell:13819}; Paladine kaufen kein Reittier.",
}
