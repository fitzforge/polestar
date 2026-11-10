-- German (deDE): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Succubus and Incubus (Alliance)"] = "Sukkubus und Inkubus (Allianz)",
	["At 20: the succubus and Forever's incubus, its male twin, each with a soul pouch for your shards."] = "Auf Stufe 20: der Sukkubus und der Inkubus von Forever, sein männliches Gegenstück, jeweils mit einem Seelenbeutel für deine Splitter.",

	-- Step 1: Gakin's Summons (Gnomes)
	-- {quest:1717} Gakin's Summons
	["{quest:1717} (Gnomes)"] = "{quest:1717} (Gnome)",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram
	["At 20 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257}."] = "Mit Stufe 20 schickt dich {npc:6120}, der Hexenmeisterlehrer in {object:32383} von {zone:1455}, zu {npc:6122} in {zone:1453}. Nimm die {area:2257}.",

	-- Step 2: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens · {area:150} Menethil Harbor · {zone:1445} Dustwallow Marsh · {area:35} Booty Bay · {area:392} Ratchet
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}: a long trip for the Alliance. Take the boat from {area:150} to Theramore and head west through {zone:1445}, or the boat from {area:35} to {area:392}."] = "Mit Stufe 20 schickt dich {npc:6122}, im Keller von {object:2164} im {object:2101}, zu {npc:6244} im {zone:1413}: eine lange Reise für die Allianz. Nimm das Boot von {area:150} nach Theramore und geh nach Westen durch {zone:1445}, oder das Boot von {area:35} nach {area:392}.",

	-- Step 3: Takar the Seer
	-- {npc:6244} Takar the Seer · {area:378} Camp Taurajo · {npc:6247} Doan Karhan · {item:6898} Orb of Soran'ruk
	["{npc:6244} camps at a tent with a campfire just north-east of {area:378}, by a fork in the road: Horde ground, so come in from the east and keep clear of the Taurajo guards. {npc:6247} beside him starts the {item:6898}. Takar offers both branches: take both."] = "{npc:6244} lagert an einem Zelt mit Lagerfeuer direkt nordöstlich von {area:378}, an einer Wegkreuzung: Hordeland, komm also von Osten und halte dich von den Wachen von Taurajo fern. {npc:6247} neben ihm beginnt {item:6898}. Takar bietet beide Zweige an: Nimm beide.",
	["the succubus"] = "der Sukkubus",
	["the incubus"] = "der Inkubus",

	-- Step 4: Heartswood
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {zone:1439} Darkshore · {quest:1738} Heartswood · {npc:6122} Gakin the Darkbinder
	["Ordil'Aran lies in north-west {zone:1440}, north of {area:415} along the road toward {zone:1439}. About twenty Dark Strand cultists hold the ruins around the great tree: keep to the outer wall, and click the {quest:1738} from as far away as it lets you. It is turned in to {npc:6122}, not to Takar."] = "Ordil'Aran liegt im nordwestlichen {zone:1440}, nördlich von {area:415} an der Straße Richtung {zone:1439}. Etwa zwanzig Kultisten der Dark Strand halten die Ruinen um den großen Baum: Bleib an der Außenmauer und klicke {quest:1738} aus möglichst großer Entfernung an. Sie wird bei {npc:6122} abgegeben, nicht bei Takar.",

	-- Step 5: The Wooden Figurine
	-- {item:190309} Wooden Figurine
	["The {item:190309}"] = "{item:190309}",
	-- {zone:1440} Ashenvale · {area:413} Maestra's Post · {quest:1738} Heartswood · {item:190307} Unlit Torch · {object:29784} Basic Campfire · {area:414} Zoram Strand · {item:190308} Burning Torch
	["The house stands alone in the trees of north-western {zone:1440}, north-west of Ordil'Aran and well north of {area:413}: do it on the same trip as the {quest:1738}. Take the {item:190307} from the table outside, light it at a campfire (a {object:29784} of your own, or Talen's fire on {area:414}), and go straight back: the {item:190308} burns out after five minutes, so a fire of your own beside the house is quickest. Without it the figure in the house stops you. The figurine is upstairs."] = "Das Haus steht allein zwischen den Bäumen im nordwestlichen {zone:1440}, nordwestlich von Ordil'Aran und weit nördlich von {area:413}: Erledige es auf derselben Reise wie {quest:1738}. Nimm {item:190307} vom Tisch draußen, entzünde sie an einem Lagerfeuer (ein {object:29784} von dir selbst oder Talens Feuer bei {area:414}) und geh direkt zurück: {item:190308} brennt nach fünf Minuten aus, ein eigenes Feuer neben dem Haus ist also am schnellsten. Ohne sie hält dich die Gestalt im Haus auf. Die Figur ist im Obergeschoss.",
	-- {item:190307} Unlit Torch
	["{item:190307}, on the table outside"] = "{item:190307}, auf dem Tisch draußen",
	-- {item:190309} Wooden Figurine
	["{item:190309}, upstairs"] = "{item:190309}, im Obergeschoss",

	-- Step 6: The Binding: succubus
	-- {quest:1739} The Binding
	["{quest:1739}: succubus"] = "{quest:1739}: Sukkubus",
	-- {npc:6122} Gakin the Darkbinder · {quest:1738} Heartswood · {item:6913} Heartswood Core
	["Back to {npc:6122} with the {quest:1738}. He hands you the {item:6913}: take the stairs behind him down to the crypt; part way along the lowest corridor a side stair on the left leads to the room with the purple circle. Stand on it and use the core. Summon your voidwalker first and keep the succubus (level 20, not elite) on the circle, or the guards may kill her and the kill does not count. If she wins, use the core again; keep it, {npc:6122} takes it back."] = "Zurück zu {npc:6122} mit {quest:1738}. Er gibt dir {item:6913}: Nimm die Treppe hinter ihm hinab in die Krypta; ein Stück weit im untersten Gang führt links eine Seitentreppe zum Raum mit dem violetten Kreis. Stell dich darauf und benutze den Kern. Beschwöre zuerst deinen Leerwandler und halte den Sukkubus (Stufe 20, kein Elite) auf dem Kreis, sonst töten ihn vielleicht die Wachen und der Kill zählt nicht. Gewinnt er, benutze den Kern erneut; behalte ihn, {npc:6122} nimmt ihn zurück.",
	-- {item:6913} Heartswood Core
	["{item:6913}, on the circle in the crypt"] = "{item:6913}, auf dem Kreis in der Krypta",

	-- Step 7: The Binding: incubus
	-- {quest:65603} The Binding
	["{quest:65603}: incubus"] = "{quest:65603}: Inkubus",
	-- {item:190309} Wooden Figurine · {npc:6122} Gakin the Darkbinder
	["Give Gakin the figurine, then use the {item:190309} at the middle of the same circle and defeat the incubus it calls (level 20, not elite; it can charm you) with your voidwalker tanking. Keep the figurine: {npc:6122} takes it back."] = "Gib Gakin die Figur, benutze dann {item:190309} in der Mitte desselben Kreises und besiege den Inkubus, den sie ruft (Stufe 20, kein Elite; er kann dich bezaubern), während dein Leerwandler tankt. Behalte die Figur: {npc:6122} nimmt sie zurück.",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the circle in the crypt"] = "{npc:185335}, am Kreis in der Krypta",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Ein zweiter Verführerdämon, der männliche Sayaad, und eine Seelentasche für deine Splitter.",
	-- ["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}."] = "Auf Stufe 20 schickt dich {npc:6122} im Keller des {object:2164} im {object:2101} zu {npc:6244} im {zone:1413}.",
	-- ["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "Zurück zu {npc:6122} im {object:2164}. Stell die Figur in den Beschwörungskreis in der Gruft unter ihm und besiege den Inkubus, den sie ruft.",
	-- ["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "Nimm von {area:415} die Straße nach Westen zu {area:413}: Die Figur liegt in einem Haus zwischen den Bäumen nördlich des Postens.",
	-- ["Incubus (Alliance)"] = "Inkubus (Allianz)",
	-- ["{npc:6122}: he binds the incubus to you"] = "{npc:6122}: Er bindet den Inkubus an dich",
	-- ["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244} lagert im südlichen {zone:1413}, östlich der Straße nordöstlich von {area:378}: Komm von Osten und halte dich von den Wachen der Horde fern.",
}
