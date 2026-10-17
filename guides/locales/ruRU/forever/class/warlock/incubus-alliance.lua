-- Russian (ruRU): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Incubus (Alliance)"] = "Инкуб (Альянс)",
	["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Второй демон-соблазнитель – сайаад мужского пола – и сумка для осколков души.",

	-- Step 1: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}."] = "На 20-м уровне {npc:6122} из подвала таверны ({object:2164}, {object:2101}) отправляет вас к персонажу {npc:6244} ({zone:1413}).",

	-- Step 2: Takar the Seer
	-- {npc:6244} Takar the Seer · {zone:1413} Barrens · {area:378} Camp Taurajo
	["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244} стоит лагерем на юге зоны {zone:1413}, к востоку от дороги, северо-восточнее места {area:378}: подходите с востока и держитесь подальше от стражи Орды.",

	-- Step 3: Wooden Figurine
	-- {area:415} Astranaar · {area:413} Maestra's Post
	["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "Идите по дороге на запад: {area:415} → {area:413}. Статуэтка лежит в доме среди деревьев к северу от заставы.",

	-- Step 4: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb
	["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "Назад к {npc:6122} ({object:2164}). Поставьте статуэтку в круг призыва в склепе под ним и победите вызванного инкуба.",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122}: he binds the incubus to you"] = "{npc:6122}: он привязывает инкуба к вам",
}
