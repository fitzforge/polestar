-- German (deDE): the guide forever/class/rogue/poisons-alliance (forever/class/rogue/poisons-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Alliance)"] = "Gifte (Allianz)",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever bringt dir Gifte über diese Questreihe bei, nicht über den Lehrer; das Rezept {item:7676} gehört dazu.",

	-- Step 1: Mathias and the Defias
	-- {npc:332} Master Mathias Shaw · {object:2100} Old Town · {npc:7024} Agent Kearnen · {zone:1436} Westfall
	["At 20 {npc:332}, upstairs in the SI:7 building in {object:2100}, sends you to {npc:7024} in {zone:1436}. This chain is how you learn Poisons on Forever, so do not skip it."] = "Mit 20 schickt dich {npc:332}, oben im SI:7-Gebäude in {object:2100}, zu {npc:7024} in {zone:1436}. Mit dieser Questreihe lernst du in Forever Gifte, überspringe sie also nicht.",

	-- Step 2: Agent Kearnen
	-- {npc:7053} Klaven Mortwake · {zone:1436} Westfall · {zone:1431} Duskwood · {item:8046} Kearnen's Journal
	["Kearnen hides stealthed against the west side of a big tree with two small trees in front of it, just north of {npc:7053}'s Defias tower in the far east of {zone:1436}, by the {zone:1431} border. Read {item:8046} for the tower's layout if you like."] = "Kearnen versteckt sich getarnt an der Westseite eines großen Baums mit zwei kleinen Bäumen davor, nördlich des Defias-Turms von {npc:7053} im äußersten Osten von {zone:1436}, an der Grenze zu {zone:1431}. Lies {item:8046} für den Grundriss des Turms, wenn du magst.",

	-- Step 3: The Defias Tower Key
	-- {item:7923} Defias Tower Key
	["The {item:7923}"] = "{item:7923}",
	-- {npc:7051} Malformed Defias Drone · {spell:921} Pick Pocket · {spell:2983} Sprint
	-- plural, as words: Defias Drones = {npc:7050} Defias Drone
	["Get the key first. The {npc:7051} (level 23, not elite) starts at the tower entrance and walks a loop around the outside; it is the spiky-haired one trailing yellow sparkles. Stealth up and {spell:921} it from behind: it always has the key. It hits hard: if stealth breaks, {spell:2983} away. Watch for the pair of Defias Drones that also patrol."] = "Hol zuerst den Schlüssel. Die {npc:7051} (Stufe 23, nicht Elite) beginnt am Turmeingang und läuft eine Runde außen herum; sie ist die mit den stacheligen Haaren, die gelbe Funken hinter sich herzieht. Schleiche dich heran und wende {spell:921} von hinten an: Sie hat den Schlüssel immer. Sie schlägt hart zu: Wenn die Tarnung bricht, verschwinde mit {spell:2983}. Achte auf das Paar Defias Drones, das ebenfalls patrouilliert.",
	-- {spell:921} Pick Pocket · {npc:7051} Malformed Defias Drone · {item:7923} Defias Tower Key
	["{spell:921} the {npc:7051} for the {item:7923}"] = "{spell:921} bei der {npc:7051} für {item:7923}",

	-- Step 4: Klaven's journal
	["Klaven's journal"] = "Klavens Tagebuch",
	-- {npc:7053} Klaven Mortwake · {object:123214} Duskwood Chest · {area:97} Alther's Mill · {spell:9810} Touch of Zanzil
	-- plural, as words: Defias Tower Patrollers = {npc:7052} Defias Tower Patroller
	["Sneak up the tower. Defias Tower Patrollers (23) and Sentries (24) guard the floors; an Ambush with a dagger kills them outright if you would rather clear them. {npc:7053}, a level 26 elite, waits on the top floor: Sap him, or bring a friend. The {object:123214} beside his desk needs Lockpicking of about 70-75 (practise on the boxes at {area:97} in Redridge first). A trick: while the Sentries are away, jump from the chair to the lamp to the bookshelf above the chest, step out of stealth and open the chest from there. Opening it poisons you with the {spell:9810}, which stops your stealth for a while and lets the drone see you; that is why the key comes first. Then get out."] = "Schleiche den Turm hinauf. Defias Tower Patrollers (23) und Sentries (24) bewachen die Stockwerke; ein Hinterhalt mit einem Dolch tötet sie sofort, wenn du sie lieber ausschalten willst. {npc:7053}, ein Elite der Stufe 26, wartet im obersten Stockwerk: Setz ihn mit Kopfnuss außer Gefecht oder bring einen Freund mit. Die {object:123214} neben seinem Schreibtisch braucht Schlossknacken von etwa 70-75 (übe vorher an den Kisten bei {area:97} in Redridge). Ein Trick: Springe, während die Sentries weg sind, vom Stuhl auf die Lampe und auf das Bücherregal über der Truhe, tritt aus der Tarnung und öffne die Truhe von dort. Das Öffnen vergiftet dich mit {spell:9810}, was deine Tarnung eine Weile beendet und die Drohne dich sehen lässt; deshalb kommt der Schlüssel zuerst. Dann nichts wie raus.",
	-- {item:7908} Klaven Mortwake's Journal · {object:123214} Duskwood Chest
	["{item:7908}: the {object:123214}, top floor"] = "{item:7908}: {object:123214}, oberstes Stockwerk",

	-- Step 5: Master Mathias Shaw
	-- {zone:1453} Stormwind · {item:7676} Thistle Tea · {item:6947} Instant Poison · {item:2928} Dust of Decay · {item:3371} Empty Vial · {npc:1325} Jasper Fel · {npc:1326} Sloan McCoy · {object:2100} Old Town
	["Head north through Elwynn to {zone:1453}; Mathias Shaw is upstairs in SI:7. He teaches Poisons and gives you the {item:7676} recipe. Poisons are made, not bought: each batch of {item:6947} takes a {item:2928} and an {item:3371}, which {npc:1325} and {npc:1326} sell in {object:2100} next to SI:7. Buy a stack of each, open Poisons from your spellbook to make them, then use a poison on your weapon."] = "Geh nach Norden durch Elwynn nach {zone:1453}; Mathias Shaw ist oben im SI:7. Er bringt dir Gifte bei und gibt dir das Rezept {item:7676}. Gifte werden hergestellt, nicht gekauft: Jede Charge {item:6947} braucht {item:2928} und {item:3371}, die {npc:1325} und {npc:1326} in {object:2100} neben dem SI:7 verkaufen. Kaufe von jedem einen Stapel, öffne Gifte in deinem Zauberbuch, um sie herzustellen, und benutze dann ein Gift auf deiner Waffe.",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}: Poisons"] = "{npc:332}: Gifte",

	-- Step 6: Doc Mixilpixil
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil · {npc:1325} Jasper Fel
	["{quest:2607} still sits on you. {npc:7207} works in the cellar of the SI:7 building: the stairs down are under the stairs to the upper floor, behind {npc:1325}. Target him and type /lay (nothing after it) to be examined, then wait. If he does nothing, abandon the quest, take it again and wait until he asks you to lie down."] = "{quest:2607} hängt noch an dir. {npc:7207} arbeitet im Keller des SI:7-Gebäudes: Die Treppe nach unten liegt unter der Treppe zum Obergeschoss, hinter {npc:1325}. Wähle ihn als Ziel und tippe /lay (nichts danach), um untersucht zu werden, und warte dann. Wenn er nichts tut, brich die Quest ab, nimm sie erneut an und warte, bis er dich bittet, dich hinzulegen.",
	["/lay with the Doc targeted"] = "/lay mit dem Doc als Ziel",

	-- Step 7: The cure's ingredients
	["The cure's ingredients"] = "Die Zutaten für das Heilmittel",
	-- {zone:1453} Stormwind · {item:3421} Simple Wildflowers · {npc:1303} Felicia Gump · {object:2096} Trade District · {item:3372} Leaded Vial · {npc:1257} Keldric Boucher · {npc:1325} Jasper Fel · {item:4371} Bronze Tube · {item:8431} Spool of Light Chartreuse Silk Thread · {object:2177} The Finest Thread (no name in this language: may be words) · {item:6452} Anti-Venom · {skill:129} First Aid · {spell:526} Cure Poison · {spell:9810} Touch of Zanzil
	["All four are in {zone:1453}. {item:3421}: Bernard or {npc:1303}'s flower shop by the {object:2096} canal. A {item:3372}: many general goods and alchemy vendors ({npc:1257}, {npc:1325} and others). A {item:4371}: the Auction House in the {object:2096}; the engineering suppliers keep only one and are nearly always sold out, and an engineer can make one. The {item:8431} lies on the floor beside the left end of the counter in {object:2177}, the tailor's shop on the canals; you can only pick it up with this quest. If you skip the cure, an {item:6452} ({skill:129}) or a druid's {spell:526} also clears the {spell:9810}."] = "Alle vier sind in {zone:1453}. {item:3421}: Bernard oder der Blumenladen von {npc:1303} am Kanal beim {object:2096}. Eine {item:3372}: viele Gemischtwaren- und Alchemiehändler ({npc:1257}, {npc:1325} und andere). Eine {item:4371}: das Auktionshaus im {object:2096}; die Ingenieurbedarfshändler haben nur eine und sind fast immer ausverkauft, und ein Ingenieur kann eine herstellen. Die {item:8431} liegt auf dem Boden neben dem linken Ende der Theke in {object:2177}, dem Schneiderladen an den Kanälen; du kannst sie nur mit dieser Quest aufheben. Wenn du die Heilung auslässt, beseitigt auch ein {item:6452} ({skill:129}) oder {spell:526} eines Druiden das {spell:9810}.",
	-- {item:4371} Bronze Tube
	["{item:4371}: the Auction House"] = "{item:4371}: das Auktionshaus",

	-- Step 8: Back to Doc Mixilpixil
	-- {npc:7207} Doc Mixilpixil
	["Back to {npc:7207}"] = "Zurück zu {npc:7207}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["/lay down"] = "/hinlegen",
	-- ["At 20 {npc:332} at SI:7 in {object:2100} sends you to {npc:7024} in {zone:1436}."] = "Auf Stufe 20 schickt dich {npc:332} bei SI:7 in {object:2100} zu {npc:7024} in {zone:1436}.",
	-- ["Everything is in {zone:1453}: the Gumps sell {item:3421}, the {item:8431} lies in the city, and the nearest vendors sell a {item:3372} and a {item:4371}."] = "Alles gibt es in {zone:1453}: Die Gumps verkaufen {item:3421}, die {item:8431} liegt in der Stadt, und die nächsten Händler verkaufen eine {item:3372} und eine {item:4371}.",
	-- ["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever lehrt {spell:2842} über diese Questreihe, nicht beim Lehrer; das Rezept für {item:7676} gibt es dazu.",
	-- ["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Geh durch Elwynn nach Norden nach {zone:1453}; Mathias Shaw ist bei SI:7 in der {object:2100}.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Reite nach Norden durch den Wald von Elwynn nach {zone:1453}; Mathias Shaw ist bei SI:7 in {object:2100}.",
	-- ["{item:7908}, in the {object:123214}"] = "{item:7908}, in der {object:123214}",
	-- ["{npc:7024} watches {npc:7053}'s tower from the hills in the far east of {zone:1436}, by the {zone:1431} border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "{npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln im äußersten Osten von {zone:1436}, an der Grenze zu {zone:1431}. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- ["{npc:7207} works in the cellar of SI:7, the Barracks. Type /lay down beside him to be examined."] = "{npc:7207} arbeitet im Keller von SI:7, der Kaserne. Gib neben ihm /hinlegen ein, um dich untersuchen zu lassen.",
	-- ["{spell:2842} (Alliance)"] = "{spell:2842} (Allianz)",
}
