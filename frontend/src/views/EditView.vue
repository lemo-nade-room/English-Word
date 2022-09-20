<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import EditForm from "@/parts/EditForm.vue";
import WordsTable from "@/components/table/WordsTable.vue";
import LinkButton from "@/components/buttons/LinkButton.vue";
import { WordData } from "@/contents/wordData";
import { PropType, ref } from "vue";
import { AxiosInstance } from "axios";
import { fetchPersonalBook } from "@/contents/personalBook";

const props = defineProps({
  axios: {
    type: Function as PropType<AxiosInstance>,
    required: true,
  },
});

const title = ref("");
const data = ref<WordData[]>([]);

const reload = async () => {
  const personalBook = await fetchPersonalBook(props.axios);
  title.value = personalBook.title;
  data.value = personalBook.questions;
};

await reload();

const selected = ref<WordData>({
  id: crypto.randomUUID(),
  jp: "",
  en: "",
  ignore: false,
});

const select = (selectedId: string) => {
  const word = data.value.find(({ id }) => id === selectedId);
  if (word === undefined) return;
  selected.value = word;
};

const clearSelect = () => {
  selected.value = { id: crypto.randomUUID(), jp: "", en: "", ignore: false };
};

const onChangeIgnore = async (event: { id: string; value: boolean }) => {
  const params = new URLSearchParams();
  params.append("questionID", event.id);
  params.append("ignore", Boolean(event.value).toString());
  await props.axios.patch("/api/ignore", params);
  await reload();
};
</script>

<template>
  <div class="edit">
    <TitleHeader :text="title" />

    <EditForm :word="selected" />

    <WordsTable
      @selectRecord="select"
      class="words"
      :words="data"
      @changeIgnore="onChangeIgnore"
    />

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
