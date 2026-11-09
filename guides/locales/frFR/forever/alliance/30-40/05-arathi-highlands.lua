-- French (frFR): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Prenez un vol pour {area:42}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maître de vol de {area:35}",

	-- Step 3: Watcher Biggs
	-- {npc:5476} Watcher Biggs · {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him.\n{npc:217412} may not be here on Forever: if {npc:217412} doesn't offer {quest:93176}, skip it."] = "",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412} : trois bestioles à capturer en Arathi, en {zone:1443} et à Strangleronce",

	-- Step 4: The western swamp
	["The western swamp"] = "Le marais occidental",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Jeunes crocilisques, Tisseuses des pleurs et Jaguars du marécage parcourent tous le marais autour de la route.",

	-- Step 6: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "Suivez la route vers le nord jusqu'aux draeneï du {area:657}.",

	-- Step 7: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "Suivez la route vers l'est jusqu'à {area:76}. Les ennemis {npc:256028} laissent tomber les cristaux ; Noboru parcourt les ruines et laisse tomber son gourdin.",

	-- Step 8: The Lost Caravan
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	-- plural, as words: Lost Ones = {npc:254797} Lost One
	["The wrecked caravan's chest lies at the north end of the {area:76}, beside {npc:5391}'s cage.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391} est enfermé dans une cage au nord du sanctuaire. Libérez-le et gardez-le en vie pendant la sortie ; son coffre vous attend ensuite au bord de la route.",

	-- Step 10: The Harborage
	-- {npc:5391} Galen Goodward · {area:657} The Harborage
	["West along the road from {npc:5391}'s strongbox to the {area:657}."] = "",
	-- {npc:1776} Magtoor
	["{npc:1776}: Noboru's cudgel"] = "",

	-- Step 11: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["South down the road to {npc:5476}, on the way west out of the swamp."] = "",

	-- Step 13: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Prenez un vol pour {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "Retournez vers l'ouest par le {zone:1430} jusqu'à {area:42}.",

	-- Step 14: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, route de {area:17203}",

	-- Step 15: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} attend dans la cave de {object:2164}, dans {object:2101}. Utilisez le {item:6913} sur le cercle d'invocation et vainquez la succube invoquée. Si vous avez pris {quest:65602}, donnez-lui aussi la {item:190309}, placez-la sur le même cercle et vainquez l'incube.",
	-- {npc:5677} Summoned Succubus
	["{npc:5677}, at the summoning circle"] = "",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, si vous l'avez prise",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, sur le même cercle",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} vous lie l'incube",

	-- Step 16: Stormwind
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, Cathedral of Light",

	-- Step 18: Stormwind
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, la Royal Library du donjon",

	-- Step 19: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tram pour {zone:1455}",

	-- Step 20: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prenez un vol pour {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Maître de vol de {zone:1455}",

	-- Step 22: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "Un {npc:2434} rôde, invisible, en bordure d'{area:271} ; tuez-le et lisez le contrat qu'il porte.",
	-- {npc:2276} Magistrate Henry Maleb
	["{npc:2276}, inside"] = "{npc:2276}, à l'intérieur",

	-- Step 25: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Suivez la route vers l'est hors de {area:287}, par {area:1057}, jusqu'à {area:320}.",
	-- {npc:2700} Captain Nials · {npc:1075} Rhag Garmason
	["{npc:2700}: {npc:1075}'s plea, from 01-hillsbrad-foothills"] = "",

	-- Step 26: Northfold Manor
	-- {area:320} Refuge Pointe
	["The Syndicate hold the farm north-west of {area:320}.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "",

	-- Step 27: Hay Weevil
	-- {quest:681} Northfold Manor · {npc:217412} Amaryllis Webb
	-- plural, as words: Hay Weevils = {npc:217589} Hay Weevil
	["Hay Weevils crawl about the north end of {quest:681}'s farm: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "",

	-- Step 28: Witherbark Village
	-- {area:314} Go'Shek Farm
	["A few Witherbark trolls camp south of Northfold, on the way; the main village lies in the hills south of {area:314} in the south-east, where the Witch Doctors stand and the Shadow Hunters guard the far end of the valley. Every troll can drop a tusk."] = "",
	-- {item:5040} Shadow Hunter Knife
	["{item:5040}; below ground"] = "{item:5040} ; sous terre",

	-- Step 29: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Allez au nord au-delà de {area:314} ; les éclats scintillent sur la colline près de {area:333}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Seulement si Gluggle vous a donné le pendentif à Strangleronce",

	-- Step 30: Drywhisker Gorge: kill these as you meet them
	-- {area:318} Drywhisker Gorge
	["{area:318}: kill these as you meet them"] = "{area:318} : tuez-les au passage",
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "Les kobolds Sèche-moustache creusent dans la gorge à l'est de {area:321} (Horde) ; contournez la ville par le nord. Ils lâchent à la fois les particules et le minerai de Krazek.\nAttention : chaque type de kobold s'enfuit chercher de l'aide quand sa vie est basse (les Kobolds à 30 %, les Géomètres et les Terrassiers à 15 %), ce qui peut en attirer d'autres.",
	-- {item:4435} Mote of Myzrael · {npc:2572} Drywhisker Kobold · {npc:2573} Drywhisker Surveyor · {npc:2574} Drywhisker Digger
	["{item:4435} from {npc:2572}, {npc:2573} and {npc:2574}, by this stop"] = "",

	-- Step 31: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Les éclats se trouvent au fond de {area:318}.",
	["Below ground"] = "Sous terre",

	-- Step 32: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Chaque clé se trouve dans l'un des cercles de pierres levées des Hautes-terres : à l'est des éclats, près du {area:320} et à l'ouest. {object:2702} se dresse à l'ouest du {area:320}.\nAttention : chaque pierre centrale est gardée par environ trois élémentaires proches du niveau 39 qui attaquent ensemble si vous cliquez sur la pierre sans les avoir éliminés : Exilés ardents à l'ouest, Exilés foudroyants au cercle extérieur, Exilés grimpeurs à l'est.",

	-- Step 33: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Head back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Repartez vers le nord-est après le {area:320} ; {npc:2712} et {npc:2713} campent dans les collines au nord de {area:314}.",

	-- Step 34: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "Le coursier parcourt la route à l'ouest de {area:314} avec deux gardes ; attirez-les hors de la route.",

	-- Step 36: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} et {npc:2713}",

	-- Step 37: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "La mission de {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way.\nCareful: Orcs that drop to low health run away. {npc:2713} follows them and can pull more mobs, so kill or slow runners fast."] = "Restez avec {npc:2713} pendant qu'elle se faufile dans {area:314} et en revient ; des orcs de la Horde vous attaquent en chemin.\nAttention : les orcs qui tombent à peu de vie s'enfuient. {npc:2713} les suit et peut attirer d'autres monstres : tuez ou ralentissez vite les fuyards.",

	-- Step 38: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Pour {npc:2711} à {area:271}",

	-- Step 39: Refuge Pointe
	-- {area:320} Refuge Pointe · {object:2689} Stone of West Binding
	["West along the road to {area:320}, on the way to the {object:2689}."] = "",
	-- {npc:2789} Skuerto · {npc:2793} Kor'gresh Coldrage · {area:327} Faldir's Cove
	["{npc:2789}: {npc:2793}'s cave comes after {area:327}"] = "",

	-- Step 41: Faldir's Cove
	["South along the west coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "",

	-- Step 42: Phizzlethorpe
	["Phizzlethorpe"] = "Phizzlethorpe",
	["Escort the professor up the hill to the cave above the cove and guard him while he works. Two level 40 water elementals ambush him there, and they are immune to frost. Hold them at the cave mouth, away from him: if the fight happens inside the cave, he joins in instead of working and more elementals keep coming."] = "",

	-- Step 44: The Drowned Reef: kill these as you meet them
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

	-- Step 45: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Pour {npc:2487} à {area:35} : gardez-la",

	-- Step 46: Kor'gresh Coldrage
	-- {area:327} Faldir's Cove · {npc:2793} Kor'gresh Coldrage
	["East from {area:327} through the southern hills: {npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "",
	-- {item:4525} Trelane's Wand of Invocation
	["{item:4525}; below ground"] = "{item:4525} ; sous terre",

	-- Step 47: Foggy MacKreel
	-- {npc:2793} Kor'gresh Coldrage · {area:880} Thandol Span · {npc:2696} Foggy MacKreel · {quest:647} MacKreel's Moonshine · {npc:2705} Brewmeister Bilger · {area:271} Southshore · {area:320} Refuge Pointe
	["South-west from {npc:2793}'s cave to the {area:880}: {npc:2696} stands on a broken section of the bridge; jump down to him from its north end. {quest:647} must reach {npc:2705} in {area:271} within 15 minutes: go straight back to {area:320} and fly to {area:271}."] = "",

	-- Step 49: Fly to Southshore
	-- {area:320} Refuge Pointe
	["{area:320} flight master"] = "Maître de vol du {area:320}",

	-- Step 50: Brewmeister Bilger
	-- {area:271} Southshore
	["Off the flight, straight to the {area:271} inn."] = "",
	-- {npc:2705} Brewmeister Bilger
	["{npc:2705}, below ground"] = "",

	-- Step 52: Gavin's Naze
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Suivez la route vers le nord en sortant d'{area:271} jusque dans les montagnes. Des lions des montagnes parcourent les pentes ; les membres du Syndicat de {area:280} portent les chevalières, et {npc:2306} arpente le domaine du manoir au nord de la ville.",

	-- Step 53: Ruins of Alterac: kill these as you meet them
	-- {area:281} Ruins of Alterac
	["{area:281}: kill these as you meet them"] = "{area:281} : tuez-les au passage",
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage · Crushridge Warmongers = {npc:2287} Crushridge Warmonger · Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and carry the tomes too: pull one at a time, or group up."] = "",
	-- {item:3658} Recovered Tome
	["{item:3658}: Crushridge ogres"] = "{item:3658} : ogres Cassecrête",
	-- {item:3659} Worn Leather Book · {object:1760} Weathered Bookcase
	["{item:3659}: the {object:1760}; inside"] = "{item:3659} : {object:1760} ; à l'intérieur",

	-- Step 54: Ruins of Alterac: kill these as you meet them
	-- {npc:2417} Grel'borg the Miser
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:2417} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "Ce sont des monstres élites : il est conseillé de se grouper, cherchez des joueurs avec qui le faire. {npc:2417} est un élite de niveau 40 : la plupart des classes le battent seules au niveau 42, mais vous aurez peut-être besoin d'aide. Passez-le si vous êtes seul : l'itinéraire vous fait regagner l'expérience en tuant des monstres.",

	-- Step 55: Strahnbrad: kill these as you meet them
	-- {area:280} Strahnbrad
	["{area:280}: kill these as you meet them"] = "{area:280} : tuez-les au passage",
	-- {npc:2320} Nagaz
	["Careful: Syndicate Spies and Assassins can be stealthed. Assassins also poison you.\nCareful: About three stealthed Syndicate mobs are inside {npc:2320}'s house. {npc:2320} does not join when they are pulled, and a ranged attack through the doorway brings him out by himself."] = "Attention : les Espions et les Assassins du Syndicat peuvent être camouflés. Les Assassins vous empoisonnent aussi.\nAttention : environ trois membres du Syndicat camouflés se trouvent dans la maison de {npc:2320}. {npc:2320} ne se joint pas au combat quand vous les attirez, et une attaque à distance par la porte le fait sortir seul.",

	-- Step 56: Crushridge ogres
	["Crushridge ogres"] = "Ogres Cassecrête",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	-- plural, as words: Crushridge Maulers = {npc:2254} Crushridge Mauler · Crushridge Ogres = {npc:2252} Crushridge Ogre
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it.\nThe Crushridge Maulers, Mages, Enforcers and Warmongers (36-39) are elite; the Crushridge Ogres and Brutes (34-35) are not and drop the knucklebones too: pull one at a time, or group up."] = "",
	["Inside"] = "À l'intérieur",

	-- Step 58: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Allez au sud-ouest jusqu'au camp du Kirin Tor sur la rive du lac, à l'ouest de {area:279}, juste après la frontière de {zone:1421} : {npc:269127} s'y tient. L'archimage Ansirem se tient au sud-est, près du dôme.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Pour {npc:2542} à {area:35} : gardez-la",

	-- Step 60: Southshore
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Pour {npc:1440} à {zone:1453} : gardez-la",
	-- {npc:2277} Loremaster Dibbs
	["{npc:2277}: the parchment"] = "",

	-- Step 61: Bartolo Ginsetti
	-- {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance · {item:2321} Fine Thread
	["{npc:2438} stands between the flight master and the inn; {npc:2381} beside him sells {item:2321} if you have none."] = "",
	-- {item:2321} Fine Thread · {npc:2381} Micha Yance
	["{item:2321}, from {npc:2381}"] = "",

	-- Step 64: Ironforge
	-- {npc:1356} Prospector Stormpike · {object:32356} Hall of Explorers · {npc:1344} Prospector Ironband · {zone:1432} Loch Modan
	["{npc:1356}, {object:32356}: for {npc:1344} in {zone:1432}, next"] = "",

	-- Step 65: To Thelsamar
	-- {area:144} Thelsamar
	["To {area:144}"] = "",

	-- Step 66: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "Depuis {zone:1455}, prenez le tunnel vers l'est à travers {zone:1426} jusqu'au {zone:1432} et suivez la route jusqu'à {area:144}.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, sous terre",

	-- Step 67: Prospector Ironband
	["South-east along the loch to the dig site."] = "Longez le loch vers le sud-est jusqu'au site de fouilles.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Chaque clé se trouve à l'un des cercles de pierres levées des Hautes-terres : à l'est des éclats, près de {area:320} et à l'ouest. La {object:2702} se dresse à l'ouest de {area:320}.",
	-- ["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Escortez le professeur jusqu'à la plage au nord de la crique et protégez-le pendant qu'il travaille ; les nagas attaquent par vagues.",
	-- ["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves.\nCareful: The ambush is two level 40 water elementals, and they are immune to frost. If the fight happens inside the cave, the professor joins in instead of working and further elementals keep appearing; holding the elementals at the cave entrance, away from him, lets him finish with only the first two to deal with."] = "Escortez le professeur jusqu'à la plage au nord de la crique et protégez-le pendant qu'il travaille ; les nagas attaquent par vagues.\nAttention : l'embuscade se compose de deux élémentaires d'eau de niveau 40, insensibles au givre. Si le combat a lieu dans la grotte, le professeur s'y joint au lieu de travailler et d'autres élémentaires continuent d'apparaître ; retenir les élémentaires à l'entrée de la grotte, loin de lui, lui permet de terminer avec seulement les deux premiers à affronter.",
	-- ["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Suivez la route vers le sud par le pont jusqu'à {area:205}, côté {zone:1437}, où attend {npc:1075}.",
	-- ["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "Depuis {area:42}, suivez la route vers l'est à travers {zone:1430} jusqu'à {zone:1435} ; Biggs garde le carrefour juste à l'entrée. {npc:217412} se tient un peu au nord de lui.",
	-- ["From {zone:1455} take the tunnel east through {zone:1426} into {area:38} and follow the road to {area:144}."] = "Depuis {zone:1455}, prenez le tunnel vers l'est à travers {zone:1426} jusqu'au {area:38} et suivez la route jusqu'à {area:144}.",
	-- ["Gyll, {area:35}"] = "Gyll, {area:35}",
	-- ["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Retournez au nord-est au-delà de {area:320} ; {npc:2712} et {npc:2713} campent dans les collines au nord de {area:314}.",
	-- ["Shaman training"] = "Entraînement de chaman",
	-- ["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {area:130}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Au sud-ouest jusqu'au camp du Kirin Tor sur la rive du lac à l'ouest de {area:279}, juste après la frontière de la {area:130} : {npc:269127} s'y tient. L'archimage Ansirem se tient au sud-est, près du dôme.",
	-- ["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Restez avec {npc:2713} pendant qu'elle s'infiltre dans {area:314} et revient ; des orcs de la Horde vous attaquent en chemin.",
	-- ["Subdue the succubus"] = "Soumettez la succube",
	-- ["Summon Succubus"] = "Invoquez la succube",
	-- ["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Les ogres Cassecrête tiennent les collines au nord de {area:280}. Plus au nord, un vieux coffre en bois contient le {item:3706} ; {npc:2320}, du {quest:537}, se tient juste à côté.",
	-- ["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Les kobolds Sèche-moustache creusent dans la gorge à l'est de {area:321} (Horde) ; contournez la ville par le nord. Ils laissent tomber les particules et le minerai de Krazek.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "Le Syndicat tient la ferme au nord-ouest de {area:320}. Un {npc:217589} rampe dans la ferme : capturez-en un avec le kit d'entomologie de {npc:217412}, puis cochez-le.",
	-- ["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off.\nCareful: Syndicate Highwaymen are level 30-31 and can cast Sneak while out of combat, so they are often stealthed and hard to spot."] = "Le Syndicat tient la ferme au nord-ouest du {area:320}. Un {npc:217589} rampe dans la ferme : attrapez-en un avec le kit d'entomologiste débutant de {npc:217412}, puis cochez-le.\nAttention : les Malandrins du Syndicat sont de niveau 30-31 et peuvent lancer Camouflage hors combat : ils sont souvent furtifs et difficiles à repérer.",
	-- ["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Les trolls Witherbark vivent dans les collines au sud de {area:314} ; les Sorciers-docteurs se tiennent dans le village, les Chasseurs des ombres gardent le fond de la vallée.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Les tomes se trouvent dans le donjon en ruine à l'ouest de {area:280} ; des Mages de l'ombre d'Argus occupent les ruines.",
	-- ["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins.\nCareful: Crushridge Warmongers call nearby allies within 15 yd once they fall below half health."] = "Les tomes se trouvent dans le donjon en ruine à l'ouest de {area:280} ; des Mages de l'ombre d'Argus tiennent les ruines.\nAttention : les Combattants Cassecrête appellent les alliés dans un rayon de 15 m quand leur vie passe sous la moitié.",
	-- ["The wrecked caravan lies off the road near Biggs."] = "La caravane détruite se trouve en bord de route, près de Biggs.",
	-- ["The wrecked caravan lies off the road near Biggs.\nCareful: The camp is full of Lost Ones around level 38. They stand in linked groups of 2-3, many are casters, and they respawn quickly."] = "La caravane détruite se trouve à l'écart de la route, près de Biggs.\nAttention : le camp est rempli d'Égarés de niveau 38 environ. Ils se tiennent en groupes liés de 2 ou 3, beaucoup lancent des sorts, et ils réapparaissent vite.",
	-- ["The wrecks"] = "Les épaves",
	-- ["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Revenez sur le pont : Ebenezer gît sous son extrémité côté Arathi.",
	-- ["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Longez la côte vers l'ouest jusqu'à la crique des gobelins ; Lolo monte la garde sur les rochers au-dessus.",
	-- ["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} pour la cape de {npc:2438}, chez {npc:2381}, si vous n'en avez pas",
	-- ["{item:3659}: the {object:1760}"] = "{item:3659} : {object:1760}",
	-- ["{item:4435} along the way to {object:2701}"] = "{item:4435} sur le chemin de {object:2701}",
	-- ["{item:4435} on the way"] = "{item:4435} en chemin",
	-- ["{item:4522} on the way"] = "{item:4522} en chemin",
	-- ["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589} : capturez-le, pour {quest:93176}",
	-- ["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, dans la Cité de Dalaran",
	-- ["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, un mage ogre, occupe la grotte à l'extrémité sud de la vallée des Witherbark.",
	-- ["{npc:5476} guards the road junction in the west of the swamp. {npc:217412} stands a short way north of him."] = "{npc:5476} garde le carrefour à l'ouest du marais. {npc:217412} se tient un peu au nord de lui.",
	-- ["{object:2652}, inside"] = "{object:2652}, à l'intérieur",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453} n'a pas de maître chaman : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455} et entraînez-vous auprès de {npc:258098}. {npc:1573}, dans {object:32372}, propose aussi un vol pour {area:271}.",
}
