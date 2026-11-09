# Simplified Chinese name evidence

The companion [zhCN-client-names.json](zhCN-client-names.json) contains 1,607 same-ID client records for the maintainer's name-source review: 1,600 IDs absent from the current generated zhCN pack and seven corrections. Of the additions, 206 are referenced by the current guide/target snapshot; all seven corrections are also referenced. The other records are supplied as client evidence, not a request to expand the generated pack beyond the IDs it needs.

The source split is 1,130 ItemSparse rows, 455 WDB records and 22 names learned by the addon from the Chinese client. Each row keeps its typed ID, Chinese field, source hash and the available record offset or export row. The seven corrections retain the current generated value for comparison. The original saved extraction artifacts and bilingual ItemSparse exports were checked by SHA256 before preparing this list.

The target client is 1.60.1.70862. Learned-name snapshots do not carry a per-name Build, so those rows keep build=null. The raw ItemSparse query outputs do not embed their Build; their binding to the target Build and language comes from the saved query metadata, and this is stated on each row. Public website names, translations from installed addon databases and identity-linked descriptions are separate review material; they are not labelled here as native client fields. Placeholder, retired/test and descriptive-label entries were excluded.

This is review evidence, not an override consumed by the build or the addon. Per [TRANSLATING.md](../TRANSLATING.md#game-names), accepted names should be incorporated at their source and Names.lua regenerated through the existing pipeline. No account identifiers, account paths or SavedVariables files are included.

## Three existing text-token collisions

The following source texts currently resolve a shared English word to the wrong entity. Their three zhCN values are left unchanged in the translation patch. The local in-game acceptance build used the verified human-readable Chinese wording for these texts.

- guides/forever/alliance/skyborne/01-zephras-isle.guide, lines 191 and 458 at e978e136279cf075eff34718f3ad5fd3dacba623: the train-class notes name Briarthorn, the Ironforge warlock trainer (npc:5172, 布瑞尔索恩), but the text tokenizer selects the herb item:2450 (石南草). This is a generated guide; its train-note wording needs a durable generator-source fix. A category wording such as "A warlock trainer in Ironforge" avoids the collision while retaining the training destination. The corresponding current Chinese keys start with {item:2450} and differ in area:16624 versus area:16638.
- guides/forever/class/mage/arcane-refreshment.guide, line 45 at the same commit: "Riptide hits everyone within 10 yards" names the boss's attack, but the text tokenizer selects area:1758 (断潮之池). The guide is hand-written. A minimal source-wording option is "His area-of-effect attack hits everyone within 10 yards", preserving the ten-yard warning and the rest of the tip. Migrate the corresponding locale key when changing it; frFR has an existing translation to retain (replace its area token with "Son attaque de zone").

The existing unnamed-token exception applies only to objects with no local name. It does not apply to either collision above. The correction proposals avoid adding a special-case exception or changing routes, coordinates, goals or trainer selection.
