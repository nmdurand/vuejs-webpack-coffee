<template>
	<div id="app">
		<div class="message">
			{{ message }}
		</div>
	</div>
</template>

<script lang="coffee">
	export default
		data: ->
			message: 'Hello World'
</script>

<style>
	#app {
		display: flex;
		justify-content: center;
		align-items: center;
		.message {
			font-size: 18px;
			font-family: 'Roboto', sans-serif;
			padding: 1em;
			border-radius: .5em;
			background-color: darkslateblue;
			color: rgba(white, .8);
		}
	}
</style>
