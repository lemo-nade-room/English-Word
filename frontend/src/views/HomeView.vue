<script setup lang="ts">
import PlusButton from "@/components/buttons/PlusButton.vue";
import TitleList from "@/components/lists/TitleList.vue";
import type { PropType } from "vue";
import type { AxiosInstance } from "axios";
import { useRouter } from "vue-router";

const props = defineProps({
  axios: {
    type: Function as PropType<AxiosInstance>,
    required: true,
  },
});
interface EnglishWordTitle {
  id: string;
  title: string;
}

const router = useRouter();

const response = await props.axios.get<EnglishWordTitle[]>("/api/book");
const titles: EnglishWordTitle[] = response.data;
</script>

<template>
  <div class="home">
    <PlusButton class="plus" @click="router.push('/create')" />
    <TitleList class="list" :titles="titles" />
  </div>
</template>

<style lang="scss" scoped>
.home {
  width: 100vw;
  height: 100vh;
  .plus {
    position: absolute;
    right: 21px;
    top: 27px;
  }
  padding: {
    top: 120px;
    left: 35px;
    right: 35px;
    bottom: 100px;
  }
}
</style>
