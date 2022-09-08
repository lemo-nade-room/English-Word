<script lang="ts" setup>
import { ref } from "vue";

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false,
  },
});

const emit = defineEmits<{
  (event: "update:modelValue", value: boolean): void; // eslint-disable-line no-unused-vars
}>();

const value = ref(props.modelValue);

const toggle = () => {
  emit("update:modelValue", !value.value);
  value.value = !value.value;
};
</script>

<template>
  <span :class="{ check: true, checked: value }" @click="toggle" />
</template>

<style lang="scss" scoped>
.check {
  display: inline-block;
  width: 11px;
  height: 11px;
  background: #d9d9d9;

  position: relative;

  &.checked {
    &:before {
      content: "";

      display: block;
      width: 80%;
      height: 1px;

      border-radius: 1px;

      bottom: 20%;
      left: 54%;
      transform-origin: left;
      transform: rotate(-135deg);
      background-color: green;

      position: absolute;
    }

    &:after {
      content: "";

      display: block;
      width: 120%;
      height: 1px;
      border-radius: 1px;

      bottom: 20%;
      left: 50%;
      transform-origin: left;
      transform: rotate(-45deg);
      background-color: green;

      position: absolute;
    }
  }
}
</style>
