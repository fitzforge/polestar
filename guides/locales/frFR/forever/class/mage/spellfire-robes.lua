-- French (frFR): the guide forever/class/mage/spellfire-robes (forever/class/mage/spellfire-robes.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest
	["A robe at 15 for Horde mages, from the {zone:1458} and {zone:1421}."] = "Une robe au niveau 15 pour les mages de la Horde, via {zone:1458} et {zone:1421}.",

	-- Step 1: Uthel'nay (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {object:172961} Valley of Spirits · {zone:1420} Tirisfal Glades
	["{npc:7311} is one of {zone:1454}'s mage trainers, in {object:173161} in the {object:172961}. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311} est l'un des maîtres des mages d'{zone:1454}, dans le pavillon Darkbriar, dans {object:172961}. Prenez ensuite le zeppelin pour {zone:1420} depuis la tour devant la porte principale d'{zone:1454}.",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill · {area:2119} Gallows' End Tavern
	["{npc:2128} is the {area:159} mage trainer, upstairs in the {area:2119}: take the stairs inside, the arrow cannot tell the floors apart."] = "",

	-- Step 3: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie on the ledge behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:4568} se tient dans le {object:36082}. Le {item:7247} et l'{item:7308} sont posés sur le rebord derrière elle (tous deux reviennent 5 minutes après qu'on les a pris). Vous les rendez tous les deux à la fin : gardez-les.",

	-- Step 4: The alchemist shop
	["The alchemist shop"] = "La boutique d'alchimie",
	-- {item:7308} Cantation of Manifestation · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["Algernon's alchemist shop is in the Apothecarium. Stand on the steps or the bridge outside the shop and read the {item:7308}: up to four invisible Rift Spawns (level 16-17) appear and attack at once, and the city guards do not help. Hit one with a single-target spell and back off over the bridge: the others give up and fade, the one you hit follows. Beat it down on the shop's half of the bridge (past halfway the coffer will not work on it) until it stops fighting and sits stunned under a spiral, use the {item:7247} on it, then click the {item:7292} once it appears on the floor (clicking too early wastes a charge). Three are needed."] = "La boutique d'alchimie d'Algernon se trouve dans l'Apothicarium. Placez-vous sur les marches ou sur le pont devant la boutique et lisez l'{item:7308} : jusqu'à quatre Rejetons de la faille invisibles (niveau 16-17) apparaissent et attaquent aussitôt, et les gardes de la ville n'aident pas. Frappez-en un avec un sort à cible unique et reculez sur le pont : les autres abandonnent et s'effacent, celui que vous avez frappé vous suit. Affaiblissez-le sur la moitié du pont côté boutique (au-delà du milieu, le coffret ne fonctionne pas sur lui) jusqu'à ce qu'il cesse de se battre et reste étourdi sous une spirale, utilisez le {item:7247} sur lui, puis cliquez sur le {item:7292} dès qu'il apparaît au sol (cliquer trop tôt gaspille une charge). Il en faut trois.",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}, jusqu'à l'étourdissement",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "{item:7247}, sur le {npc:6492} étourdi",

	-- Step 5: Back to Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell
	["Back to {npc:4568}"] = "Retour auprès de {npc:4568}",

	-- Step 6: Ambermill
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:279} Dalaran · {item:7293} Dalaran Mana Gem · {item:2589} Linen Cloth · {spell:116} Frostbolt · {area:228} Sepulcher · {area:233} Ambermill · {spell:134} Fire Shield · {spell:2120} Flamestrike · {spell:122} Frost Nova
	-- plural, as words: Dalaran Apprentices = {npc:1867} Dalaran Apprentice
	["Leave the {zone:1458} and follow the road south through {zone:1421}. Every {area:279} human drops a {item:7293} four times in five, and {item:2589} too: the easiest are the Dalaran Apprentices (level 13-14, {spell:116}) on the hills south-east of the {area:228}, either side of the road south; deeper in, the walled town of {area:233} in south-east Silverpine has Watchers (18-19, {spell:134} and {spell:2120}) and Wizards (19-20, {spell:122}) that come back every 4 1/2 minutes and run for help at low health, so pull at the edge. Ten {item:2589} also come from any humanoid or the Undercity Auction House."] = "Quittez {zone:1458} et suivez la route vers le sud à travers la {zone:1421}. Chaque humain de {area:279} laisse tomber une {item:7293} quatre fois sur cinq, ainsi que de l'{item:2589} : les plus faciles sont les Apprentis de Dalaran (niveau 13-14, {spell:116}) sur les collines au sud-est du {area:228}, de part et d'autre de la route du sud ; plus loin, la ville fortifiée d'{area:233}, dans le sud-est de la forêt des Pins-Argentés, abrite des Gardiens (18-19, {spell:134} et {spell:2120}) et des Sorciers (19-20, {spell:122}) qui reviennent toutes les 4 minutes et demie et fuient chercher de l'aide quand leur vie est basse : attirez-les par les bords. Dix {item:2589} s'obtiennent aussi sur n'importe quel humanoïde ou à l'hôtel des ventes de Fossoyeuse.",

	-- Step 7: Josef Gregorian
	-- {zone:1458} Undercity · {npc:4576} Josef Gregorian · {npc:11048} Victor Ward · {npc:11049} Rhiannon Davis · {object:36082} Magic Quarter · {quest:1962} Spellfire Robes
	["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop in the {object:36082}. Hand the gems and cloth to {npc:4576} and let the three of them talk for a moment; then {npc:4576} offers {quest:1962}: take it and hand it straight back to him for the robe."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Algernon's alchemist shop is in the Apothecarium. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "La boutique d'alchimiste d'Algernon se trouve dans l'Apothicarium. Utilisez-y {item:7308} pour rendre {npc:6492} visible, maîtrisez-en un avec vos sorts, puis utilisez {item:7247} pour jeter un coffret au sol et le capturer.",
	-- ["Algernon's alchemist shop is in the {object:36072}. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "La boutique d'alchimie d'Algernon est dans {object:36072}. Utilisez-y la {item:7308} pour rendre visible le {npc:6492}, affaiblissez-en un avec vos sorts, puis utilisez le {item:7247} pour poser un coffret et le capturer.",
	-- ["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop in the {object:36082}. Hand the gems and cloth to {npc:4576} and let the three of them talk for a moment; then take {quest:1962} (Forever's quest data has {npc:11049} offering it; if the \"!\" shows over {npc:4576} instead, take it from him) and hand it to {npc:4576} for the robe."] = "Retour à {zone:1458}. {npc:4576}, {npc:11048} et {npc:11049} tiennent la boutique de tailleur dans le {object:36082}. Remettez les gemmes et le tissu à {npc:4576} et laissez-les parler tous les trois un moment ; acceptez ensuite {quest:1962} (d'après les données de quête de Forever, c'est {npc:11049} qui la propose ; si le « ! » apparaît plutôt au-dessus de {npc:4576}, prenez-la auprès de lui) et rendez-la à {npc:4576} pour la robe.",
	-- ["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop."] = "Retour à {zone:1458}. {npc:4576}, {npc:11048} et {npc:11049} tiennent la boutique de tailleur.",
	-- ["Humanoids drop {item:2589}; the Undercity Auction House sells it."] = "Les humanoïdes lâchent {item:2589} ; l'hôtel des ventes de Fossoyeuse en vend.",
	-- ["Leave the {zone:1458} and follow the road south through {zone:1421}. The {area:279} mages hold {area:233}, south-east of the {area:228}; every {npc:1867}, Mage, Protector, Warder, Conjuror, Watcher and Wizard can drop a {item:7293}."] = "Quittez {zone:1458} et suivez la route vers le sud à travers {zone:1421}. Les mages de {area:279} tiennent {area:233}, au sud-est de {area:228} ; chaque {npc:1867}, Mage, Protecteur, Garde, Conjurateur, Gardien et Sorcier de Dalaran peut lâcher une {item:7293}.",
	-- ["{npc:2128} is the {area:159} mage trainer, in the {area:2119}."] = "{npc:2128} est le maître des mages de {area:159}, à la {area:2119}.",
	-- ["{npc:2128} is the {area:159} mage trainer."] = "{npc:2128} est le maître des mages de {area:159}.",
	-- ["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:4568} se tient dans le {object:36082}. Le {item:7247} et la {item:7308} se trouvent derrière elle.",
	-- ["{npc:7311} is one of {zone:1454}'s mage trainers. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311} est l'un des maîtres des mages d'{zone:1454}. Prenez ensuite le zeppelin pour {zone:1420} depuis la tour devant la porte principale d'{zone:1454}.",
}
