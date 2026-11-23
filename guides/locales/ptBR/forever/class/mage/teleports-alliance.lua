-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/teleports-alliance (forever/class/mage/teleports-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Alliance)"] = "Teleportes e Portais (Aliança)",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "Os teleportes para as cidades nos níveis 20 e 30 e os portais de grupo nos níveis 40 e 50, com o instrutor de portais de cada cidade.",

	-- Step 1: Teleport: Stormwind
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:2485} Larimaine Purdue · {spell:3561} Teleport: Stormwind · {item:17031} Rune of Teleportation · {npc:1308} Owen Vaughn
	["At 20 go to the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:2485}, the portal trainer, stands at the very top: climb the spiral ramp and take the portal near the top. She teaches {spell:3561} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor; {npc:1308} sells them at the foot of the tower), so carry a few."] = "No nível 20, vá ao Sacrário dos Teurgos, a torre violeta do {object:2101} de {zone:1453}. {npc:2485}, a instrutora de portais, fica lá no topo: suba a rampa em espiral e pegue o portal perto do topo. Ela ensina {spell:3561} por 20 pratas. Cada teleporte gasta uma {item:17031} (10 pratas em qualquer mercador de reagentes; {npc:1308} vende no pé da torre), então leve algumas.",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}, 10 pratas cada",

	-- Step 2: Teleport: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:2489} Milstaff Stormeye · {object:32362} Mystic Ward (no name in this language: may be words) · {spell:3562} Teleport: Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455}. {npc:2489}, the portal trainer, stands with the mage trainers in the {object:32362} at the back of the city: {spell:3562}, 20 silver."] = "Pegue o {area:2257} do {object:28027} de {zone:1453} até {zone:1455}. {npc:2489}, o instrutor de portais, fica com os instrutores de mago na {object:32362}, nos fundos da cidade: {spell:3562}, 20 pratas.",

	-- Step 3: Teleport: Darnassus
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:4165} Elissa Dumas · {spell:3565} Teleport: Darnassus
	["At 30. Take the boat from {area:17203} to {area:442} in {zone:1439}, then the boat to {area:702} and the pink portal up into {zone:1457}. {npc:4165}, the portal trainer, teaches {spell:3565} for 80 silver."] = "No nível 30. Pegue o barco de {area:17203} para {area:442}, em {zone:1439}, depois o barco para {area:702} e o portal rosa até {zone:1457}. {npc:4165}, a instrutora de portais, ensina {spell:3565} por 80 pratas.",

	-- Step 4: Portals to Stormwind and Ironforge
	-- {zone:1453} Stormwind · {zone:1455} Ironforge
	["Portals to {zone:1453} and {zone:1455}"] = "Portais para {zone:1453} e {zone:1455}",
	-- {item:17032} Rune of Portals · {npc:2485} Larimaine Purdue · {spell:10059} Portal: Stormwind · {npc:2489} Milstaff Stormeye · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {spell:11416} Portal: Ironforge
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:2485} has {spell:10059} at the top of the Wizard's Sanctum; then the tram to {npc:2489} in {zone:1455}'s {object:32362} for {spell:11416}."] = "No nível 40, os instrutores de portais ensinam os portais: uma passagem que o grupo inteiro pode atravessar, por 1 ouro e 50 pratas cada. Cada portal gasta uma {item:17032} (20 pratas em qualquer vendedor de reagentes). {npc:2485} tem {spell:10059} no alto do Sacrário dos Teurgos; depois, o bondinho até {npc:2489}, na {object:32362} de {zone:1455}, para {spell:11416}.",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}, 20 pratas cada",

	-- Step 5: Portal: Darnassus
	-- {npc:4165} Elissa Dumas · {zone:1457} Darnassus · {spell:11419} Portal: Darnassus · {spell:3565} Teleport: Darnassus
	["At 50 {npc:4165} in {zone:1457} teaches the last one, {spell:11419}, for 3 gold 20 silver. Use your {spell:3565} to get there."] = "No nível 50, {npc:4165}, em {zone:1457}, ensina o último, {spell:11419}, por 3 ouros e 20 pratas. Use o seu {spell:3565} para chegar lá.",
}
