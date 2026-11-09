-- French (frFR): the guide forever/class/paladin/tyrs-watch (forever/class/paladin/tyrs-watch.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:7328} Redemption
	["Tyr's Watch and {spell:7328} (Forsaken)"] = "Tyr's Watch et {spell:7328} (Réprouvés)",
	-- {spell:7328} Redemption
	["{spell:7328} to raise fallen allies, plus a weapon and a shield for a new Forsaken paladin."] = "{spell:7328} pour ranimer les alliés tombés, plus une arme et un bouclier pour un nouveau paladin réprouvé.",

	-- Step 1: Aramis Hammerhand
	-- {npc:1569} Shadow Priest Sarvis · {item:282423} Consecrated Scroll · {quest:364} The Mindless Ones · {npc:244808} Aramis Hammerhand · {npc:259377} Injured Deathguard · {area:154} Deathknell · {spell:635} Holy Light
	["{npc:1569} gives you a {item:282423} after {quest:364}: read it, then bring it to {npc:244808} by the church. He asks you to heal five {npc:259377} lying around {area:154}. {spell:635} hurts a Forsaken paladin a little each time: watch your health."] = "",
	-- {npc:259377} Injured Deathguard · {spell:635} Holy Light
	["Heal 5 {npc:259377} with {spell:635}"] = "Soignez 5 {npc:259377} avec {spell:635}",

	-- Step 2: Coming to Terms
	-- {npc:244808} Aramis Hammerhand · {npc:246143} Frightened Paladin
	["At 4 {npc:244808} sends you after a {npc:246143} who fled into the hills west of the church, just south of the bat cave. Talk to her to offer aid: she turns on you, and you have to put her down (level 3, easy)."] = "Au niveau 4, {npc:244808} vous envoie à la recherche d'une {npc:246143} qui s'est enfuie dans les collines à l'ouest de l'église, juste au sud de la grotte des chauves-souris. Parlez-lui pour lui proposer votre aide : elle se retourne contre vous, et vous devez l'abattre (niveau 3, facile).",
	-- {npc:246143} Frightened Paladin
	["Talk to the {npc:246143}, then defeat her"] = "Parlez à la {npc:246143}, puis vainquez-la",

	-- Step 3: Shari Stilwell
	-- {area:154} Deathknell · {area:159} Brill · {npc:246152} Shari Stilwell
	["Follow the road east out of {area:154} to {area:159}. {npc:246152}, the paladin trainer, stands in town; she trains you from here on."] = "Suivez la route vers l'est en sortant de {area:154} jusqu'à {area:159}. {npc:246152}, la maîtresse des paladins, se tient dans le bourg ; c'est elle qui vous entraîne désormais.",

	-- Step 4: A Second Home
	-- {npc:246152} Shari Stilwell · {area:159} Brill · {quest:91317} The Tarnished · {area:16881} Shadowvale
	["At 8 {npc:246152} in {area:159} sends you to the order's keep on the west coast. {quest:91317} in {area:16881} and the crypt under it hit hard at 8-9: come at 10 or later."] = "Au niveau 8, {npc:246152} à {area:159} vous envoie au donjon de l'ordre sur la côte ouest. {quest:91317} à {area:16881} et la crypte en dessous frappent fort aux niveaux 8-9 : venez au niveau 10 ou plus tard.",

	-- Step 5: Bandarion Keep
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro · {quest:96896} A Righteous Cause · {npc:267009} Hadric Harlson · {area:159} Brill
	["{area:16602} stands on the bluffs north-west of the {area:156} (the road west starts near 29,46). {npc:246349} waits at the gate. {npc:246389}, the keep's trainer, and {npc:259190}, its stable master, stand at the forest's edge just south of him. They only have work for you from level 10 and after {quest:96896} from Leonid at the keep, the end of {npc:267009}'s chain that starts south-east of {area:159}; take their quests when you see them."] = "",

	-- Step 6: Murlocs at the Gates
	-- {area:16881} Shadowvale
	["The Vile Fin murlocs (level 9-11) lurk on the bluffs along the road east of the keep and in the camps around the lake to the south-west, on the way down to {area:16881}."] = "Les murlocs Aileron noir (niveau 9-11) rôdent sur les falaises le long de la route à l'est du donjon et dans les camps autour du lac au sud-ouest, en descendant vers {area:16881}.",
	-- plural, as words: Vile Fin Attackers = {npc:250283} Vile Fin Attacker
	["Vile Fin Attackers x8"] = "Attaquants aileron noir x8",
	-- plural, as words: Vile Fin Seers = {npc:250282} Vile Fin Seer
	["Vile Fin Seers x8"] = "Oracles aileron noir x8",

	-- Step 7: Touring the Grounds
	-- {npc:246349} Breton Samuels · {npc:246389} Hilda the Breaker · {npc:246394} Ander Solliden · {npc:246393} Jorin Croge · {npc:246378} Danitha Morr
	["{npc:246349} gives you a weapon, then sends you round the keep to speak with four of its people: {npc:246389} just south of the gate, {npc:246394}, the lookout, who walks the road south-east of the keep, then {npc:246393} and {npc:246378} inside the keep. Pick the conversation option with each."] = "",
	-- {npc:246349} Breton Samuels · {item:246164} Skullthumper · {item:246165} Driftwood Smasher
	["{npc:246349}: {item:246164} or {item:246165}"] = "{npc:246349} : {item:246164} ou {item:246165}",

	-- Step 8: Danitha Morr
	-- {npc:246378} Danitha Morr · {npc:246393} Jorin Croge · {quest:91317} The Tarnished
	["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it. {quest:91317} need level 9."] = "{npc:246378} dirige l'ordre depuis l'intérieur du donjon ; {npc:246393} se tient à côté. {quest:91317} demande le niveau 9.",

	-- Step 9: Shadowvale
	-- {quest:91317} The Tarnished · {area:16881} Shadowvale · {area:16616} Whispering Forest · {npc:259431} Rudolph Gelhardt
	["{quest:91317} (level 8-9) hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. Commander {npc:259431} (level 10) stands on the upper floor of a house, with Drudges below him: clear the ground floor first."] = "{quest:91317} (niveau 8-9) occupent le village en ruine de {area:16881}, dans la {area:16616}, au sud-ouest du donjon. Le commandant {npc:259431} (niveau 10) se tient à l'étage d'une maison, avec des Manoeuvres en dessous de lui : nettoyez d'abord le rez-de-chaussée.",
	-- plural, as words: Tarnished Drudges = {npc:259434} Tarnished Drudge
	["Tarnished Drudges x8"] = "Manoeuvres ternis x8",
	-- plural, as words: Tarnished Zealots = {npc:259433} Tarnished Zealot
	["Tarnished Zealots x6"] = "Zélotes ternis x6",

	-- Step 10: The crypt under Shadowvale
	-- {area:16881} Shadowvale
	["The crypt under {area:16881}"] = "La crypte sous {area:16881}",
	-- {item:246213} Sturdy Lumber · {npc:260396} Whispering Horror
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["The cellar is under the village, not on the surface: the way down is inside a burned-out house, where the arrow points. Twelve Lumber Piles (stacked beams) lie in the cellar, each good for one {item:246213}. {npc:260396}, an elite (level 11-13), sits at the far end: leave it alone."] = "La cave se trouve sous le village, pas en surface : l'accès est à l'intérieur d'une maison incendiée, là où pointe la flèche. Douze Tas de bois (des poutres empilées) se trouvent dans la cave, chacun donnant un {item:246213}. {npc:260396}, un élite (niveau 11-13), se tient tout au fond : laissez-le tranquille.",
	-- plural, as words: Lumber Piles = {object:554626} Lumber Pile
	["Lumber Piles, in the cellar: the way down is here"] = "Tas de bois, dans la cave : l'accès est ici",

	-- Step 11: Hilda the Breaker's bones
	-- {npc:246389} Hilda the Breaker
	["{npc:246389}'s bones"] = "Les ossements de {npc:246389}",
	-- plural, as words: Shadowvale Lurchers = {npc:260428} Shadowvale Lurcher · Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["The Shadowvale Lurchers and Mystics (level 8-10) in the crypt drop the Faintly Glowing Bones: about one in two from Lurchers, more from one kind of Mystic, less from the other."] = "Les Titubeurs et les Mystiques d'Ombreval (niveau 8-10) de la crypte laissent tomber les Os faiblement luminescents : environ une fois sur deux pour les Titubeurs, plus souvent pour un type de Mystique, moins pour l'autre.",
	-- plural, as words: Faintly Glowing Bones = {item:286259} Faintly Glowing Bone
	["Faintly Glowing Bones x6"] = "Os faiblement luminescents x6",

	-- Step 12: Ephram Barbaro's crystal
	-- {npc:259190} Ephram Barbaro
	["{npc:259190}'s crystal"] = "Le cristal de {npc:259190}",
	-- {item:286269} Glowing Crystal Fragment
	["The {item:286269}, a green crystal, lies on the floor in the left-hand part of the crypt."] = "Le {item:286269}, un cristal vert, est posé au sol dans la partie gauche de la crypte.",

	-- Step 13: Back to the keep
	["Back to the keep"] = "Retour au donjon",
	-- {npc:246378} Danitha Morr · {npc:259431} Rudolph Gelhardt
	["{npc:246378} hands you {npc:259431}'s head for Sylvanas: keep it in your bags, it is what you hand in."] = "{npc:246378} vous remet la tête de {npc:259431} pour Sylvanas : gardez-la dans vos sacs, c'est ce que vous rendez.",

	-- Step 14: Hilda the Breaker
	-- {npc:246389} Hilda the Breaker · {npc:259190} Ephram Barbaro
	["{npc:246389} and {npc:259190} wait at the forest's edge south of the gate."] = "{npc:246389} et {npc:259190} attendent à l'orée de la forêt, au sud de la porte.",

	-- Step 15: Ephram Barbaro
	-- {npc:259190} Ephram Barbaro · {npc:246389} Hilda the Breaker
	["{npc:259190} waits at the forest's edge south of the gate, a few steps west of {npc:246389}."] = "",

	-- Step 16: A Lesson in Divinity
	-- {npc:246378} Danitha Morr · {item:2589} Linen Cloth · {zone:1458} Undercity
	["{npc:246378} offers the first Lesson in Divinity at level 12. Bring 10 {item:2589} if you have it: the {zone:1458} asks for it next."] = "{npc:246378} propose la première Leçon de divinité au niveau 12. Apportez 10 {item:2589} si vous en avez : {zone:1458} vous en demande ensuite.",

	-- Step 17: The Undercity
	-- {area:159} Brill · {area:153} Ruins of Lordaeron · {zone:1458} Undercity · {npc:10181} Lady Sylvanas Windrunner · {object:36126} Royal Quarter · {npc:257648} Tanis Alderwood · {object:36078} Trade Quarter
	["Walk south from {area:159} to the {area:153} and down into the {zone:1458}. {npc:10181} holds court in the {object:36126}; {npc:257648} begs in the {object:36078}."] = "Marchez vers le sud depuis {area:159} jusqu'aux {area:153} et descendez dans {zone:1458}. {npc:10181} tient sa cour dans le {object:36126} ; {npc:257648} mendie dans le {object:36078}.",

	-- Step 18: Linen Cloth
	-- {npc:257648} Tanis Alderwood · {item:2589} Linen Cloth
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["{npc:257648} needs 10 {item:2589}. Humanoids drop it: the Scarlet Zealots and Friars of the glades about three kills in ten. The Undercity Auction House sells it too."] = "{npc:257648} a besoin de 10 {item:2589}. Les humanoïdes en laissent tomber : les Zélotes écarlates et les Frères des clairières environ trois fois sur dix. L'hôtel des ventes de Fossoyeuse en vend aussi.",
	-- {item:2589} Linen Cloth
	["{item:2589} x10"] = "{item:2589} x10",

	-- Step 20: The Symbol of Life
	-- {item:6866} Symbol of Life
	["The {item:6866}"] = "Le {item:6866}",
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {item:6866} Symbol of Life · {npc:257655} Deathguard Billmuth
	["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep. If you lose the symbol, {npc:246378} gives you another."] = "Retour à {area:16602}. {npc:246378} vous remet le {item:6866} ; {npc:257655} attend au rez-de-chaussée du donjon. Si vous perdez le symbole, {npc:246378} vous en donne un autre.",
	-- {npc:257655} Deathguard Billmuth
	["{npc:257655}, downstairs"] = "{npc:257655}, au rez-de-chaussée",

	-- Step 21: Deathguard Falgan
	-- {area:812} Venomweb Vale · {item:6866} Symbol of Life
	-- plural, as words: Scarlet Crusaders = {npc:239036} Scarlet Crusader
	["{area:812} is at the far east end of the glades, a long walk. Falgan lies dead among the Scarlet Crusaders there: target his body and use the {item:6866}, then talk to him at once, as he does not stay alive long. If he is already up (another player), just talk to him; if he died again, raise him again."] = "La {area:812} se trouve à l'extrémité est des clairières, une longue marche. Falgan gît mort parmi les Croisés écarlates : ciblez son corps et utilisez le {item:6866}, puis parlez-lui aussitôt, car il ne reste pas longtemps en vie. S'il est déjà debout (un autre joueur), parlez-lui simplement ; s'il est de nouveau mort, ranimez-le de nouveau.",

	-- Step 22: The Scarlet attack plans
	["The Scarlet attack plans"] = "Les plans d'attaque de la Croisade écarlate",
	-- {area:812} Venomweb Vale
	-- plural, as words: Scarlet Zealots = {npc:1537} Scarlet Zealot
	["The Scarlet Zealots (level 8-9), Friars (9-10) and Tarnished around {area:812} carry the attack plans. They run for help at low health and respawn in five minutes."] = "Les Zélotes écarlates (niveau 8-9), les Frères (9-10) et les Ternis autour de la {area:812} portent les plans d'attaque. Ils fuient chercher de l'aide quand leur vie est basse et réapparaissent en cinq minutes.",

	-- Step 23: Redemption
	-- {area:16602} Bandarion Keep · {npc:246378} Danitha Morr · {spell:7328} Redemption
	["Back to {area:16602}, across the whole glades: Billmuth downstairs takes the plans, then {npc:246378}, back upstairs in the keep, teaches you {spell:7328}."] = "",
	-- {npc:246378} Danitha Morr · {spell:7328} Redemption
	["{npc:246378}, back upstairs: {spell:7328}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:16602}, across the whole glades: Billmuth downstairs takes the plans, {npc:246378} teaches you {spell:7328}."] = "Retour à {area:16602}, en traversant toutes les clairières : Billmuth, au rez-de-chaussée, prend les plans, {npc:246378} vous apprend {spell:7328}.",
	-- ["Back to {area:16602}. {npc:246378} gives you the {item:6866}; {npc:257655} waits downstairs in the keep."] = "Retour à {area:16602}. {npc:246378} vous remet le {item:6866} ; {npc:257655} attend au rez-de-chaussée du donjon.",
	-- ["Back to {area:16602}: Billmuth takes the plans, {npc:246378} teaches you {spell:7328}."] = "Retour à {area:16602} : Billmuth prend les plans, {npc:246378} vous apprend {spell:7328}.",
	-- ["Tarnished Drudges"] = "Manoeuvres ternis",
	-- ["Tarnished Zealots"] = "Zélotes ternis",
	-- ["The Scarlet Crusaders camped around {area:812} carry the attack plans."] = "Les membres de la Croisade écarlate qui campent autour de la {area:812} portent les plans d'attaque.",
	-- ["The Vile Fin murlocs lurk on the bluffs along the road east of the keep and in the camps around the lake to the west."] = "Les murlocs Aileron noir rôdent sur les falaises le long de la route à l'est du donjon et dans les camps autour du lac à l'ouest.",
	-- ["Tyr's Watch and {spell:7328}"] = "Tyr's Watch et {spell:7328}",
	-- ["Vile Fin Attackers"] = "Attaquants aileron noir",
	-- ["Vile Fin Seers"] = "Oracles aileron noir",
	-- ["{area:16602} stands on the bluffs north-west of the {area:156} (the road west starts near 29,46). {npc:246349} waits at the gate. {npc:246389}, the keep's trainer, and {npc:259190}, its stable master, stand at the forest's edge just south of him. They only have work for you from level 10 and after A Righteous Cause from Leonid at the keep, the end of {npc:267009}'s chain that starts south-east of {area:159}; take their quests when you see them."] = "{area:16602} se dresse sur les falaises au nord-ouest de la {area:156} (la route vers l'ouest part vers 29,46). {npc:246349} attend à la porte. {npc:246389}, la maîtresse du donjon, et {npc:259190}, son maître des écuries, se tiennent à l'orée de la forêt juste au sud de lui. Ils n'ont du travail pour vous qu'à partir du niveau 10 et après Une cause juste, donnée par Leonid au donjon, la fin de la suite de quêtes de {npc:267009} qui commence au sud-est de {area:159} ; acceptez leurs quêtes quand vous les voyez.",
	-- ["{area:16602} stands on the bluffs north-west of the {area:156}. {npc:246349} waits at the gate."] = "{area:16602} se dresse sur les falaises au nord-ouest de la {area:156}. {npc:246349} attend à la porte.",
	-- ["{area:812} is at the far east end of the glades. Use the {item:6866} on {npc:257663}, then speak to him. If you lose the symbol, {npc:246378} gives you another."] = "La {area:812} se trouve à l'extrémité est des clairières. Utilisez le {item:6866} sur {npc:257663}, puis parlez-lui. Si vous perdez le symbole, {npc:246378} vous en donne un autre.",
	-- ["{npc:1569} gives you a {item:282423} after The Mindless Ones: read it, then bring it to {npc:244808} by the church. He asks you to heal five {npc:259377} lying around {area:154}. {spell:635} hurts a Forsaken paladin a little each time: watch your health."] = "{npc:1569} vous donne un {item:282423} après Les Décérébrés : lisez-le, puis apportez-le à {npc:244808} près de l'église. Il vous demande de soigner cinq {npc:259377} étendus autour de {area:154}. {spell:635} blesse un peu un paladin réprouvé à chaque fois : surveillez votre vie.",
	-- ["{npc:246152}, who trains Paladins in {area:159}, sends you to the order's keep on the west coast."] = "{npc:246152}, qui forme les paladins à {area:159}, vous envoie au donjon de l'ordre sur la côte ouest.",
	-- ["{npc:246349} gives you a weapon, then sends you round the keep to speak with four of its people: {npc:246389} just south of the gate, {npc:246393} and {npc:246378} inside the keep, and {npc:246394}, the lookout, who walks the road south-east of the keep. Pick the conversation option with each."] = "{npc:246349} vous donne une arme, puis vous envoie faire le tour du donjon pour parler à quatre de ses membres : {npc:246389} juste au sud de la porte, {npc:246393} et {npc:246378} à l'intérieur du donjon, et {npc:246394}, la vigie, qui arpente la route au sud-est du donjon. Choisissez l'option de dialogue avec chacun.",
	-- ["{npc:246378} leads the order from inside the keep; {npc:246393} stands beside it."] = "{npc:246378} dirige l'ordre depuis l'intérieur du donjon ; {npc:246393} se tient à côté.",
	-- ["{npc:246378} offers the first Lesson in Divinity at level 12."] = "{npc:246378} propose la première Leçon de divinité au niveau 12.",
	-- ["{npc:246389} and {npc:259190}"] = "{npc:246389} et {npc:259190}",
	-- ["{npc:257648} needs 10 {item:2589}. Scarlet Zealots and Scarlet Friars drop it about three times in ten; bring it along if you already carry some."] = "{npc:257648} a besoin de 10 {item:2589}. Les Zélotes écarlates et les Frères écarlates en laissent tomber environ trois fois sur dix ; apportez-en si vous en avez déjà.",
	-- ["{object:181686}, in the root cellar"] = "{object:181686}, dans le cellier",
	-- ["{object:554626}, in the root cellar"] = "{object:554626}, dans le cellier",
	-- ["{quest:91317} hold the ruined village of {area:16881} in the {area:16616}, south-west of the keep. The {item:246213} is piled in the root cellar of one of its houses; Commander {npc:259431} walks among his Tarnished."] = "{quest:91317} occupent le village en ruine de {area:16881}, dans la {area:16616}, au sud-ouest du donjon. Le {item:246213} est empilé dans le cellier de l'une de ses maisons ; le commandant {npc:259431} circule parmi ses Ternis.",
}
