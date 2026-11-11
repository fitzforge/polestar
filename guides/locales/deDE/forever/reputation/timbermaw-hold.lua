-- German (deDE): the guide forever/reputation/timbermaw-hold (forever/reputation/timbermaw-hold.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Timbermaw Hold Reputation"] = "Ruf: Holzschlundfeste",
	["Safe passage through the tunnels, agility enchants and furbolg recipes; the trinket at Exalted."] = "Sicherer Durchgang durch die Tunnel, Verzauberungen für Beweglichkeit und Furbolg-Rezepte; das Schmuckstück bei Ehrfürchtig.",
	["Recipes for Leatherworkers, Tailors, Enchanters and Alchemists from Friendly to Revered"] = "Rezepte für Lederer, Schneider, Verzauberer und Alchemisten von Freundlich bis Respektvoll",

	-- Step 1: Grazle
	-- {faction:576} Timbermaw Hold · {npc:11554} Grazle · {npc:15395} Nafien · {npc:11556} Salfa · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["{faction:576} starts at Hostile (2,500 of 3,000), so its furbolgs attack you in their tunnels; {npc:11554}, {npc:15395} and {npc:11556} talk to everyone. {npc:11554} waits by the road in the south of {zone:1448}, near the {area:2479}. Every Deadwood and Winterfall furbolg you kill gives 5 reputation up to the last point of Honored, so the quests below pay twice. The Legacy perk Diplomat adds up to 10% to every gain."] = "{faction:576} beginnt bei Feindselig (2.500 von 3.000), ihre Furbolgs greifen dich also in ihren Tunneln an; {npc:11554}, {npc:15395} und {npc:11556} reden mit jedem. {npc:11554} wartet an der Straße im Süden von {zone:1448}, nahe {area:2479}. Jeder Deadwood- und Winterquell-Furbolg, den du tötest, gibt 5 Ruf bis zum letzten Punkt von Wohlwollend, die Quests unten zahlen also doppelt. Der Vermächtnis-Vorteil „Diplomat“ fügt jedem Gewinn bis zu 10% hinzu.",

	-- Step 2: Deadwood Village
	-- {zone:1448} Felwood · {item:21377} Deadwood Headdress Feather · {npc:9464} Overlord Ror · {npc:14342} Ragepaw
	["The Deadwood furbolgs (level 48-50) hold the village at the south end of {zone:1448}. Keep every {item:21377}: they are worth 10 reputation each later and never stop counting. {npc:9464} (15 reputation) and the rare {npc:14342} (25) live here and count until Exalted. Forever pays quests in full at any level; in Classic grey mobs gave about a fifth, about 1 a kill for these furbolgs at 60. Do it while leveling if you can."] = "Die Deadwood-Furbolgs (Stufe 48-50) halten das Dorf am Südende von {zone:1448}. Behalte jedes {item:21377}: Sie sind später je 10 Ruf wert und hören nie auf zu zählen. {npc:9464} (15 Ruf) und der seltene {npc:14342} (25) leben hier und zählen bis Ehrfürchtig. Forever zahlt Quests auf jeder Stufe voll; in Classic gaben graue Gegner etwa ein Fünftel, bei diesen Furbolgs auf 60 etwa 1 pro Kill. Mach es beim Leveln, wenn du kannst.",
	-- {npc:14342} Ragepaw
	["{npc:14342}, rare"] = "{npc:14342}, selten",

	-- Step 3: Back to Grazle
	-- {npc:11554} Grazle
	["Back to {npc:11554}"] = "Zurück zu {npc:11554}",

	-- Step 4: Nafien
	-- {npc:15395} Nafien · {zone:1448} Felwood
	["{npc:15395} stands at the {zone:1448} mouth of the Timbermaw tunnel, at the top of the road in the north of {zone:1448}."] = "{npc:15395} steht an der Mündung des Holzschlund-Tunnels auf der Seite von {zone:1448}, oben an der Straße im Norden von {zone:1448}.",

	-- Step 5: Felpaw Village
	-- {npc:9462} Chieftain Bloodmaw
	["The northern Deadwood (level 53-55) camp just south of the tunnel. They drop feathers about half the time: the best feather spot. {npc:9462} gives 15 until Exalted."] = "Das nördliche Deadwood-Lager (Stufe 53-55) knapp südlich des Tunnels. Sie lassen Federn etwa jedes zweite Mal fallen: die beste Stelle für Federn. {npc:9462} gibt 15 bis Ehrfürchtig.",

	-- Step 6: Back to Nafien
	-- {npc:15395} Nafien
	["Back to {npc:15395}"] = "Zurück zu {npc:15395}",
	-- {quest:8460} Timbermaw Ally
	["These quests and their kills bring you just past Unfriendly (500 from the start). If {quest:8460} paid you less (at level 60 in Classic: 30), kill about 40 more northern Deadwood. From Unfriendly the Timbermaw in the tunnel leave you alone."] = "Diese Quests und ihre Kills bringen dich knapp über Unfreundlich (500 vom Start). Zahlte dir {quest:8460} weniger (auf Stufe 60 in Classic: 30), töte etwa 40 weitere nördliche Deadwood. Ab Unfreundlich lassen dich die Holzschlunds im Tunnel in Ruhe.",

	-- Step 7: Salfa
	-- {zone:1452} Winterspring · {npc:11556} Salfa
	["Walk through the tunnel to its {zone:1452} mouth; {npc:11556} stands just outside. Do not attack any Timbermaw: each one costs 25 reputation."] = "Geh durch den Tunnel zu seiner Mündung bei {zone:1452}; {npc:11556} steht gleich draußen. Greife keinen Holzschlund an: Jeder kostet 25 Ruf.",

	-- Step 8: Winterfall Village
	-- {area:2244} Winterfall Village · {zone:1452} Winterspring · {area:2255} Everlook · {item:21383} Winterfall Spirit Beads · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall
	["{area:2244} lies in the east of {zone:1452}, just past {area:2255}. Keep every {item:21383} you loot (10 reputation each later). The Shamans, Den Watchers and Ursas share their spawn points, so kill every furbolg in the village to make the ones you need appear; more Ursas walk the ridge just south-west of the village. {npc:10199} (rare) and {npc:10738}, in the cave at the back, give 25 until Exalted. Alliance: the Wintersaber Trainers' Winterfall Intrusion asks for the same Shamans and Ursas."] = "{area:2244} liegt im Osten von {zone:1452}, direkt hinter {area:2255}. Behalte jedes {item:21383}, das du plünderst (später je 10 Ruf). Die Schamanen, Den Watchers und Ursas teilen ihre Spawnpunkte, töte also jeden Furbolg im Dorf, damit die, die du brauchst, erscheinen; weitere Ursas laufen auf dem Kamm südwestlich des Dorfes. {npc:10199} (selten) und {npc:10738}, in der Höhle im hinteren Teil, geben 25 bis Ehrfürchtig. Allianz: Winterfall Intrusion der Wintersäblerausbilder verlangt dieselben Schamanen und Ursas.",
	-- {npc:10199} Grizzle Snowpaw
	["{npc:10199}, rare"] = "{npc:10199}, selten",
	-- {npc:10738} High Chief Winterfall
	["{npc:10738}, elite"] = "{npc:10738}, Elite",

	-- Step 9: Back to Salfa
	-- {npc:11556} Salfa
	["Back to {npc:11556}"] = "Zurück zu {npc:11556}",
	-- {quest:8466} Feathers for Grazle · {quest:8467} Feathers for Nafien · {quest:8469} Beads for Salfa
	["{quest:8466}, {quest:8467} and {quest:8469} are open now: 50 reputation for 5 feathers or 5 beads, as often as you like. Do not hand them in yet."] = "{quest:8466}, {quest:8467} und {quest:8469} sind jetzt offen: 50 Ruf für 5 Federn oder 5 Perlen, beliebig oft. Gib sie noch nicht ab.",

	-- Step 10: Unfriendly to Neutral
	["Unfriendly to Neutral"] = "Unfreundlich bis Neutral",
	-- {zone:1448} Felwood · {area:2246} Frostfire Hot Springs · {area:2243} Timbermaw Post · {npc:11556} Salfa · {area:2244} Winterfall Village
	["Unfriendly to Neutral is 3,000: about 540 more kills after these quests. Three camps: the northern Deadwood by the {zone:1448} mouth of the tunnel; the Winterfall camps around {area:2246} and {area:2243}, just south and south-east of {npc:11556} (Pathfinders give 6 a kill, Den Watchers and Totemics 5, the shortest walk to a turn-in); and {area:2244} in the east. Pick the least crowded. Keep all feathers and beads."] = "Von Unfreundlich bis Neutral sind es 3.000: nach diesen Quests etwa 540 weitere Kills. Drei Lager: das nördliche Deadwood an der Mündung des Tunnels bei {zone:1448}; die Winterquell-Lager um {area:2246} und {area:2243}, knapp südlich und südöstlich von {npc:11556} (Pathfinders geben 6 pro Kill, Den Watchers und Totemics 5, der kürzeste Weg zu einer Abgabe); und {area:2244} im Osten. Such dir das am wenigsten überfüllte aus. Behalte alle Federn und Perlen.",
	-- plural, as words: Deadwood Headdress Feathers = {item:21377} Deadwood Headdress Feather
	["Deadwood Headdress Feathers: keep them"] = "Deadwood Headdress Feathers: behalte sie",
	-- {item:21383} Winterfall Spirit Beads
	["{item:21383}: keep them"] = "{item:21383}: behalte sie",
	-- {area:2246} Frostfire Hot Springs
	-- plural, as words: Winterfall Pathfinders = {npc:7442} Winterfall Pathfinder
	["Winterfall Pathfinders, {area:2246}"] = "Winterquell-Pathfinders, {area:2246}",

	-- Step 11: Deadwood Ritual Totem
	-- {quest:8470} Deadwood Ritual Totem · {npc:11558} Kernda · {zone:1448} Felwood
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The northern Deadwood rarely drop a {quest:8470} (about 3%). From Neutral, {npc:11558} takes it in the tunnel, on the {zone:1448} side: 150 reputation and two Major Healing and Mana Potions."] = "Das nördliche Deadwood lässt selten eine {quest:8470} fallen (etwa 3%). Ab Neutral nimmt {npc:11558} sie im Tunnel auf der Seite von {zone:1448} an: 150 Ruf und zwei Große Heil- und Manatränke.",

	-- Step 12: Winterfall Ritual Totem
	-- {quest:8471} Winterfall Ritual Totem · {npc:11558} Kernda
	-- plural, as words: Mana Potions = {item:3827} Mana Potion
	["The Winterfall furbolgs rarely drop a {quest:8471} (3-4%). {npc:11558} takes it in the tunnel too: 150 reputation and three Major Healing and Mana Potions."] = "Die Winterquell-Furbolgs lassen selten eine {quest:8471} fallen (3-4%). {npc:11558} nimmt sie ebenfalls im Tunnel an: 150 Ruf und drei Große Heil- und Manatränke.",

	-- Step 13: Neutral to Friendly
	["Neutral to Friendly"] = "Neutral bis Freundlich",
	["Neutral to Friendly is 3,000: 600 kills. Keep all feathers and beads."] = "Von Neutral bis Freundlich sind es 3.000: 600 Kills. Behalte alle Federn und Perlen.",

	-- Step 14: Meilosh
	-- {npc:11557} Meilosh · {zone:1448} Felwood · {item:13484} Recipe: Transmute Earth to Water · {item:22392} Formula: Enchant 2H Weapon - Agility · {item:20253} Pattern: Warbear Harness · {item:15065} Warbear Woolies · {quest:6031} Runecloth · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["{npc:11557} stands in the tunnel, near its {zone:1448} mouth. From Friendly he sells: {item:13484} (1 gold 50 silver), {item:22392} (2 gold 50 silver), {item:20253} (1 gold 60 silver) and {item:15065} (2 gold). He also takes 30 {quest:6031} once for 100 reputation and a choice of shoulders or gauntlets, and Tailors with skill 290 can bring him 2 {item:14342} for 100 more and the {item:15802} pattern."] = "{npc:11557} steht im Tunnel, nahe der Mündung bei {zone:1448}. Ab Freundlich verkauft er: {item:13484} (1 Gold 50 Silber), {item:22392} (2 Gold 50 Silber), {item:20253} (1 Gold 60 Silber) und {item:15065} (2 Gold). Er nimmt außerdem einmalig 30 {quest:6031} für 100 Ruf und die Wahl zwischen Schultern oder Handschuhen, und Schneider mit Fertigkeit 290 können ihm 2 {item:14342} für 100 mehr und das Muster {item:15802} bringen.",

	-- Step 15: Runecloth for Meilosh
	-- {quest:6031} Runecloth · {npc:11557} Meilosh
	["{quest:6031} for {npc:11557}"] = "{quest:6031} für {npc:11557}",
	-- {quest:6031} Runecloth
	["{quest:6031} drops from the humanoids of the level 50-60 zones, the Deadwood and Winterfall furbolgs among them."] = "{quest:6031} fällt von den Humanoiden der Zonen der Stufen 50-60, darunter die Deadwood- und Winterquell-Furbolgs.",

	-- Step 16: Sacred Cloth
	-- {npc:11557} Meilosh · {item:14342} Mooncloth · {item:15802} Mooncloth Boots
	["Tailors with skill 290: {npc:11557} takes 2 {item:14342} once for 100 reputation and teaches the {item:15802}."] = "Schneider mit Fertigkeit 290: {npc:11557} nimmt einmalig 2 {item:14342} für 100 Ruf an und lehrt das {item:15802}.",

	-- Step 17: Friendly to Honored
	["Friendly to Honored"] = "Freundlich bis Wohlwollend",
	-- {npc:11557} Meilosh · {item:19445} Formula: Enchant Weapon - Agility · {item:19202} Pattern: Heavy Timbermaw Belt · {item:19044} Might of the Timbermaw · {skill:165} Leatherworking · {item:19047} Wisdom of the Timbermaw · {skill:197} Tailoring
	["Friendly to Honored is 6,000: 1,200 kills. Keep all feathers and beads. Honored opens at {npc:11557}: {item:19445} (3 gold), and for 2 gold 20 silver each {item:19202} and {item:19044} ({skill:165}) and {item:19047} ({skill:197})."] = "Von Freundlich bis Wohlwollend sind es 6.000: 1.200 Kills. Behalte alle Federn und Perlen. Wohlwollend öffnet bei {npc:11557}: {item:19445} (3 Gold), und für je 2 Gold 20 Silber {item:19202} und {item:19044} ({skill:165}) und {item:19047} ({skill:197}).",

	-- Step 18: Honored to Revered
	["Honored to Revered"] = "Wohlwollend bis Respektvoll",
	["Honored to Revered is 12,000: 2,400 kills, the last ones that count. Kills stop at 11,999 of 12,000 Honored and never tip you into Revered: when they stop, hand in one set of 5 feathers or beads to cross over. Saving every feather and bead pays off now: about 4,800 kills from the start to the end of Honored leave you with about 2,100 feathers and beads, and that is all of Revered to Exalted. Turning them in early would cost you about 2,400 more kills."] = "Von Wohlwollend bis Respektvoll sind es 12.000: 2.400 Kills, die letzten, die zählen. Kills hören bei 11.999 von 12.000 Wohlwollend auf und kippen dich nie in Respektvoll: Wenn sie aufhören, gib einen Satz von 5 Federn oder Perlen ab, um hinüberzukommen. Jetzt zahlt es sich aus, jede Feder und jede Perle aufgehoben zu haben: etwa 4.800 Kills vom Start bis zum Ende von Wohlwollend lassen dir etwa 2.100 Federn und Perlen, und das ist ganz Respektvoll bis Ehrfürchtig. Sie früh abzugeben würde dich etwa 2.400 Kills mehr kosten.",
	-- {item:19445} Formula: Enchant Weapon - Agility · {skill:333} Enchanting
	["{item:19445} ({skill:333}), 3 gold"] = "{item:19445} ({skill:333}), 3 Gold",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: once your kills stop, 5 feathers into Revered"] = "{quest:8467}: sobald deine Kills aufhören, 5 Federn bis Respektvoll",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: or 5 beads"] = "{quest:8469}: oder 5 Perlen",

	-- Step 19: Revered to Exalted
	["Revered to Exalted"] = "Respektvoll bis Ehrfürchtig",
	-- {npc:15395} Nafien · {npc:11554} Grazle · {npc:11556} Salfa · {npc:14342} Ragepaw · {npc:10199} Grizzle Snowpaw · {npc:10738} High Chief Winterfall · {npc:11557} Meilosh · {item:19204} Pattern: Heavy Timbermaw Boots · {item:19049} Timbermaw Brawlers · {skill:165} Leatherworking · {item:19050} Mantle of the Timbermaw · {skill:197} Tailoring
	["Kills stopped at the end of Honored. Revered to Exalted is 21,000: 420 turn-ins, 2,100 feathers and beads. Hand in the feathers to {npc:15395} at the tunnel or {npc:11554} in the south, the beads to {npc:11556}, five at a time. The named furbolgs (Ror, Bloodmaw, {npc:14342}, {npc:10199}, {npc:10738}) still count. Revered opens at {npc:11557}, for 4 gold each: {item:19204} and {item:19049} ({skill:165}) and {item:19050} ({skill:197})."] = "Die Kills haben am Ende von Wohlwollend aufgehört. Von Respektvoll bis Ehrfürchtig sind es 21.000: 420 Abgaben, 2.100 Federn und Perlen. Gib die Federn bei {npc:15395} am Tunnel oder {npc:11554} im Süden ab, die Perlen bei {npc:11556}, je fünf auf einmal. Die benannten Furbolgs (Ror, Bloodmaw, {npc:14342}, {npc:10199}, {npc:10738}) zählen weiter. Respektvoll öffnet bei {npc:11557}, für je 4 Gold: {item:19204} und {item:19049} ({skill:165}) und {item:19050} ({skill:197}).",
	-- {quest:8467} Feathers for Nafien
	["{quest:8467}: 5 feathers, 50 reputation"] = "{quest:8467}: 5 Federn, 50 Ruf",
	-- {quest:8466} Feathers for Grazle
	["{quest:8466}: 5 feathers, 50 reputation"] = "{quest:8466}: 5 Federn, 50 Ruf",
	-- {quest:8469} Beads for Salfa
	["{quest:8469}: 5 beads, 50 reputation"] = "{quest:8469}: 5 Perlen, 50 Ruf",

	-- Step 20: The Root of All Evil
	-- {npc:11555} Gorn One Eye · {npc:11557} Meilosh · {quest:8481} The Root of All Evil · {item:21144} Demon Summoning Torch · {npc:10738} High Chief Winterfall · {npc:15623} Xandivious · {item:21326} Defender of the Timbermaw
	["At Exalted, {npc:11555}, in the tunnel by {npc:11557}, gives {quest:8481}: plant his {item:21144} in the mouth of {npc:10738}'s cave and defeat the demon {npc:15623} (level 62, elite: bring a group). The reward is {item:21326}, a trinket that calls a Timbermaw ally, and 200 reputation."] = "Bei Ehrfürchtig gibt dir {npc:11555}, im Tunnel bei {npc:11557}, {quest:8481}: Pflanze seine {item:21144} in die Mündung der Höhle von {npc:10738} und besiege den Dämon {npc:15623} (Stufe 62, Elite: bring eine Gruppe mit). Die Belohnung ist {item:21326}, ein Schmuckstück, das einen Verbündeten der Holzschlunds ruft, und 200 Ruf.",

	-- Step 21: Xandivious
	-- {area:2244} Winterfall Village · {npc:15623} Xandivious
	["{area:2244}, the cave at the back. Clear the furbolgs around the mouth first, plant the torch, kill {npc:15623} and loot the Essence from his Demon Bag."] = "{area:2244}, die Höhle im hinteren Teil. Räume zuerst die Furbolgs um die Mündung, pflanze die Fackel, töte {npc:15623} und plündere die Essenz aus seinem Dämonenbeutel.",
	-- {npc:15623} Xandivious
	["{npc:15623}, 25 reputation"] = "{npc:15623}, 25 Ruf",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Alternate Deadwood feathers ({npc:15395}) and Winterfall beads ({npc:11556}), whichever camp is less crowded."] = "Wechsle zwischen Federn der Totenwaldfelle ({npc:15395}) und Perlen der Winterfelle ({npc:11556}), je nachdem, welches Lager weniger voll ist.",
	-- ["Deadwood furbolgs (level 48-50) camp at the southern end of {zone:1448}. Keep every {item:21377} they drop: {npc:11554} and {npc:15395} take them later."] = "Furbolgs der Totenwaldfelle (Stufe 48-50) lagern am Südende des Gebiets {zone:1448}. Behalte jede {item:21377}, die sie fallen lassen: {npc:11554} und {npc:15395} nehmen sie später.",
	-- ["Feathers and beads to Friendly"] = "Federn und Perlen bis Freundlich",
	-- ["Feathers for {npc:11554} and Feathers for {npc:15395} (Deadwood Headdress Feathers) and Beads for {npc:11556} ({item:21383}) repeat as often as you like; every Deadwood or Winterfall kill counts as well. {area:2244} is the densest bead spot."] = "Federn für {npc:11554} und Federn für {npc:15395} (Kopfputzfedern der Totenwaldfelle) sowie Perlen für {npc:11556} ({item:21383}) lassen sich beliebig oft wiederholen; jeder Kill an Totenwaldfellen oder Winterfellen zählt auch. Im {area:2244} gibt es die meisten Perlen.",
	-- ["Feathers to Honored"] = "Federn bis Wohlwollend",
	-- ["Go through {faction:576} to its {zone:1452} exit; {npc:11556} stands just outside. The quests and kills so far usually reach Unfriendly, and then the Timbermaw let you pass. If they still show red, kill more Deadwood by the tunnel first."] = "Geh durch die {faction:576} zum Ausgang nach {zone:1452}; {npc:11556} steht gleich draußen. Die bisherigen Quests und Kills reichen meist für Unfreundlich, dann lassen dich die Furbolgs der Holzschlundfeste durch. Sind sie noch rot, töte zuerst mehr Totenwaldfelle am Tunnel.",
	-- ["Keep turning in feathers and beads until Exalted."] = "Gib weiter Federn und Perlen ab, bis Ehrfürchtig.",
	-- ["The northern Deadwood (level 53-55) hold the camps just south of the tunnel. Keep their feathers too."] = "Die nördlichen Totenwaldfelle (Stufe 53-55) halten die Lager gleich südlich des Tunnels. Behalte auch ihre Federn.",
	-- ["The northern Deadwood camps by the tunnel are the densest feather spot (35% drop chance there). Hand feathers to {npc:15395} at the tunnel, or to {npc:11554} in the south."] = "Die nördlichen Lager der Totenwaldfelle am Tunnel sind der beste Ort für Federn (dort 35 % Dropchance). Gib die Federn bei {npc:15395} am Tunnel oder bei {npc:11554} im Süden ab.",
	-- ["{area:2244} sits on the eastern side of {zone:1452}. Keep every {item:21383} you loot: {npc:11556} takes them."] = "Das {area:2244} liegt auf der Ostseite von {zone:1452}. Behalte alle {item:21383}, die du erbeutest: {npc:11556} nimmt sie.",
	-- ["{faction:576} starts out Hostile, and its furbolgs in the tunnels attack until you reach Unfriendly. Every Deadwood and Winterfall furbolg you kill raises it, so the quests below pay twice. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:576} beginnt bei Feindselig, und ihre Furbolgs in den Tunneln greifen an, bis du Unfreundlich erreichst. Jeder Furbolg der Totenwaldfelle und der Winterfelle, den du tötest, erhöht ihn, die Quests unten zahlen sich also doppelt aus. Forevers Vermächtnis-Vorteil „Diplomat“ erhöht den Rufgewinn.",
	-- ["{faction:576} to Exalted"] = "{faction:576} bis Ehrfürchtig",
	-- ["{faction:576} to Revered"] = "{faction:576} bis Respektvoll",
	-- ["{npc:11556}: Beads for {npc:11556}"] = "{npc:11556}: Perlen für {npc:11556}",
	-- ["{npc:15395} waits in northern {zone:1448} at the tunnel into {faction:576}."] = "{npc:15395} wartet im nördlichen {zone:1448} am Tunnel zur {faction:576}.",
	-- ["{npc:15395}: Feathers for {npc:15395}"] = "{npc:15395}: Federn für {npc:15395}",
}
