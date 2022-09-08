<script lang="ts" setup>
import type { PropType } from "vue";
import { computed } from "vue";

const props = defineProps({
  text: {
    type: String,
    default: "Link",
  },
  color: {
    type: String as PropType<"red" | "blue">,
    default: "blue",
  },
});

const colors: Record<string, string> = {
  red: "#FF5050",
  blue: "#509ce3",
};

const colorStyle = computed(() => {
  return { color: colors[props.color] };
});

const emit = defineEmits<{
  (event: "click", value: PointerEvent): void; // eslint-disable-line no-unused-vars
}>();
</script>

<template>
  <button
    type="button"
    class="btn"
    :style="colorStyle"
    @click="(e) => emit('click', e)"
  >
    {{ text }}
  </button>
</template>

<style lang="scss" scoped>
.btn {
  border: none;
  background-color: transparent;

  font: {
    family: "Inter", serif;
    style: normal;
    weight: 400;
    size: 16px;
  }

  line-height: 19px;
}
</style>
