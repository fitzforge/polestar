//! Start from here and Skip saying what it did, in the guide window (addon/Polestar/UI/GuideFrame.lua: the away
//! banner's second link, the startedHere and stepSkip banners, the Skip button's tooltip). Real Core + Theme + UI
//! manifests, the fake Engine (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!(
			r#"uistub.install()
stub.login()
local GF, E = Polestar.UI.GuideFrame, Polestar.Engine
local B, N = GF.parts.banner, GF.parts.nav
local function lastCall(name)
	for i = #uistub.calls, 1, -1 do
		if uistub.calls[i][1] == name then return uistub.calls[i] end
	end
end
uistub.setGuide(uistub.elwynn, 2)
uistub.live = 2
{script}"#
		),
		..Default::default()
	})
}

#[test]
fn looking_ahead_the_banner_offers_start_from_here_with_what_it_does_and_its_undo() {
	let out = run(r#"
		uistub.hereOffer = { target = 4, from = 2, steps = { 2, 3 }, inLog = { { id = 7, title = "Kobold Camp Cleanup", timed = true } }, loses = {} }
		N.Next:Click(); N.Next:Click()
		local shown = { B.Text:GetText(), B.Jump.Label:GetText(), B.Later:IsShown() and B.Later.Label:GetText() }
		stub.RunScript(B.Later, "OnEnter")
		local tip = GameTooltip.lines
		B.Later:Click()
		local started = { lastCall("StartHere"), E.GetStepIndex(), E.GetLiveStep(), B:IsShown() and B.Text:GetText(), B.Jump.Label:GetText() }
		B.Jump:Click()
		emit({ shown = shown, tip = tip, started = started, undo = lastCall("UndoStartHere"), at = E.GetStepIndex() })"#)
	.remove(0);
	assert_eq!(out["shown"], json!(["Looking ahead. The guide is at step 2.", "Back to step 2", "Start from here"]));
	let tip = out["tip"].to_string();
	assert!(tip.contains("Make step 4 the guide's step"), "{tip}");
	assert!(tip.contains("Skips the open steps 2\u{2013}3 before it."), "{tip}");
	assert!(tip.contains("Kept along the way: \\\"Kobold Camp Cleanup\\\"") || tip.contains("Kept along the way:"), "{tip}");
	assert!(tip.contains("is timed: While you're here waits until it ends."), "{tip}");
	assert_eq!(out["started"], json!([["StartHere"], 4, 4, "Started from step 4\nSkipped steps 2\u{2013}3", "Undo"]));
	assert_eq!(out["undo"], json!(["UndoStartHere"]));
	assert_eq!(out["at"], 2);
}

#[test]
fn a_step_that_would_lose_its_own_work_offers_the_step_it_comes_from_and_a_refused_one_offers_nothing() {
	let out = run(r#"
		uistub.hereOffer = { target = 4, from = 2, instead = 3, lost = { { quest = 15, title = "Investigate Echo Ridge", from = 3 } }, steps = { 2 }, inLog = {}, loses = {} }
		N.Next:Click(); N.Next:Click()
		local instead = B.Later:IsShown() and B.Later.Label:GetText()
		stub.RunScript(B.Later, "OnEnter")
		local tip = GameTooltip.lines
		uistub.hereOffer = { target = 4, from = 2, refuse = "lost" }
		uistub.update()
		emit({ instead = instead, tip = tip, refused = B.Later:IsShown() })"#)
	.remove(0);
	assert_eq!(out["instead"], "Start from step 3");
	assert!(out["tip"].to_string().contains("Step 4 needs"), "{}", out["tip"]);
	assert_eq!(out["refused"], false);
}

#[test]
fn the_skip_banner_says_what_else_the_guide_passed_grouped_by_reason() {
	let out = run(r#"
		Polestar.Fire("PLAYER_SKIPPED_STEP", uistub.elwynn, 2, {
			{ step = 3, reason = "done" }, { step = 4, reason = "done" }, { step = 5, reason = "leftOut", because = { "Lakeshire" } },
			{ step = 6, reason = "notNow" }, { step = 7, reason = "done" } })
		emit(B.Text:GetText())"#)
	.remove(0);
	assert_eq!(
		out,
		json!(
			"Skipped Step 2  \u{b7}  Marshal McBride\nAlso passed steps 3\u{2013}4, 7: already done\nAlso passed step 5: they need what you skipped (Lakeshire)\nAlso passed step 6: not for you now"
		)
	);
}

#[test]
fn looking_ahead_the_skip_button_says_which_step_it_skips() {
	let out = run(r#"
		stub.RunScript(N.Skip, "OnEnter")
		local live = GameTooltip.lines[1]
		N.Next:Click(); N.Next:Click()
		stub.RunScript(N.Skip, "OnEnter")
		emit({ live, GameTooltip.lines[1] })"#)
	.remove(0);
	assert_eq!(out, json!(["Skip this step", "Skip step 4"]));
}
