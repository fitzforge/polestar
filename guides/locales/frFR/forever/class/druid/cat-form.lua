-- French (frFR): the guide forever/class/druid/cat-form (forever/class/druid/cat-form.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:768} Cat Form
	["Your stealth and melee form: in Forever this chain gives {spell:768} at 20, not the trainer."] = "Votre forme de camouflage et de mêlée : dans Forever, cette suite de quêtes donne {spell:768} au niveau 20, pas le maître.",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {npc:11802} Dendrite Starblaze · {area:493} Moonglade
	["{npc:4217} stands in the {area:1658}. Skyborne far from {zone:1457}: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No Aquatic Form yet? Take A Lesson to Learn from him too: it also goes to {npc:11802}, and its Trial of the Lake (the Aquatic Form guide) is in the same {area:493}."] = "{npc:4217} se trouve dans {area:1658}. Éolides loin de {zone:1457} : lancez {spell:18960} et prenez le vol de {npc:11800} au milieu de {area:2361} (elle emmène les druides au {area:702}, pas besoin du trajet aérien), puis le portail pour monter. Pas encore de forme aquatique ? Prenez-lui aussi Une leçon à apprendre : elle mène aussi à {npc:11802}, et son épreuve du lac (le guide de la forme aquatique) se passe dans le même {area:493}.",

	-- Step 3: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Learn the flight path there if you do not have it."] = "",

	-- Step 4: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "Les reliques du Refuge des saisons",
	-- {quest:98394} The Great Cat Spirit · {area:493} Moonglade · {npc:272054} Avatar of Saeyleenan · {area:2361} Nighthaven · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) waits on the hill above the bridge in southern {area:493}; the {npc:272054} (Skyborne) stands on high ground past the twin bridges, south-west of {area:2361}: climb up to it. The relics lie in the {area:2363} east of the lake: leave your form and click the statue at the den's entrance for a short stealth (five minutes), then go deep into the cave and over the bridge. Enraged spirits guard the relics and attack anything they see: stay in the statue's stealth and keep moving. Each relic is a small orb beside a cat statue in an alcove: the Fang and the Claw have one spot each, the Silent Shadow two, and it is the one players camp. A relic shows as unusable while another player loots it: wait a moment and try again. Stealth gone? Walk back to the entrance statue for more."] = "{quest:98394} (Elfes de la nuit) attend sur la colline au-dessus du pont, au sud de {area:493} ; l'{npc:272054} (Éolides) se tient sur les hauteurs après les deux ponts, au sud-ouest de {area:2361} : grimpez jusqu'à lui. Les reliques se trouvent dans les {area:2363}, à l'est du lac : quittez votre forme et cliquez sur la statue à l'entrée des tanières pour un court camouflage (cinq minutes), puis enfoncez-vous dans la grotte et franchissez le pont. Des esprits enragés gardent les reliques et attaquent tout ce qu'ils voient : restez dans le camouflage de la statue et ne vous arrêtez pas. Chaque relique est un petit orbe à côté d'une statue de félin, dans une alcôve : le Croc et la Griffe ont un emplacement chacun, l'Ombre silencieuse deux, et c'est celle que les joueurs attendent. Une relique apparaît comme inutilisable pendant qu'un autre joueur la ramasse : attendez un instant et réessayez. Plus de camouflage ? Retournez à la statue de l'entrée pour en reprendre.",

	-- Step 5: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "Retour auprès de {npc:11802}",
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11800}'s flight to {area:702}: she stands in the middle of {area:2361} and flies druids there, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 6: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:768} Cat Form
	["Take the portal up to {npc:4217}, upstairs in the {area:1658}: he teaches you {spell:768}."] = "Prenez le portail pour monter jusqu'à {npc:4217}, à l'étage de {area:1658} : il vous apprend {spell:768}.",

	-- Step 8: The Great Cat Spirit
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:11802} Dendrite Starblaze · {area:493} Moonglade
	["{npc:3033} stands in the druids' hut on {area:1639}. No Aquatic Form yet? Take A Lesson to Learn from him too: it also goes to {npc:11802}, and its Trial of the Lake (the Aquatic Form guide) is in the same {area:493}."] = "{npc:3033} se tient dans la hutte des druides, sur {area:1639}. Pas encore de forme aquatique ? Prenez-lui aussi Une leçon à apprendre : elle mène aussi à {npc:11802}, et son épreuve du lac (le guide de la forme aquatique) se passe dans le même {area:493}.",

	-- Step 9: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 10: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {quest:98342} The Great Cat Spirit · {area:493} Moonglade · {npc:272054} Avatar of Saeyleenan · {area:2361} Nighthaven · {area:2363} Stormrage Barrow Dens
	["{quest:98342} (Tauren) waits on the hill above the bridge in southern {area:493}; the {npc:272054} (Skyborne) stands on high ground past the twin bridges, south-west of {area:2361}: climb up to it. The relics lie in the {area:2363} east of the lake: leave your form and click the statue at the den's entrance for a short stealth (five minutes), then go deep into the cave and over the bridge. Enraged spirits guard the relics and attack anything they see: stay in the statue's stealth and keep moving. Each relic is a small orb beside a cat statue in an alcove: the Fang and the Claw have one spot each, the Silent Shadow two, and it is the one players camp. A relic shows as unusable while another player loots it: wait a moment and try again. Stealth gone? Walk back to the entrance statue for more."] = "{quest:98342} (Taurens) attend sur la colline au-dessus du pont, au sud de {area:493} ; l'{npc:272054} (Éolides) se tient sur les hauteurs après les deux ponts, au sud-ouest de {area:2361} : grimpez jusqu'à lui. Les reliques se trouvent dans les {area:2363}, à l'est du lac : quittez votre forme et cliquez sur la statue à l'entrée des tanières pour un court camouflage (cinq minutes), puis enfoncez-vous dans la grotte et franchissez le pont. Des esprits enragés gardent les reliques et attaquent tout ce qu'ils voient : restez dans le camouflage de la statue et ne vous arrêtez pas. Chaque relique est un petit orbe à côté d'une statue de félin, dans une alcôve : le Croc et la Griffe ont un emplacement chacun, l'Ombre silencieuse deux, et c'est celle que les joueurs attendent. Une relique apparaît comme inutilisable pendant qu'un autre joueur la ramasse : attendez un instant et réessayez. Plus de camouflage ? Retournez à la statue de l'entrée pour en reprendre.",

	-- Step 11: Back to Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11798}'s flight to {area:1638}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 12: To Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:768} Cat Form
	["{npc:3033} on {area:1639} teaches you {spell:768}."] = "{npc:3033}, sur {area:1639}, vous apprend {spell:768}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:11802} in {area:2361}, then fly to {area:702}."] = "Retournez voir {npc:11802} à {area:2361}, puis prenez un vol pour {area:702}.",
	-- ["Back to {npc:11802} in {area:2361}, then take {npc:11798}'s flight to {area:1638}."] = "Retournez voir {npc:11802} à {area:2361}, puis prenez le vol de {npc:11798} pour {area:1638}.",
	-- ["Cast Teleport: {area:493}. {npc:11802} is in {area:2361}."] = "Lancez Téléportation : {area:493}. {npc:11802} se trouve à {area:2361}.",
	-- ["Cast Teleport: {area:493}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Lancez Téléportation : {area:493}. {npc:11802} se trouve à {area:2361} ; apprenez-y le trajet aérien si vous ne l'avez pas.",
	-- ["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11798}'s flight to {area:1638}."] = "Lancez {spell:18960} pour arriver près de {npc:11802} à {area:2361} (personne sur l'Île de Zéphras ne donne la quête des Éolides), puis prenez le vol de {npc:11798} pour {area:1638}.",
	-- ["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11800}'s flight to {area:702}: she stands in the middle of {area:2361} and flies druids there, no flight path needed."] = "Lancez {spell:18960} pour arriver près de {npc:11802} à {area:2361} (personne sur l'Île de Zéphras ne donne la quête des Éolides), puis prenez le vol de {npc:11800} pour le {area:702} : elle se tient au milieu de {area:2361} et y emmène les druides, pas besoin du trajet aérien.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361}.",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}; learn the flight path there if you do not have it."] = "Lancez {spell:18960}. {npc:11802} est à {area:2361} ; apprenez-y le trajet aérien si vous ne l'avez pas.",
	-- ["Take the portal up to {npc:4217} in the {area:1658}."] = "Prenez le portail pour monter voir {npc:4217} dans {area:1658}.",
	-- ["{npc:3033} stands on {area:1639}."] = "{npc:3033} se trouve sur {area:1639}.",
	-- ["{npc:4217} stands in the {area:1658}. Skyborne without the Rut'theran flight path: take the boat from {area:442}."] = "{npc:4217} se trouve dans {area:1658}. Éolides sans le trajet aérien de Rut'theran : prenez le bateau depuis {area:442}.",
	-- ["{quest:98342} (Tauren) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98342} (Taurens) attend sur la colline sud au-dessus du pont, l'{npc:272054} (Éolides) au sud des ponts jumeaux. Les reliques se trouvent dans {area:2363}, à l'est du lac : quittez votre forme, cliquez sur la statue de l'entrée pour cinq minutes de camouflage, évitez les esprits à l'intérieur et prenez une relique de chaque ; la {item:280680} se trouve au pied de la statue de félin blanc. Une relique ne donne rien pendant qu'un autre joueur la fouille : patientez un instant et réessayez.",
	-- ["{quest:98394} (Night Elves) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394} (Elfes de la nuit) attend sur la colline sud au-dessus du pont, l'{npc:272054} (Éolides) au sud des ponts jumeaux. Les reliques se trouvent dans {area:2363}, à l'est du lac : quittez votre forme, cliquez sur la statue de l'entrée pour cinq minutes de camouflage, évitez les esprits à l'intérieur et prenez une relique de chaque ; la {item:280680} se trouve au pied de la statue de félin blanc. Une relique ne donne rien pendant qu'un autre joueur la fouille : patientez un instant et réessayez.",
}
