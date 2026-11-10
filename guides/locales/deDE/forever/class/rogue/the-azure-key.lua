-- German (deDE): the guide forever/class/rogue/the-azure-key (forever/class/rogue/the-azure-key.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ravenholdt reputation and experience at 50; Classic's item choice may be gone on Forever."] = "Ruf bei Rabenholdt und Erfahrung mit 50; die Gegenstandswahl aus Classic könnte in Forever entfallen sein.",
	["Ravenholdt reputation"] = "Ruf bei Ravenholdt",

	-- Step 1: A Simple Request (Alliance)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Alliance)"] = "{quest:8233} (Allianz)",
	-- {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {object:2100} Old Town · {zone:1457} Darnassus · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} in {zone:1455}."] = "Mit 50 hat {npc:918} in {object:2100} von {zone:1453} sie; ebenso Syurna in {zone:1457} und {npc:5165} in {zone:1455}.",

	-- Step 2: A Simple Request (Horde)
	-- {quest:8233} A Simple Request
	["{quest:8233} (Horde)"] = "{quest:8233} (Horde)",
	-- {npc:3328} Ormok · {object:172960} Cleft of Shadow · {npc:4583} Miles Dexter · {zone:1458} Undercity · {object:36073} Rogues' Quarter
	["At 50 {npc:3328} in the {object:172960} has it; so does {npc:4583} in the {zone:1458}'s {object:36073}."] = "Auf Stufe 50 hat {npc:3328} in der {object:172960} sie; ebenso {npc:4583} im {object:36073} von {zone:1458}.",

	-- Step 3: Lord Jorach Ravenholdt
	-- {area:3486} Ravenholdt Manor · {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {zone:1416} Alterac Mountains
	["{area:3486} hides in the hills east of {area:272}. Horde fly to {area:272}, Alliance to {area:271}. The trail starts behind the plateau north of {area:275}, climbs into the hills and runs through a small tunnel into the {zone:1416}; Lord Jorach is inside the manor. Do not attack anyone at the manor: lost Ravenholdt reputation makes him refuse to speak to you."] = "{area:3486} versteckt sich in den Hügeln östlich von {area:272}. Die Horde fliegt nach {area:272}, die Allianz nach {area:271}. Der Pfad beginnt hinter dem Plateau nördlich von {area:275}, führt in die Hügel und durch einen kleinen Tunnel in das {zone:1416}; Lord Jorach ist im Anwesen. Greife im Anwesen niemanden an: Verlorener Ruf bei Rabenholdt führt dazu, dass er sich weigert, mit dir zu sprechen.",

	-- Step 4: Sealed Azure Bag
	-- {area:3137} Talrendis Point · {area:1237} Valormok · {zone:1447} Azshara · {spell:921} Pick Pocket · {area:1769} Timbermaw Hold · {spell:403} Lightning Bolt · {spell:6535} Lightning Cloud
	-- plural, as words: Timbermaw Shamans = {npc:6188} Timbermaw Shaman
	["Alliance fly to {area:3137}, Horde to {area:1237}. Only the level 50-51 Timbermaw Shamans in the furbolg hills of northern {zone:1447} carry the bag (the level 47-49 furbolgs further south do not): about one kill in thirty drops it. {spell:921} them instead and you lose no Timbermaw reputation; if you are Unfriendly or better with {area:1769}, mark them At War in your reputation panel first. They cast {spell:403} and {spell:6535}, heal each other and run at low health."] = "Die Allianz fliegt nach {area:3137}, die Horde nach {area:1237}. Nur die Timbermaw Shamans der Stufe 50-51 in den Furbolg-Hügeln im Norden von {zone:1447} tragen die Tasche (die Furbolgs der Stufe 47-49 weiter südlich nicht): Etwa jeder dreißigste Kill lässt sie fallen. Bestiehl sie stattdessen mit {spell:921}, dann verlierst du keinen Ruf bei den Timbermaw; wenn du bei {area:1769} Unfreundlich oder besser bist, setze sie vorher in deinem Rufpanel auf Im Krieg. Sie wirken {spell:403} und {spell:6535}, heilen sich gegenseitig und laufen bei wenig Leben weg.",

	-- Step 5: Archmage Xylem
	-- {npc:8395} Sanath Lim-yo · {area:1237} Valormok
	["{npc:8395}, camped below the cliffs just east of {area:1237}, teleports you up (dismount first); a trail leads to Xylem's tower."] = "{npc:8395}, der unter den Klippen östlich von {area:1237} lagert, teleportiert dich nach oben (steig vorher ab); ein Pfad führt zu Xylems Turm.",

	-- Step 6: Encoded Fragments
	-- {spell:6907} Diseased Slime · {area:2497} Bitter Reaches · {zone:1447} Azshara · {area:1237} Valormok
	-- plural, as words: Forest Oozes = {npc:8766} Forest Ooze · Mistwing Ravagers = {npc:8764} Mistwing Ravager
	["The Forest Oozes (level 52-53, {spell:6907} up close) drop a fragment four times in five: the biggest group, seven of them, is in the {area:2497} hills of north-eastern {zone:1447}, four more south-east of {area:1237}. Pick their pockets before the kill for an extra fragment or two. Killing the Mistwing Ravagers and hippogryphs that share their spots makes more oozes appear."] = "Die Forest Oozes (Stufe 52-53, aus der Nähe {spell:6907}) lassen in vier von fünf Fällen einen Splitter fallen: Die größte Gruppe, sieben von ihnen, ist in den Hügeln von {area:2497} im Nordosten von {zone:1447}, vier weitere südöstlich von {area:1237}. Bestiehl sie vor dem Kill für einen oder zwei zusätzliche Splitter. Das Töten der Mistwing Ravagers und Hippogreife, die dieselben Plätze teilen, lässt mehr Oozes erscheinen.",

	-- Step 7: Back to Xylem
	["Back to Xylem"] = "Zurück zu Xylem",

	-- Step 8: Morphaz in the Sunken Temple
	-- {area:1417} Sunken Temple
	["Morphaz in the {area:1417}"] = "Morphaz im {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {area:75} Stonard · {area:1438} Nethergarde Keep · {npc:5710} Jammal'an the Prophet · {spell:12533} Acid Breath · {spell:2094} Blind
	["Morphaz, a level 52 elite green drake, lives deep in the {area:1417}: a group of five, level 50-54. The temple stands in the {area:74}; climb into the sunken building, swim down through it and follow the passage to the portal. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on. He is not there when you arrive: first kill the six troll guardians (elites of 50-52) on the platforms around the upper ring, which opens the way down (the left-hand ramp from the entrance) to {npc:5710} in the Pit of Sacrifice. Jammal'an's death brings out two drakes, Weaver and Dreamscythe; when both are dead, Morphaz and Hazzas appear together and fight as a pair. Their {spell:12533} is nature damage: nature protection potions help; poisons and {spell:2094} do not work on them. The key always drops. Hunters, Priests and Mages of 50 need Morphaz too: one clear serves them all."] = "Morphaz, ein grüner Elite-Drache der Stufe 52, lebt tief im {area:1417}: eine Gruppe aus fünf, Stufe 50-54. Der Tempel steht im {area:74}; klettere in das versunkene Gebäude, schwimm hindurch nach unten und folge dem Gang zum Portal. Horde: Flieg nach {area:75}; Allianz: Flieg nach {area:1438} und reite weiter. Er ist bei deiner Ankunft nicht da: Töte zuerst die sechs Troll-Wächter (Elite, 50-52) auf den Plattformen rund um den oberen Ring, was den Weg nach unten öffnet (die linke Rampe vom Eingang) zu {npc:5710} in der Pit of Sacrifice. Jammal'ans Tod bringt zwei Drachen hervor, Weaver und Dreamscythe; wenn beide tot sind, erscheinen Morphaz und Hazzas zusammen und kämpfen als Paar. Ihr {spell:12533} ist Naturschaden: Naturschutztränke helfen; Gifte und {spell:2094} wirken bei ihnen nicht. Der Schlüssel fällt immer. Jäger, Priester und Magier der Stufe 50 brauchen Morphaz ebenfalls: Ein Durchgang dient allen.",
	-- {item:20022} Azure Key
	["{item:20022}: Morphaz, inside the temple"] = "{item:20022}: Morphaz, im Tempel",

	-- Step 9: Lord Ravenholdt
	["Lord Ravenholdt"] = "Lord Ravenholdt",
	-- {item:19982} Duskbat Drape · {item:19984} Ebon Mask · {item:20255} Whisperwalk Boots
	["Look at the reward window before you hand in: Classic offered the {item:19982}, the {item:19984} or the {item:20255}, and Forever's notes say the choice may be gone."] = "Sieh dir das Belohnungsfenster an, bevor du abgibst: Classic bot {item:19982}, {item:19984} oder {item:20255}, und Forevers Hinweise besagen, dass die Wahl entfallen sein könnte.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alliance fly to {area:3137}, Horde to {area:1237}. The Timbermaw Shamans in {zone:1447}'s northern hills drop the bag, about one in thirty."] = "Allianz fliegt nach {area:3137}, Horde nach {area:1237}. Die Schamanen der Holzschlundfeste in den nördlichen Hügeln von {zone:1447} lassen die Tasche fallen, etwa eine von dreißig.",
	-- ["At 50 {npc:918} in {zone:1453}'s {object:2100} has it; so do Syurna in {zone:1457} and {npc:5165} and Fenthwick in {zone:1455}."] = "Auf Stufe 50 hat {npc:918} in {object:2100} in {zone:1453} sie; ebenso Syurna in {zone:1457} sowie {npc:5165} und Fenthwick in {zone:1455}.",
	-- ["Morphaz, a green drake, is an elite boss deep in the {area:1417}, a level 50 dungeon: bring a group of five. The temple stands in the {area:74}; swim down to the entrance. Horde: fly to {area:75}; Alliance: fly to {area:1438} and ride on."] = "Morphaz, ein grüner Drache, ist ein Elite-Boss tief im {area:1417}, einem Dungeon der Stufe 50: Bring eine Gruppe von fünf mit. Der Tempel steht im {area:74}; schwimm hinab zum Eingang. Horde: Flieg nach {area:75}; Allianz: Flieg nach {area:1438} und reite weiter.",
	-- ["Ravenholdt reputation and experience at 50; Forever removed the Classic item choice."] = "Ruf bei Ravenholdt und Erfahrung auf Stufe 50; Forever hat die Gegenstandsauswahl aus Classic entfernt.",
	-- ["The Forest Oozes of southern {zone:1447} drop the fragments."] = "Die Waldbrühschlammer im südlichen {zone:1447} lassen die Fragmente fallen.",
	-- ["{area:3486} hides in the hills east of {area:272}, up a path into the {zone:1416}. Horde fly to {area:272}, Alliance to {area:271}."] = "{area:3486} versteckt sich in den Hügeln östlich von {area:272}, einen Pfad hinauf ins {zone:1416}. Horde fliegt nach {area:272}, Allianz nach {area:271}.",
	-- ["{npc:6768}: no item choices in Forever"] = "{npc:6768}: In Forever keine Gegenstandsauswahl",
}
