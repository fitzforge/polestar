-- Russian (ruRU): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Succubus and Incubus (Alliance)"] = "Суккуб и инкуб (Альянс)",
	["At 20: the succubus and Forever's incubus, its male twin, each with a soul pouch for your shards."] = "На 20-м уровне: суккуб и инкуб Forever – её двойник мужского пола, – и к каждому сумка для осколков души.",

	-- Step 1: Gakin's Summons (Gnomes)
	-- {quest:1717} Gakin's Summons
	["{quest:1717} (Gnomes)"] = "",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind · {area:2257} Deeprun Tram
	["At 20 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the {area:2257}."] = "",

	-- Step 2: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens · {area:150} Menethil Harbor · {zone:1445} Dustwallow Marsh · {area:35} Booty Bay · {area:392} Ratchet
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}: a long trip for the Alliance. Take the boat from {area:150} to Theramore and head west through {zone:1445}, or the boat from {area:35} to {area:392}."] = "На 20-м уровне {npc:6122} из подвала таверны ({object:2164}, {object:2101}) отправляет вас к персонажу {npc:6244} ({zone:1413}): для Альянса это долгий путь. Плывите на корабле из места {area:150} на Терамор и идите на запад через {zone:1445} или плывите из места {area:35} сюда: {area:392}.",

	-- Step 3: Takar the Seer
	-- {npc:6244} Takar the Seer · {area:378} Camp Taurajo · {npc:6247} Doan Karhan · {item:6898} Orb of Soran'ruk
	["{npc:6244} camps at a tent with a campfire just north-east of {area:378}, by a fork in the road: Horde ground, so come in from the east and keep clear of the Taurajo guards. {npc:6247} beside him starts the {item:6898}. Takar offers both branches: take both."] = "",
	["the succubus"] = "",
	["the incubus"] = "",

	-- Step 4: Heartswood
	-- {zone:1440} Ashenvale · {area:415} Astranaar · {zone:1439} Darkshore · {quest:1738} Heartswood · {npc:6122} Gakin the Darkbinder
	["Ordil'Aran lies in north-west {zone:1440}, north of {area:415} along the road toward {zone:1439}. About twenty Dark Strand cultists hold the ruins around the great tree: keep to the outer wall, and click the {quest:1738} from as far away as it lets you. It is turned in to {npc:6122}, not to Takar."] = "",

	-- Step 5: The Wooden Figurine
	-- {item:190309} Wooden Figurine
	["The {item:190309}"] = "",
	-- {zone:1440} Ashenvale · {area:413} Maestra's Post · {quest:1738} Heartswood · {item:190307} Unlit Torch · {object:29784} Basic Campfire · {area:414} Zoram Strand · {item:190308} Burning Torch
	["The house stands alone in the trees of north-western {zone:1440}, north-west of Ordil'Aran and well north of {area:413}: do it on the same trip as the {quest:1738}. Take the {item:190307} from the table outside, light it at a campfire (a {object:29784} of your own, or Talen's fire on {area:414}), and go straight back: the {item:190308} burns out after five minutes, so a fire of your own beside the house is quickest. Without it the figure in the house stops you. The figurine is upstairs."] = "",
	-- {item:190307} Unlit Torch
	["{item:190307}, on the table outside"] = "",
	-- {item:190309} Wooden Figurine
	["{item:190309}, upstairs"] = "",

	-- Step 6: The Binding: succubus
	-- {quest:1739} The Binding
	["{quest:1739}: succubus"] = "",
	-- {npc:6122} Gakin the Darkbinder · {quest:1738} Heartswood · {item:6913} Heartswood Core
	["Back to {npc:6122} with the {quest:1738}. He hands you the {item:6913}: take the stairs behind him down to the crypt; part way along the lowest corridor a side stair on the left leads to the room with the purple circle. Stand on it and use the core. Summon your voidwalker first and keep the succubus (level 20, not elite) on the circle, or the guards may kill her and the kill does not count. If she wins, use the core again; keep it, {npc:6122} takes it back."] = "",
	-- {item:6913} Heartswood Core
	["{item:6913}, on the circle in the crypt"] = "",

	-- Step 7: The Binding: incubus
	-- {quest:65603} The Binding
	["{quest:65603}: incubus"] = "",
	-- {item:190309} Wooden Figurine · {npc:6122} Gakin the Darkbinder
	["Give Gakin the figurine, then use the {item:190309} at the middle of the same circle and defeat the incubus it calls (level 20, not elite; it can charm you) with your voidwalker tanking. Keep the figurine: {npc:6122} takes it back."] = "",
	-- {npc:185335} Summoned Incubus
	["{npc:185335}, at the circle in the crypt"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "Второй демон-соблазнитель – сайаад мужского пола – и сумка для осколков души.",
	-- ["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "Назад к {npc:6122} ({object:2164}). Поставьте статуэтку в круг призыва в склепе под ним и победите вызванного инкуба.",
	-- ["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "Идите по дороге на запад: {area:415} → {area:413}. Статуэтка лежит в доме среди деревьев к северу от заставы.",
	-- ["Incubus (Alliance)"] = "Инкуб (Альянс)",
	-- ["{npc:6122}: he binds the incubus to you"] = "{npc:6122}: он привязывает инкуба к вам",
	-- ["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244} стоит лагерем на юге зоны {zone:1413}, к востоку от дороги, северо-восточнее места {area:378}: подходите с востока и держитесь подальше от стражи Орды.",
}
