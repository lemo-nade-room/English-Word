<script lang="ts" setup>
defineProps({
  type: {
    type: String,
    default: "text",
    validator: (value: String) =>
      ["text", "password", "email", "number", "search", "tel", "url"].includes(
        value.toString()
      ),
  },
  alt: {
    type: String,
    default: null,
  },
  autofocus: {
    type: Boolean,
    default: undefined,
  },
  autocomplete: {
    type: Boolean,
    default: false,
  },
  disabled: {
    type: Boolean,
    default: false,
  },
  max: {
    type: Number,
    default: undefined,
  },
  min: {
    type: Number,
    default: undefined,
  },
  maxlength: {
    type: Number,
    default: undefined,
  },
  minlength: {
    type: Number,
    default: undefined,
  },
  multiple: {
    type: Boolean,
    default: false,
  },
  pattern: {
    type: String,
    default: undefined,
  },
  placeholder: {
    type: String,
    default: undefined,
  },
  readonly: {
    type: Boolean,
    default: false,
  },
  required: {
    type: Boolean,
    default: false,
  },
  modelValue: {
    type: String,
    default: "",
  },
  width: {
    type: String,
    default: undefined,
  },
  height: {
    type: String,
    default: undefined,
  },
});

const emit = defineEmits();
</script>

<template>
  <input
    class="input"
    :type="type"
    :alt="alt"
    :autofocus="autofocus"
    :autocomplete="autocomplete"
    :disabled="disabled"
    :max="max"
    :min="min"
    :maxlength="maxlength"
    :minlength="minlength"
    :multiple="multiple"
    :pattern="pattern"
    :placeholder="placeholder"
    :readonly="readonly"
    :required="required"
    @click="(e) => emit('click', e)"
    @change="(e) => emit('change', e)"
    @keyup="(e) => emit('keyup', e)"
    @keydown="(e) => emit('keydown', e)"
    @input="(e) => emit('update:modelValue', e.target.value)"
    :value="modelValue"
    :style="{ width, height }"
  />
</template>

<style lang="scss" scoped>
.input {
  box-sizing: border-box;
  width: 289px;
  height: 46px;
  border: 1px solid #34c2ff;
  box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);

  font-family: "Inter", serif;
  font-style: normal;
  font-weight: 400;
  font-size: 24px;
  line-height: 46px;
  color: black;

  &::placeholder {
    color: #9c9a9a;
  }
}

@media screen and (max-width: 300px) {
  .input {
    width: 250px;
    height: 30px;
  }
}
</style>
