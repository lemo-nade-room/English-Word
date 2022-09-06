<script lang="ts" setup>
import { defineEmits } from "vue";

const emit = defineEmits();
</script>

<template>
  <button class="btn" @click="(e) => emit('click', e)">
    <span class="text">Go</span>
  </button>
</template>

<style lang="scss" scoped>
.btn {
  background-color: transparent;
  width: 192px;
  border: {
    top: 1px solid #15a5e3;
    bottom: 1px solid #15a5e3;
    right: none;
    left: none;
  }

  .text {
    width: 69px;
    height: 39px;

    font-family: "Inter", sans-serif;
    font-style: normal;
    font-weight: 600;
    font-size: 32px;
    line-height: 39px;

    text-align: center;

    color: #ffffff;

    -webkit-text-stroke: 1px #15a5e3;
  }
}
</style>
