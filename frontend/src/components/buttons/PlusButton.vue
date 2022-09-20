<script lang="ts" setup>
const emit = defineEmits<{
  (event: "click", value: PointerEvent): void; // eslint-disable-line no-unused-vars
}>();
</script>

<template>
  <button class="btn" @click="(e) => emit('click', e)"></button>
</template>

<style lang="scss" scoped>
.btn {
  $length: 32px;
  $color: #53c1ff;

  display: block;
  position: relative;
  width: $length;
  height: $length;
  border: none;
  background-color: transparent;

  &:before {
    content: "";
    display: block;
    width: $length;
    height: 1px;
    background: $color;

    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
  }

  &:after {
    content: "";
    display: block;
    width: 1px;
    height: $length;
    background: $color;

    position: absolute;
    left: 50%;
    top: 0;
    transform: translateX(-50%);
  }
}
</style>
