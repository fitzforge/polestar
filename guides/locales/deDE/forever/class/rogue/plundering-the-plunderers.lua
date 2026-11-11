-- German (deDE): the guide forever/class/rogue/plundering-the-plunderers (forever/class/rogue/plundering-the-plunderers.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7676} Thistle Tea
	["Ten {item:7676}, the rogue energy drink, from the Horde lockpicking jobs at 16."] = "Zehn {item:7676}, das Energiegetränk der Schurken, aus den Schlossknack-Aufträgen der Horde auf Stufe 16.",

	-- Step 1: To Orgrimmar!
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {npc:3401} Shenthul · {zone:1454} Orgrimmar
	["At 16 {npc:3170}, the rogue trainer in {area:362}, sends you to {npc:3401} in {zone:1454}."] = "Auf Stufe 16 schickt dich {npc:3170}, der Schurkenlehrer in {area:362}, zu {npc:3401} in {zone:1454}.",

	-- Step 2: Find the Shattered Hand
	-- {npc:6467} Mennet Carkad · {object:36073} Rogues' Quarter · {npc:3401} Shenthul · {zone:1454} Orgrimmar · {quest:1998} Fenwick Thatros · {zone:1421} Silverpine Forest
	["At 16 {npc:6467} in the {object:36073} sends you to {npc:3401} in {zone:1454}. Take {quest:1998} from him too; it is done in {zone:1421} at the end of this guide."] = "Auf Stufe 16 schickt dich {npc:6467} im {object:36073} zu {npc:3401} in {zone:1454}. Nimm bei ihm auch {quest:1998} an; sie wird am Ende dieses Guides in {zone:1421} erledigt.",

	-- Step 3: Shenthul and Zando'zan
	-- {npc:3401} Shenthul · {quest:2379} Zando'zan
	["{npc:3401} and {quest:2379}"] = "{npc:3401} und {quest:2379}",
	-- {zone:1458} Undercity · {zone:1411} Durotar · {npc:3401} Shenthul · {quest:2379} Zando'zan · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {spell:1804} Pick Lock
	["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}. Train {spell:1804} from {npc:3401} (or any rogue trainer) now if you lack it: this job is a lockpicking test."] = "Untote nehmen den Zeppelin von den Türmen vor der {zone:1458} nach {zone:1411}. {npc:3401} und {quest:2379} stehen im {object:172960}, der Schlucht unter dem {object:172982}. Lerne jetzt {spell:1804} bei {npc:3401} (oder einem anderen Schurkenlehrer), falls du es nicht kannst: Dieser Auftrag ist eine Schlossknacken-Prüfung.",

	-- Step 4: Wrenix the Wretched
	-- {area:392} Ratchet · {zone:1413} Barrens · {npc:7161} Wrenix the Wretched · {item:7970} E.C.A.C. · {item:5060} Thieves' Tools · {spell:1804} Pick Lock
	["Fly or walk to {area:392} on the {zone:1413} coast. {npc:7161} stands in a small shed near the bank, up the hill to the left before the docks. His Gizmotronic Apparatus beside him hands out what the job needs: take an {item:7970} and {item:5060} ({spell:1804} does not work without the tools in your bags)."] = "Flieg oder geh nach {area:392} an der Küste von {zone:1413}. {npc:7161} steht in einem kleinen Schuppen nahe der Bank, den Hügel links hinauf vor den Docks. Sein Gizmotronic Apparatus neben ihm gibt aus, was der Auftrag braucht: Nimm einen {item:7970} und {item:5060} ({spell:1804} funktioniert nicht ohne das Werkzeug in deinen Taschen).",

	-- Step 5: Southsea Treasure
	-- {area:392} Ratchet · {object:123462} The Jewel of the Southsea (no name in this language: may be words) · {npc:7168} Polly · {item:7970} E.C.A.C. · {item:7968} Southsea Treasure
	["Follow the coast south from {area:392} to the first beached pirate ship, the Tide Razor, and climb aboard up its bow. On the middle deck the Buccaneer's Strongboxes come back fast: pick them until your Lockpicking is about 30 (a few are trapped with a frost nova or turn you into a rat; picking still works as a rat). Keep picking while they still give skill: the poisons job at 20 ends at a lockbox that needs about 75, and these boxes are the closest practice. Then go down to the bottom hold and pick the lock of {object:123462}: it is empty, but opening it calls a giant level 50 {npc:7168} into the next room. Stay stealthed, put the {item:7970} on your action bar, target {npc:7168} and use it: the parrot shrinks to level 18. Kill it for the {item:7968}."] = "Folge der Küste südlich von {area:392} bis zum ersten gestrandeten Piratenschiff, der Tide Razor, und klettere am Bug an Bord. Auf dem Mitteldeck kommen die Buccaneer's Strongboxes schnell wieder: Knacke sie, bis dein Schlossknacken bei etwa 30 liegt (einige sind mit einer Frostnova versehen oder verwandeln dich in eine Ratte; Knacken geht auch als Ratte). Knacke weiter, solange sie noch Fertigkeit bringen: Der Giftauftrag mit 20 endet an einer Schließkiste, die etwa 75 braucht, und diese Kisten sind die nächste Übungsmöglichkeit. Geh dann hinunter in den untersten Laderaum und knacke das Schloss von {object:123462}: Sie ist leer, aber ihr Öffnen ruft einen riesigen {npc:7168} der Stufe 50 in den nächsten Raum. Bleib getarnt, lege {item:7970} auf deine Aktionsleiste, wähle {npc:7168} als Ziel und benutze ihn: Der Papagei schrumpft auf Stufe 18. Töte ihn für {item:7968}.",
	-- {item:7968} Southsea Treasure · {npc:7168} Polly · {item:7970} E.C.A.C.
	["{item:7968}: {npc:7168}, after the {item:7970}"] = "{item:7968}: {npc:7168}, nach dem {item:7970}",

	-- Step 6: Back to Wrenix the Wretched
	-- {npc:7161} Wrenix the Wretched
	["Back to {npc:7161}"] = "Zurück zu {npc:7161}",
	-- {npc:7161} Wrenix the Wretched · {item:7676} Thistle Tea
	["{npc:7161}: ten {item:7676}"] = "{npc:7161}: zehn {item:7676}",

	-- Step 7: Fenwick Thatros
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {quest:1998} Fenwick Thatros · {area:1338} Lordamere Lake · {area:228} Sepulcher
	["Take the zeppelin from {zone:1454} to the {zone:1458} and head south into Silverpine. {quest:1998} (level 16) stands alone on the old ferry dock on {area:1338}, north-east of the {area:228}. His Uppercut knocks you back, so do not fight him at the dock's edge. He always drops his head and is back 4 1/2 minutes after a death."] = "Nimm den Zeppelin von {zone:1454} zur {zone:1458} und geh nach Süden nach Silberwald. {quest:1998} (Stufe 16) steht allein auf dem alten Fähranleger am {area:1338}, nordöstlich von {area:228}. Sein Uppercut wirft dich zurück, kämpfe also nicht am Rand des Anlegers gegen ihn. Er lässt seinen Kopf immer fallen und ist 4 1/2 Minuten nach einem Tod zurück.",

	-- Step 8: Mennet Carkad
	-- {item:5060} Thieves' Tools · {npc:6566} Estelle Gendry · {object:36073} Rogues' Quarter
	["If you have no {item:5060} left, ask {npc:6566}, the outfitter in the {object:36073}."] = "Wenn du kein {item:5060} mehr hast, frag {npc:6566}, die Ausrüsterin im {object:36073}.",

	-- Step 9: Ambermill
	-- {area:233} Ambermill · {object:103815} Ambermill Strongbox · {item:5060} Thieves' Tools
	["The Kirin Tor keep their reports in walled {area:233}, in south-east Silverpine. Facing the town hall, take the building on the right: the {object:103815} is in a corner room upstairs (any Lockpicking opens it; the {item:5060} must be in your bags). Three casters of level 19-20 guard that floor and see through stealth, one walking in and out of the strongbox room: time it or fight them one at a time."] = "Der Kirin Tor bewahrt seine Berichte im ummauerten {area:233} im Südosten von Silberwald auf. Wenn du dem Rathaus gegenüberstehst, nimm das Gebäude rechts: {object:103815} steht oben in einem Eckzimmer (jedes Schlossknacken öffnet sie; {item:5060} muss in deinen Taschen sein). Drei Zauberwirker der Stufe 19-20 bewachen dieses Stockwerk und sehen durch Tarnung; einer läuft in den Raum mit der Truhe hinein und wieder heraus: Pass den Zeitpunkt ab oder kämpfe einzeln gegen sie.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "Zurück zu {npc:6467}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly or ride to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "Flieg oder reite nach {area:392} an der Küste von {zone:1413}. {npc:7161} steht mit Wrenix' Elektrodingsda-Apparat im Ort: Kauf vor dem Aufbruch einen {item:7970} und {item:5060} am Apparat.",
	-- ["Fly or walk to {area:392} on the {zone:1413} coast. {npc:7161} stands in town with his Gizmotronic Apparatus: buy an {item:7970} and {item:5060} from the apparatus before you go."] = "Flieg oder geh nach {area:392} an der Küste von {zone:1413}. {npc:7161} steht in der Stadt mit seinem Gizmotronischen Apparat: Kaufe vor dem Aufbruch {item:7970} und {item:5060} am Apparat.",
	-- ["South along the coast from {area:392}, at the Southsea pirates' camp. If an unusually hostile parrot attacks you, use the {item:7970} on it (the quest's own advice)."] = "Südlich entlang der Küste von {area:392}, im Lager der Südmeerfreibeuter. Greift dich ein ungewöhnlich feindseliger Papagei an, benutze den {item:7970} an ihm (der eigene Rat der Quest).",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and head south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "Nimm den Zeppelin von {zone:1454} nach {zone:1458} und geh nach Süden in den Silberwald. {quest:1998} steht nordöstlich des {area:228}.",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south into Silverpine. {quest:1998} stands north-east of the {area:228}."] = "Nimm den Zeppelin von {zone:1454} nach {zone:1458} und reite nach Süden in den Silberwald. {quest:1998} steht nordöstlich von {area:228}.",
	-- ["The Kirin Tor keep their reports at {area:233}, in south-east Silverpine: pick the lock on the {object:103815}."] = "Die Kirin Tor bewahren ihre Berichte in {area:233} auf, im Südosten des Silberwalds: Knack das Schloss des {object:103815}.",
	-- ["Undead take the zeppelin from the towers outside the {zone:1458} to {zone:1411}. {npc:3401} and {quest:2379} stand in the {object:172960}, the canyon under the {object:172982}."] = "Untote nehmen den Zeppelin von den Türmen außerhalb von {zone:1458} nach {zone:1411}. {npc:3401} und {quest:2379} stehen in der {object:172960}, der Schlucht unter dem {object:172982}.",
}
