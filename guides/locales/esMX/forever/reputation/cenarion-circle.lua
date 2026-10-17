-- Spanish (Latin America) (esMX): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "Reputación: Círculo Cenarion",

	-- Step 1: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {npc:15270} Huum Wildmane · {faction:609} Cenarion Circle
	["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425} es el pueblo amurallado del centro norte de {zone:1451}. Bor y {npc:15270} están juntos adentro. {faction:609} empieza en Neutral. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",
	-- {quest:8320} Twilight Geolords
	["{quest:8320} needs level 60"] = "{quest:8320} requiere nivel 60",

	-- Step 2: Twilight Base Camp
	-- {zone:1451} Silithus · {quest:8320} Twilight Geolords · {item:20404} Encrypted Twilight Text · {faction:609} Cenarion Circle
	["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "Los cultistas del Martillo Crepuscular ocupan los campamentos del oeste de {zone:1451}. {quest:8320} y Clamapiedras se mezclan aquí; cualquier cultista puede soltar {item:20404}. Cada cultista que mates también cuenta para {faction:609}. Los Geoseñores cuentan para {quest:8320} solo si eres nivel 60 y la aceptaste.",

	-- Step 3: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "De vuelta a {area:3425}",

	-- Step 4: Encrypted Twilight Texts to Friendly
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts to Friendly"] = "Textos Crepusculares codificados hasta Amistoso",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "Textos Crepusculares codificados se repite: {npc:15306} acepta más textos una y otra vez. Los campamentos de cultistas son el lugar para conseguirlos.",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}: Textos Crepusculares codificados",

	-- Step 5: Cenarion Circle to Honored
	-- {faction:609} Cenarion Circle
	["{faction:609} to Honored"] = "{faction:609} hasta Honorable",
	-- {npc:15282} Aurel Goldleaf · {npc:15306} Bor Wildmane
	-- plural, as words: Wind Stones = {object:180461} Wind Stone · Abyssal Crests = {item:20513} Abyssal Crest
	["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "Sigue cazando en los campamentos Crepusculares. Si llevas el atuendo Crepuscular (el conjunto de cultista Crepuscular más un Medallón de estatus, de la misión Medallón de estatus de {npc:15282}), puedes invocar Templarios abisales en las Piedras de viento; sus Blasones abisales son para {npc:15306}.",

	-- Step 6: Cenarion Circle to Revered
	-- {faction:609} Cenarion Circle
	["{faction:609} to Revered"] = "{faction:609} hasta Reverenciado",
	-- {area:3454} Ruins of Ahn'Qiraj
	["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "De aquí en adelante, la banda de {area:3454} y las entregas del Consejo Abisal (blasones, sellos, cetros) dan la mayor parte de la reputación.",
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Abyssal Crests = {item:20513} Abyssal Crest · Abyssal Signets = {item:20514} Abyssal Signet · Abyssal Scepters = {item:20515} Abyssal Scepter
	["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "Los Blasones abisales, Sellos abisales y Cetros abisales se pueden repetir con {npc:15306} una vez hechas sus misiones iniciales.",

	-- Step 7: Cenarion Circle to Exalted
	-- {faction:609} Cenarion Circle
	["{faction:609} to Exalted"] = "{faction:609} hasta Exaltado",
	-- {area:3454} Ruins of Ahn'Qiraj
	["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "Sigue haciendo {area:3454} y entregando insignias del Consejo Abisal hasta Exaltado.",
}
