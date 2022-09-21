<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import SlidePicker from "@/components/picker/SlidePicker.vue";
import WordsTable from "@/components/table/WordsTable.vue";
import LinkButton from "@/components/buttons/LinkButton.vue";
import type { WordData } from "@/contents/wordData";
import { PropType, reactive, ref } from "vue";
import { AxiosInstance } from "axios";
import { fetchPersonalBook } from "@/contents/personalBook";
import { useRouter } from "vue-router";
import { PickerManager } from "@/components/picker/pickerManager";

const props = defineProps({
  axios: {
    type: Function as PropType<AxiosInstance>,
    required: true,
  },
});

const router = useRouter();

const title = ref("");
const data = ref<WordData[]>([]);

const direction = reactive(
  new PickerManager("英→日", "en2jp", "日→英", "jp2en")
);
const mode = reactive(
  new PickerManager("無限ループ", "loop", "1周のみ", "lap")
);
const orderMode = reactive(
  new PickerManager("ランダム", "random", "順番", "order")
);

const reload = async () => {
  const personalBook = await fetchPersonalBook(props.axios);
  title.value = personalBook.title;
  data.value = personalBook.questions;
};

await reload();

const isStarting = ref(false);

const onStart = async () => {
  if (isStarting.value) return;
  isStarting.value = true;
  const params = new URLSearchParams();
  params.append("mode", mode.value);
  params.append("direction", direction.value);
  params.append("orderMode", orderMode.value);
  await props.axios.post("/api/study", params);
  await router.push("/study");
};

const onEdit = async () => {
  await router.push("/edit");
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
  <div class="mode">
    <TitleHeader :text="title" />

    <LinkButton class="start" text="開始" @click="onStart" />

    <div class="pickers">
      <SlidePicker
        :left="direction.leftTitle"
        :right="direction.rightTitle"
        v-model="direction.select"
      />
      <SlidePicker
        :left="mode.leftTitle"
        :right="mode.rightTitle"
        v-model="mode.select"
      />
      <SlidePicker
        :left="orderMode.leftTitle"
        :right="orderMode.rightTitle"
        v-model="orderMode.select"
      />
    </div>

    <LinkButton class="edit" text="編集" @click="onEdit" />

    <WordsTable class="data" :words="data" @changeIgnore="onChangeIgnore" />
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

  .start {
    position: absolute;
    right: 53px;
    top: 105px;
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
  .edit {
    position: absolute;
    top: 292px;
    right: 53px;
    z-index: 2;
  }
  .data {
    position: relative;
    top: 166px;
  }
}
</style>
