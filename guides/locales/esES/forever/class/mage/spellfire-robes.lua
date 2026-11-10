-- Spanish (Spain) (esES): the guide forever/class/mage/spellfire-robes (forever/class/mage/spellfire-robes.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest
	["A robe at 15 for Horde mages, from the {zone:1458} and {zone:1421}."] = "Una toga a nivel 15 para magos de la Horda, de {zone:1458} y {zone:1421}.",

	-- Step 1: Uthel'nay (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {object:172961} Valley of Spirits · {zone:1420} Tirisfal Glades
	["{npc:7311} is one of {zone:1454}'s mage trainers, in {object:173161} in the {object:172961}. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill · {area:2119} Gallows' End Tavern
	["{npc:2128} is the {area:159} mage trainer, upstairs in the {area:2119}: take the stairs inside, the arrow cannot tell the floors apart."] = "",

	-- Step 3: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie on the ledge behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "",

	-- Step 4: The alchemist shop
	["The alchemist shop"] = "La tienda del alquimista",
	-- {item:7308} Cantation of Manifestation · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["Algernon's alchemist shop is in the Apothecarium. Stand on the steps or the bridge outside the shop and read the {item:7308}: up to four invisible Rift Spawns (level 16-17) appear and attack at once, and the city guards do not help. Hit one with a single-target spell and back off over the bridge: the others give up and fade, the one you hit follows. Beat it down on the shop's half of the bridge (past halfway the coffer will not work on it) until it stops fighting and sits stunned under a spiral, use the {item:7247} on it, then click the {item:7292} once it appears on the floor (clicking too early wastes a charge). Three are needed."] = "",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "",

	-- Step 5: Back to Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell
	["Back to {npc:4568}"] = "Vuelve con {npc:4568}",

	-- Step 6: Ambermill
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:279} Dalaran · {item:7293} Dalaran Mana Gem · {item:2589} Linen Cloth · {spell:116} Frostbolt · {area:228} Sepulcher · {area:233} Ambermill · {spell:134} Fire Shield · {spell:2120} Flamestrike · {spell:122} Frost Nova
	-- plural, as words: Dalaran Apprentices = {npc:1867} Dalaran Apprentice
	["Leave the {zone:1458} and follow the road south through {zone:1421}. Every {area:279} human drops a {item:7293} four times in five, and {item:2589} too: the easiest are the Dalaran Apprentices (level 13-14, {spell:116}) on the hills south-east of the {area:228}, either side of the road south; deeper in, the walled town of {area:233} in south-east Silverpine has Watchers (18-19, {spell:134} and {spell:2120}) and Wizards (19-20, {spell:122}) that come back every 4 1/2 minutes and run for help at low health, so pull at the edge. Ten {item:2589} also come from any humanoid or the Undercity Auction House."] = "",

	-- Step 7: Josef Gregorian
	-- {zone:1458} Undercity · {npc:4576} Josef Gregorian · {npc:11048} Victor Ward · {npc:11049} Rhiannon Davis · {object:36082} Magic Quarter · {quest:1962} Spellfire Robes
	["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop in the {object:36082}. Hand the gems and cloth to {npc:4576} and let the three of them talk for a moment; then {npc:4576} offers {quest:1962}: take it and hand it straight back to him for the robe."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Algernon's alchemist shop is in the Apothecarium. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "La tienda de alquimia de Algernon está en el Apothecarium. Usa {item:7308} allí para hacer visible a la {npc:6492}, somete a una con tus hechizos y luego usa {item:7247} para lanzar un cofre y capturarla.",
	-- ["Algernon's alchemist shop is in the {object:36072}. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "La tienda de alquimia de Algernon está en {object:36072}. Usa {item:7308} allí para hacer visible a {npc:6492}, sométela con tus hechizos y luego usa {item:7247} para lanzar un cofre y capturarla.",
	-- ["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop."] = "Vuelve a {zone:1458}. {npc:4576}, {npc:11048} y {npc:11049} atienden la sastrería.",
	-- ["Humanoids drop {item:2589}; the Undercity Auction House sells it."] = "Los humanoides sueltan {item:2589}; la casa de subastas de Entrañas lo vende.",
	-- ["Leave the {zone:1458} and follow the road south through {zone:1421}. The {area:279} mages hold {area:233}, south-east of the {area:228}; every {npc:1867}, Mage, Protector, Warder, Conjuror, Watcher and Wizard can drop a {item:7293}."] = "Sal de {zone:1458} y sigue el camino hacia el sur por {zone:1421}. Los magos de {area:279} controlan {area:233}, al sureste de {area:228}; cualquier {npc:1867}, mago, protector, guardián, conjurador, vigía o hechicero puede soltar una {item:7293}.",
	-- ["{npc:2128} is the {area:159} mage trainer."] = "{npc:2128} es el instructor de magos de {area:159}.",
	-- ["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:4568} está en {object:36082}. {item:7247} y {item:7308} están detrás de ella.",
	-- ["{npc:7311} is one of {zone:1454}'s mage trainers. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311} es uno de los instructores de magos de {zone:1454}. Después toma el zepelín a {zone:1420} desde la torre de fuera de la puerta principal de {zone:1454}.",
}
