-- Korean (koKR): the guide forever/class/warlock/incubus-alliance (forever/class/warlock/incubus-alliance.guide).
-- Written by `forge i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Succubus and Incubus (Alliance)"] = "",
	["At 20: the succubus and Forever's incubus, its male twin, each with a soul pouch for your shards."] = "",

	-- Step 1: Gakin's Summons (Gnomes)
	-- {quest:1717} Gakin's Summons
	["{quest:1717} (Gnomes)"] = "",
	-- {npc:6120} Lago Blackwrench · {zone:1455} Ironforge · {object:32383} Forlorn Cavern · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["At 20 {npc:6120}, the warlock trainer in {zone:1455}'s {object:32383}, sends you to {npc:6122} in {zone:1453}. Take the Deeprun Tram."] = "",

	-- Step 2: Devourer of Souls
	-- {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6244} Takar the Seer · {zone:1413} Barrens · {object:1162} Menethil Harbor (no name in this language: may be words) · {zone:1445} Dustwallow Marsh · {object:3204} Booty Bay (no name in this language: may be words)
	["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}: a long trip for the Alliance. Take the boat from {object:1162} to Theramore and head west through {zone:1445}, or the boat from {object:3204} to Ratchet."] = "",

	-- Step 3: Takar the Seer
	-- {npc:6244} Takar the Seer · {npc:6247} Doan Karhan · {item:6898} Orb of Soran'ruk
	["{npc:6244} camps at a tent with a campfire just north-east of Camp Taurajo, by a fork in the road: Horde ground, so come in from the east and keep clear of the Taurajo guards. {npc:6247} beside him starts the {item:6898}. Takar offers both branches: take both."] = "",
	["the succubus"] = "",
	["the incubus"] = "",

	-- Step 4: Heartswood
	-- {zone:1440} Ashenvale · {zone:1439} Darkshore · {quest:1738} Heartswood · {npc:6122} Gakin the Darkbinder
	["Ordil'Aran lies in north-west {zone:1440}, north of Astranaar along the road toward {zone:1439}. About twenty Dark Strand cultists hold the ruins around the great tree: keep to the outer wall, and click the {quest:1738} from as far away as it lets you. It is turned in to {npc:6122}, not to Takar."] = "",

	-- Step 5: The Wooden Figurine
	-- {item:190309} Wooden Figurine
	["The {item:190309}"] = "",
	-- {zone:1440} Ashenvale · {object:19863} Maestra's Post (no name in this language: may be words) · {quest:1738} Heartswood · {item:190307} Unlit Torch · {object:29784} Basic Campfire · {item:190308} Burning Torch
	["The house stands alone in the trees of north-western {zone:1440}, north-west of Ordil'Aran and well north of {object:19863}: do it on the same trip as the {quest:1738}. Take the {item:190307} from the table outside, light it at a campfire (a {object:29784} of your own, or Talen's fire on Zoram Strand), and go straight back: the {item:190308} burns out after five minutes, so a fire of your own beside the house is quickest. Without it the figure in the house stops you. The figurine is upstairs."] = "",
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
	-- ["A second seducer demon, the male sayaad, and a soul shard bag to carry your shards."] = "두 번째 유혹 악마인 남성 사야드, 그리고 영혼의 조각을 담을 영혼의 조각 가방.",
	-- ["At 20 {npc:6122}, in the cellar of the {object:2164} in the {object:2101}, sends you to {npc:6244} in the {zone:1413}."] = "20레벨에 {object:2101} {object:2164} 지하실의 {npc:6122}이(가) {zone:1413}의 {npc:6244}에게 보냅니다.",
	-- ["Back to {npc:6122} in the {object:2164}. Place the figurine at the summoning circle in the crypt below him and defeat the incubus it calls."] = "{object:2164}의 {npc:6122}에게 돌아가십시오. 그 아래 지하 묘지의 소환진에 조각상을 놓고, 불러낸 인큐버스를 처치하십시오.",
	-- ["From {area:415} take the road west to {area:413}: the figurine lies in a house among the trees north of the post."] = "{area:415}에서 서쪽 길을 따라 {area:413}(으)로 가십시오: 조각상은 초소 북쪽 나무 사이 집 안에 있습니다.",
	-- ["Incubus (Alliance)"] = "인큐버스 (얼라이언스)",
	-- ["{npc:6122}: he binds the incubus to you"] = "{npc:6122}: 인큐버스를 당신에게 귀속시킵니다",
	-- ["{npc:6244} camps in the southern {zone:1413}, east of the road north-east of {area:378}: come in from the east and keep clear of the Horde guards."] = "{npc:6244}은(는) {zone:1413} 남부, {area:378} 북동쪽 길의 동쪽에 야영하고 있습니다: 동쪽에서 접근하고 호드 경비병을 피하십시오.",
}
