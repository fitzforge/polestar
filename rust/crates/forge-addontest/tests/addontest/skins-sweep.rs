//! #1390: every Polestar frame follows Appearance > Windows > Skin, live. The whole addon is loaded, its frames
//! are built (the flight timer, the instance tracker, the party panel, the confirm dialog, the toasts, the
//! welcome and copy windows), and the skin is switched through every choice: each skinned frame is painted in
//! the skin in use, the floating ones on the window skin (Halo's veil, not a menu's fill), and the quest item and
//! travel buttons' hover wash follows the skin's.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const SCRIPT: &str = r#"
local T, W = Polestar.Theme, Polestar.Widgets
T._testShowHidden = true
-- Build what is built on demand.
Polestar.Set("party.panel", true)
W.Modal({ title = "Reset?", text = "Sure?", action = "Reset" })
Polestar.Nav.alerts.ShowSample()
Polestar.Rares.Toast.Show({ kind = "rare", name = "Mother Fang", map = 1429, x = 50, y = 50 })
Polestar.UI.ShowCopy("Copy", "text")
local named = {
	timer = PolestarFlightTimer, tracker = PolestarInstanceTracker, party = PolestarPartyPanel,
	modal = PolestarModal and PolestarModal.Box, transit = PolestarTransitAlert, rare = PolestarRareToast,
	copy = PolestarCopy,
}
local missing = {}
for k, f in pairs(named) do if not f then missing[#missing + 1] = k end end
table.sort(missing)
-- Every frame a skin painted.
local painted = {}
for _, f in ipairs(stub.frames) do if rawget(f, "psSkin") then painted[#painted + 1] = f end end
local function hover(b) local hl = b and rawget(b, "Hl"); return hl and { hl:GetVertexColor() } or false end
local out = { missing = table.concat(missing, ","), painted = #painted, skins = {} }
for _, key in ipairs(T.SKIN_ORDER) do
	Polestar.Set("ui.skin", key)
	local stale = 0
	for _, f in ipairs(painted) do if f.psSkin.skin ~= key then stale = stale + 1 end end
	local s = { stale = stale, frames = {} }
	for k, f in pairs(named) do
		local d = f.psSkin
		s.frames[k] = {
			skin = d and d.skin or false,
			veil = d and d.veil ~= nil and d.veil:IsShown() or false,
			shadow = f.psShadow ~= nil and f.psShadow:IsShown() or false,
		}
	end
	s.item = hover(PolestarQuestItemButton)
	s.travel = hover(PolestarTravelButton)
	s.wash = { T.Wash("hover") }
	out.skins[key] = s
end
emit(out)
"#;

fn run() -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: SCRIPT.into(),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn switching_the_skin_restyles_the_flight_timer_and_every_polestar_frame_live_1390() {
	let out = run();
	assert_eq!(out["missing"], "", "every swept frame was built");
	assert!(out["painted"].as_u64().unwrap() > 10, "the sweep saw the skinned frames: {}", out["painted"]);
	let skins = out["skins"].as_object().unwrap();
	assert_eq!(skins.len(), 6);
	for (key, s) in skins {
		assert_eq!(s["stale"], 0, "{key}: every skinned frame repainted in the skin in use");
		for (name, f) in s["frames"].as_object().unwrap() {
			assert_eq!(f["skin"], json!(key), "{key}: {name} painted in it");
			// The window skin: Halo's soft veil (a panel would take the menu fill), the house drop shadow.
			assert_eq!(f["veil"], json!(key == "halo"), "{key}: {name} on the window skin");
			if key == "polestar" {
				assert_eq!(f["shadow"], true, "{name}: the house window's shadow");
			}
		}
		for b in ["item", "travel"] {
			if s[b] != json!(false) {
				assert_eq!(s[b], s["wash"], "{key}: the {b} button's hover wash is the skin's");
			}
		}
	}
	assert_ne!(skins["polestar"]["wash"], skins["hearth"]["wash"], "the skins' hover washes differ");
	assert!(skins["polestar"]["item"] != json!(false), "the quest item button was built");
}
