-- Spanish (Latin America) (esMX): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor · {npc:13085} Myrokos Silentform
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and {npc:13085}'s jobs against the Syndicate."] = "Abre {area:3486}, la casa oculta de los pícaros en las colinas de Alterac, y los trabajos de {npc:13085} contra el Sindicato.",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "Reputación con {npc:13936}",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "{item:17126}",
	-- {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad · {spell:1846} Detect Traps
	["At 24 any capital's rogue trainer ({npc:332} or {npc:918} in {zone:1453}, Gest or Ormok in {zone:1454}, and the others) has an {item:17126} from {npc:13936} for you: ask for it in their talk window. Open it: the quest gives you the {item:17125} for {npc:6707}. Learn {spell:1846} from your trainer first if you have not; the way in is a test of it."] = "A nivel 24, el instructor de pícaros de cualquier capital ({npc:332} o {npc:918} en {zone:1453}, Gest u Ormok en {zone:1454}, y los demás) tiene una {item:17126} de {npc:13936} para ti: pídesela en su ventana de diálogo. Ábrela: la misión te da {item:17125} para {npc:6707}. Aprende antes {spell:1846} con tu instructor si no la tienes; la entrada es una prueba de eso.",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {spell:1846} Detect Traps · {area:3486} Ravenholdt Manor · {npc:6707} Fahrad · {npc:13936} Ravenholdt
	["Horde fly to {area:272}, Alliance to {area:271}. The trail to the manor is hard to see: it starts behind the plateau north of {area:275}, east of {area:272}, climbs into the hills and bends twice to a small tunnel. A chest sits in the tunnel: do not open it. Cast {spell:1846} near it and walk up close; that is the Rite of Cunning (it comes back after 5 minutes). Opening the chest calls Milton, an elite rogue of about level 32. Through the tunnel lies {area:3486}: {npc:6707} is upstairs inside. Do not attack anyone at the manor: it costs {npc:13936} reputation."] = "La Horda vuela a {area:272}, la Alianza a {area:271}. El sendero a la mansión cuesta verlo: empieza detrás de la meseta al norte de {area:275}, al este de {area:272}, sube a las colinas y dobla dos veces hasta un pequeño túnel. Hay un cofre en el túnel: no lo abras. Lanza {spell:1846} cerca y acércate caminando; ese es el Rito de la Astucia (vuelve a los 5 minutos). Abrir el cofre llama a Milton, un pícaro élite de nivel 32 más o menos. Pasando el túnel está {area:3486}: {npc:6707} está adentro, en el piso de arriba. No ataques a nadie en la mansión: cuesta reputación con {npc:13936}.",
	-- {spell:1846} Detect Traps
	["Rite of Cunning: {spell:1846} beside the tunnel chest"] = "Rito de la Astucia: {spell:1846} junto al cofre del túnel",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {npc:13085} Myrokos Silentform · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Rogues = {npc:2260} Syndicate Rogue
	["{npc:266216} is inside {area:275}, the Syndicate fortress south of the manor; he can stand in any of fifteen spots in the keep, so search. Quick and quiet, says {npc:13085}. Pick the pockets of the level 20-21 Syndicate Rogues, Shadow Mages and Watchmen on your way: they carry {quest:6701} for the guards' repeatable reputation quest."] = "{npc:266216} está dentro de {area:275}, la fortaleza del Sindicato al sur de la mansión; puede estar en cualquiera de quince lugares del castillo, así que búscalo. Rápido y en silencio, dice {npc:13085}. Roba a los pícaros, magos de las sombras y vigilantes del Sindicato de nivel 20-21 en el camino: llevan {quest:6701} para la misión repetible de reputación de los guardias.",
	-- {quest:6701} Syndicate Emblems
	["Pick Pocket Syndicate members for {quest:6701}"] = "Roba a los miembros del Sindicato para {quest:6701}",

	-- Step 4: Myrokos Silentform
	-- {npc:6766} Ravenholdt Guard
	["{npc:6766}: one emblem each time, 100 reputation"] = "{npc:6766}: un emblema cada vez, 100 de reputación",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {npc:266357} Barton · {area:280} Strahnbrad · {zone:1416} Alterac Mountains · {spell:921} Pick Pocket
	["In your mid 30s {npc:13085} has two more jobs; take both. {npc:266357} leads a Syndicate scouting party at {area:280}, in the east of the {zone:1416}, inside one of the houses with stealthed Syndicate around him. Pick his pocket for the report and do not kill him: he does not drop it. If you are lower than him he sees through stealth; Master of Deception helps, or Distract him, Vanish and come in from behind. {spell:921} can miss several times in a row."] = "A mediados de tus treintas, {npc:13085} tiene dos trabajos más; toma ambos. {npc:266357} dirige una partida de exploración del Sindicato en {area:280}, en el este de {zone:1416}, dentro de una de las casas, con miembros del Sindicato en sigilo a su alrededor. Róbale el informe y no lo mates: no lo suelta. Si eres de menor nivel que él, te ve a través del sigilo; Maestro del engaño ayuda, o distráelo, usa Esfumarse y entra por detrás. {spell:921} puede fallar varias veces seguidas.",
	-- {item:275482} Barton's Scouting Report
	["Pick Pocket Barton for {item:275482}"] = "Roba a Barton para {item:275482}",

	-- Step 6: Covert Extraction
	-- {npc:13085} Myrokos Silentform · {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["Back to {npc:13085}; the report sends you after the Perenolde heirlooms. Two towers stand among the {area:281}, in the middle of the {zone:1416}, held by ogres: the shield lies in the northern tower, the sword in the southern one, which elite ogres ring and watch from far off. Stay stealthed; nothing guards the heirlooms inside."] = "De vuelta con {npc:13085}; el informe te manda tras las reliquias de los Perenolde. Hay dos torres entre {area:281}, en el centro de {zone:1416}, ocupadas por ogros: el escudo está en la torre norte y la espada en la sur, rodeada de ogros élite que vigilan desde lejos. Mantente en sigilo; nada custodia las reliquias adentro.",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, in the northern tower"] = "{item:275636}, en la torre norte",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, in the southern tower"] = "{item:275635}, en la torre sur",

	-- Step 7: A Way In
	-- {area:324} Stromgarde Keep · {area:313} Northfold Manor · {object:656157} Syndicate Footlocker (no name in this language: may be words) · {quest:96783} A Way In
	["{area:324} in western Arathi is a Syndicate stronghold; to get in you need a uniform. {area:313}, in north-western Arathi, is held by Syndicate Highwaymen, Pathstalkers and Mercenaries (level 30-32): find the {object:656157} there and take the uniform; that ends {quest:96783}."] = "{area:324}, en el oeste de Arathi, es un bastión del Sindicato; para entrar necesitas un uniforme. {area:313}, en el noroeste de Arathi, la ocupan salteadores, caminantes de senda y mercenarios del Sindicato (nivel 30-32): busca ahí {object:656157} y toma el uniforme; eso termina {quest:96783}.",
	-- {quest:96784} Master of Disguise · {item:275706} Syndicate Uniform
	["{quest:96784}: the {item:275706}"] = "{quest:96784}: {item:275706}",

	-- Step 8: Anastasia Miller
	-- {item:275706} Syndicate Uniform · {quest:96784} Master of Disguise · {quest:96785} Ain't No Telling · {npc:266847} Anastasia Miller
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Stromgarde's Syndicate Prowlers and Conjurors are elite (level 35-36): a rogue of 36 can slip past them, but fighting one alone is hard, so stay hidden or bring a friend. Put on the {item:275706} ({quest:96784} hands it to you at the footlocker) to pass as one of them; stealth or suspicious acts can break it. If the footlocker gave you no uniform, Anastasia hands you one with {quest:96785}. {npc:266847} is not inside the keep: she stands on a ledge on the outside of the castle wall. Jump across to it from the roof of the house beside the ledge."] = "Los merodeadores y conjuradores del Sindicato de Stromgarde son élite (nivel 35-36): un pícaro de nivel 36 puede pasar a su lado sin que lo vean, pero pelear solo con uno es difícil, así que mantente oculto o trae a un amigo. Ponte {item:275706} ({quest:96784} te lo da en el baúl) para hacerte pasar por uno de ellos; el sigilo o los actos sospechosos pueden romperlo. Si el baúl no te dio uniforme, Anastasia te da uno con {quest:96785}. {npc:266847} no está dentro del castillo: está en una cornisa por fuera de la muralla. Salta hasta ella desde el techo de la casa junto a la cornisa.",

	-- Step 9: Ain't No Telling
	-- {item:275709} Stolen Funds
	["She will not talk without something to bargain with. Her stash is upstairs in a house close to the keep: take the {item:275709}. If it is already open, wait for it to come back."] = "No va a hablar sin algo con qué negociar. Su escondite está en el piso de arriba de una casa cerca del castillo: toma {item:275709}. Si ya está abierto, espera a que vuelva.",
	-- {item:275709} Stolen Funds
	["{item:275709}: Anastasia's Stash"] = "{item:275709}: el escondite de Anastasia",

	-- Step 10: The Syndicate Sting
	-- {area:1057} Thoradin's Wall · {area:287} Hillsbrad · {item:275882} Intercepted Shipment · {item:275706} Syndicate Uniform · {npc:13085} Myrokos Silentform
	["Falconcrest's men make the handoff at the southern end of {area:1057}, the old wall between Arathi and {area:287}. Kill the two guarding the box and take the {item:275882}. Keep the {item:275706}: {npc:13085} wants it back with the shipment."] = "Los hombres de Crestahalcón hacen la entrega en el extremo sur de {area:1057}, la vieja muralla entre Arathi y {area:287}. Mata a los dos que custodian la caja y toma {item:275882}. Guarda {item:275706}: {npc:13085} lo quiere de vuelta con el cargamento.",

	-- Step 11: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "Regresa con {npc:13085}",
	-- {npc:13085} Myrokos Silentform · {npc:13936} Ravenholdt
	["{npc:13085}: 70 silver, 300 {npc:13936} reputation"] = "{npc:13085}: 70 de plata, 300 de reputación con {npc:13936}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "A nivel 24, una {item:17126} de {npc:13936} inicia esto; los datos te la dan a través de {npc:332} o {npc:918} en {zone:1453}, o de Gest u Ormok en {zone:1454}. La misión te entrega el {item:17125} para {npc:6707}.",
	-- ["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "A nivel 36, {npc:13085} te envía por el informe de exploración de Barton. Barton dirige un grupo de la Hermandad en {area:280}, en el este de {zone:1416}: róbale del bolsillo, no lo mates.",
	-- ["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "La Horda vuela a {area:272}; la Alianza, a {area:271}. La mansión se oculta en las colinas al este de {area:272}, subiendo por un sendero hacia {zone:1416}; el Rite of Cunning te deja entrar.",
	-- ["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "Abre {area:3486}, la casa oculta de los pícaros en las colinas de Alterac, y sus primeros trabajos.",
	-- ["Rite of Cunning"] = "Rite of Cunning",
	-- ["{item:275482}: pickpocket Barton"] = "{item:275482}: roba del bolsillo a Barton",
	-- ["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216} está dentro de {area:275}, la fortaleza de la Hermandad en el este de {area:287}, al sur de la mansión. Rápido y en silencio, dice {npc:13085}.",
	-- ["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766}: {quest:6701}, repetible",
}
