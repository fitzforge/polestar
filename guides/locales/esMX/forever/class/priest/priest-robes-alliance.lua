-- Spanish (Latin America) (esMX): the guide forever/class/priest/priest-robes-alliance (forever/class/priest/priest-robes-alliance.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Priest Robes at 5 (Alliance)"] = "Túnicas de sacerdote a nivel 5 (Alianza)",
	["A free uncommon robe at 5: heal and fortify a wounded guard near your first town."] = "Una túnica poco común gratis a nivel 5: cura y fortalece a un guardia herido cerca de tu primer pueblo.",

	-- Step 1: In Favor of the Light
	-- {npc:375} Priestess Anetta · {area:24} Northshire Abbey · {npc:377} Priestess Josetta · {area:87} Goldshire · {spell:613} Lesser Heal
	["At 5, {npc:375}, the priest trainer inside {area:24}, sends you to {npc:377} in {area:87}. Train {spell:613} (Rank 2) from Anetta while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "A nivel 5, {npc:375}, la instructora de sacerdotes dentro de {area:24}, te manda con {npc:377} en {area:87}. Entrena {spell:613} (rango 2) con Anetta mientras estás aquí: se abre a nivel 4 por 1 de plata, y la siguiente misión necesita justo ese rango.",

	-- Step 2: Priestess Josetta
	-- {area:9} Northshire Valley · {area:87} Goldshire · {npc:377} Priestess Josetta
	["Follow the road south out of {area:9} to {area:87}. {npc:377} is upstairs in the Lion's Pride Inn."] = "Sigue el camino al sur desde {area:9} hasta {area:87}. {npc:377} está en el piso de arriba de la Posada Orgullo de León.",
	-- {spell:613} Lesser Heal
	["{spell:613} (Rank 2), if Anetta did not teach it yet"] = "{spell:613} (rango 2), si Anetta todavía no te lo enseñó",

	-- Step 3: Guard Roberts
	-- {npc:12423} Guard Roberts · {area:87} Goldshire · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12423} kneels by a tree on the lake shore east of {area:87}, off the road: walk along the shore, the minimap misses him from the road. Cast {spell:613} (Rank 2) on him first, then {spell:1243}. Rank 1 of {spell:613} does not count; drag Rank 2 onto your bar from the spellbook (or cast both from the spellbook if an action bar addon gets in the way). He walks off once both land and is back in about 3 minutes."] = "{npc:12423} está arrodillado junto a un árbol en la orilla del lago al este de {area:87}, fuera del camino: ve por la orilla, desde el camino el minimapa no lo muestra. Lanza primero {spell:613} (rango 2) sobre él y luego {spell:1243}. El rango 1 de {spell:613} no cuenta; arrastra el rango 2 a tu barra desde el libro de hechizos (o lanza los dos desde el libro si un addon de barras te molesta). Se va cuando recibe los dos y vuelve en unos 3 minutos.",
	-- {npc:12423} Guard Roberts
	["Heal and fortify {npc:12423}"] = "Sana y fortalece a {npc:12423}",

	-- Step 4: Priestess Josetta
	-- {item:16605} Friar's Robes of the Light
	["Back upstairs in the Lion's Pride Inn: Josetta gives you {item:16605}."] = "De vuelta arriba en la Posada Orgullo de León: Josetta te da {item:16605}.",

	-- Step 5: In Favor of the Light
	-- {npc:837} Branstock Khalder · {area:77} Anvilmar · {area:132} Coldridge Valley · {npc:1226} Maxan Anvol · {area:131} Kharanos · {spell:613} Lesser Heal
	["At 5, {npc:837}, the priest trainer inside {area:77} in {area:132}, sends you to {npc:1226} in {area:131}. Train {spell:613} (Rank 2) from him while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "A nivel 5, {npc:837}, el instructor de sacerdotes dentro de {area:77} en {area:132}, te manda con {npc:1226} en {area:131}. Entrena {spell:613} (rango 2) con él mientras estás aquí: se abre a nivel 4 por 1 de plata, y la siguiente misión necesita justo ese rango.",

	-- Step 6: Maxan Anvol
	-- {area:132} Coldridge Valley · {area:131} Kharanos · {npc:1226} Maxan Anvol · {area:2102} Thunderbrew Distillery
	["Take the tunnel north-east out of {area:132} and follow the road east to {area:131}. {npc:1226} is inside the {area:2102}."] = "Toma el túnel al noreste para salir de {area:132} y sigue el camino al este hasta {area:131}. {npc:1226} está dentro de {area:2102}.",
	-- {spell:613} Lesser Heal · {npc:837} Branstock Khalder
	["{spell:613} (Rank 2), if {npc:837} did not teach it yet"] = "{spell:613} (rango 2), si {npc:837} todavía no te lo enseñó",

	-- Step 7: Mountaineer Dolf
	-- {npc:12427} Mountaineer Dolf · {area:131} Kharanos · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12427} kneels on a ridge between two low walls just south of {area:131}, across the road from the hunter pet trainer: if the road starts going downhill, you have passed him. Cast {spell:613} (Rank 2) on him first, then {spell:1243}; he speaks after each spell. Rank 1 of {spell:613} does not count."] = "{npc:12427} está arrodillado en una loma entre dos muros bajos, justo al sur de {area:131}, al otro lado del camino del instructor de mascotas de cazador: si el camino empieza a bajar, ya lo pasaste. Lanza primero {spell:613} (rango 2) sobre él y luego {spell:1243}; habla después de cada hechizo. El rango 1 de {spell:613} no cuenta.",
	-- {npc:12427} Mountaineer Dolf
	["Heal and fortify {npc:12427}"] = "Sana y fortalece a {npc:12427}",

	-- Step 8: Maxan Anvol
	-- {area:2102} Thunderbrew Distillery · {npc:1226} Maxan Anvol · {item:16605} Friar's Robes of the Light
	["Back inside the {area:2102}: {npc:1226} gives you {item:16605}."] = "De vuelta dentro de {area:2102}: {npc:1226} te da {item:16605}.",

	-- Step 9: In Favor of Elune
	-- {npc:3595} Shanda · {area:256} Aldrassil · {area:188} Shadowglen · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {spell:613} Lesser Heal
	["At 5, {npc:3595}, the priest trainer on the second level of {area:256}, the great tree in {area:188}, sends you to {npc:3600} in {area:186}. Train {spell:613} (Rank 2) from her while you are here: it opens at level 4 for 1 silver, and the next quest needs exactly that rank."] = "A nivel 5, {npc:3595}, la instructora de sacerdotes en el segundo nivel de {area:256}, el gran árbol de {area:188}, te manda con {npc:3600} en {area:186}. Entrena {spell:613} (rango 2) con ella mientras estás aquí: se abre a nivel 4 por 1 de plata, y la siguiente misión necesita justo ese rango.",

	-- Step 10: Laurna Morninglight
	-- {area:188} Shadowglen · {area:186} Dolanaar · {npc:3600} Laurna Morninglight
	["Leave {area:188} by the ramp and follow the road south-west to {area:186}. {npc:3600} is in the building at the north edge of the village."] = "Sal de {area:188} por la rampa y sigue el camino al suroeste hasta {area:186}. {npc:3600} está en el edificio del borde norte de la aldea.",
	-- {spell:613} Lesser Heal · {npc:3595} Shanda
	["{spell:613} (Rank 2), if {npc:3595} did not teach it yet"] = "{spell:613} (rango 2), si {npc:3595} todavía no te lo enseñó",

	-- Step 11: Sentinel Shaya
	-- {npc:12429} Sentinel Shaya · {area:259} Lake Al'Ameth · {area:186} Dolanaar · {spell:613} Lesser Heal · {spell:1243} Power Word: Fortitude
	["{npc:12429} kneels on the rocks at the edge of {area:259}, about 100 yards south of {area:186}, with no quest mark over her. Cast {spell:613} (Rank 2) on her first, then {spell:1243}; she runs off toward the lake once both land and is back in about 5 minutes. Rank 1 of {spell:613} does not count."] = "{npc:12429} está arrodillada en las rocas del borde de {area:259}, a unos 100 m al sur de {area:186}, sin marca de misión encima. Lanza primero {spell:613} (rango 2) sobre ella y luego {spell:1243}; corre hacia el lago cuando recibe los dos y vuelve en unos 5 minutos. El rango 1 de {spell:613} no cuenta.",
	-- {npc:12429} Sentinel Shaya
	["Heal and fortify {npc:12429}"] = "Cura y fortalece a {npc:12429}",

	-- Step 12: Laurna Morninglight
	-- {area:186} Dolanaar · {npc:3600} Laurna Morninglight · {item:16604} Moon Robes of Elune
	["Back at the north edge of {area:186}: {npc:3600} gives you the {item:16604}."] = "De vuelta en el borde norte de {area:186}: {npc:3600} te da {item:16604}.",
}
