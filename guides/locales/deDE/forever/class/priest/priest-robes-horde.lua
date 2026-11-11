-- German (deDE): the guide forever/class/priest/priest-robes-horde (forever/class/priest/priest-robes-horde.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Horde)"] = "Priestergewänder mit 5 (Horde)",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "Ein kostenloses ungewöhnliches Gewand mit 5: Heile und stärke eine verwundete Wache in der Nähe deiner ersten Stadt.",

	-- Step 1: In Favor of Spirituality
	-- {npc:3707} Ken'jai · {area:363} Valley of Trials · {npc:3706} Tai'jin · {area:362} Razor Hill · {spell:613} Lesser Heal
	["At 5, {npc:3707}, the priest trainer in the Den in the middle of the {area:363}, sends you to {npc:3706} in {area:362}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Mit 5 schickt dich {npc:3707}, der Priesterlehrer in der Höhle mitten im {area:363}, zu {npc:3706} in {area:362}. Lerne bei ihm {spell:613} (Rang 2), solange du hier bist: Der Rang ist ab Stufe 4 für 1 Silber erhältlich, und die nächste Quest braucht genau diesen Rang.",

	-- Step 2: Tai'jin
	-- {area:363} Valley of Trials · {area:362} Razor Hill · {npc:3706} Tai'jin
	["Follow the road out of the {area:363} north-east to {area:362}. {npc:3706} is inside the barracks, the first building on the right as you come into town."] = "Folge der Straße aus dem {area:363} nach Nordosten nach {area:362}. {npc:3706} ist in der Kaserne, dem ersten Gebäude rechts, wenn du in die Stadt kommst.",
	-- {spell:613} Lesser Heal · {npc:3707} Ken'jai
	["{spell:613} (Rank 2), if {npc:3707} did not teach it yet"] = "{spell:613} (Rang 2), falls {npc:3707} ihn dir noch nicht beigebracht hat",

	-- Step 3: Grunt Kor'ja
	-- {npc:12430} Grunt Kor'ja · {area:362} Razor Hill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12430} kneels behind a group of rocks just off the road, a short walk south of {area:362}. Cast {spell:613} (Rank 2) on her first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook. She leaves once both land and is back in about 5 minutes."] = "{npc:12430} kniet hinter einer Felsgruppe direkt an der Straße, ein kurzes Stück südlich von {area:362}. Wirke zuerst {spell:613} (Rang 2) auf sie, dann {spell:1243}. Rang 1 von {spell:613} zählt nicht; zieh Rang 2 aus dem Zauberbuch auf deine Leiste. Sie geht weg, sobald beide wirken, und ist nach etwa 5 Minuten zurück.",
	-- {npc:12430} Grunt Kor'ja
	["Heal and fortify {npc:12430}"] = "Heile und stärke {npc:12430}",

	-- Step 4: Tai'jin
	-- {area:362} Razor Hill · {npc:3706} Tai'jin · {item:16606} Juju Hex Robes
	["Back in the {area:362} barracks: {npc:3706} gives you the {item:16606}."] = "Zurück in der Kaserne von {area:362}: {npc:3706} gibt dir {item:16606}.",

	-- Step 5: In Favor of Darkness
	-- {npc:2123} Dark Cleric Duesten · {area:154} Deathknell · {npc:2129} Dark Cleric Beryl · {area:159} Brill · {spell:613} Lesser Heal
	["At 5, {npc:2123}, the priest trainer in the chapel of {area:154}, sends you to {npc:2129} in {area:159}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Mit 5 schickt dich {npc:2123}, der Priesterlehrer in der Kapelle von {area:154}, zu {npc:2129} in {area:159}. Lerne bei ihm {spell:613} (Rang 2), solange du hier bist: Der Rang ist ab Stufe 4 für 1 Silber erhältlich, und die nächste Quest braucht genau diesen Rang.",

	-- Step 6: Dark Cleric Beryl
	-- {area:154} Deathknell · {area:159} Brill · {npc:2129} Dark Cleric Beryl · {area:2119} Gallows' End Tavern
	["Follow the road east out of {area:154} to {area:159}. {npc:2129} is upstairs in the inn, {area:2119}."] = "Folge der Straße nach Osten aus {area:154} nach {area:159}. {npc:2129} ist oben im Gasthaus, {area:2119}.",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Duesten did not teach it yet"] = "{spell:613} (Rang 2), falls Duesten ihn dir noch nicht beigebracht hat",

	-- Step 7: Deathguard Kel
	-- {npc:12428} Deathguard Kel · {area:159} Brill · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12428} kneels, half-dead, beside the north gate of {area:159}'s graveyard, a short walk north of the inn. Cast {spell:613} (Rank 2) on him first, then {spell:1243}: Fortitude first does not count, nor does Rank 1 of {spell:613}. If an addon gets in the way, cast both from the spellbook."] = "{npc:12428} kniet halbtot neben dem Nordtor des Friedhofs von {area:159}, ein kurzes Stück nördlich des Gasthauses. Wirke zuerst {spell:613} (Rang 2) auf ihn, dann {spell:1243}: Zuerst Seelenstärke zählt nicht, ebenso wenig Rang 1 von {spell:613}. Wenn ein Addon stört, wirke beide aus dem Zauberbuch.",
	-- {npc:12428} Deathguard Kel
	["Heal and fortify {npc:12428}"] = "Heile und stärke {npc:12428}",

	-- Step 8: Dark Cleric Beryl
	-- {area:159} Brill · {item:16607} Acolyte's Sacrificial Robes
	["Back upstairs in the {area:159} inn: Beryl gives you the {item:16607}."] = "Zurück oben im Gasthaus von {area:159}: Beryl gibt dir {item:16607}.",
}
