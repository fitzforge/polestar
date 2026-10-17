-- Spanish (Latin America) (esMX): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "Abre {area:3486}, la casa oculta de los pícaros en las colinas de Alterac, y sus primeros trabajos.",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "Reputación con {npc:13936}",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "{item:17126}",
	-- {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad
	["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "A nivel 24, una {item:17126} de {npc:13936} inicia esto; los datos te la dan a través de {npc:332} o {npc:918} en {zone:1453}, o de Gest u Ormok en {zone:1454}. La misión te entrega el {item:17125} para {npc:6707}.",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {zone:1416} Alterac Mountains
	["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "La Horda vuela a {area:272}; la Alianza, a {area:271}. La mansión se oculta en las colinas al este de {area:272}, subiendo por un sendero hacia {zone:1416}; el Rite of Cunning te deja entrar.",
	["Rite of Cunning"] = "Rite of Cunning",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766}: {quest:6701}, repetible",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {area:287} Hillsbrad · {npc:13085} Myrokos Silentform
	["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216} está dentro de {area:275}, la fortaleza de la Hermandad en el este de {area:287}, al sur de la mansión. Rápido y en silencio, dice {npc:13085}.",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains
	["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "A nivel 36, {npc:13085} te envía por el informe de exploración de Barton. Barton dirige un grupo de la Hermandad en {area:280}, en el este de {zone:1416}: róbale del bolsillo, no lo mates.",
	-- {item:275482} Barton's Scouting Report
	["{item:275482}: pickpocket Barton"] = "{item:275482}: roba del bolsillo a Barton",

	-- Step 6: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "Regresa con {npc:13085}",
}
