<script lang="ts">
	import { register } from 'swiper/element/bundle';
	import Icon from '@iconify/svelte';
	import { onMount } from 'svelte';

	register();

	onMount(() => {
		const swiperEl = document.querySelector('#swiper1') as any;

		const swiperParams = {
			speed: 400,
			spaceBetween: 100
		};

		if (swiperEl) {
			console.log('init swiper');

			Object.assign(swiperEl, swiperParams);
			swiperEl.initialize();

			swiperEl.addEventListener('slidechange', (event:CustomEvent) => {
			// Returns true when swipe right, false when left.
			let isRightSwipe = event.detail[0].touches.diff < 0;
			if (isRightSwipe) {
				date = nextDate(date);
			} else {
				date = beforeDate(date);
			}
		});
		}
	});

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
		<div class="max-w-2xl mx-auto h-4/6 bg-white rounded-2xl ">

			<swiper-container loop="true" id="swiper1">
				<swiper-slide>
					<div
						class=""
					>
					<div class="px-8 py-8 flex overflow-x-auto">
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
						<div class="px-10 py-10 rounded-full bg-black"></div>
					</div>	
					
						
						<div class="border-line " />
						Lorem ipsum dolor sit amet consectetur adipisicing elit. Minus, illo consequuntur corporis nobis adipisci nisi eius odio, obcaecati consectetur earum cumque modi doloremque vero alias, neque nemo repellat corrupti est?
					</div>
					
				</swiper-slide>
				<swiper-slide>
					<div
						class="h-40 px-8 py-8"
					>
						<span style="color:red;">{direction}{count}</span>
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
	.border-line {
		border: 4px dashed #a2d2ff;
		
	}
</style>
