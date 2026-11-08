-- French (frFR): the guide forever/class/warlock/incubus-horde (forever/class/warlock/incubus-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Succubus and Incubus (Horde)"] = "Succube et incube (Horde)",
	["At 20: the succubus and Forever's incubus, its male twin, each with a soul pouch for your shards."] = "Au niveau 20 : la succube et l'incube de Forever, son jumeau masculin, chacun avec une bourse d'âmes pour vos fragments.",

	-- Step 1: Devourer of Souls (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {npc:5909} Cazul · {npc:5675} Carendin Halgar · {zone:1458} Undercity · {quest:1472} Devourer of Souls · {zone:1454} Orgrimmar
	["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers start these demons, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one; this guide follows whichever {quest:1472} you took. {npc:5909} offers both of {zone:1454}'s branches: take both."] = "Au niveau 20, {npc:5875}, dans la {object:172960} sous la {object:172982}, vous envoie voir {npc:5909}, à quelques pas. Deux maîtres lancent ces démons, {npc:5875} ici et {npc:5675} à {zone:1458}, et vous ne pouvez en prendre qu'un ; ce guide suit la quête {quest:1472} que vous avez prise. {npc:5909} propose les deux branches d'{zone:1454} : prenez les deux.",
	["the succubus"] = "la succube",
	["the incubus"] = "l'incube",

	-- Step 2: Zankaja
	-- {npc:5910} Zankaja · {object:172982} Valley of Strength
	["{npc:5910} lives in a hut up on the cliffs on the west side of the city, above the {object:172982}: climb the wind rider tower, cross the bridge at its top to the west and turn right off it. She sends you to the Crossroads."] = "",

	-- Step 3: Magar
	-- {npc:3363} Magar · {object:173018} Magar's Cloth Goods · {object:172960} Cleft of Shadow · {zone:1440} Ashenvale
	["{npc:3363} keeps {object:173018} on the main street east of the {object:172960}. He asks you to look for his mate Krilge in {zone:1440}."] = "{npc:3363} tient {object:173018} dans la grande rue, à l'est de la {object:172960}. Il vous demande de chercher sa compagne Krilge en {zone:1440}.",

	-- Step 4: Gazrog
	-- {npc:3464} Gazrog · {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {zone:1442} Stonetalon Mountains
	["{npc:3464} waits in front of the inn at the Crossroads. He sends you on to {npc:4197} at {area:2539}, in {zone:1442}."] = "",

	-- Step 5: Ken'zigla
	-- {zone:1442} Stonetalon Mountains · {area:2539} Malaka'jin · {npc:4197} Ken'zigla · {npc:5911} Grunt Logmar
	["Take the road west from the Crossroads into {zone:1442} and, just past the border, the faint trail up to the left (south): {area:2539} cannot be reached from the main road. {npc:4197} hands you her draught for {npc:5911}."] = "",

	-- Step 6: Grunt Dogran
	-- {npc:5911} Grunt Logmar · {area:378} Camp Taurajo · {npc:5875} Gan'rul Bloodeye
	["{npc:5911} stands at {area:378}, south down the road from the Crossroads. He sends you north to the quilboar camp where Dogran is held: the camp with two huts side by side, north-west of a decoy camp whose huts stand apart. A rare level 22 elite quilboar sometimes guards the huts: send your voidwalker in, sacrifice it if you must, and talk to Dogran. He gives you a pendant for {npc:5875}. Keep it."] = "",

	-- Step 7: The Binding: succubus (Orgrimmar)
	-- {quest:1513} The Binding · {zone:1454} Orgrimmar
	["{quest:1513}: succubus ({zone:1454})"] = "{quest:1513} : succube ({zone:1454})",
	-- {npc:5875} Gan'rul Bloodeye · {item:6626} Dogran's Pendant · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade
	["Back to {npc:5875} with the pendant. He hands you {item:6626}: take it across the {object:172960} to {npc:3216}'s tent, stand on the purple circle and use it. Summon your voidwalker first and let it tank: the succubus (level 20, not elite) charms and lashes; keep your damage over time on her. If she wins, use the pendant again. Keep the pendant: {npc:5875} takes it back."] = "Retournez voir {npc:5875} avec le pendentif. Il vous remet le {item:6626} : traversez la {object:172960} jusqu'à la tente de {npc:3216}, placez-vous sur le cercle violet et utilisez-le. Invoquez d'abord votre marcheur du Vide et laissez-le encaisser : la succube (niveau 20, pas élite) charme et fouette ; maintenez vos dégâts sur la durée sur elle. Si elle gagne, utilisez de nouveau le pendentif. Gardez le pendentif : {npc:5875} le reprend.",
	-- {item:6626} Dogran's Pendant
	["{item:6626}, on the circle in Neeru's tent"] = "{item:6626}, sur le cercle de la tente de Neeru",

	-- Step 8: Fallen Sky Lake
	-- {area:422} Fallen Sky Lake · {zone:1440} Ashenvale · {area:431} Splintertree Post · {item:190232} Withered Scarf · {npc:3931} Shadethicket Oracle
	-- plural, as words: Shadethicket Stone Movers = {npc:3782} Shadethicket Stone Mover
	["{area:422} lies in southern {zone:1440}, south-west of {area:431}. The Shadethicket Stone Movers and Bark Rippers (level 25-26) around the lake drop the {item:190232} about one time in twenty, and the lone {npc:3931} (30) can drop it too: plan on a good number of kills, so come at 25 or later (Forever made this quest level 27); with the succubus already bound you can leave it for your 20s leveling in {zone:1440}. They respawn in five minutes."] = "Le {area:422} se trouve dans le sud d'{zone:1440}, au sud-ouest du {area:431}. Les Bouge-pierres et les Bark Rippers Sombretaillis (niveau 25-26) autour du lac lâchent l'{item:190232} environ une fois sur vingt, et l'{npc:3931} solitaire (30) peut aussi le lâcher : prévoyez bon nombre de victimes, venez donc au niveau 25 ou plus (Forever a passé cette quête au niveau 27) ; une fois la succube liée, vous pouvez la garder pour votre progression de la vingtaine en {zone:1440}. Ils réapparaissent en cinq minutes.",

	-- Step 9: The Binding: incubus (Orgrimmar)
	-- {quest:65604} The Binding · {zone:1454} Orgrimmar
	["{quest:65604}: incubus ({zone:1454})"] = "{quest:65604} : incube ({zone:1454})",
	-- {npc:5875} Gan'rul Bloodeye · {item:190232} Withered Scarf
	["Back to {npc:5875} with the scarf, then use the {item:190232} on the same circle in Neeru's tent and defeat the incubus it calls (level 20, not elite) with your voidwalker tanking. Keep the scarf: {npc:5875} takes it back."] = "Retournez voir {npc:5875} avec l'écharpe, puis utilisez l'{item:190232} sur le même cercle de la tente de Neeru et vainquez l'incube qu'elle appelle (niveau 20, pas élite), votre marcheur du Vide encaissant les coups. Gardez l'écharpe : {npc:5875} la reprend.",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the circle in Neeru's tent"] = "{npc:185335}, au cercle de la tente de Neeru",

	-- Step 10: Devourer of Souls (Undercity)
	-- {object:1661} The Undercity · {npc:5675} Carendin Halgar · {quest:1472} Devourer of Souls · {npc:5875} Gan'rul Bloodeye · {object:36082} Magic Quarter · {npc:5693} Godrick Farsan
	["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} close by. {npc:5693} shows you an image of each quarry and offers both branches: take both."] = "La version de {object:1661}, pour les démonistes qui ont pris la quête {quest:1472} de {npc:5675} plutôt que celle de {npc:5875}. Au niveau 20, {npc:5675}, dans le {object:36082}, vous envoie voir {npc:5693}, tout près. {npc:5693} vous montre une image de chaque proie et propose les deux branches : prenez les deux.",

	-- Step 11: Silverpine hearts
	["Silverpine hearts"] = "Cœurs de la forêt des Pins-Argentés",
	-- {npc:185333} Avelina Lilly · {area:279} Dalaran · {area:233} Ambermill · {npc:5682} Dalin Forgewright · {area:230} Greymane Wall
	["{npc:185333} (level 22) works as a tailor for the {area:279} wizards at {area:233}, in eastern Silverpine: the wizards around her are hostile. {npc:5682} (level 20, not elite) patrols near the {area:230} in the far south. Both are Alliance-friendly humans: attacking them can flag you for PvP. Each drops her or his heart."] = "{npc:185333} (niveau 22) travaille comme couturière pour les sorciers de {area:279} à {area:233}, dans l'est de la forêt des Pins-Argentés : les sorciers autour d'elle sont hostiles. {npc:5682} (niveau 20, pas élite) patrouille près du {area:230}, à l'extrême sud. Ce sont tous deux des humains amicaux envers l'Alliance : les attaquer peut vous marquer JcJ. Chacun lâche son cœur.",

	-- Step 12: Corma Villard
	-- {npc:5683} Corma Villard · {zone:1437} Wetlands · {area:881} Thandol Span · {zone:1458} Undercity · {area:287} Hillsbrad · {zone:1417} Arathi Highlands
	["{npc:5683} (level 22, not elite; Comar in older records) wanders the north of the {zone:1437} just past the {area:881}, to the right as you come off the bridge. From the {zone:1458} head through {area:287} and {zone:1417}, where the mobs are 30 and up. Attacking her flags you for PvP."] = "{npc:5683} (niveau 22, pas élite ; Comar dans les anciennes archives) erre dans le nord des {zone:1437}, juste après le {area:881}, à droite en descendant du pont. Depuis {zone:1458}, passez par {area:287} et les {zone:1417}, où les monstres sont de niveau 30 et plus. L'attaquer vous marque JcJ.",

	-- Step 13: The Binding: succubus (Undercity)
	-- {quest:1474} The Binding · {zone:1458} Undercity
	["{quest:1474}: succubus ({zone:1458})"] = "{quest:1474} : succube ({zone:1458})",
	-- {npc:5675} Carendin Halgar · {npc:5683} Corma Villard · {item:6286} Pure Hearts
	["Back to {npc:5675} with Dalin's and {npc:5683}'s hearts. He hands you the {item:6286}: go down to the summoning circle below him, stand on it and use them. Summon your voidwalker first and keep the fight on the circle, or the guards may kill her and the kill does not count. If she wins, use the hearts again; keep them, {npc:5675} takes them back."] = "",
	-- {item:6286} Pure Hearts · {npc:5675} Carendin Halgar
	["{item:6286}, on the circle below {npc:5675}"] = "{item:6286}, sur le cercle sous {npc:5675}",

	-- Step 14: Isaac Pearson
	-- {npc:185334} Isaac Pearson · {area:392} Ratchet · {zone:1413} Barrens · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["{npc:185334} (level 22) works in {area:392}, on the {zone:1413} coast, at one of two spots in town: take the zeppelin to {zone:1411} and head south, or fly from {zone:1454}. He is an Alliance-friendly human: attacking him can flag you for PvP."] = "{npc:185334} (niveau 22) travaille à {area:392}, sur la côte des {zone:1413}, à l'un des deux endroits possibles en ville : prenez le zeppelin pour {zone:1411} et allez vers le sud, ou volez depuis {zone:1454}. C'est un humain amical envers l'Alliance : l'attaquer peut vous marquer JcJ.",

	-- Step 15: The Binding: incubus (Undercity)
	-- {quest:65597} The Binding · {zone:1458} Undercity
	["{quest:65597}: incubus ({zone:1458})"] = "{quest:65597} : incube ({zone:1458})",
	-- {npc:5675} Carendin Halgar · {item:190181} Lovers' Hearts
	["Back to {npc:5675} with the lovers' hearts, then place the {item:190181} on the same circle and defeat the incubus they call (level 20, not elite; it can charm you). Keep the hearts: {npc:5675} takes them back."] = "Retournez voir {npc:5675} avec les cœurs des amants, puis posez les {item:190181} sur le même cercle et vainquez l'incube qu'ils appellent (niveau 20, pas élite ; il peut vous charmer). Gardez les cœurs : {npc:5675} les reprend.",
	-- {npc:185335} Summoned Incubus · {npc:5675} Carendin Halgar
	["{npc:185335}, at the circle below {npc:5675}"] = "{npc:185335}, au cercle sous {npc:5675}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Un second démon séducteur, le sayaad mâle, et un sac de fragments d'âme pour porter vos fragments.",
	-- ["At 20 {npc:5875}, in the {object:172960} under the {object:172982}, sends you to {npc:5909} a few steps away. Two trainers offer the incubus, {npc:5875} here and {npc:5675} in the {zone:1458}, and you can take only one: this guide follows whichever {quest:1472} you took."] = "Au niveau 20, {npc:5875}, dans la {object:172960} sous la {object:172982}, vous envoie voir {npc:5909} à quelques pas. Deux maîtres proposent l'incube, {npc:5875} ici et {npc:5675} à {zone:1458}, et vous ne pouvez en prendre qu'un : ce guide suit la quête {quest:1472} que vous avez prise.",
	-- ["Back to {npc:5675} in the {object:36082}. Place the hearts at the summoning circle below him and defeat the incubus they call."] = "Retournez voir {npc:5675} dans le {object:36082}. Placez les cœurs sur le cercle d'invocation en dessous de lui et vainquez l'incube qu'ils appellent.",
	-- ["Back to {npc:5675} with Dalin's and Corma's hearts. He hands you the {item:6286}: go down to the summoning circle below him, stand on it and use them. Summon your voidwalker first and keep the fight on the circle, or the guards may kill her and the kill does not count. If she wins, use the hearts again; keep them, {npc:5675} takes them back."] = "Retournez voir {npc:5675} avec les cœurs de Dalin et de Corma. Il vous remet les {item:6286} : descendez au cercle d'invocation sous lui, placez-vous dessus et utilisez-les. Invoquez d'abord votre marcheur du Vide et gardez le combat sur le cercle, sinon les gardes risquent de la tuer et la victime ne compte pas. Si elle gagne, utilisez de nouveau les cœurs ; gardez-les, {npc:5675} les reprend.",
	-- ["Back to {npc:5875} in the {object:172960}. Take the scarf to the summoning circle in {npc:3216}'s tent nearby and defeat the incubus it calls."] = "Retournez voir {npc:5875} dans la {object:172960}. Apportez l'écharpe au cercle d'invocation dans la tente de {npc:3216}, tout près, et vainquez l'incube qu'elle appelle.",
	-- ["Corma Villard"] = "Corma Villard",
	-- ["Corma's Heart"] = "Cœur de Corma",
	-- ["Incubus (Horde)"] = "Incube (Horde)",
	-- ["Take the road west from the {area:380} into {zone:1442} and, just past the border, the faint trail up to the left (south): {area:2539} cannot be reached from the main road. {npc:4197} hands you her draught for {npc:5911}."] = "Prenez la route vers l'ouest depuis la {area:380} jusque dans les {zone:1442} et, juste après la frontière, le sentier peu visible qui monte à gauche (au sud) : {area:2539} est inaccessible depuis la route principale. {npc:4197} vous remet son breuvage pour {npc:5911}.",
	-- ["{area:422} lies in southern {zone:1440}, south of {area:431}. The Shadethicket bog beasts around the lake drop the {item:190232}, about one in twenty."] = "Le {area:422} se trouve dans le sud d'{zone:1440}, au sud du {area:431}. Les bêtes des tourbières Sombretaillis autour du lac laissent tomber l'{item:190232}, environ une fois sur vingt.",
	-- ["{npc:185333} works as a tailor for the {area:279} wizards at {area:233}, in eastern {zone:1421}. Take her heart."] = "{npc:185333} travaille comme couturière pour les sorciers de {area:279} à {area:233}, dans l'est de la {zone:1421}. Prenez son cœur.",
	-- ["{npc:185334} works in {area:392}, on the {zone:1413} coast. Take the zeppelin to {zone:1411} and ride or fly on to {area:392}."] = "{npc:185334} travaille à {area:392}, sur la côte des {zone:1413}. Prenez le zeppelin jusqu'à {zone:1411}, puis continuez à monture ou en vol jusqu'à {area:392}.",
	-- ["{npc:3363} keeps {object:173018}, east of the {object:172960} along the main street. He asks you to look for his mate, Krilge."] = "{npc:3363} tient {object:173018}, à l'est de la {object:172960}, le long de la rue principale. Il vous demande de chercher sa compagne, Krilge.",
	-- ["{npc:3464} waits in front of the inn at the {area:380}. He sends you on to {npc:4197} at {area:2539}, in {zone:1442}."] = "{npc:3464} attend devant l'auberge de la {area:380}. Il vous envoie ensuite voir {npc:4197} à {area:2539}, dans les {zone:1442}.",
	-- ["{npc:5675}: he binds the incubus to you"] = "{npc:5675} : il vous lie l'incube",
	-- ["{npc:5875}: he binds the incubus to you"] = "{npc:5875} : il vous lie l'incube",
	-- ["{npc:5910} lives in a hut up on the cliffs on the west side of the city, above the {object:172982}: climb the wind rider tower, cross the bridge at its top to the west and turn right off it. She sends you to the {area:380}."] = "{npc:5910} vit dans une hutte en haut des falaises du côté ouest de la ville, au-dessus de la {object:172982} : montez à la tour des coursiers du vent, traversez le pont à son sommet vers l'ouest et tournez à droite en le quittant. Elle vous envoie à la {area:380}.",
	-- ["{npc:5911} stands at {area:378}, south down the road from the {area:380}. He sends you north to the quilboar camp where Dogran is held: the camp with two huts side by side, north-west of a decoy camp whose huts stand apart. A rare level 22 elite quilboar sometimes guards the huts: send your voidwalker in, sacrifice it if you must, and talk to Dogran. He gives you a pendant for {npc:5875}. Keep it."] = "{npc:5911} se tient au {area:378}, au sud de la {area:380} par la route. Il vous envoie au nord, au camp des hurans où Dogran est retenu : le camp aux deux huttes côte à côte, au nord-ouest d'un camp leurre dont les huttes sont séparées. Un huran élite rare de niveau 22 garde parfois les huttes : envoyez votre marcheur du Vide, sacrifiez-le s'il le faut, et parlez à Dogran. Il vous donne un pendentif pour {npc:5875}. Gardez-le.",
	-- ["{object:1661}'s version, for warlocks who took {npc:5675}'s {quest:1472} instead of {npc:5875}'s. At 20 {npc:5675}, in the {object:36082}, sends you to {npc:5693} in the Temple of the Damned, just north of him."] = "La version de {object:1661}, pour les démonistes qui ont pris la quête {quest:1472} de {npc:5675} au lieu de celle de {npc:5875}. Au niveau 20, {npc:5675}, dans le {object:36082}, vous envoie voir {npc:5693} dans le temple des Damnés, juste au nord.",
}
