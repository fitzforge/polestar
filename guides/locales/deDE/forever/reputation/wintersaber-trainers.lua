-- German (deDE): the guide forever/reputation/wintersaber-trainers (forever/reputation/wintersaber-trainers.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Wintersaber Trainers Reputation"] = "Ruf: Wintersäblerausbilder",
	-- {spell:17229} Winterspring Frostsaber · {zone:1452} Winterspring
	["The {spell:17229}: 840 quest turn-ins in {zone:1452}, with Timbermaw reputation on the side."] = "Der {spell:17229}: 840 Quest-Abgaben in {zone:1452}, nebenbei Ruf bei den Holzschlunds.",
	-- {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {quest:5201} Winterfall Intrusion
	["{area:1769} reputation on the side: 50 and about 4 {item:21383} per {quest:5201}"] = "Ruf bei {area:1769} nebenbei: 50 und etwa 4 {item:21383} pro {quest:5201}",

	-- Step 1: Rivern Frostwind
	-- {npc:10618} Rivern Frostwind · {area:2241} Frostsaber Rock · {zone:1452} Winterspring · {faction:589} Wintersaber Trainers · {quest:4970} Frostsaber Provisions
	["{npc:10618} stands on top of {area:2241}, in the far north of {zone:1452}; the path winds up from the east side. Only the Alliance can earn the {faction:589}' favour, from Neutral, at level 58. All three of her quests pay 50 and repeat as often as you like: 840 turn-ins from Neutral to Exalted. The first one, {quest:4970}, is the only one open at the start."] = "{npc:10618} steht auf der Spitze von {area:2241}, im äußersten Norden von {zone:1452}; der Pfad windet sich von der Ostseite hinauf. Nur die Allianz kann sich die Gunst der {faction:589} verdienen, ab Neutral, auf Stufe 58. Alle drei ihrer Quests zahlen 50 und lassen sich beliebig oft wiederholen: 840 Abgaben von Neutral bis Ehrfürchtig. Die erste, {quest:4970}, ist zu Beginn die einzige, die offen ist.",

	-- Step 2: Shardtooth and Chillwind meat
	["Shardtooth and Chillwind meat"] = "Shardtooth- und Chillwind-Fleisch",
	-- {npc:7445} Elder Shardtooth · {area:2255} Everlook · {npc:7446} Rabid Shardtooth
	-- plural, as words: Chillwind Ravagers = {npc:7449} Chillwind Ravager · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera · Shardtooth Bears = {npc:7444} Shardtooth Bear
	["The meat only drops while the quest is in your log, and a group shares no loot: farm it alone. The best droppers live right below the rock: {npc:7445} bears (about half the time) and Chillwind Ravagers (half the time) roam the snowfields east and south-east of it. Around {area:2255} the Chillwind Chimaeras drop it as often and the Shardtooth Bears a little less; the {npc:7446} by the giants' gorge in the south drop it most often (six in ten)."] = "Das Fleisch fällt nur, solange die Quest in deinem Questlog ist, und eine Gruppe teilt keine Beute: Farme es allein. Die besten Quellen leben direkt unterhalb des Felsens: {npc:7445}-Bären (etwa jedes zweite Mal) und Chillwind Ravagers (jedes zweite Mal) streifen über die Schneefelder östlich und südöstlich davon. Rund um {area:2255} lassen die Chillwind Chimaeras es genauso oft fallen und die Shardtooth Bears etwas seltener; die {npc:7446} an der Riesenschlucht im Süden lassen es am häufigsten fallen (sechs von zehn).",
	-- {item:12622} Shardtooth Meat
	["{item:12622}: the bears"] = "{item:12622}: die Bären",
	-- {item:12623} Chillwind Meat
	["{item:12623}: the chimaeras"] = "{item:12623}: die Schimären",

	-- Step 3: Back to Rivern Frostwind
	-- {npc:10618} Rivern Frostwind
	["Back to {npc:10618}"] = "Zurück zu {npc:10618}",

	-- Step 4: Neutral to Friendly: Frostsaber Provisions, then Winterfall Intrusion
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion
	["Neutral to Friendly: {quest:4970}, then {quest:5201}"] = "Neutral bis Freundlich: {quest:4970}, dann {quest:5201}",
	-- {quest:4970} Frostsaber Provisions · {quest:5201} Winterfall Intrusion · {area:2244} Winterfall Village · {area:2255} Everlook
	-- plural, as words: Winterfall Shamans = {npc:7439} Winterfall Shaman · Winterfall Ursas = {npc:7438} Winterfall Ursa
	["Repeat {quest:4970}: 30 turn-ins reach Neutral 1,500, and then {quest:5201} opens: 5 Winterfall Shamans and 5 Winterfall Ursas in {area:2244}, just east of {area:2255}. The village has only a few Shamans, but every furbolg there shares their spawn points: kill all of them, not just the ones you need, and more Shamans and Ursas appear; more Ursas walk the ridge just south-west of the village. Take both quests on every trip: kill the furbolgs, pick up meat on the way back. Neutral to Friendly is 60 turn-ins."] = "Wiederhole {quest:4970}: 30 Abgaben bringen dich auf Neutral 1.500, dann öffnet sich {quest:5201}: 5 Winterquell-Schamanen und 5 Winterquell-Ursas in {area:2244}, gleich östlich von {area:2255}. Im Dorf gibt es nur wenige Schamanen, aber jeder Furbolg dort teilt ihre Spawnpunkte: Töte alle, nicht nur die, die du brauchst, und es erscheinen mehr Schamanen und Ursas; weitere Ursas laufen auf dem Kamm südwestlich des Dorfes. Nimm bei jedem Ausflug beide Quests an: Töte die Furbolgs, sammle auf dem Rückweg Fleisch ein. Von Neutral bis Freundlich sind es 60 Abgaben.",

	-- Step 5: Friendly to Honored
	["Friendly to Honored"] = "Freundlich bis Wohlwollend",
	-- {quest:5201} Winterfall Intrusion · {quest:4970} Frostsaber Provisions · {area:1769} Timbermaw Hold · {item:21383} Winterfall Spirit Beads · {faction:589} Wintersaber Trainers
	["Friendly to Honored is 6,000: 120 turn-ins. {quest:5201} is the quickest; do {quest:4970} when the village is crowded or you pass the bears and chimaeras anyway. Every Winterfall furbolg you kill counts for {area:1769} too: 50 Timbermaw reputation per {quest:5201} up to the end of Honored with them, and about four {item:21383}. Take Salfa's Winterfall Activity (the Timbermaw guide) the first time you are in the village, and keep the beads until your Timbermaw kills stop counting: then each 5 pay 50. You will reach Exalted with the Timbermaw long before the {faction:589}."] = "Von Freundlich bis Wohlwollend sind es 6.000: 120 Abgaben. {quest:5201} ist die schnellste; mache {quest:4970}, wenn das Dorf überfüllt ist oder du ohnehin an den Bären und Schimären vorbeikommst. Jeder Winterquell-Furbolg, den du tötest, zählt auch für {area:1769}: 50 Ruf bei den Holzschlunds pro {quest:5201} bis zum Ende von Wohlwollend bei ihnen, und etwa vier {item:21383}. Nimm beim ersten Mal im Dorf Salfa's Winterfall Activity (der Holzschlund-Guide) an und behalte die Perlen, bis deine Holzschlund-Kills nicht mehr zählen: Dann zahlen je 5 jeweils 50. Du erreichst Ehrfürchtig bei den Holzschlunds lange vor den {faction:589}.",

	-- Step 6: Honored to Exalted: Rampaging Giants too
	-- {quest:5981} Rampaging Giants
	["Honored to Exalted: {quest:5981} too"] = "Wohlwollend bis Ehrfürchtig: auch {quest:5981}",
	-- {quest:5981} Rampaging Giants · {area:2249} Frostwhisper Gorge · {zone:1452} Winterspring · {area:2244} Winterfall Village · {npc:7446} Rabid Shardtooth · {item:12622} Shardtooth Meat
	-- plural, as words: Frostmaul Giants = {npc:7428} Frostmaul Giant · Frostmaul Preservers = {npc:7429} Frostmaul Preserver
	["At Honored Rivern Frostwind adds {quest:5981}: 4 Frostmaul Giants and 4 Frostmaul Preservers, elite giants in {area:2249} in the south-east of {zone:1452}; the path down into the gorge starts at its north-west end. Take it on a trip south with a friend or two, or when {area:2244} is crowded; the {npc:7446} by the gorge drop {item:12622} most often. Honored to Exalted is 33,000: 660 turn-ins."] = "Bei Wohlwollend fügt Rivern Frostwind {quest:5981} hinzu: 4 Frostmaul Giants und 4 Frostmaul Preservers, Elite-Riesen in {area:2249} im Südosten von {zone:1452}; der Pfad in die Schlucht beginnt an deren Nordwestende. Mach sie auf einem Ausflug nach Süden mit einem oder zwei Freunden oder wenn {area:2244} überfüllt ist; die {npc:7446} an der Schlucht lassen {item:12622} am häufigsten fallen. Von Wohlwollend bis Ehrfürchtig sind es 33.000: 660 Abgaben.",
	-- {npc:7428} Frostmaul Giant
	["{npc:7428}, elite"] = "{npc:7428}, Elite",
	-- {npc:7429} Frostmaul Preserver
	["{npc:7429}, elite"] = "{npc:7429}, Elite",
}
