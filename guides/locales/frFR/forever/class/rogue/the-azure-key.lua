-- French (frFR): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Classic's item choice may be gone on Forever."] = "Réputation auprès de Ravenholdt et expérience au niveau 50 ; le choix d'objet de Classic a peut-être disparu sur Forever.",
	["Ravenholdt reputation"] = "Réputation Ravenholdt",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (Alliance)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} in {zone:1455}."] = "Au niveau 50, {npc:918}, dans la {object:2100} de {zone:1453}, la propose ; tout comme Syurna à {zone:1457} et {npc:5165} à {zone:1455}.",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (Horde)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "Au niveau 50, {npc:3328}, dans {object:172960}, la propose ; {npc:4583}, dans {object:36073} de {zone:1458}, aussi.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {zone:1416} Alterac Mountains
	["{area:3486} hides in the hills east of {area:272}. Horde fly to {area:272}, Alliance to {area:271}. The trail starts behind the plateau north of {area:275}, climbs into the hills and runs through a small tunnel into the {zone:1416}; Lord Jorach is inside the manor. Do not attack anyone at the manor: lost Ravenholdt reputation makes him refuse to speak to you."] = "Le {area:3486} se cache dans les collines à l'est de {area:272}. Horde : volez jusqu'à {area:272} ; Alliance : jusqu'à {area:271}. Le sentier part derrière le plateau au nord du {area:275}, grimpe dans les collines et passe par un petit tunnel jusque dans les {zone:1416} ; le seigneur Jorach est à l'intérieur du manoir. N'attaquez personne au manoir : une perte de réputation auprès de Ravenholdt le pousse à refuser de vous parler.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara · {spell:921} Pick Pocket · {area:1769} Timbermaw Hold · {spell:403} Lightning Bolt · {spell:6535} Lightning Cloud
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. Only the level 50-51 Timbermaw Shamans in the furbolg hills of northern {zone:1447} carry the bag (the level 47-49 furbolgs further south do not): about one kill in thirty drops it. {spell:921} them instead and you lose no Timbermaw reputation; if you are Unfriendly or better with {area:1769}, mark them At War in your reputation panel first. They cast {spell:403} and {spell:6535}, heal each other and run at low health."] = "Alliance : volez jusqu'à {area:3137} ; Horde : jusqu'à {area:1237}. Seuls les Chamans Grumegueule de niveau 50-51, dans les collines des furbolgs du nord d'{zone:1447}, portent le sac (les furbolgs de niveau 47-49 plus au sud ne l'ont pas) : environ une victime sur trente le laisse tomber. Utilisez plutôt {spell:921} sur eux et vous ne perdez aucune réputation auprès des Grumegueules ; si vous êtes Inamical ou mieux avec le {area:1769}, cochez d'abord En guerre dans votre fenêtre de réputation. Ils lancent {spell:403} et {spell:6535}, se soignent entre eux et fuient quand leur vie est basse.",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo · {area:1237} Valormok
	["{npc:8395}, camped below the cliffs just east of {area:1237}, teleports you up (dismount first); a trail leads to Xylem's tower."] = "{npc:8395}, qui campe au pied des falaises juste à l'est de {area:1237}, vous téléporte en haut (descendez d'abord de monture) ; un sentier mène à la tour de Xylem.",

	-- Step 6: Encoded Fragments
	-- {spell:6907} Diseased Slime · {area:2497} Bitter Reaches · {zone:1447} Azshara · {area:1237} Valormok
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze · Mistwing Ravagers = {npc:8764} Mistwing Ravager
	["The Forest Oozes (level 52-53, {spell:6907} up close) drop a fragment four times in five: the biggest group, seven of them, is in the {area:2497} hills of north-eastern {zone:1447}, four more south-east of {area:1237}. Pick their pockets before the kill for an extra fragment or two. Killing the Mistwing Ravagers and hippogryphs that share their spots makes more oozes appear."] = "Les Limons forestiers (niveau 52-53, {spell:6907} au corps à corps) laissent tomber un fragment quatre fois sur cinq : le plus grand groupe, sept d'entre eux, se trouve dans les collines des {area:2497}, au nord-est d'{zone:1447}, et quatre autres au sud-est de {area:1237}. Faites-leur les poches avant de les tuer pour un fragment ou deux de plus. Tuer les Ravageurs Brumaile et les hippogryphes qui partagent leurs emplacements fait apparaître davantage de limons.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "Retour auprès de Xylem",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz dans {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:2094} Blind
	["Morphaz, a level 52 elite green drake, lives deep in the {area:1417}: a group of five, level 50-54. The temple stands in the {area:74}; climb into the sunken building, swim down through it and follow the passage to the portal. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on. He is not there when you arrive: first kill the six troll guardians (elites of 50-52) on the platforms around the upper ring, which opens the way down (the left-hand ramp from the entrance) to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe; when both are dead, Morphaz and Hazzas appear together and fight as a pair. Their {spell:12533} is nature damage: nature protection potions help; poisons and {spell:2094} do not work on them. The key always drops. Hunters, Priests and Mages of 50 need Morphaz too: one clear serves them all."] = "Morphaz, un drake vert élite de niveau 52, vit au fond du {area:1417} : un groupe de cinq, niveau 50-54. Le temple se dresse dans l'{area:74} ; montez dans le bâtiment englouti, plongez à travers et suivez le passage jusqu'au portail. Horde : volez jusqu'à {area:75} ; Alliance : volez jusqu'au {area:1438} et continuez à monture. Il n'est pas là à votre arrivée : tuez d'abord les six gardiens trolls (élites de niveau 50-52) sur les plates-formes autour de l'anneau supérieur, ce qui ouvre la descente (la rampe de gauche depuis l'entrée) vers {npc:5710} dans la Fosse du sacrifice. La mort de Jammal'an fait sortir deux drakes, Tisserand et Fauche-rêve ; quand les deux sont morts, Morphaz et Hazzas apparaissent ensemble et combattent en duo. Leur {spell:12533} inflige des dégâts de nature : les potions de protection contre la nature aident ; les poisons et {spell:2094} ne fonctionnent pas sur eux. La clé tombe toujours. Les chasseurs, prêtres et mages de niveau 50 ont aussi besoin de Morphaz : une seule expédition sert à tous.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022} : Morphaz, dans le temple",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "Seigneur Ravenholdt",
	-- {item:19982} Duskbat Drape · {item:19984} Ebon Mask · {item:20255} Whisperwalk Boots
	["Look at the reward window before you hand in: Classic offered the {item:19982}, the {item:19984} or the {item:20255}, and Forever's notes say the choice may be gone."] = "Regardez la fenêtre des récompenses avant de rendre la quête : Classic proposait le {item:19982}, le {item:19984} ou les {item:20255}, et les notes de Forever disent que ce choix a peut-être disparu.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "L'Alliance prend un vol pour {area:3137}, la Horde pour {area:1237}. Les Chamans Grumegueule des collines du nord d'{zone:1447} laissent tomber le sac, environ une fois sur trente.",
	-- ["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "Au niveau 50, {npc:918}, dans {object:2100} de {zone:1453}, la propose ; Syurna à {zone:1457}, {npc:5165} et Fenthwick à {zone:1455} aussi.",
	-- ["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "Morphaz, un drake vert, est un boss élite au fond de {area:1417}, un donjon de niveau 50 : venez en groupe de cinq. Le temple se dresse dans {area:74} ; nagez jusqu'à l'entrée au fond. Horde : prenez un vol pour {area:75} ; Alliance : prenez un vol pour {area:1438} et continuez à cheval.",
	-- ["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "Réputation Ravenholdt et expérience au niveau 50 ; Forever a retiré le choix d'objet de Classic.",
	-- ["The Forest Oozes of southern {zone:1447} drop the fragments."] = "Les Limons forestiers du sud d'{zone:1447} laissent tomber les fragments.",
	-- ["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486} se cache dans les collines à l'est de {area:272}, au bout d'un chemin qui monte dans {zone:1416}. La Horde prend un vol pour {area:272}, l'Alliance pour {area:271}.",
	-- ["{npc:6768}: no item choices in Forever"] = "{npc:6768} : pas de choix d'objet dans Forever",
}
