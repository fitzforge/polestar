-- Spanish (Latin America) (esMX): the guide forever/class/shaman/call-of-earth-alliance (forever/class/shaman/call-of-earth-alliance.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94373} Call of Earth
	["{quest:94373} (Alliance)"] = "{quest:94373} (Alianza)",
	-- {item:5175} Earth Totem · {spell:8071} Stoneskin Totem
	["Your {item:5175}: without it no earth totem can be cast. {spell:8071} comes with it at level 4."] = "Tu {item:5175}: sin él no puedes lanzar ningún tótem de tierra. {spell:8071} viene con él a nivel 4.",

	-- Step 1: Archaic Rune
	-- {quest:94373} Call of Earth · {quest:98581} Archaic Rune · {npc:658} Sten Stoutarm · {area:132} Coldridge Valley · {quest:179} Dwarven Outfitters · {npc:257446} Teo Hammerstorm · {area:77} Anvilmar
	["Teo's {quest:94373} needs the {quest:98581} handed in first: {npc:658}, where you entered {area:132}, gives it to Dwarf shamans after his {quest:179}. Bring it up the road to {npc:257446} inside {area:77}."] = "{quest:94373} de Teo necesita que antes entregues {quest:98581}: {npc:658}, donde entraste a {area:132}, se la da a los chamanes enanos después de su {quest:179}. Llévala camino arriba hasta {npc:257446}, dentro de {area:77}.",

	-- Step 2: Teo Hammerstorm
	-- {npc:257446} Teo Hammerstorm · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {quest:94373} Call of Earth
	["{npc:257446} trains shamans inside {area:77}, the hall at the south end of {area:132}. The quest opens at level 4. Never took it and now 10 or more? {npc:258098} in {zone:1455} or {npc:258113} in {area:131} gives you {quest:94373}, a pointer back to Teo: take it for the experience on the way."] = "{npc:257446} entrena chamanes dentro de {area:77}, el salón del extremo sur de {area:132}. La misión se abre a nivel 4. ¿Nunca la tomaste y ya tienes nivel 10 o más? {npc:258098} en {zone:1455} o {npc:258113} en {area:131} te da {quest:94373}, una indicación de vuelta a Teo: tómala por la experiencia en el camino.",

	-- Step 3: Iceclaw Bear Pendants
	-- plural, as words: Iceclaw Bear Pendants = {item:264356} Iceclaw Bear Pendant
	["Iceclaw Bear Pendants"] = "Colgantes de oso Garrahelada",
	-- {area:77} Anvilmar
	-- plural, as words: Frostmane Troll Whelps = {npc:706} Frostmane Troll Whelp · Frostmane Novices = {npc:946} Frostmane Novice · Frostbolts = {spell:116} Frostbolt
	["The Frostmane Troll Whelps (level 3-4) hold the snowy slopes west and south-west of {area:77}, and the Frostmane Novices (level 3-4, they throw Frostbolts from range) camp south of it. Both carry the pendants; they respawn in about three minutes."] = "Las crías de trol Peloescarcha (nivel 3-4) ocupan las laderas nevadas al oeste y suroeste de {area:77}, y los novicios Peloescarcha (nivel 3-4, lanzan descargas de escarcha a distancia) acampan al sur. Ambos llevan los colgantes; reaparecen en unos tres minutos.",

	-- Step 4: Teo Hammerstorm
	-- {area:77} Anvilmar · {item:6635} Earth Sapta
	["Back to Teo inside {area:77}. He hands you the {item:6635}: do not drink it yet."] = "De vuelta con Teo dentro de {area:77}. Te da {item:6635}: no lo bebas todavía.",

	-- Step 5: Lost the Earth Sapta?
	-- {quest:94472} Earth Sapta
	["Lost the {quest:94472}?"] = "¿Perdiste {quest:94472}?",
	-- {quest:94472} Earth Sapta
	["Only if the {quest:94472} is gone from your bags (drunk away from the stone, or sold): Teo gives you another."] = "Solo si {quest:94472} ya no está en tus bolsas (lo bebiste lejos de la piedra o lo vendiste): Teo te da otro.",
	-- {npc:257446} Teo Hammerstorm · {quest:94472} Earth Sapta
	["{npc:257446}: a new {quest:94472}"] = "{npc:257446}: un {quest:94472} nuevo",

	-- Step 6: The Spirit Stone
	["The Spirit Stone"] = "La Piedra del Espíritu",
	-- {area:77} Anvilmar · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth
	["The Spirit Stone stands on a snowy ridge north-west of {area:77}. The trail is easy to miss: it climbs the hill from the valley floor; at the small camp near the top turn left and the stone comes into view. Stand beside it, drink the {item:6635} and speak to the {npc:5891} before it fades."] = "La Piedra del Espíritu está en una cresta nevada al noroeste de {area:77}. El sendero es fácil de pasar por alto: sube la colina desde el fondo del valle; en el campamentito cerca de la cima, dobla a la izquierda y aparece la piedra. Párate a su lado, bebe {item:6635} y habla con la {npc:5891} antes de que se desvanezca.",
	-- {item:6635} Earth Sapta
	["{item:6635}, beside the Spirit Stone"] = "{item:6635}, junto a la piedra espiritual",
	-- {item:6656} Rough Quartz
	["it hands you the {item:6656}: keep it"] = "te da {item:6656}: guárdalo",

	-- Step 7: Teo Hammerstorm
	-- {item:6656} Rough Quartz · {area:77} Anvilmar · {item:5175} Earth Totem
	["Bring the {item:6656} back to Teo inside {area:77}. Keep the {item:5175} in your bags for good: every earth totem needs it."] = "Lleva {item:6656} de vuelta a Teo dentro de {area:77}. Guarda {item:5175} en tus bolsas para siempre: todo tótem de tierra lo necesita.",
	-- {npc:257446} Teo Hammerstorm · {spell:8071} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:257446}: {spell:8071} and your {item:5175}"] = "{npc:257446}: {spell:8071} y tu {item:5175}",
	["the level 4 shaman spells"] = "los hechizos de chamán de nivel 4",
}
