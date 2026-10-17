-- French (frFR): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:407778} Divine Storm
	["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "Une cape rare au niveau 30, tirée de l'ancienne histoire de {spell:407778} ; pour l'instant, seuls les paladins de l'Alliance peuvent la terminer.",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "Strange Orb",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore
	["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "Montez au sommet de {area:444}, dans le nord de {zone:1439}. Fouillez le Strange Orb là-haut : il vous donne l'Althalaxx Orb, qui lance la quête.",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "Strange Orb au sommet de {area:444} : clic droit sur l'Althalaxx Orb qu'il donne",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663} se trouve à {area:413}, dans l'ouest de {zone:1440}.",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} is in the Cathedral of Light."] = "{npc:5492} est dans la cathédrale de la Lumière.",

	-- Step 4: Ursula Deline
	-- {object:2101} Mage Quarter · {npc:5495} Ursula Deline
	["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "Katherine vous envoie voir les démonistes dans {object:2101} ; {npc:5495} parle en leur nom.",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner
	["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "Les Invocateurs, Champions et Pisteurs Blackrock campent dans le nord-ouest des Carmines ; ils laissent tomber le {item:209778}.",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "Retour auprès d'{npc:5495}",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "Granules de Mannoroth",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "{area:435} se trouve dans le sud-est d'{zone:1440}. Les Flagellantes de Mannoroc, Infernaux incendiaires, Gangregardes et Molosses de la Légion qui s'y trouvent laissent tomber les Granules de Mannoroth.",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth
	["The {object:409311}"] = "{object:409311}",
	-- {object:409311} Spear of Mannoroth · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb
	["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311} se dresse à l'extrémité est de {area:435}. Brisez l'orbe dessus ; l'{object:409315} apparaît à côté.",
	-- {object:409315} Shattered Orb
	["from the {object:409315}"] = "sur l'{object:409315}",

	-- Step 9: Return to Delgren
	-- {area:413} Maestra's Post
	["Back to {area:413}."] = "Retour à {area:413}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311} se dresse à l'extrémité est de {area:435}. Lancez {spell:11170} sur l'orbe qui s'y trouve ; {object:409315} apparaît à côté.",
}
