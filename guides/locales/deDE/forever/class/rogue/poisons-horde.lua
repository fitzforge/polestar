-- German (deDE): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Horde)"] = "Gifte (Horde)",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever bringt dir Gifte über diese Questreihe bei, nicht über den Lehrer; das Rezept {item:7676} gehört dazu.",

	-- Step 1: Lockpicking practice
	["Lockpicking practice"] = "Schlossknacken üben",
	-- {object:129127} Gallywix's Lockbox · {spell:1804} Pick Lock · {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {item:5060} Thieves' Tools · {area:392} Ratchet
	["{object:129127} at the end of the tower job needs Lockpicking of about 70-75. Train {spell:1804} from Gest or {npc:3401} in the {object:172960} if you lack it, carry {item:5060}, and pick the Buccaneer's Strongboxes on the middle deck of the Tide Razor, the beached pirate ship south of {area:392}: they come back fast. Your cap rises 5 per level."] = "{object:129127} am Ende des Turmauftrags braucht Schlossknacken von etwa 70-75. Lerne {spell:1804} bei Gest oder {npc:3401} im {object:172960}, falls du es nicht kannst, trage {item:5060} bei dir und knacke die Buccaneer's Strongboxes auf dem Mitteldeck der Tide Razor, dem gestrandeten Piratenschiff südlich von {area:392}: Sie kommen schnell wieder. Dein Limit steigt um 5 pro Stufe.",
	["Tide Razor"] = "Tide Razor",
	["Lockpicking about 75: pick the Buccaneer's Strongboxes on the Tide Razor"] = "Schlossknacken etwa 75: Knacke die Buccaneer's Strongboxes auf der Tide Razor",

	-- Step 2: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Take the quest and wait: he speaks three lines and salutes you. After his third line, target him and type /salute. If it does not count, abandon the quest and take it again. The tower job ahead is built around Ambush, which needs a dagger: if you have none, Kareth, the blade merchant in the {object:172960}, sells a Jambiya."] = "{npc:3401} steht im {object:172960}, der Schlucht unter dem {object:172982}. Nimm die Quest an und warte: Er spricht drei Zeilen und salutiert dir. Wähle ihn nach seiner dritten Zeile als Ziel und tippe /salute. Wenn es nicht zählt, brich die Quest ab und nimm sie erneut an. Der Turmauftrag danach dreht sich um Hinterhalt, der einen Dolch braucht: Wenn du keinen hast, verkauft Kareth, der Klingenhändler im {object:172960}, eine Jambiya.",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "/salutieren: {npc:3401}",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458}: Behalte {item:8051}",

	-- Step 3: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:3401} Shenthul
	["Fly to the Crossroads and head north to the Venture Co. tower above the {area:382}. Fizzule stands under a tree east of the tower, outside it, and is hostile until signalled. Target him from about 50 yards and fire the {item:8051} twice, then walk up in front of him and /salute. In any other order he attacks. Lost the {item:8051}? Abandon and retake from {npc:3401}."] = "Flieg zum Kreuzweg und geh nach Norden zum Turm der Venture Co. über dem {area:382}. Fizzule steht unter einem Baum östlich des Turms, außerhalb, und ist feindselig, bis du ein Signal gibst. Wähle ihn aus etwa 50 Yards als Ziel und feuere zweimal die {item:8051} ab, geh dann vor ihn und tippe /salute. In jeder anderen Reihenfolge greift er an. Hast du die {item:8051} verloren? Brich ab und nimm die Quest erneut bei {npc:3401} an.",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, at Fizzule"] = "{item:8051}, zweimal, auf Fizzule",

	-- Step 4: Silixiz's Tower Key
	-- {item:8066} Fizzule's Whistle · {npc:7287} Foreman Silixiz · {spell:921} Pick Pocket
	["Keep {item:8066} in your bags and use it on him every time you come near, or he turns hostile. {npc:7287} (level 22) walks by the tower: hug the wall, stealth up behind him and {spell:921} the key. Killing him does not give it; if his pockets are empty, kill him and wait 4 1/2 minutes for him to come back."] = "Behalte {item:8066} in deinen Taschen und benutze sie jedes Mal bei ihm, wenn du in seine Nähe kommst, sonst wird er feindselig. {npc:7287} (Stufe 22) läuft am Turm vorbei: Drück dich an die Wand, schleiche dich hinter ihn und wende {spell:921} für den Schlüssel an. Ihn zu töten bringt den Schlüssel nicht; wenn seine Taschen leer sind, töte ihn und warte 4 1/2 Minuten, bis er zurück ist.",
	-- {item:8072} Silixiz's Tower Key
	["Pick Pocket Foreman Silixiz for {item:8072}"] = "Bestiehl Foreman Silixiz und erhalte {item:8072}",

	-- Step 5: The Venture Co. tower
	["The Venture Co. tower"] = "Der Turm der Venture Co.",
	-- {spell:1943} Rupture · {spell:2098} Eviscerate · {npc:7288} Grand Foreman Puzik Gallywix · {spell:1776} Gouge · {spell:5277} Evasion · {item:7676} Thistle Tea · {object:129127} Gallywix's Lockbox · {spell:9810} Touch of Zanzil · {npc:2391} Serge Hinott
	-- plural, as words: Mutated Venture Co. Drones = {npc:7310} Mutated Venture Co. Drone
	["Inside, floor by floor (everything comes back after 4 1/2 minutes): the Mutated Venture Co. Drones (level 25) on the ground floor die to one Ambush with a dagger; the Patrollers on the second floor take half their health from a one-point {spell:1943}; the Lookouts on the open third floor from a one-point {spell:2098}. {npc:7288} waits on the top floor: a level 23 elite, back 10 minutes after a kill. Open with Ambush (about half his health), then {spell:1776}, {spell:5277}, a healing potion and {item:7676}; a friend makes it easy. One head per kill. Then pick {object:129127} beside him for the cache: it poisons you with the {spell:9810}, which weakens your stealth and agility until {npc:2391} cures it."] = "Drinnen, Stockwerk für Stockwerk (alles kommt nach 4 1/2 Minuten wieder): Die Mutated Venture Co. Drones (Stufe 25) im Erdgeschoss sterben durch einen Hinterhalt mit einem Dolch; die Patrollers im zweiten Stockwerk verlieren durch ein {spell:1943} mit einem Punkt die Hälfte ihres Lebens, die Lookouts im offenen dritten Stockwerk durch ein {spell:2098} mit einem Punkt. {npc:7288} wartet im obersten Stockwerk: ein Elite der Stufe 23, 10 Minuten nach einem Kill zurück. Beginne mit Hinterhalt (etwa die Hälfte seines Lebens), dann {spell:1776}, {spell:5277}, ein Heiltrank und {item:7676}; mit einem Freund ist es leicht. Ein Kopf pro Kill. Knacke dann neben ihm {object:129127} für den Vorrat: Sie vergiftet dich mit {spell:9810}, was Tarnung und Beweglichkeit schwächt, bis {npc:2391} es heilt.",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074}: {npc:7288} (Elite)",

	-- Step 6: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "Zurück zu {npc:3401}",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {item:8072} Silixiz's Tower Key · {area:263} Cleft · {item:2928} Dust of Decay · {item:6947} Instant Poison
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Fly back to {zone:1454} ({area:392} or the Crossroads; dying at the tower and taking the spirit healer's way back to the Crossroads is quicker). Keep {item:8072} afterwards. Before you leave the {area:263}, buy {item:2928} and Empty Vials from Rekkul: once Hinott teaches Poisons, each batch of {item:6947} takes one of each."] = "Flieg zurück nach {zone:1454} ({area:392} oder zum Kreuzweg; am Turm zu sterben und den Rückweg des Geistheilers zum Kreuzweg zu nehmen ist schneller). Behalte danach {item:8072}. Kaufe, bevor du {area:263} verlässt, {item:2928} und Leere Phiolen bei Rekkul: Sobald Hinott dir Gifte beibringt, braucht jede Charge {item:6947} von jedem eins.",

	-- Step 7: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:287} Hillsbrad · {area:272} Tarren Mill · {npc:2391} Serge Hinott · {npc:2216} Apothecary Lydon · {npc:3401} Shenthul · {item:6947} Instant Poison
	["Take the zeppelin from {zone:1454} to the {zone:1458} and follow the road south through {zone:1421} into {area:287}, to {area:272}. {npc:2391} works in the building next to the flight path, beside {npc:2216}, a wagon outside. If you lost the Sample of Zanzil's Mixture, abandon and retake from {npc:3401}. Stay beside him for about a minute while he brews the cure; if it never finishes, abandon and retake from him. Then open Poisons from your spellbook to make {item:6947} from Rekkul's dust and vials, and use it on your weapon."] = "Nimm den Zeppelin von {zone:1454} zur {zone:1458} und folge der Straße nach Süden durch {zone:1421} nach {area:287}, bis {area:272}. {npc:2391} arbeitet im Gebäude neben der Flugroute, neben {npc:2216}, einem Wagen vor der Tür. Wenn du die Probe von Zanzils Gebräu verloren hast, brich ab und nimm die Quest erneut bei {npc:3401} an. Bleib etwa eine Minute bei ihm, während er das Heilmittel braut; wenn es nie fertig wird, brich ab und nimm die Quest erneut bei ihm an. Öffne dann Gifte in deinem Zauberbuch, um aus Rekkuls Staub und Phiolen {item:6947} herzustellen, und benutze es auf deiner Waffe.",
	["Wait for the cure"] = "Warte auf das Heilmittel",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391}: Gifte",
	-- {item:8095} Hinott's Oil · {spell:9810} Touch of Zanzil
	["{item:8095}: clears the {spell:9810}"] = "{item:8095}: entfernt {spell:9810}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "Mit 20 steht {npc:3401} in der {object:172960}, der Schlucht unter dem {object:172982}. Nimm ihn ins Ziel und gib /salutieren ein.",
	-- ["Fly back to {zone:1454}."] = "Flieg zurück nach {zone:1454}.",
	-- ["Fly to the {area:380} and head north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "Flieg zum {area:380} und geh nach Norden zum Turm der Venture Co. nördlich des {area:382}. Feuere in Sichtweite des Turms zweimal {item:8051} ab und tippe dann /salute bei {npc:7233}, bevor er dich angreift.",
	-- ["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "Flieg zum {area:380} und reite nach Norden zum Turm der Venture Co. nördlich von {area:382}. Feuere in Sichtweite des Turms zweimal {item:8051} ab und salutiere dann vor {npc:7233} (/salutieren), bevor er dich angreift.",
	-- ["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever lehrt {spell:2842} über diese Questreihe, nicht beim Lehrer; das Rezept für {item:7676} gibt es dazu.",
	-- ["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "Bleib verstohlen. {npc:7287} trägt den Turmschlüssel; Gallywix (Elite) und seine Schließkassette sind oben im Turm. Töte je zwei Drohnen, Patrouillen und Ausgucke der Venture Co. rund um den Turm.",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and head south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "Nimm den Zeppelin von {zone:1454} nach {zone:1458} und geh nach Süden durch {zone:1421} nach {area:272} in {area:287}. {npc:2391} steht in {area:272}; warte neben ihm, während er das Heilmittel braut.",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "Nimm den Zeppelin von {zone:1454} nach {zone:1458} und reite nach Süden durch den {zone:1421} nach {area:272} in {area:287}. {npc:2391} steht in {area:272}; warte neben ihm, während er das Heilmittel braut.",
	-- ["{item:8051}, twice, in sight of the tower"] = "{item:8051}, zweimal, in Sichtweite des Turms",
	-- ["{spell:2842} (Horde)"] = "{spell:2842} (Horde)",
}
