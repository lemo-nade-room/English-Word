<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import LinkButton from "@/components/buttons/LinkButton.vue";
import type { ResultRecord } from "@/contents/resultRecord";
import { PropType } from "vue";
import { AxiosInstance } from "axios";

const props = defineProps({
  axios: {
    type: Function as PropType<AxiosInstance>,
    required: true,
  },
});

const records = (await props.axios.get<ResultRecord[]>("/api/result")).data;
const title = (await props.axios.get<string>("/api/book/state")).data;
</script>

<template>
  <div class="result">
    <TitleHeader :text="title" />
    <LinkButton class="link" text="もう一度" />
    <ul class="records">
      <li class="record" v-for="record in records" :key="record">
        <span class="score">{{ record.score }}</span>
        <span class="mode">{{ record.mode }}</span>
        <span class="when">{{ record.when }}</span>
      </li>
    </ul>
  </div>
</template>

<style lang="scss" scoped>
.result {
  padding: 0 35px;
  .link {
    position: absolute;
    right: 29px;
    top: 113px;
  }
  .records {
    position: relative;
    top: 156px;
    width: 100%;

    .record {
      display: grid;
      grid-template-columns: 30% 30% 30%;
      width: 100%;

      &:first-of-type {
        font-weight: bold;
      }

      line-height: 60px;
      color: #504d4d;
      font: {
        family: "Inter", sans-serif;
        style: normal;
        weight: 400;
        size: 20px;
      }
    }
  }
}
</style>
