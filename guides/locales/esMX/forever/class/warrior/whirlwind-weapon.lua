-- Spanish (Latin America) (esMX): the guide forever/class/warrior/whirlwind-weapon (forever/class/warrior/whirlwind-weapon.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2458} Berserker Stance · {spell:1680} Whirlwind
	["{spell:2458} at 30 and a {spell:1680} axe, sword or warhammer at 40."] = "{spell:2458} a nivel 30 y un hacha, espada o martillo de guerra de {spell:1680} a nivel 40.",

	-- Step 1: The Islander (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "A nivel 30, {npc:5479}, en {object:2100}, junto a la taberna El Cerdo Borracho, te envía con {npc:6236} en {area:720} en {zone:1413}.",

	-- Step 2: The Islander (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "A nivel 30, {npc:5113}, el instructor de guerreros de {zone:1455}, te envía con {npc:6236} en {area:720} en {zone:1413}.",

	-- Step 3: The Islander (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3354} in the {object:172958} sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "A nivel 30, {npc:3354}, en {object:172958}, te envía con {npc:6236} en {area:720} en {zone:1413}.",

	-- Step 4: The Islander (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "A nivel 30, {npc:3041}, el instructor de guerreros de {zone:1456}, te envía con {npc:6236} en {area:720} en {zone:1413}.",

	-- Step 5: The Islander (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "A nivel 30, {npc:4595}, un instructor de guerreros de {zone:1458}, te envía con {npc:6236} en {area:720} en {zone:1413}.",

	-- Step 6: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Cabalga hacia el sur por la costa desde {area:392} hasta {area:720}. {npc:6236} está junto a la arena: pisa la rejilla para empezar el combate; los retadores llegan de uno en uno y luego {npc:6238} (33).",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Derrota a los retadores y a {npc:6238}",

	-- Step 7: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills · {item:3357} Liferoot · {item:3901} Bloodscalp Tusk · {quest:1714} Essence of the Exile
	["{npc:6176} camps in the south-east of {zone:1416}, above {zone:1424}; his cauldron stands beside him. He asks for a {item:3357}, a {item:3901} and the {quest:1714}, which his cauldron brews from three charms."] = "{npc:6176} acampa en el sureste de {zone:1416}, por encima de {zone:1424}; su caldera está a su lado. Pide una {item:3357}, un {item:3901} y la {quest:1714}, que su caldera prepara con tres talismanes.",

	-- Step 8: The exiles of Arathi
	["The exiles of Arathi"] = "Los exiliados de Arathi",
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Three kinds of elemental exiles roam {zone:1417}: Burning Exiles in the north-west, Thundering Exiles in the middle, Cresting Exiles in the north-east. Each drops its charm."] = "Tres tipos de exiliados elementales recorren {zone:1417}: Exiliados ardientes en el noroeste, Exiliados tronadores en el centro y Exiliados acuosos en el noreste. Cada uno suelta su talismán.",
	-- {item:4479} Burning Charm
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:4479} from the Burning Exiles"] = "{item:4479} de los Exiliados ardientes",
	-- {item:4480} Thundering Charm
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:4480} from the Thundering Exiles"] = "{item:4480} de los Exiliados tronadores",
	-- {item:4481} Cresting Charm
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:4481} from the Cresting Exiles"] = "{item:4481} de los Exiliados acuosos",

	-- Step 9: Essence of the Exile
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["{item:3357}: {skill:182}, or the auction house"] = "{item:3357}: {skill:182} o la casa de subastas",

	-- Step 10: Bloodscalp Tusk
	-- {zone:1434} Stranglethorn Vale · {item:3901} Bloodscalp Tusk
	["The Bloodscalp trolls hold the north-west of {zone:1434}; they drop the {item:3901}."] = "Los trols Sangrapellejo ocupan el noroeste de {zone:1434}; sueltan el {item:3901}.",

	-- Step 11: The Summoning
	-- {quest:1712} Cyclonian · {npc:6176} Bath'rah the Windwatcher · {item:6894} Whirlwind Heart
	["{quest:1712} waits just north of {npc:6176}'s camp and carries the {item:6894}. {quest:1712} is elite: grouping up is advised."] = "{quest:1712} espera justo al norte del campamento de {npc:6176} y lleva el {item:6894}. {quest:1712} es élite: se recomienda ir en grupo.",
	-- {item:6894} Whirlwind Heart · {quest:1712} Cyclonian
	["{item:6894} from {quest:1712}"] = "{item:6894} de {quest:1712}",
}
