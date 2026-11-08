-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/impsys-request (forever/class/warlock/impsys-request.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14470} Impsy
	["A staff, off-hand or robe for your 50s; {npc:14470}'s own errand, not a step of the Dreadsteed chain."] = "Um cajado, item de mão secundária ou toga para os 50; tarefa própria de {npc:14470}, não uma etapa da série do Corcel Medonho.",

	-- Step 1: An Imp's Request (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "No nível 50, {npc:461}, no {object:2164}, no {object:2101}, manda você para {npc:14470}, em {zone:1448}, com um pedaço de {item:14256}.",

	-- Step 2: An Imp's Request (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "No nível 50, {npc:5172}, em {zone:1455}, manda você para {npc:14470}, em {zone:1448}, com um pedaço de {item:14256}.",

	-- Step 3: An Imp's Request (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:3326} in the {object:172960} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "No nível 50, {npc:3326} na {object:172960} manda você a {npc:14470} em {zone:1448} com um pedaço de {item:14256}.",

	-- Step 4: An Imp's Request (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:14470} Impsy · {zone:1448} Felwood · {item:14256} Felcloth
	["At 50 {npc:4563} in the {object:36082} sends you to {npc:14470} in {zone:1448} with a piece of {item:14256}."] = "No nível 50, {npc:4563} no {object:36082} manda você a {npc:14470} em {zone:1448} com um pedaço de {item:14256}.",

	-- Step 5: Felcloth
	-- {item:14256} Felcloth · {zone:1448} Felwood · {quest:8419} An Imp's Request · {npc:14470} Impsy · {quest:8420} Hot and Itchy
	["One {item:14256}: the Jadefire satyrs of {zone:1448} drop it about one kill in fourteen, and so do the Legashi satyrs and the Felguard Sentries you hunt for Niby's essences. Quicker: buy one at the Auction House. You need it for the trainer's {quest:8419} or for {npc:14470}'s own {quest:8420}, the same errand: whichever you hold."] = "Um {item:14256}: os sátiros Jadefire de {zone:1448} soltam cerca de uma morte em catorze, e os sátiros Legashi e as Sentinelas Guarda Vil que você caça para as essências de Niby também. Mais rápido: compre um na Casa de Leilões. Você precisa dele para {quest:8419} do instrutor ou para {quest:8420} do próprio {npc:14470}, a mesma tarefa: a que você tiver.",

	-- Step 6: Impsy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls · {quest:8419} An Imp's Request · {item:20613} Rotting Wood · {item:20614} Bloodvenom Essence
	["{npc:14470} waits beside {npc:14469} on a rise just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. Hand him the trainer's {quest:8419} with the cloth. Next he wants ten {item:20613} and four {item:20614}."] = "{npc:14470} espera ao lado de {npc:14469} numa elevação logo a nordeste de {area:1997}: vindo para o norte pela ponte de {area:1765}, eles ficam fora da estrada, a leste, depois de algumas gosmas. Entregue a ele {quest:8419} do instrutor com o pano. Em seguida ele quer dez {item:20613} e quatro {item:20614}.",

	-- Step 7: Impsy: Hot and Itchy
	-- {npc:14470} Impsy · {npc:14469} Niby the Almighty · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls · {quest:8420} Hot and Itchy · {item:20613} Rotting Wood · {item:20614} Bloodvenom Essence
	["{npc:14470} waits beside {npc:14469} on a rise just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. Take his own {quest:8420} and hand him the cloth at once. Next he wants ten {item:20613} and four {item:20614}."] = "{npc:14470} espera ao lado de {npc:14469} numa elevação logo a nordeste de {area:1997}: vindo para o norte pela ponte de {area:1765}, eles ficam fora da estrada, a leste, depois de algumas gosmas. Pegue {quest:8420} dele e entregue o pano na hora. Em seguida ele quer dez {item:20613} e quatro {item:20614}.",

	-- Step 8: Rotting Wood and Bloodvenom
	-- {item:20613} Rotting Wood
	["{item:20613} and Bloodvenom"] = "{item:20613} e Peçonha",
	-- {area:1767} Irontree Woods · {zone:1448} Felwood · {area:1998} Talonbranch Glade · {item:20613} Rotting Wood · {npc:7149} Withered Protector · {npc:14470} Impsy
	-- plural, as words: Tainted Oozes = {npc:7092} Tainted Ooze
	["The Irontree treants (level 52) of {area:1767}, in northern {zone:1448} west of {area:1998}, drop {item:20613} one time in four; the big {npc:7149} (55) often drops three at once but hits hard and dazes. The Tainted Oozes (51) around {npc:14470} and along the Bloodvenom drop the essence one time in five."] = "Os ents Irontree (nível 52) de {area:1767}, no norte de {zone:1448}, a oeste de {area:1998}, soltam {item:20613} uma vez em quatro; o grande {npc:7149} (55) costuma soltar três de uma vez, mas bate forte e atordoa. As Gosmas Maculadas (51) em volta de {npc:14470} e ao longo do Bloodvenom soltam a essência uma vez em cinco.",

	-- Step 9: Impsy again
	-- {npc:14470} Impsy
	["{npc:14470} again"] = "{npc:14470} de novo",
	-- {npc:14470} Impsy · {item:20609} Voodoo Feathers · {area:1417} Sunken Temple
	["{npc:14470} now wants six {item:20609} from the {area:1417}: a dungeon run."] = "{npc:14470} agora quer seis {item:20609} de {area:1417}: uma corrida de masmorra.",

	-- Step 10: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "O {area:1417}",
	-- {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor
	["The {area:1417} ({area:1477}, level 50-56, a group of five) stands in the middle of the {area:74}: swim down into the temple and take the stairs to the entrance. The six troll guardians (level 51-52, elite) stand on the balconies around the central pit, each with adds; each drops his feather every time: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Not soloable at 52."] = "{area:1417} ({area:1477}, nível 50-56, grupo de cinco) fica no meio de {area:74}: nade para baixo até o templo e pegue as escadas até a entrada. Os seis guardiões trolls (nível 51-52, elite) ficam nas sacadas em volta do fosso central, cada um com reforços; cada um solta a pena dele toda vez: Talho e {npc:5716}, o Âmbar, Hukkah e Mirran, o Azul, Zolo e Lorro, o Verde. Não dá para fazer solo no 52.",
	-- {npc:5716} Zul'Lor
	-- plural, as words: Amber Voodoo Feathers = {item:20606} Amber Voodoo Feather
	["Amber Voodoo Feathers: Gasher, {npc:5716}"] = "Penas Vodu Âmbar: Talho, {npc:5716}",
	-- plural, as words: Blue Voodoo Feathers = {item:20607} Blue Voodoo Feather
	["Blue Voodoo Feathers: Hukku, Mijan"] = "Penas Vodu Azuis: Hukkah, Mirran",
	-- plural, as words: Green Voodoo Feathers = {item:20608} Green Voodoo Feather
	["Green Voodoo Feathers: Zolo, Loro"] = "Penas Vodu Verdes: Zolo, Lorro",

	-- Step 11: Trolls of a Feather
	-- {item:20536} Soul Harvester · {item:20534} Abyss Shard · {item:20530} Robes of Servitude
	["Choose the {item:20536} (staff), the {item:20534} (off-hand) or the {item:20530}."] = "Escolha {item:20536} (cajado), {item:20534} (mão secundária) ou {item:20530}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:14470} in {zone:1448}."] = "No nível 50, {npc:461} no {object:2164}, no {object:2101}, manda você a {npc:14470} em {zone:1448}.",
	-- ["At 50 {npc:5172} in {zone:1455} sends you to {npc:14470} in {zone:1448}."] = "No nível 50, {npc:5172} em {zone:1455} manda você a {npc:14470} em {zone:1448}.",
	-- ["The Irontree treants in northern {zone:1448} drop the {item:20613}; the Tainted Oozes around {area:1763} the {item:20614}."] = "Os arvorosos Ferrárbol do norte de {zone:1448} deixam cair a {item:20613}; as Gosmas Maculadas em volta de {area:1763}, a {item:20614}.",
	-- ["The six troll guardians of the {area:1417}, a level 50 dungeon, each drop a Voodoo Feather: bring a group of five. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance."] = "Os seis guardiões trolls do {area:1417}, uma masmorra de nível 50, deixam cair cada um uma Pena Vodu: leve um grupo de cinco. O templo fica no meio do {area:74}; mergulhe nele para chegar à entrada.",
	-- ["{npc:14470} waits beside {npc:14469} in central {zone:1448}, just east of {area:1763}. This chain is {npc:14470}'s own and is not part of the Dreadsteed chain; Niby and {npc:14470} also give the {item:18762} chain here."] = "{npc:14470} espera ao lado de {npc:14469} no centro de {zone:1448}, logo a leste de {area:1763}. Esta série é de {npc:14470} e não faz parte da série do Corcel Medonho; Niby e {npc:14470} também dão aqui a série do {item:18762}.",
	-- ["{npc:14470} wants one {item:14256}: the Jadefire satyrs and the demons of {area:1763} drop it."] = "{npc:14470} quer um {item:14256}: os sátiros Flamejade e os demônios de {area:1763} deixam cair.",
}
