<script lang="ts" setup>
import ShortInput from "@/components/inputs/ShortInput.vue";
import GoButton from "@/components/buttons/GoButton.vue";
import { computed, PropType, ref } from "vue";
import type { AxiosInstance } from "axios";
import { useRouter } from "vue-router";

const props = defineProps({
  axios: {
    type: Function as PropType<AxiosInstance>,
    required: true,
  },
});

const emit = defineEmits<{
  (event: "token", value: string): void;
}>();

const id = ref("");
const password = ref("");

const isImpossible = computed(() => id.value === "" || password.value === "");
const router = useRouter();

const send = async () => {
  const response = await props.axios.patch("/auth", {
    name: id.value,
    password: password.value,
  });
  emit("token", response.data);
  await router.push("/");
};
</script>

<template>
  <form class="login">
    <ShortInput class="input-id" placeholder="ID" v-model="id" />
    <ShortInput
      class="input-password"
      type="password"
      v-model="password"
      placeholder="パスワード"
    />
    <GoButton class="btn" :disable="isImpossible" @click="send" />
  </form>
</template>

<style lang="scss" scoped>
.login {
  margin-top: 164px;
  width: 100vw;
  height: 203px;

  display: flex;
  flex-direction: column;
  align-items: center;

  .input-password {
    margin-top: 29px;
  }

  .btn {
    margin-top: 44px;
  }
}
</style>
