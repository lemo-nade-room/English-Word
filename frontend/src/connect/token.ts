let token: string | null = null;

export const get = (): string | null => token;

export const set = (value: string): void => {
  token = value;
};
