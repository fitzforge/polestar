-- French (frFR): the guide forever/class/warrior/whirlwind-weapon (forever/class/warrior/whirlwind-weapon.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2458} Berserker Stance · {spell:1680} Whirlwind
	["{spell:2458} at 30 and a {spell:1680} axe, sword or warhammer at 40."] = "{spell:2458} au niveau 30 et une hache, une épée ou un marteau de guerre {spell:1680} au niveau 40.",

	-- Step 1: The Islander (Stormwind)
	-- {npc:5479} Wu Shen · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5479}, beside {npc:5480} in the warrior trainers' building of {object:2100}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "Au niveau 30, {npc:5479}, à côté de {npc:5480} dans le bâtiment des maîtres des guerriers de la {object:2100}, vous envoie voir {npc:6236} sur l'{area:720}, dans les {zone:1413}.",

	-- Step 2: The Islander (Ironforge)
	-- {npc:5113} Kelv Sternhammer · {zone:1455} Ironforge · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:5113}, the warrior trainer of {zone:1455}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "Au niveau 30, {npc:5113}, le maître des guerriers de {zone:1455}, vous envoie voir {npc:6236} sur l'{area:720}, dans les {zone:1413}.",

	-- Step 3: The Islander (Orgrimmar)
	-- {npc:3354} Sorek · {object:172958} Valley of Honor · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3354} in the {object:172958} sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "Au niveau 30, {npc:3354}, dans la {object:172958}, vous envoie voir {npc:6236} sur l'{area:720}, dans les {zone:1413}.",

	-- Step 4: The Islander (Thunder Bluff)
	-- {npc:3041} Torm Ragetotem · {zone:1456} Thunder Bluff · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:3041}, the warrior trainer of {zone:1456}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "Au niveau 30, {npc:3041}, le maître des guerriers des {zone:1456}, vous envoie voir {npc:6236} sur l'{area:720}, dans les {zone:1413}.",

	-- Step 5: The Islander (Undercity)
	-- {npc:4595} Baltus Fowler · {zone:1458} Undercity · {npc:6236} Klannoc Macleod · {area:720} Fray Island · {zone:1413} Barrens
	["At 30, {npc:4595}, a warrior trainer of the {zone:1458}, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "Au niveau 30, {npc:4595}, un maître des guerriers de {zone:1458}, vous envoie voir {npc:6236} sur l'{area:720}, dans les {zone:1413}.",

	-- Step 6: Fray Island
	-- {area:392} Ratchet · {area:391} Merchant Coast · {area:720} Fray Island · {npc:6236} Klannoc Macleod
	["Fly to {area:392} and go south along the {area:391}. {area:720} lies offshore to the south-east: wade across on the shallow sand bar; off it the water is deep and fatigue sets in. {npc:6236} stands by the arena."] = "Volez jusqu'à {area:392} et allez au sud le long de la {area:391}. L'{area:720} se trouve au large, au sud-est : traversez à gué par le banc de sable peu profond ; à côté, l'eau est profonde et la fatigue s'installe. {npc:6236} se tient près de l'arène.",

	-- Step 7: The Affray
	-- {npc:6248} Twiggy Flathead · {npc:6238} Big Will · {spell:1160} Demoralizing Shout
	["You have 10 minutes. Eat and drink to full, then step onto the grate in the middle of the crowd: {npc:6248} announces the challengers (level 26-27), who come one at a time, 15-20 seconds apart, and only while you stand near the grate. After each kill, step off the grate to eat or bandage; step back on when ready for the next. Six of them, then {npc:6238} (level 33, not elite) walks out; he stays neutral until you attack him, so bandage or eat first. Do not use {spell:1160}: it sends the challengers running and more of them pile in at once. If nothing starts, step off and on the grate again, or abandon the quest and take it again."] = "Vous avez 10 minutes. Mangez et buvez jusqu'à être plein, puis montez sur la grille au milieu de la foule : {npc:6248} annonce les adversaires (niveau 26-27), qui arrivent un par un, à 15-20 secondes d'intervalle, et seulement tant que vous êtes près de la grille. Après chaque victoire, descendez de la grille pour manger ou vous bander ; remontez quand vous êtes prêt pour le suivant. Il y en a six, puis {npc:6238} (niveau 33, pas élite) entre ; il reste neutre tant que vous ne l'attaquez pas, bandez-vous ou mangez donc d'abord. N'utilisez pas {spell:1160} : cela fait fuir les adversaires et ils reviennent ensuite à plusieurs. Si rien ne commence, descendez de la grille et remontez-y, ou abandonnez la quête et reprenez-la.",

	-- Step 8: Bath'rah the Windwatcher
	-- {npc:6176} Bath'rah the Windwatcher · {area:272} Tarren Mill · {zone:1416} Alterac Mountains · {area:271} Southshore · {quest:1712} Cyclonian · {item:6929} Bath'rah's Parchment · {item:3357} Liferoot · {quest:1714} Essence of the Exile
	-- plural, as words: Bloodscalp Tusks = {item:3901} Bloodscalp Tusk
	["{npc:6176} camps by ruins on the east bank of the river that runs past {area:272}, a short walk north-east of the town, just over the border in {zone:1416}; his cauldron stands beside him. Horde: fly to {area:272}. Alliance: fly to {area:271} and go north along the river; {area:272}'s guards are level 42 elites, so keep away from the town. Accepting {quest:1712} gives you {item:6929}, the list of what he needs: 8 {item:3357}, 30 Bloodscalp Tusks and the {quest:1714} from his cauldron. Click the cauldron for that quest."] = "{npc:6176} campe près de ruines sur la rive est de la rivière qui passe à {area:272}, à courte distance au nord-est du village, juste après la frontière des {zone:1416} ; son chaudron se trouve à côté de lui. Horde : volez jusqu'à {area:272}. Alliance : volez jusqu'à {area:271} et remontez la rivière vers le nord ; les gardes de {area:272} sont des élites de niveau 42, tenez-vous donc loin du village. Accepter {quest:1712} vous donne le {item:6929}, la liste de ce qu'il lui faut : 8 {item:3357}, 30 Défenses de Bloodscalp et l'{quest:1714} de son chaudron. Cliquez sur le chaudron pour cette quête.",

	-- Step 9: The exiles of Arathi
	["The exiles of Arathi"] = "Les exilés d'Arathi",
	-- {area:334} Circle of West Binding · {area:320} Refuge Pointe · {area:336} Circle of Outer Binding · {spell:403} Lightning Bolt · {area:333} Circle of East Binding · {area:321} Hammerfall · {spell:122} Frost Nova
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["The cauldron wants 8 of each charm, 24 in all, and each exile drops its charm about one kill in three, so plan on some 70 kills. All are level 38-39, not elite, and hit hard at 30-33: bring a friend or come at 35 or more. Burning Exiles (fire) by the {area:334} in the north-west, north-west of {area:320}; Thundering Exiles (air) by the {area:336} south-east of {area:320}, casting {spell:403} from 40 yards; Cresting Exiles (water) by the {area:333}, north-west of {area:321}, with {spell:122}. About a dozen of each, back in under 7 minutes. The charms trade and sell on the auction house; using one banishes another kind of exile for a while (Burning on Thundering, Thundering on Cresting, Cresting on Burning)."] = "Le chaudron veut 8 charmes de chaque sorte, 24 en tout, et chaque exilé lâche son charme environ une fois sur trois : comptez quelque 70 victimes. Tous sont de niveau 38-39, pas élites, et frappent fort au niveau 30-33 : venez avec un ami ou au niveau 35 ou plus. Les Exilés ardents (feu) près du {area:334}, au nord-ouest, au nord-ouest du {area:320} ; les Exilés foudroyants (air) près du {area:336}, au sud-est du {area:320}, qui lancent {spell:403} à 40 mètres ; les Exilés grimpeurs (eau) près du {area:333}, au nord-ouest de {area:321}, avec {spell:122}. Une douzaine de chaque, de retour en moins de 7 minutes. Les charmes s'échangent et se vendent à l'hôtel des ventes ; en utiliser un bannit un autre type d'exilé pour un temps (Ardent sur Foudroyant, Foudroyant sur Grimpeur, Grimpeur sur Ardent).",
	-- {item:4479} Burning Charm
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile
	["{item:4479}, from Burning Exiles"] = "{item:4479}, sur les Exilés ardents",
	-- {item:4480} Thundering Charm
	-- plural, as words: Thundering Exiles = {npc:2762} Thundering Exile
	["{item:4480}, from Thundering Exiles"] = "{item:4480}, sur les Exilés foudroyants",
	-- {item:4481} Cresting Charm
	-- plural, as words: Cresting Exiles = {npc:2761} Cresting Exile
	["{item:4481}, from Cresting Exiles"] = "{item:4481}, sur les Exilés grimpeurs",

	-- Step 10: Essence of the Exile
	-- {object:89931} Bath'rah's Cauldron · {quest:1714} Essence of the Exile
	["Put the 24 charms into {object:89931}: it hands you the {quest:1714}."] = "Mettez les 24 charmes dans le {object:89931} : il vous remet l'{quest:1714}.",
	-- {quest:1714} Essence of the Exile · {npc:6176} Bath'rah the Windwatcher
	["{quest:1714}, from the cauldron by {npc:6176}"] = "{quest:1714}, dans le chaudron près de {npc:6176}",

	-- Step 11: Liferoot
	-- {item:3357} Liferoot · {zone:1437} Wetlands · {zone:1417} Arathi Highlands · {zone:1434} Stranglethorn Vale · {npc:1302} Bernard Gump · {npc:1313} Maria Lumere · {zone:1453} Stormwind · {npc:844} Antonio Perelli · {area:460} Sun Rock Retreat · {zone:1441} Thousand Needles
	["You need 8 {item:3357}. Herbalists pick it by rivers and lakes in the {zone:1437}, {zone:1417} and {zone:1434}; otherwise the auction house. Herb vendors keep only one at a time and restock every two hours: {npc:1302} and {npc:1313} in {zone:1453}, {npc:844} on the road in eastern Elwynn, Jeeda at {area:460} in Stonetalon, Montarr in {zone:1441}. Kurzen Medicine Men in northern Stranglethorn drop one about one kill in twelve."] = "Il vous faut 8 {item:3357}. Les herboristes la cueillent au bord des rivières et des lacs des {zone:1437}, des {zone:1417} et de {zone:1434} ; sinon, l'hôtel des ventes. Les marchands d'herbes n'en ont qu'une à la fois et se réapprovisionnent toutes les deux heures : {npc:1302} et {npc:1313} à {zone:1453}, {npc:844} sur la route dans l'est de la forêt d'Elwynn, Jeeda à la {area:460} dans les Serres-Rocheuses, Montarr dans {zone:1441}. Les Guérisseurs Kurzen du nord de Strangleronce en lâchent une environ une fois sur douze.",

	-- Step 12: Bloodscalp Tusks
	-- plural, as words: Bloodscalp Tusks = {item:3901} Bloodscalp Tusk
	["Bloodscalp Tusks"] = "Défenses de Bloodscalp",
	-- {area:117} Grom'gol Base Camp · {area:123} Bal'lal Ruins
	["You need 30 tusks. Every Bloodscalp troll (level 33-37) of north-west Stranglethorn drops one about one kill in three, so plan on some 80 kills: the camps and ruins north and north-west of {area:117} and around the {area:123} on the coast. They enrage below 30% health and the Warriors disarm; back in 5 minutes."] = "Il vous faut 30 défenses. Chaque troll Bloodscalp (niveau 33-37) du nord-ouest de Strangleronce en lâche une environ une fois sur trois : comptez quelque 80 victimes. Les camps et les ruines au nord et au nord-ouest du {area:117}, et autour des {area:123} sur la côte. Ils enragent sous 30 % de vie et les Guerriers désarment ; de retour en 5 minutes.",

	-- Step 13: The Summoning
	-- {npc:6176} Bath'rah the Windwatcher · {quest:1713} The Summoning · {quest:1712} Cyclonian · {item:6052} Nature Protection Potion · {spell:10101} Knock Away · {item:6894} Whirlwind Heart
	["Back to {npc:6176}. Accepting {quest:1713} starts his ritual, and {quest:1712} appears just north of his camp. {quest:1712} is elite (level 40): grouping up is encouraged; it needs a group of two or three around level 40. It deals nature damage (a {item:6052} soaks it), whirls, and {spell:10101} throws you far while it heals itself as you run back: fight with your back to a slope or rock. The {item:6894} always drops. If the fight fails {npc:6176} stops answering: abandon {quest:1713} and take it again for a new summon; the earlier items are not needed again."] = "Retournez voir {npc:6176}. Accepter {quest:1713} lance son rituel, et {quest:1712} apparaît juste au nord de son camp. {quest:1712} est élite (niveau 40) : mieux vaut former un groupe ; il faut un groupe de deux ou trois vers le niveau 40. Il inflige des dégâts de nature (une {item:6052} les absorbe), tourbillonne, et {spell:10101} vous projette loin pendant qu'il se soigne le temps que vous reveniez : combattez dos à une pente ou à un rocher. Le {item:6894} tombe toujours. Si le combat échoue, {npc:6176} ne répond plus : abandonnez {quest:1713} et reprenez-la pour une nouvelle invocation ; les objets précédents ne sont pas redemandés.",
	-- {item:6894} Whirlwind Heart · {quest:1712} Cyclonian
	["{item:6894}, from {quest:1712}"] = "{item:6894}, sur {quest:1712}",
	-- {npc:6176} Bath'rah the Windwatcher · {item:6975} Whirlwind Axe
	["{npc:6176}: {item:6975}, Sword or Warhammer"] = "{npc:6176} : {item:6975}, épée ou marteau de guerre",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 30, {npc:5479} in {object:2100}, beside the Pig and Whistle, sends you to {npc:6236} on {area:720} in the {zone:1413}."] = "Au niveau 30, {npc:5479}, dans la {object:2100} à côté de la taverne du Cochon siffleur, vous envoie voir {npc:6236} sur l'{area:720}, dans les {zone:1413}.",
	-- ["Defeat the challengers and {npc:6238}"] = "Vainquez les adversaires et {npc:6238}",
	-- ["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Longez la côte vers le sud de {area:392} jusqu'à l'{area:720}. {npc:6236} se tient près de l'arène : montez sur la grille pour lancer le combat ; les adversaires arrivent un par un, puis {npc:6238} (33).",
	-- ["The Bloodscalp trolls hold the north-west of {zone:1434}; they drop the {item:3901}."] = "Les trolls Scalp-rouge occupent le nord-ouest de {zone:1434} ; ils laissent tomber la {item:3901}.",
	-- ["Three kinds of elemental exiles roam {zone:1417}: Burning Exiles in the north-west, Thundering Exiles in the middle, Cresting Exiles in the north-east. Each drops its charm."] = "Trois sortes d'exilés élémentaires errent dans les {zone:1417} : les Exilés ardents au nord-ouest, les Exilés foudroyants au centre, les Exilés grimpeurs au nord-est. Chacun laisse tomber son charme.",
	-- ["{item:3357}: {skill:182}, or the auction house"] = "{item:3357} : {skill:182}, ou l'hôtel des ventes",
	-- ["{item:4479} from the Burning Exiles"] = "{item:4479} sur les Exilés ardents",
	-- ["{item:4480} from the Thundering Exiles"] = "{item:4480} sur les Exilés foudroyants",
	-- ["{item:4481} from the Cresting Exiles"] = "{item:4481} sur les Exilés grimpeurs",
	-- ["{item:6894} from {quest:1712}"] = "{item:6894} sur {quest:1712}",
	-- ["{npc:6176} camps in the south-east of {zone:1416}, above {zone:1424}; his cauldron stands beside him. He asks for a {item:3357}, a {item:3901} and the {quest:1714}, which his cauldron brews from three charms."] = "{npc:6176} campe au sud-est des {zone:1416}, au-dessus des {zone:1424} ; son chaudron est à côté de lui. Il demande une {item:3357}, une {item:3901} et l'{quest:1714}, que son chaudron prépare à partir de trois charmes.",
	-- ["{quest:1712} waits just north of {npc:6176}'s camp and carries the {item:6894}. {quest:1712} is elite: grouping up is advised."] = "{quest:1712} attend juste au nord du camp de {npc:6176} et porte le {item:6894}. {quest:1712} est élite : un groupe est conseillé.",
}
