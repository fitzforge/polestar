-- French (frFR): the guide forever/class/warrior/fire-hardened-armor (forever/class/warrior/fire-hardened-armor.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Fire Hardened Armor"] = "Armure en acier trempé",
	["Starts now at 20 with a shield; a hauberk at 28, then a coif, leggings and gauntlets from three smiths."] = "",

	-- Step 1: Yorus Barleybrew (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to {quest:1698} in Redridge."] = "Au niveau 20, {npc:5479}, à côté de {npc:5480} dans le bâtiment des maîtres des guerriers de la {object:2100}, vous envoie voir {quest:1698} dans les Carmines.",

	-- Step 2: Yorus Barleybrew (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {quest:1698} Yorus Barleybrew
	["At 20, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {quest:1698} in Redridge."] = "Au niveau 20, {npc:5113}, le maître des guerriers de {zone:1455}, vous envoie voir {quest:1698} dans les Carmines.",

	-- Step 3: Yorus Barleybrew (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {quest:1698} Yorus Barleybrew
	["At 20, {npc:7315}, the warrior trainer of {zone:1457}, sends you to {quest:1698} in Redridge."] = "Au niveau 20, {npc:7315}, le maître des guerriers de {zone:1457}, vous envoie voir {quest:1698} dans les Carmines.",

	-- Step 4: Yorus Barleybrew
	-- {quest:1698} Yorus Barleybrew · {area:69} Lakeshire · {area:98} Rethban Caverns
	["{quest:1698} sits in the inn at {area:69}. His test is timed: before you take it, clear the Redridge gnolls on the path to the {area:98} in the hills north-west of {area:69}, including the two on the rock by the cave mouth (climb it from its right side)."] = "{quest:1698} est à l'auberge de {area:69}. Son épreuve est chronométrée : avant de la prendre, éliminez les gnolls des Carmines sur le chemin des {area:98}, dans les collines au nord-ouest de {area:69}, y compris les deux sur le rocher près de l'entrée de la grotte (escaladez-le par la droite).",

	-- Step 5: The Rethban Gauntlet
	-- {npc:6166} Yorus Barleybrew · {spell:8553} Barleybrew Scalder · {area:98} Rethban Caverns · {area:69} Lakeshire
	["You have one hour, and {npc:6166}'s {spell:8553} leaves you drunk for 8-10 minutes. Run north-west into the {area:98}, keeping close to the cliff wall to miss most gnoll packs, and go in as far as the first fork; then come back to {npc:6166} (from the ridge you can jump down into {area:69}). Dying and releasing your spirit fails the quest: abandon it and {npc:6166} gives it again."] = "Vous avez une heure, et l'{spell:8553} de {npc:6166} vous laisse ivre pendant 8 à 10 minutes. Courez au nord-ouest jusqu'aux {area:98}, en longeant la falaise pour éviter la plupart des groupes de gnolls, et entrez jusqu'au premier embranchement ; revenez ensuite voir {npc:6166} (depuis la crête, vous pouvez sauter jusqu'à {area:69}). Mourir et libérer votre esprit fait échouer la quête : abandonnez-la et {npc:6166} vous la redonne.",
	-- {area:98} Rethban Caverns
	["Enter the {area:98} and come back"] = "Entrez dans les {area:98} et revenez",

	-- Step 6: The Shieldsmith
	-- {npc:5413} Furen Longbeard · {item:6843} Cask of Scalder · {npc:6166} Yorus Barleybrew · {item:6970} Furen's Favor · {quest:1701} Fire Hardened Mail · {item:6842} Furen's Instructions
	["{npc:5413} works in the Dwarven District of Stormwind. He takes the {item:6843} (lost it? abandon the quest and {npc:6166} gives a new one) and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest, with {item:6842} listing what it needs."] = "{npc:5413} travaille dans le quartier des Nains de Hurlevent. Il prend le {item:6843} (perdu ? abandonnez la quête et {npc:6166} vous en donne un nouveau) et vous donne la {item:6970}, un bouclier ; {quest:1701} est une quête de niveau 28, et les {item:6842} indiquent ce qu'il lui faut.",

	-- Step 7: Scorched Spider Fangs
	-- plural, as words: Scorched Spider Fangs = {item:6838} Scorched Spider Fang
	["Scorched Spider Fangs"] = "Crocs d'araignée brûlés",
	-- {zone:1437} Wetlands · {area:836} Dun Algaz
	-- plural, as words: Leech Stalkers = {npc:1111} Leech Stalker · Cave Stalkers = {npc:4040} Cave Stalker
	["You need 50 fangs. The Leech Stalkers and Cave Stalkers (level 21-22) crawl in the middle of the {zone:1437}, north of {area:836}; every one drops a fang. They poison; back in 5 minutes."] = "Il vous faut 50 crocs. Les Traqueuses sanguines et les Traqueuses des grottes (niveau 21-22) rampent au milieu des {zone:1437}, au nord de {area:836} ; chacune lâche un croc. Elles empoisonnent ; de retour en 5 minutes.",

	-- Step 8: Charred and Galvanized Horns
	-- plural, as words: Galvanized Horns = {item:6840} Galvanized Horn
	["Charred and Galvanized Horns"] = "Cornes carbonisées et Cornes galvanisées",
	-- {area:460} Sun Rock Retreat · {area:465} Charred Vale · {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch · {spell:3396} Corrosive Poison · {spell:403} Lightning Bolt · {area:467} Stonetalon Peak
	-- plural, as words: Charred Horns = {item:6839} Charred Horn · Young Chimaeras = {npc:4032} Young Chimaera
	["The chimaeras live south-west of {area:460} in the {area:465}: you need 12 Charred Horns from the Fledgling (level 25-27) and Young Chimaeras (23-25), four kills in five, and the {item:6840} from the {npc:6167} (28, the big one), also four in five. Only three Fledglings, two Young and one Matriarch live there, each back in 5 minutes, so expect to wait. Fledglings and the Matriarch spit {spell:3396}, the Young cast {spell:403}. Alliance: fly to {area:467} and head south."] = "Les chimères vivent au sud-ouest de la {area:460}, dans le {area:465} : il vous faut 12 Cornes carbonisées, sur les Oisillons (niveau 25-27) et les Jeunes chimères (23-25), quatre fois sur cinq, et la {item:6840} sur la {npc:6167} (28, la grande), quatre fois sur cinq aussi. Seuls trois Oisillons, deux Jeunes et une Matriarche vivent là, chacun de retour en 5 minutes : attendez-vous à patienter. Les Oisillons et la Matriarche crachent {spell:3396}, les Jeunes lancent {spell:403}. Alliance : volez jusqu'au {area:467} et allez vers le sud.",
	-- {item:6839} Charred Horn
	["{item:6839}, from the young chimaeras"] = "{item:6839}, sur les jeunes chimères",
	-- {item:6840} Galvanized Horn · {npc:6167} Chimaera Matriarch
	["{item:6840}, from the {npc:6167}"] = "{item:6840}, sur la {npc:6167}",

	-- Step 9: Roogug in Razorfen Kraul
	-- {area:1717} Razorfen Kraul
	["Roogug in {area:1717}"] = "Roogug dans le {area:1717}",
	-- {area:1717} Razorfen Kraul · {zone:1413} Barrens · {spell:403} Lightning Bolt
	["Roogug is an elite quilboar (level 28) inside {area:1717}, the dungeon at the south end of the {zone:1413}; a five-player dungeon: needs a group of five, and his guards come with him. Inside take the left path at the first fork, cross the root bridge, go past the big empty cauldron: he is in a dead end on the right, with about ten elites on the way. He casts {spell:403} and calls Earth Rumblers. The vial always drops."] = "Roogug est un huran élite (niveau 28) dans le {area:1717}, le donjon au sud des {zone:1413} ; un donjon à cinq joueurs : il faut un groupe de cinq, et ses gardes viennent avec lui. À l'intérieur, prenez à gauche au premier embranchement, traversez le pont de racines, dépassez le grand chaudron vide : il est dans un cul-de-sac à droite, avec une dizaine d'élites en chemin. Il lance {spell:403} et appelle des Grondeurs de terre. La fiole tombe toujours.",
	-- {item:6841} Vial of Phlogiston
	["{item:6841}, from Roogug"] = "{item:6841}, sur Roogug",

	-- Step 10: Furen's Armor
	-- {npc:5413} Furen Longbeard · {object:28027} Dwarven District
	["Back to {npc:5413} in the {object:28027} for the hauberk. He then sends you to the smith of your race; the other two smiths' pieces are open to you as well: talk to them directly."] = "Retournez voir {npc:5413} dans le {object:28027} pour le haubert. Il vous envoie ensuite voir le forgeron de votre race ; les pièces des deux autres forgerons vous sont aussi ouvertes : parlez-leur directement.",

	-- Step 11: Grimand Elmore
	-- {npc:1416} Grimand Elmore · {object:28027} Dwarven District · {npc:5413} Furen Longbeard · {quest:1705} Burning Blood · {item:6845} Burning Rock
	["{npc:1416} keeps the weapon shop in the north-west of the {object:28027}, a short walk from {npc:5413}. He wants 20 {quest:1705} and the {item:6845}."] = "{npc:1416} tient la boutique d'armes au nord-ouest du {object:28027}, à deux pas de {npc:5413}. Il veut 20 {quest:1705} et la {item:6845}.",

	-- Step 12: Burning Blood
	-- {zone:1431} Duskwood · {area:42} Darkshire · {quest:1705} Burning Blood · {npc:6170} Gutspill · {item:6845} Burning Rock · {area:2161} Roland's Doom · {spell:3427} Infected Wound
	["The Nightbane worgen of {zone:1431} (Dark Runners, Vile Fangs, Shadow Weavers, Worgen and Tainted Ones, level 26-31) south and west of {area:42} drop the {quest:1705} four kills in five. {npc:6170} (level 32, not elite) carries the {item:6845} (also four in five): he walks between the inside and the mouth of the {area:2161} mine south-east of {area:42}, so wait at the entrance and pull him outside. {npc:6170} and the Tainted Ones poison and howl; Vile Fangs cause {spell:3427}."] = "Les worgens Plaie-de-nuit du {zone:1431} (Coureurs noirs, Crocs vils, Tisseurs d'ombre, Worgens et Souillés, niveau 26-31) au sud et à l'ouest de {area:42} lâchent le {quest:1705} quatre fois sur cinq. {npc:6170} (niveau 32, pas élite) porte la {item:6845} (quatre fois sur cinq aussi) : il fait des allers-retours entre l'intérieur et l'entrée de la mine du {area:2161}, au sud-est de {area:42} ; attendez donc à l'entrée et attirez-le dehors. {npc:6170} et les Souillés empoisonnent et hurlent ; les Crocs vils infligent {spell:3427}.",
	-- {quest:1705} Burning Blood
	["{quest:1705}, from the Nightbane worgen"] = "{quest:1705}, sur les worgens Plaie-de-nuit",
	-- {item:6845} Burning Rock · {npc:6170} Gutspill
	["{item:6845}, from {npc:6170}"] = "{item:6845}, sur {npc:6170}",

	-- Step 14: Mathiel
	-- {quest:1703} Mathiel · {area:1660} Warrior's Terrace · {zone:1457} Darnassus · {quest:1710} Sunscorched Shells
	["{quest:1703} works on the south side of the {area:1660} in {zone:1457}. He wants 20 {quest:1710}."] = "{quest:1703} travaille du côté sud de la {area:1660}, à {zone:1457}. Il veut 20 {quest:1710}.",

	-- Step 15: Sunscorched Shells
	-- {area:482} Highperch · {zone:1441} Thousand Needles
	-- plural, as words: Highperch Wyverns = {npc:4107} Highperch Wyvern
	["The shells lie on the ground under the wyvern nests at {area:482} in western {zone:1441}, deeper into the gorge. Only nine exist and each returns 3 minutes after you pick it, so you will wait; some shell-like things there cannot be looted. Highperch Wyverns (level 28-31) guard them and sometimes come several at once."] = "Les carapaces gisent au sol sous les nids de wyvernes de {area:482}, dans l'ouest de {zone:1441}, plus loin dans la gorge. Il n'en existe que neuf et chacune revient 3 minutes après avoir été ramassée, vous devrez donc attendre ; certaines choses qui ressemblent à des carapaces ne peuvent pas être ramassées. Des Wyvernes de Haut-perchoir (niveau 28-31) les gardent et arrivent parfois à plusieurs.",

	-- Step 17: Klockmort Spannerspan
	-- {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1455} Ironforge · {quest:1704} Klockmort Spannerspan · {object:171524} Tinker Town · {item:6848} Searing Coral
	["Ride the {area:2257} from {zone:1453} to {zone:1455}. {quest:1704}, a gnome smith, works in {object:171524} near the engineering trainers. He wants 20 {item:6848}."] = "Prenez le {area:2257} de {zone:1453} à {zone:1455}. {quest:1704}, un forgeron gnome, travaille à {object:171524}, près des maîtres de l'ingénierie. Il veut 20 {item:6848}.",

	-- Step 18: Iron Coral
	-- {quest:1708} Iron Coral · {area:150} Menethil Harbor · {item:5996} Draught of Water Breathing
	["The {quest:1708} grows on the sea floor just south of {area:150}, by the murloc huts and a wrecked boat: eight there and two south-east of the harbor, each back in 3 minutes, so you will wait for respawns to reach 20. The murlocs can net you underwater: watch your breath, and a {item:5996} removes the risk."] = "",
	-- {item:6848} Searing Coral · {quest:1708} Iron Coral
	["{item:6848}, from {quest:1708}"] = "{item:6848}, sur le {quest:1708}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A hauberk at 28, a coif, leggings and gauntlets from three smiths, and a shield on the way."] = "Un haubert au niveau 28, une coiffe, des jambières et des gantelets de trois forgerons, et un bouclier en chemin.",
	-- ["A hauberk at 28, a coif, leggings or gauntlets by race, and a shield on the way."] = "Un haubert au niveau 28, une coiffe, des jambières ou des gantelets selon la race, et un bouclier en chemin.",
	-- ["At 20, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {quest:1698} in Redridge."] = "Au niveau 20, {npc:5479}, dans la {object:2100} à côté de la taverne du Cochon siffleur, vous envoie voir {quest:1698} dans les Carmines.",
	-- ["Back to {npc:5413} in the {object:28027}. He sends you on to a smith of your own race."] = "Retournez voir {npc:5413} dans le {object:28027}. Il vous envoie chez un forgeron de votre race.",
	-- ["Ride the {area:2257} from {zone:1453} to {zone:1455}."] = "Prenez le {area:2257} de {zone:1453} à {zone:1455}.",
	-- ["Roogug is an elite quilboar inside {area:1717}, the dungeon at the south end of the {zone:1413}; he drops the {item:6841}. {area:1717} is a dungeon: grouping up is advised."] = "Roogug est un huran élite du {area:1717}, le donjon au sud des {zone:1413} ; il laisse tomber la {item:6841}. Le {area:1717} est un donjon : un groupe est conseillé.",
	-- ["The Fledgling and Young Chimaeras roam the south-west of Stonetalon, with the {npc:6167} among them: the young ones drop the {item:6839}, the Matriarch the {item:6840}."] = "Les Petites chimères et les Jeunes chimères errent au sud-ouest des Serres-Rocheuses, avec la {npc:6167} parmi elles : les jeunes laissent tomber la {item:6839}, la matriarche la {item:6840}.",
	-- ["The Leech Stalkers and Cave Stalkers crawl around 46,61 in the middle of the {zone:1437}; they drop the {item:6838}."] = "Les Traqueuses sanguines et les Traqueuses des grottes rampent vers 46,61, au centre des {zone:1437} ; elles laissent tomber le {item:6838}.",
	-- ["The Nightbane worgen of {zone:1431} drop the {quest:1705}. {npc:6170} walks in the far south-east of {zone:1431} and carries the {item:6845}."] = "Les worgens Plaie-de-nuit du {zone:1431} laissent tomber le {quest:1705}. {npc:6170} rôde à l'extrême sud-est du {zone:1431} et porte la {item:6845}.",
	-- ["The {quest:1708} grows along the {zone:1437}' west coast, south of {area:150}."] = "Le {quest:1708} pousse le long de la côte ouest des {zone:1437}, au sud de {area:150}.",
	-- ["The {quest:1708} grows on the sea floor just south of {area:150}, by the murloc huts and a wrecked boat: eight there and two south-east of the harbor, each back in 3 minutes, so you will wait for respawns to reach 20. The murlocs can net you underwater: watch your breath, and an {item:5996} removes the risk."] = "Le {quest:1708} pousse au fond de la mer juste au sud de {area:150}, près des huttes des murlocs et d'un bateau naufragé : huit à cet endroit et deux au sud-est du port, chacun de retour en 3 minutes, vous devrez donc attendre des réapparitions pour arriver à 20. Les murlocs peuvent vous prendre au filet sous l'eau : surveillez votre souffle ; un {item:5996} élimine le risque.",
	-- ["The {quest:1710} lie along the western edge of {zone:1441}."] = "Les {quest:1710} se trouvent le long du bord ouest de {zone:1441}.",
	-- ["{item:6839} from the young chimaeras"] = "{item:6839} sur les jeunes chimères",
	-- ["{item:6840} from the {npc:6167}"] = "{item:6840} sur la {npc:6167}",
	-- ["{item:6845} from {npc:6170}"] = "{item:6845} sur {npc:6170}",
	-- ["{npc:1416} is in {zone:1453}, a short walk from {npc:5413}."] = "{npc:1416} est à {zone:1453}, à quelques pas de {npc:5413}.",
	-- ["{npc:5413} works in the Dwarven District of Stormwind. He keeps the {item:6843} and gives you {item:6970}, a shield; {quest:1701} is a level 28 quest."] = "{npc:5413} travaille dans le Quartier des nains de Hurlevent. Il garde le {item:6843} et vous donne {item:6970}, un bouclier ; {quest:1701} est une quête de niveau 28.",
	-- ["{quest:1698} is in {area:69}, at the inn. His test is timed: run north-west into the {area:98}, reach the first fork and come back to him before the timer runs out. Do not die and release your spirit."] = "{quest:1698} est à {area:69}, à l'auberge. Son épreuve est chronométrée : courez au nord-ouest dans les {area:98}, atteignez la première bifurcation et revenez le voir avant la fin du temps. Ne mourez pas et ne libérez pas votre esprit.",
	-- ["{quest:1703} is a smith in {zone:1457}."] = "{quest:1703} est forgeron à {zone:1457}.",
	-- ["{quest:1705} from the Nightbane worgen"] = "{quest:1705} sur les worgens Plaie-de-nuit",
}
