-- French (frFR): the guide forever/class/mage/spellfire-robes (forever/class/mage/spellfire-robes.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {zone:1420} Tirisfal Glades
	["{npc:7311} is one of {zone:1454}'s mage trainers. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311} est l'un des maîtres des mages d'{zone:1454}. Prenez ensuite le zeppelin pour {zone:1420} depuis la tour devant la porte principale d'{zone:1454}.",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill
	["{npc:2128} is the {area:159} mage trainer."] = "{npc:2128} est le maître des mages de {area:159}.",

	-- Step 3: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:4568} se tient dans le {object:36082}. Le {item:7247} et la {item:7308} se trouvent derrière elle.",

	-- Step 4: The alchemist shop
	["The alchemist shop"] = "La boutique d'alchimie",
	-- {item:7308} Cantation of Manifestation · {npc:6492} Rift Spawn · {item:7247} Chest of Containment Coffers
	["Algernon's alchemist shop is in the Apothecarium. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "La boutique d'alchimiste d'Algernon se trouve dans l'Apothicarium. Utilisez-y {item:7308} pour rendre {npc:6492} visible, maîtrisez-en un avec vos sorts, puis utilisez {item:7247} pour jeter un coffret au sol et le capturer.",

	-- Step 5: Back to Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell
	["Back to {npc:4568}"] = "Retour auprès de {npc:4568}",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth
	["Humanoids drop {item:2589}; the Undercity Auction House sells it."] = "Les humanoïdes lâchent {item:2589} ; l'hôtel des ventes de Fossoyeuse en vend.",

	-- Step 7: Ambermill
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:279} Dalaran · {area:233} Ambermill · {area:228} Sepulcher · {npc:1867} Dalaran Apprentice · {item:7293} Dalaran Mana Gem
	["Leave the {zone:1458} and follow the road south through {zone:1421}. The {area:279} mages hold {area:233}, south-east of the {area:228}; every {npc:1867}, Mage, Protector, Warder, Conjuror, Watcher and Wizard can drop a {item:7293}."] = "Quittez {zone:1458} et suivez la route vers le sud à travers {zone:1421}. Les mages de {area:279} tiennent {area:233}, au sud-est de {area:228} ; chaque {npc:1867}, Mage, Protecteur, Garde, Conjurateur, Gardien et Sorcier de Dalaran peut lâcher une {item:7293}.",

	-- Step 8: Josef Gregorian
	-- {zone:1458} Undercity · {npc:4576} Josef Gregorian · {npc:11048} Victor Ward · {npc:11049} Rhiannon Davis
	["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop."] = "Retour à {zone:1458}. {npc:4576}, {npc:11048} et {npc:11049} tiennent la boutique de tailleur.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Algernon's alchemist shop is in the {object:36072}. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "La boutique d'alchimie d'Algernon est dans {object:36072}. Utilisez-y la {item:7308} pour rendre visible le {npc:6492}, affaiblissez-en un avec vos sorts, puis utilisez le {item:7247} pour poser un coffret et le capturer.",
}
