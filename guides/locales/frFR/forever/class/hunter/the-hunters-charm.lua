-- French (frFR): the guide forever/class/hunter/the-hunters-charm (forever/class/hunter/the-hunters-charm.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1447} Azshara · {area:1417} Sunken Temple
	["Experience at 50 through {zone:1447} and the {area:1417}; Classic's item choice may be gone on Forever."] = "De l'expérience au niveau 50 via {zone:1447} et {area:1417} ; le choix d'objet de Classic a peut-être disparu sur Forever.",
	["Experience"] = "Expérience",

	-- Step 1: The Hunter's Charm (Alliance)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Alliance)"] = "{quest:8151} (Alliance)",
	-- {npc:5516} Ulfir Ironbeard · {zone:1453} Stormwind · {object:28027} Dwarven District · {npc:5116} Olmin Burningbeard · {zone:1455} Ironforge · {object:32390} Hall of Arms (no name in this language: may be words) · {zone:1457} Darnassus
	["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' Cenarion Enclave."] = "Au niveau 50, tout maître des chasseurs de l'Alliance la propose : {npc:5516} dans {object:28027} de {zone:1453}, {npc:5116} dans {object:32390} d'{zone:1455} ou Dorion à l'Enclave cénarienne de {zone:1457}.",

	-- Step 2: The Hunter's Charm (Horde)
	-- {quest:8151} The Hunter's Charm
	["{quest:8151} (Horde)"] = "{quest:8151} (Horde)",
	-- {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {object:172958} Valley of Honor · {npc:3039} Holt Thunderhorn · {area:1641} Hunter Rise · {zone:1456} Thunder Bluff
	["At 50 any Horde hunter trainer offers it: {npc:3352} in {zone:1454}'s {object:172958} or {npc:3039} on {area:1641} in {zone:1456}."] = "Au niveau 50, tout maître des chasseurs de la Horde la propose : {npc:3352} dans {object:172958} d'{zone:1454} ou {npc:3039} sur {area:1641}, aux {zone:1456}.",

	-- Step 3: Ogtinc
	-- {npc:8405} Ogtinc · {area:1221} Ruins of Eldarath · {zone:1447} Azshara · {area:3137} Talrendis Point · {area:1237} Valormok
	["{npc:8405} lives on a raised spot on the cliffs at the north-east rim of the {area:1221}, west-central {zone:1447}. Keep to the high ridges around the ruins: the pit below does not lead up to him. Alliance: fly to {area:3137}; Horde: fly to {area:1237}, a short ride west of him."] = "{npc:8405} vit sur un promontoire des falaises, au bord nord-est des {area:1221}, dans le centre-ouest d'{zone:1447}. Restez sur les crêtes qui entourent les ruines : la fosse en contrebas ne mène pas jusqu'à lui. Alliance : volez jusqu'à {area:3137} ; Horde : volez jusqu'à {area:1237}, à quelques pas de monture à l'ouest de lui.",

	-- Step 4: Courser Antlers
	-- {zone:1447} Azshara · {area:1220} Thalassian Base Camp · {area:1237} Valormok · {area:1234} Lake Mennar
	-- plural, as words: Perfect Courser Antlers = {item:20017} Perfect Courser Antler · Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["You need two Perfect Courser Antlers. Mosshoof Coursers (level 52-53, deer) graze all over {zone:1447} and drop one about one kill in twelve, so expect two dozen kills. Good herds: north of the {area:1220} in the north, and the hills north-east and south-east of {area:1237}; the {area:1234} area also has elite giants and dragonkin. They Enrage at 30% health. Coursers share spawn points with the Thunderhead hippogryphs: if none are around, kill the hippogryphs and coursers may spawn instead. Respawn is about five and a half minutes."] = "Il vous faut deux Ramures de coursier parfaites. Les Coursiers Sabots-de-mousse (niveau 52-53, cerfs) paissent partout en {zone:1447} et en laissent tomber une environ une fois sur douze : comptez deux douzaines de victimes. Bonnes hardes : au nord du {area:1220}, dans le nord, et les collines au nord-est et au sud-est de {area:1237} ; les environs du {area:1234} abritent aussi des géants et des draconiens élites. Ils deviennent enragés à 30 % de vie. Les coursiers partagent leurs points d'apparition avec les hippogryphes Tête-tonnerre : s'il n'y en a aucun, tuez les hippogryphes et des coursiers peuvent apparaître à leur place. Ils réapparaissent en cinq minutes et demie environ.",
	-- {item:20017} Perfect Courser Antler
	-- plural, as words: Mosshoof Coursers = {npc:8761} Mosshoof Courser
	["{item:20017}, from Mosshoof Coursers"] = "{item:20017}, sur les Coursiers Sabots-de-mousse",

	-- Step 6: Wavethrashing
	-- {item:20087} Wavethrasher Scales · {zone:1447} Azshara · {area:1229} Tower of Eldara · {spell:1494} Track Beasts
	-- plural, as words: Young Wavethrashers = {npc:6347} Young Wavethrasher · Great Wavethrashers = {npc:6349} Great Wavethrasher
	["You need six {item:20087}. Wavethrashers (three-headed sea beasts) live along {zone:1447}'s coasts, mostly underwater: the Young Wavethrashers (level 51-52) of the north-east shore drop a scale about one kill in three, the Wavethrashers (52-53) of the east coast by the {area:1229} about as often (a few walk the beach there), the Great Wavethrashers (53-54) of the south-east shore about one in seven. {spell:1494} does not show them; fight them where you can breathe, and bring water breathing if you can. Elite sharks swim the deeper water."] = "Il vous faut six {item:20087}. Les Vandales des flots (bêtes marines à trois têtes) vivent le long des côtes d'{zone:1447}, surtout sous l'eau : les Jeunes Vandales des flots (niveau 51-52) de la rive nord-est laissent tomber une écaille environ une fois sur trois, les Vandales des flots (52-53) de la côte est près de la {area:1229} à peu près aussi souvent (quelques-uns marchent sur la plage), les Grands Vandales des flots (53-54) de la rive sud-est environ une fois sur sept. {spell:1494} ne les montre pas ; combattez-les là où vous pouvez respirer, et emportez de quoi respirer sous l'eau si vous le pouvez. Des requins élites nagent en eau plus profonde.",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz dans {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {area:75} Stonard · {area:1438} Nethergarde Keep · {area:42} Darkshire · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:11019} Wing Flap
	["Morphaz is an elite green drake (level 52) inside the {area:1417}, a five-player dungeon: needs a group of five. The temple stands in the {area:74} in eastern {zone:1435}: climb its outer steps, dive into the flooded hall and follow the stairs down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} or {area:42} and ride on. He is not there when you arrive: first kill the six troll guardians on the platforms around the upper ring, which opens the way down to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe (pull them one at a time); when both are dead, Morphaz and Hazzas appear together and cannot be split. Clear the dragonkin around the pit first, because they call for help. Morphaz uses {spell:12533} and {spell:11019}. The tooth always drops. Warriors in the group may want the same run for the voodoo feathers of the balcony trolls."] = "Morphaz est un drake vert élite (niveau 52) dans {area:1417}, un donjon à cinq joueurs : il faut un groupe de cinq. Le temple se dresse dans {area:74}, dans l'est du {zone:1435} : montez ses marches extérieures, plongez dans la salle inondée et suivez l'escalier jusqu'à l'entrée. Horde : volez jusqu'à {area:75} ; Alliance : volez jusqu'à {area:1438} ou {area:42} et continuez à monture. Il n'est pas là à votre arrivée : tuez d'abord les six gardiens trolls sur les plates-formes autour de l'anneau supérieur, ce qui ouvre la descente vers {npc:5710} dans la Fosse du sacrifice. La mort de Jammal'an fait sortir deux drakes, Tisserand et Fauche-rêve (attirez-les un par un) ; quand les deux sont morts, Morphaz et Hazzas apparaissent ensemble et ne peuvent pas être séparés. Nettoyez d'abord les draconiens autour de la fosse, car ils appellent à l'aide. Morphaz utilise {spell:12533} et {spell:11019}. La dent tombe toujours. Les guerriers du groupe voudront peut-être la même expédition pour les plumes vaudou des trolls du balcon.",
	-- {item:20019} Tooth of Morphaz · {area:1417} Sunken Temple
	["{item:20019}, inside the {area:1417}"] = "{item:20019}, dans {area:1417}",

	-- Step 9: The Green Drake
	-- {item:19991} Devilsaur Eye · {item:19992} Devilsaur Tooth · {item:20083} Hunting Spear
	["In Classic Ogtinc let you choose the {item:19991}, the {item:19992} or the {item:20083} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "Dans Classic, Ogtinc vous laissait choisir ici l'{item:19991}, la {item:19992} ou la {item:20083}. Les notes de mise à jour de Forever disent que ce choix a disparu, mais la page de la quête liste toujours trois récompenses sans nom : regardez la fenêtre des récompenses avant de rendre la quête.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 any Alliance hunter trainer offers it: {npc:5516} in {zone:1453}'s {object:28027}, {npc:5116} in {zone:1455}'s {object:32390} or Dorion in {zone:1457}' {area:1658}."] = "Au niveau 50, tout maître des chasseurs de l'Alliance la propose : {npc:5516} dans {object:28027} de {zone:1453}, {npc:5116} dans {object:32390} de {zone:1455} ou Dorion dans {area:1658} de {zone:1457}.",
	-- ["Experience at 50 through {zone:1447} and the {area:1417}; Forever removed the Classic item choice."] = "De l'expérience au niveau 50 via {zone:1447} et {area:1417} ; Forever a supprimé le choix d'objet de Classic.",
	-- ["Morphaz is an elite dragon boss inside the {area:1417}, a five-player dungeon: bring a group. The temple stands in the middle of the {area:74}; swim down into it to reach the entrance. Horde: fly to {area:75}; Alliance: fly to {area:42} or {area:1438} and ride on."] = "Morphaz est un boss dragon élite dans {area:1417}, un donjon à cinq joueurs : venez en groupe. Le temple se dresse au milieu de {area:74} ; plongez pour atteindre l'entrée. Horde : volez jusqu'à {area:75} ; Alliance : volez jusqu'à {area:42} ou {area:1438} et continuez à monture.",
	-- ["Mosshoof Coursers graze all over {zone:1447}; one in a dozen or so drops a pair of Perfect Courser Antlers."] = "Des Coursiers Sabots-de-mousse ({npc:8761}) paissent partout en {zone:1447} ; environ un sur douze lâche une paire de Ramures de coursier parfaites ({item:20017}).",
	-- ["Wavethrashers crawl along {zone:1447}'s coasts: Young Wavethrashers on the north-east shore and Wavethrashers on the east coast drop the scales about twice as often as the Great Wavethrashers of the south shore."] = "Les Vandales des flots rampent le long des côtes d'{zone:1447} : les Jeunes Vandales des flots de la rive nord-est et les Vandales des flots de la côte est laissent tomber les écailles environ deux fois plus souvent que les Grands Vandales des flots de la rive sud.",
	-- ["{npc:8405} lives atop the cliffs north-east of the {area:1221}. Alliance: fly to {area:3137}; Horde: fly to {area:1237}."] = "{npc:8405} vit au sommet des falaises au nord-est des {area:1221}. Alliance : volez jusqu'à {area:3137} ; Horde : volez jusqu'à {area:1237}.",
}
