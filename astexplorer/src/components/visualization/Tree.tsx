import { useLayoutEffect, useMemo, useReducer, useRef } from "react";
import { ErrorBoundary } from "react-error-boundary";

import type { ParseResult } from "../../core/ParseResult";
import { TreeAdapter } from "../../core/TreeAdapter";
import type { ConfigurableFilter, FilterValues } from "../../core/TreeAdapter";
import { postMessage } from "../../vscode";
import Button from "../Button";
import Checkbox from "../Checkbox";
import { scrollClosestToCenter } from "./focusNodes";
import ElementContainer from "./tree/Element";
import { TreeProvider } from "./TreeContext";

const TABS = ["Original", "Preprocessed"] as const;

type Settings = FilterValues;

function defaultSettings(): Settings {
  return {
    hideEmptyKeys: false,
    hideLocationData: false,
    hideTypeKeys: true,
  };
}

interface SettingChange {
  name: string;
  checked: boolean;
}

function reducer(state: Settings, change: SettingChange): Settings {
  return { ...state, [change.name]: change.checked };
}

interface TreeProps {
  parseResult: ParseResult;
  position: number | null;
  error: string | null;
  selectedOutput: number;
  onSelect: (index: number) => void;
}

export default function Tree({
  parseResult,
  position,
  error,
  selectedOutput,
  onSelect,
}: TreeProps) {
  const [settings, updateSettings] = useReducer(reducer, undefined, defaultSettings);

  const treeAdapter = useMemo(
    () => new TreeAdapter(parseResult.treeAdapter, settings),
    [parseResult.treeAdapter, settings],
  );
  const focusPath = useMemo(
    () => treeAdapter.computeFocusPath(parseResult.ast, position),
    [treeAdapter, parseResult.ast, position],
  );
  const rootElement = useRef<HTMLUListElement>(null);

  useLayoutEffect(() => {
    const root = rootElement.current;
    if (!root) {
      return;
    }
    scrollClosestToCenter(root, root.querySelectorAll<HTMLElement>("[data-focus-target]"));
  }, [focusPath, selectedOutput, error]);

  const filters = treeAdapter.getConfigurableFilters();

  const onToggle = (event: React.ChangeEvent<HTMLInputElement>) =>
    updateSettings({ name: event.target.name, checked: event.target.checked });

  const isOn = (filter: ConfigurableFilter) => Boolean(settings[filter.key]);

  return (
    <div className="flex min-h-0 flex-1 flex-col">
      <div className="border-separator flex shrink-0 items-center gap-3 overflow-x-auto border-b px-3 py-1.5">
        <div className="flex shrink-0 items-center gap-1">
          {TABS.map((label, index) => (
            <Button
              key={label}
              variant={selectedOutput === index ? "primary" : "secondary"}
              onClick={() => onSelect(index)}
            >
              {label}
            </Button>
          ))}
        </div>

        <div className="bg-separator h-4 w-px shrink-0" aria-hidden="true" />

        <div className="flex shrink-0 items-center gap-3">
          {filters.map((filter) => (
            <Checkbox
              key={filter.key}
              name={filter.key}
              label={filter.label}
              checked={isOn(filter)}
              onChange={onToggle}
            />
          ))}
        </div>

        {selectedOutput === 1 ? (
          <Button
            variant="secondary"
            className="ml-auto"
            onClick={() => postMessage({ refresh_pp_webview: String(selectedOutput) })}
          >
            Reload AST
          </Button>
        ) : null}
      </div>

      {error ? (
        <h4 className="text-destructive">{error}</h4>
      ) : (
        <ErrorBoundary
          resetKeys={[parseResult.ast]}
          onError={(error, info) => console.error("AST explorer render error:", error, info)}
          fallbackRender={({ error }) => <h4 className="text-destructive">{String(error)}</h4>}
        >
          <ul
            ref={rootElement}
            aria-label="Abstract syntax tree"
            className="flex-1 cursor-default overflow-auto px-6 py-3 font-mono text-[0.75rem] select-none"
          >
            <TreeProvider adapter={treeAdapter} position={position} focusPath={focusPath}>
              <ElementContainer value={parseResult.ast} level={0} />
            </TreeProvider>
          </ul>
        </ErrorBoundary>
      )}
    </div>
  );
}
