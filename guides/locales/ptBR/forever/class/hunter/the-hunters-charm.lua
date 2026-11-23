-- Portuguese (Brazil) (ptBR): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Classic's item choice may be gone on Forever."] = "Experiência no nível 50 por {zone:1447} e {area:1417}; a escolha de item do Classic pode não existir no Forever.",
	["Experience"] = "Experiência",

	-- Step 1: The Hunter's Charm (Alliance)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Alliance)"] = "{quest:8151} (Aliança)",
	-- {npc:5516} Ulfir Ironbeard · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1457} Darnassus
	["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' Cenarion Enclave."] = "No nível 50, qualquer instrutor de caçador da Aliança a oferece: {npc:5516} no {object:28027} de {zone:1453}, {npc:5116} no {object:32390} de {zone:1455} ou Dorion no Enclave Cenariano de {zone:1457}.",

	-- Step 2: The Hunter's Charm (Horde)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Horde)"] = "{quest:8151} (Horda)",
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {zone:1456} Thunder Bluff
	["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {area:1641} in {zone:1456}."] = "No nível 50, qualquer instrutor de caçador da Horda a oferece: {npc:3352} no {object:172958} de {zone:1454} ou {npc:3039} no {area:1641} em {zone:1456}.",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {zone:1447} Azshara · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives on a raised spot on the cliffs at the north-east rim of the {area:1221}, west-central {zone:1447}. Keep to the high ridges around the ruins: the pit below does not lead up to him. Alliance: fly to {area:3137}; Horde: fly to {area:1237}, a short ride west of him."] = "{npc:8405} mora num ponto alto dos penhascos na borda nordeste de {area:1221}, no centro-oeste de {zone:1447}. Fique pelas cristas altas em volta das ruínas: o buraco lá embaixo não sobe até ele. Aliança: voe para {area:3137}; Horda: voe para {area:1237}, a uma curta cavalgada a oeste dele.",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara · {area:1220} Thalassian Base Camp · {area:1237} Valormok · {area:1234} Lake Mennar
	-- plural, as words: Perfect Courser Antlers = {item:20017} Perfect Courser Antler · Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["You need two Perfect Courser Antlers. Mosshoof Coursers (level 52-53, deer) graze all over {zone:1447} and drop one about one kill in twelve, so expect two dozen kills. Good herds: north of the {area:1220} in the north, and the hills north-east and south-east of {area:1237}; the {area:1234} area also has elite giants and dragonkin. They Enrage at 30% health. Coursers share spawn points with the Thunderhead hippogryphs: if none are around, kill the hippogryphs and coursers may spawn instead. Respawn is about five and a half minutes."] = "Você precisa de duas Galhadas Perfeitas de Ginete. Os Ginetes Cascomusgo (nível 52-53, cervos) pastam por toda {zone:1447} e deixam cair uma mais ou menos a cada doze abates, então conte com umas duas dúzias. Boas manadas: ao norte de {area:1220}, no norte, e as colinas a nordeste e sudeste de {area:1237}; a área de {area:1234} também tem gigantes e dracônicos elite. Eles se enfurecem com 30% de vida. Os ginetes dividem os pontos de surgimento com os hipogrifos Cabeça-de-trovão: se não tiver nenhum por perto, mate os hipogrifos e podem nascer ginetes no lugar. Renascem em uns cinco minutos e meio.",
	-- {item:20017} Perfect Courser Antler
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["{item:20017}, from Mosshoof Coursers"] = "{item:20017}, dos Ginetes Cascomusgo",

	-- Step 6: Wavethrashing
	-- {item:20087} Wavethrasher Scales · {zone:1447} Azshara · {area:1229} Tower of Eldara · {spell:1494} Track Beasts
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["You need six {item:20087}. Wavethrashers (three-headed sea beasts) live along {zone:1447}'s coasts, mostly underwater: the Young Wavethrashers (level 51-52) of the north-east shore drop a scale about one kill in three, the Wavethrashers (52-53) of the east coast by the {area:1229} about as often (a few walk the beach there), the Great Wavethrashers (53-54) of the south-east shore about one in seven. {spell:1494} does not show them; fight them where you can breathe, and bring water breathing if you can. Elite sharks swim the deeper water."] = "Você precisa de seis {item:20087}. Os Fura-ondas (feras marinhas de três cabeças) vivem pelas costas de {zone:1447}, quase sempre debaixo d'água: os Jovens Fura-ondas (nível 51-52) da costa nordeste deixam cair uma escama mais ou menos a cada três abates, os Fura-ondas (52-53) da costa leste perto de {area:1229} mais ou menos o mesmo (alguns andam pela praia lá), e os Grandes Fura-ondas (53-54) da costa sudeste uma a cada sete. {spell:1494} não mostra eles; lute onde der para respirar e, se puder, leve algo de respiração aquática. Tubarões elite nadam nas águas mais fundas.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz no {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {area:75} Stonard · {area:1438} Nethergarde Keep · {area:42} Darkshire · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:11019} Wing Flap
	["Morphaz is an elite green drake (level 52) inside the {area:1417}, a five-player dungeon: needs a group of five. The temple stands in the {area:74} in eastern {zone:1435}: climb its outer steps, dive into the flooded hall and follow the stairs down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} or {area:42} and ride on. He is not there when you arrive: first kill the six troll guardians on the platforms around the upper ring, which opens the way down to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe (pull them one at a time); when both are dead, Morphaz and Hazzas appear together and cannot be split. Clear the dragonkin around the pit first, because they call for help. Morphaz uses {spell:12533} and {spell:11019}. The tooth always drops. Warriors in the group may want the same run for the voodoo feathers of the balcony trolls."] = "Morphaz é um draco verde elite (nível 52) dentro de {area:1417}, uma masmorra de cinco jogadores: pede um grupo de cinco. O templo fica em {area:74}, no leste de {zone:1435}: suba a escadaria de fora, mergulhe no salão alagado e siga as escadas até a entrada. Horda: voe para {area:75}; Aliança: voe para {area:1438} ou {area:42} e siga cavalgando. Ele não está lá quando você chega: primeiro mate os seis guardiões troll nas plataformas em volta do anel de cima, o que abre o caminho até {npc:5710}, no Fosso do Sacrifício. A morte de Jammal'an solta dois dracos, Tecelão e Darquimeros (puxe um de cada vez); quando os dois morrem, Morphaz e Hazzas aparecem juntos e não dá para separar. Limpe os dracônicos em volta do fosso antes, porque eles chamam ajuda. Morphaz usa {spell:12533} e {spell:11019}. O dente sempre cai. Guerreiros do grupo talvez queiram a mesma corrida pelas penas de vodu dos trolls da sacada.",
	-- {item:20019} Tooth of Morphaz · {area:1417} Sunken Temple
	["{item:20019}, inside the {area:1417}"] = "{item:20019}, dentro do {area:1417}",

	-- Step 9: The Green Drake
	-- {item:19991} Devilsaur Eye · {item:19992} Devilsaur Tooth · {item:20083} Hunting Spear
	["In Classic Ogtinc let you choose the {item:19991}, the {item:19992} or the {item:20083} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "No Classic, o Ogtinc deixava você escolher aqui o {item:19991}, o {item:19992} ou a {item:20083}. As notas de mudança do Forever dizem que a escolha acabou, mas a página da missão ainda lista três recompensas sem nome: olhe a janela de recompensa antes de entregar.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Experiência no nível 50 por {zone:1447} e o {area:1417}; o Forever removeu a escolha de item do Classic.",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz é um chefe dragão de elite dentro do {area:1417}, uma masmorra de cinco jogadores: leve um grupo. O templo fica no meio do {area:74}; mergulhe nele para chegar à entrada. Horda: voe até {area:75}; Aliança: voe até {area:42} ou {area:1438} e siga cavalgando.",
	-- ["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "Ginetes Cascomusgo pastam por todo {zone:1447}; mais ou menos um em cada doze deixa cair um par de Galhadas Perfeitas de Ginete.",
	-- ["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "Fura-ondas rastejam pelas costas de {zone:1447}: Jovens Fura-ondas na margem nordeste e Fura-ondas na costa leste deixam cair as escamas cerca de duas vezes mais que os Grandes Fura-ondas da margem sul.",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} vive no alto dos penhascos a nordeste das {area:1221}. Aliança: voe até o {area:3137}; Horda: voe até {area:1237}.",
}
