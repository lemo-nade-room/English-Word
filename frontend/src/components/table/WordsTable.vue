<script lang="ts" setup>
import CheckBox from "@/components/checkboxes/CheckBox.vue";
import type { PropType } from "vue";
import type { WordData } from "@/contents/wordData";
import { computed, reactive, ref } from "vue";

const props = defineProps({
  words: {
    type: Array as PropType<WordData[]>,
    required: true,
  },
  height: {
    type: String,
    default: "500px",
  },
});

const isIncludeIgnore = ref(false);

const data = reactive(props.words.map((word) => reactive(word)));

const showWords = computed(() => {
  if (isIncludeIgnore.value) return data;
  return data.filter((word) => !word.ignore);
});

const emit = defineEmits<{
  (event: "changeIgnore", value: { id: string; value: boolean }): void; // eslint-disable-line no-unused-vars
  (event: "selectRecord", value: string): void; // eslint-disable-line no-unused-vars
}>();

const onChangeIgnore = (id: string, value: boolean): void => {
  emit("changeIgnore", { id, value });
};

const onClick = (id: string): void => {
  emit("selectRecord", id);
};
</script>

<template>
  <div>
    <span class="ignore">
      <CheckBox class="checkbox" v-model="isIncludeIgnore" />
      <span class="text">ignoreを含まない</span>
    </span>
    <div class="table-round" :style="{ 'max-height': height }">
      <transition-group name="table" class="table" tag="table">
        <tr class="row" v-for="word in showWords" :key="word.id">
          <td class="cell table-check">
            <CheckBox
              v-model="word.ignore"
              @update:modelValue="(e) => onChangeIgnore(word.id, e)"
            />
          </td>
          <td class="cell jp" @click="onClick(word.id)">{{ word.jp }}</td>
          <td class="cell en" @click="onClick(word.id)">{{ word.en }}</td>
        </tr>
      </transition-group>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.table-move {
  transition: transform 1s;
}
.table-item {
  transition: all 1s;
}
.table-enter-to {
  transition: all 1s;
  opacity: 1;
  transform: translateX(0);
}
.table-enter-from,
.table-leave-to {
  transition: all 1s;
  opacity: 0;
  transform: translateX(100%);
}
.table-leave-active {
  position: absolute;
}
$table-border: 1px solid #585757;
.ignore {
  display: flex;
  align-items: center;
  padding-left: 9px;

  .checkbox {
    margin-right: 11px;
  }
}

.table-round {
  overflow: scroll;
}

.table {
  width: 100%;
  border: $table-border;

  .cell {
    font-size: 16px;
  }

  .table-check {
    border-right: $table-border;
    width: 27px;
    text-align: center;
  }

  .jp,
  .en {
    padding: {
      left: 5px;
      top: 2px;
      bottom: 0;
      right: 0;
    }
  }
}
</style>
