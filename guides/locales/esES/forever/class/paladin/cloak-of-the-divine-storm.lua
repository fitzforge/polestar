-- Spanish (Spain) (esES): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:407778} Divine Storm
	["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "Una capa rara a nivel 30 de la antigua historia de {spell:407778}; por ahora solo los paladines de la Alianza pueden terminarla.",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "El orbe extraño",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "Sube a lo alto de la {area:444}, en el norte de {zone:1439}. Despoja el orbe extraño de arriba: te da el orbe de Althalaxx, que inicia la misión.",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "Orbe extraño en lo alto de la {area:444}: haz clic derecho en el orbe de Althalaxx que da",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663} está en {area:413}, en el oeste de {zone:1440}.",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} is in the Cathedral of Light."] = "{npc:5492} está en la Catedral de la Luz.",

	-- Step 4: Ursula Deline
	-- {object:2101} Mage Quarter · {npc:5495} Ursula Deline
	["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "Katherine te envía a los brujos de {object:2101}; {npc:5495} habla por ellos.",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner
	["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "Los invocadores, campeones y rastreadores Roca Negra acampan en el noroeste de las Montañas Crestagrana; sueltan la {item:209778}.",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "De vuelta con {npc:5495}",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "Motas de Mannoroth",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "{area:435} está en el sureste de {zone:1440}. Los Mannoroc Latiguez, infernales abrasadores, guardias malditos y canes de la Legión de allí sueltan las motas de Mannoroth.",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words)
	["The {object:409311}"] = "La {object:409311}",
	-- {object:409311} Spear of Mannoroth (no name in this language: may be words) · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb (no name in this language: may be words)
	["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311} está en el extremo este de {area:435}. Rompe el orbe que hay en ella; {object:409315} aparece a su lado.",
	-- {object:409315} Shattered Orb (no name in this language: may be words)
	["from the {object:409315}"] = "del {object:409315}",

	-- Step 9: Return to Delgren
	-- {area:413} Maestra's Post
	["Back to {area:413}."] = "Vuelve a {area:413}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311} está en el extremo este de {area:435}. Lanza {spell:11170} sobre el orbe que hay en ella; {object:409315} aparece a su lado.",
}
