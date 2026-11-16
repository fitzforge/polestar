-- German (deDE): the guide forever/alliance/40-50/01b-riverglades (forever/alliance/40-50/01b-riverglades.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:16724} Farholde Keep
	["About 90 quests in Forever's new zone, 42 to 45, from {area:16724}: the level for its port and Western Front."] = "Etwa 90 Quests im neuen Gebiet von Forever, 42 bis 45, ab {area:16724}: die richtige Stufe für seinen Hafen und die Westfront.",

	-- Step 1: Ironforge flight master
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Flugmeister von {zone:1455}",
	-- {zone:1426} Dun Morogh · {zone:1455} Ironforge · {area:69} Lakeshire
	["The Stranglethorn guide leaves Dwarves and Gnomes at their riding trainer in {zone:1426}: ride back west into {zone:1455}, where the flight to {area:69} leaves from the gryphon master."] = "Der Schlingendorntal-Guide lässt Zwerge und Gnome bei ihrem Reitlehrer in {zone:1426} zurück: Reite zurück nach Westen nach {zone:1455}, wo der Flug nach {area:69} beim Greifenmeister startet.",

	-- Step 2: Into the Riverglades
	-- {zone:2548} Riverglades
	["Into the {zone:2548}"] = "In die {zone:2548}",
	-- {zone:1455} Ironforge · {area:69} Lakeshire · {area:2417} Blackrock Pass · {zone:2548} Riverglades · {area:16737} Bristle Hills
	["Fly from {zone:1455} to {area:69} in Redridge, then follow the road north out of town and up through {area:2417}: it comes down into the western {zone:2548} by the {area:16737}."] = "Flieg von {zone:1455} nach {area:69} im Rotkammgebirge, folge dann der Straße nach Norden aus dem Ort hinaus und hoch durch {area:2417}: Sie führt bei {area:16737} hinunter in die westlichen {zone:2548}.",
	-- {zone:2548} Riverglades
	["The western {zone:2548}"] = "Die westlichen {zone:2548}",

	-- Step 3: Scout Bolain
	-- {npc:260026} Scout Bolain
	["{npc:260026} waits beside the road east of the pass."] = "{npc:260026} wartet neben der Straße östlich des Passes.",

	-- Step 4: Southern Watch
	-- {area:16744} Southern Watch
	["Follow the road east to {area:16744}, the Alliance outpost above the river. The gnolls you passed on the way in are Captain Dalton's job: you go back for them after the lumber camp."] = "Folge der Straße nach Osten nach {area:16744}, dem Außenposten der Allianz über dem Fluss. Die Gnolle, an denen du auf dem Weg hinein vorbeigekommen bist, sind Captain Daltons Sache: Du kehrst nach dem Holzfällerlager für sie zurück.",
	-- {quest:95148} Southern Watch Gnoll Report · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95148}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95148}: für {npc:257558} in {area:16724}, behalte es",

	-- Step 5: Snargl's Snout
	-- {npc:255906} Snargl · {area:16737} Bristle Hills
	["{npc:255906} is an elite gnoll (level 40) who roams the south-western camps of the {area:16737}: grouping up is advised."] = "{npc:255906} ist ein Elite-Gnoll (Stufe 40), der durch die südwestlichen Lager von {area:16737} streift: Eine Gruppe wird empfohlen.",

	-- Step 6: Turner's Logging Camp
	-- {npc:256438} Halligan Turner
	["North up the road to the lumber camp. {npc:256438} runs it; his third job, the saplings, comes once his plant food is in."] = "Nach Norden die Straße hoch zum Holzfällerlager. {npc:256438} leitet es; sein dritter Auftrag, die Setzlinge, kommt, sobald sein Pflanzendünger abgegeben ist.",

	-- Step 7: The Bristle Hills
	-- {area:16737} Bristle Hills
	["The {area:16737}"] = "{area:16737}",
	-- {area:16737} Bristle Hills · {npc:255906} Snargl
	["West into the {area:16737}: the Redridge gnolls camp on the slopes all the way from the hills west of the lumber camp to the pass you came in by. The stolen saw blades lie only in the western camps, near the pass.\nCareful: {npc:255906}, an elite gnoll (level 40), roams the south-western camps: pull the gnolls away from him."] = "Nach Westen nach {area:16737}: Die Gnolle des Rotkammgebirges lagern an den Hängen von den Hügeln westlich des Holzfällerlagers bis zum Pass, durch den du gekommen bist. Die gestohlenen Sägeblätter liegen nur in den westlichen Lagern nahe dem Pass.\nVorsicht: {npc:255906}, ein Elite-Gnoll (Stufe 40), streift durch die südwestlichen Lager: Zieh die Gnolle von ihm weg.",

	-- Step 9: Southern Watch
	-- {area:16744} Southern Watch
	["Back east along the road to {area:16744}."] = "Zurück nach Osten die Straße entlang nach {area:16744}.",

	-- Step 11: Gelinda Coppergleam
	-- {area:16744} Southern Watch · {npc:262399} Gelinda Coppergleam
	["South-west past {area:16744}: {npc:262399}, a prospector, has camped by the Cinderscale dragonkin's hollow."] = "Südwestlich an {area:16744} vorbei: {npc:262399}, eine Prospektorin, lagert bei der Senke der Drachkin der Glutschuppen.",

	-- Step 12: The Cinderscale hollow
	["The Cinderscale hollow"] = "Die Senke der Glutschuppen",
	-- {item:271611} Cubic Draconia
	["The whelps nest all over the hollow; the warriors (level 41-42) guard its back, by the {item:271611}. Scaldaron, a rare elite drake, can be up here too: leave him be unless you have a group."] = "Die Welpen nisten überall in der Senke; die Krieger (Stufe 41-42) bewachen ihren hinteren Teil bei der {item:271611}. Scaldaron, ein seltener Elitedrache, kann auch hier oben sein: Lass ihn in Ruhe, außer du hast eine Gruppe.",

	-- Step 14: Holmsby farm
	["Holmsby farm"] = "Hof der Holmsbys",
	-- {area:16744} Southern Watch
	["Back past {area:16744} and south to the Holmsbys' farm by the river."] = "Zurück an {area:16744} vorbei und nach Süden zum Hof der Holmsbys am Fluss.",

	-- Step 15: Benjy Wheeler
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner
	["North-east across the fields to {area:16725}: {npc:258317} wants the Mudfin murlocs on the river thinned out, the same murlocs whose heads {npc:256438} needs, so one pass along the river does both."] = "Nach Nordosten über die Felder nach {area:16725}: {npc:258317} will, dass die Murlocs der Schlickflossen am Fluss dezimiert werden, dieselben Murlocs, deren Köpfe {npc:256438} braucht, also erledigt ein Durchgang am Fluss beides.",

	-- Step 16: Meadowsbrook and the river
	-- {area:16735} Meadowsbrook
	["{area:16735} and the river"] = "{area:16735} und der Fluss",
	-- {npc:258317} Benjy Wheeler · {npc:256438} Halligan Turner · {npc:258588} Jumbo Crawfish · {npc:258935} Curly · {npc:259049} Robbie Holmsby · {area:16735} Meadowsbrook · {npc:263380} Ghostmaw
	-- plural, as words: Mudfin Warriors = {npc:258574} Mudfin Warrior
	["Back south-west along the river: kill the Mudfin Warriors and Oracles on the banks for {npc:258317} (they drop {npc:256438}'s heads) and the {npc:258588} in the shallows for the shells. {npc:258935}, one of {npc:256438}'s lumberjacks, is stuck on the bank just north-west of the murlocs; {npc:259049}'s hat lies on the riverbank among them; the fresh manure is in the fields of {area:16735}, between the river and the farm. {npc:263380}, an elite (level 42), prowls the river: if he comes your way, back off and let him pass."] = "Zurück nach Südwesten den Fluss entlang: Töte die Krieger und Orakel der Schlickflossen an den Ufern für {npc:258317} (sie lassen die Köpfe für {npc:256438} fallen) und die {npc:258588} im seichten Wasser für die Panzer. {npc:258935}, einer der Holzfäller von {npc:256438}, sitzt am Ufer gleich nordwestlich der Murlocs fest; der Hut von {npc:259049} liegt zwischen ihnen am Flussufer; der frische Mist liegt auf den Feldern von {area:16735}, zwischen Fluss und Hof. {npc:263380}, ein Elite (Stufe 42), streift am Fluss umher: Kommt er auf dich zu, zieh dich zurück und lass ihn vorbei.",

	-- Step 18: Watcher Fredericks
	-- {npc:259051} Watcher Fredericks · {area:16744} Southern Watch
	["{npc:259051} keeps the west end of {area:16744}."] = "{npc:259051} steht am Westende von {area:16744}.",

	-- Step 19: Turner's Logging Camp
	["North up the road to the lumber camp."] = "Nach Norden die Straße hinauf zum Holzfällerlager.",

	-- Step 20: Saplings
	["Saplings"] = "Setzlinge",
	-- {npc:256438} Halligan Turner · {item:266161} Tree Sprouting Kit
	["Use {npc:256438}'s {item:266161} on bare ground around the camp: five saplings."] = "Benutze das {item:266161} von {npc:256438} auf kahlem Boden rund ums Lager: fünf Setzlinge.",

	-- Step 21: Hurley
	-- {npc:258963} Hurley · {npc:258935} Curly · {quest:94861} Helping Hands · {npc:263380} Ghostmaw
	["{npc:258963} stands at the camp's south end. He sets off for {npc:258935}, south-east of the camp, as soon as you take {quest:94861}: go with him and keep the attackers off, and wait if {npc:263380} is in sight. If it fails, {npc:258963} offers the quest again."] = "{npc:258963} steht am Südende des Lagers. Er bricht zu {npc:258935} südöstlich des Lagers auf, sobald du {quest:94861} annimmst: Geh mit ihm, halte die Angreifer fern und warte, wenn {npc:263380} in Sicht ist. Schlägt es fehl, bietet {npc:258963} die Quest erneut an.",
	-- {npc:258963} Hurley · {npc:258935} Curly
	["go with {npc:258963} to save {npc:258935}"] = "geh mit {npc:258963}, um {npc:258935} zu retten",

	-- Step 23: Wheeler's Grange
	-- {area:16724} Farholde Keep · {npc:258317} Benjy Wheeler · {area:16725} Wheeler's Grange
	["East along the road towards {area:16724}: hand {npc:258317} his murlocs as you pass {area:16725}."] = "Nach Osten die Straße entlang Richtung {area:16724}: Gib {npc:258317} seine Murlocs ab, wenn du an {area:16725} vorbeikommst.",

	-- Step 24: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257087} Gretchen Mayberry · {npc:260070} Bertrand Ironbrow · {npc:260080} Ember Bladewhisper · {npc:263613} Brother Lowley · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["On east along the road to {area:16724}. {npc:257087}, the gryphon master, stands at its western gate; {npc:260070} and {npc:260080} are on the way in, {npc:263613} tends the wounded by the barracks, {npc:257558} and {npc:257591} wait in the keep at the east end, and the inn is in the south of the walls."] = "Weiter nach Osten die Straße entlang nach {area:16724}. {npc:257087}, die Greifenmeisterin, steht am Westtor; {npc:260070} und {npc:260080} sind auf dem Weg hinein, {npc:263613} versorgt die Verwundeten bei der Kaserne, {npc:257558} und {npc:257591} warten in der Burg am Ostende, und das Gasthaus liegt im Süden innerhalb der Mauern.",
	-- {npc:257087} Gretchen Mayberry
	["{npc:257087}, at the western gate"] = "{npc:257087}, am Westtor",
	-- {npc:257558} Demar Brant
	["{npc:257558}, in the keep"] = "{npc:257558}, in der Burg",
	-- {quest:94877} Saving Sunnyglade
	["{quest:94877}: for later in this guide"] = "{quest:94877}: für später in diesem Guide",
	-- {npc:257591} Ashe Amberhall · {quest:94881} Curious Trinkets
	["{npc:257591}: {quest:94881}, for later in this guide"] = "{npc:257591}: {quest:94881}, für später in diesem Guide",
	-- {quest:94879} Scraps of Knowledge
	["{quest:94879}, for later in this guide"] = "{quest:94879}, für später in diesem Guide",
	-- {npc:259863} Cassandra Wheeler · {quest:95330} Love Thy Neighbor · {area:16736} Turner's Logging Camp
	["{npc:259863}, by the inn: {quest:95330}, for {area:16736} later in this guide"] = "{npc:259863}, beim Gasthaus: {quest:95330}, für {area:16736} später in diesem Guide",
	-- {npc:257595} Barracks Master Harlan
	["{npc:257595}, at the inn"] = "{npc:257595}, im Gasthaus",

	-- Step 25: The cathedral
	["The cathedral"] = "Die Kathedrale",
	-- {npc:262031} Sister Rowland · {area:16724} Farholde Keep · {npc:272437} Marla Bell · {npc:271742} Abbot Schuncke
	["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} sells the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031} hütet die alte Kathedrale in der Südwestecke von {area:16724}. Die Fledermäuse nisten im Obergeschoss; {npc:272437} verkauft daneben die heiligen Kerzen; die Gräber liegen auf dem Kapellenfriedhof.\n{npc:271742}, ein Elite der Stufe 53, steht in der Kathedrale: Er lässt dich in Ruhe, also greif ihn nie an und zieh die Fledermäuse von ihm weg.",
	-- {item:17028} Holy Candle · {npc:272437} Marla Bell
	["{item:17028}, from {npc:272437}"] = "{item:17028}, von {npc:272437}",
	-- {item:269997} Bundle of Candles
	["{item:269997}, on the graves"] = "{item:269997}, auf den Gräbern",

	-- Step 26: Wheeler's Grange
	-- {area:16725} Wheeler's Grange · {npc:258317} Benjy Wheeler
	["West to {area:16725}: {npc:258317} stands by the farmhouse."] = "Nach Westen zu {area:16725}: {npc:258317} steht beim Bauernhaus.",

	-- Step 27: The stables
	["The stables"] = "Die Ställe",
	["Search around the stables south of the farmhouse for the horses' tracks; the bundles of hay lie around the farm."] = "Such um die Ställe südlich des Bauernhauses nach den Spuren der Pferde; die Heubündel liegen auf dem Hof verteilt.",

	-- Step 29: The coyote den
	["The coyote den"] = "Der Kojotenbau",
	-- {npc:258522} Sootfur
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The coyotes den in the hills south of the farm: {npc:258522}, the big dark one, sits at the back of it; the Plains Coyotes around it drop the pelts."] = "Die Kojoten hausen in den Hügeln südlich des Hofs: {npc:258522}, der große dunkle, sitzt ganz hinten; die Ebenenkojoten drumherum lassen die Felle fallen.",

	-- Step 30: The lost horse
	["The lost horse"] = "Das verlorene Pferd",
	["One of Benjy's horses ran north up the river, past the farm. Give it the feed, then lead it home."] = "Eines von Benjys Pferden ist am Hof vorbei nach Norden den Fluss hinauf gelaufen. Gib ihm das Futter und führ es dann nach Hause.",
	-- {area:16725} Wheeler's Grange
	["walk it back to {area:16725}"] = "führ es zurück nach {area:16725}",

	-- Step 32: Foreman's Crate
	-- {area:16729} Terral's Watch
	["North up the track towards {area:16729}: the foreman's crate lies by the road."] = "Nach Norden den Pfad hinauf Richtung {area:16729}: Die Kiste des Vorarbeiters liegt am Weg.",

	-- Step 33: Terral's Watch
	-- {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{npc:259352} holds {area:16729}, the tower on the plains north-east of the crate."] = "{npc:259352} hält {area:16729}, den Turm in der Ebene nordöstlich der Kiste.",

	-- Step 34: The plains
	["The plains"] = "Die Ebene",
	-- {quest:95983} A Feast for Buzzards · {npc:263380} Ghostmaw
	-- plural, as words: Rog'mar Poachers = {npc:259052} Rog'mar Poacher
	["The Rog'mar Poachers hunt the plains north of the tower; the Wildplains lions roam among them. A picked carcass lies in the grass east of the tower: its skull starts {quest:95983}.\nCareful: {npc:263380}, an elite (level 42), hunts along the river west of the plains: keep an eye on the riverbank."] = "Die Wilderer von Rog'mar jagen in der Ebene nördlich des Turms; die Löwen der Wildplains streifen zwischen ihnen umher. Ein abgenagter Kadaver liegt östlich des Turms im Gras: Sein Schädel startet {quest:95983}.\nVorsicht: {npc:263380}, ein Elite (Stufe 42), jagt westlich der Ebene am Fluss: Behalte das Ufer im Auge.",

	-- Step 35: Terral's Watch
	-- {quest:94928} A Few Furs for Friz · {area:16727} Powderfuse Port
	["{quest:94928}: for {area:16727}, keep it"] = "{quest:94928}: für {area:16727}, behalte es",
	-- {quest:95984} Song of the Strider · {npc:263367} Sleebo Fizzlespout
	["{quest:95984}: for later, where the tallstriders graze by {npc:263367}'s workshop; keep it"] = "{quest:95984}: für später, wo die Weitschreiter bei der Werkstatt von {npc:263367} grasen; behalte es",
	-- {quest:95064} Preventative Measures · {area:16743} Rog'mar
	["{quest:95064}: for later, at the Horde's training grounds north of {area:16743}"] = "{quest:95064}: für später, auf dem Übungsgelände der Horde nördlich von {area:16743}",
	-- {quest:96125} In Need of Relief · {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["{quest:96125}: for {npc:259057} in {area:16726}, keep it"] = "{quest:96125}: für {npc:259057} in {area:16726}, behalte es",
	-- {quest:95426} Rog'mar Supplies
	["{quest:95426}: for later, the same training grounds"] = "{quest:95426}: für später, dasselbe Übungsgelände",

	-- Step 36: Farholde Keep
	-- {area:16724} Farholde Keep
	["South back to {area:16724}."] = "Zurück nach Süden zur {area:16724}.",
	-- {quest:96009} High Stakes · {area:16736} Turner's Logging Camp
	["{quest:96009}: for {area:16736} later in this guide"] = "{quest:96009}: für {area:16736}, später in diesem Guide",

	-- Step 37: WANTED: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch · {npc:259859} Wheatley
	["{npc:263380} is an elite (level 42) who hunts along the river between {area:16725} and {area:16729}, on your way north later in this guide: grouping up is advised. The poster hangs by the keep; {npc:259859}, who takes the fang, stands south of the inn."] = "{npc:263380} ist ein Elite (Stufe 42), der am Fluss zwischen {area:16725} und {area:16729} jagt, auf deinem späteren Weg nach Norden in diesem Guide: Eine Gruppe wird empfohlen. Das Plakat hängt bei der Feste; {npc:259859}, der den Fangzahn annimmt, steht südlich des Gasthauses.",
	-- {object:645166} WANTED! (no name in this language: may be words)
	["the {object:645166} poster"] = "das Plakat {object:645166}",

	-- Step 38: WANTED: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo · {area:16743} Rog'mar
	["{npc:263071} is an elite (level 42) at the Horde's training grounds north of {area:16743}, where this guide goes later: grouping up is advised."] = "{npc:263071} ist ein Elite (Stufe 42) auf dem Übungsgelände der Horde nördlich von {area:16743}, wohin dieser Guide später geht: Eine Gruppe wird empfohlen.",
	-- {object:707245} Wanted (no name in this language: may be words)
	["the {object:707245} poster"] = "das Plakat {object:707245}",

	-- Step 39: Ghostmaw
	-- {npc:263380} Ghostmaw · {area:16725} Wheeler's Grange · {area:16729} Terral's Watch
	["{npc:263380}, the elite, hunts along the river between {area:16725} and {area:16729}, on your way north."] = "{npc:263380}, der Elite, jagt am Fluss zwischen {area:16725} und {area:16729}, auf deinem Weg nach Norden.",

	-- Step 40: Sunnyglade
	-- {area:16724} Farholde Keep · {area:16729} Terral's Watch · {area:16723} Sunnyglade · {area:16743} Rog'mar · {npc:259158} Fuzzle · {npc:256831} Apprentice Claire · {npc:258697} Farmer Elbrim
	["North from {area:16724}, past {area:16729} and across the river, to {area:16723}, the farm town the Twilight cult holds; keep clear of {area:16743}, the Horde's fort east of the town. {npc:259158} the kobold hides in the middle of the town, {npc:256831} at its eastern edge, and {npc:258697} waits at his farm on the north-eastern edge."] = "Von der {area:16724} nach Norden, an {area:16729} vorbei und über den Fluss nach {area:16723}, dem Bauerndorf, das der Schattenhammerkult hält; halte Abstand zu {area:16743}, der Festung der Horde östlich des Dorfes. {npc:259158} der Kobold versteckt sich in der Dorfmitte, {npc:256831} steht am Ostrand, und {npc:258697} wartet auf seinem Hof am Nordostrand.",

	-- Step 41: The Twilight cult
	["The Twilight cult"] = "Der Schattenhammerkult",
	-- {area:16723} Sunnyglade · {item:266148} Farmers' Mementos · {item:4338} Mageweave Cloth · {npc:263613} Brother Lowley · {area:16724} Farholde Keep · {quest:94885} Field Marshal's Log · {npc:256899} Chogg'Zac · {npc:263380} Ghostmaw
	-- plural, as words: Twilight Raiders = {npc:256952} Twilight Raider
	["The cultists fill the streets and fields of {area:16723}. Start at the ritual circles in the middle (fill Claire's catalyst there), work west through the burnt houses to the edge of town, then back north-east to the loose soil west of Elbrim's farm: bury the {item:266148} the Twilight Raiders drop there. The charms, pages and finger bones drop from the cultists.\nKeep the {item:4338} they drop: {npc:263613} in {area:16724} asks for twenty when you are back there. Now and then a cultist drops the {quest:94885}: right-click it to start the quest.\nCareful: {npc:256899}, an elite ogre (level 41), walks the western streets of {area:16723}, around 44-47,47-52. Pull the cultists out towards you and let him pass; players died here more than anywhere else in the zone.\n{npc:263380}, the river's elite (level 42), can wander up from the south-western fields: let him pass."] = "Die Kultisten füllen die Straßen und Felder von {area:16723}. Beginne bei den Ritualkreisen in der Mitte (fülle dort Claires Katalysator), arbeite dich nach Westen durch die verbrannten Häuser bis zum Dorfrand, dann zurück nach Nordosten zur lockeren Erde westlich von Elbrims Hof: Vergrabe dort die {item:266148}, die die Twilight-Räuber fallen lassen. Die Talismane, Seiten und Fingerknochen droppen von den Kultisten.\nBehalte den {item:4338}, den sie fallen lassen: {npc:263613} in der {area:16724} will zwanzig, wenn du zurück bist. Ab und zu droppt ein Kultist {quest:94885}: Rechtsklicke darauf, um die Quest zu starten.\nVorsicht: {npc:256899}, ein Elite-Oger (Stufe 41), läuft durch die westlichen Straßen von {area:16723}, etwa bei 44-47,47-52. Zieh die Kultisten zu dir heraus und lass ihn vorbeiziehen; hier sind mehr Spieler gestorben als irgendwo sonst im Gebiet.\n{npc:263380}, der Elite vom Fluss (Stufe 42), kann von den südwestlichen Feldern heraufwandern: Lass ihn vorbeiziehen.",
	-- {item:269990} Crystal Catalyst
	["fill the {item:269990} at the ritual circles"] = "fülle den {item:269990} an den Ritualkreisen",
	-- {object:621813} Loose Soil (no name in this language: may be words)
	["{object:621813}: bury the mementos"] = "{object:621813}: Vergrabe die Andenken",
	-- {quest:94885} Field Marshal's Log
	["{quest:94885}: only if a cultist dropped the log"] = "{quest:94885}: nur falls ein Kultist das Logbuch fallen gelassen hat",

	-- Step 43: Cut Off the Heads
	-- {npc:256899} Chogg'Zac · {area:16723} Sunnyglade · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{npc:256899}, the two-headed ogre, is an elite (level 41) at the western edge of {area:16723}: grouping up is advised. Claire then has the filled catalyst for {npc:257591} in {area:16724}."] = "{npc:256899}, der zweiköpfige Oger, ist ein Elite (Stufe 41) am Westrand von {area:16723}: Eine Gruppe wird empfohlen. Claire hat danach den gefüllten Katalysator für {npc:257591} in der {area:16724}.",
	-- {quest:94884} An Unsettling Discovery · {npc:257591} Ashe Amberhall · {area:16724} Farholde Keep
	["{quest:94884}: for {npc:257591} in {area:16724}"] = "{quest:94884}: für {npc:257591} in der {area:16724}",

	-- Step 44: Fuzzle
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["{npc:259158} wants out of {area:16723}: lead him west to his treasure at the edge of town and keep the cultists off him."] = "{npc:259158} will raus aus {area:16723}: Führ ihn nach Westen zu seinem Schatz am Stadtrand und halte die Kultisten von ihm fern.",
	-- {npc:259158} Fuzzle · {area:16723} Sunnyglade
	["lead {npc:259158} out of {area:16723} to his treasure, west of the town"] = "Führ {npc:259158} aus {area:16723} hinaus zu seinem Schatz westlich der Stadt",

	-- Step 45: Farmer Elbrim
	["Back east through the town to Elbrim's farm: the doll and the locket are in the burnt farmhouse beside it."] = "Zurück nach Osten durch die Stadt zu Elbrims Hof: Die Puppe und das Medaillon liegen im abgebrannten Bauernhaus daneben.",

	-- Step 46: The Rog'mar training grounds
	-- {area:16743} Rog'mar
	["The {area:16743} training grounds"] = "Die Übungsplätze von {area:16743}",
	-- {area:16743} Rog'mar · {npc:263071} Blademaster Kaijo · {npc:263615} Krek the Noxious
	-- plural, as words: Rog'mar Grunts = {npc:255996} Rog'mar Grunt
	["North-east of Elbrim's farm, the Horde drills its trainees in the fields north of {area:16743}. Stay north of the fort: its guards are far above your level. The supply crates lie around the drill grounds. Three elites work this ground: {npc:263071} (42) walks among the trainees, {npc:263615} (42) lurks at the north end, and Komuk (45), a Horde elite, patrols the hills to the east; give each of them room.\nCareful: Rog'mar Grunts (55) guard the fort's north wall, around 59,39 to 61,41. Leave the crates and trainees by the wall and take the ones further north, around 57-61,34-37."] = "Nordöstlich von Elbrims Hof drillt die Horde ihre Rekruten auf den Feldern nördlich von {area:16743}. Bleib nördlich der Festung: Ihre Wachen liegen weit über deiner Stufe. Die Vorratskisten liegen rund um die Übungsplätze. Drei Elites streifen hier umher: {npc:263071} (42) läuft zwischen den Rekruten, {npc:263615} (42) lauert am Nordende, und Komuk (45), ein Elite der Horde, patrouilliert in den Hügeln im Osten; halte Abstand zu allen dreien.\nVorsicht: Grunzer von Rog'mar (55) bewachen die Nordmauer der Festung, etwa bei 59,39 bis 61,41. Lass die Kisten und Rekruten an der Mauer liegen und nimm die weiter nördlich, etwa bei 57-61,34-37.",

	-- Step 47: Blademaster Kaijo
	-- {npc:263071} Blademaster Kaijo
	["{npc:263071}, the elite, walks the training grounds."] = "{npc:263071}, der Elite, läuft über die Übungsplätze.",

	-- Step 48: Sleebo Fizzlespout's workshop
	-- {npc:263367} Sleebo Fizzlespout
	["{npc:263367}'s workshop"] = "Werkstatt von {npc:263367}",
	-- {area:16743} Rog'mar · {npc:263367} Sleebo Fizzlespout · {area:16726} Bolder'ok
	["South-east, round {area:16743}'s east side, to {npc:263367}'s workshop on the hill. Komuk and the {area:16726} ogres walk the road east of the fort: let them pass before you cross it."] = "Nach Südosten, an der Ostseite von {area:16743} vorbei, zur Werkstatt von {npc:263367} auf dem Hügel. Komuk und die Oger von {area:16726} laufen die Straße östlich der Festung ab: Lass sie vorbeiziehen, bevor du sie überquerst.",

	-- Step 49: The tallstriders and the marsh
	["The tallstriders and the marsh"] = "Die Weitschreiter und der Sumpf",
	-- plural, as words: Roving Tallstriders = {npc:263348} Roving Tallstrider
	["The Roving Tallstriders graze the meadows south-west of the workshop; further south-west the marsh bubbles with gas: fill the vials at the vents."] = "Die Umherstreifenden Weitschreiter grasen auf den Wiesen südwestlich der Werkstatt; weiter südwestlich blubbert Gas im Sumpf: Füll die Phiolen an den Gasquellen.",

	-- Step 50: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower stands just south-west of the marsh."] = "Der Turm von {npc:259352} steht gleich südwestlich des Sumpfs.",
	-- {quest:95066} The Rog'mar Situation · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95066}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95066}: für {npc:257558} in {area:16724}, behalte es",

	-- Step 51: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257591} Ashe Amberhall · {npc:257558} Demar Brant · {area:16723} Sunnyglade · {npc:263089} Tessa Dawnbright · {npc:263613} Brother Lowley
	["South across the plains to {area:16724}: {npc:257591} and {npc:257558} stand together in the keep at the east end, {npc:257591} first, her news is what Brant's next orders wait on. With {area:16723} saved, {npc:263089} by the orchard and {npc:263613} by the barracks have work for you too."] = "Nach Süden über die Ebene nach {area:16724}: {npc:257591} und {npc:257558} stehen zusammen in der Burg am Ostende, zuerst {npc:257591}, denn Brants nächste Befehle warten auf ihre Nachrichten. Da {area:16723} gerettet ist, haben auch {npc:263089} beim Obstgarten und {npc:263613} bei der Kaserne Aufgaben für dich.",
	-- {quest:94907} A Small Favor
	["{quest:94907}: for later in this guide"] = "{quest:94907}: für später in diesem Guide",
	-- {quest:95329} Out in the Field · {npc:259352} Watcher Cornelius · {area:16729} Terral's Watch
	["{quest:95329}: for {npc:259352} at {area:16729}, keep it"] = "{quest:95329}: für {npc:259352} bei {area:16729}, behalte es",
	-- {quest:94886} The Western Front
	["{quest:94886}: for later in this guide"] = "{quest:94886}: für später in diesem Guide",
	-- {npc:263613} Brother Lowley · {item:4338} Mageweave Cloth · {area:16723} Sunnyglade
	["{npc:263613}: twenty {item:4338}, from {area:16723}'s cultists and the pirates; hand it in when you are back"] = "{npc:263613}: zwanzig {item:4338}, von den Kultisten in {area:16723} und den Piraten; gib die Quest ab, wenn du zurück bist",

	-- Step 52: Tessa Dawnbright
	-- {npc:263089} Tessa Dawnbright
	["{npc:263089} stands west of the inn, by the orchard: the apples hang on the trees around it."] = "{npc:263089} steht westlich des Gasthauses beim Obstgarten: Die Äpfel hängen an den Bäumen ringsum.",

	-- Step 53: Coyote pelts
	["Coyote pelts"] = "Kojotenfelle",
	-- {area:16725} Wheeler's Grange
	-- plural, as words: Plains Coyotes = {npc:259267} Plains Coyote
	["The Plains Coyotes roam west and south-west of the keep, towards {area:16725}."] = "Die Ebenenkojoten streifen westlich und südwestlich der Burg umher, in Richtung {area:16725}.",

	-- Step 54: Tessa Dawnbright
	-- {quest:95961} Stepped Out · {npc:263120} Gray Dawnbright · {area:16727} Powderfuse Port
	["{quest:95961}: for {npc:263120} in {area:16727}, keep it"] = "{quest:95961}: für {npc:263120} in {area:16727}, behalte es",

	-- Step 55: King of the Wild Plains
	-- {npc:263315} Ombassa · {area:16729} Terral's Watch
	["{npc:263315}, an elite lion (level 41), prowls the plains north of {area:16729}, on your way back north: grouping up is advised."] = "{npc:263315}, ein Elite-Löwe (Stufe 41), streift durch die Ebenen nördlich von {area:16729}, auf deinem Rückweg nach Norden: Eine Gruppe ist ratsam.",

	-- Step 57: Sleebo Fizzlespout
	-- {npc:263367} Sleebo Fizzlespout
	["North-east to {npc:263367}'s workshop. {npc:263367}'s stress test is a fight with his G45-B4G beside the workshop: hand the quest in once it's beaten."] = "Nach Nordosten zur Werkstatt von {npc:263367}. Der Belastungstest von {npc:263367} ist ein Kampf gegen seinen G45-B4G neben der Werkstatt: Gib die Quest ab, sobald er besiegt ist.",
	["the stress test: beat G45-B4G beside the workshop"] = "der Belastungstest: Besiege G45-B4G neben der Werkstatt",

	-- Step 58: Powderfuse Port
	-- {area:16727} Powderfuse Port · {npc:255897} Friz Frazzlespark · {npc:263120} Gray Dawnbright · {npc:255894} Innkeeper Zizplink · {npc:259962} Fimbo Greasemitz · {npc:259961} Wharfmaster Whizzbuzz · {npc:260487} Gritta Chumwater · {npc:260565} Kor'gar · {npc:260560} Krikshank
	["East down the road to {area:16727}, the goblins' harbour. {npc:255897} keeps a stall at the west end of the docks; {npc:263120}, {npc:255894} and {npc:259962} are at the inn, and {npc:259961} works the north pier. Zizplink's drink needs three things the port's traders sell: the chum from {npc:260487}, the degreaser and the old poison from {npc:260565} and {npc:260560}, by {npc:255897}'s stall."] = "Nach Osten die Straße hinunter nach {area:16727}, dem Hafen der Goblins. {npc:255897} hat einen Stand am Westende der Docks; {npc:263120}, {npc:255894} und {npc:259962} sind im Gasthaus, und {npc:259961} arbeitet am Nordpier. Zizplinks Getränk braucht drei Dinge, die die Händler des Hafens verkaufen: den Köder von {npc:260487}, den Fettlöser und das alte Gift von {npc:260565} und {npc:260560}, neben dem Stand von {npc:255897}.",
	-- {quest:95059} Frazzlespark's Crate · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:95059}: for {npc:257558} in {area:16724}, keep it"] = "{quest:95059}: für {npc:257558} in {area:16724}, behalte es",
	-- {item:271657} Fresh Chum · {npc:260487} Gritta Chumwater
	["{item:271657}, from {npc:260487}"] = "{item:271657}, von {npc:260487}",
	-- {item:271653} Goblin Degreaser · {npc:260565} Kor'gar
	["{item:271653}, from {npc:260565}"] = "{item:271653}, von {npc:260565}",
	-- {item:271654} Expired Poison · {npc:260560} Krikshank
	["{item:271654}, from {npc:260560}"] = "{item:271654}, von {npc:260560}",
	-- {object:628948} WANTED! (no name in this language: may be words) · {npc:260235} Trapclaw
	["The {object:628948} poster by the inn: {npc:260235}"] = "Das Plakat {object:628948} beim Gasthaus: {npc:260235}",

	-- Step 59: WANTED: Old Rot-Chum
	-- {npc:257001} Old Rot-Chum
	["{npc:257001} is an elite (level 42) on the south shore: grouping up is advised."] = "{npc:257001} ist ein Elite (Stufe 42) am Südufer: Eine Gruppe ist ratsam.",
	-- {object:628948} WANTED! (no name in this language: may be words)
	["The {object:628948} poster by the inn"] = "Das Plakat {object:628948} beim Gasthaus",

	-- Step 60: The murlocs, south-west
	["The murlocs, south-west"] = "Die Murlocs im Südwesten",
	-- {quest:95260} Terrors From the Deep · {npc:260231} Argo Brinewhistle
	["South-west along the shore from the port: the saltwater murlocs camp on the beaches. On the way, a painted hide is stretched beside the path: it starts {quest:95260} for {npc:260231} at the docks."] = "Vom Hafen nach Südwesten am Ufer entlang: Die Salzwassermurlocs lagern an den Stränden. Unterwegs ist neben dem Pfad eine bemalte Haut aufgespannt: Sie startet {quest:95260} für {npc:260231} an den Docks.",

	-- Step 62: Back through the port
	["Back through the port"] = "Zurück durch den Hafen",
	["Back north along the shore: hand in the murlocs and the hide on the docks on your way to the crawlers."] = "Zurück nach Norden am Ufer entlang: Gib die Murlocs und die Haut auf dem Weg zu den Krabblern an den Docks ab.",
	-- {quest:95261} It Takes Guts
	["{quest:95261}: the beasts' entrails come as you go; the mushrooms are for later"] = "{quest:95261}: Die Eingeweide der Bestien kommen unterwegs; die Pilze sind für später",

	-- Step 63: The crawlers and Trapclaw
	-- {npc:260235} Trapclaw
	["The crawlers and {npc:260235}"] = "Die Krabbler und {npc:260235}",
	-- {npc:259962} Fimbo Greasemitz · {npc:260231} Argo Brinewhistle · {npc:260235} Trapclaw · {npc:259758} Gul'gash
	["North along the beach from the docks: the crawlers drop the meat for {npc:259962} and the spittle for Zizplink, and their entrails count for {npc:260231}. {npc:260235}, a big crab, scuttles along the rocks east of the docks. {npc:259758}, a rare elite of level 49, roams this coast from the docks up to the pirates' camp: if you see him, keep well away."] = "Von den Docks nach Norden den Strand entlang: Die Krabbler droppen das Fleisch für {npc:259962} und den Speichel für Zizplink, und ihre Eingeweide zählen für {npc:260231}. {npc:260235}, eine große Krabbe, huscht über die Felsen östlich der Docks. {npc:259758}, ein Rare-Elite der Stufe 49, streift an dieser Küste von den Docks bis zum Piratenlager umher: Falls du ihn siehst, halte großen Abstand.",

	-- Step 64: The Eastsea pirates
	["The Eastsea pirates"] = "Die Ostmeerpiraten",
	-- {npc:259758} Gul'gash
	["North-east along the coast to the pirates' camp on the cliffs. The buccaneers and musketeers carry the smuggled goods. {npc:259758} walks the camp too: keep an eye out for him."] = "Nach Nordosten die Küste entlang zum Lager der Piraten auf den Klippen. Die Freibeuter und Musketiere tragen die Schmuggelware. Auch {npc:259758} streift durch das Lager: Halte nach ihm Ausschau.",

	-- Step 65: Powderfuse Port
	["Back to the port, from the north pier west through the docks."] = "Zurück zum Hafen, vom Nordpier nach Westen durch die Docks.",
	-- {quest:95122} Unchecked Expansion
	["{quest:95122}: for later in this guide"] = "{quest:95122}: für später in diesem Guide",
	-- {quest:95123} A Blast Ye Scurvy Dogs!
	["{quest:95123}: for later in this guide"] = "{quest:95123}: für später in diesem Guide",
	-- {quest:95975} Her World
	["{quest:95975}: for later, the wildflowers west of the port"] = "{quest:95975}: für später, die Wildblumen westlich des Hafens",
	-- {quest:95293} Smuggler's Special · {npc:260390} Captain Bentcoin
	["{quest:95293}: for {npc:260390} at the pirates' camp"] = "{quest:95293}: für {npc:260390} im Lager der Piraten",

	-- Step 67: Beast Entrails as you go
	-- {item:268632} Beast Entrails
	["{item:268632} as you go"] = "{item:268632} nebenbei",
	-- {zone:2548} Riverglades · {item:268632} Beast Entrails · {npc:260231} Argo Brinewhistle · {npc:257001} Old Rot-Chum · {npc:263380} Ghostmaw
	["Most beasts in the {zone:2548} drop {item:268632} for {npc:260231}: the shore crawlers on this coast and the boars on the ridge west of the pirates.\nCareful: {npc:257001} (elite, 42), Komuk (a Horde elite, 45) and {npc:263380} (elite, 42) range over the zone's wilds: take your beasts away from them."] = "Die meisten Wildtiere in {zone:2548} lassen {item:268632} für {npc:260231} fallen: die Uferkriecher an dieser Küste und die Eber auf dem Kamm westlich der Piraten.\nVorsicht: {npc:257001} (Elite, 42), Komuk (ein Horde-Elite, 45) und {npc:263380} (Elite, 42) streifen durch die Wildnis des Gebiets: Zieh deine Wildtiere von ihnen weg.",

	-- Step 68: Level 44.4 on the Eastsea pirates
	["Level 44.4 on the Eastsea pirates"] = "Stufe 44.4 an den Ostmeerpiraten",
	-- {npc:259758} Gul'gash · {area:1517} Uldaman
	["Before the second wave: its raiders and bombardiers (43-45) and the pirates' ships after them are a level over you below 44.4. Top up on the first camp's buccaneers and musketeers (41-43) at its south-west end, away from the port. {npc:259758}, a rare elite of level 49, roams these cliffs: if you see him, keep well away. Or, with a group, run the {area:1517} dungeon instead."] = "Vor der zweiten Welle: Ihre Plünderer und Bombardiere (43-45) und danach die Schiffe der Piraten sind unter 44.4 eine Stufe über dir. Füll an den Freibeutern und Musketieren (41-43) des ersten Lagers an dessen südwestlichem Ende auf, weg vom Hafen. {npc:259758}, ein Rare-Elite der Stufe 49, streift über diese Klippen: Wenn du ihn siehst, halte dich fern. Oder lauf stattdessen mit einer Gruppe den Dungeon {area:1517}.",
	-- {npc:257901} Eastsea Buccaneer
	["grind on {npc:257901}"] = "farme {npc:257901}",

	-- Step 69: The pirates' second wave
	["The pirates' second wave"] = "Die zweite Welle der Piraten",
	-- {npc:259758} Gul'gash
	["North along the coast from the port: the Eastsea raiders and bombardiers have dug in on the slopes west of the buccaneers' camp, among their powder kegs. They stand close together: pull them one at a time. {npc:259758}, a rare elite of level 49, roams these cliffs and the beach below: if you see him, keep well away."] = "Vom Hafen nach Norden die Küste entlang: Die Plünderer und Bombardiere der Eastsea haben sich an den Hängen westlich des Freibeuterlagers zwischen ihren Pulverfässern verschanzt. Sie stehen dicht beieinander: Zieh sie einzeln. {npc:259758}, ein Rare-Elite der Stufe 49, streift über diese Klippen und den Strand darunter: Wenn du ihn siehst, halte dich fern.",

	-- Step 70: Captain Bentcoin
	-- {npc:260390} Captain Bentcoin · {npc:260391} Captain Haynes
	["East along the cliffs to the far end of the pirates' camp: {npc:260390} waits by the water, {npc:260391} beside him."] = "Nach Osten die Klippen entlang zum hinteren Ende des Piratenlagers: {npc:260390} wartet am Wasser, {npc:260391} neben ihm.",

	-- Step 71: Powderfuse Port
	["Back to the port."] = "Zurück zum Hafen.",

	-- Step 72: The pirates' ships
	["The pirates' ships"] = "Die Schiffe der Piraten",
	-- {quest:95124} Admiral Lamora · {npc:259758} Gul'gash
	["Out to the pirates' cliffs once more. Plant Whizzbuzz's charges on the three ships moored below the camp, south to north; {quest:95124} (level 45) stands by the middle one, with her loot chest beside her. Keep an eye out for {npc:259758} on the way."] = "Noch einmal hinaus zu den Klippen der Piraten. Platziere Whizzbuzz' Ladungen an den drei Schiffen, die unterhalb des Lagers vor Anker liegen, von Süden nach Norden; {quest:95124} (Stufe 45) steht beim mittleren, mit ihrer Beutetruhe neben sich. Halte unterwegs nach {npc:259758} Ausschau.",
	-- {item:268505} Remote Explosive Charge
	["{item:268505}, the southern ship"] = "{item:268505}, das südliche Schiff",
	["the middle ship"] = "das mittlere Schiff",
	["the northern ship"] = "das nördliche Schiff",

	-- Step 73: Rotflesh Mushrooms
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom
	["Rotflesh Mushrooms"] = "Faulfleischpilze",
	-- plural, as words: Rotflesh Mushrooms = {item:268664} Rotflesh Mushroom · Mature Paletusks = {npc:255851} Mature Paletusk
	["West from the northern ship, up the ridge: the Rotflesh Mushrooms grow among the rocks, close to the Twilight ogres' camp. The Mature Paletusks on the ridge give entrails too."] = "Westlich vom nördlichen Schiff den Grat hinauf: Die Faulfleischpilze wachsen zwischen den Felsen, nahe dem Lager der Oger des Schattenhammers. Die Ausgewachsenen Bleichhauer auf dem Grat geben ebenfalls Innereien.",

	-- Step 74: Bolder'ok
	-- {area:16726} Bolder'ok · {npc:259057} Dunston Willis
	["North-west to {area:16726}, the ogres' town. Its ogres side with the Horde and attack you on sight, and Clugfist on his hill in the middle is an elite (level 50): keep to the town's north-eastern edge, where {npc:259057} hides."] = "Nach Nordwesten nach {area:16726}, der Stadt der Oger. Ihre Oger stehen auf der Seite der Horde und greifen dich sofort an, und Clugfist auf seinem Hügel in der Mitte ist Elite (Stufe 50): Halte dich am nordöstlichen Rand der Stadt, wo sich {npc:259057} versteckt.",

	-- Step 75: Gronok's Key
	-- {npc:263749} Gronok the Butcher · {npc:259057} Dunston Willis · {item:275043} Bloodmaster's Ring
	["{npc:263749} (level 44) carries the key: he paces the lanes south of {npc:259057}'s hut.\nThe {item:275043} lies just west of the lanes: its fighters (elites, 41-45) only fight in a bout, so leave them be."] = "{npc:263749} (Stufe 44) trägt den Schlüssel: Er läuft die Gassen südlich der Hütte von {npc:259057} ab.\nDer {item:275043} liegt gleich westlich der Gassen: Seine Kämpfer (Elite, 41-45) kämpfen nur in einem Duell, also lass sie in Ruhe.",

	-- Step 76: Dunston Willis
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["Free him, then get him out: {npc:259057} fights his way out of {area:16726}, and you keep the ogres off him. If he falls, take the quest from him again."] = "Befreie ihn und bring ihn raus: {npc:259057} kämpft sich aus {area:16726} heraus, und du hältst ihm die Oger vom Leib. Stirbt er, nimm die Quest erneut bei ihm an.",
	-- {npc:259057} Dunston Willis · {area:16726} Bolder'ok
	["help {npc:259057} break out of {area:16726}"] = "Hilf {npc:259057}, aus {area:16726} auszubrechen",

	-- Step 77: Finish the Beast Entrails
	-- {item:268632} Beast Entrails
	["Finish the {item:268632}"] = "Sammle die restlichen {item:268632}",
	-- {npc:259758} Gul'gash
	["South-east out of the hills towards the port: the shore crawlers on the beach north of the docks are the quickest entrails. {npc:259758} wanders down to this beach too."] = "Nach Südosten aus den Hügeln Richtung Hafen: Die Uferkriecher am Strand nördlich der Docks liefern die Innereien am schnellsten. Auch {npc:259758} wandert zu diesem Strand hinunter.",

	-- Step 78: Powderfuse Port
	["Down to the port."] = "Hinunter zum Hafen.",
	-- {quest:95267} The Monster Surfaces · {npc:257001} Old Rot-Chum
	["{quest:95267}: a big beast in the shallows south-west of the port, near {npc:257001}, the elite"] = "{quest:95267}: ein großes Ungeheuer im seichten Wasser südwestlich des Hafens, nahe {npc:257001}, dem Elite",

	-- Step 79: The Monster Surfaces
	-- {npc:260244} Monstrous Threshadon · {npc:257001} Old Rot-Chum
	["The {npc:260244} prowls the shallows south-west of the port, below the murlocs' beaches. {npc:257001}, an elite, walks the shore close by: give him room."] = "{npc:260244} streift durch das seichte Wasser südwestlich des Hafens, unterhalb der Strände der Murlocs. {npc:257001}, ein Elite, läuft ganz in der Nähe am Ufer entlang: Halte Abstand zu ihm.",

	-- Step 81: The meadows
	["The meadows"] = "Die Wiesen",
	-- {npc:263367} Sleebo Fizzlespout
	["West of the port, the wildflowers grow in the meadows below {npc:263367}'s workshop."] = "Westlich des Hafens wachsen die Wildblumen auf den Wiesen unterhalb der Werkstatt von {npc:263367}.",

	-- Step 82: Farholde Keep
	-- {area:16724} Farholde Keep · {npc:257558} Demar Brant
	["South-west across the plains to {area:16724}: {npc:257558} in the keep at the east end."] = "Nach Südwesten über die Ebene nach {area:16724}: {npc:257558} in der Burg am östlichen Ende.",

	-- Step 83: Demar Brant
	-- {quest:94887} Saving Marshal Ryan
	["{quest:94887}: for later in this guide"] = "{quest:94887}: für später in diesem Guide",

	-- Step 86: Brother Lowley
	-- {npc:263613} Brother Lowley · {npc:262031} Sister Rowland
	["{npc:263613} tends the wounded beside the barracks: bandage three of his soldiers, then he has a note for {npc:262031} in the cathedral."] = "{npc:263613} versorgt die Verwundeten neben der Kaserne: Verbinde drei seiner Soldaten, dann hat er eine Nachricht für {npc:262031} in der Kathedrale.",
	-- {item:272126} Makeshift Bandages
	-- plural, as words: Wounded Soldiers = {npc:263614} Wounded Soldier
	["{item:272126}, on the Wounded Soldiers beside him"] = "{item:272126}, an den Verwundeten Soldaten neben ihm",

	-- Step 87: Farholde Keep, the west side
	-- {area:16724} Farholde Keep
	["{area:16724}, the west side"] = "{area:16724}, die Westseite",
	-- {npc:263089} Tessa Dawnbright · {npc:259859} Wheatley
	["West through the keep: {npc:263089} by the orchard, then the cathedral and {npc:259859} south of the inn if you have their errands."] = "Nach Westen durch die Burg: {npc:263089} beim Obstgarten, dann die Kathedrale und {npc:259859} südlich des Gasthauses, falls du Aufträge für sie hast.",

	-- Step 88: Sister Rowland
	-- {quest:96084} Something's in the Water
	["{quest:96084}: for later in this guide"] = "{quest:96084}: für später in diesem Guide",

	-- Step 90: Something's in the Water
	-- {area:16729} Terral's Watch · {npc:262031} Sister Rowland
	["North past {area:16729}: fill {npc:262031}'s phial in the marsh water north-east of the tower."] = "Nach Norden an {area:16729} vorbei: Füll die Phiole von {npc:262031} im Sumpfwasser nordöstlich des Turms.",

	-- Step 91: Terral's Watch
	-- {npc:259352} Watcher Cornelius
	["{npc:259352}'s tower."] = "Turm von {npc:259352}.",

	-- Step 93: Turner's Logging Camp
	-- {area:16736} Turner's Logging Camp · {npc:263380} Ghostmaw
	-- plural, as words: Peasant Woodpiles = {object:645516} Peasant Woodpile
	["West across the river to {area:16736}: the Peasant Woodpiles around the camp give the wood bundles.\nCareful: {npc:263380}, an elite (level 42), prowls the river by the camp: if he comes your way, back off and let him pass."] = "Nach Westen über den Fluss nach {area:16736}: Die Holzstapel der Bauern rund um das Lager geben die Holzbündel.\nVorsicht: {npc:263380}, ein Elite (Stufe 42), streift am Fluss beim Lager umher: Kommt er in deine Richtung, zieh dich zurück und lass ihn vorbeiziehen.",

	-- Step 94: Sergeant Riftan
	-- {area:16685} Twilight's Shroud · {npc:258023} Sergeant Riftan
	["North up the long valley towards {area:16685}: {npc:258023} holds a small camp below the Twilight cult's fortress."] = "Nach Norden das lange Tal hinauf Richtung {area:16685}: {npc:258023} hält ein kleines Lager unterhalb der Festung des Schattenhammerkults.",

	-- Step 95: The Twilight camps
	["The Twilight camps"] = "Die Lager des Schattenhammers",
	-- {npc:258652} Twilight Thrall · {npc:257591} Ashe Amberhall · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["The cult's camps fill the valley north and west of Riftan. Free the captive Farholde Scouts as you find them, and kill a {npc:258652} for {npc:257591}: her soulstone takes it. Twilight Enforcers (elites, level 45) patrol through the camps: watch where they walk before each pull. {npc:256881} and {npc:256891} (elites, 46) hold the fortress at the valley's head: pull the cultists away from them."] = "Die Lager des Kults füllen das Tal nördlich und westlich von Riftan. Befreie die gefangenen Späher von Farholde, wenn du sie findest, und töte einen {npc:258652} für {npc:257591}: Ihr Seelenstein nimmt ihn auf. Twilight-Vollstrecker (Elite, Stufe 45) patrouillieren durch die Lager: Achte vor jedem Pull auf ihre Laufwege. {npc:256881} und {npc:256891} (Elite, 46) halten die Festung am Ende des Tals: Zieh die Kultisten von ihnen weg.",
	-- plural, as words: Farholde Scouts = {npc:256904} Farholde Scout
	["free five captive Farholde Scouts"] = "Befreie fünf gefangene Späher von Farholde",
	-- {npc:258652} Twilight Thrall
	["kill a {npc:258652}"] = "Töte einen {npc:258652}",

	-- Step 96: Marshal Ryan
	-- {npc:257250} Marshal Ryan · {npc:256881} Overlord Kilgar · {npc:256891} Executioner Morg
	["{npc:257250} lies wounded among the camps at the valley's western edge.\nCareful: {npc:256881} and {npc:256891} (elites, 46) hold the fortress north of him: come at Ryan from the south."] = "{npc:257250} liegt verwundet zwischen den Lagern am Westrand des Tals.\nVorsicht: {npc:256881} und {npc:256891} (Elite, 46) halten die Festung nördlich von ihm: Nähere dich Ryan von Süden.",
	-- {npc:257250} Marshal Ryan
	["find {npc:257250} and talk to him"] = "Finde {npc:257250} und sprich mit ihm",
	-- {quest:94892} Dying Wish · {npc:257558} Demar Brant · {area:16724} Farholde Keep
	["{quest:94892}: for {npc:257558} in {area:16724}"] = "{quest:94892}: für {npc:257558} in {area:16724}",

	-- Step 97: The ogre mine
	["The ogre mine"] = "Die Ogermine",
	-- plural, as words: Twilight Subjugators = {npc:260996} Twilight Subjugator · Twilight Enforcers = {npc:256800} Twilight Enforcer
	["North of the camps the cult works ogre miners in a mine, driven by the Twilight Subjugators.\nCareful: Twilight Enforcers (elites, level 45) walk past the mine's mouth on their way through the camps. Wait for one to pass before you go in, and pull the miners and Subjugators back out to you."] = "Nördlich der Lager lässt der Kult Ogerminenarbeiter in einer Mine schuften, angetrieben von den Unterwerfern des Schattenhammers.\nVorsicht: Twilight-Vollstrecker (Elite, Stufe 45) laufen auf ihrem Weg durch die Lager am Mineneingang vorbei. Warte, bis einer vorbei ist, bevor du hineingehst, und zieh die Arbeiter und Unterwerfer zu dir nach draußen.",

	-- Step 99: Bring Me His Head
	-- {npc:256881} Overlord Kilgar
	["{npc:256881} is an elite (level 46) in the fortress at the head of the valley, with the Enforcers around him: grouping up is advised."] = "{npc:256881} ist ein Elite (Stufe 46) in der Festung am Ende des Tals, umgeben von den Vollstreckern: Eine Gruppe wird empfohlen.",
	-- {quest:94891} News to Farholde · {npc:257591} Ashe Amberhall
	["{quest:94891}: for {npc:257591}"] = "{quest:94891}: für {npc:257591}",

	-- Step 100: Back to Farholde Keep
	-- {area:16724} Farholde Keep
	["Back to {area:16724}"] = "Zurück nach {area:16724}",
	-- {area:16724} Farholde Keep
	["Your hearthstone is bound at {area:16724}'s inn: use it, or ride back south to the keep."] = "Dein Ruhestein ist im Gasthaus von {area:16724} gebunden: Benutze ihn oder reite zurück nach Süden zur Burg.",

	-- Step 101: Farholde Keep
	-- {npc:260070} Bertrand Ironbrow · {npc:257558} Demar Brant · {npc:257591} Ashe Amberhall
	["From the inn: {npc:260070} on the way in, then {npc:257558} and {npc:257591} in the keep."] = "Vom Gasthaus aus: {npc:260070} auf dem Weg hinein, dann {npc:257558} und {npc:257591} in der Burg.",

	-- Step 103: Demar Brant
	-- {quest:94893} Delivering Closure · {npc:278088} Abigail Lawson · {zone:1453} Stormwind
	["{quest:94893}: for {npc:278088} in {zone:1453}"] = "{quest:94893}: für {npc:278088} in {zone:1453}",

	-- Step 104: The Twilight Threat
	-- {npc:257558} Demar Brant · {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep
	["{npc:257558}: Kilgar's head for {npc:1748} in {object:2117}"] = "{npc:257558}: Kilgars Kopf für {npc:1748} in {object:2117}",

	-- Step 105: Sister Rowland
	-- {npc:262031} Sister Rowland
	["{npc:262031}, in the cathedral at the keep's south-west corner."] = "{npc:262031}, in der Kathedrale an der Südwestecke der Festung.",

	-- Step 106: Stormwind
	-- {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind · {npc:278088} Abigail Lawson · {object:2098} Cathedral Square
	["{npc:257087} flies to {zone:1453}. {npc:278088} waits in the {object:2098}."] = "{npc:257087} fliegt nach {zone:1453}. {npc:278088} wartet auf dem {object:2098}.",

	-- Step 108: Train before the Badlands
	-- {zone:1418} Badlands
	["Train before the {zone:1418}"] = "Vor dem {zone:1418} trainieren",
	-- {zone:2548} Riverglades · {zone:1418} Badlands · {zone:1425} Hinterlands · {npc:257087} Gretchen Mayberry · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}, and the {zone:1418} & {zone:1425} guide passes none: {npc:257087} flies to {zone:1453}, where you train before you go on."] = "Im {zone:2548} gibt es keinen Klassenlehrer, und der Guide für {zone:1418} & {zone:1425} kommt an keinem vorbei: {npc:257087} fliegt nach {zone:1453}, wo du trainierst, bevor du weiterziehst.",

	-- Step 109: Your class trainer
	["Your class trainer"] = "Dein Klassenlehrer",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind
	["No class trainer stands in the {zone:2548}: train here in {zone:1453} before you fly on."] = "Im {zone:2548} gibt es keinen Klassenlehrer: Trainiere hier in {zone:1453}, bevor du weiterfliegst.",

	-- Step 110: Stormwind flight master
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Flugmeister von {zone:1453}",

	-- Step 111: Shaman trainer
	["Shaman trainer"] = "Schamanenlehrer",
	-- {zone:2548} Riverglades · {zone:1453} Stormwind · {zone:1418} Badlands · {zone:1425} Hinterlands · {area:1537} Ironforge · {area:144} Thelsamar
	["No shaman trainer stands in the {zone:2548} or in {zone:1453}, and the {zone:1418} & {zone:1425} guide passes none: fly to {area:1537} and train there; {area:144} is a short flight on."] = "Weder im {zone:2548} noch in {zone:1453} gibt es einen Schamanenlehrer, und der Guide für {zone:1418} & {zone:1425} kommt an keinem vorbei: Flieg nach {area:1537} und trainiere dort; {area:144} ist nur ein kurzer Flug weiter.",

	-- Step 112: Leave Stormwind
	-- {zone:1453} Stormwind
	["Leave {zone:1453}"] = "{zone:1453} verlassen",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar · {zone:1453} Stormwind · {object:2096} Trade District
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}. {zone:1453}'s gryphon master stands in the {object:2096}."] = "Der nächste Guide beginnt im {zone:1418}, südlich von {zone:1432}: Flieg nach {area:144}. Der Greifenmeister von {zone:1453} steht im Bereich {object:2096}.",

	-- Step 113: Loch Modan
	-- {area:144} Thelsamar · {zone:1455} Ironforge · {area:2257} Deeprun Tram · {zone:1453} Stormwind · {zone:1426} Dun Morogh · {zone:1432} Loch Modan
	["No flight path to {area:144} yet: go to {zone:1455} (by the {area:2257} from {zone:1453}), ride out of its gates east through {zone:1426} and the tunnel into {zone:1432}, and on along the road to {area:144}."] = "Noch keine Flugroute nach {area:144}: Geh nach {zone:1455} (mit der {area:2257} von {zone:1453} aus), reite aus den Toren nach Osten durch {zone:1426} und den Tunnel nach {zone:1432} und weiter die Straße entlang nach {area:144}.",

	-- Step 114: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Flieg nach {area:144}",
	-- {zone:1418} Badlands · {zone:1432} Loch Modan · {area:144} Thelsamar
	["The next guide starts in the {zone:1418}, south of {zone:1432}: fly to {area:144}."] = "Der nächste Guide beginnt im {zone:1418}, südlich von {zone:1432}: Flieg nach {area:144}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{item:17028}, from {npc:272437}"] = "{item:17028}, von {npc:272437}",
	-- ["{npc:262031} keeps the old cathedral at the south-west corner of {area:16724}. The bats roost in its upper floor; {npc:272437} hands out the holy candles beside it; the graves are in the chapel graveyard.\n{npc:271742}, an elite of level 53, stands in the cathedral: he leaves you be, so never attack him, and pull the bats away from him."] = "{npc:262031} hütet die alte Kathedrale in der Südwestecke von {area:16724}. Die Fledermäuse nisten im Obergeschoss; {npc:272437} verteilt daneben die heiligen Kerzen; die Gräber liegen auf dem Kapellenfriedhof.\n{npc:271742}, ein Elite der Stufe 53, steht in der Kathedrale: Er lässt dich in Ruhe, also greif ihn nie an und zieh die Fledermäuse von ihm weg.",
}
