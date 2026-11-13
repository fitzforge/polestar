//! The skip-ahead sweep (0.3.6): every leveling guide loaded by every race and class from the route before it, first
//! load and reload. Placement passed travel and training before the last quest progress (anchorStep) even when
//! that progress was a quest done before this guide (an earlier visit to the zone, an earlier guide that offers
//! it too) and the work the travel leads to was still to do. A soft step behind the progress now passes only
//! when the quest work it leads to is done or under way (place's leadsToDone). The sweep's three remaining
//! guides, each a state from it.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

// Guide `guide` placed for the world `before` sets up: opened (first load) or the saved tab come back
// (reload). -> the live step's title.
fn place(faction: &str, guide: &str, before: &str, reload: bool) -> Value {
	let dir = forge_addontest::run::addons_dir();
	let part = format!("Polestar_Guides_{faction}");
	let saved = if reload {
		vec![("Polestar".to_string(), format!(r#"PolestarCharDB = {{ schema = 1, tabs = {{ "{guide}" }}, activeTab = 1, flags = {{ started = {{ ["{guide}"] = true }} }} }}"#))]
	} else {
		vec![]
	};
	let open = if reload { String::new() } else { format!("E.SetGuide(\"{guide}\"); stub.advance(0.25)") };
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: before.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"]), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir(&part, dir.join(&part))],
		saved,
		script: format!(
			r#"
E = Polestar.Engine
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
{open}
stub.fire("QUEST_LOG_UPDATE"); stub.advance(11)
local g = E.GetGuide()
emit({{ live = g.steps[E.GetLiveStep()].title, step = E.GetLiveStep() }})"#
		),
		..Default::default()
	})
	.remove(0)
}

// The skip-ahead sweep (alliance/30-40/04b-stranglethorn-vale|Human|WARRIOR|route|35.58): coming from forever/alliance/30-40/02-desolace.
#[test]
fn skip_ahead_stranglethorn_keeps_its_first_travel_step() {
	let before = r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "Human", "Alliance", "WARRIOR", "WARRIOR", 35
w.setXP(575, 1000)
w.complete({ 5, 6, 7, 9, 11, 12, 13, 14, 15, 18, 20, 21, 22, 33, 34, 35, 36, 37, 38, 39, 40, 45, 47, 52, 54, 56, 57, 58, 60, 61, 62, 64, 65, 66, 71, 76, 83, 84, 85, 86, 87, 88, 89, 91, 92, 94, 95, 101, 102, 104, 106, 107, 109, 111, 112, 114, 118, 119, 120, 121, 122, 124, 125, 127, 128, 129, 130, 131, 132, 133, 134, 135, 141, 142, 148, 149, 151, 153, 154, 155, 156, 157, 158, 159, 160, 163, 164, 165, 173, 174, 175, 177, 180, 181, 185, 186, 187, 188, 189, 190, 191, 194, 195, 198, 199, 200, 201, 203, 204, 210, 215, 219, 221, 222, 223, 226, 230, 239, 244, 245, 246, 248, 250, 251, 252, 257, 258, 262, 265, 266, 268, 269, 270, 275, 276, 277, 279, 281, 284, 285, 286, 288, 289, 290, 292, 293, 294, 295, 296, 297, 298, 299, 301, 305, 306, 307, 321, 322, 323, 324, 385, 399, 401, 436, 453, 463, 464, 465, 469, 470, 472, 474, 505, 510, 511, 514, 536, 555, 559, 560, 561, 562, 563, 575, 578, 583, 605, 616, 631, 632, 633, 729, 731, 783, 944, 945, 947, 948, 949, 950, 951, 953, 954, 955, 956, 957, 958, 963, 965, 966, 967, 970, 973, 982, 983, 984, 985, 986, 991, 993, 994, 1001, 1002, 1003, 1007, 1008, 1009, 1010, 1011, 1016, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1033, 1034, 1035, 1045, 1046, 1054, 1055, 1070, 1071, 1072, 1075, 1078, 1085, 1090, 1092, 1093, 1097, 1104, 1105, 1110, 1132, 1135, 1138, 1140, 1175, 1176, 1179, 1241, 1242, 1243, 1244, 1245, 1246, 1247, 1248, 1249, 1250, 1253, 1264, 1274, 1284, 1301, 1302, 1319, 1320, 1387, 1437, 1438, 1439, 1440, 1447, 1453, 1458, 1459, 1465, 1638, 1639, 1640, 1665, 2098, 2118, 2138, 2139, 2158, 3100, 3524, 3741, 3903, 3904, 3905, 4581, 4681, 4722, 4723, 4725, 4727, 4728, 4730, 4731, 4732, 4733, 4740, 4761, 4762, 4763, 4811, 4812, 4813, 5261, 5321, 5545, 5561, 5762, 6181, 6261, 6281, 6285, 86585, 86613, 86614, 86758, 87491, 87760, 91723, 91724, 91725, 91732, 91733, 91738, 92742, 92744, 92745, 92747, 92748, 92909, 95065, 95998, 96139, 96626, 96627, 97284, 97894, 97914, 98013, 98025, 98027, 98042, 98189, 98190, 98191, 98197, 98219, 98221, 98223, 98230, 98282, 98386, 98387, 98407, 99127, 99128, 99129, 99130, 99131, 99143 })
w.onQuest(213, { { required = 8, fulfilled = 0 } })
w.onQuest(328, {  })
w.onQuest(512, { { required = 7, fulfilled = 0 } })
w.onQuest(525, {  })
w.onQuest(564, { { required = 8, fulfilled = 0 }, { required = 10, fulfilled = 0 } })
w.onQuest(577, { { required = 5, fulfilled = 0 } })
w.onQuest(601, { { required = 6, fulfilled = 0 } })
w.onQuest(634, {  })
w.onQuest(659, {  })
w.onQuest(690, {  })
w.onQuest(1037, {  })
w.onQuest(1106, {  })
w.onQuest(1718, {  })
w.onQuest(5741, { { required = 1, fulfilled = 1 } })
w.onQuest(92432, {  })"#;
	for reload in [false, true] {
		let out = place("Alliance", "forever/alliance/30-40/04b-stranglethorn-vale", before, reload);
		assert_eq!(out["live"], "Fly to Darkshire", "reload {reload}: {out}");
	}
}

// The skip-ahead sweep (alliance/03-darkshore|NightElf|WARRIOR|route|16.92): coming from forever/alliance/02-westfall.
#[test]
fn skip_ahead_darkshore_keeps_its_first_travel_step() {
	let before = r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "NightElf", "Alliance", "WARRIOR", "WARRIOR", 16
w.setXP(920, 1000)
w.complete({ 9, 12, 13, 22, 36, 38, 40, 64, 102, 151, 153, 399, 456, 457, 458, 459, 475, 476, 483, 486, 487, 488, 489, 490, 916, 917, 918, 919, 920, 921, 922, 923, 928, 929, 930, 931, 932, 933, 935, 937, 938, 940, 953, 954, 955, 956, 957, 958, 983, 984, 985, 997, 1683, 1684, 2118, 2159, 2399, 2438, 2459, 2518, 2519, 2520, 2541, 2561, 3116, 3519, 3521, 3522, 3524, 4161, 4495, 4681, 4722, 4723, 4728, 4811, 4812, 4813, 6341, 6342, 6343, 6344, 7383, 87288, 92742, 92744, 92745, 92909, 95065, 96606, 96630, 96634, 97220, 97222, 97977, 97979, 98025, 98046, 98065, 98067, 98391, 98392, 98398, 99046, 99047, 99050, 99053, 99073 })
w.onQuest(35, {  })
w.onQuest(65, {  })
w.onQuest(952, {  })
w.onQuest(97894, {  })"#;
	for reload in [false, true] {
		let out = place("Alliance", "forever/alliance/03-darkshore", before, reload);
		assert_eq!(out["live"], "Boat to Auberdine", "reload {reload}: {out}");
	}
}

// The skip-ahead sweep (horde/40-50/03-feralas|Orc|WARRIOR|route|44.82): coming from forever/horde/40-50/02-feralas.
#[test]
fn skip_ahead_feralas_keeps_its_first_travel_step() {
	let before = r#"local w = stub.world
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "WARRIOR", "WARRIOR", 44
w.setXP(816, 1000)
w.complete({ 23, 25, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 201, 208, 209, 213, 216, 348, 349, 421, 422, 425, 428, 429, 430, 435, 437, 438, 439, 440, 441, 445, 449, 477, 478, 479, 481, 482, 493, 494, 496, 498, 499, 501, 502, 503, 506, 507, 508, 509, 513, 516, 527, 528, 529, 532, 533, 535, 539, 541, 544, 545, 546, 547, 549, 550, 552, 553, 556, 557, 566, 567, 568, 569, 570, 571, 572, 573, 575, 576, 577, 581, 582, 583, 584, 585, 586, 587, 588, 589, 595, 596, 597, 598, 599, 600, 604, 605, 606, 607, 609, 617, 621, 629, 638, 639, 642, 649, 651, 655, 662, 663, 664, 665, 666, 668, 669, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 701, 702, 703, 709, 710, 711, 784, 786, 788, 789, 790, 791, 792, 794, 804, 805, 806, 808, 815, 816, 817, 818, 819, 823, 824, 825, 826, 827, 828, 829, 834, 835, 837, 840, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 855, 857, 858, 863, 865, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 887, 888, 890, 891, 892, 893, 894, 895, 896, 898, 899, 900, 901, 902, 903, 905, 906, 907, 913, 1058, 1060, 1061, 1062, 1087, 1090, 1092, 1093, 1104, 1105, 1106, 1108, 1110, 1111, 1137, 1145, 1146, 1147, 1148, 1149, 1150, 1175, 1176, 1177, 1178, 1184, 1190, 1191, 1194, 1201, 1202, 1206, 1218, 1238, 1239, 1240, 1251, 1268, 1269, 1270, 1273, 1321, 1322, 1323, 1358, 1359, 1365, 1366, 1372, 1389, 1392, 1393, 1419, 1420, 1431, 1432, 1433, 1434, 1435, 1436, 1483, 1492, 1498, 1502, 1503, 1505, 1690, 1691, 1707, 1718, 1719, 1823, 1824, 1825, 1878, 1918, 2161, 2258, 2383, 2781, 2822, 2862, 2863, 2864, 2872, 2873, 2875, 2902, 2903, 2973, 2974, 2975, 2978, 2979, 2980, 2981, 2987, 3002, 3121, 3221, 3261, 3281, 3921, 3922, 3923, 4402, 4542, 4641, 4767, 4770, 4821, 4841, 4865, 4904, 4921, 5041, 5052, 5064, 5147, 5151, 5361, 5381, 5441, 5561, 5581, 5741, 5762, 5763, 5881, 6027, 6132, 6134, 6142, 6143, 6282, 6301, 6365, 6381, 6382, 6383, 6393, 6394, 6441, 6442, 6461, 6462, 6482, 6503, 6541, 6544, 6548, 6562, 6563, 6621, 6629, 6641, 7730, 7731, 7732, 8365, 8366, 86576, 91920, 91921, 92706, 93225, 93680, 95494, 95495, 95507, 95508, 95621, 95748, 95774, 95883, 95884, 95981, 96241, 96259, 96260, 96261, 96604, 96652, 96655, 96821, 96822, 96825, 96895, 96897, 96898, 97223, 97225, 97242, 97246, 97249, 97250, 97253, 97275, 97279, 97326, 97539, 97891, 98070, 98093, 98094, 98095, 98251, 98252, 99048, 99049, 99051, 99052, 99123 })
w.onQuest(2, {  })
w.onQuest(24, {  })
w.onQuest(650, {  })
w.onQuest(698, { { required = 8, fulfilled = 8 } })
w.onQuest(728, {  })
w.onQuest(830, {  })
w.onQuest(832, {  })
w.onQuest(992, { { required = 1, fulfilled = 0 } })
w.onQuest(1424, { { required = 10, fulfilled = 0 } })
w.onQuest(1430, { { required = 10, fulfilled = 0 } })
w.onQuest(2874, {  })
w.onQuest(2932, { { required = 1, fulfilled = 0 } })
w.onQuest(2976, {  })
w.onQuest(3122, {  })
w.onQuest(3520, { { required = 3, fulfilled = 0 } })
w.onQuest(4881, {  })
w.onQuest(7734, { { required = 10, fulfilled = 0 } })"#;
	for reload in [false, true] {
		let out = place("Horde", "forever/horde/40-50/03-feralas", before, reload);
		assert_eq!(out["live"], "Zeppelin to Undercity", "reload {reload}: {out}");
	}
}

// The 0.3.6 upgrade harness (Barrens 2u1uxgal3p): a group quest still waiting for the player's answer
// (`when group`, Grunt Logmar's Wrongly Blamed) is no work the travel before it leads to: the sethome before it,
// behind the player's progress, passes (before: live at "Camp").
const GROUP_GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/grp", pack = "test", title = "Group", faction = "Horde", minLevel = 1, maxLevel = 30, steps = {
	{ title = "Camp", goals = { { t = "sethome", location = "Camp Taurajo", npc = 7714, map = 1413, x = 46, y = 58 } } },
	{ title = "Logmar", when = { { k = "group", q = 97250 } }, goals = { { t = "accept", quest = 97250, title = "Wrongly Blamed", map = 1413, x = 46, y = 58 } } },
	{ title = "Gann", goals = { { t = "accept", quest = 843, title = "Gann's Reclamation", map = 1413, x = 46, y = 58 } } },
	{ title = "Bael Modan", goals = { { t = "kill", target = "Bael'dun Excavator", count = 12, quest = 843, oi = 1, map = 1413, x = 47, y = 85 } } },
	{ title = "Back", goals = { { t = "turnin", quest = 843, title = "Gann's Reclamation", map = 1413, x = 46, y = 58 } } },
} })"#;

