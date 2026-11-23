-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/voidwalker-horde (forever/class/warlock/voidwalker-horde.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Horde)"] = "Emissário do Caos (Horda)",
	["Your tank demon at 10: the voidwalker, after a stolen book and a fight at a summoning circle."] = "Seu demônio tanque no nível 10: o emissário do caos, depois de um livro roubado e de uma luta num círculo de invocação.",

	-- Step 1: Gan'rul's Summons (Orcs and Trolls)
	-- {quest:1506} Gan'rul's Summons
	["{quest:1506} (Orcs and Trolls)"] = "{quest:1506} (Orcs e Trolls)",
	-- {npc:3294} Ophek · {npc:5875} Gan'rul Bloodeye · {area:362} Razor Hill · {npc:3172} Dhugru Gorelust · {object:172960} Cleft of Shadow (no name in this language: may be words) · {zone:1454} Orgrimmar · {object:172982} Valley of Strength (no name in this language: may be words) · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:5724} Ageron Kargal · {area:159} Brill
	["At 10 {npc:3294} sends you to {npc:5875}. He stands outside at the back of {area:362}'s barracks, the big building on the east side of town (not the inn), a few steps from {npc:3172}, the warlock trainer. {npc:5875} stands with the senior warlocks in the {object:172960}, the cavern under {zone:1454}'s {object:172982}. An Orc or Troll leveling in {zone:1420} can take the {zone:1458} version from {npc:5724} in {area:159} instead (the {zone:1458} steps below): you can do only one of the two."] = "No nível 10, {npc:3294} manda você a {npc:5875}. Ele fica do lado de fora, nos fundos do quartel de {area:362}, o prédio grande no lado leste da cidade (não a estalagem), a poucos passos de {npc:3172}, o instrutor de bruxo. {npc:5875} fica com os bruxos mais experientes na {object:172960}, a caverna sob o {object:172982} de {zone:1454}. Um Orc ou Troll subindo de nível em {zone:1420} pode pegar a versão da {zone:1458} com {npc:5724} em {area:159} (as etapas da {zone:1458} abaixo): você só pode fazer uma das duas.",

	-- Step 2: Skull Rock
	-- {area:817} Skull Rock · {zone:1454} Orgrimmar · {object:58595} Burning Blade Stash · {npc:3204} Gazz'uz
	-- plural, as words: Burning Blade Apprentices = {npc:3198} Burning Blade Apprentice
	["{area:817} is the cave in the cliffs just east of {zone:1454}'s gate. Inside, take the right-hand ramp up and follow it to the top: the {object:58595} sits on that upper ledge, which cannot be reached from the lower floor. The cave is packed with Burning Blade Apprentices and Fanatics (level 9-11, many with voidwalkers) that respawn quickly, and {npc:3204}, a level 14 Burning Blade warlock, stands near the stash. Old notes call him elite; Forever's data lists him as normal. At 10 it is hard alone: pull one pack at a time and Fear the extra, wait for 11, or go with a friend. The stash always holds the tablet."] = "{area:817} é a caverna nos penhascos logo a leste do portão de {zone:1454}. Lá dentro, suba a rampa da direita e siga até o topo: {object:58595} fica nessa saliência de cima, que não dá para alcançar pelo andar de baixo. A caverna está cheia de Aprendizes e Fanáticos da Lâmina Ardente (nível 9-11, muitos com emissários do caos) que voltam rápido, e {npc:3204}, um bruxo da Lâmina Ardente de nível 14, fica perto do esconderijo. As notas antigas o chamam de elite; os dados do Forever o listam como normal. No 10, é difícil sozinho: puxe um grupo de cada vez e use Medo no extra, espere o 11, ou vá com um amigo. O esconderijo sempre guarda a tábua.",
	-- {item:6535} Tablet of Verga · {object:58595} Burning Blade Stash
	["{item:6535}, in the {object:58595}"] = "{item:6535}, em {object:58595}",

	-- Step 3: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {item:7464} Glyphs of Summoning · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:3216} Neeru Fireblade · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5875}. He hands you the {item:7464}: take them across the {object:172960} to {npc:3216}'s tent, stand on the purple circle on its floor and use them. The voidwalker (level 10, not elite) hits hard at 30% health and leaves after three minutes, so start at once: {spell:14868}, Corruption and {spell:348}, send your imp in, and Fear it when you need a breather. If it beats you or leaves, the glyphs are not used up: use them again on the circle. Keep the glyphs: {npc:5875} takes them back."] = "De volta a {npc:5875}. Ele entrega {item:7464}: leve-os pela {object:172960} até a tenda de {npc:3216}, fique no círculo roxo no chão dela e use-os. O emissário do caos (nível 10, não elite) bate forte com 30% de vida e vai embora depois de três minutos, então comece na hora: {spell:14868}, Corrupção e {spell:348}, mande seu diabrete e use Medo nele quando precisar de fôlego. Se ele vencer você ou for embora, os glifos não se esgotam: use-os de novo no círculo. Guarde os glifos: {npc:5875} os pega de volta.",
	-- {item:7464} Glyphs of Summoning
	["{item:7464}, on the circle in Neeru's tent"] = "{item:7464}, no círculo da tenda de Neeru",

	-- Step 4: Halgar's Summons (Undercity)
	-- {npc:5724} Ageron Kargal · {area:2119} Gallows' End Tavern · {area:159} Brill · {npc:5675} Carendin Halgar · {zone:1420} Tirisfal Glades · {npc:5875} Gan'rul Bloodeye · {zone:1458} Undercity · {object:36082} Magic Quarter (no name in this language: may be words)
	["At 10 {npc:5724}, upstairs in the {area:2119} in {area:159}, sends you to {npc:5675}: the version for the Undead, and for Orcs and Trolls who level in {zone:1420} instead of taking {npc:5875}'s. {npc:5675} stands in the {zone:1458}'s {object:36082}, by the Temple of the Damned."] = "No nível 10, {npc:5724}, no andar de cima da {area:2119} em {area:159}, manda você a {npc:5675}: a versão para os Mortos-vivos, e para Orcs e Trolls que sobem de nível em {zone:1420} em vez de pegar a de {npc:5875}. {npc:5675} fica no {object:36082} da {zone:1458}, junto ao Temple of the Damned.",
	-- {npc:5724} Ageron Kargal · {area:159} Brill
	["{npc:5724}, upstairs in the {area:159} inn"] = "{npc:5724}, no andar de cima da estalagem de {area:159}",

	-- Step 5: Perrine's Chest
	-- {zone:1458} Undercity · {area:154} Deathknell · {npc:1662} Captain Perrine · {npc:1537} Scarlet Zealot
	["The Scarlet tower stands in the fields west of the {zone:1458}'s ruins (not the tower near {area:154}). The grimoire is in the small chest on the ground floor, under the stairs; ignore the chest upstairs. {npc:1662} (level 9) and a {npc:1537} guard it: kill them, or Fear the zealot while you deal with Perrine. Scarlet Missionaries and Zealots (level 7-9) walk the fields around the tower. The chest is back three seconds after anyone opens it."] = "A torre Escarlate fica nos campos a oeste das ruínas da {zone:1458} (não a torre perto de {area:154}). O grimório está no baú pequeno do térreo, embaixo da escada; ignore o baú do andar de cima. {npc:1662} (nível 9) e um {npc:1537} guardam: mate-os, ou use Medo no fanático enquanto cuida de Perrine. Missionários e Fanáticos Escarlates (nível 7-9) andam pelos campos em volta da torre. O baú volta três segundos depois de qualquer um abri-lo.",
	-- {item:6285} Egalin's Grimoire · {object:37098} Perrine's Chest
	["{item:6285}, in {object:37098}"] = "{item:6285}, em {object:37098}",

	-- Step 6: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {item:6284} Runes of Summoning · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5675}. He hands you the {item:6284}: go down the stairs from him to the summoning circle and use them while standing on it. Fight the voidwalker (level 10, not elite) on the circle: if it wanders off, the city guards may kill it and the kill does not count. {spell:14868}, Corruption and {spell:348} with your imp tanking bring it down; it hits harder below 30%. If you lose, use the runes again. Keep the runes: {npc:5675} takes them back."] = "De volta a {npc:5675}. Ele entrega {item:6284} a você: desça as escadas dele até o círculo de invocação e use enquanto estiver em cima dele. Lute com o emissário do caos (nível 10, não elite) no círculo: se ele se afastar, os guardas da cidade podem matá-lo e a morte não conta. {spell:14868}, Corrupção e {spell:348} com seu diabrete tankando derrubam ele; bate mais forte abaixo de 30%. Se perder, use as runas de novo. Guarde as runas: {npc:5675} pega de volta.",
	-- {item:6284} Runes of Summoning · {npc:5675} Carendin Halgar
	["{item:6284}, on the circle below {npc:5675}"] = "{item:6284}, no círculo embaixo de {npc:5675}",
}
