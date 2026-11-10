-- French (frFR): the guide forever/class/priest/priest-robes-horde (forever/class/priest/priest-robes-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Horde)"] = "Robe de prêtre au niveau 5 (Horde)",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "Une robe inhabituelle gratuite au niveau 5 : soignez et fortifiez un garde blessé près de votre première ville.",

	-- Step 1: In Favor of Spirituality
	-- {npc:3707} Ken'jai · {area:363} Valley of Trials · {npc:3706} Tai'jin · {area:362} Razor Hill · {spell:613} Lesser Heal
	["At 5, {npc:3707}, the priest trainer in the Den in the middle of the {area:363}, sends you to {npc:3706} in {area:362}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Au niveau 5, {npc:3707}, le maître des prêtres dans la Tanière, au milieu de la {area:363}, vous envoie voir {npc:3706} à {area:362}. Apprenez {spell:613} (rang 2) auprès de lui pendant que vous y êtes : il est disponible au niveau 4 pour 1 pa, et la quête suivante demande exactement ce rang.",

	-- Step 2: Tai'jin
	-- {area:363} Valley of Trials · {area:362} Razor Hill · {npc:3706} Tai'jin
	["Follow the road out of the {area:363} north-east to {area:362}. {npc:3706} is inside the barracks, the first building on the right as you come into town."] = "Suivez la route qui sort de la {area:363} vers le nord-est jusqu'à {area:362}. {npc:3706} est dans la caserne, le premier bâtiment à droite en entrant dans la ville.",
	-- {spell:613} Lesser Heal · {npc:3707} Ken'jai
	["{spell:613} (Rank 2), if {npc:3707} did not teach it yet"] = "{spell:613} (rang 2), si {npc:3707} ne vous l'a pas encore appris",

	-- Step 3: Grunt Kor'ja
	-- {npc:12430} Grunt Kor'ja · {area:362} Razor Hill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12430} kneels behind a group of rocks just off the road, a short walk south of {area:362}. Cast {spell:613} (Rank 2) on her first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook. She leaves once both land and is back in about 5 minutes."] = "{npc:12430} est agenouillée derrière un groupe de rochers juste à côté de la route, à quelques pas au sud de {area:362}. Lancez d'abord {spell:613} (rang 2) sur elle, puis {spell:1243}. Le rang 1 de {spell:613} ne compte pas ; faites glisser le rang 2 depuis le grimoire vers votre barre. Elle s'en va une fois les deux sorts reçus et revient en 5 minutes environ.",
	-- {npc:12430} Grunt Kor'ja
	["Heal and fortify {npc:12430}"] = "Soignez et fortifiez {npc:12430}",

	-- Step 4: Tai'jin
	-- {area:362} Razor Hill · {npc:3706} Tai'jin · {item:16606} Juju Hex Robes
	["Back in the {area:362} barracks: {npc:3706} gives you the {item:16606}."] = "De retour à la caserne de {area:362} : {npc:3706} vous donne la {item:16606}.",

	-- Step 5: In Favor of Darkness
	-- {npc:2123} Dark Cleric Duesten · {area:154} Deathknell · {npc:2129} Dark Cleric Beryl · {area:159} Brill · {spell:613} Lesser Heal
	["At 5, {npc:2123}, the priest trainer in the chapel of {area:154}, sends you to {npc:2129} in {area:159}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Au niveau 5, {npc:2123}, le maître des prêtres dans la chapelle de {area:154}, vous envoie voir {npc:2129} à {area:159}. Apprenez {spell:613} (rang 2) auprès de lui pendant que vous y êtes : il est disponible au niveau 4 pour 1 pa, et la quête suivante demande exactement ce rang.",

	-- Step 6: Dark Cleric Beryl
	-- {area:154} Deathknell · {area:159} Brill · {npc:2129} Dark Cleric Beryl · {area:2119} Gallows' End Tavern
	["Follow the road east out of {area:154} to {area:159}. {npc:2129} is upstairs in the inn, {area:2119}."] = "Suivez la route vers l'est en sortant de {area:154} jusqu'à {area:159}. {npc:2129} est à l'étage de l'auberge, la {area:2119}.",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Duesten did not teach it yet"] = "{spell:613} (rang 2), si Duesten ne vous l'a pas encore appris",

	-- Step 7: Deathguard Kel
	-- {npc:12428} Deathguard Kel · {area:159} Brill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12428} kneels, half-dead, beside the north gate of {area:159}'s graveyard, a short walk north of the inn. Cast {spell:613} (Rank 2) on him first, then {spell:1243}: Fortitude first does not count, nor does Rank 1 of {spell:613}. If an addon gets in the way, cast both from the spellbook."] = "{npc:12428} est agenouillé, à moitié mort, près de la porte nord du cimetière de {area:159}, à quelques pas au nord de l'auberge. Lancez d'abord {spell:613} (rang 2) sur lui, puis {spell:1243} : Robustesse d'abord ne compte pas, pas plus que le rang 1 de {spell:613}. Si un addon vous gêne, lancez les deux depuis le grimoire.",
	-- {npc:12428} Deathguard Kel
	["Heal and fortify {npc:12428}"] = "Soignez et fortifiez {npc:12428}",

	-- Step 8: Dark Cleric Beryl
	-- {area:159} Brill · {item:16607} Acolyte's Sacrificial Robes
	["Back upstairs in the {area:159} inn: Beryl gives you the {item:16607}."] = "Remontez à l'étage de l'auberge de {area:159} : Beryl vous donne la {item:16607}.",
}
