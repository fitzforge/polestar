<script lang="ts">
	// The recording program's opt-in, shown on the Recording pages until the
	// player chooses to share. Nothing is uploaded before "Start sharing".
	import { go } from '../lib/app.svelte';
	import { api, message } from '../lib/backend';
	import { COLLECTED, CONTRACT_URL, NEVER, NEVER_NOTE } from '../lib/copy';
	import PageHeader from './PageHeader.svelte';
	import Glyph from './Glyph.svelte';
	import type { Snapshot } from '../lib/types';

	let { snapshot }: { snapshot: Snapshot } = $props();

	let busy = $state(false);
	let error = $state<string | null>(null);

	const recorder = $derived(snapshot.addons.products.find((p) => p.id === 'recorder'));

	async function start() {
		busy = true;
		error = null;
		try {
			await api.setSharing(true);
		} catch (e) {
			error = message(e);
		} finally {
			busy = false;
		}
	}
</script>

<PageHeader title="Help improve Polestar's guides" subtitle="Optional. Share what the Polestar Recorder notes as you play, and the guides, routes and data get better for everyone." />

<div class="body">
	<div class="column">
		<div class="columns">
			<section>
				<h2>What is shared</h2>
				<ul>
					{#each COLLECTED as item, i (item.text)}
						<li style:--i={i}><Glyph name={item.glyph} size={14} color="var(--textDim)" /><span>{item.text}</span></li>
					{/each}
				</ul>
			</section>
			<section>
				<h2>What never is</h2>
				<ul>
					{#each NEVER as item, i (item)}
						<li style:--i={i + 1}><Glyph name="close" size={12} color="var(--textMuted)" /><span>{item}</span></li>
					{/each}
				</ul>
			</section>
		</div>
		<p class="note fine">{NEVER_NOTE} <button class="link" onclick={() => api.openLink(CONTRACT_URL)}>Read the full list and the code</button></p>
		<div class="act">
			<button class="btn primary start" disabled={busy} onclick={start}>
				{#if busy}<span class="spinner"></span>{/if}Start sharing
			</button>
			<p class="small muted">
				{#if recorder?.installed}
					Uses the Recorder {recorder.installed} you have installed; it starts recording at your next login (or /reload).
				{:else}
					Needs the Polestar Recorder addon:
					<button class="link small-link" onclick={() => go('addons')}>install it from Addons</button>; it starts recording at your next login.
				{/if}
				Stop any time in Settings.
			</p>
		</div>
		{#if error}<p class="note bad selectable">{error}</p>{/if}
	</div>
</div>

<style>
	.columns {
		display: grid;
		grid-template-columns: 1.15fr 1fr;
		gap: var(--s5);
		padding-top: var(--s2);
	}
	@container (max-width: 560px) {
		.columns {
			grid-template-columns: 1fr;
		}
	}
	section {
		min-width: 0;
	}
	h2 {
		display: flex;
		align-items: center;
		height: 36px;
		margin: 0 0 4px;
		font-size: 13px;
		font-weight: 600;
		border-bottom: 1px solid var(--divider);
	}
	ul {
		list-style: none;
		margin: 0;
		padding: 0;
	}
	li {
		display: flex;
		align-items: flex-start;
		gap: 10px;
		padding: 5px 0;
		font-size: 12px;
		line-height: 1.5;
		animation: enter 300ms var(--ease) backwards;
		animation-delay: calc(min(var(--i), 8) * 24ms + 180ms);
	}
	@keyframes enter {
		from {
			opacity: 0;
			transform: translateY(4px);
		}
	}
	li :global(.glyph) {
		margin-top: 2px;
	}
	.fine {
		margin: var(--s4) 0 0;
		padding-top: var(--s3);
		border-top: 1px solid var(--divider);
		max-width: 80ch;
	}
	.act {
		display: flex;
		align-items: center;
		gap: var(--s4);
		margin-top: var(--s4);
		padding: var(--s4);
		background: linear-gradient(90deg, var(--accentWash), transparent 75%), var(--panel);
		border: 1px solid var(--border);
	}
	.start {
		height: 32px;
		padding: 0 20px;
	}
	.act p {
		margin: 0;
		line-height: 1.5;
	}
	.small-link {
		font-size: 11px;
	}
	.bad {
		margin: 10px 0 0;
		color: var(--warning);
	}
	@media (prefers-reduced-motion: reduce) {
		li {
			animation: none;
		}
	}
</style>
