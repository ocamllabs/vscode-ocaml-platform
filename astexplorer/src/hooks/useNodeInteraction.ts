import type { MouseEventHandler } from "react";

import type { AstValue } from "../ast";
import { useTree } from "../components/visualization/TreeContext";
import { postMessage } from "../vscode";
import { OPEN_STATES, useOpenState } from "./useDisclosure";
import type { OpenState } from "./useDisclosure";

export interface NodeInteraction {
  openState: OpenState;
  isOpen: boolean;
  onToggleClick: MouseEventHandler;
  onMouseOver: MouseEventHandler<HTMLLIElement> | undefined;
  onFocus: (() => void) | undefined;
}

export function useNodeInteraction(
  value: AstValue,
  open: boolean | undefined,
  level: number,
  isInRange: boolean,
  hasChildrenInRange: boolean,
  onToggle: (state: OpenState) => void,
): NodeInteraction {
  const { adapter } = useTree();
  const opensByDefault = level === 0;
  const [openState, setOpenState] = useOpenState(Boolean(open), isInRange || hasChildrenInRange);

  const isOpen =
    openState === OPEN_STATES.DEFAULT ? opensByDefault : openState !== OPEN_STATES.CLOSED;

  const onToggleClick: MouseEventHandler = (event) => {
    const newOpenState = event.shiftKey
      ? OPEN_STATES.DEEP_OPEN
      : isOpen
        ? OPEN_STATES.CLOSED
        : OPEN_STATES.OPEN;
    onToggle(newOpenState);
    setOpenState(newOpenState);
  };

  const range = adapter.getRange(value);
  const canHighlight = Boolean(range) && level !== 0;
  const highlight = () => {
    if (!range) {
      return;
    }
    if (range.length === 2) {
      postMessage({ begin: String(range[0]), end: String(range[1]) });
    } else {
      postMessage({
        begin: String(range[2]),
        end: String(range[3]),
        r_begin: String(range[0]),
        r_end: String(range[1]),
      });
    }
  };
  const onMouseOver: MouseEventHandler<HTMLLIElement> | undefined = canHighlight
    ? (event) => {
        event.stopPropagation();
        highlight();
      }
    : undefined;
  const onFocus = canHighlight ? highlight : undefined;

  return { openState, isOpen, onToggleClick, onMouseOver, onFocus };
}
