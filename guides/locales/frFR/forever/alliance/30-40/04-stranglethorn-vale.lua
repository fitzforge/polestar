-- French (frFR): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Prendre un vol pour {area:42}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Maître de vol du {area:150}",

	-- Step 3: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "Depuis {zone:1431}, prenez la route vers le sud jusqu'à Strangleronce ; les tentes des chasseurs se trouvent juste à l'ouest de la route, après l'embranchement de {area:99}.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, depuis {zone:1441}",

	-- Step 4: Young tigers and panthers
	["Young tigers and panthers"] = "Jeunes tigres et panthères",
	["Both roam the grass around the camp and along the road north."] = "Les deux parcourent l'herbe autour du camp et le long de la route vers le nord.",

	-- Step 8: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Tigres de Strangleronce",
	["The adult tigers prowl the hills just south and west of the camp."] = "Les tigres adultes rôdent dans les collines juste au sud et à l'ouest du camp.",

	-- Step 9: Level 33.2
	["Level 33.2"] = "",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["The jungle's quests climb to 37 from here: short of 33.2? Keep on the Stranglethorn Tigers in the hills just south and west of the camp until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "",
	-- {npc:682} Stranglethorn Tiger
	["grind on {npc:682}"] = "",

	-- Step 10: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Les anciens tigres viendront plus tard, au retour de {area:99}",

	-- Step 11: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Panthères, raptors et anciens tigres",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "Revenez vers le sud après Nesingwary : les Panthères et les Raptors de Strangleronce courent dans les clairières à l'ouest du camp vers la côte ; les anciens tigres tiennent les collines au sud-ouest.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Gluggle, un murloc rare sur la côte à l'ouest du camp, laisse tomber le {item:4614} : prenez-le si vous le croisez",

	-- Step 12: Sir S. J. Erlgadin
	-- {area:99} Rebel Camp
	["Back east to Nesingwary's camp on the way north to the {area:99}."] = "",

	-- Step 13: Rebel Camp
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["Take the road north; the camp sits in the hills to the west.\n{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, dans la hutte",
	-- {npc:469} Lieutenant Doren · {quest:200} Bookie Herod · {area:101} Kurzen's Compound
	["{npc:469}: {quest:200}'s records lie at the edge of {area:101}, next"] = "",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}, later in this guide"] = "",

	-- Step 14: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "{area:101} : tuez-les au passage",
	-- {area:99} Rebel Camp · {quest:200} Bookie Herod
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents. {quest:200}'s records lie in a hut on the compound's west side."] = "",
	-- {object:287} Bookie Herod's Records
	["{object:287}, in the hut"] = "",
	["The strongbox is deeper in, by the cave: on the northern loop (04b)"] = "",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, dans une caisse de {object:263}",

	-- Step 15: Level 33.6
	["Level 33.6"] = "",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Kurzen Jungle Fighters = {npc:937} Kurzen Jungle Fighter
	["Short of 33.6? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.6. Or, with a group, run the {area:796} dungeon (Library) instead."] = "",
	-- {npc:937} Kurzen Jungle Fighter
	["grind on {npc:937}"] = "",

	-- Step 17: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434} : tuez-les au passage",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "Attention : des camps de trolls sont proches du territoire des tigres, et les trolls peuvent se joindre au combat si vous attirez sans précaution.\nAttention : le nid des raptors abrite de jeunes raptors qui se joignent au combat quand vous attaquez les adultes.",

	-- Step 18: Level 34
	["Level 34"] = "",
	-- {area:796} Scarlet Monastery
	["The quests from here on are 37: if you are short of 34, keep on the elder tigers in the hills south-west of Nesingwary's camp until level 34. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "",
	-- {npc:1085} Elder Stranglethorn Tiger
	["grind on {npc:1085}"] = "",

	-- Step 19: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} collectionne {item:2755} : les pages tombent de presque tous les humanoïdes de la jungle. Assemblez les pages en chapitres au fur et à mesure.",

	-- Step 20: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729} et les raptors flagellants",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, le grand tigre, a son repaire au sommet de la colline au sud-ouest du camp ; les Raptors flagellants courent au sud, sur le chemin de {area:35}.",

	-- Step 21: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "Descente vers {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Suivez la route principale vers le sud sur toute la longueur de la jungle, après l'embranchement de {object:3202}, jusqu'à {area:35}, sur le cap sud.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "{npc:2495}, près de la banque ; à l'intérieur",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, à l'intérieur",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern
	["{npc:6807}, {object:56910}; upstairs"] = "{npc:6807}, {object:56910} ; à l'étage",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern
	["{npc:2832}, in the {object:56910}; upstairs"] = "{npc:2832}, dans {object:56910} ; à l'étage",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern; upstairs"] = "{npc:773}, dans la taverne ; à l'étage",
	-- {npc:773} Krazek · {npc:770} Corporal Kaleb
	["{npc:773}, from {npc:770}"] = "",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, dans la taverne",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals, on the northern loop"] = "",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, à l'étage de la taverne",

	-- Step 22: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "Prendre un vol pour {area:108}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Maître de vol de {area:35}",

	-- Step 24: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301} : tuez-les au passage",
	-- {area:108} Sentinel Hill · {zone:1436} Westfall · {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach it. The Bloodscalp trolls hold the ruins on the coast to the north."] = "",
	["The haunted island"] = "L'île hantée",

	-- Step 25: River crocolisks
	["River crocolisks"] = "Crocilisques des rivières",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "Les Crocilisques des rivières nagent dans la rivière près de {area:99}.",

	-- Step 26: Private Thorsen
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "",

	-- Step 27: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201} : faites simplement le tour du camp des chasseurs",

	-- Step 28: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, à l'intérieur",
	-- {npc:2495} Drizzlik
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{npc:2495}: the Snapjaw Crocolisks, on the northern loop"] = "",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, à l'étage",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, à l'étage",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}: the water elementals rise around the haunted island, on the northern loop"] = "",

	-- Step 29: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Prendre un vol pour {zone:1453}",

	-- Step 31: Collin Mauren
	-- {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:4078} is in the {object:2164}, in the {object:2101}."] = "",

	-- Step 32: Druid training
	["Druid training"] = "Entraînement de druide",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{npc:5504}, the druid trainer, stands in {zone:1453}, north-west of the {object:2101}."] = "",

	-- Step 34: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Prendre un vol pour {area:415}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maître de vol d'{area:442}",

	-- Step 35: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then take the road west to Stonetalon."] = "",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, au nord de {area:413}",

	-- Step 36: Stonetalon Mountains
	-- {area:608} Nijel's Point
	["The road to {area:608}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["\"Sea Wolf\" MacKinley, on the top floor"] = "« Loup de mer » MacKinley, au dernier étage",
	-- ["Bloodscalp trolls"] = "Trolls Bloodscalp",
	-- ["Fly from {area:150} to {area:1537} and train."] = "Prenez un vol de {area:150} pour {area:1537} et entraînez-vous.",
	-- ["Fly to {area:35}"] = "Prendre un vol pour {area:35}",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Prenez un vol pour {area:42} : {npc:1573} dans {object:32372} de {area:1537}, ou {npc:352} dans {object:2096} de {zone:1453}.",
	-- ["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Suivez la côte ouest vers le nord ; l'île hantée se trouve au large, à l'ouest du camp de Nesingwary. Il suffit de l'atteindre.",
	-- ["For Archmage Ansirem in {zone:1416}"] = "Pour l'archimage Ansirem dans {zone:1416}",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Les Réducteurs de tête se tiennent plus loin dans la base ; les Commandos rôdent camouflés autour et dans la grotte. Ramassez les pages des Vertes collines quand elles tombent.",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "Des Réducteurs de têtes se tiennent au fond du camp ; les Commandos rôdent, camouflés, autour et dans la grotte. Ramassez les pages des Vertes collines quand elles tombent.\nAttention : les Commandos de Kurzen sont de niveau 34-35, non élites, et apparaissent souvent camouflés ; près de la mort, ils utilisent {spell:7964}.",
	-- ["Hearth to {area:35}"] = "Pierre de foyer vers {area:35}",
	-- ["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Les registres de Herod se trouvent dans une hutte du côté ouest de la base ; son coffre est plus à l'est, près de l'entrée de la grotte.",
	-- ["Into {area:33}"] = "Vers la {area:33}",
	-- ["Into {area:40}"] = "Vers {area:40}",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Faites le tour des ruines trolls du nord et du centre : chacune abrite une tablette de pierre des légendes trolls. Les Panthères Ombregueule rôdent camouflées dans la jungle autour ; le camp de la KapitalRisk sur {area:37} porte les Cristaux réduits.",
	-- ["Skullsplitter trolls"] = "Trolls Skullsplitter",
	-- ["Snapjaw Crocolisks"] = "Crocilisques Gueule d'acier",
	-- ["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Les Crocilisques Gueule d'acier se prélassent sur le rivage et les îles le long de la côte au nord de {area:35}.",
	-- ["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Prenez la route vers le nord ; {npc:738} y patrouille, le camp se trouve dans les collines à l'ouest.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Prenez la route vers le nord ; {npc:738} s'y tient, le camp se trouve dans les collines à l'ouest.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Les trolls Bloodscalp tiennent les ruines sur la côte à l'ouest du camp de Nesingwary.",
	-- ["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Les rebelles de Kurzen tiennent le camp à l'est de {area:99} ; restez sur son pourtour, où se tiennent les Guerriers de la jungle et les Guérisseurs, et fouillez les caisses de ravitaillement près des tentes.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Les trolls Skullsplitter tiennent les ruines à l'est de la route entre Nesingwary et {object:3202}.",
	-- ["The jungle ruins"] = "Les ruines de la jungle",
	-- ["The ore drops from Drywhisker kobolds in {zone:1417}"] = "Le minerai tombe des kobolds Sèche-moustache des {zone:1417}",
	-- ["Thorsen patrols the road north of camp, toward the {area:99}."] = "Thorsen patrouille sur la route au nord du camp, vers {area:99}.",
	-- ["Tram to {zone:1453}"] = "Tram pour {zone:1453}",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Revenez vers le nord ; {area:310} se trouve à l'ouest de la route, au milieu de la jungle. Les Basilics de cristal qui s'y trouvent laissent tomber les éclats.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards.\nThe Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Repartez vers le nord ; la {area:310} se trouve à l'ouest de la route, au milieu de la jungle. Les Basilics de cristal qui s'y trouvent lâchent les éclats.\nLes trolls Bloodscalp tiennent les ruines sur la côte à l'ouest du camp de Nesingwary.",
	-- ["grind on {npc:1096}"] = "tuez en boucle : {npc:1096}",
	-- ["{area:108} flight master"] = "Maître de vol de {area:108}",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} n'a pas de maître des druides : prenez le {area:2257} depuis {object:171524} jusqu'à {zone:1453} et entraînez-vous auprès de {npc:5504}.",
	-- ["{area:33}: kill these as you meet them"] = "{area:33} : tuez-les au passage",
	-- ["{item:2006}: {object:58}; underwater"] = "{item:2006} : {object:58} ; sous l'eau",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}, près de la banque",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, à la {object:56910}",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}, au dernier étage près des quais",
	-- ["{npc:684} on the way"] = "{npc:684} en chemin",
	-- ["{npc:687} on the way"] = "{npc:687} en chemin",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770} : pour {npc:773} à {area:35}",
	-- ["{npc:773}, in the tavern"] = "{npc:773}, dans la taverne",
	-- ["{npc:941}, below ground"] = "{npc:941}, sous terre",
	-- ["{object:287}, upstairs"] = "{object:287}, à l'étage",
	-- ["{object:288}, below ground"] = "{object:288}, sous terre",
	-- ["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} est le grand bâtiment qui domine le port ; la plupart des donneurs de quêtes se trouvent à ses étages ou sur les quais en contrebas.",
	-- ["{quest:207}: four troll legends"] = "{quest:207} : quatre légendes trolls",
	-- ["{zone:1455} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{zone:1455} n'a pas de maître des druides : prenez le {area:2257} depuis {object:171524} jusqu'à {zone:1453} et entraînez-vous auprès de {npc:5504}.",
}
