-- German (deDE): the guide forever/class/mage/teleports-alliance (forever/class/mage/teleports-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Alliance)"] = "Teleports und Portale (Allianz)",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "Deine Stadtteleports mit 20 und 30 und die Gruppenportale mit 40 und 50, jeweils vom Portallehrer der Stadt.",

	-- Step 1: Teleport: Stormwind
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:2485} Larimaine Purdue · {spell:3561} Teleport: Stormwind · {item:17031} Rune of Teleportation · {npc:1308} Owen Vaughn
	["At 20 go to the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:2485}, the portal trainer, stands at the very top: climb the spiral ramp and take the portal near the top. She teaches {spell:3561} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor; {npc:1308} sells them at the foot of the tower), so carry a few."] = "Geh mit Stufe 20 zum Wizard's Sanctum, dem violetten Turm im {object:2101} von {zone:1453}. {npc:2485}, die Portallehrerin, steht ganz oben: Steig die Spiralrampe hinauf und nimm das Portal nahe dem oberen Ende. Sie bringt dir {spell:3561} für 20 Silber bei. Jeder Teleport verbraucht eine {item:17031} (10 Silber bei jedem Reagenzienhändler; {npc:1308} verkauft sie am Fuß des Turms), nimm also ein paar mit.",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}, je 10s",

	-- Step 2: Teleport: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:2489} Milstaff Stormeye · {object:32362} Mystic Ward (no name in this language: may be words) · {spell:3562} Teleport: Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455}. {npc:2489}, the portal trainer, stands with the mage trainers in the {object:32362} at the back of the city: {spell:3562}, 20 silver."] = "Nimm die {area:2257} vom {object:28027} von {zone:1453} nach {zone:1455}. {npc:2489}, der Portallehrer, steht bei den Magierlehrern im {object:32362} hinten in der Stadt: {spell:3562}, 20 Silber.",

	-- Step 3: Teleport: Darnassus
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:4165} Elissa Dumas · {spell:3565} Teleport: Darnassus
	["At 30. Take the boat from {area:17203} to {area:442} in {zone:1439}, then the boat to {area:702} and the pink portal up into {zone:1457}. {npc:4165}, the portal trainer, teaches {spell:3565} for 80 silver."] = "Mit Stufe 30. Nimm das Boot von {area:17203} nach {area:442} in {zone:1439}, dann das Boot nach {area:702} und das rosa Portal nach oben in {zone:1457}. {npc:4165}, die Portallehrerin, bringt dir {spell:3565} für 80 Silber bei.",

	-- Step 4: Portals to Stormwind and Ironforge
	-- {zone:1453} Stormwind · {zone:1455} Ironforge
	["Portals to {zone:1453} and {zone:1455}"] = "Portale nach {zone:1453} und {zone:1455}",
	-- {item:17032} Rune of Portals · {npc:2485} Larimaine Purdue · {spell:10059} Portal: Stormwind · {npc:2489} Milstaff Stormeye · {zone:1455} Ironforge · {object:32362} Mystic Ward (no name in this language: may be words) · {spell:11416} Portal: Ironforge
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:2485} has {spell:10059} at the top of the Wizard's Sanctum; then the tram to {npc:2489} in {zone:1455}'s {object:32362} for {spell:11416}."] = "Mit Stufe 40 bringen dir die Portallehrer die Portale bei: ein Tor, durch das deine ganze Gruppe treten kann, für je 1 Gold 50 Silber. Jedes Portal verbraucht eine {item:17032} (20 Silber bei jedem Reagenzienhändler). {npc:2485} hat {spell:10059} oben im Wizard's Sanctum; nimm dann die Tiefenbahn zu {npc:2489} im {object:32362} von {zone:1455} für {spell:11416}.",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}, je 20s",

	-- Step 5: Portal: Darnassus
	-- {npc:4165} Elissa Dumas · {zone:1457} Darnassus · {spell:11419} Portal: Darnassus · {spell:3565} Teleport: Darnassus
	["At 50 {npc:4165} in {zone:1457} teaches the last one, {spell:11419}, for 3 gold 20 silver. Use your {spell:3565} to get there."] = "Mit Stufe 50 bringt dir {npc:4165} in {zone:1457} das letzte bei, {spell:11419}, für 3 Gold 20 Silber. Nutze dein {spell:3565}, um hinzukommen.",
}
