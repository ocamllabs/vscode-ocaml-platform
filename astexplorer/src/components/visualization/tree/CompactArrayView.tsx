import type { MouseEventHandler } from "react";

import CompactSummary from "./CompactSummary";

interface CompactArrayViewProps {
  array: { length: number };
  onClick?: MouseEventHandler;
}

export default function CompactArrayView({ array, onClick }: CompactArrayViewProps) {
  const count = array.length;
  if (count === 0) {
    return <span className="text-muted">{"[ ]"}</span>;
  }
  return (
    <CompactSummary
      open="["
      close="]"
      label={count + " element" + (count > 1 ? "s" : "")}
      onClick={onClick}
    />
  );
}
