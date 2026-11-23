-- Spanish (Latin America) (esMX): the guide forever/class/priest/divine-grace-and-feedback (forever/class/priest/divine-grace-and-feedback.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["{quest:94773} and {spell:13896}"] = "{quest:94773} y {spell:13896}",
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["The Human priest spells: {quest:94773} at 10 (new in Forever), {spell:13896} at 20. Free, no objectives."] = "Los hechizos de sacerdote humano: {quest:94773} a nivel 10 (nuevo en Forever), {spell:13896} a nivel 20. Gratis, sin objetivos.",

	-- Step 1: Divine Grace: Priestess Josetta
	-- {npc:377} Priestess Josetta · {area:87} Goldshire · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 10, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a letter for {npc:376}. {area:87} is on the road north to {zone:1453}, so it costs no detour."] = "A nivel 10, {npc:377}, en el piso de arriba de la Posada Orgullo de León en {area:87}, te da una carta para {npc:376}. {area:87} está en el camino al norte hacia {zone:1453}, así que no es un desvío.",
	-- {npc:377} Priestess Josetta · {quest:94773} Divine Grace
	["{npc:377}: take her {quest:94773} letter"] = "{npc:377}: toma su carta de {quest:94773}",

	-- Step 2: Divine Grace: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["A Human priest in {zone:1438} at 10: {npc:3600}, in the building at the north edge of {area:186}, hands you a letter for {npc:376} in {zone:1453}."] = "Un sacerdote humano en {zone:1438} a nivel 10: {npc:3600}, en el edificio del borde norte de {area:186}, te da una carta para {npc:376} en {zone:1453}.",
	-- {npc:3600} Laurna Morninglight · {quest:94773} Divine Grace
	["{npc:3600}: take her {quest:94773} letter"] = "{npc:3600}: toma su carta de {quest:94773}",

	-- Step 3: Divine Grace: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {object:2098} Cathedral Square · {quest:94773} Divine Grace · {spell:6788} Weakened Soul · {spell:13908} Desperate Prayer
	["At 10, go to {npc:376} at the altar of the Cathedral of Light, in {zone:1453}'s {object:2098}, and take her quest: she teaches {quest:94773} on the spot. No letter needed; one from another trainer works too (next steps). {quest:94773} instantly heals a friend below half health and clears {spell:6788}, so you can shield them again (5-minute cooldown); it does not work on yourself. Human priests do not get {spell:13908} in Forever: this is their spell instead."] = "A nivel 10, ve con {npc:376} al altar de la Catedral de la Luz, en {object:2098} de {zone:1453}, y toma su misión: te enseña {quest:94773} en el acto. No hace falta carta; una de otro instructor también sirve (pasos siguientes). {quest:94773} sana al instante a un aliado por debajo de la mitad de salud y elimina {spell:6788}, para que puedas volver a escudarlo (5 minutos de reutilización); no funciona en ti. Los sacerdotes humanos no obtienen {spell:13908} en Forever: este es su hechizo en su lugar.",

	-- Step 4: Divine Grace: Josetta's letter
	-- {quest:94774} Divine Grace
	["{quest:94774}: Josetta's letter"] = "{quest:94774}: la carta de Josetta",
	-- {npc:376} High Priestess Laurena · {quest:94774} Divine Grace
	["Hand Josetta's letter to {npc:376} at the altar of the Cathedral of Light: she teaches {quest:94774}."] = "Entrégale la carta de Josetta a {npc:376} en el altar de la Catedral de la Luz: enseña {quest:94774}.",

	-- Step 5: Divine Grace: Laurna Morninglight's letter
	-- {quest:94775} Divine Grace · {npc:3600} Laurna Morninglight
	["{quest:94775}: {npc:3600}'s letter"] = "{quest:94775}: la carta de {npc:3600}",
	-- {npc:3600} Laurna Morninglight · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {quest:94775} Divine Grace
	["Hand {npc:3600}'s letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1438}: the boat from {area:702} to {area:442}, then the boat to {area:17203}): she teaches {quest:94775}."] = "Entrégale la carta de {npc:3600} a {npc:376} en el altar de la Catedral de la Luz de {zone:1453} (desde {zone:1438}: el barco de {area:702} a {area:442} y luego el barco a {area:17203}): enseña {quest:94775}.",

	-- Step 6: Divine Grace: a letter from another trainer
	-- {quest:94776} Divine Grace
	["{quest:94776}: a letter from another trainer"] = "{quest:94776}: una carta de otro instructor",
	-- {quest:94776} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94776} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Cualquier carta de {quest:94776} va para {npc:376} en el altar de la Catedral de la Luz.",

	-- Step 7: Divine Grace: a letter from another trainer
	-- {quest:94777} Divine Grace
	["{quest:94777}: a letter from another trainer"] = "{quest:94777}: una carta de otro instructor",
	-- {quest:94777} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94777} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Cualquier carta de {quest:94777} va para {npc:376} en el altar de la Catedral de la Luz.",

	-- Step 8: Divine Grace: a letter from another trainer
	-- {quest:94778} Divine Grace
	["{quest:94778}: a letter from another trainer"] = "{quest:94778}: una carta de otro instructor",
	-- {quest:94778} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94778} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Cualquier carta de {quest:94778} va para {npc:376} en el altar de la Catedral de la Luz.",

	-- Step 9: Divine Grace: a letter from another trainer
	-- {quest:94779} Divine Grace
	["{quest:94779}: a letter from another trainer"] = "{quest:94779}: una carta de otro instructor",
	-- {quest:94779} Divine Grace · {npc:376} High Priestess Laurena
	["Any {quest:94779} letter goes to {npc:376} at the altar of the Cathedral of Light."] = "Cualquier carta de {quest:94779} va para {npc:376} en el altar de la Catedral de la Luz.",

	-- Step 10: Feedback: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town
	["At 20 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) hands you a letter for {npc:376} in {zone:1453}. The {area:2257} from {object:171524} takes you there."] = "A nivel 20 en {zone:1455}, {npc:11406} en {object:32386} ({object:32362}) te da una carta para {npc:376} en {zone:1453}. {area:2257} desde {object:171524} te lleva ahí.",
	-- {npc:11406} High Priest Rohan · {quest:5676} Arcane Feedback
	["{npc:11406}: take his {quest:5676} letter"] = "{npc:11406}: toma su carta de {quest:5676}",

	-- Step 11: Feedback: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a letter for {npc:376} in {zone:1453}."] = "A nivel 20 en {zone:1457}, {npc:11401}, en el balcón superior del Templo de la Luna junto a {npc:7999}, te da una carta para {npc:376} en {zone:1453}.",
	-- {npc:11401} Priestess Alathea · {quest:5676} Arcane Feedback
	["{npc:11401}: take her {quest:5676} letter"] = "{npc:11401}: toma su carta de {quest:5676}",

	-- Step 12: Feedback: High Priestess Laurena
	-- {npc:376} High Priestess Laurena · {spell:13896} Feedback
	["At 20, {npc:376} at the altar of the Cathedral of Light teaches {spell:13896} with a quest she gives and takes back at once."] = "A nivel 20, {npc:376}, en el altar de la Catedral de la Luz, enseña {spell:13896} con una misión que te da y recibe enseguida.",

	-- Step 13: Feedback: Rohan's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Rohan's letter"] = "{spell:13896}: la carta de Rohan",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1455} Ironforge · {spell:13896} Feedback
	["Hand Rohan's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (the {area:2257} from {object:171524} in {zone:1455}): she teaches {spell:13896}."] = "Entrégale la carta de Rohan a {npc:376} en el altar de la Catedral de la Luz de {zone:1453} ({area:2257} desde {object:171524} en {zone:1455}): enseña {spell:13896}.",

	-- Step 14: Feedback: Alathea's letter
	-- {spell:13896} Feedback
	["{spell:13896}: Alathea's letter"] = "{spell:13896}: la carta de Alathea",
	-- {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {spell:13896} Feedback
	["Hand Alathea's letter to {npc:376} at the altar of {zone:1453}'s Cathedral of Light (from {zone:1457}: the portal down to {area:702}, the boat to {area:442}, then the boat to {area:17203}): she teaches {spell:13896}."] = "Entrégale la carta de Alathea a {npc:376} en el altar de la Catedral de la Luz de {zone:1453} (desde {zone:1457}: el portal de bajada a {area:702}, el barco a {area:442} y luego el barco a {area:17203}): enseña {spell:13896}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:376} in the Cathedral of Light. {npc:377} in {area:87} sends you to her with a quest of the same name."] = "A nivel 10, ve con {npc:376} en la Cathedral of Light. {npc:377}, en {area:87}, te envía con ella con una misión del mismo nombre.",
	-- ["At 20, {npc:376} teaches {spell:13896}. {npc:11406} in {zone:1455} and {npc:11401} in {zone:1457} send you to her with a quest of the same name."] = "A nivel 20, {npc:376} enseña {spell:13896}. {npc:11406}, en {zone:1455}, y {npc:11401}, en {zone:1457}, te envían con ella con una misión del mismo nombre.",
	-- ["The Human priest spells: {quest:94773} at 10, {spell:13896} at 20."] = "Los hechizos de sacerdote humano: {quest:94773} a nivel 10 y {spell:13896} a nivel 20.",
}
