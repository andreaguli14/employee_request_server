<template>
	<div class="vue-modal" @click.self="$emit('close')" v-show="open">
			<div class="vue-modal-content">
			  <slot />
			</div>
      <div>
			  <button type="button" class="selectbutton" @click="$emit('close')">Select Permissions</button>
			</div>
	  </div>
  </template>
  
  <script>
  export default {
	props: {
	  open: {
		type: Boolean,
		default: true,
	  },
	},
  };
  </script>
  <style>
.vue-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow-x: hidden;
  overflow-y: auto;
  background-color: rgba(0, 0, 0, 0.4);
  z-index: 1;
}
.selectbutton {
background: #0b6dff;
border: 0;
padding: 10px 20px;
color: white;
border-radius: 20px;
margin:0 auto;
display:block;
}

.vue-modal-content {
  width: 50%;
  position: relative;
  margin: 20px auto;
  background-color: #fff;
  border-radius: 15px;
  padding: 1rem;
  overflow-y: auto;
  max-height: 38rem;
}

  </style>