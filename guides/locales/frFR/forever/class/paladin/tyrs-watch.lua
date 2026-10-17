-- French (frFR): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328}"] = "Tyr's Watch et {spell:7328}",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "{spell:7328} pour ranimer les alliés tombés, plus une arme et un bouclier pour un nouveau paladin réprouvé.",

	-- Step 1: Shari Stilwell
	-- {npc:246152} Shari Stilwell · {area:159} Brill
	["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "{npc:246152}, qui forme les paladins à {area:159}, vous envoie au donjon de l'ordre sur la côte ouest.",

	-- Step 2: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels
	["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602} se dresse sur les falaises au nord-ouest de la {area:156}. {npc:246349} attend à la porte.",

	-- Step 3: Murlocs at the Gates
	["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "Les murlocs Aileron noir rôdent sur les falaises le long de la route à l'est du donjon et dans les camps autour du lac à l'ouest.",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers"] = "Attaquants aileron noir",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers"] = "Oracles aileron noir",

	-- Step 5: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378} dirige l'ordre depuis l'intérieur du donjon ; {npc:246393} se tient à côté.",

	-- Step 6: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {item:246213} Sturdy Lumber · {npc:259431} Rudolph Gelhardt
	["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317} occupent le village en ruine de {area:16881}, dans la {area:16616}, au sud-ouest du donjon. Le {item:246213} est empilé dans le cellier de l'une de ses maisons ; le commandant {npc:259431} circule parmi ses Ternis.",
	-- {object:554626} Lumber Pile
	["{object:554626}, in the root cellar"] = "{object:554626}, dans le cellier",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges"] = "Manoeuvres ternis",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots"] = "Zélotes ternis",

	-- Step 7: Back to the keep
	["Back to the keep"] = "Retour au donjon",

	-- Step 8: A Lesson in Divinity
	-- {npc:246378} Danitha Morr
	["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378} propose la première Leçon de divinité au niveau 12.",

	-- Step 9: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "Marchez vers le sud depuis {area:159} jusqu'aux {area:153} et descendez dans {zone:1458}. {npc:10181} tient sa cour dans le {object:36126} ; {npc:257648} mendie dans le {object:36078}.",

	-- Step 10: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot · Scarlet Friars = {npc:1538} Scarlet Friar
	["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648} a besoin de 10 {item:2589}. Les Zélotes écarlates et les Frères écarlates en laissent tomber environ trois fois sur dix ; apportez-en si vous en avez déjà.",

	-- Step 12: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "Le {item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "Retour à {area:16602}. {npc:246378} vous remet le {item:6866} ; {npc:257655} attend au rez-de-chaussée du donjon.",

	-- Step 13: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life · {npc:257663} Deathguard Falgan · {npc:246378} Danitha Morr
	["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "La {area:812} se trouve à l'extrémité est des clairières. Utilisez le {item:6866} sur {npc:257663}, puis parlez-lui. Si vous perdez le symbole, {npc:246378} vous en donne un autre.",

	-- Step 14: The Scarlet attack plans
	["The Scarlet attack plans"] = "Les plans d'attaque de la Croisade écarlate",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "Les membres de la Croisade écarlate qui campent autour de la {area:812} portent les plans d'attaque.",

	-- Step 15: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "Retour à {area:16602} : Billmuth prend les plans, {npc:246378} vous apprend {spell:7328}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{object:181686}, in the root cellar"] = "{object:181686}, dans le cellier",
}
