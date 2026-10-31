// The window is never blank: anything that stops the page (an exception while
// mounting or rendering, a promise nobody caught, a backend that never answers)
// replaces it with a plain-DOM page that says so, with the details to report.
// Plain DOM on purpose: it must work when Svelte itself is what failed.

let shown = false;

function text(e: unknown): string {
	if (e instanceof Error) return `${e.name}: ${e.message}${e.stack ? `\n\n${e.stack}` : ''}`;
	if (typeof e === 'string') return e;
	try {
		return JSON.stringify(e, null, 2);
	} catch {
		return String(e);
	}
}

export function fault(title: string, error: unknown): void {
	console.error(title, error);
	if (shown) return;
	shown = true;
	document.getElementById('intro')?.remove();
	document.documentElement.classList.remove('intro');
	const root = document.getElementById('app') ?? document.body;
	root.replaceChildren();
	const page = document.createElement('div');
	page.className = 'fault';
	page.setAttribute('role', 'alert');
	const h = document.createElement('h1');
	h.textContent = title;
	const p = document.createElement('p');
	p.className = 'note';
	p.textContent = 'Polestar Client hit a problem it could not recover from. Restart it from the tray (Quit, then open it again). If it happens again, copy the details below into a report on GitHub or the Polestar Discord.';
	const pre = document.createElement('pre');
	pre.textContent = text(error);
	const actions = document.createElement('div');
	actions.className = 'fault-actions';
	const reload = document.createElement('button');
	reload.className = 'btn primary';
	reload.textContent = 'Reload the window';
	reload.onclick = () => location.reload();
	const copy = document.createElement('button');
	copy.className = 'btn';
	copy.textContent = 'Copy details';
	copy.onclick = () => {
		void navigator.clipboard.writeText(`${title}\n\n${pre.textContent}`).then(() => (copy.textContent = 'Copied'));
	};
	actions.append(reload, copy);
	page.append(h, p, pre, actions);
	root.append(page);
}

export function watchFaults(): void {
	window.addEventListener('error', (e) => fault('Something went wrong', e.error ?? e.message));
	window.addEventListener('unhandledrejection', (e) => fault('Something went wrong', e.reason));
}
