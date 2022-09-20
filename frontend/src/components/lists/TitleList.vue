<script lang="ts" setup>
import TitleItem from "./items/TitleItem.vue";
import { PropType } from "vue";
import { EnglishWordTitle } from "@/contents/englishWordTitle";

defineProps({
  titles: {
    type: Array as PropType<EnglishWordTitle[]>,
    required: true,
  },
});

const emit = defineEmits<{
  (event: "click", value: string): void; // eslint-disable-line no-unused-vars
}>();
</script>

<template>
  <div class="list">
    <TitleItem
      @click="(id) => emit('click', id)"
      v-for="title in titles"
      :key="title.id"
      :title="title"
    />
  </div>
</template>

<style lang="scss" scoped>
.list {
  width: 100%;
  height: 100%;
  overflow: scroll;
}
</style>
