-- Spanish (Spain) (esES): the guide forever/reputation/arathi-basin (forever/reputation/arathi-basin.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Arathi Basin Reputation"] = "Reputación: Cuenca de Arathi",

	-- Step 1: League of Arathor to Friendly
	["League of Arathor to Friendly"] = "Liga de Arathor a Amistoso",
	-- {faction:509} The League of Arathor · {zone:1461} Arathi Basin · {area:320} Refuge Pointe
	["{faction:509} fights for {zone:1461} from {area:320}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:509} lucha por {zone:1461} desde {area:320}. Su reputación viene del campo de batalla: los recursos que reúne tu equipo la dan a todos, así que mantener más bases durante más tiempo da más. Ponte en cola con cualquier maestro de batalla. La ventaja de Legado Diplomático de Forever aumenta la reputación obtenida.",
	-- {npc:14983} Field Marshal Oslight · {zone:1461} Arathi Basin · {npc:14984} Sergeant Maclear
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:14983}'s The Battle for {zone:1461}! (assault every base) and Control Four Bases / Control Five Bases are one-time quests; {npc:14984} beside him takes Arathi Resource Crates."] = "La batalla por {zone:1461} de {npc:14983} (asalta todas las bases) y Toma el control de cuatro bases / Toma el control de cinco bases son misiones únicas; {npc:14984}, a su lado, acepta Cajones de recursos de Arathi.",

	-- Step 2: League of Arathor to Honored
	["League of Arathor to Honored"] = "Liga de Arathor a Honorable",
	-- {zone:1461} Arathi Basin · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15351} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Sigue jugando en {zone:1461}. Los fines de semana de Llamada a las armas: {zone:1461}, el {npc:15351} de las capitales acepta tres Marcas de honor de la Cuenca de Arathi a cambio de reputación extra.",
	-- {npc:15127} Samuel Hawke
	["{npc:15127} hands out one Arathor care package by level"] = "{npc:15127} entrega un paquete de curación de Arathor según tu nivel",

	-- Step 3: League of Arathor to Revered
	["League of Arathor to Revered"] = "Liga de Arathor a Venerado",
	-- {zone:1461} Arathi Basin
	["Keep playing {zone:1461}; wins with many bases held pay the most."] = "Sigue jugando {zone:1461}; las victorias con muchas bases en tu poder son las que más dan.",

	-- Step 4: League of Arathor to Exalted
	["League of Arathor to Exalted"] = "Liga de Arathor a Exaltado",
	["Exalted with the League of Arathor earns a Legacy Point."] = "Exaltado con la Liga de Arathor da un punto de Legado.",

	-- Step 5: The Defilers to Friendly
	-- {faction:510} The Defilers
	["{faction:510} to Friendly"] = "{faction:510} a Amistoso",
	-- {faction:510} The Defilers · {zone:1461} Arathi Basin · {area:321} Hammerfall
	["{faction:510} fight for {zone:1461} from {area:321}. Their reputation comes from the battleground: the resources your team gathers pay it to everyone, so holding more bases for longer pays more. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:510} luchan por {zone:1461} desde {area:321}. Su reputación viene del campo de batalla: los recursos que reúne tu equipo la dan a todos, así que mantener más bases durante más tiempo da más. Ponte en cola con cualquier maestro de batalla. La ventaja de Legado Diplomático de Forever aumenta la reputación obtenida.",
	-- {npc:15021} Deathmaster Dwire · {zone:1461} Arathi Basin · {npc:15022} Deathstalker Mortis
	-- plural, as words: Arathi Resource Crates = {item:19725} Arathi Resource Crate
	["{npc:15021}'s The Battle for {zone:1461}! (assault every base) and Take Four Bases / Take Five Bases are one-time quests; {npc:15022} beside him takes Arathi Resource Crates."] = "La batalla por {zone:1461} de {npc:15021} (asalta todas las bases) y Toma el contol de cuatro bases / Toma el contol de cinco bases son misiones únicas; {npc:15022}, a su lado, acepta Cajones de recursos de Arathi.",

	-- Step 6: The Defilers to Honored
	-- {faction:510} The Defilers
	["{faction:510} to Honored"] = "{faction:510} a Honorable",
	-- {zone:1461} Arathi Basin · {npc:15350} Horde Warbringer
	["Keep playing {zone:1461}. On Call to Arms: {zone:1461} weekends the {npc:15350} in the capitals takes three Arathi Basin Marks of Honor for extra reputation."] = "Sigue jugando en {zone:1461}. Los fines de semana de Llamada a las armas: {zone:1461}, el {npc:15350} de las capitales acepta tres Marcas de honor de la Cuenca de Arathi a cambio de reputación extra.",
	-- {npc:15126} Rutherford Twing
	["{npc:15126} hands out one Defiler's care package by level"] = "{npc:15126} entrega un paquete de cuidados de Rapiñador según tu nivel",

	-- Step 7: The Defilers to Revered
	-- {faction:510} The Defilers
	["{faction:510} to Revered"] = "{faction:510} a Venerado",

	-- Step 8: The Defilers to Exalted
	-- {faction:510} The Defilers
	["{faction:510} to Exalted"] = "{faction:510} a Exaltado",
	-- {faction:510} The Defilers
	["Exalted with {faction:510} earns a Legacy Point."] = "Exaltado con {faction:510} da un punto de Legado.",
}
