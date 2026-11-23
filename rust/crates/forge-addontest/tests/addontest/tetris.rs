//! Tetris by beemerwt (addon/Polestar_Arcade/games/tetris): modern piece queue and persistence of a
//! paused run, including the deliberate repositioning of the active piece.
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::json;

const ENGINE: &str = "games/tetris/Engine.lua";
const WINDOW: &str = "games/tetris/Window.lua";

fn run(script: &str) -> serde_json::Value {
	emitted(&RunAddon { addons: vec![Addon::files("Polestar_Arcade", &[ENGINE])], script: script.into(), ..Default::default() }).remove(0)
}

// The window on its own: Polestar's locale table, and the Arcade it registers with (Maps/Arcade.lua) and the events
// it listens to as stand-ins.
const POLESTAR: &str =
	"Polestar = { L = setmetatable({}, { __index = function(_, key) return key end }), RegisterEvent = function() end, Print = function() end, Arcade = { Register = function() end } }";

fn window(script: &str) -> serde_json::Value {
	emitted(&RunAddon { before: POLESTAR.into(), addons: vec![Addon::files("Polestar_Arcade", &[ENGINE, WINDOW])], script: script.into(), ..Default::default() }).remove(0)
}

#[test]
fn square_and_t_ghosts_have_four_visible_landing_cells() {
	let out = window(
		r#"
  local T = PolestarTetris
  local g = T.New()
  local function seen(kind)
   g.piece = {kind=kind, x=4, y=0, rot=0}
   PolestarTetrisAPI.Open()
   local cells, aboveBoard = {}, true
   for _, region in ipairs(PolestarTetrisFrame.regions) do
    if region.kind == "Texture" and region:IsShown() and region.color and region.color[4] == 0.3 then
     local layer, sub = region:GetDrawLayer()
     if layer ~= "ARTWORK" or sub ~= 1 then aboveBoard = false end
     local _, bg = region:GetPoint(1)
     local _, _, _, px, py = bg:GetPoint(1)
     cells[#cells+1] = {math.floor((px-14)/20)+1, math.floor((-py-50)/20)+1}
    end
   end
   table.sort(cells, function(a,b) return a[2] == b[2] and a[1] < b[1] or a[2] < b[2] end)
   return {cells=cells, aboveBoard=aboveBoard}
  end
  emit({square=seen("O"), tee=seen("T")})
 "#,
	);
	assert_eq!(out["square"], json!({"cells":[[5,19],[6,19],[5,20],[6,20]],"aboveBoard":true}));
	assert_eq!(out["tee"], json!({"cells":[[5,19],[4,20],[5,20],[6,20]],"aboveBoard":true}));
}

#[test]
fn every_shape_projects_four_ghost_cells_above_a_partial_stack() {
	let out = run(r#"
  local T = PolestarTetris
  local g = T.New()
  for x = 1, 7 do g.board[20][x] = "J" end
  local result = {}
  for _, kind in ipairs({"I","O","T","S","Z","J","L"}) do
   g.piece = {kind=kind, x=4, y=0, rot=0}
   local cells = T.GhostCells()
   local clear = #cells == 4
   for _, c in ipairs(cells) do
    if c[2] < 1 or c[2] > 20 or g.board[c[2]][c[1]] then clear = false end
   end
   result[kind] = clear
  end
  emit(result)
 "#);
	assert_eq!(out, json!({"I":true,"O":true,"T":true,"S":true,"Z":true,"J":true,"L":true}));
}

#[test]
fn next_and_hold_show_shapes_inside_the_widened_side_panel() {
	let out = window(
		r#"
  local T = PolestarTetris
  local g = T.New()
  g.queue[1], g.hold = "T", nil
  PolestarTetrisAPI.Open()
  local f = PolestarTetrisFrame
  local function count(preview)
   local n = 0
   for _, cell in ipairs(preview.cells) do if cell:IsShown() then n = n + 1 end end
   return n
  end
  local function positions(preview)
   local seen = {}
   for i, cell in ipairs(preview.cells) do if cell:IsShown() then seen[#seen+1] = i end end
   return seen
  end
  local function colored(preview, kind)
   for _, cell in ipairs(preview.cells) do
    if cell:IsShown() then
     local c, expected = cell.color, T.colors[kind]
     if not c or c[1] ~= expected[1] or c[2] ~= expected[2] or c[3] ~= expected[3] then return false end
    end
   end
   return true
  end
  local function emptySlot(preview)
   local backgrounds = 0
   for _, region in ipairs(preview.regions) do
    if region.kind == "Texture" and region:IsShown() then backgrounds = backgrounds + 1 end
   end
   return backgrounds == 16
  end
  local before = {next=count(f.NextPreview), hold=count(f.HoldPreview)}
  local holdSlotVisible = emptySlot(f.HoldPreview)
  g.hold = "O"
  PolestarTetrisAPI.Open()
  local function widest(text)
   local width = 0
   for line in (text .. "\n"):gmatch("([^\n]*)\n") do width = math.max(width, #line * 6) end
   return width
  end
  local keyboard = widest(f.KeyboardControls:GetText())
  local pad = widest(f.GamepadControls:GetText())
  emit({before=before, holdSlotVisible=holdSlotVisible,
   after={next=count(f.NextPreview), hold=count(f.HoldPreview)},
   nextKind=f.NextPreview.kind, holdKind=f.HoldPreview.kind,
   nextCells=positions(f.NextPreview), holdCells=positions(f.HoldPreview), width=f:GetWidth(),
   nextColored=colored(f.NextPreview, "T"), holdColored=colored(f.HoldPreview, "O"),
   keyboardFits=222+keyboard <= f:GetWidth()-12, padFits=222+pad <= f:GetWidth()-12})
 "#,
	);
	assert_eq!(out["before"], json!({"next":4,"hold":0}));
	assert_eq!(out["after"], json!({"next":4,"hold":4}));
	assert_eq!(out["holdSlotVisible"], true);
	assert_eq!(out["nextColored"], true);
	assert_eq!(out["holdColored"], true);
	assert_eq!(out["nextKind"], "T");
	assert_eq!(out["holdKind"], "O");
	assert_eq!(out["nextCells"], json!([2, 5, 6, 7]));
	assert_eq!(out["holdCells"], json!([2, 3, 6, 7]));
	assert_eq!(out["width"], 420);
	assert_eq!(out["keyboardFits"], true);
	assert_eq!(out["padFits"], true);
}

#[test]
fn restored_account_save_is_used_after_addon_load() {
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar_Arcade", &[ENGINE])],
		saved: vec![(
			"Polestar_Arcade".into(),
			r#"
   Polestar_TetrisDB = {high = 900, run = {board = {}, queue = {"I","T","L","S","Z","J","O"},
    score = 400, lines = 5, level = 1, paused = false,
    piece = {kind = "O", x = 6, y = 12, rot = 0}}}
   for y = 1, 20 do Polestar_TetrisDB.run.board[y] = {} end
   Polestar_TetrisDB.run.board[20][3] = "J"
  "#
			.into(),
		)],
		script: r#"
   local T = PolestarTetris
   local g = T.Run()
   T.Pause()
   emit({high=T.db.high, score=g.score, board=g.board[20][3], kind=g.piece.kind,
    x=g.piece.x, y=g.piece.y, running=not g.paused})
  "#
		.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out, json!({"high":900,"score":400,"board":"J","kind":"O","x":4,"y":0,"running":true}));
}

#[test]
fn seven_bag_and_hold_are_stable() {
	let out = run(r#"
  local T = PolestarTetris
  math.randomseed(42)
  local g = T.New()
  local all = {g.piece.kind}
  for i = 1, 6 do all[#all+1] = g.queue[i] end
  table.sort(all)
  local first = g.piece.kind
  T.Hold()
  local held = g.hold
  local second = g.piece.kind
  T.Hold()
  emit({bag = table.concat(all), held = held, sameHold = held == first,
    second = second, afterSecondHold = g.piece.kind})
 "#);
	assert_eq!(out["bag"], "IJLOSTZ");
	assert_eq!(out["sameHold"], true);
	assert_eq!(out["second"], out["afterSecondHold"]);
}

#[test]
fn flight_close_preserves_run_and_respawns_same_rotated_piece() {
	let out = run(r#"
  local T = PolestarTetris
  local g = T.New()
  g.score, g.lines, g.level, g.hold = 500, 12, 2, "Z"
  g.board[20][1] = "I"
  g.piece = {kind="T", x=5, y=12, rot=1}
  local queue = table.concat(g.queue)
  T.CloseRun()
  local paused = g.paused
  T.Pause()
  emit({paused=paused, resumed=not g.paused, kind=g.piece.kind,
    x=g.piece.x, y=g.piece.y, rot=g.piece.rot, board=g.board[20][1],
    score=g.score, lines=g.lines, level=g.level, hold=g.hold,
    queue=table.concat(g.queue), sameQueue=queue == table.concat(g.queue)})
 "#);
	assert_eq!(
		out,
		json!({"paused":true,"resumed":true,"kind":"T","x":4,"y":0,"rot":1,
  "board":"I","score":500,"lines":12,"level":2,"hold":"Z","sameQueue":true,"queue":out["queue"]})
	);
}

#[test]
fn manual_pause_keeps_position_and_blocked_respawn_ends_game() {
	let out = run(r#"
  local T = PolestarTetris
  local g = T.New()
  g.piece = {kind="O", x=5, y=10, rot=0}
  T.Pause(); T.Pause()
  local manual = g.piece.y
  g.board[1][5] = "J"
  T.CloseRun(); T.Pause()
  emit({manual=manual, over=g.over, paused=g.paused, score=g.score})
 "#);
	assert_eq!(out, json!({"manual":10,"over":true,"paused":true,"score":0}));
}

#[test]
fn hard_drop_clears_consecutive_lines_and_scores_them_once() {
	let out = run(r#"
  local T = PolestarTetris
  local g = T.New()
  for y = 19, 20 do
   for x = 1, 9 do g.board[y][x] = "J" end
  end
  g.piece = {kind="I", x=8, y=16, rot=1}
  T.HardDrop()
  emit({lines=g.lines, score=g.score, high=T.db.high, level=g.level,
   bottom=g.board[20][10], nextPiece=g.piece.kind})
 "#);
	assert_eq!(out["lines"], 2);
	assert_eq!(out["score"], 302);
	assert_eq!(out["high"], 302);
	assert_eq!(out["level"], 1);
	assert_eq!(out["bottom"], "I");
}
