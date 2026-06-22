import type { AstValue, Range } from "./ast";
import { emptyKeysFilter, locationInformationFilter, typeKeysFilter } from "./core/TreeAdapter";
import type { TreeAdapterOptions, WalkEntry } from "./core/TreeAdapter";

export interface Parser {
  locationProps: ReadonlySet<string>;
  typeProps: ReadonlySet<string>;
  nodeToRange(node: AstValue): Range | null | undefined;
  getNodeName(node: AstValue): string | undefined;
  forEachProperty(node: AstValue): Iterable<WalkEntry>;
}

export function getTreeAdapter(parser: Parser): TreeAdapterOptions {
  return {
    nodeToRange: (node) => parser.nodeToRange(node),
    nodeToName: (node) => parser.getNodeName(node),
    walkNode: (node) => parser.forEachProperty(node),
    filters: [
      emptyKeysFilter(),
      locationInformationFilter(parser.locationProps),
      typeKeysFilter(parser.typeProps),
    ],
    locationProps: parser.locationProps,
  };
}
