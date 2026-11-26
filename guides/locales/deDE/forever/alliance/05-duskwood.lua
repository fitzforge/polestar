-- German (deDE): the guide forever/alliance/05-duskwood (forever/alliance/05-duskwood.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Flieg nach {area:42}",
	-- {area:42} Darkshire · {zone:1431} Duskwood · {area:69} Lakeshire
	["Fly to {area:42} for {zone:1431}'s second loop: from {area:69}'s gryphon master if you come from the Redridge guide."] = "Fliege zu {area:42} für den zweiten Loop von {zone:1431}: vom Gryphonschreiber von {area:69}, falls du vom Redridge-Guide kommst.",

	-- Step 2: Blind Mary
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	["Her house stands on the hill south-east of {area:42}, above the {area:121}."] = "Ihr Haus steht auf dem Hügel südöstlich von {area:42}, oberhalb des {area:121}.",
	["Inside"] = "Drinnen",
	-- {item:1946} Mary's Looking Glass · {npc:511} Insane Ghoul
	["{item:1946}: the {npc:511}, in the crypt of the cemetery just below"] = "{item:1946}: der {npc:511}, in der Krypta des Friedhofs direkt darunter",

	-- Step 3: Tranquil Gardens Cemetery
	-- {npc:511} Insane Ghoul · {area:121} Tranquil Gardens Cemetery · {area:42} Darkshire
	["The {npc:511} (26) hides in the small crypt by the {area:121}, south of {area:42}; the glass is inside."] = "Der {npc:511} (26) versteckt sich in der kleinen Gruft neben dem {area:121}, südlich von {area:42}; das Glas ist drinnen.",
	-- {item:1946} Mary's Looking Glass
	["{item:1946}; inside"] = "{item:1946}; drinnen",
	-- {quest:337} An Old History Book · {zone:1431} Duskwood
	["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: seltene Beute von Gegnern im {zone:1431}",

	-- Step 4: Viktori Prism'Antras
	-- {area:42} Darkshire · {npc:276} Viktori Prism'Antras
	["North into {area:42}: {npc:276}'s house stands at the east end of town, on the way in."] = "Nördlich hinein nach {area:42}: Das Haus von {npc:276} steht am östlichen Ende der Stadt, auf dem Weg hinein.",
	-- {npc:276} Viktori Prism'Antras
	["{npc:276}, inside"] = "{npc:276}, drinnen",
	-- {quest:177} Look to the Stars · {zone:1431} Duskwood
	["{quest:177}: the ogres of Vul'Gol, on your {zone:1431} return"] = "{quest:177}: die Oger von Vul'Gol, auf dem Weg zurück nach {zone:1431}",

	-- Step 6: Abercrombie
	["Head west along the road once more."] = "Geh noch einmal nach Westen entlang der Straße.",

	-- Step 7: Raven Hill Cemetery: kill these as you meet them
	-- {area:492} Raven Hill Cemetery
	["{area:492}: kill these as you meet them"] = "{area:492}: Töte diese, wenn sie dir begegnen",
	-- {npc:311} Sven Yorgen · {area:94} Raven Hill · {npc:522} Mor'Ladim
	-- plural, as words: Skeletal Fiends = {npc:531} Skeletal Fiend · Skeletal Horrors = {npc:202} Skeletal Horror
	["On the way west to {npc:311}: Skeletal Fiends and Skeletal Horrors walk the cemetery's southern half, north of {area:94}. {npc:522}, an elite, wanders the graves: keep away from him."] = "Auf dem Weg nach Westen zu {npc:311}: Skelettsatanskreaturen und Skelettschrecken laufen in der südlichen Hälfte des Friedhofs, nördlich von {area:94}. {npc:522}, ein Elite, wandert zwischen den Gräbern: Halte dich von ihm fern.",

	-- Step 8: Gooey Spider Legs
	-- plural, as words: Gooey Spider Legs = {item:2251} Gooey Spider Leg
	["Gooey Spider Legs"] = "Gooey Spider Legs",
	-- {npc:311} Sven Yorgen
	-- plural, as words: Carrion Recluses = {npc:949} Carrion Recluse · Venom Web Spiders = {npc:217} Venom Web Spider · Pygmy Venom Web Spiders = {npc:539} Pygmy Venom Web Spider · Green Recluses = {npc:569} Green Recluse
	["Carrion Recluses lurk in the woods on the way west, and Venom Web Spiders, Pygmy Venom Web Spiders and Green Recluses crawl just south of {npc:311}'s camp: each can drop a leg."] = "Carrion Recluses lauern in den Wäldern auf dem Weg nach Westen, und Venom Web Spiders, Pygmy Venom Web Spiders und Green Recluses krabbeln direkt südlich vom Lager von {npc:311}: Jede kann ein Bein fallen lassen.",

	-- Step 9: Lars
	-- {npc:893} Lars · {npc:311} Sven Yorgen
	["{npc:893}, at {npc:311}'s camp"] = "{npc:893}, am Lager von {npc:311}",

	-- Step 11: Moonbrook
	-- {quest:67} The Legend of Stalvan · {npc:311} Sven Yorgen · {zone:1436} Westfall · {area:20} Moonbrook · {object:3643} Old Footlocker · {area:42} Darkshire
	["{quest:67}: west from {npc:311}'s camp over the border into {zone:1436} and on to {area:20}, where the {object:3643} stands among the Defias (15-18). Then hearth back to {area:42}."] = "{quest:67}: westlich von {npc:311}s Lager über die Grenze nach {zone:1436} und weiter zu {area:20}, wo der {object:3643} zwischen den Defias (15-18) steht. Dann Ruhestein zurück nach {area:42}.",

	-- Step 12: Moonbrook
	-- {quest:67} The Legend of Stalvan · {object:3643} Old Footlocker · {area:20} Moonbrook · {area:42} Darkshire
	["{quest:67}: the {object:3643} in {area:20}, among the Defias (15-18), holds the next part. Then hearth back to {area:42}."] = "{quest:67}: {object:3643} in {area:20}, zwischen den Defias (15-18), enthält den nächsten Teil. Dann mit dem Ruhestein zurück nach {area:42}.",

	-- Step 13: Back to Darkshire
	-- {area:42} Darkshire
	["Back to {area:42}"] = "Zurück nach {area:42}",
	-- {area:42} Darkshire
	["Hearth back to {area:42} if you bound at the Scarlet Raven Tavern on the first loop, or head back east along the road."] = "Kehr per Ruhestein nach {area:42} zurück, wenn du auf der ersten Runde in der Scarlet Raven Tavern gebunden hast, oder geh die Straße wieder nach Osten zurück.",
	-- {npc:265} Madame Eva
	["{npc:265}, inside"] = "{npc:265}, drinnen",
	-- {npc:267} Clerk Daltry
	["{npc:267}, in the town hall"] = "{npc:267}, im Rathaus",
	-- {npc:264} Commander Althea Ebonlocke
	["{npc:264}, in the town hall"] = "{npc:264}, im Rathaus",
	-- {npc:264} Commander Althea Ebonlocke · {npc:289} Abercrombie
	-- plural, as words: Plague Spreaders = {npc:604} Plague Spreader
	["{npc:264}: the Plague Spreaders, with {npc:289}'s ghouls on the next trip west"] = "{npc:264}: die Seuchenverbreiter, mit {npc:289}'s Ghulen auf dem nächsten Ausflug nach Westen",
	-- {npc:273} Tavernkeep Smitts
	["{npc:273}, in the tavern"] = "{npc:273}, in der Taverne",

	-- Step 14: Clerk Daltry
	-- {quest:68} The Legend of Stalvan · {npc:267} Clerk Daltry
	["{quest:68}: {npc:267}, in the town hall, takes the footlocker's contents."] = "{quest:68}: {npc:267} im Rathaus nimmt den Inhalt der Fußkiste entgegen.",
	-- {npc:267} Clerk Daltry · {npc:295} Innkeeper Farley · {area:87} Goldshire · {zone:1453} Stormwind
	["{npc:267}: for {npc:295} in {area:87}, on the walk north to {zone:1453}"] = "{npc:267}: für {npc:295} in {area:87}, auf dem Weg nach Norden nach {zone:1453}",

	-- Step 15: Chef Grual
	-- {npc:272} Chef Grual
	["{npc:272} is in the Scarlet Raven Tavern too."] = "{npc:272} ist auch in der Scarlet Raven Tavern.",
	-- {npc:288} Jitters · {area:94} Raven Hill
	["For {npc:288}, at {area:94} on the way west"] = "Für {npc:288}, bei {area:94} auf dem Weg nach Westen",

	-- Step 16: Chef Grual
	-- {npc:272} Chef Grual
	["{npc:272} is in the Scarlet Raven Tavern."] = "{npc:272} ist im Scharlachroten Rabe Gasthaus.",

	-- Step 17: Rot Blossoms
	-- plural, as words: Rot Blossoms = {item:1598} Rot Blossom
	["Rot Blossoms"] = "Fäulnisblüten",
	-- {area:42} Darkshire · {area:121} Tranquil Gardens Cemetery
	-- plural, as words: Skeletal Horrors = {npc:202} Skeletal Horror · Rot Blossoms = {item:1598} Rot Blossom
	["Skeletal Horrors walk the hillside between {area:42} and the {area:121}, south-east of town; they drop the Rot Blossoms."] = "Skelettschrecken wandeln am Hang zwischen {area:42} und dem {area:121}, südöstlich des Orts; sie lassen die Fäulnisblüten fallen.",

	-- Step 19: Abercrombie
	["Head west to the hermit once more."] = "Geh noch einmal nach Westen zum Einsiedler.",

	-- Step 20: Ghoul Ribs
	-- plural, as words: Ghoul Ribs = {item:884} Ghoul Rib
	["Ghoul Ribs"] = "Ghulrippen",
	-- {area:492} Raven Hill Cemetery · {npc:522} Mor'Ladim · {npc:948} Rotted One · {spell:3428} Summon Flesh Eating Worms · {npc:503} Lord Malathrom · {npc:771} Commander Felstrom · {npc:1200} Morbent Fel
	-- plural, as words: Flesh Eaters = {npc:3} Flesh Eater · Bone Chewers = {npc:210} Bone Chewer · Plague Spreaders = {npc:604} Plague Spreader · Brain Eaters = {npc:570} Brain Eater
	["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters and Bone Chewers (24-27) are the easier kills; Plague Spreaders and Brain Eaters (27-29) drop them too. {npc:522}, an elite, wanders the graves: keep away from him.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds.\nCareful: {npc:503} (31) and {npc:771} (32), both rares, haunt the cemetery's north and west, and {npc:1200} (32, elite) keeps to the house at its western edge: leave them be."] = "Jeder Ghul in der nördlichen Hälfte von {area:492} kann eine Rippe fallen lassen: Fleischfresser und Knochenkauer (24-27) sind die leichteren Gegner; Seuchenverbreiter und Hirnfresser (27-29) lassen sie ebenfalls fallen. {npc:522}, ein Elite, wandert zwischen den Gräbern: Halte dich von ihm fern.\nVorsicht: Ein {npc:948} wirkt {spell:3428}, während er stirbt, was weitere Adds herbeiruft.\nVorsicht: {npc:503} (31) und {npc:771} (32), beide selten, spuken im Norden und Westen des Friedhofs, und {npc:1200} (32, Elite) hält sich am Haus am westlichen Rand auf: Lass sie in Ruhe.",
	-- {npc:604} Plague Spreader · {quest:58} The Night Watch
	["{npc:604}, for {quest:58}"] = "{npc:604}, für {quest:58}",

	-- Step 22: Jitters
	-- {npc:288} Jitters · {area:94} Raven Hill
	["{npc:288} hides in the house at the west end of {area:94}."] = "{npc:288} versteckt sich im Haus am Westende von {area:94}.",

	-- Step 25: Skeletal Raiders
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["Skeletal Raiders"] = "Skelett-Räuber",
	-- {area:492} Raven Hill Cemetery · {npc:311} Sven Yorgen · {npc:522} Mor'Ladim · {npc:771} Commander Felstrom
	-- plural, as words: Skeletal Raiders = {npc:1110} Skeletal Raider
	["From level 28: the Skeletal Raiders, Healers and Warders stand in the west part of the {area:492}, just east of {npc:311}'s camp.\nCareful: The Warders are 28-29 and the skeletons stand close together: pull one at a time.\nCareful: {npc:522}, an elite (35), wanders these graves too, and {npc:771} (32, rare) haunts the west part: keep away from both."] = "Ab Stufe 28: Die Skeletträuber, Healers und Warders stehen im Westteil des {area:492}, direkt östlich von {npc:311}s Lager.\nVorsicht: Die Warders sind 28-29 und die Skelette stehen dicht beieinander: Ziehe einen nach dem anderen.\nVorsicht: {npc:522}, eine Elite (35), streift ebenfalls durch diese Gräber, und {npc:771} (32, selten) spukt im Westteil herum: Halte dich von beiden fern.",

	-- Step 26: Sven Yorgen
	-- {zone:1453} Stormwind · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["Next: training, then the flight from {zone:1453} to {area:150} for the {zone:1437}."] = "Als Nächstes: Training, dann der Flug von {zone:1453} nach {area:150} für das {zone:1437}.",
	-- {npc:1212} Bishop Farthing · {zone:1453} Stormwind
	["For {npc:1212} in {zone:1453}'s Cathedral, on the walk north"] = "Für {npc:1212} in der Kathedrale von {zone:1453}, auf dem Weg nach Norden",

	-- Step 28: Agent Kearnen
	-- {area:94} Raven Hill · {zone:1436} Westfall · {npc:7024} Agent Kearnen · {npc:7053} Klaven Mortwake · {npc:7051} Malformed Defias Drone
	["Head west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Geh von {area:94} entlang der Straße nach Westen hinaus nach {zone:1436}. {npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln knapp hinter der Grenze. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel dazu; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- {item:7908} Klaven Mortwake's Journal
	["{item:7908}, in the chest"] = "{item:7908}, in der Truhe",

	-- Step 29: Master Mathias Shaw
	-- {area:1519} Stormwind · {object:2100} Old Town
	-- was: ["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Geh durch Elwynn nach Norden nach {zone:1453}; Mathias Shaw ist bei SI:7 in der {object:2100}."
	["Head north through Elwynn to {area:1519}; Mathias Shaw is at SI:7 in {object:2100}."] = "Geh nach Norden durch Elwynn nach {area:1519}; Mathias Shaw ist bei SI:7 in {object:2100}.",
	-- {npc:332} Master Mathias Shaw · {item:18160} Recipe: Thistle Tea
	["{npc:332}: Poisons, and {item:18160}"] = "{npc:332}: Gifte und {item:18160}",
	-- {quest:2607} The Touch of Zanzil · {npc:7207} Doc Mixilpixil
	["{quest:2607}: {npc:7207}, in the cellar of the Barracks"] = "{quest:2607}: {npc:7207}, im Keller der Kaserne",
	-- {npc:7207} Doc Mixilpixil
	["/lay down beside {npc:7207}"] = "/hinlegen neben {npc:7207}",
	-- {item:3372} Leaded Vial · {npc:1313} Maria Lumere
	["{item:3372}: {npc:1313}, Alchemy Supplies"] = "{item:3372}: {npc:1313}, Alchemiebedarf",
	-- {item:4371} Bronze Tube · {object:2096} Trade District · {npc:5519} Billibub Cogspinner
	["{item:4371}: the Auction House, {object:2096}; {npc:5519} keeps one and is nearly always sold out"] = "{item:4371}: das Auktionshaus, {object:2096}; {npc:5519} hat eine und ist fast immer ausverkauft",

	-- Step 30: Elwynn Forest
	-- {area:94} Raven Hill · {area:87} Goldshire · {zone:1453} Stormwind
	["North from {area:94} through Elwynn: {area:87} is on the road to {zone:1453}."] = "Von {area:94} nach Norden durch den Wald von Elwynn: {area:87} liegt an der Straße nach {zone:1453}.",

	-- Step 31: Class trainer
	["Class trainer"] = "Klassenlehrer",
	["Your new spells"] = "Deine neuen Zauber",

	-- Step 32: Innkeeper Farley
	-- {quest:69} The Legend of Stalvan · {npc:295} Innkeeper Farley · {area:87} Goldshire
	["{quest:69}: {npc:295} is in {area:87}'s Lion's Pride Inn; the chest with the letter is upstairs."] = "{quest:69}: {npc:295} ist im Lion's Pride Inn in {area:87}; die Kiste mit dem Brief steht oben.",
	-- {item:910} An Undelivered Letter · {object:1560} Storage Chest
	["{item:910}, from the {object:1560} upstairs"] = "{item:910}, von dem {object:1560} oben",

	-- Step 33: Caretaker Folsom
	-- {zone:1453} Stormwind · {npc:297} Caretaker Folsom · {object:1561} Sealed Crate
	["On into {zone:1453}: {npc:297} (the arrow shows him) takes the letter; the {object:1561} beside him holds the next clue."] = "Weiter nach {zone:1453}: {npc:297} (der Pfeil zeigt ihn) nimmt den Brief entgegen; der {object:1561} neben ihm enthält den nächsten Hinweis.",
	-- {object:1561} Sealed Crate
	["{object:1561}, beside him"] = "{object:1561}, neben ihm",

	-- Step 34: Bishop Farthing
	-- {zone:1453} Stormwind · {npc:1212} Bishop Farthing · {npc:1217} Glorin Steelbrow · {area:150} Menethil Harbor
	["On into {zone:1453}: {npc:1212} stands in the Cathedral of Light, on the way to the gryphon master. His next quest is for {npc:1217} in {area:150}, where the flight lands."] = "Weiter nach {zone:1453}: {npc:1212} steht in der Kathedrale des Lichts, auf dem Weg zum Greifenmeister. Seine nächste Quest ist für {npc:1217} in {area:150}, wo der Flug landet.",
	-- {npc:1212} Bishop Farthing
	["{npc:1212}, in the Cathedral of Light"] = "{npc:1212}, in der Kathedrale des Lichts",
	-- {npc:1217} Glorin Steelbrow · {area:150} Menethil Harbor · {zone:1437} Wetlands
	["For {npc:1217} in {area:150} (the {zone:1437} guide)"] = "Für {npc:1217} in {area:150} (der {zone:1437} Guide)",

	-- Step 35: Gazin Tenorm
	-- {zone:1453} Stormwind · {npc:6173} Gazin Tenorm · {npc:6171} Duthorian Rall
	["On into {zone:1453}: {npc:6173} and {npc:6171} are in the Cathedral of Light, on the way to the gryphon master."] = "Weiter nach {zone:1453}: {npc:6173} und {npc:6171} sind in der Kathedrale des Lichts, auf dem Weg zum Greifenmeister.",
	["Cathedral of Light"] = "Kathedrale des Lichts",

	-- Step 36: Gazin Tenorm
	-- {item:6846} Defias Script · {npc:6173} Gazin Tenorm · {quest:1787} The Tome of Divinity
	["The {item:6846} is already with {npc:6173}: take the last part of {quest:1787} from him, in the Cathedral of Light."] = "Das {item:6846} ist bereits bei {npc:6173}: nimm den letzten Teil von {quest:1787} von ihm, im Lichtdom.",

	-- Step 37: Duthorian Rall
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm
	["{npc:6171} stands in the Cathedral of Light, beside {npc:6173}."] = "{npc:6171} steht im Lichtdom, neben {npc:6173}.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: Erlösung",

	-- Step 38: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "Das {object:28027} von {zone:1453}",

	-- Step 39: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Tiefenbahn nach {zone:1455}",

	-- Step 40: Shaman training
	["Shaman training"] = "Schamanentraining",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm {area:2257} vom {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahr dann mit der Bahn zurück.",

	-- Step 41: Rogue training
	["Rogue training"] = "Schurkentraining",
	-- {zone:1453} Stormwind
	["Train here, in {zone:1453}, before you go on."] = "Lerne hier in {zone:1453}, bevor du weitergehst.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the {area:69} gryphon master: fly to {area:42} for {zone:1431}'s second loop."] = "Zurück zum Greifenmeister von {area:69}: Flieg nach {area:42} für die zweite Runde durch den {zone:1431}.",
	-- ["Continue west to {area:94}. The {object:673515} glows by the ruined house south of the road."] = "Geh weiter nach Westen nach {area:94}. Die {object:673515} leuchtet beim zerstörten Haus südlich der Straße.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters and Bone Chewers (24-27) are the easier kills; Plague Spreaders and Brain Eaters (27-29) drop them too. {npc:522}, an elite, wanders the graves: keep away from him.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "Jeder Ghul in der nördlichen Hälfte von {area:492} kann eine Rippe fallen lassen: Fleischfresser und Knochenkauer (24-27) sind leichter zu töten; Seuchenverbreiter und Hirnfresser (27-29) lassen sie auch fallen. {npc:522}, ein Elite, wandert zwischen den Gräbern: Halte dich von ihm fern.\nVorsicht: Ein {npc:948} wirkt beim Sterben {spell:3428}, was zusätzliche Adds herbeiruft.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters."] = "Jeder Ghul der nördlichen Hälfte des {area:492} kann eine Rippe fallen lassen: Fleischfresser, Knochenkauer, Seuchenverbreiter und Hirnfresser.",
	-- ["Every ghoul of the {area:492}'s northern half can drop a rib: Flesh Eaters, Bone Chewers, Plague Spreaders and Brain Eaters.\nCareful: A {npc:948} casts {spell:3428} as it dies, which brings extra adds."] = "Jeder Ghul in der nördlichen Hälfte des {area:492} kann eine Rippe fallen lassen: Flesh Eaters, Bone Chewers, Plague Spreaders und Brain Eaters.\nVorsicht: Ein {npc:948} wirkt beim Sterben {spell:3428}, was zusätzliche Adds herbeiruft.",
	-- ["Follow the road north-west past the cemetery to {npc:311}'s camp on the far west edge of the forest. {npc:893} stands beside {npc:311}."] = "Folge der Straße nach Nordwesten am Friedhof vorbei zu {npc:311}s Lager am äußersten Westrand des Waldes. {npc:893} steht neben {npc:311}.",
	-- ["Follow the road south from {area:1002} into {zone:1431}; {area:42} lies on the east side of the forest."] = "Folge der Straße von {area:1002} nach Süden in den {zone:1431}; {area:42} liegt auf der Ostseite des Waldes.",
	-- ["Head back east along the road to the {area:245}."] = "Geh zurück nach Osten entlang der Straße zum {area:245}.",
	-- ["Head back east to {area:42}."] = "Geh zurück nach Osten nach {area:42}.",
	-- ["Head north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Geh durch Elwynn nach Norden nach {zone:1453}; Mathias Shaw ist bei SI:7 in der {object:2100}.",
	-- ["Head south through the cemetery towards {area:94}. Skeletal Fiends and Skeletal Horrors walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Geh südlich durch den Friedhof in Richtung {area:94}. Skeletal Fiends und Skeletal Horrors laufen in seiner südlichen Hälfte umher. {npc:522}, ein Elite, wandert über die Gräber: Halte dich von ihm fern.",
	-- ["Head west along the road out of {area:94} into {area:40}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Geh von {area:94} entlang der Straße nach Westen hinaus nach {area:40}. {npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln knapp hinter der Grenze. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel dazu; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- ["Level 22 and 24 spells"] = "Zauber der Stufen 22 und 24",
	-- ["Next: {zone:1453} for training, then the boat from {area:17203} to {area:442} for {zone:1440}."] = "Als Nächstes: {zone:1453} zum Trainieren, dann das Boot vom {area:17203} nach {area:442} für {zone:1440}.",
	-- ["Rabid Dire Wolves roam the woods around the cemetery and {npc:289}, Starving Dire Wolves the hills north-east of him. Pygmy Venom Web Spiders crawl east of the cemetery and drop the venom. Every ghoul of the cemetery's northern half can drop a fang."] = "Tollwütige Terrorwölfe streifen durch den Wald um den Friedhof und {npc:289}, Ausgehungerte Terrorwölfe durch die Hügel nordöstlich von ihm. Zwerggiftweberspinnen krabbeln östlich des Friedhofs und lassen das Gift fallen. Jeder Ghul der nördlichen Friedhofshälfte kann einen Fangzahn fallen lassen.",
	-- ["Ride back east along the road to the {area:245}."] = "Reite die Straße zurück nach Osten zum {area:245}.",
	-- ["Ride back east to {area:42}."] = "Reite zurück nach Osten nach {area:42}.",
	-- ["Ride north through Elwynn to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "Reite nach Norden durch den Wald von Elwynn nach {zone:1453}; Mathias Shaw ist bei SI:7 in {object:2100}.",
	-- ["Ride west along the road once more."] = "Reite noch einmal die Straße nach Westen.",
	-- ["Ride west along the road out of {area:94} into {zone:1436}. {npc:7024} watches {npc:7053}'s tower from the hills just inside the border. The {npc:7051} (level 23) guarding the tower carries its key; Klaven's journal is in the chest at the top."] = "Reite die Straße nach Westen aus {area:94} hinaus nach {zone:1436}. {npc:7024} beobachtet den Turm von {npc:7053} von den Hügeln gleich hinter der Grenze. Die {npc:7051} (Stufe 23), die den Turm bewacht, trägt den Schlüssel; Klavens Tagebuch liegt in der Truhe ganz oben.",
	-- ["Ride west to the hermit once more."] = "Reite noch einmal nach Westen zum Einsiedler.",
	-- ["Skeletal Warriors and Skeletal Mages walk among the graves south-east of {area:42}, below {npc:302}'s house on the hill. Every skeleton in {zone:1431} can drop a {item:2378}."] = "Skelettkrieger und Skelettmagier wandeln zwischen den Gräbern südöstlich von {area:42}, unterhalb des Hauses von {npc:302} auf dem Hügel. Jedes Skelett im {zone:1431} kann einen {item:2378} fallen lassen.",
	-- ["The cemetery lies north of the village. Skeletal Horrors and Skeletal Fiends walk its southern half. {npc:522}, an elite, wanders the graves: keep away from him."] = "Der Friedhof liegt nördlich des Dorfs. Skelettschrecken und Skelettsatanskreaturen wandeln in seiner südlichen Hälfte. {npc:522}, ein Elite, wandert zwischen den Gräbern: Halte dich von ihm fern.",
	-- ["The hermit's shack stands in the woods north-east of the {area:492}."] = "Die Hütte des Einsiedlers steht im Wald nordöstlich des {area:492}.",
	-- ["The mound of loose dirt lies south of the farmhouse, by the old stump."] = "Der Haufen lockerer Erde liegt südlich des Bauernhauses, beim alten Baumstumpf.",
	-- ["Train in {zone:1453}, north through {zone:1429}. Then take the boat from {area:17203} to {area:442}."] = "Trainiere in {zone:1453}, nach Norden durch den {zone:1429}. Nimm dann das Boot vom {area:17203} nach {area:442}.",
	-- ["Wolves, spiders and ghouls"] = "Wölfe, Spinnen und Ghule",
	-- ["{area:492}, south"] = "{area:492}, Süden",
	-- ["{area:69} flight master"] = "Flugmeister von {area:69}",
	-- ["{item:1946}: the {npc:511} in the cemetery's crypt is level 26; it waits for the {zone:1431} return"] = "{item:1946}: Der {npc:511} in der Gruft des Friedhofs ist Stufe 26; er wartet auf deine Rückkehr in den {zone:1431}",
	-- ["{item:281046}, from the {object:673515}"] = "{item:281046}, von der {object:673515}",
	-- ["{item:4371}, from {npc:3133}: limited stock. Sold out? {npc:1448} in {area:150} sells it too."] = "{item:4371}, von {npc:3133}: begrenzter Vorrat. Ausverkauft? {npc:1448} in {area:150} verkauft sie auch.",
	-- ["{npc:2409}, at the north end of town"] = "{npc:2409}, am Nordende des Orts",
	-- ["{npc:265}, in her house by the tavern"] = "{npc:265}, in ihrem Haus bei der Taverne",
	-- ["{npc:268}, in the house behind the town hall"] = "{npc:268}, im Haus hinter dem Rathaus",
	-- ["{npc:276}'s house stands at the east end of town. {npc:3133} sells engineering goods in the house beside it."] = "{npc:276}s Haus steht am Ostende des Orts. {npc:3133} verkauft Ingenieursbedarf im Haus daneben.",
	-- ["{npc:332}: {spell:2842}, and {item:18160}"] = "{npc:332}: {spell:2842} und {item:18160}",
	-- ["{npc:633}, at the south end of town"] = "{npc:633}, am Südende des Orts",
	-- ["{npc:6790}, Scarlet Raven Tavern"] = "{npc:6790}, Taverne Zum Scharlachroten Raben",
	-- ["{npc:888} stands south of the road, at the {area:245}."] = "{npc:888} steht südlich der Straße, beim {area:245}.",
	-- ["{quest:337}: a rare drop from {zone:1431}'s mobs"] = "{quest:337}: seltene Beute von Gegnern im {zone:1431}",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the {area:442} boat."] = "{zone:1453} hat keinen Schamanenlehrer: Nimm die {area:2257} vom {object:28027} nach {zone:1455}, trainiere bei {npc:258098} und fahr dann mit der Bahn zurück zum Boot nach {area:442}.",
}
