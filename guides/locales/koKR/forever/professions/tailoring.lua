-- Korean (koKR): the guide forever/professions/tailoring (forever/professions/tailoring.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Tailoring
	-- {skill:197} Tailoring
	["Apprentice {skill:197}"] = "초급 {skill:197}",
	-- {skill:197} Tailoring
	["{skill:197} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 1g 8s in all."] = "{skill:197}은(는) 레벨업과 함께 진행합니다. Forever의 유산 시스템은 제작 전문 기술 숙련도 150, 225, 300(수습, 숙련, 전문 최대치)에 보상을 주므로, 각 단계가 중요합니다. 1-75 재료는 모두 약 1골드 8실버입니다.",

	-- Step 2: Linen Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Polestar가 레벨과 진영에 맞춰 고른 사냥터에서 이것을 떨어뜨리는 몹을 처치하세요. 경매장도 됩니다.",

	-- Step 3: Simple Linen Pants to 50
	-- {item:10045} Simple Linen Pants
	["{item:10045} to 50"] = "{item:10045}: 50까지",
	["Orange (a point every craft) until 40, yellow until 50, green until 60."] = "40까지 주황색(만들 때마다 1점), 50까지 노란색, 60까지 초록색입니다.",

	-- Step 4: Tailoring recipes at 50
	-- {skill:197} Tailoring
	["{skill:197} recipes at 50"] = "50에서 {skill:197} 제조법",
	-- {skill:197} Tailoring · {spell:8776} Linen Belt
	["Back to a {skill:197} trainer: {spell:8776} is taught from {skill:197} 50."] = "{skill:197} 상급자에게 돌아가세요. {spell:8776}은(는) {skill:197} 50부터 배울 수 있습니다.",

	-- Step 5: Linen Belt to 75
	-- {item:7026} Linen Belt
	["{item:7026} to 75"] = "{item:7026}: 75까지",
	["Yellow until 67, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "67까지 노란색, 85까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 75은(는) 초급 최대치입니다.",

	-- Step 6: Journeyman Tailoring
	-- {skill:197} Tailoring
	["Journeyman {skill:197}"] = "수습 {skill:197}",
	-- {skill:197} Tailoring
	["Journeyman needs character level 10 and {skill:197} 50; it raises the cap to 150. Materials for 75-150 are worth about 17g in all."] = "수습은(는) 캐릭터 레벨 10, {skill:197} 50이(가) 필요하며 최대 숙련도를 150(으)로 올립니다. 75-150 재료는 모두 약 17골드입니다.",

	-- Step 8: Wool Cloth (Alliance)
	-- {item:2592} Wool Cloth
	["{item:2592} (Alliance)"] = "{item:2592} (얼라이언스)",
	-- {npc:98} Riverpaw Taskmaster
	["{npc:98} (level 17-18) drop it here. The Auction House works too."] = "이곳의 {npc:98}(17-18레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 9: Wool Cloth (Horde)
	-- {item:2592} Wool Cloth
	["{item:2592} (Horde)"] = "{item:2592} (호드)",
	-- {npc:3263} Bristleback Geomancer
	["{npc:3263} (level 19-20) drop it here. The Auction House works too."] = "이곳의 {npc:3263}(19-20레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 10: Tailoring materials for 75-150
	-- {skill:197} Tailoring
	["{skill:197} materials for 75-150"] = "{skill:197} 재료(75-150)",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "무두질, 마력 추출 또는 다른 전문 기술로 얻는 재료입니다. 직접 모으거나 경매장에서 사세요.",
	-- {skill:171} Alchemy · {item:3383} Elixir of Wisdom
	["{skill:171}: {item:3383} (or the Auction House)"] = "{skill:171}: {item:3383} (또는 경매장)",

	-- Step 11: Linen Belt to 80
	-- {item:7026} Linen Belt
	["{item:7026} to 80"] = "{item:7026}: 80까지",
	["Yellow until 67, green until 85: not every craft gives a point."] = "67까지 노란색, 85까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 12: Tailoring recipes at 80
	-- {skill:197} Tailoring
	["{skill:197} recipes at 80"] = "80에서 {skill:197} 제조법",
	-- {skill:197} Tailoring · {spell:2402} Woolen Cape
	["Back to a {skill:197} trainer: {spell:2402} is taught from {skill:197} 80."] = "{skill:197} 상급자에게 돌아가세요. {spell:2402}은(는) {skill:197} 80부터 배울 수 있습니다.",

	-- Step 13: Woolen Cape to 110
	-- {spell:2402} Woolen Cape
	["{spell:2402} to 110"] = "{spell:2402}: 110까지",
	["Yellow until 97, green until 115: not every craft gives a point."] = "97까지 노란색, 115까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 14: Tailoring recipes at 110
	-- {skill:197} Tailoring
	["{skill:197} recipes at 110"] = "110에서 {skill:197} 제조법",
	-- {skill:197} Tailoring · {spell:3848} Double-stitched Woolen Shoulders
	["Back to a {skill:197} trainer: {spell:3848} is taught from {skill:197} 110."] = "{skill:197} 상급자에게 돌아가세요. {spell:3848}은(는) {skill:197} 110부터 배울 수 있습니다.",

	-- Step 15: Double-stitched Woolen Shoulders to 125
	-- {spell:3848} Double-stitched Woolen Shoulders
	["{spell:3848} to 125"] = "{spell:3848}: 125까지",
	["Yellow until 127, green until 145: not every craft gives a point."] = "127까지 노란색, 145까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 16: Tailoring recipes at 125
	-- {skill:197} Tailoring
	["{skill:197} recipes at 125"] = "125에서 {skill:197} 제조법",
	-- {skill:197} Tailoring · {spell:3852} Gloves of Meditation
	["Back to a {skill:197} trainer: {spell:3852} is taught from {skill:197} 125."] = "{skill:197} 상급자에게 돌아가세요. {spell:3852}은(는) {skill:197} 125부터 배울 수 있습니다.",

	-- Step 17: Gloves of Meditation to 150
	-- {spell:3852} Gloves of Meditation
	["{spell:3852} to 150"] = "{spell:3852}: 150까지",
	-- {skill:197} Tailoring
	["Yellow until 140, green until 155: not every craft gives a point. {skill:197} 150 is a Legacy System milestone."] = "140까지 노란색, 155까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. {skill:197} 150은(는) 유산 시스템 단계입니다.",

	-- Step 18: Expert Tailoring
	-- {skill:197} Tailoring
	["Expert {skill:197}"] = "숙련 {skill:197}",
	-- {skill:197} Tailoring
	["Expert needs character level 20 and {skill:197} 125; it raises the cap to 225. Materials for 150-225 are worth about 135g in all."] = "숙련은(는) 캐릭터 레벨 20, {skill:197} 125이(가) 필요하며 최대 숙련도를 225(으)로 올립니다. 150-225 재료는 모두 약 135골드입니다.",

	-- Step 19: Pattern: Azure Silk Cloak
	-- {item:7053} Azure Silk Cloak · {skill:197} Tailoring
	["Teaches {item:7053} (needs {skill:197} 140). Vendors sell it in limited stock that restocks."] = "{item:7053}을(를) 배웁니다({skill:197} 140 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",

	-- Step 21: Mageweave Cloth (Alliance)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Alliance)"] = "{item:4338} (얼라이언스)",
	-- {npc:6006} Shadowsworn Adept
	["{npc:6006} (level 52-53) drop it here. The Auction House works too."] = "이곳의 {npc:6006}(52-53레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 22: Mageweave Cloth (Horde)
	-- {item:4338} Mageweave Cloth
	["{item:4338} (Horde)"] = "{item:4338} (호드)",
	-- {npc:5472} Dunemaul Enforcer
	["{npc:5472} (level 46-47) drop it here. The Auction House works too."] = "이곳의 {npc:5472}(46-47레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 23: Azure Silk Cloak to 180
	-- {item:7053} Azure Silk Cloak
	["{item:7053} to 180"] = "{item:7053}: 180까지",
	["Orange (a point every craft) until 160, yellow until 175, green until 190."] = "160까지 주황색(만들 때마다 1점), 175까지 노란색, 190까지 초록색입니다.",
	["from the recipe in your bags"] = "가방에 있는 제조법으로",

	-- Step 24: Tailoring recipes at 180
	-- {skill:197} Tailoring
	["{skill:197} recipes at 180"] = "180에서 {skill:197} 제조법",
	-- {skill:197} Tailoring · {spell:8799} Crimson Silk Pantaloons
	["Back to a {skill:197} trainer: {spell:8799} is taught from {skill:197} 180."] = "{skill:197} 상급자에게 돌아가세요. {spell:8799}은(는) {skill:197} 180부터 배울 수 있습니다.",

	-- Step 25: Crimson Silk Pantaloons to 185
	-- {item:7062} Crimson Silk Pantaloons
	["{item:7062} to 185"] = "{item:7062}: 185까지",
	["Yellow until 190, green until 200: not every craft gives a point."] = "190까지 노란색, 200까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 26: Tailoring recipes at 185
	-- {skill:197} Tailoring
	["{skill:197} recipes at 185"] = "185에서 {skill:197} 제조법",
	-- {skill:197} Tailoring · {spell:12048} Black Mageweave Vest
	["Back to a {skill:197} trainer: {spell:12048} is taught from {skill:197} 185."] = "{skill:197} 상급자에게 돌아가세요. {spell:12048}은(는) {skill:197} 185부터 배울 수 있습니다.",

	-- Step 27: Black Mageweave Vest to 205
	-- {item:9998} Black Mageweave Vest
	["{item:9998} to 205"] = "{item:9998}: 205까지",
	["Yellow until 200, green until 215: not every craft gives a point."] = "200까지 노란색, 215까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 28: Tailoring recipes at 205
	-- {skill:197} Tailoring
	["{skill:197} recipes at 205"] = "205에서 {skill:197} 제조법",
	-- {skill:197} Tailoring · {spell:12072} Black Mageweave Headband
	["Back to a {skill:197} trainer: {spell:12072} is taught from {skill:197} 205."] = "{skill:197} 상급자에게 돌아가세요. {spell:12072}은(는) {skill:197} 205부터 배울 수 있습니다.",

	-- Step 29: Black Mageweave Headband to 225
	-- {item:10024} Black Mageweave Headband
	["{item:10024} to 225"] = "{item:10024}: 225까지",
	-- {skill:197} Tailoring
	["Yellow until 220, green until 235: not every craft gives a point. {skill:197} 225 is a Legacy System milestone."] = "220까지 노란색, 235까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. {skill:197} 225은(는) 유산 시스템 단계입니다.",

	-- Step 30: Artisan Tailoring
	-- {skill:197} Tailoring
	["Artisan {skill:197}"] = "전문 {skill:197}",
	-- {skill:197} Tailoring
	["Artisan needs character level 35 and {skill:197} 200; it raises the cap to 300. Materials for 225-300 are worth about 845g in all."] = "전문은(는) 캐릭터 레벨 35, {skill:197} 200이(가) 필요하며 최대 숙련도를 300(으)로 올립니다. 225-300 재료는 모두 약 845골드입니다.",

	-- Step 31: Pattern: Runecloth Gloves
	-- {item:13863} Runecloth Gloves · {skill:197} Tailoring
	["Teaches {item:13863} (needs {skill:197} 230). Vendors sell it in limited stock that restocks."] = "{item:13863}을(를) 배웁니다({skill:197} 230 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",

	-- Step 32: Pattern: Runecloth Cuffs
	-- {item:254123} Runecloth Cuffs · {skill:197} Tailoring
	["Teaches {item:254123} (needs {skill:197} 250)."] = "{item:254123}을(를) 배웁니다({skill:197} 250 필요).",

	-- Step 33: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (얼라이언스)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:1815}, {npc:1816}, {npc:1817}의 가죽을 벗기세요(48-60레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",

	-- Step 34: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (호드)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377}의 가죽을 벗기세요(48-60레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",

	-- Step 35: Runecloth (Alliance)
	-- {item:14047} Runecloth
	["{item:14047} (Alliance)"] = "{item:14047} (얼라이언스)",
	-- {npc:7027} Blackrock Slayer
	["{npc:7027} (level 56-57) drop it here. The Auction House works too."] = "이곳의 {npc:7027}(56-57레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 36: Runecloth (Horde)
	-- {item:14047} Runecloth
	["{item:14047} (Horde)"] = "{item:14047} (호드)",
	-- {npc:6189} Timbermaw Ursa
	["{npc:6189} (level 51-52) drop it here. The Auction House works too."] = "이곳의 {npc:6189}(51-52레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 37: Ironweb Spider Silk (Alliance)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Alliance)"] = "{item:14227} (얼라이언스)",
	-- {npc:1824} Plague Lurker
	["{npc:1824} (level 54-55) drop it here. The Auction House works too."] = "이곳의 {npc:1824}(54-55레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 38: Ironweb Spider Silk (Horde)
	-- {item:14227} Ironweb Spider Silk
	["{item:14227} (Horde)"] = "{item:14227} (호드)",
	-- {npc:11739} Rock Stalker
	["{npc:11739} (level 57-59) drop it here. The Auction House works too."] = "이곳의 {npc:11739}(57-59레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 39: Runecloth Belt to 236
	-- {item:13856} Runecloth Belt
	["{item:13856} to 236"] = "{item:13856}: 236까지",
	["Yellow until 240, green until 255: not every craft gives a point."] = "240까지 노란색, 255까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 40: Runecloth Gloves to 251
	-- {item:13863} Runecloth Gloves
	["{item:13863} to 251"] = "{item:13863}: 251까지",
	["Orange (a point every craft) until 245, yellow until 260, green until 275."] = "245까지 주황색(만들 때마다 1점), 260까지 노란색, 275까지 초록색입니다.",

	-- Step 41: Runecloth Cuffs to 295
	-- {item:254123} Runecloth Cuffs
	["{item:254123} to 295"] = "{item:254123}: 295까지",
	["Orange (a point every craft) until 265, yellow until 280, green until 295."] = "265까지 주황색(만들 때마다 1점), 280까지 노란색, 295까지 초록색입니다.",

	-- Step 42: Tailoring 295-300
	-- {skill:197} Tailoring · {item:14342} Mooncloth · {item:14137} Mooncloth Leggings · {item:279943} Spinning Wheel · {item:14155} Mooncloth Bag · {item:14128} Wizardweave Robe · {item:19047} Wisdom of the Timbermaw
	["On Forever no recipe a trainer teaches or both factions' vendors sell gives {skill:197} points past 295, so Polestar has no route for the last points. Recipes that still do: {item:14342} (needs a Moonwell), {item:14137} (needs a {item:279943}), {item:14155} (recipe is a drop), {item:14128} (recipe is a drop), {item:19047} (needs a {item:279943})."] = "Forever에서는 상급자가 가르치거나 양 진영 상인이 파는 제조법 중 295 이후 {skill:197} 점수를 주는 것이 없어, Polestar에는 마지막 점수를 위한 경로가 없습니다. 아직 점수를 주는 제조법: {item:14342}(달샘 필요), {item:14137}({item:279943} 필요), {item:14155}(제조법은 획득), {item:14128}(제조법은 획득), {item:19047}({item:279943} 필요).",
}
