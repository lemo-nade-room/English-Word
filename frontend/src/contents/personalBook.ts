import type { PersonalQuestion } from "@/contents/personalQuestion";
import type { AxiosInstance } from "axios";

export class PersonalBook {
  public constructor(
    public readonly id: string,
    public readonly title: string,
    public readonly questions: PersonalQuestion[]
  ) {}
}

export const fetchPersonalBook = async (
  axios: AxiosInstance
): Promise<PersonalBook> => {
  const response = await axios.get<PersonalBook>("/api/question");
  return response.data;
};
