import type { HostMessage } from "./protocol";

type Subscriber = (message: HostMessage) => void;

let subscriber: Subscriber | null = null;
const pending: HostMessage[] = [];

window.addEventListener("message", (event: MessageEvent<HostMessage>) => {
  if (subscriber) {
    subscriber(event.data);
  } else {
    pending.push(event.data);
  }
});

export function subscribeToHost(onMessage: Subscriber): () => void {
  subscriber = onMessage;
  for (const message of pending.splice(0)) {
    onMessage(message);
  }
  return () => {
    if (subscriber === onMessage) {
      subscriber = null;
    }
  };
}
