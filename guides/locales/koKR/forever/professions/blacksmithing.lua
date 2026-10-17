-- Korean (koKR): the guide forever/professions/blacksmithing (forever/professions/blacksmithing.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Blacksmithing
	-- {skill:164} Blacksmithing
	["Apprentice {skill:164}"] = "초급 {skill:164}",
	-- {skill:164} Blacksmithing
	["{skill:164} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 17s in all."] = "{skill:164}은(는) 레벨업과 함께 진행합니다. Forever의 유산 시스템은 제작 전문 기술 숙련도 150, 225, 300(수습, 숙련, 전문 최대치)에 보상을 주므로, 각 단계가 중요합니다. 1-75 재료는 모두 약 17실버입니다.",

	-- Step 2: Rough Stone (Alliance)
	-- {item:2835} Rough Stone
	["{item:2835} (Alliance)"] = "{item:2835} (얼라이언스)",
	-- {item:2835} Rough Stone · {object:1731} Copper Vein · {skill:186} Mining
	["{item:2835} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2835}은(는) {object:1731} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",

	-- Step 3: Rough Stone (Horde)
	-- {item:2835} Rough Stone
	["{item:2835} (Horde)"] = "{item:2835} (호드)",

	-- Step 4: Rough Sharpening Stone to 45
	-- {spell:2660} Rough Sharpening Stone
	["{spell:2660} to 45"] = "{spell:2660}: 45까지",
	["Orange (a point every craft) until 15, yellow until 35, green until 55."] = "15까지 주황색(만들 때마다 1점), 35까지 노란색, 55까지 초록색입니다.",

	-- Step 5: Blacksmithing recipes at 45
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 45"] = "45에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:3320} Rough Grinding Stone
	["Back to a {skill:164} trainer: {spell:3320} is taught from {skill:164} 45."] = "{skill:164} 상급자에게 돌아가세요. {spell:3320}은(는) {skill:164} 45부터 배울 수 있습니다.",

	-- Step 6: Rough Grinding Stone to 75
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 75"] = "{spell:3320}: 75까지",
	["Yellow until 65, green until 85: not every craft gives a point. 75 is the Apprentice cap."] = "65까지 노란색, 85까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 75은(는) 초급 최대치입니다.",

	-- Step 7: Journeyman Blacksmithing
	-- {skill:164} Blacksmithing
	["Journeyman {skill:164}"] = "수습 {skill:164}",
	-- {skill:164} Blacksmithing
	["Journeyman needs character level 10 and {skill:164} 50; it raises the cap to 150. Materials for 75-150 are worth about 9g 41s in all."] = "수습은(는) 캐릭터 레벨 10, {skill:164} 50이(가) 필요하며 최대 숙련도를 150(으)로 올립니다. 75-150 재료는 모두 약 9골드 41실버입니다.",
	-- {item:5956} Blacksmith Hammer
	["{item:5956}: a tool, keep it in your bags"] = "{item:5956}: 도구이니 가방에 넣어 두세요",

	-- Step 10: Coarse Stone (Alliance)
	-- {item:2836} Coarse Stone
	["{item:2836} (Alliance)"] = "{item:2836} (얼라이언스)",
	-- {item:2836} Coarse Stone · {object:1732} Tin Vein · {skill:186} Mining
	["{item:2836} comes from {object:1732} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2836}은(는) {object:1732} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",

	-- Step 11: Coarse Stone (Horde)
	-- {item:2836} Coarse Stone
	["{item:2836} (Horde)"] = "{item:2836} (호드)",

	-- Step 12: Heavy Stone (Alliance)
	-- {item:2838} Heavy Stone
	["{item:2838} (Alliance)"] = "{item:2838} (얼라이언스)",
	-- {item:2838} Heavy Stone · {object:1735} Iron Deposit · {skill:186} Mining
	["{item:2838} comes from {object:1735} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:2838}은(는) {object:1735} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",

	-- Step 13: Heavy Stone (Horde)
	-- {item:2838} Heavy Stone
	["{item:2838} (Horde)"] = "{item:2838} (호드)",

	-- Step 14: Blacksmithing materials for 75-150
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 75-150"] = "{skill:164} 재료(75-150)",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "무두질, 마력 추출 또는 다른 전문 기술로 얻는 재료입니다. 직접 모으거나 경매장에서 사세요.",
	-- {skill:186} Mining · {item:2770} Copper Ore
	["{skill:186}: smelt {item:2770} (or the Auction House)"] = "{skill:186}: {item:2770} 제련 (또는 경매장)",
	-- {skill:186} Mining · {item:2840} Copper Bar
	["{skill:186}: smelt {item:2840} (or the Auction House)"] = "{skill:186}: {item:2840} 제련 (또는 경매장)",

	-- Step 15: Rough Grinding Stone to 83
	-- {spell:3320} Rough Grinding Stone
	["{spell:3320} to 83"] = "{spell:3320}: 83까지",
	["Yellow until 65, green until 85: not every craft gives a point."] = "65까지 노란색, 85까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 16: Blacksmithing recipes at 83
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 83"] = "83에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:2666} Runed Copper Belt
	["Back to a {skill:164} trainer: {spell:2666} is taught from {skill:164} 80."] = "{skill:164} 상급자에게 돌아가세요. {spell:2666}은(는) {skill:164} 80부터 배울 수 있습니다.",

	-- Step 17: Runed Copper Belt to 100
	-- {spell:2666} Runed Copper Belt
	["{spell:2666} to 100"] = "{spell:2666}: 100까지",
	["Orange (a point every craft) until 85, yellow until 105, green until 125. Needs an anvil nearby."] = "85까지 주황색(만들 때마다 1점), 105까지 노란색, 125까지 초록색입니다. 근처에 모루가 필요합니다.",

	-- Step 18: Blacksmithing recipes at 100
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 100"] = "100에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:3117} Heavy Weightstone
	["Back to a {skill:164} trainer: {spell:3117} is taught from {skill:164} 100."] = "{skill:164} 상급자에게 돌아가세요. {spell:3117}은(는) {skill:164} 100부터 배울 수 있습니다.",

	-- Step 19: Heavy Weightstone to 112
	-- {spell:3117} Heavy Weightstone
	["{spell:3117} to 112"] = "{spell:3117}: 112까지",
	["Yellow until 107, green until 115: not every craft gives a point."] = "107까지 노란색, 115까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 20: Blacksmithing recipes at 112
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 112"] = "112에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:2668} Rough Bronze Leggings
	["Back to a {skill:164} trainer: {spell:2668} is taught from {skill:164} 95."] = "{skill:164} 상급자에게 돌아가세요. {spell:2668}은(는) {skill:164} 95부터 배울 수 있습니다.",

	-- Step 21: Rough Bronze Leggings to 121
	-- {spell:2668} Rough Bronze Leggings
	["{spell:2668} to 121"] = "{spell:2668}: 121까지",
	["Orange (a point every craft) until 120, yellow until 135, green until 150. Needs an anvil nearby."] = "120까지 주황색(만들 때마다 1점), 135까지 노란색, 150까지 초록색입니다. 근처에 모루가 필요합니다.",

	-- Step 22: Blacksmithing recipes at 121
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 121"] = "121에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:2672} Patterned Bronze Bracers
	["Back to a {skill:164} trainer: {spell:2672} is taught from {skill:164} 120."] = "{skill:164} 상급자에게 돌아가세요. {spell:2672}은(는) {skill:164} 120부터 배울 수 있습니다.",

	-- Step 23: Patterned Bronze Bracers to 150
	-- {spell:2672} Patterned Bronze Bracers
	["{spell:2672} to 150"] = "{spell:2672}: 150까지",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 125, yellow until 140, green until 155. Needs an anvil nearby. {skill:164} 150 is a Legacy System milestone."] = "125까지 주황색(만들 때마다 1점), 140까지 노란색, 155까지 초록색입니다. 근처에 모루가 필요합니다. {skill:164} 150은(는) 유산 시스템 단계입니다.",

	-- Step 24: Expert Blacksmithing
	-- {skill:164} Blacksmithing
	["Expert {skill:164}"] = "숙련 {skill:164}",
	-- {skill:164} Blacksmithing
	["Expert needs character level 20 and {skill:164} 125; it raises the cap to 225. Materials for 150-225 are worth about 42g in all."] = "숙련은(는) 캐릭터 레벨 20, {skill:164} 125이(가) 필요하며 최대 숙련도를 225(으)로 올립니다. 150-225 재료는 모두 약 42골드입니다.",

	-- Step 25: Medium Leather (Alliance)
	-- {item:2319} Medium Leather
	["{item:2319} (Alliance)"] = "{item:2319} (얼라이언스)",
	-- {npc:2248} Cave Yeti · {npc:2356} Elder Gray Bear · {npc:2385} Feral Mountain Lion · {npc:2351} Gray Bear · {npc:2384} Starving Mountain Lion · {npc:2354} Vicious Gray Bear · {skill:393} Skinning
	["Skin {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, Snapjaw, {npc:2384}, {npc:2354} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:2248}, {npc:2356}, {npc:2385}, {npc:2351}, 무쇠턱거북, {npc:2384}, {npc:2354}의 가죽을 벗기세요(18-30레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",

	-- Step 26: Medium Leather (Horde)
	-- {item:2319} Medium Leather
	["{item:2319} (Horde)"] = "{item:2319} (호드)",
	-- {npc:3809} Ashenvale Bear · {npc:3810} Elder Ashenvale Bear · {npc:3818} Elder Shadowhorn Stag · {npc:3823} Ghostpaw Runner · {npc:3811} Giant Ashenvale Bear · {npc:3817} Shadowhorn Stag · {skill:393} Skinning
	["Skin {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817} here (beasts of level 18-30 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:3809}, {npc:3810}, {npc:3818}, {npc:3823}, {npc:3811}, {npc:3817}의 가죽을 벗기세요(18-30레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",

	-- Step 31: Solid Stone (Alliance)
	-- {item:7912} Solid Stone
	["{item:7912} (Alliance)"] = "{item:7912} (얼라이언스)",
	-- {item:7912} Solid Stone · {object:2040} Mithril Deposit · {skill:186} Mining
	["{item:7912} comes from {object:2040} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:7912}은(는) {object:2040} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",

	-- Step 32: Solid Stone (Horde)
	-- {item:7912} Solid Stone
	["{item:7912} (Horde)"] = "{item:7912} (호드)",

	-- Step 33: Blacksmithing materials for 150-225
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 150-225"] = "{skill:164} 재료(150-225)",
	-- {skill:186} Mining · {item:2775} Silver Ore
	["{skill:186}: smelt {item:2775} (or the Auction House)"] = "{skill:186}: {item:2775} 제련 (또는 경매장)",
	-- {skill:186} Mining · {item:3575} Iron Bar
	["{skill:186}: smelt {item:3575} (or the Auction House)"] = "{skill:186}: {item:3575} 제련 (또는 경매장)",

	-- Step 34: Silvered Bronze Gauntlets to 155
	-- {spell:3333} Silvered Bronze Gauntlets
	["{spell:3333} to 155"] = "{spell:3333}: 155까지",
	["Yellow until 155, green until 170: not every craft gives a point. Needs an anvil nearby."] = "155까지 노란색, 170까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",

	-- Step 35: Blacksmithing recipes at 155
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 155"] = "155에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:9985} Bronze Warhammer
	["Back to a {skill:164} trainer: {spell:9985} is taught from {skill:164} 155."] = "{skill:164} 상급자에게 돌아가세요. {spell:9985}은(는) {skill:164} 155부터 배울 수 있습니다.",

	-- Step 36: Bronze Warhammer to 175
	-- {item:7956} Bronze Warhammer
	["{item:7956} to 175"] = "{item:7956}: 175까지",
	["Yellow until 170, green until 185: not every craft gives a point. Needs an anvil nearby."] = "170까지 노란색, 185까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",

	-- Step 37: Blacksmithing recipes at 175
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 175"] = "175에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:9918} Solid Sharpening Stone
	["Back to a {skill:164} trainer: {spell:9918} is taught from {skill:164} 175."] = "{skill:164} 상급자에게 돌아가세요. {spell:9918}은(는) {skill:164} 175부터 배울 수 있습니다.",

	-- Step 38: Solid Sharpening Stone to 185
	-- {item:7964} Solid Sharpening Stone
	["{item:7964} to 185"] = "{item:7964}: 185까지",
	["Yellow until 180, green until 185: not every craft gives a point."] = "180까지 노란색, 185까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 39: Blacksmithing recipes at 185
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 185"] = "185에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:7223} Golden Scale Bracers
	["Back to a {skill:164} trainer: {spell:7223} is taught from {skill:164} 185."] = "{skill:164} 상급자에게 돌아가세요. {spell:7223}은(는) {skill:164} 185부터 배울 수 있습니다.",

	-- Step 40: Golden Scale Bracers to 200
	-- {item:6040} Golden Scale Bracers
	["{item:6040} to 200"] = "{item:6040}: 200까지",
	["Yellow until 197, green until 210: not every craft gives a point. Needs an anvil nearby."] = "197까지 노란색, 210까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",

	-- Step 41: Blacksmithing recipes at 200
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 200"] = "200에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:9916} Steel Breastplate
	["Back to a {skill:164} trainer: {spell:9916} is taught from {skill:164} 200."] = "{skill:164} 상급자에게 돌아가세요. {spell:9916}은(는) {skill:164} 200부터 배울 수 있습니다.",

	-- Step 42: Steel Breastplate to 210
	-- {item:7963} Steel Breastplate
	["{item:7963} to 210"] = "{item:7963}: 210까지",
	["Yellow until 212, green until 225: not every craft gives a point. Needs an anvil nearby."] = "212까지 노란색, 225까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",

	-- Step 43: Blacksmithing recipes at 210
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 210"] = "210에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:9920} Solid Grinding Stone · {spell:9935} Steel Plate Helm
	["Back to a {skill:164} trainer: {spell:9920}, {spell:9935} are taught from {skill:164} 210."] = "{skill:164} 상급자에게 돌아가세요. {spell:9920}, {spell:9935}은(는) {skill:164} 210부터 배울 수 있습니다.",

	-- Step 44: Steel Plate Helm to 225
	-- {item:7922} Steel Plate Helm
	["{item:7922} to 225"] = "{item:7922}: 225까지",
	-- {skill:164} Blacksmithing
	["Yellow until 220, green until 230: not every craft gives a point. Needs an anvil nearby. {skill:164} 225 is a Legacy System milestone."] = "220까지 노란색, 230까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다. {skill:164} 225은(는) 유산 시스템 단계입니다.",

	-- Step 45: Artisan Blacksmithing
	-- {skill:164} Blacksmithing
	["Artisan {skill:164}"] = "전문 {skill:164}",
	-- {skill:164} Blacksmithing
	["Artisan needs character level 35 and {skill:164} 200; it raises the cap to 300. Materials for 225-300 are worth about 942g in all."] = "전문은(는) 캐릭터 레벨 35, {skill:164} 200이(가) 필요하며 최대 숙련도를 300(으)로 올립니다. 225-300 재료는 모두 약 942골드입니다.",

	-- Step 46: Plans: Sentinel's Sabatons
	-- {item:250562} Sentinel's Sabatons · {skill:164} Blacksmithing
	["Teaches {item:250562} (needs {skill:164} 240)."] = "{item:250562}을(를) 배웁니다({skill:164} 240 필요).",

	-- Step 47: Plans: Huge Thorium Battleaxe
	-- {item:12775} Huge Thorium Battleaxe · {skill:164} Blacksmithing
	["Teaches {item:12775} (needs {skill:164} 255)."] = "{item:12775}을(를) 배웁니다({skill:164} 255 필요).",

	-- Step 48: Thick Leather (Alliance)
	-- {item:4304} Thick Leather
	["{item:4304} (Alliance)"] = "{item:4304} (얼라이언스)",
	-- {npc:2729} Elder Crag Coyote · {npc:2730} Rabid Crag Coyote · {npc:2732} Ridge Huntress · {npc:2734} Ridge Stalker Patriarch · {skill:393} Skinning
	["Skin {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:2729}, {npc:2730}, {npc:2732}, {npc:2734}의 가죽을 벗기세요(38-50레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",

	-- Step 49: Thick Leather (Horde)
	-- {item:4304} Thick Leather
	["{item:4304} (Horde)"] = "{item:4304} (호드)",
	-- {npc:5292} Feral Scar Yeti · {npc:5300} Frayfeather Hippogryph · {npc:5304} Frayfeather Stagwing · {npc:5272} Grizzled Ironfur Bear · {npc:5260} Groddoc Ape · {npc:5262} Groddoc Thunderer · {npc:5268} Ironfur Bear · {npc:5274} Ironfur Patriarch · {npc:5287} Longtooth Howler · {npc:5286} Longtooth Runner · {npc:5296} Rage Scar Yeti · {skill:393} Skinning
	["Skin {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296} here (beasts of level 38-50 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:5292}, {npc:5300}, {npc:5304}, {npc:5272}, {npc:5260}, {npc:5262}, {npc:5268}, {npc:5274}, {npc:5287}, {npc:5286}, {npc:5296}의 가죽을 벗기세요(38-50레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",

	-- Step 50: Mageweave Cloth
	["Kill the mobs that drop it at the farm spot Polestar picks for your level and faction. The Auction House works too."] = "Polestar가 레벨과 진영에 맞춰 고른 사냥터에서 이것을 떨어뜨리는 몹을 처치하세요. 경매장도 됩니다.",

	-- Step 53: Rugged Leather (Alliance)
	-- {item:8170} Rugged Leather
	["{item:8170} (Alliance)"] = "{item:8170} (얼라이언스)",
	-- {npc:1815} Diseased Black Bear · {npc:1816} Diseased Grizzly · {npc:1817} Diseased Wolf · {skill:393} Skinning
	["Skin {npc:1815}, {npc:1816}, {npc:1817} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:1815}, {npc:1816}, {npc:1817}의 가죽을 벗기세요(48-60레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",

	-- Step 54: Rugged Leather (Horde)
	-- {item:8170} Rugged Leather
	["{item:8170} (Horde)"] = "{item:8170} (호드)",
	-- {npc:6369} Coralshell Tortoise · {npc:8760} Mosshoof Stag · {npc:6380} Thunderhead Consort · {npc:6379} Thunderhead Patriarch · {npc:6378} Thunderhead Skystormer · {npc:6377} Thunderhead Stagwing · {skill:393} Skinning
	["Skin {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377} here (beasts of level 48-60 yield it); the {skill:393} guide routes this. The Auction House works too."] = "이곳에서 {npc:6369}, {npc:8760}, {npc:6380}, {npc:6379}, {npc:6378}, {npc:6377}의 가죽을 벗기세요(48-60레벨 야수에게서 나옵니다). {skill:393} 가이드가 경로를 안내합니다. 경매장도 됩니다.",

	-- Step 55: Purple Lotus (Alliance)
	-- {item:8831} Purple Lotus
	["{item:8831} (Alliance)"] = "{item:8831} (얼라이언스)",
	-- {item:8831} Purple Lotus · {skill:182} Herbalism
	["Pick {item:8831} with {skill:182}; this is the densest patch in the data. The Auction House works too."] = "{skill:182}(으)로 {item:8831}을(를) 채집하세요. 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",

	-- Step 56: Purple Lotus (Horde)
	-- {item:8831} Purple Lotus
	["{item:8831} (Horde)"] = "{item:8831} (호드)",

	-- Step 57: Dense Stone (Alliance)
	-- {item:12365} Dense Stone
	["{item:12365} (Alliance)"] = "{item:12365} (얼라이언스)",
	-- {item:12365} Dense Stone · {object:324} Small Thorium Vein · {skill:186} Mining
	["{item:12365} comes from {object:324} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:12365}은(는) {object:324} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",

	-- Step 58: Dense Stone (Horde)
	-- {item:12365} Dense Stone
	["{item:12365} (Horde)"] = "{item:12365} (호드)",

	-- Step 59: Blacksmithing materials for 225-300
	-- {skill:164} Blacksmithing
	["{skill:164} materials for 225-300"] = "{skill:164} 재료(225-300)",
	-- {skill:186} Mining · {item:3858} Mithril Ore
	["{skill:186}: smelt {item:3858} (or the Auction House)"] = "{skill:186}: {item:3858} 제련 (또는 경매장)",
	-- {skill:186} Mining · {item:10620} Thorium Ore
	["{skill:186}: smelt {item:10620} (or the Auction House)"] = "{skill:186}: {item:10620} 제련 (또는 경매장)",
	-- {skill:171} Alchemy · {item:249410} Sulfuric Acid
	["{skill:171}: {item:249410} (or the Auction House)"] = "{skill:171}: {item:249410} (또는 경매장)",
	-- {skill:393} Skinning
	["{skill:393} (or the Auction House)"] = "{skill:393} (또는 경매장)",
	-- {skill:202} Engineering · {item:249432} Sandpaper
	["{skill:202}: {item:249432} (or the Auction House)"] = "{skill:202}: {item:249432} (또는 경매장)",

	-- Step 60: Mithril Coif to 230
	-- {item:7931} Mithril Coif
	["{item:7931} to 230"] = "{item:7931}: 230까지",
	["Yellow until 235, green until 245: not every craft gives a point. Needs an anvil nearby."] = "235까지 노란색, 245까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",

	-- Step 61: Blacksmithing recipes at 230
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 230"] = "230에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:16640} Dense Weightstone
	["Back to a {skill:164} trainer: {spell:16640} is taught from {skill:164} 230."] = "{skill:164} 상급자에게 돌아가세요. {spell:16640}은(는) {skill:164} 230부터 배울 수 있습니다.",

	-- Step 62: Dense Weightstone to 235
	-- {item:12643} Dense Weightstone
	["{item:12643} to 235"] = "{item:12643}: 235까지",
	["Yellow until 232, green until 235: not every craft gives a point."] = "232까지 노란색, 235까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다.",

	-- Step 63: Blacksmithing recipes at 235
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 235"] = "235에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:9968} Heavy Mithril Boots
	["Back to a {skill:164} trainer: {spell:9968} is taught from {skill:164} 230."] = "{skill:164} 상급자에게 돌아가세요. {spell:9968}은(는) {skill:164} 230부터 배울 수 있습니다.",

	-- Step 64: Heavy Mithril Boots to 244
	-- {item:7933} Heavy Mithril Boots
	["{item:7933} to 244"] = "{item:7933}: 244까지",
	["Yellow until 240, green until 250: not every craft gives a point. Needs an anvil nearby."] = "240까지 노란색, 250까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 근처에 모루가 필요합니다.",

	-- Step 65: Sentinel's Sabatons to 268
	-- {item:250562} Sentinel's Sabatons
	["{item:250562} to 268"] = "{item:250562}: 268까지",
	["Orange (a point every craft) until 260, yellow until 270, green until 280. Needs an anvil nearby."] = "260까지 주황색(만들 때마다 1점), 270까지 노란색, 280까지 초록색입니다. 근처에 모루가 필요합니다.",
	["from the recipe in your bags"] = "가방에 있는 제조법으로",

	-- Step 66: Blacksmithing recipes at 268
	-- {skill:164} Blacksmithing
	["{skill:164} recipes at 268"] = "268에서 {skill:164} 제조법",
	-- {skill:164} Blacksmithing · {spell:16639} Dense Grinding Stone
	["Back to a {skill:164} trainer: {spell:16639} is taught from {skill:164} 230."] = "{skill:164} 상급자에게 돌아가세요. {spell:16639}은(는) {skill:164} 230부터 배울 수 있습니다.",

	-- Step 67: Huge Thorium Battleaxe to 300
	-- {item:12775} Huge Thorium Battleaxe
	["{item:12775} to 300"] = "{item:12775}: 300까지",
	-- {skill:164} Blacksmithing
	["Orange (a point every craft) until 280, yellow until 292, green until 305. Needs an anvil nearby. {skill:164} 300 is a Legacy System milestone."] = "280까지 주황색(만들 때마다 1점), 292까지 노란색, 305까지 초록색입니다. 근처에 모루가 필요합니다. {skill:164} 300은(는) 유산 시스템 단계입니다.",
}
