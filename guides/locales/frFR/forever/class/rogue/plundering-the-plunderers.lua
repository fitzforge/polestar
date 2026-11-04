-- French (frFR): the guide forever/class/rogue/plundering-the-plunderers (forever/class/rogue/plundering-the-plunderers.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7676} Thistle Tea
	["Ten {item:7676}, the rogue energy drink, from the Horde lockpicking jobs at 16."] = "Dix {item:7676}, la boisson d'énergie des voleurs, grâce aux missions de crochetage de la Horde au niveau 16.",

	-- Step 1: To Orgrimmar!
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {npc:3401} Shenthul · {zone:1454} Orgrimmar
	["At 16 {npc:3170}, the rogue trainer in {area:362}, sends you to {npc:3401} in {zone:1454}."] = "Au niveau 16, {npc:3170}, le maître des voleurs de {area:362}, vous envoie voir {npc:3401} à {zone:1454}.",

	-- Step 2: Find the Shattered Hand
	-- {npc:6467} Mennet Carkad · {object:36073} Rogues' Quarter · {npc:3401} Shenthul · {zone:1454} Orgrimmar · {quest:1998} Fenwick Thatros · {zone:1421} Silverpine Forest
	["At 16 {npc:6467} in the {object:36073} sends you to {npc:3401} in {zone:1454}. Take {quest:1998} from him too; it is done in {zone:1421} at the end of this guide."] = "Au niveau 16, {npc:6467}, dans {object:36073}, vous envoie voir {npc:3401} à {zone:1454}. Prenez aussi {quest:1998} auprès de lui ; elle se termine en {zone:1421} à la fin de ce guide.",

	-- Step 3: Shenthul and Zando'zan
	-- {npc:3401} Shenthul · {quest:2379} Zando'zan
	["{npc:3401} and {quest:2379}"] = "{npc:3401} et {quest:2379}",
	-- {zone:1458} Undercity · {zone:1411} Durotar · {npc:3401} Shenthul · {quest:2379} Zando'zan · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {spell:1804} Pick Lock
	["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}. Train {spell:1804} from {npc:3401} (or any rogue trainer) now if you lack it: this job is a lockpicking test."] = "Les morts-vivants prennent le zeppelin depuis les tours devant {zone:1458} jusqu'en {zone:1411}. {npc:3401} et {quest:2379} se tiennent dans {object:172960}, le canyon sous {object:172982}. Apprenez {spell:1804} auprès de {npc:3401} (ou de n'importe quel maître des voleurs) dès maintenant si vous ne l'avez pas : ce travail est une épreuve de crochetage.",

	-- Step 4: Wrenix the Wretched
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:7161} Wrenix the Wretched · {item:7970} E.C.A.C. · {item:5060} Thieves' Tools · {spell:1804} Pick Lock
	["Fly or walk to {area:392} on the {zone:1413} coast. {npc:7161} stands in a small shed near the bank, up the hill to the left before the docks. His Gizmotronic Apparatus beside him hands out what the job needs: take an {item:7970} and {item:5060} ({spell:1804} does not work without the tools in your bags)."] = "Volez ou marchez jusqu'à {area:392}, sur la côte des {zone:1413}. {npc:7161} se tient dans une petite cabane près de la banque, en haut de la colline à gauche avant les quais. Son appareil gizmotronique, à côté de lui, distribue ce dont le travail a besoin : prenez un {item:7970} et des {item:5060} ({spell:1804} ne fonctionne pas sans les outils dans vos sacs).",

	-- Step 5: Southsea Treasure
	-- {area:392} Ratchet · {object:123462} The Jewel of the Southsea (no name in this language: may be words) · {npc:7168} Polly · {item:7970} E.C.A.C. · {item:7968} Southsea Treasure
	["Follow the coast south from {area:392} to the first beached pirate ship, the Tide Razor, and climb aboard up its bow. On the middle deck the Buccaneer's Strongboxes come back fast: pick them until your Lockpicking is about 30 (a few are trapped with a frost nova or turn you into a rat; picking still works as a rat). Keep picking while they still give skill: the poisons job at 20 ends at a lockbox that needs about 75, and these boxes are the closest practice. Then go down to the bottom hold and pick the lock of {object:123462}: it is empty, but opening it calls a giant level 50 {npc:7168} into the next room. Stay stealthed, put the {item:7970} on your action bar, target {npc:7168} and use it: the parrot shrinks to level 18. Kill it for the {item:7968}."] = "Suivez la côte vers le sud depuis {area:392} jusqu'au premier navire pirate échoué, le Tide Razor, et montez à bord par la proue. Sur le pont du milieu, les Coffres du boucanier reviennent vite : crochetez-les jusqu'à environ 30 en Crochetage (quelques-uns sont piégés d'une nova de givre ou vous transforment en rat ; on peut toujours crocheter sous forme de rat). Continuez tant qu'ils font monter la compétence : le travail des poisons au niveau 20 se termine par un coffret qui demande environ 75, et ces coffres sont l'entraînement le plus proche. Descendez ensuite dans la cale du fond et crochetez la serrure du Joyau des mers du Sud : il est vide, mais l'ouvrir fait venir un {npc:7168} géant de niveau 50 dans la salle voisine. Restez camouflé, placez le {item:7970} dans votre barre d'action, ciblez {npc:7168} et utilisez-le : le perroquet rétrécit au niveau 18. Tuez-le pour le {item:7968}.",
	-- {item:7968} Southsea Treasure · {npc:7168} Polly · {item:7970} E.C.A.C.
	["{item:7968}: {npc:7168}, after the {item:7970}"] = "{item:7968} : {npc:7168}, après le {item:7970}",

	-- Step 6: Back to Wrenix the Wretched
	-- {npc:7161} Wrenix the Wretched
	["Back to {npc:7161}"] = "Retour auprès de {npc:7161}",
	-- {npc:7161} Wrenix the Wretched · {item:7676} Thistle Tea
	["{npc:7161}: ten {item:7676}"] = "{npc:7161} : dix {item:7676}",

	-- Step 7: Fenwick Thatros
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {quest:1998} Fenwick Thatros · {area:1338} Lordamere Lake · {area:228} Sepulcher
	["Take the zeppelin from {zone:1454} to the {zone:1458} and head south into Silverpine. {quest:1998} (level 16) stands alone on the old ferry dock on {area:1338}, north-east of the {area:228}. His Uppercut knocks you back, so do not fight him at the dock's edge. He always drops his head and is back 4 1/2 minutes after a death."] = "Prenez le zeppelin d'{zone:1454} à {zone:1458} et dirigez-vous vers le sud dans la forêt des Pins-Argentés. {quest:1998} (niveau 16) se tient seul sur l'ancien quai du bac, au bord du {area:1338}, au nord-est du {area:228}. Son Uppercut vous projette en arrière : ne le combattez donc pas au bord du quai. Il laisse toujours tomber sa tête et revient 4 minutes et demie après sa mort.",

	-- Step 8: Mennet Carkad
	-- {item:5060} Thieves' Tools · {npc:6566} Estelle Gendry · {object:36073} Rogues' Quarter
	["If you have no {item:5060} left, ask {npc:6566}, the outfitter in the {object:36073}."] = "S'il ne vous reste plus de {item:5060}, demandez-en à {npc:6566}, la marchande d'équipement du {object:36073}.",

	-- Step 9: Ambermill
	-- {area:233} Ambermill · {object:103815} Ambermill Strongbox · {item:5060} Thieves' Tools
	["The Kirin Tor keep their reports in walled {area:233}, in south-east Silverpine. Facing the town hall, take the building on the right: the {object:103815} is in a corner room upstairs (any Lockpicking opens it; the {item:5060} must be in your bags). Three casters of level 19-20 guard that floor and see through stealth, one walking in and out of the strongbox room: time it or fight them one at a time."] = "Le Kirin Tor garde ses rapports dans la ville fortifiée d'{area:233}, dans le sud-est de la forêt des Pins-Argentés. Face à l'hôtel de ville, prenez le bâtiment de droite : le {object:103815} est dans une pièce d'angle à l'étage (n'importe quel niveau de Crochetage l'ouvre ; les {item:5060} doivent être dans vos sacs). Trois lanceurs de sorts de niveau 19-20 gardent cet étage et voient à travers le camouflage, l'un entrant et sortant de la pièce du coffre : choisissez le bon moment ou combattez-les un par un.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "Retour auprès de {npc:6467}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly or ride to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "Prenez un vol ou chevauchez jusqu'à {area:392}, sur la côte de {zone:1413}. {npc:7161} se tient en ville avec son Appareil bidulotronique : achetez-y un {item:7970} et des {item:5060} avant de partir.",
	-- ["South along the coast from {area:392}, at the Southsea pirates' camp. If an unusually hostile parrot attacks you, use the {item:7970} on it (the quest's own advice)."] = "Au sud de {area:392} le long de la côte, au camp des pirates des Mers du sud. Si un perroquet anormalement hostile vous attaque, utilisez le {item:7970} sur lui (conseil de la quête elle-même).",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "Prenez le zeppelin de {zone:1454} à {zone:1458} et chevauchez vers le sud jusqu'aux Pins argentés. {quest:1998} se trouve au nord-est de {area:228}.",
	-- ["The Kirin Tor keep their reports at {area:233}, in south-east Silverpine: pick the lock on the {object:103815}."] = "Le Kirin Tor garde ses rapports à {area:233}, dans le sud-est des Pins argentés : crochetez le {object:103815}.",
	-- ["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}."] = "Les morts-vivants prennent le zeppelin des tours à l'extérieur de {zone:1458} pour {zone:1411}. {npc:3401} et {quest:2379} se trouvent dans {object:172960}, le canyon sous {object:172982}.",
}
