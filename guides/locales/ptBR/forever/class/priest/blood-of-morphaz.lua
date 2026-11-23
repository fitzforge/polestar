-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/blood-of-morphaz (forever/class/priest/blood-of-morphaz.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["17,060 XP and 1g55s at 50: {zone:1447}, then Morphaz in the {area:1417} (group of 5). The item choice may be gone."] = "17.060 XP e 1g55s no nível 50: {zone:1447}, depois Morphaz em {area:1417} (grupo de 5). A escolha do item pode ter sumido.",
	["17,060 experience and 1 gold 55 silver"] = "17.060 de experiência e 1 ouro 55 pratas",

	-- Step 1: Cenarion Aid: High Priest Rohan
	-- {zone:1455} Ironforge · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {quest:8254} Cenarion Aid · {item:7972} Ichor of Undeath
	["At 50 in {zone:1455}, {npc:11406} in the {object:32386} ({object:32362}) offers {quest:8254}. Before you leave a city, buy an {item:7972} at the Auction House (a few silver): the third quest asks for one and it drops rarely."] = "No nível 50, em {zone:1455}, {npc:11406}, no {object:32386} ({object:32362}), oferece {quest:8254}. Antes de sair de uma cidade, compre um {item:7972} na Casa de Leilões (umas poucas pratas): a terceira missão pede um e ele cai raramente.",

	-- Step 2: Cenarion Aid: Brother Joshua
	-- {npc:5489} Brother Joshua · {zone:1453} Stormwind · {quest:8254} Cenarion Aid · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {item:7972} Ichor of Undeath · {object:2096} Trade District
	["At 50, {npc:5489} at the altar of {zone:1453}'s Cathedral of Light offers {quest:8254} ({npc:11406} in {zone:1455} has it too). Before you leave, buy an {item:7972} at the Auction House in the {object:2096} (a few silver): the third quest asks for one and it drops rarely."] = "No nível 50, {npc:5489}, no altar da Catedral da Luz de {zone:1453}, oferece {quest:8254} ({npc:11406}, em {zone:1455}, também tem). Antes de sair, compre uma {item:7972} na Casa de Leilões do {object:2096} (umas poucas pratas): a terceira missão pede uma e ela cai raramente.",

	-- Step 3: Cenarion Aid: Ur'kyo
	-- {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits (no name in this language: may be words) · {quest:8254} Cenarion Aid · {item:7972} Ichor of Undeath
	["At 50, {npc:6018} in {zone:1454}'s {object:172961} offers {quest:8254}. Before you leave, buy an {item:7972} at the Auction House (a few silver): the third quest asks for one and it drops rarely."] = "No nível 50, {npc:6018}, no {object:172961} de {zone:1454}, oferece {quest:8254}. Antes de sair, compre um {item:7972} na Casa de Leilões (umas poucas pratas): a terceira missão pede um e ele cai raramente.",

	-- Step 4: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405}, a furbolg, lives on the clifftop north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}. Ride east and leave the road at the fork before the ruins, then follow the northern cliff edge east to him: the naga ruins and the beach below are walled in by cliffs with no way up."] = "{npc:8405}, um furbolg, mora no topo do penhasco a nordeste de {area:1221}. Aliança: voe para {area:3137}; Horda: voe para {area:1237}. Cavalgue para leste e saia da estrada na bifurcação antes das ruínas; depois siga a borda norte do penhasco, rumo leste, até ele: as ruínas dos nagas e a praia lá embaixo são cercadas de penhascos, sem caminho para subir.",

	-- Step 5: Of Coursers We Know
	-- {zone:1447} Azshara · {npc:8405} Ogtinc · {item:20027} Healthy Courser Gland · {item:7972} Ichor of Undeath
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["Mosshoof Coursers (level 52-53, not elite) graze all over {zone:1447}, thickest north-east of {npc:8405} and south of the mountains; about one in three drops a {item:20027}, so plan on a dozen kills for four. They enrage at 30% health: finish them fast. Killing them costs no Cenarion Circle reputation. Keep any {item:7972} you loot."] = "Os Ginetes Cascomusgo (nível 52-53, não elite) pastam por toda {zone:1447}, mais numerosos a nordeste de {npc:8405} e ao sul das montanhas; cerca de um em cada três solta uma {item:20027}, então conte com uma dúzia de mortes para conseguir quatro. Eles ficam enfurecidos com 30% de vida: acabe com eles rápido. Matá-los não custa reputação com o Círculo Cenariano. Guarde qualquer {item:7972} que pegar.",

	-- Step 7: The Ichor of Undeath
	-- {item:7972} Ichor of Undeath · {npc:7864} Lingering Highborne · {area:1221} Ruins of Eldarath · {npc:8405} Ogtinc · {zone:1447} Azshara · {zone:1440} Ashenvale · {npc:7523} Suffering Highborne · {zone:1452} Winterspring
	["Carrying an {item:7972} already? It counts at once. Otherwise any undead may drop one, rarely: the {npc:7864} (level 48) in the {area:1221} below {npc:8405}'s cliff drop it about one kill in ten, the highborne ghosts on {zone:1447}'s border with {zone:1440} (level 45-46) a little less, the Anguished and {npc:7523} in {zone:1452} (54-55) about one in eight. The Auction House is usually quicker."] = "Já tem uma {item:7972}? Ela vale na hora. Senão, qualquer morto-vivo pode soltar uma, raramente: o {npc:7864} (nível 48) em {area:1221}, embaixo do penhasco de {npc:8405}, solta uma a cada dez mortes mais ou menos, os fantasmas altaneiros na divisa de {zone:1447} com {zone:1440} (nível 45-46) um pouco menos, os Angustiados e {npc:7523} em {zone:1452} (54-55) cerca de um a cada oito. A Casa de Leilões costuma ser mais rápida.",

	-- Step 9: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz no {area:1417}",
	-- {area:1417} Sunken Temple · {area:75} Stonard · {area:1438} Nethergarde Keep · {zone:1419} Blasted Lands · {area:74} Pool of Tears · {npc:5710} Jammal'an the Prophet
	["Morphaz is a level 52 elite green dragon inside the {area:1417}, a five-player dungeon: bring a group of five (a level 60 group clears it with ease). Horde: fly to {area:75}; Alliance: fly to {area:1438} in the {zone:1419} and ride north. The temple stands in the middle of the {area:74}: climb the steps on its south side, swim down through the flooded hall and take the stairs to the portal. Inside, Morphaz only appears late: kill the six troll minibosses on the upper balconies, then {npc:5710} below them; that wakes the drakes Weaver and Dreamscythe in the Pit of Sacrifice, and killing both brings Morphaz and Hazzas. The pair patrols together and cannot be split: pull them into a hallway and have the tank face them away from the group (breath and a knockback). Loot him in a party, not a raid group: the blood always drops."] = "Morphaz é um dragão verde elite de nível 52 dentro de {area:1417}, uma masmorra para cinco jogadores: leve um grupo de cinco (um grupo de nível 60 limpa com facilidade). Horda: voe para {area:75}; Aliança: voe para {area:1438}, nas {zone:1419}, e cavalgue para o norte. O templo fica no meio de {area:74}: suba os degraus do lado sul, nade para baixo pelo salão alagado e pegue a escada até o portal. Lá dentro, Morphaz só aparece no fim: mate os seis minichefes trolls nas sacadas de cima, depois {npc:5710} embaixo deles; isso acorda os dragonetes Tecelão e Darquimeros no Fosso do Sacrifício, e matar os dois traz Morphaz e Hazzas. A dupla patrulha junta e não dá para separar: puxe os dois para um corredor e peça ao tanque que vire os dois para longe do grupo (sopro e repulsão). Saqueie em grupo, não em raide: o sangue sempre cai.",
	-- {quest:8257} Blood of Morphaz · {area:1417} Sunken Temple
	["{quest:8257}: the {area:1417} entrance"] = "{quest:8257}: entrada do {area:1417}",

	-- Step 10: Greta Mosshoof
	-- {npc:10922} Greta Mosshoof · {area:2479} Emerald Sanctuary · {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:415} Astranaar · {zone:1440} Ashenvale · {item:19990} Blessed Prayer Beads · {item:20006} Circle of Hope
	["{npc:10922} is at the {area:2479} in southern {zone:1448}. Horde: fly to {area:1997} and ride south-east; Alliance: fly to {area:415} in {zone:1440} and ride north into {zone:1448}. She takes the blood for experience and gold. Look at the reward window before you hand in: Classic let you pick {item:19990}, {item:20006} or Woestave, and Forever's notes say that choice may be gone."] = "{npc:10922} fica no {area:2479}, no sul de {zone:1448}. Horda: voe para {area:1997} e cavalgue para sudeste; Aliança: voe para {area:415}, em {zone:1440}, e cavalgue para o norte, rumo a {zone:1448}. Ela troca o sangue por experiência e ouro. Olhe a janela de recompensa antes de entregar: no Classic dava para escolher {item:19990}, {item:20006} ou Vara do Padecimento, e as notas do Forever dizem que essa escolha pode ter sumido.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any undead can drop it. The {npc:7864} in the {area:1221}, below {npc:8405}'s cliffs, are the nearest; Highborne Apparitions and Lichlings haunt the ruins near {area:3137}."] = "Qualquer morto-vivo pode deixá-lo cair. Os {npc:7864} nas {area:1221}, abaixo dos penhascos de {npc:8405}, são os mais próximos; Aparições Altaneiras e Sub-liches Altaneiros assombram as ruínas perto de {area:3137}.",
	-- ["At 50 {npc:5489} in {zone:1453}'s Cathedral of Light or {npc:11406} in {zone:1455}'s {object:32386} offers it."] = "No nível 50, {npc:5489}, na Catedral da Luz de {zone:1453}, ou {npc:11406}, no {object:32386} de {zone:1455}, oferece a missão.",
	-- ["At 50 {npc:6018} in {zone:1454}'s {object:172961} offers it."] = "No nível 50, {npc:6018}, no {object:172961} de {zone:1454}, oferece a missão.",
	-- ["Experience and gold"] = "Experiência e ouro",
	-- ["Experience and gold at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "Experiência e ouro no nível 50 por {zone:1447} e pelo {area:1417}; o Forever removeu a escolha de item do Clássico.",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz é um chefe dragão de Elite dentro do {area:1417}, uma Masmorra de nível 50: leve um grupo de cinco. O templo fica no meio do {area:74}; mergulhe para chegar à entrada. Horda: voe até {area:75}; Aliança: voe até {area:42} ou {area:1438} e siga montado.",
	-- ["Mosshoof Coursers graze all over {zone:1447}; about one in three drops a {item:20027}."] = "Ginetes Cascomusgo pastam por toda {zone:1447}; cerca de um em cada três deixa cair uma {item:20027}.",
	-- ["{npc:10922} is at the {area:2479} in southern {zone:1448}."] = "{npc:10922} está no {area:2479}, no sul de {zone:1448}.",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} mora no alto dos penhascos a nordeste das {area:1221}. Aliança: voe até {area:3137}; Horda: voe até {area:1237}.",
	-- ["{quest:8254} (Alliance)"] = "{quest:8254} (Aliança)",
	-- ["{quest:8254} (Horde)"] = "{quest:8254} (Horda)",
}
