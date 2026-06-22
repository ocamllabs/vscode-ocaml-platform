import { createContext, use, useRef } from "react";
import type { ReactNode } from "react";

import type { AstValue } from "../../ast";
import type { TreeAdapter } from "../../core/TreeAdapter";

type DeselectCallback = () => void;

export type SelectNode = (node: AstValue | null, onDeselect?: DeselectCallback) => void;

interface TreeContextValue {
  adapter: TreeAdapter;
  position: number | null;
  focusPath: ReadonlySet<AstValue>;
  selectNode: SelectNode;
}

const TreeContext = createContext<TreeContextValue | null>(null);

export function useTree(): TreeContextValue {
  const context = use(TreeContext);
  if (!context) {
    throw new Error("useTree must be used within a TreeProvider");
  }
  return context;
}

interface GlobalWithNode {
  $node?: AstValue;
}

interface TreeProviderProps {
  adapter: TreeAdapter;
  position: number | null;
  focusPath: ReadonlySet<AstValue>;
  children: ReactNode;
}

export function TreeProvider({ adapter, position, focusPath, children }: TreeProviderProps) {
  const unselect = useRef<DeselectCallback | null>(null);

  const selectNode: SelectNode = (node, onDeselect) => {
    if (unselect.current) {
      unselect.current();
    }
    if (node) {
      (globalThis as GlobalWithNode).$node = node;
      unselect.current = onDeselect ?? null;
    } else {
      unselect.current = null;
      delete (globalThis as GlobalWithNode).$node;
    }
  };

  return <TreeContext value={{ adapter, position, focusPath, selectNode }}>{children}</TreeContext>;
}
