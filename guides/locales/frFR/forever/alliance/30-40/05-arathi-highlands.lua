-- French (frFR): the guide forever/alliance/30-40/05-arathi-highlands (forever/alliance/30-40/05-arathi-highlands.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["Gyll, {area:35}"] = "Gyll, {area:35}",

	-- Step 2: Watcher Biggs
	-- {area:42} Darkshire · {zone:1430} Deadwind Pass · {zone:1435} Swamp of Sorrows · {npc:217412} Amaryllis Webb
	["From {area:42} follow the road east through {zone:1430} into the {zone:1435}; Biggs guards the road junction just inside it. {npc:217412} stands a short way north of him."] = "Depuis {area:42}, suivez la route vers l'est à travers {zone:1430} jusqu'à {zone:1435} ; Biggs garde le carrefour juste à l'entrée. {npc:217412} se tient un peu au nord de lui.",
	-- {npc:217412} Amaryllis Webb · {zone:1443} Desolace
	["{npc:217412}: three critters to catch in Arathi, {zone:1443} and Stranglethorn"] = "{npc:217412} : trois bestioles à capturer en Arathi, en {zone:1443} et à Strangleronce",

	-- Step 3: The western swamp
	["The western swamp"] = "Le marais occidental",
	-- plural, as words: Sorrow Spinners = {npc:858} Sorrow Spinner · Swamp Jaguars = {npc:767} Swamp Jaguar
	["Young crocolisks, Sorrow Spinners and Swamp Jaguars all roam the swamp around the road."] = "Jeunes crocilisques, Tisseuses des pleurs et Jaguars du marécage parcourent tous le marais autour de la route.",

	-- Step 5: The Lost Caravan
	["The wrecked caravan lies off the road near Biggs."] = "La caravane détruite se trouve en bord de route, près de Biggs.",

	-- Step 7: The Harborage
	-- {area:657} The Harborage
	["Follow the road north to the draenei of the {area:657}."] = "Suivez la route vers le nord jusqu'aux draeneï du {area:657}.",

	-- Step 8: Fallow Sanctuary
	-- {area:76} Fallow Sanctuary · {npc:256028} The Lost One
	["East along the road to the {area:76}. {npc:256028} mobs drop the crystals; Noboru walks the ruins and drops his cudgel."] = "Suivez la route vers l'est jusqu'à {area:76}. Les ennemis {npc:256028} laissent tomber les cristaux ; Noboru parcourt les ruines et laisse tomber son gourdin.",

	-- Step 9: Galen Goodward
	-- {npc:5391} Galen Goodward
	["{npc:5391} is caged at the north end of the sanctuary. Free him and keep him alive on the walk out; his strongbox waits by the road afterwards."] = "{npc:5391} est enfermé dans une cage au nord du sanctuaire. Libérez-le et gardez-le en vie pendant la sortie ; son coffre vous attend ensuite au bord de la route.",

	-- Step 11: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Prenez un vol pour {zone:1453}",
	-- {zone:1430} Deadwind Pass · {area:42} Darkshire
	["Back west through {zone:1430} to {area:42}."] = "Retournez vers l'ouest à travers {zone:1430} jusqu'à {area:42}.",

	-- Step 12: Stormwind
	-- {npc:1141} Angus Stern · {area:17203} Stormwind Harbor
	["{npc:1141}, {area:17203} road"] = "{npc:1141}, route de {area:17203}",
	-- {npc:12336} Brother Crowley
	["{npc:12336}, Cathedral of Light"] = "{npc:12336}, Cathedral of Light",
	-- {npc:1440} Milton Sheaf
	["{npc:1440}, the Royal Library in the keep"] = "{npc:1440}, la Royal Library du donjon",

	-- Step 13: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {item:6913} Heartswood Core · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["{npc:6122} waits in the {object:2164}'s cellar, in the {object:2101}. Use the {item:6913} at the summoning circle there and defeat the succubus it calls. If you took {quest:65602}, hand him the {item:190309} too, place it at the same circle and defeat the incubus."] = "{npc:6122} attend dans la cave de {object:2164}, dans {object:2101}. Utilisez le {item:6913} sur le cercle d'invocation et vainquez la succube invoquée. Si vous avez pris {quest:65602}, donnez-lui aussi la {item:190309}, placez-la sur le même cercle et vainquez l'incube.",
	["Subdue the succubus"] = "Soumettez la succube",
	-- {quest:65602} What Is Love?
	["{quest:65602}, if you took it"] = "{quest:65602}, si vous l'avez prise",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the same circle"] = "{npc:185335}, sur le même cercle",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122} binds the incubus to you"] = "{npc:6122} vous lie l'incube",

	-- Step 14: Shaman training
	["Shaman training"] = "Entraînement de chaman",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker · {npc:1573} Gryth Thurden · {object:32372} Great Forge · {area:271} Southshore
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train with {npc:258098}. {npc:1573} in the {object:32372} flies to {area:271} too."] = "{zone:1453} n'a pas de maître chaman : prenez {area:2257} depuis {object:28027} jusqu'à {zone:1455} et entraînez-vous auprès de {npc:258098}. {npc:1573}, dans {object:32372}, propose aussi un vol pour {area:271}.",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prenez un vol pour {area:271}",

	-- Step 17: Shadowy Assassin
	-- {npc:2434} Shadowy Assassin · {area:271} Southshore
	["A {npc:2434} lurks unseen on the edge of {area:271}; kill him and read the contract he carries."] = "Un {npc:2434} rôde, invisible, en bordure d'{area:271} ; tuez-le et lisez le contrat qu'il porte.",

	-- Step 18: Refuge Pointe
	-- {area:287} Hillsbrad · {area:1057} Thoradin's Wall · {area:320} Refuge Pointe
	["Follow the road east out of {area:287} over {area:1057} to {area:320}."] = "Suivez la route vers l'est hors de {area:287}, par {area:1057}, jusqu'à {area:320}.",

	-- Step 19: Northfold Manor
	-- {area:320} Refuge Pointe · {npc:217589} Hay Weevil · {npc:217412} Amaryllis Webb
	["The Syndicate hold the farm north-west of {area:320}. A {npc:217589} crawls about the farm: catch one with {npc:217412}'s Entomology Starter Kit, then tick it off."] = "Le Syndicat tient la ferme au nord-ouest de {area:320}. Un {npc:217589} rampe dans la ferme : capturez-en un avec le kit d'entomologie de {npc:217412}, puis cochez-le.",
	-- {npc:217589} Hay Weevil · {quest:93176} My Little Friends
	["{npc:217589}: catch it, for {quest:93176}"] = "{npc:217589} : capturez-le, pour {quest:93176}",

	-- Step 21: Thandol Span
	-- {area:205} Dun Modr · {zone:1437} Wetlands · {npc:1075} Rhag Garmason
	["Follow the road south over the bridge to {area:205} at the {zone:1437} end, where {npc:1075} waits."] = "Suivez la route vers le sud par le pont jusqu'à {area:205}, côté {zone:1437}, où attend {npc:1075}.",

	-- Step 22: Ebenezer Rustlocke
	["Ebenezer Rustlocke"] = "Ebenezer Rustlocke",
	["Walk back onto the span: Ebenezer lies under its Arathi end."] = "Retournez sur le pont : Ebenezer gît sous son extrémité côté Arathi.",

	-- Step 23: Faldir's Cove
	["West along the coast to the goblins' cove; Lolo keeps watch on the rocks above it."] = "Longez la côte vers l'ouest jusqu'à la crique des gobelins ; Lolo monte la garde sur les rochers au-dessus.",

	-- Step 24: Phizzlethorpe
	["Phizzlethorpe"] = "Phizzlethorpe",
	["Escort the professor to the beach north of the cove and guard him while he works; naga attack in waves."] = "Escortez le professeur jusqu'à la plage au nord de la crique et protégez-le pendant qu'il travaille ; les nagas attaquent par vagues.",

	-- Step 26: The wrecks
	["The wrecks"] = "Les épaves",
	["The two wrecks lie in the bay west of the cove. The charts and logs are inside them; the gems lie on the sea floor around them. Daggerspine naga swim the whole bay."] = "Les deux épaves reposent dans la baie à l'ouest de la crique. Les cartes et les journaux sont à l'intérieur ; les gemmes gisent au fond de la mer autour. Des nagas Daguéchine nagent dans toute la baie.",

	-- Step 27: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["For {npc:2487} in {area:35}: keep it"] = "Pour {npc:2487} à {area:35} : gardez-la",

	-- Step 28: Quae
	-- {area:320} Refuge Pointe · {npc:2712} Quae · {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Ride back north-east past {area:320}; {npc:2712} and {npc:2713} camp in the hills north of {area:314}."] = "Retournez au nord-est au-delà de {area:320} ; {npc:2712} et {npc:2713} campent dans les collines au nord de {area:314}.",

	-- Step 29: Forsaken Courier
	-- {area:314} Go'Shek Farm
	["The courier walks the road west of {area:314} with two guards; pull them off the road."] = "Le coursier parcourt la route à l'ouest de {area:314} avec deux gardes ; attirez-les hors de la route.",

	-- Step 30: Quae and Kinelory
	-- {npc:2712} Quae · {npc:2713} Kinelory
	["{npc:2712} and {npc:2713}"] = "{npc:2712} et {npc:2713}",

	-- Step 31: Kinelory's errand
	-- {npc:2713} Kinelory
	["{npc:2713}'s errand"] = "La mission de {npc:2713}",
	-- {npc:2713} Kinelory · {area:314} Go'Shek Farm
	["Stay with {npc:2713} while she sneaks into {area:314} and back; Horde orcs jump you on the way."] = "Restez avec {npc:2713} pendant qu'elle s'infiltre dans {area:314} et revient ; des orcs de la Horde vous attaquent en chemin.",

	-- Step 32: Quae
	-- {npc:2711} Phin Odelic · {area:271} Southshore
	["For {npc:2711} in {area:271}"] = "Pour {npc:2711} à {area:271}",

	-- Step 33: Shards of Myzrael
	-- {area:314} Go'Shek Farm · {area:333} Circle of East Binding
	["Head north past {area:314}; the shards glitter on the hill by the {area:333}."] = "Allez au nord au-delà de {area:314} ; les éclats scintillent sur la colline près de {area:333}.",
	["Only if Gluggle gave you the pendant in Stranglethorn"] = "Seulement si Gluggle vous a donné le pendentif à Strangleronce",

	-- Step 34: Drywhisker Gorge
	-- {area:321} Hammerfall
	["The Drywhisker kobolds dig in the gorge east of {area:321} (Horde); skirt the town to the north. They drop both the motes and Krazek's ore."] = "Les kobolds Sèche-moustache creusent dans la gorge à l'est de {area:321} (Horde) ; contournez la ville par le nord. Ils laissent tomber les particules et le minerai de Krazek.",

	-- Step 35: Iridescent Shards
	-- {area:318} Drywhisker Gorge
	["The shards lie at the far end of {area:318}."] = "Les éclats se trouvent au fond de {area:318}.",

	-- Step 36: Witherbark Village
	-- {area:314} Go'Shek Farm
	["The Witherbark trolls live in the hills south of {area:314}; Witch Doctors stand in the village, Shadow Hunters guard the far end of the valley."] = "Les trolls Witherbark vivent dans les collines au sud de {area:314} ; les Sorciers-docteurs se tiennent dans le village, les Chasseurs des ombres gardent le fond de la vallée.",

	-- Step 37: Stones of Binding
	-- {area:320} Refuge Pointe · {object:2702} Stone of Inner Binding
	["Each key lies at one of the Highlands' standing-stone circles: east of the shards, near {area:320} and in the west. The {object:2702} stands west of {area:320}."] = "Chaque clé se trouve à l'un des cercles de pierres levées des Hautes-terres : à l'est des éclats, près de {area:320} et à l'ouest. La {object:2702} se dresse à l'ouest de {area:320}.",

	-- Step 39: Kor'gresh Coldrage
	-- {npc:2793} Kor'gresh Coldrage
	["{npc:2793}, an ogre mage, holds the cave at the southern end of the Witherbark valley."] = "{npc:2793}, un mage ogre, occupe la grotte à l'extrémité sud de la vallée des Witherbark.",

	-- Step 41: Alterac Mountains
	-- {area:271} Southshore · {area:280} Strahnbrad · {npc:2306} Baron Vardus
	["Follow the road north out of {area:271} into the mountains. Mountain lions roam the slopes; the Syndicate in {area:280} wear the signet rings, and {npc:2306} walks the manor grounds on the north side of town."] = "Suivez la route vers le nord hors d'{area:271} jusque dans les montagnes. Des lions des montagnes parcourent les pentes ; les membres du Syndicat de {area:280} portent les chevalières, et {npc:2306} arpente le domaine du manoir au nord de la ville.",

	-- Step 42: Crushridge ogres
	["Crushridge ogres"] = "Ogres Cassecrête",
	-- {area:280} Strahnbrad · {item:3706} Ensorcelled Parchment · {npc:2320} Nagaz · {quest:537} Dark Council
	["The Crushridge ogres hold the hills north of {area:280}. Farther north, a worn wooden chest holds the {item:3706}; {npc:2320} of the {quest:537} stands right by it."] = "Les ogres Cassecrête tiennent les collines au nord de {area:280}. Plus au nord, un vieux coffre en bois contient le {item:3706} ; {npc:2320}, du {quest:537}, se tient juste à côté.",

	-- Step 43: Ruins of Alterac
	-- {area:280} Strahnbrad
	-- plural, as words: Argus Shadow Mages = {npc:2318} Argus Shadow Mage
	["The tomes lie in the ruined keep west of {area:280}; Argus Shadow Mages hold the ruins."] = "Les tomes se trouvent dans le donjon en ruine à l'ouest de {area:280} ; des Mages de l'ombre d'Argus occupent les ruines.",

	-- Step 44: Dalaran
	-- {area:279} Dalaran · {zone:1421} Silverpine Forest · {npc:269127} Image of Archmage Modera
	["South-west to the Kirin Tor camp on the lake shore west of {area:279}, just over the border into {zone:1421}: the {npc:269127} stands there. Archmage Ansirem stands south-east of it, by the dome."] = "Allez au sud-ouest jusqu'au camp du Kirin Tor sur la rive du lac, à l'ouest de {area:279}, juste après la frontière de {zone:1421} : {npc:269127} s'y tient. L'archimage Ansirem se tient au sud-est, près du dôme.",
	-- {npc:2542} Catelyn the Blade · {area:35} Booty Bay
	["For {npc:2542} in {area:35}: keep it"] = "Pour {npc:2542} à {area:35} : gardez-la",
	-- {npc:252085} Archmage Celindra
	["{npc:252085}, in the City of Dalaran"] = "{npc:252085}, dans la Cité de Dalaran",

	-- Step 45: Southshore
	-- {item:2321} Fine Thread · {npc:2438} Bartolo Ginsetti · {npc:2381} Micha Yance
	["{item:2321} for {npc:2438}'s cloak, from {npc:2381}, if you have none"] = "{item:2321} pour la cape de {npc:2438}, chez {npc:2381}, si vous n'en avez pas",
	-- {npc:1440} Milton Sheaf · {zone:1453} Stormwind
	["For {npc:1440} in {zone:1453}: keep it"] = "Pour {npc:1440} à {zone:1453} : gardez-la",

	-- Step 47: Thelsamar
	-- {zone:1455} Ironforge · {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["From {zone:1455} take the tunnel east through {zone:1426} into {zone:1432} and follow the road to {area:144}."] = "Depuis {zone:1455}, prenez le tunnel vers l'est à travers {zone:1426} jusqu'au {zone:1432} et suivez la route jusqu'à {area:144}.",

	-- Step 48: Ironband's Excavation Site
	["South-east along the loch to the dig site."] = "Longez le loch vers le sud-est jusqu'au site de fouilles.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road north to the draenei of the {area:657}."] = "Suivez la route vers le nord jusqu'aux draeneï de {area:657}.",
	-- ["Summon Succubus"] = "Invoquez la succube",
}
