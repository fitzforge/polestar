-- German (deDE): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328} (Forsaken)"] = "Tyr's Watch und {spell:7328} (Verlassene)",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "{spell:7328}, um gefallene Verbündete wiederzubeleben, dazu eine Waffe und ein Schild für einen neuen verlassenen Paladin.",

	-- Step 1: Aramis Hammerhand
	-- {npc:1569} Shadow Priest Sarvis · {item:282423} Consecrated Scroll · {quest:364} The Mindless Ones · {npc:244808} Aramis Hammerhand · {npc:259377} Injured Deathguard · {area:154} Deathknell · {spell:635} Holy Light
	["{npc:1569} gives you a {item:282423} after {quest:364}: read it, then bring it to {npc:244808} by the church. He asks you to heal five {npc:259377} lying around {area:154}. {spell:635} hurts a Forsaken paladin a little each time: watch your health."] = "{npc:1569} gibt dir nach {quest:364} {item:282423}: Lies es und bringe es dann zu {npc:244808} bei der Kirche. Er bittet dich, fünf {npc:259377} zu heilen, die um {area:154} herum liegen. {spell:635} schadet einem Verlassenen-Paladin jedes Mal ein wenig: Achte auf dein Leben.",
	-- {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Heal 5 {npc:259377} with {spell:635}"] = "Heile 5 {npc:259377} mit {spell:635}",

	-- Step 2: Coming to Terms
	-- {npc:244808} Aramis Hammerhand · {npc:246143} Frightened Paladin
	["At 4 {npc:244808} sends you after a {npc:246143} who fled into the hills west of the church, just south of the bat cave. Talk to her to offer aid: she turns on you, and you have to put her down (level 3, easy)."] = "Mit 4 schickt dich {npc:244808} hinter einem {npc:246143} her, der in die Hügel westlich der Kirche geflohen ist, südlich der Fledermaushöhle. Sprich sie an, um Hilfe anzubieten: Sie greift dich an, und du musst sie erledigen (Stufe 3, leicht).",
	-- {npc:246143} Frightened Paladin
	["Talk to the {npc:246143}, then defeat her"] = "Sprich mit {npc:246143} und besiege sie dann",

	-- Step 3: Shari Stilwell
	-- {area:154} Deathknell · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road east out of {area:154} to {area:159}. {npc:246152}, the paladin trainer, stands in town; she trains you from here on."] = "Folge der Straße östlich aus {area:154} hinaus nach {area:159}. {npc:246152}, die Paladinlehrerin, steht in der Stadt; von hier an bildet sie dich aus.",

	-- Step 4: A Second Home
	-- {npc:246152} Shari Stilwell · {area:159} Brill · {quest:91317} The Tarnished · {area:16881} Shadowvale
	["At 8 {npc:246152} in {area:159} sends you to the order's keep on the west coast. {quest:91317} in {area:16881} and the crypt under it hit hard at 8-9: come at 10 or later."] = "Mit 8 schickt dich {npc:246152} in {area:159} zur Festung des Ordens an der Westküste. {quest:91317} in {area:16881} und die Gruft darunter schlagen mit 8-9 hart zu: Komm mit 10 oder später.",

	-- Step 5: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {npc:267009} Hadric Harlson · {area:159} Brill
	["{area:16602} stands on the bluffs north-west of the {area:156} (the road west starts near 29,46). {npc:246349} waits at the gate. {npc:246389}, the keep's trainer, and {npc:259190}, its stable master, stand at the forest's edge just south of him. They only have work for you from level 10 and after {quest:96896} from Leonid at the keep, the end of {npc:267009}'s chain that starts south-east of {area:159}; take their quests when you see them."] = "{area:16602} liegt auf den Klippen nordwestlich von {area:156} (die Straße nach Westen beginnt bei etwa 29,46). {npc:246349} wartet am Tor. {npc:246389}, die Lehrerin der Festung, und {npc:259190}, ihr Stallmeister, stehen am Waldrand direkt südlich von ihm. Sie haben erst ab Stufe 10 Arbeit für dich, und zwar nach {quest:96896} von Leonid in der Festung, dem Ende der Questreihe von {npc:267009}, die südöstlich von {area:159} beginnt; nimm ihre Quests an, wenn du sie siehst.",

	-- Step 6: Murlocs at the Gates
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs (level 9-11) lurk on the bluffs along the road east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "Die Vile Fin Murlocs (Stufe 9-11) lauern auf den Klippen an der Straße östlich der Festung und in den Lagern rund um den See im Südwesten, auf dem Weg hinunter nach {area:16881}.",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers x8"] = "Vile Fin Attackers x8",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers x8"] = "Vile Fin Seers x8",

	-- Step 7: Touring the Grounds
	-- {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:246394} Ander Solliden · {npc:246393} Jorin Croge · {npc:246378} Danitha Morr
	["{npc:246349} gives you a weapon, then sends you round the keep to speak with four of its people: {npc:246389} just south of the gate, {npc:246394}, the lookout, who walks the road south-east of the keep, then {npc:246393} and {npc:246378} inside the keep. Pick the conversation option with each."] = "{npc:246349} gibt dir eine Waffe und schickt dich dann um die Festung, damit du mit vier ihrer Leute sprichst: {npc:246389} südlich des Tores, {npc:246394}, der Späher, der die Straße südöstlich der Festung abgeht, dann {npc:246393} und {npc:246378} in der Festung. Wähle bei jedem die Gesprächsoption.",
	-- {npc:246349} Breton Samuels · {item:246164} Skullthumper · {item:246165} Driftwood Smasher
	["{npc:246349}: {item:246164} or {item:246165}"] = "{npc:246349}: {item:246164} oder {item:246165}",

	-- Step 8: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge · {quest:91317} The Tarnished
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it. {quest:91317} need level 9."] = "{npc:246378} führt den Orden aus dem Inneren der Festung; {npc:246393} steht neben ihr. {quest:91317} brauchen Stufe 9.",

	-- Step 9: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {npc:259431} Rudolph Gelhardt
	["{quest:91317} (level 8-9) hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. Commander {npc:259431} (level 10) stands on the upper floor of a house, with Drudges below him: clear the ground floor first."] = "{quest:91317} (Stufe 8-9) halten das zerstörte Dorf {area:16881} im {area:16616} südwestlich der Festung. Kommandant {npc:259431} (Stufe 10) steht im Obergeschoss eines Hauses, unter ihm Drudges: Räume zuerst das Erdgeschoss.",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges x8"] = "Tarnished Drudges x8",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots x6"] = "Tarnished Zealots x6",

	-- Step 10: The crypt under Shadowvale
	-- {area:16881} Shadowvale
	["The crypt under {area:16881}"] = "Die Gruft unter {area:16881}",
	-- {item:246213} Sturdy Lumber · {npc:260396} Whispering Horror
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["The cellar is under the village, not on the surface: the way down is inside a burned-out house, where the arrow points. Twelve Lumber Piles (stacked beams) lie in the cellar, each good for one {item:246213}. {npc:260396}, an elite (level 11-13), sits at the far end: leave it alone."] = "Der Keller liegt unter dem Dorf, nicht an der Oberfläche: Der Weg nach unten führt durch ein ausgebranntes Haus, dorthin zeigt der Pfeil. Im Keller liegen zwölf Lumber Piles (gestapelte Balken), jeder gut für ein {item:246213}. {npc:260396}, ein Elite (Stufe 11-13), sitzt am hinteren Ende: Lass ihn in Ruhe.",
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["Lumber Piles, in the cellar: the way down is here"] = "Lumber Piles, im Keller: Hier geht es nach unten",

	-- Step 11: Hilda the Breaker's bones
	-- {npc:246389} Hilda the Breaker
	["{npc:246389}'s bones"] = "Die Knochen von {npc:246389}",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher · Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["The Shadowvale Lurchers and Mystics (level 8-10) in the crypt drop the Faintly Glowing Bones: about one in two from Lurchers, more from one kind of Mystic, less from the other."] = "Die Shadowvale Lurchers und Mystics (Stufe 8-10) in der Gruft lassen die Faintly Glowing Bones fallen: etwa jeder zweite Lurcher, mehr von einer Art Mystic, weniger von der anderen.",
	-- plural, as words: Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["Faintly Glowing Bones x6"] = "Faintly Glowing Bones x6",

	-- Step 12: Ephram Barbaro's crystal
	-- {npc:259190} Ephram Barbaro
	["{npc:259190}'s crystal"] = "Der Kristall von {npc:259190}",
	-- {item:286269} Glowing Crystal Fragment
	["The {item:286269}, a green crystal, lies on the floor in the left-hand part of the crypt."] = "{item:286269}, ein grüner Kristall, liegt im linken Teil der Gruft auf dem Boden.",

	-- Step 13: Back to the keep
	["Back to the keep"] = "Zurück zur Feste",
	-- {npc:246378} Danitha Morr · {npc:259431} Rudolph Gelhardt
	["{npc:246378} hands you {npc:259431}'s head for Sylvanas: keep it in your bags, it is what you hand in."] = "{npc:246378} gibt dir den Kopf von {npc:259431} für Sylvanas: Behalte ihn in deinen Taschen, er ist es, was du abgibst.",

	-- Step 14: Hilda the Breaker
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190} wait at the forest's edge south of the gate."] = "{npc:246389} und {npc:259190} warten am Waldrand südlich des Tores.",

	-- Step 15: Ephram Barbaro
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker
	["{npc:259190} waits at the forest's edge south of the gate, a few steps west of {npc:246389}."] = "{npc:259190} wartet am Waldrand südlich des Tores, ein paar Schritte westlich von {npc:246389}.",

	-- Step 16: A Lesson in Divinity
	-- {npc:246378} Danitha Morr · {item:2589} Linen Cloth · {zone:1458} Undercity
	["{npc:246378} offers the first Lesson in Divinity at level 12. Bring 10 {item:2589} if you have it: the {zone:1458} asks for it next."] = "{npc:246378} bietet die erste Lesson of Divinity ab Stufe 12 an. Bring 10 {item:2589} mit, falls du welches hast: {zone:1458} verlangt es als Nächstes.",

	-- Step 17: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "Geh von {area:159} nach Süden zu {area:153} und hinab nach {zone:1458}. {npc:10181} hält in {object:36126} Hof; {npc:257648} bettelt in {object:36078}.",

	-- Step 18: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["{npc:257648} needs 10 {item:2589}. Humanoids drop it: the Scarlet Zealots and Friars of the glades about three kills in ten. The Undercity Auction House sells it too."] = "{npc:257648} braucht 10 {item:2589}. Humanoide lassen es fallen: die Scarlet Zealots und Friars der Lichtungen in etwa drei von zehn Kills. Das Auktionshaus von Undercity verkauft es auch.",
	-- {item:2589} Linen Cloth
	["{item:2589} x10"] = "{item:2589} x10",

	-- Step 20: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "{item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep. If you lose the symbol, {npc:246378} gives you another."] = "Zurück nach {area:16602}. {npc:246378} gibt dir {item:6866}; {npc:257655} wartet unten in der Festung. Wenn du das Symbol verlierst, gibt dir {npc:246378} ein neues.",
	-- {npc:257655} Deathguard Billmuth
	["{npc:257655}, downstairs"] = "{npc:257655}, unten",

	-- Step 21: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["{area:812} is at the far east end of the glades, a long walk. Falgan lies dead among the Scarlet Crusaders there: target his body and use the {item:6866}, then talk to him at once, as he does not stay alive long. If he is already up (another player), just talk to him; if he died again, raise him again."] = "{area:812} liegt am äußersten Ostende der Lichtungen, ein langer Marsch. Falgan liegt tot unter den Scarlet Crusaders dort: Wähle seinen Leichnam als Ziel und benutze {item:6866}, sprich dann sofort mit ihm, denn er bleibt nicht lange am Leben. Wenn er schon wieder steht (ein anderer Spieler), sprich einfach mit ihm; wenn er wieder gestorben ist, belebe ihn erneut wieder.",

	-- Step 22: The Scarlet attack plans
	["The Scarlet attack plans"] = "Die Angriffspläne des Scharlachroten Kreuzzugs",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["The Scarlet Zealots (level 8-9), Friars (9-10) and Tarnished around {area:812} carry the attack plans. They run for help at low health and respawn in five minutes."] = "Die Scarlet Zealots (Stufe 8-9), Friars (9-10) und Tarnished um {area:812} tragen die Angriffspläne. Sie rufen bei wenig Leben um Hilfe und respawnen nach fünf Minuten.",

	-- Step 23: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}, across the whole glades: Billmuth downstairs takes the plans, then {npc:246378}, back upstairs in the keep, teaches you {spell:7328}."] = "Zurück nach {area:16602}, quer durch die ganzen Lichtungen: Billmuth unten nimmt die Pläne, dann bringt dir {npc:246378}, wieder oben in der Festung, {spell:7328} bei.",
	-- {npc:246378} Danitha Morr · {spell:7328} Redemption
	["{npc:246378}, back upstairs: {spell:7328}"] = "{npc:246378}, wieder oben: {spell:7328}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "Zurück nach {area:16602}. {npc:246378} gibt dir {item:6866}; {npc:257655} wartet unten in der Feste.",
	-- ["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "Zurück nach {area:16602}: Billmuth nimmt die Pläne, {npc:246378} lehrt dich {spell:7328}.",
	-- ["Tarnished Drudges"] = "Befleckte Akkordarbeiter",
	-- ["Tarnished Zealots"] = "Befleckte Fanatiker",
	-- ["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "Die Scharlachroten Kreuzfahrer, die rund um {area:812} lagern, tragen die Angriffspläne.",
	-- ["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "Die Murlocs der Finsterflossen lauern auf den Klippen entlang der Straße östlich der Feste und in den Lagern rund um den See im Westen.",
	-- ["Tyr's Watch and {spell:7328}"] = "Tyr's Watch und {spell:7328}",
	-- ["Vile Fin Attackers"] = "Angreifer der Finsterflossen",
	-- ["Vile Fin Seers"] = "Seher der Finsterflossen",
	-- ["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602} steht auf den Klippen nordwestlich von {area:156}. {npc:246349} wartet am Tor.",
	-- ["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "{area:812} liegt am äußersten Ostende der Lichtungen. Benutze {item:6866} an {npc:257663} und sprich dann mit ihm. Verlierst du das Symbol, gibt dir {npc:246378} ein neues.",
	-- ["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "{npc:246152}, die in {area:159} Paladine ausbildet, schickt dich zur Feste des Ordens an der Westküste.",
	-- ["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378} führt den Orden aus dem Inneren der Feste; {npc:246393} steht daneben.",
	-- ["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378} bietet die erste Lektion in Sachen Göttlichkeit mit Stufe 12 an.",
	-- ["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648} braucht 10 {item:2589}. Scharlachrote Zeloten und Scharlachrote Ordensmitglieder lassen es etwa dreimal von zehn fallen; bring es mit, falls du schon welches dabeihast.",
	-- ["{object:181686}, in the root cellar"] = "{object:181686}, im Wurzelkeller",
	-- ["{object:554626}, in the root cellar"] = "{object:554626}, im Wurzelkeller",
	-- ["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317} halten das zerstörte Dorf {area:16881} in {area:16616}, südwestlich der Feste. {item:246213} ist im Wurzelkeller eines der Häuser gestapelt; Kommandant {npc:259431} geht zwischen seinen Befleckten umher.",
}
