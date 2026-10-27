<script lang="ts">
	import { app, go } from '../lib/app.svelte';
	import { api, message } from '../lib/backend';
	import { ago, ltr } from '../lib/format';
	import { rise, swap } from '../lib/motion';
	import { toast } from '../lib/toast.svelte';
	import type { Snapshot } from '../lib/types';
	import PageHeader from '../components/PageHeader.svelte';
	import Beacon from '../components/Beacon.svelte';
	import Glyph from '../components/Glyph.svelte';
	import Facts from '../components/Facts.svelte';
	import Characters from '../components/Characters.svelte';

	let { snapshot }: { snapshot: Snapshot } = $props();

	let busy = $state(false);
	let error = $state<string | null>(null);

	const status = $derived(snapshot.status);
	const addon = $derived(snapshot.game.addon);
	const retryIn = $derived(status.nextRetry ? Math.max(0, Math.ceil((status.nextRetry - app.now) / 1000)) : null);
	const facts = $derived(
		[
			status.lastUpload ? `Last sent ${ago(status.lastUpload, app.now)}` : 'Nothing sent yet',
			snapshot.pending > 0 && status.kind !== 'uploading' ? 'New play waiting to send' : null,
			addon?.installed ? `Recorder ${addon.version ?? ''}`.trim() : null,
		].filter(Boolean) as string[],
	);

	const actions: Record<string, { label: string; run: () => Promise<unknown> }> = {
		retry: { label: 'Try again now', run: () => api.retryNow() },
		resume: { label: 'Resume uploads', run: () => api.setPaused(false) },
		install: { label: 'Install the Recorder', run: () => api.addonAction('recorder', 'install').then((t) => toast(t)) },
		locate: {
			label: 'Locate the game',
			run: async () => {
				const check = await api.pickFolder();
				if (check?.problem) throw check.problem;
			},
		},
	};
	const action = $derived(status.action ? actions[status.action] : null);

	async function act() {
		if (!action) return;
		busy = true;
		error = null;
		try {
			await action.run();
		} catch (e) {
			error = message(e);
		} finally {
			busy = false;
		}
	}
</script>

<PageHeader title={status.title}>
	{#snippet lead()}<Beacon kind={status.kind} size={8} />{/snippet}
	{#key status.detail}
		<p class="note detail" in:swap>
			{status.detail}
			{#if retryIn !== null && status.kind === 'offline'}
				<span class="muted">{retryIn > 0 ? `Trying again in ${retryIn} s.` : 'Trying again now.'}</span>
			{/if}
		</p>
	{/key}
</PageHeader>

<div class="body">
	<div class="column">
		<p class="facts small muted">
			{#each facts as fact, i (fact)}{#if i > 0}<span class="sep">·</span>{/if}<span in:swap>{fact}</span>{/each}
		</p>

		{#if action || error}
			<div class="banner" class:warn={status.kind !== 'paused'} in:rise>
				<Glyph name={status.kind === 'paused' ? 'pause' : 'info'} color={status.kind === 'paused' ? 'var(--textDim)' : 'var(--warning)'} />
				<div class="text">
					<p class="note">{status.kind === 'paused' ? 'Nothing is sent while uploads are paused.' : status.kind === 'offline' ? 'Your play is kept on this PC and sent once the server answers.' : 'This needs you before anything can be sent.'}</p>
					{#if error}<p class="note error selectable">{error}</p>{/if}
				</div>
				{#if action}
					<button class="btn" class:primary={status.kind === 'attention'} disabled={busy} onclick={act}>
						{#if busy}<span class="spinner"></span>{/if}{action.label}
					</button>
				{/if}
			</div>
		{/if}

		<section class="section">
			<h2>This week <span class="aside small muted">What reached the server in the last 7 days</span></h2>
			{#if snapshot.week}
				<Facts summary={snapshot.week} />
			{:else}
				<p class="note empty-line">Nothing has reached the server this week yet. Play with the Recorder on; after you log out or type /reload, what you shared adds up here.</p>
			{/if}
		</section>

		{#if snapshot.week && snapshot.week.characters.length > 0}
			<section class="section">
				<h2>Characters <span class="aside small muted">Class, race and level only, never names</span></h2>
				<Characters characters={snapshot.week.characters} />
			</section>
		{/if}

		<section class="section">
			<h2>On this PC</h2>
			<div class="rows one">
				<div class="row">
					<Glyph name="folder" color="var(--textDim)" />
					<span class="label">World of Warcraft: Forever</span>
					<span class="value path dim" title={snapshot.game.dir ?? ''}>{snapshot.game.root ? ltr(snapshot.game.root) : 'Not found'}</span>
				</div>
				<div class="row">
					<Glyph name="record" color="var(--textDim)" />
					<span class="label">Polestar Recorder</span>
					{#if addon?.updateAvailable && addon.latest}<button class="chip accent" onclick={() => go('addons')}>{addon.latest} available</button>{/if}
					<span class="value num">{addon?.installed ? (addon.version ?? 'Installed') : 'Not installed'}</span>
				</div>
				{#each snapshot.game.accounts as account (account.name)}
					<div class="row">
						<Glyph name="lock" color="var(--textDim)" />
						<span class="label">{account.name} <span class="small muted">· this name stays on your PC</span></span>
						{#if account.pending > 0}<span class="small muted">New play waiting</span>{/if}
						{#if account.problem}
							<span class="chip warning" title={account.problem}>Can't read its file</span>
						{:else if account.recording === true}
							<span class="chip success">Recording</span>
						{:else if account.recording === false}
							<span class="chip warning" title="Type /psrec on in the game">Off in the game</span>
						{:else}
							<span class="chip">Nothing recorded yet</span>
						{/if}
					</div>
				{/each}
			</div>
		</section>
	</div>
</div>

<style>
	.detail {
		margin: 6px 0 0;
		max-width: 72ch;
	}
	.facts {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		min-height: 20px;
		margin: 0 0 var(--s2);
	}
	.sep {
		margin: 0 8px;
	}
	.banner {
		display: flex;
		align-items: center;
		gap: var(--s3);
		min-height: 52px;
		padding: var(--s2) var(--s3) var(--s2) var(--s4);
		margin-bottom: var(--s2);
		background: var(--panel);
		border: 1px solid var(--border);
	}
	.banner.warn {
		border-color: rgba(250, 191, 77, 0.3);
	}
	.text {
		flex: 1;
		min-width: 0;
	}
	.text p {
		margin: 0;
	}
	.error {
		color: var(--warning);
		margin-top: 4px !important;
	}
	.empty-line {
		margin: 14px 0 0;
		max-width: 60ch;
	}
	.path {
		max-width: 60%;
		overflow: hidden;
		text-overflow: ellipsis;
		direction: rtl;
		text-align: left;
		font-size: 12px;
	}
	.chip {
		cursor: default;
	}
	button.chip {
		cursor: pointer;
	}
</style>
