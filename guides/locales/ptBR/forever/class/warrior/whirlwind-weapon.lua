-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/whirlwind-weapon (forever/class/warrior/whirlwind-weapon.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2458} Berserker Stance · {spell:1680} Whirlwind
	["{spell:2458} at 30 and a {spell:1680} axe, sword or warhammer at 40."] = "{spell:2458} no nível 30 e um machado, espada ou martelo de guerra de {spell:1680} no nível 40.",

	-- Step 1: The Islander (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "No nível 30, {npc:5479}, em {object:2100}, ao lado da Porco e Apito, envia você a {npc:6236} na {area:720}, em {zone:1413}.",

	-- Step 2: The Islander (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "No nível 30, {npc:5113}, o instrutor de guerreiros de {zone:1455}, envia você a {npc:6236} na {area:720}, em {zone:1413}.",

	-- Step 3: The Islander (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3354} in the {object:172958} sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "No nível 30, {npc:3354}, no {object:172958}, envia você a {npc:6236} na {area:720}, em {zone:1413}.",

	-- Step 4: The Islander (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "No nível 30, {npc:3041}, o instrutor de guerreiros de {zone:1456}, envia você a {npc:6236} na {area:720}, em {zone:1413}.",

	-- Step 5: The Islander (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "No nível 30, {npc:4595}, um instrutor de guerreiros de {zone:1458}, envia você a {npc:6236} na {area:720}, em {zone:1413}.",

	-- Step 6: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Siga para o sul pela costa de {area:392} até a {area:720}. {npc:6236} fica junto à arena: pise na grade para iniciar a luta; os desafiantes vêm um de cada vez, depois {npc:6238} (33).",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Derrote os desafiantes e {npc:6238}",

	-- Step 7: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {zone:1424} Hillsbrad Foothills · {item:3357} Liferoot · {item:3901} Bloodscalp Tusk · {quest:1714} Essence of the Exile
	["{npc:6176} camps in the south-east of {zone:1416}, above {zone:1424}; his cauldron stands beside him. He asks for a {item:3357}, a {item:3901} and the {quest:1714}, which his cauldron brews from three charms."] = "{npc:6176} acampa no sudeste de {zone:1416}, acima de {zone:1424}; o caldeirão dele fica ao lado. Ele pede uma {item:3357}, uma {item:3901} e a {quest:1714}, que o caldeirão prepara com três patuás.",

	-- Step 8: The exiles of Arathi
	["The exiles of Arathi"] = "Os exilados de Arathi",
	-- {zone:1417} Arathi Highlands
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Three kinds of elemental exiles roam {zone:1417}: Burning Exiles in the north-west, Thundering Exiles in the middle, Cresting Exiles in the north-east. Each drops its charm."] = "Três tipos de exilados elementais vagam por {zone:1417}: Exilados em Chamas no noroeste, Exilados Trovejantes no centro e Exilados Vagalhantes no nordeste. Cada um deixa cair seu patuá.",
	-- {item:4479} Burning Charm
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:4479} from the Burning Exiles"] = "{item:4479} dos Exilados em Chamas",
	-- {item:4480} Thundering Charm
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:4480} from the Thundering Exiles"] = "{item:4480} dos Exilados Trovejantes",
	-- {item:4481} Cresting Charm
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:4481} from the Cresting Exiles"] = "{item:4481} dos Exilados Vagalhantes",

	-- Step 9: Essence of the Exile
	-- {item:3357} Liferoot · {skill:182} Herbalism
	["{item:3357}: {skill:182}, or the auction house"] = "{item:3357}: {skill:182} ou a casa de leilões",

	-- Step 10: Bloodscalp Tusk
	-- {zone:1434} Stranglethorn Vale · {item:3901} Bloodscalp Tusk
	["The Bloodscalp trolls hold the north-west of {zone:1434}; they drop the {item:3901}."] = "Os trolls Sanguescalpo dominam o noroeste de {zone:1434}; eles deixam cair a {item:3901}.",

	-- Step 11: The Summoning
	-- {quest:1712} Cyclonian · {npc:6176} Bath'rah the Windwatcher · {item:6894} Whirlwind Heart
	["{quest:1712} waits just north of {npc:6176}'s camp and carries the {item:6894}. {quest:1712} is elite: grouping up is advised."] = "{quest:1712} espera logo ao norte do acampamento de {npc:6176} e carrega o {item:6894}. {quest:1712} é Elite: recomenda-se formar um grupo.",
	-- {item:6894} Whirlwind Heart · {quest:1712} Cyclonian
	["{item:6894} from {quest:1712}"] = "{item:6894} de {quest:1712}",
}
