-- German (deDE): the guide forever/class/mage/celestial-orb (forever/class/mage/celestial-orb.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7515} Celestial Orb
	["{item:7515} and Stave"] = "{item:7515} und Stab",
	["An off-hand orb or a staff for the late 30s, your pick."] = "Eine Schildhand-Kugel oder ein Stab für die späten 30er, nach deiner Wahl.",

	-- Step 1: Return to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497} oben im Wizard's Sanctum, im {object:2101} von {zone:1453}, schickt dich zurück zu {npc:6546}; Bink in {zone:1455} gibt dieselbe Quest.",

	-- Step 2: Return to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, einer der Magierlehrer von {zone:1454} in {object:173161}, schickt dich zurück zu {npc:6546}; {npc:4568} in {zone:1458} und {npc:3048} in {zone:1456} geben dieselbe Quest.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}; come in from the west road, the elites roam its east side."] = "Das Häuschen von {npc:6546} liegt tief im Sumpf westlich von Theramore, direkt nördlich der {area:508}; komm von der Weststraße, die Elite streift über die Ostseite.",

	-- Step 4: The Infernal Orb
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {area:2408} Shadowprey Village · {item:7291} Infernal Orb · {spell:686} Shadow Bolt · {zone:1412} Mulgore · {zone:1456} Thunder Bluff
	-- plural, as words: Burning Blade Summoners = {npc:4668} Burning Blade Summoner · Nether Maidens = {npc:4679} Nether Maiden
	["The Burning Blade Summoners (level 38-39, not elite) work the {area:602} in southern {zone:1443}, east of {area:2408}, and every one carries an {item:7291}. They cast {spell:686} from 40 yards, keep an imp at their side and run for help at low health; Nether Maidens patrol the pillared ruin beside them, so pull with care. Horde mages: one more summoner stands alone in western {zone:1412}, south-west of {zone:1456}."] = "Die Burning Blade Summoners (Stufe 38-39, keine Elite) arbeiten im {area:602} im Süden von {zone:1443}, östlich von {area:2408}, und jeder trägt eine {item:7291}. Sie wirken {spell:686} aus 40 Metern, haben einen Imp an ihrer Seite und holen bei niedriger Gesundheit Hilfe; Nether Maidens patrouillieren in der Säulenruine neben ihnen, also zieh mit Vorsicht. Horde-Magier: Ein weiterer Summoner steht allein im Westen von {zone:1412}, südwestlich von {zone:1456}.",

	-- Step 5: The Exorcism
	-- {npc:6546} Tabetha · {quest:1955} The Exorcism · {npc:6549} Demon of the Orb
	["Back at {npc:6546}'s. Kill the critters around the cottage first: they join the fight. Accepting {quest:1955} starts a 3 minute timer, and {npc:6546} calls the {npc:6549} out in her garden: a level 40 elite that resists many spells, roots and slows. Grouping up is encouraged: a mage of 40 may need help or potions, at about 45 it is soloable. You can pull it from range from the dock. The timer keeps running after it dies, so hand the quest in straight away. If time runs out, abandon the quest and take it again; she calls the demon again."] = "Zurück bei {npc:6546}. Töte zuerst die Kleintiere rund um das Häuschen: Sie schließen sich dem Kampf an. Das Annehmen von {quest:1955} startet einen 3-Minuten-Timer, und {npc:6546} ruft den {npc:6549} in ihrem Garten herbei: eine Elite der Stufe 40, die viele Zauber widersteht, wurzelt und verlangsamt. Sich zu gruppieren wird empfohlen: Ein Magier mit 40 braucht womöglich Hilfe oder Tränke, mit etwa 45 ist er allein machbar. Du kannst ihn vom Steg aus aus der Ferne pullen. Der Timer läuft nach seinem Tod weiter, gib die Quest also sofort ab. Läuft die Zeit ab, brich die Quest ab und nimm sie noch einmal an; sie ruft den Dämon erneut.",
	-- {npc:6549} Demon of the Orb
	["{npc:6549} (elite, 40)"] = "{npc:6549} (Elite, 40)",

	-- Step 6: Power in Uldaman
	-- {area:1517} Uldaman · {zone:1418} Badlands · {area:1898} Dustwind Gulch · {npc:7023} Obsidian Sentinel · {npc:7209} Obsidian Shard
	["{area:1517} is a dungeon in the northern {zone:1418}: a group of five. Go in by the rear entrance, a cave in {area:1898} south-east of the main entrance (elite dragons fly nearby): the {npc:7023} (level 42 elite) stands just past the first door. At 80, 60, 40 and 20 percent it breaks off an {npc:7209}, an elite too; while a shard lives, both reflect targeted spells, so use area spells and your wand on them. A solo trick: step out through the nearby zone line each time a shard appears; the Sentinel heals but keeps shrinking. It always drops the power source, and takes 2 hours to come back."] = "{area:1517} ist ein Dungeon im Norden von {zone:1418}: eine Gruppe aus fünf. Geh durch den Hintereingang, eine Höhle in {area:1898} südöstlich des Haupteingangs (in der Nähe fliegen Elite-Drachen): Der {npc:7023} (Elite der Stufe 42) steht direkt hinter der ersten Tür. Bei 80, 60, 40 und 20 Prozent löst er einen {npc:7209} ab, ebenfalls eine Elite; solange ein Splitter lebt, reflektieren beide gezielte Zauber, also nutze Flächenzauber und deinen Zauberstab gegen sie. Ein Solo-Trick: Tritt jedes Mal, wenn ein Splitter erscheint, durch die nahe Gebietsgrenze nach draußen; der Sentinel heilt sich, schrumpft aber weiter. Er lässt die Energiequelle immer fallen und braucht 2 Stunden, um zurückzukehren.",

	-- Step 7: Mana Surges
	-- {npc:6546} Tabetha · {quest:1957} Mana Surges · {spell:403} Lightning Bolt
	["Back to {npc:6546}. Accepting {quest:1957} opens a rift beside her cottage and starts a 10 minute timer: twelve {quest:1957} (level 40, Shock and {spell:403}) come out about four at a time. Attacking one does not pull the rest. Standing at the edge of the field draws them all; the tree south-west of it is out of their reach but in your spell range. Kill twelve and hand in before the timer runs out."] = "Zurück zu {npc:6546}. Das Annehmen von {quest:1957} öffnet einen Riss neben ihrem Häuschen und startet einen 10-Minuten-Timer: Zwölf {quest:1957} (Stufe 40, Schock und {spell:403}) kommen heraus, etwa vier auf einmal. Einen anzugreifen zieht die anderen nicht mit. Wenn du am Rand des Feldes stehst, lockst du sie alle an; der Baum südwestlich davon ist außerhalb ihrer Reichweite, aber in der Reichweite deiner Zauber. Töte zwölf und gib ab, bevor der Timer abläuft.",
	-- {quest:1958} Celestial Power · {item:7515} Celestial Orb · {item:9517} Celestial Stave
	["{quest:1958}: the {item:7515} (off-hand) or the {item:9517}"] = "{quest:1958}: {item:7515} (Nebenhand) oder {item:9517}",

	-- Step 8: Tabetha's Task (optional)
	-- {quest:2861} Tabetha's Task
	["{quest:2861} (optional)"] = "{quest:2861} (optional)",
	-- {npc:6546} Tabetha · {npc:5497} Jennea Cannon · {npc:4568} Anastasia Hartwell · {npc:5885} Deino · {quest:2861} Tabetha's Task · {quest:2846} Tiara of the Deep · {npc:7795} Hydromancer Velratha · {area:978} Zul'Farrak · {zone:1446} Tanaris · {item:9527} Spellshifter Rod · {item:9531} Gemshale Pauldrons
	["At 40 the mage trainers who send you to {npc:6546} ({npc:5497}, Bink, {npc:4568}, {npc:5885}) also have {quest:2861}, a quest any class can do. {npc:6546} then wants the {quest:2846} from {npc:7795}, a level 46 elite naga in {area:978}, the troll dungeon in north-western {zone:1446}: a group of five, level 44-54. She is one of the bosses by the sacred pool, and the tiara always drops. The reward window shows the {item:9527} and the {item:9531}."] = "Mit Stufe 40 haben die Magierlehrer, die dich zu {npc:6546} schicken ({npc:5497}, Bink, {npc:4568}, {npc:5885}), auch {quest:2861}, eine Quest, die jede Klasse machen kann. {npc:6546} will dann {quest:2846} von {npc:7795}, einer Naga-Elite der Stufe 46 in {area:978}, dem Troll-Dungeon im Nordwesten von {zone:1446}: eine Gruppe aus fünf, Stufe 44-54. Sie ist einer der Bosse beim heiligen Teich, und die Tiara fällt immer. Im Belohnungsfenster siehst du {item:9527} und {item:9531}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}. She opens a mana rift beside her cottage: kill twelve {quest:1957} within ten minutes."] = "Zurück zu {npc:6546}. Sie öffnet neben ihrer Hütte einen Manariss: Töte innerhalb von zehn Minuten zwölf {quest:1957}.",
	-- ["The Burning Blade Summoners work the {area:602} in southern {zone:1443}; any of them carries an {item:7291}."] = "Die Beschwörer der Burning Blade treiben im {area:602} im Süden von {zone:1443} ihr Werk; jeder von ihnen trägt eine {item:7291}.",
	-- ["{area:1517} is a dungeon in the northern {zone:1418}, by the {object:178824}: a group of five. Defeat the {npc:7023} inside for its power source."] = "{area:1517} ist ein Dungeon im Norden des {zone:1418} beim {object:178824}: eine Gruppe für fünf. Besiege drinnen {npc:7023} für seine Energiequelle.",
	-- ["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you back to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497} im Wizard's Sanctum im {object:2101} von {zone:1453} schickt dich zurück zu {npc:6546}; Bink in {zone:1455} gibt dieselbe Quest.",
	-- ["{npc:5885}, one of {zone:1454}'s mage trainers, sends you back to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, einer der Magierlehrer von {zone:1454}, schickt dich zurück zu {npc:6546}; {npc:4568} in {zone:1458} und {npc:3048} in {zone:1456} geben dieselbe Quest.",
	-- ["{npc:6546} draws the demon out of the orb beside her cottage. The {npc:6549} is elite: grouping up is advised. You have three minutes before it slips back into the orb."] = "{npc:6546} zieht den Dämon neben ihrer Hütte aus der Kugel. {npc:6549} ist Elite: Eine Gruppe wird empfohlen. Du hast drei Minuten, bevor er in die Kugel zurückschlüpft.",
	-- ["{npc:6546}'s cottage is deep in the marsh west of Theramore, just north of the {area:508}."] = "Die Hütte von {npc:6546} liegt tief im Marschland westlich von Theramore, knapp nördlich der {area:508}.",
}
