-- French (frFR): the guide forever/class/rogue/plundering-the-plunderers (forever/class/rogue/plundering-the-plunderers.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {zone:1458} Undercity · {zone:1411} Durotar · {npc:3401} Shenthul · {quest:2379} Zando'zan · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}."] = "Les morts-vivants prennent le zeppelin des tours à l'extérieur de {zone:1458} pour {zone:1411}. {npc:3401} et {quest:2379} se trouvent dans {object:172960}, le canyon sous {object:172982}.",

	-- Step 4: Wrenix the Wretched
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:7161} Wrenix the Wretched · {item:7970} E.C.A.C. · {item:5060} Thieves' Tools
	["Fly or ride to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "Prenez un vol ou chevauchez jusqu'à {area:392}, sur la côte de {zone:1413}. {npc:7161} se tient en ville avec son Appareil bidulotronique : achetez-y un {item:7970} et des {item:5060} avant de partir.",

	-- Step 5: Southsea Treasure
	-- {area:392} Ratchet · {item:7970} E.C.A.C.
	["South along the coast from {area:392}, at the Southsea pirates' camp. If an unusually hostile parrot attacks you, use the {item:7970} on it (the quest's own advice)."] = "Au sud de {area:392} le long de la côte, au camp des pirates des Mers du sud. Si un perroquet anormalement hostile vous attaque, utilisez le {item:7970} sur lui (conseil de la quête elle-même).",

	-- Step 6: Back to Wrenix the Wretched
	-- {npc:7161} Wrenix the Wretched
	["Back to {npc:7161}"] = "Retour auprès de {npc:7161}",
	-- {npc:7161} Wrenix the Wretched · {item:7676} Thistle Tea
	["{npc:7161}: ten {item:7676}"] = "{npc:7161} : dix {item:7676}",

	-- Step 7: Fenwick Thatros
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {quest:1998} Fenwick Thatros · {area:228} Sepulcher
	["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "Prenez le zeppelin de {zone:1454} à {zone:1458} et chevauchez vers le sud jusqu'aux Pins argentés. {quest:1998} se trouve au nord-est de {area:228}.",

	-- Step 9: Ambermill
	-- {area:233} Ambermill · {object:103815} Ambermill Strongbox
	["The Kirin Tor keep their reports at {area:233}, in south-east Silverpine: pick the lock on the {object:103815}."] = "Le Kirin Tor garde ses rapports à {area:233}, dans le sud-est des Pins argentés : crochetez le {object:103815}.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "Retour auprès de {npc:6467}",
}
