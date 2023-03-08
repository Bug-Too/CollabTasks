<script lang="ts">
	import { register } from 'swiper/element/bundle';
	import Icon from '@iconify/svelte';
	import { swipe } from 'svelte-gestures';
	register();
	let direction: string;
	let count = 0;
	let date = new Date();
	function addDays(date: Date, days: number) {
		var result = new Date(date);
		result.setDate(result.getDate() + days);
		return result;
	}
	function beforeDate(date: Date) {
		return addDays(date, -1);
	}
	function nextDate(date: Date) {
		return addDays(date, 1);
	}
	function getDate(date: Date) {
		return date.getDate();
	}

	function handler(event: CustomEvent) {
		direction = event.detail.direction;
		event.detail.direction === 'left' ? (date = nextDate(date)) : (date = beforeDate(date));
		count++;
	}
	console.log(date.getDate());

	const month = [
		'January',
		'February',
		'March',
		'April',
		'May',
		'June',
		'July',
		'August',
		'September',
		'October',
		'November',
		'December'
	];
	console.log(month[date.getMonth()]);
</script>

<div class="primary-background ">
	<div class="px-4 h-screen pt-8">
		<div class="flex justify-center">
			<div class="py-5 bg-white rounded-full px-10">
				<h1 class="text-3xl font-bold">
					<span class="accent-color">{date.getDate()}</span>
					{month[date.getMonth()]}
					{date.getFullYear()}
				</h1>
			</div>
		</div>

		<div class="max-w-2xl mx-auto py-8">
			<div class="flex justify-between">
				<div class="w-16 h-16 rounded-full bg-white flex justify-center ">
					<Icon icon="mdi:user" color="#FFAFCC" class="w-12 h-12	 justify-self-center self-center" />
				</div>
				<div class="flex items-center">
					<span class="text-xl font-bold pr-2"> Board_Name </span>
					<div class="w-16 h-16 rounded-full bg-white flex justify-center">
						<Icon
							icon="fluent:board-20-filled"
							color="#FFAFCC"
							class="w-12 h-12 justify-self-center self-center"
						/>
					</div>
				</div>
			</div>
		</div>
		<!-- Fix this -->
		<div class="max-w-2xl mx-auto h-4/6 bg-white rounded-2xl px-8 py-8">
			<swiper-container loop="true">
				<swiper-slide>
					<div
						use:swipe={{ timeframe: 1000000000, minSwipeDistance: 30, touchAction: 'pan-y' }}
						on:swipe={handler}
						class="h-40"
					>
						<span style="color:red;">{direction}{count}</span>
						Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur voluptate eveniet exercitationem cumque necessitatibus velit adipisci corrupti earum, soluta sint aut, temporibus dolorem aliquid nisi, optio quisquam officiis enim dolores.
					</div>
				</swiper-slide>
				<swiper-slide>
					<div
						use:swipe={{ timeframe: 1000000000, minSwipeDistance: 30, touchAction: 'pan-y' }}
						on:swipe={handler}
						class="h-40"
					>
					<span style="color:red;">{direction}{count}</span>
					Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur voluptate eveniet exercitationem cumque necessitatibus velit adipisci corrupti earum, soluta sint aut, temporibus dolorem aliquid nisi, optio quisquam officiis enim dolores.
					</div>
				</swiper-slide>
			</swiper-container>
		</div>
	</div>
</div>

<style>
	.accent-color {
		color: #f72585;
	}
</style>
