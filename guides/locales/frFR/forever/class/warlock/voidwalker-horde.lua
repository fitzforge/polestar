-- French (frFR): the guide forever/class/warlock/voidwalker-horde (forever/class/warlock/voidwalker-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Voidwalker (Horde)"] = "Marcheur du Vide (Horde)",
	["Your tank demon at 10: the voidwalker, after a stolen book and a fight at a summoning circle."] = "Votre démon-tank au niveau 10 : le marcheur du Vide, après un livre volé et un combat dans un cercle d'invocation.",

	-- Step 1: Gan'rul's Summons (Orcs and Trolls)
	-- {quest:1506} Gan'rul's Summons
	["{quest:1506} (Orcs and Trolls)"] = "{quest:1506} (Orcs et Trolls)",
	-- {npc:3294} Ophek · {npc:5875} Gan'rul Bloodeye · {area:362} Razor Hill · {npc:3172} Dhugru Gorelust · {object:172960} Cleft of Shadow · {zone:1454} Orgrimmar · {object:172982} Valley of Strength · {zone:1420} Tirisfal Glades · {zone:1458} Undercity · {npc:5724} Ageron Kargal · {area:159} Brill
	["At 10 {npc:3294} sends you to {npc:5875}. He stands outside at the back of {area:362}'s barracks, the big building on the east side of town (not the inn), a few steps from {npc:3172}, the warlock trainer. {npc:5875} stands with the senior warlocks in the {object:172960}, the cavern under {zone:1454}'s {object:172982}. An Orc or Troll leveling in {zone:1420} can take the {zone:1458} version from {npc:5724} in {area:159} instead (the {zone:1458} steps below): you can do only one of the two."] = "Au niveau 10, {npc:3294} vous envoie voir {npc:5875}. Il se tient dehors, à l'arrière de la caserne de {area:362}, le grand bâtiment du côté est de la ville (pas l'auberge), à quelques pas de {npc:3172}, le maître des démonistes. {npc:5875} se tient avec les démonistes chevronnés dans la {object:172960}, la caverne sous la {object:172982} d'{zone:1454}. Un Orc ou un Troll qui progresse dans les {zone:1420} peut prendre à la place la version de {zone:1458} auprès de {npc:5724} à {area:159} (les étapes de {zone:1458} plus bas) : vous ne pouvez faire que l'une des deux.",

	-- Step 2: Skull Rock
	-- {area:817} Skull Rock · {zone:1454} Orgrimmar · {object:58595} Burning Blade Stash · {npc:3204} Gazz'uz
	-- plural, as words: Burning Blade Apprentices = {npc:3198} Burning Blade Apprentice
	["{area:817} is the cave in the cliffs just east of {zone:1454}'s gate. Inside, take the right-hand ramp up and follow it to the top: the {object:58595} sits on that upper ledge, which cannot be reached from the lower floor. The cave is packed with Burning Blade Apprentices and Fanatics (level 9-11, many with voidwalkers) that respawn quickly, and {npc:3204}, a level 14 Burning Blade warlock, stands near the stash. Old notes call him elite; Forever's data lists him as normal. At 10 it is hard alone: pull one pack at a time and Fear the extra, wait for 11, or go with a friend. The stash always holds the tablet."] = "Le {area:817} est la grotte dans les falaises juste à l'est de la porte d'{zone:1454}. À l'intérieur, prenez la rampe de droite et suivez-la jusqu'en haut : la {object:58595} se trouve sur cette corniche supérieure, inaccessible depuis le niveau inférieur. La grotte est bondée d'Apprentis de la Lame ardente et de Fanatiques (niveau 9-11, beaucoup avec des marcheurs du Vide) qui réapparaissent vite, et {npc:3204}, un démoniste de la Lame ardente de niveau 14, se tient près de la cachette. D'anciennes notes le disent élite ; les données de Forever le donnent normal. Au niveau 10, c'est dur en solo : attirez un groupe à la fois et apeurez le surplus, attendez le niveau 11, ou venez avec un ami. La cachette contient toujours la tablette.",
	-- {item:6535} Tablet of Verga · {object:58595} Burning Blade Stash
	["{item:6535}, in the {object:58595}"] = "{item:6535}, dans la {object:58595}",

	-- Step 3: The Binding (Orgrimmar)
	-- {npc:5875} Gan'rul Bloodeye · {item:7464} Glyphs of Summoning · {object:172960} Cleft of Shadow · {npc:3216} Neeru Fireblade · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5875}. He hands you the {item:7464}: take them across the {object:172960} to {npc:3216}'s tent, stand on the purple circle on its floor and use them. The voidwalker (level 10, not elite) hits hard at 30% health and leaves after three minutes, so start at once: {spell:14868}, Corruption and {spell:348}, send your imp in, and Fear it when you need a breather. If it beats you or leaves, the glyphs are not used up: use them again on the circle. Keep the glyphs: {npc:5875} takes them back."] = "Retournez voir {npc:5875}. Il vous remet les {item:7464} : traversez la {object:172960} jusqu'à la tente de {npc:3216}, placez-vous sur le cercle violet au sol et utilisez-les. Le marcheur du Vide (niveau 10, pas élite) frappe fort à 30 % de vie et s'en va au bout de trois minutes, commencez donc aussitôt : {spell:14868}, Corruption et {spell:348}, envoyez votre diablotin, et apeurez-le quand vous avez besoin de souffler. S'il vous bat ou s'en va, les glyphes ne sont pas consommés : utilisez-les de nouveau sur le cercle. Gardez les glyphes : {npc:5875} les reprend.",
	-- {item:7464} Glyphs of Summoning
	["{item:7464}, on the circle in Neeru's tent"] = "{item:7464}, sur le cercle de la tente de Neeru",

	-- Step 4: Halgar's Summons (Undercity)
	-- {npc:5724} Ageron Kargal · {area:2119} Gallows' End Tavern · {area:159} Brill · {npc:5675} Carendin Halgar · {zone:1420} Tirisfal Glades · {npc:5875} Gan'rul Bloodeye · {zone:1458} Undercity · {object:36082} Magic Quarter
	["At 10 {npc:5724}, upstairs in the {area:2119} in {area:159}, sends you to {npc:5675}: the version for the Undead, and for Orcs and Trolls who level in {zone:1420} instead of taking {npc:5875}'s. {npc:5675} stands in the {zone:1458}'s {object:36082}, by the Temple of the Damned."] = "Au niveau 10, {npc:5724}, à l'étage de la {area:2119} à {area:159}, vous envoie voir {npc:5675} : la version pour les Morts-vivants, et pour les Orcs et Trolls qui progressent dans les {zone:1420} au lieu de prendre celle de {npc:5875}. {npc:5675} se tient dans le {object:36082} de {zone:1458}, près du temple des Damnés.",
	-- {npc:5724} Ageron Kargal · {area:159} Brill
	["{npc:5724}, upstairs in the {area:159} inn"] = "{npc:5724}, à l'étage de l'auberge de {area:159}",

	-- Step 5: Perrine's Chest
	-- {zone:1458} Undercity · {area:154} Deathknell · {npc:1662} Captain Perrine · {npc:1537} Scarlet Zealot
	["The Scarlet tower stands in the fields west of the {zone:1458}'s ruins (not the tower near {area:154}). The grimoire is in the small chest on the ground floor, under the stairs; ignore the chest upstairs. {npc:1662} (level 9) and a {npc:1537} guard it: kill them, or Fear the zealot while you deal with Perrine. Scarlet Missionaries and Zealots (level 7-9) walk the fields around the tower. The chest is back three seconds after anyone opens it."] = "La tour écarlate se dresse dans les champs à l'ouest des ruines de {zone:1458} (pas la tour près de {area:154}). Le grimoire est dans le petit coffre au rez-de-chaussée, sous l'escalier ; ignorez le coffre de l'étage. {npc:1662} (niveau 9) et un {npc:1537} le gardent : tuez-les, ou apeurez le zélote pendant que vous vous occupez de Perrine. Des Missionnaires et des Zélotes écarlates (niveau 7-9) parcourent les champs autour de la tour. Le coffre revient trois secondes après avoir été ouvert.",
	-- {item:6285} Egalin's Grimoire · {object:37098} Perrine's Chest
	["{item:6285}, in {object:37098}"] = "{item:6285}, dans le {object:37098}",

	-- Step 6: The Binding (Undercity)
	-- {npc:5675} Carendin Halgar · {item:6284} Runes of Summoning · {spell:14868} Curse of Agony · {spell:348} Immolate
	["Back to {npc:5675}. He hands you the {item:6284}: go down the stairs from him to the summoning circle and use them while standing on it. Fight the voidwalker (level 10, not elite) on the circle: if it wanders off, the city guards may kill it and the kill does not count. {spell:14868}, Corruption and {spell:348} with your imp tanking bring it down; it hits harder below 30%. If you lose, use the runes again. Keep the runes: {npc:5675} takes them back."] = "Retournez voir {npc:5675}. Il vous remet les {item:6284} : descendez l'escalier depuis lui jusqu'au cercle d'invocation et utilisez-les en vous tenant dessus. Combattez le marcheur du Vide (niveau 10, pas élite) sur le cercle : s'il s'éloigne, les gardes de la ville risquent de le tuer et la victime ne compte pas. {spell:14868}, Corruption et {spell:348}, avec votre diablotin pour encaisser, en viennent à bout ; il frappe plus fort sous 30 %. Si vous perdez, utilisez de nouveau les runes. Gardez les runes : {npc:5675} les reprend.",
	-- {item:6284} Runes of Summoning · {npc:5675} Carendin Halgar
	["{item:6284}, on the circle below {npc:5675}"] = "{item:6284}, sur le cercle sous {npc:5675}",
}
