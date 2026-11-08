-- German (deDE): the guide forever/class/rogue/certificate-of-thievery (forever/class/rogue/certificate-of-thievery.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6966} Lucius · {quest:2282} Alther's Mill · {quest:2300} SI:7
	["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "Dein erster Schlossknacker-Auftrag mit Stufe 16: die Kassette von {npc:6966} bei {quest:2282}, für {quest:2300}.",

	-- Step 1: SI:7 (Goldshire)
	-- {quest:2300} SI:7
	["{quest:2300} (Goldshire)"] = "",
	-- {npc:917} Keryn Sylvius · {npc:6946} Renzik "The Shiv" · {zone:1453} Stormwind
	["At 16 {npc:917}, the rogue trainer upstairs in the Lion's Pride Inn in Goldshire, sends you to {npc:6946} in {zone:1453}. Taking it shuts out the other towns' breadcrumbs."] = "",

	-- Step 2: To Hulfdan! (Kharanos)
	-- {quest:2299} To Hulfdan!
	["{quest:2299} (Kharanos)"] = "",
	-- {npc:1234} Hogral Bakkan · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge · {object:32383} Forlorn Cavern
	["At 16 {npc:1234} in the Thunderbrew Distillery in Kharanos sends you to {npc:5165} in {zone:1455}'s {object:32383}."] = "",

	-- Step 3: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {object:32383} Forlorn Cavern · {zone:1453} Stormwind
	["{npc:5165} is in the house with a shady dealer outside, in the {object:32383}, down the stairs. Then fly or take the Deeprun Tram to {zone:1453}."] = "",

	-- Step 4: Erion Shadewhisper (Dolanaar)
	-- {quest:2259} Erion Shadewhisper
	["{quest:2259} (Dolanaar)"] = "",
	-- {npc:3599} Jannok Breezesong · {quest:2259} Erion Shadewhisper · {zone:1457} Darnassus
	["At 16 {npc:3599} in the Dolanaar inn sends you to {quest:2259} in {zone:1457}."] = "",

	-- Step 5: Erion Shadewhisper
	-- {npc:4214} Erion Shadewhisper
	["{npc:4214} stands in the Cenarion Enclave. Then the boat from Rut'theran Village to Auberdine, and the boat from Auberdine to Stormwind Harbor."] = "",

	-- Step 6: Renzik "The Shiv"
	-- {npc:6946} Renzik "The Shiv" · {quest:2300} SI:7 · {object:2100} Old Town · {npc:13283} Lord Tony Romano
	["{npc:6946} stands upstairs in the {quest:2300} building in {object:2100}, behind the rogue trainers. Before you leave: if you lack Pick Lock, {npc:13283} in the {quest:2300} building teaches it; Lockpicking is the test of the next quest."] = "",

	-- Step 7: Lucius
	-- {zone:1429} Elwynn Forest · {npc:6966} Lucius · {item:5060} Thieves' Tools · {npc:3090} Gerald Crawley
	["Head east through {zone:1429} into Redridge, or fly to Lakeshire. {npc:6966} stands on a crate on one of the Lakeshire docks, south of town; he gives you {item:5060} with the job ({npc:3090} in Lakeshire sells more). Pick Lock does not work without the tools in your bags."] = "",

	-- Step 8: Alther's Mill
	-- {quest:2282} Alther's Mill · {object:121264} Lucius's Lockbox
	["{quest:2282} stands east of Lakeshire, up off the road; Blackrock orcs roam near it. Inside, the Practice Lockboxes come back almost at once: pick them until {object:121264} opens for you (about 25 Lockpicking). Your Lockpicking cap rises 5 per level, so a low character may stall. Some boxes are trapped (a frost trap, for one); the skill still goes up. On Forever level 20 spiders wander near the boxes: clear them first or bring a friend. The lockbox always holds the token and is back two seconds after use. Practise on while it still gives skill: the next class quest needs about 75."] = "",

	-- Step 9: Back to Lucius
	-- {npc:6966} Lucius
	["Back to {npc:6966}"] = "Zurück zu {npc:6966}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 16 {npc:1234} in the {area:2102} in {area:131} sends you to {npc:5165}, in the north of {zone:1455}."] = "Mit Stufe 16 schickt dich {npc:1234} in der {area:2102} in {area:131} zu {npc:5165}, im Norden von {zone:1455}.",
	-- ["At 16 {npc:3599} in {area:186} sends you to {quest:2259} in {zone:1457}."] = "Mit Stufe 16 schickt dich {npc:3599} in {area:186} zu {quest:2259} in {zone:1457}.",
	-- ["At 16 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, sends you to {npc:6946} in {zone:1453}."] = "Mit Stufe 16 schickt dich {npc:917}, der Schurkenlehrer im Gasthaus Zur Höhle des Löwen in {area:87}, zu {npc:6946} in {zone:1453}.",
	-- ["Head east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} waits on the west side of {area:69} and gives you {item:5060}."] = "Geh nach Osten durch {zone:1429} ins Rotkammgebirge oder flieg nach {area:69}. {npc:6966} wartet auf der Westseite von {area:69} und gibt dir {item:5060}.",
	-- ["Ride east through {zone:1429} into Redridge, or fly to {area:69}. {npc:6966} waits on the west side of {area:69} and gives you {item:5060}."] = "Reite nach Osten durch {zone:1429} ins Rotkammgebirge oder flieg nach {area:69}. {npc:6966} wartet auf der Westseite von {area:69} und gibt dir {item:5060}.",
	-- ["Your first lockpicking job at 16: {npc:6966}'s lockbox at {quest:2282}, for {quest:2300}."] = "Dein erster Schlossknacker-Auftrag mit Stufe 16: die Kassette von {npc:6966} bei {quest:2282}, für {quest:2300}.",
	-- ["{npc:6946} stands beside {npc:332} at {quest:2300} in {object:2100}. Dwarves and Gnomes take the {area:2257} from {zone:1455}; Night Elves take the boat from {area:442} to {area:17203}."] = "{npc:6946} steht neben {npc:332} beim {quest:2300} in der {object:2100}. Zwerge und Gnome nehmen die Bahn {area:2257} ab {zone:1455}; Nachtelfen nehmen das Boot von {area:442} zum {area:17203}.",
	-- ["{npc:6946} stands beside {npc:332} at {quest:2300} in {object:2100}. Dwarves and Gnomes take the {area:2257} from {zone:1455}; Night Elves take the boat from {area:442} to {area:17203}. Learn Lockpicking from a rogue trainer before leaving for Redridge."] = "{npc:6946} steht neben {npc:332} bei {quest:2300} in der {object:2100}. Zwerge und Gnome nehmen die {area:2257} ab {zone:1455}; Nachtelfen nehmen das Schiff von {area:442} nach {area:17203}. Lerne Schlossknacken bei einem Schurkenlehrer, bevor du ins Rotkammgebirge aufbrichst.",
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {item:7869} there."] = "{quest:2282} steht östlich von {area:69}, etwas abseits der Straße. Öffne dort {item:7869}.",
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {object:121264} there."] = "{quest:2282} steht östlich von {area:69}, etwas abseits der Straße. Öffne dort {object:121264}.",
	-- ["{quest:2282} stands east of {area:69}, up off the road. Open {object:121264} there. Keep the {item:5060} supplied by {npc:6966} in your bags. Clear nearby spiders before practicing; lower-level rogues should bring help if the boxes are guarded. Use the practice locks until the quest lock is within your current skill, then recover the token. If useful practice remains, do it before returning to town; stop when the locks no longer improve your skill."] = "{quest:2282} liegt östlich von {area:69}, abseits der Straße. Öffne dort {object:121264}. Behalte {item:5060}, das du von {npc:6966} bekommst, in deinen Taschen. Räume nahe Spinnen weg, bevor du übst; Schurken niedrigerer Stufe sollten Hilfe mitbringen, wenn die Kisten bewacht werden. Benutze die Übungsschlösser, bis das Schloss der Quest in deinem aktuellen Können liegt, und hol dir dann das Zeichen. Bleibt nützliche Übung übrig, mach sie vor der Rückkehr in die Stadt; hör auf, wenn die Schlösser dein Können nicht mehr verbessern.",
}
