-- French (frFR): the guide forever/class/warrior/voodoo-feathers (forever/class/warrior/voodoo-feathers.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:1417} Sunken Temple
	["Experience at 50, ending in the {area:1417}; Classic's item choice may be gone on Forever."] = "De l'expérience au niveau 50, avec une fin au {area:1417} ; le choix d'objet de Classic a peut-être disparu dans Forever.",
	["Experience"] = "Expérience",

	-- Step 1: A Troubled Spirit (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to the {npc:7572} in the {zone:1435}."] = "Au niveau 50, {npc:5479}, à côté de {npc:5480} dans le bâtiment des maîtres des guerriers de la {object:2100}, vous envoie voir le {npc:7572} dans le {zone:1435}.",

	-- Step 2: A Troubled Spirit (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5113}, the warrior trainer of {zone:1455}, sends you to the {npc:7572} in the {zone:1435}."] = "Au niveau 50, {npc:5113}, le maître des guerriers de {zone:1455}, vous envoie voir le {npc:7572} dans le {zone:1435}.",

	-- Step 3: A Troubled Spirit (Darnassus)
	-- {npc:7315} Darnath Bladesinger · {zone:1457} Darnassus · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:7315}, the warrior trainer of {zone:1457}, sends you to the {npc:7572} in the {zone:1435}."] = "Au niveau 50, {npc:7315}, le maître des guerriers de {zone:1457}, vous envoie voir le {npc:7572} dans le {zone:1435}.",

	-- Step 4: A Troubled Spirit (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3354} in the {object:172958} sends you to the {npc:7572} in the {zone:1435}."] = "Au niveau 50, {npc:3354}, dans la {object:172958}, vous envoie voir le {npc:7572} dans le {zone:1435}.",

	-- Step 5: A Troubled Spirit (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:3041}, the warrior trainer of {zone:1456}, sends you to the {npc:7572} in the {zone:1435}."] = "Au niveau 50, {npc:3041}, le maître des guerriers de {zone:1456}, vous envoie voir le {npc:7572} dans le {zone:1435}.",

	-- Step 6: A Troubled Spirit (Undercity)
	-- {npc:4593} Christoph Walker · {zone:1458} Undercity · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:4593}, a warrior trainer of the {zone:1458}, sends you to the {npc:7572} in the {zone:1435}."] = "Au niveau 50, {npc:4593}, un maître des guerriers de {zone:1458}, vous envoie voir le {npc:7572} dans le {zone:1435}.",

	-- Step 7: The Fallen Hero of the Horde
	-- {npc:7572} Fallen Hero of the Horde
	["The {npc:7572}"] = "Le {npc:7572}",
	-- {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands · {area:75} Stonard · {area:1438} Nethergarde Keep
	["The {npc:7572}, a ghost, stands in the south-west of the {zone:1435}, at the pass into the {zone:1419}, a short ride south-west of {area:75}. Horde: fly to {area:75}. Alliance: fly to {area:1438} in the {zone:1419} and ride north through the pass. High-level beasts roam the way."] = "Le {npc:7572}, un fantôme, se tient au sud-ouest du {zone:1435}, au col qui mène aux {zone:1419}, à courte distance au sud-ouest de {area:75}. Horde : volez jusqu'à {area:75}. Alliance : volez jusqu'au {area:1438}, dans les {zone:1419}, et chevauchez vers le nord par le col. Des bêtes de haut niveau rôdent en chemin.",

	-- Step 8: Helboars
	-- plural, as words: Helboars = {npc:5993} Helboar
	["Helboars"] = "Sangliers infernaux",
	-- {zone:1419} Blasted Lands · {area:1438} Nethergarde Keep · {spell:8349} Fire Nova
	-- plural, as words: Helboars = {npc:5993} Helboar
	["Seven Helboars (level 52-53, not elite) roam the north-west of the {zone:1419}, south-west of {area:1438}; some stand near the ogres on the mountainside by the road. They charge from 25 yards and cast {spell:8349}. They share spawn points with the Felbeasts and scorpids: if no boars are around, kill those and boars may appear instead. Back in 5 minutes."] = "Sept Sangliers infernaux (niveau 52-53, pas élites) parcourent le nord-ouest des {zone:1419}, au sud-ouest du {area:1438} ; certains se tiennent près des ogres, sur le flanc de la montagne au bord de la route. Ils chargent à 25 mètres et lancent {spell:8349}. Ils partagent leurs points d'apparition avec les gangrebêtes et les scorpides : s'il n'y a aucun sanglier, tuez ceux-là et des sangliers peuvent apparaître à leur place. De retour en 5 minutes.",

	-- Step 10: Shadowsworn camps
	["Shadowsworn camps"] = "Camps des liges d'ombre",
	-- {area:1440} Serpent's Coil · {area:1438} Nethergarde Keep · {area:72} Dark Portal · {spell:1766} Kick
	["The Shadowsworn camp around the mouth of the {area:1440} cave, south of {area:1438} on the way to the {area:72}. You need 20 Adepts (level 52-53, they leech blood and heal hurt allies: kill them first), 10 Cultists (51-52, they throw from range, so close in) and 20 Thugs (52-53, Thrash and {spell:1766}). Thugs can run short before the others: kill every Shadowsworn you pass."] = "Les Jurés-de-l'ombre campent autour de l'entrée de la grotte du {area:1440}, au sud du {area:1438} sur le chemin de la {area:72}. Il vous faut 20 Adeptes (niveau 52-53, ils drainent le sang et soignent leurs alliés blessés : tuez-les en premier), 10 Sectateurs (51-52, ils frappent à distance, rapprochez-vous donc) et 20 Voyous (52-53, Rossée et {spell:1766}). Les Voyous peuvent manquer avant les autres : tuez chaque Juré-de-l'ombre que vous croisez.",

	-- Step 12: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "Le {area:1417}",
	-- {area:1417} Sunken Temple · {npc:5710} Jammal'an the Prophet · {npc:5716} Zul'Lor · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {spell:9081} Shadow Bolt Volley · {spell:8282} Curse of Blood · {spell:139} Renew · {npc:3560} Healing Ward · {spell:331} Healing Wave
	["You need two feathers of each colour from the six Atal'ai troll guardians (level 51-52, elite) on the {area:1417}'s balcony, who hold the barrier in front of {npc:5710}: Gasher and {npc:5716} drop the amber, Hukku and Mijan the blue, Zolo and Loro the green, every kill; each player on the quest loots their own set. The {area:1417} is a five-player dungeon: needs a group of five. It lies in the {area:74} in eastern {zone:1435}: climb the temple's outer steps, dive into the flooded hall and follow the stairs down to the entrance. Inside, reach the balcony by the stairs or the path on the right, not the spiral stairs. Hukku calls guardians and casts {spell:9081} and {spell:8282}; Mijan heals the others ({spell:139}, a {npc:3560}, {spell:331} below half health): kill her or her ward fast; {npc:5716} cleaves."] = "Il vous faut deux plumes de chaque couleur, sur les six gardiens trolls Atal'ai (niveau 51-52, élites) du balcon du {area:1417}, qui tiennent la barrière devant {npc:5710} : Balafreur et {npc:5716} lâchent l'ambre, Hukku et Mijan la bleue, Zolo et Loro la verte, à chaque victime ; chaque joueur ayant la quête ramasse son propre lot. Le {area:1417} est un donjon à cinq joueurs : il faut un groupe de cinq. Il se trouve dans l'{area:74}, dans l'est du {zone:1435} : montez les marches extérieures du temple, plongez dans la salle inondée et suivez les escaliers jusqu'à l'entrée. À l'intérieur, rejoignez le balcon par les escaliers ou le chemin de droite, pas par l'escalier en colimaçon. Hukku appelle des gardiens et lance {spell:9081} et {spell:8282} ; Mijan soigne les autres ({spell:139}, une {npc:3560}, {spell:331} sous la moitié de sa vie) : tuez-la vite, ou sa garde ; {npc:5716} porte des enchaînements.",
	-- {item:20606} Amber Voodoo Feather · {npc:5716} Zul'Lor
	["{item:20606}, from Gasher and {npc:5716}"] = "{item:20606}, sur Balafreur et {npc:5716}",
	-- {item:20607} Blue Voodoo Feather
	["{item:20607}, from Hukku and Mijan"] = "{item:20607}, sur Hukku et Mijan",
	-- {item:20608} Green Voodoo Feather
	["{item:20608}, from Zolo and Loro"] = "{item:20608}, sur Zolo et Loro",

	-- Step 13: Back to the Fallen Hero
	-- {npc:10996} Fallen Hero
	["Back to the {npc:10996}"] = "Retour auprès du {npc:10996}",
	-- {npc:10996} Fallen Hero · {item:20130} Diamond Flask · {item:20521} Fury Visor · {item:20517} Razorsteel Shoulders
	["In Classic the {npc:10996} let you choose the {item:20130}, the {item:20521} or the {item:20517} here. Forever's change notes say the choice is gone, though its quest page still lists three unnamed rewards: look at the reward window before you hand in."] = "Dans Classic, le {npc:10996} vous laissait choisir ici le {item:20130}, la {item:20521} ou les {item:20517}. Les notes de mise à jour de Forever disent que le choix a disparu, mais sa page de quête liste encore trois récompenses sans nom : regardez la fenêtre de récompense avant de rendre la quête.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to the {npc:7572} in the {zone:1435}."] = "Au niveau 50, {npc:5479}, dans la {object:2100}, à côté de la Taverne du Cochon siffleur, vous envoie voir le {npc:7572} dans le {zone:1435}.",
	-- ["Experience at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "De l'expérience au niveau 50, avec une fin dans le {area:1417} ; Forever a supprimé le choix d'objet de Classic.",
	-- ["The Helboars roam the north of the {zone:1419}, south of the {npc:10996}."] = "Les Sangliers infernaux rôdent dans le nord des {zone:1419}, au sud du {npc:10996}.",
	-- ["The Shadowsworn cultists hold the east of the {zone:1419}."] = "Les sectateurs lige d'ombre occupent l'est des {zone:1419}.",
	-- ["The {area:1417} lies under the {area:74} in the east of the {zone:1435}. Each of the six Atal'ai trolls on the balcony drops a voodoo feather: Gasher or {npc:5716} the amber, Hukku or Mijan the blue, Zolo or Loro the green. The {area:1417} is a dungeon and the trolls are elite: grouping up is advised."] = "Le {area:1417} se trouve sous le {area:74}, dans l'est du {zone:1435}. Chacun des six trolls atal'ai du balcon laisse tomber une plume vaudou : Balafreur ou {npc:5716} l'ambre, Hukku ou Mijan la bleue, Zolo ou Loro la verte. Le {area:1417} est un donjon et les trolls sont élites : il est conseillé de former un groupe.",
	-- ["The {npc:7572} stands in the south-west of the {zone:1435}, at the entrance to the {zone:1419}."] = "Le {npc:7572} se tient dans le sud-ouest du {zone:1435}, à l'entrée des {zone:1419}.",
}