#[test]
fn a_group_quest_waiting_for_its_answer_holds_no_travel_before_it() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: "local w = stub.world\nw.race, w.faction, w.level = \"Scourge\", \"Horde\", 27\nw.addMap(1413, { name = \"The Barrens\", c = 1, left = 1000, right = -3000, top = 1000, bottom = -4000 })\nw.moveTo(1413, 46, 58)\nw.onQuest(843, { { required = 12, fulfilled = 12 } })".to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			"{}\n{}\n{GROUP_GUIDE}\nE = Polestar.Engine\nstub.login(); stub.advance(0.25)\nE.SetGuide(\"test/grp\"); stub.advance(0.25)\nstub.fire(\"QUEST_LOG_UPDATE\"); stub.advance(11)\nemit({{ live = E.GetGuide().steps[E.GetLiveStep()].title }})",
			forge_addontest::TEST_PACK,
			forge_addontest::TEST_SOURCE
		),
		..Default::default()
	})
	.remove(0);
	// The sethome passes; the group quest's step asks its question (as everywhere), then Back.
	assert_eq!(out["live"], "Logmar", "{out}");
}

// The skip-ahead sweep on the 0.3.6 candidate (horde/40-50/01-stranglethorn-vale, every race and class from the route,
// 84/84 states): placement passed "Fly to Grom'gol" because the next quest work after it, the hand-in of 1240 at
// Grom'gol, was "under way": the quest is in the log. A hand-in still to do is no sign the player went there, so the
// travel to it holds (leadsToDone; the judge's leads_to_done the same). Here: 300 taken and handed in before (the
// progress), 301 carried and ready, its hand-in after the flight.
const CARRIED: &str = r#"
Polestar.RegisterGuide({ id = "test/carried", pack = "test", title = "Carried", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Take 300", goals = { { t = "accept", quest = 300, title = "Quest 300", map = 1429, x = 40, y = 40 } } },
	{ title = "Fly to the camp", goals = { { t = "goto", map = 1429, x = 45, y = 45, text = "flight master" }, { t = "fly", location = "Camp" } } },
	{ title = "Camp", goals = { { t = "turnin", quest = 301, title = "Quest 301", map = 1429, x = 70, y = 70 } } },
	{ title = "Hand in 300", goals = { { t = "turnin", quest = 300, title = "Quest 300", map = 1429, x = 72, y = 70 } } },
	{ title = "On", goals = { { t = "accept", quest = 302, title = "Quest 302", map = 1429, x = 75, y = 70 } } },
} })
"#;

#[test]
fn a_flight_to_the_hand_in_of_a_carried_quest_is_no_step_behind_the_player() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 40, 40)
w.complete({ 300 })
w.onQuest(301, { { required = 1, fulfilled = 1 } })"#
			.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			"{}\n{}\n{CARRIED}\nE = Polestar.Engine\nstub.login(); stub.advance(0.25)\nE.SetGuide(\"test/carried\"); stub.advance(0.25)\nstub.fire(\"QUEST_LOG_UPDATE\"); stub.advance(11)\nemit({{ live = E.GetLiveStep() }})",
			forge_addontest::TEST_PACK,
			forge_addontest::TEST_SOURCE
		),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["live"], 2, "the flight to 301's hand-in holds: {out}");
}
