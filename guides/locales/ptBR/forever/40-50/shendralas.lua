-- Portuguese (Brazil) (ptBR): the guide forever/40-50/shendralas (forever/40-50/shendralas.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1444} Feralas
	["About a dozen quests on a short trip into Forever's new zone (about 45-46 for the Alliance, 47 for the Horde), then on to {zone:1444}."] = "Cerca de uma dúzia de missões numa rápida passagem pela nova zona do Forever (por volta do nível 45-46 para a Aliança, 47 para a Horda), depois siga para {zone:1444}.",

	-- Step 1: North into Desolace
	-- {area:405} Desolace
	["North into {area:405}"] = "Para o norte, até {area:405}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:1099} Camp Mojache · {area:2577} Dire Maul
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. From {area:1099} ride north-west on the road past {area:2577} and on north into {area:405}: the road comes out on {area:405}'s southern edge."] = "Novidade do Forever: este guia segue o que os jogadores fizeram em {zone:2652}. Se uma etapa estiver errada, avise no Discord ou no GitHub do Polestar e diga qual é a etapa.\n{zone:2652} fica ao sul de {area:405}, passando por {area:2657}, e não tem rota de voo própria. De {area:1099}, siga para o noroeste pela estrada, passando por {area:2577}, e continue para o norte até {area:405}: a estrada sai na borda sul de {area:405}.",
	-- {area:405} Desolace · {zone:1444} Feralas
	["{area:405}, where the road from {zone:1444} comes in"] = "{area:405}, onde chega a estrada que vem de {zone:1444}",

	-- Step 2: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "Voe para {area:2408}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the zeppelin to {zone:1454} first (from {object:3202} or the {zone:1458})."] = "Novidade do Forever: este guia segue o que os jogadores fizeram em {zone:2652}. Se uma etapa estiver errada, avise no Discord ou no GitHub do Polestar e diga qual é a etapa.\n{zone:2652} fica ao sul de {area:405}, passando por {area:2657}, e não tem rota de voo própria. As missões são para os níveis 41-45. Se vier dos Reinos do Leste, pegue antes o zepelim para {zone:1454} (em {object:3202} ou em {zone:1458}).",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 3: Fly to Nijel's Point
	-- {area:608} Nijel's Point
	["Fly to {area:608}"] = "Voe para {area:608}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:150} Menethil Harbor
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the boat from {area:150} to Theramore first."] = "Novidade do Forever: este guia segue o que os jogadores fizeram em {zone:2652}. Se uma etapa estiver errada, avise no Discord ou no GitHub do Polestar e diga qual é a etapa.\n{zone:2652} fica ao sul de {area:405}, passando por {area:2657}, e não tem rota de voo própria. As missões são para os níveis 41-45. Se vier dos Reinos do Leste, pegue antes o barco de {area:150} para Theramore.",

	-- Step 4: Into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Into the {area:2657}"] = "Entrando em {area:2657}",
	-- {area:405} Desolace · {area:2408} Shadowprey Village · {area:606} Gelkis Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride east along {area:405}'s southern edge (from {area:2408}: past {area:606}): the {area:2657} opens there into {area:16651}."] = "Siga para o leste pela borda sul de {area:405} (saindo de {area:2408}: passando por {area:606}): ali {area:2657} se abre para {area:16651}.",

	-- Step 5: Into the Valley of Bones
	-- {area:608} Nijel's Point · {area:405} Desolace · {area:604} Magram Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride south from {area:608} down the road through eastern {area:405} to {area:604}: just past its western edge the path climbs into the {area:2657} and {area:16651}."] = "De {area:608}, siga para o sul pela estrada no leste de {area:405} até {area:604}: logo depois da borda oeste da vila, o caminho sobe para {area:2657} e {area:16651}.",

	-- Step 6: The Valley of Bones: a Tattered Journal
	-- {area:2657} Valley of Bones · {quest:93644} Tattered Journal
	["The {area:2657}: a {quest:93644}"] = "{area:2657}: {quest:93644}",
	-- {quest:93644} Tattered Journal · {zone:2652} Shen'dralas · {area:2657} Valley of Bones
	-- plural, as words: Outcast Necromancers = {npc:11559} Outcast Necromancer · Magram Necromancers = {npc:253272} Magram Necromancer
	-- was: ["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "Novidade do Forever: se uma etapa estiver errada, avise no Discord ou no GitHub do Polestar e diga qual é a etapa.\nOs Necromantes Proscritos e os Necromantes Magram do vale dropam {quest:93644}, cujo autor vive em {zone:2652}: os jogadores conseguiram em poucas mortes. Os centauros Magram não atacam até você atacar; os Necrocãs Magram entre eles (nível 45) são elites: deixe-os em paz.\nOs centauros Gelkis e Magram têm cadeias de missões próprias em {area:2657}, que valem uns 20.000 a 30.000 de experiência a mais, mas cada cadeia exige Honrado com o clã. Os dois clãs são rivais, então trabalhe para um deles: o guia de Reputação com os Centauros Gelkis e Magram, em Reputação, mostra como."
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. Take it from the Outcast Necromancers and leave the Magram alone: the Magram centaurs leave you be until you attack, but once you have killed Magram the whole clan turns on you, and their Necrokhans (level 45, elites) stand around the western pylon you repair later.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "",

	-- Step 7: The western pylon
	["The western pylon"] = "O pilar do oeste",
	-- {quest:92914} Strange Pylons
	-- plural, as words: Decrepit Pylon Protectors = {npc:252711} Decrepit Pylon Protector · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here.\nCareful: click the crystal from the road on its west side and move on: the Protectors stand two and three together east and north-east of it, where Corpsefeeders and the Magram Necrokhans (elites, 45) walk too."] = "",

	-- Step 8: Bristleback Retreat: the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: the eastern pylon"] = "{area:16677}: o pilar do leste",
	-- {area:16677} Bristleback Retreat · {npc:253527} Kog'thug the Brave
	["East along the valley road to the quilboar of {area:16677}: the second pylon stands at the eastern end of their camp. A Corpsefeeder (level 45, elite) walks this road: let it pass. The Bristlebacks (levels 42-43) attack on sight; {npc:253527} (level 43, elite) and his bodyguards hold the south side of the camp."] = "Siga para o leste pela estrada do vale até os javaleses de {area:16677}: o segundo pilar fica na ponta leste do acampamento. Um Devorador de Cadáveres (nível 45, elite) anda por essa estrada: deixe-o passar. Os Cerdas-Brutas (níveis 42-43) atacam ao avistar você; {npc:253527} (elite nível 43) e seus guarda-costas ocupam o lado sul do acampamento.",
	["the eastern pylon"] = "o pilar do leste",

	-- Step 9: The temple of Shen'dralas: the third pylon
	-- {zone:2652} Shen'dralas
	["The temple of {zone:2652}: the third pylon"] = "O templo de {zone:2652}: o terceiro pilar",
	["South to the Shen'dralar temple at the zone's heart, keeping west of Kog'thug's bodyguards: the third pylon stands inside. The temple's guards are neutral: leave them be."] = "Siga para o sul até o templo Shen'dralar no coração da zona, mantendo-se a oeste dos guarda-costas de Kog'thug: o terceiro pilar fica lá dentro. Os guardas do templo são neutros: deixe-os em paz.",

	-- Step 10: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93644} Tattered Journal
	["North-west from the temple to {npc:253471}'s camp on the overlook, beside the spirit healer: the {quest:93644} is his, and he wants to hear about the pylons."] = "Do templo, siga para o noroeste até o acampamento de {npc:253471} no mirante, ao lado do curandeiro espiritual: {quest:93644} é dele, e ele quer saber dos pilares.",

	-- Step 11: North into Desolace
	-- {npc:253471} Mordent Evenshade · {area:405} Desolace · {area:604} Magram Village
	["{npc:253471} wants a fragment and a shard of the pylons back from {area:405}'s two centaur villages: {area:604} lies just beyond the valley's northern way out.\nCareful: if you have killed Magram or Gelkis centaurs, that clan's guards may attack you when you walk into its village."] = "{npc:253471} quer de volta um fragmento e um estilhaço dos pilares, que estão nas duas aldeias centauras de {area:405}: {area:604} fica logo depois da saída norte do vale.\nCuidado: se você matou centauros Magram ou Gelkis, os guardas desse clã podem atacar você quando entrar na aldeia dele.",

	-- Step 12: Magram Village
	-- {item:255656} Pylon Fragment
	-- plural, as words: Magram Guardians = {npc:255560} Magram Guardian
	["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it. They leave you be unless you have fought the Magram: pick the fragment up without a fight. Every Magram you kill turns the clan against you, and back in the valley that means the Necrokhans (level 45, elites) at the western pylon as well."] = "",

	-- Step 13: Gelkis Village
	-- {area:405} Desolace · {area:606} Gelkis Village · {item:255657} Pylon Shard
	-- plural, as words: Gelkis Guardians = {npc:255561} Gelkis Guardian
	["West along {area:405}'s southern edge to {area:606}: the {item:255657} lies at its southern end, watched by Gelkis Guardians (levels 39-41)."] = "Para oeste pela borda sul de {area:405} até {area:606}: o {item:255657} fica na ponta sul, vigiado por Guardiões Gelkis (níveis 39-41).",

	-- Step 14: Back into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Back into the {area:2657}"] = "De volta a {area:2657}",
	-- {area:405} Desolace · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["East again along {area:405}'s southern edge: the {area:2657} opens into {area:16651}."] = "Para leste de novo pela borda sul de {area:405}: {area:2657} dá acesso a {area:16651}.",

	-- Step 16: The temple: the Mana Sieve
	-- {item:255662} Mana Sieve
	["The temple: the {item:255662}"] = "O templo: o {item:255662}",
	-- {npc:253471} Mordent Evenshade · {item:255662} Mana Sieve · {npc:255486} Historian Biraxas · {quest:96018} Powering the Pylons
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["{npc:253471} sends you for the {item:255662}, kept inside the temple beside {npc:255486}. {quest:96018} asks you to gather mana with the Sieve before you repair the pylons: with it in your bags you can handle the Unstable Mana Rifts, the floating sparks of mana all along the road north."] = "{npc:253471} manda você buscar o {item:255662}, guardado dentro do templo ao lado de {npc:255486}. {quest:96018} pede que você colete mana com o Filtro antes de consertar os pilares: com ele na bolsa, você pode interagir com as Fendas de Mana Instáveis, as faíscas de mana flutuantes ao longo de toda a estrada para o norte.",

	-- Step 17: Four crystals for the first unfinished pylon
	["Four crystals for the first unfinished pylon"] = "",
	-- {item:255662} Mana Sieve
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["Use the {item:255662} on Unstable Mana Rifts north of the temple. Each repair spends four crystals. If both pylons are unfinished, gather eight here or refill on the valley road after the western repair. If only one is unfinished, four are enough. Let the wandering elite Protectors pass."] = "",
	-- {item:255662} Mana Sieve · {npc:264149} Unstable Mana Rift
	["{item:255662} on an {npc:264149}"] = "",
	-- plural, as words: Coalesced Mana Crystals = {item:255667} Coalesced Mana Crystal
	["Coalesced Mana Crystals for one repair"] = "",

	-- Step 18: The road south of the western pylon
	["The road south of the western pylon"] = "",
	-- {area:16677} Bristleback Retreat · {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift · Magram Necrokhans = {npc:253274} Magram Necrokhan · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["Check the western repair in your quest log. If it is already checked, do not visit this waypoint: take four crystals east to {area:16677} (73.4,23.9). Enter from the west and stay off the south side, away from Kog'thug and his bodyguards. Repair the eastern pylon there; the route resumes when the log shows both.\nNorth up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Stop where the arrow points, on the road just south of the pylon, keeping to its west edge: the quiet side, with no Protectors behind you. Pull one {npc:252711} at a time down to that spot, the one nearest the pylon's south side first, and kill it there; then step up to the pylon's west side and use {spell:1289727}, as players did to repair it.\nCareful: stay off the pylon's east and north-east side. The Protectors stand there two and three together, a Corpsefeeder (level 45, elite) walks among them and the Magram Necrokhans (elites, 45) stand just beyond: nearly every recorded death at this pylon happened east of it. If the Magram attack you (they do once you have killed Magram), wait at the arrow until any Necrokhan by the pylon walks off before you pull. Nascent Pylon Protectors (elites, 43) wander the road south of it: let them pass.\nIf you die here, walk your ghost back to the arrow before you come back to life: players who rose beside the pylon died again within seconds."] = "",
	["the road just south of the western pylon"] = "",

	-- Step 19: The western pylon: repair it
	["The western pylon: repair it"] = "O pilar oeste: conserte-o",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon
	["Pull one {npc:252711} back to the road if it guards the crystal. Stand on the west face and use {spell:1289727}. The quest log must show the western pylon repaired; a dead Protector alone does not count."] = "",
	["Repair the western pylon from this side"] = "",

	-- Step 20: Four crystals for the eastern pylon
	["Four crystals for the eastern pylon"] = "",
	-- {area:16677} Bristleback Retreat
	["Check your bags after the western repair. If fewer than four crystals remain, use the Sieve on rifts along the valley road before entering {area:16677}. Give roaming Corpsefeeders and hostile Necrokhans room."] = "",
	-- plural, as words: Coalesced Mana Crystals = {item:255667} Coalesced Mana Crystal
	["Four unspent Coalesced Mana Crystals"] = "",

	-- Step 21: Bristleback Retreat: repair the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: repair the eastern pylon"] = "{area:16677}: conserte o pilar leste",
	-- {npc:252711} Decrepit Pylon Protector · {spell:1289727} Repair and Recharge Pylon · {npc:253527} Kog'thug the Brave
	["Enter from the west. Pull a single {npc:252711} clear if needed, then use {spell:1289727} at the eastern crystal. Keep away from {npc:253527} and his bodyguards on the south side of the camp."] = "",
	-- {npc:253471} Mordent Evenshade
	["Repair the eastern pylon, then return to {npc:253471}"] = "",

	-- Step 22: Unfinished pylon repairs
	["Unfinished pylon repairs"] = "",
	-- {npc:253471} Mordent Evenshade · {area:16677} Bristleback Retreat · {zone:2652} Shen'dralas · {zone:1444} Feralas
	["Check your quest log before going back to {npc:253471}. Each unchecked pylon needs four crystals from the rifts. For the western repair, approach from the road at 43.9,37.0 and use the west face. For the eastern repair, enter {area:16677} from the west. Return to {npc:253471} only after both repairs count.\nIf you want to leave {zone:2652} now, keep the quest. This line takes you back to your {zone:1444} route; you can return for the unfinished repair later."] = "",
	-- {zone:2652} Shen'dralas
	["Leave {zone:2652} with the repair quest in my log"] = "",

	-- Step 23: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade
	["Follow the valley road west and south to {npc:253471} with both repairs finished."] = "",

	-- Step 24: A Brief History Lesson
	-- {npc:253471} Mordent Evenshade
	["Hear {npc:253471} out, then speak to him again for the reward."] = "",
	-- {npc:253471} Mordent Evenshade
	["{npc:253471}: hear him out"] = "{npc:253471}: escute-o",

	-- Step 26: Liranne
	-- {quest:93568} Partially Digested Collar · {npc:255385} Liranne
	["A Prowler gave up a {quest:93568}: {npc:255385}, north of the temple, knows whose it was."] = "Um Espreitador deixou cair um {quest:93568}: {npc:255385}, ao norte do templo, sabe de quem era.",

	-- Step 27: The temple: Magister Kirandis
	-- {npc:254656} Magister Kirandis
	["The temple: {npc:254656}"] = "O templo: {npc:254656}",
	-- {npc:254656} Magister Kirandis · {npc:254578} Mithera · {quest:93341} Forlorn Gardens
	["{npc:254656} waits inside the temple. Then {npc:254578}, on the temple's eastern side, has work in the {quest:93341}."] = "{npc:254656} espera dentro do templo. Depois, {npc:254578}, no lado leste do templo, tem trabalho em {quest:93341}.",

	-- Step 28: The Forlorn Gardens: the pedestal
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}: the pedestal"] = "{quest:93341}: o pedestal",
	-- {quest:93341} Forlorn Gardens
	["East of the temple the {quest:93341} have run wild, and their plants attack on sight. Examine the pedestal at the gardens' southern end."] = "A leste do templo, {quest:93341} ficaram selvagens, e as plantas atacam à primeira vista. Examine o pedestal na ponta sul dos jardins.",

	-- Step 30: Mithera’s garden errands
	-- {npc:254578} Mithera
	["{npc:254578}’s garden errands"] = "",

	-- Step 31: The Forlorn Gardens
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}"] = "{quest:93341}",
	-- {npc:254674} Woodwyrd · {area:2100} Maraudon
	-- plural, as words: Rowdy Roses = {npc:254566} Rowdy Rose · Terrible Tulips = {npc:254567} Terrible Tulip · Malevolent Marigolds = {npc:254572} Malevolent Marigold · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["Rowdy Roses and Terrible Tulips grow all over the gardens; the Malevolent Marigolds keep to the northern part. {npc:254674}, the treant in the middle of the gardens, has a request of his own that needs water from {area:2100}, a dungeon: this guide leaves it.\nThe Shen'dralar who wander the gardens are neutral, like the temple's guards: leave them be and pull the flowers away from them. Careful: Nascent Pylon Protectors (elites, 43) wander the zone's middle, the gardens too: keep clear of them."] = "Rosas Rebeldes e Tulipas Terríveis crescem por todos os jardins; os Malmequeres Malévolos ficam na parte norte. {npc:254674}, o arvoroso no meio dos jardins, tem um pedido próprio que precisa de água de {area:2100}, uma masmorra: este guia o deixa de lado.\nOs Shen'dralar que andam pelos jardins são neutros, como os guardas do templo: deixe-os em paz e puxe as flores para longe deles. Cuidado: Protetores de Pilar Nascentes (elites, 43) rondam o meio da zona, inclusive os jardins: fique longe deles.",

	-- Step 33: The temple: Historian Biraxas
	-- {npc:255486} Historian Biraxas
	["The temple: {npc:255486}"] = "",
	-- {npc:255486} Historian Biraxas · {npc:254656} Magister Kirandis · {npc:252711} Decrepit Pylon Protector
	["{npc:255486}, inside the temple, has a task for you now that you have met {npc:254656}: the heart of a {npc:252711} (42-43, not elite), a short ride back up the road north."] = "{npc:255486}, dentro do templo, tem uma tarefa para você agora que conheceu {npc:254656}: o coração de um {npc:252711} (42-43, não elite), um pouco de volta pela estrada ao norte.",

	-- Step 34: A Heart of Crystal
	-- {npc:252711} Decrepit Pylon Protector
	["Use the west face of the western pylon, where you repaired it. Approach on the road from the south and pull one {npc:252711} back to you. Wait for the elite patrols to pass; do not follow a Protector around the east side."] = "",

	-- Step 36: Mana Mania
	-- {item:286647} Depleted Crystal Heart · {npc:264149} Unstable Mana Rift · {npc:276401} Nascent Pylon Protector
	["Take the {item:286647} to an {npc:264149} on the road north of the temple and throw it into the rift. The {npc:276401} is elite: grouping up is advised."] = "",

	-- Step 37: Shadowprey Village
	-- {zone:2652} Shen'dralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:2408} Shadowprey Village · {area:1637} Orgrimmar · {zone:1444} Feralas · {area:1099} Camp Mojache
	["{zone:2652} is done. Ride back north through the {area:2657} and west along {area:405}'s southern edge to {area:2408}: the next guide picks up in {area:1637}, with the {zone:1444} guide's hand-ins. Your hearthstone is bound at {area:1099}: if it is ready, hearth there and fly to {area:1637} from {area:1099} instead."] = "{zone:2652} concluída. Volte para o norte pelo {area:2657} e para oeste pela borda sul de {area:405} até a {area:2408}: o próximo guia continua em {area:1637}, com as entregas do guia de {zone:1444}. Sua Pedra de Regresso está vinculada a {area:1099}: se ela estiver pronta, use-a e voe de {area:1099} para {area:1637}.",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Mestre de voo da {area:2408}",

	-- Step 38: Back to your route
	["Back to your route"] = "De volta à sua rota",
	-- {zone:2652} Shen'dralas · {zone:1444} Feralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["{zone:2652} is done. Your {zone:1444} guide picks up from here: ride back north through the {area:2657}, west along {area:405}'s southern edge and south into {zone:1444}, to the dock on the {area:1108} where the boat crosses to {area:1116}."] = "{zone:2652} concluída. Seu guia de {zone:1444} continua daqui: volte para o norte pelo {area:2657}, para oeste pela borda sul de {area:405} e para o sul até {zone:1444}, até o cais na {area:1108}, de onde o barco atravessa para {area:1116}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the valley road and south to {npc:253471}. {quest:93016} asks you to hear him out: talk to him once more, then hand it in."] = "Volte para o oeste pela estrada do vale e depois para o sul até {npc:253471}. {quest:93016} pede que você o escute: fale com ele mais uma vez e depois entregue a missão.",
	-- ["East along the valley road to the eastern pylon and repair it the same way, a {npc:252711} first, coming in from the west: {npc:253527} (level 43, elite) and his bodyguards hold the south side of the quilboar camp, and a Corpsefeeder (level 45, elite) walks the road."] = "Siga a estrada do vale para o leste até o pilar leste e conserte-o do mesmo jeito, primeiro um {npc:252711}, chegando pelo oeste: {npc:253527} (elite nível 43) e seus guarda-costas ocupam o lado sul do acampamento dos javaligenos, e um Devorador de Cadáveres (elite nível 45) anda pela estrada.",
	-- ["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here."] = "Siga para o leste pelo vale até o estranho cristal no pedestal: clicar nele inicia {quest:92914}. Os Protetores de Pilar Decrépitos (níveis 42-43) ao redor são os elementais de mana que o guardam. Devoradores de Cadáveres (nível 45, elite) vagam pelo vale a leste daqui.",
	-- ["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "Novidade do Forever: se uma etapa estiver errada, avise no Discord ou no GitHub do Polestar e diga qual é a etapa.\nOs Necromantes Proscritos e os Necromantes Magram do vale dropam {quest:93644}, cujo autor vive em {zone:2652}: os jogadores conseguiram em poucas mortes. Os centauros Magram não atacam até você atacar; os Necrocãs Magram entre eles (nível 45) são elites: deixe-os em paz.\nOs centauros Gelkis e Magram têm cadeias de missões próprias em {area:2657}, que valem uns 20.000 a 30.000 de experiência a mais, mas cada cadeia exige Honrado com o clã. Os dois clãs são rivais, então trabalhe para um deles: o guia de Reputação com os Centauros Gelkis e Magram, em Reputação, mostra como.",
	-- ["North up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Decrepit Pylon Protectors guard it: kill one beside the pylon, then use {spell:1289727} on it, as players did to repair it.\nCareful: the pylon stands at the edge of the {area:2657}, where Magram Necrokhans and Corpsefeeders (elites, level 45) walk, and Nascent Pylon Protectors (elites, 43) wander the road. Pull the Decrepit Pylon Protectors away from them before you repair it."] = "Siga a estrada para o norte até o primeiro pilar, coletando mana das Fendas de Mana Instáveis pelo caminho. Protetores de Pilar Decrépitos o guardam: mate um ao lado do pilar e depois use {spell:1289727} nele para consertá-lo.\nCuidado: o pilar fica na borda de {area:2657}, onde andam Necrocãs Magram e Devoradores de Cadáveres (elites, nível 45), e Protetores de Pilar Nascentes (elites, 43) vagam pela estrada. Afaste os Protetores de Pilar Decrépitos deles antes de consertar o pilar.",
	-- ["The nearest Decrepit Pylon Protectors stand by the road north, from the middle of the zone up to the western pylon, and around {npc:253471}'s overlook: one of them carries the heart Biraxas wants."] = "Os Protetores de Pilar Decrépitos mais próximos ficam junto à estrada ao norte, do meio da zona até o pilar oeste, e em volta do mirante de {npc:253471}: um deles carrega o coração que Biraxas quer.",
	-- ["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it."] = "O {item:255656} fica na borda oeste da aldeia, vigiado por Guardiões Magram (níveis 39-41).",
	-- ["{npc:252711}, then {spell:1289727} on it"] = "{npc:252711}, depois {spell:1289727} nele",
	-- ["{zone:2652} is done: ride back north through the {area:2657}; the next step says where your route goes on from there."] = "{zone:2652} concluída: volte para o norte pelo {area:2657}; a próxima etapa diz para onde sua rota segue dali.",
}
