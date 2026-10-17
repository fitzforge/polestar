-- French (frFR): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ironforge
	-- {area:150} Menethil Harbor · {area:1537} Ironforge
	["Fly from {area:150} to {area:1537} and train."] = "Prenez un vol de {area:150} pour {area:1537} et entraînez-vous.",

	-- Step 2: Druid training
	["Druid training"] = "Entraînement de druide",
	-- {area:1537} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} n'a pas de maître des druides : prenez le {area:2257} depuis {object:171524} jusqu'à {zone:1453} et entraînez-vous auprès de {npc:5504}.",

	-- Step 3: Darkshire
	-- {area:42} Darkshire · {npc:1573} Gryth Thurden · {area:1537} Ironforge · {object:32372} Great Forge · {npc:352} Dungar Longdrink · {zone:1453} Stormwind · {object:2096} Trade District
	["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Prenez un vol pour {area:42} : {npc:1573} dans {object:32372} de {area:1537}, ou {npc:352} dans {object:2096} de {zone:1453}.",

	-- Step 4: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Depuis {zone:1431}, prenez la route vers le sud jusqu'à Strangleronce ; les tentes des chasseurs se trouvent juste à l'ouest de la route, après l'embranchement de {area:99}.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, depuis {zone:1441}",

	-- Step 5: Young tigers and panthers
	["Young tigers and panthers"] = "Jeunes tigres et panthères",
	["Both roam the grass around the camp and along the road north."] = "Les deux parcourent l'herbe autour du camp et le long de la route vers le nord.",

	-- Step 7: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Tigres de Strangleronce",
	["The adult tigers prowl the hills just south and west of the camp."] = "Les tigres adultes rôdent dans les collines juste au sud et à l'ouest du camp.",

	-- Step 8: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Les anciens tigres viendront plus tard, au retour de {area:99}",

	-- Step 9: Rebel Camp
	-- {npc:738} Private Thorsen
	["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Prenez la route vers le nord ; {npc:738} s'y tient, le camp se trouve dans les collines à l'ouest.",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, dans la hutte",

	-- Step 10: Kurzen's Compound
	-- {area:99} Rebel Camp
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Les rebelles de Kurzen tiennent le camp à l'est de {area:99} ; restez sur son pourtour, où se tiennent les Guerriers de la jungle et les Guérisseurs, et fouillez les caisses de ravitaillement près des tentes.",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, dans une caisse de {object:263}",

	-- Step 11: Bookie Herod
	["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Les registres de Herod se trouvent dans une hutte du côté ouest de la base ; son coffre est plus à l'est, près de l'entrée de la grotte.",

	-- Step 13: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Panthères, raptors et anciens tigres",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "Revenez vers le sud après Nesingwary : les Panthères et les Raptors de Strangleronce courent dans les clairières à l'ouest du camp vers la côte ; les anciens tigres tiennent les collines au sud-ouest.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Gluggle, un murloc rare sur la côte à l'ouest du camp, laisse tomber le {item:4614} : prenez-le si vous le croisez",

	-- Step 15: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729} et les raptors flagellants",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, le grand tigre, a son repaire au sommet de la colline au sud-ouest du camp ; les Raptors flagellants courent au sud, sur le chemin de {area:35}.",

	-- Step 16: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "Descente vers {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Suivez la route principale vers le sud sur toute la longueur de la jungle, après l'embranchement de {object:3202}, jusqu'à {area:35}, sur le cap sud.",
	["Gyll, on the top floor by the docks"] = "Gyll, au dernier étage près des quais",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}"] = "{npc:2832}, à la {object:56910}",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank"] = "{npc:2495}, près de la banque",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern"] = "{npc:773}, dans la taverne",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, dans la taverne",

	-- Step 17: Crystalvein Mine
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Revenez vers le nord ; {area:310} se trouve à l'ouest de la route, au milieu de la jungle. Les Basilics de cristal qui s'y trouvent laissent tomber les éclats.",

	-- Step 18: Bloodscalp trolls
	["Bloodscalp trolls"] = "Trolls Bloodscalp",
	["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Les trolls Bloodscalp tiennent les ruines sur la côte à l'ouest du camp de Nesingwary.",

	-- Step 19: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201} : faites simplement le tour du camp des chasseurs",

	-- Step 20: Private Thorsen
	-- {area:99} Rebel Camp
	["Thorsen patrols the road north of camp, toward the {area:99}."] = "Thorsen patrouille sur la route au nord du camp, vers {area:99}.",

	-- Step 21: River crocolisks
	["River crocolisks"] = "Crocilisques des rivières",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "Les Crocilisques des rivières nagent dans la rivière près de {area:99}.",

	-- Step 23: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Crocilisques Gueule d'acier",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Les Crocilisques Gueule d'acier se prélassent sur le rivage et les îles le long de la côte au nord de {area:35}.",

	-- Step 24: Booty Bay
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, à l'étage de la taverne",

	-- Step 25: The haunted island
	["The haunted island"] = "L'île hantée",
	["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Suivez la côte ouest vers le nord ; l'île hantée se trouve au large, à l'ouest du camp de Nesingwary. Il suffit de l'atteindre.",

	-- Step 26: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} collectionne {item:2755} : les pages tombent de presque tous les humanoïdes de la jungle. Assemblez les pages en chapitres au fur et à mesure.",

	-- Step 28: Kurzen's Compound
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Les Réducteurs de tête se tiennent plus loin dans la base ; les Commandos rôdent camouflés autour et dans la grotte. Ramassez les pages des Vertes collines quand elles tombent.",

	-- Step 29: The jungle ruins
	["The jungle ruins"] = "Les ruines de la jungle",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Faites le tour des ruines trolls du nord et du centre : chacune abrite une tablette de pierre des légendes trolls. Les Panthères Ombregueule rôdent camouflées dans la jungle autour ; le camp de la KapitalRisk sur {area:37} porte les Cristaux réduits.",
	-- {quest:207} Kurzen's Mystery
	["{quest:207}: four troll legends"] = "{quest:207} : quatre légendes trolls",

	-- Step 30: Rebel Camp
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770} : pour {npc:773} à {area:35}",

	-- Step 32: Skullsplitter trolls
	["Skullsplitter trolls"] = "Trolls Skullsplitter",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Les trolls Skullsplitter tiennent les ruines à l'est de la route entre Nesingwary et {object:3202}.",

	-- Step 34: Booty Bay
	-- {zone:1417} Arathi Highlands
	["The ore drops from Drywhisker kobolds in {zone:1417}"] = "Le minerai tombe des kobolds Sèche-moustache des {zone:1417}",

	-- Step 36: Baron Revilgaz
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Pour l'archimage Ansirem dans {zone:1416}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, à {object:56910}",
}
