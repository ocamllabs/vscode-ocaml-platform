import type { WebviewMessage } from "./protocol";

const api = typeof acquireVsCodeApi !== "undefined" ? acquireVsCodeApi() : undefined;

export function postMessage(message: WebviewMessage): void {
  api?.postMessage(message);
}
