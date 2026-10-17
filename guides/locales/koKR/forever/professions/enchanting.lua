-- Korean (koKR): the guide forever/professions/enchanting (forever/professions/enchanting.guide).
-- Written by `node tools/polestar.js i18n guides sync koKR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Korean (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Korean words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Apprentice Enchanting
	-- {skill:333} Enchanting
	["Apprentice {skill:333}"] = "초급 {skill:333}",
	-- {skill:333} Enchanting
	["{skill:333} runs alongside leveling. Forever's Legacy System rewards crafting professions at skill 150, 225 and 300 (the Journeyman, Expert and Artisan caps), so each of those checkpoints counts. Materials for 1-75 are worth about 4g 3s in all."] = "{skill:333}은(는) 레벨업과 함께 진행합니다. Forever의 유산 시스템은 제작 전문 기술 숙련도 150, 225, 300(수습, 숙련, 전문 최대치)에 보상을 주므로, 각 단계가 중요합니다. 1-75 재료는 모두 약 4골드 3실버입니다.",

	-- Step 2: Enchant Bracer - Inferior Stamina to 25
	-- {spell:7418} Enchant Bracer - Inferior Stamina
	["{spell:7418} to 25"] = "{spell:7418}: 25까지",
	["Orange (a point every craft) until 20, yellow until 22, green until 25. Enchant your own gear: any item for that slot will do."] = "20까지 주황색(만들 때마다 1점), 22까지 노란색, 25까지 초록색입니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",
	["a tool: keep it in your bags"] = "도구: 가방에 넣어 두세요",

	-- Step 3: Enchant Bracer - Minor Deflect to 75
	-- {spell:7428} Enchant Bracer - Minor Deflect
	["{spell:7428} to 75"] = "{spell:7428}: 75까지",
	["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do. 75 is the Apprentice cap."] = "80까지 주황색(만들 때마다 1점), 100까지 노란색, 120까지 초록색입니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다. 75은(는) 초급 최대치입니다.",

	-- Step 4: Journeyman Enchanting
	-- {skill:333} Enchanting
	["Journeyman {skill:333}"] = "수습 {skill:333}",
	-- {skill:333} Enchanting
	["Journeyman needs character level 10 and {skill:333} 50; it raises the cap to 150. Materials for 75-150 are worth about 7g 51s in all."] = "수습은(는) 캐릭터 레벨 10, {skill:333} 50이(가) 필요하며 최대 숙련도를 150(으)로 올립니다. 75-150 재료는 모두 약 7골드 51실버입니다.",

	-- Step 5: Formula: Enchant Cloak - Minor Agility
	-- {spell:13419} Enchant Cloak - Minor Agility · {skill:333} Enchanting
	["Teaches {spell:13419} (needs {skill:333} 110). Vendors sell it in limited stock that restocks."] = "{spell:13419}을(를) 배웁니다({skill:333} 110 필요). 상인이 한정 수량으로 팔며 재입고됩니다.",

	-- Step 6: Shadowgem (Alliance)
	-- {item:1210} Shadowgem
	["{item:1210} (Alliance)"] = "{item:1210} (얼라이언스)",
	-- {item:1210} Shadowgem · {object:1731} Copper Vein · {skill:186} Mining
	["{item:1210} comes from {object:1731} nodes ({skill:186}); this is the densest cluster in the data. The Auction House works too."] = "{item:1210}은(는) {object:1731} 채집지에서 나옵니다({skill:186}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",

	-- Step 7: Shadowgem (Horde)
	-- {item:1210} Shadowgem
	["{item:1210} (Horde)"] = "{item:1210} (호드)",

	-- Step 8: Enchanting materials for 75-150
	-- {skill:333} Enchanting
	["{skill:333} materials for 75-150"] = "{skill:333} 재료(75-150)",
	["Skinned, disenchanted or crafted by another profession: gather them yourself or buy them on the Auction House."] = "무두질, 마력 추출 또는 다른 전문 기술로 얻는 재료입니다. 직접 모으거나 경매장에서 사세요.",
	-- {skill:164} Blacksmithing · {item:6338} Silver Rod
	["{skill:164}: {item:6338} (or the Auction House)"] = "{skill:164}: {item:6338} (또는 경매장)",
	-- {skill:333} Enchanting
	["{skill:333}: disenchant uncommon (green) gear (or the Auction House)"] = "{skill:333}: 고급(녹색) 장비 마력 추출 (또는 경매장)",

	-- Step 9: Enchant Bracer - Minor Deflect to 90
	-- {spell:7428} Enchant Bracer - Minor Deflect
	["{spell:7428} to 90"] = "{spell:7428}: 90까지",
	["Orange (a point every craft) until 80, yellow until 100, green until 120. Enchant your own gear: any item for that slot will do."] = "80까지 주황색(만들 때마다 1점), 100까지 노란색, 120까지 초록색입니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",

	-- Step 10: Enchanting recipes at 90
	-- {skill:333} Enchanting
	["{skill:333} recipes at 90"] = "90에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:7426} Enchant Chest - Minor Absorption
	["Back to an {skill:333} trainer: {spell:7426} is taught from {skill:333} 90."] = "{skill:333} 상급자에게 돌아가세요. {spell:7426}은(는) {skill:333} 90부터 배울 수 있습니다.",

	-- Step 11: Enchant Chest - Minor Absorption to 120
	-- {spell:7426} Enchant Chest - Minor Absorption
	["{spell:7426} to 120"] = "{spell:7426}: 120까지",
	["Yellow until 110, green until 130: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "110까지 노란색, 130까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",

	-- Step 12: Enchanting recipes at 120
	-- {skill:333} Enchanting
	["{skill:333} recipes at 120"] = "120에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:7788} Enchant Weapon - Minor Striking
	["Back to an {skill:333} trainer: {spell:7788} is taught from {skill:333} 120."] = "{skill:333} 상급자에게 돌아가세요. {spell:7788}은(는) {skill:333} 120부터 배울 수 있습니다.",

	-- Step 13: Enchant Weapon - Minor Striking to 130
	-- {spell:7788} Enchant Weapon - Minor Striking
	["{spell:7788} to 130"] = "{spell:7788}: 130까지",
	["Yellow until 140, green until 160: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "140까지 노란색, 160까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",

	-- Step 14: Enchanting recipes at 130
	-- {skill:333} Enchanting
	["{skill:333} recipes at 130"] = "130에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:7795} Runed Silver Rod
	["Back to an {skill:333} trainer: {spell:7795} is taught from {skill:333} 130."] = "{skill:333} 상급자에게 돌아가세요. {spell:7795}은(는) {skill:333} 130부터 배울 수 있습니다.",

	-- Step 15: Enchant Cloak - Minor Agility to 150
	-- {spell:13419} Enchant Cloak - Minor Agility
	["{spell:13419} to 150"] = "{spell:13419}: 150까지",
	-- {skill:333} Enchanting
	["Orange (a point every craft) until 135, yellow until 155, green until 175. Enchant your own gear: any item for that slot will do. {skill:333} 150 is a Legacy System milestone."] = "135까지 주황색(만들 때마다 1점), 155까지 노란색, 175까지 초록색입니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다. {skill:333} 150은(는) 유산 시스템 단계입니다.",
	["from the recipe in your bags"] = "가방에 있는 제조법으로",

	-- Step 16: Expert Enchanting
	-- {skill:333} Enchanting
	["Expert {skill:333}"] = "숙련 {skill:333}",
	-- {skill:333} Enchanting
	["Expert needs character level 20 and {skill:333} 125; it raises the cap to 225. Materials for 150-225 are worth about 13s in all."] = "숙련은(는) 캐릭터 레벨 20, {skill:333} 125이(가) 필요하며 최대 숙련도를 225(으)로 올립니다. 150-225 재료는 모두 약 13실버입니다.",

	-- Step 17: Iridescent Pearl (Alliance)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Alliance)"] = "{item:5500} (얼라이언스)",
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Open Giant Clams here. The Auction House works too."] = "이곳에서 {object:2744}을(를) 여세요. 경매장도 됩니다.",

	-- Step 18: Iridescent Pearl (Horde)
	-- {item:5500} Iridescent Pearl
	["{item:5500} (Horde)"] = "{item:5500} (호드)",

	-- Step 19: Enchanting materials for 150-225
	-- {skill:333} Enchanting
	["{skill:333} materials for 150-225"] = "{skill:333} 재료(150-225)",
	-- {skill:171} Alchemy · {item:6371} Fire Oil
	["{skill:171}: {item:6371} (or the Auction House)"] = "{skill:171}: {item:6371} (또는 경매장)",
	-- {skill:164} Blacksmithing · {item:11128} Golden Rod
	["{skill:164}: {item:11128} (or the Auction House)"] = "{skill:164}: {item:11128} (또는 경매장)",

	-- Step 20: Enchant Cloak - Lesser Fire Resistance to 155
	-- {spell:7861} Enchant Cloak - Lesser Fire Resistance
	["{spell:7861} to 155"] = "{spell:7861}: 155까지",
	["Yellow until 170, green until 190: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "170까지 노란색, 190까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",

	-- Step 21: Enchanting recipes at 155
	-- {skill:333} Enchanting
	["{skill:333} recipes at 155"] = "155에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:13501} Enchant Bracer - Lesser Stamina
	["Back to an {skill:333} trainer: {spell:13501} is taught from {skill:333} 155."] = "{skill:333} 상급자에게 돌아가세요. {spell:13501}은(는) {skill:333} 155부터 배울 수 있습니다.",

	-- Step 22: Enchant Bracer - Lesser Stamina to 180
	-- {spell:13501} Enchant Bracer - Lesser Stamina
	["{spell:13501} to 180"] = "{spell:13501}: 180까지",
	["Yellow until 175, green until 195: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "175까지 노란색, 195까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",

	-- Step 23: Enchanting recipes at 180
	-- {skill:333} Enchanting
	["{skill:333} recipes at 180"] = "180에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:13628} Runed Golden Rod · {spell:13637} Enchant Boots - Lesser Agility
	["Back to an {skill:333} trainer: {spell:13628}, {spell:13637} are taught from {skill:333} 180."] = "{skill:333} 상급자에게 돌아가세요. {spell:13628}, {spell:13637}은(는) {skill:333} 180부터 배울 수 있습니다.",

	-- Step 24: Enchant Boots - Lesser Agility to 200
	-- {spell:13637} Enchant Boots - Lesser Agility
	["{spell:13637} to 200"] = "{spell:13637}: 200까지",
	["Yellow until 200, green until 220: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "200까지 노란색, 220까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",

	-- Step 25: Enchanting recipes at 200
	-- {skill:333} Enchanting
	["{skill:333} recipes at 200"] = "200에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:13661} Enchant Bracer - Strength
	["Back to an {skill:333} trainer: {spell:13661} is taught from {skill:333} 200."] = "{skill:333} 상급자에게 돌아가세요. {spell:13661}은(는) {skill:333} 200부터 배울 수 있습니다.",

	-- Step 26: Enchant Bracer - Strength to 225
	-- {spell:13661} Enchant Bracer - Strength
	["{spell:13661} to 225"] = "{spell:13661}: 225까지",
	-- {skill:333} Enchanting
	["Yellow until 220, green until 240: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 225 is a Legacy System milestone."] = "220까지 노란색, 240까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다. {skill:333} 225은(는) 유산 시스템 단계입니다.",

	-- Step 27: Artisan Enchanting
	-- {skill:333} Enchanting
	["Artisan {skill:333}"] = "전문 {skill:333}",
	-- {skill:333} Enchanting
	["Artisan needs character level 35 and {skill:333} 200; it raises the cap to 300. Materials for 225-300 are worth about 30s in all."] = "전문은(는) 캐릭터 레벨 35, {skill:333} 200이(가) 필요하며 최대 숙련도를 300(으)로 올립니다. 225-300 재료는 모두 약 30실버입니다.",
	-- {npc:11073} Annora · {skill:333} Enchanting · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:11073} teaches Artisan {skill:333} inside the {area:1517} dungeon ({zone:1418}); bring a group"] = "{npc:11073}은(는) {area:1517} 던전({zone:1418}) 안에서 전문 {skill:333}을(를) 가르칩니다. 파티를 꾸려 가세요",

	-- Step 28: Black Pearl (Alliance)
	-- {item:7971} Black Pearl
	["{item:7971} (Alliance)"] = "{item:7971} (얼라이언스)",
	-- {npc:922} Silt Crawler
	["{npc:922} (level 40-41) drop it here. The Auction House works too."] = "이곳의 {npc:922}(40-41레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 29: Black Pearl (Horde)
	-- {item:7971} Black Pearl
	["{item:7971} (Horde)"] = "{item:7971} (호드)",
	-- {npc:5431} Surf Glider
	["{npc:5431} (level 48-50) drop it here. The Auction House works too."] = "이곳의 {npc:5431}(48-50레벨)이(가) 떨어뜨립니다. 경매장도 됩니다.",

	-- Step 30: Wildvine (Alliance)
	-- {item:8153} Wildvine
	["{item:8153} (Alliance)"] = "{item:8153} (얼라이언스)",
	-- {item:8153} Wildvine · {item:8831} Purple Lotus · {skill:182} Herbalism
	["{item:8153} comes from {item:8831} nodes ({skill:182}); this is the densest patch in the data. The Auction House works too."] = "{item:8153}은(는) {item:8831} 채집지에서 나옵니다({skill:182}). 데이터상 가장 밀집된 곳입니다. 경매장도 됩니다.",

	-- Step 31: Wildvine (Horde)
	-- {item:8153} Wildvine
	["{item:8153} (Horde)"] = "{item:8153} (호드)",

	-- Step 32: Enchanting materials for 225-300
	-- {skill:333} Enchanting
	["{skill:333} materials for 225-300"] = "{skill:333} 재료(225-300)",
	-- {skill:164} Blacksmithing · {item:11144} Truesilver Rod
	["{skill:164}: {item:11144} (or the Auction House)"] = "{skill:164}: {item:11144} (또는 경매장)",

	-- Step 33: Enchant Cloak - Greater Defense to 255
	-- {spell:13746} Enchant Cloak - Greater Defense
	["{spell:13746} to 255"] = "{spell:13746}: 255까지",
	["Yellow until 245, green until 265: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "245까지 노란색, 265까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",

	-- Step 34: Enchanting recipes at 255
	-- {skill:333} Enchanting
	["{skill:333} recipes at 255"] = "255에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:13935} Enchant Boots - Agility
	["Back to an {skill:333} trainer: {spell:13935} is taught from {skill:333} 255."] = "{skill:333} 상급자에게 돌아가세요. {spell:13935}은(는) {skill:333} 255부터 배울 수 있습니다.",

	-- Step 35: Enchant Boots - Agility to 292
	-- {spell:13935} Enchant Boots - Agility
	["{spell:13935} to 292"] = "{spell:13935}: 292까지",
	["Yellow until 275, green until 295: not every craft gives a point. Enchant your own gear: any item for that slot will do."] = "275까지 노란색, 295까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다.",

	-- Step 36: Enchanting recipes at 292
	-- {skill:333} Enchanting
	["{skill:333} recipes at 292"] = "292에서 {skill:333} 제조법",
	-- {skill:333} Enchanting · {spell:13948} Enchant Gloves - Minor Haste
	["Back to an {skill:333} trainer: {spell:13948} is taught from {skill:333} 270."] = "{skill:333} 상급자에게 돌아가세요. {spell:13948}은(는) {skill:333} 270부터 배울 수 있습니다.",

	-- Step 37: Enchant Gloves - Minor Haste to 300
	-- {spell:13948} Enchant Gloves - Minor Haste
	["{spell:13948} to 300"] = "{spell:13948}: 300까지",
	-- {skill:333} Enchanting
	["Yellow until 290, green until 310: not every craft gives a point. Enchant your own gear: any item for that slot will do. {skill:333} 300 is a Legacy System milestone."] = "290까지 노란색, 310까지 초록색입니다. 만들 때마다 점수가 오르지는 않습니다. 자신의 장비에 마법부여하세요. 그 부위의 아이템이면 무엇이든 됩니다. {skill:333} 300은(는) 유산 시스템 단계입니다.",
}
