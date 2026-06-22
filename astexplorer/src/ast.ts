export interface AstObject {
  readonly [key: string]: AstValue;
}

export type AstValue =
  | string
  | number
  | boolean
  | null
  | undefined
  | readonly AstValue[]
  | AstObject;

export type Range = readonly [number, number] | readonly [number, number, number, number];
