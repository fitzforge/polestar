<script lang="ts">
	// First run: find the game, then the Addons page is ready to use.
	// Recording is a separate opt-in, offered in the Recording section.
	import { api, message } from '../lib/backend';
	import { ltr } from '../lib/format';
	import { rise, stagger, swap } from '../lib/motion';
	import type { Candidate, FolderCheck, Snapshot } from '../lib/types';
	import Band from '../components/Band.svelte';
	import Emblem from '../components/Emblem.svelte';
	import Glyph from '../components/Glyph.svelte';

	let { snapshot }: { snapshot: Snapshot } = $props();

	let busy = $state(false);
	let choosing = $state<string | null>(null);
	let picked = $state<FolderCheck | null>(null);
	let error = $state<string | null>(null);

	const game = $derived(snapshot.game);
	/** A folder chosen before (saved) that no longer works; the detected installs are still offered. */
	const saved = $derived(game.problem && !picked?.problem ? game.problem : null);
	const plural = (n: number, one: string, many: string) => `${n} ${n === 1 ? one : many}`;

	function clientName(client: string): string {
		return client === '_forever_' ? 'WoW: Forever' : `WoW: Forever, ${client} folder`;
	}

	function facts(c: Candidate): string {
		return [c.version ? `Game ${c.version}` : null, c.accounts ? plural(c.accounts, 'account', 'accounts') : 'Not logged in yet', c.addonVersion ? `Recorder ${c.addonVersion}` : null].filter(Boolean).join(' · ');
	}

	async function choose(c: Candidate) {
		choosing = c.dir;
		picked = null;
		try {
			picked = await api.chooseFolder(c.dir);
		} catch (e) {
			picked = { path: c.dir, problem: message(e) };
		} finally {
			choosing = null;
		}
	}

	async function locate() {
		busy = true;
		try {
			picked = (await api.pickFolder()) ?? picked;
		} catch (e) {
			picked = { path: '', problem: message(e) };
		} finally {
			busy = false;
		}
	}

	async function finish() {
		busy = true;
		error = null;
		try {
			await api.finishSetup();
		} catch (e) {
			error = message(e);
		} finally {
			busy = false;
		}
	}
</script>

