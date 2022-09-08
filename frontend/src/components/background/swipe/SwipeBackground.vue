<script lang="ts" setup>
import { Position } from "./position";

const emit = defineEmits<{
  (event: "click", value: PointerEvent): void; // eslint-disable-line no-unused-vars
  (
    event: "swipeUp" | "swipeDown" | "swipeRight" | "swipeLeft", // eslint-disable-line no-unused-vars
    value: TouchEvent // eslint-disable-line no-unused-vars
  ): void;
}>();

let start: Position = Position.NONE;

const onClick = (e: PointerEvent) => {
  emit("click", e);
};

const onTouchStart = (e: TouchEvent): void => {
  start = Position.decode(e);
};

const onTouchEnd = (e: TouchEvent): void => {
  const end = Position.decode(e);
  const swipe = end.swipe(start);
  if (swipe !== "none") {
    emit(swipe, e);
  }
  start = Position.NONE;
};
</script>

<template>
  <div
    class="background"
    @click="onClick"
    @touchstart="onTouchStart"
    @touchend="onTouchEnd"
  ></div>
</template>

<style lang="scss" scoped>
.background {
  display: block;
  width: 100%;
  height: 100%;
  position: absolute;
  left: 0;
  top: 0;
  background-color: transparent;
  border: none;
  outline: none;
}
</style>
