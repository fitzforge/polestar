-- French (frFR): the guide forever/class/priest/desperate-prayer-and-chastise (forever/class/priest/desperate-prayer-and-chastise.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["{quest:5634} and {quest:5641}"] = "{quest:5634} et {quest:5641}",
	-- {quest:5634} Desperate Prayer · {quest:5641} Chastise
	["The Dwarf priest spells: {quest:5634} at 10, {quest:5641} (new in Forever) at 20. Free, no objectives."] = "Les sorts de prêtre nain : {quest:5634} au niveau 10, {quest:5641} (nouveau dans Forever) au niveau 20. Gratuits, sans objectif.",

	-- Step 1: Desperate Prayer: Maxan Anvol
	-- {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery · {area:131} Kharanos · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10, {npc:1226}, the priest trainer inside the {area:2102} in {area:131}, hands you a {quest:5634} letter for {npc:11406}. {area:131} is on the road up to {zone:1455}."] = "Au niveau 10, {npc:1226}, le maître des prêtres dans la {area:2102} à {area:131}, vous remet une lettre {quest:5634} pour {npc:11406}. {area:131} est sur la route qui monte à {zone:1455}.",
	-- {npc:1226} Maxan Anvol · {quest:5634} Desperate Prayer
	["{npc:1226}: take his {quest:5634} letter"] = "{npc:1226} : prenez sa lettre {quest:5634}",

	-- Step 2: Desperate Prayer: Priestess Josetta
	-- {zone:1429} Elwynn Forest · {npc:377} Priestess Josetta · {area:87} Goldshire · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["At 10 in {zone:1429}, {npc:377}, upstairs in the Lion's Pride Inn in {area:87}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455} (the {area:2257} from {zone:1453}'s {object:28027})."] = "Au niveau 10 dans la {zone:1429}, {npc:377}, à l'étage de l'auberge de la Fierté du lion à {area:87}, vous remet une lettre {quest:5634} pour {npc:11406} à {zone:1455} (le {area:2257} depuis le {object:28027} de {zone:1453}).",
	-- {npc:377} Priestess Josetta · {quest:5634} Desperate Prayer
	["{npc:377}: take her {quest:5634} letter"] = "{npc:377} : prenez sa lettre {quest:5634}",

	-- Step 3: Desperate Prayer: Nara Meideros
	-- {zone:1453} Stormwind · {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:376} High Priestess Laurena
	["At 10 in {zone:1453}, {npc:11397}, the priest trainer in the Park (the night elf quarter on the city's west side), hands you a {quest:5634} letter for {npc:11406} in {zone:1455}. {npc:376} in the Cathedral has none for Dwarves."] = "Au niveau 10 à {zone:1453}, {npc:11397}, la maîtresse des prêtres du Parc (le quartier elfe de la nuit, à l'ouest de la ville), vous remet une lettre {quest:5634} pour {npc:11406} à {zone:1455}. {npc:376}, à la cathédrale, n'en a pas pour les nains.",
	-- {npc:11397} Nara Meideros · {quest:5634} Desperate Prayer
	["{npc:11397}: take her {quest:5634} letter"] = "{npc:11397} : prenez sa lettre {quest:5634}",

	-- Step 4: Desperate Prayer: Laurna Morninglight
	-- {zone:1438} Teldrassil · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1438}, {npc:3600}, in the building at the north edge of {area:186}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "Au niveau 10 à {zone:1438}, {npc:3600}, dans le bâtiment au bord nord de {area:186}, vous remet une lettre {quest:5634} pour {npc:11406} à {zone:1455}.",
	-- {npc:3600} Laurna Morninglight · {quest:5634} Desperate Prayer
	["{npc:3600}: take her {quest:5634} letter"] = "{npc:3600} : prenez sa lettre {quest:5634}",

	-- Step 5: Desperate Prayer: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5634} Desperate Prayer · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 10 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5634} letter for {npc:11406} in {zone:1455}."] = "Au niveau 10 à {zone:1457}, {npc:11401}, sur le balcon supérieur du temple de la Lune à côté de {npc:7999}, vous remet une lettre {quest:5634} pour {npc:11406} à {zone:1455}.",
	-- {npc:11401} Priestess Alathea · {quest:5634} Desperate Prayer
	["{npc:11401}: take her {quest:5634} letter"] = "{npc:11401} : prenez sa lettre {quest:5634}",

	-- Step 6: Desperate Prayer: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward · {quest:5634} Desperate Prayer
	["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362} (north-west of the city): he gives {quest:5634} and takes it back at once. No letter needed. {quest:5634} heals you instantly, costs no mana and has a long cooldown: keep it for emergencies."] = "Au niveau 10, allez voir {npc:11406} dans la salle des Mystères, dans {object:32362} de {zone:1455} (au nord-ouest de la ville) : il donne {quest:5634} et la reprend aussitôt. Pas besoin de lettre. {quest:5634} vous soigne instantanément, ne coûte pas de mana et a un long temps de recharge : gardez-la pour les urgences.",

	-- Step 7: Desperate Prayer: Maxan Anvol's letter
	-- {quest:5637} Desperate Prayer · {npc:1226} Maxan Anvol
	["{quest:5637}: {npc:1226}'s letter"] = "{quest:5637} : la lettre de {npc:1226}",
	-- {area:131} Kharanos · {zone:1455} Ironforge · {object:32362} Mystic Ward · {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5637} Desperate Prayer · {zone:1453} Stormwind
	["Follow the road up from {area:131} into {zone:1455} and west to the {object:32362}: {npc:11406} in the {object:32386} takes the letter and teaches {quest:5637}. The letter tells you to head to {zone:1453}, but the one who wants you is Rohan in {zone:1455}."] = "Suivez la route qui monte de {area:131} jusqu'à {zone:1455}, puis vers l'ouest jusqu'à {object:32362} : {npc:11406}, dans la salle des Mystères, prend la lettre et vous apprend {quest:5637}. La lettre vous dit d'aller à {zone:1453}, mais celui qui vous attend est Rohan, à {zone:1455}.",

	-- Step 8: Desperate Prayer: Josetta's letter
	-- {quest:5635} Desperate Prayer
	["{quest:5635}: Josetta's letter"] = "{quest:5635} : la lettre de Josetta",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {object:28027} Dwarven District
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: the {area:2257} from {zone:1453}'s {object:28027}."] = "Remettez la lettre à {npc:11406} dans la salle des Mystères, dans {object:32362} de {zone:1455} : le {area:2257} depuis le {object:28027} de {zone:1453}.",

	-- Step 9: Desperate Prayer: Nara's letter
	-- {quest:5638} Desperate Prayer
	["{quest:5638}: Nara's letter"] = "{quest:5638} : la lettre de Nara",

	-- Step 10: Desperate Prayer: Laurna Morninglight's letter
	-- {quest:5636} Desperate Prayer · {npc:3600} Laurna Morninglight
	["{quest:5636}: {npc:3600}'s letter"] = "{quest:5636} : la lettre de {npc:3600}",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward · {zone:1438} Teldrassil · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1438}, the boat from {area:702} to {area:442}, the boat to {area:150} and the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "Remettez la lettre à {npc:11406} dans la salle des Mystères, dans {object:32362} de {zone:1455} : depuis {zone:1438}, le bateau du {area:702} à {area:442}, le bateau pour {area:150} et la route vers le nord à travers les {zone:1437} et le {zone:1432} (ou le bateau pour le {area:17203} et le {area:2257}).",

	-- Step 11: Desperate Prayer: Alathea's letter
	-- {quest:5640} Desperate Prayer
	["{quest:5640}: Alathea's letter"] = "{quest:5640} : la lettre d'Alathea",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward · {zone:1453} Stormwind · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand the letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: its text says {zone:1453}, but Rohan is in {zone:1455}. From {zone:1457}, the portal down to {area:702}, the boat to {area:442}, then {area:150} and the road north (or {area:17203} and the {area:2257})."] = "Remettez la lettre à {npc:11406} dans la salle des Mystères, dans {object:32362} de {zone:1455} : son texte dit {zone:1453}, mais Rohan est à {zone:1455}. Depuis {zone:1457}, le portail qui descend au {area:702}, le bateau pour {area:442}, puis {area:150} et la route vers le nord (ou le {area:17203} et le {area:2257}).",

	-- Step 12: Desperate Prayer: an old letter
	-- {quest:5634} Desperate Prayer
	["{quest:5634}: an old letter"] = "{quest:5634} : une ancienne lettre",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward
	["This letter also goes to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}."] = "Cette lettre va aussi à {npc:11406}, dans la salle des Mystères, dans {object:32362} de {zone:1455}.",

	-- Step 13: Chastise: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:28027} Dwarven District
	["At 20 in {zone:1453}, {npc:376} at the altar of the Cathedral of Light hands you a {quest:5641} letter for {npc:11406} in {zone:1455} (the {area:2257} from the {object:28027})."] = "Au niveau 20 à {zone:1453}, {npc:376}, à l'autel de la cathédrale de la Lumière, vous remet une lettre {quest:5641} pour {npc:11406} à {zone:1455} (le {area:2257} depuis le {object:28027}).",
	-- {npc:376} High Priestess Laurena · {quest:5641} Chastise
	["{npc:376}: take her {quest:5641} letter"] = "{npc:376} : prenez sa lettre {quest:5641}",

	-- Step 14: Chastise: Priestess Alathea
	-- {zone:1457} Darnassus · {npc:11401} Priestess Alathea · {npc:7999} Tyrande Whisperwind · {quest:5641} Chastise · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 20 in {zone:1457}, {npc:11401}, on the upper balcony of the Temple of the Moon beside {npc:7999}, hands you a {quest:5641} letter for {npc:11406} in {zone:1455}."] = "Au niveau 20 à {zone:1457}, {npc:11401}, sur le balcon supérieur du temple de la Lune à côté de {npc:7999}, vous remet une lettre {quest:5641} pour {npc:11406} à {zone:1455}.",
	-- {npc:11401} Priestess Alathea · {quest:5641} Chastise
	["{npc:11401}: take her {quest:5641} letter"] = "{npc:11401} : prenez sa lettre {quest:5641}",

	-- Step 15: Chastise: High Priest Rohan
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {quest:5641} Chastise · {spell:6346} Fear Ward
	["At 20, {npc:11406} in the {object:32386} teaches {quest:5641} with a quest he gives and takes back at once. Forever renamed it from A Lack of Fear: {quest:5641} damages a humanoid and roots it for 2 seconds (instant, 2-minute cooldown), and every priest now trains {spell:6346}."] = "Au niveau 20, {npc:11406}, dans la salle des Mystères, vous apprend {quest:5641} avec une quête qu'il donne et reprend aussitôt. Forever l'a renommé, c'était Un manque de peur : {quest:5641} inflige des dégâts à un humanoïde et l'immobilise 2 secondes (instantané, temps de recharge de 2 minutes), et tous les prêtres apprennent désormais {spell:6346}.",

	-- Step 16: Chastise: Laurena's letter
	-- {quest:5645} Chastise
	["{quest:5645}: Laurena's letter"] = "{quest:5645} : la lettre de Laurena",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward · {quest:5645} Chastise
	["Hand Laurena's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: he teaches {quest:5645}."] = "Remettez la lettre de Laurena à {npc:11406} dans la salle des Mystères, dans {object:32362} de {zone:1455} : il vous apprend {quest:5645}.",

	-- Step 17: Chastise: Alathea's letter
	-- {quest:5647} Chastise
	["{quest:5647}: Alathea's letter"] = "{quest:5647} : la lettre d'Alathea",
	-- {npc:11406} High Priest Rohan · {object:32386} Hall of Mysteries (no name in this language: may be words) · {zone:1455} Ironforge · {object:32362} Mystic Ward · {zone:1457} Darnassus · {area:702} Rut'theran Village · {area:442} Auberdine · {area:150} Menethil Harbor · {zone:1437} Wetlands · {zone:1432} Loch Modan · {area:17203} Stormwind Harbor · {area:2257} Deeprun Tram
	["Hand Alathea's letter to {npc:11406} in the {object:32386}, {zone:1455}'s {object:32362}: from {zone:1457}, the boats via {area:702} and {area:442} to {area:150}, then the road north through the {zone:1437} and {zone:1432} (or the boat to {area:17203} and the {area:2257})."] = "Remettez la lettre d'Alathea à {npc:11406} dans la salle des Mystères, dans {object:32362} de {zone:1455} : depuis {zone:1457}, les bateaux via le {area:702} et {area:442} jusqu'à {area:150}, puis la route vers le nord à travers les {zone:1437} et le {zone:1432} (ou le bateau pour le {area:17203} et le {area:2257}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10, go to {npc:11406} in the {object:32386}, in {zone:1455}'s {object:32362}. Forever's quest text names Rohan, but the quest data has {npc:376} in {zone:1453}'s Cathedral of Light take it: try Rohan first, then Laurena (the {area:2257} links the cities)."] = "Au niveau 10, allez voir {npc:11406} dans la {object:32386}, dans {object:32362} de {zone:1455}. Le texte de la quête dans Forever nomme Rohan, mais selon les données c'est {npc:376}, dans la cathédrale de la Lumière de {zone:1453}, qui la reçoit : essayez d'abord Rohan, puis Laurena (le {area:2257} relie les deux villes).",
	-- ["At 20, {npc:11406} teaches {quest:5641}. {npc:376} in {zone:1453} and {npc:11401} in {zone:1457} send you to him with a quest of the same name."] = "Au niveau 20, {npc:11406} enseigne {quest:5641}. {npc:376} à {zone:1453} et {npc:11401} à {zone:1457} vous envoient à lui avec une quête du même nom.",
	-- ["If Rohan did not take it: {npc:376} is in the Cathedral of Light. Take the {area:2257} from {object:171524}."] = "Si Rohan ne l'a pas prise : {npc:376} est dans la cathédrale de la Lumière. Prenez le {area:2257} depuis {object:171524}.",
	-- ["The Human and Dwarf priest spells: {quest:5634} at 10, {quest:5641} for Dwarves at 20."] = "Les sorts de prêtre humains et nains : {quest:5634} au niveau 10, {quest:5641} pour les nains au niveau 20.",
}
