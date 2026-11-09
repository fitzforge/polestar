-- German (deDE): the guide forever/class/warlock/orb-of-orahil (forever/class/warlock/orb-of-orahil.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Orb of Orahil"] = "Kugel von Orahil",
	["An off-hand orb or a staff for your late 30s, down the felhound's or the infernal's path, your pick."] = "Eine Kugel für die Nebenhand oder ein Stab für Ende 30, über den Weg des Teufelshunds oder der Höllenbestie, deine Wahl.",

	-- Step 1: Knowledge of the Orb of Orahil (Stormwind)
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:461} in the {object:2164}, in the {object:2101}, sends you to {npc:6266} in {area:392}."] = "Mit 35 schickt dich {npc:461} in {object:2164} in {object:2101} zu {npc:6266} in {area:392}.",

	-- Step 2: Knowledge of the Orb of Orahil (Ironforge)
	-- {npc:5172} Briarthorn · {zone:1455} Ironforge · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:5172} in {zone:1455} sends you to {npc:6266} in {area:392}."] = "Mit 35 schickt dich {npc:5172} in {zone:1455} zu {npc:6266} in {area:392}.",

	-- Step 3: Knowledge of the Orb of Orahil (Orgrimmar)
	-- {npc:3326} Zevrost · {object:172960} Cleft of Shadow · {npc:6266} Menara Voidrender · {area:392} Ratchet
	["At 35 {npc:3326} in the {object:172960} sends you to {npc:6266} in {area:392}."] = "Mit 35 schickt dich {npc:3326} in {object:172960} zu {npc:6266} in {area:392}.",

	-- Step 4: Knowledge of the Orb of Orahil (Undercity)
	-- {npc:4563} Kaal Soulreaper · {object:36082} Magic Quarter · {npc:6266} Menara Voidrender · {area:392} Ratchet · {zone:1420} Tirisfal Glades · {zone:1411} Durotar
	["At 35 {npc:4563} in the {object:36082} sends you to {npc:6266} in {area:392}. The zeppelin from {zone:1420} flies to {zone:1411}."] = "Mit 35 schickt dich {npc:4563} in {object:36082} zu {npc:6266} in {area:392}. Der Zeppelin aus {zone:1420} fliegt nach {zone:1411}.",

	-- Step 5: Menara Voidrender
	-- {npc:6266} Menara Voidrender · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:6266} and her two acolytes stand in {npc:6251}'s tower on the hill above {area:392}."] = "{npc:6266} und ihre zwei Akolythen stehen im Turm von {npc:6251} auf dem Hügel über {area:392}.",

	-- Step 6: Choose an acolyte
	["Choose an acolyte"] = "Wähle einen Akolythen",
	-- {npc:6254} Acolyte Wytula · {item:15106} Staff of Dar'Orahil · {npc:6252} Acolyte Magaz · {item:15105} Staff of Noh'Orahil
	["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, the shadow versions; {npc:6252}'s infernal path with the Orb or {item:15105}, much the same items on the fire side. Most warlocks lean on shadow, but compare the four in their tooltips first. The guide follows the one you take. Keep the ruby or the emerald: it is handed back."] = "Such dir einen Akolythen aus: Du kannst nur eine ihrer Quests nehmen. Der Teufelshund-Pfad von {npc:6254} endet mit dem Orb oder {item:15106}, den Schattenversionen; der Höllenbestien-Pfad von {npc:6252} mit dem Orb oder {item:15105}, ziemlich dieselben Gegenstände auf der Feuerseite. Die meisten Hexenmeister setzen auf Schatten, vergleiche aber zuerst die vier in ihren Tooltips. Der Guide folgt dem, den du nimmst. Behalte den Rubin oder den Smaragd: Er wird zurückgegeben.",
	-- {npc:6254} Acolyte Wytula · {item:12647} Felhas Ruby
	["{npc:6254}: she gives you the {item:12647}"] = "{npc:6254}: Sie gibt dir {item:12647}",
	-- {npc:6252} Acolyte Magaz · {item:12646} Infus Emerald
	["{npc:6252}: he gives you the {item:12646}"] = "{npc:6252}: Er gibt dir {item:12646}",

	-- Step 7: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {area:2408} Shadowprey Village · {item:7291} Infernal Orb · {spell:1120} Drain Soul
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Mana Eaters = {npc:4678} Mana Eater · Mage Hunters = {npc:4681} Mage Hunter · Ley Hunters = {npc:4685} Ley Hunter · Lesser Infernals = {npc:4676} Lesser Infernal
	["{area:602} fills south-central {zone:1443}, east of {area:2408}. The Burning Blade Summoners (level 38-39, warlocks with imps) carry the {item:7291} every time. For the spirit, bring your demon to low health with your damage over time, then channel the ruby or the emerald on it and keep channelling while it dies, as with {spell:1120}: the gem does no damage of its own. The ruby works on the coven's felhounds: the two Mana Eaters (37-38) in the north, and the Mage Hunters (38) and Ley Hunters (39) further south. The emerald works on the Lesser Infernals (36-37, sixteen of them, fire-resistant)."] = "{area:602} füllt das südliche Zentrum von {zone:1443}, östlich von {area:2408}. Die Burning Blade Summoners (Stufe 38-39, Hexenmeister mit Wichteln) tragen jedes Mal {item:7291} bei sich. Bring für den Geist deinen Dämon mit deinem Schaden über Zeit auf niedrige Gesundheit, kanalisiere dann den Rubin oder den Smaragd auf ihn und kanalisiere weiter, während er stirbt, wie bei {spell:1120}: Der Edelstein verursacht selbst keinen Schaden. Der Rubin wirkt auf die Teufelshunde des Zirkels: die zwei Mana Eaters (37-38) im Norden und die Mage Hunters (38) und Ley Hunters (39) weiter südlich. Der Smaragd wirkt auf die Lesser Infernals (36-37, sechzehn Stück, feuerresistent).",
	-- {item:7291} Infernal Orb
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner
	["{item:7291}, from the Burning Blade Summoners"] = "{item:7291}, von den Beschwörern der Burning Blade",
	-- {item:12648} Imprisoned Felhound Spirit · {npc:4678} Mana Eater · {npc:4681} Mage Hunter · {npc:4685} Ley Hunter
	["{item:12648}, from a {npc:4678}, {npc:4681} or {npc:4685}"] = "{item:12648}, von {npc:4678}, {npc:4681} oder {npc:4685}",
	-- {item:12649} Imprisoned Infernal Spirit · {npc:4676} Lesser Infernal
	["{item:12649}, from a {npc:4676}"] = "{item:12649}, von einer {npc:4676}",

	-- Step 8: The demon's spirit
	["The demon's spirit"] = "Der Geist des Dämons",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet
	["Back to {npc:6266} in the tower above {area:392} with the spirit and the gem first: her orb follows from it."] = "Zurück zu {npc:6266} im Turm über {area:392} zuerst mit dem Geist und dem Edelstein: Ihre Kugel entsteht daraus.",

	-- Step 9: Tabetha
	-- {npc:6546} Tabetha · {zone:1445} Dustwallow Marsh · {zone:1413} Barrens · {npc:6549} Demon of the Orb · {spell:710} Banish
	["{npc:6546} lives at her farm in the middle of {zone:1445}, south of the road from the {zone:1413} and south-west of Theramore; a spirit healer stands beside it. Deadmire, a level 45 crocolisk, patrols the creeks just north-east. Before you accept Cleansing, clear the spiders and crocolisks around her paddock. Accepting starts a 3-minute timer: she walks to the paddock and lets the {npc:6549} out. It is elite (level 40): grouping up is encouraged; a warlock of about 40 can solo it with Fear or {spell:710} and damage over time, a level 35-38 one brings a friend. The timer keeps running after the kill, so hand in at once. If time runs out, abandon the quest and take it from {npc:6546} again."] = "{npc:6546} lebt auf ihrer Farm mitten in {zone:1445}, südlich der Straße vom {zone:1413} und südwestlich von Theramore; ein Geistheiler steht daneben. Deadmire, ein Krokilisk der Stufe 45, patrouilliert an den Bächen direkt nordöstlich. Bevor du Cleansing annimmst, räum die Spinnen und Krokilisken rund um ihr Gehege. Mit dem Annehmen startet ein 3-Minuten-Timer: Sie geht zum Gehege und lässt {npc:6549} heraus. Er ist ein Elite (Stufe 40): Eine Gruppe wird empfohlen; ein Hexenmeister um Stufe 40 kann ihn mit Furcht oder {spell:710} und Schaden über Zeit solo schaffen, mit Stufe 35-38 nimm einen Freund mit. Der Timer läuft nach dem Kill weiter, gib also sofort ab. Läuft die Zeit ab, brich die Quest ab und nimm sie bei {npc:6546} erneut an.",

	-- Step 10: The Orb of Dar'Orahil
	-- {item:15108} Orb of Dar'Orahil
	["The {item:15108}"] = "{item:15108}",
	-- {npc:6266} Menara Voidrender · {area:392} Ratchet · {item:15108} Orb of Dar'Orahil
	["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, accept her last quest and wait beside her while she completes the {item:15108} (do not attack her: the quest log calls it a kill), then speak to her again and pick the off-hand orb or the staff."] = "Zurück zu {npc:6266} im Turm über {area:392} mit der gereinigten Kugel. Auf dem Teufelshund-Pfad nimm ihre letzte Quest an und warte neben ihr, während sie {item:15108} fertigstellt (greif sie nicht an: Das Questlog zählt es als Kill), sprich sie dann noch einmal an und wähle die Nebenhand-Kugel oder den Stab.",
	-- {npc:6266} Menara Voidrender
	["Wait beside {npc:6266} while she makes the orb"] = "Warte neben {npc:6266}, während sie die Kugel herstellt",

	-- Step 11: The Orb of Noh'Orahil
	-- {item:15107} Orb of Noh'Orahil
	["The {item:15107}"] = "{item:15107}",
	-- {npc:6266} Menara Voidrender · {item:15107} Orb of Noh'Orahil
	["On the infernal path, accept her last quest and wait beside {npc:6266} while she completes the {item:15107}, then speak to her again and pick the off-hand orb or the staff."] = "Auf dem Höllenbestien-Pfad nimm ihre letzte Quest an und warte neben {npc:6266}, während sie {item:15107} fertigstellt, sprich sie dann noch einmal an und wähle die Nebenhand-Kugel oder den Stab.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6266} in the tower above {area:392} with the cleansed orb. On the felhound path, wait while she completes the {item:15108}, then speak to her again."] = "Bring die gereinigte Kugel zurück zu {npc:6266} im Turm über {area:392}. Auf dem Teufelshundweg warte, während sie {item:15108} vollendet, und sprich dann erneut mit ihr.",
	-- ["Back to {npc:6266} in the tower above {area:392} with the spirit first: {npc:6546}'s cleansing follows it."] = "Bring zuerst den Geist zurück zu {npc:6266} im Turm über {area:392}: Danach folgt die Reinigung bei {npc:6546}.",
	-- ["On the infernal path, wait while {npc:6266} completes the {item:15107}, then speak to her again."] = "Auf dem Höllenbestienweg warte, während {npc:6266} {item:15107} vollendet, und sprich dann erneut mit ihr.",
	-- ["Pick one acolyte: you can take only one of their quests. {npc:6254}'s felhound path ends with the Orb or {item:15106}, {npc:6252}'s infernal path with the Orb or {item:15105}. The guide follows the one you take."] = "Wähle einen Akolythen: Du kannst nur eine ihrer Quests annehmen. Der Teufelshundweg von {npc:6254} endet mit der Kugel oder {item:15106}, der Höllenbestienweg von {npc:6252} mit der Kugel oder {item:15105}. Der Guide folgt dem, den du nimmst.",
	-- ["The demons of {area:602}, in southern {zone:1443}, have all you need. Burning Blade Summoners carry the {item:7291}. On the felhound path, use the {item:12647} on a {npc:4678}, a felhound, and kill it for its spirit; on the infernal path, use the {item:12646} on a {npc:4676} and kill it."] = "Die Dämonen in {area:602} im Süden von {zone:1443} haben alles, was du brauchst. Beschwörer der Burning Blade tragen {item:7291}. Auf dem Teufelshundweg benutze {item:12647} an einem {npc:4678}, einem Teufelshund, und töte ihn für seinen Geist; auf dem Höllenbestienweg benutze {item:12646} an einer {npc:4676} und töte sie.",
	-- ["Wait for the orb"] = "Warte auf die Kugel",
	-- ["{item:12648}, from a {npc:4678}"] = "{item:12648}, von einem {npc:4678}",
	-- ["{npc:6266} and her two acolytes stand in the tower on the hill above {area:392}, beside {npc:6251}."] = "{npc:6266} und ihre beiden Akolythen stehen im Turm auf dem Hügel über {area:392}, neben {npc:6251}.",
	-- ["{npc:6546} lives at her farm in western {zone:1445}. She calls the {npc:6549} out of the {item:7291}; it is elite: grouping up is advised."] = "{npc:6546} lebt auf ihrem Hof im Westen von {zone:1445}. Sie ruft {npc:6549} aus {item:7291}; er ist Elite: Eine Gruppe wird empfohlen.",
}
