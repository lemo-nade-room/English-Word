<script lang="ts" setup>
import { computed } from "vue";

const props = defineProps({
  text: {
    type: String,
    required: true,
  },
});

const fontSize = computed(() => {
  // ~19: 0, 20~24: 1, 25~29: 2, 30~34: 3, 35~39: 4, ....
  const level = Math.max(0, Math.trunc(props.text.length / 5) - 3);
  const size = 20 - level * 2;
  return { "font-size": `${size}px` };
});
</script>

<template>
  <div class="title">
    <span class="text" :style="fontSize">{{ text }}</span>
  </div>
  <span class="under-line" />
</template>

<style lang="scss" scoped>
.title {
  position: absolute;
  right: 0;
  top: 55px;

  width: 350px;
  height: 34px;

  border-bottom: 1px solid #1198fb;

  padding-left: 60px;

  .text {
    font-family: "Inter", serif;
    font-style: normal;
    font-weight: 400;
    font-size: 20px;
    line-height: 24px;

    color: #504d4d;
  }
}
</style>
