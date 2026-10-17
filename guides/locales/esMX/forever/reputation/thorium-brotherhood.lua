-- Spanish (Latin America) (esMX): the guide forever/reputation/thorium-brotherhood (forever/reputation/thorium-brotherhood.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thorium Brotherhood Reputation"] = "Reputación: Hermandad del Torio",

	-- Step 1: Master Smith Burninate
	-- {area:1446} Thorium Point · {zone:1427} Searing Gorge · {faction:59} Thorium Brotherhood
	["{area:1446}, on the scaffolds in the north-west of {zone:1427}, is the Brotherhood's outpost. The {faction:59} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:1446}, en los andamios del noroeste de {zone:1427}, es el puesto de avanzada de la Hermandad. {faction:59} empieza en Neutral. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",

	-- Step 2: Secret Plans: Fiery Flux
	-- {area:1443} Slag Pit · {object:147516} Dark Iron (no name in this language: may be words) · {item:18945} Dark Iron Residue
	["The plans lie in the {area:1443} of the Cauldron, guarded by {object:147516} dwarves. {object:147516} dwarves also drop {item:18945}, which Burninate takes for Gaining Acceptance."] = "Los diseños están en {area:1443} de La Caldera, custodiados por enanos {object:147516}. Los enanos {object:147516} también sueltan {item:18945}, que Burninate acepta para Conseguir aceptación.",

	-- Step 3: Back to Burninate
	["Back to Burninate"] = "Regresa con Burninate",

	-- Step 4: Fiery Flux supplies to Friendly
	-- {item:18942} Fiery Flux
	["{item:18942} supplies to Friendly"] = "Suministros de {item:18942} hasta Amistoso",
	-- {item:3356} Kingsblood · {item:4234} Heavy Leather · {item:18944} Incendosaur Scale · {zone:1427} Searing Gorge
	-- plural, as words: Iron Bars = {item:3575} Iron Bar · Incendosaurs = {npc:9318} Incendosaur
	["Restoring Fiery Flux Supplies repeats in three versions: {item:3356}, Iron Bars or {item:4234}, each with Coal and an {item:18944}. Incendosaurs (level 47-49) in the north of {zone:1427} drop a scale every time; Burninate himself sells Coal."] = "Fabricar flujo ígneo se repite en tres versiones: {item:3356}, Barras de hierro o {item:4234}, cada una con Carbón y una {item:18944}. Los Incendosaurios (nivel 47-49) del norte de {zone:1427} sueltan una escama siempre; el propio Burninate vende Carbón.",
	-- {npc:14624} Master Smith Burninate
	["{npc:14624}: Restoring Fiery Flux Supplies"] = "{npc:14624}: Fabricar flujo ígneo",

	-- Step 5: Lokhtos Darkbargainer to Honored
	-- {npc:12944} Lokhtos Darkbargainer
	["{npc:12944} to Honored"] = "{npc:12944} hasta Honorable",
	-- {npc:12944} Lokhtos Darkbargainer · {area:1584} Blackrock Depths · {item:11099} Dark Iron Ore · {skill:186} Mining · {item:11382} Blood of the Mountain · {item:17010} Fiery Core · {item:17011} Lava Core · {item:17012} Core Leather · {npc:14387} Lothos Riftwaker · {area:1445} Blackrock Mountain · {area:2717} Molten Core
	-- plural, as words: Dark Iron Deposits = {object:165658} Dark Iron Deposit
	["{npc:12944} trades in the Grim Guzzler inside {area:1584}. His Favor Amongst the Brotherhood turn-ins take {item:11099} (mined from Dark Iron Deposits with {skill:186}), {item:11382}, {item:17010}, {item:17011} and {item:17012}. {npc:14387} at the {area:1445} entrance offers attunement to the {area:2717}."] = "{npc:12944} comercia en la taberna Tragapenas dentro de {area:1584}. Sus entregas de El favor de la Hermandad aceptan {item:11099} (extraída de Depósitos de hierro negro con {skill:186}), {item:11382}, {item:17010}, {item:17011} y {item:17012}. {npc:14387}, en la entrada de {area:1445}, ofrece la armonización para {area:2717}.",
	-- {item:11099} Dark Iron Ore
	["{item:11099}: Favor Amongst the Brotherhood, {item:11099} at Lokhtos, repeatable."] = "{item:11099}: El favor de la Hermandad, {item:11099} con Lokhtos, repetible.",

	-- Step 6: Thorium Brotherhood to Revered
	-- {faction:59} Thorium Brotherhood
	["{faction:59} to Revered"] = "{faction:59} hasta Reverenciado",
	-- {area:2717} Molten Core · {item:11382} Blood of the Mountain
	-- plural, as words: Fiery Cores = {item:17010} Fiery Core · Lava Cores = {item:17011} Lava Core · Lava Elementals = {npc:12076} Lava Elemental · Lava Reavers = {npc:12100} Lava Reaver · Molten Destroyers = {npc:11659} Molten Destroyer
	["The {area:2717} materials carry the rest: Fiery Cores drop from Firewalkers, Flameguards and Firelords, and Lava Cores from Lava Elementals, Lava Reavers and Molten Destroyers there. {item:11382} comes from Molten Destroyers and rarely elsewhere."] = "Los materiales de {area:2717} dan el resto: los Núcleos ardientes caen de Caminafuegos, Guardias de llamas y Señores del Fuego, y los Núcleos de lava de Elementales de lava, Atracadores de lava y Destructores de magma de allí. {item:11382} sale de los Destructores de magma y rara vez de otros.",
	-- {area:2717} Molten Core · {item:17010} Fiery Core · {item:17011} Lava Core · {item:17012} Core Leather · {item:11382} Blood of the Mountain
	["{area:2717} materials: Favor Amongst the Brotherhood, {item:17010}, {item:17011}, {item:17012} and {item:11382}, all repeatable at Lokhtos."] = "Materiales de {area:2717}: El favor de la Hermandad, {item:17010}, {item:17011}, {item:17012} y {item:11382}, todos repetibles con Lokhtos.",

	-- Step 7: Thorium Brotherhood to Exalted
	-- {faction:59} Thorium Brotherhood
	["{faction:59} to Exalted"] = "{faction:59} hasta Exaltado",
	-- {area:2717} Molten Core · {item:11099} Dark Iron Ore
	["Keep turning in {area:2717} materials and {item:11099} at Lokhtos until Exalted."] = "Sigue entregando materiales de {area:2717} y {item:11099} a Lokhtos hasta Exaltado.",
}
