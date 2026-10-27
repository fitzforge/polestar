// The bridge to the Rust backend. In `vite dev` outside Tauri (a plain
// browser), the calls go to ./mock.ts instead; `import.meta.env.DEV` is false
// in production builds, so that branch and the mock module are dropped.

import type { ActivityEntry, AddonAction, Changelog, Channel, FolderCheck, PackAction, Preview, Snapshot } from './types';

interface Bridge {
	invoke<T>(cmd: string, args?: Record<string, unknown>): Promise<T>;
	listen<T>(event: string, handler: (payload: T) => void): Promise<() => void>;
}

let bridge: Promise<Bridge> | null = null;

function load(): Promise<Bridge> {
	if (import.meta.env.DEV && !('__TAURI_INTERNALS__' in window)) {
		return import('./mock').then((m) => m.bridge);
	}
	return Promise.all([import('@tauri-apps/api/core'), import('@tauri-apps/api/event')]).then(([core, event]) => ({
		invoke: core.invoke,
		listen: (name, handler) => event.listen(name, (e) => handler(e.payload as never)),
	}));
}

async function call<T>(cmd: string, args?: Record<string, unknown>): Promise<T> {
	return (await (bridge ??= load())).invoke<T>(cmd, args);
}

export const api = {
	snapshot: () => call<Snapshot>('snapshot'),
	onSnapshot: async (handler: (s: Snapshot) => void) => (await (bridge ??= load())).listen<Snapshot>('snapshot', handler),
	rescan: () => call<void>('rescan'),
	chooseFolder: (path: string) => call<FolderCheck>('choose_folder', { path }),
	pickFolder: () => call<FolderCheck | null>('pick_folder'),
	checkAddons: () => call<void>('check_addons'),
	addonAction: (id: string, action: AddonAction) => call<string>('addon_action', { id, action }),
	updateAll: () => call<string>('update_all'),
	changelog: (id: string) => call<Changelog>('changelog', { id }),
	checkPacks: () => call<void>('check_packs'),
	packAction: (id: string, action: PackAction) => call<string>('pack_action', { id, action }),
	setPackTelemetry: (enabled: boolean) => call<void>('set_pack_telemetry', { enabled }),
	setPacksUrl: (url: string) => call<string>('set_packs_url', { url }),
	packLinkDone: (seq: number) => call<void>('pack_link_done', { seq }),
	setAddonPrefs: (prefs: { channel?: Channel; autoCheck?: boolean; autoInstall?: boolean }) => call<void>('set_addon_prefs', prefs),
	finishSetup: () => call<void>('finish_setup'),
	setSharing: (enabled: boolean) => call<void>('set_sharing', { enabled }),
	setPaused: (paused: boolean) => call<void>('set_paused', { paused }),
	getAutostart: () => call<boolean>('get_autostart'),
	setAutostart: (enabled: boolean) => call<void>('set_autostart', { enabled }),
	setServerUrl: (url: string) => call<string>('set_server_url', { url }),
	deleteServerData: () => call<void>('delete_server_data'),
	activity: () => call<ActivityEntry[]>('activity'),
	preview: () => call<Preview>('preview'),
	retryNow: () => call<void>('retry_now'),
	openDataFolder: () => call<void>('open_data_folder'),
	openLink: (url: string) => call<void>('open_link', { url }),
	checkUpdate: () => call<string | null>('check_update'),
	installUpdate: () => call<void>('install_update'),
	diagnostics: () => call<{ renderer: string; frameMeter: boolean }>('diagnostics'),
	windowReady: () => call<boolean>('window_ready'),
	clientLog: (line: string) => call<void>('client_log', { line }),
	/** The window is coming back from the tray (src-tauri/src/launch.rs). */
	onOpening: async (handler: () => void) => (await (bridge ??= load())).listen<null>('opening', handler),
};

/** Errors from commands arrive as strings. */
export function message(e: unknown): string {
	return typeof e === 'string' ? e : e instanceof Error ? e.message : String(e);
}
