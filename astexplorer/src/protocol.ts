import type { AstValue } from "./ast";

export type HostMessage =
  | { type: "ast"; value: AstValue }
  | { type: "pp_ast"; value: AstValue }
  | { type: "focus"; value: number }
  | { type: "error"; value: string };

export type WebviewMessage =
  | { selectedOutput: string }
  | { begin: string; end: string }
  | { begin: string; end: string; r_begin: string; r_end: string }
  | { refresh_pp_webview: string };
