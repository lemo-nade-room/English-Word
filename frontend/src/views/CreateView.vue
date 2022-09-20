<script lang="ts" setup>
import ShortInput from "@/components/inputs/ShortInput.vue";
import SubmitButton from "@/components/buttons/SubmitButton.vue";
import LongSentenceInput from "@/components/inputs/LongSentenceInput.vue";
import { PropType, ref } from "vue";
import { AxiosInstance } from "axios";
import { useRouter } from "vue-router";

const props = defineProps({
  axios: {
    type: Function as PropType<AxiosInstance>,
    required: true,
  },
});

const router = useRouter();

const title = ref("");
const text = ref("");

const isSending = ref(false);

const send = async () => {
  const params = new URLSearchParams();
  params.append("title", title.value);
  params.append("text", text.value);
  await props.axios.post("/api/book", params);
};

const onCreate = async () => {
  if (isSending.value) return;
  isSending.value = true;

  await send();
  await router.push("/edit");
};
</script>

<template>
  <div class="create">
    <div class="form">
      <ShortInput
        width="240px"
        height="42px"
        placeholder="新規 英単語帳名"
        v-model="title"
      />
      <SubmitButton @click="onCreate" />
    </div>
    <LongSentenceInput class="text" placeholder="英文 任意" v-model="text" />
  </div>
</template>

<style lang="scss" scoped>
.create {
  width: 100%;
  height: 100%;
  padding: {
    top: 82px;
    left: 43px;
    right: 43px;
    bottom: 40px;
  }

  display: flex;
  flex-direction: column;
  justify-content: space-between;

  .text {
    flex-grow: 1;
  }

  .form {
    display: flex;
    justify-content: space-between;
    margin-bottom: 26px;
  }
}
</style>
