-- German (deDE): the guide forever/class/rogue/the-eye-of-bhossca (forever/class/rogue/the-eye-of-bhossca.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:277246} Ruby-Adorned Blade · {area:796} Scarlet Monastery
	["The {item:277246}, C's payment for a solo job inside the {area:796}."] = "Die {item:277246}, die Bezahlung von C für einen Soloauftrag im Gebiet {area:796}.",

	-- Step 1: C's dead drop
	["C's dead drop"] = "Der tote Briefkasten von C",
	-- {object:410369} Dead Drop · {area:204} Pyrewood Village · {area:236} Shadowfang Keep
	["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. After the horn job and C's next letter, check it for the new job. The data lists a minimum of 25, but beta players report receiving the invitation at 30 after the horn job and a city visit; this is not a guaranteed mail level. If no new note is offered, continue leveling and check after C writes."] = "{object:410369} ist eine Kiste bei {area:204} im südlichen Silberwald, direkt südlich von {area:236}. Sieh nach dem Hornauftrag und dem nächsten Brief von C dort nach dem neuen Auftrag. Die Daten nennen mindestens 25, aber Beta-Spieler berichten, die Einladung mit 30 nach dem Hornauftrag und einem Stadtbesuch erhalten zu haben; das ist keine garantierte Poststufe. Wird keine neue Notiz angeboten, level weiter und sieh nach, wenn C schreibt.",

	-- Step 2: The Scarlet Monastery
	-- {area:796} Scarlet Monastery
	["The {area:796}"] = "{area:796}",
	-- {zone:1420} Tirisfal Glades · {npc:4293} Scarlet Scryer · {item:210963} Scryer's Key · {item:210968} Reliquary Key
	["The monastery stands in the far north-east of {zone:1420}. Go in alone. Before entering, find the disguise in the chest by the outside stables. Recheck it after changing wings: stealth and suspicious actions can remove it. In the Graveyard, pickpocket a {npc:4293} for the {item:210963}; use it on the Personal Letterbox in the Library and read the message. It sends you back to sit at both benches between the statues in the graveyard. Watch for the mechanism's messages, take the {item:210968} from the stone coffer, then return to the Library for the locked reliquary. Avoid fighting through the instance."] = "Das Kloster steht im äußersten Nordosten von {zone:1420}. Geh allein hinein. Finde vor dem Eintreten die Verkleidung in der Truhe bei den Ställen draußen. Prüfe sie nach einem Flügelwechsel erneut: Schleichen und verdächtige Handlungen können sie entfernen. Stiehl auf dem Friedhof einem {npc:4293} den {item:210963}; benutze ihn am Persönlichen Briefkasten in der Bibliothek und lies die Nachricht. Sie schickt dich zurück, um dich auf beide Bänke zwischen den Statuen auf dem Friedhof zu setzen. Achte auf die Meldungen des Mechanismus, nimm den {item:210968} aus der Steintruhe und kehre dann in die Bibliothek zum verschlossenen Reliquienschrein zurück. Vermeide es, dich durch die Instanz zu kämpfen.",
	["Solo route: Graveyard key, Library letter, Graveyard benches and coffer, then Library reliquary for the eye. Read the letter before the bench puzzle; check the disguise each time you change wings."] = "Solo-Route: Friedhofsschlüssel, Brief in der Bibliothek, Bänke und Truhe auf dem Friedhof, dann der Reliquienschrein in der Bibliothek für das Auge. Lies den Brief vor dem Bänke-Rätsel; prüfe die Verkleidung bei jedem Flügelwechsel.",

	-- Step 3: Back to the dead drop
	["Back to the dead drop"] = "Zurück zum toten Briefkasten",
	-- {object:410369} Dead Drop
	["Place the eye in the {object:410369} near Pyrewood. Check a capital mailbox for C's payment letter on your next planned city visit, then return here for the reward quest. The payment may not be available immediately; do not repeat the infiltration just because the reward has not appeared."] = "Lege das Auge in {object:410369} bei Pyrewood. Sieh bei deinem nächsten geplanten Stadtbesuch im Briefkasten einer Hauptstadt nach dem Zahlungsbrief von C und kehre dann für die Belohnungsquest hierher zurück. Die Zahlung ist vielleicht nicht sofort da; wiederhole die Infiltration nicht nur, weil die Belohnung noch nicht erschienen ist.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Find the Eye of Bhossca inside the {area:796}."] = "Finde das Auge von Bhossca im Gebiet {area:796}.",
	-- ["Place the eye in the {object:410369} near Pyrewood. C's payment is the second Eye of Bhossca quest at the same chest."] = "Leg das Auge in den {object:410369} nahe Pyrewood. Die Bezahlung von C ist die zweite Quest „Das Auge von Bhossca“ an derselben Truhe.",
	-- ["The monastery stands in the far north-east of {zone:1420}. Go in alone; C advises a disguise from the monastery's grounds before you enter."] = "Das Kloster steht im äußersten Nordosten von {zone:1420}. Geh allein hinein; C rät dir, dich vor dem Betreten auf dem Klostergelände zu verkleiden.",
	-- ["The {object:410369} is a chest near {area:204} in southern Silverpine, just south of {area:236}. C's next note waits there once you are 25."] = "Der {object:410369} ist eine Truhe nahe {area:204} im Süden von Silberwald, direkt südlich von {area:236}. Die nächste Nachricht von C wartet dort, sobald du Stufe 25 bist.",
}
