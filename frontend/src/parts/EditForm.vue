<script lang="ts" setup>
import ShortInput from "@/components/inputs/ShortInput.vue";
import SubmitButton from "@/components/buttons/SubmitButton.vue";
import { WordData } from "@/contents/wordData";
import { PropType } from "vue";
import { ref, watch } from "vue";

const props = defineProps({
  word: {
    type: Object as PropType<WordData>,
    default: { id: "", jp: "", en: "", ignore: false }, // eslint-disable-line vue/require-valid-default-prop
  },
});

const id = ref(props.word.id);
const jp = ref(props.word.jp);
const en = ref(props.word.en);

watch(props, ({ word }) => {
  id.value = word.id;
  jp.value = word.jp;
  en.value = word.en;
});
</script>

<template>
  <div class="form">
    <div class="inputs">
      <ShortInput v-model="en" width="200px" height="29px" placeholder="英語" />
      <ShortInput
        v-model="jp"
        width="200px"
        height="29px"
        placeholder="日本語"
      />
    </div>
    <SubmitButton class="decide-button" />
  </div>
</template>

<style lang="scss" scoped>
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
</style>
