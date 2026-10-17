-- German (deDE): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "Der seltene Zweihandstreitkolben der Allianz-Paladine für die 20er, mit einem Schild unterwegs.",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32362} Mystic Ward (no name in this language: may be words) · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {zone:1455} Ironforge
	["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "Mit 20 gibt dir {npc:6179} in der {object:32362} {item:6776}; er schickt dich zu {npc:6171} in der Kathedrale des Lichts in {zone:1453}. Nimm die Tiefenbahn von {zone:1455} nach {zone:1453}.",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171} steht in der Kathedrale des Lichts. Rechtsklicke {item:6776}, um seine Quest zu starten.",
	-- {item:6776} Tome of Valor
	["from the {item:6776}"] = "von {item:6776}",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "Das Bauernhaus von {npc:6182} steht an der Südwestküste von {zone:1436}. Während ihrer Quest greifen es Wellen von Defias an: Halte sie am Leben und heile sie, wenn nötig.",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}"] = "Beschütze {npc:6182}",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181} steht vor den Toren von {zone:1455}. Er gibt dir {item:6996}, in denen die vier Teile aufgeführt sind.",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is in {area:144}."] = "{npc:6241} ist in {area:144}.",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "Die Erzkiste liegt bei den Bäumen mitten im Lager der Oger der Mo'grosh im Nordosten von {zone:1432}. Die Oger der Mo'grosh sind Elite: Eine Gruppe wird empfohlen.",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "Kiste: {object:92420}",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "Zurück zu {npc:6241}",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241} macht aus dem Erz {item:6993}.",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581} ist für eine Gruppe von fünf unter {area:20}; das Instanzportal liegt in der Mine von {area:20}. Die Goblin-Holzschnitzer bei Sneed in der Mast Room lassen das Holz fallen.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, in der Mine von {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Goblin-Holzschnitzer, drinnen",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest
	["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236} ist ein Dungeon der Stufe 20-30 im Süden des {zone:1421}. Der Hammer liegt auf einer Kiste in den Ställen, am hinteren Ende des Hofs vor der Rampe nach oben.",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}, drinnen",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}."] = "{npc:3649} ist in {area:442}.",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem
	["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "Die Blackfathom-Naga am Eingang der {area:2797} an der Nordwestküste von {zone:1440} lassen {item:6995} fallen. Sie sind Elite: Eine Gruppe wird empfohlen.",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "{item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "Zurück zu {npc:3649} in {area:442}: Er reinigt den Edelstein.",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}."] = "Bring die vier Teile zu {npc:6181} vor {zone:1455}.",
}
