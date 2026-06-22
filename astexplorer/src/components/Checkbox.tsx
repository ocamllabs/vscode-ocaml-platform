import type { InputHTMLAttributes, ReactNode } from "react";

import { cn } from "../utils/cn";

interface CheckboxProps extends Omit<InputHTMLAttributes<HTMLInputElement>, "type"> {
  label?: ReactNode;
  className?: string;
}

export default function Checkbox({ label, className, ...props }: CheckboxProps) {
  return (
    <label
      className={cn(
        "inline-flex shrink-0 cursor-pointer items-center gap-2.5 text-[13px] whitespace-nowrap text-foreground select-none",
        className,
      )}
    >
      <span className="border-input-border bg-input has-focus-visible:border-ring relative grid size-4.5 place-items-center rounded-[3px] border">
        <input
          type="checkbox"
          className="peer absolute inset-0 m-0 size-full cursor-pointer appearance-none"
          {...props}
        />
        <svg
          viewBox="0 0 16 16"
          aria-hidden="true"
          className="fill-foreground pointer-events-none size-full opacity-0 peer-checked:opacity-100"
        >
          <path d="M14.431 3.323l-8.47 10-.79-.036-3.35-4.77.818-.574 2.978 4.24 8.051-9.506.764.646z" />
        </svg>
      </span>
      {label}
    </label>
  );
}
