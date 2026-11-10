-- French (frFR): the guide forever/class/rogue/poisons-horde (forever/class/rogue/poisons-horde.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Poisons (Horde)"] = "Poisons (Horde)",
	-- {item:7676} Thistle Tea
	["Forever teaches Poisons through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Sur Forever, les poisons s'apprennent par cette suite de quêtes, pas auprès du maître ; la recette du {item:7676} vient avec.",

	-- Step 1: Lockpicking practice
	["Lockpicking practice"] = "Entraînement au crochetage",
	-- {object:129127} Gallywix's Lockbox · {spell:1804} Pick Lock · {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {item:5060} Thieves' Tools · {area:392} Ratchet
	["{object:129127} at the end of the tower job needs Lockpicking of about 70-75. Train {spell:1804} from Gest or {npc:3401} in the {object:172960} if you lack it, carry {item:5060}, and pick the Buccaneer's Strongboxes on the middle deck of the Tide Razor, the beached pirate ship south of {area:392}: they come back fast. Your cap rises 5 per level."] = "Le {object:129127}, à la fin du travail de la tour, demande environ 70-75 en Crochetage. Apprenez {spell:1804} auprès de Gest ou de {npc:3401} dans {object:172960} si vous ne l'avez pas, emportez des {item:5060}, et crochetez les Coffres du boucanier sur le pont du milieu du Tide Razor, le navire pirate échoué au sud de {area:392} : ils reviennent vite. Votre maximum augmente de 5 par niveau.",
	["Tide Razor"] = "Tide Razor",
	["Lockpicking about 75: pick the Buccaneer's Strongboxes on the Tide Razor"] = "Crochetage à environ 75 : crochetez les Coffres du boucanier du Tide Razor",

	-- Step 2: The Shattered Salute
	-- {npc:3401} Shenthul · {object:172960} Cleft of Shadow · {object:172982} Valley of Strength
	["{npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Take the quest and wait: he speaks three lines and salutes you. After his third line, target him and type /salute. If it does not count, abandon the quest and take it again. The tower job ahead is built around Ambush, which needs a dagger: if you have none, Kareth, the blade merchant in the {object:172960}, sells a Jambiya."] = "{npc:3401} se tient dans {object:172960}, le canyon sous {object:172982}. Acceptez la quête et attendez : il prononce trois répliques et vous salue. Après sa troisième réplique, ciblez-le et tapez /salute. Si cela ne compte pas, abandonnez la quête et reprenez-la. Le travail de la tour qui suit repose sur Embuscade, qui demande une dague : si vous n'en avez pas, Kareth, le marchand de lames de {object:172960}, vend une Jambiya.",
	-- {npc:3401} Shenthul
	["/salute {npc:3401}"] = "/saluer {npc:3401}",
	-- {quest:2458} Deep Cover · {item:8051} Flare Gun
	["{quest:2458}: keep the {item:8051}"] = "{quest:2458} : gardez {item:8051}",

	-- Step 3: Taskmaster Fizzule
	-- {area:382} Sludge Fen · {item:8051} Flare Gun · {npc:3401} Shenthul
	["Fly to the Crossroads and head north to the Venture Co. tower above the {area:382}. Fizzule stands under a tree east of the tower, outside it, and is hostile until signalled. Target him from about 50 yards and fire the {item:8051} twice, then walk up in front of him and /salute. In any other order he attacks. Lost the {item:8051}? Abandon and retake from {npc:3401}."] = "",
	-- {item:8051} Flare Gun
	["{item:8051}, twice, at Fizzule"] = "{item:8051}, deux fois, sur Fizzule",

	-- Step 4: Silixiz's Tower Key
	-- {item:8066} Fizzule's Whistle · {npc:7287} Foreman Silixiz · {spell:921} Pick Pocket
	["Keep {item:8066} in your bags and use it on him every time you come near, or he turns hostile. {npc:7287} (level 22) walks by the tower: hug the wall, stealth up behind him and {spell:921} the key. Killing him does not give it; if his pockets are empty, kill him and wait 4 1/2 minutes for him to come back."] = "Gardez le {item:8066} dans vos sacs et utilisez-le sur lui chaque fois que vous vous approchez, sinon il devient hostile. {npc:7287} (niveau 22) marche près de la tour : longez le mur, camouflez-vous derrière lui et utilisez {spell:921} pour la clé. Le tuer ne la donne pas ; si ses poches sont vides, tuez-le et attendez 4 minutes et demie qu'il revienne.",
	-- {item:8072} Silixiz's Tower Key
	["Pick Pocket Foreman Silixiz for {item:8072}"] = "",

	-- Step 5: The Venture Co. tower
	["The Venture Co. tower"] = "La tour de la KapitalRisk",
	-- {spell:1943} Rupture · {spell:2098} Eviscerate · {npc:7288} Grand Foreman Puzik Gallywix · {spell:1776} Gouge · {spell:5277} Evasion · {item:7676} Thistle Tea · {object:129127} Gallywix's Lockbox · {spell:9810} Touch of Zanzil · {npc:2391} Serge Hinott
	-- plural, as words: Mutated Venture Co. Drones = {npc:7310} Mutated Venture Co. Drone
	["Inside, floor by floor (everything comes back after 4 1/2 minutes): the Mutated Venture Co. Drones (level 25) on the ground floor die to one Ambush with a dagger; the Patrollers on the second floor take half their health from a one-point {spell:1943}; the Lookouts on the open third floor from a one-point {spell:2098}. {npc:7288} waits on the top floor: a level 23 elite, back 10 minutes after a kill. Open with Ambush (about half his health), then {spell:1776}, {spell:5277}, a healing potion and {item:7676}; a friend makes it easy. One head per kill. Then pick {object:129127} beside him for the cache: it poisons you with the {spell:9810}, which weakens your stealth and agility until {npc:2391} cures it."] = "À l'intérieur, étage par étage (tout revient au bout de 4 minutes et demie) : les Pantins mutés de la KapitalRisk (niveau 25) du rez-de-chaussée meurent d'une seule Embuscade avec une dague ; les Patrouilleurs du deuxième étage perdent la moitié de leur vie avec un {spell:1943} à un point ; les Sentinelles du troisième étage, à ciel ouvert, avec un {spell:2098} à un point. {npc:7288} attend au dernier étage : un élite de niveau 23, qui revient 10 minutes après sa mort. Ouvrez avec Embuscade (environ la moitié de sa vie), puis {spell:1776}, {spell:5277}, une potion de soins et du {item:7676} ; un ami rend la chose facile. Une tête par victoire. Crochetez ensuite le {object:129127} à côté de lui pour la cache : il vous empoisonne avec le {spell:9810}, qui affaiblit votre camouflage et votre agilité jusqu'à ce que {npc:2391} vous en guérisse.",
	-- {item:8074} Gallywix's Head · {npc:7288} Grand Foreman Puzik Gallywix
	["{item:8074}: {npc:7288} (elite)"] = "{item:8074} : {npc:7288} (élite)",

	-- Step 6: Back to Shenthul
	-- {npc:3401} Shenthul
	["Back to {npc:3401}"] = "Retour auprès de {npc:3401}",
	-- {zone:1454} Orgrimmar · {area:392} Ratchet · {item:8072} Silixiz's Tower Key · {area:263} Cleft · {item:2928} Dust of Decay · {item:6947} Instant Poison
	-- plural, as words: Empty Vials = {item:3371} Empty Vial
	["Fly back to {zone:1454} ({area:392} or the Crossroads; dying at the tower and taking the spirit healer's way back to the Crossroads is quicker). Keep {item:8072} afterwards. Before you leave the {area:263}, buy {item:2928} and Empty Vials from Rekkul: once Hinott teaches Poisons, each batch of {item:6947} takes one of each."] = "",

	-- Step 7: Serge Hinott
	-- {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1421} Silverpine Forest · {area:287} Hillsbrad · {area:272} Tarren Mill · {npc:2391} Serge Hinott · {npc:2216} Apothecary Lydon · {npc:3401} Shenthul · {item:6947} Instant Poison
	["Take the zeppelin from {zone:1454} to the {zone:1458} and follow the road south through {zone:1421} into {area:287}, to {area:272}. {npc:2391} works in the building next to the flight path, beside {npc:2216}, a wagon outside. If you lost the Sample of Zanzil's Mixture, abandon and retake from {npc:3401}. Stay beside him for about a minute while he brews the cure; if it never finishes, abandon and retake from him. Then open Poisons from your spellbook to make {item:6947} from Rekkul's dust and vials, and use it on your weapon."] = "Prenez le zeppelin d'{zone:1454} à {zone:1458} et suivez la route vers le sud à travers la {zone:1421} jusqu'à {area:287}, à {area:272}. {npc:2391} travaille dans le bâtiment à côté du maître de vol, à côté d'{npc:2216}, un chariot devant. Si vous avez perdu l'échantillon du mélange de Zanzil, abandonnez la quête et reprenez-la auprès de {npc:3401}. Restez à côté de lui environ une minute pendant qu'il prépare le remède ; s'il ne finit jamais, abandonnez la quête et reprenez-la auprès de lui. Ouvrez ensuite Poisons depuis votre grimoire pour fabriquer du {item:6947} avec la poudre et les fioles de Rekkul, et appliquez-le sur votre arme.",
	["Wait for the cure"] = "Attendez le remède",
	-- {npc:2391} Serge Hinott
	["{npc:2391}: Poisons"] = "{npc:2391} : Poisons",
	-- {item:8095} Hinott's Oil · {spell:9810} Touch of Zanzil
	["{item:8095}: clears the {spell:9810}"] = "{item:8095} : dissipe le {spell:9810}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 20 {npc:3401} stands in the {object:172960}, the canyon under the {object:172982}. Target him and type /salute."] = "Au niveau 20, {npc:3401} se tient dans {object:172960}, le canyon sous la {object:172982}. Ciblez-le et tapez /saluer.",
	-- ["Fly back to {zone:1454} ({area:392} or the {area:380}; dying at the tower and taking the spirit healer's way back to the {area:380} is quicker). Keep {item:8072} afterwards. Before you leave the {area:263}, buy {item:2928} and Empty Vials from Rekkul: once Hinott teaches Poisons, each batch of {item:6947} takes one of each."] = "Retournez en vol à {zone:1454} (depuis {area:392} ou la {area:380} ; mourir à la tour et prendre le chemin de l'esprit gardien jusqu'à la {area:380} est plus rapide). Gardez la {item:8072} ensuite. Avant de quitter la {area:263}, achetez de la {item:2928} et des Fioles vides à Rekkul : une fois que Hinott vous aura appris les poisons, chaque fournée de {item:6947} en demande une de chaque.",
	-- ["Fly back to {zone:1454}."] = "Retournez en vol à {zone:1454}.",
	-- ["Fly to the {area:380} and head north to the Venture Co. tower above the {area:382}. Fizzule stands under a tree east of the tower, outside it, and is hostile until signalled. Target him from about 50 yards and fire the {item:8051} twice, then walk up in front of him and /salute. In any other order he attacks. Lost the {item:8051}? Abandon and retake from {npc:3401}."] = "Volez jusqu'à la {area:380} et dirigez-vous vers le nord jusqu'à la tour de la KapitalRisk au-dessus du {area:382}. Fizzule se tient sous un arbre à l'est de la tour, à l'extérieur, et reste hostile tant qu'on ne lui a pas fait signe. Ciblez-le à environ 50 mètres et tirez deux fois avec le {item:8051}, puis avancez devant lui et faites /salute. Dans tout autre ordre, il attaque. Vous avez perdu le {item:8051} ? Abandonnez et reprenez la quête auprès de {npc:3401}.",
	-- ["Fly to the {area:380} and ride north to the Venture Co. tower north of the {area:382}. In sight of the tower, fire the {item:8051} twice, then /salute {npc:7233} before he attacks you."] = "Volez jusqu'à {area:380} et allez vers le nord jusqu'à la tour de la KapitalRisk, au nord de {area:382}. En vue de la tour, tirez deux fois avec {item:8051}, puis faites /saluer à {npc:7233} avant qu'il ne vous attaque.",
	-- ["Forever teaches {spell:2842} through this chain, not the trainer; the {item:7676} recipe comes with it."] = "Forever enseigne {spell:2842} par cette chaîne, et non par le maître ; la recette de {item:7676} l'accompagne.",
	-- ["Stay stealthed. {npc:7287} carries the tower key; Gallywix (elite) and his lockbox are at the top of the tower. Kill two each of the drones, patrollers and lookouts around it."] = "Restez camouflé. {npc:7287} porte la clé de la tour ; Gallywix (élite) et son coffret sont au sommet de la tour. Tuez deux Pantins, deux Patrouilleurs et deux Sentinelles de la KapitalRisk autour.",
	-- ["Take the zeppelin from {zone:1454} to the {zone:1458} and ride south through {zone:1421} to {area:272} in {area:287}. {npc:2391} stands in {area:272}; wait beside him while he brews the cure."] = "Prenez le zeppelin d'{zone:1454} à {zone:1458} et descendez vers le sud à travers {zone:1421} jusqu'à {area:272}, à {area:287}. {npc:2391} se tient à {area:272} ; attendez à côté de lui pendant qu'il prépare le remède.",
	-- ["{item:8051}, twice, in sight of the tower"] = "{item:8051}, deux fois, en vue de la tour",
	-- ["{item:8072}: Pick Pocket Foreman Silixiz"] = "{item:8072} : Vol à la tire sur le contremaître Silixiz",
	-- ["{spell:2842} (Horde)"] = "{spell:2842} (Horde)",
}
