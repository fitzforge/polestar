-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/spellfire-robes (forever/class/mage/spellfire-robes.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest
	["A robe at 15 for Horde mages, from the {zone:1458} and {zone:1421}."] = "Uma toga no nível 15 para magos da Horda, de {zone:1458} e {zone:1421}.",

	-- Step 1: Uthel'nay (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {object:172961} Valley of Spirits (no name in this language: may be words) · {zone:1420} Tirisfal Glades
	["{npc:7311} is one of {zone:1454}'s mage trainers, in {object:173161} in the {object:172961}. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311} é um dos instrutores de mago de {zone:1454}, em {object:173161}, no {object:172961}. Depois pegue o zepelim para {zone:1420} na torre do lado de fora do portão principal de {zone:1454}.",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill · {area:2119} Gallows' End Tavern
	["{npc:2128} is the {area:159} mage trainer, upstairs in the {area:2119}: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:2128} é o instrutor de mago de {area:159}, no andar de cima da {area:2119}: suba as escadas por dentro, a seta não diferencia os andares.",

	-- Step 3: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter (no name in this language: may be words) · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie on the ledge behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:4568} fica no {object:36082}. O {item:7247} e a {item:7308} ficam na saliência atrás dela (ambos voltam 5 minutos depois de alguém pegá-los). Você entrega os dois no final, então guarde-os.",

	-- Step 4: The alchemist shop
	["The alchemist shop"] = "A loja do alquimista",
	-- {item:7308} Cantation of Manifestation · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["Algernon's alchemist shop is in the Apothecarium. Stand on the steps or the bridge outside the shop and read the {item:7308}: up to four invisible Rift Spawns (level 16-17) appear and attack at once, and the city guards do not help. Hit one with a single-target spell and back off over the bridge: the others give up and fade, the one you hit follows. Beat it down on the shop's half of the bridge (past halfway the coffer will not work on it) until it stops fighting and sits stunned under a spiral, use the {item:7247} on it, then click the {item:7292} once it appears on the floor (clicking too early wastes a charge). Three are needed."] = "A loja de alquimia do Algernon fica no Boticário. Fique nos degraus ou na ponte do lado de fora da loja e leia o {item:7308}: até quatro Aparições Etéreas invisíveis (nível 16-17) aparecem e atacam de uma vez, e os guardas da cidade não ajudam. Acerte uma com um feitiço de alvo único e recue pela ponte: as outras desistem e somem, e a que você acertou vem atrás. Bata nela na metade da ponte do lado da loja (depois do meio, o cofre não funciona nela) até ela parar de lutar e ficar atordoada embaixo de uma espiral, use o {item:7247} nela e clique no {item:7292} quando ele aparecer no chão (clicar cedo demais gasta uma carga). São três.",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}, até ficar atordoada",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "{item:7247}, na {npc:6492} atordoada",

	-- Step 5: Back to Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell
	["Back to {npc:4568}"] = "De volta a {npc:4568}",

	-- Step 6: Ambermill
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:279} Dalaran · {item:7293} Dalaran Mana Gem · {item:2589} Linen Cloth · {spell:116} Frostbolt · {area:228} Sepulcher · {area:233} Ambermill · {spell:134} Fire Shield · {spell:2120} Flamestrike · {spell:122} Frost Nova
	-- plural, as words: Dalaran Apprentices = {npc:1867} Dalaran Apprentice
	["Leave the {zone:1458} and follow the road south through {zone:1421}. Every {area:279} human drops a {item:7293} four times in five, and {item:2589} too: the easiest are the Dalaran Apprentices (level 13-14, {spell:116}) on the hills south-east of the {area:228}, either side of the road south; deeper in, the walled town of {area:233} in south-east Silverpine has Watchers (18-19, {spell:134} and {spell:2120}) and Wizards (19-20, {spell:122}) that come back every 4 1/2 minutes and run for help at low health, so pull at the edge. Ten {item:2589} also come from any humanoid or the Undercity Auction House."] = "Saia de {zone:1458} e siga a estrada para o sul por {zone:1421}. Todo humano de {area:279} deixa cair uma {item:7293} quatro vezes em cinco, e {item:2589} também: os mais fáceis são os Aprendizes de Dalaran (nível 13-14, {spell:116}) nas colinas a sudeste de {area:228}, dos dois lados da estrada para o sul; mais para dentro, a vila murada de {area:233}, no sudeste de Pinhaprata, tem Vigias (18-19, {spell:134} e {spell:2120}) e Magos (19-20, {spell:122}) que voltam a cada 4 minutos e meio e fogem atrás de ajuda com pouca vida, então puxe pela borda. Os dez {item:2589} também saem de qualquer humanoide ou da Casa de Leilões da Cidade Baixa.",

	-- Step 7: Josef Gregorian
	-- {zone:1458} Undercity · {npc:4576} Josef Gregorian · {npc:11048} Victor Ward · {npc:11049} Rhiannon Davis · {object:36082} Magic Quarter (no name in this language: may be words) · {quest:1962} Spellfire Robes
	["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop in the {object:36082}. Hand the gems and cloth to {npc:4576} and let the three of them talk for a moment; then {npc:4576} offers {quest:1962}: take it and hand it straight back to him for the robe."] = "De volta a {zone:1458}. {npc:4576}, {npc:11048} e {npc:11049} cuidam da alfaiataria no {object:36082}. Entregue as gemas e o tecido a {npc:4576} e deixe os três conversarem um pouco; depois {npc:4576} oferece {quest:1962}: aceite e entregue de volta a ele na hora para receber as vestes.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Algernon's alchemist shop is in the Apothecarium. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "A loja de alquimia de Algernon fica no Apothecarium. Use a {item:7308} lá para tornar o {npc:6492} visível, subjugue um com seus feitiços e depois use o {item:7247} para lançar um cofre e capturá-lo.",
	-- ["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop in the {object:36082}. Hand the gems and cloth to {npc:4576} and let the three of them talk for a moment; then take {quest:1962} (Forever's quest data has {npc:11049} offering it; if the \"!\" shows over {npc:4576} instead, take it from him) and hand it to {npc:4576} for the robe."] = "De volta à {zone:1458}. {npc:4576}, {npc:11048} e {npc:11049} cuidam da alfaiataria no {object:36082}. Entregue as gemas e o tecido a {npc:4576} e deixe os três conversarem um pouco; depois pegue {quest:1962} (os dados de missão do Forever mostram {npc:11049} oferecendo-a; se o \"!\" aparecer sobre {npc:4576}, pegue com ele) e entregue-a a {npc:4576} para receber as vestes.",
	-- ["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop."] = "De volta a {zone:1458}. {npc:4576}, {npc:11048} e {npc:11049} cuidam da loja do alfaiate.",
	-- ["Humanoids drop {item:2589}; the Undercity Auction House sells it."] = "Humanoides deixam cair {item:2589}; a Casa de Leilões da Cidade Baixa vende.",
	-- ["Leave the {zone:1458} and follow the road south through {zone:1421}. The {area:279} mages hold {area:233}, south-east of the {area:228}; every {npc:1867}, Mage, Protector, Warder, Conjuror, Watcher and Wizard can drop a {item:7293}."] = "Saia de {zone:1458} e siga a estrada para o sul por {zone:1421}. Os magos de {area:279} ocupam {area:233}, a sudeste do {area:228}; todo {npc:1867}, Mago, Protetora, Guardião, Conjurador, Vigia e Teurgo pode deixar cair uma {item:7293}.",
	-- ["{npc:2128} is the {area:159} mage trainer."] = "{npc:2128} é o instrutor de mago de {area:159}.",
	-- ["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:4568} fica no {object:36082}. O {item:7247} e a {item:7308} ficam atrás dela.",
}
