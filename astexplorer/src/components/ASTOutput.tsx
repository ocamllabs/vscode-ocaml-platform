import { useState } from "react";

import type { ParseResult } from "../core/ParseResult";
import { postMessage } from "../vscode";
import Tree from "./visualization/Tree";

interface ASTOutputProps {
  parseResult: ParseResult;
  ppParseResult: ParseResult;
  position: number | null;
  error: string | null;
}

export default function ASTOutput({ parseResult, ppParseResult, position, error }: ASTOutputProps) {
  const [selectedOutput, setSelectedOutput] = useState(0);
  const current = selectedOutput === 0 ? parseResult : ppParseResult;

  const onSelect = (index: number) => {
    setSelectedOutput(index);
    postMessage({ selectedOutput: String(index) });
  };

  return (
    <Tree
      parseResult={current}
      position={position}
      selectedOutput={selectedOutput}
      onSelect={onSelect}
      error={error}
    />
  );
}
