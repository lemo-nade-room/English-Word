<script lang="ts" setup>
defineProps({
  placeholder: {
    type: String,
    default: undefined,
  },
  modelValue: {
    type: String,
    default: "",
  },
});

const emit = defineEmits<{
  (event: "update:modelValue", value: string): void; // eslint-disable-line no-unused-vars
}>();
</script>

<template>
  <textarea
    class="text"
    autocapitalize="none"
    :placeholder="placeholder"
    :value="modelValue"
    @input="(e) => emit('update:modelValue', e.target.value)"
  ></textarea>
</template>

<style lang="scss" scoped>
.text {
  width: 100%;
  border: 1px solid #34c2ff;
  box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
  border-radius: 19px;
  padding: 20px;

  font: {
    family: "Inter", serif;
    style: normal;
    weight: 400;
    size: 14px;
  }
  line-height: 17px;
  color: black;

  &::placeholder {
    color: #9c9a9a;
  }
}
</style>
