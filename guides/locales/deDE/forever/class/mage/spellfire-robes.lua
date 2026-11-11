-- German (deDE): the guide forever/class/mage/spellfire-robes (forever/class/mage/spellfire-robes.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest
	["A robe at 15 for Horde mages, from the {zone:1458} and {zone:1421}."] = "Eine Robe mit 15 für Magier der Horde, aus {zone:1458} und dem {zone:1421}.",

	-- Step 1: Uthel'nay (Orgrimmar)
	-- {npc:7311} Uthel'nay · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {object:172961} Valley of Spirits · {zone:1420} Tirisfal Glades
	["{npc:7311} is one of {zone:1454}'s mage trainers, in {object:173161} in the {object:172961}. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311} ist einer der Magierlehrer von {zone:1454}, in {object:173161} im {object:172961}. Nimm dann den Zeppelin nach {zone:1420} vom Turm vor dem Haupttor von {zone:1454}.",

	-- Step 2: Cain Firesong (Brill)
	-- {npc:2128} Cain Firesong · {area:159} Brill · {area:2119} Gallows' End Tavern
	["{npc:2128} is the {area:159} mage trainer, upstairs in the {area:2119}: take the stairs inside, the arrow cannot tell the floors apart."] = "{npc:2128} ist der Magierlehrer von {area:159}, oben im {area:2119}: Nimm die Treppe drinnen, der Pfeil kann die Stockwerke nicht unterscheiden.",

	-- Step 3: Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell · {object:36082} Magic Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie on the ledge behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:4568} steht im {object:36082}. {item:7247} und {item:7308} liegen auf dem Sims hinter ihr (beide kommen 5 Minuten nach dem Mitnehmen wieder). Du gibst beide am Ende ab, also behalte sie.",

	-- Step 4: The alchemist shop
	["The alchemist shop"] = "Der Alchemieladen",
	-- {item:7308} Cantation of Manifestation · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["Algernon's alchemist shop is in the Apothecarium. Stand on the steps or the bridge outside the shop and read the {item:7308}: up to four invisible Rift Spawns (level 16-17) appear and attack at once, and the city guards do not help. Hit one with a single-target spell and back off over the bridge: the others give up and fade, the one you hit follows. Beat it down on the shop's half of the bridge (past halfway the coffer will not work on it) until it stops fighting and sits stunned under a spiral, use the {item:7247} on it, then click the {item:7292} once it appears on the floor (clicking too early wastes a charge). Three are needed."] = "Algernons Alchemieladen ist im Apothecarium. Stell dich auf die Stufen oder die Brücke vor dem Laden und lies {item:7308}: Bis zu vier unsichtbare Rift Spawns (Stufe 16-17) erscheinen und greifen sofort an, und die Stadtwachen helfen nicht. Triff einen mit einem Einzelzielzauber und zieh dich über die Brücke zurück: Die anderen geben auf und lösen sich auf, der getroffene folgt dir. Prügle ihn auf der Ladenhälfte der Brücke nieder (hinter der Mitte wirkt die Truhe nicht auf ihn), bis er nicht mehr kämpft und betäubt unter einer Spirale sitzt, benutze {item:7247} an ihm und klick dann {item:7292} an, sobald er auf dem Boden erscheint (zu früh klicken verschwendet eine Ladung). Drei sind nötig.",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}, bis zur Betäubung",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "{item:7247}, am betäubten {npc:6492}",

	-- Step 5: Back to Anastasia Hartwell
	-- {npc:4568} Anastasia Hartwell
	["Back to {npc:4568}"] = "Zurück zu {npc:4568}",

	-- Step 6: Ambermill
	-- {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:279} Dalaran · {item:7293} Dalaran Mana Gem · {item:2589} Linen Cloth · {spell:116} Frostbolt · {area:228} Sepulcher · {area:233} Ambermill · {spell:134} Fire Shield · {spell:2120} Flamestrike · {spell:122} Frost Nova
	-- plural, as words: Dalaran Apprentices = {npc:1867} Dalaran Apprentice
	["Leave the {zone:1458} and follow the road south through {zone:1421}. Every {area:279} human drops a {item:7293} four times in five, and {item:2589} too: the easiest are the Dalaran Apprentices (level 13-14, {spell:116}) on the hills south-east of the {area:228}, either side of the road south; deeper in, the walled town of {area:233} in south-east Silverpine has Watchers (18-19, {spell:134} and {spell:2120}) and Wizards (19-20, {spell:122}) that come back every 4 1/2 minutes and run for help at low health, so pull at the edge. Ten {item:2589} also come from any humanoid or the Undercity Auction House."] = "Verlasse {zone:1458} und folge der Straße nach Süden durch {zone:1421}. Jeder Mensch von {area:279} lässt in vier von fünf Fällen {item:7293} fallen, und auch {item:2589}: Am leichtesten sind die Dalaran Apprentices (Stufe 13-14, {spell:116}) auf den Hügeln südöstlich von {area:228}, auf beiden Seiten der Straße nach Süden; weiter drinnen hat die ummauerte Stadt {area:233} im Südosten von Silverpine Watchers (18-19, {spell:134} und {spell:2120}) und Wizards (19-20, {spell:122}), die alle 4 1/2 Minuten wiederkommen und bei niedriger Gesundheit Hilfe holen, also pull am Rand. Zehn {item:2589} kommen auch von jedem Humanoiden oder aus dem Auktionshaus von Undercity.",

	-- Step 7: Josef Gregorian
	-- {zone:1458} Undercity · {npc:4576} Josef Gregorian · {npc:11048} Victor Ward · {npc:11049} Rhiannon Davis · {object:36082} Magic Quarter · {quest:1962} Spellfire Robes
	["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop in the {object:36082}. Hand the gems and cloth to {npc:4576} and let the three of them talk for a moment; then {npc:4576} offers {quest:1962}: take it and hand it straight back to him for the robe."] = "Zurück nach {zone:1458}. {npc:4576}, {npc:11048} und {npc:11049} führen den Schneiderladen im {object:36082}. Gib die Edelsteine und den Stoff an {npc:4576} ab und lass die drei einen Moment reden; dann bietet {npc:4576} {quest:1962} an: Nimm sie an und gib sie direkt wieder bei ihm ab, um die Robe zu bekommen.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Algernon's alchemist shop is in the Apothecarium. Use the {item:7308} there to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "Algernons Alchemieladen ist im Apothekarium. Benutze dort {item:7308}, um {npc:6492} sichtbar zu machen, bezwinge eine mit deinen Zaubern und benutze dann {item:7247}, um ein Kästchen hinzuwerfen und sie einzufangen.",
	-- ["Back to the {zone:1458}. {npc:4576}, {npc:11048} and {npc:11049} keep the tailor's shop."] = "Zurück nach {zone:1458}. {npc:4576}, {npc:11048} und {npc:11049} führen die Schneiderei.",
	-- ["Humanoids drop {item:2589}; the Undercity Auction House sells it."] = "Humanoide lassen {item:2589} fallen; das Auktionshaus von Undercity verkauft es.",
	-- ["Leave the {zone:1458} and follow the road south through {zone:1421}. The {area:279} mages hold {area:233}, south-east of the {area:228}; every {npc:1867}, Mage, Protector, Warder, Conjuror, Watcher and Wizard can drop a {item:7293}."] = "Verlass {zone:1458} und folge der Straße nach Süden durch den {zone:1421}. Die Magier von {area:279} halten {area:233}, südöstlich von {area:228}; jeder {npc:1867}, Magier, Beschützer, Wärter, Herbeizauberer, Behüter und Hexer von Dalaran kann einen {item:7293} fallen lassen.",
	-- ["{npc:2128} is the {area:159} mage trainer."] = "{npc:2128} ist der Magierlehrer in {area:159}.",
	-- ["{npc:4568} stands in the {object:36082}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:4568} steht im {object:36082}. {item:7247} und {item:7308} liegen hinter ihr.",
	-- ["{npc:7311} is one of {zone:1454}'s mage trainers. Then take the zeppelin to {zone:1420} from the tower outside {zone:1454}'s main gate."] = "{npc:7311} ist einer der Magierlehrer von {zone:1454}. Nimm dann vom Turm vor dem Haupttor von {zone:1454} den Zeppelin nach {zone:1420}.",
}
