// The Client's own update (src-tauri/src/update.rs), from the banner or
// Settings > About: one install at a time. It downloads, checks the
// signature, installs and restarts the app, so only a failure comes back.

import { api, message } from './backend';

export const clientUpdate = $state({ busy: false, error: null as string | null });

export async function installClientUpdate(): Promise<void> {
	if (clientUpdate.busy) return;
	clientUpdate.busy = true;
	clientUpdate.error = null;
	try {
		await api.installUpdate();
	} catch (e) {
		clientUpdate.error = message(e);
	} finally {
		clientUpdate.busy = false;
	}
}
