-- French (frFR): the guide forever/reputation/darkspear-trolls (forever/reputation/darkspear-trolls.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkspear Trolls Reputation"] = "Réputation : Trolls Darkspear",
	-- {item:14047} Runecloth · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["{item:14047} to Exalted, with the old {zone:1411} quests as a fast extra that pays {zone:1454} too."] = "",
	-- {faction:530} Darkspear Trolls
	["Exalted with the {faction:530}"] = "Exalté auprès des {faction:530}",

	-- Step 1: Vehena: how it works
	-- {npc:14727} Vehena
	["{npc:14727}: how it works"] = "{npc:14727} : comment ça marche",
	-- {npc:14727} Vehena · {zone:1454} Orgrimmar · {object:172961} Valley of Spirits · {quest:7837} Additional Runecloth · {item:14047} Runecloth · {faction:530} Darkspear Trolls · {zone:1456} Thunder Bluff · {zone:1458} Undercity · {zone:1411} Durotar · {area:414} Zoram Strand · {zone:1440} Ashenvale · {object:3202} Grom'gol (no name in this language: may be words)
	["Darkspear reputation comes from quests and cloth. {npc:14727}, the Darkspear cloth quartermaster, stands in {zone:1454}'s {object:172961}. She takes four one-time donations of 60 cloth (150 each) and then {quest:7837}, 20 {item:14047} for 50, as often as you like. Every point you earn with the {faction:530} also gives a quarter as much to {zone:1454}, {zone:1456} and the {zone:1458}. While you level, do the Darkspear quests within 5 levels of them: {zone:1411} at 5 to 12, {area:414} in {zone:1440} at 19 to 27, {object:3202} in Stranglethorn at 34 to 46. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored the Darkspear merchants sell to you for 10% less (the Classic rule), the raptor vendor included; at Exalted other races can buy the raptors: 20 gold for a level 40 raptor, 200 gold for a swift raptor at level 60, once you have mount training. The {faction:530} have no tabard or other reward."] = "La réputation Darkspear vient des quêtes et des étoffes. {npc:14727}, l'intendante des étoffes Darkspear, se tient dans la {object:172961} d'{zone:1454}. Elle prend quatre dons uniques de 60 étoffes (150 chacun), puis {quest:7837}, 20 {item:14047} contre 50, aussi souvent que vous le voulez. Chaque point gagné auprès des {faction:530} en donne aussi un quart à {zone:1454}, aux {zone:1456} et à {zone:1458}. Pendant que vous montez de niveau, faites les quêtes Darkspear à moins de 5 niveaux d'écart : {zone:1411} de 5 à 12, {area:414} dans {zone:1440} de 19 à 27, Grom'gol à Strangleronce de 34 à 46. L'atout Diplomate de l'Héritage ajoute jusqu'à 10 %. Récompenses : à Honoré, les marchands Darkspear vous font 10 % de remise (la règle de Classic), le vendeur de raptors compris ; à Exalté, les autres races peuvent acheter les raptors : 20 po pour un raptor au niveau 40, 200 po pour un raptor rapide au niveau 60, une fois la monte apprise. Les {faction:530} n'ont ni tabard ni autre récompense.",

	-- Step 2: Valley of Trials (optional hub)
	-- {area:363} Valley of Trials
	["{area:363} (optional hub)"] = "{area:363} (étape facultative)",
	-- {area:363} Valley of Trials · {zone:1454} Orgrimmar · {npc:3143} Gornek · {npc:10176} Kaltunk
	["Forever pays these old quests in full at any level. The {area:363} is the best of them: about 1,400 {zone:1454} and 1,400 Darkspear reputation in 25 minutes. {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "",
	-- {npc:3144} Eitrigg · {zone:1454} Orgrimmar · {quest:787} The New Horde
	["{npc:3144}, in {zone:1454}: {quest:787}, +50"] = "{npc:3144}, à {zone:1454} : {quest:787}, +50",
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
	-- {area:367} Sen'jin Village · {area:368} Echo Isles · {zone:1454} Orgrimmar · {npc:3188} Master Gadrin · {npc:3304} Master Vornal · {npc:3194} Vel'rin Fang · {npc:7953} Xar'Ti
	["Forever pays these old quests in full at any level. {area:367} and the {area:368}: about 625 {zone:1454} and 650 Darkspear reputation in 25 minutes. {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "",
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
	-- {quest:97223} Bloodtalon Matriarch
	["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village."] = "",

	-- Step 12: Sen'jin Village: hand in
	-- {area:367} Sen'jin Village
	["{area:367}: hand in"] = "{area:367} : rendez les quêtes",

	-- Step 13: Razor Hill: Sen'jin hand-ins
	-- {area:362} Razor Hill
	["{area:362}: Sen'jin hand-ins"] = "{area:362} : quêtes de Sen'jin à rendre",

	-- Step 14: Razor Hill (optional hub)
	-- {area:362} Razor Hill
	["{area:362} (optional hub)"] = "{area:362} (étape facultative)",
	-- {area:362} Razor Hill · {zone:1411} Durotar · {zone:1454} Orgrimmar · {npc:3142} Orgnil Soulscar · {npc:3139} Gar'Thok · {npc:3191} Cook Torka · {npc:3147} Furl Scornbrow
	["Forever pays these old quests in full at any level. {area:362} and north {zone:1411}: about 1,650 {zone:1454} and 1,650 Darkspear reputation in 80 minutes. {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and Turroc at the edges."] = "",
	-- {quest:806} Dark Storms · {quest:823} Report to Orgnil
	["{quest:806}, +100: needs {quest:823} from Sen'jin"] = "{quest:806}, +100 : demande {quest:823}, de Sen'jin",

	-- Step 15: Tiragarde Keep
	-- {area:362} Razor Hill · {npc:3192} Lieutenant Benedict · {object:3239} Benedict's Chest · {item:4881} Aged Envelope · {quest:830} The Admiral's Orders · {item:4870} Canvas Scraps
	["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}."] = "",

	-- Step 16: Razormane Grounds and the Echo Isles
	-- {area:816} Razormane Grounds · {area:368} Echo Isles
	["{area:816} and the {area:368}"] = "{area:816} et les {area:368}",
	-- {area:362} Razor Hill · {area:368} Echo Isles · {object:3240} Taillasher Eggs
	["The Razormane camps are south-west and west of {area:362}. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "",

	-- Step 17: Razor Hill: hand in
	-- {area:362} Razor Hill
	["{area:362}: hand in"] = "{area:362} : rendez les quêtes",
	-- {quest:830} The Admiral's Orders · {npc:3230} Nazgrel · {zone:1454} Orgrimmar
	["{quest:830}, +100: to {npc:3230} in {zone:1454}"] = "{quest:830}, +100 : à {npc:3230}, à {zone:1454}",

	-- Step 18: The wreck
	["The wreck"] = "L'épave",
	-- {area:372} Tiragarde Keep
	["The wrecked ship lies in the shallows east of {area:372}. Open the Gnomish Toolboxes."] = "Le navire échoué est dans les hauts-fonds à l'est du {area:372}. Ouvrez les boîtes à outils gnomes.",
	-- {npc:3139} Gar'Thok · {area:362} Razor Hill
	["back at {npc:3139} in {area:362}"] = "de retour auprès de {npc:3139}, à {area:362}",

	-- Step 19: North Durotar
	-- {zone:1411} Durotar
	["North {zone:1411}"] = "Nord de {zone:1411}",
	-- {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3193} Misha Tor'kren
	["{npc:3293} stands on the road north of {area:362}, {npc:3193} at her farm west of it."] = "{npc:3293} se tient sur la route au nord de {area:362}, {npc:3193} à sa ferme, à l'ouest.",

	-- Step 20: Thunder Ridge and Razorwind Canyon
	-- {area:369} Thunder Ridge · {area:410} Razorwind Canyon
	["{area:369} and {area:410}"] = "{area:369} et {area:410}",
	-- {npc:3203} Fizzle Darkstorm · {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {area:410} Razorwind Canyon · {area:362} Razor Hill · {item:4891} Kron's Amulet
	["{npc:3203} keeps a Burning Blade camp in {area:369}, south of {zone:1454}, among the thunder lizards. The supply sacks lie in {area:410}, north of {area:362}. {item:4891} drops from the crocolisks along the river to the west, about one in ten."] = "{npc:3203} tient un camp de la Lame ardente à {area:369}, au sud d'{zone:1454}, parmi les lézards-tonnerre. Les sacs de ravitaillement sont dans le {area:410}, au nord de {area:362}. L'{item:4891} tombe des crocilisques le long de la rivière à l'ouest, environ une fois sur dix.",

	-- Step 21: Rezlak and Misha
	-- {npc:3293} Rezlak
	["{npc:3293} and Misha"] = "{npc:3293} et Misha",
	-- {npc:3118} Dustwind Storm Witch · {item:277661} Dull Storm Orb · {quest:97281} A Simmering Storm · {npc:3293} Rezlak · {quest:97282} Stormy Potential
	["A {npc:3118} may drop a {item:277661}: use it to start {quest:97281}. Once you hand that in, {npc:3293} offers {quest:97282}."] = "",
	-- {npc:3117} Dustwind Savage · {area:370} Drygulch Ravine
	["{npc:3117}, in {area:370}"] = "{npc:3117}, dans le {area:370}",

	-- Step 22: Stormy Potential
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Charged Thunder Lizard Organs = {item:277665} Charged Thunder Lizard Organ
	["The Charged Thunder Lizard Organs come from the thunder lizards on {area:369}, just west of {npc:3293}."] = "",

	-- Step 24: Skull Rock
	-- {quest:828} Margoz · {quest:827} Skull Rock · {zone:1454} Orgrimmar
	["{quest:828} camps outside {quest:827}, the cave just east of {zone:1454}."] = "{quest:828} campe devant {quest:827}, la grotte juste à l'est d'{zone:1454}.",

	-- Step 25: Orgrimmar: Neeru Fireblade and Nazgrel
	-- {zone:1454} Orgrimmar · {npc:3216} Neeru Fireblade · {npc:3230} Nazgrel
	["{zone:1454}: {npc:3216} and {npc:3230}"] = "{zone:1454} : {npc:3216} et {npc:3230}",
	-- {quest:829} Neeru Fireblade · {object:172960} Cleft of Shadow · {npc:3230} Nazgrel
	["{quest:829} is in the {object:172960}; {npc:3230} in Grommash Hold beside Thrall."] = "{quest:829} est dans la {object:172960} ; {npc:3230} dans le fort Grommash, à côté de Thrall.",

	-- Step 26: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1413} Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {area:379} Far Watch Post
	["Run out of {zone:1454}'s west gate and over the bridge into the {zone:1413}. {npc:3337} and {quest:809} stand at {area:379}."] = "Sortez d'{zone:1454} par la porte ouest et traversez le pont vers les {zone:1413}. {npc:3337} et {quest:809} se tiennent au {area:379}.",
	-- {quest:842} Crossroads Conscription · {npc:3338} Sergra Darkthorn
	["{quest:842}, +100: to {npc:3338}"] = "{quest:842}, +100 : à {npc:3338}",

	-- Step 28: Vehena: A Donation of Wool
	-- {npc:14727} Vehena · {item:14047} Runecloth · {quest:7837} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14727} offers the {item:14047} donation, and {quest:7837} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "À partir d'ici, ce sont les étoffes. La laine, la soie et le tisse-mage doivent tous être rendus avant que {npc:14727} propose le don d'{item:14047}, et {quest:7837} demande le don d'{item:14047}. Achetez les étoffes à l'hôtel des ventes, ou farmez-les : les humanoïdes en laissent, la laine du niveau 15 à 25, la soie de 25 à 40, le tisse-mage de 40 à 50, l'{item:14047} à partir de 50. Au niveau 60, farmez des monstres de niveau 52 ou plus : les plus bas sont gris.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592} : les furbolgs Crin-de-Chardon en laissent environ une fois sur quatre",

	-- Step 29: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Soie : le Syndicat à {area:287} et en Alterac en laisse environ une fois sur trois, ou achetez-la.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306} : le Syndicat",

	-- Step 30: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Tisse-mage : les satyres Jadefeu du sud de {zone:1448} et les ogres Cognedune de {zone:1446} en laissent environ une fois sur trois, ou achetez-le.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338} : les satyres Jadefeu",

	-- Step 31: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047} : la Croisade écarlate à {area:2266}, dans les {zone:1423}, les ogres Gordok devant {area:2577}, à {zone:1444}, et les camps du crépuscule de {zone:1451} en laissent environ une fois sur trois. L'hôtel des ventes est plus rapide si vous avez de l'or.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047} : la Croisade écarlate devant {area:2266}",

	-- Step 32: Everlook: A Little Luck
	-- {quest:969} Luck Be With You · {npc:11755} Harlo Wigglesworth · {area:2255} Everlook · {npc:10307} Witch Doctor Mau'ari · {item:12334} Frostmaul Shards · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant
	["{quest:969} is level 60, so it pays in full. {npc:11755} in {area:2255} sends you to {npc:10307}, who stands in the same town. The {item:12334} lie on the ground in {area:2249}, the canyon at the south end of {zone:1452}, and the Frostmaul Giants there drop them too (about one in five). The giants are elite level 59 and 60 and stand close together: pick the shards at the edges, pull one giant at a time, or bring a friend."] = "{quest:969} est de niveau 60, elle rapporte donc en entier. {npc:11755}, à {area:2255}, vous envoie auprès du {npc:10307}, qui se tient dans la même ville. Les {item:12334} sont posés au sol dans {area:2249}, le canyon au sud de {zone:1452}, et les Géants Cognegivre qui s'y trouvent en laissent aussi (environ un sur cinq). Les géants sont des élites de niveau 59 et 60 et se tiennent proches les uns des autres : ramassez les éclats sur les bords, attirez un géant à la fois, ou venez avec un ami.",

	-- Step 33: Blackrock Mountain, with a group
	["Blackrock Mountain, with a group"] = "Le mont Rochenoire, en groupe",
	-- {area:1583} Blackrock Spire · {faction:530} Darkspear Trolls · {area:340} Kargath · {zone:1418} Badlands · {quest:4903} Warlord's Command · {npc:3144} Eitrigg · {zone:1458} Undercity · {area:978} Zul'Farrak · {zone:1425} Hinterlands
	["For The Horde! (Rend's head, {area:1583}) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city, the {faction:530} included. {area:340} in the {zone:1418} starts the Rend chain: {quest:4903}, {npc:3144}'s Wisdom, then For The Horde!. Take them when your group goes. The Spider God chain of the {zone:1458} guide ({area:978} and the {zone:1425}) pays 225 Darkspear on the way."] = "",
	-- {npc:9077} Warlord Goretooth · {quest:4903} Warlord's Command
	["{npc:9077}: {quest:4903}, a group of five"] = "{npc:9077} : {quest:4903}, un groupe de cinq",

	-- Step 34: Additional Runecloth to Honored
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Honored"] = "{quest:7837} jusqu'à Honoré",
	-- {quest:7837} Additional Runecloth · {item:14047} Runecloth
	["{quest:7837}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a troll starts at Friendly 1,000: 100 hand-ins; an Undead or Skyborne at Neutral 2,000 first needs 20 more to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7837} : 20 {item:14047} contre 50 de réputation, aussi souvent que vous le voulez. D'Amical à Honoré, il faut 6 000 : 120 remises, 2 400 {item:14047}, moins ce que les quêtes vous ont donné (un troll commence à Amical 1 000 : 100 remises ; un Mort-vivant ou un Éolide à Neutre 2 000 a d'abord besoin de 20 de plus pour atteindre Amical). Rendez chaque lot de 20 que vous portez, l'un après l'autre.",

	-- Step 35: Additional Runecloth to Revered
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Revered"] = "{quest:7837} jusqu'à Révéré",
	-- {item:14047} Runecloth
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}. The Auction House price of a stack decides whether to farm or buy."] = "D'Honoré à Révéré, il faut 12 000 : 240 remises, 4 800 {item:14047}. Le prix d'une pile à l'hôtel des ventes décide s'il vaut mieux farmer ou acheter.",

	-- Step 36: Additional Runecloth to Exalted
	-- {quest:7837} Additional Runecloth
	["{quest:7837} to Exalted"] = "{quest:7837} jusqu'à Exalté",
	-- {item:14047} Runecloth · {npc:7952} Zjolnir · {area:367} Sen'jin Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. At Exalted, {npc:7952} in {area:367} sells the raptors to every Horde race: 20 gold for a level 40 raptor, 200 gold for a swift raptor at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "De Révéré à Exalté, il faut 21 000 : 420 remises, 8 400 {item:14047}. À Exalté, {npc:7952}, à {area:367}, vend les raptors à toutes les races de la Horde : 20 po pour un raptor au niveau 40, 200 po pour un raptor rapide au niveau 60 (prix de Forever) ; dans Classic, les autres races devaient être Exalté pour les acheter.",
	-- {npc:7952} Zjolnir
	["{npc:7952}: the raptors"] = "{npc:7952} : les raptors",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodtalon Matriarch Eggs"] = "Œufs de la matriarche griffesang",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Les Adeptes noirs et Ombremages (niveau 58-60) en lâchent ici ; chaque Fléau tué ici compte aussi pour l'{object:92525} (voir ce guide). L'hôtel des ventes fonctionne aussi.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Les ogres Cognedune (niveau 45-48) en lâchent ici. L'hôtel des ventes fonctionne aussi.",
	-- ["For The Horde! (Rend's head, {area:1583}) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city, the {faction:530} included. {area:340} in the {zone:1418} starts the Rend chain: {quest:4903}, {npc:3144}'s Wisdom, then For The Horde!. Take them when your group goes. The Spider God chain of the {zone:1458} guide ({area:978} and the {zone:1425}) pays 225 Darkspear on the way (a fifth at 60 in Classic)."] = "Pour la Horde ! (la tête de Rend, {area:1583}) et Le seigneur de Blackrock (la tête de Nefarian) rapportent 200 auprès de chaque ville de la Horde, {faction:530} compris. {area:340}, dans les {zone:1418}, lance la suite de Rend : {quest:4903}, Sagesse d'{npc:3144}, puis Pour la Horde !. Prenez-les quand votre groupe y va. La suite du Dieu araignée du guide de {zone:1458} ({area:978} et les {zone:1425}) rapporte 225 Darkspear en chemin (un cinquième au niveau 60 dans Classic).",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The {area:363} is the best of them: about 1,400 {zone:1454} and 1,400 Darkspear reputation in 25 minutes (about 280 each at a fifth). {npc:3143} waits in the Den, the big hut; {npc:10176} stands outside it."] = "Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. La {area:363} est la meilleure : environ 1 400 de réputation auprès d'{zone:1454} et 1 400 Darkspear en 25 minutes (environ 280 chacune à un cinquième). {npc:3143} attend dans la Tanière, la grande hutte ; {npc:10176} se tient devant.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:362} and north {zone:1411}: about 1,800 {zone:1454} and 1,650 Darkspear reputation in 80 minutes (360 and 330 at a fifth). {npc:3142} and {npc:3139} stand in the middle of the town, {npc:3191} by the barracks, {npc:3147} and {npc:266940} at the edges."] = "Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. {area:362} et le nord de {zone:1411} : environ 1 800 de réputation auprès d'{zone:1454} et 1 650 Darkspear en 80 minutes (360 et 330 à un cinquième). {npc:3142} et {npc:3139} se tiennent au milieu de la ville, {npc:3191} près de la caserne, {npc:3147} et {npc:266940} aux abords.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:367} and the {area:368}: about 700 {zone:1454} and 650 Darkspear reputation in 25 minutes (140 and 130 at a fifth). {npc:3188} and {npc:3304} stand by the huts, {npc:3194} near the water, {npc:7953} south of the village."] = "Dans Classic, les quêtes de 6 niveaux ou plus sous le vôtre rapportent moins (un cinquième au niveau 60) ; un retour de la bêta de Forever dit qu'elles rapportaient en entier. Votre première remise vous le montrera : si elle rapporte un cinquième, sautez ces étapes. {area:367} et les {area:368} : environ 700 de réputation auprès d'{zone:1454} et 650 Darkspear en 25 minutes (140 et 130 à un cinquième). {npc:3188} et {npc:3304} se tiennent près des huttes, {npc:3194} près de l'eau, {npc:7953} au sud du village.",
	-- ["Keep handing in {quest:7837} until {faction:530} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7837} jusqu'à être Exalté auprès de {faction:530}. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["Keep handing in {quest:7837}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continuez à rendre {quest:7837}, 20 {item:14047} à la fois. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Les centaures kolkar (niveau 30-33) en lâchent ici. L'hôtel des ventes fonctionne aussi.",
	-- ["Makrura and surf crawlers walk the beaches east and south of Sen'jin. The {quest:97223} is east of the village. The Ridgeshade spiders are along the road south of {area:362} and north-east of the Den."] = "Les makruras et les clampants de l'écume arpentent les plages à l'est et au sud de Sen'jin. {quest:97223} est à l'est du village. Les araignées Ridgeshade sont le long de la route au sud de {area:362} et au nord-est de la Tanière.",
	-- ["The Razormane camps are south-west and west of {area:362}; the Prickly Pear cacti grow among them. Then head to the {area:368} for the {object:3240}: each nest gives an egg every time."] = "Les camps Tranchecrin sont au sud-ouest et à l'ouest de {area:362} ; les figuiers de Barbarie poussent parmi eux. Puis allez aux {area:368} pour les {object:3240} : chaque nid donne un œuf à chaque fois.",
	-- ["The keep is south of {area:362} on the coast. {npc:3192} is in the keep's only building; his key opens {object:3239} on the roof, and the {item:4881} inside starts {quest:830}. The sailors and marines drop the {item:4870}; the {item:275713}, Battleaxe and Shield lie outside the keep."] = "Le donjon est au sud de {area:362}, sur la côte. Le {npc:3192} est dans l'unique bâtiment du donjon ; sa clé ouvre le {object:3239} sur le toit, et l'{item:4881} qu'il contient lance {quest:830}. Les marins et les fusiliers marins laissent les {item:4870} ; l'{item:275713}, la hache d'armes et le bouclier sont posés devant le donjon.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Les Massacreurs de la KapitalRisk de la {area:381} (niveau 16-17) en lâchent ici. L'hôtel des ventes fonctionne aussi.",
	-- ["{item:14047} to Exalted, with the old {zone:1411} quests as a fast extra that pays {zone:1454} too if they still pay in full."] = "L'{item:14047} jusqu'à Exalté, avec les anciennes quêtes de {zone:1411} en complément rapide, qui rapportent aussi auprès d'{zone:1454} si elles paient encore en entier.",
	-- ["{npc:14727} takes cloth for {faction:530} in the {object:172961}, {zone:1454}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7837} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14727} prend les étoffes pour {faction:530} dans la {object:172961}, à {zone:1454}. Les premiers dons d'étoffe de laine, de soie, de tisse-mage et d'{item:14047} (60 étoffes chacun) se font une fois et donnent le plus de réputation par étoffe ; ensuite, {quest:7837} se répète jusqu'à Exalté. Être Exalté auprès de la ville d'une autre race permet d'acheter les montures de cette race. L'atout Diplomate de l'Héritage de Forever augmente les gains de réputation.",
	-- ["{npc:14727}: {item:14047} delivered"] = "{npc:14727} : {item:14047} livrée",
	-- ["{quest:7837} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7837} prend 20 {item:14047} par remise et se répète à volonté. Apportez l'{item:14047} par multiples de 20 et rendez tout d'un coup, une remise après l'autre. {item:14047} : Adeptes noirs et Ombremages (niveau 58-60) dans les {zone:1423}, ou l'hôtel des ventes.",
}
