import type { AstValue } from "../ast";
import type { TreeAdapterOptions } from "./TreeAdapter";

export interface ParseResult {
  ast: AstValue;
  treeAdapter: TreeAdapterOptions;
}
