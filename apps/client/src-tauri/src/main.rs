// No console window on Windows in release builds.
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

fn main() {
	polestar_client_lib::render::choose();
	polestar_client_lib::run()
}
