-- French (frFR): the guide forever/class/warrior/voodoo-feathers (forever/class/warrior/voodoo-feathers.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:1417} Sunken Temple
	["Experience at 50, ending in the {area:1417}; Forever removed the Classic item choice."] = "De l'expérience au niveau 50, avec une fin dans le {area:1417} ; Forever a supprimé le choix d'objet de Classic.",
	["Experience"] = "Expérience",

	-- Step 1: A Troubled Spirit (Stormwind)
	-- {npc:5479} Wu Shen · {object:2100} Old Town · {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows
	["At 50, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to the {npc:7572} in the {zone:1435}."] = "Au niveau 50, {npc:5479}, dans la {object:2100}, à côté de la Taverne du Cochon siffleur, vous envoie voir le {npc:7572} dans le {zone:1435}.",

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
	-- {npc:7572} Fallen Hero of the Horde · {zone:1435} Swamp of Sorrows · {zone:1419} Blasted Lands
	["The {npc:7572} stands in the south-west of the {zone:1435}, at the entrance to the {zone:1419}."] = "Le {npc:7572} se tient dans le sud-ouest du {zone:1435}, à l'entrée des {zone:1419}.",

	-- Step 8: Helboars
	-- plural, as words: Helboars = {npc:5993} Helboar
	["Helboars"] = "Sangliers infernaux",
	-- {zone:1419} Blasted Lands · {npc:10996} Fallen Hero
	-- plural, as words: Helboars = {npc:5993} Helboar
	["The Helboars roam the north of the {zone:1419}, south of the {npc:10996}."] = "Les Sangliers infernaux rôdent dans le nord des {zone:1419}, au sud du {npc:10996}.",

	-- Step 10: Shadowsworn camps
	["Shadowsworn camps"] = "Camps des liges d'ombre",
	-- {zone:1419} Blasted Lands
	["The Shadowsworn cultists hold the east of the {zone:1419}."] = "Les sectateurs lige d'ombre occupent l'est des {zone:1419}.",

	-- Step 12: The Sunken Temple
	-- {area:1417} Sunken Temple
	["The {area:1417}"] = "Le {area:1417}",
	-- {area:1417} Sunken Temple · {area:74} Pool of Tears · {zone:1435} Swamp of Sorrows · {npc:5716} Zul'Lor
	["The {area:1417} lies under the {area:74} in the east of the {zone:1435}. Each of the six Atal'ai trolls on the balcony drops a voodoo feather: Gasher or {npc:5716} the amber, Hukku or Mijan the blue, Zolo or Loro the green. The {area:1417} is a dungeon and the trolls are elite: grouping up is advised."] = "Le {area:1417} se trouve sous le {area:74}, dans l'est du {zone:1435}. Chacun des six trolls atal'ai du balcon laisse tomber une plume vaudou : Balafreur ou {npc:5716} l'ambre, Hukku ou Mijan la bleue, Zolo ou Loro la verte. Le {area:1417} est un donjon et les trolls sont élites : il est conseillé de former un groupe.",

	-- Step 13: Back to the Fallen Hero
	-- {npc:10996} Fallen Hero
	["Back to the {npc:10996}"] = "Retour auprès du {npc:10996}",
}
