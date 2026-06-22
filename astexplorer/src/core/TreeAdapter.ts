import type { AstObject, AstValue, Range } from "../ast";

export interface WalkEntry {
  value: AstValue;
  key: string;
}

export interface Filter {
  key?: string;
  label?: string;
  configurable?: boolean;
  test(value: AstValue, key: string, fromArray: boolean): boolean;
}

export interface ConfigurableFilter extends Filter {
  key: string;
  label: string;
}

export type FilterValues = Record<string, boolean>;

export interface TreeAdapterOptions {
  filters: Filter[];
  nodeToRange(node: AstValue): Range | null | undefined;
  nodeToName(node: AstValue): string | undefined;
  walkNode(node: AstValue): Iterable<WalkEntry>;
  locationProps?: ReadonlySet<string>;
}

function isValidPosition(position: number | null): position is number {
  return position !== null && Number.isInteger(position);
}

export class TreeAdapter {
  private readonly options: TreeAdapterOptions;
  private readonly filterValues: FilterValues;

  constructor(options: TreeAdapterOptions, filterValues: FilterValues) {
    this.options = options;
    this.filterValues = filterValues;
  }

  getConfigurableFilters(): ConfigurableFilter[] {
    return (this.options.filters || []).filter(
      (filter): filter is ConfigurableFilter =>
        Boolean(filter.key) && filter.configurable !== false,
    );
  }

  getNodeName(node: AstValue): string | undefined {
    return this.options.nodeToName(node);
  }

  getRange(node: AstValue): Range | null {
    if (node == null) {
      return null;
    }
    return this.options.nodeToRange(node) ?? null;
  }

  isInRange(node: AstValue, key: string, position: number | null): boolean {
    if (this.isLocationProp(key)) {
      return false;
    }
    if (!isValidPosition(position)) {
      return false;
    }
    const range = this.getRange(node);
    if (!range) {
      return false;
    }
    return range[0] <= position && position <= range[1];
  }

  computeFocusPath(root: AstValue, position: number | null): ReadonlySet<AstValue> {
    const onPath = new Set<AstValue>();
    if (!isValidPosition(position) || root == null) {
      return onPath;
    }
    const visit = (node: AstValue, key: string): boolean => {
      if (this.isLocationProp(key)) {
        return false;
      }
      const range = this.getRange(node);
      if (range && !this.isInRange(node, key, position)) {
        return false;
      }
      let any = false;
      for (const { value: child, key: childKey } of this.walkNode(node)) {
        const childInRange = this.isInRange(child, childKey, position);
        const childOnPath =
          this.isArray(child) || this.isObject(child) ? visit(child, childKey) : false;
        if (childInRange || childOnPath) {
          any = true;
        }
      }
      if (any) {
        onPath.add(node);
      }
      return any;
    };
    visit(root, "");
    return onPath;
  }

  isLocationProp(key: string): boolean {
    return Boolean(this.options.locationProps?.has(key));
  }

  isArray(node: AstValue): node is readonly AstValue[] {
    return Array.isArray(node);
  }

  isObject(node: AstValue): node is AstObject {
    return Boolean(node) && typeof node === "object" && !this.isArray(node);
  }

  *walkNode(node: AstValue): Generator<WalkEntry> {
    if (node == null) {
      return;
    }
    const fromArray = Array.isArray(node);
    for (const result of this.options.walkNode(node)) {
      const filtered = (this.options.filters || []).some((filter) => {
        if (filter.key && !this.filterValues[filter.key]) {
          return false;
        }
        return filter.test(result.value, result.key, fromArray);
      });
      if (filtered) {
        continue;
      }
      yield result;
    }
  }
}

export function ignoreKeysFilter(
  keys: ReadonlySet<string> = new Set(),
  key?: string,
  label?: string,
): Filter {
  const filter: Filter = {
    test(_value, k) {
      return keys.has(k);
    },
  };
  if (key !== undefined) {
    filter.key = key;
  }
  if (label !== undefined) {
    filter.label = label;
  }
  return filter;
}

export function locationInformationFilter(keys: ReadonlySet<string>): Filter {
  return ignoreKeysFilter(keys, "hideLocationData", "Hide location data");
}

export function emptyKeysFilter(): Filter {
  return {
    key: "hideEmptyKeys",
    label: "Hide empty keys",
    test(value, _key, fromArray) {
      return (
        (value == null || JSON.stringify(value) === JSON.stringify({ "[]": [] })) && !fromArray
      );
    },
  };
}

export function typeKeysFilter(keys: ReadonlySet<string>): Filter {
  return { ...ignoreKeysFilter(keys, "hideTypeKeys", "Hide type keys"), configurable: false };
}
