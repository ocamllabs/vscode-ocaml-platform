import type { MouseEventHandler } from "react";

import CompactSummary from "./CompactSummary";

interface CompactObjectViewProps {
  keys: string[];
  onClick?: MouseEventHandler;
}

export default function CompactObjectView({ keys, onClick }: CompactObjectViewProps) {
  if (keys.length === 0) {
    return null;
  }
  const shown = keys.length > 5 ? keys.slice(0, 5).concat([`... +${keys.length - 5}`]) : keys;
  return <CompactSummary open="{" close="}" label={shown.join(", ")} onClick={onClick} />;
}
