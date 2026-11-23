//! Scrolling the guide menu (addon/Polestar/UI/Picker.lua) with many community guides: a community addon with 200
//! guides, and enough community addons that their entries sit below the fold of the sidebar. The list's scroll
//! bar shows beside the list (not under the details), the wheel moves a couple of rows wherever it is over the
//! list and never redraws it, the range ends at the last row, and nothing a redraw does (a tab's progress, a
//! selection) moves the list, the sidebar or the details from where the player scrolled them.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const SETUP: &str = r##"
uistub.install()
Polestar.Guides = uistub.realGuides
local function guide(id, pack, extra)
	local g = { id = id, pack = pack, minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } }
	for k, v in pairs(extra) do g[k] = v end
	assert(Polestar.RegisterGuide(g))
end
assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "0.1.0", license = "GPL-3.0" }))
local pros = {}
for i = 1, 40 do pros[i] = "A reason to take this route, number " .. i end
guide("forever/westfall", "guides", { title = "Westfall", category = "Leveling", pitch = "Westfall from end to end.", pros = pros })
guide("forever/cooking", "guides", { title = "Cooking", category = "Professions", pros = pros })
for p = 1, 20 do
	local id = "pk" .. p
	assert(Polestar.RegisterPack({ addon = "PackAddon" .. p, id = id, format = 1, title = "Pack " .. p, author = "Ann", version = "1", license = "MIT" }))
	for i = 1, (p == 1 and 200 or 3) do
		guide(id .. "/g" .. i, id, { title = string.format("Guide %03d", i), minLevel = 1 + i % 50, maxLevel = 5 + i % 50, pros = pros })
	end
end
stub.login()
UI, P, W = Polestar.UI, Polestar.UI.Picker, Polestar.Widgets
function wheel(sf, delta, times)
	for _ = 1, times or 1 do stub.RunScript(sf, "OnMouseWheel", delta) end
end
-- A frame's right edge, in px from the hub's main column's right edge, by its anchors.
function rightOf(f)
	local main = PolestarPicker.Main
	for i = 1, f:GetNumPoints() do
		local p, rel, rp, x = f:GetPoint(i)
		if p:find("RIGHT") and rp:find("RIGHT") then
			if rel == main then return x end
			local r = rightOf(rel)
			if r then return r + x end
		end
	end
end
-- Every shown guide row: { id, top }.
function rows()
	local out = {}
	for _, f in ipairs(stub.frames) do
		if f.psGuide and rawget(f, "Range") and f:IsShown() and f:GetParent() == PolestarPicker.Body then
			local _, _, _, _, y = f:GetPoint(1)
			out[#out + 1] = { id = f.psGuide.id, top = -y, h = f:GetHeight() }
		end
	end
	table.sort(out, function(a, b) return a.top < b.top end)
	return out
end
"##;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", FILES)], script: [SETUP, script].join("\n"), ..Default::default() }).remove(0)
}

fn n(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

#[test]
fn the_guide_list_s_scroll_bar_stands_beside_the_list_not_under_the_details() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("pack:pk1")
		local win = PolestarPicker
		local sf = win.Scroll
		emit({ list = rightOf(sf), bar = rightOf(sf.Bar), barShown = sf.Bar:IsShown(), details = P.details:GetWidth(),
			detailsRight = rightOf(P.details), guides = #rows() })"#);
	assert_eq!(out["guides"], 200);
	assert_eq!(out["barShown"], true, "200 guides overflow the list: its bar shows");
	assert_eq!(n(&out["detailsRight"]), 0.0, "the details pane runs to the window's right edge");
	let details_left = -n(&out["details"]);
	assert!(n(&out["list"]) <= details_left, "the list's scroll area ends at the details' edge ({} > {details_left})", out["list"]);
	assert!(n(&out["bar"]) <= details_left, "the bar is left of the details, where it can be seen and dragged ({} > {details_left})", out["bar"]);
}

#[test]
fn the_sidebar_keeps_where_the_player_scrolled_to_the_community_guides_through_a_redraw_and_a_guide_picked_in_the_list() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("All")
		local nav = PolestarPicker.NavScroll
		local over = nav.psContent > nav.psView
		wheel(nav, -1, 3)
		local scrolled = nav:GetVerticalScroll()
		Polestar.Fire("TABS_CHANGED", {}, 0)
		local refreshed = nav:GetVerticalScroll()
		Polestar.Fire("GUIDES_REGISTERED")
		local registered = nav:GetVerticalScroll()
		P.Select("forever/cooking")
		local selected = nav:GetVerticalScroll()
		-- Picking the last community addon's entry shows it; going back to All shows All again.
		P.SetCategory("pack:pk9")
		local entry
		for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() and b.psKey == "pack:pk9" then entry = b end end
		local _, _, _, _, y = entry:GetPoint(1)
		local top, at = -y, nav:GetVerticalScroll()
		local packIn = top >= at and top + entry:GetHeight() <= at + nav.psView
		P.SetCategory("All")
		emit({ over = over, scrolled = scrolled, refreshed = refreshed, registered = registered, selected = selected,
			packIn = packIn, back = nav:GetVerticalScroll() })"#);
	assert_eq!(out["over"], true, "twenty community addons run past the sidebar's foot");
	let scrolled = n(&out["scrolled"]);
	assert!(scrolled > 0.0);
	assert_eq!(n(&out["refreshed"]), scrolled, "a tab's progress keeps the sidebar where it is");
	assert_eq!(n(&out["registered"]), scrolled, "a guide registering keeps the sidebar where it is");
	assert_eq!(n(&out["selected"]), scrolled, "a guide picked in the list keeps the sidebar where it is");
	assert_eq!(out["packIn"], true, "a newly picked entry is scrolled into view");
	assert_eq!(n(&out["back"]), 0.0, "and so is All when it is picked again");
}

#[test]
fn the_details_keep_their_place_through_a_redraw_and_read_from_the_top_for_another_guide() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("pack:pk1")
		P.Select("pk1/g7")
		local ds = P.details.Scroll
		local over = ds.psContent > ds.psView
		wheel(ds, -1, 2)
		local scrolled = ds:GetVerticalScroll()
		Polestar.Fire("TABS_CHANGED", {}, 0)
		local refreshed = ds:GetVerticalScroll()
		P.Select("pk1/g7")
		local same = ds:GetVerticalScroll()
		P.Select("pk1/g8")
		emit({ over = over, scrolled = scrolled, refreshed = refreshed, same = same, other = ds:GetVerticalScroll() })"#);
	assert_eq!(out["over"], true, "forty pros overflow the details");
	let scrolled = n(&out["scrolled"]);
	assert!(scrolled > 0.0);
	assert_eq!(n(&out["refreshed"]), scrolled, "a tab's progress keeps the details where they are");
	assert_eq!(n(&out["same"]), scrolled, "picking the same guide again keeps them too");
	assert_eq!(n(&out["other"]), 0.0, "another guide reads from the top");
}

