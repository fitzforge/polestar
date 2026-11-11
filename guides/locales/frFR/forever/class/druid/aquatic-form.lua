-- French (frFR): the guide forever/class/druid/aquatic-form (forever/class/druid/aquatic-form.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Your water travel form: swim fast and breathe underwater, with a belt and an idol besides."] = "Votre forme de voyage aquatique : nagez vite et respirez sous l'eau, avec en plus une ceinture et une idole.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. Skyborne: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up."] = "{npc:4217} se tient à l'étage du bâtiment des druides, dans {area:1658}. Éolides : lancez {spell:18960} et prenez le vol de {npc:11800} au milieu de {area:2361} (elle emmène les druides au {area:702}, pas besoin du trajet aérien), puis le portail pour monter.",

	-- Step 3: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:29} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:29} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "Lancez {spell:18960} pour venir ici : {npc:11802} se tient à l'étage du bâtiment à côté de votre point d'arrivée. {quest:29} dure 30 minutes : une fois la quête acceptée, aucune téléportation ni Pierre de foyer tant que {npc:11799} ne l'a pas reçue. Six Conteneurs de babioles (des vases) reposent dans d'étroits creux au fond du {area:656}, sous {area:2361}, souvent près des fissures bouillonnantes (la fissure bouillonnante au milieu du lac vous rend votre souffle) ; chacun revient trois minutes après avoir été ouvert, et d'autres druides les prennent aussi. Vérifiez que la {item:15877} est dans vos sacs avant de remonter : elle disparaît cinq minutes après que vous l'avez ramassée. Nagez tout droit avec jusqu'au {area:2362} sur la rive nord-ouest, utilisez-la dans l'enceinte du sanctuaire et parlez à {npc:11799} près de l'arbre.",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, dans un {object:177785} au fond du lac",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Au {area:2362}",

	-- Step 4: Half Pendant of Aquatic Agility
	-- {area:2361} Nighthaven · {area:442} Auberdine · {object:177792} Strange Lockbox · {area:456} Cliffspring River
	-- plural, as words: Darkshore Threshers = {npc:2185} Darkshore Thresher
	["Fly from {area:2361} to {area:442}. The {object:177792} lies far out on the sea floor off the north coast, between tall rocks west of where the {area:456} reaches the sea: it cannot be seen from the east side of the rocks. Watch your breath and the Darkshore Threshers; fight above water."] = "Prenez un vol de {area:2361} pour {area:442}. Le {object:177792} repose au fond de la mer, loin au large de la côte nord, entre de hauts rochers à l'ouest de l'endroit où la {area:456} rejoint la mer : on ne le voit pas depuis le côté est des rochers. Surveillez votre souffle et les Batteurs de Sombrivage ; combattez hors de l'eau.",
	-- {item:15883} Half Pendant of Aquatic Agility · {object:177792} Strange Lockbox
	["{item:15883}, from the {object:177792}"] = "{item:15883}, dans le {object:177792}",

	-- Step 5: Half Pendant of Aquatic Endurance
	-- {area:442} Auberdine · {zone:1453} Stormwind · {area:108} Sentinel Hill · {object:177790} Strange Lockbox
	["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Head west to the coast: the {object:177790} lies far out on the sea floor beside a bubbling fissure (air), west of a sunken anchor. Sharks roam here; do not swim on past the wreck beyond it, the deep water brings fatigue."] = "Prenez le bateau d'{area:442} pour {zone:1453} et un vol pour {area:108}. Allez vers l'ouest jusqu'à la côte : le {object:177790} repose loin au large, au fond de la mer, à côté d'une fissure bouillonnante (de l'air), à l'ouest d'une ancre engloutie. Des requins rôdent ici ; ne nagez pas au-delà de l'épave qui suit, les eaux profondes provoquent la fatigue.",
	-- {item:15882} Half Pendant of Aquatic Endurance · {object:177790} Strange Lockbox
	["{item:15882}, from the {object:177790}"] = "{item:15882}, dans le {object:177790}",

	-- Step 6: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. Afterwards {npc:11800}, in the middle of {area:2361}, flies druids straight to {area:702}."] = "",
	-- {item:15885} Pendant of the Sea Lion
	["{item:15885}: join the halves at the shrine"] = "{item:15885} : assemblez les moitiés au sanctuaire",

	-- Step 7: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:31} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:31}: swim fast and breathe underwater."] = "",

	-- Step 8: Aquatic Form
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {quest:5061} Aquatic Form
	["Take the portal up to {npc:4217} in the {area:1658}. {quest:5061}: swim fast and breathe underwater."] = "Prenez le portail pour monter jusqu'à {npc:4217}, dans {area:1658}. {quest:5061} : nagez vite et respirez sous l'eau.",

	-- Step 9: A Lesson to Learn
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["{npc:3033} stands in the druids' hut on {area:1639}."] = "{npc:3033} se tient dans la hutte des druides, sur {area:1639}.",

	-- Step 10: Trial of the Lake
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:28} Trial of the Lake · {npc:11799} Tajarri · {area:656} Lake Elune'ara · {area:2361} Nighthaven · {object:177524} Bubbly Fissure (no name in this language: may be words) · {item:15877} Shrine Bauble · {area:2362} Shrine of Remulos
	-- plural, as words: Bauble Containers = {object:177785} Bauble Container
	["Cast {spell:18960} to get here: {npc:11802} stands upstairs in the building beside where you land. {quest:28} runs on a 30-minute timer: once you accept it, no teleport or Hearthstone until {npc:11799} has it. Six Bauble Containers (vases) lie in narrow hollows deep on the floor of {area:656} below {area:2361}, often near the bubbling fissures (the {object:177524} in the middle of the lake refills your breath); each comes back three minutes after it is opened, and other druids take them too. Check the {item:15877} is in your bags before you surface: it fades five minutes after you loot it. Swim it straight to the {area:2362} on the north-west shore, use it inside the shrine grounds and speak to {npc:11799} by the tree."] = "Lancez {spell:18960} pour venir ici : {npc:11802} se tient à l'étage du bâtiment à côté de votre point d'arrivée. {quest:28} dure 30 minutes : une fois la quête acceptée, aucune téléportation ni Pierre de foyer tant que {npc:11799} ne l'a pas reçue. Six Conteneurs de babioles (des vases) reposent dans d'étroits creux au fond du {area:656}, sous {area:2361}, souvent près des fissures bouillonnantes (la fissure bouillonnante au milieu du lac vous rend votre souffle) ; chacun revient trois minutes après avoir été ouvert, et d'autres druides les prennent aussi. Vérifiez que la {item:15877} est dans vos sacs avant de remonter : elle disparaît cinq minutes après que vous l'avez ramassée. Nagez tout droit avec jusqu'au {area:2362} sur la rive nord-ouest, utilisez-la dans l'enceinte du sanctuaire et parlez à {npc:11799} près de l'arbre.",

	-- Step 11: Half Pendant of Aquatic Agility
	-- {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {area:1637} Orgrimmar · {object:177792} Strange Lockbox · {area:382} Sludge Fen
	["Take {npc:11798}'s flight to {area:1638} and fly on to {area:1637}. The {object:177792} lies underwater in the {area:382} pond, a short walk out of {area:1637}'s west gate, in front of a wooden wall. The Venture Co. there are quick to join a fight: come in from the west to avoid most of them."] = "",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",
	-- {area:1637} Orgrimmar · {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest
	["Back through {area:1637} to the zeppelin towers outside its main gate: the zeppelin to the {zone:1458} lands in {zone:1420}, and {zone:1421} is south of the {zone:1458}."] = "",

	-- Step 13: Half Pendant of Aquatic Endurance
	-- {object:177790} Strange Lockbox · {area:228} Sepulcher · {spell:18960} Teleport: Moonglade
	["The {object:177790} lies at the bottom of very deep water off the coast north-west of the {area:228}, beside an air fissure where you can breathe: watch your breath on the way down. Then {spell:18960} takes you straight back."] = "",

	-- Step 14: Pendant of the Sea Lion
	-- {spell:18960} Teleport: Moonglade · {area:2362} Shrine of Remulos · {item:15883} Half Pendant of Aquatic Agility · {zone:1450} Moonglade · {npc:11802} Dendrite Starblaze · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. He stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:11798} flies druids to {area:1638}."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast Teleport: {zone:1450}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Lancez Téléportation : {zone:1450}. Assemblez les deux moitiés pour obtenir {item:15885} près du {area:2362}, sur la rive nord-ouest du lac, puis allez voir {npc:11802} à {area:2361}. Volez ensuite jusqu'à {area:702}.",
	-- ["Cast Teleport: {zone:1450}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Lancez Téléportation : {zone:1450}. Assemblez les deux moitiés pour obtenir {item:15885} près du {area:2362}, sur la rive nord-ouest du lac, puis allez voir {npc:11802} à {area:2361}. {npc:11798} emmène les druides en vol jusqu'à {area:1638}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez Téléportation : {zone:1450}. {npc:11802} se trouve à {area:2361}. Les Colifichets du sanctuaire reposent dans les conteneurs au fond du {area:656}, en contrebas d'{area:2361} : apportez-en une au {area:2362}, sur la rive nord-ouest, utilisez-la là-bas et parlez à {npc:11799}.",
	-- ["Cast Teleport: {zone:1450}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez Téléportation : {zone:1450}. {npc:11802} se trouve à {area:2361}. Les Colifichets du sanctuaire reposent au fond du {area:656} et disparaissent en quelques minutes : nagez directement avec l'une d'elles jusqu'au {area:2362}, sur la rive nord-ouest, utilisez-la là-bas et parlez à {npc:11799}.",
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. Fly to {area:702} afterwards."] = "Lancez {spell:18960}. Assemblez les deux moitiés pour obtenir {item:15885} près du {area:2362}, sur la rive nord-ouest du lac, puis allez voir {npc:11802} à {area:2361}. Volez ensuite jusqu'à {area:702}.",
	-- ["Cast {spell:18960}. Join the two halves into the {item:15885} near the {area:2362}, on the north-west shore of the lake, then see {npc:11802} in {area:2361}. {npc:11798} flies druids to {area:1638}."] = "Lancez {spell:18960}. Assemblez les deux moitiés pour obtenir {item:15885} près du {area:2362}, sur la rive nord-ouest du lac, puis allez voir {npc:11802} à {area:2361}. {npc:11798} transporte les druides jusqu'à {area:1638}.",
	-- ["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. Afterwards {npc:11800}, in the middle of {area:2361}, flies druids straight to {area:702}."] = "Lancez {spell:18960}. Avec les deux moitiés dans vos sacs, placez-vous près du {area:2362} sur la rive nord-ouest et utilisez la {item:15883} pour les assembler, puis lancez de nouveau {spell:18960} (le sort fonctionne dans {zone:1450}) pour arriver près de {npc:11802}. Ensuite, {npc:11800}, au milieu de {area:2361}, emmène les druides directement au {area:702}.",
	-- ["Cast {spell:18960}. With both halves in your bags, stand by the {area:2362} on the north-west shore and use the {item:15883} to join them, then cast {spell:18960} again (it works inside {zone:1450}) to land by {npc:11802}. {npc:11798} flies druids to {area:1638}."] = "Lancez {spell:18960}. Avec les deux moitiés dans vos sacs, placez-vous près du {area:2362} sur la rive nord-ouest et utilisez la {item:15883} pour les assembler, puis lancez de nouveau {spell:18960} (le sort fonctionne dans {zone:1450}) pour arriver près de {npc:11802}. {npc:11798} emmène les druides à {area:1638}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Shrine Baubles lie in the containers on the floor of {area:656}, below {area:2361}: take one to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. Les Colifichets du sanctuaire ({item:15877}) se trouvent dans les conteneurs au fond du {area:656}, en contrebas de {area:2361} : apportez-en un au {area:2362} sur la rive nord-ouest, utilisez-le là-bas et parlez à {npc:11799}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. Les Colifichets du sanctuaire ({item:15877}) reposent au fond du {area:656} et disparaissent en quelques minutes : nagez avec l'un d'eux directement jusqu'au {area:2362} sur la rive nord-ouest, utilisez-le là-bas et parlez à {npc:11799}.",
	-- ["Fly from {area:2361} to {area:442}. The {object:177792} lies under the water off the north coast, west of the {area:443}."] = "Volez de {area:2361} à {area:442}. L'{object:177792} se trouve sous l'eau au large de la côte nord, à l'ouest des {area:443}.",
	-- ["Take the boat from {area:442} to {zone:1453} and fly to {area:108}. Ride north-west to the coast: the {object:177790} lies on the sea floor off the shore."] = "Prenez le bateau d'{area:442} à {zone:1453} et volez jusqu'à la {area:108}. Allez vers le nord-ouest jusqu'à la côte : l'{object:177790} repose sur le fond marin au large du rivage.",
	-- ["Take the portal up to {npc:4217} in the {area:1658}."] = "Prenez le portail qui monte jusqu'à {npc:4217}, dans l'{area:1658}.",
	-- ["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies at the bottom of very deep water off the coast north-west of the {area:228}, beside an air fissure where you can breathe: watch your breath on the way down."] = "Prenez le vol de {npc:11798} pour {zone:1456}, un vol pour {zone:1454}, puis le zeppelin pour {zone:1420} ; {zone:1421} se trouve au sud de {zone:1458}. Le {object:177790} repose au fond d'eaux très profondes, au large de la côte au nord-ouest du {area:228}, à côté d'une fissure où vous pouvez respirer : surveillez votre souffle en descendant.",
	-- ["Take {npc:11798}'s flight to {zone:1456}, fly to {zone:1454} and take the zeppelin to {zone:1420}; {zone:1421} is south of the {zone:1458}. The {object:177790} lies on the coast west of the {area:240}, north of the {area:228}."] = "Prenez le vol de {npc:11798} jusqu'à {zone:1456}, volez jusqu'à {zone:1454} et prenez le zeppelin pour {zone:1420} ; {zone:1421} se trouve au sud d'{zone:1458}. L'{object:177790} se trouve sur la côte à l'ouest du champ ({area:240}), au nord de la crypte ({area:228}).",
	-- ["The {object:177792} lies at the north edge of the {area:382}, by the Venture Co. tower, north of the {area:380}."] = "L'{object:177792} se trouve à la lisière nord de {area:382}, près de la tour de la KapitalRisk, au nord de {area:380}.",
	-- ["The {object:177792} lies underwater in the {area:382} pond north of the {area:380}, in front of a wooden wall. The Venture Co. there are quick to join a fight: come in from the west to avoid most of them."] = "Le {object:177792} repose sous l'eau dans la mare du {area:382}, au nord de {area:380}, devant un mur de bois. Les membres de la KapitalRisk présents se joignent vite au combat : arrivez par l'ouest pour éviter la plupart d'entre eux.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} se tient sur la {area:1639}.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} se tient dans l'{area:1658}.",
}
