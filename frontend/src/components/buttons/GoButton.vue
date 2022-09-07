<script lang="ts" setup>
const props = defineProps({
  disable: {
    type: Boolean,
    default: false,
  },
});

const emit = defineEmits<{ (event: "click", value: PointerEvent): void }>(); // eslint-disable-line no-unused-vars
const clicked = (e: PointerEvent) => {
  if (props.disable) return;
  emit("click", e);
};
</script>

<template>
  <button :class="{ btn: true, disable }" @click="clicked" type="button">
    <span class="text">Go</span>
  </button>
</template>

<style lang="scss" scoped>
.btn {
  $color: #15a5e3;
  background-color: transparent;
  width: 192px;
  border: {
    top: 1px solid $color;
    bottom: 1px solid $color;
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

    -webkit-text-stroke: 1px $color;
  }

  &.disable {
    $color: #b2b1b1;
    border: {
      top: 1px solid $color;
      bottom: 1px solid $color;
      right: none;
      left: none;
    }

    .text {
      color: $color;
      -webkit-text-stroke: 1px $color;
    }
  }
}
</style>
