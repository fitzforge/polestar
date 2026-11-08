-- French (frFR): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Succubus and Incubus (Alliance)"] = "Succube et incube (Alliance)",
	["At 20: the succubus and Forever's incubus, its male twin, each with a soul pouch for your shards."] = "Au niveau 20 : la succube et l'incube de Forever, son jumeau masculin, chacun avec une bourse d'âmes pour vos fragments.",

	-- Step 1: Gakin's Summons (Gnomes)
	-- {quest:1717} Gakin's Summons
	["{quest:1717} (Gnomes)"] = "{quest:1717} (Gnomes)",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["At 20 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the Deeprun Tram."] = "",

	-- Step 2: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens · {object:1162} Menethil Harbor (no name in this language: may be words) · {zone:1445} Dustwallow Marsh · {object:3204} Booty Bay (no name in this language: may be words)
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}: a long trip for the Alliance. Take the boat from {object:1162} to Theramore and head west through {zone:1445}, or the boat from {object:3204} to Ratchet."] = "",

	-- Step 3: Takar the Seer
	-- {npc:6244} Takar the Seer · {npc:6247} Doan Karhan · {item:6898} Orb of Soran'ruk
	["{npc:6244} camps at a tent with a campfire just north-east of Camp Taurajo, by a fork in the road: Horde ground, so come in from the east and keep clear of the Taurajo guards. {npc:6247} beside him starts the {item:6898}. Takar offers both branches: take both."] = "",
	["the succubus"] = "la succube",
	["the incubus"] = "l'incube",

	-- Step 4: Heartswood
	-- {zone:1440} Ashenvale · {zone:1439} Darkshore · {quest:1738} Heartswood · {npc:6122} Gakin the Darkbinder
	["Ordil'Aran lies in north-west {zone:1440}, north of Astranaar along the road toward {zone:1439}. About twenty Dark Strand cultists hold the ruins around the great tree: keep to the outer wall, and click the {quest:1738} from as far away as it lets you. It is turned in to {npc:6122}, not to Takar."] = "",

	-- Step 5: The Wooden Figurine
	-- {item:190309} Wooden Figurine
	["The {item:190309}"] = "La {item:190309}",
	-- {zone:1440} Ashenvale · {object:19863} Maestra's Post (no name in this language: may be words) · {quest:1738} Heartswood · {item:190307} Unlit Torch · {object:29784} Basic Campfire · {item:190308} Burning Torch
	["The house stands alone in the trees of north-western {zone:1440}, north-west of Ordil'Aran and well north of {object:19863}: do it on the same trip as the {quest:1738}. Take the {item:190307} from the table outside, light it at a campfire (a {object:29784} of your own, or Talen's fire on Zoram Strand), and go straight back: the {item:190308} burns out after five minutes, so a fire of your own beside the house is quickest. Without it the figure in the house stops you. The figurine is upstairs."] = "",
	-- {item:190307} Unlit Torch
	["{item:190307}, on the table outside"] = "{item:190307}, sur la table dehors",
	-- {item:190309} Wooden Figurine
	["{item:190309}, upstairs"] = "{item:190309}, à l'étage",

	-- Step 6: The Binding: succubus
	-- {quest:1739} The Binding
	["{quest:1739}: succubus"] = "{quest:1739} : succube",
	-- {npc:6122} Gakin the Darkbinder · {quest:1738} Heartswood · {item:6913} Heartswood Core
	["Back to {npc:6122} with the {quest:1738}. He hands you the {item:6913}: take the stairs behind him down to the crypt; part way along the lowest corridor a side stair on the left leads to the room with the purple circle. Stand on it and use the core. Summon your voidwalker first and keep the succubus (level 20, not elite) on the circle, or the guards may kill her and the kill does not count. If she wins, use the core again; keep it, {npc:6122} takes it back."] = "Retournez voir {npc:6122} avec le {quest:1738}. Il vous remet le {item:6913} : prenez l'escalier derrière lui pour descendre à la crypte ; à mi-chemin du couloir le plus bas, un escalier latéral à gauche mène à la salle au cercle violet. Placez-vous dessus et utilisez le cœur. Invoquez d'abord votre marcheur du Vide et gardez la succube (niveau 20, pas élite) sur le cercle, sinon les gardes risquent de la tuer et la victime ne compte pas. Si elle gagne, utilisez de nouveau le cœur ; gardez-le, {npc:6122} le reprend.",
	-- {item:6913} Heartswood Core
	["{item:6913}, on the circle in the crypt"] = "{item:6913}, sur le cercle de la crypte",

	-- Step 7: The Binding: incubus
	-- {quest:65603} The Binding
	["{quest:65603}: incubus"] = "{quest:65603} : incube",
	-- {item:190309} Wooden Figurine · {npc:6122} Gakin the Darkbinder
	["Give Gakin the figurine, then use the {item:190309} at the middle of the same circle and defeat the incubus it calls (level 20, not elite; it can charm you) with your voidwalker tanking. Keep the figurine: {npc:6122} takes it back."] = "Donnez la figurine à Gakin, puis utilisez la {item:190309} au milieu du même cercle et vainquez l'incube qu'elle appelle (niveau 20, pas élite ; il peut vous charmer), votre marcheur du Vide encaissant les coups. Gardez la figurine : {npc:6122} la reprend.",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the circle in the crypt"] = "{npc:185335}, au cercle de la crypte",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Un second démon séducteur, le sayaad mâle, et un sac d'éclats d'âme pour transporter vos éclats.",
	-- ["At 20 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257}."] = "Au niveau 20, {npc:6120}, le maître des démonistes de la {object:32383} de {zone:1455}, vous envoie voir {npc:6122} à {zone:1453}. Prenez le {area:2257}.",
	-- ["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}."] = "Au niveau 20, {npc:6122}, dans la cave de {object:2164} dans {object:2101}, vous envoie voir {npc:6244} dans {zone:1413}.",
	-- ["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}: a long trip for the Alliance. Take the boat from {area:150} to Theramore and head west through {zone:1445}, or the boat from {area:35} to {area:392}."] = "Au niveau 20, {npc:6122}, dans la cave de l'{object:2164} du {object:2101}, vous envoie voir {npc:6244} dans les {zone:1413} : un long voyage pour l'Alliance. Prenez le bateau de {area:150} à Theramore et allez vers l'ouest à travers le {zone:1445}, ou le bateau de {area:35} à {area:392}.",
	-- ["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "Retournez voir {npc:6122} à {object:2164}. Posez la figurine sur le cercle d'invocation de la crypte sous lui et vainquez l'incube qu'elle appelle.",
	-- ["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "Depuis {area:415}, prenez la route vers l'ouest jusqu'à {area:413} : la figurine se trouve dans une maison parmi les arbres au nord du poste.",
	-- ["Incubus (Alliance)"] = "Incube (Alliance)",
	-- ["Ordil'Aran lies in north-west {zone:1440}, north of {area:415} along the road toward {zone:1439}. About twenty Dark Strand cultists hold the ruins around the great tree: keep to the outer wall, and click the {quest:1738} from as far away as it lets you. It is turned in to {npc:6122}, not to Takar."] = "Ordil'Aran se trouve au nord-ouest d'{zone:1440}, au nord d'{area:415}, le long de la route vers {zone:1439}. Une vingtaine de sectateurs du Sombre Brin tiennent les ruines autour du grand arbre : longez le mur extérieur et cliquez sur le {quest:1738} d'aussi loin que possible. Il se rend à {npc:6122}, pas à Takar.",
	-- ["The house stands alone in the trees of north-western {zone:1440}, north-west of Ordil'Aran and well north of {area:413}: do it on the same trip as the {quest:1738}. Take the {item:190307} from the table outside, light it at a campfire (a {object:29784} of your own, or Talen's fire on {area:414}), and go straight back: the {item:190308} burns out after five minutes, so a fire of your own beside the house is quickest. Without it the figure in the house stops you. The figurine is upstairs."] = "La maison se dresse, isolée, dans les arbres du nord-ouest d'{zone:1440}, au nord-ouest d'Ordil'Aran et bien au nord du {area:413} : faites-la lors du même voyage que le {quest:1738}. Prenez la {item:190307} sur la table dehors, allumez-la à un feu de camp (un {object:29784} à vous, ou le feu de Talen sur la {area:414}), et revenez tout droit : la {item:190308} s'éteint au bout de cinq minutes, un feu à vous à côté de la maison est donc le plus rapide. Sans elle, la silhouette dans la maison vous arrête. La figurine est à l'étage.",
	-- ["{npc:6122}: he binds the incubus to you"] = "{npc:6122} : il vous lie l'incube",
	-- ["{npc:6244} camps at a tent with a campfire just north-east of {area:378}, by a fork in the road: Horde ground, so come in from the east and keep clear of the Taurajo guards. {npc:6247} beside him starts the {item:6898}. Takar offers both branches: take both."] = "{npc:6244} campe sous une tente avec un feu de camp juste au nord-est du {area:378}, près d'une fourche de la route : c'est un territoire de la Horde, arrivez donc par l'est et tenez-vous loin des gardes de Taurajo. {npc:6247}, à côté de lui, lance la quête de l'{item:6898}. Takar propose les deux branches : prenez les deux.",
	-- ["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244} campe dans le sud de {zone:1413}, à l'est de la route au nord-est de {area:378} : arrivez par l'est et évitez les gardes de la Horde.",
}
