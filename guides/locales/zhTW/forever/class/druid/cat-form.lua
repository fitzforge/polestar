-- Chinese (traditional) (zhTW): the guide forever/class/druid/cat-form (forever/class/druid/cat-form.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:768} Cat Form
	["Your stealth and melee form: in Forever this chain gives {spell:768} at 20, not the trainer."] = "你的潛行與近戰形態：在 Forever 中，這個任務鏈在20級時給予{spell:768}，而不是由訓練師教授。",

	-- Step 1: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {zone:1457} Darnassus · {spell:18960} Teleport: Moonglade · {npc:11800} Silva Fil'naveth · {area:2361} Nighthaven · {area:702} Rut'theran Village · {spell:1066} Aquatic Form · {npc:11802} Dendrite Starblaze · {area:493} Moonglade
	["{npc:4217} stands in the {area:1658}. Skyborne far from {zone:1457}: cast {spell:18960} and take {npc:11800}'s flight from the middle of {area:2361} (she flies druids to {area:702}, no flight path needed), then the portal up. No {spell:1066} yet? Take A Lesson to Learn from him too: it also goes to {npc:11802}, and its Trial of the Lake (the {spell:1066} guide) is in the same {area:493}."] = "{npc:4217}站在{area:1658}。天裔精靈角色若離{zone:1457}很遠：施放{spell:18960}，搭乘{area:2361}中央{npc:11800}的航班（她會將德魯伊送到{area:702}，無需學會飛行路線），然後通過傳送門上去。還沒有{spell:1066}？也向他接取「一堂必修的課程」：這個任務同樣要找{npc:11802}，後續的「湖中試煉」（見{spell:1066}指南）也在同一個{area:493}完成。",

	-- Step 3: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:493} Moonglade · {npc:10897} Sindrayl
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. No {area:493} flight path yet? Learn it from {npc:10897}, south of the lake: the flight master in {area:2361} flies only Druids, from her gossip, and has none to learn."] = "施放{spell:18960}。{npc:11802}站在{area:2361}他建築的樓上：從裡面走上去，箭頭無法分辨樓層。還沒有{area:493}的飛行路線？向湖南邊的{npc:10897}學習：{area:2361}的飛行管理員只透過對話載德魯伊，也沒有飛行路線可學。",

	-- Step 4: The relics of the Barrow Dens
	["The relics of the Barrow Dens"] = "怒風獸穴的遺物",
	-- {quest:98394} The Great Cat Spirit · {area:493} Moonglade · {npc:272054} Avatar of Saeyleenan · {area:2361} Nighthaven · {area:2363} Stormrage Barrow Dens
	["{quest:98394} (Night Elves) waits on the hill above the bridge in southern {area:493}; the {npc:272054} (Skyborne) stands on high ground past the twin bridges, south-west of {area:2361}: climb up to it. The relics lie in the {area:2363} east of the lake: leave your form and click the statue at the den's entrance for a short stealth (five minutes), then go deep into the cave and over the bridge. Enraged spirits guard the relics and attack anything they see: stay in the statue's stealth and keep moving. Each relic is a small orb beside a cat statue in an alcove: the Fang and the Claw have one spot each, the Silent Shadow two, and it is the one players camp. A relic shows as unusable while another player loots it: wait a moment and try again. Stealth gone? Walk back to the entrance statue for more."] = "{quest:98394}（暗夜精靈）在{area:493}南部橋上方的小山上；{npc:272054}（天裔）站在雙橋過去的高地上，位於{area:2361}西南：爬上去找它。聖物在湖東的{area:2363}：解除形態，點選巢穴入口處的雕像，可獲得短暫潛行（五分鐘），然後深入洞穴並越過橋。狂怒的靈魂守衛著聖物，見到什麼就攻擊什麼：保持雕像給予的潛行，一直移動。每件聖物都是壁龕裡貓雕像旁的小球：毒牙和利爪各有一處，無聲之影有兩處，也正是玩家常蹲守的那處。別人正在拾取時，聖物會顯示為不可用：稍等片刻再試。潛行沒了？走回入口的雕像再拿一次。",

	-- Step 5: Back to Dendrite Starblaze
	-- {npc:11802} Dendrite Starblaze
	["Back to {npc:11802}"] = "返回{npc:11802}處",
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11800} Silva Fil'naveth · {area:702} Rut'theran Village
	["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11800}'s flight to {area:702}: she stands in the middle of {area:2361} and flies druids there, no flight path needed. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "施放{spell:18960}降到{area:2361}的{npc:11802}身旁（澤弗拉斯島上沒人接天裔任務），然後乘{npc:11800}的航班前往{area:702}：她站在{area:2361}中央，專門載德魯伊去那裡，無需飛行點。{npc:11802}站在他所在建築的樓上：從裡面上樓，箭頭分不清樓層。",

	-- Step 6: Cenarion Enclave
	-- {npc:4217} Mathrengyl Bearwalker · {area:1658} Cenarion Enclave · {spell:768} Cat Form
	["Take the portal up to {npc:4217}, upstairs in the {area:1658}: he teaches you {spell:768}."] = "搭傳送門上去，到{area:1658}樓上找{npc:4217}：他會教你{spell:768}。",

	-- Step 8: The Great Cat Spirit
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:1066} Aquatic Form · {npc:11802} Dendrite Starblaze · {area:493} Moonglade
	["{npc:3033} stands in the druids' hut on {area:1639}. No {spell:1066} yet? Take A Lesson to Learn from him too: it also goes to {npc:11802}, and its Trial of the Lake (the {spell:1066} guide) is in the same {area:493}."] = "{npc:3033}站在{area:1639}的德魯伊小屋內。還沒學會{spell:1066}？也從他那裡接取「一堂必修的課程」：同樣是去找{npc:11802}，後續的「湖中試煉」（{spell:1066}指南）也在同一個{area:493}。",

	-- Step 9: Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "施放{spell:18960}。{npc:11802}站在{area:2361}他所在建築的樓上：從裡面上樓，箭頭分不清樓層。",

	-- Step 10: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "{area:2363}",
	-- {quest:98342} The Great Cat Spirit · {area:493} Moonglade · {npc:272054} Avatar of Saeyleenan · {area:2361} Nighthaven · {area:2363} Stormrage Barrow Dens
	["{quest:98342} (Tauren) waits on the hill above the bridge in southern {area:493}; the {npc:272054} (Skyborne) stands on high ground past the twin bridges, south-west of {area:2361}: climb up to it. The relics lie in the {area:2363} east of the lake: leave your form and click the statue at the den's entrance for a short stealth (five minutes), then go deep into the cave and over the bridge. Enraged spirits guard the relics and attack anything they see: stay in the statue's stealth and keep moving. Each relic is a small orb beside a cat statue in an alcove: the Fang and the Claw have one spot each, the Silent Shadow two, and it is the one players camp. A relic shows as unusable while another player loots it: wait a moment and try again. Stealth gone? Walk back to the entrance statue for more."] = "{quest:98342}（牛頭人）在{area:493}南部橋上方的小山上；{npc:272054}（天裔）站在雙橋過去的高地上，位於{area:2361}西南：爬上去找它。聖物在湖東的{area:2363}：解除形態，點選巢穴入口處的雕像，可獲得短暫潛行（五分鐘），然後深入洞穴並越過橋。狂怒的靈魂守衛著聖物，見到什麼就攻擊什麼：保持雕像給予的潛行，一直移動。每件聖物都是壁龕裡貓雕像旁的小球：毒牙和利爪各有一處，無聲之影有兩處，也正是玩家常蹲守的那處。別人正在拾取時，聖物會顯示為不可用：稍等片刻再試。潛行沒了？走回入口的雕像再拿一次。",

	-- Step 11: Back to Dendrite Starblaze
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff
	["Cast {spell:18960} to land by {npc:11802} in {area:2361} (nobody on Zephras Isle takes the Skyborne quest), then take {npc:11798}'s flight to {area:1638}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "施放{spell:18960}降到{area:2361}的{npc:11802}身旁（澤弗拉斯島上沒人接天裔任務），然後從{npc:11798}處飛往{area:1638}。{npc:11802}站在他所在建築的樓上：從裡面上樓，箭頭分不清樓層。",

	-- Step 12: To Thunder Bluff
	-- {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:768} Cat Form
	["{npc:3033} on {area:1639} teaches you {spell:768}."] = "{area:1639}的{npc:3033}會教你{spell:768}。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:11802} in {area:2361}, then fly to {area:702}."] = "回到{area:2361}的{npc:11802}處，然後飛往{area:702}。",
	-- ["Back to {npc:11802} in {area:2361}, then take {npc:11798}'s flight to {area:1638}."] = "回到{area:2361}的{npc:11802}處，然後搭乘{npc:11798}的飛行路線前往{area:1638}。",
	-- ["Cast {spell:18960}. {npc:11802} is in {area:2361}."] = "施放{spell:18960}。{npc:11802}在{area:2361}。",
	-- ["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. Learn the flight path there if you do not have it."] = "施放{spell:18960}。{npc:11802}站在{area:2361}他建築的樓上：從裡面走上去，箭頭無法分辨樓層。如果你還沒有那裡的飛行路線就學起來。",
	-- ["{npc:4217} stands in the {area:1658}. Skyborne without the Rut'theran flight path: take the boat from {area:442}."] = "{npc:4217}站在{area:1658}。沒有魯瑟蘭村飛行路線的天裔精靈：從{area:442}搭船。",
	-- ["{quest:98342} (Tauren) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98342}（牛頭人）在橋上方的南邊山丘等候，{npc:272054}（天裔精靈）在雙橋南邊。遺物在湖東邊的{area:2363}裡：解除你的形態，點擊入口的雕像獲得五分鐘的潛行，避開裡面的靈魂，每種遺物各拿一個；{item:280680}在白色豹子雕像的腳下。其他玩家正在拾取某個遺物時，你拿不到東西：稍等一下再試。",
	-- ["{quest:98394} (Night Elves) waits on the southern hill above the bridge, the {npc:272054} (Skyborne) south of the twin bridges. The relics lie in the {area:2363} east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. A relic gives no loot while another player is looting it: wait a moment and try again."] = "{quest:98394}（夜精靈）在橋上方的南邊山丘等候，{npc:272054}（天裔精靈）在雙橋南邊。遺物在湖東邊的{area:2363}裡：解除你的形態，點擊入口的雕像獲得五分鐘的潛行，避開裡面的靈魂，每種遺物各拿一個；{item:280680}在白色豹子雕像的腳下。其他玩家正在拾取某個遺物時，你拿不到東西：稍等一下再試。",
}
