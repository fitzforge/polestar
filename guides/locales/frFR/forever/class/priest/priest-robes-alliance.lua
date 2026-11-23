-- French (frFR): the guide forever/class/priest/priest-robes-alliance (forever/class/priest/priest-robes-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Alliance)"] = "Robe de prêtre au niveau 5 (Alliance)",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "Une robe inhabituelle gratuite au niveau 5 : soignez et fortifiez un garde blessé près de votre première ville.",

	-- Step 1: In Favor of the Light
	-- {npc:375} Priestess Anetta · {area:24} Northshire Abbey · {npc:377} Priestess Josetta · {area:87} Goldshire · {spell:613} Lesser Heal
	["At 5, {npc:375}, the priest trainer inside {area:24}, sends you to {npc:377} in {area:87}. Train {spell:613} (Rank 2) from Anetta while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Au niveau 5, {npc:375}, la maîtresse des prêtres dans l'{area:24}, vous envoie voir {npc:377} à {area:87}. Apprenez {spell:613} (rang 2) auprès d'Anetta pendant que vous y êtes : il est disponible au niveau 4 pour 1 pa, et la quête suivante demande exactement ce rang.",

	-- Step 2: Priestess Josetta
	-- {area:9} Northshire Valley · {area:87} Goldshire · {npc:377} Priestess Josetta
	["Follow the road south out of {area:9} to {area:87}. {npc:377} is upstairs in the Lion's Pride Inn."] = "Suivez la route vers le sud en sortant de la {area:9} jusqu'à {area:87}. {npc:377} est à l'étage de l'auberge de la Fierté du lion.",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Anetta did not teach it yet"] = "{spell:613} (rang 2), si Anetta ne vous l'a pas encore appris",

	-- Step 3: Guard Roberts
	-- {npc:12423} Guard Roberts · {area:87} Goldshire · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12423} kneels by a tree on the lake shore east of {area:87}, off the road: walk along the shore, the minimap misses him from the road. Cast {spell:613} (Rank 2) on him first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook (or cast both from the spellbook if an action bar addon gets in the way). He walks off once both land and is back in about 3 minutes."] = "{npc:12423} est agenouillé près d'un arbre sur la rive du lac à l'est de {area:87}, à l'écart de la route : longez la rive, la minicarte ne le montre pas depuis la route. Lancez d'abord {spell:613} (rang 2) sur lui, puis {spell:1243}. Le rang 1 de {spell:613} ne compte pas ; faites glisser le rang 2 depuis le grimoire vers votre barre (ou lancez les deux depuis le grimoire si un addon de barres d'action vous gêne). Il s'en va une fois les deux sorts reçus et revient en 3 minutes environ.",
	-- {npc:12423} Guard Roberts
	["Heal and fortify {npc:12423}"] = "Soignez et fortifiez {npc:12423}",

	-- Step 4: Priestess Josetta
	-- {item:16605} Friar's Robes of the Light
	["Back upstairs in the Lion's Pride Inn: Josetta gives you {item:16605}."] = "Remontez à l'étage de l'auberge de la Fierté du lion : Josetta vous donne la {item:16605}.",

	-- Step 5: In Favor of the Light
	-- {npc:837} Branstock Khalder · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:1226} Maxan Anvol · {area:131} Kharanos · {spell:613} Lesser Heal
	["At 5, {npc:837}, the priest trainer inside {area:77} in {area:132}, sends you to {npc:1226} in {area:131}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Au niveau 5, {npc:837}, le maître des prêtres dans {area:77}, dans la {area:132}, vous envoie voir {npc:1226} à {area:131}. Apprenez {spell:613} (rang 2) auprès de lui pendant que vous y êtes : il est disponible au niveau 4 pour 1 pa, et la quête suivante demande exactement ce rang.",

	-- Step 6: Maxan Anvol
	-- {area:132} Coldridge Valley · {area:131} Kharanos · {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery
	["Take the tunnel north-east out of {area:132} and follow the road east to {area:131}. {npc:1226} is inside the {area:2102}."] = "Prenez le tunnel au nord-est pour sortir de la {area:132} et suivez la route vers l'est jusqu'à {area:131}. {npc:1226} est dans la {area:2102}.",
	-- {spell:613} Lesser Heal · {npc:837} Branstock Khalder
	["{spell:613} (Rank 2), if {npc:837} did not teach it yet"] = "{spell:613} (rang 2), si {npc:837} ne vous l'a pas encore appris",

	-- Step 7: Mountaineer Dolf
	-- {npc:12427} Mountaineer Dolf · {area:131} Kharanos · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12427} kneels on a ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer: if the road starts going downhill, you have passed him. Cast {spell:613} (Rank 2) on him first, then {spell:1243}; he speaks after each spell. Rank 1 of {spell:613} does not count."] = "{npc:12427} est agenouillé sur une crête entre deux murets juste au sud de {area:131}, de l'autre côté de la route par rapport au maître des familiers : si la route commence à descendre, vous l'avez dépassé. Lancez d'abord {spell:613} (rang 2) sur lui, puis {spell:1243} ; il parle après chaque sort. Le rang 1 de {spell:613} ne compte pas.",
	-- {npc:12427} Mountaineer Dolf
	["Heal and fortify {npc:12427}"] = "Soignez et fortifiez {npc:12427}",

	-- Step 8: Maxan Anvol
	-- {area:2102} Thunderbrew Distillery · {npc:1226} Maxan Anvol · {item:16605} Friar's Robes of the Light
	["Back inside the {area:2102}: {npc:1226} gives you {item:16605}."] = "De retour dans la {area:2102} : {npc:1226} vous donne la {item:16605}.",

	-- Step 9: In Favor of Elune
	-- {npc:3595} Shanda · {area:256} Aldrassil · {area:188} Shadowglen · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {spell:613} Lesser Heal
	["At 5, {npc:3595}, the priest trainer on the second level of {area:256}, the great tree in {area:188}, sends you to {npc:3600} in {area:186}. Train {spell:613} (Rank 2) from her while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Au niveau 5, {npc:3595}, la maîtresse des prêtres au deuxième niveau d'{area:256}, le grand arbre de {area:188}, vous envoie voir {npc:3600} à {area:186}. Apprenez {spell:613} (rang 2) auprès d'elle pendant que vous y êtes : il est disponible au niveau 4 pour 1 pa, et la quête suivante demande exactement ce rang.",

	-- Step 10: Laurna Morninglight
	-- {area:188} Shadowglen · {area:186} Dolanaar · {npc:3600} Laurna Morninglight
	["Leave {area:188} by the ramp and follow the road south-west to {area:186}. {npc:3600} is in the building at the north edge of the village."] = "Quittez {area:188} par la rampe et suivez la route vers le sud-ouest jusqu'à {area:186}. {npc:3600} est dans le bâtiment au bord nord du village.",
	-- {spell:613} Lesser Heal · {npc:3595} Shanda
	["{spell:613} (Rank 2), if {npc:3595} did not teach it yet"] = "{spell:613} (rang 2), si {npc:3595} ne vous l'a pas encore appris",

	-- Step 11: Sentinel Shaya
	-- {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth · {area:186} Dolanaar · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12429} kneels on the rocks at the edge of {area:259}, about 100 yards south of {area:186}, with no quest mark over her. Cast {spell:613} (Rank 2) on her first, then {spell:1243}; she runs off toward the lake once both land and is back in about 5 minutes. Rank 1 of {spell:613} does not count."] = "{npc:12429} est agenouillée sur les rochers au bord du {area:259}, à une centaine de mètres au sud de {area:186}, sans marque de quête au-dessus d'elle. Lancez d'abord {spell:613} (rang 2) sur elle, puis {spell:1243} ; elle court vers le lac une fois les deux sorts reçus et revient en 5 minutes environ. Le rang 1 de {spell:613} ne compte pas.",
	-- {npc:12429} Sentinel Shaya
	["Heal and fortify {npc:12429}"] = "Soignez et fortifiez {npc:12429}",

	-- Step 12: Laurna Morninglight
	-- {area:186} Dolanaar · {npc:3600} Laurna Morninglight · {item:16604} Moon Robes of Elune
	["Back at the north edge of {area:186}: {npc:3600} gives you the {item:16604}."] = "De retour au bord nord de {area:186} : {npc:3600} vous donne la {item:16604}.",
}
