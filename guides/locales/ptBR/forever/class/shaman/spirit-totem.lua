-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/spirit-totem (forever/class/shaman/spirit-totem.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:8412} Spirit Totem · {quest:8413} Da Voodoo
	["{quest:8412} and {quest:8413}"] = "{quest:8412} e {quest:8413}",
	-- {area:1417} Sunken Temple
	["Experience and gold at 50, ending in the {area:1417}; the Classic item choice may be gone in Forever."] = "Experiência e ouro no nível 50, terminando em {area:1417}; a escolha de item do Classic pode ter sumido no Forever.",
	["Experience and gold"] = "Experiência e ouro",

	-- Step 1: Sagorne Creststrider
	-- {npc:13417} Sagorne Creststrider · {object:172957} Valley of Wisdom (no name in this language: may be words) · {npc:6176} Bath'rah the Windwatcher
	["At 50 {npc:13417}, the shaman trainer in the {object:172957}, asks for the four elements for {npc:6176}."] = "No nível 50, {npc:13417}, o instrutor de xamã no {object:172957}, pede os quatro elementos para {npc:6176}.",

	-- Step 2: Beram Skychaser
	-- {npc:3032} Beram Skychaser · {area:1640} Spirit Rise · {zone:1456} Thunder Bluff · {npc:6176} Bath'rah the Windwatcher · {quest:8410} Elemental Mastery · {quest:8412} Spirit Totem · {quest:8411} Mastering the Elements
	["At 50 {npc:3032}, a shaman trainer on {area:1640} in {zone:1456}, asks for the four elements for {npc:6176}. Skyborne: Forever's quest page lists {quest:8410} and {quest:8412} for Orcs, Tauren and Trolls only; if {npc:3032} has nothing for you, {npc:6176}'s own {quest:8411} is open to every Horde race, but {quest:8412} after it may still turn you away."] = "No nível 50, {npc:3032}, instrutor de xamã em {area:1640}, em {zone:1456}, pede os quatro elementos para {npc:6176}. Celonatos: a página de missões do Forever lista {quest:8410} e {quest:8412} só para Orcs, Taurens e Trolls; se {npc:3032} não tiver nada para você, {quest:8411} do próprio {npc:6176} está aberta a todas as raças da Horda, mas {quest:8412}, depois dela, ainda pode barrar você.",

	-- Step 3: The four elements
	["The four elements"] = "Os quatro elementos",
	-- {item:7069} Elemental Air · {zone:1417} Arathi Highlands · {area:320} Refuge Pointe · {npc:2794} Summoned Guardian · {zone:1447} Azshara · {npc:14269} Seeker Aqualon · {area:69} Lakeshire
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile · Rumbling Exiles = {npc:2592} Rumbling Exile · Burning Exiles = {npc:2760} Burning Exile
	["One each of {item:7069}, Fire, Earth and Water; all four trade, so the auction house is quickest. To farm them, {zone:1417} has the exiles near {area:320} (level 38-39, about one kill in eight to ten, respawn under seven minutes): Thundering Exiles south-east of it (air), Rumbling Exiles south-west (earth), Burning Exiles far to the north-west (fire), and the {npc:2794} far to the south-west (water, about one in seven). Water comes easier from the Patches of Elemental Water in {zone:1447} (two in five) or {npc:14269} by {area:69} in Redridge."] = "Um de cada: {item:7069}, Fogo, Terra e Água; os quatro são negociáveis, então a Casa de Leilões é o mais rápido. Para farmar: {zone:1417} tem os exilados perto de {area:320} (nível 38-39, cerca de uma morte em oito a dez, voltam em menos de sete minutos): Exilados Trovejantes ao sudeste dela (ar), Exilados Tonitruantes ao sudoeste (terra), Exilados em Chamas bem ao noroeste (fogo) e {npc:2794} bem ao sudoeste (água, cerca de um em sete). A Água vem mais fácil das Poças de Água Elemental em {zone:1447} (dois em cinco) ou de {npc:14269}, perto de {area:69}, em Cristarrubra.",
	-- {item:7069} Elemental Air
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:7069}: Thundering Exiles"] = "{item:7069}: Exilados Trovejantes",
	-- {item:7068} Elemental Fire
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:7068}: Burning Exiles"] = "{item:7068}: Exilados em Chamas",
	-- {item:7067} Elemental Earth
	-- plural, as words: Rumbling Exiles = {npc:2592} Rumbling Exile
	["{item:7067}: Rumbling Exiles"] = "{item:7067}: Exilados Tonitruantes",
	-- {item:7070} Elemental Water · {npc:2794} Summoned Guardian · {zone:1447} Azshara
	["{item:7070}: the {npc:2794}, or {zone:1447}'s water patches"] = "{item:7070}: {npc:2794}, ou as poças de água de {zone:1447}",

	-- Step 4: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {zone:1416} Alterac Mountains · {area:272} Tarren Mill
	["{npc:6176} camps in the ruins of the east of {zone:1416}: from {area:272} follow the river east of town north into the hills."] = "{npc:6176} acampa nas ruínas do leste de {zone:1416}: a partir de {area:272}, siga para o norte, pelas colinas, o rio a leste da cidade.",

	-- Step 5: Spider eye and bear claw
	["Spider eye and bear claw"] = "Olho de aranha e garra de urso",
	-- {area:813} Bulwark · {zone:1422} Western Plaguelands · {area:3197} Chillwind Camp · {item:20610} Bloodshot Spider Eye · {spell:3427} Infected Wound · {item:20611} Thick Black Claw · {area:159} Brill
	-- plural, as words: Venom Mist Lurkers = {npc:1822} Venom Mist Lurker · Diseased Black Bears = {npc:1815} Diseased Black Bear · Carrion Vultures = {npc:1809} Carrion Vulture · Plague Lurkers = {npc:1824} Plague Lurker
	["Eight of each. Fly or ride to the {area:813} and on to the west edge of the {zone:1422}, north-west of {area:3197}: the Venom Mist Lurkers (level 50-51, they poison) give the {item:20610} and the Diseased Black Bears (level 51-52, {spell:3427}) the {item:20611}, one kill in five each; the two Carrion Vultures there drop either. The bigger Diseased Grizzlies and Plague Lurkers further east almost never drop them. A few bears and lurkers also roam south-east of {area:159} in Tirisfal."] = "Oito de cada. Voe ou cavalgue até {area:813} e siga até a borda oeste de {zone:1422}, a noroeste de {area:3197}: as Tocaieiras Rasterruça (nível 50-51, envenenam) soltam {item:20610} e os Ursos Pretos Doentes (nível 51-52, {spell:3427}) soltam {item:20611}, uma morte em cinco cada; os dois Abutres Carniceiros de lá soltam qualquer um. Os Ursos-cinzentos Doentes maiores e as Tocaieiras Pestilentas mais a leste quase nunca soltam. Alguns ursos e tocaieiras também rondam a sudeste de {area:159}, em Tirisfal.",

	-- Step 7: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "{area:1417}",
	-- {area:75} Stonard · {area:1417} Sunken Temple · {area:1477} Temple of Atal'Hakkar · {area:74} Pool of Tears · {npc:5716} Zul'Lor · {spell:139} Renew · {npc:3560} Healing Ward
	-- plural, as words: Shadow Bolt Volleys = {spell:9081} Shadow Bolt Volley
	["A five-player dungeon: needs a group of five, about level 50-55. Fly to {area:75} and ride east. The {area:1417} ({area:1477}) stands in the middle of the {area:74}: climb the stairs on the ruin's south side, dive into the flooded hall, swim down through it and follow the stairs and passages down to the portal. Two feathers of each colour, one from each of six elite troll mini-bosses (level 51-52) on the balconies around the temple's great round room, every kill, and each player on the quest loots their own: Gasher and {npc:5716} the Amber, Hukku and Mijan the Blue, Zolo and Loro the Green. Mijan heals the others ({spell:139}, a {npc:3560}): kill him first; Hukku summons guardians and throws Shadow Bolt Volleys."] = "Uma masmorra para cinco jogadores: precisa de um grupo de cinco, de nível 50-55 mais ou menos. Voe para {area:75} e cavalgue para leste. {area:1417} ({area:1477}) fica no meio de {area:74}: suba as escadas do lado sul da ruína, mergulhe no salão alagado, nade para baixo por ele e siga as escadas e passagens até o portal. Duas penas de cada cor, uma de cada um dos seis minichefes trolls elite (nível 51-52) nas sacadas em volta do grande salão redondo do templo, a cada morte, e cada jogador com a missão saqueia as próprias: Talho e {npc:5716}, o Âmbar, Hukkah e Mirran, o Azul, Zolo e Lorro, o Verde. Mirran cura os outros ({spell:139}, um {npc:3560}): mate-o primeiro; Hukkah invoca guardiões e joga Salvas de Seta Sombria.",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606}: Gasher, {npc:5716}"] = "{item:20606}: Talho, {npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}: Hukku, Mijan"] = "{item:20607}: Hukkah, Mirran",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}: Zolo, Loro"] = "{item:20608}: Zolo, Lorro",

	-- Step 8: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher
	["{npc:6176}: the old item choice may be gone, count on the experience"] = "{npc:6176}: a antiga escolha de item pode ter sumido, conte com a experiência",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:13417}, the shaman trainer in the {object:172957}, sends you to {npc:6176}."] = "No nível 50, {npc:13417}, o instrutor de xamãs no {object:172957}, envia você a {npc:6176}.",
	-- ["At 50 {npc:3032}, a shaman trainer in {zone:1456}, sends you to {npc:6176}."] = "No nível 50, {npc:3032}, instrutor de xamãs em {zone:1456}, envia você a {npc:6176}.",
	-- ["Experience and gold at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "Experiência e ouro no nível 50, terminando no {area:1417}; o Forever removeu o item à escolha do Classic.",
	-- ["In the {zone:1422}, the Venom Mist Lurkers drop the {item:20610} and the Diseased Black Bears the {item:20611} (about one kill in five each)."] = "Nas {zone:1422}, as Tocaieiras Rasterruças soltam o {item:20610} e os Ursos Pretos Doentes a {item:20611} (cerca de uma morte em cinco, cada).",
	-- ["One each of {item:7069}, Fire, Earth and Water. The Exiles of Arathi Highlands drop them, one element each, about one kill in ten: Thundering (air), Burning (fire), Rumbling (earth) and Cresting (water). Or buy them at the auction house."] = "Um de cada: {item:7069}, Fogo, Terra e Água Elemental. Os Exilados do Planalto Arathi os soltam, um elemento cada, em cerca de uma morte em dez: Trovejantes (ar), em Chamas (fogo), Tonitruantes (terra) e Vagalhantes (água). Ou compre na Casa de Leilões.",
	-- ["The {area:1417} ({area:1477}) lies under the {area:74}; the arrow points at its entrance. Gasher or {npc:5716} drop the {item:20606}, Hukku or Mijan the Blue, Zolo or Loro the Green: all six are elite trolls inside. Bring a group."] = "O {area:1417} ({area:1477}) fica sob o {area:74}; a seta aponta para a entrada. Talho ou {npc:5716} soltam a {item:20606}, Hukkah ou Mirran a azul, Zolo ou Lorro a verde: os seis são trolls elite lá dentro. Leve um grupo.",
	-- ["{item:7070}: Cresting Exiles"] = "{item:7070}: Exilados Vagalhantes",
	-- ["{npc:6176} camps in the east of {zone:1416}, north-east of {area:272}."] = "{npc:6176} acampa no leste de {zone:1416}, a nordeste de {area:272}.",
}
