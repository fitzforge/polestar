-- German (deDE): the guide forever/class/paladin/cloak-of-the-divine-storm (forever/class/paladin/cloak-of-the-divine-storm.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:444} Tower of Althalaxx
	["Starts now at 22 at the {area:444}; its mobs are 28-30, so go nearer 30 or with a friend. Alliance only for now."] = "Beginnt jetzt mit 22 am {area:444}; die Mobs dort sind 28-30, geh also eher mit 30 oder mit einem Freund. Vorerst nur Allianz.",

	-- Step 1: The Strange Orb
	["The Strange Orb"] = "Die Strange Orb",
	-- {area:444} Tower of Althalaxx · {zone:1439} Darkshore · {spell:686} Shadow Bolt · {object:409311} Spear of Mannoroth
	-- plural, as words: Dark Strand Fanatics = {npc:2336} Dark Strand Fanatic · Dark Strand Voidcallers = {npc:2337} Dark Strand Voidcaller
	["Climb to the top of the {area:444} in northern {zone:1439}. The Dark Strand Fanatics around it are easy (level 16-17), but four Dark Strand Voidcallers (level 28-29) stand in the tower on the way to the orb: each calls a voidwalker and casts {spell:686} from range. At 22-25 bring a friend or two, pull them one at a time and step behind a wall so they have to come to you. Loot the Strange Orb at the top: it gives you the Althalaxx Orb; right-click it to start the quest. Keep the orb in your bags until the {object:409311}: three later quests need it."] = "Steig zur Spitze des {area:444} im Norden von {zone:1439}. Die Dark Strand Fanatics darum sind leicht (Stufe 16-17), aber vier Dark Strand Voidcallers (Stufe 28-29) stehen im Turm auf dem Weg zum Orb: Jeder ruft einen Leerwandler und wirkt {spell:686} aus der Ferne. Bring mit 22-25 einen oder zwei Freunde mit, pull sie einzeln und tritt hinter eine Wand, damit sie zu dir kommen müssen. Plündere das Strange Orb oben: Es gibt dir den Althalaxx Orb; klick ihn mit der rechten Maustaste an, um die Quest zu starten. Behalte den Orb in deinen Taschen bis zum {object:409311}: Drei spätere Quests brauchen ihn.",
	-- {area:444} Tower of Althalaxx
	["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "Strange Orb oben auf {area:444}: Rechtsklick auf die Kugel von Althalaxx, die sie gibt",

	-- Step 2: Delgren the Purifier
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale · {zone:1439} Darkshore · {zone:1453} Stormwind
	["{npc:3663} stands at {area:413} in western {zone:1440}, south of the {zone:1439} road. He sends you to {zone:1453} with the orb."] = "{npc:3663} steht in {area:413} im Westen von {zone:1440}, südlich der Straße von {zone:1439}. Er schickt dich mit dem Orb nach {zone:1453}.",

	-- Step 3: Katherine the Pure
	-- {npc:5492} Katherine the Pure
	["{npc:5492} stands in the Cathedral of Light; she sends you to a warlock for a second opinion."] = "{npc:5492} steht in der Kathedrale des Lichts; sie schickt dich für eine zweite Meinung zu einem Hexenmeister.",

	-- Step 4: Ursula Deline
	-- {npc:5495} Ursula Deline · {object:2101} Mage Quarter · {object:2164} Slaughtered Lamb · {item:209778} Summoner's Salt
	["{npc:5495}, the warlock trainer, is in the {object:2101}'s warlock sanctum, down in the {object:2164}'s cellar. She wants 14 {item:209778} to read the orb."] = "{npc:5495}, die Hexenmeisterlehrerin, ist im Hexenmeister-Heiligtum des {object:2101}, unten im Keller von {object:2164}. Sie will 14 {item:209778}, um den Orb zu lesen.",

	-- Step 5: Summoner's Salt
	-- {item:209778} Summoner's Salt · {area:69} Lakeshire · {npc:334} Gath'Ilzogg
	-- plural, as words: Blackrock Summoners = {npc:4463} Blackrock Summoner · Blackrock Shadowcasters = {npc:436} Blackrock Shadowcaster
	["The Blackrock Summoners, Champions and Trackers (level 22-25, not elite) camp in the north-west of Redridge and drop the {item:209778}; you need 14. Two elite Blackrock Shadowcasters (22-23) stand at the cave mouth at the camp's east end: pull around them. The Blackrock camps east of {area:69} drop the salt too, but their Shadowcasters, Sentries and Hunters are elite (level 21-24), and so is {npc:334} (26): stay in the north-west."] = "Die Blackrock Summoners, Champions und Trackers (Stufe 22-25, keine Elite) lagern im Nordwesten von Redridge und lassen {item:209778} fallen; du brauchst 14. Zwei Elite-Blackrock Shadowcasters (22-23) stehen am Höhleneingang am Ostende des Lagers: Umgeh sie. Die Blackrock-Lager östlich von {area:69} lassen das Salz ebenfalls fallen, aber ihre Shadowcasters, Sentries und Hunters sind Elite (Stufe 21-24), ebenso {npc:334} (26): Bleib im Nordwesten.",

	-- Step 6: Back to Ursula Deline
	-- {npc:5495} Ursula Deline
	["Back to {npc:5495}"] = "Zurück zu {npc:5495}",

	-- Step 7: Motes of Mannoroth
	["Motes of Mannoroth"] = "Partikel von Mannoroth",
	-- {area:435} Demon Fall Canyon · {zone:1440} Ashenvale · {area:431} Splintertree Post · {spell:686} Shadow Bolt · {spell:348} Immolate
	-- plural, as words: Mannoroc Lashers = {npc:11697} Mannoroc Lasher · Searing Infernals = {npc:6073} Searing Infernal · Legion Hounds = {npc:6071} Legion Hound
	["{area:435} is in south-east {zone:1440}, east of {area:431} (a Horde camp: go round it). The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds (level 29-30, not elite) drop the Motes of Mannoroth; you need 12. Below about 27 they are hard alone: come with a second player or later. Felguards knock you down, Lashers cast {spell:686} and {spell:348}, Infernals keep a fire shield up. They respawn in five minutes."] = "{area:435} liegt im Südosten von {zone:1440}, östlich von {area:431} (ein Horde-Lager: geh drumherum). Die Mannoroc Lashers, Searing Infernals, Felguards und Legion Hounds (Stufe 29-30, keine Elite) lassen die Motes of Mannoroth fallen; du brauchst 12. Unter etwa 27 sind sie allein schwer: Komm mit einem zweiten Spieler oder später. Felguards werfen dich um, Lashers wirken {spell:686} und {spell:348}, Infernals halten einen Feuerschild aufrecht. Sie respawnen nach fünf Minuten.",

	-- Step 8: The Spear of Mannoroth
	-- {object:409311} Spear of Mannoroth
	["The {object:409311}"] = "Der {object:409311}",
	-- {object:409311} Spear of Mannoroth · {area:435} Demon Fall Canyon · {object:409315} Shattered Orb
	["The {object:409311} stands at the east end of {area:435}. Hand in the motes at the spear with the Althalaxx Orb in your bags: the orb shatters, and the {object:409315} beside it starts the last quest."] = "Der {object:409311} steht am Ostende von {area:435}. Gib die Motes am Speer ab, während der Althalaxx Orb in deinen Taschen ist: Der Orb zerbricht, und der {object:409315} daneben startet die letzte Quest.",
	-- {object:409315} Shattered Orb
	["from the {object:409315}"] = "von der {object:409315}",

	-- Step 9: Return to Delgren
	-- {npc:3663} Delgren the Purifier · {area:413} Maestra's Post · {zone:1440} Ashenvale
	["Back to {npc:3663} at {area:413} in western {zone:1440}, across the whole zone."] = "Zurück zu {npc:3663} in {area:413} im Westen von {zone:1440}, quer durch das ganze Gebiet.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A rare cloak at 30 from the old {spell:407778} story; for now only Alliance paladins can finish it."] = "Ein seltener Umhang auf Stufe 30 aus der alten Geschichte um {spell:407778}; derzeit können nur Paladine der Allianz sie abschließen.",
	-- ["Back to {area:413}."] = "Zurück zu {area:413}.",
	-- ["Blackrock Summoners, Champions and Trackers camp in the north-west of Redridge; they drop the {item:209778}."] = "Beschwörer, Helden und Fährtenleser der Blackrock lagern im Nordwesten des Rotkammgebirges; sie lassen das {item:209778} fallen.",
	-- ["Climb to the top of the {area:444} in northern {zone:1439}. Loot the Strange Orb up there: it gives you the Althalaxx Orb, which starts the quest."] = "Klettere ganz nach oben auf {area:444} im nördlichen {zone:1439}. Plündere dort oben die Strange Orb: Sie gibt dir die Kugel von Althalaxx, die die Quest startet.",
	-- ["Katherine sends you to the warlocks in the {object:2101}; {npc:5495} speaks for them."] = "Katherine schickt dich zu den Hexenmeistern im {object:2101}; {npc:5495} spricht für sie.",
	-- ["Strange Orb atop the {area:444}: right-click the Althalaxx Orb it gives"] = "Strange Orb oben auf {area:444}: Rechtsklick auf die Kugel von Althalaxx, die sie gibt",
	-- ["The Strange Orb"] = "Die Strange Orb",
	-- ["The {object:409311} stands at the east end of {area:435}. Shatter the orb on it; the {object:409315} appears beside it."] = "{object:409311} steht am Ostende von {area:435}. Zerschmettere die Kugel darauf; {object:409315} erscheint daneben.",
	-- ["The {object:409311} stands at the east end of {area:435}. {spell:11170} the orb on it; the {object:409315} appears beside it."] = "{object:409311} steht am Ostende von {area:435}. Wirke {spell:11170} auf die Kugel darauf; {object:409315} erscheint daneben.",
	-- ["{area:435} is in south-east {zone:1440}. The Mannoroc Lashers, Searing Infernals, Felguards and Legion Hounds in it drop the Motes of Mannoroth."] = "Der {area:435} liegt im Südosten von {zone:1440}. Die Mannoroc-Peitscher, Sengenden Höllenbestien, Teufelswachen und Legionshunde dort lassen die Partikel von Mannoroth fallen.",
	-- ["{npc:3663} stands at {area:413} in western {zone:1440}."] = "{npc:3663} steht bei {area:413} im westlichen {zone:1440}.",
	-- ["{npc:5492} is in the Cathedral of Light."] = "{npc:5492} ist in der Kathedrale des Lichts.",
}
