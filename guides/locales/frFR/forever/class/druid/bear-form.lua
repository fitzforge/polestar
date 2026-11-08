-- French (frFR): the guide forever/class/druid/bear-form (forever/class/druid/bear-form.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["{spell:5487} and {area:493}"] = "{spell:5487} et {area:493}",
	-- {spell:5487} Bear Form · {area:493} Moonglade
	["Your tanking form: Forever no longer trains {spell:5487}, these quests give it. Opens {area:493} too."] = "Votre forme de tank : Forever n'enseigne plus {spell:5487}, ces quêtes la donnent. Elles ouvrent aussi {area:493}.",

	-- Step 1: Heeding the Call
	-- {npc:3602} Kal · {area:186} Dolanaar · {zone:1457} Darnassus · {zone:1453} Stormwind · {npc:4217} Mathrengyl Bearwalker
	["At 10 a druid's call reaches you: {npc:3602} in {area:186}, Denatharion in {zone:1457} or Theridran in {zone:1453}. Any one of them sends you to {npc:4217} in the Cenarion Enclave of Darnassus."] = "Au niveau 10, l'appel d'un druide vous parvient : {npc:3602} à {area:186}, Denatharion à {zone:1457} ou Theridran à {zone:1453}. N'importe lequel vous envoie voir {npc:4217} à l'Enclave cénarienne de Darnassus.",
	-- {npc:3602} Kal · {area:186} Dolanaar
	["{npc:3602}, {area:186}; Denatharion's and Theridran's letters lead to the same place"] = "{npc:3602}, {area:186} ; les lettres de Denatharion et de Theridran mènent au même endroit",

	-- Step 2: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:18960} Teleport: Moonglade
	["{npc:4217} stands upstairs in the druids' building of the {area:1658}. He teaches you {spell:18960} with the quest (it stays in your spellbook, Balance tab)."] = "{npc:4217} se tient à l'étage du bâtiment des druides, dans {area:1658}. Il vous apprend {spell:18960} avec la quête (le sort reste dans votre grimoire, onglet Équilibre).",

	-- Step 3: Mathrengyl Bearwalker
	["or whichever of the three letters you carry"] = "ou celle des trois lettres que vous portez",

	-- Step 4: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:5929} Great Bear Spirit · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs, past the armor vendor. The {quest:5929} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from {area:2361} go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast {spell:18960} again. Learn the {area:493} flight path ({npc:10897}, south of the lake) for later, then take {npc:11800}'s flight from the middle of {area:2361}: she flies druids straight to {area:702}, no flight path needed. Take the portal up to {zone:1457}."] = "Lancez {spell:18960} : vous arrivez à côté du bâtiment où {npc:11802} se tient à l'étage, après le marchand d'armures. {quest:5929} se trouve dans les bois au nord-ouest. Parlez-lui et passez par toutes ses répliques (ce qu'il représente, la force du corps, la force du cœur, puis demandez sa bénédiction) : la conversation est l'objectif, il n'y a pas de combat. Il se fond dans le sol, n'a pas de marque de quête et émet une faible lueur gris-bleu près d'un groupe de trois arbres : depuis {area:2361}, allez vers l'ouest au pied des montagnes du nord, par la trouée entre les arbres et les collines. Si {npc:11802} n'est pas là à votre retour, sortez et lancez de nouveau {spell:18960}. Apprenez le trajet aérien de {area:493} ({npc:10897}, au sud du lac) pour plus tard, puis prenez le vol de {npc:11800} au milieu de {area:2361} : elle emmène les druides directement au {area:702}, pas besoin du trajet aérien. Prenez le portail pour monter à {zone:1457}.",
	-- {quest:5929} Great Bear Spirit
	["Speak with the {quest:5929}"] = "Parler à {quest:5929}",

	-- Step 7: The Moonkin Stone
	-- {object:177525} Moonkin Stone
	["The {object:177525}"] = "{object:177525}",
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {object:177525} Moonkin Stone · {item:15208} Cenarion Moondust · {npc:12144} Lunaclaw Spirit
	["Fly from {area:702} to {area:442}. The {object:177525} stands inside the nearest moonkin cave east of the village: the northern of two small rock-pile caves where the {area:442} road meets the main north-south road. Moonkin (level 11-13) stand outside, the cave is empty: slip past them. Use the {item:15208} by the stone: Lunaclaw (level 12-13) walks in towards you and stays three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Another druid's Lunaclaw gives you the spirit too."] = "Prenez un vol du {area:702} pour {area:442}. La {object:177525} se dresse dans la grotte de séléniens la plus proche à l'est du village : la plus au nord des deux petites grottes en éboulis, là où la route d'{area:442} rejoint la grande route nord-sud. Des séléniens (niveau 11-13) se tiennent dehors, la grotte est vide : faufilez-vous entre eux. Utilisez la {item:15208} près de la pierre : Lunegriffe (niveau 12-13) s'avance vers vous et reste trois minutes. Tuez-la, puis parlez à l'{npc:12144} qui apparaît et demandez la force de son corps et de son cœur : la conversation valide l'objectif. La Lunegriffe d'un autre druide vous donne aussi l'esprit.",

	-- Step 8: Body and Heart
	-- {area:702} Rut'theran Village · {npc:4217} Mathrengyl Bearwalker
	["Fly back to {area:702} and take the portal up to {npc:4217}."] = "Retournez en vol à {area:702} et prenez le portail pour rejoindre {npc:4217}.",

	-- Step 9: Heeding the Call
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village · {npc:6746} Innkeeper Pala · {zone:1456} Thunder Bluff · {npc:6929} Innkeeper Gryshka · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["At 10 a druid's call reaches you: {npc:3064} in {area:222} or {npc:6746} in {zone:1456} ({npc:6929}'s letter in {zone:1454} works too). Any one of them sends you to {npc:3033} on {area:1639} in {zone:1456}."] = "Au niveau 10, l'appel d'un druide vous parvient : {npc:3064} à {area:222} ou {npc:6746} à {zone:1456} (la lettre de {npc:6929} à {zone:1454} fonctionne aussi). N'importe lequel vous envoie voir {npc:3033} sur {area:1639}, à {zone:1456}.",
	-- {npc:3064} Gennia Runetotem · {area:222} Bloodhoof Village
	["{npc:3064}, {area:222}; Pala's and Gryshka's letters lead to the same place"] = "{npc:3064}, {area:222} ; les lettres de Pala et de Gryshka mènent au même endroit",

	-- Step 10: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade
	["{npc:3033} stands in the druids' hut on {area:1639}, over the rope bridges east of the lifts. He teaches you {spell:18960} with the quest (it stays in your spellbook, Balance tab)."] = "{npc:3033} se tient dans la hutte des druides, sur {area:1639}, au-delà des ponts de corde à l'est des ascenseurs. Il vous apprend {spell:18960} avec la quête (le sort reste dans votre grimoire, onglet Équilibre).",

	-- Step 11: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {quest:5930} Great Bear Spirit · {area:2361} Nighthaven · {quest:5922} Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs. The {quest:5930} sits in the woods to the north-west. Speak to it and go through all of its words (what it represents, the strength of the body, the strength of the heart, then ask for its blessing): the talk is the objective, there is no fight. It blends into the ground, has no quest mark and gives off a faint blue-grey glow by a group of three trees: from {area:2361} go west along the foot of the northern mountains, through the gap between the trees and the hills. If {npc:11802} is missing when you return, step outside and cast {spell:18960} again. Learn the {quest:5922} flight path (Faustron, south-west of the lake); {npc:11798} in {area:2361} flies druids to {area:1638}."] = "Lancez {spell:18960} : vous arrivez à côté du bâtiment où {npc:11802} se tient à l'étage. {quest:5930} se trouve dans les bois au nord-ouest. Parlez-lui et passez par toutes ses répliques (ce qu'il représente, la force du corps, la force du cœur, puis demandez sa bénédiction) : la conversation est l'objectif, il n'y a pas de combat. Il se fond dans le sol, n'a pas de marque de quête et émet une faible lueur gris-bleu près d'un groupe de trois arbres : depuis {area:2361}, allez vers l'ouest au pied des montagnes du nord, par la trouée entre les arbres et les collines. Si {npc:11802} n'est pas là à votre retour, sortez et lancez de nouveau {spell:18960}. Apprenez le trajet aérien de {quest:5922} (Faustron, au sud-ouest du lac) ; {npc:11798}, à {area:2361}, emmène les druides à {area:1638}.",
	-- {quest:5930} Great Bear Spirit
	["Speak with the {quest:5930}"] = "Parler à {quest:5930}",

	-- Step 13: The Moonkin Stone
	-- {object:177525} Moonkin Stone · {zone:1413} Barrens · {area:378} Camp Taurajo · {zone:1412} Mulgore · {item:15710} Cenarion Lunardust · {npc:12144} Lunaclaw Spirit
	["The {object:177525} stands in the {zone:1413} just south-west of {area:378}, by the road out of {zone:1412}. Level 20 Thunderheads roam close by: clear the way first. Use the {item:15710} by the stone: Lunaclaw (level 12-13) appears for three minutes. Kill her, then speak to the {npc:12144} that appears and ask for the strength of her body and heart: the talk is the credit. Die in the fight? Lunaclaw stays by the stone: run back and finish her."] = "La {object:177525} se dresse dans {zone:1413}, juste au sud-ouest de {area:378}, au bord de la route qui sort de {zone:1412}. Des Têtes-tonnerre de niveau 20 rôdent tout près : dégagez d'abord le chemin. Utilisez la {item:15710} près de la pierre : Lunegriffe (niveau 12-13) apparaît pendant trois minutes. Tuez-la, puis parlez à l'{npc:12144} qui apparaît et demandez la force de son corps et de son cœur : la conversation valide l'objectif. Mort pendant le combat ? Lunegriffe reste près de la pierre : revenez en courant et achevez-la.",

	-- Step 14: Body and Heart
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Back to {npc:3033} on {area:1639}."] = "Retournez voir {npc:3033} sur {area:1639}.",

	-- Step 15: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Aéronef depuis {area:279}",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:279} Dalaran
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the north side of {area:279}."] = "{spell:5487} s'apprend sur {zone:2521}. Passez cette étape si vous êtes encore sur l'île ; sinon, prenez l'aéronef au nord de {area:279}.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Aéronef vers {zone:2521}",

	-- Step 16: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Aéronef depuis {zone:1456}",
	-- {spell:5487} Bear Form · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff
	["{spell:5487} is taught on {zone:2521}. Skip this if you are still on the isle; otherwise take the skyboat from the cliffs south of {area:17045}, north of {zone:1456}."] = "{spell:5487} s'apprend sur {zone:2521}. Passez cette étape si vous êtes encore sur l'île ; sinon, prenez l'aéronef depuis les falaises au sud de {area:17045}, au nord de {zone:1456}.",

	-- Step 17: Lotheluum Starbreeze
	-- {npc:252359} Lotheluum Starbreeze · {area:16638} Valanaar
	["{npc:252359} stands in {area:16638}."] = "{npc:252359} se tient à {area:16638}.",

	-- Step 18: Urs'endris and Ur'endra
	-- {npc:255853} Urs'endris · {npc:258443} Ur'endra
	["{npc:255853} and {npc:258443}"] = "{npc:255853} et {npc:258443}",
	-- {npc:255853} Urs'endris · {area:16629} Shrine of Akir · {area:16638} Valanaar · {npc:258443} Ur'endra · {area:16623} Shen'dar Highlands · {area:16626} Gustberry Lowlands
	["{npc:255853} waits by the waterfall below the {area:16629}, north-east of {area:16638}. {npc:258443} (the bear you must defeat) lairs in an unmarked cave high on the cliff face west of him, where the {area:16623} meet the {area:16626}: take the path west out of {area:16638} (not north), cross the river on the log bridge and reach the cave from the cliff's upper, northern side. The cave at the foot of the cliffs and the foggy cave are the wrong ones."] = "{npc:255853} attend près de la cascade en contrebas du {area:16629}, au nord-est de {area:16638}. {npc:258443} (l'ours que vous devez vaincre) a son repaire dans une grotte non indiquée, haut sur la falaise à l'ouest de lui, là où {area:16623} rejoignent {area:16626} : prenez le chemin vers l'ouest en sortant de {area:16638} (pas vers le nord), traversez la rivière sur le pont de rondins et atteignez la grotte par le haut de la falaise, côté nord. La grotte au pied des falaises et la grotte dans le brouillard ne sont pas les bonnes.",

	-- Step 19: Strength and Mercy
	-- {npc:255853} Urs'endris
	["Back to {npc:255853} by the falls."] = "Retournez voir {npc:255853} près des chutes.",

	-- Step 20: Child of Nature
	-- {npc:259118} Muln Earthfury · {zone:2521} Zephras Isle · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	["{npc:259118} waits where the airship from {zone:2521} lands, in northern {zone:1412} beside {zone:1456}."] = "{npc:259118} attend là où se pose l'aéronef venu de {zone:2521}, au nord de {zone:1412}, près de {zone:1456}.",

	-- Step 21: Turak Runetotem
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:18960} Teleport: Moonglade
	["{npc:3033} trains druids in the druids' hut on {area:1639}, over the rope bridges east of the lifts. He teaches you {spell:18960} with the next quest (it stays in your spellbook, Balance tab)."] = "{npc:3033} entraîne les druides dans la hutte des druides, sur {area:1639}, au-delà des ponts de corde à l'est des ascenseurs. Il vous apprend {spell:18960} avec la quête suivante (le sort reste dans votre grimoire, onglet Équilibre).",

	-- Step 22: Child of Nature
	-- {npc:270459} Alfina Nightgaze · {npc:259084} Denaaris Stargale · {area:279} Dalaran · {zone:2521} Zephras Isle · {npc:2543} Archmage Ansirem Runeweaver
	["{npc:270459} stands beside {npc:259084} and the Skyborne Portal, west of {area:279}, where the skycutter from {zone:2521} lands. {npc:2543} offers the same quest."] = "{npc:270459} se tient à côté de {npc:259084} et du portail éolide, à l'ouest de {area:279}, là où se pose le fend-ciel venu de {zone:2521}. {npc:2543} propose la même quête.",

	-- Step 23: Sheldras Moontree
	-- {zone:1453} Stormwind · {npc:5504} Sheldras Moontree · {spell:18960} Teleport: Moonglade
	["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer (the arrow points at him); he teaches you {spell:18960} with the next quest (it stays in your spellbook, Balance tab)."] = "Le portail éolide vous mène à {zone:1453}. {npc:5504} est le maître des druides de la ville (la flèche le désigne) ; il vous apprend {spell:18960} avec la quête suivante (le sort reste dans votre grimoire, onglet Équilibre).",

	-- Step 24: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl
	["Cast {spell:18960}: it lands you beside the building where {npc:11802} stands upstairs, in {area:2361}. Learn the {area:493} flight path while you are here (Faustron for the Horde, south-west of the lake; {npc:10897} for the Alliance, south of it)."] = "Lancez {spell:18960} : vous arrivez à côté du bâtiment où {npc:11802} se tient à l'étage, à {area:2361}. Apprenez le trajet aérien de {area:493} tant que vous y êtes (Faustron pour la Horde, au sud-ouest du lac ; {npc:10897} pour l'Alliance, au sud).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}. Learn the {area:493} flight path while you are here."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}. Apprenez le trajet aérien de {area:493} pendant que vous y êtes.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5929} sits in the woods to the north-west. Learn the {area:493} flight path, then fly to {area:702} (by way of {area:442}) and take the portal up to {zone:1457}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361} ; {quest:5929} se trouve dans les bois au nord-ouest. Apprenez le trajet aérien de {area:493}, puis volez jusqu'à {area:702} (en passant par {area:442}) et prenez le portail pour monter à {zone:1457}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; the {quest:5930} sits in the woods to the north-west. {npc:11798} in {area:2361} flies druids to {area:1638}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361} ; {quest:5930} se trouve dans les bois au nord-ouest. {npc:11798}, à {area:2361}, transporte les druides jusqu'à {area:1638}.",
	-- ["Fly from {area:702} to {area:442}. The {object:177525} stands in the hills just east of the village: use the {item:15208} there, defeat Lunaclaw and speak to the {npc:12144}."] = "Volez de {area:702} à {area:442}. {object:177525} se dresse dans les collines juste à l'est du village : utilisez-y {item:15208}, vainquez Lunegriffe et parlez à {npc:12144}.",
	-- ["The Skyborne Portal takes you to {zone:1453}. {npc:5504} is the city's druid trainer."] = "Le portail éolide vous mène à {zone:1453}. {npc:5504} est le maître des druides de la ville.",
	-- ["The {object:177525} stands in the pass from {zone:1412} into the {zone:1413}. Use the {item:15710} there, defeat Lunaclaw and speak to the {npc:12144}."] = "{object:177525} se dresse dans le col entre {zone:1412} et {zone:1413}. Utilisez-y {item:15710}, vainquez Lunegriffe et parlez à {npc:12144}.",
	-- ["{npc:255853} waits by the falls north-east of {area:16638}. {npc:258443} prowls the {area:16623}, west of {area:16638}."] = "{npc:255853} attend près des chutes au nord-est de {area:16638}. {npc:258443} rôde dans {area:16623}, à l'ouest de {area:16638}.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} se tient sur {area:1639}.",
	-- ["{npc:3033} trains druids on {area:1639}."] = "{npc:3033} forme les druides sur {area:1639}.",
	-- ["{npc:4217} stands in the {area:1658}."] = "{npc:4217} se tient dans {area:1658}.",
}