#[test]
fn a_200_guide_community_list_scrolls_a_couple_of_rows_a_notch_to_its_last_row_and_keeps_its_place() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("pack:pk1")
		local win = PolestarPicker
		local sf = win.Scroll
		-- Nothing on the list takes the wheel from it: rows, folders and their parts.
		local takers = {}
		local function walk(f)
			for _, c in ipairs(f.children or {}) do
				if c.mouseWheel then takers[#takers + 1] = c:GetDebugName() end
				walk(c)
			end
		end
		walk(win.Body)
		walk(win.NavScroll.Child)
		-- The wheel scrolls without drawing the list again.
		local renders, render = 0, P.Render
		P.Render = function(...) renders = renders + 1; return render(...) end
		wheel(sf, -1)
		local notch = sf:GetVerticalScroll()
		wheel(sf, -1, 4)
		local scrolled = sf:GetVerticalScroll()
		P.Render = render
		-- A selection, a tab's progress and a guide registering keep the place.
		local list = rows()
		local pick
		for _, r in ipairs(list) do if r.top > scrolled + 40 and not pick then pick = r.id end end
		P.Select(pick)
		local selected = sf:GetVerticalScroll()
		Polestar.Fire("TABS_CHANGED", {}, 0)
		Polestar.Fire("GUIDES_REGISTERED")
		local refreshed = sf:GetVerticalScroll()
		-- The bottom: the range ends at the last row. The scroll area is the body's
		-- column (the window less its 1px edges, the header and the tab row; no
		-- footer) less 4 above and 4 below.
		wheel(sf, -1, 500)
		local SH = W.SHELL
		local view = win:GetHeight() - 2 - SH.header - SH.tabs - 8
		local last = list[#list]
		emit({ takers = table.concat(takers, ", "), renders = renders, notch = notch, scrolled = scrolled, selected = selected, refreshed = refreshed,
			bottom = sf:GetVerticalScroll(), view = view, lastBottom = last.top + last.h, rowH = last.h, count = #list })"#);
	assert_eq!(out["takers"], "", "no frame on the list or the sidebar keeps the wheel from them");
	assert_eq!(out["renders"], 0, "no redraw per notch");
	let row = n(&out["rowH"]);
	let notch = n(&out["notch"]);
	assert!(notch >= row && notch <= 3.0 * row, "a notch moves one to three rows ({notch} px, rows {row} px)");
	let scrolled = n(&out["scrolled"]);
	assert_eq!(scrolled, 5.0 * notch);
	assert_eq!(n(&out["selected"]), scrolled, "a guide picked in the list keeps the list where it is");
	assert_eq!(n(&out["refreshed"]), scrolled, "a redraw keeps the list where it is");
	assert_eq!(out["count"], 200);
	let (bottom, view, last) = (n(&out["bottom"]), n(&out["view"]), n(&out["lastBottom"]));
	assert!(last <= bottom + view, "the last row ({last}) is in view at the bottom ({bottom} + {view})");
	assert!(bottom + view - last < row, "and no more than a row of space under it ({})", bottom + view - last);
}
