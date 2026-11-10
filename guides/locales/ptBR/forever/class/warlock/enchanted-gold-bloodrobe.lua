-- Portuguese (Brazil) (ptBR): the guide forever/class/warlock/enchanted-gold-bloodrobe (forever/class/warlock/enchanted-gold-bloodrobe.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6266} Menara Voidrender
	["A rare cloth robe for your 30s, which {npc:6266} makes from the parts you bring her."] = "Um manto de tecido raro para seus 30 e poucos, que {npc:6266} faz com as partes que você trouxer.",

	-- Step 1: In Search of Menara Voidrender (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "No nível 31, {npc:461}, no {object:2164}, no {object:2101}, manda você para {npc:6266}, em {area:392}. Compre {item:5770} e {item:3577} antes (próximos passos) para poupar uma viagem.",

	-- Step 2: In Search of Menara Voidrender (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "No nível 31, {npc:5172}, em {zone:1455}, manda você para {npc:6266}, em {area:392}. Compre {item:5770} e {item:3577} antes (próximos passos) para poupar uma viagem.",

	-- Step 3: In Search of Menara Voidrender (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "No nível 31, {npc:3326}, na {object:172960}, manda você para {npc:6266}, em {area:392}. Compre {item:5770} e {item:3577} antes (próximos passos) para poupar uma viagem.",

	-- Step 4: In Search of Menara Voidrender (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar · {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}; the zeppelin from {zone:1420} flies to {zone:1411}. Buy a {item:5770} and a {item:3577} first (next steps) to save a trip."] = "No nível 31, {npc:4563}, no {object:36082}, manda você para {npc:6266}, em {area:392}; o zepelim de {zone:1420} voa para {zone:1411}. Compre {item:5770} e {item:3577} antes (próximos passos) para poupar uma viagem.",

	-- Step 5: Robes of Arcana and a Gold Bar
	-- {item:5770} Robes of Arcana · {item:3577} Gold Bar
	["{item:5770} and a {item:3577}"] = "{item:5770} e {item:3577}",
	-- {item:5770} Robes of Arcana · {item:2776} Gold Ore · {npc:6266} Menara Voidrender
	-- plural, as words: Gold Bars = {item:3577} Gold Bar
	["Tailors sew the {item:5770} from a rare pattern; miners smelt Gold Bars from {item:2776}. Everyone else buys both at the Auction House. If you wear the robe, take it off: {npc:6266} keeps it."] = "Alfaiates costuram {item:5770} a partir de um molde raro; mineiros fundem Barras de Ouro a partir de {item:2776}. Todos os outros compram os dois na Casa de Leilões. Se estiver usando a túnica, tire: {npc:6266} fica com ela.",
	-- {item:5770} Robes of Arcana
	["{item:5770}: the Auction House"] = "{item:5770}: a Casa de Leilões",
	-- {item:3577} Gold Bar
	["{item:3577}: the Auction House"] = "{item:3577}: a Casa de Leilões",

	-- Step 6: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {npc:6251} Strahad Farsan · {area:392} Ratchet · {npc:2670} Xizk Goodstitch · {area:35} Booty Bay
	["{npc:6266} stands by {npc:6251}'s tower on the hill above {area:392}, behind the engineers' hut. She takes the robe, then sends the gold bar to {npc:2670} in {area:35}."] = "{npc:6266} fica ao lado da torre de {npc:6251}, no morro acima de {area:392}, atrás da cabana dos engenheiros. Ela pega a túnica e depois manda a barra de ouro para {npc:2670}, em {area:35}.",

	-- Step 7: Xizk Goodstitch
	-- {area:392} Ratchet · {area:35} Booty Bay · {npc:2670} Xizk Goodstitch · {object:59851} A Tailor to Cities (no name in this language: may be words) · {item:3577} Gold Bar
	["The boat from {area:392} sails to {area:35}. {npc:2670} runs {object:59851} on an upper level of the town. Give him the {item:3577}; he will spin the thread later."] = "O barco de {area:392} navega até {area:35}. {npc:2670} cuida de {object:59851} num nível superior da cidade. Entregue a ele o {item:3577}; ele fiará a linha depois.",

	-- Step 8: Back to Menara Voidrender
	-- {npc:6266} Menara Voidrender
	["Back to {npc:6266}"] = "De volta a {npc:6266}",
	-- {npc:6266} Menara Voidrender · {zone:1443} Desolace
	["You need no thread yet: {npc:6266} wants demon parts from {zone:1443} next."] = "Você ainda não precisa da linha: {npc:6266} quer partes de demônio de {zone:1443} a seguir.",

	-- Step 9: Desolace demons
	-- {zone:1443} Desolace
	["{zone:1443} demons"] = "Demônios de {zone:1443}",
	-- {area:603} Sargeron · {zone:1443} Desolace · {area:608} Nijel's Point · {area:602} Mannoroc Coven · {spell:686} Shadow Bolt
	-- plural, as words: Lesser Infernals = {npc:4676} Lesser Infernal · Demon Portal Guardians = {npc:11937} Demon Portal Guardian
	["The Hatefury satyrs (level 31-32) hold {area:603} in the far north-east of {zone:1443}, past {area:608}: two kills in five give a vial, so plan on about 25. The Lesser Infernals (36-37) and Demon Portal Guardians (38) of {area:602}, in the south, drop the stone half the time; they resist fire, so use {spell:686} and Corruption."] = "Os sátiros Furiódio (nível 31-32) ocupam {area:603}, no extremo nordeste de {zone:1443}, depois de {area:608}: duas mortes em cinco soltam um frasco, então conte com umas 25. Os Infernais Menores (36-37) e os Guardiões do Portal Demoníaco (38) de {area:602}, ao sul, soltam a pedra em metade das vezes; eles resistem a fogo, então use {spell:686} e Corrupção.",
	["Vials of Hatefury Blood"] = "Ampolas de Sangue de Furiódio",

	-- Step 10: Menara Voidrender again
	-- {npc:6266} Menara Voidrender
	["{npc:6266} again"] = "{npc:6266} de novo",

	-- Step 11: Fine Gold Thread
	-- {npc:2670} Xizk Goodstitch · {area:35} Booty Bay · {quest:4785} Fine Gold Thread
	["Back to {npc:2670} in {area:35}: he offers {quest:4785} as a quest you hand straight back to him. He may show no quest marker; talk to him anyway."] = "De volta a {npc:2670}, em {area:35}: ele oferece {quest:4785} como uma missão que você devolve direto a ele. Pode não ter marcador de missão; fale com ele mesmo assim.",

	-- Step 12: Smoldering Coal
	-- {area:334} Circle of West Binding · {zone:1417} Arathi Highlands · {spell:686} Shadow Bolt · {area:321} Hammerfall · {item:6265} Soul Shard · {spell:1120} Drain Soul
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Cresting Charms = {item:4481} Cresting Charm · Cresting Exiles = {npc:2761} Cresting Exile
	["The Burning Exiles (level 38-39), fire elementals at the {area:334} in western {zone:1417}, drop the coal about one time in three. They resist fire: {spell:686} and Corruption. Below 38 they hit hard; the Cresting Charms from the Cresting Exiles near {area:321} finish one off once you have hurt it. Make a {item:6265} with {spell:1120} on the way."] = "Os Exilados em Chamas (nível 38-39), elementais de fogo em {area:334}, no oeste de {zone:1417}, soltam o carvão cerca de uma vez em três. Eles resistem a fogo: {spell:686} e Corrupção. Abaixo do nível 38 eles batem forte; os Patuás Pontudos dos Exilados Vagalhantes perto de {area:321} acabam com um deles depois que você o machuca. Faça {item:6265} com {spell:1120} no caminho.",
	-- {item:6265} Soul Shard · {spell:1120} Drain Soul
	["{item:6265}: {spell:1120} on an Exile as it dies"] = "{item:6265}: {spell:1120} num Exilado enquanto ele morre",

	-- Step 13: The Completed Robe
	-- {npc:6266} Menara Voidrender · {item:6265} Soul Shard
	["Back to {npc:6266} with the thread, the coals and a {item:6265}. Then wait beside her while she works the robe (do not attack her: the quest log calls it a kill), and speak to her again."] = "De volta a {npc:6266} com a linha, os carvões e {item:6265}. Depois espere ao lado dela enquanto ela trabalha na túnica (não ataque: o registro de missões chama isso de morte), e fale com ela de novo.",
	-- {npc:6266} Menara Voidrender
	["Wait beside {npc:6266} while she finishes the robe"] = "Espere ao lado de {npc:6266} enquanto ela termina a túnica",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 31 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "No nível 31, {npc:3326} na {object:172960} manda você até {npc:6266} em {area:392}.",
	-- ["At 31 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "No nível 31, {npc:4563} no {object:36082} manda você até {npc:6266} em {area:392}. O zepelim de {zone:1420} voa para {zone:1411}.",
	-- ["At 31 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "No nível 31, {npc:461} no {object:2164}, no {object:2101}, manda você até {npc:6266} em {area:392}.",
	-- ["At 31 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "No nível 31, {npc:5172} em {zone:1455} manda você até {npc:6266} em {area:392}.",
	-- ["Back to {npc:6266} with the thread, the coal and a {item:6265}. Wait while she completes the robe, then speak to her again."] = "De volta a {npc:6266} com a linha, o carvão e um {item:6265}. Espere enquanto ela termina o manto, depois fale com ela de novo.",
	-- ["Bring {npc:6266} a {item:5770}: tailors sew it from a pattern that drops; otherwise buy one at the Auction House. Her next errand needs a {item:3577}: smelted from {item:2776}, or from the Auction House."] = "Leve a {npc:6266} um {item:5770}: alfaiates o costuram com um molde que cai; senão, compre um na Casa de Leilões. A tarefa seguinte dela exige uma {item:3577}: fundida de {item:2776}, ou da Casa de Leilões.",
	-- ["The Burning Exiles, fire elementals in western {zone:1417}, drop the coal."] = "Os Exilados em Chamas, elementais do fogo no oeste das {zone:1417}, deixam cair o carvão.",
	-- ["The Hatefury satyrs of {area:603}, in north-eastern {zone:1443}, carry the blood; the Lesser Infernals of Mannoroc Coven, in the south, the stone."] = "Os sátiros Furiódio de {area:603}, no nordeste de {zone:1443}, carregam o sangue; os Infernais Menores da Ruínas de Mannoroc, no sul, a pedra.",
	-- ["Wait for the robe"] = "Espere o manto",
	-- ["{npc:2670} in {area:35} has the thread for you."] = "{npc:2670} em {area:35} tem a linha para você.",
	-- ["{npc:2670} sells tailoring supplies in {area:35}. Bring him the {item:3577}."] = "{npc:2670} vende suprimentos de alfaiataria em {area:35}. Leve a ele a {item:3577}.",
	-- ["{npc:6266} stands in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} fica na torre da colina acima de {area:392}, ao lado de {npc:6251}.",
}
