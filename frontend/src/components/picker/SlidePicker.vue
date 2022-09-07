<script lang="ts" setup>
import type { PropType } from "vue";
import { defineEmits, ref } from "vue";

const props = defineProps({
  left: {
    type: String,
    required: true,
  },
  right: {
    type: String,
    required: true,
  },
  modelValue: {
    type: String as PropType<"left" | "right">,
    default: "left",
  },
});

const emit = defineEmits<{
  (event: "update:modelValue", value: "left" | "right"): void; // eslint-disable-line no-unused-vars
}>();

const value = ref(props.modelValue);

const toggle = (select: "left" | "right") => {
  if (value.value === select) return;
  value.value = select;
  emit("update:modelValue", select);
};
</script>

<template>
  <div :class="['picker', value]">
    <span class="option left" @click="toggle('left')">{{ left }}</span>
    <span class="option right" @click="toggle('right')">{{ right }}</span>
    <span class="select" />
  </div>
</template>

<style lang="scss" scoped>
.picker {
  $height: 26px;
  width: 100%;
  height: $height;

  background: #ffffff;
  border: 1px solid #7b7b7b;
  box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
  border-radius: 3px;

  position: relative;
  display: flex;
  justify-content: space-around;
  z-index: 1;

  .option {
    transition: all 0.5s;
    z-index: 3;
    background-color: transparent;
    color: #504d4d;
    font: {
      family: "Inter", sans-serif;
      style: normal;
      weight: 400;
      size: 16px;
    }

    height: 100%;
    width: 50%;
    text-align: center;

    display: inline-block;
    line-height: $height;
  }

  .select {
    transition: all 0.5s;

    position: absolute;
    width: 48%;
    height: 90%;
    top: 5%;

    background: #b7b7b7;
    border: 1px solid #7b7b7b;
    box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
    border-radius: 3px;
    z-index: 2;
  }

  &.left {
    .select {
      left: 1%;
    }
    .left {
      color: white;
    }
  }
  &.right {
    .select {
      left: 51%;
    }
    .right {
      color: white;
    }
  }
}
</style>
