<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import SlidePicker from "@/components/picker/SlidePicker.vue";
import WordsTable from "@/components/table/WordsTable.vue";
import type { WordData } from "@/contents/wordData";

const data: WordData[] = [
  { id: crypto.randomUUID(), jp: "ランダム", en: "random", ignore: true },
  { id: crypto.randomUUID(), jp: "生成する", en: "generate", ignore: false },
  { id: crypto.randomUUID(), jp: "現象", en: "phenomenon", ignore: false },
  { id: crypto.randomUUID(), jp: "食べる", en: "eat", ignore: true },
];
</script>
<template>
  <div class="mode">
    <TitleHeader text="2 MINUS 1" />

    <div class="pickers">
      <SlidePicker left="英→日" right="日→英" />
      <SlidePicker left="無限ループ" right="1周のみ" />
      <SlidePicker left="ランダム" right="順番" />
    </div>

    <WordsTable class="data" :words="data" />
  </div>
</template>

<style lang="scss" scoped>
.mode {
  width: 100%;
  height: 100%;
  padding: {
    right: 53px;
    left: 53px;
    bottom: 20px;
  }

  .pickers {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    position: relative;
    top: 141px;
    width: 100%;
    height: 126px;
  }

  .data {
    position: relative;
    top: 166px;
  }
}
</style>
