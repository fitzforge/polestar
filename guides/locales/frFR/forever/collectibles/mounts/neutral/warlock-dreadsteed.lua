-- French (frFR): the guide forever/collectibles/mounts/neutral/warlock-dreadsteed (forever/collectibles/mounts/neutral/warlock-dreadsteed.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warlock Dreadsteed"] = "Destrier de l'effroi de démoniste",
	["Your epic mount at 60, summoned anywhere: no epic horse to buy and no 1,000g Journeyman Riding needed."] = "Votre monture épique au niveau 60, invoquée n'importe où : pas de cheval épique à acheter ni de monte compagnon à 1 000 po.",

	-- Step 1: Mor'zul Bloodbringer (Stormwind)
	-- {npc:5520} Spackle Thornberry · {object:2164} Slaughtered Lamb · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5520}, the demon trainer in the {object:2164}, sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:5520}, le maître des démons de l'{object:2164}, vous envoie voir {quest:7562} dans les {zone:1428}.",

	-- Step 2: Mor'zul Bloodbringer (Ironforge)
	-- {npc:6382} Jubahl Corpseseeker · {zone:1455} Ironforge · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:6382}, the demon trainer in {zone:1455}, sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:6382}, le maître des démons de {zone:1455}, vous envoie voir {quest:7562} dans les {zone:1428}.",

	-- Step 3: Mor'zul Bloodbringer (Orgrimmar)
	-- {npc:5815} Kurgul · {object:172960} Cleft of Shadow · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5815}, the demon trainer in the {object:172960}, sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:5815}, le maître des démons de la {object:172960}, vous envoie voir {quest:7562} dans les {zone:1428}.",

	-- Step 4: Mor'zul Bloodbringer (Undercity)
	-- {npc:5753} Martha Strain · {object:36082} Magic Quarter · {quest:7562} Mor'zul Bloodbringer · {zone:1428} Burning Steppes
	["At 60 {npc:5753}, the demon trainer in the {object:36082}, sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:5753}, la maîtresse des démons du {object:36082}, vous envoie voir {quest:7562} dans les {zone:1428}.",

	-- Step 5: Mor'zul Bloodbringer
	-- {quest:7562} Mor'zul Bloodbringer · {npc:14437} Gorzeeki Wildeyes · {area:255} Altar of Storms · {zone:1428} Burning Steppes · {area:254} Blackrock Mountain · {npc:14522} Ur'dan · {area:2057} Scholomance · {area:2577} Dire Maul
	["{quest:7562} and his goblin {npc:14437} camp on the hill across the road from the {area:255}, in the far north-west of the {zone:1428}, west of {area:254}. The chain is long: about 420 gold in {npc:14437}'s and {npc:14522}'s goods, a pile of crafted materials, the {area:2057} and {area:2577}. Start buying or gathering the materials of the next steps now."] = "{quest:7562} et son gobelin {npc:14437} campent sur la colline en face de l'{area:255}, de l'autre côté de la route, à l'extrême nord-ouest des {zone:1428}, à l'ouest du {area:254}. La chaîne est longue : environ 420 pièces d'or de marchandises chez {npc:14437} et {npc:14522}, un tas de matériaux d'artisanat, {area:2057} et {area:2577}. Commencez dès maintenant à acheter ou à récolter les matériaux des étapes suivantes.",

	-- Step 6: Raging Beast's Blood
	-- {zone:1452} Winterspring · {area:2250} Owl Wing Thicket · {area:2242} Hidden Grove
	["Every owlbeast of {zone:1452} (level 53-58, none elite) drops the blood about one time in three: about ninety kills for thirty. {area:2250}, in the north-east, and the {area:2242}'s surroundings are packed with them, and they respawn in five and a half minutes."] = "Chaque chouettard du {zone:1452} (niveau 53-58, aucun élite) lâche le sang environ une fois sur trois : environ quatre-vingt-dix victimes pour trente. Le {area:2250}, au nord-est, et les abords du {area:2242} en sont remplis, et ils réapparaissent en cinq minutes et demie.",

	-- Step 7: Wildeyes
	-- {npc:14436} Mor'zul Bloodbringer · {item:18591} Case of Blood · {npc:14437} Gorzeeki Wildeyes · {quest:7623} Lord Banehollow · {area:1763} Jaedenar · {npc:14523} Ulathek
	-- plural, as words: Shadowy Potions = {item:18802} Shadowy Potion
	["Back to {npc:14436}: he gives you the {item:18591} for {npc:14437} beside him. Then {npc:14436} asks for the bell, the wheel and the candle, and {npc:14437} sends you to {quest:7623} in {area:1763}: buy three Shadowy Potions from him for that trip (6 gold each: one to walk in, one after {npc:14523}, and a spare in case one runs out) and bring 150 gold for the stardust."] = "Retournez voir {npc:14436} : il vous donne la {item:18591} pour {npc:14437}, à côté de lui. Ensuite, {npc:14436} demande la cloche, la roue et la bougie, et {npc:14437} vous envoie voir {quest:7623} à {area:1763} : achetez-lui trois Potions des ténèbres pour ce voyage (6 pièces d'or chacune : une pour entrer, une après {npc:14523}, et une de rechange au cas où l'effet s'arrête) et apportez 150 pièces d'or pour la poussière d'étoile.",
	-- {item:18591} Case of Blood
	["he gives you the {item:18591}"] = "il vous donne {item:18591}",
	-- {item:18802} Shadowy Potion · {npc:14437} Gorzeeki Wildeyes
	["{item:18802}, from {npc:14437}"] = "{item:18802}, chez {npc:14437}",

	-- Step 8: The ritual pieces
	["The ritual pieces"] = "Les éléments rituels",
	-- {npc:14437} Gorzeeki Wildeyes · {skill:171} Alchemy · {item:8925} Crystal Vial · {skill:333} Enchanting · {item:11370} Dark Iron Ore · {skill:186} Mining · {zone:1428} Burning Steppes · {area:1584} Blackrock Depths · {skill:393} Skinning · {npc:7043} Flamescale Wyrmkin
	-- plural, as words: Ghost Mushrooms = {item:8845} Ghost Mushroom · Large Brilliant Shards = {item:14344} Large Brilliant Shard · Dark Iron Deposits = {object:165658} Dark Iron Deposit · Black Dragonscales = {item:15416} Black Dragonscale
	["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}: 3 Ghost Mushrooms and a {item:8925} each), 6 Large Brilliant Shards ({skill:333}: disenchant level 51+ blue items), 25 {item:11370} ({skill:186} 230: the Dark Iron Deposits of the {zone:1428} and {area:1584}) and 35 Black Dragonscales ({skill:393}: the black dragonkin of the {zone:1428}, a few percent a kill, best from the {npc:7043}). Make or gather what your professions allow and buy the rest at the Auction House; it can take a while to find 35 scales."] = "{npc:14437} veut 10 Élixirs de Puissance de l'ombre ({skill:171} : 3 Champignons fantômes et une {item:8925} chacun), 6 Grands éclats brillants ({skill:333} : désenchantez des objets bleus de niveau 51+), 25 {item:11370} ({skill:186} 230 : les Gisements de sombrefer des {zone:1428} et des {area:1584}) et 35 Écailles de dragon noir ({skill:393} : les dragonkins noirs des {zone:1428}, quelques pour cent par victime, surtout sur le {npc:7043}). Fabriquez ou récoltez ce que vos métiers permettent et achetez le reste à l'hôtel des ventes ; trouver 35 écailles peut prendre du temps.",
	-- {item:9264} Elixir of Shadow Power
	["{item:9264}: the Auction House"] = "{item:9264} : l'hôtel des ventes",
	-- {item:14344} Large Brilliant Shard
	["{item:14344}: the Auction House"] = "{item:14344} : l'hôtel des ventes",

	-- Step 9: Arcanite
	-- {npc:14437} Gorzeeki Wildeyes · {item:18629} Black Lodestone · {item:12363} Arcane Crystal · {item:12359} Thorium Bar
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar
	["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars for the {item:18629}: alchemists transmute them (an {item:12363} and a {item:12359} each, on a long cooldown); everyone else buys them."] = "Remettez les trois pièces à {npc:14437}. Il veut ensuite 3 Barres d'arcanite pour la {item:18629} : les alchimistes les transmutent (un {item:12363} et une {item:12359} chacune, avec un long temps de recharge) ; tous les autres les achètent.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: the Auction House"] = "{item:12360} : l'hôtel des ventes",

	-- Step 10: Lord Banehollow
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {zone:1448} Felwood · {area:1770} Shadow Hold · {item:18802} Shadowy Potion · {spell:23179} Taint of Shadow · {quest:7623} Lord Banehollow
	["{area:1763} lies just south of {area:1997} in western {zone:1448}, west of the road; of its two caves, {area:1770} is the northern one, further up the hill. Drink a {item:18802} at its mouth: for 20 minutes the Shadow Council there treat you as one of their own ({spell:23179}). The oozes in the red pool and the succubus Rakaiah beyond them still attack: hug the wall past them. Go down past the second, red pool, up the ramp and across two bridges to {quest:7623}, a great winged dreadlord at the back. He talks to you only while the potion lasts."] = "{area:1763} se trouve juste au sud du {area:1997}, dans l'ouest du {zone:1448}, à l'ouest de la route ; de ses deux grottes, {area:1770} est celle du nord, plus haut sur la colline. Buvez une {item:18802} à son entrée : pendant 20 minutes, le Conseil des ombres vous y traite comme l'un des siens ({spell:23179}). Les limons du bassin rouge et la succube Rakaiah au-delà attaquent quand même : longez le mur pour les dépasser. Descendez après le second bassin, le rouge, montez la rampe et traversez deux ponts jusqu'à {quest:7623}, un grand seigneur de l'effroi ailé au fond. Il ne vous parle que tant que la potion agit.",

	-- Step 11: Ulathek the Traitor
	-- {npc:14523} Ulathek · {spell:23179} Taint of Shadow · {npc:9516} Lord Banehollow
	["{npc:14523} waits in a small side room up a bridge you passed on the way down. Speak to him and he and four guards attack (all level 57, none elite): let your voidwalker hold the guards and burn {npc:14523}, sacrificing it if you must. Or click off your {spell:23179} aura to start the fight, kill {npc:14523}, then drink another potion: the guards stop at once. Take his heart back to {npc:9516} with a potion active."] = "{npc:14523} attend dans une petite salle latérale, en haut d'un pont que vous avez passé en descendant. Parlez-lui et il attaque avec quatre gardes (tous de niveau 57, aucun élite) : laissez votre marcheur du Vide retenir les gardes et concentrez-vous sur {npc:14523}, en sacrifiant le marcheur s'il le faut. Ou bien retirez votre aura {spell:23179} pour lancer le combat, tuez {npc:14523}, puis buvez une autre potion : les gardes s'arrêtent aussitôt. Rapportez son cœur à {npc:9516} avec une potion active.",

	-- Step 12: Xorothian Stardust
	-- {npc:14522} Ur'dan · {quest:7623} Lord Banehollow · {item:18687} Xorothian Stardust · {item:18802} Shadowy Potion
	["{npc:14522}, beside {quest:7623}, sells the {item:18687} for 150 gold. He deals with you only while a {item:18802} is active."] = "{npc:14522}, à côté de {quest:7623}, vend la {item:18687} pour 150 pièces d'or. Il ne traite avec vous que tant qu'une {item:18802} est active.",
	-- {item:18687} Xorothian Stardust · {npc:14522} Ur'dan
	["{item:18687}, from {npc:14522}"] = "{item:18687}, chez {npc:14522}",

	-- Step 13: Imp Delivery
	-- {npc:14437} Gorzeeki Wildeyes · {quest:7630} Arcanite · {item:18688} Imp in a Jar · {area:2057} Scholomance
	["Back to {npc:14437} with the stardust; with the {quest:7630} also done he gives you the {item:18688} for the {area:2057}. Put a group of five together now: a party, not a raid group."] = "Retournez voir {npc:14437} avec la poussière d'étoile ; une fois {quest:7630} aussi terminée, il vous donne le {item:18688} pour {area:2057}. Formez dès maintenant un groupe de cinq : un groupe, pas un groupe de raid.",
	-- {quest:7625} Xorothian Stardust · {npc:14522} Ur'dan
	["{quest:7625}, from {npc:14522}"] = "{quest:7625}, auprès de {npc:14522}",

	-- Step 14: The Scholomance
	-- {area:2057} Scholomance
	["The {area:2057}"] = "{area:2057}",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {item:13704} Skeleton Key · {npc:10508} Ras Frostwhisper · {item:18688} Imp in a Jar · {npc:14500} J'eevee
	["The {area:2057} (level 58-60, a group of five) lies under {area:2298}, the island town in the south-east of the {zone:1422}: someone needs the {item:13704} or a rogue to open the door. Fight down to {npc:10508}'s room and use the {item:18688} at the alchemy lab tables to the right: {npc:14500} makes the parchment. You need not kill Ras, but it only counts at this lab and only in a party."] = "{area:2057} (niveau 58-60, un groupe de cinq) se trouve sous {area:2298}, la ville insulaire au sud-est des {zone:1422} : quelqu'un doit avoir la {item:13704}, ou un voleur doit ouvrir la porte. Frayez-vous un chemin jusqu'à la salle de {npc:10508} et utilisez le {item:18688} aux tables du laboratoire d'alchimie sur la droite : {npc:14500} fabrique le parchemin. Inutile de tuer Ras, mais cela ne compte qu'à ce laboratoire et qu'en groupe.",
	-- {item:18688} Imp in a Jar
	["Use the {item:18688} at the alchemy lab inside"] = "Utilisez le {item:18688} au laboratoire d'alchimie à l'intérieur",

	-- Step 15: Dreadsteed of Xoroth
	-- {npc:14437} Gorzeeki Wildeyes · {npc:14436} Mor'zul Bloodbringer · {item:18663} J'eevee's Jar · {item:18629} Black Lodestone · {item:18670} Xorothian Glyphs
	-- plural, as words: Soul Shards = {item:6265} Soul Shard
	["Back to {npc:14437}, then {npc:14436} hands you his instructions. Buy {item:18663} (150 gold), the {item:18629} (50) and the {item:18670} (50) from {npc:14437}; a warlock friend who owns them can bring theirs instead. Every other warlock who will recharge the nodes needs a Lodestone of their own. Carry 15 or more Soul Shards."] = "Retournez voir {npc:14437}, puis {npc:14436} vous remet ses instructions. Achetez le {item:18663} (150 pièces d'or), la {item:18629} (50) et les {item:18670} (50) à {npc:14437} ; un ami démoniste qui les possède peut apporter les siens à la place. Chaque autre démoniste qui rechargera les nœuds a besoin de sa propre magnétite. Ayez sur vous 15 Fragments d'âme ou plus.",
	-- {item:18663} J'eevee's Jar
	["{item:18663}, 150 gold"] = "{item:18663}, 150 pièces d'or",
	-- {item:18629} Black Lodestone
	["{item:18629}, 50 gold"] = "{item:18629}, 50 pièces d'or",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, 50 gold"] = "{item:18670}, 50 pièces d'or",

	-- Step 16: Into Dire Maul West
	["Into Dire Maul West"] = "Dans Haches-Tripes Ouest",
	-- {area:2577} Dire Maul · {zone:1444} Feralas · {item:18249} Crescent Key · {npc:11496} Immol'thar
	["{area:2577} stands in the ruins of central {zone:1444}: from the gate at the foot of the ruins, walk up through the outer courtyards to the west wing's door at the north end. That door and an inner door need the {item:18249} (it drops from Pusillin in Dire Maul East) or a rogue with 300 Lockpicking. Bring a party of five. Lower {npc:11496}'s shield by killing the guardians of the five pylons (two stand in his own room), then kill {npc:11496}: his dais is the summoning circle. Rest and rebuff before you start."] = "{area:2577} se dresse dans les ruines du centre de {zone:1444} : depuis la porte au pied des ruines, montez à travers les cours extérieures jusqu'à la porte de l'aile ouest, à l'extrémité nord. Cette porte et une porte intérieure exigent la {item:18249} (elle tombe sur Pusillin à Haches-Tripes Est) ou un voleur avec 300 en Crochetage. Venez avec un groupe de cinq. Abaissez le bouclier d'{npc:11496} en tuant les gardiens des cinq pylônes (deux se tiennent dans sa propre salle), puis tuez {npc:11496} : son estrade est le cercle d'invocation. Reposez-vous et renouvelez vos améliorations avant de commencer.",
	-- {npc:11496} Immol'thar
	["{npc:11496}, inside the west wing"] = "{npc:11496}, dans l'aile ouest",

	-- Step 17: The ritual
	["The ritual"] = "Le rituel",
	-- {item:18663} J'eevee's Jar · {npc:14500} J'eevee · {item:6265} Soul Shard · {item:18670} Xorothian Glyphs · {npc:14502} Xorothian Dreadsteed · {npc:14506} Lord Hel'nurath · {npc:14504} Dreadsteed Spirit
	-- plural, as words: Dread Guards = {npc:14483} Dread Guard
	["Stand on the dais and use {item:18663}: {npc:14500} sets out the Bell, the Wheel and the Candle. The Bell heals warlocks, the Wheel shields the party, the Candle burns the imps: ignore the imps and kill the Dread Guards (elite felguards, about ten, sometimes two at once); Banish or Enslave helps. Give one player each node to watch: when one sags, tilts and sounds, a warlock with a Lodestone recharges it, a 3-second cast that any hit breaks (a {item:6265} each), so keep attackers off them. If all three fail, the ritual ends and you start again; while one stands it survives even a wipe. After about six minutes nine symbols glow and a red vortex closes the circle: walk out and the remaining demons vanish at its edge. Rest, then use the {item:18670}. Kill the {npc:14502} (level 62, elite); at half health {npc:14506} joins, a hard hitter who knocks you back. Speak to the {npc:14504}: every warlock in the party who is on this quest can bind it."] = "Placez-vous sur l'estrade et utilisez le {item:18663} : {npc:14500} dispose la cloche, la roue et la bougie. La cloche soigne les démonistes, la roue protège le groupe, la bougie brûle les diablotins : ignorez les diablotins et tuez les Gardes de l'effroi (des gangregardes élites, une dizaine, parfois deux à la fois) ; Bannir ou Asservir aide. Confiez à chaque joueur un nœud à surveiller : quand l'un faiblit, penche et sonne, un démoniste muni d'une magnétite le recharge, une incantation de 3 secondes que le moindre coup interrompt (un {item:6265} chacune), gardez donc les attaquants loin d'eux. Si les trois tombent, le rituel prend fin et vous recommencez ; tant que l'un tient, il survit même à un anéantissement. Au bout de six minutes environ, neuf symboles s'illuminent et un vortex rouge ferme le cercle : sortez-en et les démons restants disparaissent à son bord. Reposez-vous, puis utilisez les {item:18670}. Tuez le {npc:14502} (niveau 62, élite) ; à la moitié de sa vie, {npc:14506} se joint au combat, un cogneur qui vous repousse. Parlez à l'{npc:14504} : chaque démoniste du groupe qui a cette quête peut le lier.",
	-- {item:18663} J'eevee's Jar · {npc:11496} Immol'thar
	["{item:18663}, on {npc:11496}'s dais"] = "{item:18663}, sur l'estrade d'{npc:11496}",
	-- {item:18670} Xorothian Glyphs
	["{item:18670}, once the circle is complete"] = "{item:18670}, une fois le cercle complet",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 60 {npc:5520} in the {object:2164} sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:5520}, à {object:2164}, vous envoie voir {quest:7562} dans les {zone:1428}.",
	-- ["At 60 {npc:5753} in the {object:36082} sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:5753}, dans le {object:36082}, vous envoie voir {quest:7562} dans les {zone:1428}.",
	-- ["At 60 {npc:5815} in the {object:172960} sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:5815}, dans {object:172960}, vous envoie voir {quest:7562} dans les {zone:1428}.",
	-- ["At 60 {npc:6382} in {zone:1455} sends you to {quest:7562} in the {zone:1428}."] = "Au niveau 60, {npc:6382}, à {zone:1455}, vous envoie voir {quest:7562} dans les {zone:1428}.",
	-- ["Back to {npc:14436}, then hand his {item:18591} to {npc:14437} beside him. {npc:14436} then asks for three ritual pieces and {npc:14437} sends you to {zone:1448}: buy two Shadowy Potions from {npc:14437} for that trip."] = "Retournez voir {npc:14436}, puis remettez son {item:18591} à {npc:14437}, à côté de lui. {npc:14436} demande ensuite trois éléments rituels et {npc:14437} vous envoie à {zone:1448} : achetez deux Potions des ténèbres à {npc:14437} pour ce voyage.",
	-- ["Back to {npc:14437} with the stardust. He gives you the {item:18688} for the {area:2057}."] = "Retournez voir {npc:14437} avec la poussière d'étoile. Il vous donne {item:18688} pour {area:2057}.",
	-- ["Back to {npc:14437}, then {npc:14436} hands you his instructions for the ritual. Buy {item:18663}, the {item:18629} and the {item:18670} from {npc:14437}, and carry ten or more Soul Shards."] = "Retournez voir {npc:14437}, puis {npc:14436} vous remet ses instructions pour le rituel. Achetez {item:18663}, {item:18629} et {item:18670} à {npc:14437}, et emportez au moins dix Fragments d'âme.",
	-- ["Gorzeeki wants 10 Elixirs of {spell:5896} ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "Gorzeeki veut 10 Elixirs de {spell:5896} ({skill:171}), 6 Grands éclats brillants ({item:14344}) ({skill:333}), 25 {item:11370} ({skill:186}, à {area:1584} et dans {zone:1427}) et 35 Ecailles de dragon noir ({item:15416}) ({skill:393}, sur les draconiens noirs de {zone:1428}). Fabriquez ou récoltez ce que vos métiers permettent ; achetez le reste à l'hôtel des ventes.",
	-- ["Hand the three pieces to {npc:14437}. He then wants 3 Arcanite Bars: alchemists transmute them, everyone else buys them at the Auction House."] = "Remettez les trois éléments à {npc:14437}. Il veut ensuite 3 Barres d'arcanite (L'arcanite) : les alchimistes les transmutent, les autres les achètent à l'hôtel des ventes.",
	-- ["The owlbeasts of {zone:1452} drop the blood, about one in three: the Ragged and Raging Owlbeasts west of and around {area:2255}, the Crazed, Moontouched and {spell:417141} ones in the east. While you hunt, start on the materials of the next step: the Auction House has them all."] = "Les chouettards de {zone:1452} lâchent le sang, environ une fois sur trois : les Chouettards éreintés et enragés ({npc:7451}) à l'ouest et autour de {area:2255}, les affolés, lunaires et {spell:417141} à l'est. Pendant votre chasse, commencez les matériaux de l'étape suivante : l'hôtel des ventes les a tous.",
	-- ["The ritual in {area:2577}"] = "Le rituel à {area:2577}",
	-- ["The {area:2057} lies under {area:2298}, the island town in the south-east of the {zone:1422}: you need its key or a rogue to open the door, and Rattlegore's {item:13873} to go deeper. Use the {item:18688} at the alchemy lab in {npc:10508}'s room; {npc:14500} makes the parchment. Bring a group."] = "{area:2057} se trouve sous {area:2298}, la ville insulaire du sud-est des {zone:1422} : il vous faut sa clé ou un voleur pour ouvrir la porte, et {item:13873} de Cliquettripes pour aller plus loin. Utilisez {item:18688} au laboratoire d'alchimie dans la salle de {npc:10508} ; {npc:14500} fabrique le parchemin. Venez en groupe.",
	-- ["Use the {item:18688} at the alchemy lab"] = "Utilisez {item:18688} au laboratoire d'alchimie",
	-- ["Your epic mount at 60: summoned anywhere, with no gold spent on an epic horse."] = "Votre monture épique au niveau 60 : invoquée n'importe où, sans dépenser d'or pour un cheval épique.",
	-- ["{area:1763} is in western {zone:1448}. Drink a {item:18802} before you go in: the Shadow Council cultists turn friendly for a while, the demons do not. {quest:7623} waits deep inside {area:1770}, the cave above {area:1763}, across a bridge in the great root chamber."] = "{area:1763} se trouve dans l'ouest de {zone:1448}. Buvez une {item:18802} avant d'entrer : les cultistes du Conseil des ombres deviennent amicaux un moment, pas les démons. {quest:7623} attend au fond du {area:1770}, la grotte au-dessus de {area:1763}, de l'autre côté d'un pont dans la grande salle des racines.",
	-- ["{area:2577} stands in the ruins of central {zone:1444}; the ritual circle is in its west wing, past {npc:11496}, and the door needs the {item:18249} or a rogue. Use {item:18663} to start; when the bell, the wheel or the candle fades, click it with the {item:18629} (a {item:6265} each). When the demons stop coming, use the {item:18670}, defeat the {npc:14502} and its dreadlord master, and speak to the {npc:14504}. Bring a group."] = "{area:2577} se dresse dans les ruines du centre de {zone:1444} ; le cercle rituel est dans son aile ouest, après {npc:11496}, et la porte demande {item:18249} ou un voleur. Utilisez {item:18663} pour commencer ; quand la cloche, la roue ou la bougie faiblit, cliquez dessus avec {item:18629} (un {item:6265} à chaque fois). Quand les démons cessent d'arriver, utilisez {item:18670}, vainquez le {npc:14502} et son maître seigneur de l'effroi, puis parlez à l'{npc:14504}. Venez en groupe.",
	-- ["{npc:14437} wants 10 Elixirs of Shadow Power ({skill:171}), 6 Large Brilliant Shards ({skill:333}), 25 {item:11370} ({skill:186}, in {area:1584} and the {zone:1427}) and 35 Black Dragonscales ({skill:393}, black dragonkin of the {zone:1428}). Make or gather what your professions allow; buy the rest at the Auction House."] = "{npc:14437} veut 10 Elixirs de Puissance de l'ombre ({skill:171}), 6 Grands éclats brillants ({skill:333}), 25 {item:11370} ({skill:186}, dans les {area:1584} et la {zone:1427}) et 35 Ecailles de dragon noir ({skill:393}, sur les draconiens noirs des {zone:1428}). Fabriquez ou récoltez ce que vos métiers permettent ; achetez le reste à l'hôtel des ventes.",
	-- ["{npc:14504}: it binds itself to you"] = "{npc:14504} : il se lie à vous",
	-- ["{npc:14522}, beside {quest:7623}, sells the {item:18687}; he only deals with you while a {item:18802} is active. Bring plenty of gold."] = "{npc:14522}, à côté de {quest:7623}, vend {item:18687} ; il ne traite avec vous que sous l'effet d'une {item:18802}. Prévoyez beaucoup d'or.",
	-- ["{npc:14523} waits in a side chamber by a bridge on the way back up. Speak to him and he and his four guards attack; none are elite. Take his heart back to {npc:9516}, drinking another potion if the first wore off."] = "{npc:14523} attend dans une salle latérale près d'un pont, sur le chemin du retour. Parlez-lui : lui et ses quatre gardes attaquent ; aucun n'est élite. Rapportez son cœur à {npc:9516}, en buvant une autre potion si la première s'est dissipée.",
	-- ["{quest:7562} and his goblin {npc:14437} camp at the {area:255}, in the north-west of the {zone:1428}, west of {area:254}. The chain is long, costs gold at {npc:14437}'s and ends in two dungeons."] = "{quest:7562} et son gobelin {npc:14437} campent à l'{area:255}, au nord-ouest des {zone:1428}, à l'ouest du {area:254}. La chaîne est longue, coûte de l'or chez {npc:14437} et se termine dans deux donjons.",
}
