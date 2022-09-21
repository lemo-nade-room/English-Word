export class PickerManager {
  public select: "left" | "right" = "left";

  public constructor(
    public readonly leftTitle: string,
    private readonly leftValue: string,
    public readonly rightTitle: string,
    private readonly rightValue: string
  ) {}

  public get value(): string {
    if (this.select === "left") return this.leftValue;
    if (this.select === "right") return this.rightValue;
    throw Error("leftとright以外の値がselectに存在する: " + this.select);
  }
}
