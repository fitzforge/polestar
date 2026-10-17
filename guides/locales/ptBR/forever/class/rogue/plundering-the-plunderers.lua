-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/plundering-the-plunderers (forever/class/rogue/plundering-the-plunderers.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7676} Thistle Tea
	["Ten {item:7676}, the rogue energy drink, from the Horde lockpicking jobs at 16."] = "Dez {item:7676}, a bebida de energia dos ladinos, dos trabalhos de arrombamento da Horda no nível 16.",

	-- Step 1: To Orgrimmar!
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {npc:3401} Shenthul · {zone:1454} Orgrimmar
	["At 16 {npc:3170}, the rogue trainer in {area:362}, sends you to {npc:3401} in {zone:1454}."] = "No nível 16, {npc:3170}, o instrutor de ladinos em {area:362}, manda você até {npc:3401} em {zone:1454}.",

	-- Step 2: Find the Shattered Hand
	-- {npc:6467} Mennet Carkad · {object:36073} Rogues' Quarter (no name in this language: may be words) · {npc:3401} Shenthul · {zone:1454} Orgrimmar · {quest:1998} Fenwick Thatros · {zone:1421} Silverpine Forest
	["At 16 {npc:6467} in the {object:36073} sends you to {npc:3401} in {zone:1454}. Take {quest:1998} from him too; it is done in {zone:1421} at the end of this guide."] = "No nível 16, {npc:6467} no {object:36073} manda você até {npc:3401} em {zone:1454}. Pegue também {quest:1998} com ele; ela é feita em {zone:1421} no fim deste guia.",

	-- Step 3: Shenthul and Zando'zan
	-- {npc:3401} Shenthul · {quest:2379} Zando'zan
	["{npc:3401} and {quest:2379}"] = "{npc:3401} e {quest:2379}",
	-- {zone:1458} Undercity · {zone:1411} Durotar · {npc:3401} Shenthul · {quest:2379} Zando'zan · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words)
	["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}."] = "Mortos-vivos pegam o zepelim nas torres do lado de fora de {zone:1458} para {zone:1411}. {npc:3401} e {quest:2379} ficam na {object:172960}, o cânion abaixo do {object:172982}.",

	-- Step 4: Wrenix the Wretched
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:7161} Wrenix the Wretched · {item:7970} E.C.A.C. · {item:5060} Thieves' Tools
	["Fly or ride to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "Voe ou cavalgue até {area:392}, no litoral dos {zone:1413}. {npc:7161} fica na cidade com seu Aparato Mercadotrônico: compre um {item:7970} e {item:5060} no aparato antes de ir.",

	-- Step 5: Southsea Treasure
	-- {area:392} Ratchet · {item:7970} E.C.A.C.
	["South along the coast from {area:392}, at the Southsea pirates' camp. If an unusually hostile parrot attacks you, use the {item:7970} on it (the quest's own advice)."] = "Ao sul pelo litoral a partir de {area:392}, no acampamento dos piratas dos Mares do Sul. Se um papagaio estranhamente hostil atacar você, use o {item:7970} nele (o conselho da própria missão).",

	-- Step 6: Back to Wrenix the Wretched
	-- {npc:7161} Wrenix the Wretched
	["Back to {npc:7161}"] = "De volta a {npc:7161}",
	-- {npc:7161} Wrenix the Wretched · {item:7676} Thistle Tea
	["{npc:7161}: ten {item:7676}"] = "{npc:7161}: dez {item:7676}",

	-- Step 7: Fenwick Thatros
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {quest:1998} Fenwick Thatros · {area:228} Sepulcher
	["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "Pegue o zepelim de {zone:1454} para {zone:1458} e cavalgue para o sul até a Floresta de Pinhaprata. {quest:1998} fica a nordeste de {area:228}.",

	-- Step 9: Ambermill
	-- {area:233} Ambermill · {object:103815} Ambermill Strongbox
	["The Kirin Tor keep their reports at {area:233}, in south-east Silverpine: pick the lock on the {object:103815}."] = "O Kirin Tor guarda seus relatórios em {area:233}, no sudeste da Floresta de Pinhaprata: arrombe a fechadura do {object:103815}.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "De volta a {npc:6467}",
}
