-- French (frFR): the guide forever/class/warlock/felhunter-alliance (forever/class/warlock/felhunter-alliance.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Felhunter (Alliance)"] = "Chasseur corrompu (Alliance)",
	-- {item:22244} Box of Souls
	["The felhunter, the demon to bring against spellcasters, and a {item:22244} for your shards."] = "Le chasseur corrompu, le démon à opposer aux lanceurs de sorts, et une {item:22244} pour vos fragments.",

	-- Step 1: Seeking Strahad (Stormwind)
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6251} in {area:392}."] = "Au niveau 30, {npc:6122}, dans la cave de l'{object:2164}, dans le {object:2101}, vous envoie voir {npc:6251} à {area:392}.",

	-- Step 2: Seeking Strahad (Ironforge)
	-- {npc:6120} Lago Blackwrench · {object:32383} Forlorn Cavern · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["At 30 {npc:6120}, in the {object:32383}, sends you to {npc:6251} in {area:392}."] = "Au niveau 30, {npc:6120}, dans la {object:32383}, vous envoie voir {npc:6251} à {area:392}.",

	-- Step 3: Strahad Farsan
	-- {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {npc:6251} Strahad Farsan · {npc:6266} Menara Voidrender · {npc:6294} Krom Stoutarm · {zone:1455} Ironforge
	["{area:392} is a neutral goblin port on the {zone:1413} coast: the boat from {area:35} docks there. {npc:6251} stands on the hill above the town, behind the engineers' hut, by his little tower; {npc:6266} and two acolytes are with him. He sends you to {npc:6294} in {zone:1455}."] = "{area:392} est un port gobelin neutre sur la côte des {zone:1413} : le bateau de {area:35} y accoste. {npc:6251} se tient sur la colline au-dessus de la ville, derrière la cabane des ingénieurs, près de sa petite tour ; {npc:6266} et deux acolytes sont avec lui. Il vous envoie voir {npc:6294} à {zone:1455}.",

	-- Step 4: Krom Stoutarm
	-- {npc:6294} Krom Stoutarm · {object:32356} Hall of Explorers · {quest:1758} Tome of the Cabal · {area:287} Hillsbrad · {zone:1441} Thousand Needles
	["{npc:6294} is in the library of the {object:32356}. He wants two lost pieces of the {quest:1758}: one on the {area:287} coast, one in {zone:1441}."] = "{npc:6294} est dans la bibliothèque du {object:32356}. Il veut deux morceaux perdus du {quest:1758} : l'un sur la côte de {area:287}, l'autre dans {zone:1441}.",

	-- Step 5: Moldy Tome
	-- {area:271} Southshore
	["The tome is a small grey-blue book lying in the sand of a murloc camp on the shore south-west of {area:271}, near the water's edge. Six or seven murlocs guard it and more lurk underwater: they come in groups, so Fear one and keep your voidwalker on the rest. Walk down to the water to click it; from the hillside the crates block the cursor."] = "Le tome est un petit livre gris-bleu posé dans le sable d'un camp de murlocs sur le rivage au sud-ouest d'{area:271}, près du bord de l'eau. Six ou sept murlocs le gardent et d'autres se cachent sous l'eau : ils viennent en groupe, alors apeurez-en un et gardez votre marcheur du Vide sur les autres. Descendez jusqu'à l'eau pour cliquer dessus ; depuis la colline, les caisses bloquent le curseur.",
	-- {item:6931} Moldy Tome · {quest:1802} Tome of the Cabal
	["{item:6931}, from the {quest:1802} on the sand"] = "{item:6931}, sur le {quest:1802} dans le sable",

	-- Step 6: Tattered Manuscript
	-- {area:484} Freewind Post
	["The centaur cave opens in the cliffs north of {area:484}, a Horde town: keep clear of its guards. Inside, keep right at each fork, cross the pool by the small waterfall, and open the small dark box against the wall beside a larger chest: the larger one is the wrong one. You can open it only while on the quest. The centaurs respawn behind you on the way out."] = "La grotte des centaures s'ouvre dans les falaises au nord du {area:484}, une ville de la Horde : tenez-vous loin de ses gardes. À l'intérieur, prenez à droite à chaque embranchement, traversez le bassin près de la petite cascade et ouvrez la petite boîte sombre contre le mur, à côté d'un coffre plus grand : le grand n'est pas le bon. Vous ne pouvez l'ouvrir que pendant la quête. Les centaures réapparaissent derrière vous à la sortie.",
	-- {item:6997} Tattered Manuscript · {object:92423} Damaged Chest
	["{item:6997}, in the {object:92423}"] = "{item:6997}, dans le {object:92423}",

	-- Step 7: Back to Krom Stoutarm
	-- {npc:6294} Krom Stoutarm
	["Back to {npc:6294}"] = "Retournez voir {npc:6294}",
	-- {npc:6294} Krom Stoutarm · {item:7006} Reconstructed Tome · {npc:6251} Strahad Farsan
	["{npc:6294} pieces the tome together and gives you the {item:7006}: keep it, {npc:6251} takes it with the rods."] = "{npc:6294} reconstitue le tome et vous donne le {item:7006} : gardez-le, {npc:6251} le prend avec les bâtonnets.",

	-- Step 8: Rods of Channeling
	["Rods of Channeling"] = "Bâtonnets de canalisation",
	-- {area:1036} Angerfang Encampment · {area:150} Menethil Harbor · {area:836} Dun Algaz
	["The Dragonmaw hold {area:1036} in the hills east of the road from {area:150} to {area:836}. Only the casters drop the rods, four kills in five: the Bonewarders (level 27, with skeleton pets) and Shadowwarders (28). A steep path north of the central spirit healer leads up into the camp past most of the warriors."] = "Les Dragonmaw tiennent le {area:1036}, dans les collines à l'est de la route qui va de {area:150} à {area:836}. Seuls les lanceurs de sorts lâchent les bâtonnets, quatre fois sur cinq : les Gardos (niveau 27, avec des squelettes familiers) et les Gardombres (28). Un chemin escarpé au nord du gardien des âmes central monte dans le camp en évitant la plupart des guerriers.",
	["Rods of Channeling, from the Dragonmaw casters"] = "Bâtonnets de canalisation, sur les lanceurs de sorts Dragonmaw",

	-- Step 9: The Binding
	-- {npc:6251} Strahad Farsan · {area:392} Ratchet · {quest:1804} Tome of the Cabal · {quest:1795} The Binding
	["Back to {npc:6251} in {area:392}. When you accept, he draws the summoning circle and his acolytes channel a greater circle over it: wait inside the tower until both are done. Then use the {quest:1804} on the circle. The felhunter (level 30, not elite) silences and eats mana, and it vanishes after two minutes: have your voidwalker out, open with your damage over time at once and let the voidwalker tank. If you die or it wins, abandon {quest:1795} and take it again from {npc:6251}. Keep the tome: {npc:6251} takes it back."] = "Retournez voir {npc:6251} à {area:392}. Quand vous acceptez, il trace le cercle d'invocation et ses acolytes canalisent un cercle plus grand par-dessus : attendez dans la tour que les deux soient terminés. Utilisez ensuite le {quest:1804} sur le cercle. Le chasseur corrompu (niveau 30, pas élite) réduit au silence et dévore le mana, et il disparaît au bout de deux minutes : sortez votre marcheur du Vide, ouvrez aussitôt avec vos dégâts sur la durée et laissez le marcheur du Vide encaisser. Si vous mourez ou s'il gagne, abandonnez {quest:1795} et reprenez-la auprès de {npc:6251}. Gardez le tome : {npc:6251} le reprend.",
	-- {quest:1804} Tome of the Cabal
	["{quest:1804}, on the circle"] = "{quest:1804}, sur le cercle",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6251} in {area:392}. Use the {quest:1804} on the summoning circle beside him and defeat the felhunter to bind it."] = "Retournez voir {npc:6251} à {area:392}. Utilisez le {quest:1804} sur le cercle d'invocation à côté de lui et vainquez le chasseur corrompu pour le lier.",
	-- ["The Dragonmaw Bonewarders and Shadowwarders hold the hills east of the road through the {zone:1437}: the rods drop from them."] = "Les Gardiens Dragonmaw et les Veilleurs des ombres Dragonmaw occupent les collines à l'est de la route qui traverse les {zone:1437} : ils laissent tomber les bâtonnets.",
	-- ["The {item:6931} lies on the shore west of {area:271}, past the Torn Fin murloc camps."] = "Le {item:6931} se trouve sur la rive à l'ouest d'{area:271}, après les camps des murlocs Aileron déchiré.",
	-- ["The {object:92423} lies in the canyon north of {area:484}."] = "Le {object:92423} se trouve dans le canyon au nord du {area:484}.",
	-- ["{area:392} is on the {zone:1413} coast; {npc:6251} stands on the hill in town."] = "{area:392} se trouve sur la côte des {zone:1413} ; {npc:6251} se tient sur la colline de la ville.",
	-- ["{npc:6251}: he binds the felhunter to you"] = "{npc:6251} : il vous lie le chasseur corrompu",
	-- ["{npc:6294} stands in the {object:32356}."] = "{npc:6294} se tient dans le {object:32356}.",
}
