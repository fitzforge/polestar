-- French (frFR): the guide forever/class/warlock/shard-of-the-green-flame (forever/class/warlock/shard-of-the-green-flame.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood
	["A rare off-hand for your 50s from {npc:14469} and {npc:14470} in {zone:1448}, the camp that also offers An Imp's Request."] = "Un objet de main gauche rare pour les niveaux 50, de {npc:14469} et {npc:14470} à {zone:1448}, le camp qui propose aussi « La demande d'un diablotin ».",

	-- Step 1: Niby the Almighty
	-- {npc:14469} Niby the Almighty · {npc:14470} Impsy · {zone:1448} Felwood · {area:1997} Bloodvenom Post · {area:1765} Bloodvenom Falls
	-- plural, as words: Flawless Fel Essences = {quest:7602} Flawless Fel Essence
	["At 50 {npc:14469} and his imp {npc:14470} wait on a rise in central {zone:1448} just north-east of {area:1997}: coming north over the {area:1765} bridge, they stand off the road to the east, past a few oozes. {npc:14469} sends you to {npc:14470}, beside him, who wants three Flawless Fel Essences from three places."] = "Au niveau 50, {npc:14469} et son diablotin {npc:14470} attendent sur une butte au centre du {zone:1448}, juste au nord-est du {area:1997} : en venant du sud par le pont des {area:1765}, ils se tiennent à l'écart de la route, à l'est, après quelques limons. {npc:14469} vous envoie voir {npc:14470}, à côté de lui, qui veut trois Gangressences parfaites venues de trois endroits.",

	-- Step 2: Jaedenar
	-- {area:1763} Jaedenar · {area:1997} Bloodvenom Post · {area:1770} Shadow Hold · {npc:9516} Lord Banehollow
	-- plural, as words: Jaedenar Legionnaires = {npc:9862} Jaedenar Legionnaire
	["{area:1763} lies just south of {area:1997}, west of the road. Of its two caves, {area:1770} is the northern one, further up the hill; the other has no Legionnaires. {area:1770}'s tunnels run north under the hills, and the Jaedenar Legionnaires (level 55) stand in its deeper halls, from the first ramps on toward {npc:9516}'s chamber; they Uppercut anyone in melee. Three kills in four give the essence, but only about eleven spawn: clear your way in and wait out a five-minute respawn if you must. The cultists of {area:1763} and {area:1770} are all hostile."] = "{area:1763} se trouve juste au sud du {area:1997}, à l'ouest de la route. De ses deux grottes, {area:1770} est celle du nord, plus haut sur la colline ; l'autre n'a pas de Légionnaires. Les tunnels de {area:1770} filent vers le nord sous les collines, et les Légionnaires de Jaedenar (niveau 55) se tiennent dans ses salles profondes, des premières rampes jusqu'à la chambre de {npc:9516} ; ils frappent d'un uppercut quiconque est au corps à corps. Trois victimes sur quatre donnent l'essence, mais seule une onzaine apparaît : frayez-vous un chemin et attendez cinq minutes leur réapparition s'il le faut. Les sectateurs de {area:1763} et de {area:1770} sont tous hostiles.",

	-- Step 3: Azshara
	-- {zone:1447} Azshara
	["The Legashi satyrs (level 51-53) hold the Legash Encampment on {zone:1447}'s northern coast. Every kind drops the essence three times in four; the satyrs burn mana and the Hellcallers rain fire, so pull them singly."] = "Les satyres Legashi (niveau 51-53) tiennent le campement Legashi sur la côte nord d'{zone:1447}. Chaque type lâche l'essence trois fois sur quatre ; les satyres brûlent le mana et les Appelle-l'enfer font pleuvoir le feu, attirez-les donc un par un.",

	-- Step 4: The Dark Portal
	-- {area:72} The Dark Portal · {zone:1419} Blasted Lands
	["The Felguard Sentries (level 54) walk around the {area:72} in the south of the {zone:1419}, each with a felhunter. Leave the level 57 Servants of Razelikh alone: they cannot be killed without their own quest."] = "Les Sentinelles gangregardes (niveau 54) font le tour de la {area:72}, au sud des {zone:1419}, chacune avec un chasseur corrompu. Laissez tranquilles les Serviteurs de Razelikh de niveau 57 : on ne peut pas les tuer sans leur propre quête.",

	-- Step 5: Impsy
	-- {npc:14470} Impsy · {item:18626} Fel Fire · {npc:14467} Kroshius
	["Back to {npc:14470}. He hands you the {item:18626}: keep it, it wakes the infernal {npc:14467}."] = "Retournez voir {npc:14470}. Il vous remet le {item:18626} : gardez-le, il réveille l'infernal {npc:14467}.",

	-- Step 6: Kroshius
	-- {npc:14467} Kroshius · {area:1766} Shatter Scar Vale · {npc:14469} Niby the Almighty · {item:18626} Fel Fire · {npc:14470} Impsy
	["{npc:14467}' remains lie in {area:1766}, the burnt crater north of {npc:14469}: follow the road north from his camp; the remains lie a little east of it. Use the {item:18626} beside them and wait for him to rise. {npc:14467} is elite (level 55): grouping up is encouraged; a warlock of 55 or more can solo him with Fear and damage over time, or with Enslave Demon, but fire spells do nothing to him and he knocks you back. If you die he heals to full; he rises again three minutes after he dies. An elite infernal patrols the pool south of the remains: pull {npc:14467} away from it. He always drops his core. Lost the {item:18626}? Abandon the quest and take it again from {npc:14470}."] = "Les restes de {npc:14467} gisent dans le {area:1766}, le cratère brûlé au nord de {npc:14469} : suivez la route vers le nord depuis son camp ; les restes sont un peu à l'est. Utilisez le {item:18626} à côté d'eux et attendez qu'il se relève. {npc:14467} est élite (niveau 55) : mieux vaut former un groupe ; un démoniste de niveau 55 ou plus peut le battre seul avec Peur et des dégâts sur la durée, ou avec Asservir démon, mais les sorts de feu ne lui font rien et il vous repousse. Si vous mourez, il récupère toute sa vie ; il se relève trois minutes après sa mort. Un infernal élite patrouille autour du bassin au sud des restes : éloignez {npc:14467} de lui. Il lâche toujours son noyau. Vous avez perdu le {item:18626} ? Abandonnez la quête et reprenez-la auprès de {npc:14470}.",
	-- {item:18626} Fel Fire · {object:179677} Kroshius' Remains (no name in this language: may be words)
	["{item:18626}, at {object:179677}"] = "{item:18626}, aux {object:179677}",

	-- Step 7: Back to Niby the Almighty
	-- {npc:14469} Niby the Almighty
	["Back to {npc:14469}"] = "Retournez voir {npc:14469}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 50 {npc:14469} and his imp {npc:14470} wait in central {zone:1448}, just east of {area:1763}."] = "Au niveau 50, {npc:14469} et son diablotin {npc:14470} attendent au centre de {zone:1448}, juste à l'est de {area:1763}.",
	-- ["The Felguard Sentries around the {area:72}, in southern {zone:1419}, carry its essence."] = "Les Gangregardes sentinelles autour de la {area:72}, au sud des {zone:1419}, portent son essence.",
	-- ["The Jaedenar Legionnaires, a short way west of {npc:14469}, carry {area:1763}'s essence."] = "Les Légionnaires de Jaedenar, un peu à l'ouest de {npc:14469}, portent l'essence de {area:1763}.",
	-- ["The Legashi satyrs of northern {zone:1447} carry {zone:1447}'s essence."] = "Les satyres Legashi du nord d'{zone:1447} portent l'essence d'{zone:1447}.",
	-- ["{npc:14467}' remains lie in {area:1766}, north of {npc:14469}. Use the {item:18626} beside them and kill the infernal when he wakes. {npc:14467} is elite: grouping up is advised."] = "Les restes de {npc:14467} gisent dans le {area:1766}, au nord de {npc:14469}. Utilisez le {item:18626} à côté et tuez l'infernal à son réveil. {npc:14467} est élite : un groupe est conseillé.",
}
