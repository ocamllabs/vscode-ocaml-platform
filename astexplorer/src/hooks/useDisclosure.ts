import { useState } from "react";

export const OPEN_STATES = {
  DEFAULT: 0,
  OPEN: 1,
  DEEP_OPEN: 2,
  FOCUS_OPEN: 3,
  CLOSED: 4,
} as const;

const EVENTS = {
  GAIN_FOCUS: 0,
  LOOSE_FOCUS: 1,
  DEEP_OPEN: 2,
} as const;

export type OpenState = (typeof OPEN_STATES)[keyof typeof OPEN_STATES];
type Event = (typeof EVENTS)[keyof typeof EVENTS];

function transition(currentState: OpenState, event: Event): OpenState {
  if (event === EVENTS.DEEP_OPEN || currentState === OPEN_STATES.DEEP_OPEN) {
    return OPEN_STATES.DEEP_OPEN;
  }
  if (currentState === OPEN_STATES.OPEN) {
    return currentState;
  }
  return event === EVENTS.GAIN_FOCUS ? OPEN_STATES.FOCUS_OPEN : OPEN_STATES.DEFAULT;
}

interface Stored {
  state: OpenState;
  inRange: boolean;
  openFromParent: boolean;
}

export function useOpenState(
  openFromParent: boolean,
  isInRange: boolean,
): [OpenState, (state: OpenState) => void] {
  const [stored, setStored] = useState<Stored>({
    state: OPEN_STATES.DEFAULT,
    inRange: false,
    openFromParent: false,
  });

  let nextState = stored.state;
  if (isInRange !== stored.inRange) {
    nextState = transition(stored.state, isInRange ? EVENTS.GAIN_FOCUS : EVENTS.LOOSE_FOCUS);
  } else if (openFromParent && !stored.openFromParent) {
    nextState = transition(stored.state, EVENTS.DEEP_OPEN);
  }

  if (
    nextState !== stored.state ||
    isInRange !== stored.inRange ||
    openFromParent !== stored.openFromParent
  ) {
    setStored({ state: nextState, inRange: isInRange, openFromParent });
  }

  const setState = (state: OpenState) => setStored((prev) => ({ ...prev, state }));

  return [nextState, setState];
}
