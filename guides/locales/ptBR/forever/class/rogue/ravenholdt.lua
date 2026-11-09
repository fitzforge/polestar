-- Portuguese (Brazil) (ptBR): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor · {npc:13085} Myrokos Silentform
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and {npc:13085}'s jobs against the Syndicate."] = "Abre {area:3486}, a casa secreta dos ladinos nas colinas de Alterac, e os trabalhos de {npc:13085} contra a Camarilha.",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "Reputação com {npc:13936}",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "A {item:17126}",
	-- {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad · {spell:1846} Detect Traps
	["At 24 any capital's rogue trainer ({npc:332} or {npc:918} in {zone:1453}, Gest or Ormok in {zone:1454}, and the others) has an {item:17126} from {npc:13936} for you: ask for it in their talk window. Open it: the quest gives you the {item:17125} for {npc:6707}. Learn {spell:1846} from your trainer first if you have not; the way in is a test of it."] = "No nível 24, o instrutor de ladino de qualquer capital ({npc:332} ou {npc:918}, em {zone:1453}, Gest ou Ormok, em {zone:1454}, e os demais) tem para você {item:17126}, de {npc:13936}: peça na janela de conversa. Abra: a missão entrega {item:17125} para {npc:6707}. Aprenda {spell:1846} com seu instrutor antes, se ainda não aprendeu; o caminho até lá é um teste dela.",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {spell:1846} Detect Traps · {area:3486} Ravenholdt Manor · {npc:6707} Fahrad · {npc:13936} Ravenholdt
	["Horde fly to {area:272}, Alliance to {area:271}. The trail to the manor is hard to see: it starts behind the plateau north of {area:275}, east of {area:272}, climbs into the hills and bends twice to a small tunnel. A chest sits in the tunnel: do not open it. Cast {spell:1846} near it and walk up close; that is the Rite of Cunning (it comes back after 5 minutes). Opening the chest calls Milton, an elite rogue of about level 32. Through the tunnel lies {area:3486}: {npc:6707} is upstairs inside. Do not attack anyone at the manor: it costs {npc:13936} reputation."] = "A Horda voa para {area:272}, a Aliança para {area:271}. A trilha até a mansão é difícil de ver: começa atrás do planalto ao norte de {area:275}, a leste de {area:272}, sobe pelas colinas e faz duas curvas até um túnel pequeno. Há um baú no túnel: não abra. Lance {spell:1846} perto dele e chegue bem perto; isso é o Rito da Astúcia (volta depois de 5 minutos). Abrir o baú chama Milton, um ladino elite de uns nível 32. Depois do túnel fica {area:3486}: {npc:6707} está lá dentro, no andar de cima. Não ataque ninguém na mansão: isso custa reputação com {npc:13936}.",
	-- {spell:1846} Detect Traps
	["Rite of Cunning: {spell:1846} beside the tunnel chest"] = "Rito da Astúcia: {spell:1846} ao lado do baú do túnel",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable; take it now, the emblems are quest items"] = "{npc:6766}: {quest:6701}, repetível; pegue agora, os emblemas são itens de missão",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {npc:13085} Myrokos Silentform · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Rogues = {npc:2260} Syndicate Rogue
	["{npc:266216} is inside {area:275}, the Syndicate fortress south of the manor; he can stand in any of fifteen spots in the keep, so search. Quick and quiet, says {npc:13085}. Pick the pockets of the level 20-21 Syndicate Rogues, Shadow Mages and Watchmen on your way: they carry {quest:6701} for the guards' repeatable reputation quest."] = "{npc:266216} está dentro de {area:275}, a fortaleza da Camarilha ao sul da mansão; ele pode estar em qualquer um de quinze pontos da fortaleza, então procure. Rápido e em silêncio, diz {npc:13085}. Bata a carteira dos Ladinos da Camarilha, Magos das Sombras e Vigias de nível 20-21 pelo caminho: eles carregam {quest:6701}, para a missão repetível de reputação dos guardas.",
	-- {quest:6701} Syndicate Emblems
	["Pick Pocket Syndicate members for {quest:6701}"] = "{quest:6701}: bata a carteira de membros da Camarilha",

	-- Step 4: Myrokos Silentform
	-- {npc:6766} Ravenholdt Guard
	["{npc:6766}: one emblem each time, 100 reputation"] = "{npc:6766}: um emblema por vez, 100 de reputação",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains · {spell:921} Pick Pocket
	["In your mid 30s {npc:13085} has two more jobs; take both. Barton leads a Syndicate scouting party at {area:280}, in the east of the {zone:1416}, inside one of the houses with stealthed Syndicate around him. Pick his pocket for the report and do not kill him: he does not drop it. If you are lower than him he sees through stealth; Master of Deception helps, or Distract him, Vanish and come in from behind. {spell:921} can miss several times in a row."] = "Perto do nível 35, {npc:13085} tem mais dois trabalhos; pegue os dois. Barton lidera um grupo de reconhecimento da Camarilha em {area:280}, no leste de {zone:1416}, dentro de uma das casas, com a Camarilha em furtividade ao redor dele. Bata a carteira dele para pegar o relatório e não o mate: ele não solta. Se você tem nível menor que o dele, ele enxerga através da furtividade; Mestre da Enganação ajuda, ou use Distração, Sumir e entre por trás. {spell:921} pode errar várias vezes seguidas.",
	-- {item:275482} Barton's Scouting Report
	["Pick Pocket Barton for {item:275482}"] = "{item:275482}: bata a carteira de Barton",

	-- Step 6: Covert Extraction
	-- {npc:13085} Myrokos Silentform · {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["Back to {npc:13085}; the report sends you after the Perenolde heirlooms. Two towers stand among the {area:281}, in the middle of the {zone:1416}, held by ogres: the shield lies in the northern tower, the sword in the southern one, which elite ogres ring and watch from far off. Stay stealthed; nothing guards the heirlooms inside."] = "De volta a {npc:13085}; o relatório manda você atrás das relíquias dos Perenolde. Duas torres ficam entre {area:281}, no meio de {zone:1416}, ocupadas por ogros: o escudo está na torre do norte, a espada na do sul, que é cercada de ogros elite e vigiada de longe. Fique em furtividade; nada guarda as relíquias lá dentro.",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, in the northern tower"] = "{item:275636}, na torre do norte",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, in the southern tower"] = "{item:275635}, na torre do sul",

	-- Step 7: A Way In
	-- {area:324} Stromgarde Keep · {area:313} Northfold Manor · {object:656157} Syndicate Footlocker (no name in this language: may be words) · {quest:96783} A Way In
	["{area:324} in western Arathi is a Syndicate stronghold; to get in you need a uniform. {area:313}, in north-western Arathi, is held by Syndicate Highwaymen, Pathstalkers and Mercenaries (level 30-32): find the {object:656157} there and take the uniform; that ends {quest:96783}."] = "{area:324}, no oeste de Arathi, é uma fortaleza da Camarilha; para entrar, você precisa de um uniforme. {area:313}, no noroeste de Arathi, é ocupada por Bandoleiros, Tocaiantes e Mercenários da Camarilha (nível 30-32): ache {object:656157} ali e pegue o uniforme; isso encerra {quest:96783}.",
	-- {quest:96784} Master of Disguise · {item:275706} Syndicate Uniform
	["{quest:96784}: the {item:275706}"] = "{quest:96784}: {item:275706}",

	-- Step 8: Anastasia Miller
	-- {item:275706} Syndicate Uniform · {quest:96784} Master of Disguise · {quest:96785} Ain't No Telling · {npc:266847} Anastasia Miller
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Stromgarde's Syndicate Prowlers and Conjurors are elite (level 35-36): a rogue of 36 can slip past them, but fighting one alone is hard, so stay hidden or bring a friend. Put on the {item:275706} ({quest:96784} hands it to you at the footlocker) to pass as one of them; stealth or suspicious acts can break it. If the footlocker gave you no uniform, Anastasia hands you one with {quest:96785}. {npc:266847} is not inside the keep: she stands on a ledge on the outside of the castle wall. Jump across to it from the roof of the house beside the ledge."] = "Os Predadores e Conjuradores da Camarilha de Stromgarde são elite (nível 35-36): um ladino de nível 36 consegue passar por eles, mas lutar com um sozinho é difícil, então fique escondido ou leve um amigo. Vista {item:275706} ({quest:96784} entrega no baú) para passar por um deles; furtividade ou atos suspeitos podem quebrar o disfarce. Se o baú não deu o uniforme, Anastácia entrega um com {quest:96785}. {npc:266847} não está dentro da fortaleza: ela fica numa saliência do lado de fora da muralha do castelo. Pule até ela a partir do telhado da casa ao lado da saliência.",

	-- Step 9: Ain't No Telling
	-- {item:275709} Stolen Funds
	["She will not talk without something to bargain with. Her stash is upstairs in a house close to the keep: take the {item:275709}. If it is already open, wait for it to come back."] = "Ela não fala sem ter o que negociar. O esconderijo dela fica no andar de cima de uma casa perto da fortaleza: pegue {item:275709}. Se já estiver aberto, espere voltar.",
	-- {item:275709} Stolen Funds
	["{item:275709}: Anastasia's Stash"] = "{item:275709}: o esconderijo de Anastácia",

	-- Step 10: The Syndicate Sting
	-- {area:1057} Thoradin's Wall · {area:287} Hillsbrad · {item:275882} Intercepted Shipment · {item:275706} Syndicate Uniform · {npc:13085} Myrokos Silentform
	["Falconcrest's men make the handoff at the southern end of {area:1057}, the old wall between Arathi and {area:287}. Kill the two guarding the box and take the {item:275882}. Keep the {item:275706}: {npc:13085} wants it back with the shipment."] = "Os homens de Falcocrista fazem a entrega na ponta sul de {area:1057}, a velha muralha entre Arathi e {area:287}. Mate os dois que guardam a caixa e pegue {item:275882}. Guarde {item:275706}: {npc:13085} quer de volta, junto com a carga.",

	-- Step 11: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "De volta a {npc:13085}",
	-- {npc:13085} Myrokos Silentform · {npc:13936} Ravenholdt
	["{npc:13085}: 70 silver, 300 {npc:13936} reputation"] = "{npc:13085}: 70 pratas, 300 de reputação com {npc:13936}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "No nível 24, uma {item:17126} de {npc:13936} inicia isto; os dados a entregam por {npc:332} ou {npc:918} em {zone:1453}, ou por Gest ou Ormok em {zone:1454}. A missão dá a você o {item:17125} para {npc:6707}.",
	-- ["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "No nível 36, {npc:13085} manda você atrás do relatório de patrulha de Barton. Barton lidera um grupo da Camarilha em {area:280}, no leste das {zone:1416}: bata a carteira dele, não o mate.",
	-- ["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "A Horda voa para {area:272}, a Aliança para {area:271}. O solar se esconde nas colinas a leste de {area:272}, subindo uma trilha para as {zone:1416}; o Rito da Astúcia passa pelo caminho.",
	-- ["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "Abre {area:3486}, a casa secreta dos ladinos nas colinas de Alterac, e seus primeiros trabalhos.",
	-- ["Rite of Cunning"] = "Rito da Astúcia",
	-- ["{item:275482}: pickpocket Barton"] = "{item:275482}: bata a carteira de Barton",
	-- ["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216} está dentro de {area:275}, a fortaleza da Camarilha no leste de {area:287}, ao sul do solar. Rápido e silencioso, diz {npc:13085}.",
	-- ["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766}: {quest:6701}, repetível",
}
