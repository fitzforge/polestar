-- Portuguese (Brazil) (ptBR): the guide forever/class/paladin/tome-of-divinity (forever/class/paladin/tome-of-divinity.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["{spell:7328} (Alliance)"] = "{spell:7328} (Aliança)",
	-- {spell:7328} Redemption
	["{spell:7328} at 12, the paladin's resurrection: an easy chain through your capital and its home zone."] = "{spell:7328} no nível 12, a ressurreição do paladino: uma sequência fácil pela sua capital e a zona natal dela.",

	-- Step 1: The summons (Human)
	["The summons (Human)"] = "O chamado (Humano)",
	-- {npc:927} Brother Wilhelm · {area:87} Goldshire · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge
	["At 12 {npc:927}, the paladin trainer in {area:87}, sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. The errand is optional, a little XP: {npc:5149} in {zone:1455} gives the same one (taking one closes the other), and {npc:6171} starts the chain without it."] = "No nível 12, {npc:927}, o instrutor de paladino em {area:87}, manda você até {npc:6171}, na Catedral da Luz de {zone:1453}. O recado é opcional, um pouco de XP: {npc:5149}, em {zone:1455}, dá o mesmo (pegar um fecha o outro), e {npc:6171} começa a sequência sem ele.",

	-- Step 2: The summons (Dwarf)
	["The summons (Dwarf)"] = "O chamado (Anão)",
	-- {npc:5149} Brandur Ironhammer · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {npc:6179} Tiza Battleforge · {npc:1232} Azar Stronghammer · {area:131} Kharanos · {npc:928} Lord Grayson Shadowbreaker · {zone:1453} Stormwind
	["At 12 {npc:5149}, the paladin trainer in {zone:1455}'s {object:32362}, sends you upstairs to {npc:6179}. The errand is optional, a little XP: {npc:1232} in {area:131} and {npc:928} in {zone:1453} give the same one (taking one closes the others), and {npc:6179} starts the chain without it."] = "No nível 12, {npc:5149}, o instrutor de paladino na {object:32362} de {zone:1455}, manda você ao andar de cima, a {npc:6179}. O recado é opcional, um pouco de XP: {npc:1232}, em {area:131}, e {npc:928}, em {zone:1453}, dão o mesmo (pegar um fecha os outros), e {npc:6179} começa a cadeia sem ele.",

	-- Step 3: Duthorian Rall
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, Cathedral of Light"] = "{npc:6171}, Catedral da Luz",

	-- Step 5: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {item:6775} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6171} stands inside the Cathedral of Light. He hands you the {item:6775}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6171} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "{npc:6171} fica dentro da Catedral da Luz. Ele entrega o {item:6775}: clique com o botão direito nele nas bolsas para começar a próxima missão. Se o livro disser que a missão já foi feita, destrua e peça outra cópia a {npc:6171}. Leve 10 {item:2589} para a próxima etapa, se tiver.",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775}"] = "Clique com o botão direito no {item:6775}",

	-- Step 6: Stephanie Turner
	-- {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth · {zone:1436} Westfall
	["{npc:6174} stands at a corner in the middle of the {object:2096}, outside a general goods store. She wants 10 {item:2589}: humanoids drop it (Riverpaw gnolls in {zone:1436} about every other kill, Defias and kobolds a little less), or buy it at the Auction House a few steps away in the {object:2096}."] = "{npc:6174} fica numa esquina no meio do {object:2096}, em frente a uma loja de artigos gerais. Ela quer 10 {item:2589}: humanoides deixam cair (gnolls Pata Molhada em {zone:1436} mais ou menos um sim, um não; Défias e kobolds um pouco menos), ou compre na Casa de Leilões a poucos passos, no {object:2096}.",
	-- {item:2589} Linen Cloth
	["{item:2589} x10"] = "{item:2589} x10",

	-- Step 7: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {npc:6171} Duthorian Rall · {item:6866} Symbol of Life · {npc:6173} Gazin Tenorm · {npc:6172} Henze Faulk
	["Back to the Cathedral. {npc:6171} gives you the {item:6866}; {npc:6173} lies wounded by the altar of the same hall. Keep the symbol: you need it on {npc:6172}. If you lose it, {npc:6171} gives you another (The {item:6866})."] = "De volta à Catedral. {npc:6171} entrega o {item:6866}; {npc:6173} está ferido junto ao altar do mesmo salão. Guarde o símbolo: você vai usar em {npc:6172}. Se perder, {npc:6171} dá outro (O {item:6866}).",

	-- Step 8: Henze Faulk
	-- {npc:6172} Henze Faulk · {area:56} Heroes' Vigil · {area:86} Stone Cairn Lake · {item:6866} Symbol of Life · {spell:116} Frostbolt
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{npc:6172} lies dead on {area:56}, the island in {area:86} in eastern Elwynn, on top of one of the mounds around the stone circle. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes. The Defias Rogue Wizards on the island (level 9-10) cast {spell:116} from far off: they stand apart, so pull one at a time."] = "{npc:6172} está morto em {area:56}, a ilha de {area:86}, no leste de Elwynn, em cima de um dos montes em volta do círculo de pedras. Selecione o corpo dele e use o {item:6866} para ressuscitá-lo, depois fale com ele. Se outro paladino acabou de ressuscitá-lo, o corpo volta em uns três minutos. Os Teurgos Proscritos Défias da ilha (nível 9-10) soltam {spell:116} de longe: eles ficam separados, então puxe um de cada vez.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["{item:6866} on {npc:6172}'s body"] = "{item:6866} no corpo de {npc:6172}",

	-- Step 9: The Defias Script
	-- {item:6846} Defias Script
	["The {item:6846}"] = "A {item:6846}",
	-- {npc:6172} Henze Faulk · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["The Defias Rogue Wizards around the big stone tablet east of {npc:6172} carry the {item:6846}: about one kill in two drops it, but some players need many kills. They respawn in three minutes."] = "Os Teurgos Proscritos Défias em volta da grande tabuleta de pedra a leste de {npc:6172} carregam a {item:6846}: mais ou menos um em dois deixa cair, mas tem gente que precisa matar um monte. Renascem em três minutos.",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Teurgos Proscritos Défias",

	-- Step 10: Redemption
	-- {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall · {spell:7328} Redemption
	["Back to the Cathedral of Light: {npc:6173} takes the script, {npc:6171} teaches you {spell:7328}."] = "De volta à Catedral da Luz: {npc:6173} fica com a carta, {npc:6171} ensina {spell:7328}.",

	-- Step 11: Tiza Battleforge
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words)
	["{npc:6179}, upstairs in the {object:32386}"] = "{npc:6179}, no andar de cima do {object:32386}",

	-- Step 14: The Tome of Divinity
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {item:6916} Tome of Divinity · {item:2589} Linen Cloth
	["{npc:6179} stands upstairs in the {object:32386}, in the {object:32362}: take the ramp at the back of the hall. She hands you the {item:6916}: right-click it in your bags to start the next quest. If the book says the quest is already done, destroy it and ask {npc:6179} for a new copy. Bring 10 {item:2589} for the next step if you have it."] = "{npc:6179} fica no andar de cima do {object:32386}, na {object:32362}: pegue a rampa nos fundos do salão. Ela entrega o {item:6916}: clique nele com o botão direito nas bolsas para começar a próxima missão. Se o livro disser que a missão já foi feita, destrua-o e peça um novo exemplar a {npc:6179}. Leve 10 {item:2589} para a próxima etapa, se tiver.",
	-- {item:6916} Tome of Divinity
	["Right-click the {item:6916}"] = "Clique com o botão direito no {item:6916}",

	-- Step 15: John Turner
	-- {npc:6175} John Turner · {item:2589} Linen Cloth · {npc:1245} Kogan Forgestone · {area:131} Kharanos
	-- plural, as words: Dark Iron Ambushers = {npc:1981} Dark Iron Ambusher
	["{npc:6175} walks the outer ring of the Commons, past the front gate, the bank and the Auction House. He wants 10 {item:2589}: humanoids drop it ({npc:1245} in {area:131} every time, Dark Iron Ambushers about two kills in five), or buy it at the Auction House on his ring."] = "{npc:6175} anda pelo anel de fora da praça central, passando pelo portão da frente, pelo banco e pela Casa de Leilões. Ele quer 10 {item:2589}: humanoides deixam cair ({npc:1245}, em {area:131}, toda vez; Emboscadores Ferro Negro mais ou menos duas vezes a cada cinco), ou compre na Casa de Leilões do anel dele.",

	-- Step 16: The Symbol of Life
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6179} Tiza Battleforge · {item:6866} Symbol of Life · {npc:6178} Muiredon Battleforge · {npc:6177} Narm Faulk
	["Back upstairs in the {object:32386}. {npc:6179} gives you the {item:6866}; her husband {npc:6178} rests on the same floor. Keep the symbol: you need it on {npc:6177}. If you lose it, {npc:6179} gives you another (The {item:6866})."] = "De volta ao andar de cima do {object:32386}. {npc:6179} entrega o {item:6866}; o marido dela, {npc:6178}, descansa no mesmo andar. Guarde o símbolo: você precisa dele com {npc:6177}. Se o perder, {npc:6179} dá outro (O {item:6866}).",

	-- Step 17: Narm Faulk
	-- {npc:6177} Narm Faulk · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:131} Kharanos · {area:212} Helm's Bed Lake · {object:147516} Dark Iron (no name in this language: may be words) · {item:6866} Symbol of Life
	["{npc:6177} lies dead in {zone:1426}, not {zone:1432}: east past {area:131}, north-east of Ironband's compound, on the smallest of three little hills between {area:212} and the {object:147516} camp. Target his body and use the {item:6866} to raise him, then speak to him. If another paladin just raised him, his body is back within about three minutes."] = "{npc:6177} jaz morto em {zone:1426}, não em {zone:1432}: a leste de {area:131}, a nordeste do complexo de Bandaferro, na menor de três colinas pequenas entre {area:212} e o acampamento {object:147516}. Selecione o corpo dele e use o {item:6866} para ressuscitá-lo, depois fale com ele. Se outro paladino acabou de ressuscitá-lo, o corpo volta em cerca de três minutos.",
	-- {item:6866} Symbol of Life · {npc:6177} Narm Faulk
	["{item:6866} on {npc:6177}'s body"] = "{item:6866} no corpo de {npc:6177}",

	-- Step 18: The Dark Iron Script
	-- {item:6847} Dark Iron Script
	["The {item:6847}"] = "A {item:6847}",
	-- {item:6847} Dark Iron Script
	["The Dark Iron Spies (level 9-11, twelve of them) sneak around the little house below the lake, just south of Narm; you see them from his hill. About one kill in two drops the {item:6847}. They run for help at low health: finish them or step back. They respawn in three minutes."] = "Os Espiões Ferro Negro (nível 9-11, doze deles) se esgueiram em volta da casinha abaixo do lago, logo ao sul do Narm; dá para vê-los do morro dele. Mais ou menos um em dois deixa cair a {item:6847}. Eles fogem atrás de ajuda com pouca vida: acabe com eles ou recue. Renascem em três minutos.",
	-- {item:6847} Dark Iron Script
	["{item:6847}: Dark Iron Spies"] = "{item:6847}: Espiões Ferro Negro",

	-- Step 19: Redemption
	-- {object:32386} Hall of Mysteries (no name in this language: may be words) · {npc:6178} Muiredon Battleforge · {npc:6179} Tiza Battleforge · {spell:7328} Redemption
	["Back up to the {object:32386}: {npc:6178} takes the script, {npc:6179} teaches you {spell:7328}."] = "De volta ao {object:32386}: {npc:6178} pega o texto, {npc:6179} ensina {spell:7328} a você.",
}
