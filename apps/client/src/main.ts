import { mount } from 'svelte';
import './styles/app.css';
import App from './App.svelte';
import { LANGUAGE_KEY, start } from './lib/app.svelte';
import { fault, watchFaults } from './lib/fault';
import { api } from './lib/backend';
import { diagnostics } from './lib/diagnostics.svelte';
import { playIntro, replayIntro } from './lib/intro.svelte';
import { resolve, show, t } from './lib/i18n.svelte';

watchFaults();
// The language last chosen, before the first frame (settings.json, which the first snapshot
// brings, is the truth: app.svelte.ts follows it). `?lang=deDE` in the dev preview.
const lang = (import.meta.env.DEV && new URLSearchParams(location.search).get('lang')) || localStorage.getItem(LANGUAGE_KEY);
void show(resolve(lang)).then(() => {
	try {
		mount(App, { target: document.getElementById('app')! });
	} catch (e) {
		fault(t('Polestar Client could not start'), e);
	}
	start().catch((e) => fault(t('Polestar Client could not reach its background service'), e));
	playIntro().catch((e) => {
		console.error('intro', e);
		document.getElementById('intro')?.remove();
		document.documentElement.classList.remove('intro');
	});
	void api.onOpening(() => void replayIntro().catch((e) => console.error('intro', e)));
	// POLESTAR_FRAME_METER=1 shows the frame-rate overlay from the start (for the intro's numbers).
	void api.diagnostics().then((d) => d.frameMeter && (diagnostics.frames = true), () => {});
});
