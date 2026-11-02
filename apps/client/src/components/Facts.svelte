<script lang="ts">
	// A summary as fact rows: what the play adds up to, in players' words.
	import { count, distance, duration } from '../lib/format';
	import { t, tn } from '../lib/i18n.svelte';
	import type { Summary } from '../lib/types';
	import Glyph from './Glyph.svelte';

	let { summary }: { summary: Summary } = $props();

	const facts = $derived([
		{ glyph: 'hourglass', label: t('Play recorded'), value: duration(summary.seconds) },
		{ glyph: 'icon-goto', label: t('Distance travelled'), value: distance(summary.distanceYards) },
		{ glyph: 'icon-accept', label: tn('Quest accepted', 'Quests accepted', summary.questsAccepted), value: count(summary.questsAccepted) },
		{ glyph: 'icon-turnin', label: tn('Quest turned in', 'Quests turned in', summary.questsTurnedIn), value: count(summary.questsTurnedIn) },
		{ glyph: 'icon-kill', label: tn('Creature killed', 'Creatures killed', summary.kills), value: count(summary.kills) },
		{ glyph: 'search', label: tn('Kind of creature seen', 'Kinds of creature seen', summary.uniqueCreatures), value: count(summary.uniqueCreatures) },
		{ glyph: 'icon-collect', label: tn('Thing looted', 'Things looted', summary.lootWindows), value: count(summary.lootWindows) },
		{ glyph: 'icon-vendor', label: tn('Vendor visited', 'Vendors visited', summary.vendors), value: count(summary.vendors) },
		{ glyph: 'icon-level', label: tn('Trainer visited', 'Trainers visited', summary.trainers), value: count(summary.trainers) },
		{ glyph: 'flag', label: tn('Flight master', 'Flight masters', summary.flightmasters), value: count(summary.flightmasters) },
	]);
</script>

<div class="rows">
	{#each facts as fact (fact.glyph)}
		<div class="row">
			<Glyph name={fact.glyph} color="var(--textDim)" />
			<span class="label">{fact.label}</span>
			<span class="value num">{fact.value}</span>
		</div>
	{/each}
</div>
