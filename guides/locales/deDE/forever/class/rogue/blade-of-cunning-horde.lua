-- German (deDE): the guide forever/class/rogue/blade-of-cunning-horde (forever/class/rogue/blade-of-cunning-horde.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Horde)"] = "{item:7298} (Horde)",
	["A dagger at 10 from your home town's rogue quests."] = "Ein Dolch mit Stufe 10 aus den Schurkenquests deiner Heimatstadt.",

	-- Step 1: Therzok
	-- {npc:3170} Kaplak · {area:362} Razor Hill · {quest:1859} Therzok · {zone:1454} Orgrimmar · {quest:1963} The Shattered Hand
	["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}. It is only a pointer: an Orc already in {zone:1454} can skip it and take {quest:1963} from {quest:1859} straight away."] = "Mit 10 schickt dich {npc:3170}, der Schurkenlehrer in {area:362}, zu {quest:1859} in {zone:1454}. Es ist nur ein Hinweis: Ein Orc, der schon in {zone:1454} ist, kann ihn überspringen und {quest:1963} direkt von {quest:1859} annehmen.",

	-- Step 2: The Shattered Hand
	-- {quest:1859} Therzok · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength · {quest:1963} The Shattered Hand
	["{quest:1859} stands in the {object:172960}, the canyon under the {object:172982}. Trolls: take {quest:1963} from him at 10."] = "{quest:1859} steht in {object:172960}, der Schlucht unter {object:172982}. Trolle: Nehmt mit 10 {quest:1963} bei ihm an.",

	-- Step 3: Tazan
	-- {npc:6494} Tazan · {area:391} Merchant Coast · {area:392} Ratchet
	["{npc:6494} (level 13, not elite) is a troll pirate on the {area:391} south of {area:392}: he walks the fenced hill path between the lower pirate camp by the beached ship and the upper camp by a big tree. Fight him at the foot of the hill, away from the camps. He always drops his satchel and is back 4 1/2 minutes after a death; one satchel per kill, so two rogues need two kills. Hand the satchel in unopened: picking its lock now destroys it and you must kill him again."] = "{npc:6494} (Stufe 13, nicht Elite) ist ein Troll-Pirat an der {area:391} südlich von {area:392}: Er läuft auf dem eingezäunten Hügelpfad zwischen dem unteren Piratenlager am gestrandeten Schiff und dem oberen Lager an einem großen Baum. Kämpfe am Fuß des Hügels gegen ihn, abseits der Lager. Er lässt seine Tasche immer fallen und ist 4 1/2 Minuten nach einem Tod zurück; eine Tasche pro Kill, zwei Schurken brauchen also zwei Kills. Gib die Tasche ungeöffnet ab: Wird ihr Schloss jetzt geknackt, wird sie zerstört, und du musst ihn erneut töten.",

	-- Step 4: Back to Therzok
	-- {npc:6446} Therzok
	["Back to {npc:6446}"] = "Zurück zu {npc:6446}",

	-- Step 5: Tazan's Key
	-- {quest:1859} Therzok · {npc:6466} Gamon · {object:172982} Valley of Strength · {item:7208} Tazan's Key · {item:7209} Tazan's Satchel · {spell:1804} Pick Lock
	["{quest:1859} hands the satchel back: now open it. {npc:6466} (level 12) kneels by the innkeeper in the inn in the {object:172982}; stealth up and pick his pocket for {item:7208} (do not kill him: the key almost never drops). Players often kill him, so you may wait up to 5 minutes for him. Then use the key on {item:7209} in your bags. If you have trained {spell:1804}, you can pick the satchel's lock instead."] = "{quest:1859} gibt die Tasche zurück: Öffne sie jetzt. {npc:6466} (Stufe 12) kniet beim Gastwirt im Gasthaus im {object:172982}; schleiche dich heran und bestiehl ihn für {item:7208} (töte ihn nicht: Der Schlüssel fällt fast nie). Spieler töten ihn oft, du musst also bis zu 5 Minuten auf ihn warten. Benutze den Schlüssel dann an {item:7209} in deinen Taschen. Wenn du {spell:1804} gelernt hast, kannst du stattdessen das Schloss der Tasche knacken.",
	-- {item:7208} Tazan's Key
	["Pick Pocket Gamon for {item:7208}"] = "Bestiehl Gamon und erhalte {item:7208}",
	-- {item:7209} Tazan's Satchel
	["{item:7209}, once you have the key"] = "{item:7209}, sobald du den Schlüssel hast",
	-- {item:7295} Tazan's Logbook
	["{item:7295}, from the satchel"] = "{item:7295}, aus der Tasche",

	-- Step 6: Therzok's reward
	-- {npc:6446} Therzok
	["{npc:6446}'s reward"] = "Belohnung von {npc:6446}",

	-- Step 7: Mennet Carkad
	-- {npc:2130} Marion Call · {area:2119} Gallows' End Tavern · {area:159} Brill · {quest:1885} Mennet Carkad · {zone:1458} Undercity
	["At 10 {npc:2130}, the rogue trainer upstairs in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "Mit 10 schickt dich {npc:2130}, die Schurkenlehrerin oben in der {area:2119} in {area:159}, zu {quest:1885} in der {zone:1458}.",

	-- Step 8: The Rogues' Quarter
	-- {object:36073} Rogues' Quarter
	["The {object:36073}"] = "{object:36073}",
	-- {quest:1885} Mennet Carkad · {object:36073} Rogues' Quarter
	["{quest:1885} stands in the {object:36073}."] = "{quest:1885} steht in {object:36073}.",

	-- Step 9: Astor Hadren
	-- {npc:6497} Astor Hadren · {area:228} Sepulcher · {zone:1458} Undercity
	["{npc:6497} (level 13) walks the road between the {area:228} and the {zone:1458}, north of the {area:228}. He looks like a friendly traveller with no quest mark. Talk to him and pick both of his answers: he turns hostile. Kill him for the letter (it always drops). Fight him away from guards, who can take the kill and leave no loot; only one rogue per kill gets the letter. He is back 5 minutes after a death."] = "{npc:6497} (Stufe 13) geht auf der Straße zwischen {area:228} und der {zone:1458} entlang, nördlich von {area:228}. Er sieht aus wie ein freundlicher Reisender ohne Questzeichen. Sprich ihn an und wähle beide seiner Antworten: Er wird feindselig. Töte ihn für den Brief (er fällt immer). Kämpfe abseits von Wachen, die den Kill übernehmen können, ohne dass Beute übrig bleibt; nur ein Schurke pro Kill erhält den Brief. Er ist 5 Minuten nach einem Tod zurück.",

	-- Step 10: Back to Mennet Carkad
	-- {npc:6467} Mennet Carkad
	["Back to {npc:6467}"] = "Zurück zu {npc:6467}",

	-- Step 11: Andron Gant
	-- {npc:6522} Andron Gant
	["{npc:6522} is in the Apothecarium, in its biggest room, where two huge guards watch a small bridge. His ledger is on the bookshelf in the back room behind him, not the shelf on the wall next to him."] = "{npc:6522} ist im Apothekarium, in dessen größtem Raum, wo zwei riesige Wachen eine kleine Brücke bewachen. Sein Hauptbuch liegt im Regal im Hinterzimmer hinter ihm, nicht in dem Regal an der Wand neben ihm.",

	-- Step 12: Mennet Carkad and Varimathras
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras
	["{npc:6467} and {npc:2425}"] = "{npc:6467} und {npc:2425}",
	-- {npc:6467} Mennet Carkad · {npc:2425} Varimathras · {object:36126} Royal Quarter · {npc:6522} Andron Gant
	["{npc:6467} sends the ledger on to {npc:2425}, the big demon in the middle of the Hall of the Dark Lady in the {object:36126}, past its elite guards; the way in is the passage off the Apothecarium. If you lose the ledger, take another from {npc:6522}'s bookshelf."] = "{npc:6467} schickt das Hauptbuch weiter an {npc:2425}, den großen Dämon mitten in der Hall of the Dark Lady im {object:36126}, vorbei an seinen Elite-Wachen; der Weg hinein ist der Gang vom Apothekarium aus. Wenn du das Hauptbuch verlierst, nimm ein anderes aus dem Regal von {npc:6522}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:2130}, the rogue trainer in the {area:2119} in {area:159}, sends you to {quest:1885} in the {zone:1458}."] = "Mit 10 schickt dich {npc:2130}, der Schurkenlehrer in {area:2119} in {area:159}, zu {quest:1885} in {zone:1458}.",
	-- ["At 10 {npc:3170}, the rogue trainer in {area:362}, sends you to {quest:1859} in {zone:1454}."] = "Mit 10 schickt dich {npc:3170}, der Schurkenlehrer in {area:362}, zu {quest:1859} in {zone:1454}.",
	-- ["Tazan"] = "Tazan",
	-- ["{item:7208}: Gamon"] = "{item:7208}: Gamon",
	-- ["{item:7209}: Tazan"] = "{item:7209}: Tazan",
	-- ["{npc:6466} drinks in the inn in the {object:172982}. Pick his pocket for {item:7208}, then open {item:7209}."] = "{npc:6466} trinkt im Gasthaus im {object:172982}. Bestiehl ihn um {item:7208} und öffne dann {item:7209}.",
	-- ["{npc:6467} sends the ledger on to {npc:2425} in the Hall of the Dark Lady, the {object:36126}."] = "{npc:6467} schickt das Geschäftsbuch weiter an {npc:2425} in der Halle der Dunklen Fürstin, {object:36126}.",
	-- ["{npc:6494} stands on the {zone:1413} coast south of {area:392}. Kill him for his satchel."] = "{npc:6494} steht an der Küste von {zone:1413} südlich von {area:392}. Töte ihn für seine Tasche.",
	-- ["{npc:6497} stands north-east of the {area:228}. Take his Letter of Introduction from him."] = "{npc:6497} steht nordöstlich von {area:228}. Nimm sein Vorstellungsschreiben von ihm entgegen.",
	-- ["{npc:6522}'s ledger sits on the bookshelf beside him."] = "Das Geschäftsbuch von {npc:6522} liegt im Bücherregal neben ihm.",
}
