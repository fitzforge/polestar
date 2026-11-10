-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/benediction (forever/class/priest/benediction.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:18608} Benediction
	["{item:18608} and Anathema"] = "{item:18608} e Anátema",
	-- {spell:23101} Eye of Divinity · {area:2717} Molten Core · {npc:14494} Eris Havenfire
	["The epic priest staff: the {spell:23101} from {area:2717}, {npc:14494}'s peasant rescue, then the Eye of Shadow."] = "O cajado épico do sacerdote: o {spell:23101} de {area:2717}, o resgate dos camponeses de {npc:14494}, e depois a Visão das Sombras.",

	-- Step 1: The Eye of Divinity
	-- {item:18646} The Eye of Divinity · {object:179703} Cache of the Firelord · {npc:12018} Majordomo Executus · {area:2717} Molten Core · {area:1584} Blackrock Depths · {item:18412} Core Fragment · {npc:14387} Lothos Riftwaker · {area:254} Blackrock Mountain · {npc:14494} Eris Havenfire
	["{item:18646} comes from the {object:179703}, the chest that appears when {npc:12018} yields in {area:2717}, a 40-player raid (it is in the cache about half the time). {area:2717}'s portal is at the bottom of {area:1584}; once you have done Attunement to the Core (a {item:18412} from beside that portal), {npc:14387} inside {area:254} ports you straight in. Nothing in this chain starts without the Eye: {npc:14494} is invisible until you equip it."] = "{item:18646} vem do {object:179703}, o baú que aparece quando {npc:12018} cai em {area:2717}, uma raide de 40 jogadores (ele está no baú em cerca de metade das vezes). O portal de {area:2717} fica no fundo de {area:1584}; depois de fazer a Harmonização com o Núcleo (um {item:18412} que fica ao lado desse portal), {npc:14387}, dentro de {area:254}, teletransporta você direto para lá. Nada nesta cadeia começa sem o Olho: {npc:14494} fica invisível até você equipá-lo.",
	-- {npc:14387} Lothos Riftwaker · {area:2717} Molten Core
	["{npc:14387}: the way into {area:2717} once attuned"] = "{npc:14387}: o caminho para {area:2717} depois da harmonização",
	-- {item:18646} The Eye of Divinity · {area:2717} Molten Core · {area:254} Blackrock Mountain
	["{item:18646}: {area:2717}, through {area:254}"] = "{item:18646}: {area:2717}, passando por {area:254}",

	-- Step 2: Eris Havenfire
	-- {item:18646} The Eye of Divinity · {npc:14494} Eris Havenfire · {zone:1423} Eastern Plaguelands · {area:2279} Stratholme · {quest:7621} A Warning · {quest:7622} The Balance of Light and Shadow · {item:13931} Nightfin Soup · {item:8956} Oil of Immolation · {item:13180} Stratholme Holy Water
	-- plural, as words: Major Mana Potions = {item:13444} Major Mana Potion · Dark Runes = {item:20520} Dark Rune
	["Equip {item:18646}, then find {npc:14494}, a ghost on the hillside in the north-west of the {zone:1423}, west of {area:2279}'s gate (if she does not show, take the Eye off and put it back on). {quest:7621} is only talk; {quest:7622} starts the moment you accept it, so prepare first: full mana, Major Mana Potions, Demonic or Dark Runes, mana food or {item:13931}, and a stack of {item:8956} or {item:13180} for the skeletons."] = "Equipe {item:18646} e procure {npc:14494}, um fantasma na encosta do noroeste de {zone:1423}, a oeste do portão de {area:2279} (se ela não aparecer, tire o Olho e coloque de novo). {quest:7621} é só conversa; {quest:7622} começa no instante em que você aceita, então se prepare antes: mana cheia, Poções Elevadas de Mana, Runas Demoníacas ou Runas Negras, comida de mana ou {item:13931}, e uma pilha de {item:8956} ou {item:13180} para os esqueletos.",

	-- Step 3: The Balance of Light and Shadow
	-- {object:179694} Death Post (no name in this language: may be words) · {npc:14494} Eris Havenfire · {spell:552} Abolish Disease · {spell:139} Renew · {spell:2061} Flash Heal · {spell:15237} Holy Nova
	["Save 50 peasants before 15 die (the {object:179694} by the path counts the dead). They walk from the cave towards {npc:14494} in waves, catch diseases and draw skeletons and skeleton archers. Cure the purple-glowing diseases first ({spell:552}), keep {spell:139} on the hurt ones, {spell:2061} the nearly dead, and kill skeletons as they spawn: one {spell:15237} of rank 3 or more kills them, oil takes two ticks while they hit you. Shield yourself at the start of each wave; friendly nameplates make the hurt peasants easy to pick out. Friends may buff you before you accept and may heal or cure peasants, but they must not heal or buff you, attack a skeleton or bring a pet once it starts, or a demon appears and kills everyone. Fail, and {npc:14494} is gone for a while (players report anything from 15 minutes to two hours); talk to her again when she is back."] = "Salve 50 camponeses antes que 15 morram (o {object:179694} perto do caminho conta os mortos). Eles andam da caverna em direção a {npc:14494} em ondas, pegam doenças e atraem esqueletos e arqueiros esqueletos. Cure primeiro as doenças que brilham em roxo ({spell:552}), mantenha {spell:139} nos feridos, use {spell:2061} nos quase mortos e mate os esqueletos assim que surgirem: uma {spell:15237} de nível 3 ou mais os mata, o óleo leva dois pulsos enquanto eles batem em você. Proteja-se no começo de cada onda; as plaquetas de nome dos aliados facilitam achar os camponeses feridos. Amigos podem lançar aprimoramentos em você antes de você aceitar e podem curar ou limpar os camponeses, mas não podem curar nem aprimorar você, atacar um esqueleto nem trazer um ajudante depois do começo, ou um demônio aparece e mata todo mundo. Se falhar, {npc:14494} some por um tempo (jogadores relatam de 15 minutos a duas horas); fale com ela de novo quando ela voltar.",

	-- Step 5: The Eye of Shadow
	-- {item:18665} The Eye of Shadow · {npc:12397} Lord Kazzak · {zone:1419} Blasted Lands
	-- plural, as words: Doomguard Commanders = {npc:12396} Doomguard Commander
	["The splinter needs {item:18665} as well. {npc:12397}, a world boss in the {zone:1419} (a raid), always drops it; Manahounds and Doomguard Commanders there drop it rarely (about 3% and 2%), the Hederine of Winterspring hardly ever. It can be traded: check the Auction House first."] = "A lasca também precisa de {item:18665}. {npc:12397}, um chefe de mundo nas {zone:1419} (uma raide), sempre o solta; os Cães de Mana e os Comandantes Demonarcas de lá o soltam raramente (cerca de 3% e 2%), e o Hederine de Winterspring quase nunca. Ele pode ser negociado: olhe a Casa de Leilões primeiro.",

	-- Step 6: Benediction
	-- {item:18659} Splinter of Nordrassil · {item:18646} The Eye of Divinity · {item:18665} The Eye of Shadow · {item:18608} Benediction
	["With the {item:18659}, {item:18646} and {item:18665} in your bags, use the splinter wherever you are: it becomes {item:18608}. Use {item:18608} to turn it into Anathema, the shadow staff, and back (a 30-minute cooldown)."] = "Com {item:18659}, {item:18646} e {item:18665} nas bolsas, use a lasca onde estiver: ela vira {item:18608}. Use {item:18608} para transformá-lo em Anátema, o cajado das sombras, e de volta (tempo de recarga de 30 minutos).",
	-- {item:18659} Splinter of Nordrassil · {item:18608} Benediction
	["Use the {item:18659} with both Eyes in your bags: {item:18608}"] = "Use {item:18659} com os dois Olhos nas bolsas: {item:18608}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Equip {item:18646} to see {npc:14494}, a ghost on the mountainside in the north-west of the {zone:1423}. Come with full mana, Major Mana Potions and {item:8956}: if you fail, the event takes about two hours to return."] = "Equipe {item:18646} para ver {npc:14494}, um fantasma na encosta no noroeste de {zone:1423}. Venha com mana cheia, Poções Elevadas de Mana e {item:8956}: se falhar, o evento leva umas duas horas para voltar.",
	-- ["Save 50 peasants before 15 die. Kill the skeletons that attack them, cure their diseases (the purple ones first) and heal the wounded with {spell:139}. Friends may buff you beforehand but must stay out of the fight, or a demon appears and kills everyone."] = "Salve 50 camponeses antes que 15 morram. Mate os esqueletos que os atacam, cure as doenças deles (os roxos primeiro) e cure os feridos com {spell:139}. Amigos podem dar bônus antes, mas devem ficar fora da luta, ou um demônio aparece e mata todos.",
	-- ["With both Eyes in your bags: {item:18608}"] = "Com os dois Olhos nas bolsas: {item:18608}",
	-- ["You need {item:18646} first: it comes from the {object:179703} after {npc:12018} in {area:2717}. {item:18665} drops from elite demons ({npc:12397}, a world boss, always; Doomguard Commanders and Manahounds rarely); it binds when equipped, so buying one works too."] = "Primeiro você precisa de {item:18646}: vem do {object:179703} depois de {npc:12018} em {area:2717}. {item:18665} cai de demônios de elite ({npc:12397}, chefe mundial, sempre; Comandantes Demonarcas e Cães de Mana, raramente); vincula ao equipar, então comprar um também serve.",
	-- ["{npc:14494}'s splinter and the two Eyes make {item:18608}, the epic priest staff that turns into Anathema."] = "A lasca de {npc:14494} e os dois Olhos formam {item:18608}, o cajado épico de sacerdote que se transforma em Anátema.",
}
