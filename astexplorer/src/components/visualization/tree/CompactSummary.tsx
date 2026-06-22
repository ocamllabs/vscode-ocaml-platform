import type { MouseEventHandler, ReactNode } from "react";

import InlineButton from "../../InlineButton";

interface CompactSummaryProps {
  open: string;
  close: string;
  label: ReactNode;
  onClick?: MouseEventHandler | undefined;
  className?: string | undefined;
}

export default function CompactSummary({
  open,
  close,
  label,
  onClick,
  className,
}: CompactSummaryProps) {
  return (
    <span className={className}>
      <span className="text-muted">{open}</span>
      <InlineButton className="text-muted text-[0.9em] italic" onClick={onClick}>
        {label}
      </InlineButton>
      <span className="text-muted">{close}</span>
    </span>
  );
}
