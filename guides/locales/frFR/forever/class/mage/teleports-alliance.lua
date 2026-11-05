-- French (frFR): the guide forever/class/mage/teleports-alliance (forever/class/mage/teleports-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Teleports and Portals (Alliance)"] = "Téléportations et portails (Alliance)",
	["Your city teleports at 20 and 30 and the group portals at 40 and 50, from each city's portal trainer."] = "Les téléportations vers vos villes aux niveaux 20 et 30 et les portails de groupe aux niveaux 40 et 50, auprès du maître des portails de chaque ville.",

	-- Step 1: Teleport: Stormwind
	-- {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:2485} Larimaine Purdue · {spell:3561} Teleport: Stormwind · {item:17031} Rune of Teleportation · {npc:1308} Owen Vaughn
	["At 20 go to the Wizard's Sanctum, the violet tower of {zone:1453}'s {object:2101}. {npc:2485}, the portal trainer, stands at the very top: climb the spiral ramp and take the portal near the top. She teaches {spell:3561} for 20 silver. Every teleport burns one {item:17031} (10 silver at any reagent vendor; {npc:1308} sells them at the foot of the tower), so carry a few."] = "Au niveau 20, allez au Sanctuaire des sorciers, la tour violette du {object:2101} de {zone:1453}. {npc:2485}, la maîtresse des portails, se tient tout en haut : montez la rampe en spirale et prenez le portail près du sommet. Elle enseigne {spell:3561} pour 20 pa. Chaque téléportation consomme une {item:17031} (10 pa chez tout marchand de composants ; {npc:1308} en vend au pied de la tour) : emportez-en quelques-unes.",
	-- {item:17031} Rune of Teleportation
	["{item:17031}, 10s each"] = "{item:17031}, 10 pa pièce",

	-- Step 2: Teleport: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:2489} Milstaff Stormeye · {object:32362} Mystic Ward · {spell:3562} Teleport: Ironforge
	["Take the {area:2257} from {zone:1453}'s {object:28027} to {zone:1455}. {npc:2489}, the portal trainer, stands with the mage trainers in the {object:32362} at the back of the city: {spell:3562}, 20 silver."] = "Prenez le {area:2257} depuis le {object:28027} de {zone:1453} jusqu'à {zone:1455}. {npc:2489}, le maître des portails, se tient avec les maîtres des mages dans {object:32362}, au fond de la ville : {spell:3562}, 20 pa.",

	-- Step 3: Teleport: Darnassus
	-- {area:17203} Stormwind Harbor · {area:442} Auberdine · {zone:1439} Darkshore · {area:702} Rut'theran Village · {zone:1457} Darnassus · {npc:4165} Elissa Dumas · {spell:3565} Teleport: Darnassus
	["At 30. Take the boat from {area:17203} to {area:442} in {zone:1439}, then the boat to {area:702} and the pink portal up into {zone:1457}. {npc:4165}, the portal trainer, teaches {spell:3565} for 80 silver."] = "Au niveau 30. Prenez le bateau du {area:17203} à {area:442}, en {zone:1439}, puis le bateau pour le {area:702} et le portail rose qui monte à {zone:1457}. {npc:4165}, la maîtresse des portails, enseigne {spell:3565} pour 80 pa.",

	-- Step 4: Portals to Stormwind and Ironforge
	-- {zone:1453} Stormwind · {zone:1455} Ironforge
	["Portals to {zone:1453} and {zone:1455}"] = "Portails vers {zone:1453} et {zone:1455}",
	-- {item:17032} Rune of Portals · {npc:2485} Larimaine Purdue · {spell:10059} Portal: Stormwind · {npc:2489} Milstaff Stormeye · {zone:1455} Ironforge · {object:32362} Mystic Ward · {spell:11416} Portal: Ironforge
	["At 40 the portal trainers teach the portals: a gateway your whole group can step through, for 1 gold 50 silver each. Each portal burns one {item:17032} (20 silver at any reagent vendor). {npc:2485} has {spell:10059} at the top of the Wizard's Sanctum; then the tram to {npc:2489} in {zone:1455}'s {object:32362} for {spell:11416}."] = "Au niveau 40, les maîtres des portails enseignent les portails : un passage que tout votre groupe peut emprunter, pour 1 po 50 pa chacun. Chaque portail consomme une {item:17032} (20 pa chez tout marchand de composants). {npc:2485} propose {spell:10059} au sommet du Sanctuaire des sorciers ; prenez ensuite le tram jusqu'à {npc:2489}, dans {object:32362} de {zone:1455}, pour {spell:11416}.",
	-- {item:17032} Rune of Portals
	["{item:17032}, 20s each"] = "{item:17032}, 20 pa pièce",

	-- Step 5: Portal: Darnassus
	-- {npc:4165} Elissa Dumas · {zone:1457} Darnassus · {spell:11419} Portal: Darnassus · {spell:3565} Teleport: Darnassus
	["At 50 {npc:4165} in {zone:1457} teaches the last one, {spell:11419}, for 3 gold 20 silver. Use your {spell:3565} to get there."] = "Au niveau 50, {npc:4165} à {zone:1457} enseigne le dernier, {spell:11419}, pour 3 po 20 pa. Utilisez votre {spell:3565} pour vous y rendre.",
}
