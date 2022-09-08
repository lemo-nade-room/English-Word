export type SwipeDirection =
  | "swipeUp"
  | "swipeRight"
  | "swipeDown"
  | "swipeLeft"
  | "none";

export class Position {
  private constructor(private readonly x: number, private readonly y: number) {}

  public static readonly decode = (event: TouchEvent): Position => {
    const touch = event.changedTouches[0];
    return new Position(touch.screenX, touch.screenY);
  };

  public static readonly NONE = new Position(-1, -1);

  public readonly swipe = (start: Position): SwipeDirection => {
    if (start === Position.NONE) return "none";
    if (this.isSlanting(start)) return "none";
    if (this.isUp(start)) return "swipeUp";
    if (this.isDown(start)) return "swipeDown";
    if (this.isRight(start)) return "swipeRight";
    if (this.isLeft(start)) return "swipeLeft";
    return "none";
  };
  private static readonly THRESHOLD = 30;

  private isSlanting = (start: Position): boolean => {
    return (
      (this.isUp(start) || this.isDown(start)) &&
      (this.isRight(start) || this.isLeft(start))
    );
  };

  private readonly isUp = (start: Position): boolean => {
    return start.y - this.y > Position.THRESHOLD;
  };

  private readonly isDown = (start: Position): boolean => {
    return this.y - start.y > Position.THRESHOLD;
  };

  private readonly isRight = (start: Position): boolean => {
    return this.x - start.x > Position.THRESHOLD;
  };

  private readonly isLeft = (start: Position): boolean => {
    return start.x - this.x > Position.THRESHOLD;
  };
}
