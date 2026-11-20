-- French (frFR): the guide forever/40-50/shendralas (forever/40-50/shendralas.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1444} Feralas
	["About a dozen quests on a short trip into Forever's new zone (about 45-46 for the Alliance, 47 for the Horde), then on to {zone:1444}."] = "Une douzaine de quêtes lors d'une courte excursion dans la nouvelle zone de Forever (vers 45-46 pour l'Alliance, 47 pour la Horde), puis direction {zone:1444}.",

	-- Step 1: North into Desolace
	-- {area:405} Desolace
	["North into {area:405}"] = "Au nord vers {area:405}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:1099} Camp Mojache · {area:2577} Dire Maul
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. From {area:1099} ride north-west on the road past {area:2577} and on north into {area:405}: the road comes out on {area:405}'s southern edge."] = "Nouveau dans Forever : ce guide suit ce que les joueurs ont fait à {zone:2652}. Si une étape est erronée, signalez-le sur le Discord ou le GitHub de Polestar en précisant l'étape.\n{zone:2652} se trouve au sud de {area:405}, par {area:2657}, et n'a pas de trajet aérien. Depuis {area:1099}, suivez la route vers le nord-ouest après {area:2577}, puis continuez au nord vers {area:405} : la route débouche sur la bordure sud de {area:405}.",
	-- {area:405} Desolace · {zone:1444} Feralas
	["{area:405}, where the road from {zone:1444} comes in"] = "{area:405}, là où arrive la route de {zone:1444}",

	-- Step 2: Fly to Shadowprey Village
	-- {area:2408} Shadowprey Village
	["Fly to {area:2408}"] = "Prendre un vol pour {area:2408}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {zone:1454} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1458} Undercity
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the zeppelin to {zone:1454} first (from {object:3202} or the {zone:1458})."] = "Nouveau dans Forever : ce guide suit ce que les joueurs ont fait à {zone:2652}. Si une étape est erronée, signalez-le sur le Discord ou le GitHub de Polestar en précisant l'étape.\n{zone:2652} se trouve au sud de {area:405}, par {area:2657}, et n'a pas de trajet aérien. Ses quêtes sont pour les niveaux 41-45. Si vous venez des Royaumes de l'Est, prenez d'abord le zeppelin pour {zone:1454} (depuis {object:3202} ou {zone:1458}).",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Maître de vol d'{zone:1454}",

	-- Step 3: Fly to Nijel's Point
	-- {area:608} Nijel's Point
	["Fly to {area:608}"] = "Prendre un vol pour {area:608}",
	-- {zone:2652} Shen'dralas · {area:405} Desolace · {area:2657} Valley of Bones · {area:150} Menethil Harbor
	["New in Forever: this guide follows what players did in {zone:2652}. If a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\n{zone:2652} lies south of {area:405}, through the {area:2657}, and has no flight path of its own. Its quests are for levels 41-45. Coming from the Eastern Kingdoms, take the boat from {area:150} to Theramore first."] = "Nouveau dans Forever : ce guide suit ce que les joueurs ont fait à {zone:2652}. Si une étape est erronée, signalez-le sur le Discord ou le GitHub de Polestar en précisant l'étape.\n{zone:2652} se trouve au sud de {area:405}, par {area:2657}, et n'a pas de trajet aérien. Ses quêtes sont pour les niveaux 41-45. Si vous venez des Royaumes de l'Est, prenez d'abord le bateau de {area:150} pour Theramore.",

	-- Step 4: Into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Into the {area:2657}"] = "Vers {area:2657}",
	-- {area:405} Desolace · {area:2408} Shadowprey Village · {area:606} Gelkis Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride east along {area:405}'s southern edge (from {area:2408}: past {area:606}): the {area:2657} opens there into {area:16651}."] = "Allez vers l'est le long de la bordure sud de {area:405} (depuis {area:2408} : après {area:606}) : {area:2657} s'y ouvre sur {area:16651}.",

	-- Step 5: Into the Valley of Bones
	-- {area:608} Nijel's Point · {area:405} Desolace · {area:604} Magram Village · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["Ride south from {area:608} down the road through eastern {area:405} to {area:604}: just past its western edge the path climbs into the {area:2657} and {area:16651}."] = "Depuis {area:608}, descendez la route vers le sud à travers l'est de {area:405} jusqu'à {area:604} : juste après sa bordure ouest, le chemin monte vers {area:2657} et {area:16651}.",

	-- Step 6: The Valley of Bones: a Tattered Journal
	-- {area:2657} Valley of Bones · {quest:93644} Tattered Journal
	["The {area:2657}: a {quest:93644}"] = "{area:2657} : {quest:93644}",
	-- {quest:93644} Tattered Journal · {zone:2652} Shen'dralas · {area:2657} Valley of Bones
	-- plural, as words: Outcast Necromancers = {npc:11559} Outcast Necromancer · Magram Necromancers = {npc:253272} Magram Necromancer
	-- was: ["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "Nouveau dans Forever : si une étape est erronée, signalez-le sur le Discord ou le GitHub de Polestar en précisant l'étape.\nLes Nécromanciens renégats et les Nécromanciens magram de la vallée laissent tomber {quest:93644}, dont l'auteur vit à {zone:2652} : les joueurs l'ont obtenu en quelques victimes. Les centaures magram vous ignorent tant que vous ne les attaquez pas ; les Nécrokhans magram parmi eux (niveau 45) sont des élites : laissez-les tranquilles.\nLes centaures gelkis et magram ont leurs propres chaînes de quêtes dans {area:2657}, qui rapportent environ 20 000 à 30 000 points d'expérience de plus, mais chacune exige d'être Honoré auprès de son clan. Les deux clans sont rivaux, travaillez donc pour l'un d'eux : le guide Réputation des centaures gelkis et magram, dans Réputation, explique comment."
	["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. Take it from the Outcast Necromancers and leave the Magram alone: the Magram centaurs leave you be until you attack, but once you have killed Magram the whole clan turns on you, and their Necrokhans (level 45, elites) stand around the western pylon you repair later.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "",

	-- Step 7: The western pylon
	["The western pylon"] = "Le pylône ouest",
	-- {quest:92914} Strange Pylons
	-- plural, as words: Decrepit Pylon Protectors = {npc:252711} Decrepit Pylon Protector · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here.\nCareful: click the crystal from the road on its west side and move on: the Protectors stand two and three together east and north-east of it, where Corpsefeeders and the Magram Necrokhans (elites, 45) walk too."] = "",

	-- Step 8: Bristleback Retreat: the eastern pylon
	-- {area:16677} Bristleback Retreat
	["{area:16677}: the eastern pylon"] = "{area:16677} : le pylône est",
	-- {area:16677} Bristleback Retreat · {npc:253527} Kog'thug the Brave
	["East along the valley road to the quilboar of {area:16677}: the second pylon stands at the eastern end of their camp. A Corpsefeeder (level 45, elite) walks this road: let it pass. The Bristlebacks (levels 42-43) attack on sight; {npc:253527} (level 43, elite) and his bodyguards hold the south side of the camp."] = "Suivez la route de la vallée vers l'est jusqu'aux huranes de {area:16677} : le deuxième pylône se dresse à l'extrémité est de leur camp. Un Mange-cadavre (élite de niveau 45) parcourt cette route : laissez-le passer. Les Dos-hirsutes (niveaux 42-43) attaquent à vue ; {npc:253527} (élite de niveau 43) et ses gardes du corps tiennent le côté sud du camp.",
	["the eastern pylon"] = "le pylône est",

	-- Step 9: The temple of Shen'dralas: the third pylon
	-- {zone:2652} Shen'dralas
	["The temple of {zone:2652}: the third pylon"] = "Le temple de {zone:2652} : le troisième pylône",
	["South to the Shen'dralar temple at the zone's heart, keeping west of Kog'thug's bodyguards: the third pylon stands inside. The temple's guards are neutral: leave them be."] = "Au sud vers le temple shen'dralar au cœur de la zone, en restant à l'ouest des gardes du corps de Kog'thug : le troisième pylône se trouve à l'intérieur. Les gardes du temple sont neutres : laissez-les tranquilles.",

	-- Step 10: Evenshade's Overlook
	-- {npc:253471} Mordent Evenshade · {quest:93644} Tattered Journal
	["North-west from the temple to {npc:253471}'s camp on the overlook, beside the spirit healer: the {quest:93644} is his, and he wants to hear about the pylons."] = "Au nord-ouest du temple, rejoignez le camp de {npc:253471} sur le promontoire, à côté du gardien des âmes : {quest:93644} est le sien, et il veut entendre parler des pylônes.",

	-- Step 11: North into Desolace
	-- {npc:253471} Mordent Evenshade · {area:405} Desolace · {area:604} Magram Village
	["{npc:253471} wants a fragment and a shard of the pylons back from {area:405}'s two centaur villages: {area:604} lies just beyond the valley's northern way out.\nCareful: if you have killed Magram or Gelkis centaurs, that clan's guards may attack you when you walk into its village."] = "{npc:253471} veut récupérer un fragment et un éclat des pylônes dans les deux villages centaures de {area:405} : {area:604} se trouve juste après la sortie nord de la vallée.\nAttention : si vous avez tué des centaures Magram ou Gelkis, les gardes de ce clan risquent de vous attaquer quand vous entrez dans son village.",

	-- Step 12: Magram Village
	-- {item:255656} Pylon Fragment
	-- plural, as words: Magram Guardians = {npc:255560} Magram Guardian
	["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it. They leave you be unless you have fought the Magram: pick the fragment up without a fight. Every Magram you kill turns the clan against you, and back in the valley that means the Necrokhans (level 45, elites) at the western pylon as well."] = "",

	-- Step 13: Gelkis Village
	-- {area:405} Desolace · {area:606} Gelkis Village · {item:255657} Pylon Shard
	-- plural, as words: Gelkis Guardians = {npc:255561} Gelkis Guardian
	["West along {area:405}'s southern edge to {area:606}: the {item:255657} lies at its southern end, watched by Gelkis Guardians (levels 39-41)."] = "À l'ouest le long de la bordure sud de {area:405} jusqu'à {area:606} : l'{item:255657} se trouve à son extrémité sud, surveillé par des Gardiens gelkis (niveaux 39-41).",

	-- Step 14: Back into the Valley of Bones
	-- {area:2657} Valley of Bones
	["Back into the {area:2657}"] = "Retour dans {area:2657}",
	-- {area:405} Desolace · {area:2657} Valley of Bones · {area:16651} Shen'dralas
	["East again along {area:405}'s southern edge: the {area:2657} opens into {area:16651}."] = "De nouveau à l'est le long de la bordure sud de {area:405} : {area:2657} débouche sur {area:16651}.",

	-- Step 16: The temple: the Mana Sieve
	-- {item:255662} Mana Sieve
	["The temple: the {item:255662}"] = "Le temple : le {item:255662}",
	-- {npc:253471} Mordent Evenshade · {item:255662} Mana Sieve · {npc:255486} Historian Biraxas · {quest:96018} Powering the Pylons
	-- plural, as words: Unstable Mana Rifts = {npc:264149} Unstable Mana Rift
	["{npc:253471} sends you for the {item:255662}, kept inside the temple beside {npc:255486}. {quest:96018} asks you to gather mana with the Sieve before you repair the pylons: with it in your bags you can handle the Unstable Mana Rifts, the floating sparks of mana all along the road north."] = "{npc:253471} vous envoie chercher le {item:255662}, gardé dans le temple à côté de {npc:255486}. {quest:96018} vous demande de récolter du mana avec le Tamis avant de réparer les pylônes : avec lui dans vos sacs, vous pouvez utiliser les Failles de mana instables, les étincelles de mana flottantes tout le long de la route au nord.",

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
	["The western pylon: repair it"] = "Le pylône ouest : le réparer",
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
	["{area:16677}: repair the eastern pylon"] = "{area:16677} : réparer le pylône est",
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
	["{npc:253471}: hear him out"] = "{npc:253471} : l'écouter",

	-- Step 26: Liranne
	-- {quest:93568} Partially Digested Collar · {npc:255385} Liranne
	["A Prowler gave up a {quest:93568}: {npc:255385}, north of the temple, knows whose it was."] = "Un Rôdeur a laissé un {quest:93568} : {npc:255385}, au nord du temple, sait à qui il appartenait.",

	-- Step 27: The temple: Magister Kirandis
	-- {npc:254656} Magister Kirandis
	["The temple: {npc:254656}"] = "Le temple : {npc:254656}",
	-- {npc:254656} Magister Kirandis · {npc:254578} Mithera · {quest:93341} Forlorn Gardens
	["{npc:254656} waits inside the temple. Then {npc:254578}, on the temple's eastern side, has work in the {quest:93341}."] = "{npc:254656} attend dans le temple. Ensuite, {npc:254578}, du côté est du temple, a du travail dans {quest:93341}.",

	-- Step 28: The Forlorn Gardens: the pedestal
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}: the pedestal"] = "{quest:93341} : le piédestal",
	-- {quest:93341} Forlorn Gardens
	["East of the temple the {quest:93341} have run wild, and their plants attack on sight. Examine the pedestal at the gardens' southern end."] = "À l'est du temple, {quest:93341} sont retournés à l'état sauvage, et leurs plantes attaquent à vue. Examinez le piédestal à l'extrémité sud des jardins.",

	-- Step 30: Mithera’s garden errands
	-- {npc:254578} Mithera
	["{npc:254578}’s garden errands"] = "",

	-- Step 31: The Forlorn Gardens
	-- {quest:93341} Forlorn Gardens
	["The {quest:93341}"] = "{quest:93341}",
	-- {npc:254674} Woodwyrd · {area:2100} Maraudon
	-- plural, as words: Rowdy Roses = {npc:254566} Rowdy Rose · Terrible Tulips = {npc:254567} Terrible Tulip · Malevolent Marigolds = {npc:254572} Malevolent Marigold · Nascent Pylon Protectors = {npc:276401} Nascent Pylon Protector
	["Rowdy Roses and Terrible Tulips grow all over the gardens; the Malevolent Marigolds keep to the northern part. {npc:254674}, the treant in the middle of the gardens, has a request of his own that needs water from {area:2100}, a dungeon: this guide leaves it.\nThe Shen'dralar who wander the gardens are neutral, like the temple's guards: leave them be and pull the flowers away from them. Careful: Nascent Pylon Protectors (elites, 43) wander the zone's middle, the gardens too: keep clear of them."] = "Des Roses turbulentes et des Tulipes terribles poussent partout dans les jardins ; les Soucis malveillants restent dans la partie nord. {npc:254674}, le tréant au milieu des jardins, a sa propre demande, qui nécessite de l'eau de {area:2100}, un donjon : ce guide la laisse de côté.\nLes Shen'dralar qui errent dans les jardins sont neutres, comme les gardes du temple : laissez-les tranquilles et éloignez les fleurs d'eux. Attention : des Protecteurs de pylône naissants (élites, 43) rôdent au centre de la zone, jusque dans les jardins : tenez-vous à l'écart.",

	-- Step 33: The temple: Historian Biraxas
	-- {npc:255486} Historian Biraxas
	["The temple: {npc:255486}"] = "",
	-- {npc:255486} Historian Biraxas · {npc:254656} Magister Kirandis · {npc:252711} Decrepit Pylon Protector
	["{npc:255486}, inside the temple, has a task for you now that you have met {npc:254656}: the heart of a {npc:252711} (42-43, not elite), a short ride back up the road north."] = "{npc:255486}, dans le temple, a une tâche pour vous maintenant que vous avez rencontré {npc:254656} : le cœur d'un {npc:252711} (42-43, non élite), à courte distance en remontant la route vers le nord.",

	-- Step 34: A Heart of Crystal
	-- {npc:252711} Decrepit Pylon Protector
	["Use the west face of the western pylon, where you repaired it. Approach on the road from the south and pull one {npc:252711} back to you. Wait for the elite patrols to pass; do not follow a Protector around the east side."] = "",

	-- Step 36: Mana Mania
	-- {item:286647} Depleted Crystal Heart · {npc:264149} Unstable Mana Rift · {npc:276401} Nascent Pylon Protector
	["Take the {item:286647} to an {npc:264149} on the road north of the temple and throw it into the rift. The {npc:276401} is elite: grouping up is advised."] = "",

	-- Step 37: Shadowprey Village
	-- {zone:2652} Shen'dralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:2408} Shadowprey Village · {area:1637} Orgrimmar · {zone:1444} Feralas · {area:1099} Camp Mojache
	["{zone:2652} is done. Ride back north through the {area:2657} and west along {area:405}'s southern edge to {area:2408}: the next guide picks up in {area:1637}, with the {zone:1444} guide's hand-ins. Your hearthstone is bound at {area:1099}: if it is ready, hearth there and fly to {area:1637} from {area:1099} instead."] = "{zone:2652} est terminé. Retournez au nord par {area:2657}, puis à l'ouest le long de la bordure sud de {area:405} jusqu'à {area:2408} : le prochain guide reprend à {area:1637}, avec les quêtes à rendre du guide de {zone:1444}. Votre pierre de foyer est liée à {area:1099} : si elle est prête, utilisez-la et prenez plutôt un vol pour {area:1637} depuis {area:1099}.",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Maître de vol de {area:2408}",

	-- Step 38: Back to your route
	["Back to your route"] = "Retour à votre itinéraire",
	-- {zone:2652} Shen'dralas · {zone:1444} Feralas · {area:2657} Valley of Bones · {area:405} Desolace · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["{zone:2652} is done. Your {zone:1444} guide picks up from here: ride back north through the {area:2657}, west along {area:405}'s southern edge and south into {zone:1444}, to the dock on the {area:1108} where the boat crosses to {area:1116}."] = "{zone:2652} est terminé. Votre guide de {zone:1444} reprend d'ici : retournez au nord par {area:2657}, à l'ouest le long de la bordure sud de {area:405}, puis au sud dans {zone:1444}, jusqu'au quai de {area:1108} d'où le bateau traverse vers {area:1116}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the valley road and south to {npc:253471}. {quest:93016} asks you to hear him out: talk to him once more, then hand it in."] = "Revenez à l'ouest par la route de la vallée, puis au sud jusqu'à {npc:253471}. {quest:93016} vous demande de l'écouter : parlez-lui encore une fois, puis rendez-la.",
	-- ["East along the valley road to the eastern pylon and repair it the same way, a {npc:252711} first, coming in from the west: {npc:253527} (level 43, elite) and his bodyguards hold the south side of the quilboar camp, and a Corpsefeeder (level 45, elite) walks the road."] = "Suivez la route de la vallée vers l'est jusqu'au pylône est et réparez-le de la même façon, d'abord un {npc:252711}, en arrivant par l'ouest : {npc:253527} (élite de niveau 43) et ses gardes du corps tiennent le côté sud du camp huran, et un Mange-cadavre (élite de niveau 45) parcourt la route.",
	-- ["East through the valley to the strange crystal on its pedestal: clicking it starts {quest:92914}. The Decrepit Pylon Protectors (levels 42-43) around it are the mana elementals that guard it. Corpsefeeders (level 45, elite) roam the valley east of here."] = "Allez vers l'est à travers la vallée jusqu'à l'étrange cristal sur son piédestal : cliquez dessus pour lancer {quest:92914}. Les Protecteurs de pylône décrépits (niveaux 42-43) autour sont les élémentaires de mana qui le gardent. Des Mange-cadavres (élites de niveau 45) rôdent dans la vallée à l'est d'ici.",
	-- ["New in Forever: if a step is wrong, tell us on Polestar's Discord or GitHub and name the step.\nThe Outcast Necromancers and the Magram Necromancers of the valley drop a {quest:93644} whose writer lives in {zone:2652}: players got it within a few kills. The Magram centaurs leave you be until you attack; the Magram Necrokhans among them (level 45) are elites: leave them be.\nThe Gelkis and Magram centaurs have {area:2657} quest chains of their own, worth about 20,000 to 30,000 more experience, but each chain asks for Honored with its clan. The two clans are rivals, so work for one of them: the Gelkis and Magram Centaur Reputation guide, under Reputation, shows how."] = "Nouveau dans Forever : si une étape est erronée, signalez-le sur le Discord ou le GitHub de Polestar en précisant l'étape.\nLes Nécromanciens renégats et les Nécromanciens magram de la vallée laissent tomber {quest:93644}, dont l'auteur vit à {zone:2652} : les joueurs l'ont obtenu en quelques victimes. Les centaures magram vous ignorent tant que vous ne les attaquez pas ; les Nécrokhans magram parmi eux (niveau 45) sont des élites : laissez-les tranquilles.\nLes centaures gelkis et magram ont leurs propres chaînes de quêtes dans {area:2657}, qui rapportent environ 20 000 à 30 000 points d'expérience de plus, mais chacune exige d'être Honoré auprès de son clan. Les deux clans sont rivaux, travaillez donc pour l'un d'eux : le guide Réputation des centaures gelkis et magram, dans Réputation, explique comment.",
	-- ["North up the road to the first pylon, gathering mana from the Unstable Mana Rifts on the way. Decrepit Pylon Protectors guard it: kill one beside the pylon, then use {spell:1289727} on it, as players did to repair it.\nCareful: the pylon stands at the edge of the {area:2657}, where Magram Necrokhans and Corpsefeeders (elites, level 45) walk, and Nascent Pylon Protectors (elites, 43) wander the road. Pull the Decrepit Pylon Protectors away from them before you repair it."] = "Remontez la route vers le nord jusqu'au premier pylône, en récoltant le mana des Failles de mana instables en chemin. Des Protecteurs de pylône décrépits le gardent : tuez-en un à côté du pylône, puis utilisez {spell:1289727} dessus, comme l'ont fait les joueurs pour le réparer.\nAttention : le pylône se trouve en bordure de {area:2657}, où rôdent des Nécrokhans magram et des Mange-cadavres (élites, niveau 45), et des Protecteurs de pylône naissants (élites, 43) errent sur la route. Éloignez les Protecteurs de pylône décrépits d'eux avant de le réparer.",
	-- ["The nearest Decrepit Pylon Protectors stand by the road north, from the middle of the zone up to the western pylon, and around {npc:253471}'s overlook: one of them carries the heart Biraxas wants."] = "Les Protecteurs de pylône décrépits les plus proches se tiennent le long de la route du nord, du centre de la zone jusqu'au pylône ouest, et autour du belvédère de {npc:253471} : l'un d'eux porte le cœur que veut Biraxas.",
	-- ["The {item:255656} lies at the western edge of the village; Magram Guardians (levels 39-41) watch over it."] = "Le {item:255656} se trouve à l'extrémité ouest du village ; des Gardiens magram (niveaux 39-41) le surveillent.",
	-- ["{npc:252711}, then {spell:1289727} on it"] = "{npc:252711}, puis {spell:1289727} dessus",
	-- ["{zone:2652} is done: ride back north through the {area:2657}; the next step says where your route goes on from there."] = "{zone:2652} est terminé : retournez au nord par {area:2657} ; l'étape suivante indique où votre itinéraire continue.",
}
