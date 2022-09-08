<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import EditForm from "@/parts/EditForm.vue";
import WordsTable from "@/components/table/WordsTable.vue";
import LinkButton from "@/components/buttons/LinkButton.vue";
import { WordData } from "@/contents/wordData";
import { ref } from "vue";

const data: WordData[] = [
  { id: crypto.randomUUID(), jp: "ランダム", en: "random", ignore: true },
  { id: crypto.randomUUID(), jp: "生成する", en: "generate", ignore: false },
  { id: crypto.randomUUID(), jp: "現象", en: "phenomenon", ignore: false },
  { id: crypto.randomUUID(), jp: "食べる", en: "eat", ignore: true },
];
const selected = ref<WordData>({
  id: crypto.randomUUID(),
  jp: "",
  en: "",
  ignore: false,
});

const select = (selectedId: string) => {
  const word = data.find(({ id }) => id === selectedId);
  if (word === undefined) return;
  selected.value = word;
};

const clearSelect = () => {
  selected.value = { id: crypto.randomUUID(), jp: "", en: "", ignore: false };
};
</script>

<template>
  <div class="edit">
    <TitleHeader text="Don't wanna cry" />

    <EditForm :word="selected" />

    <WordsTable @selectRecord="select" class="words" :words="data" />

    <span class="links">
      <LinkButton text="新規" @click="clearSelect" />
      <LinkButton text="保存" />
      <LinkButton text="削除" color="red" />
    </span>
  </div>
</template>

<style lang="scss" scoped>
.edit {
  .form {
    position: relative;
    top: 96px;
    width: 100%;
    padding: 0 41px;

    display: flex;
    justify-content: space-between;
    align-items: center;

    .inputs {
      height: 62px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .decide-button {
      width: 90px;
      height: 55px;
      font-size: 24px;
      padding: 0;

      @media (max-width: 410px) {
        width: 70px;
        height: 43px;
      }

      @media (max-width: 390px) {
        width: 60px;
        height: 38px;
        $size: 18px;
        font-size: $size;
        line-height: $size;
      }

      @media (max-width: 390px) {
        width: 50px;
        height: 33px;
        font-size: 12px;
        line-height: 12px;
      }
    }
  }

  .links {
    position: absolute;
    top: 190px;
    right: 26px;
  }

  .words {
    position: relative;
    top: 113px;
    width: 100%;
  }
  padding: 17px;
}
</style>
