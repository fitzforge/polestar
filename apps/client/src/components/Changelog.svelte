<script lang="ts">
	// A release's notes in a drawer over the page: the band, the title, the
	// notes rendered from Markdown (escaped; links open in the browser). It takes
	// focus as it opens, keeps Tab inside, and Escape or the scrim closes it.
	import { onMount } from 'svelte';
	import { app } from '../lib/app.svelte';
	import { api } from '../lib/backend';
	import { ago } from '../lib/format';
	import { renderMarkdown } from '../lib/markdown';
	import { drawer, fade } from '../lib/motion';
	import type { Changelog } from '../lib/types';
	import Band from './Band.svelte';
	import Glyph from './Glyph.svelte';

	let { notes, onclose }: { notes: Changelog; onclose: () => void } = $props();

	const html = $derived(renderMarkdown(notes.body || '_No notes for this release._'));
	const published = $derived(notes.publishedAt ? Date.parse(notes.publishedAt) : null);
	const date = $derived(published ? new Date(published).toLocaleDateString('en-GB', { day: 'numeric', month: 'long', year: 'numeric' }) : null);

	let panel: HTMLElement;
	let close: HTMLButtonElement;
	onMount(() => close.focus());

	function click(e: MouseEvent) {
		const link = (e.target as HTMLElement).closest('a[data-link]');
		if (!link) return;
		e.preventDefault();
		void api.openLink(link.getAttribute('href') ?? '');
	}

	function keys(e: KeyboardEvent) {
		if (e.key === 'Escape') {
			e.preventDefault();
			onclose();
		} else if (e.key === 'Tab') {
			const items = [...panel.querySelectorAll<HTMLElement>('button, a[href], [tabindex]:not([tabindex="-1"])')];
			const first = items[0];
			const last = items[items.length - 1];
			if (e.shiftKey && document.activeElement === first) {
				e.preventDefault();
				last.focus();
			} else if (!e.shiftKey && document.activeElement === last) {
				e.preventDefault();
				first.focus();
			}
		}
	}
</script>

<svelte:window onkeydown={keys} />

<div class="scrim" role="presentation" onclick={onclose} transition:fade={{ duration: 200 }}></div>
<div class="drawer" role="dialog" aria-modal="true" aria-labelledby="notes-title" bind:this={panel} in:drawer out:drawer={{ duration: 200 }}>
	<Band height={108}>
		<div class="head">
			<div>
				<h2 id="notes-title">{notes.name} {notes.version}</h2>
				{#if date && published}<p class="small dim">Released {date} · {ago(published, app.now)}</p>{/if}
			</div>
			<button class="icon-btn" aria-label="Close" bind:this={close} onclick={onclose}><Glyph name="close" size={14} /></button>
		</div>
	</Band>
	<!-- svelte-ignore a11y_click_events_have_key_events, a11y_no_static_element_interactions -->
	<div class="notes selectable" onclick={click}>{@html html}</div>
	<footer>
		<button class="link" onclick={() => api.openLink(notes.pageUrl)}>{notes.pageLabel ?? 'Open the release on GitHub'}</button>
	</footer>
</div>

<style>
	.scrim {
		position: fixed;
		inset: 0;
		z-index: 45;
		background: rgba(5, 8, 15, 0.55);
	}
	.drawer {
		position: fixed;
		top: 0;
		right: 0;
		bottom: 0;
		z-index: 46;
		display: flex;
		flex-direction: column;
		width: min(460px, 92vw);
		background: var(--bg);
		border-left: 1px solid var(--border);
		box-shadow: var(--shadowWindow);
	}
	.head {
		position: relative;
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		gap: var(--s3);
		padding: 46px var(--s5) 0;
	}
	h2 {
		margin: 0;
		font-size: 18px;
		font-weight: 600;
	}
	.head p {
		margin: 6px 0 0;
	}
	.head .icon-btn {
		margin: -4px -8px 0 0;
	}
	.notes {
		flex: 1;
		overflow-y: auto;
		padding: var(--s2) var(--s5) var(--s5);
		font-size: 12.5px;
		font-weight: 400;
		line-height: 1.6;
		color: var(--textDim);
		cursor: auto;
	}
	.notes :global(h2),
	.notes :global(h3),
	.notes :global(h4) {
		margin: 20px 0 6px;
		font-size: 13px;
		font-weight: 600;
		color: var(--text);
	}
	.notes :global(:first-child) {
		margin-top: 0;
	}
	.notes :global(p),
	.notes :global(blockquote) {
		margin: 8px 0;
	}
	.notes :global(blockquote) {
		padding-left: 12px;
		border-left: 1px solid var(--border);
	}
	.notes :global(ul),
	.notes :global(ol) {
		margin: 6px 0;
		padding-left: 18px;
	}
	.notes :global(li) {
		margin: 4px 0;
	}
	.notes :global(li::marker) {
		color: var(--accent);
	}
	.notes :global(strong) {
		color: var(--text);
		font-weight: 600;
	}
	.notes :global(code) {
		padding: 0 4px;
		background: var(--inset);
		font-size: 11.5px;
	}
	.notes :global(pre) {
		padding: 10px 12px;
		background: var(--inset);
		border: 1px solid var(--border);
		overflow-x: auto;
	}
	.notes :global(a) {
		color: var(--accent);
		text-decoration: underline 1px transparent;
		text-underline-offset: 3px;
		transition: color var(--fast) var(--ease), text-decoration-color var(--fast) var(--ease);
	}
	.notes :global(a:hover) {
		color: var(--text);
		text-decoration-color: var(--accent);
	}
	footer {
		display: flex;
		align-items: center;
		height: 56px;
		padding: 0 var(--s5);
		background: var(--footer);
		border-top: 1px solid var(--border);
	}
</style>
