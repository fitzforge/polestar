-- French (frFR): the guide forever/reputation/orgrimmar (forever/reputation/orgrimmar.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orgrimmar Reputation"] = "Réputation : Orgrimmar",
	-- {zone:1411} Durotar · {zone:1448} Felwood · {zone:1447} Azshara · {item:14047} Runecloth
	["{zone:1411} and Crossroads quests while you level, {zone:1448} and {zone:1447} quests from 55, then {item:14047} to Exalted."] = "",
	-- {faction:76} Orgrimmar
	["Exalted with {faction:76}"] = "Exalté auprès d'{faction:76}",

	-- Step 1: Orgrimmar: how it works
	-- {faction:76} Orgrimmar
	["{faction:76}: how it works"] = "{faction:76} : comment ça marche",
	-- {faction:76} Orgrimmar · {npc:14726} Rashona Straglash · {quest:7832} Additional Runecloth · {item:14047} Runecloth · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{faction:76} reputation comes from quests and cloth. {npc:14726}, the cloth quartermaster, stands in the Drag beside the cloth and leather armor shop. She takes four one-time donations of 60 cloth (150 each) and then {quest:7832}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:76} also gives a quarter as much to {zone:1456}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:76}'s quests within 5 levels of them: {zone:1411} at 5 to 12, the Crossroads at 12 to 20, {npc:4949}'s {quest:5726} at 12 to 16. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Orgrimmar's merchants sell to you for 10% less (the Classic rule), the wolf vendor included; at Exalted other races can buy the wolves: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60, once you have mount training. {faction:76} has no tabard or other reward."] = "",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363} (étape facultative)",
	-- {area:363} Valley of Trials · {faction:76} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {faction:76} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "",
	-- {npc:3144} Eitrigg · {faction:76} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {faction:76}: {quest:787}, +50"] = "{npc:3144}, à {faction:76} : {quest:787}, +50",
	-- {npc:5765} Ruzan · {quest:792} Vile Familiars
	["{npc:5765}: {quest:792}, warlocks only"] = "{npc:5765} : {quest:792}, démonistes seulement",

	-- Step 3: Boars, weapons and peons
	["Boars, weapons and peons"] = "Sangliers, armes et péons",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["The training weapons lie on the ground in the Den and among the boars to the north. For the peons: target a sleeping {npc:10556} and use the {item:16114} on it."] = "Les armes d'entraînement sont posées au sol dans la Tanière et parmi les sangliers au nord. Pour les péons : ciblez un {npc:10556} endormi et utilisez la {item:16114} sur lui.",
	-- {npc:10556} Lazy Peon · {item:16114} Foreman's Blackjack
	["{npc:10556}: hit it with the {item:16114}"] = "{npc:10556} : frappez-le avec la {item:16114}",
	-- {npc:10556} Lazy Peon
	["Wake {npc:10556}"] = "",

	-- Step 4: The Den: hand in
	-- {area:364} The Den
	["{area:364}: hand in"] = "{area:364} : rendez les quêtes",

	-- Step 5: North of the Den
	["North of the Den"] = "Au nord de la Tanière",
	-- {npc:3287} Hana'zua · {quest:790} Sarkoth · {quest:792} Vile Familiars · {area:365} Burning Blade Coven · {quest:6394} Thazz'ril's Pick
	["The cactus apples grow beside the cacti north of the Den. {npc:3287} lies wounded by the rocks to the north; {quest:790}, his big scorpid, roams close by. {quest:792} swarm at the mouth of the {area:365}; {quest:6394} lies inside: take the middle tunnel where it splits three ways."] = "Les pommes de cactus poussent à côté des cactus au nord de la Tanière. {npc:3287} est étendu, blessé, près des rochers au nord ; {quest:790}, son gros scorpide, rôde tout près. {quest:792} grouillent à l'entrée du {area:365} ; {quest:6394} est à l'intérieur : prenez le tunnel du milieu là où il se divise en trois.",
	-- {quest:6394} Thazz'ril's Pick
	["{quest:6394}, in the cave"] = "{quest:6394}, dans la grotte",

	-- Step 6: The Den: hand in again
	-- {area:364} The Den
	["{area:364}: hand in again"] = "{area:364} : rendez encore les quêtes",

	-- Step 7: Burning Blade Coven
	-- {npc:3183} Yarrog Baneshadow
	["Go back into the cave and keep to the right-hand wall all the way, over a small stream, to {npc:3183} on a ledge above a pool."] = "Retournez dans la grotte et longez la paroi de droite jusqu'au bout, en passant un petit ruisseau, jusqu'à {npc:3183} sur une corniche au-dessus d'un bassin.",
	-- {quest:794} Burning Blade Medallion · {npc:3183} Yarrog Baneshadow
	["{quest:794}, from {npc:3183}"] = "{quest:794}, sur {npc:3183}",
	-- {npc:3145} Zureetha Fargaze
	["{npc:3145}, in the Den"] = "{npc:3145}, dans la Tanière",
	-- {quest:805} Report to Sen'jin Village · {quest:97225} Forgotten Loa Idols
	["{quest:805}, +50: {quest:97225} waits on it"] = "",

	-- Step 9: Sen'jin Village (optional hub)
	-- {area:367} Sen'jin Village
	["{area:367} (optional hub)"] = "{area:367} (étape facultative)",
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {faction:76} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 700 {faction:76} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "",
	-- {quest:97225} Forgotten Loa Idols · {quest:805} Report to Sen'jin Village
	["{quest:97225}, +100: needs {quest:805} from the Den"] = "",

	-- Step 10: The Echo Isles
	-- {area:368} Echo Isles
	["The {area:368}"] = "Les {area:368}",
	-- {area:368} Echo Isles · {quest:826} Zalazane
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Swim to the largest of the {area:368}, south-east of the village. {quest:826}, the idols and the skulls at the circle of power are all there; the Durotar Tigers prowl the smaller islands."] = "Nagez jusqu'à la plus grande des {area:368}, au sud-est du village. {quest:826}, les idoles et les crânes du cercle de pouvoir s'y trouvent tous ; les Tigres de Durotar rôdent sur les petites îles.",
	-- {quest:808} Minshina's Skull · {object:3237} Imprisoned Darkspear
	["{quest:808}: click an {object:3237} skull"] = "{quest:808} : cliquez sur un crâne de {object:3237}",

	-- Step 11: The coast and the road
	["The coast and the road"] = "La côte et la route",
	-- {quest:97223} Bloodtalon Matriarch · {area:362} Razor Hill
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village. The Ridgeshade spiders are along the road south of {area:362} and north-east of the Den."] = "Les makruras et les clampants de l'écume arpentent les plages à l'est et au sud de Sen'jin. {quest:97223} est à l'est du village. Les araignées Ridgeshade sont le long de la route au sud de {area:362} et au nord-est de la Tanière.",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367} : rendez les quêtes",

	-- Step 13: Thrall: Hidden Enemies (optional hub)
	-- {npc:4949} Thrall · {quest:5726} Hidden Enemies
	["{npc:4949}: {quest:5726} (optional hub)"] = "{npc:4949} : {quest:5726} (étape facultative)",
	-- {quest:5726} Hidden Enemies · {faction:76} Orgrimmar · {area:2437} Ragefire Chasm
	["Forever pays these old quests in full at any level. {quest:5726}: 400 {faction:76} reputation in 20 minutes, with a run through {area:2437} that a level 60 clears alone."] = "",

	-- Step 14: Skull Rock: the Lieutenant's Insignia
	-- {quest:827} Skull Rock · {item:14544} Lieutenant's Insignia
	["{quest:827}: the {item:14544}"] = "{quest:827} : l'{item:14544}",
	-- {quest:827} Skull Rock · {faction:76} Orgrimmar
	-- plural, as words: Burning Blade Fanatics = {npc:3197} Burning Blade Fanatic
	["{quest:827} is the cave just east of {faction:76}. Burning Blade Fanatics and Apprentices inside drop the insignia about one kill in five."] = "{quest:827} est la grotte juste à l'est d'{faction:76}. Les Fanatiques et Apprentis de la Lame ardente à l'intérieur laissent l'insigne environ une fois sur cinq.",

	-- Step 15: Orgrimmar: Thrall and Neeru Fireblade
	-- {faction:76} Orgrimmar · {npc:4949} Thrall · {npc:3216} Neeru Fireblade
	["{faction:76}: {npc:4949} and {npc:3216}"] = "{faction:76} : {npc:4949} et {npc:3216}",
	-- {npc:3216} Neeru Fireblade · {object:172960} Cleft of Shadow
	["{npc:3216} is in the {object:172960}. Tell him he may speak openly and click through his story."] = "{npc:3216} est dans la {object:172960}. Dites-lui qu'il peut parler librement et suivez toute son histoire.",
	-- {npc:3216} Neeru Fireblade
	["{npc:3216}: hear him out"] = "{npc:3216} : écoutez-le jusqu'au bout",

	-- Step 16: Ragefire Chasm
	-- {area:2437} Ragefire Chasm · {object:172960} Cleft of Shadow · {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{area:2437} opens off the {object:172960}. {npc:11518} and {npc:11519} wait at the far end."] = "Le {area:2437} s'ouvre dans la {object:172960}. {npc:11518} et {npc:11519} attendent tout au fond.",
	-- {npc:11518} Jergosh the Invoker · {npc:11519} Bazzalan
	["{npc:11518} and {npc:11519}"] = "{npc:11518} et {npc:11519}",

	-- Step 17: Orgrimmar: Hidden Enemies done
	-- {faction:76} Orgrimmar · {quest:5728} Hidden Enemies
	["{faction:76}: {quest:5728} done"] = "{faction:76} : {quest:5728} terminée",

	-- Step 18: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362} : quêtes de Sen'jin à rendre",

	-- Step 19: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362} (étape facultative)",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {faction:76} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow · {npc:266940} Turroc
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,800 {faction:76} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}, +100 : demande {quest:823}, de Sen'jin",

	-- Step 20: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps · {item:275713} Raider's Bow
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}; the {item:275713}, Battleaxe and Shield lie outside the keep."] = "Le donjon est au sud de {area:362}, sur la côte. Le {npc:3192} est dans l'unique bâtiment du donjon ; sa clé ouvre le {object:3239} sur le toit, et l'{item:4881} qu'il contient lance {quest:830}. Les marins et les fusiliers marins laissent les {item:4870} ; l'{item:275713}, la hache d'armes et le bouclier sont posés devant le donjon.",

	-- Step 21: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816} et les {area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}; the Prickly Pear cacti grow among them. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "Les camps Tranchecrin sont au sud-ouest et à l'ouest de {area:362} ; les figuiers de Barbarie poussent parmi eux. Puis allez aux {area:368} pour les {object:3240} : chaque nid donne un œuf à chaque fois.",

	-- Step 22: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362} : rendez les quêtes",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {faction:76} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {faction:76}"] = "{quest:830}, +100 : à {npc:3230}, à {faction:76}",

	-- Step 23: The wreck
	["The wreck"] = "L'épave",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "Le navire échoué est dans les hauts-fonds à l'est du {area:372}. Ouvrez les boîtes à outils gnomes.",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "de retour auprès de {npc:3139}, à {area:362}",

	-- Step 24: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "Nord de {zone:1411}",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293} se tient sur la route au nord de {area:362}, {npc:3193} à sa ferme, à l'ouest.",

	-- Step 25: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369} et {area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {faction:76} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {faction:76}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203} tient un camp de la Lame ardente à {area:369}, au sud d'{faction:76}, parmi les lézards-tonnerre. Les sacs de ravitaillement sont dans le {area:410}, au nord de {area:362}. L'{item:4891} tombe des crocilisques le long de la rivière à l'ouest, environ une fois sur dix.",

	-- Step 26: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293} et Misha",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}, dans le {area:370}",

	-- Step 27: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "",

	-- Step 29: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {faction:76} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {faction:76}."] = "{quest:828} campe devant {quest:827}, la grotte juste à l'est d'{faction:76}.",

	-- Step 30: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {faction:76} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{faction:76}: {npc:3216} and {npc:3230}"] = "{faction:76} : {npc:3216} et {npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow · {npc:3230} Nazgrel · {npc:4949} Thrall
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside {npc:4949}."] = "{quest:829} est dans la {object:172960} ; {npc:3230} dans le fort Grommash, à côté de {npc:4949}.",

	-- Step 31: Far Watch Post
	-- {faction:76} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {faction:76}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "Sortez d'{faction:76} par la porte ouest et traversez le pont vers les {zone:1413}. {npc:3337} et {quest:809} se tiennent au {area:379}.",
	-- {quest:842} Crossroads Conscription · {npc:3338} Sergra Darkthorn
	["{quest:842}, +100: to {npc:3338}"] = "{quest:842}, +100 : à {npc:3338}",

	-- Step 33: The Crossroads (optional hub)
	-- {area:380} The Crossroads
	["{area:380} (optional hub)"] = "{area:380} (étape facultative)",
	-- {area:380} The Crossroads · {faction:76} Orgrimmar · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:267310} Gur'ak · {npc:3432} Mankrik
	["Forever pays these old quests in full at any level. {area:380}: about 1,500 {faction:76} reputation in 70 minutes, {faction:76}'s only. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} and {npc:267310} stand in the town, {npc:3432} by the inn."] = "",

	-- Step 34: Around the Crossroads
	["Around the Crossroads"] = "",
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:10668} Beaten Corpse · {area:378} Camp Taurajo
	["The Razormane camps and the supply crates are north-east of the town; {npc:267307}, an elite boar, sits deep in the {area:1699} cave there. The Witchwing harpies nest far to the north-west. The {npc:10668} lies north-east of {area:378}, in the south: right-click it. Raptors and plainstriders are everywhere."] = "Les camps Tranchecrin et les caisses de ravitaillement sont au nord-est de la ville ; {npc:267307}, un sanglier élite, se tient au fond de la grotte de la {area:1699}, par là. Les harpies Ensorçaile nichent loin au nord-ouest. Le {npc:10668} gît au nord-est du {area:378}, au sud : faites un clic droit dessus. Raptors et trotteurs des plaines sont partout.",
	-- {npc:10668} Beaten Corpse
	["{npc:10668}: right-click it"] = "{npc:10668} : faites un clic droit dessus",

	-- Step 35: The Crossroads: hand in
	-- {area:380} The Crossroads
	["{area:380}: hand in"] = "{area:380} : rendez les quêtes",

	-- Step 36: Zhevras, quilboars, harpies and the Raptor Grounds
	-- {area:1697} Raptor Grounds
	["Zhevras, quilboars, harpies and the {area:1697}"] = "Zhévras, huran, harpies et {area:1697}",
	-- {npc:3438} Kreenig Snarlsnout · {quest:3281} Stolen Silver · {area:1697} Raptor Grounds · {area:378} Camp Taurajo
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner · Witchwing Slayers = {npc:3278} Witchwing Slayer
	["Zhevra Runners graze south and west of the town. {npc:3438} leads the Razormane camps north-east. The Witchwing Slayers carry the rings. The {quest:3281} is in the {area:1697} east of {area:378}: follow the nest-lined path on its left side to the last nest."] = "Les Messagers zhévras paissent au sud et à l'ouest de la ville. {npc:3438} dirige les camps Tranchecrin au nord-est. Les Tueuses Ensorçaile portent les anneaux. L'{quest:3281} se trouve dans les {area:1697}, à l'est du {area:378} : suivez le chemin bordé de nids sur son côté gauche jusqu'au dernier nid.",

	-- Step 37: The Crossroads: hand in again
	-- {area:380} The Crossroads
	["{area:380}: hand in again"] = "{area:380} : rendez de nouveau les quêtes",

	-- Step 38: Prowlers, Serena Bloodfeather and Echeyakee
	-- {npc:3452} Serena Bloodfeather · {quest:881} Echeyakee
	["Prowlers, {npc:3452} and {quest:881}"] = "Rôdeurs, {npc:3452} et {quest:881}",
	-- {quest:876} Serena Bloodfeather · {npc:3338} Sergra Darkthorn · {item:10327} Horn of Echeyakee · {object:147524} Echeyakee's Lair (no name in this language: may be words)
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler
	["Savannah Prowlers lie west and north of the Crossroads. {quest:876} leads the Witchwing harpies in the far north-west. Then {npc:3338} gives you the {item:10327}: blow it beside the kodo bones at {object:147524}, north of the town, and kill the white lion."] = "",

	-- Step 39: Chen's Empty Keg (optional hub)
	-- {quest:819} Chen's Empty Keg
	["{quest:819} (optional hub)"] = "{quest:819} (étape facultative)",
	-- {quest:819} Chen's Empty Keg · {zone:1413} Barrens · {npc:3292} Brewmaster Drohn · {area:392} Ratchet · {faction:76} Orgrimmar
	["Forever pays it in full at any level. {quest:819} lies on the ground at one of several spots in the central and northern {zone:1413}, most of them by the roads around the Crossroads; once someone takes it, it turns up at another. {npc:3292} in {area:392} pays 250 {faction:76} reputation for the keg and its first filling, then 50 for every filling after, as often as you like."] = "",
	-- {quest:819} Chen's Empty Keg
	["{quest:819}: look for it by the roads"] = "{quest:819} : cherchez-le près des routes",

	-- Step 41: Lions, plainstriders and a thunder lizard
	["Lions, plainstriders and a thunder lizard"] = "Lions, trotteurs des plaines et un lézard-tonnerre",
	-- {zone:1413} Barrens
	["Savannah lions, plainstriders and thunder lizards roam the whole northern {zone:1413}. The lions drop a tusk about every other kill, the plainstriders a kidney about two kills in five; any thunder lizard may drop the horn, about one in five."] = "Les lions des savanes, les trotteurs des plaines et les lézards-tonnerre errent dans tout le nord des {zone:1413}. Les lions laissent une défense environ une victime sur deux, les trotteurs un rein environ deux victimes sur cinq ; n'importe quel lézard-tonnerre peut laisser la corne, environ une fois sur cinq.",

	-- Step 42: Ratchet: the repeatable keg
	-- {area:392} Ratchet
	["{area:392}: the repeatable keg"] = "{area:392} : le tonneau répétable",
	-- {item:4897} Thunderhawk Saliva Gland · {item:4896} Kodo Liver · {npc:3238} Stormhide · {area:378} Camp Taurajo · {area:392} Ratchet
	-- plural, as words: Lightning Glands = {item:4898} Lightning Gland · Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["From now on Drohn takes 5 Lightning Glands, a {item:4897} and a {item:4896} for 50, as often as you like. The {npc:3238} thunder lizards (a gland about every other kill), the Greater Thunderhawks and the kodos south of {area:378} drop them. Gather several sets before you head back to {area:392}."] = "Désormais, Drohn prend 5 glandes d'éclair, une {item:4897} et un {item:4896} contre 50, aussi souvent que vous le voulez. Les lézards-tonnerre {npc:3238} (une glande environ une victime sur deux), les Grands faucons-tonnerre et les kodos au sud du {area:378} en laissent. Rassemblez plusieurs lots avant de retourner à {area:392}.",
	-- {item:4898} Lightning Gland
	-- plural, as words: Stormhides = {npc:3238} Stormhide
	["{item:4898}, from Stormhides"] = "{item:4898}, sur les Orageux",
	-- {item:4897} Thunderhawk Saliva Gland
	-- plural, as words: Greater Thunderhawks = {npc:3249} Greater Thunderhawk
	["{item:4897}, from Greater Thunderhawks"] = "{item:4897}, sur les Grands faucons-tonnerre",
	-- {item:4896} Kodo Liver
	["{item:4896}, from the kodos"] = "{item:4896}, sur les kodos",

	-- Step 43: Rashona Straglash: A Donation of Wool
	-- {npc:14726} Rashona Straglash · {item:14047} Runecloth · {quest:7832} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14726} offers the {item:14047} donation, and {quest:7832} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "À partir d'ici, ce sont les étoffes. La laine, la soie et le tisse-mage doivent tous être rendus avant que {npc:14726} propose le don d'{item:14047}, et {quest:7832} demande le don d'{item:14047}. Achetez les étoffes à l'hôtel des ventes, ou farmez-les : les humanoïdes en laissent, la laine du niveau 15 à 25, la soie de 25 à 40, le tisse-mage de 40 à 50, l'{item:14047} à partir de 50. Au niveau 60, farmez des monstres de niveau 52 ou plus : les plus bas sont gris.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592} : les furbolgs Crin-de-Chardon en laissent environ une fois sur quatre",

	-- Step 44: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Soie : le Syndicat à {area:287} et en Alterac en laisse environ une fois sur trois, ou achetez-la.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306} : le Syndicat",

	-- Step 45: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Tisse-mage : les satyres Jadefeu du sud de {zone:1448} et les ogres Cognedune de {zone:1446} en laissent environ une fois sur trois, ou achetez-le.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338} : les satyres Jadefeu",

	-- Step 46: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047} : la Croisade écarlate à {area:2266}, dans les {zone:1423}, les ogres Gordok devant {area:2577}, à {zone:1444}, et les camps du crépuscule de {zone:1451} en laissent environ une fois sur trois. L'hôtel des ventes est plus rapide si vous avez de l'or.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047} : la Croisade écarlate devant {area:2266}",

	-- Step 47: Bloodvenom Post: Wild Guardians
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring · {zone:1448} Felwood
	["These quests are level 56 to 59, so they pay in full at 60. {npc:10306} stands at {area:1997}; the owlbeasts live in {zone:1452}, through the Timbermaw tunnel north of {zone:1448}."] = "Ces quêtes sont de niveau 56 à 59 et rapportent donc en entier au niveau 60. {npc:10306} se tient au {area:1997} ; les chouettards vivent à {zone:1452}, en passant par le tunnel des Grumegueules au nord de {zone:1448}.",

	-- Step 48: Winterspring: owlbeasts
	-- {zone:1452} Winterspring
	["{zone:1452}: owlbeasts"] = "{zone:1452} : chouettards",
	-- {area:2255} Everlook
	-- plural, as words: Raging Owlbeasts = {npc:7451} Raging Owlbeast · Ragged Owlbeasts = {npc:7450} Ragged Owlbeast
	["Raging Owlbeasts north-west of {area:2255}, Ragged Owlbeasts further west."] = "Les Chouettards enragés au nord-ouest de {area:2255}, les Chouettards éreintés plus à l'ouest.",

	-- Step 49: Bloodvenom Post: hand in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in"] = "{area:1997} : rendez les quêtes",

	-- Step 50: Winterspring: Moontouched Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["{zone:1452}: Moontouched Owlbeasts"] = "{zone:1452} : Chouettards lunaires",
	-- {area:2255} Everlook
	-- plural, as words: Moontouched Owlbeasts = {npc:7453} Moontouched Owlbeast
	["Moontouched Owlbeasts north of {area:2255} and south of it."] = "Les Chouettards lunaires au nord de {area:2255} et au sud.",

	-- Step 51: Bloodvenom Post: hand in again
	-- {area:1997} Bloodvenom Post
	["{area:1997}: hand in again"] = "{area:1997} : rendez de nouveau la quête",

	-- Step 52: Winterspring: Berserk Owlbeasts
	-- {zone:1452} Winterspring
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["{zone:1452}: Berserk Owlbeasts"] = "{zone:1452} : Chouettards berserks",
	-- {area:2255} Everlook · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets
	-- plural, as words: Berserk Owlbeasts = {npc:7454} Berserk Owlbeast
	["Most Berserk Owlbeasts are north of {area:2255}. A {item:12558} may drop from the owlbeasts now: use it to start {quest:4882}."] = "La plupart des Chouettards berserks sont au nord de {area:2255}. Un {item:12558} peut maintenant tomber des chouettards : utilisez-le pour lancer {quest:4882}.",

	-- Step 53: Bloodvenom Post: last hand-in
	-- {area:1997} Bloodvenom Post
	["{area:1997}: last hand-in"] = "{area:1997} : dernière remise",
	-- {quest:4882} Guarding Secrets · {zone:1456} Thunder Bluff · {npc:5770} Nara Wildmane · {area:1639} Elder Rise
	["{quest:4882}, +100 {zone:1456}: to {npc:5770} on {area:1639} in {zone:1456}"] = "{quest:4882}, +100 {zone:1456} : à {npc:5770}, sur la {area:1639} aux {zone:1456}",
	-- {quest:4721} Wild Guardians · {faction:76} Orgrimmar
	["{quest:4721}: 300 {faction:76} reputation."] = "{quest:4721} : 300 de réputation auprès d'{faction:76}.",

	-- Step 54: Belgrom Rockmaul: Betrayed
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor · {object:173084} Hall of the Brave (no name in this language: may be words) · {quest:3504} Betrayed
	["{npc:4485} stands in the {object:172958} outside the {object:173084}. The first two {quest:3504} quests are level 53 and pay in full at 60 too, as every quest does in Forever."] = "",

	-- Step 55: Valormok
	-- {area:1237} Valormok · {zone:1447} Azshara · {npc:8576} Ag'tor Bloodfist
	["Fly to {area:1237} in western {zone:1447}. {npc:8576} sends you north-east to the blood elf camp on the bluffs of the northern peninsula."] = "Volez jusqu'à {area:1237}, dans l'ouest d'{zone:1447}. {npc:8576} vous envoie au nord-est vers le camp des elfes de sang, sur les falaises de la péninsule nord.",

	-- Step 56: Magus Rimtori's camp
	-- {npc:8578} Magus Rimtori
	["{npc:8578}'s camp"] = "Le camp de {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning · {npc:8578} Magus Rimtori
	["Kill the Reclaimers and Surveyors, then walk up to the book inside the ring of stone pillars. Read the {object:151286} there to start the next quest: break the crystals around the circle, kill the guard that comes, then {npc:8578}."] = "Tuez les Récupérateurs et les Arpenteurs, puis allez jusqu'au livre au milieu du cercle de piliers de pierre. Lisez-y le {object:151286} pour lancer la quête suivante : brisez les cristaux autour du cercle, tuez le garde qui arrive, puis {npc:8578}.",
	-- {npc:8578} Magus Rimtori
	["Find {npc:8578}'s camp"] = "Trouvez le camp de {npc:8578}",
	-- {object:151286} Kaldorei Tome of Summoning
	["the {object:151286}"] = "le {object:151286}",

	-- Step 57: Valormok and Orgrimmar
	-- {area:1237} Valormok · {faction:76} Orgrimmar
	["{area:1237} and {faction:76}"] = "{area:1237} et {faction:76}",
	-- {npc:4485} Belgrom Rockmaul · {faction:76} Orgrimmar
	["{npc:4485}, in {faction:76}"] = "{npc:4485}, à {faction:76}",
	-- {quest:3506} Betrayed · {faction:76} Orgrimmar
	["{quest:3506}: 300 {faction:76} reputation at 60."] = "{quest:3506} : 300 de réputation auprès d'{faction:76} au niveau 60.",

	-- Step 58: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "Le mont Rochenoire, en groupe",
	-- {area:340} Kargath · {zone:1418} Badlands · {faction:76} Orgrimmar · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire · {quest:4724} The Pack Mistress · {item:12652} Bijou's Reconnaissance Report · {quest:4903} Warlord's Command · {npc:3144} Eitrigg
	["{area:340} in the {zone:1418} hands out {faction:76} quests for {area:1584} and {area:1583}, all level 58 to 60 and paid in full: Precarious Predicament and Operation: Death to Angerforge (150 each), {quest:4724} and {item:12652} (100 each), {quest:4903} (150), {npc:3144}'s Wisdom (100) and For The Horde! (Rend's head, 200 to every Horde city). These are dungeon quests: take them when your group goes."] = "{area:340}, dans les {zone:1418}, donne des quêtes d'{faction:76} pour les {area:1584} et le {area:1583}, toutes de niveau 58 à 60 et payées en entier : Situation précaire et Opération : Mort à Forgehargne (150 chacune), {quest:4724} et le {item:12652} (100 chacun), {quest:4903} (150), Sagesse d'{npc:3144} (100) et Pour la Horde ! (la tête de Rend, 200 auprès de chaque ville de la Horde). Ce sont des quêtes de donjon : prenez-les quand votre groupe y va.",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, +150, a group of five"] = "{npc:9077} : {quest:4903}, +150, un groupe de cinq",
	-- {npc:9081} Galamav the Marksman · {quest:4724} The Pack Mistress
	["{npc:9081}: {quest:4724}, +100, a group of five"] = "{npc:9081} : {quest:4724}, +100, un groupe de cinq",

	-- Step 59: Additional Runecloth to Honored
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Honored"] = "{quest:7832} : Honoré",
	-- {quest:7832} Additional Runecloth · {item:14047} Runecloth
	["{quest:7832}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (an orc starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne starts at Neutral 2,000 and first needs 20 hand-ins, 400 {item:14047}, to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7832} : 20 {item:14047} contre 50 de réputation, aussi souvent que vous le voulez. D'Amical à Honoré, il faut 6 000 : 120 remises, 2 400 {item:14047}, moins ce que les quêtes vous ont donné (un orc commence à Amical 1 000 : 100 remises ; un Mort-vivant ou un Éolide commence à Neutre 2 000 et a d'abord besoin de 20 remises, 400 {item:14047}, pour atteindre Amical). Rendez chaque lot de 20 que vous portez, l'un après l'autre.",

	-- Step 60: Additional Runecloth to Revered
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Revered"] = "{quest:7832} : Révéré",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "D'Honoré à Révéré, il faut 12 000 : 240 remises, 4 800 {item:14047}. Le prix d'une pile à l'hôtel des ventes décide s'il vaut mieux farmer ou acheter.",

	-- Step 61: Additional Runecloth to Exalted
	-- {quest:7832} Additional Runecloth
	["{quest:7832} to Exalted"] = "{quest:7832} : Exalté",
	-- {item:14047} Runecloth · {faction:76} Orgrimmar · {npc:3362} Ogunaro Wolfrunner · {object:172958} Valley of Honor
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. Raid heads pay too: The Lord of Blackrock (Nefarian) 200 to every Horde city and Victory for the Horde (Onyxia) 400 to {faction:76}. At Exalted, {npc:3362} in the {object:172958} sells the wolves to every Horde race: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "De Révéré à Exalté, il faut 21 000 : 420 remises, 8 400 {item:14047}. Les têtes de raid rapportent aussi : Le seigneur de Blackrock (Nefarian) 200 auprès de chaque ville de la Horde et Victoire pour la Horde ! (Onyxia) 400 auprès d'{faction:76}. À Exalté, {npc:3362}, dans la {object:172958}, vend les loups à toutes les races de la Horde : 20 po pour un loup au niveau 40, 200 po pour un loup rapide au niveau 60 (prix de Forever) ; dans Classic, les autres races devaient être Exalté pour les acheter.",
	-- {npc:3362} Ogunaro Wolfrunner
	["{npc:3362}: the wolves"] = "{npc:3362} : les loups",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Around the {area:380}"] = "Autour de {area:380}",
	-- ["Bloodtalon Matriarch Eggs"] = "Œufs de la matriarche griffesang",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et les Ombremages (niveau 58-60) en laissent tomber ici ; chaque mort du Fléau ici compte aussi pour {object:92525} (voir ce guide). L'hôtel des ventes fonctionne aussi.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en laissent tomber ici. L'hôtel des ventes fonctionne aussi.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The {area:363} is the best of them: about 1,400 {faction:76} and 1,400 Darkspear reputation in 25 minutes (about 280 each at a fifth). {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. La {area:363} est la meilleure : environ 1 400 de réputation auprès d'{faction:76} et 1 400 Darkspear en 25 minutes (environ 280 chacune à un cinquième). {npc:3143} attend dans la Tanière, la grande hutte ; {npc:10176} se tient devant.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:362} and north {zone:1411}: about 1,800 {faction:76} and 1,650 Darkspear reputation in 80 minutes (360 and 330 at a fifth). {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. {area:362} et le nord de {zone:1411} : environ 1 800 de réputation auprès d'{faction:76} et 1 650 Darkspear en 80 minutes (360 et 330 à un cinquième). {npc:3142} et {npc:3139} se tiennent au milieu de la ville, {npc:3191} près de la caserne, {npc:3147} et {npc:266940} aux abords.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:367} and the {area:368}: about 700 {faction:76} and 650 Darkspear reputation in 25 minutes (140 and 130 at a fifth). {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. {area:367} et les {area:368} : environ 700 de réputation auprès d'{faction:76} et 650 Darkspear en 25 minutes (140 et 130 à un cinquième). {npc:3188} et {npc:3304} se tiennent près des huttes, {npc:3194} près de l'eau, {npc:7953} au sud du village.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:380}: about 1,500 {faction:76} reputation in 70 minutes (300 at a fifth), {faction:76}'s only. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} and {npc:267310} stand in the town, {npc:3432} by the inn."] = "Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. {area:380} : environ 1 500 de réputation auprès d'{faction:76} en 70 minutes (300 à un cinquième), pour {faction:76} seulement. {npc:3338}, {npc:3464}, {npc:3429}, {npc:3449} et {npc:267310} se tiennent dans la ville, {npc:3432} près de l'auberge.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {quest:5726}: 400 {faction:76} reputation in 20 minutes (80 at a fifth), with a run through {area:2437} that a level 60 clears alone."] = "Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. {quest:5726} : 400 de réputation auprès d'{faction:76} en 20 minutes (80 à un cinquième), avec un passage dans le {area:2437} qu'un niveau 60 nettoie seul.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip this. {quest:819} lies on the ground at one of several spots in the central and northern {zone:1413}, most of them by the roads around the {area:380}; once someone takes it, it turns up at another. {npc:3292} in {area:392} pays 250 {faction:76} reputation for the keg and its first filling, then 50 for every filling after, as often as you like (10 at a fifth)."] = "Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ceci. Le {quest:819} est posé au sol à l'un des nombreux endroits du centre et du nord des {zone:1413}, la plupart près des routes autour de {area:380} ; une fois que quelqu'un l'a pris, il réapparaît ailleurs. Le {npc:3292}, à {area:392}, rapporte 250 de réputation auprès d'{faction:76} pour le tonneau et son premier remplissage, puis 50 pour chaque remplissage suivant, aussi souvent que vous le voulez (10 à un cinquième).",
	-- ["Keep handing in {quest:7832} until {faction:76} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7832} jusqu'à être exalté auprès de {faction:76}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) en {zone:1423}, ou l'hôtel des ventes.",
	-- ["Keep handing in {quest:7832}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7832}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) en {zone:1423}, ou l'hôtel des ventes.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Les centaures kolkar (niveau 30-33) en laissent tomber ici. L'hôtel des ventes fonctionne aussi.",
	-- ["Level 56-60 quests and {item:14047} to Exalted, with the old {zone:1411} quests as a fast extra if they still pay in full."] = "Quêtes de niveau 56-60 et {item:14047} jusqu'à Exalté, avec les anciennes quêtes de {zone:1411} en complément rapide si elles rapportent encore en entier.",
	-- ["Savannah Prowlers lie west and north of the {area:380}. {quest:876} leads the Witchwing harpies in the far north-west. Then {npc:3338} gives you the {item:10327}: blow it beside the kodo bones at {object:147524}, north of the town, and kill the white lion."] = "Les Rôdeurs des savanes se tiennent à l'ouest et au nord de {area:380}. {quest:876} dirige les harpies Ensorçaile loin au nord-ouest. Ensuite, {npc:3338} vous donne la {item:10327} : sonnez-la près des os de kodo de l'antre d'Echeyakee, au nord de la ville, et tuez le lion blanc.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Les Massacreurs de la KapitalRisk de {area:381} (niveau 16-17) en laissent tomber ici. L'hôtel des ventes fonctionne aussi.",
	-- ["{faction:76} reputation comes from quests and cloth. {npc:14726}, the cloth quartermaster, stands in the Drag beside the cloth and leather armor shop. She takes four one-time donations of 60 cloth (150 each) and then {quest:7832}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:76} also gives a quarter as much to {zone:1456}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:76}'s quests within 5 levels of them: {zone:1411} at 5 to 12, the {area:380} at 12 to 20, {npc:4949}'s {quest:5726} at 12 to 16. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Orgrimmar's merchants sell to you for 10% less (the Classic rule), the wolf vendor included; at Exalted other races can buy the wolves: 20 gold for a level 40 wolf, 200 gold for a swift wolf at level 60, once you have mount training. {faction:76} has no tabard or other reward."] = "La réputation auprès d'{faction:76} vient des quêtes et des étoffes. {npc:14726}, l'intendante des étoffes, se tient dans la Herse, à côté de la boutique d'armures en tissu et en cuir. Elle prend quatre dons uniques de 60 étoffes (150 chacun), puis {quest:7832}, 20 {item:14047} contre 50, aussi souvent que vous le voulez. Chaque point gagné auprès d'{faction:76} en donne aussi un quart aux {zone:1456}, à {zone:1458} et aux Trolls Darkspear. Pendant que vous montez de niveau, faites les quêtes d'{faction:76} à moins de 5 niveaux d'écart : {zone:1411} de 5 à 12, {area:380} de 12 à 20, {quest:5726} de {npc:4949} de 12 à 16. L'atout Diplomate de l'Héritage ajoute jusqu'à 10 %. Récompenses : à Honoré, les marchands d'Orgrimmar vous font 10 % de remise (la règle de Classic), le vendeur de loups compris ; à Exalté, les autres races peuvent acheter les loups : 20 po pour un loup au niveau 40, 200 po pour un loup rapide au niveau 60, une fois la monte apprise. {faction:76} n'a ni tabard ni autre récompense.",
	-- ["{npc:14726} takes cloth for {faction:76} in {faction:76}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7832} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14726} prend les étoffes pour {faction:76} à {faction:76}. Les premiers dons d'Etoffe de laine, d'Etoffe de soie, d'Etoffe de tisse-mage et de {item:14047} (60 étoffes chacun) ne se font qu'une fois et donnent le plus de réputation par étoffe ; ensuite, {quest:7832} se répète jusqu'à Exalté. Être exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14726}: {item:14047} delivered"] = "{npc:14726} : {item:14047} livrée",
	-- ["{npc:4485} stands in the {object:172958} outside the {object:173084}. The first two {quest:3504} quests are level 53 and pay a little less at 60 (in Classic 30 and 45); the last two pay in full."] = "{npc:4485} se tient dans la {object:172958}, devant le Hall des Braves. Les deux premières quêtes {quest:3504} sont de niveau 53 et rapportent un peu moins au niveau 60 (dans Classic, 30 et 45) ; les deux dernières rapportent en entier.",
	-- ["{quest:7832} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7832} prend 20 {item:14047} par remise et se répète autant que vous voulez. Apportez l'{item:14047} par multiples de 20 et rendez tout d'un coup, une remise après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) en {zone:1423}, ou l'hôtel des ventes.",
}
