-- French (frFR): the guide forever/class/hunter/taming-the-beast-horde (forever/class/hunter/taming-the-beast-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:6061} Taming the Beast
	["{quest:6061} (Horde)"] = "{quest:6061} (Horde)",
	-- {item:15908} Taming Rod · {spell:1515} Tame Beast · {spell:5149} Beast Training
	["Your own pet at 10: three practice tames with a {item:15908} teach {spell:1515}, then {spell:5149}."] = "Votre propre familier au niveau 10 : trois domptages d'entraînement avec un {item:15908} vous apprennent {spell:1515}, puis {spell:5149}.",

	-- Step 1: Thotar in Razor Hill
	-- {npc:3171} Thotar · {area:362} Razor Hill
	["{npc:3171} in {area:362}"] = "{npc:3171} à {area:362}",
	-- {npc:3171} Thotar · {area:362} Razor Hill · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:11814} Kali Remik · {area:367} Sen'jin Village · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff
	["At 10 go to {npc:3171}, the hunter trainer inside the barracks in {area:362}. If {npc:3407} in {zone:1454}, {npc:11814} in {area:367} or {npc:3038} in {zone:1456} hands you The Hunter's Path, take it and hand it to {npc:3171} for a little experience; it is only a pointer, and you can take the first rod without it."] = "Au niveau 10, allez voir {npc:3171}, le maître des chasseurs dans la caserne de {area:362}. Si {npc:3407} à {zone:1454}, {npc:11814} au {area:367} ou {npc:3038} aux {zone:1456} vous remet La Voie du chasseur, acceptez-la et rendez-la à {npc:3171} pour un peu d'expérience ; ce n'est qu'une indication, et vous pouvez prendre le premier bâtonnet sans elle.",
	-- {npc:3171} Thotar · {item:15908} Taming Rod
	["{npc:3171}: the first {item:15908}"] = "{npc:3171} : le premier {item:15908}",

	-- Step 2: Dire Mottled Boar
	-- {area:362} Razor Hill · {item:15908} Taming Rod · {npc:3171} Thotar · {spell:75} Auto Shot
	-- plural, as words: Dire Mottled Boars = {npc:3099} Dire Mottled Boar
	["Dire Mottled Boars (level 6-7) roam just north and west of {area:362}. How the rod works: target a living beast, use the {item:15908} from inside its range and stand still for the whole channel while the beast hits you. Moving, fighting back, a heal from someone else or anyone else hitting the beast breaks it and costs one of the rod's few charges; if they run out, destroy the rod, abandon the quest and take it again from {npc:3171}. The boars charge from 20 yards, so start with the rod, not {spell:75}. The tamed boar becomes your pet for practice. Keep each rod: it goes back to {npc:3171}."] = "Les Sangliers tachetés redoutables (niveau 6-7) errent juste au nord et à l'ouest de {area:362}. Fonctionnement du bâtonnet : ciblez une bête vivante, utilisez le {item:15908} à portée et restez immobile pendant toute la canalisation pendant que la bête vous frappe. Bouger, riposter, un soin reçu de quelqu'un d'autre ou toute autre personne qui frappe la bête l'interrompt et coûte l'une des rares charges du bâtonnet ; s'il n'en reste plus, détruisez le bâtonnet, abandonnez la quête et reprenez-la auprès de {npc:3171}. Les sangliers chargent à 20 mètres : commencez donc par le bâtonnet, pas par {spell:75}. Le sanglier dompté devient votre familier d'entraînement. Gardez chaque bâtonnet : il retourne à {npc:3171}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living boar"] = "Utilisez le {item:15908} sur un sanglier vivant",

	-- Step 3: Surf Crawler
	-- {spell:2641} Dismiss Pet · {area:367} Sen'jin Village · {area:368} Echo Isles
	-- plural, as words: Surf Crawlers = {npc:3107} Surf Crawler · Pygmy Surf Crawlers = {npc:3106} Pygmy Surf Crawler
	["First dismiss the boar (right-click your pet's portrait, {spell:2641}): a released practice pet can turn on you. Surf Crawlers (level 7-8) walk the beaches around {area:367} and the {area:368}; the small Pygmy Surf Crawlers do not count. A crawler runs for help at 15% health, so do not hurt it."] = "Renvoyez d'abord le sanglier (clic droit sur le portrait de votre familier, {spell:2641}) : un familier d'entraînement relâché peut se retourner contre vous. Les Clampants de l'écume (niveau 7-8) arpentent les plages autour du {area:367} et des {area:368} ; les petits Clampants de l'écume pygmées ne comptent pas. Un clampant fuit chercher de l'aide à 15 % de vie : ne le blessez donc pas.",
	-- {item:15908} Taming Rod · {npc:3107} Surf Crawler
	["Use the {item:15908} on a living {npc:3107}"] = "Utilisez le {item:15908} sur un {npc:3107} vivant",

	-- Step 4: Armored Scorpid
	-- {area:362} Razor Hill · {spell:1494} Track Beasts
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Dismiss the crawler. Armored Scorpids (level 7-8) crawl the dry plains west and south-west of {area:362}, some just south of the road west out of town; {spell:1494} shows them. Their hits can break the channel: start at full health and keep still."] = "Renvoyez le clampant. Les Scorpides blindés (niveau 7-8) rampent dans les plaines arides à l'ouest et au sud-ouest de {area:362}, certains juste au sud de la route qui sort de la ville vers l'ouest ; {spell:1494} les montre. Leurs coups peuvent interrompre la canalisation : commencez avec toute votre vie et ne bougez pas.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living scorpid"] = "Utilisez le {item:15908} sur un scorpide vivant",

	-- Step 5: Ormak Grimshot in Orgrimmar
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar
	["{npc:3352} in {zone:1454}"] = "{npc:3352} à {zone:1454}",
	-- {zone:1454} Orgrimmar · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor · {npc:10088} Xao'tsu
	["Follow the road north to {zone:1454}'s gate. {npc:3352} stands with the hunter trainers in the {object:172958}, up the ramp at the city's east side; {npc:10088}, the pet trainer, is a few steps north of him."] = "Suivez la route vers le nord jusqu'à la porte d'{zone:1454}. {npc:3352} se tient avec les maîtres des chasseurs dans {object:172958}, en haut de la rampe du côté est de la ville ; {npc:10088}, le maître des familiers, est à quelques pas au nord de lui.",

	-- Step 6: Yaw Sharpmane at Bloodhoof
	-- {npc:3065} Yaw Sharpmane
	["{npc:3065} at Bloodhoof"] = "{npc:3065} à Sabot-de-Sang",
	-- {npc:3065} Yaw Sharpmane · {area:222} Bloodhoof Village · {npc:3038} Kary Thunderhorn · {zone:1456} Thunder Bluff · {npc:3407} Sian'dur · {zone:1454} Orgrimmar · {npc:3171} Thotar · {area:362} Razor Hill
	["At 10 go to {npc:3065}, who stands at the north edge of {area:222}. The Hunter's Path from {npc:3038} in {zone:1456}, {npc:3407} in {zone:1454} or {npc:3171} in {area:362} also leads here, for a little experience; it is only a pointer."] = "Au niveau 10, allez voir {npc:3065}, qui se tient à l'extrémité nord du {area:222}. La Voie du chasseur, donnée par {npc:3038} aux {zone:1456}, {npc:3407} à {zone:1454} ou {npc:3171} à {area:362}, mène aussi ici, pour un peu d'expérience ; ce n'est qu'une indication.",
	-- {npc:3065} Yaw Sharpmane · {item:15908} Taming Rod
	["{npc:3065}: the first {item:15908}"] = "{npc:3065} : le premier {item:15908}",

	-- Step 7: Adult Plainstrider
	-- {area:222} Bloodhoof Village · {item:15908} Taming Rod
	-- plural, as words: Adult Plainstriders = {npc:2956} Adult Plainstrider
	["Adult Plainstriders (level 6-7) walk the plains south-west and north-west of {area:222}. How the rod works: target a living beast, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs one of the rod's few charges (out of charges: destroy the rod, abandon the quest, take it again). A plainstrider flees at 25% health, so do not damage it first. Keep each rod: it goes back to Yaw."] = "Les Trotteurs des plaines adultes (niveau 6-7) arpentent les plaines au sud-ouest et au nord-ouest du {area:222}. Fonctionnement du bâtonnet : ciblez une bête vivante, utilisez le {item:15908} et restez immobile pendant toute la canalisation pendant qu'elle vous frappe ; bouger, riposter ou l'aide de quelqu'un d'autre l'interrompt et coûte l'une des rares charges du bâtonnet (plus de charges : détruisez le bâtonnet, abandonnez la quête et reprenez-la). Un trotteur des plaines fuit à 25 % de vie : ne le blessez donc pas d'abord. Gardez chaque bâtonnet : il retourne à Yaw.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living plainstrider"] = "Utilisez le {item:15908} sur un trotteur des plaines vivant",

	-- Step 8: Prairie Stalker
	-- {spell:2641} Dismiss Pet · {area:222} Bloodhoof Village
	-- plural, as words: Prairie Stalkers = {npc:2959} Prairie Stalker
	["Dismiss the plainstrider first (right-click the pet portrait, {spell:2641}): a released practice pet may attack you. Prairie Stalkers (level 7-8) roam the grass north of {area:222}."] = "Renvoyez d'abord le trotteur des plaines (clic droit sur le portrait du familier, {spell:2641}) : un familier d'entraînement relâché peut vous attaquer. Les Traqueurs des prairies (niveau 7-8) errent dans l'herbe au nord du {area:222}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living stalker"] = "Utilisez le {item:15908} sur un traqueur vivant",

	-- Step 9: Swoop
	-- {npc:2970} Swoop
	-- plural, as words: Swoops = {npc:2970} Swoop · Taloned Swoops = {npc:2971} Taloned Swoop
	["Dismiss the stalker. Swoops (level 7-9) glide over the plains north-west and north-east of Bloodhoof; the Taloned Swoops do not count. A {npc:2970}'s knockdown breaks the channel, but it lands only once per channel: start the rod just after it has used it."] = "Renvoyez le traqueur. Les Rapaces (niveau 7-9) planent au-dessus des plaines au nord-ouest et au nord-est de Sabot-de-Sang ; les Rapaces acérés ne comptent pas. Le renversement d'un {npc:2970} interrompt la canalisation, mais il ne le place qu'une fois par canalisation : lancez le bâtonnet juste après qu'il l'a utilisé.",
	-- {item:15908} Taming Rod · {npc:2970} Swoop
	["Use the {item:15908} on a living {npc:2970}"] = "Utilisez le {item:15908} sur un {npc:2970} vivant",

	-- Step 10: Holt Thunderhorn in Thunder Bluff
	-- {npc:3039} Holt Thunderhorn · {zone:1456} Thunder Bluff
	["{npc:3039} in {zone:1456}"] = "{npc:3039} aux {zone:1456}",
	-- {zone:1456} Thunder Bluff · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {npc:10086} Hesuwa Thunderhorn
	["Head north to {zone:1456} and take a lift up. {npc:3039} stands with the hunter trainers on {area:1641}; {npc:10086}, the pet trainer, is nearby."] = "Dirigez-vous vers le nord jusqu'aux {zone:1456} et prenez un ascenseur. {npc:3039} se tient avec les maîtres des chasseurs sur la {area:1641} ; {npc:10086}, la maîtresse des familiers, est tout près.",

	-- Step 11: Elayaa Easewind
	-- {npc:254084} Elayaa Easewind · {zone:2521} Zephras Isle · {area:16638} Valanaar · {quest:94007} Taming the Beast
	["At 10, {npc:254084}, a hunter trainer on {zone:2521}, may send you on to {area:16638} with {quest:94007}. It is only a pointer: skip it if you are already in {area:16638}."] = "Au niveau 10, {npc:254084}, maître des chasseurs sur {zone:2521}, peut vous envoyer à {area:16638} avec {quest:94007}. Ce n'est qu'une indication : passez-la si vous êtes déjà à {area:16638}.",

	-- Step 12: Quel'ana Quickgale in Valanaar
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar
	["{npc:252389} in {area:16638}"] = "{npc:252389} à {area:16638}",
	-- {npc:252389} Quel'ana Quickgale · {area:16638} Valanaar · {npc:254411} Quel'dora Quickgale
	["{npc:252389} stands with the trainers by {area:16638}'s west gate, {npc:254411} beside her."] = "{npc:252389} se tient avec les maîtres de classe près de la porte ouest de {area:16638}, {npc:254411} à côté d'elle.",
	-- {npc:252389} Quel'ana Quickgale · {item:15908} Taming Rod
	["{npc:252389}: the first {item:15908}"] = "{npc:252389} : le premier {item:15908}",

	-- Step 13: Windsong Crawler
	-- {area:16638} Valanaar · {item:15908} Taming Rod
	-- plural, as words: Windsong Crawlers = {npc:254588} Windsong Crawler
	["Windsong Crawlers live only by water: the nearest scuttle along the shore south-west of {area:16638}, among the crabs. How the rod works: target a living crawler, use the {item:15908} and stand still for the whole channel while it hits you; moving, fighting back or anyone else's help breaks it and costs a charge. Killing one does not count."] = "Les Clampants chantevent ne vivent qu'au bord de l'eau : les plus proches courent sur la rive au sud-ouest de {area:16638}, parmi les crabes. Fonctionnement du bâtonnet : ciblez un clampant vivant, utilisez le {item:15908} et restez immobile pendant toute la canalisation pendant qu'il vous frappe ; bouger, riposter ou l'aide de quelqu'un d'autre l'interrompt et coûte une charge. En tuer un ne compte pas.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living crawler"] = "Utilisez le {item:15908} sur un clampant vivant",
	-- {npc:254588} Windsong Crawler
	["Tame {npc:254588}"] = "Apprivoisez : {npc:254588}",

	-- Step 14: Ornery Galestrider
	-- {spell:2641} Dismiss Pet · {area:16626} Gustberry Lowlands · {area:16638} Valanaar
	-- plural, as words: Ornery Galestriders = {npc:251707} Ornery Galestrider
	["Dismiss the crawler first (right-click the pet portrait, {spell:2641}). Ornery Galestriders graze in the {area:16626}, the fields a short walk west and south-west of {area:16638}."] = "Renvoyez d'abord le clampant (clic droit sur le portrait du familier, {spell:2641}). Les Trotteurs des trombes hargneux paissent dans les {area:16626}, les champs à quelques pas à l'ouest et au sud-ouest de {area:16638}.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living galestrider"] = "Utilisez le {item:15908} sur un trotteur vivant",
	-- {npc:251707} Ornery Galestrider
	["Tame {npc:251707}"] = "Apprivoisez : {npc:251707}",

	-- Step 15: Vuldren Alpha
	-- {area:16626} Gustberry Lowlands
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha
	["Dismiss the galestrider. Vuldren Alphas hunt in the same {area:16626}, a little further south."] = "Renvoyez le trotteur. Les Alphas vuldrènes chassent dans les mêmes {area:16626}, un peu plus au sud.",
	-- {item:15908} Taming Rod
	["Use the {item:15908} on a living alpha"] = "Utilisez le {item:15908} sur un alpha vivant",
	-- {npc:250874} Vuldren Alpha
	["Tame {npc:250874}"] = "Apprivoisez : {npc:250874}",
	-- {npc:254411} Quel'dora Quickgale · {spell:5149} Beast Training
	["{npc:254411}, beside her: {spell:5149}"] = "{npc:254411}, à côté d'elle : {spell:5149}",

	-- Step 16: Your first pet
	["Your first pet"] = "Votre premier familier",
	-- {spell:1515} Tame Beast · {spell:17253} Bite
	["{spell:1515} works like the rod: a beast of your level or lower, a channel you must not move during, the beast hitting you all the while. A pet keeps the level you tame it at and levels up with you; it can never be above your level, so tame one close to yours. Each family has its own ability on Forever (a boar's Charge, for example). For levelling, a cat hits hardest (Claw and {spell:17253}) and a boar takes more punishment."] = "{spell:1515} fonctionne comme le bâtonnet : une bête de votre niveau ou moins, une canalisation pendant laquelle vous ne devez pas bouger, la bête vous frappant tout du long. Un familier garde le niveau auquel vous l'avez dompté et monte de niveau avec vous ; il ne peut jamais dépasser votre niveau, alors domptez-en un proche du vôtre. Chaque famille a sa propre technique sur Forever (la Charge du sanglier, par exemple). Pour monter de niveau, un félin frappe le plus fort (Griffe et {spell:17253}) et un sanglier encaisse davantage.",
	["Tame a beast of your level to keep"] = "Domptez une bête de votre niveau à garder",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {zone:1413} Barrens
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger · Venomtail Scorpids = {npc:3127} Venomtail Scorpid
	["Near {area:362}: Durotar Tigers (cats, level 7-8) roam the south of {zone:1411}, from {area:367} down the coast; Venomtail Scorpids (9-10) the north-west toward {zone:1454}; at 11-12, Savannah Huntresses (cats) prowl the plains around the Crossroads in the {zone:1413}."] = "",
	-- {zone:1412} Mulgore · {zone:1413} Barrens
	-- plural, as words: Flatland Prowlers = {npc:3566} Flatland Prowler · Prairie Wolf Alphas = {npc:2960} Prairie Wolf Alpha
	["Near Bloodhoof: Flatland Prowlers (cats, level 9) and Prairie Wolf Alphas (wolves, 9-10) roam the plains of northern {zone:1412}; at 11-12, Savannah Huntresses (cats) prowl around the Crossroads in the {zone:1413}."] = "",
	-- {area:16638} Valanaar · {area:16626} Gustberry Lowlands · {zone:2521} Zephras Isle
	-- plural, as words: Vuldren Alphas = {npc:250874} Vuldren Alpha · Shriekling Matriarchs = {npc:253283} Shriekling Matriarch · Shadowgale Urseras = {npc:250927} Shadowgale Ursera
	["Near {area:16638}: Vuldren Alphas (level 10), the beast of your last practice tame, hunt the {area:16626}; Shriekling Matriarchs (raptors, level 9) nest just west of {area:16638}; Shadowgale Urseras (bears, 10-11) roam the north of {zone:2521}."] = "Près de {area:16638} : les Alphas vuldrènes (niveau 10), la bête de votre dernier domptage d'entraînement, chassent dans les {area:16626} ; les Matriarches criailleuses (raptors, niveau 9) nichent juste à l'ouest de {area:16638} ; les Urseras trombenoires (ours, 10-11) errent dans le nord de {zone:2521}.",
	-- {spell:1584} Feed Pet · {npc:6928} Innkeeper Grosk · {area:362} Razor Hill · {npc:3025} Kaga Mistrunner · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle
	["{spell:1584}: open your spellbook, cast {spell:1584} and click a food your pet's family eats (the pet's tooltip lists them: cats eat meat and fish, boars almost anything). Raw meat looted from beasts counts. To buy: Grimtak the butcher and {npc:6928} in {area:362} sell meat, {npc:3025} in {zone:1456} and the innkeepers on {zone:2521} too; Bloodhoof's innkeeper and bakers sell bread. Food near the pet's level makes it happiest; much lower food gives about half. You cannot feed in combat."] = "{spell:1584} : ouvrez votre grimoire, lancez {spell:1584} et cliquez sur une nourriture que mange la famille de votre familier (l'infobulle du familier les liste : les félins mangent viande et poisson, les sangliers presque tout). La viande crue ramassée sur les bêtes compte. Pour en acheter : Grimtak le boucher et {npc:6928} à {area:362} vendent de la viande, ainsi que {npc:3025} aux {zone:1456} et les aubergistes de {zone:2521} ; l'aubergiste et les boulangers de Sabot-de-Sang vendent du pain. Une nourriture proche du niveau du familier le rend le plus heureux ; une nourriture bien plus basse en donne environ la moitié. Vous ne pouvez pas nourrir en combat.",
	["Happiness: the face on the pet frame. An unhappy pet does three quarters of its damage, a happy one a quarter more. Happiness drains slowly, faster when the pet dies; a pet left unhappy too long can run away."] = "Humeur : le visage sur le cadre du familier. Un familier mécontent inflige les trois quarts de ses dégâts, un familier heureux un quart de plus. L'humeur baisse lentement, plus vite quand le familier meurt ; un familier laissé trop longtemps mécontent peut s'enfuir.",
	-- {spell:5149} Beast Training
	["Loyalty grows with time and kills. Each loyalty rank raises the training points you spend in {spell:5149} (pet level times loyalty rank minus one)."] = "La loyauté grandit avec le temps et les victimes. Chaque rang de loyauté augmente les points d'entraînement que vous dépensez dans {spell:5149} (niveau du familier multiplié par le rang de loyauté moins un).",
	-- {spell:5149} Beast Training · {npc:9987} Shoja'my · {area:362} Razor Hill · {npc:265756} Genn Fairweather · {zone:2521} Zephras Isle · {npc:9988} Xon'cha · {zone:1454} Orgrimmar
	["{spell:5149} (spellbook, General tab) teaches your current pet the abilities you know. To learn a new ability or rank: leave your pet with a stable master ({npc:9987} in {area:362}, Seikwa at Bloodhoof, {npc:265756} on {zone:2521}, {npc:9988} in {zone:1454}), tame a beast that has it (its pet spellbook tab shows what it knows), use the ability in fights until the game says you learned it, then take your own pet back and teach it with {spell:5149}. A pet holds four active abilities at most."] = "{spell:5149} (grimoire, onglet Général) apprend à votre familier actuel les techniques que vous connaissez. Pour apprendre une nouvelle technique ou un nouveau rang : laissez votre familier à un maître des écuries ({npc:9987} à {area:362}, Seikwa à Sabot-de-Sang, {npc:265756} sur {zone:2521}, {npc:9988} à {zone:1454}), domptez une bête qui la possède (l'onglet du grimoire de familier montre ce qu'elle connaît), utilisez la technique en combat jusqu'à ce que le jeu vous dise que vous l'avez apprise, puis reprenez votre familier et apprenez-la-lui avec {spell:5149}. Un familier a au plus quatre techniques actives.",
	-- {spell:1853} Growl · {area:362} Razor Hill · {npc:3688} Reban Freerunner · {npc:10088} Xao'tsu · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:10086} Hesuwa Thunderhorn · {zone:1456} Thunder Bluff · {area:1641} Hunter Rise · {npc:254411} Quel'dora Quickgale · {area:16638} Valanaar · {area:75} Stonard · {object:3202} Grom'gol (no name in this language: may be words)
	["Pet trainers sell {spell:1853} ranks and resistances. Horde: Harruk in {area:362}, {npc:3688} at Bloodhoof, {npc:10088} in {zone:1454}'s {object:172958}, {npc:10086} on {zone:1456}'s {area:1641}, {npc:254411} in {area:16638}, later Grokor in {area:75} and Zudd at {object:3202}."] = "Les maîtres des familiers vendent les rangs de {spell:1853} et les résistances. Horde : Harruk à {area:362}, {npc:3688} à Sabot-de-Sang, {npc:10088} dans {object:172958} d'{zone:1454}, {npc:10086} sur la {area:1641} des {zone:1456}, {npc:254411} à {area:16638}, plus tard Grokor à {area:75} et Zudd à Grom'gol.",
	-- {spell:883} Call Pet · {spell:2641} Dismiss Pet · {spell:982} Revive Pet · {spell:136} Mend Pet
	["{spell:883}, {spell:2641} and {spell:982} are in your spellbook now; {spell:136} comes from your trainer at 12. A dead pet needs {spell:982}; one that is away more than about 100 yards is dismissed and comes back with {spell:883}."] = "{spell:883}, {spell:2641} et {spell:982} sont maintenant dans votre grimoire ; {spell:136} vient de votre maître de classe au niveau 12. Un familier mort a besoin de {spell:982} ; un familier qui s'éloigne à plus d'environ 100 mètres est renvoyé et revient avec {spell:883}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Near Bloodhoof: Flatland Prowlers (cats, level 9) and Prairie Wolf Alphas (wolves, 9-10) roam the plains of northern {zone:1412}; at 11-12, Savannah Huntresses (cats) prowl around the {area:380} in the {zone:1413}."] = "Près de Sabot-de-Sang : les Rôdeurs des basses plaines (félins, niveau 9) et les Loups Alphas des prairies (loups, 9-10) errent dans les plaines du nord de {zone:1412} ; aux niveaux 11-12, les Chasseresses des savanes (félins) rôdent autour de la {area:380}, dans les {zone:1413}.",
	-- ["Near {area:362}: Durotar Tigers (cats, level 7-8) roam the south of {zone:1411}, from {area:367} down the coast; Venomtail Scorpids (9-10) the north-west toward {zone:1454}; at 11-12, Savannah Huntresses (cats) prowl the plains around the {area:380} in the {zone:1413}."] = "Près de {area:362} : les Tigres de Durotar (félins, niveau 7-8) errent dans le sud de {zone:1411}, depuis le {area:367} le long de la côte ; les Scorpides queue-venin (9-10) dans le nord-ouest vers {zone:1454} ; aux niveaux 11-12, les Chasseresses des savanes (félins) rôdent dans les plaines autour de la {area:380}, dans les {zone:1413}.",
}
