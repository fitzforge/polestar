-- Spanish (Latin America) (esMX): the guide forever/class/mage/manaweave-robe (forever/class/mage/manaweave-robe.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1453} Stormwind · {zone:1432} Loch Modan
	["A robe at 15 for Alliance mages, from {zone:1453} and {zone:1432}."] = "Una túnica a nivel 15 para magos de la Alianza, de {zone:1453} y {zone:1432}.",

	-- Step 1: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt · {area:87} Goldshire
	["{npc:328} is the {area:87} mage trainer, upstairs in the Lion's Pride Inn."] = "{npc:328} es el instructor de magos de {area:87}, en el piso de arriba de la Posada Orgullo de León.",

	-- Step 2: Dink (Ironforge)
	-- {npc:7312} Dink · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:7312} instruye a los magos en {object:32362}, en {zone:1455}. Después, toma el {area:2257} desde {object:171524} hasta {zone:1453}.",

	-- Step 3: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}: climb the spiral ramp and take the portal near the top. The {item:7247} and the {item:7308} lie on the table behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "{npc:5497} está en lo alto del Santuario del Mago, la torre violeta de {object:2101}: sube por la rampa en espiral y toma el portal cerca de la cima. {item:7247} y {item:7308} están en la mesa detrás de ella (ambos vuelven 5 minutos después de que alguien los toma). Entregas los dos al final, así que guárdalos.",

	-- Step 4: The Blue Recluse
	-- {object:2169} The Blue Recluse · {object:2101} Mage Quarter · {item:7308} Cantation of Manifestation · {spell:122} Frost Nova · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["{object:2169} is the tavern in the {object:2101}. Read the {item:7308} inside to make the invisible Rift Spawns (level 16-17) show: in the basement it brings out one, on the balcony or in the kitchen two, in the main room or by the door three, so read it downstairs. They hit hard and break out of {spell:122} fast. Beat one down: it does not die but sits stunned with a spiral over its head; use the {item:7247} on it while it is stunned, then click the {item:7292} it leaves on the floor (clicking before it appears wastes a charge). You need three, and the cantation works only once every 5 minutes (logging out does not reset it), so plan on three rounds."] = "{object:2169} es la taberna de {object:2101}. Lee {item:7308} adentro para hacer visibles a los engendros de la grieta invisibles (nivel 16-17): en el sótano sale uno, en el balcón o la cocina dos, en la sala principal o junto a la puerta tres, así que léelo abajo. Pegan fuerte y se libran rápido de {spell:122}. Baja a uno: no muere, sino que queda aturdido con una espiral sobre la cabeza; usa {item:7247} sobre él mientras está aturdido y luego haz clic en {item:7292} que deja en el suelo (hacer clic antes de que aparezca gasta una carga). Necesitas tres, y el conjuro funciona solo una vez cada 5 minutos (desconectarte no lo reinicia), así que cuenta con tres rondas.",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "{npc:6492}, hasta aturdirlo",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "{item:7247}, sobre el {npc:6492} aturdido",

	-- Step 5: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "De vuelta con {npc:5497}",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth · {area:149} Silver Stream Mine · {object:2096} Trade District
	["Any humanoid drops {item:2589}, and the Tunnel Rats in the {area:149} drop it while you gather the gems; the Auction House in the {object:2096} sells it. You hand in ten."] = "Cualquier humanoide suelta {item:2589}, y las ratas de túnel de {area:149} lo sueltan mientras juntas las gemas; la casa de subastas de {object:2096} lo vende. Entregas diez.",

	-- Step 7: The Silver Stream Mine
	-- {area:149} Silver Stream Mine
	["The {area:149}"] = "{area:149}",
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {zone:1432} Loch Modan · {area:149} Silver Stream Mine · {area:144} Thelsamar · {object:271} Miners' League Crates
	["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The {area:149} is at the north end of the loch, north of {area:144}; Tunnel Rat kobolds hold it. The gems come only from the tall stacked {object:271} (the cursor shows a cog over them; single boxes hold nothing): every crate gives one, there are fourteen and they come back after 3 to 5 minutes. You may have to go as deep as the end chamber for six. The same crates serve the dwarves' Filthy Paws quest."] = "Toma {area:2257} a {zone:1455} y luego el camino al este por el túnel de la Puerta Sur hacia {zone:1432}. {area:149} está en el extremo norte del lago, al norte de {area:144}; la ocupan kóbolds rata de túnel. Las gemas salen solo de las {object:271} altas y apiladas (el cursor muestra un engranaje sobre ellas; las cajas sueltas no tienen nada): cada caja da una, hay catorce y vuelven a los 3 a 5 minutos. Puede que tengas que llegar hasta la cámara del fondo para conseguir seis. Las mismas cajas sirven para la misión Garras sucias de los enanos.",

	-- Step 8: Wynne Larson
	-- {zone:1453} Stormwind · {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["Back to {zone:1453} by the tram. {npc:1309} works at {object:23296} in the {object:2101}."] = "Regresa a {zone:1453} en el tranvía. {npc:1309} trabaja en {object:23296}, en {object:2101}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Humanoids drop {item:2589}; the Auction House in the {object:2096} sells it."] = "Los humanoides sueltan {item:2589}; la casa de subastas de {object:2096} lo vende.",
	-- ["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The dwarven miners' league left the crates in the {area:149} at the north end of the loch; Tunnel Rat troggs hold the mine."] = "Toma el {area:2257} hasta {zone:1455} y luego el camino hacia el este por el túnel de la Puerta Sur hasta {zone:1432}. La liga de mineros enanos dejó las cajas en {area:149}, en el extremo norte del lago; los troggs Ratatúnel ocupan la mina.",
	-- ["{npc:328} is the {area:87} mage trainer."] = "{npc:328} es el instructor de magos de {area:87}.",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:5497} está en el Wizard's Sanctum, la torre de {object:2101}. {item:7247} y {item:7308} están detrás de ella.",
	-- ["{object:2169} is the tavern in the {object:2101}. Use the {item:7308} inside to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "{object:2169} es la taberna de {object:2101}. Usa {item:7308} adentro para hacer visible a {npc:6492}, sométela con tus hechizos y luego usa {item:7247} para arrojar un cofre y capturarla.",
}
