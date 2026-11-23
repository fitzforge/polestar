-- German (deDE): the guide forever/collectibles/mounts/horde/paladin-warhorse (forever/collectibles/mounts/horde/paladin-warhorse.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse (Forsaken)"] = "Schlachtross des Paladins (Verlassene)",
	["Your first mount at 40, summoned at will: a Forsaken paladin buys no horse and pays no riding trainer."] = "Dein erstes Reittier auf Stufe 40, jederzeit beschworen: Ein verlassener Paladin kauft kein Pferd und bezahlt keinen Reitlehrer.",

	-- Step 1: Report to Danitha
	-- {npc:260093} Garen Largo · {zone:1458} Undercity · {npc:246378} Danitha Morr · {area:16602} Bandarion Keep
	["At 40 {npc:260093}, the paladin trainer in the {zone:1458}, sends you to {npc:246378} at {area:16602}. Train your new spells with him while you are there. Already at {area:16602}? Skip this step: {npc:246378} gives you the mount quest without it."] = "Auf Stufe 40 schickt dich {npc:260093}, der Paladinlehrer in {zone:1458}, zu {npc:246378} in {area:16602}. Lerne bei ihm gleich deine neuen Zauber. Schon in {area:16602}? Überspringe diesen Schritt: {npc:246378} gibt dir die Reittierquest auch ohne ihn.",
	-- {npc:260093} Garen Largo
	["{npc:260093}: your level 40 spells"] = "{npc:260093}: deine Zauber der Stufe 40",

	-- Step 2: Danitha Morr
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {zone:1458} Undercity · {area:159} Brill · {npc:246378} Danitha Morr
	["{area:16602} stands on the bluffs in western Tirisfal, north-west of the {area:156}: leave the {zone:1458} and follow the road west past {area:159}. {npc:246378} is inside the keep, upstairs."] = "{area:16602} steht auf den Klippen im Westen von Tirisfal, nordwestlich von {area:156}: Verlasse {zone:1458} und folge der Straße nach Westen an {area:159} vorbei. {npc:246378} ist in der Burg, oben.",
	-- {area:16602} Bandarion Keep
	["{area:16602}'s south gate"] = "Südtor von {area:16602}",

	-- Step 3: Summon Warhorse
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {quest:94971} A Paladin's Steed · {spell:1279399} Summon Warhorse
	["{npc:246378}, upstairs in {area:16602}, offers {quest:94971} at 40: accept it and hand it straight back. It teaches you {spell:1279399} and Apprentice Riding together, so you need no horse and no riding trainer."] = "{npc:246378}, oben in {area:16602}, bietet dir auf Stufe 40 {quest:94971} an: Nimm sie an und gib sie gleich wieder ab. Sie lehrt dich {spell:1279399} und das Reiten zugleich, also brauchst du weder Pferd noch Reitlehrer.",
}
