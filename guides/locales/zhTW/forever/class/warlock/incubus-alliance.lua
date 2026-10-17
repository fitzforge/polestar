-- Chinese (traditional) (zhTW): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Incubus (Alliance)"] = "夢魔（聯盟）",
	["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "第二種誘惑型惡魔，也就是男性的魅魔，還有一個用來裝靈魂碎片的靈魂碎片包。",

	-- Step 1: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}."] = "20級時，{object:2101}{object:2164}地下室的{npc:6122}會派你去{zone:1413}找{npc:6244}。",

	-- Step 2: Takar the Seer
	-- {npc:6244} Takar the Seer · {zone:1413} Barrens · {area:378} Camp Taurajo
	["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244}在{zone:1413}南部、{area:378}東北方道路的東邊紮營：從東邊過去，避開部落守衛。",

	-- Step 3: Wooden Figurine
	-- {area:415} Astranaar · {area:413} Maestra's Post
	["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "從{area:415}沿著道路向西前往{area:413}：小雕像在前哨站北邊樹林中的一間房子裡。",

	-- Step 4: The Binding
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb
	["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "回到{object:2164}的{npc:6122}處。把小雕像放在他下方地穴的召喚法陣上，擊敗它召喚出的夢魔。",
	-- {npc:6122} Gakin the Darkbinder
	["{npc:6122}: he binds the incubus to you"] = "{npc:6122}：他會把夢魔束縛給你",
}
