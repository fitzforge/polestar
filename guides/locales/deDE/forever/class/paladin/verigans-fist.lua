-- German (deDE): the guide forever/class/paladin/verigans-fist (forever/class/paladin/verigans-fist.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5502} Sense Undead
	["The Alliance paladin's rare two-handed mace for the 20s, with a shield and {spell:5502} on the way."] = "Der seltene Zweihandstreitkolben des Allianz-Paladins für die 20er, mit einem Schild und {spell:5502} auf dem Weg.",

	-- Step 1: The Tome of Valor (Ironforge)
	-- {npc:6179} Tiza Battleforge · {object:32386} Hall of Mysteries (no name in this language: may be words) · {object:32362} Mystic Ward (no name in this language: may be words) · {item:6776} Tome of Valor · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {area:2257} Deeprun Tram · {zone:1455} Ironforge
	["At 20 {npc:6179}, upstairs in the {object:32386} in the {object:32362}, gives you the {item:6776}. Right-click it: it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the {area:2257} from {zone:1455} to {zone:1453}."] = "Mit 20 gibt dir {npc:6179}, oben im {object:32386} in {object:32362}, {item:6776}. Klicke es mit der rechten Maustaste an: Es schickt dich zu {npc:6171} in die Kathedrale des Lichts in {zone:1453}. Nimm {area:2257} von {zone:1455} nach {zone:1453}.",

	-- Step 2: The Tome of Valor
	-- {npc:6171} Duthorian Rall · {item:6776} Tome of Valor
	["{npc:6171} stands in the Cathedral of Light. Humans get the {item:6776} from him. Right-click the book to start its quest and hand it straight back to him."] = "{npc:6171} steht in der Kathedrale des Lichts. Menschen bekommen {item:6776} von ihm. Klicke das Buch mit der rechten Maustaste an, um seine Quest zu beginnen, und gib sie gleich bei ihm ab.",
	-- {item:6776} Tome of Valor
	["Right-click the {item:6776}"] = "Klicke {item:6776} mit der rechten Maustaste an",

	-- Step 3: Daphne Stilwell
	-- {npc:6182} Daphne Stilwell · {zone:1436} Westfall · {area:20} Moonbrook · {area:1581} Deadmines
	-- plural, as words: Defias Raiders = {npc:6180} Defias Raider
	["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}, south of {area:20}: take the path that runs south beside the {area:1581}' back exit. When you take her quest, she walks from her orchard to the house and three waves of Defias Raiders (level 17-18) attack: three, then four, then five. Fight close to her so they do not swarm her, and heal her when she drops. You get time to eat and drink between waves, and she heals to full. If you or {npc:6182} die, the quest fails: abandon it and take it again from her (she is back five minutes after dying). Players find it hard alone before about 24."] = "Das Bauernhaus von {npc:6182} steht an der Südwestküste von {zone:1436}, südlich von {area:20}: Nimm den Pfad, der südlich neben dem hinteren Ausgang von {area:1581} verläuft. Wenn du ihre Quest annimmst, geht sie von ihrem Obstgarten zum Haus, und drei Wellen Defias Raiders (Stufe 17-18) greifen an: drei, dann vier, dann fünf. Kämpfe nah bei ihr, damit sie nicht überrannt wird, und heile sie, wenn sie fällt. Zwischen den Wellen hast du Zeit zum Essen und Trinken, und sie wird voll geheilt. Wenn du oder {npc:6182} stirbt, schlägt die Quest fehl: Brich sie ab und nimm sie erneut bei ihr an (sie ist fünf Minuten nach ihrem Tod zurück). Allein finden Spieler sie vor etwa Stufe 24 schwer.",
	-- {npc:6182} Daphne Stilwell
	["Protect {npc:6182}: three waves"] = "Beschütze {npc:6182}: drei Wellen",

	-- Step 4: Duthorian Rall
	-- {npc:6171} Duthorian Rall · {item:9607} Bastion of Stormwind · {spell:5502} Sense Undead
	["Back to the Cathedral of Light: {npc:6171} gives you the {item:9607} shield and teaches you {spell:5502}."] = "Zurück zur Kathedrale des Lichts: {npc:6171} gibt dir den Schild {item:9607} und bringt dir {spell:5502} bei.",

	-- Step 5: Jordan Stilwell
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge · {item:6996} Jordan's Weapon Notes
	["{npc:6181} works outside the gates of {zone:1455}, not inside. He gives you {item:6996}: four parts, in any order. Keep the notes."] = "{npc:6181} arbeitet vor den Toren von {zone:1455}, nicht darin. Er gibt dir {item:6996}: vier Teile, in beliebiger Reihenfolge. Behalte die Notizen.",

	-- Step 6: Bailor Stonehand
	-- {npc:6241} Bailor Stonehand · {area:144} Thelsamar
	["{npc:6241} is downstairs in the house of {area:144} that has a tailoring merchant outside. His quest only opens once you hold Jordan's."] = "{npc:6241} ist unten in dem Haus in {area:144}, vor dem ein Schneiderhändler steht. Seine Quest wird erst frei, wenn du Jordans Notizen hast.",

	-- Step 7: Bailor's Ore
	-- {zone:1432} Loch Modan
	["The crate of ore sits outdoors in the middle of the Mo'grosh ogre camp in north-east {zone:1432}, beside a big tree and a broken wagon, between the caves. The camp holds about fifteen Mo'grosh ogres, elite (level 18-19), who knock you down and come back after five minutes: grouping up is encouraged; at 20-22 it needs a group of about three. The crate is back two seconds after each loot, so every paladin in the group gets one."] = "Die Erzkiste steht im Freien mitten im Lager der Mo'grosh-Oger im Nordosten von {zone:1432}, neben einem großen Baum und einem kaputten Wagen, zwischen den Höhlen. Im Lager sind etwa fünfzehn Mo'grosh-Oger, Elite (Stufe 18-19), die dich umwerfen und nach fünf Minuten zurückkommen: Sich zu gruppieren ist empfehlenswert; mit 20-22 braucht man eine Gruppe von etwa drei Spielern. Die Kiste ist zwei Sekunden nach jedem Plündern wieder da, sodass jeder Paladin in der Gruppe eine bekommt.",
	-- {object:92420} Bailor's Ore
	["{object:92420} crate"] = "Kiste: {object:92420}",

	-- Step 8: Back to Bailor Stonehand
	-- {npc:6241} Bailor Stonehand
	["Back to {npc:6241}"] = "Zurück zu {npc:6241}",
	-- {npc:6241} Bailor Stonehand · {item:6993} Jordan's Refined Ore Shipment
	["{npc:6241} turns the ore into {item:6993}, the part Jordan wants."] = "{npc:6241} verarbeitet das Erz zu {item:6993}, dem Teil, das Jordan will.",

	-- Step 9: Whitestone Oak Lumber
	-- {area:1581} Deadmines · {area:20} Moonbrook
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["{area:1581} is a group of five under {area:20}; the instance portal is at the bottom of the {area:20} mine. The Goblin Woodcarvers (elite, level 18-19) in the mast room with Sneed drop the lumber every time."] = "{area:1581} ist ein Dungeon für fünf Spieler unter {area:20}; das Instanzportal liegt am Ende der Mine von {area:20}. Die Goblin Woodcarvers (Elite, Stufe 18-19) im Mastraum bei Sneed lassen das Holz jedes Mal fallen.",
	-- {area:1581} Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, in der Mine von {area:20}",
	-- plural, as words: Goblin Woodcarvers = {npc:641} Goblin Woodcarver
	["Goblin Woodcarvers, inside"] = "Goblin-Holzschnitzer, drinnen",

	-- Step 10: Jordan's Smithing Hammer
	-- {area:236} Shadowfang Keep · {zone:1421} Silverpine Forest · {zone:1437} Wetlands · {area:287} Hillsbrad
	["{area:236} is a dungeon for a group of five in the low to mid 20s, in southern {zone:1421}, Horde land: a long trip for the Alliance, through the {zone:1437}, Arathi and {area:287}. The hammer lies on a crate across from the horses in the stables, early in the dungeon, at the far end of the courtyard before the ramp up; it is back five minutes after someone takes it."] = "{area:236} ist ein Dungeon für eine Gruppe aus fünf Spielern in den unteren bis mittleren 20ern, im Süden von {zone:1421}, Horde-Gebiet: eine lange Reise für die Allianz, durch {zone:1437}, Arathi und {area:287}. Der Hammer liegt auf einer Kiste gegenüber den Pferden in den Ställen, früh im Dungeon, am Ende des Hofs vor der Rampe nach oben; er ist fünf Minuten nach dem Aufnehmen wieder da.",
	-- {object:91138} Jordan's Hammer
	["{object:91138}, inside"] = "{object:91138}, drinnen",

	-- Step 11: Thundris Windweaver
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["{npc:3649} is in {area:442}. Take his quest before you hunt naga: the Kor Gem never drops without it."] = "{npc:3649} ist in {area:442}. Nimm seine Quest an, bevor du Naga jagst: Der Kor Gem fällt ohne sie nie.",

	-- Step 12: The Corrupted Kor Gem
	-- {item:6995} Corrupted Kor Gem
	["The {item:6995}"] = "{item:6995}",
	-- {area:2797} Blackfathom Deeps · {zone:1440} Ashenvale · {item:6995} Corrupted Kor Gem · {spell:122} Frost Nova
	["The Blackfathom naga in the flooded passages around the {area:2797} entrance, on {zone:1440}'s north-west coast, drop the {item:6995}: Tide Priestesses (level 20-21), Oracles (21-22) and Sea Witches (23-24), one in two. You do not need to enter the instance. All are elite: grouping up is encouraged; players solo them one at a time, with difficulty. They heal themselves, run for help at low health, satyrs stand near some, and the Sea Witches cast {spell:122} up close. Some players report no drop while in a raid group."] = "Die Blackfathom Naga in den überfluteten Gängen rund um den Eingang von {area:2797} an der Nordwestküste von {zone:1440} lassen den {item:6995} fallen: Tide Priestesses (Stufe 20-21), Oracles (21-22) und Sea Witches (23-24), jede zweite. Du musst die Instanz nicht betreten. Alle sind Elite: Sich zu gruppieren ist empfehlenswert; Solo schaffst du sie nur einzeln und mit Mühe. Sie heilen sich selbst, rufen bei wenig Leben um Hilfe, bei manchen stehen Satyrn, und die Sea Witches wirken aus der Nähe {spell:122}. Manche Spieler berichten, dass in einer Schlachtzugsgruppe nichts fällt.",

	-- Step 13: The Purified Kor Gem
	-- {item:7083} Purified Kor Gem
	["The {item:7083}"] = "{item:7083}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["Back to {npc:3649} in {area:442}: he purifies the gem."] = "Zurück zu {npc:3649} in {area:442}: Er reinigt den Edelstein.",

	-- Step 14: Verigan's Fist
	-- {npc:6181} Jordan Stilwell · {zone:1455} Ironforge
	["Bring the four parts to {npc:6181} outside {zone:1455}. Accept his last quest and wait by him while he forges the mace at his anvil."] = "Bring die vier Teile zu {npc:6181} vor {zone:1455}. Nimm seine letzte Quest an und warte bei ihm, während er die Keule an seinem Amboss schmiedet.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:6179} in the {object:32362} gives you the {item:6776}; it sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "Mit 20 gibt dir {npc:6179} in der {object:32362} {item:6776}; er schickt dich zu {npc:6171} in der Kathedrale des Lichts in {zone:1453}. Nimm die Tiefenbahn von {zone:1455} nach {zone:1453}.",
	-- ["Bring the four parts to {npc:6181} outside {zone:1455}."] = "Bring die vier Teile zu {npc:6181} vor {zone:1455}.",
	-- ["Protect {npc:6182}"] = "Beschütze {npc:6182}",
	-- ["The Alliance paladin's rare two-handed mace for the 20s, with a shield on the way."] = "Der seltene Zweihandstreitkolben der Allianz-Paladine für die 20er, mit einem Schild unterwegs.",
	-- ["The Blackfathom naga by the entrance of {area:2797} on {zone:1440}'s north-west coast drop the {item:6995}. They are elite: grouping up is advised."] = "Die Blackfathom-Naga am Eingang der {area:2797} an der Nordwestküste von {zone:1440} lassen {item:6995} fallen. Sie sind Elite: Eine Gruppe wird empfohlen.",
	-- ["The ore crate lies by the trees in the middle of the Mo'grosh ogre camp in north-east {zone:1432}. The Mo'grosh ogres are elite: grouping up is advised."] = "Die Erzkiste liegt bei den Bäumen mitten im Lager der Oger der Mo'grosh im Nordosten von {zone:1432}. Die Oger der Mo'grosh sind Elite: Eine Gruppe wird empfohlen.",
	-- ["from the {item:6776}"] = "von {item:6776}",
	-- ["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. The Goblin Woodcarvers in the Mast Room, with Sneed, drop the lumber."] = "{area:1581} ist für eine Gruppe von fünf unter {area:20}; das Instanzportal liegt in der Mine von {area:20}. Die Goblin-Holzschnitzer bei Sneed in der Mast Room lassen das Holz fallen.",
	-- ["{area:236} is a level 20-30 dungeon in southern {zone:1421}. The hammer lies on a box inside the stables, at the far end of the courtyard before the ramp up."] = "{area:236} ist ein Dungeon der Stufe 20-30 im Süden des {zone:1421}. Der Hammer liegt auf einer Kiste in den Ställen, am hinteren Ende des Hofs vor der Rampe nach oben.",
	-- ["{npc:3649} is in {area:442}."] = "{npc:3649} ist in {area:442}.",
	-- ["{npc:6171} stands in the Cathedral of Light. Right-click the {item:6776} to start its quest."] = "{npc:6171} steht in der Kathedrale des Lichts. Rechtsklicke {item:6776}, um seine Quest zu starten.",
	-- ["{npc:6181} stands outside the gates of {zone:1455}. He gives you {item:6996}, which list the four parts."] = "{npc:6181} steht vor den Toren von {zone:1455}. Er gibt dir {item:6996}, in denen die vier Teile aufgeführt sind.",
	-- ["{npc:6182}'s farmhouse stands on the south-west coast of {zone:1436}. Waves of Defias attack it during her quest: keep her alive, and heal her if she needs it."] = "Das Bauernhaus von {npc:6182} steht an der Südwestküste von {zone:1436}. Während ihrer Quest greifen es Wellen von Defias an: Halte sie am Leben und heile sie, wenn nötig.",
	-- ["{npc:6241} is in {area:144}."] = "{npc:6241} ist in {area:144}.",
	-- ["{npc:6241} turns the ore into {item:6993}."] = "{npc:6241} macht aus dem Erz {item:6993}.",
}
