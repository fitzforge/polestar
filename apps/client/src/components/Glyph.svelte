<script lang="ts" module>
	// The addon's authored glyph family (addon/Polestar/Media/UI, drawn by
	// tools/media/ui.js): white at 32px, used here as masks tinted by `color`.
	const files = import.meta.glob('../assets/ui/*.png', { eager: true, query: '?url', import: 'default' }) as Record<string, string>;
	const urls: Record<string, string> = {};
	for (const [path, url] of Object.entries(files)) urls[path.slice(path.lastIndexOf('/') + 1, -4)] = url;

	// Three glyphs the addon has no use for, drawn in the family's hand (a
	// 24-unit grid, filled silhouettes and round-capped 2.25 strokes).
	const svg = (body: string) =>
		`data:image/svg+xml,${encodeURIComponent(`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2.25" stroke-linecap="round" stroke-linejoin="round">${body}</svg>`)}`;
	urls.pause = svg('<rect x="6.5" y="5" width="3.5" height="14" rx="1" fill="white" stroke="none"/><rect x="14" y="5" width="3.5" height="14" rx="1" fill="white" stroke="none"/>');
	urls.eye = svg('<path d="M2.5 12C5 7.6 8.2 5.5 12 5.5s7 2.1 9.5 6.5c-2.5 4.4-5.7 6.5-9.5 6.5S5 16.4 2.5 12Z"/><circle cx="12" cy="12" r="3" fill="white" stroke="none"/>');
	urls.folder = svg('<path d="M3.5 7.5a2 2 0 0 1 2-2h3.8l2.2 2.5h7a2 2 0 0 1 2 2v7.5a2 2 0 0 1-2 2h-13a2 2 0 0 1-2-2Z"/>');
</script>

<script lang="ts">
	let { name, size = 16, color = 'currentColor' }: { name: string; size?: number; color?: string } = $props();
</script>

<span class="glyph" aria-hidden="true" style:--g="url({urls[name] ?? urls['icon-note']})" style:width="{size}px" style:height="{size}px" style:background-color={color}></span>

<style>
	.glyph {
		display: inline-block;
		flex: none;
		mask: var(--g) center / contain no-repeat;
		-webkit-mask: var(--g) center / contain no-repeat;
	}
</style>
