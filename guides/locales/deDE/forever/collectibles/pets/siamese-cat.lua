-- German (deDE): the guide forever/collectibles/pets/siamese-cat (forever/collectibles/pets/siamese-cat.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Siamese Cat"] = "Siamkatze",

	-- Step 1: The Deadmines: Cookie
	-- {area:1581} The Deadmines
	["{area:1581}: Cookie"] = "{area:1581}: Krümel",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581} is a group of five under {area:20}: the mine mouth is in {area:20}, the instance portal deep inside the mine. Cookie, the murloc cook, waits on a small island under the pirate ship at the far end, an optional boss; his cooking heals him, so interrupt it. He drops the Siamese about 15% of the time in Classic's data: expect several runs. The carrier can be traded, so check the Auction House too."] = "{area:1581} ist eine Gruppe von fünf unter {area:20}: Der Eingang der Mine ist in {area:20}, das Instanzportal tief in der Mine. Cookie, der Murloc-Koch, wartet auf einer kleinen Insel unter dem Piratenschiff am Ende, ein optionaler Boss; sein Kochen heilt ihn, unterbrich es also. Er lässt die Siamkatze in den Daten von Classic zu etwa 15% fallen: rechne mit mehreren Durchgängen. Der Korb ist handelbar, schau also auch im Auktionshaus.",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581}, in the {area:20} mine"] = "{area:1581}, in der Mine von {area:20}",
	-- {area:1581} The Deadmines · {area:20} Moonbrook
	["{area:1581} portal, inside the {area:20} mine"] = "Portal von {area:1581}, in der Mine von {area:20}",
	["Cookie"] = "Krümel",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:1581} is a group of five under {area:20}; the instance portal is inside the {area:20} mine. Cookie, the murloc cook near the ship at the end, drops the Siamese about 15% of the time in our data."] = "{area:1581} ist ein Dungeon für fünf Spieler unter {area:20}; das Instanzportal liegt in der Mine von {area:20}. Krümel, der Murlockoch beim Schiff am Ende, droppt die Siamkatze laut unseren Daten in etwa 15 % der Fälle.",
}
