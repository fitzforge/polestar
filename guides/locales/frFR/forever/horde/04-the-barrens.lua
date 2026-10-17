-- French (frFR): the guide forever/horde/04-the-barrens (forever/horde/04-the-barrens.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voler jusqu'à {area:392}",
	-- {object:172982} Valley of Strength
	["Doras, the wind rider master, stands on the tower in the {object:172982}."] = "Doras, le maître des coursiers du vent, se tient sur la tour de la {object:172982}.",

	-- Step 2: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks
	["{npc:3442}, beside the wind rider master. Keep it: {quest:1483} is in Stonetalon, later"] = "{npc:3442}, à côté du maître des coursiers du vent. Gardez-la : {quest:1483} se fait aux Serres-Rocheuses, plus tard",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "Affiche {object:3972}",
	-- {npc:3453} Wharfmaster Dizzywig
	["{npc:3453}, on the dock"] = "{npc:3453}, sur le quai",

	-- Step 3: Bruuz
	-- {npc:209797} Bruuz · {area:392} Ratchet
	["{npc:209797} swims in the harbour just off {area:392}'s docks. {npc:209797} is elite: grouping up is advised."] = "{npc:209797} nage dans le port, juste au large des quais de {area:392}. {npc:209797} est élite : il est conseillé de se grouper.",

	-- Step 4: Baron Longshore
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Les pirates campent sur la plage au sud de {area:392} ; {npc:3467} se tient à son extrémité sud.",

	-- Step 5: Northwatch Hold
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast further south. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now."] = "{area:385}, sur la côte plus au sud. Les Soldats de marine de Theramore et les Protectrices de Theramore (15-16) laissent les médailles ; {npc:3393} (20) et les deux canonniers (19) se tiennent dans le donjon et sur ses remparts, c'est pourquoi le fort attend jusqu'ici.",

	-- Step 6: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} est enchaîné dans le fort. Parlez-lui pour lancer l'escorte et restez près de lui : des soldats de Theramore attaquent à la sortie. Il vous ramène à {area:392}.",

	-- Step 8: Raptor Horns
	-- {area:380} Crossroads · {area:1697} Raptor Grounds · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains south of the {area:380}, around the {area:1697}; they drop the horns. Hand them in on your next pass through {area:392}."] = "Les Faucheurs solécaille chassent dans les plaines au sud de {area:380}, autour du {area:1697} ; ils laissent les cornes. Rendez-les lors de votre prochain passage à {area:392}.",

	-- Step 9: Crossroads
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}. Gardez-la : Kadrak au {area:1703}, guide suivant",
	-- {npc:3428} Korran · {area:390} Field of Giants
	["{npc:3428}: the eggs are in the {area:390}, later"] = "{npc:3428} : les œufs sont au {area:390}, plus tard",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, en haut de la tour",

	-- Step 10: Dreadmist Peak
	-- {area:380} Crossroads · {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Ride north from the {area:380} to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the {area:380}. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Allez au nord de {area:380} jusqu'au {area:384} et remplissez l'{item:15842} au {object:19464}, puis revenez voir {npc:3448} à {area:380}. Pas d'{skill:182} ? {npc:3490}, à côté de lui, vend de la {item:2449}, trois à la fois jusqu'au réassort.",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} auprès de {npc:3490} ; les herboristes en cueillent dans les plaines",

	-- Step 11: Level 20
	["Level 20"] = "Niveau 20",
	-- {zone:1454} Orgrimmar · {npc:3354} Sorek · {npc:5892} Searn Firewarder · {area:380} Crossroads · {area:388} Stagnant Oasis
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["The level-20 class quests in {zone:1454} ({npc:3354}, {npc:5892}, the Warlock and Rogue trainers) are only offered from level 20, so finish the level here before you fly. The Thunderhawk Hatchlings (18) on the plains south-west of the {area:380} and the Kolkar (14-15) at the {area:388} are the nearest mobs worth killing; you need well under a level."] = "Les quêtes de classe de niveau 20 à {zone:1454} ({npc:3354}, {npc:5892}, les maîtres démonistes et voleurs) ne sont proposées qu'à partir du niveau 20 : finissez le niveau ici avant de voler. Les Jeunes faucons-tonnerre (18) dans les plaines au sud-ouest de {area:380} et les kolkars (14-15) à l'{area:388} sont les monstres valables les plus proches ; il vous faut bien moins d'un niveau.",
	-- {area:380} Crossroads
	-- plural, as words: Thunderhawk Hatchlings = {npc:3247} Thunderhawk Hatchling
	["grind on Thunderhawk Hatchlings south-west of the {area:380}"] = "tuez des Jeunes faucons-tonnerre au sud-ouest de {area:380}",

	-- Step 12: Orgrimmar
	-- {area:1637} Orgrimmar · {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom
	["Fly to {area:1637} to train your level 20 ranks. {npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "Volez jusqu'à {area:1637} pour apprendre vos rangs de niveau 20. {npc:3354} est dans la {object:172958}, {npc:5892} dans la {object:172957}.",

	-- Step 13: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["The {object:172960} is the canyon under the {object:172982}."] = "{object:172960} est le canyon sous {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, à quelques pas",

	-- Step 14: Shenthul
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {quest:2460} The Shattered Salute
	["{npc:3401} stands in the {object:172960}. Target him and type /salute to finish {quest:2460}."] = "{npc:3401} se tient dans la {object:172960}. Ciblez-le et tapez /salute pour terminer {quest:2460}.",
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382}"] = "{quest:2458} : {npc:7233}, près de la {area:382}",

	-- Step 15: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} se tient dans la {object:172961}, à l'ouest de la ville.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018} : {npc:4606} à {zone:1458}, dans deux guides",

	-- Step 16: Thunder Bluff
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}."] = "Volez jusqu'aux {area:1638} et apprenez vos rangs de niveau 20 : {npc:3033} est sur la {area:1639}.",

	-- Step 17: Back to the Crossroads
	-- {area:380} Crossroads
	["Back to the {area:380}"] = "Retour à {area:380}",

	-- Step 18: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3389} stands at the Kolkar watch post just west of the {area:380}."] = "{npc:3389} se tient au poste de guet kolkar juste à l'ouest de {area:380}.",

	-- Step 19: Barak Kodobane
	-- {npc:3394} Barak Kodobane · {npc:3389} Regthar Deathgate
	["{npc:3394} stands in the Kolkar camp north-west of {npc:3389}."] = "{npc:3394} se tient dans le camp kolkar au nord-ouest de {npc:3389}.",
	-- {item:15852} Kodo Horn
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["{item:15852}: Lost Barrens Kodos on the plains around the Kolkar camp"] = "{item:15852} : Kodos égarés des Tarides ({npc:3234}) dans les plaines autour du camp kolkar",
	-- {item:2449} Earthroot
	["{item:2449}: herbalists pick it here"] = "{item:2449} : les herboristes en cueillent ici",

	-- Step 21: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} vit à {area:2539}, le village troll juste à l'entrée des Serres-Rocheuses, au bout de la route à l'ouest de {npc:3389}.",

	-- Step 22: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Au nord vers les {area:383}. {npc:3682} campe au pied des collines ; {npc:261366}, l'ermite sur la crête derrière lui, n'a du travail pour vous qu'une fois que {npc:3682} vous y envoie.",

	-- Step 23: Dry Hills
	-- {area:392} Ratchet · {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them, so do both here and skip the Matriarchs by {area:392}. {quest:876} leads the Witchwing harpies in the hills to the west."] = "",

	-- Step 26: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}."] = "{npc:262119} et ses soldats de marine tiennent la caravane détruite au sud de {npc:261366}.",

	-- Step 27: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Aidez {npc:261366} : restez près de lui quand {npc:261367} et les soldats de marine de {area:21} montent la crête",

	-- Step 28: Strange Lockbox
	-- {object:177792} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177792} se trouve au bord nord de {area:382}, près de la tour de la KapitalRisk. Il contient le {item:15883} pour {quest:30}.",

	-- Step 29: Ignition
	-- {area:382} Sludge Fen · {npc:3439} Wizzlecrank's Shredder · {npc:3445} Supervisor Lugwizzle
	["East to the {area:382}. {npc:3439} stands inside the Venture Co. camp; {npc:3445} carries the key."] = "À l'est vers la {area:382}. Le {npc:3439} se trouve dans le camp de la KapitalRisk ; {npc:3445} porte la clé.",

	-- Step 30: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}."] = "Le Pilote Wizzlecrank sort du camp avec son déchiqueteur : restez avec lui et tuez tout ce qui l'attaque. {npc:3442} le récupère à {area:392}.",

	-- Step 31: Taskmaster Fizzule
	-- {area:382} Sludge Fen
	["Fizzule runs the Venture Co. camp at the east end of the {area:382}. He attacks strangers: target him and /salute before he does."] = "Fizzule dirige le camp de la KapitalRisk à l'extrémité est de la {area:382}. Il attaque les inconnus : ciblez-le et faites /salute avant lui.",

	-- Step 32: Mission: Possible But Not Probable
	-- {npc:7287} Foreman Silixiz
	["Stay stealthed: {npc:7287} carries the key to the tower; Gallywix and his lockbox are at the top. Gallywix is elite: grouping up is advised."] = "Restez camouflé : {npc:7287} porte la clé de la tour ; Gallywix et son coffret sont au sommet. Gallywix est élite : il est conseillé de se grouper.",
	["Venture Co. tower"] = "Tour de la KapitalRisk",

	-- Step 33: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Les Surveillants de la KapitalRisk et Massacreurs de la KapitalRisk de la mine au nord-est de la zone laissent l'{item:5097}.",

	-- Step 34: Hearth to the Crossroads
	-- {area:380} Crossroads
	["Hearth to the {area:380}"] = "Pierre de foyer vers {area:380}",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Il vous donne le {item:15826}",

	-- Step 35: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:380} Crossroads
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the {area:380}."] = "{npc:3395} se promène parmi les kolkars à l'{area:388}, au sud-est de {area:380}.",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve · {area:380} Crossroads
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the {area:380}"] = "{npc:12296} : utilisez le {item:15826} sur elles ; elles errent dans les plaines tout autour de {area:380}",

	-- Step 36: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Suivez la {area:458} vers le sud jusqu'au {area:378}.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, dans la cage",
	-- {npc:3433} Tatternack Steelforge
	["{npc:3433}, at the north edge of the camp"] = "{npc:3433}, au bord nord du camp",

	-- Step 37: Bristleback camps
	["Bristleback camps"] = "Camps Dos-hirsute",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {item:5075} Blood Shard · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. Every Bristleback drops a tusk; {npc:3432}'s wife lies at the north edge. Keep one {item:5075}. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Les camps des huran Dos-hirsute s'étendent sur les plaines au nord du {area:378}, de part et d'autre de la {area:458}. Chaque Dos-hirsute laisse une défense ; la femme de {npc:3432} gît au bord nord. Gardez un {item:5075}. {quest:883}, un kodo gris, erre parfois ici : son sabot lance une quête.",

	-- Step 38: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Dogran est enchaîné dans le camp huran à l'ouest de la route.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, at the end of this guide"] = "Gardez-la : {npc:5875} à {zone:1454}, à la fin de ce guide",

	-- Step 40: Stolen Silver
	-- {area:385} Northwatch Hold
	["East across the plains toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "À l'est à travers les plaines vers la côte : l'argent volé se trouve dans un nid de raptors au nord-ouest de {area:385}.",

	-- Step 41: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} attend sur la colline au sud de {area:392}, sur votre route vers le nord.",

	-- Step 43: Ishamuhale
	-- {quest:882} Ishamuhale · {area:392} Ratchet · {area:380} Crossroads
	["{quest:882}, a big Sunscale raptor, hunts the plains north of the road from {area:392} to the {area:380}."] = "{quest:882}, un grand raptor solécaille, chasse dans les plaines au nord de la route de {area:392} à {area:380}.",

	-- Step 44: Crossroads
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} propose {quest:95774} une fois {quest:4921} rendue",

	-- Step 46: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {area:380} Crossroads
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. Hand his head to {npc:3389} on your last {area:380} stop."] = "{npc:3396} mène les kolkars sur la rive ouest de l'{area:387}, au sud de {npc:3389}. Rendez sa tête à {npc:3389} lors de votre dernier arrêt à {area:380}.",

	-- Step 47: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik · {area:380} Crossroads
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last {area:380} stop."] = "En redescendant la {area:458} vers le {area:378} : les Pillards tranchecrin parmi les camps Dos-hirsute, de part et d'autre de la route au nord du camp, portent {item:277277}. Rendez-les à {npc:3432} lors de votre dernier arrêt à {area:380}.",

	-- Step 48: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Redescendez la {area:458} jusqu'au {area:378}.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Gardez-la : {npc:12696} en {zone:1440}, guide suivant",

	-- Step 49: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Les Têtes-tonnerre paissent dans les plaines juste au sud du {area:378}. {quest:884}, un lézard-tonnerre bleu, erre parmi eux : sa pointe caudale lance une quête.",

	-- Step 51: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the same plains south of the camp."] = "Les Faucons-tonnerre des nuages tournoient au-dessus des mêmes plaines au sud du camp.",

	-- Step 53: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Harvesters = {npc:3253} Silithid Harvester
	["South of Camp Taurajo the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them. Silithid Harvesters are rare: if you see one, kill it for its head."] = "Au sud du Camp Taurajo, les Antres des silithides parsèment le {area:390} ; les œufs y sont, et des Grouillants silithides sortent pour les défendre. Les Moissonneurs silithides sont rares : si vous en voyez un, tuez-le pour sa tête.",

	-- Step 54: Gann Stonespire
	-- {npc:3341} Gann Stonespire · {area:359} Bael Modan
	["{npc:3341} waits in a small camp further south, on the road toward {area:359}."] = "{npc:3341} attend dans un petit camp plus au sud, sur la route de {area:359}.",
	-- {npc:14242} Sulhasa · {npc:3341} Gann Stonespire
	["{npc:14242}, up in the tree just east of {npc:3341}"] = "{npc:14242}, dans l'arbre juste à l'est de {npc:3341}",
	-- {npc:5899} Brine · {npc:3341} Gann Stonespire
	["{npc:5899}, just west of {npc:3341}"] = "{npc:5899}, juste à l'ouest de {npc:3341}",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Remplissez l'{item:7766} au point d'eau des huran",
	-- {object:107045} Spring Well · {area:272} Tarren Mill
	["Keep it: the {object:107045} is beside {area:272}"] = "Gardez-la : le {object:107045} est à côté d'{area:272}",

	-- Step 55: Blackthorn Ridge
	-- {area:1701} Blackthorn Ridge · {npc:3436} Kuz · {npc:3434} Nak · {npc:3435} Lok Orcbane · {npc:5859} Hagg Taurenbane · {npc:3238} Stormhide · {npc:3341} Gann Stonespire · {quest:885} Washte Pawne
	-- plural, as words: Hecklefang Stalkers = {npc:4128} Hecklefang Stalker
	["West of Gann, the Razormane hold {area:1701}. {npc:3436} is on the east side, {npc:3434} to the south, {npc:3435} at the west end. Lok (25) and the Warfrenzies (24-25) are a few levels above you; {npc:5859}, a rare elite, sometimes walks the ridge: leave him. Pathfinders and Stalkers drop the Backstabber, Seers the Wand, Warfrenzies the War Shield. {npc:3238} lizards and Hecklefang Stalkers roam the plain between {npc:3341} and the ridge. {quest:885}, a rare red wind serpent, flies over the ridge: its feather starts a quest."] = "À l'ouest de {npc:3341}, les Tranchecrin tiennent la {area:1701}. {npc:3436} est à l'est, {npc:3434} au sud, {npc:3435} à l'extrémité ouest. Lok (25) et les Frénétiques Tranchecrin (24-25) ont quelques niveaux de plus que vous ; {npc:5859}, un élite rare, parcourt parfois la crête : laissez-le. Les Guides Tranchecrin et Traqueurs Tranchecrin laissent le Poignard de Tranchecrin, les Prophètes Tranchecrin la Baguette Tranchecrin carbonisée, les Frénétiques le Bouclier Tranchecrin. Les lézards {npc:3238} et les Traqueuses Jappecroc errent dans la plaine entre Gann et la crête. {quest:885}, une serpent des vents rouge et rare, survole la crête : sa plume lance une quête.",
	-- {npc:3238} Stormhide · {npc:3341} Gann Stonespire
	["{npc:3238}, on the plain between {npc:3341} and the ridge"] = "{npc:3238}, dans la plaine entre {npc:3341} et la crête",

	-- Step 56: Bael Modan
	-- {area:359} Bael Modan · {npc:3392} Prospector Khazgorm
	["South of Gann, the Bael'dun dwarves dig at {area:359}. Excavators and Foremen work the pit; {npc:3392} (26) carries the journal: pull him alone."] = "Au sud de Gann, les nains de Bael'dun creusent à {area:359}. Les Excavateurs de Bael'dun et Contremaîtres de Bael'dun travaillent la fosse ; {npc:3392} (26) porte le journal : attirez-le seul.",

	-- Step 58: Bael'dun fortress
	["Bael'dun fortress"] = "Forteresse de Bael'dun",
	-- plural, as words: Bael'dun Soldiers = {npc:3376} Bael'dun Soldier
	["The Bael'dun Soldiers, Riflemen and Officers guard the fortress on the east side of the dig; all three items drop from them."] = "Les Soldats de Bael'dun, Fusiliers de Bael'dun et Officiers de Bael'dun gardent la forteresse à l'est du site de fouilles ; les trois objets viennent d'eux.",

	-- Step 60: The flying machine
	["The flying machine"] = "La machine volante",
	["The dwarves' flying machine sits on its platform inside the dig site."] = "La machine volante des nains repose sur sa plateforme dans le site de fouilles.",

	-- Step 62: Twitching Antennae
	["Twitching Antennae"] = "Antennes frémissantes",
	-- {area:390} Field of Giants · {area:378} Camp Taurajo
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer
	["The antennae vanish fifteen minutes after they drop, so gather them now, on the way back north: kill the Silithid Swarmers and Creepers at the {area:390}' mounds until you have five, then hearth to {area:378} straight away."] = "Les antennes disparaissent quinze minutes après leur butin : ramassez-les maintenant, en remontant vers le nord. Tuez les Grouillants silithides et Rampants silithides près des antres du {area:390} jusqu'à en avoir cinq, puis utilisez tout de suite la Pierre de foyer vers le {area:378}.",
	["Twitching Antennae from the silithid"] = "Antennes frémissantes des silithides",

	-- Step 66: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:380} Crossroads
	["{npc:5878} camps beside the road east of the {area:380}."] = "{npc:5878} campe au bord de la route à l'est de {area:380}.",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Il propose ensuite {quest:1838} (1838, niveau 30) : elle demande {area:1717} et vous envoie partout en Kalimdor et dans les Royaumes de l'Est. Le guide de classe Guerrier {quest:1838} la couvre.",

	-- Step 67: Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637} to train."] = "Volez jusqu'à {area:1637} pour vous entraîner.",

	-- Step 68: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["{npc:246344} teaches Paladins in {area:1638}. You have no flight path there yet: fly to {area:378}, ride west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "{npc:246344} forme les paladins aux {area:1638}. Vous n'y avez pas encore de trajet aérien : volez jusqu'au {area:378}, traversez {zone:1412} vers l'ouest, montez par un ascenseur et prenez le trajet aérien auprès de {npc:2995} sur le plateau central.",

	-- Step 69: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {item:6626} Dogran's Pendant
	["{npc:5875} stands in the {object:172960}. Use {item:6626} on the summoning circle there and defeat the succubus to bind her."] = "{npc:5875} se tient dans la {object:172960}. Utilisez {item:6626} sur le cercle d'invocation et battez la succube pour la lier.",

	-- Step 70: Shenthul
	-- {npc:2391} Serge Hinott · {area:272} Tarren Mill
	["{npc:2391} in {area:272} teaches Poisons: keep it"] = "{npc:2391} à {area:272} enseigne les Poisons : gardez-la",

	-- Step 71: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Volez jusqu'aux {area:1638} pour vous entraîner : {npc:3033} est sur la {area:1639}.",

	-- Step 72: Moonglade
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}."] = "Lancez {spell:18960}. Taurens : assemblez les deux moitiés du pendentif au {area:2362}, sur la rive nord-ouest du lac, avant d'aller voir {npc:11802} à {area:2361}.",
	-- {item:15885} Pendant of the Sea Lion · {area:2362} Shrine of Remulos
	["{item:15885}: use a half at the {area:2362}"] = "{item:15885} : utilisez une moitié au {area:2362}",
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802} : l'accueil de {npc:3033}",

	-- Step 73: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "Les {area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue."] = "Taurens : le {npc:11957} attend sur la colline sud au-dessus du pont. Éolides : l'{npc:272054} se tient au sud des ponts jumeaux. Ensuite, les tanières à l'est du lac : quittez votre forme, cliquez sur la statue à l'entrée pour cinq minutes de camouflage, évitez les esprits à l'intérieur et prenez une relique de chaque ; la {item:280680} se trouve au pied de la statue de chat blanc.",

	-- Step 75: Turak Runetotem
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798} à {area:2361} y emmène les druides",

	-- Step 76: Back to the Crossroads
	-- {area:380} Crossroads · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["Fly back to the {area:380}. The next guide starts here and takes the road north to the {area:1703} and {zone:1440}."] = "Retour en vol à {area:380}. Le guide suivant commence ici et prend la route du nord vers le {area:1703} et {zone:1440}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bruuz"] = "Bruuz",
	-- ["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west."] = "Les Patriarches des savanes errent dans les plaines à l'est des collines, et les Pièges déclenchés sont parmi eux. {quest:876} mène aux harpies Ensorçaile dans les collines à l'ouest.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:177790} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "La {object:177790} se trouve au bord nord de la {area:382}, près de la tour de la KapitalRisk. Elle contient le {item:15883} pour {quest:30}.",
	-- ["{area:263} of Shadow is the canyon under the {object:172982}."] = "{area:263} de l'Ombre est le canyon sous la {object:172982}.",
	-- ["{item:15852}: Lost {zone:1413} Kodos on the plains around the Kolkar camp"] = "{item:15852} : Kodos égarés des {zone:1413} dans les plaines autour du camp kolkar",
	-- ["{npc:2391} in {area:272} teaches {spell:2842}: keep it"] = "{npc:2391} à {area:272} enseigne {spell:2842} : gardez-la",
	-- ["{npc:3033}: Cat Form"] = "{npc:3033} : Forme de félin",
	-- ["{npc:3033}: Cure Poison"] = "{npc:3033} : Guérison du poison",
}