<div class="setup">
	<Band height={176}>
		<div class="hero">
			<div class="polaris"><Emblem size={56} glow target /></div>
			<div class="titles">
				<h1 in:rise={{ y: 10, duration: 420 }}>Find World of Warcraft: Forever</h1>
				<p class="note" in:rise={{ y: 8, delay: 60, duration: 420 }}>Polestar Client installs and updates Polestar's addons in the game folder. It reads nothing outside it.</p>
			</div>
		</div>
	</Band>

	<div class="body">
		<div class="column">
			{#if saved}
				<div class="notice" in:rise>
					<Glyph name="info" color="var(--warning)" />
					<div class="notice-text">
						<p class="notice-title">The folder you chose before no longer works</p>
						<p class="small muted path" title={saved.path}>{ltr(saved.path)}</p>
						<p class="note selectable">{saved.message}</p>
					</div>
				</div>
			{/if}

			{#if !game.scanned}
				<div class="looking" in:rise>
					<span class="spinner" style:color="var(--accent)"></span>
					<p class="note">Looking for the game on this PC…</p>
				</div>
			{:else if game.candidates.length > 0}
				<p class="note intro" in:rise>{saved ? 'Polestar Client found these on this PC instead. Pick the one you play on:' : game.candidates.length === 1 ? 'Found on this PC:' : 'Found on this PC. Pick the one you play on:'}</p>
				<div class="cards" role="radiogroup" aria-label="WoW: Forever installs">
					{#each game.candidates as c, i (c.dir)}
						{@const on = game.dir === c.dir}
						<button class="card" class:on role="radio" aria-checked={on} disabled={choosing !== null} onclick={() => choose(c)} in:rise={{ delay: 60 + stagger(i) }}>
							<span class="radio" aria-hidden="true">
								{#if choosing === c.dir}
									<span class="spinner" style:color="var(--accent)"></span>
								{:else if on}
									<span class="tick"><Glyph name="check" size={14} color="var(--onAccent)" /></span>
								{/if}
							</span>
							<span class="card-text">
								<span class="card-title">{clientName(c.client)}</span>
								<span class="small muted path" title={c.dir}>{ltr(c.root)}</span>
								<span class="small dim">{facts(c)}</span>
							</span>
						</button>
					{/each}
				</div>
				<button class="btn quiet other" onclick={locate} disabled={busy}><Glyph name="folder" size={13} />Use another folder…</button>
			{:else if game.found && game.dir}
				<div class="cards">
					<div class="card on">
						<span class="radio" aria-hidden="true"><span class="tick"><Glyph name="check" size={14} color="var(--onAccent)" /></span></span>
						<span class="card-text">
							<span class="card-title">WoW: Forever</span>
							<span class="small muted path" title={game.dir}>{ltr(game.root ?? '')}</span>
							<span class="small dim">{[game.gameVersion ? `Game ${game.gameVersion}` : null, plural(game.accounts.length, 'account', 'accounts')].filter(Boolean).join(' · ')}</span>
						</span>
					</div>
				</div>
				<button class="btn quiet other" onclick={locate} disabled={busy}><Glyph name="folder" size={13} />Use another folder…</button>
			{:else}
				<div class="locate" in:rise>
					<h2>{saved ? 'And no other install turned up' : "We couldn't find WoW: Forever on this PC"}</h2>
					<p class="note">Show Polestar Client where you installed it: the World of Warcraft folder itself, or the <span class="code">_forever_</span> folder inside it.</p>
					<button class="btn primary" onclick={locate} disabled={busy}><Glyph name="folder" size={13} color="var(--onAccent)" />Locate your World of Warcraft folder</button>
				</div>
			{/if}

			{#if picked?.problem}
				<div class="notice" in:rise>
					<Glyph name="info" color="var(--warning)" />
					<div class="notice-text">
						<p class="notice-title">That folder won't do</p>
						{#if picked.path}<p class="small muted path" title={picked.path}>{ltr(picked.path)}</p>{/if}
						<p class="note selectable">{picked.problem}</p>
					</div>
				</div>
			{/if}

			<p class="note next">Next: your addons, what is installed and what can be updated. Sharing your play to improve the guides is optional, and off until you choose it under Recording.</p>
			{#if error}<p class="note bad selectable">{error}</p>{/if}
		</div>
	</div>

	<footer>
		<button class="btn quiet" onclick={finish} disabled={busy}>Skip for now</button>
		{#if game.found}
			{#key game.found}<button class="btn primary" disabled={busy} onclick={finish} in:swap>Continue</button>{/key}
		{/if}
	</footer>
</div>

<style>
	.setup {
		display: flex;
		flex-direction: column;
		height: 100%;
	}
	.hero {
		position: absolute;
		inset: 0;
		display: flex;
		align-items: flex-end;
		gap: var(--s5);
		padding: 0 var(--edge) var(--s5);
	}
	/* Polaris brightens and dims: a static halo behind it whose opacity breathes
	   (no animated filter, which would repaint every frame). */
	.polaris {
		position: relative;
		flex: none;
		margin-bottom: 4px;
	}
	.polaris::before {
		content: '';
		position: absolute;
		inset: -22px;
		background: radial-gradient(circle, rgba(230, 186, 102, 0.34), rgba(230, 186, 102, 0) 62%);
		opacity: 0.35;
		animation: shine 4.8s var(--easeMove) infinite alternate;
	}
	:global(.intro) .polaris::before {
		animation-play-state: paused;
	}
	@keyframes shine {
		to {
			opacity: 1;
		}
	}
	.titles {
		min-width: 0;
	}
	h1 {
		margin: 0;
		font-size: 26px;
		font-weight: 600;
		line-height: 32px;
		letter-spacing: -0.015em;
	}
	.titles p {
		margin: 6px 0 0;
		max-width: 64ch;
	}
	.body {
		padding-top: var(--s5);
	}
	.column {
		max-width: 720px;
	}
	.intro {
		margin: 0 0 var(--s3);
	}
	.looking {
		display: flex;
		align-items: center;
		gap: var(--s3);
		height: 72px;
	}
	.looking p {
		margin: 0;
	}
	.cards {
		display: flex;
		flex-direction: column;
		gap: var(--s2);
	}
	.card {
		display: flex;
		align-items: center;
		gap: var(--s4);
		min-height: 72px;
		padding: var(--s3) var(--s4);
		background: var(--panelAlt);
		border: 1px solid var(--border);
		text-align: left;
		cursor: pointer;
		transition:
			border-color var(--base) var(--ease),
			background-color var(--base) var(--ease),
			transform var(--fast) var(--ease);
	}
	button.card:hover:not(:disabled) {
		background-image: linear-gradient(var(--hover), var(--hover));
	}
	button.card:active:not(:disabled) {
		transform: translateY(1px);
	}
	.card:disabled {
		cursor: progress;
	}
	.card.on {
		border-color: rgba(230, 186, 102, 0.8);
		background-image: linear-gradient(90deg, var(--accentWash), transparent 70%);
	}
	.radio {
		display: grid;
		place-items: center;
		flex: none;
		width: 20px;
		height: 20px;
		border-radius: 50%;
		border: 1.5px solid var(--textMuted);
		transition: border-color var(--base) var(--ease);
	}
	.on .radio {
		border-color: var(--accent);
	}
	.tick {
		display: grid;
		place-items: center;
		width: 20px;
		height: 20px;
		border-radius: 50%;
		background: var(--accent);
		animation: pop 260ms var(--easePop);
	}
	@keyframes pop {
		from {
			transform: scale(0.5);
			opacity: 0;
		}
	}
	.card-text {
		display: flex;
		flex-direction: column;
		gap: 3px;
		min-width: 0;
	}
	.card-title {
		font-size: 14px;
		font-weight: 600;
	}
	.path {
		display: block;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		direction: rtl;
		text-align: left;
	}
	.other {
		margin-top: var(--s3);
		margin-left: -14px;
	}
	.locate {
		padding-top: var(--s2);
	}
	.locate h2 {
		margin: 0 0 6px;
		font-size: 15px;
		font-weight: 600;
	}
	.locate p {
		margin: 0 0 var(--s4);
		max-width: 62ch;
	}
	.code {
		font-weight: 600;
		color: var(--text);
	}
	.notice {
		display: flex;
		gap: var(--s3);
		margin: 0 0 var(--s4);
		padding: var(--s3) var(--s4);
		background: var(--panel);
		border: 1px solid rgba(250, 191, 77, 0.3);
	}
	.other + .notice,
	.locate + .notice {
		margin: var(--s4) 0 0;
	}
	.notice :global(.glyph) {
		margin-top: 1px;
	}
	.notice-text {
		min-width: 0;
	}
	.notice p {
		margin: 0;
	}
	.notice-title {
		color: var(--warning);
		font-weight: 600;
	}
	.notice .path {
		margin: 2px 0 6px;
	}
	.next {
		margin: var(--s5) 0 0;
		max-width: 66ch;
		color: var(--textMuted);
	}
	.bad {
		color: var(--warning);
	}
	footer {
		flex: none;
		display: flex;
		justify-content: flex-end;
		align-items: center;
		gap: var(--s2);
		height: 56px;
		padding: 0 var(--edge);
		background: var(--footer);
		border-top: 1px solid var(--border);
	}
	@media (prefers-reduced-motion: reduce) {
		.polaris::before {
			animation: none;
		}
	}
</style>
