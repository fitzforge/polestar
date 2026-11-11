-- German (deDE): the guide forever/class/mage/astral-knot-garment (forever/class/mage/astral-knot-garment.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A robe or a blouse for Alliance mages in their late 20s."] = "Eine Robe oder eine Bluse für Allianz-Magier in ihren späten Zwanzigern.",

	-- Step 1: Bink (Ironforge)
	-- {npc:5144} Bink · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:5144} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:5144} unterrichtet Magier in {object:32362} in {zone:1455}. Nimm danach {area:2257} von {object:171524} nach {zone:1453}.",

	-- Step 2: Jennea Cannon (Stormwind)
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}; the portal near the top of the spiral ramp takes you to her."] = "{npc:5497} steht oben im Wizard's Sanctum, dem violetten Turm des {object:2101}; das Portal nahe dem oberen Ende der Spiralrampe bringt dich zu ihr.",

	-- Step 3: High Sorcerer Andromath (Skyborne)
	-- {npc:5694} High Sorcerer Andromath
	["{npc:5694} (Skyborne)"] = "{npc:5694} (Himmelsgeborene)",
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:5694} High Sorcerer Andromath · {npc:5497} Jennea Cannon
	["You do not need a letter: at 26 climb the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:5694} waits on the spiral walkway, just past the door of the portal room near the top, and has the quest for you. ({npc:5497} may also offer you {npc:5694}, the pointer quest; it is only a pointer and you can skip it.)"] = "Du brauchst keinen Brief: Steig mit Stufe 26 das Wizard's Sanctum hinauf, den violetten Turm im {object:2101} von {zone:1453}. {npc:5694} wartet auf dem Spiralgang, kurz hinter der Tür des Portalraums nahe dem oberen Ende, und hat die Quest für dich. ({npc:5497} bietet dir vielleicht auch {npc:5694} an, die Hinweisquest; sie ist nur ein Hinweis, du kannst sie überspringen.)",

	-- Step 4: High Sorcerer Andromath
	-- {quest:1939} High Sorcerer Andromath
	["{quest:1939} waits on the spiral walkway of the Wizard's Sanctum, just past the door of the portal room as you walk down from the trainers."] = "{quest:1939} wartet auf dem Spiralgang des Wizard's Sanctum, kurz hinter der Tür des Portalraums, wenn du von den Lehrern nach unten gehst.",

	-- Step 5: The Tower of Ilgalar
	-- {area:96} Tower of Ilgalar
	["The {area:96}"] = "{area:96}",
	-- {zone:1429} Elwynn Forest · {area:69} Lakeshire · {area:96} Tower of Ilgalar · {spell:2691} Mana Burn
	["Head east through {zone:1429} into Redridge, or fly to {area:69}. The {area:96} stands alone in the east of the zone. Climb to the very top floor (not the one below): the treatise is the book sticking out of the shelf where the stairs come up. Two gnoll dogs and a gnoll caster guard the shelf; the dogs' {spell:2691} interrupts the click, so fight them on the stairs out of their sight. Morganth (level 26 elite) stands across the top floor: you do not need him, keep to the left edge of the ramp so he stays put. The book is back two seconds after anyone takes it. If you die, your ghost can run up and come back to life beside it."] = "Geh nach Osten durch {zone:1429} nach Redridge oder flieg nach {area:69}. Der {area:96} steht allein im Osten des Gebiets. Steig bis ganz nach oben (nicht ins Stockwerk darunter): Die Abhandlung ist das Buch, das aus dem Regal ragt, wo die Treppe hochkommt. Zwei Gnollhunde und ein Gnollzauberer bewachen das Regal; der {spell:2691} der Hunde unterbricht den Klick, also bekämpfe sie auf der Treppe außer Sichtweite. Morganth (Elite der Stufe 26) steht quer im obersten Stockwerk: Du brauchst ihn nicht, halte dich am linken Rand der Rampe, damit er stehen bleibt. Das Buch ist zwei Sekunden, nachdem es jemand genommen hat, wieder da. Wenn du stirbst, kann dein Geist hinauflaufen und daneben wieder zum Leben erwachen.",

	-- Step 6: Back to Andromath
	["Back to Andromath"] = "Zurück zu Andromath",

	-- Step 7: Carrion Recluses
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse
	["Carrion Recluses"] = "Aaskrabbler",
	-- {area:492} Raven Hill Cemetery · {zone:1431} Duskwood · {spell:3609} Paralyzing Poison · {npc:522} Mor'Ladim
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Black Widow Hatchlings = {npc:930} Black Widow Hatchling
	["{area:492} in western {zone:1431}: the six Carrion Recluses (level 25-26, green, {spell:3609}) walk the graves, the central statue and the riverbank, and every one drops a silk; they come back after 5 minutes. The Black Widow Hatchlings (24-25) on the slopes east of the cemetery drop it about one time in six, so mix them in while you wait. {npc:522}, a level 35 elite skeleton, walks the cemetery: watch for him."] = "{area:492} im Westen von {zone:1431}: Die sechs Carrion Recluses (Stufe 25-26, grün, {spell:3609}) laufen über die Gräber, die zentrale Statue und das Flussufer, und jede lässt eine Seide fallen; sie kommen nach 5 Minuten wieder. Die Black Widow Hatchlings (24-25) an den Hängen östlich des Friedhofs lassen sie etwa bei jedem sechsten Kill fallen, mische sie also beim Warten dazu. {npc:522}, ein Skelett-Elite der Stufe 35, läuft über den Friedhof: Halte nach ihm Ausschau.",

	-- Step 8: Wynne Larson
	-- {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["{npc:1309} works at {object:23296} in the {object:2101}. The robe gives intellect, stamina and spirit; the blouse more intellect and stamina but no spirit."] = "{npc:1309} arbeitet bei {object:23296} im {object:2101}. Die Robe gibt Intelligenz, Ausdauer und Willenskraft; die Bluse mehr Intelligenz und Ausdauer, aber keine Willenskraft.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A robe or a blouse for Human and Gnome mages in their late 20s."] = "Eine Robe oder eine Bluse für menschliche und gnomische Magier gegen Ende 20.",
	-- ["Carrion Recluses lurk in the woods of western {zone:1431} and each one drops the silk. The Black Widow Hatchlings further east drop it now and then."] = "Aaskrabbler lauern in den Wäldern im Westen von {zone:1431}, und jeder lässt die Seide fallen. Die Jungen einer Schwarzen Witwe weiter östlich lassen sie ab und zu fallen.",
	-- ["Head east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "Geh nach Osten durch {zone:1429} ins Rotkammgebirge. Der Turm des gefallenen Magiers Ilgalar steht im Osten des Gebiets; die Abhandlung ist in seiner Bibliothek.",
	-- ["Ride east through {zone:1429} into Redridge. The fallen mage's tower of Ilgalar stands in the east of the zone; the treatise is in his library."] = "Reite nach Osten durch {zone:1429} ins Rotkammgebirge. Der Turm des gefallenen Magiers Ilgalar steht im Osten des Gebiets; die Abhandlung liegt in seiner Bibliothek.",
	-- ["{npc:1309} works at {object:23296} in the {object:2101}."] = "{npc:1309} arbeitet bei {object:23296} in {object:2101}.",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}."] = "{npc:5497} steht im Magiersanktum, dem Turm in {object:2101}.",
	-- ["{quest:1939} is in the Wizard's Sanctum too."] = "{quest:1939} ist ebenfalls im Magiersanktum.",
}
