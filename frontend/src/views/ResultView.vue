<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import LinkButton from "@/components/buttons/LinkButton.vue";
import type { ResultRecord } from "@/contents/resultRecord";

const records: ResultRecord[] = [
  { score: "90%", mode: "1周", when: "" },
  { score: "80%", mode: "1周", when: "1時間前" },
  { score: "3.6周", mode: "無限", when: "2日前" },
];
</script>

<template>
  <div class="result">
    <TitleHeader text="Kidult" />
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
