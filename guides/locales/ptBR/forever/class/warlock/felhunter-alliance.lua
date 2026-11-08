-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/felhunter-alliance (forever/class/warlock/felhunter-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Alliance)"] = "Caçador Vil (Aliança)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "O caçador vil, o demônio para usar contra lançadores de feitiços, e uma {item:22244} para seus fragmentos.",

	-- Step 1: Seeking Strahad (Stormwind)
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "No nível 30, {npc:6122}, no porão de {object:2164} no {object:2101}, envia você a {npc:6251} em {area:392}.",

	-- Step 2: Seeking Strahad (Ironforge)
	-- {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6120}, in the {object:32383}, sends you to {npc:6251} in {area:392}."] = "No nível 30, {npc:6120}, em {object:32383}, envia você a {npc:6251} em {area:392}.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6294} Krom Stoutarm · {zone:1455} Ironforge
	["{area:392} is a neutral goblin port on the {zone:1413} coast: the boat from {area:35} docks there. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6294} in {zone:1455}."] = "{area:392} é um porto goblin neutro na costa de {zone:1413}: o barco de {area:35} atraca lá. {npc:6251} fica no morro acima da cidade, atrás da cabana dos engenheiros, ao lado da torrezinha dele; {npc:6266} e dois acólitos estão com ele. Ele manda você para {npc:6294}, em {zone:1455}.",

	-- Step 4: Krom Stoutarm
	-- {npc:6294} Krom Stoutarm · {object:32356} Hall of Explorers (no name in this language: may be words) · {quest:1758} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6294} is in the library of the {object:32356}. He wants two lost pieces of the {quest:1758}: one on the {area:287} coast, one in {zone:1441}."] = "{npc:6294} fica na biblioteca do {object:32356}. Ele quer duas peças perdidas do {quest:1758}: uma na costa de {area:287}, outra em {zone:1441}.",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "O tomo é um livrinho cinza-azulado caído na areia de um acampamento de murlocs na costa a sudoeste de {area:271}, perto da beira da água. Seis ou sete murlocs guardam e mais ficam à espreita debaixo d'água: vêm em grupos, então use Medo em um e mantenha seu emissário do caos nos outros. Desça até a água para clicar nele; da encosta, as caixas atrapalham o cursor.",
	-- {item:6931} Moldy Tome · {quest:1802} Tome of the Cabal
	["{item:6931}, from the {quest:1802} on the sand"] = "{item:6931}, de {quest:1802}, na areia",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}, a Horde town: keep clear of its guards. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "A caverna dos centauros se abre nos penhascos ao norte de {area:484}, uma cidade da Horda: fique longe dos guardas. Lá dentro, vá pela direita em cada bifurcação, atravesse a lagoa junto à pequena cachoeira e abra a caixinha escura encostada na parede ao lado de um baú maior: o maior é o errado. Você só consegue abrir enquanto está na missão. Os centauros reaparecem atrás de você na saída.",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, no {object:92423}",

	-- Step 7: Back to Krom Stoutarm
	-- {npc:6294} Krom Stoutarm
	["Back to {npc:6294}"] = "De volta a {npc:6294}",
	-- {npc:6294} Krom Stoutarm · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6294} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "{npc:6294} junta as peças do tomo e entrega {item:7006} a você: guarde, {npc:6251} pega junto com os bastões.",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "Bastões de Canalização",
	-- {area:1036} Angerfang Encampment · {area:150} Menethil Harbor · {area:836} Dun Algaz
	["The Dragonmaw hold {area:1036} in the hills east of the road from {area:150} to {area:836}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "Os Presa do Dragão ocupam {area:1036}, nas colinas a leste da estrada de {area:150} para {area:836}. Só os conjuradores soltam os bastões, quatro mortes em cinco: os Guarda-ossos (nível 27, com ajudantes esqueletos) e os Guarda-sombras (28). Uma trilha íngreme ao norte do curandeiro de espíritos central leva até o acampamento, passando pela maioria dos guerreiros.",
	["Rods of Channeling, from the Dragonmaw casters"] = "Bastões de Canalização, dos conjuradores Presa do Dragão",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "De volta a {npc:6251}, em {area:392}. Quando você aceita, ele desenha o círculo de invocação e os acólitos canalizam um círculo maior sobre ele: espere dentro da torre até os dois terminarem. Depois use {quest:1804} no círculo. O caçador vil (nível 30, não elite) silencia e come mana, e some depois de dois minutos: deixe seu emissário do caos fora, abra de imediato com seu dano ao longo do tempo e deixe o emissário tankar. Se você morrer ou ele vencer, abandone {quest:1795} e pegue de novo com {npc:6251}. Guarde o tomo: {npc:6251} pega de volta.",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "{quest:1804}, no círculo",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "Volte a {npc:6251} em {area:392}. Use o {quest:1804} no círculo de evocação ao lado dele e derrote o caçador vil para vinculá-lo.",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "Os Guarda-ossos e Guarda-sombras Presa do Dragão ocupam as colinas a leste da estrada que cruza o {zone:1437}: eles soltam os bastões.",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "O {item:6931} está na praia a oeste de {area:271}, depois dos acampamentos dos murlocs Rancapina.",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "O {object:92423} está no cânion ao norte de {area:484}.",
	-- ["{area:392} is on the {zone:1413} coast; {npc:6251} stands on the hill in town."] = "{area:392} fica no litoral dos {zone:1413}; {npc:6251} fica na colina da cidade.",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251}: ele vincula o caçador vil a você",
	-- ["{npc:6294} stands in the {object:32356}."] = "{npc:6294} fica em {object:32356}.",
}
