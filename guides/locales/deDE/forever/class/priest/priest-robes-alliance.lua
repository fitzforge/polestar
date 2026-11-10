-- German (deDE): the guide forever/class/priest/priest-robes-alliance (forever/class/priest/priest-robes-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Alliance)"] = "Priestergewänder mit 5 (Allianz)",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "Ein kostenloses ungewöhnliches Gewand mit 5: Heile und stärke eine verwundete Wache in der Nähe deiner ersten Stadt.",

	-- Step 1: In Favor of the Light
	-- {npc:375} Priestess Anetta · {area:24} Northshire Abbey · {npc:377} Priestess Josetta · {area:87} Goldshire · {spell:613} Lesser Heal
	["At 5, {npc:375}, the priest trainer inside {area:24}, sends you to {npc:377} in {area:87}. Train {spell:613} (Rank 2) from Anetta while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Mit 5 schickt dich {npc:375}, die Priesterlehrerin in {area:24}, zu {npc:377} in {area:87}. Lerne bei Anetta {spell:613} (Rang 2), solange du hier bist: Der Rang ist ab Stufe 4 für 1 Silber erhältlich, und die nächste Quest braucht genau diesen Rang.",

	-- Step 2: Priestess Josetta
	-- {area:9} Northshire Valley · {area:87} Goldshire · {npc:377} Priestess Josetta
	["Follow the road south out of {area:9} to {area:87}. {npc:377} is upstairs in the Lion's Pride Inn."] = "Folge der Straße nach Süden aus {area:9} nach {area:87}. {npc:377} ist oben im Lion's Pride Inn.",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Anetta did not teach it yet"] = "{spell:613} (Rang 2), falls Anetta ihn dir noch nicht beigebracht hat",

	-- Step 3: Guard Roberts
	-- {npc:12423} Guard Roberts · {area:87} Goldshire · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12423} kneels by a tree on the lake shore east of {area:87}, off the road: walk along the shore, the minimap misses him from the road. Cast {spell:613} (Rank 2) on him first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook (or cast both from the spellbook if an action bar addon gets in the way). He walks off once both land and is back in about 3 minutes."] = "{npc:12423} kniet an einem Baum am Seeufer östlich von {area:87}, abseits der Straße: Geh am Ufer entlang, die Minikarte zeigt ihn von der Straße aus nicht. Wirke zuerst {spell:613} (Rang 2) auf ihn, dann {spell:1243}. Rang 1 von {spell:613} zählt nicht; zieh Rang 2 aus dem Zauberbuch auf deine Leiste (oder wirke beide aus dem Zauberbuch, falls ein Aktionsleisten-Addon stört). Er geht weg, sobald beide wirken, und ist nach etwa 3 Minuten zurück.",
	-- {npc:12423} Guard Roberts
	["Heal and fortify {npc:12423}"] = "Heile und stärke {npc:12423}",

	-- Step 4: Priestess Josetta
	-- {item:16605} Friar's Robes of the Light
	["Back upstairs in the Lion's Pride Inn: Josetta gives you {item:16605}."] = "Zurück nach oben im Lion's Pride Inn: Josetta gibt dir {item:16605}.",

	-- Step 5: In Favor of the Light
	-- {npc:837} Branstock Khalder · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:1226} Maxan Anvol · {area:131} Kharanos · {spell:613} Lesser Heal
	["At 5, {npc:837}, the priest trainer inside {area:77} in {area:132}, sends you to {npc:1226} in {area:131}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Mit 5 schickt dich {npc:837}, der Priesterlehrer in {area:77} in {area:132}, zu {npc:1226} in {area:131}. Lerne bei ihm {spell:613} (Rang 2), solange du hier bist: Der Rang ist ab Stufe 4 für 1 Silber erhältlich, und die nächste Quest braucht genau diesen Rang.",

	-- Step 6: Maxan Anvol
	-- {area:132} Coldridge Valley · {area:131} Kharanos · {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery
	["Take the tunnel north-east out of {area:132} and follow the road east to {area:131}. {npc:1226} is inside the {area:2102}."] = "Nimm den Tunnel nach Nordosten aus {area:132} und folge der Straße nach Osten nach {area:131}. {npc:1226} ist in der {area:2102}.",
	-- {spell:613} Lesser Heal · {npc:837} Branstock Khalder
	["{spell:613} (Rank 2), if {npc:837} did not teach it yet"] = "{spell:613} (Rang 2), falls {npc:837} ihn dir noch nicht beigebracht hat",

	-- Step 7: Mountaineer Dolf
	-- {npc:12427} Mountaineer Dolf · {area:131} Kharanos · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12427} kneels on a ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer: if the road starts going downhill, you have passed him. Cast {spell:613} (Rank 2) on him first, then {spell:1243}; he speaks after each spell. Rank 1 of {spell:613} does not count."] = "{npc:12427} kniet auf einem Kamm zwischen zwei niedrigen Mauern, südlich von {area:131}, gegenüber dem Lehrer für Jägerbegleiter auf der anderen Straßenseite: Wenn die Straße bergab zu führen beginnt, bist du an ihm vorbei. Wirke zuerst {spell:613} (Rang 2) auf ihn, dann {spell:1243}; er spricht nach jedem Zauber. Rang 1 von {spell:613} zählt nicht.",
	-- {npc:12427} Mountaineer Dolf
	["Heal and fortify {npc:12427}"] = "Heile und stärke {npc:12427}",

	-- Step 8: Maxan Anvol
	-- {area:2102} Thunderbrew Distillery · {npc:1226} Maxan Anvol · {item:16605} Friar's Robes of the Light
	["Back inside the {area:2102}: {npc:1226} gives you {item:16605}."] = "Zurück in der {area:2102}: {npc:1226} gibt dir {item:16605}.",

	-- Step 9: In Favor of Elune
	-- {npc:3595} Shanda · {area:256} Aldrassil · {area:188} Shadowglen · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {spell:613} Lesser Heal
	["At 5, {npc:3595}, the priest trainer on the second level of {area:256}, the great tree in {area:188}, sends you to {npc:3600} in {area:186}. Train {spell:613} (Rank 2) from her while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "Mit 5 schickt dich {npc:3595}, die Priesterlehrerin auf der zweiten Ebene von {area:256}, dem großen Baum in {area:188}, zu {npc:3600} in {area:186}. Lerne bei ihr {spell:613} (Rang 2), solange du hier bist: Der Rang ist ab Stufe 4 für 1 Silber erhältlich, und die nächste Quest braucht genau diesen Rang.",

	-- Step 10: Laurna Morninglight
	-- {area:188} Shadowglen · {area:186} Dolanaar · {npc:3600} Laurna Morninglight
	["Leave {area:188} by the ramp and follow the road south-west to {area:186}. {npc:3600} is in the building at the north edge of the village."] = "Verlasse {area:188} über die Rampe und folge der Straße nach Südwesten nach {area:186}. {npc:3600} ist im Gebäude am Nordrand des Dorfes.",
	-- {spell:613} Lesser Heal · {npc:3595} Shanda
	["{spell:613} (Rank 2), if {npc:3595} did not teach it yet"] = "{spell:613} (Rang 2), falls {npc:3595} ihn dir noch nicht beigebracht hat",

	-- Step 11: Sentinel Shaya
	-- {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth · {area:186} Dolanaar · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12429} kneels on the rocks at the edge of {area:259}, about 100 yards south of {area:186}, with no quest mark over her. Cast {spell:613} (Rank 2) on her first, then {spell:1243}; she runs off toward the lake once both land and is back in about 5 minutes. Rank 1 of {spell:613} does not count."] = "{npc:12429} kniet auf den Felsen am Rand von {area:259}, etwa 100 Yards südlich von {area:186}, ohne Questzeichen über sich. Wirke zuerst {spell:613} (Rang 2) auf sie, dann {spell:1243}; sie rennt in Richtung See davon, sobald beide wirken, und ist nach etwa 5 Minuten zurück. Rang 1 von {spell:613} zählt nicht.",
	-- {npc:12429} Sentinel Shaya
	["Heal and fortify {npc:12429}"] = "Heile und stärke {npc:12429}",

	-- Step 12: Laurna Morninglight
	-- {area:186} Dolanaar · {npc:3600} Laurna Morninglight · {item:16604} Moon Robes of Elune
	["Back at the north edge of {area:186}: {npc:3600} gives you the {item:16604}."] = "Zurück am Nordrand von {area:186}: {npc:3600} gibt dir {item:16604}.",
}
