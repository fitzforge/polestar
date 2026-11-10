-- German (deDE): the guide forever/class/warlock/shard-of-the-green-flame (forever/class/warlock/shard-of-the-green-flame.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood
	["A rare off-hand for your 50s from {npc:14469} and {npc:14470} in {zone:1448}, the camp that also offers An Imp's Request."] = "Eine seltene Schildhand für Stufe 50+ von {npc:14469} und {npc:14470} in {zone:1448}, dem Lager, das auch Die Bitte eines Wichtels anbietet.",

	-- Step 1: Niby the Almighty
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls
	-- plural, as words: Flawless Fel Essences = {quest:7602} Flawless Fel Essence
	["At 50 {npc:14469} and his imp {npc:14470} wait on a rise in central {zone:1448} just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. {npc:14469} sends you to {npc:14470}, beside him, who wants three Flawless Fel Essences from three places."] = "Mit Stufe 50 warten {npc:14469} und sein Wichtel {npc:14470} auf einer Anhöhe im mittleren {zone:1448} direkt nordöstlich von {area:1997}: Wenn du von Süden über die Brücke von {area:1765} nach Norden kommst, stehen sie östlich abseits der Straße, hinter ein paar Schlämmen. {npc:14469} schickt dich zu {npc:14470} neben ihm, der drei Flawless Fel Essences von drei Orten will.",

	-- Step 2: Jaedenar
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {area:1770} Shadow Hold · {npc:9516} Lord Banehollow
	-- plural, as words: Jaedenar Legionnaires = {npc:9862} Jaedenar Legionnaire
	["{area:1763} lies just south of {area:1997}, west of the road. Of its two caves, {area:1770} is the northern one, further up the hill; the other has no Legionnaires. {area:1770}'s tunnels run north under the hills, and the Jaedenar Legionnaires (level 55) stand in its deeper halls, from the first ramps on toward {npc:9516}'s chamber; they Uppercut anyone in melee. Three kills in four give the essence, but only about eleven spawn: clear your way in and wait out a five-minute respawn if you must. The cultists of {area:1763} and {area:1770} are all hostile."] = "{area:1763} liegt direkt südlich von {area:1997}, westlich der Straße. Von seinen zwei Höhlen ist {area:1770} die nördliche, weiter oben am Hügel; die andere hat keine Legionnaires. Die Tunnel von {area:1770} verlaufen nach Norden unter die Hügel, und die Jaedenar Legionnaires (Stufe 55) stehen in den tieferen Hallen, von den ersten Rampen bis zur Kammer von {npc:9516}; sie führen gegen jeden im Nahkampf einen Aufwärtshaken aus. Drei von vier Kills ergeben die Essenz, aber es spawnen nur etwa elf: Kämpf dich hinein und warte notfalls einen Respawn von fünf Minuten ab. Die Kultisten von {area:1763} und {area:1770} sind alle feindlich.",

	-- Step 3: Azshara
	-- {zone:1447} Azshara
	["The Legashi satyrs (level 51-53) hold the Legash Encampment on {zone:1447}'s northern coast. Every kind drops the essence three times in four; the satyrs burn mana and the Hellcallers rain fire, so pull them singly."] = "Die Legashi-Satyrn (Stufe 51-53) halten das Legash Encampment an der Nordküste von {zone:1447}. Jede Sorte lässt die Essenz bei drei von vier Kills fallen; die Satyrn verbrennen Mana und die Hellcallers lassen Feuer regnen, pull sie also einzeln.",

	-- Step 4: The Dark Portal
	-- {area:72} The Dark Portal · {zone:1419} Blasted Lands
	["The Felguard Sentries (level 54) walk around the {area:72} in the south of the {zone:1419}, each with a felhunter. Leave the level 57 Servants of Razelikh alone: they cannot be killed without their own quest."] = "Die Felguard Sentries (Stufe 54) laufen um {area:72} im Süden von {zone:1419}, jeweils mit einem Teufelsjäger. Lass die Servants of Razelikh der Stufe 57 in Ruhe: Ohne ihre eigene Quest lassen sie sich nicht töten.",

	-- Step 5: Impsy
	-- {npc:14470} Impsy · {item:18626} Fel Fire · {npc:14467} Kroshius
	["Back to {npc:14470}. He hands you the {item:18626}: keep it, it wakes the infernal {npc:14467}."] = "Zurück zu {npc:14470}. Er gibt dir {item:18626}: Behalte es, es erweckt die Höllenbestie {npc:14467}.",

	-- Step 6: Kroshius
	-- {npc:14467} Kroshius · {area:1766} Shatter Scar Vale · {npc:14469} Niby the Almighty · {item:18626} Fel Fire · {npc:14470} Impsy
	["{npc:14467}' remains lie in {area:1766}, the burnt crater north of {npc:14469}: follow the road north from his camp; the remains lie a little east of it. Use the {item:18626} beside them and wait for him to rise. {npc:14467} is elite (level 55): grouping up is encouraged; a warlock of 55 or more can solo him with Fear and damage over time, or with Enslave Demon, but fire spells do nothing to him and he knocks you back. If you die he heals to full; he rises again three minutes after he dies. An elite infernal patrols the pool south of the remains: pull {npc:14467} away from it. He always drops his core. Lost the {item:18626}? Abandon the quest and take it again from {npc:14470}."] = "Die Überreste von {npc:14467} liegen in {area:1766}, dem verbrannten Krater nördlich von {npc:14469}: Folge der Straße von seinem Lager nach Norden; die Überreste liegen ein Stück östlich davon. Benutze {item:18626} neben ihnen und warte, bis er sich erhebt. {npc:14467} ist ein Elite (Stufe 55): Eine Gruppe wird empfohlen; ein Hexenmeister ab Stufe 55 kann ihn mit Furcht und Schaden über Zeit oder mit Dämonen versklaven solo schaffen, aber Feuerzauber wirken nicht auf ihn und er schleudert dich zurück. Stirbst du, heilt er sich voll; er erhebt sich drei Minuten nach seinem Tod erneut. Eine Elite-Höllenbestie patrouilliert am Teich südlich der Überreste: Zieh {npc:14467} von ihr weg. Er lässt seinen Kern immer fallen. {item:18626} verloren? Brich die Quest ab und nimm sie bei {npc:14470} erneut an.",
	-- {item:18626} Fel Fire · {object:179677} Kroshius' Remains (no name in this language: may be words)
	["{item:18626}, at {object:179677}"] = "{item:18626}, bei {object:179677}",

	-- Step 7: Back to Niby the Almighty
	-- {npc:14469} Niby the Almighty
	["Back to {npc:14469}"] = "Zurück zu {npc:14469}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:14469} and his imp {npc:14470} wait in central {zone:1448}, just east of {area:1763}."] = "Mit Stufe 50 warten {npc:14469} und sein Wichtel {npc:14470} in der Mitte von {zone:1448}, direkt östlich von {area:1763}.",
	-- ["The Felguard Sentries around the {area:72}, in southern {zone:1419}, carry its essence."] = "Die Wachposten der Teufelswache rund um das {area:72}, im Süden von {zone:1419}, tragen dessen Essenz.",
	-- ["The Jaedenar Legionnaires, a short way west of {npc:14469}, carry {area:1763}'s essence."] = "Die Legionäre von Jaedenar, ein kurzes Stück westlich von {npc:14469}, tragen die Essenz von {area:1763}.",
	-- ["The Legashi satyrs of northern {zone:1447} carry {zone:1447}'s essence."] = "Die Satyrn der Legashi im Norden von {zone:1447} tragen die Essenz von {zone:1447}.",
	-- ["{npc:14467}' remains lie in {area:1766}, north of {npc:14469}. Use the {item:18626} beside them and kill the infernal when he wakes. {npc:14467} is elite: grouping up is advised."] = "Die Überreste von {npc:14467} liegen im {area:1766}, nördlich von {npc:14469}. Benutze das {item:18626} daneben und töte die Höllenbestie, wenn sie erwacht. {npc:14467} ist Elite: Eine Gruppe wird empfohlen.",
}
