export class PersonalQuestion {
  public constructor(
    public readonly id: string,
    public readonly en: string,
    public readonly jp: string,
    public readonly ignore: boolean
  ) {}
}
