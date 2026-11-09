-- German (deDE): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor · {npc:13085} Myrokos Silentform
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and {npc:13085}'s jobs against the Syndicate."] = "Öffnet {area:3486}, das versteckte Schurkenhaus in den Hügeln von Alterac, und die Aufträge von {npc:13085} gegen das Syndikat.",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "Ruf bei {npc:13936}",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "Der {item:17126}",
	-- {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad · {spell:1846} Detect Traps
	["At 24 any capital's rogue trainer ({npc:332} or {npc:918} in {zone:1453}, Gest or Ormok in {zone:1454}, and the others) has an {item:17126} from {npc:13936} for you: ask for it in their talk window. Open it: the quest gives you the {item:17125} for {npc:6707}. Learn {spell:1846} from your trainer first if you have not; the way in is a test of it."] = "Mit 24 hat der Schurkenlehrer jeder Hauptstadt ({npc:332} oder {npc:918} in {zone:1453}, Gest oder Ormok in {zone:1454} und die anderen) einen {item:17126} von {npc:13936} für dich: Frag in ihrem Gesprächsfenster danach. Öffne ihn: Die Quest gibt dir {item:17125} für {npc:6707}. Lerne vorher {spell:1846} bei deinem Lehrer, falls noch nicht geschehen; der Weg hinein ist eine Prüfung darin.",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {spell:1846} Detect Traps · {area:3486} Ravenholdt Manor · {npc:6707} Fahrad · {npc:13936} Ravenholdt
	["Horde fly to {area:272}, Alliance to {area:271}. The trail to the manor is hard to see: it starts behind the plateau north of {area:275}, east of {area:272}, climbs into the hills and bends twice to a small tunnel. A chest sits in the tunnel: do not open it. Cast {spell:1846} near it and walk up close; that is the Rite of Cunning (it comes back after 5 minutes). Opening the chest calls Milton, an elite rogue of about level 32. Through the tunnel lies {area:3486}: {npc:6707} is upstairs inside. Do not attack anyone at the manor: it costs {npc:13936} reputation."] = "Die Horde fliegt nach {area:272}, die Allianz nach {area:271}. Der Pfad zum Anwesen ist schwer zu erkennen: Er beginnt hinter dem Plateau nördlich von {area:275}, östlich von {area:272}, führt in die Hügel und knickt zweimal ab zu einem kleinen Tunnel. Im Tunnel steht eine Truhe: Öffne sie nicht. Wirke {spell:1846} in ihrer Nähe und geh dicht heran; das ist der Rite of Cunning (er kommt nach 5 Minuten wieder). Das Öffnen der Truhe ruft Milton, einen Elite-Schurken der Stufe 32. Hinter dem Tunnel liegt {area:3486}: {npc:6707} ist oben im Inneren. Greife im Anwesen niemanden an: Das kostet Ruf bei {npc:13936}.",
	-- {spell:1846} Detect Traps
	["Rite of Cunning: {spell:1846} beside the tunnel chest"] = "Rite of Cunning: {spell:1846} neben der Truhe im Tunnel",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable; take it now, the emblems are quest items"] = "{npc:6766}: {quest:6701}, wiederholbar; nimm sie jetzt an, die Embleme sind Questgegenstände",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {npc:13085} Myrokos Silentform · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Rogues = {npc:2260} Syndicate Rogue
	["{npc:266216} is inside {area:275}, the Syndicate fortress south of the manor; he can stand in any of fifteen spots in the keep, so search. Quick and quiet, says {npc:13085}. Pick the pockets of the level 20-21 Syndicate Rogues, Shadow Mages and Watchmen on your way: they carry {quest:6701} for the guards' repeatable reputation quest."] = "{npc:266216} ist in {area:275}, der Festung des Syndikats südlich des Anwesens; er kann an fünfzehn verschiedenen Stellen in der Festung stehen, such also. Schnell und leise, sagt {npc:13085}. Bestiehl auf dem Weg die Syndicate Rogues, Shadow Mages und Watchmen der Stufe 20-21: Sie tragen {quest:6701} für die wiederholbare Rufquest der Wachen.",
	-- {quest:6701} Syndicate Emblems
	["Pick Pocket Syndicate members for {quest:6701}"] = "Bestiehl Mitglieder des Syndikats für {quest:6701}",

	-- Step 4: Myrokos Silentform
	-- {npc:6766} Ravenholdt Guard
	["{npc:6766}: one emblem each time, 100 reputation"] = "{npc:6766}: ein Emblem pro Abgabe, 100 Ruf",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains · {spell:921} Pick Pocket
	["In your mid 30s {npc:13085} has two more jobs; take both. Barton leads a Syndicate scouting party at {area:280}, in the east of the {zone:1416}, inside one of the houses with stealthed Syndicate around him. Pick his pocket for the report and do not kill him: he does not drop it. If you are lower than him he sees through stealth; Master of Deception helps, or Distract him, Vanish and come in from behind. {spell:921} can miss several times in a row."] = "In deinen mittleren 30ern hat {npc:13085} zwei weitere Aufträge; nimm beide an. Barton führt einen Spähtrupp des Syndikats in {area:280} an, im Osten des {zone:1416}, in einem der Häuser, mit getarnten Syndikatsleuten um sich. Bestiehl ihn für den Bericht und töte ihn nicht: Er lässt ihn nicht fallen. Wenn du eine niedrigere Stufe hast als er, sieht er durch Tarnung; Meister der Täuschung hilft, oder lenke ihn ab, verschwinde und komm von hinten. {spell:921} kann mehrmals hintereinander fehlschlagen.",
	-- {item:275482} Barton's Scouting Report
	["Pick Pocket Barton for {item:275482}"] = "Bestiehl Barton und erhalte {item:275482}",

	-- Step 6: Covert Extraction
	-- {npc:13085} Myrokos Silentform · {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["Back to {npc:13085}; the report sends you after the Perenolde heirlooms. Two towers stand among the {area:281}, in the middle of the {zone:1416}, held by ogres: the shield lies in the northern tower, the sword in the southern one, which elite ogres ring and watch from far off. Stay stealthed; nothing guards the heirlooms inside."] = "Zurück zu {npc:13085}; der Bericht schickt dich den Erbstücken der Perenolde nach. Zwei Türme stehen zwischen den {area:281}, mitten im {zone:1416}, von Ogern gehalten: Der Schild liegt im nördlichen Turm, das Schwert im südlichen, den Elite-Oger umringen und aus der Ferne beobachten. Bleib getarnt; drinnen bewacht nichts die Erbstücke.",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, in the northern tower"] = "{item:275636}, im nördlichen Turm",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, in the southern tower"] = "{item:275635}, im südlichen Turm",

	-- Step 7: A Way In
	-- {area:324} Stromgarde Keep · {area:313} Northfold Manor · {object:656157} Syndicate Footlocker · {quest:96783} A Way In
	["{area:324} in western Arathi is a Syndicate stronghold; to get in you need a uniform. {area:313}, in north-western Arathi, is held by Syndicate Highwaymen, Pathstalkers and Mercenaries (level 30-32): find the {object:656157} there and take the uniform; that ends {quest:96783}."] = "{area:324} im westlichen Arathi ist eine Festung des Syndikats; um hineinzukommen, brauchst du eine Uniform. {area:313}, im nordwestlichen Arathi, wird von Syndicate Highwaymen, Pathstalkers und Mercenaries (Stufe 30-32) gehalten: Finde dort {object:656157} und nimm die Uniform; damit endet {quest:96783}.",
	-- {quest:96784} Master of Disguise · {item:275706} Syndicate Uniform
	["{quest:96784}: the {item:275706}"] = "{quest:96784}: {item:275706}",

	-- Step 8: Anastasia Miller
	-- {item:275706} Syndicate Uniform · {quest:96784} Master of Disguise · {quest:96785} Ain't No Telling · {npc:266847} Anastasia Miller
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Stromgarde's Syndicate Prowlers and Conjurors are elite (level 35-36): a rogue of 36 can slip past them, but fighting one alone is hard, so stay hidden or bring a friend. Put on the {item:275706} ({quest:96784} hands it to you at the footlocker) to pass as one of them; stealth or suspicious acts can break it. If the footlocker gave you no uniform, Anastasia hands you one with {quest:96785}. {npc:266847} is not inside the keep: she stands on a ledge on the outside of the castle wall. Jump across to it from the roof of the house beside the ledge."] = "Die Syndicate Prowlers und Conjurors in Stromgarde sind Elite (Stufe 35-36): Ein Schurke der Stufe 36 kann an ihnen vorbeischlüpfen, aber allein gegen einen zu kämpfen ist schwer, bleib also versteckt oder bring einen Freund mit. Zieh {item:275706} an ({quest:96784} gibt sie dir an der Truhe), um als einer von ihnen durchzugehen; Tarnung oder verdächtiges Verhalten können sie brechen. Wenn dir die Truhe keine Uniform gegeben hat, gibt dir Anastasia mit {quest:96785} eine. {npc:266847} ist nicht in der Festung: Sie steht auf einem Vorsprung an der Außenseite der Burgmauer. Spring vom Dach des Hauses neben dem Vorsprung hinüber.",

	-- Step 9: Ain't No Telling
	-- {item:275709} Stolen Funds
	["She will not talk without something to bargain with. Her stash is upstairs in a house close to the keep: take the {item:275709}. If it is already open, wait for it to come back."] = "Sie redet nicht ohne etwas zum Verhandeln. Ihr Versteck liegt oben in einem Haus nahe der Festung: Nimm {item:275709}. Wenn es schon geöffnet ist, warte, bis es wieder da ist.",
	-- {item:275709} Stolen Funds
	["{item:275709}: Anastasia's Stash"] = "{item:275709}: Anastasias Versteck",

	-- Step 10: The Syndicate Sting
	-- {area:1057} Thoradin's Wall · {area:287} Hillsbrad · {item:275882} Intercepted Shipment · {item:275706} Syndicate Uniform · {npc:13085} Myrokos Silentform
	["Falconcrest's men make the handoff at the southern end of {area:1057}, the old wall between Arathi and {area:287}. Kill the two guarding the box and take the {item:275882}. Keep the {item:275706}: {npc:13085} wants it back with the shipment."] = "Falconcrests Männer machen die Übergabe am Südende von {area:1057}, der alten Mauer zwischen Arathi und {area:287}. Töte die beiden, die die Kiste bewachen, und nimm {item:275882}. Behalte {item:275706}: {npc:13085} will sie mit der Lieferung zurück.",

	-- Step 11: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "Zurück zu {npc:13085}",
	-- {npc:13085} Myrokos Silentform · {npc:13936} Ravenholdt
	["{npc:13085}: 70 silver, 300 {npc:13936} reputation"] = "{npc:13085}: 70 Silber, 300 Ruf bei {npc:13936}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "Auf Stufe 24 startet ein {item:17126} von {npc:13936} das Ganze; laut Daten erhältst du ihn über {npc:332} oder {npc:918} in {zone:1453} oder Gest oder Ormok in {zone:1454}. Die Quest gibt dir das {item:17125} für {npc:6707}.",
	-- ["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "Auf Stufe 36 schickt dich {npc:13085} nach Bartons Erkundungsbericht. Barton führt einen Trupp des Syndikats in {area:280} im Osten des {zone:1416}: Bestiehl ihn, töte ihn nicht.",
	-- ["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "Horde fliegt nach {area:272}, Allianz nach {area:271}. Das Anwesen versteckt sich in den Hügeln östlich von {area:272}, einen Pfad hinauf ins {zone:1416}; der Rite of Cunning führt dich hinein.",
	-- ["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "Öffnet {area:3486}, das versteckte Schurkenhaus in den Hügeln von Alterac, und seine ersten Aufträge.",
	-- ["Rite of Cunning"] = "Rite of Cunning",
	-- ["{item:275482}: pickpocket Barton"] = "{item:275482}: Barton bestehlen",
	-- ["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216} ist in {area:275}, der Festung des Syndikats im Osten von {area:287}, südlich des Anwesens. Schnell und leise, sagt {npc:13085}.",
	-- ["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766}: {quest:6701}, wiederholbar",
}
