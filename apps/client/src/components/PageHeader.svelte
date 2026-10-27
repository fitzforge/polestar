<script lang="ts">
	// A page's head over the shell's starlit band: the title in Hero on the
	// 32 edge at y 32, its subtitle in Note 8px under it (two lines at most),
	// an optional glyph in the gutter left of the title and actions at the right.
	import type { Snippet } from 'svelte';

	let { title, subtitle, lead, aside, children }: { title: string; subtitle?: string; lead?: Snippet; aside?: Snippet; children?: Snippet } = $props();
</script>

<div class="head">
	{#if lead}<div class="lead">{@render lead()}</div>{/if}
	<div class="titles">
		<h1>{title}</h1>
		{#if subtitle}<p class="note">{subtitle}</p>{/if}
		{@render children?.()}
	</div>
	{#if aside}<div class="aside">{@render aside()}</div>{/if}
</div>

<style>
	.head {
		position: relative;
		flex: none;
		display: flex;
		align-items: flex-start;
		gap: var(--s4);
		height: var(--band);
		padding: var(--s6) var(--edge) 0;
		/* The head's actions end where the page's content does. */
		max-width: calc(var(--measure) + 2 * var(--edge));
	}
	.lead {
		position: absolute;
		left: 6px;
		top: 38px;
		display: grid;
		place-items: center;
		width: 20px;
		height: 20px;
	}
	.titles {
		flex: 1;
		min-width: 0;
	}
	h1 {
		margin: 0;
		font-size: 26px;
		font-weight: 600;
		line-height: 32px;
		letter-spacing: -0.015em;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	p {
		margin: 6px 0 0;
		max-width: 72ch;
		max-height: 38px;
		overflow: hidden;
		display: -webkit-box;
		-webkit-line-clamp: 2;
		line-clamp: 2;
		-webkit-box-orient: vertical;
	}
	.aside {
		flex: none;
		display: flex;
		align-items: center;
		gap: var(--s2);
		height: 32px;
	}
</style>
