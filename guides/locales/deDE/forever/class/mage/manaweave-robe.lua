-- German (deDE): the guide forever/class/mage/manaweave-robe (forever/class/mage/manaweave-robe.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1453} Stormwind · {zone:1432} Loch Modan
	["A robe at 15 for Alliance mages, from {zone:1453} and {zone:1432}."] = "Eine Robe mit Stufe 15 für Allianzmagier, aus {zone:1453} und {zone:1432}.",

	-- Step 1: Zaldimar Wefhellt (Goldshire)
	-- {npc:328} Zaldimar Wefhellt
	["{npc:328} (Goldshire)"] = "",
	-- {npc:328} Zaldimar Wefhellt
	["{npc:328} is the Goldshire mage trainer, upstairs in the Lion's Pride Inn."] = "",

	-- Step 2: Dink (Ironforge)
	-- {npc:7312} Dink · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {object:171524} Tinker Town · {zone:1453} Stormwind
	["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the Deeprun Tram from {object:171524} to {zone:1453} afterwards."] = "",

	-- Step 3: Jennea Cannon
	-- {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {item:7247} Chest of Containment Coffers · {item:7308} Cantation of Manifestation
	["{npc:5497} stands at the top of the Wizard's Sanctum, the violet tower of the {object:2101}: climb the spiral ramp and take the portal near the top. The {item:7247} and the {item:7308} lie on the table behind her (both come back 5 minutes after someone takes them). You hand both in at the end, so keep them."] = "",

	-- Step 4: The Blue Recluse
	-- {object:2169} The Blue Recluse · {object:2101} Mage Quarter · {item:7308} Cantation of Manifestation · {item:7247} Chest of Containment Coffers · {item:7292} Filled Containment Coffer
	-- plural, as words: Rift Spawns = {npc:6492} Rift Spawn
	["{object:2169} is the tavern in the {object:2101}. Read the {item:7308} inside to make the invisible Rift Spawns (level 16-17) show: in the basement it brings out one, on the balcony or in the kitchen two, in the main room or by the door three, so read it downstairs. They hit hard and break out of Frost Nova fast. Beat one down: it does not die but sits stunned with a spiral over its head; use the {item:7247} on it while it is stunned, then click the {item:7292} it leaves on the floor (clicking before it appears wastes a charge). You need three, and the cantation works only once every 5 minutes (logging out does not reset it), so plan on three rounds."] = "",
	-- {npc:6492} Rift Spawn
	["{npc:6492}, down to the stun"] = "",
	-- {item:7247} Chest of Containment Coffers · {npc:6492} Rift Spawn
	["{item:7247}, on the stunned {npc:6492}"] = "",

	-- Step 5: Back to Jennea Cannon
	-- {npc:5497} Jennea Cannon
	["Back to {npc:5497}"] = "Zurück zu {npc:5497}",

	-- Step 6: Linen Cloth
	-- {item:2589} Linen Cloth · {object:2096} Trade District
	["Any humanoid drops {item:2589}, and the Tunnel Rats in the Silver Stream Mine drop it while you gather the gems; the Auction House in the {object:2096} sells it. You hand in ten."] = "",

	-- Step 7: The Silver Stream Mine
	["The Silver Stream Mine"] = "",
	-- {zone:1455} Ironforge · {zone:1432} Loch Modan · {object:271} Miners' League Crates
	["Take the Deeprun Tram to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The Silver Stream Mine is at the north end of the loch, north of Thelsamar; Tunnel Rat kobolds hold it. The gems come only from the tall stacked {object:271} (the cursor shows a cog over them; single boxes hold nothing): every crate gives one, there are fourteen and they come back after 3 to 5 minutes. You may have to go as deep as the end chamber for six. The same crates serve the dwarves' Filthy Paws quest."] = "",

	-- Step 8: Wynne Larson
	-- {zone:1453} Stormwind · {npc:1309} Wynne Larson · {object:23296} Larson Clothiers · {object:2101} Mage Quarter
	["Back to {zone:1453} by the tram. {npc:1309} works at {object:23296} in the {object:2101}."] = "Mit der Bahn zurück nach {zone:1453}. {npc:1309} arbeitet bei {object:23296} in {object:2101}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Humanoids drop {item:2589}; the Auction House in the {object:2096} sells it."] = "Humanoide lassen {item:2589} fallen; das Auktionshaus in {object:2096} verkauft es.",
	-- ["Take the {area:2257} to {zone:1455}, then the road east through the South Gate tunnel into {zone:1432}. The dwarven miners' league left the crates in the {area:149} at the north end of the loch; Tunnel Rat troggs hold the mine."] = "Nimm {area:2257} nach {zone:1455}, dann die Straße nach Osten durch den Tunnel am Südtor nach {zone:1432}. Die Minenarbeiterliga der Zwerge hat die Kisten in {area:149} am Nordende des Sees zurückgelassen; Troggs der Tunnelratten halten die Mine.",
	-- ["The {area:149}"] = "{area:149}",
	-- ["{npc:328} is the {area:87} mage trainer."] = "{npc:328} ist der Magierlehrer in {area:87}.",
	-- ["{npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}. The {item:7247} and the {item:7308} lie behind her."] = "{npc:5497} steht im Magiersanktum, dem Turm in {object:2101}. {item:7247} und {item:7308} liegen hinter ihr.",
	-- ["{npc:7312} teaches mages in {zone:1455}'s {object:32362}. Take the {area:2257} from {object:171524} to {zone:1453} afterwards."] = "{npc:7312} unterrichtet Magier in {object:32362} in {zone:1455}. Nimm danach {area:2257} von {object:171524} nach {zone:1453}.",
	-- ["{object:2169} is the tavern in the {object:2101}. Use the {item:7308} inside to make the {npc:6492} visible, subdue one with your spells, then use the {item:7247} to throw down a coffer and capture it."] = "{object:2169} ist die Taverne in {object:2101}. Benutze dort {item:7308}, um {npc:6492} sichtbar zu machen, bezwinge eine mit deinen Zaubern und benutze dann {item:7247}, um einen Kasten hinzuwerfen und sie einzufangen.",
}
