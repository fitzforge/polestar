<script lang="ts" module>
	// The window's own title bar. On Linux and Windows the window has no system
	// frame (tauri.linux.conf.json, tauri.windows.conf.json): this 32px strip
	// over the top of the window drags it, and holds the window's controls
	// (minimize, close to the tray) at the right. On macOS the system keeps its traffic
	// lights over the sidebar (tauri.macos.conf.json, an overlay title bar), so
	// only the drag strip is drawn.
	export const MAC = typeof navigator !== 'undefined' && /Mac/.test(navigator.platform || navigator.userAgent);
</script>

<script lang="ts">
	import { onMount } from 'svelte';

	type Win = import('@tauri-apps/api/window').Window;
	const tauri = typeof window !== 'undefined' && '__TAURI_INTERNALS__' in window;

	let win = $state<Win | null>(null);

	onMount(() => {
		// The window is one fixed size (src-tauri/src/window.rs): it never maximizes, so its
		// own hairline edge always shows.
		document.documentElement.classList.toggle('framed', !MAC);
		if (!tauri) return;
		void import('@tauri-apps/api/window').then(({ getCurrentWindow }) => (win = getCurrentWindow()));
	});
</script>

<div class="titlebar" class:mac={MAC} data-tauri-drag-region>
	{#if !MAC}
		<div class="controls">
			<button class="control" aria-label="Minimize" onclick={() => win?.minimize()}>
				<svg viewBox="0 0 10 10" aria-hidden="true"><path d="M1 5.5h8" /></svg>
			</button>
			<button class="control close" aria-label="Close to the tray" title="Close (Polestar Client keeps running in the tray)" onclick={() => win?.close()}>
				<svg viewBox="0 0 10 10" aria-hidden="true"><path d="M1.5 1.5l7 7M8.5 1.5l-7 7" /></svg>
			</button>
		</div>
	{/if}
</div>

<style>
	.titlebar {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		z-index: 50;
		display: flex;
		justify-content: flex-end;
		height: var(--titlebar);
	}
	.mac {
		height: 28px;
	}
	.controls {
		display: flex;
		height: 100%;
	}
	.control {
		display: grid;
		place-items: center;
		width: 44px;
		height: 100%;
		padding: 0;
		border: 0;
		background: transparent;
		color: var(--textDim);
		cursor: pointer;
		transition:
			background-color var(--fast) var(--ease),
			color var(--fast) var(--ease);
	}
	.control svg {
		width: 10px;
		height: 10px;
		fill: none;
		stroke: currentColor;
		stroke-width: 1.1;
		stroke-linecap: round;
		stroke-linejoin: round;
		filter: drop-shadow(1px 1px 0 rgba(0, 0, 5, 0.5));
	}
	.control:hover {
		background: var(--hover);
		color: var(--text);
	}
	.control:active {
		background: var(--press);
	}
	.close:hover {
		background: var(--danger);
		color: var(--onAccent);
	}
	.close:hover svg {
		filter: none;
	}
	.control:focus-visible {
		outline-offset: -2px;
	}
</style>
