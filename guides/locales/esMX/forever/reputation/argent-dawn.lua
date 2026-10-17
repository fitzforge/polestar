-- Spanish (Latin America) (esMX): the guide forever/reputation/argent-dawn (forever/reputation/argent-dawn.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Argent Dawn Reputation"] = "Reputación: El Alba Argenta",

	-- Step 1: Argent Dawn Commission (Alliance)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Alliance)"] = "{quest:5401} (Alianza)",
	-- {object:2160} The Argent Dawn · {npc:10840} Argent Officer Pureheart · {area:3197} Chillwind Camp · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10840} at {area:3197} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} empieza en Neutral. Toma la comisión de {npc:10840} en {area:3197} y llévala equipada: en Classic, las Piedras de la Plaga solo caen mientras tienes equipado el abalorio {quest:5401}. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",

	-- Step 2: Argent Dawn Commission (Horde)
	-- {quest:5401} Argent Dawn Commission
	["{quest:5401} (Horde)"] = "{quest:5401} (Horda)",
	-- {object:2160} The Argent Dawn · {npc:10839} Argent Officer Garush · {area:152} The Bulwark · {quest:5401} Argent Dawn Commission
	["{object:2160} starts out Neutral. Take the Commission from {npc:10839} at {area:152} and wear it: in Classic, Scourgestones only drop while the {quest:5401} trinket is equipped. Forever's Legacy Diplomat perk increases reputation gains."] = "{object:2160} empieza en Neutral. Toma la comisión de {npc:10839} en {area:152} y llévala equipada: en Classic, las Piedras de la Plaga solo caen mientras tienes equipado el abalorio {quest:5401}. La ventaja Diplomático del Legado de Forever aumenta la reputación obtenida.",

	-- Step 3: Minion's Scourgestones to Friendly
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Minion's Scourgestones to Friendly"] = "Piedras de la Plaga del esbirro hasta Amistoso",
	-- {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {area:152} The Bulwark · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel · {item:12844} Argent Dawn Valor Token
	-- plural, as words: Minion's Scourgestones = {item:12840} Minion's Scourgestone
	["Ghouls and skeletons all over {zone:1422} drop Minion's Scourgestones about half the time; this cluster is dense. Hand them in 20 at a time to any Argent Officer (Pureheart at {area:3197}, Garush at {area:152}, {npc:11039} at {area:2268}). Each turn-in also pays an {item:12844} for the Argent quartermasters."] = "Los necrófagos y esqueletos de todo {zone:1422} sueltan Piedras de la Plaga del esbirro aproximadamente la mitad de las veces; este grupo es denso. Entrégalas de 20 en 20 a cualquier Oficial Argenta (Purocorazón en {area:3197}, Garush en {area:152}, {npc:11039} en {area:2268}). Cada entrega también da una {item:12844} para los intendentes Argenta.",

	-- Step 4: Invader's Scourgestones to Honored
	-- plural, as words: Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Invader's Scourgestones to Honored"] = "Piedras de la Plaga del invasor hasta Honorable",
	-- {item:14047} Runecloth · {npc:11039} Duke Nicholas Zverenhoff · {area:2268} Light's Hope Chapel
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept · Invader's Scourgestones = {item:12841} Invader's Scourgestone
	["Dark Adepts and Shadowmages (level 58-60) drop Invader's Scourgestones here, along with Minion's stones and {item:14047}. Hand Invader's in 10 at a time and Minion's 20 at a time to {npc:11039} at {area:2268}. In Classic both stop giving reputation at Honored."] = "Los Adeptos oscuros y Magos oscuros (nivel 58-60) sueltan aquí Piedras de la Plaga del invasor, además de piedras del esbirro y {item:14047}. Entrega las del invasor de 10 en 10 y las del esbirro de 20 en 20 a {npc:11039} en {area:2268}. En Classic ambas dejan de dar reputación en Honorable.",

	-- Step 5: Corruptor's Scourgestones and dungeons to Revered
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["Corruptor's Scourgestones and dungeons to Revered"] = "Piedras de la Plaga del corruptor y calabozos hasta Reverenciado",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {npc:1853} Darkmaster Gandling · {npc:10433} Marduk Blackpool · {npc:1852} Araj the Summoner · {zone:1422} Western Plaguelands
	-- plural, as words: Corruptor's Scourgestones = {item:12843} Corruptor's Scourgestone
	["From Honored on, Corruptor's Scourgestones (one per turn-in) and Scourge kills in {area:2279} and {area:2057} carry the reputation. Corruptor's stones drop from the Scourge bosses there ({npc:1853}, {npc:10433}, Vectus) and from {npc:1852} and Putridius in {zone:1422}. Many dungeon runs pay off faster than any open-world farm."] = "Desde Honorable, las Piedras de la Plaga del corruptor (una por entrega) y matar Plaga en {area:2279} y {area:2057} dan la reputación. Las piedras del corruptor caen de los jefes de la Plaga de allí ({npc:1853}, {npc:10433}, Vectus) y de {npc:1852} y Putridus en {zone:1422}. Muchas incursiones en calabozos rinden más rápido que cualquier farmeo al aire libre.",
	-- {area:2279} Stratholme · {area:2057} Scholomance
	["Run {area:2279} (both wings) and {area:2057}, killing every Scourge you pass."] = "Haz {area:2279} (ambas alas) y {area:2057}, matando a toda la Plaga que encuentres.",

	-- Step 6: Argent Dawn to Exalted
	-- {faction:529} Argent Dawn
	["{faction:529} to Exalted"] = "{faction:529} hasta Exaltado",
	-- {area:2279} Stratholme · {area:2057} Scholomance · {item:12843} Corruptor's Scourgestone · {area:2268} Light's Hope Chapel
	["Keep running {area:2279} and {area:2057} and turning in every {item:12843} at {area:2268} until Exalted."] = "Sigue haciendo {area:2279} y {area:2057} y entregando cada {item:12843} en {area:2268} hasta Exaltado.",
}
