-- French (frFR): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:327} Faldir's Cove
	["For characters of 35 to 37. {area:327}, where the naga and the professor's water elementals are 38-40, is a group stop: skip it if you are alone."] = "Pour les personnages de niveau 35 à 37. {area:327}, où les nagas et les élémentaires d'eau du professeur sont de niveau 38-40, se fait en Groupe : passez-la si vous êtes seul.",

	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Prenez un vol pour {area:42}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maître de vol de {area:35}",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "{npc:5476} garde le carrefour à l'ouest du marais. {npc:217412} se tient un peu au nord de lui.\nIl se peut que {npc:217412} ne soit pas là sur Forever : si {npc:217412} ne propose pas {quest:93176}, passez-la.",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412} : trois bestioles à capturer en Arathi, en {zone:1443} et à Strangleronce",

	-- Step 4: The western swamp
	["The western swamp"] = "Le marais occidental",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Jeunes crocilisques, Tisseuses des pleurs et Jaguars du marécage parcourent tous le marais autour de la route.",

	-- Step 6: Father Tuttle
	-- {npc:255597} Father Tuttle · {area:657} Harborage
	["North-west of Watcher Biggs, {npc:255597} (level 34) waits by the road: lead him north to the {area:657}, on your way there. Stay close to him and clear what attacks him; if he falls, abandon the quest and go on."] = "Au nord-ouest du Guetteur Biggs, {npc:255597} (niveau 34) attend près de la route : escortez-le vers le nord jusqu'à {area:657}, sur votre chemin. Restez près de lui et éliminez ce qui l'attaque ; s'il meurt, abandonnez la quête et continuez.",

	-- Step 7: Harborage
	-- {area:657} Harborage · {npc:254775} Karana · {npc:254770} Pelluk · {npc:1776} Magtoor · {area:76} Fallow Sanctuary
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Follow the road north to the draenei of the {area:657}. {npc:254775} and {npc:254770} stand beside {npc:1776}: their Lost Ones are the ones you meet in the {area:76} anyway."] = "Suivez la route vers le nord jusqu'aux draeneï de {area:657}. {npc:254775} et {npc:254770} se tiennent à côté de {npc:1776} : leurs Égarés sont ceux que vous croisez de toute façon dans {area:76}.",
	-- {npc:1776} Magtoor · {npc:255597} Father Tuttle
	["{npc:1776}: {npc:255597}'s escort"] = "{npc:1776} : l'escorte de {npc:255597}",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {quest:1389} Draenethyst Crystals · {npc:254797} Lost One · {npc:254775} Karana · {npc:254770} Pelluk · {item:258530} Lucky Lure · {quest:1392} Noboru the Cudgel · {npc:1776} Magtoor
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["East along the road to the {area:76}. The {quest:1389} are the glowing blue crystals among the Lost Ones' tents: click them. Any {npc:254797} counts for {npc:254775}, and the Lost One Fishermen on the sanctuary's west side carry {npc:254770}'s {item:258530}. {quest:1392} walks a long path through the ruins; his cudgel starts a quest for {npc:1776}. Don't wait for him.\nCareful: Noboru is level 39, two over you here: fight him only with a friend or from level 38; otherwise let him pass."] = "À l'est par la route vers {area:76}. {quest:1389} sont les cristaux bleus luisants parmi les tentes des Égarés : cliquez dessus. N'importe quel {npc:254797} compte pour {npc:254775}, et les Pêcheurs égarés du côté ouest du sanctuaire portent l'{item:258530} de {npc:254770}. {quest:1392} parcourt un long chemin à travers les ruines ; son gourdin lance une quête pour {npc:1776}. Ne l'attendez pas.\nAttention : Noboru est de niveau 39, deux de plus que vous ici : ne l'affrontez qu'avec un ami ou à partir du niveau 38 ; sinon laissez-le passer.",
	-- {quest:1392} Noboru the Cudgel
	["from {quest:1392}: he walks a path through the ruins"] = "sur {quest:1392} : il parcourt un chemin à travers les ruines",
	-- {item:6071} Draenethyst Crystal
	["{item:6071}, the blue crystals by the tents"] = "{item:6071}, les cristaux bleus près des tentes",
	-- {item:258530} Lucky Lure · {npc:757} Lost One Fisherman
	["{item:258530}, from a {npc:757}"] = "{item:258530}, sur un {npc:757}",
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["Lost Ones: Hunters, Muckdwellers, Seers and Riftseekers all count"] = "Égarés : Chasseurs, Habitants de la fange, Voyants et Chercheurs de faille comptent tous",

	-- Step 9: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "Le coffre de la caravane détruite se trouve à l'extrémité nord de {area:76}, à côté de la cage de {npc:5391}.\nAttention : le camp est rempli d'Égarés de niveau 38 environ. Ils se tiennent en groupes liés de 2 ou 3, beaucoup lancent des sorts, et ils réapparaissent vite.",

	-- Step 10: Galen Goodward
	-- {npc:5391} Galen Goodward
	-- plural, as words: Lost One Riftseekers = {npc:762} Lost One Riftseeker · Lost Ones = {npc:254797} Lost One
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards. Careful: on the walk out the camp's Lost One Riftseekers (37-38) and their pets, with the Lost Ones around them, turn on {npc:5391}: clear the cage and the start of his path first, stay beside him and pull every attacker onto yourself. Many players lose him the first time; if he dies, abandon the quest and take it again at his cage."] = "{npc:5391} est enfermé dans une cage au nord du sanctuaire. Libérez-le et gardez-le en vie pendant la sortie ; son coffre vous attend ensuite au bord de la route. Attention : pendant la sortie, les Fouille-rivage Perdus du camp (37-38) et leurs familiers, avec les Perdus qui les entourent, s'en prennent à {npc:5391} : nettoyez d'abord la cage et le début de son trajet, restez à côté de lui et attirez chaque attaquant sur vous. Beaucoup de joueurs le perdent la première fois ; s'il meurt, abandonnez la quête et reprenez-la à sa cage.",

	-- Step 11: Harborage
	-- {npc:5391} Galen Goodward · {area:657} Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "À l'ouest par la route, du coffre de {npc:5391} jusqu'au {area:657}.",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "{npc:1776} : le gourdin de Noboru",
	-- {npc:1776} Magtoor · {quest:93464} The Visiting Mage · {npc:11863} Azore Aldamort · {zone:1443} Desolace
	["{npc:1776}: {quest:93464}, for {npc:11863} in {zone:1443}, on the {zone:1443} guide at the end of 30-40"] = "{npc:1776} : {quest:93464}, pour {npc:11863} en {zone:1443}, dans le Guide {zone:1443} à la fin des 30-40",

	-- Step 12: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "Redescendez la route vers le sud jusqu'à {npc:5476}, sur le chemin de la sortie ouest du marais.",

	-- Step 14: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Prenez un vol pour {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "Retournez vers l'ouest par le {zone:1430} jusqu'à {area:42}.",

	-- Step 15: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, route de {area:17203}",

	-- Step 16: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} attend dans la cave de {object:2164}, dans {object:2101}. Utilisez le {item:6913} sur le cercle d'invocation et vainquez la succube invoquée. Si vous avez pris {quest:65602}, donnez-lui aussi la {item:190309}, placez-la sur le même cercle et vainquez l'incube.",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "{npc:5677}, au cercle d'invocation",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, si vous l'avez prise",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, sur le même cercle",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} lie l'incube à vous",

	-- Step 17: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, Cathédrale de la Lumière",

	-- Step 19: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, la Bibliothèque royale du donjon",

	-- Step 20: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 21: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prenez un vol pour {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 22: Southshore
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside, if 30-40/01 didn't take it: the Syndicate camp is on the way to Arathi"] = "{npc:2276}, à l'intérieur, si le 30-40/01 ne l'a pas prise : le camp du Syndicat est sur la route d'Arathi",

	-- Step 23: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore · {npc:2276} Magistrate Henry Maleb
	["A {npc:2434} (37-38) lurks stealthed on the edge of {area:271}, and few players find him. Careful: he is a level or two over you; fight him only at full health, or leave him. His contract goes to {npc:2276}. Don't wait for him: the rest of this step doesn't need him."] = "Un {npc:2434} (37-38) rôde, camouflé, en bordure d'{area:271}, et peu de joueurs le trouvent. Attention : il a un ou deux niveaux de plus que vous ; affrontez-le seulement avec toute votre vie, ou laissez-le. Son contrat va à {npc:2276}. Ne l'attendez pas : le reste de cette étape n'a pas besoin de lui.",
	-- {npc:2434} Shadowy Assassin
	["{npc:2434}, if you spot him"] = "{npc:2434}, si vous le repérez",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}, à l'intérieur",

	-- Step 25: Alterac Mountains
	["Syndicate camp"] = "Camp du Syndicat",

	-- Step 26: Syndicate camp
	-- {area:271} Southshore · {area:272} Tarren Mill
	-- plural, as words: Syndicate Wizards = {npc:2319} Syndicate Wizard
	["North out of {area:271} to the Syndicate camp on the Alterac border, west of {area:272} (Horde): its Footpads and Thieves are the Syndicate Maleb wants, and the documents lie in the camp. Then back to the road and east to Arathi.\nCareful: a few Syndicate Wizards (34-35) stand among the tents and cast from range: pull them one at a time."] = "Au nord en sortant d'{area:271}, jusqu'au camp du Syndicat à la frontière d'Alterac, à l'ouest d'{area:272} (Horde) : ses Voleurs de grand chemin et Voleurs sont les membres du Syndicat que veut Maleb, et les documents se trouvent dans le camp. Puis revenez sur la route et allez vers l'est jusqu'à Arathi.\nAttention : quelques Sorciers du Syndicat (34-35) se tiennent parmi les tentes et lancent des sorts à distance : attirez-les un par un.",

	-- Step 28: Refuge Pointe
	-- {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["From the Syndicate camp, follow the road east over {area:1057} to {area:320}."] = "Depuis le camp du Syndicat, suivez la route vers l'est, par {area:1057}, jusqu'à {area:320}.",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "{npc:2700} : la supplique de {npc:1075}, de 01-hillsbrad-foothills",

	-- Step 29: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "Le Syndicat tient la ferme au nord-ouest du {area:320}.\nAttention : les Malandrins du Syndicat sont de niveau 30-31 et peuvent lancer Camouflage hors combat : ils sont souvent furtifs et difficiles à repérer.",

	-- Step 30: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s {item:213565}."] = "Des Charançons du foin rampent à l'extrémité nord de la ferme de {quest:681} : attrapez-en un avec l'outil du {item:213565} de {npc:217412}.",

	-- Step 31: Shards of Myzrael
	-- {quest:681} Northfold Manor · {area:333} Circle of East Binding · {area:314} Go'Shek Farm
	["East from {quest:681} across the north of the Highlands; the shards glitter on the hill by the {area:333}, north of {area:314}."] = "À l'est de {quest:681}, traversez le nord des Hautes-terres ; les éclats scintillent sur la colline près de {area:333}, au nord de {area:314}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Seulement si Gluggle vous a donné le pendentif à Strangleronce",

	-- Step 32: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "{area:318} : tuez-les au passage",
	-- {area:321} Hammerfall · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop the Motes of Myzrael, not Krazek's ore. Lesser Bloodstone Deposits need {skill:186} 75: mine four ore, buy them at the Auction House, or ask a miner friend. The ore goal is optional; continue with Myzrael if you cannot get it. Careful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Les kobolds Sèche-moustache creusent dans la gorge à l'est de {area:321} (Horde) ; contournez la ville par le nord. Ils lâchent les Poussières de Myzrael, pas le minerai de Krazek. Les Gisements de pierre de sang inférieure demandent {skill:186} 75 : minez quatre minerais, achetez-les à l'hôtel des ventes ou demandez à un ami mineur. L'objectif du minerai est facultatif ; continuez avec Myzrael si vous ne pouvez pas l'obtenir. Attention : chaque type de kobold s'enfuit chercher de l'aide quand sa vie est basse (les Kobolds à 30 %, les Géomètres et les Terrassiers à 15 %), ce qui peut en attirer d'autres.",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "{item:4435} sur {npc:2572}, {npc:2573} et {npc:2574}, à cet arrêt",

	-- Step 33: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Les éclats se trouvent au fond de {area:318}.",
	["Below ground"] = "Sous terre",

	-- Step 34: Iridescent Shards
	-- {quest:651} Stones of Binding · {object:2691} Stone of East Binding
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{quest:651} is a group quest at this level: three Cresting Exiles (38-39) guard the {object:2691} and attack together. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "{quest:651} est une Quête de groupe à ce niveau : trois Exilés grimpeurs (38-39) gardent la {object:2691} et attaquent ensemble. Grouper est conseillé, cherchez des joueurs avec qui la faire. Passez-la si vous êtes seul.",

	-- Step 35: Witherbark Village
	-- {area:318} Drywhisker Gorge · {area:314} Go'Shek Farm · {area:317} Witherbark Village
	["South from {area:318}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "Au sud de {area:318}, au-delà de {area:314}, jusqu'à {area:317} dans les collines : les Sorciers-docteurs se tiennent parmi les huttes et les Chasseurs des ombres gardent le fond de la vallée. Chaque troll peut laisser tomber une défense.",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "{item:5040} ; sous terre",

	-- Step 36: Quae
	-- {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["North-west out of the Witherbark valley; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "Sortez de la vallée des Witherbark par le nord-ouest ; {npc:2712} et {npc:2713} campent dans les collines juste au nord de {area:314}.",

	-- Step 37: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road from {area:314} west across the Highlands, as far as about 24,45, and back, with two guards: the arrow follows the road west until you meet him. Pull them off the road."] = "Le coursier parcourt la route depuis {area:314} vers l'ouest à travers les Hautes-terres, jusqu'à environ 24,45, puis revient, accompagné de deux gardes : la flèche suit la route vers l'ouest jusqu'à ce que vous le croisiez. Attirez-les hors de la route.",

	-- Step 39: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} et {npc:2713}",

	-- Step 40: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "La mission de {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "Restez avec {npc:2713} pendant qu'elle se faufile dans {area:314} et en revient ; des orcs de la Horde vous attaquent en chemin.\nAttention : les orcs qui tombent à peu de vie s'enfuient. {npc:2713} les suit et peut attirer d'autres monstres : tuez ou ralentissez vite les fuyards.",

	-- Step 41: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Pour {npc:2711} à {area:271}",

	-- Step 42: Stones of Binding
	-- {npc:2712} Quae · {object:2691} Stone of East Binding · {area:314} Go'Shek Farm · {object:2702} Stone of Inner Binding · {area:320} Refuge Pointe
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["From {npc:2712}'s camp, a short way north-east to the {object:2691}, by the shards' hill north of {area:314}. The {object:2702}, where the three keys go, stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Depuis le camp de {npc:2712}, un peu au nord-est jusqu'à la {object:2691}, près de la colline des éclats au nord de {area:314}. La {object:2702}, où vont les trois clés, se dresse à l'ouest de {area:320}.\nAttention : chaque pierre centrale est gardée par environ trois élémentaires proches du niveau 39 qui attaquent ensemble si vous cliquez sur la pierre sans les avoir éliminés : Exilés ardents à l'ouest, Exilés foudroyants au cercle extérieur, Exilés grimpeurs à l'est.",

	-- Step 43: Refuge Pointe
	-- {area:320} Refuge Pointe
	["West along the road to {area:320}."] = "À l'ouest par la route jusqu'à {area:320}.",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {object:2689} Stone of West Binding
	["{npc:2789}: {npc:2793}'s cave, west past the {object:2689}"] = "{npc:2789} : la grotte de {npc:2793}, à l'ouest au-delà de la {object:2689}",

	-- Step 45: Faldir's Cove
	-- {npc:2768} Professor Phizzlethorpe
	["A group stop: two level 40 water elementals ambush {npc:2768}'s escort, and the Daggerspine naga in the reef are 38-40, with Sorceresses among them. Grouping up is encouraged, look for people to do it with. Skip it if you are alone.\nSouth along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Étape de groupe : deux élémentaires d'eau de niveau 40 tendent une embuscade à l'escorte du {npc:2768}, et les nagas Daggerspine du récif sont 38-40, avec des Ensorceleuses parmi eux. Grouper est conseillé, cherchez des joueurs avec qui la faire. Passez-la si vous êtes seul.\nAu sud le long de la côte ouest jusqu'à la crique des gobelins ; Lolo fait le guet sur les rochers au-dessus.",

	-- Step 46: Phizzlethorpe
	["Phizzlethorpe"] = "Phizzlethorpe",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "Escortez le professeur en haut de la colline jusqu'à la grotte au-dessus de la crique et protégez-le pendant qu'il travaille. Deux élémentaires d'eau de niveau 40 lui tendent une embuscade là-haut, et ils sont insensibles au givre. Retenez-les à l'entrée de la grotte, loin de lui : si le combat a lieu dans la grotte, il s'y joint au lieu de travailler et d'autres élémentaires continuent d'arriver.",

	-- Step 48: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328} : tuez-les au passage",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Les deux épaves reposent dans la baie à l'ouest de la crique. Les cartes et les journaux sont à l'intérieur ; les gemmes gisent au fond de la mer autour. Des nagas Daguéchine nagent dans toute la baie.",
	-- {npc:2595} Daggerspine Raider
	["{npc:2595}, underwater"] = "{npc:2595}, sous l'eau",
	-- {item:4492} Elven Gem
	["{item:4492}; underwater"] = "{item:4492} ; sous l'eau",
	-- {npc:2596} Daggerspine Sorceress
	["{npc:2596}, underwater"] = "{npc:2596}, sous l'eau",
	-- {object:2709} Maiden's Folly Log
	["{object:2709}; underwater"] = "{object:2709} ; sous l'eau",
	-- {object:2707} Maiden's Folly Charts
	["{object:2707}; underwater"] = "{object:2707} ; sous l'eau",
	-- {object:2710} Spirit of Silverpine Log
	["{object:2710}; underwater"] = "{object:2710} ; sous l'eau",
	-- {object:2708} Spirit of Silverpine Charts
	["{object:2708}; underwater"] = "{object:2708} ; sous l'eau",

	-- Step 49: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Pour {npc:2487} à {area:35} : gardez-la",

	-- Step 50: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["South-east through the hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley.\nCareful: {npc:2793} is level 39, a caster, one or two over you here: clear the cave mouth first, then pull him alone at full health."] = "Au sud-est à travers les collines : {npc:2793}, un ogre mage, tient la grotte au bout sud de la vallée des Witherbark.\nAttention : {npc:2793} est niveau 39, un lanceur de sorts, un ou deux niveaux au-dessus de vous ici : nettoyez l'entrée de la grotte d'abord, puis attirez-le seul avec toute votre vie.",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "{item:4525} ; sous terre",

	-- Step 51: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "Au sud-ouest de la grotte de {npc:2793}, jusqu'au {area:880} : {npc:2696} se tient sur une section effondrée du pont ; sautez jusqu'à lui depuis son extrémité nord. {quest:647} doit parvenir à {npc:2705} à {area:271} en moins de 15 minutes : retournez directement au {area:320} et prenez un vol pour {area:271}.",

	-- Step 53: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "Maître de vol du {area:320}",

	-- Step 54: Brewmeister Bilger
	-- {area:271} Southshore · {npc:2276} Magistrate Henry Maleb · {npc:2277} Loremaster Dibbs · {area:280} Strahnbrad
	["Off the flight, straight to the {area:271} inn. Then {npc:2276} and {npc:2277}, in the town hall, take the Syndicate camp's quests and send you north to {area:280}."] = "À la descente du vol, allez directement à l'Auberge d'{area:271}. Puis {npc:2276} et {npc:2277}, à l'hôtel de ville, prennent les quêtes du camp du Syndicat et vous envoient au nord à {area:280}.",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "{npc:2705}, sous terre",
	-- {npc:2276} Magistrate Henry Maleb · {area:280} Strahnbrad
	["{npc:2276}: the signet rings are in {area:280}"] = "{npc:2276} : les chevalières sont à {area:280}",
	-- {npc:1356} Prospector Stormpike · {zone:1455} Ironforge
	["For {npc:1356} in {zone:1455}, at the end of this guide"] = "Pour le {npc:1356} à {zone:1455}, à la fin de ce Guide",

	-- Step 56: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings."] = "Suivez la route vers le nord en sortant d'{area:271} jusque dans les montagnes. Des lions des montagnes parcourent les pentes ; les membres du Syndicat de {area:280} portent les chevalières.",

	-- Step 57: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "{area:281} : tuez-les au passage",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "Les tomes se trouvent dans le donjon en ruine à l'ouest de {area:280} ; des Mages de l'ombre d'Argus tiennent les ruines.\nAttention : les Combattants Cassecrête appellent les alliés dans un rayon de 15 m quand leur vie passe sous la moitié.\nLes Cogneurs, Mages, Massacreurs et Combattants Cassecrête (36-39) sont élites ; les Ogres et Brutes Cassecrête (34-35) ne le sont pas et portent aussi les tomes : attirez-les un par un, ou formez un groupe.",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658} : ogres Cassecrête",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase · {quest:540} Preserving Knowledge
	["{item:3659}: the {object:1760}, beside Muckrake (40, elite): get it with a group, or abandon {quest:540}; inside"] = "{item:3659} : la {object:1760}, à côté de Muckrake (40, élite) : prenez-le en groupe, ou abandonnez {quest:540} ; à l'intérieur",

	-- Step 58: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back.\n{npc:2417} walks from the arrow north-east through the ruins to about 40,47 and back: if he isn't at the arrow, follow his path."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:2417} est un élite de niveau 40 : la plupart des classes le battent seules au niveau 42, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.\n{npc:2417} marche depuis la flèche vers le nord-est à travers les ruines jusqu'à environ 40,47, puis revient : s'il n'est pas à la flèche, suivez son trajet.",

	-- Step 59: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "{area:280} : tuez-les au passage",
	-- {npc:2306} Baron Vardus · {area:280} Strahnbrad
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps north of the village. Leave him be."] = "Attention : les Espions et Assassins du Syndicat peuvent être camouflés. Les Assassins vous empoisonnent aussi.\nAttention : {npc:2306} (40) apparaît à un seul endroit à la fois : la cave de l'auberge d'{area:280}, ou l'un des camps de tentes du Syndicat au nord du village. Laissez-le tranquille.",

	-- Step 60: Crushridge ogres
	["Crushridge ogres"] = "Ogres Cassecrête",
	-- {area:280} Strahnbrad
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Careful: Nagaz (40) stands far to the north-west by a worn wooden chest, with Syndicate guards: stay with the ogres.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "Les ogres Cassecrête tiennent les collines au nord de {area:280}. Attention : Nagaz (40) se tient loin au nord-ouest près d'un vieux coffre en bois, avec des gardes du Syndicat : restez avec les ogres.\nLes Mutileurs, Mages, Massacreurs et Combattants Cassecrête (36-39) sont élites ; les Ogres et Brutes Cassecrête (34-35) ne le sont pas et lâchent aussi les osselets : attirez-les un par un, ou formez un groupe.",

	-- Step 62: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Allez au sud-ouest jusqu'au camp du Kirin Tor sur la rive du lac, à l'ouest de {area:279}, juste après la frontière de {zone:1421} : {npc:269127} s'y tient. L'archimage Ansirem se tient au sud-est, près du dôme.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Pour {npc:2542} à {area:35} : gardez-la",

	-- Step 63: Image of Archmage Modera
	-- {npc:269127} Image of Archmage Modera · {quest:92458} Heart of Disruption · {item:277507} Dalaran Sewer Key
	["For your City of Dalaran run, next: the {npc:269127} wants the arcane remnants in the city thinned out and a mote from the heart of the disruption. {quest:92458} brings the {item:277507}, which opens the grate."] = "Pour votre expédition dans Cité de Dalaran, la prochaine étape : l'{npc:269127} veut que vous éclaircissiez les rangs des vestiges arcaniques de la ville et que vous rapportiez une particule du cœur de la perturbation. {quest:92458} donne la {item:277507}, qui ouvre la grille.",

	-- Step 64: City of Dalaran
	["City of Dalaran"] = "Cité de Dalaran",
	-- {quest:92457} Starving Arcane · {item:251961} Arcane Mote · {quest:92458} Heart of Disruption
	-- plural, as words: Seeking Remnants = {npc:247003} Seeking Remnant · Saturated Remnants = {npc:247001} Saturated Remnant
	["The City of Dalaran is a dungeon for a group of five at about level 28 to 33: at your level it goes quickly. Its way in is the sewer grate in the city's western wall, by the lake, 30 yards from Modera's camp.\nInside: the Seeking Remnants, Saturated Remnants and Mana Echoes are Modera's {quest:92457}; the {item:251961} for {quest:92458} drops inside too."] = "Cité de Dalaran est un donjon pour un groupe de cinq, vers les niveaux 28 à 33 : à votre niveau, il se fait vite. On y entre par la grille d'égout du mur ouest de la ville, près du lac, à 30 mètres du camp de Modera.\nÀ l'intérieur : les Seeking Remnants, les Saturated Remnants et les Mana Echoes sont pour {quest:92457}, la quête de Modera ; la {item:251961} pour {quest:92458} se trouve aussi à l'intérieur.",
	-- {quest:92457} Starving Arcane
	["{quest:92457}: the remnants and echoes, inside"] = "{quest:92457} : les vestiges et les échos, à l'intérieur",
	-- {quest:92458} Heart of Disruption · {item:251961} Arcane Mote
	["{quest:92458}: the {item:251961}, inside"] = "{quest:92458} : {item:251961}, à l'intérieur",

	-- Step 65: Image of Archmage Modera
	["Back out of the grate to Modera's camp on the lake shore."] = "Ressortez par la grille et retournez au camp de Modera, sur la rive du lac.",

	-- Step 68: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Pour {npc:1440} à {zone:1453} : gardez-la",

	-- Step 69: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "{npc:2438} se tient entre le maître de vol et l'auberge ; {npc:2381}, à côté de lui, vend du {item:2321} si vous n'en avez pas.",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "{item:2321}, chez {npc:2381}",

	-- Step 71: Ironforge
	-- {npc:1356} Prospector Stormpike · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356} : pour {npc:1344} au {zone:1432}, ensuite",

	-- Step 72: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Prendre un vol pour {area:144}",

	-- Step 73: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "Vers {area:144}",
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "Depuis {zone:1455}, prenez le tunnel vers l'est à travers {zone:1426} jusqu'au {zone:1432} et suivez la route jusqu'à {area:144}.",

	-- Step 74: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, sous terre",

	-- Step 75: Prospector Ironband
	["South-east along the loch to the dig site."] = "Longez le loch vers le sud-est jusqu'au site de fouilles.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:2434} lurks stealthed on the edge of {area:271}, and few players find him. If you spot him, kill him and read the contract he carries: {npc:2276} takes it. Don't wait for him: the rest of this step doesn't need him."] = "Un {npc:2434} rôde, camouflé, en bordure d'{area:271}, et peu de joueurs le trouvent. Si vous le repérez, tuez-le et lisez le contrat qu'il porte : {npc:2276} le prend. Ne l'attendez pas : le reste de cette étape n'a pas besoin de lui.",
	-- ["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "Un {npc:2434} rôde, invisible, en bordure d'{area:271} ; tuez-le et lisez le contrat qu'il porte.",
	-- ["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: About three stealthed Syndicate mobs are inside {npc:2320}'s house. {npc:2320} does not join when they are pulled, and a ranged attack through the doorway brings him out by himself."] = "Attention : les Espions et les Assassins du Syndicat peuvent être camouflés. Les Assassins vous empoisonnent aussi.\nAttention : environ trois membres du Syndicat camouflés se trouvent dans la maison de {npc:2320}. {npc:2320} ne se joint pas au combat quand vous les attirez, et une attaque à distance par la porte le fait sortir seul.",
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Chaque clé se trouve à l'un des cercles de pierres levées des Hautes-terres : à l'est des éclats, près de {area:320} et à l'ouest. La {object:2702} se dresse à l'ouest de {area:320}.",
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Chaque clé se trouve dans l'un des cercles de pierres levées des Hautes-terres : à l'est des éclats, près du {area:320} et à l'ouest. {object:2702} se dresse à l'ouest du {area:320}.\nAttention : chaque pierre centrale est gardée par environ trois élémentaires proches du niveau 39 qui attaquent ensemble si vous cliquez sur la pierre sans les avoir éliminés : Exilés ardents à l'ouest, Exilés foudroyants au cercle extérieur, Exilés grimpeurs à l'est.",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals. {quest:1392} walks a long path through the ruins: if you meet him, kill him, his cudgel starts a quest for {npc:1776}. Don't wait for him."] = "Suivez la route vers l'est jusqu'à {area:76}. Les ennemis {npc:256028} laissent tomber les cristaux. {quest:1392} parcourt un long chemin à travers les ruines : si vous le croisez, tuez-le, son gourdin lance une quête pour {npc:1776}. Ne l'attendez pas.",
	-- ["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "Suivez la route vers l'est jusqu'à {area:76}. Les ennemis {npc:256028} laissent tomber les cristaux ; Noboru parcourt les ruines et laisse tomber son gourdin.",
	-- ["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "À l'est de {area:327}, par les collines du sud : {npc:2793}, un mage ogre, occupe la grotte à l'extrémité sud de la vallée des Witherbark.",
	-- ["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Escortez le professeur jusqu'à la plage au nord de la crique et protégez-le pendant qu'il travaille ; les nagas attaquent par vagues.",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves.\nCareful: The ambush is two level 40 water elementals, and they are immune to frost. If the fight happens inside the cave, the professor joins in instead of working and further elementals keep appearing; holding the elementals at the cave entrance, away from him, lets him finish with only the first two to deal with."] = "Escortez le professeur jusqu'à la plage au nord de la crique et protégez-le pendant qu'il travaille ; les nagas attaquent par vagues.\nAttention : l'embuscade se compose de deux élémentaires d'eau de niveau 40, insensibles au givre. Si le combat a lieu dans la grotte, le professeur s'y joint au lieu de travailler et d'autres élémentaires continuent d'apparaître ; retenir les élémentaires à l'entrée de la grotte, loin de lui, lui permet de terminer avec seulement les deux premiers à affronter.",
	-- ["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Suivez la route vers l'est hors de {area:287}, par {area:1057}, jusqu'à {area:320}.",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Suivez la route vers le nord en sortant d'{area:271} jusque dans les montagnes. Des lions des montagnes parcourent les pentes ; les membres du Syndicat de {area:280} portent les chevalières, et {npc:2306} arpente le domaine du manoir au nord de la ville.",
	-- ["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings. {npc:2306} (40) turns up in one spot at a time: the cellar of {area:280}'s inn, or one of the Syndicate tent camps in the uplands north and north-west of the village."] = "Suivez la route vers le nord en sortant d'{area:271} jusque dans les montagnes. Des lions des montagnes parcourent les pentes ; les membres du Syndicat de {area:280} portent les chevalières. {npc:2306} (40) apparaît à un seul endroit à la fois : la cave de l'auberge d'{area:280}, ou l'un des camps de tentes du Syndicat sur les hauteurs au nord et au nord-ouest du village.",
	-- ["Follow the road north to the draenei of the {area:657}."] = "Suivez la route vers le nord jusqu'aux draeneï du {area:657}.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Suivez la route vers le sud par le pont jusqu'à {area:205}, côté {zone:1437}, où attend {npc:1075}.",
	-- ["For characters of 36 to 38, but {area:327} and the Alterac Syndicate quests are level 40: on purpose, for their experience. {npc:2768}'s two water elementals (40) are immune to frost, and {npc:2306} (40) waits among his Syndicate: pull them one at a time."] = "Pour les personnages de niveau 36 à 38, mais {area:327} et les quêtes du Syndicat d'Alterac sont de niveau 40 : c'est voulu, pour leur expérience. Les deux élémentaires d'eau de {npc:2768} (40) sont insensibles au givre, et {npc:2306} (40) attend parmi son Syndicat : attirez-les un par un.",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "Depuis {area:42}, suivez la route vers l'est à travers {zone:1430} jusqu'à {zone:1435} ; Biggs garde le carrefour juste à l'entrée. {npc:217412} se tient un peu au nord de lui.",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "Depuis {zone:1455}, prenez le tunnel vers l'est à travers {zone:1426} jusqu'au {area:38} et suivez la route jusqu'à {area:144}.",
	-- ["Gyll, {area:35}"] = "Gyll, {area:35}",
	-- ["Head back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Repartez vers le nord-est après le {area:320} ; {npc:2712} et {npc:2713} campent dans les collines au nord de {area:314}.",
	-- ["Head back south from the eastern circle; {npc:2712} and {npc:2713} camp in the hills just north of {area:314}."] = "Repartez vers le sud depuis le cercle est ; {npc:2712} et {npc:2713} campent dans les collines juste au nord de {area:314}.",
	-- ["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Allez au nord au-delà de {area:314} ; les éclats scintillent sur la colline près de {area:333}.",
	-- ["Inside"] = "À l'intérieur",
	-- ["Off the flight, straight to the {area:271} inn."] = "En descendant du griffon, allez directement à l'auberge d'{area:271}.",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Retournez au nord-est au-delà de {area:320} ; {npc:2712} et {npc:2713} campent dans les collines au nord de {area:314}.",
	-- ["Shaman training"] = "Entraînement de chaman",
	-- ["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Longez la côte ouest vers le sud jusqu'à la crique des gobelins ; Lolo monte la garde sur les rochers au-dessus.",
	-- ["South from the {object:2691}, past {area:314}, to {area:317} in the hills: the Witch Doctors stand among the huts and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "Au sud de {object:2691}, au-delà de {area:314}, jusqu'à {area:317} dans les collines : les Sorciers-docteurs se tiennent parmi les huttes et les Chasseurs des ombres gardent le fond de la vallée. Chaque troll peut laisser tomber une défense.",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Au sud-ouest jusqu'au camp du Kirin Tor sur la rive du lac à l'ouest de {area:279}, juste après la frontière de la {area:130} : {npc:269127} s'y tient. L'archimage Ansirem se tient au sud-est, près du dôme.",
	-- ["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Restez avec {npc:2713} pendant qu'elle s'infiltre dans {area:314} et revient ; des orcs de la Horde vous attaquent en chemin.",
	-- ["Subdue the succubus"] = "Soumettez la succube",
	-- ["Summon Succubus"] = "Invoquez la succube",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "Les ogres Cassecrête tiennent les collines au nord de {area:280}. Plus au nord, un vieux coffre en bois contient le {item:3706} ; {npc:2320}, du {quest:537}, se tient juste à côté.\nLes Cogneurs, Mages, Massacreurs et Bellicistes Cassecrête (36-39) sont élites ; les Ogres et Brutes Cassecrête (34-35) ne le sont pas et lâchent aussi les osselets : attirez-les un par un, ou formez un groupe.",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Les kobolds Sèche-moustache creusent dans la gorge à l'est de {area:321} (Horde) ; contournez la ville par le nord. Ils laissent tomber les particules et le minerai de Krazek.",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Les kobolds Sèche-moustache creusent dans la gorge à l'est de {area:321} (Horde) ; contournez la ville par le nord. Ils lâchent à la fois les particules et le minerai de Krazek.\nAttention : chaque type de kobold s'enfuit chercher de l'aide quand sa vie est basse (les Kobolds à 30 %, les Géomètres et les Terrassiers à 15 %), ce qui peut en attirer d'autres.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "Le Syndicat tient la ferme au nord-ouest de {area:320}. Un {npc:217589} rampe dans la ferme : capturez-en un avec le kit d'entomologie de {npc:217412}, puis cochez-le.",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Les trolls Witherbark vivent dans les collines au sud de {area:314} ; les Sorciers-docteurs se tiennent dans le village, les Chasseurs des ombres gardent le fond de la vallée.",
	-- ["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "Le coursier parcourt la route à l'ouest de {area:314} avec deux gardes ; attirez-les hors de la route.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Les tomes se trouvent dans le donjon en ruine à l'ouest de {area:280} ; des Mages de l'ombre d'Argus occupent les ruines.",
	-- ["The wrecked caravan lies off the road near Biggs."] = "La caravane détruite se trouve en bord de route, près de Biggs.",
	-- ["The wrecks"] = "Les épaves",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:2417} est un élite de niveau 40 : la plupart des classes le battent seules au niveau 42, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Revenez sur le pont : Ebenezer gît sous son extrémité côté Arathi.",
	-- ["West along the road to {area:320}, on the way to the {object:2689}."] = "À l'ouest par la route jusqu'au {area:320}, sur le chemin de {object:2689}.",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} pour la cape de {npc:2438}, chez {npc:2381}, si vous n'en avez pas",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659} : {object:1760}",
	-- ["{item:4435} along the way to {object:2701}"] = "{item:4435} sur le chemin de {object:2701}",
	-- ["{item:4435} on the way"] = "{item:4435} en chemin",
	-- ["{item:4522} on the way"] = "{item:4522} en chemin",
	-- ["{npc:1356}, {object:32356}: for {npc:1344} in {zone:1432}, next"] = "{npc:1356}, {object:32356} : pour {npc:1344} au {zone:1432}, ensuite",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589} : capturez-le, pour {quest:93176}",
	-- ["{npc:2277}: the parchment"] = "{npc:2277} : le parchemin",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, dans la Cité de Dalaran",
	-- ["{npc:2789}: {npc:2793}'s cave comes after {area:327}"] = "{npc:2789} : la grotte de {npc:2793} vient après {area:327}",
	-- ["{object:2652}, inside"] = "{object:2652}, à l'intérieur",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453} n'a pas de maître chaman : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455} et entraînez-vous auprès de {npc:258098}. {npc:1573}, dans {object:32372}, propose aussi un vol pour {area:271}.",
}
