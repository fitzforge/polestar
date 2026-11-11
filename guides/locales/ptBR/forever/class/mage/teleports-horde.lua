-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/teleports-horde (forever/class/mage/teleports-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Horde)"] = "Teleportes e Portais (Horda)",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "Os teleportes para as cidades nos níveis 20 e 30 e os portais de grupo nos níveis 40 e 50, com o instrutor de portais de cada cidade.",

	-- Step 1: Teleport: Orgrimmar
	-- {object:173161} Darkbriar Lodge (no name in this language: may be words) · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits (no name in this language: may be words) · {npc:5958} Thuul · {spell:3567} Teleport: Orgrimmar · {item:17031} Rune of Teleportation
	["At 20 go to {object:173161} in {zone:1454}'s {object:172961}, where the mage trainers live. {npc:5958}, the portal trainer, stands on the upper floor and teaches {spell:3567} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor), so carry a few."] = "No nível 20, vá a {object:173161}, no {object:172961} de {zone:1454}, onde moram os instrutores de mago. {npc:5958}, o instrutor de portais, fica no andar de cima e ensina {spell:3567} por 20 pratas. Cada teleporte gasta uma {item:17031} (10 pratas em qualquer vendedor de reagentes), então leve algumas.",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}, 10 pratas cada",

	-- Step 2: Teleport: Undercity
	-- {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {object:36082} Magic Quarter (no name in this language: may be words) · {spell:3563} Teleport: Undercity · {npc:4575} Hannah Akeley
	["Take the zeppelin from the tower outside {zone:1454}'s gate to {zone:1420} and walk into the {zone:1458}. {npc:2492}, the portal trainer, stands in the {object:36082} with the mage trainers: {spell:3563}, 20 silver. {npc:4575} beside him sells the runes."] = "Pegue o zepelim da torre fora do portão de {zone:1454} até {zone:1420} e entre na {zone:1458}. {npc:2492}, o instrutor de portais, fica no {object:36082} com os instrutores de mago: {spell:3563}, 20 pratas. {npc:4575}, ao lado dele, vende as runas.",

	-- Step 3: Teleport: Thunder Bluff
	-- {zone:1456} Thunder Bluff · {zone:1412} Mulgore · {zone:1454} Orgrimmar · {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {spell:3566} Teleport: Thunder Bluff
	["At 30. {zone:1456} is in {zone:1412}: fly there from {zone:1454} or the Crossroads. {npc:5957}, the portal trainer, stands with the mage trainers in the {area:2197}, the cave under {area:1640}: go down inside, the arrow cannot tell the floors apart. She teaches {spell:3566} for 80 silver."] = "No nível 30. {zone:1456} fica em {zone:1412}: voe até lá de {zone:1454} ou da Encruzilhada. {npc:5957}, a instrutora de portais, fica com os instrutores de mago em {area:2197}, a caverna sob {area:1640}: desça por dentro, a seta não diferencia os andares. Ela ensina {spell:3566} por 80 pratas.",

	-- Step 4: Portals to Orgrimmar and the Undercity
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Portals to {zone:1454} and the {zone:1458}"] = "Portais para {zone:1454} e {zone:1458}",
	-- {item:17032} Rune of Portals · {npc:5958} Thuul · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {spell:11417} Portal: Orgrimmar · {zone:1458} Undercity · {npc:2492} Lexington Mortaim · {spell:11418} Portal: Undercity
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:5958} in {object:173161} has {spell:11417}; teleport to the {zone:1458} for {npc:2492}'s {spell:11418}."] = "No nível 40, os instrutores de portais ensinam os portais: uma passagem que o grupo inteiro pode atravessar, por 1 ouro e 50 pratas cada. Cada portal gasta uma {item:17032} (20 pratas em qualquer vendedor de reagentes). {npc:5958}, em {object:173161}, tem {spell:11417}; teletransporte-se para a {zone:1458} e pegue {spell:11418} com {npc:2492}.",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}, 20 pratas cada",

	-- Step 5: Portal: Thunder Bluff
	-- {npc:5957} Birgitte Cranston · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {spell:11420} Portal: Thunder Bluff · {spell:3566} Teleport: Thunder Bluff
	["At 50 {npc:5957}, down in the {area:2197} under {area:1640} in {zone:1456}, teaches the last one, {spell:11420}, for 3 gold 20 silver. Use your {spell:3566} to get there."] = "No nível 50, {npc:5957}, lá embaixo em {area:2197}, sob {area:1640}, em {zone:1456}, ensina o último, {spell:11420}, por 3 ouros e 20 pratas. Use o seu {spell:3566} para chegar lá.",
}
