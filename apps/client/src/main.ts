import { mount } from 'svelte';
import './styles/app.css';
import App from './App.svelte';
import { app, start } from './lib/app.svelte';
import { fault, watchFaults } from './lib/fault';
import { api } from './lib/backend';
import { diagnostics } from './lib/diagnostics.svelte';
import { playIntro, replayIntro } from './lib/intro.svelte';
import { watchSight } from './lib/sight.svelte';

watchFaults();
try {
	mount(App, { target: document.getElementById('app')! });
} catch (e) {
	fault('Polestar Client could not start', e);
}
start().catch((e) => fault('Polestar Client could not reach its background service', e));
// Out of sight, every animation holds still (lib/still.ts, #1801).
watchSight(() => (app.now = Date.now())).catch((e) => console.error('sight', e));
playIntro().catch((e) => {
	console.error('intro', e);
	document.getElementById('intro')?.remove();
	document.documentElement.classList.remove('intro');
});
void api.onOpening(() => void replayIntro().catch((e) => console.error('intro', e)));
// POLESTAR_FRAME_METER=1 shows the frame-rate overlay from the start (for the intro's numbers).
void api.diagnostics().then((d) => d.frameMeter && (diagnostics.frames = true), () => {});
