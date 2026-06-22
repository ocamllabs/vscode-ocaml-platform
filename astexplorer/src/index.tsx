import { StrictMode, useEffect, useReducer } from "react";
import { createRoot } from "react-dom/client";

import ASTOutput from "./components/ASTOutput";
import type { ParseResult } from "./core/ParseResult";
import { subscribeToHost } from "./hostBridge";
import { getTreeAdapter } from "./parserMiddleware";
import parser from "./parsers/refmt-ml";
import type { HostMessage } from "./protocol";

import "./index.css";

const treeAdapter = getTreeAdapter(parser);

function emptyResult(): ParseResult {
  return { ast: null, treeAdapter };
}

interface State {
  astResult: ParseResult;
  ppAstResult: ParseResult;
  position: number | null;
  error: string | null;
}

function initialState(): State {
  return {
    astResult: emptyResult(),
    ppAstResult: emptyResult(),
    position: null,
    error: null,
  };
}

function reducer(state: State, message: HostMessage): State {
  switch (message.type) {
    case "ast":
      return {
        ...state,
        astResult: { ...emptyResult(), ast: message.value },
        error: null,
      };
    case "pp_ast":
      return {
        ...state,
        ppAstResult: { ...emptyResult(), ast: message.value },
        error: null,
      };
    case "focus":
      return { ...state, position: message.value };
    case "error":
      return { ...state, error: message.value };
    default:
      return state;
  }
}

function App() {
  const [state, dispatch] = useReducer(reducer, undefined, initialState);

  useEffect(() => subscribeToHost(dispatch), []);

  return (
    <div className="flex h-screen flex-col overflow-hidden">
      <ASTOutput
        parseResult={state.astResult}
        ppParseResult={state.ppAstResult}
        position={state.position}
        error={state.error}
      />
    </div>
  );
}

const container = document.getElementById("index");
if (container) {
  createRoot(container).render(
    <StrictMode>
      <App />
    </StrictMode>,
  );
}
