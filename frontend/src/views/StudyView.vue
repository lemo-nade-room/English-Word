<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import WordQuestion from "@/parts/WordQuestion.vue";
import SwipeBackground from "@/components/background/swipe/SwipeBackground.vue";
import ScoreStatus from "@/parts/ScoreStatus.vue";
import { PropType, ref } from "vue";
import { AxiosError, AxiosInstance } from "axios";
import type { CurrentQuestion } from "@/contents/currentQuestion";
import { useRouter } from "vue-router";

const props = defineProps({
  axios: {
    type: Function as PropType<AxiosInstance>,
    required: true,
  },
});

const router = useRouter();

const isShowAnswer = ref(false);

const title = ref("");
const quiz = ref("");
const answer = ref("");
const ratio = ref("");
const count = ref("");

const fetchQuestion = async () => {
  const response = await props.axios.get<CurrentQuestion>("/api/study");
  const question = response.data;
  title.value = question.title;
  quiz.value = question.question;
  answer.value = question.answer;
  ratio.value = question.ratio;
  count.value = question.count;
};

const reload = async () => {
  try {
    await fetchQuestion();
  } catch (e) {
    const error = e as AxiosError;
    const data = error.response?.data as { error: boolean; reason: string };
    const reason = data.reason;
    console.log(error.response?.status, reason);
    if (error.response?.status !== 400) throw error;
    if (reason !== "もう問題がありません") throw error;
    await router.push("/result");
  }
};

await reload();

const onTouchScreen = () => {
  isShowAnswer.value = !isShowAnswer.value;
};

const isConnecting = ref(false);

const onAnswer = async (isCorrect: boolean) => {
  if (isConnecting.value) return;
  isConnecting.value = true;
  const params = new URLSearchParams();
  console.log("answer", isCorrect);
  params.append("isCorrect", Boolean(isCorrect).toString());
  await props.axios.patch("/api/study", params);
  await reload();
  isShowAnswer.value = false;
  isConnecting.value = false;
};

const onRewind = async () => {
  if (isConnecting.value) return;
  isConnecting.value = true;
  console.log("戻る");
  try {
    await props.axios.delete("/api/study");
  } catch (e) {
    const error = e as AxiosError;
    const data = error.response?.data as { error: boolean; reason: string };
    const reason = data.reason;
    if (error.response?.status !== 400) throw e;
    if (reason !== "戻る問題がない") throw e;
    isConnecting.value = false;
    return;
  }
  await reload();
  isShowAnswer.value = false;
  isConnecting.value = false;
};
</script>

<template>
  <div class="study">
    <SwipeBackground
      @click="onTouchScreen"
      @swipeLeft="onAnswer(true)"
      @swipeDown="onAnswer(false)"
      @swipeRight="onRewind"
    />
    <TitleHeader :text="title" />
    <ScoreStatus class="status" :count="count" :ratio="ratio" />
    <WordQuestion
      class="question"
      :quiz="quiz"
      :answer="answer"
      :is-show-answer="isShowAnswer"
    />
  </div>
</template>

<style lang="scss" scoped>
.study {
  width: 100%;
  height: 100%;

  .status {
    position: absolute;
    top: 104px;
    right: 16px;
  }

  .question {
    position: absolute;
    width: 80%;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
  }
}
</style>
